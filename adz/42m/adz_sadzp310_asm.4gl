
&include "../4gl/sadzp310_mcr.inc" 

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"

&include "../4gl/sadzp310_type.inc"

&ifndef DEBUG
GLOBALS "../../cfg/top_global.inc"
&endif

DEFINE
  mo_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO,
  mb_backend_mode  BOOLEAN,
  mb_result        BOOLEAN,
  ms_result        STRING

FUNCTION sadzp310_asm_run(p_backend_mode,p_COMPRESS_FILE_INFO)
DEFINE
  p_backend_mode  BOOLEAN,
  p_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO 
  
  CALL sadzp310_asm_initialize(p_backend_mode,p_COMPRESS_FILE_INFO.*)
  CALL sadzp310_asm_start()
  CALL sadzp310_asm_finalize()

  RETURN mb_result

END FUNCTION 

FUNCTION sadzp310_asm_initialize(p_backend_mode,p_COMPRESS_FILE_INFO)
DEFINE
  p_backend_mode BOOLEAN,
  p_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO 
  
  LET mb_backend_mode = p_backend_mode
  LET mo_COMPRESS_FILE_INFO.* = p_COMPRESS_FILE_INFO.*
  
END FUNCTION 

FUNCTION sadzp310_asm_start()
DEFINE
  ls_curr_working_dir STRING,
  lb_result       BOOLEAN,
  lb_chdir        BOOLEAN,
  ls_work_path    STRING,
  li_loop         INTEGER,
  ls_message      STRING,
  ls_all_message  STRING,
  lb_raise_exception  BOOLEAN,
  ls_os_separator STRING

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  #取得目前工作目錄
  CALL os.Path.pwd() RETURNING ls_curr_working_dir
  LET ls_all_message = ""
  LET lb_raise_exception = FALSE

  CASE 
    #Trigger
    WHEN mo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE = cs_working_type_trigger
      CALL sadzp310_asmg_run(mb_backend_mode,mo_COMPRESS_FILE_INFO.*) RETURNING lb_result,ls_message
      LET ls_all_message = ls_all_message,"\n",ls_message
      IF NOT lb_result THEN LET lb_raise_exception = TRUE END IF  
    #View
    WHEN mo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE = cs_working_type_view
      CALL sadzp310_asmv_run(mb_backend_mode,mo_COMPRESS_FILE_INFO.*) RETURNING lb_result,ls_message
      LET ls_all_message = ls_all_message,"\n",ls_message
      IF NOT lb_result THEN LET lb_raise_exception = TRUE END IF  
    #MTable
    WHEN mo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE = cs_working_type_mtable
      CALL sadzp310_asmt_run(mb_backend_mode,mo_COMPRESS_FILE_INFO.*) RETURNING lb_result,ls_message
      LET ls_all_message = ls_all_message,"\n",ls_message
      IF NOT lb_result THEN LET lb_raise_exception = TRUE END IF  
  END CASE  

  #切回原目錄
  CALL os.Path.chdir(ls_curr_working_dir) RETURNING lb_chdir    

  IF lb_raise_exception THEN
    LET lb_result = FALSE
    IF mb_backend_mode THEN  #背景顯示內容
      DISPLAY ls_message
    ELSE 
      CALL sadzp310_log_view_logresult(ls_message)
    END IF  
  END IF

  LET mb_result = lb_result
  
END FUNCTION 

FUNCTION sadzp310_asm_finalize()
END FUNCTION 

{###############################################################################
# Descriptions...: 整批建立作業執行
# Memo...........:
# Usage..........: CALL sadzp310_asm_batch_run(mb_backend_mode, mo_arguments.*) 
#                   RETURNING lb_result,lo_batch_rec
# Input parameter: p_backend_mode 是否背景顯示訊息旗標
#                : p_arguments    預備執行批次作業資料
# Return code....: lb_ret 批次作業執行是否成功
#                : lo_asm_rec  批次作業執行log
# Date & Author..: 160303 by circlelai(160309-00001#1)
# Modify.........: 
###############################################################################}
FUNCTION sadzp310_asm_batch_run(p_backend_mode,p_arguments)
  DEFINE 
    p_backend_mode BOOLEAN,
    p_arguments    T_ARGUMENTS
  DEFINE
    lo_COMPRESS_FILE_INFO   T_COMPRESS_FILE_INFO,
    lo_batch_rec  DYNAMIC ARRAY OF T_ASM_REC,
    lo_strbuff1   base.StringBuffer,
    lo_strbuff2   base.StringBuffer,
    lb_result     BOOLEAN,
    li_idx1       INTEGER, 
    li_idx2       INTEGER,
    li_idx3       INTEGER,
    li_idx4       INTEGER,
    lv_objName    VARCHAR(50),
    ls_sql        STRING,
    ls_FileName   STRING,   # 儲存所有執行詳細log
    ls_fPath      STRING,   # 儲存檔案的絕對路徑
    ls_substr1    STRING,
    ls_substr2    STRING,
    ls_msg        STRING,
    ls_char       STRING
  DEFINE 
    lb_ret  BOOLEAN,
    lo_asm_rec  DYNAMIC ARRAY OF T_ASM_REC

  LET lb_ret = TRUE 
  LET lo_strbuff1 = base.StringBuffer.create()
  LET lo_strbuff2 = base.StringBuffer.create()

  #解析字串 mo_arguments.a_WORKING_OBJECT 
  CALL lo_strbuff1.append(p_arguments.a_WORKING_OBJECT)

  LET li_idx2 = 0
  IF (lo_strbuff1.equals("ALL")) THEN #取得所有設計資料
    INITIALIZE ls_sql TO NULL 
    
    CASE p_arguments.a_CONSTRUCT_TYPE
      WHEN cs_mdm_construct_type_table  #MTable
        LET ls_sql = "SELECT DISTINCT IA.DZIA001 FROM DZIA_T IA WHERE IA.DZIA001 LIKE '%_t' "
      WHEN cs_mdm_construct_type_trigger #Trigger
        LET ls_sql = "SELECT DISTINCT IT.DZIT002 FROM DZIT_T IT WHERE IT.DZIT002 LIKE '%_trg' "
      WHEN cs_mdm_construct_type_view #View
        LET ls_sql = "SELECT DISTINCT IV.DZIV001 FROM DZIV_T IV WHERE IV.DZIV001 LIKE '%_v' "
      OTHERWISE
        INITIALIZE ls_sql TO NULL 
    END CASE 

    IF ls_sql IS NOT NULL THEN #get data from DB
      PREPARE lpre_batch_run_obj FROM ls_sql
      DECLARE lcur_batch_run_obj CURSOR FOR lpre_batch_run_obj
      OPEN lcur_batch_run_obj
      FOREACH lcur_batch_run_obj INTO lv_objName
        IF SQLCA.sqlcode THEN
          EXIT FOREACH
        END IF
        LET li_idx2 = li_idx2 + 1
        LET lo_batch_rec[li_idx2].OBJ_NAME = lv_objName
      END FOREACH
      CLOSE lcur_batch_run_obj
      FREE lcur_batch_run_obj
      FREE lpre_batch_run_obj
    END IF 
    
  ELSE 
    FOR li_idx1 = 1 TO lo_strbuff1.getLength()
      LET ls_char = lo_strbuff1.getCharAt(li_idx1)
      IF ls_char IS NULL THEN 
        #Do nothing
      ELSE
        IF (ls_char.equals(",")) THEN 
          LET li_idx2 = li_idx2 + 1 
          LET lo_batch_rec[li_idx2].OBJ_NAME = lo_strbuff2.toString()
          CALL lo_strbuff2.clear()
        ELSE
          CALL lo_strbuff2.append(ls_char)
        END IF
      END IF 
      
    END FOR 
    
    IF lo_strbuff2.getLength() > 0 THEN 
      LET li_idx2 = li_idx2 + 1 
      LET lo_batch_rec[li_idx2].OBJ_NAME = lo_strbuff2.toString()
      CALL lo_strbuff2.clear()
    END IF
    
  END IF
  
  CASE p_arguments.a_CONSTRUCT_TYPE
    WHEN cs_mdm_construct_type_table  #MTable
      DISPLAY "Starting Create/Alter table with design data......please wait patiently."
      LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE = cs_working_type_mtable
      LET ls_substr1 = security.RandomGenerator.CreateUUIDString()
      LET ls_FileName = "sadzp310_asm_", ls_substr1, ".log" #執行日誌全紀錄
      FOR li_idx1 = 1 TO lo_batch_rec.getLength()
        LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME = lo_batch_rec[li_idx1].OBJ_NAME 
        CALL sadzp310_asmt_run(p_backend_mode, lo_COMPRESS_FILE_INFO.*) RETURNING lb_result, ls_msg 
        LET lo_batch_rec[li_idx1].MSG_LOG = ls_msg
        IF lb_result THEN
          LET lo_batch_rec[li_idx1].ERR_CODE = "201"  --Successful Created
          DISPLAY cs_success_tag, "Table '", lo_batch_rec[li_idx1].OBJ_NAME, "' Create/Alter Success"
        ELSE #紀錄錯誤訊息
          LET lb_ret = FALSE 
          # 搜尋'ORA-'取得 error code
          CALL  lo_strbuff1.clear()
          LET ls_substr1 = "ORA-"
          LET li_idx2 = 1
          LET li_idx3 = IIF ((ls_msg IS NOT NULL), ls_msg.getIndexOf(ls_substr1, li_idx2), 0 )
          IF li_idx3 > 0 THEN
            WHILE (li_idx3 > 0) 
              LET li_idx4 =  ls_msg.getIndexOf(":", li_idx3)
              LET ls_substr2 = ls_msg.subString(li_idx3, (li_idx4 -1))
              IF (lo_strbuff1.getLength() == 0) OR (lo_strbuff1.getIndexOf(ls_substr2, 1) == 0) THEN
                #err-code 不存在'lo_strbuff1'中則新增
                CALL lo_strbuff1.append(ls_substr2)
                CALL lo_strbuff1.append(",")
              END IF 
              LET li_idx2 = li_idx4 
              LET li_idx3 = ls_msg.getIndexOf(ls_substr1, li_idx2)
            END WHILE 
            LET lo_batch_rec[li_idx1].ERR_CODE = lo_strbuff1.toString()
          ELSE
            LET lo_batch_rec[li_idx1].ERR_CODE = "500" --Internal Server Error
            IF ls_msg IS NULL THEN #Unknow error msg
              LET lo_asm_rec[li_idx1].MSG_LOG = "Internal Server Error"
            END IF 
          END IF

          # 搜尋"Log File : "取得 log file 儲存路徑
          CALL  lo_strbuff1.clear()
          LET ls_substr1 = "Log File : "
          LET li_idx2 = 1
          LET li_idx3 = IIF ((ls_msg IS NOT NULL), ls_msg.getIndexOf(ls_substr1, li_idx2), 0 )
          IF li_idx3 > 0 THEN
            WHILE (li_idx3 > 0) 
              LET li_idx4 =  ls_msg.getIndexOf("\n", li_idx3)
              LET li_idx3 = li_idx3 + ls_substr1.getLength()
              LET ls_substr2 = ls_msg.subString(li_idx3, (li_idx4 - 1))
              IF (lo_strbuff1.getLength() == 0) OR (lo_strbuff1.getIndexOf(ls_substr2, 1) == 0) THEN
                CALL lo_strbuff1.append(ls_substr2)
                CALL lo_strbuff1.append("\n")
              END IF 
              LET li_idx2 = li_idx4 
              LET li_idx3 = ls_msg.getIndexOf(ls_substr1, li_idx2)
            END WHILE 
            LET lo_batch_rec[li_idx1].LOG_FILE = lo_strbuff1.toString()
          ELSE
            LET lo_batch_rec[li_idx1].LOG_FILE = "NOT FOUND" --Not found log file 
          END IF 
          
          IF (p_backend_mode) THEN #背景顯示錯誤訊息
            DISPLAY cs_error_tag, "Table '", lo_batch_rec[li_idx1].OBJ_NAME, "' Create/Alter Error"
          END IF
          
        END IF

        #紀錄 log 到 ls_logFName 
        IF (ls_FileName IS NOT NULL) THEN 
          CALL sadzp310_util_gen_log_file(lo_batch_rec[li_idx1].MSG_LOG, ls_FileName, "a") 
                RETURNING  lb_result,ls_fPath
        END IF 
      END FOR 

      IF ls_fPath IS NOT NULL THEN #顯示執行日誌文件路徑
        DISPLAY "Execution log file path : ", ls_fPath
      END IF
      DISPLAY "END Create/Alter table with design data."
      
      LET lo_asm_rec.* = lo_batch_rec.*

    WHEN cs_mdm_construct_type_trigger #Trigger
      DISPLAY "Starting Create/Replace Trigger with design data......please wait patiently."
      LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE = cs_working_type_trigger
      LET ls_substr1 = security.RandomGenerator.CreateUUIDString()
      LET ls_FileName = "sadzp310_asm_", ls_substr1, ".log" #執行日誌全紀錄
      FOR li_idx1 = 1 TO lo_batch_rec.getLength()
        LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME = lo_batch_rec[li_idx1].OBJ_NAME 
        CALL sadzp310_asmg_run(p_backend_mode, lo_COMPRESS_FILE_INFO.*) RETURNING lb_result, ls_msg 
        LET lo_batch_rec[li_idx1].MSG_LOG = ls_msg
        IF lb_result THEN
          LET lo_batch_rec[li_idx1].ERR_CODE = "201"  --Successful Created
          DISPLAY cs_success_tag, "Trigger '", lo_batch_rec[li_idx1].OBJ_NAME, "' Create/Replace Success"
        ELSE #紀錄錯誤訊息
          LET lb_ret = FALSE 
          # 搜尋'ORA-'取得 error code
          CALL  lo_strbuff1.clear()
          LET ls_substr1 = "ORA-"
          LET li_idx2 = 1
          LET li_idx3 = IIF ((ls_msg IS NOT NULL), ls_msg.getIndexOf(ls_substr1, li_idx2), 0 )
          IF li_idx3 > 0 THEN
            WHILE (li_idx3 > 0) 
              LET li_idx4 =  ls_msg.getIndexOf(":", li_idx3)
              LET ls_substr2 = ls_msg.subString(li_idx3, (li_idx4 -1))
              IF (lo_strbuff1.getLength() == 0) OR (lo_strbuff1.getIndexOf(ls_substr2, 1) == 0) THEN
                #err-code 不存在'lo_strbuff1'中則新增
                CALL lo_strbuff1.append(ls_substr2)
                CALL lo_strbuff1.append(",")
              END IF 
              LET li_idx2 = li_idx4 
              LET li_idx3 = ls_msg.getIndexOf(ls_substr1, li_idx2)
            END WHILE 
            LET lo_batch_rec[li_idx1].ERR_CODE = lo_strbuff1.toString()
          ELSE
            LET lo_batch_rec[li_idx1].ERR_CODE = "500" --Internal Server Error
            IF ls_msg IS NULL THEN #Unknow error msg
              LET lo_asm_rec[li_idx1].MSG_LOG = "Internal Server Error"
            END IF 
          END IF

          # 搜尋"Log File : "取得 log file 儲存路徑
          CALL  lo_strbuff1.clear()
          LET ls_substr1 = "Log File : "
          LET li_idx2 = 1
          LET li_idx3 = IIF ((ls_msg IS NOT NULL), ls_msg.getIndexOf(ls_substr1, li_idx2), 0 )
          IF li_idx3 > 0 THEN
            WHILE (li_idx3 > 0) 
              LET li_idx4 =  ls_msg.getIndexOf("\n", li_idx3)
              LET li_idx3 = li_idx3 + ls_substr1.getLength()
              LET ls_substr2 = ls_msg.subString(li_idx3, (li_idx4 - 1))
              IF (lo_strbuff1.getLength() == 0) OR (lo_strbuff1.getIndexOf(ls_substr2, 1) == 0) THEN
                CALL lo_strbuff1.append(ls_substr2)
                CALL lo_strbuff1.append("\n")
              END IF 
              LET li_idx2 = li_idx4 
              LET li_idx3 = ls_msg.getIndexOf(ls_substr1, li_idx2)
            END WHILE 
            LET lo_batch_rec[li_idx1].LOG_FILE = lo_strbuff1.toString()
          ELSE
            LET lo_batch_rec[li_idx1].LOG_FILE = "NOT FOUND" --Not found log file 
          END IF 
          
          IF (p_backend_mode) THEN #背景顯示錯誤訊息
            DISPLAY cs_error_tag, "Trigger '", lo_batch_rec[li_idx1].OBJ_NAME, "' Create/Replace Error"
          END IF
        END IF 

        #紀錄 log 到 ls_logFName 
        IF (ls_FileName IS NOT NULL) THEN 
          CALL sadzp310_util_gen_log_file(lo_batch_rec[li_idx1].MSG_LOG, ls_FileName, "a") 
                RETURNING  lb_result, ls_fPath
        END IF 
        
      END FOR 

      IF ls_fPath IS NOT NULL THEN #顯示執行日誌文件路徑
        DISPLAY "Execution log file path : ", ls_fPath
      END IF
      DISPLAY "END Create/Replace Trigger with design data."
      
      LET lo_asm_rec.* = lo_batch_rec.*
      
    WHEN cs_mdm_construct_type_view #View
      DISPLAY "Starting Create/Replace View with design data......please wait patiently."
      LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE = cs_working_type_view 
      LET ls_substr1 = security.RandomGenerator.CreateUUIDString()
      LET ls_FileName = "sadzp310_asm_", ls_substr1, ".log" #執行日誌全紀錄
      FOR li_idx1 = 1 TO lo_batch_rec.getLength()
        LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME = lo_batch_rec[li_idx1].OBJ_NAME 
        CALL sadzp310_asmv_run(p_backend_mode, lo_COMPRESS_FILE_INFO.*) RETURNING lb_result, ls_msg 
        LET lo_batch_rec[li_idx1].MSG_LOG = ls_msg
        IF lb_result THEN
          LET lo_batch_rec[li_idx1].ERR_CODE = "201"  --Successful Created
          DISPLAY cs_success_tag, "View '", lo_batch_rec[li_idx1].OBJ_NAME, "' Create/Replace Success"
        ELSE #紀錄錯誤訊息
          LET lb_ret = FALSE 
          # 搜尋'ORA-'取得 error code
          CALL  lo_strbuff1.clear()
          LET ls_substr1 = "ORA-"
          LET li_idx2 = 1
          LET li_idx3 = IIF ((ls_msg IS NOT NULL), ls_msg.getIndexOf(ls_substr1, li_idx2), 0 )
          IF li_idx3 > 0 THEN
            WHILE (li_idx3 > 0) 
              LET li_idx4 =  ls_msg.getIndexOf(":", li_idx3)
              LET ls_substr2 = ls_msg.subString(li_idx3, (li_idx4 -1))
              IF (lo_strbuff1.getLength() == 0) OR (lo_strbuff1.getIndexOf(ls_substr2, 1) == 0) THEN
                #err-code 不存在'lo_strbuff1'中則新增
                CALL lo_strbuff1.append(ls_substr2)
                CALL lo_strbuff1.append(",")
              END IF 
              LET li_idx2 = li_idx4 
              LET li_idx3 = ls_msg.getIndexOf(ls_substr1, li_idx2)
            END WHILE 
            LET lo_batch_rec[li_idx1].ERR_CODE = lo_strbuff1.toString()
          ELSE
            LET lo_batch_rec[li_idx1].ERR_CODE = "500" --Internal Server Error
            IF ls_msg IS NULL THEN #Unknow error msg
              LET lo_asm_rec[li_idx1].MSG_LOG = "Internal Server Error"
            END IF 
          END IF

          # 搜尋"Log File : "取得 log file 儲存路徑
          CALL  lo_strbuff1.clear()
          LET ls_substr1 = "Log File : "
          LET li_idx2 = 1
          LET li_idx3 = IIF ((ls_msg IS NOT NULL), ls_msg.getIndexOf(ls_substr1, li_idx2), 0 )
          IF li_idx3 > 0 THEN
            WHILE (li_idx3 > 0) 
              LET li_idx4 =  ls_msg.getIndexOf("\n", li_idx3)
              LET li_idx3 = li_idx3 + ls_substr1.getLength()
              LET ls_substr2 = ls_msg.subString(li_idx3, (li_idx4 - 1))
              IF (lo_strbuff1.getLength() == 0) OR (lo_strbuff1.getIndexOf(ls_substr2, 1) == 0) THEN
                CALL lo_strbuff1.append(ls_substr2)
                CALL lo_strbuff1.append("\n")
              END IF 
              LET li_idx2 = li_idx4 
              LET li_idx3 = ls_msg.getIndexOf(ls_substr1, li_idx2)
            END WHILE 
            LET lo_batch_rec[li_idx1].LOG_FILE = lo_strbuff1.toString()
          ELSE
            LET lo_batch_rec[li_idx1].LOG_FILE = "NOT FOUND" --Not found log file 
          END IF 
          
          IF (p_backend_mode) THEN #背景顯示錯誤訊息
            DISPLAY cs_error_tag, "View '", lo_batch_rec[li_idx1].OBJ_NAME, "' Create/Replace Error"
          END IF
        END IF 

        #紀錄 log 到 ls_logFName 
        IF (ls_FileName IS NOT NULL) THEN 
          CALL sadzp310_util_gen_log_file(lo_batch_rec[li_idx1].MSG_LOG, ls_FileName, "a") 
                RETURNING  lb_result, ls_fPath
        END IF 
      END FOR 
      
      IF ls_fPath IS NOT NULL THEN #顯示執行日誌文件路徑
        DISPLAY "Execution log file path : ", ls_fPath
      END IF
      DISPLAY "END Create/Replace View with design data."
      
      LET lo_asm_rec.* = lo_batch_rec.*
      
    OTHERWISE
      LET lb_ret = FALSE 
      LET lo_asm_rec[1].ERR_CODE = "400"  --Bad Request
      LET lo_asm_rec[1].MSG_LOG = "Bad Request: error parameter after Arguments ", cs_args_construct_type, 
                      ",error string :", cs_args_construct_type, " ", p_arguments.a_CONSTRUCT_TYPE, ""
    END CASE 

    RETURN lb_ret, lo_asm_rec 
END FUNCTION 
