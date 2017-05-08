&include "../4gl/sadzi200_mcr.inc" 

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi200_type.inc"

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi200_cnst.inc"

DEFINE mb_result BOOLEAN
             
#觀看 Log
FUNCTION sadzi200_log_view_logresult(p_message)
DEFINE
  p_message     STRING
DEFINE  
  txt_LogResult STRING

  LET txt_LogResult = p_message
  
  CALL sadzi200_log_open_logresult_form()

  DISPLAY BY NAME txt_LogResult
  MENU
    ON ACTION btn_ok
      EXIT MENU  

    ON ACTION CLOSE
      EXIT MENU
  END MENU

  CALL sadzi200_log_close_logresult_form()
  
END FUNCTION

#開啟看 Log 的Form
FUNCTION sadzi200_log_open_logresult_form()

  &ifndef DEBUG
    OPEN WINDOW w_sadzi200_log WITH FORM cl_ap_formpath("ADZ","sadzi200_log")
  &else
    OPEN WINDOW w_sadzi200_log WITH FORM sadzi200_util_get_form_path("sadzi200_log")
  &endif
  
  CURRENT WINDOW IS w_sadzi200_log
  
END FUNCTION

#關閉看 Log 的Form
FUNCTION sadzi200_log_close_logresult_form()

  CLOSE WINDOW w_sadzi200_log
  
END FUNCTION
