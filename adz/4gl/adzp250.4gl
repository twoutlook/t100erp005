&include "../4gl/sadzp250_mcr.inc"
IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp250_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp250_type.inc"

#執行的環境變數
DEFINE 
  mb_fault BOOLEAN,
  ms_lang  STRING,
  mo_arguments T_ARGUMENTS
            
MAIN
     
  CALL adzp250_initialize()
  CALL adzp250_start()
  CALL adzp250_finalize()
    
END MAIN

FUNCTION adzp250_initialize()
DEFINE
  li_args        INTEGER,
  li_loop        INTEGER,
  ls_args        STRING,
  lb_result      BOOLEAN,  
  li_total_args  INTEGER,
  lb_args_exists BOOLEAN

  &ifndef DEBUG
    CALL cl_tool_init()
    CALL cl_db_connect("ds", TRUE)
    LET ms_lang = g_lang
  &else
    CONNECT TO "local"
    --LET ms_mode = "DEBUG"
    LET ms_lang = cs_default_language
  &endif

  LET lb_args_exists = TRUE

  #設定參數
  LET li_args = NUM_ARGS()

  #先作參數的檢核
  LET li_total_args = 0
  FOR li_loop = 1 TO li_args
    LET ls_args = UPSHIFT(ARG_VAL(li_loop))
    IF ls_args LIKE "-%" THEN
      LET li_total_args = li_total_args + 1
    END IF
  END FOR 
  IF li_total_args = 0 THEN 
    LET lb_args_exists = FALSE 
  END IF

  #參數有存在或正確的時候, 才會進行實際參數的指定
  IF lb_args_exists THEN
    FOR li_loop = 1 TO li_args
      LET ls_args = UPSHIFT(ARG_VAL(li_loop))

      #驗證參數
      CALL adzp250_check_arguments(ls_args,ARG_VAL(li_loop + 1)) RETURNING lb_result
      IF NOT lb_result THEN LET mb_fault = TRUE EXIT FOR END IF
      
      CASE 
        WHEN ls_args = cs_args_GUID  
          LET mo_arguments.a_GUID = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_MODE  
          LET mo_arguments.a_mode = ARG_VAL(li_loop + 1)
      END CASE 
      
    END FOR
  END IF  

  {
  IF (ms_guid.trim() IS NULL)THEN
    LET mb_fault = TRUE
    CALL adzp250_show_help()
    CALL adzp250_finalize()
  END IF 
  }
  
END FUNCTION

FUNCTION adzp250_start()
DEFINE
  lb_result       BOOLEAN,
  ls_guid         STRING 

  #Call Main Process  
  CALL sadzp250_run(mo_arguments.a_mode,mo_arguments.a_GUID,ms_lang) 
  
END FUNCTION

FUNCTION adzp250_finalize()

  IF mb_fault THEN
    EXIT PROGRAM -1 
  ELSE
    EXIT PROGRAM 
  END IF
  
END FUNCTION

FUNCTION adzp250_show_help()

  DISPLAY "\n",
          "Usage : ","\n",
          "  r.r ",ui.Interface.getName(),"\n",
          "  r.r ",ui.Interface.getName(),"-ID [Patch GUID] -MODE [DEBUG]","\n",
          "\n",
          "Ex. ","\n",
          "  r.r ",ui.Interface.getName(),"-ID '86A57EFE-8275-4E89-995D-6F09566C8034' -MODE DEBUG","\n"

END FUNCTION 

FUNCTION adzp250_check_arguments(p_argument_type,p_value)
DEFINE
  p_argument_type STRING,
  p_value         STRING
DEFINE
  ls_argument_type STRING,
  ls_value         STRING
DEFINE
  lb_return BOOLEAN

  LET ls_argument_type = p_argument_type
  LET ls_value = p_value

  LET lb_return = TRUE

  CASE 
    WHEN ls_argument_type = cs_args_GUID
      IF NVL(ls_value.trim(),cs_null_value) = cs_null_value THEN
        LET lb_return = FALSE
        DISPLAY cs_error_tag,"Please assign the GUID that you want monitored."
      END IF 
    WHEN ls_argument_type = cs_args_mode
      IF NVL(ls_value.trim(),cs_null_value) = cs_null_value THEN
        LET lb_return = FALSE
        DISPLAY cs_error_tag,"Please assign the correct mode."
      END IF
  END CASE 

  RETURN lb_return

END FUNCTION