SCHEMA ds

GLOBALS
   DEFINE g_apmp490_02_input     RECORD
                                    scb01     LIKE type_t.chr10,
                                    scb02     LIKE type_t.chr10,
                                    bt01      LIKE type_t.chr10,
                                    bt01_desc LIKE type_t.chr80,
                                    ed01      LIKE type_t.chr10,
                                    scb03     LIKE type_t.chr10
                                 END RECORD
   DEFINE g_d_cnt_p49002_01      LIKE type_t.num5
   DEFINE g_appoint_idx          LIKE type_t.num5
   DEFINE g_d_idx_p49002_01      LIKE type_t.num5
   DEFINE g_d_cnt_p49002_02      LIKE type_t.num5
   DEFINE g_d_idx_p49002_02      LIKE type_t.num5
   DEFINE g_d_cnt_p49002_03      LIKE type_t.num5
   DEFINE g_d_idx_p49002_03      LIKE type_t.num5
   DEFINE g_d_cnt_p49002_04      LIKE type_t.num5
   DEFINE g_d_idx_p49002_04      LIKE type_t.num5
END GLOBALS 
