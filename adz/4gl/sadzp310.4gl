&include "../4gl/sadzp310_mcr.inc"

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp240_type.inc"
&include "../4gl/sadzp310_type.inc"

#執行的環境變數
DEFINE 
  ms_lang         STRING,
  ms_MasterDB     STRING,
  ms_MasterUser   STRING,
  mb_backend_mode BOOLEAN,
  mo_arguments    T_ARGUMENTS,
  mb_result       BOOLEAN,
  mo_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO  
            
FUNCTION sadzp310_run(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ARGUMENTS 
  
  CALL sadzp310_initialize(p_backend_mode,p_arguments.*)
  CALL sadzp310_start() RETURNING mb_result,mo_COMPRESS_FILE_INFO.*
  CALL sadzp310_finalize()

  RETURN mb_result,mo_COMPRESS_FILE_INFO.*

END FUNCTION

FUNCTION sadzp310_initialize(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ARGUMENTS

  LET mb_backend_mode = p_backend_mode
  LET mo_arguments.*  = p_arguments.*

  CALL sadzp310_util_set_execute_path(os.path.pwd()) #設定執行路徑
  
  &ifndef DEBUG
    LET ms_lang = NVL(g_lang,cs_default_lang)
  &else
    LET ms_lang = cs_default_lang
  &endif
  
END FUNCTION

FUNCTION sadzp310_start()
DEFINE
  lb_result       BOOLEAN,
  li_idx1         INTEGER,
  ls_subStr1       STRING,
  ls_result       STRING,
  ls_replace_arg  STRING,
  lo_EXP_LIST     DYNAMIC ARRAY OF T_EXP_HEADER,
  lo_batch_rec    DYNAMIC ARRAY OF T_ASM_REC,
  lo_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO  

DEFINE 
  ls_status  STRING,
  ls_msg     STRING,
  li_loop    INTEGER,
  lb_ret     BOOLEAN,
  lo_dzit_t  DYNAMIC ARRAY OF T_DZIT_T

  
  CASE
    WHEN mo_arguments.a_WORKING_TYPE = cs_mdm_export 
      #先匯出再壓縮
      CALL sadzp310_exp_run(mb_backend_mode,mo_arguments.*) RETURNING lb_result,lo_EXP_LIST
      CALL sadzp310_pk_run(lo_EXP_LIST) RETURNING lb_result,lo_COMPRESS_FILE_INFO.*
      IF lb_result THEN 
        CALL sadzp310_show_compress_info(lo_COMPRESS_FILE_INFO.*) 
      END IF 

      #有指定會出路徑的話, 就直接複製到該路徑去
      IF mo_arguments.a_EXPORT_FILE_LOCATION IS NOT NULL THEN
        CALL sadzp310_exp_clone_to_specify_location(lo_COMPRESS_FILE_INFO.cfi_PATH,mo_arguments.a_EXPORT_FILE_LOCATION,lo_COMPRESS_FILE_INFO.cfi_NAME) RETURNING lb_result
      END IF
      
      #有啟動UI模式的話儲存到 Client 端
      IF mo_arguments.a_SHOW_DIALOG THEN
        CALL sadzp310_util_download_package(ms_lang,lo_COMPRESS_FILE_INFO.*) RETURNING lb_result
        #顯示結果
        CALL sadzp310_show_result_message_box(lb_result,lo_COMPRESS_FILE_INFO.*)
      END IF
      
    WHEN mo_arguments.a_WORKING_TYPE = cs_mdm_import
    
      #有啟動UI模式的話先上傳到 Server 端
      IF mo_arguments.a_SHOW_DIALOG THEN
        #上傳
        CALL sadzp310_util_upload_package(ms_lang,mo_arguments.*) RETURNING lb_result,mo_arguments.*
        IF NOT lb_result THEN GOTO _RESULT END IF
      END IF

      #進行解縮及匯入
      IF NVL(mo_arguments.a_SOURCE_FULL_NAME,cs_null_value) <> cs_null_value THEN
        #先解縮
        CALL sadzp310_upk_run(mo_arguments.*) RETURNING lo_COMPRESS_FILE_INFO.*,lo_EXP_LIST
        #再匯入
        CALL sadzp310_imp_run(mb_backend_mode,lo_COMPRESS_FILE_INFO.*,lo_EXP_LIST) RETURNING lb_result 
        IF lb_result THEN 
          CALL sadzp310_show_compress_info(lo_COMPRESS_FILE_INFO.*)
        END IF
      ELSE 
        LET lb_result = FALSE
        DISPLAY cs_error_tag,"No specify any file to import."
      END IF  
      IF NOT lb_result THEN GOTO _RESULT END IF

      # 取得實際trigger 狀態 #20161124 by circlelai start
      IF (lo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE == cs_working_type_trigger) THEN
        CALL sadzp310_asmg_get_dzit_t_data(lo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME) RETURNING lo_dzit_t
        FOR li_loop = 1 TO lo_dzit_t.getLength()
          CALL sadzp310_asmg_get_trigger_status(
                  lo_dzit_t[li_loop].DZIT003,   --預建立schema group name
                  lo_dzit_t[li_loop].DZIT001,   --table name
                  lo_dzit_t[li_loop].DZIT002)   --trigger id  
            RETURNING ls_status 
          LET lo_dzit_t[li_loop].DZIT009 = ls_status 
        END FOR  
      END IF 
      # 取得實際trigger 狀態 #20161124 by circlelai end
      
      #有啟動組合參數的話就執行表格異動或View及Trigger建置的動作
      IF mo_arguments.a_MAKE_ASSEMBLE THEN
        CALL sadzp310_asm_run(mb_backend_mode,lo_COMPRESS_FILE_INFO.*) RETURNING lb_result

        # 變更trigger 狀態 #20161124 by circlelai start
        IF (lo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE == cs_working_type_trigger 
            AND (NOT lb_result OR mo_arguments.a_RUN_MODE == 1)) THEN
          FOR li_loop = 1 TO lo_dzit_t.getLength()
            IF (NOT lb_result) THEN  
              LET lo_dzit_t[li_loop].DZIT009 = "X" #建構失敗要設置為失效
            END IF
            
            IF (lo_dzit_t[li_loop].DZIT009 == "Y") THEN
              LET ls_status = "ENABLE"
            ELSE 
              LET ls_status = "DISABLE"
            END IF 
            # 更新實體trigger狀態
            CALL sadzp310_asmg_switch_trg(
                   lo_dzit_t[li_loop].DZIT002, 
                   ls_status,lo_dzit_t[li_loop].DZIT003) 
              RETURNING lb_ret,ls_msg
            # 更新 trigger設計資料狀態 (dzit_t)
            CALL sadzp310_asmg_set_trigger_status(lo_dzit_t[li_loop].*) 
              RETURNING lb_ret
          END FOR 
        END IF 
        #20161124 by circlelai end
        
        IF NOT lb_result THEN #建構失敗
          GOTO _RESULT 
        END IF

        IF lb_result AND mo_arguments.a_MAKE_REBUILD THEN 
        END IF
      ELSE
        #Fixme_161103: 未執行建構,需要更新'設計資料建構狀態旗標' 
      END IF

      
      
      LABEL _RESULT:
      
      #有啟動UI模式的話顯示結果
      IF mo_arguments.a_SHOW_DIALOG THEN
        #顯示結果
        CALL sadzp310_show_result_message_box(lb_result,lo_COMPRESS_FILE_INFO.*)
      END IF
      
    #160309-00001#1 add by circlelai start 
    WHEN mo_arguments.a_WORKING_TYPE = cs_mdm_assemble  --"-WT iasm" 
      # 整批建立作業，batch create /alter (Table,Trigger,View) by design data

      #有啟動UI模式的話，開啟處選擇窗口 
      IF mo_arguments.a_SHOW_DIALOG THEN 
        #fixme? 待做,提供介面讓使用者選擇要執行建構的項目
      END IF 
      
      IF mo_arguments.a_WORKING_OBJECT IS NOT NULL THEN
        CALL sadzp310_asm_batch_run(mb_backend_mode, mo_arguments.*) RETURNING lb_result,lo_batch_rec
        IF NOT lb_result THEN --顯示錯誤訊息
          FOR li_idx1 = 1 TO lo_batch_rec.getLength()
            LET ls_subStr1 = lo_batch_rec[li_idx1].ERR_CODE
            CASE
              WHEN (ls_subStr1.getIndexOf("ORA-", 1) > 0)
                DISPLAY cs_error_tag, " '", lo_batch_rec[li_idx1].OBJ_NAME, "' Create/Alter Error :\n"
                        ,"  Error Code : ",lo_batch_rec[li_idx1].ERR_CODE, "\n"
                        ,"  Log Path   : ", lo_batch_rec[li_idx1].LOG_FILE, "\n"
              WHEN ((ls_subStr1 MATCHES "4[0-9][0-9]") 
                    OR (ls_subStr1 MATCHES "5[0-9][0-9]"))  
                DISPLAY cs_error_tag, " '", lo_batch_rec[li_idx1].OBJ_NAME, "' Create/Alter Error :\n"
                        ,"  Error Code : ",lo_batch_rec[li_idx1].ERR_CODE, "\n"
                        ,"  Error Msg. : ",lo_batch_rec[li_idx1].MSG_LOG, "\n"
              OTHERWISE 
                EXIT CASE 
            END CASE 
            
          END FOR
          DISPLAY "Error." --方便使用者於背景判斷批次執行的結果
        ELSE 
          DISPLAY "Success." --方便使用者於背景判斷批次執行的結果
        END IF
        
      ELSE 
        DISPLAY "No data need doing."
      END IF 
      #160309-00001#1 add by circlelai end 
      
  END CASE

  RETURN lb_result,lo_COMPRESS_FILE_INFO.*
  
END FUNCTION

FUNCTION sadzp310_finalize()
END FUNCTION

FUNCTION sadzp310_show_compress_info(p_COMPRESS_FILE_INFO)
DEFINE
  p_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO  
DEFINE
  lo_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO  

  LET lo_COMPRESS_FILE_INFO.* = p_COMPRESS_FILE_INFO.*

  DISPLAY cs_information_tag,"Compressed file compress/uncompress information.","\n",
          "  Object type : ",lo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE,"\n",
          "  Object name : ",lo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME,"\n",
          "  Compressed file name : ",lo_COMPRESS_FILE_INFO.cfi_NAME,"\n",
          "  Compressed file path : ",lo_COMPRESS_FILE_INFO.cfi_PATH,"\n"
  
END FUNCTION

FUNCTION sadzp310_show_result_message_box(p_result,p_COMPRESS_FILE_INFO)
DEFINE 
  p_result BOOLEAN,
  p_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO  
DEFINE
  lb_result  BOOLEAN,
  lo_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO,  
  ls_replace_arg  STRING  
  
  LET lb_result  = p_result
  LET lo_COMPRESS_FILE_INFO.* = p_COMPRESS_FILE_INFO.*

  CASE
    WHEN mo_arguments.a_WORKING_TYPE = cs_mdm_export
      IF lb_result THEN 
        LET ls_replace_arg = lo_COMPRESS_FILE_INFO.cfi_NAME,"|"
        CALL sadzp000_msg_show_info(NULL, 'adz-00701', ls_replace_arg, 0) -- 匯出成功
      ELSE
        LET ls_replace_arg = lo_COMPRESS_FILE_INFO.cfi_NAME,"|"
        CALL sadzp000_msg_show_error(NULL, 'adz-00702', ls_replace_arg, 0) -- 匯出失敗
      END IF
    WHEN mo_arguments.a_WORKING_TYPE = cs_mdm_import
      IF lb_result THEN 
        LET ls_replace_arg = lo_COMPRESS_FILE_INFO.cfi_NAME,"|"
        CALL sadzp000_msg_show_info(NULL, 'adz-00703', ls_replace_arg, 0) -- 匯入成功
      ELSE
        LET ls_replace_arg = lo_COMPRESS_FILE_INFO.cfi_NAME,"|"
        CALL sadzp000_msg_show_error(NULL, 'adz-00704', ls_replace_arg, 0) -- 匯入失敗
      END IF
      
  END CASE    
 
END FUNCTION

