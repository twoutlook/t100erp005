&include "../4gl/sadzp350_mcr.inc"

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp350_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp350_type.inc"

DEFINE
  ms_memo      STRING,
  ms_lang      STRING,
  mo_arguments T_ADZP350_ARGUMENTS
  
FUNCTION sadzp350_sdiff_run(p_lang,p_arguments)
DEFINE
  p_lang       STRING,
  p_arguments  T_ADZP350_ARGUMENTS
  
  CALL sadzp350_sdiff_initialize(p_lang,p_arguments.*)
  CALL sadzp350_sdiff_start()
  CALL sadzp350_sdiff_finalize()

END FUNCTION

FUNCTION sadzp350_sdiff_initialize(p_lang,p_arguments)
DEFINE
  p_lang      STRING,
  p_arguments T_ADZP350_ARGUMENTS
  
  LET ms_memo = ""
  LET ms_lang = p_lang
  LET mo_arguments.* = p_arguments.*
  
END FUNCTION

FUNCTION sadzp350_sdiff_start()
DEFINE
  li_records               INTEGER,
  lo_lost_table            DYNAMIC ARRAY OF T_LOST_TABLE,
  lo_table_diff_info       DYNAMIC ARRAY OF T_TABLE_DIFF_INFO,
  lo_synonym_diff_info     DYNAMIC ARRAY OF T_SYNONYM_DIFF_INFO,
  lo_table_type_diff_info  DYNAMIC ARRAY OF T_TABLE_TYPE_DIFF_INFO,
  ls_memo                  STRING,
  ls_full_path             STRING,
  lb_result                BOOLEAN

  #Information  
  LET ls_memo = "Database schema diff compare report",","
  CALL sadzp350_sdiff_show_and_log(ls_memo) 
  LET ls_memo = "Date : ",CURRENT YEAR TO SECOND
  CALL sadzp350_sdiff_show_and_log(ls_memo) 
  LET ls_memo = "ZONE : ",FGL_GETENV("ZONE")
  CALL sadzp350_sdiff_show_and_log(ls_memo) 
  LET ls_memo = "CUST : ",FGL_GETENV("CUST")
  CALL sadzp350_sdiff_show_and_log(ls_memo) 
  LET ls_memo = "DGENV : ",FGL_GETENV("DGENV")
  CALL sadzp350_sdiff_show_and_log(ls_memo) 
  LET ls_memo = "HOSTNAME : ",FGL_GETENV("HOSTNAME")
  CALL sadzp350_sdiff_show_and_log(ls_memo) 
  CALL sadzp350_sdiff_memo_pend_new_line()

  #Tables
  CALL sadzp350_sdiff_get_design_table_data_count("DS","ALL") RETURNING li_records
  LET ls_memo = "Design data table counts : ",li_records
  CALL sadzp350_sdiff_show_and_log(ls_memo) 
  
  CALL sadzp350_sdiff_get_db_table_data_count("DS","ALL") RETURNING li_records
  LET ls_memo = "DB table counts : ",li_records
  CALL sadzp350_sdiff_show_and_log(ls_memo) 

  CALL sadzp350_sdiff_get_lost_table_list("DS","ALL") RETURNING lo_lost_table
  CALL sadzp350_sdiff_show_lost_table_information(lo_lost_table)
  CALL sadzp350_sdiff_memo_pend_new_line()
  
  #Table Columns
  CALL sadzp350_sdiff_get_design_column_data_count("DS","ALL") RETURNING li_records
  LET ls_memo = "Design data column counts : ",li_records
  CALL sadzp350_sdiff_show_and_log(ls_memo) 

  CALL sadzp350_sdiff_get_db_column_data_count("DS","ALL") RETURNING li_records
  LET ls_memo = "DB column counts : ",li_records
  CALL sadzp350_sdiff_show_and_log(ls_memo)
  
  CALL sadzp350_sdiff_get_db_column_data_diff_to_design_data("DS","ALL") RETURNING lo_table_diff_info
  CALL sadzp350_sdiff_show_table_diff(lo_table_diff_info,cs_working_type_design,"DS")
  CALL sadzp350_sdiff_memo_pend_new_line()
  CALL sadzp350_sdiff_get_design_data_diff_to_db_column_data("DS","ALL") RETURNING lo_table_diff_info
  CALL sadzp350_sdiff_show_table_diff(lo_table_diff_info,"DS",cs_working_type_design)
  CALL sadzp350_sdiff_memo_pend_new_line()

  CALL sadzp350_sdiff_get_db_column_data_diff_to_db_column_data("DS","ALL","DSDEMO","ALL") RETURNING lo_table_diff_info   
  CALL sadzp350_sdiff_show_table_diff(lo_table_diff_info,"DS","DSDEMO")
  CALL sadzp350_sdiff_memo_pend_new_line()
  CALL sadzp350_sdiff_get_db_column_data_diff_to_db_column_data("DSDEMO","ALL","DS","ALL") RETURNING lo_table_diff_info   
  CALL sadzp350_sdiff_show_table_diff(lo_table_diff_info,"DSDEMO","DS")
  CALL sadzp350_sdiff_memo_pend_new_line()

  CALL sadzp350_sdiff_get_db_column_data_diff_to_db_column_data("DS","ALL","DSDATA","ALL") RETURNING lo_table_diff_info   
  CALL sadzp350_sdiff_show_table_diff(lo_table_diff_info,"DS","DSDATA")
  CALL sadzp350_sdiff_memo_pend_new_line()
  CALL sadzp350_sdiff_get_db_column_data_diff_to_db_column_data("DSDATA","ALL","DS","ALL") RETURNING lo_table_diff_info   
  CALL sadzp350_sdiff_show_table_diff(lo_table_diff_info,"DSDATA","DS")
  CALL sadzp350_sdiff_memo_pend_new_line()

  #Synonym
  CALL sadzp350_sdiff_get_design_synonym_table_data_count("DS","ALL") RETURNING li_records
  LET ls_memo = "Design data synonym counts : ",li_records
  CALL sadzp350_sdiff_show_and_log(ls_memo) 
  CALL sadzp350_sdiff_get_db_synonym_table_data_count("DSDEMO","ALL") RETURNING li_records   
  LET ls_memo = "DSDEMO synonym counts : ",li_records
  CALL sadzp350_sdiff_show_and_log(ls_memo) 
  CALL sadzp350_sdiff_get_db_synonym_table_data_count("DSDATA","ALL") RETURNING li_records   
  LET ls_memo = "DSDATA synonym counts : ",li_records
  CALL sadzp350_sdiff_show_and_log(ls_memo) 
  CALL sadzp350_sdiff_memo_pend_new_line()
  
  CALL sadzp350_sdiff_get_db_synonym_diff_to_design_data("DSDEMO","ALL") RETURNING lo_synonym_diff_info
  CALL sadzp350_sdiff_show_synonym_diff(lo_synonym_diff_info,cs_working_type_design,"DSDEMO")
  CALL sadzp350_sdiff_memo_pend_new_line()
  CALL sadzp350_sdiff_get_design_data_diff_to_db_synonym("DSDEMO","ALL") RETURNING lo_synonym_diff_info  
  CALL sadzp350_sdiff_show_synonym_diff(lo_synonym_diff_info,"DSDEMO",cs_working_type_design)
  CALL sadzp350_sdiff_memo_pend_new_line()

  CALL sadzp350_sdiff_get_db_synonym_diff_to_design_data("DSDATA","ALL") RETURNING lo_synonym_diff_info
  CALL sadzp350_sdiff_show_synonym_diff(lo_synonym_diff_info,cs_working_type_design,"DSDATA")
  CALL sadzp350_sdiff_memo_pend_new_line()
  CALL sadzp350_sdiff_get_design_data_diff_to_db_synonym("DSDATA","ALL") RETURNING lo_synonym_diff_info  
  CALL sadzp350_sdiff_show_synonym_diff(lo_synonym_diff_info,"DSDATA",cs_working_type_design)
  CALL sadzp350_sdiff_memo_pend_new_line()

  #Table Type Compare
  CALL sadzp350_sdiff_get_design_table_type_diff_to_db_table_type() RETURNING lo_table_type_diff_info
  CALL sadzp350_sdiff_show_table_type_diff(lo_table_type_diff_info)
  CALL sadzp350_sdiff_memo_pend_new_line()
  
  CALL sadzp350_sdiff_export_to_document(cs_export_csv) RETURNING lb_result,ls_full_path

  #有啟動UI模式的話儲存到 Client 端
  IF mo_arguments.a_send_to_client THEN
    DISPLAY cs_information_tag,"Sending file to client ... "
    CALL sadzp350_util_download_document(ms_lang,ls_full_path,cs_export_csv) RETURNING lb_result
    IF lb_result THEN DISPLAY cs_information_tag,"Success !!" ELSE DISPLAY cs_error_tag,"Failed !!" END IF
  END IF
  
END FUNCTION

FUNCTION sadzp350_sdiff_finalize()
END FUNCTION

--r.t Table筆數
FUNCTION sadzp350_sdiff_get_design_table_data_count(p_schema_name,p_table_name)
DEFINE
  p_schema_name STRING,
  p_table_name  STRING
DEFINE
  ls_schema_name STRING,
  ls_table_name  STRING,
  ls_SQL         STRING,
  li_records     INTEGER  
DEFINE
  li_return  INTEGER  

  LET ls_schema_name = p_schema_name.toUpperCase()
  LET ls_table_name  = p_table_name.toUpperCase()

  LET ls_SQL = "SELECT COUNT(*) RECORDS                                        ",
               "  FROM DZEA_T EA                                               ",
               " WHERE NOT EXISTS (                                            ",
               "                    SELECT 1                                   ",
               "                      FROM DBA_OBJECTS DOS                     ",
               "                     WHERE DOS.OWNER = '",ls_schema_name,"'    ",
               "                       AND DOS.OBJECT_TYPE = 'VIEW'            ",
               "                       AND DOS.OBJECT_NAME = UPPER(EA.DZEA001) ",
               "                  )                                            "

  PREPARE lpre_get_design_table_data_count FROM ls_sql
  DECLARE lcur_get_design_table_data_count CURSOR FOR lpre_get_design_table_data_count

  
  OPEN lcur_get_design_table_data_count
  FETCH lcur_get_design_table_data_count INTO li_records
  CLOSE lcur_get_design_table_data_count
  
  FREE lpre_get_design_table_data_count
  FREE lcur_get_design_table_data_count  

  LET li_return = li_records
  
  RETURN li_return               
  
END FUNCTION 

--DB DS筆數
FUNCTION sadzp350_sdiff_get_db_table_data_count(p_schema_name,p_table_name)
DEFINE
  p_schema_name STRING,
  p_table_name  STRING
DEFINE
  ls_schema_name STRING,
  ls_table_name  STRING,
  ls_SQL         STRING,
  li_records     INTEGER  
DEFINE
  li_return  INTEGER  

  LET ls_schema_name = p_schema_name.toUpperCase()
  LET ls_table_name  = p_table_name.toUpperCase()

  LET ls_SQL = "SELECT COUNT(*) RECORDS                                    ",
               "  FROM DBA_TABLES DTS                                      ",
               " WHERE DTS.OWNER = '",ls_schema_name,"'                    ",
               "   AND EXISTS (                                            ",
               "                SELECT 1                                   ",
               "                  FROM DZEA_T EA                           ",
               "                 WHERE EA.DZEA001 = LOWER(DTS.TABLE_NAME)  ",
               "              )                                            "

  PREPARE lpre_get_db_table_data_count FROM ls_sql
  DECLARE lcur_get_db_table_data_count CURSOR FOR lpre_get_db_table_data_count

  
  OPEN lcur_get_db_table_data_count
  FETCH lcur_get_db_table_data_count INTO li_records
  CLOSE lcur_get_db_table_data_count
  
  FREE lpre_get_db_table_data_count
  FREE lcur_get_db_table_data_count  

  LET li_return = li_records
  
  RETURN li_return               
  
END FUNCTION 

-- 差異表格 
FUNCTION sadzp350_sdiff_get_lost_table_list(p_schema_name,p_table_name)
DEFINE
  p_schema_name STRING,
  p_table_name  STRING
DEFINE
  ls_schema_name STRING,
  ls_table_name  STRING,
  ls_SQL         STRING,
  lo_lost_table  DYNAMIC ARRAY OF T_LOST_TABLE,
  li_counts      INTEGER,
  li_records     INTEGER  
DEFINE
  lo_return  DYNAMIC ARRAY OF T_LOST_TABLE

  LET ls_schema_name = p_schema_name.toUpperCase()
  LET ls_table_name  = p_table_name.toUpperCase()

  LET li_counts = 1
  
  #DB DS筆數
  LET ls_SQL = "SELECT EA.DZEA001 TABLE_NAME                                   ",
               "  FROM DZEA_T EA                                               ",
               " WHERE NOT EXISTS (                                            ",
               "                    SELECT 1                                   ",
               "                      FROM DBA_OBJECTS DOS                     ",
               "                     WHERE DOS.OWNER = '",ls_schema_name,"'    ",
               "                       AND DOS.OBJECT_TYPE = 'VIEW'            ",
               "                       AND DOS.OBJECT_NAME = UPPER(EA.DZEA001) ",
               "                  )                                            ",
               "MINUS                                                          ",
               "SELECT LOWER(DTS.TABLE_NAME) TABLE_NAME                        ",
               "  FROM DBA_TABLES DTS                                          ",
               " WHERE DTS.OWNER = '",ls_schema_name,"'                        ",
               "   AND EXISTS (                                                ",
               "                SELECT 1                                       ",
               "                  FROM DZEA_T EA                               ",
               "                 WHERE EA.DZEA001 = LOWER(DTS.TABLE_NAME)      ",
               "              )                                                "
                                                                              
  PREPARE lpre_get_lost_table_list FROM ls_sql                                
  DECLARE lcur_get_lost_table_list CURSOR FOR lpre_get_lost_table_list        

  OPEN lcur_get_lost_table_list 
  FOREACH lcur_get_lost_table_list INTO lo_lost_table[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_lost_table_list

  CALL lo_lost_table.deleteElement(li_counts)
  
  FREE lpre_get_lost_table_list
  FREE lcur_get_lost_table_list  

  LET lo_return = lo_lost_table
  
  RETURN lo_return               
  
END FUNCTION 

FUNCTION sadzp350_sdiff_get_design_column_data_count(p_schema_name,p_table_name)
DEFINE
  p_schema_name STRING,
  p_table_name  STRING
DEFINE
  ls_schema_name STRING,
  ls_table_name  STRING,
  ls_SQL         STRING,
  li_records     INTEGER  
DEFINE
  li_return  INTEGER  

  LET ls_schema_name = p_schema_name.toUpperCase()
  LET ls_table_name  = p_table_name.toUpperCase()

  LET LS_SQL = "SELECT COUNT(*) RECORDS ",
               "  FROM DZEB_T           "

  PREPARE lpre_get_design_column_data_count FROM ls_sql
  DECLARE lcur_get_design_column_data_count CURSOR FOR lpre_get_design_column_data_count

  OPEN lcur_get_design_column_data_count
  FETCH lcur_get_design_column_data_count INTO li_records
  CLOSE lcur_get_design_column_data_count
  
  FREE lpre_get_design_column_data_count
  FREE lcur_get_design_column_data_count  

  LET li_return = li_records
  
  RETURN li_return               
  
END FUNCTION 

FUNCTION sadzp350_sdiff_get_db_column_data_count(p_schema_name,p_table_name)
DEFINE
  p_schema_name STRING,
  p_table_name  STRING
DEFINE
  ls_schema_name STRING,
  ls_table_name  STRING,
  ls_SQL         STRING,
  li_records     INTEGER  
DEFINE
  li_return  INTEGER  

  LET ls_schema_name = p_schema_name.toUpperCase()
  LET ls_table_name  = p_table_name.toUpperCase()

  LET ls_SQL = "SELECT COUNT(*) RECORDS                                    ",
               "  FROM DBA_TAB_COLUMNS DTC                                 ",
               " WHERE DTC.OWNER = '",ls_schema_name,"'                    ",
               "   AND EXISTS (                                            ",
               "                SELECT 1                                   ",
               "                  FROM DZEB_T EB                           ",
               "                 WHERE EB.DZEB001 = LOWER(DTC.TABLE_NAME)  ",
               "                   AND EB.DZEB002 = LOWER(DTC.COLUMN_NAME) ", 
               "              )                                            "

  PREPARE lpre_get_db_column_data_count FROM ls_sql
  DECLARE lcur_get_db_column_data_count CURSOR FOR lpre_get_db_column_data_count

  OPEN lcur_get_db_column_data_count
  FETCH lcur_get_db_column_data_count INTO li_records
  CLOSE lcur_get_db_column_data_count
  
  FREE lpre_get_db_column_data_count
  FREE lcur_get_db_column_data_count  

  LET li_return = li_records
  
  RETURN li_return               
  
END FUNCTION 

FUNCTION sadzp350_sdiff_get_design_synonym_table_data_count(p_schema_name,p_table_name)
DEFINE
  p_schema_name STRING,
  p_table_name  STRING
DEFINE
  ls_schema_name STRING,
  ls_table_name  STRING,
  ls_SQL         STRING,
  li_records     INTEGER  
DEFINE
  li_return  INTEGER  

  LET ls_schema_name = p_schema_name.toUpperCase()
  LET ls_table_name  = p_table_name.toUpperCase()

  LET ls_SQL = "SELECT COUNT(*) RECORDS                          ",
               "  FROM DZEA_T EA                                 ",                            
               " WHERE EA.DZEA003 IN (",cs_system_module_list,") "
 
  PREPARE lpre_get_design_synonym_table_data_count FROM ls_sql
  DECLARE lcur_get_design_synonym_table_data_count CURSOR FOR lpre_get_design_synonym_table_data_count

  OPEN lcur_get_design_synonym_table_data_count
  FETCH lcur_get_design_synonym_table_data_count INTO li_records
  CLOSE lcur_get_design_synonym_table_data_count
  
  FREE lpre_get_design_synonym_table_data_count
  FREE lcur_get_design_synonym_table_data_count  

  LET li_return = li_records
  
  RETURN li_return               
  
END FUNCTION 

FUNCTION sadzp350_sdiff_get_db_synonym_table_data_count(p_schema_name,p_table_name)
DEFINE
  p_schema_name STRING,
  p_table_name  STRING
DEFINE
  ls_schema_name STRING,
  ls_table_name  STRING,
  ls_SQL         STRING,
  li_records     INTEGER  
DEFINE
  li_return  INTEGER  

  LET ls_schema_name = p_schema_name.toUpperCase()
  LET ls_table_name  = p_table_name.toUpperCase()

  LET ls_SQL = "SELECT COUNT(*) RECORDS                                         ",
               "  FROM DBA_OBJECTS DOS                                          ",
               " WHERE DOS.OBJECT_TYPE = 'SYNONYM'                              ",
               "   AND DOS.OWNER = '",ls_schema_name,"'                         ",
               {
               "   AND EXISTS (                                                 ",
               "                SELECT 1                                        ",
               "                  FROM DZEA_T EA                                ",
               "                 WHERE EA.DZEA001 = LOWER(DOS.OBJECT_NAME)      ",
               "                   AND EA.DZEA003 IN (",cs_system_module_list,")",
               "              )                                                 ",
               }
               "   AND NOT EXISTS (                                             ",
               "                    SELECT 1                                    ",
               "                      FROM DBA_OBJECTS DOSB                     ",
               "                     WHERE DOSB.OWNER = '",ls_schema_name,"'    ",
               "                       AND DOSB.OBJECT_TYPE = 'VIEW'            ",
               "                       AND DOSB.OBJECT_NAME = DOS.OBJECT_NAME   ",
               "                  )                                             "
 
  PREPARE lpre_get_db_synonym_table_data_count FROM ls_sql
  DECLARE lcur_get_db_synonym_table_data_count CURSOR FOR lpre_get_db_synonym_table_data_count

  OPEN lcur_get_db_synonym_table_data_count
  FETCH lcur_get_db_synonym_table_data_count INTO li_records
  CLOSE lcur_get_db_synonym_table_data_count
  
  FREE lpre_get_db_synonym_table_data_count
  FREE lcur_get_db_synonym_table_data_count  

  LET li_return = li_records
  
  RETURN li_return               
  
END FUNCTION 

#DB與設計資料的差異
FUNCTION sadzp350_sdiff_get_db_column_data_diff_to_design_data(p_schema_name,p_table_name)
DEFINE
  p_schema_name STRING,
  p_table_name  STRING
DEFINE
  ls_schema_name      STRING,
  ls_table_name       STRING,
  ls_SQL              STRING,
  lo_table_diff_info  DYNAMIC ARRAY OF T_TABLE_DIFF_INFO,
  li_counts           INTEGER,
  li_records          INTEGER  
DEFINE
  lo_return  DYNAMIC ARRAY OF T_TABLE_DIFF_INFO

  LET ls_schema_name = p_schema_name.toUpperCase()
  LET ls_table_name  = p_table_name.toUpperCase()

  LET li_counts = 1
  
  LET ls_SQL = "SELECT UPPER(EB.DZEB001)                      TABLE_NAME,                                 ",
               "       UPPER(EB.DZEB002)                      COLUMN_NAME,                                ",
               "       EB.DZEB004                             ISKEY,                                      ",
               "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') NULLABLE,                                   ",
               "       UPPER(TD.GZTD003)                      DATA_TYPE,                                  ",
               "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(                                         ",
               "       DECODE(                                                                            ",
               "              UPPER(TD.GZTD003),                                                          ",
               "              'BLOB','4000',                                                              ",
               "              'CLOB','4000',                                                              ",
               "              'DATE','7',                                                                 ",
               "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),                                ",
               "              TD.GZTD008                                                                  ",
               "             ),',','.'),' ',''))),'.',',')    DATA_LENGTH                                 ",
               "  FROM DZEB_T EB                                                                          ",
               "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006                               ",
               " WHERE 1=1                                                                                ",
               --"   AND EB.DZEB001 = '",ls_table_name,"'                                                   ",
               "   AND NOT EXISTS (                                                                       ",
               "                    SELECT 1                                                              ",
               "                      FROM DBA_OBJECTS DOS                                                ",
               "                     WHERE DOS.OWNER = 'DS'                                               ",
               "                       AND DOS.OBJECT_TYPE = 'VIEW'                                       ",
               "                       AND DOS.OBJECT_NAME = UPPER(EB.DZEB001)                            ",
               "                  )                                                                       ",
               "MINUS                                                                                     ",
               "SELECT ATC.TABLE_NAME                       TABLE_NAME,                                   ",
               "       ATC.COLUMN_NAME                      COLUMN_NAME,                                  ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                                        ",
               "       ATC.NULLABLE                         NULLABLE,                                     ",
               "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE,   ",
               "       REPLACE(                                                                           ",
               "                TO_CHAR(DECODE(                                                           ",
               "                                ATC.DATA_TYPE,                                            ",
               "                                'NUMBER',DECODE(                                          ",
               "                                                 NVL(ATC.DATA_SCALE,'0'),                 ",
               "                                                 '0',ATC.DATA_PRECISION,                  ",
               "                                                 ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE  ",
               "                                               ),                                         ",
               "                                ATC.DATA_LENGTH                                           ",
               "                              )                                                           ",
               "                       ),'.',','                                                          ",
               "              ) DATA_LENGTH                                                               ",  
               "  FROM DBA_TAB_COLUMNS ATC                                                                ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER                     ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME                ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME               ",
               "                                      AND ACC.CONSTRAINT_NAME NOT LIKE 'SYS%'             ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'                  ",
               " WHERE 1=1                                                                                ",
               "   AND ATC.TABLE_NAME NOT LIKE 'BIN$%'                                                    ",
               "   AND ATC.TABLE_NAME NOT LIKE '%REBUILD'                                                 ",
               "   AND ATC.COLUMN_NAME NOT LIKE 'SYS%'                                                    ",
               "   AND ATC.OWNER = '",ls_schema_name,"'                                                   ",
               --"   AND ATC.TABLE_NAME = ",ls_table_name,"                                                 ",  
               "   AND EXISTS (                                                                           ",
               "                SELECT 1                                                                  ",
               "                  FROM GZDA_T DA                                                          ",
               "                 WHERE DA.GZDA001 = LOWER(ATC.OWNER)                                      ",
               "                   AND DA.GZDA005 = 'Y'                                                   ",
               "              )                                                                           ",
               "   AND EXISTS (                                                                           ",
               "                SELECT 1                                                                  ",
               "                  FROM DZEA_T EA                                                          ",
               "                 WHERE EA.DZEA001 = LOWER(ATC.TABLE_NAME)                                 ",
               "              )                                                                           ",
               "   AND NOT EXISTS (                                                                       ",
               "                    SELECT 1                                                              ",
               "                      FROM DBA_OBJECTS DOS                                                ",
               "                     WHERE DOS.OWNER = 'DS'                                               ",
               "                       AND DOS.OBJECT_TYPE = 'VIEW'                                       ",
               "                       AND DOS.OBJECT_NAME = ATC.TABLE_NAME                               ",
               "                  )                                                                       " 
                                                                                            
  PREPARE lpre_get_db_column_data_diff_to_design_data FROM ls_sql                                
  DECLARE lcur_get_db_column_data_diff_to_design_data CURSOR FOR lpre_get_db_column_data_diff_to_design_data        

  OPEN lcur_get_db_column_data_diff_to_design_data 
  FOREACH lcur_get_db_column_data_diff_to_design_data INTO lo_table_diff_info[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_db_column_data_diff_to_design_data

  CALL lo_table_diff_info.deleteElement(li_counts)
  
  FREE lpre_get_db_column_data_diff_to_design_data
  FREE lcur_get_db_column_data_diff_to_design_data  

  LET lo_return = lo_table_diff_info
  
  RETURN lo_return               
  
END FUNCTION 

#r.t與DB的差異
FUNCTION sadzp350_sdiff_get_design_data_diff_to_db_column_data(p_schema_name,p_table_name)
DEFINE
  p_schema_name STRING,
  p_table_name  STRING
DEFINE
  ls_schema_name      STRING,
  ls_table_name       STRING,
  ls_SQL              STRING,
  lo_table_diff_info  DYNAMIC ARRAY OF T_TABLE_DIFF_INFO,
  li_counts           INTEGER,
  li_records          INTEGER  
DEFINE
  lo_return  DYNAMIC ARRAY OF T_TABLE_DIFF_INFO

  LET ls_schema_name = p_schema_name.toUpperCase()
  LET ls_table_name  = p_table_name.toUpperCase()

  LET li_counts = 1
  
  LET ls_SQL = "SELECT ATC.TABLE_NAME                       TABLE_NAME,                                   ",
               "       ATC.COLUMN_NAME                      COLUMN_NAME,                                  ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                                        ",
               "       ATC.NULLABLE                         NULLABLE,                                     ",
               "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE,   ",
               "       REPLACE(                                                                           ",
               "                TO_CHAR(DECODE(                                                           ",
               "                                ATC.DATA_TYPE,                                            ",
               "                                'NUMBER',DECODE(                                          ",
               "                                                 NVL(ATC.DATA_SCALE,'0'),                 ",
               "                                                 '0',ATC.DATA_PRECISION,                  ",
               "                                                 ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE  ",
               "                                               ),                                         ",
               "                                ATC.DATA_LENGTH                                           ",
               "                              )                                                           ",
               "                       ),'.',','                                                          ",
               "              ) DATA_LENGTH                                                               ",  
               "  FROM DBA_TAB_COLUMNS ATC                                                                ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER                     ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME                ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME               ",
               "                                      AND ACC.CONSTRAINT_NAME NOT LIKE 'SYS%'             ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'                  ",
               " WHERE 1=1                                                                                ",
               "   AND ATC.TABLE_NAME NOT LIKE 'BIN$%'                                                    ",
               "   AND ATC.TABLE_NAME NOT LIKE '%REBUILD'                                                 ",
               "   AND ATC.COLUMN_NAME NOT LIKE 'SYS%'                                                    ",
               "   AND ATC.OWNER = '",ls_schema_name,"'                                                   ",
               --"   AND ATC.TABLE_NAME = ",ls_table_name,"                                                 ",  
               "   AND EXISTS (                                                                           ",
               "                SELECT 1                                                                  ",
               "                  FROM GZDA_T DA                                                          ",
               "                 WHERE DA.GZDA001 = LOWER(ATC.OWNER)                                      ",
               "                   AND DA.GZDA005 = 'Y'                                                   ",
               "              )                                                                           ",
               "   AND EXISTS (                                                                           ",
               "                SELECT 1                                                                  ",
               "                  FROM DZEA_T EA                                                          ",
               "                 WHERE EA.DZEA001 = LOWER(ATC.TABLE_NAME)                                 ",
               "              )                                                                           ",
               "   AND NOT EXISTS (                                                                       ",
               "                    SELECT 1                                                              ",
               "                      FROM DBA_OBJECTS DOS                                                ",
               "                     WHERE DOS.OWNER = 'DS'                                               ",
               "                       AND DOS.OBJECT_TYPE = 'VIEW'                                       ",
               "                       AND DOS.OBJECT_NAME = ATC.TABLE_NAME                               ",
               "                  )                                                                       ",
               "MINUS                                                                                     ",
               "SELECT UPPER(EB.DZEB001)                      TABLE_NAME,                                 ",
               "       UPPER(EB.DZEB002)                      COLUMN_NAME,                                ",
               "       EB.DZEB004                             ISKEY,                                      ",
               "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') NULLABLE,                                   ",
               "       UPPER(TD.GZTD003)                      DATA_TYPE,                                  ",
               "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(                                         ",
               "       DECODE(                                                                            ",
               "              UPPER(TD.GZTD003),                                                          ",
               "              'BLOB','4000',                                                              ",
               "              'CLOB','4000',                                                              ",
               "              'DATE','7',                                                                 ",
               "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),                                ",
               "              TD.GZTD008                                                                  ",
               "             ),',','.'),' ',''))),'.',',')    DATA_LENGTH                                 ",
               "  FROM DZEB_T EB                                                                          ",
               "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006                               ",
               " WHERE 1=1                                                                                ",
               --"   AND EB.DZEB001 = '",ls_table_name,"'                                                   ",
               "   AND NOT EXISTS (                                                                       ",
               "                    SELECT 1                                                              ",
               "                      FROM DBA_OBJECTS DOS                                                ",
               "                     WHERE DOS.OWNER = 'DS'                                               ",
               "                       AND DOS.OBJECT_TYPE = 'VIEW'                                       ",
               "                       AND DOS.OBJECT_NAME = UPPER(EB.DZEB001)                            ",
               "                  )                                                                       "                
                                                                                            
  PREPARE lpre_get_design_data_diff_to_db_column_data FROM ls_sql                                
  DECLARE lcur_get_design_data_diff_to_db_column_data CURSOR FOR lpre_get_design_data_diff_to_db_column_data        

  OPEN lcur_get_design_data_diff_to_db_column_data 
  FOREACH lcur_get_design_data_diff_to_db_column_data INTO lo_table_diff_info[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_design_data_diff_to_db_column_data

  CALL lo_table_diff_info.deleteElement(li_counts)
  
  FREE lpre_get_design_data_diff_to_db_column_data
  FREE lcur_get_design_data_diff_to_db_column_data  

  LET lo_return = lo_table_diff_info
  
  RETURN lo_return               
  
END FUNCTION 

FUNCTION sadzp350_sdiff_get_db_column_data_diff_to_db_column_data(p_src_schema_name,p_src_table_name,p_dst_schema_name,p_dst_table_name)
DEFINE
  p_src_schema_name  STRING,
  p_src_table_name   STRING,
  p_dst_schema_name  STRING,
  p_dst_table_name   STRING
DEFINE
  ls_src_schema_name  STRING,
  ls_src_table_name   STRING,
  ls_dst_schema_name  STRING,
  ls_dst_table_name   STRING,
  ls_SQL              STRING,
  lo_table_diff_info  DYNAMIC ARRAY OF T_TABLE_DIFF_INFO,
  li_counts           INTEGER,
  li_records          INTEGER  
DEFINE
  lo_return  DYNAMIC ARRAY OF T_TABLE_DIFF_INFO

  LET ls_src_schema_name = p_src_schema_name.toUpperCase()
  LET ls_src_table_name  = p_src_table_name.toUpperCase()
  LET ls_dst_schema_name = p_dst_schema_name.toUpperCase()
  LET ls_dst_table_name  = p_dst_table_name.toUpperCase()

  LET li_counts = 1
                                 
  LET ls_SQL = "SELECT ATC.TABLE_NAME                       TABLE_NAME,                                     ",
               "       ATC.COLUMN_NAME                      COLUMN_NAME,                                    ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                                          ",
               "       ATC.NULLABLE                         NULLABLE,                                       ",
               "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE,     ",
               "       REPLACE(                                                                             ",
               "                TO_CHAR(DECODE(                                                             ",
               "                                ATC.DATA_TYPE,                                              ",
               "                                'NUMBER',DECODE(                                            ",
               "                                                 NVL(ATC.DATA_SCALE,'0'),                   ",
               "                                                 '0',ATC.DATA_PRECISION,                    ",
               "                                                 ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE    ",
               "                                               ),                                           ",
               "                                ATC.DATA_LENGTH                                             ",
               "                              )                                                             ",
               "                       ),'.',','                                                            ",
               "              ) DATA_LENGTH                                                                 ",
               "  FROM DBA_TAB_COLUMNS ATC                                                                  ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER                       ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME                  ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME                 ",
               "                                      AND ACC.CONSTRAINT_NAME NOT LIKE 'SYS%'               ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'                    ",
               " WHERE 1=1                                                                                  ",
               "   AND ATC.TABLE_NAME NOT LIKE 'BIN$%'                                                      ",
               "   AND ATC.TABLE_NAME NOT LIKE '%REBUILD'                                                   ",
               "   AND ATC.COLUMN_NAME NOT LIKE 'SYS%'                                                      ",
               "   AND ATC.OWNER = '",ls_src_schema_name,"'                                                 ",
               --"   AND ATC.TABLE_NAME = ",ls_src_table_name,"                                               ",
               "   AND EXISTS (                                                                             ",
               "                SELECT 1                                                                    ",
               "                  FROM GZDA_T DA                                                            ",
               "                 WHERE DA.GZDA001 = LOWER(ATC.OWNER)                                        ",
               "                   AND DA.GZDA005 = 'Y'                                                     ",
               "              )                                                                             ",
               "   AND EXISTS (                                                                             ",
               "                SELECT 1                                                                    ",
               "                  FROM DZEA_T EA                                                            ",
               "                 WHERE EA.DZEA001 = LOWER(ATC.TABLE_NAME)                                   ",
               "                   AND EA.DZEA003 NOT IN (",cs_system_module_list,")                        ",      
               "              )                                                                             ",
               "MINUS                                                                                       ",
               "SELECT ATC.TABLE_NAME                       TABLE_NAME,                                     ",
               "       ATC.COLUMN_NAME                      COLUMN_NAME,                                    ",
               "       DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                                          ",
               "       ATC.NULLABLE                         NULLABLE,                                       ",
               "       DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE,     ",
               "       REPLACE(                                                                             ",
               "                TO_CHAR(DECODE(                                                             ",
               "                                ATC.DATA_TYPE,                                              ",
               "                                'NUMBER',DECODE(                                            ",
               "                                                 NVL(ATC.DATA_SCALE,'0'),                   ",
               "                                                 '0',ATC.DATA_PRECISION,                    ",
               "                                                 ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE    ",
               "                                               ),                                           ",
               "                                ATC.DATA_LENGTH                                             ",
               "                              )                                                             ",
               "                       ),'.',','                                                            ",
               "              ) DATA_LENGTH                                                                 ",
               "  FROM DBA_TAB_COLUMNS ATC                                                                  ",
               "  LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER                       ",
               "                                      AND ACC.TABLE_NAME  = ATC.TABLE_NAME                  ",
               "                                      AND ACC.COLUMN_NAME = ATC.COLUMN_NAME                 ",
               "                                      AND ACC.CONSTRAINT_NAME NOT LIKE 'SYS%'               ",
               "                                      AND ACC.CONSTRAINT_NAME LIKE '%PK'                    ",
               " WHERE 1=1                                                                                  ",
               "   AND ATC.TABLE_NAME NOT LIKE 'BIN$%'                                                      ",
               "   AND ATC.TABLE_NAME NOT LIKE '%REBUILD'                                                   ",
               "   AND ATC.COLUMN_NAME NOT LIKE 'SYS%'                                                      ",
               "   AND ATC.OWNER = '",ls_dst_schema_name,"'                                                 ",
               --"   AND ATC.TABLE_NAME = ",ls_dst_table_name,"                                               ",
               "   AND EXISTS (                                                                             ",
               "                SELECT 1                                                                    ",
               "                  FROM GZDA_T DA                                                            ",
               "                 WHERE DA.GZDA001 = LOWER(ATC.OWNER)                                        ",
               "                   AND DA.GZDA005 = 'Y'                                                     ",
               "              )                                                                             ",
               "   AND EXISTS (                                                                             ",
               "                SELECT 1                                                                    ",
               "                  FROM DZEA_T EA                                                            ",
               "                 WHERE EA.DZEA001 = LOWER(ATC.TABLE_NAME)                                   ",
               "                   AND EA.DZEA003 NOT IN (",cs_system_module_list,")                        ",      
               "              )                                                                             "
              
                                                                                                          
  PREPARE lpre_get_db_column_data_diff_to_db_column_data FROM ls_sql                                
  DECLARE lcur_get_db_column_data_diff_to_db_column_data CURSOR FOR lpre_get_db_column_data_diff_to_db_column_data        

  OPEN lcur_get_db_column_data_diff_to_db_column_data 
  FOREACH lcur_get_db_column_data_diff_to_db_column_data INTO lo_table_diff_info[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_db_column_data_diff_to_db_column_data

  CALL lo_table_diff_info.deleteElement(li_counts)
  
  FREE lpre_get_db_column_data_diff_to_db_column_data
  FREE lcur_get_db_column_data_diff_to_db_column_data  

  LET lo_return = lo_table_diff_info
  
  RETURN lo_return               
  
END FUNCTION 

FUNCTION sadzp350_sdiff_get_db_synonym_diff_to_design_data(p_schema_name,p_synonym_name)
DEFINE
  p_schema_name  STRING,
  p_synonym_name STRING
DEFINE
  ls_schema_name   STRING,
  ls_synonym_name  STRING,
  ls_SQL           STRING,
  lo_synonym_diff  DYNAMIC ARRAY OF T_SYNONYM_DIFF_INFO,
  li_counts        INTEGER,
  li_records       INTEGER  
DEFINE
  lo_return  DYNAMIC ARRAY OF T_SYNONYM_DIFF_INFO

  LET ls_schema_name  = p_schema_name.toUpperCase()
  LET ls_synonym_name = p_synonym_name.toUpperCase()

  LET li_counts = 1
  
  LET ls_SQL = "SELECT UPPER(EA.DZEA001) SYNONYM_NAME                          ",
               "  FROM DZEA_T EA                                               ",           
               " WHERE EA.DZEA003 IN (",cs_system_module_list,")               ",
               "MINUS                                                          ",
               "SELECT DOS.OBJECT_NAME SYNONYM_NAME                            ",
               "  FROM DBA_OBJECTS DOS                                         ",
               " WHERE DOS.OBJECT_TYPE = 'SYNONYM'                             ",
               "   AND DOS.OWNER = '",ls_schema_name,"'                        ",
               "   AND NOT EXISTS (                                            ",
               "                    SELECT *                                   ",
               "                      FROM DBA_OBJECTS DOSB                    ",
               "                     WHERE DOSB.OWNER = '",ls_schema_name,"'   ",
               "                       AND DOSB.OBJECT_TYPE = 'VIEW'           ",
               "                       AND DOSB.OBJECT_NAME = DOS.OBJECT_NAME  ",
               "                  )                                            "
                                                                                                
  PREPARE lpre_get_db_synonym_diff_to_design_data FROM ls_sql                                
  DECLARE lcur_get_db_synonym_diff_to_design_data CURSOR FOR lpre_get_db_synonym_diff_to_design_data        

  OPEN lcur_get_db_synonym_diff_to_design_data 
  FOREACH lcur_get_db_synonym_diff_to_design_data INTO lo_synonym_diff[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_db_synonym_diff_to_design_data

  CALL lo_synonym_diff.deleteElement(li_counts)
  
  FREE lpre_get_db_synonym_diff_to_design_data
  FREE lcur_get_db_synonym_diff_to_design_data  

  LET lo_return = lo_synonym_diff
  
  RETURN lo_return               
  
END FUNCTION 

FUNCTION sadzp350_sdiff_get_design_data_diff_to_db_synonym(p_schema_name,p_synonym_name)
DEFINE
  p_schema_name  STRING,
  p_synonym_name STRING
DEFINE
  ls_schema_name   STRING,
  ls_synonym_name  STRING,
  ls_SQL           STRING,
  lo_synonym_diff  DYNAMIC ARRAY OF T_SYNONYM_DIFF_INFO,
  li_counts        INTEGER,
  li_records       INTEGER  
DEFINE
  lo_return  DYNAMIC ARRAY OF T_SYNONYM_DIFF_INFO

  LET ls_schema_name  = p_schema_name.toUpperCase()
  LET ls_synonym_name = p_synonym_name.toUpperCase()

  LET li_counts = 1
  
  LET ls_SQL = "SELECT DOS.OBJECT_NAME SYNONYM_NAME                            ",
               "  FROM DBA_OBJECTS DOS                                         ",
               " WHERE DOS.OBJECT_TYPE = 'SYNONYM'                             ",
               "   AND DOS.OWNER = '",ls_schema_name,"'                        ",
               "   AND NOT EXISTS (                                            ",
               "                    SELECT *                                   ",
               "                      FROM DBA_OBJECTS DOSB                    ",
               "                     WHERE DOSB.OWNER = '",ls_schema_name,"'   ",
               "                       AND DOSB.OBJECT_TYPE = 'VIEW'           ",
               "                       AND DOSB.OBJECT_NAME = DOS.OBJECT_NAME  ",
               "                  )                                            ",
               "MINUS                                                          ",
               "SELECT UPPER(EA.DZEA001) SYNONYM_NAME                          ",
               "  FROM DZEA_T EA                                               ",           
               " WHERE EA.DZEA003 IN (",cs_system_module_list,")               "
                                                                                                
  PREPARE lpre_get_design_data_diff_to_db_synonym FROM ls_sql                                
  DECLARE lcur_get_design_data_diff_to_db_synonym CURSOR FOR lpre_get_design_data_diff_to_db_synonym        

  OPEN lcur_get_design_data_diff_to_db_synonym 
  FOREACH lcur_get_design_data_diff_to_db_synonym INTO lo_synonym_diff[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_design_data_diff_to_db_synonym

  CALL lo_synonym_diff.deleteElement(li_counts)
  
  FREE lpre_get_design_data_diff_to_db_synonym
  FREE lcur_get_design_data_diff_to_db_synonym  

  LET lo_return = lo_synonym_diff
  
  RETURN lo_return               
  
END FUNCTION 

FUNCTION sadzp350_sdiff_get_design_table_type_diff_to_db_table_type()
DEFINE
  ls_SQL                   STRING,
  lo_table_type_diff_info  DYNAMIC ARRAY OF T_TABLE_TYPE_DIFF_INFO,
  li_counts                INTEGER,
  li_records               INTEGER  
DEFINE
  lo_return  DYNAMIC ARRAY OF T_TABLE_TYPE_DIFF_INFO

  LET li_counts = 1

  LET ls_SQL = "SELECT DAA.TABLE_OWNER,DAA.TABLE_NAME,DAA.MODULE_NAME,DAA.TABLE_TYPE DEFINE_TABLE_TYPE,DOO.TABLE_TYPE REAL_TABLE_TYPE                      ",            
               "  FROM (                                                                                                                                   ",
               "         SELECT DAO.TABLE_OWNER,DAO.TABLE_NAME,DAO.MODULE_NAME,DECODE(UPPER(EU.DZEU003),'T','TABLE','S','SYNONYM','(NO_FOUND)') TABLE_TYPE ",
               "           FROM (                                                                                                                          ",
               "                 SELECT UPPER(DA.GZDA001) TABLE_OWNER,UPPER(EA.DZEA001) TABLE_NAME,EA.DZEA003 MODULE_NAME                                  ",
               "                   FROM GZDA_T DA,                                                                                                         ",
               "                        DZEA_T EA                                                                                                          ",
               "                  WHERE DA.GZDASTUS = 'Y'                                                                                                  ",
               "                    AND DA.GZDA005  = 'Y'                                                                                                  ",
               "                ) DAO                                                                                                                      ",
               "                LEFT OUTER JOIN DZEU_T EU ON EU.DZEU001 = LOWER(DAO.TABLE_NAME)                                                            ",
               "                                         AND EU.DZEU002 = LOWER(DAO.TABLE_OWNER)                                                           ",
               "          ORDER BY DAO.TABLE_NAME,DAO.TABLE_OWNER                                                                                          ",
               "       ) DAA                                                                                                                               ",
               "       LEFT OUTER JOIN (                                                                                                                   ",
               "                         SELECT DOS.OWNER TABLE_OWNER,DOS.OBJECT_NAME TABLE_NAME,DOS.OBJECT_TYPE TABLE_TYPE                                ",
               "                           FROM DBA_OBJECTS DOS                                                                                            ",
               "                          WHERE 1=1                                                                                                        ",
               "                            AND DOS.OWNER IN ('DS','DSDEMO','DSDATA')                                                                      ",
               "                            AND DOS.OBJECT_TYPE IN ('TABLE','SYNONYM')                                                                     ",
               "                            AND EXISTS (                                                                                                   ",
               "                                         SELECT 1                                                                                          ",
               "                                           FROM DZEA_T EA                                                                                  ",
               "                                          WHERE EA.DZEA001 = LOWER(DOS.OBJECT_NAME)                                                        ",
               "                                       )                                                                                                   ",
               "                       ) DOO                                                                                                               ",
               "                       ON DOO.TABLE_OWNER = DAA.TABLE_OWNER                                                                                ",
               "                      AND DOO.TABLE_NAME  = DAA.TABLE_NAME                                                                                 ",
               " WHERE 1=1                                                                                                                                 ",
               "   AND DAA.TABLE_TYPE <> DOO.TABLE_TYPE                                                                                                    ",
               " ORDER BY DAA.TABLE_NAME,DAA.TABLE_OWNER                                                                                                   "
                                                                                                          
  PREPARE lpre_get_design_table_type_diff_to_db_table_type FROM ls_sql                                
  DECLARE lcur_get_design_table_type_diff_to_db_table_type CURSOR FOR lpre_get_design_table_type_diff_to_db_table_type        

  OPEN lcur_get_design_table_type_diff_to_db_table_type 
  FOREACH lcur_get_design_table_type_diff_to_db_table_type INTO lo_table_type_diff_info[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_design_table_type_diff_to_db_table_type

  CALL lo_table_type_diff_info.deleteElement(li_counts)
  
  FREE lpre_get_design_table_type_diff_to_db_table_type
  FREE lcur_get_design_table_type_diff_to_db_table_type  

  LET lo_return = lo_table_type_diff_info
  
  RETURN lo_return               
  
END FUNCTION 

FUNCTION sadzp350_sdiff_show_lost_table_information(p_lost_table)
DEFINE 
  p_lost_table  DYNAMIC ARRAY OF T_LOST_TABLE
DEFINE 
  lo_lost_table  DYNAMIC ARRAY OF T_LOST_TABLE,
  li_loop        INTEGER,
  ls_memo        STRING

  LET lo_lost_table = p_lost_table

  LET ls_memo = "Lost tables"
  CALL sadzp350_sdiff_show_and_log(ls_memo) 

  FOR li_loop = 1 TO lo_lost_table.getLength()
    LET ls_memo = sadzp350_util_lpad(lo_lost_table[li_loop].TABLE_NAME,15,NULL)
    CALL sadzp350_sdiff_show_and_log(ls_memo) 
  END FOR
  
END FUNCTION 

FUNCTION sadzp350_sdiff_show_table_diff(p_table_diff_info,p_source,p_target)
DEFINE
  p_table_diff_info  DYNAMIC ARRAY OF T_TABLE_DIFF_INFO,
  p_source   STRING,
  p_target   STRING
DEFINE
  lo_table_diff_info  DYNAMIC ARRAY OF T_TABLE_DIFF_INFO,
  ls_source           STRING,
  ls_target           STRING,
  ls_memo             STRING,
  li_loop             INTEGER

  LET lo_table_diff_info = p_table_diff_info
  LET ls_source = p_source
  LET ls_target = p_target

  LET ls_memo = "Table diff source : '",ls_source,"' target : '",ls_target,"'"
  CALL sadzp350_sdiff_show_and_log(ls_memo) 

  LET ls_memo = "Table Name",",",
                "Column Name",",",
                "Key",",",
                "Null",",",
                "Data Type",",",
                "Length",","
  CALL sadzp350_sdiff_show_and_log(ls_memo)
  
  FOR li_loop = 1 TO lo_table_diff_info.getLength()
    LET ls_memo = lo_table_diff_info[li_loop].tdi_TABLE_NAME,",",  
                  lo_table_diff_info[li_loop].tdi_COLUMN_NAME,",", 
                  lo_table_diff_info[li_loop].tdi_ISKEY,",",       
                  lo_table_diff_info[li_loop].tdi_NULLABLE,",",    
                  lo_table_diff_info[li_loop].tdi_DATA_TYPE,",",   
                  lo_table_diff_info[li_loop].tdi_DATA_LENGTH,","
    CALL sadzp350_sdiff_show_and_log(ls_memo) 
  END FOR 
  
END FUNCTION

FUNCTION sadzp350_sdiff_show_table_type_diff(p_table_type_diff_info)
DEFINE
  p_table_type_diff_info  DYNAMIC ARRAY OF T_TABLE_TYPE_DIFF_INFO
DEFINE
  lo_table_type_diff_info  DYNAMIC ARRAY OF T_TABLE_TYPE_DIFF_INFO,
  ls_memo             STRING,
  li_loop             INTEGER

  LET lo_table_type_diff_info = p_table_type_diff_info

  LET ls_memo = "Table type diff compare."
  CALL sadzp350_sdiff_show_and_log(ls_memo) 

  LET ls_memo = "Table Owner",",",
                "Table Name",",",
                "Module Name",",",
                "Define table type",",",
                "Real table type",","
  CALL sadzp350_sdiff_show_and_log(ls_memo)
  
  FOR li_loop = 1 TO lo_table_type_diff_info.getLength()
    LET ls_memo = lo_table_type_diff_info[li_loop].ttdi_TABLE_OWNER,",",  
                  lo_table_type_diff_info[li_loop].ttdi_TABLE_NAME,",", 
                  lo_table_type_diff_info[li_loop].ttdi_MODULE_NAME,",",       
                  lo_table_type_diff_info[li_loop].ttdi_DEFINE_TABLE_TYPE,",",    
                  lo_table_type_diff_info[li_loop].ttdi_REAL_TABLE_TYPE,","   
    CALL sadzp350_sdiff_show_and_log(ls_memo) 
  END FOR 
  
END FUNCTION

FUNCTION sadzp350_sdiff_show_synonym_diff(p_synonym_diff_info,p_source,p_target)
DEFINE
  p_synonym_diff_info  DYNAMIC ARRAY OF T_SYNONYM_DIFF_INFO,
  p_source   STRING,
  p_target   STRING
DEFINE
  lo_synonym_diff_info  DYNAMIC ARRAY OF T_SYNONYM_DIFF_INFO,
  ls_source           STRING,
  ls_target           STRING,
  ls_memo             STRING,
  li_loop             INTEGER

  LET lo_synonym_diff_info = p_synonym_diff_info
  LET ls_source = p_source
  LET ls_target = p_target

  LET ls_memo = "Synonym diff source : '",ls_source,"' target : '",ls_target,"'","," 
  CALL sadzp350_sdiff_show_and_log(ls_memo) 

  LET ls_memo = "Synonym Name",","
  CALL sadzp350_sdiff_show_and_log(ls_memo)
  
  FOR li_loop = 1 TO lo_synonym_diff_info.getLength()
    LET ls_memo = lo_synonym_diff_info[li_loop].SYNONYM_NAME,","
    CALL sadzp350_sdiff_show_and_log(ls_memo) 
  END FOR   

END FUNCTION

FUNCTION sadzp350_sdiff_show_and_log(p_memo)
DEFINE
  p_memo STRING 

  LET ms_memo = ms_memo,"\n",
                p_memo

  DISPLAY p_memo
  
END FUNCTION   

FUNCTION sadzp350_sdiff_memo_pend_new_line()

  LET ms_memo = ms_memo,"\n"
  
END FUNCTION   

FUNCTION sadzp350_sdiff_export_to_document(p_doc_type)
DEFINE
  p_doc_type  STRING
DEFINE
  ls_doc_type     STRING,
  ls_working_dir  STRING,
  ls_curr_working_dir STRING,
  ls_full_path    STRING,
  ls_result       STRING,
  lb_result       BOOLEAN,
  ls_path         STRING,
  ls_separator    STRING
DEFINE
  lb_return BOOLEAN
  
  LET ls_doc_type = p_doc_type.toLowerCase()

  LET ls_separator = os.Path.separator()

  #取得目前工作目錄
  CALL os.Path.pwd() RETURNING ls_curr_working_dir
  
  CALL sadzp350_util_change_to_temp_directory(ls_doc_type) RETURNING lb_result,ls_path
  CALL sadzp350_util_gen_diff_document(ls_path,ms_memo,ls_doc_type,NULL) RETURNING ls_result
  
  CALL os.Path.chdir(ls_curr_working_dir) RETURNING lb_result

  LET ls_full_path = ls_result
  DISPLAY cs_information_tag,"Generate document : ",ls_full_path

  RETURN lb_return,ls_full_path
  
END FUNCTION
