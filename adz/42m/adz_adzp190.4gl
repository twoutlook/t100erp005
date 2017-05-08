#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 13/01/17
#
#+ 程式代碼......: adzp190
#+ 設計人員......: 
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp190.4gl
# Description    : SQL BUILDER
# Memo           :

 
IMPORT os
SCHEMA ds 

GLOBALS "../../cfg/top_global.inc"
 
#+ 作業開始
MAIN
DEFINE l_msg     STRING 
DEFINE l_code    STRING

   CALL cl_tool_init()
  ##切換至使用者所需要的資料庫 (營運中心)  #todo
   #CALL cl_db_connect("dsdemo", TRUE)

   LET l_code = ARG_VAL(2)
   IF cl_null(l_code) THEN
      LET l_code = "adzp190"
   END IF
    
   DISPLAY "[Argument]",l_code
   CALL sadzp190_rtn(l_code) RETURNING l_msg
   DISPLAY "[Return SQL]",l_msg

   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
