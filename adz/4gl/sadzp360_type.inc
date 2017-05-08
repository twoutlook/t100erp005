
SCHEMA ds

PUBLIC TYPE T_ARGUMENTS RECORD
              a_args1   VARCHAR(30)
            END RECORD

PUBLIC TYPE T_APS_TABLE_LIST RECORD
              atl_TABLE_NAME  VARCHAR(30)
            END RECORD

PUBLIC TYPE T_FILE_DIALOG RECORD
              PATH       VARCHAR(1024),
              TYPE_DESC  VARCHAR(1024),
              TYPE_LIST  VARCHAR(50),
              CAPTION    VARCHAR(1024)
            END RECORD             

PUBLIC TYPE T_PUT_GET_FILE_PARA RECORD
              SERVER_FILE_PATH  VARCHAR(1024),
              SERVER_FILE_NAME  VARCHAR(1024),
              CLIENT_FILE_PATH  VARCHAR(1024),
              CLIENT_FILE_NAME  VARCHAR(1024)
            END RECORD                         

PUBLIC TYPE T_EXPORT_INFO RECORD
              WORKING_PATH  VARCHAR(1024),
              TAR_NAME      VARCHAR(1024),
              CLIENT_PATH   VARCHAR(1024),
              RESULT        BOOLEAN   
            END RECORD       
            