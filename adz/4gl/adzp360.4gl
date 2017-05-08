&include "../4gl/sadzp360_mcr.inc"

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp360_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp360_type.inc"

#執行的環境變數
DEFINE 
  ms_lang         STRING,
  mb_fault        BOOLEAN,
  mo_arguments    T_ARGUMENTS,
  mb_args_exists  BOOLEAN
            
MAIN
DEFINE
  lb_result        BOOLEAN,
  ls_TAR_file_path STRING
     
  CALL adzp360_initialize()
  CALL adzp360_start()
  CALL adzp360_finalize()
    
END MAIN

FUNCTION adzp360_initialize()
DEFINE
  li_args        INTEGER,
  li_loop        INTEGER,
  ls_args        STRING,
  lb_result      BOOLEAN,  
  li_total_args  INTEGER,
  lb_args_exists BOOLEAN

  LET lb_args_exists = TRUE
  
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
      CALL adzp360_check_arguments(ls_args,ARG_VAL(li_loop + 1)) RETURNING lb_result
      IF NOT lb_result THEN LET mb_fault = TRUE EXIT FOR END IF
      
      CASE 
        WHEN ls_args = cs_args_table_name  
          LET mo_arguments.a_args1 = ARG_VAL(li_loop + 1)
      END CASE 
      
    END FOR
  END IF  

  #本隻程式先設定有參數存在
  LET lb_args_exists = TRUE 
  LET mb_args_exists = lb_args_exists

  {
  #for test
  ###################
  LET mb_args_exists = TRUE
  LET mo_arguments.a_TABLE_NAME = "ooefl_t"
  ###################
  }

  #驗證參數失敗, 直接結束
  IF mb_fault THEN CALL adzp360_finalize() END IF
  
END FUNCTION

FUNCTION adzp360_start()
DEFINE
  lb_backend_mode BOOLEAN,
  lb_result       BOOLEAN

  LET lb_backend_mode = TRUE
  
  IF mb_args_exists THEN 
    DISPLAY cs_information_tag,"Generate APS tables package starting ..." 
    CALL sadzp360_run(lb_backend_mode,mo_arguments.*) RETURNING lb_result
    DISPLAY cs_information_tag,"Generate APS tables package finished." 
  ELSE 
    CALL adzp360_help()
  END IF  
  
END FUNCTION

FUNCTION adzp360_finalize()

  IF mb_fault THEN
    EXIT PROGRAM -1 
  ELSE
    EXIT PROGRAM 
  END IF
  
END FUNCTION

FUNCTION adzp360_help()

  DISPLAY "\n",
          "Usage :","\n",
          "  r.r adzp360","\n"
          
END FUNCTION 

FUNCTION adzp360_check_arguments(p_argument_type,p_value)
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
    WHEN ls_argument_type = cs_args_table_name
  END CASE 

  RETURN lb_return

END FUNCTION