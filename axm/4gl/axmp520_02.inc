SCHEMA ds

GLOBALS
DEFINE g_detail_02_idx          LIKE type_t.num5
DEFINE g_detail2_02_idx        LIKE type_t.num5
DEFINE g_detail3_02_idx        LIKE type_t.num5
DEFINE g_detail4_02_idx        LIKE type_t.num5
DEFINE g_detail_02_cnt          LIKE type_t.num5
DEFINE g_detail2_02_cnt        LIKE type_t.num5
DEFINE g_detail3_02_cnt        LIKE type_t.num5
DEFINE g_detail4_02_cnt        LIKE type_t.num5          
DEFINE g_ref_fields                  DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列 
DEFINE g_rtn_fields                 DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gsuccess                      LIKE type_t.num5
DEFINE g_xmdkdocno           LIKE xmdk_t.xmdkdocno
DEFINE g_s_bas_0028         LIKE type_t.chr1
DEFINE g_s_bas_0036         LIKE type_t.chr1
DEFINE g_s_bas_0007         LIKE type_t.chr1
END GLOBALS
