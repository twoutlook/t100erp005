#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: adzp170
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp170.4gl 
# Description    : 解析4fd畫面成設計資料工具
# Memo           :

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

MAIN
   DEFINE l_result          BOOLEAN
   DEFINE l_node            om.DomNode            #4fd domNode

   DEFINE l_module          STRING                  #4fd所在模組
   DEFINE l_form_name       LIKE dzfi_t.dzfi001     #UI畫面代號
   DEFINE l_ver             LIKE dzfi_t.dzfi002     #規格版次
   DEFINE l_dgenv           LIKE dzfi_t.dzfi009     #使用標示:s-標準產品, c-客製
   DEFINE l_error_message   STRING
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("adz", "") #todo
   CALL cl_tool_init()

   #切換至使用者所需要的資料庫 (營運中心)  #todo
   CALL cl_db_connect("ds", FALSE)

   LET l_module = UPSHIFT(ARG_VAL(2))   # 4fd所在模組
   LET l_form_name = ARG_VAL(3)         # UI畫面代號  "demo"
   LET l_ver = ARG_VAL(4)               # 規格版次
   LET l_dgenv = ARG_VAL(5)             # 使用標示

   IF cl_null(l_dgenv) THEN
      LET l_dgenv = FGL_GETENV("DGENV")
   END IF
   
   #CALL adzp170("AIT", "aiti169", "1")
   CALL sadzp168_3(l_module, l_form_name, l_ver, l_dgenv)
      RETURNING l_result, l_error_message

   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN



