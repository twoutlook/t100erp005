#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: sadzi888_04
#+ 設計人員......: ernest
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name : sadzi888_04.4gl 
# Description  : 表格資料匯出/匯入
#
#  異動型態    異動單號       日 期       異動者      異動內容
#  ========= ============= ========== ========== ===============================================
#  Modify                  2016.08.23 Ernestliou 1.修改抓取確認是否異動清單由字串改為暫存表格
#  Modify                  2016.08.28 Ernestliou 1.判斷不為 Patch 包才做 r.s ds 表格清單
#  Modify                  2016.10.11 Ernestliou 1.adzi800 匯出時改為抓取adzp999運行模式 7
#  Modify                  2016.12.26 Ernestliou 1.配合其他匯出修改(ex.APS)
#

&include "../4gl/sadzi140_mcr.inc"

IMPORT os
IMPORT security
IMPORT xml

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzi140_cnst.inc"
&include "../4gl/sadzp230_cnst.inc"
&include "../4gl/sadzp240_cnst.inc"

CONSTANT cs_patch_ext_xml         = "xml"
CONSTANT cs_tag_break_error       = "[BREAK_ERROR]"
CONSTANT cs_tag_backup_table_list = "[BACKUP_TABLE_LIST]"

CONSTANT cs_platform_type_erp = "ERP"
CONSTANT cs_platform_type_mdm = "MDM"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzi140_type.inc"
&include "../4gl/sadzp240_type.inc"

GLOBALS "../../cfg/top_global.inc"
&ifndef DEBUG
GLOBALS "../4gl/adzi888_global.inc" 
&endif
            
DEFINE             
  ms_DGENV      STRING,
  ms_MasterDB   STRING,
  ms_MasterUser STRING,
  ms_run_mode   STRING,
  ms_import_error_list   STRING,
  ms_default_export_name STRING

  
################################################################################
## Import  
################################################################################
             
FUNCTION sadzi888_04_import_run(p_tar_path,p_GUID,p_sequence)
DEFINE
  p_tar_path  STRING,
  p_GUID      STRING,
  p_sequence  STRING
DEFINE
  ls_tar_path          STRING,
  ls_GUID              STRING,
  ls_sequence          STRING,
  ls_request_no        STRING,
  li_sequence_no       INTEGER,
  ls_working_path      STRING,
  lb_result            BOOLEAN,
  ls_file_list         STRING,
  ls_separator         STRING,
  li_loop              INTEGER,
  li_lang_table        INTEGER,
  lo_db_connstr        T_DB_CONNSTR,
  ls_patch_no          STRING,
  ls_backup_tables     STRING,
  lb_error             BOOLEAN, 
  lb_success           BOOLEAN,
  lo_dzee_t            T_DZEE_T,
  lo_table_list        DYNAMIC ARRAY OF T_TABLE_LIST,
  lo_dzlm_erp_object_list   DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_dzlm_mdm_object_list   DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_revise_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ld_start_time        DATETIME YEAR TO SECOND,
  ld_end_time          DATETIME YEAR TO SECOND
  
  LET ls_tar_path = p_tar_path
  LET ls_GUID     = p_GUID
  LET ls_sequence = p_sequence
  
  LET ls_separator = os.Path.separator()

  LET ms_import_error_list = ""
  LET ms_default_export_name = cs_default_export_name,".",cs_default_export_ext

  #若是經由Patch manager 指定的, 要回填起始時間
  IF ls_GUID.trim() IS NOT NULL THEN 
    &ifndef DEBUG
      LET ld_start_time = cl_get_current()
    &else
      LET ld_start_time = CURRENT YEAR TO SECOND
    &endif
    LET lo_dzee_t.DZEE001 = ls_GUID
    LET lo_dzee_t.DZEE002 = ls_sequence
    LET lo_dzee_t.DZEE005 = cs_state_processing
    LET lo_dzee_t.DZEE007 = ld_start_time
    CALL sadzp240_intf_set_start_time(lo_dzee_t.*)
    CALL sadzp240_intf_set_status_code(lo_dzee_t.*)
  END IF  
  
  #取得DGENV
  LET ms_DGENV = FGL_GETENV("DGENV") 
  #取得Master DB 及 User
  CALL sadzi140_db_get_parameter(cs_param_level_system,cs_param_master_db) RETURNING ms_MasterDB
  CALL sadzi140_db_get_parameter(cs_param_level_system,cs_param_master_user) RETURNING ms_MasterUser

  #檢核 GET_COL_DEFAULT Stored function 是否有建
  CALL sadzi140_util_create_procedure(ms_MasterDB,ms_MasterUser,cs_prc_get_col_default,TRUE) RETURNING lb_error
  IF lb_error THEN DISPLAY cs_error_tag,"[adz-00469] Create crtical stored procedure/function fail." GOTO _EXIT END IF 
  #解壓縮 
  CALL sadzi888_04_get_and_untar_package(ls_tar_path) RETURNING lb_result,ls_working_path
  IF NOT lb_result THEN GOTO _EXIT END IF
  
  #取得ERP匯入表格清單
  CALL sadzi888_04_get_vfy_object_list(ls_working_path,cs_platform_type_erp) RETURNING lb_result,lo_dzlm_erp_object_list,ls_patch_no
  IF NOT lb_result THEN GOTO _EXIT END IF 
  #取得MDM匯入表格清單
  CALL sadzi888_04_get_vfy_object_list(ls_working_path,cs_platform_type_mdm) RETURNING lb_result,lo_dzlm_mdm_object_list,ls_patch_no
  IF NOT lb_result THEN GOTO _EXIT END IF 

  LET lb_success = TRUE
  #匯入ERP表格
  CALL sadzi888_04_import_erp_objects(lo_dzlm_erp_object_list,ls_patch_no,ls_GUID,ls_sequence) RETURNING lb_result
  IF NOT lb_result THEN LET lb_success = FALSE END IF 
  #匯入MDM物件
  CALL sadzi888_04_import_mdm_objects(lo_dzlm_mdm_object_list,ls_patch_no,ls_GUID,ls_sequence) RETURNING lb_result
  IF NOT lb_result THEN LET lb_success = FALSE END IF
  
  LABEL _CHECK:

  IF NOT lb_success THEN
    #有錯要回填Patch Manager清單為Error
    IF ls_GUID.trim() IS NOT NULL THEN 
      LET lo_dzee_t.DZEE001 = ls_GUID
      LET lo_dzee_t.DZEE002 = ls_sequence
      LET lo_dzee_t.DZEE005 = cs_state_error
      CALL sadzp240_intf_set_status_code(lo_dzee_t.*)
    END IF  
  ELSE 
    #回填Patch Manager清單為成功
    IF ls_GUID.trim() IS NOT NULL THEN 
      LET lo_dzee_t.DZEE001 = ls_GUID
      LET lo_dzee_t.DZEE002 = ls_sequence
      LET lo_dzee_t.DZEE005 = cs_state_finished
      CALL sadzp240_intf_set_status_code(lo_dzee_t.*)
    END IF  
  END IF
  
  #顯示有錯誤的清單
  DISPLAY cs_tag_break_error,"Import object error list :","\n",ms_import_error_list 
  
  LABEL _EXIT:

  #若是經由Patch manager 指定的, 要回填結束時間
  IF ls_GUID.trim() IS NOT NULL THEN 
    &ifndef DEBUG
      LET ld_end_time = cl_get_current()
    &else
      LET ld_end_time = CURRENT YEAR TO SECOND
    &endif
    LET lo_dzee_t.DZEE001 = ls_GUID
    LET lo_dzee_t.DZEE002 = ls_sequence
    LET lo_dzee_t.DZEE008 = ld_end_time
    #將Log內容回寫到資料庫中
    CALL sadzp240_intf_set_log_file_contents(lo_dzee_t.*)
    #回填結束時間
    CALL sadzp240_intf_set_end_time(lo_dzee_t.*)
  END IF    
  
  RETURN lb_result
  
END FUNCTION 

FUNCTION sadzi888_04_gen_table_schema(p_dzlm_table_list)
DEFINE
  p_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_list_cnt        INTEGER,
  lb_success         BOOLEAN,
  ls_table_list      STRING
DEFINE 
  lb_return  BOOLEAN

  LET lo_dzlm_table_list = p_dzlm_table_list

  LET lb_success = TRUE
  LET ls_table_list = ""
  
  FOR li_list_cnt = 1 TO lo_dzlm_table_list.getLength()
    LET ls_table_list = ls_table_list,",",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002
  END FOR 

  IF (ls_table_list.trim() IS NOT NULL) AND (ls_table_list.trim() <> ",") THEN
    DISPLAY cs_information_tag," Generate ds.sch and gztz_t data."   
    LET ls_table_list = ls_table_list.subString(2,ls_table_list.getLength())
    CALL sadzi888_04_gen_db_schema(ms_MasterUser.toLowerCase(),ls_table_list) RETURNING lb_success
  END IF 

  LET lb_return = lb_success

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzi888_04_gen_multi_lang_file(p_dzlm_table_list)
DEFINE
  p_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_list_cnt        INTEGER,
  lb_success         BOOLEAN,
  ls_table_list      STRING
DEFINE 
  lb_error   BOOLEAN,
  lb_return  BOOLEAN

  LET lo_dzlm_table_list = p_dzlm_table_list

  LET lb_success = TRUE
  LET lb_error = FALSE 
  LET ls_table_list = ""
  
  DISPLAY cs_information_tag," Generate multi language programs."   
  FOR li_list_cnt = 1 TO lo_dzlm_table_list.getLength()
    IF lo_dzlm_table_list[li_list_cnt].dtl_table_type = "L" THEN
      CALL sadzi888_04_gen_multi_lang(lo_dzlm_table_list[li_list_cnt].dtl_DZLM002) RETURNING lb_success
      IF NOT lb_success THEN LET lb_error = TRUE END IF 
    END IF 
  END FOR 

  LET lb_return = NOT lb_error

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzi888_04_gen_extend_inc_file(p_dzlm_table_list)
DEFINE
  p_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_list_cnt        INTEGER,
  lb_success         BOOLEAN,
  ls_table_list      STRING
DEFINE 
  lb_error   BOOLEAN,
  lb_return  BOOLEAN

  LET lo_dzlm_table_list = p_dzlm_table_list

  LET lb_success = TRUE
  LET lb_error = FALSE 
  LET ls_table_list = ""
  
  DISPLAY cs_information_tag," Generate extend inc files."   
  FOR li_list_cnt = 1 TO lo_dzlm_table_list.getLength()
    CALL sadzi888_04_gen_extend_inc(lo_dzlm_table_list[li_list_cnt].dtl_DZLM002) RETURNING lb_success
    IF NOT lb_success THEN LET lb_error = TRUE END IF 
  END FOR 

  LET lb_return = NOT lb_error

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzi888_04_recompile_invalid_db_objects(p_dzlm_table_list)
DEFINE
  p_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_list_cnt        INTEGER,
  lb_success         BOOLEAN,
  ls_table_list      STRING
DEFINE 
  lb_error   BOOLEAN,
  lb_return  BOOLEAN

  LET lo_dzlm_table_list = p_dzlm_table_list

  LET lb_success = TRUE
  LET lb_error = FALSE 
  LET ls_table_list = ""
  
  DISPLAY cs_information_tag," Recompile invalid objects."   
  FOR li_list_cnt = 1 TO lo_dzlm_table_list.getLength()
    CALL sadzi888_04_recompile_invalid_object(lo_dzlm_table_list[li_list_cnt].dtl_DZLM002) RETURNING lb_success
    IF NOT lb_success THEN LET lb_error = TRUE END IF 
  END FOR 

  LET lb_return = NOT lb_error

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzi888_04_gen_table_structure_file(p_dzlm_table_list)
DEFINE
  p_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_list_cnt        INTEGER,
  lb_success         BOOLEAN,
  ls_table_list      STRING,
  li_loop            INTEGER,
  ls_table_name      STRING,
  ls_module_name     STRING,
  ls_module_env      STRING,
  ls_lang            STRING,
  ls_tbl_Name        STRING,
  ls_separator       STRING,
  ls_schema_sql      STRING,
  lb_result          BOOLEAN,
  lo_lang_arr        DYNAMIC ARRAY OF T_LANGUAGE_TYPE
DEFINE 
  lb_error   BOOLEAN,
  lb_return  BOOLEAN

  LET lo_dzlm_table_list = p_dzlm_table_list

  LET lb_success = TRUE
  LET lb_error = FALSE 
  LET ls_table_list = ""
  LET ls_separator = os.Path.separator()
  
  DISPLAY cs_information_tag," Generate table structure file."

  -- 依照多語言產出對應的 tbl 檔
  CALL sadzi140_xml_get_lang_type_list() RETURNING lo_lang_arr
  
  FOR li_list_cnt = 1 TO lo_dzlm_table_list.getLength()
  
    LET ls_table_name  = lo_dzlm_table_list[li_list_cnt].dtl_DZLM002
    LET ls_module_name = lo_dzlm_table_list[li_list_cnt].dtl_module
    
    LET ls_module_env  = FGL_GETENV(ls_module_name)
    
    FOR li_loop = 1 TO lo_lang_arr.getLength()
      LET ls_lang = lo_lang_arr[li_loop]
      &ifndef DEBUG
      LET ls_tbl_Name = ls_module_env,ls_separator,"dzx",ls_separator,"tbl",ls_separator,ls_lang,ls_separator,ls_table_name,".tbl"
      &else
      #Local debug 用
      LET ls_tbl_Name = "c:\\temp\\tbl\\",ls_table_name,"_",ls_lang,".tbl"
      &endif
      DISPLAY cs_information_tag," Generate tbl File :",ls_tbl_Name 
      CALL sadzi140_xml_gen_table_describe(ls_table_name,ls_tbl_Name,ls_lang) RETURNING lb_result
      CALL sadzi140_db_gen_table_schema(ls_table_name,ls_module_name,TRUE,ls_lang) RETURNING ls_schema_sql
    END FOR   
    
  END FOR 

  LET lb_return = NOT lb_error

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzi888_04_gen_db_schema(p_db_owner,p_table_name)
DEFINE
  p_db_owner   STRING,
  p_table_name STRING 
DEFINE
  ls_db_owner   STRING,
  ls_table_name STRING, 
  ls_command    STRING,
  lb_success    BOOLEAN,
  ls_message    STRING

  LET ls_db_owner   = p_db_owner
  LET ls_table_name = p_table_name

  LET lb_success = TRUE
  
  LET ls_command = "r.s ",ls_db_owner.trim()," ",ls_table_name.trim()
  
  DISPLAY cs_command_tag,ls_command

  &ifndef DEBUG
  CALL cl_cmdrun_openpipe("r.s",ls_command,TRUE) RETURNING lb_success,ls_message
  &endif

  RETURN lb_success

END FUNCTION

FUNCTION sadzi888_04_gen_multi_lang(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name STRING,
  ls_command    STRING,
  lb_success    BOOLEAN,
  ls_message    STRING  

  LET ls_table_name = p_table_name
  
  LET lb_success = TRUE
  
  LET ls_command = "r.r adzp140 ",ls_table_name CLIPPED
  DISPLAY cs_command_tag,ls_command

  &ifndef DEBUG
  RUN ls_command WITHOUT WAITING
  #CALL cl_cmdrun_openpipe("adzp140",ls_command,TRUE) RETURNING lb_success,ls_message
  &endif

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzi888_04_gen_extend_inc(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name STRING,
  ls_command    STRING,
  lb_success    BOOLEAN,
  ls_message    STRING  

  LET ls_table_name = p_table_name
  
  LET lb_success = TRUE
  
  LET ls_command = "r.r adzp156 ",ls_table_name CLIPPED
  DISPLAY cs_command_tag,ls_command

  &ifndef DEBUG
  RUN ls_command WITHOUT WAITING
  #CALL cl_cmdrun_openpipe("adzp156",ls_command,TRUE) RETURNING lb_success,ls_message
  &endif

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzi888_04_recompile_invalid_object(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name STRING,
  ls_command    STRING,
  lb_success    BOOLEAN,
  ls_message    STRING  

  LET ls_table_name = p_table_name
  
  LET lb_success = TRUE
  
  LET ls_command = "r.r adzp320 -T ",ls_table_name CLIPPED
  DISPLAY cs_command_tag,ls_command

  &ifndef DEBUG
  RUN ls_command WITHOUT WAITING
  #CALL cl_cmdrun_openpipe("adzp156",ls_command,TRUE) RETURNING lb_success,ls_message
  &endif

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzi888_04_import_erp_table(p_dzlm_table_list,p_patch_no,p_guid)
DEFINE
  p_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  p_patch_no        STRING, 
  p_guid            STRING
DEFINE
  lo_dzlm_table_list     DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_patch_no            STRING, 
  ls_guid                STRING,
  lo_revise_table_list   DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_import_parameters   T_DZLM_T_SCR,
  lo_import_info         T_EXPORT_INFO,
  lo_dzez_t              T_DZEZ_T,
  li_list_cnt            INTEGER,
  li_revise_table_list   INTEGER,
  ls_enable_backup_trunc STRING,
  lb_error               BOOLEAN,
  lb_diff                BOOLEAN,
  ls_new_version         STRING,
  ls_message             STRING,
  lb_truncted            BOOLEAN,
  lb_result              BOOLEAN,
  ls_force_making_alter  STRING,
  lb_altered             BOOLEAN  
DEFINE
  lo_return DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lb_return BOOLEAN

  LET lo_dzlm_table_list = p_dzlm_table_list
  LET ls_patch_no = p_patch_no
  LET ls_guid = p_guid
  
  LET lb_error = FALSE
  LET lb_diff  = FALSE
  LET ls_force_making_alter = "Y"
  LET li_revise_table_list = 0

  #是否強迫執行異動 
  CALL sadzp240_util_get_parameter(cs_param_level_alter,cs_param_force_making_alter) RETURNING ls_force_making_alter
  LET ls_force_making_alter = NVL(ls_force_making_alter,"Y")

  FOR li_list_cnt = 1 TO lo_dzlm_table_list.getLength()
    IF NVL(lo_dzlm_table_list[li_list_cnt].dtl_DZLM001,"T") = "T" THEN
      LET lo_import_parameters.DZLM002 = lo_dzlm_table_list[li_list_cnt].dtl_DZLM002   #TableName
      LET lo_import_parameters.DZLM005 = lo_dzlm_table_list[li_list_cnt].dtl_DZLM005   #ConstructVersion
      LET lo_import_parameters.DZLM006 = lo_dzlm_table_list[li_list_cnt].dtl_DZLM006   #SD_Version
      LET lo_import_parameters.DZLM012 = lo_dzlm_table_list[li_list_cnt].dtl_DZLM012   #需求單號
      LET lo_import_parameters.DZLM015 = lo_dzlm_table_list[li_list_cnt].dtl_DZLM015   #序號    

      #GUID 不為空白, 表示是為Patch Manager給的,要回呼更新驗證檔案
      IF ls_GUID.trim() IS NOT NULL THEN  
        BEGIN WORK 
        LET lo_dzez_t.DZEZ001 = ls_GUID
        LET lo_dzez_t.DZEZ002 = lo_dzlm_table_list[li_list_cnt].dtl_DZLM002
        LET lo_dzez_t.DZEZ003 = cs_state_processing
        LET lo_dzez_t.DZEZ004 = ls_patch_no
        CALL sadzp240_vfy_set_status_code(lo_dzez_t.*)
        CALL sadzp240_vfy_set_sub_pack_name(lo_dzez_t.*)
        CALL sadzp240_vfy_set_start_time(lo_dzez_t.*)
        COMMIT WORK
      END IF 

      #先做Verify
      LET lb_diff = FALSE
      LET lo_import_parameters.TYPES = cs_exim_verify  #ivfy
      CALL sadzp220_run(TRUE,lo_import_parameters.*) RETURNING lo_import_info.*
      IF lo_import_info.RESULT THEN #回傳TRUE表示有差異
        LET lb_diff = TRUE
        DISPLAY cs_message_tag,"There are something different with table : ",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002
      ELSE  
        DISPLAY cs_message_tag,"There is not any different with table : ",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002," skip alter table."
      END IF 
      #檢核表格是否先前已經異動成功
      CALL sadzi888_04_check_erp_table_if_altered(lo_dzlm_table_list[li_list_cnt].dtl_DZLM002) RETURNING lb_altered
      IF NOT lb_altered THEN DISPLAY cs_warning_tag,"The table ",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002," may not be altered." END IF 

      #比對有差異或者強迫異動設定為"Y"或者表格沒有異動成功都要執行異動
      IF lb_diff OR (ls_force_making_alter = "Y") OR (NOT lb_altered) THEN 
        #20161220 begin
        #先貼標
        CALL sadzi140_util_toggle_columns_comments(lo_dzlm_table_list[li_list_cnt].dtl_DZLM002 ) RETURNING lb_result
        #20161220 end
        #做Import
        LET lo_import_parameters.TYPES = cs_exim_import  #iimp
        CALL sadzp220_run(TRUE,lo_import_parameters.*) RETURNING lo_import_info.*
        IF lo_import_info.RESULT THEN #回傳TRUE表示失敗
          LET lb_error = TRUE
          #回填表格異動狀態碼
          CALL sadzi888_04_set_verify_status(ls_GUID,lo_dzez_t.*,cs_state_error)
          DISPLAY cs_error_tag," Import table ",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002 
          LET ms_import_error_list = ms_import_error_list,"[",cs_exim_import,"]",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002,"\n"
          CONTINUE FOR 
        ELSE
          DISPLAY cs_success_tag," Import table ",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002 
        END IF 

        #做異動
        LET lb_truncted = FALSE
        LABEL _REVISE:
        
        LET lo_import_parameters.TYPES = cs_exim_assemble #iasm
        CALL sadzp220_run(TRUE,lo_import_parameters.*) RETURNING lo_import_info.*
        IF lo_import_info.RESULT THEN #回傳TRUE表示失敗
          #取得是否有啟動備份及Truncate Table機制
          CALL sadzi140_db_get_parameter(cs_param_level_alm,cs_param_enable_backup_trunc) RETURNING ls_enable_backup_trunc
          IF ls_enable_backup_trunc = "Y" THEN 
            IF NOT lb_truncted THEN 
              #將各Schema備份後, 執行Truncate
              CALL sadzi888_04_backup_and_truncate_table(lo_dzlm_table_list[li_list_cnt].dtl_DZLM002, ls_patch_no) RETURNING lb_result
              IF lb_result THEN   
                LET lb_truncted = TRUE
                DISPLAY cs_success_tag,"Backup and truncate table ",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002
                GOTO _REVISE
              END IF   
            END IF
          END IF  
          LET lb_error = TRUE
          #回填表格異動狀態碼
          CALL sadzi888_04_set_verify_status(ls_GUID,lo_dzez_t.*,cs_state_error)
          DISPLAY cs_error_tag," Revise table ",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002 
          LET ms_import_error_list = ms_import_error_list,"[",cs_exim_assemble,"]",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002,"\n"
          CONTINUE FOR 
        ELSE
          DISPLAY cs_success_tag," Revise table ",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002 
        END IF

        #做Rebuild
        LET lo_import_parameters.TYPES = cs_exim_rebuild #ireb
        CALL sadzp220_run(TRUE,lo_import_parameters.*) RETURNING lo_import_info.*
        IF lo_import_info.RESULT THEN #回傳TRUE表示失敗
          LET lb_error = TRUE
          #回填表格異動狀態碼
          CALL sadzi888_04_set_verify_status(ls_GUID,lo_dzez_t.*,cs_state_error)
          DISPLAY cs_error_tag," Rebuild table ",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002 
          LET ms_import_error_list = ms_import_error_list,"[",cs_exim_rebuild,"]",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002,"\n"
          CONTINUE FOR 
        ELSE
          DISPLAY cs_success_tag," Rebuild table ",lo_dzlm_table_list[li_list_cnt].dtl_DZLM002 
        END IF

        #更新表格權限
        CALL sadzi140_util_grant_revoke_privileges(lo_dzlm_table_list[li_list_cnt].dtl_DZLM002) RETURNING ls_message
        
        #更新異動碼
        CALL sadzi140_db_update_alter_code(ms_MasterUser,lo_dzlm_table_list[li_list_cnt].dtl_DZLM002)
        
        #產生及取得新快照版本版號
        CALL sadzi140_vcs_get_new_version_code(lo_dzlm_table_list[li_list_cnt].dtl_DZLM002,FALSE,FALSE,FALSE,TRUE,1) RETURNING ls_new_version
        CALL sadzi140_shot_create_snapshot(ms_MasterUser,lo_dzlm_table_list[li_list_cnt].dtl_DZLM002,"",ls_new_version,lo_dzlm_table_list[li_list_cnt].dtl_DZLM005,lo_dzlm_table_list[li_list_cnt].dtl_DZLM012,ms_dgenv)

        #異動成功的表格做紀錄, 以進行後面的 r.s 和 gen multi lang file
        LET li_revise_table_list = li_revise_table_list + 1 
        LET lo_revise_table_list[li_revise_table_list].* = lo_dzlm_table_list[li_list_cnt].*
      END IF  

      #回填表格異動狀態碼
      CALL sadzi888_04_set_verify_status(ls_GUID,lo_dzez_t.*,cs_state_finished)
      
    END IF    
  END FOR

  LET lo_return = lo_revise_table_list
  LET lb_return = NOT lb_error

  RETURN lb_return,lo_return
  
END FUNCTION 

FUNCTION sadzi888_04_import_mdm_single_object(p_dzlm_object_list,p_patch_no,p_guid)
DEFINE
  p_dzlm_object_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  p_patch_no         STRING, 
  p_guid             STRING
DEFINE
  lo_dzlm_object_list    DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_patch_no            STRING, 
  ls_guid                STRING,
  lo_revise_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_import_parameters   T_DZLM_T_SCR,
  lo_import_info         T_EXPORT_INFO,
  lo_dzez_t              T_DZEZ_T,
  li_list_cnt            INTEGER,
  li_revise_table_list   INTEGER,
  ls_enable_backup_trunc STRING,
  lb_error               BOOLEAN,
  ls_new_version         STRING,
  lb_truncted            BOOLEAN,
  lb_result              BOOLEAN 
DEFINE
  lo_return DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lb_return BOOLEAN

  LET lo_dzlm_object_list = p_dzlm_object_list
  LET ls_patch_no = p_patch_no
  LET ls_guid = p_guid
  
  LET lb_error = FALSE
  LET li_revise_table_list = 0

  FOR li_list_cnt = 1 TO lo_dzlm_object_list.getLength()
    IF NVL(lo_dzlm_object_list[li_list_cnt].dtl_DZLM001,"T") <> "T" THEN 
      LET lo_import_parameters.DZLM002 = lo_dzlm_object_list[li_list_cnt].dtl_DZLM002   #ObjectName
      LET lo_import_parameters.DZLM001 = lo_dzlm_object_list[li_list_cnt].dtl_DZLM001   #ObjectType
      LET lo_import_parameters.DZLM005 = lo_dzlm_object_list[li_list_cnt].dtl_DZLM005   #ConstructVersion
      LET lo_import_parameters.DZLM006 = lo_dzlm_object_list[li_list_cnt].dtl_DZLM006   #SD_Version
      LET lo_import_parameters.DZLM012 = lo_dzlm_object_list[li_list_cnt].dtl_DZLM012   #需求單號
      LET lo_import_parameters.DZLM015 = lo_dzlm_object_list[li_list_cnt].dtl_DZLM015   #序號    

      #GUID 不為空白, 表示是為Patch Manager給的,要回呼更新驗證檔案
      IF ls_GUID.trim() IS NOT NULL THEN  
        BEGIN WORK 
        LET lo_dzez_t.DZEZ001 = ls_GUID
        LET lo_dzez_t.DZEZ002 = lo_dzlm_object_list[li_list_cnt].dtl_DZLM002
        LET lo_dzez_t.DZEZ003 = cs_state_processing
        LET lo_dzez_t.DZEZ004 = ls_patch_no
        CALL sadzp240_vfy_set_status_code(lo_dzez_t.*)
        CALL sadzp240_vfy_set_sub_pack_name(lo_dzez_t.*)
        CALL sadzp240_vfy_set_start_time(lo_dzez_t.*)
        COMMIT WORK
      END IF 
      
      #Import
      LET lo_import_parameters.TYPES = cs_exim_import  #iimp
      CALL sadzp310_adpt_patch_run(TRUE,lo_import_parameters.*,lo_dzlm_object_list[li_list_cnt].*) RETURNING lo_import_info.*
      IF lo_import_info.RESULT THEN #回傳TRUE表示失敗
        LET lb_error = TRUE
        #回填表格異動狀態碼
        CALL sadzi888_04_set_verify_status(ls_GUID,lo_dzez_t.*,cs_state_error)
        DISPLAY cs_error_tag," Import mdm object ",lo_dzlm_object_list[li_list_cnt].dtl_DZLM002 
        LET ms_import_error_list = ms_import_error_list,"[",cs_exim_import,"]",lo_dzlm_object_list[li_list_cnt].dtl_DZLM002,"\n"
        CONTINUE FOR 
      ELSE
        DISPLAY cs_success_tag," Import mdm object ",lo_dzlm_object_list[li_list_cnt].dtl_DZLM002 
      END IF 

      #異動成功的物件做紀錄
      LET li_revise_table_list = li_revise_table_list + 1 
      LET lo_revise_object_list[li_revise_table_list].* = lo_dzlm_object_list[li_list_cnt].*

      #回填表格異動狀態碼
      CALL sadzi888_04_set_verify_status(ls_GUID,lo_dzez_t.*,cs_state_finished)
    END IF    
  END FOR

  LET lo_return = lo_revise_object_list
  LET lb_return = NOT lb_error

  RETURN lb_return,lo_return
  
END FUNCTION 

#回寫DZEZ_T的狀態碼及結束時間
FUNCTION sadzi888_04_set_verify_status(p_guid,p_dzez_t,p_status_code)
DEFINE
  p_guid        STRING,
  p_dzez_t      T_DZEZ_T,
  p_status_code STRING
DEFINE
  ls_guid        STRING,
  lo_dzez_t      T_DZEZ_T,
  ls_status_code STRING

  LET ls_guid = p_guid
  LET lo_dzez_t.* = p_dzez_t.*
  LET ls_status_code = p_status_code
  
  IF ls_GUID.trim() IS NOT NULL THEN  
    BEGIN WORK 
    LET lo_dzez_t.DZEZ003 = ls_status_code
    CALL sadzp240_vfy_set_status_code(lo_dzez_t.*)
    CALL sadzp240_vfy_set_end_time(lo_dzez_t.*)
    COMMIT WORK
  END IF 
    
END FUNCTION 

FUNCTION sadzi888_04_get_vfy_object_list(p_working_path,p_type)
DEFINE
  p_working_path  STRING,
  p_type          STRING
DEFINE 
  ls_working_path  STRING,
  ls_type          STRING,
  ls_request_no    STRING,
  ls_sequence_no   STRING,
  ls_vfy_file      STRING,
  ls_separator     STRING,
  li_count         INTEGER,
  li_records       INTEGER,
  lb_error         BOOLEAN,
  ls_patch_no      STRING,
  ls_object_type   STRING,
  lo_xml_file      xml.domDocument,
  lo_dom_node      xml.DomNode,
  lo_table_node    xml.DomNode,
  lo_dzlm_table_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lb_return  BOOLEAN,
  lo_return  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_return  STRING

  LET ls_working_path = p_working_path
  LET ls_type = p_type

  LET ls_separator = os.Path.separator()
  CALL lo_dzlm_table_list.clear()
  CALL lo_return.clear()

  LET lb_error = FALSE 

  LET ls_vfy_file = ls_working_path,ls_separator,cs_table_export_list

  LET lo_xml_file = xml.domDocument.create()
  
  TRY 
    CALL lo_xml_file.load(ls_vfy_file)
  CATCH 
    LET lb_error = TRUE
    DISPLAY cs_error_tag," Get verify file fault."
    GOTO _ERROR 
  END TRY
 
  LET lo_dom_node = lo_xml_file.getDocumentElement()
  LET ls_patch_no = lo_dom_node.getAttribute("patch_no")

  LET lo_table_node = lo_dom_node.getFirstChildElement()

  LET li_count = 1  
  LET li_records = 1
  
  WHILE (lo_table_node IS NOT NULL)

    LET ls_object_type = NVL(lo_table_node.getAttribute("type"),"T")
    
    CASE 
      #ERP
      WHEN ls_type = cs_platform_type_erp
        IF ls_object_type = "T" THEN 
          LET lo_dzlm_table_list[li_records].dtl_DZLM002    = lo_table_node.getAttribute("name") 
          LET lo_dzlm_table_list[li_records].dtl_DZLM001    = lo_table_node.getAttribute("type") 
          LET lo_dzlm_table_list[li_records].dtl_DZLM005    = lo_table_node.getAttribute("construct_version") 
          LET lo_dzlm_table_list[li_records].dtl_DZLM006    = lo_table_node.getAttribute("sd_version") 
          LET lo_dzlm_table_list[li_records].dtl_DZLM012    = lo_table_node.getAttribute("request_no") 
          LET lo_dzlm_table_list[li_records].dtl_DZLM015    = lo_table_node.getAttribute("sequence_no") 
          LET lo_dzlm_table_list[li_records].dtl_module     = lo_table_node.getAttribute("module") 
          LET lo_dzlm_table_list[li_records].dtl_table_type = lo_table_node.getAttribute("table_type") 
          LET lo_dzlm_table_list[li_records].dtl_tar_name   = lo_table_node.getAttribute("tar_name") 
          LET lo_dzlm_table_list[li_records].dtl_tar_path   = ls_working_path
          LET lo_dzlm_table_list[li_records].dtl_tar_full_name = ls_working_path,ls_separator,lo_table_node.getAttribute("tar_name")
          LET li_records = li_records + 1  
        END IF
      #MDM  
      WHEN ls_type = cs_platform_type_mdm
        IF ls_object_type LIKE "M%" THEN 
          LET lo_dzlm_table_list[li_records].dtl_DZLM002    = lo_table_node.getAttribute("name") 
          LET lo_dzlm_table_list[li_records].dtl_DZLM001    = lo_table_node.getAttribute("type") 
          LET lo_dzlm_table_list[li_records].dtl_DZLM005    = lo_table_node.getAttribute("construct_version") 
          LET lo_dzlm_table_list[li_records].dtl_DZLM006    = lo_table_node.getAttribute("sd_version") 
          LET lo_dzlm_table_list[li_records].dtl_DZLM012    = lo_table_node.getAttribute("request_no") 
          LET lo_dzlm_table_list[li_records].dtl_DZLM015    = lo_table_node.getAttribute("sequence_no") 
          LET lo_dzlm_table_list[li_records].dtl_module     = lo_table_node.getAttribute("module") 
          LET lo_dzlm_table_list[li_records].dtl_table_type = lo_table_node.getAttribute("table_type") 
          LET lo_dzlm_table_list[li_records].dtl_tar_name   = lo_table_node.getAttribute("tar_name") 
          LET lo_dzlm_table_list[li_records].dtl_tar_path   = ls_working_path
          LET lo_dzlm_table_list[li_records].dtl_tar_full_name = ls_working_path,ls_separator,lo_table_node.getAttribute("tar_name") 
          LET li_records = li_records + 1  
        END IF
    END CASE
    
    LET li_count = li_count + 1 
    
    LET lo_table_node = lo_table_node.getNextSiblingElement()
    
  END WHILE 

  LET lo_return = lo_dzlm_table_list
  LET ls_return = ls_patch_no

  LABEL _ERROR:

  LET lb_return = NOT lb_error
  
  RETURN lb_return,lo_return,ls_return
  
END FUNCTION

FUNCTION sadzi888_04_get_and_untar_package(p_tar_full_path)
DEFINE
  p_tar_full_path STRING
DEFINE
  ls_working_path STRING,
  ls_tar_path     STRING,
  ls_tar_name     STRING,  
  ls_src_path     STRING,
  ls_dst_path     STRING,
  ls_os_separator STRING,
  ls_message      STRING,
  ls_TARString    STRING,
  ls_ext_name     STRING,
  lb_result       BOOLEAN,
  lb_error        BOOLEAN 
DEFINE
  lb_return BOOLEAN  

  LET ls_tar_path = os.Path.dirName(p_tar_full_path)
  LET ls_tar_name = os.Path.basename(p_tar_full_path)

  LET ls_ext_name = os.path.extension(ls_tar_name)
  IF NVL(ls_ext_name,cs_null_value) <> cs_default_export_ext THEN
    LET ls_tar_path = p_tar_full_path
    LET ls_tar_name = ms_default_export_name
  END IF 

  LET lb_error = FALSE 
  
  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  #建立工作目錄
  CALL sadzi888_04_making_work_directory(cs_working_dir_type_import) RETURNING ls_working_path
  DISPLAY cs_information_tag,"Working Path : ",ls_working_path

  LET ls_src_path = ls_tar_path,ls_os_separator,ls_tar_name
  LET ls_dst_path = ls_working_path,ls_os_separator,ls_tar_name

  IF NOT os.Path.EXISTS(ls_src_path) THEN
    LET lb_error = TRUE
    LET ls_message = "The file that you want to unpack is not exists."
    DISPLAY cs_error_tag,ls_message
    GOTO _ERROR
  END IF

  CALL sadzi888_04_moving_file(ls_src_path,NULL,ls_dst_path,NULL) RETURNING lb_result
  IF NOT lb_result THEN
    LET lb_error = TRUE
    GOTO _ERROR
  END IF

  #Untar
  LET ls_TARString = "tar zxvf ",ls_tar_name
  RUN ls_TARString 
  
  LABEL _ERROR:  
  
  LET lb_return = NOT lb_error

  RETURN lb_return,ls_working_path  
  
END FUNCTION 

FUNCTION sadzi888_04_import_erp_objects(p_dzlm_erp_object_list,p_patch_no,p_GUID,p_sequence)
DEFINE 
  p_dzlm_erp_object_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  p_patch_no             STRING,
  p_GUID                 STRING,
  p_sequence             STRING
DEFINE 
  lo_dzlm_erp_object_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_patch_no             STRING,
  ls_GUID                 STRING,
  ls_sequence             STRING,
  lo_revise_table_list    DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_dzee_t               T_DZEE_T,
  lo_db_connstr           T_DB_CONNSTR,
  lo_table_list           DYNAMIC ARRAY OF T_TABLE_LIST,
  li_loop                 INTEGER, 
  ls_backup_tables        STRING,
  lb_result               BOOLEAN,
  lb_final_result         BOOLEAN 
DEFINE
  lb_return  BOOLEAN
  
  LET lo_dzlm_erp_object_list = p_dzlm_erp_object_list
  LET ls_patch_no             = p_patch_no
  LET ls_GUID                 = p_GUID
  LET ls_sequence             = p_sequence

  LET lb_final_result = TRUE

  #匯入及異動表格
  CALL sadzi888_04_import_erp_table(lo_dzlm_erp_object_list,ls_patch_no,ls_GUID) RETURNING lb_result,lo_revise_table_list
  IF NOT lb_result THEN LET lb_final_result = FALSE DISPLAY cs_error_tag,"Import table with more than one errors." END IF
  
  #Generate tbl,sch file
  CALL sadzi888_04_gen_table_structure_file(lo_revise_table_list) RETURNING lb_result
  IF NOT lb_result THEN LET lb_final_result = FALSE DISPLAY cs_error_tag,"Generate table tructure with more than one errors." END IF

  #2016.08.28 begin
  IF NOT (DOWNSHIFT(ls_patch_no.subString(1,1)) MATCHES "[a-z]") THEN
    #Gen ds.sch 和 gztz_t 資料
    CALL sadzi888_04_gen_table_schema(lo_revise_table_list) RETURNING lb_result
    IF NOT lb_result THEN LET lb_final_result = FALSE DISPLAY cs_error_tag,"Generate ds.sch not success." END IF
  END IF
  #2016.08.28 end

  #Gen 多語言程式檔及編譯
  CALL sadzi888_04_gen_multi_lang_file(lo_revise_table_list) RETURNING lb_result
  IF NOT lb_result THEN LET lb_final_result = FALSE DISPLAY cs_error_tag,"Generate multi language program not success." END IF

  #產生延伸檔
  CALL sadzi888_04_gen_extend_inc_file(lo_revise_table_list) RETURNING lb_result
  IF NOT lb_result THEN LET lb_final_result = FALSE DISPLAY cs_error_tag,"Generate extend inc file not success." END IF

  #重新編譯失效的資料庫物件
  CALL sadzi888_04_recompile_invalid_db_objects(lo_revise_table_list) RETURNING lb_result
  IF NOT lb_result THEN LET lb_final_result = FALSE DISPLAY cs_error_tag,"Recompile invalid db objects not success." END IF

  #呼叫產生 Grant 的SQL
  CALL sadzi140_db_get_db_connect_string(ms_MasterDB) RETURNING lo_db_connstr.*
  CALL sadzi140_db_grant_APS_privilege(lo_db_connstr.*,ms_MasterDB)

  #取出備份表格清單
  CALL sadzi888_04_get_backup_table_list(ls_patch_no) RETURNING lo_table_list
  IF lo_table_list.getLength() >= 1 THEN 
    FOR li_loop = 1 TO lo_table_list.getLength()
      LET ls_backup_tables = ls_backup_tables,",'",lo_table_list[li_loop].tl_TABLE_NAME,"'"
    END FOR 
    LET ls_backup_tables = ls_backup_tables.subString(2,ls_backup_tables.getLength())
    DISPLAY cs_tag_backup_table_list,ls_backup_tables
  END IF   
  
  LET lb_return = lb_final_result

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi888_04_import_mdm_objects(p_dzlm_erp_object_list,p_patch_no,p_GUID,p_sequence)
DEFINE 
  p_dzlm_erp_object_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  p_patch_no             STRING,
  p_GUID                 STRING,
  p_sequence             STRING
DEFINE 
  lo_dzlm_erp_object_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_patch_no             STRING,
  ls_GUID                 STRING,
  ls_sequence             STRING,
  lo_revise_table_list    DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_dzee_t               T_DZEE_T,
  lo_db_connstr           T_DB_CONNSTR,
  lo_table_list           DYNAMIC ARRAY OF T_TABLE_LIST,
  li_loop                 INTEGER, 
  ls_backup_tables        STRING,
  lb_result               BOOLEAN
DEFINE
  lb_return  BOOLEAN
  
  LET lo_dzlm_erp_object_list = p_dzlm_erp_object_list
  LET ls_patch_no             = p_patch_no
  LET ls_GUID                 = p_GUID
  LET ls_sequence             = p_sequence

  #匯入及異動表格
  CALL sadzi888_04_import_mdm_single_object(lo_dzlm_erp_object_list,ls_patch_no,ls_GUID) RETURNING lb_result,lo_revise_table_list
  
  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION
            
################################################################################

################################################################################
## Export  
################################################################################
             
FUNCTION sadzi888_04_export_run(p_patch_or_request_no,p_serial_no)
DEFINE
  p_patch_or_request_no  STRING,
  p_serial_no STRING
DEFINE
  ls_patch_or_request_no STRING,
  ls_serial_no           STRING,
  lo_export_info         DYNAMIC ARRAY OF T_EXPORT_INFO,
  lo_DZLM_TABLE_LIST     DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_PATCH_REQUEST_INFO  DYNAMIC ARRAY OF T_PATCH_REQUEST_INFO,
  lb_result              BOOLEAN,
  li_serial_num          INTEGER,
  li_request_cnt         INTEGER,
  ls_TAR_path            STRING,
  ls_TAR_name            STRING,
  ls_src_path            STRING,
  ls_dst_path            STRING, 
  ls_src_file            STRING,
  ls_dst_file            STRING, 
  ls_os_separator        STRING,
  ls_table_list          STRING,
  lb_altered             BOOLEAN,
  ls_zone                STRING,
  ls_guid                VARCHAR(50),
  ls_check_object_if_altered STRING,
  lb_check_object_if_altered BOOLEAN

  LET ls_patch_or_request_no = p_patch_or_request_no
  LET ls_serial_no = p_serial_no

  &ifndef DEBUG
  #adzp999運行模式(1:過單打包; 2:過單解包; 3:patch打包; 4:patch解包; 5:需求單打包; 6:需求單解包; 7:adzi800匯出打包)
  LET ms_run_mode = g_run_mode
  &else
  LET ms_run_mode = NULL
  &endif
  
  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  CALL FGL_GETENV("ZONE") RETURNING ls_zone

  #取得是否執行物件未異動完全的檢查
  CALL sadzi888_04_get_patch_parameter(cs_param_level_export,cs_param_check_object_if_altered) RETURNING ls_check_object_if_altered
  LET lb_check_object_if_altered = IIF(NVL(ls_check_object_if_altered,"N")=="Y",TRUE,FALSE)
  
  #2016.12.26 begin
  IF NVL(ls_serial_no.trim(),cs_null_value) = cs_exim_dump THEN 
    LET lo_PATCH_REQUEST_INFO[1].REQUEST_NO  = cs_rt_design_request_no   
    LET lo_PATCH_REQUEST_INFO[1].REQUEST_SEQ = cs_rt_design_sequence_no   
    LET lb_result = TRUE
  ELSE 
  #2016.12.26 end
    CALL sadzi888_04_get_sequence_guid() RETURNING li_serial_num,ls_guid
    #CALL sadzi888_04_generate_unload_xml(ls_patch_no)
    #CALL sadzi888_04_get_patch_table_list(ls_patch_no) RETURNING lb_result
    
    #若沒有給serial no, 表示給的是 Patch no, 抓 xml 檔
    IF ls_serial_no.trim() IS NULL THEN 
      CALL sadzi888_04_get_patch_table_list_by_xml(ls_patch_or_request_no) RETURNING lb_result,lo_PATCH_REQUEST_INFO
    ELSE
      LET lo_PATCH_REQUEST_INFO[1].REQUEST_NO  = ls_patch_or_request_no   
      LET lo_PATCH_REQUEST_INFO[1].REQUEST_SEQ = ls_serial_no   
      LET lb_result = TRUE
    END IF
  END IF #2016.12.26 

  IF lb_result THEN   

    #2016.12.26 begin
    IF NVL(ls_serial_no.trim(),cs_null_value) = cs_exim_dump THEN 
      CALL sadzi888_04_get_dzhe_table_list(ls_patch_or_request_no,lo_DZLM_TABLE_LIST) RETURNING lo_DZLM_TABLE_LIST
    ELSE
    #2016.12.26 end
      #用從 Patch 中取得的需求單及序號取得表格清單
      FOR li_request_cnt = 1 TO lo_PATCH_REQUEST_INFO.getLength()
        CALL sadzi888_04_get_dzlm_table_list(lo_PATCH_REQUEST_INFO[li_request_cnt].REQUEST_NO,lo_PATCH_REQUEST_INFO[li_request_cnt].REQUEST_SEQ,lo_DZLM_TABLE_LIST) RETURNING lo_DZLM_TABLE_LIST
      END FOR   

      #用從 Patch 中取得的需求單及序號取得MDM物件清單
      FOR li_request_cnt = 1 TO lo_PATCH_REQUEST_INFO.getLength()
        CALL sadzi888_04_get_dzlm_mdm_object_list(lo_PATCH_REQUEST_INFO[li_request_cnt].REQUEST_NO,lo_PATCH_REQUEST_INFO[li_request_cnt].REQUEST_SEQ,lo_DZLM_TABLE_LIST) RETURNING lo_DZLM_TABLE_LIST
      END FOR
    END IF #2016.12.26 

    #做過濾, 只抓最高版次的
    CALL sadzi888_04_table_list_filter(lo_DZLM_TABLE_LIST) RETURNING lo_DZLM_TABLE_LIST 

    #重新整理清單依照 ADZ,AZZ,AWS,Axx,MDM 排序
    CALL sadzi888_04_crate_sort_temp_table()
    CALL sadzi888_04_resort_object_list(lo_DZLM_TABLE_LIST) RETURNING lo_DZLM_TABLE_LIST
    CALL sadzi888_04_drop_sort_temp_table()

    IF lo_DZLM_TABLE_LIST.getLength() >= 1 THEN  

      LET lb_altered = TRUE
      LET ls_table_list = ""
      
      IF lb_check_object_if_altered THEN 
        #匯出前檢核是否有未經異動成功的表格或物件
        CALL sadzi888_04_check_object_if_altered_list(lo_DZLM_TABLE_LIST) RETURNING lb_altered,ls_table_list
        --LET lb_result = TRUE -- For test
      END IF  

      #若都異動完成,才可以進行匯出
      IF lb_altered THEN 
        CALL sadzi888_04_set_ddata(li_serial_num,ls_guid,lo_DZLM_TABLE_LIST) RETURNING lb_result
        CALL sadzi888_04_export_object(lo_DZLM_TABLE_LIST) RETURNING lb_result,lo_export_info
        CALL sadzi888_04_tar_exported_files(ls_patch_or_request_no,ls_serial_no,lo_export_info,lo_DZLM_TABLE_LIST) RETURNING lb_result,ls_TAR_path,ls_TAR_name
        -- 透過 adzp230 匯出, 則會將狀態碼設上去
        CALL sadzi888_04_update_pass_through_status_code(lo_DZLM_TABLE_LIST) RETURNING lb_result
        #如果匯出資訊包含.xml副檔名, 就把從工作目錄複製到xml所在目錄
        IF NVL(os.Path.extension(ls_patch_or_request_no),cs_null_default) = cs_patch_ext_xml THEN
          LET ls_src_path = ls_TAR_path
          LET ls_dst_path = os.Path.dirname(ls_patch_or_request_no),ls_os_separator,ls_TAR_name
          CALL sadzi888_04_moving_file(ls_src_path,NULL,ls_dst_path,NULL) RETURNING lb_result       
        END IF 
      ELSE
        DISPLAY cs_error_tag,"There are some table(s) not alter success in zone '",ls_zone,"', can not exporting : ",
                             ls_table_list
        DISPLAY cs_tag_break_error
      END IF    
    ELSE
      DISPLAY cs_warning_tag,"No any table could be exporting."
    END IF
    
  END IF

  RETURN lb_result,ls_TAR_path
  
END FUNCTION 

FUNCTION sadzi888_04_tar_exported_files(p_patch_or_request_no,p_serial_no,p_export_info,p_dzlm_table_list)
DEFINE
  p_patch_or_request_no STRING,
  p_serial_no           STRING,
  p_export_info         DYNAMIC ARRAY OF T_EXPORT_INFO,
  p_dzlm_table_list     DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  ls_patch_or_request_no  STRING,
  ls_serial_no            STRING,
  lo_export_info          DYNAMIC ARRAY OF T_EXPORT_INFO,
  lo_dzlm_table_list      DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_src_path     STRING,
  ls_dst_path     STRING,
  ls_message      STRING,
  ls_os_separator STRING,
  ls_working_path STRING,
  ls_TARString    STRING,
  ls_TARName      STRING,
  ls_TAR_path     STRING,
  ls_xml_path     STRING,
  ls_xml_patch_no STRING,
  lb_error        BOOLEAN,
  li_exp_cnt      INTEGER,
  lb_result       BOOLEAN
DEFINE
  lb_return  BOOLEAN 

  LET ls_patch_or_request_no = p_patch_or_request_no.trim()
  LET ls_serial_no           = p_serial_no
  LET lo_export_info         = p_export_info
  LET lo_dzlm_table_list     = p_dzlm_table_list

  LET lb_error = FALSE
  
  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  #建立工作目錄
  CALL sadzi888_04_making_work_directory(cs_working_dir_type_export) RETURNING ls_working_path
  DISPLAY cs_information_tag," Working Path : ",ls_working_path
  
  FOR li_exp_cnt = 1 TO lo_export_info.getLength()
    LET ls_src_path = lo_export_info[li_exp_cnt].WORKING_PATH,ls_os_separator,lo_export_info[li_exp_cnt].TAR_NAME
    LET ls_dst_path = ls_working_path,ls_os_separator,lo_export_info[li_exp_cnt].TAR_NAME

    CALL sadzi888_04_moving_file(ls_src_path,NULL,ls_dst_path,NULL) RETURNING lb_result

    IF NOT lb_result THEN
      LET lb_error = TRUE
      EXIT FOR
    END IF
    
  END FOR 
  IF lb_error THEN GOTO _ERROR END IF

  #產生清單
  IF NVL(os.Path.extension(ls_patch_or_request_no),cs_null_default) = cs_patch_ext_xml THEN
    #先取得xml檔名
    LET ls_xml_patch_no = os.Path.basename(ls_patch_or_request_no)
    #再取得主檔名稱
    LET ls_xml_patch_no = ls_xml_patch_no.subString(1,ls_xml_patch_no.getIndexOf(cs_patch_ext_xml,1)-2)
  ELSE
    LET ls_xml_patch_no = ls_patch_or_request_no
  END IF 
  CALL sadzi888_04_generate_verify_file(ls_xml_patch_no,ls_working_path,lo_dzlm_table_list,lo_export_info)

  #TAR FILE BEGIN
  IF ls_serial_no.trim() IS NULL THEN
    -- 如果輸入的路徑/Patch No 中含有.xml副檔名, 則直接取.xml前面的字串當成匯出路徑  
    IF NVL(os.Path.extension(ls_patch_or_request_no),cs_null_default) = cs_patch_ext_xml THEN
      LET ls_xml_path = os.Path.dirname(ls_patch_or_request_no),ls_os_separator 
      LET ls_TARName = ls_patch_or_request_no.subString(ls_xml_path.getLength()+1,ls_patch_or_request_no.getIndexOf(".",1)),cs_default_export_ext
    ELSE 
      LET ls_TARName = ls_patch_or_request_no,"T.",cs_default_export_ext
    END IF 
  ELSE   
    LET ls_TARName = cs_default_export_name,".",cs_default_export_ext
  END IF 
  
  LET ls_TAR_path = ls_working_path,ls_os_separator,ls_TARName
  
  LET ls_TARString = "tar zcvf ",ls_TARName," *.tdi *.tvz *.vfy"
  RUN ls_TARString
  
  #DISPLAY cs_information_tag," TAR Package Path : ",ls_TAR_path
  DISPLAY cs_tag_table_pack_path,ls_working_path
  DISPLAY cs_tag_table_pack_name,ls_TARName
  DISPLAY cs_tag_pack_full_name,ls_TAR_path
  #TAR FILE END

  LABEL _ERROR:

  LET lb_return = NOT lb_error

  RETURN lb_return,ls_TAR_path,ls_TARName

END FUNCTION 

FUNCTION sadzi888_04_generate_verify_file(p_patch_no,p_temp_path,p_dzlm_table_list,p_export_info)
DEFINE
  p_patch_no         STRING,
  p_temp_path        STRING,
  p_dzlm_table_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  p_export_info      DYNAMIC ARRAY OF T_EXPORT_INFO
DEFINE 
  ls_patch_no        STRING,
  ls_temp_path       STRING,
  lo_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_export_info     DYNAMIC ARRAY OF T_EXPORT_INFO,
  ls_vfy_filename    STRING,
  ls_separator       STRING,
  ls_tar_name        STRING,
  li_table_list_cnt  INTEGER,
  li_table_cnt       INTEGER,
  li_exp_cnt         INTEGER,
  ls_temp_name       STRING,
  ls_object_name     STRING,
  lo_xml_tap_document  xml.DomDocument,
  lo_xml_exp_elements  xml.DomNode,
  lo_exp_node_xml      xml.DomNode

  LET ls_patch_no        = p_patch_no
  LET ls_temp_path       = p_temp_path
  LET lo_dzlm_table_list = p_dzlm_table_list
  LET lo_export_info     = p_export_info
  
  LET ls_separator = os.Path.separator()

  LET ls_vfy_filename = ls_temp_path,ls_separator,cs_table_export_list
  
  #產出 XML 標頭
  LET lo_xml_tap_document = xml.DomDocument.CreateDocument("export")
  LET lo_xml_exp_elements = lo_xml_tap_document.getDocumentElement()
  CALL lo_xml_exp_elements.setAttribute("patch_no",ls_patch_no)

  LET li_table_list_cnt = lo_dzlm_table_list.getLength()
  FOR li_table_cnt = 1 TO li_table_list_cnt
    IF lo_dzlm_table_list[li_table_cnt].dtl_DZLM002 IS NOT NULL THEN 
      LET lo_exp_node_xml = lo_xml_exp_elements.appendChildElement("object")
      CALL lo_exp_node_xml.setAttribute("name",lo_dzlm_table_list[li_table_cnt].dtl_DZLM002)
      CALL lo_exp_node_xml.setAttribute("type",lo_dzlm_table_list[li_table_cnt].dtl_DZLM001)
      CALL lo_exp_node_xml.setAttribute("construct_version",lo_dzlm_table_list[li_table_cnt].dtl_DZLM005)
      CALL lo_exp_node_xml.setAttribute("sd_version",lo_dzlm_table_list[li_table_cnt].dtl_DZLM006)
      CALL lo_exp_node_xml.setAttribute("request_no",lo_dzlm_table_list[li_table_cnt].dtl_DZLM012)
      CALL lo_exp_node_xml.setAttribute("sequence_no",lo_dzlm_table_list[li_table_cnt].dtl_DZLM015)
      CALL lo_exp_node_xml.setAttribute("module",lo_dzlm_table_list[li_table_cnt].dtl_module)
      CALL lo_exp_node_xml.setAttribute("table_type",lo_dzlm_table_list[li_table_cnt].dtl_table_type)
      FOR li_exp_cnt = 1 TO lo_export_info.getLength()
        LET ls_temp_name = lo_export_info[li_exp_cnt].TAR_NAME
        LET ls_object_name = lo_dzlm_table_list[li_table_cnt].dtl_DZLM002 
        IF ls_temp_name.subString(1,ls_object_name.getLength()) = ls_object_name THEN 
          LET ls_tar_name = ls_temp_name
          EXIT FOR
        END IF 
      END FOR 
      CALL lo_exp_node_xml.setAttribute("tar_name",ls_tar_name)
    END IF 
  END FOR 
  
  #開檔將String Buffer寫入實體檔案
  CALL lo_xml_tap_document.setFeature("format-pretty-print", "TRUE")
  CALL lo_xml_tap_document.save(ls_vfy_filename)

END FUNCTION

FUNCTION sadzi888_04_generate_unload_xml(p_patch_no)
DEFINE
  p_patch_no         STRING
DEFINE 
  ls_patch_no        STRING, 
  ls_temp_path       STRING,
  ls_xml_filename    STRING,
  ls_separator       STRING,
  li_request_cnt     INTEGER,
  li_list_cnt        INTEGER,
  li_rec_cnt         INTEGER,
  ls_sql             STRING,
  lo_PATCH_REQUEST_INFO DYNAMIC ARRAY OF T_PATCH_REQUEST_INFO,
  lo_xml_tap_document   xml.DomDocument,
  lo_xml_exp_elements   xml.DomNode,
  lo_exp_node_xml       xml.DomNode

  LET ls_patch_no = p_patch_no
  
  LET ls_temp_path = cs_patch_path
  
  LET ls_separator = os.Path.separator()
  LET ls_xml_filename = ls_temp_path,ls_separator,ls_patch_no,ls_separator,cs_patch_file

  LET ls_sql = "SELECT DISTINCT LM.DZLM012,LM.DZLM015 ",
               "  FROM DZLM_T LM                      ",
               " WHERE LM.DZLM001 = 'T'               ",  
               " ORDER BY LM.DZLM012,LM.DZLM015       "

  PREPARE lpre_generate_unload_xml FROM ls_sql
  DECLARE lcur_generate_unload_xml CURSOR FOR lpre_generate_unload_xml

  LET li_rec_cnt = 1 
  
  OPEN lcur_generate_unload_xml
  FOREACH lcur_generate_unload_xml INTO lo_PATCH_REQUEST_INFO[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_generate_unload_xml

  CALL lo_PATCH_REQUEST_INFO.deleteElement(li_rec_cnt)
  
  FREE lpre_generate_unload_xml
  FREE lcur_generate_unload_xml  
               
  #產出 XML 標頭
  LET lo_xml_tap_document = xml.DomDocument.CreateDocument("patch")
  LET lo_xml_exp_elements = lo_xml_tap_document.getDocumentElement()
  CALL lo_xml_exp_elements.setAttribute("patch_no",ls_patch_no)

  LET li_request_cnt = lo_PATCH_REQUEST_INFO.getLength()
  FOR li_list_cnt = 1 TO li_request_cnt
    IF lo_PATCH_REQUEST_INFO[li_list_cnt].REQUEST_NO IS NOT NULL THEN 
      LET lo_exp_node_xml = lo_xml_exp_elements.appendChildElement("request")
      CALL lo_exp_node_xml.setAttribute("no",lo_PATCH_REQUEST_INFO[li_list_cnt].REQUEST_NO)
      CALL lo_exp_node_xml.setAttribute("sequence",lo_PATCH_REQUEST_INFO[li_list_cnt].REQUEST_SEQ)
    END IF 
  END FOR 
  
  #開檔將String Buffer寫入實體檔案
  CALL lo_xml_tap_document.setFeature("format-pretty-print", "TRUE")
  CALL lo_xml_tap_document.save(ls_xml_filename)

END FUNCTION

FUNCTION sadzi888_04_get_patch_table_list(p_patch_no)
DEFINE
  p_patch_no STRING
DEFINE
  ls_patch_no   STRING,
  ls_patch_file STRING,
  ls_error_msg  STRING,
  ls_SQL        STRING,
  li_cnt        INTEGER,
  lb_success    BOOLEAN  
DEFINE
  lb_result BOOLEAN  

  LET ls_patch_no = p_patch_no

  LET lb_success = TRUE

  IF ls_patch_no.trim() IS NULL THEN
    LET lb_success = FALSE
    LET ls_error_msg = cs_error_tag,"Patch number is null."
    GOTO _RETURN
  END IF

  #取得此次patch的[需求單號]+[項次]匯出清單unl檔
  LET ls_patch_file = os.Path.join(cs_patch_path.trim(), ls_patch_no.trim())
  LET ls_patch_file = os.Path.join(ls_patch_file.trim(), cs_patch_file.trim())

  #檢查unl檔是否存在
  IF NOT os.Path.EXISTS(ls_patch_file) THEN
    LET lb_success = FALSE
    LET ls_error_msg = cs_error_tag,"Unload file is not exists."
    GOTO _RETURN
  END IF

  #建立暫存表格供匯入表格資訊
  CALL sadzi888_04_crate_temp_table()

  #匯入patch清單
  LET ls_SQL = "INSERT INTO adzp230_patch "
  TRY 
    LOAD FROM ls_patch_file ls_SQL
  CATCH
    LET lb_success = FALSE
    LET ls_error_msg = cs_error_tag,"Load data from unload file not success."
    GOTO _RETURN
  END TRY   
   
  #檢查patch是否有清單資料
  SELECT COUNT(*) INTO li_cnt FROM adzp230_patch

  IF li_cnt = 0 THEN
    LET lb_success = FALSE
    LET ls_error_msg = cs_error_tag,"No any table can be export."
    GOTO _RETURN
  END IF

  LABEL _RETURN: 

  IF NOT lb_success THEN
    DISPLAY ls_error_msg
  END IF 

  LET lb_result = lb_success

  RETURN lb_result
  
END FUNCTION 

FUNCTION sadzi888_04_get_patch_table_list_by_xml(p_patch_no)
DEFINE
  p_patch_no STRING
DEFINE
  ls_patch_no   STRING,
  ls_patch_file STRING,
  ls_error_msg  STRING,
  ls_SQL        STRING,
  ls_separator  STRING,
  li_cnt        INTEGER,
  lb_success    BOOLEAN,  
  li_count      INTEGER,
  ls_request_no  STRING,
  ls_sequence_no STRING,
  lo_PATCH_REQUEST_INFO DYNAMIC ARRAY OF T_PATCH_REQUEST_INFO,
  lo_xml_file   xml.domDocument,
  lo_dom_node   xml.DomNode,
  lo_table_node xml.DomNode
DEFINE
  lb_result BOOLEAN,  
  lo_return DYNAMIC ARRAY OF T_PATCH_REQUEST_INFO

  LET ls_patch_no = p_patch_no

  LET ls_separator = os.Path.separator()
  
  LET lb_success = TRUE

  IF ls_patch_no.trim() IS NULL THEN
    LET lb_success = FALSE
    LET ls_error_msg = cs_error_tag,"Patch number is null."
    GOTO _RETURN
  END IF

  #取得此次patch的[需求單號]+[項次]匯出清單xml檔
  IF os.Path.isFile(ls_patch_no) AND os.Path.exists(ls_patch_no) THEN
    LET ls_patch_file = ls_patch_no
  ELSE 
    LET ls_patch_file = cs_patch_path.trim(),ls_separator,ls_patch_no,ls_separator,cs_patch_file
  END IF 

  #檢查xml檔是否存在
  IF NOT os.Path.exists(ls_patch_file) THEN
    LET lb_success = FALSE
    LET ls_error_msg = cs_error_tag,"Patch XML is not exists."
    GOTO _RETURN
  END IF

  LET lo_xml_file = xml.domDocument.create()
  
  TRY 
    DISPLAY cs_information_tag,ls_patch_file
    CALL lo_xml_file.load(ls_patch_file)
  CATCH 
    LET lb_success = FALSE
    DISPLAY cs_error_tag,"Load patch XML file fault."
    GOTO _RETURN 
  END TRY
 
  LET lo_dom_node = lo_xml_file.getDocumentElement()
  LET lo_table_node = lo_dom_node.getFirstChildElement()

  LET li_count = 1  
  WHILE (lo_table_node IS NOT NULL)

    LET ls_request_no  = lo_table_node.getAttribute("no") 
    LET ls_sequence_no = lo_table_node.getAttribute("sequence") 
  
    LET lo_PATCH_REQUEST_INFO[li_count].REQUEST_NO  = ls_request_no.trim()
    LET lo_PATCH_REQUEST_INFO[li_count].REQUEST_SEQ = ls_sequence_no.trim()

    LET li_count = li_count + 1 
    
    LET lo_table_node = lo_table_node.getNextSiblingElement()
    
  END WHILE 

  LET lo_return = lo_PATCH_REQUEST_INFO
  
  LABEL _RETURN: 

  IF NOT lb_success THEN
    DISPLAY ls_error_msg
  END IF 

  LET lb_result = lb_success

  RETURN lb_result,lo_return
  
END FUNCTION 

#建立temp table
FUNCTION sadzi888_04_crate_temp_table()

  #表格註冊資料匯出檔
  CREATE TEMP TABLE adzp230_patch
  (
    patch001 VARCHAR(10),       
    patch002 VARCHAR(20),       
    patch003 INTEGER,           
    patch004 VARCHAR(10),       #作業類型
    patch005 VARCHAR(160),      #作業代號
    patch006 VARCHAR(120),      #作業名稱
    patch007 VARCHAR(5),        #階段
    patch008 VARCHAR(20),       #過單人
    patch009 DATE,              #過單時
    patch010 DATE               #簽入時   
  )
  
END FUNCTION

FUNCTION sadzi888_04_drop_temp_table()

  #表格註冊資料匯出檔
  DROP TABLE adzp230_patch
  
END FUNCTION

#建立排序 temp table
FUNCTION sadzi888_04_crate_sort_temp_table()

  CREATE TEMP TABLE adzp230_sort
  (
    WORK_TYPE	    VARCHAR(10),
    DZLM001	      VARCHAR(10),
    DZLM002	      VARCHAR(20),
    DZLM005	      VARCHAR(10),
    DZLM006	      VARCHAR(10),
    DZLM012	      VARCHAR(20),
    DZLM015	      VARCHAR(40),
    MODULE        VARCHAR(10),
    TABLE_TYPE    VARCHAR(10),
    TAR_NAME      VARCHAR(100),
    TAR_PATH      VARCHAR(250),
    TAR_FULL_NAME VARCHAR(500)
  )
  
END FUNCTION

FUNCTION sadzi888_04_drop_sort_temp_table()

  DROP TABLE adzp230_sort
  
END FUNCTION

#2016.08.23 begin
FUNCTION sadzi888_04_create_altered_list_temp_table()

  CREATE TEMP TABLE adzp230_alter
  (
    TABLE_NAME VARCHAR(50)
  )
  
END FUNCTION

FUNCTION sadzi888_04_drop_altered_list_temp_table()

  DROP TABLE adzp230_alter
  
END FUNCTION
#2016.08.23 end

FUNCTION sadzi888_04_get_request_no_list()
DEFINE
  lo_PATCH_REQUEST_INFO DYNAMIC ARRAY OF T_PATCH_REQUEST_INFO,
  ls_sql                STRING,
  li_rec_cnt            INTEGER
DEFINE
  lo_result DYNAMIC ARRAY OF T_DZLM_TABLE_LIST

  LET ls_sql = "SELECT DISTINCT PATCH002, PATCH003 ",
               "  FROM ADZP230_PATCH               " 
  
  PREPARE lpre_get_request_no_list FROM ls_sql
  DECLARE lcur_get_request_no_list CURSOR FOR lpre_get_request_no_list

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_request_no_list
  FOREACH lcur_get_request_no_list INTO lo_PATCH_REQUEST_INFO[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_request_no_list

  CALL lo_PATCH_REQUEST_INFO.deleteElement(li_rec_cnt)
  
  FREE lpre_get_request_no_list
  FREE lcur_get_request_no_list  

  LET lo_result = lo_PATCH_REQUEST_INFO
  
  RETURN lo_result
  
END FUNCTION

FUNCTION sadzi888_04_get_sequence_guid()
DEFINE
  li_serial_num  INTEGER,
  ls_guid        VARCHAR(50)
DEFINE
  li_result INTEGER,
  ls_result VARCHAR(50)
DEFINE 
  ls_message  STRING

  TRY 
    SELECT MAX(NVL(ddata002,0)) 
      INTO li_serial_num
      FROM adzi888_ddata
  CATCH 
    #2015.03.18 Mark, 改純抓取 master 的 GUID
    #LET li_serial_num = NULL 
    LET li_serial_num = 0
  END TRY   

  TRY 
    SELECT DISTINCT master001 
      INTO ls_guid 
      FROM adzi888_master
  CATCH
    LET ls_guid = NULL
  END TRY     
  
  IF SQLCA.sqlcode OR ls_guid IS NULL THEN
    LET ls_message = " Get master GUID : ",SQLCA.sqlcode
    DISPLAY cs_warning_tag,ls_message
  END IF

  {
  #2015.03.18 Mark, 改純抓取 master 的 GUID
  IF SQLCA.sqlcode OR li_serial_num IS NULL THEN
    #140814 by Jay mark---start---
    #LET ls_guid = security.RandomGenerator.CreateUUIDString()
    TRY 
      SELECT DISTINCT master001 
        INTO ls_guid 
        FROM adzi888_master
    CATCH
      LET ls_guid = NULL
    END TRY     
    
    IF SQLCA.sqlcode OR ls_guid IS NULL THEN
      LET ls_message = " Get master GUID : ",SQLCA.sqlcode
      DISPLAY cs_warning_tag,ls_message
    END IF

    #-------by Jay--------end-----

    LET li_serial_num = 0
  ELSE   
    #取得guid
    TRY 
      SELECT DISTINCT ddata001 
        INTO ls_guid
        FROM adzi888_ddata
    CATCH
      LET ls_guid = NULL
    END TRY     
  END IF   
  }
  
  LET li_result = li_serial_num
  LET ls_result = ls_guid

  RETURN li_result,ls_result

END FUNCTION 

FUNCTION sadzi888_04_get_dzlm_table_list(p_request_no,p_sequence_no,p_DZLM_TABLE_LIST)
DEFINE
  p_request_no      STRING,
  p_sequence_no     INTEGER,
  p_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  ls_request_no      STRING,
  ls_sequence_no     STRING,
  lo_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_sql             STRING,
  ls_cond_sql        STRING,
  ls_pass_sql        STRING,
  ls_sequence_sql    STRING, #2016.10.11
  ls_check_pass_request STRING,
  li_rec_cnt         INTEGER
DEFINE
  lo_result DYNAMIC ARRAY OF T_DZLM_TABLE_LIST

  LET ls_request_no      = p_request_no
  LET ls_sequence_no     = p_sequence_no    
  LET lo_DZLM_TABLE_LIST = p_DZLM_TABLE_LIST

  CALL sadzi140_db_get_parameter(cs_param_level_alm,cs_param_check_pass_request) RETURNING ls_check_pass_request
  IF ls_check_pass_request = "Y" THEN
    #LET ls_cond_sql = " AND LM.DZLM022 = '",ls_check_pass_request.trim(),"'" 
    LET ls_cond_sql = " AND LM.DZLM022 IS NOT NULL " 
  ELSE 
    LET ls_cond_sql = "" 
  END IF

  #adzp999運行模式(1:過單打包; 2:過單解包; 3:patch打包; 4:patch解包; 5:需求單打包; 6:需求單解包; 7:adzi800匯出打包)
  #2016.10.11 begin
  LET ls_pass_sql = "" 
  LET ls_sequence_sql = " AND LM.DZLM015 = ",ls_sequence_no.trim()," "
  CASE
    WHEN NVL(ms_run_mode,"X") = "1"
      LET ls_pass_sql = " AND LM.DZLM008 = 'O' " 
    WHEN NVL(ms_run_mode,"X") = "7"
      LET ls_sequence_sql = "" 
  END CASE
  #2016.10.11 end
  
  LET ls_sql = " SELECT '",cs_exim_export,"'    WORK_TYPE,                                                      ",
               "        LM.DZLM001              DZLM001,                                                        ",
               "        LM.DZLM002              DZLM002,                                                        ",
               "        LM.DZLM005              DZLM005,                                                        ",
               "        LM.DZLM006              DZLM006,                                                        ",
               "        LM.DZLM012              DZLM012,                                                        ",
               "        NVL(EV.MAX_SEQ,0)       DZLM015,                                                        ",
               "        LM.DZLM004              MODULE_NAME,                                                    ",
               "        EA.DZEA004              TABLE_TYPE,                                                     ",                                                        
               "        ''                      TAR_NAME                                                        ",
               "   FROM (                                                                                       ",
               "           SELECT DECODE(LMO.DZLM004,'ADZ',0,'AZZ',1,'AWS',2,9) DZLMSEQ, LMO.*                  ", 
               "             FROM DZLM_T LMO                                                                    ",
               "        ) LM                                                                                    ",  
               "   LEFT OUTER JOIN DZEA_T EA ON EA.DZEA001 = LM.DZLM002                                         ",
               "   LEFT OUTER JOIN (                                                                            ",
               "                      SELECT EVO.DZEV002,TO_CHAR(MAX(TO_NUMBER(NVL(EVO.DZEV003,'0')))) MAX_SEQ  ",
               "                        FROM DZEV_T EVO                                                         ",
               "                       WHERE EVO.DZEV001 = 'DS'                                                 ",
               "                         AND EVO.DZEV004 = 'TableDesigner'                                      ",
               "                       GROUP BY EVO.DZEV002                                                     ",
               "                   ) EV ON EV.DZEV002 = UPPER(LM.DZLM002)                                       ",
               "  WHERE LM.DZLM012 = '",ls_request_no.trim(),"'                                                 ",
               #"    AND LM.DZLM015 = ",ls_sequence_no.trim(),"                                                  ", #2016.10.11 Mark
               ls_sequence_sql, #2016.10.11 Add
               "    AND LM.DZLM001 = 'T'                                                                        ",
               ls_cond_sql,
               ls_pass_sql,
               "  ORDER BY LM.DZLMSEQ,LM.DZLM002                                                                " 
  
  PREPARE lpre_get_dzlm_table_list FROM ls_sql
  DECLARE lcur_get_dzlm_table_list CURSOR FOR lpre_get_dzlm_table_list

  LET li_rec_cnt = lo_DZLM_TABLE_LIST.getLength() + 1 
  
  OPEN lcur_get_dzlm_table_list
  FOREACH lcur_get_dzlm_table_list INTO lo_DZLM_TABLE_LIST[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_dzlm_table_list

  CALL lo_DZLM_TABLE_LIST.deleteElement(li_rec_cnt)
  
  FREE lpre_get_dzlm_table_list
  FREE lcur_get_dzlm_table_list  

  LET lo_result = lo_DZLM_TABLE_LIST
  
  RETURN lo_result
  
END FUNCTION

FUNCTION sadzi888_04_get_dzlm_mdm_object_list(p_request_no,p_sequence_no,p_DZLM_TABLE_LIST)
DEFINE
  p_request_no      STRING,
  p_sequence_no     INTEGER,
  p_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  ls_request_no      STRING,
  ls_sequence_no     STRING,
  lo_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_sql             STRING,
  ls_cond_sql        STRING,
  ls_pass_sql        STRING,
  ls_sequence_sql    STRING, #2016.10.11
  ls_check_pass_request STRING,
  li_rec_cnt         INTEGER
DEFINE
  lo_result DYNAMIC ARRAY OF T_DZLM_TABLE_LIST

  LET ls_request_no      = p_request_no
  LET ls_sequence_no     = p_sequence_no    
  LET lo_DZLM_TABLE_LIST = p_DZLM_TABLE_LIST

  CALL sadzi140_db_get_parameter(cs_param_level_alm,cs_param_check_pass_request) RETURNING ls_check_pass_request
  IF ls_check_pass_request = "Y" THEN
    #LET ls_cond_sql = " AND LM.DZLM022 = '",ls_check_pass_request.trim(),"'" 
    LET ls_cond_sql = " AND LM.DZLM022 IS NOT NULL " 
  ELSE 
    LET ls_cond_sql = "" 
  END IF

  #adzp999運行模式(1:過單打包; 2:過單解包; 3:patch打包; 4:patch解包; 5:需求單打包; 6:需求單解包; 7:adzi800匯出打包)
  #2016.10.11 begin
  LET ls_pass_sql = "" 
  LET ls_sequence_sql = " AND LM.DZLM015 = ",ls_sequence_no.trim()," "
  CASE
    WHEN NVL(ms_run_mode,"X") = "1"
      LET ls_pass_sql = " AND LM.DZLM008 = 'O' " 
    WHEN NVL(ms_run_mode,"X") = "7"
      LET ls_sequence_sql = "" 
  END CASE
  #2016.10.11 end
  
  LET ls_sql = " SELECT '",cs_exim_export,"'         WORK_TYPE,                            ",
               "        LM.DZLM001                   DZLM001,                              ",
               "        LM.DZLM002                   DZLM002,                              ",
               "        LM.DZLM005                   DZLM005,                              ",
               "        LM.DZLM006                   DZLM006,                              ",
               "        LM.DZLM012                   DZLM012,                              ",
               "        LM.DZLM015                   DZLM015,                              ",
               "        'MDM'                        MODULE_NAME,                          ",
               "        ''                           TABLE_TYPE,                           ",
               "        ''                           TAR_NAME                              ",
               "   FROM (                                                                  ",                                                                             
               "          SELECT DECODE(LMO.DZLM001,'MT',0,'MV',1,'MG',2,9) DZLMSEQ, LMO.* ",        
               "            FROM DZLM_T LMO                                                ",            
               "        ) LM                                                               ",
               "  WHERE LM.DZLM012 = '",ls_request_no.trim(),"'                            ",
               #"    AND LM.DZLM015 = ",ls_sequence_no.trim(),"                             ", #2016.10.11 Mark
               ls_sequence_sql, #2016.10.11
               "    AND LM.DZLM001 IN ('MT','MG','MV')                                     ",
               ls_cond_sql,
               ls_pass_sql, #2016.10.11
               "  ORDER BY LM.DZLMSEQ, LM.DZLM002                                          " 
  
  PREPARE lpre_get_dzlm_mdm_object_list FROM ls_sql
  DECLARE lcur_get_dzlm_mdm_object_list CURSOR FOR lpre_get_dzlm_mdm_object_list

  LET li_rec_cnt = lo_DZLM_TABLE_LIST.getLength() + 1 
  
  OPEN lcur_get_dzlm_mdm_object_list
  FOREACH lcur_get_dzlm_mdm_object_list INTO lo_DZLM_TABLE_LIST[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_dzlm_mdm_object_list

  CALL lo_DZLM_TABLE_LIST.deleteElement(li_rec_cnt)
  
  FREE lpre_get_dzlm_mdm_object_list
  FREE lcur_get_dzlm_mdm_object_list  

  LET lo_result = lo_DZLM_TABLE_LIST
  
  RETURN lo_result
  
END FUNCTION

FUNCTION sadzi888_04_table_list_filter(p_DZLM_TABLE_LIST) 
DEFINE
  p_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_TABLE_LIST      DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_loop, li_loop2  INTEGER,
  lb_assigned        BOOLEAN
DEFINE
  lo_return DYNAMIC ARRAY OF T_DZLM_TABLE_LIST

  LET lo_DZLM_TABLE_LIST = p_DZLM_TABLE_LIST

  CALL lo_TABLE_LIST.clear()
  
  FOR li_loop = 1 TO lo_DZLM_TABLE_LIST.getLength()
    #將表格清單中的內容和傳入的表格清單比對,有重複的,抓版次最大的那一筆做接下來的匯出
    LET lb_assigned = FALSE
    FOR li_loop2 = 1 TO lo_TABLE_LIST.getLength()
      IF lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM002 = lo_TABLE_LIST[li_loop2].dtl_DZLM002 AND
        lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM005 > lo_TABLE_LIST[li_loop2].dtl_DZLM005 THEN
        LET lo_TABLE_LIST[li_loop2].* = lo_DZLM_TABLE_LIST[li_loop].*
        LET lb_assigned = TRUE
        EXIT FOR
      END IF    
    END FOR
    IF lb_assigned THEN CONTINUE FOR END IF

    #接下來看看 Table List 中有沒有該表格, 沒有才塞入    
    LET lb_assigned = FALSE
    FOR li_loop2 = 1 TO lo_TABLE_LIST.getLength()
      IF lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM002 = lo_TABLE_LIST[li_loop2].dtl_DZLM002 THEN
        LET lb_assigned = TRUE
        EXIT FOR
      END IF    
    END FOR
    IF NOT lb_assigned THEN 
      LET lo_TABLE_LIST[lo_TABLE_LIST.getLength() + 1].* = lo_DZLM_TABLE_LIST[li_loop].*
    END IF 
    
  END FOR  

  LET lo_return = lo_TABLE_LIST

  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi888_04_resort_object_list(p_dzlm_object_list)
DEFINE
  p_dzlm_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_dzlm_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_temp_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_sort_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_records  INTEGER,
  li_loop     INTEGER,
  lb_result   BOOLEAN 
DEFINE
  lb_return  BOOLEAN,
  lo_return  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST

  LET lo_dzlm_object_list = p_dzlm_object_list

  LET li_records = lo_dzlm_object_list.getLength()
  
  CALL lo_temp_object_list.clear()

  {
  #For debug print 
  FOR li_loop = 1 TO lo_dzlm_object_list.getLength()
    DISPLAY lo_dzlm_object_list[li_loop].dtl_MODULE," ; ",lo_dzlm_object_list[li_loop].dtl_DZLM002
  END FOR 
  }
  
  #ADZ
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF lo_dzlm_object_list[li_loop].dtl_MODULE = 'ADZ' THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzi888_04_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzi888_04_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR

  #AZZ
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF lo_dzlm_object_list[li_loop].dtl_MODULE = 'AZZ' THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzi888_04_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzi888_04_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR

  #AWS
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF lo_dzlm_object_list[li_loop].dtl_MODULE = 'AWS' THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzi888_04_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzi888_04_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR

  #Axx
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF (lo_dzlm_object_list[li_loop].dtl_MODULE <> 'ADZ') AND
       (lo_dzlm_object_list[li_loop].dtl_MODULE <> 'AZZ') AND
       (lo_dzlm_object_list[li_loop].dtl_MODULE <> 'AWS') AND
       (lo_dzlm_object_list[li_loop].dtl_MODULE <> 'MDM') THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzi888_04_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzi888_04_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR
  
  #MDM放最後, 以 Table -> View -> Trigger 順序執行
  #MT
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF lo_dzlm_object_list[li_loop].dtl_MODULE = 'MDM' AND lo_dzlm_object_list[li_loop].dtl_DZLM001 = "MT" THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzi888_04_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzi888_04_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR

  #MV
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF lo_dzlm_object_list[li_loop].dtl_MODULE = 'MDM' AND lo_dzlm_object_list[li_loop].dtl_DZLM001 = "MV" THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzi888_04_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzi888_04_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR
  
  #MG
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF lo_dzlm_object_list[li_loop].dtl_MODULE = 'MDM' AND lo_dzlm_object_list[li_loop].dtl_DZLM001 = "MG" THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzi888_04_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzi888_04_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR
  
  LET lo_return = lo_temp_object_list

  {
  #For debug print 
  FOR li_loop = 1 TO lo_return.getLength()
    DISPLAY lo_return[li_loop].dtl_MODULE," ; ",lo_return[li_loop].dtl_DZLM002
  END FOR 
  }
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi888_04_insert_into_sort_temp_table(p_dzlm_object_list)
DEFINE
  p_dzlm_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_dzlm_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_object_count      INTEGER,
  li_loop              INTEGER 
DEFINE
  lb_return BOOLEAN

  LET lo_dzlm_object_list = p_dzlm_object_list

  LET li_object_count = lo_dzlm_object_list.getLength()
  LET lb_return = TRUE

  BEGIN WORK 
  DELETE FROM adzp230_sort
  COMMIT WORK 

  BEGIN WORK 

  TRY 
    FOR li_loop = 1 TO li_object_count
      INSERT INTO adzp230_sort 
        (
          WORK_TYPE,
          DZLM001,
          DZLM002,
          DZLM005,
          DZLM006,
          DZLM012,
          DZLM015,
          MODULE,
          TABLE_TYPE,
          TAR_NAME,
          TAR_PATH,
          TAR_FULL_NAME
        )
      VALUES
        (
          lo_dzlm_object_list[li_loop].dtl_WORK_TYPE,	   
          lo_dzlm_object_list[li_loop].dtl_DZLM001,	     
          lo_dzlm_object_list[li_loop].dtl_DZLM002,	     
          lo_dzlm_object_list[li_loop].dtl_DZLM005,	     
          lo_dzlm_object_list[li_loop].dtl_DZLM006,	     
          lo_dzlm_object_list[li_loop].dtl_DZLM012,	     
          lo_dzlm_object_list[li_loop].dtl_DZLM015,	     
          lo_dzlm_object_list[li_loop].dtl_MODULE,       
          lo_dzlm_object_list[li_loop].dtl_TABLE_TYPE,   
          lo_dzlm_object_list[li_loop].dtl_TAR_NAME,     
          lo_dzlm_object_list[li_loop].dtl_TAR_PATH,     
          lo_dzlm_object_list[li_loop].dtl_TAR_FULL_NAME
        )  
    END FOR
    
    COMMIT WORK
  CATCH 
    LET lb_return = FALSE
    ROLLBACK WORK
  END TRY   
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi888_04_get_sorted_object_list()
DEFINE
  lo_dzlm_object_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_sql              STRING,
  li_rec_cnt          INTEGER
DEFINE
  lo_result DYNAMIC ARRAY OF T_DZLM_TABLE_LIST

  LET ls_sql = "SELECT WORK_TYPE,DZLM001,DZLM002,DZLM005,DZLM006,   ",
               "       DZLM012,DZLM015,MODULE, TABLE_TYPE,TAR_NAME, ",
               "       TAR_PATH,TAR_FULL_NAME                       ",
               "  FROM ADZP230_SORT                                 ",
               " ORDER BY MODULE,DZLM002                            " 
  
  PREPARE lpre_get_sorted_object_list FROM ls_sql
  DECLARE lcur_get_sorted_object_list CURSOR FOR lpre_get_sorted_object_list

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_sorted_object_list
  FOREACH lcur_get_sorted_object_list INTO lo_dzlm_object_list[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_sorted_object_list

  CALL lo_dzlm_object_list.deleteElement(li_rec_cnt)
  
  FREE lpre_get_sorted_object_list
  FREE lcur_get_sorted_object_list  

  LET lo_result = lo_dzlm_object_list
  
  RETURN lo_result
  
END FUNCTION
  
FUNCTION sadzi888_04_generate_table_list_xml(p_DZLM_TABLE_LIST,p_file_name) 
DEFINE
  p_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  p_file_name STRING 
DEFINE
  lo_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_file_name       STRING, 
  ls_vfy_filename    STRING,
  ls_separator       STRING,
  ls_tar_name        STRING,
  li_table_list_cnt  INTEGER,
  li_table_cnt       INTEGER,
  li_exp_cnt         INTEGER,
  ls_temp_name       STRING,
  ls_temp_path       STRING,
  lo_xml_tap_document  xml.DomDocument,
  lo_xml_exp_elements  xml.DomNode,
  lo_exp_node_xml      xml.DomNode

  LET lo_dzlm_table_list = p_dzlm_table_list
  LET ls_file_name = p_file_name
  
  LET ls_separator = os.Path.separator()

  LET ls_temp_path = FGL_GETENV("TEMPDIR") 

  LET ls_vfy_filename = ls_temp_path,ls_separator,ls_file_name
  
  #產出 XML 標頭
  LET lo_xml_tap_document = xml.DomDocument.CreateDocument("export")
  LET lo_xml_exp_elements = lo_xml_tap_document.getDocumentElement()

  LET li_table_list_cnt = lo_dzlm_table_list.getLength()
  FOR li_table_cnt = 1 TO li_table_list_cnt
    IF lo_dzlm_table_list[li_table_cnt].dtl_DZLM002 IS NOT NULL THEN 
      LET lo_exp_node_xml = lo_xml_exp_elements.appendChildElement("object")
      CALL lo_exp_node_xml.setAttribute("name",lo_dzlm_table_list[li_table_cnt].dtl_DZLM002)
      CALL lo_exp_node_xml.setAttribute("type",lo_dzlm_table_list[li_table_cnt].dtl_DZLM001)
      CALL lo_exp_node_xml.setAttribute("construct_version",lo_dzlm_table_list[li_table_cnt].dtl_DZLM005)
      CALL lo_exp_node_xml.setAttribute("sd_version",lo_dzlm_table_list[li_table_cnt].dtl_DZLM006)
      CALL lo_exp_node_xml.setAttribute("request_no",lo_dzlm_table_list[li_table_cnt].dtl_DZLM012)
      CALL lo_exp_node_xml.setAttribute("sequence_no",lo_dzlm_table_list[li_table_cnt].dtl_DZLM015)
      CALL lo_exp_node_xml.setAttribute("module",lo_dzlm_table_list[li_table_cnt].dtl_module)
      CALL lo_exp_node_xml.setAttribute("table_type",lo_dzlm_table_list[li_table_cnt].dtl_table_type)
    END IF 
  END FOR 
  
  #開檔將String Buffer寫入實體檔案
  CALL lo_xml_tap_document.setFeature("format-pretty-print", "TRUE")
  CALL lo_xml_tap_document.save(ls_vfy_filename)

END FUNCTION

FUNCTION sadzi888_04_set_ddata(p_serial_num,p_guid,p_dzlm_table_list)
DEFINE
  p_serial_num      INTEGER,
  p_guid            VARCHAR(50),
  p_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  li_serial_num      INTEGER,
  ls_guid            VARCHAR(50),
  ls_message         STRING,
  lo_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_rec             INTEGER
DEFINE
  lb_result BOOLEAN  

  LET li_serial_num = p_serial_num
  LET ls_guid       = p_guid
  LET lo_DZLM_TABLE_LIST = p_dzlm_table_list

  LET lb_result = TRUE
  
  FOR li_rec = 1 TO lo_DZLM_TABLE_LIST.getLength()
    IF (lo_DZLM_TABLE_LIST[li_rec].dtl_DZLM002 IS NOT NULL) AND NOT sadzi888_04_check_table_exist(lo_DZLM_TABLE_LIST[li_rec].dtl_DZLM002) THEN 
      TRY 
        LET li_serial_num = li_serial_num + 1
        
        INSERT INTO adzi888_ddata ( 
                                    DDATA001,DDATA002,DDATA003,DDATA004,DDATA005,
                                    DDATA006,DDATA007,DDATA008,DDATA009,DDATA010,
                                    DDATA015
                                  )
                           VALUES (
                                    ls_guid,li_serial_num,lo_DZLM_TABLE_LIST[li_rec].dtl_DZLM002,'1','adzi140',
                                    lo_DZLM_TABLE_LIST[li_rec].dtl_DZLM002,'','1','0','0',
                                    'd'
                                  )

      CATCH
        LET lb_result = FALSE
        
        IF SQLCA.sqlcode THEN
          LET ls_message = cs_warning_tag," INSERT adzi888_ddata : ",SQLCA.sqlcode
          DISPLAY ls_message
        END IF
        
        --EXIT FOR 
      END TRY  
    END IF                             
    
  END FOR 

  RETURN lb_result
  
END FUNCTION 

FUNCTION sadzi888_04_check_object_if_altered_list(p_dzlm_table_list)
DEFINE
  p_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_erp_table_list  STRING,
  ls_mdm_object_list STRING,
  ls_err_table_list  STRING,
  ls_erp_not_altered STRING,
  ls_mdm_not_altered STRING,
  lb_alter_status    BOOLEAN, 
  lb_table_altered   BOOLEAN, 
  li_loop            INTEGER
DEFINE
  lb_result BOOLEAN,
  ls_result STRING  

  LET lo_DZLM_TABLE_LIST = p_dzlm_table_list

  LET ls_erp_table_list  = ""
  LET ls_mdm_object_list = ""
  LET ls_err_table_list  = ""
  LET ls_erp_not_altered = ""
  LET ls_mdm_not_altered = ""
  LET lb_table_altered = TRUE
  LET lb_alter_status  = TRUE
  
  FOR li_loop = 1 TO lo_DZLM_TABLE_LIST.getLength()
  
    CASE 
      WHEN lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM001 = "T" -- ERP Table
        LET ls_erp_table_list = ls_erp_table_list,"'",lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM002,"',"
      WHEN lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM001 = "MT" -- MDM Table
        LET ls_mdm_object_list = ls_mdm_object_list,"'",lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM002,"',"
      WHEN lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM001 = "MG" -- MDM Trigger
        LET ls_mdm_object_list = ls_mdm_object_list,"'",lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM002,"',"
      WHEN lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM001 = "MV" -- MDM View
        LET ls_mdm_object_list = ls_mdm_object_list,"'",lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM002,"',"
    END CASE 
    
  END FOR 

  #判定 ERP 相關表格是否已經異動成功
  LET ls_erp_table_list = ls_erp_table_list.subString(1,ls_erp_table_list.getLength() - 1)
  IF ls_erp_table_list.getLength() > 1 THEN
    CALL sadzi888_04_create_altered_list_temp_table() #2016.08.23 add
    CALL sadzi888_04_parse_table_list_to_temp_table(ls_erp_table_list) #2016.08.23 add
    CALL sadzi888_04_check_erp_tables_altered() RETURNING lb_alter_status,ls_erp_not_altered
    IF NOT lb_alter_status THEN LET lb_table_altered = FALSE END IF
    CALL sadzi888_04_drop_altered_list_temp_table() #2016.08.23 add
  END IF  

  {  
  #中台要不要做判定 ??
  LET ls_mdm_object_list = ls_mdm_object_list.subString(1,ls_mdm_object_list.getLength() - 1)
  IF ls_mdm_object_list.getLength() > 1 THEN 
    CALL sadzi888_04_check_mdm_object_altered(ls_mdm_object_list) RETURNING lb_alter_status,ls_mdm_not_altered
    IF NOT lb_alter_status THEN LET lb_table_altered = FALSE END IF
  END IF  
  }
  
  LET ls_err_table_list = ls_erp_not_altered,",",
                          ls_mdm_not_altered

  LET lb_result = lb_table_altered
  LET ls_result = ls_err_table_list  
  
  RETURN lb_result,ls_result
  
END FUNCTION 

#2016.08.23 begin
FUNCTION sadzi888_04_parse_table_list_to_temp_table(p_table_list)
DEFINE
  p_table_list STRING
DEFINE
  ls_table_list STRING,
  li_loop       INTEGER,
  ls_table_char STRING,
  lv_table_name VARCHAR(50),
  lo_table_name base.StringBuffer

  LET ls_table_list = p_table_list

  LET lo_table_name = base.StringBuffer.create()
  CALL lo_table_name.clear()

  FOR li_loop = 1 TO ls_table_list.getLength()
    LET ls_table_char = ls_table_list.getCharAt(li_loop)
    IF ls_table_char = "," THEN
      CALL lo_table_name.append(lv_table_name)
      CALL lo_table_name.replace("'","",0)
      CALL lo_table_name.replace(" ","",0)
      LET lv_table_name = lo_table_name.toString()
      INSERT INTO adzp230_alter (table_name) VALUES (lv_table_name)
      LET lv_table_name = "" 
      CALL lo_table_name.clear()
    ELSE
      LET lv_table_name = lv_table_name,ls_table_char 
    END IF
  END FOR  
  
END FUNCTION   
#2016.08.23 end

FUNCTION sadzi888_04_check_erp_tables_altered()
DEFINE
  ls_sql           STRING,
  ls_table         VARCHAR(30),
  li_rec_cnt       INTEGER,
  li_table_count   INTEGER,
  lb_table_altered BOOLEAN, 
  ls_table_altered STRING
DEFINE  
  lb_return  BOOLEAN,
  ls_return  STRING

  LET ls_table_altered = ""
  LET lb_table_altered = TRUE
  LET li_table_count = 0
  
  LET ls_sql = "SELECT EA.DZEA001                                 ",
               "  FROM DZEA_T EA                                  ",
               " WHERE EA.DZEA011 = 'N'                           ",
               "   AND EXISTS (                                   ", #2016.08.23 begin
               "                SELECT 1                          ",
               "                  FROM ADZP230_ALTER AA           ",
               "                 WHERE AA.TABLE_NAME = EA.DZEA001 ",
               "              )                                   ", #2016.08.23 end
               " ORDER BY EA.DZEA001                              "        

  PREPARE lpre_check_erp_table_altered FROM ls_sql
  DECLARE lcur_check_erp_table_altered CURSOR FOR lpre_check_erp_table_altered

  LET li_rec_cnt = 1
  
  OPEN lcur_check_erp_table_altered
  FOREACH lcur_check_erp_table_altered INTO ls_table
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_table_altered = ls_table_altered,ls_table,"," 
    LET lb_table_altered = FALSE
    
    LET li_rec_cnt = li_rec_cnt + 1

    LET li_table_count = li_table_count + 1
    IF li_table_count >= 10 THEN
      LET ls_table_altered = ls_table_altered,"\n"
      LET li_table_count = 0 
    END IF
    
  END FOREACH
  CLOSE lcur_check_erp_table_altered

  FREE lpre_check_erp_table_altered
  FREE lcur_check_erp_table_altered
  
  LET ls_table_altered = ls_table_altered.subString(1,ls_table_altered.getLength() - 1)    

  LET lb_return = lb_table_altered
  LET ls_return = ls_table_altered
        
  RETURN lb_return,ls_return
  
END FUNCTION

FUNCTION sadzi888_04_check_erp_table_if_altered(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name  STRING,
  ls_sql         STRING,
  ls_altered     VARCHAR(2)
DEFINE  
  lb_return  BOOLEAN

  LET ls_table_name = p_table_name
  
  LET ls_sql = "SELECT EA.DZEA011                       ", 
               "  FROM DZEA_T EA                        ",
               " WHERE EA.DZEA001 = '",ls_table_name,"' ",
               " ORDER BY EA.DZEA001                    "

  PREPARE lpre_check_erp_table_if_altered FROM ls_sql
  DECLARE lcur_check_erp_table_if_altered CURSOR FOR lpre_check_erp_table_if_altered
  OPEN lcur_check_erp_table_if_altered
  FETCH lcur_check_erp_table_if_altered INTO ls_altered
  CLOSE lcur_check_erp_table_if_altered
  FREE lpre_check_erp_table_if_altered
  FREE lcur_check_erp_table_if_altered
  
  LET lb_return = IIF(NVL(ls_altered,"N")=="Y",TRUE,FALSE)
        
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi888_04_check_table_exist(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name  STRING,
  ls_sql         STRING,
  li_rec_count   INTEGER,
  lb_return      BOOLEAN

  LET ls_table_name = p_table_name

  TRY 
    #取得資料筆數
    LET ls_sql = "SELECT COUNT(1)                         ",
                 "  FROM ADZI888_DDATA DD                 ",
                 " WHERE DD.DDATA005 = 'adzi140'          ",
                 "   AND DD.DDATA006 = '",ls_table_name,"'" 

    PREPARE lpre_check_table_exist FROM ls_sql
    DECLARE lcur_check_table_exist CURSOR FOR lpre_check_table_exist
    OPEN lcur_check_table_exist
    FETCH lcur_check_table_exist INTO li_rec_count
    CLOSE lcur_check_table_exist
    FREE lcur_check_table_exist
    FREE lpre_check_table_exist
  CATCH 
    LET li_rec_count = 0
  END TRY   

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi888_04_export_object(p_dzlm_table_list)
DEFINE
  p_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_rec             INTEGER,
  ls_message         STRING,
  lb_error           BOOLEAN,
  lb_fault           BOOLEAN,
  li_exp_cnt         INTEGER,
  ls_update_shipping_code STRING,
  lo_export_info     DYNAMIC ARRAY OF T_EXPORT_INFO,
  lo_PARAMETERS      T_DZLM_T_SCR
DEFINE
  lb_result BOOLEAN  

  LET lo_DZLM_TABLE_LIST = p_dzlm_table_list

  LET lb_result = TRUE
  LET lb_error  = FALSE
  LET lb_fault  = FALSE
  LET li_exp_cnt = 0

  CALL lo_export_info.clear()
  
  FOR li_rec = 1 TO lo_DZLM_TABLE_LIST.getLength()

    IF lo_DZLM_TABLE_LIST[li_rec].dtl_DZLM002 IS NOT NULL THEN  
  
      LET lo_PARAMETERS.TYPES   = lo_DZLM_TABLE_LIST[li_rec].dtl_WORK_TYPE #iexp, iimp, idel, iasm
      LET lo_PARAMETERS.DZLM001 = lo_DZLM_TABLE_LIST[li_rec].dtl_DZLM001   #ObjectType 
      LET lo_PARAMETERS.DZLM002 = lo_DZLM_TABLE_LIST[li_rec].dtl_DZLM002   #ObjectName
      LET lo_PARAMETERS.DZLM005 = lo_DZLM_TABLE_LIST[li_rec].dtl_DZLM005   #ConstructVersion
      LET lo_PARAMETERS.DZLM006 = lo_DZLM_TABLE_LIST[li_rec].dtl_DZLM006   #SD_Version
      LET lo_PARAMETERS.DZLM012 = lo_DZLM_TABLE_LIST[li_rec].dtl_DZLM012   #需求單號
      LET lo_PARAMETERS.DZLM015 = lo_DZLM_TABLE_LIST[li_rec].dtl_DZLM015   #儲存在DZEV中的最大序號

      #ERP 表格
      IF lo_DZLM_TABLE_LIST[li_rec].dtl_DZLM001 = "T" THEN 
        LET li_exp_cnt = li_exp_cnt + 1
        CALL sadzp220_run(FALSE,lo_PARAMETERS.*) RETURNING lo_export_info[li_exp_cnt].*
      ELSE
      #MDM物件
        LET li_exp_cnt = li_exp_cnt + 1
        CALL sadzp310_adpt_patch_run(TRUE,lo_PARAMETERS.*,lo_DZLM_TABLE_LIST[li_rec].*) RETURNING lo_export_info[li_exp_cnt].*
      END IF  

      LET ls_message = "Export Object : ",lo_PARAMETERS.DZLM002
      LET lb_fault = lo_export_info[li_exp_cnt].RESULT
      
      IF lb_fault THEN
        LET lb_error = TRUE
        DISPLAY cs_tag_break_error,ls_message
        EXIT FOR
      ELSE
        #取得是否有啟動更新出貨識別碼機制
        CALL sadzi140_db_get_parameter(cs_param_level_alm,cs_param_update_shipping_code) RETURNING ls_update_shipping_code
        IF ls_update_shipping_code = "Y" THEN 
          #更新出貨識別碼
          CALL sadzi140_db_update_shipping_code(lo_PARAMETERS.DZLM002)
        END IF 
        DISPLAY cs_success_tag,ls_message
      END IF
      
    END IF   
    
  END FOR 

  LET lb_result = NOT lb_error
  
  RETURN lb_result,lo_export_info
  
END FUNCTION 

FUNCTION sadzi888_04_moving_file(p_src_path,p_src_file_name,p_dst_path,p_dst_file_name)
DEFINE
  p_src_path       STRING,
  p_src_file_name  STRING,
  p_dst_path       STRING,
  p_dst_file_name  STRING
DEFINE
  ls_src_path       STRING,
  ls_src_file_name  STRING,
  ls_dst_path       STRING,
  ls_dst_file_name  STRING,
  ls_src_full_name  STRING,
  ls_dst_full_name  STRING,
  ls_os_separator   STRING,
  ls_message        STRING,
  lb_result         BOOLEAN
DEFINE
  lb_return  BOOLEAN

  LET ls_src_path       = p_src_path
  LET ls_src_file_name  = p_src_file_name
  LET ls_dst_path       = p_dst_path 
  LET ls_dst_file_name  = p_dst_file_name

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator

  IF NVL(ls_src_file_name.trim(),cs_null_default) = cs_null_default THEN 
    LET ls_src_full_name = ls_src_path
  ELSE
    LET ls_src_full_name = ls_src_path,ls_os_separator,ls_src_file_name
  END IF   

  IF NVL(ls_dst_file_name.trim(),cs_null_default) = cs_null_default THEN 
    LET ls_dst_full_name = ls_dst_path
  ELSE
    LET ls_dst_full_name = ls_dst_path,ls_os_separator,ls_dst_file_name
  END IF   

  LET ls_message = "Moving file from ",ls_src_full_name,"\n"," TO ",ls_dst_full_name
  
  CALL os.Path.copy(ls_src_path,ls_dst_path) RETURNING lb_result
  
  IF NOT lb_result THEN
    DISPLAY cs_error_tag,ls_message
  ELSE
    DISPLAY cs_success_tag,ls_message
  END IF
  
  LET lb_return = lb_result

  RETURN lb_return

END FUNCTION 

FUNCTION sadzi888_04_get_backup_table_list(p_patch_no)
DEFINE
  p_patch_no  STRING
DEFINE
  ls_patch_no    STRING,
  ls_sql         STRING,
  lo_table_list  DYNAMIC ARRAY OF T_TABLE_LIST,
  li_rec_cnt     INTEGER
DEFINE
  lo_result DYNAMIC ARRAY OF T_TABLE_LIST

  LET ls_patch_no = p_patch_no

  LET ls_sql = "SELECT ATS.TABLE_NAME                                                  ", 
               "  FROM ALL_TABLES ATS                                                  ",
               " WHERE ATS.OWNER = 'DSBAK'                                             ",
               "   AND ATS.TABLE_NAME LIKE '%'||REPLACE('",ls_patch_no,"','-','_')||'%'",
               " ORDER BY ATS.TABLE_NAME                                               "               
  
  PREPARE lpre_get_backup_table_list FROM ls_sql
  DECLARE lcur_get_backup_table_list CURSOR FOR lpre_get_backup_table_list

  LET li_rec_cnt = 1
  
  OPEN lcur_get_backup_table_list
  FOREACH lcur_get_backup_table_list INTO lo_table_list[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_backup_table_list

  CALL lo_table_list.deleteElement(li_rec_cnt)
  
  FREE lpre_get_backup_table_list
  FREE lcur_get_backup_table_list  

  LET lo_result = lo_table_list
  
  RETURN lo_result
  
END FUNCTION

################################################################################

############################ COMMON  UTILITY ###################################

FUNCTION sadzi888_04_making_work_directory(p_work_type)
DEFINE
  p_work_type STRING
DEFINE
  ls_work_type        STRING,
  li_ConstructVersion INTEGER,
  li_SD_Version       INTEGER,
  ls_PathName         STRING,
  ls_TEMPDIR          STRING,
  ls_GUID             STRING,
  li_MKDIR            INTEGER,
  li_CHDIR            INTEGER,
  ls_os_separator     STRING
DEFINE 
  ls_return STRING   

  LET ls_work_type = p_work_type
  
  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator

  LET ls_GUID = security.RandomGenerator.CreateUUIDString()
  
  LET ls_TEMPDIR  = FGL_GETENV("TEMPDIR")
  LET ls_PathName = ls_TEMPDIR,ls_os_separator,ls_work_type,"_",ls_GUID
                    
  CALL os.Path.mkdir(ls_PathName) RETURNING li_MKDIR
  CALL os.Path.chdir(ls_PathName) RETURNING li_CHDIR  

  LET ls_return = ls_PathName
  
  RETURN ls_return  
  
END FUNCTION

################################################################################

FUNCTION sadzi888_04_backup_and_truncate_table(p_table_name,p_patch_no)
DEFINE 
  p_table_name  STRING,
  p_patch_no    STRING
DEFINE 
  ls_table_name         STRING,
  ls_patch_no           STRING,
  li_loop               INTEGER,
  lo_table_in_db_type   DYNAMIC ARRAY OF T_TABLE_IN_DB_TYPE,
  lo_db_connstr         T_DB_CONNSTR,
  lo_db_bak_connstr     T_DB_CONNSTR,
  ls_trunc_sql_filename STRING,
  ls_message            STRING,
  ls_all_message        STRING,
  ls_error              STRING,
  ls_check_error        STRING,
  lb_error              BOOLEAN
DEFINE 
  lb_return  BOOLEAN  

  LET ls_table_name  = p_table_name
  LET ls_patch_no    = p_patch_no
  
  LET lb_error = FALSE

  LET lo_db_bak_connstr.db_source   = FGL_GETENV("ORACLE_SID")
  LET lo_db_bak_connstr.db_username = 'dsbak'
  LET lo_db_bak_connstr.db_password = 'dsbak'
  LET lo_db_bak_connstr.db_sid      = FGL_GETENV("ORACLE_SID")
  
  #取得表格在DB中是 Table or Synonym
  CALL sadzi140_db_get_table_in_db_type(ls_table_name,cs_order_by_desc) RETURNING lo_table_in_db_type
  
  FOR li_loop = 1 TO lo_table_in_db_type.getLength()
    CALL sadzi140_db_get_db_connect_string(lo_table_in_db_type[li_loop].tidt_db) RETURNING lo_db_connstr.*

    #判斷若是要建立的型態為表格(T), 則產生表格異動碼
    IF lo_table_in_db_type[li_loop].tidt_object_type = "T" THEN
      ###############################################################################################################################################################
      
      #產出 SQL Scripts File
      CALL sadzi888_04_gen_backup_and_truncate_sql_file(lo_db_connstr.db_username,ls_table_name,ls_patch_no) RETURNING ls_trunc_sql_filename
      LET lo_db_bak_connstr.db_sql_filename = ls_trunc_sql_filename
      
      CALL sadzi140_db_sqlplus(lo_db_bak_connstr.*) RETURNING ls_message
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Backup and truncate table.","\n", 
                           "User : ",lo_db_bak_connstr.db_username,"\n",
                           ls_message
      
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
    DISPLAY cs_error_tag," Backup and truncate table process error, please refer to log."
  END IF  

  DISPLAY ls_all_message
  
  IF NOT lb_error THEN
    DISPLAY cs_success_tag,"Table ",ls_table_name," truncated finished."
  ELSE
    DISPLAY cs_error_tag,"Table ",ls_table_name," truncated with error !!"
  END IF  

  LABEL _return:
  
  LET lb_return = NOT lb_error
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi888_04_gen_backup_and_truncate_sql_file(p_schema,p_table,p_patch_no)
DEFINE 
  p_schema   STRING,
  p_table    STRING,
  p_patch_no STRING
DEFINE
  ls_schema         STRING,
  ls_table          STRING,
  ls_patch_no       STRING,
  ls_sql            STRING,
  ls_sript_filename STRING,
  ls_separator      STRING,   
  ls_tempdir        STRING,
  ls_random_name    STRING,
  ls_exit_sign      STRING,
  lchannel_write    base.Channel
DEFINE
  ls_return  STRING

  LET ls_schema   = p_schema
  LET ls_table    = p_table
  LET ls_patch_no = p_patch_no

  LET ls_exit_sign = "exit;"
  
  LET ls_sql = "SET SERVEROUTPUT ON                                                                                   ","\n",
               "declare                                                                                               ","\n",       
               "  -------------------------------------------------------------------------------                     ","\n",       
               "  cs_ERROR_TAG        CONSTANT VARCHAR2(20) := '",cs_error_tag,"';                                    ","\n",  
               "  cs_WARNING_TAG      CONSTANT VARCHAR2(20) := '",cs_warning_tag,"';                                  ","\n",  
               "  cs_SUCCESS_TAG      CONSTANT VARCHAR2(20) := '",cs_success_tag,"';                                  ","\n",  
               "  cs_INFORMATION_TAG  CONSTANT VARCHAR2(20) := '",cs_information_tag,"';                              ","\n",      
               "  -------------------------------------------------------------------------------                     ","\n",       
               "  ls_sql           varchar2(4096);                                                                    ","\n",         
               "  ls_table         varchar2(30);                                                                      ","\n",         
               "  ls_real_table    varchar2(30);                                                                      ","\n",         
               "  ls_schema_table  varchar2(30);                                                                      ","\n",         
               "  ls_schema        varchar2(30);                                                                      ","\n",         
               "  ls_patch_no      varchar2(50);                                                                      ","\n", 
               "  li_count         number;                                                                            ","\n",   
               "begin                                                                                                 ","\n",       
               "                                                                                                      ","\n",       
               "  ls_schema   := '",ls_schema,"';                                                                     ","\n", 
               "  ls_table    := '",ls_table,"';                                                                      ","\n", 
               "  ls_patch_no := replace('",ls_patch_no,"','-','_');                                                                   ","\n",  
               "                                                                                                      ","\n",       
               "  ls_real_table   := ls_schema||'_'||ls_table||'_'||ls_patch_no;                                      ","\n", 
               "  ls_schema_table := ls_schema||'.'||ls_table;                                                        ","\n", 
               "                                                                                                      ","\n", 
               "  begin                                                                                               ","\n", 
               "    ls_sql := 'select count(*) from '||ls_schema_table||' where 1=1';                                 ","\n", 
               "    EXECUTE IMMEDIATE ls_sql into li_count;                                                           ","\n", 
               "  exception                                                                                           ","\n", 
               "    WHEN OTHERS THEN                                                                                  ","\n",       
               "      li_count := 0;                                                                                  ","\n", 
               "  end;                                                                                                ","\n", 
               "                                                                                                      ","\n",       
               "  BEGIN                                                                                               ","\n", 
               "    if li_count > 0 then                                                                              ","\n",                    
               "      DBMS_OUTPUT.put_line(cs_INFORMATION_TAG||'Backup and truncate table begin.');                   ","\n",                                         
               "                                                                                                      ","\n", 
               "      ls_sql := 'create table '||ls_real_table||' as select * from '||ls_schema_table||' where 1=1';  ","\n", 
               "      EXECUTE IMMEDIATE ls_sql;                                                                       ","\n",         
               "      DBMS_OUTPUT.put_line(cs_SUCCESS_TAG||'Create backup table '||ls_real_table||' success.');       ","\n",                                                     
               "                                                                                                      ","\n", 
               "      ls_sql := 'truncate table '||ls_schema_table;                                                   ","\n", 
               "      EXECUTE IMMEDIATE ls_sql;                                                                       ","\n", 
               "      DBMS_OUTPUT.put_line(cs_SUCCESS_TAG||'Truncate table '||ls_schema_table||' success.');          ","\n",                                                  
               "                                                                                                      ","\n", 
               "      DBMS_OUTPUT.put_line(cs_INFORMATION_TAG||'Backup and truncate table end.');                     ","\n",                                       
               "    else                                                                                              ","\n", 
               "      DBMS_OUTPUT.put_line(cs_INFORMATION_TAG||'The table '||ls_schema_table||                        ","\n", 
               "                           ' does not contain any data,skip backup and truncate.');                   ","\n",                                         
               "    end if;                                                                                           ","\n", 
               "  EXCEPTION                                                                                           ","\n",       
               "    WHEN OTHERS THEN                                                                                  ","\n",       
               "      DBMS_OUTPUT.put_line(cs_ERROR_TAG||ls_sql);                                                     ","\n",       
               "      DBMS_OUTPUT.put_line(SQLERRM);                                                                  ","\n",       
               "  END;                                                                                                ","\n",       
               "                                                                                                      ","\n",       
               "end;                                                                                                  ","\n",       
               "/                                                                                                     "
               
  LET ls_separator = os.Path.separator()

  LET ls_tempdir = FGL_GETENV("TEMPDIR")
  CALL sadzi140_db_get_GUID() RETURNING ls_random_name 
  LET ls_sript_filename = ls_tempdir,ls_separator,"adzp230_backup_and_truncate.",ls_random_name,".sql"
  
  
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

FUNCTION sadzi888_04_get_patch_parameter(p_level,p_param)
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
               " WHERE EJ.DZEJ001 = 'adzp230_parameters' ",
               "   AND EJ.DZEJ003 = '",ls_level,"'       ",
               "   AND EJ.DZEJ004 = '",ls_param,"'       "
                              
  PREPARE lpre_get_patch_parameter FROM ls_sql
  DECLARE lcur_get_patch_parameter CURSOR FOR lpre_get_patch_parameter

  OPEN lcur_get_patch_parameter
  FETCH lcur_get_patch_parameter INTO lv_parameter
  CLOSE lcur_get_patch_parameter
  
  FREE lpre_get_patch_parameter
  FREE lcur_get_patch_parameter  

  LET ls_return = lv_parameter
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi888_04_update_pass_through_status_code(p_dzlm_table_list)
DEFINE
  p_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_object_name     STRING,
  li_loop            INTEGER,
  lb_result          BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET lo_DZLM_TABLE_LIST = p_dzlm_table_list

  LET lb_result = TRUE
  
  FOR li_loop = 1 TO lo_DZLM_TABLE_LIST.getLength()
  
    CASE 
      WHEN lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM001 = "T" -- ERP Table
        LET ls_object_name = lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM002
        CALL sadzi888_04_set_dzea_status_code(ls_object_name,cs_pass_through_status_code) RETURNING lb_result
      WHEN lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM001 = "MT" -- MDM Table
        LET ls_object_name = lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM002 
        #尚未實做更新段
        --CALL sadzi888_04_set_dzia_status_code(ls_object_name,cs_pass_through_status_code) RETURNING lb_result
      WHEN lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM001 = "MG" -- MDM Trigger
        LET ls_object_name = lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM002 
        #尚未實做更新段
        --CALL sadzi888_04_set_dzit_status_code(ls_object_name,cs_pass_through_status_code) RETURNING lb_result
      WHEN lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM001 = "MV" -- MDM View
        LET ls_object_name = lo_DZLM_TABLE_LIST[li_loop].dtl_DZLM002 
        #尚未實做更新段
        --CALL sadzi888_04_set_dziv_status_code(ls_object_name,cs_pass_through_status_code) RETURNING lb_result
    END CASE 
    
  END FOR 

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzi888_04_set_dzea_status_code(p_object_name,p_status_code)
DEFINE
  p_object_name STRING,
  p_status_code STRING
DEFINE  
  ls_object_name  VARCHAR(20),
  ls_status_code  VARCHAR(10),
  lb_success      BOOLEAN
DEFINE
  lb_return  BOOLEAN

  LET ls_object_name = p_object_name
  LET ls_status_code = p_status_code
  
  LET lb_success = TRUE

  TRY
  
    UPDATE DZEA_T                                 
       SET DZEASTUS = ls_status_code
     WHERE DZEA001  = ls_object_name
       
  CATCH
    LET lb_success = FALSE
    DISPLAY cs_warning_tag,"Update erp table status code unsuccess : ",SQLCA.sqlcode
  END TRY

  LET lb_return = lb_success     
    
  RETURN lb_return
  
END FUNCTION

#2016.12.26 begin
FUNCTION sadzi888_04_get_dzhe_table_list(p_GUID,p_DZLM_TABLE_LIST)
DEFINE
  p_GUID            STRING,
  p_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  ls_GUID            STRING,
  lo_DZLM_TABLE_LIST DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_sql             STRING,
  li_rec_cnt         INTEGER
DEFINE
  lo_result DYNAMIC ARRAY OF T_DZLM_TABLE_LIST

  LET ls_GUID            = p_GUID
  LET lo_DZLM_TABLE_LIST = p_DZLM_TABLE_LIST

  LET ls_sql = " SELECT '",cs_exim_export,"'    WORK_TYPE,                                                      ",
               "        HE.DZHE001              DZLM001,                                                        ",
               "        HE.DZHE002              DZLM002,                                                        ",
               "        HE.DZHE005              DZLM005,                                                        ",
               "        HE.DZHE006              DZLM006,                                                        ",
               "        HE.DZHE012              DZLM012,                                                        ",
               "        NVL(EV.MAX_SEQ,0)       DZLM015,                                                        ",
               "        HE.DZHE004              MODULE_NAME,                                                    ",
               "        EA.DZEA004              TABLE_TYPE,                                                     ",                                                        
               "        ''                      TAR_NAME                                                        ",
               "   FROM (                                                                                       ",
               "           SELECT DECODE(HEO.DZHE004,'ADZ',0,'AZZ',1,'AWS',2,9) DZHESEQ, HEO.*                  ", 
               "             FROM DZHE_T HEO                                                                    ",
               "        ) HE                                                                                    ",  
               "   LEFT OUTER JOIN DZEA_T EA ON EA.DZEA001 = HE.DZHE002                                         ",
               "   LEFT OUTER JOIN (                                                                            ",
               "                      SELECT EVO.DZEV002,TO_CHAR(MAX(TO_NUMBER(NVL(EVO.DZEV003,'0')))) MAX_SEQ  ",
               "                        FROM DZEV_T EVO                                                         ",
               "                       WHERE EVO.DZEV001 = 'DS'                                                 ",
               "                         AND EVO.DZEV004 = 'TableDesigner'                                      ",
               "                       GROUP BY EVO.DZEV002                                                     ",
               "                   ) EV ON EV.DZEV002 = UPPER(HE.DZHE002)                                       ",
               "  WHERE HE.DZHE000 = '",ls_GUID.trim(),"'                                                       ",
               "    AND HE.DZHE001 = 'T'                                                                        ",
               "  ORDER BY HE.DZHESEQ,HE.DZHE002                                                                " 
  
  PREPARE lpre_get_dzhe_table_list FROM ls_sql
  DECLARE lcur_get_dzhe_table_list CURSOR FOR lpre_get_dzhe_table_list

  LET li_rec_cnt = lo_DZLM_TABLE_LIST.getLength() + 1 
  
  OPEN lcur_get_dzhe_table_list
  FOREACH lcur_get_dzhe_table_list INTO lo_DZLM_TABLE_LIST[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_dzhe_table_list

  CALL lo_DZLM_TABLE_LIST.deleteElement(li_rec_cnt)
  
  FREE lpre_get_dzhe_table_list
  FREE lcur_get_dzhe_table_list  

  LET lo_result = lo_DZLM_TABLE_LIST
  
  RETURN lo_result
  
END FUNCTION
#2016.12.26 begin
