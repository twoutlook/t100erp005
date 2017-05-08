#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: adzp179
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp179.4gl 
# Description    : 比對新/舊版畫面設計資料的Patch工具
# Memo           :

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

MAIN
   DEFINE l_gzzb001           LIKE gzzb_t.gzzb001     #行業畫面代碼
   DEFINE l_dzfi002_is        LIKE dzfi_t.dzfi002     #行業畫面最大版次
   DEFINE l_gzzb003           LIKE gzzb_t.gzzb003     #[引用]的[標準畫面]代碼
   DEFINE l_dzfi002_sd        LIKE dzfi_t.dzfi002     #[引用]的[標準畫面]最大版次
   DEFINE l_result            LIKE type_t.chr1
   DEFINE l_error_message     STRING
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
   CALL cl_tool_init()

   #切換至使用者所需要的資料庫 (營運中心) 
   CALL cl_db_connect("ds", FALSE)

   LET l_gzzb001 = ARG_VAL(2)   #需比對的UI畫面代號 "demo"
   LET l_dzfi002_is = ARG_VAL(3)
   LET l_gzzb003 = ARG_VAL(4)
   LET l_dzfi002_sd = ARG_VAL(5)

   CALL sadzp168_8(l_gzzb001, l_dzfi002_is, l_gzzb003, l_dzfi002_sd)
      RETURNING l_result, l_error_message

   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN


