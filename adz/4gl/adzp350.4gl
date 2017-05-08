&include "../4gl/sadzp350_mcr.inc"

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp350_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp350_type.inc"

#執行的環境變數
DEFINE 
  ms_dlang        STRING,
  mb_fault        BOOLEAN,
  mo_ARGUMENTS    T_ADZP350_ARGUMENTS, 
  mb_args_exists  BOOLEAN
            
MAIN

  CALL adzp350_initialize()
  CALL adzp350_start()
  CALL adzp350_finalize()
    
END MAIN

FUNCTION adzp350_initialize()
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
    #CALL cl_ap_init("adz","N")
    CALL cl_tool_init()
    CALL cl_db_connect("ds", TRUE)
    #CONNECT TO "ds"
    LET ms_dlang = NVL(g_dlang,cs_default_lang)
  &else
    CONNECT TO "local"
    LET ms_dlang = cs_default_lang
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
      CALL adzp350_check_arguments(ls_args,ARG_VAL(li_loop + 1)) RETURNING lb_result
      IF NOT lb_result THEN LET mb_fault = TRUE EXIT FOR END IF
      
      CASE 
        #Source 
        WHEN ls_args = cs_args_source_working_type 
          LET mo_ARGUMENTS.a_source_working_type = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_source_design_name 
          LET mo_ARGUMENTS.a_source_design_name = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_source_schema_name 
          LET mo_ARGUMENTS.a_source_schema_name = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_source_table_name  
          LET mo_ARGUMENTS.a_source_table_name = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_source_file_name   
          LET mo_ARGUMENTS.a_source_file_name = ARG_VAL(li_loop + 1)
          
        #Destination
        WHEN ls_args = cs_args_dest_working_type 
          LET mo_ARGUMENTS.a_dest_working_type = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_dest_design_name  
          LET mo_ARGUMENTS.a_dest_design_name = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_dest_schema_name  
          LET mo_ARGUMENTS.a_dest_schema_name = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_dest_table_name   
          LET mo_ARGUMENTS.a_dest_table_name = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_dest_file_name    
          LET mo_ARGUMENTS.a_dest_file_name = ARG_VAL(li_loop + 1)
          
        #Options 
        WHEN ls_args = cs_args_export_file_type 
          LET mo_ARGUMENTS.a_exp_document_type = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_send_to_client 
          LET mo_ARGUMENTS.a_send_to_client = TRUE
        WHEN ls_args = cs_args_GUI_mode 
          LET mo_ARGUMENTS.a_GUI_mode = TRUE
        WHEN ls_args = cs_args_shipping_diff 
          LET mo_ARGUMENTS.a_shipping_diff = TRUE
          
      END CASE 
      
    END FOR
  END IF

  LET mb_args_exists = lb_args_exists
  
  #驗證參數失敗, 直接結束
  IF mb_fault THEN CALL adzp350_finalize() END IF
  
END FUNCTION

FUNCTION adzp350_start()
DEFINE
  ls_separator  STRING,
  lb_result     BOOLEAN

  LET ls_separator = os.Path.separator()

  #debug begin
  {
  LET mo_ARGUMENTS.a_source_design_name = 'imxf_t'
  LET mo_ARGUMENTS.a_dest_schema_name   = 'DS' 
  LET mo_ARGUMENTS.a_dest_table_name    = 'imxf_t'
  LET mo_ARGUMENTS.a_exp_document_type  = "csv"
  }
  #debug end

  LET mo_arguments.a_send_to_client = TRUE
  LET mo_arguments.a_shipping_diff  = TRUE
  LET mb_args_exists = TRUE
  
  #開始執行
  IF mb_args_exists THEN
    IF mo_arguments.a_shipping_diff THEN 
      CALL sadzp350_sdiff_run(ms_dlang,mo_ARGUMENTS.*)
    ELSE
      #CALL sadzp350_run(TRUE,mo_ARGUMENTS.*) RETURNING lb_result
    END IF
  ELSE
    CALL adzp350_help()
  END IF  
  
END FUNCTION

FUNCTION adzp350_finalize()

  IF mb_fault THEN
    EXIT PROGRAM -1 
  ELSE
    EXIT PROGRAM 
  END IF
  
END FUNCTION

FUNCTION adzp350_help()

  DISPLAY "\n",
          "Usage :","\n",
          "  r.r adzp350 [Options] [Arguments]","\n","\n",
          "  Options :","\n",  
          "    -STC  : Sending exported file to client. ","\n",
          "    -GUI  : GUI Mode ","\n",
          "    -SHIP : Make a diff work for product dhipping. ","\n"
          {
          "  Arguments :","\n",  
          "    -WT : Working Type ","\n",
          "      iexp : Export table datas.","\n",
          "      iimp : Import table datas.","\n",  
          "      iasm : Create/Alter table with design data.","\n",  
          "    -SFN : Source package name with full path.","\n",
          "    -EFL : Export file location.","\n","\n",  
          "  Example :","\n",
          "      Export table :","\n",
          "        r.r adzp350 -WT iexp 'itmm_t' 'T' '1' '000000-00000' '1' -EFL '/u3/usr/testuser/adzp350'","\n",
          "      Import table :","\n",
          "        r.r adzp350 -WT iimp 'itmm_t' 'T' '1' '000000-00000' '1' -SFN '/u3/usr/testuser/adzp350/itmm_t+TABLE+999999-99999+00000.tdi'","\n",
          "      Create/Alter table :","\n",
          "        r.r adzp350 -WT iasm 'itmm_t'","\n"
          }
          
END FUNCTION 

FUNCTION adzp350_check_arguments(p_argument_type,p_value)
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
    WHEN ls_argument_type = cs_args_source_working_type 
      IF ls_value.toUpperCase() <> cs_working_type_db AND
         ls_value.toUpperCase() <> cs_working_type_design AND
         ls_value.toUpperCase() <> cs_working_type_file THEN
        DISPLAY cs_error_tag,ls_argument_type," : No such working type : ",ls_value
        LET lb_return = FALSE
      END IF
    WHEN ls_argument_type = cs_args_source_design_name 
    WHEN ls_argument_type = cs_args_source_schema_name 
    WHEN ls_argument_type = cs_args_source_table_name  
    WHEN ls_argument_type = cs_args_source_file_name   
      IF NOT os.Path.exists(ls_value) THEN
        DISPLAY cs_error_tag,ls_argument_type," : The file '",ls_value,"' not exists."
        LET lb_return = FALSE
      END IF
    WHEN ls_argument_type = cs_args_dest_working_type 
      IF ls_value.toUpperCase() <> cs_working_type_db AND
         ls_value.toUpperCase() <> cs_working_type_design AND
         ls_value.toUpperCase() <> cs_working_type_file THEN
        DISPLAY cs_error_tag,ls_argument_type," : No such working type : ",ls_value
        LET lb_return = FALSE
      END IF
    WHEN ls_argument_type = cs_args_dest_design_name  
    WHEN ls_argument_type = cs_args_dest_schema_name  
    WHEN ls_argument_type = cs_args_dest_table_name   
    WHEN ls_argument_type = cs_args_dest_file_name    
      IF NOT os.Path.exists(ls_value) THEN
        DISPLAY cs_error_tag,ls_argument_type," : The file '",ls_value,"' not exists."
        LET lb_return = FALSE
      END IF
  END CASE 
  
  RETURN lb_return

END FUNCTION

FUNCTION adzp350_check_specified_argument_existed(p_argument)
DEFINE
  p_argument STRING
DEFINE
  ls_argument STRING,
  li_args     INTEGER,
  li_loop     INTEGER,
  ls_args     STRING,
  lb_existed  BOOLEAN
DEFINE
  lb_return  BOOLEAN  

  LET ls_argument = p_argument.trim()

  LET lb_existed = FALSE

  #設定參數
  LET li_args = NUM_ARGS()

  #先作參數的檢核
  FOR li_loop = 1 TO li_args
    LET ls_args = UPSHIFT(ARG_VAL(li_loop))
    IF ls_args = ls_argument THEN
      LET lb_existed = TRUE
      EXIT FOR
    END IF
  END FOR 

  LET lb_return = lb_existed

  RETURN lb_return
  
END FUNCTION