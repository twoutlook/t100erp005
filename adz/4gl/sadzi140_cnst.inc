#Primary Key Constant
CONSTANT cs_db_type           STRING = "ORA" 
CONSTANT cs_enterprise        STRING = "99"

CONSTANT cs_primary_key_type  STRING = "P"
CONSTANT cs_unique_index_type STRING = "U"

CONSTANT cs_pk_keyword        STRING = "_pk"
CONSTANT cs_fk_keyword        STRING = "_fk"
CONSTANT cs_fd_keyword        STRING = "_fd"
CONSTANT cs_rk_keyword        STRING = "_rk"
CONSTANT cs_table_tail_code   STRING = "_t"

CONSTANT cs_idx_normal_keyword STRING = "_n"
CONSTANT cs_idx_unique_keyword STRING = "_u"

CONSTANT cs_null_value        STRING = "!@#"      

CONSTANT cs_top_module_name   STRING = "TOP"
CONSTANT cs_table_designer    STRING = "TableDesigner"
CONSTANT cs_database          STRING = "Database"

CONSTANT cs_alter_column      STRING = "altcol"
CONSTANT cs_drop_column       STRING = "drpcol"
CONSTANT cs_create_table      STRING = "crttbl"
CONSTANT cs_create_synonym    STRING = "crtsym"
CONSTANT cs_alter_table       STRING = "alttable"
CONSTANT cs_toggle_bookmark   STRING = "tglebmark" 

CONSTANT cs_reversion         STRING = "rev"
CONSTANT cs_digits            STRING = "&&&"

CONSTANT cs_master_db         STRING = "ds"
CONSTANT cs_master_user       STRING = "ds"
CONSTANT cs_slave_user        STRING = "dsdemo"

CONSTANT cs_local_db          STRING = "local"

CONSTANT cs_dummy_table_name  STRING = 'DUMMY'
CONSTANT cs_dummy_column_name STRING = 'DUMMY'

CONSTANT cs_default_privilege_role STRING = "TIPTOP"

CONSTANT cs_question_yes      STRING = "yes"    
CONSTANT cs_question_no       STRING = "no" 

CONSTANT cs_result_success    STRING = "Success"    
CONSTANT cs_result_fail       STRING = "Fail" 
CONSTANT cs_result_cancel     STRING = "Cancel"    

CONSTANT cs_init_version_code STRING = '0'
CONSTANT cs_init_alm_ver_code STRING = '0'

CONSTANT cs_no_define          STRING = 'NoDefine' 
CONSTANT cs_group_leading_code STRING = "grp" 

CONSTANT cs_cdf_serial_number STRING = "cdfSerialNumber"  
CONSTANT cs_cdf_user_define   STRING = "cdfUserDefine"

CONSTANT cs_cdf_user_define_varchar  STRING = "cdfUserDefineVarchar"  
CONSTANT cs_cdf_user_define_number   STRING = "cdfUserDefineNumber"  
CONSTANT cs_cdf_user_define_datetime STRING = "cdfUserDefineDateTime"  

CONSTANT cs_default_lang      STRING = "zh_TW"
CONSTANT cs_dept              STRING = "None"

CONSTANT cs_lang_zh_cn        STRING = "zh_CN"
CONSTANT cs_lang_zh_tw        STRING = "zh_TW"

CONSTANT cs_order_by_asc      STRING = "ASC"
CONSTANT cs_order_by_desc     STRING = "DESC"

CONSTANT cs_message_hint      STRING = "Hint"
CONSTANT cs_message_warning   STRING = "Warning"
CONSTANT cs_message_error     STRING = "Error"

CONSTANT cs_rebuild_tail      STRING = "_rebuild"
CONSTANT cs_export_import_ext STRING = 'tdi'

CONSTANT cs_export_import_all_file STRING = '*.tdi'

CONSTANT cs_table_rev         STRING = "Rev"
CONSTANT cs_column_shipped    STRING = "Y"
CONSTANT cs_lang_modified     STRING = "Y"

CONSTANT cs_view_type_db      STRING = "DB"
CONSTANT cs_view_type_rt      STRING = "RT"

CONSTANT cs_alter_type_add    STRING = "ADD"
CONSTANT cs_alter_type_modify STRING = "MODIFY"

CONSTANT cs_alm_table         STRING = "DZLM_T"
CONSTANT cs_mdm_module_name   STRING = "MDM" 

CONSTANT cs_schema_type_all  STRING = "ALL"

CONSTANT cs_pass_through_status_code STRING = "P"

CONSTANT cs_default_db_type  STRING = "ORA"
CONSTANT cs_default_topind   STRING = "sd"
CONSTANT cs_standard_topind  STRING = "sd"

CONSTANT cs_status_finalizing STRING = "Finalizing..."

CONSTANT cs_privilege_receiver_dsaps STRING = "dsaps"

CONSTANT cs_keyword_DGENV   STRING = "DGENV"
CONSTANT cs_keyword_ERPID   STRING = "ERPID"
CONSTANT cs_keyword_CUST    STRING = "CUST"
CONSTANT cs_keyword_DB_TYPE STRING = "DB_TYPE"
CONSTANT cs_keyword_TOPIND  STRING = "TOPIND"
CONSTANT cs_keyword_renamed STRING = "RENAMED"
CONSTANT cs_ERP_default_ID  STRING = "T100ERP"

#Grant Privilege
CONSTANT cs_privilege_all        STRING = "ALL"
CONSTANT cs_privilege_select     STRING = "SELECT"
CONSTANT cs_privilege_insert     STRING = "INSERT"
CONSTANT cs_privilege_update     STRING = "UPDATE"
CONSTANT cs_privilege_delete     STRING = "DELETE"
CONSTANT cs_privilege_references STRING = "REFERENCES"
CONSTANT cs_privilege_alter      STRING = "ALTER"
CONSTANT cs_privilege_index      STRING = "INDEX"

CONSTANT cs_custom_module_leading_code STRING = "E"

#Parameter Level define
CONSTANT cs_param_level_system          STRING = "System"
CONSTANT cs_param_level_editor          STRING = "Editor"
CONSTANT cs_param_level_alter_table     STRING = "AlterTable"
CONSTANT cs_param_level_rebuild         STRING = "Rebuild"
CONSTANT cs_param_level_alm             STRING = "ALM"
CONSTANT cs_param_level_column_define   STRING = "ColumnDefine"
CONSTANT cs_param_level_lob             STRING = "LOB"
CONSTANT cs_param_level_language        STRING = "Language"
CONSTANT cs_param_level_default_value   STRING = "DefaultValue"
CONSTANT cs_param_level_patch_Key_value STRING = "PatchKeyValue"
CONSTANT cs_param_level_session         STRING = "Session"
CONSTANT cs_param_level_export_import   STRING = "ExportImport"

#System Level
CONSTANT cs_param_master_db         STRING = "MasterDB"
CONSTANT cs_param_master_user       STRING = "MasterUser"
CONSTANT cs_param_enable_customize  STRING = "EnableCustomize"
CONSTANT cs_param_enable_industry   STRING = "EnableIndustry"
CONSTANT cs_param_essential_schemas STRING = "EssentialSchemas"

#Editor Level
CONSTANT cs_param_enable_user_define            STRING = "EnableUserDefine"
CONSTANT cs_param_version                       STRING = "Version"
CONSTANT cs_param_show_detail_color             STRING = "ShowDetailColor"
CONSTANT cs_param_drag_and_drop_internal        STRING = "DragAndDropInternal"
CONSTANT cs_param_delete_table_control          STRING = "DeleteTableControl"
CONSTANT cs_param_synonym_define                STRING = "SynonymDefine" 
CONSTANT cs_param_check_table_tail_code         STRING = "CheckTableTailCode" 
CONSTANT cs_param_table_user_define_code        STRING = "TableUserDefineCode" 
CONSTANT cs_param_column_user_define_code       STRING = "ColumnUserDefineCode" 
CONSTANT cs_param_table_tail_code               STRING = "TableTailCode"
CONSTANT cs_param_enable_foreign_key            STRING = "EnableForeignKey"
CONSTANT cs_param_table_user_custom_code        STRING = "TableUserCustomCode" 
CONSTANT cs_param_column_user_custom_code       STRING = "ColumnUserCustomCode" 
CONSTANT cs_param_column_user_alter_code        STRING = "ColumnUserAlterCode" 
CONSTANT cs_param_key_user_alter_leading_code   STRING = "KeyUserAlterLeadingCode" 
CONSTANT cs_param_index_user_alter_leading_code STRING = "IndexUserAlterLeadingCode" 
CONSTANT cs_param_max_table_name_length         STRING = "MaxTableNameLength" 
CONSTANT cs_param_notify_custom_field_type      STRING = "NotifyCustomFieldType"            

#AlterTable Level
CONSTANT cs_param_drop_abnormal_column   STRING = "DropAbnormalColumn"

#ALM Level
CONSTANT cs_param_enable_alm             STRING = "EnableALM"
CONSTANT cs_param_check_pass_request     STRING = "CheckPassRequest"
CONSTANT cs_param_enable_backup_trunc    STRING = "EnableBackupTrunc"
CONSTANT cs_param_update_shipping_code   STRING = "UpdateShippingCode"

#LOB Level
CONSTANT cs_param_tablespace STRING = "Tablespace"

#Rebuild Level
CONSTANT cs_param_enable_data_moving     STRING = "EnableDataMoving"
CONSTANT cs_param_drop_backup_table      STRING = "DropBackupTable"
CONSTANT cs_param_check_data_exists      STRING = "CheckDataExists"
CONSTANT cs_param_max_rebuild_records    STRING = "MaxRebuildRecords"
CONSTANT cs_param_enable_force_rebuild   STRING = "EnableForceRebuild"

#Column Define Level
CONSTANT cs_param_number_of_varchar_fields  STRING = "NumberOfVarcharFields"
CONSTANT cs_param_number_of_number_fields   STRING = "NumberOfNumberFields"
CONSTANT cs_param_number_of_datetime_fields STRING = "NumberOfDateTimeFields"

#Language level
CONSTANT cs_param_local_language  STRING = "LocalLanguage"

#DefaultValue Level
CONSTANT cs_param_enable_blob       STRING = "EnableBLOB"
CONSTANT cs_param_enable_clob       STRING = "EnableCLOB"
CONSTANT cs_param_enable_date       STRING = "EnableDATE"
CONSTANT cs_param_enable_number     STRING = "EnableNUMBER"
CONSTANT cs_param_enable_timestamp  STRING = "EnableTIMESTAMP"
CONSTANT cs_param_enable_varchar2   STRING = "EnableVARCHAR2"

#PatchKeyValue Level
CONSTANT cs_param_patch_key_value_date      STRING = "DATE"
CONSTANT cs_param_patch_key_value_number    STRING = "NUMBER"
CONSTANT cs_param_patch_key_value_timestamp STRING = "TIMESTAMP"
CONSTANT cs_param_patch_key_value_varchar2  STRING = "VARCHAR2"

#ExportImport Level
CONSTANT cs_param_check_erpid  STRING = "CheckERPID"

#Optimizer Features Enable
CONSTANT cs_param_optimizer_features_enable  STRING = "OptimizerFeaturesEnable"

CONSTANT cs_side_left  STRING = "LEFT"
CONSTANT cs_side_right STRING = "RIGHT"

CONSTANT cs_editor_mode_browse STRING = "BROWSE"
CONSTANT cs_editor_mode_edit   STRING = "EDIT"
CONSTANT cs_editor_mode_design STRING = "DESIGN"

CONSTANT cs_exim_dump     STRING = "idmp" 
CONSTANT cs_exim_export   STRING = "iexp" 
CONSTANT cs_exim_import   STRING = "iimp" 
CONSTANT cs_exim_verify   STRING = "ivfy" 
CONSTANT cs_exim_assemble STRING = "iasm" 
CONSTANT cs_exim_delete   STRING = "idel" 
CONSTANT cs_exim_drop     STRING = "idrp"
CONSTANT cs_exim_alter    STRING = "ialt" 
CONSTANT cs_exim_rebuild  STRING = "ireb" 

CONSTANT cs_working_dir_type_import STRING = "IMP"
CONSTANT cs_working_dir_type_export STRING = "EXP"

CONSTANT cs_rt_design_data_version_code STRING = "0"
CONSTANT cs_rt_design_data_code         STRING = "T"
CONSTANT cs_rt_design_data_version      STRING = "99999"
CONSTANT cs_rt_design_sd_version        STRING = "0"

CONSTANT cs_rt_design_request_no  STRING = "999999-99999"
CONSTANT cs_rt_design_sequence_no STRING = "99999"

CONSTANT cs_null_username_default STRING = "Tester"
CONSTANT cs_max_table_name_length STRING = "4" 

CONSTANT cs_default_optimizer_features_enable STRING = "11.2.0.3"

#Stored procedure name
CONSTANT cs_prc_get_col_default          STRING = "GET_COL_DEFAULT"
CONSTANT cs_prc_get_col_default_by_owner STRING = "GET_COL_DEFAULT_BY_OWNER"

#Backup, Recover Type
CONSTANT cs_bkrv_type_qc_pass   STRING = "PASS"
CONSTANT cs_bkrv_type_patch     STRING = "PATCH"
CONSTANT cs_bkrv_type_check_out STRING = "CHECK_OUT"

CONSTANT cs_bkrv_backup    STRING = "backup"
CONSTANT cs_bkrv_recovery  STRING = "recovery"

CONSTANT cs_env_debug_mode STRING = "TABLE_BUILDER_DEBUG" 

#Privileges
CONSTANT cs_priv_type_select     STRING = 'SELECT'
CONSTANT cs_priv_type_insert     STRING = 'INSERT'
CONSTANT cs_priv_type_update     STRING = 'UPDATE'
CONSTANT cs_priv_type_delete     STRING = 'DELETE'
CONSTANT cs_priv_type_alter      STRING = 'ALTER'
CONSTANT cs_priv_type_index      STRING = 'INDEX'
CONSTANT cs_priv_type_references STRING = 'REFERENCES'

#Logs
CONSTANT cs_logs_level_information STRING = "Information"
CONSTANT cs_logs_level_warning     STRING = "Warning"
CONSTANT cs_logs_level_error       STRING = "Error"

CONSTANT cs_logs_type_table    STRING = "Table"
CONSTANT cs_logs_type_column   STRING = "Column"
CONSTANT cs_logs_type_key      STRING = "Key"
CONSTANT cs_logs_type_index    STRING = "Index"
CONSTANT cs_logs_type_synonym  STRING = "Synonym"
CONSTANT cs_logs_type_view     STRING = "View"
CONSTANT cs_logs_type_trigger  STRING = "Trigger"

CONSTANT cs_logs_type_reserve_column STRING = "ReserveColumn"
CONSTANT cs_logs_type_drop_backdoor_column STRING = "DropBackdoorColumn"
CONSTANT cs_logs_type_set_drop_backdoor_column STRING = "SetDropBackDoorCols"

#Control if drop column that add by backend program
CONSTANT cs_rt_drop_backdoor_column STRING = "RT_DROP_BACKDOOR_COLUMN"
