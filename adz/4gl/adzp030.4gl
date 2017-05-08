SCHEMA ds

MAIN

   DEFINE p_prog_id   STRING
   DEFINE p_prog_ver  STRING
   DEFINE p_dgenv     LIKE type_t.chr1
   DEFINE lc_dzaf001  LIKE dzaf_t.dzaf001  #規格代號
   DEFINE li_dzaf002  LIKE type_t.num5     #建構版號
   DEFINE lc_dzaf003  LIKE dzaf_t.dzaf003  #規格版號
   DEFINE lc_dzaf007  LIKE dzaf_t.dzaf007  #產品代號
   DEFINE li_repcomp  LIKE type_t.num5     #判斷是否為報表元件
   DEFINE lc_chr4     CHAR(4)
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ls_sql      STRING

   LET p_prog_id  = ARG_VAL(1) CLIPPED
   LET p_prog_ver = ARG_VAL(2) CLIPPED
   LET p_dgenv    = ARG_VAL(3) CLIPPED
   LET lc_dzaf007 = FGL_GETENV("ERPID")   #產品代號

   CALL cl_db_connect("ds",FALSE)
   LET lc_dzaf001 = p_prog_id

   #判斷是否為報表元件
   LET lc_chr4 = p_prog_id.subString(p_prog_id.getLength()-3,p_prog_id.getLength())
   IF lc_chr4[1,1] = "_" AND lc_chr4[2,2] MATCHES "[xg]" AND lc_chr4[3,3] MATCHES "[01-9]" AND
                                                             lc_chr4[4,4] MATCHES "[01-9]" THEN
      LET li_repcomp = TRUE
   ELSE
      LET li_repcomp = FALSE
   END IF

   #如果有輸入prog_ver 時,就一定要輸入 客製標示
   IF p_prog_ver IS NOT NULL THEN
      IF p_dgenv IS NULL THEN
         DISPLAY "ERROR: 如果有輸入prog_ver(第二參數) 時,就一定要輸入客製標示(第三參數)"
      END IF
   END IF

   #當沒有輸入 dgenv 時，查看該作業是否已經有存在客製版次資料,有就抓c, 沒有就抓s
   IF p_prog_ver IS NULL THEN
      SELECT COUNT(*) INTO li_cnt FROM dzaf_t
       WHERE dzaf001 = lc_dzaf001   #規格代號
         AND dzaf007 = lc_dzaf007   #產品代號
         AND dzaf010 = "c"          #識別標示
      IF li_cnt = 0 THEN
         LET p_dgenv = "s"
      ELSE
         LET p_dgenv = "c"
      END IF

      #抓取ALM最大設計版次
      LET ls_sql = "SELECT MAX(dzaf002) FROM dzaf_t ",
                   " WHERE dzaf001 = ? ",  #規格代號
                     " AND dzaf007 = ? ",  #產品代號
                     " AND dzaf010 = ? "   #識別標示
      PREPARE s1 FROM ls_sql
      EXECUTE s1 USING lc_dzaf001,lc_dzaf007,p_dgenv INTO li_dzaf002 

      IF NOT li_repcomp THEN
         #從最大設計版次決定規格版次
         SELECT dzaf003 INTO lc_dzaf003 FROM dzaf_t
          WHERE dzaf001 = lc_dzaf001   #規格代號
            AND dzaf002 = li_dzaf002
            AND dzaf007 = lc_dzaf007   #產品代號
#           AND dzaf008 = lc_dzaf008   #產品版本
            AND dzaf010 = p_dgenv      #識別標示
      ELSE
         #報表元件例外, 從最大程式版次決定規格版次
         SELECT dzaf004 INTO lc_dzaf003 FROM dzaf_t
          WHERE dzaf001 = lc_dzaf001   #規格代號
            AND dzaf002 = li_dzaf002
            AND dzaf007 = lc_dzaf007   #產品代號
#           AND dzaf008 = lc_dzaf008   #產品版本
            AND dzaf010 = p_dgenv      #識別標示
      END IF

      DISPLAY " INFO: 取得最大設計版次為:",li_dzaf002," 所屬規格版次為:",lc_dzaf003 ," 規格代號:",lc_dzaf001

      LET p_prog_ver  = lc_dzaf003
      DISPLAY " 未輸入版次, 依照ALM取出最新規格版次:",lc_dzaf003
   END IF

   IF sadzp030_tab_gen(p_prog_id,p_prog_ver,'',p_dgenv) THEN
   ELSE
      DISPLAY " 注意:回傳為FALSE"
   END IF
END MAIN


