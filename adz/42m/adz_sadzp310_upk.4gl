&include "../4gl/sadzp310_mcr.inc"

IMPORT util 
IMPORT os 
IMPORT security
IMPORT xml

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp310_type.inc"

DEFINE
  mo_arguments    T_ARGUMENTS,
  mb_result       BOOLEAN,
  ms_result       STRING,
  mo_EXP_LIST     DYNAMIC ARRAY OF T_EXP_HEADER,
  mo_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO

FUNCTION sadzp310_upk_run(p_arguments)
DEFINE
  p_arguments T_ARGUMENTS
  
  CALL sadzp310_upk_initialize(p_arguments.*)
  CALL sadzp310_upk_start()
  CALL sadzp310_upk_finalize()

  RETURN mo_COMPRESS_FILE_INFO.*,mo_EXP_LIST

END FUNCTION 

FUNCTION sadzp310_upk_initialize(p_arguments)
DEFINE
  p_arguments  T_ARGUMENTS
  
  LET mo_arguments.* = p_arguments.*
  
END FUNCTION 

FUNCTION sadzp310_upk_start()
DEFINE
  ls_curr_working_dir STRING,
  lb_result       BOOLEAN,
  lb_chdir        BOOLEAN,
  ls_work_path    STRING,
  ls_notice_file  STRING,
  ls_os_separator STRING,
  lo_EXP_LIST           DYNAMIC ARRAY OF T_EXP_HEADER,
  lo_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO
  

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  #取得目前工作目錄
  CALL os.Path.pwd() RETURNING ls_curr_working_dir

  #取得及切換工作目錄
  CALL sadzp310_util_making_work_directory(NVL(mo_arguments.a_OBJECT_TYPE,cs_working_unknow_object),cs_working_dir_type_uncompress,NVL(mo_arguments.a_WORKING_OBJECT,cs_working_unknow_object)) RETURNING lb_result,ls_work_path
  LET mo_arguments.a_WORKING_FILE = os.Path.basename(mo_arguments.a_SOURCE_FULL_NAME)
  LET mo_arguments.a_WORKING_PATH = ls_work_path
  LET mo_arguments.a_WORKING_FULL_NAME = ls_work_path,ls_os_separator,mo_arguments.a_WORKING_FILE

  #切換目錄成功了, 才開始作業
  IF lb_result THEN
    CALL os.Path.copy(mo_arguments.a_SOURCE_FULL_NAME,mo_arguments.a_WORKING_FULL_NAME) RETURNING lb_result
    CALL sadzp310_upk_uncompress_files(mo_arguments.a_WORKING_FILE) RETURNING lb_result
    LET ls_notice_file = cs_verify_file_export_notice||"."||cs_export_verify_ext
    CALL sadzp310_upk_parse_export_notice(ls_notice_file) RETURNING lo_COMPRESS_FILE_INFO.*,lo_EXP_LIST
    CALL sadzp310_util_reset_working_path(lo_COMPRESS_FILE_INFO.*,lo_EXP_LIST,ls_work_path) RETURNING lo_COMPRESS_FILE_INFO.*,lo_EXP_LIST
  END IF  

  LET mo_COMPRESS_FILE_INFO.* = lo_COMPRESS_FILE_INFO.*
  LET mo_EXP_LIST = lo_EXP_LIST

  #切回原目錄
  CALL os.Path.chdir(ls_curr_working_dir) RETURNING lb_chdir    

  #設定回傳值
  LET mb_result = lb_result
  
END FUNCTION 

FUNCTION sadzp310_upk_finalize()
END FUNCTION 

FUNCTION sadzp310_upk_uncompress_files(p_compress_name)
DEFINE
  p_compress_name STRING
DEFINE
  ls_compress_name STRING,
  ls_TARString     STRING
DEFINE
  lb_return  BOOLEAN

  LET ls_compress_name = p_compress_name.trim()
  
  LET lb_return = TRUE

  LET ls_TARString = "tar zxvf ",ls_compress_name
  
  DISPLAY cs_command_tag,ls_TARString
  
  RUN ls_TARString   

  RETURN lb_return

END FUNCTION 

FUNCTION sadzp310_upk_parse_export_notice(p_file_name)
DEFINE
  p_file_name  STRING
DEFINE
  ls_file_name STRING,
  ls_result    STRING,
  lb_result    BOOLEAN,
  li_loop      INTEGER,
  lo_json_arr  util.JSONArray,
  lo_json_obj  util.JSONObject,
  lo_EXP_LIST  DYNAMIC ARRAY OF T_EXP_HEADER,
  lo_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO

  LET ls_file_name = p_file_name

  LET lo_json_arr = util.JSONArray.create()
  LET lo_json_obj = util.JSONObject.create()

  CALL sadzp310_util_read_file_contents(ls_file_name) RETURNING lb_result,ls_result
  
  LET lo_json_arr = util.JSONArray.parse(ls_result)

  #開始拆解Export Notice的內容
  FOR li_loop = 1 TO lo_json_arr.getLength()
    IF li_loop = 1 THEN
      #第一筆是Compress Header information
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_COMPRESS_FILE_INFO)
    ELSE
      #其他是被壓縮物件的 Header
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_EXP_LIST[li_loop - 1])
    END IF
  END FOR

  RETURN lo_COMPRESS_FILE_INFO.*,lo_EXP_LIST
  
END FUNCTION



