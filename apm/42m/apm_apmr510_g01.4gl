#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr510_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:16(2017-02-13 15:28:10), PR版次:0016(2017-02-13 16:17:40)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000120
#+ Filename...: apmr510_g01
#+ Description: ...
#+ Creator....: 05229(2014-06-23 15:37:59)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="apmr510_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160328-00005#1  2016/04/01  By  dorislai  修正 變更前的未稅金額，給錯欄位，導致抓到含稅金額的部分
#160816-00001#8  2016/08/17  By 08734      抓取理由碼改CALL sub
#161020-00013#1  2016/10/20  By  zhujing   g_select重写，配合g_from的子查询写法
#161207-00033#25 2016/12/22  By lixh       一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#170110-00001#1  2017/01/16  By zhujing    变更子报表中增加备注栏位，配合主报表费用料号需显示备注的处理。
#170119-00010#1  2017/01/19  By dorislai   修正BPM簽核，印不出來的問題
#161031-00025#14 2017/02/13  By xujing    处理备注sql
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
   pmee001 LIKE pmee_t.pmee001, 
   pmee002 LIKE pmee_t.pmee002, 
   pmee003 LIKE pmee_t.pmee003, 
   pmee004 LIKE pmee_t.pmee004, 
   pmee005 LIKE pmee_t.pmee005, 
   pmee006 LIKE pmee_t.pmee006, 
   pmee007 LIKE pmee_t.pmee007, 
   pmee008 LIKE pmee_t.pmee008, 
   pmee009 LIKE pmee_t.pmee009, 
   pmee010 LIKE pmee_t.pmee010, 
   pmee011 LIKE pmee_t.pmee011, 
   pmee012 LIKE pmee_t.pmee012, 
   pmee013 LIKE pmee_t.pmee013, 
   pmee015 LIKE pmee_t.pmee015, 
   pmee016 LIKE pmee_t.pmee016, 
   pmee017 LIKE pmee_t.pmee017, 
   pmee018 LIKE pmee_t.pmee018, 
   pmee019 LIKE pmee_t.pmee019, 
   pmee020 LIKE pmee_t.pmee020, 
   pmee021 LIKE pmee_t.pmee021, 
   pmee022 LIKE pmee_t.pmee022, 
   pmee023 LIKE pmee_t.pmee023, 
   pmee024 LIKE pmee_t.pmee024, 
   pmee025 LIKE pmee_t.pmee025, 
   pmee026 LIKE pmee_t.pmee026, 
   pmee027 LIKE pmee_t.pmee027, 
   pmee028 LIKE pmee_t.pmee028, 
   pmee029 LIKE pmee_t.pmee029, 
   pmee030 LIKE pmee_t.pmee030, 
   pmee031 LIKE pmee_t.pmee031, 
   pmee032 LIKE pmee_t.pmee032, 
   pmee033 LIKE pmee_t.pmee033, 
   pmee040 LIKE pmee_t.pmee040, 
   pmee041 LIKE pmee_t.pmee041, 
   pmee042 LIKE pmee_t.pmee042, 
   pmee043 LIKE pmee_t.pmee043, 
   pmee044 LIKE pmee_t.pmee044, 
   pmee046 LIKE pmee_t.pmee046, 
   pmee900 LIKE pmee_t.pmee900, 
   pmee901 LIKE pmee_t.pmee901, 
   pmee902 LIKE pmee_t.pmee902, 
   pmee903 LIKE pmee_t.pmee903, 
   pmee904 LIKE pmee_t.pmee904, 
   pmeeacti LIKE pmee_t.pmeeacti, 
   pmeedocdt LIKE pmee_t.pmeedocdt, 
   pmeedocno LIKE pmee_t.pmeedocno, 
   pmeeent LIKE pmee_t.pmeeent, 
   pmeesite LIKE pmee_t.pmeesite, 
   pmeestus LIKE pmee_t.pmeestus, 
   pmeg001 LIKE pmeg_t.pmeg001, 
   pmeg002 LIKE pmeg_t.pmeg002, 
   pmeg003 LIKE pmeg_t.pmeg003, 
   pmeg004 LIKE pmeg_t.pmeg004, 
   pmeg005 LIKE pmeg_t.pmeg005, 
   pmeg006 LIKE pmeg_t.pmeg006, 
   pmeg007 LIKE pmeg_t.pmeg007, 
   pmeg008 LIKE pmeg_t.pmeg008, 
   pmeg009 LIKE pmeg_t.pmeg009, 
   pmeg010 LIKE pmeg_t.pmeg010, 
   pmeg011 LIKE pmeg_t.pmeg011, 
   pmeg012 LIKE pmeg_t.pmeg012, 
   pmeg013 LIKE pmeg_t.pmeg013, 
   pmeg014 LIKE pmeg_t.pmeg014, 
   pmeg015 LIKE pmeg_t.pmeg015, 
   pmeg016 LIKE pmeg_t.pmeg016, 
   pmeg017 LIKE pmeg_t.pmeg017, 
   pmeg019 LIKE pmeg_t.pmeg019, 
   pmeg020 LIKE pmeg_t.pmeg020, 
   pmeg021 LIKE pmeg_t.pmeg021, 
   pmeg022 LIKE pmeg_t.pmeg022, 
   pmeg023 LIKE pmeg_t.pmeg023, 
   pmeg024 LIKE pmeg_t.pmeg024, 
   pmeg025 LIKE pmeg_t.pmeg025, 
   pmeg026 LIKE pmeg_t.pmeg026, 
   pmeg027 LIKE pmeg_t.pmeg027, 
   pmeg028 LIKE pmeg_t.pmeg028, 
   pmeg029 LIKE pmeg_t.pmeg029, 
   pmeg030 LIKE pmeg_t.pmeg030, 
   pmeg031 LIKE pmeg_t.pmeg031, 
   pmeg032 LIKE pmeg_t.pmeg032, 
   pmeg033 LIKE pmeg_t.pmeg033, 
   pmeg034 LIKE pmeg_t.pmeg034, 
   pmeg035 LIKE pmeg_t.pmeg035, 
   pmeg036 LIKE pmeg_t.pmeg036, 
   pmeg037 LIKE pmeg_t.pmeg037, 
   pmeg038 LIKE pmeg_t.pmeg038, 
   pmeg039 LIKE pmeg_t.pmeg039, 
   pmeg040 LIKE pmeg_t.pmeg040, 
   pmeg041 LIKE pmeg_t.pmeg041, 
   pmeg042 LIKE pmeg_t.pmeg042, 
   pmeg043 LIKE pmeg_t.pmeg043, 
   pmeg044 LIKE pmeg_t.pmeg044, 
   pmeg045 LIKE pmeg_t.pmeg045, 
   pmeg046 LIKE pmeg_t.pmeg046, 
   pmeg047 LIKE pmeg_t.pmeg047, 
   pmeg048 LIKE pmeg_t.pmeg048, 
   pmeg049 LIKE pmeg_t.pmeg049, 
   pmeg050 LIKE pmeg_t.pmeg050, 
   pmeg901 LIKE pmeg_t.pmeg901, 
   pmeg902 LIKE pmeg_t.pmeg902, 
   pmeg903 LIKE pmeg_t.pmeg903, 
   pmegorga LIKE pmeg_t.pmegorga, 
   pmegseq LIKE pmeg_t.pmegseq, 
   pmegsite LIKE pmeg_t.pmegsite, 
   pmegunit LIKE pmeg_t.pmegunit, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   t1_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t10_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t22_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t24_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t4_pmaal004 LIKE pmaal_t.pmaal004, 
   t5_pmaal004 LIKE pmaal_t.pmaal004, 
   t9_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t13_pmaal004 LIKE pmaal_t.pmaal004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t12_imaal003 LIKE imaal_t.imaal003, 
   l_pmee029_ooefl003 LIKE type_t.chr1000, 
   l_pmee032_pmaal004 LIKE type_t.chr100, 
   l_pmee022_pmaal004 LIKE type_t.chr100, 
   l_pmee004_pmaal004 LIKE type_t.chr100, 
   l_pmee003_ooefl003 LIKE type_t.chr1000, 
   l_pmee002_ooag011 LIKE type_t.chr300, 
   l_pmee021_pmaal004 LIKE type_t.chr100, 
   l_pmeg023_pmaal004 LIKE type_t.chr100, 
   l_pmegunit_ooefl003 LIKE type_t.chr1000, 
   l_pmegorga_ooefl003 LIKE type_t.chr1000, 
   l_pmee009_desc LIKE type_t.chr100, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   l_pmee010_desc LIKE type_t.chr100, 
   l_pmee023_desc LIKE type_t.chr100, 
   l_pmee903_desc LIKE type_t.chr100, 
   x_t12_imaal004 LIKE imaal_t.imaal004, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_order LIKE type_t.chr30, 
   l_pmee011_desc LIKE type_t.chr100, 
   l_pmeg020_desc LIKE type_t.chr100, 
   l_pmeg027_desc LIKE type_t.chr80
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr1          #變更的資料
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
TYPE sr3_r RECORD  #單頭變更前欄位#
   pmek002_1       LIKE pmek_t.pmek002,   #變更欄位第一排
   pmek002_1_desc  LIKE dzeb_t.dzeb003,   #欄位名稱
   pmek004_1       LIKE pmek_t.pmek004,   #變更前內容
   pmek002_2       LIKE pmek_t.pmek002,   #變更欄位第二排
   pmek002_2_desc  LIKE dzeb_t.dzeb003,   #欄位名稱
   pmek004_2       LIKE pmek_t.pmek004,   #變更前內容
   l_chk           LIKE type_t.chr1       #是否列印金額
END RECORD

TYPE sr4_r RECORD   #單頭變更資訊   
   pmek002   LIKE pmek_t.pmek002,   #變更欄位
   pmek004   LIKE pmek_t.pmek004    #變更前內容
END RECORD

TYPE sr5_r RECORD  #多帳期#
   pmefdocno             LIKE pmef_t.pmefdocno,
   pmef001_chg           LIKE pmef_t.pmef001,       #期別
   pmef002_chg           LIKE pmef_t.pmef002,       #收款條件
   pmef002_desc_chg      LIKE dzeb_t.dzeb003,       #收款條件說明
   pmef003_chg           LIKE pmef_t.pmef003,       #預計應收款日期
   pmef004_chg           LIKE pmef_t.pmef004,       #票據到期日
   pmef005_chg           LIKE pmef_t.pmef005,       #未稅金額
   pmef900               LIKE pmef_t.pmef900,       #變更序 
   pmef001               LIKE pmef_t.pmef001,       #期別 
   pmef002               LIKE pmef_t.pmef002,       #收款條件
   pmef002_desc          LIKE dzeb_t.dzeb003,       #收款條件說明
   pmef003               LIKE pmef_t.pmef003,       #預計應收款日期
   pmef004               LIKE pmef_t.pmef004,       #票據到期日
   pmef005               LIKE pmef_t.pmef005,       #含稅金額
   l_pmef_show           LIKE type_t.chr1,
   l_pmef_show_2         LIKE type_t.chr1,
   l_pmef001_btl         LIKE type_t.num20_6,
   l_pmef002_btl         LIKE type_t.num20_6,
   l_pmef003_btl         LIKE type_t.num20_6,
   l_pmef004_btl         LIKE type_t.num20_6,
   l_pmef005_btl         LIKE type_t.num20_6
END RECORD

TYPE sr6_r RECORD  #單身變更欄位
   pmeg001         LIKE pmeg_t.pmeg001,     #料件編號
   imaal003        LIKE imaal_t.imaal003,   #品名
   imaal004        LIKE imaal_t.imaal004,   #規格
   pmeg002         LIKE pmeg_t.pmeg002,     #產品特徵
   pmeg012         LIKE pmeg_t.pmeg012,     #出貨日期
   pmeg007         LIKE pmeg_t.pmeg007,     #數量   
   pmeg006         LIKE pmeg_t.pmeg006,     #單位
   pmeg015         LIKE pmeg_t.pmeg015,     #單價   
   pmeg046         LIKE pmeg_t.pmeg046,     #未稅金額
   pmeg027         LIKE pmeg_t.pmeg027,     #供應商料號
   pmeg027_desc    LIKE pmeg_t.pmeg027,     
   pmeg020         LIKE pmeg_t.pmeg020,     #緊急度   
   pmeg020_desc    LIKE type_t.chr100,
   pmegunit        LIKE pmeg_t.pmegunit,    #收貨據點
   pmegunit_desc   LIKE type_t.chr100,      
   pmegorga        LIKE pmeg_t.pmegorga,    #付款據點
   pmegorga_desc   LIKE type_t.chr100,
   pmeg050         LIKE pmeg_t.pmeg050,     #备注 #170110-00001#1 add
   l_pmeg002_show  LIKE type_t.chr1,
   l_pmeg020_show  LIKE type_t.chr1,
   l_pmeg027_show  LIKE type_t.chr1
END RECORD

TYPE sr7_r RECORD #子件件特性
   pmehdocno          LIKE pmeh_t.pmehdocno,
   pmehseq            LIKE pmeh_t.pmehseq,
   pmeh003_chg        LIKE pmeh_t.pmeh003,    #子件特性
   pmeh003_desc_chg   LIKE type_t.chr100,
   pmehseq1_chg       LIKE pmeh_t.pmehseq1,   #項序
   pmeh001_chg        LIKE pmeh_t.pmeh001,    #料件編號
   imaal003_chg       LIKE imaal_t.imaal003,  #品名
   imaal004_chg       LIKE imaal_t.imaal004,  #規格
   pmeh002_chg        LIKE pmeh_t.pmeh002,    #產品特徵
   pmehseq2_chg       LIKE pmeh_t.pmehseq2,   #項序
   pmeh006_chg        LIKE pmeh_t.pmeh006,    #分批數量
   pmeh004_chg        LIKE pmeh_t.pmeh004,    #單位
   pmeh011_chg        LIKE pmeh_t.pmeh011,    #約定交貨日
   pmeh003            LIKE pmeh_t.pmeh003,    #子件特性
   pmeh003_desc       LIKE type_t.chr100,     #子件特性
   pmehseq1           LIKE pmeh_t.pmehseq1,   #項序
   pmeh001            LIKE pmeh_t.pmeh001,    #料件編號
   imaal003           LIKE imaal_t.imaal003,  #品名
   imaal004           LIKE imaal_t.imaal004,  #規格
   pmeh002            LIKE pmeh_t.pmeh002,    #產品特徵
   pmehseq2           LIKE pmeh_t.pmehseq2,   #項序
   pmeh006            LIKE pmeh_t.pmeh006,    #分批數量
   pmeh004            LIKE pmeh_t.pmeh004,    #單位
   pmeh011            LIKE pmeh_t.pmeh011,    #約定交貨日
   pmeh_chg_show      LIKE type_t.chr1,
   pmeh_show          LIKE type_t.chr1,
   pmehseq1_pmeh001_show LIKE type_t.chr1,  
   pmeh003_btl        LIKE type_t.num20_6,
   pmehseq1_btl       LIKE type_t.num20_6,
   pmeh001_btl        LIKE type_t.num20_6,
   pmeh002_btl        LIKE type_t.num20_6,   
   pmehseq2_btl       LIKE type_t.num20_6,
   pmeh006_btl        LIKE type_t.num20_6,
   pmeh004_btl        LIKE type_t.num20_6,
   pmeh011_btl        LIKE type_t.num20_6,
   pmeh002_chg_show   LIKE type_t.chr1,
   pmeh002_show       LIKE type_t.chr1
END RECORD

TYPE sr8_r RECORD  #關聯單據明細
   pmeidocno          LIKE pmei_t.pmeidocno,
   pmeiseq           LIKE pmei_t.pmeiseq1,
   pmeiseq1            LIKE pmei_t.pmeiseq,
   pmei003_chg        LIKE pmei_t.pmei003,
   pmei004_chg        LIKE pmei_t.pmei004,
   pmei005_chg        LIKE pmei_t.pmei005,
   pmei006_chg        LIKE pmei_t.pmei006,
   pmei023_chg        LIKE pmei_t.pmei023,
   pmei022_chg        LIKE pmei_t.pmei022,
   pmei003            LIKE pmei_t.pmei003,  #來源單號
   pmei004            LIKE pmei_t.pmei004,  #來源項次
   pmei005            LIKE pmei_t.pmei005,  #來源項序
   pmei006            LIKE pmei_t.pmei006,  #來源分批序
   pmei023            LIKE pmei_t.pmei023,  #需求數量
   pmei022            LIKE pmei_t.pmei022,  #需求單位
   pmei003_btl        LIKE type_t.num20_6, 
   pmei004_btl        LIKE type_t.num20_6,
   pmei005_btl        LIKE type_t.num20_6,
   pmei006_btl        LIKE type_t.num20_6,
   pmei023_btl        LIKE type_t.num20_6,
   pmei022_btl        LIKE type_t.num20_6,
   pmei_show          LIKE type_t.chr1,
   pmei_chg_show      LIKE type_t.chr1
END RECORD

DEFINE g_cnt      LIKE type_t.num5
DEFINE g_sql_cnt  STRING
DEFINE sr4 DYNAMIC ARRAY OF sr4_r

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_acc                LIKE gzcb_t.gzcb008           #變更理由碼
#end add-point
 
{</section>}
 
{<section id="apmr510_g01.main" readonly="Y" >}
PUBLIC FUNCTION apmr510_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  變更的資料
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "apmr510_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL apmr510_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL apmr510_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL apmr510_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr510_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr510_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #161020-00013#1 marked-S
#   LET g_select = " SELECT pmee001,pmee002,pmee003,pmee004,pmee005,pmee006,pmee007,pmee008,pmee009,pmee010, 
#      pmee011,pmee012,pmee046,pmee015,pmee016,pmee017,pmee018,pmee019,pmee020,pmee021,pmee022,pmee023, 
#      pmee024,pmee025,pmee026,pmee027,pmee028,pmee029,pmee030,pmee031,pmee032,pmee033,pmee040,pmee041, 
#      pmee042,pmee043,pmee044,pmee046,pmee900,pmee901,pmee902,pmee903,pmee904,pmeeacti,pmeedocdt,pmeedocno, 
#      pmeeent,pmeesite,pmeestus,pmeg001,pmeg002,pmeg003,pmeg004,pmeg005,pmeg006,pmeg007,pmeg008,pmeg009, 
#      pmeg010,pmeg011,pmeg012,pmeg013,pmeg014,pmeg015,pmeg016,pmeg017,pmeg019,pmeg020,pmeg021,pmeg022, 
#      pmeg023,pmeg024,pmeg025,pmeg026,pmeg027,pmeg028,pmeg029,pmeg030,pmeg031,pmeg032,pmeg033,pmeg034, 
#      pmeg035,pmeg036,pmeg037,pmeg038,pmeg039,pmeg040,pmeg041,pmeg042,pmeg043,pmeg044,pmeg045,pmeg046, 
#      pmeg047,pmeg048,pmeg049,pmeg050,pmeg901,pmeg902,pmeg903,pmegorga,pmegseq,pmegsite,pmegunit,oofa_t.oofa011, 
#      t1.ooag011,ooefl_t.ooefl003,t10.ooefl003,x.t22_ooefl003,x.t24_ooefl003,pmaal_t.pmaal004,t4.pmaal004, 
#      t5.pmaal004,t9.pmaal004,x.t13_pmaal004,x.imaal_t_imaal003,x.t12_imaal003,trim(pmee029)||'.'||trim(t10.ooefl003), 
#      trim(pmee032)||'.'||trim(t9.pmaal004),trim(pmee022)||'.'||trim(t5.pmaal004),trim(pmee004)||'.'||trim(t4.pmaal004), 
#      trim(pmee003)||'.'||trim(ooefl_t.ooefl003),trim(pmee002)||'.'||trim(t1.ooag011),trim(pmee021)||'.'||trim(pmaal_t.pmaal004), 
#      trim(pmeg023)||'.'||trim(x.t13_pmaal004),trim(pmegunit)||'.'||trim(x.t24_ooefl003),trim(pmegorga)||'.'||trim(x.t22_ooefl003), 
#      NULL,ooibl_t.ooibl004,'','','',x.t12_imaal004,x.imaal_t_imaal004,trim(pmeedocno)||trim(TO_CHAR(pmee_t.pmee900,'0000')),'',''"
   #161020-00013#1 marked-E
   #161020-00013#1 add-S
   LET g_select = " SELECT pmee001,pmee002,pmee003,pmee004,pmee005,pmee006,pmee007,pmee008,pmee009,pmee010, ",
       "pmee011,pmee012,pmee013,pmee015,pmee016,pmee017,pmee018,pmee019,pmee020,pmee021,pmee022,pmee023, ",
       "pmee024,pmee025,pmee026,pmee027,pmee028,pmee029,pmee030,pmee031,pmee032,pmee033,pmee040,pmee041, ",
       "pmee042,pmee043,pmee044,pmee046,pmee900,pmee901,pmee902,pmee903,pmee904,pmeeacti,pmeedocdt,pmeedocno, ",
       "pmeeent,pmeesite,pmeestus,pmeg001,pmeg002,pmeg003,pmeg004,pmeg005,pmeg006,pmeg007,pmeg008,pmeg009, ",
       "pmeg010,pmeg011,pmeg012,pmeg013,pmeg014,pmeg015,pmeg016,pmeg017,pmeg019,pmeg020,pmeg021,pmeg022, ",
       "pmeg023,pmeg024,pmeg025,pmeg026,pmeg027,pmeg028,pmeg029,pmeg030,pmeg031,pmeg032,pmeg033,pmeg034, ",
       "pmeg035,pmeg036,pmeg037,pmeg038,pmeg039,pmeg040,pmeg041,pmeg042,pmeg043,pmeg044,pmeg045,pmeg046, ",
       "pmeg047,pmeg048,pmeg049,pmeg050,pmeg901,pmeg902,pmeg903,pmegorga,pmegseq,pmegsite,pmegunit,",
       "( SELECT oofa011 FROM oofa_t WHERE oofa_t.oofa001 = pmee_t.pmee027 AND oofa_t.oofaent = pmee_t.pmeeent), ",
       "( SELECT ooag011 FROM ooag_t t1 WHERE t1.ooag001 = pmee_t.pmee002 AND t1.ooagent = pmee_t.pmeeent), ",
       "( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmee_t.pmee003 AND ooefl_t.ooeflent = pmee_t.pmeeent AND ooefl_t.ooefl002 = '" , g_dlang,"'" ,"),",
       "( SELECT ooefl003 FROM ooefl_t t10 WHERE t10.ooefl001 = pmee_t.pmee029 AND t10.ooeflent = pmee_t.pmeeent AND t10.ooefl002 = '" , g_dlang,"'" ,"),",
       "x.t22_ooefl003,x.t24_ooefl003,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmee_t.pmee021 AND pmaal_t.pmaalent = pmee_t.pmeeent AND pmaal_t.pmaal002 = '" , g_dlang,"'" ,"),",
       "( SELECT pmaal004 FROM pmaal_t t4 WHERE t4.pmaal001 = pmee_t.pmee004 AND t4.pmaalent = pmee_t.pmeeent AND t4.pmaal002 = '" , g_dlang,"'" ,"),",
       "( SELECT pmaal004 FROM pmaal_t t5 WHERE t5.pmaal001 = pmee_t.pmee022 AND t5.pmaalent = pmee_t.pmeeent AND t5.pmaal002 = '" , g_dlang,"'" ,"),",
       "( SELECT pmaal004 FROM pmaal_t t9 WHERE t9.pmaal001 = pmee_t.pmee032 AND t9.pmaalent = pmee_t.pmeeent AND t9.pmaal002 = '" , g_dlang,"'" ,"),",
       "x.t13_pmaal004,x.imaal_t_imaal003,x.t12_imaal003,",
       "trim(pmee029)||'.'||trim((SELECT ooefl003 FROM ooefl_t t10 WHERE t10.ooefl001 = pmee_t.pmee029 AND t10.ooeflent = pmee_t.pmeeent AND t10.ooefl002 = '" , g_dlang,"'" ,")),",
       "trim(pmee032)||'.'||trim((SELECT pmaal004 FROM pmaal_t t9 WHERE t9.pmaal001 = pmee_t.pmee032 AND t9.pmaalent = pmee_t.pmeeent AND t9.pmaal002 = '" , g_dlang,"'" ,")),",
       "trim(pmee022)||'.'||trim((SELECT pmaal004 FROM pmaal_t t5 WHERE t5.pmaal001 = pmee_t.pmee022 AND t5.pmaalent = pmee_t.pmeeent AND t5.pmaal002 = '" , g_dlang,"'" ,")),",
       "trim(pmee004)||'.'||trim((SELECT pmaal004 FROM pmaal_t t4 WHERE t4.pmaal001 = pmee_t.pmee004 AND t4.pmaalent = pmee_t.pmeeent AND t4.pmaal002 = '" , g_dlang,"'" ,")),",
       "trim(pmee003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmee_t.pmee003 AND ooefl_t.ooeflent = pmee_t.pmeeent AND ooefl_t.ooefl002 = '" , g_dlang,"'" ,")),",
       "trim(pmee002)||'.'||trim((SELECT ooag011 FROM ooag_t t1 WHERE t1.ooag001 = pmee_t.pmee002 AND t1.ooagent = pmee_t.pmeeent)), ",
       "trim(pmee021)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmee_t.pmee021 AND pmaal_t.pmaalent = pmee_t.pmeeent AND pmaal_t.pmaal002 = '" , g_dlang,"'" ,")),",
       "trim(pmeg023)||'.'||trim(x.t13_pmaal004),trim(pmegunit)||'.'||trim(x.t24_ooefl003), ",
       "trim(pmegorga)||'.'||trim(x.t22_ooefl003),NULL,( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = pmee_t.pmee009 AND ooibl_t.ooiblent = pmee_t.pmeeent AND ooibl_t.ooibl003 = '" , g_dlang,"'" ,"),",
       "'','','',x.t12_imaal004,x.imaal_t_imaal004,trim(pmeedocno)||trim(TO_CHAR(pmee_t.pmee900,'0000')),'','',''"
   #161020-00013#1 add-E
             
#   #end add-point
#   LET g_select = " SELECT pmee001,pmee002,pmee003,pmee004,pmee005,pmee006,pmee007,pmee008,pmee009,pmee010, 
#       pmee011,pmee012,pmee013,pmee015,pmee016,pmee017,pmee018,pmee019,pmee020,pmee021,pmee022,pmee023, 
#       pmee024,pmee025,pmee026,pmee027,pmee028,pmee029,pmee030,pmee031,pmee032,pmee033,pmee040,pmee041, 
#       pmee042,pmee043,pmee044,pmee046,pmee900,pmee901,pmee902,pmee903,pmee904,pmeeacti,pmeedocdt,pmeedocno, 
#       pmeeent,pmeesite,pmeestus,pmeg001,pmeg002,pmeg003,pmeg004,pmeg005,pmeg006,pmeg007,pmeg008,pmeg009, 
#       pmeg010,pmeg011,pmeg012,pmeg013,pmeg014,pmeg015,pmeg016,pmeg017,pmeg019,pmeg020,pmeg021,pmeg022, 
#       pmeg023,pmeg024,pmeg025,pmeg026,pmeg027,pmeg028,pmeg029,pmeg030,pmeg031,pmeg032,pmeg033,pmeg034, 
#       pmeg035,pmeg036,pmeg037,pmeg038,pmeg039,pmeg040,pmeg041,pmeg042,pmeg043,pmeg044,pmeg045,pmeg046, 
#       pmeg047,pmeg048,pmeg049,pmeg050,pmeg901,pmeg902,pmeg903,pmegorga,pmegseq,pmegsite,pmegunit,( SELECT oofa011 FROM oofa_t WHERE oofa_t.oofa001 = pmee_t.pmee027 AND oofa_t.oofaent = pmee_t.pmeeent), 
#       ( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmee_t.pmee002 AND ooag_t.ooagent = pmee_t.pmeeent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmee_t.pmee003 AND ooefl_t.ooeflent = pmee_t.pmeeent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmee_t.pmee029 AND ooefl_t.ooeflent = pmee_t.pmeeent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),x.t22_ooefl003,x.t24_ooefl003,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmee_t.pmee021 AND pmaal_t.pmaalent = pmee_t.pmeeent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmee_t.pmee004 AND pmaal_t.pmaalent = pmee_t.pmeeent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmee_t.pmee022 AND pmaal_t.pmaalent = pmee_t.pmeeent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmee_t.pmee032 AND pmaal_t.pmaalent = pmee_t.pmeeent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),x.t13_pmaal004,x.imaal_t_imaal003,x.t12_imaal003,trim(pmee029)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmee_t.pmee029 AND ooefl_t.ooeflent = pmee_t.pmeeent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmee032)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmee_t.pmee032 AND pmaal_t.pmaalent = pmee_t.pmeeent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmee022)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmee_t.pmee022 AND pmaal_t.pmaalent = pmee_t.pmeeent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmee004)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmee_t.pmee004 AND pmaal_t.pmaalent = pmee_t.pmeeent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmee003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmee_t.pmee003 AND ooefl_t.ooeflent = pmee_t.pmeeent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmee002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmee_t.pmee002 AND ooag_t.ooagent = pmee_t.pmeeent)), 
#       trim(pmee021)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmee_t.pmee021 AND pmaal_t.pmaalent = pmee_t.pmeeent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmeg023)||'.'||trim(x.t13_pmaal004),trim(pmegunit)||'.'||trim(x.t24_ooefl003), 
#       trim(pmegorga)||'.'||trim(x.t22_ooefl003),NULL,( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = pmee_t.pmee009 AND ooibl_t.ooiblent = pmee_t.pmeeent AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),'','','',x.t12_imaal004,x.imaal_t_imaal004,'','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM pmee_t LEFT OUTER JOIN ( SELECT pmeg_t.*,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmeg_t.pmegorga AND ooefl_t.ooeflent = pmeg_t.pmegent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,") t22_ooefl003,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmeg_t.pmegunit AND ooefl_t.ooeflent = pmeg_t.pmegent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,") t24_ooefl003,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmeg_t.pmeg023 AND pmaal_t.pmaalent = pmeg_t.pmegent AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,") t13_pmaal004,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmeg_t.pmeg001 AND imaal_t.imaalent = pmeg_t.pmegent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmeg_t.pmeg003 AND imaal_t.imaalent = pmeg_t.pmegent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t12_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmeg_t.pmeg003 AND imaal_t.imaalent = pmeg_t.pmegent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t12_imaal004,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmeg_t.pmeg001 AND imaal_t.imaalent = pmeg_t.pmegent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal004 FROM pmeg_t ) x  ON pmee_t.pmeeent = x.pmegent AND pmee_t.pmeedocno  
        = x.pmegdocno AND pmee_t.pmee900 = x.pmeg900"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_where = " WHERE " ,tm.wc CLIPPED," AND pmeeent =",g_enterprise," AND pmeesite='",g_site,"' "  #160324-00003 by whitney add

#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY pmee900,pmeedocno,pmegseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmee_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr510_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE apmr510_g01_curs CURSOR FOR apmr510_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr510_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr510_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   pmee001 LIKE pmee_t.pmee001, 
   pmee002 LIKE pmee_t.pmee002, 
   pmee003 LIKE pmee_t.pmee003, 
   pmee004 LIKE pmee_t.pmee004, 
   pmee005 LIKE pmee_t.pmee005, 
   pmee006 LIKE pmee_t.pmee006, 
   pmee007 LIKE pmee_t.pmee007, 
   pmee008 LIKE pmee_t.pmee008, 
   pmee009 LIKE pmee_t.pmee009, 
   pmee010 LIKE pmee_t.pmee010, 
   pmee011 LIKE pmee_t.pmee011, 
   pmee012 LIKE pmee_t.pmee012, 
   pmee013 LIKE pmee_t.pmee013, 
   pmee015 LIKE pmee_t.pmee015, 
   pmee016 LIKE pmee_t.pmee016, 
   pmee017 LIKE pmee_t.pmee017, 
   pmee018 LIKE pmee_t.pmee018, 
   pmee019 LIKE pmee_t.pmee019, 
   pmee020 LIKE pmee_t.pmee020, 
   pmee021 LIKE pmee_t.pmee021, 
   pmee022 LIKE pmee_t.pmee022, 
   pmee023 LIKE pmee_t.pmee023, 
   pmee024 LIKE pmee_t.pmee024, 
   pmee025 LIKE pmee_t.pmee025, 
   pmee026 LIKE pmee_t.pmee026, 
   pmee027 LIKE pmee_t.pmee027, 
   pmee028 LIKE pmee_t.pmee028, 
   pmee029 LIKE pmee_t.pmee029, 
   pmee030 LIKE pmee_t.pmee030, 
   pmee031 LIKE pmee_t.pmee031, 
   pmee032 LIKE pmee_t.pmee032, 
   pmee033 LIKE pmee_t.pmee033, 
   pmee040 LIKE pmee_t.pmee040, 
   pmee041 LIKE pmee_t.pmee041, 
   pmee042 LIKE pmee_t.pmee042, 
   pmee043 LIKE pmee_t.pmee043, 
   pmee044 LIKE pmee_t.pmee044, 
   pmee046 LIKE pmee_t.pmee046, 
   pmee900 LIKE pmee_t.pmee900, 
   pmee901 LIKE pmee_t.pmee901, 
   pmee902 LIKE pmee_t.pmee902, 
   pmee903 LIKE pmee_t.pmee903, 
   pmee904 LIKE pmee_t.pmee904, 
   pmeeacti LIKE pmee_t.pmeeacti, 
   pmeedocdt LIKE pmee_t.pmeedocdt, 
   pmeedocno LIKE pmee_t.pmeedocno, 
   pmeeent LIKE pmee_t.pmeeent, 
   pmeesite LIKE pmee_t.pmeesite, 
   pmeestus LIKE pmee_t.pmeestus, 
   pmeg001 LIKE pmeg_t.pmeg001, 
   pmeg002 LIKE pmeg_t.pmeg002, 
   pmeg003 LIKE pmeg_t.pmeg003, 
   pmeg004 LIKE pmeg_t.pmeg004, 
   pmeg005 LIKE pmeg_t.pmeg005, 
   pmeg006 LIKE pmeg_t.pmeg006, 
   pmeg007 LIKE pmeg_t.pmeg007, 
   pmeg008 LIKE pmeg_t.pmeg008, 
   pmeg009 LIKE pmeg_t.pmeg009, 
   pmeg010 LIKE pmeg_t.pmeg010, 
   pmeg011 LIKE pmeg_t.pmeg011, 
   pmeg012 LIKE pmeg_t.pmeg012, 
   pmeg013 LIKE pmeg_t.pmeg013, 
   pmeg014 LIKE pmeg_t.pmeg014, 
   pmeg015 LIKE pmeg_t.pmeg015, 
   pmeg016 LIKE pmeg_t.pmeg016, 
   pmeg017 LIKE pmeg_t.pmeg017, 
   pmeg019 LIKE pmeg_t.pmeg019, 
   pmeg020 LIKE pmeg_t.pmeg020, 
   pmeg021 LIKE pmeg_t.pmeg021, 
   pmeg022 LIKE pmeg_t.pmeg022, 
   pmeg023 LIKE pmeg_t.pmeg023, 
   pmeg024 LIKE pmeg_t.pmeg024, 
   pmeg025 LIKE pmeg_t.pmeg025, 
   pmeg026 LIKE pmeg_t.pmeg026, 
   pmeg027 LIKE pmeg_t.pmeg027, 
   pmeg028 LIKE pmeg_t.pmeg028, 
   pmeg029 LIKE pmeg_t.pmeg029, 
   pmeg030 LIKE pmeg_t.pmeg030, 
   pmeg031 LIKE pmeg_t.pmeg031, 
   pmeg032 LIKE pmeg_t.pmeg032, 
   pmeg033 LIKE pmeg_t.pmeg033, 
   pmeg034 LIKE pmeg_t.pmeg034, 
   pmeg035 LIKE pmeg_t.pmeg035, 
   pmeg036 LIKE pmeg_t.pmeg036, 
   pmeg037 LIKE pmeg_t.pmeg037, 
   pmeg038 LIKE pmeg_t.pmeg038, 
   pmeg039 LIKE pmeg_t.pmeg039, 
   pmeg040 LIKE pmeg_t.pmeg040, 
   pmeg041 LIKE pmeg_t.pmeg041, 
   pmeg042 LIKE pmeg_t.pmeg042, 
   pmeg043 LIKE pmeg_t.pmeg043, 
   pmeg044 LIKE pmeg_t.pmeg044, 
   pmeg045 LIKE pmeg_t.pmeg045, 
   pmeg046 LIKE pmeg_t.pmeg046, 
   pmeg047 LIKE pmeg_t.pmeg047, 
   pmeg048 LIKE pmeg_t.pmeg048, 
   pmeg049 LIKE pmeg_t.pmeg049, 
   pmeg050 LIKE pmeg_t.pmeg050, 
   pmeg901 LIKE pmeg_t.pmeg901, 
   pmeg902 LIKE pmeg_t.pmeg902, 
   pmeg903 LIKE pmeg_t.pmeg903, 
   pmegorga LIKE pmeg_t.pmegorga, 
   pmegseq LIKE pmeg_t.pmegseq, 
   pmegsite LIKE pmeg_t.pmegsite, 
   pmegunit LIKE pmeg_t.pmegunit, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   t1_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t10_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t22_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t24_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t4_pmaal004 LIKE pmaal_t.pmaal004, 
   t5_pmaal004 LIKE pmaal_t.pmaal004, 
   t9_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t13_pmaal004 LIKE pmaal_t.pmaal004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t12_imaal003 LIKE imaal_t.imaal003, 
   l_pmee029_ooefl003 LIKE type_t.chr1000, 
   l_pmee032_pmaal004 LIKE type_t.chr100, 
   l_pmee022_pmaal004 LIKE type_t.chr100, 
   l_pmee004_pmaal004 LIKE type_t.chr100, 
   l_pmee003_ooefl003 LIKE type_t.chr1000, 
   l_pmee002_ooag011 LIKE type_t.chr300, 
   l_pmee021_pmaal004 LIKE type_t.chr100, 
   l_pmeg023_pmaal004 LIKE type_t.chr100, 
   l_pmegunit_ooefl003 LIKE type_t.chr1000, 
   l_pmegorga_ooefl003 LIKE type_t.chr1000, 
   l_pmee009_desc LIKE type_t.chr100, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   l_pmee010_desc LIKE type_t.chr100, 
   l_pmee023_desc LIKE type_t.chr100, 
   l_pmee903_desc LIKE type_t.chr100, 
   x_t12_imaal004 LIKE imaal_t.imaal004, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_order LIKE type_t.chr30, 
   l_pmee011_desc LIKE type_t.chr100, 
   l_pmeg020_desc LIKE type_t.chr100, 
   l_pmeg027_desc LIKE type_t.chr80
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_gzcb008 LIKE gzcb_t.gzcb008
DEFINE l_pmeg020 LIKE type_t.chr500
DEFINE l_pmeg027 LIKE type_t.chr500
DEFINE l_pmegunit LIKE type_t.chr500
DEFINE l_pmegorga LIKE type_t.chr500
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH apmr510_g01_curs INTO sr_s.*
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
       #付款條件
       CALL s_desc_get_ooib002_desc(sr_s.pmee009)RETURNING sr_s.l_pmee009_desc
       #交易條件
       CALL s_desc_get_acc_desc(238,sr_s.pmee010)RETURNING sr_s.l_pmee010_desc
       #採購通路
       CALL s_desc_get_acc_desc(275,sr_s.pmee023)RETURNING sr_s.l_pmee023_desc
       #稅別說明
       CALL apmr510_g01_pmee011_ref(sr_s.pmee011)RETURNING sr_s.l_pmee011_desc
       #變更理由
       LET l_gzcb008 = '' 
      #160816-00001#8  2016/08/17  By 08734 Mark       
      # SELECT gzcb008 INTO l_gzcb008  
      #   FROM gzcb_t
      #  WHERE gzcb001 = '24'
      #    AND gzcb002 = 'apmt500'
       LET g_acc = s_fin_get_scc_value('24','apmt500','6')  #160816-00001#8  2016/08/17  By 08734 add
       IF NOT cl_null(l_gzcb008)THEN          
          CALL s_desc_get_acc_desc(l_gzcb008,sr_s.pmee903)RETURNING sr_s.l_pmee903_desc
       END IF
       CALL cl_getmsg('apm-00646',g_dlang) RETURNING l_pmeg020 
       CALL cl_getmsg('apm-00647',g_dlang) RETURNING l_pmeg027 
       CALL cl_getmsg('apm-00648',g_dlang) RETURNING l_pmegunit
       CALL cl_getmsg('apm-00649',g_dlang) RETURNING l_pmegorga
       #緊急度說明  
       CALL s_desc_gzcbl004_desc('2036',sr_s.pmeg020)RETURNING sr_s.l_pmeg020_desc 
       LET sr_s.l_pmeg020_desc = l_pmeg020,sr_s.l_pmeg020_desc 
       IF sr_s.pmeg020 = 1 THEN 
          LET sr_s.l_pmeg020_desc = ''
       END IF
       #供應商料號
       LET sr_s.l_pmeg027_desc = l_pmeg027,sr_s.pmeg027 
       IF cl_null(sr_s.pmeg027) THEN 
          LET sr_s.l_pmeg027_desc = ''
       END IF
       #收貨據點
       LET sr_s.l_pmegunit_ooefl003 = l_pmegunit,sr_s.l_pmegunit_ooefl003
       IF sr_s.pmegunit = sr_s.pmeesite THEN
          LET sr_s.l_pmegunit_ooefl003 =''
       END IF
       #付款據點
       LET sr_s.l_pmegorga_ooefl003 = l_pmegorga,sr_s.l_pmegorga_ooefl003
       IF sr_s.pmegorga = sr_s.pmeesite OR cl_null(sr_s.pmegorga)THEN
          LET sr_s.l_pmegorga_ooefl003 =''
       END IF
       #161207-00033#25-S
       IF NOT cl_null(sr_s.pmee028) THEN   
          CALL s_desc_get_oneturn_guest_desc(sr_s.pmee028) RETURNING sr_s.t4_pmaal004
          LET sr_s.l_pmee004_pmaal004 = sr_s.pmee004 CLIPPED,'.',sr_s.t4_pmaal004 CLIPPED
          IF sr_s.pmee004 = sr_s.pmee021 THEN
             LET sr_s.pmaal_t_pmaal004 = sr_s.t4_pmaal004
             LET sr_s.l_pmee021_pmaal004 = sr_s.pmee021 CLIPPED,'.',sr_s.t4_pmaal004 CLIPPED
          END IF
          IF sr_s.pmee004 = sr_s.pmee022 THEN
             LET sr_s.t5_pmaal004 = sr_s.t4_pmaal004
             LET sr_s.l_pmee022_pmaal004 = sr_s.pmee022 CLIPPED,'.',sr_s.t4_pmaal004 CLIPPED
          END IF 
          IF sr_s.pmee004 = sr_s.pmee032 THEN
             LET sr_s.t9_pmaal004 = sr_s.t4_pmaal004
             LET sr_s.l_pmee032_pmaal004 = sr_s.pmee032 CLIPPED,'.',sr_s.t4_pmaal004 CLIPPED
          END IF  
          IF sr_s.pmee004 = sr_s.pmeg023 THEN
             LET sr_s.x_t13_pmaal004 = sr_s.t4_pmaal004
             LET sr_s.l_pmeg023_pmaal004 = sr_s.pmeg023 CLIPPED,'.',sr_s.t4_pmaal004 CLIPPED
          END IF            
       END IF
       #161207-00033#25-E
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].pmee001 = sr_s.pmee001
       LET sr[l_cnt].pmee002 = sr_s.pmee002
       LET sr[l_cnt].pmee003 = sr_s.pmee003
       LET sr[l_cnt].pmee004 = sr_s.pmee004
       LET sr[l_cnt].pmee005 = sr_s.pmee005
       LET sr[l_cnt].pmee006 = sr_s.pmee006
       LET sr[l_cnt].pmee007 = sr_s.pmee007
       LET sr[l_cnt].pmee008 = sr_s.pmee008
       LET sr[l_cnt].pmee009 = sr_s.pmee009
       LET sr[l_cnt].pmee010 = sr_s.pmee010
       LET sr[l_cnt].pmee011 = sr_s.pmee011
       LET sr[l_cnt].pmee012 = sr_s.pmee012
       LET sr[l_cnt].pmee013 = sr_s.pmee013
       LET sr[l_cnt].pmee015 = sr_s.pmee015
       LET sr[l_cnt].pmee016 = sr_s.pmee016
       LET sr[l_cnt].pmee017 = sr_s.pmee017
       LET sr[l_cnt].pmee018 = sr_s.pmee018
       LET sr[l_cnt].pmee019 = sr_s.pmee019
       LET sr[l_cnt].pmee020 = sr_s.pmee020
       LET sr[l_cnt].pmee021 = sr_s.pmee021
       LET sr[l_cnt].pmee022 = sr_s.pmee022
       LET sr[l_cnt].pmee023 = sr_s.pmee023
       LET sr[l_cnt].pmee024 = sr_s.pmee024
       LET sr[l_cnt].pmee025 = sr_s.pmee025
       LET sr[l_cnt].pmee026 = sr_s.pmee026
       LET sr[l_cnt].pmee027 = sr_s.pmee027
       LET sr[l_cnt].pmee028 = sr_s.pmee028
       LET sr[l_cnt].pmee029 = sr_s.pmee029
       LET sr[l_cnt].pmee030 = sr_s.pmee030
       LET sr[l_cnt].pmee031 = sr_s.pmee031
       LET sr[l_cnt].pmee032 = sr_s.pmee032
       LET sr[l_cnt].pmee033 = sr_s.pmee033
       LET sr[l_cnt].pmee040 = sr_s.pmee040
       LET sr[l_cnt].pmee041 = sr_s.pmee041
       LET sr[l_cnt].pmee042 = sr_s.pmee042
       LET sr[l_cnt].pmee043 = sr_s.pmee043
       LET sr[l_cnt].pmee044 = sr_s.pmee044
       LET sr[l_cnt].pmee046 = sr_s.pmee046
       LET sr[l_cnt].pmee900 = sr_s.pmee900
       LET sr[l_cnt].pmee901 = sr_s.pmee901
       LET sr[l_cnt].pmee902 = sr_s.pmee902
       LET sr[l_cnt].pmee903 = sr_s.pmee903
       LET sr[l_cnt].pmee904 = sr_s.pmee904
       LET sr[l_cnt].pmeeacti = sr_s.pmeeacti
       LET sr[l_cnt].pmeedocdt = sr_s.pmeedocdt
       LET sr[l_cnt].pmeedocno = sr_s.pmeedocno
       LET sr[l_cnt].pmeeent = sr_s.pmeeent
       LET sr[l_cnt].pmeesite = sr_s.pmeesite
       LET sr[l_cnt].pmeestus = sr_s.pmeestus
       LET sr[l_cnt].pmeg001 = sr_s.pmeg001
       LET sr[l_cnt].pmeg002 = sr_s.pmeg002
       LET sr[l_cnt].pmeg003 = sr_s.pmeg003
       LET sr[l_cnt].pmeg004 = sr_s.pmeg004
       LET sr[l_cnt].pmeg005 = sr_s.pmeg005
       LET sr[l_cnt].pmeg006 = sr_s.pmeg006
       LET sr[l_cnt].pmeg007 = sr_s.pmeg007
       LET sr[l_cnt].pmeg008 = sr_s.pmeg008
       LET sr[l_cnt].pmeg009 = sr_s.pmeg009
       LET sr[l_cnt].pmeg010 = sr_s.pmeg010
       LET sr[l_cnt].pmeg011 = sr_s.pmeg011
       LET sr[l_cnt].pmeg012 = sr_s.pmeg012
       LET sr[l_cnt].pmeg013 = sr_s.pmeg013
       LET sr[l_cnt].pmeg014 = sr_s.pmeg014
       LET sr[l_cnt].pmeg015 = sr_s.pmeg015
       LET sr[l_cnt].pmeg016 = sr_s.pmeg016
       LET sr[l_cnt].pmeg017 = sr_s.pmeg017
       LET sr[l_cnt].pmeg019 = sr_s.pmeg019
       LET sr[l_cnt].pmeg020 = sr_s.pmeg020
       LET sr[l_cnt].pmeg021 = sr_s.pmeg021
       LET sr[l_cnt].pmeg022 = sr_s.pmeg022
       LET sr[l_cnt].pmeg023 = sr_s.pmeg023
       LET sr[l_cnt].pmeg024 = sr_s.pmeg024
       LET sr[l_cnt].pmeg025 = sr_s.pmeg025
       LET sr[l_cnt].pmeg026 = sr_s.pmeg026
       LET sr[l_cnt].pmeg027 = sr_s.pmeg027
       LET sr[l_cnt].pmeg028 = sr_s.pmeg028
       LET sr[l_cnt].pmeg029 = sr_s.pmeg029
       LET sr[l_cnt].pmeg030 = sr_s.pmeg030
       LET sr[l_cnt].pmeg031 = sr_s.pmeg031
       LET sr[l_cnt].pmeg032 = sr_s.pmeg032
       LET sr[l_cnt].pmeg033 = sr_s.pmeg033
       LET sr[l_cnt].pmeg034 = sr_s.pmeg034
       LET sr[l_cnt].pmeg035 = sr_s.pmeg035
       LET sr[l_cnt].pmeg036 = sr_s.pmeg036
       LET sr[l_cnt].pmeg037 = sr_s.pmeg037
       LET sr[l_cnt].pmeg038 = sr_s.pmeg038
       LET sr[l_cnt].pmeg039 = sr_s.pmeg039
       LET sr[l_cnt].pmeg040 = sr_s.pmeg040
       LET sr[l_cnt].pmeg041 = sr_s.pmeg041
       LET sr[l_cnt].pmeg042 = sr_s.pmeg042
       LET sr[l_cnt].pmeg043 = sr_s.pmeg043
       LET sr[l_cnt].pmeg044 = sr_s.pmeg044
       LET sr[l_cnt].pmeg045 = sr_s.pmeg045
       LET sr[l_cnt].pmeg046 = sr_s.pmeg046
       LET sr[l_cnt].pmeg047 = sr_s.pmeg047
       LET sr[l_cnt].pmeg048 = sr_s.pmeg048
       LET sr[l_cnt].pmeg049 = sr_s.pmeg049
       LET sr[l_cnt].pmeg050 = sr_s.pmeg050
       LET sr[l_cnt].pmeg901 = sr_s.pmeg901
       LET sr[l_cnt].pmeg902 = sr_s.pmeg902
       LET sr[l_cnt].pmeg903 = sr_s.pmeg903
       LET sr[l_cnt].pmegorga = sr_s.pmegorga
       LET sr[l_cnt].pmegseq = sr_s.pmegseq
       LET sr[l_cnt].pmegsite = sr_s.pmegsite
       LET sr[l_cnt].pmegunit = sr_s.pmegunit
       LET sr[l_cnt].oofa_t_oofa011 = sr_s.oofa_t_oofa011
       LET sr[l_cnt].t1_ooag011 = sr_s.t1_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].t10_ooefl003 = sr_s.t10_ooefl003
       LET sr[l_cnt].x_t22_ooefl003 = sr_s.x_t22_ooefl003
       LET sr[l_cnt].x_t24_ooefl003 = sr_s.x_t24_ooefl003
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].t4_pmaal004 = sr_s.t4_pmaal004
       LET sr[l_cnt].t5_pmaal004 = sr_s.t5_pmaal004
       LET sr[l_cnt].t9_pmaal004 = sr_s.t9_pmaal004
       LET sr[l_cnt].x_t13_pmaal004 = sr_s.x_t13_pmaal004
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_t12_imaal003 = sr_s.x_t12_imaal003
       LET sr[l_cnt].l_pmee029_ooefl003 = sr_s.l_pmee029_ooefl003
       LET sr[l_cnt].l_pmee032_pmaal004 = sr_s.l_pmee032_pmaal004
       LET sr[l_cnt].l_pmee022_pmaal004 = sr_s.l_pmee022_pmaal004
       LET sr[l_cnt].l_pmee004_pmaal004 = sr_s.l_pmee004_pmaal004
       LET sr[l_cnt].l_pmee003_ooefl003 = sr_s.l_pmee003_ooefl003
       LET sr[l_cnt].l_pmee002_ooag011 = sr_s.l_pmee002_ooag011
       LET sr[l_cnt].l_pmee021_pmaal004 = sr_s.l_pmee021_pmaal004
       LET sr[l_cnt].l_pmeg023_pmaal004 = sr_s.l_pmeg023_pmaal004
       LET sr[l_cnt].l_pmegunit_ooefl003 = sr_s.l_pmegunit_ooefl003
       LET sr[l_cnt].l_pmegorga_ooefl003 = sr_s.l_pmegorga_ooefl003
       LET sr[l_cnt].l_pmee009_desc = sr_s.l_pmee009_desc
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].l_pmee010_desc = sr_s.l_pmee010_desc
       LET sr[l_cnt].l_pmee023_desc = sr_s.l_pmee023_desc
       LET sr[l_cnt].l_pmee903_desc = sr_s.l_pmee903_desc
       LET sr[l_cnt].x_t12_imaal004 = sr_s.x_t12_imaal004
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].l_order = sr_s.l_order
       LET sr[l_cnt].l_pmee011_desc = sr_s.l_pmee011_desc
       LET sr[l_cnt].l_pmeg020_desc = sr_s.l_pmeg020_desc
       LET sr[l_cnt].l_pmeg027_desc = sr_s.l_pmeg027_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr510_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr510_g01_rep_data()
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
          START REPORT apmr510_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT apmr510_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT apmr510_g01_rep
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
 
{<section id="apmr510_g01.rep" readonly="Y" >}
PRIVATE REPORT apmr510_g01_rep(sr1)
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
DEFINE sr3       sr3_r 
DEFINE sr5       sr5_r #多帳期
DEFINE sr6       sr6_r #單身
DEFINE sr7       sr7_r
DEFINE sr8       sr8_r 
DEFINE l_subrep05_show LIKE type_t.chr5
DEFINE l_subrep06_show LIKE type_t.chr5
DEFINE l_subrep07_show LIKE type_t.chr5
DEFINE l_subrep08_show LIKE type_t.chr5
DEFINE l_subrep09_show LIKE type_t.chr5
DEFINE l_pmeg_show     LIKE type_t.chr5
DEFINE l_pmee904_show  LIKE type_t.chr5
DEFINE l_pmeg903_show  LIKE type_t.chr5
DEFINE l_pmeg002_show  LIKE type_t.chr5
DEFINE l_pmeg027_show  LIKE type_t.chr5
DEFINE l_pmeg046_sum_show LIKE type_t.chr5
DEFINE l_pmeg048_sum_show LIKE type_t.chr5
DEFINE l_pmeg047_sum_show LIKE type_t.chr5

DEFINE l_ac            INTEGER
DEFINE l_i             INTEGER
DEFINE l_pmef_count    LIKE type_t.num5 
DEFINE l_pmeh_count    LIKE type_t.num5
DEFINE l_pmei_count    LIKE type_t.num5
DEFINE l_count         LIKE type_t.num5
DEFINE l_pmeg046_sum   LIKE pmeg_t.pmeg046
DEFINE l_pmeg048_sum   LIKE pmeg_t.pmeg048
DEFINE l_pmeg047_sum   LIKE pmeg_t.pmeg047

DEFINE l_pmee004_btl   LIKE type_t.num20_6
DEFINE l_pmee021_btl   LIKE type_t.num20_6
DEFINE l_pmee022_btl   LIKE type_t.num20_6
DEFINE l_pmee009_btl   LIKE type_t.num20_6
DEFINE l_pmee010_btl   LIKE type_t.num20_6
DEFINE l_pmee011_btl   LIKE type_t.num20_6
DEFINE l_pmee015_btl   LIKE type_t.num20_6
DEFINE l_pmee023_btl   LIKE type_t.num20_6
DEFINE l_pmee002_btl   LIKE type_t.num20_6
DEFINE l_pmee003_btl   LIKE type_t.num20_6
DEFINE l_pmee004       LIKE type_t.num20_6
DEFINE l_pmee021       LIKE type_t.num20_6
DEFINE l_pmee022       LIKE type_t.num20_6
DEFINE l_pmee009       LIKE type_t.num20_6
DEFINE l_pmee010       LIKE type_t.num20_6
DEFINE l_pmee011       LIKE type_t.num20_6
DEFINE l_pmee015       LIKE type_t.num20_6
DEFINE l_pmee023       LIKE type_t.num20_6
DEFINE l_pmee002       LIKE type_t.num20_6
DEFINE l_pmee003       LIKE type_t.num20_6

DEFINE l_pmeg001_btl   LIKE type_t.num20_6
DEFINE l_pmeg002_btl   LIKE type_t.num20_6
DEFINE l_pmeg012_btl   LIKE type_t.num20_6
DEFINE l_pmeg007_btl   LIKE type_t.num20_6
DEFINE l_pmeg006_btl   LIKE type_t.num20_6
DEFINE l_pmeg015_btl   LIKE type_t.num20_6
DEFINE l_pmeg046_btl   LIKE type_t.num20_6
DEFINE l_pmeg027_btl   LIKE type_t.num20_6
DEFINE l_pmeg020_btl   LIKE type_t.num20_6
DEFINE l_pmegunit_btl  LIKE type_t.num20_6
DEFINE l_pmegorga_btl  LIKE type_t.num20_6
DEFINE l_pmeg050_btl   LIKE type_t.num20_6 #170110-00001#1 add

DEFINE l_ooef019       LIKE ooef_t.ooef019
DEFINE l_pmeg027       LIKE type_t.chr500
DEFINE l_pmegorga      LIKE type_t.chr500
DEFINE l_pmegunit      LIKE type_t.chr500
DEFINE l_pmee900       LIKE ooff_t.ooff004  #161031-00025#14 add
DEFINE l_pmegseq       LIKE ooff_t.ooff005  #161031-00025#14 add
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.l_order,sr1.pmegseq
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
        BEFORE GROUP OF sr1.l_order
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            LET g_rep_docno = sr1.pmeedocno   #170119-00010#1-add
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*   #add--2015/08/19 By shiun
            CALL cl_gr_init_apr(sr1.pmeedocno)
#            #end add-point:rep.header 
#            LET g_rep_docno = sr1.l_order
#            CALL cl_gr_init_pageheader() #表頭資訊
#            PRINTX g_grPageHeader.*
#            PRINTX g_grPageFooter.*
#            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
            #170119-00010#1-s-add
            LET g_doc_key = 'pmeeent=' ,sr1.pmeeent,'{+}pmeedocno=' ,sr1.pmeedocno,'{+}pmee900=' ,sr1.pmee900         
            CALL cl_gr_init_apr(sr1.pmeedocno)
            #170119-00010#1-e-add
#            #end add-point:rep.apr.signstr.before   
#            LET g_doc_key = 'pmeeent=' ,sr1.pmeeent,'{+}pmeedocno=' ,sr1.pmeedocno,'{+}pmee900=' ,sr1.pmee900         
#            CALL cl_gr_init_apr(sr1.l_order)
#            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_order.before name="rep.b_group.l_order.before"
           #取的所屬稅區
           SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
           #單頭變更子報表
           LET l_subrep05_show = "N"
           LET l_pmee004_btl = 0
           LET l_pmee021_btl = 0
           LET l_pmee022_btl = 0
           LET l_pmee009_btl = 0
           LET l_pmee010_btl = 0
           LET l_pmee011_btl = 0
           LET l_pmee015_btl = 0
           LET l_pmee023_btl = 0
           LET l_pmee002_btl = 0
           LET l_pmee003_btl = 0               
           LET l_pmee004 = 0
           LET l_pmee021 = 0
           LET l_pmee022 = 0
           LET l_pmee009 = 0
           LET l_pmee010 = 0
           LET l_pmee011 = 0
           LET l_pmee015 = 0
           LET l_pmee023 = 0
           LET l_pmee002 = 0
           LET l_pmee003 = 0
           
           START REPORT apmr510_g01_subrep05
              LET g_sql = "SELECT pmek002,pmek004 ",
                          "  FROM pmek_t ",
                          " WHERE pmekdocno    = '",sr1.pmeedocno CLIPPED,"'",
                          "   AND pmekent      = '",sr1.pmeeent   CLIPPED,"'",
                          "   AND pmeksite     = '",sr1.pmeesite  CLIPPED,"'",
                          "   AND pmek001      = '",sr1.pmee900   CLIPPED,"'",
                          "   AND pmek002 IN ('pmdldocno','pmdldocdt','pmdl001','pmdl002','pmdl003','pmdl004','pmdl009','pmdl010','pmdl011','pmdl015','pmdl021','pmdl022','pmdl023','pmdl903','pmdl904') ",
                          "   AND pmekseq      = 0 ",
                          "   AND pmekseq1     = 0 ",
                          "   AND pmekseq2     = 0 "                          
              LET l_ac = 1
              CALL sr4.clear()
              DECLARE apmr510_g01_repcur05 CURSOR FROM g_sql
              FOREACH apmr510_g01_repcur05 INTO sr4[l_ac].*
                 IF STATUS THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = "apmr510_g01_repcur05:"
                    LET g_errparam.code   = SQLCA.sqlcode
                    LET g_errparam.popup  = FALSE
                    CALL cl_err()
                    EXIT FOREACH
                 END IF                                                                             
              LET l_ac = l_ac + 1
              END FOREACH
              LET l_ac = l_ac-1            #最後多加了一次
              LET l_i = 1                  #目前筆數              
              IF l_ac > 0 THEN
                 LET l_subrep05_show = "Y"
                 WHILE TRUE
                    INITIALIZE sr3.* TO NULL
                    LET sr3.pmek002_1 = sr4[l_i].pmek002
                    LET sr3.pmek004_1 = sr4[l_i].pmek004  
                    CASE
                       WHEN sr3.pmek002_1  = 'pmdl002' #採購人員
                          CALL s_desc_get_person_desc(sr3.pmek004_1) RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1  = 'pmdl003' #採購部門 
                          CALL s_desc_get_department_desc(sr3.pmek004_1)RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1  = 'pmdl004' #供應商編號 
                          CALL s_desc_get_trading_partner_abbr_desc(sr3.pmek004_1)RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1  = 'pmdl005' #採購性質
                          CALL s_desc_gzcbl004_desc(2052,sr3.pmek004_1)RETURNING sr3.pmek004_1  
                       WHEN sr3.pmek002_1  = 'pmdl006' #多角性質
                          CALL s_desc_gzcbl004_desc(2053,sr3.pmek004_1)RETURNING sr3.pmek004_1 
                       WHEN sr3.pmek002_1  = 'pmdl007' #資料來源類型
                          CALL s_desc_gzcbl004_desc(2054,sr3.pmek004_1)RETURNING sr3.pmek004_1                             
                       WHEN sr3.pmek002_1  = 'pmdl009' #付款條件
                          CALL s_desc_gzcbl004_desc(2057,sr3.pmek004_1)RETURNING sr3.pmek004_1 
                       WHEN sr3.pmek002_1  = 'pmdl010' #交易條件 
                          CALL s_desc_get_acc_desc(238,sr3.pmek004_1) RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1  = 'pmdl011' #稅別
                          CALL s_desc_get_tax_desc(l_ooef019,sr3.pmek004_1)RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1  = 'pmdl018' #付款款優惠條件
                          CALL s_desc_ooid001_desc(sr3.pmek004_1)RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1  = 'pmdl020' #運送方式
                          CALL s_desc_gzcbl004_desc(263,sr3.pmek004_1)RETURNING sr3.pmek004_1 
                       WHEN sr3.pmek002_1  = 'pmdl021' #付款供應商
                          CALL s_desc_get_trading_partner_abbr_desc(sr3.pmek004_1)RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1  = 'pmdl022' #送貨供應商
                          CALL s_desc_get_trading_partner_abbr_desc(sr3.pmek004_1)RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1  = 'pmdl023' #採購分類一
                          CALL s_desc_get_acc_desc(275,sr3.pmek004_1) RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1  = 'pmdl024' #採購分類二
                          CALL s_desc_get_acc_desc(264,sr3.pmek004_1) RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1 = 'pmdl025' #送貨地址
                          CALL apmr510_g01_pmdl025_ref(sr3.pmek004_1)RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1 = 'pmdl026' #帳款地址
                          CALL apmr510_g01_pmdl026_ref(sr3.pmek004_1)RETURNING sr3.pmek004_1   
                       WHEN sr3.pmek002_1 = 'pmdl027' #供應商連絡人
                          CALL s_desc_get_person_desc(sr3.pmek004_1)RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1  = 'pmdl029' #收貨部門 
                          CALL s_desc_get_department_desc(sr3.pmek004_1)RETURNING sr3.pmek004_1                            
                       WHEN sr3.pmek002_1  = 'pmdl032' #最終客戶 
                          CALL s_desc_get_trading_partner_abbr_desc(sr3.pmek004_1)RETURNING sr3.pmek004_1  
                       WHEN sr3.pmek002_1  = 'pmdl033' #發票類型 
                          CALL apmr510_g01_pmdl033_ref(sr3.pmek004_1 )RETURNING sr3.pmek004_1 
                       WHEN sr3.pmek002_1  = 'pmdl043' #留置原因 
                          CALL s_desc_get_acc_desc(298,sr3.pmek004_1) RETURNING sr3.pmek004_1
                       WHEN sr3.pmek002_1  = 'pmdl052' #最終供應商
                          CALL s_desc_get_trading_partner_abbr_desc(sr3.pmek004_1)RETURNING sr3.pmek004_1   
                    END CASE                    
                    CALL apmr510_g01_pmek002_ref(sr3.pmek002_1) RETURNING sr3.pmek002_1_desc                                                                
                    IF (l_i + 1) <= l_ac THEN
                       LET sr3.pmek002_2 = sr4[l_i+1].pmek002
                       LET sr3.pmek004_2 = sr4[l_i+1].pmek004                       
                       CASE
                         WHEN sr3.pmek002_2  = 'pmdl002' #採購人員
                            CALL s_desc_get_person_desc(sr3.pmek004_2) RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2  = 'pmdl003' #採購部門 
                            CALL s_desc_get_department_desc(sr3.pmek004_2)RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2  = 'pmdl004' #供應商編號 
                            CALL s_desc_get_trading_partner_abbr_desc(sr3.pmek004_2)RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2  = 'pmdl005' #採購性質
                            CALL s_desc_gzcbl004_desc(2052,sr3.pmek004_2)RETURNING sr3.pmek004_2  
                         WHEN sr3.pmek002_2  = 'pmdl006' #多角性質
                            CALL s_desc_gzcbl004_desc(2053,sr3.pmek004_2)RETURNING sr3.pmek004_2 
                         WHEN sr3.pmek002_2  = 'pmdl007' #資料來源類型
                            CALL s_desc_gzcbl004_desc(2054,sr3.pmek004_2)RETURNING sr3.pmek004_2                             
                         WHEN sr3.pmek002_2  = 'pmdl009' #付款條件
                            CALL s_desc_gzcbl004_desc(2057,sr3.pmek004_2)RETURNING sr3.pmek004_2 
                         WHEN sr3.pmek002_2  = 'pmdl010' #交易條件 
                            CALL s_desc_get_acc_desc(238,sr3.pmek004_2) RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2  = 'pmdl011' #稅別
                            CALL s_desc_get_tax_desc(l_ooef019,sr3.pmek004_2)RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2  = 'pmdl018' #付款款優惠條件
                            CALL s_desc_ooid001_desc(sr3.pmek004_2)RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2  = 'pmdl020' #運送方式
                            CALL s_desc_gzcbl004_desc(263,sr3.pmek004_2)RETURNING sr3.pmek004_2 
                         WHEN sr3.pmek002_2  = 'pmdl021' #付款供應商
                            CALL s_desc_get_trading_partner_abbr_desc(sr3.pmek004_2)RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2  = 'pmdl022' #送貨供應商
                            CALL s_desc_get_trading_partner_abbr_desc(sr3.pmek004_2)RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2  = 'pmdl023' #採購分類一
                            CALL s_desc_get_acc_desc(275,sr3.pmek004_2) RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2  = 'pmdl024' #採購分類二
                            CALL s_desc_get_acc_desc(264,sr3.pmek004_2) RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2 = 'pmdl025' #送貨地址
                            CALL apmr510_g01_pmdl025_ref(sr3.pmek004_2)RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2 = 'pmdl026' #帳款地址
                            CALL apmr510_g01_pmdl026_ref(sr3.pmek004_2)RETURNING sr3.pmek004_2   
                         WHEN sr3.pmek002_2 = 'pmdl027' #供應商連絡人
                            CALL s_desc_get_person_desc(sr3.pmek004_2)RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2  = 'pmdl029' #收貨部門 
                            CALL s_desc_get_department_desc(sr3.pmek004_2)RETURNING sr3.pmek004_2                            
                         WHEN sr3.pmek002_2  = 'pmdl032' #最終客戶 
                            CALL s_desc_get_trading_partner_abbr_desc(sr3.pmek004_2)RETURNING sr3.pmek004_2  
                         WHEN sr3.pmek002_2  = 'pmdl033' #發票類型 
                            CALL apmr510_g01_pmdl033_ref(sr3.pmek004_2)RETURNING sr3.pmek004_2 
                         WHEN sr3.pmek002_2  = 'pmdl043' #留置原因 
                            CALL s_desc_get_acc_desc(298,sr3.pmek004_2) RETURNING sr3.pmek004_2
                         WHEN sr3.pmek002_2  = 'pmdl052' #最終供應商
                            CALL s_desc_get_trading_partner_abbr_desc(sr3.pmek004_2)RETURNING sr3.pmek004_2   
                       END CASE
                        
                       CALL apmr510_g01_pmek002_ref(sr3.pmek002_2) RETURNING sr3.pmek002_2_desc                     
                    END IF
                                       
                    CALL apmr510_g01_pmee_chg(sr3.pmek002_1,sr3.pmek002_2,'pmdl004')RETURNING l_pmee004  #如果相等表示有變更
                    CALL apmr510_g01_pmee_chg(sr3.pmek002_1,sr3.pmek002_2,'pmdl021')RETURNING l_pmee021
                    CALL apmr510_g01_pmee_chg(sr3.pmek002_1,sr3.pmek002_2,'pmdl022')RETURNING l_pmee022
                    CALL apmr510_g01_pmee_chg(sr3.pmek002_1,sr3.pmek002_2,'pmdl009')RETURNING l_pmee009
                    CALL apmr510_g01_pmee_chg(sr3.pmek002_1,sr3.pmek002_2,'pmdl010')RETURNING l_pmee010
                    CALL apmr510_g01_pmee_chg(sr3.pmek002_1,sr3.pmek002_2,'pmdl011')RETURNING l_pmee011
                    CALL apmr510_g01_pmee_chg(sr3.pmek002_1,sr3.pmek002_2,'pmdl015')RETURNING l_pmee015
                    CALL apmr510_g01_pmee_chg(sr3.pmek002_1,sr3.pmek002_2,'pmdl023')RETURNING l_pmee023
                    CALL apmr510_g01_pmee_chg(sr3.pmek002_1,sr3.pmek002_2,'pmdl002')RETURNING l_pmee002                    
                    CALL apmr510_g01_pmee_chg(sr3.pmek002_1,sr3.pmek002_2,'pmdl003')RETURNING l_pmee003
                
                    IF l_pmee004 != 0 THEN LET l_pmee004_btl = 0.5 END IF
                    IF l_pmee021 != 0 THEN LET l_pmee021_btl = 0.5 END IF
                    IF l_pmee022 != 0 THEN LET l_pmee022_btl = 0.5 END IF
                    IF l_pmee009 != 0 THEN LET l_pmee009_btl = 0.5 END IF
                    IF l_pmee010 != 0 THEN LET l_pmee010_btl = 0.5 END IF
                    IF l_pmee011 != 0 THEN LET l_pmee011_btl = 0.5 END IF
                    IF l_pmee015 != 0 THEN LET l_pmee015_btl = 0.5 END IF
                    IF l_pmee023 != 0 THEN LET l_pmee023_btl = 0.5 END IF
                    IF l_pmee002 != 0 THEN LET l_pmee002_btl = 0.5 END IF
                    IF l_pmee003 != 0 THEN LET l_pmee003_btl = 0.5 END IF

                    OUTPUT TO REPORT apmr510_g01_subrep05(sr3.*)
                    LET l_i = l_i + 2
                    IF l_i > l_ac THEN
                       EXIT WHILE
                    END IF
                 END  WHILE
              END IF
           FINISH REPORT apmr510_g01_subrep05
           PRINTX l_subrep05_show
           PRINTX l_pmee004_btl
           PRINTX l_pmee021_btl
           PRINTX l_pmee022_btl
           PRINTX l_pmee009_btl
           PRINTX l_pmee010_btl
           PRINTX l_pmee011_btl
           PRINTX l_pmee015_btl
           PRINTX l_pmee023_btl
           PRINTX l_pmee002_btl
           PRINTX l_pmee003_btl
           ###############################################################################################
           #多帳期
           START REPORT apmr510_g01_subrep06
           LET l_subrep06_show ="N"      
           LET sr5.l_pmef_show = 'Y'
           LET sr5.l_pmef_show_2 ='Y' 
           LET g_cnt = 0           
           LET g_sql = " SELECT pmefdocno,pmef001,pmef002,'',pmef003,pmef004,pmef005,pmef900,'','','','','','' ",
                       "   FROM pmef_t ",
                       "  WHERE pmefent   = '",sr1.pmeeent,"' ",
                       "    AND pmefdocno = '",sr1.pmeedocno CLIPPED,"'",
                       "    AND pmef900   = '",sr1.pmee900 CLIPPED,"' ",                      
                       "  ORDER BY pmef001 "             
           LET g_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
           PREPARE apmr510_g01_subrep06_cnt_pre FROM g_sql_cnt                     
           EXECUTE apmr510_g01_subrep06_cnt_pre INTO g_cnt
           FREE apmr510_g01_subrep06_cnt_pre    
           
           IF g_cnt > 0 THEN
              LET l_subrep06_show ="Y"   
              DECLARE apmr510_g01_repcur06 CURSOR FROM g_sql
              FOREACH apmr510_g01_repcur06 INTO sr5.*               
                 LET l_pmef_count = 0                           
                 #期別                
                 CALL apmr510_g01_chg(sr1.pmeeent,sr5.pmefdocno,0,0,0,sr5.pmef900,'pmdm001') RETURNING sr5.pmef001,l_cnt
                 LET sr5.l_pmef001_btl = 0.5
                 IF l_cnt = 0 THEN 
                    LET sr5.l_pmef001_btl = 0                  
                    LET sr5.pmef001 = sr5.pmef001_chg 
                    LET l_pmef_count = l_pmef_count + 1
                 END IF
                 # 付款條件           
                 CALL s_desc_get_ooib002_desc(sr5.pmef002_chg)RETURNING sr5.pmef002_desc_chg   #付款條件說明              
                 CALL apmr510_g01_chg(sr1.pmeeent,sr5.pmefdocno,0,0,0,sr5.pmef900,'pmdm002') RETURNING sr5.pmef002,l_cnt                  
                 LET sr5.l_pmef002_btl = 0.5              
                 IF l_cnt = 0  THEN
                    LET sr5.l_pmef002_btl = 0                 
                    LET sr5.pmef002 = sr5.pmef002_chg   
                    LET sr5.pmef002_desc =sr5.pmef002_desc_chg                                         
                    LET l_pmef_count = l_pmef_count + 1
                 ELSE
                    CALL s_desc_get_ooib002_desc(sr5.pmef002 )RETURNING sr5.pmef002_desc  #變更前付款條件說明 
                 END IF
                 #預計應付款日
                 CALL apmr510_g01_chg(sr1.pmeeent,sr5.pmefdocno,0,0,0,sr5.pmef900,'pmdm003') RETURNING sr5.pmef003,l_cnt
                 LET sr5.l_pmef003_btl = 0.5
                 IF l_cnt = 0  THEN 
                    LET sr5.l_pmef003_btl = 0
                    LET sr5.pmef003 = sr5.pmef003_chg
                    LET l_pmef_count = l_pmef_count + 1
                 END IF
                 #預計票據到期日
                 CALL apmr510_g01_chg(sr1.pmeeent,sr5.pmefdocno,0,0,0,sr5.pmef900,'pmdm004') RETURNING sr5.pmef004,l_cnt                 
                 LET sr5.l_pmef004_btl = 0.5
                 IF l_cnt = 0  THEN 
                    LET sr5.l_pmef004_btl = 0
                    LET sr5.pmef004 = sr5.pmef004_chg 
                    LET l_pmef_count = l_pmef_count + 1
                 END IF
                 #未稅金額
                 CALL apmr510_g01_chg(sr1.pmeeent,sr5.pmefdocno,0,0,0,sr5.pmef900,'pmdm005') RETURNING sr5.pmef005,l_cnt                                    
                 LET sr5.l_pmef005_btl = 0.5
                 IF l_cnt = 0  THEN 
                    LET sr5.l_pmef005_btl = 0
                    LET sr5.pmef005 = sr5.pmef005_chg 
                    LET l_pmef_count = l_pmef_count + 1
                 END IF
                 
                 IF l_pmef_count = 5 THEN     #無變更欄位                    
                    LET sr5.l_pmef_show = 'N' #全部都一樣沒變更過第二排隱藏
                       IF tm.a1 = 'Y' THEN       #只顯示有變更欄位
                          LET sr5.l_pmef_show_2 = 'N'                                         
                       END IF
                 END IF                               
                 OUTPUT TO REPORT apmr510_g01_subrep06(sr5.*)
              END FOREACH
           END IF
           FINISH REPORT apmr510_g01_subrep06
           PRINTX l_subrep06_show 
         
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
      
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
          #161031-00025#14 mark(s)
#          LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = '",
#              sr1.pmeeent CLIPPED ,"'", " AND  ooff002 = '", sr1.pmeedocno CLIPPED ,"'", " AND ooff003 = '",sr1.pmee900 CLIPPED,"' "
          #161031-00025#14 mark(e)
          #161031-00025#14 add(s)
          LET l_pmee900 = sr1.pmee900
          LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = ",
              sr1.pmeeent CLIPPED , " AND  ooff003 = '", sr1.pmeedocno CLIPPED ,"'", " AND ooff004 = '",l_pmee900 CLIPPED,"'"
          #161031-00025#14 add(e)
#           #end add-point:rep.sub01.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
#                sr1.pmeeent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr510_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE apmr510_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT apmr510_g01_subrep01
           DECLARE apmr510_g01_repcur01 CURSOR FROM g_sql
           FOREACH apmr510_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr510_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT apmr510_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT apmr510_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order.after name="rep.b_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.pmegseq
 
           #add-point:rep.b_group.pmegseq.before name="rep.b_group.pmegseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.pmegseq.after name="rep.b_group.pmegseq.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
            #161031-00025#14 mark(s)
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '",
#                 sr1.pmeeent CLIPPED ,"'", " AND  ooff002 = '", sr1.pmeedocno CLIPPED ,"'", " AND  ooff003 = '", sr1.pmee900 CLIPPED ,"'",
#                 "AND ooff004 = '", sr1.pmegseq CLIPPED ,"' "
             #161031-00025#14 mark(e)
             #161031-00025#14 add(s)
             LET l_pmee900 = sr1.pmee900
             LET l_pmegseq = sr1.pmegseq
             LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = ",
                 sr1.pmeeent CLIPPED , " AND  ooff003 = '", sr1.pmeedocno CLIPPED ,"'", " AND  ooff004 = '", l_pmee900 CLIPPED,"'",
                 " AND ooff005 = '", l_pmegseq CLIPPED ,"'"
             #161031-00025#14 add(e)
#           #end add-point:rep.sub02.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
#                sr1.pmeeent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'", " AND  ooff004 = ", 
#                sr1.pmegseq CLIPPED ,""
# 
#           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr510_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE apmr510_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT apmr510_g01_subrep02
           DECLARE apmr510_g01_repcur02 CURSOR FROM g_sql
           FOREACH apmr510_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr510_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT apmr510_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT apmr510_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          #單頭備註
          CALL apmr510_g01_show(sr1.pmee904,'','') RETURNING l_pmee904_show
          #單身備註
          CALL apmr510_g01_show(sr1.pmeg903,'','') RETURNING l_pmeg903_show
          #單身產品特徵
          CALL apmr510_g01_show(sr1.pmeg002,'','') RETURNING l_pmeg002_show
          #供應商料號
          CALL apmr510_g01_show(sr1.pmeg027,'','') RETURNING l_pmeg027_show
                      
          PRINTX l_pmee904_show
          PRINTX l_pmeg903_show
          PRINTX l_pmeg002_show
          PRINTX l_pmeg027_show

          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          START REPORT apmr510_g01_subrep07 
             LET l_subrep07_show ='Y'   
             LET l_pmeg_show ='Y'             
             LET l_count = 0
             #料號                       
             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdn001') RETURNING sr6.pmeg001,l_cnt                             
             LET l_pmeg001_btl = 0.5             
             IF l_cnt = 0 THEN 
                LET l_pmeg001_btl = 0
                LET sr6.pmeg001 = sr1.pmeg001
                LET sr6.imaal003 = sr1.x_t12_imaal003
                LET sr6.imaal004 = sr1.x_t12_imaal004  
                LET l_count = l_count + 1
             ELSE
                CALL s_desc_get_item_desc(sr6.pmeg001)RETURNING sr6.imaal003,sr6.imaal004  
             END IF          
             #產品特徵
             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdn002') RETURNING sr6.pmeg002,l_cnt
             LET l_pmeg002_btl = 0.5              
             IF l_cnt = 0 THEN 
                LET l_pmeg002_btl = 0
                LET sr6.pmeg002 = sr1.pmeg002 
                LET l_count = l_count + 1
                #CALL apmr510_g01_show(sr6.pmeg002,'','') RETURNING sr6.l_pmeg002_show  
             END IF             
             #出貨日期
             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdn012') RETURNING sr6.pmeg012,l_cnt
             LET l_pmeg012_btl = 0.5
             IF l_cnt = 0 THEN
                LET l_pmeg012_btl = 0             
                LET sr6.pmeg012 = sr1.pmeg012 
                LET l_count = l_count + 1
             END IF
             #銷售數量
             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdn007') RETURNING sr6.pmeg007,l_cnt
             LET l_pmeg007_btl = 0.5
             IF l_cnt = 0 THEN 
                LET l_pmeg007_btl = 0
                LET sr6.pmeg007 = sr1.pmeg007 
                LET l_count = l_count + 1
             END IF
             #單位
             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdn006') RETURNING sr6.pmeg006,l_cnt
             LET l_pmeg006_btl = 0.5
             IF l_cnt = 0 THEN
                LET l_pmeg006_btl = 0             
                LET sr6.pmeg006 = sr1.pmeg006 
                LET l_count = l_count + 1
             END IF
             #單價
             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdn015') RETURNING sr6.pmeg015,l_cnt
             LET l_pmeg015_btl = 0.5
             IF l_cnt = 0 THEN 
                LET l_pmeg015_btl = 0
                LET sr6.pmeg015 = sr1.pmeg015 
                LET l_count = l_count + 1
             END IF
             #未稅金額             
             #160328-00005#1-mod-(S)
#             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdn047') RETURNING sr6.pmeg046,l_cnt
             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdn046') RETURNING sr6.pmeg046,l_cnt
             #160328-00005#1-mod-(E)
             LET l_pmeg046_btl = 0.5
             IF l_cnt = 0 THEN
                LET l_pmeg046_btl = 0                
                LET sr6.pmeg046 = sr1.pmeg046 
                LET l_count = l_count + 1
             END IF
             #供應商料號             
             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdn027') RETURNING sr6.pmeg027,l_cnt
             CALL cl_getmsg('apm-00647',g_dlang) RETURNING l_pmeg027
             LET sr6.pmeg027_desc = l_pmeg027,sr6.pmeg027
             IF cl_null(sr6.pmeg027)THEN
                LET sr6.pmeg027_desc =''
             END IF
             LET l_pmeg027_btl = 0.5
             IF l_cnt = 0 THEN
                LET l_pmeg027_btl = 0                
                LET sr6.pmeg027 = sr1.pmeg027 
                LET sr6.pmeg027_desc = sr1.l_pmeg027_desc 
                IF cl_null(sr6.pmeg027)THEN
                   LET sr6.pmeg027_desc =''
                END IF
                LET l_count = l_count + 1
             END IF
             #緊急度                          
             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdn020') RETURNING sr6.pmeg020,l_cnt                       
             LET l_pmeg020_btl = 0.5
             IF l_cnt = 0 THEN
                LET l_pmeg020_btl = 0                
                LET sr6.pmeg020 = sr1.pmeg020 
                LET sr6.pmeg020_desc = sr1.l_pmeg020_desc
                LET l_count = l_count + 1                
             ELSE
                CALL s_desc_gzcbl004_desc('2036',sr6.pmeg020)RETURNING sr6.pmeg020_desc
                CALL apmr510_g01_show(sr6.pmeg020,'','') RETURNING sr6.l_pmeg020_show
             END IF
             #收貨據點
             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdnunit') RETURNING sr6.pmegunit,l_cnt
             LET l_pmegunit_btl = 0.5
             IF l_cnt = 0 THEN
                LET l_pmegunit_btl = 0                
                LET sr6.pmegunit = sr1.pmegunit 
                LET sr6.pmegunit_desc = sr1.l_pmegunit_ooefl003                
                LET l_count = l_count + 1
             ELSE
                CALL s_desc_get_department_desc(sr6.pmegunit)RETURNING sr6.pmegunit_desc
                CALL cl_getmsg('apm-00648',g_dlang) RETURNING l_pmegunit
                LET sr6.pmegunit_desc = l_pmegunit,sr6.pmegunit
                IF sr6.pmegunit = sr1.pmeesite OR cl_null(sr6.pmegunit) THEN 
                   LET sr6.pmegunit_desc = ''
                END IF
             END IF
             #付款據點
             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdnorga') RETURNING sr6.pmegorga,l_cnt
             LET l_pmegorga_btl = 0.5
             IF l_cnt = 0 THEN
                LET l_pmegorga_btl = 0                
                LET sr6.pmegorga = sr1.pmegorga
                LET sr6.pmegorga_desc = sr1.l_pmegorga_ooefl003
                LET l_count = l_count + 1
             ELSE
                CALL s_desc_get_department_desc(sr6.pmegorga)RETURNING sr6.pmegorga_desc
                CALL cl_getmsg('apm-00649',g_dlang) RETURNING l_pmegorga
                LET sr6.pmegorga_desc = l_pmegorga,sr6.pmegorga
                IF sr6.pmegorga = sr1.pmeesite OR cl_null(sr6.pmegorga) THEN
                   LET sr6.pmegorga_desc = ''
                END IF
             END IF
             #170110-00001#1 add-S
             #备注
             CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,0,0,sr1.pmee900,'pmdn050') RETURNING sr6.pmeg050,l_cnt
             LET l_pmeg050_btl = 0.5
             IF l_cnt = 0 THEN
                LET l_pmeg050_btl = 0             
                LET sr6.pmeg050 = sr1.pmeg050 
                LET l_count = l_count + 1
             END IF
             #170110-00001#1 add-E
             #170110-00001#1 mod-S
#             IF l_count = 11 THEN
             IF l_count = 12 THEN
             #170110-00001#1 mod-E
                LET l_subrep07_show ='N'
                IF tm.a1 = 'Y' THEN
                   LET l_pmeg_show ='N'
                END IF
             END IF                
          OUTPUT TO REPORT apmr510_g01_subrep07(sr6.*)
          FINISH REPORT apmr510_g01_subrep07          
          PRINTX l_subrep07_show
          PRINTX l_pmeg001_btl
          PRINTX l_pmeg002_btl
          PRINTX l_pmeg012_btl
          PRINTX l_pmeg007_btl
          PRINTX l_pmeg006_btl
          PRINTX l_pmeg015_btl
          PRINTX l_pmeg046_btl 
          PRINTX l_pmeg027_btl  
          PRINTX l_pmeg020_btl  
          PRINTX l_pmegunit_btl 
          PRINTX l_pmegorga_btl       
          PRINTX l_pmeg050_btl      #170110-00001#1 add          
          #####################################################################
          #多交期資料
          START REPORT apmr510_g01_subrep08
             LET l_subrep08_show ='N'
             LET sr7.pmehseq1_pmeh001_show ='N'       
             LET sr7.pmehseq1_btl = 0
             LET sr7.pmeh001_btl = 0              
             LET g_sql = "SELECT pmehdocno,pmehseq,pmeh003,'',pmehseq1,pmeh001,'','',pmeh002,pmehseq2,pmeh006,pmeh004,pmeh011 ",
                         "  FROM pmeh_t ",
                         " WHERE pmehdocno = '",sr1.pmeedocno  CLIPPED,"'",
                         "   AND pmehent   = '",sr1.pmeeent    CLIPPED,"'",
                         "   AND pmeh900   = '",sr1.pmee900    CLIPPED,"'",
                         "   AND pmehseq   = '",sr1.pmegseq    CLIPPED,"'",
                         "   ORDER BY pmehseq1,pmehseq2 "
             LET g_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
             PREPARE apmr510_g01_subrep08_cnt_pre FROM g_sql_cnt            
             LET g_cnt = 0
             EXECUTE apmr510_g01_subrep08_cnt_pre INTO g_cnt
             FREE apmr510_g01_subrep08_cnt_pre
                                                                  
             IF g_cnt > 1 THEN
                LET l_subrep08_show ='Y'
                LET l_pmeg_show = 'Y'
                LET g_sql_cnt = g_sql_cnt CLIPPED," WHERE pmeh003 <> '1' "
                PREPARE apmr510_g01_subrep08_cnt_pre01 FROM g_sql_cnt
                LET g_cnt = 0                                     
                EXECUTE apmr510_g01_subrep08_cnt_pre01 INTO g_cnt #子件特性不為'1'的筆數
                FREE apmr510_g01_subrep08_cnt_pre01                      
              
                DECLARE apmr510_g01_repcur08 CURSOR FROM g_sql
                FOREACH apmr510_g01_repcur08 INTO sr7.*
                   IF STATUS THEN INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = STATUS
                      LET g_errparam.extend = 'apmr510_g01_repcur03:'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      EXIT FOREACH
                   END IF                                                                                 
                   LET l_pmeh_count  = 0                                                        
                   LET sr7.pmeh_show='Y'                    
                   LET sr7.pmeh_chg_show ='Y'   
                   
                   #子件特性                    
                   CALL s_desc_gzcbl004_desc('2055',sr7.pmeh003_chg)RETURNING sr7.pmeh003_desc_chg 
                   LET sr7.pmeh003_desc_chg = sr7.pmeh003_chg CLIPPED,'.',sr7.pmeh003_desc_chg
                   CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr7.pmehseq1_chg,sr7.pmehseq2_chg,sr1.pmee900,'pmdo003') RETURNING sr7.pmeh003,l_cnt                                                      
                   LET sr7.pmeh003_btl = 0.5 
                   IF l_cnt = 0 THEN
                      LET sr7.pmeh003_btl = 0                    
                      LET sr7.pmeh003 = sr7.pmeh003_chg  
                      LET sr7.pmeh003_desc = sr7.pmeh003_desc_chg                       
                      LET l_pmeh_count = l_pmeh_count + 1
                   ELSE
                      CALL s_desc_gzcbl004_desc('2055',sr7.pmeh003)RETURNING sr7.pmeh003_desc 
                      LET sr7.pmeh003_desc  = sr7.pmeh003 CLIPPED,'.',sr7.pmeh003_desc  
                      IF cl_null(sr7.pmeh003) THEN 
                         LET sr7.pmeh003_desc = ''
                      END IF
                   END IF
                   
                   IF g_cnt > 0 THEN
                      LET sr7.pmehseq1_pmeh001_show ='Y'
                      #項序
                      CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr7.pmehseq1_chg,sr7.pmehseq2_chg,sr1.pmee900,'pmdoseq1') RETURNING sr7.pmehseq1,l_cnt
                      LET sr7.pmehseq1_btl = 0.5
                      IF l_cnt = 0 THEN
                         LET sr7.pmehseq1_btl = 0                    
                         LET sr7.pmehseq1 = sr7.pmehseq1_chg
                         LET l_pmeh_count = l_pmeh_count + 1                       
                      END IF
                      #料件編號 
                      CALL s_desc_get_item_desc(sr7.pmeh001_chg)RETURNING sr7.imaal003_chg,sr7.imaal004_chg #品名/規格             
                      CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr7.pmehseq1_chg,sr7.pmehseq2_chg,sr1.pmee900,'pmdo001') RETURNING sr7.pmeh001,l_cnt                                         
                      LET sr7.pmeh001_btl = 0.5
                      IF l_cnt = 0 THEN 
                         LET sr7.pmeh001_btl = 0
                         LET sr7.pmeh001 = sr7.pmeh001_chg
                         LET sr7.imaal003 = sr7.imaal003_chg
                         LET sr7.imaal004 = sr7.imaal004_chg
                         LET l_pmeh_count = l_pmeh_count + 1                   
                      ELSE
                         CALL s_desc_get_item_desc(sr7.pmeh001)RETURNING sr7.imaal003,sr7.imaal004 #品名/規格                        
                      END IF                                     
                      #產品特徵
                      CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr7.pmehseq1_chg,sr7.pmehseq2_chg,sr1.pmee900,'pmdo002') RETURNING sr7.pmeh002,l_cnt
                      IF cl_null(sr7.pmeh002_chg) THEN LET sr7.pmeh002_chg = 333 END IF                      
                      LET sr7.pmeh002_btl = 0          
                      IF l_cnt = 0 THEN 
                         LET sr7.pmeh002_btl = 0
                         LET sr7.pmeh002 = sr7.pmeh002_chg
                         LET l_pmeh_count = l_pmeh_count + 1                       
                      END IF   
                   END IF
                   #分批序   
                   CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr7.pmehseq1_chg,sr7.pmehseq2_chg,sr1.pmee900,'pmdoseq2') RETURNING sr7.pmehseq2,l_cnt
                   LET sr7.pmehseq2_btl = 0.5
                   IF l_cnt = 0 THEN 
                      LET sr7.pmehseq2_btl = 0
                      LET sr7.pmehseq2 = sr7.pmehseq2_chg
                      LET l_pmeh_count = l_pmeh_count + 1 
                   END IF                 
                   #分批數量
                   CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr7.pmehseq1_chg,sr7.pmehseq2_chg,sr1.pmee900,'pmdo006') RETURNING sr7.pmeh006,l_cnt
                   LET sr7.pmeh006_btl = 0.5
                   IF l_cnt = 0 THEN 
                      LET sr7.pmeh006_btl = 0
                      LET sr7.pmeh006 = sr7.pmeh006_chg
                      LET l_pmeh_count = l_pmeh_count + 1
                   END IF                 
                   #單位
                   CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr7.pmehseq1_chg,sr7.pmehseq2_chg,sr1.pmee900,'pmdo004') RETURNING sr7.pmeh004,l_cnt
                   LET sr7.pmeh004_btl = 0.5
                   IF l_cnt = 0 THEN 
                      LET sr7.pmeh004_btl = 0
                      LET sr7.pmeh004 = sr7.pmeh004_chg
                      LET l_pmeh_count = l_pmeh_count + 1 
                   END IF
                   #出貨日
                   CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr7.pmehseq1_chg,sr7.pmehseq2_chg,sr1.pmee900,'pmdo011') RETURNING sr7.pmeh011,l_cnt
                   LET sr7.pmeh011_btl = 0.5
                   IF l_cnt = 0 THEN 
                      LET sr7.pmeh011_btl = 0
                      LET sr7.pmeh011 = sr7.pmeh011_chg
                      LET l_pmeh_count = l_pmeh_count + 1 
                   END IF                       
                   IF g_cnt > 0 THEN
                       IF l_pmeh_count = 8 THEN
                          LET sr7.pmeh_show ='N' #沒變更 直接取xmeh資料 第二排隱藏
                          IF tm.a1 ='Y' THEN
                             LET sr7.pmeh_chg_show ='N' #只取有變更過的資料
                          END IF                       
                       END IF  
                    ELSE
                       IF l_pmeh_count = 5 THEN
                          LET sr7.pmeh_show ='N' #沒變更 直接取xmeh資料 第二排隱藏
                          IF tm.a1 ='Y' THEN
                             LET sr7.pmeh_chg_show ='N' #只取有變更過的資料
                          END IF                       
                       END IF  
                    END IF                            
                   OUTPUT TO REPORT apmr510_g01_subrep08(sr7.*)                    
                END FOREACH
             END IF
          FINISH REPORT apmr510_g01_subrep08
          IF sr7.pmeh_show = 'Y' OR  sr7.pmeh_chg_show ='Y' THEN
             LET l_pmeg_show = 'Y' 
          END IF
          PRINTX l_subrep08_show
          PRINTX l_pmeg_show
          
          #關聯單據明細
          START REPORT apmr510_g01_subrep09 
             LET l_subrep09_show= 'N'
             LET sr8.pmei_show ='Y' 
             LET sr8.pmei_chg_show ='Y'             
             LET g_sql = "SELECT pmeidocno,pmeiseq,pmeiseq1,pmei003,pmei004,pmei005,pmei006,pmei023,pmei022 ",
                         "  FROM pmei_t ",
                         " WHERE pmeidocno = '",sr1.pmeedocno  CLIPPED,"'",
                         "   AND pmeient   = '",sr1.pmeeent    CLIPPED,"'",
                         "   AND pmei900   = '",sr1.pmee900    CLIPPED,"'",
                         "   AND pmeiseq   = '",sr1.pmegseq    CLIPPED,"'",
                         "   ORDER BY pmeiseq1 "
             LET g_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
             PREPARE apmr510_g01_subrep09_cnt_pre FROM g_sql_cnt             
             LET g_cnt = 0
             EXECUTE apmr510_g01_subrep09_cnt_pre INTO g_cnt
             FREE apmr510_g01_subrep09_cnt_pre             
             IF g_cnt > 0 THEN                
                LET l_subrep09_show = 'Y'
                LET l_pmei_count = 0
                DECLARE apmr510_g01_repcur09 CURSOR FROM g_sql
                FOREACH apmr510_g01_repcur09 INTO sr8.*                                        
                   #來源單號
                   CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr8.pmeiseq1,0,sr1.pmee900,'pmdp003') RETURNING sr8.pmei003,l_cnt
                   LET sr8.pmei003_btl = 0.5
                   IF l_cnt = 0 THEN 
                      LET sr8.pmei003_btl= 0
                      LET sr8.pmei003 = sr8.pmei003_chg
                      LET l_pmei_count = l_pmei_count + 1 
                   END IF              
                   #來源項次
                   CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr8.pmeiseq1,0,sr1.pmee900,'pmdp004') RETURNING sr8.pmei004,l_cnt
                   LET sr8.pmei004_btl = 0.5
                   IF l_cnt = 0 THEN 
                      LET sr8.pmei004_btl= 0
                      LET sr8.pmei004 = sr8.pmei004_chg
                      LET l_pmei_count = l_pmei_count + 1 
                   END IF 
                   #來源項序
                   CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr8.pmeiseq1,0,sr1.pmee900,'pmdp005') RETURNING sr8.pmei005,l_cnt
                   LET sr8.pmei005_btl = 0.5
                   IF l_cnt = 0 THEN 
                      LET sr8.pmei005_btl= 0
                      LET sr8.pmei005 = sr8.pmei005_chg
                      LET l_pmei_count = l_pmei_count + 1 
                   END IF                   
                   #來源分批序
                   CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr8.pmeiseq1,0,sr1.pmee900,'pmdp006') RETURNING sr8.pmei006,l_cnt
                   LET sr8.pmei006_btl = 0.5
                   IF l_cnt = 0 THEN 
                      LET sr8.pmei006_btl = 0
                      LET sr8.pmei006 = sr8.pmei006_chg
                      LET l_pmei_count = l_pmei_count + 1 
                   END IF   
                   #需求數量
                   CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr8.pmeiseq1,0,sr1.pmee900,'pmdp023') RETURNING sr8.pmei023,l_cnt
                   LET sr8.pmei023_btl = 0.5
                   IF l_cnt = 0 THEN 
                      LET sr8.pmei023_btl= 0
                      LET sr8.pmei023 = sr8.pmei023_chg
                      LET l_pmei_count = l_pmei_count + 1 
                   END IF
                   #需求單位
                   CALL apmr510_g01_chg(sr1.pmeeent,sr1.pmeedocno,sr1.pmegseq,sr8.pmeiseq1,0,sr1.pmee900,'pmdp022') RETURNING sr8.pmei022,l_cnt
                   LET sr8.pmei022_btl = 0.5
                   IF l_cnt = 0 THEN 
                      LET sr8.pmei022_btl= 0
                      LET sr8.pmei022 = sr8.pmei022_chg
                      LET l_pmei_count = l_pmei_count + 1 
                   END IF                                    
                  IF l_pmei_count = 6 THEN
                      LET sr8.pmei_show ='N' #沒變更 直接取pmeh資料 第二排隱藏
                      IF tm.a1 ='Y' THEN
                         LET sr8.pmei_chg_show ='N' #只取有變更過的資料
                      END IF                       
                  END IF                    
                   OUTPUT TO REPORT apmr510_g01_subrep09(sr8.*)                    
                END FOREACH
             END IF
          FINISH REPORT apmr510_g01_subrep09
          PRINTX l_subrep09_show     
          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
 
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           #161031-00025#14 mark(s)
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '",
#                sr1.pmeeent CLIPPED ,"'", " AND  ooff002 = '", sr1.pmeedocno CLIPPED ,"'", " AND  ooff003 = '", sr1.pmee900 CLIPPED ,"'",
#                "AND ooff004 = '", sr1.pmegseq CLIPPED ,"' "
           #161031-00025#14 mark(e)
           #161031-00025#14 add(s)
           LET l_pmee900 = sr1.pmee900
           LET l_pmegseq = sr1.pmegseq
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = ",
                sr1.pmeeent CLIPPED , " AND  ooff003 = '", sr1.pmeedocno CLIPPED ,"'", " AND  ooff004 = '", l_pmee900 CLIPPED,"'",
                " AND ooff005 = '", l_pmegseq CLIPPED,"'"
           #161031-00025#14 add(e)
#           #end add-point:rep.sub03.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
#                sr1.pmeeent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'", " AND  ooff004 = ", 
#                sr1.pmegseq CLIPPED ,""
# 
#           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr510_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE apmr510_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT apmr510_g01_subrep03
           DECLARE apmr510_g01_repcur03 CURSOR FROM g_sql
           FOREACH apmr510_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr510_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT apmr510_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT apmr510_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_order
 
           #add-point:rep.a_group.l_order.before name="rep.a_group.l_order.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
          #161031-00025#14 mark(s)
#          LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = '",
#                 sr1.pmeeent CLIPPED ,"'", " AND  ooff002 = '", sr1.pmeedocno CLIPPED ,"'", " AND  ooff003 = '", sr1.pmee900 CLIPPED ,"'",
#                 "AND ooff004 = '", sr1.pmegseq CLIPPED ,"' "
          #161031-00025#14 mark(e)
          #161031-00025#14 add(s)
          LET l_pmee900 = sr1.pmee900
          LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = ",
                 sr1.pmeeent CLIPPED , " AND  ooff003 = '", sr1.pmeedocno CLIPPED ,"' AND  ooff004 = '", l_pmee900 CLIPPED,"'" 
          #161031-00025#14 add(e)
#           #end add-point:rep.sub04.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
#                sr1.pmeeent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr510_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE apmr510_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT apmr510_g01_subrep04
           DECLARE apmr510_g01_repcur04 CURSOR FROM g_sql
           FOREACH apmr510_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr510_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr510_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT apmr510_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order.after name="rep.a_group.l_order.after"
           LET l_pmeg046_sum = GROUP SUM(sr1.pmeg046)#未稅金額
           LET l_pmeg048_sum = GROUP SUM(sr1.pmeg048)#稅額
           LET l_pmeg047_sum = GROUP SUM(sr1.pmeg047)#含稅金額
           CALL apmr510_g01_show(l_pmeg046_sum,'','') RETURNING l_pmeg046_sum_show
           CALL apmr510_g01_show(l_pmeg048_sum,'','') RETURNING l_pmeg048_sum_show
           CALL apmr510_g01_show(l_pmeg047_sum,'','') RETURNING l_pmeg047_sum_show
            
           PRINTX l_pmeg046_sum,l_pmeg046_sum_show
           PRINTX l_pmeg048_sum,l_pmeg048_sum_show
           PRINTX l_pmeg047_sum,l_pmeg047_sum_show
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmegseq
 
           #add-point:rep.a_group.pmegseq.before name="rep.a_group.pmegseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.pmegseq.after name="rep.a_group.pmegseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="apmr510_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr510_g01_subrep01(sr2)
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
PRIVATE REPORT apmr510_g01_subrep02(sr2)
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
PRIVATE REPORT apmr510_g01_subrep03(sr2)
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
PRIVATE REPORT apmr510_g01_subrep04(sr2)
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
 
{<section id="apmr510_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: apmr510_g01_pmee011_ref(p_oodbl002)
# Input parameter: p_oodbl002  #稅別編號  
# Return code....: r_oodbl004  #稅別說明
# Date & Author..: 20140804 By Hans
################################################################################
PRIVATE FUNCTION apmr510_g01_pmee011_ref(p_oodbl002)
DEFINE r_oodbl004 LIKE oodbl_t.oodbl004 #說明
DEFINE p_oodbl002 LIKE oodbl_t.oodbl002 #代碼
  
   SELECT oodbl004 INTO r_oodbl004
     FROM oodbl_t,ooef_t
    WHERE ooef001 = g_site 
     AND oodblent = g_enterprise
     AND oodbl001 = ooef019
     AND oodbl002 = p_oodbl002
     AND oodbl003 = g_dlang
  
   RETURN  r_oodbl004

END FUNCTION

################################################################################
# Descriptions...: 回傳欄位名稱
# Memo...........:
# Usage..........: CALL apmr510_g01_pmek002_ref(p_pmek002)
#                  RETURNING r_pmek02_desc
# Input parameter: p_pmek002         變更欄位
# Return code....: r_pmek002_desc    欄位名稱
# Date & Author..: 2014/8/05 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr510_g01_pmek002_ref(p_pmek002)
DEFINE p_pmek002         LIKE pmek_t.pmek002
DEFINE r_pmek002_desc    LIKE dzeb_t.dzeb003
   
#   SELECT dzeb003 INTO r_pmek002_desc
#     FROM dzeb_t 
#    WHERE dzeb001 = 'pmdl_t'    #變更前欄名稱 
#      AND dzeb002 =  p_pmek002

   SELECT dzebl003 INTO r_pmek002_desc
     FROM dzebl_t 
    WHERE dzebl001 = p_pmek002    #變更前欄名稱 
      AND dzebl002 = g_dlang
        
   RETURN r_pmek002_desc
END FUNCTION

################################################################################
# Descriptions...: 抓取變更前資料
# Memo...........:
# Usage..........: CALL apmr510_g01_chg(p_pmekent,p_pmekdocno,p_pmekseq,p_pmekseq1,p_pmekseq2,p_pmek001,p_pmek002)
# Input parameter: p_pmekent    企業編號
#                  p_pmekdocno  單號
#                  p_pmekseq    項次
#                  p_pmekseq1   項序 
#                  p_pmekseq2   分批序
#                  p_pmek001    變更序
#                  p_pmek002    變更欄位
# Return code....: r_pmek004    變更前資料
#                  r_cnt        是否有變更過
# Date & Author..: 2014/08/09 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr510_g01_chg(p_pmekent,p_pmekdocno,p_pmekseq,p_pmekseq1,p_pmekseq2,p_pmek001,p_pmek002)
DEFINE r_pmek004   LIKE pmek_t.pmek004   #變更前欄位數值
DEFINE p_pmekent   LIKE pmek_t.pmekent   
DEFINE p_pmekdocno LIKE pmek_t.pmekdocno #單號
DEFINE p_pmekseq   LIKE pmek_t.pmekseq 
DEFINE p_pmekseq1  LIKE pmek_t.pmekseq1  
DEFINE p_pmekseq2  LIKE pmek_t.pmekseq2  #期別
DEFINE p_pmek001   LIKE pmek_t.pmek001   #變更序
DEFINE p_pmek002   LIKE pmek_t.pmek002   #變更欄位名稱
DEFINE l_pmek005   LIKE pmek_t.pmek005
DEFINE r_cnt       LIKE type_t.num5

   LET r_pmek004  = ''
   LET r_cnt = 0
   
   SELECT COUNT(*) INTO r_cnt
     FROM pmek_t 
    WHERE pmekent    = p_pmekent
      AND pmekdocno  = p_pmekdocno
      AND pmekseq    = p_pmekseq
      AND pmekseq1   = p_pmekseq1
      AND pmekseq2   = p_pmekseq2 
      AND pmek001    = p_pmek001 
      AND pmek002    = p_pmek002
      
   IF r_cnt ! =0 THEN 
      SELECT pmek004 INTO r_pmek004 
        FROM pmek_t 
       WHERE pmekent    = p_pmekent
         AND pmekdocno  = p_pmekdocno
         AND pmekseq    = p_pmekseq
         AND pmekseq1   = p_pmekseq1
         AND pmekseq2   = p_pmekseq2 
         AND pmek001    = p_pmek001
         AND pmek002    = p_pmek002
   END IF

      RETURN r_pmek004,r_cnt
END FUNCTION

################################################################################
# Descriptions...: 單頭欄位是否變更
# Memo...........:
# Usage..........: CALL apmr510_g01_pmee_chg(p_pmek002,p_pmek002_2,p_pmek002_3)
# Input parameter: p_pmek002     變更欄位
#                  p_pmek002_2   變更欄位
#                  p_pmek002_3   採購單欄位
# Return code....: 0.5/0
# Date & Author..: 2014/08/05 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr510_g01_pmee_chg(p_pmek002,p_pmek002_2,p_pmek002_3)
DEFINE p_pmek002   LIKE pmek_t.pmek002
DEFINE p_pmek002_2 LIKE pmek_t.pmek002
DEFINE p_pmek002_3 LIKE pmek_t.pmek002

 IF p_pmek002 = p_pmek002_3 OR p_pmek002_2 = p_pmek002_3 THEN
    RETURN 0.5
 ELSE
    RETURN 0
 END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmr510_g01_show(p_arg1,p_arg2,p_arg3)
# Input parameter: p_arg1
#                  p_arg2
#                  p_arg3
# Return code....: r_show
# Date & Author..: 2014/08/05 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr510_g01_show(p_arg1,p_arg2,p_arg3)
DEFINE p_arg1 LIKE type_t.chr1000
DEFINE p_arg2 LIKE type_t.chr1000
DEFINE p_arg3 LIKE type_t.chr1000
DEFINE r_show LIKE type_t.chr1

   IF cl_null(p_arg1) AND cl_null(p_arg2) AND cl_null(p_arg3) THEN
      LET r_show = "N"
   ELSE
      LET r_show = "Y"
   END IF
   
   RETURN r_show
   
END FUNCTION

################################################################################
# Descriptions...: 送貨地址說明
# Memo...........:
# Date & Author..: 2014/09/30
# Modify.........:
################################################################################
PUBLIC FUNCTION apmr510_g01_pmdl025_ref(p_pmdl025)
DEFINE p_pmdl025   LIKE pmdl_t.pmdl025
DEFINE r_oofb011   LIKE oofb_t.oofb011

       LET r_oofb011 =  ''
       SELECT oofb011 INTO r_oofb011 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = g_oofa001 AND oofb002 = '3' AND oofb019 = p_pmdl025
       RETURN r_oofb011
END FUNCTION

################################################################################
# Descriptions...: 帳款地址
# Memo...........:
# Usage..........: CALL apmr510_g01_pmdl026_ref(p_pmdl026)
# Date & Author..: 2014/09/30 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION apmr510_g01_pmdl026_ref(p_pmdl026)
DEFINE p_pmdl026   LIKE pmdl_t.pmdl026
DEFINE r_oofb011   LIKE oofb_t.oofb011

       LET r_oofb011 =  ''
       SELECT oofb011 INTO r_oofb011 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = g_oofa001 AND oofb002 = '5' AND oofb019 = p_pmdl026
       RETURN r_oofb011
END FUNCTION

################################################################################
# Descriptions...: 發票類型說明
# Memo...........:
# Usage..........: CALL apmr510_g01_pmdl033_ref(p_pmdl033)
# Date & Author..: 2014/09/30 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION apmr510_g01_pmdl033_ref(p_pmdl033)
DEFINE p_pmdl033    LIKE pmdl_t.pmdl033
DEFINE r_isacl004   LIKE isacl_t.isacl004
DEFINE l_ooef019    LIKE ooef_t.ooef019

   #獲得當前營運據點的所屬稅區
   LET l_ooef019 = ''
   SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmdl033
   CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001='"||l_ooef019||"' AND isacl002=? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_isacl004 = '', g_rtn_fields[1] , ''
   RETURN r_isacl004
END FUNCTION

 
{</section>}
 
{<section id="apmr510_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 單頭變更欄位子報表
# Memo...........:
# Modify.........:
################################################################################
PRIVATE REPORT apmr510_g01_subrep05(sr3)
DEFINE sr3 sr3_r    
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

################################################################################
# Descriptions...: 單頭多帳期子報表
# Memo...........:
# Modify.........:
################################################################################
PRIVATE REPORT apmr510_g01_subrep06(sr5)
DEFINE sr5 sr5_r    
    ORDER EXTERNAL BY sr5.pmefdocno
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT

################################################################################
# Descriptions...: 單身明細子報表
# Memo...........:
# Modify.........:
################################################################################
PRIVATE REPORT apmr510_g01_subrep07(sr6)
DEFINE sr6 sr6_r    
    
    FORMAT 
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr6.*
END REPORT

################################################################################
# Descriptions...: 多帳期子報表
# Memo...........:
# Modify.........:
################################################################################
PRIVATE REPORT apmr510_g01_subrep08(sr7)
DEFINE sr7 sr7_r 
    ORDER EXTERNAL BY sr7.pmehdocno,sr7.pmehseq,sr7.pmehseq1
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr7.*
END REPORT

################################################################################
# Descriptions...: 關聯單據子報表
# Memo...........:
# Modify.........:
################################################################################
PRIVATE REPORT apmr510_g01_subrep09(sr8)
DEFINE sr8 sr8_r     
    ORDER EXTERNAL BY sr8.pmeidocno
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr8.*
END REPORT

 
{</section>}
 
