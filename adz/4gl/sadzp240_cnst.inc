
&ifndef DEBUG
#CONSTANT cs_patch_path = "/u6/scm/t10/erp/adz"
CONSTANT cs_patch_path = "/u6/scm"
&else
CONSTANT cs_patch_path = "c:\\temp"
&endif

CONSTANT cs_tag_table_pack_path = "[Table_Pack_Path]"
CONSTANT cs_tag_table_pack_name = "[Table_Pack_Name]"
CONSTANT cs_tag_pack_full_name  = "[Pack_Full_Name]"

CONSTANT cs_patch_file = "adzp230_table.xml"

CONSTANT cs_table_export_list = "table_export_list.vfy"

CONSTANT cs_default_export_ext = "tgz"
CONSTANT cs_default_export_name = "TABLE_EXPORT_PACKAGE"

CONSTANT cs_working_dir_type_patch  = "ipatch"
CONSTANT cs_working_dir_type_subpkg = "isubpkg"

#CONSTANT cs_default_lang  STRING = "zh_TW"

#CONSTANT cs_null_value = "#$%&"
CONSTANT cs_UsingFormat STRING = "&&&&&"

CONSTANT cs_run_background_sign = '&'

#Level Kind
CONSTANT cs_param_level_pack     STRING = "Pack"
CONSTANT cs_param_level_resource STRING = "Resource"
CONSTANT cs_param_level_log      STRING = "Log"
CONSTANT cs_param_level_alter    STRING = "Alter"

#Pack Level
CONSTANT cs_param_table_per_package STRING = "TablePerPackage"

#System Level
CONSTANT cs_param_using_cpu_resource STRING = "UsingCPUResource"

#Log Level
CONSTANT cs_param_reserve_days STRING = "ReserveDays"
CONSTANT cs_default_log_reserve_days STRING = "60"

#Alter Level
CONSTANT cs_param_force_making_alter STRING = "ForceMakingAlter"

CONSTANT cs_state_waiting    = "W" -- Waiting
CONSTANT cs_state_assigned   = "A" -- Assigned
CONSTANT cs_state_processing = "P" -- Processing
CONSTANT cs_state_finished   = "F" -- Finished
CONSTANT cs_state_error      = "E" -- Error
CONSTANT cs_state_manually   = "M" -- Manually
CONSTANT cs_state_cancel     = "X" -- Cancel

