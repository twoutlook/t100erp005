
SCHEMA ds

PRIVATE TYPE T_DZEE_T_SCR RECORD 
                CHECKBOX   VARCHAR(1),
                DZEE001    LIKE DZEE_T.DZEE001,
                DZEE002    LIKE DZEE_T.DZEE002,
                DZEE003    LIKE DZEE_T.DZEE003,
                DZEE004    LIKE DZEE_T.DZEE004,
                DZEE005    LIKE DZEE_T.DZEE005,
                DZEE006    LIKE DZEE_T.DZEE006,
                DZEE007    LIKE DZEE_T.DZEE007,
                DZEE008    LIKE DZEE_T.DZEE008,
                DZEECOST   VARCHAR(10),
                DZEE009    LIKE DZEE_T.DZEE009,
                DZEE010    LIKE DZEE_T.DZEE010,
                DZEE011    LIKE DZEE_T.DZEE011
             END RECORD

PRIVATE TYPE T_DZEE_T_SCR_COLOR RECORD 
                CHECKBOX   STRING,
                DZEE001    STRING,
                DZEE002    STRING,
                DZEE003    STRING,
                DZEE004    STRING,
                DZEE005    STRING,
                DZEE006    STRING,
                DZEE007    STRING,
                DZEE008    STRING,
                DZEECOST   STRING,
                DZEE009    STRING,
                DZEE010    STRING,
                DZEE011    STRING
             END RECORD
             
PRIVATE TYPE T_DZEZ_T_SCR RECORD 
                STATUS   VARCHAR(1),
                DZEZ001  LIKE DZEZ_T.DZEZ001,
                DZEZ007  LIKE DZEZ_T.DZEZ007,
                DZEZ002  LIKE DZEZ_T.DZEZ002,
                DZEZ003  LIKE DZEZ_T.DZEZ003,
                DZEZ004  LIKE DZEZ_T.DZEZ004,
                DZEZ005  LIKE DZEZ_T.DZEZ005,
                DZEZ006  LIKE DZEZ_T.DZEZ006,
                DZEZCOST VARCHAR(10)
             END RECORD

PRIVATE TYPE T_DZEZ_T_SCR_COLOR RECORD 
                STATUS   STRING,
                DZEZ001  STRING,
                DZEZ007  STRING,
                DZEZ002  STRING,
                DZEZ003  STRING,
                DZEZ004  STRING,
                DZEZ005  STRING,
                DZEZ006  STRING,
                DZEZCOST STRING
             END RECORD

PRIVATE TYPE T_BACKUP_TABLE_SCR RECORD 
                STATUS   VARCHAR(1),
                TABLES   VARCHAR(30)
             END RECORD

PRIVATE TYPE T_CUST_TABLE_SCR RECORD 
                STATUS   VARCHAR(1),
                TABLES   VARCHAR(30)
             END RECORD

PRIVATE TYPE T_STATISTICS_SCR RECORD 
               TABLE_COUNT                  INTEGER,
               SPLIT                        INTEGER,
               TABLE_PER_PACK               INTEGER,
               START_TIME                   VARCHAR(50),
               END_TIME                     VARCHAR(50),
               MAX_TIME                     VARCHAR(50),
               SINGLE_TABLE_MAX_USING_TIME  VARCHAR(50)
             END RECORD
             
PUBLIC TYPE T_DB_CONNSTR RECORD
              db_source        VARCHAR(20),
              db_username      VARCHAR(20),
              db_password      VARCHAR(20),
              db_schema        VARCHAR(20),
              db_sid           VARCHAR(20),
              db_sql_filename  VARCHAR(150),
              db_version       VARCHAR(50)
            END RECORD
            
PUBLIC TYPE T_DB_INFO RECORD
                        DB_NAME   VARCHAR(200),
                        USER_NAME VARCHAR(200)
                      END RECORD

PUBLIC TYPE T_PARAMETERS RECORD
              PARAMETER1 VARCHAR(100),
              PARAMETER2 VARCHAR(100),
              PARAMETER3 VARCHAR(100),
              PARAMETER4 VARCHAR(100),
              PARAMETER5 VARCHAR(100)
            END RECORD

PUBLIC TYPE T_ARGUMENTS RECORD
              a_GUID   VARCHAR(60),
              a_mode   VARCHAR(1024)
            END RECORD
            
