&include "../4gl/sadzp000_mcr.inc"

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp200_type.inc"

PUBLIC TYPE T_SR_ALM_RECALL RECORD
              sar_ROWNUM    INTEGER,
              sar_CHECKBOX  VARCHAR(1),
              sar_DZLM001	  VARCHAR(10),  -- 建構類型
              sar_DZLM002	  VARCHAR(20),  -- 建構代號
              sar_DZLM003   VARCHAR(120), -- 建構名稱
              sar_DZLM004	  VARCHAR(10),  -- 模組    
              sar_DZLM005	  INTEGER,      -- 建構版號
              sar_DZLM006	  INTEGER,      -- SD版號  
              sar_DZLM007	  VARCHAR(20),  -- SD工號  
              sar_DZLM008	  VARCHAR(1),   -- SD狀態  
              sar_DZLM009	  INTEGER,      -- PR版號  
              sar_DZLM010	  VARCHAR(20),  -- PR工號  
              sar_DZLM011	  VARCHAR(1),   -- PR狀態  
              sar_DZLM012	  VARCHAR(20),  -- 需求單號
              sar_DZLM013	  VARCHAR(10),  -- 產品代號
              sar_DZLM014	  VARCHAR(10),  -- 產品版本
              sar_DZLM015	  INTEGER,      -- 作業項次
              sar_DZLM016	  VARCHAR(40),  -- 客戶代碼    
              sar_DZLM017	  DATE,         -- 簽入時間
              sar_DZLM018	  VARCHAR(40),  -- SD GUID
              sar_DZLM019	  VARCHAR(40),  -- PR GUID
              sar_DZLM020	  VARCHAR(1),   -- SD 已下載
              sar_DZLM021	  VARCHAR(1),   -- PR 已下載
              sar_DZAF010   VARCHAR(2)    -- 使用標示(S/C)
            END RECORD            

DEFINE
  m_sr_alm_recall DYNAMIC ARRAY OF T_SR_ALM_RECALL,
  mo_return       DYNAMIC ARRAY OF T_DZLM_T,  
  mb_wizard       BOOLEAN,
  mb_return       BOOLEAN  

FUNCTION sadzp200_recall_run(p_request_type,p_user,p_lang,p_wizard)
DEFINE
  p_request_type STRING,
  p_user         STRING,
  p_lang         STRING,
  p_wizard       BOOLEAN  
  
  CALL sadzp200_recall_initialize(p_wizard)
  CALL sadzp200_recall_initial_form(p_request_type,p_lang)
  CALL sadzp200_recall_start(p_request_type,p_user,p_lang)
  CALL sadzp200_recall_finalize(FALSE)

  RETURN mb_return,mo_return
  
END FUNCTION 

FUNCTION sadzp200_recall_initialize(p_wizard)
DEFINE
  p_wizard BOOLEAN 
  
  LET mb_wizard = p_wizard

  LET mb_return = FALSE
  INITIALIZE mo_return TO NULL
  
END FUNCTION 

FUNCTION sadzp200_recall_initial_form(p_request_type,p_lang)
DEFINE
  p_request_type STRING,
  p_lang         STRING
DEFINE
  ls_sql STRING

  &ifndef DEBUG
    OPEN WINDOW w_sadzp200_recall WITH FORM cl_ap_formpath("ADZ","sadzp200_recall")
  &else
    OPEN WINDOW w_sadzp200_recall WITH FORM "sadzp200_recall"
  &endif
  
  CURRENT WINDOW IS w_sadzp200_recall

  LET ls_sql = "SELECT GZCB002                 TYPE,     ",
               "       GZCB002||'. '||GZCBL004 NAME      ",
               "  FROM GZCB_T CB                         ",
               "  LEFT OUTER JOIN GZCBL_T                ",
               "               ON GZCB001  = GZCBL001    ",
               "              AND GZCB002  = GZCBL002    ",
               "              AND GZCBL003 = '",p_lang,"'",
               " WHERE CB.GZCB001 = 137                  " 

  CALL sadzp200_recall_find_and_fill_combobox("formonly.dzlm008",ls_sql)
  CALL sadzp200_recall_find_and_fill_combobox("formonly.dzlm011",ls_sql)
  
  CALL sadzp200_set_field_hidden(p_request_type)  
  
END FUNCTION

FUNCTION sadzp200_recall_start(p_request_type,p_user,p_lang)
DEFINE
  p_request_type STRING,
  p_user         STRING,
  p_lang         STRING   
DEFINE
  ls_request_type STRING,
  ls_user         STRING, 
  ls_lang         STRING,   
  li_row_num      INTEGER,
  li_alm_index    INTEGER,
  li_count        INTEGER,
  li_arr_curr     INTEGER,
  lo_curr_window  ui.Window,
  lo_curr_form    ui.Form,
  lo_sr_alm_out   T_SR_ALM_RECALL
  
  LET ls_request_type = p_request_type  
  LET ls_user         = p_user
  LET ls_lang         = p_lang

  LET lo_curr_window = ui.Window.getCurrent()
  LET lo_curr_form   = lo_curr_window.getForm()

  DIALOG ATTRIBUTES(UNBUFFERED)
    INPUT ARRAY m_sr_alm_recall FROM sr_alm_recall.* ATTRIBUTE(WITHOUT DEFAULTS)
    
      BEFORE INPUT
        CALL DIALOG.setActionHidden("insert",TRUE)
        CALL DIALOG.setActionHidden("append",TRUE)
        CALL DIALOG.setActionHidden("delete",TRUE)
        
      BEFORE ROW 
        LET li_alm_index = ARR_CURR()
        LET lo_sr_alm_out.* = m_sr_alm_recall[li_alm_index].*

      ON CHANGE edt_select
        LET li_arr_curr = ARR_CURR()
        IF m_sr_alm_recall[li_arr_curr].sar_DZLM001 IS NULL THEN
          CALL m_sr_alm_recall.deleteElement(li_arr_curr)
        END IF 

    END INPUT

    BEFORE DIALOG 
      CALL lo_curr_form.setElementHidden("btn_back",NOT mb_wizard)
      CALL lo_curr_form.setElementHidden("btn_next",NOT mb_wizard)
      CALL sadzp200_recall_fill_alm_recall(ls_request_type,ls_user)

    ON ACTION btn_back
      CONTINUE DIALOG
    
    ON ACTION btn_next
      CONTINUE DIALOG
    
    ON ACTION btn_ok
      LET mb_return = TRUE
      LET mo_return = null            
      FOR li_count = 1 TO  m_sr_alm_recall.getLength()
        IF m_sr_alm_recall[li_count].sar_CHECKBOX THEN 
          LET mo_return[li_count].DZLM001 = m_sr_alm_recall[li_count].sar_DZLM001
          LET mo_return[li_count].DZLM002 = m_sr_alm_recall[li_count].sar_DZLM002
          LET mo_return[li_count].DZLM003 = m_sr_alm_recall[li_count].sar_DZLM003
          LET mo_return[li_count].DZLM004 = m_sr_alm_recall[li_count].sar_DZLM004
          LET mo_return[li_count].DZLM005 = m_sr_alm_recall[li_count].sar_DZLM005
          LET mo_return[li_count].DZLM006 = m_sr_alm_recall[li_count].sar_DZLM006
          LET mo_return[li_count].DZLM007 = m_sr_alm_recall[li_count].sar_DZLM007
          LET mo_return[li_count].DZLM008 = m_sr_alm_recall[li_count].sar_DZLM008
          LET mo_return[li_count].DZLM009 = m_sr_alm_recall[li_count].sar_DZLM009
          LET mo_return[li_count].DZLM010 = m_sr_alm_recall[li_count].sar_DZLM010
          LET mo_return[li_count].DZLM011 = m_sr_alm_recall[li_count].sar_DZLM011
          LET mo_return[li_count].DZLM012 = m_sr_alm_recall[li_count].sar_DZLM012
          LET mo_return[li_count].DZLM013 = m_sr_alm_recall[li_count].sar_DZLM013
          LET mo_return[li_count].DZLM014 = m_sr_alm_recall[li_count].sar_DZLM014
          LET mo_return[li_count].DZLM015 = m_sr_alm_recall[li_count].sar_DZLM015
          LET mo_return[li_count].DZLM016 = m_sr_alm_recall[li_count].sar_DZLM016
          LET mo_return[li_count].DZLM017 = m_sr_alm_recall[li_count].sar_DZLM017
          LET mo_return[li_count].DZLM018 = m_sr_alm_recall[li_count].sar_DZLM018
          LET mo_return[li_count].DZLM019 = m_sr_alm_recall[li_count].sar_DZLM019
          LET mo_return[li_count].DZLM020 = m_sr_alm_recall[li_count].sar_DZLM020
          LET mo_return[li_count].DZLM021 = m_sr_alm_recall[li_count].sar_DZLM021
        END IF   
      END FOR 
      EXIT DIALOG
      
    ON ACTION btn_cancel
      GOTO _RETURN
      
    ON ACTION CLOSE
      LABEL _RETURN:
      LET mb_return = FALSE
      EXIT DIALOG
      
  END DIALOG
  
END FUNCTION 

FUNCTION sadzp200_recall_finalize(p_force_exit)
DEFINE
  p_force_exit BOOLEAN

  CLOSE WINDOW w_sadzp200_recall
  
  IF p_force_exit THEN 
    EXIT PROGRAM 
  END IF 
  
END FUNCTION 

FUNCTION sadzp200_recall_fill_alm_recall(p_request_type,p_user)
DEFINE
  p_request_type STRING,
  p_user         STRING 
DEFINE
  ls_request_type STRING,
  ls_user         STRING, 
  li_count        INTEGER,
  ls_SQL          STRING

  LET ls_request_type = p_request_type  
  LET ls_user         = p_user

  LET ls_SQL = "SELECT ROWNUM ROW_NUM,'0' CHECK_BOX,LMA.*                                                                ",
               "  FROM (                                                                                                 ",
               "        SELECT LM.DZLM001,LM.DZLM002,LM.DZLM003,LM.DZLM004,LM.DZLM005,                                   ",
               "               LM.DZLM006,LM.DZLM007,LM.DZLM008,LM.DZLM009,LM.DZLM010,                                   ",
               "               LM.DZLM011,LM.DZLM012,LM.DZLM013,LM.DZLM014,LM.DZLM015,                                   ",
               "               LM.DZLM016,LM.DZLM017,LM.DZLM018,LM.DZLM019,LM.DZLM020,                                   ",
               "               LM.DZLM021,AF.DZAF010                                                                     ",
               "          FROM DZLM_T LM                                                                                 ",
               "          LEFT OUTER JOIN DZAF_T AF ON AF.DZAF001 = LM.DZLM002                                           ",
               "                                   AND AF.DZAF002 = LM.DZLM005                                           ",                                
               "                                   AND AF.DZAF005 = LM.DZLM001                                           ",                                
               --"                                   AND AF.DZAF007 = LM.DZLM013                                           ",                                
               --"                                   AND AF.DZAF008 = LM.DZLM014                                           ",                                
               "         WHERE 1=1                                                                                       ",
               "           AND (                                                                                         ",
               "                 ((LM.DZLM007 = '",ls_user,"') AND (LM.DZLM008 = 'O') AND ('SD'='",ls_request_type,"'))  ",
               "                 OR                                                                                      ",
               "                 ((LM.DZLM010 = '",ls_user,"') AND (LM.DZLM011 = 'O') AND ('PR'='",ls_request_type,"'))  ",
               "               )                                                                                         ",
               "         ORDER BY LM.DZLM004, LM.DZLM002, LM.DZLM001                                                     ",
               "       ) LMA                                                                                             ",
               " ORDER BY 1                                                                                              "
               
  PREPARE lpre_fill_alm_recall FROM ls_sql
  DECLARE lcur_fill_alm_recall CURSOR FOR lpre_fill_alm_recall

  CALL m_sr_alm_recall.clear()
  
  LET li_count = 1

  TRY 
    FOREACH lcur_fill_alm_recall INTO m_sr_alm_recall[li_count].*
      IF SQLCA.sqlcode THEN
        EXIT FOREACH
      END IF

      LET li_count = li_count + 1
      
    END FOREACH
  CATCH
    DISPLAY ls_SQL
  END TRY 
  CALL m_sr_alm_recall.deleteElement(li_count)

END FUNCTION

FUNCTION sadzp200_recall_find_and_fill_combobox(p_component_name,p_sql)
DEFINE
  p_component_name STRING,
  p_sql           STRING
DEFINE 
  lo_combobox ui.ComboBox
  
  LET lo_combobox = ui.ComboBox.forName(p_component_name)
  CALL sadzp200_recall_fill_combobox(lo_combobox,p_sql)
  
END FUNCTION

FUNCTION sadzp200_recall_fill_combobox(p_combobox,p_sql)
DEFINE 
  p_combobox ui.ComboBox,
  p_sql      STRING
DEFINE
  ls_sql    STRING,
  li_count  INTEGER, 
  lo_module RECORD 
              combobox_name VARCHAR(50),
              combobox_desc VARCHAR(255)
            END RECORD  

  LET ls_sql = p_sql
 
  PREPARE lpre_combobox FROM ls_sql
  DECLARE lcur_combobox SCROLL CURSOR FOR lpre_combobox

  CALL p_combobox.clear()
  
  LET li_count = 0

  OPEN lcur_combobox
  FOREACH lcur_combobox INTO lo_module.*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    CALL p_combobox.addItem(lo_module.combobox_name,lo_module.combobox_desc)
    LET li_count = li_count + 1
  END FOREACH
  CLOSE lcur_combobox

  FREE lcur_combobox
  FREE lpre_combobox

END FUNCTION

FUNCTION sadzp200_set_field_hidden(p_request_type)
DEFINE
  p_request_type STRING
DEFINE
  lo_curr_window ui.Window,
  lo_curr_form   ui.Form,
  lb_hidden      BOOLEAN

  IF p_request_type = cs_user_role_sd THEN
    LET lb_hidden = TRUE
  ELSE
    LET lb_hidden = FALSE
  END IF 

  LET lo_curr_window = ui.Window.getCurrent()
  LET lo_curr_form   = lo_curr_window.getForm()
  
  CALL lo_curr_form.setFieldHidden("dzlm006",(NOT lb_hidden))
  CALL lo_curr_form.setFieldHidden("dzlm009",lb_hidden)
  
END FUNCTION 
