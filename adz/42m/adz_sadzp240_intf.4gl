&include "../4gl/sadzi140_mcr.inc"

IMPORT util 
IMPORT os 
IMPORT security
IMPORT xml

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp240_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp240_type.inc"

FUNCTION sadzp240_intf_insert_update_dzee_t(p_dzee_t)
DEFINE
  p_dzee_t  T_DZEE_T
DEFINE 
  lo_dzee_t T_DZEE_T

  LET lo_dzee_t.* = p_dzee_t.*

  TRY 
    INSERT INTO DZEE_T(
                        DZEE001,DZEE002,DZEE003,DZEE004,DZEE005,
                        DZEE006,DZEE007,DZEE008,DZEE009,DZEE010,
                        DZEE011
                      )
               VALUES (
                        lo_dzee_t.dzee001,lo_dzee_t.dzee002,lo_dzee_t.dzee003,lo_dzee_t.dzee004,lo_dzee_t.dzee005,
                        lo_dzee_t.dzee006,lo_dzee_t.dzee007,lo_dzee_t.dzee008,lo_dzee_t.dzee009,lo_dzee_t.dzee010,
                        lo_dzee_t.dzee011
                      )
  CATCH
    DISPLAY cs_warning_tag," Insert DZEE_T unsuccess."
    TRY
      UPDATE DZEE_T                                 
         SET DZEE003 = lo_dzee_t.dzee003,
             DZEE004 = lo_dzee_t.dzee004,
             DZEE005 = lo_dzee_t.dzee005,
             DZEE006 = NVL(DZEE006,lo_dzee_t.dzee006),
             DZEE007 = NVL(DZEE007,lo_dzee_t.dzee007),
             DZEE008 = lo_dzee_t.dzee008,
             DZEE009 = lo_dzee_t.dzee009,
             DZEE010 = lo_dzee_t.dzee010,
             DZEE011 = lo_dzee_t.dzee011
       WHERE DZEE001 = lo_dzee_t.dzee001
         AND DZEE002 = lo_dzee_t.dzee002
    CATCH
      DISPLAY cs_error_tag," Insert or Update DZEE_T unsuccess : ",SQLCA.sqlcode
    END TRY    
  END TRY

END FUNCTION

FUNCTION sadzp240_intf_set_status_code(p_dzee_t)
DEFINE
  p_dzee_t  T_DZEE_T
DEFINE 
  lo_dzee_t T_DZEE_T

  LET lo_dzee_t.* = p_dzee_t.*

  TRY
    UPDATE DZEE_T                                 
       SET DZEE005 = lo_dzee_t.dzee005
     WHERE DZEE001 = lo_dzee_t.dzee001
       AND DZEE002 = lo_dzee_t.dzee002
  CATCH
    DISPLAY cs_error_tag," Update status code unsuccess : ",SQLCA.sqlcode
  END TRY    

END FUNCTION

FUNCTION sadzp240_intf_set_start_time(p_dzee_t)
DEFINE
  p_dzee_t  T_DZEE_T
DEFINE 
  lo_dzee_t T_DZEE_T

  LET lo_dzee_t.* = p_dzee_t.*

  TRY
    UPDATE DZEE_T                                 
       SET DZEE007 = lo_dzee_t.dzee007,
           DZEE008 = NULL
     WHERE DZEE001 = lo_dzee_t.dzee001
       AND DZEE002 = lo_dzee_t.dzee002
  CATCH
    DISPLAY cs_error_tag," Update start time unsuccess : ",SQLCA.sqlcode
  END TRY    

END FUNCTION

FUNCTION sadzp240_intf_set_end_time(p_dzee_t)
DEFINE
  p_dzee_t  T_DZEE_T
DEFINE 
  lo_dzee_t T_DZEE_T

  LET lo_dzee_t.* = p_dzee_t.*

  TRY
    UPDATE DZEE_T                                 
       SET DZEE008 = lo_dzee_t.dzee008
     WHERE DZEE001 = lo_dzee_t.dzee001
       AND DZEE002 = lo_dzee_t.dzee002
  CATCH
    DISPLAY cs_error_tag," Update end time unsuccess : ",SQLCA.sqlcode
  END TRY    

END FUNCTION

FUNCTION sadzp240_intf_set_assigned_status(p_dzee_t)
DEFINE
  p_dzee_t  T_DZEE_T
DEFINE 
  lo_dzee_t T_DZEE_T

  LET lo_dzee_t.* = p_dzee_t.*

  TRY
    UPDATE DZEE_T                                 
       SET DZEE005 = lo_dzee_t.dzee005,
           DZEE006 = lo_dzee_t.dzee006,
           DZEE009 = lo_dzee_t.dzee009,
           DZEE010 = lo_dzee_t.dzee010,
           DZEE011 = lo_dzee_t.dzee011
     WHERE DZEE001 = lo_dzee_t.dzee001
       AND DZEE002 = lo_dzee_t.dzee002
  CATCH
    DISPLAY cs_error_tag," Update assigned status unsuccess : ",SQLCA.sqlcode
  END TRY    

END FUNCTION

FUNCTION sadzp240_intf_set_log_file_contents(p_dzee_t)
DEFINE
  p_dzee_t  T_DZEE_T
DEFINE 
  lo_dzee_t T_DZEE_T,
  ls_log_contents STRING,
  lo_dzee012 LIKE DZEE_T.dzee012
  
  LET lo_dzee_t.* = p_dzee_t.*

  #先取得子包dzee_t資訊
  CALL sadzp240_intf_get_sub_patch_information(lo_dzee_t.*) RETURNING lo_dzee_t.*
  
  #取得Log檔的內容
  LET ls_log_contents = ""
  CALL sadzp240_intf_get_log_file_contents(lo_dzee_t.DZEE010) RETURNING ls_log_contents

  IF ls_log_contents.trim() IS NOT NULL THEN
  
    LOCATE lo_dzee012 IN FILE

    LET lo_dzee012 = ls_log_contents
    TRY
      UPDATE DZEE_T                                 
         SET DZEE012 = lo_dzee012
       WHERE DZEE001 = lo_dzee_t.dzee001
         AND DZEE002 = lo_dzee_t.dzee002
    CATCH
      DISPLAY cs_error_tag," Update log file contents unsuccess : ",SQLCA.sqlcode
    END TRY    

    FREE lo_dzee012
    
  END IF  

END FUNCTION

FUNCTION sadzp240_intf_get_log_file_contents(p_FileName)
DEFINE
  p_FileName  STRING
DEFINE
  ls_FileName  STRING
DEFINE  
  lo_channel_read  base.Channel,
  ls_TextLine      STRING,
  li_RecCnt        INTEGER,
  lb_success       BOOLEAN
DEFINE
  ls_RETURN  STRING

  LET ls_FileName = p_FileName
  
  LET lb_success = TRUE
  LET ls_TextLine = ""

  LET lo_channel_read = base.Channel.create()
  TRY 
    CALL lo_channel_read.openFile(ls_FileName,"r")
  CATCH
    LET lb_success = FALSE
    DISPLAY cs_error_tag,"Open file ",ls_FileName," failed !!"
  END TRY  

  IF lb_success THEN
    LET li_RecCnt = 1 
    WHILE TRUE
      IF lo_channel_read.isEof() THEN 
        EXIT WHILE
      END IF

      LET ls_TextLine = ls_TextLine,lo_channel_read.readLine(),"\n"
      
      LET li_RecCnt = li_RecCnt + 1 
        
    END WHILE
  END IF
  
  LET ls_RETURN = ls_TextLine
  
  CALL lo_channel_read.close()
  
  RETURN ls_RETURN
  
END FUNCTION

FUNCTION sadzp240_intf_get_log_record_contents(p_dzee_t)
DEFINE
  p_dzee_t  T_DZEE_T
DEFINE 
  lo_dzee_t       T_DZEE_T,
  ls_log_contents STRING,
  ls_sql          STRING,  
  ls_check        STRING,
  lo_dzee012      LIKE DZEE_T.dzee012,
  lv_dzee012_tmp  VARCHAR(4000)
DEFINE
  ls_return STRING  
  
  LET lo_dzee_t.* = p_dzee_t.*

  LOCATE lo_dzee012 IN FILE
  
  LET ls_sql = "SELECT DZEE012                                         DZEE012,                                 ",
               "       TO_CHAR(SUBSTR((REPLACE(REPLACE(DZEE012, CHR(10), ''), CHR(13), '')),1,500)) DZEE012_TMP ", 
               "  FROM DZEE_T                                                                                   ", 
               " WHERE DZEE001 = '",lo_dzee_t.DZEE001,"'                                                        ",
               "   AND DZEE002 = '",lo_dzee_t.DZEE002,"'                                                        "
               
  PREPARE lpre_get_log_record_contents FROM ls_sql
  DECLARE lcur_get_log_record_contents CURSOR FOR lpre_get_log_record_contents

  OPEN lcur_get_log_record_contents
  FETCH lcur_get_log_record_contents INTO lo_dzee012,lv_dzee012_tmp
  CLOSE lcur_get_log_record_contents

  FREE lpre_get_log_record_contents
  FREE lcur_get_log_record_contents

  LET ls_check = lv_dzee012_tmp
  LET ls_check = ls_check.trim()

  IF (NVL(ls_check,cs_null_default) = cs_null_default) THEN 
    LET ls_return = ""
  ELSE 
    LET ls_return = lo_dzee012
  END IF

  FREE lo_dzee012

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp240_intf_generate_interface(p_patch_no,p_tar_list)
DEFINE
  p_patch_no STRING,
  p_tar_list DYNAMIC ARRAY OF T_TAR_LIST
DEFINE
  ls_patch_no  STRING,
  lo_tar_list  DYNAMIC ARRAY OF T_TAR_LIST,
  lo_dzee_t    T_DZEE_T,
  ls_GUID      STRING,
  li_tar_count INTEGER,
  ldt_datetime DATETIME YEAR TO SECOND
DEFINE
  ls_return STRING  

  LET ls_patch_no = p_patch_no
  LET lo_tar_list = p_tar_list

  LET ls_GUID = security.RandomGenerator.CreateUUIDString()

  BEGIN WORK 
  
  FOR li_tar_count = 1 TO lo_tar_list.getLength() 
    &ifndef DEBUG
    LET ldt_datetime = cl_get_current()
    &else
    LET ldt_datetime = CURRENT YEAR TO SECOND
    &endif
    LET lo_dzee_t.DZEE001 = ls_GUID
    LET lo_dzee_t.DZEE002 = lo_tar_list[li_tar_count].tl_SEQ_NO
    LET lo_dzee_t.DZEE003 = ls_patch_no
    LET lo_dzee_t.DZEE004 = lo_tar_list[li_tar_count].tl_TAR_NAME
    LET lo_dzee_t.DZEE005 = cs_state_waiting
    LET lo_dzee_t.DZEE006 = NULL
    LET lo_dzee_t.DZEE007 = NULL
    LET lo_dzee_t.DZEE008 = NULL
    LET lo_dzee_t.DZEE009 = NULL
    LET lo_dzee_t.DZEE010 = NULL
    LET lo_dzee_t.DZEE011 = NULL
    CALL sadzp240_intf_insert_update_dzee_t(lo_dzee_t.*)
  END FOR

  COMMIT WORK

  LET ls_return = ls_GUID
  
  RETURN ls_return

END FUNCTION 

FUNCTION sadzp240_intf_get_sub_patch_list(p_guid)
DEFINE
  p_guid STRING 
DEFINE
  ls_guid   STRING,
  ls_sql    STRING,
  li_counts INTEGER,
  lo_dzee_t DYNAMIC ARRAY OF T_DZEE_T 
DEFINE 
  lo_return DYNAMIC ARRAY OF T_DZEE_T 

  LET ls_guid = p_guid 

  LET li_counts = 1
  
  LET ls_sql = "SELECT DZEE001,DZEE002,DZEE003,DZEE004,DZEE005, ", 
               "       DZEE006,DZEE007,DZEE008,DZEE009,DZEE010, ",
               "       DZEE011                                  ", 
               "  FROM DZEE_T                                   ", 
               " WHERE DZEE001 = '",ls_guid,"'                  ",
               "   AND DZEE005 = '",cs_state_waiting,"'         ",
               " ORDER BY DZEE002                               "
               
  PREPARE lpre_get_sub_patch_list FROM ls_sql
  DECLARE lcur_get_sub_patch_list CURSOR FOR lpre_get_sub_patch_list

  OPEN lcur_get_sub_patch_list
  FOREACH lcur_get_sub_patch_list INTO lo_dzee_t[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_sub_patch_list

  CALL lo_dzee_t.deleteElement(li_counts)
  
  FREE lpre_get_sub_patch_list
  FREE lcur_get_sub_patch_list

  LET lo_return = lo_dzee_t

  RETURN lo_return
  
END FUNCTION

FUNCTION sadzp240_intf_get_sub_patch_information(p_dzee_t)
DEFINE
  p_dzee_t T_DZEE_T 
DEFINE
  lo_dzee_t T_DZEE_T, 
  ls_sql    STRING
DEFINE 
  lo_return T_DZEE_T 

  LET lo_dzee_t.* = p_dzee_t.* 

  LET ls_sql = "SELECT DZEE001,DZEE002,DZEE003,DZEE004,DZEE005, ", 
               "       DZEE006,DZEE007,DZEE008,DZEE009,DZEE010, ",
               "       DZEE011                                  ", 
               "  FROM DZEE_T                                   ", 
               " WHERE DZEE001 = '",lo_dzee_t.DZEE001,"'        ",
               "   AND DZEE002 = ?                              ",
               " ORDER BY DZEE002                               "
               
  PREPARE lpre_get_sub_patch_information FROM ls_sql
  DECLARE lcur_get_sub_patch_information CURSOR FOR lpre_get_sub_patch_information

  OPEN lcur_get_sub_patch_information USING lo_dzee_t.DZEE002
  FETCH lcur_get_sub_patch_information INTO lo_return.*
  CLOSE lcur_get_sub_patch_information

  FREE lpre_get_sub_patch_information
  FREE lcur_get_sub_patch_information

  RETURN lo_return.*
  
END FUNCTION

#取得正在處理中的個數
FUNCTION sadzp240_intf_get_on_exec_pack_counts(p_guid)
DEFINE
  p_guid STRING
DEFINE
  ls_guid  STRING,
  ls_sql         STRING,
  li_rec_count   INTEGER
DEFINE  
  li_return INTEGER

  LET ls_guid = p_guid

  LET ls_sql = "SELECT COUNT(*)                            ", 
               "  FROM DZEE_T                              ", 
               " WHERE DZEE001 = '",ls_guid,"'             ",
               "   AND DZEE005 = '",cs_state_processing,"' " 
                  
  PREPARE lpre_get_on_exec_pack_counts FROM ls_sql
  DECLARE lcur_get_on_exec_pack_counts CURSOR FOR lpre_get_on_exec_pack_counts
  OPEN lcur_get_on_exec_pack_counts
  FETCH lcur_get_on_exec_pack_counts INTO li_rec_count
  CLOSE lcur_get_on_exec_pack_counts
  FREE lcur_get_on_exec_pack_counts
  FREE lpre_get_on_exec_pack_counts

  LET li_return = NVL(li_rec_count,0)
  
  RETURN li_return
  
END FUNCTION

#取得已分派的個數
FUNCTION sadzp240_intf_get_assigned_pack_counts(p_guid)
DEFINE
  p_guid STRING
DEFINE
  ls_guid  STRING,
  ls_sql         STRING,
  li_rec_count   INTEGER
DEFINE  
  li_return INTEGER

  LET ls_guid = p_guid

  LET ls_sql = "SELECT COUNT(*)                          ", 
               "  FROM DZEE_T                            ", 
               " WHERE DZEE001 = '",ls_guid,"'           ",
               "   AND DZEE005 = '",cs_state_assigned,"' " 
                  
  PREPARE lpre_get_assigned_pack_counts FROM ls_sql
  DECLARE lcur_get_assigned_pack_counts CURSOR FOR lpre_get_assigned_pack_counts
  OPEN lcur_get_assigned_pack_counts
  FETCH lcur_get_assigned_pack_counts INTO li_rec_count
  CLOSE lcur_get_assigned_pack_counts
  FREE lcur_get_assigned_pack_counts
  FREE lpre_get_assigned_pack_counts

  LET li_return = NVL(li_rec_count,0)
  
  RETURN li_return
  
END FUNCTION

#取得有錯誤的個數
FUNCTION sadzp240_intf_get_error_pack_counts(p_guid)
DEFINE
  p_guid STRING
DEFINE
  ls_guid      STRING,
  ls_sql       STRING,
  li_rec_count INTEGER
DEFINE  
  li_return INTEGER

  LET ls_guid = p_guid

  LET ls_sql = "SELECT COUNT(*)                       ", 
               "  FROM DZEE_T                         ", 
               " WHERE DZEE001 = '",ls_guid,"'        ",
               "   AND DZEE005 = '",cs_state_error,"' " 
                  
  PREPARE lpre_get_error_pack_counts FROM ls_sql
  DECLARE lcur_get_error_pack_counts CURSOR FOR lpre_get_error_pack_counts
  OPEN lcur_get_error_pack_counts
  FETCH lcur_get_error_pack_counts INTO li_rec_count
  CLOSE lcur_get_error_pack_counts
  FREE lcur_get_error_pack_counts
  FREE lpre_get_error_pack_counts

  LET li_return = NVL(li_rec_count,0)
  
  RETURN li_return
  
END FUNCTION

FUNCTION sadzp240_intf_get_if_any_error(p_guid)
DEFINE
  p_guid STRING
DEFINE
  ls_guid    STRING,
  li_counts  INTEGER
DEFINE  
  lb_return BOOLEAN

  LET ls_guid = p_guid

  CALL sadzp240_intf_get_error_pack_counts(ls_guid) RETURNING li_counts
  
  LET lb_return = IIF(li_counts==0,FALSE,TRUE)
  
  RETURN lb_return
  
END FUNCTION

#取得是否已經完成所有工作(皆已經Sign上完成時間)
FUNCTION sadzp240_intf_get_finished_time_counts(p_guid)
DEFINE
  p_guid STRING
DEFINE
  ls_guid      STRING,
  ls_sql       STRING,
  li_rec_count INTEGER
DEFINE  
  li_return INTEGER

  LET ls_guid = p_guid

  LET ls_sql = "SELECT COUNT(*)                ", 
               "  FROM DZEE_T                  ", 
               " WHERE DZEE001 = '",ls_guid,"' ",
               "   AND DZEE008 IS NULL         " 
                  
  PREPARE lpre_get_finished_time_counts FROM ls_sql
  DECLARE lcur_get_finished_time_counts CURSOR FOR lpre_get_finished_time_counts
  OPEN lcur_get_finished_time_counts
  FETCH lcur_get_finished_time_counts INTO li_rec_count
  CLOSE lcur_get_finished_time_counts
  FREE lcur_get_finished_time_counts
  FREE lpre_get_finished_time_counts

  LET li_return = NVL(li_rec_count,0)
  
  RETURN li_return
  
END FUNCTION

FUNCTION sadzp240_intf_get_if_all_finished(p_guid)
DEFINE
  p_guid STRING
DEFINE
  ls_guid    STRING,
  li_counts  INTEGER
DEFINE  
  lb_return BOOLEAN

  LET ls_guid = p_guid

  CALL sadzp240_intf_get_finished_time_counts(ls_guid) RETURNING li_counts
  
  LET lb_return = IIF(li_counts==0,TRUE,FALSE)
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp240_intf_kill_expired_interface_data()
DEFINE
  ls_exec_sql     STRING,
  ls_reserve_days STRING,
  lb_result       BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET lb_return = TRUE
  
  #取得預設的Log保留天數
  CALL sadzp240_util_get_parameter(cs_param_level_log,cs_param_reserve_days) RETURNING ls_reserve_days
  LET ls_reserve_days = NVL(ls_reserve_days,cs_default_log_reserve_days)

  CALL sadzp240_intf_kill_dzez_data(ls_reserve_days) RETURNING lb_result
  IF NOT lb_result THEN LET lb_return = FALSE END IF
  CALL sadzp240_intf_kill_dzee_data(ls_reserve_days) RETURNING lb_result
  IF NOT lb_result THEN LET lb_return = FALSE END IF

  RETURN lb_return  
  
END FUNCTION 

FUNCTION sadzp240_intf_kill_dzee_data(p_reserve_days)
DEFINE
  p_reserve_days STRING
DEFINE
  ls_exec_sql     STRING,
  ls_reserve_days STRING
DEFINE
  lb_return BOOLEAN  

  LET lb_return = TRUE

  LET ls_reserve_days = p_reserve_days
  
  #刪除過期的 Interface 資料
  LET ls_exec_sql = "DELETE FROM DZEE_T                                          ",
                    " WHERE DZEE006 <= TRUNC(SYSTIMESTAMP) - ",ls_reserve_days," "
                    
  BEGIN WORK

  TRY
    PREPARE lpre_kill_dzee_data FROM ls_exec_sql
    EXECUTE lpre_kill_dzee_data
    COMMIT WORK
  CATCH
    LET lb_return = FALSE
    DISPLAY cs_error_tag,"Execute SQL ",ls_exec_sql," not success." 
    ROLLBACK WORK
  END TRY

  RETURN lb_return  
  
END FUNCTION 

FUNCTION sadzp240_intf_kill_dzez_data(p_reserve_days)
DEFINE
  p_reserve_days STRING
DEFINE
  ls_exec_sql     STRING,
  ls_reserve_days STRING
DEFINE
  lb_return BOOLEAN  

  LET lb_return = TRUE

  LET ls_reserve_days = p_reserve_days
  
  #刪除過期的 Interface 資料
  LET ls_exec_sql = "DELETE FROM DZEZ_T EZ                                                          ",                     
                    " WHERE 1=1                                                                     ",
                    "   AND EXISTS (                                                                ",
                    "                SELECT 1                                                       ",
                    "                  FROM DZEE_T EE                                               ",
                    "                 WHERE EE.DZEE001 = EZ.DZEZ001                                 ",
                    "                   AND EE.DZEE006 <= TRUNC(SYSTIMESTAMP) - ",ls_reserve_days," ", 
                    "              )                                                                "                    
                    
  BEGIN WORK

  TRY
    PREPARE lpre_kill_dzez_data FROM ls_exec_sql
    EXECUTE lpre_kill_dzez_data
    COMMIT WORK
  CATCH
    LET lb_return = FALSE
    DISPLAY cs_error_tag,"Execute SQL ",ls_exec_sql," not success." 
    ROLLBACK WORK
  END TRY

  RETURN lb_return  
  
END FUNCTION 

FUNCTION sadzp240_intf_get_all_log_records(p_GUID)
DEFINE
  p_GUID  STRING
DEFINE 
  ls_GUID         STRING,
  ls_log_contents STRING,
  ls_sql          STRING,  
  ls_logs         STRING,
  lo_dzee012      LIKE DZEE_T.dzee012,
  ls_dzee012      STRING,
  lv_dzee012_tmp  VARCHAR(4000),
  ls_dzee012_tmp  STRING,
  lv_dzee010      VARCHAR(600),
  ls_dzee010      STRING  
DEFINE
  ls_return STRING  
  
  LET ls_GUID = p_GUID

  LOCATE lo_dzee012 IN FILE
  
  LET ls_sql = "SELECT DZEE010,DZEE012,                                                                          ",
               "       TO_CHAR(SUBSTR((REPLACE(REPLACE(DZEE012, CHR(10), ''), CHR(13), '')),1,500)) DZEE012_TMP  ",
               "  FROM DZEE_T                                                                                    ",                                                           
               " WHERE DZEE001 = '",ls_GUID,"'                                                                   "
               
  PREPARE lpre_get_all_log_records FROM ls_sql
  DECLARE lcur_get_all_log_records CURSOR FOR lpre_get_all_log_records

  OPEN lcur_get_all_log_records
  FOREACH lcur_get_all_log_records INTO lv_dzee010,lo_dzee012,lv_dzee012_tmp
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_dzee010 = lv_dzee010
    LET ls_dzee012 = lo_dzee012
    LET ls_dzee012_tmp = lv_dzee012_tmp

    IF ls_dzee012_tmp.trim() = "" THEN
      #抓不到內容, 換抓實體檔案
      CALL sadzp240_intf_get_log_file_contents(ls_dzee010) RETURNING ls_dzee012  
    END IF 
    
    LET ls_logs = ls_logs,"\n",
                  "Log File : ",ls_dzee010,"\n", 
                  ls_dzee012 

    LET lo_dzee012 = NULL                  

  END FOREACH
  CLOSE lcur_get_all_log_records

  FREE lpre_get_all_log_records
  FREE lcur_get_all_log_records

  LET ls_return = ls_logs

  FREE lo_dzee012

  RETURN ls_return
  
END FUNCTION

#重新設定屬於 MDM 模組有錯誤的包
FUNCTION sadzp240_intf_reset_mdm_packages(p_guid)
DEFINE
  p_guid  STRING
DEFINE
  ls_guid    STRING,
  ls_mdm_obj_list STRING,
  li_result  INTEGER, 
  lo_dzee_t  DYNAMIC ARRAY OF T_DZEE_T,
  li_loop    INTEGER
DEFINE
  lb_result  BOOLEAN  

  LET ls_guid = p_guid
  
  LET lb_result = FALSE

  CALL sadzp240_intf_get_if_any_wip_sub_patch(ls_guid) RETURNING li_result

  #如果沒有正在處理中的包
  IF li_result = 0 THEN 
    CALL sadzp240_intf_get_mdm_err_sub_patch(ls_guid) RETURNING lo_dzee_t
    IF lo_dzee_t.getLength() > 0 THEN
      FOR li_loop = 1 TO lo_dzee_t.getLength()
        #將該小包重設為 Waiting 
        LET lo_dzee_t[li_loop].DZEE005 = cs_state_waiting
        CALL sadzp240_intf_set_status_code(lo_dzee_t[li_loop].*) 
      END FOR
      LET lb_result = TRUE
    END IF
  END IF

  RETURN lb_result  
  
END FUNCTION

#取得是否有任何未處理或處理中的包
FUNCTION sadzp240_intf_get_if_any_wip_sub_patch(p_guid)
DEFINE
  p_guid STRING
DEFINE
  ls_guid       STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER
DEFINE  
  lb_return BOOLEAN

  LET ls_guid = p_guid

  LET ls_sql = "SELECT COUNT(*)                                                                                 ",
               "  FROM DZEE_T EE                                                                                ",
               " WHERE 1=1                                                                                      ",
               "   AND EE.DZEE001 = '",ls_guid,"'                                                               ",
               "   AND EE.DZEE005 IN ('",cs_state_waiting,"','",cs_state_assigned,"','",cs_state_processing,"') "
                  
  PREPARE lpre_get_if_any_wip_sub_patch FROM ls_sql
  DECLARE lcur_get_if_any_wip_sub_patch CURSOR FOR lpre_get_if_any_wip_sub_patch
  OPEN lcur_get_if_any_wip_sub_patch
  FETCH lcur_get_if_any_wip_sub_patch INTO li_rec_count
  CLOSE lcur_get_if_any_wip_sub_patch
  FREE lcur_get_if_any_wip_sub_patch
  FREE lpre_get_if_any_wip_sub_patch

  LET lb_return = IIF(NVL(li_rec_count,0)==0,FALSE,TRUE)
  
  RETURN lb_return
  
END FUNCTION

#取得屬於MDM模組中有錯誤的子包
FUNCTION sadzp240_intf_get_mdm_err_sub_patch(p_guid)
DEFINE
  p_guid  STRING
DEFINE
  ls_guid    STRING,
  ls_sql     STRING,
  li_counts  INTEGER,
  lo_dzee_t  DYNAMIC ARRAY OF T_DZEE_T 
DEFINE 
  lo_return DYNAMIC ARRAY OF T_DZEE_T 

  LET ls_guid = p_guid 

  LET li_counts = 1
  
  LET ls_sql = "SELECT DZEE001,DZEE002,DZEE003,DZEE004,DZEE005,             ", 
               "       DZEE006,DZEE007,DZEE008,DZEE009,DZEE010,             ",
               "       DZEE011                                              ", 
               "  FROM DZEE_T EE                                            ", 
               " WHERE EE.DZEE001 = '",ls_guid,"'                           ",
               "   AND EE.DZEE005 = '",cs_state_error,"'                    ",
               "   AND EXISTS (                                             ",
               "                SELECT 1                                    ",
               "                  FROM DZEZ_T EZ                            ",
               "                 WHERE EZ.DZEZ001 = EE.DZEE001              ",
               "                   AND NVL(EZ.DZEZ007,'XXX') = 'MDM'        ",
               "              )                                             ",
               " ORDER BY DZEE002                                           "
               
  PREPARE lpre_get_mdm_err_sub_patch FROM ls_sql
  DECLARE lcur_get_mdm_err_sub_patch CURSOR FOR lpre_get_mdm_err_sub_patch

  OPEN lcur_get_mdm_err_sub_patch
  FOREACH lcur_get_mdm_err_sub_patch INTO lo_dzee_t[li_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_counts = li_counts + 1

  END FOREACH
  CLOSE lcur_get_mdm_err_sub_patch

  CALL lo_dzee_t.deleteElement(li_counts)
  
  FREE lpre_get_mdm_err_sub_patch
  FREE lcur_get_mdm_err_sub_patch

  LET lo_return = lo_dzee_t

  RETURN lo_return
  
END FUNCTION