&include "../4gl/sadzp350_mcr.inc"

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp350_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp350_type.inc"

DEFINE
  ms_execute_path STRING

FUNCTION sadzp350_util_set_execute_path(p_path)
DEFINE
  p_path STRING 

  LET ms_execute_path = p_path
  
END FUNCTION 

FUNCTION sadzp350_util_get_execute_path()
DEFINE
  ls_path STRING 
  
  LET ls_path = ms_execute_path

  RETURN ls_path
  
END FUNCTION 

FUNCTION sadzp350_util_get_form_path(p_form_name)
DEFINE
  p_form_name STRING 
DEFINE
  ls_form_name    STRING,
  ls_path         STRING,
  ls_os_separator STRING,
  ls_form_path    STRING

  LET ls_form_name = p_form_name
  
  LET ls_path = sadzp350_util_get_execute_path()
  LET ls_os_separator = os.Path.separator()
  LET ls_form_path = ls_path,ls_os_separator,ls_form_name                      

  RETURN ls_form_path
  
END FUNCTION 

FUNCTION sadzp350_util_trim_str(p_string)
DEFINE
  p_string STRING
DEFINE
  ls_string STRING
DEFINE
  ls_return STRING

  LET ls_string = p_string

  LET ls_string = ls_string.trim()
  
  LET ls_return = ls_string
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzp350_util_get_program_title(p_program,p_lang)
DEFINE
  p_program STRING,
  p_lang    STRING
DEFINE
  ls_program STRING,
  ls_lang    STRING,
  ls_program_title VARCHAR(512),
  ls_sql     STRING
DEFINE
  ls_return STRING  

  LET ls_program = p_program
  LET ls_lang    = p_lang
  
  LET ls_sql = "SELECT ZA.GZZA001||'-'||ZAL.GZZAL003  PROGRAM_TITLE           ",
               "  FROM GZZA_T ZA                                              ",
               "  LEFT OUTER JOIN GZZAL_T ZAL ON ZAL.GZZAL001 = ZA.GZZA001    ",
               "                             AND ZAL.GZZAL002 = '",ls_lang,"' ",
               " WHERE ZA.GZZA001 = '",ls_program,"'                          "              

  PREPARE lpre_get_program_title FROM ls_sql
  DECLARE lcur_get_program_title CURSOR FOR lpre_get_program_title

  INITIALIZE ls_program_title TO NULL
  
  OPEN lcur_get_program_title
  FETCH lcur_get_program_title INTO ls_program_title
  CLOSE lcur_get_program_title
  
  FREE lpre_get_program_title
  FREE lcur_get_program_title  

  LET ls_return = ls_program_title
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp350_util_gen_diff_document(p_exp_path,p_contents,p_doc_type,p_guid)
DEFINE
  p_exp_path STRING,
  p_contents STRING,
  p_doc_type STRING,
  p_guid     STRING      
DEFINE
  ls_exp_path     STRING,
  ls_contents     STRING,
  ls_doc_type     STRING, 
  ls_ID           STRING,
  ls_exit_sign    STRING,
  lchannel_write  base.Channel,
  ls_doc_filename STRING,
  ls_separator    STRING, 
  ls_return       STRING

  LET ls_exp_path = p_exp_path
  LET ls_contents = p_contents
  LET ls_doc_type = p_doc_type
  LET ls_ID       = NVL(p_guid,sadzp350_util_get_datetime_string())
  
  LET ls_separator = os.Path.separator()
  
  LET ls_doc_filename = ls_exp_path,ls_separator,"sadzp350_diff_",ls_ID,".",ls_doc_type
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  #開檔寫入
  TRY
    CALL lchannel_write.openFile(ls_doc_filename, "w" )
    CALL lchannel_write.write(ls_contents)
    #關檔
    CALL lchannel_write.close()
  CATCH
    DISPLAY cs_error_tag,"Generate diff document with error !!"
  END TRY  

  LET ls_return = ls_doc_filename

  RETURN ls_return

END FUNCTION

FUNCTION sadzp350_util_get_GUID()
DEFINE 
  ls_GUID  STRING
DEFINE  
  ls_return STRING

  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID 

  LET ls_return = ls_GUID
  
  RETURN ls_return                     
  
END FUNCTION

FUNCTION sadzp350_util_get_datetime_string()
DEFINE 
  ls_date  STRING
DEFINE  
  ls_return STRING

  LET ls_date = (TODAY USING "yyyymmdd")
  
  LET ls_return = ls_date
  
  RETURN ls_return                     
  
END FUNCTION

FUNCTION sadzp350_util_making_work_directory(p_object_type)
DEFINE
  p_object_type  STRING
DEFINE
  ls_object_type   STRING,
  ls_PathName      STRING,
  ls_TEMPDIR       STRING,
  ls_GUID          STRING,
  li_mkdir         BOOLEAN,
  lb_chdir         BOOLEAN,
  ls_os_separator  STRING
DEFINE 
  lb_return BOOLEAN, 
  ls_return STRING   

  LET ls_object_type = p_object_type

  LET lb_return = TRUE
  LET lb_chdir  = TRUE

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  LET ls_GUID = security.RandomGenerator.CreateUUIDString()
  
  LET ls_TEMPDIR  = FGL_GETENV("TEMPDIR")
  LET ls_PathName = ls_TEMPDIR,ls_os_separator,"sadzp350_",ls_object_type,"_",ls_GUID

  CALL os.Path.mkdir(ls_PathName) RETURNING li_mkdir

  IF NOT os.Path.exists(ls_PathName) THEN
    LET lb_return = FALSE
    DISPLAY cs_error_tag," The temporary path '",ls_PathName,"' doesn't exists !!"
  ELSE  
    CALL os.Path.chdir(ls_PathName) RETURNING lb_chdir  
    LET lb_return = lb_chdir
  END IF 
  
  LET ls_return = ls_PathName
  
  RETURN lb_return,ls_return  
  
END FUNCTION

FUNCTION sadzp350_util_change_to_temp_directory(p_object_type)
DEFINE
  p_object_type  STRING
DEFINE
  ls_object_type   STRING,
  ls_path_name     STRING,
  ls_temp_dir      STRING,
  ls_GUID          STRING,
  li_mkdir         BOOLEAN,
  lb_chdir         BOOLEAN,
  ls_os_separator  STRING
DEFINE 
  lb_return BOOLEAN, 
  ls_return STRING   

  LET ls_object_type = p_object_type

  LET lb_return = TRUE
  LET lb_chdir  = TRUE

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  LET ls_temp_dir  = FGL_GETENV("TEMPDIR")
  LET ls_path_name = ls_temp_dir

  IF NOT os.Path.exists(ls_path_name) THEN
    LET lb_return = FALSE
    DISPLAY cs_error_tag," The temporary path '",ls_path_name,"' doesn't exists !!"
  ELSE  
    CALL os.Path.chdir(ls_path_name) RETURNING lb_chdir  
    LET lb_return = lb_chdir
  END IF 
  
  LET ls_return = ls_path_name
  
  RETURN lb_return,ls_return  
  
END FUNCTION

FUNCTION sadzp350_util_download_document(p_lang,p_diff_full_path,p_save_doc_type)
DEFINE
  p_lang           STRING,
  p_diff_full_path STRING,
  p_save_doc_type  STRING
DEFINE
  ls_lang                STRING,
  ls_diff_full_path      STRING,
  ls_save_doc_type       STRING,
  lo_file_dialog         T_FILE_DIALOG, 
  lo_PUT_GET_FILE_PARA   T_PUT_GET_FILE_PARA,
  ls_client_path   STRING,
  ls_doc_path      STRING,
  ls_doc_name      STRING,
  ls_all_type_file STRING,
  ls_export_desc   STRING, 
  ls_export_title  STRING,
  ls_replace_arg   STRING,
  lb_result        BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET ls_lang           = p_lang
  LET ls_diff_full_path = p_diff_full_path
  LET ls_save_doc_type  = p_save_doc_type

  LET ls_doc_path = os.Path.dirName(ls_diff_full_path)
  LET ls_doc_name = os.Path.basename(ls_diff_full_path)
  LET ls_all_type_file = "*.",ls_save_doc_type
  
  LET lb_result = TRUE  
  
  CALL sadzp000_msg_get_message('adz-00224',ls_lang) RETURNING ls_export_desc -- 匯出檔
  CALL sadzp000_msg_get_message('adz-00225',ls_lang) RETURNING ls_export_title -- 儲存匯出檔
  CALL sadzp350_dlg_set_dialog_parameter("",ls_export_desc,ls_all_type_file,ls_export_title) RETURNING lo_file_dialog.*
  CALL sadzp350_dlg_save_dir_dialog(lo_file_dialog.*) RETURNING ls_client_path
  CALL sadzp350_util_set_download_file_parameter(ls_doc_path,ls_doc_name,ls_client_path,ls_doc_name) RETURNING lo_PUT_GET_FILE_PARA.*
  
  IF NVL(lo_PUT_GET_FILE_PARA.CLIENT_FILE_PATH,cs_null_value) <> cs_null_value THEN
    CALL sadzp350_util_save_to_client(lo_PUT_GET_FILE_PARA.*) RETURNING lb_result
  ELSE
    LET lb_result = FALSE  
  END IF   

  LET lb_return = lb_result

  RETURN lb_return

END FUNCTION        

FUNCTION sadzp350_util_set_download_file_parameter(p_param1,p_param2,p_param3,p_param4)
DEFINE 
  p_param1,p_param2,p_param3,p_param4 STRING 
DEFINE
  lo_parameter T_PUT_GET_FILE_PARA
DEFINE
  lo_return  T_PUT_GET_FILE_PARA

  #Source
  LET lo_parameter.SERVER_FILE_PATH = p_param1   
  LET lo_parameter.SERVER_FILE_NAME = p_param2
  #Destination  
  LET lo_parameter.CLIENT_FILE_PATH = p_param3   
  LET lo_parameter.CLIENT_FILE_NAME = p_param4   

  LET lo_return.* = lo_parameter.*

  RETURN lo_return.*  

END FUNCTION 

FUNCTION sadzp350_util_save_to_client(mo_parameter)
DEFINE
  mo_parameter T_PUT_GET_FILE_PARA
DEFINE
  lo_parameter    T_PUT_GET_FILE_PARA,
  ls_source       STRING,
  ls_destination  STRING,
  ls_os_separator STRING
DEFINE
  lb_return BOOLEAN  

  LET lo_parameter.* = mo_parameter.*
  LET lb_return = TRUE

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator 

  LET ls_source      = lo_parameter.SERVER_FILE_PATH,ls_os_separator,lo_parameter.SERVER_FILE_NAME
  LET ls_destination = lo_parameter.CLIENT_FILE_PATH,ls_os_separator,lo_parameter.CLIENT_FILE_NAME

  DISPLAY cs_information_tag,"Source File : ",ls_source
  DISPLAY cs_information_tag,"Destination File : ",ls_destination 

  TRY 
    CALL FGL_PUTFILE(ls_source,ls_destination)
  CATCH
    LET lb_return = FALSE 
  END TRY  

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzp350_util_lpad(p_string,p_length,p_pad_str)
DEFINE
  p_string  STRING,
  p_length  INTEGER,
  p_pad_str STRING
DEFINE
  ls_string   STRING,
  li_length   INTEGER,
  ls_pad_str  STRING,
  li_lose_num INTEGER,
  li_loop     INTEGER,
  ls_str_pad  STRING
DEFINE
  ls_return STRING
  
  LET ls_string  = p_string
  LET li_length  = p_length
  LET ls_pad_str = NVL(p_pad_str, " ")

  LET ls_str_pad = ""
  
  LET li_lose_num = li_length - ls_string.getLength()

  IF li_lose_num > 0 THEN
    FOR li_loop = 1 TO li_lose_num
      LET ls_str_pad = ls_str_pad,ls_pad_str
    END FOR 
    LET ls_string = ls_str_pad,ls_string
  END IF

  LET ls_return = ls_string

  RETURN ls_return
  
END FUNCTION