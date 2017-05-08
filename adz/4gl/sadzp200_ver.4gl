&include "../4gl/sadzp000_mcr.inc"

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"

&include "../4gl/sadzp200_type.inc"

FUNCTION sadzp200_ver_get_new_ver_info(p_DZAF_T,p_user_role,p_dzlm_exist)
DEFINE
  p_DZAF_T     T_DZAF_T,
  p_user_role  STRING,
  p_dzlm_exist BOOLEAN
DEFINE
  lo_DZAF_T     T_DZAF_T,
  ls_user_role  STRING,
  lb_dzlm_exist BOOLEAN
DEFINE
  lb_return  BOOLEAN,
  lo_result  T_DZAF_T
  
  LET lo_DZAF_T.*   = p_DZAF_T.*
  LET ls_user_role  = p_user_role
  LET lb_dzlm_exist = p_dzlm_exist

  LET lo_DZAF_T.DZAF007 = NVL(lo_DZAF_T.DZAF007,FGL_GETENV("ERPID"))
  LET lo_DZAF_T.DZAF008 = NVL(lo_DZAF_T.DZAF008,FGL_GETENV("ERPVER"))
  LET lo_DZAF_T.DZAF009 = NVL(lo_DZAF_T.DZAF009,FGL_GETENV("CUST"))
  LET lo_DZAF_T.DZAF010 = NVL(lo_DZAF_T.DZAF010,FGL_GETENV("DGENV"))

  CALL sadzp200_ver_get_new_ver_raw_data(lo_DZAF_T.*,ls_user_role,lb_dzlm_exist) RETURNING lo_result.*
  CALL sadzp200_ver_set_ver(lo_result.*,ls_user_role) RETURNING lb_return

  RETURN lb_return,lo_result.*
  
END FUNCTION 

FUNCTION sadzp200_ver_get_new_ver_raw_data(p_DZAF_T,p_user_role,p_dzlm_exist)
DEFINE
  p_DZAF_T     T_DZAF_T,
  p_user_role  STRING,
  p_dzlm_exist BOOLEAN
DEFINE
  lo_DZAF_T  T_DZAF_T,
  ls_user_role          STRING,
  lb_dzlm_exist         BOOLEAN,
  li_curr_construct_ver INTEGER,
  li_new_construct_ver  INTEGER,
  li_construct_ver      INTEGER,
  li_sd_ver             INTEGER,
  li_pr_ver             INTEGER,
  li_sd_curr_ver        INTEGER,
  li_pr_curr_ver        INTEGER,
  li_sd_max_inc_num     INTEGER,
  li_pr_max_inc_num     INTEGER
DEFINE
  lo_result  T_DZAF_T
  
  LET lo_DZAF_T.*   = p_DZAF_T.*
  LET ls_user_role  = p_user_role
  LET lb_dzlm_exist = p_dzlm_exist

  LET lo_result.* = p_DZAF_T.*

  #先取得最大建構版次
  LET li_curr_construct_ver = sadzp200_ver_get_max_construct_version(lo_DZAF_T.*)
  
  #DZLM_T 存在, 則傳原先的建構版次
  IF lb_dzlm_exist THEN 
    LET li_new_construct_ver = IIF(li_curr_construct_ver == 0,1,li_curr_construct_ver)
  ELSE
    LET li_new_construct_ver = li_curr_construct_ver + 1
  END IF  

  LET lo_DZAF_T.DZAF002 = li_curr_construct_ver

  #取得目前SD,PR的版次
  LET li_sd_curr_ver = sadzp200_ver_get_curr_sd_version(lo_DZAF_T.*)
  LET li_pr_curr_ver = sadzp200_ver_get_curr_pr_version(lo_DZAF_T.*)

  #取得SD,PR最大遞增允許值
  LET li_sd_max_inc_num = NVL(sadzp200_ver_get_parameter(cs_ver_type_sd,cs_max_increase_number),ci_unlimit_number)
  LET li_pr_max_inc_num = NVL(sadzp200_ver_get_parameter(cs_ver_type_pr,cs_max_increase_number),ci_unlimit_number)
  
  CASE 
    #SD
    WHEN ls_user_role = cs_user_role_sd
      LET li_construct_ver = li_new_construct_ver
      #當SD現行版次已經達最大遞增允許值時, 則不再遞增
      IF (li_sd_curr_ver >= li_sd_max_inc_num) AND (li_sd_max_inc_num <> ci_unlimit_number) THEN
        LET li_sd_ver = li_sd_curr_ver
      ELSE 
        LET li_sd_ver = li_sd_curr_ver + 1
      END IF 
      LET li_pr_ver = li_pr_curr_ver
    #PR
    WHEN ls_user_role = cs_user_role_pr
      LET li_construct_ver = li_new_construct_ver
      LET li_sd_ver = li_sd_curr_ver
      #當PR現行版次已經達最大遞增允許值時, 則不再遞增
      IF (li_pr_curr_ver >= li_pr_max_inc_num) AND (li_pr_max_inc_num <> ci_unlimit_number) THEN
        LET li_pr_ver = li_pr_curr_ver
      ELSE 
        LET li_pr_ver = li_pr_curr_ver + 1
      END IF 
  OTHERWISE    
    LET li_construct_ver = li_curr_construct_ver
    LET li_sd_ver = li_sd_curr_ver
    LET li_pr_ver = li_pr_curr_ver
  END CASE   

  LET lo_result.DZAF002 = IIF(li_construct_ver==0,NULL,li_construct_ver) 
  LET lo_result.DZAF003 = IIF(li_sd_ver==0,NULL,li_sd_ver)
  LET lo_result.DZAF004 = IIF(li_pr_ver==0,NULL,li_pr_ver)

  RETURN lo_result.*
  
END FUNCTION

FUNCTION sadzp200_ver_get_curr_ver_info(p_DZAF_T)
DEFINE
  p_DZAF_T  T_DZAF_T
DEFINE
  lo_DZAF_T  T_DZAF_T,
  li_construct_ver INTEGER,
  li_sd_ver        INTEGER,
  li_pr_ver        INTEGER,
  ls_module        STRING,
  ls_using_mark    STRING
DEFINE
  lo_result  T_DZAF_T
  
  LET lo_DZAF_T.*  = p_DZAF_T.*

  LET lo_DZAF_T.DZAF007 = NVL(lo_DZAF_T.DZAF007,FGL_GETENV("ERPID"))
  LET lo_DZAF_T.DZAF008 = NVL(lo_DZAF_T.DZAF008,FGL_GETENV("ERPVER"))
  LET lo_DZAF_T.DZAF009 = NVL(lo_DZAF_T.DZAF009,FGL_GETENV("CUST"))
  LET lo_DZAF_T.DZAF010 = NVL(lo_DZAF_T.DZAF010,FGL_GETENV("DGENV"))
  
  LET lo_result.* = lo_DZAF_T.*

  IF (lo_DZAF_T.DZAF002 IS NULL) OR (lo_DZAF_T.DZAF002 = 0) THEN #2014/09/05 by Hiko:增加dzaf002=0的條件
    LET li_construct_ver = sadzp200_ver_get_max_construct_version(lo_DZAF_T.*)
    LET lo_DZAF_T.DZAF002 = li_construct_ver
  ELSE
    LET li_construct_ver = lo_DZAF_T.DZAF002
  END IF   
  
  LET li_sd_ver     = sadzp200_ver_get_curr_sd_version(lo_DZAF_T.*)
  LET li_pr_ver     = sadzp200_ver_get_curr_pr_version(lo_DZAF_T.*)
  LET ls_using_mark = sadzp200_ver_get_curr_using_mark(lo_DZAF_T.*)
  LET ls_module     = sadzp200_ver_get_curr_module_name(lo_DZAF_T.*)

  #設定回傳資訊
  LET lo_result.DZAF002 = IIF(li_construct_ver==0,NULL,li_construct_ver) 
  LET lo_result.DZAF003 = IIF(li_sd_ver==0,NULL,li_sd_ver)
  LET lo_result.DZAF004 = IIF(li_pr_ver==0,NULL,li_pr_ver)
  LET lo_result.DZAF006 = NVL(lo_result.DZAF006,ls_module.trim())
  LET lo_result.DZAF010 = NVL(lo_result.DZAF010,ls_using_mark.trim())

  RETURN lo_result.*
  
END FUNCTION

FUNCTION sadzp200_ver_get_prev_ver_info(p_DZAF_T,p_role)
DEFINE
  p_DZAF_T  T_DZAF_T,
  p_role    STRING
DEFINE
  lo_DZAF_T  T_DZAF_T,
  ls_role           STRING,
  li_max_crst_ver   INTEGER,
  li_construct_ver  INTEGER,
  li_sd_ver         INTEGER,
  li_pr_ver         INTEGER,
  ls_module         STRING,
  ls_using_mark     STRING,
  lo_DZLM_INFO      T_DZLM_T,
  li_sd_min_dec_num STRING,
  li_pr_min_dec_num STRING,
  li_max_sd_ver     INTEGER,
  li_max_pr_ver     INTEGER
DEFINE
  lo_result  T_DZAF_T
  
  LET lo_DZAF_T.*  = p_DZAF_T.*
  LET ls_role = p_role

  LET lo_DZAF_T.DZAF007 = NVL(lo_DZAF_T.DZAF007,FGL_GETENV("ERPID"))
  LET lo_DZAF_T.DZAF008 = NVL(lo_DZAF_T.DZAF008,FGL_GETENV("ERPVER"))
  LET lo_DZAF_T.DZAF009 = NVL(lo_DZAF_T.DZAF009,FGL_GETENV("CUST"))
  LET lo_DZAF_T.DZAF010 = NVL(lo_DZAF_T.DZAF010,FGL_GETENV("DGENV"))
  
  LET lo_result.* = lo_DZAF_T.*

  CALL sadzp200_ver_get_dzlm_info(lo_DZAF_T.DZAF001) RETURNING lo_DZLM_INFO.*

  #若DZLM的SD或PR版次其中一個為空值,則取前一版次時,建構版次需要減一,否則維持原版次
  IF ((lo_DZLM_INFO.DZLM006 <> 0 ) AND (lo_DZLM_INFO.DZLM009 <> 0 )) OR (lo_DZLM_INFO.DZLM001 IS NULL) THEN 
    LET li_max_crst_ver = sadzp200_ver_get_max_construct_version(lo_DZAF_T.*) 
  ELSE
    LET li_max_crst_ver = sadzp200_ver_get_max_construct_version(lo_DZAF_T.*) - 1
  END IF
  LET li_construct_ver = IIF(li_max_crst_ver <= 0,0,li_max_crst_ver)
  LET lo_DZAF_T.DZAF002 = li_construct_ver

  LET li_max_sd_ver = sadzp200_ver_get_max_sd_version(lo_DZAF_T.*)
  LET li_max_pr_ver = sadzp200_ver_get_max_pr_version(lo_DZAF_T.*)
  
  IF NVL(lo_DZLM_INFO.DZLM006,ci_min_number) <> 0 THEN
    LET li_sd_ver = li_max_sd_ver - 1
  ELSE
    LET li_sd_ver = li_max_sd_ver
  END IF 
  
  IF NVL(lo_DZLM_INFO.DZLM009,ci_min_number) <> 0 THEN
    LET li_pr_ver = li_max_pr_ver - 1
  ELSE
    LET li_pr_ver = li_max_pr_ver
  END IF

  #取得SD,PR最大遞減允許值
  LET li_sd_min_dec_num  = NVL(sadzp200_ver_get_parameter(cs_ver_type_sd,cs_min_decrease_number),ci_min_number) 
  LET li_pr_min_dec_num  = NVL(sadzp200_ver_get_parameter(cs_ver_type_pr,cs_min_decrease_number),ci_min_number)
  
  #建構版次不為 1 時做判斷
  #如果版本比最大遞減允許值小, 且最大遞減允許值不為-1,則以最大遞減允許值為主
  IF (lo_DZAF_T.DZAF002 <> ci_construct_ver_one) THEN
    IF (NVL(li_sd_ver,ci_min_number) < li_sd_min_dec_num) AND (li_sd_min_dec_num <> ci_unlimit_number) THEN
      LET li_sd_ver = li_sd_min_dec_num
    END IF  
    IF (NVL(li_pr_ver,ci_min_number) < li_pr_min_dec_num) AND (li_pr_min_dec_num <> ci_unlimit_number) THEN
      LET li_pr_ver = li_pr_min_dec_num
    END IF  
  END IF 
  
  LET ls_using_mark = sadzp200_ver_get_curr_using_mark(lo_DZAF_T.*)
  LET ls_module     = sadzp200_ver_get_curr_module_name(lo_DZAF_T.*)

  #設定回傳資訊
  LET lo_result.DZAF002 = IIF(li_construct_ver==0,NULL,li_construct_ver) 
  LET lo_result.DZAF003 = IIF(li_sd_ver==0,NULL,li_sd_ver)
  LET lo_result.DZAF004 = IIF(li_pr_ver==0,NULL,li_pr_ver)
  LET lo_result.DZAF006 = NVL(lo_result.DZAF006,ls_module.trim())
  LET lo_result.DZAF010 = NVL(lo_result.DZAF010,ls_using_mark.trim())

  RETURN lo_result.*
  
END FUNCTION

FUNCTION sadzp200_ver_get_prev_ver_info_by_dgenv(p_DZAF_T,p_role)
DEFINE
  p_DZAF_T  T_DZAF_T,
  p_role    STRING
DEFINE
  lo_DZAF_T  T_DZAF_T,
  ls_role    STRING,
  lb_result  BOOLEAN,
  lo_DZLM_INFO T_DZLM_T,
  lo_result    T_DZAF_T
DEFINE
  lo_return  T_DZAF_T
  
  LET lo_DZAF_T.*  = p_DZAF_T.*
  LET ls_role = p_role

  LET lo_DZAF_T.DZAF007 = NVL(lo_DZAF_T.DZAF007,FGL_GETENV("ERPID"))
  LET lo_DZAF_T.DZAF008 = NVL(lo_DZAF_T.DZAF008,FGL_GETENV("ERPVER"))
  LET lo_DZAF_T.DZAF009 = NVL(lo_DZAF_T.DZAF009,FGL_GETENV("CUST"))
  LET lo_DZAF_T.DZAF010 = NVL(lo_DZAF_T.DZAF010,FGL_GETENV("DGENV"))
  
  LET lo_result.* = lo_DZAF_T.*

  CALL sadzp200_ver_get_dzlm_info(lo_DZAF_T.DZAF001) RETURNING lo_DZLM_INFO.*

  IF (lo_DZAF_T.DZAF010 = cs_dgenv_customize) AND (lo_DZLM_INFO.DZLM005 = 1) THEN
    LET lo_DZAF_T.DZAF002 = NULL
    CALL sadzp200_ver_check_if_base_is_standard(lo_DZAF_T.DZAF001) RETURNING lb_result  
    IF lb_result THEN 
      LET lo_DZAF_T.DZAF010 = cs_dgenv_standard
      CALL sadzp200_ver_get_curr_ver_info(lo_DZAF_T.*) RETURNING lo_result.*
    ELSE 
      INITIALIZE lo_result TO NULL  
    END IF   
  ELSE
    CALL sadzp200_ver_get_prev_ver_info(lo_DZAF_T.*,ls_role) RETURNING lo_result.*
  END IF

  {   
  #先取輸入的是否有值
  CALL sadzp200_ver_get_prev_ver_info(lo_DZAF_T.*,ls_role) RETURNING lo_result.*

  #判斷回傳建構版次若為空值,且前一輸入的環境為客制,則重新取標準的最後版本  
  IF (lo_DZAF_T.DZAF010 = cs_dgenv_customize) AND (lo_result.DZAF002 = 0) THEN
    LET lo_DZAF_T.* = lo_result.*
    LET lo_DZAF_T.DZAF010 = cs_dgenv_standard
    CALL sadzp200_ver_get_curr_ver_info(lo_DZAF_T.*) RETURNING lo_result.*
  END IF 
  }
  
  LET lo_return.* = lo_result.*

  RETURN lo_return.*

END FUNCTION 

FUNCTION sadzp200_ver_get_dzlm_info(p_program_name)
DEFINE
  p_program_name  STRING 
DEFINE
  ls_program_name  STRING,
  ls_SQL           STRING,
  li_count         INTEGER
DEFINE 
  lo_return  T_DZLM_T
  
  LET ls_program_name = p_program_name.toLowerCase()
  
  LET ls_SQL = "SELECT DZLM001,DZLM002,DZLM003,DZLM004,DZLM005, ",
               "       DZLM006,DZLM007,DZLM008,DZLM009,DZLM010, ",
               "       DZLM011,DZLM012,DZLM013,DZLM014,DZLM015, ",
               "       DZLM016,DZLM017,DZLM018,DZLM019,DZLM020, ",
               "       DZLM021                                  ",
               "  FROM DZLM_T                                   ",
               " WHERE DZLM002 = '",ls_program_name,"'          ",
               "   AND DZLM017 IS NULL                          ",
               "   AND (                                        ",
               "        (DZLM008 = '",cs_check_out,"')          ",
               "        OR                                      ",  
               "        (DZLM011 = '",cs_check_out,"')          ",
               "       )                                        " 

  PREPARE lpre_get_dzlm_info FROM ls_sql
  DECLARE lcur_get_dzlm_info CURSOR FOR lpre_get_dzlm_info

  LET li_count = 1

  TRY 
    OPEN lcur_get_dzlm_info
    FETCH lcur_get_dzlm_info INTO lo_return.*
    CLOSE lcur_get_dzlm_info
    FREE lcur_get_dzlm_info
    FREE lpre_get_dzlm_info
  CATCH
    DISPLAY ls_SQL
  END TRY 
  
  RETURN lo_return.*  
  
END FUNCTION

FUNCTION sadzp200_ver_get_max_construct_version(p_DZAF_T)
DEFINE
  p_DZAF_T  T_DZAF_T
DEFINE
  lo_DZAF_T      T_DZAF_T,
  li_max_dzaf002 INTEGER  
DEFINE
  li_return INTEGER
  
  LET lo_DZAF_T.* = p_DZAF_T.*

  #SELECT MAX(CAST(NVL(TRIM(DZAF002),"0") AS INTEGER))
  SELECT MAX(NVL(DZAF002,0)) 
    INTO li_max_dzaf002
    FROM DZAF_T
   WHERE DZAF001 = lo_DZAF_T.DZAF001
     AND DZAF005 = lo_DZAF_T.DZAF005
     --AND DZAF007 = lo_DZAF_T.DZAF007
     --AND DZAF008 = lo_DZAF_T.DZAF008
     AND DZAF010 = lo_DZAF_T.DZAF010

  LET li_return = NVL(li_max_dzaf002,0)     

  RETURN li_return     
  
END FUNCTION

FUNCTION sadzp200_ver_get_curr_sd_version(p_DZAF_T)
DEFINE
  p_DZAF_T  T_DZAF_T
DEFINE
  lo_DZAF_T      T_DZAF_T,
  li_max_dzaf003 INTEGER  
DEFINE
  li_return INTEGER
  
  LET lo_DZAF_T.* = p_DZAF_T.*

  #SELECT CAST(NVL(TRIM(DZAF003),"0") AS INTEGER)
  SELECT NVL(DZAF003,0)
    INTO li_max_dzaf003
    FROM DZAF_T
   WHERE DZAF001 = lo_DZAF_T.DZAF001
     AND DZAF002 = lo_DZAF_T.DZAF002
     AND DZAF005 = lo_DZAF_T.DZAF005
     --AND DZAF007 = lo_DZAF_T.DZAF007
     --AND DZAF008 = lo_DZAF_T.DZAF008
     AND DZAF010 = lo_DZAF_T.DZAF010

  LET li_return = li_max_dzaf003     

  RETURN li_return     
  
END FUNCTION

FUNCTION sadzp200_ver_get_curr_pr_version(p_DZAF_T)
DEFINE
  p_DZAF_T  T_DZAF_T
DEFINE
  lo_DZAF_T      T_DZAF_T,
  li_max_dzaf004 INTEGER  
DEFINE
  li_return INTEGER
  
  LET lo_DZAF_T.* = p_DZAF_T.*

  SELECT NVL(DZAF004,0)
    INTO li_max_dzaf004
    FROM DZAF_T
   WHERE DZAF001 = lo_DZAF_T.DZAF001
     AND DZAF002 = lo_DZAF_T.DZAF002
     AND DZAF005 = lo_DZAF_T.DZAF005
     --AND DZAF007 = lo_DZAF_T.DZAF007
     --AND DZAF008 = lo_DZAF_T.DZAF008
     AND DZAF010 = lo_DZAF_T.DZAF010

  LET li_return = li_max_dzaf004     

  RETURN li_return     
  
END FUNCTION

FUNCTION sadzp200_ver_get_max_sd_version(p_DZAF_T)
DEFINE
  p_DZAF_T  T_DZAF_T
DEFINE
  lo_DZAF_T      T_DZAF_T,
  li_max_dzaf003 INTEGER  
DEFINE
  li_return INTEGER
  
  LET lo_DZAF_T.* = p_DZAF_T.*

  SELECT MAX(NVL(DZAF003,0))
    INTO li_max_dzaf003
    FROM DZAF_T
   WHERE DZAF001 = lo_DZAF_T.DZAF001
     --AND DZAF002 = lo_DZAF_T.DZAF002
     AND DZAF005 = lo_DZAF_T.DZAF005
     --AND DZAF007 = lo_DZAF_T.DZAF007
     --AND DZAF008 = lo_DZAF_T.DZAF008
     AND DZAF010 = lo_DZAF_T.DZAF010

  LET li_return = li_max_dzaf003     

  RETURN li_return     
  
END FUNCTION

FUNCTION sadzp200_ver_get_max_pr_version(p_DZAF_T)
DEFINE
  p_DZAF_T  T_DZAF_T
DEFINE
  lo_DZAF_T      T_DZAF_T,
  li_max_dzaf004 INTEGER  
DEFINE
  li_return INTEGER
  
  LET lo_DZAF_T.* = p_DZAF_T.*

  SELECT MAX(NVL(DZAF004,0))
    INTO li_max_dzaf004
    FROM DZAF_T
   WHERE DZAF001 = lo_DZAF_T.DZAF001
     --AND DZAF002 = lo_DZAF_T.DZAF002
     AND DZAF005 = lo_DZAF_T.DZAF005
     --AND DZAF007 = lo_DZAF_T.DZAF007
     --AND DZAF008 = lo_DZAF_T.DZAF008
     AND DZAF010 = lo_DZAF_T.DZAF010

  LET li_return = li_max_dzaf004     

  RETURN li_return     
  
END FUNCTION

FUNCTION sadzp200_ver_get_curr_using_mark(p_DZAF_T)
DEFINE
  p_DZAF_T  T_DZAF_T
DEFINE
  lo_DZAF_T  T_DZAF_T,
  ls_dzaf010 VARCHAR(10)
DEFINE
  ls_return STRING
  
  LET lo_DZAF_T.* = p_DZAF_T.*

  SELECT DZAF010
    INTO ls_dzaf010
    FROM DZAF_T
   WHERE DZAF001 = lo_DZAF_T.DZAF001
     AND DZAF002 = lo_DZAF_T.DZAF002
     AND DZAF005 = lo_DZAF_T.DZAF005
     --AND DZAF007 = lo_DZAF_T.DZAF007
     --AND DZAF008 = lo_DZAF_T.DZAF008
     AND DZAF010 = lo_DZAF_T.DZAF010

  LET ls_return = ls_dzaf010     
  LET ls_return = ls_return.trim()     

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp200_ver_get_curr_module_name(p_DZAF_T)
DEFINE
  p_DZAF_T  T_DZAF_T
DEFINE
  lo_DZAF_T  T_DZAF_T,
  ls_dzaf006 VARCHAR(10)
DEFINE
  ls_return STRING
  
  LET lo_DZAF_T.* = p_DZAF_T.*

  SELECT DZAF006
    INTO ls_dzaf006
    FROM DZAF_T
   WHERE DZAF001 = lo_DZAF_T.DZAF001
     AND DZAF002 = lo_DZAF_T.DZAF002
     AND DZAF005 = lo_DZAF_T.DZAF005
     --AND DZAF007 = lo_DZAF_T.DZAF007
     --AND DZAF008 = lo_DZAF_T.DZAF008
     AND dzaf010 = lo_DZAF_T.dzaf010

  LET ls_return = ls_dzaf006     
  LET ls_return = ls_return.trim()     

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp200_ver_set_ver(p_DZAF_T,p_user_role)
DEFINE
  p_DZAF_T    T_DZAF_T,
  p_user_role STRING
DEFINE
  lo_DZAF_T     T_DZAF_T,
  ls_user_role  STRING,
  ls_insert_sql STRING,
  ls_update_sql STRING,
  ls_set_version STRING
DEFINE
  lb_return BOOLEAN  
  
  LET lo_DZAF_T.* = p_DZAF_T.*
  LET ls_user_role = p_user_role

  LET ls_insert_sql = ""
  LET ls_update_sql = ""

  CASE 
    WHEN ls_user_role = cs_user_role_sd
      LET ls_set_version = "SET DZAF003 = ",NVL(sadzp200_util_trim(lo_DZAF_T.DZAF003),"NULL"),""
    WHEN ls_user_role = cs_user_role_pr
      LET ls_set_version = "SET DZAF004 = ",NVL(sadzp200_util_trim(lo_DZAF_T.DZAF004),"NULL"),""
  END CASE 

  LET ls_insert_sql = "INSERT INTO DZAF_T(                                                      ",
                      "                    dzaf001,dzaf002,dzaf003,dzaf004,dzaf005,             ",
                      "                    dzaf006,dzaf007,dzaf008,dzaf009,dzaf010              ",
                      "                  )                                                      ",
                      "            VALUES(                                                      ",
                      "                   '",lo_DZAF_T.DZAF001,"',                              ",
                      "                   ",NVL(sadzp200_util_trim(lo_DZAF_T.DZAF002),"NULL"),",",
                      "                   ",NVL(sadzp200_util_trim(lo_DZAF_T.DZAF003),"NULL"),",",
                      "                   ",NVL(sadzp200_util_trim(lo_DZAF_T.DZAF004),"NULL"),",",
                      "                   '",sadzp200_util_trim(lo_DZAF_T.DZAF005),"',          ",
                      "                   '",sadzp200_util_trim(lo_DZAF_T.DZAF006),"',          ",
                      "                   '",sadzp200_util_trim(lo_DZAF_T.DZAF007),"',          ",
                      "                   '",sadzp200_util_trim(lo_DZAF_T.DZAF008),"',          ",
                      "                   '",sadzp200_util_trim(lo_DZAF_T.DZAF009),"',          ",
                      "                   '",sadzp200_util_trim(lo_DZAF_T.DZAF010),"'           ",
                      "                  )                                                      "

  LET ls_update_sql = " UPDATE DZAF_T                                              ",
                      ls_set_version,
                      " WHERE 1=1                                                  ",
                      "   AND dzaf001 = '",sadzp200_util_trim(lo_DZAF_T.DZAF001),"'",
                      "   AND dzaf002 = ",NVL(sadzp200_util_trim(lo_DZAF_T.DZAF002),"NULL"),"",
                      "   AND dzaf005 = '",sadzp200_util_trim(lo_DZAF_T.DZAF005),"'",
                      --"   AND dzaf007 = '",sadzp200_util_trim(lo_DZAF_T.DZAF007),"'",
                      --"   AND dzaf008 = '",sadzp200_util_trim(lo_DZAF_T.DZAF008),"'",
                      "   AND dzaf010 = '",sadzp200_util_trim(lo_DZAF_T.DZAF010),"'"
                      
  TRY
    PREPARE lpre_insert_dzaf FROM ls_insert_sql
    EXECUTE lpre_insert_dzaf
    LET lb_return = TRUE 
  CATCH
    LET lb_return = FALSE 
    DISPLAY cs_warning_tag,"Insert into dzaf_t unsuccess, maybe key duplicate."
    TRY
      PREPARE lpre_update_dzaf FROM ls_update_sql
      EXECUTE lpre_update_dzaf
      LET lb_return = TRUE 
    CATCH
      LET lb_return = FALSE 
      DISPLAY cs_warning_tag,"Update dzaf_t unsuccess."
    END TRY 
  END TRY

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzp200_ver_display_ver_info(p_DZAF_T)
DEFINE
  p_DZAF_T  T_DZAF_T
DEFINE
  lo_DZAF_T  T_DZAF_T
  
  LET lo_DZAF_T.*  = p_DZAF_T.*

  DISPLAY cs_information_tag,"DZAF001 : ",lo_DZAF_T.DZAF001
  DISPLAY cs_information_tag,"DZAF002 : ",lo_DZAF_T.DZAF002
  DISPLAY cs_information_tag,"DZAF003 : ",lo_DZAF_T.DZAF003
  DISPLAY cs_information_tag,"DZAF004 : ",lo_DZAF_T.DZAF004
  DISPLAY cs_information_tag,"DZAF005 : ",lo_DZAF_T.DZAF005
  DISPLAY cs_information_tag,"DZAF006 : ",lo_DZAF_T.DZAF006
  DISPLAY cs_information_tag,"DZAF007 : ",lo_DZAF_T.DZAF007
  DISPLAY cs_information_tag,"DZAF008 : ",lo_DZAF_T.DZAF008
  DISPLAY cs_information_tag,"DZAF009 : ",lo_DZAF_T.DZAF009
  DISPLAY cs_information_tag,"DZAF010 : ",lo_DZAF_T.DZAF010
  
END FUNCTION

FUNCTION sadzp200_ver_delete_data(p_DZLM_T,p_DGENV)
DEFINE
  p_DZLM_T  T_DZLM_T,
  p_DGENV   STRING
DEFINE
  lo_DZLM_T  T_DZLM_T,
  lv_DGENV   VARCHAR(2)
DEFINE 
  lb_return BOOLEAN 
  
  LET lo_DZLM_T.* = p_DZLM_T.*
  LET lv_DGENV    = p_DGENV.trim()

  DELETE FROM DZAF_T
   WHERE DZAF001 = lo_DZLM_T.DZLM002
     AND DZAF002 = lo_DZLM_T.DZLM005
     AND DZAF005 = lo_DZLM_T.DZLM001
     --AND DZAF007 = lo_DZLM_T.DZLM013
     --AND DZAF008 = lo_DZLM_T.DZLM014
     AND DZAF010 = lv_DGENV

  IF SQLCA.sqlcode = 0 THEN
    LET lb_return = TRUE
  ELSE
    LET lb_return = FALSE
  END IF 
  
  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzp200_ver_decreas_dzaf_ver(p_DZAF_T,p_user_role)
DEFINE
  p_DZAF_T    T_DZAF_T,
  p_user_role STRING
DEFINE
  lo_DZAF_T           T_DZAF_T,
  li_sd_version       INTEGER,
  li_pr_version       INTEGER,
  ls_user_role        STRING,
  li_sd_min_dec_num   INTEGER,
  li_pr_min_dec_num   INTEGER
DEFINE 
  lo_return  T_DZAF_T
  
  LET lo_DZAF_T.* = p_DZAF_T.*
  LET ls_user_role = p_user_role

  #取得SD,PR最大遞減允許值
  LET li_sd_min_dec_num  = NVL(sadzp200_ver_get_parameter(cs_ver_type_sd,cs_min_decrease_number),ci_min_number) 
  LET li_pr_min_dec_num  = NVL(sadzp200_ver_get_parameter(cs_ver_type_pr,cs_min_decrease_number),ci_min_number) 
  
  CASE 
    WHEN ls_user_role = cs_user_role_sd
      LET li_sd_version = lo_DZAF_T.DZAF003
      IF NVL(li_sd_version,ci_min_number) <= li_sd_min_dec_num THEN
        LET li_sd_version = li_sd_version
      ELSE
        #若版次為1, 則減1後設為NULL
        IF li_sd_version = 1 THEN
          LET li_sd_version = ""
        ELSE 
          LET li_sd_version = li_sd_version - 1
        END IF
      END IF  
      LET lo_DZAF_T.DZAF003 = li_sd_version
    WHEN ls_user_role = cs_user_role_pr
      LET li_pr_version = lo_DZAF_T.DZAF004
      IF NVL(li_pr_version,ci_min_number) <= li_pr_min_dec_num THEN
        LET li_pr_version = li_pr_version
      ELSE 
        #若版次為1, 則減1後設為NULL
        IF li_pr_version = 1 THEN
          LET li_pr_version = ""
        ELSE 
          LET li_pr_version = li_pr_version - 1
        END IF
      END IF
      LET lo_DZAF_T.DZAF004 = li_pr_version
  END CASE

  LET lo_return.* = lo_DZAF_T.*
  
  RETURN lo_return.*  
  
END FUNCTION

#檢核程式本質是否為標準程式
FUNCTION sadzp200_ver_check_if_base_is_standard(p_prog_name)
DEFINE
  p_prog_name STRING
DEFINE
  ls_prog_name   STRING,
  ls_sql         STRING,
  li_counts      INTEGER
DEFINE   
  lb_return BOOLEAN
  
  LET ls_prog_name = p_prog_name.toLowerCase()

  LET ls_sql = "SELECT COUNT(*)                            ",
               "  FROM DZAF_T AF                           ",
               " WHERE AF.DZAF001 = '",ls_prog_name,"'     ",
               "   AND AF.DZAF010 = '",cs_dgenv_standard,"'"      
                                       
  PREPARE lpre_check_if_standard FROM ls_sql
  DECLARE lcur_check_if_standard CURSOR FOR lpre_check_if_standard

  OPEN lcur_check_if_standard
  FETCH lcur_check_if_standard INTO li_counts
  CLOSE lcur_check_if_standard
  
  FREE lpre_check_if_standard
  FREE lcur_check_if_standard  

  LET lb_return = IIF(li_counts > 0,TRUE,FALSE)
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp200_ver_get_program_curr_dgenv(p_prog_name)
DEFINE
  p_prog_name STRING 
DEFINE
  ls_prog_name STRING,
  ls_sql       STRING,
  lo_dgenvs    DYNAMIC ARRAY OF VARCHAR(2),
  ls_sys_dgenv STRING,
  ls_dgnev     STRING,
  li_count     INTEGER
DEFINE
  ls_return STRING

  LET ls_prog_name = p_prog_name

  LET li_count = 1
  LET ls_sys_dgenv = FGL_GETENV("DGENV")
  LET ls_dgnev = ""

  -- 因為有 order by , 所以 'c' 一定排第一個
  LET ls_sql = "SELECT DISTINCT AF.DZAF010              ", 
               "  FROM DZAF_T AF                        ", 
               " WHERE AF.DZAF001 = '",ls_prog_name,"'  ", 
               " ORDER BY AF.DZAF010                    "  
               
  PREPARE lpre_get_program_curr_dgenv FROM ls_sql
  DECLARE lcur_get_program_curr_dgenv CURSOR FOR lpre_get_program_curr_dgenv

  OPEN lcur_get_program_curr_dgenv
  FOREACH lcur_get_program_curr_dgenv INTO lo_dgenvs[li_count]
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    LET li_count = li_count + 1
  END FOREACH
  CLOSE lcur_get_program_curr_dgenv
  
  FREE lpre_get_program_curr_dgenv
  FREE lcur_get_program_curr_dgenv  

  LET ls_dgnev = lo_dgenvs[1] -- 取第一個值(c或s由此決定)
  LET ls_return = NVL(ls_dgnev,ls_sys_dgenv)

  RETURN ls_return  
  
END FUNCTION 

FUNCTION sadzp200_ver_get_parameter(p_level,p_param)
DEFINE
  p_level STRING,
  p_param STRING
DEFINE
  ls_level     STRING,
  ls_param     STRING,
  ls_sql       STRING,
  lv_parameter VARCHAR(1024) 
DEFINE
  ls_return    STRING

  LET ls_level = p_level
  LET ls_param = p_param

  LET ls_sql = "SELECT EJ.DZEJ005                        ",
               "  FROM DZEJ_T EJ                         ",
               " WHERE EJ.DZEJ001 = 'adzp200_parameters' ",
               "   AND EJ.DZEJ003 = '",ls_level,"'       ",
               "   AND EJ.DZEJ004 = '",ls_param,"'       "
                              
  PREPARE lpre_get_parameter FROM ls_sql
  DECLARE lcur_get_parameter CURSOR FOR lpre_get_parameter

  OPEN lcur_get_parameter
  FETCH lcur_get_parameter INTO lv_parameter
  CLOSE lcur_get_parameter
  
  FREE lpre_get_parameter
  FREE lcur_get_parameter  

  LET ls_return = lv_parameter
  
  RETURN ls_return.trim()
  
END FUNCTION