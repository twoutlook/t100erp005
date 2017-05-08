&include "../4gl/sadzi190_mcr.inc"

IMPORT util
IMPORT OS 
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi190_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi190_type.inc"

GLOBALS "../../cfg/top_global.inc"

FUNCTION sadzi190_db_connect_db(p_db)
DEFINE 
  p_db STRING

  TRY
    DISCONNECT CURRENT
  CATCH
    DISPLAY "[Hint] No any connection, skip disconnect."
  END TRY  
  
  CONNECT TO p_db
  
END FUNCTION

FUNCTION sadzi190_db_get_parameters(p_level,p_param)
DEFINE
  p_level STRING,
  p_param STRING
DEFINE
  ls_level     STRING,
  ls_param     STRING,
  ls_sql       STRING,
  lo_parameter T_PARAMETERS
DEFINE
  lo_return    T_PARAMETERS

  LET ls_level = p_level
  LET ls_param = p_param

  LET ls_sql = "SELECT EJ.DZEJ005,EJ.DZEJ006,EJ.DZEJ007,EJ.DZEJ008,EJ.DZEJ009 ",
               "  FROM DZEJ_T EJ                                              ",
               " WHERE EJ.DZEJ001 = 'adzi190_parameters'                      ",
               "   AND EJ.DZEJ003 = '",ls_level,"'                            ",
               "   AND EJ.DZEJ004 = '",ls_param,"'                            "
                              
  PREPARE lpre_get_parameter FROM ls_sql
  DECLARE lcur_get_parameter CURSOR FOR lpre_get_parameter

  OPEN lcur_get_parameter
  FETCH lcur_get_parameter INTO lo_parameter.*
  CLOSE lcur_get_parameter
  
  FREE lpre_get_parameter
  FREE lcur_get_parameter  

  LET lo_return.* = lo_parameter.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi190_db_get_db_info()
DEFINE
  lo_db_info T_DB_INFO,
  ls_sql     STRING
DEFINE
  lo_return T_DB_INFO  

  LET ls_sql = "SELECT ORA_DATABASE_NAME, USER ", 
               "  FROM DUAL                    " 

  PREPARE lpre_get_db_info FROM ls_sql
  DECLARE lcur_get_db_info CURSOR FOR lpre_get_db_info

  INITIALIZE lo_db_info TO NULL
  
  OPEN lcur_get_db_info
  FETCH lcur_get_db_info INTO lo_db_info.*
  CLOSE lcur_get_db_info
  
  FREE lpre_get_db_info
  FREE lcur_get_db_info  

  LET lo_return.* = lo_db_info.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi190_db_get_object_information(p_object_name,p_owner_list)
DEFINE 
  p_object_name STRING,
  p_owner_list  STRING
DEFINE
  ls_object_name  STRING,
  ls_owner_list   STRING,
  ls_sql          STRING,
  li_rec_cnt      INTEGER,         
  lo_object_info  DYNAMIC ARRAY OF T_DZEU_T
DEFINE  
  lo_return DYNAMIC ARRAY OF T_DZEU_T

  LET ls_owner_list  = p_owner_list
  LET ls_object_name = p_object_name
  
  LET li_rec_cnt = 1
  
  LET ls_sql = "SELECT EU.DZEU001,EU.DZEU002,EU.DZEU003,EU.DZEU004,EU.DZEU005  ",
               "  FROM DZEU_T EU                                               ",
               " WHERE EU.DZEU001 = '",ls_object_name,"'                       ",
               "   AND EU.DZEU004 = 'Y'                                        ",
               "   AND EU.DZEU002 IN (",ls_owner_list,")                       ", 
               "UNION ALL                                                      ", 
               "SELECT IU.DZIU001,IU.DZIU002,IU.DZIU003,IU.DZIU004,IU.DZIU005  ",
               "  FROM DZIU_T IU                                               ",
               " WHERE IU.DZIU001 = '",ls_object_name,"'                       ",
               "   AND IU.DZIU004 = 'Y'                                        ",
               "   AND IU.DZIU002 IN (",ls_owner_list,")                       ", 
               " ORDER BY 5 ASC,3 DESC                                         "
                              
  PREPARE lpre_get_object_information FROM ls_sql
  DECLARE lcur_get_object_information CURSOR FOR lpre_get_object_information

  OPEN lcur_get_object_information
  FOREACH lcur_get_object_information INTO lo_object_info[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_object_information
  CALL lo_object_info.deleteElement(li_rec_cnt)
  
  FREE lpre_get_object_information
  FREE lcur_get_object_information  

  LET lo_return.* = lo_object_info.*
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi190_db_get_db_connect_string(p_db_name)
DEFINE
  p_db_name STRING
DEFINE
  ls_db_name      STRING,
  ls_db_sid       STRING,
  ls_privacy_word STRING,
  lb_success      BOOLEAN,
  lo_db_connstr   T_DB_COXN_STR,
  ls_sql          STRING
DEFINE
  lo_return T_DB_COXN_STR  
  
  LET ls_db_name = p_db_name

  LET ls_db_sid = FGL_GETENV("ORACLE_SID")  --ex: t10dit
  
  LET ls_sql = "SELECT '",ls_db_sid,"'  DB_SID,          ",
               "       DA.GZDA001       DB_NAME,         ",
               "       DA.GZDA003       DB_USERNAME,     ",
               "       DA.GZDA004       DB_PASSWORD,     ",
               "       ''               DB_DB_LINK,      ",
               "       ''               DB_SQL_FILENAME  ",
               "  FROM GZDA_T DA                         ",
               " WHERE DA.GZDA001 = '",ls_db_name,"'     "

  PREPARE lpre_get_db_connect_string FROM ls_sql
  DECLARE lcur_get_db_connect_string CURSOR FOR lpre_get_db_connect_string

  INITIALIZE lo_db_connstr TO NULL
  
  OPEN lcur_get_db_connect_string
  FETCH lcur_get_db_connect_string INTO lo_db_connstr.*
  CLOSE lcur_get_db_connect_string

  &ifndef DEBUG
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
  &endif
  
  FREE lpre_get_db_connect_string
  FREE lcur_get_db_connect_string  

  LET lo_return.* = lo_db_connstr.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi190_db_sqlplus(p_db_connstr)
DEFINE
  p_db_connstr T_DB_COXN_STR
DEFINE
  lo_db_connstr  T_DB_COXN_STR,
  ls_sqlplus_str STRING,
  ls_message     STRING,
  ls_log_file    STRING,
  ls_file_list   STRING,
  ls_return      STRING

  LET lo_db_connstr.* = p_db_connstr.*

  LET ls_sqlplus_str = "sqlplus ",lo_DB_CONNSTR.db_username,"/",lo_DB_CONNSTR.db_password,"@",lo_DB_CONNSTR.db_sid||" @"||lo_DB_CONNSTR.db_sql_filename

  CALL sadzi190_db_run_and_catch_log(ls_sqlplus_str) RETURNING ls_message
  CALL sadzi190_db_gen_log_file(ls_Message) RETURNING ls_log_file

  LET ls_file_list = ls_file_list,"SQL File : ",lo_DB_CONNSTR.db_sql_filename,"\n"
  LET ls_file_list = ls_file_list,"Log File : ",ls_log_file,"\n"
  LET ls_file_list = ls_file_list,ls_message
  
  LET ls_return = ls_file_list
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzi190_db_run_and_catch_log(p_command)
DEFINE 
  p_command   STRING  #要執行的指令
DEFINE  
  ls_command  STRING, #要執行的指令
  ls_return   STRING,
  ls_cmd_line STRING,
  ls_message  STRING,
  li_log_line INTEGER,
  lch_read    base.Channel   

  LET ls_command = p_command   
  
  LET ls_message  = ""
  LET li_log_line = 0

  LET lch_read  = base.Channel.create()
  CALL lch_read.setDelimiter("")

  #LET ls_command = ls_command||" 2>&1"
  
  CALL lch_read.openPipe(ls_command, "r")
  WHILE TRUE
    LET ls_cmd_line = lch_read.readLine()
    IF lch_read.isEof() THEN 
      EXIT WHILE 
    END IF

    LET li_log_line = li_log_line + 1 
    LET ls_message = ls_message, 
                     "[",(li_log_line USING "&&&&"),"] ",ls_cmd_line, "\n"
    LET ls_cmd_line = ls_cmd_line.toUpperCase()

  END WHILE
  CALL lch_read.close()

  LET ls_return = ls_message
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi190_db_gen_log_file(p_log)
DEFINE
  p_log      STRING
DEFINE
  ls_log           STRING, 
  ls_GUID   STRING,
  ls_temp_dir      STRING,
  lchannel_write   base.Channel,
  ls_log_filename  STRING,
  ls_return        STRING,
  ls_separator     STRING
  
  LET ls_log      = p_log

  LET ls_separator = os.Path.separator()
  
  LET ls_temp_dir = FGL_GETENV("TEMPDIR")
  
  CALL sadzi190_util_get_GUID() RETURNING ls_GUID
  
  LET ls_log_filename = ls_temp_dir,ls_separator,"sadzi190_db_",ls_GUID,".log"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  LET ls_log = ls_log
  
  #開檔寫入
  TRY
    CALL lchannel_write.openFile(ls_log_filename, "w" )
    CALL lchannel_write.write(ls_log)
    #關檔
    CALL lchannel_write.close()
  CATCH
    DISPLAY "Generate log Error : ",ls_log_filename
  END TRY  

  LET ls_return = ls_log_filename

  RETURN ls_return

END FUNCTION

FUNCTION sadzi190_db_exec_SQL(p_sql,p_batch_mode)
DEFINE
  p_sql STRING,
  p_batch_mode BOOLEAN
DEFINE
  ls_sql         STRING,
  lb_batch_mode  BOOLEAN,
  ls_replace_arg STRING
DEFINE
  lb_return BOOLEAN 

  LET ls_sql = p_sql
  LET lb_batch_mode = p_batch_mode

  LET lb_return = TRUE
  
  BEGIN WORK

  TRY
    PREPARE lpre_exec_sql FROM ls_sql
    EXECUTE lpre_exec_sql
    COMMIT WORK
  CATCH
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00024"   # 驗證sql指令失敗(%1)
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示
    LET g_errparam.replace[1] = ls_sql
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
    CALL cl_err()
    #CALL sadzi190_msg_message_box("Error","dialog","執行 SQL"||ls_sql||" 失敗.","stop")
    ROLLBACK WORK
  END TRY  

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi190_db_exec_SQL_no_commit(p_sql,p_batch_mode)
DEFINE
  p_sql STRING,
  p_batch_mode BOOLEAN
DEFINE
  ls_sql         STRING,
  lb_batch_mode  BOOLEAN,
  ls_replace_arg STRING
DEFINE
  lb_return BOOLEAN 
  
  LET ls_sql = p_sql
  LET lb_batch_mode = p_batch_mode

  LET lb_return = TRUE
  
  TRY
    PREPARE lpre_exec_SQL_no_commit FROM ls_sql
    EXECUTE lpre_exec_SQL_no_commit
  CATCH
    LET lb_return = FALSE
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00024"   # 驗證sql指令失敗(%1)
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示
    LET g_errparam.replace[1] = ls_sql
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
    CALL cl_err()
    #CALL sadzi190_msg_message_box("Error","dialog","執行 SQL"||ls_sql||" 失敗.","stop")
  END TRY  

  RETURN lb_return
  
END FUNCTION

################################################################################
# Descriptions...: 產生基本Trigger Script
# Memo...........: 
# Usage..........: CALL sadzi190_db_gen_trigger_scripts(p_dzit_t.*) 
#                :       RETURNING p_dzit_t.*
# Input parameter: p_dzit_t  Trigger資料
#                : 
# Return code....: p_dzit_t  Trigger資料
#                : 
# Date & Author..: 
# Modify.........: 20160406 by CircleLai
################################################################################
FUNCTION sadzi190_db_gen_trigger_scripts(p_dzit_t)
DEFINE
  p_dzit_t  T_DZIT_T_WL
DEFINE
  lo_dzit_t       T_DZIT_T_WL,
  lo_strbuf       base.StringBuffer,
  ls_str1         STRING,
  ls_trigger_type STRING,
  ls_events       STRING,
  ls_scripts      STRING
DEFINE
  lo_return T_DZIT_T_WL

  LET lo_dzit_t.* = p_dzit_t.*
  LET lo_strbuf = base.StringBuffer.create()
  
  LOCATE lo_dzit_t.DZIT008 IN FILE

  LET ls_trigger_type = ""
  IF lo_dzit_t.DZIT007 = cs_trigger_type_row THEN 
    LET ls_trigger_type = "    FOR EACH ROW ",cs_new_line
  END IF 

  CALL sadzi190_db_parse_trigger_event(lo_dzit_t.DZIT006) RETURNING ls_events

  # "CREATE OR REPLACE TRIGGER ", lo_dzit_t.DZIT002, cs_new_line
  CALL lo_strbuf.append("CREATE OR REPLACE TRIGGER ")
  CALL lo_strbuf.append(lo_dzit_t.DZIT002)
  CALL lo_strbuf.append(cs_new_line)
  # "    ", lo_dzit_t.DZIT005, " ", ls_events, " ON ", lo_dzit_t.DZIT001, cs_new_line
  LET ls_str1 = "    ", lo_dzit_t.DZIT005, " "
  CALL lo_strbuf.append(ls_str1.toUpperCase())
  CALL lo_strbuf.append(ls_events.toUpperCase())
  CALL lo_strbuf.append(" ON ")
  CALL lo_strbuf.append(lo_dzit_t.DZIT001)
  CALL lo_strbuf.append(cs_new_line)
  # "    REFERENCING new as n old as o ", cs_new_line
  CALL lo_strbuf.append("    REFERENCING new as n old as o ")
  CALL lo_strbuf.append(cs_new_line)
  # "    FOR EACH ROW ",cs_new_line
  IF lo_dzit_t.DZIT007 = cs_trigger_type_row THEN
    CALL lo_strbuf.append("    FOR EACH ROW ")
    CALL lo_strbuf.append(cs_new_line)
  END IF
  # "DECLARE ", cs_new_line
  CALL lo_strbuf.append("DECLARE ")
  CALL lo_strbuf.append(cs_new_line)
  # "  l_erp_status    varchar2(3); ", cs_new_line
  # "  l_tran_status   varchar2(3); ", cs_new_line
  # "  l_timestamp     varchar2(17); ", cs_new_line
  # "  l_cnt           number; ", cs_new_line
  CALL lo_strbuf.append("  l_erp_status    varchar2(3); ")
  CALL lo_strbuf.append(cs_new_line)
  CALL lo_strbuf.append("  l_tran_status   varchar2(3); ")
  CALL lo_strbuf.append(cs_new_line)
  CALL lo_strbuf.append("  l_timestamp     varchar2(17); ")
  CALL lo_strbuf.append(cs_new_line)
  CALL lo_strbuf.append("  l_cnt           number; ")
  CALL lo_strbuf.append(cs_new_line)

  # "BEGIN ", cs_new_line
  CALL lo_strbuf.append("BEGIN ")
  CALL lo_strbuf.append(cs_new_line)
  # "-- Trigger Code begin ", cs_new_line
  CALL lo_strbuf.append("-- Trigger Code begin ")
  CALL lo_strbuf.append(cs_new_line)
  # "  /** 設置時間變數l_timestamp **/"
  CALL lo_strbuf.append("  /** 設置時間變數l_timestamp **/")
  CALL lo_strbuf.append(cs_new_line)
  # "  SELECT TO_CHAR(sysdate,'yyyyMMddhh24miss') || SUBSTR(TO_CHAR(sysdate,'SSSSS'),1,3) INTO l_timestamp FROM dual;"
  # "  /** 設置時間變數l_timestamp **/"
  CALL lo_strbuf.append("  SELECT TO_CHAR(sysdate,'yyyyMMddhh24miss') || SUBSTR(TO_CHAR(sysdate,'SSSSS'),1,3) INTO l_timestamp FROM dual;")
  CALL lo_strbuf.append(cs_new_line)
  IF lo_dzit_t.DZIT007 = cs_trigger_type_row THEN 
    #"  /** 如果產生相同的一筆資料,必需刪除 **/"
    CALL lo_strbuf.append("  /** if there are two or more of the same information in the same time then must keep only one **/")
    CALL lo_strbuf.append(cs_new_line)
    CALL lo_strbuf.append("  /** SELECT count(*) INTO l_cnt FROM ?table_name?" 
                           || " WHERE ?pk_col? AND tran_time = l_timestamp; **/")
    CALL lo_strbuf.append(cs_new_line)
    CALL lo_strbuf.append("  IF (l_cnt > 0) THEN ")
    CALL lo_strbuf.append(cs_new_line)
    CALL lo_strbuf.append("    DBMS_OUTPUT.PUT_LINE('假如同一時有兩個以上的相同資料,只保留一筆資料,本訊息列可刪除'); ")
    CALL lo_strbuf.append("    /** DELETE ?table_name? WHERE ?pk_col? AND tran_time = l_timestamp; **/ ")
    CALL lo_strbuf.append(cs_new_line)
    CALL lo_strbuf.append("  END IF; ")
    CALL lo_strbuf.append(cs_new_line)

    IF lo_dzit_t.DZIT006 IS NOT NULL THEN 
      LET ls_str1 = lo_dzit_t.DZIT006
      LET ls_str1 = ls_str1.toUpperCase()
      CALL lo_strbuf.append("  CASE ")
      CALL lo_strbuf.append(cs_new_line)
      IF ls_str1.getIndexOf("INSERT",1) <> 0 THEN
        CALL lo_strbuf.append("    WHEN inserting THEN ")
        CALL lo_strbuf.append(cs_new_line)
        CALL lo_strbuf.append("    DBMS_OUTPUT.PUT_LINE('請寫入觸發INSERT的內容,本訊息列可刪除'); ")
        CALL lo_strbuf.append(cs_new_line)   
      END IF 
      IF ls_str1.getIndexOf("UPDATE",1) <> 0 THEN
        CALL lo_strbuf.append("    WHEN updating THEN ")
        CALL lo_strbuf.append(cs_new_line)   
        CALL lo_strbuf.append("    DBMS_OUTPUT.PUT_LINE('請寫入觸發UPDATE的內容,本訊息列可刪除'); ")
        CALL lo_strbuf.append(cs_new_line)   
      END IF 
      IF ls_str1.getIndexOf("UPDATE",1) <> 0 THEN
        CALL lo_strbuf.append("    WHEN deleting THEN ")
        CALL lo_strbuf.append(cs_new_line)   
        CALL lo_strbuf.append("    DBMS_OUTPUT.PUT_LINE('請寫入觸發DELETE的內容,本訊息列可刪除'); ")
        CALL lo_strbuf.append(cs_new_line)   
      END IF 
      CALL lo_strbuf.append("  END CASE; ")
      CALL lo_strbuf.append(cs_new_line)
    END IF
  END IF 
  # "-- Trigger Code end ", cs_new_line
  CALL lo_strbuf.append("-- Trigger Code end ")
  CALL lo_strbuf.append(cs_new_line)
  # "EXCEPTION ", cs_new_line
  CALL lo_strbuf.append("EXCEPTION ")
  CALL lo_strbuf.append(cs_new_line)
  # "  WHEN OTHERS THEN ", cs_new_line
  CALL lo_strbuf.append("  WHEN OTHERS THEN ")
  CALL lo_strbuf.append(cs_new_line)
  # "    raise_application_error(-20100, 'Trigger Error code ' || SQLCODE || ': ' || SQLERRM || ' DATAKEY ? : ?');"
  CALL lo_strbuf.append("    raise_application_error(-20100, 'Trigger Error code ' || SQLCODE || ': ' || SQLERRM" 
                        || "|| ' DATAKEY ? : ?');")
  CALL lo_strbuf.append(cs_new_line)
  # "END ", cs_new_line
  CALL lo_strbuf.append("END; ")
  CALL lo_strbuf.append(cs_new_line)

  #LET ls_scripts = "CREATE OR REPLACE TRIGGER ",lo_dzit_t.DZIT002,"                       ",cs_new_line,
  #                 "    ", lo_dzit_t.DZIT005," ",ls_events,"                                   ",cs_new_line,
  #                 "  ON ",lo_dzit_t.DZIT001,"                                            ",cs_new_line,
  #                 "  REFERENCING new as n old as o                                       ",cs_new_line,
  #                 ls_trigger_type,
  #                 "DECLARE                                                               ",cs_new_line,
  #                 "BEGIN                                                                 ",cs_new_line,
  #                 "                                                                      ",cs_new_line,
  #                 "  -- Trigger Code begin                                               ",cs_new_line,
  #                 "  DBMS_OUTPUT.PUT_LINE('從這裡開始撰寫 Trigger, 本訊息列可刪除');          ",cs_new_line,
  #                 "  -- Trigger Code end                                                 ",cs_new_line,
  #                 "                                                                      ",cs_new_line,
  #                 "EXCEPTION                                                             ",cs_new_line,
  #                 "   WHEN OTHERS THEN                                                   ",cs_new_line,
  #                 "     DBMS_OUTPUT.PUT_LINE('[ERROR] '||SQLERRM);                       ",cs_new_line,
  #                 "END;                                                                  ",cs_new_line
  
  LET lo_dzit_t.DZIT008 = lo_strbuf.toString()
  
  LET lo_return.* = lo_dzit_t.*

  RETURN lo_return.*  

END FUNCTION

FUNCTION sadzi190_db_parse_trigger_event(p_events)
DEFINE 
  p_events STRING
DEFINE 
  ls_events       STRING,
  li_index        INTEGER,
  ls_event_char   STRING,
  ls_event_string STRING,
  ls_event_queue  STRING
DEFINE
  ls_return STRING   

  LET ls_events = p_events

  LET ls_event_queue  = "" 
  LET ls_event_string = "" 
  
  FOR li_index = 1 TO ls_events.getLength()
    LET ls_event_char = NVL(ls_events.subString(li_index,li_index),cs_null_value) 
    IF ls_event_char MATCHES "," THEN
      LET ls_event_string = ls_event_string," OR "
      LET ls_event_queue  = ls_event_queue,ls_event_string
      LET ls_event_string = ""
    ELSE
      LET ls_event_string = ls_event_string,ls_event_char 
    END IF    
  END FOR

  #最後一組或僅有一組要加入Queue
  LET ls_event_queue = ls_event_queue,ls_event_string

  LET ls_return = ls_event_queue --.subString(1,ls_event_queue.getLength()-1)
  
  RETURN ls_return
  
END FUNCTION
#產生刪除觸發器的script 
FUNCTION sadzi190_db_gen_drop_trigger_script(p_trigger_name)
DEFINE
  p_trigger_name  STRING
DEFINE
  ##########################
  ls_drop_script         STRING,
  ls_drop_rebuild_script STRING,
  ls_exit_sign           STRING,
  ls_drop_full           STRING,
  ls_object_type         STRING,
  ##########################
  ls_trigger_name     STRING,
  ls_GUID             STRING,
  ls_tempdir          STRING,
  lchannel_write      base.Channel,
  ls_sript_filename   STRING,
  ls_procedure_script STRING,
  ls_separator        STRING 
DEFINE
  ls_return STRING  
  
  LET ls_trigger_name = p_trigger_name

  LET ls_separator = os.Path.separator()
  
  LET ls_tempdir = FGL_GETENV("TEMPDIR")
  CALL sadzi190_util_get_GUID() RETURNING ls_GUID 
  LET ls_sript_filename = ls_tempdir,ls_separator,"sadzi190_drop_",ls_trigger_name,"_",ls_GUID,".drp"
  
  LET ls_exit_sign = "exit;"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  LET ls_drop_script = "DROP TRIGGER ",ls_trigger_name

  LET ls_procedure_script = "-- Drop Trigger.                                              ","\n",
                            "SET SERVEROUTPUT ON                                           ","\n",
                            "DECLARE                                                       ","\n",
                            "  ls_SQL  VARCHAR2(1024);                                     ","\n",
                            "BEGIN                                                         ","\n",
                            "   DBMS_OUTPUT.ENABLE(100000);                                ","\n",
                            "                                                              ","\n",
                            "   ls_SQL := '",ls_drop_script,"';                            ","\n",
                            "                                                              ","\n",
                            "   BEGIN                                                      ","\n",
                            "     EXECUTE IMMEDIATE ls_SQL;                                ","\n",
                            "     DBMS_OUTPUT.PUT_LINE('[Message] Drop trigger success.'); ","\n",          
                            "   EXCEPTION                                                  ","\n",
                            "     WHEN OTHERS THEN                                         ","\n",
                            "       DBMS_OUTPUT.PUT_LINE(SQLERRM);                         ","\n",
                            "   END;                                                       ","\n",
                            "                                                              ","\n",
                            "EXCEPTION                                                     ","\n",
                            "  WHEN OTHERS THEN                                            ","\n",
                            "    DBMS_OUTPUT.PUT_LINE(SQLERRM);                            ","\n",
                            "END;                                                          ","\n",
                            "/                                                             ","\n"
  
  LET ls_drop_full = ls_procedure_script,"\n",
                     ls_exit_sign
  
  #開檔寫入
  TRY
    CALL lchannel_write.openFile(ls_sript_filename, "w" )
    CALL lchannel_write.write(ls_drop_full)
    #關檔
    CALL lchannel_write.close()
  CATCH
    DISPLAY "Generate Script Error !!"
  END TRY  

  LET ls_return = ls_sript_filename
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzi190_db_gen_switch_trigger_script(p_jsonobj)
DEFINE
  p_jsonobj   util.JSONObject --trigger_name, status
DEFINE
  ##########################
  ls_disable_rebuild_script STRING,
  ls_exit_sign              STRING,
  ls_disable_full           STRING,
  ls_object_type            STRING,
  ##########################
  ls_trigger_name     STRING,
  ls_status           STRING,
  ls_GUID             STRING,
  ls_tempdir          STRING,
  lchannel_write      base.Channel,
  ls_sript_filename   STRING,
  ls_procedure_script STRING,
  ls_separator        STRING 
DEFINE
  ls_return STRING

  #p_jsonobj 取得參數
  LET ls_trigger_name = IIF (p_jsonobj.has("trigger_name"), p_jsonobj.get("trigger_name"), NULL )
  LET ls_status = IIF (p_jsonobj.has("status"), p_jsonobj.get("status"), "?" ) --rixqq?

  LET ls_separator = os.Path.separator()
  
  LET ls_tempdir = FGL_GETENV("TEMPDIR")
  CALL sadzi190_util_get_GUID() RETURNING ls_GUID 
  LET ls_sript_filename = ls_tempdir,ls_separator,"sadzi190_disable_",ls_trigger_name,"_",ls_GUID,".dis"
  
  LET ls_exit_sign = "exit;"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  LET ls_procedure_script = "-- Switch Trigger.                                                         ","\n",
                            "DECLARE                                                                    ","\n",
                            "  ls_SQL  VARCHAR2(1024);                                                  ","\n",
                            "  ls_status VARCHAR(10);                                                   ","\n",
                            "BEGIN                                                                      ","\n",
                            "  DBMS_OUTPUT.ENABLE(100000);                                              ","\n",
                            "                                                                           ","\n",
                            "  SELECT DECODE(UTS.STATUS,'ENABLED','DISABLE','DISABLED','ENABLE') STATUS ","\n",
                            "    INTO ls_status                                                         ","\n",
                            "    FROM USER_TRIGGERS UTS                                                 ","\n",
                            "   WHERE UTS.TRIGGER_NAME = '",ls_trigger_name.toUpperCase(),"';           ","\n",
                            "                                                                           ","\n",
                            --強制設定trigger disable or enable
                            IIF ((ls_status == "?") , "", ("ls_status := '"|| ls_status || "';")), 
                            "  ls_SQL := 'ALTER TRIGGER ",ls_trigger_name.toUpperCase()," '||ls_status; ","\n",
                            "                                                                           ","\n",
                            "  BEGIN                                                                    ","\n",
                            "    EXECUTE IMMEDIATE ls_SQL;                                              ","\n",
                            "    DBMS_OUTPUT.PUT_LINE('[Message] Switch trigger success.');             ","\n",
                            "  EXCEPTION                                                                ","\n",
                            "    WHEN OTHERS THEN                                                       ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(SQLERRM);                                       ","\n",
                            "  END;                                                                     ","\n",
                            "                                                                           ","\n",
                            "EXCEPTION                                                                  ","\n",
                            "  WHEN OTHERS THEN                                                         ","\n",
                            "    DBMS_OUTPUT.PUT_LINE(SQLERRM);                                         ","\n",
                            "END;                                                                       ","\n",
                            "/                                                                          ","\n"
  
  LET ls_disable_full = ls_procedure_script,"\n",
                        ls_exit_sign
  
  #開檔寫入
  TRY
    CALL lchannel_write.openFile(ls_sript_filename, "w" )
    CALL lchannel_write.write(ls_disable_full)
    #關檔
    CALL lchannel_write.close()
  CATCH
    DISPLAY "Generate Script Error !!"
  END TRY  

  LET ls_return = ls_sript_filename
  
  RETURN ls_return

END FUNCTION
#取得目前Trigger實際狀態  --rixqq? 與 sadzp310_asmg_get_trigger_status function 功能雷同,考慮整合
FUNCTION sadzi190_db_get_trigger_status(p_owner,p_table_name,p_trigger_name)
DEFINE
  p_owner        STRING,  -- schema name || 或者是資料庫代號(ex: erpdb,awsdb)
  p_table_name   STRING,
  p_trigger_name STRING
DEFINE
  ls_owner        STRING,
  ls_table_name   STRING,
  ls_trigger_name STRING,
  ls_sql          STRING,
  ls_status       VARCHAR(10) --Y:已建立,N:未建立,X:失效中
DEFINE
  ls_return  STRING

  LET ls_owner = "'", p_owner.toUpperCase(), "'"
  LET ls_table_name = p_table_name.toUpperCase()
  LET ls_trigger_name = p_trigger_name.toUpperCase() 
  
  #由資料庫代號取得schema name
  IF (p_owner == cs_alias_erp_db OR p_owner == cs_alias_aws_db) THEN
    CALL sadzi190_dtas_decode_columns(p_owner) RETURNING ls_owner
    LET ls_owner = ls_owner.toUpperCase()
  END IF 
  
  LET ls_sql = "SELECT DECODE(STATUS,'ENABLED','Y','DISABLED','X','N') STATUS ",
               "  FROM ALL_TRIGGERS ATS                                       ",
               " WHERE 1=1                                                    ",
               "   AND ATS.OWNER IN (",ls_owner,")                            ",
               "   AND ATS.TABLE_NAME = '",ls_table_name,"'                   ",
               "   AND ATS.TRIGGER_NAME = '",ls_trigger_name,"'               "
 
  PREPARE lpre_get_trigger_status FROM ls_sql
  DECLARE lcur_get_trigger_status CURSOR FOR lpre_get_trigger_status
  OPEN lcur_get_trigger_status
  #FETCH lcur_get_trigger_status INTO ls_status
  FOREACH lcur_get_trigger_status INTO ls_status
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    IF (ls_status == "Y" ) THEN
      EXIT FOREACH
    END IF
  END FOREACH
  CLOSE lcur_get_trigger_status
  FREE lcur_get_trigger_status
  FREE lpre_get_trigger_status

  LET ls_return = NVL(ls_status,"N")
  LET ls_return = ls_return.trim()
  
  RETURN ls_return
  
END FUNCTION

# @Deprecated 停用樣版功能function  
FUNCTION sadzi190_db_load_from_template(p_dzit_t)
DEFINE
  p_dzit_t  T_DZIT_T_WL
DEFINE
  lo_dzit_t       T_DZIT_T_WL,
  ls_trigger_type STRING,
  ls_events       STRING,
  ls_scripts      STRING
DEFINE
  lo_return T_DZIT_T_WL

  LET lo_dzit_t.* = p_dzit_t.*
  
  LOCATE lo_dzit_t.DZIT008 IN FILE

  CALL sadzi190_db_get_template_contents(lo_dzit_t.*) RETURNING ls_scripts  
  LET lo_dzit_t.DZIT008 = ls_scripts
  
  LET lo_return.* = lo_dzit_t.*

  RETURN lo_return.*  

END FUNCTION
# @Deprecated 停用樣版功能function  
FUNCTION sadzi190_db_get_template_contents(p_dzit_t)
DEFINE
  p_dzit_t  T_DZIT_T_WL
DEFINE
  lo_dzit_t     T_DZIT_T_WL,
  lo_dzit008    LIKE DZIT_T.DZIT008,
  lo_str_buf    base.StringBuffer,
  ls_sql        STRING,
  ls_mdm_name   STRING,
  ls_erp_name   STRING,
  li_rec_count  INTEGER
DEFINE
  ls_return  STRING

  LET lo_dzit_t.* = p_dzit_t.*

  LET lo_str_buf = base.StringBuffer.create()
  CALL lo_str_buf.Clear()
  
  LOCATE lo_dzit008 IN FILE
  
  #取得樣板資料
  LET ls_sql = "SELECT IT.DZIT008                           ",
               "  FROM DZIT_T IT                            ",
               " WHERE IT.DZIT001 = '",lo_dzit_t.DZIT001,"' ",
               "   AND IT.DZIT002 = '",lo_dzit_t.DZIT002,"' ",
               "   AND IT.DZIT003 = '",cs_template_words,"' ",
               --"   AND IT.DZIT004 = '",cs_dgenv_standard,",",cs_dgenv_customize,"' "
               "   AND IT.DZIT004 = '",lo_dzit_t.DZIT004,"' "
 
  PREPARE lpre_get_template_contents FROM ls_sql
  DECLARE lcur_get_template_contents CURSOR FOR lpre_get_template_contents
  OPEN lcur_get_template_contents
  FETCH lcur_get_template_contents INTO lo_dzit008
  CLOSE lcur_get_template_contents
  FREE lcur_get_template_contents
  FREE lpre_get_template_contents

  LET ls_return = lo_dzit008
  FREE lo_dzit008

  CALL sadzi190_util_get_mdmdb_name(lo_dzit_t.DZIT003) RETURNING ls_mdm_name
  CALL sadzi190_util_get_erpdb_name(lo_dzit_t.DZIT003) RETURNING ls_erp_name
  CALL lo_str_buf.append(ls_return)
  CALL lo_str_buf.replace(cs_identify_mdm_db,ls_mdm_name,0)  
  CALL lo_str_buf.replace(cs_identify_erp_db,ls_erp_name,0)  
  CALL lo_str_buf.toString() RETURNING ls_return  

  RETURN ls_return
  
END FUNCTION
# @Deprecated 停用樣版功能function  
FUNCTION sadzi190_db_load_template_data(p_dzit_t,p_lang)
DEFINE
  p_dzit_t  T_DZIT_T_WL,
  p_lang    STRING 
DEFINE
  lo_dzit_t      T_DZIT_T_WL,
  ls_lang        STRING, 
  lo_temp_dzit_t T_DZIT_T_WL,
  ls_sql         STRING,
  li_rec_count   INTEGER
DEFINE
  lo_return  T_DZIT_T_WL

  LET lo_dzit_t.* = p_dzit_t.*
  LET ls_lang = p_lang

  LOCATE lo_temp_dzit_t.DZIT008 IN FILE
  
  #取得樣板資料
  LET ls_sql = "SELECT IT.DZIT001,IT.DZIT002,IT.DZIT003,IT.DZIT004,IT.DZIT005,   ",
               "       IT.DZIT006,IT.DZIT007,IT.DZIT008,IT.DZIT009,ITL.DZITL006, ",
               "       ITL.DZITL007                                              ", 
               "  FROM DZIT_T IT                                                 ",
               "  LEFT OUTER JOIN DZITL_T ITL ON ITL.DZITL001 = IT.DZIT001       ",
               "                             AND ITL.DZITL002 = IT.DZIT002       ",
               "                             AND ITL.DZITL003 = IT.DZIT003       ",
               "                             AND ITL.DZITL004 = IT.DZIT004       ",
               "                             AND ITL.DZITL005 = '",ls_lang,"'    ", 
               " WHERE 1=1                                                       ",
               "   AND IT.DZIT001 = '",lo_dzit_t.DZIT001,"'                      ",
               "   AND IT.DZIT002 = '",lo_dzit_t.DZIT002,"'                      ",
               "   AND IT.DZIT003 = '",cs_template_words,"'                      ",
               --"   AND IT.DZIT004 = '",cs_dgenv_standard,",",cs_dgenv_customize,"' "
               "   AND IT.DZIT004 = '",lo_dzit_t.DZIT004,"'                      "
 
  PREPARE lpre_load_template_data FROM ls_sql
  DECLARE lcur_load_template_data CURSOR FOR lpre_load_template_data
  OPEN lcur_load_template_data
  FETCH lcur_load_template_data INTO lo_temp_dzit_t.*
  CLOSE lcur_load_template_data
  FREE lcur_load_template_data
  FREE lpre_load_template_data

  LET lo_return.* = lo_temp_dzit_t.*
  
  RETURN lo_return.*
  
END FUNCTION
