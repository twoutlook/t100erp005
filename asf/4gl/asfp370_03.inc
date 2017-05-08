SCHEMA ds

GLOBALS

#單頭 type 宣告
 type type_g_asfp370_03_m        RECORD
       indcdocno      LIKE indc_t.indcdocno,  #input
       indcdocno_desc LIKE type_t.chr80,      #input
       indcdocdt      LIKE indc_t.indcdocdt,  #input
       indcent_03     LIKE indc_t.indcent,    #key
       indcdocno_03   LIKE indc_t.indcdocno,  #key show
       indcdocdt_03   LIKE indc_t.indcdocdt   #show
       END RECORD
DEFINE g_asfp370_03_m        type_g_asfp370_03_m

END GLOBALS
