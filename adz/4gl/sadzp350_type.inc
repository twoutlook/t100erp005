
SCHEMA ds

PUBLIC TYPE T_PARAMETERS RECORD
              PARAMETER1 VARCHAR(100),
              PARAMETER2 VARCHAR(100),
              PARAMETER3 VARCHAR(100),
              PARAMETER4 VARCHAR(100),
              PARAMETER5 VARCHAR(100)
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
            
PUBLIC TYPE T_ADZP350_ARGUMENTS RECORD
              a_source_working_type VARCHAR(10),
              a_source_design_name  VARCHAR(50),
              a_source_schema_name  VARCHAR(50),
              a_source_table_name   VARCHAR(50),
              a_source_file_name    VARCHAR(1024),
              a_dest_working_type   VARCHAR(10),
              a_dest_design_name    VARCHAR(50),
              a_dest_schema_name    VARCHAR(50),
              a_dest_table_name     VARCHAR(50),
              a_dest_file_name      VARCHAR(1024),
              a_exp_document_type   VARCHAR(10),
              a_send_to_client      BOOLEAN,
              a_GUI_mode            BOOLEAN,
              a_shipping_diff       BOOLEAN
            END RECORD

PUBLIC TYPE T_DIFF_PARAMETER RECORD
              dp_GUID                VARCHAR(50), 
              dp_source_working_type VARCHAR(50),
              dp_source_schema_name  VARCHAR(50),
              dp_source_table_name   VARCHAR(50),
              dp_dest_working_type   VARCHAR(50),
              dp_dest_schema_name    VARCHAR(50),
              dp_dest_table_name     VARCHAR(50)
            END RECORD
            
PUBLIC TYPE T_SCHEMA_INFORMATION RECORD
              si_TYPE         VARCHAR(50),
              si_SCHEMA_NAME  VARCHAR(50),
              si_TABLE_NAME   VARCHAR(50),
              si_COLUMN_NAME  VARCHAR(50),
              si_ISKEY        VARCHAR(02),
              si_NULLABLE     VARCHAR(02),
              si_DATA_TYPE    VARCHAR(200),
              si_DATA_LENGTH  INTEGER,
              si_COLUMN_ID    INTEGER          
            END RECORD            

PUBLIC TYPE T_TABLE_DIFF_INFO RECORD
              tdi_TABLE_NAME   VARCHAR(50),
              tdi_COLUMN_NAME  VARCHAR(50),
              tdi_ISKEY        VARCHAR(02),
              tdi_NULLABLE     VARCHAR(02),
              tdi_DATA_TYPE    VARCHAR(200),
              tdi_DATA_LENGTH  INTEGER
            END RECORD            
            
PUBLIC TYPE T_TABLE_TYPE_DIFF_INFO RECORD
              ttdi_TABLE_OWNER        VARCHAR(50),
              ttdi_TABLE_NAME         VARCHAR(50),
              ttdi_MODULE_NAME        VARCHAR(50),
              ttdi_DEFINE_TABLE_TYPE  VARCHAR(50),
              ttdi_REAL_TABLE_TYPE    VARCHAR(50)
            END RECORD
            
PUBLIC TYPE T_DZHG_T RECORD
              DZHG001 LIKE DZHG_T.DZHG001, --比對 GUID		
              DZHG002 LIKE DZHG_T.DZHG002, --來源或目的端
              DZHG003 LIKE DZHG_T.DZHG003, --DB或設計資料
              DZHG004 LIKE DZHG_T.DZHG004, --Schema名稱	
              DZHG005 LIKE DZHG_T.DZHG005, --表格名稱		
              DZHG006 LIKE DZHG_T.DZHG006, --欄位名稱		
              DZHG007 LIKE DZHG_T.DZHG007, --是否為鍵值	
              DZHG008 LIKE DZHG_T.DZHG008, --可否為空值	
              DZHG009 LIKE DZHG_T.DZHG009, --資料型態		
              DZHG010 LIKE DZHG_T.DZHG010, --資料長度		
              DZHG011 LIKE DZHG_T.DZHG011, --欄位識別碼	
              DZHG012 LIKE DZHG_T.DZHG012  --產生日期		
            END RECORD     

PUBLIC TYPE T_DIFF_RECORDS RECORD
              dr_SDZHG005 LIKE DZHG_T.DZHG005,
              dr_SDZHG006 LIKE DZHG_T.DZHG006,
              dr_SDZHG007 LIKE DZHG_T.DZHG007,
              dr_SDZHG008 LIKE DZHG_T.DZHG008,
              dr_SDZHG009 LIKE DZHG_T.DZHG009,
              dr_SDZHG010 LIKE DZHG_T.DZHG010,
              dr_DIFF     VARCHAR(10),
              dr_DDZHG005 LIKE DZHG_T.DZHG005,
              dr_DDZHG006 LIKE DZHG_T.DZHG006,
              dr_DDZHG007 LIKE DZHG_T.DZHG007,
              dr_DDZHG008 LIKE DZHG_T.DZHG008,
              dr_DDZHG009 LIKE DZHG_T.DZHG009,
              dr_DDZHG010 LIKE DZHG_T.DZHG010
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

PUBLIC TYPE T_LOST_TABLE RECORD
              TABLE_NAME  VARCHAR(30)
            END RECORD             
            
PUBLIC TYPE T_SYNONYM_DIFF_INFO RECORD
              SYNONYM_NAME  VARCHAR(30)
            END RECORD             
            