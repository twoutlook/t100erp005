&include "../4gl/sadzi180_mcr.inc"

IMPORT util
IMPORT OS 
IMPORT security

SCHEMA ds
#_db, 進行實際表格的異動

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc" 
&include "../4gl/sadzi180_cnst.inc" 

&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzi180_type.inc"

FUNCTION sadzi180_db_connect_db(p_db)
DEFINE 
  p_db STRING

  TRY
    DISCONNECT CURRENT
  CATCH
    DISPLAY "[Hint] No any connection, skip disconnect."
  END TRY  
  
  CONNECT TO p_db
  
END FUNCTION

FUNCTION sadzi180_db_get_parameters(p_level,p_param)
DEFINE
  p_level STRING,
  p_param STRING
DEFINE
  ls_level     STRING,
  ls_param     STRING,
  ls_sql       STRING,
  lo_parameter T_PARAMETERS
DEFINE
  lo_return    T_PARAMETERS

  LET ls_level = p_level
  LET ls_param = p_param

  LET ls_sql = "SELECT EJ.DZEJ005,EJ.DZEJ006,EJ.DZEJ007,EJ.DZEJ008,EJ.DZEJ009 ",
               "  FROM DZEJ_T EJ                                              ",
               " WHERE EJ.DZEJ001 = 'adzi180_parameters'                      ",
               "   AND EJ.DZEJ003 = '",ls_level,"'                            ",
               "   AND EJ.DZEJ004 = '",ls_param,"'                            "
                              
  PREPARE lpre_get_parameter FROM ls_sql
  DECLARE lcur_get_parameter CURSOR FOR lpre_get_parameter

  OPEN lcur_get_parameter
  FETCH lcur_get_parameter INTO lo_parameter.*
  CLOSE lcur_get_parameter
  
  FREE lpre_get_parameter
  FREE lcur_get_parameter  

  LET lo_return.* = lo_parameter.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi180_db_get_db_info()
DEFINE
  lo_db_info T_DB_INFO,
  ls_sql     STRING
DEFINE
  lo_return T_DB_INFO  

  LET ls_sql = "SELECT ORA_DATABASE_NAME, USER ", 
               "  FROM DUAL                    " 

  PREPARE lpre_get_db_info FROM ls_sql
  DECLARE lcur_get_db_info CURSOR FOR lpre_get_db_info

  INITIALIZE lo_db_info TO NULL
  
  OPEN lcur_get_db_info
  FETCH lcur_get_db_info INTO lo_db_info.*
  CLOSE lcur_get_db_info
  
  FREE lpre_get_db_info
  FREE lcur_get_db_info  

  LET lo_return.* = lo_db_info.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi180_db_append_dzia_information(p_dzia_t)
  DEFINE
    p_dzia_t T_DZIA_T
  DEFINE
    lo_dzia_t T_DZIA_T,
    ls_DGENV  STRING
  DEFINE
    lo_return T_DZIA_T

  LET lo_dzia_t.* = p_dzia_t.*

  LET ls_DGENV = FGL_GETENV("DGENV")
  
  LET lo_dzia_t.dzia003 = cs_mdm_module_name
  LET lo_dzia_t.dzia004 = "X"
  LET lo_dzia_t.dzia005 = "N"
  LET lo_dzia_t.dzia006 = "N"
  LET lo_dzia_t.dzia007 = "N"
  LET lo_dzia_t.dzia008 = ""
  LET lo_dzia_t.dzia009 = ""
  LET lo_dzia_t.dzia010 = ""
  LET lo_dzia_t.dzia011 = ""
  LET lo_dzia_t.dzia012 = ""
  LET lo_dzia_t.dzia013 = ""
  LET lo_dzia_t.dzia014 = ""
  LET lo_dzia_t.dzia015 = ls_DGENV
  LET lo_dzia_t.dzia016 = cs_mdm_module_name
  LET lo_dzia_t.dzia017 = "N"
  LET lo_dzia_t.dzia018 = ls_DGENV
  LET lo_dzia_t.dzia019 = ""
  LET lo_dzia_t.dzia020 = ""
  LET lo_dzia_t.dzia021 = ""
  
  LET lo_return.* = lo_dzia_t.*

  RETURN lo_return.* 
  
END FUNCTION

FUNCTION sadzi180_db_append_dzib_information(p_table_name,p_column_list)
  DEFINE
    p_table_name  STRING,
    p_column_list DYNAMIC ARRAY OF T_INTF_COLUMN_LIST
  DEFINE
    ls_table_name  STRING,
    lo_column_list DYNAMIC ARRAY OF T_INTF_COLUMN_LIST,
    lo_temp_dzib_t T_DZIB_T,
    lo_dzib_t      DYNAMIC ARRAY OF T_DZIB_T,
    li_loop        INTEGER,
    ls_DGENV       STRING
  DEFINE
    lo_return DYNAMIC ARRAY OF T_DZIB_T

  LET ls_table_name = p_table_name
  LET lo_column_list = p_column_list

  LET ls_DGENV = FGL_GETENV("DGENV")

  FOR li_loop = 1 TO lo_column_list.getLength()
    CALL sadzi180_db_get_dzib_source_data(lo_column_list[li_loop].*) RETURNING lo_temp_dzib_t.*
    LET lo_dzib_t[li_loop].* = lo_temp_dzib_t.*
    
    LET lo_dzib_t[li_loop].DZIB001 = ls_table_name #Interface 表格名稱
    #欄位代號  --DGW07558 add at 151105
    IF (ls_table_name <> lo_column_list[li_loop].TABLE_NAME) THEN 
      #只有新增項目才需要寫入欄位代號
      LET lo_dzib_t[li_loop].DZIB002 = lo_column_list[li_loop].COLUMN_NAME
      LET lo_dzib_t[li_loop].DZIB003 = lo_column_list[li_loop].COLUMN_DESC
    END IF 
    
    LET lo_dzib_t[li_loop].DZIB021 = li_loop       #欄位序號
    LET lo_dzib_t[li_loop].DZIB028 = "N"
    LET lo_dzib_t[li_loop].DZIB029 = ls_DGENV
    LET lo_dzib_t[li_loop].DZIB030 = ls_DGENV
    LET lo_dzib_t[li_loop].DZIB031 = "N"
    
  END FOR
  
  LET lo_return = lo_dzib_t

  RETURN lo_return 
  
END FUNCTION  

FUNCTION sadzi180_db_get_dzia_information(p_jsonobj)
  DEFINE
    p_jsonobj    util.JSONObject 
    #傳入參數 tablename, stand_cust --DGW07558_add_at201512161500 
  DEFINE 
    ls_table_name STRING,
    ls_stand_cust STRING,
    ls_sqlwhere   STRING,
    ls_sql        STRING,
    lo_dzia_t     T_DZIA_T
  DEFINE
    lo_return  T_DZIA_T

  LET ls_table_name = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL)
  LET ls_stand_cust = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL)

  LET ls_sqlwhere = " WHERE IA.DZIA001 = '",ls_table_name,"' "
  IF (ls_stand_cust IS NOT NULL) 
     AND (ls_stand_cust = cs_dgenv_customize 
         OR ls_stand_cust = cs_dgenv_standard) THEN
    LET ls_sqlwhere = ls_sqlwhere, " AND IA.DZIA015='", ls_stand_cust, "' "
  END IF 
  
  LET ls_sql = " SELECT IA.DZIA001,IA.DZIA002,IA.DZIA003,IA.DZIA004,IA.DZIA005, ",
               "        IA.DZIA006,IA.DZIA007,IA.DZIA008,IA.DZIA009,IA.DZIA010, ",
               "        IA.DZIA011,IA.DZIA012,IA.DZIA013,IA.DZIA014,IA.DZIA015, ",
               "        IA.DZIA016,IA.DZIA017,IA.DZIA018,IA.DZIA019,IA.DZIA020, ",
               "        IA.DZIA021                                              ",
               "   FROM DZIA_T IA                                               ",
               ls_sqlwhere
  
  PREPARE lpre_get_dzia_information FROM ls_sql
  DECLARE lcur_get_dzia_information CURSOR FOR lpre_get_dzia_information
  OPEN lcur_get_dzia_information
  FETCH lcur_get_dzia_information INTO lo_dzia_t.*
  CLOSE lcur_get_dzia_information
  FREE lcur_get_dzia_information
  FREE lpre_get_dzia_information

  LET lo_return.* = lo_dzia_t.*

  RETURN lo_return.*
  
END FUNCTION 

FUNCTION sadzi180_db_get_dzib_information(p_jsonobj)
  DEFINE
    p_jsonobj    util.JSONObject 
    #傳入參數 tablename, stand_cust --DGW07558_add_at201512161500 
  DEFINE
    ls_table_name STRING,
    ls_stand_cust STRING,
    ls_sqlwhere   STRING,
    ls_sql        STRING,
    li_rec_cnt    INTEGER,
    lo_dzib_t     DYNAMIC ARRAY OF T_DZIB_T
  DEFINE
    lo_return  DYNAMIC ARRAY OF T_DZIB_T

  LET ls_table_name = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL)
  LET ls_stand_cust = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL)

  LET ls_sqlwhere = " WHERE IB.DZIB001 = '",ls_table_name,"' "
  IF (ls_stand_cust IS NOT NULL) 
     AND (ls_stand_cust = cs_dgenv_customize 
         OR ls_stand_cust = cs_dgenv_standard) THEN
    LET ls_sqlwhere = ls_sqlwhere, " AND IB.DZIB029='", ls_stand_cust, "' "
  END IF
  
  LET ls_sql = " SELECT IB.DZIB001,IB.DZIB002,IB.DZIB003,IB.DZIB004,IB.DZIB005, ",
               "        IB.DZIB006,IB.DZIB007,IB.DZIB008,IB.DZIB012,IB.DZIB021, ",
               "        IB.DZIB022,IB.DZIB023,IB.DZIB024,IB.DZIB027,IB.DZIB028, ",
               "        IB.DZIB029,IB.DZIB030,IB.DZIB031                        ",
               "   FROM DZIB_T IB                                               ",
               ls_sqlwhere,
               " ORDER BY DZIBMODDT,IB.DZIB021,IB.DZIB002                       " # --DGW07558_mod at20151105

  PREPARE lpre_get_dzib_information FROM ls_sql
  DECLARE lcur_get_dzib_information CURSOR FOR lpre_get_dzib_information
  
  LET li_rec_cnt = 1
  OPEN lcur_get_dzib_information
  FOREACH lcur_get_dzib_information INTO lo_dzib_t[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_dzib_information
  CALL lo_dzib_t.deleteElement(li_rec_cnt)
  
  FREE lcur_get_dzib_information
  FREE lpre_get_dzib_information

  LET lo_return = lo_dzib_t

  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzi180_db_get_dzib_source_data(p_column_list)
  DEFINE
    p_column_list T_INTF_COLUMN_LIST
  DEFINE
    lo_column_list T_INTF_COLUMN_LIST,
    lo_dzib_t      T_DZIB_T,
    ls_sql         STRING
  DEFINE
    lo_return  T_DZIB_T

  LET lo_column_list.* = p_column_list.*

  LET ls_sql = " SELECT EB.DZEB001,EB.DZEB002,EB.DZEB003,EB.DZEB004,EB.DZEB005,                      ",
               "        EB.DZEB006,EB.DZEB007,EB.DZEB008,EB.DZEB012,EB.DZEB021,                      ",
               "        EB.DZEB022,EB.DZEB023,EB.DZEB024,EB.DZEB027,EB.DZEB028,                      ",
               "        EB.DZEB029,EB.DZEB030,EB.DZEB031                                             ",
               "   FROM DZEB_T EB                                                                    ",
               "  WHERE EB.DZEB001 = '",lo_column_list.TABLE_NAME,"'                                 ",
               "    AND EB.DZEB002 = '",lo_column_list.COLUMN_NAME1,"'                                ",
               " UNION ALL                                                                           ", 
               " SELECT *                                                                            ", 
               "   FROM (                                                                            ", 
               "         SELECT '",cs_mdm_virtual_table,"'  DZEB001,                                 ", 
               "                EK.DZEK002                  DZEB002,                                 ", 
               "                EK.DZEK005                  DZEB003,                                 ", 
               "                EK.DZEK003                  DZEB004,                                 ", 
               "                EK.DZEK003                  DZEB005,                                 ", 
               "                EK.DZEK004                  DZEB006,                                 ", 
               "                TD.GZTD003                  DZEB007,                                 ", 
               "                TD.GZTD008                  DZEB008,                                 ", 
               "                NULL                        DZEB012,                                 ", 
               "                EK.DZEK006                  DZEB021,                                 ", 
               "                EK.DZEK001                  DZEB022,                                 ", 
               "                NULL                        DZEB023,                                 ", 
               "                NULL                        DZEB024,                                 ", 
               "                NULL                        DZEB027,                                 ", 
               "                'Y'                         DZEB028,                                 ", 
               "                's'                         DZEB029,                                 ", 
               "                's'                         DZEB030,                                 ", 
               "                'N'                         DZEB031                                  ", 
               "           FROM DZEK_T EK                                                            ", 
               "           LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EK.DZEK004                      ", 
               "          WHERE EK.DZEK001 IN (                                                      ",
               "                                'cdfErpStatus',                                      ",
               "                                'cdfMDMStatus',                                      ",
               "                                'cdfBTime',                                          ",
               "                                'cdfTaskNo',                                         ",
               "                                'cdfErpOldStatus'                                    ",
               "                              )                                                      ",  
               "          ORDER BY EK.DZEK006                                                        ", 
               "        ) MDM_DATA                                                                   ", 
               "  WHERE UPPER('",cs_mdm_virtual_table,"') = UPPER('",lo_column_list.TABLE_NAME,"')   ", 
               "    AND UPPER(MDM_DATA.DZEB002) = UPPER('",lo_column_list.COLUMN_NAME1,"')           ", 
               " UNION ALL                                                                           ", 
               " SELECT *                                                                            ", 
               "   FROM (                                                                            ", 
               "         SELECT '",cs_plm_virtual_table,"'  DZEB001,                                 ", 
               "                EK.DZEK002                  DZEB002,                                 ", 
               "                EK.DZEK005                  DZEB003,                                 ", 
               "                EK.DZEK003                  DZEB004,                                 ", 
               "                EK.DZEK003                  DZEB005,                                 ", 
               "                EK.DZEK004                  DZEB006,                                 ", 
               "                TD.GZTD003                  DZEB007,                                 ", 
               "                TD.GZTD008                  DZEB008,                                 ", 
               "                NULL                        DZEB012,                                 ", 
               "                EK.DZEK006                  DZEB021,                                 ", 
               "                EK.DZEK001                  DZEB022,                                 ", 
               "                NULL                        DZEB023,                                 ", 
               "                NULL                        DZEB024,                                 ", 
               "                NULL                        DZEB027,                                 ", 
               "                'Y'                         DZEB028,                                 ", 
               "                's'                         DZEB029,                                 ", 
               "                's'                         DZEB030,                                 ", 
               "                'N'                         DZEB031                                  ", 
               "           FROM DZEK_T EK                                                            ", 
               "           LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EK.DZEK004                      ", 
               "          WHERE EK.DZEK001 IN (                                                      ", 
               "                                'cdfPLMPrimaryKey',                                  ",
               "                                'cdfEnterpriseID',                                   ",
               "                                'cdfPLMLanguage',                                    ",
               "                                'cdfPLMUser',                                        ",
               "                                'cdfSequenceKey',                                    ",
               "                                'cdfSequenceKeySubCount',                            ",
               "                                'cdfDataKey',                                        ",
               "                                'cdfDataKeyTotalCount',                              ",
               "                                'cdfDataKeySubCount',                                ",
               "                                'cdfActionType'                                      ",
               "                              )                                                      ",  
               "          ORDER BY EK.DZEK006                                                        ", 
               "        ) MDM_DATA                                                                   ", 
               "  WHERE UPPER('",cs_plm_virtual_table,"') = UPPER('",lo_column_list.TABLE_NAME,"')   ", 
               "    AND UPPER(MDM_DATA.DZEB002) = UPPER('",lo_column_list.COLUMN_NAME1,"')           " 
  
  PREPARE lpre_get_dzib_source_data FROM ls_sql
  DECLARE lcur_get_dzib_source_data CURSOR FOR lpre_get_dzib_source_data
  OPEN lcur_get_dzib_source_data
  FETCH lcur_get_dzib_source_data INTO lo_dzib_t.*
  CLOSE lcur_get_dzib_source_data
  FREE lcur_get_dzib_source_data
  FREE lpre_get_dzib_source_data

  LET lo_return.* = lo_dzib_t.*

  RETURN lo_return.*
  
END FUNCTION 

FUNCTION sadzi180_db_append_dziu_information(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE
  ls_table_name  STRING,
  lo_dziu_t      DYNAMIC ARRAY OF T_DZIU_T,
  lo_mdm_data    DYNAMIC ARRAY OF T_MDM_DATA,
  lo_main_mdm    T_MDM_DATA,
  ls_object_type STRING,
  li_loop        INTEGER,
  li_sequence    INTEGER,
  ls_DGENV       STRING
DEFINE
  lo_return DYNAMIC ARRAY OF T_DZIU_T

  LET ls_table_name = p_table_name
  
  LET ls_DGENV = FGL_GETENV("DGENV")

  INITIALIZE lo_dziu_t TO NULL
  INITIALIZE lo_mdm_data TO NULL

  #取得MDM預設的目的及需求端資料庫資料
  CALL sadzi180_db_get_mdm_default_data() RETURNING lo_mdm_data

  FOR li_loop = 1 TO lo_mdm_data.getLength()
    LET lo_dziu_t[li_loop].DZIU001 = ls_table_name
    LET lo_dziu_t[li_loop].DZIU002 = lo_mdm_data[li_loop].md_DB_USER
    #判斷物件型態該為表格或同義字
    CASE 
      WHEN lo_mdm_data[li_loop].md_TYPE = cs_param_mdm_db
        LET ls_object_type = cs_table_shorthand
        LET li_sequence    = 0
        LET lo_main_mdm.*  = lo_mdm_data[li_loop].*
      WHEN lo_mdm_data[li_loop].md_TYPE = cs_param_trigger_db
        LET ls_object_type = cs_synonym_shorthand
        LET li_sequence    = li_loop
    END CASE  
    LET lo_dziu_t[li_loop].DZIU003 = ls_object_type
    LET lo_dziu_t[li_loop].DZIU004 = "Y"
    LET lo_dziu_t[li_loop].DZIU005 = li_sequence
    
  END FOR

  LET lo_return = lo_dziu_t

  RETURN lo_return 
  
END FUNCTION  

FUNCTION sadzi180_db_get_mdm_default_data()
DEFINE
  ls_sql          STRING,
  li_rec_cnt      INTEGER,
  lo_default_data DYNAMIC ARRAY OF T_MDM_DATA
DEFINE
  lo_return DYNAMIC ARRAY OF T_MDM_DATA

  LET li_rec_cnt = 1

  #暫定先從DZEJ取得, 之後可以再擴大
  LET ls_sql = "SELECT EJ.DZEJ004,EJ.DZEJ006,EJ.DZEJ007            ",
               "  FROM DZEJ_T EJ                                   ",
               " WHERE EJ.DZEJ001 = 'adzi180_parameters'           ",
               "   AND EJ.DZEJ003 = '",cs_param_level_db_define,"' ",
               " ORDER BY TO_NUMBER(EJ.DZEJ002)                    "
                              
  PREPARE lpre_get_mdm_default_data FROM ls_sql
  DECLARE lcur_get_mdm_default_data CURSOR FOR lpre_get_mdm_default_data

  OPEN lcur_get_mdm_default_data
  FOREACH lcur_get_mdm_default_data INTO lo_default_data[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_mdm_default_data
  CALL lo_default_data.deleteElement(li_rec_cnt)
  
  FREE lpre_get_mdm_default_data
  FREE lcur_get_mdm_default_data  

  LET lo_return = lo_default_data
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi180_db_get_object_information(p_object_name)
DEFINE 
  p_object_name STRING
DEFINE
  ls_object_name  STRING,
  ls_sql          STRING,
  li_rec_cnt      INTEGER,         
  lo_object_info  DYNAMIC ARRAY OF T_DZIU_T
DEFINE  
  lo_return DYNAMIC ARRAY OF T_DZIU_T

  LET ls_object_name = p_object_name
  
  LET li_rec_cnt = 1
  
  LET ls_sql = "SELECT EU.DZIU001,EU.DZIU002,EU.DZIU003,EU.DZIU004,EU.DZIU005  ",
               "  FROM DZIU_T EU                                               ",
               " WHERE EU.DZIU001 = '",ls_object_name,"'                       ",
               "   AND EU.DZIU004 = 'Y'                                        ",
               " ORDER BY EU.DZIU005 ASC,EU.DZIU003 DESC                       "
                              
  PREPARE lpre_get_object_information FROM ls_sql
  DECLARE lcur_get_object_information CURSOR FOR lpre_get_object_information

  OPEN lcur_get_object_information
  FOREACH lcur_get_object_information INTO lo_object_info[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_object_information
  CALL lo_object_info.deleteElement(li_rec_cnt)
  
  FREE lpre_get_object_information
  FREE lcur_get_object_information  

  LET lo_return.* = lo_object_info.*
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi180_db_get_db_connect_string(p_db_name)
DEFINE
  p_db_name STRING
DEFINE
  ls_db_name      STRING,
  ls_db_sid       STRING,
  ls_privacy_word STRING,
  lb_success      BOOLEAN,
  lo_db_connstr   T_DB_CONNSTR,
  ls_sql          STRING
DEFINE
  lo_return T_DB_CONNSTR  
  
  LET ls_db_name = p_db_name

  LET ls_db_sid = FGL_GETENV("ORACLE_SID")
  
  LET ls_sql = "SELECT '",ls_db_sid,"'  DB_SOURCE,       ",
               "       DA.GZDA003       DB_USERNAME,     ",
               "       DA.GZDA004       DB_PASSWORD,     ",
               "       DA.GZDA001       DB_SCHEMA,       ",
               "       '",ls_db_sid,"'  DB_SID,          ",
               "       ''               DB_SQL_FILENAME, ",
               "       ''               DB_VERSION       ",
               "  FROM GZDA_T DA                         ",
               " WHERE 1=1                               ",
               "   AND DA.GZDA001  = '",ls_db_name,"'    ",
               "   AND DA.GZDA005  = 'M'                 ", 
               "   AND DA.GZDASTUS = 'Y'                 "

  PREPARE lpre_get_db_connect_string FROM ls_sql
  DECLARE lcur_get_db_connect_string CURSOR FOR lpre_get_db_connect_string

  INITIALIZE lo_db_connstr TO NULL
  
  OPEN lcur_get_db_connect_string
  FETCH lcur_get_db_connect_string INTO lo_db_connstr.*
  CLOSE lcur_get_db_connect_string

  &ifndef DEBUG
  IF (NVL(lo_db_connstr.db_username,cs_null_value) = cs_master_db) THEN
    CALL sadzi140_db_get_privacy_word() RETURNING lb_success,ls_privacy_word
    IF lb_success THEN 
      LET lo_db_connstr.db_password = cl_hashkey_base65_anti(ls_privacy_word)
    ELSE 
      LET lo_db_connstr.db_password = cl_hashkey_base65_anti(lo_db_connstr.db_password)
    END IF 
  ELSE 
    IF lo_db_connstr.db_username IS NOT NULL THEN 
      LET lo_db_connstr.db_password = cl_hashkey_base65_anti(lo_db_connstr.db_password)
    END IF  
  END IF 
  &endif
  
  FREE lpre_get_db_connect_string
  FREE lcur_get_db_connect_string  

  LET lo_return.* = lo_db_connstr.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi180_db_get_create_dummy_table_sql(p_create_table)
DEFINE 
  p_create_table  T_DZIA_T
DEFINE
  lo_create_table T_DZIA_T,
  ls_sql          STRING,
  ls_table_space  STRING,
  ls_comment      STRING,
  ls_return       STRING

  LET lo_create_table.* = p_create_table.* 

  LET ls_sql = ""
  
  LET ls_table_space = ""
  LET ls_comment     = ""

  #指定 Tablespace 
  IF NVL(lo_create_table.DZIA010 CLIPPED,cs_null_value) <> cs_null_value AND lo_create_table.DZIA010 CLIPPED <> ""
     AND lo_create_table.DZIA010 CLIPPED <> " " THEN
    LET ls_table_space = "TABLESPACE ",
                        lo_create_table.DZIA010
  END IF

  LET ls_sql = "CREATE TABLE"," ",
               lo_create_table.DZIA001," ",
               ls_table_space," ", 
               "AS SELECT * FROM DUMMY WHERE 1=2",
               ";"

  #Table的說明             
  IF NOT NVL(lo_create_table.DZIA002,cs_null_value) = cs_null_value THEN
    LET ls_comment = "COMMENT ON TABLE ",lo_create_table.DZIA001,"  IS '",lo_create_table.DZIA002,"'",
                     ";"
  END IF

  LET ls_return = ls_sql,"\n",
                  ls_comment 
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi180_db_get_check_synonym_sql(p_synonym_name)
DEFINE 
  p_synonym_name STRING
DEFINE
  ls_synonym_name STRING,
  ls_sql           STRING,
  ls_return        STRING

  LET ls_synonym_name = p_synonym_name
  
  LET ls_sql = "SELECT 1 FROM ",ls_synonym_name," WHERE 1=2",
               ";"

  LET ls_return = ls_sql
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi180_db_get_drop_dummy_column_sql(p_table_name)
DEFINE 
  p_table_name STRING
DEFINE
  ls_table_name STRING,
  ls_sql           STRING,
  ls_return        STRING

  LET ls_table_name = p_table_name

  -- alter table ZZZZ_T drop column DUMMY;
  LET ls_sql = "ALTER TABLE ",ls_table_name," DROP COLUMN DUMMY",
               ";"

  LET ls_return = ls_sql
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi180_db_gen_table_grant(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_line          STRING,
  ls_sql           STRING,
  ls_table_name    STRING,
  lo_line_str_buf  base.StringBuffer,
  lo_table_grant RECORD
                   privileges_name   VARCHAR(30),
                   privileges_user   VARCHAR(30)
                 END RECORD
DEFINE
  ls_Return STRING               

  LET ls_table_name   = p_table_name
  LET lo_line_str_buf = base.StringBuffer.create()

  LET ls_sql = "SELECT BJ.DZEJ005 privileges_name, ",
               --"       BJ.DZEJ006 privileges_user  ", 
               "       'PUBLIC'   privileges_user  ", 
               "  FROM DZEJ_T BJ                   ", 
               " WHERE BJ.DZEJ001 = 'TABLE_GRANTS' ", 
               " ORDER BY BJ.DZEJ002               "

  PREPARE lpre_gen_table_grant FROM ls_sql
  DECLARE lcur_gen_table_grant CURSOR FOR lpre_gen_table_grant

  OPEN lcur_gen_table_grant
  FOREACH lcur_gen_table_grant INTO lo_table_grant.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_line = "grant ",lo_table_grant.privileges_name,
                  " on ",ls_table_name,
                  " to ",lo_table_grant.privileges_user,";","\n"
    CALL lo_line_str_buf.append(ls_line)

  END FOREACH
  CLOSE lcur_gen_table_grant
  
  FREE lpre_gen_table_grant
  FREE lcur_gen_table_grant  

  LET ls_Return = lo_line_str_buf.toString()

  RETURN ls_Return
                  
END FUNCTION

FUNCTION sadzi180_db_sqlplus(p_db_connstr)
DEFINE
  p_db_connstr T_DB_CONNSTR
DEFINE
  lo_db_connstr  T_DB_CONNSTR,
  ls_sqlplus_str STRING,
  ls_message     STRING,
  ls_log_file    STRING,
  ls_file_list   STRING,
  ls_return      STRING

  LET lo_db_connstr.* = p_db_connstr.*

  LET ls_sqlplus_str = "sqlplus ",lo_DB_CONNSTR.db_username,"/",lo_DB_CONNSTR.db_password,"@",lo_DB_CONNSTR.db_sid||" @"||lo_DB_CONNSTR.db_sql_filename

  CALL sadzi180_db_run_and_catch_log(ls_sqlplus_str) RETURNING ls_message
  CALL sadzi180_db_gen_log_file(ls_Message) RETURNING ls_log_file

  LET ls_file_list = ls_file_list,"SQL File : ",lo_DB_CONNSTR.db_sql_filename,"\n"
  LET ls_file_list = ls_file_list,"Log File : ",ls_log_file,"\n"
  LET ls_file_list = ls_file_list,ls_message
  
  LET ls_return = ls_file_list
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzi180_db_run_and_catch_log(p_command)
DEFINE 
  p_command   STRING  #要執行的指令
DEFINE  
  ls_command  STRING, #要執行的指令
  ls_return   STRING,
  ls_cmd_line STRING,
  ls_message  STRING,
  li_log_line INTEGER,
  lch_read    base.Channel   

  LET ls_command = p_command   
  
  LET ls_message  = ""
  LET li_log_line = 0

  LET lch_read  = base.Channel.create()
  CALL lch_read.setDelimiter("")

  #LET ls_command = ls_command||" 2>&1"
  
  CALL lch_read.openPipe(ls_command, "r")
  WHILE TRUE
    LET ls_cmd_line = lch_read.readLine()
    IF lch_read.isEof() THEN 
      EXIT WHILE 
    END IF

    LET li_log_line = li_log_line + 1 
    LET ls_message = ls_message, 
                     "[",(li_log_line USING "&&&&"),"] ",ls_cmd_line, "\n"
    LET ls_cmd_line = ls_cmd_line.toUpperCase()

  END WHILE
  CALL lch_read.close()

  LET ls_return = ls_message
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi180_db_gen_log_file(p_log)
DEFINE
  p_log      STRING
DEFINE
  ls_log           STRING, 
  ls_GUID   STRING,
  ls_temp_dir      STRING,
  lchannel_write   base.Channel,
  ls_log_filename  STRING,
  ls_return        STRING,
  ls_separator     STRING
  
  LET ls_log      = p_log

  LET ls_separator = os.Path.separator()
  
  LET ls_temp_dir = FGL_GETENV("TEMPDIR")
  
  CALL sadzi180_util_get_GUID() RETURNING ls_GUID
  
  LET ls_log_filename = ls_temp_dir,ls_separator,"sadzi180_db_",ls_GUID,".log"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  LET ls_log = ls_log
  
  #開檔寫入
  TRY
    CALL lchannel_write.openFile(ls_log_filename, "w" )
    CALL lchannel_write.write(ls_log)
    #關檔
    CALL lchannel_write.close()
  CATCH
    DISPLAY "Generate log Error : ",ls_log_filename
  END TRY  

  LET ls_return = ls_log_filename

  RETURN ls_return

END FUNCTION

FUNCTION sadzi180_db_get_alter_column_sql(p_create_table)
DEFINE 
  p_create_table  T_DZIA_T
DEFINE
  lo_create_table   T_DZIA_T,
  lo_alter_columns  DYNAMIC ARRAY OF T_COLUMN_ALTER,
  li_rec_cnt        INTEGER,
  ls_table_name     STRING,
  ls_std_cust       STRING,   #標準或者客制
  ls_sqlwhere       STRING,
  ls_sql            STRING,
  ls_alter_type     STRING,
  ls_alter_script   STRING,
  ls_alter_sql      STRING,
  ls_data_type      STRING
DEFINE  
  ls_return      STRING

  LET lo_create_table.* = p_create_table.*

  LET ls_table_name = lo_create_table.DZIA001
  LET ls_std_cust   = lo_create_table.DZIA015

  LET ls_sqlwhere = " WHERE IB.DZIB001 = '",ls_table_name.toLowerCase(),"' "
  IF (ls_std_cust IS NOT NULL) AND 
     (ls_std_cust = cs_dgenv_customize OR ls_std_cust = cs_dgenv_standard) THEN
    LET ls_sqlwhere = ls_sqlwhere, " AND IB.DZIB029 = '", ls_std_cust, "' "
  END IF 
  
  LET ls_alter_type   = ""
  LET ls_alter_script = ""
  LET ls_alter_sql    = ""
  
  LET ls_sql = "SELECT UPPER(IB.DZIB002)                      DZIB002, ",
               "       IB.DZIB004                             DZIB004, ",
               "       DECODE(IB.DZIB004,'Y','N','N','Y','Y') DZIB005, ",
               "       UPPER(TD.GZTD003)                      DZIB007, ",
               "       DECODE(                                         ",
               "              UPPER(TD.GZTD003),                       ",
               "              'BLOB','4000',                           ",
               "              'CLOB','4000',                           ",
               "              'DATE','7',                              ",
               "              TD.GZTD008                               ",
               "             )                                DZIB008, ",
               "       TRIM(IB.DZIB012)                       DZIB012  ",
               "  FROM DZIB_T IB                                       ",
               "  LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = IB.DZIB006 ",
               ls_sqlwhere,
               " ORDER BY IB.DZIB021                                   "
               
  PREPARE lpre_get_alter_column_sql FROM ls_sql
  DECLARE lcur_get_alter_column_sql CURSOR FOR lpre_get_alter_column_sql

  LET li_rec_cnt = 1
  
  OPEN lcur_get_alter_column_sql
  FOREACH lcur_get_alter_column_sql INTO lo_alter_columns[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_alter_type = cs_alter_type_add 

    IF (lo_alter_columns[li_rec_cnt].DZIB007 = 'DATE') OR 
       (lo_alter_columns[li_rec_cnt].DZIB007 = 'CLOB') OR 
       (lo_alter_columns[li_rec_cnt].DZIB007 = 'BLOB') THEN
      LET ls_data_type = lo_alter_columns[li_rec_cnt].DZIB007
    ELSE      
      LET ls_data_type = lo_alter_columns[li_rec_cnt].DZIB007,"(",lo_alter_columns[li_rec_cnt].DZIB008,")"
    END IF

    LET ls_alter_script = "ALTER TABLE", cs_SPACE,
                          ls_table_name, cs_SPACE,
                          ls_alter_type, cs_SPACE,
                          lo_alter_columns[li_rec_cnt].DZIB002, cs_SPACE,
                          ls_data_type,
                          ";","\n"

    LET ls_alter_sql = ls_alter_sql,ls_alter_script
    
    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_alter_column_sql
  CALL lo_alter_columns.deleteElement(li_rec_cnt)
  
  FREE lpre_get_alter_column_sql
  FREE lcur_get_alter_column_sql  

  LET ls_return = ls_alter_sql
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi180_db_get_alter_constraint_sql(p_create_table)
DEFINE 
  p_create_table  T_DZIA_T
DEFINE
  lo_create_table     T_DZIA_T,
  lo_alter_constraint DYNAMIC ARRAY OF T_TABLE_CONSTRAINT,
  li_loop             INTEGER, 
  li_rec_cnt          INTEGER,
  ls_constraints      STRING,
  ls_sql              STRING,
  ls_sqlwhere         STRING,
  ls_line             STRING,
  ls_table_name       STRING,
  lb_constraint_exist   BOOLEAN,
  ls_key_type           STRING,
  ls_references         STRING,
  ls_enable_foreign_key STRING,
  ls_foreign_key_state  STRING,
  lo_string_buffer    base.StringBuffer
DEFINE  
  ls_return STRING

  LET lo_create_table.* = p_create_table.*

  LET ls_table_name = lo_create_table.DZIA001
  
  LET lo_string_buffer = base.StringBuffer.create()
  
  LET ls_sqlwhere = " WHERE IB.DZIB001 = '",ls_table_name.toLowerCase(), "' ",
                    "   AND IB.DZIB004 = 'Y' "
  #判斷客制或者標準
  IF (lo_create_table.DZIA015 IS NOT NULL) AND 
     (lo_create_table.DZIA015 = cs_dgenv_customize OR 
      lo_create_table.DZIA015 = cs_dgenv_standard) THEN
    LET ls_sqlwhere = ls_sqlwhere, 
                      " AND IB.DZIB029 = '", lo_create_table.DZIA015, "' "
  END IF 
  
  LET ls_sql = "SELECT IB.DZIB001        tc_TABLE_NAME,                                      ",
               "       IB.DZIB001||'_PK' tc_CONSTRAINT_NAME,                                 ",
               "       'P'               tc_CONSTRAINT_TYPE,                                 ",
               "       LISTAGG(IB.DZIB002,',') WITHIN GROUP (ORDER BY IB.DZIB021) tc_COLUMNS ",
               "  FROM DZIB_T IB                                                             ",
               ls_sqlwhere,
               " GROUP BY IB.DZIB001,IB.DZIB001||'_PK'                                       "
  
  PREPARE lpre_get_alter_constraint_sql FROM ls_sql
  DECLARE lcur_get_alter_constraint_sql CURSOR FOR lpre_get_alter_constraint_sql

  LET li_rec_cnt = 1
  
  OPEN lcur_get_alter_constraint_sql
  FOREACH lcur_get_alter_constraint_sql INTO lo_alter_constraint[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_Line = ""

    IF NVL(lo_alter_constraint[li_rec_cnt].tc_CONSTRAINT_TYPE,cs_null_value) = "P" THEN
      LET ls_key_type = "primary key";
      LET ls_references = ""
    END IF

    #Example
    #Add
    --alter table ITMML_T add constraint itmml_pk primary key (ITMMLENT, ITMML001);
    --alter table ITMML_T add constraint itmml_fk foreign key (ITMMLENT) references itmm_t (ITMMENT) ON DELETE CASCADE DISABLE;
    --alter table ITMML_T add constraint itmml_uk unique (ITMML003);    
    #Drop
    --alter table ITMML_T drop constraint ITMML_PK CASCADE;
    --alter table ITMML_T drop constraint ITMML_FK;
  
    LET ls_Line = ls_Line,
                  "alter table ",lo_alter_constraint[li_rec_cnt].tc_TABLE_NAME,
                  " add constraint ",lo_alter_constraint[li_rec_cnt].tc_CONSTRAINT_NAME," ",ls_key_type,
                  " (",lo_alter_constraint[li_rec_cnt].tc_COLUMNS,") ",ls_references,";","\n"
                  
    CALL lo_string_buffer.append(ls_Line)

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_alter_constraint_sql
  CALL lo_alter_constraint.deleteElement(li_rec_cnt)
  
  FREE lpre_get_alter_constraint_sql
  FREE lcur_get_alter_constraint_sql  

  LET ls_return = lo_string_buffer.toString()
 
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi180_db_exec_SQL(p_sql,p_batch_mode)
DEFINE
  p_sql STRING,
  p_batch_mode BOOLEAN
DEFINE
  ls_sql         STRING,
  lb_batch_mode  BOOLEAN,
  ls_replace_arg STRING
DEFINE
  lb_return BOOLEAN 

  LET ls_sql = p_sql
  LET lb_batch_mode = p_batch_mode

  LET lb_return = TRUE
  
  BEGIN WORK

  TRY
    PREPARE lpre_exec_sql FROM ls_sql
    EXECUTE lpre_exec_sql
    COMMIT WORK
  CATCH
    CALL sadzi190_msg_message_box("Error","dialog","執行 SQL"||ls_sql||" 失敗.","stop")
    ROLLBACK WORK
  END TRY  

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi180_db_exec_SQL_no_commit(p_sql,p_batch_mode)
DEFINE
  p_sql STRING,
  p_batch_mode BOOLEAN
DEFINE
  ls_sql         STRING,
  lb_batch_mode  BOOLEAN,
  ls_replace_arg STRING
DEFINE
  lb_return BOOLEAN 
  
  LET ls_sql = p_sql
  LET lb_batch_mode = p_batch_mode

  LET lb_return = TRUE
  
  TRY
    PREPARE lpre_exec_SQL_no_commit FROM ls_sql
    EXECUTE lpre_exec_SQL_no_commit
  CATCH
    LET lb_return = FALSE
    IF lb_batch_mode THEN
      DISPLAY cs_error_tag,"Execute SQL ",ls_sql," not success."
    ELSE 
      CALL sadzi190_msg_message_box("Error","dialog","執行 SQL"||ls_sql||" 失敗.","stop")
    END IF 
  END TRY 
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi180_db_gen_drop_script(p_table_name,p_type)
DEFINE
  p_table_name  STRING,
  p_type        STRING
DEFINE
  ##########################
  ls_drop_script         STRING,
  ls_drop_rebuild_script STRING,
  ls_exit_sign           STRING,
  ls_drop_full           STRING,
  ls_object_type         STRING,
  ##########################
  ls_table_name       STRING,
  ls_type             STRING,
  ls_GUID             STRING,
  ls_tempdir          STRING,
  lchannel_write      base.Channel,
  ls_sript_filename   STRING,
  ls_procedure_script STRING,
  ls_separator        STRING 
DEFINE
  ls_return STRING  
  
  LET ls_table_name = p_table_name
  LET ls_type       = p_type

  LET ls_separator = os.Path.separator()
  
  LET ls_tempdir = FGL_GETENV("TEMPDIR")
  CALL sadzi180_util_get_GUID() RETURNING ls_GUID 
  LET ls_sript_filename = ls_tempdir,ls_separator,"sadzi180_drop_",ls_table_name,"_",ls_GUID,".drp"
  
  LET ls_exit_sign = "exit;"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  IF ls_type = 'T' THEN
    LET ls_object_type = "TABLE"
    LET ls_drop_script = "DROP TABLE ",ls_table_name," CASCADE CONSTRAINTS"
  ELSE
    LET ls_object_type = "SYNONYM"
    LET ls_drop_script = "DROP SYNONYM ",ls_table_name
  END IF

  LET ls_procedure_script = "-- Drop table or synonym procedure.                         ","\n",
                            "SET SERVEROUTPUT ON                                         ","\n",
                            "DECLARE                                                     ","\n",
                            "  ls_SQL        VARCHAR2(1024);                             ","\n",
                            "BEGIN                                                       ","\n",
                            "   DBMS_OUTPUT.ENABLE(100000);                              ","\n",
                            "                                                            ","\n",
                            "   ls_SQL := '",ls_drop_script,"';                          ","\n",
                            "                                                            ","\n",
                            "   BEGIN                                                    ","\n",
                            "     EXECUTE IMMEDIATE ls_SQL;                              ","\n",
                            "     DBMS_OUTPUT.PUT_LINE('[Message] Drop table success.'); ","\n",          
                            "   EXCEPTION                                                ","\n",
                            "     WHEN OTHERS THEN                                       ","\n",
                            "       DBMS_OUTPUT.PUT_LINE(SQLERRM);                       ","\n",
                            "   END;                                                     ","\n",
                            "                                                            ","\n",
                            "EXCEPTION                                                   ","\n",
                            "  WHEN OTHERS THEN                                          ","\n",
                            "    DBMS_OUTPUT.PUT_LINE(SQLERRM);                          ","\n",
                            "END;                                                        ","\n",
                            "/                                                           ","\n"
  
  LET ls_drop_full = ls_procedure_script,"\n",
                     ls_exit_sign
  
  #開檔寫入
  TRY
    CALL lchannel_write.openFile(ls_sript_filename, "w" )
    CALL lchannel_write.write(ls_drop_full)
    #關檔
    CALL lchannel_write.close()
  CATCH
    DISPLAY "Generate Script Error !!"
  END TRY  

  LET ls_return = ls_sript_filename
  
  RETURN ls_return

END FUNCTION

#客制還原回標準，資料庫操作行為
FUNCTION sadzi180_db_cust_to_std(p_jsonobj)
  DEFINE 
    p_jsonobj  util.JSONObject
    #"tablename", "stand_cust"
  DEFINE 
    lb_return       BOOLEAN,
    lb_result       BOOLEAN,
    ls_table_name   STRING,
    ls_stand_cust   STRING,
    ls_sqlwhere     STRING,
    ls_sql          STRING 

  LET lb_return = TRUE 
  LET lb_result = TRUE 
  LET ls_table_name = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL)
  LET ls_stand_cust = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL)

  #設計資料表名稱不存在
  IF (ls_table_name IS NULL) THEN
    LET lb_return = FALSE
  END IF 
  
  IF (lb_return) THEN 
    BEGIN WORK

    #設計資料表欄位檔
    IF lb_result THEN
      LET ls_sqlwhere = " WHERE DZIB001 = '",ls_table_name,"' "
      IF (ls_stand_cust IS NOT NULL) 
          AND (ls_stand_cust = cs_dgenv_customize 
              OR ls_stand_cust = cs_dgenv_standard) THEN
        LET ls_sqlwhere = ls_sqlwhere, " AND DZIB029 = '", ls_stand_cust, "' "
      END IF
      LET ls_sql = "DELETE FROM DZIB_T ", ls_sqlwhere
      CALL sadzi180_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
    END IF 
    
    #設計資料表主檔(最後才刪)
    IF lb_result THEN
      LET ls_sqlwhere = " WHERE DZIA001 = '",ls_table_name,"' "
      IF (ls_stand_cust IS NOT NULL) 
          AND (ls_stand_cust = cs_dgenv_customize 
              OR ls_stand_cust = cs_dgenv_standard) THEN
        LET ls_sqlwhere = ls_sqlwhere, " AND DZIA015 = '", ls_stand_cust, "' "
      END IF
      LET ls_sql = "DELETE FROM DZIA_T ", ls_sqlwhere
      CALL sadzi180_db_exec_SQL_no_commit(ls_sql, FALSE) RETURNING lb_result
    END IF 

    #刪除 DZLM_T (簽出入記錄)
    IF lb_result THEN
      LET ls_sqlwhere = " WHERE DZLM001='MT'                   ", 
                        "   AND DZLM002='", ls_table_name, "'  "
      LET ls_sql = "DELETE FROM DZLM_T ", ls_sqlwhere
      CALL sadzi180_db_exec_SQL_no_commit(ls_sql, FALSE) RETURNING lb_result
    END IF 

    #刪除 DZAF_T (版本樹) 客制表訊息
    IF lb_result AND (ls_stand_cust = cs_dgenv_customize) THEN
      LET ls_sqlwhere = " WHERE DZAF001='", ls_table_name, "'    ", 
                        "   AND DZAF010='", ls_stand_cust, "'    ", 
                        "   AND DZAF005='MT'                     "
      LET ls_sql = "DELETE FROM DZAF_T ", ls_sqlwhere
      CALL sadzi180_db_exec_SQL_no_commit(ls_sql, FALSE) RETURNING lb_result
    END IF 
    
    IF lb_result THEN
      COMMIT WORK 
    ELSE
      LET lb_return = false
      ROLLBACK WORK
    END IF 
  END IF 
  
  RETURN lb_return 
END FUNCTION 

