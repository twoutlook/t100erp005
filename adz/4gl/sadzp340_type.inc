
SCHEMA ds

PUBLIC TYPE T_ARGUMENTS RECORD
              a_GUID   VARCHAR(60),
              a_path   VARCHAR(1024)
            END RECORD

PUBLIC TYPE T_SR_ADZP340 RECORD
              sa_tbl_path                 VARCHAR(1024),
              sa_merge_pkg_path           VARCHAR(1024),
              sa_refresh_cust_std_section VARCHAR(1)
            END RECORD
