
&include "../4gl/sadzp310_mcr.inc" 

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"

&include "../4gl/sadzp310_type.inc"

&ifndef DEBUG
GLOBALS "../../cfg/top_global.inc"
&endif

DEFINE
  mo_COMPRESS_FILE_INFO   T_COMPRESS_FILE_INFO,
  mb_backend_mode BOOLEAN,
  mb_result       BOOLEAN,
  ms_result       STRING

FUNCTION sadzp310_asmv_run(p_backend_mode,p_COMPRESS_FILE_INFO)
DEFINE
  p_backend_mode BOOLEAN,
  p_COMPRESS_FILE_INFO     T_COMPRESS_FILE_INFO
  
  CALL sadzp310_asmv_initialize(p_backend_mode,p_COMPRESS_FILE_INFO.*)
  CALL sadzp310_asmv_start()
  CALL sadzp310_asmv_finalize()

  RETURN mb_result,ms_result

END FUNCTION 

FUNCTION sadzp310_asmv_initialize(p_backend_mode,p_COMPRESS_FILE_INFO)
DEFINE
  p_backend_mode BOOLEAN,
  p_COMPRESS_FILE_INFO     T_COMPRESS_FILE_INFO
  
  LET mb_backend_mode = p_backend_mode
  LET mo_COMPRESS_FILE_INFO.* = p_COMPRESS_FILE_INFO.*
  
END FUNCTION 

FUNCTION sadzp310_asmv_start()
DEFINE
  lo_T_DZIV_T DYNAMIC ARRAY OF T_DZIV_T,
  lo_jsonobj  util.JSONObject,
  ls_message  STRING,
  lb_result   BOOLEAN

  #取得 View 設計資料
  CALL sadzp310_asmv_get_dziv_t_data(mo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME) RETURNING lo_T_DZIV_T
  #實際建制
  CALL sadzp310_asmv_create_replace_view(lo_T_DZIV_T) RETURNING lb_result, ls_message

  LET ms_result = ls_message
  LET mb_result = lb_result

  #更新 View 的狀態
  #20160706 begin
  {
  IF (lb_result) THEN
    INITIALIZE lo_jsonobj TO NULL 
  ELSE 
    LET lo_jsonobj = util.JSONObject.create()
    CALL lo_jsonobj.put("status", "X") #view 建構失敗，顯示失效中
  END IF 
  CALL sadzp310_asmv_get_and_set_view_status(lo_T_DZIV_T, lo_jsonobj ) RETURNING lb_result
  }
  #20160706 begin
  CALL sadzp310_asmv_get_and_set_view_status(lo_T_DZIV_T) RETURNING lb_result
  
END FUNCTION 

FUNCTION sadzp310_asmv_finalize()
END FUNCTION 

FUNCTION sadzp310_asmv_get_dziv_t_data(p_object_name)
DEFINE
  p_object_name STRING
DEFINE
  ls_object_name STRING,
  ls_SQL         STRING,
  li_rec_count   INTEGER,
  lo_T_DZIV_T    DYNAMIC ARRAY OF T_DZIV_T
DEFINE
  lo_return  DYNAMIC ARRAY OF T_DZIV_T

  LET ls_object_name = p_object_name.toLowerCase()

  LET ls_sql = "SELECT IV.DZIV001,IV.DZIV002,IV.DZIV003,IV.DZIV004,IV.DZIV005,         ",
               "       IV.DZIV006                                                      ",
               "  FROM DZIV_T IV                                                       ",
               " INNER JOIN (                                                          ", #20160706 ernest begin
               "              SELECT IV0.DZIV001,IV0.DZIV002,MIN(IV0.DZIV003) DZIV003  ",
               "                FROM DZIV_T IV0                                        ",
               "               GROUP BY DZIV001,DZIV002                                ",
               "            ) IV2 ON IV.DZIV001 = IV2.DZIV001                          ",
               "                 AND IV.DZIV002 = IV2.DZIV002                          ",
               "                 AND IV.DZIV003 = IV2.DZIV003                          ", #20160706 ernest end
               #20160706 ernest mark begin
               { 
               " INNER JOIN ( SELECT DISTINCT DZIV001,DZIV002,         ",  #判斷當標準與客製同時存在時只顯示客製
               "                     CASE WHEN EXISTS (                ", 
               "SELECT 1                                               ",
               "   FROM DZIV_T IV2                                     ",
               "  WHERE IV2.DZIV001 = IV1.DZIV001                      ",
               "    AND IV2.DZIV002 = IV1.DZIV002                      ", 
               "    AND IV2.DZIV003 = '", cs_dgenv_cust, "'            ",   
               "                                       )               ", 
               "                      THEN '", cs_dgenv_cust, "'       ", 
               "                      ELSE '", cs_dgenv_stand, "'      ",
               "                      END AS DZIV003                   ",  
               "                FROM (                              ",
               "                     SELECT IV0.DZIV001, IV0.DZIV002, IV0.DZIV003 ",
               "                       FROM DZIV_T IV0                            ", 
               "                     ) IV1                                        ",
               "            ) IV2 ON IV.DZIV001 = IV2.DZIV001 AND IV.DZIV002 = IV2.DZIV002 AND IV.DZIV003 = IV2.DZIV003 ",
               } 
               #20160706 ernest mark end
               " WHERE 1=1                                                             ",
               "   AND IV.DZIV001 = '",ls_object_name,"'                               ",
               "   AND IV.DZIV002 <> '",cs_template_words,"'                           ",
               "   AND IV.DZIV002 IN ('", cs_alias_erp_db, "', '", cs_alias_aws_db,"') ", # ver 160525.01 
               " ORDER BY IV.DZIV001                                                   "

  INITIALIZE lo_T_DZIV_T TO NULL
  
  PREPARE lpre_get_dziv_t_data FROM ls_sql
  DECLARE lcur_get_dziv_t_data CURSOR FOR lpre_get_dziv_t_data

  LET li_rec_count = 1
  LOCATE lo_T_DZIV_T[li_rec_count].DZIV004 IN FILE

  OPEN lcur_get_dziv_t_data
  FOREACH lcur_get_dziv_t_data INTO lo_T_DZIV_T[li_rec_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1
    LOCATE lo_T_DZIV_T[li_rec_count].DZIV004 IN FILE

  END FOREACH
  CALL lo_T_DZIV_T.deleteElement(li_rec_count)
  
  CLOSE lpre_get_dziv_t_data
  CLOSE lcur_get_dziv_t_data

  LET lo_return = lo_T_DZIV_T

  RETURN lo_return

END FUNCTION

################################################################################
# Descriptions...: 實際執行建構 View
# Memo...........: 
# Usage..........: CALL sadzp310_asmv_create_replace_view(lo_T_DZIV_T) 
#                :      RETURNING lb_result,ls_message
# Input parameter: p_T_DZIV_T  預建構的VIEW資料
# Return code....: lb_result   建構是否成功
#                : ls_message  建構執行日誌
# Date & Author..: 
# Modify.........: 20160330 by CircleLai
################################################################################
FUNCTION sadzp310_asmv_create_replace_view(p_T_DZIV_T)
DEFINE 
  p_T_DZIV_T     DYNAMIC ARRAY OF T_DZIV_T
DEFINE 
  lo_T_DZIV_T     DYNAMIC ARRAY OF T_DZIV_T,
  lo_schema_list  DYNAMIC ARRAY OF LIKE DZEJ_T.DZEJ007, 
  lo_db_coxn      T_DB_COXN_STR,
  lo_str_buf      base.StringBuffer,
  li_loop         INTEGER,
  li_idx          INTEGER,
  ls_dziv004      STRING,
  ls_mdm_name     STRING,
  ls_erp_name     STRING,
  ls_SQL_file     STRING,
  ls_view_sql     STRING,
  ls_message      STRING,
  ls_all_message  STRING,
  ls_check_error  STRING,
  lb_result       BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET lo_T_DZIV_T = p_T_DZIV_T
  LET lb_return = TRUE
  LET lo_str_buf = base.StringBuffer.create()

  FOR li_loop = 1 TO lo_T_DZIV_T.getLength()
    #20160706 mark begin
    {
    IF (lo_T_DZIV_T[li_loop].DZIV002 == cs_alias_erp_db 
        OR lo_T_DZIV_T[li_loop].DZIV002 == cs_alias_aws_db ) THEN
      CALL sadzp310_util_trans_schema_queue_to_array(lo_T_DZIV_T[li_loop].DZIV002) RETURNING lo_schema_list
    ELSE
      LET lo_schema_list[1] = lo_T_DZIV_T[li_loop].DZIV002
    END IF
    }
    #20160706 mark end
    CALL sadzp310_util_trans_schema_queue_to_array(lo_T_DZIV_T[li_loop].DZIV002) RETURNING lo_schema_list
    
    FOR li_idx = 1 TO lo_schema_list.getLength()
      IF (lo_schema_list[li_idx] == 'ds') THEN CONTINUE FOR END IF 
      DISPLAY cs_information_tag, "Alter view ", lo_T_DZIV_T[li_loop].DZIV001,
                                  " for schema : ", lo_schema_list[li_idx], "\n"
      #先取得資料庫連接資訊
      CALL sadzp310_db_get_db_connect_string(lo_schema_list[li_idx]) RETURNING lo_db_coxn.*
      
      # 替換代名詞
      CALL sadzp310_util_get_mdmdb_name(lo_schema_list[li_idx]) RETURNING ls_mdm_name
      CALL sadzp310_util_get_erpdb_name(lo_schema_list[li_idx]) RETURNING ls_erp_name
      
      CALL lo_str_buf.clear()
      CALL lo_str_buf.append(lo_T_DZIV_T[li_loop].DZIV004)
      CALL lo_str_buf.replace(cs_identify_aws_db, ls_mdm_name,0) #置換{AWSDB}
      CALL lo_str_buf.replace(cs_identify_erp_db, ls_erp_name,0) #置換{ERPDB}
      CALL lo_str_buf.replace(cs_identify_mdm_db, ls_mdm_name,0) #置換{MDMDB}
      
      CALL lo_str_buf.toString() RETURNING ls_dziv004
      
      #產出 Create / Replace Trigger SQL File
      LET ls_view_sql = ls_dziv004,"\n",cs_sql_go_sign 
      
      CALL sadzp310_util_gen_sql_script_file(ls_view_sql,cs_create_trigger) RETURNING ls_SQL_file 
      LET lo_db_coxn.db_sql_filename = ls_SQL_file
      
      #該有的資訊都有, 就執行
      IF NVL(lo_db_coxn.db_username,cs_null_value) <> cs_null_value AND 
         NVL(lo_db_coxn.db_password,cs_null_value) <> cs_null_value THEN
        CALL sadzp310_db_sqlplus(lo_db_coxn.*) RETURNING ls_message
      ELSE
        LET ls_message = cs_warning_tag,"User name or password can not be null for ",lo_T_DZIV_T[li_loop].DZIV002
        DISPLAY ls_message 
        CONTINUE FOR
      END IF
      
      #紀錄執行日誌
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Create or Replace View.[", lo_T_DZIV_T[li_loop].DZIV001, "]", "\n", 
                           "User : ",lo_db_coxn.db_username,"\n",
                           ls_message
                           
      #異動過程中任一區域有任何錯誤, 就終止異動
      LET ls_check_error = ls_all_message.toUpperCase()
      IF (ls_check_error.getIndexOf("ERROR",1) > 0) THEN 
        LET lb_return = FALSE
        EXIT FOR
      END IF
      
    END FOR
    
    IF (NOT lb_return) THEN EXIT FOR END IF
    
  END FOR

  RETURN lb_return, ls_all_message

END FUNCTION

--FUNCTION sadzp310_asmv_get_and_set_view_status(p_dziv_t, p_jsonobj)
FUNCTION sadzp310_asmv_get_and_set_view_status(p_dziv_t)
DEFINE
  p_dziv_t  DYNAMIC ARRAY OF T_DZIV_T
  --p_jsonobj util.JSONObject  --status
DEFINE
  lo_dziv_t        DYNAMIC ARRAY OF T_DZIV_T,
  ls_view_status   STRING,
  lb_result        BOOLEAN,
  lb_status        BOOLEAN,
  li_loop          INTEGER
DEFINE
  lb_return BOOLEAN
  
  LET lo_dziv_t = p_dziv_t 
  LET ls_view_status = cs_view_status_created

  #20160706 begin
  {
  LET lb_result = TRUE
  INITIALIZE ls_status TO NULL 
  
  IF (p_jsonobj IS NOT NULL ) THEN
    IF (p_jsonobj.has("status")) THEN
      LET ls_status = p_jsonobj.get("status")
    END IF 
  END IF 

  IF (ls_status IS NOT NULL ) THEN #使用傳入的狀態
    FOR li_loop = 1 TO lo_dziv_t.getLength()
      LET lo_dziv_t[li_loop].DZIV005 = ls_status
      CALL sadzp310_asmv_set_view_status(lo_dziv_t[li_loop].*) RETURNING lb_status
      IF NOT lb_status THEN LET lb_result = FALSE END IF
    END FOR  
  ELSE  #檢查view 使否建立 已建立 Y , 未建立 N
    FOR li_loop = 1 TO lo_dziv_t.getLength()
      CALL sadzp310_asmv_get_view_status(lo_dziv_t[li_loop].DZIV002, lo_dziv_t[li_loop].DZIV001) RETURNING ls_status
      LET lo_dziv_t[li_loop].DZIV005 = ls_status
      CALL sadzp310_asmv_set_view_status(lo_dziv_t[li_loop].*) RETURNING lb_status
      IF NOT lb_status THEN LET lb_result = FALSE END IF
    END FOR  
  END IF 
  }
  #20160706 end

  FOR li_loop = 1 TO lo_dziv_t.getLength()
    #檢核是否有任何 View 不存在, 如果都沒有, 就掛上未建立
    CALL sadzp310_util_check_view_exists(lo_dziv_t[li_loop].*) RETURNING lb_result 
    IF NOT lb_result THEN LET ls_view_status = cs_view_status_uncreated GOTO _VIEW_STATUS END IF

    #檢核View是否有無效建立, 若有, 則掛上失效中
    CALL sadzp310_util_check_view_if_invalid(lo_dziv_t[li_loop].DZIV001) RETURNING lb_result
    IF lb_result THEN LET ls_view_status = cs_view_status_invalid GOTO _VIEW_STATUS END IF  

    #檢核View Data是否比較新, 若是, 則掛上失效中
    CALL sadzp310_util_check_view_if_expired(lo_dziv_t[li_loop].*) RETURNING lb_result 
    IF lb_result THEN LET ls_view_status = cs_view_status_invalid GOTO _VIEW_STATUS END IF
    
    LABEL _VIEW_STATUS:
    
    LET lo_dziv_t[li_loop].DZIV005 = ls_view_status
    CALL sadzp310_asmv_set_view_status(lo_dziv_t[li_loop].*) RETURNING lb_result
  END FOR  
  
  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzp310_asmv_get_view_status(p_owner,p_view_name)
DEFINE
  p_owner        STRING,
  p_view_name STRING
DEFINE
  ls_owner      STRING,
  ls_view_name  STRING,
  ls_sql        STRING,
  li_counts     INTEGER
DEFINE
  ls_return  STRING
  
  LET ls_owner = p_owner.toUpperCase()
  LET ls_view_name = p_view_name.toUpperCase()
  
  CALL sadzp310_util_decode_columns(p_owner) RETURNING ls_owner 
  LET ls_owner = ls_owner.toUpperCase()
  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                           ",
               "  FROM DBA_VIEWS DVS                      ",
               " WHERE DVS.OWNER in (",ls_owner,")        ",
               "   AND DVS.VIEW_NAME = '",ls_view_name,"' "               
               
  PREPARE lpre_get_view_status FROM ls_sql
  DECLARE lcur_get_view_status CURSOR FOR lpre_get_view_status
  OPEN lcur_get_view_status
  FETCH lcur_get_view_status INTO li_counts
  CLOSE lcur_get_view_status
  FREE lcur_get_view_status
  FREE lpre_get_view_status

  LET ls_return = IIF(li_counts >= 1,"Y","N")
  LET ls_return = ls_return.trim()
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp310_asmv_set_view_status(p_dziv_t)
DEFINE
  p_dziv_t T_DZIV_T
DEFINE  
  lo_dziv_t  T_DZIV_T,
  lb_success BOOLEAN
DEFINE
  lb_return  BOOLEAN

  LET lo_dziv_t.* = p_dziv_t.*
  
  LET lb_success = TRUE

  TRY
  
    UPDATE DZIV_T                                 
       SET DZIV005 = lo_dziv_t.DZIV005
     WHERE DZIV001 = lo_dziv_t.dziv001
       AND DZIV002 = lo_dziv_t.dziv002
       AND DZIV003 = lo_dziv_t.dziv003
       
  CATCH
    LET lb_success = FALSE
    DISPLAY cs_warning_tag,"Update view status unsuccess : ",SQLCA.sqlcode
  END TRY

  LET lb_return = lb_success     
    
  RETURN lb_return
  
END FUNCTION

