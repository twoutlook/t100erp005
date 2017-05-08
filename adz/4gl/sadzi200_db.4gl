&include "../4gl/sadzi200_mcr.inc"

IMPORT util
IMPORT OS 
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi200_type.inc"

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi200_cnst.inc"

FUNCTION sadzi200_db_connect_db(p_db)
DEFINE 
  p_db STRING

  TRY
    DISCONNECT CURRENT
  CATCH
    DISPLAY "[Hint] No any connection, skip disconnect."
  END TRY  
  
  CONNECT TO p_db
  
END FUNCTION

FUNCTION sadzi200_db_get_parameters(p_level,p_param)
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
               " WHERE EJ.DZEJ001 = 'adzi200_parameters'                      ",
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

FUNCTION sadzi200_db_get_db_info()
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

FUNCTION sadzi200_db_get_object_information(p_object_name,p_owner_list)
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

FUNCTION sadzi200_db_get_db_connect_string(p_db_name)
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

  LET ls_db_sid = FGL_GETENV("ORACLE_SID")
  
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

FUNCTION sadzi200_db_sqlplus(p_db_connstr)
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

  CALL sadzi200_db_run_and_catch_log(ls_sqlplus_str) RETURNING ls_message
  CALL sadzi200_db_gen_log_file(ls_Message) RETURNING ls_log_file

  LET ls_file_list = ls_file_list,"SQL File : ",lo_DB_CONNSTR.db_sql_filename,"\n"
  LET ls_file_list = ls_file_list,"Log File : ",ls_log_file,"\n"
  LET ls_file_list = ls_file_list,ls_message
  
  LET ls_return = ls_file_list
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzi200_db_run_and_catch_log(p_command)
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

FUNCTION sadzi200_db_gen_log_file(p_log)
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
  
  CALL sadzi200_util_get_GUID() RETURNING ls_GUID
  
  LET ls_log_filename = ls_temp_dir,ls_separator,"sadzi200_db_",ls_GUID,".log"
  
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

FUNCTION sadzi200_db_exec_SQL(p_sql,p_batch_mode)
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
    DISPLAY cs_error_tag,"執行 SQL "||ls_sql||" 失敗."
    ROLLBACK WORK
  END TRY  

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi200_db_exec_SQL_no_commit(p_sql,p_batch_mode)
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
    DISPLAY cs_error_tag,"執行 SQL "||ls_sql||" 失敗."
  END TRY  

  RETURN lb_return
  
END FUNCTION
################################################################################
# Descriptions...: 產生基本VIEW Script
# Memo...........: 
# Usage..........: CALL sadzi200_db_gen_view_scripts(lo_dziv_t.*) 
#                :       RETURNING lo_dziv_t.*
# Input parameter: p_dziv_t  View資料
#                : 
# Return code....: p_dziv_t  View資料
#                : 
# Date & Author..: 
# Modify.........: 20160329 by CircleLai
################################################################################
FUNCTION sadzi200_db_gen_view_scripts(p_dziv_t)
DEFINE
  p_dziv_t  T_DZIV_T_WL
DEFINE
  lo_dziv_t       T_DZIV_T_WL,
  lo_strbuf       base.StringBuffer,
  li_idx          INTEGER,
  ls_view_type    STRING,
  ls_tbl_name     STRING,
  ls_db_alias     STRING, #對應資料庫
  ls_events       STRING,
  ls_scripts      STRING
DEFINE
  lo_return T_DZIV_T_WL

  LET lo_dziv_t.* = p_dziv_t.*
  
  LOCATE lo_dziv_t.DZIV004 IN FILE

  LET lo_strbuf = base.StringBuffer.create()

  #20160706 mark begin
   
  #解析view name, 自動產生對應要搜尋的table name
  --CALL lo_strbuf.append(lo_dziv_t.DZIV001)
  --LET li_idx = lo_strbuf.getLength()
  --IF (li_idx <> 0) THEN #view id is not null
    # lo_dziv_t.DZIV001 like "all_ooca_v"
    --IF lo_strbuf.subString(li_idx-1, li_idx) == "_v" THEN
      --CALL lo_strbuf.replaceAt(li_idx-1, 2, "") -- clean "_v"
    --END IF
    --LET li_idx = lo_strbuf.getIndexOf("_", 1)
    --IF (li_idx <> 0) THEN
       --CALL lo_strbuf.replaceAt(1, li_idx, "") --clean "all_"
    --END IF
    --CALL lo_strbuf.append("_t")
    --LET ls_tbl_name = lo_strbuf.toString()
  --END IF 
  
  #解析對應資料庫
  --CALL lo_strbuf.clear()
  --CALL lo_strbuf.append(lo_dziv_t.DZIV002)
  --LET li_idx = lo_strbuf.getLength()
  --IF li_idx <> 0 THEN # schema name is not null
    --CASE 
      --WHEN lo_strbuf.equals(cs_alias_aws_db)
        --LET ls_db_alias = "{ERPDB}"
      --WHEN lo_strbuf.equals(cs_alias_erp_db)
        --LET ls_db_alias = "{AWSDB}"
      --WHEN lo_strbuf.equals("dsaws") OR lo_strbuf.equals("dsawst")
        --CALL sadzi200_util_get_erpdb_name(lo_strbuf.toString()) RETURNING ls_db_alias
      --WHEN lo_strbuf.equals("dsdata") OR lo_strbuf.equals("dsdemo")
        --CALL sadzi200_util_get_mdmdb_name(lo_strbuf.toString()) RETURNING ls_db_alias
      --OTHERWISE
        --LET ls_db_alias = lo_strbuf.toString()
    --END CASE
    --
  --END IF  

  --CALL lo_strbuf.clear()
  # "CREATE OR REPLACE VIEW ", lo_dziv_t.DZIV001, " AS ", cs_new_line
  --CALL lo_strbuf.append("CREATE OR REPLACE VIEW ")
  --CALL lo_strbuf.append(lo_dziv_t.DZIV001)
  --CALL lo_strbuf.append(" AS ") 
  --CALL lo_strbuf.append(cs_new_line)
  # "SELECT * FROM ", DB_NAME, ".", Table_name, cs_new_line
  --CALL lo_strbuf.append("SELECT * FROM ")
  --IF ls_tbl_name IS NOT NULL THEN
    --IF (ls_db_alias IS NOT NULL) THEN 
      --CALL lo_strbuf.append(ls_db_alias)
      --CALL lo_strbuf.append(".")
    --END IF
    --CALL lo_strbuf.append(ls_tbl_name)
    --CALL lo_strbuf.append(";")
  --ELSE 
    --CALL lo_strbuf.append("DUAL WHERE 1=2;")
  --END IF 
  --CALL lo_strbuf.append(cs_new_line)
  
  #20160706 mark end

  LET ls_scripts = "SELECT * FROM DUAL WHERE 1=2;",cs_new_line
  
  LET lo_dziv_t.DZIV004 = ls_scripts --lo_strbuf.toString()
  
  LET lo_return.* = lo_dziv_t.*

  RETURN lo_return.*  

END FUNCTION

FUNCTION sadzi200_db_gen_drop_view_script(p_view_name)
DEFINE
  p_view_name  STRING
DEFINE
  ##########################
  ls_drop_script         STRING,
  ls_drop_rebuild_script STRING,
  ls_exit_sign           STRING,
  ls_drop_full           STRING,
  ls_object_type         STRING,
  ##########################
  ls_view_name     STRING,
  ls_GUID             STRING,
  ls_tempdir          STRING,
  lchannel_write      base.Channel,
  ls_sript_filename   STRING,
  ls_procedure_script STRING,
  ls_separator        STRING 
DEFINE
  ls_return STRING  
  
  LET ls_view_name = p_view_name

  LET ls_separator = os.Path.separator()
  
  LET ls_tempdir = FGL_GETENV("TEMPDIR")
  CALL sadzi200_util_get_GUID() RETURNING ls_GUID 
  LET ls_sript_filename = ls_tempdir,ls_separator,"sadzi200_drop_",ls_view_name,"_",ls_GUID,".drp"
  
  LET ls_exit_sign = "exit;"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  LET ls_drop_script = "DROP VIEW ",ls_view_name

  LET ls_procedure_script = "-- Drop View.                                                 ","\n",
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
                            "     DBMS_OUTPUT.PUT_LINE('[Message] Drop view success.');    ","\n",          
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

FUNCTION sadzi200_db_get_view_status(p_owner,p_view_name)
DEFINE
  p_owner        STRING,
  p_view_name STRING
DEFINE
  ls_owner      STRING,
  ls_view_name  STRING,
  ls_sql        STRING,
  li_counts     INTEGER
DEFINE
  ls_return  STRING

  LET ls_owner = p_owner.toUpperCase()
  LET ls_view_name = p_view_name.toUpperCase()
  
  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                           ",
               "  FROM DBA_VIEWS DVS                      ",
               " WHERE DVS.OWNER in (",ls_owner,")        ",
               "   AND DVS.VIEW_NAME = '",ls_view_name,"' "               
               
  PREPARE lpre_get_view_status FROM ls_sql
  DECLARE lcur_get_view_status CURSOR FOR lpre_get_view_status
  OPEN lcur_get_view_status
  FETCH lcur_get_view_status INTO li_counts
  CLOSE lcur_get_view_status
  FREE lcur_get_view_status
  FREE lpre_get_view_status

  LET ls_return = IIF(li_counts >= 1,"Y","N")  #View 存在則設置為'Y'
  LET ls_return = ls_return.trim()
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi200_db_load_from_template(p_dziv_t)
DEFINE
  p_dziv_t  T_DZIV_T_WL
DEFINE
  lo_dziv_t       T_DZIV_T_WL,
  ls_view_type STRING,
  ls_events       STRING,
  ls_scripts      STRING
DEFINE
  lo_return T_DZIV_T_WL

  LET lo_dziv_t.* = p_dziv_t.*
  
  LOCATE lo_dziv_t.DZIV004 IN FILE

  CALL sadzi200_db_get_template_contents(lo_dziv_t.*) RETURNING ls_scripts  
  LET lo_dziv_t.DZIV004 = ls_scripts
  
  LET lo_return.* = lo_dziv_t.*

  RETURN lo_return.*  

END FUNCTION

FUNCTION sadzi200_db_get_template_contents(p_dziv_t)
DEFINE
  p_dziv_t  T_DZIV_T_WL
DEFINE
  lo_dziv_t     T_DZIV_T_WL,
  lo_dziv004    LIKE DZIV_T.DZIV004,
  lo_str_buf    base.StringBuffer,
  ls_sql        STRING,
  ls_mdm_name   STRING,
  ls_erp_name   STRING,
  li_rec_count  INTEGER
DEFINE
  ls_return  STRING

  LET lo_dziv_t.* = p_dziv_t.*

  LET lo_str_buf = base.StringBuffer.create()
  CALL lo_str_buf.Clear()
  
  LOCATE lo_dziv004 IN FILE
  
  #取得樣板資料
  LET ls_sql = "SELECT IT.DZIV004                           ",
               "  FROM DZIV_T IT                            ",
               " WHERE IT.DZIV001 = '",lo_dziv_t.DZIV001,"' ",
               "   AND IT.DZIV002 = '",lo_dziv_t.DZIV002,"' ",
               "   AND IT.DZIV003 = '",cs_template_words,"' ",
               --"   AND IT.DZIV004 = '",cs_dgenv_standard,",",cs_dgenv_customize,"' "
               "   AND IT.DZIV004 = '",lo_dziv_t.DZIV004,"' "
 
  PREPARE lpre_get_template_contents FROM ls_sql
  DECLARE lcur_get_template_contents CURSOR FOR lpre_get_template_contents
  OPEN lcur_get_template_contents
  FETCH lcur_get_template_contents INTO lo_dziv004
  CLOSE lcur_get_template_contents
  FREE lcur_get_template_contents
  FREE lpre_get_template_contents

  LET ls_return = lo_dziv004
  FREE lo_dziv004

  CALL sadzi200_util_get_mdmdb_name(lo_dziv_t.DZIV003) RETURNING ls_mdm_name
  CALL sadzi200_util_get_erpdb_name(lo_dziv_t.DZIV003) RETURNING ls_erp_name
  CALL lo_str_buf.append(ls_return)
  CALL lo_str_buf.replace(cs_identify_mdm_db,ls_mdm_name,0)  
  CALL lo_str_buf.replace(cs_identify_erp_db,ls_erp_name,0)  
  CALL lo_str_buf.toString() RETURNING ls_return  

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi200_db_load_template_data(p_dziv_t,p_lang)
DEFINE
  p_dziv_t  T_DZIV_T_WL,
  p_lang    STRING 
DEFINE
  lo_dziv_t      T_DZIV_T_WL,
  ls_lang        STRING, 
  lo_temp_dziv_t T_DZIV_T_WL,
  ls_sql         STRING,
  li_rec_count   INTEGER
DEFINE
  lo_return  T_DZIV_T_WL

  LET lo_dziv_t.* = p_dziv_t.*
  LET ls_lang = p_lang

  LOCATE lo_temp_dziv_t.DZIV004 IN FILE
  
  #取得樣板資料
  LET ls_sql = "SELECT IV.DZIV001,IV.DZIV002,IV.DZIV003,IV.DZIV004,IV.DZIV005,   ",
               "       IVL.DZIVL005,IVL.DZIVL006                                 ", 
               "  FROM DZIV_T IV                                                 ",
               "  LEFT OUTER JOIN DZIVL_T IVL ON IVL.DZIVL001 = IV.DZIV001       ",
               "                             AND IVL.DZIVL002 = IV.DZIV002       ",
               "                             AND IVL.DZIVL003 = IV.DZIV003       ",
               "                             AND IVL.DZIVL004 = '",ls_lang,"'    ", 
               " WHERE 1=1                                                       ",
               "   AND IV.DZIV001 = '",lo_dziv_t.DZIV001,"'                      ",
               "   AND IV.DZIV002 = '",cs_template_words,"'                      ",
               "   AND IV.DZIV003 = '",lo_dziv_t.DZIV003,"'                      "
               
  PREPARE lpre_load_template_data FROM ls_sql
  DECLARE lcur_load_template_data CURSOR FOR lpre_load_template_data
  OPEN lcur_load_template_data
  FETCH lcur_load_template_data INTO lo_temp_dziv_t.*
  CLOSE lcur_load_template_data
  FREE lcur_load_template_data
  FREE lpre_load_template_data

  LET lo_return.* = lo_temp_dziv_t.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi200_db_get_connection_list()
DEFINE
  ls_sql        STRING,
  li_rec_cnt    INTEGER,         
  lo_coxn_info  DYNAMIC ARRAY OF T_DB_COXN_STR
DEFINE  
  lo_return DYNAMIC ARRAY OF T_DB_COXN_STR

  LET li_rec_cnt = 1
  
  LET ls_sql = "SELECT EJ.DZEJ005 DB_SID,                              ",
               "       DA.GZDA001 DB_NAME,                             ",
               "       DA.GZDA003 DB_USERNAME,                         ",
               "       DA.GZDA004 DB_PASSWORD,                         ",
               "       ''         DB_DB_LINK,                          ",
               "       ''         DB_SQL_FILENAME                      ",
               "  FROM DZEJ_T EJ                                       ",
               "  LEFT OUTER JOIN GZDA_T DA ON DA.GZDA001 = EJ.DZEJ005 ",
               " WHERE EJ.DZEJ001 = 'adzi200_parameters'               ",
               "   AND EJ.DZEJ004 = 'MasterDB'                         ",
               "UNION                                                  ",
               "SELECT EJ.DZEJ007 DB_SID,                              ",
               "       DA.GZDA001 DB_NAME,                             ",
               "       DA.GZDA003 DB_USERNAME,                         ",
               "       DA.GZDA004 DB_PASSWORD,                         ",
               "       ''         DB_DB_LINK,                          ",
               "       ''         DB_SQL_FILENAME                      ",
               "  FROM DZEJ_T EJ                                       ",
               "  LEFT OUTER JOIN GZDA_T DA ON DA.GZDA001 = EJ.DZEJ007 ",
               " WHERE EJ.DZEJ001 = 'adzi180_parameters'               ",
               "   AND EJ.DZEJ004 IN ('ERPDB','MDMDB')                 ",
               " ORDER BY 1                                            "
                              
  PREPARE lpre_get_connection_list FROM ls_sql
  DECLARE lcur_get_connection_list CURSOR FOR lpre_get_connection_list

  OPEN lcur_get_connection_list
  FOREACH lcur_get_connection_list INTO lo_coxn_info[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_connection_list
  CALL lo_coxn_info.deleteElement(li_rec_cnt)
  
  FREE lpre_get_connection_list
  FREE lcur_get_connection_list  

  LET lo_return.* = lo_coxn_info.*
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi200_db_get_connection_queue(p_coxn_info)
DEFINE
  p_coxn_info  DYNAMIC ARRAY OF T_DB_COXN_STR
DEFINE
  li_count     INTEGER,   
  ls_coxn_info STRING,  
  lo_coxn_info DYNAMIC ARRAY OF T_DB_COXN_STR
DEFINE
  ls_return STRING  
  
  LET lo_coxn_info = p_coxn_info

  LET ls_coxn_info = ""
  
  IF lo_coxn_info.getLength() > 1 THEN 
    FOR li_count = 1 TO lo_coxn_info.getLength()
      LET ls_coxn_info = ls_coxn_info,",",lo_coxn_info[li_count].db_sid 
    END FOR
  END IF   

  LET ls_return = ls_coxn_info

  RETURN ls_return

END FUNCTION

FUNCTION sadzi200_db_get_db_sid_list(p_coxn_info)
DEFINE
  p_coxn_info  DYNAMIC ARRAY OF T_DB_COXN_STR
DEFINE
  lo_coxn_info   DYNAMIC ARRAY OF T_DB_COXN_STR,
  li_count       INTEGER,
  li_idx1        INTEGER, 
  lo_column_list DYNAMIC ARRAY OF T_COLUMN_LIST  
DEFINE
  lo_return DYNAMIC ARRAY OF T_COLUMN_LIST  
  
  LET lo_coxn_info = p_coxn_info

  CALL lo_column_list.clear()
  
  IF lo_coxn_info.getLength() > 1 THEN
    LET li_idx1 = 1
    FOR li_count = 1 TO lo_coxn_info.getLength()
      IF lo_coxn_info[li_count].db_sid == "ds" OR 
         lo_coxn_info[li_count].db_sid == "dsdata" OR
         lo_coxn_info[li_count].db_sid == "dsdemo" THEN
        #do nothing , 將資料庫ds,dsdata,dsdemo隱藏  #0160314 add by circlelai
      ELSE 
        LET lo_column_list[li_idx1].COLUMN_NAME = lo_coxn_info[li_count].db_sid
        LET lo_column_list[li_idx1].COLUMN_NAME = lo_coxn_info[li_count].db_sid
        LET li_idx1 = li_idx1 + 1
      END IF
    END FOR
  END IF   

  LET lo_return = lo_column_list

  RETURN lo_return

END FUNCTION