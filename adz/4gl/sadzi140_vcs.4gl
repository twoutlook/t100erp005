
IMPORT util

&include "../4gl/sadzp000_cnst.inc"

SCHEMA ds

PRIVATE TYPE T_DZEO_T RECORD
               dzeo001 LIKE dzeo_t.dzeo001,
               dzeo002 LIKE dzeo_t.dzeo002,
               dzeo003 LIKE dzeo_t.dzeo003,
               dzeo004 LIKE dzeo_t.dzeo004,
               dzeo005 LIKE dzeo_t.dzeo005,
               dzeo006 LIKE dzeo_t.dzeo006,
               dzeo007 LIKE dzeo_t.dzeo007,
               dzeo008 LIKE dzeo_t.dzeo008,
               dzeo009 LIKE dzeo_t.dzeo009 
             END RECORD

FUNCTION sadzi140_vcs_get_new_seqence(p_object,p_major,p_minor,p_rev,p_build,p_stage)
DEFINE
  p_object STRING,
  p_major  BOOLEAN,
  p_minor  BOOLEAN,
  p_rev    BOOLEAN,
  p_build  BOOLEAN,
  p_stage  INTEGER
DEFINE
  ls_object   STRING,
  ls_sequence STRING,
  lo_dzeo_t   T_DZEO_T
DEFINE
  ls_return STRING  

  LET ls_object = p_object.toUpperCase()

  CALL sadzi140_vcs_set_vcs_define(ls_object,p_major,p_minor,p_rev,p_build)
  CALL sadzi140_vcs_get_vcs_define(ls_object) RETURNING lo_dzeo_t.*

  CASE p_stage
    WHEN 1
      LET ls_sequence = NVL(lo_dzeo_t.dzeo002,"0")
    WHEN 2
      LET ls_sequence = NVL(lo_dzeo_t.dzeo003,"0")
    WHEN 3
      LET ls_sequence = NVL(lo_dzeo_t.dzeo004,"0")
    WHEN 4
      LET ls_sequence = NVL(lo_dzeo_t.dzeo005,"0")
  OTHERWISE  
  END CASE

  LET ls_return = ls_sequence
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_vcs_get_curr_seqence(p_object)
DEFINE
  p_object STRING,
  p_stage  INTEGER
DEFINE
  ls_object   STRING,
  ls_sequence STRING,
  lo_dzeo_t   T_DZEO_T
DEFINE
  ls_return STRING  

  LET ls_object = p_object.toUpperCase()

  CALL sadzi140_vcs_get_vcs_define(ls_object) RETURNING lo_dzeo_t.*

  CASE p_stage
    WHEN 1
      LET ls_sequence = NVL(lo_dzeo_t.dzeo002,"0")
    WHEN 2                                   
      LET ls_sequence = NVL(lo_dzeo_t.dzeo003,"0")
    WHEN 3                                   
      LET ls_sequence = NVL(lo_dzeo_t.dzeo004,"0")
    WHEN 4                                   
      LET ls_sequence = NVL(lo_dzeo_t.dzeo005,"0")
  OTHERWISE  
  END CASE

  LET ls_return = ls_sequence
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_vcs_get_new_version_code(p_object,p_major,p_minor,p_rev,p_build,p_level)
DEFINE
  p_object STRING,
  p_major  BOOLEAN,
  p_minor  BOOLEAN,
  p_rev    BOOLEAN,
  p_build  BOOLEAN,
  p_level  INTEGER 
DEFINE
  ls_object  STRING,
  ls_level   STRING,
  ls_version STRING,
  lo_dzeo_t  T_DZEO_T
DEFINE
  ls_return STRING  

  LET ls_object = p_object.toUpperCase()

  CALL sadzi140_vcs_set_vcs_define(ls_object,p_major,p_minor,p_rev,p_build)
  CALL sadzi140_vcs_get_vcs_define(ls_object) RETURNING lo_dzeo_t.*

  CASE p_level
    WHEN 1
      LET ls_level = NVL((NVL(lo_dzeo_t.dzeo005,0) USING "<<<<<"),"0")
    WHEN 2
      LET ls_level = NVL((NVL(lo_dzeo_t.dzeo004,0) USING "<<<<<"),"0"),".",
                     NVL((NVL(lo_dzeo_t.dzeo005,0) USING "<<<<<"),"0")
    WHEN 3
      LET ls_level = NVL((NVL(lo_dzeo_t.dzeo003,0) USING "<<<<<"),"0"),".",
                     NVL((NVL(lo_dzeo_t.dzeo004,0) USING "<<<<<"),"0"),".",
                     NVL((NVL(lo_dzeo_t.dzeo005,0) USING "<<<<<"),"0")
    WHEN 4
      LET ls_level = NVL((NVL(lo_dzeo_t.dzeo002,0) USING "<<<<<"),"0"),".",
                     NVL((NVL(lo_dzeo_t.dzeo003,0) USING "<<<<<"),"0"),".",
                     NVL((NVL(lo_dzeo_t.dzeo004,0) USING "<<<<<"),"0"),".",
                     NVL((NVL(lo_dzeo_t.dzeo005,0) USING "<<<<<"),"0")
    OTHERWISE
      LET ls_level = NVL((NVL(lo_dzeo_t.dzeo005,0) USING "<<<<<"),"0")
  END CASE 
  
  LET ls_version = ls_level

  LET ls_return = ls_version
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_vcs_get_curr_version_code(p_object,p_level)
DEFINE
  p_object STRING,
  p_level  INTEGER
DEFINE
  ls_object  STRING,
  ls_version STRING,
  ls_level   STRING,
  lo_dzeo_t  T_DZEO_T
DEFINE
  ls_return STRING  

  LET ls_object = p_object.toUpperCase()

  CALL sadzi140_vcs_get_vcs_define(ls_object) RETURNING lo_dzeo_t.*

  CASE p_level
    WHEN 1
      LET ls_level = NVL((NVL(lo_dzeo_t.dzeo005,0) USING "<<<<<"),"0")
    WHEN 2
      LET ls_level = NVL((NVL(lo_dzeo_t.dzeo004,0) USING "<<<<<"),"0"),".",
                     NVL((NVL(lo_dzeo_t.dzeo005,0) USING "<<<<<"),"0")
    WHEN 3
      LET ls_level = NVL((NVL(lo_dzeo_t.dzeo003,0) USING "<<<<<"),"0"),".",
                     NVL((NVL(lo_dzeo_t.dzeo004,0) USING "<<<<<"),"0"),".",
                     NVL((NVL(lo_dzeo_t.dzeo005,0) USING "<<<<<"),"0")
    WHEN 4
      LET ls_level = NVL((NVL(lo_dzeo_t.dzeo002,0) USING "<<<<<"),"0"),".",
                     NVL((NVL(lo_dzeo_t.dzeo003,0) USING "<<<<<"),"0"),".",
                     NVL((NVL(lo_dzeo_t.dzeo004,0) USING "<<<<<"),"0"),".",
                     NVL((NVL(lo_dzeo_t.dzeo005,0) USING "<<<<<"),"0")
    OTHERWISE
      LET ls_level = NVL((NVL(lo_dzeo_t.dzeo005,0) USING "<<<<<"),"0")
  END CASE 

  LET ls_version = ls_level

  LET ls_return = ls_version
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_vcs_get_vcs_define(p_object)
DEFINE
  p_object  STRING 
DEFINE
  ls_object STRING,
  ls_sql    STRING,
  lo_dzeo_t T_DZEO_T

  LET ls_object = p_object.toUpperCase()

  LET ls_sql = "SELECT EO.DZEO001,                  ",
               "       EO.DZEO002,                  ",
               "       EO.DZEO003,                  ",
               "       EO.DZEO004,                  ",
               "       EO.DZEO005,                  ",
               "       EO.DZEO006,                  ",
               "       EO.DZEO007,                  ",
               "       EO.DZEO008,                  ",
               "       EO.DZEO009                   ",
               "  FROM DZEO_T EO                    ",
               " WHERE EO.DZEO001 = '",ls_object,"' " 

  PREPARE lpre_get_vcs_define FROM ls_sql
  DECLARE lcur_get_vcs_define CURSOR FOR lpre_get_vcs_define

  OPEN lcur_get_vcs_define
  FETCH lcur_get_vcs_define INTO lo_dzeo_t.*
  CLOSE lcur_get_vcs_define
  
  FREE lpre_get_vcs_define
  FREE lcur_get_vcs_define  

  RETURN lo_dzeo_t.*
  
END FUNCTION

FUNCTION sadzi140_vcs_set_vcs_define(p_object,p_major,p_minor,p_rev,p_build)
DEFINE
  p_object  STRING,
  p_major   BOOLEAN,
  p_minor   BOOLEAN,
  p_rev     BOOLEAN,
  p_build   BOOLEAN
DEFINE
  ls_object     STRING,
  ls_insert_sql STRING,
  ls_update_sql STRING,
  ls_set_sql    STRING
  
  LET ls_object = p_object.toUpperCase()

  LET ls_insert_sql = ""
  LET ls_update_sql = ""
  LET ls_set_sql    = ""

  IF p_major THEN
    LET ls_set_sql = ls_set_sql," DZEO002 = DZEO002 + 1"
  END IF

  IF p_minor THEN
    IF ls_set_sql IS NOT NULL THEN
      LET ls_set_sql = ls_set_sql,",\n"
    END IF
    LET ls_set_sql = ls_set_sql," DZEO003 = DZEO003 + 1"
  END IF
  
  IF p_rev THEN
    IF ls_set_sql IS NOT NULL THEN
      LET ls_set_sql = ls_set_sql,",\n"
    END IF
    LET ls_set_sql = ls_set_sql," DZEO004 = DZEO004 + 1"
  END IF
  
  IF p_build THEN
    IF ls_set_sql IS NOT NULL THEN
      LET ls_set_sql = ls_set_sql,",\n"
    END IF
    LET ls_set_sql = ls_set_sql," DZEO005 = DZEO005 + 1"
  END IF
  
  LET ls_insert_sql = "INSERT INTO DZEO_T(DZEO001,DZEO002,DZEO003,DZEO004,DZEO005)",
                      "            VALUES('",ls_object,"',0,0,0,0)                "

  LET ls_update_sql = "UPDATE DZEO_T EO                   ",
                      "   SET ", 
                      ls_set_sql,
                      " WHERE EO.DZEO001 = '",ls_object,"'"   

  TRY
    PREPARE lpre_insert_dzeo FROM ls_insert_sql
    EXECUTE lpre_insert_dzeo
  CATCH
    DISPLAY "[Hint] Object ",ls_object," already exists."
  END TRY

  IF p_major OR p_minor OR p_rev OR p_build THEN
    TRY    
      PREPARE lpre_update_dzeo FROM ls_update_sql
      EXECUTE lpre_update_dzeo
    CATCH
      DISPLAY cs_error_tag,"Update DZEO_T unsuccess."
      DISPLAY "[Update SQL] ",ls_update_sql
    END TRY
  END IF
  
END FUNCTION

FUNCTION sadzi140_vcs_delete_vcs_data(p_object)
DEFINE
  p_object  STRING
DEFINE
  ls_object     STRING,
  ls_delete_sql STRING
  
  LET ls_object = p_object.toUpperCase() 

  LET ls_delete_sql = "DELETE FROM DZEO_T EO              ",
                      " WHERE EO.DZEO001 = '",ls_object,"'" 
 
  BEGIN WORK
  TRY
    PREPARE lpre_delete_vcs_data FROM ls_delete_sql
    EXECUTE lpre_delete_vcs_data
  CATCH
    DISPLAY cs_error_tag,"DELETE '",ls_object,"' FROM DZEO_T Failed !"
    ROLLBACK WORK
    BEGIN WORK
  END TRY
  COMMIT WORK

END FUNCTION

FUNCTION sadzi140_vcs_reset_vcs_data(p_object)
DEFINE
  p_object  STRING
DEFINE
  ls_object     STRING,
  ls_delete_sql STRING
  
  LET ls_object  = p_object.toUpperCase() 

  LET ls_delete_sql = "UPDATE DZEO_T EO                   ",
                      "   SET EO.DZEO002 = 0,             ",
                      "       EO.DZEO003 = 0,             ",
                      "       EO.DZEO004 = 0,             ",
                      "       EO.DZEO005 = 0              ",
                      " WHERE EO.DZEO001 = '",ls_object,"'" 
 
  BEGIN WORK
  TRY
    PREPARE lpre_reset_vcs_data FROM ls_delete_sql
    EXECUTE lpre_reset_vcs_data
  CATCH
    DISPLAY cs_error_tag,"Reset '",ls_object,"' FROM DZEO_T Failed !"
    ROLLBACK WORK
    BEGIN WORK
  END TRY
  COMMIT WORK

END FUNCTION

