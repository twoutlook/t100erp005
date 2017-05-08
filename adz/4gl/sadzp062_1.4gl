#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 14/02/20
#
#+ 程式代碼......: sadzp062_1
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp062_1.4gl
# Description    : 和模組相關的功能
# Modify         : 2014/11/21 by Hiko : 將刪除等功能移到sadzp063_1處理
#                  2015/07/01 by madey: sadzp062_1_find_module增加Q類(hard code qry) 
#                  20160307 160226-00010 by Hiko : 將sadzp062_1_find_module內屬於歸屬模組的程式段變成單獨的FUNCTION.
#                : 20160429 160429-00009 by Hiko : 增加依據程式代號取得版次資訊的功能:sadzp062_1_get_curr_dzaf

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp200_type.inc"

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 取得程式歸屬模組別
# Input parameter : p_prog 程式代號
#                 : p_type 類型
# Return code     : STRING 模組代號
# Date & Author   : 160226-00010 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp062_1_find_belong_module(p_prog, p_type)
   DEFINE p_prog    LIKE gzde_t.gzde001,
          p_type    LIKE gzde_t.gzde003
   DEFINE l_gzza003 LIKE gzza_t.gzza003, #歸屬模組
          l_gzza011 LIKE gzza_t.gzza011, #是否客製
          l_gzzj001 LIKE gzzj_t.gzzj001, #實際模組
          ls_sql    STRING,
          l_cnt     LIKE type_t.num5

   #尋找模組的sql
   CASE 
      WHEN p_type="M"
         #資料來源作業azzi900
         LET ls_sql = "SELECT gzza003,gzza011",
                      " FROM gzza_t",
                      " WHERE gzza001='",p_prog,"'"
      WHEN p_type MATCHES "[SBGXW]"
         #資料來源作業azzi901
         LET ls_sql = "SELECT gzde002,gzde008",
                      " FROM gzde_t",
                      " WHERE gzde001='",p_prog,"'"
      WHEN p_type="F"
         #尋找子程式的子畫面有無資料存在
         SELECT COUNT(*) INTO l_cnt 
            FROM gzde_t
            LEFT JOIN gzdf_t ON gzde001=gzdf001
            WHERE gzdf002= p_prog

         IF l_cnt >0 THEN 
            #資料來源作業azzi901_代表子程式的子畫面
            LET ls_sql = "SELECT DISTINCT gzde002,gzdf003",
                         " FROM gzde_t",
                         " LEFT JOIN gzdf_t ON gzde001=gzdf001 ",
                         " WHERE gzdf002='",p_prog,"'"
         ELSE
            #資料來源作業azzi900_代表主程式的子畫面
            LET ls_sql = "SELECT DISTINCT gzza003,gzdf003",
                         " FROM gzza_t",
                         " LEFT JOIN gzdf_t ON gzza001=gzdf001 ",
                         " WHERE gzdf002='",p_prog,"'"  
         END IF
      WHEN p_type="Z"
         #資料來源作業azzi700
         LET ls_sql = "SELECT gzja002,gzja005",
                      " FROM gzja_t",
                      " WHERE gzja001='",p_prog,"'"

      #20150701 -Begin-
      WHEN p_type="Q"
         #資料來源作業adzi210 (r.q)
         LET ls_sql = "SELECT DISTINCT 'QRY',                                                        ",
                      "              CASE                                                            ",
                      "                WHEN EXISTS (SELECT 1                                         ",
                      "                        FROM dzca_t ca2                                       ",
                      "                       WHERE ca2.dzca001 = ca1.dzca001                        ",
                      "                         AND ca2.dzca002 = 'c') THEN                          ",
                      "                 'c'                                                          ",
                      "                ELSE                                                          ",
                      "                 's'                                                          ",
                      "              END AS dzca002_1                                                ",
                      " FROM (SELECT dzca001, dzca002 FROM dzca_t WHERE dzca001 ='",p_prog,"') ca1   "

      OTHERWISE 
           DISPLAY "error: module type undefine:",p_type
      #20150701 -End-
   END CASE
   
   TRY
      PREPARE gzza_prep FROM ls_sql
      EXECUTE gzza_prep INTO l_gzza003,l_gzza011
      FREE gzza_prep
   CATCH
      DISPLAY "ERROR:sadzp062_1_find_belong_module:ls_sql=",ls_sql
   END TRY
   
   RETURN l_gzza003 CLIPPED,l_gzza011 CLIPPED
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 取得程式模組別
# Input parameter : p_prog 程式代號
#                 : p_type 類型
# Return code     : STRING 模組代號
# Date & Author   : 2014/06/04 by madey
##########################################################################
PUBLIC FUNCTION sadzp062_1_find_module(p_prog,p_type)
   DEFINE p_prog    LIKE gzde_t.gzde001,
          p_type    LIKE gzde_t.gzde003,
          l_gzza003 LIKE gzza_t.gzza003, #歸屬模組
          l_gzza011 LIKE gzza_t.gzza011  #是否客製

   CALL sadzp062_1_find_belong_module(p_prog, p_type) RETURNING l_gzza003,l_gzza011 #160226-00010

   #若註冊資訊為客製,需透過gzzj_t找到實際的模組別,以AZZ為例:
   #若歸屬模組(gzzj003)相等, 但!= 實際模組(gzzj001)的話, 表示是AZZ-->CZZ ,否則用原本模組就好(CZZ)
   IF l_gzza011 = "Y" OR l_gzza011 = "c" THEN #2014/10/03 by Hiko
      CALL sadzp062_1_translate_cust_module(l_gzza003) RETURNING l_gzza003
   END IF

   #DISPLAY "回傳模組為：",l_gzza003
   RETURN l_gzza003
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 轉換對應客製模組   (AZZ->CZZ) (CZZ->CZZ)
# Input parameter : p_module 模組別
# Return code     : r_module 模組別
# Date & Author   : 2014/06/04 by madey
##########################################################################
PUBLIC FUNCTION sadzp062_1_translate_cust_module(p_module)
   DEFINE p_module  LIKE gzza_t.gzza003, 
          r_module  LIKE gzza_t.gzza003, 
          l_gzzj001 LIKE gzzj_t.gzzj001, #實際模組
          ls_sql    STRING,
          l_cnt     LIKE type_t.num5

 TRY
   LET r_module = p_module

   #註冊資訊為客製,需透過gzzj_t找到實際的模組別,以AZZ為例:
   #若歸屬模組(gzzj003)相等， 但!= 實際模組(gzzj001)的話, 表示是AZZ-->CZZ ,否則用原本模組就好
   SELECT gzzj001 INTO l_gzzj001 FROM gzzj_t WHERE gzzj003 = p_module AND gzzj003 <> gzzj001
   IF SQLCA.sqlcode = 0  THEN
      LET r_module = l_gzzj001
   END IF

  CATCH
   DISPLAY "error: sqlca.sqlcode=",SQLCA.SQLCODE

  END TRY

  RETURN r_module

END FUNCTION

#依據程式代號取得版次資訊.
PUBLIC FUNCTION sadzp062_1_get_curr_dzaf(p_prog)
   DEFINE p_prog STRING
   DEFINE lo_dzaf     T_DZAF_T,
          l_cons_type LIKE dzaf_t.dzaf005,
          l_module    LIKE dzaf_t.dzaf006, 
          ls_sql      STRING,
          ls_sql_base STRING,
          ls_sql_cond STRING,
          ls_err_msg  STRING 

   LET p_prog = p_prog.trim()

   #取得建構類型與對應模組:有客製就以客製為主.
   LET ls_sql_base = "SELECT distinct dzaf005,dzaf006 FROM dzaf_t WHERE dzaf001='",p_prog CLIPPED,"'"
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

      RETURN "ERROR:找不到建構類型",NULL
   END IF

   CALL sadzp060_2_get_curr_ver_info(p_prog, l_cons_type, l_module) RETURNING lo_dzaf.*,ls_err_msg
   IF NOT cl_null(ls_err_msg) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00833" #取得版次資料過程出現錯誤!
      LET g_errparam.popup = TRUE
      CALL cl_err() 

      RETURN "ERROR:取得版次資料過程出現錯誤",NULL
   END IF

   RETURN NULL,lo_dzaf.*
END FUNCTION
