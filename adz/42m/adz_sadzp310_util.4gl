&include "../4gl/sadzp310_mcr.inc"

IMPORT util 
IMPORT os 
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp310_type.inc"

DEFINE
  ms_execute_path  STRING

FUNCTION sadzp310_util_set_execute_path(p_path)
DEFINE
  p_path STRING 

  LET ms_execute_path = p_path
  
END FUNCTION 
  
FUNCTION sadzp310_util_get_execute_path()
DEFINE
  ls_path STRING 
  
  LET ls_path = NVL(ms_execute_path,os.Path.pwd())

  RETURN ls_path
  
END FUNCTION 

FUNCTION sadzp310_util_get_form_path(p_form_name)
DEFINE
  p_form_name STRING 
DEFINE
  ls_form_name    STRING,
  ls_path         STRING,
  ls_os_separator STRING,
  ls_form_path    STRING

  LET ls_form_name = p_form_name
  
  LET ls_path = sadzp310_util_get_execute_path()
  LET ls_os_separator = os.Path.separator()
  LET ls_form_path = ls_path,ls_os_separator,ls_form_name                      

  RETURN ls_form_path
  
END FUNCTION 

FUNCTION sadzp310_util_making_work_directory(p_object_type,p_working_dir_type,p_object_name)
DEFINE
  p_object_type      STRING,
  p_working_dir_type STRING,
  p_object_name      STRING
DEFINE
  ls_object_type      STRING,
  ls_working_dir_type STRING,
  ls_object_name      STRING
DEFINE
  ls_PathName      STRING,
  ls_TEMPDIR       STRING,
  ls_GUID          STRING,
  li_mkdir         BOOLEAN,
  lb_chdir         BOOLEAN,
  ls_os_separator  STRING
DEFINE 
  lb_return BOOLEAN, 
  ls_return STRING   

  LET ls_object_type      = p_object_type
  LET ls_working_dir_type = p_working_dir_type
  LET ls_object_name      = p_object_name

  LET lb_return = TRUE
  LET lb_chdir  = TRUE

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  LET ls_GUID = security.RandomGenerator.CreateUUIDString()
  
  LET ls_TEMPDIR  = FGL_GETENV("TEMPDIR")
  LET ls_PathName = ls_TEMPDIR,ls_os_separator,ls_object_type,"_",ls_object_name,"_",ls_working_dir_type,"_",ls_GUID

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

FUNCTION sadzp310_util_write_file(p_file_name,p_text_string)
DEFINE
  p_file_name   STRING,
  p_text_string STRING
DEFINE   
  ls_file_name      STRING,
  ls_text_string    STRING,
  lo_channel_write  base.Channel,
  lb_success        BOOLEAN

  LET ls_file_name  = p_file_name
  LET ls_text_string = p_text_string

  LET lb_success = TRUE
  
  LET  lo_channel_write = base.Channel.create()
  CALL lo_channel_write.setDelimiter("")

  TRY
    CALL lo_channel_write.openFile(ls_file_name, "w")
    CALL lo_channel_write.write(ls_text_string)
    CALL lo_channel_write.close()
  CATCH
    LET lb_success = FALSE
  END TRY  

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_util_reset_working_path(p_COMPRESS_FILE_INFO,p_EXP_LIST,p_work_path)
DEFINE
  p_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO,
  p_EXP_LIST            DYNAMIC ARRAY OF T_EXP_HEADER,
  p_work_path           STRING
DEFINE
  lo_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO,
  lo_EXP_LIST            DYNAMIC ARRAY OF T_EXP_HEADER,
  ls_work_path           STRING,
  ls_os_separator        STRING,
  li_loop                INTEGER

  LET lo_COMPRESS_FILE_INFO.* = p_COMPRESS_FILE_INFO.*
  LET lo_EXP_LIST = p_EXP_LIST
  LET ls_work_path = p_work_path

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator

  #重設壓縮包的解包路徑
  LET lo_COMPRESS_FILE_INFO.cfi_PATH = ls_work_path
  LET lo_COMPRESS_FILE_INFO.cfi_FULL_NAME = lo_COMPRESS_FILE_INFO.cfi_PATH,ls_os_separator,lo_COMPRESS_FILE_INFO.cfi_NAME
  LET lo_COMPRESS_FILE_INFO.cfi_NOTICE_PATH = ls_work_path
  LET lo_COMPRESS_FILE_INFO.cfi_NOTICE_FULL_NAME = lo_COMPRESS_FILE_INFO.cfi_NOTICE_PATH,ls_os_separator,lo_COMPRESS_FILE_INFO.cfi_NOTICE_NAME

  #重設匯出檔解包後的路徑
  FOR li_loop = 1 TO lo_EXP_LIST.getLength()
    LET lo_EXP_LIST[li_loop].eh_EXP_PATH = ls_work_path
    LET lo_EXP_LIST[li_loop].eh_EXP_FULL_NAME = lo_EXP_LIST[li_loop].eh_EXP_PATH,ls_os_separator,lo_EXP_LIST[li_loop].eh_EXP_NAME
  END FOR 

  RETURN lo_COMPRESS_FILE_INFO.*,lo_EXP_LIST
  
END FUNCTION 

FUNCTION sadzp310_util_read_file_contents(p_file_name)
DEFINE
  p_file_name  STRING
DEFINE
  ls_file_name     STRING,
  lo_channel_read  base.Channel,
  ls_TextLine      STRING,
  li_RecCnt        INTEGER,
  lb_success       BOOLEAN
DEFINE
  ls_return  STRING,
  lb_return  BOOLEAN

  LET ls_file_name = p_file_name

  LET lb_success = TRUE

  LET lo_channel_read = base.Channel.create()
  TRY 
    CALL lo_channel_read.openFile(ls_file_name,"r")
  CATCH
    LET lb_success = FALSE
    DISPLAY cs_error_tag,"Open file ",ls_file_name," fault."
  END TRY  

  IF lb_success THEN
    LET li_RecCnt = 1 
    WHILE TRUE
      IF lo_channel_read.isEof() THEN 
        EXIT WHILE
      END IF

      LET ls_TextLine = ls_TextLine,lo_channel_read.readLine()
      
      LET li_RecCnt = li_RecCnt + 1 
        
    END WHILE
  END IF
  
  CALL lo_channel_read.close()

  LET ls_return = ls_TextLine
  LET lb_return = lb_success
  
  RETURN lb_return,ls_return
  
END FUNCTION

FUNCTION sadzp310_util_download_package(p_lang,p_COMPRESS_FILE_INFO)
DEFINE
  p_lang                STRING,
  p_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO
DEFINE
  ls_lang                STRING,
  lo_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO,
  lo_file_dialog         T_FILE_DIALOG, 
  lo_PUT_GET_FILE_PARA   T_PUT_GET_FILE_PARA,
  ls_client_path  STRING,
  ls_export_desc  STRING, 
  ls_export_title STRING,
  ls_replace_arg  STRING,
  lb_result       BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET ls_lang = p_lang
  LET lo_COMPRESS_FILE_INFO.* = p_COMPRESS_FILE_INFO.*

  LET lb_result = TRUE  
  
  CALL sadzp000_msg_get_message('adz-00224',ls_lang) RETURNING ls_export_desc -- 匯出檔
  CALL sadzp000_msg_get_message('adz-00225',ls_lang) RETURNING ls_export_title -- 儲存匯出檔
  CALL sadzp310_dlg_set_dialog_parameter(lo_COMPRESS_FILE_INFO.cfi_PATH,ls_export_desc,cs_export_import_all_file,ls_export_title) RETURNING lo_file_dialog.*
  CALL sadzp310_dlg_save_dir_dialog(lo_file_dialog.*) RETURNING ls_client_path
  CALL sadzp310_exp_set_download_file_parameter(lo_COMPRESS_FILE_INFO.cfi_PATH,lo_COMPRESS_FILE_INFO.cfi_NAME,ls_client_path,lo_COMPRESS_FILE_INFO.cfi_NAME) RETURNING lo_PUT_GET_FILE_PARA.*
  IF NVL(lo_PUT_GET_FILE_PARA.CLIENT_FILE_PATH,cs_null_value) <> cs_null_value THEN
    CALL sadzp310_exp_save_to_client(lo_PUT_GET_FILE_PARA.*) RETURNING lb_result
  ELSE
    LET lb_result = FALSE  
  END IF   

  LET lb_return = lb_result

  RETURN lb_return

END FUNCTION        

FUNCTION sadzp310_util_upload_package(p_lang,p_arguments)
DEFINE
  p_lang       STRING,
  p_arguments  T_ARGUMENTS
DEFINE
  ls_lang         STRING,
  lo_arguments    T_ARGUMENTS,
  ls_import_path  STRING,
  ls_import_desc  STRING, 
  ls_import_title STRING,
  ls_server_path  STRING,
  ls_separator    STRING,
  lo_export_info  T_EXPORT_INFO,
  lb_result       BOOLEAN,
  ls_clinet_path_name   STRING,
  lo_file_dialog        T_FILE_DIALOG, 
  lo_PUT_GET_FILE_PARA  T_PUT_GET_FILE_PARA
DEFINE
  lb_return  BOOLEAN,  
  lo_return  T_ARGUMENTS

  LET ls_lang = p_lang
  LET lo_arguments.* = p_arguments.*

  LET lb_result = TRUE
  LET ls_separator = os.Path.separator()
  LET lb_result = TRUE
  
  LET ls_import_path = os.Path.pwd()
  CALL sadzp000_msg_get_message('adz-00224',ls_lang) RETURNING ls_import_desc
  CALL sadzp000_msg_get_message('adz-00226',ls_lang) RETURNING ls_import_title
  CALL sadzp310_dlg_set_dialog_parameter(ls_import_path,ls_import_desc,cs_export_import_all_file,ls_import_title) RETURNING lo_file_dialog.*
  CALL sadzp310_dlg_open_file_dialog(lo_file_dialog.*) RETURNING ls_clinet_path_name
  IF NVL(ls_clinet_path_name,cs_null_value) <> cs_null_value THEN
    CALL sadzp310_imp_parse_client_full_name(ls_clinet_path_name,lo_export_info.*) RETURNING lo_export_info.*
    CALL sadzp310_imp_get_server_working_path(lo_export_info.TAR_NAME) RETURNING lb_result,ls_server_path
    CALL sadzp310_imp_set_upload_parameter(lo_export_info.CLIENT_PATH,lo_export_info.TAR_NAME,ls_server_path,lo_export_info.TAR_NAME) RETURNING lo_PUT_GET_FILE_PARA.*
    CALL sadzp310_imp_catch_to_server(lo_PUT_GET_FILE_PARA.*) RETURNING lb_result
    LET lo_arguments.a_SOURCE_FULL_NAME = NULL
    IF lb_result THEN
      LET lo_arguments.a_SOURCE_FULL_NAME = lo_PUT_GET_FILE_PARA.SERVER_FILE_PATH,ls_separator,lo_PUT_GET_FILE_PARA.SERVER_FILE_NAME
    END IF
  ELSE  
    LET lo_arguments.a_SOURCE_FULL_NAME = NULL
    LET lb_result = FALSE
  END IF 

  LET lb_return = lb_result
  LET lo_return.* = lo_arguments.*

  RETURN lb_return,lo_return.*

END FUNCTION        

FUNCTION sadzp310_util_gen_sql_script_file(p_sql,p_sql_type)
DEFINE
  p_sql      STRING,
  p_sql_type STRING 
DEFINE
  ls_sql             STRING,
  ls_sql_type        STRING, 
  ls_exit_sign       STRING,
  ls_GUID            STRING,
  ls_tempdir         STRING,
  lchannel_write     base.Channel,
  ls_sript_filename  STRING,
  ls_separator       STRING, 
  ls_return          STRING
  
  LET ls_sql      = p_sql
  LET ls_sql_type = p_sql_type
  
  LET ls_exit_sign = "exit;"

  LET ls_separator = os.Path.separator()

  LET ls_tempdir = FGL_GETENV("TEMPDIR")

  LET ls_GUID = security.RandomGenerator.CreateUUIDString()
  
  LET ls_sript_filename = ls_tempdir,ls_separator,"sadzp310_",ls_sql_type,"_",ls_GUID,".sql"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  LET ls_sql = ls_sql,"\n",
               ls_exit_sign
  
  #開檔寫入
  TRY
    CALL lchannel_write.openFile(ls_sript_filename, "w" )
    CALL lchannel_write.write(ls_sql)
    #關檔
    CALL lchannel_write.close()
  CATCH
    DISPLAY cs_error_tag,"Generate Script Error !!"
  END TRY  

  LET ls_return = ls_sript_filename

  RETURN ls_return

END FUNCTION
################################################################################
# Descriptions...: 在$TEMPDIR目錄下write | append | (?read) 檔案
# Memo...........:  read 功能尚未完成，待做
# Usage..........: CALL sadzp310_util_gen_log_file(p_log, p_filename, p_openFMode) 
#                   RETURNING lb_ret,ls_ret
# Input parameter: p_log        預備寫入的內容
#                : p_filename    log檔案名稱  ex: "sadzp310_asm_*.log"
#                : p_openFMode  開啟檔案模式 'w', 'a', 'r'
# Return code....: lb_ret   寫入log file 行為是否正確
#                : ls_ret   寫入行為回傳檔案絕對路徑
# Date & Author..: 20160303 by circlelai (160309-00001#1)
# Modify.........: 
################################################################################
FUNCTION sadzp310_util_gen_log_file(p_log, p_filename, p_openFMode)
DEFINE 
  p_log         STRING,
  p_filename    STRING,
  p_openFMode   STRING
DEFINE
  ls_log        STRING,
  ls_fileName   STRING,
  ls_openFMode  STRING,
  ls_separator  STRING,
  ls_tempDir    STRING,
  ls_filePath   STRING,
  lchannel_write    base.Channel
DEFINE 
  lb_ret    BOOLEAN,
  ls_ret    STRING

  LET ls_log  = p_log
  LET ls_fileName = p_filename
  LET ls_openFMode = p_openFMode
  LET ls_ret = TRUE 

  LET ls_separator  = os.Path.separator()
  LET ls_tempDir = FGL_GETENV("TEMPDIR")
  # ls_fileName like below: 
  # CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID
  # ls_fileName = "sadzp310_db_",ls_GUID,".log"
  LET ls_filePath = ls_TEMPDIR, ls_separator, ls_fileName
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  CASE ls_openFMode
    WHEN "w" 
      #開檔寫入
      TRY
        CALL lchannel_write.openFile(ls_filePath, "w")
        CALL lchannel_write.write(ls_log)
        #關檔
        CALL lchannel_write.close()
      CATCH
        LET ls_ret = FALSE 
        DISPLAY cs_error_tag,"sadzp310_util function(w): generate log fail.File path = ",ls_filePath
      END TRY 
      LET ls_ret = ls_filePath
    WHEN "a"
      #開檔寫入
      TRY
        CALL lchannel_write.openFile(ls_filePath, "a")
        CALL lchannel_write.write(ls_log)
        #關檔
        CALL lchannel_write.close()
      CATCH
        LET ls_ret = FALSE 
        DISPLAY cs_error_tag,"sadzp310_util function(a): generate log fail.File path = ",ls_filePath
      END TRY 
      LET ls_ret = ls_filePath
    WHEN "r"
      #?? 預埋功能，待做  --201603031046
    OTHERWISE 
      DISPLAY cs_error_tag,"sadzp310_util function: unknow open file mode"
  END CASE 
  
  RETURN lb_ret,ls_ret
END FUNCTION 
################################################################################
# Descriptions...: 解譯schema_string或者資料庫別名(db_alias)取得 資料庫陣列(lo_schema_list)
# Memo...........: schema_string example "dsaws,dsawst"
#                : db_alias example "awsdb"
# Usage..........: CALL sadzp310_util_trans_schema_queue_to_array(p_schemas) RETURNING lo_return
# Input parameter: p_schemas 要解譯的字串
# Return code....: lo_return 解譯取得的資料庫陣列
# Date & Author..: 20160330 by CircleLai
# Modify.........: 
################################################################################
FUNCTION sadzp310_util_trans_schema_queue_to_array(p_schemas)
DEFINE 
  p_schemas STRING
DEFINE 
  li_index          INTEGER,
  li_schema_counts  INTEGER,
  ls_schema_char    STRING,
  ls_schemas        STRING,
  ls_schemas_string STRING,
  ls_sql            STRING,
  ls_db_type        STRING, 
  lo_schema_list    DYNAMIC ARRAY OF LIKE DZEJ_T.DZEJ007
DEFINE
  lo_return  DYNAMIC ARRAY OF LIKE DZEJ_T.DZEJ007

  LET ls_schemas = p_schemas 
  LET ls_schemas_string = NULL 

  #20160706 marked begin
  {
  IF (ls_schemas == cs_alias_erp_db OR  ls_schemas == cs_alias_aws_db) THEN
    #從資料庫別名取得對應的資料庫實際名稱
    LET ls_schemas = IIF ((p_schemas == cs_alias_erp_db), "ERPDB" , "MDMDB")
    LET ls_sql = "SELECT EJ.DZEJ007 FROM DZEJ_T EJ         ", 
                 " WHERE EJ.DZEJ001 = 'adzi180_parameters' ",
                 "   AND EJ.DZEJ004 = '",ls_schemas,"'     "
    PREPARE lpre_trans_schema_que_to_arr FROM ls_sql
    DECLARE lcur_trans_schema_que_to_arr CURSOR FOR lpre_trans_schema_que_to_arr
    OPEN lcur_trans_schema_que_to_arr
    LET li_schema_counts = 1
    FOREACH lcur_trans_schema_que_to_arr INTO lo_schema_list[li_schema_counts]
      IF SQLCA.sqlcode THEN
        EXIT FOREACH
      END IF
      LET li_schema_counts = li_schema_counts + 1 
    END FOREACH
    CALL lo_schema_list.deleteElement(li_schema_counts)
    CLOSE lcur_trans_schema_que_to_arr
    FREE lcur_trans_schema_que_to_arr
    FREE lpre_trans_schema_que_to_arr
    
  ELSE #schema_string --old version
    FOR li_index = 1 TO ls_schemas.getLength()
      LET ls_schema_char = NVL(ls_schemas.subString(li_index,li_index),cs_null_value) 
      IF ls_schema_char MATCHES "," THEN
        LET li_schema_counts = lo_schema_list.getLength()
        LET lo_schema_list[li_schema_counts + 1] = ls_schemas_string
        LET ls_schemas_string = NULL
      ELSE
        LET ls_schemas_string = ls_schemas_string,ls_schema_char 
      END IF    
      
    END FOR

    #最後一組或僅有一組要加入Array
    IF ls_schemas_string IS NOT NULL THEN 
      LET li_schema_counts = lo_schema_list.getLength()
      LET lo_schema_list[li_schema_counts + 1] = ls_schemas_string
    END IF 
    
  END IF
  }
  #20160706 marked end

  CASE 
    #ERPDB
    WHEN (ls_schemas = cs_alias_erp_db) 
      LET ls_db_type = "Y" 
    #MDMDB
    WHEN (ls_schemas = cs_alias_aws_db)
      LET ls_db_type = "M"
  END CASE 

  LET ls_sql = "select DA.GZDA001 SCHEMA_NAME " , "\n"
             , "  from gzda_t DA " , "\n"
             , " where DA.GZDASTUS = 'Y' " , "\n"
             , "   and DA.GZDA005  = '" , ls_db_type , "' " , "\n"
             , " order by DA.GZDA001 desc " , "\n"

  PREPARE lpre_trans_schema_queue_to_array FROM ls_sql
  DECLARE lcur_trans_schema_queue_to_array CURSOR FOR lpre_trans_schema_queue_to_array
  OPEN lcur_trans_schema_queue_to_array
  LET li_schema_counts = 1
  
  FOREACH lcur_trans_schema_queue_to_array INTO lo_schema_list[li_schema_counts]
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET li_schema_counts = li_schema_counts + 1
    
  END FOREACH
  
  CALL lo_schema_list.deleteElement(li_schema_counts)
  
  CLOSE lcur_trans_schema_queue_to_array
  
  FREE lcur_trans_schema_queue_to_array
  FREE lpre_trans_schema_queue_to_array

  LET lo_return = lo_schema_list
  
  RETURN lo_return
  
END FUNCTION
################################################################################
# Descriptions...: 取得erpdb對應的awsdb資料庫名稱
# Memo...........: 
# Usage..........: CALL sadzp310_util_get_mdmdb_name(p_erp_db) RETURNING ls_return
# Input parameter: p_erp_db   ERP資料庫名稱
# Return code....: ls_return  對應的AWS資料庫名稱
# Date & Author..: 20160330 by CircleLai
# Modify.........: 
################################################################################
FUNCTION sadzp310_util_get_mdmdb_name(p_erp_db)
DEFINE
  p_erp_db STRING
DEFINE
  ls_erp_db STRING,
  ls_sql        STRING,
  ls_mdm_name   VARCHAR(20),
  li_rec_count  INTEGER
DEFINE
  ls_return  STRING

  LET ls_erp_db = p_erp_db

  #取得MDM資料
  LET ls_sql = "SELECT EJ.DZEJ007                                               ",
               "  FROM DZEJ_T EJ                                                ",
               " WHERE EJ.DZEJ001 = 'adzi180_parameters'                        ",
               "   AND EJ.DZEJ004 = 'MDMDB'                                     ",
               "   AND EJ.DZEJ005 = (                                           ",
               "                      SELECT MIN(EJT.DZEJ005) DZEJ005           ",
               "                        FROM DZEJ_T EJT                         ",
               "                       WHERE EJT.DZEJ001 = 'adzi180_parameters' ",
               "                         AND EJT.DZEJ004 IN ('ERPDB','MDMDB')   ",
               "                         AND EJT.DZEJ007 = '",ls_erp_db,"'      ",
               "                    )                                           "
 
  PREPARE lpre_get_mdmdb_name FROM ls_sql
  DECLARE lcur_get_mdmdb_name CURSOR FOR lpre_get_mdmdb_name
  OPEN lcur_get_mdmdb_name
  FETCH lcur_get_mdmdb_name INTO ls_mdm_name
  CLOSE lcur_get_mdmdb_name
  FREE lcur_get_mdmdb_name
  FREE lpre_get_mdmdb_name

  LET ls_return = ls_mdm_name

  RETURN ls_return
  
END FUNCTION
################################################################################
# Descriptions...: 取得awsdb對應的erpdb資料庫名稱
# Memo...........: 
# Usage..........: CALL sadzp310_util_get_erpdb_name(p_mdmdb) RETURNING ls_return
# Input parameter: p_mdmdb    AWS資料庫名稱
# Return code....: ls_return  對應的ERP資料庫名稱
# Date & Author..: 20160330 by CircleLai
# Modify.........: 
################################################################################
FUNCTION sadzp310_util_get_erpdb_name(p_mdmdb)
DEFINE
  p_mdmdb STRING
DEFINE
  ls_mdmdb STRING,
  ls_sql        STRING,
  ls_erp_name   VARCHAR(20),
  li_rec_count  INTEGER
DEFINE
  ls_return  STRING

  LET ls_mdmdb = p_mdmdb

  #取得MDM資料
  LET ls_sql = "SELECT EJ.DZEJ007                                               ",
               "  FROM DZEJ_T EJ                                                ",
               " WHERE EJ.DZEJ001 = 'adzi180_parameters'                        ",
               "   AND EJ.DZEJ004 = 'ERPDB'                                     ",
               "   AND EJ.DZEJ005 = (                                           ",
               "                      SELECT MIN(EJT.DZEJ005) DZEJ005           ",
               "                        FROM DZEJ_T EJT                         ",
               "                       WHERE EJT.DZEJ001 = 'adzi180_parameters' ",
               "                         AND EJT.DZEJ004 IN ('MDMDB','ERPDB')   ",
               "                         AND EJT.DZEJ007 = '",ls_mdmdb,"'       ",
               "                    )                                           "
 
  PREPARE lpre_get_erpdb_name FROM ls_sql
  DECLARE lcur_get_erpdb_name CURSOR FOR lpre_get_erpdb_name
  OPEN lcur_get_erpdb_name
  FETCH lcur_get_erpdb_name INTO ls_erp_name
  CLOSE lcur_get_erpdb_name
  FREE lcur_get_erpdb_name
  FREE lpre_get_erpdb_name

  LET ls_return = ls_erp_name

  RETURN ls_return
  
END FUNCTION
################################################################################
# Descriptions...: 解析 schema_String or schena_alias into "'schema_name1','schema_name2'"
# Memo...........: 
# Usage..........: CALL sadzp310_util_decode_columns(p_columns) RETURNING ls_return
# Input parameter: p_columns  schema_String like ex "dsdemo,dsdata", 
#                :            schena_alias like ex "awsdb" or "erpdb"
# Return code....: ls_return  return string like "'dsaws','dsawst'"
# Date & Author..: 20160330 by CircleLai
# Modify.........: 
# 
# Fixme_161102...: 待做,考慮變更由 gzda_t (azzi085 維護作業) 中取得資料庫資訊  by Circle Lai
# ...............: 取得ERPDB 參考SQL e.q. SELECT GZDA003 FROM GZDA_T WHERE GZDASTUS='Y' AND GZDA005='Y'
# ...............: 取得AWSDB 參考SQL e.q. SELECT GZDA003 FROM GZDA_T WHERE GZDASTUS='Y' AND GZDA005='M'
################################################################################
FUNCTION sadzp310_util_decode_columns(p_columns)
DEFINE 
  p_columns STRING
DEFINE 
  li_index          INTEGER,
  ls_column_char    STRING,
  ls_columns        STRING,
  ls_columns_string STRING,
  ls_sql            STRING,
  ls_columns_queue  STRING,
  lo_dzej007        DYNAMIC ARRAY OF LIKE DZEJ_T.DZEJ007
DEFINE
  ls_return STRING   

  LET ls_columns = p_columns

  LET ls_columns_queue  = "" 
  LET ls_columns_string = "'" 
  
  IF (ls_columns == cs_alias_erp_db OR  ls_columns == cs_alias_aws_db) THEN
    LET ls_columns = IIF ((p_columns == cs_alias_erp_db), 
                          "ERPDB" , 
                          "MDMDB")
    LET li_index = 1 
    #取得確實要執行的 schema name
    LET ls_sql = "SELECT EJ.DZEJ007 FROM DZEJ_T EJ         ", 
                 " WHERE EJ.DZEJ001 = 'adzi180_parameters' ",
                 "   AND EJ.DZEJ004 = '",ls_columns,"'     "
    PREPARE lpre_decode_columns FROM ls_sql
    DECLARE lcur_decode_columns CURSOR FOR lpre_decode_columns
    OPEN lcur_decode_columns
    FOREACH lcur_decode_columns INTO lo_dzej007[li_index]
      IF SQLCA.sqlcode THEN
        EXIT FOREACH
      END IF
      LET ls_columns_string = "'", lo_dzej007[li_index], "'"
      LET li_index = li_index + 1
      LET ls_columns_queue = ls_columns_queue,ls_columns_string,","
    END FOREACH
    CALL lo_dzej007.deleteElement(li_index) 
    CLOSE lcur_decode_columns
    FREE lcur_decode_columns
    FREE lpre_decode_columns
  ELSE 
    FOR li_index = 1 TO ls_columns.getLength()
      LET ls_column_char = NVL(ls_columns.subString(li_index,li_index),cs_null_value) 
      IF ls_column_char MATCHES "," THEN
        LET ls_columns_string = ls_columns_string,"'"
        LET ls_columns_queue  = ls_columns_queue,ls_columns_string,","
        LET ls_columns_string = "'"
      ELSE
        LET ls_columns_string = ls_columns_string,ls_column_char 
      END IF    
    END FOR

    #最後一組或僅有一組要加入Queue
    LET ls_columns_string = ls_columns_string,"'"
    LET ls_columns_queue  = ls_columns_queue,ls_columns_string,","
    LET ls_columns_string = "'"
  END IF 
  
  LET ls_return = ls_columns_queue.subString(1,ls_columns_queue.getLength()-1)
  
  RETURN ls_return
  
END FUNCTION

#20160706 begin
FUNCTION sadzp310_util_check_view_exists(p_dziv_t)
DEFINE        
  p_dziv_t   T_DZIV_T
DEFINE
  lo_dziv_t     T_DZIV_T,
  ls_view_name  STRING,
  ls_db_type    STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  ls_gzda005    STRING
DEFINE  
  lb_return     BOOLEAN

  LET lo_dziv_t.* = p_dziv_t.*
  
  LET ls_view_name = UPSHIFT(lo_dziv_t.DZIV001)
  LET ls_db_type   = lo_dziv_t.DZIV002

  CASE
    WHEN ls_db_type = cs_alias_erp_db
      LET ls_gzda005 = "Y"
    WHEN ls_db_type = cs_alias_aws_db
      LET ls_gzda005 = "M"
  END CASE

  #取得資料筆數
  LET ls_sql = "SELECT CASE                                         ",
               "         WHEN DBCS.CNTS <> DACS.CNTS THEN 0 ELSE 1  ",
               "       END AS CNTS                                  ",
               "  FROM (                                            ",
               "        SELECT COUNT(1) CNTS                        ",   
               "          FROM DBA_OBJECTS DOS                      ",
               "         WHERE DOS.OBJECT_NAME = '",ls_view_name,"' ",
               "           AND DOS.OBJECT_TYPE = 'VIEW'             ",
               "       ) DBCS,                                      ",
               "       (                                            ",
               "        SELECT COUNT(1) CNTS                        ",
               "          FROM GZDA_T DA                            ",
               "         WHERE DA.GZDASTUS = 'Y'                    ",
               "           AND DA.GZDA005  = '",ls_gzda005,"'       ",
               "       ) DACS                                       ",
               " WHERE 1=1                                          "
 
  PREPARE lpre_check_view_exists FROM ls_sql
  DECLARE lcur_check_view_exists CURSOR FOR lpre_check_view_exists
  OPEN lcur_check_view_exists
  FETCH lcur_check_view_exists INTO li_rec_count
  CLOSE lcur_check_view_exists
  FREE lcur_check_view_exists
  FREE lpre_check_view_exists

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp310_util_check_view_if_invalid(p_view_name)
DEFINE        
  p_view_name  STRING
DEFINE
  ls_view_name  STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  lb_return     BOOLEAN

  LET ls_view_name = p_view_name.toUpperCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                             ",
               "  FROM DBA_OBJECTS DOS                      ",
               " WHERE DOS.OBJECT_NAME = '",ls_view_name,"' ", 
               "   AND DOS.OBJECT_TYPE = 'VIEW'             ",
               "   AND DOS.STATUS      = 'INVALID'          "
   
  PREPARE lpre_check_view_if_invalid FROM ls_sql
  DECLARE lcur_check_view_if_invalid CURSOR FOR lpre_check_view_if_invalid
  OPEN lcur_check_view_if_invalid
  FETCH lcur_check_view_if_invalid INTO li_rec_count
  CLOSE lcur_check_view_if_invalid
  FREE lcur_check_view_if_invalid
  FREE lpre_check_view_if_invalid

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp310_util_check_view_if_expired(p_dziv_t)
DEFINE        
  p_dziv_t   T_DZIV_T
DEFINE
  lo_dziv_t     T_DZIV_T,
  ls_view_name  STRING,
  ls_db_type    STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  ls_gzda005    STRING
DEFINE  
  lb_return     BOOLEAN

  LET lo_dziv_t.* = p_dziv_t.*
  
  LET ls_view_name = lo_dziv_t.DZIV001

  #取得資料筆數
  LET ls_sql = "SELECT CASE                                                                   ",
               "         WHEN DALMDT.LAST_MODIFY_TIME > DBLMDT.LAST_MODIFY_TIME THEN 1 ELSE 0 ",
               "       END LMDT                                                               ",
               "  FROM (                                                                      ",
               "        SELECT MAX(DOS.LAST_DDL_TIME) LAST_MODIFY_TIME                        ",
               "          FROM DBA_OBJECTS DOS                                                ",
               "         WHERE DOS.OBJECT_NAME = '",ls_view_name.toUpperCase(),"'             ",
               "           AND DOS.OBJECT_TYPE = 'VIEW'                                       ",
               "       ) DBLMDT,                                                              ",
               "       (                                                                      ",
               "        SELECT IV.DZIVMODDT LAST_MODIFY_TIME                                  ",
               "          FROM DZIV_T IV                                                      ",
               "         WHERE IV.DZIV001 = '",ls_view_name.toLowerCase(),"'                  ",
               "       ) DALMDT                                                               ",
               " WHERE 1=1                                                                    "
                                                                                              
  PREPARE lpre_check_view_if_expired FROM ls_sql
  DECLARE lcur_check_view_if_expired CURSOR FOR lpre_check_view_if_expired
  OPEN lcur_check_view_if_expired
  FETCH lcur_check_view_if_expired INTO li_rec_count
  CLOSE lcur_check_view_if_expired
  FREE lcur_check_view_if_expired
  FREE lpre_check_view_if_expired

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION
#20160706 end

################################################################################
# @desc.   刪除字串中\r,\n,\t,空白符號
# @para.   p_string 要處理的字串
# @return  ls_return  回傳處理後的字串
# @modify  170210-00052#1 at 2017/02/14 by circlelai 調整字串處理功能
################################################################################
FUNCTION sadzp310_util_trim_str(p_string)
DEFINE
  p_string STRING
DEFINE ls_string STRING
DEFINE lo_strbuf base.StringBuffer
  
DEFINE 
  ls_return STRING

  LET ls_string = p_string.trim()
  
  IF ls_string IS NOT NULL THEN 
     LET lo_strbuf = base.StringBuffer.create()
     CALL lo_strbuf.clear()
     CALL lo_strbuf.append(ls_string)
     CALL lo_strbuf.replace(" ","",0)
     CALL lo_strbuf.replace("\t","",0)
     CALL lo_strbuf.replace("\r","",0)
     CALL lo_strbuf.replace("\n","",0)
     LET ls_string = lo_strbuf.toString()
  END IF 
  
  LET ls_return = ls_string
  
  RETURN ls_return

END FUNCTION

# @desc.   加密
# @input   p_toDigest  要加密的字串
# @input   p_algo      演算法(SHA1, SHA512, SHA384, SHA256, SHA224, MD5)
# @return  ls_ret      加密後字串, if 加密失敗則回傳加密錯誤日誌
# @return  lb_ret      加密是否成功
# @create  170210-00052#1 at 2017/02/20 by circlelai 
FUNCTION sadzp310_util_ComputeHash(p_toDigest, p_algo)
DEFINE -- input 
  p_toDigest STRING, 
  p_algo     STRING 
DEFINE -- return 
  ls_ret     STRING,
  lb_ret     BOOLEAN 
DEFINE ls_toDigest STRING
DEFINE lo_dgst security.Digest 

  LET ls_ret = NULL
  LET lb_ret = TRUE  
  
  TRY 
    # check input para.
    IF p_toDigest IS NULL THEN 
      LET lb_ret = TRUE 
      LET ls_ret = "Input string is null."
      RETURN lb_ret, ls_ret
    END IF 
    
    LET lo_dgst = security.Digest.CreateDigest(p_algo)
    CALL lo_dgst.AddStringData(p_toDigest)

    LET ls_ret = lo_dgst.DoHexBinaryDigest()
    LET lb_ret = TRUE  
  CATCH 
    LET ls_ret = STATUS, "-", SQLCA.SQLERRM # 記錄錯誤訊息
    LET lb_ret = FALSE
  END TRY 
  
  RETURN lb_ret, ls_ret  
END FUNCTION  

