
SCHEMA ds

PRIVATE TYPE T_DZIT_T_WL_H_SCR RECORD 
                RECORDTYPE VARCHAR(1),
                DZITSEQ    VARCHAR(4),
                DZIT001    LIKE DZIT_T.DZIT001,
                DZIT002    LIKE DZIT_T.DZIT002,
                DZIT003    LIKE DZIT_T.DZIT003,
                DZIT004    LIKE DZIT_T.DZIT004,
                DZIT009    LIKE DZIT_T.DZIT009,
                DZITL006   LIKE DZITL_T.DZITL006,
                DZLM008    LIKE DZLM_T.DZLM008,     #DGW07558_add_at20151230
                DZLM007    LIKE DZLM_T.DZLM007,     #DGW07558_add_at20151230
                OOAG011    LIKE OOAG_T.OOAG011,     #DGW07558_add_at20151230
                DZIT010    LIKE DZIT_T.DZIT010      #DGW07558_add_at20160216
             END RECORD

PRIVATE TYPE T_DZIT_T_WL_B_SCR RECORD 
               DZIT001    LIKE DZIT_T.DZIT001,
               DZIT002    LIKE DZIT_T.DZIT002,
               DZIT003    LIKE DZIT_T.DZIT003,
               DZIT004    LIKE DZIT_T.DZIT004, 
               DZIT005    LIKE DZIT_T.DZIT005,
               DZIT006    LIKE DZIT_T.DZIT006,
               DZIT007    LIKE DZIT_T.DZIT007,
               DZIT008    LIKE DZIT_T.DZIT008,
               DZIT009    LIKE DZIT_T.DZIT009,
               DZITL006   LIKE DZITL_T.DZITL006, 
               DZITL007   LIKE DZITL_T.DZITL007,
               DZITCRTID  LIKE DZIT_T.DZITCRTID,    # 20170104 circlelai
               DZITCRTDT  LIKE DZIT_T.DZITCRTDT,    # 20170104 circlelai
               DZITMODID  LIKE DZIT_T.DZITMODID,    # 20170104 circlelai
               DZITMODDT  LIKE DZIT_T.DZITMODDT,    # 20170104 circlelai
               DZITCRTID_DESC  VARCHAR(100),   # 20170104 circlelai
               DZITMODID_DESC  VARCHAR(100),   # 20170104 circlelai
               DZITCRT_SYNTAX  VARCHAR(1536),  # 新版trigger ,限制 script 的開頭語法 # 170210-00052#1 by circlelai
               DZITCRT_BODY    LIKE DZIT_T.DZIT011  # 新版trigger, script body # 170210-00052#1 by circlelai 
             END RECORD
             
PRIVATE TYPE T_DZIT_T_WL RECORD 
               DZIT001  LIKE DZIT_T.DZIT001,
               DZIT002  LIKE DZIT_T.DZIT002,
               DZIT003  LIKE DZIT_T.DZIT003,
               DZIT004  LIKE DZIT_T.DZIT004, 
               DZIT005  LIKE DZIT_T.DZIT005,
               DZIT006  LIKE DZIT_T.DZIT006,
               DZIT007  LIKE DZIT_T.DZIT007,
               DZIT008  LIKE DZIT_T.DZIT008,
               DZIT009  LIKE DZIT_T.DZIT009,
               DZITL006 LIKE DZITL_T.DZITL006, 
               DZITL007 LIKE DZITL_T.DZITL007,
               DZIT011  LIKE DZIT_T.DZIT011  # 新版trigger script # 170210-00052#1 by circlelai 
             END RECORD

PRIVATE TYPE T_DZITL_T_WL RECORD 
               DZITL001 LIKE DZITL_T.DZITL001,
               DZITL002 LIKE DZITL_T.DZITL002,
               DZITL003 LIKE DZITL_T.DZITL003,
               DZITL004 LIKE DZITL_T.DZITL004, 
               DZITL005 LIKE DZITL_T.DZITL005,
               DZITL006 LIKE DZITL_T.DZITL006,
               DZITL007 LIKE DZITL_T.DZITL007
             END RECORD
             
PUBLIC TYPE T_TABLE_IN_DB_TYPE RECORD
              tidt_db          VARCHAR(20),
              tidt_object_type VARCHAR(20)
            END RECORD             

PUBLIC TYPE T_TABLE_SYNONYM RECORD
              p_row_number   VARCHAR(10), #DZEU005 
              p_master_db    VARCHAR(15),
              p_table_name   VARCHAR(15), #DZEU001
              p_type         VARCHAR(2),
              p_checkbox     VARCHAR(1),  #DZEU004
              p_ent_db       VARCHAR(20), #DZEU002
              p_sch_type     VARCHAR(2)   #DZEU003 
            END RECORD

PUBLIC TYPE T_DATA_LINE RECORD
                DATA001 VARCHAR(500),
                DATA002 VARCHAR(500), 
                DATA003 VARCHAR(500),
                DATA004 VARCHAR(500),
                DATA005 VARCHAR(500),
                DATA006 VARCHAR(500),
                DATA007 VARCHAR(500),
                DATA008 VARCHAR(500),
                DATA009 VARCHAR(500),
                DATA010 VARCHAR(500),
                DATA011 VARCHAR(500),
                DATA012 VARCHAR(500), 
                DATA013 VARCHAR(500),
                DATA014 VARCHAR(500),
                DATA015 VARCHAR(500),
                DATA016 VARCHAR(500),
                DATA017 VARCHAR(500),
                DATA018 VARCHAR(500),
                DATA019 VARCHAR(500),
                DATA020 VARCHAR(500),
                DATA021 VARCHAR(500),
                DATA022 VARCHAR(500), 
                DATA023 VARCHAR(500),
                DATA024 VARCHAR(500),
                DATA025 VARCHAR(500),
                DATA026 VARCHAR(500),
                DATA027 VARCHAR(500),
                DATA028 VARCHAR(500),
                DATA029 VARCHAR(500),
                DATA030 VARCHAR(500)
              END RECORD

PRIVATE TYPE T_DZEU_T RECORD
               DZEU001 LIKE DZEU_T.DZEU001,
               DZEU002 LIKE DZEU_T.DZEU002,
               DZEU003 LIKE DZEU_T.DZEU003,
               DZEU004 LIKE DZEU_T.DZEU004,
               DZEU005 LIKE DZEU_T.DZEU005
             END RECORD
              
PUBLIC TYPE T_SYS_INFO RECORD
              SYS_LANG   VARCHAR(200),
              SYS_USER   VARCHAR(200),
              SYS_DEPT   VARCHAR(200)
            END RECORD

PUBLIC TYPE T_TABLE_SHIP_NOTICE RECORD
              TABLE_NAME VARCHAR(30),
              RECORDS    INTEGER
            END RECORD

PUBLIC TYPE T_PARAMETERS RECORD
              PARAMETER1 VARCHAR(100),
              PARAMETER2 VARCHAR(100),
              PARAMETER3 VARCHAR(100),
              PARAMETER4 VARCHAR(100),
              PARAMETER5 VARCHAR(100)
            END RECORD

PUBLIC TYPE T_COLUMN_LIST RECORD 
              COLUMN_NAME   VARCHAR(30),
              COLUMN_DESC   VARCHAR(100) 
            END RECORD
            
PUBLIC TYPE T_SCHEMA_LIST RECORD
              CHECKBOX     VARCHAR(1),
              SCHEMA_NAME  VARCHAR(30)
            END RECORD