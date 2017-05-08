&include "../4gl/sadzp000_mcr.inc" 

IMPORT OS

FUNCTION sadzp050_fnc_exec_prog(p_command,p_check_fault)
DEFINE 
  p_command     STRING,
  p_check_fault BOOLEAN  
DEFINE 
  ls_command      STRING,  
  lb_check_fault  BOOLEAN,
  lb_success      BOOLEAN, 
  ls_all_message  STRING,  
  lo_channel      base.Channel,
  ls_message      STRING,
  ls_err_message  STRING
DEFINE
  lb_return BOOLEAN  

  LET ls_command     = p_command
  LET lb_check_fault = p_check_fault
  
  LET ls_all_message = NULL
  LET lb_success = TRUE
  LET lb_return  = TRUE

  LET lo_channel = base.Channel.create()
  CALL lo_channel.setDelimiter("")

  #DISPLAY "ls_command: ",ls_command
  LET ls_command = ls_command CLIPPED," 2>&1"

  CALL lo_channel.openPipe(ls_command,"r")   #執行指令
  IF STATUS THEN
    LET lb_success = FALSE
  ELSE
    WHILE TRUE
      CALL lo_channel.readLine() RETURNING ls_message
      IF lo_channel.isEof() THEN
        EXIT WHILE
      END IF

      #有錯誤訊息
      LET ls_err_message = ls_message.toUpperCase()
      IF ls_err_message.getIndexOf("ERROR" ,1) OR ls_err_message.getIndexOf("FAILED" ,1) THEN
        LET lb_success = FALSE
      END IF
    END WHILE
  END IF
  CALL lo_channel.close()

  IF lb_check_fault THEN
    LET lb_return = lb_success
  END IF  

  RETURN lb_return, ls_all_message
  
END FUNCTION
