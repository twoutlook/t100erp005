#&define DEBUG

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
 
CONSTANT cs_lang STRING = "zh_TW"
CONSTANT cs_default_client_path STRING = "c:\\tt\\"

PRIVATE TYPE T_PARAMETER RECORD
               p_PARAM1   STRING, 
               p_PARAM2   STRING, 
               p_PARAM3   STRING, 
               p_PARAM4   STRING
             END RECORD

&ifndef DEBUG
GLOBALS "../../cfg/top_global.inc"
&else
GLOBALS "../../cfg/top_global.inc"
&endif

#執行的環境變數
DEFINE 
  ms_dir       STRING,
  ms_lang      STRING,
  mo_PARAMETER T_PARAMETER
            
MAIN
  CALL adzp070_initialize()
  CALL adzp070_start()
  CALL adzp070_finalize()
END MAIN

FUNCTION adzp070_initialize()
DEFINE
  lo_client_path  base.StringBuffer

  LET mo_PARAMETER.p_PARAM1 = NVL(ARG_VAL(2),"DIR") #DIR
  LET mo_PARAMETER.p_PARAM2 = NVL(ARG_VAL(3),cs_default_client_path) #Client Path
  LET mo_PARAMETER.p_PARAM3 = ARG_VAL(4) 
  LET mo_PARAMETER.p_PARAM4 = ARG_VAL(5) 

  #將 Client 端反斜線加倍, 避免被系統吃掉
  LET lo_client_path = base.StringBuffer.create()
  CALL lo_client_path.append(mo_PARAMETER.p_PARAM2)
  CALL lo_client_path.replace("\\","\\\\",0)
  LET mo_PARAMETER.p_PARAM2 = lo_client_path.toString()
  
  &ifndef DEBUG
    #依模組進行系統初始化設定(系統設定)
    CALL cl_tool_init()
    #CONNECT TO "ds"
    LET ms_lang = NVL(g_lang,cs_lang)
  &else
    CONNECT TO "local"
    LET ms_lang = cs_lang
  &endif

  #設定為背景執行
  LET g_bgjob = "Y" 

END FUNCTION

FUNCTION adzp070_start()
DEFINE
  lb_success   BOOLEAN,
  ls_message   STRING,
  ls_err_code  STRING

  DISPLAY "[adzp070 START]"
  
  #產出基本資料
  CALL adzp070_gen_basedata(ms_lang) RETURNING lb_success,ls_message
  IF NOT lb_success THEN
    LET ls_err_code = "adz-00123"
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code =  ls_err_code
    LET g_errparam.extend = ls_err_code
    LET g_errparam.popup = TRUE
    CALL cl_err()
  END IF   

  #產出成功再下載
  IF lb_success THEN
    CALL adzp070_get_basedata() RETURNING lb_success,ls_message
    IF NOT lb_success THEN
      LET ls_err_code = "adz-00124"
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  ls_err_code
      LET g_errparam.extend = ls_err_code
      LET g_errparam.popup = TRUE
      CALL cl_err()
    END IF
  END IF    

  IF lb_success THEN
    DISPLAY "[SUCCESS]"
    DISPLAY "[adzp070 SUCCESS]"
  ELSE
    DISPLAY "[FALIED]"
    DISPLAY "[adzp070 FALIED]"
  END IF   
  
END FUNCTION

FUNCTION adzp070_finalize()
  DISCONNECT CURRENT
END FUNCTION

################################################################################

FUNCTION adzp070_gen_basedata(p_lang)
DEFINE 
  p_lang STRING
DEFINE
  ls_lang      STRING,
  ls_command   STRING,
  lb_success   BOOLEAN,
  ls_message   STRING  

  LET ls_lang = p_lang

  {
  &ifndef DEBUG
  LET ls_command = "r.r adzp040 GENDATA"
  CALL adzp070_exec_prog(ls_command,TRUE) RETURNING lb_success,ls_message
  &endif
  }
  
  CALL sadzp040_util_generate_designer_files(ls_lang) RETURNING lb_success,ls_message

  RETURN lb_success,ls_message

END FUNCTION

FUNCTION adzp070_get_basedata()
DEFINE
  ls_command   STRING,
  lb_success   BOOLEAN,
  ls_message   STRING  

  LET ls_command = "r.r adzp050 TT '",mo_PARAMETER.p_PARAM1,"' '",mo_PARAMETER.p_PARAM2,"'"
  
  &ifndef DEBUG
  CALL adzp070_exec_prog(ls_command,TRUE) RETURNING lb_success,ls_message
  &endif
  #DISPLAY cs_command_tag,ls_command

  RETURN lb_success,ls_message
  
END FUNCTION

FUNCTION adzp070_exec_prog(p_command,p_check_fault)
DEFINE 
  p_command     STRING,
  p_check_fault BOOLEAN  
DEFINE 
  ls_command      STRING,  
  lb_check_fault  BOOLEAN,
  lb_success      BOOLEAN, 
  ls_all_message  STRING,  
  lo_channel      base.Channel,
  ls_message      STRING,
  ls_err_message  STRING
DEFINE
  lb_return BOOLEAN  

  LET ls_command     = p_command
  LET lb_check_fault = p_check_fault
  
  LET ls_all_message = NULL
  LET lb_success = TRUE
  LET lb_return  = TRUE

  LET lo_channel = base.Channel.create()
  CALL lo_channel.setDelimiter("")

  #DISPLAY "ls_command: ",ls_command
  LET ls_command = ls_command CLIPPED," 2>&1"

  CALL lo_channel.openPipe(ls_command,"r")   #執行指令
  IF STATUS THEN
    LET lb_success = FALSE
  ELSE
    WHILE TRUE
      CALL lo_channel.readLine() RETURNING ls_message
      DISPLAY ls_message
      CALL ui.Interface.refresh()
      LET ls_all_message = ls_all_message,ls_message,"\n" 
      IF lo_channel.isEof() THEN
        EXIT WHILE
      END IF

      #有錯誤訊息
      LET ls_err_message = ls_message.toUpperCase()
      IF ls_err_message.getIndexOf("ERROR" ,1) OR ls_err_message.getIndexOf("FAILED" ,1) THEN
        LET lb_success = FALSE
      END IF
    END WHILE
  END IF
  CALL lo_channel.close()

  IF lb_check_fault THEN
    LET lb_return = lb_success
  END IF  

  RETURN lb_return, ls_all_message
  
END FUNCTION




