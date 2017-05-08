#+ Version..: T100-ERP-1.00.00 Build-00001
#+
#+ Filename.: azzp888
#+ Buildtype: p01樣板自動產生
#+ Memo.....: 直接執行程式

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

MAIN
   DEFINE ls_cmd_prefix  STRING
   DEFINE ls_tmp         STRING
   DEFINE ls_cmd         STRING
   DEFINE lc_gzza001     LIKE gzza_t.gzza001
   DEFINE lc_gzza003     LIKE gzza_t.gzza003
   DEFINE li_lang        LIKE type_t.num5

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   LET g_bgjob = "Y"

   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")

   CASE g_argv[1]
      WHEN "act"   #抓取action
         LET ls_cmd_prefix = "r.r azzp195"
      WHEN "4tm"   #產生4tm / 4ad
         LET ls_cmd_prefix = "r.r azzp193"
      WHEN "42s"   #產生多語言
         LET ls_cmd_prefix = "r.r azzp191"
      OTHERWISE
         EXIT PROGRAM
   END CASE

   DECLARE azzp888_cs CURSOR FOR
    SELECT gzza001,gzza003 FROM gzza_t
     WHERE gzzastus = "Y"

   FOREACH azzp888_cs INTO lc_gzza001,lc_gzza003
      IF lc_gzza003 = "ADZ" OR lc_gzza003 = "AIT" THEN
         CONTINUE FOREACH
      END IF

      LET ls_tmp = ls_cmd_prefix," ",lc_gzza001
      IF g_argv[1] = "4tm" THEN
         LET ls_tmp = ls_tmp," 4tm"
      END IF
      
      FOR li_lang = 0 TO 2 STEP 2
         IF g_argv[1] = "act" AND li_lang <> 0 THEN
            CONTINUE FOR
         END IF
         LET ls_cmd = ls_tmp,li_lang
display 'command=',ls_cmd
         RUN ls_cmd
      END FOR
   END FOREACH

   CALL cl_ap_exitprogram("0")

END MAIN

