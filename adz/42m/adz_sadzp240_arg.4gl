&include "../4gl/sadzi140_mcr.inc"
IMPORT OS

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp240_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp240_type.inc"

DEFINE ms_lang STRING
DEFINE m_arguments_scr DYNAMIC ARRAY OF T_ARGUMENT_LIST


FUNCTION sadzp240_arg_run()
  
  CALL sadzp240_arg_initialize()
  CALL sadzp240_arg_initial_form()
  CALL sadzp240_arg_start()
  CALL sadzp240_arg_finalize()

END FUNCTION 
  
FUNCTION sadzp240_arg_initialize()

  &ifndef DEBUG
    LET ms_lang = g_lang
  &else
    LET ms_lang = cs_default_language
  &endif
  
END FUNCTION

FUNCTION sadzp240_arg_initial_form()
DEFINE 
  lw_window   ui.Window,
  lf_form     ui.Form,
  ls_cfg_path STRING,
  ls_4st_path STRING,
  ls_img_path STRING
  
  OPTIONS INPUT WRAP

  &ifndef DEBUG
    OPEN WINDOW w_sadzp240_arg WITH FORM cl_ap_formpath("ADZ","sadzp240_arg")
  &else
    OPEN WINDOW w_sadzp240_arg WITH FORM "sadzp240_arg" -- sadzp240_util_get_form_path("sadzp240_arg")
  &endif
  
  CURRENT WINDOW IS w_sadzp240_arg
  CLOSE WINDOW SCREEN
  
  &ifndef DEBUG
  CALL cl_ui_wintitle(1) #工具抬頭名稱
  CALL cl_load_4ad_interface(NULL)
  &endif

  CALL sadzp240_util_set_form_title('sadzp240_arg',ms_lang)
  CALL sadzp240_util_set_form_style(ms_lang)
  
END FUNCTION 


FUNCTION sadzp240_arg_start()
DEFINE 
  lb_result  BOOLEAN
DEFINE
  lb_return BOOLEAN   

  DIALOG ATTRIBUTE(UNBUFFERED)
    
    INPUT ARRAY m_arguments_scr FROM sr_arguments.* ATTRIBUTE(WITHOUT DEFAULTS)
    END INPUT

    BEFORE DIALOG
      CALL sadzp240_fill_arguments()
    
    ON ACTION btn_ok
      BEGIN WORK 
      CALL sadzp240_arg_insert_update_arguments(m_arguments_scr)
      COMMIT WORK
      
      EXIT DIALOG
      
    ON ACTION btn_cancel 
      EXIT DIALOG
      
    ON ACTION CLOSE
      EXIT DIALOG
  
  END DIALOG

END FUNCTION

FUNCTION sadzp240_arg_finalize()
  CLOSE WINDOW w_sadzp240_arg
END FUNCTION

FUNCTION sadzp240_fill_arguments()
DEFINE 
  ls_sql         STRING,
  li_count       INTEGER

  LET ls_sql = "SELECT ''         AL_STATUS,             ",
               "       EJ.DZEJ002 AL_SEQUENCE,           ",
               "       EJ.DZEJ003 AL_CATEGORY,           ",
               "       EJ.DZEJ004 AL_TYPES,              ",
               "       EJ.DZEJ005 AL_CODE                ",
               "  FROM DZEJ_T EJ                         ",
               " WHERE EJ.DZEJ001 = 'adzp240_parameters' ",
               " ORDER BY EJ.DZEJ002                     "
                  
  PREPARE lpre_fill_arguments FROM ls_sql
  DECLARE lcur_fill_arguments CURSOR FOR lpre_fill_arguments

  CALL m_arguments_scr.clear()
  
  LET li_count = 1
  
  FOREACH lcur_fill_arguments INTO m_arguments_scr[li_count].*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_count = li_count + 1
    
  END FOREACH
  CALL m_arguments_scr.deleteElement(li_count)

END FUNCTION

FUNCTION sadzp240_arg_insert_update_arguments(p_arguments)
DEFINE
  p_arguments   DYNAMIC ARRAY OF T_ARGUMENT_LIST
DEFINE 
  lo_arguments  DYNAMIC ARRAY OF T_ARGUMENT_LIST,
  li_loop  INTEGER

  LET lo_arguments = p_arguments

  FOR li_loop = 1 TO lo_arguments.getLength()
    IF lo_arguments[li_loop].al_SEQUENCE IS NOT NULL AND
       lo_arguments[li_loop].al_TYPES IS NOT NULL THEN 
      TRY
        UPDATE DZEJ_T                                 
           SET DZEJ005 = lo_arguments[li_loop].al_CODE
         WHERE DZEJ001 = "adzp240_parameters"
           AND DZEJ002 = lo_arguments[li_loop].al_SEQUENCE
           AND DZEJ003 = lo_arguments[li_loop].al_CATEGORY
           AND DZEJ004 = lo_arguments[li_loop].al_TYPES
      CATCH
        DISPLAY cs_warning_tag,"Update DZEJ_T unsuccess : ",SQLCA.sqlcode
      END TRY
    END IF  
  END FOR

END FUNCTION
