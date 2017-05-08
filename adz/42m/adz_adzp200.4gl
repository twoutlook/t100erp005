&include "../4gl/sadzp000_mcr.inc"

IMPORT os

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp200_type.inc"

PRIVATE TYPE T_PARAMETER RECORD
               p_PARAM1   STRING, 
               p_PARAM2   STRING, 
               p_PARAM3   STRING, 
               p_PARAM4   STRING
             END RECORD

#程式資訊及使用者資訊的基礎型別
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp000_type.inc"

DEFINE 
  mo_PARAMETER T_PARAMETER
 
#+ 作業開始
MAIN
DEFINE
  lb_result     BOOLEAN,
  ls_message    STRING
DEFINE
  lo_user_info  T_USER_INFO -- 使用者資訊物件

  OPTIONS
  INPUT NO WRAP
  DEFER INTERRUPT

  &ifndef DEBUG
  #依模組進行系統初始化設定(系統設定)
  CALL cl_tool_init()
  &else
  CONNECT TO "local" 
  &endif

  LET mo_PARAMETER.p_PARAM1 = ARG_VAL(2)
  LET mo_PARAMETER.p_PARAM2 = ARG_VAL(3)
  
  IF (mo_PARAMETER.p_PARAM1 IS NULL) OR (mo_PARAMETER.p_PARAM2 IS NULL) THEN
    DISPLAY "\n",
            "Usage : r.r ",ui.Interface.getName()," [RECALL] [SD/PR]",
            "\n"
  END IF  

  IF (mo_PARAMETER.p_PARAM1 = "RECALL") THEN 
    #設定使用者資訊
    LET lo_user_info.ui_NUMBER = g_user
    LET lo_user_info.ui_NAME   = cl_get_accountname(g_user)
    LET lo_user_info.ui_LANG   = g_lang   
    LET lo_user_info.ui_ROLE   = mo_PARAMETER.p_PARAM2  

    CALL sadzp200_util_recall(lo_user_info.*) RETURNING lb_result,ls_message
    
  END IF 
    
END MAIN
