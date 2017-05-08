&include "../4gl/sadzi180_mcr.inc"
IMPORT OS
IMPORT util

SCHEMA ds
&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi180_cnst.inc"

CONSTANT cs_left  STRING = "sr_left"
CONSTANT cs_right STRING = "sr_right"

&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi180_type.inc"

GLOBALS "../../cfg/top_global.inc"  #DGW07558_add
DEFINE m_left_columns_list  DYNAMIC ARRAY OF T_INTF_COLUMN_LIST
DEFINE m_right_columns_list DYNAMIC ARRAY OF T_INTF_COLUMN_LIST
DEFINE m_r_col_lst_idx INTEGER #DGW07558_add at20151109
DEFINE m_r_pre_del_colLst DYNAMIC ARRAY OF T_INTF_COLUMN_LIST  #DGW07558_add at20151102
DEFINE m_r_pre_ins_colLst DYNAMIC ARRAY OF T_INTF_COLUMN_LIST  #DGW07558_add at20151102


DEFINE m_mdm_schema_list DYNAMIC ARRAY OF T_SCHEMA_LIST

DEFINE m_dzia_t T_DZIA_T

DEFINE m_mdf_dzia_t T_DZIA_T
DEFINE m_mdf_dzib_t DYNAMIC ARRAY OF T_DZIB_T
DEFINE m_edit_type  STRING

DEFINE ms_lang  STRING
DEFINE ms_dgenv STRING  #目前作業環境
DEFINE mb_return BOOLEAN


{#######################################
@func  sadzi180_ictb_run
@desc  編輯視窗開始Function
@para  p_dzia_t : dzia_t 設計資料
@para  p_dzib_t : dzib_t 設計資料
@para  p_edit_type : 編輯模式
                   , if equle cs_mdf_type_new 表示新增表格
                   , if cs_mdf_type_modify  表示修改表格
@return  mb_return : 新增修改是否成功
@return  m_dzia_t : dzia_t 設計資料
@return  m_right_columns_list : dzia_t 設計資料
@return  m_mdm_schema_list  : 預建構 schema 資料
@return  m_r_pre_del_colLst : dzib_t 設計資料刪除項目
@author   
@modify  
########################################}
FUNCTION sadzi180_ictb_run(p_dzia_t,p_dzib_t,p_edit_type)
DEFINE
  p_dzia_t    T_DZIA_T,
  p_dzib_t    DYNAMIC ARRAY OF T_DZIB_T,
  p_edit_type STRING

  CALL sadzi180_ictb_initialize(p_dzia_t.*,p_dzib_t,p_edit_type)
  CALL sadzi180_ictb_initial_form()
  CALL sadzi180_ictb_start()
  CALL sadzi180_ictb_finalize()

  #因為修改模式需求，多回傳一個參數'm_r_pre_del_colLst'，內容有關於刪除項目 ~DGW07558_add_at20151103
  RETURN mb_return,m_dzia_t.*,m_right_columns_list,m_mdm_schema_list,m_r_pre_del_colLst

END FUNCTION 
  
FUNCTION sadzi180_ictb_initialize(p_dzia_t,p_dzib_t,p_edit_type)
DEFINE
  p_dzia_t    T_DZIA_T,
  p_dzib_t    DYNAMIC ARRAY OF T_DZIB_T,
  p_edit_type STRING 
  
  LET m_edit_type = p_edit_type 

  LET mb_return = TRUE

  INITIALIZE m_left_columns_list  TO NULL
  INITIALIZE m_right_columns_list TO NULL
  INITIALIZE m_r_pre_del_colLst   TO NULL #修改模式需求，紀錄刪除的項目
  INITIALIZE m_r_pre_ins_colLst   TO NULL #修改模式需求，紀錄新增的項目

  &ifndef DEBUG
    LET ms_lang = g_lang
    CALL FGL_GETENV("DGENV") RETURNING ms_dgenv
  &else
    LET ms_lang = cs_default_lang
  &endif
  
  IF ms_dgenv IS NULL THEN LET ms_dgenv = cs_dgenv_stand END IF

  IF p_dzia_t.DZIA001 IS NULL THEN 
    INITIALIZE m_dzia_t TO NULL
  ELSE
    LET m_mdf_dzia_t.* = p_dzia_t.*
    LET m_mdf_dzib_t   = p_dzib_t
  END IF  

  # 修改模式下 
  IF m_edit_type = cs_mdf_type_modify THEN
     LET m_dzia_t.* = p_dzia_t.*
  END IF
  
END FUNCTION

FUNCTION sadzi180_ictb_initial_form()

  OPTIONS INPUT WRAP

  &ifndef DEBUG
    OPEN WINDOW w_sadzi180_ictb WITH FORM cl_ap_formpath("ADZ","sadzi180_ictb")
    #CONNECT TO cs_master_db
  &else
    OPEN WINDOW w_sadzi180_ictb WITH FORM sadzi180_util_get_form_path("sadzi180_ictb")
    #CONNECT TO "local"
  &endif
  
  CURRENT WINDOW IS w_sadzi180_ictb

  CALL sadzi180_ictb_set_window_title(m_edit_type)
  
END FUNCTION 


FUNCTION sadzi180_ictb_start()
DEFINE 
  drag_index, drop_index, i INTEGER,
  drag_source STRING,
  drag_value  T_INTF_COLUMN_LIST
DEFINE 
  lo_left_array   DYNAMIC ARRAY OF T_INTF_COLUMN_LIST,
  lo_right_array  DYNAMIC ARRAY OF T_INTF_COLUMN_LIST,
  lo_dnd          ui.DragDrop,
  lc_msg          VARCHAR(1024),
  lc_lang         VARCHAR (6),
  li_index        INTEGER,
  li_column_count INTEGER, 
  li_idx_del      INTEGER, 
  lb_idx          BOOLEAN,
  ls_columns      STRING,
  ls_pick_table   STRING,
  ls_answer       STRING,
  ls_replace_arg  STRING
  
DEFINE
  ls_return STRING   
  
  LET ls_columns = ""
  LET m_r_col_lst_idx = 0
  LET lc_lang   = ms_lang

  CALL sadzi180_ictb_fill_mdm_schema_list()
  
  DIALOG ATTRIBUTE(UNBUFFERED)
    DISPLAY ARRAY m_left_columns_list TO sr_left.*
      BEFORE ROW 
        CALL sadzi180_ictb_reload(DIALOG)
        
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
          #修改模式下，跳出視窗提醒'是否要刪除欄位' --DGW07558_mod_20151112
          IF m_edit_type = cs_mdf_type_modify THEN
            #檢查已出貨欄位不能修改、刪除欄位  
            CALL sadzi180_ictb_chk_shipped(drag_value.COLUMN_NAME) RETURNING ls_answer
            IF (ls_answer IS NOT NULL) AND (ls_answer = "Y") THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = "adz-00798"  --已出貨設計資料[%1]，不能進行修改、刪除。
              IF ms_dgenv = cs_dgenv_cust THEN 
                LET g_errparam.code   = "adz-00799" --標準設計資料[%1]，不能進行修改、刪除。
              END IF
              LET g_errparam.extend = NULL
              LET g_errparam.popup  = TRUE  #訊息開窗顯示
              LET g_errparam.replace[1] = drag_value.COLUMN_NAME
              LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
              CALL cl_err()
              CONTINUE DIALOG 
            END IF 
            
            LET ls_replace_arg = ""
            CALL sadzp000_msg_question_box(NULL, "adz-00064", ls_replace_arg, 0) RETURNING ls_answer
            #LET ls_answer = sadzi190_msg_question_box("欄位刪除","dialog","是否要刪除欄位 ? ","question")
            IF ls_answer = cs_response_yes THEN 
              #確認要刪除欄位
              LET drop_index = lo_dnd.getLocationRow()
              CALL DIALOG.insertRow(cs_left, drop_index)
              CALL DIALOG.setCurrentRow(cs_left, drop_index)
              LET m_left_columns_list[drop_index].* = drag_value.*
              CALL DIALOG.deleteRow(cs_right, drag_index)
              
              LET lb_idx = FALSE 
              IF (m_r_pre_ins_colLst.getLength() > 0) THEN  #檢查是否此次的新增項目
                FOR i = 1 TO m_r_pre_ins_colLst.getLength()
                  IF m_r_pre_ins_colLst[i].COLUMN_NAME = drag_value.COLUMN_NAME THEN  
                    #從新增項目Array中移除該項目
                    Call m_r_pre_ins_colLst.deleteElement(i)
                    LET lb_idx = TRUE 
                    EXIT FOR
                  END IF
                END FOR 
              END IF 
              IF NOT lb_idx THEN # 修改模式下記錄刪除項目之後提供給資料庫刪除依據; --DGW07558_Add at20151102
                CALL m_r_pre_del_colLst.appendElement()
                LET li_idx_del = m_r_pre_del_colLst.getLength()  
                LET li_idx_del = IIF(li_idx_del == 0,1,li_idx_del)
                LET m_r_pre_del_colLst[li_idx_del].* = drag_value.*
              END IF
            END IF
          ELSE
            LET drop_index = lo_dnd.getLocationRow()
            CALL DIALOG.insertRow(cs_left, drop_index)
            CALL DIALOG.setCurrentRow(cs_left, drop_index)
            LET m_left_columns_list[drop_index].* = drag_value.*
            CALL DIALOG.deleteRow(cs_right, drag_index)
          END IF
        END IF
        
    END DISPLAY
    
    DISPLAY ARRAY m_right_columns_list TO sr_right.*
      BEFORE ROW 
        CALL sadzi180_ictb_reload(DIALOG)
        LET m_r_col_lst_idx =  DIALOG.getCurrentRow(cs_right)
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
        ELSE  #新增欄位
          LET drop_index = lo_dnd.getLocationRow()
          #檢查目地表欄位代號是否重複，重複則跳出警告視窗 --DGW07558_add 
          LET lb_idx = FALSE 
          IF m_right_columns_list.getLength() >  0 THEN 
            FOR i = 1 TO  m_right_columns_list.getLength()
              IF m_right_columns_list[i].COLUMN_NAME = drag_value.COLUMN_NAME THEN  
                LET ls_replace_arg = m_right_columns_list[i].COLUMN_NAME,"|"
                LET lb_idx = TRUE 
                EXIT FOR
              END IF
            END FOR
          END IF
          
          IF lb_idx THEN  #drag_value.COLUMN_NAME, adz-00182: %1不可設定重複的欄位
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = "adz-00182"
            LET g_errparam.extend = NULL
            LET g_errparam.popup  = TRUE  #訊息開窗顯示
            LET g_errparam.replace[1] = drag_value.COLUMN_NAME  
            LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
            CALL cl_err()
          ELSE
            IF m_edit_type = cs_mdf_type_modify THEN
              #修改模式下的新增項目append在最後面; --DGW07558_add
              LET lb_idx = FALSE 
              CALL DIALOG.appendRow(cs_right)
              LET drop_index = DIALOG.getArrayLength(cs_right)
              LET drop_index = IIF(drop_index == 0,1,drop_index)
              LET m_right_columns_list[drop_index].* = drag_value.*
              #檢查新增項目是否是原本刪除項目 --DGW07558_Add at20151102
              IF m_r_pre_del_colLst.getLength() >  0 THEN 
                FOR i = 1 TO  m_r_pre_del_colLst.getLength()
                  IF m_r_pre_del_colLst[i].COLUMN_NAME = drag_value.COLUMN_NAME THEN  
                    #從刪除項目Array中移除該項目
                    Call m_r_pre_del_colLst.deleteElement(i)
                    LET lb_idx = TRUE 
                    EXIT FOR
                  END IF
                END FOR
              END IF
              #是否本次新增項目
              IF NOT lb_idx THEN 
                CALL m_r_pre_ins_colLst.appendElement()
                LET li_idx_del = m_r_pre_ins_colLst.getLength()  
                LET li_idx_del = IIF(li_idx_del == 0,1,li_idx_del)
                LET m_r_pre_ins_colLst[li_idx_del].* = drag_value.*
              END IF 
            ELSE 
              CALL DIALOG.insertRow(cs_right, drop_index)
            END IF
            CALL DIALOG.setCurrentRow(cs_right, drop_index)
            CALL DIALOG.deleteRow(cs_left, drag_index)
          END IF
        END IF
        
    END DISPLAY

    INPUT m_dzia_t.dzia001 FROM ed_table_name  ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE INPUT 
        IF m_edit_type = cs_mdf_type_modify THEN
          #修改狀態下停用部分欄位修改功能
          NEXT FIELD NEXT
        END IF
    END INPUT
    
    INPUT m_dzia_t.dzia002 FROM ed_TableDescription  ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE INPUT 
        IF m_edit_type = cs_mdf_type_modify THEN
          #修改狀態下停用部分欄位修改功能
          NEXT FIELD NEXT
        END IF
    END INPUT

    INPUT ARRAY m_mdm_schema_list FROM sr_schema.*  ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE INPUT
        #修改狀態下停用部分欄位修改功能
        IF m_edit_type = cs_mdf_type_modify THEN
          NEXT FIELD ed_pick_table
        END IF
    END INPUT
    
    #輸入表格供挑選表格
    INPUT ls_pick_table FROM ed_pick_table ATTRIBUTE(WITHOUT DEFAULTS)
      AFTER FIELD ed_pick_table
        #GOTO _controlp #造成新增錯誤或者程式關閉，所以先mark掉 --DGW07558_mod_at201512291600
      
      ON ACTION controlp INFIELD ed_pick_table
        #跳出視窗提供使用者選擇表格  --DGW07558_need_add 要改寫不透過LIB跳窗
        {
        #&ifndef DEBUG
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'i'
          LET g_qryparam.reqry = FALSE
          LET g_qryparam.default1 = ls_pick_table
          CALL q_dzea001()    #呼叫開窗
          LET ls_pick_table = g_qryparam.return1
          DISPLAY ls_pick_table TO ed_pick_table
        #&endif
        }
        LABEL _controlp:
        CALL sadzi180_ictb_get_column_data(ls_pick_table) RETURNING lo_left_array
        CALL sadzi180_ictb_fill_left_columns_list(lo_left_array)
        #CALL sadzi180_ictb_fill_right_columns_list(lo_right_array)
        
    END INPUT
    
    BEFORE DIALOG
      
      CALL sadzi180_ictb_reload(DIALOG)
      CALL DIALOG.setSelectionMode("sr_left",TRUE)
      CALL DIALOG.setSelectionMode("sr_right",TRUE)
      IF m_edit_type = cs_mdf_type_modify THEN
        LET m_dzia_t.dzia001 = m_mdf_dzia_t.DZIA001
        LET m_dzia_t.dzia002 = m_mdf_dzia_t.DZIA002
        CALL sadzi180_ictb_get_column_data_from_array(m_mdf_dzib_t) RETURNING lo_right_array
        CALL sadzi180_ictb_fill_right_columns_list(lo_right_array) 
      END IF
    
    ON ACTION right_move CALL sadzi180_ictb_move_to_left_or_right(DIALOG,cs_left,cs_right)
    ON ACTION left_move  CALL sadzi180_ictb_move_to_left_or_right(DIALOG,cs_right,cs_left)
    ON ACTION left_up    CALL sadzi180_ictb_move_up_or_down(DIALOG,cs_left,TRUE)
    ON ACTION left_down  CALL sadzi180_ictb_move_up_or_down(DIALOG,cs_left,FALSE)
    ON ACTION right_up   CALL sadzi180_ictb_move_up_or_down(DIALOG,cs_right,TRUE)
    ON ACTION right_down CALL sadzi180_ictb_move_up_or_down(DIALOG,cs_right,FALSE)
    
    ON ACTION btn_ok 
      IF m_dzia_t.dzia001 IS NULL THEN 
        #lbl_table_name, adz-00767 "%1 不能为空值"
        INITIALIZE lc_msg TO NULL 
        SELECT gzzd005 
          INTO lc_msg 
          FROM gzzd_t 
         WHERE gzzd001 = 'sadzi180_ictb' 
           AND gzzd002 = lc_lang
           AND gzzd003 = 'lbl_table_name'
        IF (lc_msg IS NULL ) THEN LET lc_msg = "Table Name" END IF
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00767"
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.replace[1] = "", lc_msg  
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
        NEXT FIELD ed_table_name
        CONTINUE DIALOG
      END IF 
      
      IF m_dzia_t.dzia002 IS NULL THEN #表格說明未輸入
        #lbl_TableDesc, adz-00767 "%1 不能为空值"
        INITIALIZE lc_msg TO NULL 
        SELECT gzzd005 
          INTO lc_msg 
          FROM gzzd_t 
         WHERE gzzd001 = 'sadzi180_ictb' 
           AND gzzd002 = lc_lang
           AND gzzd003 = 'lbl_TableDesc'
        IF (lc_msg IS NULL ) THEN LET lc_msg = "Table Description" END IF
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00767"
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.replace[1] = "", lc_msg  
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
        NEXT FIELD ed_TableDescription
        CONTINUE DIALOG
      END IF 

      IF m_right_columns_list.getLength() = 0 THEN #目的表格欄位為空
        #lbl_dest_data, adz-00767 "%1 不能为空值"
        INITIALIZE lc_msg TO NULL 
        SELECT gzzd005 
          INTO lc_msg 
          FROM gzzd_t 
         WHERE gzzd001 = 'sadzi180_ictb' 
           AND gzzd002 = lc_lang
           AND gzzd003 = 'lbl_dest_data'
        IF (lc_msg IS NULL ) THEN LET lc_msg = "Objective table fieldn" END IF
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00767"
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.replace[1] = "", lc_msg  
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
        NEXT FIELD lbl_column_name_right
        CONTINUE DIALOG
      END IF  

      #修改表格模式下，再次確認是否修改表格內容  -DGW07558_mod_at20151112
      IF m_edit_type = cs_mdf_type_modify THEN
        LET ls_replace_arg = ""
        CALL sadzp000_msg_question_box(NULL, "adz-00729", ls_replace_arg, 0) RETURNING ls_answer
        #LET ls_answer = sadzi190_msg_question_box("表格修改","dialog","是否修改表格 ? ","question")
        IF ls_answer = cs_response_yes THEN
          EXIT DIALOG
        END IF
      ELSE 
        EXIT DIALOG
      END IF 
      

    ON ACTION btn_column_modify  
      #修改欄位名稱  --DGW07558_add at20151103
      LET m_r_col_lst_idx =  DIALOG.getCurrentRow(cs_right)
      LET lb_idx = FALSE 
      IF (m_edit_type = cs_mdf_type_new  AND m_right_columns_list.getLength() > 0) 
        OR (m_edit_type = cs_mdf_type_modify AND m_r_pre_ins_colLst.getLength() > 0) THEN 
        LET lb_idx = TRUE
      END IF  
      IF (lb_idx) THEN  
        CALL sadzi180_ictb_modify_column_name()
      ELSE
        LET ls_replace_arg = ""
        IF (m_edit_type = cs_mdf_type_modify) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00730" #只有本次新增欄位才能進行修改
          LET g_errparam.extend = NULL
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
          CALL cl_err()
        ELSE 
          #目的表格欄位為空
          #lbl_dest_data, adz-00767 "%1 不能为空值"
          INITIALIZE lc_msg TO NULL 
          SELECT gzzd005 
            INTO lc_msg 
            FROM gzzd_t 
           WHERE gzzd001 = 'sadzi180_ictb' 
             AND gzzd002 = lc_lang
             AND gzzd003 = 'lbl_dest_data'
          IF (lc_msg IS NULL ) THEN LET lc_msg = "Objective table fieldn" END IF
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00767"
          LET g_errparam.extend = NULL
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.replace[1] = "", lc_msg  
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
          CALL cl_err()
        END IF
        
      END IF
    ON ACTION btn_cancel 
      LET mb_return = FALSE
      EXIT DIALOG
      
    ON ACTION CLOSE
      LET mb_return = FALSE
      EXIT DIALOG
  
  END DIALOG

END FUNCTION

FUNCTION sadzi180_ictb_finalize()
  CLOSE WINDOW w_sadzi180_ictb
END FUNCTION

FUNCTION sadzi180_ictb_reload(p_dialog)
DEFINE 
  p_dialog ui.Dialog
  
  CALL p_dialog.setActionActive("right_move", m_left_columns_list.getLength()  > 0)
  CALL p_dialog.setActionActive("left_move" , m_right_columns_list.getLength() > 0)
  CALL p_dialog.setActionActive("left_up"   , p_dialog.getCurrentRow(cs_left)  > 1)
  CALL p_dialog.setActionActive("left_down" , p_dialog.getCurrentRow(cs_left)  < m_left_columns_list.getLength())
  CALL p_dialog.setActionActive("right_up"  , p_dialog.getCurrentRow(cs_right) > 1)
  CALL p_dialog.setActionActive("right_down", p_dialog.getCurrentRow(cs_right) < m_right_columns_list.getLength())
  
END FUNCTION

FUNCTION sadzi180_ictb_get_value(p_list_name,p_index)
DEFINE 
  p_list_name STRING,
  p_index     INT
  
  IF p_list_name = cs_left THEN
    RETURN m_left_columns_list[p_index].*
  ELSE
    RETURN m_right_columns_list[p_index].* 
  END IF
  
END FUNCTION

FUNCTION sadzi180_ictb_set_value(p_list_name,p_index,p_value)
DEFINE 
  p_list_name STRING
DEFINE 
  p_index INT,
  p_value T_INTF_COLUMN_LIST
  
  IF p_list_name = cs_left THEN 
    LET m_left_columns_list[p_index].* = p_value.*
  ELSE
    LET m_right_columns_list[p_index].* = p_value.* 
  END IF
  
END FUNCTION

-- Remove the current item from the source side and move it the destination side
FUNCTION sadzi180_ictb_move_to_left_or_right(p_dialog,p_source,p_dest)
DEFINE 
  i INTEGER,
  p_dialog ui.Dialog,
  p_source STRING,
  p_dest   STRING
DEFINE 
  ls_source   STRING,
  ls_dest     STRING,
  
  li_idx_src  INT, 
  li_idx_dest INT, 
  li_idx_del  INT, 
  lo_col_list T_INTF_COLUMN_LIST
DEFINE
  ls_replace_arg STRING,
  lb_move_action BOOLEAN, #是否要執行搬移動作 --DGW07558_add 
  ls_answer STRING,
  lb_idx BOOLEAN 

  LET ls_source = p_source 
  LET ls_dest   = p_dest
  LET lb_move_action = TRUE 

  LET li_idx_src  = p_dialog.getCurrentRow(ls_source)

  CALL sadzi180_ictb_get_value(ls_source,li_idx_src) RETURNING lo_col_list.*
  
  IF (p_dest == cs_right) THEN  #由左向右新增
    #檢查目地表'欄位代號'是否重複，重複則跳出警告視窗 --DGW07558_add 
    LET lb_move_action = TRUE
    FOR i = 1 TO  m_right_columns_list.getLength()
      IF m_right_columns_list[i].COLUMN_NAME = lo_col_list.COLUMN_NAME THEN  
        LET lb_move_action = FALSE 
        EXIT FOR
      END IF
    END FOR
    IF NOT lb_move_action THEN #lo_col_list.COLUMN_NAME , adz-00182 %1不可設定重複的欄位
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = "adz-00182"
      LET g_errparam.extend = NULL
      LET g_errparam.popup  = TRUE  #訊息開窗顯示
      LET g_errparam.replace[1] = lo_col_list.COLUMN_NAME  
      LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
      CALL cl_err()
    END IF
    
    IF m_edit_type = cs_mdf_type_modify AND lb_move_action THEN
      LET lb_idx = FALSE 
      #檢查新增項目是否是原本刪除項目 --DGW07558_Add at20151102
      IF (m_r_pre_del_colLst.getLength() >  0) THEN
        FOR i = 1 TO  m_r_pre_del_colLst.getLength()
          IF m_r_pre_del_colLst[i].COLUMN_NAME = lo_col_list.COLUMN_NAME THEN  
            #從刪除項目Array中移除該項目
            Call m_r_pre_del_colLst.deleteElement(i)
            LET lb_idx = TRUE 
            EXIT FOR
          END IF
        END FOR
      END IF 
      #是否本次新增項目
      IF NOT lb_idx THEN 
        CALL m_r_pre_ins_colLst.appendElement()
        LET li_idx_del = m_r_pre_ins_colLst.getLength()  
        LET li_idx_del = IIF(li_idx_del == 0,1,li_idx_del)
        LET m_r_pre_ins_colLst[li_idx_del].* = lo_col_list.*
      END IF 
    END IF
  ELSE #由右向左刪除欄位，
    IF m_edit_type = cs_mdf_type_modify THEN  #在修改功能下要跳出警告視窗 -DGW07558_Add
      LET lb_move_action = FALSE 
      LET ls_replace_arg = ""

      # 需要判斷出貨期標"Y"，不能刪除修改
      CALL sadzi180_ictb_chk_shipped(lo_col_list.COLUMN_NAME) RETURNING ls_answer
      IF (ls_answer IS NOT NULL) AND (ls_answer = "Y") THEN
        INITIALIZE g_errparam TO NULL
        IF ms_dgenv = cs_dgenv_cust THEN
          #此表格 %01 欄位 %02 為標準欄位，不能進行修改、刪除。
          LET g_errparam.code   = "adz-00728"
        ELSE 
          #此表格 %01 欄位 %02 已經出貨，不能進行修改、刪除。
          LET g_errparam.code   = "adz-00727"
        END IF
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.replace[1] = lo_col_list.TABLE_NAME
        LET g_errparam.replace[2] = lo_col_list.COLUMN_NAME
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
        RETURN 
      END IF 
      
      LET ls_answer = cs_response_no
      CALL sadzp000_msg_question_box(NULL, "adz-00064", ls_replace_arg, 0) RETURNING ls_answer
      #LET ls_answer = sadzi190_msg_question_box("欄位刪除","dialog","是否要刪除欄位 ? ","question")
      
      IF ls_answer = cs_response_yes THEN
        LET lb_move_action = TRUE
        #記錄刪除項目，之後提供給資料庫刪除依據  --DGW07558_Add at 20151102
        LET lb_idx = FALSE 
        IF (m_r_pre_ins_colLst.getLength() > 0) THEN  #檢查是否此次的新增項目
          FOR i = 1 TO m_r_pre_ins_colLst.getLength()
            IF m_r_pre_ins_colLst[i].COLUMN_NAME = lo_col_list.COLUMN_NAME THEN  
              #從新增項目Array中移除該項目
              Call m_r_pre_ins_colLst.deleteElement(i)
              LET lb_idx = TRUE 
              EXIT FOR
            END IF
          END FOR 
        END IF 
        IF NOT lb_idx THEN
          CALL m_r_pre_del_colLst.appendElement()
          LET li_idx_del = m_r_pre_del_colLst.getLength()  
          LET li_idx_del = IIF(li_idx_del == 0,1,li_idx_del)
          LET m_r_pre_del_colLst[li_idx_del].* = lo_col_list.*
        END IF
      END IF
    END IF
  END IF
  
  IF lb_move_action THEN
    CALL p_dialog.appendRow(ls_dest)
    LET li_idx_dest = p_dialog.getArrayLength(ls_dest)
    LET li_idx_dest = IIF(li_idx_dest == 0,1,li_idx_dest)
    CALL sadzi180_ictb_set_value(ls_dest,li_idx_dest,lo_col_list.*)
    CALL p_dialog.deleteRow(ls_source,li_idx_src)
    CALL p_dialog.setCurrentRow(ls_dest,li_idx_dest)
    CALL sadzi180_ictb_reload(p_dialog)
  END IF 
END FUNCTION

-- Move the current item at the given side 1 row up or down
FUNCTION sadzi180_ictb_move_up_or_down(p_dialog,p_side,p_up)
DEFINE 
  p_dialog ui.Dialog,
  p_side   STRING,
  p_up     INT
DEFINE 
  li_idx  INT,
  li_step INT,
  lo_col_list_step  T_INTF_COLUMN_LIST,
  lo_col_list       T_INTF_COLUMN_LIST
  
  IF p_up THEN
    LET li_step = -1
  ELSE
    LET li_step = 1
  END IF
  
  LET li_idx = p_dialog.getCurrentRow(p_side)

  CALL sadzi180_ictb_get_value(p_side,li_idx) RETURNING lo_col_list.*
  CALL sadzi180_ictb_get_value(p_side,li_idx + li_step) RETURNING lo_col_list_step.*
  
  CALL sadzi180_ictb_set_value(p_side,li_idx + li_step,lo_col_list.*)
  CALL sadzi180_ictb_set_value(p_side,li_idx,lo_col_list_step.*)
  
  CALL p_dialog.setCurrentRow(p_side,li_idx + li_step)
  CALL sadzi180_ictb_reload(p_dialog)
  
END FUNCTION

FUNCTION sadzi180_ictb_fill_left_columns_list(p_array)
DEFINE 
  p_array  DYNAMIC ARRAY OF T_INTF_COLUMN_LIST
DEFINE 
  lo_array  DYNAMIC ARRAY OF T_INTF_COLUMN_LIST,
  li_index  INTEGER

  LET lo_array.* = p_array.*

  CALL m_left_columns_list.Clear();

  FOR li_index = 1 TO lo_array.getLength()
    LET m_left_columns_list[li_index].TABLE_NAME  = lo_array[li_index].TABLE_NAME
    LET m_left_columns_list[li_index].COLUMN_NAME = lo_array[li_index].COLUMN_NAME
    LET m_left_columns_list[li_index].COLUMN_NAME1 = lo_array[li_index].COLUMN_NAME1
    LET m_left_columns_list[li_index].COLUMN_DESC = lo_array[li_index].COLUMN_DESC
    LET m_left_columns_list[li_index].PRIMARY_KEY = lo_array[li_index].PRIMARY_KEY
    LET m_left_columns_list[li_index].NOT_NULL    = lo_array[li_index].NOT_NULL
    LET m_left_columns_list[li_index].DATA_TYPE   = lo_array[li_index].DATA_TYPE
    LET m_left_columns_list[li_index].DATA_LENGTH = lo_array[li_index].DATA_LENGTH
  END FOR 

END FUNCTION

FUNCTION sadzi180_ictb_fill_right_columns_list(p_array)
DEFINE 
  p_array  DYNAMIC ARRAY OF T_INTF_COLUMN_LIST
DEFINE 
  lo_array  DYNAMIC ARRAY OF T_INTF_COLUMN_LIST,
  li_index  INTEGER

  LET lo_array.* = p_array.*

  CALL m_right_columns_list.Clear();

  FOR li_index = 1 TO lo_array.getLength()
    LET m_right_columns_list[li_index].TABLE_NAME  = lo_array[li_index].TABLE_NAME
    LET m_right_columns_list[li_index].COLUMN_NAME = lo_array[li_index].COLUMN_NAME
    LET m_right_columns_list[li_index].COLUMN_NAME1 = lo_array[li_index].COLUMN_NAME1
    LET m_right_columns_list[li_index].COLUMN_DESC = lo_array[li_index].COLUMN_DESC
    LET m_right_columns_list[li_index].PRIMARY_KEY = lo_array[li_index].PRIMARY_KEY
    LET m_right_columns_list[li_index].NOT_NULL    = lo_array[li_index].NOT_NULL
    LET m_right_columns_list[li_index].DATA_TYPE   = lo_array[li_index].DATA_TYPE
    LET m_right_columns_list[li_index].DATA_LENGTH = lo_array[li_index].DATA_LENGTH
  END FOR 

END FUNCTION

FUNCTION sadzi180_ictb_get_column_data(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  lo_get_column_data DYNAMIC ARRAY OF T_INTF_COLUMN_LIST
DEFINE
  ls_table_name  STRING,
  ls_sql         STRING,
  li_rec_cnt     INTEGER
DEFINE
  lo_return DYNAMIC ARRAY OF T_INTF_COLUMN_LIST  

  LET ls_table_name = p_table_name.toLowerCase()
  
  LET li_rec_cnt = 1

  LET ls_sql = " SELECT *                                                                           ",
               "   FROM (                                                                           ",
               "         SELECT 'N'                        CHECK_BOX,                               ",
               "                '",cs_mdm_virtual_table,"' DZIB001,                                 ",
               "                EK.DZEK002                 DZIB002_1,                               ",#DGW07558_Add at20151105
               "                EK.DZEK002                 DZIB002,                                 ",
               "                EK.DZEK005                 DZIB003,                                 ",
               "                EK.DZEK003                 DZIB004,                                 ",
               "                EK.DZEK003                 DZIB005,                                 ",
               "                TD.GZTD003                 DZIB007,                                 ",
               "                TD.GZTD008                 DZIB008                                  ",
               "           FROM DZEK_T EK                                                           ",
               "           LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EK.DZEK004                     ",
               "          WHERE EK.DZEK001 IN (                                                     ",
               "                                'cdfErpStatus',                                     ",
               "                                'cdfMDMStatus',                                     ",
               "                                'cdfBTime',                                         ",
               "                                'cdfTaskNo',                                        ",
               "                                'cdfErpOldStatus'                                   ",
               "                              )                                                     ",  
               "          ORDER BY EK.DZEK006                                                       ",
               "        ) MDM_DATA                                                                  ",
               "  WHERE UPPER('",cs_mdm_virtual_table,"') = UPPER('",ls_table_name,"')              ",
               " UNION ALL                                                                          ",
               " SELECT *                                                                           ",
               "   FROM (                                                                           ",
               "         SELECT 'N'                        CHECK_BOX,                               ",
               "                '",cs_plm_virtual_table,"' DZIB001,                                 ",
               "                EK.DZEK002                 DZIB002_1,                               ",#DGW07558_Add at20151105
               "                EK.DZEK002                 DZIB002,                                 ",
               "                EK.DZEK005                 DZIB003,                                 ",
               "                EK.DZEK003                 DZIB004,                                 ",
               "                EK.DZEK003                 DZIB005,                                 ",
               "                TD.GZTD003                 DZIB007,                                 ",
               "                TD.GZTD008                 DZIB008                                  ",
               "           FROM DZEK_T EK                                                           ",
               "           LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EK.DZEK004                     ",
               "          WHERE EK.DZEK001 IN (                                                     ", 
               "                                'cdfPLMPrimaryKey',                                 ",
               "                                'cdfEnterpriseID',                                  ",
               "                                'cdfPLMLanguage',                                   ",
               "                                'cdfPLMUser',                                       ",
               "                                'cdfSequenceKey',                                   ",
               "                                'cdfSequenceKeySubCount',                           ",
               "                                'cdfDataKey',                                       ",
               "                                'cdfDataKeyTotalCount',                             ",
               "                                'cdfDataKeySubCount',                               ",
               "                                'cdfActionType'                                     ",
               "                              )                                                     ",  
               "          ORDER BY EK.DZEK006                                                       ",
               "        ) PLM_DATA                                                                  ",
               "  WHERE UPPER('",cs_plm_virtual_table,"') = UPPER('",ls_table_name,"')              ",
               " UNION ALL                                                                          ",
               " SELECT *                                                                           ",
               "   FROM (                                                                           ",
               "         SELECT 'N' CHECK_BOX,                                                      ", 
               "                EB.DZEB001,EB.DZEB002 DZEB002_1,EB.DZEB002,EB.DZEB003,              ", #DGW07558_Add at20151105
               "                EB.DZEB004,EB.DZEB005,EB.DZEB007,EB.DZEB008                         ", 
               "           FROM DZEB_T EB                                                           ", 
               "          WHERE EB.DZEB001 = '",ls_table_name,"'                                    ", 
               "          ORDER BY EB.DZEB021                                                       ", 
               "        ) EB_DATA                                                                   "
                 
  PREPARE lpre_get_column_data FROM ls_sql
  DECLARE lcur_get_column_data CURSOR FOR lpre_get_column_data

  OPEN lcur_get_column_data
  FOREACH lcur_get_column_data INTO lo_get_column_data[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_column_data

  CALL lo_get_column_data.deleteElement(li_rec_cnt)
  
  FREE lpre_get_column_data
  FREE lcur_get_column_data  
  
  LET lo_return.* = lo_get_column_data.*
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi180_ictb_get_column_data_from_array(p_dzib_t)
DEFINE
  p_dzib_t  DYNAMIC ARRAY OF T_DZIB_T
DEFINE
  lo_dzib_t  DYNAMIC ARRAY OF T_DZIB_T,
  li_loop    INTEGER,
  lo_get_column_data_from_array DYNAMIC ARRAY OF T_INTF_COLUMN_LIST
DEFINE
  lo_return DYNAMIC ARRAY OF T_INTF_COLUMN_LIST  

  LET lo_dzib_t = p_dzib_t
  
  FOR li_loop = 1 TO lo_dzib_t.getLength()
    LET lo_get_column_data_from_array[li_loop].CHECK_BOX   = "N"
    LET lo_get_column_data_from_array[li_loop].TABLE_NAME  = lo_dzib_t[li_loop].DZIB001
    LET lo_get_column_data_from_array[li_loop].COLUMN_NAME = lo_dzib_t[li_loop].DZIB002
    LET lo_get_column_data_from_array[li_loop].COLUMN_DESC = lo_dzib_t[li_loop].DZIB003
    LET lo_get_column_data_from_array[li_loop].PRIMARY_KEY = lo_dzib_t[li_loop].DZIB004
    LET lo_get_column_data_from_array[li_loop].NOT_NULL    = lo_dzib_t[li_loop].DZIB005
    LET lo_get_column_data_from_array[li_loop].DATA_TYPE   = lo_dzib_t[li_loop].DZIB007
    LET lo_get_column_data_from_array[li_loop].DATA_LENGTH = lo_dzib_t[li_loop].DZIB008
    LET lo_get_column_data_from_array[li_loop].COLUMN_NAME1 = lo_dzib_t[li_loop].DZIB002 #DGW07558_Add at20151105
  END FOR 
  
  LET lo_return.* = lo_get_column_data_from_array.*
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi180_ictb_fill_mdm_schema_list()
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

FUNCTION sadzi180_ictb_set_window_title(p_edit_type)
DEFINE 
  p_edit_type STRING
DEFINE
  ls_window_desc  STRING,
  ls_uc_t         STRING
  
  CASE
    WHEN p_edit_type = cs_mdf_type_new
      IF (ms_dgenv = cs_dgenv_stand) THEN
        LET ls_uc_t = "_t"
      ELSE 
        LET ls_uc_t = "uc_t"
      END IF 
      DISPLAY ls_uc_t TO formonly.lbl_uc_t
      
      LET ls_window_desc = "建立中介表格"
      CALL FGL_SETTITLE(ls_window_desc)
    WHEN p_edit_type = cs_mdf_type_modify
      LET ls_window_desc = "修改中介表格"
      CALL FGL_SETTITLE(ls_window_desc)
  END CASE 
  
END FUNCTION 

PRIVATE FUNCTION sadzi180_ictb_modify_column_name()
  #修改目的表格欄位代號  --DGW07558_Add_at20151104
DEFINE 
  drag_index, drop_index, i, j INTEGER,
  drag_source STRING,
  drag_value  T_INTF_COLUMN_LIST
DEFINE 
  lo_left_array   DYNAMIC ARRAY OF T_INTF_COLUMN_LIST,
  lo_right_array  DYNAMIC ARRAY OF T_INTF_COLUMN_LIST,
  li_r_idx        INTEGER,
  ls_colVal_o     STRING,
  ls_colVal_n     STRING,
  ls_replace_arg  STRING,
  ls_pick_table   STRING,
  li_column_count INTEGER,
  lo_dnd          ui.DragDrop,
  ls_answer       STRING,
  lb_idx          BOOLEAN
DEFINE 
  li_r_pre_ins_colLst_idx   INTEGER 
  

  LET li_column_count = m_right_columns_list.getLength()
  LET li_r_idx = 0

  FOR i=1 TO m_right_columns_list.getLength() 
    LET lo_right_array[i].* = m_right_columns_list[i].*
  END FOR 
  
  
  DISPLAY m_dzia_t.dzia001 TO ed_table_name
  DISPLAY m_dzia_t.dzia002 TO ed_TableDescription
  
  DIALOG ATTRIBUTE(UNBUFFERED,FIELD ORDER FORM)

    DISPLAY ARRAY m_left_columns_list TO sr_left.*
    END DISPLAY
    
    INPUT ARRAY lo_right_array FROM sr_right.*
      ATTRIBUTE (DELETE ROW = FALSE ,INSERT ROW = FALSE , APPEND ROW=FALSE )
      BEFORE INPUT 
        LET li_r_idx = DIALOG.getCurrentRow(cs_right)

      BEFORE ROW 
        LET li_r_idx = DIALOG.getCurrentRow(cs_right)
        IF (li_r_idx < 0 OR li_r_idx > li_column_count) THEN
          LET li_r_idx = 1
          CALL FGL_SET_ARR_CURR(li_r_idx) 
        END IF 
        
      BEFORE FIELD lbl_column_name_right
        LET ls_colVal_o = lo_right_array[li_r_idx].COLUMN_NAME
        #修改表格模式下，判斷是否為本次新增欄位
        IF m_edit_type = cs_mdf_type_modify THEN
          CALL sadzi180_ictb_chk_click_insert_col(ls_colVal_o, li_r_pre_ins_colLst_idx) 
            RETURNING lb_idx, li_r_pre_ins_colLst_idx
          IF NOT lb_idx THEN #非本次新增項目不能修改欄位代號,跳轉到下個新增欄位
            FOR i = 1 TO lo_right_array.getLength()
              IF (m_r_pre_ins_colLst[li_r_pre_ins_colLst_idx].COLUMN_NAME == lo_right_array[i].COLUMN_NAME) THEN
                LET li_r_idx = i 
                CALL DIALOG.setCurrentRow(cs_right, i)
                NEXT FIELD CURRENT 
                EXIT FOR 
              END IF 
            END FOR
          END IF
        END IF 
      
      AFTER FIELD lbl_column_name_right
      
      ON CHANGE lbl_column_name_right
        LET ls_colVal_n = lo_right_array[li_r_idx].COLUMN_NAME
        IF (ls_colVal_n <> ls_colVal_o) THEN
          #當有變更欄位名稱時比較修改後的欄位名稱是否重複
          FOR i = 1 TO  lo_right_array.getLength()
            IF (li_r_idx <> i) THEN
              IF (ls_colVal_n == lo_right_array[i].COLUMN_NAME) THEN
                #欄位代號重覆跳出警告視窗並還原修改內容
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code   = "adz-00182"
                LET g_errparam.extend = NULL
                LET g_errparam.popup  = TRUE  #訊息開窗顯示
                LET g_errparam.replace[1] = ls_colVal_n
                LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
                CALL cl_err()
                LET lo_right_array[li_r_idx].COLUMN_NAME = ls_colVal_o
                NEXT FIELD lbl_column_name_right
                EXIT FOR 
              END IF 
            END IF 
          END FOR
          #修改表格模式下，將異動加入 m_r_pre_ins_colLst
          IF m_edit_type = cs_mdf_type_modify THEN 
            FOR i = 1 TO  m_r_pre_ins_colLst.getLength()
              IF (ls_colVal_o = m_r_pre_ins_colLst[i].COLUMN_NAME) THEN
                LET m_r_pre_ins_colLst[i].COLUMN_NAME = ls_colVal_n
                LET i = i + 1
                IF (i > m_r_pre_ins_colLst.getLength()) THEN LET i = 1 END IF 
                EXIT FOR 
              END IF 
            END FOR 
          END IF 
        END IF
      
      BEFORE FIELD lbl_column_desc_right
        LET ls_colVal_o = lo_right_array[li_r_idx].COLUMN_NAME
        #修改表格模式下，判斷是否為本次新增欄位
        IF m_edit_type = cs_mdf_type_modify THEN
          CALL sadzi180_ictb_chk_click_insert_col(ls_colVal_o, li_r_pre_ins_colLst_idx) 
            RETURNING lb_idx, li_r_pre_ins_colLst_idx
          IF NOT lb_idx THEN #非本次新增項目不能修改欄位代號,跳轉到下個新增欄位
            FOR i = 1 TO lo_right_array.getLength()
              IF (m_r_pre_ins_colLst[li_r_pre_ins_colLst_idx].COLUMN_NAME == lo_right_array[i].COLUMN_NAME) THEN
                LET li_r_idx = i 
                CALL DIALOG.setCurrentRow(cs_right, i)
                NEXT FIELD CURRENT 
                EXIT FOR 
              END IF 
            END FOR
          END IF
        END IF 
        
      AFTER FIELD lbl_column_desc_right
        
      ON CHANGE lbl_column_desc_right
        #修改表格模式下，將異動加入 m_r_pre_ins_colLst
        IF m_edit_type = cs_mdf_type_modify THEN 
          FOR i = 1 TO  m_r_pre_ins_colLst.getLength()
            IF (ls_colVal_o = m_r_pre_ins_colLst[i].COLUMN_NAME) THEN
              LET m_r_pre_ins_colLst[i].COLUMN_DESC = lo_right_array[i].COLUMN_DESC
              LET i = i + 1
              IF (i > m_r_pre_ins_colLst.getLength()) THEN LET i = 1 END IF 
              EXIT FOR 
            END IF 
          END FOR 
        END IF 
      
    END INPUT
    
    
    DISPLAY ARRAY m_mdm_schema_list TO sr_schema.*
      
    END DISPLAY 
    
    #輸入表格供挑選表格
    INPUT ls_pick_table FROM ed_pick_table ATTRIBUTE(WITHOUT DEFAULTS)
      AFTER FIELD ed_pick_table
        GOTO _controlp
        
      ON ACTION controlp INFIELD ed_pick_table
        #跳出視窗提供使用者選擇表格  --DGW07558_need_add 要改寫不透過LIB跳窗
        {
        #&ifndef DEBUG
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'i'
          LET g_qryparam.reqry = FALSE
          LET g_qryparam.default1 = ls_pick_table
          CALL q_dzea001()    #呼叫開窗
          LET ls_pick_table = g_qryparam.return1
          DISPLAY ls_pick_table TO ed_pick_table
        #&endif
        }
        LABEL _controlp:
        CALL sadzi180_ictb_get_column_data(ls_pick_table) RETURNING lo_left_array
        CALL sadzi180_ictb_fill_left_columns_list(lo_left_array)

    END INPUT
    
    BEFORE DIALOG
      IF ( m_r_col_lst_idx > 0) THEN
        CALL DIALOG.setCurrentRow(cs_right, m_r_col_lst_idx)
      END IF 
    ON ACTION btn_column_cancel
      RETURN
    ON ACTION btn_column_confirm
      IF (li_r_idx > 0) THEN
        #比較修改後的欄位名稱是否重複
        LET ls_colVal_n = lo_right_array[li_r_idx].COLUMN_NAME
        IF (ls_colVal_n <> ls_colVal_o) THEN  
          FOR i = 1 TO  lo_right_array.getLength()
            IF (li_r_idx <> i) THEN
              IF (ls_colVal_n == lo_right_array[i].COLUMN_NAME) THEN
                #show error then 還原修改內容
                #ls_colVal_n, adz-00182: %1不可設定重複的欄位
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code   = "adz-00182"
                LET g_errparam.extend = NULL
                LET g_errparam.popup  = TRUE  #訊息開窗顯示
                LET g_errparam.replace[1] = ls_colVal_n
                LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
                CALL cl_err()
                LET lo_right_array[li_r_idx].COLUMN_NAME = ls_colVal_o
                NEXT FIELD lbl_column_name_right
                EXIT FOR 
              END IF 
            END IF 
          END FOR 
          #修改表格模式下，將異動加入 m_r_pre_ins_colLst
          IF m_edit_type = cs_mdf_type_modify THEN 
            FOR i = 1 TO  m_r_pre_ins_colLst.getLength()
              IF (ls_colVal_o = m_r_pre_ins_colLst[i].COLUMN_NAME) THEN
                LET m_r_pre_ins_colLst[i].COLUMN_NAME = ls_colVal_n
                EXIT FOR 
              END IF 
            END FOR 
          END IF 
        END IF 
      END IF 
      LET m_right_columns_list = lo_right_array
      RETURN 
      
  END DIALOG
  
END FUNCTION 

#檢查目前進入欄位是否本次新增項目，若是本次新增項目回傳 ture;
#若否則回傳下一個新增項目位置旗標;
FUNCTION sadzi180_ictb_chk_click_insert_col(ps_colName, pi_r_pre_ins_colLst_idx)
DEFINE 
  ps_colName STRING,
  pi_r_pre_ins_colLst_idx INTEGER 
DEFINE 
  i   INTEGER,
  ls_colName String
DEFINE 
  lb_return BOOLEAN,
  li_r_pre_ins_colLst_idx INTEGER 

  LET lb_return = FALSE 
  LET ls_colName = ps_colName
  LET li_r_pre_ins_colLst_idx = pi_r_pre_ins_colLst_idx

  FOR i = 1 TO m_r_pre_ins_colLst.getLength()
    IF (m_r_pre_ins_colLst[i].COLUMN_NAME == ls_colName) THEN
      LET lb_return = TRUE 
      LET li_r_pre_ins_colLst_idx = i
      EXIT FOR 
    END IF 
  END FOR 

  IF NOT lb_return THEN #非本次新增項目不能修改欄位代號,跳轉到下個新增欄位
    LET lb_return = FALSE
    IF (li_r_pre_ins_colLst_idx  <= 0 
      OR li_r_pre_ins_colLst_idx >= m_r_pre_ins_colLst.getLength()) THEN
      LET li_r_pre_ins_colLst_idx = 1
    ELSE 
      LET li_r_pre_ins_colLst_idx = li_r_pre_ins_colLst_idx + 1  
    END IF
  END IF 
  RETURN lb_return, li_r_pre_ins_colLst_idx
  
END FUNCTION 

#檢查欄位是否已出貨
FUNCTION sadzi180_ictb_chk_shipped(p_col_name)
  DEFINE 
    p_col_name    STRING
  DEFINE
    li_loop       INTEGER,
    ls_col_name   STRING,   #欄位名稱
    ls_m_col_name STRING 
  DEFINE 
    ls_return     STRING  #出貨旗標狀態
  
  LET ls_col_name = p_col_name
  FOR li_loop = 1 TO m_mdf_dzib_t.getLength()
    IF (ls_col_name = m_mdf_dzib_t[li_loop].DZIB002) THEN
      LET ls_return = m_mdf_dzib_t[li_loop].DZIB031
      EXIT FOR 
    END IF 
  END FOR 

  RETURN ls_return
END FUNCTION 

