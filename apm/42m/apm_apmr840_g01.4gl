#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr840_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-10-20 15:20:27), PR版次:0006(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000056
#+ Filename...: apmr840_g01
#+ Description: ...
#+ Creator....: 02159(2015-04-03 12:28:37)
#+ Modifier...: 05384 -SD/PR- 00000
 
{</section>}
 
{<section id="apmr840_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

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
   pmdl020 LIKE pmdl_t.pmdl020, 
   pmdl021 LIKE pmdl_t.pmdl021, 
   pmdl022 LIKE pmdl_t.pmdl022, 
   pmdl023 LIKE pmdl_t.pmdl023, 
   pmdl024 LIKE pmdl_t.pmdl024, 
   pmdl025 LIKE pmdl_t.pmdl025, 
   pmdl027 LIKE pmdl_t.pmdl027, 
   pmdl028 LIKE pmdl_t.pmdl028, 
   pmdl029 LIKE pmdl_t.pmdl029, 
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
   pmdl054 LIKE pmdl_t.pmdl054, 
   pmdl055 LIKE pmdl_t.pmdl055, 
   pmdl200 LIKE pmdl_t.pmdl200, 
   pmdl201 LIKE pmdl_t.pmdl201, 
   pmdl202 LIKE pmdl_t.pmdl202, 
   pmdl203 LIKE pmdl_t.pmdl203, 
   pmdl204 LIKE pmdl_t.pmdl204, 
   pmdldocdt LIKE pmdl_t.pmdldocdt, 
   pmdldocno LIKE pmdl_t.pmdldocno, 
   pmdlent LIKE pmdl_t.pmdlent, 
   pmdlsite LIKE pmdl_t.pmdlsite, 
   pmdlstus LIKE pmdl_t.pmdlstus, 
   pmdlunit LIKE pmdl_t.pmdlunit, 
   pmdn001 LIKE pmdn_t.pmdn001, 
   pmdn002 LIKE pmdn_t.pmdn002, 
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
   pmdn022 LIKE pmdn_t.pmdn022, 
   pmdn023 LIKE pmdn_t.pmdn023, 
   pmdn024 LIKE pmdn_t.pmdn024, 
   pmdn025 LIKE pmdn_t.pmdn025, 
   pmdn026 LIKE pmdn_t.pmdn026, 
   pmdn028 LIKE pmdn_t.pmdn028, 
   pmdn029 LIKE pmdn_t.pmdn029, 
   pmdn030 LIKE pmdn_t.pmdn030, 
   pmdn043 LIKE pmdn_t.pmdn043, 
   pmdn045 LIKE pmdn_t.pmdn045, 
   pmdn046 LIKE pmdn_t.pmdn046, 
   pmdn047 LIKE pmdn_t.pmdn047, 
   pmdn048 LIKE pmdn_t.pmdn048, 
   pmdn049 LIKE pmdn_t.pmdn049, 
   pmdn050 LIKE pmdn_t.pmdn050, 
   pmdn051 LIKE pmdn_t.pmdn051, 
   pmdn052 LIKE pmdn_t.pmdn052, 
   pmdn053 LIKE pmdn_t.pmdn053, 
   pmdn200 LIKE pmdn_t.pmdn200, 
   pmdn201 LIKE pmdn_t.pmdn201, 
   pmdn202 LIKE pmdn_t.pmdn202, 
   pmdn203 LIKE pmdn_t.pmdn203, 
   pmdn205 LIKE pmdn_t.pmdn205, 
   pmdn206 LIKE pmdn_t.pmdn206, 
   pmdn207 LIKE pmdn_t.pmdn207, 
   pmdn208 LIKE pmdn_t.pmdn208, 
   pmdn209 LIKE pmdn_t.pmdn209, 
   pmdn210 LIKE pmdn_t.pmdn210, 
   pmdn211 LIKE pmdn_t.pmdn211, 
   pmdn212 LIKE pmdn_t.pmdn212, 
   pmdn213 LIKE pmdn_t.pmdn213, 
   pmdn214 LIKE pmdn_t.pmdn214, 
   pmdn215 LIKE pmdn_t.pmdn215, 
   pmdn216 LIKE pmdn_t.pmdn216, 
   pmdn217 LIKE pmdn_t.pmdn217, 
   pmdn218 LIKE pmdn_t.pmdn218, 
   pmdn219 LIKE pmdn_t.pmdn219, 
   pmdn220 LIKE pmdn_t.pmdn220, 
   pmdn221 LIKE pmdn_t.pmdn221, 
   pmdn222 LIKE pmdn_t.pmdn222, 
   pmdn223 LIKE pmdn_t.pmdn223, 
   pmdn224 LIKE pmdn_t.pmdn224, 
   pmdn225 LIKE pmdn_t.pmdn225, 
   pmdnorga LIKE pmdn_t.pmdnorga, 
   pmdnseq LIKE pmdn_t.pmdnseq, 
   pmdnsite LIKE pmdn_t.pmdnsite, 
   pmdnunit LIKE pmdn_t.pmdnunit, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   t3_ooefl003 LIKE ooefl_t.ooefl003, 
   t5_ooefl003 LIKE ooefl_t.ooefl003, 
   t6_ooefl003 LIKE ooefl_t.ooefl003, 
   t7_pmaal004 LIKE pmaal_t.pmaal004, 
   t10_pmaal004 LIKE pmaal_t.pmaal004, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   t4_oocql004 LIKE oocql_t.oocql004, 
   t8_oocql004 LIKE oocql_t.oocql004, 
   t9_oocql004 LIKE oocql_t.oocql004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   oojdl_t_oojdl003 LIKE oojdl_t.oojdl003, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   l_pmdl022_pmaal004 LIKE type_t.chr100, 
   l_pmdl204_ooefl003 LIKE type_t.chr1000, 
   l_pmdlsite_ooefl003 LIKE type_t.chr1000, 
   l_pmdlunit_ooefl003 LIKE type_t.chr1000, 
   l_pmdnsite_desc LIKE type_t.chr30, 
   l_pmdl021_pmaal004 LIKE type_t.chr100, 
   l_pmdl029_ooefl003 LIKE type_t.chr1000, 
   l_pmdnunit_ooefl003 LIKE type_t.chr100, 
   l_pmdn203_ooefl003 LIKE type_t.chr100, 
   l_pmdn025_desc LIKE type_t.chr100, 
   l_pmdn025_addr LIKE type_t.chr1000, 
   l_pmdl203_desc LIKE type_t.chr100, 
   l_pmdl023_oojdl003 LIKE type_t.chr100, 
   l_pmdl200_ooefl003 LIKE type_t.chr1000, 
   l_sum047 LIKE type_t.chr30, 
   l_sum007 LIKE type_t.chr30, 
   l_pmdn047 LIKE type_t.chr30, 
   l_pmdn007 LIKE type_t.chr30, 
   l_pmdl027_oofa011 LIKE type_t.chr100, 
   l_imaal004 LIKE type_t.chr100, 
   l_imaal003 LIKE type_t.chr100, 
   l_pmdl004_pmaal004 LIKE type_t.chr100, 
   l_pmdl002_ooag011 LIKE type_t.chr300, 
   l_pmdl003_ooefl003 LIKE type_t.chr1000, 
   l_pmdo010 LIKE type_t.chr100, 
   l_pmdo010_desc LIKE type_t.chr100
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING                   #where condition
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
#多期帳款 
# TYPE sr3_r RECORD
#   pmdmdocno      LIKE pmdm_t.pmdmdocno,
#   pmdm001        LIKE pmdm_t.pmdm001,
#   pmdm002        LIKE pmdm_t.pmdm002,
#   l_pmdm002_desc LIKE ooibl_t.ooibl004,
#   pmdm003        LIKE pmdm_t.pmdm003,
#   pmdm004        LIKE pmdm_t.pmdm004,
#   pmdm005        LIKE pmdm_t.pmdm005,
#   pmdm006        LIKE pmdm_t.pmdm006   
#END RECORD
#多交期
 TYPE type_sr_t RECORD
   pmdnsite LIKE pmdn_t.pmdnsite
END RECORD

DEFINE sr_t    DYNAMIC ARRAY OF type_sr_t
DEFINE l_sum1  LIKE pmdn_t.pmdn007 
DEFINE l_sum2  LIKE pmdn_t.pmdn047
TYPE  sr3_r RECORD         
   #子報表05資料
   #子報表05資料
   pmdldocno     LIKE pmdl_t.pmdldocno, #采购單號
   pmdl004       LIKE pmdl_t.pmdl004,   #供应商编号
   pmdnsite      LIKE pmdn_t.pmdnsite,  #订货门店
   pmdn217       LIKE pmdn_t.pmdn217,   #结算方式
   staal003        LIKE type_t.chr500,     #结算方式名称
   oofc012         LIKE oofc_t.oofc012,       #预约电话
   pmdl008       LIKE pmdl_t.pmdl008,   #订货单号
   pmdl029       LIKE pmdl_t.pmdl029,   #收货部门
   pmdl002     LIKE pmdl_t.pmdl002, #管理科别
   pmdl002_desc LIKE rtaxl_t.rtaxl003,    #管理品类名称
   oofb017         LIKE oofb_t.oofb017,       #地址
   pmdn001       LIKE pmdn_t.pmdn001,   #商品编码
   #l_pmdn001     LIKE type_t.num20,    #160420-00039#22 20160722 mark by beckxie
   l_pmdn001     LIKE pmdn_t.pmdn001,   #160420-00039#22 20160722  add by beckxie
   pmdnseq       LIKE pmdn_t.pmdnseq,   #项次
   pmdn200       LIKE pmdn_t.pmdn200,   #条码
   imaal003        LIKE imaal_t.imaal003,     #商品名称
   imaal004        LIKE imaal_t.imaal004,     #规格
   pmdn201       LIKE pmdn_t.pmdn201,   #单位
   l_pmdn201_desc LIKE oocal_t.oocal003,    #单位说明
   pmdn202       LIKE pmdn_t.pmdn202,   #件数
   pmdnud011     LIKE pmdn_t.pmdn202, #件装数
   pmdn015       LIKE pmdn_t.pmdn015,   #进价
   pmdn007       LIKE pmdn_t.pmdn007,   #订货数量
   pmdn048       LIKE pmdn_t.pmdn048,   #进税税率
   pmdn047       LIKE pmdn_t.pmdn047,   #订价金额
   pmaal004        LIKE pmaal_t.pmaal004,
   ooefl003        LIKE ooefl_t.ooefl003,
   l_order         LIKE type_t.chr200  #2016-7-6 zhujing add   子报表5跳页依据
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
   pmdo013        LIKE pmdo_t.pmdo013,
   pmdo010        LIKE pmdo_t.pmdo010,
   l_pmdo010_desc LIKE type_t.chr100,
   imaal003       LIKE imaal_t.imaal003,
   imaal004       LIKE imaal_t.imaal004,   
   l_pmdo003_desc LIKE type_t.chr80,
   l_item_show    LIKE type_t.chr1
END RECORD

#end add-point
 
{</section>}
 
{<section id="apmr840_g01.main" readonly="Y" >}
PUBLIC FUNCTION apmr840_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "apmr840_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL apmr840_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL apmr840_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL apmr840_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr840_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr840_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
 
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,pmdl006,pmdl007,pmdl008,pmdl009,pmdl010, ",
                  "        pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,pmdl020,pmdl021,pmdl022,pmdl023,pmdl024, ",
                  "        pmdl025,pmdl027,pmdl028,pmdl029,pmdl033,pmdl040,pmdl041,pmdl042,pmdl043,pmdl044, ",
                  "        pmdl046,pmdl047,pmdl048,pmdl049,pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,pmdl203, ",
                  "        pmdl204,pmdldocdt,pmdldocno,pmdlent,pmdlsite,pmdlstus,pmdlunit,pmdn001,pmdn002,pmdn006, ",
                  "        pmdn007,pmdn008,pmdn009,pmdn010,pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,pmdn016, ",
                  "        pmdn017,pmdn019,pmdn020,pmdn022,pmdn023,pmdn024,pmdn025,pmdn026,pmdn028,pmdn029, ",
                  "        pmdn030,pmdn043,pmdn045,pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,pmdn051,pmdn052, ",
                  "        pmdn053,pmdn200,pmdn201,pmdn202,pmdn203,pmdn205,pmdn206,pmdn207,pmdn208,pmdn209, ",
                  "        pmdn210,pmdn211,pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,pmdn217,pmdn218,pmdn219, ",
                  "        pmdn220,pmdn221,pmdn222,pmdn223,pmdn224,pmdn225,pmdnorga,pmdnseq,pmdnsite,pmdnunit, ",
                  "        ooag_t.ooag011,ooefl_t.ooefl003,t1.ooefl003,t2.ooefl003,t3.ooefl003, ",
                  "        t5.ooefl003,t6.ooefl003,t7.pmaal004,t10.pmaal004,pmaal_t.pmaal004, ",
                  "        ooibl_t.ooibl004,oocql_t.oocql004,t4.oocql004,t8.oocql004,t9.oocql004, ",
                  "        ooail_t.ooail003,oojdl_t.oojdl003,oofa_t.oofa011, ",
                  "        trim(pmdl022)||'.'||trim(pmaal_t.pmaal004),trim(pmdl204)||'.'||trim(t2.ooefl003), ",
                  "        trim(pmdlsite)||'.'||trim(t3.ooefl003), ",
                  "        CASE WHEN COALESCE(trim(x.pmdnunit),' ') != ' ' ",
                  "                THEN trim(x.pmdnunit)||'.'||trim((SELECT ooefl003 FROM ooefl_t ",
                  "                                                   WHERE ooefl001 = x.pmdnsite AND ooeflent = x.pmdnent ",
                  "                                                     AND ooefl002 = '",g_dlang,"' ) ) END , ",
                  "        '',trim(pmdl021)||'.'||trim(t10.pmaal004),trim(pmdl029)||'.'||trim(ooefl_t.ooefl003), ",        
                  "        CASE WHEN COALESCE(trim(pmdnunit),' ') != ' ' THEN trim(pmdnunit)||'.'|| ",
                  "          (SELECT ooefl003  ",
                  "             FROM ooefl_t ",
                  "            WHERE ooeflent = ",g_enterprise,
                  "              AND ooefl001 = pmdnunit ",
                  "              AND ooefl002 = '",g_dlang,"') END, ",
                  "        CASE WHEN COALESCE(trim(x.pmdn203),' ') != ' ' THEN trim(pmdnunit)||'.'|| ",
                  "          (SELECT ooefl003  ",
                  "             FROM ooefl_t ",
                  "            WHERE ooeflent = ",g_enterprise,
                  "              AND ooefl001 = x.pmdn203 ",
                  "              AND ooefl002 = '",g_dlang,"') END, ",
                  "        '','',         ",
                  "          (SELECT gzcbl004 ",
                  "             FROM gzcb_t,gzcbl_t ",
                  "            WHERE gzcb001 = '6014' AND gzcb002 = pmdl203 ",
                  "              AND gzcb001 = gzcbl001  AND gzcb002 = gzcbl002 ",
                  "              AND gzcbl003 = '",g_dlang,"'), ",
                  "        CASE WHEN COALESCE(trim(pmdl023),' ') != ' ' THEN trim(pmdl023)||'.'||trim(oojdl_t.oojdl003) END , ",
                  "        CASE WHEN COALESCE(trim(pmdl200),' ') != ' ' THEN trim(pmdl200)||'.'||trim(t1.ooefl003) END , ",
                  "              (SELECT SUM(COALESCE(pmdn047,0))  ",
                  "                 FROM pmdn_t ",
                  "                WHERE pmdndocno = pmdldocno ",
                  "                  AND pmdnent = pmdlent ",
                  "                  AND pmdnsite = x.pmdnsite), ",
                  "              (SELECT SUM(COALESCE(pmdn007,0))  ",
                  "                 FROM pmdn_t ",
                  "                WHERE pmdndocno = pmdldocno ",
                  "                  AND pmdnent = pmdlent ",
                  "                  AND pmdnsite = x.pmdnsite), ",
                  "              (SELECT SUM(COALESCE(pmdn047,0))  ",
                  "                 FROM pmdn_t ",
                  "                WHERE pmdndocno = pmdldocno ",
                  "                  AND pmdnent = pmdlent ",
                  "                  ), ",
                  "              (SELECT SUM(COALESCE(pmdn007,0))  ",
                  "                 FROM pmdn_t ",
                  "                WHERE pmdndocno = pmdldocno ",
                  "                  AND pmdnent = pmdlent ",
                  "                  ), ",
                  "        CASE WHEN COALESCE(trim(pmdl027),' ') != ' ' THEN trim(pmdl027)||'.'||trim(oofa_t.oofa011) END,x.imaal004,x.imaal003, ",
                  "        CASE WHEN COALESCE(trim(pmdl004),' ') != ' ' THEN trim(pmdl004)||'.'||trim(t7.pmaal004) END , ",
                  "        CASE WHEN COALESCE(trim(pmdl002),' ') != ' ' THEN trim(pmdl002)||'.'||trim(ooag_t.ooag011) END, ",
                  "        CASE WHEN COALESCE(trim(pmdl003),' ') != ' ' THEN trim(pmdl003)||'.'||trim(t6.ooefl003) END, ",
                  "        CASE WHEN x.pmdn024 = 'N' THEN ",
                  "                 (SELECT pmdo010  ",
                  "                    FROM pmdo_t ",
                  "                   WHERE pmdoent = ",g_enterprise,
                  "                     AND pmdodocno = pmdldocno  ",
                  "                     AND pmdoseq = 1 ",
                  "                     AND pmdoseq1 = 1 ",
                  "                     AND pmdoseq2 = 1) END, ",
                  "                     CASE WHEN COALESCE((CASE WHEN x.pmdn024 = 'N' THEN  ",
                  "                 (SELECT pmdo010  ",
                  "                    FROM pmdo_t ",
                  "                   WHERE pmdoent = ",g_enterprise,
                  "                     AND pmdodocno = pmdldocno  ",
                  "                     AND pmdoseq = 1 ",
                  "                     AND pmdoseq1 = 1 ",
                  "                     AND pmdoseq2 = 1) END),' ') != ' ' THEN  ",
                  "                 (SELECT oocql004 FROM oocql_t ",
                  "                   WHERE oocqlent = ",g_enterprise,
                  "                     AND oocql001 = '274' ",
                  "                     AND oocql002 = (SELECT pmdo010 ", 
                  "                                      FROM pmdo_t ",
                  "                                     WHERE pmdoent = ",g_enterprise,
                  "                                       AND pmdodocno = pmdldocno  ",
                  "                                       AND pmdoseq = 1 ",
                  "                                       AND pmdoseq1 = 1 ",
                  "                                       AND pmdoseq2 = 1) ",
                  "                     AND oocql003 = '",g_dlang,"') END   "
#   #end add-point
#   LET g_select = " SELECT pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,pmdl006,pmdl007,pmdl008,pmdl009,pmdl010, 
#       pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,pmdl020,pmdl021,pmdl022,pmdl023,pmdl024,pmdl025,pmdl027, 
#       pmdl028,pmdl029,pmdl033,pmdl040,pmdl041,pmdl042,pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,pmdl049, 
#       pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,pmdl203,pmdl204,pmdldocdt,pmdldocno,pmdlent,pmdlsite, 
#       pmdlstus,pmdlunit,pmdn001,pmdn002,pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,pmdn011,pmdn012,pmdn013, 
#       pmdn014,pmdn015,pmdn016,pmdn017,pmdn019,pmdn020,pmdn022,pmdn023,pmdn024,pmdn025,pmdn026,pmdn028, 
#       pmdn029,pmdn030,pmdn043,pmdn045,pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,pmdn051,pmdn052,pmdn053, 
#       pmdn200,pmdn201,pmdn202,pmdn203,pmdn205,pmdn206,pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,pmdn212, 
#       pmdn213,pmdn214,pmdn215,pmdn216,pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,pmdn222,pmdn223,pmdn224, 
#       pmdn225,pmdnorga,pmdnseq,pmdnsite,pmdnunit,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmdl_t.pmdl002 AND ooag_t.ooagent = pmdl_t.pmdlent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdl_t.pmdl029 AND ooefl_t.ooeflent = pmdl_t.pmdlent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t1 WHERE t1.ooefl001 = pmdl_t.pmdl200 AND t1.ooeflent = pmdl_t.pmdlent AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooefl001 = pmdl_t.pmdl204 AND t2.ooeflent = pmdl_t.pmdlent AND t2.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t3 WHERE t3.ooefl001 = pmdl_t.pmdlsite AND t3.ooeflent = pmdl_t.pmdlent AND t3.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t5 WHERE t5.ooefl001 = pmdl_t.pmdlunit AND t5.ooeflent = pmdl_t.pmdlent AND t5.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t6 WHERE t6.ooefl001 = pmdl_t.pmdl003 AND t6.ooeflent = pmdl_t.pmdlent AND t6.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t7 WHERE t7.pmaal001 = pmdl_t.pmdl004 AND t7.pmaalent = pmdl_t.pmdlent AND t7.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t10 WHERE t10.pmaal001 = pmdl_t.pmdl021 AND t10.pmaalent = pmdl_t.pmdlent AND t10.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl022 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = pmdl_t.pmdl009 AND ooibl_t.ooiblent = pmdl_t.pmdlent AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '298' AND oocql_t.oocql002 = pmdl_t.pmdl043 AND oocql_t.oocqlent = pmdl_t.pmdlent AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t t4 WHERE t4.oocql001 = '264' AND t4.oocql002 = pmdl_t.pmdl024 AND t4.oocqlent = pmdl_t.pmdlent AND t4.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t t8 WHERE t8.oocql001 = '238' AND t8.oocql002 = pmdl_t.pmdl010 AND t8.oocqlent = pmdl_t.pmdlent AND t8.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t t9 WHERE t9.oocql001 = '263' AND t9.oocql002 = pmdl_t.pmdl020 AND t9.oocqlent = pmdl_t.pmdlent AND t9.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = pmdl_t.pmdl015 AND ooail_t.ooailent = pmdl_t.pmdlent AND ooail_t.ooail002 = '" , 
#       g_dlang,"'" ,"),( SELECT oojdl003 FROM oojdl_t WHERE oojdl_t.oojdl001 = pmdl_t.pmdl023 AND oojdl_t.oojdlent = pmdl_t.pmdlent AND oojdl_t.oojdl002 = '" , 
#       g_dlang,"'" ,"),( SELECT oofa011 FROM oofa_t WHERE oofa_t.oofa001 = pmdl_t.pmdl027 AND oofa_t.oofaent = pmdl_t.pmdlent), 
#       trim(pmdl022)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl022 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmdl204)||'.'||trim((SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooefl001 = pmdl_t.pmdl204 AND t2.ooeflent = pmdl_t.pmdlent AND t2.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmdlsite)||'.'||trim((SELECT ooefl003 FROM ooefl_t t3 WHERE t3.ooefl001 = pmdl_t.pmdlsite AND t3.ooeflent = pmdl_t.pmdlent AND t3.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmdlunit)||'.'||trim((SELECT ooefl003 FROM ooefl_t t5 WHERE t5.ooefl001 = pmdl_t.pmdlunit AND t5.ooeflent = pmdl_t.pmdlent AND t5.ooefl002 = '" , 
#       g_dlang,"'" ,")),'',trim(pmdl021)||'.'||trim((SELECT pmaal004 FROM pmaal_t t10 WHERE t10.pmaal001 = pmdl_t.pmdl021 AND t10.pmaalent = pmdl_t.pmdlent AND t10.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmdl029)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdl_t.pmdl029 AND ooefl_t.ooeflent = pmdl_t.pmdlent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmdnunit)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdl_t.pmdl029 AND ooefl_t.ooeflent = pmdl_t.pmdlent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmdn203)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdl_t.pmdl029 AND ooefl_t.ooeflent = pmdl_t.pmdlent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),'','','',trim(pmdl023)||'.'||trim((SELECT oojdl003 FROM oojdl_t WHERE oojdl_t.oojdl001 = pmdl_t.pmdl023 AND oojdl_t.oojdlent = pmdl_t.pmdlent AND oojdl_t.oojdl002 = '" , 
#       g_dlang,"'" ,")),trim(pmdl200)||'.'||trim((SELECT ooefl003 FROM ooefl_t t1 WHERE t1.ooefl001 = pmdl_t.pmdl200 AND t1.ooeflent = pmdl_t.pmdlent AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,")),'','','','',trim(pmdl027)||'.'||trim((SELECT oofa011 FROM oofa_t WHERE oofa_t.oofa001 = pmdl_t.pmdl027 AND oofa_t.oofaent = pmdl_t.pmdlent)), 
#       '','',trim(pmdl004)||'.'||trim((SELECT pmaal004 FROM pmaal_t t7 WHERE t7.pmaal001 = pmdl_t.pmdl004 AND t7.pmaalent = pmdl_t.pmdlent AND t7.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmdl002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmdl_t.pmdl002 AND ooag_t.ooagent = pmdl_t.pmdlent)), 
#       trim(pmdl003)||'.'||trim((SELECT ooefl003 FROM ooefl_t t6 WHERE t6.ooefl001 = pmdl_t.pmdl003 AND t6.ooeflent = pmdl_t.pmdlent AND t6.ooefl002 = '" , 
#       g_dlang,"'" ,")),'',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
  LET g_from = " FROM pmdl_t ",
               "      LEFT OUTER JOIN oojdl_t ON oojdl_t.oojdl001 = pmdl_t.pmdl023 AND oojdl_t.oojdlent = pmdl_t.pmdlent AND oojdl_t.oojdl002 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = pmdl_t.pmdl022 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN oofa_t ON oofa_t.oofa001 = pmdl_t.pmdl027 AND oofa_t.oofaent = pmdl_t.pmdlent ",
               "      LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = pmdl_t.pmdl029 AND ooefl_t.ooeflent = pmdl_t.pmdlent AND ooefl_t.ooefl002 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '298' AND oocql_t.oocql002 = pmdl_t.pmdl043 AND oocql_t.oocqlent = pmdl_t.pmdlent AND oocql_t.oocql003 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN ooefl_t t1 ON t1.ooefl001 = pmdl_t.pmdl200 AND t1.ooeflent = pmdl_t.pmdlent AND t1.ooefl002 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN ooefl_t t2 ON t2.ooefl001 = pmdl_t.pmdl204 AND t2.ooeflent = pmdl_t.pmdlent AND t2.ooefl002 = '",g_dlang,"' ",    
               "      LEFT OUTER JOIN ooefl_t t3 ON t3.ooefl001 = pmdl_t.pmdlsite AND t3.ooeflent = pmdl_t.pmdlent AND t3.ooefl002 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN oocql_t t4 ON t4.oocql001 = '264' AND t4.oocql002 = pmdl_t.pmdl024 AND t4.oocqlent = pmdl_t.pmdlent AND t4.oocql003 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = pmdl_t.pmdl002 AND ooag_t.ooagent = pmdl_t.pmdlent ",
               "      LEFT OUTER JOIN ooefl_t t5 ON t5.ooefl001 = pmdl_t.pmdlunit AND t5.ooeflent = pmdl_t.pmdlent AND t5.ooefl002 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN ooefl_t t6 ON t6.ooefl001 = pmdl_t.pmdl003 AND t6.ooeflent = pmdl_t.pmdlent AND t6.ooefl002 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN pmaal_t t7 ON t7.pmaal001 = pmdl_t.pmdl004 AND t7.pmaalent = pmdl_t.pmdlent AND t7.pmaal002 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = pmdl_t.pmdl009 AND ooibl_t.ooiblent = pmdl_t.pmdlent AND ooibl_t.ooibl003 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN oocql_t t8 ON t8.oocql001 = '238' AND t8.oocql002 = pmdl_t.pmdl010 AND t8.oocqlent = pmdl_t.pmdlent AND t8.oocql003 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = pmdl_t.pmdl015 AND ooail_t.ooailent = pmdl_t.pmdlent AND ooail_t.ooail002 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN oocql_t t9 ON t9.oocql001 = '263' AND t9.oocql002 = pmdl_t.pmdl020 AND t9.oocqlent = pmdl_t.pmdlent AND t9.oocql003 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN pmaal_t t10 ON t10.pmaal001 = pmdl_t.pmdl021 AND t10.pmaalent = pmdl_t.pmdlent AND t10.pmaal002 = '",g_dlang,"' ",
               "      LEFT OUTER JOIN ( SELECT pmdn_t.*,imaal003,imaal004 FROM pmdn_t LEFT JOIN imaal_t ON imaalent = pmdnent AND imaal001 = pmdn001 AND imaal002 = '",g_dlang,"' ) x ",
               "                   ON pmdl_t.pmdlent = x.pmdnent     AND pmdl_t.pmdldocno = x.pmdndocno "
#   #end add-point
#    LET g_from = " FROM pmdl_t LEFT OUTER JOIN ( SELECT pmdn_t.* FROM pmdn_t  ) x  ON pmdl_t.pmdlent  
#        = x.pmdnent AND pmdl_t.pmdldocno = x.pmdndocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    LET g_where = g_where CLIPPED, "AND pmdl203 IS NOT NULL " #採購方式不為空值
   #end add-point
    LET g_order = " ORDER BY pmdnsite,pmdldocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmdl_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
 
   #end add-point
   PREPARE apmr840_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE apmr840_g01_curs CURSOR FOR apmr840_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr840_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr840_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
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
   pmdl020 LIKE pmdl_t.pmdl020, 
   pmdl021 LIKE pmdl_t.pmdl021, 
   pmdl022 LIKE pmdl_t.pmdl022, 
   pmdl023 LIKE pmdl_t.pmdl023, 
   pmdl024 LIKE pmdl_t.pmdl024, 
   pmdl025 LIKE pmdl_t.pmdl025, 
   pmdl027 LIKE pmdl_t.pmdl027, 
   pmdl028 LIKE pmdl_t.pmdl028, 
   pmdl029 LIKE pmdl_t.pmdl029, 
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
   pmdl054 LIKE pmdl_t.pmdl054, 
   pmdl055 LIKE pmdl_t.pmdl055, 
   pmdl200 LIKE pmdl_t.pmdl200, 
   pmdl201 LIKE pmdl_t.pmdl201, 
   pmdl202 LIKE pmdl_t.pmdl202, 
   pmdl203 LIKE pmdl_t.pmdl203, 
   pmdl204 LIKE pmdl_t.pmdl204, 
   pmdldocdt LIKE pmdl_t.pmdldocdt, 
   pmdldocno LIKE pmdl_t.pmdldocno, 
   pmdlent LIKE pmdl_t.pmdlent, 
   pmdlsite LIKE pmdl_t.pmdlsite, 
   pmdlstus LIKE pmdl_t.pmdlstus, 
   pmdlunit LIKE pmdl_t.pmdlunit, 
   pmdn001 LIKE pmdn_t.pmdn001, 
   pmdn002 LIKE pmdn_t.pmdn002, 
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
   pmdn022 LIKE pmdn_t.pmdn022, 
   pmdn023 LIKE pmdn_t.pmdn023, 
   pmdn024 LIKE pmdn_t.pmdn024, 
   pmdn025 LIKE pmdn_t.pmdn025, 
   pmdn026 LIKE pmdn_t.pmdn026, 
   pmdn028 LIKE pmdn_t.pmdn028, 
   pmdn029 LIKE pmdn_t.pmdn029, 
   pmdn030 LIKE pmdn_t.pmdn030, 
   pmdn043 LIKE pmdn_t.pmdn043, 
   pmdn045 LIKE pmdn_t.pmdn045, 
   pmdn046 LIKE pmdn_t.pmdn046, 
   pmdn047 LIKE pmdn_t.pmdn047, 
   pmdn048 LIKE pmdn_t.pmdn048, 
   pmdn049 LIKE pmdn_t.pmdn049, 
   pmdn050 LIKE pmdn_t.pmdn050, 
   pmdn051 LIKE pmdn_t.pmdn051, 
   pmdn052 LIKE pmdn_t.pmdn052, 
   pmdn053 LIKE pmdn_t.pmdn053, 
   pmdn200 LIKE pmdn_t.pmdn200, 
   pmdn201 LIKE pmdn_t.pmdn201, 
   pmdn202 LIKE pmdn_t.pmdn202, 
   pmdn203 LIKE pmdn_t.pmdn203, 
   pmdn205 LIKE pmdn_t.pmdn205, 
   pmdn206 LIKE pmdn_t.pmdn206, 
   pmdn207 LIKE pmdn_t.pmdn207, 
   pmdn208 LIKE pmdn_t.pmdn208, 
   pmdn209 LIKE pmdn_t.pmdn209, 
   pmdn210 LIKE pmdn_t.pmdn210, 
   pmdn211 LIKE pmdn_t.pmdn211, 
   pmdn212 LIKE pmdn_t.pmdn212, 
   pmdn213 LIKE pmdn_t.pmdn213, 
   pmdn214 LIKE pmdn_t.pmdn214, 
   pmdn215 LIKE pmdn_t.pmdn215, 
   pmdn216 LIKE pmdn_t.pmdn216, 
   pmdn217 LIKE pmdn_t.pmdn217, 
   pmdn218 LIKE pmdn_t.pmdn218, 
   pmdn219 LIKE pmdn_t.pmdn219, 
   pmdn220 LIKE pmdn_t.pmdn220, 
   pmdn221 LIKE pmdn_t.pmdn221, 
   pmdn222 LIKE pmdn_t.pmdn222, 
   pmdn223 LIKE pmdn_t.pmdn223, 
   pmdn224 LIKE pmdn_t.pmdn224, 
   pmdn225 LIKE pmdn_t.pmdn225, 
   pmdnorga LIKE pmdn_t.pmdnorga, 
   pmdnseq LIKE pmdn_t.pmdnseq, 
   pmdnsite LIKE pmdn_t.pmdnsite, 
   pmdnunit LIKE pmdn_t.pmdnunit, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   t3_ooefl003 LIKE ooefl_t.ooefl003, 
   t5_ooefl003 LIKE ooefl_t.ooefl003, 
   t6_ooefl003 LIKE ooefl_t.ooefl003, 
   t7_pmaal004 LIKE pmaal_t.pmaal004, 
   t10_pmaal004 LIKE pmaal_t.pmaal004, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   t4_oocql004 LIKE oocql_t.oocql004, 
   t8_oocql004 LIKE oocql_t.oocql004, 
   t9_oocql004 LIKE oocql_t.oocql004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   oojdl_t_oojdl003 LIKE oojdl_t.oojdl003, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   l_pmdl022_pmaal004 LIKE type_t.chr100, 
   l_pmdl204_ooefl003 LIKE type_t.chr1000, 
   l_pmdlsite_ooefl003 LIKE type_t.chr1000, 
   l_pmdlunit_ooefl003 LIKE type_t.chr1000, 
   l_pmdnsite_desc LIKE type_t.chr30, 
   l_pmdl021_pmaal004 LIKE type_t.chr100, 
   l_pmdl029_ooefl003 LIKE type_t.chr1000, 
   l_pmdnunit_ooefl003 LIKE type_t.chr100, 
   l_pmdn203_ooefl003 LIKE type_t.chr100, 
   l_pmdn025_desc LIKE type_t.chr100, 
   l_pmdn025_addr LIKE type_t.chr1000, 
   l_pmdl203_desc LIKE type_t.chr100, 
   l_pmdl023_oojdl003 LIKE type_t.chr100, 
   l_pmdl200_ooefl003 LIKE type_t.chr1000, 
   l_sum047 LIKE type_t.chr30, 
   l_sum007 LIKE type_t.chr30, 
   l_pmdn047 LIKE type_t.chr30, 
   l_pmdn007 LIKE type_t.chr30, 
   l_pmdl027_oofa011 LIKE type_t.chr100, 
   l_imaal004 LIKE type_t.chr100, 
   l_imaal003 LIKE type_t.chr100, 
   l_pmdl004_pmaal004 LIKE type_t.chr100, 
   l_pmdl002_ooag011 LIKE type_t.chr300, 
   l_pmdl003_ooefl003 LIKE type_t.chr1000, 
   l_pmdo010 LIKE type_t.chr100, 
   l_pmdo010_desc LIKE type_t.chr100
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_ooef001       LIKE ooef_t.ooef001
   define l_pmdnsiteu     like pmdn_t.pmdnsite
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH apmr840_g01_curs INTO sr_s.*
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
       
       #採購方式
       if sr_s.pmdnsite=l_pmdnsiteu then 
          continue  foreach
       end if
       
       #收貨地址
       IF sr_s.pmdl203 = '3' THEN
          LET l_ooef001 = sr_s.pmdn223
       ELSE
          LET l_ooef001 = sr_s.pmdnunit
       END IF
       CALL s_apmt840_address_ref('3',sr_s.pmdn025,l_ooef001)
          RETURNING sr_s.l_pmdn025_desc,sr_s.l_pmdn025_addr
          
       #160420-00039#22 20160722 mark by beckxie---S
       #CALL s_desc_gzcbl004_desc('6014',sr_s.pmdl203) RETURNING sr_s.l_pmdl203_desc
       #
       ##品名,規格
       #SELECT imaal003,imaal004 INTO sr_s.l_imaal003,sr_s.l_imaal004
       #  FROM imaal_t
       # WHERE imaalent = g_enterprise
       #   AND imaal001 = sr_s.pmdn001      
       #   AND imaal002 = g_dlang      
       #
       ##收貨時段
       #IF sr_s.pmdn024 = 'N' THEN #不為多交期
       #   SELECT pmdo010 INTO sr_s.l_pmdo010
       #     FROM pmdo_t
       #    WHERE pmdoent = g_enterprise
       #      AND pmdodocno = sr_s.pmdldocno 
       #      AND pmdoseq = 1
       #      AND pmdoseq1 = 1
       #      AND pmdoseq2 = 1
       #    IF cl_null(sr_s.l_pmdo010) THEN
       #       LET sr_s.l_pmdo010_desc = ' '
       #    ELSE
       #       CALL s_desc_get_acc_desc('274',sr_s.l_pmdo010) RETURNING sr_s.l_pmdo010_desc
       #    END IF
       #END IF
       #
       ##單身收貨組織
       #CALL s_desc_get_department_desc(sr_s.pmdnunit) RETURNING sr_s.l_pmdnunit_ooefl003
       #LET sr_s.l_pmdnunit_ooefl003 = sr_s.pmdnunit,'.',sr_s.l_pmdnunit_ooefl003              
       #
       ##單身收貨部門
       #CALL s_desc_get_department_desc(sr_s.pmdn203) RETURNING sr_s.l_pmdn203_ooefl003
       #LET sr_s.l_pmdn203_ooefl003 = sr_s.pmdn203,'.',sr_s.l_pmdn203_ooefl003
       #
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       #CALL apmr840_g01_initialize(sr_s.pmdl004,sr_s.l_pmdl004_pmaal004) RETURNING sr_s.l_pmdl004_pmaal004
       #CALL apmr840_g01_initialize(sr_s.pmdl027,sr_s.l_pmdl027_oofa011) RETURNING sr_s.l_pmdl027_oofa011
       #CALL apmr840_g01_initialize(sr_s.pmdl200,sr_s.l_pmdl200_ooefl003) RETURNING sr_s.l_pmdl200_ooefl003
       #CALL apmr840_g01_initialize(sr_s.pmdl023,sr_s.l_pmdl023_oojdl003) RETURNING sr_s.l_pmdl023_oojdl003
       #CALL apmr840_g01_initialize(sr_s.pmdl002,sr_s.l_pmdl002_ooag011) RETURNING sr_s.l_pmdl002_ooag011
       #CALL apmr840_g01_initialize(sr_s.pmdl003,sr_s.l_pmdl003_ooefl003) RETURNING sr_s.l_pmdl003_ooefl003
       #CALL apmr840_g01_initialize(sr_s.pmdnunit,sr_s.l_pmdnunit_ooefl003) RETURNING sr_s.l_pmdnunit_ooefl003
       #CALL apmr840_g01_initialize(sr_s.pmdn203,sr_s.l_pmdn203_ooefl003) RETURNING sr_s.l_pmdn203_ooefl003
	    #160420-00039#22 20160722 mark by beckxie---E
	    #收貨組織/收貨部門/收貨時段
       LET sr_s.l_pmdnunit_ooefl003 = sr_s.l_pmdnunit_ooefl003,'/',sr_s.l_pmdn203_ooefl003,'/',sr_s.l_pmdo010_desc
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
         #160420-00039#22 20160722 mark by beckxie---S
         #SELECT ooefl003 into sr_s.l_pmdnsite_desc from ooefl_t 
         #where ooefl001 = sr_s.pmdnsite AND t3.ooeflent = sr_s.pmdlent AND t3.ooefl002 = g_dlang          
         #160420-00039#22 20160722 mark by beckxie---E
         # SELECT SUM(COALESCE(pmdn007,0)),SUM(COALESCE(pmdn047,0)) 
         # INTO sr_s.l_pmdn007,sr_s.l_pmdn047  # 订货数量，定价金额
         # FROM pmdn_t
         #WHERE pmdndocno = sr_s.pmdldocno
         #  AND pmdnent = g_enterprise
         #  AND pmdnsite = sr_s.pmdnsite
         #SELECT SUM(COALESCE(pmdn007,0)),SUM(COALESCE(pmdn047,0)) 
         # INTO sr_s.l_sum007,sr_s.l_sum047  # 订货数量，定价金额
         # FROM pmdn_t
         #WHERE pmdndocno = sr_s.pmdldocno
         #  AND pmdnent = g_enterprise
          #160420-00039#22 20160722 mark by beckxie---E
       #end add-point
 
       #set rep array value
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
       LET sr[l_cnt].pmdl020 = sr_s.pmdl020
       LET sr[l_cnt].pmdl021 = sr_s.pmdl021
       LET sr[l_cnt].pmdl022 = sr_s.pmdl022
       LET sr[l_cnt].pmdl023 = sr_s.pmdl023
       LET sr[l_cnt].pmdl024 = sr_s.pmdl024
       LET sr[l_cnt].pmdl025 = sr_s.pmdl025
       LET sr[l_cnt].pmdl027 = sr_s.pmdl027
       LET sr[l_cnt].pmdl028 = sr_s.pmdl028
       LET sr[l_cnt].pmdl029 = sr_s.pmdl029
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
       LET sr[l_cnt].pmdl054 = sr_s.pmdl054
       LET sr[l_cnt].pmdl055 = sr_s.pmdl055
       LET sr[l_cnt].pmdl200 = sr_s.pmdl200
       LET sr[l_cnt].pmdl201 = sr_s.pmdl201
       LET sr[l_cnt].pmdl202 = sr_s.pmdl202
       LET sr[l_cnt].pmdl203 = sr_s.pmdl203
       LET sr[l_cnt].pmdl204 = sr_s.pmdl204
       LET sr[l_cnt].pmdldocdt = sr_s.pmdldocdt
       LET sr[l_cnt].pmdldocno = sr_s.pmdldocno
       LET sr[l_cnt].pmdlent = sr_s.pmdlent
       LET sr[l_cnt].pmdlsite = sr_s.pmdlsite
       LET sr[l_cnt].pmdlstus = sr_s.pmdlstus
       LET sr[l_cnt].pmdlunit = sr_s.pmdlunit
       LET sr[l_cnt].pmdn001 = sr_s.pmdn001
       LET sr[l_cnt].pmdn002 = sr_s.pmdn002
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
       LET sr[l_cnt].pmdn022 = sr_s.pmdn022
       LET sr[l_cnt].pmdn023 = sr_s.pmdn023
       LET sr[l_cnt].pmdn024 = sr_s.pmdn024
       LET sr[l_cnt].pmdn025 = sr_s.pmdn025
       LET sr[l_cnt].pmdn026 = sr_s.pmdn026
       LET sr[l_cnt].pmdn028 = sr_s.pmdn028
       LET sr[l_cnt].pmdn029 = sr_s.pmdn029
       LET sr[l_cnt].pmdn030 = sr_s.pmdn030
       LET sr[l_cnt].pmdn043 = sr_s.pmdn043
       LET sr[l_cnt].pmdn045 = sr_s.pmdn045
       LET sr[l_cnt].pmdn046 = sr_s.pmdn046
       LET sr[l_cnt].pmdn047 = sr_s.pmdn047
       LET sr[l_cnt].pmdn048 = sr_s.pmdn048
       LET sr[l_cnt].pmdn049 = sr_s.pmdn049
       LET sr[l_cnt].pmdn050 = sr_s.pmdn050
       LET sr[l_cnt].pmdn051 = sr_s.pmdn051
       LET sr[l_cnt].pmdn052 = sr_s.pmdn052
       LET sr[l_cnt].pmdn053 = sr_s.pmdn053
       LET sr[l_cnt].pmdn200 = sr_s.pmdn200
       LET sr[l_cnt].pmdn201 = sr_s.pmdn201
       LET sr[l_cnt].pmdn202 = sr_s.pmdn202
       LET sr[l_cnt].pmdn203 = sr_s.pmdn203
       LET sr[l_cnt].pmdn205 = sr_s.pmdn205
       LET sr[l_cnt].pmdn206 = sr_s.pmdn206
       LET sr[l_cnt].pmdn207 = sr_s.pmdn207
       LET sr[l_cnt].pmdn208 = sr_s.pmdn208
       LET sr[l_cnt].pmdn209 = sr_s.pmdn209
       LET sr[l_cnt].pmdn210 = sr_s.pmdn210
       LET sr[l_cnt].pmdn211 = sr_s.pmdn211
       LET sr[l_cnt].pmdn212 = sr_s.pmdn212
       LET sr[l_cnt].pmdn213 = sr_s.pmdn213
       LET sr[l_cnt].pmdn214 = sr_s.pmdn214
       LET sr[l_cnt].pmdn215 = sr_s.pmdn215
       LET sr[l_cnt].pmdn216 = sr_s.pmdn216
       LET sr[l_cnt].pmdn217 = sr_s.pmdn217
       LET sr[l_cnt].pmdn218 = sr_s.pmdn218
       LET sr[l_cnt].pmdn219 = sr_s.pmdn219
       LET sr[l_cnt].pmdn220 = sr_s.pmdn220
       LET sr[l_cnt].pmdn221 = sr_s.pmdn221
       LET sr[l_cnt].pmdn222 = sr_s.pmdn222
       LET sr[l_cnt].pmdn223 = sr_s.pmdn223
       LET sr[l_cnt].pmdn224 = sr_s.pmdn224
       LET sr[l_cnt].pmdn225 = sr_s.pmdn225
       LET sr[l_cnt].pmdnorga = sr_s.pmdnorga
       LET sr[l_cnt].pmdnseq = sr_s.pmdnseq
       LET sr[l_cnt].pmdnsite = sr_s.pmdnsite
       LET sr[l_cnt].pmdnunit = sr_s.pmdnunit
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].t1_ooefl003 = sr_s.t1_ooefl003
       LET sr[l_cnt].t2_ooefl003 = sr_s.t2_ooefl003
       LET sr[l_cnt].t3_ooefl003 = sr_s.t3_ooefl003
       LET sr[l_cnt].t5_ooefl003 = sr_s.t5_ooefl003
       LET sr[l_cnt].t6_ooefl003 = sr_s.t6_ooefl003
       LET sr[l_cnt].t7_pmaal004 = sr_s.t7_pmaal004
       LET sr[l_cnt].t10_pmaal004 = sr_s.t10_pmaal004
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].t4_oocql004 = sr_s.t4_oocql004
       LET sr[l_cnt].t8_oocql004 = sr_s.t8_oocql004
       LET sr[l_cnt].t9_oocql004 = sr_s.t9_oocql004
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].oojdl_t_oojdl003 = sr_s.oojdl_t_oojdl003
       LET sr[l_cnt].oofa_t_oofa011 = sr_s.oofa_t_oofa011
       LET sr[l_cnt].l_pmdl022_pmaal004 = sr_s.l_pmdl022_pmaal004
       LET sr[l_cnt].l_pmdl204_ooefl003 = sr_s.l_pmdl204_ooefl003
       LET sr[l_cnt].l_pmdlsite_ooefl003 = sr_s.l_pmdlsite_ooefl003
       LET sr[l_cnt].l_pmdlunit_ooefl003 = sr_s.l_pmdlunit_ooefl003
       LET sr[l_cnt].l_pmdnsite_desc = sr_s.l_pmdnsite_desc
       LET sr[l_cnt].l_pmdl021_pmaal004 = sr_s.l_pmdl021_pmaal004
       LET sr[l_cnt].l_pmdl029_ooefl003 = sr_s.l_pmdl029_ooefl003
       LET sr[l_cnt].l_pmdnunit_ooefl003 = sr_s.l_pmdnunit_ooefl003
       LET sr[l_cnt].l_pmdn203_ooefl003 = sr_s.l_pmdn203_ooefl003
       LET sr[l_cnt].l_pmdn025_desc = sr_s.l_pmdn025_desc
       LET sr[l_cnt].l_pmdn025_addr = sr_s.l_pmdn025_addr
       LET sr[l_cnt].l_pmdl203_desc = sr_s.l_pmdl203_desc
       LET sr[l_cnt].l_pmdl023_oojdl003 = sr_s.l_pmdl023_oojdl003
       LET sr[l_cnt].l_pmdl200_ooefl003 = sr_s.l_pmdl200_ooefl003
       LET sr[l_cnt].l_sum047 = sr_s.l_sum047
       LET sr[l_cnt].l_sum007 = sr_s.l_sum007
       LET sr[l_cnt].l_pmdn047 = sr_s.l_pmdn047
       LET sr[l_cnt].l_pmdn007 = sr_s.l_pmdn007
       LET sr[l_cnt].l_pmdl027_oofa011 = sr_s.l_pmdl027_oofa011
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_pmdl004_pmaal004 = sr_s.l_pmdl004_pmaal004
       LET sr[l_cnt].l_pmdl002_ooag011 = sr_s.l_pmdl002_ooag011
       LET sr[l_cnt].l_pmdl003_ooefl003 = sr_s.l_pmdl003_ooefl003
       LET sr[l_cnt].l_pmdo010 = sr_s.l_pmdo010
       LET sr[l_cnt].l_pmdo010_desc = sr_s.l_pmdo010_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       LET sr_t[l_cnt].pmdnsite = sr_s.pmdnsite
       let l_pmdnsiteu=sr[l_cnt].pmdnsite
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    CALL sr_t.deleteElement(l_cnt)
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr840_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr840_g01_rep_data()
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
          START REPORT apmr840_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT apmr840_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT apmr840_g01_rep
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
 
{<section id="apmr840_g01.rep" readonly="Y" >}
PRIVATE REPORT apmr840_g01_rep(sr1)
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
DEFINE l_ooef017         LIKE ooef_t.ooef017   #法人
DEFINE l_g_site_t        LIKE ooef_t.ooef001   #儲存g_site值
DEFINE l_success         LIKE type_t.num5
DEFINE l_pmdl044_show    LIKE type_t.chr10
DEFINE sr3 sr3_r         #多期帳款
DEFINE sr4 sr4_r         #多交期 
define g_sqll   string 
DEFINE l_subrep05_show  LIKE type_t.chr1 
DEFINE l_i2             INTEGER
DEFINE l_oofb001  LIKE oofb_t.oofb001
define l_pmdnsite like pmdn_t.pmdnsite
DEFINE l_oofb012  LIKE oofb_t.oofb012
DEFINE  l_oofc012   LIKE oofc_t.oofc012
DEFINE  l_oofb011   LIKE oofb_t.oofb011
DEFINE  l_ooef001   LIKE ooef_t.ooef001
DEFINE  l_ooef012   LIKE ooef_t.ooef012
DEFINE l_pmdoseq1_o       LIKE type_t.num5
DEFINE l_item_show_o      LIKE type_t.chr1
DEFINE g_cnt              LIKE type_t.num5
DEFINE g_sql_cnt          STRING
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.pmdldocno,sr1.pmdnsite
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
            
            #取法人對內名稱
            CALL s_aooi100_get_comp(sr1.pmdlsite) RETURNING l_success,l_ooef017
            LET l_g_site_t = g_site #備份g_site預設值
            LET g_site = l_ooef017  #抓法人資料
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.pmdldocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
            
            LET g_site = l_g_site_t #恢復原g_site值            
            
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'pmdlent=' ,sr1.pmdlent,'{+}pmdldocno=' ,sr1.pmdldocno         
            CALL cl_gr_init_apr(sr1.pmdldocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.pmdldocno.before name="rep.b_group.pmdldocno.before"
           #顯示否判斷           
           #單頭備註是否顯示
           LET l_sum1 = 0
           LET l_sum2 = 0
           LET l_pmdl044_show = ''
           IF cl_null(sr1.pmdl044) THEN
              LET l_pmdl044_show = "N"
           ELSE
              LET l_pmdl044_show = "Y"
           END IF
           PRINTX l_pmdl044_show
           
#           LET g_sql = " SELECT pmdmdocno,pmdm001,pmdm002,'',pmdm003,pmdm004,pmdm005,pmdm006 ",
#                       "   FROM pmdm_t ",
#                       "  WHERE pmdment = ",sr1.pmdlent CLIPPED,
#                       "    AND pmdmdocno = '",sr1.pmdldocno CLIPPED,"'",
#                       "  ORDER BY pmdm001 "
#           START REPORT apmr840_g01_subrep05
#           DECLARE apmr840_g01_repcur05 CURSOR FROM g_sql
#           FOREACH apmr840_g01_repcur05 INTO sr3.*
#              IF STATUS THEN INITIALIZE g_errparam TO NULL
#              LET g_errparam.code = STATUS
#              LET g_errparam.extend = 'apmr840_g01_repcur05:'
#              LET g_errparam.popup = TRUE
#              CALL cl_err()
#              EXIT FOREACH END IF
#
#              #SELECT ooibl004 INTO sr3.l_pmdm002_desc FROM ooibl_t 
#              # WHERE ooiblent=g_enterprise 
#              #   AND ooibl002 = sr3.pmdm002
#              #   AND ooibl003 = g_dlang
#
#              OUTPUT TO REPORT apmr840_g01_subrep05(sr3.*)
#           END FOREACH
#           FINISH REPORT apmr840_g01_subrep05
          
           
           
           #PRINTX l_sum1
           #PRINTX l_sum2
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
           PREPARE apmr840_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE apmr840_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT apmr840_g01_subrep01
           DECLARE apmr840_g01_repcur01 CURSOR FROM g_sql
           FOREACH apmr840_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr840_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT apmr840_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT apmr840_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.pmdldocno.after name="rep.b_group.pmdldocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.pmdnsite
 
           #add-point:rep.b_group.pmdnsite.before name="rep.b_group.pmdnsite.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.pmdnsite.after name="rep.b_group.pmdnsite.after"
           
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
                sr1.pmdnsite CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr840_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE apmr840_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT apmr840_g01_subrep02
           DECLARE apmr840_g01_repcur02 CURSOR FROM g_sql
           FOREACH apmr840_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr840_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT apmr840_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT apmr840_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          IF cl_null(sr1.l_pmdn007) THEN
             LET sr1.l_pmdn007 = 0
          END IF 
          IF cl_null(sr1.l_pmdn047) THEN
             LET sr1.l_pmdn047 = 0
          END IF 
          LET l_sum1 = l_sum1 + sr1.l_pmdn007
          LET l_sum2 = l_sum2 + sr1.l_pmdn047

#         START REPORT apmr840_g01_subrep06
#         IF NOT cl_null(sr1.pmdnseq) AND sr1.pmdnseq > 0 THEN
#            LET g_sql = "SELECT pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdo001,pmdo002,pmdo003, ",
#                        "       pmdo004,pmdo006,pmdo013,pmdo010,'',NULL,NULL,NULL,'0' ",
#                        "  FROM pmdo_t ",
#                        " WHERE pmdoent = ",sr1.pmdlent CLIPPED,
#                        "   AND pmdodocno = '",sr1.pmdldocno CLIPPED,"' ",
#                        "   AND pmdoseq = ",sr1.pmdnseq CLIPPED,
#                        " ORDER BY pmdoseq1,pmdoseq2 "
#            LET g_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
#            PREPARE apmr840_g01_subrep06_cnt_pre FROM g_sql_cnt
#
#            LET g_cnt = 0
#            EXECUTE apmr840_g01_subrep06_cnt_pre INTO g_cnt
#            FREE apmr840_g01_subrep06_cnt_pre
#
#            IF g_cnt > 1 THEN
#
#               LET g_sql_cnt = g_sql_cnt CLIPPED," WHERE pmdo003 <> '1' "
#               PREPARE apmr840_g01_subrep06_cnt_pre01 FROM g_sql_cnt
#               LET g_cnt = 0
#               EXECUTE apmr840_g01_subrep06_cnt_pre01 INTO g_cnt
#               FREE apmr840_g01_subrep06_cnt_pre01
#
#               LET l_pmdoseq1_o = 0
#               DECLARE apmr840_g01_repcur06 CURSOR FROM g_sql
#               FOREACH apmr840_g01_repcur06 INTO sr4.*
#                  IF STATUS THEN INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = STATUS
#                  LET g_errparam.extend = 'apmr840_g01_repcur03:'
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  EXIT FOREACH END IF
#
#                  #顯示項序、料件編號
#                  IF g_cnt > 0 THEN
#                     LET sr4.l_item_show = '1'
#               
#                     SELECT imaal003,imaal004 INTO sr4.imaal003,sr4.imaal004
#                       FROM imaal_t
#                      WHERE imaalent = g_enterprise
#                        AND imaal001 = sr4.pmdo001
#                        AND imaal002 = g_dlang
#                     
#                     IF sr4.pmdoseq1 = l_pmdoseq1_o THEN
#                        LET sr4.l_pmdo003_desc = ''
#                        LET sr4.pmdoseq1= ''
#                        LET sr4.pmdo001 = ''
#                        #隱藏品名、規格、產品特徵
#                        LET sr4.l_item_show = '2'                        
#                     ELSE
#                        #隱藏產品特徵
#                        IF cl_null(sr4.pmdo002) THEN
#                           LET sr4.l_item_show = '3'
#                        END IF
#                     END IF
#                  END IF
#                  
#                  #子件特性
#                  #如果不要將內存值外顯再解開
#                   SELECT gzcb002||"."||gzcbl004 INTO sr4.l_pmdo003_desc
#                    FROM gzcb_t,gzcbl_t
#                   WHERE gzcb001 = gzcbl001 AND gzcb002 = gzcbl002
#                     AND gzcb001 = '2055'   AND gzcbl003 = g_dlang
#                     AND gzcb002 = sr4.pmdo003
#                  
#                  #收貨時段
#                  SELECT pmdo010 INTO sr4.pmdo010
#                    FROM pmdo_t
#                   WHERE pmdoent = g_enterprise
#                     AND pmdodocno = sr_s.pmdldocno 
#                     AND pmdoseq = sr4.pmdoseq
#                     AND pmdoseq1 = sr4.pmdoseq1
#                     AND pmdoseq2 = sr4.pmdoseq2
#                  IF cl_null(sr4.pmdo010) THEN
#                     LET sr4.l_pmdo010_desc = ' '
#                  ELSE
#                     CALL s_desc_get_acc_desc('274',sr4.pmdo010) RETURNING sr4.l_pmdo010_desc
#                  END IF
#                  
#                  OUTPUT TO REPORT apmr840_g01_subrep06(sr4.*)
#                  LET l_pmdoseq1_o = sr4.pmdoseq1
#                  LET l_item_show_o = sr4.l_item_show
#               END FOREACH
#            END IF
#         END IF
#         FINISH REPORT apmr840_g01_subrep06
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.pmdlent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdldocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.pmdnsite CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr840_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE apmr840_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT apmr840_g01_subrep03
           DECLARE apmr840_g01_repcur03 CURSOR FROM g_sql
           FOREACH apmr840_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr840_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT apmr840_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT apmr840_g01_subrep03
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
           PREPARE apmr840_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE apmr840_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT apmr840_g01_subrep04
           DECLARE apmr840_g01_repcur04 CURSOR FROM g_sql
           FOREACH apmr840_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr840_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr840_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT apmr840_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.pmdldocno.after name="rep.a_group.pmdldocno.after"
             #LET g_sqll = " SELECT DISTINCT pmdnsite ",
             #         "   FROM pmdn_t ",
             ##          "  WHERE pmdnent = ",sr1.pmdlent CLIPPED,
             #          "    AND pmdndocno = '",sr1.pmdldocno CLIPPED,"'",
             #          "  ORDER BY pmdnsite "
            #PREPARE apmr840_sel FROM g_sqll
            #DECLARE b_fill_curs CURSOR FOR apmr840_sel
            #FOREACH b_fill_curs INTO l_pmdnsite
#           FOR l_i2 = 1 TO sr_t.getLength()       #2016-7-6 zhujing marked
           #160420-00039#22 20160722 mark by beckxie---S
           #LET g_sql = " SELECT  pmdldocno,pmdl004,pmdnsite,pmdn217,   staal003, ",
           #            "         '',         pmdl008,pmdl029, pmdl002, rtaxl003,",
           #            "         '',         pmdn001,'',        pmdnseq,   pmdn200, ",
           #            "         imaal003,   imaal004, pmdn201, oocal003,    pmdn202, ",
           #            "         '',pmdn015,pmdn007, pmdn048,   pmdn047 ,",
#          #             "         pmaal004,ooefl003 ",   #2016-7-6 zhujing marked
           #            "         pmaal004,ooefl003,trim(pmdldocno)||'-'||trim(pmdnsite) ",    #2016-7-6 zhujing mod
           #            "   FROM pmdl_t ",
           #            "   LEFT JOIN rtaxl_t ON rtaxlent = pmdlent and rtaxl001 = pmdl002 and rtaxl002 = '",g_dlang,"' ", 
           #            "   LEFT JOIN pmaal_t ON pmaalent = pmdlent AND pmaal001 = pmdl004 AND pmaal002 = '",g_dlang,"' ",                       
           #            "   ,pmdn_t ",
           #            "   LEFT OUTER JOIN imaal_t ON pmdn001 = imaal001 AND imaalent = pmdnent AND imaal002 = '",g_dlang,"' ", 
           #            "   LEFT JOIN oocal_t ON oocalent = pmdnent AND oocal001 = pmdn201 AND  oocal002 ='",g_dlang,"' ",  
           #            "   LEFT JOIN staal_t ON staalent = pmdnent AND staal001 = pmdn217 AND staal002 = '",g_dlang,"' ", 
           #            "   LEFT JOIN ooefl_t ON ooeflent = pmdnent AND ooefl001 = pmdnsite AND ooefl002 = '",g_dlang,"' ",                       
           #            "  WHERE pmdlent ='",sr1.pmdlent,"' ",
           #            "    AND pmdldocno = '",sr1.pmdldocno CLIPPED,"'",
#          #             "    AND pmdnsite='",sr_t[l_i2].pmdnsite CLIPPED,"'",       #2016-7-6 zhujing marked
           #            "    AND pmdlent = pmdnent AND pmdldocno = pmdndocno ",
#          #             "  ORDER BY pmdldocno,TO_NUMBER(pmdn001) "                  #2016-7-6 zhujing marked
           #            "  ORDER BY pmdldocno,pmdn001 " 
           #160420-00039#22 20160722 mark by beckxie---E
           #160420-00039#22 20160722 add by beckxie---S
           LET g_sql = "SELECT pmdldocno,pmdl004,pmdnsite,pmdn217, ",
                       "       CASE WHEN COALESCE(trim(pmdn217),' ') != ' ' THEN trim(pmdn217)||'|'||trim(staal003) END, ",
                       "       (SELECT oofc012 FROM oofc_t ",
                       "               WHERE oofcent = ",g_enterprise,
                       "                 AND oofc002 = (SELECT ooef012  ",
                       "                                  FROM ooef_t  ",
                       "                                 WHERE ooef001 = pmdnsite  ",
                       "                                   AND ooefent = pmdnent) ",
                       "                 AND oofc008 = '1' ",
                       "                 AND oofc010 = 'Y' ",
                       "                AND oofcstus = 'Y') oofc012, ",
                       "       pmdl008,pmdl029, pmdl002, ",
                       "       CASE WHEN COALESCE(trim(pmdl002),' ') != ' ' THEN trim(pmdl002)||'|'||trim(rtaxl003) END, ",
                       "       (SELECT oofb011 ",
                       "          FROM oofb_t  ",
                       "         WHERE oofbent = ",g_enterprise,
                       "           AND oofb002 = (SELECT ooef012  ",
                       "                            FROM ooef_t  ",
                       "                           WHERE ooef001 = pmdnsite  ",
                       "                             AND ooefent = pmdnent) ",
                       "           AND oofb008 = '1' ",
                       "           AND oofb010 = 'Y' ",
                       "           AND oofbstus = 'Y') oofb017, ",
                       "       pmdn001,pmdn001 l_pmdn001, ",
                       "       pmdnseq,   pmdn200, imaal003, imaal004, pmdn201, oocal003,pmdn202,'', ",
                       "       pmdn015,pmdn007, pmdn048,   pmdn047 , ",
                       "       CASE WHEN COALESCE(trim(pmdl004),' ') != ' ' THEN trim(pmdl004)||'|'||trim(pmaal004) END, ",
                       "       CASE WHEN COALESCE(trim(pmdnsite),' ') != ' ' THEN trim(pmdnsite)||'|'||trim(ooefl003) END, ",
                       "       trim(pmdldocno)||'-'||trim(pmdnsite) ",
                       "   FROM pmdl_t ",
                       "        LEFT JOIN rtaxl_t ON rtaxlent = pmdlent AND rtaxl001 = pmdl002 AND rtaxl002 = '",g_dlang,"' ", 
                       "        LEFT JOIN pmaal_t ON pmaalent = pmdlent AND pmaal001 = pmdl004 AND pmaal002 = '",g_dlang,"' ",                       
                       "        ,pmdn_t ",
                       "        LEFT OUTER JOIN imaal_t ON pmdn001 = imaal001 AND imaalent = pmdnent AND imaal002 = '",g_dlang,"' ", 
                       "        LEFT JOIN oocal_t ON oocalent = pmdnent AND oocal001 = pmdn201 AND  oocal002 ='",g_dlang,"' ",  
                       "        LEFT JOIN staal_t ON staalent = pmdnent AND staal001 = pmdn217 AND staal002 = '",g_dlang,"' ", 
                       "        LEFT JOIN ooefl_t ON ooeflent = pmdnent AND ooefl001 = pmdnsite AND ooefl002 = '",g_dlang,"' ",                       
                       "  WHERE pmdlent =",sr1.pmdlent,
                       "    AND pmdldocno = '",sr1.pmdldocno CLIPPED,"'",
#                       "    AND pmdnsite='",sr_t[l_i2].pmdnsite CLIPPED,"'",       #2016-7-6 zhujing marked
                       "    AND pmdlent = pmdnent AND pmdldocno = pmdndocno ",
#                       "  ORDER BY pmdldocno,TO_NUMBER(pmdn001) "                  #2016-7-6 zhujing marked
                       "  ORDER BY pmdldocno,pmdn001 " 
           DISPLAY "g_sql:\n",g_sql
           #160420-00039#22 20160722 add by beckxie---E
           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr840_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE apmr840_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
             LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show                           
           START REPORT apmr840_g01_subrep05                 
              DECLARE citr003_g01_repcur05 CURSOR FROM g_sql
              FOREACH citr003_g01_repcur05 INTO sr3.*
              
                 LET sr3.pmdnud011 = sr3.pmdn007/sr3.pmdn202
                 #160420-00039#22 20160722 mark by beckxie---S
                 #LET sr3.l_pmdn001 = sr3.pmdn001  # 商品编号
                 #LET l_ooef001=sr3.pmdnsite  
                 #
                 #SELECT ooef012 INTO l_ooef012 
                 #  FROM ooef_t 
                 # WHERE ooef001=l_ooef001 
                 #   AND ooefent = sr1.pmdlent
                 #          
                 #SELECT oofb011 INTO l_oofb011 
                 #  FROM oofb_t 
                 # WHERE oofbent = g_enterprise
                 #   AND oofb002 = l_ooef012
                 #   AND oofb008 = '1'
                 #   AND oofb010 = 'Y'
                 #   AND oofbstus = 'Y'
                 #LET sr3.oofb017=l_oofb011   # 地址
                 #
                 #
                 #SELECT oofc012 INTO l_oofc012 FROM oofc_t 
                 # WHERE oofcent = g_enterprise 
                 #   AND oofc002 = l_ooef012
                 #   AND oofc008 = '1'
                 #   AND oofc010 = 'Y'
                 #   AND oofcstus = 'Y'
                 #LET sr3.oofc012 =l_oofc012  # 预约电话
                 #
                 #IF NOT cl_null(sr3.pmdn217) THEN #结算方式
                 #   LET sr3.staal003 = sr3.pmdn217,'|',sr3.staal003
                 #END IF 
                 #
                 #IF NOT cl_null(sr3.pmdl002) THEN #管理品类
                 #   LET sr3.pmdl002_desc = sr3.pmdl002,'|',sr3.pmdl002_desc
                 #END IF
                 #
                 #IF NOT cl_null(sr3.pmaal004) THEN
                 #   LET sr3.pmaal004 = sr3.pmdl004,'|',sr3.pmaal004   # 供应商
                 #END IF
                 #
                 #
                 #IF NOT cl_null(sr3.pmdnsite) THEN
                 #   LET sr3.ooefl003 = sr3.pmdnsite,'|',sr3.ooefl003   #订货门店名称
                 #END IF
                 #160420-00039#22 20160722 mark by beckxie---E
                 IF STATUS THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = "apmr840_g01_subrep05:"
                    LET g_errparam.code   = SQLCA.sqlcode
                    LET g_errparam.popup  = FALSE
                    CALL cl_err()                  
                    EXIT FOREACH 
                 END IF
                 
                 OUTPUT TO REPORT apmr840_g01_subrep05(sr3.*)

            END FOREACH  
           
             FINISH REPORT apmr840_g01_subrep05  
#           END FOR           #2016-7-6 zhujing marked
           
           PRINTX l_sum1
           PRINTX l_sum2
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmdnsite
 
           #add-point:rep.a_group.pmdnsite.before name="rep.a_group.pmdnsite.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.pmdnsite.after name="rep.a_group.pmdnsite.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="apmr840_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr840_g01_subrep01(sr2)
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
PRIVATE REPORT apmr840_g01_subrep02(sr2)
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
PRIVATE REPORT apmr840_g01_subrep03(sr2)
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
PRIVATE REPORT apmr840_g01_subrep04(sr2)
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
 
{<section id="apmr840_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 是否要顯示.說明
# Memo...........:
# Usage..........: CALL apmr840_g01_initialize(p_arg,p_exp)
#                  RETURNING r_exp
# Input parameter: p_arg    編號
#                : p_exp    說明
# Return code....: r_exp    顯示值
# Date & Author..: 2015/04/03 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr840_g01_initialize(p_arg,p_exp)
DEFINE p_arg   STRING
DEFINE p_exp   STRING
DEFINE r_exp   STRING

 INITIALIZE r_exp TO NULL
   IF cl_null(p_arg) OR p_exp = '.' THEN
      LET r_exp = p_arg
   ELSE
      LET r_exp = p_exp
   END IF
 RETURN r_exp
 
END FUNCTION

 
{</section>}
 
{<section id="apmr840_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 多帳期子報表
# Memo...........:
# Usage..........: CALL apmr840_g01_subrep05(sr3)
#                  
# Input parameter: sr3            資料RECORD
# Return code....: 
# Date & Author..: 2015/04/13 By sakura
# Modify.........:
################################################################################
PRIVATE REPORT apmr840_g01_subrep05(sr3)
DEFINE  sr3    sr3_r 
DEFINE  l_rep05_cnt1 LIKE type_t.num10
DEFINE  l_rep05_sum1 LIKE pmdn_t.pmdn007
DEFINE  l_rep05_sum2 LIKE pmdn_t.pmdn047
DEFINE  l_staal003_desc LIKE staal_t.staal003

#   ORDER EXTERNAL BY sr3.pmdldocno,sr3.pmdnsite    #2016-7-6 zhujing mod
   ORDER EXTERNAL BY sr3.l_order,sr3.pmdn200    #2016-7-6 zhujing mod
   FORMAT
#      BEFORE GROUP OF sr3.pmdnsite
      BEFORE GROUP OF sr3.l_order     #2016-7-6 zhujing mod

         LET l_rep05_cnt1 = 0           # 合计：记录数
         LET l_rep05_sum1 = 0           # 合计：订货数量
         LET l_rep05_sum2 = 0           # 合计：定价金额
            
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
            
            LET l_rep05_cnt1 = l_rep05_cnt1 + 1
            LET l_rep05_sum1 = l_rep05_sum1 + sr3.pmdn007
            LET l_rep05_sum2 = l_rep05_sum2 + sr3.pmdn047

#        AFTER GROUP OF sr3.pmdldocno   
        AFTER GROUP OF sr3.l_order      #2016-7-6 zhujing mod-S
           PRINTX l_rep05_cnt1
           PRINTX l_rep05_sum1
           PRINTX l_rep05_sum2          #2016-7-6 zhujing mod-E

#        AFTER GROUP OF sr3.pmdnsite    #2016-7-6 zhujing mod-S
        AFTER GROUP OF sr3.pmdn200
#           PRINTX l_rep05_cnt1
#           PRINTX l_rep05_sum1
#           PRINTX l_rep05_sum2         #2016-7-6 zhujing mod-E  
END REPORT

################################################################################
# Descriptions...: 多交期報表
# Memo...........:
# Usage..........: CALL apmr840_g01_subrep06(sr4)
# Input parameter: sr4            資料RECORD
# Return code....: 
# Date & Author..: 2015/04/13 By sakura
# Modify.........:
################################################################################
PRIVATE REPORT apmr840_g01_subrep06(sr4)
DEFINE sr4             sr4_r

   ORDER EXTERNAL BY sr4.pmdodocno,sr4.pmdoseq
      FORMAT

         ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
END REPORT

 
{</section>}
 
