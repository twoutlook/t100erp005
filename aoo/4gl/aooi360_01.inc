SCHEMA ds

GLOBALS
   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_i36001      STRING             #單身QBE條件
   DEFINE g_d_idx_i36001    LIKE type_t.num5   #單身所在筆數
   DEFINE g_d_cnt_i36001    LIKE type_t.num5   #單身總筆數
   #備註類型:1.人員備註2.客商備註3.料號備註4.BOM單頭備註5.BO單身備註6.單據單頭備註
   #7.單據單身備註8.製程料號單頭備註9.製程料號單身備註
   DEFINE g_ooff001_d       LIKE ooff_t.ooff001
   DEFINE g_ooff002_d       LIKE ooff_t.ooff002   #第一Key值
   DEFINE g_ooff003_d       LIKE ooff_t.ooff003   #第二Key值
   DEFINE g_ooff004_d       LIKE ooff_t.ooff004   #第三Key值
   DEFINE g_ooff005_d       LIKE ooff_t.ooff005   #第四Key值
   DEFINE g_ooff006_d       LIKE ooff_t.ooff006   #第五Key值
   DEFINE g_ooff007_d       LIKE ooff_t.ooff007   #第六Key值
   DEFINE g_ooff008_d       LIKE ooff_t.ooff008   #第七Key值
   DEFINE g_ooff009_d       LIKE ooff_t.ooff009   #第八Key值
   DEFINE g_ooff010_d       LIKE ooff_t.ooff010   #第九Key值
   DEFINE g_ooff011_d       LIKE ooff_t.ooff011   #第十Key值
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
   DEFINE g_loc             LIKE type_t.chr5   #判斷游標所在位置
END GLOBALS

