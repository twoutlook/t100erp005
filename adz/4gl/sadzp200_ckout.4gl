# 160504-00002   : 20160520  by ernest: 1.加入行業別的管控
# 160802-00010   : 20160802  by ernest: 1.修改 sadzp200_ckout 對於 dzlu008 的判斷問題
# 160919-00031   : 20160923  by ernest: 1.P65T的需求單不能顯示

&include "../4gl/sadzp000_mcr.inc"

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp200_type.inc"

PUBLIC TYPE T_SR_ALM_OUT RECORD
               sao_ROWNUM    INTEGER,
               sao_CHECKBOX  VARCHAR(1),
               sao_DZLU001   VARCHAR(2),   -- 角色    
               sao_DZLU002   VARCHAR(20),  -- 工號    
               sao_DZLU003   VARCHAR(20),  -- 需求單號
               sao_DZLU004   VARCHAR(10),  -- 產品代號
               sao_DZLU005   VARCHAR(10),  -- 產品版本
               sao_DZLU006   INTEGER,      -- 作業項次
               sao_DZLU007   VARCHAR(7),   -- 客戶代碼    
               sao_DZLU008   VARCHAR(10),  -- 作業類型
               sao_DZLU009   VARCHAR(160)  -- 作業代號
            END RECORD            

DEFINE
  m_sr_alm_out  DYNAMIC ARRAY OF T_SR_ALM_OUT,
  mo_return     DYNAMIC ARRAY OF T_DZLU_T,  
  mb_wizard     BOOLEAN,
  mb_return     BOOLEAN,
  mi_step       INTEGER,
  ms_topind     STRING, #160504-00002
  ms_search     STRING  

FUNCTION sadzp200_ckout_run(p_request_type,p_user,p_lang,p_step,p_wizard)
DEFINE
  p_request_type STRING,
  p_user         STRING,
  p_lang         STRING,
  p_step         INTEGER,
  p_wizard       BOOLEAN  
  
  LET mi_step = p_step
  LET ms_topind = NVL(FGL_GETENV("TOPIND"),cs_industry_type_standard) #160504-00002 #160802-00010
      
  CALL sadzp200_ckout_initialize(p_wizard)
  CALL sadzp200_ckout_initial_form(p_lang)
  CALL sadzp200_ckout_start(p_request_type,p_user,ms_topind,p_lang,p_step) #160504-00002
  CALL sadzp200_ckout_finalize(FALSE)

  RETURN mb_return,mi_step,mo_return
  
END FUNCTION 

FUNCTION sadzp200_ckout_initialize(p_wizard)
DEFINE
  p_wizard BOOLEAN 
  
  LET mb_wizard = p_wizard

  LET mb_return = FALSE
  INITIALIZE mo_return TO NULL
  
END FUNCTION 

FUNCTION sadzp200_ckout_initial_form(p_lang)
DEFINE
  p_lang STRING
DEFINE
  ls_sql STRING

  &ifndef DEBUG
    OPEN WINDOW w_sadzp200_ckout WITH FORM cl_ap_formpath("ADZ","sadzp200_ckout")
  &else
    OPEN WINDOW w_sadzp200_ckout WITH FORM "sadzp200_ckout"
  &endif
  
  CURRENT WINDOW IS w_sadzp200_ckout

  #Being:20150417 by Hiko
  &ifndef DEBUG
  CALL cl_ui_wintitle(1) #工具抬頭名稱
  CALL cl_load_4ad_interface(NULL)
  &endif

  CALL sadzp200_util_set_form_title('sadzp200_ckout',p_lang)
  CALL sadzp200_util_set_form_style(p_lang)
  
  #End:20150417 by Hiko
  

  LET ls_sql = "SELECT GZCB002                 TYPE,     ",
               "       GZCB002||'. '||GZCBL004 NAME      ",
               "  FROM GZCB_T CB                         ",
               "  LEFT OUTER JOIN GZCBL_T                ",
               "               ON GZCB001  = GZCBL001    ",
               "              AND GZCB002  = GZCBL002    ",
               "              AND GZCBL003 = '",p_lang,"'",
               " WHERE CB.GZCB001 = 136                  " 

  CALL sadzp200_ckout_find_and_fill_combobox("formonly.dzlu008",ls_sql)
  
END FUNCTION

FUNCTION sadzp200_ckout_start(p_request_type,p_user,p_topind,p_lang,p_step)
DEFINE
  p_request_type STRING,
  p_user         STRING,
  p_topind       STRING,
  p_lang         STRING,
  p_step         INTEGER   
DEFINE
  ls_request_type STRING,
  ls_user         STRING, 
  ls_topind       STRING, #160504-00002
  ls_lang         STRING,   
  li_step         INTEGER,   
  li_row_num      INTEGER,
  li_alm_index    INTEGER,
  li_count        INTEGER,
  li_arr_curr     INTEGER,
  li_checkbox     INTEGER,
  lb_checked      BOOLEAN, 
  ls_err_code     STRING,
  ls_err_msg      STRING,
  li_dzlu_cnt     INTEGER,
  lo_temp         T_SR_ALM_OUT,  
  lo_curr_window  ui.Window,
  lo_curr_form    ui.Form,
  lo_sr_alm_out   T_SR_ALM_OUT
  
  LET ls_request_type = p_request_type  
  LET ls_user         = p_user
  LET ls_topind       = p_topind #160504-00002
  LET ls_lang         = p_lang
  LET li_step         = p_step

  LET lo_curr_window = ui.Window.getCurrent()
  LET lo_curr_form   = lo_curr_window.getForm()

  DIALOG ATTRIBUTES(UNBUFFERED)
    INPUT ARRAY m_sr_alm_out FROM sr_alm_out.* ATTRIBUTE(WITHOUT DEFAULTS)
    
      BEFORE INPUT
        CALL DIALOG.setActionHidden("insert",TRUE)
        CALL DIALOG.setActionHidden("append",TRUE)
        CALL DIALOG.setActionHidden("delete",TRUE)
        
      BEFORE ROW 
        LET li_alm_index = ARR_CURR()
        LET lo_sr_alm_out.* = m_sr_alm_out[li_alm_index].*

      ON CHANGE lbl_edt_select
        LET li_arr_curr = ARR_CURR()
        LET li_checkbox = m_sr_alm_out[li_arr_curr].sao_CHECKBOX
        IF ls_request_type = cs_user_role_all THEN 
          LET lo_temp.* = m_sr_alm_out[li_arr_curr].*
          #只能夠挑一個需求單
          LET li_row_num = m_sr_alm_out[li_arr_curr].sao_ROWNUM
          FOR li_count = 1 TO m_sr_alm_out.getLength()
            IF m_sr_alm_out[li_count].sao_ROWNUM <> li_row_num THEN 
              LET m_sr_alm_out[li_count].sao_CHECKBOX = "0"
            END IF 
          END FOR
          FOR li_count = 1 TO m_sr_alm_out.getLength()
            IF lo_temp.sao_DZLU002 = m_sr_alm_out[li_count].sao_DZLU002 AND
               lo_temp.sao_DZLU003 = m_sr_alm_out[li_count].sao_DZLU003 AND
               lo_temp.sao_DZLU004 = m_sr_alm_out[li_count].sao_DZLU004 AND
               lo_temp.sao_DZLU005 = m_sr_alm_out[li_count].sao_DZLU005 AND
               lo_temp.sao_DZLU006 = m_sr_alm_out[li_count].sao_DZLU006 THEN
              LET m_sr_alm_out[li_count].sao_CHECKBOX = li_checkbox
            END IF 
          END FOR
        ELSE 
          #只能夠挑一個需求單
          LET li_row_num = m_sr_alm_out[li_arr_curr].sao_ROWNUM
          FOR li_count = 1 TO m_sr_alm_out.getLength()
            IF m_sr_alm_out[li_count].sao_ROWNUM <> li_row_num THEN 
              LET m_sr_alm_out[li_count].sao_CHECKBOX = "0"
            END IF 
          END FOR
        END IF   
        
    END INPUT

    INPUT ms_search FROM ed_Search ATTRIBUTE(WITHOUT DEFAULTS)
    END INPUT

    BEFORE DIALOG
      CALL DIALOG.setActionActive("btn_back",NOT mb_wizard) 
      CALL DIALOG.setActionActive("btn_next",mb_wizard) 
      CALL DIALOG.setActionActive("btn_ok",NOT mb_wizard) 
      IF NOT mb_wizard THEN 
        CALL lo_curr_form.setElementHidden("btn_back",NOT mb_wizard)
        CALL lo_curr_form.setElementHidden("btn_next",NOT mb_wizard)
        CALL DIALOG.setActionActive("btn_ok",NOT mb_wizard) 
      END IF 
      CALL sadzp200_ckout_fill_alm_out(ls_request_type,ls_user,ls_topind) #160504-00002

    ON ACTION btn_back
      CONTINUE DIALOG
    
    ON ACTION btn_next
      LET lb_checked = FALSE
      FOR li_count = 1 TO m_sr_alm_out.getLength()
        IF m_sr_alm_out[li_count].sao_CHECKBOX AND m_sr_alm_out[li_count].sao_DZLU001 IS NOT NULL THEN
          LET lb_checked = TRUE
        END IF  
      END FOR 
      IF NOT lb_checked THEN
        &ifndef DEBUG
        LET ls_err_code = "adz-00348"
        LET ls_err_msg  = "|"
        CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
        &endif
        CONTINUE DIALOG
      END IF 
      LET li_step = li_step + 1
      LET mi_step = li_step
      GOTO _btn_ok
    
    ON ACTION btn_ok
      LABEL _btn_ok:
      LET mb_return = TRUE
      LET li_dzlu_cnt = 0
      FOR li_count = 1 TO m_sr_alm_out.getLength()
        IF m_sr_alm_out[li_count].sao_CHECKBOX AND m_sr_alm_out[li_count].sao_DZLU001 IS NOT NULL THEN
          LET li_dzlu_cnt = li_dzlu_cnt + 1 
          LET mo_return[li_dzlu_cnt].DZLU001 = m_sr_alm_out[li_count].sao_DZLU001
          LET mo_return[li_dzlu_cnt].DZLU002 = m_sr_alm_out[li_count].sao_DZLU002
          LET mo_return[li_dzlu_cnt].DZLU003 = m_sr_alm_out[li_count].sao_DZLU003
          LET mo_return[li_dzlu_cnt].DZLU004 = m_sr_alm_out[li_count].sao_DZLU004
          LET mo_return[li_dzlu_cnt].DZLU005 = m_sr_alm_out[li_count].sao_DZLU005
          LET mo_return[li_dzlu_cnt].DZLU006 = m_sr_alm_out[li_count].sao_DZLU006
          LET mo_return[li_dzlu_cnt].DZLU007 = m_sr_alm_out[li_count].sao_DZLU007
          LET mo_return[li_dzlu_cnt].DZLU008 = m_sr_alm_out[li_count].sao_DZLU008
          LET mo_return[li_dzlu_cnt].DZLU009 = m_sr_alm_out[li_count].sao_DZLU009
        END IF  
      END FOR 
      EXIT DIALOG

    ON ACTION btn_search  
      CALL sadzp200_ckout_fill_alm_out(ls_request_type,ls_user,ls_topind) #160504-00002
      
    ON ACTION btn_cancel
      GOTO _CLOSE
      
    ON ACTION CLOSE
      LABEL _CLOSE:
      LET mb_return = FALSE
      EXIT DIALOG
      
  END DIALOG
  
END FUNCTION 

FUNCTION sadzp200_ckout_finalize(p_force_exit)
DEFINE
  p_force_exit BOOLEAN

  CLOSE WINDOW w_sadzp200_ckout
  
  IF p_force_exit THEN 
    EXIT PROGRAM 
  END IF 
  
END FUNCTION 

FUNCTION sadzp200_ckout_fill_alm_out(p_request_type,p_user,p_toind)
DEFINE
  p_request_type STRING,
  p_user         STRING,
  p_toind        STRING #160504-00002  
DEFINE
  ls_request_type STRING,
  ls_user         STRING, 
  ls_toind        STRING, #160504-00002  
  ls_dzlu001      STRING,
  li_count        INTEGER,
  ls_SQL          STRING,
  ls_SQL_search   STRING,
  ls_cond_SQL     STRING, 
  ls_P65T_SQL     STRING, #160919-00031
  ls_DGENV        STRING  #160919-00031

  LET ls_request_type = p_request_type  
  LET ls_user         = p_user
  LET ls_toind        = p_toind #160504-00002

  LET ls_DGENV = FGL_GETENV("DGENV") #160919-00031

  #160919-00031 begin
  IF ls_DGENV = cs_dgenv_standard THEN
    LET ls_P65T_SQL = " AND NOT EXISTS (                                 ",
                      "                   SELECT 1                       ",
                      "                     FROM DZLA_T LA               ",
                      "                    WHERE LA.DZLA007 = LU.DZLU003 ",
                      "                      AND LA.DZLA010 = LU.DZLU006 ",
                      "                      AND LA.DZLA001 = 'P65T'     ",
                      "                )                                 "
  ELSE
    LET ls_P65T_SQL = ""
  END IF
  #160919-00031 end
  
  CASE 
    WHEN ls_request_type = cs_user_role_registry
      LET ls_cond_SQL = " AND 1=1"
      LET ls_dzlu001  = "'",cs_user_role_registry,"'"
    WHEN ls_request_type = cs_user_role_all
      LET ls_cond_SQL = " AND 1=1"
      LET ls_dzlu001  = " LU.DZLU001 "
    WHEN ls_request_type = cs_user_role_sd
      LET ls_cond_SQL = " AND LU.DZLU001 = '",ls_request_type,"'"  
      LET ls_dzlu001  = " LU.DZLU001 "
    WHEN ls_request_type = cs_user_role_pr
      LET ls_cond_SQL = " AND LU.DZLU001 = '",ls_request_type,"'"  
      LET ls_dzlu001  = " LU.DZLU001 "
  END CASE 

  IF ms_search.trim() IS NOT NULL THEN
    LET ls_SQL_search = " AND (                                   ", 
                        "       LU.DZLU001 LIKE '%",ms_search,"%' ",
                        "       OR                                ",
                        "       LU.DZLU003 LIKE '%",ms_search,"%' ",
                        "       OR                                ",
                        "       LU.DZLU006 LIKE '%",ms_search,"%' ",
                        "       OR                                ",
                        "       LU.DZLU008 LIKE '%",ms_search,"%' ",
                        "       OR                                ",
                        "       LU.DZLU009 LIKE '%",ms_search,"%' ",
                        "     )                                   "
  ELSE
    LET ls_SQL_search = ""
  END IF

  LET ls_SQL = "  SELECT ROWNUM ROW_NUM,'0' CHECK_BOX,LUA.*                                                                          ",
               "    FROM (                                                                                                           ",
               "          SELECT DISTINCT                                                                                            ",
               "                 ",ls_dzlu001," DZLU001,LU.DZLU002 DZLU002,LU.DZLU003 DZLU003,LU.DZLU004 DZLU004,LU.DZLU005 DZLU005, ",
               "                 LU.DZLU006 DZLU006,LU.DZLU007 DZLU007,LU.DZLU008 DZLU008,LU.DZLU009 DZLU009                         ",
               "            FROM DZLU_T LU                                                                                           ",
               "           WHERE 1=1                                                                                                 ",
               ls_cond_SQL,            
               ls_SQL_search,               
               ls_P65T_SQL,
               "             AND LU.DZLU002 = '",ls_user,"'                                                                          ",
               "             AND NVL(LU.DZLU008,'",NVL(ls_toind,cs_industry_type_standard),"') = '",ls_toind,"'                      ", #160504-00002 #160802-00010               
               --"             AND LU.DZLU008 = '",ls_toind,"'                                                                         ", #160504-00002
               --"             AND NVL(LU.DZLU008,'",cs_null_default,"') = DECODE(LU.DZLU008,NULL,'",cs_null_default,"','",ls_toind,"')", #160504-00002 #160802-00010               
               "           ORDER BY LU.DZLU003, LU.DZLU006                                                                           ",
               "         ) LUA                                                                                                       "

  PREPARE lpre_fill_alm_out FROM ls_sql
  DECLARE lcur_fill_alm_out CURSOR FOR lpre_fill_alm_out

  CALL m_sr_alm_out.clear()
  
  LET li_count = 1

  TRY 
    FOREACH lcur_fill_alm_out INTO m_sr_alm_out[li_count].*
      IF SQLCA.sqlcode THEN
        EXIT FOREACH
      END IF

      LET li_count = li_count + 1
      
    END FOREACH
  CATCH
    DISPLAY ls_SQL
  END TRY 
  CALL m_sr_alm_out.deleteElement(li_count)

END FUNCTION

FUNCTION sadzp200_ckout_find_and_fill_combobox(p_component_name,p_sql)
DEFINE
  p_component_name STRING,
  p_sql           STRING
DEFINE 
  lo_combobox ui.ComboBox
  
  LET lo_combobox = ui.ComboBox.forName(p_component_name)
  CALL sadzp200_ckout_fill_combobox(lo_combobox,p_sql)
  
END FUNCTION

FUNCTION sadzp200_ckout_fill_combobox(p_combobox,p_sql)
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

FUNCTION sadzp200_ckout_get_dzlu_without_alm(p_role,p_user)
DEFINE
  p_role STRING, 
  p_user STRING
DEFINE
  ls_role            STRING, 
  ls_user            STRING,
  li_role            INTEGER,
  ls_user_name       STRING,
  ls_alm_request_no  STRING,
  ls_alm_sequence_no STRING, 
  lo_role_arr        T_STATIC_ROLE_LIST,
  lo_dzlu_t          T_DZLU_T
DEFINE
  lb_result BOOLEAN,
  lo_result DYNAMIC ARRAY OF T_DZLU_T 

  LET ls_role = p_role
  LET ls_user = p_user  

  LET lb_result = TRUE

  LET ls_user_name = FGL_GETENV("USER")
  
  IF ls_user_name = cs_topstd_user_name THEN
    LET ls_alm_request_no = cs_topstd_request_no
    LET ls_alm_sequence_no = cs_topstd_sequence_no
  ELSE
    LET ls_alm_request_no = cs_disable_alm_request_no
    LET ls_alm_sequence_no = cs_disable_alm_sequence_no
  END IF 

  LET lo_dzlu_t.DZLU001 = ls_role
  LET lo_dzlu_t.DZLU002 = ls_user
  LET lo_dzlu_t.DZLU003 = ls_alm_request_no -- 需求單號
  LET lo_dzlu_t.DZLU004 = FGL_GETENV("ERPID") 
  LET lo_dzlu_t.DZLU005 = FGL_GETENV("ERPVER") 
  LET lo_dzlu_t.DZLU006 = ls_alm_sequence_no -- 作業項次
  LET lo_dzlu_t.DZLU007 = FGL_GETENV("CUST") 
  LET lo_dzlu_t.DZLU008 = cs_industry_type_standard 
  LET lo_dzlu_t.DZLU009 = ""
  
  LET lo_result[1].* = lo_dzlu_t.*

  #如果 ROLE 為 ALL, 則要重新產生兩組分別為SD及PR的陣列
  IF ls_role = cs_user_role_all THEN
    #設定角色Array
    CALL sadzp200_util_get_static_role_list() RETURNING lo_role_arr
    FOR li_role = 1 TO lo_role_arr.getLength()

      LET ls_role = lo_role_arr[li_role]
      LET lo_dzlu_t.DZLU001 = ls_role
      LET lo_result[li_role].* = lo_dzlu_t.*
       
    END FOR 
  
  END IF 
  
  RETURN lb_result,lo_result
  
END FUNCTION