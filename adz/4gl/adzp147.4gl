#+ 程式代碼......: adzp147
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
# Program name   : adzp147.4gl
# Description    : 程式重新產生作業
# Modify         : 2015/11/09 by Hiko : 新建程式
#                  20170116 170116-00019 by madey :檢查權限由sadzp060_2_chk_permission改成sadzp060_2_have_checked_out

import os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/adzp080_type.inc"

MAIN
   DEFINE ls_prog      STRING, #程式代號
          ls_construct STRING, #建構類型
          ls_module    STRING  #模組別
   DEFINE lo_upload_param T_UPLOAD_PARAM,
          ls_tap_dir      STRING
   DEFINE lo_dzaf_t   T_DZAF_T,
          ls_err_msg  STRING,
          lb_result   BOOLEAN 
             
   LET ls_prog = ARG_VAL(2)
   LET ls_construct = ARG_VAL(3)
   LET ls_module = ARG_VAL(4)
   DISPLAY "adzp147 regen..."
   DISPLAY "ls_prog = ",ls_prog
   DISPLAY "ls_construct = ",ls_construct
   DISPLAY "ls_module = ",ls_module

   CALL cl_tool_init()

   CALL cl_progress_bar(3)

  ##重產前先檢查是否有權限:直接以Server端的tap來判斷即可.
   CALL cl_progress_ing("check permission...")
  #Begin :170116-00019 modify
  #檢查權限由sadzp060_2_chk_permission改成sadzp060_2_have_checked_out(因為chk_permission是參考server端模組下的tap檔，若首次簽出且下載沒報錯，但需要用此功能重產時，檢查模組下的tap不準,模組下的tap是上傳程式才會被更新為最新的)
  #LET ls_tap_dir= os.path.join(os.path.join(FGL_GETENV(ls_module), "dzx"), "tap")
  #CALL sadzp060_2_chk_permission(ls_prog, ls_tap_dir, "CODE") RETURNING lo_upload_param.*,ls_err_msg
   CALL sadzp060_2_have_checked_out(ls_prog,ls_construct,'PR',0) RETURNING ls_err_msg
  #End: 170116-00019 modify 
   IF cl_null(ls_err_msg) THEN
      #原本希望透過lo_upload_param來組合dzaf_t,但少了建構版次(dzaf002)的資訊,所以作罷.
      CALL cl_progress_ing("get current version...")
      CALL sadzp060_2_get_curr_ver_info(ls_prog, ls_construct, ls_module) RETURNING lo_dzaf_t.*,ls_err_msg
      IF cl_null(ls_err_msg) THEN
         CALL cl_progress_ing("gen tab and r.c3...")
         CALL sadzp060_2_rc3(ls_prog, lo_dzaf_t.*, '0') RETURNING lb_result,ls_err_msg
         IF NOT lb_result THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "adz-00128" #呼叫r.c3產生4gl及tgl時發生錯誤.
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
         ELSE
            #重產完畢要再度提醒.
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "adz-00736" #程式%1已經重產完畢,請下載程式繼續編輯..
            LET g_errparam.extend = ""
            LET g_errparam.replace[1] = ls_prog
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      ELSE
         INITIALIZE g_errparam TO NULL
         IF lo_dzaf_t.dzaf010="s" THEN
            LET g_errparam.code = "adz-00295" #取得標準版次失敗.
         ELSE
            LET g_errparam.code = "adz-00296" #取得客製版次失敗.
         END IF
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "!"
      LET g_errparam.extend = ls_err_msg
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
END MAIN
