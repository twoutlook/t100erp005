&include "../4gl/sadzp241_mcr.inc"

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp241_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp240_type.inc"
&include "../4gl/sadzp241_type.inc"

#執行的環境變數
DEFINE 
  ms_lang         STRING,
  mb_backend_mode BOOLEAN,
  mo_arguments    T_ARGUMENTS,
  mb_result       BOOLEAN
            
FUNCTION sadzp241_run(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ARGUMENTS 
  
  CALL sadzp241_initialize(p_backend_mode,p_arguments.*)
  CALL sadzp241_start()
  CALL sadzp241_finalize()

  RETURN mb_result

END FUNCTION

FUNCTION sadzp241_initialize(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ARGUMENTS

  LET mb_backend_mode = p_backend_mode
  LET mo_arguments.*  = p_arguments.*

  &ifndef DEBUG
    LET ms_lang = NVL(g_lang,cs_default_lang)
  &else
    LET ms_lang = cs_default_lang
  &endif
  
END FUNCTION

FUNCTION sadzp241_start()
DEFINE
  lb_result        BOOLEAN,
  ls_table_list    STRING, 
  ls_current       STRING,
  lo_error_tables  DYNAMIC ARRAY OF T_ERROR_TABLES

  LET lb_result = TRUE

  IF mo_arguments.a_GUID IS NULL AND mo_arguments.a_path IS NOT NULL THEN 
    #如果GUID 為空而 path 不為空, 則直接執行 adzp888
    LET ls_current = sadzp241_get_datetime_current()
    DISPLAY cs_message_tag,ls_current," No define GUID and execute adzp888."
    CALL sadzp241_call_patch_merge(mo_arguments.*) RETURNING lb_result 
  ELSE 
    
    WHILE TRUE
    
      #先檢查有沒有表格(ADZ,AZZ)還在執行異動的
      CALL sadzp241_get_if_any_on_altering(mo_arguments.a_GUID) RETURNING lb_result
      #如果沒有就開始準備執行 adzp888 
      IF NOT lb_result THEN
        #查看看有沒有異動失敗的
        CALL sadzp241_get_alter_error_tables(mo_arguments.a_GUID) RETURNING lo_error_tables
        IF lo_error_tables.getLength() > 0 THEN
          #如果有失敗的, 就繼續等待
          LET ls_current = sadzp241_get_datetime_current()
          CALL sadzp241_get_alter_error_table_list(lo_error_tables) RETURNING ls_table_list
          DISPLAY cs_error_tag,ls_current," There are some table(s) alter with error, waiting for resubmit : ",ls_table_list
          SLEEP 5
          CONTINUE WHILE 
        ELSE
          IF mo_arguments.a_path IS NULL THEN
            LET ls_current = sadzp241_get_datetime_current()
            DISPLAY cs_error_tag,ls_current," The path for adzp888 is null, please redefine it !!"             
          ELSE 
            #如果都成功, 就開始執行 adzp888
            LET ls_current = sadzp241_get_datetime_current()
            DISPLAY cs_message_tag,ls_current," Alter system table(s) successed, continue execute adzp888."
            CALL sadzp241_call_patch_merge(mo_arguments.*) RETURNING lb_result
          END IF  
          EXIT WHILE 
        END IF  
      END IF 

      #每 3 秒檢查一次
      SLEEP 3
      LET ls_current = sadzp241_get_datetime_current()
      DISPLAY cs_message_tag,ls_current," System table on altering ..."
      
    END WHILE
    
  END IF  
  
END FUNCTION

FUNCTION sadzp241_finalize()
END FUNCTION

FUNCTION sadzp241_get_if_any_on_altering(p_guid)
DEFINE
  p_guid STRING
DEFINE
  ls_guid  STRING,
  ls_sql         STRING,
  li_rec_count   INTEGER
DEFINE  
  lb_return  BOOLEAN

  LET ls_guid = p_guid

  LET ls_sql = "SELECT COUNT(*)                    ",
               "  FROM DZEZ_T EZ                   ",
               " WHERE 1=1                         ",
               "   AND EZ.DZEZ007 IN ('ADZ','AZZ') ",
               "   AND EZ.DZEZ003 IN ('W','A','P') ",
               "   AND EZ.DZEZ001 = '",ls_guid,"'  "
                     
  PREPARE lpre_get_if_any_on_altering FROM ls_sql
  DECLARE lcur_get_if_any_on_altering CURSOR FOR lpre_get_if_any_on_altering
  OPEN lcur_get_if_any_on_altering
  FETCH lcur_get_if_any_on_altering INTO li_rec_count
  CLOSE lcur_get_if_any_on_altering
  FREE lcur_get_if_any_on_altering
  FREE lpre_get_if_any_on_altering

  LET li_rec_count = NVL(li_rec_count,0)
  LET lb_return = IIF(li_rec_count > 0,TRUE,FALSE)
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp241_get_alter_error_tables(p_GUID)
DEFINE
  p_GUID STRING
DEFINE
  ls_GUID          STRING,
  li_rec_count     INTEGER,
  ls_sql           STRING,
  lo_error_tables  DYNAMIC ARRAY OF T_ERROR_TABLES
DEFINE
  lo_return  DYNAMIC ARRAY OF T_ERROR_TABLES
  
  LET ls_GUID = p_GUID

  LET ls_sql = "SELECT EZ.DZEZ002                  ",
               "  FROM DZEZ_T EZ                   ",
               " WHERE 1=1                         ",
               "   AND EZ.DZEZ007 IN ('ADZ','AZZ') ",
               "   AND EZ.DZEZ003 = 'E'            ",
               "   AND EZ.DZEZ001 = '",ls_GUID,"'  ",
               " ORDER BY EZ.DZEZ002               "
   
  INITIALIZE lo_error_tables TO NULL
  
  PREPARE lpre_get_alter_error_tables FROM ls_sql
  DECLARE lcur_get_alter_error_tables CURSOR FOR lpre_get_alter_error_tables

  LET li_rec_count = 1

  OPEN lcur_get_alter_error_tables
  FOREACH lcur_get_alter_error_tables INTO lo_error_tables[li_rec_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

  END FOREACH
  CALL lo_error_tables.deleteElement(li_rec_count)
  
  CLOSE lpre_get_alter_error_tables
  CLOSE lcur_get_alter_error_tables
  
  LET lo_return = lo_error_tables
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzp241_get_alter_error_table_list(p_error_tables)
DEFINE
  p_error_tables  DYNAMIC ARRAY OF T_ERROR_TABLES
DEFINE
  lo_error_tables  DYNAMIC ARRAY OF T_ERROR_TABLES,
  li_loop       INTEGER,
  li_count      INTEGER,
  ls_table_list STRING
DEFINE
  ls_return  STRING

  LET lo_error_tables = p_error_tables

  LET ls_table_list = ""
  LET li_count = 0

  FOR li_loop = 1 TO lo_error_tables.getLength()
    LET ls_table_list = ls_table_list,lo_error_tables[li_loop].gt_TABLE_NAME,","

    LET li_count = li_count + 1
    
    IF li_count >= 10 THEN
      LET ls_table_list = ls_table_list,"\n"
      LET li_count = 0
    END IF 
       
  END FOR

  LET ls_table_list = ls_table_list.subString(1,ls_table_list.getLength()-1)
  LET ls_return = ls_table_list
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp241_call_patch_merge(p_arguments)
DEFINE
  p_arguments    T_ARGUMENTS 
DEFINE
  lo_arguments    T_ARGUMENTS ,
  ls_command      STRING,
  ls_program_name STRING,
  lb_success      BOOLEAN 

  LET lo_arguments.* = p_arguments.*

  LET ls_program_name = "adzp888"
  LET lb_success = TRUE
  
  LET ls_command = "r.r ",ls_program_name," '",lo_arguments.a_path,"' '' '",lo_arguments.a_refresh_cust_std_section,"'"
  DISPLAY cs_command_tag,ls_command

  RUN ls_command WITHOUT WAITING

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzp241_get_datetime_current()
DEFINE
  ls_current  STRING

  &ifndef DEBUG
    LET ls_current = cl_get_current()
  &else
    LET ls_current = CURRENT YEAR TO SECOND
  &endif

  RETURN ls_current

END FUNCTION