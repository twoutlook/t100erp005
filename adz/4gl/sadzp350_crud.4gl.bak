&include "../4gl/sadzp350_mcr.inc"

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp350_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp350_type.inc"

FUNCTION sadzp350_crud_inser_dzhg_t(p_dzhg_t)
DEFINE
  p_dzhg_t T_DZHG_T
DEFINE  
  lo_dzhg_t T_DZHG_T
DEFINE
  lb_success  BOOLEAN,
  ls_user     VARCHAR(100)

  LET lo_dzhg_t.* = p_dzhg_t.*
  LET lb_success = TRUE

  LET ls_user = FGL_GETENV("USERNUMBER")

  TRY
    INSERT INTO DZHG_T(
                       DZHG001,DZHG002,DZHG003,DZHG004,DZHG005,
                       DZHG006,DZHG007,DZHG008,DZHG009,DZHG010,
                       DZHG011,DZHG012
                      ) 
               VALUES (
                       lo_dzhg_t.DZHG001,lo_dzhg_t.DZHG002,lo_dzhg_t.DZHG003,lo_dzhg_t.DZHG004,lo_dzhg_t.DZHG005,
                       lo_dzhg_t.DZHG006,lo_dzhg_t.DZHG007,lo_dzhg_t.DZHG008,lo_dzhg_t.DZHG009,lo_dzhg_t.DZHG010,
                       lo_dzhg_t.DZHG011,lo_dzhg_t.DZHG012
                      )
    
  CATCH 
    TRY
      UPDATE DZHG_T                                 
         SET DZHG003 = lo_dzhg_t.dzhg003,
             DZHG004 = lo_dzhg_t.dzhg004,
             DZHG005 = lo_dzhg_t.dzhg005,
             DZHG006 = lo_dzhg_t.dzhg006,
             DZHG007 = lo_dzhg_t.dzhg007,
             DZHG008 = lo_dzhg_t.dzhg008,
             DZHG009 = lo_dzhg_t.dzhg009,
             DZHG010 = lo_dzhg_t.dzhg010,
             DZHG011 = lo_dzhg_t.dzhg011,
             DZHG012 = lo_dzhg_t.dzhg012
       WHERE DZHG001 = lo_dzhg_t.dzhg001
         AND DZHG002 = lo_dzhg_t.dzhg002
    CATCH
      LET lb_success = FALSE
      DISPLAY cs_warning_tag,"Insert or Update DZHG_T unsuccess : ",SQLCA.sqlcode
    END TRY
  END TRY

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp350_crud_delete_expired_log_data(p_reserve_days)
DEFINE
  p_reserve_days STRING
DEFINE
  ls_reserve_days STRING,
  ls_exec_sql     STRING
DEFINE
  lb_return  BOOLEAN  

  LET ls_reserve_days = p_reserve_days
  
  LET lb_return = TRUE
  
  #刪除過期的 Log 資料
  LET ls_exec_sql = "DELETE FROM DZHG_T                                          ",
                    " WHERE DZHG012 <= TRUNC(SYSTIMESTAMP) - ",ls_reserve_days," "
                    
  TRY
    PREPARE lpre_exec_sql FROM ls_exec_sql
    EXECUTE lpre_exec_sql
  CATCH
    LET lb_return = FALSE
    DISPLAY cs_error_tag,"Execute SQL ",ls_exec_sql," not success." 
  END TRY

  RETURN lb_return  

END FUNCTION
