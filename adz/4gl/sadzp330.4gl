&include "../4gl/sadzp330_mcr.inc"

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp330_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp240_type.inc"
&include "../4gl/sadzp330_type.inc"

#執行的環境變數
DEFINE 
  ms_lang         STRING,
  ms_MasterDB     STRING,
  ms_MasterUser   STRING,
  mb_backend_mode BOOLEAN,
  mo_arguments    T_ARGUMENTS,
  mb_result       BOOLEAN
            
FUNCTION sadzp330_run(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ARGUMENTS 
  
  CALL sadzp330_initialize(p_backend_mode,p_arguments.*)
  CALL sadzp330_start() RETURNING mb_result
  CALL sadzp330_finalize()

  RETURN mb_result

END FUNCTION

FUNCTION sadzp330_initialize(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ARGUMENTS

  LET mb_backend_mode = p_backend_mode
  LET mo_arguments.*  = p_arguments.*

  &ifndef DEBUG
    LET ms_lang = NVL(g_lang,cs_default_lang)
  &else
    LET ms_lang = cs_default_lang
  &endif
  
END FUNCTION

FUNCTION sadzp330_start()
DEFINE
  lb_result        BOOLEAN,
  ls_result        STRING,
  ls_replace_arg   STRING,
  li_loop          INTEGER,
  ls_message       STRING,
  ls_all_message   STRING,
  lo_grant_tables  DYNAMIC ARRAY OF T_GRANT_TABLES
DEFINE
  lb_return  BOOLEAN

  LET lb_result = TRUE
  
  CALL sadzp330_get_grant_revoke_list(mo_arguments.a_TABLE_NAME) RETURNING lo_grant_tables

  FOR li_loop = 1 TO lo_grant_tables.getLength()
    DISPLAY cs_message_tag,"Grant/Revoke table : ",lo_grant_tables[li_loop].gt_TABLE_NAME
    CALL sadzi140_util_grant_revoke_privileges(lo_grant_tables[li_loop].gt_TABLE_NAME) RETURNING ls_result
    LET ls_message = ls_result.toUpperCase()
    IF ls_message.getIndexOf('ERROR',1) >= 1 THEN
      DISPLAY cs_error_tag,"Table ",lo_grant_tables[li_loop].gt_TABLE_NAME," grant/revoke not success'"
      LET lb_result = FALSE
      LET ls_all_message = ls_all_message,"\n",ls_result 
    END IF   
  END FOR 

  IF NOT lb_result THEN
    DISPLAY cs_error_tag,ls_all_message
  END IF 
  
  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp330_finalize()
END FUNCTION

FUNCTION sadzp330_get_grant_revoke_list(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name    STRING,
  li_rec_count     INTEGER,
  ls_sql           STRING,
  ls_cond_sql      STRING,
  ls_exists_sql    STRING,
  lo_grant_tables  DYNAMIC ARRAY OF T_GRANT_TABLES
DEFINE
  lo_return  DYNAMIC ARRAY OF T_GRANT_TABLES
  
  LET ls_table_name = p_table_name

  IF ls_table_name.toUpperCase() = "ALL" THEN
    LET ls_cond_sql = "" 
    LET ls_exists_sql = "   AND NOT EXISTS (                                                                                    ",
                        "                    SELECT 1                                                                           ",
                        "                      FROM (                                                                           ",
                        "                             SELECT DTP.TABLE_NAME,DTP.OWNER,DTP.GRANTEE,                              ",
                        "                                    NVL(MAX(DECODE(DTP.PRIVILEGE,'SELECT','Y',NULL)),'N')     DZEN004, ",
                        "                                    NVL(MAX(DECODE(DTP.PRIVILEGE,'INSERT','Y',NULL)),'N')     DZEN005, ",
                        "                                    NVL(MAX(DECODE(DTP.PRIVILEGE,'UPDATE','Y',NULL)),'N')     DZEN006, ",
                        "                                    NVL(MAX(DECODE(DTP.PRIVILEGE,'DELETE','Y',NULL)),'N')     DZEN007, ",
                        "                                    NVL(MAX(DECODE(DTP.PRIVILEGE,'REFERENCES','Y',NULL)),'N') DZEN008, ",
                        "                                    NVL(MAX(DECODE(DTP.PRIVILEGE,'ALTER','Y',NULL)),'N')      DZEN009, ",
                        "                                    NVL(MAX(DECODE(DTP.PRIVILEGE,'INDEX','Y',NULL)),'N')      DZEN010  ",
                        "                              FROM DBA_TAB_PRIVS DTP                                                   ",
                        "                             GROUP BY DTP.TABLE_NAME,DTP.OWNER,DTP.GRANTEE                             ",
                        "                           ) DTPX                                                                      ",
                        "                     WHERE 1=1                                                                         ",
                        "                       AND DTPX.TABLE_NAME = UPPER(EN.DZEN001)                                         ",
                        "                       AND DTPX.OWNER      = UPPER(EN.DZEN002)                                         ",
                        "                       AND DTPX.GRANTEE    = UPPER(EN.DZEN003)                                         ",
                        "                       AND DTPX.DZEN004    = EN.DZEN004                                                ",
                        "                       AND DTPX.DZEN005    = EN.DZEN005                                                ",
                        "                       AND DTPX.DZEN006    = EN.DZEN006                                                ",
                        "                       AND DTPX.DZEN007    = EN.DZEN007                                                ",
                        "                       AND DTPX.DZEN008    = EN.DZEN008                                                ",
                        "                       AND DTPX.DZEN009    = EN.DZEN009                                                ",
                        "                       AND DTPX.DZEN010    = EN.DZEN010                                                ",
                        "                  )                                                                                    "
  ELSE
    LET ls_cond_sql = " AND EN.DZEN001 = '",ls_table_name.toLowerCase(),"' "
    LET ls_exists_sql = ""
  END IF 

  LET ls_sql = "SELECT EN.DZEN001                                         ",
               "  FROM DZEN_T EN                                          ",
               " WHERE 1=1                                                ",
               "   AND EXISTS (                                           ",
               "                SELECT 1                                  ",
               "                  FROM DBA_TABLES DTS                     ",
               "                 WHERE DTS.OWNER      = UPPER(EN.DZEN002) ",
               "                   AND DTS.TABLE_NAME = UPPER(EN.DZEN001) ",
               "              )                                           ",
               ls_cond_sql,
               ls_exists_sql,
               " GROUP BY EN.DZEN001                                      ",
               " ORDER BY EN.DZEN001                                      "

  INITIALIZE lo_grant_tables TO NULL
  
  PREPARE lpre_get_grant_revoke_list FROM ls_sql
  DECLARE lcur_get_grant_revoke_list CURSOR FOR lpre_get_grant_revoke_list

  LET li_rec_count = 1

  OPEN lcur_get_grant_revoke_list
  FOREACH lcur_get_grant_revoke_list INTO lo_grant_tables[li_rec_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

  END FOREACH
  CALL lo_grant_tables.deleteElement(li_rec_count)
  
  CLOSE lpre_get_grant_revoke_list
  CLOSE lcur_get_grant_revoke_list
  
  LET lo_return = lo_grant_tables
  
  RETURN lo_return
  
END FUNCTION 