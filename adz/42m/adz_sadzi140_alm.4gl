&include "../4gl/sadzi140_mcr.inc" 

IMPORT os
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzi140_cnst.inc"
&include "../4gl/sadzi140_type.inc"

DEFINE m_dzlm_list T_DZLM_T

DEFINE mo_sys_info  T_SYS_INFO
DEFINE mo_dzlm_info T_DZLM_INFO

DEFINE ms_sql_modules STRING
DEFINE ms_sql_tables STRING

DEFINE mi_step   INTEGER
DEFINE mb_result BOOLEAN 
                      
FUNCTION sadzi140_alm_run(p_step,p_dzlm_info)
DEFINE
  p_step      INTEGER,
  p_dzlm_info T_DZLM_INFO
DEFINE 
  li_step INTEGER 

  LET mi_step = p_step
  LET mo_dzlm_info.* = p_dzlm_info.*
  
  CALL sadzi140_alm_initialize()
  CALL sadzi140_alm_initial_form()
  CALL sadzi140_alm_start()
  CALL sadzi140_alm_finalize()

  RETURN mb_result, mi_step, mo_dzlm_info.* 
  
END FUNCTION

FUNCTION sadzi140_alm_initialize()
DEFINE
  ls_user STRING
  
  &ifndef DEBUG
    LET mo_sys_info.sys_lang = g_lang
    LET mo_sys_info.sys_user = g_user
    LET mo_sys_info.sys_dept = g_dept
  &else
    CALL FGL_GETENV("USERNAME") RETURNING ls_user
    LET mo_sys_info.sys_lang = cs_default_lang
    LET mo_sys_info.sys_user = ls_user
    LET mo_sys_info.sys_dept = cs_dept
  &endif

  LET mb_result = TRUE

  CALL sadzi140_alm_initial_sql("")
  
END FUNCTION

FUNCTION sadzi140_alm_initial_form()
DEFINE
  lo_combobox  ui.ComboBox

  &ifndef DEBUG
    OPEN WINDOW w_sadzi140_alm WITH FORM cl_ap_formpath("ADZ","sadzi140_alm")
    #CONNECT TO cs_master_db
  &else
    OPEN WINDOW w_sadzi140_alm WITH FORM sadzi140_util_get_form_path("sadzi140_alm")
    #CONNECT TO "local"
  &endif
  
  CURRENT WINDOW IS w_sadzi140_alm

  LET lo_combobox = ui.ComboBox.forName("formonly.cb_modulename")
  CALL sadzi140_alm_fill_combobox(lo_combobox,ms_sql_modules)

END FUNCTION

FUNCTION sadzi140_alm_start()
DEFINE
  ls_replace_arg   STRING,
  ls_combobox_text STRING,
  ls_version       STRING,
  lo_dzlm_info     T_DZLM_INFO,
  lo_dzlm_t        T_DZLM_T,
  lo_combobox      ui.ComboBox

  DIALOG ATTRIBUTES(UNBUFFERED)
    INPUT lo_dzlm_info.* FROM sr_dzlm_list.* ATTRIBUTE(WITHOUT DEFAULTS)
      ON CHANGE cb_ModuleName
        CALL sadzi140_alm_initial_sql(lo_dzlm_info.MODULE_NAME) 
        LET lo_combobox = ui.ComboBox.forName("formonly.cb_tablename")
        CALL sadzi140_alm_fill_combobox(lo_combobox,ms_sql_tables)
        
      ON CHANGE cb_TableName
        LET lo_combobox = ui.ComboBox.forName("formonly.cb_tablename")
        CALL lo_combobox.getTextOf(lo_dzlm_info.TABLE_NAME) RETURNING ls_combobox_text 
        LET ls_version = ls_combobox_text.subString(ls_combobox_text.getIndexOf("[",1) + 1,ls_combobox_text.getIndexOf("]",1)-1)
        CALL sadzi140_alm_get_alm_data(TRUE,mo_sys_info.sys_user,lo_dzlm_info.TABLE_NAME,ls_version,TRUE) RETURNING lo_dzlm_t.*
        LET lo_dzlm_info.TABLE_DESC = lo_dzlm_t.dzlm003
        LET lo_dzlm_info.VERSION    = lo_dzlm_t.dzlm005  
    END INPUT 

    BEFORE DIALOG
      IF NVL(mo_dzlm_info.MODULE_NAME,cs_null_value) <> cs_null_value THEN
        CALL sadzi140_alm_initial_sql(mo_dzlm_info.MODULE_NAME) 
        LET lo_combobox = ui.ComboBox.forName("formonly.cb_tablename")
        CALL sadzi140_alm_fill_combobox(lo_combobox,ms_sql_tables)
        LET lo_dzlm_info.* = mo_dzlm_info.*
      END IF  
      
    ON ACTION btn_next
      IF (NVL(lo_dzlm_info.MODULE_NAME,cs_null_value) = cs_null_value) OR (NVL(lo_dzlm_info.TABLE_NAME,cs_null_value) = cs_null_value) THEN
        LET ls_replace_arg = "|"
        CALL sadzi140_msg_show_error(NULL, 'adz-00176', ls_replace_arg, 1)
        CONTINUE DIALOG
      END IF
      LET mo_dzlm_info.* = lo_dzlm_info.*
      LET mb_result = TRUE
      LET mi_step = mi_step + 1
      EXIT DIALOG

    {  
    ON ACTION btn_ok
      LET mb_result = TRUE
      EXIT DIALOG
    }
    
    ON ACTION btn_Cancel  
      INITIALIZE lo_dzlm_info TO NULL
      INITIALIZE mo_dzlm_info TO NULL
      LET mb_result = FALSE
      EXIT DIALOG
      
    ON ACTION CLOSE
      EXIT DIALOG
      
  END DIALOG

END FUNCTION

FUNCTION sadzi140_alm_finalize()
  CLOSE WINDOW w_sadzi140_alm
END FUNCTION

FUNCTION sadzi140_alm_get_alm_version(p_table_name,p_user)
DEFINE
  p_table_name STRING,
  p_user       STRING
DEFINE
  ls_table_name   STRING,
  ls_user         STRING,
  ls_sql          STRING,
  ls_alm_version  VARCHAR(30),
  ls_return       STRING

  LET ls_table_name = p_table_name
  LET ls_user       = p_user

  #抓取建構版本, 而且只抓簽出的
  LET ls_sql = "SELECT LM.DZLM005                      ",
               "  FROM DZLM_T LM                       ",
               " WHERE LM.DZLM001 = 'TABLE'            ",
               "   AND LM.DZLM002 = '",ls_table_name,"'",
               "   AND LM.DZLM007 = '",ls_user,"'      ",
               "   AND LM.DZLM012 = '1'                "  
                              
  PREPARE lpre_get_alm_version FROM ls_sql
  DECLARE lcur_get_alm_version CURSOR FOR lpre_get_alm_version

  OPEN lcur_get_alm_version
  FETCH lcur_get_alm_version INTO ls_alm_version
  CLOSE lcur_get_alm_version
  
  FREE lpre_get_alm_version
  FREE lcur_get_alm_version  

  LET ls_return = NVL(ls_alm_version,"0")
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi140_alm_fill_combobox(p_combobox,p_sql)
DEFINE 
  p_combobox ui.combobox,
  p_sql      STRING
DEFINE
  ls_sql      STRING,
  li_index    INTEGER,
  li_count    INTEGER, 
  lo_combobox RECORD 
                combobox_name VARCHAR(50),
                combobox_desc VARCHAR(255)
              END RECORD  
  
  LET li_index = 0
  LET ls_sql = p_sql
  
  PREPARE lpre_combobox FROM ls_sql
  DECLARE lcur_combobox SCROLL CURSOR FOR lpre_combobox

  CALL p_combobox.clear()
  
  LET li_count = 1

  FOREACH lcur_combobox INTO lo_combobox.*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    CALL p_combobox.addItem(lo_combobox.combobox_name,lo_combobox.combobox_desc)
    LET li_count = li_count + 1
  END FOREACH

  FREE lcur_combobox
  FREE lpre_combobox

END FUNCTION

FUNCTION sadzi140_alm_initial_sql(p_module)
DEFINE
  p_module STRING
DEFINE
  ls_module    STRING,
  ls_sql_table STRING

  LET ls_module = p_module

  IF NVL(ls_module,cs_null_value) <> cs_null_value THEN
    LET ls_sql_table = " AND LM.DZLM004 = '",ls_module.toUpperCase(),"'"
  ELSE
    LET ls_sql_table = " AND 1=2"
  END IF 

  LET ms_sql_modules = "SELECT DISTINCT                                              ",
                       "       LM.DZLM004                     MODULE_NAME,           ",          
                       "       LM.DZLM004||'. '||ZOL.GZZOL003 MODULE_DESC            ",          
                       "  FROM DZLM_T LM                                             ",          
                       "  LEFT OUTER JOIN GZZOL_T ZOL                                ",
                       "               ON ZOL.GZZOL001 = LM.DZLM004                  ",
                       "              AND ZOL.GZZOL002 = '",mo_sys_info.sys_lang,"'  ",
                       " WHERE EXISTS (                                              ",          
                       "                SELECT 1                                     ",          
                       "                  FROM GZZT_T ZT                             ",          
                       "                 WHERE ZT.GZZT001 = LM.DZLM004               ",         
                       "              )                                              ",
                       "   AND LM.DZLM001 = 'TABLE'                                  ",
                       "   AND LM.DZLM008 = 'W'                                      ",
                       "   AND LM.DZLM012 = '1'                                      ",
                       "   AND NOT EXISTS (                                          ",
                       "                    SELECT 1                                 ",
                       "                      FROM DZEA_T EA                         ",
                       "                     WHERE EA.DZEA001 = LM.DZLM002           ",
                       "                  )                                          ",
                       "   AND LM.DZLM007 = '",mo_sys_info.sys_user,"'               ",                                  
                       " ORDER BY LM.DZLM004                                         "       

  LET ms_sql_tables = "SELECT LM.DZLM002                                         TABLE_NAME,    ",       
                      "       LM.DZLM002||'. '||LM.DZLM003||'['||LM.DZLM005||']' TABLE_DESC     ",       
                      "  FROM DZLM_T LM                                                         ",          
                      " WHERE LM.DZLM001 = 'TABLE'                                              ",
                      "   AND LM.DZLM008 = 'W'                                                  ",
                      "   AND LM.DZLM012 = '1'                                                  ",
                      "   AND NOT EXISTS (                                                      ",
                      "                    SELECT 1                                             ",
                      "                      FROM DZEA_T EA                                     ",
                      "                     WHERE EA.DZEA001 = LM.DZLM002                       ",
                      "                  )                                                      ",
                      "   AND LM.DZLM007 = '",mo_sys_info.sys_user,"'                           ",    
                      ls_sql_table,                      
                      " ORDER BY LM.DZLM002,LM.DZLM005                                          "
                      
END FUNCTION

FUNCTION sadzi140_alm_get_alm_data(p_enable_alm,p_user,p_table_name,p_version,p_check_exist)
DEFINE
  p_enable_alm  BOOLEAN,
  p_user        STRING,
  p_table_name  STRING,
  p_version     STRING,
  p_check_exist BOOLEAN
DEFINE
  lb_enable_alm   BOOLEAN,
  ls_user         STRING,
  ls_table_name   STRING,
  ls_version      STRING,
  lb_check_exist  BOOLEAN,
  ls_sql          STRING,
  ls_sql_where    STRING,
  lo_dzlm_t       T_DZLM_T,
  lo_return       T_DZLM_T

  LET lb_enable_alm  = p_enable_alm
  LET ls_user        = p_user
  LET ls_table_name  = p_table_name
  LET ls_version     = p_version
  LET lb_check_exist = p_check_exist

  INITIALIZE lo_dzlm_t.* TO NULL
  INITIALIZE lo_return.* TO NULL

  IF lb_enable_alm THEN
    IF lb_check_exist THEN
      LET ls_sql_where = " AND NOT EXISTS (                                             ",
                         "                  SELECT 1                                    ",
                         "                    FROM DZEA_T EA                            ",
                         "                   WHERE EA.DZEA001 = LM.DZLM002              ",
                         "                )                                             "
    ELSE
      LET ls_sql_where = " AND 1=1 "
    END IF 

    LET ls_sql  = "SELECT LM.DZLM001,LM.DZLM002,LM.DZLM003,LM.DZLM004,MAX(LM.DZLM005) DZLM005, ",
                  "       LM.DZLM006,LM.DZLM007,LM.DZLM008,LM.DZLM009,LM.DZLM010,              ",
                  "       LM.DZLM011,LM.DZLM012                                                ",         
                  "  FROM DZLM_T LM                                                            ",          
                  " WHERE LM.DZLM001 = 'TABLE'                                                 ",
                  "   AND LM.DZLM008 = 'W'                                                     ",
                  "   AND LM.DZLM012 = '1'                                                     ",
                  ls_sql_where,
                  "   AND LM.DZLM007 = '",ls_user,"'                                           ",
                  "   AND LM.DZLM002 = '",ls_table_name,"'                                     ",    
                  "   AND LM.DZLM005 = NVL('",ls_version,"',LM.DZLM005)                        ",    
                  " GROUP BY LM.DZLM001,LM.DZLM002,LM.DZLM003,LM.DZLM004,LM.DZLM006,           ",
                  "          LM.DZLM007,LM.DZLM008,LM.DZLM009,LM.DZLM010,LM.DZLM011,           ",
                  "          LM.DZLM012                                                        ", 
                  " ORDER BY 2,5                                                               "
  ELSE 
    LET ls_sql  = "SELECT NULL,NULL,NULL,NULL,'",cs_init_alm_ver_code,"',  ",
                  "       NULL,NULL,NULL,NULL,NULL,                        ",
                  "       NULL,NULL                                        ",         
                  "  FROM DUAL                                             "
  END IF   
                              
  PREPARE lpre_get_alm_data FROM ls_sql
  DECLARE lcur_get_alm_data CURSOR FOR lpre_get_alm_data

  OPEN lcur_get_alm_data
  FETCH lcur_get_alm_data INTO lo_dzlm_t.*
  CLOSE lcur_get_alm_data
  
  FREE lpre_get_alm_data
  FREE lcur_get_alm_data  

  #若抓不到ALM的版號, 則取預設值
  LET lo_dzlm_t.DZLM005 = NVL(lo_dzlm_t.DZLM005,cs_init_alm_ver_code)
  LET lo_return.* = lo_dzlm_t.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi140_alm_check_alm_table_exist(p_owner)
DEFINE
  p_owner      STRING
DEFINE
  ls_owner      STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  lb_return     BOOLEAN

  LET ls_owner = NVL(p_owner.toUpperCase(),cs_master_user.toUpperCase())

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                             ",
               "  FROM DBA_OBJECTS DOS                      ",
               " WHERE DOS.OWNER = '",ls_owner,"'           ",
               "   AND DOS.OBJECT_NAME = '",cs_alm_table,"' "

  PREPARE lpre_check_alm_table_exist FROM ls_sql
  DECLARE lcur_check_alm_table_exist CURSOR FOR lpre_check_alm_table_exist
  OPEN lcur_check_alm_table_exist
  FETCH lcur_check_alm_table_exist INTO li_rec_count
  CLOSE lcur_check_alm_table_exist
  FREE lcur_check_alm_table_exist
  FREE lpre_check_alm_table_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION



