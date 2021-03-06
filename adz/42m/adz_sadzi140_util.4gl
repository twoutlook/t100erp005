{
  異動型態    異動單號       日 期       異動者      異動內容
  ========= ============= ========== ========== ===============================================
  Modify                  20161220   Ernestliou 1.針對客戶自行新增的欄位, 一律不處理 drop 程序
}

&include "../4gl/sadzi140_mcr.inc"

IMPORT os
IMPORT util
IMPORT ui

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp000_type.inc"

&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp200_type.inc"

&include "../4gl/sadzi140_cnst.inc"

&ifndef DEBUG
GLOBALS "../../cfg/top_global.inc"
&else
GLOBALS "../../cfg/top_global.inc"
&endif

DEFINE
  ms_execute_path STRING

################################################################################
#資料表 TYPE 宣告

&include "../4gl/sadzi140_type.inc"

FUNCTION sadzi140_util_set_execute_path(p_path)
DEFINE
  p_path STRING 

  LET ms_execute_path = p_path
  
END FUNCTION 

FUNCTION sadzi140_util_get_execute_path()
DEFINE
  ls_path STRING 
  
  LET ls_path = ms_execute_path

  RETURN ls_path
  
END FUNCTION 

FUNCTION sadzi140_util_get_form_path(p_form_name)
DEFINE
  p_form_name STRING 
DEFINE
  ls_form_name    STRING,
  ls_path         STRING,
  ls_os_separator STRING,
  ls_form_path    STRING

  LET ls_form_name = p_form_name
  
  LET ls_path = sadzi140_util_get_execute_path()
  LET ls_os_separator = os.Path.separator()
  LET ls_form_path = ls_path,ls_os_separator,ls_form_name                      

  RETURN ls_form_path
  
END FUNCTION 

FUNCTION sadzi140_util_create_real_table(p_master_user,p_create_table,p_version,p_alm_version,p_alm_request_no,p_dgenv,p_create_shot)
DEFINE
  p_master_user     STRING,
  p_create_table    T_DZEA_CREATE_TABLE,
  p_version         STRING,  
  p_alm_version     STRING,  
  p_alm_request_no  STRING,
  p_dgenv           STRING,
  p_create_shot     BOOLEAN
DEFINE
  ls_master_user          STRING,
  lo_create_table         T_DZEA_CREATE_TABLE,
  ls_version              STRING,
  ls_alm_version          STRING,
  ls_alm_request_no       STRING,
  ls_dgenv                STRING,
  lb_create_shot          BOOLEAN,
  lo_db_connstr           T_DB_CONNSTR,
  lo_table_in_db_type     DYNAMIC ARRAY OF T_TABLE_IN_DB_TYPE,
  li_loop                 INTEGER,
  ls_sql_script           STRING,
  ls_table_grant          STRING,
  ls_table_sql_filename   STRING,
  ls_synonym_sql_filename STRING,
  ls_message              STRING,
  ls_db_user_name         STRING,
  ls_table_name           STRING,
  ls_table_index          STRING,
  ls_curr_version         STRING,
  ls_new_version          STRING,
  ls_all_message          STRING
DEFINE 
  ls_return      STRING   
  
  LET ls_master_user    = NVL(p_master_user,"ds")
  LET lo_create_table.* = p_create_table.*
  LET ls_version        = p_version
  LET ls_alm_version    = p_alm_version
  LET lb_create_shot    = p_create_shot
  LET ls_alm_request_no = p_alm_request_no
  LET ls_dgenv          = p_dgenv

  #取得表格在DB中是 Table or Synonym
  CALL sadzi140_db_get_table_in_db_type(lo_create_table.dct_table_name,cs_order_by_asc) RETURNING lo_table_in_db_type
  
  FOR li_loop = 1 TO lo_table_in_db_type.getLength()
    CALL sadzi140_db_get_db_connect_string(lo_table_in_db_type[li_loop].tidt_db) RETURNING lo_db_connstr.*

    #判斷若是要建立的型態為表格(T), 則產生表格建立碼
    IF lo_table_in_db_type[li_loop].tidt_object_type = "T" THEN
      CALL sadzi140_db_get_create_dummy_table_sql(lo_create_table.*) RETURNING ls_sql_script
      CALL sadzi140_db_gen_table_index(lo_db_connstr.db_username,lo_create_table.dct_table_name,FALSE) RETURNING ls_table_index
      CALL sadzi140_db_gen_table_grant(lo_create_table.dct_table_name) RETURNING ls_table_grant
      LET ls_sql_script = ls_sql_script,"\n",
                         ls_table_index,"\n",
                         ls_table_grant
      CALL sadzi140_rev_gen_sql_script_file(ls_sql_script,cs_create_table) RETURNING ls_table_sql_filename
      LET lo_db_connstr.db_sql_filename = ls_table_sql_filename
    ELSE
      #否則產生同義字建立碼(S)
      CALL sadzi140_db_get_create_synonym_sql(lo_db_connstr.*,lo_create_table.*) RETURNING ls_sql_script
      CALL sadzi140_rev_gen_sql_script_file(ls_sql_script,cs_create_synonym) RETURNING ls_synonym_sql_filename
      LET lo_db_connstr.db_sql_filename = ls_synonym_sql_filename
    END IF

    LET lo_db_connstr.db_version = ls_version
    
    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
      CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
      #若沒有錯誤則建立Snapshot
      LET ls_db_user_name = lo_db_connstr.db_username
      LET ls_table_name   = lo_create_table.dct_table_name
      IF (NOT (ls_message.getIndexOf("Error",1) > 0)) AND (ls_db_user_name.toUpperCase() = ls_master_user.toUpperCase()) AND lb_create_shot THEN
        CALL sadzi140_vcs_get_curr_version_code(ls_table_name,1) RETURNING ls_curr_version
        CALL sadzi140_vcs_get_new_version_code(ls_table_name,FALSE,FALSE,FALSE,TRUE,1) RETURNING ls_new_version
        CALL sadzi140_shot_create_snapshot(ls_master_user,lo_create_table.dct_table_name,ls_curr_version,ls_new_version,ls_alm_version,ls_alm_request_no,ls_dgenv)
      END IF  
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Create real table.","\n", 
                           "User : ",lo_db_connstr.db_username,"\n",
                           "Version : ",lo_db_connstr.db_version,"\n",
                           ls_message
    END IF        

  END FOR

  LET ls_return = ls_all_message

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_util_make_alter_table(p_master_user,p_table_name,p_batch_mode)
DEFINE 
  p_master_user STRING,
  p_table_name  STRING,
  p_batch_mode  BOOLEAN
DEFINE 
  ls_master_user         STRING,
  ls_table_name          STRING,
  lb_batch_mode          BOOLEAN,
  ls_view_log            STRING,
  li_loop                INTEGER,
  ls_prev_veriosn        STRING,
  lb_different           BOOLEAN,
  lo_different           DYNAMIC ARRAY OF T_COLUMN_DIFF,
  lo_table_in_db_type    DYNAMIC ARRAY OF T_TABLE_IN_DB_TYPE,
  lb_index_diff          BOOLEAN,
  lo_index_diff_list     DYNAMIC ARRAY OF T_INDEX_DIFF,
  lb_constraint_diff     BOOLEAN,
  lo_constraint_diff     DYNAMIC ARRAY OF T_CONSTRAINT_DIFF, 
  lo_db_connstr          T_DB_CONNSTR,
  ls_alter_sql           STRING, 
  ls_alter_sql_filename  STRING,
  ls_drop_sql            STRING, 
  ls_drop_sql_filename   STRING,
  ls_message             STRING,
  ls_all_message         STRING,
  ls_error               STRING,
  lb_error               BOOLEAN,
  ls_db_user_name        STRING,
  ls_key_list            STRING,
  ls_constraint_sql      STRING,
  ls_alter_index_sql     STRING,
  ls_drop_index_sql      STRING,
  ls_replace_arg         STRING,
  ls_check_error         STRING,
  lb_table_lock          BOOLEAN,
  ls_lock_user_name      STRING,
  ls_foreign_sql         STRING,
  ls_alter_column_sql    STRING,
  ls_drop_column_sql     STRING, 
  ls_update_sql          STRING,
  ls_err_message         STRING,
  ls_error_code          STRING,
  ls_alter_procedure_sql STRING,
  ls_message_bar         STRING,
  ls_lang                STRING, #20161220
  li_backdoor_col_counts INTEGER, #20161220
  ls_backdoor_col_list   STRING, #20161220
  ls_toggle_comment_sql      STRING, #20161220
  ls_toggle_comment_filename STRING, #20161220
  lb_rt_drop_backdoor_column BOOLEAN, #20161220
  lo_undrop_col_list  DYNAMIC ARRAY OF T_COLUMN_LIST, #20161220
  ls_drop_abnormal_column STRING,
  lb_drop_abnormal_column BOOLEAN,
  ls_alter_procedure_filename STRING
DEFINE 
  lb_return  BOOLEAN  

  LET ls_master_user = p_master_user
  LET ls_table_name  = p_table_name
  LET lb_batch_mode  = p_batch_mode
  
  LET lb_error = FALSE
  LET ls_lang = NVL(g_lang,cs_default_lang) #20161220

  #檢核表格有無被鎖定
  CALL sadzi140_db_check_table_lock(ls_table_name) RETURNING lb_table_lock,ls_lock_user_name
  IF lb_table_lock THEN
    LET lb_error = TRUE
    LET ls_error_code = "adz-00142"
    LET ls_replace_arg = ls_table_name,"|",ls_lock_user_name,"|"
    
    IF lb_batch_mode THEN
      LET ls_err_message = sadzp000_msg_get_message(ls_error_code,cs_default_language)
      CALL sadzp000_msg_replace_message(ls_err_message,ls_replace_arg) RETURNING ls_err_message
      DISPLAY cs_error_tag,ls_err_message
    ELSE 
      CALL sadzp000_msg_show_error(NULL, ls_error_code, ls_replace_arg, 1)
    END IF 
    
    GOTO _return      
    
  END IF

  #判斷是否要進行 Columns, Key, Index 等的 Drop 程序
  CALL sadzi140_db_get_parameter(cs_param_level_alter_table,cs_param_drop_abnormal_column) RETURNING ls_drop_abnormal_column
  LET lb_drop_abnormal_column = IIF(NVL(ls_drop_abnormal_column,"N")=="Y",TRUE,FALSE)  
  
  #取得表格在DB中是 Table or Synonym
  CALL sadzi140_db_get_table_in_db_type(ls_table_name,cs_order_by_desc) RETURNING lo_table_in_db_type
  
  FOR li_loop = 1 TO lo_table_in_db_type.getLength()
    CALL sadzi140_db_get_db_connect_string(lo_table_in_db_type[li_loop].tidt_db) RETURNING lo_db_connstr.*
    
    #檢查表格型態, 並建立之
    CALL sadzi140_db_get_alter_table_type_procedure(ls_table_name,lo_db_connstr.db_username,ls_master_user) RETURNING ls_alter_procedure_sql
    #產出 SQL Scripts File
    CALL sadzi140_rev_gen_sql_script_file(ls_alter_procedure_sql,cs_alter_table) RETURNING ls_alter_procedure_filename
    LET lo_db_connstr.db_sql_filename = ls_alter_procedure_filename
    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
      CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
      LET ls_db_user_name = lo_db_connstr.db_username
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Check and modify table or synonym type.","\n", 
                           "User : ",lo_db_connstr.db_username,"\n",
                           --"Version : ",lo_db_connstr.db_version,"\n",
                           ls_message
    END IF        
    
    #判斷若是要建立的型態為表格(T), 則產生表格異動碼
    IF lo_table_in_db_type[li_loop].tidt_object_type = "T" THEN
      LET ls_alter_sql = ""
      ###############################################################################################################################################################
      #Toggle bookmark for table columns
      #20161220 begin
      LET ls_message_bar = "Toggle bookmark for ",lo_db_connstr.db_username,".",ls_table_name," columns."
      CALL sadzi140_util_show_message_bar(lb_batch_mode,ls_message_bar)
      CALL sadzi140_util_get_toggle_bookmark_scripts(lo_db_connstr.db_username,ls_table_name) RETURNING ls_toggle_comment_sql
      CALL sadzi140_rev_gen_sql_script_file(ls_toggle_comment_sql,cs_toggle_bookmark) RETURNING ls_toggle_comment_filename
      LET lo_db_connstr.db_sql_filename = ls_toggle_comment_filename
      IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
        CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
        LET ls_all_message = ls_all_message,"\n",
                             "Process :",ls_message_bar,"\n", 
                             "User : ",lo_db_connstr.db_username,"\n",
                             ls_message
      END IF        
      #20161220 end
      ###############################################################################################################################################################
      #先以TableEditor的資料作欄位的異動
      LET lo_different = NULL
      LET ls_message_bar = "Get ",lo_db_connstr.db_username," column difference with table editor."
      CALL sadzi140_util_show_message_bar(lb_batch_mode,ls_message_bar) 
      CALL sadzi140_shot_get_column_diff_by_table_editor(lo_db_connstr.db_username,ls_table_name) RETURNING lb_different,lo_different
      CALL sadzi140_db_get_alter_column_sql(ls_master_user,lo_db_connstr.db_username,ls_table_name,cs_table_designer,lo_different) RETURNING ls_alter_column_sql
      LET ls_alter_sql = ls_alter_sql,"\n",
                         ls_alter_column_sql

      #Key(Constraint)有異動要處理
      LET ls_message_bar = "Get ",lo_db_connstr.db_username," constraint difference with table editor."
      CALL sadzi140_util_show_message_bar(lb_batch_mode,ls_message_bar) 
      CALL sadzi140_shot_get_constraint_diff_by_table_editor(lo_db_connstr.db_username,ls_table_name) RETURNING lb_constraint_diff,lo_constraint_diff
      IF lb_constraint_diff THEN
        CALL sadzi140_db_get_alter_constraint_sql(lo_db_connstr.db_username,ls_table_name,lo_constraint_diff) RETURNING ls_constraint_sql
        LET ls_alter_sql = ls_alter_sql,"\n",
                           ls_constraint_sql
      END IF

      #更新 Foreign Key Data 的Foreign Key 欄位順序(DZED_T)
      CALL sadzi140_db_get_update_foreign_key_data(ls_table_name) RETURNING ls_update_sql
      LET ls_alter_sql = ls_alter_sql,"\n",
                         ls_update_sql
      
      #索引有異動要處理
      LET ls_message_bar = "Get ",lo_db_connstr.db_username," index difference with table editor."
      CALL sadzi140_util_show_message_bar(lb_batch_mode,ls_message_bar) 
      CALL sadzi140_shot_get_index_diff_by_table_editor(ls_master_user,ls_table_name) RETURNING lb_index_diff,lo_index_diff_list
      IF lb_index_diff THEN
        CALL sadzi140_db_get_alter_index_sql(lo_db_connstr.db_username,ls_table_name,lo_index_diff_list) RETURNING ls_alter_index_sql
        LET ls_alter_sql = ls_alter_sql,"\n",
                           ls_alter_index_sql
      END IF

      #產出 SQL Scripts File
      CALL sadzi140_rev_gen_sql_script_file(ls_alter_sql,cs_alter_column) RETURNING ls_alter_sql_filename
      LET lo_db_connstr.db_sql_filename = ls_alter_sql_filename
      IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
        CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
        LET ls_db_user_name = lo_db_connstr.db_username
        LET ls_all_message = ls_all_message,"\n",
                             "Process :","Alter table modify column.","\n", 
                             "User : ",lo_db_connstr.db_username,"\n",
                             --"Version : ",lo_db_connstr.db_version,"\n",
                             ls_message
      END IF        
      ###############################################################################################################################################################

      ###############################################################################################################################################################
      LET ls_drop_sql = ""
      #再用實際Database的資料刪除不需要的欄位
      LET lo_different = NULL
      LET ls_message_bar = "Get ",lo_db_connstr.db_username," column difference with database."
      CALL sadzi140_util_show_message_bar(lb_batch_mode,ls_message_bar) 
      CALL sadzi140_shot_get_column_diff_by_database(lo_db_connstr.db_username,ls_table_name,lb_drop_abnormal_column) RETURNING lb_different,lo_different
      CALL sadzi140_db_get_drop_column_sql(ls_master_user,lo_db_connstr.db_username,ls_table_name,cs_database,lo_different) RETURNING lb_rt_drop_backdoor_column,ls_drop_column_sql,lo_undrop_col_list #20161220
      #20161220 begin 
      IF lb_rt_drop_backdoor_column THEN 
        CALL sadzi140_util_create_altering_log(cs_logs_type_drop_backdoor_column,lo_undrop_col_list) 
      ELSE
        CALL sadzi140_util_create_altering_log(cs_logs_type_reserve_column,lo_undrop_col_list)
      END IF
      #20161220 end 
      LET ls_drop_sql = ls_drop_sql,"\n",
                        ls_drop_column_sql
      
      
      #Key(Constraint)有異動要處理
      LET ls_message_bar = "Get ",lo_db_connstr.db_username," constraint difference with database."
      CALL sadzi140_util_show_message_bar(lb_batch_mode,ls_message_bar) 
      CALL sadzi140_shot_get_constraint_diff_by_database(lo_db_connstr.db_username,ls_table_name,lb_drop_abnormal_column) RETURNING lb_constraint_diff,lo_constraint_diff
      IF lb_constraint_diff THEN
        CALL sadzi140_db_get_drop_constraint_sql(lo_db_connstr.db_username,ls_table_name,lo_constraint_diff) RETURNING ls_constraint_sql
        LET ls_drop_sql = ls_constraint_sql,"\n",
                          ls_drop_sql
      END IF

      #索引有異動要處理
      LET ls_message_bar = "Get ",lo_db_connstr.db_username," index difference with database."
      CALL sadzi140_util_show_message_bar(lb_batch_mode,ls_message_bar) 
      CALL sadzi140_shot_get_index_diff_by_database(ls_master_user,ls_table_name,lb_drop_abnormal_column) RETURNING lb_index_diff,lo_index_diff_list 
      IF lb_index_diff THEN
        CALL sadzi140_db_get_drop_index_sql(lo_db_connstr.db_username,ls_table_name,ls_prev_veriosn,lo_index_diff_list) RETURNING ls_drop_index_sql
        LET ls_drop_sql = ls_drop_sql,"\n",
                          ls_drop_index_sql
      END IF 
      
      #產出 SQL Scripts File
      CALL sadzi140_rev_gen_sql_script_file(ls_drop_sql,cs_drop_column) RETURNING ls_drop_sql_filename
      LET lo_db_connstr.db_sql_filename = ls_drop_sql_filename
      IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
        CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
        LET ls_db_user_name = lo_db_connstr.db_username
        LET ls_all_message = ls_all_message,"\n",
                             "Process :","Alter table drop column.","\n", 
                             "User : ",lo_db_connstr.db_username,"\n",
                             --"Version : ",lo_db_connstr.db_version,"\n",
                             ls_message
      END IF   
        
      ###############################################################################################################################################################
      
    END IF
    
    #異動過程中任一區域有任何錯誤, 就終止表格異動
    LET ls_check_error = ls_all_message.toUpperCase()
    IF (ls_check_error.getIndexOf("ERROR",1) > 0) THEN
      EXIT FOR
    END IF
    
  END FOR

  LET ls_error = ls_all_message.toUpperCase()
  IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_error = TRUE
    IF lb_batch_mode THEN
      DISPLAY cs_error_tag," Alter table error, please refer to log."
    ELSE 
      CALL sadzp000_msg_show_error(NULL, 'adz-00097', NULL, 1)
    END IF 
  END IF  

  IF lb_batch_mode THEN
    DISPLAY ls_all_message
  ELSE
    #CALL sadzi140_rev_view_logresult(ls_all_message)
    CALL sadzi140_util_show_message_bar(lb_batch_mode,"") 
    DISPLAY ls_all_message
  END IF  

  #20161220 begin
  #Get backdoor column list
  CALL sadzi140_db_get_backdoor_columns(ls_table_name) RETURNING li_backdoor_col_counts,ls_backdoor_col_list
  IF li_backdoor_col_counts > 0 THEN  
    LET ls_backdoor_col_list = "\n",ls_backdoor_col_list
    CALL sadzp000_msg_get_message('adz-00947',ls_lang) RETURNING ls_message
    CALL sadzp000_msg_replace_message(ls_message,ls_backdoor_col_list) RETURNING ls_message
    DISPLAY cs_warning_tag,ls_message
    IF NOT lb_batch_mode THEN 
      CALL sadzp000_msg_show_info(NULL, 'adz-00947', ls_backdoor_col_list, 0)
    END IF
  END IF  
  #20161220 end
  
  IF NOT lb_error THEN
    IF lb_batch_mode THEN
      DISPLAY "[Finish] Table ",ls_table_name," alter finished."
    ELSE
      LET ls_replace_arg = " ",ls_table_name," ","|"
      CALL sadzp000_msg_show_info(NULL, 'adz-00110', ls_replace_arg, 0)
    END IF  
  ELSE
    IF lb_batch_mode THEN
      DISPLAY cs_error_tag,"Table ",ls_table_name," alter with error !!"
    ELSE
      LET ls_replace_arg = ls_table_name,"|"
      #CALL sadzp000_msg_show_error(NULL, 'adz-00098', ls_replace_arg, 1)
      CALL sadzi140_rev_view_logresult(ls_all_message)
    END IF   
  END IF  

  LABEL _return:
  
  LET lb_return = lb_error
  
  RETURN lb_return,ls_all_message
  
END FUNCTION

#刪除 Master Table 的資料
FUNCTION sadzi140_util_delete_master_table(p_master_user,p_if_delete_data,p_table_name,p_batch_node)
DEFINE
  p_master_user    STRING,
  p_if_delete_data STRING,
  p_table_name     STRING,
  p_batch_node     BOOLEAN 
DEFINE 
  ls_master_user      STRING,
  ls_if_delete_data   STRING,
  ls_table_name       STRING,
  lb_batch_node       BOOLEAN, 
  lo_table_in_db_type DYNAMIC ARRAY OF T_TABLE_IN_DB_TYPE,
  lo_db_connstr       T_DB_CONNSTR,
  ls_main_table       STRING,
  ls_sql              STRING,
  lb_drop_table       BOOLEAN,
  lb_more_one_record  BOOLEAN,
  ls_replace_arg      STRING,
  lb_table_lock       BOOLEAN,
  ls_lock_user_name   STRING,
  ls_drop_script_name STRING,
  ls_all_message      STRING,
  ls_message          STRING,
  li_loop             INTEGER,
  ls_error            STRING,
  ls_question         STRING,
  ls_foreign_key_list STRING,
  lb_result           BOOLEAN,  
  lb_error            BOOLEAN
DEFINE 
  lb_return BOOLEAN  

  LET ls_master_user    = p_master_user
  LET ls_if_delete_data = p_if_delete_data
  LET ls_table_name     = p_table_name
  LET lb_batch_node     = p_batch_node
  
  LET ls_main_table      = ls_table_name
  LET lb_drop_table      = FALSE 
  LET lb_more_one_record = FALSE
  LET lb_table_lock      = FALSE
  LET lb_error           = FALSE 

  #取得表格是否還有資料
  CALL sadzi140_db_get_more_one_record_from_all_tables(ls_table_name) RETURNING lb_more_one_record
  IF lb_more_one_record THEN
    LET ls_replace_arg = ls_table_name,"|"
    CALL sadzp000_msg_show_error(NULL, 'adz-00139', ls_replace_arg, 1)
    GOTO _return
  END IF

  #檢核表格有無被鎖定
  CALL sadzi140_db_check_table_lock(ls_table_name) RETURNING lb_table_lock,ls_lock_user_name
  IF lb_table_lock THEN
    LET ls_replace_arg = ls_table_name,"|",ls_lock_user_name,"|"
    CALL sadzp000_msg_show_error(NULL, 'adz-00140', ls_replace_arg, 1)
    GOTO _return       
  END IF
  
  #取得表格在DB中是 Table or Synonym
  CALL sadzi140_db_get_table_in_db_type(ls_table_name,cs_order_by_desc) RETURNING lo_table_in_db_type
  
  FOR li_loop = 1 TO lo_table_in_db_type.getLength()
    CALL sadzi140_db_get_db_connect_string(lo_table_in_db_type[li_loop].tidt_db) RETURNING lo_db_connstr.*

    #若為表格, 則產生Drop Table Script file
    IF lo_table_in_db_type[li_loop].tidt_object_type = "T" THEN
      CALL sadzi140_db_gen_drop_script(ls_table_name,"T") RETURNING ls_drop_script_name 
    ELSE
      CALL sadzi140_db_gen_drop_script(ls_table_name,"S") RETURNING ls_drop_script_name 
    END IF
    
    LET lo_db_connstr.db_sql_filename = ls_drop_script_name
    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
      CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Drop table and delete set data.","\n", 
                           "User : ",lo_db_connstr.db_username,"\n",
                           "Version : ",lo_db_connstr.db_version,"\n",
                           ls_message
    END IF        
    
  END FOR  
  
  LET ls_error = ls_all_message.toUpperCase()
  IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_error = TRUE
    CALL sadzp000_msg_show_error(NULL, 'adz-00097', NULL, 1)
    IF lb_batch_node THEN
      DISPLAY ls_all_message
    ELSE
      CALL sadzi140_rev_view_logresult(ls_all_message)
    END IF
  END IF  

  IF NOT lb_error THEN
    LET lb_drop_table = TRUE 
    #判斷是否刪除相關資料 
    IF ls_if_delete_data.toUpperCase() = "D"  THEN
      #資料表欄位多語言檔(需存在於DZEB_T)
      LET ls_sql = "DELETE FROM DZEBL_T EBL                                ",
                   " WHERE EXISTS (                                        ",
                   "                SELECT 1                               ",
                   "                  FROM DZEB_T EB                       ",
                   "                 WHERE EB.DZEB002 = EBL.DZEBL001       ",
                   "                   AND EB.DZEB001 = '",ls_main_table,"'",
                   "              )                                        "{,
                   "   AND EBL.DZEBL002 = '",g_lang,"'                     "}
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)        
      
      #資料表欄位檔
      LET ls_sql = "DELETE FROM DZEB_T ", 
                   " WHERE DZEB001 = '",ls_main_table,"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)                   
      
      #資料表索引檔
      LET ls_sql = "DELETE FROM DZEC_T ", 
                   " WHERE DZEC001 = '",ls_main_table,"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)        
      
      #資料表主鍵值檔
      LET ls_sql = "DELETE FROM DZED_T ", 
                   " WHERE DZED001 = '",ls_main_table,"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)        

      #刪除外來鍵時詢問
      CALL sadzi140_db_get_foreign_key_list(ls_main_table) RETURNING lb_result,ls_foreign_key_list
      IF lb_result THEN 
        LET ls_replace_arg = ls_main_table,"|",ls_foreign_key_list,"|"
        CALL sadzp000_msg_alert_box(NULL, "adz-00383", ls_replace_arg, 0) RETURNING ls_question                                       
        IF ls_question = cs_question_yes THEN
          #資料表外來鍵值檔
          LET ls_sql = "DELETE FROM DZED_T   ", 
                       " WHERE DZED003 = 'R' ",
                       "   AND DZED005 = '",ls_main_table,"' "
          CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
        END IF
      END IF
      
      #資料表欄位參考檔
      LET ls_sql = "DELETE FROM DZEF_T ", 
                   " WHERE DZEF001 = '",ls_main_table,"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
      
      #欄位規格設計資料檔
      LET ls_sql = "DELETE FROM DZEP_T ", 
                   " WHERE DZEP001 = '",ls_main_table,"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
      
      #樹狀結構設定檔
      LET ls_sql = "DELETE FROM DZEQ_T ", 
                   " WHERE DZEQ001 = '",ls_main_table,"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
      
      #多語言關聯設定檔 
      LET ls_sql = "DELETE FROM DZER_T ", 
                   " WHERE DZER001 = '",ls_main_table,"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
      
      #助記碼設定檔 
      LET ls_sql = "DELETE FROM DZET_T ", 
                   " WHERE DZET001 = '",ls_main_table,"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)

      #權限設定檔 
      LET ls_sql = "DELETE FROM DZEN_T ", 
                   " WHERE DZEN001 = '",ls_main_table,"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
      
      #資料表主檔多語言檔 
      LET ls_sql = "DELETE FROM DZEAL_T ", 
                   " WHERE DZEAL001 = '",ls_main_table,"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)

      #刪除序號檔
      LET ls_sql = "DELETE FROM DZEO_T ", 
                   " WHERE DZEO001 = '",ls_main_table.toUpperCase(),"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)

      #刪除表格.同義字設定檔
      LET ls_sql = "DELETE FROM DZEU_T                                ", 
                   " WHERE DZEU001 = '",ls_main_table.toLowerCase(),"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)

      #刪除表格快照檔
      LET ls_sql = "DELETE FROM DZEV_T                                ", 
                   " WHERE DZEV001 = '",ls_master_user.toUpperCase(),"'",
                   "   AND DZEV002 = '",ls_main_table.toUpperCase(),"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
      
      #刪除鍵/索引快照檔
      LET ls_sql = "DELETE FROM DZEW_T                                ", 
                   " WHERE DZEW001 = '",ls_main_table.toLowerCase(),"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
      
      #刪除狀態設定檔
      LET ls_sql = "DELETE FROM GZCC_T                                ", 
                   " WHERE GZCC001 = '",ls_main_table.toLowerCase(),"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
      
      #版本設定檔
      LET ls_sql = "DELETE FROM DZAF_T                                 ", 
                   " WHERE DZAF001 = '",ls_main_table.toLowerCase(),"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)

      #ALM資料檔
      LET ls_sql = "DELETE FROM DZLM_T                                 ", 
                   " WHERE DZLM002 = '",ls_main_table.toLowerCase(),"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)

      #Key欄位賦予值檔
      LET ls_sql = "DELETE FROM DZIG_T                                 ", 
                   " WHERE DZIG001 = '",ls_main_table.toLowerCase(),"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
      
      #資料表主檔(最後才刪)
      LET ls_sql = "DELETE FROM DZEA_T ", 
                   " WHERE DZEA001 = '",ls_main_table,"' "
      CALL sadzi140_db_exec_SQL(ls_sql,FALSE)

    END IF  
  END IF    

  LABEL _return:
  
  LET lb_return = lb_drop_table

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_util_gen_multi_lang(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name   STRING,
  ls_command      STRING,
  ls_program_name STRING,
  lb_success      BOOLEAN,
  ls_message      STRING  

  LET ls_table_name = p_table_name

  LET ls_program_name = "adzp140"
  
  LET ls_command = "r.r ",ls_program_name," ",ls_table_name CLIPPED
  DISPLAY cs_command_tag,ls_command

  &ifndef DEBUG
  DISPLAY cs_information_tag," Call ",ls_program_name," generate language files."
  IF sadzi140_util_check_program_exists(ls_program_name) THEN 
    CALL cl_cmdrun_openpipe(ls_program_name,ls_command,TRUE) RETURNING lb_success,ls_message
  END IF  
  &endif

END FUNCTION

FUNCTION sadzi140_util_gen_extend_inc(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name   STRING,
  ls_command      STRING,
  ls_program_name STRING,
  lb_success      BOOLEAN,
  ls_message      STRING  

  LET ls_table_name = p_table_name

  LET ls_program_name = "adzp156"
  LET lb_success = TRUE
  
  LET ls_command = "r.r ",ls_program_name," ",ls_table_name CLIPPED
  DISPLAY cs_command_tag,ls_command

  &ifndef DEBUG
  IF sadzi140_util_check_program_exists(ls_program_name) THEN 
    RUN ls_command WITHOUT WAITING
    #CALL cl_cmdrun_openpipe(ls_program_name,ls_command,TRUE) RETURNING lb_success,ls_message
  END IF  
  &endif

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzi140_util_recompile_invalid_db_objects(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name   STRING,
  ls_command      STRING,
  ls_program_name STRING,
  lb_success      BOOLEAN,
  ls_message      STRING  

  LET ls_table_name = p_table_name

  LET ls_program_name = "adzp320"
  LET lb_success = TRUE
  
  LET ls_command = "r.r ",ls_program_name," -T ",ls_table_name CLIPPED
  DISPLAY cs_command_tag,ls_command

  &ifndef DEBUG
  IF sadzi140_util_check_program_exists(ls_program_name) THEN 
    RUN ls_command WITHOUT WAITING
    #CALL cl_cmdrun_openpipe(ls_program_name,ls_command,TRUE) RETURNING lb_success,ls_message
  END IF  
  &endif

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzi140_util_collect_affect_prog_list(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name   STRING,
  ls_command      STRING,
  lo_channel      base.Channel,
  ls_data_line    STRING,
  li_index        INTEGER,
  lb_success      BOOLEAN,
  ls_program_name STRING,
  ls_msg_number   STRING,
  ls_replace_arg  STRING,
  ls_message      STRING  

  LET ls_table_name = p_table_name

  LET ls_program_name = "adzp144"
  
  IF sadzi140_util_check_program_exists(ls_program_name) THEN 
    LET ls_command = "r.r ",ls_program_name," ",ls_table_name," 2>&1"
    DISPLAY cs_command_tag,ls_command

    LET lo_channel = base.Channel.create()
    CALL lo_channel.setDelimiter("")
    CALL lo_channel.openPipe(ls_command,"r") #執行指令

    WHILE TRUE
      CALL lo_channel.readLine() RETURNING ls_data_line
      IF lo_channel.isEof() THEN
        EXIT WHILE
      END IF

      DISPLAY ls_data_line #顯示背景訊息
      LET li_index = ls_data_line.getIndexOf("NEEDREGEN", 1)
      IF li_index > 0 THEN
        LET ls_data_line = ls_data_line.subString(li_index + 10, ls_data_line.getLength())

        &ifndef DEBUG
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = "adz-00779"
        LET g_errparam.replace[1] = ls_table_name
        LET g_errparam.replace[2] = ls_data_line
        LET g_errparam.popup = TRUE
        CALL cl_err()
        &endif
        
        EXIT WHILE
      END IF
    END WHILE

    CALL lo_channel.close()
    
  END IF  

END FUNCTION

FUNCTION sadzi140_util_kill_snapshot(p_master_db,p_table_name,p_version_info)
DEFINE
  p_master_db    STRING,
  p_table_name   STRING,
  p_version_info T_VERSION_INFO
DEFINE
  ls_master_db    STRING,
  ls_table_name   STRING,
  lo_version_info T_VERSION_INFO,
  lb_success      BOOLEAN
  
  
  LET ls_master_db  = p_master_db 
  LET ls_table_name = p_table_name
  LET lo_version_info.* = p_version_info.*

  LET lb_success = TRUE

  BEGIN WORK
  
  CALL sadzi140_shot_delete_table_shot_data(ls_master_db,ls_table_name,lo_version_info.*) RETURNING lb_success
  IF NOT lb_success THEN GOTO _check_error END IF 
  CALL sadzi140_shot_delete_constraint_index_shot_data(ls_table_name,lo_version_info.*) RETURNING lb_success
  IF NOT lb_success THEN GOTO _check_error END IF 

  LABEL _check_error:
  IF NOT lb_success THEN
    ROLLBACK WORK
  ELSE
    COMMIT WORK
  END IF 
  
  RETURN lb_success
  
END FUNCTION

#更新欄位所使用的元件組設定(Oracle 專用)
FUNCTION sadzi140_util_oracle_update_dzeb022()
DEFINE
  ls_sql STRING
  
  # 更新為共用欄位
  LET ls_sql = "update dzeb_t ebx                                                                                           ",
               "   set ebx.dzeb022 = (                                                                                      ",
               "                      select ek.dzek001                                                                     ",
               "                        from dzeb_t eb, dzek_t ek                                                           ",
               "                       where 1=1                                                                            ",
               "                         and (ek.dzek002 = substrb(eb.dzeb002,5,4) OR ek.dzek002 = substrb(eb.dzeb002,6,4)) ",  
               "                         and eb.dzeb001 = ebx.dzeb001                                                       ",
               "                         and eb.dzeb002 = ebx.dzeb002                                                       ",
               "                    )                                                                                       ",
               " where 1=1                                                                                                  ",
               "   and TRANSLATE(substrb(ebx.dzeb002,5,4), ' +-.0123456789', ' ') IS not NULL                               ",
               "   and length(TRANSLATE(substrb(ebx.dzeb002,5,4), ' +-.0123456789', ' ')) > 1                               ",
               "   and ebx.dzeb001 <> 'type_t'                                                                              ",
               "   and ebx.dzeb022 is null                                                                                  "
               
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)

  # 更新為序號欄位
  LET ls_sql = "update dzeb_t eb                                                         ",
               "   set eb.dzeb022 = 'cdfSerialNumber'                                    ",
               " where 1=1                                                               ",
               "   and (                                                                 ",
               "        TRANSLATE(substrb(eb.dzeb002,5,4), ' +-.0123456789', ' ') IS NULL",
               "        OR                                                               ",
               "        TRANSLATE(substrb(eb.dzeb002,6,4), ' +-.0123456789', ' ') IS NULL",
               "       )                                                                 ",
               "   and eb.dzeb001 <> 'type_t'                                            ",
               "   and eb.dzeb022 is null                                                "
               
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
  
END FUNCTION

FUNCTION sadzi140_util_trim_str(p_string)
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

FUNCTION sadzi140_util_get_table_pre_name(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  li_loop           INTEGER,
  ls_table_char     STRING, 
  ls_table_name     STRING,
  ls_table_pre_name STRING
DEFINE
  ls_return STRING  

  LET ls_table_name     = p_table_name
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

#匯入SCO前刪除 Table 相關資料
FUNCTION sadzi140_util_sco_delete_data(p_master_user,p_table_name)
DEFINE
  p_master_user    STRING,
  p_table_name     STRING
DEFINE 
  ls_master_user   STRING,
  ls_table_name    STRING,
  ls_table_columns STRING,
  ls_sql           STRING

  LET ls_master_user = p_master_user
  LET ls_table_name  = p_table_name
  
  IF ls_table_name.getIndexOf("_",1) > 0 THEN
    LET ls_table_columns = ls_table_name.subString(1,ls_table_name.getIndexOf("_",1)-1)
  ELSE
    LET ls_table_columns = ls_table_name.subString(1,ls_table_name.getLength())
  END IF  
  
  #資料表欄位多語言檔(需存在於DZEB_T)
  LET ls_sql = "DELETE FROM DZEBL_T ",
               " WHERE DZEBL001 LIKE '",ls_table_columns,"%'"
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
  
  #資料表欄位檔
  LET ls_sql = "DELETE FROM DZEB_T ", 
               " WHERE DZEB001 = '",ls_table_name,"'"
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)                   
  
  #資料表索引檔
  LET ls_sql = "DELETE FROM DZEC_T ", 
               " WHERE DZEC001 = '",ls_table_name,"' "
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)        
  
  #資料表鍵值檔
  LET ls_sql = "DELETE FROM DZED_T ", 
               " WHERE DZED001 = '",ls_table_name,"' "
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)        
  
  #資料表欄位參考檔
  LET ls_sql = "DELETE FROM DZEF_T ", 
               " WHERE DZEF001 = '",ls_table_name,"' "
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
  
  #欄位規格設計資料檔
  LET ls_sql = "DELETE FROM DZEP_T ", 
               " WHERE DZEP001 = '",ls_table_name,"' "
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
  
  #樹狀結構設定檔
  LET ls_sql = "DELETE FROM DZEQ_T ", 
               " WHERE DZEQ001 = '",ls_table_name,"' "
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
  
  #多語言關聯設定檔 
  LET ls_sql = "DELETE FROM DZER_T ", 
               " WHERE DZER001 = '",ls_table_name,"' "
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
  
  #助記碼設定檔 
  LET ls_sql = "DELETE FROM DZET_T ", 
               " WHERE DZET001 = '",ls_table_name,"' "
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)

  #權限設定檔 
  LET ls_sql = "DELETE FROM DZEN_T ", 
               " WHERE DZEN001 = '",ls_table_name,"' "
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
  
  #刪除序號檔
  LET ls_sql = "DELETE FROM DZEO_T ", 
               " WHERE DZEO001 = '",ls_table_name.toUpperCase(),"' "
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)

  #刪除表格快照檔
  LET ls_sql = "DELETE FROM DZEV_T                                ", 
               " WHERE DZEV001 = '",ls_master_user.toUpperCase(),"'",
               "   AND DZEV002 = '",ls_table_name.toUpperCase(),"' "
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
  
  #刪除鍵/索引快照檔
  LET ls_sql = "DELETE FROM DZEW_T                                ", 
               " WHERE DZEW001 = '",ls_table_name.toLowerCase(),"' "
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
  
  #刪除狀態設定檔
  LET ls_sql = "DELETE FROM GZCC_T                                ", 
               " WHERE GZCC001 = '",ls_table_name.toLowerCase(),"' "
  CALL sadzi140_db_exec_SQL(ls_sql,FALSE)
    
END FUNCTION

#表格重建函式
FUNCTION sadzi140_util_table_rebuild(p_master_user,p_table_name,p_batch_mode,p_alm_version)
DEFINE 
  p_master_user STRING,
  p_table_name  STRING,
  p_batch_mode  BOOLEAN,
  p_alm_version STRING
DEFINE 
  ls_master_user  STRING,
  ls_table_name   STRING,
  lb_batch_mode   BOOLEAN,
  ls_alm_version  STRING,
  ls_rbtb_name    STRING,
  lb_exists       BOOLEAN,
  ls_replace_arg  STRING,
  ls_question     STRING,
  lb_diff         BOOLEAN, 
  lb_table_lock   BOOLEAN,
  ls_lock_user_name STRING,
  li_loop         INTEGER,
  ls_message      STRING,
  ls_all_message  STRING,
  ls_sql_script   STRING,
  lb_error        BOOLEAN,
  ls_multi_cols   STRING,
  ls_cursor_cols  STRING,
  ls_reb_table    STRING,
  ls_error        STRING,
  ls_parameter    STRING,
  ls_msg_number   STRING,
  li_columnid_rec INTEGER,
  lb_more_one_record       BOOLEAN,
  ls_drop_script_name      STRING,
  ls_rebuild_script_name   STRING,
  ls_move_data_script_name STRING,
  lo_table_in_db_type      DYNAMIC ARRAY OF T_TABLE_IN_DB_TYPE,
  lo_db_connstr            T_DB_CONNSTR,
  lo_create_table          T_DZEA_CREATE_TABLE
DEFINE 
  ls_rtn_code    STRING,
  ls_rtn_message STRING,
  lb_return      BOOLEAN  

  LET ls_master_user = p_master_user
  LET ls_table_name  = p_table_name
  LET lb_batch_mode  = p_batch_mode
  LET ls_alm_version = p_alm_version
  
  LET lb_return      = TRUE
  LET ls_rtn_code    = "1"
  LET lb_error       = FALSE 
  LET ls_question    = cs_question_yes
  LET ls_rbtb_name   = ls_table_name,cs_rebuild_tail
  LET ls_all_message = ""
  
  LET lo_create_table.dct_master_user = p_master_user
  LET lo_create_table.dct_table_name  = p_table_name

  #檢核是否強迫重建
  CALL sadzi140_db_get_parameter(cs_param_level_rebuild,cs_param_enable_force_rebuild) RETURNING ls_parameter
  IF ls_parameter = "N" THEN  
    #檢核是否需要重建
    CALL sadzi140_db_get_column_id_status(ls_master_user,ls_table_name) RETURNING li_columnid_rec 
    IF li_columnid_rec = 0 THEN
      LET lb_error = FALSE
      LET ls_rtn_code = "0"
      LET ls_msg_number = "adz-00173"
      IF NOT lb_batch_mode THEN
        LET ls_replace_arg = ls_table_name,"|"
        CALL sadzp000_msg_show_error(NULL, ls_msg_number, ls_replace_arg, 1)
      ELSE
        LET ls_message = "[",ls_msg_number,"] Table ",ls_table_name," not need to modify."
        LET ls_all_message = ls_all_message,"\n",
                             cs_error_tag,ls_message 
        DISPLAY ls_message
      END IF  
      GOTO _return 
    END IF
  END IF  

  #非批次模式才執行表格存在與否的詢問(重建表格的備份資料存在, 確定要重新抓取並重建嗎 ?)
  IF NOT lb_batch_mode THEN
    CALL sadzi140_db_check_table_exists(ls_rbtb_name) RETURNING lb_exists
    IF lb_exists THEN
      LET ls_replace_arg = ls_table_name,"|"
      CALL sadzp000_msg_question_box(NULL, "adz-00138", ls_replace_arg, 0) RETURNING ls_question
      IF ls_question = cs_question_no THEN 
        LET lb_error = FALSE
        LET ls_rtn_code = "0"
        GOTO _return 
      END IF
    END IF
  END IF
  
  #取得表格是否有資料, 若有資料則不可以執行重建
  CALL sadzi140_db_get_parameter(cs_param_level_rebuild,cs_param_check_data_exists) RETURNING ls_parameter
  IF ls_parameter = "Y" THEN
    CALL sadzi140_db_get_more_one_record_from_all_tables(ls_table_name) RETURNING lb_more_one_record
    IF lb_more_one_record THEN
      LET lb_error = TRUE
      LET ls_rtn_code = "-1"
      LET ls_msg_number = "adz-00168"
      IF NOT lb_batch_mode THEN
        LET ls_replace_arg = ls_table_name,"|"
        CALL sadzp000_msg_show_error(NULL, ls_msg_number, ls_replace_arg, 1)
      ELSE
        LET ls_message = "[",ls_msg_number,"] Table ",ls_table_name," include datas, can not rebuild."
        LET ls_all_message = ls_all_message,"\n",
                             cs_error_tag,ls_message 
        DISPLAY ls_message
      END IF  
      GOTO _return
    END IF
  END IF

  #進行表格資料搬移相關檢核(尚未實做)
  CALL sadzi140_db_get_parameter(cs_param_level_rebuild,cs_param_enable_data_moving) RETURNING ls_parameter
  IF ls_parameter = "Y" THEN
  END IF 
  
  #檢核欄位和索引與實際表格有沒有差異
  CALL sadzi140_shot_check_diff(ls_master_user,ls_table_name,TRUE) RETURNING lb_diff
  IF lb_diff THEN
    LET lb_error = TRUE
    LET ls_rtn_code = "-1"
    LET ls_msg_number = "adz-00135"
    IF NOT lb_batch_mode THEN
      LET ls_replace_arg = ""
      CALL sadzp000_msg_show_error(NULL, ls_msg_number, ls_replace_arg, 1)
    ELSE
      LET ls_message = "[",ls_msg_number,"] Real table ",ls_table_name," columns are different from design datas."
      LET ls_all_message = ls_all_message,"\n",
                           cs_error_tag,ls_message 
      DISPLAY ls_message
    END IF   
    GOTO _return        
  END IF
  
  #檢核表格有無被鎖定
  CALL sadzi140_db_check_table_lock(ls_table_name) RETURNING lb_table_lock,ls_lock_user_name
  IF lb_table_lock THEN
    LET lb_error = TRUE
    LET ls_rtn_code = "-1"
    LET ls_msg_number = "adz-00136"
    IF NOT lb_batch_mode THEN
      LET ls_replace_arg = ls_table_name,"|",ls_lock_user_name,"|"
      CALL sadzp000_msg_show_error(NULL, ls_msg_number, ls_replace_arg, 1)
    ELSE
      LET ls_message = "[",ls_msg_number,"] Table ",ls_table_name," locked by ",ls_lock_user_name,"."
      LET ls_all_message = ls_all_message,"\n",
                           cs_error_tag,ls_message 
      DISPLAY ls_message
    END IF   
    GOTO _return        
  END IF      

  ------------------------------------------------------------------------------
  -- 開始執行表格重建
  ------------------------------------------------------------------------------

  #取得表格在DB中是 Table or Synonym
  CALL sadzi140_db_get_table_in_db_type(ls_table_name,cs_order_by_desc) RETURNING lo_table_in_db_type

  #先備份原先表格
  FOR li_loop = 1 TO lo_table_in_db_type.getLength()
    CALL sadzi140_db_get_db_connect_string(lo_table_in_db_type[li_loop].tidt_db) RETURNING lo_db_connstr.*

    #若為表格, 則產生Rebuild Table Script file
    IF lo_table_in_db_type[li_loop].tidt_object_type = "T" THEN
      CALL sadzi140_db_gen_rebuild_script(ls_table_name) RETURNING ls_rebuild_script_name
    ELSE 
      CALL sadzi140_db_get_create_synonym_sql(lo_db_connstr.*,lo_create_table.*) RETURNING ls_sql_script
      CALL sadzi140_rev_gen_sql_script_file(ls_sql_script,cs_create_synonym) RETURNING ls_rebuild_script_name
    END IF
    
    LET lo_db_connstr.db_sql_filename = ls_rebuild_script_name
    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
      CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Backup original table data.","\n", 
                           "User : ",lo_db_connstr.db_username,"\n",
                           "Version : ",lo_db_connstr.db_version,"\n",
                           ls_message
    END IF     

    LET ls_error = ls_message.toUpperCase()
    IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
      LET lb_error = TRUE
      LET ls_rtn_code = "-1"
      EXIT FOR
    END IF    

  END FOR
  IF lb_error THEN GOTO _check_error END IF   

  #進行異動
  CALL sadzi140_util_make_alter_table(ls_master_user,ls_table_name,TRUE) RETURNING lb_error,ls_message
  LET ls_all_message = ls_all_message,"\n",
                       ls_message
  LET ls_error = ls_message.toUpperCase()
  IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_error = TRUE
    LET ls_rtn_code = "-1"
  END IF    
  IF lb_error THEN GOTO _check_error END IF   

  #進行表格資料搬移
  CALL sadzi140_db_get_parameter(cs_param_level_rebuild,cs_param_enable_data_moving) RETURNING ls_parameter
  IF ls_parameter = "Y" THEN
    FOR li_loop = 1 TO lo_table_in_db_type.getLength()
      CALL sadzi140_db_get_db_connect_string(lo_table_in_db_type[li_loop].tidt_db) RETURNING lo_db_connstr.*
      IF lo_table_in_db_type[li_loop].tidt_object_type = "T" THEN
        LET ls_reb_table = ls_table_name,cs_rebuild_tail
        CALL sadzi140_db_get_table_columns(lo_db_connstr.db_username,ls_table_name,"r_datas") RETURNING ls_multi_cols,ls_cursor_cols
        CALL sadzi140_db_gen_move_data_script(ls_table_name,ls_reb_table,ls_multi_cols,ls_cursor_cols) RETURNING ls_move_data_script_name

        LET lo_db_connstr.db_sql_filename = ls_move_data_script_name
        IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
          CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
          LET ls_all_message = ls_all_message,"\n",
                               "Process :","Moving data.","\n", 
                               "User : ",lo_db_connstr.db_username,"\n",
                               "Version : ",lo_db_connstr.db_version,"\n",
                               ls_message
        END IF        
      END IF
      LET ls_error = ls_message.toUpperCase()
      IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
        LET lb_error = TRUE
        LET ls_rtn_code = "-1"
        EXIT FOR
      END IF    
    END FOR 
  END IF   
  IF lb_error THEN GOTO _check_error END IF   

  #刪除備份表格
  CALL sadzi140_db_get_parameter(cs_param_level_rebuild,cs_param_drop_backup_table) RETURNING ls_parameter
  IF ls_parameter = "Y" THEN
    FOR li_loop = 1 TO lo_table_in_db_type.getLength()
      CALL sadzi140_db_get_db_connect_string(lo_table_in_db_type[li_loop].tidt_db) RETURNING lo_db_connstr.*
      IF lo_table_in_db_type[li_loop].tidt_object_type = "T" THEN
        CALL sadzi140_db_gen_drop_script(ls_rbtb_name,"T") RETURNING ls_drop_script_name
        
        LET lo_db_connstr.db_sql_filename = ls_drop_script_name
        IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
          CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
          LET ls_all_message = ls_all_message,"\n",
                               "Process :","Drop backup table : ",ls_rbtb_name,"\n", 
                               "User : ",lo_db_connstr.db_username,"\n",
                               "Version : ",lo_db_connstr.db_version,"\n",
                               ls_message
        END IF        
      END IF
      LET ls_error = ls_message.toUpperCase()
      IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
        LET lb_error = TRUE
        LET ls_rtn_code = "-1"
        EXIT FOR
      END IF    
    END FOR
  END IF    
  IF lb_error THEN GOTO _check_error END IF   

  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------

  LABEL _check_error:

  LET ls_error = ls_all_message.toUpperCase()
  IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_error = TRUE
    LET ls_rtn_code = "-1"
    LET ls_msg_number = "adz-00167"
    IF NOT lb_batch_mode THEN
      CALL sadzp000_msg_show_error(NULL, ls_msg_number, NULL, 1)
      CALL sadzi140_rev_view_logresult(ls_all_message)
    ELSE
      DISPLAY "[",ls_msg_number,"] Rebuild ERROR !!","\n",ls_all_message
    END IF
  ELSE   
    LET ls_msg_number = "adz-00169"
    LET ls_replace_arg = ls_table_name,"|"
    IF NOT lb_batch_mode THEN
      CALL sadzp000_msg_show_info(NULL, ls_msg_number, ls_replace_arg, 0)
    ELSE
      DISPLAY "[",ls_msg_number,"] Rebuild success."
    END IF   
  END IF  

  &ifdef DEBUG
  #CALL sadzi140_rev_view_logresult(ls_all_message)
  &endif
  
  LABEL _return:
  
  LET lb_return = NOT lb_error
  LET ls_rtn_message = ls_all_message
  
  RETURN lb_return,ls_rtn_code,ls_all_message
  
END FUNCTION

FUNCTION sadzi140_util_get_table_leading_code(p_table_name)
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

#取得共用欄位的預設值
FUNCTION sadzi140_util_get_common_fields(p_common_fields)
DEFINE
  p_common_fields  DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(50)
DEFINE
  lo_common_fields  DYNAMIC ARRAY OF T_COMMON_FIELD
DEFINE  
  ls_sql      STRING,
  li_rec_cnt  INTEGER

  LET ls_sql = "SELECT EJP.DZEJ003                       COMMON_DEFINE, ",
               "       EK.DZEK002                        COMMON_FIELD,  ",
               "       REPLACE(EJP.DZEJ004,'''','''''')  DZEP018,       ",
               "       REPLACE(EJF.DZEJ004,'''','''''')  DZEF003,       ",
               "       REPLACE(EJF.DZEJ005,'''','''''')  DZEF006,       ",
               "       REPLACE(EJF.DZEJ006,'''','''''')  DZEF007,       ",
               "       REPLACE(EJF.DZEJ007,'''','''''')  DZEF009,       ",
               "       REPLACE(EJF.DZEJ008,'''','''''')  DZEF008        ",
               "  FROM DZEJ_T EJP,DZEJ_T EJF,DZEK_T EK                  ",
               " WHERE EJP.DZEJ001 = 'adzi150_dzep_std'                 ",
               "   AND EJF.DZEJ001 = 'adzi150_dzef_std'                 ",
               "   AND EJP.DZEJ002 = EJF.DZEJ002                        ",
               "   AND EJP.DZEJ003 = EJF.DZEJ003                        ",
               "   AND EK.DZEK001  = EJP.DZEJ003                        "

  PREPARE lpre_get_common_fields FROM ls_sql
  DECLARE lcur_get_common_fields CURSOR FOR lpre_get_common_fields

  LET li_rec_cnt = 1 
  CALL p_common_fields.clear()
  
  OPEN lcur_get_common_fields
  FOREACH lcur_get_common_fields INTO lo_common_fields[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET p_common_fields[li_rec_cnt,1] = lo_common_fields[li_rec_cnt].COMMON_DEFINE
    LET p_common_fields[li_rec_cnt,2] = lo_common_fields[li_rec_cnt].COMMON_FIELD 
    LET p_common_fields[li_rec_cnt,3] = lo_common_fields[li_rec_cnt].DZEP018      
    LET p_common_fields[li_rec_cnt,4] = lo_common_fields[li_rec_cnt].DZEF003      
    LET p_common_fields[li_rec_cnt,5] = lo_common_fields[li_rec_cnt].DZEF006      
    LET p_common_fields[li_rec_cnt,6] = lo_common_fields[li_rec_cnt].DZEF007      
    LET p_common_fields[li_rec_cnt,7] = lo_common_fields[li_rec_cnt].DZEF009      
    LET p_common_fields[li_rec_cnt,8] = lo_common_fields[li_rec_cnt].DZEF008       
    
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_common_fields
    
  FREE lpre_get_common_fields
  FREE lcur_get_common_fields  

END FUNCTION

FUNCTION sadzi140_util_get_program_title(p_program,p_lang)
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
  
  LET ls_sql = "SELECT ZAL.GZZAL003||'('||ZA.GZZA001||')'  PROGRAM_TITLE      ",
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

FUNCTION sadzi140_util_export_table_schema(p_table_name,p_lang,p_construct_ver,p_sd_ver,p_request_no,p_sequence_no)
DEFINE
  p_table_name     STRING,
  p_lang           STRING,
  p_construct_ver  STRING,
  p_sd_ver         STRING,
  p_request_no     STRING,
  p_sequence_no    STRING  
DEFINE
  ls_table_name       STRING,
  ls_lang             STRING,  
  ls_construct_ver    STRING,
  ls_sd_ver           STRING, 
  ls_request_no       STRING, 
  ls_sequence_no      STRING,  
  ls_export_path      STRING,
  ls_export_desc      STRING,
  ls_export_title     STRING,
  li_CHDIR            INTEGER,
  lo_export_parameter T_DZLM_T_SCR,
  lo_export_info      T_EXPORT_INFO,
  lo_exec_result      T_EXEC_RESULT,
  lo_file_dialog      T_FILE_DIALOG,
  lo_putfile_para     T_PUT_GET_FILE_PARA,  
  lo_base_table_info  T_BASE_TABLE_INFO

  LET ls_table_name    = p_table_name
  LET ls_lang          = p_lang
  LET ls_construct_ver = p_construct_ver
  LET ls_sd_ver        = p_sd_ver
  LET ls_request_no    = p_request_no
  LET ls_sequence_no   = p_sequence_no
  
  LET ls_export_path = os.Path.pwd()
  CALL sadzi140_exim_reset_parameters() 
  CALL sadzp000_msg_get_message('adz-00224',ls_lang) RETURNING ls_export_desc
  CALL sadzp000_msg_get_message('adz-00225',ls_lang) RETURNING ls_export_title
  CALL sadzi140_exim_get_parameter(cs_exim_export,ls_table_name,ls_construct_ver,ls_sd_ver,ls_request_no,ls_sequence_no) RETURNING lo_export_parameter.*
  CALL sadzi140_exim_run(FALSE,lo_export_parameter.*) RETURNING lo_export_info.*,lo_exec_result.*
  CALL sadzi140_dlg_set_dialog_parameter(ls_export_path,ls_export_desc,cs_export_import_all_file,ls_export_title) RETURNING lo_file_dialog.*
  CALL sadzi140_dlg_save_dir_dialog(lo_file_dialog.*) RETURNING lo_export_info.CLIENT_PATH
  CALL sadzi140_exim_set_putfile_parameter(lo_export_info.WORKING_PATH,lo_export_info.TAR_NAME,lo_export_info.CLIENT_PATH,lo_export_info.TAR_NAME) RETURNING lo_putfile_para.*
  IF NVL(lo_putfile_para.CLIENT_FILE_PATH,cs_null_value) <> cs_null_value THEN
    CALL sadzi140_exim_save_to_client(lo_putfile_para.*)
    CALL sadzp000_msg_show_info(NULL, 'adz-00228', NULL, 0)
  END IF   
  CALL sadzi140_exim_reset_parameters()

  #返回原路徑  
  CALL os.Path.chdir(ls_export_path) RETURNING li_CHDIR  
      
END FUNCTION

FUNCTION sadzi140_util_import_table_schema(p_master_user,p_lang)
DEFINE
  p_master_user    STRING,   
  p_lang           STRING
DEFINE
  ls_master_user      STRING,   
  ls_lang             STRING,  
  ls_orig_path        STRING,
  lb_result           BOOLEAN,
  lb_imp_result       BOOLEAN,
  ls_message          STRING,
  lo_getfile_para     T_PUT_GET_FILE_PARA,
  lo_tar_file_info    T_TAR_FILE_INFO
DEFINE
  lb_return BOOLEAN,
  ls_return STRING  

  LET ls_master_user = p_master_user
  LET ls_lang        = p_lang

  LET lb_return = TRUE
  LET lb_result = TRUE

  LET ls_orig_path = os.Path.pwd()
  CALL sadzi140_exim_reset_parameters() 

  CALL sadzi140_util_catch_table_pkg_to_server(ls_lang) RETURNING lb_result,lo_getfile_para.*,lo_tar_file_info.*
  IF lb_result THEN
    DISPLAY cs_information_tag,"Start to import and alter table." 
    CALL sadzi140_util_import_and_alter_table(ls_master_user,ls_lang,lo_getfile_para.*,lo_tar_file_info.*) RETURNING lb_imp_result
    IF NOT lb_result THEN
      DISPLAY cs_error_tag,"Import and alter table failed !!"
    END IF 
  ELSE   
    DISPLAY cs_warning_tag,"Catch table package from client to server failed or no select any file." 
  END IF  
  
  CALL sadzi140_exim_reset_parameters()

  #返回原路徑  
  CALL os.Path.chdir(ls_orig_path) RETURNING lb_result  

  LET lb_return = lb_imp_result
  LET ls_return = lo_tar_file_info.TABLE_NAME

  RETURN lb_return,ls_return
  
END FUNCTION

FUNCTION sadzi140_util_catch_table_pkg_to_server(p_lang)
DEFINE
  p_lang STRING
DEFINE
  ls_lang             STRING,  
  ls_import_path      STRING,
  ls_import_desc      STRING,
  ls_import_title     STRING,
  ls_clinet_path_name STRING,
  lb_success          BOOLEAN,
  lb_result           BOOLEAN,
  lo_import_info      T_EXPORT_INFO,
  lo_file_dialog      T_FILE_DIALOG,
  lo_getfile_para     T_PUT_GET_FILE_PARA,
  lo_tar_file_info    T_TAR_FILE_INFO
DEFINE
  lb_return  BOOLEAN

  LET ls_lang = p_lang

  LET lb_success = TRUE
  LET lb_return  = TRUE
  LET lb_result  = FALSE
  
  CALL sadzp000_msg_get_message('adz-00224',ls_lang) RETURNING ls_import_desc
  CALL sadzp000_msg_get_message('adz-00226',ls_lang) RETURNING ls_import_title
  CALL sadzi140_dlg_set_dialog_parameter(ls_import_path,ls_import_desc,cs_export_import_all_file,ls_import_title) RETURNING lo_file_dialog.*
  CALL sadzi140_dlg_open_file_dialog(lo_file_dialog.*) RETURNING ls_clinet_path_name
  IF NVL(ls_clinet_path_name,cs_null_value) <> cs_null_value THEN 
    CALL sadzi140_exim_parse_client_full_name(ls_clinet_path_name,lo_import_info.*) RETURNING lo_import_info.*
    CALL sadzi140_exim_parse_tar_file_info(lo_import_info.TAR_NAME) RETURNING lo_tar_file_info.*
    CALL sadzi140_exim_get_server_working_path(lo_tar_file_info.TABLE_NAME) RETURNING lb_success,lo_import_info.WORKING_PATH
    CALL sadzi140_exim_set_getfile_parameter(lo_import_info.CLIENT_PATH,lo_import_info.TAR_NAME,lo_import_info.WORKING_PATH,lo_import_info.TAR_NAME) RETURNING lo_getfile_para.*
    IF NVL(lo_getfile_para.CLIENT_FILE_NAME,cs_null_value) <> cs_null_value THEN
      CALL sadzi140_exim_catch_to_server(lo_getfile_para.*) RETURNING lb_result
      IF lb_result THEN
        DISPLAY cs_success_tag,"Catch client file to server succeeded."  
      ELSE
        DISPLAY cs_error_tag,"Catch client file to server failed."  
      END IF
    ELSE 
      DISPLAY cs_warning_tag,"Client file not selected."  
    END IF   
  END IF   

  LET lb_return = lb_result  
  
  RETURN lb_return,lo_getfile_para.*,lo_tar_file_info.*
  
END FUNCTION

FUNCTION sadzi140_util_import_and_alter_table(p_master_user,p_lang,p_put_get_file_para,p_tar_file_info)
DEFINE
  p_master_user        STRING,
  p_lang               STRING,
  p_put_get_file_para  T_PUT_GET_FILE_PARA,   
  p_tar_file_info      T_TAR_FILE_INFO
DEFINE
  ls_master_user        STRING,
  ls_lang               STRING,
  lo_put_get_file_para  T_PUT_GET_FILE_PARA,
  lo_tar_file_info      T_TAR_FILE_INFO,
  ls_message            STRING,
  lb_diff               BOOLEAN,
  lb_result             BOOLEAN,
  ls_file_name          STRING,
  ls_replace_arg        STRING,
  ls_question           STRING,
  ls_msg_code           STRING,
  lo_import_parameter   T_DZLM_T_SCR,
  lo_exec_result        T_EXEC_RESULT,
  lo_import_info        T_EXPORT_INFO
DEFINE
  lb_return BOOLEAN  

  LET ls_master_user         = p_master_user
  LET ls_lang                = p_lang
  LET lo_put_get_file_para.* = p_put_get_file_para.*
  LET lo_tar_file_info.*     = p_tar_file_info.*
  
  LET lb_return = FALSE
  LET lb_diff = FALSE
  LET ls_question = cs_question_no
    
  CALL os.Path.chdir(lo_put_get_file_para.SERVER_FILE_PATH) RETURNING lb_result

  #檢核資料(和設計資料比對)
  CALL sadzi140_exim_get_parameter(cs_exim_verify,lo_tar_file_info.TABLE_NAME,lo_tar_file_info.CONSTRUCT_VERSION,lo_tar_file_info.SD_VERSION,lo_tar_file_info.REQUEST_NO,lo_tar_file_info.SEQUENCE_NO) RETURNING lo_import_parameter.*
  CALL sadzi140_exim_set_module_parameters(cs_exim_verify,lo_tar_file_info.TABLE_NAME,lo_tar_file_info.CONSTRUCT_VERSION,lo_tar_file_info.SD_VERSION,lo_tar_file_info.REQUEST_NO,lo_tar_file_info.SEQUENCE_NO)
  CALL sadzi140_exim_run(FALSE,lo_import_parameter.*) RETURNING lo_import_info.*,lo_exec_result.*
  
  #如果比對有差異
  IF lo_exec_result.er_RESULT THEN
    LET lb_diff = lo_exec_result.er_RESULT
    DISPLAY cs_information_tag,"There are something different with design data and import data !!" 
  ELSE
    #表格 xxxx 設計資料與匯入資料沒有差異, 您要進行異動嗎 ?
    LET ls_msg_code = "adz-00868"
    CALL sadzp000_msg_get_message(ls_msg_code,ls_lang) RETURNING ls_message
    CALL sadzp000_msg_replace_message(ls_message,lo_tar_file_info.TABLE_NAME||cs_divide) RETURNING ls_message
    DISPLAY cs_message_tag,ls_msg_code,"-",ls_message
    LET ls_replace_arg = lo_tar_file_info.TABLE_NAME||cs_divide
    CALL sadzp000_msg_question_box(NULL, ls_msg_code, ls_replace_arg, 0) RETURNING ls_question                                       
  END IF 

  #有差異或者使用者回覆要異動則執行
  IF lb_diff OR (ls_question = cs_question_yes) THEN 
    #20161220 begin
    #先以舊資料貼標
    CALL sadzi140_util_toggle_columns_comments(lo_tar_file_info.TABLE_NAME) RETURNING lb_result    
    #20161220 end
    #匯入資料
    CALL sadzi140_exim_get_parameter(cs_exim_import,lo_tar_file_info.TABLE_NAME,lo_tar_file_info.CONSTRUCT_VERSION,lo_tar_file_info.SD_VERSION,lo_tar_file_info.REQUEST_NO,lo_tar_file_info.SEQUENCE_NO) RETURNING lo_import_parameter.*
    CALL sadzi140_exim_set_module_parameters(cs_exim_import,lo_tar_file_info.TABLE_NAME,lo_tar_file_info.CONSTRUCT_VERSION,lo_tar_file_info.SD_VERSION,lo_tar_file_info.REQUEST_NO,lo_tar_file_info.SEQUENCE_NO)
    CALL sadzi140_exim_run(FALSE,lo_import_parameter.*) RETURNING lo_import_info.*,lo_exec_result.*
    #如果沒有失敗
    IF NOT lo_import_info.RESULT THEN 
      #建立/異動表格
      CALL sadzi140_exim_get_parameter(cs_exim_assemble,lo_tar_file_info.TABLE_NAME,lo_tar_file_info.CONSTRUCT_VERSION,lo_tar_file_info.SD_VERSION,lo_tar_file_info.REQUEST_NO,lo_tar_file_info.SEQUENCE_NO) RETURNING lo_import_parameter.*
      CALL sadzi140_exim_set_module_parameters(cs_exim_assemble,lo_tar_file_info.TABLE_NAME,lo_tar_file_info.CONSTRUCT_VERSION,lo_tar_file_info.SD_VERSION,lo_tar_file_info.REQUEST_NO,lo_tar_file_info.SEQUENCE_NO)
      CALL sadzi140_exim_run(FALSE,lo_import_parameter.*) RETURNING lo_import_info.*,lo_exec_result.*
      CALL sadzi140_util_grant_revoke_privileges(lo_tar_file_info.TABLE_NAME) RETURNING ls_message 
      CALL sadzi140_util_regen_grant_aps_privilege_file() RETURNING ls_file_name 
      CALL sadzi140_db_update_alter_code(ls_master_user,lo_tar_file_info.TABLE_NAME)
      IF NOT lo_import_info.RESULT THEN 
        CALL sadzp000_msg_show_info(NULL, 'adz-00229', NULL, 0)
      ELSE
        CALL sadzp000_msg_show_error(NULL, NVL(lo_exec_result.er_CODE,"adz-00680"), NULL, 0)
      END IF  
    ELSE  
      CALL sadzp000_msg_show_error(NULL, NVL(lo_exec_result.er_CODE,"adz-00680"), NULL, 0)
    END IF  

    LET lb_return = lo_import_info.RESULT
    
  END IF    

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_util_get_property(p_property_name,p_lang)
DEFINE
  p_property_name STRING,
  p_lang          STRING
DEFINE
  ls_property_name  STRING,
  ls_lang           STRING,
  ls_sql            STRING,
  lo_property_type  T_PROPERTY
DEFINE
  lo_return T_PROPERTY

  LET ls_property_name = p_property_name
  LET ls_lang          = p_lang

  #取得資料表欄位屬性
  LET ls_sql = "SELECT TD.GZTD001   D_PROPERTY,                               ",
               "       TDL.GZTDL003 D_DESC,                                   ",
               "       TD.GZTD003   D_TYPE,                                   ",
               "       TD.GZTD008   D_LENGTH,                                 ",
               "       TD.GZTD005   D_WIDGETS,                                ",
               "       TD.GZTD006   D_PERCENT,                                ",
               "       TD.GZTD007   D_FORMAT,                                 ",
               "       ''           D_NULLABLE,                               ",
               "       DECODE(                                                ",
               "               UPPER(TRIM(TD.GZTD003)),                       ",
               "               'NUMBER','0',                                  ",
               "               ''                                             ",
               "             )      D_DEFAULT,                                ",
               "       TD.GZTD010   D_WIDGET_WIDTH,                           ",
               "       TD.GZTD011   D_REPORT_WIDTH,                           ",
               "       TD.GZTD012   D_REPORT_DIGIT,                           ",
               "       TD.GZTD013   D_WORD_CASE                               ",
               "  FROM GZTD_T TD                                              ",      
               "  LEFT OUTER JOIN GZTDL_T TDL ON TDL.GZTDL001 = TD.GZTD001    ",      
               "                             AND TDL.GZTDL002 = '",ls_lang,"' ",      
               " WHERE TD.GZTD001 = '",ls_property_name,"'                    ",
               "   AND TD.GZTDSTUS = 'Y'                                      ",      
               "   AND TD.GZTD001 NOT LIKE 'T%'                               ",      
               " ORDER BY TD.GZTD001                                          "
               
  PREPARE lpre_get_property FROM ls_sql
  DECLARE lcur_get_property CURSOR FOR lpre_get_property
  OPEN lcur_get_property
  FETCH lcur_get_property INTO lo_property_type.*
  CLOSE lcur_get_property
  FREE lcur_get_property
  FREE lpre_get_property
  
  LET lo_return.* = lo_property_type.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi140_util_create_procedure(p_master_db,p_master_user,p_object_name,p_batch_mode)
DEFINE 
  p_master_db   STRING,
  p_master_user STRING,
  p_object_name STRING,
  p_batch_mode  BOOLEAN
DEFINE 
  ls_master_db           STRING,
  ls_master_user         STRING,
  ls_object_name         STRING,
  lb_batch_mode          BOOLEAN,
  lo_db_connstr          T_DB_CONNSTR,
  ls_message             STRING,
  ls_all_message         STRING,
  ls_error               STRING, 
  ls_procedure_sql       STRING, 
  ls_procedure_file_name STRING, 
  ls_msg_number          STRING,
  lb_exists              BOOLEAN,
  lb_error               BOOLEAN
DEFINE 
  lb_return  BOOLEAN  

  LET ls_master_db   = p_master_db
  LET ls_master_user = p_master_user
  LET ls_object_name = p_object_name
  LET lb_batch_mode  = p_batch_mode

  LET lb_error = FALSE
  
  CALL sadzi140_prc_check_procedure_if_exists(ls_master_user,ls_object_name) RETURNING lb_exists

  IF NOT lb_exists THEN 
    CALL sadzi140_db_get_db_connect_string(ls_master_db) RETURNING lo_db_connstr.*
    
    CASE
      #建立取得 Columnm 預設值的Procedure
      WHEN ls_object_name = cs_prc_get_col_default
        CALL sadzi140_prc_create_get_col_default() RETURNING ls_procedure_file_name
      WHEN ls_object_name = cs_prc_get_col_default_by_owner
        CALL sadzi140_prc_create_get_col_default_by_owner() RETURNING ls_procedure_file_name
    END CASE

    #產出 SQL Scripts File
    LET lo_db_connstr.db_sql_filename = ls_procedure_file_name
    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
      CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Create Stored Procedure [.",ls_object_name,"]\n", 
                           "User : ",lo_db_connstr.db_username,"\n",
                           ls_message
    END IF  

    LET ls_error = ls_all_message.toUpperCase()

    IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
      LET lb_error = TRUE
      LET ls_msg_number = "adz-00468"
      IF lb_batch_mode THEN
        DISPLAY "[",ls_msg_number,"] Create stored procedure ",ls_object_name," ERROR !!","\n",
                ls_all_message
      ELSE
        CALL sadzp000_msg_show_error(ls_msg_number, ls_msg_number, ls_object_name, 1)
        CALL sadzi140_rev_view_logresult(ls_all_message)
      END IF
    END IF  
    
  END IF

  LET lb_return = lb_error

  RETURN lb_return
  
END FUNCTION    

#將語系別轉換為Array
FUNCTION sadzi140_util_get_local_language()
DEFINE
  li_length      INTEGER,
  ls_local_lang  STRING,
  ls_lang_char   STRING,
  ls_lang_string STRING,
  lo_local_lang  DYNAMIC ARRAY OF T_LOCAL_LANGUAGE
DEFINE
  lo_return DYNAMIC ARRAY OF T_LOCAL_LANGUAGE

  CALL lo_local_lang.clear()

  #取得當地語系清單
  CALL sadzi140_db_get_parameter(cs_param_level_language,cs_param_local_language) RETURNING ls_local_lang
  
  IF ls_local_lang IS NOT NULL THEN 
    FOR li_length = 1 TO ls_local_lang.getLength()
      LET ls_lang_char = ls_local_lang.subString(li_length,li_length)
      IF ls_lang_char = "," THEN 
        LET lo_local_lang[lo_local_lang.getLength() + 1] = ls_lang_string
        LET ls_lang_string = ""
      ELSE
        LET ls_lang_string = ls_lang_string,ls_lang_char 
      END IF
    END FOR
  ELSE
    #抓不到給預設值
    LET lo_local_lang[1] = cs_lang_zh_cn  
    LET lo_local_lang[2] = cs_lang_zh_tw  
  END IF

  LET lo_return = lo_local_lang

  RETURN lo_return  
    
END FUNCTION 

#20160824 begin
#將語系別轉換為Array
FUNCTION sadzi140_util_get_local_lang()
DEFINE
  li_length      INTEGER,
  ls_local_lang  STRING,
  ls_lang_char   STRING,
  ls_lang_string STRING,
  ls_sql         STRING,
  li_rec_count   INTEGER,
  lo_local_lang  DYNAMIC ARRAY OF T_LOCAL_LANGUAGE
DEFINE
  lo_return DYNAMIC ARRAY OF T_LOCAL_LANGUAGE

  LET li_rec_count = 1
  CALL lo_local_lang.clear()

  LET ls_sql = "SELECT GZZY001    ",
               "  FROM GZZY_T     ",
               " ORDER BY GZZY001 "
                               
  PREPARE lpre_get_local_lang FROM ls_sql
  DECLARE lcur_get_local_lang CURSOR FOR lpre_get_local_lang

  OPEN lcur_get_local_lang
  FOREACH lcur_get_local_lang INTO lo_local_lang[li_rec_count]
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

  END FOREACH
  CLOSE lcur_get_local_lang
  
  FREE lpre_get_local_lang
  FREE lcur_get_local_lang  

  CALL lo_local_lang.deleteElement(li_rec_count)
  
  LET lo_return = lo_local_lang

  RETURN lo_return  
    
END FUNCTION 
#20160824 end

FUNCTION sadzi140_util_check_default_value(p_data_type,p_data_length,p_default_value)
DEFINE
  p_data_type     STRING,
  p_data_length   STRING,
  p_default_value STRING
DEFINE
  ls_data_type     STRING,
  ls_data_length   STRING,
  ls_default_value STRING,
  ls_SQL           STRING,
  ls_integer       STRING,
  ls_decimal       STRING,
  li_integer       INTEGER,
  li_decimal       INTEGER,
  li_pinteger      INTEGER,
  ls_d_integer     STRING,
  ls_d_decimal     STRING,
  li_d_integer     INTEGER,
  li_d_decimal     INTEGER,
  ls_error_code    STRING,
  ls_check_code    STRING,
  ls_result        STRING,
  ls_check_value   STRING,
  lb_result        BOOLEAN,
  li_loop          INTEGER,
  lo_mapping_data  DYNAMIC ARRAY OF T_MAPPING_DATA
DEFINE
  ls_return STRING,
  lb_return BOOLEAN  

  LET ls_data_type     = p_data_type
  LET ls_data_length   = p_data_length
  LET ls_default_value = p_default_value.trim()

  LET lb_result = TRUE
  LET ls_return = ""
  LET ls_result = ""

  --IF (NVL(ls_default_value.trim(),cs_null_default) = cs_null_default) OR (ls_default_value.trim() IS NULL) THEN
  #輸入的值為NULL或空白, 則直接返回
  LET ls_check_value = NVL(sadzi140_util_trim_str(ls_default_value),cs_null_default)
  IF (ls_check_value = cs_null_default) OR (ls_check_value = ASCII(32)) THEN
    GOTO _RETURN 
  END IF  

  #數值型態的欄位需做進一步的控管
  IF ls_data_type.toUpperCase() = "NUMBER" THEN
    #取設定長度的整數位及精度
    IF ls_data_length.getIndexOf(",",1) <> 0 THEN 
      LET ls_integer = ls_data_length.subString(1,ls_data_length.getIndexOf(",",1)-1) 
      LET ls_decimal = ls_data_length.subString(ls_data_length.getIndexOf(",",1)+1,ls_data_length.getLength())
      LET li_integer = ls_integer
      LET li_decimal = ls_decimal
      LET li_pinteger = li_integer - li_decimal
    ELSE 
      LET li_integer = ls_data_length
      LET li_decimal = 0
      LET li_pinteger = li_integer
    END IF
    #取預設值的整數及小數
    IF ls_default_value.getIndexOf(".",1) <> 0 THEN
      LET ls_d_integer = ls_default_value.subString(1,ls_default_value.getIndexOf(".",1)-1) 
      LET ls_d_decimal = ls_default_value.subString(ls_default_value.getIndexOf(".",1)+1,ls_default_value.getLength())
    ELSE 
      LET li_d_integer = ls_default_value
      LET li_d_decimal = 0
    END IF
    #當輸入的預設值比設定的精度大的話, 則不通過
    IF (ls_d_integer.getLength() > li_pinteger) THEN 
      LET ls_result = "adz-00566"
      LET lb_result = FALSE
    END IF 
    IF (ls_d_decimal.getLength() > li_decimal) THEN 
      LET ls_result = "adz-00567"
      LET lb_result = FALSE
    END IF 
  END IF  

  IF lb_result THEN 
    LET ls_check_code = "adz-00565"
    #把輸入的預設值送到資料庫端做檢驗
    CASE UPSHIFT(ls_data_type)
      WHEN "BLOB"
        LET ls_SQL = "SELECT TO_BLOB(",ls_default_value,") FROM DUAL"
        LET ls_check_code = "adz-00570"
      WHEN "CLOB"
        LET ls_SQL = "SELECT TO_CLOB(",ls_default_value,") FROM DUAL"
        LET ls_check_code = "adz-00571"
      WHEN "DATE"
        LET ls_SQL = "SELECT ",ls_default_value," FROM DUAL"
        LET ls_check_code = "adz-00572"
      WHEN "NUMBER"
        LET ls_SQL = "SELECT TO_NUMBER(",ls_default_value,") FROM DUAL"
        LET ls_check_code = "adz-00573"
      WHEN "TIMESTAMP"
        LET ls_SQL = "SELECT TO_CHAR(",ls_default_value,",'YYYY/MM/DD HH24:MI:SS.FF') FROM DUAL"
        LET ls_check_code = "adz-00574"
      WHEN "VARCHAR2"
        LET ls_SQL = "SELECT TO_CHAR(",ls_default_value,") FROM DUAL"
        LET ls_check_code = "adz-00575"
    END CASE
    
    CALL sadzi140_db_run_SQL(ls_SQL) RETURNING lb_result
    IF NOT lb_result THEN LET ls_result = ls_check_code END IF
    
  END IF   

  LABEL _RETURN:
  
  LET lb_return = lb_result
  LET ls_return = ls_result

  RETURN lb_return,ls_return
  
END FUNCTION 

FUNCTION sadzi140_util_check_if_enable_set_default_value(p_data_type)
DEFINE
  p_data_type STRING
DEFINE
  ls_data_type   STRING,
  ls_enable_type STRING,
  ls_enable      STRING
DEFINE
  lb_return BOOLEAN  

  LET ls_data_type = p_data_type

  CASE UPSHIFT(ls_data_type)
    WHEN "BLOB"
      LET ls_enable_type = cs_param_enable_blob
    WHEN "CLOB"
      LET ls_enable_type = cs_param_enable_clob
    WHEN "DATE"
      LET ls_enable_type = cs_param_enable_date
    WHEN "NUMBER"
      LET ls_enable_type = cs_param_enable_number
    WHEN "TIMESTAMP"
      LET ls_enable_type = cs_param_enable_timestamp
    WHEN "VARCHAR2"
      LET ls_enable_type = cs_param_enable_varchar2
  END CASE

  CALL sadzi140_db_get_parameter(cs_param_level_default_value,ls_enable_type) RETURNING ls_enable
  LET ls_enable = NVL(ls_enable,"N")
  
  LET lb_return = IIF(ls_enable=="Y",TRUE,FALSE)

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzi140_util_get_global_var_to_db_func_mapping_data()
DEFINE
  ls_sql       STRING,
  li_rec_count INTEGER,
  lo_parameter DYNAMIC ARRAY OF T_MAPPING_DATA
DEFINE
  lo_return    DYNAMIC ARRAY OF T_MAPPING_DATA

  LET li_rec_count = 1

  LET ls_sql = "SELECT EJ.DZEJ004,EJ.DZEJ005,EJ.DZEJ006    ",
               "  FROM DZEJ_T EJ                           ",
               " WHERE EJ.DZEJ001 = 'adzi140_mapping_data' ",
               "   AND EJ.DZEJ003 = 'GlobalVarToDBFunc'    "
                              
  PREPARE lpre_get_global_var_to_db_func_mapping_data FROM ls_sql
  DECLARE lcur_get_global_var_to_db_func_mapping_data CURSOR FOR lpre_get_global_var_to_db_func_mapping_data

  OPEN lcur_get_global_var_to_db_func_mapping_data
  FOREACH lcur_get_global_var_to_db_func_mapping_data INTO lo_parameter[li_rec_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

  END FOREACH
  CLOSE lcur_get_global_var_to_db_func_mapping_data
  
  FREE lpre_get_global_var_to_db_func_mapping_data
  FREE lcur_get_global_var_to_db_func_mapping_data  

  CALL lo_parameter.deleteElement(li_rec_count)
  
  LET lo_return = lo_parameter
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi140_util_get_db_func_by_mapping_data(p_global_var,p_column_type,p_mapping_data)
DEFINE
  p_global_var   STRING,
  p_column_type  STRING,
  p_mapping_data DYNAMIC ARRAY OF T_MAPPING_DATA
DEFINE
  ls_global_var   STRING,
  ls_column_type  STRING,
  lo_mapping_data DYNAMIC ARRAY OF T_MAPPING_DATA,
  li_loop         INTEGER,
  ls_db_func      STRING
DEFINE 
  ls_return STRING
  
  LET ls_global_var   = UPSHIFT(p_global_var.trim())
  LET ls_column_type  = p_column_type.trim()
  LET lo_mapping_data = p_mapping_data

  LET ls_return = ""
  
  FOR li_loop = 1 TO lo_mapping_data.getLength()
    IF lo_mapping_data[li_loop].md_GLOBAL_VARIABLE = ls_global_var AND
       lo_mapping_data[li_loop].md_COLUMN_TYPE IS NULL THEN
      LET ls_db_func = lo_mapping_data[li_loop].md_DB_FUNCTION
      EXIT FOR
    ELSE 
      IF lo_mapping_data[li_loop].md_GLOBAL_VARIABLE = ls_global_var AND
         lo_mapping_data[li_loop].md_COLUMN_TYPE = ls_column_type THEN 
        LET ls_db_func = lo_mapping_data[li_loop].md_DB_FUNCTION
        EXIT FOR
      END IF  
    END IF
  END FOR

  LET ls_return = ls_db_func

  RETURN ls_return
  
END FUNCTION 

#Begin:20150417 by Hiko
FUNCTION sadzi140_util_set_form_title(p_form,p_lang) 
DEFINE 
  p_form  STRING,
  p_lang  STRING
DEFINE 
  ls_form      STRING,
  ls_lang      STRING,
  lo_window    ui.Window,
  lf_form      ui.Form,
  ls_cfg_path  STRING,
  ls_4st_path  STRING,
  ls_img_path  STRING,
  ls_icon_path STRING
DEFINE 
  ls_sql    STRING,
  ls_title  VARCHAR(1024) 

  LET ls_form = p_form
  LET ls_lang = p_lang
  
  LET ls_sql = "SELECT GZDEL003                ",
               "  FROM GZDEL_T                 ",
               " WHERE GZDEL001 = '",ls_form,"'",
               "   AND GZDEL002 = '",ls_lang,"'"
               
  PREPARE lcur_set_form_title FROM ls_sql
  EXECUTE lcur_set_form_title INTO ls_title
  FREE lcur_set_form_title

  LET lo_window = ui.Window.getCurrent()
  CALL lo_window.setText(ls_title CLIPPED) 

  LET ls_img_path  = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
  LET ls_icon_path = os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico")
  TRY 
    CALL lo_window.setImage(ls_icon_path)
  CATCH
    DISPLAY cs_warning_tag,"Can not set logo icon !"
  END TRY   
    
  
END FUNCTION
#End:20150417 by Hiko

FUNCTION sadzi140_util_set_form_style(p_lang)
DEFINE
  p_lang STRING
DEFINE
  ls_lang     STRING,
  ls_cfg_path STRING,
  ls_4st_path STRING

  LET ls_lang = p_lang
  
  LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
  LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), ls_lang), "designer.4st")
  
  TRY 
    CALL ui.Interface.loadStyles(ls_4st_path)
  CATCH
    DISPLAY cs_warning_tag,"Can not found 'designer.4st' !"
  END TRY   
  
END FUNCTION 

FUNCTION sadzi140_util_make_snapshot(p_master_user,p_table_name,p_alm_version,p_alm_request_no,p_dgenv)
DEFINE 
  p_master_user    STRING,
  p_table_name     STRING,
  p_alm_version    STRING,
  p_alm_request_no STRING,
  p_dgenv          STRING
DEFINE 
  ls_master_user    STRING,
  ls_table_name     STRING,
  ls_alm_version    STRING,
  ls_alm_request_no STRING,
  ls_dgenv          STRING,
  ls_curr_version   STRING,
  ls_new_version    STRING,
  lb_different      BOOLEAN,
  ls_question       STRING,
  lb_alter          BOOLEAN,
  ls_replace_arg    STRING
DEFINE
  lb_return        BOOLEAN

  LET ls_master_user    = p_master_user
  LET ls_table_name     = p_table_name
  LET ls_alm_version    = p_alm_version
  LET ls_alm_request_no = p_alm_request_no
  LET ls_dgenv          = p_dgenv
  
  LET lb_alter = FALSE

  #產生及取得新快照版本版號
  CALL sadzi140_vcs_get_new_version_code(ls_table_name,FALSE,FALSE,FALSE,TRUE,1) RETURNING ls_new_version
  CALL sadzi140_shot_create_snapshot(ls_master_user,ls_table_name,ls_curr_version,ls_new_version,ls_alm_version,ls_alm_request_no,ls_dgenv)
  
END FUNCTION

FUNCTION sadzi140_util_create_curr_snapshot(p_master_user,p_table_name,p_module_name,p_table_desc,p_dgenv)
DEFINE
  p_master_user  STRING,
  p_table_name   STRING,
  p_module_name  STRING,
  p_table_desc   STRING,
  p_dgenv        STRING 
DEFINE
  ls_master_user    STRING,
  ls_table_name     STRING,
  ls_module_name    STRING,
  ls_table_desc     STRING,
  ls_dgenv          STRING,
  ls_alm_version    STRING,
  ls_alm_request_no STRING,
  lo_table_info     T_PROGRAM_INFO,
  lo_dzlm_t         T_DZLM_T

  LET ls_master_user = p_master_user
  LET ls_table_name  = p_table_name
  LET ls_module_name = p_module_name
  LET ls_table_desc  = p_table_desc
  LET ls_dgenv       = p_dgenv
  
  LET lo_table_info.pi_NAME   = ls_table_name
  LET lo_table_info.pi_MODULE = ls_module_name
  LET lo_table_info.pi_DESC   = ls_table_desc
  LET lo_table_info.pi_TYPE   = cs_spec_type_table 
  CALL sadzp200_alm_get_dzlm(lo_table_info.*,cs_user_role_sd) RETURNING lo_dzlm_t.*
  LET ls_alm_version    = NVL(lo_dzlm_t.DZLM005,cs_disable_alm_sequence_no)
  LET ls_alm_request_no = NVL(lo_dzlm_t.DZLM012,cs_disable_alm_request_no)
  CALL sadzi140_util_make_snapshot(ls_master_user,ls_table_name,ls_alm_version,ls_alm_request_no,ls_dgenv)
  
END FUNCTION

FUNCTION sadzi140_util_show_message_bar(p_batch_mode,p_message)
DEFINE 
  p_batch_mode BOOLEAN,
  p_message    STRING
DEFINE 
  lb_batch_mode BOOLEAN,
  ls_message    STRING

  LET lb_batch_mode = p_batch_mode
  LET ls_message    = p_message

  IF NOT lb_batch_mode THEN 
    IF ls_message IS NULL THEN
      ERROR "" 
    ELSE 
      ERROR cs_information_tag,ls_message ATTRIBUTES(BLUE) 
    END IF  
    CALL ui.Interface.refresh()
  ELSE 
    IF ls_message IS NOT NULL THEN
      DISPLAY cs_information_tag,ls_message
    END IF  
  END IF   
  
END FUNCTION

FUNCTION sadzi140_util_check_program_exists(p_program_name)
DEFINE
  p_program_name  STRING
DEFINE
  ls_program_name STRING,
  ls_sql          STRING,
  li_rec_count    INTEGER
DEFINE
  lb_return  BOOLEAN

  LET ls_program_name = p_program_name.toLowerCase()

  LET li_rec_count = 0

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                           ",
               "  FROM GZZA_T ZA                          ",
               " WHERE 1=1                                ",
               "   AND ZA.GZZA001 = '",ls_program_name,"' "
 
  PREPARE lpre_check_program_exists FROM ls_sql
  DECLARE lcur_check_program_exists CURSOR FOR lpre_check_program_exists
  OPEN lcur_check_program_exists
  FETCH lcur_check_program_exists INTO li_rec_count
  CLOSE lcur_check_program_exists
  FREE lcur_check_program_exists
  FREE lpre_check_program_exists

  IF li_rec_count = 0 THEN
    DISPLAY cs_warning_tag,"No such execution program ",ls_program_name
  ELSE 
    DISPLAY cs_message_tag,"Execution program ",ls_program_name," found !"  
  END IF
  
  LET lb_return = IIF(li_rec_count==0,FALSE,TRUE)
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_util_grant_revoke_privileges(p_table_name)
DEFINE
  p_table_name     STRING
DEFINE
  ls_table_name          STRING,
  li_loop                INTEGER,
  li_grant               INTEGER,
  li_diff                INTEGER,
  li_granter             INTEGER,
  ls_sql_script          STRING,
  ls_revoke_sql          STRING,
  ls_grant_sql           STRING,
  ls_revoke_all_sql      STRING,
  ls_grant_all_sql       STRING,
  ls_grant_sql_filename  STRING,
  ls_message             STRING,
  ls_all_message         STRING,
  lb_result              BOOLEAN,
  ls_sql_memo            STRING
DEFINE  
  lo_db_connstr            T_DB_CONNSTR,
  lo_privilege_granter     DYNAMIC ARRAY OF T_PRIVILEGE_GRANTER,
  lo_privilege_info_list   DYNAMIC ARRAY OF T_PRIVILEGE_INFO, 
  lo_privilege_info        T_PRIVILEGE_INFO, 
  lo_privilege_design_diff DYNAMIC ARRAY OF T_PRIVILEGE_DIFF,
  lo_privilege_db_diff     DYNAMIC ARRAY OF T_PRIVILEGE_DIFF,
  lo_aps_privileges        DYNAMIC ARRAY OF T_PRIVILEGE_DIFF
DEFINE 
  ls_return  STRING   
  
  LET ls_table_name = p_table_name

  DISPLAY cs_message_tag,"Revoke and grant privileges for table ",ls_table_name

  ----------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------------------------------------------------------
  
  #取得正項差異清單
  CALL sadzi140_shot_get_privileges_diff_by_table_editor(ls_table_name) RETURNING lb_result,lo_privilege_design_diff
  CALL sadzi140_db_get_privilege_granter_from_diff(lo_privilege_design_diff) RETURNING lo_privilege_granter

  FOR li_granter = 1 TO lo_privilege_granter.getLength()
  
    LET ls_revoke_all_sql = ""
    LET ls_grant_all_sql  = ""
    LET ls_sql_script     = ""
    
    FOR li_diff = 1 TO lo_privilege_design_diff.getLength()
      IF lo_privilege_design_diff[li_diff].DZEN002 = lo_privilege_granter[li_granter] THEN
        #從 diff 資料重新更新權限資訊
        CALL sadzi140_db_refresh_privilege_info(lo_privilege_design_diff[li_diff].*) RETURNING lo_privilege_info.*
        #先作 Revoke
        CALL sadzi140_db_revoke_object_privileges(ls_table_name,cs_privilege_all,lo_privilege_info.pi_ACCEPTER) RETURNING ls_revoke_sql
        LET ls_revoke_all_sql = ls_revoke_all_sql,"\n",
                                ls_revoke_sql        
        #再取 Grant
        CALL sadzi140_db_grant_object_privileges(ls_table_name,lo_privilege_info.*) RETURNING ls_grant_sql
        LET ls_grant_all_sql = ls_grant_all_sql,"\n",
                               ls_grant_sql        
      END IF
    END FOR 

    LET ls_sql_memo = "/*","\n",
                      "Purpose : For grant privileges'","\n",
                      "Table : ",ls_table_name,"\n",
                      "Granter : ",lo_privilege_granter[li_granter],"\n",   
                      "*/"
  
    LET ls_sql_script = ls_sql_memo,"\n",
                        ls_sql_script,"\n",
                        ls_revoke_all_sql,"\n",
                        ls_grant_all_sql
                        
    CALL sadzi140_db_get_db_connect_string(lo_privilege_granter[li_granter]) RETURNING lo_db_connstr.*
    CALL sadzi140_rev_gen_sql_script_file(ls_sql_script,cs_create_table) RETURNING ls_grant_sql_filename
    LET lo_db_connstr.db_sql_filename = ls_grant_sql_filename
    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
      CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Grant privileges.","\n", 
                           "User : ",lo_db_connstr.db_username,"\n",
                           "Version : ",lo_db_connstr.db_version,"\n",
                           ls_message
                           
    END IF
    
  END FOR 

  ----------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------------------------------------------------------
  
  #取得反項差異清單
  CALL sadzi140_shot_get_privileges_diff_by_database(ls_table_name) RETURNING lb_result,lo_privilege_db_diff
  CALL sadzi140_db_get_privilege_granter_from_diff(lo_privilege_db_diff) RETURNING lo_privilege_granter

  FOR li_granter = 1 TO lo_privilege_granter.getLength()
  
    LET ls_revoke_all_sql = ""
    LET ls_sql_script     = ""
    
    FOR li_diff = 1 TO lo_privilege_db_diff.getLength()
      IF lo_privilege_db_diff[li_diff].DZEN002 = lo_privilege_granter[li_granter] THEN
        #從 diff 資料重新更新權限資訊
        CALL sadzi140_db_refresh_privilege_info(lo_privilege_db_diff[li_diff].*) RETURNING lo_privilege_info.*
        #反項只作 Revoke
        CALL sadzi140_db_revoke_object_privileges(ls_table_name,cs_privilege_all,lo_privilege_info.pi_ACCEPTER) RETURNING ls_revoke_sql
        LET ls_revoke_all_sql = ls_revoke_all_sql,"\n",
                                ls_revoke_sql        
      END IF
    END FOR 

    LET ls_sql_memo = "/*","\n",
                      "Purpose : For revoke privileges'","\n",
                      "Table : ",ls_table_name,"\n",
                      "Granter : ",lo_privilege_granter[li_granter],"\n",   
                      "*/"
  
    LET ls_sql_script = ls_sql_memo,"\n",
                        ls_sql_script,"\n",
                        ls_revoke_all_sql,"\n"
                        
    CALL sadzi140_db_get_db_connect_string(lo_privilege_granter[li_granter]) RETURNING lo_db_connstr.*
    CALL sadzi140_rev_gen_sql_script_file(ls_sql_script,cs_create_table) RETURNING ls_grant_sql_filename
    LET lo_db_connstr.db_sql_filename = ls_grant_sql_filename
    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
      CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Revoke privileges.","\n", 
                           "User : ",lo_db_connstr.db_username,"\n",
                           "Version : ",lo_db_connstr.db_version,"\n",
                           ls_message
                           
    END IF
    
  END FOR 

  ----------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------------------------------------------------------
  
  LET ls_return = ls_all_message

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_util_regen_grant_aps_privilege_file()
DEFINE
  lo_aps_grant_scripts DYNAMIC ARRAY OF T_APS_GRANT_SCRIPTS,
  ls_file_name  STRING,
  li_loop       INTEGER,
  ls_contents   STRING,
  ls_separator  STRING,
  lb_result     BOOLEAN
DEFINE
  ls_return STRING  

  LET ls_separator = os.Path.separator()
  
  CALL sadzi140_util_get_aps_privilege_scripts() RETURNING lo_aps_grant_scripts
  LET ls_file_name = FGL_GETENV("APSE"),ls_separator,"script",ls_separator,"dsgrant.sql"

  LET ls_contents = ""
  FOR li_loop = 1 TO lo_aps_grant_scripts.getLength()
    LET ls_contents = ls_contents,lo_aps_grant_scripts[li_loop],"\n" 
  END FOR 
  LET ls_contents = ls_contents,"exit;"

  CALL sadzi140_util_write_file(ls_file_name,ls_contents) RETURNING lb_result

  LET ls_return = ls_file_name

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_util_get_aps_privilege_scripts()
DEFINE
  ls_sql      STRING,
  li_rec_cnt  INTEGER,
  lo_aps_grant_scripts DYNAMIC ARRAY OF T_APS_GRANT_SCRIPTS
DEFINE
  lo_return DYNAMIC ARRAY OF T_APS_GRANT_SCRIPTS 

  LET li_rec_cnt = 1
  
  LET ls_sql = "SELECT DISTINCT                                                                       ",
               "       'grant '||                                                                     ",
               "       LOWER(SUBSTR(ENS.SQLS,1,LENGTH(ENS.SQLS)-1))||                                 ",
               "       ' on '||EN.DZEN001||' to '||EN.DZEN003||' ;'                                   ",
               "  FROM DZEN_T EN                                                                      ",
               "       LEFT OUTER JOIN (                                                              ",
               "                         SELECT ENS.DZEN001,ENS.DZEN002,ENS.DZEN003,                  ",
               "                                CASE WHEN ENS.DZEN004 = 'Y' THEN 'SELECT,' END||      ",
               "                                CASE WHEN ENS.DZEN005 = 'Y' THEN 'INSERT,' END||      ",
               "                                CASE WHEN ENS.DZEN006 = 'Y' THEN 'UPDATE,' END||      ",
               "                                CASE WHEN ENS.DZEN007 = 'Y' THEN 'DELETE,' END||      ",
               "                                CASE WHEN ENS.DZEN008 = 'Y' THEN 'REFERENCES,' END||  ",
               "                                CASE WHEN ENS.DZEN009 = 'Y' THEN 'ALTER,' END||       ",
               "                                CASE WHEN ENS.DZEN010 = 'Y' THEN 'INDEX,' END SQLS    ",
               "                           FROM DZEN_T ENS                                            ",
               "                       ) ENS ON ENS.DZEN001 = EN.DZEN001                              ",
               "                            AND ENS.DZEN002 = EN.DZEN002                              ",
               "                            AND ENS.DZEN003 = EN.DZEN003                              ",
               " WHERE EN.DZEN003 = '",cs_privilege_receiver_dsaps,"'                                 ",
               " ORDER BY 1                                                                           "
                                                                                                                             
  PREPARE lpre_get_aps_grant_scripts FROM ls_sql
  DECLARE lcur_get_aps_grant_scripts CURSOR FOR lpre_get_aps_grant_scripts

  OPEN lcur_get_aps_grant_scripts
  FOREACH lcur_get_aps_grant_scripts INTO lo_aps_grant_scripts[li_rec_cnt]
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_aps_grant_scripts

  CALL lo_aps_grant_scripts.deleteElement(li_rec_cnt)
  
  FREE lpre_get_aps_grant_scripts
  FREE lcur_get_aps_grant_scripts  

  LET lo_return = lo_aps_grant_scripts
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi140_util_identify_db_data(p_backend_mode,p_lang)
DEFINE
  p_backend_mode BOOLEAN,
  p_lang         STRING
DEFINE
  lb_backend_mode BOOLEAN,
  ls_lang         STRING,
  lb_result       BOOLEAN,
  ls_result       STRING,
  ls_replace_arg  STRING,
  ls_message      STRING,
  lo_string_buf   base.StringBuffer
DEFINE
  lb_return BOOLEAN  

  LET lb_backend_mode = p_backend_mode
  LET ls_lang = p_lang

  LET lo_string_buf = base.StringBuffer.create()
  CALL lo_string_buf.clear()

  #檢核資料庫設定的完整性
  CALL sadzi140_db_check_complete_of_db_data() RETURNING lb_result,ls_result
  IF NOT lb_result THEN
    IF lb_backend_mode THEN 
      LET ls_replace_arg = ls_result,"|"
      CALL sadzp000_msg_get_message('adz-00750',ls_lang) RETURNING ls_message
      CALL lo_string_buf.append(ls_message)
      CALL lo_string_buf.replace("%1",ls_result,0)
      LET ls_message = lo_string_buf.toString()
      DISPLAY cs_error_tag,ls_message
    ELSE 
      LET ls_replace_arg = ls_result,"|"
      CALL sadzp000_msg_show_error(NULL, 'adz-00750', ls_replace_arg, 1)
    END IF  
  END IF 

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi140_util_split_string_to_group(p_string,p_groups,p_split_sign)
DEFINE
  p_string      STRING,
  p_groups      INTEGER,
  p_split_sign  STRING
DEFINE
  ls_string      STRING,
  li_groups      INTEGER,
  ls_split_sign  STRING,
  li_loop        INTEGER,
  ls_char        STRING,
  li_sign_count  INTEGER,
  ls_list        STRING
DEFINE
  ls_return  STRING
  
  LET ls_string = p_string
  LET li_groups = p_groups
  LET ls_split_sign = p_split_sign

  LET li_sign_count = 0

  FOR li_loop = 1 TO ls_string.getLength()
    LET ls_char = ls_string.subString(li_loop,li_loop)
    IF ls_char = ls_split_sign THEN
      IF li_sign_count >= li_groups THEN 
        LET ls_list = ls_list,ls_char,"\n"
        LET li_sign_count = 1
      ELSE
        LET ls_list = ls_list,ls_char
        LET li_sign_count = li_sign_count + 1
      END IF  
    ELSE
      LET ls_list = ls_list,ls_char 
    END IF
  END FOR

  LET ls_return = ls_list
  
  RETURN ls_return
  
END FUNCTION 

#UNTAR資料
FUNCTION sadzi140_util_untar_file(p_path,p_file_name,p_kill_file)
DEFINE
  p_path       STRING,
  p_file_name  STRING,
  p_kill_file  BOOLEAN
DEFINE
  ls_path        STRING,
  ls_file_name   STRING,
  lb_kill_file   BOOLEAN,
  ls_full_path   STRING,
  ls_TARString   STRING,
  ls_separator   STRING,
  li_run_result  INTEGER,
  lb_result      BOOLEAN
DEFINE
  lb_return  BOOLEAN
  
  LET ls_path      = p_path
  LET ls_file_name = p_file_name
  LET lb_kill_file = p_kill_file

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_separator 

  LET ls_full_path = ls_path,ls_separator,ls_file_name

  LET ls_TARString = "tar xvf ",ls_file_name
  
  RUN ls_TARString RETURNING li_run_result

  IF lb_kill_file THEN
    CALL os.Path.delete(ls_file_name) RETURNING lb_result
  END IF
  
  LET lb_return = IIF(li_run_result==0,TRUE,FALSE)
  
  RETURN lb_return 
  
END FUNCTION

FUNCTION sadzi140_util_get_file_list(p_orig_dir,p_work_dir)
DEFINE
  p_orig_dir STRING,
  p_work_dir STRING 
DEFINE
  ls_orig_dir  STRING,
  ls_work_dir  STRING,
  lb_result    BOOLEAN,
  ls_file_name STRING,
  li_file_cnt  INTEGER,
  li_count     INTEGER,
  ls_type      STRING,
  lo_directory_list DYNAMIC ARRAY OF T_DIRECTORY_LIST
DEFINE
  lo_return DYNAMIC ARRAY OF T_DIRECTORY_LIST
  
  LET ls_orig_dir = p_orig_dir
  LET ls_work_dir = p_work_dir

  LET li_count = 1

  CALL os.Path.chdir(ls_work_dir) RETURNING lb_result

  CALL os.Path.dirfmask( 1 + 2 + 4 )
  CALL os.Path.dirsort("name", 1)

  LET li_file_cnt = os.Path.diropen(ls_work_dir)

  WHILE li_file_cnt > 0

    LET ls_file_name = os.Path.dirnext(li_file_cnt)
    IF ls_file_name IS NULL THEN EXIT WHILE END IF

    CASE 
      WHEN os.Path.isFile(ls_file_name)
        LET ls_type = "F" -- File
      WHEN os.Path.isDirectory(ls_file_name)
        LET ls_type = "D" -- Directory
      WHEN os.Path.isLink(ls_file_name)
        LET ls_type = "L" -- Link
      OTHERWISE
        LET ls_type = "E" -- Error
    END CASE 
    
    LET lo_directory_list[li_count].dl_type = ls_type
    LET lo_directory_list[li_count].dl_name = ls_file_name

    LET li_count = li_count + 1
    
  END WHILE

  CALL os.Path.dirclose(li_file_cnt)

  CALL os.Path.chdir(ls_orig_dir) RETURNING lb_result

  LET lo_return = lo_directory_list

  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi140_util_rename_clone(p_work_table_name,p_work_dir,p_directory_list,p_new_table_name)
DEFINE 
  p_work_table_name STRING,
  p_work_dir        STRING, 
  p_directory_list  DYNAMIC ARRAY OF T_DIRECTORY_LIST,
  p_new_table_name  STRING 
DEFINE 
  ls_work_table_name STRING,
  ls_work_dir        STRING, 
  lo_directory_list  DYNAMIC ARRAY OF T_DIRECTORY_LIST,
  ls_new_table_name  STRING,
  ls_new_work_dir    STRING,
  ls_old_file_name   STRING,
  ls_new_file_name   STRING,
  li_count           INTEGER,
  lb_result          BOOLEAN,
  ls_separator       STRING,
  lo_string_buf      base.StringBuffer,
  lo_new_dir_list    DYNAMIC ARRAY OF T_DIRECTORY_LIST
DEFINE
  lb_return BOOLEAN,
  ls_return STRING,  
  lo_return DYNAMIC ARRAY OF T_DIRECTORY_LIST

  LET ls_work_table_name   = p_work_table_name.toLowerCase()
  LET ls_work_dir          = p_work_dir
  LET lo_directory_list    = p_directory_list
  LET ls_new_table_name    = p_new_table_name
  
  LET lo_string_buf = base.StringBuffer.create()
  LET ls_separator = os.Path.separator()
  LET lb_return = TRUE
  
  CALL os.Path.chdir(ls_work_dir) RETURNING lb_result

  CALL sadzi140_exim_making_work_directory(ls_new_table_name,cs_working_dir_type_import) RETURNING lb_result,ls_new_work_dir

  FOR li_count = 1 TO lo_directory_list.getLength()
    CALL lo_string_buf.clear()
    CALL lo_string_buf.append(lo_directory_list[li_count].dl_name)
    CALL lo_string_buf.replace(ls_work_table_name,ls_new_table_name,0)

    LET lo_new_dir_list[li_count].dl_type = lo_directory_list[li_count].dl_type
    LET lo_new_dir_list[li_count].dl_name = lo_string_buf.toString()

    LET ls_old_file_name = ls_work_dir,ls_separator,lo_directory_list[li_count].dl_name
    LET ls_new_file_name = ls_new_work_dir,ls_separator,lo_new_dir_list[li_count].dl_name

    CALL os.Path.copy(ls_old_file_name,ls_new_file_name) RETURNING lb_result
    IF NOT lb_result THEN LET lb_return = FALSE END IF 
    DISPLAY IIF(lb_result,cs_information_tag,cs_error_tag),"Copy file from '",ls_old_file_name,"' to '",ls_new_file_name,"' : ",IIF(lb_result,"Successed.","Failed.")
    
  END FOR
  
  LET ls_return = ls_new_work_dir
  LET lo_return = lo_new_dir_list

  RETURN lb_return,ls_return,lo_return  

END FUNCTION

FUNCTION sadzi140_util_replace_clone_contents(p_old_table_name,p_work_dir,p_directory_list,p_new_table_name,p_table_tail_code)
DEFINE 
  p_old_table_name   STRING,
  p_work_dir         STRING, 
  p_directory_list   DYNAMIC ARRAY OF T_DIRECTORY_LIST,
  p_new_table_name   STRING,
  p_table_tail_code  STRING
DEFINE 
  ls_old_table_name  STRING,
  ls_work_dir        STRING, 
  lo_directory_list  DYNAMIC ARRAY OF T_DIRECTORY_LIST,
  ls_new_table_name  STRING, 
  ls_table_tail_code STRING,
  ls_old_file_name   STRING,
  ls_new_file_name   STRING,
  ls_old_front_name  STRING,
  ls_new_front_name  STRING,
  li_count           INTEGER,
  lb_result          BOOLEAN,
  ls_file_name       STRING,
  lb_status          BOOLEAN,
  ls_text            STRING,
  ls_text_line       STRING,
  ls_file_ext        STRING,
  lo_pkg_sys_info    T_PKG_SYS_INFO,
  lo_json_obj        util.JSONObject,
  lo_channel_read    base.Channel,
  lo_string_buf      base.StringBuffer
DEFINE
  lb_return BOOLEAN,
  ls_return STRING,  
  lo_return DYNAMIC ARRAY OF T_DIRECTORY_LIST

  LET ls_old_table_name    = p_old_table_name.toLowerCase()
  LET ls_work_dir          = p_work_dir
  LET lo_directory_list    = p_directory_list
  LET ls_new_table_name    = p_new_table_name
  LET ls_table_tail_code   = p_table_tail_code

  LET lo_string_buf = base.StringBuffer.create()

  LET lb_return = TRUE
  LET lb_status = TRUE
  
  CALL os.Path.chdir(ls_work_dir) RETURNING lb_result

  LET ls_old_front_name = ls_old_table_name.subString(1,ls_old_table_name.getIndexOf(ls_table_tail_code,1)-1)
  LET ls_new_front_name = ls_new_table_name.subString(1,ls_new_table_name.getIndexOf(ls_table_tail_code,1)-1)
  
  FOR li_count = 1 TO lo_directory_list.getLength()

    LET ls_file_name = lo_directory_list[li_count].dl_name
    LET ls_file_ext = os.Path.extension(ls_file_name)

    IF ls_file_ext.toLowerCase() = "txn" THEN 
      CALL sadzi140_exim_table_get_notice(ls_file_name) RETURNING lb_result,lo_json_obj
      CALL sadzi140_exim_get_sys_info() RETURNING lo_pkg_sys_info.*
      CALL sadzi140_exim_set_export_notice_sys_info(lo_pkg_sys_info.*,lo_json_obj,TRUE)
      LET ls_text = util.JSON.format(lo_json_obj.toString())
    ELSE 
      LET lo_channel_read = base.Channel.create()
      LET lb_result = TRUE
      LET ls_text = ""
      #開檔先讀內容
      TRY 
        CALL lo_channel_read.openFile(ls_file_name,"r")
      CATCH
        LET lb_result = FALSE
        LET lb_status = FALSE
        DISPLAY cs_error_tag,"Open file ",ls_file_name," for read failed !"
      END TRY  

      IF lb_result THEN 
        WHILE TRUE
          IF lo_channel_read.isEof() THEN 
            EXIT WHILE
          END IF

          LET ls_text_line = lo_channel_read.readLine()
          IF ls_text_line.trim() IS NOT NULL THEN 
            LET ls_text = ls_text,
                          ls_text_line,"\n"
          END IF                
          
        END WHILE
      END IF
    END IF
    
    CALL lo_string_buf.clear()
    CALL lo_string_buf.append(ls_text)
    CALL lo_string_buf.replace(ls_old_front_name,ls_new_front_name,0)

    #再將結果寫回去
    CALL sadzi140_exim_write_file(ls_file_name,lo_string_buf.toString()) RETURNING lb_result
    IF NOT lb_result THEN LET lb_status = FALSE END IF

    #關檔
    TRY 
      CALL lo_channel_read.close()
    CATCH 
      DISPLAY cs_error_tag,"Close file ",ls_file_name," failed !"
    END TRY  

  END FOR
  
  LET lb_return = lb_status

  RETURN lb_return

END FUNCTION

FUNCTION sadzi140_util_replace_string(p_string,p_from,p_to)
DEFINE 
  p_string STRING,
  p_from   STRING,
  p_to     STRING
DEFINE 
  ls_string      STRING,
  ls_from        STRING,
  ls_to          STRING,
  lo_string_buf  base.StringBuffer
DEFINE
  ls_return STRING  

  LET ls_string = p_string
  LET ls_from   = p_from
  LET ls_to     = p_to
  
  LET lo_string_buf = base.StringBuffer.create()

  CALL lo_string_buf.clear()
  CALL lo_string_buf.append(ls_string)
  CALL lo_string_buf.replace(ls_from,ls_to,0)
  
  LET ls_return = lo_string_buf.toString()

  RETURN ls_return

END FUNCTION

FUNCTION sadzi140_util_write_file(p_file_name,p_line_string)
DEFINE
  p_file_name   STRING,
  p_line_string STRING
DEFINE   
  ls_file_name      STRING,
  ls_line_string    STRING,
  lo_channel_write  base.Channel,
  lb_success        BOOLEAN

  LET ls_file_name  = p_file_name
  LET ls_line_string = p_line_string

  LET lb_success = TRUE
  
  LET  lo_channel_write = base.Channel.create()
  CALL lo_channel_write.setDelimiter("")

  TRY
    CALL lo_channel_write.openFile(ls_file_name, "w" )
    CALL lo_channel_write.write(ls_line_string)
    CALL lo_channel_write.close()
    DISPLAY cs_success_tag,"Data write to '",ls_file_name,"' successed !!"
  CATCH
    LET lb_success = FALSE
    DISPLAY cs_error_tag,"Data write to '",ls_file_name,"' failed !!"
  END TRY  

  RETURN lb_success
  
END FUNCTION

#20160617 begin
FUNCTION sadzi140_util_set_log_for_shipped_table(p_table_name,p_user)
DEFINE
  p_table_name STRING,
  p_user       STRING
DEFINE
  ls_table_name STRING,
  ls_user       STRING,
  ls_host_zone  STRING,
  lo_DZHH_T     T_DZHH_T,
  ldt_datetime  DATETIME YEAR TO DAY

  LET ls_table_name = p_table_name
  LET ls_user = p_user

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  LET ldt_datetime = CURRENT YEAR TO DAY
  &endif

  LET ls_host_zone = FGL_GETENV("HOST"),".",FGL_GETENV("ZONE")

  LET lo_DZHH_T.DZHH001 = ls_table_name
  LET lo_DZHH_T.DZHH002 = ldt_datetime
  LET lo_DZHH_T.DZHH003 = ""
  LET lo_DZHH_T.DZHH004 = ""
  LET lo_DZHH_T.DZHH005 = ls_host_zone

  CALL sadzi140_crud_insert_update_dzhh_t(lo_DZHH_T.*)
  
END FUNCTION
#20160617 end

#20161220 begin
FUNCTION sadzi140_util_get_toggle_bookmark_scripts(p_db_user_name,p_table_name)
DEFINE
  p_db_user_name STRING,
  p_table_name   STRING
DEFINE
  ls_db_user_name STRING,
  ls_table_name   STRING,
  ls_sql_scripts  STRING,
  ls_scripts      STRING,
  ls_exit_sign    STRING,
  li_loop         INTEGER,
  lo_comment_columns  DYNAMIC ARRAY OF T_COMMENT_COLUMNS
DEFINE
  ls_return  STRING
  
  LET ls_db_user_name = p_db_user_name
  LET ls_table_name   = p_table_name

  CALL sadzi140_db_get_toggle_comment_columns(ls_db_user_name,ls_table_name) RETURNING lo_comment_columns

  LET ls_sql_scripts = ""
  LET ls_exit_sign = "exit;"
  
  FOR li_loop = 1 TO lo_comment_columns.getLength()
    CALL sadzi140_db_get_comment_columns_scripts(lo_comment_columns[li_loop].*) RETURNING ls_scripts
    LET ls_sql_scripts = ls_sql_scripts,ls_scripts,"\n"
  END FOR  
  
  LET ls_sql_scripts = "-- Set column comments. ","\n",  
                       "SET SERVEROUTPUT ON     ","\n",
                       ls_sql_scripts,
                       ls_exit_sign
                       
  LET ls_return = ls_sql_scripts                  

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_util_create_altering_log(p_alter_type,p_alter_columns)
DEFINE
  p_alter_type    STRING,
  p_alter_columns DYNAMIC ARRAY OF T_COLUMN_LIST
DEFINE
  ls_alter_type    STRING,
  lo_alter_columns DYNAMIC ARRAY OF T_COLUMN_LIST,
  li_loop          INTEGER,
  ls_message       STRING,
  lb_result        BOOLEAN

  LET ls_alter_type    = p_alter_type
  LET lo_alter_columns = p_alter_columns

  FOR li_loop = 1 TO lo_alter_columns.getLength()
    LET ls_message = ls_alter_type," : ",lo_alter_columns[li_loop].COLUMN_DESC
    CALL sadzi140_logs_write_log(cs_logs_level_warning,ls_alter_type,ls_message) RETURNING lb_result
  END FOR
  
END FUNCTION

#標註欄位說明
FUNCTION sadzi140_util_toggle_columns_comments(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE 
  ls_table_name        STRING,
  lo_table_in_db_type  DYNAMIC ARRAY OF T_TABLE_IN_DB_TYPE,
  lo_db_connstr        T_DB_CONNSTR,
  ls_all_message       STRING,
  ls_message           STRING,
  li_loop              INTEGER,
  ls_error             STRING,
  ls_message_bar       STRING,
  ls_toggle_comment_sql      STRING, 
  ls_toggle_comment_filename STRING
DEFINE 
  lb_return BOOLEAN  

  LET ls_table_name     = p_table_name
  
  LET lb_return          = TRUE
  LET ls_all_message     = ""

  #取得表格在DB中是 Table or Synonym
  CALL sadzi140_db_get_table_in_db_type(ls_table_name,cs_order_by_desc) RETURNING lo_table_in_db_type
  
  FOR li_loop = 1 TO lo_table_in_db_type.getLength()
    CALL sadzi140_db_get_db_connect_string(lo_table_in_db_type[li_loop].tidt_db) RETURNING lo_db_connstr.*

    #若為表格, 則產生Toggle column comment script file
    IF lo_table_in_db_type[li_loop].tidt_object_type = "T" THEN
      ###############################################################################################################################################################
      #Toggle bookmark for table columns
      LET ls_message_bar = "Toggle bookmark for ",lo_db_connstr.db_username,".",ls_table_name," columns."
      DISPLAY cs_message_tag,ls_message_bar
      CALL sadzi140_util_get_toggle_bookmark_scripts(lo_db_connstr.db_username,ls_table_name) RETURNING ls_toggle_comment_sql
      CALL sadzi140_rev_gen_sql_script_file(ls_toggle_comment_sql,cs_toggle_bookmark) RETURNING ls_toggle_comment_filename
      LET lo_db_connstr.db_sql_filename = ls_toggle_comment_filename
      IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
        CALL sadzi140_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
        LET ls_all_message = ls_all_message,"\n",
                             "Process :",ls_message_bar,"\n", 
                             "User : ",lo_db_connstr.db_username,"\n",
                             ls_message
      END IF        
      ###############################################################################################################################################################
    END IF
    
  END FOR  
  
  LET ls_error = ls_all_message.toUpperCase()
  IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_return = FALSE
  END IF  
  
  RETURN lb_return
  
END FUNCTION
#20161220 end