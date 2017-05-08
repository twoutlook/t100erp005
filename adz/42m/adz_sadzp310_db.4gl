&include "../4gl/sadzp310_mcr.inc"

IMPORT util
IMPORT OS 
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"

&include "../4gl/sadzp310_type.inc"

DEFINE
  mo_columns_data_in_mem  DYNAMIC ARRAY OF T_COLUMNS_DATA_IN_MEM

FUNCTION sadzp310_db_connect_db(p_db)
DEFINE 
  p_db STRING

  TRY
    DISCONNECT CURRENT
  CATCH
    DISPLAY cs_warning_tag,"No any connection, skip disconnect."
  END TRY  
  
  CONNECT TO p_db
  
END FUNCTION

FUNCTION sadzp310_db_get_db_info()
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

FUNCTION sadzp310_db_get_db_connect_string(p_db_name)
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

FUNCTION sadzp310_db_sqlplus(p_db_connstr)
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

  CALL sadzp310_db_run_and_catch_log(ls_sqlplus_str) RETURNING ls_message
  CALL sadzp310_db_gen_log_file(ls_Message) RETURNING ls_log_file

  LET ls_file_list = ls_file_list,"SQL File : ",lo_DB_CONNSTR.db_sql_filename,"\n"
  LET ls_file_list = ls_file_list,"Log File : ",ls_log_file,"\n"
  LET ls_file_list = ls_file_list,ls_message
  
  LET ls_return = ls_file_list
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzp310_db_run_and_catch_log(p_command)
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

FUNCTION sadzp310_db_gen_log_file(p_log)
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
  
  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID
  
  LET ls_log_filename = ls_temp_dir,ls_separator,"sadzp310_db_",ls_GUID,".log"
  
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
    DISPLAY cs_error_tag,"Generate log Error : ",ls_log_filename
  END TRY  

  LET ls_return = ls_log_filename

  RETURN ls_return

END FUNCTION

FUNCTION sadzp310_db_exec_SQL(p_sql)
DEFINE
  p_sql STRING
DEFINE
  ls_sql         STRING,
  ls_replace_arg STRING
DEFINE
  lb_return BOOLEAN 

  LET ls_sql = p_sql

  LET lb_return = TRUE
  
  BEGIN WORK

  TRY
    PREPARE lpre_exec_sql FROM ls_sql
    EXECUTE lpre_exec_sql
    COMMIT WORK
  CATCH
    LET lb_return = FALSE
    ROLLBACK WORK
  END TRY  

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp310_db_exec_SQL_no_commit(p_sql)
DEFINE
  p_sql STRING
DEFINE
  ls_sql         STRING,
  ls_replace_arg STRING
DEFINE
  lb_return BOOLEAN 
  
  LET ls_sql = p_sql

  LET lb_return = TRUE
  
  TRY
    PREPARE lpre_exec_SQL_no_commit FROM ls_sql
    EXECUTE lpre_exec_SQL_no_commit
  CATCH
    LET lb_return = FALSE
  END TRY  

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp310_db_get_parameter(p_level,p_param)
DEFINE
  p_level STRING,
  p_param STRING
DEFINE
  ls_level     STRING,
  ls_param     STRING,
  ls_sql       STRING,
  lv_parameter VARCHAR(1024) 
DEFINE
  ls_return    STRING

  LET ls_level = p_level
  LET ls_param = p_param

  LET ls_sql = "SELECT EJ.DZEJ005                        ",
               "  FROM DZEJ_T EJ                         ",
               " WHERE EJ.DZEJ001 = 'adzi140_parameters' ", -- 暫時和 r.t 共用 
               "   AND EJ.DZEJ003 = '",ls_level,"'       ",
               "   AND EJ.DZEJ004 = '",ls_param,"'       "
                              
  PREPARE lpre_get_parameter FROM ls_sql
  DECLARE lcur_get_parameter CURSOR FOR lpre_get_parameter

  OPEN lcur_get_parameter
  FETCH lcur_get_parameter INTO lv_parameter
  CLOSE lcur_get_parameter
  
  FREE lpre_get_parameter
  FREE lcur_get_parameter  

  LET ls_return = lv_parameter
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp310_db_get_column_data_to_mem(p_owner,p_table_name)
DEFINE
  p_owner       STRING,
  p_table_name  STRING
DEFINE
  lo_columns_data_in_mem DYNAMIC ARRAY OF T_COLUMNS_DATA_IN_MEM
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  lo_return DYNAMIC ARRAY OF T_COLUMNS_DATA_IN_MEM

  LET ls_owner       = p_owner
  LET ls_table_name  = p_table_name
  
  LET li_rec_cnt = 1

  LET ls_sql = " SELECT ATC.OWNER                            OWNER,                                       ",
               "        ATC.TABLE_NAME                       TABLE_NAME,                                  ",
               "        ATC.COLUMN_NAME                      COLUMN_NAME,                                 ",
               "        DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                                       ",
               "        ATC.NULLABLE                         NULLABLE,                                    ",
               "        DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE,  ",
               "        REPLACE(TO_CHAR(DECODE(                                                           ",
               "                ATC.DATA_TYPE,                                                            ",
               "                'NUMBER',DECODE(                                                          ",
               "                                 ATC.DATA_SCALE,                                          ",
               "                                 '0',ATC.DATA_PRECISION,                                  ",
               "                                 ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE                  ",
               "                               ),                                                         ",
               "                ATC.DATA_LENGTH                                                           ",
               "              )),'.',',')                    DATA_LENGTH,                                 ",
               "        TRIM(DS.GET_COL_DEFAULT(ATC.TABLE_NAME,ATC.COLUMN_NAME)) DEFAULT_VALUE            ",
               "   FROM DBA_TAB_COLUMNS ATC                                                               ",
               "   LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER                    ",
               "                                       AND ACC.TABLE_NAME  = ATC.TABLE_NAME               ",
               "                                       AND ACC.COLUMN_NAME = ATC.COLUMN_NAME              ",
               "                                       AND ACC.CONSTRAINT_NAME LIKE '%PK'                 ",
               "  WHERE 1=1                                                                               ",
               "    AND ATC.OWNER       = '",ls_owner.toUpperCase(),"'                                    ",
               "    AND ATC.TABLE_NAME  = '",ls_table_name.toUpperCase(),"'                               ",
               "    AND ATC.COLUMN_NAME NOT LIKE 'SYS%'                                                   ",
               "  ORDER BY 1,2,3                                                                          "
                
  PREPARE lpre_get_columns_data_to_mem FROM ls_sql
  DECLARE lcur_get_columns_data_to_mem CURSOR FOR lpre_get_columns_data_to_mem

  OPEN lcur_get_columns_data_to_mem
  FOREACH lcur_get_columns_data_to_mem INTO lo_columns_data_in_mem[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET li_rec_cnt = li_rec_cnt + 1
    
  END FOREACH
  CLOSE lcur_get_columns_data_to_mem
  CALL lo_columns_data_in_mem.deleteElement(li_rec_cnt)
  
  FREE lpre_get_columns_data_to_mem
  FREE lcur_get_columns_data_to_mem  
  
  LET lo_return = lo_columns_data_in_mem
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzp310_db_get_db_column_data(p_owner,p_table_name,p_column_name)
DEFINE
  p_owner       STRING,
  p_table_name  STRING,
  p_column_name STRING
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_column_name STRING,
  lo_db_column_data  T_COLUMN_DATA,
  li_loop            INTEGER
DEFINE
  lo_return T_COLUMN_DATA

  LET ls_owner       = p_owner
  LET ls_table_name  = p_table_name
  LET ls_column_name = p_column_name

  FOR li_loop = 1 TO mo_columns_data_in_mem.getLength()
    IF mo_columns_data_in_mem[li_loop].OWNER       = ls_owner AND
       mo_columns_data_in_mem[li_loop].TABLE_NAME  = ls_table_name AND
       mo_columns_data_in_mem[li_loop].COLUMN_NAME = ls_column_name THEN

       LET lo_db_column_data.COLUMN_NAME   = mo_columns_data_in_mem[li_loop].COLUMN_NAME  
       LET lo_db_column_data.ISKEY         = mo_columns_data_in_mem[li_loop].ISKEY        
       LET lo_db_column_data.NULLABLE      = mo_columns_data_in_mem[li_loop].NULLABLE     
       LET lo_db_column_data.DATA_TYPE     = mo_columns_data_in_mem[li_loop].DATA_TYPE    
       LET lo_db_column_data.DATA_LENGTH   = mo_columns_data_in_mem[li_loop].DATA_LENGTH  
       LET lo_db_column_data.DEFAULT_VALUE = mo_columns_data_in_mem[li_loop].DEFAULT_VALUE
       
       EXIT FOR
       
    END IF   
  END FOR 

  LET lo_return.* = lo_db_column_data.*
  
  RETURN lo_return.*

END FUNCTION 

FUNCTION sadzp310_db_get_design_column_data(p_jsonobj)
  DEFINE
    p_jsonobj     util.JSONObject 
    #傳入參數 "owner", "tablename", "stand_cust", "col_name"
  DEFINE
    lo_design_column_data T_COLUMN_DATA
  DEFINE
    ls_owner       STRING,
    ls_table_name  STRING,
    ls_column_name STRING,
    ls_stand_cust  STRING,
    ls_where       STRING,
    ls_sql         STRING,
    ls_exec_sql    STRING,
    li_rec_cnt     INTEGER,
    ls_alter_table VARCHAR(30)
  DEFINE
    lo_return T_COLUMN_DATA

  LET ls_owner       = IIF (p_jsonobj.has("owner"), p_jsonobj.get("owner"), NULL )
  LET ls_table_name  = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL )
  LET ls_column_name = IIF (p_jsonobj.has("col_name"), p_jsonobj.get("col_name"), NULL )
  LET ls_stand_cust  = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL )

  LET ls_where = " WHERE IB.DZIB001 = '", ls_table_name.toLowerCase(), "'  ",
                 "   AND IB.DZIB002 = '", ls_column_name.toLowerCase(), "' "
  IF (ls_stand_cust IS NOT NULL) AND 
     (ls_stand_cust = cs_dgenv_cust OR 
      ls_stand_cust = cs_dgenv_stand) THEN
    LET ls_where = ls_where, " AND IB.DZIB029 = '", ls_stand_cust, "' "
  END IF
  
  LET li_rec_cnt = 0

  LET ls_sql = " SELECT UPPER(IB.DZIB002)                      COLUMN_NAME,  ",
               "        IB.DZIB004                             ISKEY,        ",
               "        DECODE(IB.DZIB004,'Y','N','N','Y','Y') NULLABLE,     ",
               "        UPPER(TD.GZTD003)                      DATA_TYPE,    ",
               "        REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(           ",
               "        DECODE(                                              ",
               "               UPPER(TD.GZTD003),                            ",
               "               'BLOB','4000',                                ",
               "               'CLOB','4000',                                ",
               "               'DATE','7',                                   ",
               "               'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),  ",
               "               TD.GZTD008                                    ",
               "              ),',','.'),' ',''))),'.',',')    DATA_LENGTH,  ",
               "        TRIM(IB.DZIB012)                       DEFAULT_VALUE ",
               "   FROM DZIB_T IB                                            ",
               "        LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = IB.DZIB006 ",
               ls_where,
               "  ORDER BY 1                                                 "
                
  PREPARE lpre_get_design_column_data FROM ls_sql
  DECLARE lcur_get_design_column_data CURSOR FOR lpre_get_design_column_data

  OPEN lcur_get_design_column_data
  FETCH lcur_get_design_column_data INTO lo_design_column_data.*
  CLOSE lcur_get_design_column_data
  
  FREE lpre_get_design_column_data
  FREE lcur_get_design_column_data  
  
  LET lo_return.* = lo_design_column_data.*
  
  RETURN lo_return.*
  
END FUNCTION 

FUNCTION sadzp310_db_check_db_column_exist(p_owner,p_table_name,p_column_name)
DEFINE
  p_owner       STRING,
  p_table_name  STRING,
  p_column_name STRING
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_column_name STRING,
  lb_rec_exist   BOOLEAN,
  li_loop        INTEGER,
  lb_return      BOOLEAN

  LET ls_owner       = p_owner.toUpperCase()
  LET ls_table_name  = p_table_name.toUpperCase()
  LET ls_column_name = p_column_name.toUpperCase()

  LET lb_rec_exist = FALSE
  
  FOR li_loop = 1 TO mo_columns_data_in_mem.getLength()
    IF mo_columns_data_in_mem[li_loop].OWNER       = ls_owner AND
       mo_columns_data_in_mem[li_loop].TABLE_NAME  = ls_table_name AND
       mo_columns_data_in_mem[li_loop].COLUMN_NAME = ls_column_name THEN

       LET lb_rec_exist = TRUE
       
       EXIT FOR
       
    END IF   
  END FOR  
  
  LET lb_return = lb_rec_exist
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp310_db_get_alter_column_sql(p_jsonobj, p_diff_columns)
  DEFINE 
    p_jsonobj      util.JSONObject, 
    #傳入參數 "owner", "tablename", "stand_cust"
    p_diff_columns  DYNAMIC ARRAY OF T_DIFF_COLUMNS 
  DEFINE
    lo_jsonobj        util.JSONObject,
    lo_diff_columns   DYNAMIC ARRAY OF T_DIFF_COLUMNS,
    lo_alter_columns  DYNAMIC ARRAY OF T_COLUMN_ALTER,
    lo_db_column_data     T_COLUMN_DATA,
    lo_design_column_data T_COLUMN_DATA,
    li_loop           INTEGER,
    li_rec_cnt        INTEGER,
    lb_column_exist   BOOLEAN,
    ls_table_owner    STRING,
    ls_table_name     STRING,
    ls_stand_cust     STRING,
    ls_columns        STRING,
    ls_sql            STRING,
    ls_where          STRING,
    ls_alter_type     STRING,
    ls_alter_script   STRING,
    ls_alter_sql      STRING,
    ls_data_type      STRING,
    ls_default        STRING,
    ls_lob_tablespace STRING,
    ls_rebuild_index_list STRING
  DEFINE 
    ls_return      STRING
  
  LET ls_table_owner = IIF (p_jsonobj.has("owner"), p_jsonobj.get("owner"), NULL )
  LET ls_table_name  = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL )
  LET ls_stand_cust  = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL)

  LET lo_diff_columns.* = p_diff_columns.*
  LET lo_jsonobj = p_jsonobj
  
  LET ls_alter_type   = ""
  LET ls_alter_script = ""
  LET ls_alter_sql    = ""

  INITIALIZE mo_columns_data_in_mem TO NULL 

  #取得 LOB 型態欄位的Tablespace
  CALL sadzp310_db_get_parameter(cs_param_level_lob,cs_param_tablespace) RETURNING ls_lob_tablespace
  CALL sadzp310_db_get_column_data_to_mem(ls_table_owner,ls_table_name) RETURNING mo_columns_data_in_mem
  
  FOR li_loop = 1 TO lo_diff_columns.getLength()
    LET ls_columns = ls_columns,",'",lo_diff_columns[li_loop].DZIB002,"'"
  END FOR

  LET ls_columns = ls_columns.subString(2,ls_columns.getLength())
  LET ls_where = " WHERE IB.DZIB001 = '",ls_table_name.toLowerCase(),"' ",
                 "   AND IB.DZIB002 IN (",ls_columns.toLowerCase(), ")  "
  IF (ls_stand_cust IS NOT NULL) AND 
     (ls_stand_cust = cs_dgenv_cust OR 
      ls_stand_cust = cs_dgenv_stand) THEN
    LET ls_where = ls_where, " AND IB.DZIB029 = '", ls_stand_cust, "' "
  END IF 

  LET ls_sql = "SELECT UPPER(IB.DZIB002)                      DZIB002,       ",
               "       IB.DZIB004                             DZIB004,       ",
               "       DECODE(IB.DZIB004,'Y','N','N','Y','Y') DZIB005,       ",
               "       UPPER(TD.GZTD003)                      DZIB007,       ",
               "       DECODE(                                               ",
               "              UPPER(TD.GZTD003),                             ",
               "              'BLOB','4000',                                 ",
               "              'CLOB','4000',                                 ",
               "              'DATE','7',                                    ",
               "              TD.GZTD008                                     ",
               "             )                                DZIB008,       ",
               "       TRIM(IB.DZIB012)                       DZIB012        ",  --預設值
               "  FROM DZIB_T IB                                             ",
               "  LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = IB.DZIB006  ", 
               ls_where,
               " ORDER BY IB.DZIB021                                         "
               
  PREPARE lpre_get_alter_column_sql FROM ls_sql
  DECLARE lcur_get_alter_column_sql CURSOR FOR lpre_get_alter_column_sql

  LET li_rec_cnt = 1
  
  OPEN lcur_get_alter_column_sql
  FOREACH lcur_get_alter_column_sql INTO lo_alter_columns[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    #取得欄位資料
    CALL lo_jsonobj.put("col_name", lo_alter_columns[li_rec_cnt].DZIB002)
    CALL sadzp310_db_get_db_column_data(ls_table_owner, ls_table_name, lo_alter_columns[li_rec_cnt].DZIB002) 
         RETURNING lo_db_column_data.*
    CALL sadzp310_db_get_design_column_data(lo_jsonobj) RETURNING lo_design_column_data.* 

    #查看看欄位是否存在, 若存在, 則做Modify, 否則做 Add
    CALL sadzp310_db_check_db_column_exist(ls_table_owner,ls_table_name,lo_alter_columns[li_rec_cnt].DZIB002) 
         RETURNING lb_column_exist
    IF lb_column_exist THEN
      LET ls_alter_type = cs_alter_type_modify
    ELSE 
      LET ls_alter_type = cs_alter_type_add
    END IF

    #設定Data Type
    IF (lo_db_column_data.DATA_TYPE <> lo_design_column_data.DATA_TYPE) OR 
       (NVL(lo_db_column_data.DATA_LENGTH,cs_null_default) <> NVL(lo_design_column_data.DATA_LENGTH,cs_null_default)) THEN
    
      IF (lo_alter_columns[li_rec_cnt].DZIB007 = 'DATE') 
         OR (lo_alter_columns[li_rec_cnt].DZIB007 = 'CLOB') 
         OR (lo_alter_columns[li_rec_cnt].DZIB007 = 'BLOB') THEN
        LET ls_data_type = lo_alter_columns[li_rec_cnt].DZIB007
      ELSE      
        LET ls_data_type = lo_alter_columns[li_rec_cnt].DZIB007,"(",lo_alter_columns[li_rec_cnt].DZIB008,")"
      END IF

      LET ls_alter_script = "ALTER TABLE",cs_SPACE,
                            ls_table_name,cs_SPACE,
                            ls_alter_type,cs_SPACE,
                            lo_alter_columns[li_rec_cnt].DZIB002,cs_SPACE,
                            ls_data_type,
                            ";","\n"

      LET ls_alter_sql = ls_alter_sql,ls_alter_script
    END IF 

    #設定預設值
    IF (NVL(lo_db_column_data.DEFAULT_VALUE,cs_null_default) <> NVL(lo_design_column_data.DEFAULT_VALUE,cs_null_default)) THEN
      LET ls_alter_type = cs_alter_type_modify
      IF NVL(lo_alter_columns[li_rec_cnt].DZIB012,cs_null_default) <> cs_null_default THEN 
        CASE UPSHIFT(lo_alter_columns[li_rec_cnt].DZIB007)
          WHEN "BLOB"
            LET ls_default = "default",cs_SPACE,lo_alter_columns[li_rec_cnt].DZIB012
          WHEN "CLOB"
            LET ls_default = "default",cs_SPACE,lo_alter_columns[li_rec_cnt].DZIB012
          WHEN "DATE"
            LET ls_default = "default",cs_SPACE,lo_alter_columns[li_rec_cnt].DZIB012
          WHEN "NUMBER"
            LET ls_default = "default",cs_SPACE,lo_alter_columns[li_rec_cnt].DZIB012
          WHEN "TIMESTAMP"
            LET ls_default = "default",cs_SPACE,lo_alter_columns[li_rec_cnt].DZIB012
          WHEN "VARCHAR2"
            LET ls_default = "default",cs_SPACE,lo_alter_columns[li_rec_cnt].DZIB012
        END CASE 
      ELSE
        LET ls_default = "default NULL"
      END IF 
      
      LET ls_alter_script = "ALTER TABLE",cs_SPACE,
                            ls_table_name,cs_SPACE,
                            ls_alter_type,cs_SPACE,
                            lo_alter_columns[li_rec_cnt].DZIB002,cs_SPACE,
                            ls_default,
                            ";","\n"

      LET ls_alter_sql = ls_alter_sql,ls_alter_script
    END IF  

    #判斷為 LOB 型態的欄位, 將之移到 DSBLOB Tablespace
    IF ((lo_alter_columns[li_rec_cnt].DZIB007 = 'CLOB') OR (lo_alter_columns[li_rec_cnt].DZIB007 = 'BLOB')) THEN
      #Ex. ALTER TABLE DS.DZAB_T MOVE LOB(DZAB099) STORE AS (TABLESPACE BLOBDATA); 
      LET ls_alter_script = "ALTER TABLE",cs_SPACE,
                            ls_table_name,cs_SPACE,
                            "MOVE LOB(",lo_alter_columns[li_rec_cnt].DZIB002,")",cs_SPACE,
                            "STORE AS (TABLESPACE ",ls_lob_tablespace,")",
                            ";","\n"
                           
      LET ls_alter_sql = ls_alter_sql,ls_alter_script

      {
      #新增/異動 BLOB,CLOB 時要重建該表格相關 Index 
      CALL sadzp310_db_get_rebuild_index_list(ls_table_name) RETURNING ls_rebuild_index_list
      LET ls_alter_sql = ls_alter_sql,ls_rebuild_index_list
      }
      
    END IF    

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_alter_column_sql
  CALL lo_alter_columns.deleteElement(li_rec_cnt)
  
  FREE lpre_get_alter_column_sql
  FREE lcur_get_alter_column_sql  

  LET ls_return = ls_alter_sql
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp310_db_get_drop_column_sql(p_jsonobj, p_diff_columns)
  DEFINE 
    p_jsonobj      util.JSONObject, #參數 "owner", "tablename", "stand_cust"
    p_diff_columns DYNAMIC ARRAY OF T_DIFF_COLUMNS 
  DEFINE 
    lo_diff_columns  DYNAMIC ARRAY OF T_DIFF_COLUMNS,
    lo_alter_columns DYNAMIC ARRAY OF T_DIFF_COLUMNS,
    li_loop          INTEGER,
    li_rec_cnt       INTEGER,
    lb_column_exist  BOOLEAN,
    ls_table_owner   STRING,
    ls_table_name    STRING,
    ls_stand_cust    STRING,
    ls_columns       STRING,
    ls_sql           STRING,
    ls_where         STRING,
    ls_where2        STRING, 
    ls_alter_type    STRING,
    ls_alter_script  STRING,
    ls_alter_sql     STRING,
    ls_data_type     STRING
  DEFINE  
    ls_return      STRING 
  
  LET ls_table_owner    = IIF (p_jsonobj.has("owner"), p_jsonobj.get("owner"), NULL )
  LET ls_table_name     = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL )
  LET ls_stand_cust     = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL )
  LET lo_diff_columns.* = p_diff_columns.*

  LET ls_alter_type   = ""
  LET ls_alter_script = ""
  LET ls_alter_sql    = ""
  
  FOR li_loop = 1 TO lo_diff_columns.getLength()
    LET ls_columns = ls_columns,",'",lo_diff_columns[li_loop].DZIB002,"'"
  END FOR

  LET ls_columns = ls_columns.subString(2,ls_columns.getLength())
  LET ls_where = " AND ATC.COLUMN_NAME IN (",ls_columns.toUpperCase(),")"

  LET ls_where2 = " WHERE IB.DZIB001 = LOWER(ATC.TABLE_NAME)  ",
                  "   AND IB.DZIB002 = LOWER(ATC.COLUMN_NAME) "
  IF (ls_stand_cust IS NOT NULL) AND 
      (ls_stand_cust = cs_dgenv_cust OR 
       ls_stand_cust = cs_dgenv_stand) THEN
    LET ls_where2 = ls_where2, " AND IB.DZIB029 = '", ls_stand_cust, "' "
  END IF
  
  LET ls_sql = "SELECT ATC.COLUMN_NAME                      DZIB002,                        ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') DZIB004,                        ",
               "       ATC.NULLABLE                         DZIB005,                        ",
               "       ATC.DATA_TYPE                        DZIB007,                        ",
               "       TO_CHAR(DECODE(                                                      ",
               "               ATC.DATA_TYPE,                                               ",
               "               'NUMBER',DECODE(                                             ",
               "                                ATC.DATA_SCALE,                             ",
               "                                '0',ATC.DATA_PRECISION,                     ",
               "                                ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE     ",
               "                              ),                                            ",
               "               ATC.DATA_LENGTH                                              ",
               "             ))                             DZIB008                         ",
               "  FROM DBA_TAB_COLUMNS ATC                                                  ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER       ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME  ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'    ",
               " WHERE 1=1                                                                  ",
               ls_where,
               "   AND NOT EXISTS (                                                         ",
               "                    SELECT 1 FROM DZIB_T IB                                 ",
               ls_where2,
               "                  )                                                         ",  
               "   AND ATC.OWNER      = '",ls_table_owner.toUpperCase(),"'                  ",
               "   AND ATC.TABLE_NAME = '",ls_table_name.toUpperCase(),"'                   "
  
  PREPARE lpre_get_drop_column_sql FROM ls_sql
  DECLARE lcur_get_drop_column_sql CURSOR FOR lpre_get_drop_column_sql

  LET li_rec_cnt = 1
  
  OPEN lcur_get_drop_column_sql
  FOREACH lcur_get_drop_column_sql INTO lo_alter_columns[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_alter_script = "ALTER TABLE ",
                         ls_table_name,
                         " DROP COLUMN ",
                         lo_alter_columns[li_rec_cnt].DZIB002,
                         ";","\n"

    LET ls_alter_sql = ls_alter_sql,ls_alter_script
    
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_drop_column_sql
  CALL lo_alter_columns.deleteElement(li_rec_cnt)
  
  FREE lpre_get_drop_column_sql
  FREE lcur_get_drop_column_sql  

  LET ls_return = ls_alter_sql
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp310_db_get_create_dummy_table_sql(p_table_schema)
DEFINE 
  p_table_schema  T_TABLE_METADATA 
DEFINE
  lo_table_schema T_TABLE_METADATA,
  ls_sql          STRING,
  ls_table_space  STRING,
  ls_comment      STRING,
  ls_return       STRING

  LET lo_table_schema.* = p_table_schema.* 

  LET ls_sql = ""
  
  LET ls_table_space = ""
  LET ls_comment     = ""

  #指定 Tablespace 
  IF NVL(lo_table_schema.ts_TABLE_SPACE  CLIPPED,cs_null_value) <> cs_null_value AND lo_table_schema.ts_TABLE_SPACE CLIPPED <> ""
     AND lo_table_schema.ts_TABLE_SPACE CLIPPED <> " " THEN
    LET ls_table_space = "TABLESPACE ",
                        lo_table_schema.ts_TABLE_SPACE
  END IF

  LET ls_sql = "CREATE TABLE"," ",
               lo_table_schema.ts_TABLE_NAME," ",
               ls_table_space," ", 
               "AS SELECT * FROM DUMMY WHERE 1=2",
               ";"

  #Table的說明             
  IF NOT NVL(lo_table_schema.ts_COMMENT,cs_null_value) = cs_null_value THEN
    LET ls_comment = "COMMENT ON TABLE ",lo_table_schema.ts_TABLE_NAME,"  IS '",lo_table_schema.ts_COMMENT,"'",
                     ";"
  END IF

  LET ls_return = ls_sql,"\n",
                  ls_comment 
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp310_db_check_table_exist(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  ls_owner      STRING,
  ls_table_name STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  lb_return     BOOLEAN

  LET ls_owner      = NVL(p_owner.toUpperCase(),cs_master_user.toUpperCase())
  LET ls_table_name = p_table_name.toUpperCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                             ",
               "  FROM DBA_OBJECTS DOS                      ",
               " WHERE DOS.OWNER = '",ls_owner,"'           ",
               "   AND DOS.OBJECT_TYPE = 'TABLE'            ",
               "   AND DOS.OBJECT_NAME = '",ls_table_name,"'"

  PREPARE lpre_check_table_exist FROM ls_sql
  DECLARE lcur_check_table_exist CURSOR FOR lpre_check_table_exist
  OPEN lcur_check_table_exist
  FETCH lcur_check_table_exist INTO li_rec_count
  CLOSE lcur_check_table_exist
  FREE lcur_check_table_exist
  FREE lpre_check_table_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp310_db_get_table_metadata(p_owner,p_table_name)
DEFINE 
  p_owner      STRING,
  p_table_name STRING
DEFINE
  ls_owner        STRING,
  ls_table_name   STRING,
  ls_sql          STRING,
  lo_table_schema T_TABLE_METADATA
DEFINE  
  lo_return T_TABLE_METADATA

  LET ls_owner = p_owner
  LET ls_table_name = p_table_name
  
  LET ls_sql = "SELECT '",ls_owner.toUpperCase(),"' OWNER,       ",
               "       IA.DZIA001                   TABLE_NAME,  ",
               "       IA.DZIA010                   TABLE_SPACE, ",
               "       IA.DZIA002                   COMMANT      ",
               "  FROM DZIA_T IA                                 ",
               " INNER JOIN (                                            ", #客製與標準數據同時存在時取客制數據
               "       SELECT DISTINCT IA1.DZIA001 AS DZIA001_1,         ",
               "         CASE WHEN                                       ",
               "              EXISTS (                                   ",
               "                     SELECT 1 FROM DZIA_T IA2            ",
               "                      WHERE IA2.DZIA001 = IA1.DZIA001    ",
               "                        AND IA2.DZIA015='c'              ", 
               "              )                                          ",
               "              THEN 'c'                                   ",
               "              ELSE 's'                                   ",
               "          END AS DZIA015_1                               ",
               "         FROM (SELECT IA0.DZIA001, IA0.DZIA015           ",
               "                 FROM DZIA_T IA0                         ",
               "              ) IA1                                      ",
               " ) IA2 ON IA.DZIA001 = IA2.DZIA001_1                     ",
               "      AND IA.DZIA015 = IA2.DZIA015_1                     ",
               " WHERE IA.DZIA001 = '",ls_table_name,"'          " 
                               
  PREPARE lpre_get_table_metadata FROM ls_sql
  DECLARE lcur_get_table_metadata CURSOR FOR lpre_get_table_metadata

  OPEN lcur_get_table_metadata
  FETCH lcur_get_table_metadata INTO lo_table_schema.*
  CLOSE lcur_get_table_metadata
  
  FREE lpre_get_table_metadata
  FREE lcur_get_table_metadata  

  LET lo_return.* = lo_table_schema.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzp310_db_get_alter_constraint_sql(p_owner,p_table_constraint)
DEFINE 
  p_owner STRING,           
  p_table_constraint  DYNAMIC ARRAY OF T_TABLE_CONSTRAINT 
DEFINE
  ls_owner              STRING,           
  lo_table_constraint   DYNAMIC ARRAY OF T_TABLE_CONSTRAINT,
  li_loop               INTEGER, 
  ls_line               STRING,
  ls_key_type           STRING,
  ls_references         STRING,
  lb_cons_exists        BOOLEAN,
  lo_string_buffer      base.StringBuffer
DEFINE ls_key_null_default_value  STRING  # PK欄位補預設值
DEFINE  
  ls_return STRING

  LET ls_owner = p_owner
  LET lo_table_constraint = p_table_constraint

  LET lo_string_buffer = base.StringBuffer.create()

  FOR li_loop = 1 TO lo_table_constraint.getLength()

    LET ls_Line = ""
    
    CALL sadzp310_db_check_table_constraint_exist(ls_owner ,lo_table_constraint[li_loop].tc_TABLE_NAME 
        ,lo_table_constraint[li_loop].tc_CONSTRAINT_NAME) RETURNING lb_cons_exists
    
    IF lb_cons_exists THEN
      LET ls_Line = ls_Line,
                    "-- Drop primary key.","\n",
                    "alter table ",lo_table_constraint[li_loop].tc_TABLE_NAME," drop primary key cascade drop index;","\n"
    END IF

    # 檢查PK欄位內容是NULL則更新 # 160309-00001#1 by circlelai at 20170208 start
    CALL sadzp310_db_get_key_null_default_value_list(lo_table_constraint[li_loop].tc_TABLE_NAME ) 
         RETURNING ls_key_null_default_value
    IF ls_key_null_default_value IS NOT NULL THEN
       LET ls_Line = ls_Line,
                  "-- Set Key field default value if key field data is null.","\n",
                  ls_key_null_default_value, "\n"
       LET ls_Line = ls_Line,"commit;","\n" 
    END IF 
    # 160309-00001#1 by circlelai at 20170208 end
    
    IF NVL(lo_table_constraint[li_loop].tc_CONSTRAINT_TYPE,cs_null_value) = "P" THEN
      LET ls_key_type = "primary key";
      LET ls_references = ""
    END IF

    #Example
    #Add
    --alter table ITMML_T add constraint itmml_pk primary key (ITMMLENT, ITMML001);
    --alter table ITMML_T add constraint itmml_fk foreign key (ITMMLENT) references itmm_t (ITMMENT) ON DELETE CASCADE DISABLE;
    --alter table ITMML_T add constraint itmml_uk unique (ITMML003);    
    #Drop
    --alter table ITMML_T drop constraint ITMML_PK CASCADE;
    --alter table ITMML_T drop constraint ITMML_FK;
  
    LET ls_Line = ls_Line
                , "-- Alter table add constraint." , "\n"
                , "alter table ",lo_table_constraint[li_loop].tc_TABLE_NAME
                , "  add constraint ",lo_table_constraint[li_loop].tc_CONSTRAINT_NAME," ",ls_key_type
                , "  (",lo_table_constraint[li_loop].tc_COLUMNS,") ",ls_references,";","\n"
                  
    CALL lo_string_buffer.append(ls_Line)
  
  END FOR  
  
  LET ls_return = lo_string_buffer.toString()
 
  RETURN ls_return
  
END FUNCTION

#檢核實際表格 Key 值是否存在
FUNCTION sadzp310_db_check_table_constraint_exist(p_owner,p_table_name,p_constraint_name)
DEFINE
  p_owner           STRING,
  p_table_name      STRING,
  p_constraint_name STRING
DEFINE
  ls_owner           STRING,
  ls_table_name      STRING,
  ls_constraint_name STRING,
  ls_sql             STRING,
  li_rec_count       INTEGER,
  lb_return          BOOLEAN

  LET ls_owner      = NVL(p_owner.toUpperCase(),cs_master_user.toUpperCase())
  LET ls_table_name = p_table_name.toUpperCase()
  LET ls_constraint_name = p_constraint_name

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                                      ",
               "  FROM DBA_CONSTRAINTS ACS                           ",
               " WHERE ACS.OWNER = '",ls_owner,"'                    ",
               "   AND ACS.TABLE_NAME = '",ls_table_name,"'          ",
               "   AND ACS.CONSTRAINT_NAME = '",ls_constraint_name,"'" 
 
  PREPARE lpre_check_table_constraint_exist FROM ls_sql
  DECLARE lcur_check_table_constraint_exist CURSOR FOR lpre_check_table_constraint_exist
  OPEN lcur_check_table_constraint_exist
  FETCH lcur_check_table_constraint_exist INTO li_rec_count
  CLOSE lcur_check_table_constraint_exist
  FREE lcur_check_table_constraint_exist
  FREE lpre_check_table_constraint_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp310_db_gen_table_grant(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_line          STRING,
  ls_sql           STRING,
  ls_table_name    STRING,
  lo_line_str_buf  base.StringBuffer,
  lo_table_grant RECORD
                   privileges_name   VARCHAR(30),
                   privileges_user   VARCHAR(30)
                 END RECORD
DEFINE
  ls_Return STRING               

  LET ls_table_name   = p_table_name
  LET lo_line_str_buf = base.StringBuffer.create()

  LET ls_sql = "SELECT BJ.DZEJ005 privileges_name, ",
               --"       BJ.DZEJ006 privileges_user  ", 
               "       'PUBLIC'   privileges_user  ", 
               "  FROM DZEJ_T BJ                   ", 
               " WHERE BJ.DZEJ001 = 'TABLE_GRANTS' ", 
               " ORDER BY BJ.DZEJ002               "

  PREPARE lpre_gen_table_grant FROM ls_sql
  DECLARE lcur_gen_table_grant CURSOR FOR lpre_gen_table_grant

  OPEN lcur_gen_table_grant
  FOREACH lcur_gen_table_grant INTO lo_table_grant.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_line = "grant ",lo_table_grant.privileges_name,
                  " on ",ls_table_name,
                  " to ",lo_table_grant.privileges_user,";","\n"
    CALL lo_line_str_buf.append(ls_line)

  END FOREACH
  CLOSE lcur_gen_table_grant
  
  FREE lpre_gen_table_grant
  FREE lcur_gen_table_grant  

  LET ls_Return = lo_line_str_buf.toString()

  RETURN ls_Return
                  
END FUNCTION

#從dzia_t取得設計表目前是否被客制旗標狀態
FUNCTION sadzp310_db_get_mtable_cust_state(p_jsonobj)
  DEFINE 
    p_jsonobj  util.JSONObject #輸入 "tablename"
  DEFINE 
    ls_tblname    STRING,
    ls_sql        STRING,
    ls_retrun     STRING,
    ls_cust_sta   VARCHAR(10)   #客制旗標狀態 (dzia015)
  
  LET ls_tblName = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL )
  
  LET ls_sql = "SELECT                         ",
               "  CASE WHEN                                             ",
               "       EXISTS (                                         ",
               "               SELECT 1 FROM DZIA_T IA2                 ",
               "                WHERE IA2.DZIA001 = IA1.DZIA001         ",
               "                  AND IA2.DZIA015='", cs_dgenv_cust, "' ",
               "               )             ",
               "         THEN '", cs_dgenv_cust, "'             ",
               "         ELSE '", cs_dgenv_stand, "'            ",
               "       END AS DZIA015        ",
               "  FROM ( SELECT IA0.DZIA001, IA0.DZIA015                ",
               "           FROM DZIA_T IA0                              ",
               "        ) IA1                                           ",
               " WHERE IA1.DZIA001 = '", ls_tblName, "'                 "
  PREPARE lpre_get_mtable_cust_state FROM ls_sql             
  DECLARE lcur_get_mtable_cust_state CURSOR FOR lpre_get_mtable_cust_state

  OPEN lcur_get_mtable_cust_state
  FETCH lcur_get_mtable_cust_state INTO ls_cust_sta
  CLOSE lcur_get_mtable_cust_state
  FREE lcur_get_mtable_cust_state
  FREE lpre_get_mtable_cust_state

  IF (ls_cust_sta = cs_dgenv_stand) OR (ls_cust_sta = cs_dgenv_cust) THEN
    LET ls_retrun = ls_cust_sta
  ELSE 
    #未定義狀態
    INITIALIZE ls_retrun TO NULL
  END IF 

  RETURN ls_retrun
END FUNCTION
################################################################################
# Descriptions...: 重置adzi180 tableDZIB_T,DZIA_T 異動碼到預設值 
# Memo...........: DZIB_T,DZIA_T
# Usage..........: CALL sadzp310_db_update_alter_code(lo_jsonobj)
#                 
# Input parameter: p_jsonobj  JSONObject, 傳入參數 tablename, alter_code, stand_cust
#                : tablename    物件名稱
#                : alter_code   異動碼
#                : stand_cust   標準或者客制
# Return code....: no return
#                : 
# Date & Author..: 160309-00001#1 by circlelai
# Modify.........: 
################################################################################
FUNCTION sadzp310_db_update_alter_code(p_jsonobj)
DEFINE
  p_jsonobj   util.JSONObject 
  #傳入參數 tablename, alter_code, stand_cust
DEFINE
  ls_obj_name   STRING,   #物件名稱
  ls_alter_code STRING,   #異動碼
  ls_stand_cust STRING,   #標準或者客制
  ls_sqlwhere   STRING,
  ls_exec_sql   STRING
DEFINE 
  lb_ret        BOOLEAN 

  LET ls_obj_name = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL)
  LET ls_alter_code = IIF (p_jsonobj.has("alter_code"), p_jsonobj.get("alter_code"), NULL )
  LET ls_stand_cust = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL )

  #傳入參處有錯誤，直接回傳
  IF (ls_obj_name IS NULL) OR (ls_alter_code IS NULL ) THEN
    RETURN 
  END IF 
  
  BEGIN WORK
  #Column
  LET ls_sqlwhere = " WHERE IB.DZIB001 = '",ls_obj_name.toLowerCase(),"' " 
  IF (ls_stand_cust = cs_dgenv_cust OR ls_stand_cust = cs_dgenv_stand) THEN
    LET ls_sqlwhere = ls_sqlwhere, " AND IB.DZIB029 = '", ls_stand_cust, "' "
  END IF 
  
  LET ls_exec_sql = " UPDATE DZIB_T IB                                      ",
                    "    SET IB.DZIB028 = '", ls_alter_code, "'             ",
                    ls_sqlwhere 
  
  CALL sadzp310_db_exec_SQL_no_commit(ls_exec_sql) RETURNING lb_ret

  #Main Table
  LET ls_sqlwhere = " WHERE IA.DZIA001 = '", ls_obj_name.toLowerCase(), "' " 
  IF (ls_stand_cust = cs_dgenv_cust OR ls_stand_cust = cs_dgenv_stand) THEN
    LET ls_sqlwhere = ls_sqlwhere, " AND IA.DZIA015 = '", ls_stand_cust, "' "
  END IF 
  LET ls_exec_sql = " UPDATE DZIA_T IA                                      ",
                    "    SET IA.DZIA011 = '",ls_alter_code,"'               ",
                    ls_sqlwhere
  
  CALL sadzp310_db_exec_SQL_no_commit(ls_exec_sql) RETURNING lb_ret
  
  COMMIT WORK
  
END FUNCTION 
################################################################################
# Descriptions...: 更新明細檔(DZIB_T)的'異動確認碼'欄位(DZIB028)
# Memo...........: 
# Usage..........: CALL sadzp310_db_update_dzib_alter_code(lo_jsonobj) 
#                   RETURNING lb_success
# Input parameter: p_jsonobj    JSONObject, 傳入參數 "tablename", "stand_cust", "col_name", "chk_diff"
#                : tablename    物件名稱
#                : stand_cust   標準或者客制
#                : col_name     欄位名稱
#                : chk_diff     設計與實體不符 "1", 相符"0"
# Return code....: lb_ret   更新是否成功
#                : 
# Date & Author..: 160309-00001#1 by circlelai
# Modify.........: 
################################################################################
FUNCTION sadzp310_db_update_dzib_alter_code(p_jsonobj)
DEFINE 
  p_jsonobj  util.JSONObject
  #傳入參數 "tablename", "stand_cust", "col_name", "chk_diff"
DEFINE
  ls_tbl_name   STRING,   #table name
  ls_stand_cust STRING,
  ls_col_name   STRING,   #column name
  ls_sqlwhere   STRING,
  ls_exec_sql   STRING,
  ls_alter_code STRING,
  li_chk_diff   INTEGER   #decide Update value
DEFINE 
  lb_ret     BOOLEAN

  LET ls_tbl_name = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL)
  LET ls_col_name = IIF (p_jsonobj.has("col_name"), p_jsonobj.get("col_name"), NULL)
  LET li_chk_diff = IIF (p_jsonobj.has("chk_diff"), p_jsonobj.get("chk_diff"), -1)
  LET ls_stand_cust = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL)

  #傳入參數錯誤
  IF (ls_tbl_name IS NULL) OR 
     (ls_col_name IS NULL) THEN
    LET lb_ret = FALSE 
    RETURN lb_ret
  END IF 
  
  CASE li_chk_diff
    WHEN 1
      LET ls_alter_code = "N"
    WHEN 0
      LET ls_alter_code = "Y"
    OTHERWISE 
      LET ls_alter_code = "Y"  --default 'Y'
  END CASE 

  LET ls_sqlwhere = "  WHERE IB.DZIB001 = '",ls_tbl_name.toLowerCase(),"' ",
                    "    AND IB.DZIB002 = '",ls_col_name.toLowerCase(),"' "
  #搜尋客制或者標準表
  IF (ls_stand_cust IS NOT NULL) AND 
     (ls_stand_cust = cs_dgenv_cust OR 
      ls_stand_cust = cs_dgenv_stand) THEN
    LET ls_sqlwhere = ls_sqlwhere, " AND IB.DZIB029 = '",ls_stand_cust , "' "
  END IF 
  
  LET ls_exec_sql = " UPDATE DZIB_T IB ",
                    "    SET IB.DZIB028 = '",ls_alter_code,"' ",
                    ls_sqlwhere
  CALL sadzp310_db_exec_SQL_no_commit(ls_exec_sql) RETURNING lb_ret
  
  RETURN lb_ret 
  
END FUNCTION 
################################################################################
# Descriptions...: 更新主檔(DZIA_T)的'異動確認碼'欄位(DZIA011)
# Memo...........: 
# Usage..........: CALL sadzp310_db_update_dzia_alter_code(lo_jsonobj) 
#                   RETURNING lb_success
# Input parameter: p_jsonobj    JSONObject, 傳入參數 "tablename", "chk_diff", "stand_cust"
#                : tablename    物件名稱
#                : stand_cust   標準或者客制
#                : chk_diff     設計與實體不符 "1", 相符"0"
# Return code....: lb_ret   更新是否成功
#                : 
# Date & Author..: 160309-00001#1 by circlelai
# Modify.........: 
################################################################################
FUNCTION sadzp310_db_update_dzia_alter_code(p_jsonobj)
DEFINE
  p_jsonobj   util.JSONObject
  #傳入參數 "tablename", "chk_diff", "stand_cust"
DEFINE
  li_chk_diff     INTEGER,    #設計與實體表格不相同 = 1
  ls_tbl_name     STRING,     #表格名稱
  ls_stand_cust   STRING,     #標準或者客制表
  ls_alter_code   STRING,     
  ls_sqlwhere     STRING,
  ls_exec_sql     STRING
DEFINE 
  lb_ret         BOOLEAN 

  LET ls_tbl_name = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL)
  LET li_chk_diff = IIF (p_jsonobj.has("chk_diff"), p_jsonobj.get("chk_diff"), -1)
  LET ls_stand_cust = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL )

  #輸入參數錯誤離開function
  IF (ls_tbl_name IS NULL) OR (li_chk_diff = -1) THEN 
    LET lb_ret = FALSE 
    RETURN lb_ret
  END IF 

  CASE li_chk_diff
    WHEN 1
      LET ls_alter_code = "N"
    WHEN 0
      LET ls_alter_code = "Y"
    OTHERWISE 
      LET ls_alter_code = "Y"
  END CASE 

  LET ls_sqlwhere = "  WHERE IA.DZIA001 = '", ls_tbl_name.toLowerCase(), "' "
  IF (ls_stand_cust IS NOT NULL) AND 
     (ls_stand_cust = cs_dgenv_cust OR 
      ls_stand_cust = cs_dgenv_stand) THEN
    LET ls_sqlwhere = ls_sqlwhere, " AND IA.DZIA015 = '",ls_stand_cust , "' "
  END IF 
  
  LET ls_exec_sql = " UPDATE DZIA_T IA                                      ",
                    "    SET IA.DZIA011 = '",ls_alter_code,"'               ",
                    ls_sqlwhere
  CALL sadzp310_db_exec_SQL(ls_exec_sql)  RETURNING lb_ret

  RETURN lb_ret
  
END FUNCTION  

################################################################################
# Descriptions...: 產生更新PK欄位不得為空的SQL
# Memo...........: Set Key field default value if key field data is null
# Usage..........: sadzp310_db_get_key_null_default_value_list(p_tbl_name)
#                  
# Input parameter: p_tbl_name 表格名稱
#                : 
# Return code....: ls_default_list  SQL list
#                : 
# Date & Author..:  160309-00001#1 by circlelai at 20170208
# Modify.........: 
################################################################################
FUNCTION sadzp310_db_get_key_null_default_value_list(p_tbl_name)
DEFINE p_tbl_name  STRING
DEFINE ls_tbl_name STRING 
DEFINE lo_tbl_pk_data  DYNAMIC ARRAY OF RECORD
       column_name  LIKE dzib_t.dzib002,  # 欄位名稱
       column_type  LIKE dzib_t.dzib007   # 欄位型態
                   END RECORD 
DEFINE ls_sql      STRING
DEFINE li_rec_cnt  INTEGER
DEFINE li_idx      INTEGER
DEFINE ls_val      STRING 
DEFINE ls_default_list STRING

  LET ls_default_list = ""
  LET li_rec_cnt = 1
  LET ls_tbl_name = p_tbl_name.toLowerCase()
  
  # 取得 table 的 鍵值 欄位名稱與欄位型態
  LET ls_sql = "select dzib002 column_name,dzib007 column_type" , "\n"
             , "  from dzib_t" , "\n"
             , " where dzib001 = '" , ls_tbl_name , "' and dzib004 = 'Y' "
  PREPARE lpre_get_key_null_default_value_list FROM ls_sql
  DECLARE lcur_get_key_null_default_value_list CURSOR FOR lpre_get_key_null_default_value_list
  OPEN lcur_get_key_null_default_value_list
  FOREACH lcur_get_key_null_default_value_list INTO lo_tbl_pk_data[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    LET li_rec_cnt = li_rec_cnt + 1
  END FOREACH
  CLOSE lcur_get_key_null_default_value_list
  FREE lpre_get_key_null_default_value_list
  FREE lcur_get_key_null_default_value_list
  CALL lo_tbl_pk_data.deleteElement(li_rec_cnt)

  IF lo_tbl_pk_data.getLength() > 0 THEN
     FOR li_idx = 1 TO lo_tbl_pk_data.getLength()
        LET ls_val = NULL 
        CASE UPSHIFT(lo_tbl_pk_data[li_idx].column_type)
          WHEN "DATE"
            LET ls_val = "trunc(sysdate)"
          WHEN "NUMBER"
            LET ls_val = "0"
          WHEN "TIMESTAMP"
            LET ls_val = "trunc(systimestamp)"
          WHEN "VARCHAR2"
            LET ls_val = "' '"
          OTHERWISE 
            LET ls_val = NULL 
        END CASE
        
        IF ls_val IS NULL THEN 
           CONTINUE FOR
        END IF 
        
        LET ls_sql = "update " , ls_tbl_name , " set " , lo_tbl_pk_data[li_idx].column_name 
                  , " = " , ls_val , " where " , lo_tbl_pk_data[li_idx].column_name  , " is null"
        LET ls_default_list = ls_default_list, ls_sql, ";" , "\n"
     END FOR 
    
  END IF

  RETURN ls_default_list
END FUNCTION 

