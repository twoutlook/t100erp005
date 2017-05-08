SCHEMA ds

GLOBALS
   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_i35002      STRING             #單身QBE條件
   DEFINE g_d_idx_i35002    LIKE type_t.num5   #單身所在筆數
   DEFINE g_d_cnt_i35002    LIKE type_t.num5   #單身總筆數
   DEFINE g_pmaa027_d       LIKE pmaa_t.pmaa027
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
END GLOBALS
