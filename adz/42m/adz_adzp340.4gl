&include "../4gl/sadzp340_mcr.inc"

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp340_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp340_type.inc"

#執行的環境變數
DEFINE 
  ms_lang         STRING,
  mb_fault        BOOLEAN,
  mo_arguments    T_ARGUMENTS
  
MAIN
     
  CALL adzp340_initialize()
  CALL adzp340_start()
  CALL adzp340_finalize()
    
END MAIN

FUNCTION adzp340_initialize()

  &ifndef DEBUG
    #依模組進行系統初始化設定(系統設定)
    CALL cl_tool_init()
    CALL cl_db_connect("ds", TRUE)
    #CONNECT TO "ds"
    LET ms_lang = NVL(g_lang,cs_default_lang)
  &else
    CONNECT TO "local"
    LET ms_lang = cs_default_lang
  &endif
  
END FUNCTION

FUNCTION adzp340_start()
DEFINE
  lb_backend_mode BOOLEAN,
  lb_result       BOOLEAN

  LET lb_backend_mode = TRUE
  
  DISPLAY cs_information_tag,"Monitor adz/azz table patch starting ..." 
  CALL sadzp340_run(lb_backend_mode,mo_arguments.*) RETURNING lb_result
  DISPLAY cs_information_tag,"Monitor adz/azz table patch finished." 
  
END FUNCTION

FUNCTION adzp340_finalize()

  IF mb_fault THEN
    EXIT PROGRAM -1 
  ELSE
    EXIT PROGRAM 
  END IF
  
END FUNCTION

FUNCTION adzp340_help()
END FUNCTION 
