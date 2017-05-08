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
  mo_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO,
  mo_EXP_LIST  DYNAMIC ARRAY OF T_EXP_HEADER,
  mb_result    BOOLEAN

FUNCTION sadzp310_pk_run(p_EXP_LIST)
DEFINE
  p_EXP_LIST  DYNAMIC ARRAY OF T_EXP_HEADER
DEFINE  
  lo_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO,
  lb_result BOOLEAN

  CALL sadzp310_pk_initialize(p_EXP_LIST)
  CALL sadzp310_pk_start() RETURNING lb_result,lo_COMPRESS_FILE_INFO.*
  CALL sadzp310_pk_finalize()

  LET mo_COMPRESS_FILE_INFO.* = lo_COMPRESS_FILE_INFO.*
  LET mb_result = lb_result
  
  RETURN mb_result,mo_COMPRESS_FILE_INFO.*
    
END FUNCTION

FUNCTION sadzp310_pk_initialize(p_EXP_LIST)
DEFINE
  p_EXP_LIST  DYNAMIC ARRAY OF T_EXP_HEADER

  LET mo_EXP_LIST = p_EXP_LIST
  
END FUNCTION

FUNCTION sadzp310_pk_start()
DEFINE
  ls_os_separator        STRING,
  ls_curr_working_dir    STRING,
  lb_chdir               BOOLEAN,
  lb_result              BOOLEAN,
  ls_work_path           STRING,
  lo_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO
DEFINE
  lb_return   BOOLEAN,
  lo_return   T_COMPRESS_FILE_INFO
  
  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  #取得目前工作目錄
  CALL os.Path.pwd() RETURNING ls_curr_working_dir

  #建立及切換工作目錄(用清單的第一個項目建立工作目錄)
  CALL sadzp310_util_making_work_directory(
       mo_EXP_LIST[1].eh_OBJECT_TYPE
      ,cs_working_dir_type_compress
      ,mo_EXP_LIST[1].eh_OBJECT_NAME) RETURNING lb_result,ls_work_path
  #產生驗證清單檔案
  CALL sadzp310_pk_generate_verify_file(mo_EXP_LIST,ls_work_path) RETURNING lb_result,lo_COMPRESS_FILE_INFO.*
  LET mo_COMPRESS_FILE_INFO.* = lo_COMPRESS_FILE_INFO.*

  #壓縮
  CALL sadzp310_pk_collect_and_compress(mo_EXP_LIST,lo_COMPRESS_FILE_INFO.*) RETURNING lb_result
  
  #切回原目錄
  CALL os.Path.chdir(ls_curr_working_dir) RETURNING lb_chdir   

  LET lb_return = lb_result
  LET lo_return.* = lo_COMPRESS_FILE_INFO.*
  
  RETURN lb_return, lo_return.*

END FUNCTION

FUNCTION sadzp310_pk_finalize()
END FUNCTION

FUNCTION sadzp310_pk_generate_verify_file(p_EXP_LIST,p_work_path)
DEFINE
  p_EXP_LIST   DYNAMIC ARRAY OF T_EXP_HEADER,
  p_work_path  STRING
DEFINE
  lo_EXP_LIST           DYNAMIC ARRAY OF T_EXP_HEADER,
  ls_work_path          STRING,
  li_loop               INTEGER,
  ls_full_name          STRING,
  lo_json_obj           util.JSONArray,
  ls_json_string        STRING,
  ls_os_separator       STRING,
  lo_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO,
  lb_result             BOOLEAN
DEFINE
  lo_return  T_COMPRESS_FILE_INFO,
  lb_return  BOOLEAN

  LET lo_EXP_LIST = p_EXP_LIST
  LET ls_work_path = p_work_path

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  #JSON 
  LET lo_json_obj = util.JSONArray.create()

  CALL sadzp310_pk_get_compress_header(ls_work_path,lo_EXP_LIST) RETURNING lo_COMPRESS_FILE_INFO.*
  
  #第一項先放 Compress Header
  CALL lo_json_obj.put(1,lo_COMPRESS_FILE_INFO)

  #再來把匯出檔的Header放上去
  FOR li_loop = 1 TO lo_EXP_LIST.getLength()
    LET ls_full_name = ls_work_path,ls_os_separator,lo_EXP_LIST[li_loop].eh_EXP_NAME
    CALL os.Path.copy(lo_EXP_LIST[li_loop].eh_EXP_FULL_NAME,ls_full_name) RETURNING lb_result
    #放所有匯出檔的 Header
    CALL lo_json_obj.put(li_loop + 1,lo_EXP_LIST[li_loop])
  END FOR

  #排版一下JSON格式文件
  LET ls_json_string = util.JSON.format(lo_json_obj.toString())
  #寫檔  
  CALL sadzp310_util_write_file(lo_COMPRESS_FILE_INFO.cfi_NOTICE_FULL_NAME,ls_json_string) RETURNING lb_result

  LET lo_return.* = lo_COMPRESS_FILE_INFO.*
  LET lb_return = lb_result

  RETURN lb_return,lo_return.*
  
END FUNCTION

FUNCTION sadzp310_pk_get_compress_header(p_working_path,p_EXP_LIST)
DEFINE
  p_working_path  STRING,
  p_EXP_LIST      DYNAMIC ARRAY OF T_EXP_HEADER
DEFINE
  ls_working_path        STRING,
  lo_EXP_LIST            DYNAMIC ARRAY OF T_EXP_HEADER,
  ls_os_separator        STRING,
  lo_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO
DEFINE
  lo_return  T_COMPRESS_FILE_INFO

  LET ls_working_path = p_working_path
  LET lo_EXP_LIST     = p_EXP_LIST

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator

  #ALM Information
  LET lo_COMPRESS_FILE_INFO.cfi_ALM_NO     = cs_design_request_no
  LET lo_COMPRESS_FILE_INFO.cfi_ALM_SEQ    = cs_design_request_seq
  LET lo_COMPRESS_FILE_INFO.cfi_ALTER_SEQ  = cs_design_sequence_no

  #Compress Information
  LET lo_COMPRESS_FILE_INFO.cfi_NAME        = lo_EXP_LIST[1].eh_OBJECT_NAME,"_",lo_EXP_LIST[1].eh_OBJECT_TYPE,"_",lo_COMPRESS_FILE_INFO.cfi_ALM_NO,"_",lo_COMPRESS_FILE_INFO.cfi_ALTER_SEQ,".",cs_export_compress_ext       
  LET lo_COMPRESS_FILE_INFO.cfi_PATH        = ls_working_path 
  LET lo_COMPRESS_FILE_INFO.cfi_FULL_NAME   = lo_COMPRESS_FILE_INFO.cfi_PATH,ls_os_separator,lo_COMPRESS_FILE_INFO.cfi_NAME
  LET lo_COMPRESS_FILE_INFO.cfi_OBJECTS     = lo_EXP_LIST.getLength()
  LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE = lo_EXP_LIST[1].eh_OBJECT_TYPE
  LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME = lo_EXP_LIST[1].eh_OBJECT_NAME

  #Notice File Information
  LET lo_COMPRESS_FILE_INFO.cfi_NOTICE_NAME      = cs_verify_file_export_notice,".",cs_export_verify_ext       
  LET lo_COMPRESS_FILE_INFO.cfi_NOTICE_PATH      = ls_working_path 
  LET lo_COMPRESS_FILE_INFO.cfi_NOTICE_FULL_NAME = lo_COMPRESS_FILE_INFO.cfi_NOTICE_PATH,ls_os_separator,lo_COMPRESS_FILE_INFO.cfi_NOTICE_NAME

  #OS Environment
  LET lo_COMPRESS_FILE_INFO.cfi_OWNER    = FGL_GETENV("USER") 
  LET lo_COMPRESS_FILE_INFO.cfi_DATETIME = CURRENT YEAR TO SECOND 
  LET lo_COMPRESS_FILE_INFO.cfi_DGENV    = FGL_GETENV("DGENV") 
  LET lo_COMPRESS_FILE_INFO.cfi_CUST     = FGL_GETENV("CUST")

  LET lo_return.* = lo_COMPRESS_FILE_INFO.*

  RETURN lo_return.*  

END FUNCTION

FUNCTION sadzp310_pk_collect_and_compress(p_EXP_LIST,p_COMPRESS_FILE_INFO)
DEFINE
  p_EXP_LIST  DYNAMIC ARRAY OF T_EXP_HEADER,
  p_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO
DEFINE
  lo_EXP_LIST            DYNAMIC ARRAY OF T_EXP_HEADER,
  lo_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO,
  ls_compress_file_list  STRING,
  li_loop                INTEGER,
  lb_result              BOOLEAN 
DEFINE
  lb_return BOOLEAN 
  
  LET lo_EXP_LIST = p_EXP_LIST
  LET lo_COMPRESS_FILE_INFO.* = p_COMPRESS_FILE_INFO.*
  
  LET ls_compress_file_list = ""

  #先將Verify檔案串進清單中  
  LET ls_compress_file_list = ls_compress_file_list,lo_COMPRESS_FILE_INFO.cfi_NOTICE_NAME," "
  #再將其他檔案串進清單中  
  FOR li_loop = 1 TO lo_EXP_LIST.getLength()
    LET ls_compress_file_list = ls_compress_file_list,lo_EXP_LIST[li_loop].eh_EXP_NAME," "
  END FOR

  #去頭尾空格
  LET ls_compress_file_list = ls_compress_file_list.trim()

  #建立壓縮檔
  CALL sadzp310_pk_compress_files(lo_COMPRESS_FILE_INFO.cfi_NAME,ls_compress_file_list) RETURNING lb_result
  IF NOT lb_result THEN 
    DISPLAY cs_error_tag,"Create compress file "||lo_COMPRESS_FILE_INFO.cfi_NAME||" fault."
  ELSE 
    DISPLAY cs_success_tag,"Create compress file "||lo_COMPRESS_FILE_INFO.cfi_NAME||" success."  
  END IF

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzp310_pk_compress_files(p_compress_name,p_compress_file_list)
DEFINE
  p_compress_name      STRING,
  p_compress_file_list STRING
DEFINE
  ls_compress_name      STRING,
  ls_compress_file_list STRING,
  ls_TARString          STRING
DEFINE
  lb_return  BOOLEAN

  LET ls_compress_name      = p_compress_name.trim()
  LET ls_compress_file_list = p_compress_file_list.trim()
  
  LET lb_return = TRUE

  LET ls_TARString = "tar zcvf ",ls_compress_name," ",ls_compress_file_list
  
  DISPLAY cs_command_tag,ls_TARString
  
  RUN ls_TARString   

  RETURN lb_return

END FUNCTION 
