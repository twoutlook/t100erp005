&include "../4gl/sadzp250_mcr.inc"

IMPORT util
IMPORT OS 
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp250_cnst.inc"

&include "../4gl/sadzp250_type.inc"

FUNCTION sadzp250_db_connect_db(p_db)
DEFINE 
  p_db STRING

  TRY
    DISCONNECT CURRENT
  CATCH
    DISPLAY "[Hint] No any connection, skip disconnect."
  END TRY  
  
  CONNECT TO p_db
  
END FUNCTION

FUNCTION sadzp250_db_get_parameters(p_level,p_param)
DEFINE
  p_level STRING,
  p_param STRING
DEFINE
  ls_level     STRING,
  ls_param     STRING,
  ls_sql       STRING,
  lo_parameter T_PARAMETERS
DEFINE
  lo_return    T_PARAMETERS

  LET ls_level = p_level
  LET ls_param = p_param

  LET ls_sql = "SELECT EJ.DZEJ005,EJ.DZEJ006,EJ.DZEJ007,EJ.DZEJ008,EJ.DZEJ009 ",
               "  FROM DZEJ_T EJ                                              ",
               " WHERE EJ.DZEJ001 = 'adzp250_parameters'                      ",
               "   AND EJ.DZEJ003 = '",ls_level,"'                            ",
               "   AND EJ.DZEJ004 = '",ls_param,"'                            "
                              
  PREPARE lpre_get_parameter FROM ls_sql
  DECLARE lcur_get_parameter CURSOR FOR lpre_get_parameter

  OPEN lcur_get_parameter
  FETCH lcur_get_parameter INTO lo_parameter.*
  CLOSE lcur_get_parameter
  
  FREE lpre_get_parameter
  FREE lcur_get_parameter  

  LET lo_return.* = lo_parameter.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzp250_db_get_db_info()
DEFINE
  lo_db_info T_DB_INFO,
  ls_sql     STRING
DEFINE
  lo_return T_DB_INFO  

  LET ls_sql = "SELECT ORA_DATABASE_NAME, USER ", 
               "  FROM DUAL                    " 

  PREPARE lpre_get_db_info FROM ls_sql
  DECLARE lcur_get_db_info CURSOR FOR lpre_get_db_info

  INITIALIZE lo_db_info TO NULL
  
  OPEN lcur_get_db_info
  FETCH lcur_get_db_info INTO lo_db_info.*
  CLOSE lcur_get_db_info
  
  FREE lpre_get_db_info
  FREE lcur_get_db_info  

  LET lo_return.* = lo_db_info.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzp250_db_run_and_catch_log(p_command)
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

FUNCTION sadzp250_db_gen_log_file(p_log)
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
  
  CALL sadzp250_util_get_GUID() RETURNING ls_GUID
  
  LET ls_log_filename = ls_temp_dir,ls_separator,"sadzp250_db_",ls_GUID,".log"
  
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
    DISPLAY "Generate log Error : ",ls_log_filename
  END TRY  

  LET ls_return = ls_log_filename

  RETURN ls_return

END FUNCTION

FUNCTION sadzp250_db_exec_SQL(p_sql,p_batch_mode)
DEFINE
  p_sql STRING,
  p_batch_mode BOOLEAN
DEFINE
  ls_sql         STRING,
  lb_batch_mode  BOOLEAN,
  ls_replace_arg STRING
DEFINE
  lb_return BOOLEAN 

  LET ls_sql = p_sql
  LET lb_batch_mode = p_batch_mode

  LET lb_return = TRUE
  
  BEGIN WORK

  TRY
    PREPARE lpre_exec_sql FROM ls_sql
    EXECUTE lpre_exec_sql
    COMMIT WORK
  CATCH
    CALL FGL_WINMESSAGE("Error","執行 SQL"||ls_sql||" 失敗.","stop")
    ROLLBACK WORK
  END TRY  

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp250_db_exec_SQL_no_commit(p_sql,p_batch_mode)
DEFINE
  p_sql STRING,
  p_batch_mode BOOLEAN
DEFINE
  ls_sql         STRING,
  lb_batch_mode  BOOLEAN,
  ls_replace_arg STRING
DEFINE
  lb_return BOOLEAN 
  
  LET ls_sql = p_sql
  LET lb_batch_mode = p_batch_mode

  LET lb_return = TRUE
  
  TRY
    PREPARE lpre_exec_SQL_no_commit FROM ls_sql
    EXECUTE lpre_exec_SQL_no_commit
  CATCH
    LET lb_return = FALSE
    CALL FGL_WINMESSAGE("Error","執行 SQL"||ls_sql||" 失敗.","stop")
  END TRY  

  RETURN lb_return
  
END FUNCTION

