&include "../4gl/sadzi180_mcr.inc" 

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi180_cnst.inc"

&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi180_type.inc"

DEFINE mb_result BOOLEAN
             
#觀看 Log
FUNCTION sadzi180_log_view_logresult(p_message)
DEFINE
  p_message     STRING
DEFINE  
  txt_LogResult STRING

  LET txt_LogResult = p_message
  
  CALL sadzi180_log_open_logresult_form()

  DISPLAY BY NAME txt_LogResult
  MENU
    ON ACTION btn_ok
      EXIT MENU  

    ON ACTION CLOSE
      EXIT MENU
  END MENU

  CALL sadzi180_log_close_logresult_form()
  
END FUNCTION

#開啟看 Log 的Form
FUNCTION sadzi180_log_open_logresult_form()

  &ifndef DEBUG
    OPEN WINDOW w_sadzi180_log WITH FORM cl_ap_formpath("ADZ","sadzi180_log")
  &else
    OPEN WINDOW w_sadzi180_log WITH FORM sadzi180_util_get_form_path("sadzi180_log")
  &endif
  
  CURRENT WINDOW IS w_sadzi180_log
  
END FUNCTION

#關閉看 Log 的Form
FUNCTION sadzi180_log_close_logresult_form()

  CLOSE WINDOW w_sadzi180_log
  
END FUNCTION

