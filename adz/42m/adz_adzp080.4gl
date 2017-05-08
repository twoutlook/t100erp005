# Modify              : 2015/11/09 by Hiko    : 調整有錯誤的訊息顯現機制
# Modify 160310-00002 : 2016/03/10 by Ernest  : 上傳錯誤時回傳錯誤訊息
# Modify 160922-00039 : 2016/09/26 by Ernest  : 配合本版次調整更新呼叫sadzp060_8_modify_curr_ver

#&define DEBUG

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/adzp080_cnst.inc"
&include "../4gl/adzp080_type.inc"

GLOBALS "../../cfg/top_global.inc"

#執行的環境變數
DEFINE 
  ms_lang         STRING,
  mi_log_line     INTEGER,
  ms_message      STRING,
  ms_all_progress STRING,
  ms_file_name    STRING,
  ms_ext_name     STRING,
  mo_parameters   T_UPLOAD_PARAM,
  ms_all_tasks    STRING,
  mb_run_normal   BOOLEAN,
  mb_success      BOOLEAN,  
  mi_spend_time   DATETIME YEAR TO SECOND,
  ms_adjust_ver   STRING #160922-00039
            
MAIN
  CALL adzp080_initialize()
  IF mo_parameters.arg3_upload_doc_type <> cs_doc_type_4rp THEN 
    CALL adzp080_initial_form()
  END IF   
  CALL adzp080_start()
  CALL adzp080_finalize()
END MAIN

FUNCTION adzp080_initialize()
DEFINE 
  ls_program_name STRING,
  ls_message      STRING,
  ls_dzaf010      STRING,
  ls_err_code     STRING,
  ls_dgenv        STRING,
  lb_result       BOOLEAN 

  LET mb_run_normal = TRUE

  LET ls_dgenv = FGL_GETENV("DGENV")
  
  #Initialize parameters
  &ifndef DEBUG
    LET mo_parameters.arg1_program_name      = NVL(ARG_VAL(2),"NULL")  #Program Name                   
    LET mo_parameters.arg2_module_name       = NVL(ARG_VAL(3),"NULL")  #Module Name                    
    LET mo_parameters.arg3_upload_doc_type   = NVL(ARG_VAL(4),"''")      #Upload Document Type (SPEC or CODE)
    LET mo_parameters.arg4_client_path       = NVL(ARG_VAL(5),"''")        #Client Path
    LET ms_adjust_ver                        = NVL(ARG_VAL(6),"N")        #160922-00039            
    --LET mo_parameters.arg5_spec_version     = NVL(ARG_VAL(6),"''")      #SD Version Code                   
    --LET mo_parameters.arg6_code_version     = NVL(ARG_VAL(7),"''")      #PR Version Code  
    --LET mo_parameters.arg7_std_program      = NVL(ARG_VAL(8),"''")      #Standard Program
    --LET mo_parameters.arg8_std_spec_version = NVL(ARG_VAL(9),"''")      #StandardSD Version Code                   
    --LET mo_parameters.arg9_std_code_version = NVL(ARG_VAL(10),"''")     #StandardPR Version Code  
    --LET mo_parameters.arg10_dgenv           = NVL(ARG_VAL(11),ls_dgenv) #DGENV
  &else
    LET mo_parameters.arg1_program_name      = "aiti333.tzp"     #Program Name                   
    LET mo_parameters.arg2_module_name       = "ait"             #Module Name                    
    LET mo_parameters.arg3_upload_doc_type   = cs_doc_type_spec  #Upload Document Type (SPEC or CODE)
    LET mo_parameters.arg4_client_path       = "c:\\tt\\"        #Client Path                    
    LET ms_adjust_ver                        = "N"               #160922-00039     
    --LET mo_parameters.arg5_spec_version     = "1"               #SD Version Code                   
    --LET mo_parameters.arg6_code_version     = "1"               #PR Version Code
    --LET mo_parameters.arg7_std_program      = "''"              #Standard Program
    --LET mo_parameters.arg8_std_spec_version = "''"              #SD Version Code                   
    --LET mo_parameters.arg9_std_code_version = "''"              #PR Version Code  
    --LET mo_parameters.arg10_dgenv           = ls_dgenv          #DGENV
  &endif

  IF (
      mo_parameters.arg1_program_name    = "NULL" OR
      mo_parameters.arg2_module_name     = "NULL" OR
      mo_parameters.arg3_upload_doc_type = "''" OR
      mo_parameters.arg4_client_path     = "''" 
      --mo_parameters.arg5_spec_version    = "''" OR
      --mo_parameters.arg6_code_version    = "''" OR
      --mo_parameters.arg10_dgenv          = "''" 
     ) THEN 
    IF mo_parameters.arg3_upload_doc_type <>  cs_doc_type_4rp THEN 
      DISPLAY "\n",
              "Usage : r.r ",ui.Interface.getName()," [ProgramName.ext] [ModuleName] [SPEC/CSPEC/SPECGEN/CODE] [ClientPath]",
              "\n"
      LET mb_run_normal = FALSE
      CALL adzp080_finalize()
    END IF   
  END IF

  IF (mo_parameters.arg3_upload_doc_type <> cs_doc_type_4rp) THEN 
    LET ls_program_name = mo_parameters.arg1_program_name
    IF ls_program_name.getIndexOf(".",1) > 1 THEN
      LET ms_file_name = ls_program_name.subString(1,ls_program_name.getIndexOf(".",1)-1)
      LET ms_ext_name  = ls_program_name.subString(ls_program_name.getIndexOf(".",1)+1,ls_program_name.getLength())
    ELSE
      LET mb_success = FALSE
      LET ls_message = cs_error_tag,"No define compressed file extension name (.tzs,.tzc,.tzr ...) !!"
      LET ms_message = ms_message,ls_message 
      CALL adzp080_finalize()
    END IF
  END IF    

  &ifndef DEBUG
    #依模組進行系統初始化設定(系統設定)
    CALL cl_tool_init()
    #CONNECT TO "ds"
    LET ms_lang = NVL(g_lang,cs_default_lang)
  &else
    CONNECT TO "local"
    LET ms_lang = cs_default_lang
  &endif

  #背景執行
  LET g_bgjob = "N" 

  #Log 行數重設
  LET mi_log_line = 0
  LET ms_message = ""

  #目前跑兩個程序
  #LET ms_all_tasks = "2"
  #160922-00039 begin 
  IF ms_adjust_ver = "Y" THEN
    LET ms_all_tasks = "3"
  ELSE
    LET ms_all_tasks = "2"
  END IF
  #160922-00039 end 

  {
  ##############################################################################
  #暫時使用, 往後依ALM版控方式決定是否移除
  #判斷傳入的 Spec Version 是否為 0 , 若為 0 則呼叫取得 Spec 版本的函式
  IF (mo_parameters.arg5_spec_version = "0") AND 
     (mo_parameters.arg3_upload_doc_type = cs_doc_type_code OR mo_parameters.arg3_upload_doc_type = cs_doc_type_gcode) THEN
      --CALL sadzp060_2_get_max_revision(ms_file_name,cs_doc_type_spec) RETURNING lb_result, mo_parameters.arg5_spec_version, ls_dzaf010
      --CALL sadzp060_3_get_spec_max_revision(ms_file_name,cs_doc_type_spec,mo_parameters.arg2_module_name) RETURNING mo_parameters.arg5_spec_version, ls_message 
      IF mo_parameters.arg5_spec_version CLIPPED = "0" THEN
        LET mb_success = FALSE
        LET ls_message = cs_error_tag,ls_message
        LET ms_message = ms_message,ls_message 
        CALL adzp080_finalize()
      END IF   
  END IF 
  ##############################################################################
  }
  
END FUNCTION

FUNCTION adzp080_initial_form()
DEFINE
  ls_erp_path STRING

  CALL FGL_GETENV(cs_erp_path) RETURNING ls_erp_path
  
  &ifndef DEBUG
    OPEN WINDOW w_adzp080 WITH FORM cl_ap_formpath("ADZ","adzp080") 
    ATTRIBUTE(STYLE="progress_bar", TEXT="PROGRESSING")
    CLOSE WINDOW SCREEN
    #CONNECT TO cs_master_db
  &else
    OPEN WINDOW w_adzp080 WITH FORM "adzp080"
    ATTRIBUTE(STYLE="popup")
    CLOSE WINDOW SCREEN
    #CONNECT TO "local"
  &endif

  CURRENT WINDOW IS w_adzp080

  #瀏覽頁簽資料初始化
  &ifndef DEBUG
  #CALL cl_ui_init()
  CALL ui.Interface.loadStyles(ls_erp_path||"/cfg/4st/adzp080")
  &endif

END FUNCTION

FUNCTION adzp080_start()
DEFINE
  lb_success        BOOLEAN,
  ls_message        STRING,
  ls_main_message   STRING,
  ls_err_code       STRING,
  ls_err_msg        STRING,
  li_tasks          INTEGER,
  ls_tasks          STRING,
  li_all_tasks      INTEGER,
  li_tasks_percent  INTEGER,
  ls_tasks_progress STRING,
  li_time_start     DATETIME YEAR TO SECOND,
  li_time_end       DATETIME YEAR TO SECOND  

  LET ls_message = "[Start] ","[",CURRENT HOUR TO SECOND,"] ",ui.Interface.getName(),"\n"
  DISPLAY ls_message
  #LET ls_message = ls_message, "mo_parameters.arg5_spec_version : ",mo_parameters.arg5_spec_version,"\n"
  #LET ls_message = ls_message, "mo_parameters.arg6_code_version : ",mo_parameters.arg6_code_version,"\n"
  LET ms_message = ms_message,ls_message 
  
  LET li_tasks = 0

  #上傳壓縮包及解縮
  IF mo_parameters.arg3_upload_doc_type <> cs_doc_type_4rp THEN 
    LET li_tasks = li_tasks + 1
    LET ls_tasks = li_tasks
    DISPLAY ms_all_tasks TO formonly.ed_all_perccent
    DISPLAY ls_tasks TO formonly.ed_all_single
    LET li_all_tasks = ms_all_tasks
    LET li_tasks_percent = ((100*li_tasks) / li_all_tasks)
    LET ls_tasks_progress = li_tasks_percent
    LET ls_main_message = "Upload package and uncompress"
    DISPLAY ls_main_message TO formonly.lbl_main_message
    CALL adzp080_refresh_tasks_progressbar(ls_tasks_progress)
  END IF   
  LET li_time_start = CURRENT HOUR TO SECOND
  CALL adzp080_upload_package() RETURNING lb_success,ls_message
  LET li_time_end = cl_get_current()
  DISPLAY cs_information_tag,"Upload Package START Time : ",li_time_start  
  DISPLAY cs_information_tag,"Upload Package  END Time : ",li_time_end  
  LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
  IF NOT lb_success THEN
    LET ls_err_code = "adz-00152"
    LET ls_err_msg  = ls_message,"|" -- 160310-00002
    DISPLAY cs_error_tag,"[",ls_err_code,"]",ls_message -- 160310-00002
    &ifndef DEBUG
    # 160310-00002 begin
      INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00152"
         LET g_errparam.extend = ls_message
         LET g_errparam.popup = TRUE
         CALL cl_err()
    # 160310-00002 end
    -- CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1) -- 160310-00002 Mark
    &else
    DISPLAY ls_err_code
    &endif
  END IF   
  LET ms_message = ms_message,ls_message 

  #本版次調整更新及編譯及連結(4RP 不做)
  IF lb_success AND (mo_parameters.arg3_upload_doc_type <> cs_doc_type_4rp) THEN
    
    #160922-00039 begin
    IF lb_success AND ms_adjust_ver = "Y" THEN
      LET li_tasks = li_tasks + 1
      LET ls_tasks = li_tasks
      DISPLAY ms_all_tasks TO formonly.ed_all_perccent
      DISPLAY ls_tasks TO formonly.ed_all_single
      LET li_all_tasks = ms_all_tasks
      LET li_tasks_percent = ((100*li_tasks) / li_all_tasks)
      LET ls_tasks_progress = li_tasks_percent
      LET ls_main_message = "Adjust update for this version."
      DISPLAY ls_main_message TO formonly.lbl_main_message
      CALL adzp080_refresh_tasks_progressbar(ls_tasks_progress)
       
      LET li_time_start = CURRENT HOUR TO SECOND
      CALL adzp080_adjust_version_update() RETURNING lb_success,ls_message
      LET li_time_end = cl_get_current()
      DISPLAY cs_information_tag,"Adjust version START Time : ",li_time_start  
      DISPLAY cs_information_tag,"Adjust version  END Time : ",li_time_end  
      LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
    END IF
    #160922-00039 end
    
    IF lb_success THEN
      LET li_tasks = li_tasks + 1
      LET ls_tasks = li_tasks
      DISPLAY ms_all_tasks TO formonly.ed_all_perccent
      DISPLAY ls_tasks TO formonly.ed_all_single
      LET li_all_tasks = ms_all_tasks
      LET li_tasks_percent = ((100*li_tasks) / li_all_tasks)
      LET ls_tasks_progress = li_tasks_percent
      LET ls_main_message = "Build and link package"
      DISPLAY ls_main_message TO formonly.lbl_main_message
      CALL adzp080_refresh_tasks_progressbar(ls_tasks_progress)
       
      LET li_time_start = CURRENT HOUR TO SECOND
      CALL adzp080_build_package() RETURNING lb_success,ls_message
      LET li_time_end = cl_get_current()
      DISPLAY cs_information_tag,"Build Package START Time : ",li_time_start  
      DISPLAY cs_information_tag,"Build Package  END Time : ",li_time_end  
      LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
    END IF
    
    IF NOT lb_success THEN
      #Begin:2015/11/09 by Hiko
      #LET ls_err_code = "adz-00153"
      #LET ls_err_msg  = "|"
      #&ifndef DEBUG
      #CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
      #&else
      #DISPLAY ls_err_code
      #&endif
      INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "!"
         LET g_errparam.extend = ls_message
         LET g_errparam.popup = TRUE
         CALL cl_err()
      #End:2015/11/09 by Hiko
    END IF
    
    LET ms_message = ms_message,ls_message 
    
  END IF    

  #顯示參數值供參考
  DISPLAY cs_parameter_tag,"arg1_program_name      : ",mo_parameters.arg1_program_name
  DISPLAY cs_parameter_tag,"arg2_module_name       : ",mo_parameters.arg2_module_name
  DISPLAY cs_parameter_tag,"arg3_upload_doc_type   : ",mo_parameters.arg3_upload_doc_type
  DISPLAY cs_parameter_tag,"arg4_client_path       : ",mo_parameters.arg4_client_path
  DISPLAY cs_parameter_tag,"arg5_spec_version      : ",mo_parameters.arg5_spec_version
  DISPLAY cs_parameter_tag,"arg6_code_version      : ",mo_parameters.arg6_code_version
  DISPLAY cs_parameter_tag,"arg7_std_program       : ",mo_parameters.arg7_std_program
  DISPLAY cs_parameter_tag,"arg8_std_spec_version  : ",mo_parameters.arg8_std_spec_version
  DISPLAY cs_parameter_tag,"arg9_std_code_version  : ",mo_parameters.arg9_std_code_version
  DISPLAY cs_parameter_tag,"arg10_dgenv            : ",mo_parameters.arg10_dgenv
  DISPLAY cs_parameter_tag,"arg11_type             : ",mo_parameters.arg11_type
  
  IF lb_success THEN
    LET ls_message = "[SUCCESS] ","[",CURRENT HOUR TO SECOND,"] ",ui.Interface.getName()
    CALL adzp080_refresh_all_progressbar("100")
    SLEEP 1
  ELSE
    LET ls_message = "[FAILED] ","[",CURRENT HOUR TO SECOND,"] ",ui.Interface.getName()
  END IF   
  DISPLAY ls_message

  DISPLAY cs_information_tag,"Upload package and build program Total Time : ",mi_spend_time  
  
  LET ms_message = ms_message,ls_message 

  LET mb_success = lb_success
  
END FUNCTION

FUNCTION adzp080_finalize()
  #Begin:2015/11/09 by Hiko
  #IF mb_run_normal THEN
  #  IF NOT mb_success THEN
  #    CALL adzp080_rev_view_logresult(ms_message)
  #    IF mo_parameters.arg3_upload_doc_type <> cs_doc_type_4rp THEN 
  #      MENU
  #        COMMAND "CLOSE"
  #          EXIT MENU
  #        COMMAND "btn_confirm"
  #          EXIT MENU
  #        COMMAND "btn_view_log"
  #          CALL adzp080_rev_view_logresult(ms_message)  
  #      END MENU
  #    END IF   
  #  END IF
  #END IF   
  #End:2015/11/09 by Hiko

  #CALL adzp080_rev_view_logresult(ms_message)  
  
  TRY
    CLOSE WINDOW w_adzp080
  CATCH
  END TRY  
  
  TRY
    DISCONNECT CURRENT
  CATCH
  END TRY  
  
  EXIT PROGRAM
  
END FUNCTION

################################################################################

FUNCTION adzp080_upload_package()
DEFINE
  ls_command    STRING,
  lb_success    BOOLEAN,
  ls_message    STRING,
  ls_program    STRING,  
  lo_parameters T_UPLOAD_PARAM

  LET lb_success = TRUE
  LET ls_message = ""

  LET ls_program = "adzp060"

  CALL adzp080_get_prog_progress_all(ls_program,ms_ext_name,mo_parameters.arg3_upload_doc_type) RETURNING ms_all_progress

  #檢核及取得剩下的參數
  CALL sadzp060_run(mo_parameters.*,ms_lang) RETURNING lb_success,ls_message,lo_parameters.*
  
  #設定模組變數
  LET mo_parameters.* = lo_parameters.*

  { 
  LET ls_command = "r.r ",ls_program," ",
                   mo_parameters.arg1_program_name," ",   
                   mo_parameters.arg2_module_name," ",    
                   mo_parameters.arg3_upload_doc_type," ",
                   mo_parameters.arg4_client_path," "

  CALL adzp080_exec_prog(ls_command) RETURNING lb_success,ls_message
  }
  
  RETURN lb_success,ls_message
  
END FUNCTION

FUNCTION adzp080_build_package()
DEFINE
  ls_command   STRING,
  lb_success   BOOLEAN,
  ls_message   STRING,
  ls_program   STRING  
  
  LET lb_success = TRUE
  LET ls_message = ""

  LET ls_program = "adzp040"

  CALL adzp080_get_prog_progress_all(ls_program,ms_ext_name,mo_parameters.arg3_upload_doc_type) RETURNING ms_all_progress
  
  LET ls_command = "r.r ",ls_program," ",
                   mo_parameters.arg1_program_name," ",   
                   mo_parameters.arg2_module_name," ",    
                   mo_parameters.arg3_upload_doc_type," ",
                   NVL(mo_parameters.arg5_spec_version,"''")," ",   
                   NVL(mo_parameters.arg6_code_version,"''")," ",
                   NVL(mo_parameters.arg7_std_program,"''")," ",
                   NVL(mo_parameters.arg8_std_spec_version,"''")," ",
                   NVL(mo_parameters.arg9_std_code_version,"''")," ",
                   NVL(mo_parameters.arg10_dgenv,"''")," ",
                   NVL(mo_parameters.arg11_type,"''")

  CALL adzp080_exec_prog(ls_command) RETURNING lb_success,ls_message

  RETURN lb_success,ls_message

END FUNCTION

#160922-00039 begin 
FUNCTION adzp080_adjust_version_update()
DEFINE
  lb_success  BOOLEAN,
  ls_message  STRING,
  ls_version  STRING
  
  CASE
    WHEN mo_parameters.arg3_upload_doc_type = "SPEC"
      LET ls_version = mo_parameters.arg5_spec_version 
    WHEN mo_parameters.arg3_upload_doc_type = "CODE"
      LET ls_version = mo_parameters.arg6_code_version 
  END CASE

  #本版次調整更新
  CALL sadzp060_8_modify_curr_ver(mo_parameters.arg1_program_name, ls_version, mo_parameters.arg2_module_name, mo_parameters.arg3_upload_doc_type) RETURNING lb_success,ls_message
  
  RETURN lb_success,ls_message
  
END FUNCTION
#160922-00039 end 

FUNCTION adzp080_exec_prog(p_command)
DEFINE 
  p_command STRING  
DEFINE 
  ls_command      STRING,  
  lb_success      BOOLEAN, 
  ls_all_message  STRING,  
  lo_channel      base.Channel,
  ls_message      STRING,
  ls_err_message  STRING,
  ls_line_no      STRING,
  li_progress     INTEGER,
  ls_progress     STRING,
  ls_show_message STRING,
  ls_version_code STRING, 
  lb_record       BOOLEAN,
  li_all_progress INTEGER

  LET ls_command = p_command
  
  LET ls_all_message = NULL
  LET lb_success = TRUE

  LET lb_record = TRUE

  LET lo_channel = base.Channel.create()
  CALL lo_channel.setDelimiter("")

  DISPLAY cs_command_tag,ls_command
  LET ls_command = ls_command CLIPPED," 2>&1"

  CALL lo_channel.openPipe(ls_command,"r")   #執行指令
  IF STATUS THEN
    LET lb_success = FALSE
  ELSE
    WHILE TRUE
      CALL lo_channel.readLine() RETURNING ls_message
      IF lo_channel.isEof() THEN
        EXIT WHILE
      END IF

      #看到 IGNORE 就不紀錄
      IF ls_message.getIndexOf(cs_ignore_tag,1) THEN
        LET lb_record = FALSE
      END IF 

      IF NOT lb_record THEN
        #看到 NOTE 就紀錄
        IF ls_message.getIndexOf(cs_note_tag,1) THEN
          LET lb_record = TRUE
          CONTINUE WHILE
        END IF 
      END IF  

      IF lb_record THEN 
        IF ls_message.getIndexOf(cs_progress_tag,1) THEN
          LET li_progress = ls_message.subString(11,ls_message.getLength())
          LET li_all_progress = ms_all_progress
          DISPLAY li_progress TO formonly.ed_prog_single  
          DISPLAY li_all_progress TO formonly.ed_prog_perccent  
          LET li_progress = ((100*li_progress) / li_all_progress)
          LET ls_progress = li_progress
          #DISPLAY "PROGRESS : ",ls_progress
          CALL adzp080_refresh_all_progressbar(ls_progress)
        ELSE   
          #取得訊息秀在訊息Bar上
          IF ls_message.getIndexOf(cs_message_tag,1) THEN
            LET ls_show_message = ls_message.subString(10,ls_message.getLength())
            DISPLAY ls_show_message TO formonly.lbl_sub_message  
          ELSE   
            LET mi_log_line = mi_log_line + 1
            LET ls_line_no = "[",(mi_log_line USING "&&&&"),"]",
                             "[",CURRENT HOUR TO SECOND,"] " 

            DISPLAY ls_line_no,ls_message   #顯示背景訊息
            LET ls_all_message = ls_all_message CLIPPED," ",
                                 ls_line_no,ls_message CLIPPED,"\n"
          END IF                       
        END IF
        
        #有錯誤訊息
        LET ls_err_message = ls_message.toUpperCase()
        IF ls_err_message.getIndexOf("ERROR" ,1) OR ls_err_message.getIndexOf("FAILED" ,1) THEN
          LET lb_success = FALSE
        END IF
      END IF   
    END WHILE
  END IF
  CALL lo_channel.close()

  IF lb_success THEN 
    DISPLAY ms_all_progress TO formonly.ed_prog_perccent  
    CALL ui.Interface.refresh()
  END IF

  RETURN lb_success, ls_all_message
  
END FUNCTION

FUNCTION adzp080_get_prog_progress_all(p_program,p_pgrs_type,p_doc_type)
DEFINE
  p_program   STRING,
  p_pgrs_type STRING,
  p_doc_type  STRING
DEFINE
  ls_program      STRING,
  ls_pgrs_type    STRING,
  ls_doc_type     STRING,
  ls_progress_all VARCHAR(5),
  ls_sql          STRING
DEFINE
  ls_return STRING  

  LET ls_program   = p_program
  LET ls_pgrs_type = p_pgrs_type
  LET ls_doc_type  = p_doc_type.toUpperCase()
  
  LET ls_sql = "SELECT EJ.DZEJ006 PROGRESS_ALL                           ",
               "  FROM DZEJ_T EJ                                         ",
               " WHERE EJ.DZEJ001 = '",ls_program,"_Progress'            ",  
               "   AND EJ.DZEJ003 = 'ALL'                                ",
               "   AND EJ.DZEJ004 = '",ls_pgrs_type,"'                   ",
               "   AND (                                                 ",
               "         NVL(EJ.DZEJ005,'X') = NVL('",ls_doc_type,"','X')",
               "         OR                                              ", 
               "         EJ.DZEJ005 IS NULL                              ",
               "       )                                                 "

  #DISPLAY "SQL : ",ls_sql               

  PREPARE lpre_get_prog_progress_all FROM ls_sql
  DECLARE lcur_get_prog_progress_all CURSOR FOR lpre_get_prog_progress_all

  OPEN lcur_get_prog_progress_all
  FETCH lcur_get_prog_progress_all INTO ls_progress_all
  CLOSE lcur_get_prog_progress_all
  
  FREE lpre_get_prog_progress_all
  FREE lcur_get_prog_progress_all  

  LET ls_return = ls_progress_all
  
  RETURN ls_return
  
END FUNCTION

FUNCTION adzp080_refresh_all_progressbar(pi_position)
DEFINE 
  pi_position INTEGER
DEFINE 
  pbr_progress INTEGER  

  IF pi_position <> 0 THEN 
    LET pbr_progress = pi_position
    DISPLAY BY NAME pbr_progress
  END IF 

  CALL ui.Interface.refresh()

  #SLEEP 1
  
END FUNCTION

FUNCTION adzp080_refresh_tasks_progressbar(pi_position)
DEFINE 
  pi_position INTEGER
DEFINE 
  pbr_tasks INTEGER  

  IF pi_position <> 0 THEN 
    LET pbr_tasks = pi_position
    DISPLAY BY NAME pbr_tasks
  END IF 

  CALL ui.Interface.refresh()
  
END FUNCTION

#觀看 Log
FUNCTION adzp080_rev_view_logresult(p_message)
DEFINE
  p_message     STRING
DEFINE  
  txt_LogResult STRING

  LET txt_LogResult = p_message
  
  CALL adzp080_rev_open_logresult_form()

  DISPLAY BY NAME txt_LogResult
  MENU
    ON ACTION btn_ok
      EXIT MENU  

    ON ACTION CLOSE
      EXIT MENU
  END MENU

  CALL adzp080_rev_close_logresult_form()
  
END FUNCTION

#開啟看 Log 的Form
FUNCTION adzp080_rev_open_logresult_form()

  &ifndef DEBUG
    OPEN WINDOW w_adzp080_log WITH FORM cl_ap_formpath("ADZ","adzp080_log")
  &else
    OPEN WINDOW w_adzp080_log WITH FORM "adzp080_log"
  &endif
  
  CURRENT WINDOW IS w_adzp080_log
  
END FUNCTION

#關閉看 Log 的Form
FUNCTION adzp080_rev_close_logresult_form()

  CLOSE WINDOW w_adzp080_log
  
END FUNCTION

