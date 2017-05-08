#+ 程式版本......: T6 Version 1.00.00 Build-0009 at 13/03/18
#
#+ 程式代碼......: adzp062
#+ 設計人員......: Hiko
#+ 功能名稱說明...:刪除第一版次程式設計資料(for 設計器呼叫)
#+ 修改歷程......: 2014/10/27 by Hiko : 建立程式
#+               : 20150414 by Hiko : 調整詢問視窗(cl_ask_confirm_parm改成cl_ask_confirm)
#+               : 2015/12/10 by Hiko : 刪除第一版次之後要將重產flag更新為Y.

IMPORT os
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"

MAIN
   DEFINE l_prog     LIKE dzaf_t.dzaf001, #程式代號
          l_ver      LIKE dzaf_t.dzaf004, #程式版次
          ls_kind    STRING,              #類型(SD/PR):目前沒有使用
          l_type     LIKE dzaf_t.dzaf005, #建構類型
          l_identity LIKE dzaf_t.dzaf010  #客製
   DEFINE lb_result  BOOLEAN,
          ls_err_msg STRING,
          l_cnt      SMALLINT,
          l_max_ver  LIKE dzba_t.dzba002, #最大程式版次
          lb_upd_dzax BOOLEAN,
          lb_intrans  BOOLEAN #是否已經進入Transaction
   
   CALL cl_tool_init()   

   LET l_prog = ARG_VAL(2) CLIPPED
   LET l_ver = ARG_VAL(3) CLIPPED
   LET ls_kind = ARG_VAL(4) CLIPPED
   LET l_type = ARG_VAL(5) CLIPPED
   LET l_identity = ARG_VAL(6) CLIPPED

   LET lb_upd_dzax = FALSE
   LET lb_intrans = FALSE

   TRY
      IF NUM_ARGS() > 1 THEN #確認是否背景執行
         IF NOT cl_null(l_prog) AND NOT cl_null(l_ver) AND NOT cl_null(ls_kind) AND NOT cl_null(l_type) AND NOT cl_null(l_identity) THEN
            #check有沒有傳入參數,如果有,表示透過設計器呼叫的
            DISPLAY "adzp062:arg2 l_prog=",l_prog
            DISPLAY "adzp062:arg3 l_ver=",l_ver
            DISPLAY "adzp062:arg4 ls_kind=",ls_kind
            DISPLAY "adzp062:arg5 l_type=",l_type
            DISPLAY "adzp062:arg6 l_identity=",l_identity
            DISPLAY "adzp062:g_user=",g_user
          
            #先檢查權限
            CALL sadzp060_2_have_checked_out(l_prog, l_type, "PR", 1) RETURNING ls_err_msg
            IF NOT cl_null(ls_err_msg) THEN #沒有權限就離開
               CALL cl_ap_exitprogram("0")
            END IF
 
            IF cl_ask_confirm("adz-00160") THEN  #友善提醒 : 此動作會將程式版次1所對應的設計資料全部清空, 請問是否真的要執行? 
               #WHERE條件的依據:
               #1.新建的標準程式和客製程式的程式版次都是1
               #2.標準轉客製簽出程式一開始就是2
               #3.標準轉客製是簽出規格(2),此時客製程式版次為1,再簽出程式的時候,版次就變成2
               #結論:所以只判斷版次是正確的
               SELECT COUNT(*) INTO l_cnt FROM dzaf_t WHERE dzaf001=l_prog AND dzaf004 IS NOT NULL
               SELECT MAX(dzaf004) INTO l_max_ver FROM dzaf_t WHERE dzaf001=l_prog
               IF l_cnt<>1 OR l_max_ver<>1 THEN #程式版次不是1的資料不允許刪除
                  CALL cl_ask_pressanykey("adz-00074") #友善提醒 : 系統僅支援刪除版次1(且只有版次1)的設計資料
               ELSE
                  #若已經是FreeStyle,則程式會產生不出來,所以要特別提醒.     
                  CALL sadzp169_02_chk_not_free_style(l_prog, l_identity) RETURNING lb_result,ls_err_msg
                  IF NOT lb_result THEN
                     IF cl_ask_confirm("adz-00416") THEN
                        LET lb_upd_dzax = TRUE
                     ELSE
                        CALL cl_ap_exitprogram("0")
                     END IF
                  END IF

                  BEGIN WORK
                  LET lb_intrans = TRUE #這是為了CATCH的時候使用

                  IF lb_upd_dzax THEN
                     UPDATE dzax_t SET dzax003='N',dzax004='Y' WHERE dzax001=l_prog AND dzax006=l_identity
                  END IF
                  DISPLAY "DELETE CODE TREE..." #實際上是不用判斷版次和客製標示,但為了防呆,還是判斷一下比較安全.
                  DISPLAY "delete dzba_t"
                  DELETE FROM dzba_t WHERE dzba001=l_prog AND dzba002=1 AND dzba010=l_identity
                  DISPLAY "delete dzbb_t"
                  DELETE FROM dzbb_t WHERE dzbb001=l_prog AND dzbb003=1 AND dzbb004=l_identity
                  DISPLAY "DELETE SECTION TREE..."
                  DISPLAY "delete dzbc_t"
                  DELETE FROM dzbc_t WHERE dzbc001=l_prog AND dzbc002=1 AND dzbc007=l_identity
                  DISPLAY "delete dzbd_t"
                  DELETE FROM dzbd_t WHERE dzbd001=l_prog #SECTION因為和add point架構上不同,所以就全部刪除即可.
                  COMMIT WORK
      
                  CALL cl_ask_pressanykey("adz-00294")  #設計資料刪除成功

                  CALL sadzp060_2_set_regen(l_prog, "Y") #2015/12/10 by Hiko:重產flag更新為Y.
               END IF

               CALL cl_ap_exitprogram("0")
            END IF
         ELSE
           DISPLAY "\nUsage: r.r adzp062 prog revision kind type identity","\n   Ex: r.r adzp062 aiti004 1 CODE M s"
         END IF
      
         #離開作業
         CALL cl_ap_exitprogram("0")
      END IF
   CATCH
      IF lb_intrans THEN
         ROLLBACK WORK
      END IF
      CALL cl_ask_pressanykey("adz-00218") #執行失敗
      CALL cl_ap_exitprogram("0")
   END TRY
END MAIN
