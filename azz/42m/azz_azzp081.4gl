#+ Version..: T100-ERP-1.00.00 Build-00001
#+
#+ Filename.: azzp081
#+ Buildtype: p01樣板自動產生
#+ Memo.....: 每日未完成項目自動產出工具

SCHEMA ds

MAIN
   DEFINE lc_gzry  RECORD LIKE gzry_t.*

   CONNECT TO "ds"

   DECLARE azzp081_cs CURSOR FOR
    SELECT * FROM gzry_t
     WHERE gzry004 <> "Y" AND gzry006 <> "tiptop"
     ORDER BY gzry006 ASC,gzry014 DESC,gzry009 ASC
   FOREACH azzp081_cs INTO lc_gzry.*

      display lc_gzry.gzry006
      display "緊急度:",lc_gzry.gzry014 USING "&"," 分(5分為最緊急)"
      display "工作項目:",lc_gzry.gzry001,"(",lc_gzry.gzry003 CLIPPED,")"
      display "內容說明:"
      display lc_gzry.gzry005
      display "預計開工日期:",lc_gzry.gzry009
      display "預估時數:",lc_gzry.gzry010 USING "##&.&&" ,"hr(s)"
      display "---------------------------------------------------------"

   END FOREACH

END MAIN
