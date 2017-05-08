
SCHEMA ds

PRIVATE TYPE T_DZIA_T_SCR RECORD 
                RECORDTYPE LIKE TYPE_T.CHR1,
                DZIASEQ    VARCHAR(4),
                DZIA003    LIKE DZIA_T.DZIA003,
                DZIA001    LIKE DZIA_T.DZIA001,
                DZIA002    LIKE DZIA_T.DZIA002,
                DZIA004    LIKE DZIA_T.DZIA004,
                DZIA005    LIKE DZIA_T.DZIA005,
                DZIA006    LIKE DZIA_T.DZIA006,
                DZIA007    LIKE DZIA_T.DZIA007,
                DZIA011    LIKE DZIA_T.DZIA011,
                DZIA012    LIKE DZIA_T.DZIA012,
                DZIA013    LIKE DZIA_T.DZIA013,
                DZIA014    LIKE DZIA_T.DZIA014,
                DZIA015    LIKE DZIA_T.DZIA015,
                DZIA016    LIKE DZIA_T.DZIA016,
                DZIA017    LIKE DZIA_T.DZIA017,
                DZIA018    LIKE DZIA_T.DZIA018,
                DZIA019    LIKE DZIA_T.DZIA019,
                DZIA020    LIKE DZIA_T.DZIA020,
                DZIA021    LIKE DZIA_T.DZIA021,
                DZLM008    LIKE DZLM_T.DZLM008,     #DGW07558_add_at20151126
                DZLM007    LIKE DZLM_T.DZLM007,     #DGW07558_add_at20151126
                OOAG011    LIKE OOAG_T.OOAG011      #DGW07558_add_at20151126
             END RECORD

#--DGW07558_add_at2015111
PRIVATE TYPE T_DZIA_T_SCR_COLOR RECORD 
                RECORDTYPE STRING,
                DZIASEQ    STRING,
                DZIA003    STRING,
                DZIA001    STRING,
                DZIA002    STRING,
                DZIA004    STRING,
                DZIA005    STRING,
                DZIA006    STRING,
                DZIA007    STRING,
                DZIA011    STRING,
                DZIA012    STRING,
                DZIA013    STRING,
                DZIA014    STRING,
                DZIA015    STRING,
                DZIA016    STRING,
                DZIA017    STRING,
                DZIA018    STRING,
                DZIA019    STRING,
                DZIA020    STRING,
                DZIA021    STRING,
                DZLM008    STRING
            END RECORD
{             
PRIVATE TYPE T_DZIA_T RECORD 
               DZIA001 LIKE DZIA_T.DZIA001,
               DZIA002 LIKE DZIA_T.DZIA002,
               DZIA003 LIKE DZIA_T.DZIA003,
               DZIA004 LIKE DZIA_T.DZIA004,
               DZIA005 LIKE DZIA_T.DZIA005,
               DZIA006 LIKE DZIA_T.DZIA006,
               DZIA007 LIKE DZIA_T.DZIA007,
               DZIA008 LIKE DZIA_T.DZIA008,
               DZIA009 LIKE DZIA_T.DZIA009,
               DZIA010 LIKE DZIA_T.DZIA010,
               DZIA011 LIKE DZIA_T.DZIA011,
               DZIA012 LIKE DZIA_T.DZIA012,
               DZIA013 LIKE DZIA_T.DZIA013,
               DZIA014 LIKE DZIA_T.DZIA014,
               DZIA015 LIKE DZIA_T.DZIA015,
               DZIA016 LIKE DZIA_T.DZIA016,
               DZIA017 LIKE DZIA_T.DZIA017,
               DZIA018 LIKE DZIA_T.DZIA018,
               DZIA019 LIKE DZIA_T.DZIA019,
               DZIA020 LIKE DZIA_T.DZIA020,
               DZIA021 LIKE DZIA_T.DZIA021
             END RECORD
}
             
PRIVATE TYPE T_DZIB_T_SCR RECORD
                RECORDTYPE LIKE TYPE_T.CHR1,
                GROUPID    VARCHAR(256),
                DZIBSEQ    VARCHAR(4),
                DZIB001    LIKE DZIB_T.DZIB001,
                DZIB002    LIKE DZIB_T.DZIB002,
                DZIB003    LIKE DZIB_T.DZIB003,
                DZIB004    LIKE DZIB_T.DZIB004,
                DZIB005    LIKE DZIB_T.DZIB005, 
                DZIB006    LIKE DZIB_T.DZIB006,
                GZTDL003   LIKE GZTDL_T.GZTDL003,
                DZIB007    LIKE DZIB_T.DZIB007,
                DZIB008    LIKE DZIB_T.DZIB008,
                DZIB012    LIKE DZIB_T.DZIB012,
                DZIB021    LIKE DZIB_T.DZIB021,
                DZIB022    LIKE DZIB_T.DZIB022,
                DZIB023    LIKE DZIB_T.DZIB023,
                DZIB024    LIKE DZIB_T.DZIB024,
                DZIB027    LIKE DZIB_T.DZIB027,
                DZIB028    LIKE DZIB_T.DZIB028, 
                DZIB029    LIKE DZIB_T.DZIB029, 
                DZIB030    LIKE DZIB_T.DZIB030, 
                DZIB031    LIKE DZIB_T.DZIB031 
            END RECORD

#--DGW07558_add_at20151125
PRIVATE TYPE T_DZIB_T_SCR_COLOR RECORD
                RECORDTYPE STRING,
                GROUPID    STRING,
                DZIBSEQ    STRING,
                DZIB001    STRING,
                DZIB002    STRING,
                DZIB003    STRING,
                DZIB004    STRING,
                DZIB005    STRING,
                DZIB006    STRING,
                GZTDL003   STRING,
                DZIB007    STRING,
                DZIB008    STRING,
                DZIB012    STRING,
                DZIB021    STRING,
                DZIB022    STRING,
                DZIB023    STRING,
                DZIB024    STRING,
                DZIB027    STRING,
                DZIB028    STRING,
                DZIB029    STRING,
                DZIB030    STRING,
                DZIB031    STRING
            END RECORD
{
PRIVATE TYPE T_DZIB_T RECORD
                DZIB001 LIKE DZIB_T.DZIB001,
                DZIB002 LIKE DZIB_T.DZIB002,
                DZIB003 LIKE DZIB_T.DZIB003,
                DZIB004 LIKE DZIB_T.DZIB004,
                DZIB005 LIKE DZIB_T.DZIB005,
                DZIB006 LIKE DZIB_T.DZIB006,
                DZIB007 LIKE DZIB_T.DZIB007,
                DZIB008 LIKE DZIB_T.DZIB008,
                DZIB012 LIKE DZIB_T.DZIB012,
                DZIB021 LIKE DZIB_T.DZIB021,
                DZIB022 LIKE DZIB_T.DZIB022,
                DZIB023 LIKE DZIB_T.DZIB023,
                DZIB024 LIKE DZIB_T.DZIB024,
                DZIB027 LIKE DZIB_T.DZIB027,
                DZIB028 LIKE DZIB_T.DZIB028,
                DZIB029 LIKE DZIB_T.DZIB029,
                DZIB030 LIKE DZIB_T.DZIB030,
                DZIB031 LIKE DZIB_T.DZIB031
             END RECORD
}

{
PRIVATE TYPE T_DZIU_T RECORD
               DZIU001 LIKE DZIU_T.DZIU001,
               DZIU002 LIKE DZIU_T.DZIU002,
               DZIU003 LIKE DZIU_T.DZIU003,
               DZIU004 LIKE DZIU_T.DZIU004,
               DZIU005 LIKE DZIU_T.DZIU005
             END RECORD
}

{
PUBLIC TYPE T_COLUMN_ALTER RECORD
              dzib002 LIKE dzib_t.dzib002, 
              dzib004 LIKE dzib_t.dzib004, 
              dzib005 LIKE dzib_t.dzib005, 
              dzib007 LIKE dzib_t.dzib007, 
              dzib008 LIKE dzib_t.dzib008, 
              dzib012 LIKE dzib_t.dzib012  
            END RECORD
}

{
PUBLIC TYPE T_TABLE_CONSTRAINT RECORD
              tc_TABLE_NAME      VARCHAR(30),
              tc_CONSTRAINT_NAME VARCHAR(100),
              tc_CONSTRAINT_TYPE VARCHAR(10),
              tc_COLUMNS         VARCHAR(1024)
            END RECORD
}
            
{
PUBLIC TYPE T_DB_CONNSTR RECORD
              db_source        VARCHAR(20),
              db_username      VARCHAR(20),
              db_password      VARCHAR(20),
              db_schema        VARCHAR(20),
              db_sid           VARCHAR(20),
              db_sql_filename  VARCHAR(150),
              db_version       VARCHAR(50)
            END RECORD
}

{
PUBLIC TYPE T_DB_COXN_STR RECORD
              db_sid           VARCHAR(100),
              db_db_name       VARCHAR(100),
              db_username      VARCHAR(100),
              db_password      VARCHAR(100),
              db_db_link       VARCHAR(100),
              db_sql_filename  VARCHAR(1024)
            END RECORD
}
            
PUBLIC TYPE T_TABLE_IN_DB_TYPE RECORD
              tidt_db          VARCHAR(20),
              tidt_object_type VARCHAR(20)
            END RECORD             

PUBLIC TYPE T_TABLE_SYNONYM RECORD
              p_row_number   VARCHAR(10), #DZIU005 
              p_master_db    VARCHAR(15),
              p_table_name   VARCHAR(15), #DZIU001
              p_type         VARCHAR(2),
              p_checkbox     VARCHAR(1),  #DZIU004
              p_ent_db       VARCHAR(20), #DZIU002
              p_sch_type     VARCHAR(2)   #DZIU003 
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

{
PUBLIC TYPE T_COLUMN_DATA RECORD
                            COLUMN_NAME   VARCHAR(200),
                            ISKEY         VARCHAR(200),
                            NULLABLE      VARCHAR(200),
                            DATA_TYPE     VARCHAR(200),
                            DATA_LENGTH   VARCHAR(200),
                            DEFAULT_VALUE VARCHAR(4000)
                          END RECORD
}
                          
{
PUBLIC TYPE T_DB_INFO RECORD
                        DB_NAME   VARCHAR(200),
                        USER_NAME VARCHAR(200)
                      END RECORD
}
PUBLIC TYPE T_SYS_INFO RECORD
                        SYS_LANG   VARCHAR(200),
                        SYS_USER   VARCHAR(200),
                        SYS_DEPT   VARCHAR(200)
                      END RECORD

PUBLIC TYPE T_TABLE_SHIP_NOTICE RECORD
              TABLE_NAME VARCHAR(30),
              RECORDS    INTEGER
           END RECORD

PUBLIC TYPE T_INTF_COLUMN_LIST RECORD
                                 CHECK_BOX     VARCHAR(01),   
                                 TABLE_NAME    VARCHAR(30),
                                 COLUMN_NAME1   VARCHAR(30),
                                 COLUMN_NAME   VARCHAR(30),
                                 COLUMN_DESC   VARCHAR(1024),
                                 PRIMARY_KEY   VARCHAR(02),
                                 NOT_NULL      VARCHAR(02),
                                 DATA_TYPE     VARCHAR(100), 
                                 DATA_LENGTH   VARCHAR(10)
                               END RECORD
           
PUBLIC TYPE T_PARAMETERS RECORD
              PARAMETER1 VARCHAR(100),
              PARAMETER2 VARCHAR(100),
              PARAMETER3 VARCHAR(100),
              PARAMETER4 VARCHAR(100),
              PARAMETER5 VARCHAR(100)
            END RECORD

PUBLIC TYPE T_MDM_DATA RECORD
              md_TYPE    VARCHAR(100),
              md_DB_SID  VARCHAR(100),
              md_DB_USER VARCHAR(100)
            END RECORD            

PUBLIC TYPE T_SCHEMA_LIST RECORD
              sl_CHECK_BOX    VARCHAR(1),
              sl_SCHEMA_NAME  VARCHAR(50)
            END RECORD 

PUBLIC TYPE T_adzi180_ARGUMENTS RECORD    #adzi180 帶入參數 --DGW07558_add_at20151119
  a_WORKING_TYPE    VARCHAR(10) -- chkdiff,
END RECORD 