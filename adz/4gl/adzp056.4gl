#+ 程式代碼......: adzp056
#+ 設計人員......: Hiko
# Prog. Version..: 
#
# Program name   : adzp056.4gl
# Description    : 寫入程式與函式關聯到資料庫
# Modify         : 20160615 160526-00022 by Hiko : 新建程式

import os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

MAIN
   DEFINE ls_code   STRING, #程式編號
          ls_source STRING, #來源程式完整路徑
          ls_target STRING  #解析函式後所產生的完整檔案路徑

   CALL cl_tool_init()

   LET ls_code = ARG_VAL(2)
   LET ls_source = ARG_VAL(3)
   LET ls_target = ARG_VAL(4)
   IF cl_null(ls_code) OR cl_null(ls_source) OR cl_null(ls_target) THEN
      DISPLAY cl_replace_err_msg(cl_getmsg("adz-00876", g_lang), "3") #執行此程式需要 %1 個參數!
   ELSE
      CALL adzp056_ins_dzbs(ls_code, ls_source, ls_target)
   END IF
END MAIN
{
PRIVATE FUNCTION adzp056_parse_4gl(p_code, p_source_file_path, p_target_file_path)
   DEFINE p_code             LIKE dzbs_t.dzbs001, #程式編號
          p_source_file_path STRING, #來源程式路徑,例如/u1/t10dit/erp/axm/4gl/axmt500.4gl
          p_target_file_path STRING  #目標程式路徑,例如/ut/t10dit/tmp/axmt500.func.temp
   #取得建構類型與對應模組:有客製就以客製為主.
   LET ls_sql_base = "SELECT distinct dzaf005,dzaf006 FROM dzaf_t WHERE dzaf001='",m_prog CLIPPED,"'"
   LET ls_sql_cond = " AND dzaf010='c'"
   LET ls_sql = ls_sql_base,ls_sql_cond
   PREPARE dzaf_prep1 FROM ls_sql
   EXECUTE dzaf_prep1 INTO l_cons_type,l_module
   FREE dzaf_prep1

   IF cl_null(l_cons_type) THEN #找不到客製再找標準.
      LET ls_sql_cond = " AND dzaf010='s'"
      LET ls_sql = ls_sql_base,ls_sql_cond
      PREPARE dzaf_prep2 FROM ls_sql
      EXECUTE dzaf_prep2 INTO l_cons_type,l_module
      FREE dzaf_prep2
   END IF 
   
   IF cl_null(l_cons_type) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00832" #找不到建構類型!
      LET g_errparam.popup = TRUE
      CALL cl_err() 
         
      RETURN NULL
   END IF
END FUNCTION
}
PRIVATE FUNCTION adzp056_ins_dzbs(p_code, p_source_file_path, p_target_file_path)
   DEFINE p_code             LIKE dzbs_t.dzbs001, #程式編號
          p_source_file_path STRING, #來源程式路徑,例如/u1/t10dit/erp/axm/4gl/axmt500.4gl
          p_target_file_path STRING  #目標程式路徑,例如/ut/t10dit/tmp/axmt500.func.temp
   DEFINE ls_cmd    STRING,
          lb_result BOOLEAN,
          ls_msg    STRING,
          lch_file  base.Channel,
          ls_line   STRING,
          ltok_line base.StringTokenizer,
          li_i      SMALLINT,
          l_dzbs001 LIKE dzbs_t.dzbs001,
          l_dzbs002 LIKE dzbs_t.dzbs002,
          l_dzbs003 LIKE dzbs_t.dzbs003,
          li_cnt    SMALLINT
          
   #先刪除目標檔案.
   CALL os.Path.delete(p_target_file_path) RETURNING lb_result #刪除失敗就算了.

   LET ls_cmd = "find_function.sh ",p_source_file_path," ",p_target_file_path
   CALL cl_cmdrun_openpipe("find_function.sh", ls_cmd, FALSE) RETURNING lb_result,ls_msg

   IF lb_result THEN
      #取得目標檔案, 將解析結果寫入dzbs_t內.
      TRY
         #先刪除資料庫的資料.
         DELETE FROM dzbs_t WHERE dzbs001=p_code

         LET lch_file = base.Channel.create()
         CALL lch_file.openFile(p_target_file_path, "r")

         WHILE TRUE
            LET ls_line = lch_file.readLine()
            IF lch_file.isEof() THEN
               EXIT WHILE
            END IF
         
            LET ltok_line = base.StringTokenizer.create(ls_line, ",")
            LET li_i = 1
            WHILE ltok_line.hasMoreTokens()
               CASE li_i
                  WHEN 1
                     LET l_dzbs001 = ltok_line.nextToken() #程式編號(等於p_code)
                  WHEN 2
                     LET l_dzbs002 = ltok_line.nextToken() #宣告函式名稱
                  WHEN 3
                     LET l_dzbs003 = ltok_line.nextToken() #使用函式名稱
               END CASE

               LET li_i = li_i + 1
            END WHILE

            #若發現所屬函式和目標函式相同, 表示這是遞迴呼叫, 就不要寫入dzbs_t.
            IF l_dzbs002<>l_dzbs003 THEN
               SELECT COUNT(*) INTO li_cnt FROM dzbs_t
                WHERE dzbs001=l_dzbs001 AND dzbs002=l_dzbs002 AND dzbs003=l_dzbs003
               IF li_cnt=0 THEN
                  INSERT INTO dzbs_t VALUES(l_dzbs001,l_dzbs002,l_dzbs003)
               END IF
            END IF
         END WHILE

         display "解析程式 ",p_source_file_path," 成功!"
      CATCH
         display "新增到資料庫失敗"
      END TRY
   ELSE
      display "解析程式 ",p_source_file_path," 過程失敗!"
   END IF
END FUNCTION
