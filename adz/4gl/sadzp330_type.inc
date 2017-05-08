
SCHEMA ds

PUBLIC TYPE T_ARGUMENTS RECORD
              a_TABLE_NAME   VARCHAR(30)
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

PUBLIC TYPE T_DB_COXN_STR RECORD
              db_sid           VARCHAR(100),
              db_db_name       VARCHAR(100),
              db_username      VARCHAR(100),
              db_password      VARCHAR(100),
              db_db_link       VARCHAR(100),
              db_sql_filename  VARCHAR(1024)
            END RECORD

PUBLIC TYPE T_DB_INFO RECORD
              DB_NAME   VARCHAR(200),
              USER_NAME VARCHAR(200)
            END RECORD

PUBLIC TYPE T_GRANT_TABLES RECORD
              gt_TABLE_NAME   VARCHAR(30)
            END RECORD
        
PUBLIC TYPE T_INVALID_OWNER RECORD
              ir_NAME  VARCHAR(30)
            END RECORD 
            