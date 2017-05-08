SCHEMA ds

GLOBALS
   TYPE type_step01 RECORD
             chk          LIKE type_t.chr1,
             gzzz001 LIKE gzzz_t.gzzz001,
             gzzal003 LIKE gzzal_t.gzzal003,
             gzzz005 LIKE gzzz_t.gzzz005
              END RECORD
   TYPE type_step02 RECORD
             chk           LIKE type_t.chr1,
             dzea001 LIKE dzea_t.dzea001,
             dzea001_desc LIKE dzeal_t.dzeal003,
             gzza001 LIKE gzza_t.gzza001,
             gzza001_desc  LIKE gzzal_t.gzzal003,
             gzde001 LIKE gzde_t.gzde001
              END RECORD
   TYPE type_step03 RECORD
             dzea001 LIKE dzea_t.dzea001,
             dzea001_desc LIKE dzeal_t.dzeal003,
             reason STRING
              END RECORD
   TYPE type_step04 RECORD
             dzea001 LIKE dzea_t.dzea001,
             dzea001_desc LIKE dzeal_t.dzeal003,
             cnt LIKE type_t.num10
              END RECORD
   TYPE type_step05 RECORD
             dzea001 LIKE dzea_t.dzea001,
             dzea001_desc LIKE dzeal_t.dzeal003,
             cnt LIKE type_t.num10
              END RECORD

   DEFINE gs_step1_wc   STRING
   DEFINE gs_step2_wc  STRING
   DEFINE g_step01  DYNAMIC ARRAY OF type_step01
   DEFINE g_step02 DYNAMIC ARRAY OF type_step02
   DEFINE g_step03 DYNAMIC ARRAY OF type_step03
   DEFINE g_step03_2 DYNAMIC ARRAY OF type_step03
   DEFINE g_step04 DYNAMIC ARRAY OF type_step04
   DEFINE g_step05 DYNAMIC ARRAY OF type_step05
   DEFINE g_expent  LIKE gzou_t.gzou001   #匯出企業
   DEFINE g_impent  LIKE gzou_t.gzou001  #匯入企業
   DEFINE g_exppath STRING  #匯出路徑
   DEFINE g_imppath STRING  #匯入路徑
   DEFINE g_nondata STRING  #無資料表
END GLOBALS
