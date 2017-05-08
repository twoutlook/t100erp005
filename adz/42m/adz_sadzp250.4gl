&include "../4gl/sadzp250_mcr.inc"

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp000_cnst.inc"

CONSTANT cs_erp_path STRING = "ERP"
CONSTANT cs_program_title STRING = "sadzp250-Table Patch Monitor "

&include "../4gl/sadzp240_cnst.inc"
&include "../4gl/sadzp250_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

################################################################################
#資料表 TYPE 宣告

&include "../4gl/sadzp240_type.inc"
&include "../4gl/sadzp250_type.inc"

DEFINE 
  ms_lang        STRING,
  ms_user        STRING

#定義模組變數
DEFINE m_dzee_t_scr DYNAMIC ARRAY OF T_DZEE_T_SCR
DEFINE m_dzez_t_scr DYNAMIC ARRAY OF T_DZEZ_T_SCR

DEFINE m_backup_table_scr DYNAMIC ARRAY OF T_BACKUP_TABLE_SCR
DEFINE m_cust_table_scr   DYNAMIC ARRAY OF T_CUST_TABLE_SCR

DEFINE m_statistics_scr  DYNAMIC ARRAY OF T_STATISTICS_SCR

DEFINE m_dzee_t_scr_color DYNAMIC ARRAY OF T_DZEE_T_SCR_COLOR
DEFINE m_dzez_t_scr_color DYNAMIC ARRAY OF T_DZEZ_T_SCR_COLOR

DEFINE ms_GUID       STRING
DEFINE ms_mode       STRING
DEFINE ms_patch      STRING 
DEFINE ms_patch_full STRING 
DEFINE ms_search     STRING

DEFINE mi_dzee_index  INTEGER

FUNCTION sadzp250_run(p_mode,p_guid,p_lang)
DEFINE
  p_mode STRING,
  p_guid STRING,
  p_lang STRING
  
  CALL sadzp250_initialize(p_mode,p_guid,p_lang)
  CALL sadzp250_initial_form()
  CALL sadzp250_start()
  CALL sadzp250_finalize(TRUE) 
  
END FUNCTION

FUNCTION sadzp250_initialize(p_mode,p_guid,p_lang)
DEFINE
  p_mode STRING,
  p_guid STRING, 
  p_lang STRING
DEFINE
  ls_parameter   STRING,
  ls_replace_arg STRING,
  ls_erpalm      STRING,
  lb_exists      BOOLEAN,
  lb_error       BOOLEAN, 
  ls_user        STRING

  CALL sadzp250_util_set_execute_path(os.path.pwd()) #設定執行路徑

  LET ms_mode = p_mode
  LET ms_guid = p_guid
  LET ms_lang = p_lang

END FUNCTION

FUNCTION sadzp250_initial_form()
DEFINE 
  ls_erp_path   STRING,
  lo_window     ui.Window, 
  lo_form       ui.Form,
  ls_cfg_path   STRING,
  ls_4st_path   STRING,
  ls_separator  STRING

  LET ls_separator = os.Path.separator()
  
  CALL FGL_GETENV(cs_erp_path) RETURNING ls_erp_path
  
  #按 Enter 自動跳欄位
  OPTIONS INPUT WRAP
  CLOSE WINDOW SCREEN

  &ifndef DEBUG
    OPEN WINDOW w_adzp250 WITH FORM cl_ap_formpath("ADZ","sadzp250") 
    CURRENT WINDOW IS w_adzp250
    CALL sadzp250_set_window_title()
    CALL cl_load_4ad_interface(NULL)
    LET lo_window = ui.Window.getCurrent()
    LET lo_form = lo_window.getForm()
    #LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
    #LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), ms_lang), "designer.4st")
    #CALL ui.Interface.loadStyles(ls_4st_path)    
    CALL ui.Interface.loadStyles(ls_erp_path||ls_separator||"cfg"||ls_separator||"4st"||ls_separator||"adzp250")
    #讓ON ACITON controlg的Button從畫面上消失, 改成用Ctrl-G來觸發
  &else
    OPEN WINDOW w_adzp250 WITH FORM sadzp250_util_get_form_path("sadzp250")
    CURRENT WINDOW IS w_adzp250
    CALL sadzp250_set_window_title()
    LET lo_window = ui.Window.getCurrent()
    LET lo_form = lo_window.getForm()
    CALL ui.Interface.loadStyles("adzp250")
    #LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
    #LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), ms_lang), "designer.4st")
    #CALL ui.Interface.loadStyles(ls_4st_path)    
    CALL ui.Interface.loadActionDefaults("resource\\tiptop_0")
  &endif

  CALL ui.Dialog.setDefaultUnbuffered(TRUE)

END FUNCTION 

FUNCTION sadzp250_start()
DEFINE 
  ls_separator     STRING,
  ls_get_unfinish  STRING,
  lo_dzee_t        T_DZEE_T,
  ls_log_contents  STRING,
  ls_command       STRING,
  ls_question      STRING,
  li_index         INTEGER,
  ls_name          STRING,
  ls_filename      STRING,
  ls_pwd           STRING,
  ls_result        STRING,
  lo_channel       base.Channel,
  lo_curr_window   ui.Window,
  lo_curr_form     ui.Form

  LET ls_separator = os.Path.separator()

  LET lo_curr_window = ui.Window.getCurrent()
  LET lo_curr_form   = lo_curr_window.getForm()
  
  CALL lo_curr_window.setImage("logo/dsc_logo.ico")
  
  DIALOG ATTRIBUTES(UNBUFFERED)
    
    #Table Lists 
    DISPLAY ARRAY m_dzee_t_scr TO sr_PatchList.*
    #INPUT ARRAY m_dzee_t_scr FROM sr_PatchList.* ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE ROW 
        LET mi_dzee_index = ARR_CURR()
        CALL sadzp250_refresh_buttons(DIALOG,m_dzee_t_scr[mi_dzee_index].DZEE005,ms_mode)

    #END INPUT
    END DISPLAY

    DISPLAY ARRAY m_dzez_t_scr TO sr_TableStatus.*
    END DISPLAY
    
    DISPLAY ARRAY m_backup_table_scr TO sr_backup_table.*
    END DISPLAY
    
    DISPLAY ARRAY m_cust_table_scr TO sr_cust_table.*
    END DISPLAY

    INPUT ARRAY m_statistics_scr FROM sr_statistics.* ATTRIBUTE(WITHOUT DEFAULTS)
    #DISPLAY ARRAY m_statistics_scr TO sr_statistics.*
    #END DISPLAY
    END INPUT
    
    #輸入搜尋條件
    INPUT ls_name FROM cb_GUID ATTRIBUTE(WITHOUT DEFAULTS)
      ON CHANGE cb_GUID
        LET li_index = sadzp250_get_combobox_index_by_name("formonly.cb_guid",ls_name)
        LET ms_patch_full = sadzp250_get_combobox_text_by_index("formonly.cb_guid",li_index)
        LET ms_GUID  = ms_patch_full.subString(ms_patch_full.getIndexOf("[",1)+1,ms_patch_full.getIndexOf("]",1)-1)
        #LET ms_patch = ms_patch_full.subString(1,ms_patch_full.getIndexOf("-",1)-1)
        LET ms_patch  = ms_patch_full.subString(ms_patch_full.getIndexOf("{",1)+1,ms_patch_full.getIndexOf("}",1)-1)
        CALL sadzp250_refresh_monitor(DIALOG,ms_GUID,ms_patch)
    END INPUT

    #輸入搜尋條件
    INPUT ls_get_unfinish FROM cb_get_unfinish 
      ON CHANGE cb_get_unfinish
        LET ms_search = ""
        IF ls_get_unfinish = "Y" THEN
          CALL sadzp250_refill_combobox(FALSE,FALSE)
        ELSE 
          CALL sadzp250_refill_combobox(TRUE,FALSE)
        END IF
        CALL sadzp250_refresh_and_refill_data(DIALOG,FALSE)
        CALL sadzp250_refresh_monitor(DIALOG,ms_GUID,ms_patch)
        CALL sadzp250_refresh_buttons(DIALOG,m_dzee_t_scr[mi_dzee_index].DZEE005,ms_mode)
    END INPUT

    INPUT ms_search FROM ed_filter
    END INPUT 
    
    BEFORE DIALOG
       LET mi_dzee_index = 1
       LET ls_get_unfinish = "Y"
       LET ms_search = ms_guid
      CALL sadzp250_reset_buttons(DIALOG,FALSE)
      IF ms_search IS NOT NULL THEN 
        CALL sadzp250_refill_combobox(FALSE,TRUE)
      ELSE  
        CALL sadzp250_refill_combobox(FALSE,FALSE)
      END IF  
      CALL sadzp250_refresh_and_refill_data(DIALOG,TRUE)
      CALL sadzp250_refresh_monitor(DIALOG,ms_GUID,ms_patch)
      CALL sadzp250_refresh_buttons(DIALOG,m_dzee_t_scr[mi_dzee_index].DZEE005,ms_mode)

    ON IDLE 3
      CALL sadzp250_refresh_monitor(DIALOG,ms_GUID,ms_patch)

    ON ACTION btn_view_log
      LET ls_log_contents = ""
      CALL sadzp250_adapter_dzeescr_to_dzee(m_dzee_t_scr[mi_dzee_index].*) RETURNING lo_dzee_t.*
      CALL sadzp240_intf_get_log_record_contents(lo_dzee_t.*) RETURNING ls_log_contents
      IF (NVL(ls_log_contents.trim(),cs_null_default) = cs_null_default) OR (ls_log_contents IS NULL) THEN
        CALL sadzp240_intf_get_log_file_contents(m_dzee_t_scr[mi_dzee_index].DZEE010) RETURNING ls_log_contents 
      END IF
      CALL sadzp250_log_view_logresult(ls_log_contents,ms_lang) 
    
    ON ACTION btn_resubmit  
      CALL sadzp000_msg_question_box("adz-00513","adz-00513","",0) RETURNING ls_question
      IF (ls_question = cs_response_yes) THEN 
        LET ls_command = m_dzee_t_scr[mi_dzee_index].DZEE011
        DISPLAY cs_command_tag,ls_command
        RUN ls_command WITHOUT WAITING
        SLEEP 1
        CALL sadzp250_refresh_monitor(DIALOG,ms_GUID,ms_patch)
        CALL sadzp250_refresh_buttons(DIALOG,m_dzee_t_scr[mi_dzee_index].DZEE005,ms_mode)
      END IF  
      
    ON ACTION btn_cancel
      CALL sadzp000_msg_question_box("adz-00535","adz-00535","",0) RETURNING ls_question
      IF (ls_question = cs_response_yes) THEN 
        CALL sadzp250_adapter_dzeescr_to_dzee(m_dzee_t_scr[mi_dzee_index].*) RETURNING lo_dzee_t.*
        LET lo_dzee_t.DZEE005 = cs_state_cancel
        CALL sadzp240_intf_set_status_code(lo_dzee_t.*)
        CALL sadzp250_refresh_monitor(DIALOG,ms_GUID,ms_patch)
        CALL sadzp250_refresh_buttons(DIALOG,m_dzee_t_scr[mi_dzee_index].DZEE005,ms_mode)
      END IF  
    
    ON ACTION btn_manually
      CALL sadzp000_msg_question_box("adz-00536","adz-00536","",0) RETURNING ls_question
      IF (ls_question = cs_response_yes) THEN 
        CALL sadzp250_adapter_dzeescr_to_dzee(m_dzee_t_scr[mi_dzee_index].*) RETURNING lo_dzee_t.*
        LET lo_dzee_t.DZEE005 = cs_state_manually
        CALL sadzp240_intf_set_status_code(lo_dzee_t.*)
        CALL sadzp250_refresh_monitor(DIALOG,ms_GUID,ms_patch)
        CALL sadzp250_refresh_buttons(DIALOG,m_dzee_t_scr[mi_dzee_index].DZEE005,ms_mode)
      END IF  

    ON ACTION btn_open_archive
      LET ls_pwd = os.Path.homedir()
      LET lo_channel = base.Channel.create()
      LET ls_filename = sadzp250_dlg_opendlg(
                                              "Open table archive",
                                              ls_pwd,
                                              NULL,
                                              "*.tgz",""
                                            )

      IF ls_filename IS NOT NULL THEN                                       
        CALL sadzp250_util_run_table_patcher(ls_filename) RETURNING ls_result   
        LET ms_search = ls_result
        GOTO　_FILTER  
      END IF  

    ON ACTION ed_filter
      LABEL _FILTER:
      IF ls_get_unfinish = "Y" THEN
        CALL sadzp250_refill_combobox(FALSE,TRUE)
      ELSE 
        CALL sadzp250_refill_combobox(TRUE,TRUE)
      END IF      
      CALL sadzp250_refresh_monitor(DIALOG,ms_GUID,ms_patch)
      CALL sadzp250_refresh_buttons(DIALOG,m_dzee_t_scr[mi_dzee_index].DZEE005,ms_mode)
      
    ON ACTION btn_exit
      LET INT_FLAG=FALSE         
      EXIT DIALOG
      
    ON ACTION EXIT
      LET INT_FLAG=FALSE         
      EXIT DIALOG  
      
    ON ACTION CLOSE    
      LET INT_FLAG=FALSE         
      EXIT DIALOG

    CONTINUE DIALOG  

  END DIALOG

END FUNCTION

FUNCTION sadzp250_finalize(p_value)
DEFINE
  p_value BOOLEAN

  IF p_value THEN
    EXIT PROGRAM
  ELSE
    EXIT PROGRAM -1
  END IF 
  
END FUNCTION

FUNCTION sadzp250_set_window_title()
DEFINE
  ls_zone          STRING,
  ls_user          STRING,
  ls_user_domain   STRING,
  lo_db_info       T_DB_INFO, 
  ls_program_title STRING,
  ls_window_title  STRING

  CALL FGL_GETENV("ZONE") RETURNING ls_zone

  #For get Windows information
  CALL FGL_GETENV("USERNAME") RETURNING ls_user
  CALL FGL_GETENV("USERDOMAIN") RETURNING ls_user_domain
  
  CALL sadzp250_db_get_db_info() RETURNING lo_db_info.*
  CALL sadzp250_util_get_program_title('sadzp250',ms_lang) RETURNING ls_program_title
  
  LET ls_zone = NVL(ls_zone,ls_user_domain)
  LET ls_user = NVL(ms_user,ls_user)

  LET ls_window_title = NVL(ls_program_title,cs_program_title)," [ Zone：",ls_zone," ] [ User：",ls_user," ] [DB Name：",lo_db_info.DB_NAME,"] [DB User：",lo_db_info.USER_NAME,"] [ Login Time：",CURRENT YEAR TO SECOND," ]"

  CALL FGL_SETTITLE(ls_window_title)

END FUNCTION

FUNCTION sadzp250_refresh_monitor(p_DIALOG,p_GUID,p_patch_number)
DEFINE
  p_DIALOG       ui.Dialog,
  p_GUID         STRING,
  p_patch_number STRING
DEFINE
  ls_GUID         STRING,
  ls_patch_number STRING

  LET ls_patch_number = p_patch_number
  LET ls_GUID = p_GUID
  
  CALL sadzp250_fill_dzee_t(ls_GUID)
  CALL p_DIALOG.setArrayAttributes("sr_patchlist", m_dzee_t_scr_color)
  CALL sadzp250_fill_dzez_t(ls_GUID)
  CALL p_DIALOG.setArrayAttributes("sr_tablestatus", m_dzez_t_scr_color)
  CALL sadzp250_fill_backup_tables(ls_patch_number)
  CALL sadzp250_fill_cust_tables(ls_GUID)
  CALL sadzp250_fill_statistics_tables(ls_GUID)
  
END FUNCTION 

FUNCTION sadzp250_refresh_buttons(p_DIALOG,p_status_code,p_mode)
DEFINE
  p_DIALOG      ui.Dialog,
  p_status_code STRING,
  p_mode        STRING
DEFINE
  ls_status_code STRING,
  ls_mode        STRING

  LET ls_status_code = p_status_code
  LET ls_mode = p_mode

  IF ls_mode.toUpperCase() = "DEBUG" THEN
    CALL sadzp250_reset_buttons(p_DIALOG,TRUE)
  ELSE  
    
    CALL sadzp250_reset_buttons(p_DIALOG,FALSE)
    
    CASE ls_status_code
      WHEN cs_state_waiting    
        CALL p_DIALOG.setActionActive("btn_cancel", TRUE)
      WHEN cs_state_assigned   
        CALL p_DIALOG.setActionActive("btn_cancel", TRUE)
      WHEN cs_state_processing 
        CALL p_DIALOG.setActionActive("btn_view_log", TRUE)
      WHEN cs_state_finished   
        CALL p_DIALOG.setActionActive("btn_resubmit", TRUE)
        CALL p_DIALOG.setActionActive("btn_view_log", TRUE)
      WHEN cs_state_error      
        CALL p_DIALOG.setActionActive("btn_resubmit", TRUE)
        CALL p_DIALOG.setActionActive("btn_view_log", TRUE)
        CALL p_DIALOG.setActionActive("btn_manually", TRUE)
        CALL p_DIALOG.setActionActive("btn_cancel", TRUE)
      WHEN cs_state_manually   
        CALL p_DIALOG.setActionActive("btn_view_log", TRUE)
      WHEN cs_state_cancel     
        CALL p_DIALOG.setActionActive("btn_view_log", TRUE)
      OTHERWISE
        CALL sadzp250_reset_buttons(p_DIALOG,FALSE)
    END CASE 
  END IF         
      
END FUNCTION 

FUNCTION sadzp250_reset_buttons(p_DIALOG,p_active)
DEFINE
  p_DIALOG  ui.Dialog,
  p_active  BOOLEAN

  CALL p_DIALOG.setActionActive("btn_view_log", p_active)
  CALL p_DIALOG.setActionActive("btn_resubmit", p_active)
  CALL p_DIALOG.setActionActive("btn_manually", p_active)
  CALL p_DIALOG.setActionActive("btn_cancel", p_active)

END FUNCTION 

FUNCTION sadzp250_fill_dzee_t(p_guid)
DEFINE
  p_guid STRING
DEFINE 
  ls_guid        STRING,
  ls_sql         STRING,
  ls_sql_cond    STRING,
  li_count       INTEGER

  LET ls_guid = p_guid.trim()

  LET ls_sql_cond = " AND EE.DZEE001 = '",ls_guid,"'"

  LET ls_sql = "SELECT '' STATUS,                                                       ",
               "       EE.DZEE001,EE.DZEE002,EE.DZEE003,EE.DZEE004,EE.DZEE005,          ",
               "       EE.DZEE006,EE.DZEE007,EE.DZEE008,                                ",
               "       TRIM(REPLACE(EE.DZEE008 - EE.DZEE007,'+000000000','')) DZEECOST, ",   
               "       EE.DZEE009,EE.DZEE010,EE.DZEE011                                 ",
               "  FROM DZEE_T EE                                                        ",
               " WHERE 1=1                                                              ",         
               ls_sql_cond,                                                              
               " ORDER BY EE.DZEE002                                                    "
                  
  PREPARE lpre_fill_dzee_t FROM ls_sql
  DECLARE lcur_fill_dzee_t CURSOR FOR lpre_fill_dzee_t

  CALL m_dzee_t_scr.clear()
  CALL m_dzee_t_scr_color.clear()
  
  LET li_count = 1
  
  FOREACH lcur_fill_dzee_t INTO m_dzee_t_scr[li_count].*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET m_dzee_t_scr_color[li_count].DZEE005 = NULL
    
    IF m_dzee_t_scr[li_count].DZEE005 = cs_state_finished THEN
      LET m_dzee_t_scr_color[li_count].DZEE005 = "green reverse"
    END IF

    IF (m_dzee_t_scr[li_count].DZEE005 = cs_state_error)  THEN
      LET m_dzee_t_scr_color[li_count].DZEE005 = "red reverse"
    END IF
    
    IF (m_dzee_t_scr[li_count].DZEE005 = cs_state_cancel) THEN
      LET m_dzee_t_scr_color[li_count].DZEE005 = "magenta reverse"
    END IF
    
    IF (m_dzee_t_scr[li_count].DZEE005 = cs_state_manually) THEN
      LET m_dzee_t_scr_color[li_count].DZEE005 = "blue reverse"
    END IF
    
    IF m_dzee_t_scr[li_count].DZEE005 = cs_state_processing THEN
      LET m_dzee_t_scr_color[li_count].DZEE005 = "yellow reverse"
    END IF
    
    LET li_count = li_count + 1
    
  END FOREACH
  CALL m_dzee_t_scr.deleteElement(li_count)

END FUNCTION

FUNCTION sadzp250_fill_dzez_t(p_guid)
DEFINE
  p_guid STRING
DEFINE 
  ls_guid        STRING,
  ls_sql         STRING,
  ls_sql_cond    STRING,
  li_count       INTEGER

  LET ls_guid = p_guid.trim()

  LET ls_sql_cond = " AND EZ.DZEZ001 = '",ls_guid,"'"

  LET ls_sql = "SELECT '' STATUS,                                                      ",
               "       EZ.DZEZ001,EZ.DZEZ007,EZ.DZEZ002,EZ.DZEZ003,EZ.DZEZ004,         ",
               "       EZ.DZEZ005,EZ.DZEZ006,                                          ",
               "       TRIM(REPLACE(EZ.DZEZ006 - EZ.DZEZ005,'+000000000','')) DZEZCOST ", 
               "  FROM DZEZ_T EZ                                                       ",
               " WHERE 1=1                                                             ",         
               ls_sql_cond,                                                              
               " ORDER BY EZ.DZEZ002                                                   "
                  
  PREPARE lpre_fill_dzez_t FROM ls_sql
  DECLARE lcur_fill_dzez_t CURSOR FOR lpre_fill_dzez_t

  CALL m_dzez_t_scr.clear()
  CALL m_dzez_t_scr_color.clear()
  
  LET li_count = 1
  
  FOREACH lcur_fill_dzez_t INTO m_dzez_t_scr[li_count].*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET m_dzez_t_scr_color[li_count].DZEZ003 = NULL
    
    IF m_dzez_t_scr[li_count].DZEZ003 = cs_state_finished THEN
      LET m_dzez_t_scr_color[li_count].DZEZ003 = "green reverse"
    END IF

    IF (m_dzez_t_scr[li_count].DZEZ003 = cs_state_error) THEN
      LET m_dzez_t_scr_color[li_count].DZEZ003 = "red reverse"
    END IF

    IF m_dzez_t_scr[li_count].DZEZ003 = cs_state_processing THEN
      LET m_dzez_t_scr_color[li_count].DZEZ003 = "yellow reverse"
    END IF
    
    LET li_count = li_count + 1
    
  END FOREACH
  CALL m_dzez_t_scr.deleteElement(li_count)

END FUNCTION

FUNCTION sadzp250_fill_backup_tables(p_patch_number)
DEFINE
  p_patch_number STRING
DEFINE 
  ls_patch_number STRING,
  ls_sql          STRING,
  li_count        INTEGER

  LET ls_patch_number = p_patch_number.trim()
  LET ls_patch_number = NVL(ls_patch_number,cs_null_default)

  LET ls_sql = "SELECT '' STATUS,ATS.TABLE_NAME TABLE_NAME         ",
               "  FROM ALL_TABLES ATS                              ",
               " WHERE ATS.TABLE_NAME LIKE '%",ls_patch_number,"%' ",
               "   AND ATS.OWNER = 'DSBAK'                         ",
               " ORDER BY ATS.TABLE_NAME                           "
                  
  PREPARE lpre_fill_backup_tables FROM ls_sql
  DECLARE lcur_fill_backup_tables CURSOR FOR lpre_fill_backup_tables

  CALL m_backup_table_scr.clear()
  
  LET li_count = 1
  
  FOREACH lcur_fill_backup_tables INTO m_backup_table_scr[li_count].*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET li_count = li_count + 1
    
  END FOREACH
  CALL m_backup_table_scr.deleteElement(li_count)

END FUNCTION

FUNCTION sadzp250_fill_cust_tables(p_GUID)
DEFINE
  p_GUID STRING
DEFINE 
  ls_GUID  STRING,
  ls_sql   STRING,
  li_count INTEGER

  LET ls_GUID = p_GUID.trim()

  LET ls_sql = "SELECT DISTINCT '' STATUS,EB.DZEB001               ",
               "  FROM DZEB_T EB                                   ",
               " WHERE EXISTS (                                    ",
               "                SELECT 1                           ",
               "                  FROM DZEZ_T EZ                   ",
               "                 WHERE EZ.DZEZ002 = EB.DZEB001     ",
               "                   AND EZ.DZEZ001 = '",ls_GUID,"'  ",
               "              )                                    ",
               "   AND EB.DZEB029 = 'c'                            ",
               " ORDER BY EB.DZEB001                               "
                   
  PREPARE lpre_fill_cust_tables FROM ls_sql
  DECLARE lcur_fill_cust_tables CURSOR FOR lpre_fill_cust_tables

  CALL m_cust_table_scr.clear()
  
  LET li_count = 1
  
  FOREACH lcur_fill_cust_tables INTO m_cust_table_scr[li_count].*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET li_count = li_count + 1
    
  END FOREACH
  CALL m_cust_table_scr.deleteElement(li_count)

END FUNCTION

FUNCTION sadzp250_fill_statistics_tables(p_GUID)
DEFINE
  p_GUID STRING
DEFINE 
  ls_GUID  STRING,
  ls_sql   STRING,
  li_count INTEGER

  LET ls_GUID = p_GUID.trim()

  LET ls_sql = "SELECT T.CNTS                 TCNTS,                                                   ",
               "       P.CNTS                 PCNTS,                                                   ",
               "       DECODE(P.CNTS,0,0,CEIL(T.CNTS / P.CNTS)) T_PER_P,                               ",
               "       ST.MST                 MST,                                                     ",
               "       ET.MET                 MET,                                                     ",
               "       UT.MUT                 MUT,                                                     ",
               "       STUT.STMUT             STMUT                                                    ",
               "  FROM (                                                                               ",
               "         SELECT COUNT(*) CNTS                                                          ",
               "           FROM DZEZ_T EZ                                                              ",
               "          WHERE EZ.DZEZ001 = '",ls_GUID,"'                                             ",
               "       ) T,                                                                            ",
               "       (                                                                               ",
               "         SELECT COUNT(*) CNTS                                                          ",
               "           FROM DZEE_T EE                                                              ",
               "          WHERE EE.DZEE001 = '",ls_GUID,"'                                             ",
               "       ) P,                                                                            ",
               "       (                                                                               ",
               "         SELECT TO_CHAR(MIN(EZ.DZEZ005),'YYYY-MM-DD HH24:MI:SS') MST                   ",
               "           FROM DZEZ_T EZ                                                              ",
               "          WHERE EZ.DZEZ001 = '",ls_GUID,"'                                             ",
               "       ) ST,                                                                           ",
               "       (                                                                               ",
               "         SELECT TO_CHAR(MAX(EZ.DZEZ006),'YYYY-MM-DD HH24:MI:SS') MET                   ",
               "           FROM DZEZ_T EZ                                                              ",
               "          WHERE EZ.DZEZ001 = '",ls_GUID,"'                                             ",
               "       ) ET,                                                                           ",
               "       (                                                                               ",
               "          SELECT TRIM(REPLACE(MAX(EZ.DZEZ006) - MIN(EZ.DZEZ005),'+000000000','')) MUT  ",
               "            FROM DZEZ_T EZ                                                             ",
               "           WHERE EZ.DZEZ001 = '",ls_GUID,"'                                            ",
               "       ) UT,                                                                           ",
               "       (                                                                               ",
               "          SELECT TRIM(REPLACE(MAX(EZ.DZEZ006 - EZ.DZEZ005),'+000000000','')) STMUT     ",
               "            FROM DZEZ_T EZ                                                             ",
               "           WHERE EZ.DZEZ001 = '",ls_GUID,"'                                            ",
               "       ) STUT                                                                          ",
               " WHERE 1=1                                                                             "
                   
  PREPARE lpre_fill_statistics_tables FROM ls_sql
  DECLARE lcur_fill_statistics_tables CURSOR FOR lpre_fill_statistics_tables

  CALL m_statistics_scr.clear()
  
  LET li_count = 1
  
  FOREACH lcur_fill_statistics_tables INTO m_statistics_scr[li_count].*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET li_count = li_count + 1
    
  END FOREACH
  CALL m_statistics_scr.deleteElement(li_count)

END FUNCTION

FUNCTION sadzp250_refill_combobox(p_list_all,p_search)
DEFINE
  p_list_all  BOOLEAN,
  p_search    BOOLEAN
DEFINE
  lb_list_all    BOOLEAN,
  lb_search      BOOLEAN,
  ls_sql         STRING,
  ls_sql_cond    STRING,
  ls_sql_search  STRING

  LET lb_list_all = p_list_all
  LET lb_search = p_search

  IF lb_list_all THEN
    LET ls_sql_cond = ""
  ELSE 
    LET ls_sql_cond = " AND EE.DZEE005 NOT IN ('",cs_state_finished,"','",cs_state_manually,"','",cs_state_cancel,"') "
  END IF

  IF lb_search THEN
    LET ls_sql_search = " AND (                               ",
                        "       DZEE001 = '",ms_search,"'     ",
                        "       OR                            ",
                        "       DZEE001 LIKE '",ms_search,"%' ", 
                        "       OR                            ",
                        "       DZEE003 LIKE '",ms_search,"%' ", 
                        "     )                               "
    
  ELSE
    LET ls_sql_search = ""
  END IF

  LET ls_sql = "SELECT DISTINCT                                             ",
               "       EE.DZEE001                                  DZEEID,  ",
               "       '{'||EE.DZEE003||'}'||'-['||EE.DZEE001||']' DZEELIST ",
               "  FROM DZEE_T EE                                            ",
               " WHERE 1=1                                                  ",
               ls_sql_cond,
               ls_sql_search,
               " ORDER BY 2 DESC                                            "

  CALL sadzp250_find_and_fill_combobox("formonly.cb_guid",ls_sql)

END FUNCTION 

FUNCTION sadzp250_find_and_fill_combobox(p_component_name,p_sql)
DEFINE
  p_component_name STRING,
  p_sql           STRING
DEFINE 
  lo_combobox ui.ComboBox
  
  LET lo_combobox = ui.ComboBox.forName(p_component_name)
  CALL sadzp250_fill_combobox(lo_combobox,p_sql)
  
END FUNCTION

FUNCTION sadzp250_get_combobox_name_by_index(p_component_name,p_index)
DEFINE
  p_component_name STRING,
  p_index          INTEGER
DEFINE 
  lo_combobox ui.ComboBox
DEFINE
  ls_return STRING
  
  LET lo_combobox = ui.ComboBox.forName(p_component_name)
  LET ls_return = lo_combobox.getItemName(p_index)  

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp250_get_combobox_index_by_name(p_component_name,p_name)
DEFINE
  p_component_name STRING,
  p_name           STRING
DEFINE 
  lo_combobox ui.ComboBox
DEFINE
  li_return INTEGER
  
  LET lo_combobox = ui.ComboBox.forName(p_component_name)
  LET li_return = lo_combobox.getIndexOf(p_name)  

  RETURN li_return
  
END FUNCTION

FUNCTION sadzp250_get_combobox_text_by_index(p_component_name,p_index)
DEFINE
  p_component_name STRING,
  p_index          INTEGER
DEFINE 
  lo_combobox ui.ComboBox
DEFINE
  ls_return STRING
  
  LET lo_combobox = ui.ComboBox.forName(p_component_name)
  LET ls_return = lo_combobox.getItemText(p_index)  

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp250_fill_combobox(p_combobox,p_sql)
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

#將畫面上的DZEE_T Screen array (T_DZEE_T_SCR)轉換為 T_DZEE_T
FUNCTION sadzp250_adapter_dzeescr_to_dzee(p_dzee_scr)
DEFINE
  p_dzee_scr T_DZEE_T_SCR
DEFINE
  lo_dzee_scr T_DZEE_T_SCR,
  lo_dzee_t   T_DZEE_T
DEFINE
  lo_return T_DZEE_T

  LET lo_dzee_scr.* = p_dzee_scr.*

  LET lo_dzee_t.DZEE001 = lo_dzee_scr.DZEE001 
  LET lo_dzee_t.DZEE002 = lo_dzee_scr.DZEE002 
  LET lo_dzee_t.DZEE003 = lo_dzee_scr.DZEE003 
  LET lo_dzee_t.DZEE004 = lo_dzee_scr.DZEE004 
  LET lo_dzee_t.DZEE005 = lo_dzee_scr.DZEE005 
  LET lo_dzee_t.DZEE006 = lo_dzee_scr.DZEE006 
  LET lo_dzee_t.DZEE007 = lo_dzee_scr.DZEE007 
  LET lo_dzee_t.DZEE008 = lo_dzee_scr.DZEE008 
  LET lo_dzee_t.DZEE009 = lo_dzee_scr.DZEE009 
  LET lo_dzee_t.DZEE010 = lo_dzee_scr.DZEE010 
  LET lo_dzee_t.DZEE011 = lo_dzee_scr.DZEE011 
  
  LET lo_return.* = lo_dzee_t.*
  
  RETURN lo_return.*
  
END FUNCTION 

FUNCTION sadzp250_refresh_and_refill_data(p_DIALOG,p_initial)
DEFINE
  p_DIALOG   ui.Dialog,
  p_initial  BOOLEAN
DEFINE
  lb_initial  BOOLEAN,
  ls_name     STRING,
  li_index    INTEGER

  LET lb_initial = p_initial
  
  LET ls_name = sadzp250_get_combobox_name_by_index("formonly.cb_guid",1)
  LET li_index = sadzp250_get_combobox_index_by_name("formonly.cb_guid",ls_name)
  IF lb_initial THEN 
    LET ms_patch_full = NVL(ms_GUID,sadzp250_get_combobox_text_by_index("formonly.cb_guid",li_index))
  ELSE
    LET ms_patch_full = sadzp250_get_combobox_text_by_index("formonly.cb_guid",li_index)
  END IF
  LET ms_GUID  = ms_patch_full.subString(ms_patch_full.getIndexOf("[",1)+1,ms_patch_full.getIndexOf("]",1)-1)
  #LET ms_patch = ms_patch_full.subString(1,ms_patch_full.getIndexOf("-",1)-1)
  LET ms_patch  = ms_patch_full.subString(ms_patch_full.getIndexOf("{",1)+1,ms_patch_full.getIndexOf("}",1)-1)
  
END FUNCTION