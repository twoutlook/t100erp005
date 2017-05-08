#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 13/01/17
#
#+ 程式代碼......: sadzp190_tbls
#+ 設計人員......: 
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp190_tbls.4gl
# Description    : SQL BUILDER 開窗
# Memo           :

IMPORT OS

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

TYPE T_OBJECT_LIST RECORD 
   OBJECT_NAME   VARCHAR(30),
   OBJECT_DESC   VARCHAR(100) 
   END RECORD

TYPE T_OBJECT_LIST2 RECORD
   ALIAS         VARCHAR(30),
   OBJECT_NAME   VARCHAR(30),
   OBJECT_DESC   VARCHAR(100) 
   END RECORD

DEFINE m_left_columns_list  DYNAMIC ARRAY OF T_OBJECT_LIST 
DEFINE m_right_columns_list DYNAMIC ARRAY OF T_OBJECT_LIST

DEFINE m_left_columns_list2  DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE m_right_columns_list2 DYNAMIC ARRAY OF T_OBJECT_LIST2

CONSTANT cs_left  STRING = "sr_left"
CONSTANT cs_right STRING = "sr_right"

 
FUNCTION sadzp190_tbls_run(p_left_array,p_right_array)
DEFINE p_left_array  DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE p_right_array DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE ls_columns    DYNAMIC ARRAY OF T_OBJECT_LIST
  
  CALL sadzp190_tbls_initial_form()
  CALL sadzp190_tbls_start(p_left_array,p_right_array) RETURNING ls_columns 
  CALL sadzp190_tbls_finalize()

  RETURN ls_columns
  
END FUNCTION 
  
FUNCTION sadzp190_tbls_initial_form()
  OPTIONS INPUT WRAP

  OPEN WINDOW w_sadzp190_tbls WITH FORM cl_ap_formpath("ADZ","adzp190_tbls")
  
  CURRENT WINDOW IS w_sadzp190_tbls
  
END FUNCTION 

FUNCTION sadzp190_tbls_start(p_left_array,p_right_array)
DEFINE p_left_array   DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE p_right_array  DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE drag_index     LIKE type_t.num5
DEFINE drop_index     LIKE type_t.num5
DEFINE drag_source    STRING
DEFINE drag_value     T_OBJECT_LIST
DEFINE lo_left_array  DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE lo_right_array DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE ls_columns     DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE lo_dnd         ui.DragDrop
DEFINE ls_return      DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE l_i            LIKE type_t.num5   

  LET lo_left_array.*  = p_left_array.*
  LET lo_right_array.* = p_right_array.*

  LET ls_columns = ""
  
  DIALOG ATTRIBUTE(UNBUFFERED)
    DISPLAY ARRAY m_left_columns_list TO sr_left.*
      BEFORE ROW 
        CALL sadzp190_tbls_reload(DIALOG)
        
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
        #只能單選
        {IF drag_source = cs_left THEN
          CALL lo_dnd.dropInternal()
        ELSE
          LET drop_index = lo_dnd.getLocationRow()
          CALL DIALOG.insertRow(cs_left, drop_index)
          CALL DIALOG.setCurrentRow(cs_left, drop_index)
          LET m_left_columns_list[drop_index].* = drag_value.*
          CALL DIALOG.deleteRow(cs_right, drag_index)
        END IF}
        #多選
        IF drag_source = cs_left THEN
           CALL lo_dnd.dropInternal()
        ELSE
           LET drop_index = lo_dnd.getLocationRow()
           IF drop_index > m_left_columns_list.getLength() THEN
              LET drop_index = m_left_columns_list.getLength()
           END IF 
           FOR l_i=m_right_columns_list.getLength() TO 1 STEP -1
              IF DIALOG.isRowSelected(cs_right,l_i) THEN
                 #CALL DIALOG.insertRow( cs_left,drop_index)
                 #CALL DIALOG.setSelectionRange( cs_left,drop_index,drop_index,TRUE)
                 #LET m_left_columns_list[drop_index].* = m_right_columns_list[l_i].*
                 CALL DIALOG.deleteRow(cs_right,l_i)
              END IF
           END FOR
        END IF 
    END DISPLAY
    
    DISPLAY ARRAY m_right_columns_list TO sr_right.*
      BEFORE ROW 
        CALL sadzp190_tbls_reload(DIALOG)
      
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
        #只能單選
        {IF drag_source = cs_right THEN
          CALL lo_dnd.dropInternal()
        ELSE
          LET drop_index = lo_dnd.getLocationRow()
          CALL DIALOG.insertRow(cs_right, drop_index)
          CALL DIALOG.setCurrentRow(cs_right, drop_index)
          LET m_right_columns_list[drop_index].* = drag_value.*
          CALL DIALOG.deleteRow(cs_left, drag_index)
        END IF}
        #多選
        IF drag_source = cs_right THEN
           CALL lo_dnd.dropInternal()
        ELSE
           LET drop_index = lo_dnd.getLocationRow()
           IF drop_index > m_right_columns_list.getLength() THEN
              LET drop_index = m_right_columns_list.getLength()
           END IF 
           FOR l_i=m_left_columns_list.getLength() TO 1 STEP -1
              IF DIALOG.isRowSelected(cs_left,l_i) THEN
                 CALL DIALOG.insertRow(cs_right,drop_index)
                 CALL DIALOG.setSelectionRange(cs_right,drop_index,drop_index,TRUE)
                 LET m_right_columns_list[drop_index].* = m_left_columns_list[l_i].*
                 #CALL DIALOG.deleteRow(cs_left,l_i)
              END IF
           END FOR
        END IF 
    END DISPLAY

    BEFORE DIALOG
      CALL DIALOG.setSelectionMode(cs_left,1)
      CALL DIALOG.setSelectionMode(cs_right,1)
      CALL DIALOG.setActionHidden("close",TRUE)
      CALL sadzi190_diff_fill_left_columns_list(lo_left_array)
      CALL sadzi190_diff_fill_right_columns_list(lo_right_array)
      CALL sadzp190_tbls_reload(DIALOG)
    
    ON ACTION right_move CALL sadzp190_tbls_move_to_left_or_right(DIALOG,cs_left,cs_right)
    ON ACTION left_move  CALL sadzp190_tbls_move_to_left_or_right(DIALOG,cs_right,cs_left)
    ON ACTION left_up    CALL sadzp190_tbls_move_up_or_down(DIALOG,cs_left,TRUE)
    ON ACTION left_down  CALL sadzp190_tbls_move_up_or_down(DIALOG,cs_left,FALSE)
    ON ACTION right_up   CALL sadzp190_tbls_move_up_or_down(DIALOG,cs_right,TRUE)
    ON ACTION right_down CALL sadzp190_tbls_move_up_or_down(DIALOG,cs_right,FALSE)
    
    ON ACTION btn_ok 
      LET ls_columns.* = m_right_columns_list.*
      EXIT DIALOG
      
    ON ACTION btn_cancel 
      LET ls_columns.* = p_right_array.*
      EXIT DIALOG
      
    ON ACTION CLOSE
      EXIT DIALOG
  
  END DIALOG

  LET ls_return.* = ls_columns.*

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp190_tbls_finalize()
  CLOSE WINDOW w_sadzp190_tbls
END FUNCTION

FUNCTION sadzp190_tbls_reload(p_dialog)
DEFINE p_dialog ui.Dialog
  
  CALL p_dialog.setActionActive("right_move", m_left_columns_list.getLength()  > 0)
  CALL p_dialog.setActionActive("left_move" , m_right_columns_list.getLength() > 0)
  CALL p_dialog.setActionActive("left_up"   , p_dialog.getCurrentRow(cs_left)  > 1)
  CALL p_dialog.setActionActive("left_down" , p_dialog.getCurrentRow(cs_left)  < m_left_columns_list.getLength())
  CALL p_dialog.setActionActive("right_up"  , p_dialog.getCurrentRow(cs_right) > 1)
  CALL p_dialog.setActionActive("right_down", p_dialog.getCurrentRow(cs_right) < m_right_columns_list.getLength())
  
END FUNCTION

FUNCTION sadzp190_tbls_get_value(p_list_name,p_index)
DEFINE p_list_name STRING
DEFINE p_index     INT
  
  IF p_list_name = cs_left THEN
    RETURN m_left_columns_list[p_index].*
  ELSE
    RETURN m_right_columns_list[p_index].* 
  END IF
  
END FUNCTION

FUNCTION sadzp190_tbls_set_value(p_list_name,p_index,p_value)
DEFINE p_list_name STRING
DEFINE p_index     LIKE type_t.num5
DEFINE p_value     T_OBJECT_LIST
  
  IF p_list_name = cs_left THEN 
    LET m_left_columns_list[p_index].* = p_value.*
  ELSE
    LET m_right_columns_list[p_index].* = p_value.* 
  END IF
  
END FUNCTION

-- Remove the current item from the source side and move it the destination side
FUNCTION sadzp190_tbls_move_to_left_or_right(p_dialog,p_source,p_dest)
DEFINE p_dialog    ui.Dialog
DEFINE p_source    STRING
DEFINE p_dest      STRING
DEFINE ls_source   STRING
DEFINE ls_dest     STRING
DEFINE li_idx_dest LIKE type_t.num5
DEFINE l_i         LIKE type_t.num5
  
  LET ls_source = p_source 
  LET ls_dest   = p_dest 
  
  #LET li_idx_src  = p_dialog.getCurrentRow(ls_source)
  LET li_idx_dest = p_dialog.getCurrentRow(ls_dest)
  IF li_idx_dest < 1 THEN LET li_idx_dest = 1 END IF 
  #多選
  IF ls_source = cs_right THEN 
     #LET drop_index = lo_dnd.getLocationRow()
     FOR l_i=m_right_columns_list.getLength() TO 1 STEP -1
        IF p_dialog.isRowSelected(cs_right,l_i) THEN
           #CALL DIALOG.insertRow( cs_left,drop_index)
           #CALL DIALOG.setSelectionRange( cs_left,drop_index,drop_index,TRUE)
           #LET m_left_columns_list[drop_index].* = m_right_columns_list[l_i].*
           CALL p_dialog.deleteRow(cs_right,l_i)
        END IF
     END FOR
  ELSE
     LET li_idx_dest = p_dialog.getArrayLength(ls_dest)
     IF NOT cl_null(m_right_columns_list[li_idx_dest].OBJECT_NAME) THEN
        LET li_idx_dest = li_idx_dest + 1
     END IF 
     #FOR l_i=m_left_columns_list.getLength() TO 1 STEP -1
     FOR l_i= 1 TO m_left_columns_list.getLength()
        IF p_dialog.isRowSelected(cs_left,l_i) THEN
           CALL p_dialog.appendRow(cs_right)
           #CALL p_dialog.insertRow(cs_right,li_idx_dest)
           CALL p_dialog.setSelectionRange(cs_right,li_idx_dest,li_idx_dest,TRUE)
           LET m_right_columns_list[li_idx_dest].* = m_left_columns_list[l_i].*
           LET li_idx_dest = li_idx_dest + 1
           #CALL DIALOG.deleteRow(cs_left,l_i)
        END IF
     END FOR
  END IF 
  #只能單選
  {LET li_idx_dest = IIF(li_idx_dest == 0,1,li_idx_dest)
  IF ls_dest = cs_right THEN 
  CALL p_dialog.InsertRow(ls_dest,li_idx_dest)
  END IF 
  CALL sadzp190_tbls_get_value(ls_source,li_idx_src) RETURNING lo_col_list.*
  
  CALL sadzp190_tbls_set_value(ls_dest,li_idx_dest,lo_col_list.*)
  IF ls_source = cs_right THEN
  CALL p_dialog.deleteRow(ls_source,li_idx_src)
  END IF 
  CALL p_dialog.setCurrentRow(ls_dest,li_idx_dest)
  CALL sadzp190_tbls_reload(p_dialog)
  }
END FUNCTION

-- Move the current item at the given side 1 row up or down
FUNCTION sadzp190_tbls_move_up_or_down(p_dialog,p_side,p_up)
DEFINE p_dialog          ui.Dialog
DEFINE p_side            STRING
DEFINE p_up              LIKE type_t.num5
DEFINE li_idx            LIKE type_t.num5
DEFINE li_step           LIKE type_t.num5
DEFINE lo_col_list_step  T_OBJECT_LIST
DEFINE lo_col_list       T_OBJECT_LIST
  
  IF p_up THEN
    LET li_step = -1
  ELSE
    LET li_step = 1
  END IF
  
  LET li_idx = p_dialog.getCurrentRow(p_side)

  CALL sadzp190_tbls_get_value(p_side,li_idx) RETURNING lo_col_list.*
  CALL sadzp190_tbls_get_value(p_side,li_idx + li_step) RETURNING lo_col_list_step.*
  
  CALL sadzp190_tbls_set_value(p_side,li_idx + li_step,lo_col_list.*)
  CALL sadzp190_tbls_set_value(p_side,li_idx,lo_col_list_step.*)
  
  CALL p_dialog.setCurrentRow(p_side,li_idx + li_step)
  CALL sadzp190_tbls_reload(p_dialog)
  
END FUNCTION

FUNCTION sadzi190_diff_fill_left_columns_list(p_array)
DEFINE p_array   DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE lo_array  DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE li_index  INTEGER

  LET lo_array.* = p_array.*

  CALL m_left_columns_list.Clear();

  FOR li_index = 1 TO lo_array.getLength()
    LET m_left_columns_list[li_index].OBJECT_NAME = lo_array[li_index].OBJECT_NAME
    LET m_left_columns_list[li_index].OBJECT_DESC = lo_array[li_index].OBJECT_DESC
  END FOR 

END FUNCTION

FUNCTION sadzi190_diff_fill_right_columns_list(p_array)
DEFINE p_array   DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE lo_array  DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE li_index  LIKE type_t.num5

  LET lo_array.* = p_array.*

  CALL m_right_columns_list.Clear();

  FOR li_index = 1 TO lo_array.getLength()
    LET m_right_columns_list[li_index].OBJECT_NAME = lo_array[li_index].OBJECT_NAME
    LET m_right_columns_list[li_index].OBJECT_DESC = lo_array[li_index].OBJECT_DESC
  END FOR 

END FUNCTION

FUNCTION sadzp190_tbls_run2(p_left_array,p_right_array)
DEFINE p_left_array  DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE p_right_array DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE ls_columns    DYNAMIC ARRAY OF T_OBJECT_LIST2
  
  CALL sadzp190_tbls_initial_form2()
  CALL sadzp190_tbls_start2(p_left_array,p_right_array) RETURNING ls_columns 
  CLOSE WINDOW w_sadzp190_tbls2

  RETURN ls_columns
  
END FUNCTION 

FUNCTION sadzp190_tbls_initial_form2()
  OPTIONS INPUT WRAP

  OPEN WINDOW w_sadzp190_tbls2 WITH FORM cl_ap_formpath("ADZ","adzp190_tbls2")
  
  CURRENT WINDOW IS w_sadzp190_tbls2
  
END FUNCTION 

FUNCTION sadzp190_tbls_start2(p_left_array,p_right_array)
DEFINE p_left_array   DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE p_right_array  DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE drag_index     LIKE type_t.num5 
DEFINE drop_index     LIKE type_t.num5
DEFINE drag_source    STRING
DEFINE drag_value     T_OBJECT_LIST2
DEFINE lo_left_array  DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE lo_right_array DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE lo_dnd         ui.DragDrop
DEFINE ls_return      DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE l_i            LIKE type_t.num5   

  LET lo_left_array.*  = p_left_array.*
  LET lo_right_array.* = p_right_array.*
  
  DIALOG ATTRIBUTE(UNBUFFERED)
    DISPLAY ARRAY m_left_columns_list2 TO sr_left.*
      BEFORE ROW 
        CALL sadzp190_tbls_reload2(DIALOG)
        
      ON DRAG_START(lo_dnd)
        LET drag_source = cs_left
        LET drag_index = arr_curr()
        LET drag_value.* = m_left_columns_list2[drag_index].*

      ON DRAG_FINISHED(lo_dnd)
        INITIALIZE drag_source TO NULL

      ON DRAG_ENTER(lo_dnd)
        IF drag_source IS NULL THEN
          CALL lo_dnd.setOperation(NULL)
        END IF
        
      ON DROP (lo_dnd)
        #只能單選
        {IF drag_source = cs_left THEN
          CALL lo_dnd.dropInternal()
        ELSE
          LET drop_index = lo_dnd.getLocationRow()
          CALL DIALOG.insertRow(cs_left, drop_index)
          CALL DIALOG.setCurrentRow(cs_left, drop_index)
          LET m_left_columns_list[drop_index].* = drag_value.*
          CALL DIALOG.deleteRow(cs_right, drag_index)
        END IF}
        #多選
        IF drag_source = cs_left THEN
           CALL lo_dnd.dropInternal()
        ELSE
           LET drop_index = lo_dnd.getLocationRow()
           IF drop_index > m_left_columns_list2.getLength() THEN
              LET drop_index = m_left_columns_list2.getLength()
           END IF 
           FOR l_i=m_right_columns_list2.getLength() TO 1 STEP -1
              IF DIALOG.isRowSelected(cs_right,l_i) THEN
                 CALL DIALOG.insertRow( cs_left,drop_index)
                 CALL DIALOG.setSelectionRange( cs_left,drop_index,drop_index,TRUE)
                 LET m_left_columns_list2[drop_index].* = m_right_columns_list2[l_i].*
                 CALL DIALOG.deleteRow(cs_right,l_i)
              END IF
           END FOR
        END IF 
    END DISPLAY
    
    DISPLAY ARRAY m_right_columns_list2 TO sr_right.*
      BEFORE ROW 
        CALL sadzp190_tbls_reload(DIALOG)
      
      ON DRAG_START(lo_dnd)
        LET drag_source = cs_right
        LET drag_index = arr_curr()
        LET drag_value.* = m_right_columns_list2[drag_index].*
        
      ON DRAG_FINISHED(lo_dnd)
        INITIALIZE drag_source TO NULL

      ON DRAG_ENTER(lo_dnd)
        IF drag_source IS NULL THEN
          CALL lo_dnd.setOperation(NULL)
        END IF
        
      ON DROP(lo_dnd)
        #只能單選
        {IF drag_source = cs_right THEN
          CALL lo_dnd.dropInternal()
        ELSE
          LET drop_index = lo_dnd.getLocationRow()
          CALL DIALOG.insertRow(cs_right, drop_index)
          CALL DIALOG.setCurrentRow(cs_right, drop_index)
          LET m_right_columns_list[drop_index].* = drag_value.*
          CALL DIALOG.deleteRow(cs_left, drag_index)
        END IF}
        #多選
        IF drag_source = cs_right THEN
           CALL lo_dnd.dropInternal()
        ELSE
           LET drop_index = lo_dnd.getLocationRow()
           IF drop_index > m_right_columns_list2.getLength() THEN
              LET drop_index = m_right_columns_list2.getLength()
           END IF 
           FOR l_i=m_left_columns_list2.getLength() TO 1 STEP -1
              IF DIALOG.isRowSelected(cs_left,l_i) THEN
                 CALL DIALOG.insertRow(cs_right,drop_index)
                 CALL DIALOG.setSelectionRange(cs_right,drop_index,drop_index,TRUE)
                 LET m_right_columns_list2[drop_index].* = m_left_columns_list2[l_i].*
                 CALL DIALOG.deleteRow(cs_left,l_i)
              END IF
           END FOR
        END IF 
    END DISPLAY

    BEFORE DIALOG
      CALL DIALOG.setSelectionMode(cs_left,1)
      CALL DIALOG.setSelectionMode(cs_right,1)
      CALL DIALOG.setActionHidden("close",TRUE)
      CALL sadzi190_diff_fill_left_columns_list2(lo_left_array)
      CALL sadzi190_diff_fill_right_columns_list2(lo_right_array)
      CALL sadzp190_tbls_reload2(DIALOG)
    
    ON ACTION right_move CALL sadzp190_tbls_move_to_left_or_right2(DIALOG,cs_left,cs_right)
    ON ACTION left_move  CALL sadzp190_tbls_move_to_left_or_right2(DIALOG,cs_right,cs_left)
    ON ACTION left_up    CALL sadzp190_tbls_move_up_or_down2(DIALOG,cs_left,TRUE)
    ON ACTION left_down  CALL sadzp190_tbls_move_up_or_down2(DIALOG,cs_left,FALSE)
    ON ACTION right_up   CALL sadzp190_tbls_move_up_or_down2(DIALOG,cs_right,TRUE)
    ON ACTION right_down CALL sadzp190_tbls_move_up_or_down2(DIALOG,cs_right,FALSE)
    
    ON ACTION btn_ok 
      LET ls_return.* = m_right_columns_list2.*
      EXIT DIALOG
      
    ON ACTION btn_cancel 
      LET ls_return.* = p_right_array.*
      EXIT DIALOG
      
    ON ACTION CLOSE
      EXIT DIALOG
  
  END DIALOG

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp190_tbls_reload2(p_dialog)
DEFINE p_dialog   ui.Dialog
  
  CALL p_dialog.setActionActive("right_move", m_left_columns_list2.getLength()  > 0)
  CALL p_dialog.setActionActive("left_move" , m_right_columns_list2.getLength() > 0)
  CALL p_dialog.setActionActive("left_up"   , p_dialog.getCurrentRow(cs_left)  > 1)
  CALL p_dialog.setActionActive("left_down" , p_dialog.getCurrentRow(cs_left)  < m_left_columns_list2.getLength())
  CALL p_dialog.setActionActive("right_up"  , p_dialog.getCurrentRow(cs_right) > 1)
  CALL p_dialog.setActionActive("right_down", p_dialog.getCurrentRow(cs_right) < m_right_columns_list2.getLength())
  
END FUNCTION

-- Remove the current item from the source side and move it the destination side
FUNCTION sadzp190_tbls_move_to_left_or_right2(p_dialog,p_source,p_dest)
DEFINE p_dialog    ui.Dialog
DEFINE p_source    STRING
DEFINE p_dest      STRING
DEFINE ls_source   STRING
DEFINE ls_dest     STRING
DEFINE li_idx_src  LIKE type_t.num5 
DEFINE li_idx_dest LIKE type_t.num5 
DEFINE l_i         LIKE type_t.num5
  
  LET ls_source = p_source 
  LET ls_dest   = p_dest 
  
  LET li_idx_src  = p_dialog.getCurrentRow(ls_source)
  LET li_idx_dest = p_dialog.getCurrentRow(ls_dest)
  #IF li_idx_dest < 1 THEN LET li_idx_dest = 1 END IF 
  #多選
  IF ls_source = cs_right THEN 
     #LET drop_index = lo_dnd.getLocationRow()
     FOR l_i=m_right_columns_list2.getLength() TO 1 STEP -1
        IF p_dialog.isRowSelected(cs_right,l_i) THEN
           CALL p_dialog.insertRow(cs_left,li_idx_dest)
           CALL p_dialog.setSelectionRange( cs_left,li_idx_dest,li_idx_dest,TRUE)
           LET m_left_columns_list2[li_idx_dest].* = m_right_columns_list2[l_i].*
           CALL p_dialog.deleteRow(cs_right,l_i)
        END IF
     END FOR
  ELSE
     LET li_idx_dest = p_dialog.getArrayLength(ls_dest)
     IF NOT cl_null(m_right_columns_list2[li_idx_dest].OBJECT_NAME) THEN
        LET li_idx_dest = li_idx_dest + 1
     END IF
     #FOR l_i=m_left_columns_list2.getLength() TO 1 STEP -1
     FOR l_i= 1 TO m_left_columns_list2.getLength()
        IF p_dialog.isRowSelected(cs_left,l_i) THEN
           CALL p_dialog.appendRow(cs_right)
           #CALL p_dialog.insertRow(cs_right,li_idx_dest)
           CALL p_dialog.setSelectionRange(cs_right,li_idx_dest,li_idx_dest,TRUE)
           LET m_right_columns_list2[li_idx_dest].* = m_left_columns_list2[l_i].*
           LET li_idx_dest = li_idx_dest + 1
           #CALL p_dialog.deleteRow(cs_left,l_i)
        END IF
     END FOR
     FOR l_i=m_left_columns_list2.getLength() TO 1 STEP -1
        IF p_dialog.isRowSelected(cs_left,l_i) THEN
           CALL p_dialog.deleteRow(cs_left,l_i)
        END IF 
     END FOR
  END IF 
  #只能單選
  {LET li_idx_dest = IIF(li_idx_dest == 0,1,li_idx_dest)
  IF ls_dest = cs_right THEN 
  CALL p_dialog.InsertRow(ls_dest,li_idx_dest)
  END IF 
  CALL sadzp190_tbls_get_value(ls_source,li_idx_src) RETURNING lo_col_list.*
  
  CALL sadzp190_tbls_set_value(ls_dest,li_idx_dest,lo_col_list.*)
  IF ls_source = cs_right THEN
  CALL p_dialog.deleteRow(ls_source,li_idx_src)
  END IF 
  CALL p_dialog.setCurrentRow(ls_dest,li_idx_dest)
  CALL sadzp190_tbls_reload(p_dialog)
  }
END FUNCTION

-- Move the current item at the given side 1 row up or down
FUNCTION sadzp190_tbls_move_up_or_down2(p_dialog,p_side,p_up)
DEFINE p_dialog          ui.Dialog
DEFINE p_side            STRING
DEFINE p_up              LIKE type_t.num5
DEFINE li_idx            LIKE type_t.num5
DEFINE li_step           LIKE type_t.num5
DEFINE lo_col_list_step  T_OBJECT_LIST2
DEFINE lo_col_list       T_OBJECT_LIST2
  
  IF p_up THEN
    LET li_step = -1
  ELSE
    LET li_step = 1
  END IF
  
  LET li_idx = p_dialog.getCurrentRow(p_side)

  CALL sadzp190_tbls_get_value2(p_side,li_idx) RETURNING lo_col_list.*
  CALL sadzp190_tbls_get_value2(p_side,li_idx + li_step) RETURNING lo_col_list_step.*
  
  CALL sadzp190_tbls_set_value2(p_side,li_idx + li_step,lo_col_list.*)
  CALL sadzp190_tbls_set_value2(p_side,li_idx,lo_col_list_step.*)
  
  CALL p_dialog.setCurrentRow(p_side,li_idx + li_step)
  CALL sadzp190_tbls_reload(p_dialog)
  
END FUNCTION

FUNCTION sadzp190_tbls_get_value2(p_list_name,p_index)
DEFINE p_list_name   STRING
DEFINE p_index       LIKE type_t.num5
  
  IF p_list_name = cs_left THEN
    RETURN m_left_columns_list2[p_index].*
  ELSE
    RETURN m_right_columns_list2[p_index].* 
  END IF
  
END FUNCTION

FUNCTION sadzp190_tbls_set_value2(p_list_name,p_index,p_value)
DEFINE p_list_name   STRING
DEFINE p_index       LIKE type_t.num5
DEFINE p_value       T_OBJECT_LIST2
  
  IF p_list_name = cs_left THEN 
    LET m_left_columns_list2[p_index].* = p_value.*
  ELSE
    LET m_right_columns_list2[p_index].* = p_value.* 
  END IF
  
END FUNCTION


FUNCTION sadzi190_diff_fill_left_columns_list2(p_array)
DEFINE p_array   DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE lo_array  DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE li_index  LIKE type_t.num5

  LET lo_array.* = p_array.*

  CALL m_left_columns_list2.Clear();

  FOR li_index = 1 TO lo_array.getLength()
    LET m_left_columns_list2[li_index].ALIAS = lo_array[li_index].ALIAS
    LET m_left_columns_list2[li_index].OBJECT_NAME = lo_array[li_index].OBJECT_NAME
    LET m_left_columns_list2[li_index].OBJECT_DESC = lo_array[li_index].OBJECT_DESC
  END FOR 

END FUNCTION

FUNCTION sadzi190_diff_fill_right_columns_list2(p_array)
DEFINE p_array   DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE lo_array  DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE li_index  LIKE type_t.num5

  LET lo_array.* = p_array.*

  CALL m_right_columns_list2.Clear();

  FOR li_index = 1 TO lo_array.getLength()
    LET m_right_columns_list2[li_index].ALIAS=lo_array[li_index].ALIAS
    LET m_right_columns_list2[li_index].OBJECT_NAME = lo_array[li_index].OBJECT_NAME
    LET m_right_columns_list2[li_index].OBJECT_DESC = lo_array[li_index].OBJECT_DESC
  END FOR 

END FUNCTION




