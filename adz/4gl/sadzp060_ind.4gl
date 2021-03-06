#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/10/12
#
#+ 程式代碼......: sadzp060_ind
#+ 設計人員......: Elena
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp060_ind.4gl
# Description    : 行業別相關function
# Memo           : s
# 修改歷程       : 20160707 by elena :判斷程式是否為行業程式改由註冊table判斷 (原為gzzb001<>gzzb003,註冊table包含gzza_t,gzde_t, gzdf_t, gzja_t, dzca_t)

IMPORT os
IMPORT XML

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"



##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 判斷程式是否為強制引用的行業別程式(gzzb001<>gzzb003)
# Input parameter : p_prog
# Return code     : rb_result
# Date & Author   : 20160321 by Elena
##########################################################################

PUBLIC FUNCTION sadzp060_ind_check_industry(p_prog)
   DEFINE p_prog      LIKE dzaa_t.dzaa001
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ls_trigger  STRING

   DEFINE ms_topind  STRING
   DEFINE ms_dgenv   LIKE dzaf_t.dzaf010
   DEFINE rb_result  STRING

   LET ms_topind = FGL_GETENV("TOPIND") CLIPPED
   LET ms_dgenv = FGL_GETENV("DGENV") CLIPPED

   LET li_cnt =0
   LET rb_result = FALSE

   TRY

      IF ms_dgenv = 's' THEN
         IF ms_topind IS NULL OR ms_topind = 'sd' THEN
            LET rb_result = FALSE  #標準環境
         ELSE
            LET ls_trigger = "call sadzp060_ind_check_industry finish"
               SELECT COUNT(*) INTO li_cnt FROM gzzb_t
               WHERE gzzb001=p_prog AND gzzb001<>gzzb003
            IF li_cnt = 0 THEN
               LET rb_result = FALSE  #非強制引用   
            ELSE 
               LET rb_result = TRUE  #強制引用
            END IF
         END IF
      ELSE
         #客製環境沒有行業議題
         LET rb_result = FALSE  #客製環境 
      END IF
 
      RETURN rb_result

   CATCH
      CALL sadzp060_ind_err_catch(ls_trigger, NULL)
      #DISPLAY 'error: get gzzb_t fail,SQLCA.sqlcode=',SQLCA.sqlcode
      LET rb_result = FALSE
      RETURN rb_result

   END TRY


END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 判斷是否為行業程式 (只限M類程式適用)
# Input parameter : none
# Return code     : rb_result
# Date & Author   : 20160325 by Elena
##########################################################################
PUBLIC FUNCTION sadzp060_ind_check_industry_prog(p_prog)
   DEFINE p_prog      LIKE dzaa_t.dzaa001
   DEFINE li_cnt      LIKE type_t.num5,
          ls_trigger  STRING,
          ls_sql      STRING,
          ls_ind      LIKE gzza_t.gzza015

   DEFINE rb_result  STRING

   LET li_cnt = 0;

   TRY
   
      LET ls_trigger = "call sadzp060_ind_check_industry_prog finish"
      
      SELECT COUNT(*) INTO li_cnt FROM gzzb_t
      WHERE gzzb001=p_prog AND gzzb002<>'sd'

      IF li_cnt = 0 THEN
         LET rb_result = FALSE
      ELSE
         LET rb_result = TRUE
      END IF      
 
      RETURN rb_result
   CATCH
      CALL sadzp060_ind_err_catch(ls_trigger, NULL)
      #DISPLAY 'error: get gzzb_t fail,SQLCA.sqlcode=',SQLCA.sqlcode
      LET rb_result = FALSE
      RETURN rb_result
   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 判斷是否為行業程式
# Input parameter : none
# Return code     : rb_result
# Date & Author   : 20160325 by Elena
##########################################################################
PRIVATE FUNCTION sadzp060_ind_cite_prog(p_prog)
   DEFINE p_prog      LIKE dzaa_t.dzaa001
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ls_trigger  STRING

   DEFINE rb_result  STRING

   LET li_cnt = 0;

   TRY

      LET ls_trigger = "call sadzp060_ind_cite_prog finish"

      SELECT COUNT(*) INTO li_cnt FROM gzzb_t
      WHERE gzzb001=p_prog AND gzzb001<>gzzb003
      IF li_cnt = 0 THEN
         LET rb_result = FALSE
      ELSE
         LET rb_result = TRUE
      END IF

      RETURN rb_result
   CATCH
      CALL sadzp060_ind_err_catch(ls_trigger, NULL)
      #DISPLAY 'error: get gzzb_t fail,SQLCA.sqlcode=',SQLCA.sqlcode
      LET rb_result = FALSE
      RETURN rb_result
   END TRY

END FUNCTION
##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 判斷是否為行業區域
# Input parameter : none
# Return code     : rb_result
# Date & Author   : 20160321 by Elena
##########################################################################
PUBLIC FUNCTION sadzp060_ind_check_area()

   DEFINE ms_topind  STRING
   DEFINE ms_dgenv   LIKE dzaf_t.dzaf010
   DEFINE rb_result  BOOLEAN

   LET ms_topind = FGL_GETENV("TOPIND") CLIPPED
   LET ms_dgenv = FGL_GETENV("DGENV") CLIPPED

   #LET ms_topind = 'ph' #test

   IF ms_dgenv = "s" THEN
      IF ms_topind IS NULL OR ms_topind = "sd" THEN
         LET rb_result = FALSE
      ELSE
         LET rb_result = TRUE
      END IF

   ELSE
      #客製環境沒有行業議題
      LET rb_result = FALSE
   END IF

   RETURN rb_result
END FUNCTION




##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 擷取錯誤訊息.
# Input parameter : p_trigger 執行的顯現資訊
#                   p_sql 執行的SQL
# Return code     : none
# Date & Author   : 20130412 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_ind_err_catch(p_trigger, p_sql)
   DEFINE p_trigger STRING,
          p_sql STRING

   DISPLAY "ERROR : ls_trigger=",p_trigger
   DISPLAY "STATUS=",STATUS
   DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
   DISPLAY "ls_sql=",p_sql,"<<"
END FUNCTION



##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 依1.標準、客製環境 2.判斷是否為行業別程式 3.判斷是否強
#                   制引用，回傳不同參數
# Input parameter : p_prog
# Return code     : rs_return
#                   0：可r.a
#                   1：標準環境下，不可複製行業程式 (ex:aiti001_ph、biti001_ph)
#                   2：行業環境下，不可複製標準程式 (ex:aiti001)
#                   3：行業環境下此程式為強制引用 
# Date & Author   : 20160325 by Elena
#(只限M類程式適用),目前只有adzp168有用到
##########################################################################

PUBLIC FUNCTION sadzp060_ind_check_status(p_prog)

   DEFINE p_prog      LIKE dzaa_t.dzaa001
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ls_trigger  STRING

   DEFINE ms_topind  STRING
   DEFINE ms_dgenv   LIKE dzaf_t.dzaf010
   DEFINE rs_result  STRING

   LET ms_topind = FGL_GETENV("TOPIND") CLIPPED
   LET ms_dgenv = FGL_GETENV("DGENV") CLIPPED

   IF ms_dgenv = 's' THEN
      #s,sd
      IF ms_topind IS NULL OR ms_topind = 'sd' THEN   
         
         #判斷是否是行業程式 (gzzb002<>'sd')
         IF sadzp060_ind_check_industry_prog(p_prog) THEN  #是行業程式
           LET rs_result = '1'
         ELSE
           LET rs_result = '0'  
         END IF
         
      #s,<>'sd'   
      ELSE
         IF sadzp060_ind_check_industry_prog(p_prog) THEN # 是行業程式
      
            #判斷是否強制引用
            IF sadzp060_ind_cite_prog(p_prog) THEN
              LET rs_result = '3'
            ELSE
              LET rs_result = '0'
            END IF
         ELSE
            LET rs_result = '2'
         END IF
  
      END IF
   #c
   ELSE
      LET rs_result = '0' 
   END IF
   
   RETURN rs_result

END FUNCTION


##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 依1.標準、客製環境 2.判斷是否為行業別程式 3.判斷是否強
#                   制引用，回傳不同參數
# Input parameter : p_prog
# Return code     : rs_return
#                   0：可r.a
#                   1：標準環境下，不可複製行業程式 (ex:aiti001_ph、biti001_ph)
#                   2：行業環境下，不可複製標準程式 (ex:aiti001)
#                   3：行業環境下此程式為強制引用
# Date & Author   : 20160325 by Elena
#(只限M類程式適用),目前只有adzp168有用到
##########################################################################

PUBLIC FUNCTION sadzp060_ind_check_status_1(p_prog)

   DEFINE p_prog      LIKE dzaa_t.dzaa001
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ls_trigger  STRING

   DEFINE ms_topind  STRING
   DEFINE ms_dgenv   LIKE dzaf_t.dzaf010
   DEFINE rs_result  STRING

   LET ms_topind = FGL_GETENV("TOPIND") CLIPPED
   LET ms_dgenv = FGL_GETENV("DGENV") CLIPPED

   IF ms_dgenv = 's' THEN
      #s,sd
      IF ms_topind IS NULL OR ms_topind = 'sd' THEN

         #判斷是否是行業程式 (gzzb002<>'sd')
         #IF sadzp060_ind_check_industry_prog(p_prog) THEN  #是行業程式
         IF sadzp060_ind_check_industry_by_register(p_prog) THEN
           LET rs_result = '1'
         ELSE
           LET rs_result = '0'
         END IF

      #s,<>'sd'
      ELSE
         #IF sadzp060_ind_check_industry_prog(p_prog) THEN # 是行業程式
         IF sadzp060_ind_check_industry_by_register(p_prog) THEN

            #判斷是否強制引用
            IF sadzp060_ind_cite_prog(p_prog) THEN
              LET rs_result = '3'
            ELSE
              LET rs_result = '0'
            END IF
         ELSE
            LET rs_result = '2'
         END IF

      END IF
   #c
   ELSE
      LET rs_result = '0'
   END IF

   RETURN rs_result

END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 依1.標準、客製環境 2.傳入p_topind是否是行業 3.是否彈出錯誤訊息
# Input parameter : p_topind：sd or NULL(標準),非sd AND 非NULL(行業)
#                   type：d(刪除)、u(修改)
#                   rb_msg:是否彈出錯誤訊息
# Return code     : rb_return
#                   TRUE：可刪除或修改
#                   FALSE：不可刪除或修改
# Date & Author   : 20160329 by Elena
##########################################################################

PUBLIC FUNCTION sadzp060_ind_check_modify_permissions(p_topind, TYPE, rb_msg)

   DEFINE p_topind    STRING
   DEFINE TYPE        STRING
   DEFINE rb_msg      BOOLEAN   
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ls_trigger  STRING

   DEFINE ms_dgenv   LIKE dzaf_t.dzaf010
   DEFINE ms_topind  STRING
   DEFINE rb_result  BOOLEAN
   
   LET ms_dgenv = FGL_GETENV("DGENV") CLIPPED
   LET ms_topind = FGL_GETENV("TOPIND") CLIPPED
   LET rb_result = TRUE

   #LET p_topind = 'ph'  #test

   IF ms_dgenv = 's' THEN
      #行業環境
      IF ms_topind <> 'sd' AND ms_topind IS NOT NULL THEN
         #傳入資料topind為標準，提示不可修改、刪除
         IF p_topind == 'sd' OR p_topind IS NULL THEN
            IF rb_msg THEN
               CASE
                  WHEN TYPE = 'u' 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "adz-00815"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET rb_result = FALSE
                  WHEN TYPE = 'd'
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "adz-00816"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET rb_result = FALSE
               END CASE
            ELSE
               LET rb_result = FALSE;
            END IF
         END IF
      END IF
   END IF
   RETURN rb_result	  
END FUNCTION


##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 依傳入類別、程式名稱判斷回傳行業
# Input parameter : p_prog：程式代號、表格名稱
#                   type：1:程式,2:表格
# Return code     : rs_ind_type:所屬行業
# Date & Author   : 20160330 by Elena
##########################################################################

PUBLIC FUNCTION sadzp060_ind_return_industry(p_prog, TYPE)

   DEFINE p_prog     STRING
   DEFINE TYPE       STRING
   DEFINE ls_sql     STRING
   DEFINE li_cnt     LIKE type_t.num5
 
   DEFINE ms_dgenv   LIKE dzaf_t.dzaf010
   DEFINE ms_topind  STRING
   DEFINE ls_gzzb002 LIKE gzzb_t.gzzb002
   DEFINE ls_dzea014 LIKE dzea_t.dzea014
   DEFINE rs_result  STRING
   DEFINE l_dzca007 LIKE dzca_t.dzca007
   DEFINE l_dzca001 LIKE dzca_t.dzca001
   DEFINE l_dzca002 LIKE dzca_t.dzca002

   CASE
      #程式:查詢gzzb_t   
      WHEN TYPE = '1'
          IF (p_prog MATCHES "q_*" ) OR (p_prog MATCHES "cq_*" ) THEN #madey:開窗
	     LET ls_sql = "SELECT dzca007 FROM DZCA_T WHERE DZCA001 =? AND dzca002=?"
             PREPARE select_dzca_t FROM ls_sql
             DECLARE dzca_curs CURSOR FOR select_dzca_t
             
             LET l_dzca001=p_prog
             LET l_dzca002="c" #先抓客製
             LET l_dzca007=''
             EXECUTE dzca_curs INTO l_dzca007 USING l_dzca001,l_dzca002
             IF SQLCA.SQLCODE THEN
                LET l_dzca002="s" 
                EXECUTE dzca_curs INTO l_dzca007 USING l_dzca001,l_dzca002
                IF SQLCA.SQLCODE THEN
                   LET l_dzca007=''
                   DISPLAY "Warning: not found data in dzca_t:",l_dzca001,l_dzca002
                END IF
             END IF
             LET rs_result = l_dzca007
                 
          ELSE
	     LET ls_sql = "SELECT GZZB002 FROM GZZB_T WHERE GZZB001 = '" , p_prog , "' "
             PREPARE select_gzzb_t FROM ls_sql
             DECLARE gzzb_curs CURSOR FOR select_gzzb_t
             
             FOREACH gzzb_curs INTO ls_gzzb002
                LET rs_result = ls_gzzb002
             END FOREACH
          END IF

      WHEN TYPE = '2'
	  LET ls_sql = "SELECT DZEA014 FROM DZEA_T WHERE DZEA001 = '" , p_prog , "' "
          PREPARE select_dzea_t FROM ls_sql
          DECLARE dzea_curs CURSOR FOR select_dzea_t

          FOREACH dzea_curs INTO ls_dzea014
             LET rs_result = ls_dzea014
          END FOREACH   	   
      
   END CASE
   RETURN rs_result
END FUNCTION


##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 判斷傳入程式代號是否有被引用
# Input parameter : p_prog：程式代號
# Return code     : rb_return:TRUE/FALSE
# Date & Author   : 20160406 by Elena
##########################################################################

PUBLIC FUNCTION sadzp060_ind_is_cite(p_prog)
   DEFINE p_prog     LIKE gzzb_t.gzzb003
   DEFINE ls_trigger STRING
   DEFINE ls_sql     STRING
   DEFINE li_cnt     LIKE type_t.num5

   DEFINE rb_result  BOOLEAN


   LET li_cnt = 0;

   TRY

      LET ls_trigger = "call sadzp060_ind_IsCite finish"

      SELECT COUNT(*) INTO li_cnt FROM gzzb_t
      WHERE gzzb003=p_prog AND GZZB003 <> GZZB001

      IF li_cnt = 0 THEN
         LET rb_result = FALSE
      ELSE
         LET rb_result = TRUE
      END IF

      RETURN rb_result
   CATCH
      CALL sadzp060_ind_err_catch(ls_trigger, NULL)
      LET rb_result = FALSE
      RETURN rb_result
   END TRY


END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 由程式類型與判斷是否為強制引用，判斷是否為引用程式，非M類程式皆非引用
# Input parameter : p_prog  程式代號
#                 : p_type  程式類型 (M:主程式,S:子程式,F:子畫面,B:應用元件,Q:開窗HardCode,Z:服務)
# Return code     : rb_result
# Date & Author   : 20160711 by Elena
##########################################################################
PUBLIC FUNCTION sadzp060_ind_check_prog_by_type(p_prog, p_type)
   DEFINE p_prog    LIKE gzza_t.gzza001,
          p_type    STRING


   DEFINE ls_trigger  STRING,
          ls_sql      STRING,
          ls_str      STRING,
          ls_ind      LIKE gzza_t.gzza015,
          rb_result   BOOLEAN,
          ln_cnt      LIKE type_t.num5

   DEFINE ls_topind  STRING

   
   TRY
   
      LET ls_trigger = "call sadzp060_ind_check_prog_by_type finish"
  
      #只有M類程式有引用問題，其他類型都非引用
      IF p_type = "M" AND sadzp060_ind_check_industry(p_prog) THEN
         LET rb_result = TRUE
      ELSE
         LET rb_result = FALSE
      END IF

      ##取傳入的程式代號來取得應複製的行業代號
      #LET ls_str = p_prog CLIPPED
      #LET ls_topind = ls_str.substring( ls_str.getindexof('_',1)+1,ls_str.getlength())
      #
      #CASE
      #   WHEN p_type = "M"
      #      LET ls_sql = "SELECT COUNT(*)  FROM gzza_t WHERE gzza001 = '", p_prog ,"'  AND gzza015 = '", ls_topind ,"' "
      #   WHEN p_type = "[SB]"
      #      LET ls_sql = "SELECT COUNT(*)  FROM gzde_t WHERE gzde001 = '", p_prog ,"' AND gzde009 = '", ls_topind ,"'"
      #   WHEN p_type = "F"
      #      LET ls_sql = "SELECT COUNT(*)  FROM gzdf_t a LEFT JOIN gzza_t b ",
      #                   "ON a.gzdf001 = b.gzza001 WHERE gzdf002 = '", p_prog ,"' AND gzza015 = '", ls_topind ,"'"
      #   WHEN p_type = "Q"
      #      LET ls_sql = "SELECT COUNT(*)  FROM dzca_t WHERE dzca001 = '", p_prog ,"' AND dzca007 = '", ls_topind ,"'"
      #   WHEN p_type = "Z"
      #      LET ls_sql = "SELECT COUNT(*)  FROM gzja_t WHERE gzja001 = '", p_prog ,"' AND gzja006 = '", ls_topind ,"'"
      #END CASE
      #PREPARE qry_cs FROM ls_sql
      #EXECUTE qry_cs INTO ln_cnt
      #LET rb_result = IIF (ln_cnt >0 , TRUE, FALSE)
      RETURN rb_result
  
   CATCH
      CALL sadzp060_ind_err_catch(ls_trigger, NULL)
      LET rb_result = FALSE
      RETURN rb_result

   END TRY 


END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 由程式類型自各類型註冊資料判斷是否為行業程式 (標準環境適用)
# Input parameter : p_prog  程式代號
#                 : p_type  程式類型 (M:主程式,S:子程式,F:子畫面,B:應用元件,Q:開窗HardCode,Z:服務)
# Return code     : rb_result
# Date & Author   : 20160711 by Elena
##########################################################################
PUBLIC FUNCTION sadzp060_ind_check_industry_by_register(p_prog)

   DEFINE p_prog LIKE dzaf_t.dzaf001

   DEFINE ls_trigger STRING,
          ls_type    LIKE dzaf_t.dzaf005,
          ls_sql     STRING,
          ls_str     STRING,
          ls_topind  STRING,
          ln_cnt     LIKE type_t.num5,
          rb_result  BOOLEAN,
          ls_gzza015 LIKE gzza_t.gzza015


   LET ls_trigger = "call sadzp060_ind_check_industry_by_register finish"

   LET ls_sql = "select  dzaf005 from dzaf_t where dzaf001='", p_prog ,"' and dzaf002 =  (select max(nvl(dzaf002,0)) max_ver from dzaf_t where dzaf001='", p_prog ,"')"

   
   PREPARE dzaf_cs FROM ls_sql
   EXECUTE dzaf_cs 

   TRY

      FOREACH dzaf_cs INTO ls_type
         #取傳入的程式代號來取得應複製的行業代號
         LET ls_str = p_prog CLIPPED
         #LET ls_topind = ls_str.substring( ls_str.getindexof('_',1)+1,ls_str.getlength())
         
         CASE
            WHEN ls_type = "M"
               #LET ls_sql = "SELECT COUNT(*)  FROM gzza_t WHERE gzza001 = '", p_prog ,"'  AND gzza015 = '", ls_topind ,"' "
               LET ls_sql = "select gzza015 from gzza_t where gzza001 = '", p_prog ,"'"
            WHEN ls_type MATCHES "[SB]"
               #LET ls_sql = "SELECT COUNT(*)  FROM gzde_t WHERE gzde001 = '", p_prog ,"' AND gzde009 = '", ls_topind ,"'"
               LET ls_sql = "select gzde009 from gzde_t where gzde001 = '", p_prog ,"'"
            WHEN ls_type = "F"
               #LET ls_sql = "SELECT COUNT(*)  FROM gzdf_t a LEFT JOIN gzde_t b ",
               #             "ON a.gzdf001 = b.gzde001 WHERE gzdf002 = '", p_prog ,"' AND gzde009 = '", ls_topind ,"'"
               LET ls_sql = "select topind from                                          ",
                            "(select gzza015 topind from gzdf_t a                        ",
                            "    left join gzza_t b on a.gzdf001 = b.gzza001             ",
                            "    where gzdf002 = 'aiti001_01_s01' and gzza015 <> ' ')    ",
                            "union all                                                   ",
                            "(select gzde009 topind from gzdf_t a                        ",
                            "    left join gzde_t b on a.gzdf001 = b.gzde001             ",
                            "    where gzdf002 = 'aiti001_01_s01' and gzde009 <> ' ')    "
            WHEN ls_type = "Q"
               #LET ls_sql = "SELECT COUNT(*)  FROM dzca_t WHERE dzca001 = '", p_prog ,"' AND dzca007 = '", ls_topind ,"'"
               LET ls_sql = "select dzca007 from dzca_t where dzca001 ='", p_prog ,"'"
            WHEN ls_type = "Z"
               #LET ls_sql = "SELECT COUNT(*)  FROM gzja_t WHERE gzja001 = '", p_prog ,"' AND gzja006 = '", ls_topind ,"'"
               LET ls_sql = "select gzja006 from gzja_t where gzja001 = '", p_prog ,"'"
         END CASE
         PREPARE qry_cs FROM ls_sql
         EXECUTE qry_cs INTO ls_gzza015

         LET ls_topind = ls_gzza015
         LET rb_result = IIF ((ls_topind = 'sd' or cl_null(ls_topind)) , FALSE, TRUE)
         RETURN rb_result
      END FOREACH

   
   CATCH
      CALL sadzp060_ind_err_catch(ls_trigger, NULL)
      LET rb_result = FALSE
      RETURN rb_result
   END TRY



END FUNCTION
