
PUBLIC TYPE T_DZLM_TABLE_LIST RECORD 
               dtl_WORK_TYPE	   VARCHAR(10),
               dtl_DZLM001	     VARCHAR(10),
               dtl_DZLM002	     VARCHAR(20),
               dtl_DZLM005	     VARCHAR(10),
               dtl_DZLM006	     VARCHAR(10),
               dtl_DZLM012	     VARCHAR(20),
               dtl_DZLM015	     VARCHAR(40),
               dtl_MODULE        VARCHAR(10),
               dtl_TABLE_TYPE    VARCHAR(10),
               dtl_TAR_NAME      VARCHAR(100),
               dtl_TAR_PATH      VARCHAR(250),
               dtl_TAR_FULL_NAME VARCHAR(500)
             END RECORD

PUBLIC TYPE T_PATCH_REQUEST_INFO RECORD 
               REQUEST_NO	  VARCHAR(50),
               REQUEST_SEQ  INTEGER
             END RECORD

PUBLIC TYPE T_TABLE_LIST RECORD
              tl_TABLE_NAME VARCHAR(50)
            END RECORD
            
PUBLIC TYPE T_TAR_LIST RECORD
              tl_SEQ_NO   INTEGER,
              tl_TAR_NAME VARCHAR(50)
            END RECORD

PUBLIC TYPE T_ARGUMENT_LIST RECORD
              al_STATUS    VARCHAR(2),
              al_SEQUENCE  VARCHAR(40),
              al_CATEGORY  VARCHAR(40), 
              al_TYPES     VARCHAR(500),
              al_CODE      VARCHAR(80)
            END RECORD             
            
PUBLIC TYPE T_DZEE_T RECORD
              DZEE001 LIKE DZEE_T.DZEE001,
              DZEE002 LIKE DZEE_T.DZEE002,
              DZEE003 LIKE DZEE_T.DZEE003,
              DZEE004 LIKE DZEE_T.DZEE004,
              DZEE005 LIKE DZEE_T.DZEE005,
              DZEE006 LIKE DZEE_T.DZEE006,
              DZEE007 LIKE DZEE_T.DZEE007,
              DZEE008 LIKE DZEE_T.DZEE008,
              DZEE009 LIKE DZEE_T.DZEE009,
              DZEE010 LIKE DZEE_T.DZEE010,
              DZEE011 LIKE DZEE_T.DZEE011
            END RECORD  
            
PUBLIC TYPE T_DZEZ_T RECORD
              DZEZ001 LIKE DZEZ_T.DZEZ001,
              DZEZ002 LIKE DZEZ_T.DZEZ002,
              DZEZ003 LIKE DZEZ_T.DZEZ003,
              DZEZ004 LIKE DZEZ_T.DZEZ004,
              DZEZ005 LIKE DZEZ_T.DZEZ005,
              DZEZ006 LIKE DZEZ_T.DZEZ006,
              DZEZ007 LIKE DZEZ_T.DZEZ007
            END RECORD  

PUBLIC TYPE T_MULTI_LANG_TABLES RECORD
              mlt_TABLE_NAME  VARCHAR(50),
              mlt_MODULE_NAME VARCHAR(10)
            END RECORD 
            