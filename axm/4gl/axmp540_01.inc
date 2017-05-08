SCHEMA ds

GLOBALS
DEFINE g_wc                 STRING
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail2_idx        LIKE type_t.num5
DEFINE g_detail_cnt         LIKE type_t.num5
DEFINE g_detail2_cnt        LIKE type_t.num5
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_mode               LIKE type_t.chr10             #資料輸入模式：d刪資底稿
DEFINE g_xmdk_m        RECORD
                            xmdkdocno      LIKE xmdk_t.xmdkdocno,
                            xmdkdocno_desc LIKE type_t.chr80,
                            xmdk003        LIKE xmdk_t.xmdk003,
                            xmdk003_desc   LIKE type_t.chr80,
                            xmdkdocdt      LIKE xmdk_t.xmdkdocdt
                     END RECORD 

END GLOBALS
