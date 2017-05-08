{
  異動型態    異動單號       日 期       異動者      異動內容
  ========= ============= ========== ========== ===============================================
  Fix                     2016.09.05 Ernestliou 1.修正解析 Patch 名稱錯誤的問題
  Modify                  2016.09.12 Ernestliou 1.產生 ds.sch 後也重產多語言檔
  Modify                  2016.10.18 Ernestliou 1.更新dzyg_t.dzyg002
}
&include "../4gl/sadzi140_mcr.inc"

IMPORT util 
IMPORT os 
IMPORT security 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp240_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp240_type.inc"

DEFINE
  ms_patch_path_name STRING,
  ms_guid            STRING

FUNCTION sadzp240_run(p_patch_path_name)
DEFINE
  p_patch_path_name STRING
DEFINE
  lb_result          BOOLEAN,
  ls_working_path    STRING,  
  ls_patch_path      STRING,
  ls_patch_no        STRING,
  ls_guid            STRING,
  ls_message         STRING,
  ls_err_messages    STRING,
  ls_task_path       STRING,
  ls_host_name       STRING,
  ls_zone            STRING,
  ls_host_zone       STRING, 
  lo_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_tar_list        DYNAMIC ARRAY OF T_TAR_LIST
DEFINE
  lb_return BOOLEAN,
  ls_return STRING
  
  LET ms_patch_path_name = p_patch_path_name
  LET lb_return = TRUE
  LET ls_guid = ""
  LET ls_err_messages = ""
  LET ls_host_name = FGL_GETENV("HOSTNAME")
  LET ls_zone      = FGL_GETENV("ZONE")
  LET ls_host_zone = ls_host_name,".",ls_zone

  LET ls_patch_path = os.Path.dirName(ms_patch_path_name)

  #若有指定 GUID 則不做解包動作直接跳到啟動 Manager
  IF ms_guid IS NOT NULL THEN
    LET ls_guid = ms_guid
    GOTO _START_MANAGER  
  END IF
  
  #解包
  CALL sadzp240_upk_get_and_untar_package(ms_patch_path_name) RETURNING lb_result,ls_working_path
  IF NOT lb_result THEN LET lb_return = FALSE GOTO _ERROR END IF
  #取得包裝清單 
  CALL sadzp240_upk_get_vfy_table_list(ls_working_path) RETURNING lb_result,lo_dzlm_table_list,ls_patch_no
  IF NOT lb_result THEN LET lb_return = FALSE GOTO _ERROR END IF
  #重新整理清單依照 ADZ,AZZ,AWS,Axx,MDM 排序
  CALL sadzp240_upk_crate_sort_temp_table()
  CALL sadzp240_upk_resort_object_list(lo_dzlm_table_list) RETURNING lo_dzlm_table_list
  CALL sadzp240_upk_drop_sort_temp_table()
  #重新包小包  
  CALL sadzp240_pk_collect_and_pack(ls_patch_path,ls_working_path,lo_dzlm_table_list,ls_patch_no) RETURNING lb_result,ls_task_path,lo_tar_list
  IF NOT lb_result THEN LET lb_return = FALSE GOTO _ERROR END IF 
  
  #刪除已經過期的資料
  LET ls_message = "Kill expired interface data"
  DISPLAY cs_information_tag,ls_message
  CALL sadzp240_intf_kill_expired_interface_data() RETURNING lb_result
  IF NOT lb_result THEN
    DISPLAY cs_warning_tag,ls_message," fault." 
  ELSE
    DISPLAY cs_warning_tag,ls_message," success." 
  END IF 
  
  #產生Interface資料
  CALL sadzp240_intf_generate_interface(ls_patch_no,lo_tar_list) RETURNING ls_guid
  #產生表格清單
  CALL sadzp240_vfy_generate_verify(ls_guid,lo_dzlm_table_list) RETURNING lb_result

  
  LABEL _START_MANAGER:
  
  
  #等1秒鐘避免某些程序還未做完
  SLEEP 1

  #啟動Patch Monitor
  #CALL sadzp240_start_patch_monitor()
  #開始啟動Patch Manager
  CALL sadzp240_start_patch_manager(ls_guid,ls_task_path) 

  #For Test
  #LET ls_guid = "38BDD785-0804-46D4-B152-4BA6DC14F9EA"

  #檢核是否皆已經完成(回填完成時間及紀錄)
  WHILE TRUE
    IF sadzp240_intf_get_if_all_finished(ls_guid) THEN
      EXIT WHILE 
    END IF 
    SLEEP 1
  END WHILE

  #判斷是否為 Patch 包才做 r.s ds 整個重產
  IF DOWNSHIFT(ls_patch_no.subString(1,1)) MATCHES "[a-z]" THEN #2016.09.05
    #重產 ds.sch
    CALL sadzp240_util_gen_db_schema()
    CALL sadzp240_util_gen_multi_lang_file(ls_guid) RETURNING lb_result #2016.09.12
    CALL sadzp240_util_update_dzyg002(ls_patch_no) #2016.10.18
  END IF
  
  #檢核是否有錯誤
  CALL sadzp240_intf_get_if_any_error(ls_guid) RETURNING lb_result 
  IF lb_result THEN 
    LET lb_return = FALSE
    CALL sadzp240_intf_get_all_log_records(ls_guid) RETURNING ls_err_messages 
    DISPLAY cs_message_tag,ls_err_messages
    DISPLAY cs_error_tag,"Patch or import error GUID : ",ls_guid
    DISPLAY cs_information_tag,"Please run the command below on ",ls_host_zone," to see more log information : ","\n",
                               "  r.r adzp250 -ID '",ls_guid,"'"
    GOTO _ERROR 
  END IF
  
  LABEL _ERROR:

  LET ls_return = ls_err_messages

  RETURN lb_return,ls_return
  
END FUNCTION

FUNCTION sadzp240_start_patch_monitor()
DEFINE
  ls_command STRING

  LET ls_command = "$FGLRUN $ADZ/42r/adzp250.42r ",cs_run_background_sign

  DISPLAY cs_command_tag,ls_command
  
  RUN ls_command WITHOUT WAITING
        
END FUNCTION 

FUNCTION sadzp240_start_patch_manager(p_guid,p_patch_path)
DEFINE 
  p_guid            STRING,
  p_patch_path      STRING
DEFINE
  ls_guid            STRING,
  ls_patch_path      STRING,
  lo_dzee_t          DYNAMIC ARRAY OF T_DZEE_T, 
  li_dzee_count      INTEGER,
  li_cpu_count       INTEGER,
  li_cpu_resource    INTEGER,
  li_exec_packs      INTEGER,
  li_error           INTEGER,
  li_real_resource   INTEGER,
  li_assigned        INTEGER,
  ls_os_separator    STRING,
  ls_file_name       STRING,
  ls_command         STRING,   
  ls_patch_log_name  STRING,
  ls_patch_command   STRING,
  lb_mdm_reset       BOOLEAN,
  lb_result          BOOLEAN,
  ld_assign_time     DATETIME YEAR TO SECOND

  LET ls_guid = p_guid
  LET ls_patch_path = p_patch_path

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  LET lb_mdm_reset = FALSE

  DISPLAY cs_information_tag,"Table patch manager start."
  DISPLAY cs_information_tag,"Execution GUID : ",ls_guid
  
  WHILE TRUE

    #必要時重設屬於MDM的包(成功後就不會再做)
    IF NOT lb_mdm_reset THEN 
      CALL sadzp240_intf_reset_mdm_packages(ls_guid) RETURNING lb_mdm_reset
    END IF 
    
    #取得要分派執行的Patch程式個數
    CALL sadzp240_intf_get_sub_patch_list(ls_guid) RETURNING lo_dzee_t
    #取得正在執行的Patch程式個數
    CALL sadzp240_intf_get_on_exec_pack_counts(ls_guid) RETURNING li_exec_packs
    #取得已分派的程式個數
    CALL sadzp240_intf_get_assigned_pack_counts(ls_guid) RETURNING li_assigned
    #取得錯誤的程式個數
    CALL sadzp240_intf_get_error_pack_counts(ls_guid) RETURNING li_error

    #若已經沒有要分派及執行中及沒有錯誤的程式, 則離開  
    #IF ((lo_dzee_t.getLength() = 0) AND (li_exec_packs = 0) AND (li_assigned = 0) AND (li_error = 0)) THEN EXIT WHILE END IF 
    IF ((lo_dzee_t.getLength() = 0) AND (li_exec_packs = 0) AND (li_assigned = 0)) THEN EXIT WHILE END IF 

    #取得CPU資源
    CALL sadzp240_util_get_cpu_resource() RETURNING li_cpu_resource

    #剩下的CPU資源
    LET li_real_resource = li_cpu_resource - li_exec_packs - li_assigned

    IF li_real_resource > 0 THEN 
      FOR li_dzee_count = 1 TO lo_dzee_t.getLength()
      
        LET ls_file_name = lo_dzee_t[li_dzee_count].DZEE004
        LET ls_file_name = ls_file_name.subString(1,ls_file_name.getIndexOf(cs_default_export_ext,1)-2)
        LET ls_patch_log_name  = ls_patch_path,ls_os_separator,ls_file_name,".log"
        #LET ls_patch_command   = "r.r adzp230 iimp '",ls_patch_path,ls_os_separator,lo_dzee_t[li_dzee_count].DZEE004,"' -ID '",lo_dzee_t[li_dzee_count].DZEE001,"' '",sadzp240_util_trim_str(lo_dzee_t[li_dzee_count].DZEE002),"'"
        LET ls_patch_command   = "nohup $FGLRUN $ADZ/42r/adzp230.42r '' iimp '",ls_patch_path,ls_os_separator,lo_dzee_t[li_dzee_count].DZEE004,"' -ID '",lo_dzee_t[li_dzee_count].DZEE001,"' '",sadzp240_util_trim_str(lo_dzee_t[li_dzee_count].DZEE002),"'"
        LET ls_command = ls_patch_command," > '",ls_patch_log_name,"' 2>&1 ",cs_run_background_sign

        #設定狀態碼為已分派,並給定Patch的Full Name及Log Name
        &ifndef DEBUG
          LET ld_assign_time = cl_get_current()
        &else
          LET ld_assign_time = CURRENT YEAR TO SECOND
        &endif  
        LET lo_dzee_t[li_dzee_count].DZEE005 = cs_state_assigned
        LET lo_dzee_t[li_dzee_count].DZEE006 = ld_assign_time
        LET lo_dzee_t[li_dzee_count].DZEE009 = ls_patch_command
        LET lo_dzee_t[li_dzee_count].DZEE010 = ls_patch_log_name
        LET lo_dzee_t[li_dzee_count].DZEE011 = ls_command
        
        CALL sadzp240_intf_set_assigned_status(lo_dzee_t[li_dzee_count].*)

        DISPLAY cs_command_tag,ls_command
        
        RUN ls_command WITHOUT WAITING
        
        LET li_real_resource = li_real_resource - 1
        
        #CPU 資源分配完了, 就離開for
        IF li_real_resource = 0 THEN EXIT FOR END IF     
        
      END FOR
    END IF  

    #等 1 秒鐘再更新 Interface 中的資料
    SLEEP 1
    
  END WHILE 

  DISPLAY cs_information_tag,"Table patch manager finished."
  
END FUNCTION

FUNCTION sadzp240_set_module_guid(p_guid)
DEFINE
  p_guid  STRING

  LET ms_guid = p_guid
  
END FUNCTION

FUNCTION sadzp240_get_module_guid()
DEFINE
  ls_return  STRING

  LET ls_return = ms_guid

  RETURN ls_return
  
END FUNCTION

