#+ 程式代碼......: adzp011
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp011.4gl
# Description    : 產生設計器專用的加密字串
# Memo           :
# Modify         : 2015/11/26 by Hiko : 新建程式

IMPORT os
IMPORT security
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

MAIN
   DEFINE l_eff_date DATE
   DEFINE l_src STRING,
          l_key STRING

   LET l_eff_date = DATE(ARG_VAL(2))
   LET l_src  = l_eff_date
   LET l_key = security.Base64.FromString(l_src)
   DISPLAY "l_key:",l_key
END MAIN
