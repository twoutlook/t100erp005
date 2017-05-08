SCHEMA ds

GLOBALS
   DEFINE g_apsp610_01_input     RECORD
                                    psca001                  LIKE psca_t.psca001,
                                    psca001_desc        LIKE pscal_t.pscal003,
                                    pmdldocno            LIKE pmdl_t.pmdldocno,
                                    pmdldocno_desc  LIKE type_t.chr80,
                                    imaf142                   LIKE imaf_t.imaf142,
                                    imaf142_desc         LIKE type_t.chr80,
                                    cb01                          LIKE type_t.chr1
                                 END RECORD
   DEFINE g_apsp610_01_wc        STRING
   DEFINE g_d_cnt_p61001         LIKE type_t.num5
   DEFINE g_appoint_idx          LIKE type_t.num5   #指定進入單身行數
   DEFINE g_d_idx_p61001         LIKE type_t.num5   #單身所在筆數

   DEFINE g_apsp610_01_ooef004   LIKE ooef_t.ooef004

   DEFINE g_imae012              LIKE imae_t.imae012
   DEFINE g_pspc050              LIKE pspc_t.pspc050
   DEFINE g_pspc010              LIKE pspc_t.pspc010
   DEFINE g_pspc045              LIKE pspc_t.pspc045
   DEFINE g_imaa009              LIKE imaa_t.imaa009
   DEFINE g_imaf141               LIKE imaf_t.imaf141
   DEFINE g_controlno            LIKE ooha_t.ooha001     #控制組編號  

   DEFINE g_budget_control       LIKE type_t.chr1        #是否走預算控制
   DEFINE g_pmdldocno_t          LIKE pmdl_t.pmdldocno   #記錄單別

   DEFINE g_p610_pspc002     LIKE pspc_t.pspc002  #160608-00013#3 20160621 add by ming 

END GLOBALS
