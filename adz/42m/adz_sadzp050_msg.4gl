#&define DEBUG

IMPORT OS
IMPORT UTIL

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc" 
&include "../4gl/sadzp050_cnst.inc" 

&include "../4gl/sadzp000_type.inc" 
&include "../4gl/sadzp050_type.inc" 
&include "../4gl/sadzp200_type.inc" 

GLOBALS "../../cfg/top_global.inc"

FUNCTION sadzp050_msg_show_error(ps_title, ps_err_code, ps_replace_arg, pi_idle_sec)
DEFINE
  ps_title        STRING, 
  ps_err_code     STRING,
  ps_replace_arg  STRING, 
  pi_idle_sec     INTEGER
DEFINE
  ls_title        STRING, 
  ls_err_code     STRING,
  ls_replace_arg  STRING, 
  li_idle_sec     INTEGER,
  li_length       INTEGER,
  li_arg_cnts     INTEGER,
  ls_arg_char     STRING,
  ls_arg_string   STRING,
  ls_err_message  STRING  

  LET ls_title       = NVL(ps_title,ps_err_code)
  LET ls_err_code    = ps_err_code
  LET ls_replace_arg = ps_replace_arg
  LET li_idle_sec    = pi_idle_sec

  LET ls_arg_string = ""
  LET li_arg_cnts = 1
  
  INITIALIZE g_errparam TO NULL
  
  LET g_errparam.code   = ls_err_code
  LET g_errparam.extend = NULL
  LET g_errparam.popup  = TRUE

  IF ls_replace_arg IS NOT NULL THEN 
    FOR li_length = 1 TO ls_replace_arg.getLength()
      LET ls_arg_char = ls_replace_arg.subString(li_length,li_length)
      IF ls_arg_char = cs_divide THEN 
        LET g_errparam.replace[li_arg_cnts] = ls_arg_string
        LET li_arg_cnts = li_arg_cnts + 1
        LET ls_arg_string = ""
      ELSE
        LET ls_arg_string = ls_arg_string,ls_arg_char
      END IF 
    END FOR
  END IF    
  
  LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
  
  CALL cl_err()  
  
END FUNCTION