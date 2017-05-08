SCHEMA ds

GLOBALS
DEFINE g_wc                      STRING
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail_cnt         LIKE type_t.num5
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500)      #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500)     #ap_ref用陣列
DEFINE g_current_page   LIKE type_t.num5                                         #目前所在頁數
DEFINE g_mode                LIKE type_t.chr10                   #資料輸入模式：d刪資底稿
DEFINE g_xmdg_m        RECORD
                            xmdgdocno              LIKE xmdg_t.xmdgdocno,
                            xmdgdocno_desc    LIKE type_t.chr80,
                            xmdg002                    LIKE xmdg_t.xmdg002,
                            xmdg002_desc          LIKE type_t.chr80,
                            xmdgdocdt                LIKE xmdg_t.xmdgdocdt
                     END RECORD

END GLOBALS
