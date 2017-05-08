&include "../4gl/sadzi140_mcr.inc"

IMPORT util 
IMPORT os 
IMPORT security
IMPORT xml

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp240_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp240_type.inc"

FUNCTION sadzp240_vfy_insert_update_dzez_t(p_dzez_t)
DEFINE
  p_dzez_t  T_DZEZ_T
DEFINE 
  lo_dzez_t T_DZEZ_T

  LET lo_dzez_t.* = p_dzez_t.*

  TRY 
    INSERT INTO DZEZ_T(
                        DZEZ001,DZEZ002,DZEZ003,DZEZ004,DZEZ005,
                        DZEZ006,DZEZ007
                      )
               VALUES (
                        lo_dzez_t.dzez001,lo_dzez_t.dzez002,lo_dzez_t.dzez003,lo_dzez_t.dzez004,lo_dzez_t.dzez005,
                        lo_dzez_t.dzez006,lo_dzez_t.dzez007
                      )
  CATCH
    DISPLAY cs_warning_tag," Insert DZEZ_T unsuccess."
    TRY
      UPDATE DZEZ_T                                 
         SET DZEZ003 = NVL(DZEZ003,lo_dzez_t.dzez003),
             DZEZ004 = NVL(DZEZ004,lo_dzez_t.dzez004),
             DZEZ005 = NVL(DZEZ005,lo_dzez_t.dzez005),
             DZEZ006 = NVL(DZEZ006,lo_dzez_t.dzez006),
             DZEZ007 = NVL(DZEZ007,lo_dzez_t.dzez007)
       WHERE DZEZ001 = lo_dzez_t.dzez001
         AND DZEZ002 = lo_dzez_t.dzez002
    CATCH
      DISPLAY cs_error_tag," Insert or Update DZEZ_T unsuccess : ",SQLCA.sqlcode
    END TRY    
  END TRY

END FUNCTION

FUNCTION sadzp240_vfy_set_status_code(p_dzez_t)
DEFINE
  p_dzez_t  T_DZEZ_T
DEFINE 
  lo_dzez_t T_DZEZ_T

  LET lo_dzez_t.* = p_dzez_t.*

  TRY
    UPDATE DZEZ_T                                 
       SET DZEZ003 = lo_dzez_t.dzez003
     WHERE DZEZ001 = lo_dzez_t.dzez001
       AND DZEZ002 = lo_dzez_t.dzez002
  CATCH
    DISPLAY cs_error_tag," Update status code unsuccess : ",SQLCA.sqlcode
  END TRY    

END FUNCTION

FUNCTION sadzp240_vfy_set_sub_pack_name(p_dzez_t)
DEFINE
  p_dzez_t  T_DZEZ_T
DEFINE 
  lo_dzez_t T_DZEZ_T

  LET lo_dzez_t.* = p_dzez_t.*

  TRY
    UPDATE DZEZ_T                                 
       SET DZEZ004 = lo_dzez_t.dzez004
     WHERE DZEZ001 = lo_dzez_t.dzez001
       AND DZEZ002 = lo_dzez_t.dzez002
  CATCH
    DISPLAY cs_error_tag," Update status code unsuccess : ",SQLCA.sqlcode
  END TRY    

END FUNCTION

FUNCTION sadzp240_vfy_set_start_time(p_dzez_t)
DEFINE
  p_dzez_t  T_DZEZ_T
DEFINE 
  lo_dzez_t T_DZEZ_T,
  ldt_datetime DATETIME YEAR TO SECOND

  LET lo_dzez_t.* = p_dzez_t.*

  &ifndef DEBUG
  LET ldt_datetime = cl_get_current()
  &else
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif
  
  TRY
    UPDATE DZEZ_T                                 
       SET DZEZ005 = ldt_datetime,
           DZEZ006 = NULL
     WHERE DZEZ001 = lo_dzez_t.dzez001
       AND DZEZ002 = lo_dzez_t.dzez002
  CATCH
    DISPLAY cs_error_tag," Update start time unsuccess : ",SQLCA.sqlcode
  END TRY    

END FUNCTION

FUNCTION sadzp240_vfy_set_end_time(p_dzez_t)
DEFINE
  p_dzez_t  T_DZEZ_T
DEFINE 
  lo_dzez_t T_DZEZ_T,
  ldt_datetime DATETIME YEAR TO SECOND

  LET lo_dzez_t.* = p_dzez_t.*

  &ifndef DEBUG
  LET ldt_datetime = cl_get_current()
  &else
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif
    
  TRY
    UPDATE DZEZ_T                                 
       SET DZEZ006 = ldt_datetime
     WHERE DZEZ001 = lo_dzez_t.dzez001
       AND DZEZ002 = lo_dzez_t.dzez002
  CATCH
    DISPLAY cs_error_tag," Update end time unsuccess : ",SQLCA.sqlcode
  END TRY    

END FUNCTION

FUNCTION sadzp240_vfy_kill_expired_verify_data()
DEFINE
  ls_exec_sql STRING

  #刪除過期的 Interface 資料
  LET ls_exec_sql = "DELETE FROM DZEZ_T                          ",
                    " WHERE DZEZ005 <= TRUNC(SYSTIMESTAMP) - 365 "
                    
  BEGIN WORK

  TRY
    PREPARE lpre_exec_sql FROM ls_exec_sql
    EXECUTE lpre_exec_sql
    COMMIT WORK
  CATCH
    DISPLAY cs_error_tag,"Execute SQL ",ls_exec_sql," not success." 
    ROLLBACK WORK
  END TRY  
  
END FUNCTION 

FUNCTION sadzp240_vfy_generate_verify(p_guid,p_dzlm_table_list)
DEFINE
  p_guid     STRING,
  p_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  ls_guid      STRING,
  lo_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_dzez_t    T_DZEZ_T,
  li_count     INTEGER,
  ldt_datetime DATETIME YEAR TO SECOND
DEFINE
  lb_return BOOLEAN

  LET ls_guid = p_guid
  LET lo_dzlm_table_list = p_dzlm_table_list

  LET lb_return = TRUE

  BEGIN WORK 
  
  FOR li_count = 1 TO lo_dzlm_table_list.getLength() 
    &ifndef DEBUG
    LET ldt_datetime = cl_get_current()
    &else
    LET ldt_datetime = CURRENT YEAR TO SECOND
    &endif
    LET lo_dzez_t.DZEZ001 = ls_GUID
    LET lo_dzez_t.DZEZ002 = lo_dzlm_table_list[li_count].dtl_DZLM002
    LET lo_dzez_t.DZEZ003 = cs_state_waiting
    LET lo_dzez_t.DZEZ004 = NULL
    LET lo_dzez_t.DZEZ005 = NULL
    LET lo_dzez_t.DZEZ006 = NULL
    LET lo_dzez_t.DZEZ007 = lo_dzlm_table_list[li_count].dtl_MODULE
    #Insert 到DZEZ去
    CALL sadzp240_vfy_insert_update_dzez_t(lo_dzez_t.*)
  END FOR

  COMMIT WORK

  RETURN lb_return

END FUNCTION 