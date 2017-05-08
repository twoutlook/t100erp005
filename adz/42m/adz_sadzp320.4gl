&include "../4gl/sadzp320_mcr.inc"

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp320_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp240_type.inc"
&include "../4gl/sadzp320_type.inc"

#執行的環境變數
DEFINE 
  ms_lang         STRING,
  ms_MasterDB     STRING,
  ms_MasterUser   STRING,
  mb_backend_mode BOOLEAN,
  mo_arguments    T_ARGUMENTS,
  mb_result       BOOLEAN
            
FUNCTION sadzp320_run(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ARGUMENTS 
  
  CALL sadzp320_initialize(p_backend_mode,p_arguments.*)
  CALL sadzp320_start() RETURNING mb_result
  CALL sadzp320_finalize()

  RETURN mb_result

END FUNCTION

FUNCTION sadzp320_initialize(p_backend_mode,p_arguments)
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

FUNCTION sadzp320_start()
DEFINE
  lb_result         BOOLEAN,
  ls_result         STRING,
  ls_replace_arg    STRING,
  lo_invalid_object DYNAMIC ARRAY OF T_INVALID_OBJECT
DEFINE
  lb_return  BOOLEAN

  CALL sadzp320_get_invalid_objects(mo_arguments.a_TABLE_NAME) RETURNING lo_invalid_object
  IF lo_invalid_object.getLength() <> 0 THEN 
    CALL sadzp320_recompile_invalid_objects(lo_invalid_object) RETURNING lb_result,ls_result
    IF NOT lb_result THEN 
      DISPLAY cs_error_tag,"Objects belong to ",mo_arguments.a_TABLE_NAME," recompile with error : ",ls_result
    ELSE  
      DISPLAY cs_success_tag,"Objects belong to ",mo_arguments.a_TABLE_NAME," recompile successed."
    END IF
  ELSE
    DISPLAY cs_message_tag,"Objects belong to ",mo_arguments.a_TABLE_NAME," no need to recompile."
  END IF  
  
  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp320_finalize()
END FUNCTION

FUNCTION sadzp320_get_invalid_objects(p_object_name)
DEFINE
  p_object_name STRING
DEFINE
  ls_object_name     STRING,
  li_rec_count       INTEGER,
  ls_sql             STRING,
  lo_invalid_object  DYNAMIC ARRAY OF T_INVALID_OBJECT
DEFINE
  lo_return  DYNAMIC ARRAY OF T_INVALID_OBJECT
  
  LET ls_object_name = p_object_name

  LET ls_sql = "SELECT UPPER(IV.DZIV002)            OWNER,                               ", 
               "       UPPER('",ls_object_name,"')  TABLE_NAME,                          ", 
               "       'VIEW'                       OBJECT_TYPE,                         ", 
               "       UPPER(IV.DZIV001)            OBJECT_NAME,                         ", 
               "       NVL(DO.STATUS,'N/A')         STATUS                               ", 
               "  FROM DZIV_T IV                                                         ", 
               "  LEFT OUTER JOIN DBA_OBJECTS DO ON DO.OWNER = UPPER(IV.DZIV002)         ", 
               "                                AND DO.OBJECT_NAME = UPPER(IV.DZIV001)   ", 
               " WHERE 1=1                                                               ", 
               "   AND EXISTS (                                                          ", 
               "                SELECT 1                                                 ", 
               "                  FROM GZDA_T DA                                         ", 
               "                 WHERE DA.GZDA001  = IV.DZIV002                          ", 
               "                   AND DA.GZDA005  = 'Y'                                 ", 
               "                   AND DA.GZDASTUS = 'Y'                                 ", 
               "              )                                                          ", 
               "   AND DO.STATUS = 'INVALID'                                             ", 
               "   AND UPPER(IV.DZIV004) LIKE UPPER('%",ls_object_name,"%')              ", 
               "UNION                                                                    ", 
               "SELECT UPPER(IT.DZIT003)    OWNER,                                       ", 
               "       UPPER(IT.DZIT001)    TABLE_NAME,                                  ", 
               "       'TRIGGER'            OBJECT_TYPE,                                 ", 
               "       UPPER(IT.DZIT002)    OBJECT_NAME,                                 ", 
               "       NVL(DO.STATUS,'N/A') STATUS                                       ", 
               "  FROM DZIT_T IT                                                         ", 
               "  LEFT OUTER JOIN DBA_OBJECTS DO ON DO.OWNER = UPPER(IT.DZIT003)         ", 
               "                                AND DO.OBJECT_NAME = UPPER(IT.DZIT002)   ", 
               " WHERE 1=1                                                               ", 
               "   AND EXISTS (                                                          ", 
               "                SELECT 1                                                 ", 
               "                  FROM GZDA_T DA                                         ", 
               "                 WHERE DA.GZDA001  = IT.DZIT003                          ", 
               "                   AND DA.GZDA005  = 'Y'                                 ", 
               "                   AND DA.GZDASTUS = 'Y'                                 ", 
               "              )                                                          ", 
               "   AND DO.STATUS  = 'INVALID'                                            ",
               "   AND IT.DZIT001 = LOWER('",ls_object_name,"')                          "

  INITIALIZE lo_invalid_object TO NULL
  
  PREPARE lpre_get_invalid_objects FROM ls_sql
  DECLARE lcur_get_invalid_objects CURSOR FOR lpre_get_invalid_objects

  LET li_rec_count = 1

  OPEN lcur_get_invalid_objects
  FOREACH lcur_get_invalid_objects INTO lo_invalid_object[li_rec_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

  END FOREACH
  CALL lo_invalid_object.deleteElement(li_rec_count)
  
  CLOSE lpre_get_invalid_objects
  CLOSE lcur_get_invalid_objects
  
  LET lo_return = lo_invalid_object
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzp320_recompile_invalid_objects(p_invalid_object)
DEFINE 
  p_invalid_object  DYNAMIC ARRAY OF T_INVALID_OBJECT
DEFINE 
  lo_invalid_object    DYNAMIC ARRAY OF T_INVALID_OBJECT,
  lo_invalid_owner     DYNAMIC ARRAY OF T_INVALID_OWNER,
  lo_db_connstr        T_DB_CONNSTR,
  li_count             INTEGER,
  li_invalid           INTEGER,
  ls_recompile_sql     STRING,
  ls_recompile_all_sql STRING,
  ls_sql_memo          STRING,
  ls_sql_script        STRING,
  ls_recomp_filename   STRING,
  ls_message           STRING,
  ls_all_message       STRING,
  ls_error_check       STRING,
  lb_result            BOOLEAN
DEFINE
  lb_return BOOLEAN,
  ls_return STRING

  LET lo_invalid_object = p_invalid_object

  LET lb_return = TRUE

  CALL sadzp320_get_invalid_owner(lo_invalid_object) RETURNING lo_invalid_owner
  
  FOR li_count = 1 TO lo_invalid_owner.getLength()

    LET ls_recompile_all_sql = ""
    LET ls_sql_script     = ""
  
    FOR li_invalid = 1 TO lo_invalid_object.getLength()
      IF lo_invalid_object[li_invalid].io_OWNER = lo_invalid_owner[li_count].ir_NAME THEN
        #取得要 ReCompile 的SQL 
        CALL sadzp320_get_recompile_script(lo_invalid_object[li_invalid].*) RETURNING ls_recompile_sql
        LET ls_recompile_all_sql = ls_recompile_all_sql,"\n",
                                   ls_recompile_sql  
      END IF
    END FOR

    LET ls_sql_memo = "/*","\n",
                      "Purpose : For recompile invalid object'","\n",
                      "Object owner : ",lo_invalid_owner[li_count].ir_NAME,"\n",   
                      "*/"
  
    LET ls_sql_script = ls_sql_memo,"\n",
                        ls_sql_script,"\n",
                        ls_recompile_all_sql,"\n"
                        
    CALL sadzp320_db_get_db_connect_string(lo_invalid_owner[li_count].ir_NAME) RETURNING lo_db_connstr.*
    CALL sadzp320_db_gen_sql_script_file(ls_sql_script,cs_recompile_object) RETURNING ls_recomp_filename
    LET lo_db_connstr.db_sql_filename = ls_recomp_filename
    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
      CALL sadzp320_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Recompile invalid objects.","\n", 
                           "User : ",lo_db_connstr.db_username,"\n",
                           "Version : ",lo_db_connstr.db_version,"\n",
                           ls_message
    END IF
    
  END FOR   
  
  LET ls_return = ls_all_message
  LET ls_error_check = ls_all_message.toUpperCase()
  IF ls_error_check.getIndexOf('ERROR',1) >= 1 THEN
    LET lb_return = FALSE
  END IF

  RETURN lb_return,ls_return
  
END FUNCTION 

FUNCTION sadzp320_get_invalid_owner(p_invalid_object)
DEFINE
  p_invalid_object  DYNAMIC ARRAY OF T_INVALID_OBJECT
DEFINE
  lo_invalid_object DYNAMIC ARRAY OF T_INVALID_OBJECT,
  lo_invalid_owner  DYNAMIC ARRAY OF T_INVALID_OWNER,
  li_diff           INTEGER,  
  li_loop           INTEGER,
  lb_exist          BOOLEAN, 
  ls_object         STRING,
  li_rec_cnt        INTEGER,
  ls_sql            STRING
DEFINE
  lo_return  DYNAMIC ARRAY OF T_INVALID_OWNER 

  LET lo_invalid_object = p_invalid_object

  LET li_rec_cnt = 1
  CALL lo_invalid_owner.clear()

  #從差異清單中抓取不重複的賦予權限者
  FOR li_diff = 1 TO lo_invalid_object.getLength()
    LET lb_exist = FALSE
    #找到有重複則離開
    FOR li_loop = 1 TO lo_invalid_owner.getLength()
      IF lo_invalid_owner[li_loop].ir_NAME = lo_invalid_object[li_diff].io_OWNER THEN
        LET lb_exist = TRUE
        EXIT FOR
      END IF 
    END FOR
    #不重複則加入清單
    IF NOT lb_exist THEN
      LET lo_invalid_owner[lo_invalid_owner.getLength() + 1].ir_NAME = lo_invalid_object[li_diff].io_OWNER
    END IF
  END FOR 

  LET lo_return = lo_invalid_owner

  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzp320_get_recompile_script(p_invalid_object)
DEFINE
  p_invalid_object  T_INVALID_OBJECT
DEFINE
  lo_invalid_object  T_INVALID_OBJECT,
  ls_sql STRING
DEFINE
  ls_return STRING
  
  LET lo_invalid_object.* = p_invalid_object.*

  LET ls_sql = "ALTER ",lo_invalid_object.io_OBJECT_TYPE," ",lo_invalid_object.io_OBJECT_NAME," COMPILE",";","\n"

  LET ls_return = ls_sql

  RETURN ls_return
  
END FUNCTION