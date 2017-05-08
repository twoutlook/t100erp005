SCHEMA ds

GLOBALS
   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_t10002      STRING             #單身QBE條件
   DEFINE g_d_idx_t10002    LIKE type_t.num5   #單身所在筆數
   DEFINE g_d_cnt_t10002    LIKE type_t.num5   #單身總筆數
   DEFINE g_pmbadocno_d     LIKE pmba_t.pmbadocno
   DEFINE g_pmba001_d       LIKE pmba_t.pmba001
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
   DEFINE g_loc             LIKE type_t.chr5   #判斷游標所在位置
END GLOBALS
