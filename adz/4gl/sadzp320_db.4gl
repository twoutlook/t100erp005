&include "../4gl/sadzp320_mcr.inc"

IMPORT util
IMPORT OS 
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp320_cnst.inc"

&include "../4gl/sadzp320_type.inc"


FUNCTION sadzp320_db_get_db_connect_string(p_db_name)
DEFINE
  p_db_name STRING
DEFINE
  ls_db_name      STRING,
  ls_db_sid       STRING,
  ls_privacy_word STRING,
  lb_success      BOOLEAN,
  lo_db_connstr   T_DB_CONNSTR,
  ls_sql          STRING
DEFINE
  lo_return T_DB_CONNSTR  
  
  LET ls_db_name = p_db_name.toLowerCase()

  LET ls_db_sid = FGL_GETENV("ORACLE_SID")
  
  LET ls_sql = "SELECT '",ls_db_sid,"'  DB_SOURCE,       ",
               "       DA.GZDA003       DB_USERNAME,     ",
               "       DA.GZDA004       DB_PASSWORD,     ",
               "       DA.GZDA001       DB_SCHEMA,       ",
               "       '",ls_db_sid,"'  DB_SID,          ",
               "       ''               DB_SQL_FILENAME, ",
               "       ''               DB_VERSION       ",
               "  FROM GZDA_T DA                         ",
               " WHERE 1=1                               ",
               "   AND DA.GZDA001  = '",ls_db_name,"'    ",
               "   AND DA.GZDA005  = 'Y'                 ", 
               "   AND DA.GZDASTUS = 'Y'                 "

  PREPARE lpre_get_db_connect_string FROM ls_sql
  DECLARE lcur_get_db_connect_string CURSOR FOR lpre_get_db_connect_string

  INITIALIZE lo_db_connstr TO NULL
  
  OPEN lcur_get_db_connect_string
  FETCH lcur_get_db_connect_string INTO lo_db_connstr.*
  CLOSE lcur_get_db_connect_string

  &ifndef DEBUG
  IF (NVL(lo_db_connstr.db_username,cs_null_value) = cs_master_db) THEN
    CALL sadzi140_db_get_privacy_word() RETURNING lb_success,ls_privacy_word
    IF lb_success THEN 
      LET lo_db_connstr.db_password = cl_hashkey_base65_anti(ls_privacy_word)
    ELSE 
      LET lo_db_connstr.db_password = cl_hashkey_base65_anti(lo_db_connstr.db_password)
    END IF 
  ELSE 
    IF lo_db_connstr.db_username IS NOT NULL THEN 
      LET lo_db_connstr.db_password = cl_hashkey_base65_anti(lo_db_connstr.db_password)
    END IF  
  END IF 
  &endif
  
  FREE lpre_get_db_connect_string
  FREE lcur_get_db_connect_string  

  LET lo_return.* = lo_db_connstr.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzp320_db_sqlplus(p_db_connstr)
DEFINE
  p_db_connstr T_DB_CONNSTR
DEFINE
  lo_db_connstr  T_DB_CONNSTR,
  ls_sqlplus_str STRING,
  ls_message     STRING,
  ls_log_file    STRING,
  ls_file_list   STRING,
  ls_return      STRING

  LET lo_db_connstr.* = p_db_connstr.*

  LET ls_sqlplus_str = "sqlplus ",lo_DB_CONNSTR.db_username,"/",lo_DB_CONNSTR.db_password,"@",lo_DB_CONNSTR.db_sid||" @"||lo_DB_CONNSTR.db_sql_filename

  CALL sadzp320_db_run_and_catch_log(ls_sqlplus_str) RETURNING ls_message
  CALL sadzp320_db_gen_log_file(ls_Message) RETURNING ls_log_file

  LET ls_file_list = ls_file_list,"SQL File : ",lo_DB_CONNSTR.db_sql_filename,"\n"
  LET ls_file_list = ls_file_list,"Log File : ",ls_log_file,"\n"
  LET ls_file_list = ls_file_list,ls_message
  
  LET ls_return = ls_file_list
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzp320_db_run_and_catch_log(p_command)
DEFINE 
  p_command   STRING  #要執行的指令
DEFINE  
  ls_command  STRING, #要執行的指令
  ls_return   STRING,
  ls_cmd_line STRING,
  ls_message  STRING,
  li_log_line INTEGER,
  lch_read    base.Channel   

  LET ls_command = p_command   
  
  LET ls_message  = ""
  LET li_log_line = 0

  LET lch_read  = base.Channel.create()
  CALL lch_read.setDelimiter("")

  #LET ls_command = ls_command||" 2>&1"
  
  CALL lch_read.openPipe(ls_command, "r")
  WHILE TRUE
    LET ls_cmd_line = lch_read.readLine()
    IF lch_read.isEof() THEN 
      EXIT WHILE 
    END IF

    LET li_log_line = li_log_line + 1 
    LET ls_message = ls_message, 
                     "[",(li_log_line USING "&&&&"),"] ",ls_cmd_line, "\n"
    LET ls_cmd_line = ls_cmd_line.toUpperCase()

  END WHILE
  CALL lch_read.close()

  LET ls_return = ls_message
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp320_db_gen_log_file(p_log)
DEFINE
  p_log      STRING
DEFINE
  ls_log           STRING, 
  ls_GUID   STRING,
  ls_temp_dir      STRING,
  lchannel_write   base.Channel,
  ls_log_filename  STRING,
  ls_return        STRING,
  ls_separator     STRING
  
  LET ls_log      = p_log

  LET ls_separator = os.Path.separator()
  
  LET ls_temp_dir = FGL_GETENV("TEMPDIR")
  
  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID
  
  LET ls_log_filename = ls_temp_dir,ls_separator,"sadzp320_db_",ls_GUID,".log"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  LET ls_log = ls_log
  
  #開檔寫入
  TRY
    CALL lchannel_write.openFile(ls_log_filename, "w" )
    CALL lchannel_write.write(ls_log)
    #關檔
    CALL lchannel_write.close()
  CATCH
    DISPLAY cs_error_tag,"Generate log Error : ",ls_log_filename
  END TRY  

  LET ls_return = ls_log_filename

  RETURN ls_return

END FUNCTION

FUNCTION sadzp320_db_exec_SQL(p_sql)
DEFINE
  p_sql STRING
DEFINE
  ls_sql         STRING,
  ls_replace_arg STRING
DEFINE
  lb_return BOOLEAN 

  LET ls_sql = p_sql

  LET lb_return = TRUE
  
  BEGIN WORK

  TRY
    PREPARE lpre_exec_sql FROM ls_sql
    EXECUTE lpre_exec_sql
    COMMIT WORK
  CATCH
    LET lb_return = FALSE
    ROLLBACK WORK
  END TRY  

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp320_db_exec_SQL_no_commit(p_sql)
DEFINE
  p_sql STRING
DEFINE
  ls_sql         STRING,
  ls_replace_arg STRING
DEFINE
  lb_return BOOLEAN 
  
  LET ls_sql = p_sql

  LET lb_return = TRUE
  
  TRY
    PREPARE lpre_exec_SQL_no_commit FROM ls_sql
    EXECUTE lpre_exec_SQL_no_commit
  CATCH
    LET lb_return = FALSE
  END TRY  

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp320_db_gen_sql_script_file(p_sql,p_sql_type)
DEFINE
  p_sql      STRING,
  p_sql_type STRING 
DEFINE
  ls_sql             STRING,
  ls_sql_type        STRING, 
  ls_exit_sign       STRING,
  ls_random_name     STRING,
  ls_tempdir         STRING,
  lchannel_write     base.Channel,
  ls_sript_filename  STRING,
  ls_separator       STRING, 
  ls_return          STRING
  
  LET ls_sql      = p_sql
  LET ls_sql_type = p_sql_type
  LET ls_exit_sign = "exit;"

  LET ls_separator = os.Path.separator()

  LET ls_tempdir = FGL_GETENV("TEMPDIR")
  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_random_name 
  LET ls_sript_filename = ls_tempdir,ls_separator,"sadzp320_db_",ls_sql_type,"_",ls_random_name,".sql"
  
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  LET ls_sql = ls_sql,"\n",
               ls_exit_sign
  
  #開檔寫入
  TRY
    CALL lchannel_write.openFile(ls_sript_filename, "w" )
    CALL lchannel_write.write(ls_sql)
    #關檔
    CALL lchannel_write.close()
  CATCH
    DISPLAY "Generate Script Error !!"
  END TRY  

  LET ls_return = ls_sript_filename

  RETURN ls_return

END FUNCTION
