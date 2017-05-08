#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr500_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:20(2017-02-02 10:34:23), PR版次:0020(2017-02-06 12:04:09)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000250
#+ Filename...: axmr500_g01
#+ Description: ...
#+ Creator....: 01588(2014-04-22 09:49:04)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="axmr500_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160922-00035#1   2016/10/06  By  dorislai  嘜頭原本抓取客戶編號，要換抓取收貨客戶
#160922-00028#1   2016/10/13  By  shiun     多帳期子報表在期別與付款條件中間增加顯示帳款類型
#161207-00033#9   2016/12/22  By  08993     一次性交易對象名稱顯示要改抓pmak003
#161205-00042#2   2016/12/23 By 08992        嘜頭預設圖片設置、圖中字位置設定
#161031-00024#1   2017/02/02 By 06137       2.報表畫面增加"列印額外品名規格"選項
#                                           2-1.打勾時，依料件編號+單別參數"額外品名規格類型"，串到aimm221抓取資料
#                                           2-2.有抓到值時，原品名規格資料不印，改印額外品名規格資料，額外品名規格資料依行序+換行符號組成一個大字串放至品名中
#                                           2-3.沒抓到值，印原品名規格
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"
IMPORT util   #161205-00042#2 add
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   xmda001 LIKE xmda_t.xmda001, 
   xmda002 LIKE xmda_t.xmda002, 
   xmda003 LIKE xmda_t.xmda003, 
   xmda004 LIKE xmda_t.xmda004, 
   xmda005 LIKE xmda_t.xmda005, 
   xmda006 LIKE xmda_t.xmda006, 
   xmda007 LIKE xmda_t.xmda007, 
   xmda008 LIKE xmda_t.xmda008, 
   xmda009 LIKE xmda_t.xmda009, 
   xmda010 LIKE xmda_t.xmda010, 
   xmda011 LIKE xmda_t.xmda011, 
   xmda012 LIKE xmda_t.xmda012, 
   xmda013 LIKE xmda_t.xmda013, 
   xmda015 LIKE xmda_t.xmda015, 
   xmda016 LIKE xmda_t.xmda016, 
   xmda017 LIKE xmda_t.xmda017, 
   xmda018 LIKE xmda_t.xmda018, 
   xmda019 LIKE xmda_t.xmda019, 
   xmda020 LIKE xmda_t.xmda020, 
   xmda021 LIKE xmda_t.xmda021, 
   xmda022 LIKE xmda_t.xmda022, 
   xmda023 LIKE xmda_t.xmda023, 
   xmda024 LIKE xmda_t.xmda024, 
   xmda025 LIKE xmda_t.xmda025, 
   xmda026 LIKE xmda_t.xmda026, 
   xmda027 LIKE xmda_t.xmda027, 
   xmda028 LIKE xmda_t.xmda028, 
   xmda030 LIKE xmda_t.xmda030, 
   xmda031 LIKE xmda_t.xmda031, 
   xmda032 LIKE xmda_t.xmda032, 
   xmda033 LIKE xmda_t.xmda033, 
   xmda034 LIKE xmda_t.xmda034, 
   xmda035 LIKE xmda_t.xmda035, 
   xmda036 LIKE xmda_t.xmda036, 
   xmda037 LIKE xmda_t.xmda037, 
   l_xmda037_desc LIKE type_t.chr100, 
   xmda038 LIKE xmda_t.xmda038, 
   l_xmda038_desc LIKE type_t.chr100, 
   xmda039 LIKE xmda_t.xmda039, 
   xmda041 LIKE xmda_t.xmda041, 
   xmda042 LIKE xmda_t.xmda042, 
   xmda043 LIKE xmda_t.xmda043, 
   xmda044 LIKE xmda_t.xmda044, 
   xmda045 LIKE xmda_t.xmda045, 
   xmda046 LIKE xmda_t.xmda046, 
   xmda047 LIKE xmda_t.xmda047, 
   xmda071 LIKE xmda_t.xmda071, 
   xmdadocdt LIKE xmda_t.xmdadocdt, 
   xmdadocno LIKE xmda_t.xmdadocno, 
   xmdaent LIKE xmda_t.xmdaent, 
   xmdasite LIKE xmda_t.xmdasite, 
   xmdastus LIKE xmda_t.xmdastus, 
   xmdc001 LIKE xmdc_t.xmdc001, 
   xmdc002 LIKE xmdc_t.xmdc002, 
   xmdc003 LIKE xmdc_t.xmdc003, 
   xmdc004 LIKE xmdc_t.xmdc004, 
   xmdc005 LIKE xmdc_t.xmdc005, 
   xmdc006 LIKE xmdc_t.xmdc006, 
   xmdc007 LIKE xmdc_t.xmdc007, 
   xmdc008 LIKE xmdc_t.xmdc008, 
   xmdc009 LIKE xmdc_t.xmdc009, 
   xmdc010 LIKE xmdc_t.xmdc010, 
   xmdc011 LIKE xmdc_t.xmdc011, 
   xmdc012 LIKE xmdc_t.xmdc012, 
   xmdc013 LIKE xmdc_t.xmdc013, 
   xmdc015 LIKE xmdc_t.xmdc015, 
   xmdc016 LIKE xmdc_t.xmdc016, 
   xmdc017 LIKE xmdc_t.xmdc017, 
   xmdc019 LIKE xmdc_t.xmdc019, 
   xmdc020 LIKE xmdc_t.xmdc020, 
   xmdc021 LIKE xmdc_t.xmdc021, 
   xmdc022 LIKE xmdc_t.xmdc022, 
   xmdc023 LIKE xmdc_t.xmdc023, 
   xmdc024 LIKE xmdc_t.xmdc024, 
   xmdc025 LIKE xmdc_t.xmdc025, 
   xmdc026 LIKE xmdc_t.xmdc026, 
   xmdc027 LIKE xmdc_t.xmdc027, 
   xmdc028 LIKE xmdc_t.xmdc028, 
   xmdc029 LIKE xmdc_t.xmdc029, 
   xmdc030 LIKE xmdc_t.xmdc030, 
   xmdc031 LIKE xmdc_t.xmdc031, 
   xmdc032 LIKE xmdc_t.xmdc032, 
   xmdc033 LIKE xmdc_t.xmdc033, 
   xmdc034 LIKE xmdc_t.xmdc034, 
   xmdc035 LIKE xmdc_t.xmdc035, 
   xmdc036 LIKE xmdc_t.xmdc036, 
   xmdc037 LIKE xmdc_t.xmdc037, 
   xmdc038 LIKE xmdc_t.xmdc038, 
   xmdc039 LIKE xmdc_t.xmdc039, 
   xmdc040 LIKE xmdc_t.xmdc040, 
   xmdc041 LIKE xmdc_t.xmdc041, 
   xmdc042 LIKE xmdc_t.xmdc042, 
   xmdc043 LIKE xmdc_t.xmdc043, 
   xmdc044 LIKE xmdc_t.xmdc044, 
   xmdc045 LIKE xmdc_t.xmdc045, 
   xmdc046 LIKE xmdc_t.xmdc046, 
   xmdc047 LIKE xmdc_t.xmdc047, 
   xmdc048 LIKE xmdc_t.xmdc048, 
   xmdc049 LIKE xmdc_t.xmdc049, 
   xmdc050 LIKE xmdc_t.xmdc050, 
   xmdc052 LIKE xmdc_t.xmdc052, 
   xmdc053 LIKE xmdc_t.xmdc053, 
   xmdcorga LIKE xmdc_t.xmdcorga, 
   xmdcseq LIKE xmdc_t.xmdcseq, 
   xmdcsite LIKE xmdc_t.xmdcsite, 
   xmdcunit LIKE xmdc_t.xmdcunit, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   t8_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t13_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t14_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_pmaal003 LIKE pmaal_t.pmaal003, 
   t11_pmaal003 LIKE pmaal_t.pmaal003, 
   t12_pmaal003 LIKE pmaal_t.pmaal003, 
   t4_pmaal004 LIKE pmaal_t.pmaal004, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   pmaml_t_pmaml003 LIKE pmaml_t.pmaml003, 
   t4_pmaal003 LIKE pmaal_t.pmaal003, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   oofb_t_oofb011 LIKE oofb_t.oofb011, 
   t5_oofb011 LIKE oofb_t.oofb011, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   x_t22_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t19_oocal003 LIKE oocal_t.oocal003, 
   x_t20_oocal003 LIKE oocal_t.oocal003, 
   l_xmdadocno_oobal004 LIKE type_t.chr80, 
   l_xmda002_ooag011 LIKE type_t.chr80, 
   l_xmda003_ooefl003 LIKE type_t.chr80, 
   l_xmda008_oobal004 LIKE type_t.chr80, 
   l_xmda031_oobal004 LIKE type_t.chr80, 
   l_xmda034_pmaal004 LIKE type_t.chr80, 
   l_xmdc041_oobal004 LIKE type_t.chr80, 
   l_xmdcorga_ooefl003 LIKE type_t.chr80, 
   l_xmdcunit_ooefl003 LIKE type_t.chr80, 
   l_xmda011_desc LIKE type_t.chr80, 
   l_amount LIKE type_t.num20_6, 
   l_xmda010_desc LIKE type_t.chr80, 
   l_xmda023_desc LIKE type_t.chr80, 
   l_xmda004_pmaal003 LIKE type_t.chr80, 
   t12_pmaal006 LIKE pmaal_t.pmaal006, 
   l_xmda022_pmaal003 LIKE type_t.chr80, 
   t11_pmaal006 LIKE pmaal_t.pmaal006, 
   t4_pmaal006 LIKE pmaal_t.pmaal006, 
   t12_pmaal004 LIKE pmaal_t.pmaal004, 
   t11_pmaal004 LIKE pmaal_t.pmaal004, 
   l_xmda021_pmaal003 LIKE type_t.chr80, 
   l_oofb171 LIKE type_t.chr100, 
   l_xmda020_desc LIKE type_t.chr30, 
   l_credit_num LIKE type_t.chr1000
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #QBE條件 
       c1 LIKE type_t.chr1          #列印額外品名
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
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 TYPE sr3_r RECORD
   xmdbdocno      LIKE xmdb_t.xmdbdocno,
   xmdb001        LIKE xmdb_t.xmdb001,
   xmdb002        LIKE xmdb_t.xmdb002,
   l_xmdb002_desc LIKE ooibl_t.ooibl004,
   xmdb003        LIKE xmdb_t.xmdb003,
   xmdb004        LIKE xmdb_t.xmdb004,
   xmdb005        LIKE xmdb_t.xmdb005,
   xmdb006        LIKE xmdb_t.xmdb006,
   l_amount       LIKE xmdb_t.xmdb006,
   l_xmdb016_desc LIKE gzcbl_t.gzcbl004   #add--160922-00028#1 By shiun
END RECORD
 TYPE sr4_r RECORD
   xmdddocno      LIKE xmdd_t.xmdddocno,
   xmddseq        LIKE xmdd_t.xmddseq,
   xmddseq1       LIKE xmdd_t.xmddseq1,
   xmddseq2       LIKE xmdd_t.xmddseq2,
   xmdd001        LIKE xmdd_t.xmdd001,
   xmdd002        LIKE xmdd_t.xmdd002,
   xmdd003        LIKE xmdd_t.xmdd003,
   xmdd004        LIKE xmdd_t.xmdd004,
   xmdd006        LIKE xmdd_t.xmdd006,
   xmdd011        LIKE xmdd_t.xmdd011,
   imaal003       LIKE imaal_t.imaal003,
   imaal004       LIKE imaal_t.imaal004,
   l_xmdd003_desc LIKE type_t.chr80,
   l_item_show    LIKE type_t.chr1
END RECORD
 TYPE sr5_r RECORD
   xmdsdocno      LIKE xmds_t.xmdsdocno,
   xmdsseq        LIKE xmds_t.xmdsseq,
   xmds001        LIKE xmds_t.xmds001,
   xmds002        LIKE xmds_t.xmds002,
   xmds004        LIKE xmds_t.xmds004,
   imaal003       LIKE imaal_t.imaal003,
   imaal004       LIKE imaal_t.imaal004
END RECORD
#add--2015/08/11 By shiun--(S)
TYPE sr6_r RECORD 
   xmao001        LIKE xmao_t.xmao001,          #客戶編號
   xmao002        LIKE xmao_t.xmao002,          #嘜頭編號
   xmap003        LIKE xmap_t.xmap003,          #類別
   xmap004        LIKE xmap_t.xmap004,          #行序
   xmap005        LIKE xmap_t.xmap005,          #資料類型
   xmap006        LIKE xmap_t.xmap006,          #資料內容
   l_xmap006_img  LIKE type_t.chr1000,          #資料內容(圖片)   #161205-00042#2-add
   l_imgstr       LIKE xmap_t.xmap006,          #圖中字內容       #161205-00042#2-add
   l_xmap003_desc LIKE type_t.chr500,           #類別說明
   l_xmap005_desc LIKE type_t.chr500,           #資料內容說明
   l_xmap003_show LIKE type_t.chr1              #類別顯示否
END RECORD
TYPE sr7_r RECORD 
   xmao001          LIKE xmao_t.xmao001,          #客戶編號
   xmao002          LIKE xmao_t.xmao002,          #嘜頭編號
   xmap006_1        LIKE xmap_t.xmap006,          #資料內容
   xmap006_2        LIKE xmap_t.xmap006,          #資料內容
   l_xmap003_desc_1 LIKE type_t.chr500,           #類別說明
   l_xmap003_desc_2 LIKE type_t.chr500,           #類別說明
   #161205-00042#2-add-s
   l_xmap006_1_img  LIKE type_t.chr1000,          #資料內容(圖片)
   l_xmap006_2_img  LIKE type_t.chr1000,          #資料內容(圖片)
   l_imgstr_1       LIKE xmap_t.xmap006,          #圖中字內容
   l_imgstr_2       LIKE xmap_t.xmap006           #圖中字內容
   #161205-00042#2-add-e
#   l_xmap003_show_1 LIKE type_t.chr500,           #類別顯示否
#   l_xmap003_show_2 LIKE type_t.chr500            #類別顯示否
END RECORD
TYPE sr8_r RECORD
   xmao001          LIKE xmao_t.xmao001,          #客戶編號
   xmao002          LIKE xmao_t.xmao002,          #嘜頭編號
   xmap006_1        LIKE xmap_t.xmap006,          #資料內容
   xmap006_2        LIKE xmap_t.xmap006,          #資料內容
   l_xmap003_desc_1 LIKE type_t.chr500,           #類別說明
   l_xmap003_desc_2 LIKE type_t.chr500,           #類別說明
   #161205-00042#2-add-s
   l_xmap006_1_img  LIKE type_t.chr1000,          #資料內容(圖片)
   l_xmap006_2_img  LIKE type_t.chr1000,          #資料內容(圖片)
   l_imgstr_1       LIKE xmap_t.xmap006,          #圖中字內容
   l_imgstr_2       LIKE xmap_t.xmap006           #圖中字內容
   #161205-00042#2-add-e   
#   l_xmap003_show_1 LIKE type_t.chr500,           #類別顯示否
#   l_xmap003_show_2 LIKE type_t.chr500            #類別顯示否
END RECORD
DEFINE sr8 DYNAMIC ARRAY OF sr8_r
#add--2015/08/11 By shiun--(E)
DEFINE g_cnt      LIKE type_t.num5
DEFINE g_sql_cnt  STRING
#end add-point
 
{</section>}
 
{<section id="axmr500_g01.main" readonly="Y" >}
PUBLIC FUNCTION axmr500_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  QBE條件 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.c1  列印額外品名
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"
DEFINE  l_success LIKE type_t.num5
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.c1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CALL s_axmi210_cre_tmp_table() RETURNING l_success #add--2015/08/11 By shiun
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "axmr500_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axmr500_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axmr500_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axmr500_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr500_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr500_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT xmda001,xmda002,xmda003,xmda004,xmda005,xmda006,xmda007,xmda008,xmda009,xmda010, 
       xmda011,xmda012,xmda013,xmda015,xmda016,xmda017,xmda018,xmda019,xmda020,xmda021,xmda022,xmda023, 
       xmda024,xmda025,xmda026,xmda027,xmda028,xmda030,xmda031,xmda032,xmda033,xmda034,xmda035,xmda036, 
       xmda037,'',xmda038,'',xmda039,xmda041,xmda042,xmda043,xmda044,xmda045,xmda046,xmda047,xmda071, 
       xmdadocdt,xmdadocno,xmdaent,xmdasite,xmdastus,xmdc001,xmdc002,xmdc003,xmdc004,xmdc005,xmdc006, 
       xmdc007,xmdc008,xmdc009,xmdc010,xmdc011,xmdc012,xmdc013,xmdc015,xmdc016,xmdc017,xmdc019,xmdc020, 
       xmdc021,xmdc022,xmdc023,xmdc024,xmdc025,xmdc026,xmdc027,xmdc028,xmdc029,xmdc030,xmdc031,xmdc032, 
       xmdc033,xmdc034,xmdc035,xmdc036,xmdc037,xmdc038,xmdc039,xmdc040,xmdc041,xmdc042,xmdc043,xmdc044, 
       xmdc045,xmdc046,xmdc047,xmdc048,xmdc049,xmdc050,xmdc052,xmdc053,xmdcorga,xmdcseq,xmdcsite,xmdcunit, 
       ( SELECT oofa011 FROM oofa_t WHERE oofa_t.oofa001 = xmda_t.xmda027 AND oofa_t.oofaent = xmda_t.xmdaent), 
       ( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmda_t.xmda002 AND ooag_t.ooagent = xmda_t.xmdaent), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmda_t.xmda003 AND ooefl_t.ooeflent = xmda_t.xmdaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),x.t13_ooefl003,x.t14_ooefl003,( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda034 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda021 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda022 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda004 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda036 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = xmda_t.xmda009 AND ooibl_t.ooiblent = xmda_t.xmdaent AND ooibl_t.ooibl003 = '" , 
       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = xmda_t.xmda015 AND ooail_t.ooailent = xmda_t.xmdaent AND ooail_t.ooail002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaml003 FROM pmaml_t WHERE pmaml_t.pmaml001 = xmda_t.xmda017 AND pmaml_t.pmamlent = xmda_t.xmdaent AND pmaml_t.pmaml002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda004 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT ooidl003 FROM ooidl_t WHERE ooidl_t.ooidl001 = xmda_t.xmda018 AND ooidl_t.ooidlent = xmda_t.xmdaent AND ooidl_t.ooidl002 = '" , 
       g_dlang,"'" ,"),( SELECT oofb011 FROM oofb_t WHERE oofb_t.oofb001 = xmda_t.xmda026 AND oofb_t.oofbent = xmda_t.xmdaent), 
       ( SELECT oofb011 FROM oofb_t WHERE oofb_t.oofb001 = xmda_t.xmda025 AND oofb_t.oofbent = xmda_t.xmdaent), 
       x.imaal_t_imaal003,x.imaal_t_imaal004,x.t22_imaal003,x.oocal_t_oocal003,x.t19_oocal003,x.t20_oocal003, 
       NULL,trim(xmda002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmda_t.xmda002 AND ooag_t.ooagent = xmda_t.xmdaent)), 
       trim(xmda003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmda_t.xmda003 AND ooefl_t.ooeflent = xmda_t.xmdaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),NULL,NULL,trim(xmda034)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda034 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),NULL,trim(xmdcorga)||'.'||trim(x.t14_ooefl003),trim(xmdcunit)||'.'||trim(x.t13_ooefl003), 
       NULL,NULL,NULL,NULL,trim(xmda004)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda004 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),( SELECT pmaal006 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda022 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),trim(xmda022)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda022 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),( SELECT pmaal006 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda021 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal006 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda004 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda022 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda021 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),trim(xmda021)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda021 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM xmda_t LEFT OUTER JOIN ( SELECT xmdc_t.*,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmdc_t.xmdcunit AND ooefl_t.ooeflent = xmdc_t.xmdcent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,") t13_ooefl003,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmdc_t.xmdcorga AND ooefl_t.ooeflent = xmdc_t.xmdcent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,") t14_ooefl003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xmdc_t.xmdc001 AND imaal_t.imaalent = xmdc_t.xmdcent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = xmdc_t.xmdc001 AND imaal_t.imaalent = xmdc_t.xmdcent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal004,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xmdc_t.xmdc003 AND imaal_t.imaalent = xmdc_t.xmdcent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t22_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = xmdc_t.xmdc010 AND oocal_t.oocalent = xmdc_t.xmdcent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = xmdc_t.xmdc008 AND oocal_t.oocalent = xmdc_t.xmdcent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") t19_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = xmdc_t.xmdc006 AND oocal_t.oocalent = xmdc_t.xmdcent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") t20_oocal003 FROM xmdc_t ) x  ON xmda_t.xmdaent = x.xmdcent AND xmda_t.xmdadocno  
        = x.xmdcdocno AND xmda_t.xmdasite = x.xmdcsite"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
    LET g_order = " ORDER BY xmdadocno,xmdcseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axmr500_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axmr500_g01_curs CURSOR FOR axmr500_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr500_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr500_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xmda001 LIKE xmda_t.xmda001, 
   xmda002 LIKE xmda_t.xmda002, 
   xmda003 LIKE xmda_t.xmda003, 
   xmda004 LIKE xmda_t.xmda004, 
   xmda005 LIKE xmda_t.xmda005, 
   xmda006 LIKE xmda_t.xmda006, 
   xmda007 LIKE xmda_t.xmda007, 
   xmda008 LIKE xmda_t.xmda008, 
   xmda009 LIKE xmda_t.xmda009, 
   xmda010 LIKE xmda_t.xmda010, 
   xmda011 LIKE xmda_t.xmda011, 
   xmda012 LIKE xmda_t.xmda012, 
   xmda013 LIKE xmda_t.xmda013, 
   xmda015 LIKE xmda_t.xmda015, 
   xmda016 LIKE xmda_t.xmda016, 
   xmda017 LIKE xmda_t.xmda017, 
   xmda018 LIKE xmda_t.xmda018, 
   xmda019 LIKE xmda_t.xmda019, 
   xmda020 LIKE xmda_t.xmda020, 
   xmda021 LIKE xmda_t.xmda021, 
   xmda022 LIKE xmda_t.xmda022, 
   xmda023 LIKE xmda_t.xmda023, 
   xmda024 LIKE xmda_t.xmda024, 
   xmda025 LIKE xmda_t.xmda025, 
   xmda026 LIKE xmda_t.xmda026, 
   xmda027 LIKE xmda_t.xmda027, 
   xmda028 LIKE xmda_t.xmda028, 
   xmda030 LIKE xmda_t.xmda030, 
   xmda031 LIKE xmda_t.xmda031, 
   xmda032 LIKE xmda_t.xmda032, 
   xmda033 LIKE xmda_t.xmda033, 
   xmda034 LIKE xmda_t.xmda034, 
   xmda035 LIKE xmda_t.xmda035, 
   xmda036 LIKE xmda_t.xmda036, 
   xmda037 LIKE xmda_t.xmda037, 
   l_xmda037_desc LIKE type_t.chr100, 
   xmda038 LIKE xmda_t.xmda038, 
   l_xmda038_desc LIKE type_t.chr100, 
   xmda039 LIKE xmda_t.xmda039, 
   xmda041 LIKE xmda_t.xmda041, 
   xmda042 LIKE xmda_t.xmda042, 
   xmda043 LIKE xmda_t.xmda043, 
   xmda044 LIKE xmda_t.xmda044, 
   xmda045 LIKE xmda_t.xmda045, 
   xmda046 LIKE xmda_t.xmda046, 
   xmda047 LIKE xmda_t.xmda047, 
   xmda071 LIKE xmda_t.xmda071, 
   xmdadocdt LIKE xmda_t.xmdadocdt, 
   xmdadocno LIKE xmda_t.xmdadocno, 
   xmdaent LIKE xmda_t.xmdaent, 
   xmdasite LIKE xmda_t.xmdasite, 
   xmdastus LIKE xmda_t.xmdastus, 
   xmdc001 LIKE xmdc_t.xmdc001, 
   xmdc002 LIKE xmdc_t.xmdc002, 
   xmdc003 LIKE xmdc_t.xmdc003, 
   xmdc004 LIKE xmdc_t.xmdc004, 
   xmdc005 LIKE xmdc_t.xmdc005, 
   xmdc006 LIKE xmdc_t.xmdc006, 
   xmdc007 LIKE xmdc_t.xmdc007, 
   xmdc008 LIKE xmdc_t.xmdc008, 
   xmdc009 LIKE xmdc_t.xmdc009, 
   xmdc010 LIKE xmdc_t.xmdc010, 
   xmdc011 LIKE xmdc_t.xmdc011, 
   xmdc012 LIKE xmdc_t.xmdc012, 
   xmdc013 LIKE xmdc_t.xmdc013, 
   xmdc015 LIKE xmdc_t.xmdc015, 
   xmdc016 LIKE xmdc_t.xmdc016, 
   xmdc017 LIKE xmdc_t.xmdc017, 
   xmdc019 LIKE xmdc_t.xmdc019, 
   xmdc020 LIKE xmdc_t.xmdc020, 
   xmdc021 LIKE xmdc_t.xmdc021, 
   xmdc022 LIKE xmdc_t.xmdc022, 
   xmdc023 LIKE xmdc_t.xmdc023, 
   xmdc024 LIKE xmdc_t.xmdc024, 
   xmdc025 LIKE xmdc_t.xmdc025, 
   xmdc026 LIKE xmdc_t.xmdc026, 
   xmdc027 LIKE xmdc_t.xmdc027, 
   xmdc028 LIKE xmdc_t.xmdc028, 
   xmdc029 LIKE xmdc_t.xmdc029, 
   xmdc030 LIKE xmdc_t.xmdc030, 
   xmdc031 LIKE xmdc_t.xmdc031, 
   xmdc032 LIKE xmdc_t.xmdc032, 
   xmdc033 LIKE xmdc_t.xmdc033, 
   xmdc034 LIKE xmdc_t.xmdc034, 
   xmdc035 LIKE xmdc_t.xmdc035, 
   xmdc036 LIKE xmdc_t.xmdc036, 
   xmdc037 LIKE xmdc_t.xmdc037, 
   xmdc038 LIKE xmdc_t.xmdc038, 
   xmdc039 LIKE xmdc_t.xmdc039, 
   xmdc040 LIKE xmdc_t.xmdc040, 
   xmdc041 LIKE xmdc_t.xmdc041, 
   xmdc042 LIKE xmdc_t.xmdc042, 
   xmdc043 LIKE xmdc_t.xmdc043, 
   xmdc044 LIKE xmdc_t.xmdc044, 
   xmdc045 LIKE xmdc_t.xmdc045, 
   xmdc046 LIKE xmdc_t.xmdc046, 
   xmdc047 LIKE xmdc_t.xmdc047, 
   xmdc048 LIKE xmdc_t.xmdc048, 
   xmdc049 LIKE xmdc_t.xmdc049, 
   xmdc050 LIKE xmdc_t.xmdc050, 
   xmdc052 LIKE xmdc_t.xmdc052, 
   xmdc053 LIKE xmdc_t.xmdc053, 
   xmdcorga LIKE xmdc_t.xmdcorga, 
   xmdcseq LIKE xmdc_t.xmdcseq, 
   xmdcsite LIKE xmdc_t.xmdcsite, 
   xmdcunit LIKE xmdc_t.xmdcunit, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   t8_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t13_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t14_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_pmaal003 LIKE pmaal_t.pmaal003, 
   t11_pmaal003 LIKE pmaal_t.pmaal003, 
   t12_pmaal003 LIKE pmaal_t.pmaal003, 
   t4_pmaal004 LIKE pmaal_t.pmaal004, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   pmaml_t_pmaml003 LIKE pmaml_t.pmaml003, 
   t4_pmaal003 LIKE pmaal_t.pmaal003, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   oofb_t_oofb011 LIKE oofb_t.oofb011, 
   t5_oofb011 LIKE oofb_t.oofb011, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   x_t22_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t19_oocal003 LIKE oocal_t.oocal003, 
   x_t20_oocal003 LIKE oocal_t.oocal003, 
   l_xmdadocno_oobal004 LIKE type_t.chr80, 
   l_xmda002_ooag011 LIKE type_t.chr80, 
   l_xmda003_ooefl003 LIKE type_t.chr80, 
   l_xmda008_oobal004 LIKE type_t.chr80, 
   l_xmda031_oobal004 LIKE type_t.chr80, 
   l_xmda034_pmaal004 LIKE type_t.chr80, 
   l_xmdc041_oobal004 LIKE type_t.chr80, 
   l_xmdcorga_ooefl003 LIKE type_t.chr80, 
   l_xmdcunit_ooefl003 LIKE type_t.chr80, 
   l_xmda011_desc LIKE type_t.chr80, 
   l_amount LIKE type_t.num20_6, 
   l_xmda010_desc LIKE type_t.chr80, 
   l_xmda023_desc LIKE type_t.chr80, 
   l_xmda004_pmaal003 LIKE type_t.chr80, 
   t12_pmaal006 LIKE pmaal_t.pmaal006, 
   l_xmda022_pmaal003 LIKE type_t.chr80, 
   t11_pmaal006 LIKE pmaal_t.pmaal006, 
   t4_pmaal006 LIKE pmaal_t.pmaal006, 
   t12_pmaal004 LIKE pmaal_t.pmaal004, 
   t11_pmaal004 LIKE pmaal_t.pmaal004, 
   l_xmda021_pmaal003 LIKE type_t.chr80, 
   l_oofb171 LIKE type_t.chr100, 
   l_xmda020_desc LIKE type_t.chr30, 
   l_credit_num LIKE type_t.chr1000
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_desc          LIKE type_t.chr300
#dorislai-20150724-add----(S)
DEFINE l_pmaa027       LIKE pmaa_t.pmaa027      #聯絡對象識別碼  
DEFINE l_success       LIKE type_t.num5         
DEFINE l_oofb171_n1    STRING
DEFINE l_oofb171_n2    STRING
DEFINE l_oofb171_n3    STRING
DEFINE l_oofb171       STRING
#dorislai-20150724-add----(E)
DEFINE l_oocq019       LIKE oocq_t.oocq019
DEFINE r_pmak003  LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#9 add
DEFINE l_pmaa004  LIKE pmaa_t.pmaa004   #法人類型            #161207-00033#9 add
DEFINE l_sql     STRING                                     #161207-00033#9 add
#161031-00024#1 Add By Ken 170202(S)
DEFINE l_slip_tmp       LIKE ooba_t.ooba002      #單據別   
DEFINE l_gzcb002        LIKE gzcb_t.gzcb002      #單據別參數
DEFINE l_cnt_chk        LIKE type_t.num10
#161031-00024#1 Add By Ken 170202(E)
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #161207-00033#9-s add
    LET l_sql = "SELECT pmaa004 FROM pmaa_t        ",
               "  WHERE pmaaent ='",g_enterprise,"'",
               "    AND pmaa001 = ?                "
    PREPARE axmr500_g01_prep FROM l_sql
    #161207-00033#9-e add
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH axmr500_g01_curs INTO sr_s.*
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
       #161207-00033#9-s add
       EXECUTE axmr500_g01_prep USING sr_s.xmda004 INTO l_pmaa004
       IF l_pmaa004 = '2' THEN   #2.一次性交易對象
          #一次性交易對象全名
          CALL s_desc_axm_get_oneturn_guest_desc('1',sr_s.xmdadocno)
               RETURNING r_pmak003
          IF NOT cl_null(r_pmak003) THEN
             LET sr_s.t4_pmaal003 = r_pmak003          
             IF sr_s.xmda021 = sr_s.xmda004 THEN   #帳款客戶
                LET sr_s.t11_pmaal004 = sr_s.t4_pmaal003
             END IF
             IF sr_s.xmda022 = sr_s.xmda004 THEN   #收貨客戶
                LET sr_s.t12_pmaal004 = sr_s.t4_pmaal003
             END IF
          END IF   
       END IF   
       #161207-00033#9-e add
       #訂單單號.說明
       LET l_desc = ''
       CALL s_aooi200_get_slip_desc(sr_s.xmdadocno) 
            RETURNING l_desc
       CALL axmr500_g01_combination(sr_s.xmdadocno,l_desc)
            RETURNING sr_s.l_xmdadocno_oobal004
       
       #來源單號.說明
       LET l_desc = ''
       CALL s_aooi200_get_slip_desc(sr_s.xmda008)
            RETURNING l_desc
       CALL axmr500_g01_combination(sr_s.xmda008,l_desc)
            RETURNING sr_s.l_xmda008_oobal004
            
       #多角來源單號.說明
       LET l_desc = ''
       CALL s_aooi200_get_slip_desc(sr_s.xmda031)
            RETURNING l_desc
       CALL axmr500_g01_combination(sr_s.xmda031,l_desc)
            RETURNING sr_s.l_xmda031_oobal004
            
       #價格參考單號.說明
       LET l_desc = ''
       CALL s_aooi200_get_slip_desc(sr_s.xmdc041)
            RETURNING l_desc
       CALL axmr500_g01_combination(sr_s.xmdc041,l_desc)
            RETURNING sr_s.l_xmdc041_oobal004
            
       #稅別
       CALL axmr500_g01_xmda011_ref(sr_s.xmdaent,sr_s.xmdasite,sr_s.xmda011)
            RETURNING sr_s.l_xmda011_desc
       LET sr_s.l_xmda011_desc = sr_s.l_xmda011_desc CLIPPED,sr_s.xmda012 USING '<<<<<','%'
            
       #交易條件
       CALL axmr500_g01_acc_ref(sr_s.xmdaent,'238',sr_s.xmda010)
            RETURNING sr_s.l_xmda010_desc
            
       #銷售通路
       CALL axmr500_g01_acc_ref(sr_s.xmdaent,'275',sr_s.xmda023)
            RETURNING sr_s.l_xmda023_desc
            
       #金額
       IF sr_s.xmda013 = 'Y' THEN   #含稅
          LET sr_s.l_amount = sr_s.xmdc047
       ELSE
          LET sr_s.l_amount = sr_s.xmdc046
       END IF
       #modify--2015/02/03 By Shiun--(S)
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL axmr500_g01_initialize(sr_s.xmda004,sr_s.l_xmda004_pmaal003) RETURNING sr_s.l_xmda004_pmaal003
       CALL axmr500_g01_initialize(sr_s.xmda021,sr_s.l_xmda021_pmaal003) RETURNING sr_s.l_xmda021_pmaal003
       CALL axmr500_g01_initialize(sr_s.xmda022,sr_s.l_xmda022_pmaal003) RETURNING sr_s.l_xmda022_pmaal003
       CALL axmr500_g01_initialize(sr_s.xmda002,sr_s.l_xmda002_ooag011) RETURNING sr_s.l_xmda002_ooag011
       CALL axmr500_g01_initialize(sr_s.xmda003,sr_s.l_xmda003_ooefl003) RETURNING sr_s.l_xmda003_ooefl003
       #modify--2015/02/03 By Shiun--(E)
       
       #dorislai-20150722-add----(S)
       #送貨地址

       LET l_pmaa027 = ''
       CALL s_axmt500_get_pmaa027(sr_s.xmda022) RETURNING l_pmaa027
       LET sr_s.l_oofb171 = ''
       IF NOT cl_null(l_pmaa027) THEN
          #呼叫地址組合應用元件
          CALL s_aooi350_get_address(l_pmaa027,sr_s.xmda025,g_dlang) RETURNING l_success,l_oofb171

          #抓第一段地址-郵遞區號
          LET l_oofb171_n1 = l_oofb171.getIndexOf("\r\n",1)          
          IF l_oofb171_n1 <> 1 THEN
             LET l_oofb171_n3 = l_oofb171.subString(1,l_oofb171_n1-1)
             LET sr_s.l_oofb171 = l_oofb171_n3
          END IF
          #抓第二段地址-州/省 + 縣/市 + 行政區         
          LET l_oofb171_n2 = l_oofb171.getIndexOf("\r\n",l_oofb171_n1+1)  #抓第二個\r\n
          LET l_oofb171_n3 = l_oofb171.subString(l_oofb171_n1+2,l_oofb171_n2-1)
          IF NOT cl_null(l_oofb171_n3) THEN
             #此段判斷僅用來讓字串不要有多餘的空白          
             IF cl_null(sr_s.l_oofb171) THEN
                LET sr_s.l_oofb171 = l_oofb171_n3
             ELSE
                LET sr_s.l_oofb171 = sr_s.l_oofb171,' ',l_oofb171_n3
             END IF
          END IF
          #抓第三段地址-地址
          LET l_oofb171_n1 = l_oofb171_n2 
          LET l_oofb171_n2 = l_oofb171.getLength()
          LET l_oofb171_n3 = l_oofb171.subString(l_oofb171_n1+2,l_oofb171_n2)
          IF NOT cl_null(l_oofb171_n3) THEN
             #此段判斷僅用來讓字串不要有多餘的空白   
             IF cl_null(sr_s.l_oofb171) THEN
                LET sr_s.l_oofb171 = l_oofb171_n3
             ELSE
                LET sr_s.l_oofb171 = sr_s.l_oofb171,' ',l_oofb171_n3
             END IF
          END IF

       END IF
       #運送方式
       CALL s_desc_get_acc_desc('263',sr_s.xmda020) RETURNING sr_s.l_xmda020_desc
       #dorislai-20150722-add----(E)
       #add--2015/08/28 By shiun--(S)
       CALL s_apmi011_location_ref(sr_s.xmda020,sr_s.xmda037) RETURNING sr_s.l_xmda037_desc
       CALL s_apmi011_location_ref(sr_s.xmda020,sr_s.xmda038) RETURNING sr_s.l_xmda038_desc
       #add--2015/08/28 By shiun--(E)
       #mark--2015/08/28 By shiun--(S)
       #add--2015/08/11 By shiun--(S)
#       #起運地帶出參考欄位
#       LET l_oocq019 = ''               #運輸方式清空
#       LET sr_s.l_xmda037_desc = ''
#
#       IF NOT cl_null(sr_s.xmda020) THEN
#       SELECT oocq019 INTO l_oocq019 FROM oocq_t
#        WHERE oocqent = sr_s.xmdaent
#          AND oocq001 ='263'
#          AND oocq002 = sr_s.xmda020 #運輸方式
#       END IF
#
#       CASE
#          WHEN l_oocq019 = '1' OR    #陸運
#               l_oocq019 = '4'       #其他
#        
#             DECLARE axmr500_xmda_cs SCROLL CURSOR FOR
#                SELECT oockl005 FROM oockl_t
#                 WHERE oocklent = sr_s.xmdaent
#                   AND oockl003 = sr_s.xmda037
#                   AND oockl004 = g_dlang
#              ORDER BY oockl001 DESC
#                  OPEN axmr500_xmda_cs
#           FETCH FIRST axmr500_xmda_cs INTO sr_s.l_xmda037_desc
#        
#          WHEN l_oocq019 = '2'       #海運        
#             SELECT oocql004 INTO sr_s.l_xmda037_desc FROM oocql_t
#              WHERE oocqlent = sr_s.xmdaent
#                AND oocql001 ='262'
#                AND oocql002 = sr_s.xmda037
#                AND oocql003 = g_dlang
#
#          WHEN l_oocq019 = '3'       #空運
#             SELECT oocql004 INTO sr_s.l_xmda037_desc FROM oocql_t
#              WHERE oocqlent = sr_s.xmdaent
#                AND oocql001 = '276'
#                AND oocql002 = sr_s.l_xmda037_desc
#                AND oocql003 = g_dlang
#       END CASE
#
#       #目的地帶出參考欄位
#       LET l_oocq019 = ''
#       LET sr_s.l_xmda038_desc = ''
#
#       IF NOT cl_null(sr_s.xmda020) THEN
#       SELECT oocq019 INTO l_oocq019
#         FROM oocq_t
#        WHERE oocq001 = '263'
#          AND oocq002 = sr_s.xmda038
#       END IF
#       CASE
#          WHEN l_oocq019 = '1' OR    #陸運
#               l_oocq019 = '4'       #其他
#
#             DECLARE axme500_xmda_cs1 SCROLL CURSOR FOR
#                SELECT oockl005 FROM oockl_t
#                 WHERE oocklent = sr_s.xmdaent
#                 AND oockl003 = sr_s.xmda038
#                   AND oockl004 = g_dlang
#                 ORDER BY oockl001 DESC
#                 OPEN axme500_xmda_cs1
#             FETCH FIRST axme500_xmda_cs1 INTO sr_s.l_xmda038_desc
#
#          WHEN l_oocq019 = '2'       #海運
#
#             SELECT oocql004 INTO sr_s.l_xmda038_desc FROM oocql_t
#              WHERE oocqlent = sr_s.xmdaent
#                AND oocql001 ='262'
#                AND oocql002 = sr_s.xmda038
#                AND oocql003 = g_dlang
#
#          WHEN l_oocq019 = '3'       #空運
#
#             SELECT oocql004 INTO sr_s.l_xmda038_desc FROM oocql_t
#              WHERE oocqlent = sr_s.xmdaent
#                AND oocql001 = '276'
#                AND oocql002 = sr_s.xmda038
#                AND oocql003 = g_dlang
#       END CASE
       #mark--2015/08/28 By shiun--(E)
       CALL s_axmi210_ins_tmp_table(sr_s.xmdc001,sr_s.x_imaal_t_imaal003,sr_s.t4_pmaal004,sr_s.xmda033,sr_s.xmdadocno,sr_s.l_xmda037_desc,sr_s.l_xmda038_desc,'','','','','',sr_s.xmdadocno) RETURNING l_success
       #add--2015/08/11 By shiun--(E)
       
       #161031-00024#1 Add By Ken 170202(S)
       IF tm.c1 = 'Y' THEN
          #先取得單別
          LET l_success = ''
          LET l_slip_tmp = ''
          CALL s_aooi200_get_slip(sr_s.xmdadocno)
             RETURNING l_success,l_slip_tmp
          
          #取得單別參數
          CALL cl_get_doc_para(g_enterprise,g_site,l_slip_tmp,'D-MFG-0087')
             RETURNING l_gzcb002       
             
          IF NOT cl_null(l_gzcb002) THEN
             LET l_cnt_chk = 0
             SELECT COUNT(1) INTO l_cnt_chk
               FROM imab_t
              WHERE imabent = g_enterprise
                AND imab001 = sr_s.xmdc001
                AND imab002 = l_gzcb002
                AND imabstus = 'Y'
                AND (imab005 IS NOT NULL OR imab005<>'')                 
             IF l_cnt_chk > 0 THEN
                CALL s_desc_get_imab004_desc(sr_s.xmdc001,l_gzcb002) RETURNING sr_s.x_imaal_t_imaal003
                IF NOT cl_null(sr_s.x_imaal_t_imaal003) THEN
                   LET sr_s.x_imaal_t_imaal004 = ''
                END IF
             END IF
          END IF
       END IF
       #161031-00024#1 Add By Ken 170202(E)         
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
 
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].xmda001 = sr_s.xmda001
       LET sr[l_cnt].xmda002 = sr_s.xmda002
       LET sr[l_cnt].xmda003 = sr_s.xmda003
       LET sr[l_cnt].xmda004 = sr_s.xmda004
       LET sr[l_cnt].xmda005 = sr_s.xmda005
       LET sr[l_cnt].xmda006 = sr_s.xmda006
       LET sr[l_cnt].xmda007 = sr_s.xmda007
       LET sr[l_cnt].xmda008 = sr_s.xmda008
       LET sr[l_cnt].xmda009 = sr_s.xmda009
       LET sr[l_cnt].xmda010 = sr_s.xmda010
       LET sr[l_cnt].xmda011 = sr_s.xmda011
       LET sr[l_cnt].xmda012 = sr_s.xmda012
       LET sr[l_cnt].xmda013 = sr_s.xmda013
       LET sr[l_cnt].xmda015 = sr_s.xmda015
       LET sr[l_cnt].xmda016 = sr_s.xmda016
       LET sr[l_cnt].xmda017 = sr_s.xmda017
       LET sr[l_cnt].xmda018 = sr_s.xmda018
       LET sr[l_cnt].xmda019 = sr_s.xmda019
       LET sr[l_cnt].xmda020 = sr_s.xmda020
       LET sr[l_cnt].xmda021 = sr_s.xmda021
       LET sr[l_cnt].xmda022 = sr_s.xmda022
       LET sr[l_cnt].xmda023 = sr_s.xmda023
       LET sr[l_cnt].xmda024 = sr_s.xmda024
       LET sr[l_cnt].xmda025 = sr_s.xmda025
       LET sr[l_cnt].xmda026 = sr_s.xmda026
       LET sr[l_cnt].xmda027 = sr_s.xmda027
       LET sr[l_cnt].xmda028 = sr_s.xmda028
       LET sr[l_cnt].xmda030 = sr_s.xmda030
       LET sr[l_cnt].xmda031 = sr_s.xmda031
       LET sr[l_cnt].xmda032 = sr_s.xmda032
       LET sr[l_cnt].xmda033 = sr_s.xmda033
       LET sr[l_cnt].xmda034 = sr_s.xmda034
       LET sr[l_cnt].xmda035 = sr_s.xmda035
       LET sr[l_cnt].xmda036 = sr_s.xmda036
       LET sr[l_cnt].xmda037 = sr_s.xmda037
       LET sr[l_cnt].l_xmda037_desc = sr_s.l_xmda037_desc
       LET sr[l_cnt].xmda038 = sr_s.xmda038
       LET sr[l_cnt].l_xmda038_desc = sr_s.l_xmda038_desc
       LET sr[l_cnt].xmda039 = sr_s.xmda039
       LET sr[l_cnt].xmda041 = sr_s.xmda041
       LET sr[l_cnt].xmda042 = sr_s.xmda042
       LET sr[l_cnt].xmda043 = sr_s.xmda043
       LET sr[l_cnt].xmda044 = sr_s.xmda044
       LET sr[l_cnt].xmda045 = sr_s.xmda045
       LET sr[l_cnt].xmda046 = sr_s.xmda046
       LET sr[l_cnt].xmda047 = sr_s.xmda047
       LET sr[l_cnt].xmda071 = sr_s.xmda071
       LET sr[l_cnt].xmdadocdt = sr_s.xmdadocdt
       LET sr[l_cnt].xmdadocno = sr_s.xmdadocno
       LET sr[l_cnt].xmdaent = sr_s.xmdaent
       LET sr[l_cnt].xmdasite = sr_s.xmdasite
       LET sr[l_cnt].xmdastus = sr_s.xmdastus
       LET sr[l_cnt].xmdc001 = sr_s.xmdc001
       LET sr[l_cnt].xmdc002 = sr_s.xmdc002
       LET sr[l_cnt].xmdc003 = sr_s.xmdc003
       LET sr[l_cnt].xmdc004 = sr_s.xmdc004
       LET sr[l_cnt].xmdc005 = sr_s.xmdc005
       LET sr[l_cnt].xmdc006 = sr_s.xmdc006
       LET sr[l_cnt].xmdc007 = sr_s.xmdc007
       LET sr[l_cnt].xmdc008 = sr_s.xmdc008
       LET sr[l_cnt].xmdc009 = sr_s.xmdc009
       LET sr[l_cnt].xmdc010 = sr_s.xmdc010
       LET sr[l_cnt].xmdc011 = sr_s.xmdc011
       LET sr[l_cnt].xmdc012 = sr_s.xmdc012
       LET sr[l_cnt].xmdc013 = sr_s.xmdc013
       LET sr[l_cnt].xmdc015 = sr_s.xmdc015
       LET sr[l_cnt].xmdc016 = sr_s.xmdc016
       LET sr[l_cnt].xmdc017 = sr_s.xmdc017
       LET sr[l_cnt].xmdc019 = sr_s.xmdc019
       LET sr[l_cnt].xmdc020 = sr_s.xmdc020
       LET sr[l_cnt].xmdc021 = sr_s.xmdc021
       LET sr[l_cnt].xmdc022 = sr_s.xmdc022
       LET sr[l_cnt].xmdc023 = sr_s.xmdc023
       LET sr[l_cnt].xmdc024 = sr_s.xmdc024
       LET sr[l_cnt].xmdc025 = sr_s.xmdc025
       LET sr[l_cnt].xmdc026 = sr_s.xmdc026
       LET sr[l_cnt].xmdc027 = sr_s.xmdc027
       LET sr[l_cnt].xmdc028 = sr_s.xmdc028
       LET sr[l_cnt].xmdc029 = sr_s.xmdc029
       LET sr[l_cnt].xmdc030 = sr_s.xmdc030
       LET sr[l_cnt].xmdc031 = sr_s.xmdc031
       LET sr[l_cnt].xmdc032 = sr_s.xmdc032
       LET sr[l_cnt].xmdc033 = sr_s.xmdc033
       LET sr[l_cnt].xmdc034 = sr_s.xmdc034
       LET sr[l_cnt].xmdc035 = sr_s.xmdc035
       LET sr[l_cnt].xmdc036 = sr_s.xmdc036
       LET sr[l_cnt].xmdc037 = sr_s.xmdc037
       LET sr[l_cnt].xmdc038 = sr_s.xmdc038
       LET sr[l_cnt].xmdc039 = sr_s.xmdc039
       LET sr[l_cnt].xmdc040 = sr_s.xmdc040
       LET sr[l_cnt].xmdc041 = sr_s.xmdc041
       LET sr[l_cnt].xmdc042 = sr_s.xmdc042
       LET sr[l_cnt].xmdc043 = sr_s.xmdc043
       LET sr[l_cnt].xmdc044 = sr_s.xmdc044
       LET sr[l_cnt].xmdc045 = sr_s.xmdc045
       LET sr[l_cnt].xmdc046 = sr_s.xmdc046
       LET sr[l_cnt].xmdc047 = sr_s.xmdc047
       LET sr[l_cnt].xmdc048 = sr_s.xmdc048
       LET sr[l_cnt].xmdc049 = sr_s.xmdc049
       LET sr[l_cnt].xmdc050 = sr_s.xmdc050
       LET sr[l_cnt].xmdc052 = sr_s.xmdc052
       LET sr[l_cnt].xmdc053 = sr_s.xmdc053
       LET sr[l_cnt].xmdcorga = sr_s.xmdcorga
       LET sr[l_cnt].xmdcseq = sr_s.xmdcseq
       LET sr[l_cnt].xmdcsite = sr_s.xmdcsite
       LET sr[l_cnt].xmdcunit = sr_s.xmdcunit
       LET sr[l_cnt].oofa_t_oofa011 = sr_s.oofa_t_oofa011
       LET sr[l_cnt].t8_ooag011 = sr_s.t8_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].x_t13_ooefl003 = sr_s.x_t13_ooefl003
       LET sr[l_cnt].x_t14_ooefl003 = sr_s.x_t14_ooefl003
       LET sr[l_cnt].t1_pmaal003 = sr_s.t1_pmaal003
       LET sr[l_cnt].t11_pmaal003 = sr_s.t11_pmaal003
       LET sr[l_cnt].t12_pmaal003 = sr_s.t12_pmaal003
       LET sr[l_cnt].t4_pmaal004 = sr_s.t4_pmaal004
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].pmaml_t_pmaml003 = sr_s.pmaml_t_pmaml003
       LET sr[l_cnt].t4_pmaal003 = sr_s.t4_pmaal003
       LET sr[l_cnt].ooidl_t_ooidl003 = sr_s.ooidl_t_ooidl003
       LET sr[l_cnt].oofb_t_oofb011 = sr_s.oofb_t_oofb011
       LET sr[l_cnt].t5_oofb011 = sr_s.t5_oofb011
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].x_t22_imaal003 = sr_s.x_t22_imaal003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t19_oocal003 = sr_s.x_t19_oocal003
       LET sr[l_cnt].x_t20_oocal003 = sr_s.x_t20_oocal003
       LET sr[l_cnt].l_xmdadocno_oobal004 = sr_s.l_xmdadocno_oobal004
       LET sr[l_cnt].l_xmda002_ooag011 = sr_s.l_xmda002_ooag011
       LET sr[l_cnt].l_xmda003_ooefl003 = sr_s.l_xmda003_ooefl003
       LET sr[l_cnt].l_xmda008_oobal004 = sr_s.l_xmda008_oobal004
       LET sr[l_cnt].l_xmda031_oobal004 = sr_s.l_xmda031_oobal004
       LET sr[l_cnt].l_xmda034_pmaal004 = sr_s.l_xmda034_pmaal004
       LET sr[l_cnt].l_xmdc041_oobal004 = sr_s.l_xmdc041_oobal004
       LET sr[l_cnt].l_xmdcorga_ooefl003 = sr_s.l_xmdcorga_ooefl003
       LET sr[l_cnt].l_xmdcunit_ooefl003 = sr_s.l_xmdcunit_ooefl003
       LET sr[l_cnt].l_xmda011_desc = sr_s.l_xmda011_desc
       LET sr[l_cnt].l_amount = sr_s.l_amount
       LET sr[l_cnt].l_xmda010_desc = sr_s.l_xmda010_desc
       LET sr[l_cnt].l_xmda023_desc = sr_s.l_xmda023_desc
       LET sr[l_cnt].l_xmda004_pmaal003 = sr_s.l_xmda004_pmaal003
       LET sr[l_cnt].t12_pmaal006 = sr_s.t12_pmaal006
       LET sr[l_cnt].l_xmda022_pmaal003 = sr_s.l_xmda022_pmaal003
       LET sr[l_cnt].t11_pmaal006 = sr_s.t11_pmaal006
       LET sr[l_cnt].t4_pmaal006 = sr_s.t4_pmaal006
       LET sr[l_cnt].t12_pmaal004 = sr_s.t12_pmaal004
       LET sr[l_cnt].t11_pmaal004 = sr_s.t11_pmaal004
       LET sr[l_cnt].l_xmda021_pmaal003 = sr_s.l_xmda021_pmaal003
       LET sr[l_cnt].l_oofb171 = sr_s.l_oofb171
       LET sr[l_cnt].l_xmda020_desc = sr_s.l_xmda020_desc
       LET sr[l_cnt].l_credit_num = sr_s.l_credit_num
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmr500_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr500_g01_rep_data()
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
          START REPORT axmr500_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axmr500_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axmr500_g01_rep
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
 
{<section id="axmr500_g01.rep" readonly="Y" >}
PRIVATE REPORT axmr500_g01_rep(sr1)
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
DEFINE l_xmddseq1_o   LIKE xmdd_t.xmddseq1
DEFINE l_xmda071_show LIKE type_t.chr1
DEFINE l_xmdc002_show LIKE type_t.chr1
DEFINE l_xmdc050_show LIKE type_t.chr1
DEFINE sr5 sr5_r
#add--2015/06/15 By shiun--(S)
DEFINE sr6 sr6_r
DEFINE l_xmao003   LIKE xmao_t.xmao003         #變數內容多筆時顯示方式
DEFINE l_xmao004   LIKE xmao_t.xmao004         #顯示符號
DEFINE l_count     LIKE type_t.num5
DEFINE l_xmap_show LIKE type_t.chr10           #嘜頭隱藏   
DEFINE l_xmap006   STRING #資料內容
DEFINE l_out       STRING #輸出內容
DEFINE l_load      STRING #xmap006暫存內容
DEFINE l_str       STRING #擷取參數
DEFINE l_length    LIKE type_t.num5   #總長度
DEFINE l_n         LIKE type_t.num5   #起始位置(判斷用)
DEFINE l_n1        LIKE type_t.num5   #第一個&位置
DEFINE l_n2        LIKE type_t.num5   #第二個&位置
DEFINE l_min       LIKE type_t.num5   #第一筆資料
#add--2015/06/15 By shiun--(S)
#dorislai-20150722-add----(S)
DEFINE l_success       LIKE type_t.num5
DEFINE l_xmaj002_1     LIKE xmaj_t.xmaj002      #訂單確認時超限控管方式(據點)
DEFINE l_xmaj002_2     LIKE xmaj_t.xmaj002      #訂單確認時超限控管方式(集團)
DEFINE l_xmda004_credit_show    LIKE  type_t.chr1      #額度是否超限顯示
DEFINE l_fee_info_show          LIKE  type_t.chr1      #費用資訊是否顯示
DEFINE l_flag          LIKE type_t.num5
DEFINE l_xmda004       LIKE xmda_t.xmda004      #客戶編號
DEFINE l_xmda015       LIKE xmda_t.xmda015      #幣別
DEFINE l_site          LIKE xmda_t.xmdasite
DEFINE l_stus          LIKE xmda_t.xmdastus
#dorislai-20150722-add----(E)
#add--2015/08/12 By shiun--(S)
DEFINE sr7 sr7_r
DEFINE l_tmp_sql         STRING
DEFINE l_ac              INTEGER
DEFINE l_i               INTEGER
DEFINE l_j               INTEGER
DEFINE l_max_count       INTEGER
DEFINE l_while_count     INTEGER
DEFINE l_xmap003_sql     STRING
DEFINE l_xmap006_sql     STRING
DEFINE l_xmap003_desc    LIKE type_t.chr500
DEFINE l_xmap005_desc    LIKE type_t.chr500
DEFINE l_xmap003_show    LIKE type_t.chr1
DEFINE l_xmao001         LIKE xmao_t.xmao001         #客戶編號
DEFINE l_xmao002         LIKE xmao_t.xmao002         #嘜頭編號
DEFINE l_xmap006_array   LIKE xmap_t.xmap006         #資料內容
DEFINE l_xmap003         LIKE xmap_t.xmap003         #類別
DEFINE l_xmap004         LIKE xmap_t.xmap004         #行序

#add--2015/08/12 By shiun--(E)
#161205-00042#2-add-s
DEFINE l_js              STRING
DEFINE l_loaa001         LIKE loaa_t.loaa001
DEFINE l_xmap006_img     LIKE type_t.chr1000      #資料內容(圖片)
DEFINE l_xmap006_img_arr DYNAMIC ARRAY OF STRING
DEFINE l_imgstr          LIKE xmap_t.xmap006      #圖中字內容
#161205-00042#2-add-e
DEFINe ls_url_surc  STRING   #161205-00042#2-add
DEFINe ls_url_dest  STRING   #161205-00042#2-add
DEFINE l_imaal004_show   LIKE type_t.chr1      #161031-00024#1 Add By ken 170206
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.xmdadocno,sr1.xmdcseq
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
        BEFORE GROUP OF sr1.xmdadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xmdadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xmdaent=' ,sr1.xmdaent,'{+}xmdadocno=' ,sr1.xmdadocno         
            CALL cl_gr_init_apr(sr1.xmdadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xmdadocno.before name="rep.b_group.xmdadocno.before"
           #dorislai-20150722-add----(S)
           
           LET g_sql = " SELECT xmdsdocno,xmdsseq,xmds001,xmds002,xmds004,NULL,NULL ",
                       "   FROM xmds_t ",
                       "  WHERE xmdsent = '",sr1.xmdaent,"' ",
                       "    AND xmdsdocno = '",sr1.xmdadocno CLIPPED,"'",
                       "  ORDER BY xmdsseq "
           START REPORT axmr500_g01_subrep07
           DECLARE axmr500_g01_repcur07 CURSOR FROM g_sql
           FOREACH axmr500_g01_repcur07 INTO sr5.*
              IF STATUS THEN INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = STATUS
                 LET g_errparam.extend = 'axmr500_g01_repcur05:'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 EXIT FOREACH 
              END IF
             
              SELECT imaal003,imaal004 INTO sr5.imaal003,sr5.imaal004 FROM imaal_t
               WHERE imaalent = sr1.xmdaent AND imaal001 = sr5.xmds001 AND imaal002 = g_dlang

              
              OUTPUT TO REPORT axmr500_g01_subrep07(sr5.*)
           END FOREACH
           FINISH REPORT axmr500_g01_subrep07
           IF cl_null(sr5.xmdsseq) THEN
              LET l_fee_info_show = 'N'
           ELSE
              LET l_fee_info_show = 'Y'
           END IF
           PRINTX l_fee_info_show

           #信用額度檢查
           #呼叫信用額度檢核應用元件，檢核此交易是否會超限
           CALL s_axmt500_get_credit('1',sr1.xmda004) RETURNING l_xmaj002_1,l_xmaj002_2  #抓取axmi140的訂單列印時超限控管方式
           IF l_xmaj002_1 = '3' OR l_xmaj002_2 = '3' THEN      #警告
              #檢查/更新信用額度
              IF s_axmt500_credit('1',sr1.xmdadocno,sr1.xmda004) THEN
                 LET l_xmda004_credit_show = 'N'  #不超過信用額度，不顯示警告
              ELSE
                 LET l_xmda004_credit_show = 'Y'  #超過信用額度，顯示警告
              END IF    
           END IF

           PRINTX l_xmda004_credit_show
           
           #dorislai-20150722-add----(E)
           
           
           
           #單頭備註若為空，則整行隱藏
           IF cl_null(sr1.xmda071) THEN
              LET l_xmda071_show = 'N'
           ELSE
              LET l_xmda071_show = 'Y'
           END IF
           PRINTX l_xmda071_show
           
           #161031-00024#1 Add By Ken 170206(S)
           #規格若為空，則隱藏
           INITIALIZE l_imaal004_show TO NULL
           IF cl_null(sr1.x_imaal_t_imaal004) THEN
              LET l_imaal004_show = 'N'
           ELSE
              LET l_imaal004_show = 'Y'
           END IF
           PRINTX l_imaal004_show
           #161031-00024#1 Add By Ken 170206(E)           
           
           #mod--160922-00028#1 By shiun--(S)
           LET g_sql = " SELECT xmdbdocno,xmdb001,xmdb002,NULL,xmdb003,xmdb004,xmdb005,xmdb006,0 ",
                       "        ,(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '3015' AND gzcbl002 = xmdb016 AND gzcbl003 = '",g_dlang,"') ",
           #mod--160922-00028#1 By shiun--(E)
                       "   FROM xmdb_t ",
                       "  WHERE xmdbent = '",sr1.xmdaent,"' ",
                       "    AND xmdbdocno = '",sr1.xmdadocno CLIPPED,"'",
                       "  ORDER BY xmdb001 "
           START REPORT axmr500_g01_subrep05
           DECLARE axmr500_g01_repcur05 CURSOR FROM g_sql
           FOREACH axmr500_g01_repcur05 INTO sr3.*
           IF STATUS THEN INITIALIZE g_errparam TO NULL
              LET g_errparam.code = STATUS
              LET g_errparam.extend = 'axmr500_g01_repcur05:'
              LET g_errparam.popup = TRUE
              CALL cl_err()
           EXIT FOREACH END IF
              
              CALL axmr500_g01_xmdb002_ref(sr1.xmdaent,sr3.xmdb002)
                   RETURNING sr3.l_xmdb002_desc
              
              IF sr1.xmda013 = 'Y' THEN
                 LET sr3.l_amount = sr3.xmdb006
              ELSE
                 LET sr3.l_amount = sr3.xmdb005
              END IF
              
              OUTPUT TO REPORT axmr500_g01_subrep05(sr3.*)
           END FOREACH
           FINISH REPORT axmr500_g01_subrep05
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr500_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axmr500_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axmr500_g01_subrep01
           DECLARE axmr500_g01_repcur01 CURSOR FROM g_sql
           FOREACH axmr500_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr500_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axmr500_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axmr500_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xmdadocno.after name="rep.b_group.xmdadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xmdcseq
 
           #add-point:rep.b_group.xmdcseq.before name="rep.b_group.xmdcseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xmdcseq.after name="rep.b_group.xmdcseq.after"
           
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
                sr1.xmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmdcseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr500_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axmr500_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axmr500_g01_subrep02
           DECLARE axmr500_g01_repcur02 CURSOR FROM g_sql
           FOREACH axmr500_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr500_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axmr500_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axmr500_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
            #產品特徵若無值，則整行隱藏
            IF cl_null(sr1.xmdc002) THEN
               LET l_xmdc002_show = 'N'
            ELSE
               LET l_xmdc002_show = 'Y'
            END IF
            
            #單身備註若無值，則整行隱藏
            IF cl_null(sr1.xmdc050) THEN
               LET l_xmdc050_show = 'N'
            ELSE
               LET l_xmdc050_show = 'Y'
            END IF
            
            PRINTX l_xmdc002_show,l_xmdc050_show
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
            START REPORT axmr500_g01_subrep06
            IF NOT cl_null(sr1.xmdcseq) AND sr1.xmdcseq > 0 THEN
               LET g_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd003, ",
                           "       xmdd004,xmdd006,xmdd011,NULL,NULL,NULL,'0' ",
                           "  FROM xmdd_t ",
                           " WHERE xmddent = '",sr1.xmdaent,"'",
                           "   AND xmdddocno = '",sr1.xmdadocno CLIPPED,"' ",
                           "   AND xmddseq = ",sr1.xmdcseq CLIPPED,
                           " ORDER BY xmddseq1,xmddseq2 "
               LET g_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
               PREPARE axmr500_g01_subrep06_cnt_pre FROM g_sql_cnt
               
               LET g_cnt = 0
               EXECUTE axmr500_g01_subrep06_cnt_pre INTO g_cnt
               FREE axmr500_g01_subrep06_cnt_pre
               
               IF g_cnt > 1 THEN
               
                  LET g_sql_cnt = g_sql_cnt CLIPPED," WHERE xmdd003 <> '1' "
                  PREPARE axmr500_g01_subrep06_cnt_pre01 FROM g_sql_cnt
                  LET g_cnt = 0
                  EXECUTE axmr500_g01_subrep06_cnt_pre01 INTO g_cnt
                  FREE axmr500_g01_subrep06_cnt_pre01
             
                  LET l_xmddseq1_o = 0
                  DECLARE axmr500_g01_repcur06 CURSOR FROM g_sql
                  FOREACH axmr500_g01_repcur06 INTO sr4.*
                     IF STATUS THEN INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = STATUS
                        LET g_errparam.extend = 'axmr500_g01_repcur03:'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     EXIT FOREACH END IF
                  
                     #子件特性
                     CALL axmr500_g01_scc_ref('2055',sr4.xmdd003)
                          RETURNING sr4.l_xmdd003_desc
                     LET sr4.l_xmdd003_desc = sr4.xmdd003 CLIPPED,'.',sr4.l_xmdd003_desc CLIPPED
                     
                     #顯示項序、料件編號
                     IF g_cnt > 0 THEN
                        LET sr4.l_item_show = '1'
                     
                        SELECT imaal003,imaal004 INTO sr4.imaal003,sr4.imaal004
                          FROM imaal_t
                         WHERE imaalent = sr1.xmdaent
                           AND imaal001 = sr4.xmdd001
                           AND imaal002 = g_dlang
                        
                        IF sr4.xmddseq1 = l_xmddseq1_o THEN
                           LET sr4.l_xmdd003_desc = ''
                           LET sr4.xmddseq1= ''
                           LET sr4.xmdd001 = ''
                           #隱藏品名、規格、產品特徵
                           LET sr4.l_item_show = '2'
                        ELSE
                           #隱藏產品特徵
                           IF cl_null(sr4.xmdd002) THEN
                              LET sr4.l_item_show = '3'
                           END IF
                        END IF
                     END IF
                 
                     OUTPUT TO REPORT axmr500_g01_subrep06(sr4.*)
                     LET l_xmddseq1_o = sr4.xmddseq1
                  END FOREACH
               END IF
            END IF
            FINISH REPORT axmr500_g01_subrep06
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.xmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmdcseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr500_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axmr500_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axmr500_g01_subrep03
           DECLARE axmr500_g01_repcur03 CURSOR FROM g_sql
           FOREACH axmr500_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr500_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axmr500_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axmr500_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmdadocno
 
           #add-point:rep.a_group.xmdadocno.before name="rep.a_group.xmdadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr500_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axmr500_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axmr500_g01_subrep04
           DECLARE axmr500_g01_repcur04 CURSOR FROM g_sql
           FOREACH axmr500_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr500_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axmr500_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axmr500_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xmdadocno.after name="rep.a_group.xmdadocno.after"
           START REPORT axmr500_g01_subrep08              
              LET l_count = 0
              IF NOT cl_null(sr1.xmda004) AND NOT cl_null(sr1.xmda044) THEN
                 CALL axmr500_g01_cre_tmp_table()
                 #161205-00042#2-mod-s
#                 LET g_sql = " SELECT xmao003,xmao004,xmao001,xmao002,xmap003,xmap004,xmap005,xmap006 ",
                 LET g_sql = " SELECT xmao003,xmao004,xmao001,xmao002,xmap003,xmap004,xmap005,xmap006,'','','','','' ",
                 #161205-00042#2-mod-e
                             "   FROM xmao_t,xmap_t ",
                             "  WHERE xmaoent = xmapent",
                             "    AND xmao001 = xmap001",
                             "    AND xmao002 = xmap002",
                             "    AND xmaoent = '",sr1.xmdaent,"' ",
                             #"    AND xmao001 = '",sr1.xmda004,"'",  #160922-00035#1-s-mod
                             "    AND xmao001 = '",sr1.xmda022,"'",   #160922-00035#1-e-mod
                             "    AND xmao002 = '",sr1.xmda044,"'",
                             "  ORDER BY xmap003,xmap004 "
                 DECLARE axmr500_g01_repcur08 CURSOR FROM g_sql 
                 #161205-00042#2-mod-s
#                 LET l_tmp_sql = " INSERT INTO axmr500_tmp01 (xmao001,xmao002,xmap003,l_xmap003_desc,xmap004,xmap006,l_xmap003_show) VALUES (?,?,?,?,?,?,?) "  
                 LET l_tmp_sql = " INSERT INTO axmr500_tmp01 (xmao001,xmao002,xmap003,l_xmap003_desc,xmap004,xmap006,l_xmap006_img,l_imgstr,l_xmap003_show) VALUES (?,?,?,?,?, ?,?,?,?) "  
                 LET l_xmao003 = ''
                 LET l_xmao004 = ''
                 #161205-00042#2-mod-e                 
                 #add--2015/08/12 By shiun--(S)                 
                 LET l_tmp_sql = " INSERT INTO axmr500_g01_temp (xmao001,xmao002,xmap003,l_xmap003_desc,xmap004,xmap006,l_xmap006_img,l_imgstr,l_xmap003_show) VALUES (?,?,?,?,?,?,?,?,?) "
                 PREPARE master_tmp FROM l_tmp_sql
                 #add--2015/08/12 By shiun--(E)
                 FOREACH axmr500_g01_repcur08 INTO l_xmao003,l_xmao004,sr6.*                    
                    CALL s_desc_gzcbl004_desc('2102',sr6.xmap003) RETURNING sr6.l_xmap003_desc
                    CALL s_desc_gzcbl004_desc('2100',sr6.xmap005) RETURNING sr6.l_xmap005_desc
                    LET l_n = 1
                    LET l_load =''
                    WHILE TRUE
                     LET l_xmap006 = sr6.xmap006
                     LET l_length = LENGTH(l_xmap006)
                     LET l_n1 = l_xmap006.getIndexOf('&',l_n)
                     LET l_n2 = l_xmap006.getIndexOf('&',l_n1+1)
                     IF l_n1 != 0 AND l_n2 != 0 THEN
                        LET l_str = l_xmap006.subString(l_n1+1,l_n2-1)
                        IF cl_null(l_load) THEN
                           LET l_load = l_xmap006.subString(l_n,l_n1-1)
                        ELSE
                           LET l_load = l_load || l_xmap006.subString(l_n,l_n1-1)
                        END IF                        
                        CALL s_axmi210_assemble(sr1.xmdadocno,l_str,l_xmao003,l_xmao004) RETURNING l_out
                        IF cl_null(l_load) THEN
                           LET l_load = l_out
                        ELSE
                           LET l_load = l_load || l_out
                        END IF    
                        LET l_n = l_n2 + 1
                     ELSE
                        IF NOT cl_null(l_load) THEN
                           LET sr6.xmap006 = l_load
                        END IF
                        EXIT WHILE
                     END IF
                    END WHILE
                    SELECT MIN(xmap004) INTO l_min
                      FROM xmap_t
                     WHERE xmapent = sr1.xmdaent
                       AND xmap001 = sr1.xmda004
                       AND xmap002 = sr1.xmda044
                       AND xmap003 = sr6.xmap003
                    IF sr6.xmap004 = l_min THEN
                       LET sr6.l_xmap003_show = 'Y'
                    ELSE
                       LET sr6.l_xmap003_show = 'N'
                    END IF
                    #161205-00042#2-add-s
                    CASE sr6.xmap005
                       WHEN '2'
                          LET l_js = ''
                          LET l_loaa001 = ''
                          LET g_pk_array[1].values = sr6.xmao001
                          LET g_pk_array[1].column = 'xmap001'
                          LET g_pk_array[2].values = sr6.xmao002
                          LET g_pk_array[2].column = 'xmap002'
                          LET g_pk_array[3].values = sr6.xmap003
                          LET g_pk_array[3].column = 'xmap003'
                          LET g_pk_array[4].values = sr6.xmap004
                          LET g_pk_array[4].column = 'xmap004'                          
                          LET l_js = util.JSON.stringify(g_pk_array)
                          LET l_loaa001 = l_js.trim()
                          LET l_xmap006_img_arr = cl_doc_open_attach(l_loaa001,"","","2")
                          LET sr6.l_xmap006_img = l_xmap006_img_arr[1]
                       WHEN '3'
                          CASE sr6.xmap006
                             WHEN "diamond"
                                 #source pic
                                 LET ls_url_surc = os.Path.join(os.Path.join(FGL_GETENV("TOP"),"res/img/ui/application"),"diamond.png")
                                #destination pic
                                 LET ls_url_dest = os.Path.join(FGL_GETENV("TEMPDIR"),"diamond.png")
                                 LET sr6.l_xmap006_img = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"out"),"diamond.png")
                                 IF NOT os.path.exists(ls_url_dest) THEN
                                   IF os.path.copy(ls_url_surc,ls_url_dest) THEN 
                                      LET sr6.l_xmap006_img  = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"out"),"diamond.png")
                                   ELSE
                                      #copy error, get notfound pic
                                      LET sr6.l_xmap006_img = os.Path.join(os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"pic"),"reptpic"),"no_logo.png")
                                   END IF
                                 END IF                       
                             WHEN "triangle"
                                 #source pic
                                 LET ls_url_surc = os.Path.join(os.Path.join(FGL_GETENV("TOP"),"res/img/ui/application"),"triangle.png")
                                 #destination pic
                                 LET ls_url_dest = os.Path.join(FGL_GETENV("TEMPDIR"),"triangle.png")
                                 LET sr6.l_xmap006_img = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"out"),"triangle.png")
                                 IF NOT os.path.exists(ls_url_dest) THEN
                                   IF os.path.copy(ls_url_surc,ls_url_dest) THEN 
                                      LET sr6.l_xmap006_img  = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"out"),"triangle.png")
                                   ELSE
                                      #copy error, get notfound pic
                                      LET sr6.l_xmap006_img = os.Path.join(os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"pic"),"reptpic"),"no_logo.png")
                                   END IF
                                 END IF                                  
                          END CASE
                       WHEN '4' 
                          LET sr6.l_imgstr = sr6.xmap006
                    END CASE
                    IF cl_null(sr6.l_xmap006_img) THEN
                       LET sr6.l_xmap006_img = ' '
                    END IF
                    #161205-00042#2-add-e
                    #161205-00042#2-mod-s
#                    EXECUTE master_tmp USING sr6.xmao001,sr6.xmao002,sr6.xmap003,sr6.l_xmap003_desc,sr6.xmap004,sr6.xmap006,sr6.l_xmap003_show        #add--2015/08/12 By shiun            
                    EXECUTE master_tmp USING sr6.xmao001,sr6.xmao002,sr6.xmap003,sr6.l_xmap003_desc,sr6.xmap004,sr6.xmap006,sr6.l_xmap006_img,sr6.l_imgstr,sr6.l_xmap003_show
                    #161205-00042#2-mod-e
                 END FOREACH
                 #add--2015/08/12 By shiun--(S)
                 LET l_xmap003_sql = " SELECT DISTINCT xmap003,l_xmap003_desc ",
                                     " FROM axmr500_g01_temp ",
                                     " ORDER BY xmap003"
                 #161205-00042#2-mod-s
#                 LET l_xmap006_sql = " SELECT DISTINCT xmap004,xmap006,l_xmap003_show,xmao001,xmao002 ",
                 LET l_xmap006_sql = " SELECT DISTINCT xmap004,xmap006,l_xmap006_img,l_imgstr,l_xmap003_show,xmao001,xmao002 ",
                 #161205-00042#2-mod-e
                                     " FROM axmr500_g01_temp ",
                                     " WHERE l_xmap003_desc = ?",
                                     " ORDER BY xmap004"
                 DECLARE axmr500_g01_xmap003 CURSOR FROM l_xmap003_sql 
                 
                 PREPARE axmr500_g01_xmap006_pb FROM l_xmap006_sql                 
                 DECLARE axmr500_g01_xmap006_cs CURSOR FOR axmr500_g01_xmap006_pb   
                 
                 LET l_i = 1
                 LET l_max_count = 1
                 
                 FOREACH axmr500_g01_xmap003 INTO l_xmap003,l_xmap003_desc
                    LET l_j = l_max_count
                    OPEN axmr500_g01_xmap006_cs USING l_xmap003_desc

                    #161205-00042#2-mod-s
#                    FOREACH axmr500_g01_xmap006_cs INTO l_xmap004,l_xmap006_array,l_xmap003_show,l_xmao001,l_xmao002
                    FOREACH axmr500_g01_xmap006_cs INTO l_xmap004,l_xmap006_array,l_xmap006_img,l_imgstr,l_xmap003_show,l_xmao001,l_xmao002
                    #161205-00042#2-mod-e                    
                       IF l_i MOD 2 = 1 THEN
                          #161205-00042#2-add-s
                          #圖中字放置，在4rp中根據預設圖檔的不同會放置不同位置&大小的圖中字
                          IF NOT cl_null(l_imgstr) THEN
                             LET sr8[l_j-1].l_imgstr_1 = l_imgstr
                             CONTINUE FOREACH
                          END IF
                          #161205-00042#2-add-e
                          IF l_xmap003_show = 'Y' THEN
                             LET sr8[l_j].l_xmap003_desc_1 = l_xmap003_desc
                          ELSE
                             LET sr8[l_j].l_xmap003_desc_1 = ' '
                          END IF
                          LET sr8[l_j].xmao001 = l_xmao001
                          LET sr8[l_j].xmao002 = l_xmao002
                          LET sr8[l_j].xmap006_1 = l_xmap006_array
                          #161205-00042#2-add-s
                          LET sr8[l_j].l_xmap006_1_img = l_xmap006_img
                          DISPLAY "sr8[l_j].l_xmap006_1_img:",sr8[l_j].l_xmap006_1_img
                          #161205-00042#2-add-e
                       ELSE
                          #161205-00042#2-add-s
                          #圖中字放置，在4rp中根據預設圖檔的不同會放置不同位置&大小的圖中字
                          IF NOT cl_null(l_imgstr) THEN
                             LET sr8[l_j-1].l_imgstr_2 = l_imgstr
                             CONTINUE FOREACH
                          END IF
                          #161205-00042#2-add-e                       
                          IF l_xmap003_show = 'Y' THEN
                             LET sr8[l_j].l_xmap003_desc_2 = l_xmap003_desc
                          ELSE
                             LET sr8[l_j].l_xmap003_desc_2 = ' '
                          END IF
                          LET sr8[l_j].xmao001 = l_xmao001
                          LET sr8[l_j].xmao002 = l_xmao002
                          LET sr8[l_j].xmap006_2 = l_xmap006_array
                          #161205-00042#2-add-s
                          LET sr8[l_j].l_xmap006_2_img = l_xmap006_img
                          DISPLAY "sr8[l_j].l_xmap006_2_img:",sr8[l_j].l_xmap006_2_img
                          #161205-00042#2-add-e                          
                       END IF
                       LET l_j = l_j + 1
                    END FOREACH
                 
                    LET l_i = l_i + 1 
                 
                    IF l_i MOD 2 = 1 THEN
                       LET l_max_count = sr8.getLength() + 1
                    END IF
                 END FOREACH
                 LET l_ac = 1
                 LET l_while_count = sr8.getLength()
                 WHILE TRUE
                    LET sr7.xmao001 = sr8[l_ac].xmao001
                    LET sr7.xmao002 = sr8[l_ac].xmao002
                    LET sr7.l_xmap003_desc_1 = sr8[l_ac].l_xmap003_desc_1
                    LET sr7.l_xmap003_desc_2 = sr8[l_ac].l_xmap003_desc_2
                    LET sr7.xmap006_1 = sr8[l_ac].xmap006_1
                    LET sr7.xmap006_2 = sr8[l_ac].xmap006_2
                    #161205-00042#2-add-s
                    LET sr7.l_xmap006_1_img = sr8[l_ac].l_xmap006_1_img
                    LET sr7.l_xmap006_2_img = sr8[l_ac].l_xmap006_2_img            
                    LET sr7.l_imgstr_1 = sr8[l_ac].l_imgstr_1
                    LET sr7.l_imgstr_2 = sr8[l_ac].l_imgstr_2   
                    #161205-00042#2-add-e
                    OUTPUT TO REPORT axmr500_g01_subrep08(sr7.*)
                    LET l_ac = l_ac + 1
                    IF l_ac > l_while_count THEN
                       EXIT WHILE
                    END IF
                 END WHILE
                 #add--2015/08/12 BY shiun--(E)                 
              END IF
              CLOSE master_tmp   #add--2015/08/12 By shiun
           FINISH REPORT axmr500_g01_subrep08 
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmdcseq
 
           #add-point:rep.a_group.xmdcseq.before name="rep.a_group.xmdcseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xmdcseq.after name="rep.a_group.xmdcseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            CALL s_axmi210_drop_tmp_table()  #add--2015/08/11 By shiun
            CALL axmr500_g01_drop_tmp_table()   #add--2015/08/12 By shiun
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axmr500_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axmr500_g01_subrep01(sr2)
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
PRIVATE REPORT axmr500_g01_subrep02(sr2)
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
PRIVATE REPORT axmr500_g01_subrep03(sr2)
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
PRIVATE REPORT axmr500_g01_subrep04(sr2)
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
 
{<section id="axmr500_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 將代號跟說明組合
# Memo...........:
# Usage..........: CALL axmr500_g01_combination(p_value,p_desc)
#                  RETURNING r_combination
# Input parameter: p_value        代號
#                : p_desc         說明
# Return code....: r_combination  代號.說明
#                : 
# Date & Author..: 2014/04/29 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr500_g01_combination(p_value,p_desc)
DEFINE p_value           LIKE type_t.chr80
DEFINE p_desc            LIKE type_t.chr80
DEFINE r_combination     LIKE type_t.chr80

   LET r_combination = p_value CLIPPED,".",p_desc CLIPPED
   
   RETURN r_combination
END FUNCTION

################################################################################
# Descriptions...: 抓取稅別說明
# Memo...........:
# Usage..........: CALL axmr500_g01_xmda011_ref(p_xmdaent,p_xmdasite,p_xmda011)
#                  RETURNING r_xmda011_desc
# Input parameter: p_xmdaent      企業編號
#                : p_xmdasite     營運據點
#                : p_xmda011      稅別
# Return code....: r_xmda011_desc 稅別說明
#                : 
# Date & Author..: 2014/04/29 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr500_g01_xmda011_ref(p_xmdaent,p_xmdasite,p_xmda011)
DEFINE p_xmdaent         LIKE xmda_t.xmdaent
DEFINE p_xmdasite        LIKE xmda_t.xmdasite
DEFINE p_xmda011         LIKE xmda_t.xmda011
DEFINE r_xmda011_desc    LIKE oodbl_t.oodbl004
DEFINE l_ooef019         LIKE ooef_t.ooef019

   #稅區
   LET l_ooef019 = ''
   SELECT ooef019 INTO l_ooef019 
     FROM ooef_t
    WHERE ooefent = p_xmdaent
      AND ooef001 = p_xmdasite

   #稅別說明
   LET r_xmda011_desc = ''
   SELECT oodbl004 INTO r_xmda011_desc
     FROM oodbl_t
    WHERE oodblent = p_xmdaent
      AND oodbl001 = l_ooef019
      AND oodbl002 = p_xmda011
      AND oodbl003 = g_dlang
   
   RETURN r_xmda011_desc
END FUNCTION

################################################################################
# Descriptions...: 抓取ACC說明
# Memo...........:
# Usage..........: CALL axmr500_g01_acc_ref(p_oocqlent,p_oocql001,p_oocql002)
#                  RETURNING r_oocql004
# Input parameter: p_oocqlent     企業編號
#                : p_oocql001     應用分類
#                : p_oocql002     應用分類碼
# Return code....: r_oocql004     說明
#                : 
# Date & Author..: 2014/04/29 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr500_g01_acc_ref(p_oocqlent,p_oocql001,p_oocql002)
DEFINE p_oocqlent        LIKE oocql_t.oocqlent
DEFINE p_oocql001        LIKE oocql_t.oocql001
DEFINE p_oocql002        LIKE oocql_t.oocql002
DEFINE r_oocql004        LIKE oocql_t.oocql004

   LET r_oocql004 = ''
   SELECT oocql004 INTO r_oocql004
     FROM oocql_t
    WHERE oocqlent = p_oocqlent
      AND oocql001 = p_oocql001
      AND oocql002 = p_oocql002
      AND oocql003 = g_dlang
   
   RETURN r_oocql004
END FUNCTION

################################################################################
# Descriptions...: 抓取收款條件說明
# Memo...........:
# Usage..........: CALL axmr500_g01_xmdb002_ref(p_xmdbent,p_xmdb002)
#                  RETURNING r_xmdb002_desc
# Input parameter: p_xmdbent      企業編號
#                : p_xmdb002      收款條件
# Return code....: r_xmdb002_desc 說明
#                : 
# Date & Author..: 2014/04/30 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr500_g01_xmdb002_ref(p_xmdbent,p_xmdb002)
DEFINE p_xmdbent         LIKE xmdb_t.xmdbent
DEFINE p_xmdb002         LIKE xmdb_t.xmdb002
DEFINE r_xmdb002_desc    LIKE ooibl_t.ooibl004

   LET r_xmdb002_desc = ''
   SELECT ooibl004 INTO r_xmdb002_desc
     FROM ooibl_t
    WHERE ooiblent = p_xmdbent
      AND ooibl002 = p_xmdb002
      AND ooibl003 = g_dlang
   
   RETURN r_xmdb002_desc
END FUNCTION

################################################################################
# Descriptions...: 抓取子件特性說明
# Memo...........:
# Usage..........: CALL axmr500_g01_scc_ref(p_gzcbl001,p_gzcbl002)
#                  RETURNING r_gzcbl004
# Input parameter: p_gzcbl001     應用分類
#                : p_gzcbl002     應用分類碼
# Return code....: r_gzcbl004     說明
#                : 
# Date & Author..: 2014/04/30 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr500_g01_scc_ref(p_gzcbl001,p_gzcbl002)
DEFINE p_gzcbl001        LIKE gzcbl_t.gzcbl001
DEFINE p_gzcbl002        LIKE gzcbl_t.gzcbl002
DEFINE r_gzcbl004        LIKE gzcbl_t.gzcbl004

   LET r_gzcbl004 = ''
   SELECT gzcbl004 INTO r_gzcbl004
     FROM gzcbl_t
    WHERE gzcbl001 = p_gzcbl001
      AND gzcbl002 = p_gzcbl002
      AND gzcbl003 = g_dlang
   
   RETURN r_gzcbl004
END FUNCTION

PRIVATE FUNCTION axmr500_g01_initialize(p_arg,p_exp)
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
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL axmr500_g01_cre_tmp_table()
#                  RETURNING r_success
# Input parameter: 無
# Date & Author..: 2015/08/22 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr500_g01_cre_tmp_table()
 DROP TABLE axmr500_g01_temp;

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop axmr500_g01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   CREATE TEMP TABLE axmr500_g01_temp(
                   xmao001        LIKE xmao_t.xmao001,          #客戶編號
                   xmao002        LIKE xmao_t.xmao002,          #嘜頭編號
                   xmap003        LIKE xmap_t.xmap003,          #類別
                   l_xmap003_desc LIKE type_t.chr500,           #類別說明
                   xmap004        LIKE xmap_t.xmap004,          #行序
                   xmap006        LIKE xmap_t.xmap006,          #資料內容
                   l_xmap006_img  LIKE type_t.chr1000,          #資料內容(圖)   #161205-00042#2-add
                   l_imgstr       LIKE xmap_t.xmap006,          #圖中字內容   #161205-00042#2-add
                   l_xmap003_show LIKE type_t.chr1              #類別顯示否
                   )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axmr500_g01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
END FUNCTION
################################################################################
# Descriptions...: 刪除臨時表
# Memo...........:
# Usage..........: CALL axmr500_g01_drop_tmp_table()
# Input parameter:
# Return code....:
# Date & Author..: 2015/08/12 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr500_g01_drop_tmp_table()
   
   DROP TABLE axmr500_g01_temp;
   
END FUNCTION

 
{</section>}
 
{<section id="axmr500_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 多帳期子報表
# Memo...........:
# Usage..........: CALL axmr500_g01_subrep05(sr3)
#                  
# Input parameter: sr3            資料RECORD
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/04/29 By stellar0130
# Modify.........:
################################################################################
PRIVATE REPORT axmr500_g01_subrep05(sr3)
DEFINE sr3             sr3_r

   ORDER EXTERNAL BY sr3.xmdbdocno
      FORMAT
   
         ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

################################################################################
# Descriptions...: 多交期報表
# Memo...........:
# Usage..........: CALL axmr500_g01_subrep06(sr4)
#                  
# Input parameter: sr4            資料RECORD
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/04/29 By stellar0130
# Modify.........:
################################################################################
PRIVATE REPORT axmr500_g01_subrep06(sr4)
DEFINE sr4             sr4_r

   ORDER EXTERNAL BY sr4.xmdddocno,sr4.xmddseq
      FORMAT
   
         ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
END REPORT

################################################################################
# Descriptions...: 費用資料子報表
# Memo...........:
# Usage..........: CALL axmr500_g01_subrep07(sr5)
#                  
# Input parameter: sr5            資料RECORD
# Return code....: 
# Date & Author..: 20150723 By dorislai
# Modify.........:
################################################################################
PRIVATE REPORT axmr500_g01_subrep07(sr5)
DEFINE sr5       sr5_r    
    ORDER EXTERNAL BY sr5.xmdsdocno
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT
################################################################################
# Descriptions...: 嘜頭資料子報表
# Memo...........:
# Usage..........: CALL axmr500_g01_subrep08(sr7)
#                  
# Input parameter: sr6            資料RECORD
# Return code....: 
# Date & Author..: 2015/08/11 By shiun
# Modify.........:
################################################################################
PRIVATE REPORT axmr500_g01_subrep08(sr7)
   DEFINE sr7 sr7_r
   ORDER EXTERNAL BY sr7.xmao001,sr7.xmao002
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr7.*
END REPORT

 
{</section>}
 
