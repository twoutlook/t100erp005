{
  異動型態    異動單號       日 期       異動者      異動內容
  ========= ============= ========== ========== ===============================================
  Modify                  20161220   Ernestliou 1.針對客戶自行新增的欄位, 一律不處理 drop 程序
  Modify                  20170214   Ernestliou 1.表格重建時對應 Trigger 的異動
}

&include "../4gl/sadzi140_mcr.inc"

IMPORT util
IMPORT OS 
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzi140_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"

&include "../4gl/sadzi140_type.inc"

PRIVATE TYPE T_COLUMN_DIFF_W_COMMENT RECORD
              dzev005  LIKE dzev_t.dzev005,
              dzev006  LIKE dzev_t.dzev006,
              dzev007  LIKE dzev_t.dzev007,
              dzev008  LIKE dzev_t.dzev008,
              dzev009  LIKE dzev_t.dzev009,
              dzev021  LIKE dzev_t.dzev021,
              comments VARCHAR(4000)
            END RECORD

&ifndef DEBUG
GLOBALS "../../cfg/top_global.inc"
&else
GLOBALS "../../cfg/top_global.inc"
&endif

DEFINE
  mo_columns_data_in_mem DYNAMIC ARRAY OF T_COLUMNS_DATA_IN_MEM

FUNCTION sadzi140_db_create_table_for_users(p_schema_sql,p_table_name,p_module_name,p_user,p_lang)
DEFINE
  p_schema_sql  STRING,
  p_table_name  STRING,
  p_module_name STRING,
  p_user        STRING,
  p_lang        STRING
DEFINE
  ls_schema_sql  STRING,
  ls_table_name  STRING,
  ls_module_name STRING,
  ls_user        STRING,
  ls_lang        STRING,
  ls_sql         STRING,
  ls_separator   STRING, 
  li_counts      INTEGER,
  ls_user_name   VARCHAR(100)

  LET ls_schema_sql  = p_schema_sql
  LET ls_table_name  = p_table_name
  LET ls_module_name = p_module_name
  LET ls_user        = p_user
  LET ls_lang        = p_lang

  IF ls_user IS NULL THEN
    #取得DB使用者
    LET ls_sql = "SELECT DA.GZDA001        ",
                 "  FROM GZDA_T DA         ",
                 " WHERE 1=1               ",
                 "   AND DA.GZDA005  = 'Y' ", 
                 "   AND DA.GZDASTUS = 'Y' ",
                 " ORDER BY DA.GZDA001     "

    DISPLAY ls_sql
    
    PREPARE lpre_get_db_users FROM ls_sql
    DECLARE lcur_get_db_users CURSOR FOR lpre_get_db_users
  
    OPEN lcur_get_db_users
    FOREACH lcur_get_db_users INTO ls_user_name
      IF SQLCA.sqlcode THEN
        EXIT FOREACH
      END IF

      LET li_counts = li_counts + 1
  
      LET ls_user = ls_user_name
      DISPLAY "Create Table for multi USER : ",ls_user
      CALL sadzi140_db_create_table(ls_schema_sql,ls_table_name,ls_module_name,ls_user.toLowerCase(),ls_lang)
  
    END FOREACH
    CLOSE lcur_get_db_users
    
    FREE lpre_get_db_users
    FREE lcur_get_db_users
  ELSE
    DISPLAY "Create Table for single USER : ",ls_user
    CALL sadzi140_db_create_table(ls_schema_sql,ls_table_name,ls_module_name,ls_user.toLowerCase(),ls_lang)
  END IF  

END FUNCTION

FUNCTION sadzi140_db_create_table(p_schema_sql,p_table_name,p_module_name,p_user,p_lang)
DEFINE
  p_schema_sql  STRING,
  p_table_name  STRING,
  p_module_name STRING,
  p_user        STRING,
  p_lang        STRING 
DEFINE
  ls_schema_sql       STRING,
  ls_table_name       STRING,
  ls_module_name      STRING,
  ls_user             STRING,
  ls_lang             STRING, 
  ls_schema_file_name STRING,
  ls_erp_env          STRING,
  ls_separator        STRING,  
  lo_db_connstr       T_DB_CONNSTR
  
  LET ls_schema_sql  = p_schema_sql
  LET ls_table_name  = p_table_name
  LET ls_module_name = p_module_name
  LET ls_lang        = p_lang

  LET ls_separator = os.Path.separator()

  LET ls_erp_env = FGL_GETENV(ls_module_name)
  LET ls_schema_file_name = ls_erp_env,ls_separator,"sch",ls_separator,ls_lang,ls_separator,ls_table_name,".sch"

  #取得資料庫相關連結資訊
  &ifndef DEBUG
  IF p_user = "" THEN
    LET ls_user = cs_master_user
  ELSE
    LET ls_user = p_user
  END IF  
  &else
  LET ls_user = "local"
  &endif
  
  CALL sadzi140_db_get_db_connect_string(ls_user) RETURNING lo_db_connstr.*
  
  ## 目前先呼叫 SQLPLUS 執行 Schema File
  RUN "sqlplus "||lo_db_connstr.db_username||"/"||lo_db_connstr.db_password||"@"||lo_db_connstr.db_source||" @"||ls_schema_file_name

END FUNCTION

FUNCTION sadzi140_db_gen_table_schema(p_table_name,p_module_name,p_batch_mode,p_lang)
DEFINE
  p_table_name  STRING,
  p_module_name STRING,
  p_batch_mode  BOOLEAN,
  p_lang        STRING
DEFINE
  ls_table_name       STRING,
  ls_module_name      STRING,
  lb_batch_mode       BOOLEAN,  
  ls_lang             STRING,
  ##########################
  ls_table_memo       STRING,
  ls_table_contents   STRING,
  ls_table_constraint STRING,
  ls_table_index      STRING,
  ls_table_grant      STRING,
  ls_exit_sign        STRING,
  ls_table_full       STRING,
  ##########################
  ls_erp_env          STRING,
  lchannel_write      base.Channel,
  ls_schema_filename  STRING,
  ls_replace_arg      STRING,
  ls_separator        STRING
  
  LET ls_table_name  = p_table_name
  LET ls_module_name = p_module_name
  LET lb_batch_mode  = p_batch_mode
  LET ls_lang        = p_lang

  LET ls_separator = os.Path.separator()
  
  &ifndef DEBUG
  LET ls_erp_env = FGL_GETENV(ls_module_name)
  LET ls_schema_filename = ls_erp_env,ls_separator,"sch",ls_separator,ls_lang,ls_separator,ls_table_name,".sch"
  &else
  LET ls_erp_env = FGL_GETENV("TEMPDIR")
  LET ls_schema_filename = ls_erp_env,ls_separator,ls_table_name,"_",ls_lang,".sch"
  &endif
  
  LET ls_exit_sign = "exit;"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  CALL sadzi140_db_gen_table_memo(ls_table_name) RETURNING ls_table_memo
  CALL sadzi140_db_gen_table_contents(ls_table_name) RETURNING ls_table_contents
  CALL sadzi140_db_gen_table_constraint("",ls_table_name,FALSE) RETURNING ls_table_constraint
  CALL sadzi140_db_gen_table_index("",ls_table_name,FALSE) RETURNING ls_table_index
  CALL sadzi140_db_gen_table_grant(ls_table_name) RETURNING ls_table_grant

  LET ls_table_full = ls_table_memo,"\n",
                      ls_table_contents,"\n",
                      ls_table_constraint,"\n",
                      ls_table_index,"\n",
                      ls_table_grant,"\n",
                      ls_exit_sign
  
  #開檔寫入
  TRY
    DISPLAY "Schema File : ",ls_schema_filename
    CALL lchannel_write.openFile(ls_schema_filename, "w" )
    CALL lchannel_write.write(ls_table_full)
    #關檔
    CALL lchannel_write.close()
    IF lb_batch_mode THEN
      DISPLAY cs_success_tag,"Generate Table Schema : "||ls_table_name
    ELSE
      IF lb_batch_mode THEN
        DISPLAY cs_success_tag,"Generate Table Schema : "||ls_table_name
      ELSE
        #CALL sadzi140_rev_view_logresult(ls_table_full)
        DISPLAY cs_success_tag,"Generate Table Schema : "||ls_table_name
      END IF  
    END IF  
  CATCH
    LET ls_table_full = ""
    DISPLAY cs_error_tag,"Generate Table Schema : "||ls_table_name
    IF NOT lb_batch_mode THEN
      #Create Table Schema ERROR
      LET ls_replace_arg = ls_table_name,"|",ls_module_name,"|",SQLCA.SQLCODE,"|"
      CALL sadzp000_msg_show_error(NULL, 'adz-00085', ls_replace_arg, 1)
    END IF  
  END TRY  

  RETURN ls_table_full

END FUNCTION

FUNCTION sadzi140_db_gen_table_contents(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_line           STRING,
  ls_sql            STRING,
  ls_table_name     STRING,
  li_rec_count      INTEGER,
  li_counts         INTEGER,
  ls_comma          STRING, 
  ls_COL_LENGTH     STRING,
  lo_line_str_buf   base.StringBuffer,
  lo_table_contents RECORD
                      col_name    LIKE dzeb_t.dzeb002, 
                      data_type   VARCHAR(50),
                      col_length  VARCHAR(50),
                      default_val VARCHAR(50),
                      NULLABLE    VARCHAR(50),
                      col_desc    VARCHAR(300),
                      eb_col_desc LIKE dzeb_t.dzeb003 
                    END RECORD,
  lo_table_datas RECORD
                   col_name    STRING,
                   data_type   STRING,
                   col_length  STRING,
                   default_val STRING,
                   NULLABLE    STRING,
                   col_desc    STRING
                 END RECORD
DEFINE
  ls_Return   STRING

  LET ls_table_name   = p_table_name
  LET lo_line_str_buf = base.StringBuffer.create()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                       ",
               "  FROM DZEB_T BB                      ",
               " WHERE 1=1                            ",
               "   AND BB.DZEB001 = '",ls_table_name,"'" 

  PREPARE lpre_get_rec_counts FROM ls_sql
  DECLARE lcur_get_rec_counts CURSOR FOR lpre_get_rec_counts
  OPEN lcur_get_rec_counts
  FETCH lcur_get_rec_counts INTO li_rec_count
  CLOSE lcur_get_rec_counts
  FREE lcur_get_rec_counts
  FREE lpre_get_rec_counts

  #取得欄位資料
  LET ls_sql = "SELECT EB.DZEB002       COL_NAME,                                ",      
               "       TD.GZTD003       DATA_TYPE,                               ",
               "       TRIM(TD.GZTD008) COL_LENGTH,                              ",
               "       ''               DEFAULT_VAL,                             ",
               "       ''               NULLABLE,                                ",  
               "       EBL.DZEBL003     COL_DESC,                                ",
               "       EB.DZEB003       EB_COL_DESC                              ",
               "  FROM DZEB_T EB                                                 ",
               "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006      ",                                 
               "       LEFT OUTER JOIN DZEBL_T EBL ON EBL.DZEBL001 = EB.DZEB002  ",
               "                                  AND EBL.DZEBL002 = '",g_lang,"'",
               " WHERE 1=1                                                       ",
               "   AND EB.DZEB001 = '",ls_table_name,"'                          ",
               " ORDER BY EB.DZEB021,EB.DZEB002                                  " 

  PREPARE lpre_gen_table_contents FROM ls_sql
  DECLARE lcur_gen_table_contents CURSOR FOR lpre_gen_table_contents

  LET ls_line = "create table ",ls_table_name,"\n"
  CALL lo_line_str_buf.append(ls_line)
  LET ls_line = "(","\n"
  CALL lo_line_str_buf.append(ls_line)

  LET li_counts = 0
  OPEN lcur_gen_table_contents
  FOREACH lcur_gen_table_contents INTO lo_table_contents.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

    LET ls_COL_LENGTH = lo_table_contents.COL_LENGTH
    LET ls_COL_LENGTH = ls_COL_LENGTH.Trim()
    IF ls_COL_LENGTH IS NOT NULL THEN
      LET lo_table_datas.COL_LENGTH = "(",lo_table_contents.COL_LENGTH,")"
    ELSE  
      LET lo_table_datas.COL_LENGTH = lo_table_contents.COL_LENGTH
    END IF

    #2012.12.18 Remove
    {
    IF lo_table_contents.DEFAULT_VAL IS NOT NULL THEN
      LET lo_table_datas.DEFAULT_VAL = "DEFAULT ",lo_table_contents.DEFAULT_VAL
    ELSE
      LET lo_table_datas.DEFAULT_VAL = lo_table_contents.DEFAULT_VAL
    END IF

    IF lo_table_contents.NULLABLE = "N" THEN
      LET lo_table_datas.NULLABLE = "NOT NULL"
    ELSE   
      LET lo_table_datas.NULLABLE = "" 
    END IF
    }
    
    #最後一筆資料不加逗號
    IF li_counts = li_rec_count THEN
      LET ls_comma = ""
    ELSE
      LET ls_comma = ","
    END IF

    LET ls_line = lo_table_contents.col_name,7 SPACE,
                  lo_table_contents.data_type,
                  lo_table_datas.col_length,2 SPACE,
                  lo_table_datas.default_val,2 SPACE,
                  lo_table_datas.nullable,2 SPACE,
                  ls_comma,
                  sadzi140_db_get_comment_sign("B"),nvl(lo_table_contents.col_desc,lo_table_contents.eb_col_desc),sadzi140_db_get_comment_sign("E"),"\n"
    
    CALL lo_line_str_buf.append(ls_line)

  END FOREACH
  CLOSE lcur_gen_table_contents
  
  LET ls_line = ");"
  CALL lo_line_str_buf.append(ls_line)
  
  FREE lpre_gen_table_contents
  FREE lcur_gen_table_contents  

  LET ls_Return = lo_line_str_buf.toString()

  RETURN ls_Return
  
END FUNCTION

FUNCTION sadzi140_db_gen_table_memo(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_line          STRING,
  ls_sql           STRING,
  ls_table_name    STRING,
  lo_line_str_buf  base.StringBuffer,
  ls_comment_sign  STRING,
  lo_table_memo RECORD
                  tm_table_name LIKE dzea_t.dzea001,
                  tm_table_desc VARCHAR(300),
                  tm_table_memo LIKE dzea_t.dzea002,
                  tm_table_type LIKE dzea_t.dzea004,
                  tm_multi_lang LIKE dzea_t.dzea005,
                  tm_sys_table  LIKE dzea_t.dzea006
                END RECORD
DEFINE
  ls_return STRING               

  LET ls_table_name  = p_table_name
  LET lo_line_str_buf = base.StringBuffer.create()

  LET ls_sql = "SELECT EA.DZEA001   TABLE_NAME,                                  ",
               "       EAL.DZEAL003 TABLE_DESC,                                  ",
               "       EAL.DZEAL004 TABLE_MEMO,                                  ",
               "       EA.DZEA004   TABLE_TYPE,                                  ",
               "       EA.DZEA005   MULTI_LANG,                                  ",
               "       EA.DZEA006   SYS_TABLE                                    ",
               "  FROM DZEA_T EA                                                 ",
               "       LEFT OUTER JOIN DZEAL_T EAL ON EAL.DZEAL001 = EA.DZEA001  ",                                      
               "                                  AND EAL.DZEAL002 = '",g_lang,"'",
               " WHERE 1=1                                                       ",
               "   AND EA.DZEA001 = '",ls_table_name,"'                          ",
               "                                                                 "

  PREPARE lpre_gen_table_memo FROM ls_sql
  DECLARE lcur_gen_table_memo CURSOR FOR lpre_gen_table_memo

  LET ls_comment_sign = sadzi140_db_get_comment_sign("B")
  LET ls_comment_sign = ls_comment_sign,"\n" 
  CALL lo_line_str_buf.append(ls_comment_sign)
  
  OPEN lcur_gen_table_memo
  FOREACH lcur_gen_table_memo INTO lo_table_memo.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_line = "================================================================================","\n"
    CALL lo_line_str_buf.append(ls_line)
    LET ls_line = "檔案代號:",lo_table_memo.tm_table_name,"\n" 
    CALL lo_line_str_buf.append(ls_line)
    LET ls_line = "檔案名稱:",lo_table_memo.tm_table_desc,"\n" 
    CALL lo_line_str_buf.append(ls_line)
    LET ls_line = "檔案目的:",lo_table_memo.tm_table_memo,"\n" 
    CALL lo_line_str_buf.append(ls_line)
    LET ls_line = "上游檔案:","\n" 
    CALL lo_line_str_buf.append(ls_line)
    LET ls_line = "下游檔案:","\n" 
    CALL lo_line_str_buf.append(ls_line)
    LET ls_line = "檔案類型:",lo_table_memo.tm_table_type,"\n" 
    CALL lo_line_str_buf.append(ls_line)
    LET ls_line = "多語系檔案:",lo_table_memo.tm_multi_lang,"\n" 
    CALL lo_line_str_buf.append(ls_line)
    LET ls_line = "============.========================.==========================================","\n"  
    CALL lo_line_str_buf.append(ls_line)

  END FOREACH
  CLOSE lcur_gen_table_memo
  
  LET ls_comment_sign = sadzi140_db_get_comment_sign("E")
  CALL lo_line_str_buf.append(ls_comment_sign)

  FREE lpre_gen_table_memo
  FREE lcur_gen_table_memo  

  LET ls_return = lo_line_str_buf.toString()

  RETURN ls_return
                  
END FUNCTION

FUNCTION sadzi140_db_gen_table_constraint(p_owner,p_table_name,p_include_drop)
DEFINE
  p_owner        STRING,
  p_table_name   STRING,
  p_include_drop BOOLEAN
DEFINE
  ls_owner              STRING,
  ls_table_name         STRING,
  lb_include_drop       BOOLEAN,
  ls_line               STRING,
  ls_sql                STRING,
  lo_line_str_buf       base.StringBuffer,
  lb_constraint_exist   BOOLEAN,
  lb_index_exist        BOOLEAN,
  ls_drop_index         STRING,
  ls_enable_foreign_key STRING,
  ls_foreign_key_state  STRING,
  lo_table_constraint RECORD
                        key_table       VARCHAR(30),
                        key_name        VARCHAR(30),
                        key_type        VARCHAR(10),
                        key_columns     VARCHAR(512),
                        foreign_table   VARCHAR(30),
                        foreign_columns VARCHAR(30)
                      END RECORD
DEFINE
  ls_return STRING               

  LET ls_owner        = p_owner
  LET ls_table_name   = p_table_name
  LET lb_include_drop = p_include_drop
  
  LET lo_line_str_buf = base.StringBuffer.create()

  #取得 Foreign 是否啟動
  CALL sadzi140_db_get_parameter(cs_param_level_editor,cs_param_enable_foreign_key) RETURNING ls_enable_foreign_key
  LET ls_foreign_key_state = IIF(ls_enable_foreign_key=="Y",cs_state_enable,cs_state_disable)

  LET ls_sql = "SELECT BD.DZED001 KEY_TABLE,           ",  
               "       BD.DZED002 KEY_NAME,            ",
               "       BD.DZED003 KEY_TYPE,            ",
               "       BD.DZED004 KEY_COLUMNS,         ",
               "       BD.DZED005 FOREIGN_TABLE,       ",
               "       BD.DZED006 FOREIGN_COLUMNS      ",
               "  FROM DZED_T BD                       ",
               " WHERE BD.DZED001 = '",ls_table_name,"'",
               "   AND BD.DZED003 <> 'F'               "               

  PREPARE lpre_GenTableConstraint FROM ls_sql
  DECLARE lcur_GenTableConstraint CURSOR FOR lpre_GenTableConstraint

  OPEN lcur_GenTableConstraint
  FOREACH lcur_GenTableConstraint INTO lo_table_constraint.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_line = ""

    IF lo_table_constraint.KEY_TYPE = "P" THEN
      IF lb_include_drop THEN
        #檢查Constraint是否存在, 若存在則先 Drop 
        CALL sadzi140_db_check_table_constraint_exist(ls_owner,lo_table_constraint.KEY_TABLE,lo_table_constraint.key_name) RETURNING lb_constraint_exist
        IF lb_constraint_exist THEN
          LET ls_line = ls_line,
                        "alter table ",lo_table_constraint.KEY_TABLE," drop primary key cascade drop index;","\n"
        END IF    
        #檢查Index是否存在, 若存在則Drop 
        CALL sadzi140_db_check_table_index_exist(ls_owner,lo_table_constraint.KEY_NAME) RETURNING lb_index_exist
        IF lb_index_exist THEN
          CALL sadzi140_db_get_drop_index_procedure(lo_table_constraint.KEY_NAME) RETURNING ls_drop_index
          LET ls_line = ls_line,
                        "-- sadzi140_db_gen_table_constraint()","\n", 
                        ls_drop_index,"\n"
                        {
                        "drop index ",lo_table_constraint.KEY_NAME,";","\n"
                        }
        END IF                
        
      END IF
      LET ls_line = ls_line,
                    "alter table ",lo_table_constraint.KEY_TABLE,
                    " add constraint ",lo_table_constraint.KEY_NAME,
                    " primary key (",lo_table_constraint.KEY_COLUMNS,") enable validate;","\n"
    END IF

    IF lo_table_constraint.KEY_TYPE = "U" THEN
      LET ls_line = "alter table ",lo_table_constraint.KEY_TABLE,
                    " add constraint ",lo_table_constraint.KEY_NAME,
                    " unique (",lo_table_constraint.KEY_COLUMNS,") enable validate;","\n"
    END IF

    IF lo_table_constraint.KEY_TYPE = "R" THEN
      IF (ls_enable_foreign_key = "Y") THEN 
        LET ls_line = "alter table ",lo_table_constraint.KEY_TABLE,
                      " add constraint ",lo_table_constraint.KEY_NAME,
                      " foreign key (",lo_table_constraint.KEY_COLUMNS,")",
                      " references ",lo_table_constraint.FOREIGN_TABLE,
                      " (",lo_table_constraint.FOREIGN_COLUMNS,") ",ls_foreign_key_state,";","\n"
      ELSE
        
      END IF;      
    END IF
    
    CALL lo_line_str_buf.append(ls_line)

  END FOREACH
  CLOSE lcur_GenTableConstraint
  
  FREE lpre_GenTableConstraint
  FREE lcur_GenTableConstraint  

  LET ls_return = lo_line_str_buf.toString()

  RETURN ls_return
                  
END FUNCTION

FUNCTION sadzi140_db_get_drop_index_procedure(p_index_name)
DEFINE
  p_index_name STRING
DEFINE
  ls_index_name STRING,
  ls_procedure  STRING
DEFINE
  ls_return STRING  

  LET ls_index_name = p_index_name.toUpperCase()

  LET ls_procedure = "-- Drop index inline procedure.                                                      ","\n",
                     "SET SERVEROUTPUT ON                                                                  ","\n",
                     "DECLARE                                                                              ","\n",
                     "  INDEX_NOT_EXISTS EXCEPTION;                                                        ","\n",
                     "  PRAGMA EXCEPTION_INIT(INDEX_NOT_EXISTS, -1418);                                    ","\n",
                     "BEGIN                                                                                ","\n",
                     "  DBMS_OUTPUT.ENABLE(100000);                                                        ","\n",
                     "  EXECUTE IMMEDIATE ('DROP INDEX ",ls_index_name,"');                                ","\n",
                     "EXCEPTION                                                                            ","\n",
                     "  WHEN INDEX_NOT_EXISTS THEN                                                         ","\n",
                     "    DBMS_OUTPUT.PUT_LINE('",cs_warning_tag," INDEX ",ls_index_name," NOT EXISTS.');  ","\n",
                     "END;                                                                                 ","\n",
                     "/                                                                                    "

  LET ls_return =  ls_procedure

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_gen_table_index(p_owner,p_table_name,p_include_drop)
DEFINE
  p_owner        STRING,
  p_table_name   STRING,
  p_include_drop BOOLEAN
DEFINE
  ls_owner        STRING,
  ls_tablename    STRING,
  lb_include_drop BOOLEAN,
  ls_line         STRING,
  ls_sql          STRING,
  ls_unique       STRING,
  #lo_line_str_buf base.StringBuffer,
  lb_index_exist  BOOLEAN,
  lo_table_index RECORD
                   index_table   VARCHAR(50),
                   index_name    VARCHAR(50),
                   index_type    VARCHAR(10),
                   index_columns VARCHAR(150)
                 END RECORD
DEFINE
  ls_return STRING               

  LET ls_owner        = p_owner
  LET ls_tablename    = p_table_name
  LET lb_include_drop = p_include_drop
  
  #LET lo_line_str_buf = base.StringBuffer.create()
  
  LET ls_unique = "";

  LET ls_sql = "SELECT BC.DZEC001 INDEX_TABLE,        ",  
               "       BC.DZEC002 INDEX_NAME,         ",
               "       BC.DZEC003 INDEX_TYPE,         ",
               "       BC.DZEC004 INDEX_COLUMNS       ",
               "  FROM DZEC_T BC                      ",
               " WHERE BC.DZEC001 = '",ls_tablename,"'"

  PREPARE lpre_gen_table_index FROM ls_sql
  DECLARE lcur_gen_table_index CURSOR FOR lpre_gen_table_index

  OPEN lcur_gen_table_index
  FOREACH lcur_gen_table_index INTO lo_table_index.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    IF NVL(lo_table_index.INDEX_TYPE,cs_null_value) = "U" THEN
      LET ls_unique = "unique";
    ELSE
      LET ls_unique = "";
    END IF

    IF lb_include_drop THEN
      CALL sadzi140_db_check_table_index_exist(ls_owner,lo_table_index.INDEX_NAME) RETURNING lb_index_exist
      IF lb_index_exist THEN
        LET ls_line = ls_line,
                      "-- sadzi140_db_gen_table_index()","\n", 
                      "drop index ",lo_table_index.INDEX_NAME,";","\n"
      END IF                
    END IF
      
    LET ls_line = ls_line,
                  "create ",ls_unique," index ",lo_table_index.INDEX_NAME,
                  " on ",lo_table_index.INDEX_TABLE,
                  " (",lo_table_index.INDEX_COLUMNS,");","\n"
                  
    #CALL lo_line_str_buf.append(ls_line)

  END FOREACH
  CLOSE lcur_gen_table_index
  
  FREE lpre_gen_table_index
  FREE lcur_gen_table_index  

  LET ls_return = ls_line #lo_line_str_buf.toString()

  RETURN ls_return
                  
END FUNCTION

FUNCTION sadzi140_db_gen_table_grant(p_table_name)
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
               "       BJ.DZEJ006 privileges_user  ", 
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

FUNCTION sadzi140_db_exec_SQL(p_sql,p_batch_mode)
DEFINE
  p_sql STRING,
  p_batch_mode BOOLEAN
DEFINE
  ls_sql         STRING,
  lb_batch_mode  BOOLEAN,
  ls_replace_arg STRING

  LET ls_sql = p_sql
  LET lb_batch_mode = p_batch_mode

  BEGIN WORK

  TRY
    PREPARE lpre_exec_sql FROM ls_sql
    EXECUTE lpre_exec_sql
    COMMIT WORK
  CATCH
    IF lb_batch_mode THEN
      DISPLAY cs_error_tag,"Execute SQL ",ls_sql," not success." 
    ELSE
      LET ls_replace_arg = ls_sql,"|"
      CALL sadzp000_msg_show_error(NULL, 'adz-00086', ls_replace_arg, 1) 
    END IF   
    ROLLBACK WORK
  END TRY  
  
END FUNCTION

FUNCTION sadzi140_db_exec_SQL_no_commit(p_sql,p_batch_mode)
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
    IF lb_batch_mode THEN
      DISPLAY cs_error_tag,"Execute SQL ",ls_sql," not success." 
    ELSE
      LET ls_replace_arg = ls_sql,"|"
      CALL sadzp000_msg_show_error(NULL, 'adz-00086', ls_replace_arg, 1)
    END IF   
  END TRY  
  
END FUNCTION

FUNCTION sadzi140_db_run_SQL(p_sql)
DEFINE
  p_sql STRING
DEFINE
  ls_sql STRING
DEFINE
  lb_return BOOLEAN 
  
  LET ls_sql = p_sql

  LET lb_return = TRUE
  
  TRY
    PREPARE lpre_run_SQL_no_commit FROM ls_sql
    EXECUTE lpre_run_SQL_no_commit
  CATCH
    LET lb_return = FALSE
  END TRY  

  FREE lpre_run_SQL_no_commit

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_db_get_fgl_connect_string(p_db_name)
DEFINE
  p_db_name STRING
DEFINE
  lo_db_connstr T_DB_CONNSTR,
  ls_db_spec    STRING,
  ls_db_str     STRING

  LET ls_db_spec = p_db_name
  LET ls_db_str  = "dbi.database.",ls_db_spec,"."
  
  LET lo_db_connstr.db_source   = FGL_GETRESOURCE(ls_db_str||"source")
  LET lo_db_connstr.db_username = FGL_GETRESOURCE(ls_db_str||"username")
  LET lo_db_connstr.db_password = FGL_GETRESOURCE(ls_db_str||"password")
  LET lo_db_connstr.db_schema   = FGL_GETRESOURCE(ls_db_str||"schema")
  LET lo_db_connstr.db_sid      = FGL_GETENV("ORACLE_SID")
  
  RETURN lo_db_connstr.*
  
END FUNCTION

FUNCTION sadzi140_db_get_db_connect_string(p_db_name)
DEFINE
  p_db_name STRING
DEFINE
  ls_db_name      STRING,
  ls_db_sid       STRING,
  ls_privacy_word STRING,
  lb_success      BOOLEAN,
  lo_db_connstr   T_DB_CONNSTR,
  ls_sql          STRING
DEFINE
  lo_return T_DB_CONNSTR  
  
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
               " WHERE 1=1                               ",
               "   AND DA.GZDA001  = '",ls_db_name,"'    ",
               "   AND DA.GZDA005  = 'Y'                 ", 
               "   AND DA.GZDASTUS = 'Y'                 "

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

FUNCTION sadzi140_db_get_all_db_connect_string()
DEFINE
  ls_db_sid       STRING,
  li_rec_cnt      INTEGER,
  lo_db_connstr   DYNAMIC ARRAY OF T_DB_CONNSTR,
  ls_privacy_word STRING,
  lb_success      BOOLEAN,
  ls_sql          STRING
DEFINE
  lo_return DYNAMIC ARRAY OF T_DB_CONNSTR  
  
  LET ls_db_sid = FGL_GETENV("ORACLE_SID")
  
  LET ls_sql = "SELECT '",ls_db_sid,"'  DB_SOURCE,       ",
               "       DA.GZDA003       DB_USERNAME,     ",
               "       DA.GZDA004       DB_PASSWORD,     ",
               "       DA.GZDA001       DB_SCHEMA,       ",
               "       '",ls_db_sid,"'  DB_SID,          ",
               "       ''               DB_SQL_FILENAME, ",
               "       ''               DB_VERSION       ",
               "  FROM GZDA_T DA                         ",
               " WHERE 1=1                               ",  
               "   AND DA.GZDA005  = 'Y'                 ", 
               "   AND DA.GZDASTUS = 'Y'                 "

  PREPARE lpre_get_all_db_connect_string FROM ls_sql
  DECLARE lcur_get_all_db_connect_string CURSOR FOR lpre_get_all_db_connect_string

  INITIALIZE lo_db_connstr TO NULL

  LET li_rec_cnt = 1
  OPEN lcur_get_all_db_connect_string
  FOREACH lcur_get_all_db_connect_string INTO lo_db_connstr[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    &ifndef DEBUG
    IF (lo_db_connstr[li_rec_cnt].db_username = cs_master_db) THEN
      CALL sadzi140_db_get_privacy_word() RETURNING lb_success,ls_privacy_word
      IF lb_success THEN 
        LET lo_db_connstr[li_rec_cnt].db_password = cl_hashkey_base65_anti(ls_privacy_word)
      ELSE 
        LET lo_db_connstr[li_rec_cnt].db_password = cl_hashkey_base65_anti(lo_db_connstr[li_rec_cnt].db_password)
      END IF 
    ELSE 
      LET lo_db_connstr[li_rec_cnt].db_password = cl_hashkey_base65_anti(lo_db_connstr[li_rec_cnt].db_password)
    END IF 
    &endif
    
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_all_db_connect_string

  CALL lo_db_connstr.deleteElement(li_rec_cnt)
  
  FREE lpre_get_all_db_connect_string
  FREE lcur_get_all_db_connect_string

  LET lo_return = lo_db_connstr
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi140_db_get_valid_schema_list()
DEFINE
  li_rec_cnt      INTEGER,
  lo_schema_list  DYNAMIC ARRAY OF T_SCHEMA_LIST, 
  ls_sql          STRING
DEFINE
  lo_return DYNAMIC ARRAY OF T_SCHEMA_LIST  
  
  LET ls_sql = " SELECT DA.GZDA003                       ",
               "   FROM GZDA_T DA                        ", 
               "  WHERE 1=1                              ", 
               "    AND DA.GZDA003 NOT IN ('ds','dsdemo')",
               "    AND DA.GZDA005  = 'Y'                ", 
               "    AND DA.GZDASTUS = 'Y'                ",
               "  ORDER BY DA.GZDA003                    "  

  PREPARE lpre_get_valid_schema_list FROM ls_sql
  DECLARE lcur_get_valid_schema_list CURSOR FOR lpre_get_valid_schema_list

  INITIALIZE lo_schema_list TO NULL

  LET li_rec_cnt = 1
  
  OPEN lcur_get_valid_schema_list
  FOREACH lcur_get_valid_schema_list INTO lo_schema_list[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_valid_schema_list
  CALL lo_schema_list.deleteElement(li_rec_cnt)
  
  FREE lpre_get_valid_schema_list
  FREE lcur_get_valid_schema_list

  LET lo_return = lo_schema_list
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi140_db_get_table_type_by_dsdemo(p_table_name,p_schema_name)
DEFINE 
  p_table_name   STRING,
  p_schema_name  STRING
DEFINE
  ls_table_name  STRING,
  ls_schema_name STRING,
  li_rec_cnt     INTEGER,
  lo_table_type  T_TABLE_TYPE, 
  ls_sql         STRING
DEFINE
  lo_return T_TABLE_TYPE  

  LET ls_table_name  = p_table_name.toLowerCase()
  LET ls_schema_name = p_schema_name.toLowerCase()

  #從 DSDEMO 抓參考資料
  LET ls_sql = "SELECT EU.DZEU001,DA.GZDA001 DZEU002,EU.DZEU003 ,                 ",
               "       EU.DZEU004,TO_CHAR(EUN.DZEU005) DZEU005                    ",
               "  FROM DZEU_T EU                                                  ",
               "  LEFT OUTER JOIN (                                               ",
               "                    SELECT EU3.DZEU001,MAX(EU3.DZEU005)+1 DZEU005 ",
               "                      FROM DZEU_T EU3                             ",
               "                     GROUP BY EU3.DZEU001                         ",
               "                  ) EUN ON EUN.DZEU001 = EU.DZEU001               ",
               "  LEFT OUTER JOIN GZDA_T DA ON DA.GZDA003 = '",ls_schema_name,"'  ", 
               "                           AND DA.GZDA005 = 'Y'                   ",
               " WHERE EU.DZEU001 = '",ls_table_name,"'                           ",
               "   AND EU.DZEU002 = (                                             ",
               "                      SELECT DA.GZDA001                           ",
               "                        FROM GZDA_T DA                            ",
               "                       WHERE DA.GZDA001 = EU.DZEU002              ",
               "                         AND DA.GZDA003 = '",cs_slave_user,"'     ",
               "                    )                                             ",
               "   AND NOT EXISTS (                                               ",
               "                    SELECT 1                                      ",
               "                      FROM DZEU_T EU2                             ",
               "                     WHERE EU2.DZEU001 = EU.DZEU001               ",
               "                       AND EU.DZEU002 = '",ls_schema_name,"'      ",
               "                  )                                               "

  PREPARE lpre_get_table_type_by_dsdemo FROM ls_sql
  DECLARE lcur_get_table_type_by_dsdemo CURSOR FOR lpre_get_table_type_by_dsdemo

  INITIALIZE lo_table_type TO NULL

  LET li_rec_cnt = 1
  
  OPEN lcur_get_table_type_by_dsdemo
  FETCH lcur_get_table_type_by_dsdemo INTO lo_table_type.*
  CLOSE lcur_get_table_type_by_dsdemo
  
  FREE lpre_get_table_type_by_dsdemo
  FREE lcur_get_table_type_by_dsdemo

  LET lo_return.* = lo_table_type.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi140_db_get_privacy_word()
DEFINE
  ls_file_name    STRING,
  lo_channel      base.Channel,
  ls_privacy_word STRING,
  lb_file_exist   BOOLEAN
DEFINE
  ls_result STRING,
  lb_result BOOLEAN
  
  LET ls_file_name = os.Path.join(os.Path.join(FGL_GETENV("FBIN"),"4gl"),"gendbs.inc")

  IF os.Path.exists(ls_file_name) THEN
    LET lb_file_exist = TRUE
    LET lo_channel = base.Channel.create()
    CALL lo_channel.openFile(ls_file_name.trim(),"r")
    WHILE lo_channel.read(ls_privacy_word)
    END WHILE
    CALL lo_channel.close()
  ELSE
    LET lb_file_exist = FALSE
    DISPLAY cs_error_tag," Get privacy file error !!"
  END IF

  LET lb_result = lb_file_exist
  LET ls_result = ls_privacy_word

  RETURN lb_result,ls_result
  
END FUNCTION      

FUNCTION sadzi140_db_sqlplus(p_db_connstr)
DEFINE
  p_db_connstr T_DB_CONNSTR
DEFINE
  ls_sqlplus_str STRING,
  ls_message     STRING,
  ls_log_file    STRING,
  lo_db_connstr  T_DB_CONNSTR,
  ls_file_list   STRING,
  ls_return      STRING

  LET lo_db_connstr.* = p_db_connstr.*

  LET ls_sqlplus_str = "sqlplus ",lo_DB_CONNSTR.db_username,"/",lo_DB_CONNSTR.db_password,"@",lo_DB_CONNSTR.db_source||" @"||lo_DB_CONNSTR.db_sql_filename
  #DISPLAY ls_sqlplus_str
  CALL sadzi140_db_run_and_catch_log(ls_sqlplus_str) RETURNING ls_message
  #RUN ls_sqlplus_str
  CALL sadzi140_db_gen_log_file(ls_Message) RETURNING ls_log_file
  #DISPLAY "Log File : ",ls_log_file

  LET ls_file_list = ls_file_list,"SQL File : ",lo_DB_CONNSTR.db_sql_filename,"\n"
  LET ls_file_list = ls_file_list,"Log File : ",ls_log_file,"\n"
  LET ls_file_list = ls_file_list,ls_message
  
  LET ls_return = ls_file_list
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzi140_db_run_and_catch_log(p_command)
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

FUNCTION sadzi140_db_gen_log_file(p_log)
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
  CALL sadzi140_db_get_GUID() RETURNING ls_GUID 
  LET ls_log_filename = ls_temp_dir,ls_separator,"sadzi140_db_",ls_GUID,".log"
  
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

FUNCTION sadzi140_db_gen_db_schema(p_db_owner,p_table_name,p_table_type)
DEFINE
  p_db_owner   STRING,
  p_table_name STRING,
  p_table_type STRING  
DEFINE
  ls_db_owner   STRING,
  ls_table_name STRING, 
  ls_table_type STRING,  
  ls_command    STRING,
  lb_success    BOOLEAN,
  ls_message    STRING
DEFINE
  lb_return BOOLEAN   

  LET ls_db_owner   = p_db_owner
  LET ls_table_name = p_table_name
  LET ls_table_type = NVL(p_table_type,cs_null_value)

  LET lb_success = TRUE
  
  LET ls_command = "r.s ",ls_db_owner.trim()," ",ls_table_name.trim()
  DISPLAY cs_command_tag,ls_command

  -- 20160513
  IF ls_table_type = "L" THEN  
    &ifndef DEBUG
    IF g_bgjob <> "Y" THEN 
      CALL cl_progress_bar(2)
      CALL cl_progress_ing(ls_command)
    END IF   
    CALL cl_cmdrun_openpipe("r.s",ls_command,TRUE) RETURNING lb_success,ls_message
    IF g_bgjob <> "Y" THEN
      CALL cl_progress_ing(NVL(ls_message,cs_status_finalizing))
    END IF   
    &endif
  ELSE 
    RUN ls_command WITHOUT WAITING
  END IF;  

  LET lb_return = lb_success

  RETURN lb_return

END FUNCTION

#取得各DB Tool的SQL註解符號
#p_Sign--B:取得開始註解符號; E:取得結束註解符號
FUNCTION sadzi140_db_get_comment_sign(p_sign)
DEFINE 
  p_sign   CHAR(02)
DEFINE 
  ls_sign    CHAR(02),
  ls_comment STRING,
  ls_return  STRING

  LET ls_sign   = p_sign
  LET ls_return = ""
   
  IF ls_sign = "B" THEN
    CASE cs_db_type
      WHEN "IFX" 
        LET ls_comment= "{ "
      WHEN "ORA" 
        LET ls_comment = "/* "
      WHEN "MSV" 
        LET ls_comment = "/* "
    END CASE
  ELSE
    CASE cs_db_type
      WHEN "IFX" 
        LET ls_comment = " }"
      WHEN "ORA" 
        LET ls_comment = " */"
      WHEN "MSV" 
        LET ls_comment = " */"
    END CASE
  END IF

  LET ls_return = ls_comment
 
  RETURN ls_return
   
END FUNCTION

FUNCTION sadzi140_db_gen_drop_script(p_table_name,p_type)
DEFINE
  p_table_name  STRING,
  p_type        STRING
DEFINE
  ##########################
  ls_drop_script         STRING,
  ls_drop_rebuild_script STRING,
  ls_exit_sign           STRING,
  ls_drop_full           STRING,
  ls_object_type         STRING,
  ##########################
  ls_table_name       STRING,
  ls_type             STRING,
  ls_random_name      STRING,
  ls_tempdir          STRING,
  lchannel_write      base.Channel,
  ls_sript_filename   STRING,
  ls_procedure_script STRING,
  ls_separator        STRING 
DEFINE
  ls_return STRING  
  
  LET ls_table_name = p_table_name
  LET ls_type      = p_type

  LET ls_separator = os.Path.separator()
  
  LET ls_tempdir = FGL_GETENV("TEMPDIR")
  CALL sadzi140_db_get_GUID() RETURNING ls_random_name 
  LET ls_sript_filename = ls_tempdir,ls_separator,ls_table_name,ls_random_name,".drp"
  
  LET ls_exit_sign = "exit;"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  IF ls_type = 'T' THEN
    LET ls_object_type = "TABLE"
    LET ls_drop_rebuild_script = "DROP TABLE ",ls_table_name,cs_rebuild_tail," CASCADE CONSTRAINTS"
    LET ls_drop_script = "DROP TABLE ",ls_table_name," CASCADE CONSTRAINTS"
  ELSE
    LET ls_object_type = "SYNONYM"
    LET ls_drop_rebuild_script = ""
    LET ls_drop_script = "DROP SYNONYM ",ls_table_name
  END IF

  LET ls_procedure_script = "-- Drop table or synonym procedure.                                        ","\n",
                            "SET SERVEROUTPUT ON                                                        ","\n",
                            "DECLARE                                                                    ","\n",
                            "  ls_SQL        VARCHAR2(1024);                                            ","\n",
                            "  ls_ObjectType VARCHAR2(10);                                              ","\n",
                            "BEGIN                                                                      ","\n",
                            "   DBMS_OUTPUT.ENABLE(100000);                                             ","\n",
                            "                                                                           ","\n",
                            "   ls_ObjectType := '",ls_object_type,"';                                  ","\n",
                            "                                                                           ","\n",
                            "   IF (ls_ObjectType = 'TABLE') THEN                                       ","\n",
                            "     ls_SQL := '",ls_drop_rebuild_script,"';                               ","\n",
                            "     BEGIN                                                                 ","\n",
                            "       EXECUTE IMMEDIATE ls_SQL;                                           ","\n",
                            "       DBMS_OUTPUT.PUT_LINE('[Message] Drop rebuild table success.');      ","\n",                    
                            "     EXCEPTION                                                             ","\n",
                            "       WHEN OTHERS THEN                                                    ","\n",
                            "         DBMS_OUTPUT.PUT_LINE(SQLERRM);                                    ","\n",
                            "     END;                                                                  ","\n",
                            "   END IF;                                                                 ","\n",
                            "                                                                           ","\n",
                            "   ls_SQL := '",ls_drop_script,"';                                         ","\n",
                            "                                                                           ","\n",
                            "   BEGIN                                                                   ","\n",
                            "     EXECUTE IMMEDIATE ls_SQL;                                             ","\n",
                            "     DBMS_OUTPUT.PUT_LINE('[Message] Drop table success.');                ","\n",          
                            "   EXCEPTION                                                               ","\n",
                            "     WHEN OTHERS THEN                                                      ","\n",
                            "         DBMS_OUTPUT.PUT_LINE(SQLERRM);                                    ","\n",
                            "   END;                                                                    ","\n",
                            "                                                                           ","\n",
                            "EXCEPTION                                                                  ","\n",
                            "  WHEN OTHERS THEN                                                         ","\n",
                            "    DBMS_OUTPUT.PUT_LINE(SQLERRM);                                         ","\n",
                            "END;                                                                       ","\n",
                            "/                                                                          ","\n"

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


FUNCTION sadzi140_db_gen_rebuild_script(p_table_name)
DEFINE
  p_table_name  STRING,
  p_type        STRING
DEFINE
  ##########################
  ls_drop_script      STRING,
  ls_exit_sign        STRING,
  ls_drop_full        STRING,
  ##########################
  ls_table_name       STRING,
  ls_type             STRING,
  ls_random_name      STRING,
  ls_tempdir          STRING,
  lchannel_write      base.Channel,
  ls_sript_filename   STRING,
  ls_procedure_script STRING,
  ls_separator        STRING 
DEFINE
  ls_return STRING  
  
  LET ls_table_name = p_table_name

  LET ls_separator = os.Path.separator()
  
  LET ls_tempdir = FGL_GETENV("TEMPDIR")
  CALL sadzi140_db_get_GUID() RETURNING ls_random_name 
  LET ls_sript_filename = ls_tempdir,ls_separator,ls_table_name,ls_random_name,".reb"
  
  LET ls_exit_sign = "exit;"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  #20170214 mark begin
{  
  LET ls_procedure_script = "-- Rebuild table PL/SQL procedure                                                                            ","\n",
                            "SET SERVEROUTPUT ON                                                                                          ","\n",
                            "DECLARE                                                                                                      ","\n",
                            "  -------------------------------------------------------------------------------                            ","\n",
                            "  cursor c_index(p_owner varchar2,p_table_name varchar2) IS                                                  ","\n",
                            "    select *                                                                                                 ","\n",
                            "      from all_indexes ais                                                                                   ","\n",
                            "     where ais.OWNER      = p_owner                                                                          ","\n",
                            "       and ais.TABLE_NAME = p_table_name;                                                                    ","\n",
                            "  r_index c_index%ROWTYPE;                                                                                   ","\n",
                            "  -------------------------------------------------------------------------------                            ","\n",
                            "  cursor c_constraints(p_owner varchar2,p_table_name varchar2) IS                                            ","\n",
                            "    select *                                                                                                 ","\n",
                            "      from all_constraints acs                                                                               ","\n",
                            "     where acs.OWNER      = p_owner                                                                          ","\n",
                            "       and acs.TABLE_NAME = p_table_name;                                                                    ","\n",
                            "  r_constraints c_constraints%ROWTYPE;                                                                       ","\n",
                            "  -------------------------------------------------------------------------------                            ","\n",
                            "  cs_ERROR_TAG    CONSTANT VARCHAR2(20) := '",cs_error_tag,"';                                               ","\n",          
                            "  cs_WARNING_TAG  CONSTANT VARCHAR2(20) := '",cs_warning_tag,"';                                             ","\n",            
                            "  cs_SUCCESS_TAG  CONSTANT VARCHAR2(20) := '",cs_success_tag,"';                                             ","\n",            
                            "  ls_SQL          VARCHAR2(1024);                                                                            ","\n",
                            "  ls_TableName    VARCHAR2(512);                                                                             ","\n",
                            "  ls_user         VARCHAR2(512);                                                                             ","\n",
                            "  ls_TableSpace   VARCHAR2(512);                                                                             ","\n",
                            "  ls_RebuildTable VARCHAR2(512);                                                                             ","\n",
                            "  li_counts       INTEGER;                                                                                   ","\n",
                            "BEGIN                                                                                                        ","\n",
                            "  DBMS_OUTPUT.ENABLE(100000);                                                                                ","\n",
                            "                                                                                                             ","\n",
                            "  ls_TableName := '",ls_table_name.toUpperCase(),"';                                                         ","\n",
                            "  ls_RebuildTable := ls_TableName||'",cs_rebuild_tail.toUpperCase(),"';                                      ","\n",                
                            "                                                                                                             ","\n",
                            "  select user                                                                                                ","\n",
                            "    into ls_user                                                                                             ","\n",
                            "    from dual;                                                                                               ","\n",
                            "                                                                                                             ","\n",
                            "  select ats.TABLESPACE_NAME                                                                                 ","\n",
                            "    into ls_TableSpace                                                                                       ","\n",
                            "    from all_tables ats                                                                                      ","\n",
                            "   where ats.OWNER      = ls_user                                                                            ","\n",
                            "     and ats.TABLE_NAME = ls_TableName;                                                                      ","\n",
                            "                                                                                                             ","\n",
                            "  -- 先刪除舊的備份表格                                                                                         ","\n",
                            "  BEGIN                                                                                                      ","\n",
                            "    ls_SQL := 'DROP TABLE '||ls_RebuildTable;                                                                ","\n",
                            "    EXECUTE IMMEDIATE ls_SQL;                                                                                ","\n",
                            "  EXCEPTION                                                                                                  ","\n",
                            "    WHEN OTHERS THEN                                                                                         ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||' '||ls_SQL);                                                     ","\n",
                            "  END;                                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "  -- 將表格更名為備份表格名稱                                                                                    ","\n",
                            "  BEGIN                                                                                                      ","\n",
                            "    ls_SQL := 'ALTER TABLE '||ls_TableName||' RENAME TO '||ls_RebuildTable;                                  ","\n",
                            "    EXECUTE IMMEDIATE ls_SQL;                                                                                ","\n",
                            "  EXCEPTION                                                                                                  ","\n",
                            "    WHEN OTHERS THEN                                                                                         ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(cs_ERROR_TAG||' '||ls_SQL);                                                       ","\n",
                            "      RAISE;                                                                                                 ","\n",
                            "  END;                                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "  -- 刪除表格的Key及Index                                                                                      ","\n",
                            "  BEGIN                                                                                                      ","\n",
                            "    ls_SQL := 'ALTER TABLE '||ls_RebuildTable||' DROP PRIMARY KEY CASCADE DROP INDEX';                       ","\n",
                            "    EXECUTE IMMEDIATE ls_SQL;                                                                                ","\n",
                            "  EXCEPTION                                                                                                  ","\n",
                            "    WHEN OTHERS THEN                                                                                         ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||' '||ls_SQL);                                                     ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(SQLERRM);                                                                         ","\n",
                            "  END;                                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "  -- 刪除表格其他的Constraint                                                                                   ","\n",
                            "  li_counts := 0;                                                                                            ","\n",
                            "  open c_constraints(ls_user,ls_RebuildTable);                                                               ","\n",
                            "  LOOP                                                                                                       ","\n",
                            "    fetch c_constraints into r_constraints;                                                                  ","\n",
                            "    if c_constraints%notfound then                                                                           ","\n",
                            "      exit;                                                                                                  ","\n",
                            "    end if;                                                                                                  ","\n",
                            "                                                                                                             ","\n",
                            "    ls_SQL := 'alter table '||ls_RebuildTable||' drop constraint '||r_constraints.CONSTRAINT_NAME||' cascade'; ","\n",
                            "                                                                                                             ","\n",
                            "    BEGIN                                                                                                    ","\n",
                            "      EXECUTE IMMEDIATE ls_SQL;                                                                              ","\n",
                            "    EXCEPTION                                                                                                ","\n",
                            "      WHEN OTHERS THEN                                                                                       ","\n",
                            "        DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||'Drop CONSTRAINT '||r_constraints.CONSTRAINT_NAME||' fault.');  ","\n",
                            "        DBMS_OUTPUT.PUT_LINE(SQLERRM);                                                                       ","\n",
                            "    END;                                                                                                     ","\n",
                            "                                                                                                             ","\n",
                            "    li_counts := li_counts + 1;                                                                              ","\n",
                            "                                                                                                             ","\n",
                            "  END LOOP;                                                                                                  ","\n",
                            "  close c_constraints;                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "  -- 刪除表格其他的Index                                                                                        ","\n",
                            "  li_counts := 0;                                                                                            ","\n",
                            "  open c_index(ls_user,ls_RebuildTable);                                                                     ","\n",
                            "  LOOP                                                                                                       ","\n",
                            "    fetch c_index into r_index;                                                                              ","\n",
                            "    if c_index%notfound then                                                                                 ","\n",
                            "      exit;                                                                                                  ","\n",
                            "    end if;                                                                                                  ","\n",
                            "                                                                                                             ","\n",
                            "    ls_SQL := 'DROP INDEX '||r_index.INDEX_NAME;                                                             ","\n",
                            "                                                                                                             ","\n",
                            "    BEGIN                                                                                                    ","\n",
                            "      EXECUTE IMMEDIATE ls_SQL;                                                                              ","\n",
                            "    EXCEPTION                                                                                                ","\n",
                            "      WHEN OTHERS THEN                                                                                       ","\n",
                            "        DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||'Drop INDEX '||r_index.INDEX_NAME||' fault.');                  ","\n",
                            "        DBMS_OUTPUT.PUT_LINE(SQLERRM);                                                                       ","\n",
                            "    END;                                                                                                     ","\n",
                            "                                                                                                             ","\n",
                            "    li_counts := li_counts + 1;                                                                              ","\n",
                            "                                                                                                             ","\n",
                            "  END LOOP;                                                                                                  ","\n",
                            "  close c_index;                                                                                             ","\n",
                            "                                                                                                             ","\n",
                            "  -- 重新建立表格等待異動                                                                                        ","\n",
                            "  BEGIN                                                                                                      ","\n",
                            "    ls_SQL := 'CREATE TABLE '||ls_TableName||' TABLESPACE '||ls_TableSpace||                                 ","\n",
                            "              '          AS SELECT * FROM DUMMY WHERE 1=2';                                                  ","\n",
                            "    EXECUTE IMMEDIATE ls_SQL;                                                                                ","\n",
                            "  EXCEPTION                                                                                                  ","\n",
                            "    WHEN OTHERS THEN                                                                                         ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(cs_ERROR_TAG||' '||ls_SQL);                                                       ","\n",
                            "      RAISE;                                                                                                 ","\n",
                            "  END;                                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "  -- 賦予權限(TIPTOP)                                                                                          ","\n",
                            "  BEGIN                                                                                                      ","\n",
                            "    ls_SQL := 'grant select, insert, update, delete on '||ls_TableName||' to TIPTOP';                        ","\n",
                            "    EXECUTE IMMEDIATE ls_SQL;                                                                                ","\n",
                            "  EXCEPTION                                                                                                  ","\n",
                            "    WHEN OTHERS THEN                                                                                         ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(cs_ERROR_TAG||' '||ls_SQL);                                                       ","\n",
                            "      RAISE;                                                                                                 ","\n",
                            "  END;                                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "  DBMS_OUTPUT.PUT_LINE(cs_SUCCESS_TAG);                                                                      ","\n",
                            "                                                                                                             ","\n",
                            "EXCEPTION                                                                                                    ","\n",
                            "  WHEN OTHERS THEN                                                                                           ","\n",
                            "    DBMS_OUTPUT.PUT_LINE(cs_ERROR_TAG||SQLERRM);                                                                      ","\n",
                            "END;                                                                                                         ","\n",
                            "/                                                                                                            ","\n"
}
  #20170214 mark end

  #20170214 begin
  LET ls_procedure_script = "-- Rebuild table PL/SQL procedure                                                                            ","\n",
                            "SET SERVEROUTPUT ON                                                                                          ","\n",
                            "DECLARE                                                                                                      ","\n",
                            "  type t_trigger_content is record                                                                           ","\n",
                            "  (                                                                                                          ","\n",
                            "    table_name    all_triggers.TABLE_NAME%type,                                                              ","\n",
                            "    trigger_name  all_triggers.TRIGGER_NAME%type,                                                            ","\n",
                            "    trigger_ddl   varchar2(32767),                                                                           ","\n",
                            "    trigger_body  varchar2(32767),                                                                           ","\n",
                            "    trigger_alter varchar2(32767)                                                                            ","\n",
                            "  );                                                                                                         ","\n",
                            "  type t_trigger_list is table of t_trigger_content index by pls_integer;                                    ","\n",
                            "  trigger_list t_trigger_list;                                                                               ","\n",
                            "  -------------------------------------------------------------------------------                            ","\n",
                            "  cursor c_trigger_list(p_owner varchar2,p_table_name varchar2) IS                                           ","\n",
                            "    SELECT TABLE_NAME,TRIGGER_NAME,TO_CHAR(DBMS_METADATA.GET_DDL('TRIGGER', TRIGGER_NAME)) TRIGGER_DDL       ","\n",
                            "      FROM ALL_TRIGGERS                                                                                      ","\n",
                            "     WHERE OWNER = p_owner                                                                                   ","\n",
                            "       AND TABLE_NAME = p_table_name;                                                                        ","\n",
                            "  r_trigger_list c_trigger_list%ROWTYPE;                                                                     ","\n",
                            "  -------------------------------------------------------------------------------                            ","\n",
                            "  cursor c_index(p_owner varchar2,p_table_name varchar2) IS                                                  ","\n",
                            "    select *                                                                                                 ","\n",
                            "      from all_indexes ais                                                                                   ","\n",
                            "     where ais.OWNER      = p_owner                                                                          ","\n",
                            "       and ais.TABLE_NAME = p_table_name;                                                                    ","\n",
                            "  r_index c_index%ROWTYPE;                                                                                   ","\n",
                            "  -------------------------------------------------------------------------------                            ","\n",
                            "  cursor c_constraints(p_owner varchar2,p_table_name varchar2) IS                                            ","\n",
                            "    select *                                                                                                 ","\n",
                            "      from all_constraints acs                                                                               ","\n",
                            "     where acs.OWNER      = p_owner                                                                          ","\n",
                            "       and acs.TABLE_NAME = p_table_name;                                                                    ","\n",
                            "  r_constraints c_constraints%ROWTYPE;                                                                       ","\n",
                            "  -------------------------------------------------------------------------------                            ","\n",
                            "  cs_ERROR_TAG    CONSTANT VARCHAR2(20) := '",cs_error_tag,"';                                               ","\n",          
                            "  cs_WARNING_TAG  CONSTANT VARCHAR2(20) := '",cs_warning_tag,"';                                             ","\n",            
                            "  cs_SUCCESS_TAG  CONSTANT VARCHAR2(20) := '",cs_success_tag,"';                                             ","\n",            
                            "  ls_SQL          VARCHAR2(1024);                                                                            ","\n",
                            "  ls_TableName    VARCHAR2(512);                                                                             ","\n",
                            "  ls_user         VARCHAR2(512);                                                                             ","\n",
                            "  ls_TableSpace   VARCHAR2(512);                                                                             ","\n",
                            "  ls_RebuildTable VARCHAR2(512);                                                                             ","\n",
                            "  li_counts       INTEGER;                                                                                   ","\n",
                            "  ---- For Trigger rebuild ------------------------------------------------------                            ","\n",
                            "  li_index     integer;                                                                                      ","\n",
                            "  ls_exec_sql  varchar2(32767);                                                                              ","\n",
                            "  -------------------------------------------------------------------------------                            ","\n",
                            "BEGIN                                                                                                        ","\n",
                            "  DBMS_OUTPUT.ENABLE(100000);                                                                                ","\n",
                            "                                                                                                             ","\n",
                            "  ls_TableName := '",ls_table_name.toUpperCase(),"';                                                         ","\n",
                            "  ls_RebuildTable := ls_TableName||'",cs_rebuild_tail.toUpperCase(),"';                                      ","\n",                
                            "                                                                                                             ","\n",
                            "  select user                                                                                                ","\n",
                            "    into ls_user                                                                                             ","\n",
                            "    from dual;                                                                                               ","\n",
                            "                                                                                                             ","\n",
                            "  select ats.TABLESPACE_NAME                                                                                 ","\n",
                            "    into ls_TableSpace                                                                                       ","\n",
                            "    from all_tables ats                                                                                      ","\n",
                            "   where ats.OWNER      = ls_user                                                                            ","\n",
                            "     and ats.TABLE_NAME = ls_TableName;                                                                      ","\n",
                            "                                                                                                             ","\n",
                            "  ----- Backup Trigger DDL and drop Trigger begin -----                                                      ","\n",
                            "  li_index := 1;                                                                                             ","\n",
                            "  open c_trigger_list(ls_user,ls_TableName);                                                                         ","\n",
                            "  LOOP                                                                                                       ","\n",
                            "    fetch c_trigger_list into r_trigger_list;                                                                ","\n",
                            "    if c_trigger_list%notfound then                                                                          ","\n",
                            "      exit;                                                                                                  ","\n",
                            "    end if;                                                                                                  ","\n",
                            "                                                                                                             ","\n",
                            "    trigger_list(li_index).table_name   := r_trigger_list.TABLE_NAME;                                        ","\n",
                            "    trigger_list(li_index).trigger_name := r_trigger_list.trigger_name;                                      ","\n",
                            "    trigger_list(li_index).trigger_ddl  := r_trigger_list.trigger_ddl;                                       ","\n",
                            "                                                                                                             ","\n",
                            "    select substr(r_trigger_list.trigger_ddl,1,instr(r_trigger_list.trigger_ddl,'ALTER')-1)                  ","\n",
                            "      into trigger_list(li_index).trigger_body                                                               ","\n",
                            "      from dual;                                                                                             ","\n",
                            "                                                                                                             ","\n",
                            "    select substr(r_trigger_list.trigger_ddl,instr(r_trigger_list.trigger_ddl,'ALTER'),length(r_trigger_list.trigger_ddl))  ","\n", 
                            "      into trigger_list(li_index).trigger_alter                                                              ","\n",
                            "      from dual;                                                                                             ","\n",
                            "                                                                                                             ","\n",
                            "    BEGIN                                                                                                    ","\n",
                            "      ls_exec_sql := 'drop trigger '||r_trigger_list.trigger_name;                                           ","\n",
                            "      --Dbms_Output.put_line(ls_exec_sql);                                                                   ","\n",
                            "      execute immediate ls_exec_sql;                                                                         ","\n",
                            "    EXCEPTION                                                                                                ","\n",
                            "      WHEN OTHERS THEN                                                                                       ","\n",
                            "        DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||' '||ls_exec_sql);                                              ","\n",
                            "    END;                                                                                                     ","\n",
                            "                                                                                                             ","\n",
                            "    li_index := li_index + 1;                                                                                ","\n",
                            "                                                                                                             ","\n",
                            "  END LOOP;                                                                                                  ","\n",
                            "  close c_trigger_list;                                                                                      ","\n",
                            "  ----- Backup Trigger DDL and drop Trigger end -----                                                        ","\n",
                            "                                                                                                             ","\n",
                            "  -- 先刪除舊的備份表格                                                                                      ","\n",
                            "  BEGIN                                                                                                      ","\n",
                            "    ls_SQL := 'DROP TABLE '||ls_RebuildTable;                                                                ","\n",
                            "    EXECUTE IMMEDIATE ls_SQL;                                                                                ","\n",
                            "  EXCEPTION                                                                                                  ","\n",
                            "    WHEN OTHERS THEN                                                                                         ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||' '||ls_SQL);                                                     ","\n",
                            "  END;                                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "  -- 將表格更名為備份表格名稱                                                                                ","\n",
                            "  BEGIN                                                                                                      ","\n",
                            "    ls_SQL := 'ALTER TABLE '||ls_TableName||' RENAME TO '||ls_RebuildTable;                                  ","\n",
                            "    EXECUTE IMMEDIATE ls_SQL;                                                                                ","\n",
                            "  EXCEPTION                                                                                                  ","\n",
                            "    WHEN OTHERS THEN                                                                                         ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(cs_ERROR_TAG||' '||ls_SQL);                                                       ","\n",
                            "      RAISE;                                                                                                 ","\n",
                            "  END;                                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "  -- 刪除表格的Key及Index                                                                                      ","\n",
                            "  BEGIN                                                                                                      ","\n",
                            "    ls_SQL := 'ALTER TABLE '||ls_RebuildTable||' DROP PRIMARY KEY CASCADE DROP INDEX';                       ","\n",
                            "    EXECUTE IMMEDIATE ls_SQL;                                                                                ","\n",
                            "  EXCEPTION                                                                                                  ","\n",
                            "    WHEN OTHERS THEN                                                                                         ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||' '||ls_SQL);                                                     ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(SQLERRM);                                                                         ","\n",
                            "  END;                                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "  -- 刪除表格其他的Constraint                                                                                   ","\n",
                            "  li_counts := 0;                                                                                            ","\n",
                            "  open c_constraints(ls_user,ls_RebuildTable);                                                               ","\n",
                            "  LOOP                                                                                                       ","\n",
                            "    fetch c_constraints into r_constraints;                                                                  ","\n",
                            "    if c_constraints%notfound then                                                                           ","\n",
                            "      exit;                                                                                                  ","\n",
                            "    end if;                                                                                                  ","\n",
                            "                                                                                                             ","\n",
                            "    ls_SQL := 'alter table '||ls_RebuildTable||' drop constraint '||r_constraints.CONSTRAINT_NAME||' cascade'; ","\n",
                            "                                                                                                             ","\n",
                            "    BEGIN                                                                                                    ","\n",
                            "      EXECUTE IMMEDIATE ls_SQL;                                                                              ","\n",
                            "    EXCEPTION                                                                                                ","\n",
                            "      WHEN OTHERS THEN                                                                                       ","\n",
                            "        DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||'Drop CONSTRAINT '||r_constraints.CONSTRAINT_NAME||' fault.');  ","\n",
                            "        DBMS_OUTPUT.PUT_LINE(SQLERRM);                                                                       ","\n",
                            "    END;                                                                                                     ","\n",
                            "                                                                                                             ","\n",
                            "    li_counts := li_counts + 1;                                                                              ","\n",
                            "                                                                                                             ","\n",
                            "  END LOOP;                                                                                                  ","\n",
                            "  close c_constraints;                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "  -- 刪除表格其他的Index                                                                                        ","\n",
                            "  li_counts := 0;                                                                                            ","\n",
                            "  open c_index(ls_user,ls_RebuildTable);                                                                     ","\n",
                            "  LOOP                                                                                                       ","\n",
                            "    fetch c_index into r_index;                                                                              ","\n",
                            "    if c_index%notfound then                                                                                 ","\n",
                            "      exit;                                                                                                  ","\n",
                            "    end if;                                                                                                  ","\n",
                            "                                                                                                             ","\n",
                            "    ls_SQL := 'DROP INDEX '||r_index.INDEX_NAME;                                                             ","\n",
                            "                                                                                                             ","\n",
                            "    BEGIN                                                                                                    ","\n",
                            "      EXECUTE IMMEDIATE ls_SQL;                                                                              ","\n",
                            "    EXCEPTION                                                                                                ","\n",
                            "      WHEN OTHERS THEN                                                                                       ","\n",
                            "        DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||'Drop INDEX '||r_index.INDEX_NAME||' fault.');                  ","\n",
                            "        DBMS_OUTPUT.PUT_LINE(SQLERRM);                                                                       ","\n",
                            "    END;                                                                                                     ","\n",
                            "                                                                                                             ","\n",
                            "    li_counts := li_counts + 1;                                                                              ","\n",
                            "                                                                                                             ","\n",
                            "  END LOOP;                                                                                                  ","\n",
                            "  close c_index;                                                                                             ","\n",
                            "                                                                                                             ","\n",
                            "  -- 重新建立表格等待異動                                                                                        ","\n",
                            "  BEGIN                                                                                                      ","\n",
                            "    ls_SQL := 'CREATE TABLE '||ls_TableName||' TABLESPACE '||ls_TableSpace||                                 ","\n",
                            "              '          AS SELECT * FROM DUMMY WHERE 1=2';                                                  ","\n",
                            "    EXECUTE IMMEDIATE ls_SQL;                                                                                ","\n",
                            "  EXCEPTION                                                                                                  ","\n",
                            "    WHEN OTHERS THEN                                                                                         ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(cs_ERROR_TAG||' '||ls_SQL);                                                       ","\n",
                            "      RAISE;                                                                                                 ","\n",
                            "  END;                                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "  -- 賦予權限(TIPTOP)                                                                                        ","\n",
                            "  BEGIN                                                                                                      ","\n",
                            "    ls_SQL := 'grant select, insert, update, delete on '||ls_TableName||' to TIPTOP';                        ","\n",
                            "    EXECUTE IMMEDIATE ls_SQL;                                                                                ","\n",
                            "  EXCEPTION                                                                                                  ","\n",
                            "    WHEN OTHERS THEN                                                                                         ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(cs_ERROR_TAG||' '||ls_SQL);                                                       ","\n",
                            "      RAISE;                                                                                                 ","\n",
                            "  END;                                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "  DBMS_OUTPUT.PUT_LINE(cs_SUCCESS_TAG);                                                                      ","\n",
                            "                                                                                                             ","\n",
                            "  ----- Recreate Trigger begin -----                                                                         ","\n",
                            "  li_index := trigger_list.first;                                                                            ","\n",
                            "  loop                                                                                                       ","\n",
                            "    exit when li_index is null;                                                                              ","\n",
                            "    /*                                                                                                       ","\n",
                            "    dbms_output.put_line('table_name : '||trigger_list(li_index).table_name||chr(13)||                       ","\n",
                            "                         'trigger_name : '||trigger_list(li_index).trigger_name||chr(13)||                   ","\n",
                            "                         'trigger_ddl : '||trigger_list(li_index).trigger_ddl||chr(13)||                     ","\n",
                            "                         'trigger_body : '||trigger_list(li_index).trigger_body||chr(13)||                   ","\n",
                            "                         'trigger_alter : '||trigger_list(li_index).trigger_alter                            ","\n",
                            "                                                                                                             ","\n",
                            "                        );                                                                                   ","\n",
                            "    */                                                                                                       ","\n",
                            "                                                                                                             ","\n",
                            "    BEGIN                                                                                                    ","\n",
                            "      ls_exec_sql := trigger_list(li_index).trigger_body;                                                    ","\n",
                            "      Dbms_Output.put_line('Recreate trigger : '||trigger_list(li_index).trigger_name);                      ","\n",
                            "      execute immediate ls_exec_sql;                                                                         ","\n",
                            "    EXCEPTION                                                                                                ","\n",
                            "      WHEN OTHERS THEN                                                                                       ","\n",
                            "        DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||' '||ls_exec_sql);                                              ","\n",
                            "    END;                                                                                                     ","\n",
                            "                                                                                                             ","\n",
                            "    BEGIN                                                                                                    ","\n",
                            "      ls_exec_sql := trigger_list(li_index).trigger_alter;                                                   ","\n",
                            "      Dbms_Output.put_line('Alter trigger : '||trigger_list(li_index).trigger_name);                         ","\n",
                            "      execute immediate ls_exec_sql;                                                                         ","\n",
                            "    EXCEPTION                                                                                                ","\n",
                            "      WHEN OTHERS THEN                                                                                       ","\n",
                            "        DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||' '||ls_exec_sql);                                              ","\n",
                            "    END;                                                                                                     ","\n",
                            "                                                                                                             ","\n",
                            "    li_index := trigger_list.next(li_index);                                                                 ","\n",
                            "                                                                                                             ","\n",
                            "  end loop;                                                                                                  ","\n",
                            "  ----- Recreate Trigger end -----                                                                           ","\n",
                            "                                                                                                             ","\n",
                            "EXCEPTION                                                                                                    ","\n",
                            "  WHEN OTHERS THEN                                                                                           ","\n",
                            "    DBMS_OUTPUT.PUT_LINE(cs_ERROR_TAG||SQLERRM);                                                                      ","\n",
                            "END;                                                                                                         ","\n",
                            "/                                                                                                            ","\n"
  #20170214 end
                
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

#異動實際表格型態的 Procedure
#若目標Schema的表格或是同義字不存在,會以ds的內容,並參照dzeu_t的型態建立之
FUNCTION sadzi140_db_get_alter_table_type_procedure(p_table_name,p_schema_name,p_master_schema)
DEFINE
  p_table_name     STRING,
  p_schema_name    STRING,
  p_master_schema  STRING
DEFINE
  ls_table_name       STRING,
  ls_schema_name      STRING,
  ls_master_schema    STRING,
  ls_procedure_script STRING
DEFINE
  ls_return STRING  
  
  LET ls_table_name    = p_table_name
  LET ls_schema_name   = p_schema_name
  LET ls_master_schema = p_master_schema

  LET ls_procedure_script = "-- Create non exist table or synonymous.                                                                                                                 ","\n",
                            "DECLARE                                                                                                                                                  ","\n",
                            "  --------------------------------------------------------                                                                                               ","\n",
                            "  cursor c_index(p_owner varchar2,p_table_name varchar2) IS                                                                                              ","\n",
                            "    SELECT *                                                                                                                                             ","\n",
                            "      FROM ALL_INDEXES AIS                                                                                                                               ","\n",
                            "     WHERE AIS.OWNER      = p_owner                                                                                                                      ","\n",
                            "       AND AIS.TABLE_NAME = p_table_name;                                                                                                                ","\n",
                            "  r_index c_index%ROWTYPE;                                                                                                                               ","\n",
                            "  --------------------------------------------------------                                                                                               ","\n",
                            "  li_counts          INTEGER;                                                                                                                            ","\n",
                            "  li_cnts            INTEGER;                                                                                                                            ","\n",
                            "  ls_table_name      VARCHAR2(50);                                                                                                                       ","\n",
                            "  ls_schema_name     VARCHAR2(50);                                                                                                                       ","\n",
                            "  ls_master_schema   VARCHAR2(50);                                                                                                                       ","\n",
                            "  ls_user            VARCHAR2(50);                                                                                                                       ","\n",
                            "  ls_db_name         VARCHAR2(50);                                                                                                                       ","\n",
                            "  ls_table_type      VARCHAR2(50);                                                                                                                       ","\n",
                            "  ls_real_table_type VARCHAR2(50);                                                                                                                       ","\n",
                            "  ls_backup_name     VARCHAR2(50);                                                                                                                       ","\n",
                            "  ls_ExecScript      VARCHAR2(4096);                                                                                                                     ","\n",
                            "  --------------------------------------------------------                                                                                               ","\n",
                            "  cs_ERROR_TAG       CONSTANT VARCHAR2(20) := '",cs_error_tag,"';                                                                                        ","\n",
                            "  cs_WARNING_TAG     CONSTANT VARCHAR2(20) := '",cs_warning_tag,"';                                                                                      ","\n",
                            "  cs_SUCCESS_TAG     CONSTANT VARCHAR2(20) := '",cs_success_tag,"';                                                                                      ","\n",
                            "  --------------------------------------------------------                                                                                               ","\n",
                            "BEGIN                                                                                                                                                    ","\n",
                            "                                                                                                                                                         ","\n",
                            "  ls_table_name    := '",ls_table_name.toUpperCase(),"';                                                                                                 ","\n",
                            "  ls_backup_name   := ls_table_name||'_ALTER';                                                                                                           ","\n",
                            "  ls_schema_name   := '",ls_schema_name.toUpperCase(),"';                                                                                                ","\n",
                            "  ls_master_schema := '",ls_master_schema.toUpperCase(),"';                                                                                              ","\n",
                            "                                                                                                                                                         ","\n",
                            "  SELECT USER                                                                                                                                            ","\n",
                            "    INTO ls_user                                                                                                                                         ","\n",
                            "    FROM DUAL;                                                                                                                                           ","\n",
                            "                                                                                                                                                         ","\n",
                            "  BEGIN                                                                                                                                                  ","\n",
                            "    SELECT DA.GZDA001                                                                                                                                    ","\n",
                            "      INTO ls_db_name                                                                                                                                    ","\n",
                            "      FROM DS.GZDA_T DA                                                                                                                                  ","\n",
                            "     WHERE DA.GZDA003 = LOWER(ls_schema_name);                                                                                                           ","\n",
                            "  EXCEPTION                                                                                                                                              ","\n",
                            "    WHEN OTHERS THEN                                                                                                                                     ","\n",
                            "      DBMS_OUTPUT.PUT_LINE(cs_ERROR_TAG||'Can not get db name by schema '||ls_schema_name);                                                              ","\n",                           
                            "      ls_db_name := NULL;                                                                                                                                ","\n",      
                            "  END;                                                                                                                                                   ","\n",
                            "                                                                                                                                                         ","\n",
                            "  BEGIN                                                                                                                                                  ","\n",
                            "    SELECT COUNT(*)                                                                                                                                      ","\n",
                            "      INTO li_cnts                                                                                                                                       ","\n",
                            "      FROM ALL_TABLES ATS                                                                                                                                ","\n",
                            "     WHERE ATS.OWNER      = UPPER(ls_schema_name)                                                                                                        ","\n",
                            "       AND ATS.TABLE_NAME = UPPER(ls_table_name);                                                                                                        ","\n",
                            "  EXCEPTION                                                                                                                                              ","\n",
                            "    WHEN OTHERS THEN                                                                                                                                     ","\n",
                            "      li_cnts := 0;                                                                                                                                      ","\n",
                            "  END;                                                                                                                                                   ","\n",
                            "                                                                                                                                                         ","\n",
                            "  BEGIN                                                                                                                                                  ","\n",
                            "    SELECT UPPER(EU.DZEU003) TABLE_TYPE                                                                                                                  ","\n",
                            "      INTO ls_table_type                                                                                                                                 ","\n",
                            "      FROM ",ls_master_schema,".DZEU_T EU                                                                                                                ","\n",
                            "     WHERE EU.DZEU001 = LOWER(ls_table_name)                                                                                                             ","\n",
                            "       AND EU.DZEU002 = LOWER(ls_db_name);                                                                                                               ","\n",
                            "  EXCEPTION                                                                                                                                              ","\n",
                            "    WHEN OTHERS THEN                                                                                                                                     ","\n",
                            "      ls_table_type := 'X';                                                                                                                              ","\n",
                            "  END;                                                                                                                                                   ","\n",
                            "                                                                                                                                                         ","\n",
                            "  BEGIN                                                                                                                                                  ","\n",
                            "    SELECT DECODE(AOS.OBJECT_TYPE,'TABLE','T','SYNONYM','S','INDEX','I','X') TABLE_TYPE                                                                  ","\n",
                            "      INTO ls_real_table_type                                                                                                                            ","\n",
                            "      FROM ALL_OBJECTS AOS                                                                                                                               ","\n",
                            "     WHERE AOS.OWNER       = UPPER(ls_schema_name)                                                                                                       ","\n",
                            "       AND AOS.OBJECT_NAME = UPPER(ls_table_name);                                                                                                       ","\n",
                            "  EXCEPTION                                                                                                                                              ","\n",
                            "    WHEN OTHERS THEN                                                                                                                                     ","\n",
                            "      ls_real_table_type := 'X';                                                                                                                         ","\n",
                            "  END;                                                                                                                                                   ","\n",
                            "  --DBMS_OUTPUT.PUT_LINE(li_cnts);                                                                                                                       ","\n",
                            "                                                                                                                                                         ","\n",
                            "  -- 不為 Master schema 時才做這件事                                                                                                                     ","\n",
                            "  IF (ls_user <> ls_master_schema) AND (ls_db_name IS NOT NULL) THEN                                                                                     ","\n",
                            "    IF (li_cnts = 0) OR (ls_table_type <> ls_real_table_type) THEN                                                                                       ","\n",
                            "                                                                                                                                                         ","\n",
                            "      IF ls_real_table_type = 'T' THEN                                                                                                                   ","\n",
                            "        -- 刪除備份表格名稱                                                                                                                              ","\n",
                            "        BEGIN                                                                                                                                            ","\n",
                            "          ls_ExecScript := 'DROP TABLE '||ls_backup_name;                                                                                                ","\n",
                            "          EXECUTE IMMEDIATE ls_ExecScript;                                                                                                               ","\n",
                            "        EXCEPTION                                                                                                                                        ","\n",
                            "          WHEN OTHERS THEN                                                                                                                               ","\n",
                            "            DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||'Drop backup table not success.')  ;                                                                    ","\n",
                            "        END;                                                                                                                                             ","\n",
                            "                                                                                                                                                         ","\n",
                            "        -- 將原表格更名為備份表格名稱                                                                                                                    ","\n",
                            "        BEGIN                                                                                                                                            ","\n",
                            "          ls_ExecScript := 'ALTER TABLE '||ls_table_name||' RENAME TO '||ls_backup_name;                                                                 ","\n",
                            "          EXECUTE IMMEDIATE ls_ExecScript;                                                                                                               ","\n",
                            "        EXCEPTION                                                                                                                                        ","\n",
                            "          WHEN OTHERS THEN                                                                                                                               ","\n",
                            "            DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||'Alter original table rename to backup not success.');                                                  ","\n",
                            "            RAISE;                                                                                                                                       ","\n",
                            "        END;                                                                                                                                             ","\n",
                            "                                                                                                                                                         ","\n",
                            "        -- 刪除表格的Key及Index                                                                                                                          ","\n",
                            "        BEGIN                                                                                                                                            ","\n",
                            "          ls_ExecScript := 'ALTER TABLE '||ls_backup_name||' DROP PRIMARY KEY CASCADE DROP INDEX';                                                       ","\n",
                            "          EXECUTE IMMEDIATE ls_ExecScript;                                                                                                               ","\n",
                            "        EXCEPTION                                                                                                                                        ","\n",
                            "          WHEN OTHERS THEN                                                                                                                               ","\n",
                            "            DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||'Alter drop primary key and index not success.');                                                       ","\n",
                            "        END;                                                                                                                                             ","\n",
                            "                                                                                                                                                         ","\n",
                            "        -- 刪除表格其他的Index                                                                                                                           ","\n",
                            "        li_counts := 0;                                                                                                                                  ","\n",
                            "        open c_index(ls_user,ls_backup_name);                                                                                                            ","\n",
                            "        LOOP                                                                                                                                             ","\n",
                            "          fetch c_index into r_index;                                                                                                                    ","\n",
                            "          if c_index%notfound then                                                                                                                       ","\n",
                            "            exit;                                                                                                                                        ","\n",
                            "          end if;                                                                                                                                        ","\n",
                            "                                                                                                                                                         ","\n",
                            "          ls_ExecScript := 'DROP INDEX '||r_index.INDEX_NAME;                                                                                            ","\n",
                            "                                                                                                                                                         ","\n",
                            "          BEGIN                                                                                                                                          ","\n",
                            "            EXECUTE IMMEDIATE ls_ExecScript;                                                                                                             ","\n",
                            "          EXCEPTION                                                                                                                                      ","\n",
                            "            WHEN OTHERS THEN                                                                                                                             ","\n",
                            "              DBMS_OUTPUT.PUT_LINE(cs_WARNING_TAG||'Drop INDEX '||r_index.INDEX_NAME||' not success.');                                                  ","\n",
                            "          END;                                                                                                                                           ","\n",
                            "                                                                                                                                                         ","\n",
                            "          li_counts := li_counts + 1;                                                                                                                    ","\n",
                            "                                                                                                                                                         ","\n",
                            "        END LOOP;                                                                                                                                        ","\n",
                            "        close c_index;                                                                                                                                   ","\n",
                            "                                                                                                                                                         ","\n",
                            "      ELSIF ls_real_table_type = 'S' THEN                                                                                                                ","\n",
                            "        BEGIN                                                                                                                                            ","\n",
                            "          ls_ExecScript := 'DROP SYNONYM '||ls_table_name;                                                                                               ","\n",
                            "          EXECUTE IMMEDIATE ls_ExecScript;                                                                                                               ","\n",
                            "        EXCEPTION                                                                                                                                        ","\n",
                            "          WHEN OTHERS THEN                                                                                                                               ","\n",
                            "            DBMS_OUTPUT.PUT_LINE(cs_warning_tag||ls_ExecScript);                                                                                         ","\n",
                            "            DBMS_OUTPUT.PUT_LINE(SQLERRM);                                                                                                               ","\n",
                            "        END;                                                                                                                                             ","\n",
                            "      END IF;                                                                                                                                            ","\n",
                            "                                                                                                                                                         ","\n",
                            "                                                                                                                                                         ","\n",
                            "      IF ls_table_type = 'T' THEN                                                                                                                        ","\n",
                            "        ls_ExecScript := 'CREATE TABLE '||ls_schema_name||'.'||ls_table_name||' AS SELECT * FROM '||ls_master_schema||'.'||ls_table_name||' WHERE 1=2';  ","\n",
                            "        BEGIN                                                                                                                                            ","\n",
                            "          EXECUTE IMMEDIATE ls_ExecScript;                                                                                                               ","\n",
                            "        EXCEPTION                                                                                                                                        ","\n",
                            "          WHEN OTHERS THEN                                                                                                                               ","\n",
                            "            DBMS_OUTPUT.PUT_LINE(cs_ERROR_tag||ls_ExecScript)  ;                                                                                         ","\n",
                            "            DBMS_OUTPUT.PUT_LINE(SQLERRM);                                                                                                               ","\n",
                            "        END;                                                                                                                                             ","\n",
                            "                                                                                                                                                         ","\n",
                            "        ls_ExecScript := 'GRANT SELECT, INSERT, UPDATE, DELETE ON '||ls_table_name||' TO TIPTOP';                                                        ","\n",
                            "        BEGIN                                                                                                                                            ","\n",
                            "          EXECUTE IMMEDIATE ls_ExecScript;                                                                                                               ","\n",
                            "        EXCEPTION                                                                                                                                        ","\n",
                            "          WHEN OTHERS THEN                                                                                                                               ","\n",
                            "            DBMS_OUTPUT.PUT_LINE(cs_ERROR_tag||ls_ExecScript)  ;                                                                                         ","\n",
                            "            DBMS_OUTPUT.PUT_LINE(SQLERRM);                                                                                                               ","\n",
                            "        END;                                                                                                                                             ","\n",
                            "                                                                                                                                                         ","\n",
                            "      ELSIF ls_table_type = 'S' THEN                                                                                                                     ","\n",
                            "        ls_ExecScript := 'CREATE SYNONYM '||ls_table_name||' FOR '||ls_master_schema||'.'||ls_table_name;                                                ","\n",
                            "        BEGIN                                                                                                                                            ","\n",
                            "          EXECUTE IMMEDIATE ls_ExecScript;                                                                                                               ","\n",
                            "        EXCEPTION                                                                                                                                        ","\n",
                            "          WHEN OTHERS THEN                                                                                                                               ","\n",
                            "            DBMS_OUTPUT.PUT_LINE(cs_ERROR_tag||ls_ExecScript)  ;                                                                                         ","\n",
                            "            DBMS_OUTPUT.PUT_LINE(SQLERRM);                                                                                                               ","\n",
                            "        END;                                                                                                                                             ","\n",
                            "      END IF;                                                                                                                                            ","\n",
                            "    END IF;                                                                                                                                              ","\n",
                            "  END IF;                                                                                                                                                ","\n",
                            "                                                                                                                                                         ","\n",
                            "END;                                                                                                                                                     ","\n",
                            "/                                                                                                                                                        ","\n"

  LET ls_return = ls_procedure_script,"\n"
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzi140_db_get_update_foreign_key_data(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  ls_table_name       STRING,
  ls_procedure_script STRING,
  ls_separator        STRING 
DEFINE
  ls_return STRING  
  
  LET ls_table_name = p_table_name.toLowerCase()

  LET ls_separator = os.Path.separator()

  LET ls_procedure_script = "-- Update foreign key data procedure.                                                                                                                                                                 ","\n",
                            "SET SERVEROUTPUT ON                                                                                                                                                                                   ","\n",
                            "DECLARE                                                                                                                                                                                               ","\n",
                            "  -----------------------------------------------------------------------------                                                                                                                       ","\n",
                            "  cs_ERROR_TAG    CONSTANT VARCHAR2(20) := '",cs_error_tag,"';                                                                                                                                        ","\n",
                            "  cs_WARNING_TAG  CONSTANT VARCHAR2(20) := '",cs_warning_tag,"';                                                                                                                                      ","\n",
                            "  cs_SUCCESS_TAG  CONSTANT VARCHAR2(20) := '",cs_success_tag,"';                                                                                                                                      ","\n",
                            "  -----------------------------------------------------------------------------                                                                                                                       ","\n",
                            "  ls_ExecScript        varchar2(32767);                                                                                                                                                               ","\n",  
                            "  ls_user              varchar2(20);                                                                                                                                                                  ","\n",  
                            "  ls_table_name        varchar2(30);                                                                                                                                                                  ","\n",
                            "  lb_false             boolean;                                                                                                                                                                       ","\n",
                            "  ls_r_constraint_name varchar2(60);                                                                                                                                                                  ","\n",
                            "BEGIN                                                                                                                                                                                                 ","\n",
                            "                                                                                                                                                                                                      ","\n",
                            "  ls_table_name := '",ls_table_name,"';                                                                                                                                                               ","\n",
                            "                                                                                                                                                                                                      ","\n",
                            "  SELECT USER                                                                                                                                                                                         ","\n",
                            "    INTO ls_user                                                                                                                                                                                      ","\n",
                            "    FROM DUAL;                                                                                                                                                                                        ","\n",
                            "                                                                                                                                                                                                      ","\n",
                            "  lb_false := FALSE;                                                                                                                                                                                  ","\n",
                            "  ls_r_constraint_name := NULL;                                                                                                                                                                       ","\n",
                            "                                                                                                                                                                                                      ","\n",
                            "  BEGIN                                                                                                                                                                                               ","\n",
                            "    SELECT ACS.R_CONSTRAINT_NAME                                                                                                                                                                      ","\n",
                            "      INTO ls_r_constraint_name                                                                                                                                                                       ","\n",
                            "      FROM ALL_CONSTRAINTS ACS                                                                                                                                                                        ","\n",
                            "     WHERE EXISTS (                                                                                                                                                                                   ","\n",
                            "                    SELECT 1                                                                                                                                                                          ","\n",
                            "                      FROM DZED_T ED                                                                                                                                                                  ","\n",
                            "                     WHERE ED.DZED001 = LOWER(ACS.TABLE_NAME)                                                                                                                                         ","\n",
                            "                       AND ED.DZED002 = LOWER(ACS.CONSTRAINT_NAME)                                                                                                                                    ","\n",
                            "                       AND ED.DZED003 = DECODE(ACS.CONSTRAINT_TYPE, 'R', 'R', ACS.CONSTRAINT_TYPE)                                                                                                    ","\n",
                            "                       AND ED.DZED003 = 'R'                                                                                                                                                           ","\n",
                            "                       AND ED.DZED001 = lower(ls_table_name)                                                                                                                                          ","\n",
                            "                  )                                                                                                                                                                                   ","\n",
                            "       AND ACS.OWNER = UPPER(ls_user);                                                                                                                                                                ","\n",
                            "  EXCEPTION                                                                                                                                                                                           ","\n",
                            "    WHEN OTHERS THEN                                                                                                                                                                                  ","\n",
                            "      DBMS_OUTPUT.put_line(cs_WARNING_TAG||SQLERRM);                                                                                                                                                  ","\n",
                            "      lb_false := TRUE;                                                                                                                                                                               ","\n",
                            "  END;                                                                                                                                                                                                ","\n",
                            "                                                                                                                                                                                                      ","\n",
                            "  if (not lb_false) and (ls_r_constraint_name is not null) then                                                                                                                                       ","\n",
                            "    BEGIN                                                                                                                                                                                             ","\n",
                            "      ls_ExecScript := 'UPDATE DZED_T ED                                                                                                                                                         '||  ","\n",
                            "                       '   SET (                                                                                                                                                                 '||  ","\n",
                            "                       '         ED.DZED004,                                                                                                                                                     '||  ","\n",
                            "                       '         ED.DZED005,                                                                                                                                                     '||  ","\n",
                            "                       '         ED.DZED006                                                                                                                                                      '||  ","\n",
                            "                       '       ) = (                                                                                                                                                             '||  ","\n",
                            "                       '            SELECT LOWER(ACC.COLUMN_NAMES),                                                                                                                              '||  ","\n",
                            "                       '                   LOWER(ACCR.TABLE_NAME),                                                                                                                               '||  ","\n",
                            "                       '                   LOWER(ACCR.COLUMN_NAMES)                                                                                                                              '||  ","\n",
                            "                       '              FROM ALL_CONSTRAINTS ACS                                                                                                                                   '||  ","\n",
                            "                       '              LEFT OUTER JOIN (                                                                                                                                          '||  ","\n",
                            "                       '                               SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, '','') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES '||  ","\n",
                            "                       '                                 FROM ALL_CONS_COLUMNS ACCS                                                                                                              '||  ","\n",
                            "                       '                                GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                 '||  ","\n",
                            "                       '                              ) ACC ON ACC.CONSTRAINT_NAME = ACS.CONSTRAINT_NAME                                                                                         '||  ","\n",
                            "                       '                                   AND ACC.OWNER           = ACS.OWNER                                                                                                   '||  ","\n",
                            "                       '              LEFT OUTER JOIN (                                                                                                                                          '||  ","\n",
                            "                       '                               SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, '','') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES '||  ","\n",
                            "                       '                                 FROM ALL_CONS_COLUMNS ACCS                                                                                                              '||  ","\n",
                            "                       '                                GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                 '||  ","\n",
                            "                       '                              ) ACCR ON ACCR.CONSTRAINT_NAME = ACS.R_CONSTRAINT_NAME                                                                                     '||  ","\n",
                            "                       '                                    AND ACCR.OWNER           = ACS.R_OWNER                                                                                               '||  ","\n",
                            "                       '             WHERE 1 = 1                                                                                                                                                 '||  ","\n",
                            "                       '               AND ACS.TABLE_NAME = UPPER(ED.DZED001)                                                                                                                    '||  ","\n",
                            "                       '               AND ACS.CONSTRAINT_NAME = UPPER(ED.DZED002)                                                                                                               '||  ","\n",
                            "                       '               AND DECODE(ACS.CONSTRAINT_TYPE, ''R'', ''R'', ACS.CONSTRAINT_TYPE) = ED.DZED003                                                                           '||  ","\n",
                            "                       '               AND ACS.OWNER      = UPPER('''||ls_user||''')                                                                                                             '||  ","\n",
                            "                       '           )                                                                                                                                                             '||  ","\n",
                            "                       ' WHERE ED.DZED001 = LOWER('''||ls_table_name||''')                                                                                                                       '||  ","\n",
                            "                       '   AND ED.DZED003 = ''R''                                                                                                                                                ';   ","\n",
                            "                                                                                                                                                                                                      ","\n",
                            "      EXECUTE IMMEDIATE ls_ExecScript;                                                                                                                                                                ","\n",
                            "      COMMIT;                                                                                                                                                                                         ","\n",
                            "    EXCEPTION                                                                                                                                                                                         ","\n",
                            "      WHEN OTHERS THEN ROLLBACK;                                                                                                                                                                      ","\n",
                            "      DBMS_OUTPUT.put_line(cs_ERROR_TAG||SQLERRM);                                                                                                                                                    ","\n",
                            "    END;                                                                                                                                                                                              ","\n",
                            "  end if;                                                                                                                                                                                             ","\n",
                            "                                                                                                                                                                                                      ","\n",
                            "END;                                                                                                                                                                                                  ","\n",
                            "/                                                                                                                                                                                                     ","\n"

  LET ls_return = ls_procedure_script
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzi140_db_get_create_dummy_table_sql(p_create_table)
DEFINE 
  p_create_table  T_DZEA_CREATE_TABLE
DEFINE
  lo_create_table T_DZEA_CREATE_TABLE,
  ls_sql          STRING,
  ls_table_space  STRING,
  ls_comment      STRING,
  ls_return       STRING

  LET lo_create_table.* = p_create_table.* 

  LET ls_sql = ""
  
  LET ls_table_space = ""
  LET ls_comment     = ""

  #指定 Tablespace 
  IF NVL(lo_create_table.dct_table_space CLIPPED,cs_null_value) <> cs_null_value AND lo_create_table.dct_table_space CLIPPED <> ""
     AND lo_create_table.dct_table_space CLIPPED <> " " THEN
    LET ls_table_space = "TABLESPACE ",
                        lo_create_table.dct_table_space
  END IF

  LET ls_sql = "CREATE TABLE"," ",
               lo_create_table.dct_table_name," ",
               ls_table_space," ", 
               "AS SELECT * FROM DUMMY WHERE 1=2",
               ";"

  #Table的說明             
  IF NOT NVL(lo_create_table.dct_table_description,cs_null_value) = cs_null_value THEN
    LET ls_comment = "COMMENT ON TABLE ",lo_create_table.dct_table_name,"  IS '",lo_create_table.dct_table_description,"'",
                     ";"
  END IF

  LET ls_return = ls_sql,"\n",
                  ls_comment 
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_get_create_synonym_sql(p_db_connstr,p_create_table)
DEFINE 
  p_db_connstr   T_DB_CONNSTR,
  p_create_table T_DZEA_CREATE_TABLE
DEFINE
  lo_db_connstr   T_DB_CONNSTR,
  lo_create_table T_DZEA_CREATE_TABLE,
  ls_sql          STRING,
  ls_return       STRING

  LET lo_create_table.* = p_create_table.*
  LET lo_db_connstr.* = p_db_connstr.*

  #FOR li_loop = 1 TO lo_SchemaType.getLength()
  #  IF lo_create_table.
  #END FOR
  
  LET ls_sql = ""

  LET ls_sql = "CREATE OR REPLACE SYNONYM ",
               lo_db_connstr.db_username,".",lo_create_table.dct_table_name," ",
               "FOR ",
               lo_create_table.dct_master_user,".",lo_create_table.dct_table_name,
               ";"

  LET ls_return = ls_sql
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_get_alter_constraint_sql(p_owner,p_table_name,p_diff_constraint)
DEFINE 
  p_owner           STRING,
  p_table_name      STRING,
  p_diff_constraint DYNAMIC ARRAY OF T_CONSTRAINT_DIFF 
DEFINE
  ls_owner            STRING,
  ls_table_name       STRING,
  lo_diff_constraint  DYNAMIC ARRAY OF T_CONSTRAINT_DIFF,
  lo_alter_constraint DYNAMIC ARRAY OF T_CONSTRAINT_DIFF,
  li_loop             INTEGER, 
  li_rec_cnt          INTEGER,
  ls_constraints      STRING,
  ls_sql              STRING,
  ls_where            STRING,
  ls_line             STRING,
  lb_constraint_exist BOOLEAN,
  ls_key_type         STRING,
  ls_references       STRING,
  ls_enable_foreign_key STRING,
  ls_foreign_key_state  STRING,
  ls_key_null_default_value STRING,
  lo_string_buffer    base.StringBuffer
DEFINE  
  ls_return STRING

  LET ls_owner           = p_owner
  LET ls_table_name      = p_table_name
  LET lo_diff_constraint = p_diff_constraint

  LET lo_string_buffer = base.StringBuffer.create()

  FOR li_loop = 1 TO lo_diff_constraint.getLength()
    LET ls_constraints = ls_constraints,",'",lo_diff_constraint[li_loop].dzed002,"'"
  END FOR 
  LET ls_constraints = ls_constraints.subString(2,ls_constraints.getLength())

  LET ls_sql = "SELECT UPPER(ED.DZED001) DZED001,                      ",
               "       UPPER(ED.DZED002) DZED002,                      ",
               "       UPPER(ED.DZED003) DZED003,                      ",
               "       UPPER(ED.DZED004) DZED004,                      ",
               "       UPPER(ED.DZED005) DZED005,                      ",
               "       UPPER(ED.DZED006) DZED006                       ",
               "  FROM DZED_T ED                                       ",
               " WHERE ED.DZED001 = '",ls_table_name.toLowerCase(),"'  ",
               "   AND ED.DZED002 IN (",ls_constraints.toLowerCase(),")",
               "   AND ED.DZED003 <> 'F'                               "               

  PREPARE lpre_get_alter_constraint_sql FROM ls_sql
  DECLARE lcur_get_alter_constraint_sql CURSOR FOR lpre_get_alter_constraint_sql

  LET li_rec_cnt = 1
  
  OPEN lcur_get_alter_constraint_sql
  FOREACH lcur_get_alter_constraint_sql INTO lo_alter_constraint[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_Line = ""

    IF NVL(lo_alter_constraint[li_rec_cnt].DZED003,cs_null_value) = "P" THEN
      LET ls_key_type = "primary key";
      LET ls_references = ""
    END IF
    IF NVL(lo_alter_constraint[li_rec_cnt].DZED003,cs_null_value) = "U" THEN
      LET ls_key_type = "unique";
      LET ls_references = ""
    END IF
    IF NVL(lo_alter_constraint[li_rec_cnt].DZED003,cs_null_value) = "R" THEN
      #取得 Foreign 是否啟動
      CALL sadzi140_db_get_parameter(cs_param_level_editor,cs_param_enable_foreign_key) RETURNING ls_enable_foreign_key
      LET ls_foreign_key_state = IIF(ls_enable_foreign_key=="Y",cs_state_enable,cs_state_disable)
      LET ls_key_type = "foreign key";
      LET ls_references = "references ",lo_alter_constraint[li_rec_cnt].dzed005," (",lo_alter_constraint[li_rec_cnt].dzed006,") ON DELETE CASCADE ",ls_foreign_key_state
    END IF

    #Example
    #Add
    --alter table ITMML_T add constraint itmml_pk primary key (ITMMLENT, ITMML001);
    --alter table ITMML_T add constraint itmml_fk foreign key (ITMMLENT) references itmm_t (ITMMENT) ON DELETE CASCADE DISABLE;
    --alter table ITMML_T add constraint itmml_uk unique (ITMML003);    
    #Drop
    --alter table ITMML_T drop constraint ITMML_PK CASCADE;
    --alter table ITMML_T drop constraint ITMML_FK;
  
    CALL sadzi140_db_check_table_constraint_exist(ls_owner,lo_alter_constraint[li_rec_cnt].dzed001,lo_alter_constraint[li_rec_cnt].dzed002) RETURNING lb_constraint_exist
    IF lb_constraint_exist THEN
      IF NVL(lo_alter_constraint[li_rec_cnt].DZED003,cs_null_value) = "P" THEN
        LET ls_Line = ls_Line,
                      "-- Drop primary key.","\n",
                      "alter table ",lo_alter_constraint[li_rec_cnt].dzed001," drop primary key cascade drop index;","\n"
      ELSE                     
        LET ls_Line = ls_Line,
                      "-- Drop constraint.","\n",
                      "alter table ",lo_alter_constraint[li_rec_cnt].dzed001," drop constraint ",lo_alter_constraint[li_rec_cnt].DZED002," cascade;","\n"
      END IF                     
    END IF                

    CALL sadzi140_db_get_key_null_default_value_list(ls_table_name) RETURNING ls_key_null_default_value 
    LET ls_Line = ls_Line,
                  "-- Set Key field default value if key field data is null.","\n",
                  ls_key_null_default_value
    LET ls_Line = ls_Line,"commit;","\n"
    
    LET ls_Line = ls_Line,
                  "-- Alter table add constraint.","\n",
                  "alter table ",lo_alter_constraint[li_rec_cnt].dzed001,
                  " add constraint ",lo_alter_constraint[li_rec_cnt].dzed002," ",ls_key_type,
                  " (",lo_alter_constraint[li_rec_cnt].dzed004,") ",ls_references,";","\n"
                  
    CALL lo_string_buffer.append(ls_Line)

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_alter_constraint_sql
  CALL lo_alter_constraint.deleteElement(li_rec_cnt)
  
  FREE lpre_get_alter_constraint_sql
  FREE lcur_get_alter_constraint_sql  

  LET ls_return = lo_string_buffer.toString()
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_get_drop_constraint_sql(p_owner,p_table_name,p_diff_constraint)
DEFINE 
  p_owner           STRING,
  p_table_name      STRING,
  p_diff_constraint DYNAMIC ARRAY OF T_CONSTRAINT_DIFF 
DEFINE
  ls_owner            STRING,
  ls_table_name       STRING,
  lo_diff_constraint  DYNAMIC ARRAY OF T_CONSTRAINT_DIFF,
  lo_drop_constraint  DYNAMIC ARRAY OF T_CONSTRAINT_DIFF,
  li_loop             INTEGER, 
  li_rec_cnt          INTEGER,
  ls_indexes          STRING,
  ls_sql              STRING,
  ls_where            STRING,
  ls_line             STRING,
  lb_table_index_exist    BOOLEAN,
  lb_designer_index_exist BOOLEAN,
  ls_unique               STRING,
  ls_constraints          STRING,
  lo_string_buffer        base.StringBuffer
DEFINE  
  ls_return STRING

  LET ls_owner             = p_owner
  LET ls_table_name        = p_table_name
  LET lo_diff_constraint.* = p_diff_constraint.*

  LET lo_string_buffer = base.StringBuffer.create()

  FOR li_loop = 1 TO lo_diff_constraint.getLength()
    LET ls_constraints = ls_constraints,",'",lo_diff_constraint[li_loop].dzed002,"'"
  END FOR 
  LET ls_constraints = ls_constraints.subString(2,ls_constraints.getLength())
  
  LET ls_sql = "SELECT ACS.TABLE_NAME,                                                                                                                                      ",
               "       ACS.CONSTRAINT_NAME,                                                                                                                                 ",
               "       DECODE(ACS.CONSTRAINT_TYPE, 'R', 'R', ACS.CONSTRAINT_TYPE) CONSTRAINT_TYPE,                                                                          ",
               "       ACC.COLUMN_NAMES,                                                                                                                                    ",
               "       ACCR.TABLE_NAME R_TABLE_NAME,                                                                                                                        ",
               "       ACCR.COLUMN_NAMES                                                                                                                                    ",
               "  FROM DBA_CONSTRAINTS ACS                                                                                                                                  ",
               "  LEFT OUTER JOIN (                                                                                                                                         ",
               "                   SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES  ",
               "                     FROM DBA_CONS_COLUMNS ACCS                                                                                                             ",
               "                    GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                ",
               "                  ) ACC ON ACC.CONSTRAINT_NAME = ACS.CONSTRAINT_NAME                                                                                        ",
               "                       AND ACC.OWNER           = ACS.OWNER                                                                                                  ",
               "  LEFT OUTER JOIN (                                                                                                                                         ",
               "                   SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES  ",
               "                     FROM DBA_CONS_COLUMNS ACCS                                                                                                             ",
               "                    GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                ",
               "                  ) ACCR ON ACCR.CONSTRAINT_NAME = ACS.R_CONSTRAINT_NAME                                                                                    ",
               "                        AND ACCR.OWNER           = ACS.R_OWNER                                                                                              ",
               " WHERE 1 = 1                                                                                                                                                ",
               "   AND ACS.TABLE_NAME = '",ls_table_name.toUpperCase(),"'                                                                                                   ",
               "   AND ACS.OWNER      = '",ls_owner.toUpperCase(),"'                                                                                                        ",
               "   AND ACS.CONSTRAINT_NAME IN (",ls_constraints.toUpperCase(),")                                                                                            "
               
  PREPARE lpre_get_drop_constraint_sql FROM ls_sql
  DECLARE lcur_get_drop_constraint_sql CURSOR FOR lpre_get_drop_constraint_sql

  LET li_rec_cnt = 1
  
  OPEN lcur_get_drop_constraint_sql
  FOREACH lcur_get_drop_constraint_sql INTO lo_drop_constraint[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_Line = ""

    IF NVL(lo_drop_constraint[li_rec_cnt].DZED003,cs_null_value) = "P" THEN
      LET ls_Line = ls_Line,
                    "-- Drop primary key.","\n",
                    "alter table ",lo_drop_constraint[li_rec_cnt].dzed001," drop primary key cascade drop index;","\n"
    ELSE                     
      LET ls_Line = ls_Line,
                    "-- Drop constraint.","\n",
                    "alter table ",lo_drop_constraint[li_rec_cnt].dzed001," drop constraint ",lo_drop_constraint[li_rec_cnt].DZED002," cascade;","\n"
    END IF                     
      
    CALL lo_string_buffer.append(ls_Line)
    
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_drop_constraint_sql
  CALL lo_drop_constraint.deleteElement(li_rec_cnt)
  
  FREE lpre_get_drop_constraint_sql
  FREE lcur_get_drop_constraint_sql  

  LET ls_return = lo_string_buffer.toString()
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_get_alter_index_sql(p_owner,p_table_name,p_diff_indexes)
DEFINE 
  p_owner        STRING,
  p_table_name   STRING,
  p_diff_indexes DYNAMIC ARRAY OF T_INDEX_DIFF 
DEFINE
  ls_owner         STRING,
  ls_table_name    STRING,
  lo_diff_indexes  DYNAMIC ARRAY OF T_INDEX_DIFF,
  lo_alter_indexes DYNAMIC ARRAY OF T_INDEX_DIFF,
  li_loop          INTEGER, 
  li_rec_cnt       INTEGER,
  ls_indexes       STRING,
  ls_sql           STRING,
  ls_where         STRING,
  ls_line          STRING,
  lb_index_exist   BOOLEAN,
  ls_unique        STRING,
  lo_string_buffer base.StringBuffer
DEFINE  
  ls_return STRING

  LET ls_owner          = p_owner
  LET ls_table_name     = p_table_name
  LET lo_diff_indexes   = p_diff_indexes

  LET lo_string_buffer = base.StringBuffer.create()

  FOR li_loop = 1 TO lo_diff_indexes.getLength()
    LET ls_indexes = ls_indexes,",'",lo_diff_indexes[li_loop].dzec002,"'"
  END FOR 
  LET ls_indexes = ls_indexes.subString(2,ls_indexes.getLength())

  LET ls_sql = "SELECT UPPER(EC.DZEC001) DZEC001,                     ",
               "       UPPER(EC.DZEC002) DZEC002,                     ",
               "       UPPER(EC.DZEC003) DZEC003,                     ",
               "       UPPER(EC.DZEC004) DZEC004                      ",
               "  FROM DZEC_T EC                                      ",
               " WHERE EC.DZEC001 = '",ls_table_name.toLowerCase(),"' ",
               "   AND EC.DZEC002 IN (",ls_indexes.toLowerCase(),")   "

  PREPARE lpre_get_alter_index_sql FROM ls_sql
  DECLARE lcur_get_alter_index_sql CURSOR FOR lpre_get_alter_index_sql

  LET li_rec_cnt = 1
  
  OPEN lcur_get_alter_index_sql
  FOREACH lcur_get_alter_index_sql INTO lo_alter_indexes[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_Line = ""

    IF NVL(lo_alter_indexes[li_rec_cnt].DZEC003,cs_null_value) = "U" THEN
      LET ls_unique = "unique";
    ELSE
      LET ls_unique = "";
    END IF

    CALL sadzi140_db_check_table_index_exist(ls_owner,lo_alter_indexes[li_rec_cnt].DZEC002) RETURNING lb_index_exist
    IF lb_index_exist THEN
      LET ls_Line = ls_Line,
                    "-- sadzi140_db_get_alter_index_sql()","\n",
                    "drop index ",lo_alter_indexes[li_rec_cnt].DZEC002,";","\n"
    END IF                
      
    LET ls_Line = ls_Line,
                  "create ",ls_unique," index ",lo_alter_indexes[li_rec_cnt].DZEC002,
                  " on ",lo_alter_indexes[li_rec_cnt].DZEC001,
                  " (",lo_alter_indexes[li_rec_cnt].DZEC004,");","\n"

    LET ls_Line = ls_Line,
                  "analyze table ",lo_alter_indexes[li_rec_cnt].DZEC001," estimate statistics;","\n"
                  
    CALL lo_string_buffer.append(ls_Line)
    
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_alter_index_sql
  CALL lo_alter_indexes.deleteElement(li_rec_cnt)
  
  FREE lpre_get_alter_index_sql
  FREE lcur_get_alter_index_sql  

  LET ls_return = lo_string_buffer.toString()
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_get_drop_index_sql(p_owner,p_table_name,p_prev_version,p_diff_indexes)
DEFINE 
  p_owner        STRING,
  p_table_name   STRING,
  p_prev_version STRING,
  p_diff_indexes DYNAMIC ARRAY OF T_INDEX_DIFF 
DEFINE
  ls_owner         STRING,
  ls_table_name    STRING,
  ls_prev_version  STRING,
  lo_diff_indexes  DYNAMIC ARRAY OF T_INDEX_DIFF,
  lo_drop_indexes  DYNAMIC ARRAY OF T_INDEX_DIFF,
  li_loop          INTEGER, 
  li_rec_cnt       INTEGER,
  ls_indexes       STRING,
  ls_sql           STRING,
  ls_where         STRING,
  ls_line          STRING,
  lb_table_index_exist    BOOLEAN,
  lb_designer_index_exist BOOLEAN,
  ls_unique               STRING,
  lo_string_buffer        base.StringBuffer
DEFINE  
  ls_return STRING

  LET ls_owner          = p_owner
  LET ls_table_name     = p_table_name
  LET ls_prev_version   = p_prev_version
  LET lo_diff_indexes.* = p_diff_indexes.*

  LET lo_string_buffer = base.StringBuffer.create()

  FOR li_loop = 1 TO lo_diff_indexes.getLength()
    LET ls_indexes = ls_indexes,",'",lo_diff_indexes[li_loop].dzec002,"'"
  END FOR 
  LET ls_indexes = ls_indexes.subString(2,ls_indexes.getLength())
  
  LET ls_sql = "SELECT AIS.TABLE_NAME,AIS.INDEX_NAME,SUBSTRB(AIS.UNIQUENESS,1,1) INDEX_TYPE,                                 ",
               "       LISTAGG(AICS.COLUMN_NAME,',') WITHIN GROUP (ORDER BY AIS.INDEX_NAME,AICS.COLUMN_POSITION) COLUMN_NAME ",
               "  FROM DBA_INDEXES AIS,DBA_IND_COLUMNS AICS                                                                  ",
               " WHERE AIS.OWNER        = '",ls_owner.toUpperCase(),"'                                                       ",
               "   AND AIS.TABLE_NAME   = '",ls_table_name.toUpperCase(),"'                                                  ",
               "   AND AICS.TABLE_OWNER = AIS.TABLE_OWNER                                                                    ",
               "   AND AICS.TABLE_NAME  = AIS.TABLE_NAME                                                                     ",
               "   AND AICS.INDEX_NAME  = AIS.INDEX_NAME                                                                     ",
               "   AND AIS.INDEX_NAME NOT IN (                                                                               ",
               "                               SELECT ACS.CONSTRAINT_NAME                                                    ",
               "                                 FROM DBA_CONSTRAINTS ACS                                                    ",
               "                                WHERE ACS.TABLE_NAME = AIS.TABLE_NAME                                        ",
               "                                  AND ACS.OWNER      = AIS.OWNER                                             ",
               "                             )                                                                               ",
               "   AND AIS.INDEX_NAME IN (",ls_indexes.toUpperCase(),")                                                      ",
               "  GROUP BY AIS.TABLE_NAME,AIS.INDEX_NAME,SUBSTRB(AIS.UNIQUENESS,1,1)                                         "               
               
  PREPARE lpre_get_drop_index_sql FROM ls_sql
  DECLARE lcur_get_drop_index_sql CURSOR FOR lpre_get_drop_index_sql

  LET li_rec_cnt = 1
  
  OPEN lcur_get_drop_index_sql
  FOREACH lcur_get_drop_index_sql INTO lo_drop_indexes[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_Line = ""

    --CALL sadzi140_db_check_table_index_exist(ls_owner,lo_drop_indexes[li_rec_cnt].DZEC002) RETURNING lb_table_index_exist
    --CALL sadzi140_db_check_designer_index_exist(lo_drop_indexes[li_rec_cnt].DZEC002) RETURNING lb_designer_index_exist
    #實際表格 Index 存在及 r.t 的資料不存在時, 才產出 drop index Scripts  
    --IF lb_table_index_exist AND NOT lb_designer_index_exist THEN
      LET ls_Line = ls_Line,
                    "-- sadzi140_db_get_drop_index_sql()","\n",
                    "drop index ",lo_drop_indexes[li_rec_cnt].DZEC002,";","\n"
    --END IF                
      
    CALL lo_string_buffer.append(ls_Line)
    
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_drop_index_sql
  CALL lo_drop_indexes.deleteElement(li_rec_cnt)
  
  FREE lpre_get_drop_index_sql
  FREE lcur_get_drop_index_sql  

  LET ls_return = lo_string_buffer.toString()
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_get_alter_column_sql(p_master_user,p_table_owner,p_table_name,p_object_type,p_diff_columns)
DEFINE 
  p_master_user  STRING, 
  p_table_owner  STRING,
  p_table_name   STRING,
  p_object_type  STRING,
  p_diff_columns DYNAMIC ARRAY OF T_COLUMN_DIFF 
DEFINE
  ls_master_user    STRING, 
  ls_table_owner    STRING,
  ls_table_name     STRING,
  ls_object_type    STRING,
  lo_diff_columns   DYNAMIC ARRAY OF T_COLUMN_DIFF,
  lo_alter_columns  DYNAMIC ARRAY OF T_COLUMN_ALTER,
  lo_db_column_data     T_COLUMN_DATA,
  lo_design_column_data T_COLUMN_DATA,
  li_loop           INTEGER, 
  li_rec_cnt        INTEGER,
  ls_columns        STRING,
  ls_sql            STRING,
  ls_where          STRING,
  ls_alter_type     STRING,
  ls_alter_script   STRING,
  ls_alter_sql      STRING,
  ls_data_type      STRING,
  ls_default        STRING,
  ls_lob_tablespace STRING,
  ls_sql_upd_dzeb_t STRING,
  ls_comment_script STRING, #20161220
  ls_rebuild_index_list STRING,
  lb_column_exist   BOOLEAN
DEFINE  
  ls_return      STRING

  LET ls_master_user    = p_master_user
  LET ls_table_owner    = p_table_owner
  LET ls_table_name     = p_table_name
  LET ls_object_type    = p_object_type
  LET lo_diff_columns.* = p_diff_columns.*

  LET ls_alter_type   = ""
  LET ls_alter_script = ""
  LET ls_alter_sql    = ""

  INITIALIZE mo_columns_data_in_mem TO NULL

  #取得 LOB 型態欄位的Tablespace
  CALL sadzi140_db_get_parameter(cs_param_level_lob,cs_param_tablespace) RETURNING ls_lob_tablespace
  CALL sadzi140_db_get_column_data_to_mem(ls_table_owner,ls_table_name) RETURNING mo_columns_data_in_mem
  
  FOR li_loop = 1 TO lo_diff_columns.getLength()
    LET ls_columns = ls_columns,",'",lo_diff_columns[li_loop].DZEV005,"'"
  END FOR

  LET ls_columns = ls_columns.subString(2,ls_columns.getLength())
  #LET ls_where = " AND EV.DZEV005 IN (",ls_columns,")"
  LET ls_where = " AND EB.DZEB002 IN (",ls_columns.toLowerCase(),")"

  LET ls_sql = "SELECT UPPER(EB.DZEB002)                      DZEB002,                      ",
               "       EB.DZEB004                             DZEB004,                      ",
               "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') DZEB005,                      ",
               "       UPPER(TD.GZTD003)                      DZEB007,                      ",
               "       DECODE(                                                              ",
               "              UPPER(TD.GZTD003),                                            ",
               "              'BLOB','4000',                                                ",
               "              'CLOB','4000',                                                ",
               "              'DATE','7',                                                   ",
               "              TD.GZTD008                                                    ",
               "             )                                DZEB008,                      ",
               "       TRIM(EB.DZEB012)                       DZEB012                       ",
               "  FROM DZEB_T EB                                                            ",
               "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006                 ",
               " WHERE EB.DZEB001 = '",ls_table_name.toLowerCase(),"'                       ",
               ls_where,
               " ORDER BY EB.DZEB021                                                        "
               
  PREPARE lpre_get_alter_column_sql FROM ls_sql
  DECLARE lcur_get_alter_column_sql CURSOR FOR lpre_get_alter_column_sql

  LET li_rec_cnt = 1
  
  OPEN lcur_get_alter_column_sql
  FOREACH lcur_get_alter_column_sql INTO lo_alter_columns[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    #取得欄位資料
    CALL sadzi140_db_get_db_column_data(ls_table_owner,ls_table_name,lo_alter_columns[li_rec_cnt].DZEB002) RETURNING lo_db_column_data.*
    CALL sadzi140_db_get_design_column_data(ls_table_owner,ls_table_name,lo_alter_columns[li_rec_cnt].DZEB002) RETURNING lo_design_column_data.* 

    #查看看欄位是否存在, 若存在, 則做Modify, 否則做 Add
    CALL sadzi140_db_check_db_column_exist(ls_table_owner,ls_table_name,lo_alter_columns[li_rec_cnt].DZEB002) RETURNING lb_column_exist
    IF lb_column_exist THEN
      LET ls_alter_type = cs_alter_type_modify
    ELSE
      LET ls_alter_type = cs_alter_type_add
    END IF

    #設定Data Type
    IF (lo_db_column_data.DATA_TYPE <> lo_design_column_data.DATA_TYPE) OR 
       (NVL(lo_db_column_data.DATA_LENGTH,cs_null_default) <> NVL(lo_design_column_data.DATA_LENGTH,cs_null_default)) THEN
    
      IF (lo_alter_columns[li_rec_cnt].DZEB007 = 'DATE') OR (lo_alter_columns[li_rec_cnt].DZEB007 = 'CLOB') OR (lo_alter_columns[li_rec_cnt].DZEB007 = 'BLOB') THEN
        LET ls_data_type = lo_alter_columns[li_rec_cnt].DZEB007
      ELSE      
        LET ls_data_type = lo_alter_columns[li_rec_cnt].DZEB007,"(",lo_alter_columns[li_rec_cnt].DZEB008,")"
      END IF

      LET ls_alter_script = "ALTER TABLE",cs_SPACE,
                            ls_table_name,cs_SPACE,
                            ls_alter_type,cs_SPACE,
                            lo_alter_columns[li_rec_cnt].DZEB002,cs_SPACE,
                            ls_data_type,
                            ";","\n"

      LET ls_alter_sql = ls_alter_sql,ls_alter_script
    END IF 

    #20161220 begin
    #設定 Comment
    IF ls_alter_type = cs_alter_type_add THEN
      LET ls_comment_script = "COMMENT ON COLUMN ",ls_table_name,".",lo_alter_columns[li_rec_cnt].DZEB002," IS '",lo_alter_columns[li_rec_cnt].DZEB002,"'",";","\n"
      LET ls_alter_sql = ls_alter_sql,ls_comment_script
    END IF
    #20161220 end
    
    
    #設定預設值
    IF (NVL(lo_db_column_data.DEFAULT_VALUE,cs_null_default) <> NVL(lo_design_column_data.DEFAULT_VALUE,cs_null_default)) THEN 
      
      LET ls_alter_type = cs_alter_type_modify
      LET ls_sql_upd_dzeb_t = ""
      IF NVL(lo_alter_columns[li_rec_cnt].dzeb012,cs_null_default) <> cs_null_default THEN 
        CASE UPSHIFT(lo_alter_columns[li_rec_cnt].dzeb007)
          WHEN "BLOB"
            LET ls_default = "default",cs_SPACE,lo_alter_columns[li_rec_cnt].dzeb012
          WHEN "CLOB"
            LET ls_default = "default",cs_SPACE,lo_alter_columns[li_rec_cnt].dzeb012
          WHEN "DATE"
            LET ls_default = "default",cs_SPACE,lo_alter_columns[li_rec_cnt].dzeb012
          WHEN "NUMBER"
            LET ls_default = "default",cs_SPACE,lo_alter_columns[li_rec_cnt].dzeb012
          WHEN "TIMESTAMP"
            LET ls_default = "default",cs_SPACE,lo_alter_columns[li_rec_cnt].dzeb012
          WHEN "VARCHAR2"
            LET ls_default = "default",cs_SPACE,lo_alter_columns[li_rec_cnt].dzeb012
        END CASE 
      ELSE
        LET ls_default = "default NULL"
        #LET ls_sql_upd_dzeb_t = "UPDATE DZEB_T SET DZEB012 = "" WHERE DZEB001 = '",ls_table_name,"' AND DZEB002 = '",lo_alter_columns[li_rec_cnt].DZEB002,"'",";","\n"
        #LET ls_sql_upd_dzeb_t = ls_sql_upd_dzeb_t,
        #                        "commit;",
        #                        "\n"
      END IF 
      
      LET ls_alter_script = "ALTER TABLE",cs_SPACE,
                            ls_table_name,cs_SPACE,
                            ls_alter_type,cs_SPACE,
                            lo_alter_columns[li_rec_cnt].DZEB002,cs_SPACE,
                            ls_default,
                            ";","\n"

      LET ls_alter_sql = ls_alter_sql,ls_alter_script
      LET ls_alter_sql = ls_alter_sql,ls_sql_upd_dzeb_t
    END IF  

    #判斷為 LOB 型態的欄位, 將之移到 DSBLOB Tablespace
    IF ((lo_alter_columns[li_rec_cnt].DZEB007 = 'CLOB') OR (lo_alter_columns[li_rec_cnt].DZEB007 = 'BLOB')) THEN
      #Ex. ALTER TABLE DS.DZAB_T MOVE LOB(DZAB099) STORE AS (TABLESPACE BLOBDATA); 
      LET ls_alter_script = "ALTER TABLE",cs_SPACE,
                            ls_table_name,cs_SPACE,
                            "MOVE LOB(",lo_alter_columns[li_rec_cnt].DZEB002,")",cs_SPACE,
                            "STORE AS (TABLESPACE ",ls_lob_tablespace,")",
                            ";","\n"
                           
      LET ls_alter_sql = ls_alter_sql,ls_alter_script

      #新增/異動 BLOB,CLOB 時要重建該表格相關 Index 
      CALL sadzi140_db_get_rebuild_index_list(ls_table_name) RETURNING ls_rebuild_index_list
      LET ls_alter_sql = ls_alter_sql,ls_rebuild_index_list
      
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

FUNCTION sadzi140_db_get_alter_foreign_constraint_sql(p_table_owner,p_table_name)
DEFINE 
  p_table_owner  STRING,
  p_table_name   STRING
DEFINE
  ls_table_owner   STRING,
  ls_table_name    STRING,
  li_loop          INTEGER, 
  li_rec_cnt       INTEGER,
  lo_CONSTRAINT    T_CONSTRAINT_DIFF,
  ls_alter_sql     STRING,
  ls_alter_script  STRING,
  ls_sql           STRING,
  ls_foreign_key_state  STRING,
  ls_enable_foreign_key STRING
DEFINE  
  ls_return      STRING

  LET ls_table_owner = p_table_owner.toUpperCase()
  LET ls_table_name  = p_table_name.toLowerCase()

  #取得 Foreign 是否啟動
  CALL sadzi140_db_get_parameter(cs_param_level_editor,cs_param_enable_foreign_key) RETURNING ls_enable_foreign_key
  LET ls_foreign_key_state = IIF(ls_enable_foreign_key=="Y",cs_state_enable,cs_state_disable)
      
  LET ls_sql = " SELECT ED.DZED001,ED.DZED002,ED.DZED003,ED.DZED004,ED.DZED005,     ",
               "        ED.DZED006                                                  ", 
               "   FROM DZED_T ED                                                   ",
               "  WHERE ED.DZED005 = '",ls_table_name,"'                            ",
               "    AND NOT EXISTS (                                                ",
               "                     SELECT 1                                       ",
               "                       FROM DBA_CONSTRAINTS ACS                     ",
               "                      WHERE ACS.OWNER = '",ls_table_owner,"'        ",
               "                        AND ACS.CONSTRAINT_NAME = UPPER(ED.DZED002) ",
               "                        AND ACS.TABLE_NAME      = UPPER(ED.DZED001) ",
               "                   )                                                ",
               "    AND ED.DZED003 <> 'F'                                           "               
                              
  PREPARE lpre_get_alter_foreign_constraint_sql FROM ls_sql
  DECLARE lcur_get_alter_foreign_constraint_sql CURSOR FOR lpre_get_alter_foreign_constraint_sql

  LET li_rec_cnt = 1
  
  OPEN lcur_get_alter_foreign_constraint_sql
  FOREACH lcur_get_alter_foreign_constraint_sql INTO lo_CONSTRAINT.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_alter_script = "ALTER TABLE ",lo_CONSTRAINT.dzed001,
                          " ADD CONSTRAINT ",lo_CONSTRAINT.dzed002,
                          " FOREIGN KEY (",lo_CONSTRAINT.dzed004,") REFERENCES ",lo_CONSTRAINT.dzed005," (",lo_CONSTRAINT.dzed006,") ON DELETE CASCADE ",ls_foreign_key_state,";","\n"
       
    LET ls_alter_sql = ls_alter_sql,ls_alter_script
    
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_alter_foreign_constraint_sql
  
  FREE lpre_get_alter_foreign_constraint_sql
  FREE lcur_get_alter_foreign_constraint_sql  

  LET ls_return = ls_alter_sql
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_get_drop_column_sql(p_master_user,p_table_owner,p_table_name,p_object_type,p_diff_columns)
DEFINE 
  p_master_user  STRING, 
  p_table_owner  STRING, 
  p_table_name   STRING,
  p_object_type  STRING,
  p_diff_columns DYNAMIC ARRAY OF T_COLUMN_DIFF 
DEFINE
  ls_master_user   STRING, 
  ls_table_owner   STRING, 
  ls_table_name    STRING,
  ls_object_type   STRING,
  lo_diff_columns  DYNAMIC ARRAY OF T_COLUMN_DIFF,
  lo_alter_columns DYNAMIC ARRAY OF T_COLUMN_DIFF_W_COMMENT, #20161220
  lo_undrop_col_list DYNAMIC ARRAY OF T_COLUMN_LIST, #20161220
  li_undrop_length INTEGER,  #20161220
  li_loop          INTEGER, 
  li_rec_cnt       INTEGER,
  ls_columns       STRING,
  ls_sql           STRING,
  ls_where         STRING,
  ls_alter_type    STRING,
  ls_alter_script  STRING,
  ls_alter_sql     STRING,
  ls_data_type     STRING,
  lb_column_exist  BOOLEAN,
  lb_drop_column   BOOLEAN, #20161220
  lb_rt_drop_backdoor_column BOOLEAN #20161220
DEFINE  
  lb_return  BOOLEAN, #20161220
  ls_return  STRING,
  lo_return  DYNAMIC ARRAY OF T_COLUMN_LIST #20161220

  LET ls_master_user    = p_master_user
  LET ls_table_owner    = p_table_owner
  LET ls_table_name     = p_table_name
  LET ls_object_type    = p_object_type
  LET lo_diff_columns.* = p_diff_columns.*

  LET ls_alter_type   = ""
  LET ls_alter_script = ""
  LET ls_alter_sql    = ""
  
  CALL lo_undrop_col_list.clear()

  #20161220 begin
  LET lb_rt_drop_backdoor_column = IIF(NVL(FGL_GETENV(cs_rt_drop_backdoor_column),"N")=="Y",TRUE,FALSE)
  #LET lb_rt_drop_backdoor_column = TRUE # for test
  #20161220 end
  
  FOR li_loop = 1 TO lo_diff_columns.getLength()
    LET ls_columns = ls_columns,",'",lo_diff_columns[li_loop].DZEV005,"'"
  END FOR

  LET ls_columns = ls_columns.subString(2,ls_columns.getLength())
  #LET ls_where = " AND EV.DZEV005 IN (",ls_columns,")"
  LET ls_where = " AND ATC.COLUMN_NAME IN (",ls_columns.toUpperCase(),")"
  
  LET ls_sql = "SELECT ATC.COLUMN_NAME                      DZEV005,                        ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') DZEV006,                        ",
               "       ATC.NULLABLE                         DZEV007,                        ",
               "       ATC.DATA_TYPE                        DZEV008,                        ",
               "       TO_CHAR(DECODE(                                                      ",
               "               ATC.DATA_TYPE,                                               ",
               "               'NUMBER',DECODE(                                             ",
               "                                NVL(ATC.DATA_SCALE,'0'),                    ",
               "                                '0',ATC.DATA_PRECISION,                     ",
               "                                ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE     ",
               "                              ),                                            ",
               "               ATC.DATA_LENGTH                                              ",
               "             ))                             DZEV009,                        ", #20161220
               "       ATC.COLUMN_ID                        DZEV021,                        ", #20161220
               "       DCCS.COMMENTS                        COMMENTS                        ", #20161220
               "  FROM DBA_TAB_COLUMNS ATC                                                  ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER       ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME  ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'    ",
               "  LEFT OUTER JOIN DBA_COL_COMMENTS DCCS ON DCCS.OWNER       = ATC.OWNER       ", #20161220
               "                                       AND DCCS.TABLE_NAME  = ATC.TABLE_NAME  ", #20161220
               "                                       AND DCCS.COLUMN_NAME = ATC.COLUMN_NAME ", #20161220
               " WHERE 1=1                                                                  ",
               ls_where,
               "   AND NOT EXISTS (                                                         ",
               "                    SELECT 1 FROM DZEB_T EB                                 ",
               "                     WHERE EB.DZEB001 = LOWER(ATC.TABLE_NAME)               ",
               "                       AND EB.DZEB002 = LOWER(ATC.COLUMN_NAME)              ",
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

    #20161220 begin
    LET lb_drop_column = TRUE
    IF lo_alter_columns[li_rec_cnt].dzev005 <> cs_dummy_column_name THEN 
      IF NVL(lo_alter_columns[li_rec_cnt].comments,cs_null_value) <> lo_alter_columns[li_rec_cnt].dzev005 THEN
        IF NOT lb_rt_drop_backdoor_column THEN
          LET lb_drop_column = FALSE
        ELSE  
          LET li_undrop_length = lo_undrop_col_list.getLength() + 1
          LET lo_undrop_col_list[li_undrop_length].COLUMN_NAME = lo_alter_columns[li_rec_cnt].DZEV005
          LET lo_undrop_col_list[li_undrop_length].COLUMN_DESC = ls_table_owner,".",lo_alter_columns[li_rec_cnt].DZEV005  
        END IF 
      END IF
    END IF  
    #20161220 end

    IF lb_drop_column THEN #20161220 
      LET ls_alter_script = "ALTER TABLE ",
                           ls_table_name,
                           " DROP COLUMN ",
                           lo_alter_columns[li_rec_cnt].DZEV005,
                           ";","\n"

      LET ls_alter_sql = ls_alter_sql,ls_alter_script
    ELSE #20161220 begin
      LET li_undrop_length = lo_undrop_col_list.getLength() + 1
      LET lo_undrop_col_list[li_undrop_length].COLUMN_NAME = lo_alter_columns[li_rec_cnt].DZEV005
      LET lo_undrop_col_list[li_undrop_length].COLUMN_DESC = ls_table_owner,".",lo_alter_columns[li_rec_cnt].DZEV005  
    END IF #20161220 end
      
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_drop_column_sql
  CALL lo_alter_columns.deleteElement(li_rec_cnt)
  
  FREE lpre_get_drop_column_sql
  FREE lcur_get_drop_column_sql  

  LET lb_return = lb_rt_drop_backdoor_column #20161220
  LET ls_return = ls_alter_sql
  LET lo_return = lo_undrop_col_list #20161220
 
  RETURN lb_return,ls_return,lo_return #20161220
  
END FUNCTION

#檢核實際表格Column值是否存在
FUNCTION sadzi140_db_check_db_column_exist_by_single_column(p_owner,p_table_name,p_column_name)
DEFINE
  p_owner       STRING,
  p_table_name  STRING,
  p_column_name STRING
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_column_name STRING,
  ls_sql         STRING,
  li_rec_count   INTEGER,
  lb_return      BOOLEAN

  LET ls_owner       = p_owner.toUpperCase()
  LET ls_table_name  = p_table_name.toUpperCase()
  LET ls_column_name = p_column_name.toUpperCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                               ",
               "  FROM ALL_TAB_COLUMNS ATC                    ",
               " WHERE ATC.OWNER       = '",ls_owner,"'       ",
               "   AND ATC.TABLE_NAME  = '",ls_table_name,"'  ",
               "   AND ATC.COLUMN_NAME = '",ls_column_name,"' "
 
  PREPARE lpre_check_db_column_exist FROM ls_sql
  DECLARE lcur_check_db_column_exist CURSOR FOR lpre_check_db_column_exist
  OPEN lcur_check_db_column_exist
  FETCH lcur_check_db_column_exist INTO li_rec_count
  CLOSE lcur_check_db_column_exist
  FREE lcur_check_db_column_exist
  FREE lpre_check_db_column_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_db_check_db_column_exist(p_owner,p_table_name,p_column_name)
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

#檢核實際表格 Key 值是否存在
FUNCTION sadzi140_db_check_table_constraint_exist(p_owner,p_table_name,p_constraint_name)
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
               "  FROM ALL_CONSTRAINTS ACS                           ",
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

#檢核實際表格Synonym是否存在
FUNCTION sadzi140_db_check_table_synonym_exist(p_owner,p_table_name)
DEFINE
  p_owner       STRING,
  p_table_name  STRING
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_sql         STRING,
  li_rec_count   INTEGER,
  lb_return      BOOLEAN

  LET ls_owner      = NVL(p_owner.toUpperCase(),cs_master_user.toUpperCase())
  LET ls_table_name = p_table_name.toUpperCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                             ",
               "  FROM DBA_OBJECTS DOS                      ",
               " WHERE DOS.OWNER = '",ls_owner,"'           ",
               "   AND DOS.OBJECT_TYPE = 'SYNONYM'          ",
               "   AND DOS.OBJECT_NAME = '",ls_table_name,"'"

  PREPARE lpre_check_table_synonym_exist FROM ls_sql
  DECLARE lcur_check_table_synonym_exist CURSOR FOR lpre_check_table_synonym_exist
  OPEN lcur_check_table_synonym_exist
  FETCH lcur_check_table_synonym_exist INTO li_rec_count
  CLOSE lcur_check_table_synonym_exist
  FREE lcur_check_table_synonym_exist
  FREE lpre_check_table_synonym_exist

  DISPLAY li_rec_count
  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

#檢核實際表格 Index 是否存在
FUNCTION sadzi140_db_check_table_index_exist(p_owner,p_index_name)
DEFINE
  p_owner       STRING,
  p_index_name  STRING
DEFINE
  ls_owner      STRING,
  ls_index_name STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  lb_return     BOOLEAN

  LET ls_owner      = NVL(p_owner.toUpperCase(),cs_master_user.toUpperCase())
  LET ls_index_name = p_index_name.toUpperCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                            ",
               "  FROM ALL_INDEXES AI                      ",
               " WHERE AI.OWNER = '",ls_owner,"'           ",
               "   AND AI.INDEX_NAME = '",ls_index_name,"' " 
 
  PREPARE lpre_check_table_index_exist FROM ls_sql
  DECLARE lcur_check_table_index_exist CURSOR FOR lpre_check_table_index_exist
  OPEN lcur_check_table_index_exist
  FETCH lcur_check_table_index_exist INTO li_rec_count
  CLOSE lcur_check_table_index_exist
  FREE lcur_check_table_index_exist
  FREE lpre_check_table_index_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

#檢核 Table Designer Index 資料是否存在
FUNCTION sadzi140_db_check_designer_index_exist(p_index_name)
DEFINE
  p_index_name  STRING
DEFINE
  ls_index_name STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  lb_return     BOOLEAN

  LET ls_index_name = p_index_name.toUpperCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                        ",
               "  FROM DZEC_T EC                       ",
               " WHERE EC.DZEC002 = '",ls_index_name,"'"  
 
  PREPARE lpre_check_designer_index_exist FROM ls_sql
  DECLARE lcur_check_designer_index_exist CURSOR FOR lpre_check_designer_index_exist
  OPEN lcur_check_designer_index_exist
  FETCH lcur_check_designer_index_exist INTO li_rec_count
  CLOSE lcur_check_designer_index_exist
  FREE lcur_check_designer_index_exist
  FREE lpre_check_designer_index_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

#以亂數產出副檔名
FUNCTION sadzi140_db_get_GUID()
DEFINE
  lr_random_name RECORD
                   segment1 STRING,
                   segment2 STRING,
                   segment3 STRING,
                   segment4 STRING
                 END RECORD
DEFINE 
  li_random_value   INTEGER,
  li_max_random_num INTEGER,
  ls_GUID           STRING,
  ls_using_format   STRING
DEFINE  
  ls_return       STRING

  {
  LET li_max_random_num = 9999
  LET ls_using_format  = "&&&&"
  
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_random_name.segment1 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_random_name.segment2 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_random_name.segment3 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_random_name.segment4 = li_random_value USING ls_using_format
  
  LET ls_final_name = lr_random_name.segment1,".",
                      lr_random_name.segment2,".",
                      lr_random_name.segment3,".",
                      lr_random_name.segment4
  }

  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID 

  LET ls_return = ls_GUID
  
  RETURN ls_return                     
  
END FUNCTION

FUNCTION sadzi140_db_get_parameter(p_level,p_param)
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
               " WHERE EJ.DZEJ001 = 'adzi140_parameters' ",
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

FUNCTION sadzi140_db_get_table_in_db_type(p_table_name,p_order_type)
DEFINE 
  p_table_name STRING,
  p_order_type STRING
DEFINE
  ls_table_name       STRING,
  ls_order_type       STRING,
  ls_sql              STRING,
  li_rec_cnt          INTEGER,         
  lo_table_in_db_type DYNAMIC ARRAY OF T_TABLE_IN_DB_TYPE
DEFINE  
  lo_return DYNAMIC ARRAY OF T_TABLE_IN_DB_TYPE

  LET ls_table_name = p_table_name
  LET ls_order_type = p_order_type
  
  LET li_rec_cnt = 1
  
  LET ls_sql = "SELECT EU.DZEU002, EU.DZEU003          ",
               "  FROM DZEU_T EU                       ",
               " WHERE EU.DZEU001 = '",ls_table_name,"'",
               "   AND EU.DZEU004 = 'Y'                ",
               " ORDER BY EU.DZEU005 ",ls_order_type," "
                              
  PREPARE lpre_get_table_or_synonym FROM ls_sql
  DECLARE lcur_get_table_or_synonym CURSOR FOR lpre_get_table_or_synonym

  OPEN lcur_get_table_or_synonym
  FOREACH lcur_get_table_or_synonym INTO lo_table_in_db_type[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_table_or_synonym
  CALL lo_table_in_db_type.deleteElement(li_rec_cnt)
  
  FREE lpre_get_table_or_synonym
  FREE lcur_get_table_or_synonym  

  LET lo_return.* = lo_table_in_db_type.*
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi140_db_get_main_table_synonym_data(p_main_table)
DEFINE
  p_main_table STRING
DEFINE
  ls_main_table  STRING,
  lo_schema_type DYNAMIC ARRAY OF T_TABLE_SYNONYM,
  li_rec_cnt     INTEGER,
  ls_sql         STRING,
  lo_return      DYNAMIC ARRAY OF T_TABLE_SYNONYM

  LET ls_main_table = p_main_table

  LET li_rec_cnt = 1

  LET ls_sql = "SELECT EU.DZEU005,'',EU.DZEU001,'',EU.DZEU004,EU.DZEU002,EU.DZEU003 ", 
               "  FROM DZEU_T EU                                                    ", 
               " WHERE EU.DZEU001 = '",ls_main_table,"'                             ", 
               " ORDER BY EU.DZEU005                                                "
               
  PREPARE lpre_get_main_table_synonym_data FROM ls_sql
  DECLARE lcur_get_main_table_synonym_data CURSOR FOR lpre_get_main_table_synonym_data

  OPEN lcur_get_main_table_synonym_data
  FOREACH lcur_get_main_table_synonym_data INTO lo_schema_type[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_main_table_synonym_data
  CALL lo_schema_type.deleteElement(li_rec_cnt)
  
  FREE lpre_get_main_table_synonym_data
  FREE lcur_get_main_table_synonym_data  

  LET lo_return.* = lo_schema_type.*

  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi140_db_check_table_exist(p_owner,p_table_name)
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

  --DISPLAY li_rec_count
  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_db_get_create_table_info(p_table_name)
DEFINE 
  p_table_name STRING
DEFINE
  ls_table_name        STRING,
  ls_sql               STRING,
  li_rec_cnt           INTEGER,         
  lo_table_information T_DZEA_CREATE_TABLE
DEFINE  
  lo_return T_DZEA_CREATE_TABLE

  LET ls_table_name = p_table_name
  LET li_rec_cnt = 1
  
  LET ls_sql = "SELECT EA.DZEA003,EA.DZEA004,EA.DZEA001,EA.DZEA002,EA.DZEA005, ",
               "       EA.DZEA006,EA.DZEA007,EA.DZEA008,EA.DZEA009,EA.DZEA010, ",
               "       '',''                                                   ",
               "  FROM DZEA_T EA                                               ",
               " WHERE EA.DZEA001 = '",ls_table_name,"'                        " 
                               
  PREPARE lpre_get_table_infomation FROM ls_sql
  DECLARE lcur_get_table_infomation CURSOR FOR lpre_get_table_infomation

  OPEN lcur_get_table_infomation
  FETCH lcur_get_table_infomation INTO lo_table_information.*
  CLOSE lcur_get_table_infomation
  
  FREE lpre_get_table_infomation
  FREE lcur_get_table_infomation  

  LET lo_return.* = lo_table_information.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi140_db_get_module_leading_code(p_module_name,p_table_name)
DEFINE 
  p_module_name STRING,
  p_table_name  STRING
DEFINE
  ls_module_name  STRING,
  ls_table_name   STRING,
  ls_sql          STRING,
  li_rec_cnt      INTEGER,
  ls_leading_code VARCHAR(10)         
DEFINE  
  ls_return STRING

  LET ls_module_name = p_module_name
  LET ls_table_name  = p_table_name

  LET li_rec_cnt = 1

  LET ls_sql = "SELECT ZT.GZZT002                                                              ",
               "  FROM GZZT_T ZT                                                               ",
               " WHERE ZT.GZZT001 = (                                                          ",
               "                      SELECT ZJ.GZZJ003                                        ",
               "                        FROM GZZJ_T ZJ                                         ",
               "                       WHERE ZJ.GZZJ001 = '",ls_module_name,"'                 ",
               "                    )                                                          ",
               "   AND ZT.GZZT002 LIKE SUBSTRB('",ls_table_name,"',1,LENGTHB(ZT.GZZT002))||'%' "
                                              
  PREPARE lpre_get_module_leading_code FROM ls_sql
  DECLARE lcur_get_module_leading_code CURSOR FOR lpre_get_module_leading_code

  OPEN lcur_get_module_leading_code
  FETCH lcur_get_module_leading_code INTO ls_leading_code
  CLOSE lcur_get_module_leading_code
  
  FREE lpre_get_module_leading_code
  FREE lcur_get_module_leading_code  

  IF NVL(ls_leading_code,cs_null_value) = cs_null_value THEN

    LET ls_sql = "SELECT ZT.GZZT002                                              ",
                 "  FROM GZZT_T ZT                                               ",
                 " WHERE ZT.GZZT001 = (                                          ",
                 "                      SELECT ZJ.GZZJ003                        ",
                 "                        FROM GZZJ_T ZJ                         ",
                 "                       WHERE ZJ.GZZJ001 = '",ls_module_name,"' ",
                 "                    )                                          "
                                                
    PREPARE lpre_get_module_only_leading_code FROM ls_sql
    DECLARE lcur_get_module_only_leading_code CURSOR FOR lpre_get_module_only_leading_code

    OPEN lcur_get_module_only_leading_code
    FETCH lcur_get_module_only_leading_code INTO ls_leading_code
    CLOSE lcur_get_module_only_leading_code
    
    FREE lpre_get_module_only_leading_code
    FREE lcur_get_module_only_leading_code  
    
  END IF

  LET ls_return = ls_leading_code
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_get_module_code_by_dgenv(p_module_name,p_dgenv)
DEFINE 
  p_module_name STRING,
  p_dgenv       STRING
DEFINE
  ls_module_name  STRING,
  ls_dgenv        STRING,
  ls_sql          STRING,
  li_rec_cnt      INTEGER,
  ls_module_code  VARCHAR(10)         
DEFINE  
  ls_return STRING

  LET ls_module_name = p_module_name
  LET ls_dgenv       = p_dgenv

  LET li_rec_cnt = 1

  IF ls_dgenv = cs_dgenv_standard THEN
    LET ls_sql = "SELECT DISTINCT ZJ.GZZJ003                ",
                 "  FROM GZZJ_T ZJ                          ",
                 " WHERE ZJ.GZZJ001 = '",ls_module_name,"'  "
  ELSE 
    LET ls_sql = "SELECT ZJ.GZZJ001                         ",
                 "  FROM GZZJ_T ZJ                          ",
                 " WHERE ZJ.GZZJ001 = ZJ.GZZJ003            ",
                 "   AND ZJ.GZZJ003 = '",ls_module_name,"'  ",
                 "   AND 's' = '",ls_dgenv.toLowerCase(),"' ",
                 "UNION                                     ",
                 "SELECT ZJ.GZZJ001                         ",
                 "  FROM GZZJ_T ZJ                          ",
                 " WHERE ZJ.GZZJ001 <> ZJ.GZZJ003           ",
                 "   AND ZJ.GZZJ003 = '",ls_module_name,"'  ",
                 "   AND 'c' = '",ls_dgenv.toLowerCase(),"' "
  END IF               
                                              
  PREPARE lpre_get_module_code_by_dgenv FROM ls_sql
  DECLARE lcur_get_module_code_by_dgenv CURSOR FOR lpre_get_module_code_by_dgenv

  OPEN lcur_get_module_code_by_dgenv
  FETCH lcur_get_module_code_by_dgenv INTO ls_module_code
  CLOSE lcur_get_module_code_by_dgenv
  
  FREE lpre_get_module_code_by_dgenv
  FREE lcur_get_module_code_by_dgenv  

  LET ls_return = NVL(ls_module_code,p_module_name)
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_gen_key_data(p_table_name,p_key_list)
DEFINE
  p_table_name STRING,
  p_key_list   STRING
DEFINE
  lo_t_dzed_t RECORD
                dzed001 LIKE dzed_t.dzed001,
                dzed002 LIKE dzed_t.dzed002,
                dzed003 LIKE dzed_t.dzed003,
                dzed004 LIKE dzed_t.dzed004,
                dzed005 LIKE dzed_t.dzed005,
                dzed006 LIKE dzed_t.dzed006,
                dzed007 LIKE dzed_t.dzed007,
                dzed008 LIKE dzed_t.dzed008,
                dzed009 LIKE dzed_t.dzed009,
                dzed010 LIKE dzed_t.dzed010
              END RECORD
DEFINE
  ls_table_name      STRING,
  ls_key_list        STRING,
  ls_pre_column_name STRING,
  ls_key_name        STRING,
  lb_chk_key         BOOLEAN,
  ls_dgenv           VARCHAR(100),
  ls_user            VARCHAR(100),
  ldt_datetime       DATETIME YEAR TO SECOND
  
  
  LET ls_table_name = p_table_name
  LET ls_key_list   = p_key_list.subString(2,p_key_list.getLength())

  LET ls_DGENV = FGL_GETENV("DGENV")

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif
  
  LET ls_pre_column_name = NVL(ls_table_name.subString(1,ls_table_name.getIndexOf("_",1)-1),ls_table_name)
  LET ls_key_name = ls_pre_column_name,cs_pk_keyword

  LET lo_t_dzed_t.dzed001 = ls_table_name 
  LET lo_t_dzed_t.dzed002 = ls_key_name 
  LET lo_t_dzed_t.dzed003 = cs_primary_key_type 
  LET lo_t_dzed_t.dzed004 = ls_key_list 
  LET lo_t_dzed_t.dzed005 = ""
  LET lo_t_dzed_t.dzed006 = ""
  #LET lo_t_dzed_t.dzed007 = "N"
  #LET lo_t_dzed_t.dzed008 = ls_dgenv 
  #LET lo_t_dzed_t.dzed009 = ls_dgenv 
  #LET lo_t_dzed_t.dzed010 = "N"

  BEGIN WORK
  IF ls_key_list IS NOT NULL THEN
    TRY
    INSERT INTO DZED_T(
                        dzed001,dzed002,dzed003,dzed004,dzed005,
                        dzed006,dzed007,dzed008,dzed009,dzed010,
                        dzedcrtid,dzedcrtdt,dzedmodid,dzedmoddt
                      )
                 VALUES (
                          lo_t_dzed_t.dzed001,lo_t_dzed_t.dzed002,lo_t_dzed_t.dzed003,lo_t_dzed_t.dzed004,lo_t_dzed_t.dzed005,
                          lo_t_dzed_t.dzed006,NVL(lo_t_dzed_t.dzed007,"N"),NVL(lo_t_dzed_t.dzed008,ls_dgenv),NVL(lo_t_dzed_t.dzed009,ls_dgenv),NVL(lo_t_dzed_t.dzed010,"N"),
                          ls_user,ldt_datetime,ls_user,ldt_datetime
                        )
    CATCH
      ROLLBACK WORK
      BEGIN WORK
      #DISPLAY "Warning : Key Duplicate, update it."
      TRY 
        UPDATE dzed_t                            
           SET dzed004 = lo_t_dzed_t.dzed004,
               dzed005 = lo_t_dzed_t.dzed005,          
               dzed006 = lo_t_dzed_t.dzed006,
               #dzed007 = lo_t_dzed_t.dzed007,          
               #dzed008 = lo_t_dzed_t.dzed008,
               #dzed009 = lo_t_dzed_t.dzed009,          
               #dzed010 = lo_t_dzed_t.dzed010          
               dzedmodid = ls_user,
               dzedmoddt = ldt_datetime          
         WHERE dzed001 = lo_t_dzed_t.dzed001     
           AND dzed002 = lo_t_dzed_t.dzed002     
      CATCH
        ROLLBACK WORK
        BEGIN WORK
        DISPLAY "Error : Key update fail."
      END TRY    
    END TRY
  ELSE
    CALL sadzi140_db_check_key_data(lo_t_dzed_t.dzed001,lo_t_dzed_t.dzed002) RETURNING lb_chk_key
    IF lb_chk_key THEN 
      TRY 
        DELETE FROM DZED_T
         WHERE DZED001 = lo_t_dzed_t.dzed001
           AND DZED002 = lo_t_dzed_t.dzed002
      CATCH
        ROLLBACK WORK
        BEGIN WORK
        DISPLAY "Error : Key Delete fail."
      END TRY    
    END IF      
  END IF  
  COMMIT WORK
  
END FUNCTION

FUNCTION sadzi140_db_gen_key_index_data(p_table_name,p_key_list)
DEFINE
  p_table_name STRING,
  p_key_list   STRING
DEFINE
  lo_t_dzec_t RECORD
                dzec001 LIKE dzec_t.dzec001,
                dzec002 LIKE dzec_t.dzec002,
                dzec003 LIKE dzec_t.dzec003,
                dzec004 LIKE dzec_t.dzec004,
                dzec005 LIKE dzec_t.dzec005,
                dzec006 LIKE dzec_t.dzec006,
                dzec007 LIKE dzec_t.dzec007,
                dzec008 LIKE dzec_t.dzec008
              END RECORD
DEFINE
  ls_table_name      STRING,
  ls_key_list        STRING,
  ls_pre_column_name STRING,
  ls_key_name        STRING,
  lb_chk_index       BOOLEAN,
  ls_dgenv           VARCHAR(100),
  ls_user            VARCHAR(100),
  ldt_datetime       DATETIME YEAR TO SECOND
  
  
  LET ls_table_name = p_table_name
  LET ls_key_list   = p_key_list.subString(2,p_key_list.getLength())

  LET ls_DGENV = FGL_GETENV("DGENV")

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif
  
  LET ls_pre_column_name = NVL(ls_table_name.subString(1,ls_table_name.getIndexOf("_",1)-1),ls_table_name)
  LET ls_key_name = ls_pre_column_name,cs_pk_keyword

  LET lo_t_dzec_t.dzec001 = ls_table_name 
  LET lo_t_dzec_t.dzec002 = ls_key_name 
  LET lo_t_dzec_t.dzec003 = cs_unique_index_type 
  LET lo_t_dzec_t.dzec004 = ls_key_list 
  #LET lo_t_dzec_t.dzec005 = ""
  #LET lo_t_dzec_t.dzec006 = ls_dgenv
  #LET lo_t_dzec_t.dzec007 = ls_dgenv
  #LET lo_t_dzec_t.dzec008 = "N"
  
  BEGIN WORK
  IF ls_key_list IS NOT NULL THEN
    TRY
      INSERT INTO DZEC_T(
                          dzec001,dzec002,dzec003,dzec004,dzec005,
                          dzec006,dzec007,dzec008,
                          dzeccrtid,dzeccrtdt,dzecmodid,dzecmoddt
                        )
                 VALUES (
                          lo_t_dzec_t.dzec001,lo_t_dzec_t.dzec002,lo_t_dzec_t.dzec003,lo_t_dzec_t.dzec004,NVL(lo_t_dzec_t.dzec005,"N"),
                          NVL(lo_t_dzec_t.dzec006,ls_dgenv),NVL(lo_t_dzec_t.dzec007,ls_dgenv),NVL(lo_t_dzec_t.dzec008,"N"),
                          ls_user,ldt_datetime,ls_user,ldt_datetime
                        )
    CATCH
      ROLLBACK WORK
      BEGIN WORK
      #DISPLAY "Warning : Key Duplicate, update it."
      TRY 
        UPDATE dzec_t                            
           SET dzec004 = lo_t_dzec_t.dzec004,
               #dzec005 = lo_t_dzec_t.dzec005,
               #dzec006 = lo_t_dzec_t.dzec006,
               #dzec007 = lo_t_dzec_t.dzec007,
               #dzec008 = lo_t_dzec_t.dzec008,
               dzecmodid = ls_user,
               dzecmoddt = ldt_datetime               
         WHERE dzec001 = lo_t_dzec_t.dzec001     
           AND dzec002 = lo_t_dzec_t.dzec002     
      CATCH
        ROLLBACK WORK
        BEGIN WORK
        DISPLAY "Error : Index update fail."
      END TRY    
    END TRY
  ELSE
    CALL sadzi140_db_check_index_data(lo_t_dzec_t.dzec001,lo_t_dzec_t.dzec002) RETURNING lb_chk_index
    IF lb_chk_index THEN 
      TRY 
        DELETE FROM dzec_t
         WHERE dzec001 = lo_t_dzec_t.dzec001
           AND dzec002 = lo_t_dzec_t.dzec002
      CATCH
        ROLLBACK WORK
        BEGIN WORK
        DISPLAY "Error : Index delete fail."
      END TRY    
    END IF      
  END IF  
  COMMIT WORK
  
END FUNCTION

#檢核表格是否存在
FUNCTION sadzi140_db_check_table_exists(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  lb_return     BOOLEAN,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  ls_table_name STRING

  LET ls_table_name = p_table_name.toUpperCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT (*)                            ",
               "  FROM DBA_TABLES ATB                       ",
               " WHERE ATB.TABLE_NAME = '",ls_table_name,"' "
  
  PREPARE lpre_check_table_exists FROM ls_sql
  DECLARE lcur_check_table_exists CURSOR FOR lpre_check_table_exists
  OPEN lcur_check_table_exists
  FETCH lcur_check_table_exists INTO li_rec_count
  CLOSE lcur_check_table_exists
  FREE lcur_check_table_exists
  FREE lpre_check_table_exists

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

#檢核表格 Key 值是否存在
FUNCTION sadzi140_db_check_key_data(p_table_name,p_key_name)
DEFINE
  p_table_name  STRING,
  p_key_name    STRING
DEFINE
  lb_return     BOOLEAN,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  ls_table_name STRING,
  ls_key_name   STRING

  LET ls_table_name = p_table_name
  LET ls_key_name   = p_key_name

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                        ",
               "  FROM DZED_T ED                       ",
               " WHERE 1=1                             ",
               "   AND ED.DZED001 = '",ls_table_name,"'", 
               "   AND ED.DZED002 = '",ls_key_name,"'  " 
 
  PREPARE lpre_check_key_data FROM ls_sql
  DECLARE lcur_check_key_data CURSOR FOR lpre_check_key_data
  OPEN lcur_check_key_data
  FETCH lcur_check_key_data INTO li_rec_count
  CLOSE lcur_check_key_data
  FREE lcur_check_key_data
  FREE lpre_check_key_data

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

#取得Foreign Key List
FUNCTION sadzi140_db_get_foreign_key_list(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  lb_return      BOOLEAN,
  ls_sql         STRING,
  li_rec_count   INTEGER,
  ls_column_list STRING,
  ls_column_name VARCHAR(50),
  ls_table_name  STRING

  LET ls_table_name = p_table_name
  
  LET li_rec_count = 0
  LET ls_column_list = ""

  #取得 Foreign Key 清單
  LET ls_sql = "SELECT ED.DZED001                      ",
               "  FROM DZED_T ED                       ",
               " WHERE 1=1                             ",
               "   AND ED.DZED003 = 'R'                ",
               "   AND ED.DZED005 = '",ls_table_name,"'" 
 
  PREPARE lpre_get_foreign_key_list FROM ls_sql
  DECLARE lcur_get_foreign_key_list CURSOR FOR lpre_get_foreign_key_list
  
  OPEN lcur_get_foreign_key_list
  FOREACH lcur_get_foreign_key_list INTO ls_column_name
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

    LET ls_column_list = ls_column_list,ls_column_name,","
    
  END FOREACH
  CLOSE lcur_get_foreign_key_list
  
  FREE lcur_get_foreign_key_list
  FREE lpre_get_foreign_key_list

  LET ls_column_list = ls_column_list.subString(1,ls_column_list.getLength()-1)
  
  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return,ls_column_list
  
END FUNCTION

#檢核表格 Index 值是否存在
FUNCTION sadzi140_db_check_index_data(p_table_name,p_key_name)
DEFINE
  p_table_name  STRING,
  p_key_name    STRING
DEFINE
  lb_return     BOOLEAN,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  ls_table_name STRING,
  ls_key_name   STRING

  LET ls_table_name = p_table_name
  LET ls_key_name   = p_key_name

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                        ",
               "  FROM DZEC_T EC                       ",
               " WHERE 1=1                             ",
               "   AND EC.DZEC001 = '",ls_table_name,"'", 
               "   AND EC.DZEC002 = '",ls_key_name,"'  " 
 
  PREPARE lpre_check_index_data FROM ls_sql
  DECLARE lcur_check_index_data CURSOR FOR lpre_check_index_data
  OPEN lcur_check_index_data
  FETCH lcur_check_index_data INTO li_rec_count
  CLOSE lcur_check_index_data
  FREE lcur_check_index_data
  FREE lpre_check_index_data

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

#檢核表格是否被鎖定
FUNCTION sadzi140_db_check_table_lock(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE  
  ls_sql        STRING,
  li_rec_count  INTEGER,
  ls_table_name STRING,
  ls_enterprise STRING,
  lv_user_name  VARCHAR(500)
DEFINE
  lb_return     BOOLEAN,
  ls_user_name  STRING  

  LET ls_table_name = p_table_name.toUpperCase()

  &ifndef DEBUG
    LET ls_enterprise = g_enterprise
  &else
    LET ls_enterprise = cs_enterprise
  &endif  
  
  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1),L.OS_USER_NAME||'-'||AG.OOAG011 USERNAME     ",                  
               "  FROM GV$LOCKED_OBJECT L                                    ",
               " INNER JOIN DBA_OBJECTS O ON O.OBJECT_ID = L.OBJECT_ID       ",
               " INNER JOIN V$SESSION V ON V.SID = L.SESSION_ID              ",
               " INNER JOIN V$PROCESS P ON P.ADDR= V.PADDR                   ",
               "  LEFT OUTER JOIN (                                          ",   
               "                    SELECT XA.GZXA001,AG.OOAG011             ",   
               "                      FROM DSDEMO.OOAG_T AG,                 ",   
               "                           DSDEMO.GZXA_T XA                  ",   
               "                     WHERE XA.GZXAENT = AG.OOAGENT           ",   
               "                        AND AG.OOAG001 = XA.GZXA003          ",    
               "                        AND XA.GZXAENT = '",ls_enterprise,"' ",
               "                      GROUP BY XA.GZXA001,AG.OOAG011         ",    
               "                      ORDER BY XA.GZXA001                    ",    
               "                  ) AG                                       ",
               "                  ON AG.GZXA001 = L.OS_USER_NAME             ",
               " WHERE 1=1                                                   ",
               "   AND O.OBJECT_NAME = '",ls_table_name.toUpperCase(),"'     ",
               "   AND V.LOCKWAIT IS NULL                                    ",
               " GROUP BY L.OS_USER_NAME||'-'||AG.OOAG011                    ",
               " ORDER BY 2                                                  "
 
  PREPARE lpre_check_table_lock FROM ls_sql
  DECLARE lcur_check_table_lock CURSOR FOR lpre_check_table_lock
  OPEN lcur_check_table_lock
  FETCH lcur_check_table_lock INTO li_rec_count,lv_user_name
  CLOSE lcur_check_table_lock
  FREE lcur_check_table_lock
  FREE lpre_check_table_lock

  LET ls_user_name = lv_user_name
  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return,ls_user_name
  
END FUNCTION

FUNCTION sadzi140_db_get_more_one_record_from_all_tables(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name      STRING,
  li_rec_cnt         INTEGER,
  ls_sql             STRING,
  lv_counts_sql      VARCHAR(1024),
  ls_counts_sql      STRING,
  lb_more_record     BOOLEAN,
  lb_more_one_record BOOLEAN
DEFINE  
  lb_return BOOLEAN

  LET ls_table_name = p_table_name.toUpperCase()

  LET li_rec_cnt = 1
  LET lb_more_one_record = FALSE

  LET ls_sql = "SELECT 'SELECT COUNT(1) FROM '||ATB.OWNER||'.'||ATB.TABLE_NAME ",
               "  FROM DBA_TABLES ATB                                          ",
               " WHERE ATB.TABLE_NAME = '",ls_table_name,"'                    "
               
  PREPARE lpre_get_more_one_record_from_all_tables FROM ls_sql
  DECLARE lcur_get_more_one_record_from_all_tables CURSOR FOR lpre_get_more_one_record_from_all_tables

  OPEN lcur_get_more_one_record_from_all_tables
  FOREACH lcur_get_more_one_record_from_all_tables INTO lv_counts_sql
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_counts_sql = lv_counts_sql
    CALL sadzi140_db_get_table_more_one_record(ls_counts_sql) RETURNING lb_more_record
    IF lb_more_record THEN
      LET lb_more_one_record = TRUE
    END IF
    
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_more_one_record_from_all_tables
  
  FREE lpre_get_more_one_record_from_all_tables
  FREE lcur_get_more_one_record_from_all_tables  

  LET lb_return = lb_more_one_record

  RETURN lb_return
  
END FUNCTION

#抓取表格是否有資料存在
FUNCTION sadzi140_db_get_table_more_one_record(p_sql)
DEFINE
  p_sql    STRING
DEFINE
  ls_sql        STRING,
  li_rec_count  INTEGER
DEFINE
  lb_return     BOOLEAN

  LET ls_sql = p_sql
  
  LET lb_return = FALSE

  PREPARE lpre_get_table_more_one_record FROM ls_sql
  DECLARE lcur_get_table_more_one_record CURSOR FOR lpre_get_table_more_one_record
  TRY 
    OPEN lcur_get_table_more_one_record
    FETCH lcur_get_table_more_one_record INTO li_rec_count
    CLOSE lcur_get_table_more_one_record
  CATCH
    LET li_rec_count = 0
  END TRY   
  FREE lcur_get_table_more_one_record
  FREE lpre_get_table_more_one_record

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_db_update_alter_code(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  ls_owner         STRING,
  ls_table_name    STRING,
  li_col_fwd_rec   INTEGER,
  li_col_bwd_rec   INTEGER,
  li_key_fwd_rec   INTEGER,
  li_key_bwd_rec   INTEGER,
  li_idx_fwd_rec   INTEGER,
  li_idx_bwd_rec   INTEGER,
  li_columnid_rec  INTEGER,
  ls_exec_sql      STRING,
  ls_alter_code    STRING

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name

  #先重置異動碼
  CALL sadzi140_db_update_default_alter_code(ls_table_name,"Y")

  CALL sadzi140_db_get_column_forward_records(ls_owner,ls_table_name) RETURNING li_col_fwd_rec
  CALL sadzi140_db_get_column_backward_records(ls_owner,ls_table_name) RETURNING li_col_bwd_rec
  CALL sadzi140_db_get_key_forward_records(ls_owner,ls_table_name) RETURNING li_key_fwd_rec
  CALL sadzi140_db_get_key_backward_records(ls_owner,ls_table_name) RETURNING li_key_bwd_rec
  CALL sadzi140_db_get_index_forward_records(ls_owner,ls_table_name) RETURNING li_idx_fwd_rec
  CALL sadzi140_db_get_index_backward_records(ls_owner,ls_table_name) RETURNING li_idx_bwd_rec

  CALL sadzi140_db_get_column_id_status(ls_owner,ls_table_name) RETURNING li_columnid_rec
  
  ##############################################################################
  IF (li_col_fwd_rec >= 1) OR (li_col_bwd_rec >= 1) OR
     (li_key_fwd_rec >= 1) OR (li_key_bwd_rec >= 1) OR 
     (li_idx_fwd_rec >= 1) OR (li_idx_bwd_rec >= 1) OR
     (li_columnid_rec >= 1) THEN
    LET ls_alter_code = "N"
  ELSE
    LET ls_alter_code = "Y"
  END IF

  LET ls_exec_sql = " UPDATE DZEA_T EA                                      ",
                    "    SET EA.DZEA011 = '",ls_alter_code,"'               ",
                    "  WHERE EA.DZEA001 = '",ls_table_name.toLowerCase(),"' "
                    
  CALL sadzi140_db_exec_SQL(ls_exec_sql,FALSE)                      
  
  ##############################################################################
  
END FUNCTION 

FUNCTION sadzi140_db_update_shipping_code(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name    STRING,
  ls_exec_sql      STRING

  LET ls_table_name = p_table_name

  BEGIN WORK 
  
  LET ls_exec_sql = " UPDATE DZEA_T EA                                      ",
                    "    SET EA.DZEA017 = 'Y'                               ",
                    "  WHERE EA.DZEA001 = '",ls_table_name.toLowerCase(),"' "
                    
  CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,TRUE)

  LET ls_exec_sql = " UPDATE DZEB_T EB                                      ",
                    "    SET EB.DZEB031 = 'Y'                               ",
                    "  WHERE EB.DZEB001 = '",ls_table_name.toLowerCase(),"' "
                    
  CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,TRUE)
  
  LET ls_exec_sql = " UPDATE DZEC_T EC                                      ",
                    "    SET EC.DZEC008 = 'Y'                               ",
                    "  WHERE EC.DZEC001 = '",ls_table_name.toLowerCase(),"' "
                    
  CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,TRUE)
  
  LET ls_exec_sql = " UPDATE DZED_T ED                                      ",
                    "    SET ED.DZED010 = 'Y'                               ",
                    "  WHERE ED.DZED001 = '",ls_table_name.toLowerCase(),"' "
                    
  CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,TRUE)
  
  COMMIT WORK   
  
END FUNCTION 

FUNCTION sadzi140_db_update_default_alter_code(p_table_name,p_alter_code)
DEFINE
  p_table_name STRING,
  p_alter_code STRING
DEFINE
  ls_table_name STRING,
  ls_alter_code STRING,
  ls_exec_sql   STRING

  LET ls_table_name = p_table_name
  LET ls_alter_code = p_alter_code

  BEGIN WORK

  #Column
  LET ls_exec_sql = " UPDATE DZEB_T EB                                      ",
                    "    SET EB.DZEB028 = '",ls_alter_code,"'               ",
                    "  WHERE EB.DZEB001 = '",ls_table_name.toLowerCase(),"' "
                    
  CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,FALSE)

  #Index
  LET ls_exec_sql = " UPDATE DZEC_T EC                                      ",
                    "    SET EC.DZEC005 = '",ls_alter_code,"'               ",
                    "  WHERE EC.DZEC001 = '",ls_table_name.toLowerCase(),"' "
                    
  CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,FALSE)

  #Key
  LET ls_exec_sql = " UPDATE DZED_T ED                                      ",
                    "    SET ED.DZED007 = '",ls_alter_code,"'               ",
                    "  WHERE ED.DZED001 = '",ls_table_name.toLowerCase(),"' "
                    
  CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,FALSE)

  #Main Table
  LET ls_exec_sql = " UPDATE DZEA_T EA                                      ",
                    "    SET EA.DZEA011 = '",ls_alter_code,"'               ",
                    "  WHERE EA.DZEA001 = '",ls_table_name.toLowerCase(),"' "
                    
  CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,FALSE)                      

  COMMIT WORK
  
END FUNCTION 

FUNCTION sadzi140_db_get_column_forward_records(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  lo_column_forward_records T_COLUMN_DATA
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_column_name STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  li_return INTEGER  

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 0

  ------------------------------------------------------------------------------------------------
  -- Column forward
  ------------------------------------------------------------------------------------------------
  LET ls_sql = "SELECT UPPER(EB.DZEB002)                      COLUMN_NAME,                   ",
               "       EB.DZEB004                             ISKEY,                         ",
               "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') NULLABLE,                      ",
               "       UPPER(TD.GZTD003)                      DATA_TYPE,                     ",
               "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(                            ",
               "       DECODE(                                                               ",
               "              UPPER(TD.GZTD003),                                             ",
               "              'BLOB','4000',                                                 ",
               "              'CLOB','4000',                                                 ",
               "              'DATE','7',                                                    ",
               "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),                   ",
               "              TD.GZTD008                                                     ",
               "             ),',','.'),' ',''))),'.',',')    DATA_LENGTH,                   ",
               "       TRIM(EB.DZEB012)                       DEFAULT_VALUE                  ",
               "  FROM DZEB_T EB                                                             ",
               "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006                  ",
               " WHERE EB.DZEB001 = '",ls_table_name.toLowerCase(),"'                        ",
               "MINUS                                                                        ",
               "SELECT ATC.COLUMN_NAME                      COLUMN_NAME,                     ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                           ",
               "       ATC.NULLABLE                         NULLABLE,                        ",
               "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE,  ",
               "       REPLACE(TO_CHAR(DECODE(                                               ",
               "               ATC.DATA_TYPE,                                                ",
               "               'NUMBER',DECODE(                                              ",
               "                                NVL(ATC.DATA_SCALE,'0'),                     ",
               "                                '0',ATC.DATA_PRECISION,                      ",
               "                                ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE      ",
               "                              ),                                             ",
               "               ATC.DATA_LENGTH                                               ",
               "             )),'.',',')                    DATA_LENGTH,                     ",
               "       TRIM(DS.GET_COL_DEFAULT(ATC.TABLE_NAME,ATC.COLUMN_NAME)) DEFAULT_VALUE ",
               "  FROM DBA_TAB_COLUMNS ATC                                                   ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER        ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME   ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME  ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'     ",
               " WHERE 1=1                                                                   ",
               "   AND ATC.OWNER      = '",ls_owner.toUpperCase(),"'                         ",
               "   AND ATC.TABLE_NAME = '",ls_table_name.toUpperCase(),"'                    ",
               "   AND ATC.COLUMN_NAME NOT LIKE 'SYS_%'                                      ",
               " ORDER BY 1                                                                  "
                
  PREPARE lpre_get_column_forward_records FROM ls_sql
  DECLARE lcur_get_column_forward_records CURSOR FOR lpre_get_column_forward_records

  BEGIN WORK
  
  OPEN lcur_get_column_forward_records
  FOREACH lcur_get_column_forward_records INTO lo_column_forward_records.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_column_name = lo_column_forward_records.COLUMN_NAME
    
    LET ls_exec_sql = " UPDATE DZEB_T EB                                       ",
                      "    SET EB.DZEB028 = 'N'                                ",
                      "  WHERE EB.DZEB001 = '",ls_table_name.toLowerCase(),"'  ",
                      "    AND EB.DZEB002 = '",ls_column_name.toLowerCase(),"' "
         
    CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,FALSE)                      

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_column_forward_records

  COMMIT WORK
  
  FREE lpre_get_column_forward_records
  FREE lcur_get_column_forward_records  
  -------------------------------------------------------------------------------------------------
  
  LET li_return = li_rec_cnt
  
  RETURN li_return
  
END FUNCTION 

FUNCTION sadzi140_db_get_column_backward_records(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  lo_column_backward_records T_COLUMN_DATA
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_column_name STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  li_return INTEGER  

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 0

  ------------------------------------------------------------------------------------------------
  -- Column backward
  ------------------------------------------------------------------------------------------------
  LET ls_sql = " SELECT ATC.COLUMN_NAME                      COLUMN_NAME,                     ",
               "        DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                           ",
               "        ATC.NULLABLE                         NULLABLE,                        ",
               "        DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE,  ",
               "        REPLACE(TO_CHAR(DECODE(                                               ",
               "                ATC.DATA_TYPE,                                                ",
               "                'NUMBER',DECODE(                                              ",
               "                                 NVL(ATC.DATA_SCALE,'0'),                     ",
               "                                 '0',ATC.DATA_PRECISION,                      ",
               "                                 ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE      ",
               "                               ),                                             ",
               "                ATC.DATA_LENGTH                                               ",
               "              )),'.',',')                    DATA_LENGTH,                     ",
               "        TRIM(DS.GET_COL_DEFAULT(ATC.TABLE_NAME,ATC.COLUMN_NAME)) DEFAULT_VALUE ",
               "   FROM DBA_TAB_COLUMNS ATC                                                   ",
               "   LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER        ",
               "                                       AND ACC.TABLE_NAME  = ATC.TABLE_NAME   ",
               "                                       AND ACC.COLUMN_NAME = ATC.COLUMN_NAME  ",
               "                                       AND ACC.CONSTRAINT_NAME LIKE '%PK'     ",
               "  WHERE 1=1                                                                   ",
               "    AND ATC.OWNER      = '",ls_owner.toUpperCase(),"'                         ",
               "    AND ATC.TABLE_NAME = '",ls_table_name.toUpperCase(),"'                    ",
               "    AND ATC.COLUMN_NAME NOT LIKE 'SYS_%'                                       ",
               " MINUS                                                                        ",
               " SELECT UPPER(EB.DZEB002)                      COLUMN_NAME,                   ",
               "        EB.DZEB004                             ISKEY,                         ",
               "        DECODE(EB.DZEB004,'Y','N','N','Y','Y') NULLABLE,                      ",
               "        UPPER(TD.GZTD003)                      DATA_TYPE,                     ",
               "        REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(                            ",
               "        DECODE(                                                               ",
               "               UPPER(TD.GZTD003),                                             ",
               "               'BLOB','4000',                                                 ",
               "               'CLOB','4000',                                                 ",
               "               'DATE','7',                                                    ",
               "               'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),                   ",
               "               TD.GZTD008                                                     ",
               "              ),',','.'),' ',''))),'.',',')    DATA_LENGTH,                   ",
               "        TRIM(EB.DZEB012)                       DEFAULT_VALUE                  ",
               "   FROM DZEB_T EB                                                             ",
               "        LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006                  ",
               "  WHERE EB.DZEB001 = '",ls_table_name.toLowerCase(),"'                        ",
               "  ORDER BY 1                                                                  "
                
  PREPARE lpre_get_column_backward_records FROM ls_sql
  DECLARE lcur_get_column_backward_records CURSOR FOR lpre_get_column_backward_records

  OPEN lcur_get_column_backward_records
  FOREACH lcur_get_column_backward_records INTO lo_column_backward_records.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_column_backward_records
  
  FREE lpre_get_column_backward_records
  FREE lcur_get_column_backward_records  
  -------------------------------------------------------------------------------------------------
  
  LET li_return = li_rec_cnt
  
  RETURN li_return
  
END FUNCTION 

FUNCTION sadzi140_db_get_key_forward_records(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  lo_key_forward_records T_CONSTRAINT_DIFF
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_key_name    STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  li_return INTEGER  

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 0

  ------------------------------------------------------------------------------------------------
  -- key forward
  ------------------------------------------------------------------------------------------------
  LET ls_sql = "SELECT UPPER(ED.DZED001)       TABLE_NAME,                                                                                                                  ",
               "       UPPER(ED.DZED002)       CONSTRAINT_NAME,                                                                                                             ",
               "       UPPER(ED.DZED003)       CONSTRAINT_TYPE,                                                                                                             ",
               "       UPPER(ED.DZED004)       COLUMN_NAMES,                                                                                                                ",
               "       UPPER(TRIM(ED.DZED005)) R_TABLE_NAME,                                                                                                                ",
               "       UPPER(TRIM(ED.DZED006)) R_COLUMN_NAMES                                                                                                               ",
               "  FROM DZED_T ED                                                                                                                                            ",
               " WHERE ED.DZED001 = '",ls_table_name.toLowerCase(),"'                                                                                                       ",
               "   AND ED.DZED003 <> 'F'                                                                                                                                    ",         
               "MINUS                                                                                                                                                       ",
               "SELECT ACS.TABLE_NAME,                                                                                                                                      ",
               "       ACS.CONSTRAINT_NAME,                                                                                                                                 ",
               "       DECODE(ACS.CONSTRAINT_TYPE, 'R', 'R', ACS.CONSTRAINT_TYPE) CONSTRAINT_TYPE,                                                                          ",
               "       ACC.COLUMN_NAMES,                                                                                                                                    ",
               "       ACCR.TABLE_NAME R_TABLE_NAME,                                                                                                                        ",
               "       ACCR.COLUMN_NAMES                                                                                                                                    ",
               "  FROM DBA_CONSTRAINTS ACS                                                                                                                                  ",
               "  LEFT OUTER JOIN (                                                                                                                                         ",
               "                   SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES  ",
               "                     FROM DBA_CONS_COLUMNS ACCS                                                                                                             ",
               "                    GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                ",
               "                  ) ACC ON ACC.CONSTRAINT_NAME = ACS.CONSTRAINT_NAME                                                                                        ",
               "                       AND ACC.OWNER           = ACS.OWNER                                                                                                  ",
               "  LEFT OUTER JOIN (                                                                                                                                         ",
               "                   SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES  ",
               "                     FROM DBA_CONS_COLUMNS ACCS                                                                                                             ",
               "                    GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                ",
               "                  ) ACCR ON ACCR.CONSTRAINT_NAME = ACS.R_CONSTRAINT_NAME                                                                                    ",
               "                        AND ACCR.OWNER           = ACS.R_OWNER                                                                                              ",
               " WHERE 1 = 1                                                                                                                                                ",
               "   AND ACS.TABLE_NAME = '",ls_table_name.toUpperCase(),"'                                                                                                   ",
               "   AND ACS.OWNER      = '",ls_owner.toUpperCase(),"'                                                                                                        ",
               "   AND ACS.CONSTRAINT_NAME NOT LIKE 'SYS%'                                                                                                                  "             
                
  PREPARE lpre_get_key_forward_records FROM ls_sql
  DECLARE lcur_get_key_forward_records CURSOR FOR lpre_get_key_forward_records

  OPEN lcur_get_key_forward_records
  FOREACH lcur_get_key_forward_records INTO lo_key_forward_records.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_key_forward_records

  FREE lpre_get_key_forward_records
  FREE lcur_get_key_forward_records  
  -------------------------------------------------------------------------------------------------
  
  LET li_return = li_rec_cnt
  
  RETURN li_return
  
END FUNCTION 

FUNCTION sadzi140_db_get_key_backward_records(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  lo_key_backward_records T_CONSTRAINT_DIFF
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_key_name    STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  li_return INTEGER  

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 0

  ------------------------------------------------------------------------------------------------
  -- key backward
  ------------------------------------------------------------------------------------------------
  LET ls_sql = "SELECT ACS.TABLE_NAME,                                                                                                                                      ",
               "       ACS.CONSTRAINT_NAME,                                                                                                                                 ",
               "       DECODE(ACS.CONSTRAINT_TYPE, 'R', 'R', ACS.CONSTRAINT_TYPE) CONSTRAINT_TYPE,                                                                          ",
               "       ACC.COLUMN_NAMES,                                                                                                                                    ",
               "       ACCR.TABLE_NAME R_TABLE_NAME,                                                                                                                        ",
               "       ACCR.COLUMN_NAMES                                                                                                                                    ",
               "  FROM DBA_CONSTRAINTS ACS                                                                                                                                  ",
               "  LEFT OUTER JOIN (                                                                                                                                         ",
               "                   SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES  ",
               "                     FROM DBA_CONS_COLUMNS ACCS                                                                                                             ",
               "                    GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                ",
               "                  ) ACC ON ACC.CONSTRAINT_NAME = ACS.CONSTRAINT_NAME                                                                                        ",
               "                       AND ACC.OWNER           = ACS.OWNER                                                                                                  ",
               "  LEFT OUTER JOIN (                                                                                                                                         ",
               "                   SELECT ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME,LISTAGG(ACCS.COLUMN_NAME, ',') WITHIN GROUP(ORDER BY ACCS.POSITION) COLUMN_NAMES  ",
               "                     FROM DBA_CONS_COLUMNS ACCS                                                                                                             ",
               "                    GROUP BY ACCS.CONSTRAINT_NAME,ACCS.OWNER,ACCS.TABLE_NAME                                                                                ",
               "                  ) ACCR ON ACCR.CONSTRAINT_NAME = ACS.R_CONSTRAINT_NAME                                                                                    ",
               "                        AND ACCR.OWNER           = ACS.R_OWNER                                                                                              ",
               " WHERE 1 = 1                                                                                                                                                ",
               "   AND ACS.TABLE_NAME = '",ls_table_name.toUpperCase(),"'                                                                                                   ",
               "   AND ACS.OWNER      = '",ls_owner.toUpperCase(),"'                                                                                                        ",
               "   AND ACS.CONSTRAINT_NAME NOT LIKE 'SYS%'                                                                                                                  ",           
               "MINUS                                                                                                                                                       ",
               "SELECT UPPER(ED.DZED001)       TABLE_NAME,                                                                                                                  ",
               "       UPPER(ED.DZED002)       CONSTRAINT_NAME,                                                                                                             ",
               "       UPPER(ED.DZED003)       CONSTRAINT_TYPE,                                                                                                             ",
               "       UPPER(ED.DZED004)       COLUMN_NAMES,                                                                                                                ",
               "       UPPER(TRIM(ED.DZED005)) R_TABLE_NAME,                                                                                                                ",
               "       UPPER(TRIM(ED.DZED006)) R_COLUMN_NAMES                                                                                                               ",
               "  FROM DZED_T ED                                                                                                                                            ",
               " WHERE ED.DZED001 = '",ls_table_name.toLowerCase(),"'                                                                                                       ",
               "   AND ED.DZED003 <> 'F'                                                                                                                                    "         
                
  PREPARE lpre_get_key_backward_records FROM ls_sql
  DECLARE lcur_get_key_backward_records CURSOR FOR lpre_get_key_backward_records

  OPEN lcur_get_key_backward_records
  FOREACH lcur_get_key_backward_records INTO lo_key_backward_records.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_key_backward_records
  
  FREE lpre_get_key_backward_records
  FREE lcur_get_key_backward_records  
  -------------------------------------------------------------------------------------------------
  
  LET li_return = li_rec_cnt
  
  RETURN li_return
  
END FUNCTION 

FUNCTION sadzi140_db_get_index_forward_records(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  lo_index_forward_records T_INDEX_DATA
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_index_name STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  li_return INTEGER  

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 0

  ------------------------------------------------------------------------------------------------
  -- Index forward
  ------------------------------------------------------------------------------------------------
  LET ls_sql = "SELECT UPPER(EC.DZEC001) TABLE_NAME,                                                                         ",
               "       UPPER(EC.DZEC002) INDEX_NAME,                                                                         ",
               "       UPPER(EC.DZEC003) INDEX_TYPE,                                                                         ",
               "       UPPER(REPLACE(EC.DZEC004,' ','')) COLUMN_NAME                                                         ",
               "  FROM DZEC_T EC                                                                                             ",
               " WHERE EC.DZEC001 = '",ls_table_name.toLowerCase(),"'                                                        ",
               "   AND NOT EXISTS (                                                                                          ",
               "                    SELECT 1                                                                                 ",
               "                      FROM DZED_T ED                                                                         ",
               "                     WHERE ED.DZED001 = EC.DZEC001                                                           ",
               "                       AND ED.DZED002 = EC.DZEC002                                                           ",
               "                  )                                                                                          ",
               " MINUS                                                                                                       ",
               "SELECT AIS.TABLE_NAME TABLE_NAME,                                                                            ",
               "       AIS.INDEX_NAME INDEX_NAME,                                                                            ",
               "       SUBSTRB(DECODE(AIS.UNIQUENESS,'UNIQUE','UNIQUE',AIS.INDEX_TYPE),1,1) INDEX_TYPE,                      ",
               "       LISTAGG(AICS.COLUMN_NAME,',') WITHIN GROUP (ORDER BY AIS.INDEX_NAME,AICS.COLUMN_POSITION) COLUMN_NAME ",
               "  FROM DBA_INDEXES AIS,DBA_IND_COLUMNS AICS                                                                  ",
               " WHERE AIS.OWNER        = '",ls_owner.toUpperCase(),"'                                                       ",
               "   AND AIS.TABLE_NAME   = '",ls_table_name.toUpperCase(),"'                                                  ",
               "   AND AICS.TABLE_OWNER = AIS.TABLE_OWNER                                                                    ",
               "   AND AICS.TABLE_NAME  = AIS.TABLE_NAME                                                                     ",
               "   AND AICS.INDEX_NAME  = AIS.INDEX_NAME                                                                     ",
               "   AND AIS.INDEX_NAME NOT IN (                                                                               ",
               "                               SELECT ACS.CONSTRAINT_NAME                                                    ",
               "                                 FROM DBA_CONSTRAINTS ACS                                                    ",
               "                                WHERE ACS.TABLE_NAME = AIS.TABLE_NAME                                        ",
               "                                  AND ACS.OWNER      = AIS.OWNER                                             ",
               "                             )                                                                               ",
               " GROUP BY AIS.TABLE_NAME,AIS.INDEX_NAME,SUBSTRB(DECODE(AIS.UNIQUENESS,'UNIQUE','UNIQUE',AIS.INDEX_TYPE),1,1) "
                
  PREPARE lpre_get_index_forward_records FROM ls_sql
  DECLARE lcur_get_index_forward_records CURSOR FOR lpre_get_index_forward_records

  BEGIN WORK
  
  OPEN lcur_get_index_forward_records
  FOREACH lcur_get_index_forward_records INTO lo_index_forward_records.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_index_name = lo_index_forward_records.COLUMN_NAME
    
    LET ls_exec_sql = "UPDATE DZEC_T EC                                      ",
                      "   SET EC.DZEC005 = 'N'                               ",
                      " WHERE EC.DZEC001 = '",ls_table_name.toLowerCase(),"' ",
                      "   AND EC.DZEC002 = '",ls_index_name.toLowerCase(),"' "

    CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,FALSE)                      

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_index_forward_records
  
  COMMIT WORK
  
  FREE lpre_get_index_forward_records
  FREE lcur_get_index_forward_records  
  -------------------------------------------------------------------------------------------------
  
  LET li_return = li_rec_cnt
  
  RETURN li_return
  
END FUNCTION 

FUNCTION sadzi140_db_get_index_backward_records(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  lo_index_backward_records T_INDEX_DATA
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_index_name STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  li_return INTEGER  

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 0

  ------------------------------------------------------------------------------------------------
  -- Index backward
  ------------------------------------------------------------------------------------------------
  LET ls_sql = "SELECT AIS.TABLE_NAME TABLE_NAME,                                                                            ",
               "       AIS.INDEX_NAME INDEX_NAME,                                                                            ",
               "       SUBSTRB(DECODE(AIS.UNIQUENESS,'UNIQUE','UNIQUE',AIS.INDEX_TYPE),1,1) INDEX_TYPE,                      ",
               "       LISTAGG(AICS.COLUMN_NAME,',') WITHIN GROUP (ORDER BY AIS.INDEX_NAME,AICS.COLUMN_POSITION) COLUMN_NAME ",
               "  FROM DBA_INDEXES AIS,DBA_IND_COLUMNS AICS                                                                  ",
               " WHERE AIS.OWNER        = '",ls_owner.toUpperCase(),"'                                                       ",
               "   AND AIS.TABLE_NAME   = '",ls_table_name.toUpperCase(),"'                                                  ",
               "   AND AICS.TABLE_OWNER = AIS.TABLE_OWNER                                                                    ",
               "   AND AICS.TABLE_NAME  = AIS.TABLE_NAME                                                                     ",
               "   AND AICS.INDEX_NAME  = AIS.INDEX_NAME                                                                     ",
               "   AND AIS.INDEX_NAME NOT IN (                                                                               ",
               "                               SELECT ACS.CONSTRAINT_NAME                                                    ",
               "                                 FROM DBA_CONSTRAINTS ACS                                                    ",
               "                                WHERE ACS.TABLE_NAME = AIS.TABLE_NAME                                        ",
               "                                  AND ACS.OWNER      = AIS.OWNER                                             ",
               "                             )                                                                               ",
               " GROUP BY AIS.TABLE_NAME,AIS.INDEX_NAME,SUBSTRB(DECODE(AIS.UNIQUENESS,'UNIQUE','UNIQUE',AIS.INDEX_TYPE),1,1) ",
               " MINUS                                                                                                       ",
               "SELECT UPPER(EC.DZEC001) TABLE_NAME,                                                                         ",
               "       UPPER(EC.DZEC002) INDEX_NAME,                                                                         ",
               "       UPPER(EC.DZEC003) INDEX_TYPE,                                                                         ",
               "       UPPER(REPLACE(EC.DZEC004,' ','')) COLUMN_NAME                                                         ",
               "  FROM DZEC_T EC                                                                                             ",
               " WHERE EC.DZEC001 = '",ls_table_name.toLowerCase(),"'                                                        ",
               "   AND NOT EXISTS (                                                                                          ",
               "                    SELECT 1                                                                                 ",
               "                      FROM DZED_T ED                                                                         ",
               "                     WHERE ED.DZED001 = EC.DZEC001                                                           ",
               "                       AND ED.DZED002 = EC.DZEC002                                                           ",
               "                  )                                                                                          "
                
  PREPARE lpre_get_index_backward_records FROM ls_sql
  DECLARE lcur_get_index_backward_records CURSOR FOR lpre_get_index_backward_records

  OPEN lcur_get_index_backward_records
  FOREACH lcur_get_index_backward_records INTO lo_index_backward_records.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_index_backward_records
  
  FREE lpre_get_index_backward_records
  FREE lcur_get_index_backward_records  
  -------------------------------------------------------------------------------------------------
  
  LET li_return = li_rec_cnt
  
  RETURN li_return
  
END FUNCTION 

FUNCTION sadzi140_db_get_column_id_status(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_key_name    STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  li_colid_cnt   INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  li_return INTEGER  

  LET ls_owner      = p_owner
  LET ls_table_name = p_table_name
  
  LET li_rec_cnt = 0

  ------------------------------------------------------------------------------------------------
  -- key backward
  ------------------------------------------------------------------------------------------------

  LET ls_sql = "SELECT 1                                                    ",
               "  FROM (                                                    ",
               "          SELECT ATC.COLUMN_ID   ROW_NUM,                   ",           
               "                 ATC.COLUMN_NAME COLUMN_NAME                ",           
               "            FROM DBA_TAB_COLUMNS ATC                        ",           
               "           WHERE ATC.OWNER = UPPER('",ls_owner,"')          ",
               "             AND ATC.TABLE_NAME = UPPER('",ls_table_name,"')",
               "             AND ATC.COLUMN_NAME <> 'DUMMY'                 ",           
               "          MINUS                                             ",
               "         SELECT EB.DZEB021        ROW_NUM,                  ",          
               "                UPPER(EB.DZEB002) COLUMN_NAME               ",          
               "           FROM DZEB_T EB                                   ",          
               "         WHERE EB.DZEB001 = LOWER('",ls_table_name,"')      ",
               "         UNION                                              ",
               "         SELECT EB.DZEB021        ROW_NUM,                  ",          
               "                UPPER(EB.DZEB002) COLUMN_NAME               ",          
               "           FROM DZEB_T EB                                   ",          
               "         WHERE EB.DZEB001 = LOWER('",ls_table_name,"')      ",
               "         MINUS                                              ",
               "         SELECT ATC.COLUMN_ID   ROW_NUM,                    ",          
               "                ATC.COLUMN_NAME COLUMN_NAME                 ",          
               "           FROM DBA_TAB_COLUMNS ATC                         ",          
               "          WHERE ATC.OWNER = UPPER('",ls_owner,"')           ",
               "            AND ATC.TABLE_NAME = UPPER('",ls_table_name,"') ",
               "            AND ATC.COLUMN_NAME <> 'DUMMY'                  ",
               "       ) COL_STATUS                                         "

                
  PREPARE lpre_get_column_id_status FROM ls_sql
  DECLARE lcur_get_column_id_status CURSOR FOR lpre_get_column_id_status

  OPEN lcur_get_column_id_status
  FOREACH lcur_get_column_id_status INTO li_colid_cnt
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_column_id_status
  
  FREE lpre_get_column_id_status
  FREE lcur_get_column_id_status  
  -------------------------------------------------------------------------------------------------
  
  LET li_return = li_rec_cnt
  
  RETURN li_return
  
END FUNCTION 

FUNCTION sadzi140_db_get_db_info()
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

FUNCTION sadzi140_db_connect_db(p_db)
DEFINE 
  p_db STRING
DEFINE
  lb_return BOOLEAN   

  LET lb_return = TRUE
  
  TRY
    DISCONNECT CURRENT
  CATCH
    DISPLAY cs_message_tag,"No any connection, skip disconnect."
  END TRY  

  TRY 
    CONNECT TO p_db
  CATCH
    LET lb_return = FALSE
    DISPLAY cs_error_tag,"Could not connect to database, please contact DBA !"
  END TRY 

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_db_get_table_columns(p_owner,p_table_name,p_cursor)
DEFINE
  p_owner      STRING,
  p_table_name STRING,
  p_cursor     STRING 
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_cursor      STRING, 
  li_rec_cnt     INTEGER,
  lv_column      VARCHAR(1024),
  ls_column      STRING,  
  ls_sql         STRING,
  li_column_num  INTEGER,
  ls_CRLF        STRING,
  ls_multi_cols  STRING,
  ls_cursor_cols STRING
DEFINE  
  lb_return BOOLEAN

  LET ls_owner      = p_owner.toUpperCase()     
  LET ls_table_name = p_table_name.toUpperCase()
  LET ls_cursor     = p_cursor    

  LET ls_multi_cols = ""
  LET ls_cursor_cols = ""
  
  LET li_rec_cnt = 1
  LET li_column_num = 0

  LET ls_sql = "SELECT ATC.COLUMN_NAME                     ",
               "  FROM DBA_TAB_COLUMNS ATC                 ",
               " WHERE ATC.OWNER      = '",ls_owner,"'     ",
               "   AND ATC.TABLE_NAME = '",ls_table_name,"'",
               " ORDER BY ATC.COLUMN_ID                    "
                                                     
  PREPARE lpre_get_table_columns FROM ls_sql
  DECLARE lcur_get_table_columns CURSOR FOR lpre_get_table_columns

  OPEN lcur_get_table_columns
  FOREACH lcur_get_table_columns INTO lv_column
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_column_num = li_column_num + 1

    IF li_column_num >= 10 THEN 
      LET ls_CRLF = "\n"
    ELSE
      LET ls_CRLF = ""
    END IF 
    
    LET ls_column = lv_column
    LET ls_multi_cols = ls_multi_cols,ls_column,",",ls_CRLF
    LET ls_cursor_cols = ls_cursor_cols,ls_cursor,".",ls_column,",",ls_CRLF

    IF li_column_num >= 10 THEN
      LET li_column_num = 0
    END IF 
    
  END FOREACH
  CLOSE lcur_get_table_columns
  
  LET ls_multi_cols = ls_multi_cols.subString(1,ls_multi_cols.getLength()-1)
  IF ls_multi_cols.subString(ls_multi_cols.getLength(),ls_multi_cols.getLength()) = "," THEN
    LET ls_multi_cols = ls_multi_cols.subString(1,ls_multi_cols.getLength()-1)
  END IF  
  
  LET ls_cursor_cols = ls_cursor_cols.subString(1,ls_cursor_cols.getLength()-1)
  IF ls_cursor_cols.subString(ls_cursor_cols.getLength(),ls_cursor_cols.getLength()) = "," THEN
    LET ls_cursor_cols = ls_cursor_cols.subString(1,ls_cursor_cols.getLength()-1)
  END IF   
  
  FREE lpre_get_table_columns
  FREE lcur_get_table_columns  

  RETURN ls_multi_cols,ls_cursor_cols
  
END FUNCTION

FUNCTION sadzi140_db_get_DZEA_info(p_table_name)
DEFINE 
  p_table_name STRING
DEFINE
  ls_table_name STRING,
  ls_sql        STRING,
  lo_DZEA_info  T_DZEA_INFO
DEFINE  
  lo_return T_DZEA_INFO

  LET ls_table_name = p_table_name
  
  LET ls_sql = "SELECT EA.DZEA001,EA.DZEA002,EA.DZEA003,EA.DZEA004,EA.DZEA005, ",
               "       EA.DZEA006,EA.DZEA007,EA.DZEA008,EA.DZEA009,EA.DZEA010, ",
               "       EA.DZEA011,EA.DZEA012,EA.DZEA013,EA.DZEA014,EA.DZEA015  ",
               "  FROM DZEA_T EA                                               ",
               " WHERE EA.DZEA001 = '",ls_table_name,"'                        " 
                               
  PREPARE lpre_get_DZEA_info FROM ls_sql
  DECLARE lcur_get_DZEA_info CURSOR FOR lpre_get_DZEA_info

  OPEN lcur_get_DZEA_info
  FETCH lcur_get_DZEA_info INTO lo_DZEA_info.*
  CLOSE lcur_get_DZEA_info
  
  FREE lpre_get_DZEA_info
  FREE lcur_get_DZEA_info  

  LET lo_return.* = lo_DZEA_info.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi140_db_gen_move_data_script(p_table_name,p_reb_table,p_multi_cols,p_cursor_cols)
DEFINE
  p_table_name  STRING,
  p_reb_table   STRING,
  p_multi_cols  STRING,
  p_cursor_cols STRING
DEFINE
  ##########################
  ls_drop_script      STRING,
  ls_exit_sign        STRING,
  ls_drop_full        STRING,
  ##########################
  ls_table_name       STRING,
  ls_reb_table        STRING,
  ls_multi_cols       STRING,
  ls_cursor_cols      STRING,
  ls_random_name      STRING,
  ls_tempdir          STRING,
  lchannel_write      base.Channel,
  ls_sript_filename   STRING,
  ls_procedure_script STRING,
  ls_separator        STRING
DEFINE
  ls_return STRING  
  
  LET ls_table_name  = p_table_name
  LET ls_reb_table   = p_reb_table
  LET ls_multi_cols  = p_multi_cols
  LET ls_cursor_cols = p_cursor_cols

  LET ls_separator = os.Path.separator()
  
  LET ls_tempdir = FGL_GETENV("TEMPDIR")
  CALL sadzi140_db_get_GUID() RETURNING ls_random_name 
  LET ls_sript_filename = ls_tempdir,ls_separator,ls_table_name,ls_random_name,".mve"
  
  LET ls_exit_sign = "exit;"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  LET ls_procedure_script = "-- Fill rebuild data procedure                                       ","\n",
                            "SET SERVEROUTPUT ON                                                  ","\n",
                            "DECLARE                                                              ","\n",
                            "  ------------------------------------------------------------------ ","\n",
                            "  cursor c_datas IS                                                  ","\n",
                            "    SELECT *                                                         ","\n",
                            "      FROM ",ls_reb_table.toUpperCase(),";                           ","\n",
                            "  r_datas c_datas%ROWTYPE;                                           ","\n",
                            "  ------------------------------------------------------------------ ","\n",
                            "  cs_ERROR_TAG        CONSTANT VARCHAR2(20) := '",cs_error_tag,"';   ","\n",                                      
                            "  cs_WARNING_TAG      CONSTANT VARCHAR2(20) := '",cs_warning_tag,"'; ","\n",                                        
                            "  cs_SUCCESS_TAG      CONSTANT VARCHAR2(20) := '",cs_success_tag,"'; ","\n",
                            "  cs_MSG              CONSTANT VARCHAR2(20) := 'Moving Data.';       ","\n",
                            "  ls_SQL              VARCHAR2(1024);                                ","\n",
                            "  ls_columns          VARCHAR2(4000);                                ","\n",
                            "  ls_TableName        VARCHAR2(30);                                  ","\n",
                            "  ls_RebuildTableName VARCHAR2(30);                                  ","\n",
                            "  ls_Owner            VARCHAR2(30);                                  ","\n",
                            "  ln_count            INTEGER;                                       ","\n",
                            "  ln_count_total      INTEGER;                                       ","\n",
                            "  ------------------------------------------------------------------ ","\n",
                            "BEGIN                                                                ","\n",              
                            "  DBMS_OUTPUT.ENABLE(100000);                                        ","\n",
                            "                                                                     ","\n",
                            "  ln_count := 1;                                                     ","\n",
                            "  ln_count_total := 0;                                               ","\n",
                            "                                                                     ","\n",
                            "  open c_datas;                                                      ","\n",
                            "  loop                                                               ","\n",
                            "    fetch c_datas into r_datas;                                      ","\n",
                            "    if c_datas%notfound then                                         ","\n",
                            "       exit;                                                         ","\n",
                            "    end if;                                                          ","\n",
                            "                                                                     ","\n",
                            "    INSERT INTO ",ls_table_name.toUpperCase(),"                      ","\n",
                            "    (                                                                ","\n",
                            ls_multi_cols,                                                        
                            "    )                                                                ","\n",
                            "    VALUES                                                           ","\n",
                            "    (                                                                ","\n",
                            ls_cursor_cols,                                                       
                            "    );                                                               ","\n",
                            "                                                                     ","\n",
                            "    ln_count := ln_count + 1;                                        ","\n",
                            "    if ln_count >= 1000 then                                         ","\n",
                            "      commit;                                                        ","\n",
                            "      ln_count_total := ln_count_total + ln_count;                   ","\n",
                            "      ln_count := 1;                                                 ","\n",
                            "    end if;                                                          ","\n",
                            "                                                                     ","\n",
                            "  end loop;                                                          ","\n",
                            "                                                                     ","\n",
                            "  ln_count_total := ln_count_total + ln_count;                       ","\n",
                            "                                                                     ","\n",
                            "  commit;                                                            ","\n",
                            "                                                                     ","\n",
                            "  DBMS_OUTPUT.PUT_LINE(cs_SUCCESS_TAG||' '||cs_MSG);                 ","\n",                                 
                            "                                                                     ","\n",
                            "EXCEPTION                                                            ","\n",              
                            "  WHEN OTHERS THEN ROLLBACK;                                         ","\n",            
                            "  DBMS_OUTPUT.PUT_LINE(cs_ERROR_TAG||' '||cs_MSG);                   ","\n",
                            "  DBMS_OUTPUT.PUT_LINE(SQLERRM);                                     ","\n",
                            "END;                                                                 ","\n",              
                            "/                                                                    ","\n"                                                
                                                                                                                           
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

FUNCTION sadzi140_db_get_column_data_to_mem(p_owner,p_table_name)
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
               "                                 NVL(ATC.DATA_SCALE,'0'),                                 ",
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

{
FUNCTION sadzi140_db_get_db_column_data(p_owner,p_table_name,p_column_name)
DEFINE
  p_owner       STRING,
  p_table_name  STRING,
  p_column_name STRING
DEFINE
  lo_db_column_data T_COLUMN_DATA
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_column_name STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  lo_return T_COLUMN_DATA

  LET ls_owner       = p_owner
  LET ls_table_name  = p_table_name
  LET ls_column_name = p_column_name
  
  LET li_rec_cnt = 0

  LET ls_sql = " SELECT ATC.COLUMN_NAME                      COLUMN_NAME,                                 ",
               "        DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                                       ",
               "        ATC.NULLABLE                         NULLABLE,                                    ",
               "        DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE,  ",
               "        REPLACE(TO_CHAR(DECODE(                                                           ",
               "                ATC.DATA_TYPE,                                                            ",
               "                'NUMBER',DECODE(                                                          ",
               "                                 NVL(ATC.DATA_SCALE,'0'),                                 ",
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
               "    AND ATC.COLUMN_NAME = '",ls_column_name.toUpperCase(),"'                              ",
               "  ORDER BY 1                                                                              "
                
  PREPARE lpre_get_db_column_data FROM ls_sql
  DECLARE lcur_get_db_column_data CURSOR FOR lpre_get_db_column_data

  OPEN lcur_get_db_column_data
  FETCH lcur_get_db_column_data INTO lo_db_column_data.*
  CLOSE lcur_get_db_column_data
  
  FREE lpre_get_db_column_data
  FREE lcur_get_db_column_data  
  
  LET lo_return.* = lo_db_column_data.*
  
  RETURN lo_return.*
  
END FUNCTION 
}
 
FUNCTION sadzi140_db_get_db_column_data(p_owner,p_table_name,p_column_name)
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

  LET ls_owner       = p_owner.toUpperCase()
  LET ls_table_name  = p_table_name.toUpperCase()
  LET ls_column_name = p_column_name.toUpperCase()

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

FUNCTION sadzi140_db_get_design_column_data(p_owner,p_table_name,p_column_name)
DEFINE
  p_owner       STRING,
  p_table_name  STRING,
  p_column_name STRING
DEFINE
  lo_design_column_data T_COLUMN_DATA
DEFINE
  ls_owner       STRING,
  ls_table_name  STRING,
  ls_column_name STRING,
  ls_sql         STRING,
  ls_exec_sql    STRING,
  li_rec_cnt     INTEGER,
  ls_alter_table VARCHAR(30)
DEFINE
  lo_return T_COLUMN_DATA

  LET ls_owner       = p_owner
  LET ls_table_name  = p_table_name
  LET ls_column_name = p_column_name
  
  LET li_rec_cnt = 0

  LET ls_sql = " SELECT UPPER(EB.DZEB002)                      COLUMN_NAME,  ",
               "        EB.DZEB004                             ISKEY,        ",
               "        DECODE(EB.DZEB004,'Y','N','N','Y','Y') NULLABLE,     ",
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
               "        TRIM(EB.DZEB012)                       DEFAULT_VALUE ",
               "   FROM DZEB_T EB                                            ",
               "        LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006 ",
               "  WHERE EB.DZEB001 = '",ls_table_name.toLowerCase(),"'       ",
               "    AND EB.DZEB002 = '",ls_column_name.toLowerCase(),"'      ",
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

FUNCTION sadzi140_db_update_module_code(p_table_name,p_module,p_dgenv)
DEFINE
  p_table_name STRING,
  p_module     STRING,
  p_dgenv      STRING
DEFINE
  ls_table_name    STRING,
  ls_module        STRING,
  ls_dgenv         STRING,
  ls_exec_sql      STRING

  LET ls_table_name = p_table_name
  LET ls_module     = p_module
  LET ls_dgenv      = p_dgenv

  LET ls_exec_sql = " UPDATE DZEA_T EA                                      ",
                    "    SET EA.DZEA003 = '",ls_module.toUpperCase(),"',    ",
                    "        EA.DZEA015 = '",ls_dgenv.toLowerCase(),"'      ",    
                    "  WHERE EA.DZEA001 = '",ls_table_name.toLowerCase(),"' "
                    
  CALL sadzi140_db_exec_SQL(ls_exec_sql,TRUE)                      
  
END FUNCTION 

#檢核欄位是否有客制資料
FUNCTION sadzi140_db_check_column_if_customize(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  ls_table_name STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  lb_return     BOOLEAN

  LET ls_table_name = p_table_name.toLowerCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1) CNTS                         ",
               "  FROM DZEB_T EB                             ",
               " WHERE EB.DZEB001 = '",ls_table_name,"'      ", 
               "   AND EB.DZEB029 = '",cs_dgenv_customize,"' " 
                
  PREPARE lpre_check_column_if_customize FROM ls_sql
  DECLARE lcur_check_column_if_customize CURSOR FOR lpre_check_column_if_customize
  OPEN lcur_check_column_if_customize
  FETCH lcur_check_column_if_customize INTO li_rec_count
  CLOSE lcur_check_column_if_customize
  FREE lcur_check_column_if_customize
  FREE lpre_check_column_if_customize

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

#檢核Key是否有客制資料
FUNCTION sadzi140_db_check_key_if_customize(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  ls_table_name STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  lb_return     BOOLEAN

  LET ls_table_name = p_table_name.toLowerCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1) CNTS                         ",
               "  FROM DZED_T ED                             ",
               " WHERE ED.DZED001 = '",ls_table_name,"'      ", 
               "   AND ED.DZED008 = '",cs_dgenv_customize,"' " 
                
  PREPARE lpre_check_key_if_customize FROM ls_sql
  DECLARE lcur_check_key_if_customize CURSOR FOR lpre_check_key_if_customize
  OPEN lcur_check_key_if_customize
  FETCH lcur_check_key_if_customize INTO li_rec_count
  CLOSE lcur_check_key_if_customize
  FREE lcur_check_key_if_customize
  FREE lpre_check_key_if_customize

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_db_check_index_if_customize(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  ls_table_name STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  lb_return     BOOLEAN

  LET ls_table_name = p_table_name.toLowerCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1) CNTS                         ",
               "  FROM DZEC_T EC                             ",
               " WHERE EC.DZEC001 = '",ls_table_name,"'      ", 
               "   AND EC.DZEC006 = '",cs_dgenv_customize,"' " 
                
  PREPARE lpre_check_index_if_customize FROM ls_sql
  DECLARE lcur_check_index_if_customize CURSOR FOR lpre_check_index_if_customize
  OPEN lcur_check_index_if_customize
  FETCH lcur_check_index_if_customize INTO li_rec_count
  CLOSE lcur_check_index_if_customize
  FREE lcur_check_index_if_customize
  FREE lpre_check_index_if_customize

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_db_grant_APS_privilege(p_db_connstr,p_master_db)
DEFINE 
  p_db_connstr  T_DB_CONNSTR,
  p_master_db   STRING
DEFINE 
  lo_db_connstr  T_DB_CONNSTR,
  ls_master_db   STRING,
  ls_message     STRING,
  ls_separator   STRING

  LET lo_db_connstr.* = p_db_connstr.*
  LET ls_master_db    = p_master_db

  LET ls_separator = os.Path.separator()
  
  #呼叫產生 Grant 的SQL
  LET lo_db_connstr.db_sql_filename = FGL_GETENV("APSE"),ls_separator,"script",ls_separator,"dsgrant.sql"
  IF os.Path.exists(lo_db_connstr.db_sql_filename) THEN 
    DISPLAY cs_information_tag," Grant ",lo_db_connstr.db_username," privileges for APS system."
    CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
  ELSE
    DISPLAY cs_warning_tag,"Can not find the APSE script file for ",lo_db_connstr.db_username," !!"
  END IF  
  #DISPLAY ls_message
  
END FUNCTION

FUNCTION sadzi140_db_update_column_name(p_table_name,p_old_col_name,p_new_col_name)
DEFINE
  p_table_name   STRING,
  p_old_col_name STRING,
  p_new_col_name STRING
DEFINE
  ls_table_name   STRING,
  ls_old_col_name STRING,
  ls_new_col_name STRING,
  ls_exec_sql     STRING

  LET ls_table_name   = p_table_name.toLowerCase()
  LET ls_old_col_name = p_old_col_name.toLowerCase()
  LET ls_new_col_name = p_new_col_name.toLowerCase()

  LET ls_exec_sql = " UPDATE DZEB_T EB                         ",
                    "    SET EB.DZEB002 = '",ls_new_col_name,"'",
                    "  WHERE EB.DZEB001 = '",ls_table_name,"'  ",
                    "    AND EB.DZEB002 = '",ls_old_col_name,"'"
                    
  CALL sadzi140_db_exec_SQL(ls_exec_sql,FALSE)
  
END FUNCTION 

FUNCTION sadzi140_db_get_rebuild_index_list(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  ls_table_name   STRING,
  ls_sql          STRING,
  li_rec_count    INTEGER,
  ls_rebuild_list STRING,
  ls_rebuild_sql  VARCHAR(1024),
  ls_rebuild      STRING
DEFINE
  ls_return STRING
  
  LET ls_table_name = p_table_name
  
  LET li_rec_count = 0
  LET ls_rebuild_list = ""

  #取得 Rebuild Index 清單
  &ifndef DEBUG
    LET ls_rebuild = "'ALTER INDEX '||EC.DZEC002||' REBUILD'"
  &else
    LET ls_rebuild = "'ALTER INDEX '||EC.DZEC002||' REBUILD'"
  &endif
  
  LET ls_sql = "SELECT ",ls_rebuild," REBUILD_SQL                                ",
               "  FROM DZEC_T EC                                                 ",
               " WHERE EXISTS (                                                  ",
               "                SELECT 1                                         ",
               "                  FROM USER_INDEXES UIS                          ",
               "                 WHERE UIS.INDEX_NAME = UPPER(EC.DZEC002)        ",
               "                   AND UIS.TABLE_NAME = UPPER(EC.DZEC001)        ",
               "                   AND UIS.TABLE_OWNER = (SELECT USER FROM DUAL) ",
               "              )                                                  ",
               "   AND EC.DZEC001 = '",ls_table_name,"'                          "
                                                                                 
  PREPARE lpre_get_rebuild_index_list FROM ls_sql                                
  DECLARE lcur_get_rebuild_index_list CURSOR FOR lpre_get_rebuild_index_list
  
  OPEN lcur_get_rebuild_index_list
  FOREACH lcur_get_rebuild_index_list INTO ls_rebuild_sql
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

    LET ls_rebuild_list = ls_rebuild_list,ls_rebuild_sql,";","\n"
    
  END FOREACH
  CLOSE lcur_get_rebuild_index_list
  
  FREE lcur_get_rebuild_index_list
  FREE lpre_get_rebuild_index_list

  LET ls_return = ls_rebuild_list
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_get_column_type_data_type(p_column_type)
DEFINE
  p_column_type  STRING
DEFINE
  ls_column_type STRING,
  ls_sql         STRING,
  lo_data_type   T_DATA_TYPE
DEFINE  
  lo_return      T_DATA_TYPE

  LET ls_column_type = p_column_type

  #取得Data Type 相關資訊
  LET ls_sql = "SELECT TDM.GZTD003                                     DT_TYPE,                                                 ",
               "       TDM.GZTD008                                     DT_LENGTH,                                               ",
               "       TDM.DT_INTEGER                                  DT_INTEGER,                                              ",
               "       TDM.DT_DECIMAL                                  DT_DECIMAL,                                              ",
               "       (NVL(TDM.DT_INTEGER,0) - NVL(TDM.DT_DECIMAL,0)) DT_PDECIMAL                                              ",
               "  FROM (                                                                                                        ",
               "        SELECT TDX.GZTD003                                                                         GZTD003,     ",
               "               TDX.GZTD008                                                                         GZTD008,     ",
               "               DECODE(TDX.COMMA_POS,0,TDX.GZTD008,SUBSTRB(TDX.GZTD008,1,TDX.COMMA_POS-1))          DT_INTEGER,  ",
               "               DECODE(TDX.COMMA_POS,0,0,SUBSTRB(TDX.GZTD008,TDX.COMMA_POS+1,LENGTHB(TDX.GZTD008))) DT_DECIMAL   ",
               "          FROM (                                                                                                ",
               "                SELECT TD.GZTD003                                                     GZTD003,                  ",
               "                       REPLACE(REPLACE(TD.GZTD008,' ',''),'.',',')                    GZTD008,                  ",
               "                       NVL(INSTRB(REPLACE(REPLACE(TD.GZTD008,' ',''),'.',','),','),0) COMMA_POS                 ",
               "                  FROM GZTD_T TD                                                                                ",
               "                 WHERE TD.GZTD001 = '",ls_column_type.TRIM(),"'                                                 ",
               "               ) TDX                                                                                            ",
               "       ) TDM                                                                                                    " 
                
  PREPARE lpre_get_data_type FROM ls_sql
  DECLARE lcur_get_data_type CURSOR FOR lpre_get_data_type
  OPEN lcur_get_data_type
  FETCH lcur_get_data_type INTO lo_data_type.*
  CLOSE lcur_get_data_type
  FREE lcur_get_data_type
  FREE lpre_get_data_type

  LET lo_return.* = lo_data_type.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi140_db_column_type_validation(p_new_column_type,p_old_column_type)
DEFINE
  p_new_column_type STRING,
  p_old_column_type STRING
DEFINE
  ls_new_column_type STRING,
  ls_old_column_type STRING,
  lo_new_data_type   T_DATA_TYPE,
  lo_old_data_type   T_DATA_TYPE
DEFINE
  lb_return BOOLEAN

  LET lb_return = TRUE  

  LET ls_new_column_type = p_new_column_type.trim()
  LET ls_old_column_type = p_old_column_type.trim()

  #先取得兩者的資料型態
  CALL sadzi140_db_get_column_type_data_type(ls_new_column_type) RETURNING lo_new_data_type.*
  CALL sadzi140_db_get_column_type_data_type(ls_old_column_type) RETURNING lo_old_data_type.*

  #新舊資料型態不符時, 則出局
  IF (lo_new_data_type.DT_TYPE <> lo_old_data_type.DT_TYPE) THEN
    LET lb_return = FALSE  
    GOTO _OUT
  END IF 

  #減去小數後的兩者整數比對, 新的比舊的小, 則出局
  IF (lo_new_data_type.DT_PINTEGER < lo_old_data_type.DT_PINTEGER) THEN
    LET lb_return = FALSE   
    GOTO _OUT
  END IF   

  #兩者小數比對, 新的比舊的小, 則出局
  IF (lo_new_data_type.DT_DECIMAL < lo_old_data_type.DT_DECIMAL) THEN
    LET lb_return = FALSE  
    GOTO _OUT
  END IF
  
  LABEL _OUT:

  RETURN lb_return
 
END FUNCTION

FUNCTION sadzi140_db_get_key_null_default_value_list(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  ls_table_name   STRING,
  ls_sql          STRING,
  li_rec_count    INTEGER,
  ls_default_list STRING,
  ls_default_sql  VARCHAR(1024),
  ls_default      STRING
DEFINE
  ls_return STRING
  
  LET ls_table_name = p_table_name.toLowerCase()
  
  LET li_rec_count = 0
  LET ls_default_list = ""

  #抓DZIG_T的賦予值, 沒有的話抓預設賦予值
  LET ls_sql = "SELECT 'update '||EB.DZEB001||' set '||EB.DZEB002||' = '||IG.DZIG003||' where '||EB.DZEB002||' is null' usql ",
               "  FROM DZEB_T EB                                                                                             ",
               " INNER JOIN DZIG_T IG ON IG.DZIG001 = EB.DZEB001                                                             ",
               "                     AND IG.DZIG002 = EB.DZEB002                                                             ",
               " WHERE 1=1                                                                                                   ",
               "   AND EB.DZEB001 = '",ls_table_name,"'                                                                      ",
               "   AND EB.DZEB004 = 'Y'                                                                                      ",
               "UNION ALL                                                                                                    ",
               "SELECT 'update '||EB.DZEB001||' set '||EB.DZEB002||' = '||EJ.DZEJ005||' where '||EB.DZEB002||' is null' usql ",
               "  FROM DZEB_T EB                                                                                             ",
               "  LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006                                                       ",
               "  LEFT OUTER JOIN DZEJ_T EJ ON EJ.DZEJ001 = 'adzi140_parameters'                                             ",
               "                           AND EJ.DZEJ003 = 'PatchKeyValue'                                                  ",
               "                           AND TD.GZTD003 = LOWER(EJ.DZEJ004)                                                ",
               " WHERE 1=1                                                                                                   ",
               "   AND EB.DZEB001 = '",ls_table_name,"'                                                                      ",
               "   AND EB.DZEB004 = 'Y'                                                                                      ",
               "   AND NOT EXISTS (                                                                                          ",
               "                    SELECT 1                                                                                 ",
               "                      FROM DZIG_T IG                                                                         ",
               "                     WHERE IG.DZIG001 = EB.DZEB001                                                           ",
               "                       AND IG.DZIG002 = EB.DZEB002                                                           ",
               "                  )                                                                                          "
               
  PREPARE lpre_get_key_null_default_value_list FROM ls_sql                                
  DECLARE lcur_get_key_null_default_value_list CURSOR FOR lpre_get_key_null_default_value_list
  
  OPEN lcur_get_key_null_default_value_list
  FOREACH lcur_get_key_null_default_value_list INTO ls_default_sql
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

    LET ls_default_list = ls_default_list,ls_default_sql,";","\n"
    
  END FOREACH
  CLOSE lcur_get_key_null_default_value_list
  
  FREE lcur_get_key_null_default_value_list
  FREE lpre_get_key_null_default_value_list

  LET ls_return = ls_default_list
  
  RETURN ls_return
  
END FUNCTION

{
FUNCTION sadzi140_db_alter_optimizer_feature()
DEFINE
  ls_db_version STRING,
  ls_exec_sql   STRING

  CALL sadzi140_db_get_parameter(cs_param_level_session,cs_param_optimizer_features_enable) RETURNING ls_db_version
  LET ls_db_version = NVL(ls_db_version,cs_default_optimizer_features_enable)
  DISPLAY cs_information_tag,"Optimizer feature version set to : ",ls_db_version

  LET ls_exec_sql = "ALTER SESSION SET OPTIMIZER_FEATURES_ENABLE='",ls_db_version,"'"
                   
  CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,FALSE)
  
END FUNCTION 
}

FUNCTION sadzi140_db_grant_object_privileges(p_object,p_privilege_info)
DEFINE
  p_object          STRING,
  p_privilege_info  T_PRIVILEGE_INFO
DEFINE
  ls_object         STRING,
  lo_privilege_info T_PRIVILEGE_INFO,
  ls_privileges     STRING,
  ls_sql            STRING
DEFINE
  ls_return STRING
  
  LET ls_object           = p_object
  LET lo_privilege_info.* = p_privilege_info.*

  LET ls_privileges = ""

  #判斷有"Y"的就取用
  IF lo_privilege_info.pi_SELECT = "Y" THEN
    LET ls_privileges = ls_privileges,cs_privilege_select,"," 
  END IF
  IF lo_privilege_info.pi_INSERT = "Y" THEN
    LET ls_privileges = ls_privileges,cs_privilege_insert,"," 
  END IF
  IF lo_privilege_info.pi_UPDATE = "Y" THEN
    LET ls_privileges = ls_privileges,cs_privilege_update,"," 
  END IF
  IF lo_privilege_info.pi_DELETE = "Y" THEN
    LET ls_privileges = ls_privileges,cs_privilege_delete,"," 
  END IF
  IF lo_privilege_info.pi_REFERENCES = "Y" THEN
    LET ls_privileges = ls_privileges,cs_privilege_references,"," 
  END IF
  IF lo_privilege_info.pi_ALTER = "Y" THEN
    LET ls_privileges = ls_privileges,cs_privilege_alter,"," 
  END IF
  IF lo_privilege_info.pi_INDEX = "Y" THEN
    LET ls_privileges = ls_privileges,cs_privilege_index,"," 
  END IF

  #將最後一個逗號捨棄
  LET ls_privileges = ls_privileges.subString(1,ls_privileges.getLength()-1)
  
  LET ls_sql = "GRANT ",ls_privileges," ON ",ls_object," TO ",lo_privilege_info.pi_ACCEPTER,";","\n"

  LET ls_return = ls_sql
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_revoke_object_privileges(p_object,p_privilege,p_user)
DEFINE
  p_object    STRING,
  p_privilege STRING,
  p_user      STRING
DEFINE
  ls_object    STRING,
  ls_privilege STRING,
  ls_user      STRING,
  ls_sql       STRING
DEFINE
  ls_return STRING
  
  LET ls_object    = p_object
  LET ls_privilege = NVL(p_privilege,cs_privilege_all)
  LET ls_user      = p_user

  LET ls_sql = "REVOKE ",ls_privilege," ON ",ls_object," FROM ",ls_user,";","\n"

  LET ls_return = ls_sql
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_get_privilege_granter(p_object)
DEFINE
  p_object STRING
DEFINE
  ls_object  STRING,
  li_rec_cnt INTEGER,
  ls_sql     STRING,
  lo_privilege_granter DYNAMIC ARRAY OF T_PRIVILEGE_GRANTER 
DEFINE
  lo_return DYNAMIC ARRAY OF T_PRIVILEGE_GRANTER 

  LET ls_object = p_object.toLowerCase()

  LET li_rec_cnt = 1

  LET ls_sql = "SELECT LOWER(DTP.OWNER) DZEN002                       ",
               "  FROM DBA_TAB_PRIVS DTP                              ",                                   
               " WHERE DTP.TABLE_NAME = '",ls_object.toUpperCase(),"' ",          
               "   AND DTP.GRANTEE <> 'TIPTOP'                        ",                                   
               " GROUP BY DTP.OWNER,DTP.GRANTEE                       ",                                   
               "UNION                                                 ",
               "SELECT EN.DZEN002                                     ", 
               "  FROM DZEN_T EN                                      ", 
               " WHERE EN.DZEN001 = '",ls_object.toLowerCase(),"'     ",
               " GROUP BY EN.DZEN002                                  ", 
               " ORDER BY 1                                           "
 
  PREPARE lpre_get_privilege_granter FROM ls_sql
  DECLARE lcur_get_privilege_granter CURSOR FOR lpre_get_privilege_granter

  OPEN lcur_get_privilege_granter
  FOREACH lcur_get_privilege_granter INTO lo_privilege_granter[li_rec_cnt]
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET li_rec_cnt = li_rec_cnt + 1
    
  END FOREACH
  CLOSE lcur_get_privilege_granter
  
  CALL lo_privilege_granter.deleteElement(li_rec_cnt)
  
  FREE lpre_get_privilege_granter
  FREE lcur_get_privilege_granter    

  LET lo_return = lo_privilege_granter

  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi140_db_get_privilege_granter_from_diff(p_privilege_diff)
DEFINE
  p_privilege_diff  DYNAMIC ARRAY OF T_PRIVILEGE_DIFF
DEFINE
  lo_privilege_diff    DYNAMIC ARRAY OF T_PRIVILEGE_DIFF,
  lo_privilege_granter DYNAMIC ARRAY OF T_PRIVILEGE_GRANTER,
  li_diff              INTEGER,  
  li_loop              INTEGER,
  lb_exist             BOOLEAN, 
  ls_object            STRING,
  li_rec_cnt           INTEGER,
  ls_sql               STRING
DEFINE
  lo_return  DYNAMIC ARRAY OF T_PRIVILEGE_GRANTER 

  LET lo_privilege_diff = p_privilege_diff

  LET li_rec_cnt = 1
  CALL lo_privilege_granter.clear()

  #從差異清單中抓取不重複的賦予權限者
  FOR li_diff = 1 TO lo_privilege_diff.getLength()
    LET lb_exist = FALSE
    #找到有重複則離開
    FOR li_loop = 1 TO lo_privilege_granter.getLength()
      IF lo_privilege_granter[li_loop] = lo_privilege_diff[li_diff].DZEN002 THEN
        LET lb_exist = TRUE
        EXIT FOR
      END IF 
    END FOR
    #不重複則加入清單
    IF NOT lb_exist THEN
      LET lo_privilege_granter[lo_privilege_granter.getLength() + 1] = lo_privilege_diff[li_diff].DZEN002
    END IF
  END FOR 

  LET lo_return = lo_privilege_granter

  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi140_db_get_privilege_info(p_object,p_granter)
DEFINE
  p_object  STRING,
  p_granter STRING
DEFINE
  ls_object  STRING,
  ls_granter STRING,
  li_rec_cnt INTEGER,
  ls_sql     STRING,
  lo_privilege_info DYNAMIC ARRAY OF T_PRIVILEGE_INFO 
DEFINE
  lo_return DYNAMIC ARRAY OF T_PRIVILEGE_INFO 

  LET ls_object  = p_object.toLowerCase()
  LET ls_granter = p_granter

  LET li_rec_cnt = 1

  LET ls_sql = "SELECT EN.DZEN002,EN.DZEN003,EN.DZEN004,EN.DZEN005,EN.DZEN006, ",
               "       EN.DZEN007,EN.DZEN008,EN.DZEN009,EN.DZEN010             ",
               "  FROM DZEN_T EN                                               ",
               " WHERE EN.DZEN001 = '",ls_object,"'                            ",
               "   AND EN.DZEN002 = '",ls_granter,"'                           ",
               " ORDER BY EN.DZEN003                                           "
 
  PREPARE lpre_get_privilege_info FROM ls_sql
  DECLARE lcur_get_privilege_info CURSOR FOR lpre_get_privilege_info

  OPEN lcur_get_privilege_info
  FOREACH lcur_get_privilege_info INTO lo_privilege_info[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET li_rec_cnt = li_rec_cnt + 1
    
  END FOREACH
  CLOSE lcur_get_privilege_info
  
  CALL lo_privilege_info.deleteElement(li_rec_cnt)
  
  FREE lpre_get_privilege_info
  FREE lcur_get_privilege_info    

  LET lo_return = lo_privilege_info

  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi140_db_refresh_privilege_info(p_PRIVILEGE_DIFF)
DEFINE
  p_PRIVILEGE_DIFF T_PRIVILEGE_DIFF
DEFINE
  lo_privilege_diff T_PRIVILEGE_DIFF,
  lo_privilege_info T_PRIVILEGE_INFO 
DEFINE
  lo_return T_PRIVILEGE_INFO 
  
  LET lo_PRIVILEGE_DIFF.* = p_PRIVILEGE_DIFF.*

  LET lo_privilege_info.pi_GRANTER    = lo_privilege_diff.DZEN002
  LET lo_privilege_info.pi_ACCEPTER   = lo_privilege_diff.DZEN003
  LET lo_privilege_info.pi_SELECT     = lo_privilege_diff.DZEN004
  LET lo_privilege_info.pi_INSERT     = lo_privilege_diff.DZEN005
  LET lo_privilege_info.pi_UPDATE     = lo_privilege_diff.DZEN006
  LET lo_privilege_info.pi_DELETE     = lo_privilege_diff.DZEN007
  LET lo_privilege_info.pi_REFERENCES = lo_privilege_diff.DZEN008
  LET lo_privilege_info.pi_ALTER      = lo_privilege_diff.DZEN009
  LET lo_privilege_info.pi_INDEX      = lo_privilege_diff.DZEN010
  
  LET lo_return.* = lo_privilege_info.*

  RETURN lo_return.*
  
END FUNCTION 

FUNCTION sadzi140_db_get_effect_table_list(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  ls_table_name  STRING,
  li_rec_cnt INTEGER,
  ls_sql     STRING,
  lv_effect_table VARCHAR(1024), 
  ls_effect_table STRING 
DEFINE
  ls_return STRING

  LET ls_table_name  = p_table_name.toLowerCase()

  LET li_rec_cnt = 1
  LET ls_effect_table = ""

  LET ls_sql = "SELECT DISTINCT ED.DZED001||'-'||EAL.DZEAL003 EFFECT_TABLE ",
               "  FROM DZED_T ED                                           ",
               "  LEFT OUTER JOIN DZEAL_T EAL ON EAL.DZEAL001 = ED.DZED001 ",
               "                             AND EAL.DZEAL002 = 'zh_TW'    ",
               " WHERE DZED005 = '",ls_table_name.toLowerCase(),"'         ",
               " ORDER BY 1                                                " 
  
  PREPARE lpre_get_effect_table_list FROM ls_sql
  DECLARE lcur_get_effect_table_list CURSOR FOR lpre_get_effect_table_list

  OPEN lcur_get_effect_table_list
  FOREACH lcur_get_effect_table_list INTO lv_effect_table
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET li_rec_cnt = li_rec_cnt + 1
    LET ls_effect_table = ls_effect_table,",",lv_effect_table,"\n"
    
  END FOREACH
  CLOSE lcur_get_effect_table_list
  
  FREE lpre_get_effect_table_list
  FREE lcur_get_effect_table_list    

  IF NVL(ls_effect_table.trim(),cs_null_value) <> cs_null_value THEN 
    LET ls_return = "\n","\n",ls_effect_table.subString(2,ls_effect_table.getLength())
  ELSE
    LET ls_return = ""
  END IF 

  RETURN ls_return
  
END FUNCTION 

FUNCTION sadzi140_db_get_db_schema_list()
DEFINE
  ls_sql         STRING,
  li_counts      INTEGER,
  lo_schema_list DYNAMIC ARRAY OF T_STATIC_DB_SCHEMA
DEFINE
  lo_return  DYNAMIC ARRAY OF T_STATIC_DB_SCHEMA

  LET li_counts = 1
  
  LET ls_sql = "SELECT DA.GZDA001        ",
               "  FROM GZDA_T DA         ",
               " WHERE 1=1               ",
               "   AND DA.GZDA005  = 'Y' ", 
               "   AND DA.GZDASTUS = 'Y' ",
               " ORDER BY DA.GZDA001     "
               
  PREPARE lpre_get_db_schema_list FROM ls_sql
  DECLARE lcur_get_db_schema_list CURSOR FOR lpre_get_db_schema_list

  OPEN lcur_get_db_schema_list
  FOREACH lcur_get_db_schema_list INTO lo_schema_list[li_counts].sds_DB_NAME
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_db_schema_list

  CALL lo_schema_list.deleteElement(li_counts)
  
  FREE lpre_get_db_schema_list
  FREE lcur_get_db_schema_list

  LET lo_return = lo_schema_list
  
  RETURN lo_return

END FUNCTION

FUNCTION sadzi140_db_get_static_db_list()
DEFINE
  li_length           INTEGER,
  ls_static_db        STRING,
  ls_static_db_char   STRING,
  ls_static_db_string STRING,
  lo_static_db_list   DYNAMIC ARRAY OF T_STATIC_DB_SCHEMA
DEFINE
  lo_return DYNAMIC ARRAY OF T_STATIC_DB_SCHEMA

  CALL lo_static_db_list.clear()

  #取得當地語系清單
  CALL sadzi140_db_get_parameter(cs_param_level_system,cs_param_essential_schemas) RETURNING ls_static_db
  
  IF ls_static_db.trim() IS NOT NULL THEN 
    FOR li_length = 1 TO ls_static_db.getLength()
      LET ls_static_db_char = ls_static_db.subString(li_length,li_length)
      IF ls_static_db_char = "," THEN 
        LET lo_static_db_list[lo_static_db_list.getLength() + 1].sds_DB_NAME = ls_static_db_string
        LET ls_static_db_string = ""
      ELSE
        LET ls_static_db_string = ls_static_db_string,ls_static_db_char 
      END IF
    END FOR
  ELSE
    #抓不到給預設值
    LET lo_static_db_list[1].sds_DB_NAME = 'ds'
    LET lo_static_db_list[2].sds_DB_NAME = 'dsdemo'
    LET lo_static_db_list[3].sds_DB_NAME = 'dsdata'
  END IF

  LET lo_return = lo_static_db_list

  RETURN lo_return  
    
END FUNCTION 

FUNCTION sadzi140_db_check_complete_of_db_data()
DEFINE
  lo_static_db_list DYNAMIC ARRAY OF T_STATIC_DB_SCHEMA,
  lo_db_data_list   DYNAMIC ARRAY OF T_STATIC_DB_SCHEMA,
  li_static         INTEGER,
  li_db_data        INTEGER,
  lb_total_result   BOOLEAN,
  ls_total_result   STRING,
  lb_result         BOOLEAN
DEFINE
  ls_return  STRING,
  lb_return  BOOLEAN

  CALL sadzi140_db_get_static_db_list() RETURNING lo_static_db_list
  CALL sadzi140_db_get_db_schema_list() RETURNING lo_db_data_list

  LET lb_total_result = TRUE
  LET ls_total_result = ""
  
  #抓出在資料庫設定中是否 ds,dsdemo,dsdata 有設定
  FOR li_static = 1 TO lo_static_db_list.getLength()
    LET lb_result = FALSE
    FOR li_db_data = 1 TO lo_db_data_list.getLength()
      IF lo_static_db_list[li_static].sds_DB_NAME = lo_db_data_list[li_db_data].sds_DB_NAME THEN 
        LET lb_result = TRUE
        EXIT FOR
      END IF
    END FOR
    IF NOT lb_result THEN
      LET lb_total_result = FALSE
      LET ls_total_result = ls_total_result,lo_static_db_list[li_static].sds_DB_NAME,","
    END IF
  END FOR 
  
  LET lb_return = lb_total_result
  LET ls_return = "\n",ls_total_result.subString(1,ls_total_result.getLength()-1)
  
  RETURN lb_return,ls_return 
  
END FUNCTION

#20160616 begin
FUNCTION sadzi140_db_check_index_length_if_exceed(p_DZEB_T,p_column_list)
DEFINE
  p_DZEB_T      DYNAMIC ARRAY OF T_DZEB_T,
  p_column_list DYNAMIC ARRAY OF T_COLUMN_LIST
DEFINE
  lo_DZEB_T           DYNAMIC ARRAY OF T_DZEB_T,
  lo_column_list      DYNAMIC ARRAY OF T_COLUMN_LIST,
  li_index_max_length INTEGER,
  li_loop             INTEGER,
  li_loop2            INTEGER,
  li_type_size        INTEGER,
  li_all_type_size    INTEGER
DEFINE
  lo_return  T_KEY_IF_EXCEED

  LET lo_DZEB_T = p_DZEB_T
  LET lo_column_list = p_column_list

  LET li_type_size = 0
  LET li_all_type_size = 0
  
  CALL sadzi140_db_get_oracle_key_max_length() RETURNING li_index_max_length

  FOR li_loop = 1 TO lo_column_list.getLength()
    FOR li_loop2 = 1 TO lo_DZEB_T.getLength()
      IF lo_DZEB_T[li_loop2].dzeb002 = lo_column_list[li_loop].COLUMN_NAME THEN 
        CALL sadzi140_db_get_oracle_column_data_type_size(lo_DZEB_T[li_loop2].*) RETURNING li_type_size
        LET li_all_type_size = li_all_type_size + li_type_size
        EXIT FOR
      END IF 
    END FOR
  END FOR  

  LET lo_return.kie_sys_def = li_index_max_length
  LET lo_return.kie_user_def = li_all_type_size
  
  IF li_all_type_size >= li_index_max_length THEN
    LET lo_return.kie_result = TRUE
  ELSE 
    LET lo_return.kie_result = FALSE
  END IF 
  
  RETURN lo_return.*
  
END FUNCTION 

FUNCTION sadzi140_db_check_key_length_if_exceed(p_DZEB_T)
DEFINE
  p_DZEB_T  DYNAMIC ARRAY OF T_DZEB_T
DEFINE
  lo_DZEB_T         DYNAMIC ARRAY OF T_DZEB_T,
  li_key_max_length INTEGER,
  li_loop           INTEGER,
  li_type_size      INTEGER,
  li_all_type_size  INTEGER
DEFINE
  lo_return  T_KEY_IF_EXCEED

  LET lo_DZEB_T = p_DZEB_T

  LET li_type_size = 0
  LET li_all_type_size = 0
  
  CALL sadzi140_db_get_oracle_key_max_length() RETURNING li_key_max_length

  FOR li_loop = 1 TO lo_DZEB_T.getLength()
    IF NVL(lo_DZEB_T[li_loop].dzeb004,"N") = "Y" THEN 
      CALL sadzi140_db_get_oracle_column_data_type_size(lo_DZEB_T[li_loop].*) RETURNING li_type_size
      LET li_all_type_size = li_all_type_size + li_type_size
    END IF 
  END FOR 

  LET lo_return.kie_sys_def = li_key_max_length
  LET lo_return.kie_user_def = li_all_type_size
  
  IF li_all_type_size >= li_key_max_length THEN
    LET lo_return.kie_result = TRUE
  ELSE 
    LET lo_return.kie_result = FALSE
  END IF 
  
  RETURN lo_return.*
  
END FUNCTION 

FUNCTION sadzi140_db_get_oracle_key_max_length()
DEFINE
  ls_sql            STRING,
  li_block_size     INTEGER,
  li_key_max_length INTEGER
DEFINE  
  li_return  INTEGER

  #取得DB Block Size
  LET ls_sql = "SELECT VALUE BLOCK_SIZE       ",
               "  FROM V$PARAMETER            ",
               " WHERE NAME = 'db_block_size' "
                 
  PREPARE lpre_get_oracle_key_max_length FROM ls_sql
  DECLARE lcur_get_oracle_key_max_length CURSOR FOR lpre_get_oracle_key_max_length
  OPEN lcur_get_oracle_key_max_length
  FETCH lcur_get_oracle_key_max_length INTO li_block_size
  CLOSE lcur_get_oracle_key_max_length
  FREE lcur_get_oracle_key_max_length
  FREE lpre_get_oracle_key_max_length

  #Formula reference to http://blog.csdn.net/yidian815/article/details/16336911
  LET li_key_max_length = (NVL(li_block_size,0) - 192) * 0.8
  
  LET li_return = li_key_max_length
  
  RETURN li_return
  
END FUNCTION

FUNCTION sadzi140_db_get_oracle_column_data_type_size(p_DZEB_T)
DEFINE
  p_DZEB_T  T_DZEB_T
DEFINE
  lo_DZEB_T      T_DZEB_T,
  ls_data_type   STRING,
  li_type_size   INTEGER,
  li_define_size INTEGER
DEFINE
  li_return INTEGER
  
  LET lo_DZEB_T.* = p_DZEB_T.*
  LET ls_data_type = UPSHIFT(lo_DZEB_T.dzeb007)

  LET li_type_size = 0
  
  #Size reference to https://docs.oracle.com/cd/B28359_01/appdev.111/b28395/oci03typ.htm
  CASE
    WHEN ls_data_type = "BLOB"
      LET li_type_size = 99999
    WHEN ls_data_type = "CLOB"
      LET li_type_size = 99999
    WHEN ls_data_type = "DATE"
      LET li_type_size = 7
    WHEN ls_data_type = "NUMBER"
      LET li_type_size = 21 
    WHEN ls_data_type = "TIMESTAMP"
      LET li_define_size = NVL(lo_DZEB_T.dzeb008,0)
      LET li_type_size = IIF(li_define_size > 0,13,11)
    WHEN ls_data_type = "VARCHAR2"
      LET li_type_size = NVL(lo_DZEB_T.dzeb008,0)
  OTHERWISE 
    LET li_type_size = 99999
  END CASE  
  
  LET li_return = li_type_size
  
  RETURN li_return
    
END FUNCTION
#20160616 end

#20161220 begin
FUNCTION sadzi140_db_get_comment_columns_scripts(p_column_comments)
DEFINE
  p_column_comments T_COMMENT_COLUMNS
DEFINE
  lo_column_comments T_COMMENT_COLUMNS,
  ls_scripts STRING
DEFINE
  ls_return STRING

  LET lo_column_comments.* = p_column_comments.*
  
  LET ls_scripts = "DECLARE                                                                      ","\n",
                   "  ls_exe_sql VARCHAR2(1000);                                                 ","\n",
                   "BEGIN                                                                        ","\n",
                   "                                                                             ","\n",
                   "  ls_exe_sql := 'COMMENT ON COLUMN ",
                                     UPSHIFT(lo_column_comments.CC_OWNER),".",
                                     UPSHIFT(lo_column_comments.CC_TABLE_NAME),".",
                                     UPSHIFT(lo_column_comments.CC_COLUMN_NAME),
                                     " IS ''",
                                     UPSHIFT(lo_column_comments.CC_COLUMN_NAME),"'''; ","\n",
                   "                                                                             ","\n",
                   "  BEGIN                                                                      ","\n",
                   "    EXECUTE IMMEDIATE ls_exe_sql;                                            ","\n",
                   "    DBMS_OUTPUT.PUT_LINE('",cs_success_tag,"'||ls_exe_sql||', '||SQLERRM);   ","\n",
                   "  EXCEPTION                                                                  ","\n",
                   "    WHEN OTHERS THEN                                                         ","\n",
                   "      DBMS_OUTPUT.PUT_LINE('",cs_warning_tag,"'||ls_exe_sql||', '||SQLERRM); ","\n",
                   "  END;                                                                       ","\n",
                   "                                                                             ","\n",
                   "END;                                                                         ","\n",
                   "/                                                                            ","\n"

  LET ls_return = ls_scripts

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_db_get_toggle_comment_columns(p_db_user_name,p_table_name)
DEFINE
  p_db_user_name STRING,
  p_table_name   STRING 
DEFINE
  ls_db_user_name STRING,
  ls_table_name   STRING,
  li_rec_cnt      INTEGER,
  ls_sql          STRING,
  lo_comment_columns  DYNAMIC ARRAY OF T_COMMENT_COLUMNS
DEFINE
  lo_return  DYNAMIC ARRAY OF T_COMMENT_COLUMNS

  LET ls_db_user_name = p_db_user_name
  LET ls_table_name   = p_table_name

  LET li_rec_cnt = 1
  
  LET ls_sql = "SELECT UPPER('",ls_db_user_name,"')  OWNER,                                       ",
               "       UPPER(EB.DZEB001)             TABLE_NAME,                                  ",
               "       UPPER(EB.DZEB002)             COLUMN_NAME,                                 ",
               "       UPPER(EB.DZEB002)             COMMENTS                                     ",
               "  FROM DZEB_T EB                                                                  ",
               " WHERE EB.DZEB001 = '",ls_table_name.toLowerCase(),"'                             ",
               "   AND EXISTS (                                                                   ", 
               "                SELECT 1                                                          ",
               "                  FROM DBA_COL_COMMENTS DCCS                                      ",
               "                 WHERE 1=1                                                        ",
               "                   AND DCCS.OWNER       = UPPER('",ls_db_user_name,"')            ", 
               "                   AND DCCS.TABLE_NAME  = UPPER('",ls_table_name,"')              ", 
               "                   AND DCCS.COLUMN_NAME = UPPER(EB.DZEB002)                       ",
               "                   AND DCCS.COLUMN_NAME <> NVL(DCCS.COMMENTS,'",cs_null_value,"') ",
               "              )                                                                   ",
               " ORDER BY EB.DZEB021                                                              " 
                                                                                                                              
  PREPARE lpre_get_toggle_comment_columns FROM ls_sql
  DECLARE lcur_get_toggle_comment_columns CURSOR FOR lpre_get_toggle_comment_columns

  OPEN lcur_get_toggle_comment_columns
  FOREACH lcur_get_toggle_comment_columns INTO lo_comment_columns[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_toggle_comment_columns

  CALL lo_comment_columns.deleteElement(li_rec_cnt)
  
  FREE lpre_get_toggle_comment_columns
  FREE lcur_get_toggle_comment_columns  
  
  LET lo_return = lo_comment_columns

  RETURN lo_return 
  
END FUNCTION

FUNCTION sadzi140_db_get_backdoor_columns(p_table_name)
DEFINE
  p_table_name  STRING 
DEFINE
  ls_table_name       STRING,
  li_rec_cnt          INTEGER,
  ls_sql              STRING,
  li_col_count        INTEGER,
  ls_backdoor_cols    STRING,
  lo_backdoor_columns DYNAMIC ARRAY OF T_COMMENT_COLUMNS
DEFINE
  ls_return  STRING,
  li_return  INTEGER

  LET ls_table_name   = p_table_name

  LET li_rec_cnt = 1
  LET li_col_count = 1
  LET ls_backdoor_cols = ""
  
  LET ls_sql = "SELECT DCCS.OWNER,DCCS.TABLE_NAME,DCCS.COLUMN_NAME,DCCS.COMMENTS ",
               "  FROM DBA_COL_COMMENTS DCCS                                     ",
               " WHERE 1=1                                                       ",
               "   AND DCCS.TABLE_NAME = '",ls_table_name.toUpperCase(),"'       ",
               "   AND NVL(TRIM(DCCS.COMMENTS), 'x') <> DCCS.COLUMN_NAME         ",
               "   AND EXISTS (                                                  ",
               "                SELECT 1                                         ",
               "                  FROM GZDA_T DA                                 ",
               "                 WHERE DA.GZDA001 = LOWER(DCCS.OWNER)            ",
               "                   AND DA.GZDA005 = 'Y'                          ",
               "              )                                                  ",
               " ORDER BY DCCS.OWNER,DCCS.TABLE_NAME,DCCS.COLUMN_NAME            "
                                                                                                                              
  PREPARE lpre_get_backdoor_columns FROM ls_sql
  DECLARE lcur_get_backdoor_columns CURSOR FOR lpre_get_backdoor_columns

  OPEN lcur_get_backdoor_columns
  FOREACH lcur_get_backdoor_columns INTO lo_backdoor_columns[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_backdoor_cols = ls_backdoor_cols,
                           lo_backdoor_columns[li_rec_cnt].CC_OWNER,".",
                           lo_backdoor_columns[li_rec_cnt].CC_TABLE_NAME,".",
                           lo_backdoor_columns[li_rec_cnt].CC_COLUMN_NAME,","

    LET li_rec_cnt = li_rec_cnt + 1
    LET li_col_count = li_col_count + 1
    IF li_col_count > 5 THEN
      LET li_col_count = 1 
      LET ls_backdoor_cols = ls_backdoor_cols,"\n"
    END IF  

  END FOREACH
  CLOSE lcur_get_backdoor_columns

  CALL lo_backdoor_columns.deleteElement(li_rec_cnt)
  
  FREE lpre_get_backdoor_columns
  FREE lcur_get_backdoor_columns  
  
  LET li_return = lo_backdoor_columns.getLength()
  LET ls_return = ls_backdoor_cols

  RETURN li_return,ls_return 
  
END FUNCTION
#20161220 end