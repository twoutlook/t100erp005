#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: sadzp168_4
#+ Buildtype: p01樣板自動產生
#+ Memo.....: 產生畫面欄位資訊(含tsd資料與產生器資料)--取得欄位tab資訊

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

GLOBALS
   
END GLOBALS

MAIN
   DEFINE l_result          BOOLEAN
   DEFINE l_node            om.DomNode            #4fd domNode

   DEFINE l_dzfi001         LIKE dzfi_t.dzfi001     #畫面代號
   DEFINE l_dzfi002         LIKE dzfi_t.dzfi002     #規格版本
   DEFINE l_dgenv           LIKE dzfi_t.dzfi009     #識別標示
   DEFINE l_error_message   STRING
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("adz", "") #todo
   CALL cl_tool_init()

   #切換至使用者所需要的資料庫 (營運中心)  #todo
   CALL cl_db_connect("ds", FALSE)

   LET l_dzfi001 = ARG_VAL(2)
   LET l_dzfi002 = ARG_VAL(3)
   LET l_dgenv = ARG_VAL(4)

   IF cl_null(l_dgenv) THEN
      LET l_dgenv = FGL_GETENV("DGENV")
   END IF
   
   CALL sadzp168_4(l_dzfi001, l_dzfi002, l_dgenv)
      RETURNING l_result, l_error_message
   
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN



