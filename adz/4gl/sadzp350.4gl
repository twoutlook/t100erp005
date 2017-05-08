&include "../4gl/sadzp350_mcr.inc"

IMPORT util 
IMPORT os

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp350_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp350_type.inc"

#執行的環境變數
DEFINE 
  ms_dlang        STRING,
  ms_lang         STRING,
  ms_MasterDB     STRING,
  ms_MasterUser   STRING,
  ms_GUID         STRING,
  mb_result       BOOLEAN,
  mb_backend_mode BOOLEAN,
  mo_arguments    T_ADZP350_ARGUMENTS
            
FUNCTION sadzp350_run(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ADZP350_ARGUMENTS
  
  CALL sadzp350_initialize(p_backend_mode,p_arguments.*)
  CALL sadzp350_start()
  CALL sadzp350_finalize()

  RETURN mb_result

END FUNCTION

FUNCTION sadzp350_initialize(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ADZP350_ARGUMENTS

  LET mb_backend_mode = p_backend_mode
  LET mo_arguments.*  = p_arguments.* 

  LET mb_result = TRUE
  LET ms_GUID = ""

  &ifndef DEBUG
    LET ms_lang = NVL(g_lang,cs_default_lang)
  &else
    LET ms_lang = cs_default_lang
  &endif
  
END FUNCTION

FUNCTION sadzp350_start()
DEFINE
  lb_result  BOOLEAN,
  lo_src_schema_information DYNAMIC ARRAY OF T_SCHEMA_INFORMATION,
  lo_dst_schema_information DYNAMIC ARRAY OF T_SCHEMA_INFORMATION,
  lo_DIFF_PARAMETER T_DIFF_PARAMETER,
  lo_DIFF_RECORDS   DYNAMIC ARRAY OF T_DIFF_RECORDS,
  ls_file_path  STRING
  
  CALL sadzp350_util_get_GUID() RETURNING ms_GUID
  DISPLAY cs_information_tag,"Working GUID : ",ms_GUID

  DISPLAY cs_information_tag,"Preparing source data ..."
  CALL sadzp350_get_data_from_design_data(mo_ARGUMENTS.a_source_design_name) RETURNING lo_src_schema_information
  DISPLAY cs_information_tag,"Source data records : ",lo_src_schema_information.getLength()
  
  DISPLAY cs_information_tag,"Preparing destination data ..."
  CALL sadzp350_get_data_from_real_schema(mo_ARGUMENTS.a_dest_schema_name, mo_ARGUMENTS.a_dest_table_name) RETURNING lo_dst_schema_information
  DISPLAY cs_information_tag,"Destination data records : ",lo_dst_schema_information.getLength()

  DISPLAY cs_information_tag,"Delete expired log datas ..."
  CALL sadzp350_crud_delete_expired_log_data(cs_log_reserve_days) RETURNING lb_result

  DISPLAY cs_information_tag,"Load data to temporary zone ..."
  DISPLAY cs_information_tag,"Begin : ",CURRENT YEAR TO SECOND 
  CALL sadzp350_set_diff_base_data(ms_GUID,lo_src_schema_information,lo_dst_schema_information) RETURNING lb_result
  DISPLAY cs_information_tag,"Finished : ",CURRENT YEAR TO SECOND 

  DISPLAY cs_information_tag,"Start diff process ..."
  DISPLAY cs_information_tag,"Begin : ",CURRENT YEAR TO SECOND 
  CALL sadzp350_get_diff_parameters(ms_GUID,mo_arguments.*) RETURNING lo_DIFF_PARAMETER.*
  CALL sadzp350_get_diff_result_records(lo_DIFF_PARAMETER.*) RETURNING lo_DIFF_RECORDS
  DISPLAY cs_information_tag,"Finished : ",CURRENT YEAR TO SECOND 

  DISPLAY cs_information_tag,"Start export document with ",mo_ARGUMENTS.a_exp_document_type," ..."
  DISPLAY cs_information_tag,"Begin : ",CURRENT YEAR TO SECOND 
  CALL sadzp350_export_to_document(mo_ARGUMENTS.a_exp_document_type,lo_DIFF_RECORDS) RETURNING lb_result,ls_file_path
  DISPLAY cs_information_tag,"Finished : ",CURRENT YEAR TO SECOND 

  #有啟動UI模式的話儲存到 Client 端
  IF mo_arguments.a_send_to_client THEN
    DISPLAY cs_information_tag,"Sending file to client ... "
    CALL sadzp350_util_download_document(ms_lang,ls_file_path,mo_ARGUMENTS.a_exp_document_type) RETURNING lb_result
    IF lb_result THEN DISPLAY cs_information_tag,"Success !!" ELSE DISPLAY cs_error_tag,"Failed !!" END IF
  END IF

END FUNCTION

FUNCTION sadzp350_finalize()
END FUNCTION

FUNCTION sadzp350_get_diff_parameters(p_GUID,p_arguments)
DEFINE
  p_guid       STRING,
  p_arguments  T_ADZP350_ARGUMENTS
DEFINE
  lo_DIFF_PARAMETER  T_DIFF_PARAMETER
DEFINE
  lo_return  T_DIFF_PARAMETER

  LET lo_DIFF_PARAMETER.dp_GUID = p_guid
  LET lo_DIFF_PARAMETER.dp_source_working_type = UPSHIFT(p_arguments.a_source_working_type)
  LET lo_DIFF_PARAMETER.dp_source_schema_name  = UPSHIFT(p_arguments.a_source_schema_name)
  LET lo_DIFF_PARAMETER.dp_source_table_name   = UPSHIFT(p_arguments.a_source_table_name)
  LET lo_DIFF_PARAMETER.dp_dest_working_type   = UPSHIFT(p_arguments.a_dest_working_type)
  LET lo_DIFF_PARAMETER.dp_dest_schema_name    = UPSHIFT(p_arguments.a_dest_schema_name)
  LET lo_DIFF_PARAMETER.dp_dest_table_name     = UPSHIFT(p_arguments.a_dest_table_name)

  LET lo_return.* = lo_DIFF_PARAMETER.*

  RETURN lo_return.*
  
END FUNCTION 

FUNCTION sadzp350_get_data_from_design_data(p_table_name)
DEFINE
  p_table_name STRING
DEFINE
  ls_table_name STRING,
  ls_table_cond VARCHAR(100),
  ls_sql        STRING,
  li_counts     INTEGER,
  lo_schema_information DYNAMIC ARRAY OF T_SCHEMA_INFORMATION
DEFINE
  lo_return DYNAMIC ARRAY OF T_SCHEMA_INFORMATION

  LET ls_table_name = p_table_name.toLowerCase()

  LET li_counts = 1

  IF ls_table_name.toUpperCase() = cs_schema_table_all THEN 
    LET ls_table_cond = " EB.DZEB001 "
  ELSE 
    LET ls_table_cond = " '",ls_table_name,"' "
  END IF
  
  LET ls_sql = "SELECT '",cs_working_type_design,"'           WORKING_TYPE, ",
               "       '",cs_design_owner_name,"'             SCHEMA_NAME,  ",
               "       UPPER(EB.DZEB001)                      TABLE_NAME,   ",
               "       UPPER(EB.DZEB002)                      COLUMN_NAME,  ", 
               "       EB.DZEB004                             ISKEY,        ", 
               "       DECODE(EB.DZEB004,'Y','N','N','Y','Y') NULLABLE,     ", 
               "       UPPER(TD.GZTD003)                      DATA_TYPE,    ", 
               "       REPLACE(TO_CHAR(TO_NUMBER(REPLACE(REPLACE(           ", 
               "       DECODE(                                              ", 
               "              UPPER(TD.GZTD003),                            ", 
               "              'BLOB','4000',                                ", 
               "              'CLOB','4000',                                ", 
               "              'DATE','7',                                   ", 
               "              'TIMESTAMP',DECODE(TD.GZTD008,'0','7','11'),  ", 
               "              TD.GZTD008                                    ", 
               "             ),',','.'),' ',''))),'.',',')    DATA_LENGTH,  ", 
               "       EB.DZEB021                             COLUMN_ID     ",
               "  FROM DZEB_T EB                                            ", 
               "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006 ", 
               " WHERE 1=1                                                  ",
               "   AND EB.DZEB001 = ",ls_table_cond,"                       ",
               " ORDER BY EB.DZEB001,EB.DZEB021                             "


  PREPARE lpre_get_data_from_design_data FROM ls_sql
  DECLARE lcur_get_data_from_design_data CURSOR FOR lpre_get_data_from_design_data

  OPEN lcur_get_data_from_design_data 
  FOREACH lcur_get_data_from_design_data INTO lo_schema_information[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_data_from_design_data

  CALL lo_schema_information.deleteElement(li_counts)
  
  FREE lpre_get_data_from_design_data
  FREE lcur_get_data_from_design_data

  LET lo_return = lo_schema_information

  RETURN lo_return
  
END FUNCTION

FUNCTION sadzp350_get_data_from_real_schema(p_owner,p_table_name)
DEFINE
  p_owner      STRING,
  p_table_name STRING
DEFINE
  ls_owner      STRING,
  ls_table_name STRING,
  ls_owner_cond VARCHAR(100),
  ls_table_cond VARCHAR(100),
  ls_sql        STRING,
  li_counts     INTEGER,
  lo_schema_information DYNAMIC ARRAY OF T_SCHEMA_INFORMATION
DEFINE
  lo_return DYNAMIC ARRAY OF T_SCHEMA_INFORMATION

  LET ls_owner      = p_owner.toUpperCase()
  LET ls_table_name = p_table_name.toUpperCase()

  LET li_counts = 1

  IF ls_owner.toUpperCase() = cs_schema_owner_all THEN 
    LET ls_owner_cond = " ATC.OWNER "
  ELSE 
    LET ls_owner_cond = " '",ls_owner,"' "
  END IF

  IF ls_table_name.toUpperCase() = cs_schema_table_all THEN 
    LET ls_table_cond = " ATC.TABLE_NAME "
  ELSE 
    LET ls_table_cond = " '",ls_table_name,"' "
  END IF
  
  LET ls_sql = " SELECT '",cs_working_type_db,"'             WORKING_TYPE,                                 ",
               "        ATC.OWNER                            SCHEMA_NAME,                                  ",
               "        ATC.TABLE_NAME                       TABLE_NAME,                                   ",
               "        ATC.COLUMN_NAME                      COLUMN_NAME,                                  ",
               "        DECODE(ACC.COLUMN_NAME,NULL,'N','Y') ISKEY,                                        ",
               "        ATC.NULLABLE                         NULLABLE,                                     ",
               "        DECODE(INSTRB(ATC.DATA_TYPE,'TIMESTAMP'),1,'TIMESTAMP',ATC.DATA_TYPE) DATA_TYPE,   ",
               "        REPLACE(                                                                           ",
               "                 TO_CHAR(DECODE(                                                           ",
               "                                 ATC.DATA_TYPE,                                            ",
               "                                 'NUMBER',DECODE(                                          ",
               "                                                  NVL(ATC.DATA_SCALE,'0'),                 ",
               "                                                  '0',ATC.DATA_PRECISION,                  ",
               "                                                  ATC.DATA_PRECISION||'.'||ATC.DATA_SCALE  ",
               "                                                ),                                         ",
               "                                 ATC.DATA_LENGTH                                           ",
               "                               )                                                           ",
               "                        ),'.',','                                                          ",
               "               ) DATA_LENGTH,                                                              ",
               "               ATC.COLUMN_ID                                                               ",
               "   FROM DBA_TAB_COLUMNS ATC                                                                ",
               "   LEFT OUTER JOIN DBA_CONS_COLUMNS ACC ON ACC.OWNER       = ATC.OWNER                     ",
               "                                       AND ACC.TABLE_NAME  = ATC.TABLE_NAME                ",
               "                                       AND ACC.COLUMN_NAME = ATC.COLUMN_NAME               ",
               "                                       AND ACC.CONSTRAINT_NAME NOT LIKE 'SYS%'             ",
               "                                       AND ACC.CONSTRAINT_NAME LIKE '%PK'                  ",
               "  WHERE 1=1                                                                                ",
               "    AND ATC.TABLE_NAME NOT LIKE 'BIN$%'                                                    ",
               "    AND ATC.TABLE_NAME NOT LIKE '%REBUILD'                                                 ",
               "    AND ATC.COLUMN_NAME NOT LIKE 'SYS%'                                                    ",
               "    AND ATC.OWNER = ",ls_owner_cond,"                                                      ",
               "    AND ATC.TABLE_NAME = ",ls_table_cond,"                                                 ",
               "    AND EXISTS (                                                                           ",
               "                 SELECT 1                                                                  ",
               "                   FROM GZDA_T DA                                                          ",
               "                  WHERE DA.GZDA001 = LOWER(ATC.OWNER)                                      ",
               "                    AND DA.GZDA005 = 'Y'                                                   ",
               "               )                                                                           ",
               "    AND EXISTS (                                                                           ",
               "                 SELECT 1                                                                  ",
               "                   FROM DZEA_T EA                                                          ",
               "                  WHERE EA.DZEA001 = LOWER(ATC.TABLE_NAME)                                 ",
               "               )                                                                           ",
               "  ORDER BY ATC.OWNER,ATC.TABLE_NAME, ATC.COLUMN_ID                                         "

  PREPARE lpre_get_data_from_real_schema FROM ls_sql
  DECLARE lcur_get_data_from_real_schema CURSOR FOR lpre_get_data_from_real_schema

  OPEN lcur_get_data_from_real_schema 
  FOREACH lcur_get_data_from_real_schema INTO lo_schema_information[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_data_from_real_schema

  CALL lo_schema_information.deleteElement(li_counts)
  
  FREE lpre_get_data_from_real_schema
  FREE lcur_get_data_from_real_schema

  LET lo_return = lo_schema_information

  RETURN lo_return
  
END FUNCTION

FUNCTION sadzp350_get_data_from_file(p_file_path)
DEFINE
  p_file_path STRING
DEFINE
  ls_file_path STRING

  LET ls_file_path = p_file_path
  
END FUNCTION

FUNCTION sadzp350_set_diff_base_data(p_guid,p_src_schema_information,p_dst_schema_information)
DEFINE
  p_guid            STRING,
  p_src_schema_information DYNAMIC ARRAY OF T_SCHEMA_INFORMATION,
  p_dst_schema_information DYNAMIC ARRAY OF T_SCHEMA_INFORMATION
DEFINE
  ls_guid  STRING,
  lo_src_schema_information DYNAMIC ARRAY OF T_SCHEMA_INFORMATION,
  lo_dst_schema_information DYNAMIC ARRAY OF T_SCHEMA_INFORMATION,
  lb_result  BOOLEAN,
  li_loop    INTEGER,
  li_count   INTEGER,
  lo_DZHG_T  T_DZHG_T,
  li_total_recs INTEGER
DEFINE
  lb_return BOOLEAN

  LET ls_guid = p_guid
  LET lo_src_schema_information = p_src_schema_information
  LET lo_dst_schema_information = p_dst_schema_information

  BEGIN WORK
  
  --Source
  LET li_count = 0
  LET li_total_recs = 0
  FOR li_loop = 1 TO lo_src_schema_information.getLength()
    LET lo_DZHG_T.DZHG001 = ls_guid
    LET lo_DZHG_T.DZHG002 = cs_data_source
    LET lo_DZHG_T.DZHG003 = lo_src_schema_information[li_loop].si_TYPE  
    LET lo_DZHG_T.DZHG004 = lo_src_schema_information[li_loop].si_SCHEMA_NAME  
    LET lo_DZHG_T.DZHG005 = lo_src_schema_information[li_loop].si_TABLE_NAME 
    LET lo_DZHG_T.DZHG006 = lo_src_schema_information[li_loop].si_COLUMN_NAME
    LET lo_DZHG_T.DZHG007 = lo_src_schema_information[li_loop].si_ISKEY      
    LET lo_DZHG_T.DZHG008 = lo_src_schema_information[li_loop].si_NULLABLE   
    LET lo_DZHG_T.DZHG009 = lo_src_schema_information[li_loop].si_DATA_TYPE  
    LET lo_DZHG_T.DZHG010 = lo_src_schema_information[li_loop].si_DATA_LENGTH
    LET lo_DZHG_T.DZHG011 = lo_src_schema_information[li_loop].si_COLUMN_ID  
    LET lo_DZHG_T.DZHG012 = CURRENT YEAR TO SECOND                           
    CALL sadzp350_crud_inser_dzhg_t(lo_DZHG_T.*) RETURNING lb_result
    
    LET li_count = li_count + 1
    LET li_total_recs = li_total_recs + 1
    IF li_count >= 1000 THEN
      DISPLAY cs_information_tag,"Source load ",li_total_recs," records."
      COMMIT WORK
      BEGIN WORK
      LET li_count = 0
    END IF 
    
  END FOR      
  DISPLAY cs_information_tag,"Source load ",li_total_recs," records."

  --Destination
  LET li_count = 0
  LET li_total_recs = 0
  FOR li_loop = 1 TO lo_dst_schema_information.getLength()
    LET lo_DZHG_T.DZHG001 = ls_guid
    LET lo_DZHG_T.DZHG002 = cs_data_dest
    LET lo_DZHG_T.DZHG003 = lo_dst_schema_information[li_loop].si_TYPE
    LET lo_DZHG_T.DZHG004 = lo_dst_schema_information[li_loop].si_SCHEMA_NAME  
    LET lo_DZHG_T.DZHG005 = lo_dst_schema_information[li_loop].si_TABLE_NAME 
    LET lo_DZHG_T.DZHG006 = lo_dst_schema_information[li_loop].si_COLUMN_NAME
    LET lo_DZHG_T.DZHG007 = lo_dst_schema_information[li_loop].si_ISKEY      
    LET lo_DZHG_T.DZHG008 = lo_dst_schema_information[li_loop].si_NULLABLE     
    LET lo_DZHG_T.DZHG009 = lo_dst_schema_information[li_loop].si_DATA_TYPE  
    LET lo_DZHG_T.DZHG010 = lo_dst_schema_information[li_loop].si_DATA_LENGTH
    LET lo_DZHG_T.DZHG011 = lo_dst_schema_information[li_loop].si_COLUMN_ID  
    LET lo_DZHG_T.DZHG012 = CURRENT YEAR TO SECOND                           
    CALL sadzp350_crud_inser_dzhg_t(lo_DZHG_T.*) RETURNING lb_result
    
    LET li_count = li_count + 1
    LET li_total_recs = li_total_recs + 1
    IF li_count >= 1000 THEN
      DISPLAY cs_information_tag,"Destination load ",li_total_recs," records."
      COMMIT WORK
      BEGIN WORK
      LET li_count = 0
    END IF
    
  END FOR      
  DISPLAY cs_information_tag,"Destination load ",li_total_recs," records."

  COMMIT WORK
  
  RETURN lb_return  

END FUNCTION

FUNCTION sadzp350_get_diff_result_records(p_diff_parameter)
DEFINE
  p_diff_parameter T_DIFF_PARAMETER
DEFINE
  lo_diff_parameter T_DIFF_PARAMETER,
  lo_DIFF_RECORDS   DYNAMIC ARRAY OF T_DIFF_RECORDS,  
  ls_sql    STRING,
  li_counts INTEGER
DEFINE
  lo_return  DYNAMIC ARRAY OF T_DIFF_RECORDS  
  
  LET lo_diff_parameter.* = p_diff_parameter.*

  IF lo_diff_parameter.dp_source_working_type IS NULL THEN
    LET lo_diff_parameter.dp_source_working_type = " HG.DZHG003 "
  ELSE 
    LET lo_diff_parameter.dp_source_working_type = " '",lo_diff_parameter.dp_source_working_type,"' "
  END IF
  
  IF lo_diff_parameter.dp_source_schema_name = cs_schema_owner_all OR
     lo_diff_parameter.dp_source_schema_name IS NULL THEN
    LET lo_diff_parameter.dp_source_schema_name = " HG.DZHG004 " 
  ELSE  
    LET lo_diff_parameter.dp_source_schema_name = " '",lo_diff_parameter.dp_source_schema_name,"' " 
  END IF

  IF lo_diff_parameter.dp_source_table_name = cs_schema_table_all OR
     lo_diff_parameter.dp_source_table_name IS NULL THEN
    LET lo_diff_parameter.dp_source_table_name = " HG.DZHG005 " 
  ELSE  
    LET lo_diff_parameter.dp_source_table_name = " '",lo_diff_parameter.dp_source_table_name,"' " 
  END IF

  IF lo_diff_parameter.dp_dest_working_type IS NULL THEN
    LET lo_diff_parameter.dp_dest_working_type = " HG.DZHG003 "
  ELSE 
    LET lo_diff_parameter.dp_dest_working_type = " '",lo_diff_parameter.dp_dest_working_type,"' "
  END IF
  
  IF lo_diff_parameter.dp_dest_schema_name = cs_schema_owner_all OR
     lo_diff_parameter.dp_dest_schema_name IS NULL THEN
    LET lo_diff_parameter.dp_dest_schema_name = " HG.DZHG004 "
  ELSE
    LET lo_diff_parameter.dp_dest_schema_name = " '",lo_diff_parameter.dp_dest_schema_name,"' "
  END IF

  IF lo_diff_parameter.dp_dest_table_name = cs_schema_table_all OR 
    lo_diff_parameter.dp_dest_table_name IS NULL THEN
    LET lo_diff_parameter.dp_dest_table_name = " HG.DZHG005 " 
  ELSE
    LET lo_diff_parameter.dp_dest_table_name = " '",lo_diff_parameter.dp_dest_table_name,"' " 
  END IF

  LET ls_sql = " SELECT SDATA.DZHG005,SDATA.DZHG006,SDATA.DZHG007,SDATA.DZHG008,SDATA.DZHG009,SDATA.DZHG010,     ",
               "        CASE                                                                                     ",
               "          WHEN SDATA.ALL_DATA IS NULL THEN '<'                                                   ",
               "          WHEN DDATA.ALL_DATA IS NULL THEN '>'                                                   ",
               "          WHEN SDATA.ALL_DATA = DDATA.ALL_DATA THEN '='                                          ",
               "          WHEN SDATA.ALL_DATA <> DDATA.ALL_DATA THEN '<>'                                        ",
               "        END AS DIFF,                                                                             ",
               "        DDATA.DZHG005,DDATA.DZHG006,DDATA.DZHG007,DDATA.DZHG008,DDATA.DZHG009,DDATA.DZHG010      ", 
               "   FROM (                                                                                        ",
               "          SELECT HG.DZHG005,HG.DZHG006                                                           ",
               "            FROM DZHG_T HG                                                                       ",
               "           WHERE HG.DZHG001 = '",lo_diff_parameter.dp_GUID,"'                                    ",
               "             AND HG.DZHG002 = '",cs_data_source,"'                                               ",
               "             AND HG.DZHG003 = ",lo_diff_parameter.dp_source_working_type,"                       ", --'DESIGN'
               "             AND HG.DZHG004 = ",lo_diff_parameter.dp_source_schema_name,"                        ", --'DESIGN'
               "             AND HG.DZHG005 = ",lo_diff_parameter.dp_source_table_name,"                         ", -- NULL
               "          UNION                                                                                  ",
               "          SELECT HG.DZHG005,HG.DZHG006                                                           ",
               "            FROM DZHG_T HG                                                                       ",
               "           WHERE HG.DZHG001 = '",lo_diff_parameter.dp_GUID,"'                                    ",
               "             AND HG.DZHG002 = '",cs_data_dest,"'                                                 ",
               "             AND HG.DZHG003 = ",lo_diff_parameter.dp_dest_working_type,"                         ", -- 'DB'
               "             AND HG.DZHG004 = ",lo_diff_parameter.dp_dest_schema_name,"                          ", -- 'DS'
               "             AND HG.DZHG005 = ",lo_diff_parameter.dp_dest_table_name,"                           ", --NULL
               "        ) ODATA                                                                                  ",
               "        LEFT OUTER JOIN                                                                          ",
               "        (                                                                                        ",
               "          SELECT HG.DZHG005,HG.DZHG006,HG.DZHG007,HG.DZHG008,HG.DZHG009,HG.DZHG010,              ",
               "                 HG.DZHG005||HG.DZHG006||HG.DZHG007||HG.DZHG008||HG.DZHG009||HG.DZHG010 ALL_DATA ",
               "            FROM DZHG_T HG                                                                       ",
               "           WHERE HG.DZHG001 = '",lo_diff_parameter.dp_GUID,"'                                    ",
               "             AND HG.DZHG002 = '",cs_data_source,"'                                               ",
               "             AND HG.DZHG003 = ",lo_diff_parameter.dp_source_working_type,"                       ", --'DESIGN' 
               "             AND HG.DZHG004 = ",lo_diff_parameter.dp_source_schema_name,"                        ", --'DESIGN'
               "             AND HG.DZHG005 = ",lo_diff_parameter.dp_source_table_name,"                         ", -- NULL
               "        ) SDATA ON SDATA.DZHG005 = ODATA.DZHG005                                                 ",
               "               AND SDATA.DZHG006 = ODATA.DZHG006                                                 ",
               "        LEFT OUTER JOIN                                                                          ",
               "        (                                                                                        ",
               "          SELECT HG.DZHG005,HG.DZHG006,HG.DZHG007,HG.DZHG008,HG.DZHG009,HG.DZHG010,              ",
               "                 HG.DZHG005||HG.DZHG006||HG.DZHG007||HG.DZHG008||HG.DZHG009||HG.DZHG010 ALL_DATA ",
               "            FROM DZHG_T HG                                                                       ",
               "           WHERE HG.DZHG001 = '",lo_diff_parameter.dp_GUID,"'                                    ",
               "             AND HG.DZHG002 = '",cs_data_dest,"'                                                 ",
               "             AND HG.DZHG003 = ",lo_diff_parameter.dp_dest_working_type,"                         ", -- 'DB' 
               "             AND HG.DZHG004 = ",lo_diff_parameter.dp_dest_schema_name,"                          ", -- 'DS'
               "             AND HG.DZHG005 = ",lo_diff_parameter.dp_dest_table_name,"                           ", --NULL
               "        ) DDATA ON DDATA.DZHG005 = ODATA.DZHG005                                                 ",
               "               AND DDATA.DZHG006 = ODATA.DZHG006                                                 ",
               "  WHERE 1=1                                                                                      ",
               "  ORDER BY ODATA.DZHG005,ODATA.DZHG006                                                           "

  LET li_counts = 1
  
  PREPARE lpre_get_diff_result_records FROM ls_sql
  DECLARE lcur_get_diff_result_records CURSOR FOR lpre_get_diff_result_records

  OPEN lcur_get_diff_result_records       
  FOREACH lcur_get_diff_result_records INTO lo_DIFF_RECORDS[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_diff_result_records

  CALL lo_DIFF_RECORDS.deleteElement(li_counts)
  
  FREE lpre_get_diff_result_records
  FREE lcur_get_diff_result_records               

  LET lo_return = lo_DIFF_RECORDS

  RETURN lo_return
  
END FUNCTION

FUNCTION sadzp350_export_to_document(p_doc_type,p_DIFF_RECORDS)
DEFINE
  p_doc_type  STRING,
  p_DIFF_RECORDS  DYNAMIC ARRAY OF T_DIFF_RECORDS
DEFINE
  ls_doc_type     STRING,
  lo_DIFF_RECORDS DYNAMIC ARRAY OF T_DIFF_RECORDS,
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
  LET lo_DIFF_RECORDS = p_DIFF_RECORDS

  LET ls_separator = os.Path.separator()

  #取得目前工作目錄
  CALL os.Path.pwd() RETURNING ls_curr_working_dir
  CALL sadzp350_util_making_work_directory(ls_doc_type) RETURNING lb_result,ls_path

  CASE
    WHEN ls_doc_type = cs_export_csv
      CALL sadzp350_export_document_to_csv(ls_path,lo_DIFF_RECORDS) RETURNING lb_result,ls_result
    WHEN ls_doc_type = cs_export_sql
      -- 尚未實做
  END CASE

  LET ls_full_path = ls_result
  DISPLAY cs_information_tag,"Generate document : ",ls_full_path

  RETURN lb_return,ls_full_path
  
END FUNCTION

FUNCTION sadzp350_export_document_to_csv(p_export_path,p_DIFF_RECORDS)
DEFINE
  p_export_path STRING,
  p_DIFF_RECORDS  DYNAMIC ARRAY OF T_DIFF_RECORDS
DEFINE
  ls_export_path  STRING,
  lo_DIFF_RECORDS DYNAMIC ARRAY OF T_DIFF_RECORDS,
  li_loop         INTEGER,
  ls_contents     STRING,
  ls_title        STRING,
  ls_result       STRING
DEFINE
  lb_return  BOOLEAN,
  ls_return  STRING
  
  LET ls_export_path = p_export_path
  LET lo_DIFF_RECORDS = p_DIFF_RECORDS

  LET ls_contents = ""
  LET lb_return = TRUE

  LET ls_title = '"","Source Data","","","","","","","Destination Data","","","","","",',
                 "\n", 
                 '"","Table Name","Column Name","Key Field","Allow Null","Data Type","Data Length","DIFF","Table Name","Column Name","Key Field","Allow Null","Data Type","Data Length",',
                 "\n" 
                 
  LET ls_contents = ls_contents,ls_title                 

  FOR li_loop = 1 TO lo_DIFF_RECORDS.getLength()
    LET ls_contents = ls_contents,
                      li_loop,",",
                      lo_DIFF_RECORDS[li_loop].dr_SDZHG005,",", 
                      lo_DIFF_RECORDS[li_loop].dr_SDZHG006,",", 
                      lo_DIFF_RECORDS[li_loop].dr_SDZHG007,",", 
                      lo_DIFF_RECORDS[li_loop].dr_SDZHG008,",", 
                      lo_DIFF_RECORDS[li_loop].dr_SDZHG009,",", 
                      lo_DIFF_RECORDS[li_loop].dr_SDZHG010,",",
                      lo_DIFF_RECORDS[li_loop].dr_DIFF,",",
                      lo_DIFF_RECORDS[li_loop].dr_DDZHG005,",",
                      lo_DIFF_RECORDS[li_loop].dr_DDZHG006,",",
                      lo_DIFF_RECORDS[li_loop].dr_DDZHG007,",",
                      lo_DIFF_RECORDS[li_loop].dr_DDZHG008,",",
                      lo_DIFF_RECORDS[li_loop].dr_DDZHG009,",",
                      lo_DIFF_RECORDS[li_loop].dr_DDZHG010,",",
                      "\n"
  END FOR

  CALL sadzp350_util_gen_diff_document(ls_export_path,ls_contents,cs_export_csv,ms_guid) RETURNING ls_result

  LET ls_return = ls_result

  RETURN lb_return,ls_return
  
END FUNCTION

