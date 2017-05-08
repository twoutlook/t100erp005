&include "../4gl/sadzi190_mcr.inc"
IMPORT OS

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi190_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi190_type.inc"

CONSTANT cs_left  STRING = "sr_left"
CONSTANT cs_right STRING = "sr_right"

GLOBALS "../../cfg/top_global.inc"

DEFINE m_left_columns_list  DYNAMIC ARRAY OF T_COLUMN_LIST
DEFINE m_right_columns_list DYNAMIC ARRAY OF T_COLUMN_LIST

DEFINE ms_lang STRING

FUNCTION sadzi190_dtas_run(p_left_array,p_right_array)
DEFINE 
  p_left_array  DYNAMIC ARRAY OF T_COLUMN_LIST,
  p_right_array DYNAMIC ARRAY OF T_COLUMN_LIST
DEFINE
  ls_columns STRING 
  
  CALL sadzi190_dtas_initialize()
  CALL sadzi190_dtas_initial_form()
  CALL sadzi190_dtas_start(p_left_array,p_right_array) RETURNING ls_columns 
  CALL sadzi190_dtas_finalize()

  RETURN ls_columns
  
END FUNCTION 
  
FUNCTION sadzi190_dtas_initialize()

  &ifndef DEBUG
    LET ms_lang = g_lang
  &else
    LET ms_lang = cs_default_lang
  &endif
  
END FUNCTION

FUNCTION sadzi190_dtas_initial_form()
  OPTIONS INPUT WRAP

  &ifndef DEBUG
    OPEN WINDOW w_sadzi190_dtas WITH FORM cl_ap_formpath("ADZ","sadzi190_dtas")
    #CONNECT TO cs_master_db
  &else
    OPEN WINDOW w_sadzi190_dtas WITH FORM sadzi190_util_get_form_path("sadzi190_dtas")
    #CONNECT TO "local"
  &endif
  
  CURRENT WINDOW IS w_sadzi190_dtas
  
END FUNCTION 


FUNCTION sadzi190_dtas_start(p_left_array,p_right_array)
DEFINE 
  p_left_array  DYNAMIC ARRAY OF T_COLUMN_LIST,
  p_right_array DYNAMIC ARRAY OF T_COLUMN_LIST
DEFINE 
  drag_index, drop_index, i INT,
  drag_source STRING,
  drag_value  T_COLUMN_LIST
DEFINE 
  lo_left_array  DYNAMIC ARRAY OF T_COLUMN_LIST,
  lo_right_array DYNAMIC ARRAY OF T_COLUMN_LIST,
  li_index       INTEGER,
  ls_columns     STRING,
  lo_dnd         ui.DragDrop
DEFINE
  ls_return STRING   

  LET lo_left_array.*  = p_left_array.*
  LET lo_right_array.* = p_right_array.*

  LET ls_columns = ""
  
  DIALOG ATTRIBUTE(UNBUFFERED)
    DISPLAY ARRAY m_left_columns_list TO sr_left.*
      BEFORE ROW 
        CALL sadzi190_dtas_reload(DIALOG)
        
      ON DRAG_START(lo_dnd)
        LET drag_source = cs_left
        LET drag_index = arr_curr()
        LET drag_value.* = m_left_columns_list[drag_index].*

      ON DRAG_FINISHED(lo_dnd)
        INITIALIZE drag_source TO NULL

      ON DRAG_ENTER(lo_dnd)
        IF drag_source IS NULL THEN
          CALL lo_dnd.setOperation(NULL)
        END IF
        
      ON DROP (lo_dnd)
        IF drag_source == cs_left THEN
          CALL lo_dnd.dropInternal()
        ELSE
          LET drop_index = lo_dnd.getLocationRow()
          CALL DIALOG.insertRow(cs_left, drop_index)
          CALL DIALOG.setCurrentRow(cs_left, drop_index)
          LET m_left_columns_list[drop_index].* = drag_value.*
          CALL DIALOG.deleteRow(cs_right, drag_index)
        END IF
        
    END DISPLAY
    
    DISPLAY ARRAY m_right_columns_list TO sr_right.*
      BEFORE ROW 
        CALL sadzi190_dtas_reload(DIALOG)
      
      ON DRAG_START(lo_dnd)
        LET drag_source = cs_right
        LET drag_index = arr_curr()
        LET drag_value.* = m_right_columns_list[drag_index].*
        
      ON DRAG_FINISHED(lo_dnd)
        INITIALIZE drag_source TO NULL

      ON DRAG_ENTER(lo_dnd)
        IF drag_source IS NULL THEN
          CALL lo_dnd.setOperation(NULL)
        END IF
        
      ON DROP(lo_dnd)
        IF drag_source == cs_right THEN
          CALL lo_dnd.dropInternal()
        ELSE
          LET drop_index = lo_dnd.getLocationRow()
          CALL DIALOG.insertRow(cs_right, drop_index)
          CALL DIALOG.setCurrentRow(cs_right, drop_index)
          LET m_right_columns_list[drop_index].* = drag_value.*
          CALL DIALOG.deleteRow(cs_left, drag_index)
        END IF
        
    END DISPLAY

    BEFORE DIALOG
      CALL sadzi190_dtas_fill_left_columns_list(lo_left_array)
      CALL sadzi190_dtas_fill_right_columns_list(lo_right_array)
      CALL sadzi190_dtas_reload(DIALOG)
    
    ON ACTION right_move CALL sadzi190_dtas_move_to_left_or_right(DIALOG,cs_left,cs_right)
    ON ACTION left_move  CALL sadzi190_dtas_move_to_left_or_right(DIALOG,cs_right,cs_left)
    ON ACTION left_up    CALL sadzi190_dtas_move_up_or_down(DIALOG,cs_left,TRUE)
    ON ACTION left_down  CALL sadzi190_dtas_move_up_or_down(DIALOG,cs_left,FALSE)
    ON ACTION right_up   CALL sadzi190_dtas_move_up_or_down(DIALOG,cs_right,TRUE)
    ON ACTION right_down CALL sadzi190_dtas_move_up_or_down(DIALOG,cs_right,FALSE)
    
    ON ACTION btn_ok 
      LET ls_columns = ""
      IF m_right_columns_list.getLength() <> 0 THEN
        FOR li_index = 1 TO m_right_columns_list.getLength()
          LET ls_columns = ls_columns,m_right_columns_list[li_index].COLUMN_NAME,","
        END FOR 
        LET ls_columns = ls_columns.subString(1,ls_columns.getLength()-1)
      END IF   
      EXIT DIALOG
      
    ON ACTION btn_cancel 
      LET ls_columns = cs_result_cancel
      EXIT DIALOG
      
    ON ACTION CLOSE
      EXIT DIALOG
  
  END DIALOG

  LET ls_return = ls_columns

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi190_dtas_finalize()
  CLOSE WINDOW w_sadzi190_dtas
END FUNCTION

FUNCTION sadzi190_dtas_reload(p_dialog)
DEFINE 
  p_dialog ui.Dialog
  
  CALL p_dialog.setActionActive("right_move", m_left_columns_list.getLength()  > 0)
  CALL p_dialog.setActionActive("left_move" , m_right_columns_list.getLength() > 0)
  CALL p_dialog.setActionActive("left_up"   , p_dialog.getCurrentRow(cs_left)  > 1)
  CALL p_dialog.setActionActive("left_down" , p_dialog.getCurrentRow(cs_left)  < m_left_columns_list.getLength())
  CALL p_dialog.setActionActive("right_up"  , p_dialog.getCurrentRow(cs_right) > 1)
  CALL p_dialog.setActionActive("right_down", p_dialog.getCurrentRow(cs_right) < m_right_columns_list.getLength())
  
END FUNCTION

FUNCTION sadzi190_dtas_get_value(p_list_name,p_index)
DEFINE 
  p_list_name STRING,
  p_index     INT
  
  IF p_list_name = cs_left THEN
    RETURN m_left_columns_list[p_index].*
  ELSE
    RETURN m_right_columns_list[p_index].* 
  END IF
  
END FUNCTION

FUNCTION sadzi190_dtas_set_value(p_list_name,p_index,p_value)
DEFINE 
  p_list_name STRING
DEFINE 
  p_index INT,
  p_value T_COLUMN_LIST
  
  IF p_list_name = cs_left THEN 
    LET m_left_columns_list[p_index].* = p_value.*
  ELSE
    LET m_right_columns_list[p_index].* = p_value.* 
  END IF
  
END FUNCTION

-- Remove the current item from the source side and move it the destination side
FUNCTION sadzi190_dtas_move_to_left_or_right(p_dialog,p_source,p_dest)
DEFINE 
  p_dialog ui.Dialog,
  p_source STRING,
  p_dest   STRING
DEFINE 
  ls_source   STRING,
  ls_dest     STRING,
  li_idx_src  INT, 
  li_idx_dest INT, 
  lo_col_list T_COLUMN_LIST
  
  LET ls_source = p_source 
  LET ls_dest   = p_dest 
  
  CALL p_dialog.appendRow(ls_dest)

  LET li_idx_src  = p_dialog.getCurrentRow(ls_source)
  LET li_idx_dest = p_dialog.getArrayLength(ls_dest) -- getCurrentRow(ls_dest)
  LET li_idx_dest = IIF(li_idx_dest == 0,1,li_idx_dest)
  
  #CALL p_dialog.InsertRow(ls_dest,li_idx_dest)
  
  CALL sadzi190_dtas_get_value(ls_source,li_idx_src) RETURNING lo_col_list.*
  
  CALL sadzi190_dtas_set_value(ls_dest,li_idx_dest,lo_col_list.*)
  CALL p_dialog.deleteRow(ls_source,li_idx_src)
  CALL p_dialog.setCurrentRow(ls_dest,li_idx_dest)
  CALL sadzi190_dtas_reload(p_dialog)
  
END FUNCTION

-- Move the current item at the given side 1 row up or down
FUNCTION sadzi190_dtas_move_up_or_down(p_dialog,p_side,p_up)
DEFINE 
  p_dialog ui.Dialog,
  p_side   STRING,
  p_up     INT
DEFINE 
  li_idx  INT,
  li_step INT,
  lo_col_list_step  T_COLUMN_LIST,
  lo_col_list       T_COLUMN_LIST
  
  IF p_up THEN
    LET li_step = -1
  ELSE
    LET li_step = 1
  END IF
  
  LET li_idx = p_dialog.getCurrentRow(p_side)

  CALL sadzi190_dtas_get_value(p_side,li_idx) RETURNING lo_col_list.*
  CALL sadzi190_dtas_get_value(p_side,li_idx + li_step) RETURNING lo_col_list_step.*
  
  CALL sadzi190_dtas_set_value(p_side,li_idx + li_step,lo_col_list.*)
  CALL sadzi190_dtas_set_value(p_side,li_idx,lo_col_list_step.*)
  
  CALL p_dialog.setCurrentRow(p_side,li_idx + li_step)
  CALL sadzi190_dtas_reload(p_dialog)
  
END FUNCTION

FUNCTION sadzi190_dtas_fill_left_columns_list(p_array)
DEFINE 
  p_array  DYNAMIC ARRAY OF T_COLUMN_LIST
DEFINE 
  lo_array  DYNAMIC ARRAY OF T_COLUMN_LIST,
  li_index  INTEGER

  LET lo_array.* = p_array.*

  CALL m_left_columns_list.Clear();

  FOR li_index = 1 TO lo_array.getLength()
    LET m_left_columns_list[li_index].COLUMN_NAME = lo_array[li_index].COLUMN_NAME
    LET m_left_columns_list[li_index].COLUMN_DESC = lo_array[li_index].COLUMN_DESC
  END FOR 

END FUNCTION

FUNCTION sadzi190_dtas_fill_right_columns_list(p_array)
DEFINE 
  p_array  DYNAMIC ARRAY OF T_COLUMN_LIST
DEFINE 
  lo_array  DYNAMIC ARRAY OF T_COLUMN_LIST,
  li_index  INTEGER

  LET lo_array.* = p_array.*

  CALL m_right_columns_list.Clear();

  FOR li_index = 1 TO lo_array.getLength()
    LET m_right_columns_list[li_index].COLUMN_NAME = lo_array[li_index].COLUMN_NAME
    LET m_right_columns_list[li_index].COLUMN_DESC = lo_array[li_index].COLUMN_DESC
  END FOR 

END FUNCTION
#解析字串  example return value = "'dsaws','dsawst'"
#加入判斷 "ERPDB" and "MDMDB" 字串  #add_at 20160126 by DGW07558
FUNCTION sadzi190_dtas_decode_columns(p_columns)
DEFINE 
  p_columns STRING
DEFINE 
  li_index          INTEGER,
  ls_column_char    STRING,
  ls_columns        STRING,
  ls_columns_string STRING,
  ls_sql            STRING,
  ls_columns_queue  STRING,
  lo_dzej007        DYNAMIC ARRAY OF LIKE DZEJ_T.DZEJ007
DEFINE
  ls_return STRING   

  LET ls_columns = p_columns

  LET ls_columns_queue  = "" 
  LET ls_columns_string = "'" 
  
  IF (ls_columns == cs_alias_erp_db OR  ls_columns == cs_alias_aws_db) THEN
    LET ls_columns = IIF ((p_columns == cs_alias_erp_db), 
                          "ERPDB" , 
                          "MDMDB")
    LET li_index = 1 
    #取得確實要執行的 schema name
    LET ls_sql = "SELECT EJ.DZEJ007 FROM DZEJ_T EJ         ", 
                 " WHERE EJ.DZEJ001 = 'adzi180_parameters' ",
                 "   AND EJ.DZEJ004 = '",ls_columns,"'     "
    PREPARE lpre_decode_columns FROM ls_sql
    DECLARE lcur_decode_columns CURSOR FOR lpre_decode_columns
    OPEN lcur_decode_columns
    FOREACH lcur_decode_columns INTO lo_dzej007[li_index]
      IF SQLCA.sqlcode THEN
        EXIT FOREACH
      END IF
      LET ls_columns_string = "'", lo_dzej007[li_index], "'"
      LET li_index = li_index + 1
      LET ls_columns_queue = ls_columns_queue,ls_columns_string,","
    END FOREACH
    CALL lo_dzej007.deleteElement(li_index) 
    CLOSE lcur_decode_columns
    FREE lcur_decode_columns
    FREE lpre_decode_columns
  ELSE 
    FOR li_index = 1 TO ls_columns.getLength()
      LET ls_column_char = NVL(ls_columns.subString(li_index,li_index),cs_null_value) 
      IF ls_column_char MATCHES "," THEN
        LET ls_columns_string = ls_columns_string,"'"
        LET ls_columns_queue  = ls_columns_queue,ls_columns_string,","
        LET ls_columns_string = "'"
      ELSE
        LET ls_columns_string = ls_columns_string,ls_column_char 
      END IF    
    END FOR

    #最後一組或僅有一組要加入Queue
    LET ls_columns_string = ls_columns_string,"'"
    LET ls_columns_queue  = ls_columns_queue,ls_columns_string,","
    LET ls_columns_string = "'"
  END IF 
  
  LET ls_return = ls_columns_queue.subString(1,ls_columns_queue.getLength()-1)
  
  RETURN ls_return
  
END FUNCTION