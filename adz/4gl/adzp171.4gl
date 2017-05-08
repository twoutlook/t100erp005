#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 13/01/15
#
#+ 程式代碼......: adzp171
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp171.4gl 
# Description    : 重組設計資料成4fd畫面工具
# Memo           :
#測試使用dzfi_t, dzfj_t table產生4fd,應該要以adzp171-130201.4gl版本為主
#+ 修改歷程......: 2015/05/22 by madey : 沒給版次及使用標示時，自動抓目前dzaf

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp200_type.inc"

MAIN
   DEFINE l_dzfi001           LIKE dzfi_t.dzfi001     #結構代號
   DEFINE l_dzfi002           LIKE dzfi_t.dzfi002     #版次
   DEFINE l_dgenv             LIKE dzfi_t.dzfi009     #使用標示:s-標準產品, c-客製
   DEFINE l_result            LIKE type_t.chr1
   DEFINE l_error_message     STRING
   DEFINE lo_DZAF_T T_DZAF_T  #dzaf物件 20150522
   DEFINE l_type              STRING #建構類型 20150522 
   
   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("adz", "")
   CALL cl_tool_init()

   #切換至使用者所需要的資料庫 (營運中心)
   CALL cl_db_connect("ds", FALSE)

   LET l_dzfi001 = ARG_VAL(2)   #畫面結構代號
   LET l_dzfi002 = ARG_VAL(3)   #規格版次
   LET l_dgenv = ARG_VAL(4)     #使用標示:s-標準產品, c-客製

   #20150522 -Begin-
   IF cl_null(l_dzfi002) AND cl_null(l_dgenv) THEN
      DISPLAY "Info:未指定版次及使用標示，自動抓目前該程式最新狀態"
      LET l_type = sadzp060_2_chk_spec_type(l_dzfi001) 
      IF l_type="N" THEN
         LET l_error_message = "ERROR:程式",l_dzfi001,"取得建構類型錯誤"
         DISPLAY l_error_message
         GOTO _RTN
      ELSE
          CALL sadzp060_2_get_curr_ver_info(l_dzfi001, l_type, NULL) RETURNING lo_DZAF_T.*,l_error_message
          IF NOT cl_null(l_error_message) THEN
             LET l_error_message = "ERROR:程式",l_dzfi001,"取得版次資料錯誤:",l_error_message
             DISPLAY l_error_message
             GOTO _RTN
          ELSE
             DISPLAY "revision:(",lo_DZAF_T.dzaf003 USING "<<<" ,",",lo_DZAF_T.dzaf010 ,")"
             LET l_dzfi002 = lo_DZAF_T.dzaf003 CLIPPED
             LET l_dgenv = lo_DZAF_T.dzaf010 CLIPPED
          END IF
      END IF
   END IF
   #20150522 -End-

   CALL sadzp168_5(l_dzfi001, l_dzfi002, l_dgenv, TRUE) 
      RETURNING l_result, l_error_message
      
 LABEL _RTN:
   #離開作業
   CALL cl_ap_exitprogram("0")

END MAIN

