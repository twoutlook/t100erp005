SCHEMA ds 

#GLOBALS "../../cfg/top_global.inc"

MAIN

   ##定義在其他link的程式則無效
   #WHENEVER ERROR CALL cl_err_msg_log

   ##依模組進行系統初始化設定(系統設定)
   #CALL cl_tool_init()

   #MENU "license" ATTRIBUTE (STYLE="dialog", COMMENT=cl_getmsg("adz-00724", g_lang), IMAGE="information")
   MENU "license" ATTRIBUTE (STYLE="dialog", COMMENT="User limit exceeds", IMAGE="information")
     BEFORE MENU
       #CLOSE WINDOW SCREEN

     ON ACTION OK
       EXIT MENU

     #ON IDLE 10
     #  EXIT MENU
   END MENU

END MAIN
