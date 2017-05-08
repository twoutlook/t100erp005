# 160504-00002   : 20160505  by ernest: 1.針對釋出的新增
# 160729-00008   : 20160729  by ernest: 1.針對DZLM_T簽出的預先處理
# 160919-00031   : 20160919  by ernest: 1.修改新增 P65T 關卡後的釋出方式
# 161129-00001   : 20161129  by ernest: 1.當簽出者為 topstd 時, 不啟動版次修正機制

&include "../4gl/sadzp000_mcr.inc"

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"

CONSTANT 
  cs_request_divider STRING = "#",
  cs_4gl_mark_sign   STRING = "#",  
  cs_4gl_mark_begin  STRING = "-s",  
  cs_4gl_mark_end    STRING = "-e",
  cs_4gl_extend      STRING = ".4gl"  

PRIVATE TYPE T_ROLE_POWER RECORD
              rp_VERSION  INTEGER,     -- 版號
              rp_NUMBER   VARCHAR(30), -- 工號
              rp_STATUS   VARCHAR(10)  -- 狀態
             END RECORD
            
#將從 DZLU 及 DZAF 取得的資料彙整到 DZLM_T 中
FUNCTION sadzp200_alm_set_dzlm_mix_info(p_DZLU_T,p_DZAF_T,p_program_info,p_guid)
DEFINE
  p_DZLU_T       T_DZLU_T,
  p_DZAF_T       T_DZAF_T,
  p_program_info T_PROGRAM_INFO,
  p_guid         STRING   
DEFINE
  lo_DZLU_T       T_DZLU_T,
  lo_DZAF_T       T_DZAF_T,
  lo_program_info T_PROGRAM_INFO,  
  lv_guid         VARCHAR(40),
  lv_sd_guid      VARCHAR(40),
  lv_pr_guid      VARCHAR(40),
  lo_DZLM_T       T_DZLM_T,
  lo_SD_POWER     T_ROLE_POWER,
  lo_PR_POWER     T_ROLE_POWER,
  lb_result       BOOLEAN,
  ls_update_type  STRING
DEFINE
  lb_return BOOLEAN  

  LET lo_DZLU_T.* = p_DZLU_T.*  
  LET lo_DZAF_T.* = p_DZAF_T.*   
  LET lo_program_info.* = p_program_info.* 
  LET lv_guid = p_guid.trim()

  INITIALIZE lo_SD_POWER TO NULL
  INITIALIZE lo_PR_POWER TO NULL
  
  LET lv_sd_guid = ""
  LET lv_pr_guid = ""

  CASE 
    WHEN lo_DZLU_T.DZLU001 = cs_user_role_sd
      LET lo_SD_POWER.rp_VERSION = lo_DZAF_T.DZAF003  
      LET lo_SD_POWER.rp_NUMBER  = lo_DZLU_T.DZLU002
      LET lo_SD_POWER.rp_STATUS  = cs_check_out
      LET lv_sd_guid = lv_guid
    WHEN lo_DZLU_T.DZLU001 = cs_user_role_pr
      LET lo_PR_POWER.rp_VERSION = lo_DZAF_T.DZAF004  
      LET lo_PR_POWER.rp_NUMBER  = lo_DZLU_T.DZLU002
      LET lo_PR_POWER.rp_STATUS  = cs_check_out
      LET lv_pr_guid = lv_guid
  END CASE 

  LET lo_DZLM_T.DZLM001 = lo_DZAF_T.DZAF005
  LET lo_DZLM_T.DZLM002 = lo_DZAF_T.DZAF001
  LET lo_DZLM_T.DZLM003 = lo_program_info.pi_DESC
  LET lo_DZLM_T.DZLM004 = lo_DZAF_T.DZAF006
  LET lo_DZLM_T.DZLM005 = lo_DZAF_T.DZAF002
  -----------------------------------------
  -- SD
  LET lo_DZLM_T.DZLM006 = lo_SD_POWER.rp_VERSION
  LET lo_DZLM_T.DZLM007 = lo_SD_POWER.rp_NUMBER 
  LET lo_DZLM_T.DZLM008 = lo_SD_POWER.rp_STATUS 
  -- PR
  LET lo_DZLM_T.DZLM009 = lo_PR_POWER.rp_VERSION
  LET lo_DZLM_T.DZLM010 = lo_PR_POWER.rp_NUMBER 
  LET lo_DZLM_T.DZLM011 = lo_PR_POWER.rp_STATUS 
  -----------------------------------------
  LET lo_DZLM_T.DZLM012 = lo_DZLU_T.DZLU003
  LET lo_DZLM_T.DZLM013 = lo_DZLU_T.DZLU004
  LET lo_DZLM_T.DZLM014 = lo_DZLU_T.DZLU005
  LET lo_DZLM_T.DZLM015 = lo_DZLU_T.DZLU006
  LET lo_DZLM_T.DZLM016 = lo_DZAF_T.DZAF009
  LET lo_DZLM_T.DZLM017 = NULL -- 簽入時間
  LET lo_DZLM_T.DZLM018 = lv_sd_guid
  LET lo_DZLM_T.DZLM019 = lv_pr_guid
  LET lo_DZLM_T.DZLM020 = "N"
  LET lo_DZLM_T.DZLM021 = "N"

  #160729-00008 begin
  #161129-00001 begin
  IF (NVL(lo_DZLM_T.DZLM007,cs_null_default) <> cs_topstd_user_name) AND (NVL(lo_DZLM_T.DZLM010,cs_null_default) <> cs_topstd_user_name) THEN
    CALL sadzp200_alm_check_and_rearrange_dzlm(lo_DZLM_T.*,lo_DZLU_T.DZLU001) RETURNING lb_result
  END IF
  #161129-00001 end
  #160729-00008 end
  CALL sadzp200_alm_set_dzlm(lo_DZLM_T.*,lo_DZLU_T.DZLU001) RETURNING lb_result,ls_update_type 

  LET lb_return = lb_result

  RETURN lb_return,ls_update_type
  
END FUNCTION 

FUNCTION sadzp200_alm_check_data_exist(p_DZLU_T,p_DZAF_T)
DEFINE
  p_DZLU_T  T_DZLU_T,
  p_DZAF_T  T_DZAF_T
DEFINE
  lo_DZLU_T    T_DZLU_T,
  lo_DZAF_T    T_DZAF_T,
  li_counts    INTEGER
DEFINE 
  lb_return BOOLEAN 
  
  LET lo_DZLU_T.* = p_DZLU_T.*  
  LET lo_DZAF_T.* = p_DZAF_T.*

  SELECT COUNT(*) 
    INTO li_counts
    FROM DZLM_T
   WHERE DZLM001 = lo_DZAF_T.DZAF005
     AND DZLM002 = lo_DZAF_T.DZAF001
     AND DZLM005 = lo_DZAF_T.DZAF002
     AND DZLM012 = lo_DZLU_T.DZLU003
     AND DZLM013 = lo_DZLU_T.DZLU004
     AND DZLM014 = lo_DZLU_T.DZLU005
     --AND DZLM015 = lo_DZLU_T.DZLU006 --項次不比對
     AND (DZLM008 = cs_check_out OR DZLM011 = cs_check_out)    
     AND DZLM017 IS NULL

  LET lb_return = IIF(li_counts > 0,TRUE,FALSE)

  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzp200_alm_check_item_if_exist(p_program_info,p_role)
DEFINE
  p_program_info  T_PROGRAM_INFO,
  p_role          STRING 
DEFINE
  lo_program_info  T_PROGRAM_INFO,
  ls_ROLE      STRING,
  li_counts    INTEGER,
  ls_sql       STRING,
  ls_where_sql STRING
DEFINE 
  lb_return BOOLEAN 

  LET lo_program_info.* = p_program_info.*
  LET ls_ROLE = p_role
  
  CASE ls_ROLE
    WHEN cs_user_role_all
      LET ls_where_sql = " ((DZLM008 = '",cs_check_out,"') OR (DZLM011 = '",cs_check_out,"'))"
    WHEN cs_user_role_sd
      LET ls_where_sql = " DZLM008 = '",cs_check_out,"'"
    WHEN cs_user_role_pr
      LET ls_where_sql = " DZLM011 = '",cs_check_out,"'"
  END CASE 

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(*)                                 ",
               "  FROM DZLM_T                                   ",
               " WHERE DZLM001 = '",lo_program_info.pi_TYPE,"'  ",  
               "   AND DZLM002 = '",lo_program_info.pi_NAME,"'  ",
               --"   AND DZLM004 = '",lo_program_info.pi_MODULE,"'",
               "   AND DZLM017 IS NULL                          ",
               "   AND ",
               ls_where_sql

  TRY              
    PREPARE lpre_check_item_if_exist FROM ls_sql
    DECLARE lcur_check_item_if_exist CURSOR FOR lpre_check_item_if_exist
    OPEN lcur_check_item_if_exist
    FETCH lcur_check_item_if_exist INTO li_counts
    CLOSE lcur_check_item_if_exist
    FREE lcur_check_item_if_exist
    FREE lpre_check_item_if_exist
  CATCH
    DISPLAY cs_error_tag,ls_sql 
  END TRY   
  
  LET lb_return = IIF(li_counts > 0,TRUE,FALSE)
  
  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzp200_alm_get_alm_owner_by_role(p_program_info,p_role)
DEFINE
  p_program_info  T_PROGRAM_INFO,
  p_role          STRING 
DEFINE
  lo_program_info T_PROGRAM_INFO,
  ls_ROLE         STRING,
  ls_sql          STRING,
  ls_where_sql    STRING,
  ls_field        STRING,
  ls_owner        VARCHAR(20)
DEFINE 
  lb_return  BOOLEAN,
  ls_return  VARCHAR(20)

  LET lo_program_info.* = p_program_info.*
  LET ls_ROLE = p_role

  LET ls_owner  = ""
  
  CASE ls_ROLE
    WHEN cs_user_role_sd
      LET ls_field = "DZLM007"
      LET ls_where_sql = " DZLM008 = '",cs_check_out,"'"
    WHEN cs_user_role_pr
      LET ls_field = "DZLM010"
      LET ls_where_sql = " DZLM011 = '",cs_check_out,"'"
  END CASE 

  #取得資料筆數
  LET ls_sql = "SELECT ",ls_field,"                             ",
               "  FROM DZLM_T                                   ",
               " WHERE DZLM001 = '",lo_program_info.pi_TYPE,"'  ",  
               "   AND DZLM002 = '",lo_program_info.pi_NAME,"'  ",
               --"   AND DZLM004 = '",lo_program_info.pi_MODULE,"'",
               "   AND DZLM017 IS NULL                          ",
               "   AND ",
               ls_where_sql

  TRY              
    PREPARE lpre_get_alm_owner_by_role FROM ls_sql
    DECLARE lcur_get_alm_owner_by_role CURSOR FOR lpre_get_alm_owner_by_role
    OPEN lcur_get_alm_owner_by_role
    FETCH lcur_get_alm_owner_by_role INTO ls_owner
    CLOSE lcur_get_alm_owner_by_role
    FREE lcur_get_alm_owner_by_role
    FREE lpre_get_alm_owner_by_role
  CATCH
    DISPLAY cs_error_tag,ls_sql 
  END TRY

  LET lb_return = IIF(ls_owner IS NULL,FALSE,TRUE)
  LET ls_return = ls_owner  
               
  RETURN lb_return,ls_return 
  
END FUNCTION

FUNCTION sadzp200_alm_get_alm_request_information_by_role(p_program_info,p_role)
DEFINE
  p_program_info  T_PROGRAM_INFO,
  p_role          STRING 
DEFINE
  lo_program_info T_PROGRAM_INFO,
  ls_ROLE         STRING,
  ls_sql          STRING,
  ls_where_sql    STRING,
  ls_field        STRING,
  lo_request_info T_REQUEST_INFORMATION
DEFINE 
  lb_return BOOLEAN,
  lo_return T_REQUEST_INFORMATION

  LET lo_program_info.* = p_program_info.*
  LET ls_ROLE = p_role

  CASE ls_ROLE
    WHEN cs_user_role_sd
      LET ls_field = "DZLM012,DZLM015"
      LET ls_where_sql = " DZLM008 = '",cs_check_out,"'"
    WHEN cs_user_role_pr
      LET ls_field = "DZLM012,DZLM015"
      LET ls_where_sql = " DZLM011 = '",cs_check_out,"'"
  END CASE 

  #取得需求資料
  LET ls_sql = "SELECT ",ls_field,"                             ",
               "  FROM DZLM_T                                   ",
               " WHERE DZLM001 = '",lo_program_info.pi_TYPE,"'  ",  
               "   AND DZLM002 = '",lo_program_info.pi_NAME,"'  ",
               --"   AND DZLM004 = '",lo_program_info.pi_MODULE,"'",
               "   AND DZLM017 IS NULL                          ",
               "   AND ",
               ls_where_sql

  TRY              
    PREPARE lpre_get_alm_request_information_by_role FROM ls_sql
    DECLARE lcur_get_alm_request_information_by_role CURSOR FOR lpre_get_alm_request_information_by_role
    OPEN lcur_get_alm_request_information_by_role
    FETCH lcur_get_alm_request_information_by_role INTO lo_request_info.*
    CLOSE lcur_get_alm_request_information_by_role
    FREE lcur_get_alm_request_information_by_role
    FREE lpre_get_alm_request_information_by_role
  CATCH
    DISPLAY cs_error_tag,ls_sql 
  END TRY

  LET lb_return = IIF(lo_request_info.ri_REQUEST_NO IS NULL,FALSE,TRUE)
  LET lo_return.* = lo_request_info.*
  
  RETURN lb_return,lo_return.*  
  
END FUNCTION

FUNCTION sadzp200_alm_get_owner_list(p_program_info)
DEFINE
  p_program_info  T_PROGRAM_INFO
DEFINE
  lo_program_info         T_PROGRAM_INFO,
  ls_role                 STRING,
  lo_check_out_owner_list DYNAMIC ARRAY OF T_CHECK_OUT_OWNER_LIST,
  lo_request_info         T_REQUEST_INFORMATION,
  lb_result               BOOLEAN,
  ls_owner                STRING,
  li_owner_list           INTEGER,
  lo_role_arr             T_STATIC_ROLE_LIST
DEFINE
  lo_return DYNAMIC ARRAY OF T_CHECK_OUT_OWNER_LIST

  LET lo_program_info.* = p_program_info.*

  LET li_owner_list = 1

  CALL sadzp200_util_get_static_role_list() RETURNING lo_role_arr

  FOR li_owner_list = 1 TO lo_role_arr.getLength()
    LET ls_role = lo_role_arr[li_owner_list]
    
    CALL sadzp200_alm_get_alm_owner_by_role(lo_program_info.*,ls_role) RETURNING lb_result,ls_owner
    IF NOT lb_result THEN DISPLAY cs_warning_tag,ls_role," no booking program ",lo_program_info.pi_NAME," (ROLE)." END IF 
    CALL sadzp200_alm_get_alm_request_information_by_role(lo_program_info.*,ls_role) RETURNING lb_result,lo_request_info.* 
    IF NOT lb_result THEN DISPLAY cs_warning_tag,ls_role," no booking program ",lo_program_info.pi_NAME," (REQUEST NO)." END IF 

    IF lb_result THEN 
      LET lo_check_out_owner_list[li_owner_list].cool_ROLE = ls_role
      LET lo_check_out_owner_list[li_owner_list].cool_ID   = ls_owner
      &ifndef DEBUG
      LET lo_check_out_owner_list[li_owner_list].cool_NAME = cl_get_accountname(ls_owner)
      &else
      LET lo_check_out_owner_list[li_owner_list].cool_NAME = ls_owner
      &endif
      LET lo_check_out_owner_list[li_owner_list].cool_REQUEST_NO  = lo_request_info.ri_REQUEST_NO 
      LET lo_check_out_owner_list[li_owner_list].cool_SEQUENCE_NO = lo_request_info.ri_SEQUENCE_NO
    END IF     
  END FOR
  
  LET lo_return = lo_check_out_owner_list

  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzp200_alm_check_item_if_check_out(p_DZLU_T,p_DZAF_T)
DEFINE
  p_DZLU_T T_DZLU_T,
  p_DZAF_T T_DZAF_T
DEFINE
  lo_DZLU_T    T_DZLU_T,
  lo_DZAF_T    T_DZAF_T,
  ls_ROLE      STRING,
  li_counts    INTEGER,
  ls_sql       STRING,
  ls_where_sql STRING,
  ls_or_sql    STRING
DEFINE 
  lb_return BOOLEAN 

  LET lo_DZLU_T.* = p_DZLU_T.*
  LET lo_DZAF_T.* = p_DZAF_T.*

  LET ls_ROLE = lo_DZLU_T.DZLU001
  
  CASE ls_ROLE
    WHEN cs_user_role_sd
      LET ls_where_sql = " DZLM008 = '",cs_check_out,"'"
      LET ls_or_sql    = " DZLM011 = '",cs_check_out,"'"
    WHEN cs_user_role_pr
      LET ls_where_sql = " DZLM011 = '",cs_check_out,"'"
      LET ls_or_sql    = " DZLM008 = '",cs_check_out,"'"
  END CASE 

  #取得資料筆數(相同需求單號及序號)
  LET ls_sql = "SELECT COUNT(*)                                                        ",
               "  FROM DZLM_T                                                          ",
               " WHERE DZLM001 = '",lo_DZAF_T.DZAF005,"'                               ",  
               "   AND DZLM002 = '",lo_DZAF_T.DZAF001,"'                               ",
               --"   AND DZLM004 = '",lo_DZAF_T.DZAF006,"'                               ",
               "   AND DZLM017 IS NULL                                                 ",
               "   AND (DZLM012||DZLM015) = '",lo_DZLU_T.DZLU003||lo_DZLU_T.DZLU006,"' ",
               "   AND ",
               ls_where_sql

  TRY              
    PREPARE lpre_get_same_sr FROM ls_sql
    DECLARE lcur_get_same_sr CURSOR FOR lpre_get_same_sr
    OPEN lcur_get_same_sr
    FETCH lcur_get_same_sr INTO li_counts
    CLOSE lcur_get_same_sr
    FREE lcur_get_same_sr
    FREE lpre_get_same_sr
  CATCH
    DISPLAY cs_error_tag,ls_sql 
  END TRY   
  
  LET lb_return = IIF(li_counts > 0,TRUE,FALSE)
  IF lb_return THEN GOTO _return END IF
  
  #取得資料筆數(不同需求單號及序號)
  LET ls_sql = "SELECT COUNT(*)                                                        ",
               "  FROM DZLM_T                                                          ",
               " WHERE DZLM001 = '",lo_DZAF_T.DZAF005,"'                               ",  
               "   AND DZLM002 = '",lo_DZAF_T.DZAF001,"'                               ",
               --"   AND DZLM004 = '",lo_DZAF_T.DZAF006,"'                               ",
               "   AND DZLM017 IS NULL                                                 ",
               "   AND (DZLM012||DZLM015) <> '",lo_DZLU_T.DZLU003||lo_DZLU_T.DZLU006,"'",
               "   AND (                                                               ",                                        
               ls_where_sql,
               "   OR EXISTS (                                                         ",
               "                SELECT 1                                               ",
               "                  FROM DZLM_T LMB                                      ",
               "                 WHERE LMB.DZLM001 = DZLM001                           ",
               "                   AND LMB.DZLM002 = DZLM002                           ",
               "                   AND LMB.DZLM005 = DZLM005                           ",
               "                   AND ",ls_or_sql,
               "                   AND LMB.DZLM012 = DZLM012                           ",
               "                   AND LMB.DZLM013 = DZLM013                           ",
               "                   AND LMB.DZLM014 = DZLM014                           ",
               "              )                                                        ",
               "       )                                                               "

  TRY              
    PREPARE lpre_get_diff_sr FROM ls_sql
    DECLARE lcur_get_diff_sr CURSOR FOR lpre_get_diff_sr
    OPEN lcur_get_diff_sr
    FETCH lcur_get_diff_sr INTO li_counts
    CLOSE lcur_get_diff_sr
    FREE lcur_get_diff_sr
    FREE lpre_get_diff_sr
  CATCH 
    DISPLAY cs_error_tag,ls_sql 
  END TRY 
  
  LET lb_return = IIF(li_counts > 0,TRUE,FALSE)
  IF lb_return THEN GOTO _return END IF

  LABEL _return:
  
  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzp200_alm_get_dzlm(p_program_info,p_role)
DEFINE
  p_program_info  T_PROGRAM_INFO,
  p_role          STRING 
DEFINE
  lo_program_info  T_PROGRAM_INFO,
  ls_ROLE          STRING,
  ls_SQL           STRING,
  ls_where_sql     STRING,
  li_count         INTEGER
DEFINE 
  lo_return  T_DZLM_T
  
  LET lo_program_info.* = p_program_info.*
  LET ls_ROLE = p_role
  
  CASE ls_ROLE
    WHEN cs_user_role_all
      LET ls_where_sql = " ((DZLM008 = '",cs_check_out,"') OR (DZLM011 = '",cs_check_out,"'))"
    WHEN cs_user_role_sd
      LET ls_where_sql = " DZLM008 = '",cs_check_out,"'"
    WHEN cs_user_role_pr
      LET ls_where_sql = " DZLM011 = '",cs_check_out,"'"
  END CASE 

  LET ls_SQL = "SELECT DZLM001,DZLM002,DZLM003,DZLM004,DZLM005, ",
               "       DZLM006,DZLM007,DZLM008,DZLM009,DZLM010, ",
               "       DZLM011,DZLM012,DZLM013,DZLM014,DZLM015, ",
               "       DZLM016,DZLM017,DZLM018,DZLM019,DZLM020, ",
               "       DZLM021                                  ",
               "  FROM DZLM_T                                   ",
               " WHERE DZLM001 = '",lo_program_info.pi_TYPE,"'  ",  
               "   AND DZLM002 = '",lo_program_info.pi_NAME,"'  ",
               --"   AND DZLM004 = '",lo_program_info.pi_MODULE,"'",
               "   AND DZLM017 IS NULL                          ",
               "   AND ",
               ls_where_sql

  PREPARE lpre_get_dzlm FROM ls_sql
  DECLARE lcur_get_dzlm CURSOR FOR lpre_get_dzlm

  LET li_count = 1

  TRY 
    OPEN lcur_get_dzlm
    FETCH lcur_get_dzlm INTO lo_return.*
    CLOSE lcur_get_dzlm
    FREE lcur_get_dzlm
    FREE lpre_get_dzlm
  CATCH
    DISPLAY ls_SQL
  END TRY 
  
  RETURN lo_return.*  
  
END FUNCTION
 
FUNCTION sadzp200_alm_set_dzlm(p_DZLM_T,p_user_role)
DEFINE
  p_DZLM_T    T_DZLM_T,
  p_user_role STRING
DEFINE
  lo_DZLM_T      T_DZLM_T,
  ls_user_role   STRING,
  ls_insert_sql  STRING,
  ls_update_sql  STRING,
  ls_update_type STRING,
  ls_set_sql     STRING
DEFINE
  lb_return BOOLEAN  
  
  LET lo_DZLM_T.*  = p_DZLM_T.*
  LET ls_user_role = p_user_role

  CASE 
    WHEN ls_user_role = cs_user_role_sd
      LET ls_set_sql = " SET DZLM006 =  ",NVL(sadzp200_util_trim(lo_DZLM_T.DZLM006),"NULL")," ,",
                       "     DZLM007 = '",sadzp200_util_trim(lo_DZLM_T.DZLM007),"',",
                       "     DZLM008 = '",sadzp200_util_trim(lo_DZLM_T.DZLM008),"',",
                       "     DZLM018 = '",sadzp200_util_trim(lo_DZLM_T.DZLM018),"',",
                       "     DZLM020 = '",sadzp200_util_trim(lo_DZLM_T.DZLM020),"' "
                       
    WHEN ls_user_role = cs_user_role_pr
      LET ls_set_sql = " SET DZLM009 =  ",NVL(sadzp200_util_trim(lo_DZLM_T.DZLM009),"NULL")," ,",
                       "     DZLM010 = '",sadzp200_util_trim(lo_DZLM_T.DZLM010),"',",
                       "     DZLM011 = '",sadzp200_util_trim(lo_DZLM_T.DZLM011),"',",
                       "     DZLM019 = '",sadzp200_util_trim(lo_DZLM_T.DZLM019),"',",
                       "     DZLM021 = '",sadzp200_util_trim(lo_DZLM_T.DZLM021),"' "
  END CASE 
  
  LET ls_insert_sql = ""
  LET ls_update_sql = ""

  LET ls_insert_sql = "INSERT INTO DZLM_T(                                                          ",
                      "                    DZLM001,DZLM002,DZLM003,DZLM004,DZLM005,                 ",
                      "                    DZLM006,DZLM007,DZLM008,DZLM009,DZLM010,                 ",
                      "                    DZLM011,DZLM012,DZLM013,DZLM014,DZLM015,                 ",
                      "                    DZLM016,DZLM017,DZLM018,DZLM019,DZLM020,                 ",
                      "                    DZLM021                                                  ",
                      "                  )                                                          ", 
                      "            VALUES(                                                          ",
                      "                    '",lo_DZLM_T.DZLM001,"',                                 ",
                      "                    '",lo_DZLM_T.DZLM002,"',                                 ",
                      "                    '",lo_DZLM_T.DZLM003,"',                                 ",
                      "                    '",lo_DZLM_T.DZLM004,"',                                 ",
                      "                     ",NVL(lo_DZLM_T.DZLM005,"NULL")," ,                     ",
                      "                     ",NVL(sadzp200_util_trim(lo_DZLM_T.DZLM006),"NULL")," , ",
                      "                    '",sadzp200_util_trim(lo_DZLM_T.DZLM007),"',             ",
                      "                    '",sadzp200_util_trim(lo_DZLM_T.DZLM008),"',             ",
                      "                     ",NVL(sadzp200_util_trim(lo_DZLM_T.DZLM009),"NULL")," , ",
                      "                    '",sadzp200_util_trim(lo_DZLM_T.DZLM010),"',             ",
                      "                    '",sadzp200_util_trim(lo_DZLM_T.DZLM011),"',             ",
                      "                    '",lo_DZLM_T.DZLM012,"',                                 ",
                      "                    '",lo_DZLM_T.DZLM013,"',                                 ",
                      "                    '",lo_DZLM_T.DZLM014,"',                                 ",
                      "                    ",lo_DZLM_T.DZLM015,",                                   ",
                      "                    NULL,                                                    ",
                      "                    NULL,                                                    ",
                      "                    '",lo_DZLM_T.DZLM018,"',                                 ",
                      "                    '",lo_DZLM_T.DZLM019,"',                                 ",
                      "                    '",lo_DZLM_T.DZLM020,"',                                 ",
                      "                    '",lo_DZLM_T.DZLM021,"'                                  ",
                      "                  )                                                          "

  LET ls_update_sql = "UPDATE DZLM_T                            ",
                      ls_set_sql,
                      " WHERE 1=1                               ",
                      "   AND DZLM001 = '",lo_DZLM_T.DZLM001,"' ",
                      "   AND DZLM002 = '",lo_DZLM_T.DZLM002,"' ",
                      "   AND DZLM005 =  ",lo_DZLM_T.DZLM005,"  ",
                      "   AND DZLM012 = '",lo_DZLM_T.DZLM012,"' ",
                      "   AND DZLM013 = '",lo_DZLM_T.DZLM013,"' ",
                      "   AND DZLM014 = '",lo_DZLM_T.DZLM014,"' ",
                      "   AND DZLM015 =  ",lo_DZLM_T.DZLM015,"  "
  
  TRY
    LET ls_update_type = cs_modify_type_insert 
    PREPARE lpre_insert_dzlm FROM ls_insert_sql
    EXECUTE lpre_insert_dzlm
    LET lb_return = TRUE 
  CATCH
    LET lb_return = FALSE 
    DISPLAY cs_warning_tag,"Insert into dzlm_t unsuccess."
    TRY
      LET ls_update_type = cs_modify_type_update
      PREPARE lpre_update_dzlm FROM ls_update_sql
      EXECUTE lpre_update_dzlm
      LET lb_return = TRUE 
    CATCH
      LET lb_return = FALSE 
      DISPLAY cs_error_tag,"Update dzlm_t unsuccess."
      DISPLAY ls_insert_sql
      DISPLAY ls_update_sql
    END TRY
  END TRY

  RETURN lb_return,ls_update_type
  
END FUNCTION 

FUNCTION sadzp200_alm_preset_dzlm(p_DZLM_T,p_user_role)
DEFINE
  p_DZLM_T    T_DZLM_T,
  p_user_role STRING
DEFINE
  lo_DZLM_T    T_DZLM_T,
  ls_user_role STRING
DEFINE
  lo_RETURN  T_DZLM_T
  
  LET lo_DZLM_T.*  = p_DZLM_T.*
  LET ls_user_role = p_user_role

  CASE 
    WHEN ls_user_role = cs_user_role_sd
      LET lo_DZLM_T.DZLM006 = ""
      LET lo_DZLM_T.DZLM007 = ""
      LET lo_DZLM_T.DZLM008 = ""
      LET lo_DZLM_T.DZLM018 = ""
      LET lo_DZLM_T.DZLM020 = ""
    WHEN ls_user_role = cs_user_role_pr
      LET lo_DZLM_T.DZLM009 = ""
      LET lo_DZLM_T.DZLM010 = ""
      LET lo_DZLM_T.DZLM011 = ""
      LET lo_DZLM_T.DZLM019 = ""
      LET lo_DZLM_T.DZLM021 = ""
  END CASE

  LET lo_RETURN.* = lo_DZLM_T.*
  
  RETURN lo_RETURN.*
  
END FUNCTION 

FUNCTION sadzp200_alm_check_data_valid(p_DZLM_T,p_check_type)
DEFINE
  p_DZLM_T      T_DZLM_T,
  p_check_type  STRING
DEFINE
  lo_DZLM_T     T_DZLM_T,
  ls_check_type STRING,
  ls_sql        STRING,
  ls_dzlm008    STRING,
  ls_dzlm011    STRING,
  li_counts     INTEGER
DEFINE 
  lb_return BOOLEAN 
  
  LET lo_DZLM_T.*   = p_DZLM_T.*  
  LET ls_check_type = p_check_type

  CASE ls_check_type
    WHEN cs_check_out
      LET ls_dzlm008 = "(DZLM008 = '",cs_check_out,"')"
      LET ls_dzlm011 = "(DZLM011 = '",cs_check_out,"')"
    WHEN cs_check_in
      LET ls_dzlm008 = "(DZLM008 = '",cs_check_in,"')"
      LET ls_dzlm011 = "(DZLM011 = '",cs_check_in,"')"
  END CASE 
  
  
  #取得資料筆數
  LET ls_sql = "  SELECT COUNT(*)                                     ",
               "    FROM DZLM_T                                       ",
               "   WHERE DZLM001 = '",lo_DZLM_T.DZLM001,"'            ",
               "     AND DZLM002 = '",lo_DZLM_T.DZLM002,"'            ",
               "     AND DZLM005 =  ",lo_DZLM_T.DZLM005,"             ",
               "     AND DZLM012 = '",lo_DZLM_T.DZLM012,"'            ",
               "     AND DZLM013 = '",lo_DZLM_T.DZLM013,"'            ",
               "     AND DZLM014 = '",lo_DZLM_T.DZLM014,"'            ",
               "     AND DZLM015 = '",lo_DZLM_T.DZLM015,"'            ",
               "     AND (                                            ",
               "           ((DZLM006 IS NOT NULL) AND ",ls_dzlm008,") ",
               "           OR                                         ",
               "           ((DZLM009 IS NOT NULL) AND ",ls_dzlm011,") ",
               "         )                                            ",
               "     AND DZLM017 IS NULL                              "

  TRY              
    PREPARE lpre_check_data_valid FROM ls_sql
    DECLARE lcur_check_data_valid CURSOR FOR lpre_check_data_valid
    OPEN lcur_check_data_valid
    FETCH lcur_check_data_valid INTO li_counts
    CLOSE lcur_check_data_valid
    FREE lcur_check_data_valid
    FREE lpre_check_data_valid
  CATCH
    DISPLAY cs_error_tag,ls_sql 
  END TRY   

  LET lb_return = IIF(li_counts > 0,TRUE,FALSE)

  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzp200_alm_delete_dzlm_data(p_DZLM_T)
DEFINE
  p_DZLM_T  T_DZLM_T
DEFINE
  lo_DZLM_T  T_DZLM_T
DEFINE 
  lb_return BOOLEAN 
  
  LET lo_DZLM_T.* = p_DZLM_T.*  

  DELETE FROM DZLM_T
   WHERE DZLM001 = lo_DZLM_T.DZLM001
     AND DZLM002 = lo_DZLM_T.DZLM002
     AND DZLM005 = lo_DZLM_T.DZLM005
     AND DZLM012 = lo_DZLM_T.DZLM012
     AND DZLM013 = lo_DZLM_T.DZLM013
     AND DZLM014 = lo_DZLM_T.DZLM014
     AND DZLM015 = lo_DZLM_T.DZLM015
     AND DZLM017 IS NULL

  IF SQLCA.sqlcode = 0 THEN
    LET lb_return = TRUE
  ELSE
    LET lb_return = FALSE
  END IF 
  
  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzp200_alm_update_check_in_date(p_DZLM_T)
DEFINE
  p_DZLM_T  T_DZLM_T
DEFINE
  lo_DZLM_T  T_DZLM_T
DEFINE 
  lb_return BOOLEAN 
  
  LET lo_DZLM_T.* = p_DZLM_T.*  

  &ifndef DEBUG
  LET lo_DZLM_T.DZLM017 = cl_get_current() --CURRENT YEAR TO SECOND
  &else
  LET lo_DZLM_T.DZLM017 = CURRENT YEAR TO SECOND
  &endif  

  UPDATE DZLM_T
     SET DZLM017 = lo_DZLM_T.DZLM017
   WHERE DZLM001 = lo_DZLM_T.DZLM001
     AND DZLM002 = lo_DZLM_T.DZLM002
     AND DZLM005 = lo_DZLM_T.DZLM005
     AND DZLM012 = lo_DZLM_T.DZLM012
     AND DZLM013 = lo_DZLM_T.DZLM013
     AND DZLM014 = lo_DZLM_T.DZLM014
     AND DZLM015 = lo_DZLM_T.DZLM015
     AND DZLM017 IS NULL

  IF SQLCA.sqlcode = 0 THEN
    LET lb_return = TRUE
  ELSE
    LET lb_return = FALSE
  END IF 
  
  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzp200_alm_update_download_code(p_DZLM_T,p_ROLE)
DEFINE
  p_DZLM_T  T_DZLM_T,
  p_ROLE    STRING
DEFINE
  lo_DZLM_T  T_DZLM_T,
  ls_ROLE    STRING
DEFINE 
  lb_return BOOLEAN 
  
  LET lo_DZLM_T.* = p_DZLM_T.*
  LET ls_ROLE = p_ROLE  

  CASE 
    WHEN ls_ROLE = cs_user_role_sd
      UPDATE DZLM_T
         SET DZLM020 = "Y"
       WHERE DZLM001 = lo_DZLM_T.DZLM001
         AND DZLM002 = lo_DZLM_T.DZLM002
         AND DZLM005 = lo_DZLM_T.DZLM005
         AND DZLM012 = lo_DZLM_T.DZLM012
         AND DZLM013 = lo_DZLM_T.DZLM013
         AND DZLM014 = lo_DZLM_T.DZLM014
         AND DZLM015 = lo_DZLM_T.DZLM015
         AND DZLM017 IS NULL
    WHEN ls_ROLE = cs_user_role_pr
      UPDATE DZLM_T
         SET DZLM021 = "Y"
       WHERE DZLM001 = lo_DZLM_T.DZLM001
         AND DZLM002 = lo_DZLM_T.DZLM002
         AND DZLM005 = lo_DZLM_T.DZLM005
         AND DZLM012 = lo_DZLM_T.DZLM012
         AND DZLM013 = lo_DZLM_T.DZLM013
         AND DZLM014 = lo_DZLM_T.DZLM014
         AND DZLM015 = lo_DZLM_T.DZLM015
         AND DZLM017 IS NULL
  END CASE

  IF SQLCA.sqlcode = 0 THEN
    LET lb_return = TRUE
  ELSE
    LET lb_return = FALSE
  END IF 
  
  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzp200_alm_get_dzlm_role_list(p_dzlm_t)
DEFINE
  p_dzlm_t    T_DZLM_T
DEFINE
  lo_dzlm_t     T_DZLM_T,
  lo_role_arr   T_STATIC_ROLE_LIST,
  li_role_count INTEGER
DEFINE
  lo_return T_STATIC_ROLE_LIST

  LET lo_dzlm_t.* = p_dzlm_t.*

  LET li_role_count = 1

  IF (lo_dzlm_t.DZLM006 IS NOT NULL) THEN
    LET lo_role_arr[li_role_count] = cs_user_role_sd
    LET li_role_count = li_role_count + 1 
  END IF 
  
  IF (lo_dzlm_t.DZLM009 IS NOT NULL) THEN 
    LET lo_role_arr[li_role_count] = cs_user_role_pr 
    LET li_role_count = li_role_count + 1 
  END IF 

  LET lo_return = lo_role_arr

  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzp200_alm_flush_dzlm_array(p_DZLM_T)
DEFINE
  p_DZLM_T  T_DZLM_T
DEFINE
  lo_DZLM_T  T_DZLM_T,
  ls_SQL     STRING
DEFINE 
  lo_return T_DZLM_T 
  
  LET lo_DZLM_T.* = p_DZLM_T.*  

  LET ls_SQL = "  SELECT DZLM001,DZLM002,DZLM003,DZLM004,DZLM005, ",
               "         DZLM006,DZLM007,DZLM008,DZLM009,DZLM010, ",
               "         DZLM011,DZLM012,DZLM013,DZLM014,DZLM015, ",
               "         DZLM016,DZLM017,DZLM018,DZLM019,DZLM020, ",
               "         DZLM021                                  ",
               "    FROM DZLM_T                                   ",
               "   WHERE DZLM001 = '",lo_DZLM_T.DZLM001,"'        ",
               "     AND DZLM002 = '",lo_DZLM_T.DZLM002,"'        ",
               "     AND DZLM005 =  ",lo_DZLM_T.DZLM005,"         ",
               "     AND DZLM012 = '",lo_DZLM_T.DZLM012,"'        ",
               "     AND DZLM013 = '",lo_DZLM_T.DZLM013,"'        ",
               "     AND DZLM014 = '",lo_DZLM_T.DZLM014,"'        ",
               "     AND DZLM015 =  ",lo_DZLM_T.DZLM015,"         "

  PREPARE lpre_flush_dzlm_array FROM ls_sql
  DECLARE lcur_flush_dzlm_array CURSOR FOR lpre_flush_dzlm_array

  TRY 
    OPEN lcur_flush_dzlm_array
    FETCH lcur_flush_dzlm_array INTO lo_return.*
    CLOSE lcur_flush_dzlm_array
    FREE lcur_flush_dzlm_array
    FREE lpre_flush_dzlm_array
  CATCH
    DISPLAY ls_SQL
  END TRY 
  
  RETURN lo_return.*  
  
END FUNCTION

FUNCTION sadzp200_alm_update_check_in_code(p_DZLM_T,p_ROLE)
DEFINE
  p_DZLM_T  T_DZLM_T,
  p_ROLE    STRING
DEFINE
  lo_DZLM_T  T_DZLM_T,
  ls_ROLE    STRING,
  lb_result  BOOLEAN #160729-00008 add
DEFINE 
  lb_return BOOLEAN 
  
  LET lo_DZLM_T.* = p_DZLM_T.*
  LET ls_ROLE = p_ROLE  

  #160729-00008 begin
  #161129-00001 begin
  IF (NVL(lo_DZLM_T.DZLM007,cs_null_default) <> cs_topstd_user_name) AND (NVL(lo_DZLM_T.DZLM010,cs_null_default) <> cs_topstd_user_name) THEN
    CALL sadzp200_alm_check_and_rearrange_dzlm(lo_DZLM_T.*,ls_ROLE) RETURNING lb_result
  END IF  
  #161129-00001 end
  #160729-00008 end
  
  CASE 
    WHEN ls_ROLE = cs_user_role_sd
      UPDATE DZLM_T
         SET DZLM008 = cs_check_in
       WHERE DZLM001 = lo_DZLM_T.DZLM001
         AND DZLM002 = lo_DZLM_T.DZLM002
         AND DZLM005 = lo_DZLM_T.DZLM005
         AND DZLM012 = lo_DZLM_T.DZLM012
         AND DZLM013 = lo_DZLM_T.DZLM013
         AND DZLM014 = lo_DZLM_T.DZLM014
         AND DZLM015 = lo_DZLM_T.DZLM015
         AND DZLM017 IS NULL
         AND DZLM008 IS NOT NULL 
    WHEN ls_ROLE = cs_user_role_pr
      UPDATE DZLM_T
         SET DZLM011 = cs_check_in
       WHERE DZLM001 = lo_DZLM_T.DZLM001
         AND DZLM002 = lo_DZLM_T.DZLM002
         AND DZLM005 = lo_DZLM_T.DZLM005
         AND DZLM012 = lo_DZLM_T.DZLM012
         AND DZLM013 = lo_DZLM_T.DZLM013
         AND DZLM014 = lo_DZLM_T.DZLM014
         AND DZLM015 = lo_DZLM_T.DZLM015
         AND DZLM017 IS NULL
         AND DZLM011 IS NOT NULL 
  END CASE

  IF SQLCA.sqlcode = 0 THEN
    LET lb_return = TRUE
  ELSE
    LET lb_return = FALSE
  END IF 
  
  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzp200_alm_check_alm_table_exist(p_owner)
DEFINE
  p_owner      STRING
DEFINE
  ls_owner      STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  lb_return     BOOLEAN

  LET ls_owner = p_owner.toUpperCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                                  ",
               "  FROM ALL_OBJECTS AOS                           ",
               " WHERE AOS.OBJECT_NAME = '",cs_alm_main_table,"' "

  PREPARE lpre_check_alm_table_exist FROM ls_sql
  DECLARE lcur_check_alm_table_exist CURSOR FOR lpre_check_alm_table_exist
  OPEN lcur_check_alm_table_exist
  FETCH lcur_check_alm_table_exist INTO li_rec_count
  CLOSE lcur_check_alm_table_exist
  FREE lcur_check_alm_table_exist
  FREE lpre_check_alm_table_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

-- 160504-00002 begin
{
#160919-00031 Cancel begin
[釋出規則]
程式&規格: dzla002 <>’T’
2.1	曾過正 & 階段<=QC, 不能釋出
檢核條件: WHERE dzla005 is not null  AND dzla001<=’P63T’
2.2曾過正(dzlm022='P') &  階段>QC, 可以直接釋出
檢核條件: WHERE dzla005 is not null AND dzla006=’P’ AND (dzla001>’P63T’AND dzla001<’P99’)
2.3未曾過正, 必須要還原(remark掉本次修改) 才能釋出
檢核條件: WHERE dzla005 is null

Table: dzla002=’T’
2.2	曾過正 & 階段<=QC, 不能釋出
檢核條件: WHERE dzla005 is not null  AND dzla001<=’P63T’
2.2曾過正(dzlm022='P') &  階段>QC, 可以直接釋出
檢核條件: WHERE dzla005 is not null AND dzla006=’P’ AND (dzla001>’P63T’AND dzla001<’P99’)
#160919-00031 Cancel end
}
{
#160919-00031 Fix begin
[釋出規則]
程式&規格: dzla002 <>’T’
2.1	曾過正 & 階段<= P65T:完測, 不能釋出
檢核條件: WHERE dzla005 is not null  AND dzla001<=’P65T’
2.2未曾過正, 必須要還原(remark掉本次修改) 才能釋出
檢核條件: WHERE dzla005 is null

Table: dzla002=’T’
2.2	曾過正 & 階段<= P65T:完測, 不能釋出
檢核條件: WHERE dzla005 is not null  AND dzla001<=’P65T’
#160919-00031 Fix end
}
FUNCTION sadzp200_alm_check_if_could_release(p_DZLM_T,p_role)
DEFINE
  p_DZLM_T  T_DZLM_T,
  p_role    STRING
DEFINE
  lo_DZLM_T    T_DZLM_T,
  ls_role      STRING,
  ls_stage     VARCHAR(5),
  ldt_p_date   DATETIME YEAR TO SECOND,
  ls_code      VARCHAR(2),
  ls_type      VARCHAR(5),
  ls_result    STRING,
  lo_check_out_owner T_CHECK_OUT_OWNER_LIST,
  lo_cko_info  T_CHECK_OUT_INFO,
  lo_mark_info T_MARK_INFORMATION
DEFINE 
  ls_return   STRING,
  ls_rtn_code STRING,
  lo_rtn_info T_MARK_INFORMATION,
  lo_rtn_cko  T_CHECK_OUT_OWNER_LIST
  
  LET lo_DZLM_T.* = p_DZLM_T.*
  LET ls_role     = p_role

  INITIALIZE lo_check_out_owner TO NULL
  INITIALIZE lo_mark_info TO NULL

  LET ls_type     = lo_DZLM_T.DZLM001
  LET ls_result   = cs_release_yes
  LET ls_rtn_code = "adz-00850"
  LET ls_return   = ls_result

  CALL sadzp200_alm_get_alm_passing_stage_and_code(lo_DZLM_T.*) RETURNING ls_stage,ldt_p_date,ls_code

  CASE 
    WHEN ls_type = "T"  OR
         ls_type = "MT" OR
         ls_type = "MG" OR
         ls_type = "MV" 
         
      -- 曾過正&階段<=P65T,不能釋出   
      --IF ldt_p_date IS NOT NULL AND ls_stage <= "P63T" THEN -- 160919-00031 mark
      IF ldt_p_date IS NOT NULL AND ls_stage <= "P65T" THEN -- 160919-00031 Modify
        LET ls_result = cs_release_no
        LET ls_rtn_code = "adz-00849"
      END IF     

      {
      -- 160919-00031 Mark begin
      -- 曾過正(dzlm022='P')&階段>QC,可以直接釋出
      IF ldt_p_date IS NOT NULL AND ls_code = "P" AND ls_stage > "P63T" AND ls_stage < "P99" THEN
        LET ls_result = cs_release_yes
        LET ls_rtn_code = "adz-00850"
      END IF
      -- 160919-00031 Mark end
      }
      
    WHEN ls_type <> "T"  AND
         ls_type <> "MT" AND
         ls_type <> "MG" AND
         ls_type <> "MV" 

      -- 曾過正&階段<=P65T,不能釋出   
      --IF ldt_p_date IS NOT NULL AND ls_stage <= "P63T" THEN -- 160919-00031 mark
      IF ldt_p_date IS NOT NULL AND ls_stage <= "P65T" THEN -- 160919-00031 modify
        LET ls_result = cs_release_no
        LET ls_rtn_code = "adz-00849"
      END IF     

      {
      -- 160919-00031 Mark begin
      -- 曾過正(dzlm022='P')&階段>QC,可以直接釋出
      IF ldt_p_date IS NOT NULL AND ls_code = "P" AND ls_stage > "P63T" AND ls_stage < "P99" THEN
        LET ls_result = cs_release_yes
        LET ls_rtn_code = "adz-00850"
      END IF 
      -- 160919-00031 Mark end
      }
      
      -- 未曾過正,必須要還原(remark掉本次修改)才能釋出(程式)
      #IF ls_role = cs_ver_type_pr THEN 
        IF (ldt_p_date IS NULL) THEN
          CALL sadzp200_alm_check_if_program_marked(lo_DZLM_T.*) RETURNING lo_mark_info.*
          IF lo_mark_info.mi_result THEN 
            LET ls_result = cs_release_yes
            LET ls_rtn_code = "adz-00850"
          ELSE
            LET ls_result = cs_release_mark
            LET ls_rtn_code = "adz-00851"
          END IF
        END IF
      #END IF  
      
    OTHERWISE
      LET ls_result = cs_release_no
      LET ls_rtn_code = "adz-00853"
  END CASE 

  IF (ls_result = cs_release_yes) THEN 
    CASE
      WHEN ls_role = cs_ver_type_sd
        CALL sadzp200_alm_get_check_out_info(lo_DZLM_T.*,ls_role) RETURNING lo_cko_info.*
        IF lo_cko_info.coi_IO = cs_check_out THEN
          LET ls_rtn_code = "adz-00867"
          LET lo_check_out_owner.cool_ROLE        = "CODE"
          LET lo_check_out_owner.cool_ID          = lo_DZLM_T.DZLM010
          LET lo_check_out_owner.cool_NAME        = lo_DZLM_T.DZLM010
          LET lo_check_out_owner.cool_REQUEST_NO  = lo_DZLM_T.DZLM012
          LET lo_check_out_owner.cool_SEQUENCE_NO = lo_DZLM_T.DZLM015 
        END IF 
      WHEN ls_role = cs_ver_type_pr
        CALL sadzp200_alm_get_check_out_info(lo_DZLM_T.*,ls_role) RETURNING lo_cko_info.*
        IF lo_cko_info.coi_IO = cs_check_out THEN 
          LET ls_rtn_code = "adz-00867" 
          LET lo_check_out_owner.cool_ROLE        = "SPEC"
          LET lo_check_out_owner.cool_ID          = lo_DZLM_T.DZLM007
          LET lo_check_out_owner.cool_NAME        = lo_DZLM_T.DZLM007
          LET lo_check_out_owner.cool_REQUEST_NO  = lo_DZLM_T.DZLM012
          LET lo_check_out_owner.cool_SEQUENCE_NO = lo_DZLM_T.DZLM015 
        END IF 
    END CASE 
  END IF 

  LET ls_return     = ls_result
  LET lo_rtn_info.* = lo_mark_info.*
  LET lo_rtn_cko.*  = lo_check_out_owner.*
  
  RETURN ls_return,ls_rtn_code,lo_rtn_info.*,lo_rtn_cko.*
  
END FUNCTION

FUNCTION sadzp200_alm_get_alm_passing_stage_and_code(p_DZLM_T)
DEFINE
  p_DZLM_T  T_DZLM_T
DEFINE
  lo_DZLM_T   T_DZLM_T,
  ls_sql      STRING,
  ls_stage    VARCHAR(5),
  ldt_p_date  DATETIME YEAR TO SECOND,
  ls_code     VARCHAR(2)
DEFINE
  ls_rtn_stage STRING,
  ls_rtn_dt    DATETIME YEAR TO SECOND,
  ls_rtn_code  STRING

  LET lo_DZLM_T.* = p_DZLM_T.*  
  
  LET ls_sql = "SELECT LA.DZLA001,LA.DZLA005,LA.DZLA006     ",
               "  FROM DZLA_T LA                            ",
               " WHERE LA.DZLA002 = '",lo_DZLM_T.DZLM001,"' ",
               "   AND LA.DZLA003 = '",lo_DZLM_T.DZLM002,"' ",
               "   AND LA.DZLA007 = '",lo_DZLM_T.DZLM012,"' ",
               "   AND LA.DZLA010 = '",lo_DZLM_T.DZLM015,"' "

  PREPARE lpre_get_alm_passing_stage_and_code FROM ls_sql
  DECLARE lcur_get_alm_passing_stage_and_code CURSOR FOR lpre_get_alm_passing_stage_and_code
  OPEN lcur_get_alm_passing_stage_and_code
  FETCH lcur_get_alm_passing_stage_and_code INTO ls_stage,ldt_p_date,ls_code
  CLOSE lcur_get_alm_passing_stage_and_code
  FREE lcur_get_alm_passing_stage_and_code
  FREE lpre_get_alm_passing_stage_and_code

  LET ls_rtn_stage = ls_stage
  LET ls_rtn_dt    = ldt_p_date
  LET ls_rtn_code  = ls_code
    
  RETURN ls_rtn_stage,ls_rtn_dt,ls_rtn_code
  
END FUNCTION

FUNCTION sadzp200_alm_get_check_out_info(p_DZLM_T,p_role)
DEFINE
  p_DZLM_T  T_DZLM_T,
  p_role    STRING
DEFINE
  lo_DZLM_T   T_DZLM_T,
  ls_role     STRING,
  ls_sql      STRING,
  ls_sql_role STRING,
  lo_cko_info T_CHECK_OUT_INFO
DEFINE
  lo_return T_CHECK_OUT_INFO

  LET lo_DZLM_T.* = p_DZLM_T.*
  LET ls_role = p_role  

  CASE
    WHEN ls_role = cs_ver_type_pr
      LET ls_sql_role = "LM.DZLM006,LM.DZLM007,LM.DZLM008"
    WHEN ls_role = cs_ver_type_sd
      LET ls_sql_role = "LM.DZLM009,LM.DZLM010,LM.DZLM011"
  END CASE 
  
  LET ls_sql = "SELECT ",ls_sql_role,"                      ", 
               "  FROM DZLM_T LM                            ", 
               " WHERE LM.DZLM001 = '",lo_DZLM_T.DZLM001,"' ", 
               "   AND LM.DZLM002 = '",lo_DZLM_T.DZLM002,"' ", 
               "   AND LM.DZLM005 = '",lo_DZLM_T.DZLM005,"' " 
   
  PREPARE lpre_get_check_out_info FROM ls_sql
  DECLARE lcur_get_check_out_info CURSOR FOR lpre_get_check_out_info
  OPEN lcur_get_check_out_info
  FETCH lcur_get_check_out_info INTO lo_cko_info.*
  CLOSE lcur_get_check_out_info
  FREE lcur_get_check_out_info
  FREE lpre_get_check_out_info

  LET lo_return.* = lo_cko_info.*
    
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzp200_alm_check_if_program_marked(p_DZLM_T)
DEFINE
  p_DZLM_T  T_DZLM_T
DEFINE
  lo_DZLM_T       T_DZLM_T,
  lo_mark_info    T_MARK_INFORMATION,
  ls_dzlm015      STRING,
  ls_request_bill STRING,
  ls_4gl_filename STRING,
  ls_separator    STRING 
DEFINE
  lo_return  T_MARK_INFORMATION

  LET lo_DZLM_T.* = p_DZLM_T.*
  
  LET ls_dzlm015 = lo_DZLM_T.DZLM015
  LET ls_dzlm015 = ls_dzlm015.trim()
  LET ls_request_bill = lo_DZLM_T.DZLM012,cs_request_divider,ls_dzlm015

  LET ls_separator = os.Path.separator()
  LET ls_4gl_filename =  FGL_GETENV(lo_DZLM_T.DZLM004),ls_separator,"4gl",ls_separator,lo_DZLM_T.DZLM002,cs_4gl_extend

  CALL sadzp200_alm_get_data_from_file(ls_4gl_filename,ls_request_bill) RETURNING lo_mark_info.*
  LET lo_return.* = lo_mark_info.*

  RETURN lo_return.*

END FUNCTION 

FUNCTION sadzp200_alm_get_data_from_file(p_FileName,p_request_bill)
DEFINE
  p_FileName     STRING,
  p_request_bill STRING
DEFINE
  ls_FileName      STRING,
  ls_request_bill  STRING,
  ls_mark_line     STRING,
  ls_mark_begin    STRING,
  ls_mark_end      STRING,
  ls_text          STRING,
  ls_text_line     STRING,
  lb_mark_begin    BOOLEAN,
  lb_mark_end      BOOLEAN,
  lb_mark_line     BOOLEAN,
  lb_success       BOOLEAN,
  lb_result        BOOLEAN,
  ls_res_code      STRING,
  lb_found_rsvd    BOOLEAN, 
  li_line_count    INTEGER
DEFINE
  lo_channel_read     base.Channel,
  lo_line_string_buf  base.StringBuffer
DEFINE
  lo_return  T_MARK_INFORMATION
  
  LET ls_FileName     = p_FileName
  LET ls_request_bill = p_request_bill

  #設定 Mark 的符號
  LET ls_mark_begin = ls_request_bill,cs_4gl_mark_begin 
  LET ls_mark_end   = ls_request_bill,cs_4gl_mark_end 
  LET ls_mark_line  = ls_request_bill
  
  LET lb_mark_begin = FALSE
  LET lb_mark_end   = FALSE
  LET lb_mark_line  = FALSE
  

  LET lb_success   = TRUE
  LET lb_result    = TRUE
  LET ls_res_code  = ""
  LET ls_text_line = ""

  LET lo_channel_read = base.Channel.create()
  
  TRY 
    CALL lo_channel_read.openFile(ls_FileName,"r")
  CATCH
    DISPLAY cs_error_tag,"Open file ",ls_FileName," fault !!"
    LET lb_success = FALSE
    LET lb_result = FALSE
    #開啟 4gl 檔案失敗, 無法進行辨識 !
    LET ls_res_code = "adz-00862"
    LET ls_text_line = ls_FileName
  END TRY  

  IF lb_success THEN
  
    LET li_line_count = 1
    LET lo_line_string_buf = base.StringBuffer.create()
    CALL lo_line_string_buf.clear()
    
    WHILE TRUE
      IF lo_channel_read.isEof() THEN 
        EXIT WHILE
      END IF

      LET ls_text = lo_channel_read.readLine()

      CALL lo_line_string_buf.clear()
      CALL lo_line_string_buf.append(ls_text)
      CALL lo_line_string_buf.replace(" ","",0)

      LET ls_text_line = lo_line_string_buf.toString()
      LET ls_text_line = ls_text_line.trim()

      LET lb_mark_line = FALSE
      LET lb_found_rsvd = FALSE
      CASE
        WHEN ls_text_line.getIndexOf(ls_mark_begin,1) > 0
          IF lb_mark_begin THEN
            LET lb_result = FALSE
            #發現重複的註記起始碼, 辨識失敗 !
            LET ls_res_code = "adz-00860"
            EXIT WHILE
          END IF 
          IF ls_text_line.subString(1,1) = cs_4gl_mark_sign THEN
            LET lb_mark_begin = TRUE
            LET lb_mark_end   = FALSE
          ELSE 
            LET lb_found_rsvd = TRUE
          END IF   
        WHEN ls_text_line.getIndexOf(ls_mark_end,1) > 0
          IF NOT lb_mark_begin THEN
            LET lb_result = FALSE
            #找不到註記起始碼, 辨識失敗 !
            LET ls_res_code = "adz-00863"
            EXIT WHILE
          END IF 
          IF lb_mark_end THEN
            LET lb_result = FALSE
            #發現重複的註記結尾碼, 辨識失敗 !
            LET ls_res_code = "adz-00861"
            EXIT WHILE
          END IF 
          IF ls_text_line.subString(1,1) = cs_4gl_mark_sign THEN
            LET lb_mark_begin = FALSE
            LET lb_mark_end   = TRUE
          ELSE 
            LET lb_found_rsvd = TRUE
          END IF  
        WHEN ls_text_line.getIndexOf(ls_mark_line,1) > 0
          IF ls_text_line.subString(1,1) = cs_4gl_mark_sign THEN
            LET lb_mark_line = TRUE
          ELSE   
            LET lb_found_rsvd = TRUE
          END IF  
      END CASE 

      IF lb_mark_begin OR lb_mark_line OR lb_found_rsvd THEN
        IF ls_text_line.subString(1,1) <> cs_4gl_mark_sign THEN 
          LET lb_result = FALSE
          #註記的第一碼非為"#"符號, 辨識失敗 !
          LET ls_res_code = "adz-00859"
          EXIT WHILE
        END IF
      END IF 

      LET li_line_count = li_line_count + 1
      
    END WHILE

    #只有開始沒有結束
    IF lb_mark_begin AND ls_res_code IS NULL THEN
      LET lb_result = FALSE
      #找不到註記結尾碼, 辨識失敗 !
      LET ls_res_code = "adz-00864"
    END IF
    
  END IF
  
  CALL lo_channel_read.close()
  
  IF lb_result THEN
    LET ls_res_code   = ""
    LET li_line_count = 0
    LET ls_text_line  = ""
  END IF 
   
  LET lo_return.mi_result    = lb_result
  LET lo_return.mi_code      = ls_res_code
  LET lo_return.mi_line_no   = li_line_count
  LET lo_return.mi_line_code = ls_text

  RETURN lo_return.*
  
END FUNCTION

-- 160504-00002 end

-- 160729-00008 begin
FUNCTION sadzp200_alm_check_and_rearrange_dzlm(p_DZLM_T,p_user_role)
DEFINE
  p_DZLM_T    T_DZLM_T,
  p_user_role STRING
DEFINE
  lo_DZLM_T    T_DZLM_T,
  ls_user_role STRING,
  lo_DZLM_ARR  DYNAMIC ARRAY OF T_DZLM_T,
  lb_del_same  BOOLEAN,
  lb_result    BOOLEAN
DEFINE
  lb_return BOOLEAN

  LET lo_DZLM_T.*  = p_DZLM_T.*
  LET ls_user_role = p_user_role

  LET lb_del_same = FALSE
  
  #取得比現行版次小的ALM資料
  CALL sadzp200_alm_get_construct_ver_smaller_then_current(lo_DZLM_T.*) RETURNING lo_DZLM_ARR
  #再將這些資料設為簽入
  CALL sadzp200_alm_set_record_check_in(lo_DZLM_ARR) RETURNING lb_result
  
  #先檢查相同要簽出版次的程式是否還有效, 若有效, 就不設為失效(負值)
  CALL sadzp200_alm_check_if_same_construct_ver_exists(lo_DZLM_T.*) RETURNING lb_result
  LET lb_del_same = NOT lb_result
  
  #取得比現行版次大(或包含當下版次無效)的ALM資料
  CALL sadzp200_alm_get_construct_ver_bigger_then_current(lo_DZLM_T.*,lb_del_same) RETURNING lo_DZLM_ARR
  #再更新dzlm005為負值
  CALL sadzp200_alm_set_invalid_sign(lo_DZLM_ARR) RETURNING lb_result

  LET lb_return = lb_result

  RETURN lb_return
    
END FUNCTION

FUNCTION sadzp200_alm_check_if_same_construct_ver_exists(p_DZLM_T)
DEFINE
  p_DZLM_T  T_DZLM_T
DEFINE
  lo_DZLM_T  T_DZLM_T,
  ls_sql     STRING,
  li_counts  INTEGER,
  lb_result  BOOLEAN
DEFINE
  lb_return BOOLEAN

  LET lo_DZLM_T.* = p_DZLM_T.*

  LET ls_sql = " SELECT COUNT(*)                          ",
               "   FROM DZLM_T                            ",
               "  WHERE DZLM001 = '",lo_DZLM_T.DZLM001,"' ",
               "    AND DZLM002 = '",lo_DZLM_T.DZLM002,"' ",
               "    AND DZLM005 =  ",lo_DZLM_T.DZLM005,"  ",
               "    AND DZLM012 = '",lo_DZLM_T.DZLM012,"' ",
               "    AND DZLM013 = '",lo_DZLM_T.DZLM013,"' ",
               "    AND DZLM014 = '",lo_DZLM_T.DZLM014,"' ",
               "    AND DZLM015 =  ",lo_DZLM_T.DZLM015,"  ",
               "    AND DZLM017 IS NULL                   "

  PREPARE lpre_check_if_same_construct_ver_exists FROM ls_sql
  DECLARE lcur_check_if_same_construct_ver_exists CURSOR FOR lpre_check_if_same_construct_ver_exists
  OPEN lcur_check_if_same_construct_ver_exists
  FETCH lcur_check_if_same_construct_ver_exists INTO li_counts
  CLOSE lcur_check_if_same_construct_ver_exists
  FREE lcur_check_if_same_construct_ver_exists
  FREE lpre_check_if_same_construct_ver_exists

  LET lb_return = IIF(NVL(li_counts,0) > 0,TRUE,FALSE)  

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp200_alm_get_construct_ver_bigger_then_current(p_DZLM_T,p_get_curr)
DEFINE
  p_DZLM_T   T_DZLM_T,
  p_get_curr BOOLEAN
DEFINE
  lo_DZLM_T    T_DZLM_T,
  lb_get_curr  BOOLEAN,
  lo_DZLM_ARR  DYNAMIC ARRAY OF T_DZLM_T,
  ls_sql       STRING,
  ls_sql_cond  STRING,
  li_counts    INTEGER,
  lb_result    BOOLEAN
DEFINE
  lo_return  DYNAMIC ARRAY OF T_DZLM_T

  LET lo_DZLM_T.* = p_DZLM_T.*
  LET lb_get_curr = p_get_curr

  LET li_counts = 1
  
  IF lb_get_curr THEN
    LET ls_sql_cond = " AND DZLM005 >= ",lo_DZLM_T.DZLM005," "
  ELSE
    LET ls_sql_cond = " AND DZLM005 > ",lo_DZLM_T.DZLM005," "
  END IF

  LET ls_sql = " SELECT DZLM001,DZLM002,DZLM003,DZLM004,DZLM005, ",
               "        DZLM006,DZLM007,DZLM008,DZLM009,DZLM010, ",
               "        DZLM011,DZLM012,DZLM013,DZLM014,DZLM015, ",
               "        DZLM016,DZLM017,DZLM018,DZLM019,DZLM020, ",
               "        DZLM021                                  ",
               "   FROM DZLM_T                                   ",
               "  WHERE DZLM001 = '",lo_DZLM_T.DZLM001,"'        ",
               "    AND DZLM002 = '",lo_DZLM_T.DZLM002,"'        ",
               "    AND DZLM013 = '",lo_DZLM_T.DZLM013,"'        ",
               "    AND DZLM014 = '",lo_DZLM_T.DZLM014,"'        ",
               ls_sql_cond

  PREPARE lpre_get_construct_ver_bigger_then_current FROM ls_sql
  DECLARE lcur_get_construct_ver_bigger_then_current CURSOR FOR lpre_get_construct_ver_bigger_then_current

  OPEN lcur_get_construct_ver_bigger_then_current
  FOREACH lcur_get_construct_ver_bigger_then_current INTO lo_DZLM_ARR[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_construct_ver_bigger_then_current

  CALL lo_DZLM_ARR.deleteElement(li_counts)
  
  FREE lpre_get_construct_ver_bigger_then_current
  FREE lcur_get_construct_ver_bigger_then_current

  LET lo_return = lo_DZLM_ARR
  
  RETURN lo_return

END FUNCTION

FUNCTION sadzp200_alm_set_invalid_sign(p_DZLM_T)
DEFINE
  p_DZLM_T  DYNAMIC ARRAY OF T_DZLM_T
DEFINE
  lo_DZLM_T  DYNAMIC ARRAY OF T_DZLM_T,
  lb_result  BOOLEAN,
  ls_message STRING,
  li_loop    INTEGER
DEFINE
  lb_return  BOOLEAN  

  LET lo_DZLM_T = p_DZLM_T
  LET lb_return = TRUE

  FOR li_loop = 1 TO lo_DZLM_T.getLength()
    LET ls_message = "Now update "||lo_DZLM_T[li_loop].DZLM002||" construct version '"||lo_DZLM_T[li_loop].DZLM005||"' to invalid."
    DISPLAY cs_information_tag,ls_message
    CALL sadzp200_alm_set_dzlm_to_invalid(lo_DZLM_T[li_loop].*) RETURNING lb_result 
    IF NOT lb_result THEN LET lb_return = lb_result END IF 
  END FOR

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp200_alm_set_dzlm_to_invalid(p_DZLM_T)
DEFINE
  p_DZLM_T  T_DZLM_T
DEFINE
  lo_DZLM_T      T_DZLM_T,
  li_dzlm005     INTEGER,
  ls_update_sql  STRING,
  ldt_current    DATETIME YEAR TO SECOND,
  ls_message     STRING
DEFINE
  lb_return BOOLEAN  
  
  LET lo_DZLM_T.*  = p_DZLM_T.*

  &ifndef DEBUG
  LET ldt_current = cl_get_current() --CURRENT YEAR TO SECOND
  &else
  LET ldt_current = CURRENT YEAR TO SECOND
  &endif  

  LET ls_message = "Force set invalid : ",ldt_current
  
  LET ls_update_sql = ""
  LET li_dzlm005 = lo_DZLM_T.DZLM005
  LET li_dzlm005 = li_dzlm005 * -1

  LET ls_update_sql = "UPDATE DZLM_T                                             ",
                      "   SET DZLM005 = ",li_dzlm005,",                          ", 
                      "       DZLM008 = CASE                                     ",
                      "                   WHEN DZLM008 IS NULL THEN NULL         ",
                      "                 ELSE                                     ",
                      "                   'I'                                    ",         
                      "                 END,                                     ",
                      "       DZLM011 = CASE                                     ",
                      "                   WHEN DZLM011 IS NULL THEN NULL         ",
                      "                 ELSE                                     ",
                      "                   'I'                                    ",         
                      "                 END,                                     ",
                      "       DZLM017 = CASE                                     ",
                      "                   WHEN DZLM017 IS NOT NULL THEN DZLM017  ",
                      "                 ELSE                                     ",
                      "                   SYSDATE                                ",         
                      "                 END,                                     ",
                      "       DZLM018 = '",ls_message,"'                         ",
                      " WHERE 1=1                                                ",
                      "   AND DZLM001 = '",lo_DZLM_T.DZLM001,"'                  ",
                      "   AND DZLM002 = '",lo_DZLM_T.DZLM002,"'                  ",
                      "   AND DZLM005 =  ",lo_DZLM_T.DZLM005,"                   ",
                      "   AND DZLM012 = '",lo_DZLM_T.DZLM012,"'                  ",
                      "   AND DZLM013 = '",lo_DZLM_T.DZLM013,"'                  ",
                      "   AND DZLM014 = '",lo_DZLM_T.DZLM014,"'                  ",
                      "   AND DZLM015 =  ",lo_DZLM_T.DZLM015,"                   "
  
  TRY
    PREPARE lpre_update_set_dzlm_to_invalid FROM ls_update_sql
    EXECUTE lpre_update_set_dzlm_to_invalid
    LET lb_return = TRUE 
  CATCH
    LET lb_return = FALSE 
    DISPLAY cs_error_tag,"Update dzlm005 to invalid failed."
    DISPLAY ls_update_sql
  END TRY

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzp200_alm_get_construct_ver_smaller_then_current(p_DZLM_T)
DEFINE
  p_DZLM_T  T_DZLM_T
DEFINE
  lo_DZLM_T    T_DZLM_T,
  lo_DZLM_ARR  DYNAMIC ARRAY OF T_DZLM_T,
  ls_sql       STRING,
  li_counts    INTEGER,
  lb_result    BOOLEAN
DEFINE
  lo_return  DYNAMIC ARRAY OF T_DZLM_T

  LET lo_DZLM_T.* = p_DZLM_T.*

  LET li_counts = 1
  
  LET ls_sql = " SELECT DZLM001,DZLM002,DZLM003,DZLM004,DZLM005, ",
               "        DZLM006,DZLM007,DZLM008,DZLM009,DZLM010, ",
               "        DZLM011,DZLM012,DZLM013,DZLM014,DZLM015, ",
               "        DZLM016,DZLM017,DZLM018,DZLM019,DZLM020, ",
               "        DZLM021                                  ",
               "   FROM DZLM_T                                   ",
               "  WHERE DZLM001 = '",lo_DZLM_T.DZLM001,"'        ",
               "    AND DZLM002 = '",lo_DZLM_T.DZLM002,"'        ",
               "    AND DZLM013 = '",lo_DZLM_T.DZLM013,"'        ",
               "    AND DZLM014 = '",lo_DZLM_T.DZLM014,"'        ",
               "    AND DZLM005 <  ",lo_DZLM_T.DZLM005,"         ",
               "    AND (                                        ",
               "          DZLM017 IS NULL                        ",
               "          OR                                     ",
               "          NVL(DZLM008,'X') = 'O'                 ",
               "          OR                                     ",
               "          NVL(DZLM011,'X') = 'O'                 ",
               "        )                                        "

  PREPARE lpre_get_construct_ver_smaller_then_current FROM ls_sql
  DECLARE lcur_get_construct_ver_smaller_then_current CURSOR FOR lpre_get_construct_ver_smaller_then_current

  OPEN lcur_get_construct_ver_smaller_then_current
  FOREACH lcur_get_construct_ver_smaller_then_current INTO lo_DZLM_ARR[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_construct_ver_smaller_then_current

  CALL lo_DZLM_ARR.deleteElement(li_counts)
  
  FREE lpre_get_construct_ver_smaller_then_current
  FREE lcur_get_construct_ver_smaller_then_current

  LET lo_return = lo_DZLM_ARR
  
  RETURN lo_return

END FUNCTION

FUNCTION sadzp200_alm_set_record_check_in(p_DZLM_T)
DEFINE
  p_DZLM_T  DYNAMIC ARRAY OF T_DZLM_T
DEFINE
  lo_DZLM_T  DYNAMIC ARRAY OF T_DZLM_T,
  lb_result  BOOLEAN,
  ls_message STRING,
  li_loop    INTEGER
DEFINE
  lb_return  BOOLEAN  

  LET lo_DZLM_T = p_DZLM_T
  LET lb_return = TRUE

  FOR li_loop = 1 TO lo_DZLM_T.getLength()
    LET ls_message = "Now update "||lo_DZLM_T[li_loop].DZLM002||" construct version '"||lo_DZLM_T[li_loop].DZLM005||"' to check-in."
    DISPLAY cs_information_tag,ls_message
    CALL sadzp200_alm_set_dzlm_to_checkin(lo_DZLM_T[li_loop].*) RETURNING lb_result
    IF NOT lb_result THEN LET lb_return = lb_result END IF 
  END FOR

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzp200_alm_set_dzlm_to_checkin(p_DZLM_T)
DEFINE
  p_DZLM_T  T_DZLM_T
DEFINE
  lo_DZLM_T      T_DZLM_T,
  ls_update_sql  STRING,
  ldt_current    DATETIME YEAR TO SECOND,
  ls_message     STRING
DEFINE
  lb_return BOOLEAN  
  
  LET lo_DZLM_T.*  = p_DZLM_T.*

  &ifndef DEBUG
  LET ldt_current = cl_get_current() --CURRENT YEAR TO SECOND
  &else
  LET ldt_current = CURRENT YEAR TO SECOND
  &endif  

  LET ls_message = "Force check-in : ",ldt_current
  
  LET ls_update_sql = "UPDATE DZLM_T                                             ",
                      "   SET DZLM008 = CASE                                     ",
                      "                   WHEN DZLM008 IS NULL THEN NULL         ",
                      "                 ELSE                                     ",
                      "                   'I'                                    ",         
                      "                 END,                                     ",
                      "       DZLM011 = CASE                                     ",
                      "                   WHEN DZLM011 IS NULL THEN NULL         ",
                      "                 ELSE                                     ",
                      "                   'I'                                    ",         
                      "                 END,                                     ",
                      "       DZLM017 = CASE                                     ",
                      "                   WHEN DZLM017 IS NOT NULL THEN DZLM017  ",
                      "                 ELSE                                     ",
                      "                   SYSDATE                                ",         
                      "                 END,                                     ",
                      "       DZLM018 = '",ls_message,"'                         ",
                      " WHERE 1=1                                                ",
                      "   AND DZLM001 = '",lo_DZLM_T.DZLM001,"'                  ",
                      "   AND DZLM002 = '",lo_DZLM_T.DZLM002,"'                  ",
                      "   AND DZLM005 =  ",lo_DZLM_T.DZLM005,"                   ",
                      "   AND DZLM012 = '",lo_DZLM_T.DZLM012,"'                  ",
                      "   AND DZLM013 = '",lo_DZLM_T.DZLM013,"'                  ",
                      "   AND DZLM014 = '",lo_DZLM_T.DZLM014,"'                  ",
                      "   AND DZLM015 =  ",lo_DZLM_T.DZLM015,"                   "
  
  TRY
    PREPARE lpre_update_set_dzlm_to_checkin FROM ls_update_sql
    EXECUTE lpre_update_set_dzlm_to_checkin
    LET lb_return = TRUE 
  CATCH
    LET lb_return = FALSE 
    DISPLAY cs_error_tag,"Update dzlm_t record to check-in failed."
    DISPLAY ls_update_sql
  END TRY

  RETURN lb_return
  
END FUNCTION 
-- 160729-00008 end
