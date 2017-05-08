&include "../4gl/sadzi180_mcr.inc"
IMPORT OS

SCHEMA ds

&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi180_cnst.inc"

&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi180_type.inc"

DEFINE m_mdm_schema_list DYNAMIC ARRAY OF T_SCHEMA_LIST

DEFINE ms_lang STRING
DEFINE mb_return BOOLEAN

FUNCTION sadzi180_scs_run()

  CALL sadzi180_scs_initialize()
  CALL sadzi180_scs_initial_form()
  CALL sadzi180_scs_start()
  CALL sadzi180_scs_finalize()

  RETURN mb_return,m_mdm_schema_list 

END FUNCTION 
  
FUNCTION sadzi180_scs_initialize()

  LET ms_lang = cs_default_lang

  LET mb_return = TRUE

END FUNCTION

FUNCTION sadzi180_scs_initial_form()
  OPTIONS INPUT WRAP

  &ifndef DEBUG
    OPEN WINDOW w_sadzi180_scs WITH FORM cl_ap_formpath("ADZ","sadzi180_scs")
    #CONNECT TO cs_master_db
  &else
    OPEN WINDOW w_sadzi180_scs WITH FORM sadzi180_util_get_form_path("sadzi180_scs")
    #CONNECT TO "local"
  &endif
  
  CURRENT WINDOW IS w_sadzi180_scs
  
END FUNCTION 

FUNCTION sadzi180_scs_start()
DEFINE 
  li_index        INTEGER,
  ls_columns      STRING,
  ls_pick_table   STRING,
  li_column_count INTEGER,
  lo_dnd          ui.DragDrop
DEFINE
  ls_return STRING   

  LET ls_columns = ""

  CALL sadzi180_scs_fill_mdm_schema_list()
  
  DIALOG ATTRIBUTE(UNBUFFERED)

    INPUT ARRAY m_mdm_schema_list FROM sr_schema.*  ATTRIBUTE(WITHOUT DEFAULTS)
    END INPUT
    
    ON ACTION btn_ok 
      LET mb_return = TRUE
      EXIT DIALOG
      
    ON ACTION btn_cancel 
      LET mb_return = FALSE
      EXIT DIALOG
      
    ON ACTION CLOSE
      LET mb_return = FALSE
      EXIT DIALOG
  
  END DIALOG

END FUNCTION

FUNCTION sadzi180_scs_finalize()
  CLOSE WINDOW w_sadzi180_scs
END FUNCTION

FUNCTION sadzi180_scs_fill_mdm_schema_list()
DEFINE 
  ls_sql   STRING,
  li_count INTEGER

  LET ls_sql = "SELECT 'Y' CHECK_BOX, EJ.DZEJ007         ",
               "  FROM DZEJ_T EJ                         ",
               " WHERE EJ.DZEJ001 = 'adzi180_parameters' ",
               "   AND EJ.DZEJ003 = 'DBDefine'           ",
               "   AND EJ.DZEJ004 = 'MDMDB'              ",
               " ORDER BY DZEJ007                        "
               
  PREPARE lpre_fill_mdm_schema_list FROM ls_sql
  DECLARE lcur_fill_mdm_schema_list CURSOR FOR lpre_fill_mdm_schema_list
  OPEN lcur_fill_mdm_schema_list

  CALL m_mdm_schema_list.clear()
  
  LET li_count = 1

  FOREACH lcur_fill_mdm_schema_list INTO m_mdm_schema_list[li_count].*    
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET li_count = li_count + 1
    
  END FOREACH
  CALL m_mdm_schema_list.deleteElement(li_count)

END FUNCTION