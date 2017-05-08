#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr570_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:12(2016-12-22 15:13:36), PR版次:0012(2016-12-22 17:41:03)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000175
#+ Filename...: apmr570_g01
#+ Description: ...
#+ Creator....: 05016(2014-05-13 16:54:29)
#+ Modifier...: 01534 -SD/PR- 01534
 
{</section>}
 
{<section id="apmr570_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#161207-00033#26  2016/12/22  By lixh     一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
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
   l_condition LIKE type_t.chr1000, 
   pmds000 LIKE pmds_t.pmds000, 
   pmds001 LIKE pmds_t.pmds001, 
   pmds002 LIKE pmds_t.pmds002, 
   pmds003 LIKE pmds_t.pmds003, 
   pmds006 LIKE pmds_t.pmds006, 
   pmds007 LIKE pmds_t.pmds007, 
   pmds008 LIKE pmds_t.pmds008, 
   pmds009 LIKE pmds_t.pmds009, 
   pmds010 LIKE pmds_t.pmds010, 
   pmds011 LIKE pmds_t.pmds011, 
   pmds021 LIKE pmds_t.pmds021, 
   pmds022 LIKE pmds_t.pmds022, 
   pmds023 LIKE pmds_t.pmds023, 
   pmds024 LIKE pmds_t.pmds024, 
   pmds031 LIKE pmds_t.pmds031, 
   pmds032 LIKE pmds_t.pmds032, 
   pmds033 LIKE pmds_t.pmds033, 
   pmds034 LIKE pmds_t.pmds034, 
   pmds035 LIKE pmds_t.pmds035, 
   pmds036 LIKE pmds_t.pmds036, 
   pmds037 LIKE pmds_t.pmds037, 
   pmds038 LIKE pmds_t.pmds038, 
   pmds039 LIKE pmds_t.pmds039, 
   pmds040 LIKE pmds_t.pmds040, 
   pmds041 LIKE pmds_t.pmds041, 
   pmds042 LIKE pmds_t.pmds042, 
   pmds043 LIKE pmds_t.pmds043, 
   pmds044 LIKE pmds_t.pmds044, 
   pmds045 LIKE pmds_t.pmds045, 
   pmds046 LIKE pmds_t.pmds046, 
   pmds047 LIKE pmds_t.pmds047, 
   pmds048 LIKE pmds_t.pmds048, 
   pmds049 LIKE pmds_t.pmds049, 
   pmds081 LIKE pmds_t.pmds081, 
   pmds100 LIKE pmds_t.pmds100, 
   pmdsdocdt LIKE pmds_t.pmdsdocdt, 
   pmdsdocno LIKE pmds_t.pmdsdocno, 
   pmdsent LIKE pmds_t.pmdsent, 
   pmdssite LIKE pmds_t.pmdssite, 
   pmdsstus LIKE pmds_t.pmdsstus, 
   pmdt001 LIKE pmdt_t.pmdt001, 
   pmdt002 LIKE pmdt_t.pmdt002, 
   pmdt003 LIKE pmdt_t.pmdt003, 
   pmdt004 LIKE pmdt_t.pmdt004, 
   pmdt005 LIKE pmdt_t.pmdt005, 
   pmdt006 LIKE pmdt_t.pmdt006, 
   pmdt007 LIKE pmdt_t.pmdt007, 
   pmdt008 LIKE pmdt_t.pmdt008, 
   pmdt009 LIKE pmdt_t.pmdt009, 
   pmdt010 LIKE pmdt_t.pmdt010, 
   pmdt011 LIKE pmdt_t.pmdt011, 
   pmdt016 LIKE pmdt_t.pmdt016, 
   pmdt017 LIKE pmdt_t.pmdt017, 
   pmdt018 LIKE pmdt_t.pmdt018, 
   pmdt019 LIKE pmdt_t.pmdt019, 
   pmdt020 LIKE pmdt_t.pmdt020, 
   pmdt021 LIKE pmdt_t.pmdt021, 
   pmdt022 LIKE pmdt_t.pmdt022, 
   pmdt023 LIKE pmdt_t.pmdt023, 
   pmdt024 LIKE pmdt_t.pmdt024, 
   pmdt025 LIKE pmdt_t.pmdt025, 
   pmdt026 LIKE pmdt_t.pmdt026, 
   pmdt036 LIKE pmdt_t.pmdt036, 
   pmdt037 LIKE pmdt_t.pmdt037, 
   pmdt038 LIKE pmdt_t.pmdt038, 
   pmdt039 LIKE pmdt_t.pmdt039, 
   pmdt040 LIKE pmdt_t.pmdt040, 
   pmdt041 LIKE pmdt_t.pmdt041, 
   pmdt046 LIKE pmdt_t.pmdt046, 
   pmdt047 LIKE pmdt_t.pmdt047, 
   pmdt051 LIKE pmdt_t.pmdt051, 
   pmdt052 LIKE pmdt_t.pmdt052, 
   pmdt053 LIKE pmdt_t.pmdt053, 
   pmdt054 LIKE pmdt_t.pmdt054, 
   pmdt055 LIKE pmdt_t.pmdt055, 
   pmdt059 LIKE pmdt_t.pmdt059, 
   pmdt060 LIKE pmdt_t.pmdt060, 
   pmdt061 LIKE pmdt_t.pmdt061, 
   pmdt062 LIKE pmdt_t.pmdt062, 
   pmdt081 LIKE pmdt_t.pmdt081, 
   pmdt082 LIKE pmdt_t.pmdt082, 
   pmdt083 LIKE pmdt_t.pmdt083, 
   pmdtseq LIKE pmdt_t.pmdtseq, 
   pmdtsite LIKE pmdt_t.pmdtsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t1_pmaal004 LIKE pmaal_t.pmaal004, 
   t2_pmaal004 LIKE pmaal_t.pmaal004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t3_oocql004 LIKE oocql_t.oocql004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   pmaml_t_pmaml003 LIKE pmaml_t.pmaml003, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t7_imaal003 LIKE imaal_t.imaal003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t5_oocal003 LIKE oocal_t.oocal003, 
   x_t6_oocal003 LIKE oocal_t.oocal003, 
   x_qcaol_t_qcaol004 LIKE qcaol_t.qcaol004, 
   l_pmds003_ooefl003 LIKE type_t.chr1000, 
   l_pmds007_pmaal004 LIKE type_t.chr100, 
   l_pmds008_pmaal004 LIKE type_t.chr100, 
   l_pmds009_pmaal004 LIKE type_t.chr100, 
   l_pmds002_ooag011 LIKE type_t.chr300, 
   l_pmdt016_inayl003 LIKE type_t.chr1000, 
   l_pmdt017_inab003 LIKE type_t.chr1000, 
   pmdt063 LIKE pmdt_t.pmdt063, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   x_t7_imaal004 LIKE imaal_t.imaal004, 
   l_pmdt083_desc LIKE qcaol_t.qcaol004
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr1,         #多庫儲批收貨 
       a2 LIKE type_t.chr1          #製造批序號
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
TYPE sr3_r RECORD    #子報表01多庫儲批收貨資料
   pmdudocno  LIKE pmdu_t.pmdudocno,
   pmduseq    LIKE pmdu_t.pmduseq,       #項次
   pmduseq1   LIKE pmdu_t.pmduseq1,      #項序
   pmdu005    LIKE pmdu_t.pmdu005,       #倉庫管理特徵
   pmdu006    LIKE pmdu_t.pmdu006,       #庫位
   pmdu007    LIKE pmdu_t.pmdu007,       #儲位
   pmdu008    LIKE pmdu_t.pmdu008,       #批號      
   pmdu010    LIKE pmdu_t.pmdu010,       #數量
   pmdu009    LIKE pmdu_t.pmdu009        #單位
END RECORD

TYPE sr4_r RECORD
   inao008_1 LIKE inao_t.inao008,            #製造批號
   inao009_1 LIKE inao_t.inao009,            #製造序號
   inao008_2 LIKE inao_t.inao008,            #製造批號
   inao009_2 LIKE inao_t.inao009,            #製造序號
   inao008_3 LIKE inao_t.inao008,            #製造批號
   inao009_3 LIKE inao_t.inao009,            #製造序號 
   l_inao008_1_inao009_1 LIKE type_t.chr100, #批號/序號 1
   l_inao008_2_inao009_2 LIKE type_t.chr100, #批號/序號 2 
   l_inao008_3_inao009_3 LIKE type_t.chr100  #批號/序號 3   
   
END RECORD

TYPE sr5_r RECORD
   inao008 LIKE inao_t.inao008,          #製造批號
   inao009 LIKE inao_t.inao009           #製造序號
   END RECORD
   
TYPE sr6_r RECORD
   inao008_1 LIKE inao_t.inao008,            #製造批號
   inao012_1 LIKE inao_t.inao012,            #數量
   inao008_2 LIKE inao_t.inao008,            #製造批號
   inao012_2 LIKE inao_t.inao012,            #數量
   inao008_3 LIKE inao_t.inao008,            #製造批號
   inao012_3 LIKE inao_t.inao012,            #數量 
   l_inao008_1_inao012_1 LIKE type_t.chr100, #批號/數量 1
   l_inao008_2_inao012_2 LIKE type_t.chr100, #批號/數量 2 
   l_inao008_3_inao012_3 LIKE type_t.chr100  #批號/數量 3       
   
END RECORD 

TYPE sr7_r RECORD
   inao008 LIKE inao_t.inao008,          #製造批號
   inao012 LIKE inao_t.inao012           #數量
END RECORD
   

DEFINE sr5 DYNAMIC ARRAY OF sr5_r
DEFINE sr7 DYNAMIC ARRAY OF sr7_r
#add by liuxsa 16/7/19
TYPE sr8_r RECORD
   pmdsdocno  LIKE pmds_t.pmdsdocno,          #單號 
   item       LIKE imaa_t.imaa001,            #料件编号
   imaal003   LIKE imaal_t.imaal003,          #品名
   inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
   inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
   inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)
   pmdt019    LIKE pmdt_t.pmdt019,            #單位
   pmdt0201   LIKE pmdt_t.pmdt020,            #數量1
   pmdt0202   LIKE pmdt_t.pmdt020,            #數量2
   pmdt0203   LIKE pmdt_t.pmdt020,            #數量3
   pmdt0204   LIKE pmdt_t.pmdt020,            #數量4
   pmdt0205   LIKE pmdt_t.pmdt020,            #數量5
   pmdt0206   LIKE pmdt_t.pmdt020,            #數量6
   pmdt0207   LIKE pmdt_t.pmdt020,            #數量7
   pmdt0208   LIKE pmdt_t.pmdt020,            #數量8
   pmdt0209   LIKE pmdt_t.pmdt020,            #數量9
   pmdt0200   LIKE pmdt_t.pmdt020             #數量10
   ,l_skip    LIKE type_t.chr1,
   condition  LIKE type_t.chr1000,
   pmdt036    LIKE pmdt_t.pmdt036             #单价   
 END RECORD
DEFINE g_inam014        ARRAY[10] OF VARCHAR(1000)
DEFINE l_total LIKE type_t.num10
TYPE r_sum   RECORD 
                 sum01  LIKE pmdt_t.pmdt020,
                 sum02  LIKE pmdt_t.pmdt020,
                 sum03  LIKE pmdt_t.pmdt020,
                 sum04  LIKE pmdt_t.pmdt020,
                 sum05  LIKE pmdt_t.pmdt020,
                 sum06  LIKE pmdt_t.pmdt020,
                 sum07  LIKE pmdt_t.pmdt020,
                 sum08  LIKE pmdt_t.pmdt020,
                 sum09  LIKE pmdt_t.pmdt020,
                 sum10  LIKE pmdt_t.pmdt020,
                 sum11  LIKE pmdt_t.pmdt020
             END RECORD
#end add-point
 
{</section>}
 
{<section id="apmr570_g01.main" readonly="Y" >}
PUBLIC FUNCTION apmr570_g01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  多庫儲批收貨 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.a2  製造批序號
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "apmr570_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL apmr570_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL apmr570_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL apmr570_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr570_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr570_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT NULL,pmds000,pmds001,pmds002,pmds003,pmds006,pmds007,pmds008,pmds009,pmds010,pmds011, 
       pmds021,pmds022,pmds023,pmds024,pmds031,pmds032,pmds033,pmds034,pmds035,pmds036,pmds037,pmds038, 
       pmds039,pmds040,pmds041,pmds042,pmds043,pmds044,pmds045,pmds046,pmds047,pmds048,pmds049,pmds081, 
       pmds100,pmdsdocdt,pmdsdocno,pmdsent,pmdssite,pmdsstus,pmdt001,pmdt002,pmdt003,pmdt004,pmdt005, 
       pmdt006,pmdt007,pmdt008,pmdt009,pmdt010,pmdt011,pmdt016,pmdt017,pmdt018,pmdt019,pmdt020,pmdt021, 
       pmdt022,pmdt023,pmdt024,pmdt025,pmdt026,pmdt036,pmdt037,pmdt038,pmdt039,pmdt040,pmdt041,pmdt046, 
       pmdt047,pmdt051,pmdt052,pmdt053,pmdt054,pmdt055,pmdt059,pmdt060,pmdt061,pmdt062,pmdt081,pmdt082, 
       pmdt083,pmdtseq,pmdtsite,ooag_t.ooag011,ooefl_t.ooefl003,pmaal_t.pmaal004,t1.pmaal004,t2.pmaal004, 
       ooibl_t.ooibl004,oocql_t.oocql004,x.t3_oocql004,ooail_t.ooail003,pmaml_t.pmaml003,ooidl_t.ooidl003, 
       x.imaal_t_imaal003,x.t7_imaal003,x.inab_t_inab003,x.oocal_t_oocal003,x.t5_oocal003,x.t6_oocal003, 
       x.qcaol_t_qcaol004,trim(pmds003)||'.'||trim(ooefl_t.ooefl003),trim(pmds007)||'.'||trim(t2.pmaal004), 
       trim(pmds008)||'.'||trim(t1.pmaal004),trim(pmds009)||'.'||trim(pmaal_t.pmaal004),trim(pmds002)||'.'||trim(ooag_t.ooag011), 
       trim(x.inayl_t_inayl003),trim(pmdt017)||'.'||trim(x.inab_t_inab003),pmdt063,x.imaal_t_imaal004,x.t7_imaal004,''"
       
#   #end add-point
#   LET g_select = " SELECT NULL,pmds000,pmds001,pmds002,pmds003,pmds006,pmds007,pmds008,pmds009,pmds010, 
#       pmds011,pmds021,pmds022,pmds023,pmds024,pmds031,pmds032,pmds033,pmds034,pmds035,pmds036,pmds037, 
#       pmds038,pmds039,pmds040,pmds041,pmds042,pmds043,pmds044,pmds045,pmds046,pmds047,pmds048,pmds049, 
#       pmds081,pmds100,pmdsdocdt,pmdsdocno,pmdsent,pmdssite,pmdsstus,pmdt001,pmdt002,pmdt003,pmdt004, 
#       pmdt005,pmdt006,pmdt007,pmdt008,pmdt009,pmdt010,pmdt011,pmdt016,pmdt017,pmdt018,pmdt019,pmdt020, 
#       pmdt021,pmdt022,pmdt023,pmdt024,pmdt025,pmdt026,pmdt036,pmdt037,pmdt038,pmdt039,pmdt040,pmdt041, 
#       pmdt046,pmdt047,pmdt051,pmdt052,pmdt053,pmdt054,pmdt055,pmdt059,pmdt060,pmdt061,pmdt062,pmdt081, 
#       pmdt082,pmdt083,pmdtseq,pmdtsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmds_t.pmds002 AND ooag_t.ooagent = pmds_t.pmdsent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmds_t.pmds003 AND ooefl_t.ooeflent = pmds_t.pmdsent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmds_t.pmds009 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmds_t.pmds008 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmds_t.pmds007 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = pmds_t.pmds031 AND ooibl_t.ooiblent = pmds_t.pmdsent AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmds_t.pmds032 AND oocql_t.oocqlent = pmds_t.pmdsent AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),x.t3_oocql004,( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = pmds_t.pmds037 AND ooail_t.ooailent = pmds_t.pmdsent AND ooail_t.ooail002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaml003 FROM pmaml_t WHERE pmaml_t.pmaml001 = pmds_t.pmds039 AND pmaml_t.pmamlent = pmds_t.pmdsent AND pmaml_t.pmaml002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooidl003 FROM ooidl_t WHERE ooidl_t.ooidl001 = pmds_t.pmds040 AND ooidl_t.ooidlent = pmds_t.pmdsent AND ooidl_t.ooidl002 = '" , 
#       g_dlang,"'" ,"),x.imaal_t_imaal003,x.t7_imaal003,x.inab_t_inab003,x.oocal_t_oocal003,x.t5_oocal003, 
#       x.t6_oocal003,x.qcaol_t_qcaol004,trim(pmds003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmds_t.pmds003 AND ooefl_t.ooeflent = pmds_t.pmdsent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmds007)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmds_t.pmds007 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmds008)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmds_t.pmds008 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmds009)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmds_t.pmds009 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmds002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmds_t.pmds002 AND ooag_t.ooagent = pmds_t.pmdsent)), 
#       '',trim(pmdt017)||'.'||trim(x.inab_t_inab003),pmdt063,x.imaal_t_imaal004,x.t7_imaal004,''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
#    LET g_from = " FROM pmds_t LEFT OUTER JOIN ooidl_t ON ooidl_t.ooidl001 = pmds_t.pmds040 AND ooidl_t.ooidlent = pmds_t.pmdsent AND ooidl_t.ooidl002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN pmaml_t ON pmaml_t.pmaml001 = pmds_t.pmds039 AND pmaml_t.pmamlent = pmds_t.pmdsent AND pmaml_t.pmaml002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = pmds_t.pmds037 AND ooail_t.ooailent = pmds_t.pmdsent AND ooail_t.ooail002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmds_t.pmds032 AND oocql_t.oocqlent = pmds_t.pmdsent AND oocql_t.oocql003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN oofa_t ON oofa_t.oofa002 = '2' AND oofa_t.oofa003 = pmds_t.pmds002 AND oofa_t.oofaent = pmds_t.pmdsent             LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = pmds_t.pmds009 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t1 ON t1.pmaal001 = pmds_t.pmds008 AND t1.pmaalent = pmds_t.pmdsent AND t1.pmaal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t2 ON t2.pmaal001 = pmds_t.pmds007 AND t2.pmaalent = pmds_t.pmdsent AND t2.pmaal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = pmds_t.pmds003 AND ooefl_t.ooeflent = pmds_t.pmdsent AND ooefl_t.ooefl002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = pmds_t.pmds031 AND ooibl_t.ooiblent = pmds_t.pmdsent AND ooibl_t.ooibl003 = '" , 
#        g_dlang,"'" ," LEFT OUTER JOIN ( SELECT pmdt_t.*,t3.oocql004 t3_oocql004,imaal_t.imaal003 imaal_t_imaal003, 
#        t7.imaal003 t7_imaal003,inaa_t.inaa002 inaa_t_inaa002,inab_t.inab003 inab_t_inab003,oocal_t.oocal003 oocal_t_oocal003, 
#        t5.oocal003 t5_oocal003,t6.oocal003 t6_oocal003,qcaol_t.qcaol004 qcaol_t_qcaol004,imaal_t.imaal004 imaal_t_imaal004, 
#        t7.imaal004 t7_imaal004 FROM pmdt_t             LEFT OUTER JOIN qcaol_t ON qcaol_t.qcaol002 = pmdt_t.pmdt083 AND qcaol_t.qcaolent = pmdt_t.pmdtent AND qcaol_t.qcaol003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t3 ON t3.oocql001 = '269' AND t3.oocql002 = pmdt_t.pmdt051 AND t3.oocqlent = pmdt_t.pmdtent AND t3.oocql003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = pmdt_t.pmdt023 AND oocal_t.oocalent = pmdt_t.pmdtent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t5 ON t5.oocal001 = pmdt_t.pmdt021 AND t5.oocalent = pmdt_t.pmdtent AND t5.oocal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t6 ON t6.oocal001 = pmdt_t.pmdt019 AND t6.oocalent = pmdt_t.pmdtent AND t6.oocal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN inab_t ON inab_t.inab001 = pmdt_t.pmdt016 AND inab_t.inab002 = pmdt_t.pmdt017 AND inab_t.inabent = pmdt_t.pmdtent             LEFT OUTER JOIN inaa_t ON inaa_t.inaa001 = pmdt_t.pmdt016 AND inaa_t.inaaent = pmdt_t.pmdtent   AND inaa_t.inaasite = pmdt_t.pmdtsite          LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = pmdt_t.pmdt008 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t t7 ON t7.imaal001 = pmdt_t.pmdt006 AND t7.imaalent = pmdt_t.pmdtent AND t7.imaal002 = '" , 
#        g_dlang,"'" ," ) x  ON pmds_t.pmdsent = x.pmdtent AND pmds_t.pmdsdocno = x.pmdtdocno"

 LET g_from = " FROM pmds_t ",
              " LEFT OUTER JOIN ooidl_t ON ooidl_t.ooidl001 = pmds_t.pmds040 AND ooidl_t.ooidlent = pmds_t.pmdsent AND ooidl_t.ooidl002 = '",g_dlang,"'",
              " LEFT OUTER JOIN pmaml_t ON pmaml_t.pmaml001 = pmds_t.pmds039 AND pmaml_t.pmamlent = pmds_t.pmdsent AND pmaml_t.pmaml002 = '",g_dlang,"'",
              " LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = pmds_t.pmds037 AND ooail_t.ooailent = pmds_t.pmdsent AND ooail_t.ooail002 = '",g_dlang,"'",
              " LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmds_t.pmds032 AND oocql_t.oocqlent = pmds_t.pmdsent AND oocql_t.oocql003 = '",g_dlang,"'",
              " LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = pmds_t.pmds002 AND ooag_t.ooagent = pmds_t.pmdsent",
              " LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = pmds_t.pmds009 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '",g_dlang,"'" ,
              " LEFT OUTER JOIN pmaal_t t1 ON t1.pmaal001 = pmds_t.pmds008 AND t1.pmaalent = pmds_t.pmdsent AND t1.pmaal002 = '",g_dlang,"'",
              " LEFT OUTER JOIN pmaal_t t2 ON t2.pmaal001 = pmds_t.pmds007 AND t2.pmaalent = pmds_t.pmdsent AND t2.pmaal002 = '",g_dlang,"'", 
              " LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = pmds_t.pmds003 AND ooefl_t.ooeflent = pmds_t.pmdsent AND ooefl_t.ooefl002 = '",g_dlang,"'",
              " LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = pmds_t.pmds031 AND ooibl_t.ooiblent = pmds_t.pmdsent AND ooibl_t.ooibl003 = '",g_dlang,"'",
              " LEFT OUTER JOIN ",
              " ( SELECT pmdt_t.*,t3.oocql004 t3_oocql004,imaal_t.imaal003 imaal_t_imaal003,", 
              "          t7.imaal003 t7_imaal003,inayl_t.inayl003 inayl_t_inayl003,",
              "          inab_t.inab003 inab_t_inab003,oocal_t.oocal003 oocal_t_oocal003,",
              "          t5.oocal003 t5_oocal003,t6.oocal003 t6_oocal003,",
              "          qcaol_t.qcaol004 qcaol_t_qcaol004,imaal_t.imaal004 imaal_t_imaal004,",
              "          t7.imaal004 t7_imaal004",
              "     FROM pmdt_t",
              "     LEFT OUTER JOIN qcaol_t ON qcaol_t.qcaol002 = pmdt_t.pmdt083 AND qcaol_t.qcaolent = pmdt_t.pmdtent AND qcaol_t.qcaol003 = '",g_dlang,"'", 
              "     LEFT OUTER JOIN oocql_t t3 ON t3.oocql001 = '269' AND t3.oocql002 = pmdt_t.pmdt051 AND t3.oocqlent = pmdt_t.pmdtent AND t3.oocql003 = '",g_dlang,"'",
              "     LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = pmdt_t.pmdt023 AND oocal_t.oocalent = pmdt_t.pmdtent AND oocal_t.oocal002 = '",g_dlang,"'",
              "     LEFT OUTER JOIN oocal_t t5 ON t5.oocal001 = pmdt_t.pmdt021 AND t5.oocalent = pmdt_t.pmdtent AND t5.oocal002 = '",g_dlang,"'",
              "     LEFT OUTER JOIN oocal_t t6 ON t6.oocal001 = pmdt_t.pmdt019 AND t6.oocalent = pmdt_t.pmdtent AND t6.oocal002 = '",g_dlang,"'",
              "     LEFT OUTER JOIN inab_t ON inab_t.inab001 = pmdt_t.pmdt016 AND inab_t.inab002 = pmdt_t.pmdt017 AND inab_t.inabent = pmdt_t.pmdtent AND inab_t.inabsite = pmdt_t.pmdtsite",
              "     LEFT OUTER JOIN inayl_t ON inayl_t.inayl001 = pmdt_t.pmdt016 AND inayl_t.inaylent = pmdt_t.pmdtent AND inayl_t.inayl002 = '",g_dlang,"'",
              "     LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = pmdt_t.pmdt008 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '",g_dlang,"'",
              "     LEFT OUTER JOIN imaal_t t7 ON t7.imaal001 = pmdt_t.pmdt006 AND t7.imaalent = pmdt_t.pmdtent AND t7.imaal002 = '",g_dlang,"' ) x",
              " ON pmds_t.pmdsent = x.pmdtent AND pmds_t.pmdsdocno = x.pmdtdocno"

#   #end add-point
#    LET g_from = " FROM pmds_t LEFT OUTER JOIN ( SELECT pmdt_t.*,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '269' AND oocql_t.oocql002 = pmdt_t.pmdt051 AND oocql_t.oocqlent = pmdt_t.pmdtent AND oocql_t.oocql003 = '" , 
#        g_dlang,"'" ,") t3_oocql004,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdt_t.pmdt008 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdt_t.pmdt006 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") t7_imaal003,( SELECT inab003 FROM inab_t WHERE inab_t.inab001 = pmdt_t.pmdt016 AND inab_t.inab002 = pmdt_t.pmdt017 AND inab_t.inabsite = pmdt_t.pmdtsite AND inab_t.inabent = pmdt_t.pmdtent) inab_t_inab003, 
#        ( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdt_t.pmdt023 AND oocal_t.oocalent = pmdt_t.pmdtent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdt_t.pmdt021 AND oocal_t.oocalent = pmdt_t.pmdtent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") t5_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdt_t.pmdt019 AND oocal_t.oocalent = pmdt_t.pmdtent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") t6_oocal003,( SELECT qcaol004 FROM qcaol_t WHERE qcaol_t.qcaol002 = pmdt_t.pmdt083 AND qcaol_t.qcaolent = pmdt_t.pmdtent AND qcaol_t.qcaol003 = '" , 
#        g_dlang,"'" ,") qcaol_t_qcaol004,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmdt_t.pmdt008 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal004,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmdt_t.pmdt006 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") t7_imaal004 FROM pmdt_t ) x  ON pmds_t.pmdsent = x.pmdtent AND pmds_t.pmdsdocno  
#        = x.pmdtdocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
#    LET g_where = " WHERE pmds_t.pmds000 IN ('3','4','6') AND " ,tm.wc CLIPPED  #150602 by whitney add
   #end add-point
    LET g_where = " WHERE pmds_t.pmds000 IN ('3','4','6','12') AND " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY pmdsdocno,pmdt006,pmdtseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmds_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr570_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE apmr570_g01_curs CURSOR FOR apmr570_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr570_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr570_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_condition LIKE type_t.chr1000, 
   pmds000 LIKE pmds_t.pmds000, 
   pmds001 LIKE pmds_t.pmds001, 
   pmds002 LIKE pmds_t.pmds002, 
   pmds003 LIKE pmds_t.pmds003, 
   pmds006 LIKE pmds_t.pmds006, 
   pmds007 LIKE pmds_t.pmds007, 
   pmds008 LIKE pmds_t.pmds008, 
   pmds009 LIKE pmds_t.pmds009, 
   pmds010 LIKE pmds_t.pmds010, 
   pmds011 LIKE pmds_t.pmds011, 
   pmds021 LIKE pmds_t.pmds021, 
   pmds022 LIKE pmds_t.pmds022, 
   pmds023 LIKE pmds_t.pmds023, 
   pmds024 LIKE pmds_t.pmds024, 
   pmds031 LIKE pmds_t.pmds031, 
   pmds032 LIKE pmds_t.pmds032, 
   pmds033 LIKE pmds_t.pmds033, 
   pmds034 LIKE pmds_t.pmds034, 
   pmds035 LIKE pmds_t.pmds035, 
   pmds036 LIKE pmds_t.pmds036, 
   pmds037 LIKE pmds_t.pmds037, 
   pmds038 LIKE pmds_t.pmds038, 
   pmds039 LIKE pmds_t.pmds039, 
   pmds040 LIKE pmds_t.pmds040, 
   pmds041 LIKE pmds_t.pmds041, 
   pmds042 LIKE pmds_t.pmds042, 
   pmds043 LIKE pmds_t.pmds043, 
   pmds044 LIKE pmds_t.pmds044, 
   pmds045 LIKE pmds_t.pmds045, 
   pmds046 LIKE pmds_t.pmds046, 
   pmds047 LIKE pmds_t.pmds047, 
   pmds048 LIKE pmds_t.pmds048, 
   pmds049 LIKE pmds_t.pmds049, 
   pmds081 LIKE pmds_t.pmds081, 
   pmds100 LIKE pmds_t.pmds100, 
   pmdsdocdt LIKE pmds_t.pmdsdocdt, 
   pmdsdocno LIKE pmds_t.pmdsdocno, 
   pmdsent LIKE pmds_t.pmdsent, 
   pmdssite LIKE pmds_t.pmdssite, 
   pmdsstus LIKE pmds_t.pmdsstus, 
   pmdt001 LIKE pmdt_t.pmdt001, 
   pmdt002 LIKE pmdt_t.pmdt002, 
   pmdt003 LIKE pmdt_t.pmdt003, 
   pmdt004 LIKE pmdt_t.pmdt004, 
   pmdt005 LIKE pmdt_t.pmdt005, 
   pmdt006 LIKE pmdt_t.pmdt006, 
   pmdt007 LIKE pmdt_t.pmdt007, 
   pmdt008 LIKE pmdt_t.pmdt008, 
   pmdt009 LIKE pmdt_t.pmdt009, 
   pmdt010 LIKE pmdt_t.pmdt010, 
   pmdt011 LIKE pmdt_t.pmdt011, 
   pmdt016 LIKE pmdt_t.pmdt016, 
   pmdt017 LIKE pmdt_t.pmdt017, 
   pmdt018 LIKE pmdt_t.pmdt018, 
   pmdt019 LIKE pmdt_t.pmdt019, 
   pmdt020 LIKE pmdt_t.pmdt020, 
   pmdt021 LIKE pmdt_t.pmdt021, 
   pmdt022 LIKE pmdt_t.pmdt022, 
   pmdt023 LIKE pmdt_t.pmdt023, 
   pmdt024 LIKE pmdt_t.pmdt024, 
   pmdt025 LIKE pmdt_t.pmdt025, 
   pmdt026 LIKE pmdt_t.pmdt026, 
   pmdt036 LIKE pmdt_t.pmdt036, 
   pmdt037 LIKE pmdt_t.pmdt037, 
   pmdt038 LIKE pmdt_t.pmdt038, 
   pmdt039 LIKE pmdt_t.pmdt039, 
   pmdt040 LIKE pmdt_t.pmdt040, 
   pmdt041 LIKE pmdt_t.pmdt041, 
   pmdt046 LIKE pmdt_t.pmdt046, 
   pmdt047 LIKE pmdt_t.pmdt047, 
   pmdt051 LIKE pmdt_t.pmdt051, 
   pmdt052 LIKE pmdt_t.pmdt052, 
   pmdt053 LIKE pmdt_t.pmdt053, 
   pmdt054 LIKE pmdt_t.pmdt054, 
   pmdt055 LIKE pmdt_t.pmdt055, 
   pmdt059 LIKE pmdt_t.pmdt059, 
   pmdt060 LIKE pmdt_t.pmdt060, 
   pmdt061 LIKE pmdt_t.pmdt061, 
   pmdt062 LIKE pmdt_t.pmdt062, 
   pmdt081 LIKE pmdt_t.pmdt081, 
   pmdt082 LIKE pmdt_t.pmdt082, 
   pmdt083 LIKE pmdt_t.pmdt083, 
   pmdtseq LIKE pmdt_t.pmdtseq, 
   pmdtsite LIKE pmdt_t.pmdtsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t1_pmaal004 LIKE pmaal_t.pmaal004, 
   t2_pmaal004 LIKE pmaal_t.pmaal004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t3_oocql004 LIKE oocql_t.oocql004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   pmaml_t_pmaml003 LIKE pmaml_t.pmaml003, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t7_imaal003 LIKE imaal_t.imaal003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t5_oocal003 LIKE oocal_t.oocal003, 
   x_t6_oocal003 LIKE oocal_t.oocal003, 
   x_qcaol_t_qcaol004 LIKE qcaol_t.qcaol004, 
   l_pmds003_ooefl003 LIKE type_t.chr1000, 
   l_pmds007_pmaal004 LIKE type_t.chr100, 
   l_pmds008_pmaal004 LIKE type_t.chr100, 
   l_pmds009_pmaal004 LIKE type_t.chr100, 
   l_pmds002_ooag011 LIKE type_t.chr300, 
   l_pmdt016_inayl003 LIKE type_t.chr1000, 
   l_pmdt017_inab003 LIKE type_t.chr1000, 
   pmdt063 LIKE pmdt_t.pmdt063, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   x_t7_imaal004 LIKE imaal_t.imaal004, 
   l_pmdt083_desc LIKE qcaol_t.qcaol004
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#add by liuxsa 160719-str-
DEFINE l_colorsize LIKE type_t.chr100
DEFINE l_pmdt007_desc LIKE type_t.chr100
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
DEFINE l_success   LIKE type_t.num5
#add by liuxsa 160719-end-
DEFINE l_pmds028   LIKE pmds_t.pmds028  #161207-00033#26
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #add by liuxsa 160719-str-  
    CALL apmr570_g01_erwei_tmp_table()   
    LET g_sql = " INSERT INTO apmr570_g01_temp02(pmdsdocno,item,imaal003,inam012,inam014,inam018,pmdt019,pmdt020,condition) VALUES (?,?,?,?,?,?,?,?,?) "
    PREPARE master_tmp FROM g_sql   
    #add by liuxsa 160719-end-
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH apmr570_g01_curs INTO sr_s.*
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
 
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       #add by liuxsa 160719-str-
       CALL s_feature_description(sr_s.pmdt006,sr_s.pmdt007) RETURNING l_success,l_colorsize
       let l_pmdt007_desc=l_colorsize
       IF cl_null(sr_s.x_t7_imaal003) THEN
          LET sr_s.x_t7_imaal003= sr_s.pmdt006
       END IF  
       #add by liuxsa 160719-end-   
       #161207-00033#26-S
       SELECT pmds028 INTO l_pmds028 FROM pmds_t 
        WHERE pmdsent = g_enterprise
          AND pmdsdocno = sr_s.pmdsdocno
       IF NOT cl_null(l_pmds028) THEN
          CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING sr_s.pmaal_t_pmaal004
          LET sr_s.l_pmds007_pmaal004 = sr_s.pmds007 CLIPPED,'.',sr_s.pmaal_t_pmaal004 CLIPPED
          IF sr_s.pmds007 = sr_s.pmds008 THEN
             LET sr_s.t1_pmaal004 = sr_s.pmaal_t_pmaal004
             LET sr_s.l_pmds008_pmaal004 = sr_s.l_pmds007_pmaal004
          END IF
          IF sr_s.pmds007 = sr_s.pmds009 THEN
             LET sr_s.t2_pmaal004 = sr_s.pmaal_t_pmaal004
             LET sr_s.l_pmds009_pmaal004 = sr_s.l_pmds007_pmaal004
          END IF          
       END IF       
       #161207-00033#26-E
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_condition = sr_s.l_condition
       LET sr[l_cnt].pmds000 = sr_s.pmds000
       LET sr[l_cnt].pmds001 = sr_s.pmds001
       LET sr[l_cnt].pmds002 = sr_s.pmds002
       LET sr[l_cnt].pmds003 = sr_s.pmds003
       LET sr[l_cnt].pmds006 = sr_s.pmds006
       LET sr[l_cnt].pmds007 = sr_s.pmds007
       LET sr[l_cnt].pmds008 = sr_s.pmds008
       LET sr[l_cnt].pmds009 = sr_s.pmds009
       LET sr[l_cnt].pmds010 = sr_s.pmds010
       LET sr[l_cnt].pmds011 = sr_s.pmds011
       LET sr[l_cnt].pmds021 = sr_s.pmds021
       LET sr[l_cnt].pmds022 = sr_s.pmds022
       LET sr[l_cnt].pmds023 = sr_s.pmds023
       LET sr[l_cnt].pmds024 = sr_s.pmds024
       LET sr[l_cnt].pmds031 = sr_s.pmds031
       LET sr[l_cnt].pmds032 = sr_s.pmds032
       LET sr[l_cnt].pmds033 = sr_s.pmds033
       LET sr[l_cnt].pmds034 = sr_s.pmds034
       LET sr[l_cnt].pmds035 = sr_s.pmds035
       LET sr[l_cnt].pmds036 = sr_s.pmds036
       LET sr[l_cnt].pmds037 = sr_s.pmds037
       LET sr[l_cnt].pmds038 = sr_s.pmds038
       LET sr[l_cnt].pmds039 = sr_s.pmds039
       LET sr[l_cnt].pmds040 = sr_s.pmds040
       LET sr[l_cnt].pmds041 = sr_s.pmds041
       LET sr[l_cnt].pmds042 = sr_s.pmds042
       LET sr[l_cnt].pmds043 = sr_s.pmds043
       LET sr[l_cnt].pmds044 = sr_s.pmds044
       LET sr[l_cnt].pmds045 = sr_s.pmds045
       LET sr[l_cnt].pmds046 = sr_s.pmds046
       LET sr[l_cnt].pmds047 = sr_s.pmds047
       LET sr[l_cnt].pmds048 = sr_s.pmds048
       LET sr[l_cnt].pmds049 = sr_s.pmds049
       LET sr[l_cnt].pmds081 = sr_s.pmds081
       LET sr[l_cnt].pmds100 = sr_s.pmds100
       LET sr[l_cnt].pmdsdocdt = sr_s.pmdsdocdt
       LET sr[l_cnt].pmdsdocno = sr_s.pmdsdocno
       LET sr[l_cnt].pmdsent = sr_s.pmdsent
       LET sr[l_cnt].pmdssite = sr_s.pmdssite
       LET sr[l_cnt].pmdsstus = sr_s.pmdsstus
       LET sr[l_cnt].pmdt001 = sr_s.pmdt001
       LET sr[l_cnt].pmdt002 = sr_s.pmdt002
       LET sr[l_cnt].pmdt003 = sr_s.pmdt003
       LET sr[l_cnt].pmdt004 = sr_s.pmdt004
       LET sr[l_cnt].pmdt005 = sr_s.pmdt005
       LET sr[l_cnt].pmdt006 = sr_s.pmdt006
       LET sr[l_cnt].pmdt007 = sr_s.pmdt007
       LET sr[l_cnt].pmdt008 = sr_s.pmdt008
       LET sr[l_cnt].pmdt009 = sr_s.pmdt009
       LET sr[l_cnt].pmdt010 = sr_s.pmdt010
       LET sr[l_cnt].pmdt011 = sr_s.pmdt011
       LET sr[l_cnt].pmdt016 = sr_s.pmdt016
       LET sr[l_cnt].pmdt017 = sr_s.pmdt017
       LET sr[l_cnt].pmdt018 = sr_s.pmdt018
       LET sr[l_cnt].pmdt019 = sr_s.pmdt019
       LET sr[l_cnt].pmdt020 = sr_s.pmdt020
       LET sr[l_cnt].pmdt021 = sr_s.pmdt021
       LET sr[l_cnt].pmdt022 = sr_s.pmdt022
       LET sr[l_cnt].pmdt023 = sr_s.pmdt023
       LET sr[l_cnt].pmdt024 = sr_s.pmdt024
       LET sr[l_cnt].pmdt025 = sr_s.pmdt025
       LET sr[l_cnt].pmdt026 = sr_s.pmdt026
       LET sr[l_cnt].pmdt036 = sr_s.pmdt036
       LET sr[l_cnt].pmdt037 = sr_s.pmdt037
       LET sr[l_cnt].pmdt038 = sr_s.pmdt038
       LET sr[l_cnt].pmdt039 = sr_s.pmdt039
       LET sr[l_cnt].pmdt040 = sr_s.pmdt040
       LET sr[l_cnt].pmdt041 = sr_s.pmdt041
       LET sr[l_cnt].pmdt046 = sr_s.pmdt046
       LET sr[l_cnt].pmdt047 = sr_s.pmdt047
       LET sr[l_cnt].pmdt051 = sr_s.pmdt051
       LET sr[l_cnt].pmdt052 = sr_s.pmdt052
       LET sr[l_cnt].pmdt053 = sr_s.pmdt053
       LET sr[l_cnt].pmdt054 = sr_s.pmdt054
       LET sr[l_cnt].pmdt055 = sr_s.pmdt055
       LET sr[l_cnt].pmdt059 = sr_s.pmdt059
       LET sr[l_cnt].pmdt060 = sr_s.pmdt060
       LET sr[l_cnt].pmdt061 = sr_s.pmdt061
       LET sr[l_cnt].pmdt062 = sr_s.pmdt062
       LET sr[l_cnt].pmdt081 = sr_s.pmdt081
       LET sr[l_cnt].pmdt082 = sr_s.pmdt082
       LET sr[l_cnt].pmdt083 = sr_s.pmdt083
       LET sr[l_cnt].pmdtseq = sr_s.pmdtseq
       LET sr[l_cnt].pmdtsite = sr_s.pmdtsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].t1_pmaal004 = sr_s.t1_pmaal004
       LET sr[l_cnt].t2_pmaal004 = sr_s.t2_pmaal004
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].x_t3_oocql004 = sr_s.x_t3_oocql004
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].pmaml_t_pmaml003 = sr_s.pmaml_t_pmaml003
       LET sr[l_cnt].ooidl_t_ooidl003 = sr_s.ooidl_t_ooidl003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_t7_imaal003 = sr_s.x_t7_imaal003
       LET sr[l_cnt].x_inab_t_inab003 = sr_s.x_inab_t_inab003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t5_oocal003 = sr_s.x_t5_oocal003
       LET sr[l_cnt].x_t6_oocal003 = sr_s.x_t6_oocal003
       LET sr[l_cnt].x_qcaol_t_qcaol004 = sr_s.x_qcaol_t_qcaol004
       LET sr[l_cnt].l_pmds003_ooefl003 = sr_s.l_pmds003_ooefl003
       LET sr[l_cnt].l_pmds007_pmaal004 = sr_s.l_pmds007_pmaal004
       LET sr[l_cnt].l_pmds008_pmaal004 = sr_s.l_pmds008_pmaal004
       LET sr[l_cnt].l_pmds009_pmaal004 = sr_s.l_pmds009_pmaal004
       LET sr[l_cnt].l_pmds002_ooag011 = sr_s.l_pmds002_ooag011
       LET sr[l_cnt].l_pmdt016_inayl003 = sr_s.l_pmdt016_inayl003
       LET sr[l_cnt].l_pmdt017_inab003 = sr_s.l_pmdt017_inab003
       LET sr[l_cnt].pmdt063 = sr_s.pmdt063
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].x_t7_imaal004 = sr_s.x_t7_imaal004
       LET sr[l_cnt].l_pmdt083_desc = sr_s.l_pmdt083_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       #add by liuxsa 160719-str
       LET sr_s.l_condition="-",sr_s.pmdt016 CLIPPED,"-",sr_s.pmdt017 CLIPPED,"-",sr_s.pmdt018 CLIPPED,"-",sr_s.pmdt051 CLIPPED,"-"
       LET sr[l_cnt].l_condition = sr_s.l_condition
       IF NOT cl_null(sr_s.pmdt007) THEN
         LET l_imaa005=NULL
         SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent=g_enterprise and imaa001=sr_s.pmdt006
         LET l_inam012=NULL
         LET l_inam014=NULL
         LET l_inam018=NULL
       
         LET l_cnt2=1
         LET tok = base.StringTokenizer.createExt(sr_s.pmdt007,'_','',TRUE)
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
            EXECUTE master_tmp USING sr_s.pmdsdocno,sr_s.pmdt006,sr_s.x_t7_imaal003,l_inam012,l_inam014,l_inam018,sr_s.pmdt019,sr_s.pmdt020,sr_s.l_condition 
          END IF 
        END IF 
        #add by liuxsa 160719-end-
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr570_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr570_g01_rep_data()
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
          START REPORT apmr570_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT apmr570_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT apmr570_g01_rep
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
 
{<section id="apmr570_g01.rep" readonly="Y" >}
PRIVATE REPORT apmr570_g01_rep(sr1)
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
DEFINE sr4       sr4_r
DEFINE sr6       sr6_r
DEFINE l_pmdt016_inayl003_show LIKE type_t.chr1    #倉庫隱藏
DEFINE l_pmdt017_inab003_show  LIKE type_t.chr1    #儲位
DEFINE l_pmds045_show          LIKE type_t.chr1    #pmds045 備註 單頭
DEFINE l_pmdt059_show          LIKE type_t.chr1    #pmdt059 備註 單身
DEFINE l_pmdt083_show          LIKE type_t.chr1    #判定結果
DEFINE l_subrep06_show         LIKE type_t.chr1
DEFINE l_subrep07_show         LIKE type_t.chr1
DEFINE l_pmdt007_pmdt063_show  LIKE type_t.chr1    #判定結果 /庫存產品特徵
DEFINE l_ac               INTEGER
DEFINE l_i                INTEGER

#add by liuxsa 160719-str-
DEFINE sr8             sr8_r
DEFINE l_sql           STRING      
DEFINE l_inam014_cnt   LIKE type_t.num10
DEFINE l_pageno        LIKE type_t.num10
DEFINE l_inam014       LIKE type_t.chr1000 
DEFINE l_subrep08_show LIKE type_t.chr1
DEFINE l_item          LIKE type_t.chr1000
DEFINE l_pmdt020_sum   LIKE pmdt_t.pmdt020
#add by liuxsa 160719-end-
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.pmdsdocno,sr1.pmdt006,sr1.l_condition
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
        BEFORE GROUP OF sr1.pmdsdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.pmdsdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'pmdsent=' ,sr1.pmdsent,'{+}pmdsdocno=' ,sr1.pmdsdocno         
            CALL cl_gr_init_apr(sr1.pmdsdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.pmdsdocno.before name="rep.b_group.pmdsdocno.before"
           #pmds045 備註單頭隱藏
           INITIALIZE l_pmds045_show TO NULL
           IF cl_null(sr1.pmds045) THEN
              LET l_pmds045_show = "N"
           ELSE
              LET l_pmds045_show = "Y"
           END IF
           
           PRINTX l_pmds045_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.pmdsent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdsdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr570_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE apmr570_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT apmr570_g01_subrep01
           DECLARE apmr570_g01_repcur01 CURSOR FROM g_sql
           FOREACH apmr570_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr570_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT apmr570_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT apmr570_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.pmdsdocno.after name="rep.b_group.pmdsdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.pmdt006
 
           #add-point:rep.b_group.pmdt006.before name="rep.b_group.pmdt006.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.pmdt006.after name="rep.b_group.pmdt006.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_condition
 
           #add-point:rep.b_group.l_condition.before name="rep.b_group.l_condition.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.l_condition.after name="rep.b_group.l_condition.after"
           
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
                sr1.pmdsent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdsdocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr570_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE apmr570_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT apmr570_g01_subrep02
           DECLARE apmr570_g01_repcur02 CURSOR FROM g_sql
           FOREACH apmr570_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr570_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT apmr570_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT apmr570_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
            # 備註單身隱藏
            INITIALIZE l_pmdt059_show TO NULL
            IF cl_null(sr1.pmdt059) THEN
               LET l_pmdt059_show = "N"
            ELSE
               LET l_pmdt059_show = "Y"
            END IF
            
            INITIALIZE l_pmdt016_inayl003_show TO NULL
            IF cl_null(sr1.pmdt016) THEN
               LET l_pmdt016_inayl003_show = "N"
            ELSE
               LET l_pmdt016_inayl003_show = "Y"
            END IF
            
            INITIALIZE l_pmdt017_inab003_show TO NULL
            IF cl_null(sr1.pmdt017) THEN
               LET l_pmdt017_inab003_show = "N"
            ELSE
               LET l_pmdt017_inab003_show = "Y"
            END IF
            

           #判定結果說明
           SELECT qcaol004 INTO sr1.l_pmdt083_desc
             FROM qcaol_t
            WHERE qcaolent = sr1.pmdsent
              AND qcaol002 = sr1.pmdt083                                                                        
                       
            #判定結果隱藏
            INITIALIZE l_pmdt083_show TO NULL
            IF cl_null(sr1.pmdt083)  THEN
               LET l_pmdt083_show = "N"
            ELSE
               LET l_pmdt083_show = "Y"
            END IF
            
            #料件/庫存管理特徵 都為空時 縮排
            INITIALIZE l_pmdt007_pmdt063_show TO NULL
            IF cl_null(sr1.pmdt007) AND cl_null(sr1.pmdt063) THEN
               LET l_pmdt007_pmdt063_show = "N"
            ELSE
               LET l_pmdt007_pmdt063_show = "Y"
            END IF
            
            PRINTX l_pmdt059_show
            PRINTX l_pmdt017_inab003_show
            PRINTX l_pmdt016_inayl003_show
            PRINTX l_pmdt083_show
            PRINTX l_pmdt007_pmdt063_show
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
            START REPORT apmr570_g01_subrep05
            IF tm.a1 ="Y" AND NOT cl_null(sr1.pmdtseq) THEN
               LET g_sql = "SELECT pmdudocno,pmduseq,pmduseq1,pmdu005,pmdu006,pmdu007,pmdu008,pmdu010,pmdu009 ",
                           "  FROM pmdu_t ",
                           " WHERE pmdudocno = '",sr1.pmdsdocno CLIPPED,"'",
                           "   AND pmduent   = '",sr1.pmdsent   CLIPPED,"'",
                           "   AND pmduseq   = '",sr1.pmdtseq   CLIPPED,"' ",                           
                           "   ORDER BY pmduseq1 "
                                  
               DECLARE apmr570_g01_repcur05 CURSOR FROM g_sql
               FOREACH apmr570_g01_repcur05 INTO sr3.*                              
                  OUTPUT TO REPORT apmr570_g01_subrep05(sr3.*)
               END FOREACH
            END IF
            FINISH REPORT apmr570_g01_subrep05
             #############################################################################                              
            INITIALIZE l_subrep06_show TO NULL
            LET l_subrep06_show = "N" 
            START REPORT apmr570_g01_subrep06              
            IF tm.a2 ="Y" AND  NOT cl_null(sr1.pmdtseq) THEN                          
               LET g_sql = "SELECT inao008,inao009",
                           "  FROM inao_t ",
                           " WHERE inaoent     = '",sr1.pmdsent      CLIPPED,"'",                                               
                           "   AND inaosite    = '",sr1.pmdssite     CLIPPED,"'",
                           "   AND inaodocno   = '",sr1.pmdsdocno    CLIPPED,"'",                    
                           "   AND inaoseq     = '",sr1.pmdtseq      CLIPPED,"'",                           
                           "   AND inao008 IS NOT NULL  ",
                           "   AND inao009 IS NOT NULL  "
                       
                       
            
               LET l_ac = 1                              
               CALL sr5.clear()                 
               DECLARE apmr570_g01_repcur06 CURSOR FROM g_sql
               FOREACH apmr570_g01_repcur06 INTO sr5[l_ac].*  
                   LET l_ac = l_ac+1                                
               END FOREACH      
               LET l_ac = l_ac-1               
               LET l_i = 1                                   
               IF l_ac > 0 THEN
                  LET l_subrep06_show = "Y"         
                  WHILE TRUE                         
                     INITIALIZE sr4.* TO NULL
                     LET sr4.inao008_1 = sr5[l_i].inao008
                     LET sr4.inao009_1 = sr5[l_i].inao009
                     LET sr4.l_inao008_1_inao009_1  = sr4.inao008_1  , "/" , sr4.inao009_1                                                                                         
                     IF l_i+1 <= l_ac THEN    
                        LET sr4.inao008_2 = sr5[l_i+1].inao008
                        LET sr4.inao009_2 = sr5[l_i+1].inao009
                        LET sr4.l_inao008_2_inao009_2 =  sr4.inao008_2 , "/" , sr4.inao009_2                              
                     END IF
                     
                     IF l_i+2 <= l_ac THEN    
                        LET sr4.inao008_3 = sr5[l_i+2].inao008
                        LET sr4.inao009_3 = sr5[l_i+2].inao009                  
                        LET sr4.l_inao008_3_inao009_3 = sr4.inao008_3 , "/" , sr4.inao009_3
                     END IF              
                            
                     OUTPUT TO REPORT apmr570_g01_subrep06(sr4.*)              
                     LET l_i = l_i + 3
                     IF l_i > l_ac THEN  
                        EXIT WHILE
                     END IF                     
                  END  WHILE                                                
               END IF                    
            END IF                      
            FINISH REPORT apmr570_g01_subrep06
            PRINTX l_subrep06_show 
            #############################################################################
            INITIALIZE l_subrep07_show TO NULL
            LET l_subrep07_show = "N" 
            START REPORT apmr570_g01_subrep07           
            IF tm.a2 ="Y" AND  NOT cl_null(sr1.pmdtseq)THEN                          
               LET g_sql = "SELECT inao008,inao012",
                           "  FROM inao_t ",
                           " WHERE inaoent     = '",sr1.pmdsent      CLIPPED,"'",                                               
                           "   AND inaosite    = '",sr1.pmdssite     CLIPPED,"'",
                           "   AND inaodocno   = '",sr1.pmdsdocno    CLIPPED,"'",                    
                           "   AND inaoseq     = '",sr1.pmdtseq      CLIPPED,"'",                          
                           "   AND inao008 IS NOT NULL ",
                           "   AND inao009 IS NULL     "
                                              
                             
               LET l_ac = 1                              
               CALL sr7.clear()                 
               DECLARE apmr570_g01_repcur07 CURSOR FROM g_sql
               FOREACH apmr570_g01_repcur07 INTO sr7[l_ac].*  
                   LET l_ac = l_ac+1                                
               END FOREACH      
               LET l_ac = l_ac-1               
               LET l_i = 1
                          
               IF l_ac > 0 THEN
                  LET l_subrep07_show = "Y"
                  WHILE TRUE                         
                     INITIALIZE sr6.* TO NULL
                     LET sr6.inao008_1 = sr7[l_i].inao008
                     LET sr6.inao012_1 = sr7[l_i].inao012
                     LET sr6.l_inao008_1_inao012_1  = sr6.inao008_1  , "/" , sr6.inao012_1                                                                                         
                     IF l_i+1 <= l_ac THEN    
                        LET sr6.inao008_2 = sr7[l_i+1].inao008
                        LET sr6.inao012_2 = sr7[l_i+1].inao012
                        LET sr6.l_inao008_2_inao012_2 =  sr6.inao008_2 , "/" , sr6.inao012_2                              
                     END IF
                     
                     IF l_i+2 <= l_ac THEN    
                        LET sr6.inao008_3 = sr7[l_i+2].inao008
                        LET sr6.inao012_3 = sr7[l_i+2].inao012                  
                        LET sr6.l_inao008_3_inao012_3 = sr6.inao008_3 , "/" , sr6.inao012_3
                     END IF              
                            
                     OUTPUT TO REPORT apmr570_g01_subrep07(sr6.*)              
                     LET l_i = l_i + 3
                     IF l_i > l_ac THEN  
                        EXIT WHILE
                     END IF                     
                  END  WHILE 
               END IF                    
            END IF
                       
            FINISH REPORT apmr570_g01_subrep07  
            PRINTX l_subrep07_show
                              
          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.pmdsent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr570_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE apmr570_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT apmr570_g01_subrep03
           DECLARE apmr570_g01_repcur03 CURSOR FROM g_sql
           FOREACH apmr570_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr570_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT apmr570_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT apmr570_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmdsdocno
 
           #add-point:rep.a_group.pmdsdocno.before name="rep.a_group.pmdsdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.pmdsent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdsdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr570_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE apmr570_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT apmr570_g01_subrep04
           DECLARE apmr570_g01_repcur04 CURSOR FROM g_sql
           FOREACH apmr570_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr570_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr570_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT apmr570_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.pmdsdocno.after name="rep.a_group.pmdsdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmdt006
 
           #add-point:rep.a_group.pmdt006.before name="rep.a_group.pmdt006.before"
 
           #end add-point:
 
 
           #add-point:rep.a_group.pmdt006.after name="rep.a_group.pmdt006.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_condition
 
           #add-point:rep.a_group.l_condition.before name="rep.a_group.l_condition.before"
           #add by liuxsa 160719-str-
           DROP TABLE inam014_tmp
          CREATE TEMP TABLE inam014_tmp
          (
           i          decimal(5,0),
           inam014    LIKE type_t.chr1000
           )

          DROP TABLE pmdn_print_tmp         
          CREATE TEMP TABLE pmdn_print_tmp
          (
           pmdsdocno  LIKE pmds_t.pmdsdocno,          #單號 
           item       LIKE type_t.chr100,
           imaal003   LIKE imaal_t.imaal003,          #品名
           inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
           inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
           inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)           
           pmdt019    LIKE pmdt_t.pmdt019,            #單位
           pmdt0201   LIKE pmdt_t.pmdt020,            #數量1
           pmdt0202   LIKE pmdt_t.pmdt020,            #數量2
           pmdt0203   LIKE pmdt_t.pmdt020,            #數量3
           pmdt0204   LIKE pmdt_t.pmdt020,            #數量4
           pmdt0205   LIKE pmdt_t.pmdt020,            #數量5
           pmdt0206   LIKE pmdt_t.pmdt020,            #數量6
           pmdt0207   LIKE pmdt_t.pmdt020,            #數量7
           pmdt0208   LIKE pmdt_t.pmdt020,            #數量8
           pmdt0209   LIKE pmdt_t.pmdt020,            #數量9
           pmdt0200   LIKE pmdt_t.pmdt020,            #數量10
           l_skip     LIKE type_t.chr1,
           condition  LIKE type_t.chr1000
          )
   
          LET l_sub_sql = " SELECT DISTINCT inam014 FROM apmr570_g01_temp02 ",
                      " WHERE pmdsdocno=? and imaal003=? and condition=? and item=? ",
                      " ORDER BY inam014"
          PREPARE inam014_ins FROM l_sub_sql
          DECLARE inam014_ins_cs CURSOR FOR inam014_ins

          #計算橫軸個數
          LET l_sql = "SELECT COUNT(1) FROM (",l_sub_sql,")"
          PREPARE inam014_cnt_pre FROM l_sql            
          
          EXECUTE inam014_cnt_pre INTO l_inam014_cnt USING sr1.pmdsdocno,sr1.x_t7_imaal003,sr1.l_condition,sr1.pmdt006
          FREE inam014_cnt_pre
             
           --总合计
           
          LET l_sub_sql = " SELECT SUM(pmdt020) FROM apmr570_g01_temp02 ",
                      " WHERE pmdsdocno=? "
          PREPARE pmdt020_total_sum FROM l_sub_sql        
          
          #總計(合計)   
          LET l_sub_sql = " SELECT SUM(pmdt020) FROM apmr570_g01_temp02 ",
                      " WHERE pmdsdocno=? and imaal003=? and condition=? and item=? "
          PREPARE pmdt020_total FROM l_sub_sql
       
              
          IF NOT cl_null(l_inam014_cnt) THEN
             LET l_pageno = (l_inam014_cnt -1)/10   #每頁10筆
             LET l_pageno = l_pageno +1
         
             DELETE FROM inam014_tmp WHERE 1=1
             OPEN inam014_ins_cs USING sr1.pmdsdocno,sr1.x_t7_imaal003,sr1.l_condition,sr1.pmdt006
             LET l_i=1
             FOREACH inam014_ins_cs INTO l_inam014
                INSERT INTO inam014_tmp VALUES(l_i,l_inam014)
                LET l_i=l_i+1
             END FOREACH
          
             FOR l_i = 1 to l_pageno
                CALL apmr570_g01_ins_erwei_temp(sr1.pmdsdocno,sr1.x_t7_imaal003,l_i,sr1.l_condition,sr1.pmdt006)
             END FOR  
          END IF           
          
           
          LET g_sql = " SELECT A.*,'",sr1.pmdt036,"' FROM pmdn_print_tmp A WHERE 1=1 "
          LET l_cnt = 0
          LET l_sub_sql = ""
          LET l_subrep08_show ="N"
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE apmr570_g01_repcur08_cnt_pre FROM l_sub_sql
          EXECUTE apmr570_g01_repcur08_cnt_pre INTO l_cnt
          IF l_cnt > 0 THEN 
              LET l_subrep08_show ="Y"
          END IF
          --调用子报表
          PRINTX l_subrep08_show 
          START REPORT apmr570_g01_subrep08
          LET g_sql=g_sql," ORDER BY 1,3,4 "
          DECLARE apmr570_g01_repcur08 CURSOR FROM g_sql
          FOREACH apmr570_g01_repcur08 INTO sr8.*
             IF STATUS THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "apmr570_g01_repcur08:"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = FALSE
                CALL cl_err()                  
                EXIT FOREACH 
             END IF
             
             OUTPUT TO REPORT apmr570_g01_subrep08(sr8.*) --subrep05中印出
          END FOREACH
          FINISH REPORT apmr570_g01_subrep08  
          
          --打印总合计
          LET l_pmdt020_sum=0
          LET l_total=0
          EXECUTE pmdt020_total INTO l_pmdt020_sum USING sr1.pmdsdocno,sr1.x_t7_imaal003,sr1.l_condition,sr1.pmdt006
          let l_total=l_pmdt020_sum*sr1.pmdt036
          PRINTX l_pmdt020_sum
          PRINTX l_total   
           #add by liuxsa 160719-end-
           #end add-point:
 
 
           #add-point:rep.a_group.l_condition.after name="rep.a_group.l_condition.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="apmr570_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr570_g01_subrep01(sr2)
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
PRIVATE REPORT apmr570_g01_subrep02(sr2)
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
PRIVATE REPORT apmr570_g01_subrep03(sr2)
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
PRIVATE REPORT apmr570_g01_subrep04(sr2)
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
 
{<section id="apmr570_g01.other_function" readonly="Y" >}

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
PRIVATE FUNCTION apmr570_g01_erwei_tmp_table()
   
   #add by liuxsa 160719
   
   DROP TABLE apmr570_g01_temp02;

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'apmr570_g01_temp02'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   CREATE TEMP TABLE apmr570_g01_temp02(  
                   pmdsdocno  LIKE pmds_t.pmdsdocno,          #單號  
                   item       LIKE type_t.chr100,             #料件编号
                   imaal003   LIKE imaal_t.imaal003,          #品名
                   inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
                   inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
                   inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)
                   pmdt019    LIKE pmdt_t.pmdt019,            #單位                  
                   pmdt020    LIKE pmdt_t.pmdt020,            #數量  
                   condition  LIKE type_t.chr1000             #分组条件                   
                   )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apmr570_g01_temp02'
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
PRIVATE FUNCTION apmr570_g01_ins_erwei_temp(p_pmdsdocno,p_imaal003,p_i,p_condition,p_item)
#add by liuxsa 160719
--計算交叉表數值區資料總和
DEFINE p_pmdsdocno  LIKE pmds_t.pmdsdocno
DEFINE p_imaal003   LIKE imaal_t.imaal003
DEFINE p_condition  LIKE type_t.chr1000
DEFINE p_item       LIKE type_t.chr100
DEFINE p_i          LIKE type_t.num5
DEFINE l_n          LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5
DEFINE l_max        LIKE type_t.num5
DEFINE l_max2       LIKE type_t.num5
DEFINE l_a          LIKE type_t.num5
DEFINE l_b          LIKE type_t.num5
DEFINE l_sql        STRING
DEFINE l_pmdt020    STRING
DEFINE l_vi         varchar(3)
DEFINE i          LIKE type_t.num5

   CALL g_inam014.clear()

   SELECT COUNT(DISTINCT inam014) INTO l_n FROM apmr570_g01_temp02
         WHERE pmdsdocno=p_pmdsdocno AND imaal003 = p_imaal003 AND item = p_item  AND condition=p_condition
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
   
   LET l_sql = " INSERT INTO pmdn_print_tmp(pmdsdocno,item,imaal003,inam012,inam014,inam018,pmdt019,condition  "
   FOR i=1 to l_max2
      CASE i WHEN 1 LET l_pmdt020 = 'pmdt0201'
             WHEN 2 LET l_pmdt020 = 'pmdt0202'
             WHEN 3 LET l_pmdt020 = 'pmdt0203'
             WHEN 4 LET l_pmdt020 = 'pmdt0204'
             WHEN 5 LET l_pmdt020 = 'pmdt0205'
             WHEN 6 LET l_pmdt020 = 'pmdt0206'
             WHEN 7 LET l_pmdt020 = 'pmdt0207'
             WHEN 8 LET l_pmdt020 = 'pmdt0208'
             WHEN 9 LET l_pmdt020 = 'pmdt0209'           
             WHEN 10 LET l_pmdt020 = 'pmdt0200'
      END CASE
      LET l_sql = l_sql , ",",l_pmdt020
   END FOR
   
   LET l_sql = l_sql," ) SELECT pmdsdocno,item,imaal003,inam012,'','',pmdt019,condition "
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql," ,sum(A",l_vi,")"
   END FOR
   LET l_sql = l_sql,"  FROM ( SELECT pmdsdocno,item,imaal003,inam012,inam014,inam018,pmdt019,condition "
 
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql,",CASE WHEN inam014 = '",g_inam014[i],"'",
                        " THEN pmdt020 ELSE 0 END A",l_vi
   END FOR
   LET l_sql = l_sql,  "  FROM apmr570_g01_temp02 ",
               " WHERE pmdsdocno='",p_pmdsdocno,"'",
               "   AND item = '",p_item,"'",
               "   AND condition='",p_condition,"'",
               "   AND imaal003 = '",p_imaal003,"'",
               "   ) "
               ," GROUP BY pmdsdocno,imaal003,inam012,pmdt019,condition,item "
                              
   PREPARE pmdn_print_pr FROM l_sql
   
   DELETE FROM pmdn_print_tmp WHERE 1=1
   EXECUTE pmdn_print_pr
   
  UPDATE pmdn_print_tmp 
      SET l_skip = "N"
      WHERE pmdsdocno = p_pmdsdocno AND imaal003 = p_imaal003 AND inam014 = g_inam014[l_max2] AND item = p_item
   
END FUNCTION

 
{</section>}
 
{<section id="apmr570_g01.other_report" readonly="Y" >}

REPORT apmr570_g01_subrep05(sr3)
DEFINE sr3 sr3_r
ORDER EXTERNAL BY sr3.pmdudocno
   FORMAT
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr3.* 
         
END REPORT

REPORT apmr570_g01_subrep06(sr4)
DEFINE sr4 sr4_r
ORDER EXTERNAL BY sr4.l_inao008_1_inao009_1
   FORMAT
      ON EVERY ROW
         PRINTX g_grNumFmt.*        
         PRINTX sr4.*
        
END REPORT

PRIVATE REPORT apmr570_g01_subrep07(sr6)
DEFINE sr6 sr6_r
ORDER EXTERNAL BY sr6.l_inao008_1_inao012_1 
   FORMAT           
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr6.*
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
PRIVATE REPORT apmr570_g01_subrep08(sr8)
#add by liuxsa 160719
DEFINE sr8 sr8_r
DEFINE sr3       sr3_r
DEFINE sr4       sr4_r
DEFINE sr6       sr6_r
DEFINE l_ac              INTEGER
DEFINE l_i               INTEGER
DEFINE l_count           INTEGER
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
DEFINE l_pmdt020_sum   LIKE type_t.num15_3
DEFINE l_pmdt020_total LIKE type_t.num15_3
DEFINE l_pmdt036_total LIKE type_t.num20_6
DEFINE l_sum r_sum
DEFINE l_title         LIKE type_t.chr1000
DEFINE l_sql           LIKE type_t.chr1000

    ORDER EXTERNAL BY sr8.pmdsdocno
    FORMAT
        BEFORE GROUP OF sr8.pmdsdocno  --子報表中動態顯示title及計算總和
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
           PREPARE apmr570_g01_title_pre FROM l_sql
           EXECUTE apmr570_g01_title_pre into l_title
          
           IF tm.a1 ="Y" THEN              
                  LET g_sql = "SELECT pmdudocno,pmduseq,pmduseq1,pmdu006,pmdu007,pmdu008,pmdu005,sum(pmdu010),pmdu009 ",
                              "  FROM pmdu_t,pmdt_t ",
                              " WHERE pmdudocno = '",sr8.pmdsdocno CLIPPED,"'",
                              "   AND pmduent   = '",g_enterprise   CLIPPED,"'",
                              "   AND pmduseq   = pmdtseq and pmdudocno=pmdtdocno AND pmduent=pmdtent ",   
                              "   AND pmdt006='",sr8.item,"'",
                              "   AND '-'||trim(pmdt016)||'-'||trim(pmdt017)||'-'||trim(pmdt018)||'-'||trim(pmdt051)||'-' = '",sr8.condition,"'",                             
                              "   group BY  pmdudocno,pmdu006,pmdu007,pmdu008,pmdu009,pmdu005"
                                     
                  DECLARE apmr570_g01_repcur05_2 CURSOR FROM g_sql
                  EXECUTE apmr570_g01_repcur05_2 INTO sr3.*
           
                  PRINTX sr3.*             
            END IF
            IF tm.a2 ="Y" THEN      
                LET g_sql = "SELECT inao008,inao009",
                           "  FROM inao_t,pmdt_t ",
                           " WHERE inaoent     = '",g_enterprise      CLIPPED,"'",                                               
                           "   AND inaosite    = '",g_site     CLIPPED,"'",
                           "   AND inaodocno   = '",sr8.pmdsdocno    CLIPPED,"'",                    
                           "   AND inaoseq= pmdtseq and inaodocno=pmdtdocno AND inaoent=pmdtent and inaosite=pmdtsite",
                           "   AND pmdt006='",sr8.item,"'",
                           "   AND '-'||trim(pmdt016)||'-'||trim(pmdt017)||'-'||trim(pmdt018)||'-'||trim(pmdt051)||'-' = '",sr8.condition,"'",                              
                           "   AND inao000     = '1'",
                           "   AND inao008 IS NOT NULL  ",
                           "   AND inao009 IS NOT NULL  "                                             
            
               LET l_ac = 1                              
               CALL sr5.clear()                 
               DECLARE apmr570_g01_repcur06_2 CURSOR FROM g_sql
               FOREACH apmr570_g01_repcur06_2 INTO sr5[l_ac].*  
                  LET l_ac = l_ac+1                                
               END FOREACH      
               LET l_ac = l_ac-1               
               LET l_i = 1                       
               IF l_ac > 0 THEN      
                  WHILE TRUE                         
                     INITIALIZE sr4.* TO NULL
                     LET sr4.inao008_1 = sr5[l_i].inao008
                     LET sr4.inao009_1 = sr5[l_i].inao009
                     LET sr4.l_inao008_1_inao009_1  = sr4.inao008_1  , "/" , sr4.inao009_1                                                                                         
                     IF l_i+1 <= l_ac THEN    
                        LET sr4.inao008_2 = sr5[l_i+1].inao008
                        LET sr4.inao009_2 = sr5[l_i+1].inao009
                        LET sr4.l_inao008_2_inao009_2 =  sr4.inao008_2 , "/" , sr4.inao009_2                              
                     END IF
                     
                     IF l_i+2 <= l_ac THEN    
                        LET sr4.inao008_3 = sr5[l_i+2].inao008
                        LET sr4.inao009_3 = sr5[l_i+2].inao009                  
                        LET sr4.l_inao008_3_inao009_3 = sr4.inao008_3 , "/" , sr4.inao009_3
                     END IF              
                            
                     PRINTX sr4.*              
                     LET l_i = l_i + 3
                     IF l_i > l_ac THEN  
                        EXIT WHILE
                     END IF                     
                  END  WHILE                                                
               END IF  
                                
               LET g_sql = "SELECT inao008,inao012",
                           "  FROM inao_t ",
                           " WHERE inaoent     = '",g_enterprise      CLIPPED,"'",                                               
                           "   AND inaosite    = '",g_site     CLIPPED,"'",
                           "   AND inaodocno   = '",sr8.pmdsdocno    CLIPPED,"'",                    
                           "   AND inaoseq= pmdtseq and inaodocno=pmdtdocno AND inaoent=pmdtent and inaosite=pmdtsite",
                           "   AND pmdt006='",sr8.item,"'",
                           "   AND '-'||trim(pmdt016)||'-'||trim(pmdt017)||'-'||trim(pmdt018)||'-'||trim(pmdt051)||'-' = '",sr8.condition,"'",                                                    
                           "   AND inao000     = '1'",
                           "   AND inao008 IS NOT NULL ",
                           "   AND inao009 IS NULL "  
                             
               LET l_ac = 1                              
               CALL sr7.clear()                 
               DECLARE apmr570_g01_repcur07_2 CURSOR FROM g_sql
               FOREACH apmr570_g01_repcur07_2 INTO sr7[l_ac].*
                   LET l_ac = l_ac+1                                
               END FOREACH      
               LET l_ac = l_ac-1               
               LET l_i = 1                           
               IF l_ac > 0 THEN
                  WHILE TRUE                         
                     INITIALIZE sr6.* TO NULL
                     LET sr6.inao008_1 = sr7[l_i].inao008
                     LET sr6.inao012_1 = sr7[l_i].inao012
                     LET sr6.l_inao008_1_inao012_1  = sr6.inao008_1  , "/" , sr6.inao012_1                                                                                         
                     IF l_i+1 <= l_ac THEN    
                        LET sr6.inao008_2 = sr7[l_i+1].inao008
                        LET sr6.inao012_2 = sr7[l_i+1].inao012
                        LET sr6.l_inao008_2_inao012_2 =  sr6.inao008_2 , "/" , sr6.inao012_2                              
                     END IF
                     
                     IF l_i+2 <= l_ac THEN    
                        LET sr6.inao008_3 = sr7[l_i+2].inao008
                        LET sr6.inao012_3 = sr7[l_i+2].inao012                  
                        LET sr6.l_inao008_3_inao012_3 = sr6.inao008_3 , "/" , sr6.inao012_3
                     END IF              
                            
                     PRINTX sr6.*              
                     LET l_i = l_i + 3
                     IF l_i > l_ac THEN  
                        EXIT WHILE
                     END IF                     
                  END  WHILE 
               END IF                    
            END IF

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
            LET l_pmdt020_sum = 0
            IF cl_null(sr8.pmdt0201) THEN LET sr8.pmdt0201 = 0 END IF            
            IF cl_null(sr8.pmdt0202) THEN LET sr8.pmdt0202 = 0 END IF            
            IF cl_null(sr8.pmdt0203) THEN LET sr8.pmdt0203 = 0 END IF           
            IF cl_null(sr8.pmdt0204) THEN LET sr8.pmdt0204 = 0 END IF            
            IF cl_null(sr8.pmdt0205) THEN LET sr8.pmdt0205 = 0 END IF            
            IF cl_null(sr8.pmdt0206) THEN LET sr8.pmdt0206 = 0 END IF          
            IF cl_null(sr8.pmdt0207) THEN LET sr8.pmdt0207 = 0 END IF            
            IF cl_null(sr8.pmdt0208) THEN LET sr8.pmdt0208 = 0 END IF            
            IF cl_null(sr8.pmdt0209) THEN LET sr8.pmdt0209 = 0 END IF           
            IF cl_null(sr8.pmdt0200) THEN LET sr8.pmdt0200 = 0 END IF              
            
            #横向小計
            LET l_pmdt020_sum = sr8.pmdt0201+sr8.pmdt0202+sr8.pmdt0203+sr8.pmdt0204+sr8.pmdt0205+sr8.pmdt0206+sr8.pmdt0207+sr8.pmdt0208+sr8.pmdt0209+sr8.pmdt0200
            PRINTX l_pmdt020_sum  
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
            LET l_sum.sum01=l_sum.sum01+ sr8.pmdt0201 
            LET l_sum.sum02=l_sum.sum02+ sr8.pmdt0202 
            LET l_sum.sum03=l_sum.sum03+ sr8.pmdt0203 
            LET l_sum.sum04=l_sum.sum04+ sr8.pmdt0204 
            LET l_sum.sum05=l_sum.sum05+ sr8.pmdt0205 
            LET l_sum.sum06=l_sum.sum06+ sr8.pmdt0206 
            LET l_sum.sum07=l_sum.sum07+ sr8.pmdt0207 
            LET l_sum.sum08=l_sum.sum08+ sr8.pmdt0208 
            LET l_sum.sum09=l_sum.sum09+ sr8.pmdt0209 
            LET l_sum.sum10=l_sum.sum10+ sr8.pmdt0200 
                                  
            #金额
            LET l_pmdt036_total=l_pmdt020_sum*sr8.pmdt036
            PRINTX l_pmdt036_total
            
            
        AFTER GROUP OF sr8.pmdsdocno
            #横向总计
            EXECUTE pmdt020_total INTO l_pmdt020_total USING sr8.pmdsdocno,sr8.imaal003,sr8.condition,sr8.item
            IF cl_null(l_pmdt020_total) THEN LET l_pmdt020_total = 0 END IF
            PRINTX l_pmdt020_total                   
            #总数量
            EXECUTE pmdt020_total_sum INTO l_total USING sr8.pmdsdocno
            IF cl_null(l_total) THEN LET l_total = 0 END IF
            #纵向小计
            LET l_sum.sum11=l_sum.sum01+l_sum.sum02+l_sum.sum03+l_sum.sum04+l_sum.sum05+l_sum.sum06+l_sum.sum07+l_sum.sum08+l_sum.sum09+l_sum.sum10
            PRINTX l_sum.*

END REPORT

 
{</section>}
 
