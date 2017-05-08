SCHEMA ds

GLOBALS
   DEFINE g_apmp490_03_input     RECORD
                                    sscb01                 LIKE type_t.chr10, 
                                    p490_03_chk01 LIKE type_t.chr1 
                                 END RECORD   
   DEFINE g_d_cnt_p49003_01      LIKE type_t.num5
   DEFINE g_appoint_idx          LIKE type_t.num5
   DEFINE g_d_idx_p49003_01      LIKE type_t.num5
   DEFINE g_d_cnt_p49003_02      LIKE type_t.num5
   DEFINE g_d_idx_p49003_02      LIKE type_t.num5
   DEFINE g_d_cnt_p49003_03      LIKE type_t.num5
   DEFINE g_d_idx_p49003_03      LIKE type_t.num5   
   DEFINE g_d_cnt_p49003_04      LIKE type_t.num5   
   DEFINE g_d_idx_p49003_04      LIKE type_t.num5
#150529-00010#1-s add
   DEFINE g_bmba     DYNAMIC ARRAY OF RECORD
          bmba001    LIKE bmba_t.bmba001,         #主件料號
          bmba002    LIKE bmba_t.bmba002,         #特性
          bmba003    LIKE bmba_t.bmba003,         #元件料號
          bmba004    LIKE bmba_t.bmba004,         #部位編號
          bmba005    DATETIME YEAR TO SECOND,     #生效日期時間
          bmba007    LIKE bmba_t.bmba007,         #作業編號
          bmba008    LIKE bmba_t.bmba008,         #作業序
          bmba035    LIKE bmba_t.bmba035,         #保稅否
          l_bmba011  LIKE bmba_t.bmba011,         #組成用量：QPA分子，对应于原始的主件料号
          l_bmba012  LIKE bmba_t.bmba012,         #主件底數：QPA分母，对应于原始的主件料号
          l_inam002  LIKE inam_t.inam002          #元件對應的產品特徵
                     END RECORD
#150529-00010#1-e add
END GLOBALS
