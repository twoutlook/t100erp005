&include "../4gl/sadzp250_mcr.inc" 

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzp250_cnst.inc"
&include "../4gl/sadzp250_type.inc"

DEFINE mb_result BOOLEAN
DEFINE ms_lang   STRING
             
#觀看 Log
FUNCTION sadzp250_log_view_logresult(p_message,p_lang)
DEFINE
  p_message  STRING,
  p_lang     STRING
DEFINE  
  txt_LogResult STRING

  LET txt_LogResult = p_message
  LET ms_lang = p_lang
  
  CALL sadzp250_log_open_logresult_form()

  DISPLAY BY NAME txt_LogResult
  MENU
    ON ACTION btn_ok
      EXIT MENU  

    ON ACTION CLOSE
      EXIT MENU
  END MENU

  CALL sadzp250_log_close_logresult_form()
  
END FUNCTION

#開啟看 Log 的Form
FUNCTION sadzp250_log_open_logresult_form()
DEFINE
  ls_cfg_path   STRING,
  ls_4st_path   STRING

  &ifndef DEBUG
    OPEN WINDOW w_sadzp250_log WITH FORM cl_ap_formpath("ADZ","sadzp250_log")
    CALL cl_load_4ad_interface(NULL)
  &else
    OPEN WINDOW w_sadzp250_log WITH FORM sadzp250_util_get_form_path("sadzp250_log")
  &endif
  LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
  LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), ms_lang), "designer.4st")
  CALL ui.Interface.loadStyles(ls_4st_path)    
  
  CURRENT WINDOW IS w_sadzp250_log
  
END FUNCTION

#關閉看 Log 的Form
FUNCTION sadzp250_log_close_logresult_form()

  CLOSE WINDOW w_sadzp250_log
  
END FUNCTION

