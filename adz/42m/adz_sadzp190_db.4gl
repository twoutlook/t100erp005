#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 13/01/17
#
#+ 程式代碼......: sadzp190_db
#+ 設計人員......: 
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp190_db.4gl
# Description    : SQL BUILDER 執行SQL PLUS
# Memo           :

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzi140_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

PUBLIC TYPE T_DB_INFO RECORD
   DB_NAME   VARCHAR(200),
   USER_NAME VARCHAR(200)
   END RECORD

PUBLIC TYPE T_DB_CONNSTR RECORD
   db_source        VARCHAR(20),
   db_username      VARCHAR(20),
   db_password      VARCHAR(20),
   db_schema        VARCHAR(20),
   db_sid           VARCHAR(20),
   db_sql_filename  VARCHAR(150),
   db_version       VARCHAR(50)
   END RECORD                      

PUBLIC FUNCTION sadzp190_db_run(p_file_name,p_rowcount)
DEFINE p_file_name    STRING 
DEFINE p_rowcount     LIKE type_t.num5
DEFINE l_db_connstr   T_DB_CONNSTR 
DEFINE l_str          STRING
DEFINE l_log          STRING
DEFINE ls_return      STRING
DEFINE l_i            LIKE type_t.num10
DEFINE l_cnt          LIKE type_t.num5

   CALL sadzp190_db_get_db_connect_string("dsdemo") RETURNING l_db_connstr.*
   LET l_db_connstr.db_sql_filename = p_file_name
   CALL sadzp190_db_sqlplus(l_db_connstr.*) RETURNING l_log
   
   LET l_i = l_log.getIndexOf("completed.",1)
   IF l_i > 0 THEN
      LET l_str = l_log.subString(l_i+10,l_log.getLength())
   END IF 
   LET l_log = l_str
   LET l_i = l_log.getIndexOf("Disconn",1)
   IF l_i > 0 THEN
      LET l_str = l_log.subString(1,l_i-1)
   END IF 
   LET l_log = l_str
   
   LET ls_return = l_log
   
   {
   LET l_str = NULL 
   LET l_i = 1
   LET l_cnt = 0
   WHILE l_i > 0
      LET l_i = l_log.getIndexOf("\n",1)
      IF l_i > 0 THEN
         LET l_str = l_str,l_log.subString(1,l_i-1),"\n"
         LET l_log = l_log.subString(l_i+1,l_log.getLength())
         LET l_cnt = l_cnt + 1
      END IF 
      IF l_cnt >= p_rowcount THEN
         EXIT WHILE 
      END IF 
   END WHILE 

   LET ls_return = l_str
   
   }
   
   RETURN ls_return
   
END FUNCTION 

FUNCTION sadzp190_db_sqlplus(p_db_connstr)
DEFINE p_db_connstr T_DB_CONNSTR
DEFINE ls_sqlplus_str STRING
DEFINE ls_message     STRING
DEFINE ls_log_file    STRING
DEFINE lo_db_connstr  T_DB_CONNSTR
DEFINE ls_file_list   STRING
DEFINE ls_return      STRING

  LET lo_db_connstr.* = p_db_connstr.*

  LET ls_sqlplus_str = "sqlplus ",lo_DB_CONNSTR.db_username,"/",lo_DB_CONNSTR.db_password,"@",lo_DB_CONNSTR.db_source||" @"||lo_DB_CONNSTR.db_sql_filename
  CALL sadzp190_db_run_and_catch_log(ls_sqlplus_str) RETURNING ls_message

  LET ls_file_list = ls_file_list,"SQL File : ",lo_DB_CONNSTR.db_sql_filename,"\n"
  LET ls_file_list = ls_file_list,"Log File : ",ls_log_file,"\n"
  LET ls_file_list = ls_file_list,ls_message
  
  LET ls_return = ls_file_list
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzp190_db_run_and_catch_log(p_command)
DEFINE p_command   STRING  #要執行的指令
DEFINE ls_command  STRING  #要執行的指令
DEFINE ls_return   STRING
DEFINE ls_cmd_line STRING
DEFINE ls_message  STRING
DEFINE li_log_line INTEGER
DEFINE lch_read    base.Channel   

  LET ls_command = p_command   
  
  LET ls_message  = ""
  LET li_log_line = 0

  LET lch_read  = base.Channel.create()
  CALL lch_read.setDelimiter("")
  
  CALL lch_read.openPipe(ls_command, "r")
  WHILE TRUE
    LET ls_cmd_line = lch_read.readLine()
    IF lch_read.isEof() THEN 
      EXIT WHILE 
    END IF
    IF NOT cl_null(ls_cmd_line) THEN 
       LET ls_message = ls_message, ls_cmd_line, "\n"
    END IF 
    LET ls_cmd_line = ls_cmd_line.toUpperCase()

  END WHILE
  CALL lch_read.close()

  LET ls_return = ls_message
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp190_db_get_db_connect_string(p_db_name)
DEFINE p_db_name     STRING
DEFINE ls_db_name    STRING
DEFINE ls_db_sid     STRING
DEFINE lo_db_connstr T_DB_CONNSTR
DEFINE ls_sql        STRING
DEFINE lb_success    BOOLEAN
DEFINE ls_privacy_word STRING
DEFINE lo_return     T_DB_CONNSTR  
  
  LET ls_db_name = p_db_name

  LET ls_db_sid = FGL_GETENV("ORACLE_SID")
  
  LET ls_sql = "SELECT '",ls_db_sid,"'  DB_SOURCE,       ",
               "       DA.GZDA003       DB_USERNAME,     ",
               "       DA.GZDA004       DB_PASSWORD,     ",
               "       DA.GZDA001       DB_SCHEMA,       ",
               "       '",ls_db_sid,"'  DB_SID,          ",
               "       ''               DB_SQL_FILENAME, ",
               "       ''               DB_VERSION       ",
               "  FROM GZDA_T DA                         ",
               " WHERE DA.GZDA001 = '",ls_db_name,"'     "

  PREPARE lpre_get_db_connect_string FROM ls_sql
  DECLARE lcur_get_db_connect_string CURSOR FOR lpre_get_db_connect_string

  INITIALIZE lo_db_connstr TO NULL
  
  OPEN lcur_get_db_connect_string
  FETCH lcur_get_db_connect_string INTO lo_db_connstr.*
  CLOSE lcur_get_db_connect_string
  
  IF (NVL(lo_db_connstr.db_username,cs_null_value) = cs_master_db) THEN
    CALL sadzi140_db_get_privacy_word() RETURNING lb_success,ls_privacy_word
    IF lb_success THEN 
      LET lo_db_connstr.db_password = cl_hashkey_base65_anti(ls_privacy_word)
    ELSE 
      LET lo_db_connstr.db_password = cl_hashkey_base65_anti(lo_db_connstr.db_password)
    END IF 
  ELSE 
    IF lo_db_connstr.db_username IS NOT NULL THEN 
      LET lo_db_connstr.db_password = cl_hashkey_base65_anti(lo_db_connstr.db_password)
    END IF  
  END IF 
  
  FREE lpre_get_db_connect_string
  FREE lcur_get_db_connect_string  

  LET lo_return.* = lo_db_connstr.*
  
  RETURN lo_return.*
  
END FUNCTION
#產生sql檔
PUBLIC FUNCTION sadzp190_db_gen_sql_file(p_sql,p_line_size,p_page_size)
DEFINE p_sql              STRING
DEFINE p_line_size        STRING
DEFINE p_page_size        STRING
DEFINE ls_sql             STRING
DEFINE ls_line_size       STRING
DEFINE ls_page_size       STRING
DEFINE ls_exit_sign       STRING
DEFINE ls_random_name     STRING
DEFINE ls_tempdir         STRING
DEFINE lchannel_write     base.Channel
DEFINE ls_sript_filename  STRING
DEFINE ls_return          STRING
DEFINE ls_os_separator    STRING
DEFINE l_replace          STRING  
  
  LET ls_sql       = p_sql


  LET l_replace = "'",g_dept,"'"
  LET ls_sql = cl_replace_str(ls_sql,":DEPT",l_replace)
  LET l_replace = "'",g_user,"'"
  LET ls_sql = cl_replace_str(ls_sql,":USER",l_replace)
  LET l_replace = "'",g_enterprise,"'"
  LET ls_sql = cl_replace_str(ls_sql,":ENT",l_replace)
  LET l_replace = "'",g_today,"'"
  LET ls_sql = cl_replace_str(ls_sql,":TODAY",l_replace)
  LET l_replace = "'",g_dlang,"'"
  LET ls_sql = cl_replace_str(ls_sql,":DLANG",l_replace)
  LET l_replace = "'",g_lang,"'"
  LET ls_sql = cl_replace_str(ls_sql,":LANG",l_replace)
  LET l_replace = "'",g_legal,"'"
  LET ls_sql = cl_replace_str(ls_sql,":LEGAL",l_replace)
  LET l_replace = "'",g_site,"'"
  LET ls_sql = cl_replace_str(ls_sql,":SITE",l_replace)
  
  LET ls_sql = cl_replace_str(ls_sql,"arg1",'1')
  LET ls_sql = cl_replace_str(ls_sql,"arg2",'1')
  LET ls_sql = cl_replace_str(ls_sql,"arg3",'1')
  LET ls_sql = cl_replace_str(ls_sql,"arg4",'1')
  LET ls_sql = cl_replace_str(ls_sql,"arg5",'1')
  LET ls_sql = cl_replace_str(ls_sql,"arg6",'1')
  LET ls_sql = cl_replace_str(ls_sql,"arg7",'1')
  LET ls_sql = cl_replace_str(ls_sql,"arg8",'1')
  LET ls_sql = cl_replace_str(ls_sql,"arg9",'1')
  
  LET ls_line_size = "SET LINESIZE ",p_line_size
  LET ls_page_size = "SET PAGESIZE ",p_page_size

  LET ls_exit_sign = "exit;"

  LET ls_os_separator = os.Path.separator()

  LET ls_tempdir = FGL_GETENV("TEMPDIR")
  CALL sadzp190_db_gen_random_name() RETURNING ls_random_name 
  LET ls_sript_filename = ls_tempdir,ls_os_separator,"adzp190",".",ls_random_name,".sql"
  DISPLAY "[SQL File Name]",ls_sript_filename
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  LET ls_sql = ls_line_size,"\n",
               ls_page_size,"\n",
               ls_sql,";\n",
               ls_exit_sign
  
  #開檔寫入
  TRY
    CALL lchannel_write.openFile(ls_sript_filename, "w" )
    CALL lchannel_write.write(ls_sql)
    #關檔
    CALL lchannel_write.close()
  CATCH
    DISPLAY "Generate Script Error !!"
  END TRY  

  LET ls_return = ls_sript_filename

  RETURN ls_return

END FUNCTION

#以亂數產出副檔名
FUNCTION sadzp190_db_gen_random_name()
DEFINE 
  ls_GUID    STRING,
  ls_return  STRING
  
  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID 
  
  LET ls_return = ls_GUID
  
  RETURN ls_return                     
  
END FUNCTION




