&include "../4gl/sadzi140_mcr.inc"

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp240_type.inc"

#執行的環境變數
DEFINE 
  mb_fault           BOOLEAN,
  ms_arg_GUID        STRING,
  ms_patch_path_name STRING,
  mb_setup           BOOLEAN,
  mb_GUID            BOOLEAN
            
MAIN
     
  CALL adzp240_initialize()
  CALL adzp240_start()
  CALL adzp240_finalize()
    
END MAIN

FUNCTION adzp240_initialize()
DEFINE
  li_args        INTEGER,
  li_loop        INTEGER,
  ls_args        STRING,   
  ls_patch_name  STRING,
  ls_patch_ext   STRING,
  lb_corr_patch  BOOLEAN

  LET mb_setup = FALSE
  LET mb_GUID  = FALSE 
  
  &ifndef DEBUG
    CALL cl_tool_init()
    CALL cl_db_connect("ds", TRUE)
    LET ms_patch_path_name = ARG_VAL(2) 
  &else
    CONNECT TO "local"
    LET ms_patch_path_name = ARG_VAL(1) --"C:\\temp\\xyz.tgz" 
  &endif

  #設定參數
  LET li_args = NUM_ARGS()

  #先作參數的檢核
  FOR li_loop = 1 TO li_args
    LET ls_args = UPSHIFT(ARG_VAL(li_loop))
    CASE 
      WHEN ls_args = "-SETUP"  
        LET mb_setup = TRUE 
        EXIT FOR
      WHEN ls_args = "-ID"
        LET ms_arg_GUID = ARG_VAL(li_loop + 1)
        LET ms_arg_GUID = ms_arg_GUID.trim()
        LET mb_GUID = TRUE
        EXIT FOR
    END CASE
  END FOR 

  #不是設定 GUID 也不是設定要執行 SETUP 才執行檔名驗證
  IF (NOT mb_GUID) AND (NOT mb_setup) THEN 
    IF (ms_patch_path_name.trim() IS NULL) THEN
      LET mb_fault = TRUE
      CALL adzp240_show_help()
      CALL adzp240_finalize()
    ELSE  
      LET ls_patch_name = os.Path.basename(ms_patch_path_name)
      LET ls_patch_ext  = os.Path.extension(ls_patch_name)
      LET ls_patch_name = ls_patch_name.subString(1,ls_patch_name.getIndexOf(ls_patch_ext,1)-3)

      #檢核Patch包的前後序號連貫性是否一致    
      TRY 
        CALL sadzp240_util_chk_routine_num(ls_patch_name,FALSE) RETURNING lb_corr_patch
      CATCH
        LET lb_corr_patch = TRUE
      END TRY
      
      IF NOT lb_corr_patch THEN 
        LET mb_fault = TRUE
        CALL adzp240_finalize()
      END IF
      
    END IF
  END IF  

END FUNCTION

FUNCTION adzp240_start()
DEFINE
  lb_result       BOOLEAN,
  ls_message      STRING,
  ls_guid         STRING, 
  ls_time_start   STRING,
  ls_time_end     STRING

  IF mb_setup THEN
    DISPLAY cs_information_tag,"Start table patch manager SETUP ..."
    CALL sadzp240_arg_run() 
    DISPLAY cs_information_tag,"Finished."
  ELSE 

    IF mb_GUID THEN
      #設定運作主程式的GUID
      CALL sadzp240_set_module_guid(ms_arg_GUID)
    END IF
    
    CALL sadzp240_run(ms_patch_path_name) RETURNING lb_result,ls_message
    LET ls_guid = ls_message.subString(1,ls_message.getIndexOf('\n',1)-1)
    IF lb_result THEN
      DISPLAY cs_success_tag,"Execute patch success !! "
    ELSE
      DISPLAY cs_error_tag,"Execute patch error !! "
    END IF
    
    LET ls_time_start = sadzp240_util_get_min_start_datetime(ls_guid)
    LET ls_time_end   = sadzp240_util_get_max_finish_datetime(ls_guid)

    #DISPLAY cs_information_tag,"Execution GUID : ",NVL(ls_guid,NVL(ms_arg_GUID,"N/A"))
    DISPLAY cs_information_tag,"Start Time : ",ls_time_start
    DISPLAY cs_information_tag," End  Time : ",ls_time_end
    
  END IF   
  
END FUNCTION

FUNCTION adzp240_finalize()

  IF mb_fault THEN
    EXIT PROGRAM -1 
  ELSE
    EXIT PROGRAM 
  END IF
  
END FUNCTION

FUNCTION adzp240_show_help()

  DISPLAY "\n",
          "Usage : ","\n",
          "  Run table patch package :","\n", 
          "    r.r ",ui.Interface.getName()," [PatchFullPathName]","\n",
          "  Continue last job by GUID :","\n", 
          "    r.r ",ui.Interface.getName()," -ID [GUID]","\n",
          "  Setup running parameters :","\n", 
          "    r.r ",ui.Interface.getName()," -SETUP","\n",
          "\n",
          "Ex. ","\n",
          "  r.r ",ui.Interface.getName()," '/u3/usr/john/A000000999T.tgz' ","\n",
          "  r.r ",ui.Interface.getName()," -ID 'A115B8A6-A960-4293-84AF-89D4062A2DA9' ","\n"

END FUNCTION 
