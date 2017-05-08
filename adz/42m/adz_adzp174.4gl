#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: sadzp168_7
#+ Buildtype: p01樣板自動產生
#+ Memo.....: 依照版次 批次重新產生4fd畫面檔和解析設計資料

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"

GLOBALS
   
END GLOBALS

MAIN
   DEFINE l_result          BOOLEAN
   DEFINE l_node            om.DomNode            #4fd domNode

   DEFINE l_module          STRING                  #4fd所在模組
   DEFINE l_form_name       STRING                  #UI畫面代號
   DEFINE l_dzfi001         LIKE dzfi_t.dzfi001     #畫面代號
   DEFINE l_dzfi002         LIKE dzfi_t.dzfi002     #規格版本
   DEFINE l_dgenv           LIKE dzfi_t.dzfi009     #識別標示
   DEFINE l_error_message   STRING
   DEFINE l_file            STRING
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("adz", "") #todo
   CALL cl_tool_init()

   #切換至使用者所需要的資料庫 (營運中心)  #todo
   CALL cl_db_connect("ds", FALSE)
   
   LET l_file = ARG_VAL(2)
   CALL sadzp168_7(l_file)
   
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN


