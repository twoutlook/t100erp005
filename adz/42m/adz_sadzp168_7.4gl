#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: sadzp168_7
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp168_7.4gl 
# Description    : 依照版次 批次重新產生4fd畫面檔和解析設計資料
# Memo           :

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"

GLOBALS
   DEFINE g_gen42s_flag     LIKE type_t.chr1
END GLOBALS

DEFINE g_error_message       STRING                  #錯誤訊息

PRIVATE FUNCTION sadzp168_7_init(p_file)
   DEFINE p_file            STRING
   DEFINE l_sql             STRING
   DEFINE l_wc              STRING
   DEFINE l_file            STRING
   
   LET g_rtn_msg = TRUE
   
   CREATE TEMP TABLE form_batchlist(
      dzfk001        VARCHAR(20)
   ) 
 
   LET g_gen42s_flag = FALSE
 
   LET l_file = p_file.trim()
   #LOAD FROM "/u3/usr/saki/batch/batchlist.txt" "INSERT INTO form_batchlist "
   LOAD FROM l_file "INSERT INTO form_batchlist "

   #取得節點下各子節點畫面結構資訊
   LET l_sql = "SELECT DISTINCT dzfk001 FROM form_batchlist ",
               "  WHERE 1=1 ",
               "  ORDER BY dzfk001 "
               
   #LET l_wc = "dzfk001 like 'aiti553%'"
   #LET l_sql = cl_str_replace(l_sql, "1=1", l_wc)
   
   PREPARE sadzp168_7_dzfq_pre FROM l_sql
   DECLARE sadzp168_7_dzfq_cs CURSOR WITH HOLD FOR sadzp168_7_dzfq_pre
                
END FUNCTION

PUBLIC FUNCTION sadzp168_7(p_file)
   DEFINE p_file                 STRING
   DEFINE l_dzfq004              LIKE dzfq_t.dzfq004     #畫面代號
   DEFINE l_dzfq005              LIKE dzfq_t.dzfq005     #畫面類別
   DEFINE l_channel              base.Channel
   DEFINE l_file                 STRING
   DEFINE l_str                  STRING
   DEFINE l_result               LIKE type_t.chr1
   DEFINE l_error_message        STRING
   DEFINE l_gzza002              LIKE gzza_t.gzza002     #程式類別
   DEFINE l_gzza003              LIKE gzza_t.gzza003     #模組代碼
   DEFINE l_gzzal003             LIKE gzzal_t.gzzal003   #程式名稱
   DEFINE l_gzza003_module       LIKE gzza_t.gzza003     #模組代碼
   DEFINE l_spec_ver             LIKE dzaf_t.dzaf003     #規格版次
   DEFINE l_spec_ide             LIKE dzaf_t.dzaf010     #識別標示
   DEFINE ls_err_msg             STRING
   DEFINE l_4fd_path             STRING
   DEFINE l_old_name             STRING                  #原有4fd檔名稱會改成,例:aooi001.4fd改成aooi001.4fd.bak.20140704
   DEFINE l_new_name             STRING                  #4fd檔正確名稱:aooi001.4fd
   DEFINE l_i                    LIKE type_t.num5
   DEFINE l_cnt                  LIKE type_t.num5

   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   CALL sadzp168_7_init(p_file)
   LET l_i = 1

   SELECT COUNT(*) INTO l_cnt FROM form_batchlist
   DISPLAY "batchlist count:", l_cnt
   IF l_cnt = 0 THEN
      DISPLAY "count = 0"
      RETURN
   END IF
   
   LET l_file = "regen4fd-", FGL_GETENV("ZONE"), "-", TODAY USING 'YYYYMMDD', ".log"
   #LET l_file = os.Path.join("/u3/usr/saki/batch", l_file) 
   LET l_file = os.Path.join(os.Path.homedir(), os.Path.join("batch",l_file))
   #LET l_file = os.Path.join("/u3/usr/jay", l_file) 
   LET l_channel = base.Channel.create()
   CALL l_channel.openFile(l_file, "a")

   CALL l_channel.setDelimiter("")
   LET l_str = "#--------------------------- (", cl_get_current(), ") ------------------------#"
   CALL l_channel.write(l_str)
   CALL l_channel.write("")


   
   #取得設計資料裡所有的畫面代碼
   FOREACH sadzp168_7_dzfq_cs INTO l_dzfq004
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-FOREACH sadzp168_7_dzfq_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         EXIT FOREACH
      END IF

      CALL l_channel.write("")
      LET l_str = l_i USING "<<<<<", ". ", l_dzfq004 CLIPPED
      CALL l_channel.write(l_str)

      LET l_i = l_i + 1

      #取得畫面所屬類別(M:主程式畫面, S:子程式畫面, F:子畫面)
      LET l_dzfq005 = cl_chk_spec_type(l_dzfq004) 
      
      IF l_dzfq005 = "N" THEN
         LET l_str = "    ", "ERROR:", cl_getmsg_parm("adz-00495", g_lang, l_dzfq004)
         CALL l_channel.write(l_str)
         CALL l_channel.write("")
         CONTINUE FOREACH
      END IF
      
      ##取得畫面模組代碼
      #CALL sadzp168_1_gzza002(l_dzfq004, l_dzfq005) 
      #   RETURNING l_gzza002, l_gzza003, l_gzza003_module, l_gzzal003
      
      CALL cl_adz_find_module(l_dzfq004, l_dzfq005)
         RETURNING l_gzza003_module

      #指定4fd 所在模組
      LET g_gzza003_module = l_gzza003_module

      IF g_gzza003_module IS NULL THEN
         LET l_str = "    ", "ERROR:", cl_getmsg("adz-00012", g_lang)
         CALL l_channel.write(l_str)
         CALL l_channel.write("")
         CONTINUE FOREACH
      END IF
      
      #取得程式碼版次及客製標示識別
      CALL cl_adz_get_spec_curr_revision(l_dzfq004, NULL, l_dzfq005)
         RETURNING l_spec_ver, l_spec_ide, ls_err_msg

      IF NOT cl_null(ls_err_msg) THEN
         LET l_str = "    ", "ERROR-", l_dzfq004 CLIPPED, ":", cl_getmsg_parm("adz-00303", g_lang, l_dzfq004), ". ", ls_err_msg.trim()
         CALL l_channel.write(l_str)
         CALL l_channel.write("")
         CONTINUE FOREACH
      END IF

      ##先編譯看看原本是不是就可以編譯成功
      #IF NOT sadzp168_2_compile_file(l_gzza003_module, l_dzfq004, TRUE) THEN
      #   LET l_str = "    ", "ERROR-", l_dzfq004 CLIPPED, ":原編譯就失敗. ", ASCII 10, g_error_message.trim()
      #   CALL l_channel.write(l_str)
      #   CALL l_channel.write("")
      #   #CONTINUE FOREACH
      #END IF
      
      #檢查原4fd file是否存在,存在mv .bak
      LET l_4fd_path = os.Path.join(FGL_GETENV(UPSHIFT(l_gzza003_module)), "4fd")
      
      LET l_old_name = l_dzfq004 CLIPPED, ".4fd.", TODAY USING 'YYMMDD'
      LET l_new_name = l_dzfq004 CLIPPED, ".4fd"
      
      LET l_old_name = os.Path.join(l_4fd_path, l_old_name)
      LET l_new_name = os.Path.join(l_4fd_path, l_new_name)
      
      IF os.Path.EXISTS(l_new_name) THEN
         IF os.Path.delete(l_old_name) THEN END IF

         #將原4fd檔備份
         IF NOT os.Path.rename(l_new_name, l_old_name) THEN
             LET l_str = "    ", "Warn:目的備份檔案:",l_new_name.trim()," 失敗!"
             CALL l_channel.write(l_str)
         END IF
      END IF
      
      #依目前版次重組4fd,產生4fd file
      LET l_str = "    ", "sadzp168_5(", l_dzfq004 CLIPPED, ", ", l_spec_ver USING "<<<<<", ", ", l_spec_ide CLIPPED, ")"
      CALL l_channel.write(l_str)
      
      CALL sadzp168_5(l_dzfq004, l_spec_ver, l_spec_ide, TRUE)
         RETURNING l_result, l_error_message

      IF NOT l_result THEN
         LET l_str = "    ", l_dzfq004 CLIPPED, "-", l_error_message 
         CALL l_channel.write(l_str)
         CALL l_channel.write("")
         CONTINUE FOREACH
      END IF

      LET l_str = "    ", l_dzfq004 CLIPPED, " is success."
      CALL l_channel.write(l_str)
      CALL l_channel.write("")
      DISPLAY ""
   END FOREACH

   LET l_str = "#--------------------------- (", cl_get_current(), ") -----------end----------#"
   CALL l_channel.write(l_str)
   CALL l_channel.write("")
   CALL l_channel.write("")
   CALL l_channel.close()
END FUNCTION


