SCHEMA ds

GLOBALS

   DEFINE g_wc_01               STRING
   
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
END GLOBALS
