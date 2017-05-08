#+ 程式代碼......: adzp144
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp144.4gl
# Description    : 依據表格代號設定程式重產標示
# Modify         : 2015/11/09 by Hiko : 新建程式

SCHEMA ds
GLOBALS "../../cfg/top_global.inc"

MAIN
   CALL cl_tool_init()
   CALL sadzp060_2_need_regen(ARG_VAL(2))
END MAIN
