SCHEMA ds

GLOBALS
   DEFINE g_setting            RECORD
                               choice1 LIKE type_t.chr1,
                               choice2 LIKE type_t.chr1,
                               choice3 LIKE type_t.chr1,
                               choice4 LIKE type_t.chr1,
                               choice5 LIKE type_t.chr1,
                               choice6 LIKE type_t.chr1,
                               choice7 LIKE type_t.chr1,
                               choice8 LIKE ooba_t.ooba002,
                               choice9 LIKE type_t.chr1
                               END RECORD
   DEFINE g_sfaadocno          LIKE sfaa_t.sfaadocno
   DEFINE g_sfaadocdt          LIKE sfaa_t.sfaadocdt
   DEFINE g_wc                 STRING
   TYPE type_g_sfaa_d          RECORD
                               keyno              LIKE type_t.num5,
                               sfaa005            LIKE sfaa_t.sfaa005,
                               sfaa006            LIKE sfaa_t.sfaa006,
                               sfaa007            LIKE sfaa_t.sfaa007,
                               sfaa008            LIKE sfaa_t.sfaa008,
                               sfaa063            LIKE sfaa_t.sfaa063,
                               sfaa009            LIKE sfaa_t.sfaa009,
                               sfaa009_desc       LIKE type_t.chr500,
                               sfaa010            LIKE sfaa_t.sfaa010,
                               sfaa011            LIKE sfaa_t.sfaa011,
                               sfaa010_desc       LIKE type_t.chr500,
                               sfaa010_desc_desc  LIKE type_t.chr500,
                               sfac006            LIKE sfac_t.sfac006,
                               sfac006_desc       LIKE imefl_t.imefl005,
                               sfaa012            LIKE sfaa_t.sfaa012,
                               sfaa013            LIKE sfaa_t.sfaa013,
                               sfaa013_desc       LIKE type_t.chr500,
                               sfaa019            LIKE sfaa_t.sfaa019,
                               sfaa020            LIKE sfaa_t.sfaa020
                               END RECORD

   TYPE type_g_xmdd_d          RECORD
                               keyno              LIKE type_t.num5,
                               xmdddocno          LIKE xmdd_t.xmdddocno,
                               xmddseq            LIKE xmdd_t.xmddseq,
                               xmddseq1           LIKE xmdd_t.xmddseq1,
                               xmddseq2           LIKE xmdd_t.xmddseq2,
                               xmda004            LIKE xmda_t.xmda004,
                               xmda004_desc       LIKE type_t.chr500,
                               xmdd001            LIKE xmdd_t.xmdd001,
                               xmdd040            LIKE xmdd_t.xmdd040,
                               xmdd001_desc       LIKE imaal_t.imaal003,
                               xmdd001_desc_desc  LIKE imaal_t.imaal004,
                               xmdd002            LIKE xmdd_t.xmdd002,
                               xmdd002_desc       LIKE imefl_t.imefl005,
                               xmdd006            LIKE xmdd_t.xmdd006,
                               xmdd004            LIKE xmdd_t.xmdd004,
                               xmdd004_desc       LIKE type_t.chr500,
                               qty                LIKE xmdd_t.xmdd006,
                               xmdd011            LIKE xmdd_t.xmdd011
                               END RECORD

   DEFINE g_sfaa_d             DYNAMIC ARRAY OF type_g_sfaa_d
   DEFINE g_sfaa_d_t           type_g_sfaa_d
   DEFINE g_xmdd_d             DYNAMIC ARRAY OF type_g_xmdd_d
   DEFINE g_xmdd_d_t           type_g_xmdd_d
   DEFINE go_dnd               ui.DragDrop
   DEFINE drag_source          STRING
   DEFINE drag_index           INTEGER
   DEFINE drop_index           INTEGER
   DEFINE drag_value           STRING
   DEFINE ls_group_id          STRING
END GLOBALS
