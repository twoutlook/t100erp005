&include "../4gl/sadzi140_mcr.inc"

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzi140_type.inc"
&include "../4gl/sadzi140_cnst.inc"

#新增表格設計器表格資料的快照
FUNCTION sadzi140_shot_set_table_designer_snapshot(p_owner,p_table_name,p_version,p_curr_version,p_alm_version,p_alm_request_no,p_dgenv)
DEFINE
  p_owner          STRING,
  p_table_name     STRING,
  p_version        STRING,
  p_curr_version   STRING, 
  p_alm_version    STRING,
  p_alm_request_no STRING,
  p_dgenv          STRING  
DEFINE
  ls_owner        STRING,
  ls_table_name   STRING,
  ls_version      STRING,
  ls_curr_version STRING, 
  ls_alm_version  STRING, 
  ls_alm_request_no STRING, 
  ls_dgenv          STRING,  
  ls_sql          STRING,
  li_count        INTEGER,
  lo_snapshot     T_SNAPSHOT

  LET ls_owner          = p_owner.toUpperCase()
  LET ls_table_name     = p_table_name.toLowerCase()
  LET ls_version        = p_version
  LET ls_curr_version   = p_curr_version
  LET ls_alm_version    = p_alm_version
  LET ls_alm_request_no = p_alm_request_no
  LET ls_dgenv          = p_dgenv
  
  LET li_count = 1

  BEGIN WORK
  
  LET ls_sql = "SELECT ''                                     OWNER,           ",
               "       ''                                     TABLE_NAME,      ",
               "       ''                                     VERSION,         ",
               "       ''                                     CODE_TYPE,       ",               
               "       UPPER(EB.DZEB002)                      COLUMN_NAME,     ",
               "       EB.DZEB004                             ISKEY,           ",
               "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') NULLABLE,        ",
               "       UPPER(TD.GZTD003)                      DATA_TYPE,       ",
               "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(              ", 
               "       DECODE(                                                 ",
               "              UPPER(TD.GZTD003),                               ",
               "              'BLOB','4000',                                   ",
               "              'CLOB','4000',                                   ",
               "              'DATE','7',                                      ",
               "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),     ",
               "              TD.GZTD008                                       ",
               "             ),',','.'),' ',''))),'.',',')    DATA_LENGTH,     ",
               "       EB.DZEB003                             COMMENTS,        ",      
               "       EB.DZEB021                             COLUMN_SEQ,      ",
               "       ''                                     PREV_VERSION,    ",
               "       EB.DZEB006                             COLUMN_TYPE,     ",
               "       EB.DZEB021                             COLUMN_SEQ,      ",
               "       EB.DZEB022                             COLUMN_TYPE_DEF, ",
               "       EB.DZEB023                             NUMBER_TYPE_SEQ, ",
               "       EB.DZEB024                             COLUMN_MEMO,     ",
               "       ''                                     ALM_VERSION,     ",
               "       ''                                     ALM_REQUEST_NO,  ",
               "       EB.DZEB029                             DGENV,           ",
               "       EB.DZEB012                             DEFAULTV,        ", 
               "       EB.DZEB030                             ORIG_DGENV,      ",
               "       EB.DZEB031                             SHIPPING_CODE    ", 
               "  FROM DZEB_T EB                                               ",   
               "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006    ",   
               " WHERE EB.DZEB001 = '",ls_table_name,"'                        ",
               " ORDER BY EB.DZEB021                                           "

  PREPARE lpre_GetTableDesignerSnapshot FROM ls_sql
  DECLARE lcur_GetTableDesignerSnapshot CURSOR FOR lpre_GetTableDesignerSnapshot
  
  FOREACH lcur_GetTableDesignerSnapshot INTO lo_snapshot.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET lo_snapshot.DZEV001 = ls_owner
    LET lo_snapshot.DZEV002 = ls_table_name.toUpperCase()
    LET lo_snapshot.DZEV003 = ls_version
    LET lo_snapshot.DZEV004 = cs_table_designer
    LET lo_snapshot.DZEV012 = ls_curr_version
    LET lo_snapshot.DZEV018 = ls_alm_version
    LET lo_snapshot.DZEV019 = ls_alm_request_no
    
    CALL sadzi140_shot_insert_DZEV_T(lo_snapshot.*)

    LET li_count = li_count + 1
    
  END FOREACH

  COMMIT WORK
  
END FUNCTION

#新增現行表格的快照
FUNCTION sadzi140_shot_set_database_snapshot(p_owner,p_table_name,p_version,p_curr_version,p_alm_version,p_alm_request_no,p_dgenv)
DEFINE
  p_owner          STRING, 
  p_table_name     STRING,
  p_version        STRING,
  p_curr_version   STRING, 
  p_alm_version    STRING,
  p_alm_request_no STRING,
  p_dgenv          STRING  
DEFINE
  lo_snapshot       T_SNAPSHOT,
  ls_owner          STRING, 
  ls_table_name     STRING,
  ls_version        STRING,
  ls_curr_version   STRING, 
  ls_alm_version    STRING,
  ls_alm_request_no STRING, 
  ls_dgenv          STRING,  
  ls_sql            STRING,
  li_count          INTEGER

  LET ls_owner          = p_owner.toUpperCase()
  LET ls_table_name     = p_table_name.toUpperCase()
  LET ls_version        = p_version
  LET ls_curr_version   = p_curr_version
  LET ls_alm_version    = p_alm_version
  LET ls_alm_request_no = p_alm_request_no
  LET ls_dgenv          = p_dgenv
  
  LET li_count = 1

  ##############################################################################
  BEGIN WORK
  
  LET ls_sql = "SELECT ATC.OWNER                            OWNER,                           ",
               "       ATC.TABLE_NAME                       TABLE_NAME,                      ",
               "       ''                                   VERSION,                         ",
               "       ''                                   CODE_TYPE,                       ",               
               "       ATC.COLUMN_NAME                      COLUMN_NAME,                     ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                           ",
               "       ATC.NULLABLE                         NULLABLE,                        ",
               "       ATC.DATA_TYPE                        DATA_TYPE,                       ",
               "       REPLACE(TO_CHAR(DECODE(                                               ",
               "               ATC.DATA_TYPE,                                                ",
               "               'NUMBER',DECODE(                                              ",
               "                                NVL(ATC.DATA_SCALE,'0'),                     ",
               "                                '0',ATC.DATA_PRECISION,                      ",
               "                                ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE      ",
               "                              ),                                             ",
               "               ATC.DATA_LENGTH                                               ",
               "             )),'.',',')                    DATA_LENGTH,                     ",
               "       ACT.COMMENTS                         COMMENTS,                        ",   
               "       ''                                   COLUMN_SEQ,                      ",
               "       ''                                   PREV_VERSION,                    ",
               "       ''                                   COLUMN_TYPE,                     ",
               "       ''                                   COLUMN_SEQ,                      ",
               "       ''                                   COLUMN_TYPE_DEF,                 ",
               "       ''                                   NUMBER_TYPE_SEQ,                 ",
               "       ''                                   COLUMN_MEMO,                     ",
               "       ''                                   ALM_VERSION,                     ",
               "       ''                                   ALM_REQUEST_NO,                  ",
               "       ''                                   DGENV,                           ",
               "       ''                                   DEFAULTV,                        ",  
               "       ''                                   ORG_DGENV,                       ",
               "       ''                                   SHIPPING_NOTICE                  ",
               "  FROM DBA_TAB_COLUMNS ATC                                                   ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER        ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME   ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME  ",
               "  LEFT OUTER JOIN DBA_COL_COMMENTS ACT ON ACT.OWNER       = ATC.OWNER        ",        
               "                                      AND ACT.TABLE_NAME  = ATC.TABLE_NAME   ",
               "                                      AND ACT.COLUMN_NAME = ATC.COLUMN_NAME  ",
               " WHERE 1=1                                                                   ",
               "   AND ATC.OWNER      = '",ls_owner,"'                                       ",
               "   AND ATC.TABLE_NAME = '",ls_table_name,"'                                  ",
               "   AND ATC.COLUMN_NAME NOT LIKE 'SYS_%'                                      ",
               " ORDER BY ATC.COLUMN_NAME                                                    "

  PREPARE lpre_get_database_snapshot FROM ls_sql
  DECLARE lcur_get_database_snapshot CURSOR FOR lpre_get_database_snapshot
  
  FOREACH lcur_get_database_snapshot INTO lo_snapshot.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET lo_snapshot.DZEV001 = ls_owner
    LET lo_snapshot.DZEV002 = ls_table_name
    LET lo_snapshot.DZEV003 = ls_version
    LET lo_snapshot.DZEV004 = cs_database
    LET lo_snapshot.DZEV012 = ls_curr_version
    LET lo_snapshot.DZEV018 = ls_alm_version
    LET lo_snapshot.DZEV019 = ls_alm_request_no
    LET lo_snapshot.DZEV020 = ls_dgenv
    LET lo_snapshot.DZEV022 = ls_dgenv
    LET lo_snapshot.DZEV023 = "N"

    CALL sadzi140_shot_insert_DZEV_T(lo_snapshot.*)
    
    LET li_count = li_count + 1
    
  END FOREACH

  COMMIT WORK
  ##############################################################################

  ## 更新序號, 有就更新, 沒有留空白 #################################################
  BEGIN WORK
  
  LET ls_sql = "UPDATE DZEV_T EV                                                  ",
               "   SET EV.DZEV011 = (                                             ",
               "                      SELECT EV2.DZEV011                          ",
               "                        FROM DZEV_T EV2                           ",
               "                       WHERE EV2.DZEV001 = EV.DZEV001             ",
               "                         AND EV2.DZEV002 = EV.DZEV002             ",
               "                         AND EV2.DZEV003 = EV.DZEV003             ",
               "                         AND EV2.DZEV005 = EV.DZEV005             ",
               "                         AND EV2.DZEV004 = '",cs_table_designer,"'",  
               "                    )                                             ",
               " WHERE EV.DZEV001 = '",ls_owner,"'                                ",
               "   AND EV.DZEV002 = '",ls_table_name,"'                           ",
               "   AND EV.DZEV003 = '",ls_version,"'                              ",
               "   AND EV.DZEV004 = '",cs_database,"'                             "

  TRY
    PREPARE lpre_update_seq_no FROM ls_sql
    EXECUTE lpre_update_seq_no
  CATCH
  END TRY
  
  COMMIT WORK
  ##############################################################################
  
END FUNCTION

FUNCTION sadzi140_shot_insert_DZEV_T(p_snapshot)
DEFINE
  p_snapshot  T_SNAPSHOT
DEFINE
  lo_snapshot  T_SNAPSHOT

  LET lo_snapshot.* = p_snapshot.*

  TRY
    INSERT INTO DZEV_T(
                        DZEV001,DZEV002,DZEV003,DZEV004,DZEV005,
                        DZEV006,DZEV007,DZEV008,DZEV009,DZEV010,
                        DZEV011,DZEV012,DZEV013,DZEV014,DZEV015,
                        DZEV016,DZEV017,DZEV018,DZEV019,DZEV020,
                        DZEV021,DZEV022,DZEV023
                      ) 
               VALUES (
                        lo_snapshot.DZEV001,lo_snapshot.DZEV002,lo_snapshot.DZEV003,lo_snapshot.DZEV004,lo_snapshot.DZEV005,
                        lo_snapshot.DZEV006,lo_snapshot.DZEV007,lo_snapshot.DZEV008,lo_snapshot.DZEV009,lo_snapshot.DZEV010,
                        lo_snapshot.DZEV011,lo_snapshot.DZEV012,lo_snapshot.DZEV013,lo_snapshot.DZEV014,lo_snapshot.DZEV015,
                        lo_snapshot.DZEV016,lo_snapshot.DZEV017,lo_snapshot.DZEV018,lo_snapshot.DZEV019,lo_snapshot.DZEV020,
                        lo_snapshot.DZEV021,lo_snapshot.DZEV022,lo_snapshot.DZEV023
                      )
  CATCH 
    DISPLAY cs_warning_tag,"Insert snapshot into DZEV_T fault."
    #ROLLBACK WORK
    #BEGIN WORK
  END TRY  
  
END FUNCTION

FUNCTION sadzi140_shot_create_snapshot(p_master_user,p_table_name,p_curr_version,p_new_version,p_alm_version,p_alm_request_no,p_dgenv)
DEFINE
  p_master_user    STRING,
  p_table_name     STRING,
  p_curr_version   STRING,
  p_new_version    STRING,
  p_alm_version    STRING,
  p_alm_request_no STRING,
  p_dgenv          STRING 
DEFINE
  ls_master_user      STRING,
  ls_table_name       STRING,
  ls_curr_version     STRING,
  ls_new_version      STRING,
  ls_alm_version      STRING,
  ls_alm_request_no   STRING,
  ls_dgenv            STRING,
  lo_constraint_index DYNAMIC ARRAY OF T_CONSTRAINT_INDEX

  LET ls_master_user    = p_master_user
  LET ls_table_name     = p_table_name
  LET ls_curr_version   = p_curr_version
  LET ls_new_version    = p_new_version
  LET ls_alm_version    = p_alm_version
  LET ls_alm_request_no = p_alm_request_no
  LET ls_dgenv          = p_dgenv
  
  CALL sadzi140_shot_set_table_designer_snapshot(ls_master_user,ls_table_name,ls_new_version,ls_curr_version,ls_alm_version,ls_alm_request_no,ls_dgenv)
  CALL sadzi140_shot_set_database_snapshot(ls_master_user,ls_table_name,ls_new_version,ls_curr_version,ls_alm_version,ls_alm_request_no,ls_dgenv)
  CALL sadzi140_shot_get_constraint_index_data(ls_table_name,ls_new_version,ls_curr_version,ls_alm_version,ls_alm_request_no,ls_dgenv) RETURNING lo_constraint_index
  IF lo_constraint_index.getLength() >= 1 THEN  
    CALL sadzi140_shot_set_constraint_index_data(lo_constraint_index)
  END IF  
  
END FUNCTION

FUNCTION sadzi140_shot_check_diff(p_owner,p_table_name,p_drop_abnormal_column)
DEFINE
  p_owner      STRING,
  p_table_name STRING,
  p_drop_abnormal_column BOOLEAN
DEFINE
  ls_owner            STRING,
  ls_table_name       STRING,
  lb_drop_abnormal_column BOOLEAN,
  lo_column_diff      DYNAMIC ARRAY OF T_COLUMN_DIFF,
  lo_index_diff       DYNAMIC ARRAY OF T_INDEX_DIFF,
  lo_constraint_diff  DYNAMIC ARRAY OF T_CONSTRAINT_DIFF,
  lb_different        BOOLEAN,
  lb_alter            BOOLEAN
DEFINE
  lb_return        BOOLEAN
  
  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  LET lb_drop_abnormal_column = p_drop_abnormal_column

  LET lb_different = FALSE
  LET lb_alter     = FALSE

  #與 r.t 的資料比對看有無差異(比對表格欄位)
  CALL sadzi140_shot_check_column_diff(ls_owner,ls_table_name,lb_drop_abnormal_column) RETURNING lb_different,lo_column_diff
  IF lb_different THEN 
    LET lb_alter = TRUE 
    #DISPLAY "比對表格欄位" 
    #DISPLAY "curr_version",ls_curr_version 
  END IF

  #與 r.t 的資料比對看有無差異(比對Constraint)
  CALL sadzi140_shot_check_constraint_diff(ls_owner,ls_table_name,lb_drop_abnormal_column) RETURNING lb_different,lo_constraint_diff
  IF lb_different THEN 
    LET lb_alter = TRUE 
    #DISPLAY "比對 Constraint diff" 
    #DISPLAY "curr_version",ls_curr_version 
  END IF
  
  #與 r.t 的資料比對看有無差異(比對Index)
  CALL sadzi140_shot_check_index_diff(ls_owner,ls_table_name,lb_drop_abnormal_column) RETURNING lb_different,lo_index_diff
  IF lb_different THEN 
    LET lb_alter = TRUE 
    #DISPLAY "比對 Index diff" 
    #DISPLAY "curr_version",ls_curr_version 
  END IF

  LET lb_return = lb_alter
  
  RETURN lb_return
  
END FUNCTION

#比對現行 Table Editor 的資料和實際表格的差異(正反向都要抓)
FUNCTION sadzi140_shot_check_column_diff(p_owner,p_table_name,p_drop_abnormal_column)
DEFINE
  p_owner       STRING, 
  p_table_name  STRING,
  p_drop_abnormal_column BOOLEAN
DEFINE
  ls_owner        STRING, 
  ls_tableName    STRING,
  lb_drop_abnormal_column BOOLEAN,
  lo_column_diff  DYNAMIC ARRAY OF T_COLUMN_DIFF,
  li_rec_cnt      INTEGER,
  ls_sql          STRING,
  ls_dummy_sql    STRING
DEFINE
  lb_different  BOOLEAN,
  lo_different  DYNAMIC ARRAY OF T_COLUMN_DIFF 

  LET ls_owner     = p_owner
  LET ls_tableName = p_table_name
  LET lb_drop_abnormal_column = p_drop_abnormal_column

  LET lb_different = FALSE
  LET lo_different = NULL
  LET li_rec_cnt = 1 

  IF lb_drop_abnormal_column THEN
    LET ls_dummy_sql = ""
  ELSE
    LET ls_dummy_sql = " AND ATC.COLUMN_NAME = 'DUMMY' "
  END IF  
  
  ##############################################################################
  #正向比對
  LET ls_sql = "SELECT UPPER(EB.DZEB002)                      COLUMN_NAME,                              ",
               "       EB.DZEB004                             ISKEY,                                    ",
               "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') NULLABLE,                                 ",
               "       UPPER(TD.GZTD003)                      DATA_TYPE,                                ",
               "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(                                       ", 
               "       DECODE(                                                                          ",
               "              UPPER(TD.GZTD003),                                                        ",
               "              'BLOB','4000',                                                            ",
               "              'CLOB','4000',                                                            ",
               "              'DATE','7',                                                               ",
               "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),                              ",
               "              TD.GZTD008                                                                ",
               "             ),',','.'),' ',''))),'.',',')    DATA_LENGTH,                              ",
               "       TRIM(EB.DZEB012)                       DEFAULT_VALUE                             ", 
               "  FROM DZEB_T EB                                                                        ",
               "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006                             ",
               " WHERE EB.DZEB001 = '",ls_tableName.toLowerCase(),"'                                    ",
               "MINUS                                                                                   ",
               "SELECT ATC.COLUMN_NAME                      COLUMN_NAME,                                ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                                      ",
               "       ATC.NULLABLE                         NULLABLE,                                   ",
               "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE, ",
               "       REPLACE(TO_CHAR(DECODE(                                                          ",
               "               ATC.DATA_TYPE,                                                           ",
               "               'NUMBER',DECODE(                                                         ",
               "                                NVL(ATC.DATA_SCALE,'0'),                                ",
               "                                '0',ATC.DATA_PRECISION,                                 ",
               "                                ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE                 ",
               "                              ),                                                        ",
               "               ATC.DATA_LENGTH                                                          ",
               "             )),'.',',')                    DATA_LENGTH,                                ",
               "       TRIM(DS.GET_COL_DEFAULT(ATC.TABLE_NAME,ATC.COLUMN_NAME))  DEFAULT_VALUE          ",
               "  FROM DBA_TAB_COLUMNS ATC                                                              ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER                   ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME              ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME             ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'                ",
               " WHERE 1=1                                                                              ",
               "   AND ATC.OWNER      = '",ls_owner.toUpperCase(),"'                                    ",
               "   AND ATC.TABLE_NAME = '",ls_tableName.toUpperCase(),"'                                ",
               "   AND ATC.COLUMN_NAME NOT LIKE 'SYS_%'                                                 ",
               " ORDER BY 1                                                                             "
               
  PREPARE lpre_check_column_diff_forward FROM ls_sql
  DECLARE lcur_check_column_diff_forward CURSOR FOR lpre_check_column_diff_forward

  OPEN lcur_check_column_diff_forward
  FOREACH lcur_check_column_diff_forward INTO lo_column_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_check_column_diff_forward
  {
  IF li_rec_cnt > 1 THEN
    CALL lo_column_diff.deleteElement(li_rec_cnt)
  END IF  
  }
  
  FREE lpre_check_column_diff_forward
  FREE lcur_check_column_diff_forward
  ##############################################################################

  ##############################################################################
  #反向比對
  LET ls_sql = "SELECT ATC.COLUMN_NAME                      COLUMN_NAME,                                ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                                      ",
               "       ATC.NULLABLE                         NULLABLE,                                   ",
               "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE, ",
               "       REPLACE(TO_CHAR(DECODE(                                                          ",
               "               ATC.DATA_TYPE,                                                           ",
               "               'NUMBER',DECODE(                                                         ",
               "                                NVL(ATC.DATA_SCALE,'0'),                                ",
               "                                '0',ATC.DATA_PRECISION,                                 ",
               "                                ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE                 ",
               "                              ),                                                        ",
               "               ATC.DATA_LENGTH                                                          ",
               "             )),'.',',')                    DATA_LENGTH,                                ",
               "       TRIM(DS.GET_COL_DEFAULT(ATC.TABLE_NAME,ATC.COLUMN_NAME))  DEFAULT_VALUE          ",
               "  FROM DBA_TAB_COLUMNS ATC                                                              ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER                   ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME              ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME             ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'                ",
               " WHERE 1=1                                                                              ",
               "   AND ATC.OWNER      = '",ls_owner.toUpperCase(),"'                                    ",
               "   AND ATC.TABLE_NAME = '",ls_tableName.toUpperCase(),"'                                ",
               "   AND ATC.COLUMN_NAME NOT LIKE 'SYS_%'                                                 ",
               ls_dummy_sql,
               "MINUS                                                                                   ",
               "SELECT UPPER(EB.DZEB002)                      COLUMN_NAME,                              ",
               "       EB.DZEB004                             ISKEY,                                    ",
               "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') NULLABLE,                                 ",
               "       UPPER(TD.GZTD003)                      DATA_TYPE,                                ",
               "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(                                       ",                                  
               "       DECODE(                                                                          ",
               "              UPPER(TD.GZTD003),                                                        ",
               "              'BLOB','4000',                                                            ",
               "              'CLOB','4000',                                                            ",
               "              'DATE','7',                                                               ",
               "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),                              ",
               "              TD.GZTD008                                                                ",
               "             ),',','.'),' ',''))),'.',',')    DATA_LENGTH,                              ",
               "       TRIM(EB.DZEB012)                       DEFAULT_VALUE                             ",
               "  FROM DZEB_T EB                                                                        ",
               "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006                             ",
               " WHERE EB.DZEB001 = '",ls_tableName.toLowerCase(),"'                                    ",
               " ORDER BY 1                                                                             "
               
  PREPARE lpre_check_column_diff_reverse FROM ls_sql
  DECLARE lcur_check_column_diff_reverse CURSOR FOR lpre_check_column_diff_reverse

  OPEN lcur_check_column_diff_reverse
  FOREACH lcur_check_column_diff_reverse INTO lo_column_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_check_column_diff_reverse
  {
  IF li_rec_cnt > 1 THEN
    CALL lo_column_diff.deleteElement(li_rec_cnt)
  END IF  
  }
  FREE lpre_check_column_diff_reverse
  FREE lcur_check_column_diff_reverse
  ##############################################################################
  
  IF li_rec_cnt >= 2 THEN
    LET lb_different = TRUE
  END IF  

  LET lo_different.* = lo_column_diff.*
  
  RETURN lb_different, lo_different
  
END FUNCTION

#取得 Table 之間的比對(By TableEditor)
FUNCTION sadzi140_shot_get_column_diff_by_table_editor(p_owner,p_table_name)
DEFINE
  p_owner       STRING, 
  p_table_name  STRING
DEFINE
  lo_column_diff  DYNAMIC ARRAY OF T_COLUMN_DIFF,
  ls_owner        STRING, 
  ls_tablename    STRING,
  li_rec_cnt      INTEGER,
  ls_sql          STRING
DEFINE
  lb_different    BOOLEAN,
  lo_different    DYNAMIC ARRAY OF T_COLUMN_DIFF 

  LET ls_owner     = p_owner
  LET ls_tablename = p_table_name

  LET lb_different    = FALSE
  LET lo_different    = NULL

  LET ls_sql = "SELECT UPPER(EB.DZEB002)                      DZEV005,                                ",
               "       EB.DZEB004                             DZEV006,                                ",
               "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') DZEV007,                                ",
               "       UPPER(TD.GZTD003)                      DZEV008,                                ",
               "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(                                     ",                                  
               "       DECODE(                                                                        ",
               "              UPPER(TD.GZTD003),                                                      ",
               "              'BLOB','4000',                                                          ",
               "              'CLOB','4000',                                                          ",
               "              'DATE','7',                                                             ",
               "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),                            ",
               "              TD.GZTD008                                                              ",
               "             ),',','.'),' ',''))),'.',',')    DZEV009,                                ",
               "       TRIM(EB.DZEB012)                       DZEV021                                 ",
               "  FROM DS.DZEB_T EB                                                                   ",
               "       LEFT OUTER JOIN DS.GZTD_T TD ON TD.GZTD001 = EB.DZEB006                        ",
               " WHERE EB.DZEB001 = '",ls_tableName.toLowerCase(),"'                                  ",
               "MINUS                                                                                 ",
               "SELECT ATC.COLUMN_NAME                      DZEV005,                                  ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') DZEV006,                                  ",
               "       ATC.NULLABLE                         DZEV007,                                  ",
               "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DZEV008, ",
               "       REPLACE(TO_CHAR(DECODE(                                                        ",
               "               ATC.DATA_TYPE,                                                         ",
               "               'NUMBER',DECODE(                                                       ",
               "                                NVL(ATC.DATA_SCALE,'0'),                              ",
               "                                '0',ATC.DATA_PRECISION,                               ",
               "                                ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE               ",
               "                              ),                                                      ",
               "               ATC.DATA_LENGTH                                                        ",
               "             )),'.',',')                    DZEV009,                                  ",
               "       TRIM(DS.GET_COL_DEFAULT(ATC.TABLE_NAME,ATC.COLUMN_NAME))  DZEV021              ",
               "  FROM DBA_TAB_COLUMNS ATC                                                            ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER                 ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME            ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME           ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'              ",
               " WHERE 1=1                                                                            ",
               "   AND ATC.OWNER      = '",ls_owner.toUpperCase(),"'                                  ",
               "   AND ATC.TABLE_NAME = '",ls_tableName.toUpperCase(),"'                              ",
               "   AND ATC.COLUMN_NAME NOT LIKE 'SYS_%'                                               ",
               " ORDER BY 1                                                                           "

  PREPARE lpre_get_diff_list_by_editor FROM ls_sql
  DECLARE lcur_get_diff_list_by_editor CURSOR FOR lpre_get_diff_list_by_editor

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_diff_list_by_editor
  FOREACH lcur_get_diff_list_by_editor INTO lo_column_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_diff_list_by_editor
  IF li_rec_cnt > 1 THEN
    CALL lo_column_diff.deleteElement(li_rec_cnt)
  END If  
  
  FREE lpre_get_diff_list_by_editor
  FREE lcur_get_diff_list_by_editor

  IF li_rec_cnt >= 2 THEN
    LET lb_different = TRUE
  END IF  

  LET lo_different.* = lo_column_diff.*
  
  RETURN lb_different, lo_different
  
END FUNCTION

#取得 Table 之間的比對(By Database)
FUNCTION sadzi140_shot_get_column_diff_by_database(p_owner,p_table_name,p_drop_abnormal_column)
DEFINE
  p_owner      STRING, 
  p_table_name STRING,
  p_drop_abnormal_column BOOLEAN
DEFINE
  ls_owner        STRING, 
  ls_tablename    STRING,
  lb_drop_abnormal_column BOOLEAN,
  lo_column_diff  DYNAMIC ARRAY OF T_COLUMN_DIFF,
  li_rec_cnt      INTEGER,
  ls_sql          STRING,
  ls_dummy_sql    STRING
DEFINE
  lb_different    BOOLEAN,
  lo_different    DYNAMIC ARRAY OF T_COLUMN_DIFF 

  LET ls_owner     = p_owner
  LET ls_tablename = p_table_name
  LET lb_drop_abnormal_column = p_drop_abnormal_column

  LET lb_different    = FALSE
  LET lo_different    = NULL

  IF lb_drop_abnormal_column THEN
    LET ls_dummy_sql = ""
  ELSE
    LET ls_dummy_sql = " AND ATC.COLUMN_NAME = 'DUMMY' "
  END IF  

  LET ls_sql = "SELECT ATC.COLUMN_NAME                      DZEV005,                                  ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') DZEV006,                                  ",
               "       ATC.NULLABLE                         DZEV007,                                  ",
               "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DZEV008, ",
               "       REPLACE(TO_CHAR(DECODE(                                                        ",
               "               ATC.DATA_TYPE,                                                         ",
               "               'NUMBER',DECODE(                                                       ",
               "                                NVL(ATC.DATA_SCALE,'0'),                              ",
               "                                '0',ATC.DATA_PRECISION,                               ",
               "                                ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE               ",
               "                              ),                                                      ",
               "               ATC.DATA_LENGTH                                                        ",
               "             )),'.',',')                    DZEV009,                                  ",
               "       TRIM(DS.GET_COL_DEFAULT(ATC.TABLE_NAME,ATC.COLUMN_NAME))  DZEV021              ",
               "  FROM DBA_TAB_COLUMNS ATC                                                            ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER                 ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME            ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME           ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'              ",
               " WHERE 1=1                                                                            ",
               "   AND ATC.OWNER      = '",ls_owner.toUpperCase(),"'                                  ",
               "   AND ATC.TABLE_NAME = '",ls_tableName.toUpperCase(),"'                              ",
               "   AND ATC.COLUMN_NAME NOT LIKE 'SYS_%'                                               ",
               ls_dummy_sql,
               "MINUS                                                                                 ",
               "SELECT UPPER(EB.DZEB002)                      DZEV005,                                ",
               "       EB.DZEB004                             DZEV006,                                ",
               "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') DZEV007,                                ",
               "       UPPER(TD.GZTD003)                      DZEV008,                                ",
               "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(                                     ",                                  
               "       DECODE(                                                                        ",
               "              UPPER(TD.GZTD003),                                                      ",
               "              'BLOB','4000',                                                          ",
               "              'CLOB','4000',                                                          ",
               "              'DATE','7',                                                             ",
               "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),                            ",
               "              TD.GZTD008                                                              ",
               "             ),',','.'),' ',''))),'.',',')    DZEV009,                                ",
               "       TRIM(EB.DZEB012)                       DZEV021                                 ",
               "  FROM DS.DZEB_T EB                                                                   ",
               "       LEFT OUTER JOIN DS.GZTD_T TD ON TD.GZTD001 = EB.DZEB006                        ",
               " WHERE EB.DZEB001 = '",ls_tableName.toLowerCase(),"'                                  ",
               " ORDER BY 1                                                                           "
               
  PREPARE lpre_get_diff_list_by_database FROM ls_sql
  DECLARE lcur_get_diff_list_by_database CURSOR FOR lpre_get_diff_list_by_database

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_diff_list_by_database
  FOREACH lcur_get_diff_list_by_database INTO lo_column_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_diff_list_by_database
  IF li_rec_cnt > 1 THEN
    CALL lo_column_diff.deleteElement(li_rec_cnt)
  END IF  
  
  FREE lpre_get_diff_list_by_database
  FREE lcur_get_diff_list_by_database

  IF li_rec_cnt >= 2 THEN
    LET lb_different = TRUE
  END IF  

  LET lo_different.* = lo_column_diff.*
  
  RETURN lb_different, lo_different
  

END FUNCTION

#比對現行 Table Editor 的 Constraint 資料和最近一次的 Snapshot 的差異(正反向都要抓)
FUNCTION sadzi140_shot_check_constraint_diff(p_owner,p_table_name,p_drop_abnormal_column)
DEFINE
  p_owner       STRING, 
  p_table_name  STRING,
  p_drop_abnormal_column BOOLEAN
DEFINE
  ls_owner      STRING, 
  ls_table_name STRING,
  lb_drop_abnormal_column BOOLEAN,
  li_rec_cnt    INTEGER,
  ls_sql        STRING
DEFINE
  lo_constraint_diff  DYNAMIC ARRAY OF T_CONSTRAINT_DIFF,
  lb_different        BOOLEAN,
  lo_different        DYNAMIC ARRAY OF T_CONSTRAINT_DIFF 

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  LET lb_drop_abnormal_column = p_drop_abnormal_column

  LET lb_different = FALSE
  LET lo_different = NULL
  LET li_rec_cnt = 1 
  
  ##############################################################################
  #正向比對
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
               
  PREPARE lpre_check_key_diff_forward FROM ls_sql
  DECLARE lcur_check_key_diff_forward CURSOR FOR lpre_check_key_diff_forward

  OPEN lcur_check_key_diff_forward
  FOREACH lcur_check_key_diff_forward INTO lo_constraint_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_check_key_diff_forward
  
  FREE lpre_check_key_diff_forward
  FREE lcur_check_key_diff_forward
  ##############################################################################

  ##############################################################################
  #反向比對
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
               "SELECT UPPER(ED.DZED001)       TABLE_NAME,                                                                                                                  ",
               "       UPPER(ED.DZED002)       CONSTRAINT_NAME,                                                                                                             ",
               "       UPPER(ED.DZED003)       CONSTRAINT_TYPE,                                                                                                             ",
               "       UPPER(ED.DZED004)       COLUMN_NAMES,                                                                                                                ",
               "       UPPER(TRIM(ED.DZED005)) R_TABLE_NAME,                                                                                                                ",
               "       UPPER(TRIM(ED.DZED006)) R_COLUMN_NAMES                                                                                                               ",
               "  FROM DZED_T ED                                                                                                                                            ",
               " WHERE ED.DZED001 = '",ls_table_name.toLowerCase(),"'                                                                                                       ",
               "   AND ED.DZED003 <> 'F'                                                                                                                                    "         

  PREPARE lpre_check_key_diff_reverse FROM ls_sql
  DECLARE lcur_check_key_diff_reverse CURSOR FOR lpre_check_key_diff_reverse

  OPEN lcur_check_key_diff_reverse
  FOREACH lcur_check_key_diff_reverse INTO lo_constraint_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_check_key_diff_reverse

  FREE lpre_check_key_diff_reverse
  FREE lcur_check_key_diff_reverse
  ##############################################################################
  
  IF li_rec_cnt >= 2 THEN
    LET lb_different = TRUE
  END IF  

  LET lo_different.* = lo_constraint_diff.*
  
  RETURN lb_different, lo_different
  
END FUNCTION

#取得 Constraint 資料的比對(TableEditor)
FUNCTION sadzi140_shot_get_constraint_diff_by_table_editor(p_owner,p_table_name)
DEFINE
  p_owner        STRING,
  p_table_name   STRING
DEFINE
  ls_owner           STRING,
  ls_table_name      STRING,
  lo_constraint_diff DYNAMIC ARRAY OF T_CONSTRAINT_DIFF,
  li_rec_cnt         INTEGER,
  ls_sql             STRING
DEFINE
  lb_different BOOLEAN,
  lo_different DYNAMIC ARRAY OF T_CONSTRAINT_DIFF 

  LET ls_owner        = p_owner
  LET ls_table_name   = p_table_name

  LET lb_different = FALSE
  LET lo_different = NULL
  
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
               
  PREPARE lpre_get_constraint_diff_by_editor FROM ls_sql
  DECLARE lcur_get_constraint_diff_by_editor CURSOR FOR lpre_get_constraint_diff_by_editor

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_constraint_diff_by_editor
  FOREACH lcur_get_constraint_diff_by_editor INTO lo_constraint_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_constraint_diff_by_editor
  IF li_rec_cnt > 1 THEN
    CALL lo_constraint_diff.deleteElement(li_rec_cnt)
  END If  
  
  FREE lpre_get_constraint_diff_by_editor
  FREE lcur_get_constraint_diff_by_editor

  IF li_rec_cnt >= 2 THEN
    LET lb_different = TRUE
  END IF  

  LET lo_different.* = lo_constraint_diff.*
  
  RETURN lb_different, lo_different  

END FUNCTION

#取得 Constraint 資料的比對(DataBase)
FUNCTION sadzi140_shot_get_constraint_diff_by_database(p_owner,p_table_name,p_drop_abnormal_column)
DEFINE
  p_owner        STRING,
  p_table_name   STRING,
  p_drop_abnormal_column BOOLEAN
DEFINE
  ls_owner            STRING,
  ls_table_name       STRING,
  lb_drop_abnormal_column BOOLEAN,
  lo_constraint_diff  DYNAMIC ARRAY OF T_CONSTRAINT_DIFF,
  li_rec_cnt          INTEGER,
  ls_sql              STRING
DEFINE
  lb_different   BOOLEAN,
  lo_different   DYNAMIC ARRAY OF T_CONSTRAINT_DIFF 

  LET ls_owner        = p_owner
  LET ls_table_name   = p_table_name
  LET lb_drop_abnormal_column = p_drop_abnormal_column

  LET lb_different = FALSE
  LET lo_different = NULL

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
               "SELECT UPPER(ED.DZED001)       TABLE_NAME,                                                                                                                  ",
               "       UPPER(ED.DZED002)       CONSTRAINT_NAME,                                                                                                             ",
               "       UPPER(ED.DZED003)       CONSTRAINT_TYPE,                                                                                                             ",
               "       UPPER(ED.DZED004)       COLUMN_NAMES,                                                                                                                ",
               "       UPPER(TRIM(ED.DZED005)) R_TABLE_NAME,                                                                                                                ",
               "       UPPER(TRIM(ED.DZED006)) R_COLUMN_NAMES                                                                                                               ",
               "  FROM DZED_T ED                                                                                                                                            ",
               " WHERE ED.DZED001 = '",ls_table_name.toLowerCase(),"'                                                                                                       ",
               "   AND ED.DZED003 <> 'R'                                                                                                                                    "         
               
  PREPARE lpre_get_constraint_diff_by_database FROM ls_sql
  DECLARE lcur_get_constraint_diff_by_database CURSOR FOR lpre_get_constraint_diff_by_database

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_constraint_diff_by_database
  FOREACH lcur_get_constraint_diff_by_database INTO lo_constraint_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_constraint_diff_by_database
  IF li_rec_cnt > 1 THEN
    CALL lo_constraint_diff.deleteElement(li_rec_cnt)
  END IF  
  
  FREE lpre_get_constraint_diff_by_database
  FREE lcur_get_constraint_diff_by_database

  IF li_rec_cnt >= 2 THEN
    LET lb_different = TRUE
  END IF  

  LET lo_different.* = lo_constraint_diff.*
  
  RETURN lb_different, lo_different  

END FUNCTION

#比對現行 Table Editor 的 Index 資料和最近一次的 Snapshot 的差異(正反向都要抓)
FUNCTION sadzi140_shot_check_index_diff(p_owner,p_table_name,p_drop_abnormal_column)
DEFINE
  p_owner       STRING, 
  p_table_name  STRING,
  p_drop_abnormal_column BOOLEAN
DEFINE
  ls_owner      STRING, 
  ls_table_name STRING,
  lb_drop_abnormal_column BOOLEAN,
  li_rec_cnt    INTEGER,
  ls_sql        STRING
DEFINE
  lo_index_diff  DYNAMIC ARRAY OF T_INDEX_DIFF,
  lb_different   BOOLEAN,
  lo_different   DYNAMIC ARRAY OF T_INDEX_DIFF 

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  LET lb_drop_abnormal_column = p_drop_abnormal_column

  LET lb_different = FALSE
  LET lo_different = NULL
  LET li_rec_cnt = 1 
  
  ##############################################################################
  #正向比對
  LET ls_sql = "SELECT UPPER(EC.DZEC001) TABLE_NAME,                                                                         ",
               "       UPPER(EC.DZEC002) INDEX_NAME,                                                                         ",
               "       UPPER(EC.DZEC003) INDEX_TYPE,                                                                         ",
               "       UPPER(EC.DZEC004) COLUMN_NAME                                                                         ",
               "  FROM DZEC_T EC                                                                                             ",
               " WHERE EC.DZEC001 = '",ls_table_name.toLowerCase(),"'                                                        ",
               "   AND NOT EXISTS (                                                                                          ",
               "                    SELECT 1                                                                                 ",
               "                      FROM DZED_T ED                                                                         ",
               "                     WHERE ED.DZED001 = EC.DZEC001                                                           ",
               "                       AND ED.DZED002 = EC.DZEC002                                                           ",
               "                  )                                                                                          ",
               " MINUS                                                                                                       ",
               "SELECT AIS.TABLE_NAME                TABLE_NAME,                                                             ",
               "       AIS.INDEX_NAME                INDEX_NAME,                                                             ",
               "       SUBSTRB(AIS.UNIQUENESS,1,1)   INDEX_TYPE,                                                             ",
               "       LISTAGG(AICS.COLUMN_NAME,',') WITHIN GROUP (ORDER BY AIS.INDEX_NAME,AICS.COLUMN_POSITION) COLUMN_NAME ",
               "  FROM DBA_INDEXES AIS,DBA_IND_COLUMNS AICS                                                                  ",
               " WHERE AIS.OWNER        = '",ls_owner.toUpperCase(),"'                                                       ",
               "   AND AIS.TABLE_NAME   = '",ls_table_name.toUpperCase(),"'                                                  ",
               "   AND AICS.TABLE_OWNER = AIS.TABLE_OWNER                                                                    ",
               "   AND AICS.TABLE_NAME  = AIS.TABLE_NAME                                                                     ",
               "   AND AICS.INDEX_NAME  = AIS.INDEX_NAME                                                                     ",
               "   AND AIS.INDEX_NAME NOT IN (                                                                               ",
               "                               SELECT ACS.CONSTRAINT_NAME                                                    ",
               "                                 FROM DBA_CONSTRAINTS ACS                                                    ",
               "                                WHERE ACS.TABLE_NAME = AIS.TABLE_NAME                                        ",
               "                                  AND ACS.OWNER      = AIS.OWNER                                             ",
               "                             )                                                                               ",
               "  GROUP BY AIS.TABLE_NAME,AIS.INDEX_NAME,SUBSTRB(AIS.UNIQUENESS,1,1)                                         "               
               
  PREPARE lpre_check_index_diff_forward FROM ls_sql
  DECLARE lcur_check_index_diff_forward CURSOR FOR lpre_check_index_diff_forward

  OPEN lcur_check_index_diff_forward
  FOREACH lcur_check_index_diff_forward INTO lo_index_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_check_index_diff_forward
  {
  IF li_rec_cnt > 1 THEN
    CALL lo_index_diff.deleteElement(li_rec_cnt)
  END IF  
  }
  
  FREE lpre_check_index_diff_forward
  FREE lcur_check_index_diff_forward
  ##############################################################################

  ##############################################################################
  #反向比對
  LET ls_sql = "SELECT AIS.TABLE_NAME                TABLE_NAME,                                                             ",
               "       AIS.INDEX_NAME                INDEX_NAME,                                                             ",
               "       SUBSTRB(AIS.UNIQUENESS,1,1)   INDEX_TYPE,                                                             ",
               "       LISTAGG(AICS.COLUMN_NAME,',') WITHIN GROUP (ORDER BY AIS.INDEX_NAME,AICS.COLUMN_POSITION) COLUMN_NAME ",
               "  FROM DBA_INDEXES AIS,DBA_IND_COLUMNS AICS                                                                  ",
               " WHERE AIS.OWNER        = '",ls_owner.toUpperCase(),"'                                                       ",
               "   AND AIS.TABLE_NAME   = '",ls_table_name.toUpperCase(),"'                                                  ",
               "   AND AICS.TABLE_OWNER = AIS.TABLE_OWNER                                                                    ",
               "   AND AICS.TABLE_NAME  = AIS.TABLE_NAME                                                                     ",
               "   AND AICS.INDEX_NAME  = AIS.INDEX_NAME                                                                     ",
               "   AND AIS.INDEX_NAME NOT IN (                                                                               ",
               "                               SELECT ACS.CONSTRAINT_NAME                                                    ",
               "                                 FROM DBA_CONSTRAINTS ACS                                                    ",
               "                                WHERE ACS.TABLE_NAME = AIS.TABLE_NAME                                        ",
               "                                  AND ACS.OWNER      = AIS.OWNER                                             ",
               "                             )                                                                               ",
               "  GROUP BY AIS.TABLE_NAME,AIS.INDEX_NAME,SUBSTRB(AIS.UNIQUENESS,1,1)                                         ",
               "MINUS                                                                                                        ",
               "SELECT UPPER(EC.DZEC001) TABLE_NAME,                                                                         ",
               "       UPPER(EC.DZEC002) INDEX_NAME,                                                                         ",
               "       UPPER(EC.DZEC003) INDEX_TYPE,                                                                         ",
               "       UPPER(EC.DZEC004) COLUMN_NAME                                                                         ",
               "  FROM DZEC_T EC                                                                                             ",
               " WHERE EC.DZEC001 = '",ls_table_name.toLowerCase(),"'                                                        ",
               "   AND NOT EXISTS (                                                                                          ",
               "                    SELECT 1                                                                                 ",
               "                      FROM DZED_T ED                                                                         ",
               "                     WHERE ED.DZED001 = EC.DZEC001                                                           ",
               "                       AND ED.DZED002 = EC.DZEC002                                                           ",
               "                  )                                                                                          "
               
  
  PREPARE lpre_check_index_diff_reverse FROM ls_sql
  DECLARE lcur_check_index_diff_reverse CURSOR FOR lpre_check_index_diff_reverse

  OPEN lcur_check_index_diff_reverse
  FOREACH lcur_check_index_diff_reverse INTO lo_index_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_check_index_diff_reverse
  {
  IF li_rec_cnt > 1 THEN
    CALL lo_index_diff.deleteElement(li_rec_cnt)
  END IF  
  }
  FREE lpre_check_index_diff_reverse
  FREE lcur_check_index_diff_reverse
  ##############################################################################
  
  IF li_rec_cnt >= 2 THEN
    LET lb_different = TRUE
  END IF  

  LET lo_different.* = lo_index_diff.*
  
  RETURN lb_different, lo_different
  
END FUNCTION

#取得Index資料的比對(TableEditor)
FUNCTION sadzi140_shot_get_index_diff_by_table_editor(p_owner,p_table_name)
DEFINE
  p_owner        STRING,
  p_table_name   STRING
DEFINE
  ls_owner        STRING,
  ls_table_name   STRING,
  ls_version      STRING,
  lo_index_diff   DYNAMIC ARRAY OF T_INDEX_DIFF,
  li_rec_cnt      INTEGER,
  ls_sql          STRING
DEFINE
  lb_different   BOOLEAN,
  lo_different   DYNAMIC ARRAY OF T_INDEX_DIFF 

  LET ls_owner        = p_owner
  LET ls_table_name   = p_table_name

  LET lb_different = FALSE
  LET lo_different = NULL
  
  LET ls_sql = "SELECT UPPER(EC.DZEC001) TABLE_NAME,                                                                         ",
               "       UPPER(EC.DZEC002) INDEX_NAME,                                                                         ",
               "       UPPER(EC.DZEC003) INDEX_TYPE,                                                                         ",
               "       UPPER(EC.DZEC004) COLUMN_NAME                                                                         ",
               "  FROM DZEC_T EC                                                                                             ",
               " WHERE EC.DZEC001 = '",ls_table_name.toLowerCase(),"'                                                        ",
               "   AND NOT EXISTS (                                                                                          ",
               "                    SELECT 1                                                                                 ",
               "                      FROM DZED_T ED                                                                         ",
               "                     WHERE ED.DZED001 = EC.DZEC001                                                           ",
               "                       AND ED.DZED002 = EC.DZEC002                                                           ",
               "                  )                                                                                          ",
               " MINUS                                                                                                       ",
               "SELECT AIS.TABLE_NAME,AIS.INDEX_NAME,SUBSTRB(AIS.UNIQUENESS,1,1) INDEX_TYPE,                                 ",
               "       LISTAGG(AICS.COLUMN_NAME,',') WITHIN GROUP (ORDER BY AIS.INDEX_NAME,AICS.COLUMN_POSITION) COLUMN_NAME ",
               "                                                                                                             ",
               "  FROM DBA_INDEXES AIS,DBA_IND_COLUMNS AICS                                                                  ",
               " WHERE AIS.OWNER        = '",ls_owner.toUpperCase(),"'                                                       ",
               "   AND AIS.TABLE_NAME   = '",ls_table_name.toUpperCase(),"'                                                  ",
               "   AND AICS.TABLE_OWNER = AIS.TABLE_OWNER                                                                    ",
               "   AND AICS.TABLE_NAME  = AIS.TABLE_NAME                                                                     ",
               "   AND AICS.INDEX_NAME  = AIS.INDEX_NAME                                                                     ",
               "   AND AIS.INDEX_NAME NOT IN (                                                                               ",
               "                               SELECT ACS.CONSTRAINT_NAME                                                    ",
               "                                 FROM DBA_CONSTRAINTS ACS                                                    ",
               "                                WHERE ACS.TABLE_NAME = AIS.TABLE_NAME                                        ",
               "                                  AND ACS.OWNER      = AIS.OWNER                                             ",
               "                             )                                                                               ",
               "  GROUP BY AIS.TABLE_NAME,AIS.INDEX_NAME,SUBSTRB(AIS.UNIQUENESS,1,1)                                         "               
               
  PREPARE lpre_get_index_diff_by_editor FROM ls_sql
  DECLARE lcur_get_index_diff_by_editor CURSOR FOR lpre_get_index_diff_by_editor

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_index_diff_by_editor
  FOREACH lcur_get_index_diff_by_editor INTO lo_index_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_index_diff_by_editor
  IF li_rec_cnt > 1 THEN
    CALL lo_index_diff.deleteElement(li_rec_cnt)
  END If  
  
  FREE lpre_get_index_diff_by_editor
  FREE lcur_get_index_diff_by_editor

  IF li_rec_cnt >= 2 THEN
    LET lb_different = TRUE
  END IF  

  LET lo_different.* = lo_index_diff.*
  
  RETURN lb_different, lo_different  

END FUNCTION

#取得Index 資料的比對(Snapshot)
FUNCTION sadzi140_shot_get_index_diff_by_database(p_owner,p_table_name,p_drop_abnormal_column)
DEFINE
  p_owner        STRING,
  p_table_name   STRING,
  p_drop_abnormal_column BOOLEAN
DEFINE
  ls_owner        STRING,
  ls_table_name   STRING,
  lb_drop_abnormal_column BOOLEAN,
  lo_index_diff   DYNAMIC ARRAY OF T_INDEX_DIFF,
  li_rec_cnt      INTEGER,
  ls_sql          STRING
DEFINE
  lb_different   BOOLEAN,
  lo_different   DYNAMIC ARRAY OF T_INDEX_DIFF 

  LET ls_owner        = p_owner
  LET ls_table_name   = p_table_name
  LET lb_drop_abnormal_column = p_drop_abnormal_column

  LET lb_different = FALSE
  LET lo_different = NULL

  LET ls_sql = "SELECT AIS.TABLE_NAME,AIS.INDEX_NAME,SUBSTRB(AIS.UNIQUENESS,1,1) INDEX_TYPE,                                 ",
               "       LISTAGG(AICS.COLUMN_NAME,',') WITHIN GROUP (ORDER BY AIS.INDEX_NAME,AICS.COLUMN_POSITION) COLUMN_NAME ",
               "                                                                                                             ",
               "  FROM DBA_INDEXES AIS,DBA_IND_COLUMNS AICS                                                                  ",
               " WHERE AIS.OWNER        = '",ls_owner.toUpperCase(),"'                                                       ",
               "   AND AIS.TABLE_NAME   = '",ls_table_name.toUpperCase(),"'                                                  ",
               "   AND AICS.TABLE_OWNER = AIS.TABLE_OWNER                                                                    ",
               "   AND AICS.TABLE_NAME  = AIS.TABLE_NAME                                                                     ",
               "   AND AICS.INDEX_NAME  = AIS.INDEX_NAME                                                                     ",
               "   AND AIS.INDEX_NAME NOT IN (                                                                               ",
               "                               SELECT ACS.CONSTRAINT_NAME                                                    ",
               "                                 FROM DBA_CONSTRAINTS ACS                                                    ",
               "                                WHERE ACS.TABLE_NAME = AIS.TABLE_NAME                                        ",
               "                                  AND ACS.OWNER      = AIS.OWNER                                             ",
               "                             )                                                                               ",
               "  GROUP BY AIS.TABLE_NAME,AIS.INDEX_NAME,SUBSTRB(AIS.UNIQUENESS,1,1)                                         ",
               "MINUS                                                                                                        ",
               "SELECT UPPER(EC.DZEC001) TABLE_NAME,                                                                         ",
               "       UPPER(EC.DZEC002) INDEX_NAME,                                                                         ",
               "       UPPER(EC.DZEC003) INDEX_TYPE,                                                                         ",
               "       UPPER(EC.DZEC004) COLUMN_NAME                                                                         ",
               "  FROM DZEC_T EC                                                                                             ",
               " WHERE EC.DZEC001 = '",ls_table_name.toLowerCase(),"'                                                        ",
               "   AND NOT EXISTS (                                                                                          ",
               "                    SELECT 1                                                                                 ",
               "                      FROM DZED_T ED                                                                         ",
               "                     WHERE ED.DZED001 = EC.DZEC001                                                           ",
               "                       AND ED.DZED002 = EC.DZEC002                                                           ",
               "                  )                                                                                          "
               
  PREPARE lpre_get_index_diff_by_database FROM ls_sql
  DECLARE lcur_get_index_diff_by_database CURSOR FOR lpre_get_index_diff_by_database

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_index_diff_by_database
  FOREACH lcur_get_index_diff_by_database INTO lo_index_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_index_diff_by_database
  IF li_rec_cnt > 1 THEN
    CALL lo_index_diff.deleteElement(li_rec_cnt)
  END IF  
  
  FREE lpre_get_index_diff_by_database
  FREE lcur_get_index_diff_by_database

  IF li_rec_cnt >= 2 THEN
    LET lb_different = TRUE
  END IF  

  LET lo_different.* = lo_index_diff.*
  
  RETURN lb_different, lo_different  

END FUNCTION

FUNCTION sadzi140_shot_get_key_list(p_master_user,p_table_name)
DEFINE
  p_master_user  STRING,
  p_table_name   STRING
DEFINE
  ls_master_user   STRING,
  ls_table_name    STRING,
  lo_key_field     DYNAMIC ARRAY OF T_COLUMN_DIFF
DEFINE  
  ls_sql         STRING,
  li_rec_cnt     INTEGER,
  ls_key_field   STRING

  LET ls_master_user  = p_master_user
  LET ls_table_name   = p_table_name

  LET ls_key_field = ""

  LET ls_sql = "SELECT UPPER(EB.DZEB002)                      DZEB002,       ",
               "       EB.DZEB004                             DZEB004,       ",  
               "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') DZEB005,       ",
               "       UPPER(TD.GZTD003)                      DZEB007,       ",
               "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(            ",
               "       DECODE(                                               ",
               "               UPPER(TD.GZTD003),                            ",
               "               'BLOB','4000',                                ",
               "               'CLOB','4000',                                ",
               "               'DATE','7',                                   ",
               "               'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),  ",
               "               TD.GZTD008                                    ",
               "             ),',','.'),' ',''))),'.',',')    DZEB008        ",
               "  FROM DZEB_T EB                                             ",
               "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006  ",
               " WHERE EB.DZEB001 = '",ls_table_name.toLowerCase(),"'        ",
               " ORDER BY EB.DZEB021                                         "               
  PREPARE lpre_get_key_list FROM ls_sql
  DECLARE lcur_get_key_list CURSOR FOR lpre_get_key_list

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_key_list
  FOREACH lcur_get_key_list INTO lo_key_field[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    IF lo_key_field[li_rec_cnt].DZEV006 = "Y" THEN
      LET ls_key_field = ls_key_field,",",lo_key_field[li_rec_cnt].DZEV005
    END IF    
    
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_key_list
  
  FREE lpre_get_key_list
  FREE lcur_get_key_list  

  RETURN ls_key_field
  
END FUNCTION

FUNCTION sadzi140_shot_delete_table_shot_data(p_master_db,p_table_name,p_version_info)
DEFINE
  p_master_db    STRING,
  p_table_name   STRING,
  p_version_info T_VERSION_INFO
DEFINE
  ls_master_db     STRING,
  ls_table_name    STRING,
  lo_version_info  T_VERSION_INFO,
  lb_success       BOOLEAN,
  ls_delete_sql    STRING
DEFINE
  lb_return BOOLEAN
  
  LET ls_master_db  = p_master_db.toUpperCase() 
  LET ls_table_name = p_table_name.toUpperCase()
  LET lo_version_info.* = p_version_info.*

  LET lb_success = TRUE

  LET ls_delete_sql = "DELETE FROM DZEV_T EV                                 ",
                      " WHERE EV.DZEV001 = '",ls_master_db,"'                ",
                      "   AND EV.DZEV002 = '",ls_table_name,"'               ",
                      --"   AND EV.DZEV003 = '",lo_version_info.REVISION,"'    ",
                      "   AND EV.DZEV018 = '",lo_version_info.ALM_VERSION,"' "

  TRY
    PREPARE lpre_delete_table_shot_data FROM ls_delete_sql
    EXECUTE lpre_delete_table_shot_data
  CATCH
    LET lb_success = FALSE
  END TRY

  LET lb_return = lb_success

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_shot_delete_constraint_index_shot_data(p_table_name,p_version_info)
DEFINE
  p_table_name   STRING,
  p_version_info T_VERSION_INFO
DEFINE
  ls_table_name   STRING,
  lo_version_info T_VERSION_INFO,
  lb_success      BOOLEAN,
  ls_sql          STRING
DEFINE
  lb_return BOOLEAN  
  
  LET ls_table_name     = p_table_name.toUpperCase()
  LET lo_version_info.* = p_version_info.*

  LET lb_success = TRUE

  LET ls_sql = "DELETE FROM DZEW_T EW                                 ",
               " WHERE EW.DZEW001 = '",ls_table_name.toLowerCase(),"' ",
               "   AND EW.DZEW002 = '",lo_version_info.REVISION,"'    ",
               "   AND EW.DZEW010 = '",lo_version_info.ALM_VERSION,"' "

  TRY
    PREPARE lpre_delete_constraint_index_shot_data FROM ls_sql
    EXECUTE lpre_delete_constraint_index_shot_data
  CATCH
    LET lb_success = FALSE
  END TRY

  LET lb_return = lb_success

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_shot_get_constraint_index_data(p_table_name,p_new_version,p_curr_version,p_alm_version,p_alm_request_no,p_dgenv)
DEFINE
  p_table_name     STRING,
  p_new_version    STRING,
  p_curr_version   STRING,
  p_alm_version    STRING,
  p_alm_request_no STRING,
  p_dgenv          STRING 
DEFINE
  ls_table_name       STRING,
  ls_new_version      STRING,
  ls_curr_version     STRING,
  ls_alm_version      STRING,
  ls_alm_request_no   STRING, 
  ls_dgenv            STRING, 
  lo_constraint_index DYNAMIC ARRAY OF T_CONSTRAINT_INDEX
DEFINE  
  ls_sql     STRING,
  li_rec_cnt INTEGER,
  lo_return  DYNAMIC ARRAY OF T_CONSTRAINT_INDEX

  LET ls_table_name     = p_table_name
  LET ls_new_version    = p_new_version  
  LET ls_curr_version   = p_curr_version
  LET ls_alm_version    = p_alm_version  
  LET ls_alm_request_no = p_alm_request_no
  LET ls_dgenv          = p_dgenv

  LET lo_constraint_index = ""
  LET lo_return = ""
  
  LET ls_sql = "SELECT EC.DZEC001                         TABLE_NAME,           ",
               "       ''                                 SEQ_NO,               ",
               "       'Index'                            CONSTRAINT_OR_INDEX,  ",
               "       EC.DZEC002                         DATA_NAME,            ",
               "       EC.DZEC003                         DATATYPES,            ",
               "       TRANSLATE(EC.DZEC004, '+-._', ',') DATA_COLUMNS,         ",
               "       ''                                 FOREIGN_TABLE,        ",
               "       ''                                 FOREIGN_COLUMNS,      ",
               "       ''                                 PREV_SEQ_NO,          ",
               "       ''                                 ALM_VERSION,          ",
               "       ''                                 ALM_REQUEST_NO,       ",
               "       EC.DZEC006                         DGENV,                ",
               "       EC.DZEC007                         ORIG_DGENV,           ",
               "       EC.DZEC008                         SHIP_NOTICE           ",
               "  FROM DZEC_T EC                                                ",
               " WHERE EC.DZEC001 = '",ls_table_name,"'                         ",
               "UNION ALL                                                       ",
               "SELECT ED.DZED001                         TABLE_NAME,           ",
               "       ''                                 SEQ_NO,               ",
               "       'Constraint'                       CONSTRAINT_OR_INDEX,  ",
               "       ED.DZED002                         DATA_NAME,            ",
               "       ED.DZED003                         DATATYPES,            ",
               "       TRANSLATE(ED.DZED004, '+-._', ',') DATA_COLUMNS,         ",
               "       ED.DZED005                         FOREIGN_TABLE,        ",
               "       ED.DZED006                         FOREIGN_COLUMNS,      ",
               "       ''                                 PREV_SEQ_NO,          ",
               "       ''                                 ALM_VERSION,          ",
               "       ''                                 ALM_REQUEST_NO,       ",
               "       ED.DZED008                         DGENV,                ",
               "       ED.DZED009                         ORIG_DGENV,           ",
               "       ED.DZED010                         SHIP_NOTICE           ",
               "  FROM DZED_T ED                                                ",
               " WHERE ED.DZED001 = '",ls_table_name,"'                         ",
               "   AND ED.DZED003 <> 'F'                                        "

  PREPARE lpre_GetConstraintIndexData FROM ls_sql
  DECLARE lcur_GetConstraintIndexData CURSOR FOR lpre_GetConstraintIndexData

  LET li_rec_cnt = 1 
  
  OPEN lcur_GetConstraintIndexData
  FOREACH lcur_GetConstraintIndexData INTO lo_constraint_index[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET lo_constraint_index[li_rec_cnt].DZEW002 = ls_new_version 
    LET lo_constraint_index[li_rec_cnt].DZEW009 = ls_curr_version
    LET lo_constraint_index[li_rec_cnt].DZEW010 = ls_alm_version
    LET lo_constraint_index[li_rec_cnt].DZEW011 = ls_alm_request_no
    
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_GetConstraintIndexData
  IF li_rec_cnt > 1 THEN
    CALL lo_constraint_index.deleteElement(li_rec_cnt)
  END If  
  
  FREE lpre_GetConstraintIndexData
  FREE lcur_GetConstraintIndexData  

  LET lo_return.* = lo_constraint_index.* 
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi140_shot_set_constraint_index_data(p_constraint_index)
DEFINE
  p_constraint_index DYNAMIC ARRAY OF T_CONSTRAINT_INDEX
DEFINE
  li_loop INTEGER,
  lo_constraint_index DYNAMIC ARRAY OF T_CONSTRAINT_INDEX

  LET lo_constraint_index.* = p_constraint_index.*

  FOR li_loop = 1 TO lo_constraint_index.getLength()
    CALL sadzi140_shot_insert_DZEW_T(lo_constraint_index[li_loop].*)
  END FOR  
  
END FUNCTION

FUNCTION sadzi140_shot_insert_DZEW_T(p_constraint_index)
DEFINE
  p_constraint_index T_CONSTRAINT_INDEX
DEFINE
  li_loop INTEGER,
  lo_constraint_index T_CONSTRAINT_INDEX

  LET lo_constraint_index.* = p_constraint_index.*

  TRY
    INSERT INTO DZEW_T(
                        DZEW001,DZEW002,DZEW003,DZEW004,DZEW005,
                        DZEW006,DZEW007,DZEW008,DZEW009,DZEW010,
                        DZEW011,DZEW012,DZEW013,DZEW014
                      ) 
               VALUES (
                        lo_constraint_index.DZEW001,lo_constraint_index.DZEW002,lo_constraint_index.DZEW003,lo_constraint_index.DZEW004,lo_constraint_index.DZEW005,
                        lo_constraint_index.DZEW006,TRIM(lo_constraint_index.DZEW007),TRIM(lo_constraint_index.DZEW008),lo_constraint_index.DZEW009,lo_constraint_index.DZEW010,
                        lo_constraint_index.DZEW011,lo_constraint_index.DZEW012,lo_constraint_index.DZEW013,lo_constraint_index.DZEW014
                      )
  CATCH 
    DISPLAY cs_warning_tag,"Insert into DZEW_T : ",SQLCA.SQLCODE
  END TRY
  
END FUNCTION

FUNCTION sadzi140_shot_get_max_index_prev_version(p_table_name,p_curr_version)
DEFINE 
  p_table_name   STRING,
  p_curr_version STRING
DEFINE
  ls_table_name   STRING,
  ls_curr_version STRING,
  ls_sql          STRING,
  li_rec_cnt      INTEGER,
  ls_prev_version VARCHAR(30)         
DEFINE  
  ls_return STRING

  LET ls_table_name   = p_table_name
  LET ls_curr_version = p_curr_version
  
  LET li_rec_cnt = 1
  
  LET ls_sql = "SELECT MAX(EW.DZEW002) MAX_PREV_VERSION   ",
               "  FROM DZEW_T EW                          ",
               " WHERE 1=1                                ",
               "   AND EW.DZEW001 = '",ls_table_name,"'   ",
               "   AND EW.DZEW003 = 'Index'               ",
               "   AND EW.DZEW002 <> '",ls_curr_version,"'"
               
  PREPARE lpre_get_max_index_prev_version FROM ls_sql
  DECLARE lcur_get_max_index_prev_version CURSOR FOR lpre_get_max_index_prev_version

  OPEN lcur_get_max_index_prev_version
  FETCH lcur_get_max_index_prev_version INTO ls_prev_version
  CLOSE lcur_get_max_index_prev_version
  
  FREE lpre_get_max_index_prev_version
  FREE lcur_get_max_index_prev_version  

  LET ls_return = NVL(ls_prev_version,cs_init_version_code)
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_shot_get_max_construct_revision(p_master_db,p_table_name,p_construct_version)
DEFINE 
  p_master_db         STRING,
  p_table_name        STRING,
  p_construct_version STRING
DEFINE
  ls_master_db         STRING,
  ls_table_name        STRING,
  ls_construct_version STRING,
  ls_sql               STRING,
  li_rec_cnt           INTEGER,
  ls_max_version       VARCHAR(30)         
DEFINE  
  ls_return STRING

  LET ls_master_db  = p_master_db
  LET ls_table_name = p_table_name
  LET ls_construct_version = p_construct_version
  
  LET li_rec_cnt = 1
  
  LET ls_sql = "SELECT TO_CHAR(MAX(TO_NUMBER(NVL(EV.DZEV003,'",cs_init_version_code,"')))) MAX_VERSION ",
               "  FROM DZEV_T EV                                                                       ",
               " WHERE EV.DZEV001 = '",ls_master_db.toUpperCase(),"'                                   ",
               "   AND EV.DZEV002 = '",ls_table_name.toUpperCase(),"'                                  ",
               "   AND EV.DZEV004 = 'TableDesigner'                                                    ",
               "   AND EV.DZEV018 = '",ls_construct_version,"'                                         "
               
  PREPARE lpre_get_max_construct_revision FROM ls_sql
  DECLARE lcur_get_max_construct_revision CURSOR FOR lpre_get_max_construct_revision

  OPEN lcur_get_max_construct_revision
  FETCH lcur_get_max_construct_revision INTO ls_max_version
  CLOSE lcur_get_max_construct_revision
  
  FREE lpre_get_max_construct_revision
  FREE lcur_get_max_construct_revision  

  LET ls_return = ls_max_version
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_shot_get_privileges_diff_by_table_editor(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name     STRING,
  ls_sql            STRING,
  li_rec_cnt        INTEGER,
  lo_privilege_diff DYNAMIC ARRAY OF T_PRIVILEGE_DIFF
DEFINE
  lb_return BOOLEAN,
  lo_return DYNAMIC ARRAY OF T_PRIVILEGE_DIFF 

  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 1
  
  LET ls_sql = "SELECT EN.DZEN002,EN.DZEN003,EN.DZEN004,EN.DZEN005,EN.DZEN006,        ",
               "       EN.DZEN007,EN.DZEN008,EN.DZEN009,EN.DZEN010                    ", 
               "  FROM DZEN_T EN                                                      ",
               " WHERE EN.DZEN001 = '",ls_table_name.toLowerCase(),"'                 ",
               "MINUS                                                                 ",
               "SELECT LOWER(DTP.OWNER)                                     DZEN002,  ",
               "       LOWER(DTP.GRANTEE)                                   DZEN003,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'SELECT','Y')),'N')     DZEN004,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'INSERT','Y')),'N')     DZEN005,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'UPDATE','Y')),'N')     DZEN006,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'DELETE','Y')),'N')     DZEN007,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'REFERENCES','Y')),'N') DZEN008,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'ALTER','Y')),'N')      DZEN009,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'INDEX','Y')),'N')      DZEN010   ",
               "  FROM DBA_TAB_PRIVS DTP                                              ",
               " WHERE DTP.TABLE_NAME = '",ls_table_name.toUpperCase(),"'             ",
               "   AND EXISTS (                                                       ", # 20160812 begin
               "                SELECT 1                                              ",
               "                  FROM GZDA_T DA                                      ",
               "                 WHERE DA.GZDA001 = LOWER(DTP.OWNER)                  ",
               "              )                                                       ",
               "   AND EXISTS (                                                       ",
               "                SELECT 1                                              ",
               "                  FROM GZDA_T DA                                      ",
               "                 WHERE DA.GZDA001 = LOWER(DTP.GRANTEE)                ",
               "              )                                                       ", # 20160812 end
               " GROUP BY DTP.OWNER,DTP.GRANTEE                                       "
                                                                                                                             
  PREPARE lpre_get_privileges_diff_by_table_editor FROM ls_sql
  DECLARE lcur_get_privileges_diff_by_table_editor CURSOR FOR lpre_get_privileges_diff_by_table_editor

  OPEN lcur_get_privileges_diff_by_table_editor
  FOREACH lcur_get_privileges_diff_by_table_editor INTO lo_privilege_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_privileges_diff_by_table_editor

  CALL lo_privilege_diff.deleteElement(li_rec_cnt)
  
  FREE lpre_get_privileges_diff_by_table_editor
  FREE lcur_get_privileges_diff_by_table_editor  
  
  LET lb_return = IIF(lo_privilege_diff.getLength() >= 1,TRUE,FALSE)
  LET lo_return = lo_privilege_diff 
  
  RETURN lb_return,lo_return
  
END FUNCTION 

FUNCTION sadzi140_shot_get_privileges_diff_by_database(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name     STRING,
  ls_sql            STRING,
  li_rec_cnt        INTEGER,
  lo_privilege_diff DYNAMIC ARRAY OF T_PRIVILEGE_DIFF
DEFINE
  lb_return BOOLEAN,
  lo_return DYNAMIC ARRAY OF T_PRIVILEGE_DIFF 

  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 1
  
  LET ls_sql = "SELECT LOWER(DTP.OWNER)                                     DZEN002,  ",
               "       LOWER(DTP.GRANTEE)                                   DZEN003,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'SELECT','Y')),'N')     DZEN004,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'INSERT','Y')),'N')     DZEN005,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'UPDATE','Y')),'N')     DZEN006,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'DELETE','Y')),'N')     DZEN007,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'REFERENCES','Y')),'N') DZEN008,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'ALTER','Y')),'N')      DZEN009,  ",
               "       NVL(MAX(DECODE(DTP.PRIVILEGE,'INDEX','Y')),'N')      DZEN010   ",
               "  FROM DBA_TAB_PRIVS DTP                                              ",
               " WHERE DTP.TABLE_NAME = '",ls_table_name.toUpperCase(),"'             ",
               "   AND EXISTS (                                                       ", # 20160812 begin
               "                SELECT 1                                              ",
               "                  FROM GZDA_T DA                                      ",
               "                 WHERE DA.GZDA001 = LOWER(DTP.OWNER)                  ",
               "              )                                                       ",
               "   AND EXISTS (                                                       ",
               "                SELECT 1                                              ",
               "                  FROM GZDA_T DA                                      ",
               "                 WHERE DA.GZDA001 = LOWER(DTP.GRANTEE)                ",
               "              )                                                       ", # 20160812 end
               " GROUP BY DTP.OWNER,DTP.GRANTEE                                       ",
               "MINUS                                                                 ",
               "SELECT EN.DZEN002,EN.DZEN003,EN.DZEN004,EN.DZEN005,EN.DZEN006,        ",
               "       EN.DZEN007,EN.DZEN008,EN.DZEN009,EN.DZEN010                    ", 
               "  FROM DZEN_T EN                                                      ",
               " WHERE EN.DZEN001 = '",ls_table_name.toLowerCase(),"'                 "
                                                                                                                             
  PREPARE lpre_get_privileges_diff_by_database FROM ls_sql
  DECLARE lcur_get_privileges_diff_by_database CURSOR FOR lpre_get_privileges_diff_by_database

  OPEN lcur_get_privileges_diff_by_database
  FOREACH lcur_get_privileges_diff_by_database INTO lo_privilege_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_privileges_diff_by_database

  CALL lo_privilege_diff.deleteElement(li_rec_cnt)
  
  FREE lpre_get_privileges_diff_by_database
  FREE lcur_get_privileges_diff_by_database  
  
  LET lb_return = IIF(lo_privilege_diff.getLength() >= 1,TRUE,FALSE)
  LET lo_return = lo_privilege_diff 
  
  RETURN lb_return,lo_return
  
END FUNCTION 

FUNCTION sadzi140_shot_check_privileges_if_diff(p_table_name)
DEFINE 
  p_table_name STRING
DEFINE 
  ls_table_name            STRING,
  lo_privilege_design_diff DYNAMIC ARRAY OF T_PRIVILEGE_DIFF,
  lo_privilege_db_diff     DYNAMIC ARRAY OF T_PRIVILEGE_DIFF,
  lb_result                BOOLEAN,
  lb_diff                  BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET ls_table_name = p_table_name

  LET lb_diff = FALSE 

  CALL sadzi140_shot_get_privileges_diff_by_table_editor(p_table_name) RETURNING lb_result,lo_privilege_design_diff
  IF lb_result THEN LET lb_diff = TRUE END IF

  CALL sadzi140_shot_get_privileges_diff_by_database(p_table_name) RETURNING lb_result,lo_privilege_db_diff
  IF lb_result THEN LET lb_diff = TRUE END IF

  LET lb_return = lb_diff
  
  RETURN lb_return
  
END FUNCTION 