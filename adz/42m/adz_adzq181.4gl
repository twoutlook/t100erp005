#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: adzq181
#+ Buildtype: 
 
IMPORT os
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"

DEFINE ms_prog DYNAMIC ARRAY OF RECORD
          gzza001 LIKE gzza_t.gzza001,
          type    LIKE type_t.num5
                  END RECORD

MAIN
   CALL cl_tool_init()
   CALL azzq181_qry_freestyle()
   CALL azzq181_qry_section()
   CALL azzq181_result()
END MAIN

PRIVATE FUNCTION azzq181_result()

   DEFINE ls_sql     STRING
   DEFINE li_cnt     LIKE type_t.num5
   DEFINE li_pos     LIKE type_t.num5
   DEFINE lc_gzzal003 LIKE gzzal_t.gzzal003
   DEFINE li_cnt1    LIKE type_t.num5

   LET ls_sql = "SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='zh_TW'"
   PREPARE azzq181_result_cs FROM ls_sql

   DISPLAY " "
   DISPLAY "改成 FREE STYLE 又改 SECTION 的清單"
   LET li_cnt = 1
   FOR li_pos = 1 TO ms_prog.getLength()
      IF ms_prog[li_pos].type = "3" THEN
         EXECUTE azzq181_result_cs USING ms_prog[li_pos].gzza001 INTO lc_gzzal003
         DISPLAY li_cnt," ",ms_prog[li_pos].gzza001," (",lc_gzzal003 CLIPPED,")"
         LET li_cnt = li_cnt + 1
      END IF
   END FOR
   DISPLAY "計",li_cnt,"筆" DISPLAY " "
   LET li_cnt1 = li_cnt
 
   DISPLAY "改成 FREE STYLE 的清單"
   LET li_cnt = 1
   FOR li_pos = 1 TO ms_prog.getLength()
      IF ms_prog[li_pos].type = "1" THEN
         EXECUTE azzq181_result_cs USING ms_prog[li_pos].gzza001 INTO lc_gzzal003
         DISPLAY li_cnt," ",ms_prog[li_pos].gzza001," (",lc_gzzal003 CLIPPED,")"
         LET li_cnt = li_cnt + 1
      END IF
   END FOR
   DISPLAY "計",li_cnt,"筆 (共計:",li_cnt+li_cnt1,"筆) "  DISPLAY " "

   DISPLAY "改 SECTION 的清單"
   LET li_cnt = 1
   FOR li_pos = 1 TO ms_prog.getLength()
      IF ms_prog[li_pos].type = "2" THEN
         EXECUTE azzq181_result_cs USING ms_prog[li_pos].gzza001 INTO lc_gzzal003
         DISPLAY li_cnt," ",ms_prog[li_pos].gzza001," (",lc_gzzal003 CLIPPED,")"
         LET li_cnt = li_cnt + 1
      END IF
   END FOR
   DISPLAY "計",li_cnt,"筆 (共計:",li_cnt+li_cnt1,"筆) "  DISPLAY " "

END FUNCTION


PRIVATE FUNCTION azzq181_qry_section()

   DEFINE ls_sql        STRING
   DEFINE lc_dzbc001    LIKE dzbc_t.dzbc001
   DEFINE li_cnt        LIKE type_t.num5

   LET ls_sql = " SELECT unique dzbc001 FROM dzbc_t,gzza_t ",
                 " WHERE dzbc005 = 'm' ",
                   " AND dzbc001 NOT LIKE 'ait%' AND gzza001 = dzbc001 ",
                " ORDER BY dzbc001"
   DECLARE adzq181_cs CURSOR FROM ls_sql

   FOREACH adzq181_cs INTO lc_dzbc001
      FOR li_cnt = 1 TO ms_prog.getLength()
         IF lc_dzbc001 = ms_prog[li_cnt].gzza001 THEN
            LET ms_prog[li_cnt].type = 3
            CONTINUE FOREACH
         END IF
      END FOR
      LET li_cnt = ms_prog.getLength()+1
      LET ms_prog[li_cnt].gzza001 = lc_dzbc001
      LET ms_prog[li_cnt].type = 2
   END FOREACH

END FUNCTION
 

PRIVATE FUNCTION azzq181_qry_freestyle()

   DEFINE ls_sql        STRING
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE lc_dzbc001    LIKE dzbc_t.dzbc001

   LET ls_sql = "SELECT dzax001 FROM dzax_t,gzza_t ",
                " WHERE dzax003 = 'Y' ",
                  " AND dzax001 NOT LIKE 'ait%' AND gzza001=dzax001 ",
                " ORDER BY dzax001"
   DECLARE adzq181_1_cs CURSOR FROM ls_sql

   FOREACH adzq181_1_cs INTO lc_dzbc001
      IF ms_prog.getLength() >= 1 THEN
         FOR li_cnt = 1 TO ms_prog.getLength()
            IF lc_dzbc001 = ms_prog[li_cnt].gzza001 THEN
               LET ms_prog[li_cnt].type = 3
               CONTINUE FOREACH
            END IF
         END FOR
      END IF
      LET li_cnt = ms_prog.getLength()+1
      LET ms_prog[li_cnt].gzza001 = lc_dzbc001
      LET ms_prog[li_cnt].type = 1
   END FOREACH

END FUNCTION
 
