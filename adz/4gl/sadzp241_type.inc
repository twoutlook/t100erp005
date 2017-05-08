
SCHEMA ds

PUBLIC TYPE T_ARGUMENTS RECORD
              a_GUID                     VARCHAR(60),
              a_path                     VARCHAR(1024),
              a_refresh_cust_std_section VARCHAR(1) 
            END RECORD

PUBLIC TYPE T_ERROR_TABLES RECORD
              gt_TABLE_NAME   VARCHAR(30)
            END RECORD
        
PUBLIC TYPE T_INVALID_OWNER RECORD
              ir_NAME  VARCHAR(30)
            END RECORD 
            