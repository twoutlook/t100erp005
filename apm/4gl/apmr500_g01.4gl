#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr500_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:28(2017-01-25 09:52:31), PR版次:0028(2017-02-06 12:02:42)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000206
#+ Filename...: apmr500_g01
#+ Description: ...
#+ Creator....: 02716(2014-04-21 10:04:16)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="apmr500_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160909-00037#1  2016/09/10  By 06948   將聯絡對象全名(oofa011)改顯示交易對象全名(pmaj012)
#160914-00017#1  2016/09/26  By Sarah   apmr500_g01_get_oofc012()中OTHERWISE段SQL的WHERE條件有誤,應改為oofc008=p_flag,oofc010='Y'
#160922-00028#1  2016/10/13  By shiun   多帳期子報表在期別與付款條件中間增加顯示帳款類型
#161207-00033#25 2016/12/26  By lixh    一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#161031-00025#2  2017/01/13  By zhujing 单头、单身备注抓取sql调整，更换群组
#170120-00006#1  2017/01/24  By 08992   SQL資料重覆抓取
#161031-00024#6  2017/01/25  By 06137   2.報表畫面增加"列印額外品名規格"選項
#                                       2-1.打勾時，依料件編號+單別參數"額外品名規格類型"，串到aimm221抓取資料
#                                       2-2.有抓到值時，原品名規格資料不印，改印額外品名規格資料，額外品名規格資料依行序+換行符號組成一個大字串放至品名中
#                                       2-3.沒抓到值，印原品名規格
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   t1_pmaal003 LIKE pmaal_t.pmaal003, 
   t2_pmaal003 LIKE pmaal_t.pmaal003, 
   t5_pmaal003 LIKE pmaal_t.pmaal003, 
   t5_pmaal006 LIKE pmaal_t.pmaal006, 
   pmaal_t_pmaal005 LIKE pmaal_t.pmaal005, 
   t2_pmaal006 LIKE pmaal_t.pmaal006, 
   t1_pmaal006 LIKE pmaal_t.pmaal006, 
   pmdl001 LIKE pmdl_t.pmdl001, 
   pmdl002 LIKE pmdl_t.pmdl002, 
   pmdl003 LIKE pmdl_t.pmdl003, 
   pmdl004 LIKE pmdl_t.pmdl004, 
   pmdl005 LIKE pmdl_t.pmdl005, 
   pmdl006 LIKE pmdl_t.pmdl006, 
   pmdl007 LIKE pmdl_t.pmdl007, 
   pmdl008 LIKE pmdl_t.pmdl008, 
   pmdl009 LIKE pmdl_t.pmdl009, 
   pmdl010 LIKE pmdl_t.pmdl010, 
   pmdl011 LIKE pmdl_t.pmdl011, 
   pmdl012 LIKE pmdl_t.pmdl012, 
   pmdl013 LIKE pmdl_t.pmdl013, 
   pmdl015 LIKE pmdl_t.pmdl015, 
   pmdl016 LIKE pmdl_t.pmdl016, 
   pmdl017 LIKE pmdl_t.pmdl017, 
   pmdl018 LIKE pmdl_t.pmdl018, 
   pmdl019 LIKE pmdl_t.pmdl019, 
   pmdl020 LIKE pmdl_t.pmdl020, 
   pmdl021 LIKE pmdl_t.pmdl021, 
   pmdl022 LIKE pmdl_t.pmdl022, 
   pmdl023 LIKE pmdl_t.pmdl023, 
   pmdl024 LIKE pmdl_t.pmdl024, 
   pmdl025 LIKE pmdl_t.pmdl025, 
   pmdl026 LIKE pmdl_t.pmdl026, 
   pmdl027 LIKE pmdl_t.pmdl027, 
   pmdl028 LIKE pmdl_t.pmdl028, 
   pmdl029 LIKE pmdl_t.pmdl029, 
   pmdl030 LIKE pmdl_t.pmdl030, 
   pmdl031 LIKE pmdl_t.pmdl031, 
   pmdl032 LIKE pmdl_t.pmdl032, 
   pmdl033 LIKE pmdl_t.pmdl033, 
   pmdl040 LIKE pmdl_t.pmdl040, 
   pmdl041 LIKE pmdl_t.pmdl041, 
   pmdl042 LIKE pmdl_t.pmdl042, 
   pmdl043 LIKE pmdl_t.pmdl043, 
   pmdl044 LIKE pmdl_t.pmdl044, 
   pmdl046 LIKE pmdl_t.pmdl046, 
   pmdl047 LIKE pmdl_t.pmdl047, 
   pmdl048 LIKE pmdl_t.pmdl048, 
   pmdl049 LIKE pmdl_t.pmdl049, 
   pmdldocdt LIKE pmdl_t.pmdldocdt, 
   pmdldocno LIKE pmdl_t.pmdldocno, 
   pmdlent LIKE pmdl_t.pmdlent, 
   pmdlsite LIKE pmdl_t.pmdlsite, 
   pmdlstus LIKE pmdl_t.pmdlstus, 
   pmdn001 LIKE pmdn_t.pmdn001, 
   pmdn002 LIKE pmdn_t.pmdn002, 
   pmdn003 LIKE pmdn_t.pmdn003, 
   pmdn004 LIKE pmdn_t.pmdn004, 
   pmdn005 LIKE pmdn_t.pmdn005, 
   pmdn006 LIKE pmdn_t.pmdn006, 
   pmdn007 LIKE pmdn_t.pmdn007, 
   pmdn008 LIKE pmdn_t.pmdn008, 
   pmdn009 LIKE pmdn_t.pmdn009, 
   pmdn010 LIKE pmdn_t.pmdn010, 
   pmdn011 LIKE pmdn_t.pmdn011, 
   pmdn012 LIKE pmdn_t.pmdn012, 
   pmdn013 LIKE pmdn_t.pmdn013, 
   pmdn014 LIKE pmdn_t.pmdn014, 
   pmdn015 LIKE pmdn_t.pmdn015, 
   pmdn016 LIKE pmdn_t.pmdn016, 
   pmdn017 LIKE pmdn_t.pmdn017, 
   pmdn019 LIKE pmdn_t.pmdn019, 
   pmdn020 LIKE pmdn_t.pmdn020, 
   pmdn021 LIKE pmdn_t.pmdn021, 
   pmdn022 LIKE pmdn_t.pmdn022, 
   pmdn023 LIKE pmdn_t.pmdn023, 
   pmdn024 LIKE pmdn_t.pmdn024, 
   pmdn025 LIKE pmdn_t.pmdn025, 
   pmdn026 LIKE pmdn_t.pmdn026, 
   pmdn027 LIKE pmdn_t.pmdn027, 
   pmdn028 LIKE pmdn_t.pmdn028, 
   pmdn029 LIKE pmdn_t.pmdn029, 
   pmdn030 LIKE pmdn_t.pmdn030, 
   pmdn031 LIKE pmdn_t.pmdn031, 
   pmdn032 LIKE pmdn_t.pmdn032, 
   pmdn033 LIKE pmdn_t.pmdn033, 
   pmdn034 LIKE pmdn_t.pmdn034, 
   pmdn035 LIKE pmdn_t.pmdn035, 
   pmdn036 LIKE pmdn_t.pmdn036, 
   pmdn037 LIKE pmdn_t.pmdn037, 
   pmdn038 LIKE pmdn_t.pmdn038, 
   pmdn039 LIKE pmdn_t.pmdn039, 
   pmdn040 LIKE pmdn_t.pmdn040, 
   pmdn041 LIKE pmdn_t.pmdn041, 
   pmdn042 LIKE pmdn_t.pmdn042, 
   pmdn043 LIKE pmdn_t.pmdn043, 
   pmdn044 LIKE pmdn_t.pmdn044, 
   pmdn045 LIKE pmdn_t.pmdn045, 
   pmdn046 LIKE pmdn_t.pmdn046, 
   pmdn047 LIKE pmdn_t.pmdn047, 
   pmdn048 LIKE pmdn_t.pmdn048, 
   pmdn049 LIKE pmdn_t.pmdn049, 
   pmdn050 LIKE pmdn_t.pmdn050, 
   pmdn051 LIKE pmdn_t.pmdn051, 
   pmdnorga LIKE pmdn_t.pmdnorga, 
   pmdnseq LIKE pmdn_t.pmdnseq, 
   pmdnsite LIKE pmdn_t.pmdnsite, 
   pmdnunit LIKE pmdn_t.pmdnunit, 
   t7_ooag011 LIKE ooag_t.ooag011, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t8_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t10_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t11_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_pmaal004 LIKE pmaal_t.pmaal004, 
   t2_pmaal004 LIKE pmaal_t.pmaal004, 
   t5_pmaal004 LIKE pmaal_t.pmaal004, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t15_pmaal004 LIKE pmaal_t.pmaal004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oojdl_t_oojdl003 LIKE oojdl_t.oojdl003, 
   t3_oocql004 LIKE oocql_t.oocql004, 
   t4_oocql004 LIKE oocql_t.oocql004, 
   t6_oocql004 LIKE oocql_t.oocql004, 
   t9_oocql004 LIKE oocql_t.oocql004, 
   x_t12_oocql004 LIKE oocql_t.oocql004, 
   x_t13_oocql004 LIKE oocql_t.oocql004, 
   x_t14_oocql004 LIKE oocql_t.oocql004, 
   x_t19_oocql004 LIKE oocql_t.oocql004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   pmaml_t_pmaml003 LIKE pmaml_t.pmaml003, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t20_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t17_oocal003 LIKE oocal_t.oocal003, 
   x_t18_oocal003 LIKE oocal_t.oocal003, 
   l_pmdl004_pmaal004 LIKE type_t.chr37, 
   l_pmdl021_pmaal004 LIKE type_t.chr100, 
   l_pmdl022_pmaal004 LIKE type_t.chr100, 
   l_pmdl002_ooag011 LIKE type_t.chr20, 
   l_pmdl003_ooefl003 LIKE type_t.chr20, 
   l_pmdn001_imaal004 LIKE type_t.chr30, 
   l_pmdnunit_ooefl003 LIKE type_t.chr20, 
   l_pmdnorga_ooefl003 LIKE type_t.chr20, 
   l_pmdn027_desc LIKE type_t.chr20, 
   l_pmdl011_desc LIKE type_t.chr30, 
   l_amount LIKE type_t.num20_6, 
   l_pmdl025_address LIKE oofb_t.oofb017, 
   l_pmdl026_address LIKE oofb_t.oofb017, 
   l_pmdl027_tel LIKE oofc_t.oofc012, 
   l_pmdl027_fax LIKE oofc_t.oofc012
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #QBE條件 
       c1 LIKE type_t.chr1,         #單據來源列印 
       a1 LIKE type_t.chr1          #列印額外品名
       END RECORD
DEFINE sr DYNAMIC ARRAY OF sr1_r                   #宣告sr為sr1_t資料結構的動態陣列
DEFINE g_select        STRING
DEFINE g_from          STRING
DEFINE g_where         STRING
DEFINE g_order         STRING
DEFINE g_sql           STRING                         #report_select_prep,REPORT段使用
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE sr3_r RECORD
   pmdmdocno      LIKE pmdm_t.pmdmdocno,
   pmdm001        LIKE pmdm_t.pmdm001,
   pmdm002        LIKE pmdm_t.pmdm002,
   l_pmdm002_desc LIKE ooibl_t.ooibl004,
   pmdm003        LIKE pmdm_t.pmdm003,
   pmdm004        LIKE pmdm_t.pmdm004,
   pmdm005        LIKE pmdm_t.pmdm005,
   pmdm006        LIKE pmdm_t.pmdm006,
   l_amount       LIKE pmdm_t.pmdm006,
   l_pmdm014_desc LIKE gzcbl_t.gzcbl004   #add--160922-00028#1 By shiun
END RECORD
TYPE sr4_r RECORD
   pmdodocno      LIKE pmdo_t.pmdodocno,
   pmdoseq        LIKE pmdo_t.pmdoseq,
   pmdoseq1       LIKE pmdo_t.pmdoseq1,
   pmdoseq2       LIKE pmdo_t.pmdoseq2,
   pmdo001        LIKE pmdo_t.pmdo001,
   pmdo002        LIKE pmdo_t.pmdo002,
   pmdo003        LIKE pmdo_t.pmdo003,
   pmdo004        LIKE pmdo_t.pmdo004,
   pmdo006        LIKE pmdo_t.pmdo006,
   pmdo011        LIKE pmdo_t.pmdo011,
   imaal003       LIKE imaal_t.imaal003,
   imaal004       LIKE imaal_t.imaal004,
   l_pmdo003_desc LIKE type_t.chr80,
   l_item_show    LIKE type_t.chr1
END RECORD
TYPE sr5_r RECORD
   pmdpdocno      LIKE pmdp_t.pmdpdocno,
   pmdpseq        LIKE pmdp_t.pmdpseq,
   pmdpseq1       LIKE pmdp_t.pmdpseq1,
   pmdp003        LIKE pmdp_t.pmdp003,
   pmdp004        LIKE pmdp_t.pmdp004,
   pmdp005        LIKE pmdp_t.pmdp005,
   pmdp006        LIKE pmdp_t.pmdp006,
   pmdp023        LIKE pmdp_t.pmdp023,
   pmdp022        LIKE pmdp_t.pmdp022 
END RECORD
#add by tangyi 160712-str
TYPE sr8_r RECORD
   pmdldocno  LIKE pmdl_t.pmdldocno,          #單號 
   item       LIKE imaa_t.imaa001,            #料件编号
   imaal003   LIKE imaal_t.imaal003,          #品名
   inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
   inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
   inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)
   pmdn006    LIKE pmdn_t.pmdn006,            #單位
   pmdn0071   LIKE pmdn_t.pmdn007,            #數量1
   pmdn0072   LIKE pmdn_t.pmdn007,            #數量2
   pmdn0073   LIKE pmdn_t.pmdn007,            #數量3
   pmdn0074   LIKE pmdn_t.pmdn007,            #數量4
   pmdn0075   LIKE pmdn_t.pmdn007,            #數量5
   pmdn0076   LIKE pmdn_t.pmdn007,            #數量6
   pmdn0077   LIKE pmdn_t.pmdn007,            #數量7
   pmdn0078   LIKE pmdn_t.pmdn007,            #數量8
   pmdn0079   LIKE pmdn_t.pmdn007,            #數量9
   pmdn0070   LIKE pmdn_t.pmdn007             #數量10
   ,l_skip    LIKE type_t.chr1,
   pmdn015    LIKE pmdn_t.pmdn015             #单价   
 END RECORD
DEFINE g_inam014        ARRAY[10] OF VARCHAR(1000)
DEFINE l_total LIKE type_t.num10
TYPE r_sum   RECORD 
                 sum01  LIKE pmdn_t.pmdn007,
                 sum02  LIKE pmdn_t.pmdn007,
                 sum03  LIKE pmdn_t.pmdn007,
                 sum04  LIKE pmdn_t.pmdn007,
                 sum05  LIKE pmdn_t.pmdn007,
                 sum06  LIKE pmdn_t.pmdn007,
                 sum07  LIKE pmdn_t.pmdn007,
                 sum08  LIKE pmdn_t.pmdn007,
                 sum09  LIKE pmdn_t.pmdn007,
                 sum10  LIKE pmdn_t.pmdn007,
                 sum11  LIKE pmdn_t.pmdn007
             END RECORD
#add by tangyi 160712-end-
#end add-point
 
{</section>}
 
{<section id="apmr500_g01.main" readonly="Y" >}
PUBLIC FUNCTION apmr500_g01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  QBE條件 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.c1  單據來源列印 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.a1  列印額外品名
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.c1 = p_arg2
   LET tm.a1 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "apmr500_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL apmr500_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL apmr500_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL apmr500_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr500_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr500_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
 
#   #end add-point
#   LET g_select = " SELECT ( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl022 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl021 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl004 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal006 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl004 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal005 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl032 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal006 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl021 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal006 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl022 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,pmdl006,pmdl007,pmdl008,pmdl009,pmdl010, 
#       pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,pmdl022,pmdl023, 
#       pmdl024,pmdl025,pmdl026,pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,pmdl032,pmdl033,pmdl040,pmdl041, 
#       pmdl042,pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,pmdl049,pmdldocdt,pmdldocno,pmdlent,pmdlsite, 
#       pmdlstus,pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,pmdn011, 
#       pmdn012,pmdn013,pmdn014,pmdn015,pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,pmdn022,pmdn023,pmdn024, 
#       pmdn025,pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,pmdn036, 
#       pmdn037,pmdn038,pmdn039,pmdn040,pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,pmdn046,pmdn047,pmdn048, 
#       pmdn049,pmdn050,pmdn051,pmdnorga,pmdnseq,pmdnsite,pmdnunit,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmdl_t.pmdl002 AND ooag_t.ooagent = pmdl_t.pmdlent), 
#       ( SELECT oofa011 FROM oofa_t WHERE oofa_t.oofa001 = pmdl_t.pmdl027 AND oofa_t.oofaent = pmdl_t.pmdlent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdl_t.pmdl003 AND ooefl_t.ooeflent = pmdl_t.pmdlent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdl_t.pmdl029 AND ooefl_t.ooeflent = pmdl_t.pmdlent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),x.t10_ooefl003,x.t11_ooefl003,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl022 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl021 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl004 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl032 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),x.t15_pmaal004,( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = pmdl_t.pmdl009 AND ooibl_t.ooiblent = pmdl_t.pmdlent AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),( SELECT oojdl003 FROM oojdl_t WHERE oojdl_t.oojdl001 = pmdl_t.pmdl023 AND oojdl_t.oojdlent = pmdl_t.pmdlent AND oojdl_t.oojdl002 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '263' AND oocql_t.oocql002 = pmdl_t.pmdl020 AND oocql_t.oocqlent = pmdl_t.pmdlent AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmdl_t.pmdl010 AND oocql_t.oocqlent = pmdl_t.pmdlent AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '298' AND oocql_t.oocql002 = pmdl_t.pmdl043 AND oocql_t.oocqlent = pmdl_t.pmdlent AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '264' AND oocql_t.oocql002 = pmdl_t.pmdl024 AND oocql_t.oocqlent = pmdl_t.pmdlent AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),x.t12_oocql004,x.t13_oocql004,x.t14_oocql004,x.t19_oocql004,( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = pmdl_t.pmdl015 AND ooail_t.ooailent = pmdl_t.pmdlent AND ooail_t.ooail002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaml003 FROM pmaml_t WHERE pmaml_t.pmaml001 = pmdl_t.pmdl017 AND pmaml_t.pmamlent = pmdl_t.pmdlent AND pmaml_t.pmaml002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooidl003 FROM ooidl_t WHERE ooidl_t.ooidl001 = pmdl_t.pmdl018 AND ooidl_t.ooidlent = pmdl_t.pmdlent AND ooidl_t.ooidl002 = '" , 
#       g_dlang,"'" ,"),x.imaal_t_imaal003,x.t20_imaal003,x.oocal_t_oocal003,x.t17_oocal003,x.t18_oocal003, 
#       trim(pmdl004)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl004 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmdl021)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl021 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmdl022)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl022 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmdl002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmdl_t.pmdl002 AND ooag_t.ooagent = pmdl_t.pmdlent)), 
#       trim(pmdl003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdl_t.pmdl003 AND ooefl_t.ooeflent = pmdl_t.pmdlent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),NULL,trim(pmdnunit)||'.'||trim(x.t10_ooefl003),trim(pmdnorga)||'.'||trim(x.t11_ooefl003), 
#       NULL,NULL,NULL,'','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #170120-00006#1-s MARK
   #160909-00037#1 --- add (S)
#   LET g_select = " SELECT t1.pmaal003,t2.pmaal003,t5.pmaal003,t5.pmaal006,pmaal_t.pmaal005,t2.pmaal006, 
#       t1.pmaal006,pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,pmdl011, 
#       pmdl012,pmdl013,pmdl015,pmdl016,pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,pmdl022,pmdl023,pmdl024, 
#       pmdl025,pmdl026,pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,pmdl032,pmdl033,pmdl040,pmdl041,pmdl042, 
#       pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,pmdl049,pmdldocdt,pmdldocno,pmdlent,pmdlsite,pmdlstus, 
#       pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,pmdn011,pmdn012, 
#       pmdn013,pmdn014,pmdn015,pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,pmdn022,pmdn023,pmdn024,pmdn025, 
#       pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,pmdn036,pmdn037, 
#       pmdn038,pmdn039,pmdn040,pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,pmdn046,pmdn047,pmdn048,pmdn049, 
#       pmdn050,pmdn051,pmdnorga,pmdnseq,pmdnsite,pmdnunit,t7.ooag011,pmaj_t.pmaj012,ooefl_t.ooefl003, 
#       t8.ooefl003,x.t10_ooefl003,x.t11_ooefl003,t1.pmaal004,t2.pmaal004,t5.pmaal004,pmaal_t.pmaal004, 
#       x.t15_pmaal004,ooibl_t.ooibl004,oojdl_t.oojdl003,t3.oocql004,t4.oocql004,t6.oocql004,t9.oocql004, 
#       x.t12_oocql004,x.t13_oocql004,x.t14_oocql004,x.t19_oocql004,ooail_t.ooail003,pmaml_t.pmaml003, 
#       ooidl_t.ooidl003,x.imaal_t_imaal003,x.t20_imaal003,x.oocal_t_oocal003,x.t17_oocal003,x.t18_oocal003, 
#       trim(pmdl004)||'.'||trim(t5.pmaal004),trim(pmdl021)||'.'||trim(t2.pmaal004),trim(pmdl022)||'.'||trim(t1.pmaal004), 
#       trim(pmdl002)||'.'||trim(t7.ooag011),trim(pmdl003)||'.'||trim(ooefl_t.ooefl003),NULL,trim(pmdnunit)||'.'||trim(x.t10_ooefl003), 
#       trim(pmdnorga)||'.'||trim(x.t11_ooefl003),NULL,NULL,NULL,'','','',''"
   #160909-00037#1 --- add (E)
   #170120-00006#1-e MARK
    #170120-00006#1-s
    LET g_select = " SELECT DISTINCT t1.pmaal003,t2.pmaal003,t5.pmaal003,t5.pmaal006,pmaal_t.pmaal005,t2.pmaal006, 
      t1.pmaal006,pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,pmdl011, 
      pmdl012,pmdl013,pmdl015,pmdl016,pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,pmdl022,pmdl023,pmdl024, 
      pmdl025,pmdl026,pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,pmdl032,pmdl033,pmdl040,pmdl041,pmdl042, 
      pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,pmdl049,pmdldocdt,pmdldocno,pmdlent,pmdlsite,pmdlstus, 
      pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,pmdn011,pmdn012, 
      pmdn013,pmdn014,pmdn015,pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,pmdn022,pmdn023,pmdn024,pmdn025, 
      pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,pmdn036,pmdn037, 
      pmdn038,pmdn039,pmdn040,pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,pmdn046,pmdn047,pmdn048,pmdn049, 
      pmdn050,pmdn051,pmdnorga,pmdnseq,pmdnsite,pmdnunit,t7.ooag011,pmaj_t.pmaj012,ooefl_t.ooefl003, 
      t8.ooefl003,x.t10_ooefl003,x.t11_ooefl003,t1.pmaal004,t2.pmaal004,t5.pmaal004,pmaal_t.pmaal004, 
      x.t15_pmaal004,ooibl_t.ooibl004,oojdl_t.oojdl003,t3.oocql004,t4.oocql004,t6.oocql004,t9.oocql004, 
      x.t12_oocql004,x.t13_oocql004,x.t14_oocql004,x.t19_oocql004,ooail_t.ooail003,pmaml_t.pmaml003, 
      ooidl_t.ooidl003,x.imaal_t_imaal003,x.t20_imaal003,x.oocal_t_oocal003,x.t17_oocal003,x.t18_oocal003, 
      trim(pmdl004)||'.'||trim(t5.pmaal004),trim(pmdl021)||'.'||trim(t2.pmaal004),trim(pmdl022)||'.'||trim(t1.pmaal004), 
      trim(pmdl002)||'.'||trim(t7.ooag011),trim(pmdl003)||'.'||trim(ooefl_t.ooefl003),NULL,trim(pmdnunit)||'.'||trim(x.t10_ooefl003), 
      trim(pmdnorga)||'.'||trim(x.t11_ooefl003),NULL,NULL,NULL,'','','',''"
    #170120-00006#1-e  
#   #end add-point
#    LET g_from = " FROM pmdl_t LEFT OUTER JOIN ( SELECT pmdn_t.*,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdn_t.pmdnunit AND ooefl_t.ooeflent = pmdn_t.pmdnent AND ooefl_t.ooefl002 = '" , 
#        g_dlang,"'" ,") t10_ooefl003,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdn_t.pmdnorga AND ooefl_t.ooeflent = pmdn_t.pmdnent AND ooefl_t.ooefl002 = '" , 
#        g_dlang,"'" ,") t11_ooefl003,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdn_t.pmdn023 AND pmaal_t.pmaalent = pmdn_t.pmdnent AND pmaal_t.pmaal002 = '" , 
#        g_dlang,"'" ,") t15_pmaal004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '265' AND oocql_t.oocql002 = pmdn_t.pmdn051 AND oocql_t.oocqlent = pmdn_t.pmdnent AND oocql_t.oocql003 = '" , 
#        g_dlang,"'" ,") t12_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '265' AND oocql_t.oocql002 = pmdn_t.pmdn049 AND oocql_t.oocqlent = pmdn_t.pmdnent AND oocql_t.oocql003 = '" , 
#        g_dlang,"'" ,") t13_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '263' AND oocql_t.oocql002 = pmdn_t.pmdn031 AND oocql_t.oocqlent = pmdn_t.pmdnent AND oocql_t.oocql003 = '" , 
#        g_dlang,"'" ,") t14_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '221' AND oocql_t.oocql002 = pmdn_t.pmdn004 AND oocql_t.oocqlent = pmdn_t.pmdnent AND oocql_t.oocql003 = '" , 
#        g_dlang,"'" ,") t19_oocql004,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdn_t.pmdn003 AND imaal_t.imaalent = pmdn_t.pmdnent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdn_t.pmdn001 AND imaal_t.imaalent = pmdn_t.pmdnent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") t20_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdn_t.pmdn010 AND oocal_t.oocalent = pmdn_t.pmdnent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdn_t.pmdn008 AND oocal_t.oocalent = pmdn_t.pmdnent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") t17_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdn_t.pmdn006 AND oocal_t.oocalent = pmdn_t.pmdnent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") t18_oocal003 FROM pmdn_t ) x  ON pmdl_t.pmdlent = x.pmdnent AND pmdl_t.pmdldocno  
#        = x.pmdndocno AND pmdl_t.pmdlsite = x.pmdnsite"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   #160909-00037#1 --- add (S)
   LET g_from = " FROM pmdl_t LEFT OUTER JOIN pmaj_t ON pmaj_t.pmaj002 = pmdl_t.pmdl027 AND pmaj_t.pmajent = pmdl_t.pmdlent ", 
        " LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = pmdl_t.pmdl032 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '",g_dlang,"'" ,
        " LEFT OUTER JOIN oojdl_t ON oojdl_t.oojdl001 = pmdl_t.pmdl023 AND oojdl_t. oojdlent = pmdl_t.pmdlent AND oojdl_t. oojdl002 = '",g_dlang,"'" ,
        " LEFT OUTER JOIN pmaal_t t1 ON t1.pmaal001 = pmdl_t.pmdl022 AND t1.pmaalent = pmdl_t.pmdlent AND t1.pmaal002 = '",g_dlang,"'", 
        " LEFT OUTER JOIN pmaal_t t2 ON t2.pmaal001 = pmdl_t.pmdl021 AND t2.pmaalent = pmdl_t.pmdlent AND t2.pmaal002 = '" ,g_dlang,"'" ,
        " LEFT OUTER JOIN oocql_t t3 ON t3.oocql001 = '263' AND t3.oocql002 = pmdl_t.pmdl020 AND t3.oocqlent = pmdl_t.pmdlent AND t3.oocql003 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN pmaml_t ON pmaml_t.pmaml001 = pmdl_t.pmdl017 AND pmaml_t.pmamlent = pmdl_t.pmdlent AND pmaml_t.pmaml002 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = pmdl_t.pmdl015 AND ooail_t.ooailent = pmdl_t.pmdlent AND ooail_t.ooail002 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN oocql_t t4 ON t4.oocql001 = '238' AND t4.oocql002 = pmdl_t.pmdl010 AND t4.oocqlent = pmdl_t.pmdlent AND t4.oocql003 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = pmdl_t.pmdl009 AND ooibl_t.ooiblent = pmdl_t.pmdlent AND ooibl_t.ooibl003 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN pmaal_t t5 ON t5.pmaal001 = pmdl_t.pmdl004 AND t5.pmaalent = pmdl_t.pmdlent AND t5.pmaal002 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = pmdl_t.pmdl003 AND ooefl_t.ooeflent = pmdl_t.pmdlent AND ooefl_t.ooefl002 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN oocql_t t6 ON t6.oocql001 = '298' AND t6.oocql002 = pmdl_t.pmdl043 AND t6.oocqlent = pmdl_t.pmdlent AND t6.oocql003 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN ooag_t t7 ON t7.ooag001 = pmdl_t.pmdl002 AND t7.ooagent = pmdl_t.pmdlent ",
        " LEFT OUTER JOIN ooidl_t ON ooidl_t.ooidl001 = pmdl_t.pmdl018 AND ooidl_t.ooidlent = pmdl_t.pmdlent AND ooidl_t.ooidl002 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN ooefl_t t8 ON t8.ooefl001 = pmdl_t.pmdl029 AND t8.ooeflent = pmdl_t.pmdlent AND t8.ooefl002 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN oocql_t t9 ON t9.oocql001 = '264' AND t9.oocql002 = pmdl_t.pmdl024 AND t9.oocqlent = pmdl_t.pmdlent AND t9.oocql003 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN ( SELECT pmdn_t.*,t10.ooefl003 t10_ooefl003,t11.ooefl003 t11_ooefl003, 
        t15.pmaal004 t15_pmaal004,t12.oocql004 t12_oocql004,t13.oocql004 t13_oocql004,t14.oocql004 t14_oocql004, 
        t19.oocql004 t19_oocql004,imaal_t.imaal003 imaal_t_imaal003,t20.imaal003 t20_imaal003,oocal_t.oocal003 oocal_t_oocal003, 
        t17.oocal003 t17_oocal003,t18.oocal003 t18_oocal003 FROM pmdn_t LEFT OUTER JOIN ooefl_t t10 ON t10.ooefl001 = pmdn_t.pmdnunit AND t10.ooeflent = pmdn_t.pmdnent AND t10.ooefl002 = '" ,g_dlang,"'" , 
        " LEFT OUTER JOIN ooefl_t t11 ON t11.ooefl001 = pmdn_t.pmdnorga AND t11.ooeflent = pmdn_t.pmdnent AND t11.ooefl002 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN oocql_t t12 ON t12.oocql001 = '265' AND t12.oocql002 = pmdn_t.pmdn051 AND t12.oocqlent = pmdn_t.pmdnent AND t12.oocql003 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN oocql_t t13 ON t13.oocql001 = '265' AND t13.oocql002 = pmdn_t.pmdn049 AND t13.oocqlent = pmdn_t.pmdnent AND t13.oocql003 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN oocql_t t14 ON t14.oocql001 = '263' AND t14.oocql002 = pmdn_t.pmdn031 AND t14.oocqlent = pmdn_t.pmdnent AND t14.oocql003 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN pmaal_t t15 ON t15.pmaal001 = pmdn_t.pmdn023 AND t15.pmaalent = pmdn_t.pmdnent AND t15.pmaal002 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = pmdn_t.pmdn010 AND oocal_t.oocalent = pmdn_t.pmdnent AND oocal_t.oocal002 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN oocal_t t17 ON t17.oocal001 = pmdn_t.pmdn008 AND t17.oocalent = pmdn_t.pmdnent AND t17.oocal002 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN oocal_t t18 ON t18.oocal001 = pmdn_t.pmdn006 AND t18.oocalent = pmdn_t.pmdnent AND t18.oocal002 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN oocql_t t19 ON t19.oocql001 = '221' AND t19.oocql002 = pmdn_t.pmdn004 AND t19.oocqlent = pmdn_t.pmdnent AND t19.oocql003 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = pmdn_t.pmdn003 AND imaal_t.imaalent = pmdn_t.pmdnent AND imaal_t.imaal002 = '" , g_dlang,"'" ,
        " LEFT OUTER JOIN imaal_t t20 ON t20.imaal001 = pmdn_t.pmdn001 AND t20.imaalent = pmdn_t.pmdnent AND t20.imaal002 = '" , g_dlang,"'" ,
        " ) x  ON pmdl_t.pmdlent = x.pmdnent AND pmdl_t.pmdldocno = x.pmdndocno  
        AND pmdl_t.pmdlsite = x.pmdnsite"
   #160909-00037#1 --- add (E)
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY pmdldocno,pmdnseq,pmdn001"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmdl_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr500_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE apmr500_g01_curs CURSOR FOR apmr500_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr500_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr500_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   t1_pmaal003 LIKE pmaal_t.pmaal003, 
   t2_pmaal003 LIKE pmaal_t.pmaal003, 
   t5_pmaal003 LIKE pmaal_t.pmaal003, 
   t5_pmaal006 LIKE pmaal_t.pmaal006, 
   pmaal_t_pmaal005 LIKE pmaal_t.pmaal005, 
   t2_pmaal006 LIKE pmaal_t.pmaal006, 
   t1_pmaal006 LIKE pmaal_t.pmaal006, 
   pmdl001 LIKE pmdl_t.pmdl001, 
   pmdl002 LIKE pmdl_t.pmdl002, 
   pmdl003 LIKE pmdl_t.pmdl003, 
   pmdl004 LIKE pmdl_t.pmdl004, 
   pmdl005 LIKE pmdl_t.pmdl005, 
   pmdl006 LIKE pmdl_t.pmdl006, 
   pmdl007 LIKE pmdl_t.pmdl007, 
   pmdl008 LIKE pmdl_t.pmdl008, 
   pmdl009 LIKE pmdl_t.pmdl009, 
   pmdl010 LIKE pmdl_t.pmdl010, 
   pmdl011 LIKE pmdl_t.pmdl011, 
   pmdl012 LIKE pmdl_t.pmdl012, 
   pmdl013 LIKE pmdl_t.pmdl013, 
   pmdl015 LIKE pmdl_t.pmdl015, 
   pmdl016 LIKE pmdl_t.pmdl016, 
   pmdl017 LIKE pmdl_t.pmdl017, 
   pmdl018 LIKE pmdl_t.pmdl018, 
   pmdl019 LIKE pmdl_t.pmdl019, 
   pmdl020 LIKE pmdl_t.pmdl020, 
   pmdl021 LIKE pmdl_t.pmdl021, 
   pmdl022 LIKE pmdl_t.pmdl022, 
   pmdl023 LIKE pmdl_t.pmdl023, 
   pmdl024 LIKE pmdl_t.pmdl024, 
   pmdl025 LIKE pmdl_t.pmdl025, 
   pmdl026 LIKE pmdl_t.pmdl026, 
   pmdl027 LIKE pmdl_t.pmdl027, 
   pmdl028 LIKE pmdl_t.pmdl028, 
   pmdl029 LIKE pmdl_t.pmdl029, 
   pmdl030 LIKE pmdl_t.pmdl030, 
   pmdl031 LIKE pmdl_t.pmdl031, 
   pmdl032 LIKE pmdl_t.pmdl032, 
   pmdl033 LIKE pmdl_t.pmdl033, 
   pmdl040 LIKE pmdl_t.pmdl040, 
   pmdl041 LIKE pmdl_t.pmdl041, 
   pmdl042 LIKE pmdl_t.pmdl042, 
   pmdl043 LIKE pmdl_t.pmdl043, 
   pmdl044 LIKE pmdl_t.pmdl044, 
   pmdl046 LIKE pmdl_t.pmdl046, 
   pmdl047 LIKE pmdl_t.pmdl047, 
   pmdl048 LIKE pmdl_t.pmdl048, 
   pmdl049 LIKE pmdl_t.pmdl049, 
   pmdldocdt LIKE pmdl_t.pmdldocdt, 
   pmdldocno LIKE pmdl_t.pmdldocno, 
   pmdlent LIKE pmdl_t.pmdlent, 
   pmdlsite LIKE pmdl_t.pmdlsite, 
   pmdlstus LIKE pmdl_t.pmdlstus, 
   pmdn001 LIKE pmdn_t.pmdn001, 
   pmdn002 LIKE pmdn_t.pmdn002, 
   pmdn003 LIKE pmdn_t.pmdn003, 
   pmdn004 LIKE pmdn_t.pmdn004, 
   pmdn005 LIKE pmdn_t.pmdn005, 
   pmdn006 LIKE pmdn_t.pmdn006, 
   pmdn007 LIKE pmdn_t.pmdn007, 
   pmdn008 LIKE pmdn_t.pmdn008, 
   pmdn009 LIKE pmdn_t.pmdn009, 
   pmdn010 LIKE pmdn_t.pmdn010, 
   pmdn011 LIKE pmdn_t.pmdn011, 
   pmdn012 LIKE pmdn_t.pmdn012, 
   pmdn013 LIKE pmdn_t.pmdn013, 
   pmdn014 LIKE pmdn_t.pmdn014, 
   pmdn015 LIKE pmdn_t.pmdn015, 
   pmdn016 LIKE pmdn_t.pmdn016, 
   pmdn017 LIKE pmdn_t.pmdn017, 
   pmdn019 LIKE pmdn_t.pmdn019, 
   pmdn020 LIKE pmdn_t.pmdn020, 
   pmdn021 LIKE pmdn_t.pmdn021, 
   pmdn022 LIKE pmdn_t.pmdn022, 
   pmdn023 LIKE pmdn_t.pmdn023, 
   pmdn024 LIKE pmdn_t.pmdn024, 
   pmdn025 LIKE pmdn_t.pmdn025, 
   pmdn026 LIKE pmdn_t.pmdn026, 
   pmdn027 LIKE pmdn_t.pmdn027, 
   pmdn028 LIKE pmdn_t.pmdn028, 
   pmdn029 LIKE pmdn_t.pmdn029, 
   pmdn030 LIKE pmdn_t.pmdn030, 
   pmdn031 LIKE pmdn_t.pmdn031, 
   pmdn032 LIKE pmdn_t.pmdn032, 
   pmdn033 LIKE pmdn_t.pmdn033, 
   pmdn034 LIKE pmdn_t.pmdn034, 
   pmdn035 LIKE pmdn_t.pmdn035, 
   pmdn036 LIKE pmdn_t.pmdn036, 
   pmdn037 LIKE pmdn_t.pmdn037, 
   pmdn038 LIKE pmdn_t.pmdn038, 
   pmdn039 LIKE pmdn_t.pmdn039, 
   pmdn040 LIKE pmdn_t.pmdn040, 
   pmdn041 LIKE pmdn_t.pmdn041, 
   pmdn042 LIKE pmdn_t.pmdn042, 
   pmdn043 LIKE pmdn_t.pmdn043, 
   pmdn044 LIKE pmdn_t.pmdn044, 
   pmdn045 LIKE pmdn_t.pmdn045, 
   pmdn046 LIKE pmdn_t.pmdn046, 
   pmdn047 LIKE pmdn_t.pmdn047, 
   pmdn048 LIKE pmdn_t.pmdn048, 
   pmdn049 LIKE pmdn_t.pmdn049, 
   pmdn050 LIKE pmdn_t.pmdn050, 
   pmdn051 LIKE pmdn_t.pmdn051, 
   pmdnorga LIKE pmdn_t.pmdnorga, 
   pmdnseq LIKE pmdn_t.pmdnseq, 
   pmdnsite LIKE pmdn_t.pmdnsite, 
   pmdnunit LIKE pmdn_t.pmdnunit, 
   t7_ooag011 LIKE ooag_t.ooag011, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t8_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t10_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t11_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_pmaal004 LIKE pmaal_t.pmaal004, 
   t2_pmaal004 LIKE pmaal_t.pmaal004, 
   t5_pmaal004 LIKE pmaal_t.pmaal004, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t15_pmaal004 LIKE pmaal_t.pmaal004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oojdl_t_oojdl003 LIKE oojdl_t.oojdl003, 
   t3_oocql004 LIKE oocql_t.oocql004, 
   t4_oocql004 LIKE oocql_t.oocql004, 
   t6_oocql004 LIKE oocql_t.oocql004, 
   t9_oocql004 LIKE oocql_t.oocql004, 
   x_t12_oocql004 LIKE oocql_t.oocql004, 
   x_t13_oocql004 LIKE oocql_t.oocql004, 
   x_t14_oocql004 LIKE oocql_t.oocql004, 
   x_t19_oocql004 LIKE oocql_t.oocql004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   pmaml_t_pmaml003 LIKE pmaml_t.pmaml003, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t20_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t17_oocal003 LIKE oocal_t.oocal003, 
   x_t18_oocal003 LIKE oocal_t.oocal003, 
   l_pmdl004_pmaal004 LIKE type_t.chr37, 
   l_pmdl021_pmaal004 LIKE type_t.chr100, 
   l_pmdl022_pmaal004 LIKE type_t.chr100, 
   l_pmdl002_ooag011 LIKE type_t.chr20, 
   l_pmdl003_ooefl003 LIKE type_t.chr20, 
   l_pmdn001_imaal004 LIKE type_t.chr30, 
   l_pmdnunit_ooefl003 LIKE type_t.chr20, 
   l_pmdnorga_ooefl003 LIKE type_t.chr20, 
   l_pmdn027_desc LIKE type_t.chr20, 
   l_pmdl011_desc LIKE type_t.chr30, 
   l_amount LIKE type_t.num20_6, 
   l_pmdl025_address LIKE oofb_t.oofb017, 
   l_pmdl026_address LIKE oofb_t.oofb017, 
   l_pmdl027_tel LIKE oofc_t.oofc012, 
   l_pmdl027_fax LIKE oofc_t.oofc012
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_ooef019          LIKE ooef_t.ooef019

#add--2015/08/06 By shiun--(S)
DEFINE l_pmdl021_pmaa027  LIKE pmaa_t.pmaa027   #帳款客戶識別碼
DEFINE l_pmdl022_pmaa027  LIKE pmaa_t.pmaa027   #送貨客戶識別碼
DEFINE l_success          LIKE type_t.num5
DEFINE l_oofa001          LIKE oofa_t.oofa001
#add--2015/08/06 By shiun--(E)
#add by tangyi 160712-str-
DEFINE l_colorsize LIKE type_t.chr100
DEFINE l_pmdn002_desc LIKE type_t.chr100
DEFINE l_inam012   LIKE type_t.chr1000
DEFINE l_inam014   LIKE type_t.chr1000
DEFINE l_inam018   LIKE type_t.chr1000
DEFINE l_inam012_desc   LIKE type_t.chr100
DEFINE l_inam014_desc   LIKE type_t.chr100
DEFINE l_inam018_desc   LIKE type_t.chr100
DEFINE tok         base.StringTokenizer
DEFINE l_cnt2      LIKE type_t.num10
DEFINE l_imec003       LIKE imec_t.imec003
DEFINE l_imaa005       LIKE imaa_t.imaa005
DEFINE l_imeb012    LIKE imeb_t.imeb012
DEFINE l_imecl005   LIKE imecl_t.imecl005
#add by tangyi 160712-end-
#161031-00024#6 Add By Ken 170125(S)
DEFINE l_slip_tmp       LIKE ooba_t.ooba002      #單據別   
DEFINE l_gzcb002        LIKE gzcb_t.gzcb002      #單據別參數
DEFINE l_sql            STRING
DEFINE l_cnt_chk        LIKE type_t.num10
#161031-00024#6 Add By Ken 170125(E)
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #add by tangyi 160712-str-  
    CALL apmr500_g01_erwei_tmp_table()   
    LET g_sql = " INSERT INTO apmr500_g01_temp02(pmdldocno,item,imaal003,inam012,inam014,inam018,pmdn006,pmdn007) VALUES (?,?,?,?,?,?,?,?) "
    PREPARE master_tmp FROM g_sql   
    #add by tangyi 160712-end-
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH apmr500_g01_curs INTO sr_s.*
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()       
          LET g_rep_success = 'N'    
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段foreach name="ins_data.foreach"
       #單頭稅別資料 依據點顯示說明
       LET l_ooef019 = ''
       SELECT ooef019 INTO l_ooef019 FROM ooef_t
        WHERE ooefent = sr_s.pmdlent
          AND ooef001 = sr_s.pmdlsite
       
       IF NOT cl_null(l_ooef019) THEN  
          LET sr_s.l_pmdl011_desc = '' 
          SELECT oodbl004 INTO sr_s.l_pmdl011_desc 
            FROM oodbl_t
           WHERE oodblent = sr_s.pmdlent
             AND oodbl001 = l_ooef019
             AND oodbl002 = sr_s.pmdl011
             AND oodbl003 = g_dlang                  
       END IF   
       
       #如果要將內存值外顯再解開
       #SELECT gzcb002||"."||gzcbl004 INTO sr1.l_pmdn027_desc
       SELECT gzcbl004 INTO sr_s.l_pmdn027_desc
         FROM gzcb_t,gzcbl_t
        WHERE gzcb001 = gzcbl001 AND gzcb002 = gzcbl002
          AND gzcb001 = '2036'   AND gzcbl003 = g_dlang
          AND gzcb002 = sr_s.pmdn020
          
            
       #單身 料號-規格 顯示內容抓取            
       SELECT imaal004 INTO sr_s.l_pmdn001_imaal004 
         FROM imaal_t
        WHERE imaalent = sr_s.pmdlent
          AND imaal001 = sr_s.pmdn001
          AND imaal002 = g_dlang
          
       IF sr_s.pmdl013 = 'Y' THEN
          LET sr_s.l_amount = sr_s.pmdn047
       ELSE
          LET sr_s.l_amount = sr_s.pmdn046
       END IF
       
       #modify--2015/02/04 By Shiun--(S)
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL apmr500_g01_initialize(sr_s.pmdl004,sr_s.l_pmdl004_pmaal004) RETURNING sr_s.l_pmdl004_pmaal004
       CALL apmr500_g01_initialize(sr_s.pmdl021,sr_s.l_pmdl021_pmaal004) RETURNING sr_s.l_pmdl021_pmaal004
       CALL apmr500_g01_initialize(sr_s.pmdl022,sr_s.l_pmdl022_pmaal004) RETURNING sr_s.l_pmdl022_pmaal004
       CALL apmr500_g01_initialize(sr_s.pmdl002,sr_s.l_pmdl002_ooag011) RETURNING sr_s.l_pmdl002_ooag011
       CALL apmr500_g01_initialize(sr_s.pmdl003,sr_s.l_pmdl003_ooefl003) RETURNING sr_s.l_pmdl003_ooefl003
       CALL apmr500_g01_initialize(sr_s.pmdnunit,sr_s.l_pmdnunit_ooefl003) RETURNING sr_s.l_pmdnunit_ooefl003
       CALL apmr500_g01_initialize(sr_s.pmdnorga,sr_s.l_pmdnorga_ooefl003) RETURNING sr_s.l_pmdnorga_ooefl003
       #modify--2015/02/04 By Shiun--(E)
       
       #add--2015/08/06 By shiun--(S)
#       #帳款客戶
#       SELECT pmaa027 INTO l_pmdl021_pmaa027
#         FROM pmaa_t
#        WHERE pmaaent = g_enterprise
#          AND pmaa001 = sr_s.pmdlsite
##          AND pmaa001 = sr_s.pmdl021
#       #送貨客戶
#       SELECT pmaa027 INTO l_pmdl022_pmaa027
#         FROM pmaa_t
#        WHERE pmaaent = g_enterprise
#          AND pmaa001 = sr_s.pmdlsite
##          AND pmaa001 = sr_s.pmdl022
       SELECT oofa001 INTO l_oofa001
         FROM oofa_t
        WHERE oofaent = g_enterprise
          AND oofa002 = '1'
          AND oofa003 = sr_s.pmdlsite          
       IF NOT cl_null(sr_s.pmdl025) THEN
          CALL s_aooi350_get_address(l_oofa001,sr_s.pmdl025,g_lang)RETURNING l_success,sr_s.l_pmdl025_address
       END IF
       
       IF NOT cl_null(sr_s.pmdl026) THEN
          CALL s_aooi350_get_address(l_oofa001,sr_s.pmdl026,g_lang)RETURNING l_success,sr_s.l_pmdl026_address
       END IF
       
       IF NOT cl_null(sr_s.pmdl027) THEN
          CALL apmr500_g01_get_oofc012(sr_s.pmdl027,'1') RETURNING sr_s.l_pmdl027_tel
          CALL apmr500_g01_get_oofc012(sr_s.pmdl027,'3') RETURNING sr_s.l_pmdl027_fax
       END IF
       #add--2015/08/06 By shiun--(E)
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       #add by tangyi 160712-str-
       CALL s_feature_description(sr_s.pmdn001,sr_s.pmdn002) RETURNING l_success,l_colorsize
       LET l_pmdn002_desc=l_colorsize
       IF cl_null(sr_s.x_t20_imaal003) THEN
          LET sr_s.x_t20_imaal003= sr_s.pmdn001
       END IF  
       #add by tangyi 160712-end-    
       #161207-00033#25-S
       IF NOT cl_null(sr_s.pmdl028) THEN
          CALL s_desc_get_oneturn_guest_desc(sr_s.pmdl028) RETURNING sr_s.t5_pmaal004
          LET sr_s.t5_pmaal003 = sr_s.t5_pmaal004
          LET sr_s.l_pmdl004_pmaal004 = sr_s.pmdl004 CLIPPED,'.',sr_s.t5_pmaal004 CLIPPED
          IF sr_s.pmdl004 = sr_s.pmdl021 THEN
             LET sr_s.t2_pmaal004 = sr_s.t5_pmaal004
             LET sr_s.t2_pmaal003 = sr_s.t2_pmaal004
             LET sr_s.l_pmdl021_pmaal004 = sr_s.l_pmdl004_pmaal004 
          END IF
          IF sr_s.pmdl004 = sr_s.pmdl022 THEN
             LET sr_s.t1_pmaal004 = sr_s.t5_pmaal004
             LET sr_s.t1_pmaal003 = sr_s.t1_pmaal004
             LET sr_s.l_pmdl022_pmaal004 = sr_s.l_pmdl004_pmaal004 
          END IF 
          IF sr_s.pmdl004 = sr_s.pmdl032 THEN
             LET sr_s.pmaal_t_pmaal004 = sr_s.t5_pmaal004
          END IF   

          IF sr_s.pmdl004 = sr_s.pmdn023 THEN
             LET sr_s.x_t15_pmaal004 = sr_s.t5_pmaal004
          END IF
       END IF
       #161207-00033#25-E 

       #161031-00024#6 Add By Ken 170125(S)
       IF tm.a1 = 'Y' THEN
          #先取得單別
          LET l_success = ''
          LET l_slip_tmp = ''
          CALL s_aooi200_get_slip(sr_s.pmdldocno)
             RETURNING l_success,l_slip_tmp
          
          #取得單別參數
          CALL cl_get_doc_para(g_enterprise,g_site,l_slip_tmp,'D-MFG-0087')
             RETURNING l_gzcb002       
             
          IF NOT cl_null(l_gzcb002) THEN
             LET l_cnt_chk = 0
             SELECT COUNT(1) INTO l_cnt_chk
               FROM imab_t
              WHERE imabent = g_enterprise
                AND imab001 = sr_s.pmdn001
                AND imab002 = l_gzcb002
                AND imabstus = 'Y'
                AND (imab005 IS NOT NULL OR imab005<>'') 
             IF l_cnt_chk > 0 THEN
                CALL s_desc_get_imab004_desc(sr_s.pmdn001,l_gzcb002) RETURNING sr_s.x_t20_imaal003
                IF NOT cl_null(sr_s.x_t20_imaal003) THEN
                   LET sr_s.l_pmdn001_imaal004 = ''
                END IF
             END IF
          END IF
       END IF
       #161031-00024#6 Add By Ken 170125(E) 
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].t1_pmaal003 = sr_s.t1_pmaal003
       LET sr[l_cnt].t2_pmaal003 = sr_s.t2_pmaal003
       LET sr[l_cnt].t5_pmaal003 = sr_s.t5_pmaal003
       LET sr[l_cnt].t5_pmaal006 = sr_s.t5_pmaal006
       LET sr[l_cnt].pmaal_t_pmaal005 = sr_s.pmaal_t_pmaal005
       LET sr[l_cnt].t2_pmaal006 = sr_s.t2_pmaal006
       LET sr[l_cnt].t1_pmaal006 = sr_s.t1_pmaal006
       LET sr[l_cnt].pmdl001 = sr_s.pmdl001
       LET sr[l_cnt].pmdl002 = sr_s.pmdl002
       LET sr[l_cnt].pmdl003 = sr_s.pmdl003
       LET sr[l_cnt].pmdl004 = sr_s.pmdl004
       LET sr[l_cnt].pmdl005 = sr_s.pmdl005
       LET sr[l_cnt].pmdl006 = sr_s.pmdl006
       LET sr[l_cnt].pmdl007 = sr_s.pmdl007
       LET sr[l_cnt].pmdl008 = sr_s.pmdl008
       LET sr[l_cnt].pmdl009 = sr_s.pmdl009
       LET sr[l_cnt].pmdl010 = sr_s.pmdl010
       LET sr[l_cnt].pmdl011 = sr_s.pmdl011
       LET sr[l_cnt].pmdl012 = sr_s.pmdl012
       LET sr[l_cnt].pmdl013 = sr_s.pmdl013
       LET sr[l_cnt].pmdl015 = sr_s.pmdl015
       LET sr[l_cnt].pmdl016 = sr_s.pmdl016
       LET sr[l_cnt].pmdl017 = sr_s.pmdl017
       LET sr[l_cnt].pmdl018 = sr_s.pmdl018
       LET sr[l_cnt].pmdl019 = sr_s.pmdl019
       LET sr[l_cnt].pmdl020 = sr_s.pmdl020
       LET sr[l_cnt].pmdl021 = sr_s.pmdl021
       LET sr[l_cnt].pmdl022 = sr_s.pmdl022
       LET sr[l_cnt].pmdl023 = sr_s.pmdl023
       LET sr[l_cnt].pmdl024 = sr_s.pmdl024
       LET sr[l_cnt].pmdl025 = sr_s.pmdl025
       LET sr[l_cnt].pmdl026 = sr_s.pmdl026
       LET sr[l_cnt].pmdl027 = sr_s.pmdl027
       LET sr[l_cnt].pmdl028 = sr_s.pmdl028
       LET sr[l_cnt].pmdl029 = sr_s.pmdl029
       LET sr[l_cnt].pmdl030 = sr_s.pmdl030
       LET sr[l_cnt].pmdl031 = sr_s.pmdl031
       LET sr[l_cnt].pmdl032 = sr_s.pmdl032
       LET sr[l_cnt].pmdl033 = sr_s.pmdl033
       LET sr[l_cnt].pmdl040 = sr_s.pmdl040
       LET sr[l_cnt].pmdl041 = sr_s.pmdl041
       LET sr[l_cnt].pmdl042 = sr_s.pmdl042
       LET sr[l_cnt].pmdl043 = sr_s.pmdl043
       LET sr[l_cnt].pmdl044 = sr_s.pmdl044
       LET sr[l_cnt].pmdl046 = sr_s.pmdl046
       LET sr[l_cnt].pmdl047 = sr_s.pmdl047
       LET sr[l_cnt].pmdl048 = sr_s.pmdl048
       LET sr[l_cnt].pmdl049 = sr_s.pmdl049
       LET sr[l_cnt].pmdldocdt = sr_s.pmdldocdt
       LET sr[l_cnt].pmdldocno = sr_s.pmdldocno
       LET sr[l_cnt].pmdlent = sr_s.pmdlent
       LET sr[l_cnt].pmdlsite = sr_s.pmdlsite
       LET sr[l_cnt].pmdlstus = sr_s.pmdlstus
       LET sr[l_cnt].pmdn001 = sr_s.pmdn001
       LET sr[l_cnt].pmdn002 = sr_s.pmdn002
       LET sr[l_cnt].pmdn003 = sr_s.pmdn003
       LET sr[l_cnt].pmdn004 = sr_s.pmdn004
       LET sr[l_cnt].pmdn005 = sr_s.pmdn005
       LET sr[l_cnt].pmdn006 = sr_s.pmdn006
       LET sr[l_cnt].pmdn007 = sr_s.pmdn007
       LET sr[l_cnt].pmdn008 = sr_s.pmdn008
       LET sr[l_cnt].pmdn009 = sr_s.pmdn009
       LET sr[l_cnt].pmdn010 = sr_s.pmdn010
       LET sr[l_cnt].pmdn011 = sr_s.pmdn011
       LET sr[l_cnt].pmdn012 = sr_s.pmdn012
       LET sr[l_cnt].pmdn013 = sr_s.pmdn013
       LET sr[l_cnt].pmdn014 = sr_s.pmdn014
       LET sr[l_cnt].pmdn015 = sr_s.pmdn015
       LET sr[l_cnt].pmdn016 = sr_s.pmdn016
       LET sr[l_cnt].pmdn017 = sr_s.pmdn017
       LET sr[l_cnt].pmdn019 = sr_s.pmdn019
       LET sr[l_cnt].pmdn020 = sr_s.pmdn020
       LET sr[l_cnt].pmdn021 = sr_s.pmdn021
       LET sr[l_cnt].pmdn022 = sr_s.pmdn022
       LET sr[l_cnt].pmdn023 = sr_s.pmdn023
       LET sr[l_cnt].pmdn024 = sr_s.pmdn024
       LET sr[l_cnt].pmdn025 = sr_s.pmdn025
       LET sr[l_cnt].pmdn026 = sr_s.pmdn026
       LET sr[l_cnt].pmdn027 = sr_s.pmdn027
       LET sr[l_cnt].pmdn028 = sr_s.pmdn028
       LET sr[l_cnt].pmdn029 = sr_s.pmdn029
       LET sr[l_cnt].pmdn030 = sr_s.pmdn030
       LET sr[l_cnt].pmdn031 = sr_s.pmdn031
       LET sr[l_cnt].pmdn032 = sr_s.pmdn032
       LET sr[l_cnt].pmdn033 = sr_s.pmdn033
       LET sr[l_cnt].pmdn034 = sr_s.pmdn034
       LET sr[l_cnt].pmdn035 = sr_s.pmdn035
       LET sr[l_cnt].pmdn036 = sr_s.pmdn036
       LET sr[l_cnt].pmdn037 = sr_s.pmdn037
       LET sr[l_cnt].pmdn038 = sr_s.pmdn038
       LET sr[l_cnt].pmdn039 = sr_s.pmdn039
       LET sr[l_cnt].pmdn040 = sr_s.pmdn040
       LET sr[l_cnt].pmdn041 = sr_s.pmdn041
       LET sr[l_cnt].pmdn042 = sr_s.pmdn042
       LET sr[l_cnt].pmdn043 = sr_s.pmdn043
       LET sr[l_cnt].pmdn044 = sr_s.pmdn044
       LET sr[l_cnt].pmdn045 = sr_s.pmdn045
       LET sr[l_cnt].pmdn046 = sr_s.pmdn046
       LET sr[l_cnt].pmdn047 = sr_s.pmdn047
       LET sr[l_cnt].pmdn048 = sr_s.pmdn048
       LET sr[l_cnt].pmdn049 = sr_s.pmdn049
       LET sr[l_cnt].pmdn050 = sr_s.pmdn050
       LET sr[l_cnt].pmdn051 = sr_s.pmdn051
       LET sr[l_cnt].pmdnorga = sr_s.pmdnorga
       LET sr[l_cnt].pmdnseq = sr_s.pmdnseq
       LET sr[l_cnt].pmdnsite = sr_s.pmdnsite
       LET sr[l_cnt].pmdnunit = sr_s.pmdnunit
       LET sr[l_cnt].t7_ooag011 = sr_s.t7_ooag011
       LET sr[l_cnt].oofa_t_oofa011 = sr_s.oofa_t_oofa011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].t8_ooefl003 = sr_s.t8_ooefl003
       LET sr[l_cnt].x_t10_ooefl003 = sr_s.x_t10_ooefl003
       LET sr[l_cnt].x_t11_ooefl003 = sr_s.x_t11_ooefl003
       LET sr[l_cnt].t1_pmaal004 = sr_s.t1_pmaal004
       LET sr[l_cnt].t2_pmaal004 = sr_s.t2_pmaal004
       LET sr[l_cnt].t5_pmaal004 = sr_s.t5_pmaal004
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].x_t15_pmaal004 = sr_s.x_t15_pmaal004
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].oojdl_t_oojdl003 = sr_s.oojdl_t_oojdl003
       LET sr[l_cnt].t3_oocql004 = sr_s.t3_oocql004
       LET sr[l_cnt].t4_oocql004 = sr_s.t4_oocql004
       LET sr[l_cnt].t6_oocql004 = sr_s.t6_oocql004
       LET sr[l_cnt].t9_oocql004 = sr_s.t9_oocql004
       LET sr[l_cnt].x_t12_oocql004 = sr_s.x_t12_oocql004
       LET sr[l_cnt].x_t13_oocql004 = sr_s.x_t13_oocql004
       LET sr[l_cnt].x_t14_oocql004 = sr_s.x_t14_oocql004
       LET sr[l_cnt].x_t19_oocql004 = sr_s.x_t19_oocql004
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].pmaml_t_pmaml003 = sr_s.pmaml_t_pmaml003
       LET sr[l_cnt].ooidl_t_ooidl003 = sr_s.ooidl_t_ooidl003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_t20_imaal003 = sr_s.x_t20_imaal003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t17_oocal003 = sr_s.x_t17_oocal003
       LET sr[l_cnt].x_t18_oocal003 = sr_s.x_t18_oocal003
       LET sr[l_cnt].l_pmdl004_pmaal004 = sr_s.l_pmdl004_pmaal004
       LET sr[l_cnt].l_pmdl021_pmaal004 = sr_s.l_pmdl021_pmaal004
       LET sr[l_cnt].l_pmdl022_pmaal004 = sr_s.l_pmdl022_pmaal004
       LET sr[l_cnt].l_pmdl002_ooag011 = sr_s.l_pmdl002_ooag011
       LET sr[l_cnt].l_pmdl003_ooefl003 = sr_s.l_pmdl003_ooefl003
       LET sr[l_cnt].l_pmdn001_imaal004 = sr_s.l_pmdn001_imaal004
       LET sr[l_cnt].l_pmdnunit_ooefl003 = sr_s.l_pmdnunit_ooefl003
       LET sr[l_cnt].l_pmdnorga_ooefl003 = sr_s.l_pmdnorga_ooefl003
       LET sr[l_cnt].l_pmdn027_desc = sr_s.l_pmdn027_desc
       LET sr[l_cnt].l_pmdl011_desc = sr_s.l_pmdl011_desc
       LET sr[l_cnt].l_amount = sr_s.l_amount
       LET sr[l_cnt].l_pmdl025_address = sr_s.l_pmdl025_address
       LET sr[l_cnt].l_pmdl026_address = sr_s.l_pmdl026_address
       LET sr[l_cnt].l_pmdl027_tel = sr_s.l_pmdl027_tel
       LET sr[l_cnt].l_pmdl027_fax = sr_s.l_pmdl027_fax
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       #add by tangyi 160712-str
       IF NOT cl_null(sr_s.pmdn002) THEN
         LET l_imaa005=NULL
         SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent=g_enterprise and imaa001=sr_s.pmdn001
         LET l_inam012=NULL
         LET l_inam014=NULL
         LET l_inam018=NULL
       
         LET l_cnt2=1
         LET tok = base.StringTokenizer.createExt(sr_s.pmdn002,'_','',TRUE)
         WHILE tok.hasMoreTokens()
            LET l_imec003=tok.nextToken()
            LET l_imeb012='N'
            SELECT imeb012 INTO l_imeb012 FROM imeb_t
             WHERE imebent=g_enterprise AND imeb002=l_cnt2
               AND imeb001=l_imaa005
               
            CASE l_imeb012
            #纵向
            WHEN 'N'
              LET l_imecl005=NULL
              SELECT imecl005 INTO l_imecl005
                FROM imec_t LEFT OUTER JOIN imecl_t ON imecent=imeclent AND imec001=imecl001 
                            AND imec002=imecl002 AND imec003=imecl003  AND imecl004=g_lang
               WHERE imecent=g_enterprise AND imec001=l_imaa005 AND imec002=l_cnt2
                 AND imec003=l_imec003 AND imecstus = 'Y'
              IF cl_null(l_inam012) THEN
                LET l_inam012=l_imec003,'·',l_imecl005
              ELSE
                 LET l_inam012=l_inam012,'/',l_imec003,'·',l_imecl005
              END IF 
            #横向
            WHEN 'Y'
              LET l_imecl005=NULL
              SELECT imecl005 INTO l_imecl005
                FROM imec_t LEFT OUTER JOIN imecl_t ON imecent=imeclent AND imec001=imecl001 
                            AND imec002=imecl002 AND imec003=imecl003  AND imecl004=g_lang
               WHERE imecent=g_enterprise AND imec001=l_imaa005 AND imec002=l_cnt2
                 AND imec003=l_imec003 AND imecstus = 'Y'
               LET l_inam014=l_imec003,'-',l_imecl005
            otherwise
              exit while
            end case 
            LET l_cnt2=l_cnt2+1
         END WHILE
        
          IF NOT cl_null(l_inam012) AND cl_null(l_inam014) THEN
            LET l_inam014="t-*"
          END IF 
          IF NOT cl_null(l_inam012) AND NOT cl_null(l_inam014) THEN
            EXECUTE master_tmp USING sr_s.pmdldocno,sr_s.pmdn001,sr_s.x_t20_imaal003,l_inam012,l_inam014,l_inam018,sr_s.pmdn006,sr_s.pmdn007 
          END IF 
        END IF 
        #add by tangyi 160712-end-
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr500_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr500_g01_rep_data()
   DEFINE HANDLER         om.SaxDocumentHandler
   DEFINE l_i             INTEGER
 
    #判斷是否有報表資料，若回彈出訊息視窗
    IF sr.getLength() = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00285"
       LET g_errparam.extend = NULL
       LET g_errparam.popup  = FALSE
       LET g_errparam.replace[1] = ''
       CALL cl_err()  
       RETURN 
    END IF
    WHILE TRUE   
       #add-point:rep_data段印前 name="rep_data.before"
       
       #end add-point     
       LET handler = cl_gr_handler()
       IF handler IS NOT NULL THEN
          START REPORT apmr500_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT apmr500_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT apmr500_g01_rep
       END IF
       #add-point:rep_data段印完 name="rep_data.after"
       
       #end add-point       
       IF g_rep_flag = TRUE THEN
          LET g_rep_flag = FALSE
          EXIT WHILE
       END IF
    END WHILE
    #add-point:rep_data段離開while印完前 name="rep_data.end.before"
    
    #end add-point
    CALL cl_gr_close_report()
    #add-point:rep_data段離開while印完後 name="rep_data.end.after"
    
    #end add-point    
END FUNCTION
 
{</section>}
 
{<section id="apmr500_g01.rep" readonly="Y" >}
PRIVATE REPORT apmr500_g01_rep(sr1)
DEFINE sr1 sr1_r
DEFINE sr2 sr2_r
DEFINE l_subrep01_show  LIKE type_t.chr1,
       l_subrep02_show  LIKE type_t.chr1,
       l_subrep03_show  LIKE type_t.chr1,
       l_subrep04_show  LIKE type_t.chr1
DEFINE l_cnt           LIKE type_t.num10
DEFINE l_sub_sql       STRING
#add-point:rep段define  (客製用) name="rep.define_customerization"

#end add-point
#add-point:rep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep.define"
DEFINE sr3 sr3_r
DEFINE sr4 sr4_r
DEFINE sr5 sr5_r

DEFINE l_pmdl044_show     LIKE type_t.chr10
DEFINE l_pmdn027_show     LIKE type_t.chr10
DEFINE l_pmdn020_show     LIKE type_t.chr10
DEFINE l_pmdnunit_show    LIKE type_t.chr10
DEFINE l_pmdnorga_show    LIKE type_t.chr10
DEFINE l_pmdn050_show     LIKE type_t.chr10
DEFINE l_detail02_show    LIKE type_t.chr10
DEFINE l_detail03_show    LIKE type_t.chr10
DEFINE l_detail04_show    LIKE type_t.chr10

DEFINE l_pmdoseq1_o       LIKE type_t.num5
DEFINE l_item_show_o      LIKE type_t.chr1
DEFINE g_cnt              LIKE type_t.num5
DEFINE g_sql_cnt          STRING
#dorislai-20150706-add----(S)
DEFINE l_pmaal006_show    LIKE type_t.chr1
#dorislai-20150706-add----(E)
#add by tangyi 160712-str-
DEFINE sr8             sr8_r
DEFINE l_sql           STRING      
DEFINE l_inam014_cnt   LIKE type_t.num10
DEFINE l_pageno        LIKE type_t.num10
DEFINE l_i             LIKE type_t.num10
DEFINE l_inam014       LIKE type_t.chr1000 
DEFINE l_subrep08_show LIKE type_t.chr1
DEFINE l_item          LIKE type_t.chr1000
DEFINE l_pmdn007_sum   LIKE pmdn_t.pmdn007
#add by tangyi 160712-end-
DEFINE l_imaal004_show   LIKE type_t.chr1      #161031-00024#6 Add By ken 170206
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
 
    #end add-point
    ORDER EXTERNAL BY sr1.pmdldocno,sr1.pmdnseq
    #add-point:rep段ORDER_after name="rep.order.after"
    
    #end add-point
    
    FORMAT
       FIRST PAGE HEADER          
          PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
          PRINTX tm.*
          PRINTX g_grNumFmt.*
          PRINTX g_rep_wcchp
 
          #讀取beforeGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.pmdldocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.pmdldocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'pmdlent=' ,sr1.pmdlent,'{+}pmdldocno=' ,sr1.pmdldocno         
            CALL cl_gr_init_apr(sr1.pmdldocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.pmdldocno.before name="rep.b_group.pmdldocno.before"
           #dorislai-20150706-add----(S)
           LET l_pmaal006_show = ''
           IF cl_null(sr1.t5_pmaal006) AND cl_null(sr1.t2_pmaal006) AND cl_null(sr1.t1_pmaal006) THEN
              LET l_pmaal006_show = "N"
           ELSE
              LET l_pmaal006_show = "Y" 
           END IF
           PRINTX l_pmaal006_show  
           #dorislai-20150706-add----(E)
           #顯示否判斷           
           #單頭備註是否顯示
           LET l_pmdl044_show = ''
           IF cl_null(sr1.pmdl044) THEN
              LET l_pmdl044_show = "N"
           ELSE
              LET l_pmdl044_show = "Y"
           END IF
          
           
           PRINTX l_pmdl044_show        
           #mod--160922-00028#1 By shiun--(S)
#           LET g_sql = " SELECT pmdmdocno,pmdm001,pmdm002,'',pmdm003,pmdm004,pmdm005,pmdm006,0 ",
#                       "   FROM pmdm_t ",
           LET g_sql = " SELECT pmdmdocno,pmdm001,pmdm002,'',pmdm003,pmdm004,pmdm005,pmdm006,0, ",
                       "        (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '3015' AND gzcbl002 = pmdm014 AND gzcbl003 = '",g_dlang,"') ",
           #mod--160922-00028#1 By shiun--(E)
                       "   FROM pmdm_t ",
                       "  WHERE pmdment = ",sr1.pmdlent CLIPPED,
                       "    AND pmdmdocno = '",sr1.pmdldocno CLIPPED,"'",
                       "  ORDER BY pmdm001 "
           START REPORT apmr500_g01_subrep05
           DECLARE apmr500_g01_repcur05 CURSOR FROM g_sql
           FOREACH apmr500_g01_repcur05 INTO sr3.*
              IF STATUS THEN INITIALIZE g_errparam TO NULL
  LET g_errparam.code = STATUS
  LET g_errparam.extend = 'apmr500_g01_repcur05:'
  LET g_errparam.popup = TRUE
  CALL cl_err()
 EXIT FOREACH END IF

              SELECT ooibl004 INTO sr3.l_pmdm002_desc FROM ooibl_t 
               WHERE ooiblent=g_enterprise 
                 AND ooibl002 = sr3.pmdm002
                 AND ooibl003 = g_dlang

              IF sr1.pmdl013 = 'Y' THEN
                 LET sr3.l_amount = sr3.pmdm006
              ELSE
                 LET sr3.l_amount = sr3.pmdm005
              END IF

              OUTPUT TO REPORT apmr500_g01_subrep05(sr3.*)
           END FOREACH
           FINISH REPORT apmr500_g01_subrep05
           
           #161031-00024#6 Add By Ken 170206(S)
           #規格若為空，則隱藏
           INITIALIZE l_imaal004_show TO NULL
           IF cl_null(sr1.l_pmdn001_imaal004) THEN
              LET l_imaal004_show = 'N'
           ELSE
              LET l_imaal004_show = 'Y'
           END IF
           PRINTX l_imaal004_show
           #161031-00024#6 Add By Ken 170206(E)             
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.pmdlent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdldocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr500_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE apmr500_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT apmr500_g01_subrep01
           DECLARE apmr500_g01_repcur01 CURSOR FROM g_sql
           FOREACH apmr500_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr500_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT apmr500_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT apmr500_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.pmdldocno.after name="rep.b_group.pmdldocno.after"
 
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.pmdnseq
 
           #add-point:rep.b_group.pmdnseq.before name="rep.b_group.pmdnseq.before"
 
           #end add-point:
 
 
           #add-point:rep.b_group.pmdnseq.after name="rep.b_group.pmdnseq.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
 
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.pmdlent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdldocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.pmdnseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.pmdlent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdldocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.pmdnseq CLIPPED 
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr500_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE apmr500_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT apmr500_g01_subrep02
           DECLARE apmr500_g01_repcur02 CURSOR FROM g_sql
           FOREACH apmr500_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr500_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT apmr500_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT apmr500_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
            #單身 供應商料號顯示否
            IF cl_null(sr1.pmdn027) THEN 
               LET l_pmdn027_show = 'N'
            ELSE 
               LET l_pmdn027_show = 'Y'
            END IF
            
            #單身 緊急度顯示否
            IF sr1.pmdn020 = '1' OR cl_null(sr1.pmdn020) THEN
               LET l_pmdn020_show = 'N'
            ELSE
               LET l_pmdn020_show = 'Y'
            END IF
            
            IF cl_null(sr1.pmdnunit) THEN
               LET l_pmdnunit_show = 'N'
            ELSE
               LET l_pmdnunit_show = 'Y'
            END IF
            
            IF cl_null(sr1.pmdnorga) THEN
               LET l_pmdnorga_show = 'N'
            ELSE
               LET l_pmdnorga_show = 'Y'
            END IF
            
            IF cl_null(sr1.pmdn050) THEN
               LET l_pmdn050_show = 'N'
            ELSE
               LET l_pmdn050_show = 'Y'
            END IF
            
            #收貨據點跟採購單的pmdlsite不一樣時則需要增加列印收貨據點資訊
            IF sr1.pmdnunit = sr1.pmdlsite THEN
               LET l_pmdnunit_show = 'N'
               LET sr1.l_pmdnunit_ooefl003 = ''
            END IF
            #付款據點跟採購單的pmdlsite不一樣時則需要增加列印付款據點資訊
            IF sr1.pmdnorga = sr1.pmdlsite THEN
               LET l_pmdnorga_show = 'N'
               LET sr1.l_pmdnorga_ooefl003 = ''
            END IF
            
            IF cl_null(sr1.x_t20_imaal003) AND l_pmdn027_show = 'N' AND l_pmdn020_show = 'N' THEN
               LET l_detail02_show = 'N'
            ELSE
               LET l_detail02_show = 'Y'
            END IF
            
            IF cl_null(sr1.l_pmdn001_imaal004) AND l_pmdnunit_show = 'N' THEN
               LET l_detail03_show = 'N'
            ELSE 
               LET l_detail03_show = 'Y'
            END IF
            
            IF cl_null(sr1.pmdn002) AND l_pmdnorga_show = 'N' THEN
               LET l_detail04_show = 'N'
            ELSE
               LET l_detail04_show = 'Y'
            END IF

            PRINTX l_pmdn027_show,l_pmdn020_show,l_pmdnunit_show,l_pmdnorga_show,l_pmdn050_show,l_detail02_show,
                   l_detail03_show,l_detail04_show
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
            START REPORT apmr500_g01_subrep06
            IF NOT cl_null(sr1.pmdnseq) AND sr1.pmdnseq > 0 THEN
               LET g_sql = "SELECT pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdo001,pmdo002,pmdo003, ",
                           "       pmdo004,pmdo006,pmdo011,NULL,NULL,NULL,'0' ",
                           "  FROM pmdo_t ",
                           " WHERE pmdoent = ",sr1.pmdlent CLIPPED,
                           "   AND pmdodocno = '",sr1.pmdldocno CLIPPED,"' ",
                           "   AND pmdoseq = ",sr1.pmdnseq CLIPPED,
                           " ORDER BY pmdoseq1,pmdoseq2 "
               LET g_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
               PREPARE apmr500_g01_subrep06_cnt_pre FROM g_sql_cnt

               LET g_cnt = 0
               EXECUTE apmr500_g01_subrep06_cnt_pre INTO g_cnt
               FREE apmr500_g01_subrep06_cnt_pre

               IF g_cnt > 1 THEN

                  LET g_sql_cnt = g_sql_cnt CLIPPED," WHERE pmdo003 <> '1' "
                  PREPARE apmr500_g01_subrep06_cnt_pre01 FROM g_sql_cnt
                  LET g_cnt = 0
                  EXECUTE apmr500_g01_subrep06_cnt_pre01 INTO g_cnt
                  FREE apmr500_g01_subrep06_cnt_pre01

                  LET l_pmdoseq1_o = 0
                  DECLARE apmr500_g01_repcur06 CURSOR FROM g_sql
                  FOREACH apmr500_g01_repcur06 INTO sr4.*
                     IF STATUS THEN INITIALIZE g_errparam TO NULL
  LET g_errparam.code = STATUS
  LET g_errparam.extend = 'apmr500_g01_repcur03:'
  LET g_errparam.popup = TRUE
  CALL cl_err()
 EXIT FOREACH END IF

                     #顯示項序、料件編號
                     IF g_cnt > 0 THEN
                        LET sr4.l_item_show = '1'
                  
                        SELECT imaal003,imaal004 INTO sr4.imaal003,sr4.imaal004
                          FROM imaal_t
                         WHERE imaalent = g_enterprise
                           AND imaal001 = sr4.pmdo001
                           AND imaal002 = g_dlang
                        
                        IF sr4.pmdoseq1 = l_pmdoseq1_o THEN
                           LET sr4.l_pmdo003_desc = ''
                           LET sr4.pmdoseq1= ''
                           LET sr4.pmdo001 = ''
                           #隱藏品名、規格、產品特徵
                           LET sr4.l_item_show = '2'                        
                        ELSE
                           #隱藏產品特徵
                           IF cl_null(sr4.pmdo002) THEN
                              LET sr4.l_item_show = '3'
                           END IF
                        END IF
                     END IF
                     
                     #子件特性
                     #如果不要將內存值外顯再解開
                     #SELECT gzcbl004 INTO sr4.l_pmdo003_desc
                      SELECT gzcb002||"."||gzcbl004 INTO sr4.l_pmdo003_desc
                       FROM gzcb_t,gzcbl_t
                      WHERE gzcb001 = gzcbl001 AND gzcb002 = gzcbl002
                        AND gzcb001 = '2055'   AND gzcbl003 = g_dlang
                        AND gzcb002 = sr4.pmdo003
                     OUTPUT TO REPORT apmr500_g01_subrep06(sr4.*)
                     LET l_pmdoseq1_o = sr4.pmdoseq1
                     LET l_item_show_o = sr4.l_item_show
                  END FOREACH
               END IF
            END IF
            FINISH REPORT apmr500_g01_subrep06
            
            START REPORT apmr500_g01_subrep07
            IF tm.c1 = 'Y' THEN
               IF NOT cl_null(sr1.pmdnseq) AND sr1.pmdnseq > 0 THEN
                  LET g_sql = " SELECT pmdpdocno,pmdpseq,pmdpseq1,pmdp003,pmdp004,pmdp005,pmdp006,pmdp023,pmdp022",
                              "   FROM pmdp_t ",
                              "  WHERE pmdpent = ",sr1.pmdlent CLIPPED,
                              "    AND pmdpdocno = '",sr1.pmdldocno CLIPPED,"'",
                              "    AND pmdpseq = ",sr1.pmdnseq CLIPPED,
                              "  ORDER BY pmdpseq "
                  DECLARE apmr500_g01_repcur07 CURSOR FROM g_sql
                  FOREACH apmr500_g01_repcur07 INTO sr5.*
                     IF STATUS THEN INITIALIZE g_errparam TO NULL
  LET g_errparam.code = STATUS
  LET g_errparam.extend = 'apmr500_g01_repcur07:'
  LET g_errparam.popup = TRUE
  CALL cl_err()
 EXIT FOREACH END IF
                     OUTPUT TO REPORT apmr500_g01_subrep07(sr5.*)
                  END FOREACH
               END IF
            END IF
            FINISH REPORT apmr500_g01_subrep07          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.pmdlent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdldocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.pmdnseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.pmdlent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdldocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.pmdnseq CLIPPED 
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr500_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE apmr500_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT apmr500_g01_subrep03
           DECLARE apmr500_g01_repcur03 CURSOR FROM g_sql
           FOREACH apmr500_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr500_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT apmr500_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT apmr500_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmdldocno
 
           #add-point:rep.a_group.pmdldocno.before name="rep.a_group.pmdldocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.pmdlent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdldocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr500_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE apmr500_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT apmr500_g01_subrep04
           DECLARE apmr500_g01_repcur04 CURSOR FROM g_sql
           FOREACH apmr500_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr500_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr500_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT apmr500_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.pmdldocno.after name="rep.a_group.pmdldocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmdnseq
 
           #add-point:rep.a_group.pmdnseq.before name="rep.a_group.pmdnseq.before"
            #add by tangyi 160712-str-
           DROP TABLE inam014_tmp
          CREATE TEMP TABLE inam014_tmp
          (
           i          decimal(5,0),
           inam014    LIKE type_t.chr1000
           )

          DROP TABLE pmdn_print_tmp         
          CREATE TEMP TABLE pmdn_print_tmp
          (
           pmdldocno  LIKE pmdl_t.pmdldocno,          #單號 
           item       LIKE type_t.chr100,
           imaal003   LIKE imaal_t.imaal003,          #品名
           inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
           inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
           inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)           
           pmdn006    LIKE pmdn_t.pmdn006,            #單位
           pmdn0071   LIKE pmdn_t.pmdn007,            #數量1
           pmdn0072   LIKE pmdn_t.pmdn007,            #數量2
           pmdn0073   LIKE pmdn_t.pmdn007,            #數量3
           pmdn0074   LIKE pmdn_t.pmdn007,            #數量4
           pmdn0075   LIKE pmdn_t.pmdn007,            #數量5
           pmdn0076   LIKE pmdn_t.pmdn007,            #數量6
           pmdn0077   LIKE pmdn_t.pmdn007,            #數量7
           pmdn0078   LIKE pmdn_t.pmdn007,            #數量8
           pmdn0079   LIKE pmdn_t.pmdn007,            #數量9
           pmdn0070   LIKE pmdn_t.pmdn007,            #數量10
           l_skip     LIKE type_t.chr1             
          )
   
          LET l_sub_sql = " SELECT DISTINCT inam014 FROM apmr500_g01_temp02 ",
                      " WHERE pmdldocno=? and imaal003=? and item=? ",
                      " ORDER BY inam014"
          PREPARE inam014_ins FROM l_sub_sql
          DECLARE inam014_ins_cs CURSOR FOR inam014_ins

          #計算橫軸個數
          LET l_sql = "SELECT COUNT(1) FROM (",l_sub_sql,")"
          PREPARE inam014_cnt_pre FROM l_sql            
          
          EXECUTE inam014_cnt_pre INTO l_inam014_cnt USING sr1.pmdldocno,sr1.x_t20_imaal003,sr1.pmdn001
          FREE inam014_cnt_pre
             
           --总合计
           
          LET l_sub_sql = " SELECT SUM(pmdn007) FROM apmr500_g01_temp02 ",
                      " WHERE pmdldocno=? "
          PREPARE pmdn007_total_sum FROM l_sub_sql        
          
          #總計(合計)   
          LET l_sub_sql = " SELECT SUM(pmdn007) FROM apmr500_g01_temp02 ",
                      " WHERE pmdldocno=? and imaal003=? and item=? "
          PREPARE pmdn007_total FROM l_sub_sql
       
              
          IF NOT cl_null(l_inam014_cnt) THEN
             LET l_pageno = (l_inam014_cnt -1)/10   #每頁10筆
             LET l_pageno = l_pageno +1
         
             DELETE FROM inam014_tmp WHERE 1=1
             OPEN inam014_ins_cs USING sr1.pmdldocno,sr1.x_t20_imaal003,sr1.pmdn001
             LET l_i=1
             FOREACH inam014_ins_cs INTO l_inam014
                INSERT INTO inam014_tmp VALUES(l_i,l_inam014)
                LET l_i=l_i+1
             END FOREACH
          
             FOR l_i = 1 to l_pageno
                CALL apmr500_g01_ins_erwei_temp(sr1.pmdldocno,sr1.x_t20_imaal003,l_i,sr1.pmdn001)
             END FOR  
          END IF           
          
           
          LET g_sql = " SELECT A.*,",sr1.pmdn015," FROM pmdn_print_tmp A WHERE 1=1 "
          LET l_cnt = 0
          LET l_sub_sql = ""
          LET l_subrep08_show ="N"
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE apmr500_g01_repcur08_cnt_pre FROM l_sub_sql
          EXECUTE apmr500_g01_repcur08_cnt_pre INTO l_cnt
          IF l_cnt > 0 THEN 
              LET l_subrep08_show ="Y"
          END IF
          --调用子报表
          PRINTX l_subrep08_show 
          START REPORT apmr500_g01_subrep08
          LET g_sql=g_sql," ORDER BY 1,3,4 "
          DECLARE apmr500_g01_repcur08 CURSOR FROM g_sql
          FOREACH apmr500_g01_repcur08 INTO sr8.*
             IF STATUS THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "apmr500_g01_repcur08:"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = FALSE
                CALL cl_err()                  
                EXIT FOREACH 
             END IF
             
             OUTPUT TO REPORT apmr500_g01_subrep08(sr8.*) --subrep05中印出
          END FOREACH
          FINISH REPORT apmr500_g01_subrep08  
          
          --打印总合计
          LET l_pmdn007_sum=0
          LET l_total=0
          EXECUTE pmdn007_total INTO l_pmdn007_sum USING sr1.pmdldocno,sr1.x_t20_imaal003,sr1.pmdn001
          let l_total=l_pmdn007_sum*sr1.pmdn015
          PRINTX l_pmdn007_sum
          PRINTX l_total  
           #add by tangyi 160712-end-
    
           #end add-point:
 
 
           #add-point:rep.a_group.pmdnseq.after name="rep.a_group.pmdnseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="apmr500_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr500_g01_subrep01(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub01.define_customerization" 

#end add-point
#add-point:sub01.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub01.define" 

#end add-point:sub01.define
 
    #add-point:sub01.order.before name="sub01.order.before" 
    
    #end add-point:sub01.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub01.everyrow.before name="sub01.everyrow.before" 
                          
            #end add-point:sub01.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub01.everyrow.after name="sub01.everyrow.after" 
            
            #end add-point:sub01.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr500_g01_subrep02(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub02.define_customerization" 

#end add-point
#add-point:sub02.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub02.define" 

#end add-point:sub02.define
 
    #add-point:sub02.order.before name="sub02.order.before" 
    
    #end add-point:sub02.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub02.everyrow.before name="sub02.everyrow.before" 
                          
            #end add-point:sub02.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub02.everyrow.after name="sub02.everyrow.after" 
            
            #end add-point:sub02.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr500_g01_subrep03(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub03.define_customerization" 

#end add-point
#add-point:sub03.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub03.define" 

#end add-point:sub03.define
 
    #add-point:sub03.order.before name="sub03.order.before" 
    
    #end add-point:sub03.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub03.everyrow.before name="sub03.everyrow.before" 
                          
            #end add-point:sub03.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub03.everyrow.after name="sub03.everyrow.after" 
            
            #end add-point:sub03.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr500_g01_subrep04(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub04.define_customerization" 

#end add-point
#add-point:sub04.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub04.define" 

#end add-point:sub04.define
 
    #add-point:sub04.order.before name="sub04.order.before" 
    
    #end add-point:sub04.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub04.everyrow.before name="sub04.everyrow.before" 
                          
            #end add-point:sub04.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub04.everyrow.after name="sub04.everyrow.after" 
            
            #end add-point:sub04.everyrow.after
 
 
END REPORT
 
 
 
 
{</section>}
 
{<section id="apmr500_g01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 當編號為空時清空編號.說明字串
# Usage..........: CALL apmr500_g01_initialize(p_arg,p_exp)
#                  RETURNING r_exp
# Input parameter: p_arg   編號
#                : p_exp   編號.說明
# Return code....: r_exp   編號.說明
# Date & Author..: 2015/02/04 By Shiun
################################################################################
PRIVATE FUNCTION apmr500_g01_initialize(p_arg,p_exp)
DEFINE p_arg   STRING
DEFINE p_exp   STRING
DEFINE r_exp   STRING
   IF cl_null(p_arg) THEN
      INITIALIZE r_exp TO NULL
   ELSE
      LET r_exp = p_exp
   END IF
RETURN r_exp
END FUNCTION

################################################################################
# Descriptions...: 取得聯絡人聯絡方式
# Memo...........:
# Usage..........: apmr500_g01_get_oofc012(p_pmdl027,p_flag)
#                  RETURNING r_success,r_oofc012
# Input parameter: p_pmdl027   聯絡對象
#                : p_flag      聯絡方式(1=電話、3=傳真)
# Return code....: r_oofc012   通訊內容
# Date & Author..: 2015/08/06  By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr500_g01_get_oofc012(p_pmdl027,p_flag)
DEFINE p_pmdl027  LIKE pmdl_t.pmdl027
DEFINE p_flag     LIKE oofc_t.oofc008
DEFINE r_oofc012  LIKE oofc_t.oofc012
DEFINE l_count    LIKE type_t.num5

   LET r_oofc012 = ''
   LET l_count = 0
   SELECT COUNT(*) INTO l_count
     FROM oofc_t
    WHERE oofcent = g_enterprise
      AND oofcstus = 'Y'
      AND oofc002 = p_pmdl027
      AND oofc008 = p_flag
      
   CASE l_count
      WHEN 0
      
      WHEN 1
         SELECT oofc012 INTO r_oofc012
           FROM oofc_t
          WHERE oofcent = g_enterprise
            AND oofcstus = 'Y'
            AND oofc002 = p_pmdl027
            AND oofc008 = p_flag
            
      OTHERWISE
         SELECT oofc012 INTO r_oofc012
           FROM oofc_t
          WHERE oofcent = g_enterprise
            AND oofcstus = 'Y'
            AND oofc002 = p_pmdl027
#160914-00017#1-s mod
#            AND oofc008 = '1'
#            AND oofc010 = p_flag
            AND oofc008 = p_flag   #聯絡方式
            AND oofc010 = 'Y'      #主要聯絡方式='Y'
#160914-00017#1-e mod
   END CASE
   
   RETURN r_oofc012
END FUNCTION

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
PRIVATE FUNCTION apmr500_g01_erwei_tmp_table()
   
   #add by tangyi 160712
   
   DROP TABLE apmr500_g01_temp02;

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'apmr500_g01_temp02'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   CREATE TEMP TABLE apmr500_g01_temp02(  
                   pmdldocno  LIKE pmdl_t.pmdldocno,          #單號  
                   item       LIKE type_t.chr100,             #料件编号
                   imaal003   LIKE imaal_t.imaal003,          #品名
                   inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
                   inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
                   inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)
                   pmdn006    LIKE pmdn_t.pmdn006,            #單位                  
                   pmdn007    LIKE pmdn_t.pmdn007             #數量                  
                   )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apmr500_g01_temp02'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
END FUNCTION

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
PRIVATE FUNCTION apmr500_g01_ins_erwei_temp(p_pmdldocno,p_imaal003,p_i,p_item)
#add by tangyi 160712
--計算交叉表數值區資料總和
DEFINE p_pmdldocno  LIKE pmdl_t.pmdldocno
DEFINE p_imaal003   LIKE imaal_t.imaal003
DEFINE p_item       LIKE type_t.chr100
DEFINE p_i          LIKE type_t.num5
DEFINE l_n          LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5
DEFINE l_max        LIKE type_t.num5
DEFINE l_max2       LIKE type_t.num5
DEFINE l_a          LIKE type_t.num5
DEFINE l_b          LIKE type_t.num5
DEFINE l_sql        STRING
DEFINE l_pmdn007    STRING
DEFINE l_vi         varchar(3)
DEFINE i          LIKE type_t.num5

   CALL g_inam014.clear()

   SELECT COUNT(DISTINCT inam014) INTO l_n FROM apmr500_g01_temp02
         WHERE pmdldocno=p_pmdldocno AND imaal003 = p_imaal003 AND item = p_item
   LET l_i = (l_n-1)/10
   LET l_i = l_i +1
   IF l_i = p_i THEN
      LET l_max = l_n
   ELSE
      LET l_max = p_i*10
   END IF

   IF l_max mod 10 = 0 THEN 
      LET l_max2 = 10
   ELSE
      LET l_max2 = l_max mod 10
   END IF

   LET l_a = p_i*10-9
   LET l_b = p_i*10
   LET l_sql = " SELECT inam014 FROM inam014_tmp",
               " WHERE i >=? and i<=? ",
               " ORDER BY i"
   PREPARE inam014_pr FROM l_sql
   DECLARE inam014_cs CURSOR FOR inam014_pr
   OPEN inam014_cs USING l_a,l_b
   LET i=1
   FOREACH inam014_cs INTO g_inam014[i]
      IF i = l_max2 THEN
         EXIT FOREACH
      ELSE
         LET i=i+1
      END IF
   END FOREACH
   
   LET l_sql = " INSERT INTO pmdn_print_tmp(pmdldocno,item,imaal003,inam012,inam014,inam018,pmdn006  "
   FOR i=1 to l_max2
      CASE i WHEN 1 LET l_pmdn007 = 'pmdn0071'
             WHEN 2 LET l_pmdn007 = 'pmdn0072'
             WHEN 3 LET l_pmdn007 = 'pmdn0073'
             WHEN 4 LET l_pmdn007 = 'pmdn0074'
             WHEN 5 LET l_pmdn007 = 'pmdn0075'
             WHEN 6 LET l_pmdn007 = 'pmdn0076'
             WHEN 7 LET l_pmdn007 = 'pmdn0077'
             WHEN 8 LET l_pmdn007 = 'pmdn0078'
             WHEN 9 LET l_pmdn007 = 'pmdn0079'           
             WHEN 10 LET l_pmdn007 = 'pmdn0070'
      END CASE
      LET l_sql = l_sql , ",",l_pmdn007
   END FOR
   
   LET l_sql = l_sql," ) SELECT pmdldocno,item,imaal003,inam012,'','',pmdn006 "
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql," ,sum(A",l_vi,")"
   END FOR
   LET l_sql = l_sql,"  FROM ( SELECT pmdldocno,item,imaal003,inam012,inam014,inam018,pmdn006 "
 
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql,",CASE WHEN inam014 = '",g_inam014[i],"'",
                        " THEN pmdn007 ELSE 0 END A",l_vi
   END FOR
   LET l_sql = l_sql,  "  FROM apmr500_g01_temp02 ",
               " WHERE pmdldocno='",p_pmdldocno,"'",
               "   AND imaal003 = '",p_imaal003,"'",
               "   AND item = '",p_item,"'",
               "   ) "
               ," GROUP BY pmdldocno,imaal003,inam012,pmdn006,item "
                              
   PREPARE pmdn_print_pr FROM l_sql
   
   DELETE FROM pmdn_print_tmp WHERE 1=1
   EXECUTE pmdn_print_pr
   
  UPDATE pmdn_print_tmp 
      SET l_skip = "N"
      WHERE pmdldocno = p_pmdldocno AND imaal003 = p_imaal003 AND inam014 = g_inam014[l_max2] AND item = p_item
   
END FUNCTION

 
{</section>}
 
{<section id="apmr500_g01.other_report" readonly="Y" >}
################################################################################
# Descriptions...: 多帳期子報表
# Memo...........:
# Usage..........: CALL apmr500_g01_subrep05(sr3)
#                  
# Input parameter: sr3            資料RECORD
# Return code....: 
# Date & Author..: 2014/05/06 By benson
# Modify.........:
################################################################################
REPORT apmr500_g01_subrep05(sr3)
DEFINE sr3             sr3_r

   ORDER EXTERNAL BY sr3.pmdmdocno
      FORMAT

         ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT
################################################################################
# Descriptions...: 多交期報表
# Memo...........:
# Usage..........: CALL apmr500_g01_subrep06(sr4)
# Input parameter: sr4            資料RECORD
# Return code....: 
# Date & Author..: 2014/05/06 By benson
# Modify.........:
################################################################################
REPORT apmr500_g01_subrep06(sr4)
DEFINE sr4             sr4_r

   ORDER EXTERNAL BY sr4.pmdodocno,sr4.pmdoseq
      FORMAT

         ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
END REPORT
################################################################################
# Descriptions...: 關聯單據報表
# Memo...........:
# Usage..........: CALL apmr500_g01_subrep07(sr5) 
# Input parameter: sr5            資料RECORD
# Return code....: 
#                : 
# Date & Author..: 2014/05/06 By benson
# Modify.........:
################################################################################
REPORT apmr500_g01_subrep07(sr5)
DEFINE sr5             sr5_r

   ORDER EXTERNAL BY sr5.pmdpdocno,sr5.pmdpseq
      FORMAT

         ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT

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
PRIVATE REPORT apmr500_g01_subrep08(sr8)
#add by tangyi 160712
DEFINE sr8 sr8_r
DEFINE l_inam0141      LIKE type_t.chr1000
DEFINE l_inam0142      LIKE type_t.chr1000
DEFINE l_inam0143      LIKE type_t.chr1000
DEFINE l_inam0144      LIKE type_t.chr1000
DEFINE l_inam0145      LIKE type_t.chr1000
DEFINE l_inam0146      LIKE type_t.chr1000
DEFINE l_inam0147      LIKE type_t.chr1000
DEFINE l_inam0148      LIKE type_t.chr1000
DEFINE l_inam0149      LIKE type_t.chr1000
DEFINE l_inam01410     LIKE type_t.chr1000
DEFINE l_pmdn007_sum   LIKE type_t.num15_3
DEFINE l_pmdn007_total LIKE type_t.num15_3
DEFINE l_pmdn015_total LIKE type_t.num20_6
DEFINE l_sum r_sum
DEFINE l_title         LIKE type_t.chr1000
DEFINE l_sql           LIKE type_t.chr1000

    ORDER EXTERNAL BY sr8.pmdldocno
    FORMAT
        BEFORE GROUP OF sr8.pmdldocno  --子報表中動態顯示title及計算總和
           SELECT substr(g_inam014[1],instr(g_inam014[1],'-')+1,Length(g_inam014[1])) INTO l_inam0141 from dual         
           SELECT substr(g_inam014[2],instr(g_inam014[2],'-')+1,Length(g_inam014[2])) INTO l_inam0142  FROM DUAL 
           SELECT substr(g_inam014[3],instr(g_inam014[3],'-')+1,Length(g_inam014[3])) INTO l_inam0143  FROM DUAL 
           SELECT substr(g_inam014[4],instr(g_inam014[4],'-')+1,Length(g_inam014[4])) INTO l_inam0144  FROM DUAL 
           SELECT substr(g_inam014[5],instr(g_inam014[5],'-')+1,Length(g_inam014[5])) INTO l_inam0145  FROM DUAL 
           SELECT substr(g_inam014[6],instr(g_inam014[6],'-')+1,Length(g_inam014[6])) INTO l_inam0146  FROM DUAL 
           SELECT substr(g_inam014[7],instr(g_inam014[7],'-')+1,Length(g_inam014[7])) INTO l_inam0147  FROM DUAL 
           SELECT substr(g_inam014[8],instr(g_inam014[8],'-')+1,Length(g_inam014[8])) INTO l_inam0148  FROM DUAL 
           SELECT substr(g_inam014[9],instr(g_inam014[9],'-')+1,Length(g_inam014[9])) INTO l_inam0149  FROM DUAL 
           SELECT substr(g_inam014[10],instr(g_inam014[10],'-')+1,Length(g_inam014[10])) INTO l_inam01410  FROM DUAL 
           INITIALIZE l_sum.* TO NULL
           LET l_title=NULL
           LET l_sql=
           "select  listagg(oocql004,'/') within group(order by imeb001,imeb002) ",
           "  from imeb_t,oocql_t ",
           " where imebent=oocqlent ",
           "   and oocql001='273' ",
           "   and oocql002=imeb004 ",
           "   and imeb001=(SELECT DISTINCT imaa005 FROM imaa_t WHERE imaaent='",g_enterprise,"' AND imaa001='",sr8.item,"') ",
           "   and imebent='",g_enterprise,"' ",
           "   and imeb012='N'",
           "   and oocql003='",g_dlang,"'"
           PREPARE apmr500_g01_title_pre FROM l_sql
           EXECUTE apmr500_g01_title_pre into l_title

           PRINTX l_inam0141
           PRINTX l_inam0142
           PRINTX l_inam0143
           PRINTX l_inam0144
           PRINTX l_inam0145
           PRINTX l_inam0146
           PRINTX l_inam0147
           PRINTX l_inam0148
           PRINTX l_inam0149
           PRINTX l_inam01410    
           PRINTX l_title           

        ON EVERY ROW
            PRINTX g_grNumFmt.*
            #SELECT substr(sr8.inam012,instr(sr8.inam012,'-')+1,Length(sr8.inam012)) INTO sr8.inam012  FROM DUAL 
            PRINTX sr8.*
            LET l_pmdn007_sum = 0
            IF cl_null(sr8.pmdn0071) THEN LET sr8.pmdn0071 = 0 END IF            
            IF cl_null(sr8.pmdn0072) THEN LET sr8.pmdn0072 = 0 END IF            
            IF cl_null(sr8.pmdn0073) THEN LET sr8.pmdn0073 = 0 END IF           
            IF cl_null(sr8.pmdn0074) THEN LET sr8.pmdn0074 = 0 END IF            
            IF cl_null(sr8.pmdn0075) THEN LET sr8.pmdn0075 = 0 END IF            
            IF cl_null(sr8.pmdn0076) THEN LET sr8.pmdn0076 = 0 END IF          
            IF cl_null(sr8.pmdn0077) THEN LET sr8.pmdn0077 = 0 END IF            
            IF cl_null(sr8.pmdn0078) THEN LET sr8.pmdn0078 = 0 END IF            
            IF cl_null(sr8.pmdn0079) THEN LET sr8.pmdn0079 = 0 END IF           
            IF cl_null(sr8.pmdn0070) THEN LET sr8.pmdn0070 = 0 END IF              
            
            #横向小計
            LET l_pmdn007_sum = sr8.pmdn0071+sr8.pmdn0072+sr8.pmdn0073+sr8.pmdn0074+sr8.pmdn0075+sr8.pmdn0076+sr8.pmdn0077+sr8.pmdn0078+sr8.pmdn0079+sr8.pmdn0070
            PRINTX l_pmdn007_sum  
            #纵向小计
            IF cl_null(l_sum.sum01) THEN LET  l_sum.sum01= 0 END IF            
            IF cl_null(l_sum.sum02) THEN LET  l_sum.sum02= 0 END IF            
            IF cl_null(l_sum.sum03) THEN LET  l_sum.sum03= 0 END IF           
            IF cl_null(l_sum.sum04) THEN LET  l_sum.sum04= 0 END IF            
            IF cl_null(l_sum.sum05) THEN LET  l_sum.sum05= 0 END IF            
            IF cl_null(l_sum.sum06) THEN LET  l_sum.sum06= 0 END IF          
            IF cl_null(l_sum.sum07) THEN LET  l_sum.sum07= 0 END IF            
            IF cl_null(l_sum.sum08) THEN LET  l_sum.sum08= 0 END IF            
            IF cl_null(l_sum.sum09) THEN LET  l_sum.sum09= 0 END IF           
            IF cl_null(l_sum.sum10) THEN LET  l_sum.sum10= 0 END IF
            IF cl_null(l_sum.sum11) THEN LET  l_sum.sum11= 0 END IF
            LET l_sum.sum01=l_sum.sum01+ sr8.pmdn0071 
            LET l_sum.sum02=l_sum.sum02+ sr8.pmdn0072 
            LET l_sum.sum03=l_sum.sum03+ sr8.pmdn0073 
            LET l_sum.sum04=l_sum.sum04+ sr8.pmdn0074 
            LET l_sum.sum05=l_sum.sum05+ sr8.pmdn0075 
            LET l_sum.sum06=l_sum.sum06+ sr8.pmdn0076 
            LET l_sum.sum07=l_sum.sum07+ sr8.pmdn0077 
            LET l_sum.sum08=l_sum.sum08+ sr8.pmdn0078 
            LET l_sum.sum09=l_sum.sum09+ sr8.pmdn0079 
            LET l_sum.sum10=l_sum.sum10+ sr8.pmdn0070 
                                  
            #金额
            LET l_pmdn015_total=l_pmdn007_sum*sr8.pmdn015
            PRINTX l_pmdn015_total
            
            
        AFTER GROUP OF sr8.pmdldocno
            #横向总计
            EXECUTE pmdn007_total INTO l_pmdn007_total USING sr8.pmdldocno,sr8.imaal003,sr8.item
            IF cl_null(l_pmdn007_total) THEN LET l_pmdn007_total = 0 END IF
            PRINTX l_pmdn007_total                   
            #总数量
            EXECUTE pmdn007_total_sum INTO l_total USING sr8.pmdldocno
            IF cl_null(l_total) THEN LET l_total = 0 END IF
            #纵向小计
            LET l_sum.sum11=l_sum.sum01+l_sum.sum02+l_sum.sum03+l_sum.sum04+l_sum.sum05+l_sum.sum06+l_sum.sum07+l_sum.sum08+l_sum.sum09+l_sum.sum10
            PRINTX l_sum.*

END REPORT

 
{</section>}
 
