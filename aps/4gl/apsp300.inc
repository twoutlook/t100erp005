SCHEMA ds

GLOBALS
   DEFINE g_setting            RECORD
                               choice1 LIKE type_t.chr1,
                               choice2 LIKE type_t.chr1,
                               choice3 LIKE type_t.chr1,
                               choice4 LIKE type_t.chr1,
                               choice5 LIKE type_t.chr1,
                               choice6 LIKE ooba_t.ooba002,
                               choice7 LIKE type_t.chr1, 
                               choice8 LIKE type_t.chr1     #160512-00016#1 20160524 add by ming 
                               END RECORD
   DEFINE g_sfaadocno          LIKE sfaa_t.sfaadocno
   DEFINE g_sfaadocdt          LIKE sfaa_t.sfaadocdt
   DEFINE g_wc                 STRING
   #170214-00009#1-s-mark  
   #因Link問題，將此段移至apsp300_03中
   #TYPE type_g_sfaa_d          RECORD
   #                            keyno              LIKE type_t.num5,
   #                            sfaa005            LIKE sfaa_t.sfaa005,
   #                            sfaa006            LIKE sfaa_t.sfaa006,
   #                            sfaa007            LIKE sfaa_t.sfaa007,
   #                            sfaa010            LIKE sfaa_t.sfaa010,
   #                            sfaa011            LIKE sfaa_t.sfaa011,
   #                            sfaa010_desc       LIKE type_t.chr500,
   #                            sfaa010_desc_desc  LIKE type_t.chr500,
   #                            sfac006            LIKE sfac_t.sfac006,
   #                            sfac006_desc       LIKE imefl_t.imefl005, 
   #                            sfaa072            LIKE sfaa_t.sfaa072,   #160512-00016#1 20160524 add by ming 
   #                            sfaa012            LIKE sfaa_t.sfaa012,
   #                            sfaa013            LIKE sfaa_t.sfaa013,
   #                            sfaa013_desc       LIKE type_t.chr500,
   #                            sfaa019            LIKE sfaa_t.sfaa019,
   #                            sfaa020            LIKE sfaa_t.sfaa020
   #                            END RECORD
   #170214-00009#1-e-mark
   TYPE type_g_psab_d          RECORD
                                  keyno             LIKE type_t.num5,
                                  psabdocno         LIKE psab_t.psabdocno,
                                  psabseq           LIKE psab_t.psabseq,
                                  psab001           LIKE psab_t.psab001,
                                  psab012           LIKE psab_t.psab012,
                                  psab001_desc      LIKE imaal_t.imaal003,
                                  psab001_desc_desc LIKE imaal_t.imaal004,
                                  psab002           LIKE psab_t.psab002,
                                  psab002_desc      LIKE imefl_t.imefl005, 
                                  psab013           LIKE psab_t.psab013, #160512-00016#1 20160524 add by ming 
                                  psab005           LIKE psab_t.psab005,
                                  psab004           LIKE psab_t.psab004,
                                  psab004_desc      LIKE type_t.chr500,
                                  qty               LIKE psab_t.psab005,
                                  psab003           LIKE psab_t.psab003
                               END RECORD
   #170214-00009#1-s-mark  
   #因Link問題，將此段移至apsp300_03中
   #DEFINE g_sfaa_d             DYNAMIC ARRAY OF type_g_sfaa_d
   #DEFINE g_sfaa_d_t           type_g_sfaa_d
   #170214-00009#1-e-mark  
   DEFINE g_psab_d             DYNAMIC ARRAY OF type_g_psab_d
   DEFINE g_psab_d_t           type_g_psab_d
   DEFINE go_dnd               ui.DragDrop
   DEFINE drag_source          STRING
   DEFINE drag_index           INTEGER
   DEFINE drop_index           INTEGER
   DEFINE drag_value           STRING
   DEFINE ls_group_id          STRING
END GLOBALS
