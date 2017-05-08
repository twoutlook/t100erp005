SCHEMA ds

GLOBALS
   DEFINE g_apsp610_03_input     RECORD
                                    sscb01                 LIKE type_t.chr10, 
                                    p610_03_chk01 LIKE type_t.chr1 
                                 END RECORD   
   DEFINE g_d_cnt_p61003_01      LIKE type_t.num5
   DEFINE g_appoint_idx          LIKE type_t.num5
   DEFINE g_d_idx_p61003_01      LIKE type_t.num5
   DEFINE g_d_cnt_p61003_02      LIKE type_t.num5
   DEFINE g_d_idx_p61003_02      LIKE type_t.num5
   DEFINE g_d_cnt_p61003_03      LIKE type_t.num5
   DEFINE g_d_idx_p61003_03      LIKE type_t.num5   
   DEFINE g_d_cnt_p61003_04      LIKE type_t.num5   
   DEFINE g_d_idx_p61003_04      LIKE type_t.num5
END GLOBALS
