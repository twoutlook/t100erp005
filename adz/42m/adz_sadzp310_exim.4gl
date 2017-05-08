
&include "../4gl/sadzp310_mcr.inc" 

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"

&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzp200_type.inc"

PUBLIC TYPE T_COLUMN_INFO RECORD
              cs_TABLE_NAME   VARCHAR(30),
              cs_COLUMN_NAME  VARCHAR(30),
              cs_COLUMN_TYPE  VARCHAR(30),
              cs_SEQUENCE     INTEGER
            END RECORD
            
&ifndef DEBUG
GLOBALS "../../cfg/top_global.inc"
&endif

CONSTANT cs_UsingFormat STRING = "&&&&&"
CONSTANT cs_NoVersionCharacter STRING = "99999"
CONSTANT cs_keyword_DGENV STRING = "DGENV"

#執行的環境變數
DEFINE 
  ms_dlang         STRING,
  mb_fault         BOOLEAN,
  ms_DGENV         STRING,
  ms_src_DGENV     STRING,
  mo_PARAMETERS    T_DZLM_T_SCR,
  mo_export_info   T_EXPORT_INFO,
  mo_column_info   DYNAMIC ARRAY OF T_COLUMN_INFO,
  ms_entry_path    STRING,
  ms_MasterDB      STRING,
  ms_MasterUser    STRING,
  mb_backend_mode  BOOLEAN,
  mb_make_work_dir BOOLEAN,
  ms_max_sequence  STRING,
  mb_same_zone     BOOLEAN, 
  mb_new_table     BOOLEAN,  
  ms_construct_version STRING,
  mo_json_obj      util.JSONObject,
  mo_local_lang    DYNAMIC ARRAY OF T_LOCAL_LANGUAGE
            
FUNCTION sadzp310_exim_run(p_backend_mode,p_parameters)
DEFINE
  p_backend_mode  BOOLEAN,
  p_parameters    T_DZLM_T_SCR
  
  CALL sadzp310_exim_initialize(p_backend_mode,p_parameters.*)
  CALL sadzp310_exim_start()
  CALL sadzp310_exim_finalize()

  RETURN mo_export_info.*
  
END FUNCTION 

FUNCTION sadzp310_exim_initialize(p_backend_mode,p_parameters)
DEFINE
  p_backend_mode  BOOLEAN,
  p_parameters    T_DZLM_T_SCR
DEFINE
  lo_parameters T_DZLM_T_SCR   

  LET mb_backend_mode = p_backend_mode
  LET lo_parameters.* = p_parameters.*

  &ifndef DEBUG
    LET ms_dlang = NVL(g_dlang,cs_default_lang)
  &else
    LET ms_dlang = cs_default_lang
  &endif

  #是否客制環境
  &ifndef DEBUG
  LET ms_DGENV = FGL_GETENV("DGENV")
  &else
  LET ms_DGENV = "s"
  &endif

  LET mo_PARAMETERS.TYPES   = lo_parameters.TYPES   #iexp, iimp, idel, iasm
  LET mo_PARAMETERS.DZLM002 = lo_parameters.DZLM002 #TableName
  LET mo_PARAMETERS.DZLM005 = lo_parameters.DZLM005 #ConstructVersion
  LET mo_PARAMETERS.DZLM006 = lo_parameters.DZLM006 #SD_Version
  LET mo_PARAMETERS.DZLM012 = lo_parameters.DZLM012 #需求單號
  LET mo_PARAMETERS.DZLM015 = lo_parameters.DZLM015 #序號

  #若ConstructVersion設為"T", 表示要匯出 r.t 的設計資料, 而非歷史版本
  IF mo_PARAMETERS.DZLM005 = cs_rt_design_data_code THEN
    LET mo_PARAMETERS.DZLM005 = cs_NoVersionCharacter
    LET mo_PARAMETERS.DZLM012 = cs_rt_design_request_no  #需求單號
    LET mo_PARAMETERS.DZLM015 = cs_rt_design_sequence_no #序號
    LET mb_same_zone = TRUE
  ELSE   
    LET mb_same_zone = FALSE
  END IF 
  
  #呼叫亂數產生器
  CALL util.Math.srand()

  #取得Master DB 及 User
  CALL sadzp310_db_get_parameter(cs_param_level_system,cs_param_master_db) RETURNING ms_MasterDB
  CALL sadzp310_db_get_parameter(cs_param_level_system,cs_param_master_user) RETURNING ms_MasterUser

  #取得當地多語言清單
  CALL sadzp310_util_get_local_language() RETURNING mo_local_lang
  
  LET mb_fault = FALSE

  #建立取得Table export notice物件
  LET mo_json_obj = util.JSONObject.Create()  
  
END FUNCTION

FUNCTION sadzp310_exim_start()
DEFINE
  lo_DZLM_T           DYNAMIC ARRAY OF T_DZLM_T_SCR,
  ls_TableName        STRING,
  ls_TARName          STRING,
  ls_ConstructVersion STRING,
  li_ConstructVersion INTEGER,
  li_SD_Version       INTEGER,
  ls_SD_Version       STRING
DEFINE  
  ls_TYPES             STRING,
  li_loop              INTEGER,
  lb_fault             BOOLEAN,
  lb_success           BOOLEAN,
  li_CHDIR             INTEGER,
  ls_rtn_code          STRING,
  lb_Copyfile          BOOLEAN,
  lb_DropSuccess       BOOLEAN,
  lb_DelSuccess        BOOLEAN,
  lb_TableExists       BOOLEAN,
  lb_RebuildSuccess    BOOLEAN,
  lb_ASMSuccess        BOOLEAN,
  lb_diff              BOOLEAN,
  ls_Revision          STRING,
  ls_TARString         VARCHAR(1024),
  ls_prev_working_path STRING,
  lo_VersionInfo       T_VERSION_INFO,
  lo_revision          T_REVISION,
  lo_curr_DZAF_T       T_DZAF_T,
  ls_alm_request_no    STRING,
  ls_alm_request_seq   STRING,
  ls_dgenv             STRING,
  ls_message           STRING,
  lb_result            BOOLEAN 


  &ifndef DEBUG
  IF NVL(mo_PARAMETERS.TYPES,cs_null_value) = cs_null_value THEN
    CALL sadzp310_exim_show_help()
  END IF
  &endif

  LET lb_fault = FALSE
  
  LET ls_TYPES            = mo_PARAMETERS.TYPES
  LET ls_TableName        = mo_PARAMETERS.DZLM002
  LET ls_ConstructVersion = mo_PARAMETERS.DZLM005
  LET ls_SD_Version       = mo_PARAMETERS.DZLM006
  LET ls_alm_request_no   = mo_PARAMETERS.DZLM012
  LET ls_alm_request_seq  = mo_PARAMETERS.DZLM015
  
  LET ls_dgenv = ms_DGENV

  #取得及切換目前工作目錄
  CALL os.Path.pwd() RETURNING ms_entry_path

  CASE NVL(ls_TYPES.ToLowerCase(),cs_null_value)
    #Export r.t setting data  
    WHEN cs_exim_export  
      LET lb_success = TRUE
      #給定DGENV的值
      CALL mo_json_obj.put(cs_keyword_DGENV,ms_DGENV)
      #取得DZLM的表格名稱  
      IF ls_TableName IS NOT NULL THEN
        IF NOT mb_make_work_dir THEN 
          CALL sadzp310_exim_making_work_directory(ls_TableName,cs_working_dir_type_export) RETURNING lb_success,mo_export_info.WORKING_PATH
          IF NOT lb_success THEN GOTO _exp_error END IF 
        END IF            
        CALL sadzp310_exim_export_DZEA_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        CALL sadzp310_exim_export_DZEAL_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        CALL sadzp310_exim_export_DZEB_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        CALL sadzp310_exim_export_DZEBL_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        CALL sadzp310_exim_export_DZEC_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        CALL sadzp310_exim_export_DZED_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        -- adzi150 begin        
        CALL sadzp310_exim_export_DZEF_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        CALL sadzp310_exim_export_DZEP_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        CALL sadzp310_exim_export_DZEQ_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        CALL sadzp310_exim_export_DZER_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        CALL sadzp310_exim_export_DZET_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        -- adzi150 end        
        #CALL sadzp310_exim_export_DZEO_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        #IF NOT lb_success THEN GOTO _exp_error END IF
        CALL sadzp310_exim_export_DZEU_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        #CALL sadzp310_exim_export_DZEV_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        #IF NOT lb_success THEN GOTO _exp_error END IF 
        #CALL sadzp310_exim_export_DZEW_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        #IF NOT lb_success THEN GOTO _exp_error END IF 
        CALL sadzp310_exim_export_GZTD_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        CALL sadzp310_exim_export_GZTDL_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF
        CALL sadzp310_exim_export_DZIG_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        -- adzi150        
        CALL sadzp310_exim_export_GZCC_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF 
        #匯出表格匯出註記
        CALL sadzp310_exim_table_export_notice(ls_TableName,mo_json_obj.toString()) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF
        #TAR File
        CALL sadzp310_exim_tar_file(mo_PARAMETERS.*) RETURNING lb_success
        IF NOT lb_success THEN GOTO _exp_error END IF
        
        LABEL _exp_error:
        
        #返回原路徑  
        CALL os.Path.chdir(ms_entry_path) RETURNING li_CHDIR
      END IF
      LET lb_fault = NOT lb_success
    #Import r.t setting data  
    WHEN cs_exim_import
      LET lb_success = TRUE
      CALL sadzp310_exim_get_column_with_sequence(ls_TableName) RETURNING mo_column_info 
      CALL sadzp310_exim_check_if_new_table(mo_column_info) RETURNING mb_new_table
      BEGIN WORK
      IF ls_TableName IS NOT NULL THEN
        IF NOT mb_make_work_dir THEN 
          CALL sadzp310_exim_making_work_directory(ls_TableName,cs_working_dir_type_import) RETURNING lb_success,mo_export_info.WORKING_PATH
          IF NOT lb_success THEN GOTO _exp_error END IF 
        END IF   
        CALL sadzp310_vcs_get_new_seqence(ls_TableName,FALSE,FALSE,FALSE,TRUE,4) RETURNING ms_max_sequence

        #取得現今DZAF的資料
        LET lo_curr_DZAF_T.DZAF001 = ls_TableName
        LET lo_curr_DZAF_T.DZAF005 = cs_spec_type_table
        LET lo_curr_DZAF_T.DZAF010 = ls_DGENV
        CALL sadzp200_ver_get_curr_ver_info(lo_curr_DZAF_T.*) RETURNING lo_curr_DZAF_T.*
        IF lo_curr_DZAF_T.DZAF002 IS NULL THEN
          CALL sadzp200_ver_get_new_ver_info(lo_curr_DZAF_T.*,cs_user_role_sd,FALSE) RETURNING lb_success,lo_curr_DZAF_T.*
          DISPLAY "Get New Version Number : ",IIF(lb_success,cs_result_success,cs_result_fail)
          IF NOT lb_success THEN GOTO _return END IF
        END IF
        LET ms_construct_version = lo_curr_DZAF_T.DZAF002  
        
        CALL sadzp310_exim_untar_file(mo_PARAMETERS.*) RETURNING lb_success
        DISPLAY "Untar : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF

        CALL sadzp310_exim_table_check_notice(ls_TableName) RETURNING lb_success,mo_json_obj
        DISPLAY "Check export notice : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 

        #抓取判斷匯出檔是不是匯出端和匯入端相同
        CALL sadzp310_exim_get_source_DGENV(mo_json_obj,ms_dgenv) RETURNING ms_src_DGENV
        IF ms_src_DGENV = ms_DGENV THEN LET mb_same_zone = TRUE ELSE LET mb_same_zone = FALSE END IF
        
        CALL sadzp310_exim_import_DZEA_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        DISPLAY "Import DZEA : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_import_DZEAL_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        DISPLAY "Import DZEAL : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_delete_DZEB_data(ls_TableName,mb_same_zone) RETURNING lb_success 
        DISPLAY "Delete DZEB : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_import_DZEB_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        DISPLAY "Import DZEB : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_import_DZEBL_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        DISPLAY "Import DZEBL : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_delete_DZEC_data(ls_TableName,mb_same_zone) RETURNING lb_success 
        DISPLAY "Delete DZEC : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_import_DZEC_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        DISPLAY "Import DZEC : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_delete_DZED_data(ls_TableName,mb_same_zone) RETURNING lb_success 
        DISPLAY "Delete DZED : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_import_DZED_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        DISPLAY "Import DZED : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        -- adzi150 begin        
        CALL sadzp310_exim_import_DZEF_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        DISPLAY "Import DZEF : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_import_DZEP_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        DISPLAY "Import DZEP : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_import_DZEQ_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        DISPLAY "Import DZEQ : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_import_DZER_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        DISPLAY "Import DZER : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_import_DZET_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        DISPLAY "Import DZET : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        -- adzi150 end        
        #CALL sadzp310_exim_import_DZEO_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        #DISPLAY "Import DZEO : ",IIF(lb_success,cs_result_success,cs_result_fail)
        #IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_import_DZEU_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        DISPLAY "Import DZEU : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF
        #CALL sadzp310_exim_import_DZEV_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success 
        #DISPLAY "Import DZEV : ",IIF(lb_success,cs_result_success,cs_result_fail)
        #IF NOT lb_success THEN GOTO _imp_error END IF 
        #CALL sadzp310_exim_import_DZEW_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        #DISPLAY "Import DZEW : ",IIF(lb_success,cs_result_success,cs_result_fail)
        #IF NOT lb_success THEN GOTO _imp_error END IF
        CALL sadzp310_exim_import_GZTD_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        DISPLAY "Import GZTD : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_import_GZTDL_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        DISPLAY "Import GZTDL : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF
        CALL sadzp310_exim_import_DZIG_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        DISPLAY "Import DZIG : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF
        -- adzi150 begin
        CALL sadzp310_exim_import_GZCC_data(ls_TableName,mo_json_obj,mo_PARAMETERS.*) RETURNING lb_success
        DISPLAY "Import GZCC : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        -- adzi150 end
        CALL sadzp310_exim_delete_invalid_dzeu_data(ls_TableName) RETURNING lb_success
        DISPLAY "Delete invalid DZEU_T data : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        CALL sadzp310_exim_add_missing_dzeu_data(ls_TableName) RETURNING lb_success
        DISPLAY "Add missing DZEU_T data : ",IIF(lb_success,cs_result_success,cs_result_fail)
        IF NOT lb_success THEN GOTO _imp_error END IF 
        
        LABEL _imp_error:
        
        IF NOT lb_success THEN
          ROLLBACK WORK
        ELSE
          COMMIT WORK
          CALL sadzp310_db_update_alter_code(ms_MasterUser,ls_TableName)
        END IF 
        
        LABEL _return:
        
        #返回原路徑  
        CALL os.Path.chdir(ms_entry_path) RETURNING li_CHDIR
        
      END IF          
      
      LET lb_fault = NOT lb_success
      
    #Create table or modify table
    WHEN cs_exim_assemble
      LET lb_success = TRUE
      CALL sadzp310_db_check_table_exist(cs_master_user,ls_TableName) RETURNING lb_TableExists
      IF lb_TableExists THEN
        CALL sadzp310_exim_modify_table(ls_TableName,ls_ConstructVersion) RETURNING lb_success           
      ELSE
        CALL sadzp310_exim_create_table(ls_TableName,ls_ConstructVersion,ls_alm_request_no,ls_dgenv) RETURNING lb_success               
        #CALL sadzp310_vcs_reset_vcs_data(ls_TableName)
      END IF
      CALL sadzp310_db_update_alter_code(ms_MasterUser,ls_TableName)
      DISPLAY cs_information_tag," Check and generate language file."

      IF NOT mb_backend_mode THEN
        CALL sadzp310_db_gen_db_schema(ms_MasterUser.toLowerCase(),ls_TableName) RETURNING lb_result
        IF NOT lb_result THEN DISPLAY cs_error_tag," Generate ds.sch error." END IF
      END IF   

      IF (sadzp310_exim_get_table_type(ls_TableName) = "L") AND NOT (mb_backend_mode) THEN
        DISPLAY cs_information_tag," Generateing generate language file."
        #產生多語言 4gl 檔
        CALL sadzp310_util_gen_multi_lang(ls_TableName)
      END IF
      
      LET lb_fault = NOT lb_success
    #Kill snapshot  
    WHEN cs_exim_delete 
      LET lb_DelSuccess = TRUE
      IF ls_TableName IS NOT NULL THEN
        CALL sadzp310_exim_get_table_version_info(ls_TableName) RETURNING lo_VersionInfo.*
        CALL sadzp310_util_kill_snapshot(ms_MasterUser,ls_TableName,lo_VersionInfo.*) RETURNING lb_success
        IF lb_success THEN
          {
          IF ls_SD_Version = cs_rt_design_sd_version THEN 
            CALL sadzp310_exim_get_max_rev_version(ls_TableName,ls_ConstructVersion) RETURNING ls_Revision
          ELSE
            LET ls_Revision = ls_SD_Version
          END IF
          }    
          CALL sadzp310_exim_get_max_rev_version(ls_TableName,ls_ConstructVersion) RETURNING ls_Revision
          IF NVL(ls_Revision,cs_null_value) <> cs_null_value THEN
            LET lo_revision.rv_ALM_VERSION  = ls_ConstructVersion
            LET lo_revision.rv_SEQUENCE     = ls_Revision
            CALL sadzp310_rev_make_revision(ls_TableName,lo_revision.*) RETURNING lb_DelSuccess
            IF lb_DelSuccess THEN
              CALL sadzp310_db_update_alter_code(ms_MasterUser,ls_TableName)
            END IF
          ELSE
            DISPLAY "[adz-00192] There are no snapshot data for fetch."
            LET lb_DelSuccess = FALSE  
          END IF   
        END IF    
      END IF  
      LET lb_fault = NOT lb_DelSuccess
    #Drop table and related files.  
    WHEN cs_exim_drop 
      LET lb_DropSuccess = TRUE
      IF ls_TableName IS NOT NULL THEN
        LET lb_DropSuccess = FALSE      
        CALL sadzp310_util_delete_master_table(ms_MasterUser,"D",ls_TableName,TRUE) RETURNING lb_DropSuccess 
        IF NOT mb_backend_mode THEN
          CALL sadzp310_db_gen_db_schema(ms_MasterUser.toLowerCase(),ls_TableName) RETURNING lb_result
          IF NOT lb_result THEN DISPLAY cs_error_tag," Generate ds.sch error." END IF
        END IF   
      END IF  
      LET lb_fault = NOT lb_DropSuccess
    #Alter Table  
    WHEN cs_exim_alter
      LET lb_ASMSuccess = TRUE
      CALL sadzp310_db_check_table_exist(cs_master_user,ls_TableName) RETURNING lb_TableExists
      IF lb_TableExists THEN
        CALL sadzp310_exim_modify_table(ls_TableName,ls_ConstructVersion) RETURNING lb_ASMSuccess           
      ELSE
        CALL sadzp310_exim_create_table(ls_TableName,ls_ConstructVersion,ls_alm_request_no,ls_dgenv) RETURNING lb_ASMSuccess               
        #CALL sadzp310_vcs_reset_vcs_data(ls_TableName)
      END IF
      IF (sadzp310_exim_get_table_type(ls_TableName) = "L") AND NOT (mb_backend_mode) THEN
        #產生多語言 4gl 檔
        CALL sadzp310_util_gen_multi_lang(ls_TableName)
      END IF
      LET lb_fault = NOT lb_ASMSuccess
    #Table rebuild.  
    WHEN cs_exim_rebuild
      LET lb_RebuildSuccess = TRUE      
      IF ls_TableName IS NOT NULL THEN

        #異動前檢核欄位和索引與實際表格有沒有差異
        CALL sadzp310_shot_check_diff(ms_MasterUser,ls_TableName) RETURNING lb_diff
        #呼叫表格重建函式
        CALL sadzp310_util_table_rebuild(ms_MasterUser,ls_TableName,TRUE,ls_ConstructVersion) RETURNING lb_RebuildSuccess,ls_rtn_code,ls_message
        IF lb_RebuildSuccess AND ls_rtn_code = "1" THEN
          CALL sadzp310_db_update_alter_code(ms_MasterUser,ls_TableName)
          IF NOT mb_backend_mode THEN
            CALL sadzp310_db_gen_db_schema(ms_MasterUser.toLowerCase(),ls_TableName) RETURNING lb_result
            IF NOT lb_result THEN DISPLAY cs_error_tag," Generate ds.sch error." END IF
          END IF   
          IF (sadzp310_exim_get_table_type(ls_TableName) = "L") AND NOT (mb_backend_mode) THEN
            #產生多語言 4gl 檔
            CALL sadzp310_util_gen_multi_lang(ls_TableName)
          END IF             
        END IF  
        
      END IF  
      LET lb_fault = NOT lb_RebuildSuccess
    WHEN cs_null_value   
      DISPLAY "No any parameters.","\n"
  OTHERWISE
    DISPLAY "Input parameters error !!"
    CALL sadzp310_exim_show_help()  
  END CASE

  #返回原路徑  
  CALL os.Path.chdir(ms_entry_path) RETURNING li_CHDIR  

  LET mb_fault = lb_fault
  LET mo_export_info.RESULT = mb_fault

END FUNCTION

FUNCTION sadzp310_exim_finalize()
END FUNCTION

################################################################################

FUNCTION sadzp310_exim_making_work_directory(p_TableName,p_MakeType)
DEFINE
  p_TableName STRING,
  p_MakeType  STRING
DEFINE
  ls_TableName STRING,
  ls_MakeType  STRING
DEFINE
  li_ConstructVersion INTEGER,
  li_SD_Version       INTEGER,
  ls_PathName         STRING,
  ls_TEMPDIR          STRING,
  ls_GUID             STRING,
  li_MKDIR            INTEGER,
  li_CHDIR            INTEGER,
  ls_os_separator     STRING,
  ls_command          STRING
DEFINE 
  lb_return BOOLEAN, 
  ls_return STRING   

  LET ls_TableName = p_TableName
  LET ls_MakeType  = p_MakeType

  LET lb_return = TRUE

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  LET ls_GUID = security.RandomGenerator.CreateUUIDString()
  
  LET ls_TEMPDIR          = FGL_GETENV("TEMPDIR")
  LET li_ConstructVersion = mo_PARAMETERS.DZLM005
  LET li_SD_Version       = mo_PARAMETERS.DZLM006
  LET ls_PathName = ls_TEMPDIR,ls_os_separator,ls_TableName,"+TABLE+",
                    mo_PARAMETERS.DZLM012,"+",
                    (mo_PARAMETERS.DZLM015 USING cs_UsingFormat),".",ls_GUID,".",ls_MakeType

  {                  
  LET ls_command = 'mkdir ',ls_PathName                    
  RUN ls_command
  LET ls_command = 'cd ',ls_PathName
  RUN ls_command
  }
  
  CALL os.Path.mkdir(ls_PathName) RETURNING li_MKDIR

  IF NOT os.Path.exists(ls_PathName) THEN
    LET lb_return = FALSE
    DISPLAY cs_error_tag," The temporary path '",ls_PathName,"' doesn't exists !!"
  ELSE  
    CALL os.Path.chdir(ls_PathName) RETURNING li_CHDIR  
  END IF 
  
  LET ls_return = ls_PathName
  
  RETURN lb_return,ls_return  
  
END FUNCTION

FUNCTION sadzp310_exim_get_DZLM_data(p_ConstructVersion,p_SD_Version)
DEFINE
  p_ConstructVersion  STRING,
  p_SD_Version        STRING
DEFINE
  ls_ConstructVersion  STRING,
  ls_SD_Version        STRING,
  lo_DZLM_T            DYNAMIC ARRAY OF T_DZLM_T_SCR
DEFINE  
  ls_SQL     STRING,
  li_RecCnt  INTEGER,
  lo_RETURN  DYNAMIC ARRAY OF T_DZLM_T_SCR

  LET ls_ConstructVersion = p_ConstructVersion
  LET ls_SD_Version       = p_SD_Version   

  LET lo_DZLM_T = ""
  LET lo_RETURN = ""
  
  LET ls_SQL = "SELECT '',                                                     ",
               "       LM.DZLM001,LM.DZLM002,LM.DZLM003,LM.DZLM004,LM.DZLM005, ",
               "       LM.DZLM006,LM.DZLM007,LM.DZLM008,LM.DZLM009,LM.DZLM010, ",
               "       LM.DZLM011,LM.DZLM012,LM.DZLM013,LM.DZLM014,LM.DZLM015, ",
               "       LM.DZLM016,LM.DZLM017,LM.DZLM018,LM.DZLM019,LM.DZLM020, ",
               "       LM.DZLM021                                              ",  
               "  FROM DZLM_T LM                                               ",
               " WHERE LM.DZLM001 = 'T'                                        ",
               "   AND LM.DZLM005 = '",ls_ConstructVersion,"'                  ",
               "   AND LM.DZLM006 = '",ls_SD_Version,"'                        "

  PREPARE lpre_GetDZLMData FROM ls_SQL
  DECLARE lcur_GetDZLMData CURSOR FOR lpre_GetDZLMData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZLMData
  FOREACH lcur_GetDZLMData INTO lo_DZLM_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZLMData
  CALL lo_DZLM_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZLMData
  FREE lcur_GetDZLMData  

  LET lo_RETURN.* = lo_DZLM_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_get_table_type(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  ls_return     STRING,
  ls_sql        STRING,
  ls_table_type VARCHAR(10),
  ls_table_name STRING

  LET ls_table_name = p_table_name

  LET ls_sql = "SELECT EA.DZEA004                      ",
               "  FROM DZEA_T EA                       ",
               " WHERE EA.DZEA001 = '",ls_table_name,"'"
 
  PREPARE lpre_get_table_type FROM ls_sql
  DECLARE lcur_get_table_type CURSOR FOR lpre_get_table_type
  OPEN lcur_get_table_type
  FETCH lcur_get_table_type INTO ls_table_type
  CLOSE lcur_get_table_type
  FREE lcur_get_table_type
  FREE lpre_get_table_type

  LET ls_return = ls_table_type
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp310_exim_get_table_version_info(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  ls_table_name STRING,
  ls_sql        STRING,
  lo_table      T_VERSION_INFO   
DEFINE
  lo_return     T_VERSION_INFO

  LET ls_table_name = p_table_name

  LET ls_sql = "SELECT EA.DZEA012,EA.DZEA013           ",
               "  FROM DZEA_T EA                       ",
               " WHERE EA.DZEA001 = '",ls_table_name,"'"
 
  PREPARE lpre_get_table_version_info FROM ls_sql
  DECLARE lcur_get_table_version_info CURSOR FOR lpre_get_table_version_info
  OPEN lcur_get_table_version_info
  FETCH lcur_get_table_version_info INTO lo_table.*
  CLOSE lcur_get_table_version_info
  FREE lcur_get_table_version_info
  FREE lpre_get_table_version_info

  LET lo_return.* = lo_table.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzp310_exim_get_max_rev_version(p_table_name,p_alm_version)
DEFINE
  p_table_name  STRING,
  p_alm_version STRING 
DEFINE
  ls_table_name      STRING,
  ls_alm_version     STRING,
  ls_sql             STRING,
  ls_max_rev_version VARCHAR(40)
DEFINE
  ls_return STRING

  LET ls_table_name  = p_table_name
  LET ls_alm_version = p_alm_version

  #呼叫取得最大的Revision Number
  CALL sadzp310_shot_get_max_construct_revision(ms_MasterUser,ls_table_name,ls_alm_version) RETURNING ls_max_rev_version 

  LET ls_return = ls_max_rev_version
  
  RETURN ls_return
  
END FUNCTION

## DZEA_T ######################################################################

FUNCTION sadzp310_exim_export_DZEA_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEA_T"
  
  CALL sadzp310_exim_get_DZEA_data(ls_TableName,p_json_obj,lo_PARAMETERS.*) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
                    
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZEA_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName   STRING,
  p_json_obj    util.JSONObject,
  po_PARAMETERS T_DZLM_T_SCR  
DEFINE
  ls_TableName    STRING,
  lo_PARAMETERS   T_DZLM_T_SCR,
  ls_MaxVersion   STRING,
  ls_ALMInfo      STRING,
  lo_DZEA_T       DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*
  
  LET lo_DZEA_T = ""
  LET lo_RETURN = ""
  LET ls_ALMInfo = ""

  #DZEA019,020,021 為 GUID, 匯出空白
  LET ls_SQL = "SELECT EA.DZEA001,EA.DZEA002,EA.DZEA003,EA.DZEA004,EA.DZEA005,",
               "       EA.DZEA006,EA.DZEA007,EA.DZEA008,EA.DZEA009,EA.DZEA010,",
               "       EA.DZEA011,EA.DZEA012,EA.DZEA013,EA.DZEA014,EA.DZEA015,",
               "       EA.DZEA016,EA.DZEA017,EA.DZEA018,'' DZEA019,'' DZEA020,",
               "       '' DZEA021                                             ",  
               "  FROM DZEA_T EA                                              ",
               " WHERE EA.DZEA001 = '",ls_TableName,"'                        "

  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZEA_T' TABLE_NAME,COUNT(1) RECORDS  ",
                   "  FROM DZEA_T EA                             ",
                   " WHERE EA.DZEA001 = '",ls_TableName,"'       "

  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)    
              
  PREPARE lpre_GetDZEAData FROM ls_SQL
  DECLARE lcur_GetDZEAData CURSOR FOR lpre_GetDZEAData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZEAData
  FOREACH lcur_GetDZEAData INTO lo_DZEA_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZEAData
  CALL lo_DZEA_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZEAData
  FREE lcur_GetDZEAData  

  LET lo_RETURN.* = lo_DZEA_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZEA_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEA_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZEA_T_data(lo_DATAS) RETURNING lb_success
    END IF  
  END IF
  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZEA_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  ls_user         VARCHAR(100),
  ldt_datetime    DATETIME YEAR TO SECOND,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  &ifndef DEBUG
  LET ls_user = g_user
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  &endif
  LET ldt_datetime = CURRENT YEAR TO SECOND
  
  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           "'",lo_DATAS[li_loop,3],"',",
                           "'",lo_DATAS[li_loop,4],"',",
                           "'",lo_DATAS[li_loop,5],"',",
                           "'",lo_DATAS[li_loop,6],"',",
                           "'",lo_DATAS[li_loop,7],"',",
                           "'",lo_DATAS[li_loop,8],"',",
                           "'",lo_DATAS[li_loop,9],"',",
                           "'",lo_DATAS[li_loop,10],"',",
                           "'",lo_DATAS[li_loop,11],"',",
                           "'",lo_DATAS[li_loop,12],"',",
                           #"'",IIF(mb_same_zone,ms_max_sequence,lo_DATAS[li_loop,13]),"',", #異動序號
                           "'",ms_max_sequence,"',", #異動序號
                           "'",lo_DATAS[li_loop,14],"',",
                           "'",lo_DATAS[li_loop,15],"',",
                           "'",lo_DATAS[li_loop,16],"',",
                           "'",lo_DATAS[li_loop,17],"',",
                           "'",lo_DATAS[li_loop,18],"',",
                           "'",lo_DATAS[li_loop,19],"',",
                           "'",lo_DATAS[li_loop,20],"',",
                           "'",lo_DATAS[li_loop,21],"',",
                           "'",ls_user,"',",
                           "systimestamp,",
                           "'",ls_user,"',",
                           "systimestamp"

      #DZEA019,020,021 為 GUID, 只Insert不Update                     
      LET ls_InsertSQL = "INSERT INTO DZEA_T (                                         ",
                         "                    DZEA001,DZEA002,DZEA003,DZEA004,DZEA005, ",
                         "                    DZEA006,DZEA007,DZEA008,DZEA009,DZEA010, ",
                         "                    DZEA011,DZEA012,DZEA013,DZEA014,DZEA015, ",
                         "                    DZEA016,DZEA017,DZEA018,DZEA019,DZEA020, ", 
                         "                    DZEA021,                                 ",
                         "                    DZEACRTID,DZEACRTDT,DZEAMODID,DZEAMODDT  ", 
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "

      #DZEA015,DZEA018 為客制標示, 不更新                   
      #DZEA019,020,021 為 GUID, 只Insert不Update                   
      LET ls_UpdateValue = "DZEA002 = '",lo_DATAS[li_loop,2],"',",
                           "DZEA003 = '",lo_DATAS[li_loop,3],"',",
                           "DZEA004 = '",lo_DATAS[li_loop,4],"',",
                           "DZEA005 = '",lo_DATAS[li_loop,5],"',",
                           "DZEA006 = '",lo_DATAS[li_loop,6],"',",
                           "DZEA007 = '",lo_DATAS[li_loop,7],"',",
                           "DZEA008 = '",lo_DATAS[li_loop,8],"',",
                           "DZEA009 = '",lo_DATAS[li_loop,9],"',",
                           "DZEA010 = '",lo_DATAS[li_loop,10],"',",
                           "DZEA011 = '",lo_DATAS[li_loop,11],"',",
                           "DZEA012 = '",lo_DATAS[li_loop,12],"',",
                           #"DZEA013 = '",IIF(mb_same_zone,ms_max_sequence,lo_DATAS[li_loop,13]),"',", #異動序號
                           "DZEA013 = '",ms_max_sequence,"',", #異動序號
                           "DZEA014 = '",lo_DATAS[li_loop,14],"',",
                           #"DZEA015 = '",lo_DATAS[li_loop,15],"',",
                           "DZEA016 = '",lo_DATAS[li_loop,16],"',",
                           "DZEA017 = '",lo_DATAS[li_loop,17],"',",
                           #"DZEA018 = '",lo_DATAS[li_loop,18],"',",
                           #"DZEA019 = '",lo_DATAS[li_loop,19],"',",
                           #"DZEA020 = '",lo_DATAS[li_loop,20],"',",
                           #"DZEA021 = '",lo_DATAS[li_loop,21],"',",
                           "DZEAMODID = TRIM('",ls_user,"'),",
                           "DZEAMODDT = systimestamp"
                           
      LET ls_UpdateSQL = "UPDATE DZEA_T SET ",
                         ls_UpdateValue,
                         " WHERE DZEA001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND NVL(DZEA015,'",cs_dgenv_standard,"') = '",cs_dgenv_standard,"'" 
                         
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
    END IF
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZEBL_T #####################################################################

FUNCTION sadzp310_exim_export_DZEBL_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEBL_T"
  
  CALL sadzp310_exim_get_DZEBL_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
                    
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZEBL_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj    util.JSONObject  
DEFINE
  ls_TableName  STRING,
  lo_DZEBL_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_DZEBL_T = ""
  LET lo_RETURN = ""
  
  LET ls_SQL = "SELECT EBL.DZEBL001,EBL.DZEBL002,EBL.DZEBL003,EBL.DZEBL004,EBL.DZEBL000 ",
               "  FROM DZEBL_T EBL                                                      ",
               " WHERE EXISTS (                                                         ",
               "                SELECT 1                                                ",
               "                  FROM DZEB_T EB                                        ",
               "                 WHERE EB.DZEB002 = EBL.DZEBL001                        ",
               "                   AND EB.DZEB001 = '",ls_TableName,"'                  ",
               "              )                                                         "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZEBL_T' TABLE_NAME,COUNT(1) RECORDS           ",
                   "  FROM DZEBL_T EBL                                     ",
                   " WHERE EXISTS (                                        ",
                   "                SELECT 1                               ",
                   "                  FROM DZEB_T EB                       ",
                   "                 WHERE EB.DZEB002 = EBL.DZEBL001       ",
                   "                   AND EB.DZEB001 = '",ls_TableName,"' ",
                   "              )                                        "

  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)    

  PREPARE lpre_GetDZEBLData FROM ls_SQL
  DECLARE lcur_GetDZEBLData CURSOR FOR lpre_GetDZEBLData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZEBLData
  FOREACH lcur_GetDZEBLData INTO lo_DZEBL_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZEBLData
  CALL lo_DZEBL_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZEBLData
  FREE lcur_GetDZEBLData  

  LET lo_RETURN.* = lo_DZEBL_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZEBL_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEBL_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZEBL_T_data(lo_DATAS) RETURNING lb_success
    END IF  
  END IF  

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZEBL_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  lb_is_lang      BOOLEAN,
  li_lng          INTEGER,
  li_loop         INTEGER,
  lb_is_udfc      BOOLEAN
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL THEN
    
      #從清單中取得可匯入的語言別
      LET lb_is_lang = FALSE
      FOR li_lng = 1 TO mo_local_lang.getLength()
        IF lo_DATAS[li_loop,2] = mo_local_lang[li_lng] THEN
          LET lb_is_lang = TRUE
          EXIT FOR
        END IF 
      END FOR 

      #符合當地多語言清單的資料才匯入
      IF lb_is_lang THEN
      
        LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                             "'",lo_DATAS[li_loop,2],"',",
                             "'",lo_DATAS[li_loop,3],"',",
                             "'",lo_DATAS[li_loop,4],"',",
                             "'",lo_DATAS[li_loop,5],"'"
                             
        LET ls_InsertSQL = "INSERT INTO DZEBL_T (                                              ",
                           "                      DZEBL001,DZEBL002,DZEBL003,DZEBL004,DZEBL000 ",
                           "                    )                                              ",  
                           " VALUES (                                                          ",
                           ls_InsertValue,
                           "        )                                                          "
                           
        LET ls_UpdateValue = "EBL.DZEBL003 = '",lo_DATAS[li_loop,3],"',",
                             "EBL.DZEBL004 = '",lo_DATAS[li_loop,4],"',",
                             "EBL.DZEBL000 = '",lo_DATAS[li_loop,5],"'"

        #只更新非自定義欄位資料
        LET ls_UpdateSQL = "UPDATE DZEBL_T EBL SET                          ",
                           ls_UpdateValue,
                           " WHERE EBL.DZEBL001 = '",lo_DATAS[li_loop,1],"' ",
                           "   AND EBL.DZEBL002 = '",lo_DATAS[li_loop,2],"' "
                           
        CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
        IF NOT lb_success THEN
          CALL sadzp310_exim_check_if_user_define_column(lo_DATAS[li_loop,5],lo_DATAS[li_loop,1]) RETURNING lb_is_udfc
          -- 非使用者定義欄位或者是使用者定義欄位而且同樣的區域才執行更新
          IF (NOT lb_is_udfc) OR (lb_is_udfc AND mb_same_zone) THEN 
            CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
          ELSE
            LET lb_success = TRUE  
          END IF  
          IF NOT lb_success THEN
            DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
            DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
            EXIT FOR 
          END IF
        END IF
      END IF
    END IF   
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZEB_T #####################################################################

FUNCTION sadzp310_exim_export_DZEB_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEB_T"
  
  CALL sadzp310_exim_get_DZEB_data(ls_TableName,p_json_obj,lo_PARAMETERS.*) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZEB_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName   STRING,
  p_json_obj    util.JSONObject,
  po_PARAMETERS T_DZLM_T_SCR  
DEFINE
  ls_TableName    STRING,
  lo_PARAMETERS   T_DZLM_T_SCR,
  ls_MaxVersion   STRING,
  lo_DZEB_T       DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET lo_DZEB_T = ""
  LET lo_RETURN = ""

  IF (lo_parameters.DZLM005 = cs_NoVersionCharacter) OR 
     (NOT sadzp310_exim_check_version_data_exist(ls_TableName)) OR 
     (NOT sadzp310_exim_check_alm_request_data_exist(ls_TableName,lo_PARAMETERS.*))THEN

    LET ls_SQL = "SELECT EB.DZEB001,EB.DZEB002,EB.DZEB003,EB.DZEB004,EB.DZEB005,",
                 "       EB.DZEB006,EB.DZEB007,EB.DZEB008,EB.DZEB012,EB.DZEB021,",
                 "       EB.DZEB022,EB.DZEB023,EB.DZEB024,EB.DZEB027,EB.DZEB028,",
                 "       EB.DZEB029,EB.DZEB030,EB.DZEB031                       ",
                 "  FROM DZEB_T EB                                              ",
                 " WHERE EB.DZEB001 = '",ls_TableName,"'                        ",
                 " ORDER BY EB.DZEB021                                          "

    #取得Table export notice             
    LET ls_tsn_SQL = "SELECT 'DZEB_T' TABLE_NAME,COUNT(1) RECORDS  ",
                     "  FROM DZEB_T EB                             ",
                     " WHERE EB.DZEB001 = '",ls_TableName,"'       "

  ELSE
    LET ls_SQL = "SELECT LOWER(EV.DZEV002)                         DZEB001,     ",
                 "       LOWER(EV.DZEV005)                         DZEB002,     ",
                 "       EV.DZEV010                                DZEB003,     ",
                 "       EV.DZEV006                                DZEB004,     ",
                 "       DECODE(EV.DZEV007,'Y','N','N','Y','Y')    DZEB005,     ",
                 "       EV.DZEV013                                DZEB006,     ",
                 "       LOWER(EV.DZEV008)                         DZEB007,     ",
                 "       DECODE(EV.DZEV008,'DATE',NULL,EV.DZEV009) DZEB008,     ",
                 "       EV.DZEV021                                DZEB012,     ", 
                 "       EV.DZEV014                                DZEB021,     ",
                 "       EV.DZEV015                                DZEB022,     ",
                 "       EV.DZEV016                                DZEB023,     ",
                 "       EV.DZEV017                                DZEB024,     ",
                 "       NULL                                      DZEB027,     ",
                 "       'N'                                       DZEB028,     ",                         
                 "       EV.DZEV020                                DZEB029,     ",                         
                 "       EV.DZEV022                                DZEB030,     ",                         
                 #"       EV.DZEV023                                DZEB031      ",                         
                 "       EB.DZEB031                                DZEB031      ",                         
                 "  FROM DZEV_T EV                                              ",
                 "  LEFT OUTER JOIN DZEB_T EB ON EB.DZEB001 = LOWER(EV.DZEV002) ",
                 "                           AND EB.DZEB002 = LOWER(EV.DZEV005) ",
                 " WHERE EV.DZEV002 = '",ls_TableName.toUpperCase(),"'          ",
                 "   AND EV.DZEV003 = TRIM('",lo_parameters.DZLM015,"')         ", 
                 "   AND EV.DZEV004 = 'TableDesigner'                           ",
                 "   AND EV.DZEV018 = '",lo_parameters.DZLM005,"'               ",
                 "   AND EV.DZEV019 = '",lo_parameters.DZLM012,"'               ",
                 " ORDER BY EV.DZEV011                                          "

    #取得Table export notice             
    LET ls_tsn_SQL = "SELECT 'DZEB_T' TABLE_NAME,COUNT(1) RECORDS          ",
                     "  FROM DZEV_T EV                                     ",
                     " WHERE EV.DZEV002 = '",ls_TableName.toUpperCase(),"' ",
                     "   AND EV.DZEV003 = TRIM('",lo_parameters.DZLM015,"')", 
                     "   AND EV.DZEV004 = 'TableDesigner'                  ",
                     "   AND EV.DZEV018 = '",lo_parameters.DZLM005,"'      ",
                     "   AND EV.DZEV019 = '",lo_parameters.DZLM012,"'      "
                     
  END IF

  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)    
  
  PREPARE lpre_GetDZEBData FROM ls_SQL
  DECLARE lcur_GetDZEBData CURSOR FOR lpre_GetDZEBData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZEBData
  FOREACH lcur_GetDZEBData INTO lo_DZEB_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZEBData
  CALL lo_DZEB_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZEBData
  FREE lcur_GetDZEBData  

  LET lo_RETURN.* = lo_DZEB_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_delete_DZEB_data(p_TableName,p_same_zone)
DEFINE
  p_TableName STRING,
  p_same_zone BOOLEAN 
DEFINE
  ls_TableName  STRING,
  lb_same_zone  BOOLEAN, 
  ls_DeleteSQL  STRING, 
  ls_sql_cond   STRING,
  lb_success    BOOLEAN 

  LET ls_TableName = p_TableName.toLowerCase()
  LET lb_same_zone = p_same_zone

  IF lb_same_zone THEN
    LET ls_sql_cond = ""
  ELSE
    LET ls_sql_cond = " AND NVL(DZEB029,'",cs_dgenv_standard,"') = '",cs_dgenv_standard,"'"
  END IF 

  LET ls_DeleteSQL = "DELETE FROM DZEB_T                 ",
                     " WHERE DZEB001 = '",ls_TableName,"'",
                     ls_sql_cond
                     
  #DISPLAY ls_DeleteSQL
  
  CALL sadzp310_exim_exec_SQL(ls_DeleteSQL) RETURNING lb_success

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZEB_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEB_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZEB_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF  

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZEB_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  ls_user         VARCHAR(100),
  ls_orig_coltype STRING,
  ls_column_type  STRING,
  li_sequence     INTEGER,
  ls_sequence     STRING,
  ls_ship_notice  STRING,
  lo_property     T_PROPERTY,
  ldt_datetime    DATETIME YEAR TO SECOND,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  &ifndef DEBUG
  LET ls_user = g_user
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  &endif
  LET ldt_datetime = CURRENT YEAR TO SECOND
  
  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL THEN
    
      #相同的ZONE就用相同的序號 
      IF mb_same_zone OR mb_new_table THEN
        LET ls_sequence = lo_DATAS[li_loop,10]
      ELSE
        #取得Sequnece ID  
        CALL sadzp310_exim_get_column_sequence(lo_DATAS[li_loop,1],lo_DATAS[li_loop,2]) RETURNING li_sequence
        LET ls_sequence = li_sequence
        LET ls_sequence = ls_sequence.trim()
      END IF 

      #取得欄位型態, 當舊型態和新型態不同時才重取對應的資料型態值(已出貨欄位才做判斷)
      LET ls_ship_notice = lo_DATAS[li_loop,18]
      IF ls_ship_notice = cs_column_shipped THEN
        LET ls_orig_coltype = lo_DATAS[li_loop,6]
        CALL sadzp310_exim_get_column_type(lo_DATAS[li_loop,1],lo_DATAS[li_loop,2],ls_orig_coltype) RETURNING ls_column_type
        IF ls_column_type <> ls_orig_coltype THEN
          CALL sadzp310_util_get_property(ls_column_type,ms_dlang) RETURNING lo_property.*
          LET lo_DATAS[li_loop,6] = ls_column_type  
          LET lo_DATAS[li_loop,7] = lo_property.d_type
          LET lo_DATAS[li_loop,8] = lo_property.d_length
        END IF
      END IF  
      
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           "'",lo_DATAS[li_loop,3],"',",
                           "'",lo_DATAS[li_loop,4],"',",
                           "'",lo_DATAS[li_loop,5],"',",
                           "'",lo_DATAS[li_loop,6],"',",
                           "'",lo_DATAS[li_loop,7],"',",
                           "'",lo_DATAS[li_loop,8],"',",
                           "'",lo_DATAS[li_loop,9],"',",
                           "",NVL(ls_sequence,"NULL"),",",
                           "'",lo_DATAS[li_loop,11],"',",
                           "",NVL(lo_DATAS[li_loop,12],"NULL"),",",
                           "'",lo_DATAS[li_loop,13],"',",
                           "'",lo_DATAS[li_loop,14],"',",
                           "'",lo_DATAS[li_loop,15],"',",
                           "'",lo_DATAS[li_loop,16],"',",
                           "'",lo_DATAS[li_loop,17],"',",
                           "'",lo_DATAS[li_loop,18],"',",
                           "'",ls_user,"',",
                           "systimestamp,",
                           "'",ls_user,"',",
                           "systimestamp"
                                                    
      LET ls_InsertSQL = "INSERT INTO DZEB_T (                                         ",
                         "                    DZEB001,DZEB002,DZEB003,DZEB004,DZEB005, ",
                         "                    DZEB006,DZEB007,DZEB008,DZEB012,DZEB021, ",
                         "                    DZEB022,DZEB023,DZEB024,DZEB027,DZEB028, ",
                         "                    DZEB029,DZEB030,DZEB031,                 ",
                         "                    DZEBCRTID,DZEBCRTDT,DZEBMODID,DZEBMODDT  ",
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "

      #DZEB029,DZEB030 為客制標示, 不更新                   
      LET ls_UpdateValue = "DZEB003 = '",lo_DATAS[li_loop,3],"',",
                           "DZEB004 = '",lo_DATAS[li_loop,4],"',",
                           "DZEB005 = '",lo_DATAS[li_loop,5],"',",
                           "DZEB006 = '",lo_DATAS[li_loop,6],"',",
                           "DZEB007 = '",lo_DATAS[li_loop,7],"',",
                           "DZEB008 = '",lo_DATAS[li_loop,8],"',",
                           "DZEB012 = '",lo_DATAS[li_loop,9],"',",
                           "DZEB021 = ",NVL(ls_sequence,"NULL"),",",  #"DZEB021 = ",NVL(lo_DATAS[li_loop,10],"NULL"),",",
                           "DZEB022 = '",lo_DATAS[li_loop,11],"',",
                           "DZEB023 = ",NVL(lo_DATAS[li_loop,12],"NULL"),",",
                           "DZEB024 = '",lo_DATAS[li_loop,13],"',",
                           "DZEB027 = '",lo_DATAS[li_loop,14],"',",
                           "DZEB028 = '",lo_DATAS[li_loop,15],"',",
                           #"DZEB029 = '",lo_DATAS[li_loop,16],"',",
                           #"DZEB030 = '",lo_DATAS[li_loop,17],"',",
                           "DZEB031 = '",lo_DATAS[li_loop,18],"',",
                           "DZEBMODID = TRIM('",ls_user,"'),",
                           "DZEBMODDT = systimestamp"
                                                    
      LET ls_UpdateSQL = "UPDATE DZEB_T SET ",
                         ls_UpdateValue,
                         " WHERE DZEB001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND DZEB002 = '",lo_DATAS[li_loop,2],"'"
                         --"   AND NVL(DZEB029,'",cs_dgenv_standard,"') = '",cs_dgenv_standard,"'"
                         
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
    END IF
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZEC_T #####################################################################

FUNCTION sadzp310_exim_export_DZEC_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEC_T"
  
  CALL sadzp310_exim_get_DZEC_data(ls_TableName,p_json_obj,lo_PARAMETERS.*) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZEC_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName   STRING,
  p_json_obj    util.JSONObject,
  po_PARAMETERS T_DZLM_T_SCR  
DEFINE
  ls_TableName   STRING,
  lo_PARAMETERS  T_DZLM_T_SCR,
  ls_MaxVersion  STRING,
  lo_DZEC_T      DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*
  
  LET lo_DZEC_T = ""
  LET lo_RETURN = ""

  IF (lo_parameters.DZLM005 = cs_NoVersionCharacter) OR 
     (NOT sadzp310_exim_check_version_data_exist(ls_TableName)) OR 
     (NOT sadzp310_exim_check_alm_request_data_exist(ls_TableName,lo_PARAMETERS.*))THEN
     
    LET ls_SQL = "SELECT EC.DZEC001,EC.DZEC002,EC.DZEC003,EC.DZEC004,EC.DZEC005,",
                 "       EC.DZEC006,EC.DZEC007,EC.DZEC008                       ",  
                 "  FROM DZEC_T EC                                              ",
                 " WHERE EC.DZEC001 = '",ls_TableName,"'                        "
    #取得Table export notice             
    LET ls_tsn_SQL = "SELECT 'DZEC_T' TABLE_NAME,COUNT(1) RECORDS  ",
                     "  FROM DZEC_T EC                              ",
                     " WHERE EC.DZEC001 = '",ls_TableName,"'        "

  ELSE
  
    LET ls_SQL = "SELECT EW.DZEW001 DZEC001,                                    ",
                 "       EW.DZEW004 DZEC002,                                    ",
                 "       EW.DZEW005 DZEC003,                                    ",
                 "       EW.DZEW006 DZEC004,                                    ",
                 "       'N'        DZEC005,                                    ",
                 "       EW.DZEW012 DZEC006,                                    ", 
                 "       EW.DZEW013 DZEC007,                                    ", 
                 #"       EW.DZEW014 DZEC008                                     ", 
                 "       EC.DZEC008 DZEC008                                     ", 
                 "  FROM DZEW_T EW                                              ",
                 "  LEFT OUTER JOIN DZEC_T EC ON EC.DZEC001 = LOWER(EW.DZEW001) ", 
                 "                           AND EC.DZEC002 = LOWER(EW.DZEW004) ",
                 " WHERE EW.DZEW001 = '",ls_TableName.toLowerCase(),"'          ",
                 "   AND EW.DZEW002 = TRIM('",lo_PARAMETERS.DZLM015,"')         ",
                 "   AND EW.DZEW003 = 'Index'                                   ",
                 "   AND EW.DZEW010 = '",lo_PARAMETERS.DZLM005,"'               ",
                 "   AND EW.DZEW011 = '",lo_PARAMETERS.DZLM012,"'               "

    LET ls_tsn_SQL = "SELECT 'DZEC_T' TABLE_NAME,COUNT(1) RECORDS          ",
                     "  FROM DZEW_T EW                                     ",
                     " WHERE EW.DZEW001 = '",ls_TableName.toLowerCase(),"' ",
                     "   AND EW.DZEW002 = TRIM('",lo_PARAMETERS.DZLM015,"')",
                     "   AND EW.DZEW003 = 'Index'                          ",
                     "   AND EW.DZEW010 = '",lo_PARAMETERS.DZLM005,"'      ",
                     "   AND EW.DZEW011 = '",lo_PARAMETERS.DZLM012,"'      "
  END IF

  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)    
  
  PREPARE lpre_GetDZECData FROM ls_SQL
  DECLARE lcur_GetDZECData CURSOR FOR lpre_GetDZECData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZECData
  FOREACH lcur_GetDZECData INTO lo_DZEC_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZECData
  CALL lo_DZEC_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZECData
  FREE lcur_GetDZECData  

  LET lo_RETURN.* = lo_DZEC_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_delete_DZEC_data(p_TableName,p_same_zone)
DEFINE
  p_TableName STRING,
  p_same_zone BOOLEAN
DEFINE
  ls_TableName  STRING,
  lb_same_zone  BOOLEAN, 
  ls_DeleteSQL  STRING, 
  ls_sql_cond   STRING,
  lb_success    BOOLEAN 

  LET ls_TableName = p_TableName.toLowerCase()
  LET lb_same_zone = p_same_zone

  IF lb_same_zone THEN
    LET ls_sql_cond = ""
  ELSE
    LET ls_sql_cond = " AND NVL(DZEC006,'",cs_dgenv_standard,"') = '",cs_dgenv_standard,"'"
  END IF
  
  LET ls_DeleteSQL = "DELETE FROM DZEC_T                               ",
                     " WHERE DZEC001 = '",ls_TableName.toLowerCase(),"'",
                     ls_sql_cond
                     
  #DISPLAY ls_DeleteSQL
  
  CALL sadzp310_exim_exec_SQL(ls_DeleteSQL) RETURNING lb_success

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZEC_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEC_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZEC_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF  

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZEC_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  ls_user         VARCHAR(100),
  ldt_datetime    DATETIME YEAR TO SECOND,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  &ifndef DEBUG
  LET ls_user = g_user
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  &endif
  LET ldt_datetime = CURRENT YEAR TO SECOND
  
  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           "'",lo_DATAS[li_loop,3],"',",
                           "'",lo_DATAS[li_loop,4],"',",
                           "'",lo_DATAS[li_loop,5],"',",
                           "'",lo_DATAS[li_loop,6],"',",
                           "'",lo_DATAS[li_loop,7],"',",
                           "'",lo_DATAS[li_loop,8],"',",
                           "'",ls_user,"',",
                           "systimestamp,",
                           "'",ls_user,"',",
                           "systimestamp"
                                                    
      LET ls_InsertSQL = "INSERT INTO DZEC_T (                                        ",
                         "                    DZEC001,DZEC002,DZEC003,DZEC004,DZEC005,",
                         "                    DZEC006,DZEC007,DZEC008,                ",
                         "                    DZECCRTID,DZECCRTDT,DZECMODID,DZECMODDT ",   
                         "                   )                                        ",  
                         " VALUES (                                                   ",
                         ls_InsertValue,
                         "        )                                                   "
                         
      #DZEC006,DZEC007 為客制標示, 不更新                   
      LET ls_UpdateValue = "DZEC003 = '",lo_DATAS[li_loop,3],"',",
                           "DZEC004 = '",lo_DATAS[li_loop,4],"',",
                           "DZEC005 = '",lo_DATAS[li_loop,5],"',",
                           #"DZEC006 = '",lo_DATAS[li_loop,6],"',",
                           #"DZEC007 = '",lo_DATAS[li_loop,7],"',",
                           "DZEC008 = '",lo_DATAS[li_loop,8],"',",
                           "DZECMODID = TRIM('",ls_user,"'),",
                           "DZECMODDT = systimestamp"
                                                    
      LET ls_UpdateSQL = "UPDATE DZEC_T SET ",
                         ls_UpdateValue,
                         " WHERE DZEC001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND DZEC002 = '",lo_DATAS[li_loop,2],"'"
                         --"   AND NVL(DZEC006,'",cs_dgenv_standard,"') = '",cs_dgenv_standard,"'"
                         
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
    END IF    
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZED_T #####################################################################

FUNCTION sadzp310_exim_export_DZED_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZED_T"
  
  CALL sadzp310_exim_get_DZED_data(ls_TableName,p_json_obj,lo_PARAMETERS.*) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZED_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName   STRING,
  p_json_obj    util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName   STRING,
  lo_PARAMETERS  T_DZLM_T_SCR,
  lo_REVISION    T_REVISION,
  ls_MaxVersion  STRING,
  lo_DZED_T      DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET lo_DZED_T = ""
  LET lo_RETURN = ""

  IF (lo_parameters.DZLM005 = cs_NoVersionCharacter) OR 
     (NOT sadzp310_exim_check_version_data_exist(ls_TableName)) OR 
     (NOT sadzp310_exim_check_alm_request_data_exist(ls_TableName,lo_PARAMETERS.*))THEN

    -- F: Footing data, R:Referencing Key, P:Primary Key 
    -- Footint Data 沒有版次的架構, 所以要另外匯出
    LET ls_SQL = "SELECT ED.DZED001,ED.DZED002,ED.DZED003,ED.DZED004,ED.DZED005,",
                 "       ED.DZED006,ED.DZED007,ED.DZED008,ED.DZED009,ED.DZED010 ",
                 "  FROM DZED_T ED                                              ",
                 " WHERE ED.DZED001 = '",ls_TableName,"'                        ",
                 "   AND ED.DZED003 <> 'F'                                      ",
                 "UNION                                                         ",
                 "SELECT ED.DZED001,ED.DZED002,ED.DZED003,ED.DZED004,ED.DZED005,",
                 "       ED.DZED006,ED.DZED007,ED.DZED008,ED.DZED009,ED.DZED010 ",
                 "  FROM DZED_T ED                                              ",
                 " WHERE ED.DZED001 = '",ls_TableName,"'                        ",
                 "   AND ED.DZED003 = 'F'                                       "
                 
    -- 取得Table export notice             
    LET ls_tsn_SQL = "SELECT 'DZED_T' TABLE_NAME,COUNT(1) RECORDS     ",
                     "  FROM (                                        ",
                     "        SELECT *                                ",
                     "          FROM DZED_T ED                        ",
                     "         WHERE ED.DZED001 = '",ls_TableName,"'  ",
                     "           AND ED.DZED003 <> 'F'                ",
                     "        UNION                                   ",
                     "        SELECT *                                ",
                     "          FROM DZED_T ED                        ",
                     "         WHERE ED.DZED001 = '",ls_TableName,"'  ",
                     "           AND ED.DZED003 = 'F'                 ",
                     "       ) ED                                     "
  ELSE
    -- Footing data 要另外 Union
    LET ls_SQL = "SELECT EW.DZEW001 DZED001,                                    ",
                 "       EW.DZEW004 DZED002,                                    ",
                 "       EW.DZEW005 DZED003,                                    ",
                 "       EW.DZEW006 DZED004,                                    ",
                 "       EW.DZEW007 DZED005,                                    ",
                 "       EW.DZEW008 DZED006,                                    ",
                 "       'N'        DZED007,                                    ",
                 "       EW.DZEW012 DZED008,                                    ",                 
                 "       EW.DZEW013 DZED009,                                    ",                 
                 #"       EW.DZEW014 DZED010                                     ",                 
                 "       ED.DZED010 DZED010                                     ",                 
                 "  FROM DZEW_T EW                                              ",
                 "  LEFT OUTER JOIN DZED_T ED ON ED.DZED001 = LOWER(EW.DZEW001) ", 
                 "                           AND ED.DZED002 = LOWER(EW.DZEW004) ",
                 "WHERE EW.DZEW001 = '",ls_TableName.toLowerCase(),"'           ",
                 "  AND EW.DZEW002 = TRIM('",lo_PARAMETERS.DZLM015,"')          ",
                 "  AND EW.DZEW003 = 'Constraint'                               ",
                 "  AND EW.DZEW010 = '",lo_PARAMETERS.DZLM005,"'                ",
                 "  AND EW.DZEW011 = '",lo_PARAMETERS.DZLM012,"'                ",
                 "UNION                                                         ",
                 "SELECT ED.DZED001,ED.DZED002,ED.DZED003,ED.DZED004,ED.DZED005,",
                 "       ED.DZED006,ED.DZED007,ED.DZED008,ED.DZED009,ED.DZED010 ",
                 "  FROM DZED_T ED                                              ",
                 " WHERE ED.DZED001 = '",ls_TableName,"'                        ",
                 "   AND ED.DZED003 = 'F'                                       "
                 
    -- 取得Table export notice     
    -- Footing data count 要另外 Union    
    LET ls_tsn_SQL = "SELECT 'DZED_T' TABLE_NAME,COUNT(1) RECORDS                           ",
                     "  FROM (                                                              ",
                     "        SELECT EW.DZEW001 DZED001,                                    ",
                     "               EW.DZEW004 DZED002,                                    ",
                     "               EW.DZEW005 DZED003,                                    ",
                     "               EW.DZEW006 DZED004,                                    ",
                     "               EW.DZEW007 DZED005,                                    ",
                     "               EW.DZEW008 DZED006,                                    ",
                     "               'N'        DZED007,                                    ",
                     "               EW.DZEW012 DZED008,                                    ",                 
                     "               EW.DZEW013 DZED009,                                    ",                 
                     "               EW.DZEW014 DZED010                                     ",
                     "          FROM DZEW_T EW                                              ",
                     "         WHERE EW.DZEW001 = '",ls_TableName.toLowerCase(),"'          ",
                     "           AND EW.DZEW002 = TRIM('",lo_PARAMETERS.DZLM015,"')         ",
                     "           AND EW.DZEW003 = 'Constraint'                              ",
                     "           AND EW.DZEW010 = '",lo_PARAMETERS.DZLM005,"'               ",
                     "           AND EW.DZEW011 = '",lo_PARAMETERS.DZLM012,"'               ",
                     "        UNION                                                         ",
                     "        SELECT ED.DZED001,ED.DZED002,ED.DZED003,ED.DZED004,ED.DZED005,",
                     "               ED.DZED006,ED.DZED007,ED.DZED008,ED.DZED009,ED.DZED010 ",
                     "          FROM DZED_T ED                                              ",
                     "         WHERE ED.DZED001 = '",ls_TableName.toLowerCase(),"'          ",
                     "           AND ED.DZED003 = 'F'                                       ",
                     "       ) ED                                                           "
  END IF

  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)    
  
  PREPARE lpre_GetDZEDData FROM ls_SQL
  DECLARE lcur_GetDZEDData CURSOR FOR lpre_GetDZEDData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZEDData
  FOREACH lcur_GetDZEDData INTO lo_DZED_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZEDData
  CALL lo_DZED_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZEDData
  FREE lcur_GetDZEDData  

  LET lo_RETURN.* = lo_DZED_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_delete_DZED_data(p_TableName,p_same_zone)
DEFINE
  p_TableName STRING,
  p_same_zone BOOLEAN
DEFINE
  ls_TableName  STRING,
  lb_same_zone  BOOLEAN, 
  ls_DeleteSQL  STRING, 
  ls_sql_cond   STRING,
  lb_success    BOOLEAN 

  LET ls_TableName = p_TableName.toLowerCase()
  LET lb_same_zone = p_same_zone

  IF lb_same_zone THEN
    LET ls_sql_cond = ""
  ELSE
    LET ls_sql_cond = " AND NVL(DZED008,'",cs_dgenv_standard,"') = '",cs_dgenv_standard,"'"
  END IF
  
  LET ls_DeleteSQL = "DELETE FROM DZED_T                               ",
                     " WHERE DZED001 = '",ls_TableName.toLowerCase(),"'",
                     ls_sql_cond
                     
  #DISPLAY ls_DeleteSQL
  
  CALL sadzp310_exim_exec_SQL(ls_DeleteSQL) RETURNING lb_success

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZED_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZED_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZED_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF  

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZED_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  ls_user         VARCHAR(100),
  ldt_datetime    DATETIME YEAR TO SECOND,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  &ifndef DEBUG
  LET ls_user = g_user
  &else
  LET ls_user = FGL_GETENV("USERNUMBER")
  &endif
  LET ldt_datetime = CURRENT YEAR TO SECOND
  
  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           "'",lo_DATAS[li_loop,3],"',",
                           "'",lo_DATAS[li_loop,4],"',",
                           "'",lo_DATAS[li_loop,5],"',",
                           "'",lo_DATAS[li_loop,6],"',",
                           "'",lo_DATAS[li_loop,7],"',",
                           "'",lo_DATAS[li_loop,8],"',",
                           "'",lo_DATAS[li_loop,9],"',",
                           "'",lo_DATAS[li_loop,10],"',",
                           "'",ls_user,"',",
                           "systimestamp,",
                           "'",ls_user,"',",
                           "systimestamp"
                           
                                                    
      LET ls_InsertSQL = "INSERT INTO DZED_T (                                         ",
                         "                    DZED001,DZED002,DZED003,DZED004,DZED005, ",
                         "                    DZED006,DZED007,DZED008,DZED009,DZED010, ",
                         "                    DZEDCRTID,DZEDCRTDT,DZEDMODID,DZEDMODDT  ",
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "
                         
      #DZED008,DZED009 為客制標示, 不更新                   
      LET ls_UpdateValue = "DZED003 = '",lo_DATAS[li_loop,3],"',      ",
                           "DZED004 = '",lo_DATAS[li_loop,4],"',      ",
                           "DZED005 = TRIM('",lo_DATAS[li_loop,5],"'),",
                           "DZED006 = TRIM('",lo_DATAS[li_loop,6],"'),",
                           "DZED007 = TRIM('",lo_DATAS[li_loop,7],"'),",
                           #"DZED008 = TRIM('",lo_DATAS[li_loop,8],"'),",
                           #"DZED009 = TRIM('",lo_DATAS[li_loop,9],"'),",
                           "DZED010 = TRIM('",lo_DATAS[li_loop,10],"'),",
                           "DZEDMODID = TRIM('",ls_user,"'),",
                           "DZEDMODDT = systimestamp"
                                                    
      LET ls_UpdateSQL = "UPDATE DZED_T SET ",
                         ls_UpdateValue,
                         " WHERE DZED001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND DZED002 = '",lo_DATAS[li_loop,2],"'"
                         --"   AND NVL(DZED008,'",cs_dgenv_standard,"') = '",cs_dgenv_standard,"'"
                         
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
    END IF    
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZEF_T #####################################################################

FUNCTION sadzp310_exim_export_DZEF_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEF_T"
  
  CALL sadzp310_exim_get_DZEF_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZEF_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj   util.JSONObject
DEFINE
  ls_TableName  STRING,
  lo_DZEF_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_DZEF_T = ""
  LET lo_RETURN = ""
  
  LET ls_SQL = "SELECT EF.DZEF001,EF.DZEF002,EF.DZEF003,EF.DZEF004,EF.DZEF005,",
               "       EF.DZEF006,EF.DZEF007,EF.DZEF008,EF.DZEF009,EF.DZEF010 ",
               "  FROM DZEF_T EF                                              ",
               " WHERE EF.DZEF001 = '",ls_TableName,"'                        "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZEF_T' TABLE_NAME,COUNT(1) RECORDS ",
                   "  FROM DZEF_T EF                            ",
                   " WHERE EF.DZEF001 = '",ls_TableName,"'      "
                 
  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetDZEFData FROM ls_SQL
  DECLARE lcur_GetDZEFData CURSOR FOR lpre_GetDZEFData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZEFData
  FOREACH lcur_GetDZEFData INTO lo_DZEF_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZEFData
  CALL lo_DZEF_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZEFData
  FREE lcur_GetDZEFData  

  LET lo_RETURN.* = lo_DZEF_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZEF_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEF_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZEF_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF  

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZEF_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           "'",lo_DATAS[li_loop,3],"',",
                           "",NVL(lo_DATAS[li_loop,4],"NULL"),",",
                           "'",lo_DATAS[li_loop,5],"',",
                           "'",lo_DATAS[li_loop,6],"',",
                           "'",lo_DATAS[li_loop,7],"',",
                           "'",lo_DATAS[li_loop,8],"',",
                           "'",lo_DATAS[li_loop,9],"',",
                           "",NVL(lo_DATAS[li_loop,10],"NULL"),""
                                                    
      LET ls_InsertSQL = "INSERT INTO DZEF_T (                                         ",
                         "                    DZEF001,DZEF002,DZEF003,DZEF004,DZEF005, ",
                         "                    DZEF006,DZEF007,DZEF008,DZEF009,DZEF010  ",
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "
                         
      LET ls_UpdateValue = "DZEF003 = '",lo_DATAS[li_loop,3],"',",
                           "DZEF004 = ",NVL(lo_DATAS[li_loop,4],"NULL"),",",
                           "DZEF005 = '",lo_DATAS[li_loop,5],"',",
                           "DZEF006 = '",lo_DATAS[li_loop,6],"',",
                           "DZEF007 = '",lo_DATAS[li_loop,7],"',",
                           "DZEF008 = '",lo_DATAS[li_loop,8],"',",
                           "DZEF009 = '",lo_DATAS[li_loop,9],"',",
                           "DZEF010 = ",NVL(lo_DATAS[li_loop,10],"NULL"),""
                                                    
      LET ls_UpdateSQL = "UPDATE DZEF_T SET ",
                         ls_UpdateValue,
                         " WHERE DZEF001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND DZEF002 = '",lo_DATAS[li_loop,2],"'"
                           
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
    END IF    
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZEP_T #####################################################################

FUNCTION sadzp310_exim_export_DZEP_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEP_T"
  
  CALL sadzp310_exim_get_DZEP_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZEP_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj   util.JSONObject
DEFINE
  ls_TableName  STRING,
  lo_DZEP_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_DZEP_T = ""
  LET lo_RETURN = ""
  
  LET ls_SQL = "SELECT EP.DZEP001,EP.DZEP002,EP.DZEP003,EP.DZEP004,EP.DZEP005,",
               "       EP.DZEP006,EP.DZEP007,EP.DZEP008,EP.DZEP009,EP.DZEP010,",
               "       EP.DZEP011,EP.DZEP012,EP.DZEP013,EP.DZEP014,EP.DZEP015,",
               "       EP.DZEP016,EP.DZEP017,EP.DZEP018,EP.DZEP019,EP.DZEP020,",
               "       EP.DZEP021,EP.DZEP022,EP.DZEP023,EP.DZEP024,EP.DZEP025,",
               "       EP.DZEP026,EP.DZEP027,EP.DZEP028                       ",
               "  FROM DZEP_T EP                                              ",
               " WHERE EP.DZEP001 = '",ls_TableName,"'                        "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZEP_T' TABLE_NAME,COUNT(1) RECORDS ",
                   "  FROM DZEP_T EP                            ",
                   " WHERE EP.DZEP001 = '",ls_TableName,"'      "
                 
  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetDZEPData FROM ls_SQL
  DECLARE lcur_GetDZEPData CURSOR FOR lpre_GetDZEPData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZEPData
  FOREACH lcur_GetDZEPData INTO lo_DZEP_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZEPData
  CALL lo_DZEP_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZEPData
  FREE lcur_GetDZEPData  

  LET lo_RETURN.* = lo_DZEP_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZEP_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEP_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZEP_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF  

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZEP_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           "'",lo_DATAS[li_loop,3],"',",
                           "'",lo_DATAS[li_loop,4],"',",
                           "'",lo_DATAS[li_loop,5],"',",
                           "'",lo_DATAS[li_loop,6],"',",
                           "'",lo_DATAS[li_loop,7],"',",
                           "'",lo_DATAS[li_loop,8],"',",
                           "'",lo_DATAS[li_loop,9],"',",
                           "'",lo_DATAS[li_loop,10],"',",
                           "'",lo_DATAS[li_loop,11],"',",
                           "'",lo_DATAS[li_loop,12],"',",
                           "",NVL(lo_DATAS[li_loop,13],"NULL"),",",
                           "",NVL(lo_DATAS[li_loop,14],"NULL"),",",
                           "'",lo_DATAS[li_loop,15],"',",
                           "'",lo_DATAS[li_loop,16],"',",
                           "'",lo_DATAS[li_loop,17],"',",
                           "'",lo_DATAS[li_loop,18],"',",
                           "'",lo_DATAS[li_loop,19],"',",
                           "'",lo_DATAS[li_loop,20],"',",
                           "'",lo_DATAS[li_loop,21],"',",
                           "'",lo_DATAS[li_loop,22],"',",
                           "'",lo_DATAS[li_loop,23],"',",
                           "'",lo_DATAS[li_loop,24],"',",
                           "'",lo_DATAS[li_loop,25],"',",
                           "'",lo_DATAS[li_loop,26],"',",
                           "",NVL(lo_DATAS[li_loop,27],"NULL"),",",
                           "'",lo_DATAS[li_loop,28],"'"
                                                    
      LET ls_InsertSQL = "INSERT INTO DZEP_T (                                         ",
                         "                    DZEP001,DZEP002,DZEP003,DZEP004,DZEP005, ",
                         "                    DZEP006,DZEP007,DZEP008,DZEP009,DZEP010, ",
                         "                    DZEP011,DZEP012,DZEP013,DZEP014,DZEP015, ",
                         "                    DZEP016,DZEP017,DZEP018,DZEP019,DZEP020, ",
                         "                    DZEP021,DZEP022,DZEP023,DZEP024,DZEP025, ",
                         "                    DZEP026,DZEP027,DZEP028                  ",
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "
                         
      LET ls_UpdateValue = "DZEP003 = '",lo_DATAS[li_loop,3],"',",
                           "DZEP004 = '",lo_DATAS[li_loop,4],"',",
                           "DZEP005 = '",lo_DATAS[li_loop,5],"',",
                           "DZEP006 = '",lo_DATAS[li_loop,6],"',",
                           "DZEP007 = '",lo_DATAS[li_loop,7],"',",
                           "DZEP008 = '",lo_DATAS[li_loop,8],"',",
                           "DZEP009 = '",lo_DATAS[li_loop,9],"',",
                           "DZEP010 = '",lo_DATAS[li_loop,10],"',",
                           "DZEP011 = '",lo_DATAS[li_loop,11],"',",
                           "DZEP012 = '",lo_DATAS[li_loop,12],"',",
                           "DZEP013 = ",NVL(lo_DATAS[li_loop,13],"NULL"),",",
                           "DZEP014 = ",NVL(lo_DATAS[li_loop,14],"NULL"),",",
                           "DZEP015 = '",lo_DATAS[li_loop,15],"',",
                           "DZEP016 = '",lo_DATAS[li_loop,16],"',",
                           "DZEP017 = '",lo_DATAS[li_loop,17],"',",
                           "DZEP018 = '",lo_DATAS[li_loop,18],"',",
                           "DZEP019 = '",lo_DATAS[li_loop,19],"',",
                           "DZEP020 = '",lo_DATAS[li_loop,20],"',",
                           "DZEP021 = '",lo_DATAS[li_loop,21],"',",
                           "DZEP022 = '",lo_DATAS[li_loop,22],"',",
                           "DZEP023 = '",lo_DATAS[li_loop,23],"',",
                           "DZEP024 = '",lo_DATAS[li_loop,24],"',",
                           "DZEP025 = '",lo_DATAS[li_loop,25],"',",
                           "DZEP026 = '",lo_DATAS[li_loop,26],"',",
                           "DZEP027 = ",NVL(lo_DATAS[li_loop,27],"NULL"),",",
                           "DZEP028 = '",lo_DATAS[li_loop,28],"'"
                                                    
      LET ls_UpdateSQL = "UPDATE DZEP_T SET ",
                         ls_UpdateValue,
                         " WHERE DZEP001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND DZEP002 = '",lo_DATAS[li_loop,2],"'"
                           
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      LET lb_success = TRUE
      {
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
      }
    END IF    
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZEQ_T #####################################################################

FUNCTION sadzp310_exim_export_DZEQ_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEQ_T"
  
  CALL sadzp310_exim_get_DZEQ_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZEQ_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj   util.JSONObject
DEFINE
  ls_TableName  STRING,
  lo_DZEQ_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_DZEQ_T = ""
  LET lo_RETURN = ""
  
  LET ls_SQL = "SELECT EQ.DZEQ001,EQ.DZEQ002,EQ.DZEQ003,EQ.DZEQ004,EQ.DZEQ005,",
               "       EQ.DZEQ006,EQ.DZEQ007,EQ.DZEQ008,EQ.DZEQ009            ",
               "  FROM DZEQ_T EQ                                              ",
               " WHERE EQ.DZEQ001 = '",ls_TableName,"'                        "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZEQ_T' TABLE_NAME,COUNT(1) RECORDS ",
                   "  FROM DZEQ_T EQ                            ",
                   " WHERE EQ.DZEQ001 = '",ls_TableName,"'      "
                 
  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetDZEQData FROM ls_SQL
  DECLARE lcur_GetDZEQData CURSOR FOR lpre_GetDZEQData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZEQData
  FOREACH lcur_GetDZEQData INTO lo_DZEQ_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZEQData
  CALL lo_DZEQ_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZEQData
  FREE lcur_GetDZEQData  

  LET lo_RETURN.* = lo_DZEQ_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZEQ_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEQ_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZEQ_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF  

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZEQ_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,6] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           "'",lo_DATAS[li_loop,3],"',",
                           "'",lo_DATAS[li_loop,4],"',",
                           "'",lo_DATAS[li_loop,5],"',",
                           "",NVL(lo_DATAS[li_loop,6],"NULL"),",",
                           "'",lo_DATAS[li_loop,7],"',",
                           "'",lo_DATAS[li_loop,8],"',",
                           "'",lo_DATAS[li_loop,9],"'"
                                                    
      LET ls_InsertSQL = "INSERT INTO DZEQ_T (                                         ",
                         "                    DZEQ001,DZEQ002,DZEQ003,DZEQ004,DZEQ005, ",
                         "                    DZEQ006,DZEQ007,DZEQ008,DZEQ009          ",
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "
                         
      LET ls_UpdateValue = "DZEQ002 = '",lo_DATAS[li_loop,2],"',",
                           "DZEQ003 = '",lo_DATAS[li_loop,3],"',",
                           "DZEQ004 = '",lo_DATAS[li_loop,4],"',",
                           "DZEQ005 = '",lo_DATAS[li_loop,5],"',",
                           "DZEQ007 = '",lo_DATAS[li_loop,7],"',",
                           "DZEQ008 = '",lo_DATAS[li_loop,8],"',",
                           "DZEQ009 = '",lo_DATAS[li_loop,9],"'"
                                                    
      LET ls_UpdateSQL = "UPDATE DZEQ_T SET ",
                         ls_UpdateValue,
                         " WHERE DZEQ001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND DZEQ006 = ",NVL(lo_DATAS[li_loop,6],"NULL"),""

      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      LET lb_success = TRUE
      {
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
      }
    END IF                         
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZER_T #####################################################################

FUNCTION sadzp310_exim_export_DZER_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZER_T"
  
  CALL sadzp310_exim_get_DZER_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZER_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj   util.JSONObject
DEFINE
  ls_TableName  STRING,
  lo_DZER_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_DZER_T = ""
  LET lo_RETURN = ""
  
  LET ls_SQL = "SELECT ER.DZER001,ER.DZER002,ER.DZER003,ER.DZER004,ER.DZER005,",
               "       ER.DZER006,ER.DZER007,ER.DZER008                       ",
               "  FROM DZER_T ER                                              ",
               " WHERE ER.DZER001 = '",ls_TableName,"'                        "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZER_T' TABLE_NAME,COUNT(1) RECORDS ",
                   "  FROM DZER_T ER                            ",
                   " WHERE ER.DZER001 = '",ls_TableName,"'      "
                 
  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetDZERData FROM ls_SQL
  DECLARE lcur_GetDZERData CURSOR FOR lpre_GetDZERData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZERData
  FOREACH lcur_GetDZERData INTO lo_DZER_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZERData
  CALL lo_DZER_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZERData
  FREE lcur_GetDZERData  

  LET lo_RETURN.* = lo_DZER_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZER_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZER_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZER_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF   

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZER_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL 
       AND lo_DATAS[li_loop,3] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           "",NVL(lo_DATAS[li_loop,3],"NULL"),",",
                           "'",lo_DATAS[li_loop,4],"',",
                           "'",lo_DATAS[li_loop,5],"',",
                           "'",lo_DATAS[li_loop,6],"',",
                           "'",lo_DATAS[li_loop,7],"',",
                           "'",lo_DATAS[li_loop,8],"'"
                                                    
      LET ls_InsertSQL = "INSERT INTO DZER_T (                                         ",
                         "                    DZER001,DZER002,DZER003,DZER004,DZER005, ",
                         "                    DZER006,DZER007,DZER008                  ",
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "
                         
      LET ls_UpdateValue = "DZER004 = '",lo_DATAS[li_loop,4],"',",
                           "DZER005 = '",lo_DATAS[li_loop,5],"',",
                           "DZER006 = '",lo_DATAS[li_loop,6],"',",
                           "DZER007 = '",lo_DATAS[li_loop,7],"',",
                           "DZER008 = '",lo_DATAS[li_loop,8],"'"
                                                    
      LET ls_UpdateSQL = "UPDATE DZER_T SET ",
                         ls_UpdateValue,
                         " WHERE DZER001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND DZER002 = '",lo_DATAS[li_loop,2],"'",
                         "   AND DZER003 = ",NVL(lo_DATAS[li_loop,3],"NULL"),""
                           
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      LET lb_success = TRUE
      {
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
      }
    END IF                         
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZET_T #####################################################################

FUNCTION sadzp310_exim_export_DZET_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZET_T"
  
  CALL sadzp310_exim_get_DZET_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZET_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj   util.JSONObject
DEFINE
  ls_TableName  STRING,
  lo_DZET_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_DZET_T = ""
  LET lo_RETURN = ""
  
  LET ls_SQL = "SELECT ET.DZET001,ET.DZET002,ET.DZET003,ET.DZET004,ET.DZET005,",
               "       ET.DZET006,ET.DZET007                                  ",
               "  FROM DZET_T ET                                              ",
               " WHERE ET.DZET001 = '",ls_TableName,"'                        "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZET_T' TABLE_NAME,COUNT(1) RECORDS ",
                   "  FROM DZET_T ET                            ",
                   " WHERE ET.DZET001 = '",ls_TableName,"'      "
                 
  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetDZETData FROM ls_SQL
  DECLARE lcur_GetDZETData CURSOR FOR lpre_GetDZETData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZETData
  FOREACH lcur_GetDZETData INTO lo_DZET_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZETData
  CALL lo_DZET_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZETData
  FREE lcur_GetDZETData  

  LET lo_RETURN.* = lo_DZET_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZET_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZET_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZET_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF  

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZET_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           "'",lo_DATAS[li_loop,3],"',",
                           "'",lo_DATAS[li_loop,4],"',",
                           "'",lo_DATAS[li_loop,5],"',",
                           "'",lo_DATAS[li_loop,6],"',",
                           "'",lo_DATAS[li_loop,7],"'"
                                                    
      LET ls_InsertSQL = "INSERT INTO DZET_T (                                         ",
                         "                    DZET001,DZET002,DZET003,DZET004,DZET005, ",
                         "                    DZET006,DZET007                          ",
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "
                         
      LET ls_UpdateValue = "DZET003 = '",lo_DATAS[li_loop,3],"',",
                           "DZET004 = '",lo_DATAS[li_loop,4],"',",
                           "DZET005 = '",lo_DATAS[li_loop,5],"',",
                           "DZET006 = '",lo_DATAS[li_loop,6],"',",
                           "DZET007 = '",lo_DATAS[li_loop,7],"'"
                                                    
      LET ls_UpdateSQL = "UPDATE DZET_T SET ",
                         ls_UpdateValue,
                         " WHERE DZET001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND DZET002 = '",lo_DATAS[li_loop,2],"'"
                           
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      LET lb_success = TRUE
      {
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
      }
    END IF    
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZEAL_T #####################################################################

FUNCTION sadzp310_exim_export_DZEAL_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEAL_T"
  
  CALL sadzp310_exim_get_DZEAL_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZEAL_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj   util.JSONObject
DEFINE
  ls_TableName  STRING,
  lo_DZEAL_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_DZEAL_T = ""
  LET lo_RETURN = ""
  
  LET ls_SQL = "SELECT EAL.DZEAL001,EAL.DZEAL002,EAL.DZEAL003,EAL.DZEAL004,EAL.DZEAL005 ",
               "  FROM DZEAL_T EAL                                                      ",
               " WHERE EAL.DZEAL001 = '",ls_TableName,"'                                "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZEAL_T' TABLE_NAME,COUNT(1) RECORDS ",
                   "  FROM DZEAL_T EAL                           ",
                   " WHERE EAL.DZEAL001 = '",ls_TableName,"'     "
                 
  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetDZEALData FROM ls_SQL
  DECLARE lcur_GetDZEALData CURSOR FOR lpre_GetDZEALData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZEALData
  FOREACH lcur_GetDZEALData INTO lo_DZEAL_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZEALData
  CALL lo_DZEAL_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZEALData
  FREE lcur_GetDZEALData  

  LET lo_RETURN.* = lo_DZEAL_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZEAL_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEAL_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZEAL_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF   

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZEAL_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  lb_is_lang      BOOLEAN,
  li_lng          INTEGER,   
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL THEN

      #從清單中取得可匯入的語言別
      LET lb_is_lang = FALSE
      FOR li_lng = 1 TO mo_local_lang.getLength()
        IF lo_DATAS[li_loop,2] = mo_local_lang[li_lng] THEN
          LET lb_is_lang = TRUE
          EXIT FOR
        END IF 
      END FOR 

      #符合當地多語言清單的資料才匯入
      IF lb_is_lang THEN
      
        LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                             "'",NVL(lo_DATAS[li_loop,2],"NULL"),"',",
                             "'",lo_DATAS[li_loop,3],"',",
                             "'",lo_DATAS[li_loop,4],"',",
                             "'",lo_DATAS[li_loop,5],"'"
                                                      
        LET ls_InsertSQL = "INSERT INTO DZEAL_T (                                           ",
                           "                    DZEAL001,DZEAL002,DZEAL003,DZEAL004,DZEAL005",
                           "                   )                                            ",  
                           " VALUES (                                                       ",
                           ls_InsertValue,
                           "        )                                                       "  
                           
        LET ls_UpdateValue = "DZEAL003 = '",lo_DATAS[li_loop,3],"',",
                             "DZEAL004 = '",lo_DATAS[li_loop,4],"',",
                             "DZEAL005 = '",lo_DATAS[li_loop,5],"'"
                                                      
        LET ls_UpdateSQL = "UPDATE DZEAL_T SET ",
                           ls_UpdateValue,
                           " WHERE DZEAL001 = '",lo_DATAS[li_loop,1],"'",
                           "   AND DZEAL002 = '",NVL(lo_DATAS[li_loop,2],"NULL"),"'"

        CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
        IF NOT lb_success THEN
          CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
          IF NOT lb_success THEN
            DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
            DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
            EXIT FOR 
          END IF
        END IF
        
      END IF      
    END IF                       
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZEO_T #####################################################################

FUNCTION sadzp310_exim_export_DZEO_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEO_T"
  
  CALL sadzp310_exim_get_DZEO_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZEO_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj   util.JSONObject
DEFINE
  ls_TableName  STRING,
  lo_DZEO_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_DZEO_T = ""
  LET lo_RETURN = ""
  
  LET ls_SQL = "SELECT EO.DZEO001,EO.DZEO002,EO.DZEO003,EO.DZEO004,EO.DZEO005,",
               "       EO.DZEO006,EO.DZEO007,EO.DZEO008,EO.DZEO009            ",
               "  FROM DZEO_T EO                                              ",
               " WHERE EO.DZEO001 = '",ls_TableName.toUpperCase(),"'          "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZEO_T' TABLE_NAME,COUNT(1) RECORDS          ",
                   "  FROM DZEO_T EO                                     ",
                   " WHERE EO.DZEO001 = '",ls_TableName.toUpperCase(),"' "
                 
  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetDZEOData FROM ls_SQL
  DECLARE lcur_GetDZEOData CURSOR FOR lpre_GetDZEOData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZEOData
  FOREACH lcur_GetDZEOData INTO lo_DZEO_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZEOData
  CALL lo_DZEO_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZEOData
  FREE lcur_GetDZEOData  

  LET lo_RETURN.* = lo_DZEO_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZEO_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEO_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZEO_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF   

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZEO_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "",NVL(lo_DATAS[li_loop,2],"NULL"),",",
                           "",NVL(lo_DATAS[li_loop,3],"NULL"),",",
                           "",NVL(lo_DATAS[li_loop,4],"NULL"),",",
                           "",NVL(lo_DATAS[li_loop,5],"NULL"),",",
                           "'",lo_DATAS[li_loop,6],"',",
                           "'",lo_DATAS[li_loop,7],"',",
                           "'",lo_DATAS[li_loop,8],"',",
                           "'",lo_DATAS[li_loop,9],"'"
                                                    
      LET ls_InsertSQL = "INSERT INTO DZEO_T (                                         ",
                         "                    DZEO001,DZEO002,DZEO003,DZEO004,DZEO005, ",
                         "                    DZEO006,DZEO007,DZEO008,DZEO009          ",
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "
                         
      LET ls_UpdateValue = "DZEO002 = ",NVL(lo_DATAS[li_loop,2],"NULL"),",",
                           "DZEO003 = ",NVL(lo_DATAS[li_loop,3],"NULL"),",",
                           "DZEO004 = ",NVL(lo_DATAS[li_loop,4],"NULL"),",",
                           "DZEO005 = ",NVL(lo_DATAS[li_loop,5],"NULL"),",",
                           "DZEO006 = '",lo_DATAS[li_loop,6],"',",
                           "DZEO007 = '",lo_DATAS[li_loop,7],"',",
                           "DZEO008 = '",lo_DATAS[li_loop,8],"',",
                           "DZEO009 = '",lo_DATAS[li_loop,9],"'"
                                                    
      LET ls_UpdateSQL = "UPDATE DZEO_T SET ",
                         ls_UpdateValue,
                         " WHERE DZEO001 = '",lo_DATAS[li_loop,1],"'"
                         
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      LET lb_success = TRUE
      {
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
      }
    END IF
  END FOR 

  
  RETURN lb_success
  
END FUNCTION

## DZEU_T #####################################################################

FUNCTION sadzp310_exim_export_DZEU_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEU_T"
  
  CALL sadzp310_exim_get_DZEU_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZEU_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj   util.JSONObject
DEFINE
  ls_TableName  STRING,
  lo_DZEU_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_DZEU_T = ""
  LET lo_RETURN = ""
  
  LET ls_SQL = "SELECT EU.DZEU001,EU.DZEU002,EU.DZEU003,EU.DZEU004,EU.DZEU005 ",
               "  FROM DZEU_T EU                                              ",
               " WHERE EU.DZEU001 = '",ls_TableName,"'                        "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZEU_T' TABLE_NAME,COUNT(1) RECORDS  ",
                   "  FROM DZEU_T EU                             ",
                   " WHERE EU.DZEU001 = '",ls_TableName,"'       "
                 
  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetDZEUData FROM ls_SQL
  DECLARE lcur_GetDZEUData CURSOR FOR lpre_GetDZEUData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZEUData
  FOREACH lcur_GetDZEUData INTO lo_DZEU_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZEUData
  CALL lo_DZEU_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZEUData
  FREE lcur_GetDZEUData  

  LET lo_RETURN.* = lo_DZEU_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZEU_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEU_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZEU_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF   

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZEU_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           "'",lo_DATAS[li_loop,3],"',",
                           "'",lo_DATAS[li_loop,4],"',",
                           "",NVL(lo_DATAS[li_loop,5],"NULL"),""
                                                    
      LET ls_InsertSQL = "INSERT INTO DZEU_T (                                         ",
                         "                    DZEU001,DZEU002,DZEU003,DZEU004,DZEU005  ",
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "
                         
      LET ls_UpdateValue = "DZEU003 = '",lo_DATAS[li_loop,3],"',",
                           "DZEU004 = '",lo_DATAS[li_loop,4],"',",
                           "DZEU005 = ",NVL(lo_DATAS[li_loop,5],"NULL"),""
                                                    
      LET ls_UpdateSQL = "UPDATE DZEU_T SET ",
                         ls_UpdateValue,
                         " WHERE DZEU001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND DZEU002 = '",lo_DATAS[li_loop,2],"'"
                           
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
    END IF    
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZEV_T #####################################################################

FUNCTION sadzp310_exim_export_DZEV_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEV_T"
  
  CALL sadzp310_exim_get_DZEV_data(ls_TableName,p_json_obj,lo_PARAMETERS.*) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZEV_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName   STRING,
  lo_REVISION    T_REVISION,
  lo_PARAMETERS  T_DZLM_T_SCR,  
  ls_MaxVersion  STRING,
  lo_DZEV_T      DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  ls_SQL_ALM STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*
  
  LET lo_DZEV_T  = ""
  LET lo_RETURN  = ""
  LET ls_SQL_ALM = ""

  LET ls_SQL = "SELECT EV.DZEV001,EV.DZEV002,EV.DZEV003,EV.DZEV004,EV.DZEV005,",
               "       EV.DZEV006,EV.DZEV007,EV.DZEV008,EV.DZEV009,EV.DZEV010,",
               "       EV.DZEV011,EV.DZEV012,EV.DZEV013,EV.DZEV014,EV.DZEV015,",
               "       EV.DZEV016,EV.DZEV017,EV.DZEV018,EV.DZEV019,EV.DZEV020,",
               "       EV.DZEV021,EV.DZEV022,EV.DZEV023                       ",  
               "  FROM DZEV_T EV                                              ",
               " WHERE EV.DZEV002 = '",ls_TableName.toUpperCase(),"'          ",
               " ORDER BY EV.DZEV011                                          " 

  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZEV_T' TABLE_NAME,COUNT(1) RECORDS          ",
                   "  FROM DZEV_T EV                                     ",
                   " WHERE EV.DZEV002 = '",ls_TableName.toUpperCase(),"' "
                 
  IF lo_parameters.DZLM005 = cs_NoVersionCharacter THEN
    #取得該表格最大的異動版次
    CALL sadzp310_rev_get_revision_data(ls_TableName) RETURNING lo_REVISION.*
    LET ls_SQL_ALM = "   AND EV.DZEV003 = TRIM('",lo_REVISION.rv_SEQUENCE,"')", 
                     "   AND EV.DZEV018 = '",lo_REVISION.rv_ALM_VERSION,"'   ",
                     "   AND EV.DZEV019 = '",lo_REVISION.rv_REQUEST_NO,"'    "

  ELSE                    
    LET ls_SQL_ALM = "   AND EV.DZEV003 = TRIM('",lo_PARAMETERS.DZLM015,"') ", 
                     "   AND EV.DZEV018 = '",lo_PARAMETERS.DZLM005,"' ",
                     "   AND EV.DZEV019 = '",lo_PARAMETERS.DZLM012,"' "
  END IF
  
  
  LET ls_SQL = ls_SQL,ls_SQL_ALM   
  LET ls_tsn_SQL = ls_tsn_SQL,ls_SQL_ALM

  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetDZEVData FROM ls_SQL
  DECLARE lcur_GetDZEVData CURSOR FOR lpre_GetDZEVData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZEVData
  FOREACH lcur_GetDZEVData INTO lo_DZEV_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZEVData
  CALL lo_DZEV_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZEVData
  FREE lcur_GetDZEVData  

  LET lo_RETURN.* = lo_DZEV_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZEV_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEV_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZEV_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF   

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZEV_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL AND
       lo_DATAS[li_loop,3] IS NOT NULL AND lo_DATAS[li_loop,4] IS NOT NULL AND
       lo_DATAS[li_loop,5] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           #"'",IIF(mb_same_zone,ms_max_sequence,lo_DATAS[li_loop,3]),"',", #異動序號
                           "'",ms_max_sequence,"',", #異動序號
                           "'",lo_DATAS[li_loop,4],"',",
                           "'",lo_DATAS[li_loop,5],"',",
                           "'",lo_DATAS[li_loop,6],"',",
                           "'",lo_DATAS[li_loop,7],"',",
                           "'",lo_DATAS[li_loop,8],"',",
                           "'",lo_DATAS[li_loop,9],"',",
                           "'",lo_DATAS[li_loop,10],"',",
                           "",NVL(lo_DATAS[li_loop,11],"NULL"),",",
                           "'",lo_DATAS[li_loop,12],"',",
                           "'",lo_DATAS[li_loop,13],"',",
                           "",NVL(lo_DATAS[li_loop,14],"NULL"),",",
                           "'",lo_DATAS[li_loop,15],"',",
                           "",NVL(lo_DATAS[li_loop,16],"NULL"),",",
                           "'",lo_DATAS[li_loop,17],"',",
                           #"'",lo_DATAS[li_loop,18],"',", #建構版次
                           "'",ms_construct_version,"',",
                           "'",lo_DATAS[li_loop,19],"',",
                           "'",lo_DATAS[li_loop,20],"',",
                           "'",lo_DATAS[li_loop,21],"',",
                           "'",lo_DATAS[li_loop,22],"',",
                           "'",lo_DATAS[li_loop,23],"'"
                                                    
      LET ls_InsertSQL = "INSERT INTO DZEV_T (                                         ",
                         "                    DZEV001,DZEV002,DZEV003,DZEV004,DZEV005, ",
                         "                    DZEV006,DZEV007,DZEV008,DZEV009,DZEV010, ",
                         "                    DZEV011,DZEV012,DZEV013,DZEV014,DZEV015, ",
                         "                    DZEV016,DZEV017,DZEV018,DZEV019,DZEV020, ",
                         "                    DZEV021,DZEV022,DZEV023                  ",
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "
                         
      LET ls_UpdateValue = "DZEV006 = '",lo_DATAS[li_loop,6],"',",
                           "DZEV007 = '",lo_DATAS[li_loop,7],"',",
                           "DZEV008 = '",lo_DATAS[li_loop,8],"',",
                           "DZEV009 = '",lo_DATAS[li_loop,9],"',",
                           "DZEV010 = '",lo_DATAS[li_loop,10],"',",
                           "DZEV011 = ",NVL(lo_DATAS[li_loop,11],"NULL"),",",
                           "DZEV012 = '",lo_DATAS[li_loop,12],"',",
                           "DZEV013 = '",lo_DATAS[li_loop,13],"',",
                           "DZEV014 = ",NVL(lo_DATAS[li_loop,14],"NULL"),",",
                           "DZEV015 = '",lo_DATAS[li_loop,15],"',",
                           "DZEV016 = ",NVL(lo_DATAS[li_loop,16],"NULL"),",",
                           "DZEV017 = '",lo_DATAS[li_loop,17],"',",
                           #"DZEV018 = '",lo_DATAS[li_loop,18],"',", #建構版次
                           "DZEV018 = '",ms_construct_version,"',",
                           "DZEV019 = '",lo_DATAS[li_loop,19],"',",
                           "DZEV020 = '",lo_DATAS[li_loop,20],"',",
                           "DZEV021 = '",lo_DATAS[li_loop,21],"',",
                           "DZEV022 = '",lo_DATAS[li_loop,22],"',",
                           "DZEV023 = '",lo_DATAS[li_loop,23],"'"
                                                    
      LET ls_UpdateSQL = "UPDATE DZEV_T SET ",
                         ls_UpdateValue,
                         " WHERE DZEV001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND DZEV002 = '",lo_DATAS[li_loop,2],"'",
                         #"   AND DZEV003 = '",IIF(mb_same_zone,ms_max_sequence,lo_DATAS[li_loop,3]),"'", #異動序號
                         "   AND DZEV003 = '",ms_max_sequence,"'", #異動序號
                         "   AND DZEV004 = '",lo_DATAS[li_loop,4],"'",
                         "   AND DZEV005 = '",lo_DATAS[li_loop,5],"'"
                           
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
    END IF    
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZEW_T #####################################################################

FUNCTION sadzp310_exim_export_DZEW_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEW_T"
  
  CALL sadzp310_exim_get_DZEW_data(ls_TableName,p_json_obj,lo_PARAMETERS.*) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZEW_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName   STRING,
  p_json_obj    util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName   STRING,
  lo_PARAMETERS  T_DZLM_T_SCR,
  lo_REVISION    T_REVISION,
  ls_MaxVersion  STRING,
  lo_DZEW_T      DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  ls_SQL_ALM STRING,
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET lo_DZEW_T  = ""
  LET lo_RETURN  = ""
  LET ls_SQL_ALM = ""
  
  LET ls_SQL = "SELECT EW.DZEW001,EW.DZEW002,EW.DZEW003,EW.DZEW004,EW.DZEW005,",
               "       EW.DZEW006,EW.DZEW007,EW.DZEW008,EW.DZEW009,EW.DZEW010,",
               "       EW.DZEW011,EW.DZEW012,EW.DZEW013,EW.DZEW014            ",
               "  FROM DZEW_T EW                                              ",
               " WHERE EW.DZEW001 = '",ls_TableName,"'                        "

  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZEW_T' TABLE_NAME,COUNT(1) RECORDS  ",
                   "  FROM DZEW_T EW                             ",
                   " WHERE EW.DZEW001 = '",ls_TableName,"'       "

                   
  IF lo_parameters.DZLM005 = cs_NoVersionCharacter THEN
    #取得該表格最大的異動版次
    CALL sadzp310_rev_get_revision_data(ls_TableName) RETURNING lo_REVISION.*
    LET ls_SQL_ALM = " AND EW.DZEW002 = TRIM('",lo_REVISION.rv_SEQUENCE,"')",
                     " AND EW.DZEW010 = '",lo_REVISION.rv_ALM_VERSION,"'   ",
                     " AND EW.DZEW011 = '",lo_REVISION.rv_REQUEST_NO,"'    "  

  ELSE                    
    LET ls_SQL_ALM = "   AND EW.DZEW002 = TRIM('",lo_PARAMETERS.DZLM015,"')",
                     "   AND EW.DZEW010 = '",lo_PARAMETERS.DZLM005,"'      ",
                     "   AND EW.DZEW011 = '",lo_PARAMETERS.DZLM012,"'      "
  END IF 
  
  LET ls_SQL = ls_SQL,ls_SQL_ALM   
  LET ls_tsn_SQL = ls_tsn_SQL,ls_SQL_ALM   

  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
               
  PREPARE lpre_GetDZEWData FROM ls_SQL
  DECLARE lcur_GetDZEWData CURSOR FOR lpre_GetDZEWData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZEWData
  FOREACH lcur_GetDZEWData INTO lo_DZEW_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZEWData
  CALL lo_DZEW_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZEWData
  FREE lcur_GetDZEWData  

  LET lo_RETURN.* = lo_DZEW_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZEW_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZEW_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZEW_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF   

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZEW_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL AND
       lo_DATAS[li_loop,3] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           #"'",IIF(mb_same_zone,ms_max_sequence,lo_DATAS[li_loop,2]),"',", #異動序號
                           "'",ms_max_sequence,"',", #異動序號
                           "'",lo_DATAS[li_loop,3],"',",
                           "'",lo_DATAS[li_loop,4],"',",
                           "'",lo_DATAS[li_loop,5],"',",
                           "'",lo_DATAS[li_loop,6],"',",
                           "TRIM('",lo_DATAS[li_loop,7],"'),",
                           "TRIM('",lo_DATAS[li_loop,8],"'),",
                           "'",lo_DATAS[li_loop,9],"',",
                           #"'",lo_DATAS[li_loop,10],"',", #建構版次
                           "'",ms_construct_version,"',",
                           "'",lo_DATAS[li_loop,11],"',",
                           "'",lo_DATAS[li_loop,12],"',",
                           "'",lo_DATAS[li_loop,13],"',",
                           "'",lo_DATAS[li_loop,14],"'"
                                                    
      LET ls_InsertSQL = "INSERT INTO DZEW_T (                                         ",
                         "                    DZEW001,DZEW002,DZEW003,DZEW004,DZEW005, ",
                         "                    DZEW006,DZEW007,DZEW008,DZEW009,DZEW010, ",
                         "                    DZEW011,DZEW012,DZEW013,DZEW014          ",
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "
                         
      LET ls_UpdateValue = "DZEW005 = '",lo_DATAS[li_loop,5],"',",
                           "DZEW006 = '",lo_DATAS[li_loop,6],"',",
                           "DZEW007 = '",lo_DATAS[li_loop,7],"',",
                           "DZEW008 = TRIM('",lo_DATAS[li_loop,8],"'),",
                           "DZEW009 = TRIM('",lo_DATAS[li_loop,9],"'),",
                           #"DZEW010 = '",lo_DATAS[li_loop,10],"',", #建構版次
                           "DZEW010 = '",ms_construct_version,"',",
                           "DZEW011 = '",lo_DATAS[li_loop,11],"',",
                           "DZEW012 = '",lo_DATAS[li_loop,12],"',",
                           "DZEW013 = '",lo_DATAS[li_loop,13],"',",
                           "DZEW014 = '",lo_DATAS[li_loop,14],"'"
                                                    
      LET ls_UpdateSQL = "UPDATE DZEW_T SET ",
                         ls_UpdateValue,
                         " WHERE DZEW001 = '",lo_DATAS[li_loop,1],"'",
                         #"   AND DZEW002 = '",IIF(mb_same_zone,ms_max_sequence,lo_DATAS[li_loop,2]),"'", #異動序號
                         "   AND DZEW002 = '",ms_max_sequence,"'", #異動序號
                         "   AND DZEW003 = '",lo_DATAS[li_loop,3],"'",
                         "   AND DZEW004 = '",lo_DATAS[li_loop,4],"'"
                           
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
    END IF    
  END FOR 

  RETURN lb_success
  
END FUNCTION

## DZIG_T #####################################################################

FUNCTION sadzp310_exim_export_DZIG_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZIG_T"
  
  CALL sadzp310_exim_get_DZIG_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_DZIG_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj   util.JSONObject
DEFINE
  ls_TableName  STRING,
  lo_DZIG_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_DZIG_T = ""
  LET lo_RETURN = ""
  
  LET ls_SQL = "SELECT IG.DZIG001,IG.DZIG002,IG.DZIG003 ",
               "  FROM DZIG_T IG                        ",
               " WHERE IG.DZIG001 = '",ls_TableName,"'  "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'DZIG_T' TABLE_NAME,COUNT(1) RECORDS ",
                   "  FROM DZIG_T IG                            ",
                   " WHERE IG.DZIG001 = '",ls_TableName,"'      "
                 
  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetDZIGData FROM ls_SQL
  DECLARE lcur_GetDZIGData CURSOR FOR lpre_GetDZIGData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetDZIGData
  FOREACH lcur_GetDZIGData INTO lo_DZIG_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetDZIGData
  CALL lo_DZIG_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetDZIGData
  FREE lcur_GetDZIGData  

  LET lo_RETURN.* = lo_DZIG_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_DZIG_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "DZIG_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_warning_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_DZIG_T_data(lo_DATAS) RETURNING lb_success
    END IF  
  ELSE  
    #為了相容舊版匯出檔, 開檔不成功一律設為 TRUE
    LET lb_success = TRUE
  END IF  
  
  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_DZIG_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           "'",lo_DATAS[li_loop,3],"' "
                                                    
      LET ls_InsertSQL = "INSERT INTO DZIG_T (                         ",
                         "                    DZIG001,DZIG002,DZIG003  ",
                         "                   )                         ",  
                         " VALUES (                                    ",
                         ls_InsertValue,                              
                         "        )                                    "
                         
      LET ls_UpdateValue = "DZIG003 = '",lo_DATAS[li_loop,3],"'"
                                                    
      LET ls_UpdateSQL = "UPDATE DZIG_T SET ",
                         ls_UpdateValue,
                         " WHERE DZIG001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND DZIG002 = '",lo_DATAS[li_loop,2],"'"
                           
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
    END IF    
  END FOR 

  RETURN lb_success
  
END FUNCTION

################################################################################

FUNCTION sadzp310_exim_get_data_from_file(p_FileName,p_fault_type)
DEFINE
  p_FileName   STRING,
  p_fault_type STRING
DEFINE
  ls_FileName   STRING,
  ls_fault_type STRING,
  lo_DATAS      DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE  
  lo_channel_read  base.Channel,
  ls_Text          STRING,
  ls_TextLine      VARCHAR(1024),
  li_RecCnt        INTEGER,
  li_TokenCnt      INTEGER,
  ls_TokenStr      STRING,
  lb_success       BOOLEAN,
  lo_RETURN        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  lo_token         base.StringTokenizer

  LET ls_FileName   = p_FileName
  LET ls_fault_type = p_fault_type

  LET lo_RETURN = NULL
  LET lb_success = TRUE

  LET lo_channel_read = base.Channel.create()
  TRY 
    CALL lo_channel_read.openFile(ls_FileName,"r")
  CATCH
    LET lb_success = FALSE
    DISPLAY ls_fault_type,"Open file ",ls_FileName," fault !!"
  END TRY  

  IF lb_success THEN
    LET li_RecCnt = 1 
    WHILE TRUE
      IF lo_channel_read.isEof() THEN 
        EXIT WHILE
      END IF

      LET ls_Text = lo_channel_read.readLine()
      LET ls_TextLine = ls_Text.Trim()
      IF NVL(ls_TextLine,cs_null_value) <> cs_null_value THEN
        LET lo_token = base.StringTokenizer.createExt(ls_TextLine,"|","",TRUE)

        LET li_TokenCnt = 0
        WHILE lo_token.hasMoreTokens()

          LET li_TokenCnt = li_TokenCnt + 1
          LET ls_TokenStr = lo_token.nextToken()
          LET lo_DATAS[li_RecCnt,li_TokenCnt] = ls_TokenStr CLIPPED

        END WHILE
        
        LET li_RecCnt = li_RecCnt + 1
      END IF   
        
    END WHILE
  END IF
  
  CALL lo_channel_read.close()

  LET lo_RETURN.* = lo_DATAS.* 
  
  RETURN lo_RETURN,lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_export_data(p_DATA_LINE)
DEFINE
  p_DATA_LINE DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  lo_line_string_buf  base.StringBuffer
DEFINE 
  li_loop   INTEGER,
  ls_Text   STRING,
  ls_Return STRING  

  LET lo_DATA_LINE.* = p_DATA_LINE.*
  LET ls_Text = ""

  LET lo_line_string_buf = base.StringBuffer.create()
  CALL lo_line_string_buf.clear()

  FOR li_loop = 1 TO lo_DATA_LINE.getLength()
    LET ls_Text = ""

    LET ls_Text = sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA001) CLIPPED,"|",
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA002) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA003) CLIPPED,"|",   
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA004) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA005) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA006) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA007) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA008) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA009) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA010) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA011) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA012) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA013) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA014) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA015) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA016) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA017) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA018) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA019) CLIPPED,"|",    
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA020) CLIPPED,"|",
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA021) CLIPPED,"|",
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA022) CLIPPED,"|",
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA023) CLIPPED,"|",
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA024) CLIPPED,"|",
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA025) CLIPPED,"|",
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA026) CLIPPED,"|",
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA027) CLIPPED,"|",
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA028) CLIPPED,"|",
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA029) CLIPPED,"|",
                  sadzp310_exim_replace_escape_character(lo_DATA_LINE[li_loop].DATA030) CLIPPED,"|",
                  "\n"
                  
    CALL lo_line_string_buf.append(ls_Text)
    
  END FOR

  LET ls_Return = lo_line_string_buf.toString()
  CALL lo_line_string_buf.clear()
  
  RETURN ls_Return
  
END FUNCTION

#移除或標示特殊字元
FUNCTION sadzp310_exim_replace_escape_character(p_value)
DEFINE
  p_value STRING
DEFINE
  lo_str_buf base.StringBuffer
DEFINE
  ls_return STRING  

  LET lo_str_buf = base.StringBuffer.create()
  CALL lo_str_buf.Clear()

  CALL lo_str_buf.append(p_value)

  #有單引號的匯出時再加上一層, 主要在匯入時使用
  CALL lo_str_buf.replace("'","''",0)
  #移除換行符號
  CALL lo_str_buf.replace("\n","",0)

  CALL lo_str_buf.toString() RETURNING ls_return  

  RETURN ls_return
  
END FUNCTION 

FUNCTION sadzp310_exim_write_file(p_FileName,p_LineString)
DEFINE
  p_FileName   STRING,
  p_LineString STRING
DEFINE   
  ls_file_name      STRING,
  ls_LineString     STRING,
  lo_channel_write  base.Channel,
  lb_success        BOOLEAN

  LET ls_file_name  = p_FileName
  LET ls_LineString = p_LineString

  LET lb_success = TRUE
  
  LET  lo_channel_write = base.Channel.create()
  CALL lo_channel_write.setDelimiter("")

  TRY
    CALL lo_channel_write.openFile(ls_file_name, "w" )
    CALL lo_channel_write.write(ls_LineString)
    CALL lo_channel_write.close()
  CATCH
    LET lb_success = FALSE
  END TRY  

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_exec_SQL(p_SQL)
DEFINE
  p_SQL STRING
DEFINE
  ls_SQL     STRING,
  lb_Success BOOLEAN

  LET ls_SQL = p_SQL
  LET lb_Success = TRUE

  #BEGIN WORK

  TRY
    PREPARE lpre_ExecSQL FROM ls_SQL
    EXECUTE lpre_ExecSQL
    #COMMIT WORK
    LET lb_Success = TRUE
  CATCH
    #DISPLAY "[ERROR] "||ls_SQL
    #ROLLBACK WORK
    LET lb_Success = FALSE
  END TRY  

  RETURN lb_Success
  
END FUNCTION

FUNCTION sadzp310_exim_show_help()

  DISPLAY "\n",
          "Usage : fglrun ",ui.Interface.getName()," [iexp/iimp/iasm/idel/idrp/ialt/ireb] [Table Name] [Construct Version] [SD Version] [Request NO.]","\n",
          "\n",
          "Ex. ","\n",
          "    -- Export/Import version 2","\n",
          "    fglrun ",ui.Interface.getName()," iexp test_t 2 0","\n",
          "    fglrun ",ui.Interface.getName()," iimp test_t 2 0","\n",
          "    -- Export/Import r.t data only","\n",
          "    fglrun ",ui.Interface.getName()," iexp test_t T 0","\n",
          "    fglrun ",ui.Interface.getName()," iimp test_t T 0","\n",
          "    -- Create or modify table","\n",
          "    fglrun ",ui.Interface.getName()," iasm test_t 1 0","\n",
          "    -- Delete current r.t data and corresponding snapshot and restore to version 1","\n",
          "    fglrun ",ui.Interface.getName()," idel test_t 1 0","\n",
          "    -- Drop table and related datas","\n",
          "    fglrun ",ui.Interface.getName()," idrp test_t","\n",
          "    -- Alter table and columns","\n",
          "    fglrun ",ui.Interface.getName()," ialt test_t 2 3","\n",
          "    -- Rebuild table","\n",
          "    fglrun ",ui.Interface.getName()," ireb test_t 2 1","\n"
          
  LET mb_fault = TRUE

END FUNCTION

FUNCTION sadzp310_exim_create_table(p_TableName,p_alm_version,p_alm_request_no,p_dgenv)
DEFINE
  p_TableName      STRING,
  p_alm_version    STRING,
  p_alm_request_no STRING,
  p_dgenv          STRING 
DEFINE
  ls_TableName      STRING,
  ls_alm_version    STRING, 
  ls_alm_request_no STRING,
  ls_dgenv          STRING 
DEFINE
  ls_MasterDB    STRING,
  ls_MasterUser  STRING,
  ls_all_message STRING,
  ls_version     STRING,
  ls_message     STRING,
  lb_error       BOOLEAN,
  lb_diff        BOOLEAN,
  lo_CreateTable T_DZEA_CREATE_TABLE
  #lo_SchemaType  DYNAMIC ARRAY OF T_TABLE_SYNONYM
DEFINE 
  lb_return BOOLEAN
  
  LET ls_TableName      = p_TableName
  LET ls_alm_version    = p_alm_version
  LET ls_alm_request_no = p_alm_request_no
  LET ls_dgenv          = p_dgenv

  LET ls_MasterDB    = ms_MasterDB
  LET ls_MasterUser  = ms_MasterUser
  
  ## 建立表格 ####################################################################
  CALL sadzp310_db_get_create_table_info(ls_TableName) RETURNING lo_CreateTable.*
  #CALL sadzp310_db_get_main_table_synonym_data(ls_TableName) RETURNING lo_SchemaType  
  LET lo_CreateTable.dct_master_db   = NVL(ls_MasterDB,cs_master_db)
  LET lo_CreateTable.dct_master_user = NVL(ls_MasterUser,cs_master_user)
  CALL sadzp310_util_create_real_table(ls_MasterUser,lo_CreateTable.*,ls_version,ls_alm_version,ls_alm_request_no,ls_dgenv,FALSE) RETURNING ls_all_message
  CALL sadzp310_util_make_alter_table(ls_MasterUser,ls_TableName,TRUE) RETURNING lb_error,ls_message
  ##############################################################################

  LET lb_return = NOT lb_error
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp310_exim_modify_table(p_TableName,p_ALMVersion)
DEFINE
  p_TableName  STRING,
  p_ALMVersion STRING 
DEFINE
  ls_TableName   STRING,
  ls_ALMVersion  STRING, 
  ls_MasterDB    STRING,
  ls_MasterUser  STRING,
  ls_all_message STRING,
  ls_version     STRING,
  ls_message     STRING,
  lb_diff        BOOLEAN,
  lb_success     BOOLEAN,
  lb_fault       BOOLEAN,
  lo_CreateTable T_DZEA_CREATE_TABLE
  #lo_SchemaType  DYNAMIC ARRAY OF T_TABLE_SYNONYM

  LET ls_TableName  = p_TableName
  LET ls_ALMVersion = p_ALMVersion

  LET ls_MasterDB    = ms_MasterDB
  LET ls_MasterUser  = ms_MasterUser
  
  ## 建立表格 ####################################################################
  CALL sadzp310_db_get_create_table_info(ls_TableName) RETURNING lo_CreateTable.*
  #CALL sadzp310_db_get_main_table_synonym_data(ls_TableName) RETURNING lo_SchemaType  
  LET lo_CreateTable.dct_master_db   = NVL(ls_MasterDB,cs_master_db)
  LET lo_CreateTable.dct_master_user = NVL(ls_MasterUser,cs_master_user)
  CALL sadzp310_util_make_alter_table(ls_MasterUser,ls_TableName,TRUE) RETURNING lb_fault,ls_message
  ##############################################################################

  LET lb_success = NOT lb_fault
  
  RETURN lb_success
  
END FUNCTION

#TAR資料
FUNCTION sadzp310_exim_tar_file(po_PARAMETERS)
DEFINE
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  lo_PARAMETERS    T_DZLM_T_SCR,  
  ls_TARName       STRING,
  ls_TARString     STRING,
  ls_os_separator  STRING,
  lb_Copyfile      BOOLEAN

  LET lo_PARAMETERS.* = po_PARAMETERS.*

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator 
  LET lb_Copyfile = TRUE
  
  LET ls_TARName = lo_PARAMETERS.DZLM002,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING cs_UsingFormat),".tdi"
                    
  LET ls_TARString = "tar cvf ",ls_TARName," *.unl *.txn"
  RUN ls_TARString    

  LET mo_export_info.TAR_NAME = ls_TARName
  
  #若為lmtb模式, 才搬移匯出檔到工作目錄
  IF mb_backend_mode THEN 
    CALL os.Path.copy(ls_TARName,ms_entry_path||ls_os_separator||ls_TARName) RETURNING lb_Copyfile
  END IF 

  RETURN lb_Copyfile 
  
END FUNCTION

#UNTAR資料
FUNCTION sadzp310_exim_untar_file(po_PARAMETERS)
DEFINE
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  lo_PARAMETERS    T_DZLM_T_SCR,  
  ls_TARName       STRING,
  ls_TARString     STRING,
  lb_Copyfile      BOOLEAN,
  ls_os_separator  STRING,
  lb_success       BOOLEAN,
  li_run_result    INTEGER

  LET lo_PARAMETERS.* = po_PARAMETERS.*

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator 
  LET lb_Copyfile = TRUE
  LET lb_success = TRUE
  
  #UNTAR資料
  LET ls_TARName = lo_PARAMETERS.DZLM002,"+TABLE+",
                   lo_PARAMETERS.DZLM012,"+",
                   (lo_PARAMETERS.DZLM015 USING cs_UsingFormat),".tdi"
                   
  #若為lmtb模式, 才搬移匯入檔到工作目錄
  IF mb_backend_mode THEN 
    CALL os.Path.copy(ms_entry_path||ls_os_separator||ls_TARName,ls_TARName) RETURNING lb_success
  END IF   
  IF NOT lb_success THEN GOTO _error END IF 
  
  LET ls_TARString = "tar xvf ",ls_TARName
  RUN ls_TARString RETURNING li_run_result
  LET lb_success = IIF(li_run_result==0,TRUE,FALSE)
  IF NOT lb_success THEN GOTO _error END IF 
  
  LABEL _error:
  
  RETURN lb_success 
  
END FUNCTION

## GZTD_T ######################################################################

FUNCTION sadzp310_exim_export_GZTD_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "GZTD_T"
  
  CALL sadzp310_exim_get_GZTD_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_GZTD_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj   util.JSONObject
DEFINE
  ls_TableName  STRING,
  lo_GZTD_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_GZTD_T = ""
  LET lo_RETURN = ""

  #尚未匯出共用欄位, 因未來會再作修改
  LET ls_SQL = "SELECT TD.GZTD001,TD.GZTD002,TD.GZTD003,TD.GZTD004,TD.GZTD005,",
               "       TD.GZTD006,TD.GZTD007,TD.GZTD008,TD.GZTD009,TD.GZTD010,",
               "       TD.GZTD011,TD.GZTD012,TD.GZTD013                       ", 
               "  FROM GZTD_T TD                                              ",
               " WHERE 1=1                                                    "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'GZTD_T' TABLE_NAME,COUNT(1) RECORDS  ",
                   "  FROM GZTD_T TD                             ",
                   " WHERE 1=1                                   "
                 
  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetGZTDData FROM ls_SQL
  DECLARE lcur_GetGZTDData CURSOR FOR lpre_GetGZTDData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetGZTDData
  FOREACH lcur_GetGZTDData INTO lo_GZTD_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetGZTDData
  CALL lo_GZTD_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetGZTDData
  FREE lcur_GetGZTDData  

  LET lo_RETURN.* = lo_GZTD_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_GZTD_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "GZTD_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_GZTD_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF
  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_GZTD_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           "'",lo_DATAS[li_loop,3],"',",
                           "'",lo_DATAS[li_loop,4],"',",
                           "'",lo_DATAS[li_loop,5],"',",
                           "'",lo_DATAS[li_loop,6],"',",
                           "'",lo_DATAS[li_loop,7],"',",
                           "'",lo_DATAS[li_loop,8],"',",
                           "'",lo_DATAS[li_loop,9],"',",
                           "",NVL(lo_DATAS[li_loop,10],"NULL"),",",
                           "",NVL(lo_DATAS[li_loop,11],"NULL"),",",
                           "'",lo_DATAS[li_loop,12],"',",
                           "'",lo_DATAS[li_loop,13],"'"
                           
      LET ls_InsertSQL = "INSERT INTO GZTD_T (                                         ",
                         "                    GZTD001,GZTD002,GZTD003,GZTD004,GZTD005, ",
                         "                    GZTD006,GZTD007,GZTD008,GZTD009,GZTD010, ",
                         "                    GZTD011,GZTD012,GZTD013                  ", 
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "
                         
      LET ls_UpdateValue = "GZTD002 = '",lo_DATAS[li_loop,2],"',",
                           "GZTD003 = '",lo_DATAS[li_loop,3],"',",
                           "GZTD004 = '",lo_DATAS[li_loop,4],"',",
                           "GZTD005 = '",lo_DATAS[li_loop,5],"',",
                           "GZTD006 = '",lo_DATAS[li_loop,6],"',",
                           "GZTD007 = '",lo_DATAS[li_loop,7],"',",
                           "GZTD008 = '",lo_DATAS[li_loop,8],"',",
                           "GZTD009 = '",lo_DATAS[li_loop,9],"',",
                           "GZTD010 = ",NVL(lo_DATAS[li_loop,10],"NULL"),",",
                           "GZTD011 = ",NVL(lo_DATAS[li_loop,11],"NULL"),",",
                           "GZTD012 = '",lo_DATAS[li_loop,12],"',",
                           "GZTD013 = '",lo_DATAS[li_loop,13],"'"
                           
      LET ls_UpdateSQL = "UPDATE GZTD_T SET ",
                         ls_UpdateValue,
                         " WHERE GZTD001 = '",lo_DATAS[li_loop,1],"'"
                         
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      
      IF NOT lb_success THEN
        LET lb_success = TRUE
        #gztd_t的update暫時不做 
        #CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
      
    END IF
  END FOR 

  RETURN lb_success
  
END FUNCTION

## GZTDL_T ######################################################################

FUNCTION sadzp310_exim_export_GZTDL_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "GZTDL_T"
  
  CALL sadzp310_exim_get_GZTDL_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_GZTDL_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj   util.JSONObject
DEFINE
  ls_TableName  STRING,
  lo_GZTDL_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_GZTDL_T = ""
  LET lo_RETURN = ""

  #尚未匯出共用欄位, 因未來會再作修改
  LET ls_SQL = "SELECT TDL.GZTDL001,TDL.GZTDL002,TDL.GZTDL003,TDL.GZTDL004,TDL.GZTDL005 ",
               "  FROM GZTDL_T TDL                                                      ",
               " WHERE 1=1                                                              "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'GZTDL_T' TABLE_NAME,COUNT(1) RECORDS ",
                   "  FROM GZTDL_T TD                            ",
                   " WHERE 1=1                                   "
                 
  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetGZTDLData FROM ls_SQL
  DECLARE lcur_GetGZTDLData CURSOR FOR lpre_GetGZTDLData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetGZTDLData
  FOREACH lcur_GetGZTDLData INTO lo_GZTDL_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetGZTDLData
  CALL lo_GZTDL_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetGZTDLData
  FREE lcur_GetGZTDLData  

  LET lo_RETURN.* = lo_GZTDL_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_GZTDL_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "GZTDL_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_GZTDL_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF
  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_GZTDL_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  lb_is_lang      BOOLEAN,
  li_lng          INTEGER, 
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL AND lo_DATAS[li_loop,2] IS NOT NULL THEN
    
      #從清單中取得可匯入的語言別
      LET lb_is_lang = FALSE
      FOR li_lng = 1 TO mo_local_lang.getLength()
        IF lo_DATAS[li_loop,2] = mo_local_lang[li_lng] THEN
          LET lb_is_lang = TRUE
          EXIT FOR
        END IF 
      END FOR 

      #符合當地多語言清單的資料才匯入
      IF lb_is_lang THEN
        LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                             "'",lo_DATAS[li_loop,2],"',",
                             "'",lo_DATAS[li_loop,3],"',",
                             "'",lo_DATAS[li_loop,4],"',",
                             "'",lo_DATAS[li_loop,5],"'"
                             
        LET ls_InsertSQL = "INSERT INTO GZTDL_T (                                              ",
                           "                      GZTDL001,GZTDL002,GZTDL003,GZTDL004,GZTDL005 ",
                           "                    )                                              ",  
                           " VALUES (                                                          ",
                           ls_InsertValue,
                           "        )                                                          "
                           
        LET ls_UpdateValue = "GZTDL003 = '",lo_DATAS[li_loop,3],"',",
                             "GZTDL004 = '",lo_DATAS[li_loop,4],"',",
                             "GZTDL005 = '",lo_DATAS[li_loop,5],"'"
                             
        LET ls_UpdateSQL = "UPDATE GZTDL_T SET ",
                           ls_UpdateValue,
                           " WHERE GZTDL001 = '",lo_DATAS[li_loop,1],"'",
                           "   AND GZTDL002 = '",lo_DATAS[li_loop,2],"'"
                           
        CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
        IF NOT lb_success THEN
          CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
          IF NOT lb_success THEN
            DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
            DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
            EXIT FOR 
          END IF
        END IF
      END IF  
    END IF
  END FOR 

  RETURN lb_success
  
END FUNCTION

## GZCC_T ######################################################################

FUNCTION sadzp310_exim_export_GZCC_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject,
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATA_LINE        DYNAMIC ARRAY OF T_DATA_LINE,
  ls_UsingFormat      STRING,
  ls_DATA_LINE        STRING,
  ls_EXPORT_TABLE     STRING,
  lb_Success          BOOLEAN

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "GZCC_T"
  
  CALL sadzp310_exim_get_GZCC_data(ls_TableName,p_json_obj) RETURNING lo_DATA_LINE
  CALL sadzp310_exim_export_data(lo_DATA_LINE) RETURNING ls_DATA_LINE 
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  CALL sadzp310_exim_write_file(ls_FileName,ls_DATA_LINE) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_get_GZCC_data(p_TableName,p_json_obj)
DEFINE
  p_TableName  STRING,
  p_json_obj   util.JSONObject
DEFINE
  ls_TableName  STRING,
  lo_GZCC_T     DYNAMIC ARRAY OF T_DATA_LINE
DEFINE  
  ls_SQL     STRING,
  ls_tsn_SQL STRING, 
  li_RecCnt  INTEGER,
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  lo_RETURN  DYNAMIC ARRAY OF T_DATA_LINE

  LET ls_TableName = p_TableName

  LET lo_GZCC_T = ""
  LET lo_RETURN = ""

  #尚未匯出共用欄位, 因未來會再作修改
  LET ls_SQL = "SELECT CC.GZCC001,CC.GZCC002,CC.GZCC003,CC.GZCC004,CC.GZCC005,",
               "       CC.GZCC006,CC.GZCCSTUS                                 ",
               "  FROM GZCC_T CC                                              ",
               " WHERE 1=1                                                    ",
               "   AND CC.GZCC001 = '",ls_TableName,"'                        "
               
  #取得Table export notice             
  LET ls_tsn_SQL = "SELECT 'GZCC_T' TABLE_NAME,COUNT(1) RECORDS  ",
                   "  FROM GZCC_T CC                             ",
                   " WHERE 1=1                                   ",
                   "   AND CC.GZCC001 = '",ls_TableName,"'       "
                 
  CALL sadzp310_exim_get_table_ship_notice(ls_tsn_SQL) RETURNING lo_table_ship_notice.*       
  CALL p_json_obj.put(lo_table_ship_notice.TABLE_NAME,lo_table_ship_notice.RECORDS)
  
  PREPARE lpre_GetGZCCData FROM ls_SQL
  DECLARE lcur_GetGZCCData CURSOR FOR lpre_GetGZCCData

  LET li_RecCnt = 1 
  
  OPEN lcur_GetGZCCData
  FOREACH lcur_GetGZCCData INTO lo_GZCC_T[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_GetGZCCData
  CALL lo_GZCC_T.deleteElement(li_RecCnt)
  
  FREE lpre_GetGZCCData
  FREE lcur_GetGZCCData  

  LET lo_RETURN.* = lo_GZCC_T.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_import_GZCC_data(p_TableName,p_json_obj,po_PARAMETERS)
DEFINE
  p_TableName    STRING,
  p_json_obj     util.JSONObject, 
  po_PARAMETERS  T_DZLM_T_SCR  
DEFINE
  ls_TableName        STRING,
  lo_PARAMETERS       T_DZLM_T_SCR,
  ls_FileName         STRING,
  lo_DATAS            DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_UsingFormat      STRING,
  ls_EXPORT_TABLE     STRING,
  lb_success          BOOLEAN,
  li_RecCount         INTEGER 

  LET ls_TableName    = p_TableName
  LET lo_PARAMETERS.* = po_PARAMETERS.*

  LET ls_UsingFormat  = cs_UsingFormat
  LET ls_EXPORT_TABLE = "GZCC_T"
  
  LET ls_FileName = ls_TableName,"+TABLE+",
                    lo_PARAMETERS.DZLM012,"+",
                    (lo_PARAMETERS.DZLM015 USING ls_UsingFormat),".",ls_EXPORT_TABLE,".unl"
  
  CALL sadzp310_exim_get_data_from_file(ls_FileName,cs_error_tag) RETURNING lo_DATAS,lb_success
  IF lb_success THEN
    LET li_RecCount = p_json_obj.Get(ls_EXPORT_TABLE)
    IF lo_DATAS.getLength() <> li_RecCount THEN
      LET lb_success = FALSE
      DISPLAY cs_error_tag,"Record and notice counts differ !!"
    END IF 
    IF lb_success THEN
      CALL sadzp310_exim_set_GZCC_T_data(lo_DATAS) RETURNING lb_success
    END IF   
  END IF
  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_set_GZCC_T_data(p_DATAS)
DEFINE
  p_DATAS DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500)
DEFINE
  lo_DATAS        DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(500),
  ls_InsertValue  STRING,
  ls_InsertSQL    STRING,
  ls_UpdateValue  STRING,
  ls_UpdateSQL    STRING,
  lb_success      BOOLEAN,
  li_loop         INTEGER
  
  LET lo_DATAS.* = p_DATAS.*
  LET lb_success = TRUE

  FOR li_loop = 1 TO lo_DATAS.getLength()
    IF lo_DATAS[li_loop,1] IS NOT NULL THEN
      LET ls_InsertValue = "'",lo_DATAS[li_loop,1],"',",
                           "'",lo_DATAS[li_loop,2],"',",
                           " ",NVL(lo_DATAS[li_loop,3],"NULL"),", ",
                           "'",lo_DATAS[li_loop,4],"',",
                           "'",lo_DATAS[li_loop,5],"',",
                           " ",NVL(lo_DATAS[li_loop,6],"NULL"),", ",
                           "'",lo_DATAS[li_loop,7],"' "
                           
      LET ls_InsertSQL = "INSERT INTO GZCC_T (                                         ",
                         "                    GZCC001,GZCC002,GZCC003,GZCC004,GZCC005, ",
                         "                    GZCC006,GZCCSTUS                         ",
                         "                   )                                         ",  
                         " VALUES (                                                    ",
                         ls_InsertValue,
                         "        )                                                    "
                         
      LET ls_UpdateValue = "GZCC002  = '",lo_DATAS[li_loop,2],"',",
                           "GZCC003  =  ",NVL(lo_DATAS[li_loop,3],"NULL"),", ",
                           "GZCC005  = '",lo_DATAS[li_loop,5],"',",
                           "GZCC006  =  ",NVL(lo_DATAS[li_loop,6],"NULL"),", ",
                           "GZCCSTUS = '",lo_DATAS[li_loop,7],"' "
                           
      LET ls_UpdateSQL = "UPDATE GZCC_T SET ",
                         ls_UpdateValue,
                         " WHERE GZCC001 = '",lo_DATAS[li_loop,1],"'",
                         "   AND GZCC004 = '",lo_DATAS[li_loop,4],"'"
                         
      CALL sadzp310_exim_exec_SQL(ls_InsertSQL) RETURNING lb_success
      LET lb_success = TRUE

      {
      #因應Merge因此不更新 2014.10.21
      IF NOT lb_success THEN
        CALL sadzp310_exim_exec_SQL(ls_UpdateSQL) RETURNING lb_success
        IF NOT lb_success THEN
          DISPLAY "[ INSERT SQL ] ",ls_InsertSQL,"\n" 
          DISPLAY "[ Update SQL ] ",ls_UpdateSQL,"\n" 
          EXIT FOR 
        END IF
      END IF
      }
      
    END IF
  END FOR 

  RETURN lb_success
  
END FUNCTION

################################################################################

FUNCTION sadzp310_exim_delete_invalid_dzeu_data(p_TableName)
DEFINE
  p_TableName  STRING
DEFINE
  ls_TableName        STRING,
  ls_DeleteSQL        STRING, 
  lb_success          BOOLEAN 

  LET ls_TableName = p_TableName.toLowerCase()

  LET ls_DeleteSQL = "DELETE FROM DZEU_T EU                                ",
                     " WHERE NOT EXISTS (                                  ",
                     "                    SELECT 1                         ",
                     "                      FROM GZDA_T DA                 ",
                     "                     WHERE DA.GZDA001 = EU.DZEU002   ",
                     "                  )                                  ",
                     "   AND EU.DZEU001 = '",ls_TableName.toLowerCase(),"' "
  
  CALL sadzp310_exim_exec_SQL(ls_DeleteSQL) RETURNING lb_success

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_add_missing_dzeu_data(p_TableName)
DEFINE
  p_TableName  STRING
DEFINE
  ls_TableName   STRING,
  ls_DeleteSQL   STRING, 
  lo_schema_list DYNAMIC ARRAY OF T_SCHEMA_LIST, 
  lo_table_type  T_TABLE_TYPE, 
  li_loop        INTEGER,
  lb_success     BOOLEAN 

  LET ls_TableName = p_TableName.toLowerCase()

  LET lb_success = TRUE

  CALL sadzp310_db_get_valid_schema_list() RETURNING lo_schema_list
  FOR li_loop = 1 TO lo_schema_list.getLength()
    CALL sadzp310_db_get_table_type_by_dsdemo(ls_TableName,lo_schema_list[li_loop].sl_SCHEMA_NAME) RETURNING lo_table_type.*
    CALL sadzp310_crud_insert_update_dzeu_t(lo_table_type.*)
  END FOR 

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp310_exim_check_version_data_exist(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name  STRING,
  ls_sql         STRING,
  li_rec_count   INTEGER,
  lb_return      BOOLEAN

  LET ls_table_name = p_table_name.toUpperCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(*)                        ",
               "  FROM DZEV_T EV                       ",
               " WHERE EV.DZEV002 = '",ls_table_name,"'",
               "   AND EV.DZEV004 = 'TableDesigner'    "
   
  PREPARE lpre_check_version_data_exist FROM ls_sql
  DECLARE lcur_check_version_data_exist CURSOR FOR lpre_check_version_data_exist
  OPEN lcur_check_version_data_exist
  FETCH lcur_check_version_data_exist INTO li_rec_count
  CLOSE lcur_check_version_data_exist
  FREE lcur_check_version_data_exist
  FREE lpre_check_version_data_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp310_exim_check_alm_request_data_exist(p_table_name,p_parameters)
DEFINE
  p_table_name  STRING,
  p_parameters  T_DZLM_T_SCR  
DEFINE
  ls_table_name  STRING,
  lo_parameters  T_DZLM_T_SCR,  
  ls_sql         STRING,
  li_rec_count   INTEGER,
  lb_return      BOOLEAN

  LET ls_table_name   = p_table_name.toUpperCase()
  LET lo_parameters.* = p_parameters.*

  #取得資料筆數
  LET ls_SQL = "SELECT COUNT(*)                                       ",                         
               "  FROM DZEV_T EV                                      ",
               " WHERE EV.DZEV002 = '",ls_table_name.toUpperCase(),"' ",
               "   AND EV.DZEV003 = TRIM('",lo_parameters.DZLM015,"') ", 
               "   AND EV.DZEV004 = 'TableDesigner'                   ",
               "   AND EV.DZEV018 = '",lo_parameters.DZLM005,"'       ",
               "   AND EV.DZEV019 = '",lo_parameters.DZLM012,"'       "
   
  PREPARE lpre_check_alm_request_data_exist FROM ls_sql
  DECLARE lcur_check_alm_request_data_exist CURSOR FOR lpre_check_alm_request_data_exist
  OPEN lcur_check_alm_request_data_exist
  FETCH lcur_check_alm_request_data_exist INTO li_rec_count
  CLOSE lcur_check_alm_request_data_exist
  FREE lcur_check_alm_request_data_exist
  FREE lpre_check_alm_request_data_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp310_exim_get_table_ship_notice(p_SQL)
DEFINE
  p_SQL STRING
DEFINE  
  lo_table_ship_notice T_TABLE_SHIP_NOTICE,
  ls_SQL     STRING,
  li_RecCnt  INTEGER
DEFINE
  lo_RETURN T_TABLE_SHIP_NOTICE

  LET ls_SQL = p_SQL

  INITIALIZE lo_table_ship_notice TO NULL
  INITIALIZE lo_RETURN TO NULL
  
  PREPARE lpre_get_table_ship_notice FROM ls_SQL
  DECLARE lcur_get_table_ship_notice CURSOR FOR lpre_get_table_ship_notice

  LET li_RecCnt = 1 
  
  OPEN lcur_get_table_ship_notice
  FETCH lcur_get_table_ship_notice INTO lo_table_ship_notice.*
  CLOSE lcur_get_table_ship_notice

  FREE lpre_get_table_ship_notice
  FREE lcur_get_table_ship_notice  

  LET lo_RETURN.* = lo_table_ship_notice.*
  
  RETURN lo_RETURN.*
  
END FUNCTION

FUNCTION sadzp310_exim_table_export_notice(p_TableName,p_data)
DEFINE
  p_TableName STRING,
  p_data      STRING
DEFINE
  ls_data       STRING,
  ls_TableName  STRING,
  ls_FileName   STRING,
  lb_Success    BOOLEAN

  LET ls_data      = p_data
  LET ls_TableName = p_TableName

  LET ls_FileName = ls_TableName,"+EXPORT+NOTICE.txn"
  CALL sadzp310_exim_write_file(ls_FileName,ls_data) RETURNING lb_Success

  RETURN lb_Success

END FUNCTION

FUNCTION sadzp310_exim_table_check_notice(p_TableName)
DEFINE
  p_TableName STRING
DEFINE
  ls_TableName  STRING,
  ls_FileName   STRING,
  lb_Success    BOOLEAN,
  li_dzea_count INTEGER, 
  li_dzeb_count INTEGER, 
  lo_json_obj   util.JSONObject

  LET ls_TableName = p_TableName

  LET lb_success = TRUE

  LET ls_FileName = ls_TableName,"+EXPORT+NOTICE.txn"
  CALL sadzp310_exim_table_get_notice(ls_FileName) RETURNING lb_Success,lo_json_obj

  LET li_dzea_count = lo_json_obj.Get("DZEA_T")
  LET li_dzeb_count = lo_json_obj.Get("DZEB_T")

  #DZEA_T 或 DZEB_T 數量為 0 , 則不處理(失敗)  
  IF (li_dzea_count = 0) OR (li_dzeb_count = 0) THEN
    LET lb_success = FALSE
  END IF 
  
  RETURN lb_Success,lo_json_obj

END FUNCTION

FUNCTION sadzp310_exim_table_get_notice(p_FileName)
DEFINE
  p_FileName  STRING
DEFINE
  ls_FileName  STRING
DEFINE  
  lo_channel_read  base.Channel,
  ls_TextLine      STRING,
  li_RecCnt        INTEGER,
  lb_success       BOOLEAN,
  lo_json_obj      util.JSONObject
DEFINE
  lo_RETURN  util.JSONObject  

  LET ls_FileName = p_FileName

  LET lb_success = TRUE

  LET lo_channel_read = base.Channel.create()
  TRY 
    CALL lo_channel_read.openFile(ls_FileName,"r")
  CATCH
    LET lb_success = FALSE
    DISPLAY "[Error]Open file ",ls_FileName," fail !!"
  END TRY  

  IF lb_success THEN
    LET li_RecCnt = 1 
    WHILE TRUE
      IF lo_channel_read.isEof() THEN 
        EXIT WHILE
      END IF

      LET ls_TextLine = ls_TextLine,lo_channel_read.readLine()
      
      LET li_RecCnt = li_RecCnt + 1 
        
    END WHILE
  END IF
  
  CALL lo_channel_read.close()
  LET lo_json_obj = util.JSONObject.parse( ls_TextLine )

  LET lo_RETURN = lo_json_obj
  
  RETURN lb_success,lo_RETURN
  
END FUNCTION

FUNCTION sadzp310_exim_get_parameter(p_param1,p_param2,p_param3,p_param4,p_param5,p_param6)
DEFINE 
  p_param1,p_param2,p_param3,p_param4,p_param5,p_param6 STRING 
DEFINE
  lo_parameter T_DZLM_T_SCR
DEFINE
  lo_return  T_DZLM_T_SCR

  LET lo_parameter.TYPES   = p_param1 #iexp, iimp, idel, iasm
  LET lo_parameter.DZLM002 = p_param2 #TableName
  LET lo_parameter.DZLM005 = p_param3 #ConstructVersion
  LET lo_parameter.DZLM006 = p_param4 #SD_Version
  LET lo_parameter.DZLM012 = p_param5 #需求單號 
  LET lo_parameter.DZLM015 = p_param6 #序號

  LET lo_return.* = lo_parameter.*

  RETURN lo_return.*  

END FUNCTION 

FUNCTION sadzp310_exim_set_module_parameters(p_param1,p_param2,p_param3,p_param4,p_param5,p_param6)
DEFINE 
  p_param1,p_param2,p_param3,p_param4,p_param5,p_param6 STRING 
DEFINE
  lo_parameter T_DZLM_T_SCR

  LET mo_PARAMETERS.TYPES   = p_param1 #iimp
  LET mo_PARAMETERS.DZLM002 = p_param2 #TableName
  LET mo_PARAMETERS.DZLM005 = IIF(p_param3==cs_rt_design_data_code,cs_rt_design_data_version,p_param3) #ConstructVersion
  LET mo_PARAMETERS.DZLM006 = p_param4 #SD_Version
  LET mo_PARAMETERS.DZLM012 = IIF(p_param3==cs_rt_design_data_code,cs_disable_alm_request_no,p_param5) #需求單號 
  LET mo_PARAMETERS.DZLM015 = IIF(p_param3==cs_rt_design_data_code,cs_disable_alm_sequence_no,p_param6) #序號
  
END FUNCTION 

FUNCTION sadzp310_exim_save_to_client(mo_parameter)
DEFINE
  mo_parameter T_PUT_GET_FILE_PARA
DEFINE
  lo_parameter    T_PUT_GET_FILE_PARA,
  ls_source       STRING,
  ls_destination  STRING,
  ls_os_separator STRING  

  LET lo_parameter.* = mo_parameter.*

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator 

  LET ls_source      = lo_parameter.SERVER_FILE_PATH,ls_os_separator,lo_parameter.SERVER_FILE_NAME
  LET ls_destination = lo_parameter.CLIENT_FILE_PATH,ls_os_separator,lo_parameter.CLIENT_FILE_NAME

  DISPLAY "Source File : ",ls_source
  DISPLAY "Destination File : ",ls_destination 
  
  CALL FGL_PUTFILE(ls_source,ls_destination)
  
END FUNCTION 

FUNCTION sadzp310_exim_catch_to_server(mo_parameter)
DEFINE
  mo_parameter T_PUT_GET_FILE_PARA
DEFINE
  lo_parameter    T_PUT_GET_FILE_PARA,
  ls_source       STRING,
  ls_destination  STRING,
  ls_os_separator STRING  

  LET lo_parameter.* = mo_parameter.*

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator 

  LET ls_source      = lo_parameter.CLIENT_FILE_PATH,ls_os_separator,lo_parameter.CLIENT_FILE_NAME
  LET ls_destination = lo_parameter.SERVER_FILE_PATH,ls_os_separator,lo_parameter.SERVER_FILE_NAME
  
  CALL FGL_GETFILE(ls_source,ls_destination)
  
END FUNCTION 

FUNCTION sadzp310_exim_set_putfile_parameter(p_param1,p_param2,p_param3,p_param4)
DEFINE 
  p_param1,p_param2,p_param3,p_param4 STRING 
DEFINE
  lo_parameter T_PUT_GET_FILE_PARA
DEFINE
  lo_return  T_PUT_GET_FILE_PARA

  #Source
  LET lo_parameter.SERVER_FILE_PATH = p_param1   
  LET lo_parameter.SERVER_FILE_NAME = p_param2
  #Destination  
  LET lo_parameter.CLIENT_FILE_PATH = p_param3   
  LET lo_parameter.CLIENT_FILE_NAME = p_param4   

  LET lo_return.* = lo_parameter.*

  RETURN lo_return.*  

END FUNCTION 

FUNCTION sadzp310_exim_set_getfile_parameter(p_param1,p_param2,p_param3,p_param4)
DEFINE 
  p_param1,p_param2,p_param3,p_param4 STRING 
DEFINE
  lo_parameter T_PUT_GET_FILE_PARA
DEFINE
  lo_return  T_PUT_GET_FILE_PARA

  #Source
  LET lo_parameter.CLIENT_FILE_PATH = p_param1   
  LET lo_parameter.CLIENT_FILE_NAME = p_param2   
  #Destination  
  LET lo_parameter.SERVER_FILE_PATH = p_param3   
  LET lo_parameter.SERVER_FILE_NAME = p_param4   

  LET lo_return.* = lo_parameter.*

  RETURN lo_return.*  

END FUNCTION 

FUNCTION sadzp310_exim_get_server_working_path(p_table_name)
DEFINE
  p_table_name STRING 
DEFINE 
  ls_working_name STRING   
DEFINE 
  lb_return BOOLEAN,
  ls_return STRING   

  LET mb_make_work_dir = TRUE
  CALL sadzp310_exim_making_work_directory(p_table_name,cs_working_dir_type_import) RETURNING lb_return,ls_working_name

  LET ls_return = ls_working_name

  RETURN lb_return,ls_return
  
END FUNCTION 

FUNCTION sadzp310_exim_get_column_with_sequence(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name  STRING,
  ls_sql         STRING,
  li_rec_cnt     INTEGER,
  lo_column_info DYNAMIC ARRAY OF T_COLUMN_INFO
DEFINE
  lo_return DYNAMIC ARRAY OF T_COLUMN_INFO

  LET ls_table_name = p_table_name.toLowerCase()
  
  LET ls_sql = "SELECT EB.DZEB001,EB.DZEB002,EB.DZEB006,EB.DZEB021 ",
               "  FROM DZEB_T EB                                   ",
               " WHERE EB.DZEB001 = '",ls_table_name,"'            ",
               " ORDER BY EB.DZEB021                               "
                
  PREPARE lpre_get_column_with_sequence FROM ls_sql
  DECLARE lcur_get_column_with_sequence CURSOR FOR lpre_get_column_with_sequence

  LET li_rec_cnt = 1
  
  OPEN lcur_get_column_with_sequence
  FOREACH lcur_get_column_with_sequence INTO lo_column_info[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_column_with_sequence
  
  FREE lpre_get_column_with_sequence
  FREE lcur_get_column_with_sequence 

  CALL lo_column_info.deleteElement(li_rec_cnt)
  
  LET lo_return = lo_column_info
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzp310_exim_check_if_new_table(p_column_info)
DEFINE
  p_column_info DYNAMIC ARRAY OF T_COLUMN_INFO
DEFINE
  lo_column_info DYNAMIC ARRAY OF T_COLUMN_INFO
DEFINE
  lb_return BOOLEAN

  LET lo_column_info = p_column_info

  IF lo_column_info.getLength() = 0 THEN
    LET lb_return = TRUE  
  ELSE
    LET lb_return = FALSE  
  END IF 
    
  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzp310_exim_get_column_sequence(p_table_name,p_column_name)
DEFINE 
  p_table_name  STRING,
  p_column_name STRING
DEFINE 
  ls_table_name  STRING,
  ls_column_name STRING,
  li_sequence    INTEGER,
  li_col_count   INTEGER,
  li_loop        INTEGER
DEFINE
  li_return INTEGER

  LET ls_table_name  = p_table_name.trim()
  LET ls_column_name = p_column_name.trim()

  LET li_sequence  = -1
  LET li_col_count = mo_column_info.getLength()

  #若在原先的欄位清單找得到該欄位, 就回傳欄位Sequence
  FOR li_loop = 1 TO mo_column_info.getLength()
    IF (mo_column_info[li_loop].cs_TABLE_NAME = ls_table_name) AND
       (mo_column_info[li_loop].cs_COLUMN_NAME = ls_column_name) THEN 
      LET li_sequence = mo_column_info[li_loop].cs_SEQUENCE 
      EXIT FOR
    END IF    
  END FOR  

  #否則,就是新欄位,要將欄位的Sequence重新指定並回傳
  IF li_sequence = -1 THEN
    LET li_col_count = li_col_count + 1
    LET li_sequence = li_col_count
    LET mo_column_info[li_col_count].cs_TABLE_NAME  = ls_table_name
    LET mo_column_info[li_col_count].cs_COLUMN_NAME = ls_column_name
    LET mo_column_info[li_col_count].cs_SEQUENCE    = li_sequence
  END IF 

  LET li_return = li_sequence
  
  RETURN li_return  
  
END FUNCTION 

FUNCTION sadzp310_exim_get_column_type(p_table_name,p_column_name,p_column_type)
DEFINE 
  p_table_name  STRING,
  p_column_name STRING,
  p_column_type STRING 
DEFINE 
  ls_table_name   STRING,
  ls_column_name  STRING,
  ls_column_type  STRING, 
  ls_new_col_type STRING,
  ls_old_col_type STRING,
  ls_ret_col_type STRING, 
  lb_result       BOOLEAN,
  li_loop         INTEGER
DEFINE
  ls_return  STRING

  LET ls_table_name  = p_table_name.trim()
  LET ls_column_name = p_column_name.trim()
  LET ls_column_type = p_column_type.trim()

  LET lb_result = FALSE
  LET ls_return = NULL
  
  #若在原先的欄位清單找得到該欄位, 就回傳欄位Column Type
  FOR li_loop = 1 TO mo_column_info.getLength()
    IF (mo_column_info[li_loop].cs_TABLE_NAME = ls_table_name) AND
       (mo_column_info[li_loop].cs_COLUMN_NAME = ls_column_name) THEN 
      LET ls_ret_col_type = mo_column_info[li_loop].cs_COLUMN_TYPE 
      EXIT FOR
    END IF    
  END FOR  

  #否則,就是新欄位,要將傳入的型態回傳
  IF ls_ret_col_type IS NULL THEN
    LET ls_ret_col_type = ls_column_type 
  END IF 

  #如果原來的型態和傳入的型態不一致時進行檢驗
  IF ls_ret_col_type <> ls_column_type THEN
    LET ls_new_col_type = ls_column_type
    LET ls_old_col_type = ls_ret_col_type
    CALL sadzp310_db_column_type_validation(ls_new_col_type,ls_old_col_type) RETURNING lb_result
    #若新的型態與舊的型態驗證通過, 則用新的, 否則用舊的
    IF lb_result THEN 
      LET ls_ret_col_type = ls_new_col_type
    ELSE
      DISPLAY cs_warning_tag,"Modify data type for column '",ls_column_name,"' from '",ls_old_col_type,"' to '",ls_new_col_type,"' validation failed."
      LET ls_ret_col_type = ls_old_col_type
    END IF
  END IF

  LET ls_return = ls_ret_col_type
  
  RETURN ls_return  
  
END FUNCTION 

FUNCTION sadzp310_exim_parse_client_full_name(p_full_name,p_export_info)
DEFINE
  p_full_name    STRING, 
  p_export_info  T_EXPORT_INFO
DEFINE
  ls_full_name    STRING, 
  lo_export_info  T_EXPORT_INFO,
  ls_client_path  STRING,
  ls_client_name  STRING 
DEFINE
  lo_return T_EXPORT_INFO

  LET ls_full_name     = p_full_name
  LET lo_export_info.* = p_export_info.*

  CALL os.Path.dirname(ls_full_name) RETURNING ls_client_path
  CALL os.Path.basename(ls_full_name) RETURNING ls_client_name

  LET lo_export_info.TAR_NAME    = ls_client_name
  LET lo_export_info.CLIENT_PATH = ls_client_path

  LET lo_return.* = lo_export_info.*

  RETURN lo_return.*
  
END FUNCTION 

FUNCTION sadzp310_exim_parse_tar_file_info(p_tar_file_name)
DEFINE 
  p_tar_file_name STRING
DEFINE 
  ls_tar_file_name STRING,
  li_loop          INTEGER,
  li_word_index    INTEGER,
  lo_tar_file_info T_TAR_FILE_INFO,
  ls_tar_char      STRING,
  ls_tar_word      STRING,
  li_tar_word      INTEGER 
DEFINE 
  lo_return T_TAR_FILE_INFO

  LET ls_tar_file_name = p_tar_file_name

  LET ls_tar_word = ""
  LET li_word_index = 1

  FOR li_loop = 1 TO ls_tar_file_name.getLength()
    LET ls_tar_char = NVL(ls_tar_file_name.subString(li_loop,li_loop),"@") 
    IF (ls_tar_char = "+") OR (ls_tar_char = ".") THEN
      CASE 
        #Table Name
        WHEN li_word_index = 1
          LET lo_tar_file_info.TABLE_NAME = ls_tar_word
        #需求單號
        WHEN li_word_index = 3
          IF ls_tar_word = cs_rt_design_request_no THEN
            LET lo_tar_file_info.CONSTRUCT_VERSION = cs_rt_design_data_code
          END IF 
          #LET mo_PARAMETERS.DZLM005 = ls_tar_word
          LET mo_PARAMETERS.DZLM012 = ls_tar_word
          LET lo_tar_file_info.REQUEST_NO = ls_tar_word
        #序號
        WHEN li_word_index = 4
          LET li_tar_word = ls_tar_word
          LET ls_tar_word = li_tar_word
          #LET mo_PARAMETERS.DZLM006 = ls_tar_word
          LET mo_PARAMETERS.DZLM015 = ls_tar_word
          LET lo_tar_file_info.SEQUENCE_NO = ls_tar_word
      END CASE   
      LET li_word_index = li_word_index + 1
      LET ls_tar_word = ""
    ELSE 
      LET ls_tar_word = ls_tar_word,ls_tar_char
    END IF    
  END FOR

  LET lo_return.* = lo_tar_file_info.*

  RETURN lo_return.* 
  
END FUNCTION 

FUNCTION sadzp310_exim_reset_parameters()
  INITIALIZE mo_PARAMETERS TO NULL
  LET mb_make_work_dir = FALSE
END FUNCTION 

FUNCTION sadzp310_exim_get_source_DGENV(p_json_obj,p_dgenv)
DEFINE
  p_json_obj util.JSONObject,
  p_dgenv    STRING
DEFINE
  ls_dgenv   STRING 
DEFINE
  ls_return STRING

  LET ls_dgenv = p_json_obj.get(cs_keyword_DGENV)

  LET ls_return = NVL(ls_dgenv,p_dgenv)

  RETURN ls_return  
 
END FUNCTION 

FUNCTION sadzp310_exim_check_if_user_define_column(p_table_name,p_column_name)
DEFINE
  p_table_name  STRING, 
  p_column_name STRING
DEFINE
  ls_table_name  STRING, 
  ls_column_name STRING,
  ls_SQL         STRING,
  li_rec_count   INTEGER,
  ls_table_cond  STRING
DEFINE
  lb_return  BOOLEAN
  
  LET ls_table_name  = p_table_name.toLowerCase()
  LET ls_column_name = p_column_name.toLowerCase()

  IF (NVL(ls_table_name,cs_null_value) = cs_null_value) THEN 
    LET ls_table_cond = ""
  ELSE 
    LET ls_table_cond = " AND EB.DZEB001 = '",ls_table_name,"' "
  END IF 

  #取得資料筆數
  LET ls_SQL = " SELECT COUNT(*)                                  ",
               "   FROM DZEB_T EB                                 ",            
               "  WHERE 1=1                                       ",
               ls_table_cond,
               "    AND EB.DZEB002 = '",ls_column_name,"'         ",
               "    AND EB.DZEB022 LIKE '",cs_cdf_user_define,"%' "

  PREPARE lpre_check_if_user_define_column FROM ls_sql
  DECLARE lcur_check_if_user_define_column CURSOR FOR lpre_check_if_user_define_column
  OPEN lcur_check_if_user_define_column
  FETCH lcur_check_if_user_define_column INTO li_rec_count
  CLOSE lcur_check_if_user_define_column
  FREE lcur_check_if_user_define_column
  FREE lpre_check_if_user_define_column

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION
