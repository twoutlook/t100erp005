SCHEMA ds

GLOBALS
DEFINE g_ref_unit            LIKE type_t.chr1   #是否启用参考单位

#-->step 1
   DEFINE g_wc_01               STRING
   DEFINE g_sfdcdocno_01        STRING

   TYPE type_g_asfp370_01_m        RECORD
          rdo_sel        LIKE type_t.chr1,   #拨入库储选项
          inaa001        LIKE inaa_t.inaa001,
          inaa001_desc   LIKE type_t.chr80,
          inab002        LIKE inab_t.inab002,
          inab002_desc   LIKE type_t.chr80 
          END RECORD
   DEFINE g_asfp370_01_m        type_g_asfp370_01_m
   
   TYPE type_g_sfdc01_d        RECORD
         sel                  LIKE type_t.chr1,        #选择
         sfdcdocno            LIKE sfdc_t.sfdcdocno,   #发料单号
         sfdcseq              LIKE sfdc_t.sfdcseq,     #项次
         sfdc001              LIKE sfdc_t.sfdc001,     #工单单号
         sfdc002              LIKE sfdc_t.sfdc002,     #工单项次
         sfdc003              LIKE sfdc_t.sfdc003,     #工单项序
         sfdc004              LIKE sfdc_t.sfdc004,     #需求料号
         sfdc004_desc         LIKE type_t.chr80,       #品名
         sfdc004_desc_desc    LIKE type_t.chr80,       #规格
         sfdc005              LIKE sfdc_t.sfdc005,     #特征
         sfdc006              LIKE sfdc_t.sfdc006,     #单位
         sfba013              LIKE sfba_t.sfba013,     #应发数量
         sfba016              LIKE sfba_t.sfba016,     #已发量
         sfdc007              LIKE sfdc_t.sfdc007,     #申请数量
         inag008              LIKE inag_t.inag008,     #库存数量
         diff                 LIKE sfdc_t.sfdc007,     #差异数量
         sfdc009              LIKE sfdc_t.sfdc009,     #参考单位
         sfdc010              LIKE sfdc_t.sfdc010,     #参考单位申请数量
         inag025              LIKE inag_t.inag025,     #参考单位库存数量
         diffr                LIKE sfdc_t.sfdc010,     #参考单位差异数量
         sfdc012              LIKE sfdc_t.sfdc012,     #拨入库位
         sfdc013              LIKE sfdc_t.sfdc013      #拨入储位
                             END RECORD
   DEFINE g_sfdc01_d          DYNAMIC ARRAY OF type_g_sfdc01_d
   DEFINE g_sfdc01_d_t        type_g_sfdc01_d

#-->step 2
   TYPE type_g_asfp370_02_m        RECORD
          chief_default  LIKE type_t.chr1   #input从料件主要仓库拨出
          END RECORD
   DEFINE g_asfp370_02_m        type_g_asfp370_02_m

   DEFINE g_wc_02               STRING

   TYPE type_g_sfdc02_d        RECORD
         sfdc004              LIKE sfdc_t.sfdc004,     #需求料号
         sfdc004_desc         LIKE type_t.chr80,       #品名
         sfdc004_desc_desc    LIKE type_t.chr80,       #规格
         sfdc005              LIKE sfdc_t.sfdc005,     #特征
         sfdc006              LIKE sfdc_t.sfdc006,     #单位
         sfdc007              LIKE sfdc_t.sfdc007,     #申请数量
         inag008              LIKE inag_t.inag008,     #库存数量
         diff                 LIKE sfdc_t.sfdc007,     #差异数量
         sfdc009              LIKE sfdc_t.sfdc009,     #参考单位
         sfdc010              LIKE sfdc_t.sfdc010,     #参考单位申请数量
         inag025              LIKE inag_t.inag025,     #参考单位库存数量
         diffr                LIKE sfdc_t.sfdc010,     #参考单位差异数量
         sfdc012              LIKE sfdc_t.sfdc012,     #拨入库位
         sfdc013              LIKE sfdc_t.sfdc013,     #拨入储位
         sum_qty              LIKE sfdc_t.sfdc007,     #拟拨入数量合计
         sum_qtyr             LIKE sfdc_t.sfdc010      #拟拨入参考数量合计
                             END RECORD
   DEFINE g_sfdc02_d          DYNAMIC ARRAY OF type_g_sfdc02_d
   DEFINE g_sfdc02_d_t        type_g_sfdc02_d
   DEFINE g_sfdc02_d_o        type_g_sfdc02_d
   DEFINE g_sfdc02_l          type_g_sfdc02_d

   TYPE type_g_inag_d        RECORD
         sel                  LIKE type_t.chr1,        #选择
         seq                  LIKE type_t.num5,        #项次
         inag004              LIKE inag_t.inag004,     #拨出库位
         inag004_desc         LIKE type_t.chr80,       #库位名称
         inag005              LIKE inag_t.inag005,     #拨出储位
         inag005_desc         LIKE type_t.chr80,       #储位名称
         inag006              LIKE inag_t.inag006,     #拨出批号
         inag003              LIKE inag_t.inag003,     #库存管理特征
         inag007              LIKE inag_t.inag007,     #单位
         inag008              LIKE inag_t.inag008,     #库存数量
         inag024              LIKE inag_t.inag024,     #参考单位
         inag025              LIKE inag_t.inag025,     #参考单位库存数量
         pack                 LIKE imaa_t.imaa001,     #包装容器
         qty                  LIKE inag_t.inag008,     #拨出数量
         qtyr                 LIKE inag_t.inag025      #拨出参考数量
                             END RECORD
   DEFINE g_inag_d          DYNAMIC ARRAY OF type_g_inag_d
   DEFINE g_inag_d_t        type_g_inag_d
   DEFINE g_inag_d_o        type_g_inag_d
   DEFINE g_inag_l          type_g_inag_d

   TYPE type_g_inai_d        RECORD
         sel                  LIKE type_t.chr1,        #选择
         seq                  LIKE type_t.num5,        #项次
         seq1                 LIKE type_t.num5,        #项序
         inai007              LIKE inai_t.inai007,     #制造序号
         inai008              LIKE inai_t.inai008,     #制造批号
         inai012              LIKE inai_t.inai012,     #制造日期
         inai010              LIKE inai_t.inai010,     #库存数量
         qty                  LIKE inai_t.inai010      #拨出数量
                             END RECORD
   DEFINE g_inai_d          DYNAMIC ARRAY OF type_g_inai_d
   DEFINE g_inai_d_t        type_g_inai_d
   DEFINE g_inai_d_o        type_g_inai_d
   DEFINE g_inai_l          type_g_inai_d

#-->step 3
 type type_g_asfp370_03_m        RECORD
       indcdocno      LIKE indc_t.indcdocno,  #input
       indcdocno_desc LIKE type_t.chr80,      #input
       indcdocdt      LIKE indc_t.indcdocdt,  #input
       post           LIKE type_t.chr1,       #input
       indcent_03     LIKE indc_t.indcent,    #key
       indcdocno_03   LIKE indc_t.indcdocno,  #key show
       indcdocdt_03   LIKE indc_t.indcdocdt   #show
       END RECORD
DEFINE g_asfp370_03_m        type_g_asfp370_03_m

 TYPE type_g_indd_d        RECORD
       inddseq         LIKE indd_t.inddseq, 
       indd002         LIKE indd_t.indd002, 
       indd002_03_desc LIKE type_t.chr500, 
       indd002_03_desc_desc LIKE type_t.chr500, 
       indd004         LIKE indd_t.indd004, 
       indd102         LIKE indd_t.indd102, 
       indd022         LIKE indd_t.indd022, 
       indd022_03_desc LIKE type_t.chr500, 
       indd023         LIKE indd_t.indd023, 
       indd023_03_desc LIKE type_t.chr500, 
       indd024         LIKE indd_t.indd024, 
       indd006         LIKE indd_t.indd006, 
       indd103         LIKE indd_t.indd103, 
       indd021         LIKE indd_t.indd021, 
       indd104         LIKE indd_t.indd104, 
       indd105         LIKE indd_t.indd105, 
       indd106         LIKE indd_t.indd106, 
       indd151         LIKE indd_t.indd151, 
       indd032         LIKE indd_t.indd032, 
       indd032_03_desc LIKE type_t.chr500, 
       indd033         LIKE indd_t.indd033, 
       indd033_03_desc LIKE type_t.chr500, 
       indd031         LIKE indd_t.indd031, 
       indd109         LIKE indd_t.indd109, 
       indd040         LIKE indd_t.indd040, 
       indd152         LIKE indd_t.indd152
       END RECORD
DEFINE g_indd_d          DYNAMIC ARRAY OF type_g_indd_d
DEFINE g_indd_d_t        type_g_indd_d
END GLOBALS
