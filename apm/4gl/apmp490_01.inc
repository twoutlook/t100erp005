SCHEMA ds

GLOBALS
   DEFINE g_apmp490_01_input     RECORD
                                    pmdldocno      LIKE pmdl_t.pmdldocno,
                                    pmdldocno_desc LIKE type_t.chr80,
                                    imaf142        LIKE imaf_t.imaf142,
                                    imaf142_desc   LIKE type_t.chr80,
                                    cb01           LIKE type_t.chr1
                                 END RECORD
   DEFINE g_apmp490_01_wc        STRING
   DEFINE g_d_cnt_p49001         LIKE type_t.num5
   DEFINE g_appoint_idx          LIKE type_t.num5   #指定進入單身行數
   DEFINE g_d_idx_p49001         LIKE type_t.num5   #單身所在筆數

   DEFINE g_apmp490_01_ooef004   LIKE ooef_t.ooef004
   DEFINE g_apmp490_01_pmdl      RECORD LIKE pmdl_t.*

   DEFINE g_pmdadocno            LIKE pmda_t.pmdadocno
   DEFINE g_pmdadocdt            LIKE pmda_t.pmdadocdt
   DEFINE g_pmdb030              LIKE pmdb_t.pmdb030
   DEFINE g_pmdb004              LIKE pmdb_t.pmdb004
   DEFINE g_imaf153              LIKE imaf_t.imaf153
   DEFINE g_imaf141              LIKE imaf_t.imaf141
   DEFINE g_controlno            LIKE ooha_t.ooha001     #控制組編號  

   DEFINE g_budget_control       LIKE type_t.chr1        #是否走預算控制
   DEFINE g_pmdldocno_t          LIKE pmdl_t.pmdldocno   #記錄單別
END GLOBALS
