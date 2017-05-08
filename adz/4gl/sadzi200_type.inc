
SCHEMA ds

PRIVATE TYPE T_DZIV_T_H_SCR RECORD 
                RECORDTYPE     VARCHAR(1),
                DZIVSEQ        VARCHAR(4),
                DZIV001        LIKE DZIV_T.DZIV001,
                DZIV002        LIKE DZIV_T.DZIV002,
                DZIV003        LIKE DZIV_T.DZIV003,
                DZIV005        LIKE DZIV_T.DZIV005,
                DZIVL005       LIKE DZIVL_T.DZIVL005,
                DZLM008        LIKE DZLM_T.DZLM008,
                DZLM007        LIKE DZLM_T.DZLM007, --Jack Cheng 20160115
                OOAG011        LIKE OOAG_T.OOAG011, --Jack Cheng 20160115
                DZIV006        LIKE DZIV_T.DZIV006  --Jack Cheng 20160130
             END RECORD

PRIVATE TYPE T_DZIV_T_B_SCR RECORD 
               DZIV001        LIKE DZIV_T.DZIV001,
               DZIV002        LIKE DZIV_T.DZIV002,
               DZIV003        LIKE DZIV_T.DZIV003,
               DZIV004        LIKE DZIV_T.DZIV004, 
               DZIV005        LIKE DZIV_T.DZIV005,
               DZIVL005       LIKE DZIVL_T.DZIVL005, 
               DZIVL006       LIKE DZIVL_T.DZIVL006, 
               DZIVCRTID      LIKE DZIV_T.DZIVCRTID, -- 20160706 ernest
               DZIVCRTDT      LIKE DZIV_T.DZIVCRTDT, -- 20160706 ernest
               DZIVMODID      LIKE DZIV_T.DZIVMODID, -- 20160706 ernest
               DZIVMODDT      LIKE DZIV_T.DZIVMODDT, -- 20160706 ernest
               DZIVCRTIDDESC  VARCHAR(100),          -- 20160706 ernest
               DZIVMODIDDESC  VARCHAR(100),          -- 20160706 ernest
               vns_HEAD       VARCHAR(5),            -- 20160706 ernest
               vns_BODY       VARCHAR(30),           -- 20160706 ernest
               vns_TAIL       VARCHAR(10),           -- 20160706 ernest
               vns_SYNTAX     VARCHAR(1536)          -- 20160706 ernest
             END RECORD

PRIVATE TYPE T_DZIV_T_WL RECORD 
               DZIV001  LIKE DZIV_T.DZIV001,
               DZIV002  LIKE DZIV_T.DZIV002,
               DZIV003  LIKE DZIV_T.DZIV003,
               DZIV004  LIKE DZIV_T.DZIV004, 
               DZIV005  LIKE DZIV_T.DZIV005,
               DZIVL005 LIKE DZIVL_T.DZIVL005, 
               DZIVL006 LIKE DZIVL_T.DZIVL006
             END RECORD

PRIVATE TYPE T_DZIVL_T_WL RECORD 
               DZIVL001 LIKE DZIVL_T.DZIVL001,
               DZIVL002 LIKE DZIVL_T.DZIVL002,
               DZIVL003 LIKE DZIVL_T.DZIVL003,
               DZIVL004 LIKE DZIVL_T.DZIVL004, 
               DZIVL005 LIKE DZIVL_T.DZIVL005,
               DZIVL006 LIKE DZIVL_T.DZIVL006
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

PUBLIC TYPE T_VIEW_CONTENTS RECORD
              vc_HEAD  STRING,
              vc_BODY  STRING,
              vc_TAIL  STRING
            END RECORD
            