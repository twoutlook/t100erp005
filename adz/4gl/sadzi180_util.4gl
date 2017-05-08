&include "../4gl/sadzi180_mcr.inc"

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds
#公用程式或是複合功能函式
&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi180_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp310_type.inc" 
&include "../4gl/sadzi180_type.inc"

DEFINE
  ms_execute_path STRING

FUNCTION sadzi180_util_set_execute_path(p_path)
DEFINE
  p_path STRING 

  LET ms_execute_path = p_path
  
END FUNCTION 

FUNCTION sadzi180_util_get_execute_path()
DEFINE
  ls_path STRING 
  
  LET ls_path = ms_execute_path

  RETURN ls_path
  
END FUNCTION 

FUNCTION sadzi180_util_get_form_path(p_form_name)
DEFINE
  p_form_name STRING 
DEFINE
  ls_form_name    STRING,
  ls_path         STRING,
  ls_os_separator STRING,
  ls_form_path    STRING

  LET ls_form_name = p_form_name
  
  LET ls_path = sadzi180_util_get_execute_path()
  LET ls_os_separator = os.Path.separator()
  LET ls_form_path = ls_path,ls_os_separator,ls_form_name                      

  RETURN ls_form_path
  
END FUNCTION 

FUNCTION sadzi180_util_trim_str(p_string)
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

FUNCTION sadzi180_util_get_table_leading_code(p_table_name)
DEFINE
  p_table_name STRING 
DEFINE
  ls_table_name     STRING,
  ls_table_pre_name STRING, 
  li_loop           INTEGER,
  ls_table_char     STRING
DEFINE
  ls_return STRING   
  
  LET ls_table_name = p_table_name
  
  LET ls_table_pre_name = ls_table_name
  FOR li_loop = 1 TO ls_table_name.getLength()
    LET ls_table_char = NVL(ls_table_name.subString(li_loop,li_loop),"@") 
    IF ls_table_char MATCHES "[_]" THEN
      LET ls_table_pre_name = ls_table_name.subString(1,li_loop - 1)
      EXIT FOR
    END IF    
  END FOR

  LET ls_return = ls_table_pre_name

  RETURN ls_return
  
END FUNCTION 

FUNCTION sadzi180_util_get_program_title(p_program,p_lang)
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
#...停用FUNCTION
FUNCTION sadzi180_util_create_real_object(p_create_object,p_mdm_schema_list)
DEFINE
  p_create_object   T_DZIA_T,
  p_mdm_schema_list DYNAMIC ARRAY OF T_SCHEMA_LIST
DEFINE
  lo_create_object        T_DZIA_T,
  lo_mdm_schema_list      DYNAMIC ARRAY OF T_SCHEMA_LIST,
  lo_db_connstr           T_DB_CONNSTR,
  lo_object_info          DYNAMIC ARRAY OF T_DZIU_T,
  li_loop                 INTEGER,
  li_sch                  INTEGER,
  ls_sql_script           STRING,
  ls_table_grant          STRING,
  ls_table_sql_filename   STRING,
  ls_synonym_sql_filename STRING,
  ls_message              STRING,
  ls_error                STRING,
  lb_success              BOOLEAN,
  ls_check_synonym        STRING,
  ls_db_user_name         STRING,
  ls_table_name           STRING,
  ls_table_index          STRING,
  ls_all_message          STRING,
  lb_matched              BOOLEAN 
DEFINE 
  lb_return  BOOLEAN,
  ls_return  STRING   
  
  LET lo_create_object.* = p_create_object.*
  LET lo_mdm_schema_list = p_mdm_schema_list
  
  LET lb_success = TRUE

  #取得表格在DB中是 Table or Synonym
  CALL sadzi180_db_get_object_information(lo_create_object.DZIA001) RETURNING lo_object_info
  
  FOR li_loop = 1 TO lo_object_info.getLength()

    LET lb_matched = FALSE
    #判斷要建立表格的資料庫是否有在清單中
    FOR li_sch = 1 TO lo_mdm_schema_list.getLength()
      IF lo_mdm_schema_list[li_sch].sl_SCHEMA_NAME = lo_object_info[li_loop].DZIU002 AND  
         lo_mdm_schema_list[li_sch].sl_CHECK_BOX = "Y" THEN
        LET lb_matched = TRUE
        EXIT FOR
      END IF
    END FOR
    #如果沒有則取下一個繼續
    IF NOT lb_matched THEN CONTINUE FOR END IF
  
    CALL sadzi180_db_get_db_connect_string(lo_object_info[li_loop].DZIU002) RETURNING lo_db_connstr.*

    #判斷若是要建立的型態為表格(T), 則產生表格建立碼
    IF lo_object_info[li_loop].DZIU003 = "T" THEN
      CALL sadzi180_db_get_create_dummy_table_sql(lo_create_object.*) RETURNING ls_sql_script
      CALL sadzi180_db_gen_table_grant(lo_create_object.DZIA001) RETURNING ls_table_grant
      LET ls_sql_script = ls_sql_script,"\n",
                          ls_table_index,"\n",
                          ls_table_grant
      CALL sadzi180_util_gen_sql_script_file(ls_sql_script,cs_create_table) RETURNING ls_table_sql_filename
      LET lo_db_connstr.db_sql_filename = ls_table_sql_filename
    END IF

    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND 
       NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value AND 
       NVL(lo_db_connstr.db_sql_filename,cs_null_value) <> cs_null_value THEN
      CALL sadzi180_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
      LET ls_error = ls_message.toUpperCase()
      #若沒有錯誤則...
      IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
        LET lb_success = FALSE
      END IF  
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Create real table/synonym.","\n", 
                           "User : ",lo_db_connstr.db_username,"\n",
                           ls_message
    END IF        

  END FOR

  LET ls_return = ls_all_message

  RETURN lb_success,ls_return
  
END FUNCTION
#...停用FUNCTION
FUNCTION sadzi180_util_make_alter_object(p_create_object,p_mdm_schema_list)
DEFINE
  p_create_object   T_DZIA_T,
  p_mdm_schema_list DYNAMIC ARRAY OF T_SCHEMA_LIST
DEFINE
  lo_create_object       T_DZIA_T,
  lo_mdm_schema_list     DYNAMIC ARRAY OF T_SCHEMA_LIST,
  lo_db_connstr          T_DB_CONNSTR,
  lo_object_info         DYNAMIC ARRAY OF T_DZIU_T,
  ls_drop_dummy          STRING,
  li_loop                INTEGER,
  li_sch                 INTEGER,
  ls_alter_sql           STRING, 
  ls_alter_sql_filename  STRING,
  ls_message             STRING,
  ls_all_message         STRING,
  lb_success             BOOLEAN,
  ls_db_user_name        STRING,
  ls_constraint_sql      STRING,
  ls_check_error         STRING,
  ls_alter_column_sql    STRING,
  lb_matched             BOOLEAN 
DEFINE 
  lb_return  BOOLEAN  

  LET lo_create_object.* = p_create_object.*
  LET lo_mdm_schema_list = p_mdm_schema_list

  LET lb_success = TRUE
  
  #取得表格在DB中是 Table or Synonym
  CALL sadzi180_db_get_object_information(lo_create_object.DZIA001) RETURNING lo_object_info
  
  FOR li_loop = 1 TO lo_object_info.getLength()
  
    LET lb_matched = FALSE
    #判斷要建立表格的資料庫是否有在清單中
    FOR li_sch = 1 TO lo_mdm_schema_list.getLength()
      IF lo_mdm_schema_list[li_sch].sl_SCHEMA_NAME = lo_object_info[li_loop].DZIU002 AND  
         lo_mdm_schema_list[li_sch].sl_CHECK_BOX = "Y" THEN
        LET lb_matched = TRUE
        EXIT FOR
      END IF
    END FOR
    #如果沒有則取下一個繼續
    IF NOT lb_matched THEN CONTINUE FOR END IF
    
    CALL sadzi180_db_get_db_connect_string(lo_object_info[li_loop].DZIU002) RETURNING lo_db_connstr.*
    
    #判斷若是要建立的型態為表格(T), 則產生表格異動碼
    IF lo_object_info[li_loop].DZIU003 = "T" THEN

    LET ls_alter_sql = ""
      
      ###############################################################################################################################################################
      #先以TableEditor的資料作欄位的異動
      CALL sadzi180_db_get_alter_column_sql(lo_create_object.*) RETURNING ls_alter_column_sql
      LET ls_alter_sql = ls_alter_sql,"\n",
                         ls_alter_column_sql

      #移除 Dummy 欄位                   
      CALL sadzi180_db_get_drop_dummy_column_sql(lo_create_object.DZIA001) RETURNING ls_drop_dummy                         
      LET ls_alter_sql = ls_alter_sql,"\n",
                         ls_drop_dummy

      #Key(Constraint)有異動要處理
      CALL sadzi180_db_get_alter_constraint_sql(lo_create_object.*) RETURNING ls_constraint_sql
      LET ls_alter_sql = ls_alter_sql,"\n",
                         ls_constraint_sql

      #產出 SQL Scripts File
      CALL sadzi180_util_gen_sql_script_file(ls_alter_sql,cs_alter_column) RETURNING ls_alter_sql_filename
      LET lo_db_connstr.db_sql_filename = ls_alter_sql_filename
      IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
        CALL sadzi180_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
        LET ls_db_user_name = lo_db_connstr.db_username
        LET ls_all_message = ls_all_message,"\n",
                             "Process :","Alter table modify column.","\n", 
                             "User : ",lo_db_connstr.db_username,"\n",
                             ls_message
      END IF        
      ###############################################################################################################################################################
      
    END IF
    
    #異動過程中任一區域有任何錯誤, 就終止表格異動
    LET ls_check_error = ls_all_message.toUpperCase()
    IF (ls_check_error.getIndexOf("ERROR",1) > 0) THEN
      LET lb_success = FALSE
      EXIT FOR
    END IF
    
  END FOR

  LET lb_return = lb_success
  
  RETURN lb_return,ls_all_message
  
END FUNCTION

#刪除 Master Table 的資料
FUNCTION sadzi180_util_delete_master_table(p_create_object,p_mdm_schema_list,p_delete_data)
DEFINE
  p_create_object   T_DZIA_T,
  p_mdm_schema_list DYNAMIC ARRAY OF T_SCHEMA_LIST,
  p_delete_data     BOOLEAN
DEFINE
  lo_create_object    T_DZIA_T,
  lo_mdm_schema_list  DYNAMIC ARRAY OF T_SCHEMA_LIST,
  lb_delete_data      BOOLEAN,
  ls_table_name       STRING,
  lo_db_connstr       T_DB_CONNSTR,
  lo_object_info      DYNAMIC ARRAY OF T_DZIU_T,
  ls_sql              STRING,
  ls_replace_arg      STRING,
  ls_drop_script_name STRING,
  ls_all_message      STRING,
  ls_message          STRING,
  li_loop             INTEGER,
  li_sch              INTEGER,
  ls_error            STRING,
  ls_question         STRING,
  ls_foreign_key_list STRING,
  lb_result           BOOLEAN,  
  lb_success          BOOLEAN,
  lb_matched          BOOLEAN 
DEFINE 
  lb_return BOOLEAN  

  LET lo_create_object.* = p_create_object.*
  LET lo_mdm_schema_list = p_mdm_schema_list
  LET lb_delete_data     = p_delete_data
  
  LET ls_table_name = lo_create_object.DZIA001
  
  LET lb_success    = TRUE 
  LET lb_result     = TRUE

  #取得表格在DB中是 Table or Synonym
  CALL sadzi180_db_get_object_information(lo_create_object.DZIA001) RETURNING lo_object_info
  
  FOR li_loop = 1 TO lo_object_info.getLength()

    LET lb_matched = FALSE
    #判斷要建立表格的資料庫是否有在清單中
    FOR li_sch = 1 TO lo_mdm_schema_list.getLength()
      IF lo_mdm_schema_list[li_sch].sl_SCHEMA_NAME = lo_object_info[li_loop].DZIU002 AND  
         lo_mdm_schema_list[li_sch].sl_CHECK_BOX = "Y" THEN
        LET lb_matched = TRUE
        EXIT FOR
      END IF
    END FOR
    #如果沒有則取下一個繼續
    IF NOT lb_matched THEN CONTINUE FOR END IF
  
    CALL sadzi180_db_get_db_connect_string(lo_object_info[li_loop].DZIU002) RETURNING lo_db_connstr.*

    #若為表格, 則產生Drop Table Script file
    IF lo_object_info[li_loop].DZIU003 = "T" THEN
      CALL sadzi180_db_gen_drop_script(ls_table_name,"T") RETURNING ls_drop_script_name 
    ELSE
      CALL sadzi180_db_gen_drop_script(ls_table_name,"S") RETURNING ls_drop_script_name 
    END IF
    
    LET lo_db_connstr.db_sql_filename = ls_drop_script_name
    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
      CALL sadzi180_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Drop table and delete set data.","\n", 
                           "User : ",lo_db_connstr.db_username,"\n",
                           ls_message
    END IF        
    
  END FOR  
  
  LET ls_error = ls_all_message.toUpperCase()
  IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_success = FALSE
  END IF  

  IF lb_success AND lb_delete_data THEN
  
    BEGIN WORK

    IF lb_result THEN 
      #資料表欄位檔
      LET ls_sql = "DELETE FROM DZIB_T ", 
                   " WHERE DZIB001 = '", ls_table_name, "' ",
                   "   AND DZIB029 = '", lo_create_object.DZIA015, "'" 
      CALL sadzi180_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
    END IF       
    
    IF lb_result THEN 
      #資料表 Table/Synonym 定義檔
      LET ls_sql = "DELETE FROM DZIU_T ", 
                   " WHERE DZIU001 = '",ls_table_name,"' "
      CALL sadzi180_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result        
    END IF       

    IF lb_result THEN 
      #ALM begin
      #版本設定檔
      LET ls_sql = "DELETE FROM DZAF_T                   ", 
                   " WHERE DZAF001 = '",ls_table_name,"' ",
                   "   AND DZAF010 = '", lo_create_object.DZIA015, "'"
      CALL sadzi180_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
    END IF  

    IF lb_result THEN 
      #ALM資料檔
      LET ls_sql = "DELETE FROM DZLM_T                   ", 
                   " WHERE DZLM002 = '",ls_table_name,"' "
      CALL sadzi180_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
      #ALM end
    END IF  

    IF lb_result THEN 
      #資料表主檔(最後才刪)
      LET ls_sql = "DELETE FROM DZIA_T ", 
                   " WHERE DZIA001 = '",ls_table_name,"' ",
                   "   AND DZIA015 = '", lo_create_object.DZIA015, "'"
      CALL sadzi180_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result        
    END IF

    IF lb_result THEN
      COMMIT WORK 
    ELSE
      ROLLBACK WORK
      CALL sadzi190_msg_message_box("Error","dialog","刪除表格相關資料時失敗.","stop")
    END IF  

  END IF    

  LET lb_success = lb_result
  LET lb_return = lb_success

  RETURN lb_return,ls_all_message
  
END FUNCTION

FUNCTION sadzi180_util_gen_sql_script_file(p_sql,p_sql_type)
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
  CALL sadzi180_util_get_GUID() RETURNING ls_GUID 
  
  LET ls_sript_filename = ls_tempdir,ls_separator,"sadzi180_",ls_sql_type,"_",ls_GUID,".sql"
  
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
    DISPLAY "Generate Script Error !!"
  END TRY  

  LET ls_return = ls_sript_filename

  RETURN ls_return

END FUNCTION

FUNCTION sadzi180_util_get_GUID()
DEFINE 
  ls_GUID  STRING
DEFINE  
  ls_return STRING

  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID 

  LET ls_return = ls_GUID
  
  RETURN ls_return                     
  
END FUNCTION

#呼叫 ALM 取得 DZLU 資訊
FUNCTION sadzi180_util_alm_check_out(p_enable_alm,p_user,p_lang,p_role,p_wizard)
DEFINE
  p_enable_alm BOOLEAN,
  p_user       STRING,
  p_lang       STRING,
  p_role       STRING, 
  p_wizard     BOOLEAN 
DEFINE
  lb_enable_alm BOOLEAN,
  ls_user       STRING,
  ls_lang       STRING,
  ls_role       STRING, 
  li_step       INTEGER,
  lb_wizard     BOOLEAN, 
  lo_DZLU_T     DYNAMIC ARRAY OF T_DZLU_T,
  lo_user_info  T_USER_INFO,
  lb_result     BOOLEAN

  LET lb_enable_alm = p_enable_alm
  LET ls_user       = p_user
  LET ls_lang       = p_lang
  LET ls_role       = p_role
  LET lb_wizard     = p_wizard
  
  #設定使用者資訊
  LET lo_user_info.ui_NUMBER = ls_user
  &ifndef DEBUG 
    LET lo_user_info.ui_NAME = cl_get_username(ls_user)
  &else  ""  
    LET lo_user_info.ui_NAME = cs_null_username_default
  &endif
  LET lo_user_info.ui_LANG   = ls_lang
  LET lo_user_info.ui_ROLE   = ls_role

  IF (lb_enable_alm) THEN
    #取得DZLU資料
    CALL sadzp200_ckout_run(lo_USER_INFO.ui_ROLE, lo_USER_INFO.ui_NUMBER, lo_USER_INFO.ui_LANG, 0, lb_wizard) 
         RETURNING lb_result,li_step,lo_DZLU_T
  ELSE
    CALL sadzp200_ckout_get_dzlu_without_alm(lo_USER_INFO.ui_ROLE, lo_USER_INFO.ui_NUMBER) RETURNING lb_result,lo_DZLU_T
  END IF

  RETURN lb_result,lo_user_info.*,lo_DZLU_T
  
END FUNCTION 

FUNCTION sadzi180_util_set_alm_info(p_table_name,p_module_name,p_table_desc,p_spec_type,p_role,p_DZLU_T)
DEFINE
  p_table_name  STRING,
  p_module_name STRING,
  p_table_desc  STRING,
  p_spec_type   STRING,
  p_role        STRING,
  p_DZLU_T      DYNAMIC ARRAY OF T_DZLU_T
DEFINE
  ls_table_name  STRING,
  ls_module_name STRING,
  ls_table_desc  STRING,
  ls_spec_type   STRING,
  ls_role        STRING,
  lo_DZLU_T      DYNAMIC ARRAY OF T_DZLU_T,
  lb_result      BOOLEAN,
  ls_update_type STRING,
  li_dzlu        INTEGER,
  ls_GUID        STRING,
  lo_dzlm_t      T_DZLM_T,
  lo_DZAF_T      T_DZAF_T,
  lo_table_info  T_PROGRAM_INFO
DEFINE
  lb_return  BOOLEAN,
  lo_return  T_DZLM_T
  

  LET ls_table_name  = p_table_name
  LET ls_module_name = p_module_name
  LET ls_table_desc  = p_table_desc
  LET ls_spec_type   = p_spec_type
  LET ls_role        = p_role
  LET lo_DZLU_T      = p_DZLU_T

  #設定表格資訊 
  LET lo_table_info.pi_NAME   = ls_table_name
  LET lo_table_info.pi_MODULE = ls_module_name
  LET lo_table_info.pi_DESC   = ls_table_desc
  LET lo_table_info.pi_TYPE   = ls_spec_type 
  
  #設定版號輸入資料
  LET lo_DZAF_T.DZAF001 = lo_table_info.pi_NAME
  LET lo_DZAF_T.DZAF005 = lo_table_info.pi_TYPE
  LET lo_DZAF_T.DZAF006 = lo_table_info.pi_MODULE
  
  #取得新版號
  CALL sadzp200_ver_get_new_ver_info(lo_DZAF_T.*,ls_role,FALSE) RETURNING lb_result,lo_DZAF_T.*
  IF NOT lb_result THEN DISPLAY cs_error_tag,"Get New version information fault." GOTO _RETURN END IF 
  #彙整入DZLM_T 
  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID
  FOR li_dzlu = 1 TO lo_DZLU_T.getLength()
    IF lo_DZLU_T[li_dzlu].DZLU001 IS NOT NULL THEN 
      CALL sadzp200_alm_set_dzlm_mix_info(lo_DZLU_T[li_dzlu].*,lo_DZAF_T.*,lo_table_info.*,ls_GUID) RETURNING lb_result,ls_update_type
      EXIT FOR 
    END IF   
  END FOR 
  IF NOT lb_result THEN DISPLAY cs_error_tag,"Set DZLM data fault." GOTO _RETURN END IF 
  CALL sadzp200_alm_get_dzlm(lo_table_info.*,cs_user_role_sd) RETURNING lo_dzlm_t.*  
  IF NOT lb_result THEN DISPLAY cs_error_tag,"Get DZLM information fault." GOTO _RETURN END IF
  
  LABEL _RETURN:

  LET lb_return = lb_result
  LET lo_return.* = lo_dzlm_t.*  

  RETURN lb_return,lo_return.*
  
END FUNCTION 

FUNCTION sadzi180_util_alm_check_in(p_table_info,p_role)
DEFINE
  p_table_info  T_PROGRAM_INFO,
  p_role        STRING
DEFINE
  lo_table_info  T_PROGRAM_INFO,
  ls_role        STRING,
  lo_dzlm_t      T_DZLM_T,
  lb_result      BOOLEAN
DEFINE
  lb_return  BOOLEAN  

  LET lo_table_info.* = p_table_info.*
  LET ls_role = p_role

  CALL sadzp200_alm_get_dzlm(lo_table_info.*,ls_role) RETURNING lo_dzlm_t.*
  
  BEGIN WORK
  
  CALL sadzp200_alm_update_check_in_code(lo_dzlm_t.*,ls_role) RETURNING lb_result
  IF NOT lb_result THEN GOTO _CheckWork END IF

  #檢核DZLM資料是否還有簽出的
  CALL sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_out) RETURNING lb_result
  IF NOT lb_result THEN
    #當DZLM中的SD或PR項均無簽出者,則 DZLM 資訊更新遷入日期結案
    CALL sadzp200_alm_update_check_in_date(lo_DZLM_T.*) RETURNING lb_result
    IF NOT lb_result THEN GOTO _CheckWork END IF 
  END IF
  
  LABEL _CheckWork:
  
  IF lb_result THEN 
    COMMIT WORK
  ELSE
    ROLLBACK WORK
  END IF

  LET lb_return = lb_result

  RETURN lb_return
      
END FUNCTION