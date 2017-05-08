&include "../4gl/sadzi140_mcr.inc"

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzi140_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzi140_type.inc"

#執行的環境變數
DEFINE 
  ms_dlang        STRING,
  ms_MasterDB     STRING,
  ms_MasterUser   STRING,
  mb_backend_mode BOOLEAN,
  mo_PARAMETERS   T_DZLM_T_SCR,
  mo_export_info  T_EXPORT_INFO
            
FUNCTION sadzp220_run(p_backend_mode,p_PARAMETERS)
DEFINE
  p_backend_mode BOOLEAN,
  p_PARAMETERS   T_DZLM_T_SCR
  
  CALL sadzp220_initialize(p_backend_mode,p_PARAMETERS.*)
  CALL sadzp220_start()
  CALL sadzp220_finalize()

  RETURN mo_export_info.*

END FUNCTION

FUNCTION sadzp220_initialize(p_backend_mode,p_PARAMETERS)
DEFINE
  p_backend_mode BOOLEAN,
  p_PARAMETERS   T_DZLM_T_SCR

  LET mb_backend_mode = p_backend_mode
  
  LET mo_PARAMETERS.TYPES   = p_PARAMETERS.TYPES   #iexp, iimp, idel, iasm
  LET mo_PARAMETERS.DZLM002 = p_PARAMETERS.DZLM002 #TableName
  LET mo_PARAMETERS.DZLM005 = p_PARAMETERS.DZLM005 #ConstructVersion
  LET mo_PARAMETERS.DZLM006 = p_PARAMETERS.DZLM006 #SD_Version
  LET mo_PARAMETERS.DZLM012 = p_PARAMETERS.DZLM012 #需求單號
  LET mo_PARAMETERS.DZLM015 = p_PARAMETERS.DZLM015 #序號

  #取得Master DB 及 User
  CALL sadzi140_db_get_parameter(cs_param_level_system,cs_param_master_db) RETURNING ms_MasterDB
  CALL sadzi140_db_get_parameter(cs_param_level_system,cs_param_master_user) RETURNING ms_MasterUser
  
END FUNCTION

FUNCTION sadzp220_start()
DEFINE
  ls_TYPES            STRING,
  ls_TableName        STRING,
  ls_TARName          STRING,
  ls_ConstructVersion STRING,
  ls_SD_Version       STRING,
  ls_request_no       STRING,
  ls_sequence_no      STRING,
  lb_fault            BOOLEAN,
  lo_parameters       T_DZLM_T_SCR,
  lo_exec_result      T_EXEC_RESULT,
  lo_export_info      T_EXPORT_INFO
  
  LET lb_fault = FALSE
  
  LET ls_TYPES            = mo_PARAMETERS.TYPES
  LET ls_TableName        = mo_PARAMETERS.DZLM002
  LET ls_ConstructVersion = mo_PARAMETERS.DZLM005
  LET ls_SD_Version       = mo_PARAMETERS.DZLM006
  LET ls_request_no       = mo_PARAMETERS.DZLM012
  LET ls_sequence_no      = mo_PARAMETERS.DZLM015

  IF NVL(ls_TYPES.ToLowerCase(),cs_null_value) = cs_null_value THEN
    DISPLAY cs_error_tag,"No any parameters.","\n"
  ELSE 
    CALL sadzi140_exim_get_parameter(ls_TYPES.ToLowerCase(),ls_TableName,ls_ConstructVersion,ls_SD_Version,ls_request_no,ls_sequence_no) RETURNING lo_parameters.*
    CALL sadzi140_exim_run(mb_backend_mode,lo_parameters.*) RETURNING lo_export_info.*,lo_exec_result.*
  END IF 

  IF lo_export_info.WORKING_PATH IS NOT NULL THEN 
    DISPLAY cs_information_tag,"Stored Path : ",lo_export_info.WORKING_PATH
  END IF
  
  IF lo_export_info.TAR_NAME IS NOT NULL THEN 
    DISPLAY cs_information_tag,"File Name : ",lo_export_info.TAR_NAME
  END IF  

  LET mo_export_info.* = lo_export_info.*
  
END FUNCTION

FUNCTION sadzp220_finalize()
END FUNCTION

FUNCTION sadzp220_get_server_working_path(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  lb_success     BOOLEAN,
  ls_server_path STRING
DEFINE
  ls_return STRING  
  
  CALL sadzi140_exim_get_server_working_path(p_table_name) RETURNING lb_success,ls_server_path

  LET ls_return = ls_server_path
  
  RETURN ls_return

END FUNCTION 
