&include "../4gl/sadzp250_mcr.inc"

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp250_cnst.inc"

DEFINE
  ms_execute_path STRING

&include "../4gl/sadzp250_type.inc"

FUNCTION sadzp250_util_set_execute_path(p_path)
DEFINE
  p_path STRING 

  LET ms_execute_path = p_path
  
END FUNCTION 

FUNCTION sadzp250_util_get_execute_path()
DEFINE
  ls_path STRING 
  
  LET ls_path = ms_execute_path

  RETURN ls_path
  
END FUNCTION 

FUNCTION sadzp250_util_get_form_path(p_form_name)
DEFINE
  p_form_name STRING 
DEFINE
  ls_form_name    STRING,
  ls_path         STRING,
  ls_os_separator STRING,
  ls_form_path    STRING

  LET ls_form_name = p_form_name
  
  LET ls_path = sadzp250_util_get_execute_path()
  LET ls_os_separator = os.Path.separator()
  LET ls_form_path = ls_path,ls_os_separator,ls_form_name                      

  RETURN ls_form_path
  
END FUNCTION 

FUNCTION sadzp250_util_trim_str(p_string)
DEFINE
  p_string STRING
DEFINE
  ls_string STRING
DEFINE
  ls_return STRING

  LET ls_string = p_string

  LET ls_string = ls_string.trim()
  
  LET ls_return = ls_string
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzp250_util_get_program_title(p_program,p_lang)
DEFINE
  p_program STRING,
  p_lang    STRING
DEFINE
  ls_program STRING,
  ls_lang    STRING,
  ls_program_title VARCHAR(512),
  ls_sql     STRING
DEFINE
  ls_return STRING  

  LET ls_program = p_program
  LET ls_lang    = p_lang
  
  LET ls_sql = "SELECT ZA.GZZA001||'-'||ZAL.GZZAL003  PROGRAM_TITLE           ",
               "  FROM GZZA_T ZA                                              ",
               "  LEFT OUTER JOIN GZZAL_T ZAL ON ZAL.GZZAL001 = ZA.GZZA001    ",
               "                             AND ZAL.GZZAL002 = '",ls_lang,"' ",
               " WHERE ZA.GZZA001 = '",ls_program,"'                          "              

  PREPARE lpre_get_program_title FROM ls_sql
  DECLARE lcur_get_program_title CURSOR FOR lpre_get_program_title

  INITIALIZE ls_program_title TO NULL
  
  OPEN lcur_get_program_title
  FETCH lcur_get_program_title INTO ls_program_title
  CLOSE lcur_get_program_title
  
  FREE lpre_get_program_title
  FREE lcur_get_program_title  

  LET ls_return = ls_program_title
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp250_util_get_GUID()
DEFINE 
  ls_GUID  STRING
DEFINE  
  ls_return STRING

  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID 

  LET ls_return = ls_GUID
  
  RETURN ls_return                     
  
END FUNCTION

FUNCTION sadzp250_util_run_table_patcher(p_file_name)
DEFINE
  p_file_name STRING
DEFINE
  ls_file_name STRING,
  ls_command   STRING,
  ls_message   STRING,
  ls_GUID      STRING,
  ls_TEMPDIR   STRING,
  ls_log_file  STRING,
  ls_file_main STRING,
  lb_result    BOOLEAN,
  ls_separator STRING,
  ls_result    STRING,
  li_count     INTEGER 
DEFINE
  ls_return  STRING
  
  LET ls_file_name = p_file_name

  LET ls_separator = os.Path.separator()

  LET ls_GUID = security.RandomGenerator.CreateUUIDString()
  LET ls_TEMPDIR = FGL_GETENV("TEMPDIR")
  LET ls_file_main = os.Path.basename(ls_file_name)
  LET ls_log_file = ls_TEMPDIR,ls_separator,"adzp250_",ls_GUID,".log" 
  
  LET ls_command = "r.r adzp240 '",ls_file_name,"' > ",ls_log_file
  DISPLAY cs_command_tag,ls_command

  &ifndef DEBUG
  RUN ls_command WITHOUT WAITING
  &endif

  LET li_count = 0
  #Log 檔產生以後才離開
  WHILE TRUE
    IF os.Path.exists(ls_log_file) AND os.Path.readable(ls_log_file) THEN
      #取得Log檔中的GUID
      CALL sadzp250_util_get_execution_guid(ls_log_file) RETURNING lb_result,ls_result
      IF ls_result IS NOT NULL THEN 
        DISPLAY cs_message_tag,"Get Execution ID : ",ls_result
        EXIT WHILE 
      END IF
    ELSE  
      LET li_count = li_count + 1 
      SLEEP 1
      ERROR "Waiting ",li_count," seconds." ATTRIBUTES(BLUE) 
      CALL ui.Interface.refresh()
      -- 60 秒後就離開
      IF li_count > = 60 THEN
        ERROR cs_error_tag,"Out of time(60s) for waiting log generating !!" ATTRIBUTES(BLUE) 
        EXIT WHILE 
      END IF
    END IF  
  END WHILE  
  CALL os.Path.delete(ls_log_file) RETURNING lb_result

  LET ls_return = ls_result

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp250_util_get_execution_guid(p_log_file)
DEFINE
  p_log_file STRING 
DEFINE
  lo_channel   base.Channel,
  ls_TextLine  STRING,
  li_RecCnt    INTEGER,
  ls_log_file  STRING,
  ls_GUID      STRING,
  lb_success   BOOLEAN,
  ls_const_str STRING
DEFINE
  lb_return BOOLEAN,
  ls_return STRING  

  LET ls_log_file = p_log_file 

  LET lb_success = TRUE
  LET ls_TextLine = ""
  LET ls_const_str = "Execution GUID : "
  
  LET lo_channel = base.Channel.create()
  TRY 
    CALL lo_channel.openFile(ls_log_file,"r")
  CATCH
    LET lb_success = FALSE
    DISPLAY cs_error_tag,"Open file ",ls_log_file," failed !!"
  END TRY  

  IF lb_success THEN
    LET li_RecCnt = 1 
    WHILE TRUE
      IF lo_channel.isEof() THEN 
        EXIT WHILE
      END IF

      LET ls_TextLine = lo_channel.readLine()

      IF ls_TextLine.getIndexOf(ls_const_str,1) >= 1 THEN
        LET ls_GUID = ls_TextLine.subString(ls_TextLine.getIndexOf(ls_const_str,1) + ls_const_str.getLength(),ls_TextLine.getLength())
        EXIT WHILE 
      END IF 
      
      LET li_RecCnt = li_RecCnt + 1 
        
    END WHILE
  END IF

  LET lb_return = lb_success
  LET ls_return = ls_GUID.trim()

  RETURN lb_return,ls_return
  
END FUNCTION

