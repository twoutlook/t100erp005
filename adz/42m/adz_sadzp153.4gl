#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: adzp153
#+ Buildtype: 
#+ Memo.....: 產生參數作業

# Modify.........:2017/01/24 By jrg542 #170124-00020 #1 調整參數產生器 針對據點級參數做處理，只要有據點級參數，可以有切換營運據點的開窗 
IMPORT os
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"

#+ 檢核 gzsz016 是否存在scc 
PUBLIC FUNCTION sadzp153_chk_gzsz016(lc_gzsz016)
   DEFINE lc_gzsz016 LIKE gzsz_t.gzsz016
   DEFINE li_cnt     LIKE type_t.num5
   DEFINE li_chk     LIKE type_t.num5
   
   #LET li_chk = FALSE 
   SELECT COUNT(*) INTO li_cnt FROM gzca_t 
      WHERE gzca001 = lc_gzsz016

   IF li_cnt > 0 THEN
      RETURN TRUE  
   END IF   
   RETURN FALSE 
END FUNCTION 

#+ 取據點參數程式
PUBLIC FUNCTION sadzp153_get_gzsv001(ps_prog)
   DEFINE l_gzsv      DYNAMIC ARRAY OF STRING 
   DEFINE ls_sql      STRING 
   DEFINE ps_prog     STRING 
   DEFINE lc_gzsv001  LIKE gzsv_t.gzsv001

   LET ls_sql = "SELECT DISTINCT gzsv001 FROM gzsv_t WHERE SUBSTR(gzsv006,0,1) = 'S' AND gzsv001= '",ps_prog,"'"

   DECLARE sadzp153_get_gzsv001_cs CURSOR FROM ls_sql
   
   FOREACH sadzp153_get_gzsv001_cs INTO lc_gzsv001
      LET l_gzsv[l_gzsv.getLength()+1] = lc_gzsv001
      LET lc_gzsv001 = ""
   END FOREACH 

   RETURN l_gzsv
END FUNCTION 



