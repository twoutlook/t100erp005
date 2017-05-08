
&include "../4gl/sadzp310_mcr.inc" 

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"

&include "../4gl/sadzp310_type.inc"

PUBLIC TYPE T_OBJECT_TYPE RECORD
              ot_schema  VARCHAR(50),   --物件放置資料庫
              ot_type    VARCHAR(50),   --物件型態 T table ,
              ot_name    VARCHAR(50)    --物件名稱
            END RECORD             

&ifndef DEBUG
GLOBALS "../../cfg/top_global.inc"
&endif

DEFINE
  mo_COMPRESS_FILE_INFO   T_COMPRESS_FILE_INFO,
  mb_backend_mode         BOOLEAN,
  mb_result               BOOLEAN,
  ms_result               STRING

FUNCTION sadzp310_asmt_run(p_backend_mode,p_COMPRESS_FILE_INFO)
DEFINE
  p_backend_mode BOOLEAN,
  p_COMPRESS_FILE_INFO     T_COMPRESS_FILE_INFO
  
  CALL sadzp310_asmt_initialize(p_backend_mode,p_COMPRESS_FILE_INFO.*)
  CALL sadzp310_asmt_start()
  CALL sadzp310_asmt_finalize()

  RETURN mb_result,ms_result

END FUNCTION 

FUNCTION sadzp310_asmt_initialize(p_backend_mode,p_COMPRESS_FILE_INFO)
DEFINE
  p_backend_mode BOOLEAN,
  p_COMPRESS_FILE_INFO     T_COMPRESS_FILE_INFO
  
  LET mb_backend_mode = p_backend_mode
  LET mo_COMPRESS_FILE_INFO.* = p_COMPRESS_FILE_INFO.*
  
END FUNCTION 

FUNCTION sadzp310_asmt_start()
DEFINE
  lo_object_type  DYNAMIC ARRAY OF T_OBJECT_TYPE,
  lo_jsonobj      util.JSONObject, #160309-00001#1 add by circlelai
  ls_message      STRING,
  ls_stand_cust   STRING, -- 使用客制(c)或者標準(s)設計數據進行建構 #160309-00001#1 add by circlelai
  lb_success      BOOLEAN,  #160309-00001#1 add by circlelai
  lb_result       BOOLEAN

  #執行建構
  CALL sadzp310_asmt_get_alter_table_list(mo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME) RETURNING lo_object_type
  CALL sadzp310_asmt_create_replace_mtable(lo_object_type) RETURNING lb_result, ls_message, ls_stand_cust #160309-00001#1 mod by circlelai

  # 更新設計數據的異動旗標
  LET lo_jsonobj = util.JSONObject.create()
  CALL lo_jsonobj.put("tablename", mo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME)
  CALL lo_jsonobj.put("stand_cust", ls_stand_cust)
  IF (lb_result) THEN  #異動確認碼更新為'Y'
    CALL lo_jsonobj.put("alter_code", "Y") 
    CALL sadzp310_db_update_alter_code(lo_jsonobj)
  ELSE
    LET lo_jsonobj = util.JSONObject.create()
    CALL lo_jsonobj.put("tablename", mo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME)
    CALL lo_jsonobj.put("stand_cust", ls_stand_cust)
    CALL sadzp310_asmt_chk_tbl_diff(lo_jsonobj) RETURNING lb_success
  END IF 
  
  LET ms_result = ls_message
  LET mb_result = lb_result
  
END FUNCTION 

FUNCTION sadzp310_asmt_finalize()
END FUNCTION 
#取得物件'MDM table'存在資料庫schema資訊
FUNCTION sadzp310_asmt_get_alter_table_list(p_table_name)
DEFINE 
  p_table_name STRING
DEFINE
  ls_table_name       STRING,
  ls_sql              STRING,
  li_rec_cnt          INTEGER,         
  lo_object_type DYNAMIC ARRAY OF T_OBJECT_TYPE
DEFINE  
  lo_return DYNAMIC ARRAY OF T_OBJECT_TYPE

  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 1
  
  LET ls_sql = "SELECT IU.DZIU002,IU.DZIU003,IU.DZIU001                  ",
               "  FROM DZIU_T IU                                         ",
               " WHERE EXISTS (                                          ",
               "                SELECT 1                                 ",
               "                  FROM DZEJ_T EJ                         ",
               "                 WHERE EJ.DZEJ001 = 'adzi180_parameters' ",
               "                   AND EJ.DZEJ003 = 'DBDefine'           ",
               "                   AND EJ.DZEJ004 = 'MDMDB'              ",
               "                   AND EJ.DZEJ007 = IU.DZIU002           ",
               "              )                                          ",
               "   AND IU.DZIU001 = '",ls_table_name,"'                  ",
               "   AND IU.DZIU003 = 'T'                                  ",
               "   AND IU.DZIU004 = 'Y'                                  "
                              
  PREPARE lpre_get_alter_table_list FROM ls_sql
  DECLARE lcur_get_alter_table_list CURSOR FOR lpre_get_alter_table_list

  OPEN lcur_get_alter_table_list
  FOREACH lcur_get_alter_table_list INTO lo_object_type[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_alter_table_list
  CALL lo_object_type.deleteElement(li_rec_cnt)
  
  FREE lpre_get_alter_table_list
  FREE lcur_get_alter_table_list

  LET lo_return.* = lo_object_type.*
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzp310_asmt_create_replace_mtable(p_OBJECT_TYPE)
DEFINE 
  p_OBJECT_TYPE  DYNAMIC ARRAY OF T_OBJECT_TYPE
DEFINE 
  lo_OBJECT_TYPE  DYNAMIC ARRAY OF T_OBJECT_TYPE,
  li_loop         INTEGER,
  lo_db_coxn      T_DB_COXN_STR,
  ls_message      STRING,
  ls_all_message  STRING,
  ls_stand_cust   STRING,     #客制旗標狀態
  ls_result       STRING,
  lb_result       BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET lo_OBJECT_TYPE = p_OBJECT_TYPE
  LET lb_return = TRUE

  FOR li_loop = 1 TO lo_OBJECT_TYPE.getLength()

    DISPLAY "\n"
    DISPLAY cs_information_tag,"Alter table for schema : ",lo_OBJECT_TYPE[li_loop].ot_schema,"\n"

    #先取得資料庫連接資訊
    CALL sadzp310_db_get_db_connect_string(lo_OBJECT_TYPE[li_loop].ot_schema) RETURNING lo_db_coxn.*

    #檢核表格是否存在, 若不存在, 則建立
    CALL sadzp310_asmt_check_and_create_table(lo_OBJECT_TYPE[li_loop].*, lo_db_coxn.*) 
          RETURNING lb_result,ls_result,ls_stand_cust
    LET ls_message = ls_result
    LET ls_all_message = ls_all_message,"\n",ls_message
    IF NOT lb_result THEN GOTO _CHECK_ERROR END IF

    #產出Alter table add column SQL File
    CALL sadzp310_asmt_add_columns(lo_OBJECT_TYPE[li_loop].*, lo_db_coxn.*, ls_stand_cust) 
          RETURNING lb_result,ls_result 
    LET ls_message = ls_result
    LET ls_all_message = ls_all_message,"\n",ls_message
    IF NOT lb_result THEN GOTO _CHECK_ERROR END IF

    #產出Alter table add constraint SQL File
    CALL sadzp310_asmt_add_constraints(lo_OBJECT_TYPE[li_loop].*, lo_db_coxn.*, ls_stand_cust) 
         RETURNING lb_result,ls_result
    LET ls_message = ls_result
    LET ls_all_message = ls_all_message,"\n",ls_message
    IF NOT lb_result THEN GOTO _CHECK_ERROR END IF

    #產出Alter table drop column SQL File
    CALL sadzp310_asmt_drop_columns(lo_OBJECT_TYPE[li_loop].*, lo_db_coxn.*, ls_stand_cust) 
          RETURNING lb_result,ls_result 
    LET ls_message = ls_result
    LET ls_all_message = ls_all_message,"\n",ls_message
    IF NOT lb_result THEN GOTO _CHECK_ERROR END IF

    
    LABEL _CHECK_ERROR:
    
    #異動過程中任一區域有任何錯誤, 就終止異動
    IF NOT lb_result THEN
      LET lb_return = lb_result
      EXIT FOR
    END IF
    
  END FOR
  
  IF (mb_backend_mode) THEN DISPLAY ls_all_message END IF 
  
  RETURN lb_return, ls_all_message, ls_stand_cust

END FUNCTION

#Alter table drop column
FUNCTION sadzp310_asmt_add_constraints(p_OBJECT_TYPE, p_db_coxn, p_stand_cust)
  DEFINE
    p_stand_cust  STRING,
    p_OBJECT_TYPE T_OBJECT_TYPE,
    p_db_coxn     T_DB_COXN_STR
  DEFINE
    lb_cons_diff    BOOLEAN,
    ls_SQL_file     STRING,
    ls_cons_SQL     STRING,
    ls_message      STRING,
    ls_all_message  STRING,
    ls_check_error  STRING,
    lo_jsonobj      util.JSONObject,
    lo_OBJECT_TYPE  T_OBJECT_TYPE,
    lo_db_coxn      T_DB_COXN_STR,
    lo_cons_diff    DYNAMIC ARRAY OF T_TABLE_CONSTRAINT
  DEFINE
    lb_return  BOOLEAN,
    ls_return  STRING  

  LET lo_OBJECT_TYPE.* = p_OBJECT_TYPE.*
  LET lo_db_coxn.*     = p_db_coxn.*
  LET lo_jsonobj       = util.JSONObject.create()
  
  LET lb_return = TRUE
  
  #產出 Alter table add constraint SQL
  DISPLAY cs_information_tag,"Check table constraint difference between real table and design data, then create alter constraint SQL file."
  CALL lo_jsonobj.put("owner", lo_OBJECT_TYPE.ot_schema)
  CALL lo_jsonobj.put("tablename", lo_OBJECT_TYPE.ot_name)
  IF (p_stand_cust IS NOT NULL) THEN CALL lo_jsonobj.put("stand_cust", p_stand_cust) END IF 
  CALL sadzp310_asmt_get_constraint_diff_by_design_data(lo_jsonobj) 
        RETURNING lb_cons_diff,lo_cons_diff
  IF lb_cons_diff THEN

    CALL sadzp310_db_get_alter_constraint_sql(lo_OBJECT_TYPE.ot_schema,lo_cons_diff) RETURNING ls_cons_SQL
    LET ls_cons_SQL = ls_cons_SQL,"\n"
    
    #產出 SQL File 待供 SQLPlus 執行                    
    CALL sadzp310_util_gen_sql_script_file(ls_cons_SQL,cs_alter_constraint) RETURNING ls_SQL_file 
    LET lo_db_coxn.db_sql_filename = ls_SQL_file
    
    #該有的資訊都有, 就執行
    IF NVL(lo_db_coxn.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_coxn.db_password,cs_null_value) <> cs_null_value THEN
      CALL sadzp310_db_sqlplus(lo_db_coxn.*) RETURNING ls_message
    ELSE
      LET ls_message = cs_error_tag,"User name or password can not be null."
    END IF        
    LET ls_all_message = ls_all_message,"\n",
                         "Process :","Alter table [", lo_OBJECT_TYPE.ot_name, "] add/alter constraints.","\n", 
                         "User : ",lo_db_coxn.db_username,"\n",
                         ls_message
                         
  END IF
  
  #確認是否有任何錯誤
  LET ls_check_error = ls_all_message.toUpperCase()
  IF (ls_check_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_return = FALSE
  END IF

  LET ls_return = ls_all_message

  RETURN lb_return,ls_return
                         
END FUNCTION 

#Alter table drop column
FUNCTION sadzp310_asmt_drop_columns(p_OBJECT_TYPE, p_db_coxn, p_stand_cust)
  DEFINE
    p_stand_cust  STRING,
    p_OBJECT_TYPE T_OBJECT_TYPE,
    p_db_coxn     T_DB_COXN_STR
  DEFINE
    lo_OBJECT_TYPE  T_OBJECT_TYPE,
    lo_db_coxn      T_DB_COXN_STR,
    lo_diff_columns DYNAMIC ARRAY OF T_DIFF_COLUMNS,
    lo_jsonobj      util.JSONObject,
    lb_diff_columns BOOLEAN,
    ls_drop_col_sql STRING, 
    ls_SQL_file     STRING,
    ls_message      STRING,
    ls_all_message  STRING,
    ls_check_error  STRING
  DEFINE
    lb_return  BOOLEAN,
    ls_return  STRING  

  LET lo_OBJECT_TYPE.* = p_OBJECT_TYPE.*
  LET lo_db_coxn.*     = p_db_coxn.*
  LET lo_jsonobj = util.JSONObject.create()
  
  LET lb_return = TRUE
  
  ########## Drop Columns ##########
  DISPLAY cs_information_tag,"Check table columns difference between real table and design data, then create drop column SQL file."
  #產出 Create / Replace Trigger SQL File
  LET lo_diff_columns = NULL
  
  CALL lo_jsonobj.put("owner", lo_db_coxn.db_username)
  CALL lo_jsonobj.put("tablename", lo_OBJECT_TYPE.ot_name)
  IF (p_stand_cust IS NOT NULL) THEN CALL lo_jsonobj.put("stand_cust", p_stand_cust) END IF 
  CALL sadzp310_asmt_get_column_diff_by_database(lo_jsonobj) 
        RETURNING lb_diff_columns,lo_diff_columns
  CALL sadzp310_db_get_drop_column_sql(lo_jsonobj, lo_diff_columns) RETURNING ls_drop_col_sql
  LET ls_drop_col_sql = ls_drop_col_sql,"\n"

  #產出 SQL File 待供 SQLPlus 執行                    
  CALL sadzp310_util_gen_sql_script_file(ls_drop_col_sql,cs_drop_column) RETURNING ls_SQL_file 
  LET lo_db_coxn.db_sql_filename = ls_SQL_file
  
  #該有的資訊都有, 就執行
  IF NVL(lo_db_coxn.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_coxn.db_password,cs_null_value) <> cs_null_value THEN
    CALL sadzp310_db_sqlplus(lo_db_coxn.*) RETURNING ls_message
  ELSE
    LET ls_message = cs_error_tag,"User name or password can not be null."
  END IF        
  LET ls_all_message = ls_all_message,"\n",
                       "Process :","Alter MTABLE [", lo_OBJECT_TYPE.ot_name, "] drop columns.","\n", 
                       "User : ",lo_db_coxn.db_username,"\n",
                       ls_message
                       
  #確認是否有任何錯誤
  LET ls_check_error = ls_all_message.toUpperCase()
  IF (ls_check_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_return = FALSE
  END IF

  LET ls_return = ls_all_message

  RETURN lb_return,ls_return
                         
END FUNCTION 

#Alter table add column
FUNCTION sadzp310_asmt_add_columns(p_OBJECT_TYPE, p_db_coxn, p_stand_cust)
  DEFINE
    p_OBJECT_TYPE T_OBJECT_TYPE,
    p_db_coxn     T_DB_COXN_STR,
    p_stand_cust  STRING      #客制旗標目前狀態
  DEFINE
    lo_OBJECT_TYPE  T_OBJECT_TYPE,
    lo_db_coxn      T_DB_COXN_STR,
    lo_diff_columns DYNAMIC ARRAY OF T_DIFF_COLUMNS,
    lo_jsonobj      util.JSONObject,
    lb_diff_columns BOOLEAN,
    ls_alt_col_sql  STRING,
    ls_SQL_file     STRING,
    ls_message      STRING,
    ls_all_message  STRING,
    ls_check_error  STRING
  DEFINE
    lb_return  BOOLEAN,
    ls_return  STRING 

  LET lo_OBJECT_TYPE.* = p_OBJECT_TYPE.*
  LET lo_db_coxn.*     = p_db_coxn.*
  LET lo_jsonobj = util.JSONObject.create()
  
  LET lb_return = TRUE
  
  #產出Alter table add column SQL File
  DISPLAY cs_information_tag,"Check table columns difference between real table and design data, then create alter column SQL file."
  LET lo_diff_columns = NULL
  
  CALL lo_jsonobj.put("owner", lo_db_coxn.db_username)
  CALL lo_jsonobj.put("tablename", lo_OBJECT_TYPE.ot_name)
  IF (p_stand_cust IS NOT NULL) THEN 
    CALL lo_jsonobj.put("stand_cust", p_stand_cust)
  END IF
  CALL sadzp310_asmt_get_column_diff_by_design_data(lo_jsonobj) RETURNING lb_diff_columns,lo_diff_columns
  CALL sadzp310_db_get_alter_column_sql(lo_jsonobj, lo_diff_columns) RETURNING ls_alt_col_sql
  LET ls_alt_col_sql = ls_alt_col_sql,"\n"

  #產出 SQL File 待供 SQLPlus 執行                    
  CALL sadzp310_util_gen_sql_script_file(ls_alt_col_sql, cs_alter_column) RETURNING ls_SQL_file 
  LET lo_db_coxn.db_sql_filename = ls_SQL_file
  
  #該有的資訊都有, 就執行
  IF NVL(lo_db_coxn.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_coxn.db_password,cs_null_value) <> cs_null_value THEN
    CALL sadzp310_db_sqlplus(lo_db_coxn.*) RETURNING ls_message
  ELSE
    LET ls_message = cs_error_tag,"User name or password can not be null."
  END IF        
  LET ls_all_message = ls_all_message,"\n",
                       "Process :","Alter MTABLE [", lo_OBJECT_TYPE.ot_name, "] add column.","\n", 
                       "User : ",lo_db_coxn.db_username,"\n",
                       ls_message
                       
  #確認是否有任何錯誤
  LET ls_check_error = ls_all_message.toUpperCase()
  IF (ls_check_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_return = FALSE
  END IF

  LET ls_return = ls_all_message

  RETURN lb_return,ls_return
                         
END FUNCTION 

#建立空表格
FUNCTION sadzp310_asmt_check_and_create_table(p_OBJECT_TYPE,p_db_coxn)
DEFINE
  p_OBJECT_TYPE T_OBJECT_TYPE,
  p_db_coxn     T_DB_COXN_STR
DEFINE
  lo_OBJECT_TYPE  T_OBJECT_TYPE,
  lo_db_coxn      T_DB_COXN_STR,
  lo_table_schema T_TABLE_METADATA,
  lo_jsonobj      util.JSONObject,
  lb_table_exists BOOLEAN,
  ls_dummy_sql    STRING,
  ls_grant_sql    STRING,
  ls_SQL_file     STRING,
  ls_message      STRING,
  ls_all_message  STRING,
  ls_stand_cust   STRING,
  ls_check_error  STRING
DEFINE
  lb_return  BOOLEAN,
  ls_return  STRING
  
  LET lo_OBJECT_TYPE.* = p_OBJECT_TYPE.*
  LET lo_db_coxn.*     = p_db_coxn.*
  LET lo_jsonobj = util.JSONObject.create()
  
  LET lb_return = TRUE
  
  ########## 檢核表格是否存在, 若不存在, 則建立 ##########
  DISPLAY cs_information_tag,"Check table '",lo_OBJECT_TYPE.ot_name,"' exist, if not create one."
  LET ls_dummy_sql = ""
  CALL sadzp310_db_check_table_exist(lo_OBJECT_TYPE.ot_schema,lo_OBJECT_TYPE.ot_name) RETURNING lb_table_exists
  IF NOT lb_table_exists THEN  #表格不存在
    CALL sadzp310_db_get_table_metadata(lo_OBJECT_TYPE.ot_schema,lo_OBJECT_TYPE.ot_name) RETURNING lo_table_schema.*
    CALL sadzp310_db_get_create_dummy_table_sql(lo_table_schema.*) RETURNING ls_dummy_sql
    CALL sadzp310_db_gen_table_grant(lo_table_schema.ts_TABLE_NAME) RETURNING ls_grant_sql  
    LET ls_dummy_sql = ls_dummy_sql,"\n",
                       ls_grant_sql,"\n"

    #產出 SQL File 待供 SQLPlus 執行                    
    CALL sadzp310_util_gen_sql_script_file(ls_dummy_sql,cs_create_mtable) RETURNING ls_SQL_file 
    LET lo_db_coxn.db_sql_filename = ls_SQL_file
    
    #該有的資訊都有, 就執行
    IF NVL(lo_db_coxn.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_coxn.db_password,cs_null_value) <> cs_null_value THEN
      CALL sadzp310_db_sqlplus(lo_db_coxn.*) RETURNING ls_message
    ELSE
      LET ls_message = cs_error_tag,"User name or password can not be null."
    END IF        
    LET ls_all_message = ls_all_message,"\n",
                         "Process :","Create MTABLE. [", lo_OBJECT_TYPE.ot_name, "]", "\n", 
                         "User : ",lo_db_coxn.db_username,"\n",
                         ls_message
  END IF 
  
  #確認是否有任何錯誤
  LET ls_check_error = ls_all_message.toUpperCase()
  IF (ls_check_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_return = FALSE
  END IF

  LET ls_return = ls_all_message

  IF (lb_return) THEN #取得客制旗標 
    CALL lo_jsonobj.put("tablename", lo_OBJECT_TYPE.ot_name)
    CALL sadzp310_db_get_mtable_cust_state(lo_jsonobj) RETURNING ls_stand_cust 
  ELSE 
    INITIALIZE ls_stand_cust TO NULL
  END IF 
  
  RETURN lb_return,ls_return,ls_stand_cust
  
END FUNCTION

#取得設計資料對照實際表格之間的比對差異
FUNCTION sadzp310_asmt_get_column_diff_by_design_data(p_jsonobj)
  DEFINE
    p_jsonobj     util.JSONObject #傳入參數 "owner", "tablename", "stand_cust"
  DEFINE
    ls_owner          STRING, 
    ls_tablename      STRING,
    ls_stand_cust     STRING,  #取得標準或客製
    ls_sql            STRING,
    ls_dzib_sqlwhere  STRING,
    lo_diff_columns   DYNAMIC ARRAY OF T_DIFF_COLUMNS,
    li_rec_cnt        INTEGER
  DEFINE
    lb_different    BOOLEAN,
    lo_different    DYNAMIC ARRAY OF T_DIFF_COLUMNS
  
  LET ls_owner      = IIF (p_jsonobj.has("owner"), p_jsonobj.get("owner"), NULL)
  LET ls_tablename  = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL)
  LET ls_stand_cust = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL )
  
  LET ls_dzib_sqlwhere = " WHERE IB.DZIB001 = '",ls_tableName.toLowerCase(),"' "
  IF (ls_stand_cust IS NOT NULL) AND 
     (ls_stand_cust = cs_dgenv_cust OR 
      ls_stand_cust = cs_dgenv_stand) THEN
    LET ls_dzib_sqlwhere = ls_dzib_sqlwhere, " AND IB.DZIB029 = '", ls_stand_cust, "' "
  END IF
  
  LET lb_different    = FALSE
  LET lo_different    = NULL

  LET ls_sql = "SELECT UPPER(IB.DZIB002)                      DZIB002,                                ",
               "       IB.DZIB004                             DZIB004,                                ",
               "       DECODE(IB.DZIB004,'Y','N','N','Y','Y') DZIB005,                                ",
               "       UPPER(TD.GZTD003)                      DZIB007,                                ",
               "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(                                     ",                                  
               "       DECODE(                                                                        ",
               "              UPPER(TD.GZTD003),                                                      ",
               "              'BLOB','4000',                                                          ",
               "              'CLOB','4000',                                                          ",
               "              'DATE','7',                                                             ",
               "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),                            ",
               "              TD.GZTD008                                                              ",
               "             ),',','.'),' ',''))),'.',',')    DZIB008,                                ",
               "       TRIM(IB.DZIB012)                       DZIB012                                 ",
               "  FROM DS.DZIB_T IB                                                                   ",
               "       LEFT OUTER JOIN DS.GZTD_T TD ON TD.GZTD001 = IB.DZIB006                        ",
               ls_dzib_sqlwhere,
               "MINUS                                                                                 ",
               "SELECT ATC.COLUMN_NAME                      DZIB002,                                  ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') DZIB004,                                  ",
               "       ATC.NULLABLE                         DZIB005,                                  ",
               "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DZIB007, ",
               "       REPLACE(TO_CHAR(DECODE(                                                        ",
               "               ATC.DATA_TYPE,                                                         ",
               "               'NUMBER',DECODE(                                                       ",
               "                                ATC.DATA_SCALE,                                       ",
               "                                '0',ATC.DATA_PRECISION,                               ",
               "                                ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE               ",
               "                              ),                                                      ",
               "               ATC.DATA_LENGTH                                                        ",
               "             )),'.',',')                    DZIB008,                                  ",
               "       TRIM(DS.GET_COL_DEFAULT_BY_OWNER('",ls_owner.toUpperCase(),"',                 ",
               "                                        ATC.TABLE_NAME,ATC.COLUMN_NAME))  DZIB012     ",
               "  FROM DBA_TAB_COLUMNS ATC                                                            ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER                 ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME            ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME           ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'              ",
               " WHERE 1=1                                                                            ",
               "   AND ATC.OWNER      = '",ls_owner.toUpperCase(),"'                                  ",
               "   AND ATC.TABLE_NAME = '",ls_tableName.toUpperCase(),"'                              ",
               "   AND ATC.COLUMN_NAME NOT LIKE 'SYS_%'                                               ",
               " ORDER BY 1                                                                           "

  PREPARE lpre_get_column_diff_by_design_data FROM ls_sql
  DECLARE lcur_get_column_diff_by_design_data CURSOR FOR lpre_get_column_diff_by_design_data

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_column_diff_by_design_data
  FOREACH lcur_get_column_diff_by_design_data INTO lo_diff_columns[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_column_diff_by_design_data
  IF li_rec_cnt > 1 THEN
    CALL lo_diff_columns.deleteElement(li_rec_cnt)
  END If  
  
  FREE lpre_get_column_diff_by_design_data
  FREE lcur_get_column_diff_by_design_data

  IF li_rec_cnt >= 2 THEN
    LET lb_different = TRUE
  END IF  

  LET lo_different.* = lo_diff_columns.*
  
  RETURN lb_different, lo_different
  
END FUNCTION

#取得實際表格對照設計資料之間的比對差異
FUNCTION sadzp310_asmt_get_column_diff_by_database(p_jsonobj)
  DEFINE
    p_jsonobj     util.JSONObject  #可能傳入參數 "owner", "tablename", "stand_cust"
  DEFINE
    ls_owner          STRING, 
    ls_tablename      STRING,
    ls_stand_cust     STRING,
    ls_sql             STRING,
    ls_dzib_sqlwhere   STRING,
    lo_diff_columns   DYNAMIC ARRAY OF T_DIFF_COLUMNS,
    li_rec_cnt        INTEGER
  DEFINE
    lb_different    BOOLEAN,
    lo_different    DYNAMIC ARRAY OF T_DIFF_COLUMNS 

  LET ls_owner      = IIF (p_jsonobj.has("owner"), p_jsonobj.get("owner"), NULL)
  LET ls_tablename  = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL)
  LET ls_stand_cust = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL ) 

  LET ls_dzib_sqlwhere = " WHERE IB.DZIB001 = '",ls_tableName.toLowerCase(),"' "
  IF (ls_stand_cust IS NOT NULL) AND 
     (ls_stand_cust = cs_dgenv_cust OR 
      ls_stand_cust = cs_dgenv_stand) THEN
    LET ls_dzib_sqlwhere = ls_dzib_sqlwhere, " AND IB.DZIB029 = '", ls_stand_cust, "' "
  END IF
  
  LET lb_different    = FALSE
  LET lo_different    = NULL

  LET ls_sql = "SELECT ATC.COLUMN_NAME                      DZIB002,                                  ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') DZIB004,                                  ",
               "       ATC.NULLABLE                         DZIB005,                                  ",
               "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DZIB007, ",
               "       REPLACE(TO_CHAR(DECODE(                                                        ",
               "               ATC.DATA_TYPE,                                                         ",
               "               'NUMBER',DECODE(                                                       ",
               "                                ATC.DATA_SCALE,                                       ",
               "                                '0',ATC.DATA_PRECISION,                               ",
               "                                ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE               ",
               "                              ),                                                      ",
               "               ATC.DATA_LENGTH                                                        ",
               "             )),'.',',')                    DZIB008,                                  ",
               "       TRIM(DS.GET_COL_DEFAULT_BY_OWNER('",ls_owner.toUpperCase(),"',                 ",
               "                                        ATC.TABLE_NAME,ATC.COLUMN_NAME))  DZIB012     ",
               "  FROM DBA_TAB_COLUMNS ATC                                                            ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER                 ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME            ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME           ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'              ",
               " WHERE 1=1                                                                            ",
               "   AND ATC.OWNER      = '",ls_owner.toUpperCase(),"'                                  ",
               "   AND ATC.TABLE_NAME = '",ls_tableName.toUpperCase(),"'                              ",
               "   AND ATC.COLUMN_NAME NOT LIKE 'SYS_%'                                               ",
               "MINUS                                                                                 ",
               "SELECT UPPER(IB.DZIB002)                      DZIB002,                                ",
               "       IB.DZIB004                             DZIB004,                                ",
               "       DECODE(IB.DZIB004,'Y','N','N','Y','Y') DZIB005,                                ",
               "       UPPER(TD.GZTD003)                      DZIB007,                                ",
               "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(                                     ",                                  
               "       DECODE(                                                                        ",
               "              UPPER(TD.GZTD003),                                                      ",
               "              'BLOB','4000',                                                          ",
               "              'CLOB','4000',                                                          ",
               "              'DATE','7',                                                             ",
               "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),                            ",
               "              TD.GZTD008                                                              ",
               "             ),',','.'),' ',''))),'.',',')    DZIB008,                                ",
               "       TRIM(IB.DZIB012)                       DZIB012                                 ",
               "  FROM DS.DZIB_T IB                                                                   ",
               "       LEFT OUTER JOIN DS.GZTD_T TD ON TD.GZTD001 = IB.DZIB006                        ",
               ls_dzib_sqlwhere,
               " ORDER BY 1                                                                           "

  PREPARE lpre_get_column_diff_by_database FROM ls_sql
  DECLARE lcur_get_column_diff_by_database CURSOR FOR lpre_get_column_diff_by_database

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_column_diff_by_database
  FOREACH lcur_get_column_diff_by_database INTO lo_diff_columns[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF 
    
    LET li_rec_cnt = li_rec_cnt + 1 
    
  END FOREACH 
  CLOSE lcur_get_column_diff_by_database
  
  IF li_rec_cnt > 1 THEN
    CALL lo_diff_columns.deleteElement(li_rec_cnt)
  END If  
  
  FREE lpre_get_column_diff_by_database
  FREE lcur_get_column_diff_by_database

  IF li_rec_cnt >= 2 THEN
    LET lb_different = TRUE
  END IF  

  LET lo_different.* = lo_diff_columns.*
  
  RETURN lb_different, lo_different
  
END FUNCTION

#取得 Constraint 資料的比對(TableEditor)
FUNCTION sadzp310_asmt_get_constraint_diff_by_design_data(p_jsonobj)
  DEFINE
    p_jsonobj     util.JSONObject # "owner", "tablename", "stand_cust"
  DEFINE
    li_rec_cnt          INTEGER,
    ls_owner            STRING,
    ls_table_name       STRING,
    ls_where            STRING,
    ls_sql              STRING,
    ls_stand_cust       STRING,
    lo_constraint_diff  DYNAMIC ARRAY OF T_TABLE_CONSTRAINT
  DEFINE
    lb_return BOOLEAN,
    lo_return DYNAMIC ARRAY OF T_TABLE_CONSTRAINT
    
  LET ls_owner      = IIF (p_jsonobj.has("owner"), p_jsonobj.get("owner"), NULL)
  LET ls_table_name = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL)
  LET ls_stand_cust = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL)
  
  LET lb_return = FALSE
  LET lo_return = NULL
  
  LET ls_where = " WHERE IB.DZIB001 = '",ls_table_name.toLowerCase(), "' ",
                 "   AND IB.DZIB004 = 'Y' "
  IF (ls_stand_cust IS NOT NULL) AND 
      (ls_stand_cust = cs_dgenv_cust OR 
       ls_stand_cust = cs_dgenv_stand) THEN
    LET ls_where = ls_where, " AND IB.DZIB029 = '", ls_stand_cust, "' "
  END IF 
  
  LET ls_sql = "SELECT UPPER(IB.DZIB001)        TABLE_NAME,                                           ",
               "       UPPER(IB.DZIB001||'_PK') CONSTRAINT_NAME,                                      ",
               "       UPPER('P')               CONSTRAINT_TYPE,                                      ",
               "       UPPER(LISTAGG(IB.DZIB002,',') WITHIN GROUP (ORDER BY IB.DZIB021)) COLUMN_NAMES ",
               "  FROM DZIB_T IB                                                                      ",
               ls_where, 
               " GROUP BY UPPER(IB.DZIB001),UPPER(IB.DZIB001||'_PK')                                  ",
               "MINUS                                                                                 ",
               "SELECT ACS.TABLE_NAME,                                                                ",
               "       ACS.CONSTRAINT_NAME,                                                           ",
               "       DECODE(ACS.CONSTRAINT_TYPE, 'R', 'R', ACS.CONSTRAINT_TYPE) CONSTRAINT_TYPE,    ",
               "       ACC.COLUMN_NAMES                                                               ",
               "  FROM DBA_CONSTRAINTS ACS                                                            ",
               "  LEFT OUTER JOIN (                                                                   ",
               "                   SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES  ",
               "                     FROM DBA_CONS_COLUMNS ACCS                                                                                                             ",
               "                    GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                ",
               "                  ) ACC ON ACC.CONSTRAINT_NAME = ACS.CONSTRAINT_NAME                                                                                        ",
               "                       AND ACC.OWNER           = ACS.OWNER                                                                                                  ",
               " WHERE 1 = 1                                               ",
               "   AND ACS.TABLE_NAME = '",ls_table_name.toUpperCase(),"'  ",
               "   AND ACS.OWNER      = '",ls_owner.toUpperCase(),"'       "
               
  PREPARE lpre_get_constraint_diff_by_design_data FROM ls_sql
  DECLARE lcur_get_constraint_diff_by_design_data CURSOR FOR lpre_get_constraint_diff_by_design_data

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_constraint_diff_by_design_data
  FOREACH lcur_get_constraint_diff_by_design_data INTO lo_constraint_diff[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_constraint_diff_by_design_data
  IF li_rec_cnt > 1 THEN
    CALL lo_constraint_diff.deleteElement(li_rec_cnt)
  END If  
  
  FREE lpre_get_constraint_diff_by_design_data
  FREE lcur_get_constraint_diff_by_design_data

  IF li_rec_cnt >= 2 THEN
    LET lb_return = TRUE
  END IF  

  LET lo_return.* = lo_constraint_diff.*
  
  RETURN lb_return, lo_return  

END FUNCTION

################################################################################
# Descriptions...: 檢查設計表與實體表格式是否相同並標記 
# Memo...........: 檢查資料庫與設計資料是否相符行為會需要較長時見
# Usage..........: CALL sadzp310_asmt_chk_tbl_diff(p_jsonobj) RETURNING lb_ret
# Input parameter: p_jsonobj ,JSONObject 帶有參數 tablename, stand_cust
#                : tablename 物件名稱
#                : stand_cust 物件標準或者客製
# Return code....: lb_ret 作業是否成功
#                : 
# Date & Author..: #160309-00001#1 by circlelai
# Modify.........: 
################################################################################
FUNCTION sadzp310_asmt_chk_tbl_diff(p_jsonobj)
DEFINE 
  p_jsonobj util.JSONObject  #傳入參數 tablename, stand_cust
DEFINE
  lb_chk_diff_add   BOOLEAN,
  lb_chk_diff_del   BOOLEAN,
  lb_chk_diff       BOOLEAN,
  lb_success        BOOLEAN,
  li_idx1           INTEGER,
  ls_tbl_name       STRING, -- table name
  ls_stu_cus        STRING, --標準's' or 客製'c'
  lo_jsonobj        util.JSONObject,
  lo_db_coxn        T_DB_COXN_STR,  --連結資料庫資訊
  lo_diff_add_col   DYNAMIC ARRAY OF T_DIFF_COLUMNS,  #內容紀錄設計表格有欄位在實體表格不存在，需要新增實體表格欄位
  lo_diff_del_col   DYNAMIC ARRAY OF T_DIFF_COLUMNS,  #內容紀錄實體表格有欄位在設計表格不存在，需要刪除實體表格欄位
  lo_object_type    DYNAMIC ARRAY OF T_OBJECT_TYPE
DEFINE 
  lb_ret  BOOLEAN 
  
  LET lo_jsonobj = p_jsonobj 
  LET ls_tbl_name = IIF (lo_jsonobj.has("tablename")
                          , lo_jsonobj.get("tablename"), NULL)
  LET ls_stu_cus = IIF (lo_jsonobj.has("stand_cust")
                        , lo_jsonobj.get("stand_cust")
                        , cs_dgenv_stand) --未輸入則取標準設計數據

  LET lb_chk_diff_add = FALSE
  LET lb_chk_diff_del = FALSE  
  LET lb_chk_diff = FALSE

  IF ls_tbl_name.trim() IS NOT NULL THEN 
    --比對設計數據與實際數據
    CALL sadzp310_asmt_get_alter_table_list(ls_tbl_name) RETURNING lo_object_type
    IF (lo_object_type.getLength() > 0) THEN
      FOR li_idx1 = 1 TO  lo_object_type.getLength()
        # 取得資料庫連接資訊
        CALL sadzp310_db_get_db_connect_string(lo_object_type[li_idx1].ot_schema) 
              RETURNING lo_db_coxn.* 
        #取得設計資料對照實際表格之間的比對差異
        CALL lo_jsonobj.put("owner", lo_db_coxn.db_username) 
        CALL sadzp310_asmt_get_column_diff_by_design_data(lo_jsonobj)
             RETURNING lb_chk_diff_add,lo_diff_add_col 
        #取得實際表格對照設計資料之間的比對差異 
        CALL sadzp310_asmt_get_column_diff_by_database(lo_jsonobj) 
             RETURNING lb_chk_diff_del,lo_diff_del_col 
        IF lb_chk_diff_add OR lb_chk_diff_del THEN
          LET lb_chk_diff = TRUE
          EXIT FOR 
        END IF 
        
      END FOR 
      
    END IF 

    #重置異動確認碼為'Y'
    CALL lo_jsonobj.put("alter_code", "Y")
    CALL sadzp310_db_update_alter_code(lo_jsonobj)
    CALL lo_jsonobj.remove("alter_code")  
    
    # 設計資料與實體資料不符，更新標籤
    IF lb_chk_diff THEN
      BEGIN WORK
      IF lb_chk_diff_add THEN
        IF (lo_diff_add_col.getLength() > 0) THEN  #標記欄位與實體不符
          CALL lo_jsonobj.put("chk_diff", 1)
          FOR li_idx1 = 1 TO lo_diff_add_col.getLength()
            CALL lo_jsonobj.put("col_name", lo_diff_add_col[li_idx1].DZIB002)
            CALL sadzp310_db_update_dzib_alter_code(lo_jsonobj) RETURNING lb_success 
          END FOR 
            
        END IF
          
      END IF
      COMMIT WORK
      IF (lo_jsonobj.has("col_name")) THEN CALL lo_jsonobj.remove("col_name") END IF 
      IF (lo_jsonobj.has("chk_diff")) THEN CALL lo_jsonobj.remove("chk_diff") END IF 
        
      CALL lo_jsonobj.put("chk_diff", 1)
      CALL sadzp310_db_update_dzia_alter_code(lo_jsonobj) RETURNING lb_success
      CALL lo_jsonobj.remove("chk_diff")
    END IF

  END IF 
  
  LET lb_ret = lb_chk_diff
  RETURN lb_ret
  
END FUNCTION 
