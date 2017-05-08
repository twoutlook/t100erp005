SCHEMA ds

GLOBALS
DEFINE g_wc                      STRING
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail_cnt         LIKE type_t.num5
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500)      #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500)     #ap_ref用陣列
DEFINE g_rec_b            LIKE type_t.num10 

DEFINE g_input  RECORD
                    sfma001   LIKE sfma_t.sfma001,            #分攤方式
                    sfeadocdt LIKE sfea_t.sfeadocdt,         #入庫日期
                    sfeadocno LIKE sfea_t.sfeadocno,       #入庫單別
                    l_sdt      LIKE sfea_t.sfeadocdt,               #分攤起日期
                    l_edt     LIKE sfea_t.sfeadocdt,               #分攤迄日期
                    l_wo_type LIKE type_t.num5,                #工單類型 1一般工單2委外工單
                   pmds007  LIKE pmds_t.pmds007,        #供應商 
                    sfba003   LIKE sfba_t.sfba003,             #作業編號
                   sfba004   LIKE sfba_t.sfba004               #作業序
END RECORD

END GLOBALS
