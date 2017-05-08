#+ 程式代碼......: sadzp007_util
#+ 設計人員......: madey
# Prog. Version..: 'T6-12.01.21(00000)'     #
# Program name   : sadzp007_util.4gl
# Description    : adz共用函式
# Modify         : 2015/11/25 by madey : 新建程式
#                : 2015/11/26 by Hiko  : 增加函式:sadzp007_util_chk_eff_date()
#                : 2015/12/20 by madey : 增加函式:sadzp007_util_get_cust_flag()
#                : 20160223 160223-00028 by madey :patch優化專案:
#                                        當時為了專案新建立此程式，時間已不可考，新增函式如下
#                                        sadzp007_util_get_path()
#                                        sadzp007_util_get_backfile_cnt()                                                 
#                                        sadzp007_util_backfile()                                   
#                : 20160428 160428-00021 by madey :增加函式:sadzp007_util_chk_cartesian()
#                : 20160429 160429-00007 by Hiko : 修正加密字串解密出錯的問題

IMPORT os
IMPORT security #2015/11/26 by Hiko

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

#+ 取得完整路徑(轉換環境變數設置) #160223-00028
PUBLIC FUNCTION sadzp007_util_get_path(p_path)
   DEFINE p_path            STRING             #檔案路徑
   DEFINE l_idx_start       LIKE type_t.num5
   DEFINE l_idx_end         LIKE type_t.num5
   DEFINE l_var             STRING
   DEFINE l_str             STRING
   DEFINE l_length          LIKE type_t.num5
   
   #環境變數應該都用"$"字元起頭
   LET l_idx_start = p_path.getIndexOf("$", 1)
   LET l_length = p_path.getLength()

   IF l_idx_start > 0 THEN
      #取得環境變數完整名稱
      LET l_idx_end = p_path.getIndexOf("/", l_idx_start)

      IF l_idx_end > 0 THEN
         LET l_var = p_path.subString(l_idx_start + 1, l_idx_end - 1)
         LET l_str = FGL_GETENV(l_var)

         #取替代字串
         LET l_var = "$", l_var.trim()
         LET p_path = cl_replace_str(p_path, l_var, l_str)

         LET p_path = sadzp007_util_get_path(p_path)
      ELSE
         LET l_var = p_path.subString(l_idx_start + 1, l_length)
         LET l_str = FGL_GETENV(l_var)

         #取替代字串
         LET l_var = "$", l_var.trim()
         LET p_path = cl_replace_str(p_path, l_var, l_str)
         RETURN p_path
      END IF
   END IF

   RETURN p_path
END FUNCTION


#+取得azzs010設定的備份版數 (0表示不留備份) #160223-00028
PUBLIC FUNCTION sadzp007_util_get_backfile_cnt()
   DEFINE ls_result    STRING
   DEFINE li_cnt       LIKE type_t.num5


   LET ls_result = cl_get_para("","","A-SYS-0031")
   IF cl_null(ls_result) OR ls_result = "NOT_DEFINED" THEN
      LET li_cnt = 0
   ELSE
      LET li_cnt = ls_result
   END IF

   RETURN li_cnt

END FUNCTION


#+檔案備份 #160223-00028
PUBLIC FUNCTION sadzp007_util_backfile(p_file_path,p_cnt) 
   DEFINE p_file_path    STRING            #檔案完整路徑
   DEFINE p_cnt          LIKE type_t.num5  #備份份數

   DEFINE ls_rootname    STRING
   DEFINE ls_extension   STRING
   DEFINE li_cnt         LIKE type_t.num5
   DEFINE ls_oldfile     STRING
   DEFINE ls_newfile     STRING  
   DEFINE ls_cmd         STRING

   
   #若不指定份數,自動抓azzs010設定
   IF cl_null(p_cnt) THEN
      LET p_cnt = sadzp007_util_get_backfile_cnt()
   END IF

   #份數為0就離開
   IF p_cnt = 0 THEN
      RETURN
   END IF
   
   #轉換路徑: 因為os.path這個method需要吃絕對路徑才能正常work
   #ex $AIT/4gl/aiti001.4gl --> /u1/topprd/erp/adz/4gl/aiti001.4gl
   LET p_file_path= sadzp007_util_get_path(p_file_path)
   
   #ex /u1/t10dev/erp/adz/4gl/aiti001.4gl --> /u1/t10dev/erp/adz/4gl/aiti001
   LET ls_rootname = os.Path.rootname(p_file_path)
   IF cl_null(ls_rootname) THEN
      DISPLAY 'Warning: get file rootname fail , skip backfile(',p_file_path,')'
      RETURN
   END IF

   #ex /u1/t10dev/erp/adz/4gl/aiti001.4gl --> 4gl
   LET ls_extension = os.Path.extension(p_file_path)
   IF cl_null(ls_extension) THEN
      DISPLAY 'Warning: get file extension fail , skip backfile(',p_file_path,')'
      RETURN
   END IF

   #備份檔案
   FOR li_cnt = p_cnt TO 1 STEP -1
      IF li_cnt > 1 THEN
         LET ls_newfile = ls_rootname,".bck",(li_cnt - 1) USING "<"
         LET ls_oldfile = ls_rootname,".bck",(li_cnt - 2) USING "<"
      ELSE
         LET ls_newfile = ls_rootname,".bck"
         LET ls_oldfile = ls_rootname,".",ls_extension
      END IF
     #IF os.Path.EXISTS(ls_newfile) THEN
     #   IF os.Path.DELETE(ls_newfile) THEN END IF
     #END IF
      IF os.Path.EXISTS(ls_oldfile) THEN
         DISPLAY "Info:rename ",ls_oldfile," --> ",ls_newfile
         IF NOT os.Path.RENAME(ls_oldfile,ls_newfile) THEN
            DISPLAY "Warning:rename fail ",ls_oldfile," --> ",ls_newfile
         END IF
      END IF
   END FOR

END FUNCTION

#+檢查加密過的日期是否還是生效. #2015/11/26 by Hiko
PUBLIC FUNCTION sadzp007_util_chk_eff_date(p_eff_date_key)
   DEFINE p_eff_date_key STRING
   DEFINE ls_eff_date_str STRING,
          ld_eff_date DATE,
          ld_today    DATE

   IF NOT cl_null(p_eff_date_key) THEN
      DISPLAY "effect date key=",p_eff_date_key

      TRY
         LET ls_eff_date_str = security.Base64.ToString(p_eff_date_key) #取得解密後的日期字串.
      CATCH
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = p_eff_date_key
         LET g_errparam.code   = "adz-00735" #來源加密字串格式有問題,無法解密.
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN FALSE
      END TRY

      LET ld_eff_date = DATE(ls_eff_date_str)
      #Begin:160429-00007
      IF ld_eff_date IS NULL THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code  = "adz-00735" #來源加密字串格式有問題,無法解密.
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
      #End:160429-00007

      LET ld_today = TODAY
      DISPLAY "ld_eff_date-ld_today=",ld_eff_date-ld_today
      IF (ld_eff_date-ld_today)<0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = "adz-00733" #此功能的執行時效已經過期.
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "adz-00734" #此功能的執行缺少最後一個參數:加密過的有效日期.
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION


#+取得程式的客製註記(註冊資料). #20151220 by madey
PUBLIC FUNCTION sadzp007_util_get_cust_flag(p_prog,p_type)
   DEFINE p_prog    LIKE gzde_t.gzde001,
          p_type    LIKE gzde_t.gzde003,
          l_gzza011 LIKE gzza_t.gzza011, #是否客製
          ls_sql    STRING,
          l_cnt     LIKE type_t.num5

   #sql
   CASE 
      WHEN p_type="M"
         #資料來源作業azzi900
         LET ls_sql = "SELECT gzza011",
                      " FROM gzza_t",
                      " WHERE gzza001='",p_prog,"'"
      WHEN p_type MATCHES "[SBGXW]"
         #資料來源作業azzi901
         LET ls_sql = "SELECT gzde008",
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
            LET ls_sql = "SELECT DISTINCT gzdf003",
                         " FROM gzde_t",
                         " LEFT JOIN gzdf_t ON gzde001=gzdf001 ",
                         " WHERE gzdf002='",p_prog,"'"
         ELSE
            #資料來源作業azzi900_代表主程式的子畫面
            LET ls_sql = "SELECT DISTINCT gzdf003",
                         " FROM gzza_t",
                         " LEFT JOIN gzdf_t ON gzza001=gzdf001 ",
                         " WHERE gzdf002='",p_prog,"'"  
         END IF
      WHEN p_type="Z"
         #資料來源作業azzi700
         LET ls_sql = "SELECT gzja005",
                      " FROM gzja_t",
                      " WHERE gzja001='",p_prog,"'"

      WHEN p_type="Q"
         #資料來源作業adzi210 (r.q)
         LET ls_sql = "SELECT DISTINCT                                                               ",
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
           DISPLAY "error: type undefine:",p_type
   END CASE
   
  TRY

   LET l_gzza011 = NULL
   PREPARE gzza_prep FROM ls_sql
   EXECUTE gzza_prep INTO l_gzza011
   FREE gzza_prep
   RETURN l_gzza011
  
  CATCH
   DISPLAY "error: sqlca.sqlcode=",SQLCA.SQLCODE
   RETURN NULL
   
  END TRY


END FUNCTION


#160428-00021
#+判斷是否有卡迪苼效應
#注意:同一個Transcation內最好只來呼叫1次，否則有可能因為殘留而不準
PUBLIC FUNCTION sadzp007_uti_chk_cartesian(p_sql)
DEFINE p_sql           STRING
DEFINE l_tmp_sql       STRING 
DEFINE l_cnt           LIKE type_t.num5
DEFINE l_replce_str    STRING 


TRY
  LET l_tmp_sql = p_sql
  
   LET l_tmp_sql = " EXPLAIN plan FOR ",l_tmp_sql
   PREPARE adzp188_tmp_sql_pre FROM l_tmp_sql
   EXECUTE adzp188_tmp_sql_pre

   LET l_cnt = 0
   LET l_tmp_sql = ""
   LET l_tmp_sql = " SELECT COUNT(plan_table_output) ", 
                   " FROM TABLE (dbms_xplan.display('plan_table',NULL,'basic')) ",
                   " WHERE plan_table_output LIKE '%MERGE JOIN CARTESIAN%'"
   PREPARE adzp188_chk_cartesian_pre FROM l_tmp_sql                
   DECLARE adzp188_chk_cartesian_curs CURSOR FOR adzp188_chk_cartesian_pre
   OPEN adzp188_chk_cartesian_curs
   FETCH adzp188_chk_cartesian_curs INTO l_cnt   
   IF l_cnt > 0 THEN
      RETURN TRUE  
   ELSE
      RETURN FALSE 
   END IF


 CATCH
      DISPLAY "ERROR:",cl_getmsg(SQLCA.SQLCODE,g_lang)," SQLERRMESSAGE=",SQLERRMESSAGE
      RETURN FALSE 

 END TRY
    
END FUNCTION
