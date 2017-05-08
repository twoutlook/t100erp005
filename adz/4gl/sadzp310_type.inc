
SCHEMA ds

{
#@desc 儲存tar檔資料
#a_WORKING_TYPE : EXP, IMP ...
#
#a_RUN_MODE : 運行模式 default(過單) = 0, patch = 1, 3
#@modify 16-11-25 by circle 07558
}
PUBLIC TYPE T_ARGUMENTS RECORD
              a_WORKING_TYPE          VARCHAR(10), -- EXP, IMP ...
              a_CONSTRUCT_TYPE        VARCHAR(10), -- MG, MV, MT
              a_WORKING_OBJECT        VARCHAR(1024), -- Object Name
              a_OBJECT_TYPE           VARCHAR(50), -- TRIGGER, VIEW, M_TABLE
              a_WORKING_PATH          VARCHAR(1024),
              a_WORKING_FILE          VARCHAR(1024),
              a_WORKING_FULL_NAME     VARCHAR(1024),
              a_WORKING_XML           VARCHAR(1024),
              a_WORKING_GUID          VARCHAR(50),
              a_SOURCE_FULL_NAME      VARCHAR(1024),
              a_SOURCE_FILE           VARCHAR(1024),
              a_SOURCE_PATH           VARCHAR(1024),
              a_EXPORT_FILE_LOCATION  VARCHAR(1024),
              a_SHOW_DIALOG           BOOLEAN,  --"-SD"
              a_MAKE_ASSEMBLE         BOOLEAN,  --"-MA"
              a_MAKE_REBUILD          BOOLEAN,
              a_BACKEND_MODE          BOOLEAN,  --"-BM"
              a_RUN_MODE              INTEGER
            END RECORD

#Clone from sadzi140_type.inc            
PUBLIC TYPE  T_DZLM_T_SCR RECORD 
                TYPES   VARCHAR(10),
                DZLM001  VARCHAR(10),  -- 建構類型
                DZLM002  VARCHAR(20),  -- 建構代號
                DZLM003  VARCHAR(120), -- 建構名稱
                DZLM004  VARCHAR(10),  -- 模組    
                DZLM005  VARCHAR(10),  -- 建構版號
                DZLM006  VARCHAR(10),  -- SD版號  
                DZLM007  VARCHAR(20),  -- SD工號  
                DZLM008  VARCHAR(1),   -- SD狀態  
                DZLM009  VARCHAR(10),  -- PR版號  
                DZLM010  VARCHAR(20),  -- PR工號  
                DZLM011  VARCHAR(1),   -- PR狀態  
                DZLM012  VARCHAR(20),  -- 需求單號
                DZLM013  VARCHAR(10),  -- 產品代號
                DZLM014  VARCHAR(10),  -- 產品版本
                DZLM015  INTEGER,      -- 作業項次
                DZLM016  VARCHAR(40),  -- 客戶代碼    
                DZLM017  DATE,         -- 簽入時間
                DZLM018 VARCHAR(40),  -- SD GUID
                DZLM019 VARCHAR(40),  -- PR GUID
                DZLM020 VARCHAR(1),   -- SD 已下載
                DZLM021 VARCHAR(1)    -- PR 已下載
               END RECORD

PUBLIC TYPE T_EXP_HEADER RECORD
              eh_OBJECT_TYPE   VARCHAR(50),  
              eh_OBJECT_NAME   VARCHAR(50),
              eh_EXP_TABLE     VARCHAR(50),
              eh_EXP_RECORDS   INTEGER,         --資料筆數
              eh_EXP_NAME      VARCHAR(1024),
              eh_EXP_PATH      VARCHAR(1024),
              eh_EXP_FULL_NAME VARCHAR(1024),
              eh_EXP_OWNER     VARCHAR(20),
              eh_EXP_DATETIME  VARCHAR(20),
              eh_DGENV         VARCHAR(10),
              eh_CUST          VARCHAR(50)
            END RECORD

PUBLIC TYPE T_COMPRESS_FILE_INFO RECORD
              cfi_ALM_NO            VARCHAR(50), 
              cfi_ALM_SEQ           VARCHAR(10),
              cfi_ALTER_SEQ         VARCHAR(10), 
              cfi_NAME              VARCHAR(1024),
              cfi_PATH              VARCHAR(1024),
              cfi_FULL_NAME         VARCHAR(1024),
              cfi_OBJECT_TYPE       VARCHAR(50),    --TRIGGER,VIEW,MTABLE
              cfi_OBJECT_NAME       VARCHAR(50),    --trgger_id, view_id, table_name
              cfi_OBJECTS           INTEGER,
              cfi_NOTICE_NAME       VARCHAR(1024),
              cfi_NOTICE_PATH       VARCHAR(1024),
              cfi_NOTICE_FULL_NAME  VARCHAR(1024),
              cfi_OWNER             VARCHAR(20),
              cfi_DATETIME          VARCHAR(20),
              cfi_DGENV             VARCHAR(10),
              cfi_CUST              VARCHAR(50)
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

PUBLIC TYPE T_TAR_FILE_INFO RECORD
              TABLE_NAME         VARCHAR(1024),
              CONSTRUCT_VERSION  VARCHAR(1024),
              SD_VERSION         VARCHAR(1024)
            END RECORD                         

PUBLIC TYPE T_EXPORT_INFO RECORD
              WORKING_PATH  VARCHAR(1024),
              TAR_NAME      VARCHAR(1024),
              CLIENT_PATH   VARCHAR(1024),
              RESULT        BOOLEAN    
            END RECORD                         

PUBLIC TYPE T_DIFF_COLUMNS RECORD
              DZIB002 LIKE DZIB_T.DZIB002,
              DZIB004 LIKE DZIB_T.DZIB004,
              DZIB005 LIKE DZIB_T.DZIB005,
              DZIB007 LIKE DZIB_T.DZIB007,
              DZIB008 LIKE DZIB_T.DZIB008,
              DZIB012 LIKE DZIB_T.DZIB012
            END RECORD

PUBLIC TYPE T_COLUMN_DATA RECORD
              COLUMN_NAME   VARCHAR(200),
              ISKEY         VARCHAR(200),
              NULLABLE      VARCHAR(200),
              DATA_TYPE     VARCHAR(200),
              DATA_LENGTH   VARCHAR(200),
              DEFAULT_VALUE VARCHAR(4000)
            END RECORD
            
PUBLIC TYPE T_COLUMNS_DATA_IN_MEM RECORD
              OWNER         VARCHAR(200),
              TABLE_NAME    VARCHAR(200),
              COLUMN_NAME   VARCHAR(200),
              ISKEY         VARCHAR(200),
              NULLABLE      VARCHAR(200),
              DATA_TYPE     VARCHAR(200),
              DATA_LENGTH   VARCHAR(200),
              DEFAULT_VALUE VARCHAR(4000)
            END RECORD

PUBLIC TYPE T_COLUMN_ALTER RECORD
              dzib002 LIKE dzib_t.dzib002, --dzev005 
              dzib004 LIKE dzib_t.dzib004, --dzev006
              dzib005 LIKE dzib_t.dzib005, --dzev007
              dzib007 LIKE dzib_t.dzib007, --dzev008
              dzib008 LIKE dzib_t.dzib008, --dzev009
              dzib012 LIKE dzib_t.dzib012  --dzev021  
            END RECORD

PUBLIC TYPE T_TABLE_METADATA RECORD
              ts_OWNER         VARCHAR(100),     
              ts_TABLE_NAME    VARCHAR(100),     
              ts_TABLE_SPACE   VARCHAR(100),     
              ts_COMMENT       VARCHAR(1024)
            END RECORD

PUBLIC TYPE T_TABLE_CONSTRAINT RECORD
              tc_TABLE_NAME      VARCHAR(30),
              tc_CONSTRAINT_NAME VARCHAR(100),
              tc_CONSTRAINT_TYPE VARCHAR(10),
              tc_COLUMNS         VARCHAR(1024)
            END RECORD
            
#Trigger Types
PRIVATE TYPE T_DZIT_T RECORD
               DZIT001 LIKE DZIT_T.DZIT001, 
               DZIT002 LIKE DZIT_T.DZIT002, 
               DZIT003 LIKE DZIT_T.DZIT003, 
               DZIT004 LIKE DZIT_T.DZIT004, 
               DZIT005 LIKE DZIT_T.DZIT005, 
               DZIT006 LIKE DZIT_T.DZIT006, 
               DZIT007 LIKE DZIT_T.DZIT007, 
               DZIT008 LIKE DZIT_T.DZIT008, 
               DZIT009 LIKE DZIT_T.DZIT009,
               DZIT010 LIKE DZIT_T.DZIT010,  # 出貨旗標
               DZIT011 LIKE DZIT_T.DZIT011   # 新觸發器內容 # 170210-00052#1 add
             END RECORD 

PRIVATE TYPE T_DZIT_T_JSON RECORD
               DZIT001 STRING, 
               DZIT002 STRING, 
               DZIT003 STRING, 
               DZIT004 STRING, 
               DZIT005 STRING, 
               DZIT006 STRING, 
               DZIT007 STRING, 
               DZIT008 STRING, 
               DZIT009 STRING,
               DZIT010 STRING,  # 出貨旗標
               DZIT011 STRING   # 新觸發器內容 # 170210-00052#1 add
             END RECORD              

PRIVATE TYPE T_DZITL_T RECORD
               DZITL001 LIKE DZITL_T.DZITL001, 
               DZITL002 LIKE DZITL_T.DZITL002, 
               DZITL003 LIKE DZITL_T.DZITL003, 
               DZITL004 LIKE DZITL_T.DZITL004, 
               DZITL005 LIKE DZITL_T.DZITL005, 
               DZITL006 LIKE DZITL_T.DZITL006, 
               DZITL007 LIKE DZITL_T.DZITL007
             END RECORD 

PRIVATE TYPE T_DZITL_T_JSON RECORD
               DZITL001 STRING, 
               DZITL002 STRING, 
               DZITL003 STRING, 
               DZITL004 STRING, 
               DZITL005 STRING, 
               DZITL006 STRING, 
               DZITL007 STRING
             END RECORD              

#View Types
PRIVATE TYPE T_DZIV_T RECORD
               DZIV001 LIKE DZIV_T.DZIV001, 
               DZIV002 LIKE DZIV_T.DZIV002, 
               DZIV003 LIKE DZIV_T.DZIV003, 
               DZIV004 LIKE DZIV_T.DZIV004, 
               DZIV005 LIKE DZIV_T.DZIV005,
               DZIV006 LIKE DZIV_T.DZIV006    #出貨旗標 add at 20160330 by CircleLai 
             END RECORD 

PRIVATE TYPE T_DZIV_T_JSON RECORD
               DZIV001 STRING, 
               DZIV002 STRING, 
               DZIV003 STRING, 
               DZIV004 STRING, 
               DZIV005 STRING,
               DZIV006 STRING    #出貨旗標 add at 20160330 by CircleLai 
             END RECORD              

PRIVATE TYPE T_DZIVL_T RECORD
               DZIVL001 LIKE DZIVL_T.DZIVL001, 
               DZIVL002 LIKE DZIVL_T.DZIVL002, 
               DZIVL003 LIKE DZIVL_T.DZIVL003, 
               DZIVL004 LIKE DZIVL_T.DZIVL004, 
               DZIVL005 LIKE DZIVL_T.DZIVL005, 
               DZIVL006 LIKE DZIVL_T.DZIVL006
             END RECORD 

PRIVATE TYPE T_DZIVL_T_JSON RECORD
               DZIVL001 STRING, 
               DZIVL002 STRING, 
               DZIVL003 STRING, 
               DZIVL004 STRING, 
               DZIVL005 STRING, 
               DZIVL006 STRING
             END RECORD              

#MTable Types
PRIVATE TYPE T_DZIA_T RECORD
               DZIA001  LIKE DZIA_T.DZIA001,
               DZIA002  LIKE DZIA_T.DZIA002,
               DZIA003  LIKE DZIA_T.DZIA003,
               DZIA004  LIKE DZIA_T.DZIA004,
               DZIA005  LIKE DZIA_T.DZIA005,
               DZIA006  LIKE DZIA_T.DZIA006,
               DZIA007  LIKE DZIA_T.DZIA007,
               DZIA008  LIKE DZIA_T.DZIA008,
               DZIA009  LIKE DZIA_T.DZIA009,
               DZIA010  LIKE DZIA_T.DZIA010,
               DZIA011  LIKE DZIA_T.DZIA011,
               DZIA012  LIKE DZIA_T.DZIA012,
               DZIA013  LIKE DZIA_T.DZIA013,
               DZIA014  LIKE DZIA_T.DZIA014,
               DZIA015  LIKE DZIA_T.DZIA015,
               DZIA016  LIKE DZIA_T.DZIA016,
               DZIA017  LIKE DZIA_T.DZIA017,
               DZIA018  LIKE DZIA_T.DZIA018,
               DZIA019  LIKE DZIA_T.DZIA019,
               DZIA020  LIKE DZIA_T.DZIA020,
               DZIA021  LIKE DZIA_T.DZIA021,
               DZIASTUS LIKE DZIA_T.DZIASTUS
             END RECORD 

PRIVATE TYPE T_DZIA_T_JSON RECORD
               DZIA001  STRING,
               DZIA002  STRING,
               DZIA003  STRING,
               DZIA004  STRING,
               DZIA005  STRING,
               DZIA006  STRING,
               DZIA007  STRING,
               DZIA008  STRING,
               DZIA009  STRING,
               DZIA010  STRING,
               DZIA011  STRING,
               DZIA012  STRING,
               DZIA013  STRING,
               DZIA014  STRING,
               DZIA015  STRING,
               DZIA016  STRING,
               DZIA017  STRING,
               DZIA018  STRING,
               DZIA019  STRING,
               DZIA020  STRING,
               DZIA021  STRING,
               DZIASTUS STRING
             END RECORD              

PRIVATE TYPE T_DZIB_T RECORD
               DZIB001  LIKE DZIB_T.DZIB001,
               DZIB002  LIKE DZIB_T.DZIB002,
               DZIB003  LIKE DZIB_T.DZIB003,
               DZIB004  LIKE DZIB_T.DZIB004,
               DZIB005  LIKE DZIB_T.DZIB005,
               DZIB006  LIKE DZIB_T.DZIB006,
               DZIB007  LIKE DZIB_T.DZIB007,
               DZIB008  LIKE DZIB_T.DZIB008,
               DZIB012  LIKE DZIB_T.DZIB012,
               DZIB021  LIKE DZIB_T.DZIB021,
               DZIB022  LIKE DZIB_T.DZIB022,
               DZIB023  LIKE DZIB_T.DZIB023,
               DZIB024  LIKE DZIB_T.DZIB024,
               DZIB027  LIKE DZIB_T.DZIB027,
               DZIB028  LIKE DZIB_T.DZIB028,
               DZIB029  LIKE DZIB_T.DZIB029,
               DZIB030  LIKE DZIB_T.DZIB030,
               DZIB031  LIKE DZIB_T.DZIB031,
               DZIBSTUS LIKE DZIB_T.DZIBSTUS
             END RECORD 

PRIVATE TYPE T_DZIB_T_JSON RECORD
               DZIB001  STRING,
               DZIB002  STRING,
               DZIB003  STRING,
               DZIB004  STRING,
               DZIB005  STRING,
               DZIB006  STRING,
               DZIB007  STRING,
               DZIB008  STRING,
               DZIB012  STRING,
               DZIB021  STRING,
               DZIB022  STRING,
               DZIB023  STRING,
               DZIB024  STRING,
               DZIB027  STRING,
               DZIB028  STRING,
               DZIB029  STRING,
               DZIB030  STRING,
               DZIB031  STRING,
               DZIBSTUS STRING
             END RECORD              
                                      
PRIVATE TYPE T_DZIU_T RECORD
               DZIU001 LIKE DZIU_T.DZIU001,
               DZIU002 LIKE DZIU_T.DZIU002,
               DZIU003 LIKE DZIU_T.DZIU003,
               DZIU004 LIKE DZIU_T.DZIU004,
               DZIU005 LIKE DZIU_T.DZIU005,
               DZIU006 LIKE DZIU_T.DZIU006,
               DZIU007 LIKE DZIU_T.DZIU007,
               DZIU008 LIKE DZIU_T.DZIU008
             END RECORD 

PRIVATE TYPE T_DZIU_T_JSON RECORD
               DZIU001 STRING,
               DZIU002 STRING,
               DZIU003 STRING,
               DZIU004 STRING,
               DZIU005 STRING,
               DZIU006 STRING,
               DZIU007 STRING,
               DZIU008 STRING
             END RECORD 

#160309-00001#1 add by circlelai 
PUBLIC TYPE T_ASM_REC RECORD    #整批建立作業回傳 info. --DGW07558 add at201603021130
              OBJ_NAME  STRING, --物件名稱
              ERR_CODE  STRING, --錯誤代碼, like 'ORA-123456'
              MSG_LOG   STRING, --執行日誌
              LOG_FILE  STRING  --紀錄錯誤訊息的檔案名稱
            END RECORD              