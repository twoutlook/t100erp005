&include "../4gl/sadzi140_mcr.inc"

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzi140_cnst.inc"

&include "../4gl/sadzi140_type.inc"

PRIVATE TYPE T_DIFF_COL_LIST RECORD 
                               RECORD_TYPE            VARCHAR(1),
                               COLUMN_NAME            VARCHAR(30),
                               ISKEY_DB_TABLE         VARCHAR(1), 
                               NULLABLE_DB_TABLE      VARCHAR(1), 
                               DATA_TYPE_DB_TABLE     VARCHAR(80),
                               DATA_LENGTH_DB_TABLE   VARCHAR(40),
                               DEFAULT_VALUE_DB_TABLE VARCHAR(4000),
                               ISKEY_RT_LIST          VARCHAR(1), 
                               NULLABLE_RT_LIST       VARCHAR(1), 
                               DATA_TYPE_RT_LIST      VARCHAR(80),
                               DATA_LENGTH_RT_LIST    VARCHAR(40),
                               DEFAULT_VALUE_RT_LIST  VARCHAR(4000)
                             END RECORD

PRIVATE TYPE T_DIFF_COL_LIST_COLOR RECORD 
                                     RECORD_TYPE            STRING,
                                     COLUMN_NAME            STRING,
                                     ISKEY_DB_TABLE         STRING, 
                                     NULLABLE_DB_TABLE      STRING, 
                                     DATA_TYPE_DB_TABLE     STRING,
                                     DATA_LENGTH_DB_TABLE   STRING,
                                     DEFAULT_VALUE_DB_TABLE STRING,
                                     ISKEY_RT_LIST          STRING, 
                                     NULLABLE_RT_LIST       STRING, 
                                     DATA_TYPE_RT_LIST      STRING,
                                     DATA_LENGTH_RT_LIST    STRING,
                                     DEFAULT_VALUE_RT_LIST  STRING
                                   END RECORD

PRIVATE TYPE T_DIFF_KEY_LIST RECORD
                               RECORD_TYPE      VARCHAR(1),
                               KEY_NAME         VARCHAR(30),
                               KEY_TYPE_DB      VARCHAR(30),
                               COLUMN_NAME_DB   VARCHAR(120),
                               F_TABLE_NAME_DB  VARCHAR(120),
                               F_COLUMN_NAME_DB VARCHAR(500), 
                               KEY_TYPE_RT      VARCHAR(30),
                               COLUMN_NAME_RT   VARCHAR(120),
                               F_TABLE_NAME_RT  VARCHAR(120),
                               F_COLUMN_NAME_RT VARCHAR(500) 
                             END RECORD

PRIVATE TYPE T_DIFF_KEY_LIST_COLOR RECORD 
                                     RECORD_TYPE      STRING,
                                     KEY_NAME         STRING,
                                     KEY_TYPE_DB      STRING,
                                     COLUMN_NAME_DB   STRING,
                                     F_TABLE_NAME_DB  STRING,
                                     F_COLUMN_NAME_DB STRING,
                                     KEY_TYPE_RT      STRING,
                                     COLUMN_NAME_RT   STRING,
                                     F_TABLE_NAME_RT  STRING,
                                     F_COLUMN_NAME_RT STRING
                                   END RECORD

PRIVATE TYPE T_DIFF_IDX_LIST RECORD
                               RECORD_TYPE      VARCHAR(1),
                               INDEX_NAME       VARCHAR(30),
                               INDEX_TYPE_DB    VARCHAR(30),
                               COLUMN_NAME_DB   VARCHAR(120),
                               INDEX_TYPE_RT    VARCHAR(30),
                               COLUMN_NAME_RT   VARCHAR(120)
                             END RECORD

PRIVATE TYPE T_DIFF_IDX_LIST_COLOR RECORD 
                                     RECORD_TYPE      STRING,
                                     INDEX_NAME       STRING,
                                     INDEX_TYPE_DB    STRING,
                                     COLUMN_NAME_DB   STRING,
                                     INDEX_TYPE_RT    STRING,
                                     COLUMN_NAME_RT   STRING
                                   END RECORD

PRIVATE TYPE T_DIFF_LIST_BY_COLUMN_ID RECORD
                                        RECORD_TYPE     VARCHAR(1),
                                        COLUMN_ID       INTEGER, 
                                        DB_COLUMN_NAME  VARCHAR(30),
                                        RT_COLUMN_NAME  VARCHAR(30)
                                      END RECORD 
                                   
PRIVATE TYPE T_DIFF_LIST_BY_COLUMN_ID_COLOR RECORD
                                              RECORD_TYPE     STRING,
                                              COLUMN_ID       STRING, 
                                              DB_COLUMN_NAME  STRING,
                                              RT_COLUMN_NAME  STRING
                                            END RECORD
                                      
&ifndef DEBUG
GLOBALS "../../cfg/top_global.inc"
&endif

DEFINE m_diff_list DYNAMIC ARRAY OF T_DIFF_COL_LIST
DEFINE m_diff_list_color DYNAMIC ARRAY OF T_DIFF_COL_LIST_COLOR

DEFINE m_diff_idx_list DYNAMIC ARRAY OF T_DIFF_IDX_LIST
DEFINE m_diff_idx_list_color DYNAMIC ARRAY OF T_DIFF_IDX_LIST_COLOR

DEFINE m_diff_key_list DYNAMIC ARRAY OF T_DIFF_KEY_LIST
DEFINE m_diff_key_list_color DYNAMIC ARRAY OF T_DIFF_KEY_LIST_COLOR

DEFINE m_diff_list_by_column_id DYNAMIC ARRAY OF T_DIFF_LIST_BY_COLUMN_ID
DEFINE m_diff_list_by_column_id_color DYNAMIC ARRAY OF T_DIFF_LIST_BY_COLUMN_ID_COLOR

DEFINE ms_lang STRING

DEFINE ms_owner_name STRING
DEFINE ms_table_name STRING

DEFINE ms_revision    STRING
DEFINE ms_alm_version STRING

DEFINE ms_view_type STRING 

FUNCTION sadzi140_rdif_run(p_owner_name,p_table_name,p_revision,p_view_type)
DEFINE
  p_owner_name STRING,
  p_table_name STRING,
  p_revision   T_REVISION,
  p_view_type  STRING

  CALL sadzi140_rdif_initialize(p_owner_name,p_table_name,p_revision.*,p_view_type)
  CALL sadzi140_rdif_initial_form()
  CALL sadzi140_rdif_start()
  CALL sadzi140_rdif_finalize()
  
END FUNCTION

FUNCTION sadzi140_rdif_initialize(p_owner_name,p_table_name,p_revision,p_view_type)
DEFINE
  p_owner_name STRING,
  p_table_name STRING,
  p_revision   T_REVISION,
  p_view_type  STRING

  LET ms_owner_name  = p_owner_name
  LET ms_table_name  = p_table_name
  LET ms_alm_version = p_revision.rv_ALM_VERSION
  LET ms_revision    = p_revision.rv_SEQUENCE
  LET ms_view_type   = p_view_type
  
  &ifndef DEBUG
  LET ms_lang = g_lang
  &else
  LET ms_lang = cs_default_lang
  &endif
  
END FUNCTION

FUNCTION sadzi140_rdif_initial_form()
#Being:20150417 by Hiko
DEFINE lw_window   ui.Window,
       lf_form     ui.Form,
       ls_cfg_path STRING,
       ls_4st_path STRING,
       ls_img_path STRING
#End:20150417 by Hiko

  &ifndef DEBUG
    OPEN WINDOW w_sadzi140_rdif WITH FORM cl_ap_formpath("ADZ","sadzi140_rdif")
    #CONNECT TO cs_master_db
  &else
    OPEN WINDOW w_sadzi140_rdif WITH FORM sadzi140_util_get_form_path("sadzi140_rdif")
    #CONNECT TO "local"
  &endif
  
  CURRENT WINDOW IS w_sadzi140_rdif
  
  #Being:20150417 by Hiko
  &ifndef DEBUG
  CALL cl_ui_wintitle(1) #工具抬頭名稱
  CALL cl_load_4ad_interface(NULL)
  &endif

  CALL sadzi140_util_set_form_title('sadzi140_rdif',ms_lang)
  CALL sadzi140_util_set_form_style(ms_lang)
  
  #End:20150417 by Hiko
END FUNCTION

FUNCTION sadzi140_rdif_start()

  DIALOG ATTRIBUTES(UNBUFFERED)
    DISPLAY ARRAY m_diff_list TO sr_table_diff.*
    END DISPLAY

    DISPLAY ARRAY m_diff_key_list TO sr_key_diff.*
    END DISPLAY
    
    DISPLAY ARRAY m_diff_idx_list TO sr_index_diff.*
    END DISPLAY

    DISPLAY ARRAY m_diff_list_by_column_id TO sr_diff_by_column_id.*
    END DISPLAY

    BEFORE DIALOG 
      CALL sadzi140_rdif_fill_table_diff_list()
      CALL DIALOG.setArrayAttributes("sr_table_diff", m_diff_list_color)
      CALL sadzi140_rdif_fill_key_diff_list()
      CALL DIALOG.setArrayAttributes("sr_key_diff", m_diff_key_list_color)
      CALL sadzi140_rdif_fill_index_diff_list()
      CALL DIALOG.setArrayAttributes("sr_index_diff", m_diff_idx_list_color)
      CALL sadzi140_rdif_fill_diff_list_by_column_id()
      CALL DIALOG.setArrayAttributes("sr_diff_by_column_id", m_diff_list_by_column_id_color)

    ON ACTION btn_ok
      EXIT DIALOG
      
    ON ACTION CLOSE
      EXIT DIALOG
      
  END DIALOG

END FUNCTION

FUNCTION sadzi140_rdif_finalize()
  CLOSE WINDOW w_sadzi140_rdif
END FUNCTION

FUNCTION sadzi140_rdif_fill_table_diff_list()
DEFINE
  lo_column_forward_records  DYNAMIC ARRAY OF T_COLUMN_DATA,
  lo_column_backward_records DYNAMIC ARRAY OF T_COLUMN_DATA 
DEFINE 
  ls_sql   STRING,
  li_index INTEGER,
  li_count INTEGER

  IF ms_view_type = cs_view_type_db THEN
    LET ls_sql = "SELECT '' RECORD_TYPE,                                                                ",
                 "       ORIG.COLUMN_NAME,                                                              ",
                 "       SRC_DATA.ISKEY         ISKEY_SRC_DATA,                                         ",
                 "       SRC_DATA.NULLABLE      NULLABLE_SRC_DATA,                                      ",
                 "       SRC_DATA.DATA_TYPE     DATA_TYPE_SRC_DATA,                                     ",
                 "       SRC_DATA.DATA_LENGTH   DATA_LENGTH_SRC_DATA,                                   ",
                 "       SRC_DATA.DEFAULT_VALUE DEFAULT_VALUE_SRC_DATA,                                 ",
                 "       TGT_DATA.ISKEY         ISKEY_TGT_DATA,                                         ",
                 "       TGT_DATA.NULLABLE      NULLABLE_TGT_DATA,                                      ",
                 "       TGT_DATA.DATA_TYPE     DATA_TYPE_TGT_DATA,                                     ",
                 "       TGT_DATA.DATA_LENGTH   DATA_LENGTH_TGT_DATA,                                   ",
                 "       TGT_DATA.DEFAULT_VALUE DEFAULT_VALUE_TGT_DATA                                  ",
                 "FROM (                                                                                ",
                 "       SELECT COLS.COLUMN_NAME, MAX(COLUMN_ID) COLUMN_ID                              ",
                 "         FROM (                                                                       ",
                 "                 SELECT ATC.COLUMN_NAME    COLUMN_NAME,                               ",
                 "                        ATC.COLUMN_ID      COLUMN_ID                                  ",
                 "                   FROM DBA_TAB_COLUMNS ATC                                           ",
                 "                  WHERE 1=1                                                           ",
                 "                    AND ATC.OWNER      = '",ms_owner_name.toUpperCase(),"'            ",
                 "                    AND ATC.TABLE_NAME = '",ms_table_name.toUpperCase(),"'            ",
                 "                    AND ATC.COLUMN_NAME <> 'DUMMY'                                    ",
                 "                 UNION                                                                ",
                 "                 SELECT EV.DZEV005   COLUMN_NAME,                                     ",
                 "                        EV.DZEV011   COLUMN_ID                                        ",
                 "                   FROM DZEV_T EV                                                     ",        
                 "                  WHERE EV.DZEV001 = '",ms_owner_name.toUpperCase(),"'                ",
                 "                    AND EV.DZEV002 = '",ms_table_name.toUpperCase(),"'                ",
                 "                    AND EV.DZEV003 = '",ms_revision,"'                                ",
                 "                    AND EV.DZEV004 = 'TableDesigner'                                  ",
                 "                    AND EV.DZEV018 = '",ms_alm_version,"'                             ",
                 "              ) COLS                                                                  ",
                 "        GROUP BY COLS.COLUMN_NAME                                                     ",
                 "     ) ORIG,                                                                          ",
                 "     (                                                                                ",
                 "       SELECT ATC.COLUMN_NAME                      COLUMN_NAME,                       ",
                 "              DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                             ",
                 "              ATC.NULLABLE                         NULLABLE,                          ",
                 "              DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE, ",
                 "              REPLACE(TO_CHAR(DECODE(                                                 ",
                 "                      ATC.DATA_TYPE,                                                  ",
                 "                      'NUMBER',DECODE(                                                ",
                 "                                       NVL(ATC.DATA_SCALE,'0'),                       ",
                 "                                       '0',ATC.DATA_PRECISION,                        ",
                 "                                       ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE        ",
                 "                                     ),                                               ",
                 "                      ATC.DATA_LENGTH                                                 ",
                 "                    )),'.',',')                    DATA_LENGTH,                       ",
                 "              TRIM(DS.GET_COL_DEFAULT(ATC.TABLE_NAME,ATC.COLUMN_NAME))  DEFAULT_VALUE ", 
                 "         FROM DBA_TAB_COLUMNS ATC                                                     ",
                 "         LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER          ",
                 "                                             AND ACC.TABLE_NAME  = ATC.TABLE_NAME     ",
                 "                                             AND ACC.COLUMN_NAME = ATC.COLUMN_NAME    ",
                 "                                             AND ACC.CONSTRAINT_NAME NOT LIKE 'SYS%'  ",
                 "                                             AND ACC.CONSTRAINT_NAME LIKE '%PK'       ",
                 "        WHERE 1=1                                                                     ",
                 "          AND ATC.OWNER      = '",ms_owner_name.toUpperCase(),"'                      ",
                 "          AND ATC.TABLE_NAME = '",ms_table_name.toUpperCase(),"'                      ",
                 "     ) SRC_DATA,                                                                      ",
                 "     (                                                                                ",
                 "       SELECT EV.DZEV005       COLUMN_NAME,                                           ",
                 "              EV.DZEV006       ISKEY,                                                 ",
                 "              EV.DZEV007       NULLABLE,                                              ",
                 "              EV.DZEV008       DATA_TYPE,                                             ",
                 "              EV.DZEV009       DATA_LENGTH,                                           ",
                 "              TRIM(EV.DZEV021) DEFAULT_VALUE                                          ",
                 "         FROM DZEV_T EV                                                               ",
                 "        WHERE EV.DZEV001 = '",ms_owner_name.toUpperCase(),"'                          ",
                 "          AND EV.DZEV002 = '",ms_table_name.toUpperCase(),"'                          ",
                 "          AND EV.DZEV003 = '",ms_revision,"'                                          ",
                 "          AND EV.DZEV004 = 'TableDesigner'                                            ",
                 "          AND EV.DZEV018 = '",ms_alm_version,"'                                       ",
                 "     ) TGT_DATA                                                                       ",
                 "WHERE TGT_DATA.COLUMN_NAME (+)= ORIG.COLUMN_NAME                                      ",
                 "  AND SRC_DATA.COLUMN_NAME (+)= ORIG.COLUMN_NAME                                      ",
                 "ORDER BY ORIG.COLUMN_ID                                                               "
  ELSE 
    IF ms_view_type = cs_view_type_rt THEN 
      LET ls_sql = "SELECT '' RECORD_TYPE,                                                                ",
                   "       ORIG.COLUMN_NAME,                                                              ",
                   "       SRC_DATA.ISKEY         ISKEY_SRC_DATA,                                         ",
                   "       SRC_DATA.NULLABLE      NULLABLE_SRC_DATA,                                      ",
                   "       SRC_DATA.DATA_TYPE     DATA_TYPE_SRC_DATA,                                     ",
                   "       SRC_DATA.DATA_LENGTH   DATA_LENGTH_SRC_DATA,                                   ",
                   "       SRC_DATA.DEFAULT_VALUE DEFAULT_VALUE_SRC_DATA,                                 ",
                   "       TGT_DATA.ISKEY         ISKEY_TGT_DATA,                                         ",
                   "       TGT_DATA.NULLABLE      NULLABLE_TGT_DATA,                                      ",
                   "       TGT_DATA.DATA_TYPE     DATA_TYPE_TGT_DATA,                                     ",
                   "       TGT_DATA.DATA_LENGTH   DATA_LENGTH_TGT_DATA,                                   ",
                   "       TGT_DATA.DEFAULT_VALUE DEFAULT_VALUE_TGT_DATA                                  ",
                   "FROM (                                                                                ",
                   "       SELECT COLS.COLUMN_NAME, MAX(COLUMN_ID) COLUMN_ID                              ",
                   "         FROM (                                                                       ",
                   "                 SELECT UPPER(EB.DZEB002)  COLUMN_NAME,                               ",           
                   "                        NVL(EB.DZEB021,0)  COLUMN_ID                                  ",           
                   "                   FROM DZEB_T EB                                                     ",           
                   "                  WHERE EB.DZEB001 = '",ms_table_name.toLowerCase(),"'                ",           
                   "                 UNION                                                                ",
                   "                 SELECT EV.DZEV005   COLUMN_NAME,                                     ",
                   "                        EV.DZEV011   COLUMN_ID                                        ",
                   "                   FROM DZEV_T EV                                                     ",        
                   "                  WHERE EV.DZEV001 = '",ms_owner_name.toUpperCase(),"'                ",
                   "                    AND EV.DZEV002 = '",ms_table_name.toUpperCase(),"'                ",
                   "                    AND EV.DZEV003 = '",ms_revision,"'                                ",
                   "                    AND EV.DZEV004 = 'TableDesigner'                                  ",
                   "                    AND EV.DZEV018 = '",ms_alm_version,"'                             ",
                   "              ) COLS                                                                  ",
                   "        GROUP BY COLS.COLUMN_NAME                                                     ",
                   "     ) ORIG,                                                                          ",
                   "     (                                                                                ",
                   "       SELECT UPPER(EB.DZEB002)                      COLUMN_NAME,                     ", 
                   "              EB.DZEB004                             ISKEY,                           ", 
                   "              DECODE(EB.DZEB004,'Y','N','N','Y','Y') NULLABLE,                        ", 
                   "              UPPER(TD.GZTD003)                      DATA_TYPE,                       ", 
                   "              REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(                              ", 
                   "              DECODE(                                                                 ", 
                   "                     UPPER(TD.GZTD003),                                               ", 
                   "                     'BLOB','4000',                                                   ", 
                   "                     'CLOB','4000',                                                   ", 
                   "                     'DATE','7',                                                      ", 
                   "                     'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),                     ",
                   "                     TD.GZTD008                                                       ", 
                   "                    ),',','.'),' ',''))),'.',',')    DATA_LENGTH,                     ",
                   "              TRIM(EB.DZEB012)                       DEFAULT_VALUE                    ", 
                   "         FROM DZEB_T EB                                                               ", 
                   "              LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006                    ", 
                   "        WHERE EB.DZEB001 = '",ms_table_name.toLowerCase(),"'                          ",
                   "     ) SRC_DATA,                                                                      ",
                   "     (                                                                                ",
                   "       SELECT EV.DZEV005       COLUMN_NAME,                                           ",
                   "              EV.DZEV006       ISKEY,                                                 ",
                   "              EV.DZEV007       NULLABLE,                                              ",
                   "              EV.DZEV008       DATA_TYPE,                                             ",
                   "              EV.DZEV009       DATA_LENGTH,                                           ",
                   "              TRIM(EV.DZEV021) DEFAULT_VALUE                                          ", 
                   "         FROM DZEV_T EV                                                               ",
                   "        WHERE EV.DZEV001 = '",ms_owner_name.toUpperCase(),"'                          ",
                   "          AND EV.DZEV002 = '",ms_table_name.toUpperCase(),"'                          ",
                   "          AND EV.DZEV003 = '",ms_revision,"'                                          ",
                   "          AND EV.DZEV004 = 'TableDesigner'                                            ",
                   "          AND EV.DZEV018 = '",ms_alm_version,"'                                       ",
                   "     ) TGT_DATA                                                                       ",
                   "WHERE TGT_DATA.COLUMN_NAME (+)= ORIG.COLUMN_NAME                                      ",
                   "  AND SRC_DATA.COLUMN_NAME (+)= ORIG.COLUMN_NAME                                      ",
                   "ORDER BY ORIG.COLUMN_ID                                                               "
    END IF 
  END IF
  
  PREPARE lpre_fill_fill_table_diff_list FROM ls_sql
  DECLARE lcur_fill_fill_table_diff_list CURSOR FOR lpre_fill_fill_table_diff_list

  CALL m_diff_list.clear()
  CALL m_diff_list_color.clear()
  
  LET li_count = 1

  #取得表格差異資料
  CALL sadzi140_rdif_get_column_forward_records(ms_owner_name,ms_table_name) RETURNING lo_column_forward_records
  CALL sadzi140_rdif_get_column_backward_records(ms_owner_name,ms_table_name) RETURNING lo_column_backward_records
  
  #DISPLAY ls_TableName
  FOREACH lcur_fill_fill_table_diff_list INTO m_diff_list[li_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET m_diff_list[li_count].RECORD_TYPE = NULL
    
    LET m_diff_list_color[li_count].RECORD_TYPE         = NULL
    LET m_diff_list_color[li_count].COLUMN_NAME         = NULL

    LET m_diff_list_color[li_count].ISKEY_RT_LIST         = NULL
    LET m_diff_list_color[li_count].NULLABLE_RT_LIST      = NULL
    LET m_diff_list_color[li_count].DATA_TYPE_RT_LIST     = NULL
    LET m_diff_list_color[li_count].DATA_LENGTH_RT_LIST   = NULL
    LET m_diff_list_color[li_count].DEFAULT_VALUE_RT_LIST = NULL
    
    LET m_diff_list_color[li_count].ISKEY_DB_TABLE         = NULL
    LET m_diff_list_color[li_count].NULLABLE_DB_TABLE      = NULL
    LET m_diff_list_color[li_count].DATA_TYPE_DB_TABLE     = NULL
    LET m_diff_list_color[li_count].DATA_LENGTH_DB_TABLE   = NULL
    LET m_diff_list_color[li_count].DEFAULT_VALUE_DB_TABLE = NULL

    FOR li_index = 1 TO lo_column_forward_records.getLength()
      IF m_diff_list[li_count].column_name = lo_column_forward_records[li_index].column_name THEN
        LET m_diff_list[li_count].RECORD_TYPE = "!"
        LET m_diff_list_color[li_count].RECORD_TYPE           = "red"
        LET m_diff_list_color[li_count].COLUMN_NAME           = "blue"
        LET m_diff_list_color[li_count].ISKEY_RT_LIST         = "yellow reverse"
        LET m_diff_list_color[li_count].NULLABLE_RT_LIST      = "yellow reverse"
        LET m_diff_list_color[li_count].DATA_TYPE_RT_LIST     = "yellow reverse"
        LET m_diff_list_color[li_count].DATA_LENGTH_RT_LIST   = "yellow reverse"
        LET m_diff_list_color[li_count].DEFAULT_VALUE_RT_LIST = "yellow reverse"
        EXIT FOR;
      END IF    
    END FOR

    FOR li_index = 1 TO lo_column_backward_records.getLength()
      IF m_diff_list[li_count].column_name = lo_column_backward_records[li_index].column_name THEN
        LET m_diff_list[li_count].RECORD_TYPE = "!"
        LET m_diff_list_color[li_count].RECORD_TYPE            = "red"
        LET m_diff_list_color[li_count].COLUMN_NAME            = "blue"
        LET m_diff_list_color[li_count].ISKEY_DB_TABLE         = "red reverse"
        LET m_diff_list_color[li_count].NULLABLE_DB_TABLE      = "red reverse"
        LET m_diff_list_color[li_count].DATA_TYPE_DB_TABLE     = "red reverse"
        LET m_diff_list_color[li_count].DATA_LENGTH_DB_TABLE   = "red reverse"
        LET m_diff_list_color[li_count].DEFAULT_VALUE_DB_TABLE = "red reverse"
        EXIT FOR
      END IF    
    END FOR
    
    LET li_count = li_count + 1
    
  END FOREACH
  #CALL m_diff_list.deleteElement(li_count)

END FUNCTION

FUNCTION sadzi140_rdif_fill_key_diff_list()
DEFINE
  lo_key_forward_records  DYNAMIC ARRAY OF T_KEY_DATA,
  lo_key_backward_records DYNAMIC ARRAY OF T_KEY_DATA 
DEFINE 
  ls_sql   STRING,
  li_key   INTEGER,
  li_count INTEGER

  IF ms_view_type = cs_view_type_db THEN
    LET ls_sql = "SELECT ''                            RECORD_TYPE,                                                                   ",
                 "       ORIG.CONSTRAINT_NAME          CONSTRAINT_NAME,                                                               ",
                 "       SRC_KEY_LIST.CONSTRAINT_TYPE  CONSTRAINT_TYPE_DB,                                                            ",
                 "       SRC_KEY_LIST.COLUMN_NAMES     COLUMN_NAMES_DB,                                                               ",
                 "       SRC_KEY_LIST.R_TABLE_NAME     R_TABLE_NAME_DB,                                                               ",
                 "       SRC_KEY_LIST.R_COLUMN_NAMES   R_COLUMN_NAMES_DB,                                                             ",
                 "       DST_KEY_LIST.CONSTRAINT_TYPE  CONSTRAINT_TYPE_RT,                                                            ",
                 "       DST_KEY_LIST.COLUMN_NAMES     COLUMN_NAMES_RT,                                                               ",
                 "       DST_KEY_LIST.R_TABLE_NAME     R_TABLE_NAME_RT,                                                               ",
                 "       DST_KEY_LIST.R_COLUMN_NAMES   R_COLUMN_NAMES_RT                                                              ",
                 "  FROM (                                                                                                            ",
                 "         SELECT ACS.CONSTRAINT_NAME                                                                                 ",                                                  
                 "           FROM DBA_CONSTRAINTS ACS                                                                                 ",                                                 
                 "          WHERE 1 = 1                                                                                               ",                                                 
                 "            AND ACS.TABLE_NAME = '",ms_table_name.toUpperCase(),"'                                                  ",                             
                 "            AND ACS.OWNER      = '",ms_owner_name.toUpperCase(),"'                                                  ",
                 "         UNION                                                                                                      ",                                                 
                 "         SELECT UPPER(EW.DZEW004) CONSTRAINT_NAME                                                                   ",
                 "           FROM DZEW_T EW                                                                                           ",
                 "          WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                                                      ",
                 "            AND EW.DZEW002 = '",ms_revision,"'                                                                      ",
                 "            AND EW.DZEW003 = 'Constraint'                                                                           ",
                 "            AND EW.DZEW010 = '",ms_alm_version,"'                                                                   ",
                 "       ) ORIG,                                                                                                      ",     
                 "       (                                                                                                            ",
                 "         SELECT ACS.CONSTRAINT_NAME                                        CONSTRAINT_NAME,                         ",                                                                                                        
                 "                DECODE(ACS.CONSTRAINT_TYPE, 'R', 'R', ACS.CONSTRAINT_TYPE) CONSTRAINT_TYPE,                         ",                                                 
                 "                ACC.COLUMN_NAMES                                           COLUMN_NAMES,                            ",                                                                                                        
                 "                ACCR.TABLE_NAME                                            R_TABLE_NAME,                            ",                                                                                            
                 "                ACCR.COLUMN_NAMES                                          R_COLUMN_NAMES                           ",                                                                              
                 "           FROM DBA_CONSTRAINTS ACS                                                                                 ",                                                 
                 "           LEFT OUTER JOIN (                                                                                        ",                                                 
                 "                            SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,                                 ",
                 "                                   LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES ", 
                 "                              FROM DBA_CONS_COLUMNS ACCS                                                            ",                                                 
                 "                             GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                               ",                                                 
                 "                           ) ACC ON ACC.CONSTRAINT_NAME = ACS.CONSTRAINT_NAME                                       ",                                                 
                 "                                AND ACC.OWNER           = ACS.OWNER                                                 ",                                                 
                 "           LEFT OUTER JOIN (                                                                                        ",                                                 
                 "                            SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,                                 ",
                 "                                   LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES ", 
                 "                              FROM DBA_CONS_COLUMNS ACCS                                                            ",                                                 
                 "                             GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                               ",                                                 
                 "                           ) ACCR ON ACCR.CONSTRAINT_NAME = ACS.R_CONSTRAINT_NAME                                   ",                                                 
                 "                                 AND ACCR.OWNER           = ACS.R_OWNER                                             ",                                                 
                 "          WHERE 1 = 1                                                                                               ",                                                 
                 "            AND ACS.TABLE_NAME = '",ms_table_name.toUpperCase(),"'                                                  ",                                                 
                 "            AND ACS.OWNER      = '",ms_owner_name.toUpperCase(),"'                                                  ",                                                 
                 "       ) SRC_KEY_LIST,                                                                                              ",
                 "       (                                                                                                            ",
                 "         SELECT UPPER(EW.DZEW004)                 CONSTRAINT_NAME,                                                  ",
                 "                UPPER(EW.DZEW005)                 CONSTRAINT_TYPE,                                                  ",
                 "                UPPER(REPLACE(EW.DZEW006,' ','')) COLUMN_NAMES,                                                     ",
                 "                UPPER(EW.DZEW007)                 R_TABLE_NAME,                                                     ",                                                                                            
                 "                UPPER(EW.DZEW008)                 R_COLUMN_NAMES                                                    ",                                                                              
                 "           FROM DZEW_T EW                                                                                           ",
                 "          WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                                                      ",
                 "            AND EW.DZEW002 = '",ms_revision,"'                                                                      ",
                 "            AND EW.DZEW003 = 'Constraint'                                                                           ",
                 "            AND EW.DZEW010 = '",ms_alm_version,"'                                                                   ",
                 "       ) DST_KEY_LIST                                                                                               ",
                 "     WHERE SRC_KEY_LIST.CONSTRAINT_NAME (+)= ORIG.CONSTRAINT_NAME                                                   ",
                 "       AND DST_KEY_LIST.CONSTRAINT_NAME (+)= ORIG.CONSTRAINT_NAME                                                   "
  ELSE 
    IF ms_view_type = cs_view_type_rt THEN
      LET ls_sql = "SELECT ''                            RECORD_TYPE,                                                                   ",
                   "       ORIG.CONSTRAINT_NAME          CONSTRAINT_NAME,                                                               ",
                   "       SRC_KEY_LIST.CONSTRAINT_TYPE  CONSTRAINT_TYPE_DB,                                                            ",
                   "       SRC_KEY_LIST.COLUMN_NAMES     COLUMN_NAMES_DB,                                                               ",
                   "       SRC_KEY_LIST.R_TABLE_NAME     R_TABLE_NAME_DB,                                                               ",
                   "       SRC_KEY_LIST.R_COLUMN_NAMES   R_COLUMN_NAMES_DB,                                                             ",
                   "       DST_KEY_LIST.CONSTRAINT_TYPE  CONSTRAINT_TYPE_RT,                                                            ",
                   "       DST_KEY_LIST.COLUMN_NAMES     COLUMN_NAMES_RT,                                                               ",
                   "       DST_KEY_LIST.R_TABLE_NAME     R_TABLE_NAME_RT,                                                               ",
                   "       DST_KEY_LIST.R_COLUMN_NAMES   R_COLUMN_NAMES_RT                                                              ",
                   "  FROM (                                                                                                            ",
                   "         SELECT UPPER(ED.DZED002) CONSTRAINT_NAME                                                                   ",                                           
                   "           FROM DZED_T ED                                                                                           ",                                                 
                   "          WHERE ED.DZED001 = '",ms_table_name.toLowerCase(),"'                                                      ",
                   "            AND ED.DZED003 <> 'F'                                                                                   ",               
                   "         UNION                                                                                                      ",                                                 
                   "         SELECT UPPER(EW.DZEW004) CONSTRAINT_NAME                                                                   ",
                   "           FROM DZEW_T EW                                                                                           ",
                   "          WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                                                      ",
                   "            AND EW.DZEW002 = '",ms_revision,"'                                                                      ",
                   "            AND EW.DZEW003 = 'Constraint'                                                                           ",
                   "            AND EW.DZEW010 = '",ms_alm_version,"'                                                                   ",
                   "       ) ORIG,                                                                                                      ",     
                   "       (                                                                                                            ",
                   "         SELECT UPPER(ED.DZED002)       CONSTRAINT_NAME,                                                            ",
                   "                UPPER(ED.DZED003)       CONSTRAINT_TYPE,                                                            ",
                   "                UPPER(ED.DZED004)       COLUMN_NAMES,                                                               ",
                   "                UPPER(TRIM(ED.DZED005)) R_TABLE_NAME,                                                               ",
                   "                UPPER(TRIM(ED.DZED006)) R_COLUMN_NAMES                                                              ",
                   "           FROM DZED_T ED                                                                                           ",
                   "          WHERE ED.DZED001 = '",ms_table_name.toLowerCase(),"'                                                      ",
                   "            AND ED.DZED003 <> 'F'                                                                                   ",               
                   "       ) SRC_KEY_LIST,                                                                                              ",
                   "       (                                                                                                            ",
                   "         SELECT UPPER(EW.DZEW004)                 CONSTRAINT_NAME,                                                  ",
                   "                UPPER(EW.DZEW005)                 CONSTRAINT_TYPE,                                                  ",
                   "                UPPER(REPLACE(EW.DZEW006,' ','')) COLUMN_NAMES,                                                     ",
                   "                UPPER(EW.DZEW007)                 R_TABLE_NAME,                                                     ",                                                                                            
                   "                UPPER(EW.DZEW008)                 R_COLUMN_NAMES                                                    ",                                                                              
                   "           FROM DZEW_T EW                                                                                           ",
                   "          WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                                                      ",
                   "            AND EW.DZEW002 = '",ms_revision,"'                                                                      ",
                   "            AND EW.DZEW003 = 'Constraint'                                                                           ",
                   "            AND EW.DZEW010 = '",ms_alm_version,"'                                                                   ",
                   "       ) DST_KEY_LIST                                                                                               ",
                   "     WHERE SRC_KEY_LIST.CONSTRAINT_NAME (+)= ORIG.CONSTRAINT_NAME                                                   ",
                   "       AND DST_KEY_LIST.CONSTRAINT_NAME (+)= ORIG.CONSTRAINT_NAME                                                   "
    END IF 
  END IF 
  
  PREPARE lpre_fill_fill_key_diff_list FROM ls_sql
  DECLARE lcur_fill_fill_key_diff_list CURSOR FOR lpre_fill_fill_key_diff_list

  CALL m_diff_key_list.clear()
  CALL m_diff_key_list_color.clear()
  
  LET li_count = 1

  #取得KEY差異資料
  CALL sadzi140_rdif_get_key_forward_records(ms_owner_name,ms_table_name) RETURNING lo_key_forward_records
  CALL sadzi140_rdif_get_key_backward_records(ms_owner_name,ms_table_name) RETURNING lo_key_backward_records
  
  #DISPLAY ls_TableName
  FOREACH lcur_fill_fill_key_diff_list INTO m_diff_key_list[li_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET m_diff_key_list[li_count].RECORD_TYPE = NULL
    
    LET m_diff_key_list_color[li_count].RECORD_TYPE      = NULL
    LET m_diff_key_list_color[li_count].KEY_NAME         = NULL
    LET m_diff_key_list_color[li_count].KEY_TYPE_DB      = NULL
    LET m_diff_key_list_color[li_count].COLUMN_NAME_DB   = NULL
    LET m_diff_key_list_color[li_count].F_TABLE_NAME_DB  = NULL
    LET m_diff_key_list_color[li_count].F_COLUMN_NAME_DB = NULL 
    LET m_diff_key_list_color[li_count].KEY_TYPE_RT      = NULL
    LET m_diff_key_list_color[li_count].COLUMN_NAME_RT   = NULL
    LET m_diff_key_list_color[li_count].F_TABLE_NAME_RT  = NULL
    LET m_diff_key_list_color[li_count].F_COLUMN_NAME_RT = NULL 

    FOR li_key = 1 TO lo_key_forward_records.getLength()
      IF m_diff_key_list[li_count].key_name = lo_key_forward_records[li_key].key_name THEN
        LET m_diff_key_list[li_count].RECORD_TYPE = "!"
        LET m_diff_key_list_color[li_count].RECORD_TYPE      = "red"
        LET m_diff_key_list_color[li_count].KEY_NAME         = "blue"
        LET m_diff_key_list_color[li_count].KEY_TYPE_RT      = "yellow reverse"
        LET m_diff_key_list_color[li_count].COLUMN_NAME_RT   = "yellow reverse"
        LET m_diff_key_list_color[li_count].F_TABLE_NAME_RT  = "yellow reverse"
        LET m_diff_key_list_color[li_count].F_COLUMN_NAME_RT = "yellow reverse" 
        EXIT FOR;
      END IF    
    END FOR

    FOR li_key = 1 TO lo_key_backward_records.getLength()
      IF m_diff_key_list[li_count].key_name = lo_key_backward_records[li_key].key_name THEN
        LET m_diff_key_list[li_count].RECORD_TYPE = "!"
        LET m_diff_key_list_color[li_count].RECORD_TYPE      = "red"
        LET m_diff_key_list_color[li_count].KEY_NAME         = "blue"
        LET m_diff_key_list_color[li_count].KEY_TYPE_DB      = "red reverse"
        LET m_diff_key_list_color[li_count].COLUMN_NAME_DB   = "red reverse"
        LET m_diff_key_list_color[li_count].F_TABLE_NAME_DB  = "red reverse"
        LET m_diff_key_list_color[li_count].F_COLUMN_NAME_DB = "red reverse" 
        EXIT FOR
      END IF    
    END FOR
    
    LET li_count = li_count + 1
    
  END FOREACH
  #CALL m_diff_key_list.deleteElement(li_count)

END FUNCTION

FUNCTION sadzi140_rdif_get_key_forward_records(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  lo_key_forward_records DYNAMIC ARRAY OF T_KEY_DATA
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_key_name    STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  lo_return DYNAMIC ARRAY OF T_KEY_DATA  

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 1

  ------------------------------------------------------------------------------------------------
  -- key forward
  ------------------------------------------------------------------------------------------------
  IF ms_view_type = cs_view_type_db THEN
    LET ls_sql = "SELECT UPPER(EW.DZEW001)                 TABLE_NAME,                                                                                                        ",
                 "       UPPER(EW.DZEW004)                 CONSTRAINT_NAME,                                                                                                   ",
                 "       UPPER(EW.DZEW005)                 CONSTRAINT_TYPE,                                                                                                   ",
                 "       UPPER(REPLACE(EW.DZEW006,' ','')) COLUMN_NAMES,                                                                                                      ",
                 "       UPPER(TRIM(EW.DZEW007))           R_TABLE_NAME,                                                                                                      ",                                                                                            
                 "       UPPER(TRIM(EW.DZEW008))           R_COLUMN_NAMES                                                                                                     ",                                                                              
                 "  FROM DZEW_T EW                                                                                                                                            ",
                 " WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                                                                                                       ",
                 "   AND EW.DZEW002 = '",ms_revision,"'                                                                                                                       ",
                 "   AND EW.DZEW003 = 'Constraint'                                                                                                                            ",
                 "   AND EW.DZEW010 = '",ms_alm_version,"'                                                                                                                    ",
                 "MINUS                                                                                                                                                       ",
                 "SELECT ACS.TABLE_NAME,                                                                                                                                      ",
                 "       ACS.CONSTRAINT_NAME,                                                                                                                                 ",
                 "       DECODE(ACS.CONSTRAINT_TYPE, 'R', 'R', ACS.CONSTRAINT_TYPE) CONSTRAINT_TYPE,                                                                          ",
                 "       ACC.COLUMN_NAMES,                                                                                                                                    ",
                 "       ACCR.TABLE_NAME R_TABLE_NAME,                                                                                                                        ",
                 "       ACCR.COLUMN_NAMES                                                                                                                                    ",
                 "  FROM DBA_CONSTRAINTS ACS                                                                                                                                  ",
                 "  LEFT OUTER JOIN (                                                                                                                                         ",
                 "                   SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES  ",
                 "                     FROM DBA_CONS_COLUMNS ACCS                                                                                                             ",
                 "                    GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                ",
                 "                  ) ACC ON ACC.CONSTRAINT_NAME = ACS.CONSTRAINT_NAME                                                                                        ",
                 "                       AND ACC.OWNER           = ACS.OWNER                                                                                                  ",
                 "  LEFT OUTER JOIN (                                                                                                                                         ",
                 "                   SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES  ",
                 "                     FROM DBA_CONS_COLUMNS ACCS                                                                                                             ",
                 "                    GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                ",
                 "                  ) ACCR ON ACCR.CONSTRAINT_NAME = ACS.R_CONSTRAINT_NAME                                                                                    ",
                 "                        AND ACCR.OWNER           = ACS.R_OWNER                                                                                              ",
                 " WHERE 1 = 1                                                                                                                                                ",
                 "   AND ACS.TABLE_NAME = '",ls_table_name.toUpperCase(),"'                                                                                                   ",
                 "   AND ACS.OWNER      = '",ls_owner.toUpperCase(),"'                                                                                                        "
  ELSE 
    IF ms_view_type = cs_view_type_rt THEN
      LET ls_sql = "SELECT UPPER(EW.DZEW001)                 TABLE_NAME,                                                                                                        ",
                   "       UPPER(EW.DZEW004)                 CONSTRAINT_NAME,                                                                                                   ",
                   "       UPPER(EW.DZEW005)                 CONSTRAINT_TYPE,                                                                                                   ",
                   "       UPPER(REPLACE(EW.DZEW006,' ','')) COLUMN_NAMES,                                                                                                      ",
                   "       UPPER(TRIM(EW.DZEW007))           R_TABLE_NAME,                                                                                                      ",                                                                                            
                   "       UPPER(TRIM(EW.DZEW008))           R_COLUMN_NAMES                                                                                                     ",                                                                              
                   "  FROM DZEW_T EW                                                                                                                                            ",
                   " WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                                                                                                       ",
                   "   AND EW.DZEW002 = '",ms_revision,"'                                                                                                                       ",
                   "   AND EW.DZEW003 = 'Constraint'                                                                                                                            ",
                   "   AND EW.DZEW010 = '",ms_alm_version,"'                                                                                                                    ",
                   "MINUS                                                                                                                                                       ",
                   "SELECT UPPER(ED.DZED001)       TABLE_NAME,                                                                                                                  ",
                   "       UPPER(ED.DZED002)       CONSTRAINT_NAME,                                                                                                             ",
                   "       UPPER(ED.DZED003)       CONSTRAINT_TYPE,                                                                                                             ",
                   "       UPPER(ED.DZED004)       COLUMN_NAMES,                                                                                                                ",
                   "       UPPER(TRIM(ED.DZED005)) R_TABLE_NAME,                                                                                                                ",
                   "       UPPER(TRIM(ED.DZED006)) R_COLUMN_NAMES                                                                                                               ",
                   "  FROM DZED_T ED                                                                                                                                            ",
                   " WHERE ED.DZED001 = '",ls_table_name.toLowerCase(),"'                                                                                                       ",
                   "   AND ED.DZED003 <> 'F'                                                                                                                                    "               
    END IF 
  END IF  
                
  PREPARE lpre_get_key_forward_records FROM ls_sql
  DECLARE lcur_get_key_forward_records CURSOR FOR lpre_get_key_forward_records

  OPEN lcur_get_key_forward_records
  FOREACH lcur_get_key_forward_records INTO lo_key_forward_records[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_key_forward_records
  
  FREE lpre_get_key_forward_records
  FREE lcur_get_key_forward_records  
  -------------------------------------------------------------------------------------------------
  
  LET lo_return.* = lo_key_forward_records.*
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi140_rdif_get_key_backward_records(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  lo_key_backward_records DYNAMIC ARRAY OF T_KEY_DATA
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_key_name STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  lo_return DYNAMIC ARRAY OF T_KEY_DATA  

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 1

  ------------------------------------------------------------------------------------------------
  -- key backward
  ------------------------------------------------------------------------------------------------
  IF ms_view_type = cs_view_type_db THEN
    LET ls_sql = "SELECT ACS.TABLE_NAME,                                                                                                                                      ",
                 "       ACS.CONSTRAINT_NAME,                                                                                                                                 ",
                 "       DECODE(ACS.CONSTRAINT_TYPE, 'R', 'R', ACS.CONSTRAINT_TYPE) CONSTRAINT_TYPE,                                                                          ",
                 "       ACC.COLUMN_NAMES,                                                                                                                                    ",
                 "       ACCR.TABLE_NAME R_TABLE_NAME,                                                                                                                        ",
                 "       ACCR.COLUMN_NAMES                                                                                                                                    ",
                 "  FROM DBA_CONSTRAINTS ACS                                                                                                                                  ",
                 "  LEFT OUTER JOIN (                                                                                                                                         ",
                 "                   SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES  ",
                 "                     FROM DBA_CONS_COLUMNS ACCS                                                                                                             ",
                 "                    GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                ",
                 "                  ) ACC ON ACC.CONSTRAINT_NAME = ACS.CONSTRAINT_NAME                                                                                        ",
                 "                       AND ACC.OWNER           = ACS.OWNER                                                                                                  ",
                 "  LEFT OUTER JOIN (                                                                                                                                         ",
                 "                   SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES  ",
                 "                     FROM DBA_CONS_COLUMNS ACCS                                                                                                             ",
                 "                    GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                ",
                 "                  ) ACCR ON ACCR.CONSTRAINT_NAME = ACS.R_CONSTRAINT_NAME                                                                                    ",
                 "                        AND ACCR.OWNER           = ACS.R_OWNER                                                                                              ",
                 " WHERE 1 = 1                                                                                                                                                ",
                 "   AND ACS.TABLE_NAME = '",ls_table_name.toUpperCase(),"'                                                                                                   ",
                 "   AND ACS.OWNER      = '",ls_owner.toUpperCase(),"'                                                                                                        ",
                 "MINUS                                                                                                                                                       ",
                 "SELECT UPPER(EW.DZEW001)                 TABLE_NAME,                                                                                                        ",
                 "       UPPER(EW.DZEW004)                 CONSTRAINT_NAME,                                                                                                   ",
                 "       UPPER(EW.DZEW005)                 CONSTRAINT_TYPE,                                                                                                   ",
                 "       UPPER(REPLACE(EW.DZEW006,' ','')) COLUMN_NAMES,                                                                                                      ",
                 "       UPPER(TRIM(EW.DZEW007))           R_TABLE_NAME,                                                                                                      ",                                                                                            
                 "       UPPER(TRIM(EW.DZEW008))           R_COLUMN_NAMES                                                                                                     ",                                                                              
                 "  FROM DZEW_T EW                                                                                                                                            ",
                 " WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                                                                                                       ",
                 "   AND EW.DZEW002 = '",ms_revision,"'                                                                                                                       ",
                 "   AND EW.DZEW003 = 'Constraint'                                                                                                                            ",
                 "   AND EW.DZEW010 = '",ms_alm_version,"'                                                                                                                    "
                 
  ELSE 
    IF ms_view_type = cs_view_type_rt THEN
      LET ls_sql = "SELECT UPPER(ED.DZED001)       TABLE_NAME,                                                                                                                  ",
                   "       UPPER(ED.DZED002)       CONSTRAINT_NAME,                                                                                                             ",
                   "       UPPER(ED.DZED003)       CONSTRAINT_TYPE,                                                                                                             ",
                   "       UPPER(ED.DZED004)       COLUMN_NAMES,                                                                                                                ",
                   "       UPPER(TRIM(ED.DZED005)) R_TABLE_NAME,                                                                                                                ",
                   "       UPPER(TRIM(ED.DZED006)) R_COLUMN_NAMES                                                                                                               ",
                   "  FROM DZED_T ED                                                                                                                                            ",
                   " WHERE ED.DZED001 = '",ls_table_name.toLowerCase(),"'                                                                                                       ",
                   "   AND ED.DZED003 <> 'F'                                                                                                                                    ",               
                   "MINUS                                                                                                                                                       ",
                   "SELECT UPPER(EW.DZEW001)                 TABLE_NAME,                                                                                                        ",
                   "       UPPER(EW.DZEW004)                 CONSTRAINT_NAME,                                                                                                   ",
                   "       UPPER(EW.DZEW005)                 CONSTRAINT_TYPE,                                                                                                   ",
                   "       UPPER(REPLACE(EW.DZEW006,' ','')) COLUMN_NAMES,                                                                                                      ",
                   "       UPPER(TRIM(EW.DZEW007))           R_TABLE_NAME,                                                                                                      ",                                                                                            
                   "       UPPER(TRIM(EW.DZEW008))           R_COLUMN_NAMES                                                                                                     ",                                                                              
                   "  FROM DZEW_T EW                                                                                                                                            ",
                   " WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                                                                                                       ",
                   "   AND EW.DZEW002 = '",ms_revision,"'                                                                                                                       ",
                   "   AND EW.DZEW003 = 'Constraint'                                                                                                                            ",
                   "   AND EW.DZEW010 = '",ms_alm_version,"'                                                                                                                    "
                   
    END IF 
  END IF  
                
  PREPARE lpre_get_key_backward_records FROM ls_sql
  DECLARE lcur_get_key_backward_records CURSOR FOR lpre_get_key_backward_records

  OPEN lcur_get_key_backward_records
  FOREACH lcur_get_key_backward_records INTO lo_key_backward_records[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_key_backward_records
  
  FREE lpre_get_key_backward_records
  FREE lcur_get_key_backward_records  
  -------------------------------------------------------------------------------------------------
  
  LET lo_return.* = lo_key_backward_records.*
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi140_rdif_fill_index_diff_list()
DEFINE
  lo_index_forward_records  DYNAMIC ARRAY OF T_INDEX_DATA,
  lo_index_backward_records DYNAMIC ARRAY OF T_INDEX_DATA 
DEFINE 
  ls_sql   STRING,
  li_index INTEGER,
  li_count INTEGER

  IF ms_view_type = cs_view_type_db THEN
    LET ls_sql = "SELECT ''                       RECORD_TYPE,                                              ",    
                 "       ORIG.INDEX_NAME          INDEX_NAME,                                               ",
                 "       SRC_IDX_LIST.INDEX_TYPE  INDEX_TYPE_SRC,                                           ",
                 "       SRC_IDX_LIST.COLUMN_NAME COLUMN_NAME_SRC,                                          ",
                 "       DST_IDX_LIST.INDEX_TYPE  INDEX_TYPE_DST,                                           ",
                 "       DST_IDX_LIST.COLUMN_NAME COLUMN_NAME_DST                                           ",
                 "  FROM (                                                                                  ",
                 "         SELECT AIS.INDEX_NAME INDEX_NAME                                                 ",
                 "           FROM DBA_INDEXES AIS                                                           ",                 
                 "          WHERE AIS.OWNER        = '",ms_owner_name.toUpperCase(),"'                      ",              
                 "            AND AIS.TABLE_NAME   = '",ms_table_name.toUpperCase(),"'                      ",
                 {             
                 "            AND AIS.INDEX_NAME NOT IN (                                                   ",                                      
                 "                                        SELECT ACS.CONSTRAINT_NAME                        ",                                      
                 "                                          FROM DBA_CONSTRAINTS ACS                        ",                                      
                 "                                         WHERE ACS.TABLE_NAME = AIS.TABLE_NAME            ",                                      
                 "                                           AND ACS.OWNER      = AIS.OWNER                 ",                                      
                 "                                      )                                                   ",
                 }
                 "         UNION                                                                            ",                                      
                 "         SELECT UPPER(EW.DZEW004) INDEX_NAME                                              ",
                 "           FROM DZEW_T EW                                                                 ",
                 "          WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                            ",
                 "            AND EW.DZEW002 = '",ms_revision,"'                                            ",
                 "            AND EW.DZEW003 = 'Index'                                                      ",
                 "            AND EW.DZEW010 = '",ms_alm_version,"'                                         ",
                 "       ) ORIG,                                                                            ",
                 "       (                                                                                  ",
                 "         SELECT AIS.INDEX_NAME INDEX_NAME,                                                ",                                     
                 "                DECODE(AIS.UNIQUENESS,'UNIQUE','UNIQUE',AIS.INDEX_TYPE) INDEX_TYPE,       ",                                     
                 "                LISTAGG(AICS.COLUMN_NAME,',')                                             ",
                 "                 WITHIN GROUP                                                             ",
                 "                 (ORDER BY AIS.INDEX_NAME,AICS.COLUMN_POSITION) COLUMN_NAME               ",
                 "           FROM DBA_INDEXES AIS,DBA_IND_COLUMNS AICS                                      ",                                     
                 "          WHERE AIS.OWNER        = '",ms_owner_name.toUpperCase(),"'                      ",             
                 "            AND AIS.TABLE_NAME   = '",ms_table_name.toUpperCase(),"'                      ",            
                 "            AND AICS.TABLE_OWNER = AIS.TABLE_OWNER                                        ",                                     
                 "            AND AICS.TABLE_NAME  = AIS.TABLE_NAME                                         ",                                     
                 "            AND AICS.INDEX_NAME  = AIS.INDEX_NAME                                         ",
                 {                 
                 "            AND AIS.INDEX_NAME NOT IN (                                                   ",                                     
                 "                                        SELECT ACS.CONSTRAINT_NAME                        ",                                     
                 "                                          FROM DBA_CONSTRAINTS ACS                        ",                                     
                 "                                         WHERE ACS.TABLE_NAME = AIS.TABLE_NAME            ",                                     
                 "                                           AND ACS.OWNER      = AIS.OWNER                 ",                                     
                 "                                      )                                                   ",
                 }                 
                 "          GROUP BY AIS.INDEX_NAME,DECODE(AIS.UNIQUENESS,'UNIQUE','UNIQUE',AIS.INDEX_TYPE) ",
                 "       ) SRC_IDX_LIST,                                                                    ",
                 "       (                                                                                  ",
                 "         SELECT UPPER(EW.DZEW004) INDEX_NAME,                                             ",
                 "                DECODE(UPPER(EW.DZEW005),                                                 ",
                 "                       'N','NORMAL',                                                      ",
                 "                       'U','UNIQUE',                                                      ",
                 "                       UPPER(EW.DZEW005)) INDEX_TYPE,                                     ",
                 "                UPPER(REPLACE(EW.DZEW006,' ','')) COLUMN_NAME                             ",
                 "           FROM DZEW_T EW                                                                 ",
                 "          WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                            ",
                 "            AND EW.DZEW002 = '",ms_revision,"'                                            ",
                 "            AND EW.DZEW003 = 'Index'                                                      ",
                 "            AND EW.DZEW010 = '",ms_alm_version,"'                                         ",
                 "       ) DST_IDX_LIST                                                                     ",
                 " WHERE SRC_IDX_LIST.INDEX_NAME (+)= ORIG.INDEX_NAME                                       ",
                 "   AND DST_IDX_LIST.INDEX_NAME (+)= ORIG.INDEX_NAME                                       "
  ELSE 
    IF ms_view_type = cs_view_type_rt THEN
      LET ls_sql = "SELECT ''                       RECORD_TYPE,                                              ",    
                   "       ORIG.INDEX_NAME          INDEX_NAME,                                               ",
                   "       SRC_IDX_LIST.INDEX_TYPE  INDEX_TYPE_SRC,                                           ",
                   "       SRC_IDX_LIST.COLUMN_NAME COLUMN_NAME_SRC,                                          ",
                   "       DST_IDX_LIST.INDEX_TYPE  INDEX_TYPE_DST,                                           ",
                   "       DST_IDX_LIST.COLUMN_NAME COLUMN_NAME_DST                                           ",
                   "  FROM (                                                                                  ",
                   "         SELECT UPPER(EC.DZEC002) INDEX_NAME                                              ",                                     
                   "           FROM DZEC_T EC                                                                 ",                                      
                   "          WHERE EC.DZEC001 = '",ms_table_name.toLowerCase(),"'                            ",             
                   "         UNION                                                                            ",                                      
                   "         SELECT UPPER(EW.DZEW004) INDEX_NAME                                              ",
                   "           FROM DZEW_T EW                                                                 ",
                   "          WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                            ",
                   "            AND EW.DZEW002 = '",ms_revision,"'                                            ",
                   "            AND EW.DZEW003 = 'Index'                                                      ",
                   "            AND EW.DZEW010 = '",ms_alm_version,"'                                         ",
                   "       ) ORIG,                                                                            ",
                   "       (                                                                                  ",
                   "         SELECT UPPER(EC.DZEC002) INDEX_NAME,                                             ",                                     
                   "                DECODE(UPPER(EC.DZEC003),                                                 ",
                   "                       'N','NORMAL',                                                      ",
                   "                       'U','UNIQUE',                                                      ",
                   "                       UPPER(EC.DZEC003)) INDEX_TYPE,                                     ",                                             
                   "                UPPER(REPLACE(EC.DZEC004,' ','')) COLUMN_NAME                             ",                                     
                   "           FROM DZEC_T EC                                                                 ",                                     
                   "          WHERE EC.DZEC001 = '",ms_table_name.toLowerCase(),"'                            ",            
                   "       ) SRC_IDX_LIST,                                                                    ",
                   "       (                                                                                  ",
                   "         SELECT UPPER(EW.DZEW004) INDEX_NAME,                                             ",
                   "                DECODE(UPPER(EW.DZEW005),                                                 ",
                   "                       'N','NORMAL',                                                      ",
                   "                       'U','UNIQUE',                                                      ",
                   "                       UPPER(EW.DZEW005)) INDEX_TYPE,                                     ",
                   "                UPPER(REPLACE(EW.DZEW006,' ','')) COLUMN_NAME                             ",
                   "           FROM DZEW_T EW                                                                 ",
                   "          WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                            ",
                   "            AND EW.DZEW002 = '",ms_revision,"'                                            ",
                   "            AND EW.DZEW003 = 'Index'                                                      ",
                   "            AND EW.DZEW010 = '",ms_alm_version,"'                                         ",
                   "       ) DST_IDX_LIST                                                                     ",
                   " WHERE SRC_IDX_LIST.INDEX_NAME (+)= ORIG.INDEX_NAME                                       ",
                   "   AND DST_IDX_LIST.INDEX_NAME (+)= ORIG.INDEX_NAME                                       "
    END IF
  END IF   

  PREPARE lpre_fill_fill_index_diff_list FROM ls_sql
  DECLARE lcur_fill_fill_index_diff_list CURSOR FOR lpre_fill_fill_index_diff_list

  CALL m_diff_idx_list.clear()
  CALL m_diff_idx_list_color.clear()
  
  LET li_count = 1

  #取得索引差異資料
  CALL sadzi140_rdif_get_index_forward_records(ms_owner_name,ms_table_name) RETURNING lo_index_forward_records
  CALL sadzi140_rdif_get_index_backward_records(ms_owner_name,ms_table_name) RETURNING lo_index_backward_records
  
  #DISPLAY ls_TableName
  FOREACH lcur_fill_fill_index_diff_list INTO m_diff_idx_list[li_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET m_diff_idx_list[li_count].RECORD_TYPE = NULL
    
    LET m_diff_idx_list_color[li_count].RECORD_TYPE    = NULL
    LET m_diff_idx_list_color[li_count].INDEX_NAME     = NULL
    LET m_diff_idx_list_color[li_count].INDEX_TYPE_DB  = NULL
    LET m_diff_idx_list_color[li_count].COLUMN_NAME_DB = NULL
    LET m_diff_idx_list_color[li_count].INDEX_TYPE_RT  = NULL
    LET m_diff_idx_list_color[li_count].COLUMN_NAME_RT = NULL

    FOR li_index = 1 TO lo_index_forward_records.getLength()
      IF m_diff_idx_list[li_count].index_name = lo_index_forward_records[li_index].index_name THEN
        LET m_diff_idx_list[li_count].RECORD_TYPE = "!"
        LET m_diff_idx_list_color[li_count].RECORD_TYPE    = "red"
        LET m_diff_idx_list_color[li_count].INDEX_NAME     = "blue"
        LET m_diff_idx_list_color[li_count].INDEX_TYPE_RT  = "yellow reverse"
        LET m_diff_idx_list_color[li_count].COLUMN_NAME_RT = "yellow reverse"
        EXIT FOR;
      END IF    
    END FOR

    FOR li_index = 1 TO lo_index_backward_records.getLength()
      IF m_diff_idx_list[li_count].index_name = lo_index_backward_records[li_index].index_name THEN
        LET m_diff_idx_list[li_count].RECORD_TYPE = "!"
        LET m_diff_idx_list_color[li_count].RECORD_TYPE    = "red"
        LET m_diff_idx_list_color[li_count].INDEX_NAME     = "blue"
        LET m_diff_idx_list_color[li_count].INDEX_TYPE_DB  = "red reverse"
        LET m_diff_idx_list_color[li_count].COLUMN_NAME_DB = "red reverse"
        EXIT FOR
      END IF    
    END FOR
    
    LET li_count = li_count + 1
    
  END FOREACH
  #CALL m_diff_idx_list.deleteElement(li_count)

END FUNCTION

FUNCTION sadzi140_rdif_get_column_forward_records(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  lo_column_forward_records DYNAMIC ARRAY OF T_COLUMN_DATA
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_column_name STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  lo_return DYNAMIC ARRAY OF T_COLUMN_DATA

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 1

  ------------------------------------------------------------------------------------------------
  -- Column forward
  ------------------------------------------------------------------------------------------------

  IF ms_view_type = cs_view_type_db THEN
    LET ls_sql = "SELECT EV.DZEV005       COLUMN_NAME,                                         ",
                 "       EV.DZEV006       ISKEY,                                               ",
                 "       EV.DZEV007       NULLABLE,                                            ",
                 "       EV.DZEV008       DATA_TYPE,                                           ",
                 "       EV.DZEV009       DATA_LENGTH,                                         ",
                 "       TRIM(EV.DZEV021) DEFAULT_VALUE                                        ",
                 "  FROM DZEV_T EV                                                             ",
                 " WHERE EV.DZEV001 = '",ms_owner_name.toUpperCase(),"'                        ",
                 "   AND EV.DZEV002 = '",ms_table_name.toUpperCase(),"'                        ",
                 "   AND EV.DZEV003 = '",ms_revision,"'                                        ",
                 "   AND EV.DZEV004 = 'TableDesigner'                                          ",
                 "   AND EV.DZEV018 = '",ms_alm_version,"'                                     ",
                 "MINUS                                                                        ",
                 "SELECT ATC.COLUMN_NAME                      COLUMN_NAME,                     ",
                 "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                           ",
                 "       ATC.NULLABLE                         NULLABLE,                        ",
                 "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE,  ",
                 "       REPLACE(TO_CHAR(DECODE(                                               ",
                 "               ATC.DATA_TYPE,                                                ",
                 "               'NUMBER',DECODE(                                              ",
                 "                                NVL(ATC.DATA_SCALE,'0'),                     ",
                 "                                '0',ATC.DATA_PRECISION,                      ",
                 "                                ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE      ",
                 "                              ),                                             ",
                 "               ATC.DATA_LENGTH                                               ",
                 "             )),'.',',')                             DATA_LENGTH,            ",
                 "       TRIM(DS.GET_COL_DEFAULT(ATC.TABLE_NAME,ATC.COLUMN_NAME))  DEFAULT_VALUE ",
                 "  FROM DBA_TAB_COLUMNS ATC                                                   ",
                 "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER        ",
                 "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME   ",
                 "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME  ",
                 "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'     ",
                 " WHERE 1=1                                                                   ",
                 "   AND ATC.OWNER      = '",ls_owner.toUpperCase(),"'                         ",
                 "   AND ATC.TABLE_NAME = '",ls_table_name.toUpperCase(),"'                    ",
                 " ORDER BY 1                                                                  "
  ELSE 
    IF ms_view_type = cs_view_type_rt THEN
      LET ls_sql = "SELECT EV.DZEV005       COLUMN_NAME,                          ",
                   "       EV.DZEV006       ISKEY,                                ",
                   "       EV.DZEV007       NULLABLE,                             ",
                   "       EV.DZEV008       DATA_TYPE,                            ",
                   "       EV.DZEV009       DATA_LENGTH,                          ",
                   "       TRIM(EV.DZEV021) DEFAULT_VALUE                         ",
                   "  FROM DZEV_T EV                                              ",
                   " WHERE EV.DZEV001 = '",ms_owner_name.toUpperCase(),"'         ",
                   "   AND EV.DZEV002 = '",ms_table_name.toUpperCase(),"'         ",
                   "   AND EV.DZEV003 = '",ms_revision,"'                         ",
                   "   AND EV.DZEV004 = 'TableDesigner'                           ",
                   "   AND EV.DZEV018 = '",ms_alm_version,"'                      ",
                   "MINUS                                                         ",
                   "SELECT UPPER(EB.DZEB002)                      COLUMN_NAME,    ", 
                   "       EB.DZEB004                             ISKEY,          ", 
                   "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') NULLABLE,       ", 
                   "       UPPER(TD.GZTD003)                      DATA_TYPE,      ", 
                   "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(             ", 
                   "       DECODE(                                                ", 
                   "              UPPER(TD.GZTD003),                              ", 
                   "              'BLOB','4000',                                  ", 
                   "              'CLOB','4000',                                  ", 
                   "              'DATE','7',                                     ", 
                   "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),    ",
                   "              TD.GZTD008                                      ", 
                   "             ),',','.'),' ',''))),'.',',')    DATA_LENGTH,    ",
                   "       TRIM(EB.DZEB012)                       DEFAULT_VALUE   ",   
                   "  FROM DZEB_T EB                                              ", 
                   "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006   ", 
                   " WHERE EB.DZEB001 = '",ms_table_name.toLowerCase(),"'         ",
                   " ORDER BY 1                                                   "
    END IF
  END IF   
                
  PREPARE lpre_get_column_forward_records FROM ls_sql
  DECLARE lcur_get_column_forward_records CURSOR FOR lpre_get_column_forward_records

  OPEN lcur_get_column_forward_records
  FOREACH lcur_get_column_forward_records INTO lo_column_forward_records[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_column_forward_records

  FREE lpre_get_column_forward_records
  FREE lcur_get_column_forward_records  
  -------------------------------------------------------------------------------------------------
  
  LET lo_return.* = lo_column_forward_records.*
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi140_rdif_get_column_backward_records(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  lo_column_backward_records DYNAMIC ARRAY OF T_COLUMN_DATA
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_column_name STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  lo_return DYNAMIC ARRAY OF T_COLUMN_DATA

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 1

  ------------------------------------------------------------------------------------------------
  -- Column backward
  ------------------------------------------------------------------------------------------------

  IF ms_view_type = cs_view_type_db THEN
    LET ls_sql = "SELECT ATC.COLUMN_NAME                      COLUMN_NAME,                     ",
                 "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                           ",
                 "       ATC.NULLABLE                         NULLABLE,                        ",
                 "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE, ",
                 "       REPLACE(TO_CHAR(DECODE(                                               ",
                 "               ATC.DATA_TYPE,                                                ",
                 "               'NUMBER',DECODE(                                              ",
                 "                                NVL(ATC.DATA_SCALE,'0'),                     ",
                 "                                '0',ATC.DATA_PRECISION,                      ",
                 "                                ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE      ",
                 "                              ),                                             ",
                 "               ATC.DATA_LENGTH                                               ",
                 "             )),'.',',')                    DATA_LENGTH,                     ",
                 "       TRIM(DS.GET_COL_DEFAULT(ATC.TABLE_NAME,ATC.COLUMN_NAME))  DEFAULT_VALUE ",
                 "  FROM DBA_TAB_COLUMNS ATC                                                   ",
                 "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER        ",
                 "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME   ",
                 "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME  ",
                 "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'     ",
                 " WHERE 1=1                                                                   ",
                 "   AND ATC.OWNER      = '",ls_owner.toUpperCase(),"'                         ",
                 "   AND ATC.TABLE_NAME = '",ls_table_name.toUpperCase(),"'                    ",
                 "MINUS                                                                        ",
                 "SELECT EV.DZEV005       COLUMN_NAME,                                         ",
                 "       EV.DZEV006       ISKEY,                                               ",
                 "       EV.DZEV007       NULLABLE,                                            ",
                 "       EV.DZEV008       DATA_TYPE,                                           ",
                 "       EV.DZEV009       DATA_LENGTH,                                         ",
                 "       TRIM(EV.DZEV021) DEFAULT_VALUE                                        ",
                 "  FROM DZEV_T EV                                                             ",
                 " WHERE EV.DZEV001 = '",ms_owner_name.toUpperCase(),"'                        ",
                 "   AND EV.DZEV002 = '",ms_table_name.toUpperCase(),"'                        ",
                 "   AND EV.DZEV003 = '",ms_revision,"'                                        ",
                 "   AND EV.DZEV004 = 'TableDesigner'                                          ",
                 "   AND EV.DZEV018 = '",ms_alm_version,"'                                     ",
                 " ORDER BY 1                                                                  "
  ELSE 
    IF ms_view_type = cs_view_type_rt THEN
      LET ls_sql = "SELECT UPPER(EB.DZEB002)                      COLUMN_NAME,    ", 
                   "       EB.DZEB004                             ISKEY,          ", 
                   "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') NULLABLE,       ", 
                   "       UPPER(TD.GZTD003)                      DATA_TYPE,      ", 
                   "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(             ", 
                   "       DECODE(                                                ", 
                   "              UPPER(TD.GZTD003),                              ", 
                   "              'BLOB','4000',                                  ", 
                   "              'CLOB','4000',                                  ", 
                   "              'DATE','7',                                     ", 
                   "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),    ",
                   "              TD.GZTD008                                      ", 
                   "             ),',','.'),' ',''))),'.',',')    DATA_LENGTH,    ",
                   "       TRIM(EB.DZEB012)                       DEFAULT_VALUE   ",
                   "  FROM DZEB_T EB                                              ", 
                   "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006   ", 
                   " WHERE EB.DZEB001 = '",ms_table_name.toLowerCase(),"'         ",
                   "MINUS                                                         ",
                   "SELECT EV.DZEV005       COLUMN_NAME,                          ",
                   "       EV.DZEV006       ISKEY,                                ",
                   "       EV.DZEV007       NULLABLE,                             ",
                   "       EV.DZEV008       DATA_TYPE,                            ",
                   "       EV.DZEV009       DATA_LENGTH,                          ",
                   "       TRIM(EV.DZEV021) DEFAULT_VALUE                         ",
                   "  FROM DZEV_T EV                                              ",
                   " WHERE EV.DZEV001 = '",ms_owner_name.toUpperCase(),"'         ",
                   "   AND EV.DZEV002 = '",ms_table_name.toUpperCase(),"'         ",
                   "   AND EV.DZEV003 = '",ms_revision,"'                         ",
                   "   AND EV.DZEV004 = 'TableDesigner'                           ",
                   "   AND EV.DZEV018 = '",ms_alm_version,"'                      ",
                   " ORDER BY 1                                                   "
    END IF
  END IF   
                
  PREPARE lpre_get_column_backward_records FROM ls_sql
  DECLARE lcur_get_column_backward_records CURSOR FOR lpre_get_column_backward_records

  OPEN lcur_get_column_backward_records
  FOREACH lcur_get_column_backward_records INTO lo_column_backward_records[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_column_backward_records
  
  FREE lpre_get_column_backward_records
  FREE lcur_get_column_backward_records  
  -------------------------------------------------------------------------------------------------
  
  LET lo_return.* = lo_column_backward_records.*
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi140_rdif_get_index_forward_records(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  lo_index_forward_records DYNAMIC ARRAY OF T_INDEX_DATA
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_index_name STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  lo_return DYNAMIC ARRAY OF T_INDEX_DATA  

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 1

  ------------------------------------------------------------------------------------------------
  -- Index forward
  ------------------------------------------------------------------------------------------------
  IF ms_view_type = cs_view_type_db THEN
    LET ls_sql = "SELECT UPPER(EW.DZEW001) TABLE_NAME,                                                                         ",
                 "       UPPER(EW.DZEW004) INDEX_NAME,                                                                         ",
                 "       DECODE(UPPER(EW.DZEW005),                                                                             ",
                 "              'N','NORMAL',                                                                                  ",
                 "              'U','UNIQUE',                                                                                  ",
                 "              UPPER(EW.DZEW005)) INDEX_TYPE,                                                                 ",
                 "       UPPER(REPLACE(EW.DZEW006,' ','')) COLUMN_NAME                                                         ",
                 "  FROM DZEW_T EW                                                                                             ",
                 " WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                                                        ",
                 "   AND EW.DZEW002 = '",ms_revision,"'                                                                        ",
                 "   AND EW.DZEW003 = 'Index'                                                                                  ",
                 "   AND EW.DZEW010 = '",ms_alm_version,"'                                                                     ",
                 " MINUS                                                                                                       ",
                 "SELECT AIS.TABLE_NAME TABLE_NAME,                                                                            ",
                 "       AIS.INDEX_NAME INDEX_NAME,                                                                            ",
                 "       DECODE(AIS.UNIQUENESS,'UNIQUE','UNIQUE',AIS.INDEX_TYPE) INDEX_TYPE,                                   ",
                 "       LISTAGG(AICS.COLUMN_NAME,',') WITHIN GROUP (ORDER BY AIS.INDEX_NAME,AICS.COLUMN_POSITION) COLUMN_NAME ",
                 "  FROM DBA_INDEXES AIS,DBA_IND_COLUMNS AICS                                                                  ",
                 " WHERE AIS.OWNER        = '",ls_owner.toUpperCase(),"'                                                       ",
                 "   AND AIS.TABLE_NAME   = '",ls_table_name.toUpperCase(),"'                                                  ",
                 "   AND AICS.TABLE_OWNER = AIS.TABLE_OWNER                                                                    ",
                 "   AND AICS.TABLE_NAME  = AIS.TABLE_NAME                                                                     ",
                 "   AND AICS.INDEX_NAME  = AIS.INDEX_NAME                                                                     ",
                 {
                 "   AND AIS.INDEX_NAME NOT IN (                                                                               ",
                 "                               SELECT ACS.CONSTRAINT_NAME                                                    ",
                 "                                 FROM DBA_CONSTRAINTS ACS                                                    ",
                 "                                WHERE ACS.TABLE_NAME = AIS.TABLE_NAME                                        ",
                 "                                  AND ACS.OWNER      = AIS.OWNER                                             ",
                 "                             )                                                                               ",
                 }
                 " GROUP BY AIS.TABLE_NAME,AIS.INDEX_NAME,DECODE(AIS.UNIQUENESS,'UNIQUE','UNIQUE',AIS.INDEX_TYPE)              "
  ELSE 
    IF ms_view_type = cs_view_type_rt THEN
      LET ls_sql = "SELECT UPPER(EW.DZEW001) TABLE_NAME,                                                                         ",
                   "       UPPER(EW.DZEW004) INDEX_NAME,                                                                         ",
                   "       DECODE(UPPER(EW.DZEW005),                                                                             ",
                   "              'N','NORMAL',                                                                                  ",
                   "              'U','UNIQUE',                                                                                  ",
                   "              UPPER(EW.DZEW005)) INDEX_TYPE,                                                                 ",
                   "       UPPER(REPLACE(EW.DZEW006,' ','')) COLUMN_NAME                                                         ",
                   "  FROM DZEW_T EW                                                                                             ",
                   " WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                                                        ",
                   "   AND EW.DZEW002 = '",ms_revision,"'                                                                        ",
                   "   AND EW.DZEW003 = 'Index'                                                                                  ",
                   "   AND EW.DZEW010 = '",ms_alm_version,"'                                                                     ",
                   " MINUS                                                                                                       ",
                   "SELECT UPPER(EC.DZEC001) TABLE_NAME,                                                                         ",
                   "       UPPER(EC.DZEC002) INDEX_NAME,                                                                         ",
                   "       DECODE(UPPER(EC.DZEC003),                                                                             ",
                   "              'N','NORMAL',                                                                                  ",
                   "              'U','UNIQUE',                                                                                  ",
                   "              UPPER(EC.DZEC003)) INDEX_TYPE,                                                                 ",                                             
                   "       UPPER(REPLACE(EC.DZEC004,' ','')) COLUMN_NAME                                                         ",
                   "  FROM DZEC_T EC                                                                                             ",
                   " WHERE EC.DZEC001 = '",ls_table_name.toLowerCase(),"'                                                        "
    END IF
  END IF   
                
  PREPARE lpre_get_index_forward_records FROM ls_sql
  DECLARE lcur_get_index_forward_records CURSOR FOR lpre_get_index_forward_records

  OPEN lcur_get_index_forward_records
  FOREACH lcur_get_index_forward_records INTO lo_index_forward_records[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_index_forward_records
  
  FREE lpre_get_index_forward_records
  FREE lcur_get_index_forward_records  
  -------------------------------------------------------------------------------------------------
  
  LET lo_return.* = lo_index_forward_records.*
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi140_rdif_get_index_backward_records(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  lo_index_backward_records DYNAMIC ARRAY OF T_INDEX_DATA
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_index_name STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  lo_return DYNAMIC ARRAY OF T_INDEX_DATA  

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 1

  ------------------------------------------------------------------------------------------------
  -- Index backward
  ------------------------------------------------------------------------------------------------
  IF ms_view_type = cs_view_type_db THEN
    LET ls_sql = "SELECT AIS.TABLE_NAME TABLE_NAME,                                                                            ",
                 "       AIS.INDEX_NAME INDEX_NAME,                                                                            ",
                 "       DECODE(AIS.UNIQUENESS,'UNIQUE','UNIQUE',AIS.INDEX_TYPE) INDEX_TYPE,                                   ",
                 "       LISTAGG(AICS.COLUMN_NAME,',') WITHIN GROUP (ORDER BY AIS.INDEX_NAME,AICS.COLUMN_POSITION) COLUMN_NAME ",
                 "  FROM DBA_INDEXES AIS,DBA_IND_COLUMNS AICS                                                                  ",
                 " WHERE AIS.OWNER        = '",ls_owner.toUpperCase(),"'                                                       ",
                 "   AND AIS.TABLE_NAME   = '",ls_table_name.toUpperCase(),"'                                                  ",
                 "   AND AICS.TABLE_OWNER = AIS.TABLE_OWNER                                                                    ",
                 "   AND AICS.TABLE_NAME  = AIS.TABLE_NAME                                                                     ",
                 "   AND AICS.INDEX_NAME  = AIS.INDEX_NAME                                                                     ",
                 {
                 "   AND AIS.INDEX_NAME NOT IN (                                                                               ",
                 "                               SELECT ACS.CONSTRAINT_NAME                                                    ",
                 "                                 FROM DBA_CONSTRAINTS ACS                                                    ",
                 "                                WHERE ACS.TABLE_NAME = AIS.TABLE_NAME                                        ",
                 "                                  AND ACS.OWNER      = AIS.OWNER                                             ",
                 "                             )                                                                               ",
                 }
                 " GROUP BY AIS.TABLE_NAME,AIS.INDEX_NAME,DECODE(AIS.UNIQUENESS,'UNIQUE','UNIQUE',AIS.INDEX_TYPE)              ",
                 "MINUS                                                                                                        ",
                 "SELECT UPPER(EW.DZEW001) TABLE_NAME,                                                                         ",
                 "       UPPER(EW.DZEW004) INDEX_NAME,                                                                         ",
                 "       DECODE(UPPER(EW.DZEW005),                                                                             ",
                 "              'N','NORMAL',                                                                                  ",
                 "              'U','UNIQUE',                                                                                  ",
                 "              UPPER(EW.DZEW005)) INDEX_TYPE,                                                                 ",
                 "       UPPER(REPLACE(EW.DZEW006,' ','')) COLUMN_NAME                                                         ",
                 "  FROM DZEW_T EW                                                                                             ",
                 " WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                                                        ",
                 "   AND EW.DZEW002 = '",ms_revision,"'                                                                        ",
                 "   AND EW.DZEW003 = 'Index'                                                                                  ",
                 "   AND EW.DZEW010 = '",ms_alm_version,"'                                                                     "
  ELSE 
    IF ms_view_type = cs_view_type_rt THEN
      LET ls_sql = "SELECT UPPER(EC.DZEC001) TABLE_NAME,                                                                         ",
                   "       UPPER(EC.DZEC002) INDEX_NAME,                                                                         ",
                   "       DECODE(UPPER(EC.DZEC003),                                                                             ",
                   "              'N','NORMAL',                                                                                  ",
                   "              'U','UNIQUE',                                                                                  ",
                   "              UPPER(EC.DZEC003)) INDEX_TYPE,                                                                 ",                                             
                   "       UPPER(REPLACE(EC.DZEC004,' ','')) COLUMN_NAME                                                         ",
                   "  FROM DZEC_T EC                                                                                             ",
                   " WHERE EC.DZEC001 = '",ls_table_name.toLowerCase(),"'                                                        ",
                   " MINUS                                                                                                       ",
                   "SELECT UPPER(EW.DZEW001) TABLE_NAME,                                                                         ",
                   "       UPPER(EW.DZEW004) INDEX_NAME,                                                                         ",
                   "       DECODE(UPPER(EW.DZEW005),                                                                             ",
                   "              'N','NORMAL',                                                                                  ",
                   "              'U','UNIQUE',                                                                                  ",
                   "              UPPER(EW.DZEW005)) INDEX_TYPE,                                                                 ",
                   "       UPPER(REPLACE(EW.DZEW006,' ','')) COLUMN_NAME                                                         ",
                   "  FROM DZEW_T EW                                                                                             ",
                   " WHERE EW.DZEW001 = '",ms_table_name.toLowerCase(),"'                                                        ",
                   "   AND EW.DZEW002 = '",ms_revision,"'                                                                        ",
                   "   AND EW.DZEW003 = 'Index'                                                                                  ",
                   "   AND EW.DZEW010 = '",ms_alm_version,"'                                                                     "
    END IF
  END IF   
                
  PREPARE lpre_get_index_backward_records FROM ls_sql
  DECLARE lcur_get_index_backward_records CURSOR FOR lpre_get_index_backward_records

  OPEN lcur_get_index_backward_records
  FOREACH lcur_get_index_backward_records INTO lo_index_backward_records[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_index_backward_records
  
  FREE lpre_get_index_backward_records
  FREE lcur_get_index_backward_records  
  -------------------------------------------------------------------------------------------------
  
  LET lo_return.* = lo_index_backward_records.*
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi140_rdif_fill_diff_list_by_column_id()
DEFINE 
  ls_sql   STRING,
  li_index INTEGER,
  li_count INTEGER
  
  IF ms_view_type = cs_view_type_db THEN
    LET ls_sql = "SELECT ''              RECORD_TYPE,                                                              ",
                 "       RO.ROW_NUM      ROW_NUM,                                                                  ",
                 "       SRC.COLUMN_NAME SRC_COL_NAME,                                                             ",
                 "       DST.COLUMN_NAME DST_COL_NAME                                                              ",
                 "  FROM (                                                                                         ",
                 "          SELECT ROWNUM ROW_NUM                                                                  ",
                 "            FROM DUAL                                                                            ",
                 "         CONNECT BY LEVEL <= (                                                                   ",
                 "                               SELECT MAX(MX.MAX_VALUE) MAX_VALUE                                ",
                 "                                 FROM (                                                          ",
                 "                                        SELECT MAX(NVL(EV.DZEV011,0)) MAX_VALUE                  ",
                 "                                          FROM DZEV_T EV                                         ",
                 "                                         WHERE EV.DZEV001 = '",ms_owner_name.toUpperCase(),"'    ",
                 "                                           AND EV.DZEV002 = '",ms_table_name.toUpperCase(),"'    ",
                 "                                           AND EV.DZEV003 = '",ms_revision,"'                    ",
                 "                                           AND EV.DZEV004 = 'TableDesigner'                      ",
                 "                                           AND EV.DZEV018 = '",ms_alm_version,"'                 ",
                 "                                        UNION ALL                                                ",
                 "                                        SELECT MAX(ATC.COLUMN_ID) MAX_VALUE                      ",
                 "                                          FROM DBA_TAB_COLUMNS ATC                               ",
                 "                                         WHERE ATC.OWNER      = '",ms_owner_name.toUpperCase(),"'",    
                 "                                           AND ATC.TABLE_NAME = '",ms_table_name.toUpperCase(),"'",
                 "                                      ) MX                                                       ",
                 "                             )                                                                   ",
                 "       ) RO,                                                                                     ",
                 "       (                                                                                         ",
                 "         SELECT ATC.COLUMN_ID   ROW_NUM,                                                         ",
                 "                ATC.COLUMN_NAME COLUMN_NAME                                                      ",
                 "           FROM DBA_TAB_COLUMNS ATC                                                              ",
                 "          WHERE ATC.OWNER      = '",ms_owner_name.toUpperCase(),"'                               ",   
                 "            AND ATC.TABLE_NAME = '",ms_table_name.toUpperCase(),"'                               ",
                 "            AND ATC.COLUMN_NAME <> 'DUMMY'                                                       ",
                 "       ) SRC,                                                                                    ",
                 "       (                                                                                         ",
                 "         SELECT EV.DZEV011        ROW_NUM,                                                       ",
                 "                UPPER(EV.DZEV005) COLUMN_NAME                                                    ",
                 "           FROM DZEV_T EV                                                                        ",
                 "         WHERE EV.DZEV001 = '",ms_owner_name.toUpperCase(),"'                                    ",
                 "           AND EV.DZEV002 = '",ms_table_name.toUpperCase(),"'                                    ",
                 "           AND EV.DZEV003 = '",ms_revision,"'                                                    ",
                 "           AND EV.DZEV004 = 'TableDesigner'                                                      ",
                 "           AND EV.DZEV018 = '",ms_alm_version,"'                                                 ",
                 "       ) DST                                                                                     ",
                 " WHERE SRC.ROW_NUM (+)= RO.ROW_NUM                                                               ",
                 "   AND DST.ROW_NUM (+)= RO.ROW_NUM                                                               ",
                 " ORDER BY RO.ROW_NUM                                                                             "
  ELSE 
    IF ms_view_type = cs_view_type_rt THEN
      LET ls_sql = "SELECT ''              RECORD_TYPE,                                                              ",
                   "       RO.ROW_NUM      ROW_NUM,                                                                  ",
                   "       SRC.COLUMN_NAME SRC_COL_NAME,                                                             ",
                   "       DST.COLUMN_NAME DST_COL_NAME                                                              ",
                   "  FROM (                                                                                         ",
                   "          SELECT ROWNUM ROW_NUM                                                                  ",
                   "            FROM DUAL                                                                            ",
                   "         CONNECT BY LEVEL <= (                                                                   ",
                   "                               SELECT MAX(MX.MAX_VALUE) MAX_VALUE                                ",
                   "                                 FROM (                                                          ",
                   "                                        SELECT MAX(NVL(EV.DZEV011,0)) MAX_VALUE                  ",
                   "                                          FROM DZEV_T EV                                         ",
                   "                                         WHERE EV.DZEV001 = '",ms_owner_name.toUpperCase(),"'    ",
                   "                                           AND EV.DZEV002 = '",ms_table_name.toUpperCase(),"'    ",
                   "                                           AND EV.DZEV003 = '",ms_revision,"'                    ",
                   "                                           AND EV.DZEV004 = 'TableDesigner'                      ",
                   "                                           AND EV.DZEV018 = '",ms_alm_version,"'                 ",
                   "                                        UNION ALL                                                ",
                   "                                        SELECT MAX(NVL(EB.DZEB021,0)) MAX_VALUE                  ",
                   "                                          FROM DZEB_T EB                                         ",
                   "                                        WHERE EB.DZEB001 = '",ms_table_name.toLowerCase(),"'     ",
                   "                                      ) MX                                                       ",
                   "                             )                                                                   ",
                   "       ) RO,                                                                                     ",
                   "       (                                                                                         ",
                   "         SELECT EB.DZEB021        ROW_NUM,                                                       ",
                   "                UPPER(EB.DZEB002) COLUMN_NAME                                                    ",
                   "           FROM DZEB_T EB                                                                        ",
                   "         WHERE EB.DZEB001 = '",ms_table_name.toLowerCase(),"'                                    ",
                   "       ) SRC,                                                                                    ",
                   "       (                                                                                         ",
                   "         SELECT EV.DZEV011        ROW_NUM,                                                       ",
                   "                UPPER(EV.DZEV005) COLUMN_NAME                                                    ",
                   "           FROM DZEV_T EV                                                                        ",
                   "         WHERE EV.DZEV001 = '",ms_owner_name.toUpperCase(),"'                                    ",
                   "           AND EV.DZEV002 = '",ms_table_name.toUpperCase(),"'                                    ",
                   "           AND EV.DZEV003 = '",ms_revision,"'                                                    ",
                   "           AND EV.DZEV004 = 'TableDesigner'                                                      ",
                   "           AND EV.DZEV018 = '",ms_alm_version,"'                                                 ",
                   "       ) DST                                                                                     ",
                   " WHERE SRC.ROW_NUM (+)= RO.ROW_NUM                                                               ",
                   "   AND DST.ROW_NUM (+)= RO.ROW_NUM                                                               ",
                   " ORDER BY RO.ROW_NUM                                                                             "
    END IF
  END IF     

  PREPARE lpre_fill_diff_list_by_column_id FROM ls_sql
  DECLARE lcur_fill_diff_list_by_column_id CURSOR FOR lpre_fill_diff_list_by_column_id

  CALL m_diff_list_by_column_id.clear()
  CALL m_diff_list_by_column_id_color.clear()
  
  LET li_count = 1

  #DISPLAY ls_TableName
  FOREACH lcur_fill_diff_list_by_column_id INTO m_diff_list_by_column_id[li_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET m_diff_list_by_column_id[li_count].RECORD_TYPE = NULL

    LET m_diff_list_by_column_id_color[li_count].RECORD_TYPE    = NULL
    LET m_diff_list_by_column_id_color[li_count].COLUMN_ID      = NULL
    LET m_diff_list_by_column_id_color[li_count].DB_COLUMN_NAME = NULL
    LET m_diff_list_by_column_id_color[li_count].RT_COLUMN_NAME = NULL

    IF NVL(m_diff_list_by_column_id[li_count].DB_COLUMN_NAME,cs_null_value) <> NVL(m_diff_list_by_column_id[li_count].RT_COLUMN_NAME,cs_null_value) THEN
      LET m_diff_list_by_column_id[li_count].RECORD_TYPE = "!"
      LET m_diff_list_by_column_id_color[li_count].RECORD_TYPE    = "red"
      LET m_diff_list_by_column_id_color[li_count].DB_COLUMN_NAME = "red reverse"
      LET m_diff_list_by_column_id_color[li_count].RT_COLUMN_NAME = "yellow reverse"
    END IF
    
    LET li_count = li_count + 1
    
  END FOREACH

END FUNCTION