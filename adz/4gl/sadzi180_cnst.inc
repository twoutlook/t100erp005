#Primary Key Constant
CONSTANT cs_dept              STRING = "None"
CONSTANT cs_enterprise        STRING = "99"

CONSTANT cs_synonym_shorthand STRING = "S"
CONSTANT cs_table_shorthand   STRING = "T"

CONSTANT cs_alter_table       STRING = "alttable"

CONSTANT cs_db_link_sign      STRING = "@"
CONSTANT cs_mdm_virtual_table STRING = "mdm_data" 
CONSTANT cs_mdm_module_name   STRING = "MDM" 

CONSTANT cs_plm_virtual_table STRING = "plm_data" 
CONSTANT cs_plm_module_name   STRING = "PLM" 

CONSTANT cs_null_username_default STRING = "Tester"

CONSTANT cs_mdf_type_new    STRING = "NEW"
CONSTANT cs_mdf_type_modify STRING = "MODIFY"
CONSTANT cs_mdf_type_std_to_cust STRING = "STD_TO_CUST"   #標準轉客制  --DGW07558_add_at20151215
CONSTANT cs_mdf_type_cust_to_std STRING = "CUST_TO_STD"   #客制還原標準  --DGW07558_add_at20151215
#Parameter Level define
CONSTANT cs_param_level_db_define STRING = "DBDefine"

#DBDefine Level
CONSTANT cs_param_mdm_db     STRING = "MDMDB"
CONSTANT cs_param_trigger_db STRING = "TriggerDB"

CONSTANT cs_response_cancel STRING = "cancel" 
#CONSTANT cs_response_yes    STRING = "yes"    
#CONSTANT cs_response_no     STRING = "no" 

CONSTANT cs_mdm_arg_chk_diff STRING = "chkdiff" #帶入參數，用於比較表格差異 --DGW07558_add_at20151120
