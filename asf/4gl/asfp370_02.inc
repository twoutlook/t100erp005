SCHEMA ds

GLOBALS
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

END GLOBALS
