#Primary Key Constant
CONSTANT cs_null_value        STRING = "!@#"      

CONSTANT cs_top_module_name   STRING = "TOP"
CONSTANT cs_database          STRING = "Database"

CONSTANT cs_alter_column      STRING = "altcol"
CONSTANT cs_alter_constraint  STRING = "altcons"
CONSTANT cs_drop_column       STRING = "drpcol"
CONSTANT cs_create_table      STRING = "crttbl"
CONSTANT cs_create_synonym    STRING = "crtsym"
CONSTANT cs_create_trigger    STRING = "crttrg"
CONSTANT cs_create_mtable     STRING = "crtmtbl"

CONSTANT cs_reversion         STRING = "rev"

CONSTANT cs_master_db         STRING = "ds"
CONSTANT cs_master_user       STRING = "ds"

CONSTANT cs_local_db          STRING = "local"

CONSTANT cs_question_yes      STRING = "yes"    
CONSTANT cs_question_no       STRING = "no" 

CONSTANT cs_result_success    STRING = "Success"    
CONSTANT cs_result_fail       STRING = "Fail" 
CONSTANT cs_result_cancel     STRING = "Cancel"    

CONSTANT cs_init_version_code STRING = '0'
CONSTANT cs_init_alm_ver_code STRING = '0'

CONSTANT cs_no_define          STRING = 'NoDefine'
 
CONSTANT cs_template_words    STRING = "template"

CONSTANT cs_sql_go_sign       STRING = "/"
CONSTANT cs_sql_exe_sign      STRING = ";"

CONSTANT cs_default_lang      STRING = "zh_TW"

CONSTANT cs_order_by_asc      STRING = "ASC"
CONSTANT cs_order_by_desc     STRING = "DESC"

CONSTANT cs_message_hint      STRING = "Hint"
CONSTANT cs_message_warning   STRING = "Warning"
CONSTANT cs_message_error     STRING = "Error"

CONSTANT cs_export_import_ext   STRING = "json"
CONSTANT cs_export_verify_ext   STRING = "vfy"
CONSTANT cs_export_compress_ext STRING = "tvz"

CONSTANT cs_export_import_all_file STRING = '*.tvz'

CONSTANT cs_alter_type_add    STRING = "ADD"
CONSTANT cs_alter_type_modify STRING = "MODIFY"

CONSTANT cs_alm_table STRING = "DZLM_T"

#Parameter Level
CONSTANT cs_param_level_system  STRING = "System"
#System Level
CONSTANT cs_param_master_db    STRING = "MasterDB"
CONSTANT cs_param_master_user  STRING = "MasterUser"

CONSTANT cs_mdm_export   STRING = "iexp" 
CONSTANT cs_mdm_import   STRING = "iimp" 
CONSTANT cs_mdm_assemble STRING = "iasm" 
CONSTANT cs_mdm_delete   STRING = "idel" 
CONSTANT cs_mdm_drop     STRING = "idrp"
CONSTANT cs_mdm_alter    STRING = "ialt" 
CONSTANT cs_mdm_rebuild  STRING = "ireb" 

CONSTANT cs_mdm_construct_type_table   STRING = "MT" --mdm table
CONSTANT cs_mdm_construct_type_trigger STRING = "MG" --mdm trigger
CONSTANT cs_mdm_construct_type_view    STRING = "MV" --mdm view

CONSTANT cs_working_dir_type_assemble   STRING = "ASSEMBLE"
CONSTANT cs_working_dir_type_import     STRING = "IMPORT"
CONSTANT cs_working_dir_type_export     STRING = "EXPORT"
CONSTANT cs_working_dir_type_compress   STRING = "COMPRESS"
CONSTANT cs_working_dir_type_uncompress STRING = "UNCOMPRESS"

CONSTANT cs_working_unknow_object STRING = "UNKNOW"

CONSTANT cs_verify_file_export_notice STRING = "EXPORT_NOTICE"

CONSTANT cs_design_request_no  STRING = "999999-99999"
CONSTANT cs_design_request_seq STRING = "99999"
CONSTANT cs_design_sequence_no STRING = "99999"

CONSTANT cs_working_type_trigger STRING = "TRIGGER"
CONSTANT cs_working_type_view    STRING = "VIEW"
CONSTANT cs_working_type_mtable  STRING = "MTABLE"

#Parameter Level define
CONSTANT cs_param_level_lob  STRING = "LOB"

#LOB Level
CONSTANT cs_param_tablespace STRING = "Tablespace"

#Argument Types
CONSTANT cs_args_working_type         STRING = "-WT"
CONSTANT cs_args_construct_type       STRING = "-CT"
CONSTANT cs_args_working_object       STRING = "-WO"
CONSTANT cs_args_working_file         STRING = "-WF"
CONSTANT cs_args_working_path         STRING = "-WP"
--CONSTANT cs_args_working_full_name STRING = "-WFN"
CONSTANT cs_args_working_xml          STRING = "-XML"
CONSTANT cs_args_source_full_name     STRING = "-SFN"
CONSTANT cs_args_working_guid         STRING = "-GUID"
CONSTANT cs_args_show_dialog          STRING = "-SD"
CONSTANT cs_args_make_assemble        STRING = "-MA"
CONSTANT cs_args_make_rebuild         STRING = "-MR"
CONSTANT cs_args_backend_mode         STRING = "-BM"
CONSTANT cs_args_export_file_location STRING = "-EFL"

CONSTANT cs_dgenv_stand  VARCHAR = "s"  #standard
CONSTANT cs_dgenv_cust   VARCHAR = "c"  #customize

CONSTANT cs_alias_aws_db STRING = "awsdb"   #中台資料庫代號 in 預建構資料庫  --add at 20160322 by CircleLai
CONSTANT cs_alias_erp_db STRING = "erpdb"   #ERP資料庫代號 in 預建構資料庫  --add at 20160322 by CircleLai

-- 20160706 begin
CONSTANT cs_view_status_invalid   STRING = "X"
CONSTANT cs_view_status_created   STRING = "Y"
CONSTANT cs_view_status_uncreated STRING = "N"

CONSTANT cs_identify_aws_db STRING = "{AWSDB}"
CONSTANT cs_identify_erp_db STRING = "{ERPDB}"
CONSTANT cs_identify_mdm_db STRING = "{MDMDB}"

CONSTANT cs_view_head_begin_tag STRING = "<head>"
CONSTANT cs_view_head_end_tag   STRING = "</head>"

CONSTANT cs_view_body_begin_tag STRING = "<body>"
CONSTANT cs_view_body_end_tag   STRING = "</body>"

CONSTANT cs_view_create_tag STRING = "CREATE "
CONSTANT cs_view_as_tag     STRING = " AS"
-- 20160706 end
