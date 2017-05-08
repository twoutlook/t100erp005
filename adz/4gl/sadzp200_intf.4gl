&include "../4gl/sadzp000_mcr.inc"

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"

FUNCTION sadzp200_intf_delete_interface_data(p_role,p_DZLM_T)
DEFINE
  p_role    STRING,
  p_DZLM_T  T_DZLM_T
DEFINE
  ls_role    STRING,
  lo_DZLM_T  T_DZLM_T,
  ls_message STRING,
  lb_result  BOOLEAN
DEFINE 
  lb_return BOOLEAN 

  LET ls_role     = p_role
  LET lo_DZLM_T.* = p_DZLM_T.*  

  LET lb_return = TRUE

  CASE 
    WHEN ls_role = cs_user_role_sd
      LET ls_message = "Delete dzan_t data by sd."
      CALL sadzp200_intf_delete_dzan_sd_data(lo_DZLM_T.*) RETURNING lb_result
    WHEN ls_role = cs_user_role_pr
      LET ls_message = "Delete dzan_t data by pr."
      CALL sadzp200_intf_delete_dzan_pr_data(lo_DZLM_T.*) RETURNING lb_result
  END CASE 

  LET lb_return = lb_result

  IF NOT lb_result THEN
    DISPLAY cs_error_tag,ls_message 
  END IF 
  
  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzp200_intf_delete_dzan_sd_data(p_DZLM_T)
DEFINE
  p_DZLM_T  T_DZLM_T
DEFINE
  lo_DZLM_T  T_DZLM_T
DEFINE 
  lb_return BOOLEAN 
  
  LET lo_DZLM_T.* = p_DZLM_T.*  

  DELETE FROM DZAN_T
   WHERE DZAN011 = lo_DZLM_T.DZLM018  

  IF SQLCA.sqlcode = 0 THEN
    LET lb_return = TRUE
  ELSE
    LET lb_return = FALSE
  END IF 
  
  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzp200_intf_delete_dzan_pr_data(p_DZLM_T)
DEFINE
  p_DZLM_T  T_DZLM_T
DEFINE
  lo_DZLM_T  T_DZLM_T
DEFINE 
  lb_return BOOLEAN 
  
  LET lo_DZLM_T.* = p_DZLM_T.*  

  DELETE FROM DZAN_T
   WHERE DZAN011 = lo_DZLM_T.DZLM019  

  IF SQLCA.sqlcode = 0 THEN
    LET lb_return = TRUE
  ELSE
    LET lb_return = FALSE
  END IF 
  
  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzp200_intf_set_interface_data(p_guid,p_role,p_prev_dzaf,p_curr_dzaf)
DEFINE
  p_guid       STRING,
  p_role       STRING,
  p_prev_dzaf  T_DZAF_T,
  p_curr_dzaf  T_DZAF_T
DEFINE
  ls_guid       STRING,
  ls_role       STRING,
  lo_prev_dzaf  T_DZAF_T,
  lo_curr_dzaf  T_DZAF_T,
  lb_result     BOOLEAN  
DEFINE 
  lb_return BOOLEAN  

  LET ls_guid = p_guid
  LET ls_role = p_role
  LET lo_prev_dzaf.* = p_prev_dzaf.*
  LET lo_curr_dzaf.* = p_curr_dzaf.*

  LET lb_result = TRUE 
  LET lb_return = TRUE
  
  CALL sadzp200_intf_set_dzan_t_data(ls_guid,ls_role,cs_interface_type_prev,lo_prev_dzaf.*) RETURNING lb_result
  IF NOT lb_result THEN GOTO _return END IF
  CALL sadzp200_intf_set_dzan_t_data(ls_guid,ls_role,cs_interface_type_curr,lo_curr_dzaf.*) RETURNING lb_result
  IF NOT lb_result THEN GOTO _return END IF

  LABEL _return:

  LET lb_return = lb_result

  RETURN lb_return  
  
END FUNCTION 

FUNCTION sadzp200_intf_set_dzan_t_data(p_guid,p_role,p_type,p_dzaf_t)
DEFINE
  p_guid    STRING,
  p_role    STRING,
  p_type    STRING,
  p_dzaf_t  T_DZAF_T
DEFINE
  lv_guid    VARCHAR(40),
  lv_role    VARCHAR(10),
  lv_type    VARCHAR(10),
  lo_dzaf_t  T_DZAF_T,
  lo_dzan_t  T_DZAN_T,
  lb_result  BOOLEAN
DEFINE
  lb_return  BOOLEAN

  LET lv_guid     = p_guid
  LET lv_role     = p_role
  LET lv_type     = p_type
  LET lo_dzaf_t.* = p_dzaf_t.*

  LET lb_result = TRUE
  LET lb_return = TRUE

  LET lo_dzan_t.DZAN001 = lo_dzaf_t.DZAF001
  LET lo_dzan_t.DZAN002 = lo_dzaf_t.DZAF002
  LET lo_dzan_t.DZAN003 = lo_dzaf_t.DZAF003
  LET lo_dzan_t.DZAN004 = lo_dzaf_t.DZAF004
  LET lo_dzan_t.DZAN005 = lo_dzaf_t.DZAF005
  LET lo_dzan_t.DZAN006 = lo_dzaf_t.DZAF006
  LET lo_dzan_t.DZAN007 = lo_dzaf_t.DZAF007
  LET lo_dzan_t.DZAN008 = lo_dzaf_t.DZAF008
  LET lo_dzan_t.DZAN009 = lo_dzaf_t.DZAF009
  LET lo_dzan_t.DZAN010 = lo_dzaf_t.DZAF010
  LET lo_dzan_t.DZAN011 = lv_guid
  LET lo_dzan_t.DZAN012 = lv_role
  LET lo_dzan_t.DZAN013 = lv_type
  &ifndef DEBUG
  LET lo_dzan_t.DZAN014 = cl_get_current() --CURRENT YEAR TO SECOND
  &else
  LET lo_dzan_t.DZAN014 = CURRENT YEAR TO SECOND
  &endif
  LET lo_dzan_t.DZAN015 = "N" 

  TRY 
    INSERT INTO DZAN_T (
                        DZAN001,DZAN002,DZAN003,DZAN004,DZAN005,
                        DZAN006,DZAN007,DZAN008,DZAN009,DZAN010,
                        DZAN011,DZAN012,DZAN013,DZAN014,DZAN015
                       ) VALUES
                       (
                        lo_dzan_t.DZAN001,lo_dzan_t.DZAN002,lo_dzan_t.DZAN003,lo_dzan_t.DZAN004,lo_dzan_t.DZAN005,
                        lo_dzan_t.DZAN006,lo_dzan_t.DZAN007,lo_dzan_t.DZAN008,lo_dzan_t.DZAN009,lo_dzan_t.DZAN010,
                        lo_dzan_t.DZAN011,lo_dzan_t.DZAN012,lo_dzan_t.DZAN013,lo_dzan_t.DZAN014,lo_dzan_t.DZAN015
                       )
  CATCH 
    LET lb_result = FALSE
  END TRY  

  LET lb_return = lb_result

  RETURN lb_return
                        
END FUNCTION 

FUNCTION sadzp200_intf_get_interface_data(p_guid,p_role)
DEFINE
  p_guid         STRING,
  p_role         STRING
DEFINE
  ls_guid   STRING,
  ls_role   STRING,
  ls_SQL    STRING,
  li_count  INTEGER,
  lo_DZAN_T DYNAMIC ARRAY OF T_DZAN_T 
DEFINE 
  lo_return DYNAMIC ARRAY OF T_DZAN_T 

  LET ls_guid = p_guid
  LET ls_role = p_role

  LET ls_SQL = "SELECT AN.DZAN001,AN.DZAN002,AN.DZAN003,AN.DZAN004,AN.DZAN005,",
               "       AN.DZAN006,AN.DZAN007,AN.DZAN008,AN.DZAN009,AN.DZAN010,",
               "       AN.DZAN011,AN.DZAN012,AN.DZAN013,AN.DZAN014,AN.DZAN015 ",
               "  FROM DZAN_T AN                                              ",
               " WHERE AN.DZAN011 = '",ls_guid.trim(),"'                      ",
               "   AND AN.DZAN012 = '",ls_role.trim(),"'                      "
               --"   AND AN.DZAN015 = '",ls_process_code.trim(),"'              "
               
  PREPARE lpre_get_interface_data FROM ls_sql
  DECLARE lcur_get_interface_data CURSOR FOR lpre_get_interface_data

  LET li_count = 1

  FOREACH lcur_get_interface_data INTO lo_DZAN_T[li_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_count = li_count + 1 

  END FOREACH
  
  CALL lo_DZAN_T.deleteElement(li_count)

  LET lo_return = lo_DZAN_T
  
  RETURN lo_return  
  
END FUNCTION 

FUNCTION sadzp200_intf_update_process_code(p_GUID,p_role,p_process_code)
DEFINE
  p_GUID STRING,
  p_role STRING,
  p_process_code STRING 
DEFINE
  ls_GUID VARCHAR(40),
  ls_role VARCHAR(10),
  ls_process_code VARCHAR(01)
DEFINE 
  lb_return BOOLEAN 

  LET ls_GUID = p_GUID
  LET ls_role = p_role
  LET ls_process_code = p_process_code

  UPDATE DZAN_T
     SET DZAN015 = ls_process_code
   WHERE DZAN011 = ls_GUID
     AND DZAN012 = ls_role  

  IF SQLCA.sqlcode = 0 THEN
    LET lb_return = TRUE
  ELSE
    LET lb_return = FALSE
  END IF 
  
  RETURN lb_return  
  
END FUNCTION
