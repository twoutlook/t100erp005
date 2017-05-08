&include "../4gl/sadzi140_mcr.inc"

{
Sample :
  r.r adzp220 -WT iexp 'itmm_t' 'T' '1' '000000-00000' '1' -EFL 'C:\\temp\\tmp'
  r.r adzp220 -WT iimp 'itmm_t' 'T' '1' '000000-00000' '1' -SFN 'C:\\temp\\tmp\\itmm_t+TABLE+999999-99999+99999.tdi'
  r.r adzp220 -WT iasm 'itmm_t'
}

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzi140_cnst.inc"
&include "../4gl/sadzp220_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzi140_type.inc"

PUBLIC TYPE T_ADZP220_ARGUMENTS RECORD
              a_WORKING_TYPE          VARCHAR(10), -- EXP, IMP ...
              a_SOURCE_FULL_NAME      VARCHAR(1024),
              a_EXPORT_FILE_LOCATION  VARCHAR(1024),
              a_SOURCE_FILE_NAME      VARCHAR(1024),
              a_SOURCE_FILE_DIR       VARCHAR(1024),
              a_DEST_FILE_NAME        VARCHAR(1024),
              a_DEST_FILE_DIR         VARCHAR(1024),
              ao_DZLM_T_SCR           T_DZLM_T_SCR
            END RECORD

#執行的環境變數
DEFINE 
  ms_dlang                STRING,
  mb_fault                BOOLEAN,
  mo_ARGUMENTS            T_ADZP220_ARGUMENTS, 
  ms_curr_pwd             STRING,
  ms_SOURCE_FULL_NAME     STRING,
  ms_EXPORT_FILE_LOCATION STRING,
  mb_args_exists          BOOLEAN
            
MAIN
DEFINE
  lb_result        BOOLEAN,
  ls_TAR_file_path STRING
     
  CALL adzp220_initialize()
  CALL adzp220_start()
  CALL adzp220_finalize()
    
END MAIN

FUNCTION adzp220_initialize()
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
      CALL adzp220_check_arguments(ls_args,ARG_VAL(li_loop + 1)) RETURNING lb_result
      IF NOT lb_result THEN LET mb_fault = TRUE EXIT FOR END IF
      
      CASE 
        WHEN ls_args = cs_args_working_type  
          LET mo_ARGUMENTS.ao_DZLM_T_SCR.TYPES   = ARG_VAL(li_loop + 1) #iexp, iimp, idel, iasm
          LET mo_ARGUMENTS.ao_DZLM_T_SCR.DZLM002 = ARG_VAL(li_loop + 2) #TableName
          LET mo_ARGUMENTS.ao_DZLM_T_SCR.DZLM005 = ARG_VAL(li_loop + 3) #ConstructVersion
          LET mo_ARGUMENTS.ao_DZLM_T_SCR.DZLM006 = ARG_VAL(li_loop + 4) #SD_Version
          LET mo_ARGUMENTS.ao_DZLM_T_SCR.DZLM012 = ARG_VAL(li_loop + 5) #需求單號
          LET mo_ARGUMENTS.ao_DZLM_T_SCR.DZLM015 = ARG_VAL(li_loop + 6) #序號
        WHEN ls_args = cs_args_source_full_name
          LET mo_ARGUMENTS.a_SOURCE_FULL_NAME = ARG_VAL(li_loop + 1) 
          LET mo_ARGUMENTS.a_SOURCE_FILE_NAME = os.Path.basename(mo_ARGUMENTS.a_SOURCE_FULL_NAME)
          LET mo_ARGUMENTS.a_SOURCE_FILE_DIR  = os.Path.dirName(mo_ARGUMENTS.a_SOURCE_FULL_NAME)
        WHEN ls_args = cs_args_export_file_location
          LET mo_ARGUMENTS.a_EXPORT_FILE_LOCATION = ARG_VAL(li_loop + 1) 
          LET mo_ARGUMENTS.a_DEST_FILE_DIR = mo_ARGUMENTS.a_EXPORT_FILE_LOCATION
      END CASE 
      
    END FOR
  END IF

  LET mb_args_exists = lb_args_exists
  
  #驗證參數失敗, 直接結束
  IF mb_fault THEN CALL adzp220_finalize() END IF
  
END FUNCTION

FUNCTION adzp220_start()
DEFINE
  ls_TYPES            STRING,
  ls_TableName        STRING,
  ls_TARName          STRING,
  ls_ConstructVersion STRING,
  ls_SD_Version       STRING,
  ls_request_no       STRING,
  ls_sequence_no      STRING,
  ls_separator        STRING,
  ls_src_file_name    STRING,
  ls_dst_file_name    STRING,
  lb_fault            BOOLEAN,
  lb_result           BOOLEAN,
  lo_parameters       T_DZLM_T_SCR,
  lo_export_info      T_EXPORT_INFO

  LET ls_separator = os.Path.separator()

  CALL sadzp220_get_server_working_path(NVL(mo_ARGUMENTS.ao_DZLM_T_SCR.DZLM002,cs_no_define)) RETURNING ms_curr_pwd
  DISPLAY cs_information_tag,"Working path : ",ms_curr_pwd

  #有來源檔案, 將來源檔案搬移到作業暫存區中
  IF mo_ARGUMENTS.a_SOURCE_FULL_NAME IS NOT NULL THEN
    LET ls_src_file_name = mo_ARGUMENTS.a_SOURCE_FULL_NAME
    LET ls_dst_file_name = ms_curr_pwd,ls_separator,mo_ARGUMENTS.a_SOURCE_FILE_NAME
    CALL adzp220_clone_file(ls_src_file_name,ls_dst_file_name) RETURNING lb_result  
  END IF

  #開始執行
  IF mb_args_exists THEN 
    CALL sadzp220_run(TRUE,mo_ARGUMENTS.ao_DZLM_T_SCR.*) RETURNING lo_export_info.*
    DISPLAY cs_information_tag,"The operation ",mo_ARGUMENTS.ao_DZLM_T_SCR.TYPES," of table ",mo_ARGUMENTS.ao_DZLM_T_SCR.DZLM002," completed."
  ELSE
    CALL adzp220_help()
  END IF  

  #有指定目的區, 將作業檔案搬移到目的目錄中
  IF mo_ARGUMENTS.a_EXPORT_FILE_LOCATION IS NOT NULL THEN
    LET ls_src_file_name = ms_curr_pwd,ls_separator,lo_export_info.TAR_NAME
    LET ls_dst_file_name = mo_ARGUMENTS.a_DEST_FILE_DIR,ls_separator,lo_export_info.TAR_NAME
    CALL adzp220_clone_file(ls_src_file_name,ls_dst_file_name) RETURNING lb_result  
  END IF
  
END FUNCTION

FUNCTION adzp220_finalize()

  IF mb_fault THEN
    EXIT PROGRAM -1 
  ELSE
    EXIT PROGRAM 
  END IF
  
END FUNCTION

FUNCTION adzp220_help()

  DISPLAY "\n",
          "Usage :","\n",
          "  r.r adzp220 [Arguments]","\n","\n",
          "  Arguments :","\n",  
          "    -WT : Working Type ","\n",
          "      iexp : Export table datas.","\n",
          "      iimp : Import table datas.","\n",  
          "      iasm : Create/Alter table with design data.","\n",  
          "    -SFN : Source package name with full path.","\n",
          "    -EFL : Export file location.","\n","\n",  
          "  Example :","\n",
          "      Export table :","\n",
          "        r.r adzp220 -WT iexp 'itmm_t' 'T' '1' '000000-00000' '1' -EFL '/u3/usr/testuser/adzp220'","\n",
          "      Import table :","\n",
          "        r.r adzp220 -WT iimp 'itmm_t' 'T' '1' '000000-00000' '1' -SFN '/u3/usr/testuser/adzp220/itmm_t+TABLE+999999-99999+00000.tdi'","\n",
          "      Create/Alter table :","\n",
          "        r.r adzp220 -WT iasm 'itmm_t'","\n"
          
END FUNCTION 

FUNCTION adzp220_check_arguments(p_argument_type,p_value)
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
    WHEN ls_argument_type = cs_args_working_type
      CASE
        WHEN ls_value = cs_exim_export
          IF NOT adzp220_check_specified_argument_existed(cs_args_export_file_location) THEN  
            DISPLAY cs_error_tag,"Please define the export file location first (",cs_args_export_file_location,")." 
            LET lb_return = FALSE
          END IF
        WHEN ls_value = cs_exim_import
          IF NOT adzp220_check_specified_argument_existed(cs_args_source_full_name) THEN  
            DISPLAY cs_error_tag,"Please define the source file full name first (",cs_args_source_full_name,")." 
            LET lb_return = FALSE
          END IF
        WHEN ls_value = cs_exim_assemble
        WHEN ls_value = cs_exim_alter
        WHEN ls_value = cs_exim_rebuild
        OTHERWISE
          DISPLAY cs_error_tag,ls_argument_type," : The working type '",ls_value,"' not correct."
          LET lb_return = FALSE
      END CASE   
    WHEN ls_argument_type = cs_args_source_full_name
      IF NOT os.Path.exists(ls_value) THEN
        DISPLAY cs_error_tag,ls_argument_type," : The file '",ls_value,"' not exists."
        LET lb_return = FALSE
      END IF
    WHEN ls_argument_type = cs_args_export_file_location
      IF NOT os.Path.isdirectory(ls_value) THEN
        DISPLAY cs_error_tag,ls_argument_type," : The export directory '",ls_value,"' not exists."
        LET lb_return = FALSE
      END IF
  END CASE 

  RETURN lb_return

END FUNCTION

FUNCTION adzp220_clone_file(p_source,p_destination)
DEFINE
  p_source      STRING,
  p_destination STRING
DEFINE
  ls_source       STRING,
  ls_destination  STRING,
  lb_result       BOOLEAN
DEFINE
  lb_return  BOOLEAN
  
  LET ls_source = p_source
  LET ls_destination = p_destination

  TRY 
    CALL os.Path.copy(ls_source,ls_destination) RETURNING lb_result
    DISPLAY cs_success_tag,"Clone file from ",ls_source," to ",ls_destination," successed."
  CATCH
    DISPLAY cs_error_tag,"Clone file from ",ls_source," to ",ls_destination," not successed."
  END TRY 

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION 

FUNCTION adzp220_check_specified_argument_existed(p_argument)
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