
&include "../4gl/sadzp310_mcr.inc" 

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp240_type.inc"
&include "../4gl/sadzp310_type.inc"

&ifndef DEBUG
GLOBALS "../../cfg/top_global.inc"
&endif

####### For patch call adapter begin ########################################

FUNCTION sadzp310_adpt_patch_run(p_backend_mode,p_parameters,p_dzlm_object_list)
DEFINE
  p_backend_mode     BOOLEAN,
  p_parameters       T_DZLM_T_SCR,
  p_dzlm_object_list T_DZLM_TABLE_LIST
DEFINE   
  lo_arguments           T_ARGUMENTS, 
  lb_result              BOOLEAN,
  lo_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO,
  lo_export_info         T_EXPORT_INFO
  
  CALL sadzp310_adpt_patch_initialize(p_parameters.*,p_dzlm_object_list.*) RETURNING lo_arguments.*
  CALL sadzp310_adpt_patch_start(p_backend_mode,lo_arguments.*) RETURNING lb_result,lo_COMPRESS_FILE_INFO.*
  CALL sadzp310_adpt_patch_finalize(lb_result,lo_COMPRESS_FILE_INFO.*) RETURNING lo_export_info.*

  RETURN lo_export_info.*

END FUNCTION 

FUNCTION sadzp310_adpt_patch_initialize(p_parameters,p_dzlm_object_list)
DEFINE
  p_parameters       T_DZLM_T_SCR,
  p_dzlm_object_list T_DZLM_TABLE_LIST
DEFINE 
  lo_arguments  T_ARGUMENTS  
  
  LET lo_arguments.a_SHOW_DIALOG  = FALSE
  LET lo_arguments.a_BACKEND_MODE = FALSE

  #Import or Export
  LET lo_arguments.a_WORKING_TYPE = p_parameters.TYPES
  
  #Import 模式將壓縮包名稱給定 Source full name
  IF p_parameters.TYPES = cs_mdm_import THEN
    LET lo_arguments.a_SOURCE_FULL_NAME = p_dzlm_object_list.dtl_TAR_FULL_NAME
    LET lo_arguments.a_MAKE_ASSEMBLE = TRUE
  END IF   

  #set working object name
  LET lo_arguments.a_WORKING_OBJECT = p_parameters.DZLM002
  
  #依照建構型態指定物件型態
  CASE 
    #Trigger
    WHEN p_parameters.DZLM001 = cs_mdm_construct_type_trigger
      LET lo_arguments.a_CONSTRUCT_TYPE = cs_mdm_construct_type_trigger
      LET lo_arguments.a_OBJECT_TYPE = cs_working_type_trigger
    #View  
    WHEN p_parameters.DZLM001 = cs_mdm_construct_type_view
      LET lo_arguments.a_CONSTRUCT_TYPE = cs_mdm_construct_type_view
      LET lo_arguments.a_OBJECT_TYPE = cs_working_type_view
    #MTable  
    WHEN p_parameters.DZLM001 = cs_mdm_construct_type_table
      LET lo_arguments.a_CONSTRUCT_TYPE = cs_mdm_construct_type_table
      LET lo_arguments.a_OBJECT_TYPE = cs_working_type_mtable
  END CASE

  # 20161124 by circlelai 07558 start
  CALL sadzp310_adpt_set_run_mode(p_dzlm_object_list.dtl_TAR_NAME
    ,lo_arguments.a_OBJECT_TYPE) RETURNING lo_arguments.a_RUN_MODE
  # 20161124 by circlelai 07558 end
    
  RETURN lo_arguments.*
  
END FUNCTION 

FUNCTION sadzp310_adpt_patch_start(p_backend_mode,p_arguments)
DEFINE  
  p_backend_mode BOOLEAN, 
  p_arguments    T_ARGUMENTS
DEFINE
  lb_result  BOOLEAN,
  lo_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO
  
  CALL sadzp310_run(p_backend_mode,p_arguments.*) RETURNING lb_result,lo_COMPRESS_FILE_INFO.*

  RETURN lb_result,lo_COMPRESS_FILE_INFO.*
  
END FUNCTION

FUNCTION sadzp310_adpt_patch_finalize(p_result,p_COMPRESS_FILE_INFO)
DEFINE
  p_result              BOOLEAN,
  p_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO
DEFINE
  lo_export_info  T_EXPORT_INFO
  
  LET lo_export_info.WORKING_PATH = p_COMPRESS_FILE_INFO.cfi_PATH
  LET lo_export_info.TAR_NAME     = p_COMPRESS_FILE_INFO.cfi_NAME
  LET lo_export_info.CLIENT_PATH  = ""
  LET lo_export_info.RESULT       = NOT p_result 

  RETURN lo_export_info.*
  
END FUNCTION 
####### For patch call adapter end ###########################################

{#######################################################
@deprecates 2016-11-24
@description 檢查本地環境，決定是否要執行建構
  檢查ERPDB, if 新舊的SQL有一個結果不為0則執行建構 (return true)
  old: 維護作業 aoos010 -> 整合設定 -> 是否啟用互聯中台
    sql1: 
      select count(1) from ooaa_t 
       WHERE ooaa001 = 'E-SYS-0705' and ooaa002 = 'Y'
  new: 維護作業 awsi100 -> 互聯中台設定 -> 是否啟用互聯中台
    sql2: 
      select count(1) FROM wset_t 
       WHERE wset001 = 'eai-0001' and wset002 = 'Y' 
@para   
@return lb_IS_MAKE_ASSEMBLE 回傳檢查結果 
          TRUE: 要執行建構, FALSE:不執行建構
@author  circlelai 07558
@version 1.0
@since   2016-09-30
@modify  2016-11-02 by Circle Lai 07558
########################################################}
FUNCTION sadzp310_adpt_IS_MAKE_ASSEMBLE () 
DEFINE 
  li_ct1_1 INTEGER,
  li_ct1_2 INTEGER,
  li_ct2_1 INTEGER,
  li_ct2_2 INTEGER, 
  lb_IS_MAKE_ASSEMBLE BOOLEAN 
  
DEFINE ls_sql      STRING
DEFINE ls_chkf1    STRING  #判斷旗標 E-SYS-0705
DEFINE ls_chkf2    STRING  #判斷旗標 eai-0001
DEFINE li_idx      INTEGER
DEFINE li_ct1      INTEGER
DEFINE li_ct2      INTEGER
DEFINE lo_erpDBLst DYNAMIC ARRAY OF RECORD GZDA003 LIKE GZDA_T.GZDA003 END RECORD

  
  INITIALIZE lo_erpDBLst TO NULL
  LET lb_IS_MAKE_ASSEMBLE = FALSE  
  LET ls_chkf1 = "E-SYS-0705"
  LET ls_chkf2 = "eai-0001"
  
  #取得ERPDB List
  LET ls_sql = "SELECT GZDA003 FROM GZDA_T ", 
               " WHERE GZDASTUS='Y' AND GZDA005='Y' "
  PREPARE lpre_IS_MAKE_ASSEMBLE_1 FROM ls_sql
  DECLARE lcur_IS_MAKE_ASSEMBLE_1 CURSOR FOR lpre_IS_MAKE_ASSEMBLE_1
  OPEN lcur_IS_MAKE_ASSEMBLE_1
  LET li_idx = 1
  FOREACH lcur_IS_MAKE_ASSEMBLE_1 INTO lo_erpDBLst[li_idx].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    LET li_idx = li_idx + 1
  END FOREACH
  CLOSE lcur_IS_MAKE_ASSEMBLE_1
  CLOSE lpre_IS_MAKE_ASSEMBLE_1

  # 檢查旗標
  IF lo_erpDBLst.getLength() > 0 THEN
    FOR li_idx = 1 TO lo_erpDBLst.getLength()
      LET ls_sql = "SELECT COUNT(1) FROM ", lo_erpDBLst[li_idx].GZDA003, ".OOAA_T"
                 , " WHERE ooaa001='",ls_chkf1,"' AND ooaa002='Y' "
      
      PREPARE lpre_IS_MAKE_ASSEMBLE_2 FROM ls_sql
      DECLARE lcur_IS_MAKE_ASSEMBLE_2 CURSOR FOR lpre_IS_MAKE_ASSEMBLE_2
      OPEN lcur_IS_MAKE_ASSEMBLE_2
      FOREACH lcur_IS_MAKE_ASSEMBLE_2 INTO li_ct1
        IF SQLCA.sqlcode THEN
          EXIT FOREACH
        END IF
      END FOREACH 
      CLOSE lcur_IS_MAKE_ASSEMBLE_2
      CLOSE lpre_IS_MAKE_ASSEMBLE_2

      
      LET ls_sql = "SELECT COUNT(1) FROM ", lo_erpDBLst[li_idx].GZDA003, ".WSET_T"
                 , " WHERE wset001='",ls_chkf2,"' AND wset002='Y' "
      
      PREPARE lpre_IS_MAKE_ASSEMBLE_3 FROM ls_sql
      DECLARE lcur_IS_MAKE_ASSEMBLE_3 CURSOR FOR lpre_IS_MAKE_ASSEMBLE_3
      OPEN lcur_IS_MAKE_ASSEMBLE_3
      FOREACH lcur_IS_MAKE_ASSEMBLE_3 INTO li_ct2
        IF SQLCA.sqlcode THEN
          EXIT FOREACH
        END IF
      END FOREACH
      CLOSE lcur_IS_MAKE_ASSEMBLE_3
      CLOSE lpre_IS_MAKE_ASSEMBLE_3

      IF (li_ct1 > 0 OR li_ct2 > 0) THEN LET lb_IS_MAKE_ASSEMBLE = TRUE END IF 

      IF (lb_IS_MAKE_ASSEMBLE) THEN EXIT FOR END IF  
    END FOR 
    
  END IF 

  RETURN lb_IS_MAKE_ASSEMBLE
END FUNCTION 

{#######################################################
@description 
  檢視傳入的patch包,依照patch名稱和物件類別決定運行模式 a_RUN_MODE
  a_RUN_MODE 0: 預設
             1: patch
@para   p_TAR_NAME 傳入的tar檔名稱
@para   p_obj_type (預留參數) 物件型態, 對應不同型態細分
          input cs_working_type_trigger
          input cs_working_type_view
          input cs_working_type_mtable
                     之後可能會依照不同的物件型態細分優化.
@return  l_RUN_MODE  回傳運行模式, default 0
@author  circlelai 07558
@version 1.0
@since   2016-11-24
########################################################}
FUNCTION sadzp310_adpt_set_run_mode(p_TAR_NAME, p_obj_type)
  DEFINE p_TAR_NAME VARCHAR(100)
  DEFINE p_obj_type VARCHAR(50)
  DEFINE l_RUN_MODE INTEGER 
  DEFINE ls_tar_name STRING 
  
  LET l_RUN_MODE = 0 
  LET ls_tar_name = DOWNSHIFT(p_TAR_NAME)
  IF (ls_tar_name.subString(1,1) MATCHES "[a-z]") THEN
    # tar 檔開頭為字母表示是patch包
    LET l_RUN_MODE = 1
  END IF 
  RETURN l_RUN_MODE
END FUNCTION 