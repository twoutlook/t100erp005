
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
  mo_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO,
  mb_backend_mode BOOLEAN,
  mb_result       BOOLEAN,
  ms_result       STRING

FUNCTION sadzp310_asmg_run(p_backend_mode,p_COMPRESS_FILE_INFO)
DEFINE
  p_backend_mode BOOLEAN,
  p_COMPRESS_FILE_INFO  T_COMPRESS_FILE_INFO
  
  CALL sadzp310_asmg_initialize(p_backend_mode,p_COMPRESS_FILE_INFO.*)
  CALL sadzp310_asmg_start()
  CALL sadzp310_asmg_finalize()

  RETURN mb_result,ms_result

END FUNCTION 

FUNCTION sadzp310_asmg_initialize(p_backend_mode,p_COMPRESS_FILE_INFO)
DEFINE
  p_backend_mode BOOLEAN,
  p_COMPRESS_FILE_INFO     T_COMPRESS_FILE_INFO
  
  LET mb_backend_mode = p_backend_mode
  LET mo_COMPRESS_FILE_INFO.* = p_COMPRESS_FILE_INFO.*
  
END FUNCTION 

FUNCTION sadzp310_asmg_start()
DEFINE
  lo_T_DZIT_T DYNAMIC ARRAY OF T_DZIT_T,
  ls_message  STRING,
  lb_result   BOOLEAN,
  li_loop     INTEGER

  #取得 Trigger 設計資料
  CALL sadzp310_asmg_get_dzit_t_data(mo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME) RETURNING lo_T_DZIT_T
  #Trigger 執行建構
  CALL sadzp310_asmg_create_replace_trigger(lo_T_DZIT_T) RETURNING lb_result,ls_message 

  LET ms_result = ls_message
  LET mb_result = lb_result

  IF (lb_result) THEN 
    #更新 Trigger 的狀態
    CALL sadzp310_asmg_and_set_trigger_status(lo_T_DZIT_T) RETURNING lb_result 
  ELSE 
    #FIXME_161123: trigger 執行建構失敗，顯示狀態為'N 未建立' ,考慮停用已存在trigger
    FOR li_loop = 1 TO lo_T_DZIT_T.getLength()
      LET lo_T_DZIT_T[li_loop].DZIT009 = 'N'
      CALL sadzp310_asmg_set_trigger_status(lo_T_DZIT_T[li_loop].*) RETURNING lb_result
    END FOR 
  END IF 
  
END FUNCTION

FUNCTION sadzp310_asmg_finalize()
END FUNCTION 

# @desc. 從dzit_t表取得觸發器設計資料
# @memo get trigger design data from dzit_t table
# @input_para.  p_object_name  觸發器ID
# @return_para. lo_return 觸發器設計資料
# @modify 170210-00052#1 at 2017/02/15 by circlelai  新增dzit011資料取得行為,調整SQL語句
FUNCTION sadzp310_asmg_get_dzit_t_data(p_object_name) 
DEFINE
  p_object_name STRING
DEFINE
  ls_object_name STRING,
  ls_SQL         STRING,
  li_rec_count   INTEGER,
  lo_T_DZIT_T    DYNAMIC ARRAY OF T_DZIT_T
DEFINE
  lo_return  DYNAMIC ARRAY OF T_DZIT_T

  LET ls_object_name = p_object_name.toLowerCase()
  
  # 170210-00052#1 modify begin
  LET ls_sql = "select IT.DZIT001, IT.DZIT002, IT.DZIT003, IT.DZIT004, IT.DZIT005, " , "\n"
             , "       IT.DZIT006, IT.DZIT007, IT.DZIT008, IT.DZIT009, IT.DZIT010, IT.DZIT011 " , "\n"
             , "  from dzit_t IT " , "\n"
             #如同時存在標準與客制,只取客制
             , " INNER JOIN ( " , "\n"
             , "SELECT DISTINCT DZIT001, DZIT002, DZIT003, MIN(IT0.DZIT004) DZIT004 " , "\n"
             , "  FROM dzit_t IT0 GROUP BY DZIT001, DZIT002, DZIT003 " , "\n"
             , "       ) IT2 ON IT.DZIT001 = IT2.DZIT001 AND IT.DZIT002 = IT2.DZIT002 " , "\n" 
             , "            AND IT.DZIT003 = IT2.DZIT003 AND IT.DZIT004 = IT2.DZIT004" , "\n"
             , " where 1=1 and IT.DZIT002 = '",ls_object_name,"' " , "\n" # trigger id
             , "   and IT.DZIT003 <> '",cs_template_words,"' " , "\n" # 過濾樣版資料
             # erpdb, awsdb 資料
             , "   and IT.DZIT003 in ('", cs_alias_erp_db, "', '", cs_alias_aws_db,"') " , "\n" # ver 160525.01
             , " order by IT.DZIT003                                           "
  # 170210-00052#1 modify end
  
  INITIALIZE lo_T_DZIT_T TO NULL
  
  PREPARE lpre_get_dzit_t_data FROM ls_sql
  DECLARE lcur_get_dzit_t_data CURSOR FOR lpre_get_dzit_t_data

  LET li_rec_count = 1
  LOCATE lo_T_DZIT_T[li_rec_count].DZIT008 IN FILE
  LOCATE lo_T_DZIT_T[li_rec_count].DZIT011 IN FILE  # 170210-00052#1 add

  OPEN lcur_get_dzit_t_data
  FOREACH lcur_get_dzit_t_data INTO lo_T_DZIT_T[li_rec_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1
    LOCATE lo_T_DZIT_T[li_rec_count].DZIT008 IN FILE
    LOCATE lo_T_DZIT_T[li_rec_count].DZIT011 IN FILE
  END FOREACH
  CALL lo_T_DZIT_T.deleteElement(li_rec_count)
  
  CLOSE lpre_get_dzit_t_data
  CLOSE lcur_get_dzit_t_data

  LET lo_return = lo_T_DZIT_T

  RETURN lo_return

END FUNCTION


# @desc.  建構trigger實際數據 (Trigger 執行建構)
# @input_para.  p_T_DZIT_T  預建構的trigger設計資料
# @return_para. lb_return   建構成功否
# @return_para. ls_all_message  建構執行日誌
# @modify: 170210-00052#1 at 2017/02/15 by circlelai ,1.判斷是否使用新觸發器腳本(dzit011)執行建構,2.sqlplus錯誤'SP2-'判斷
FUNCTION sadzp310_asmg_create_replace_trigger(p_T_DZIT_T)
DEFINE # input parameter
  p_T_DZIT_T  DYNAMIC ARRAY OF T_DZIT_T
DEFINE 
  lo_T_DZIT_T    DYNAMIC ARRAY OF T_DZIT_T,
  lo_dzej007     DYNAMIC ARRAY OF LIKE DZEJ_T.DZEJ007, 
  lo_db_coxn     T_DB_COXN_STR, 
  lo_jsonobj     util.JSONObject,
  lo_str_buf     base.StringBuffer,      
  li_loop        INTEGER,
  li_loop2       INTEGER, 
  ls_dzit003     STRING,
  --ls_dzej004     STRING,
  ls_mdm_name    STRING,
  ls_erp_name    STRING,
  ls_sql         STRING,
  ls_SQL_file    STRING,
  ls_trigger_sql STRING,
  ls_message     STRING,
  ls_check_error STRING,
  ls_objName     STRING,
  ls_dbName      STRING,
  ls_chktrg_sql  STRING,
  lb_result      BOOLEAN
# 170210-00052#1 add by circlelai begin
DEFINE li_cnt         INTEGER  # count 變數暫存 
DEFINE lb_A_SYS_0059  BOOLEAN  # [旗標]使用新版觸發器腳本
DEFINE l_gzsa002      LIKE gzsa_t.gzsa002 # 取得資料庫'A-SYS-0059'旗標值
DEFINE ls_orig_script STRING   # 觸發器原腳本
# 170210-00052#1 add by circlelai end
DEFINE # return parameter
  lb_return BOOLEAN,  
  ls_all_message STRING
  
  LET lo_T_DZIT_T   = p_T_DZIT_T
  LET lb_return     = TRUE
  
  LET lo_str_buf    = base.StringBuffer.create()
  
  # 170210-00052#1 at 2017/02/15 by circlelai begin
  LET lb_A_SYS_0059 = FALSE  -- 預設不使用新版觸發器
  # 判斷旗標使用新版或者舊版trigger 執行建構
  SELECT COUNT(1) INTO li_cnt FROM gzsa_t  WHERE gzsa001 = 'A-SYS-0059';
  IF (li_cnt > 0) THEN
     SELECT gzsa002 INTO l_gzsa002 FROM gzsa_t WHERE gzsa001 = 'A-SYS-0059';
     IF l_gzsa002 == "Y" THEN
        LET lb_A_SYS_0059 = TRUE # 使用新版trigger script
     END IF
  END IF 
  # 170210-00052#1 at 2017/02/15 by circlelai end

  FOR li_loop = 1 TO lo_T_DZIT_T.getLength()
    LET ls_dzit003 = lo_T_DZIT_T[li_loop].DZIT003
    
    # if dzit003 in ('erpdb', awsdb) -- new version 201602171752 by circlelai
    IF (ls_dzit003 == cs_alias_erp_db OR ls_dzit003 == cs_alias_aws_db) THEN
      #取得實際資料庫名稱 
      CALL sadzp310_util_trans_schema_queue_to_array(ls_dzit003) RETURNING lo_dzej007
      IF lo_dzej007.getLength() > 0 THEN 
        FOR li_loop2 = 1 TO  lo_dzej007.getLength() 
          IF (lo_dzej007[li_loop2] == 'ds') THEN CONTINUE FOR END IF 
          DISPLAY cs_information_tag, "Alter trigger ", lo_T_DZIT_T[li_loop].DZIT002, 
                                      " for schema : ", lo_dzej007[li_loop2], "\n"
          
          #先取得資料庫連接資訊
          CALL sadzp310_db_get_db_connect_string(lo_dzej007[li_loop2]) RETURNING lo_db_coxn.*
          #取得變數{ERPDB}、{MDMDB}、{AWSDB}的置換字串 ls_mdm_name ,ls_erp_name
          LET lo_jsonobj = util.JSONObject.create()
          CALL lo_jsonobj.put("db_name", lo_dzej007[li_loop2])
          CALL lo_jsonobj.put("get_mode", ls_dzit003)
          IF (ls_dzit003 == "erpdb") THEN 
            LET ls_erp_name =  lo_dzej007[li_loop2]
            # CALL sadzp310_asmg_get_relative_db_name(lo_jsonobj) RETURNING ls_mdm_name
            CALL sadzp310_util_get_mdmdb_name(ls_erp_name) RETURNING ls_mdm_name 
          ELSE  --(ls_dzit003 == "awsdb")
            LET ls_mdm_name = lo_dzej007[li_loop2]
            # CALL sadzp310_asmg_get_relative_db_name(lo_jsonobj) RETURNING ls_erp_name
            CALL sadzp310_util_get_erpdb_name(ls_mdm_name) RETURNING ls_erp_name 
          END IF
          
          CALL lo_str_buf.clear()
          # 170210-00052#1 add by circlelai begin
          # 依照旗標決定使用新舊腳本 
          LET ls_orig_script = lo_T_DZIT_T[li_loop].DZIT008 -- 預設使用舊腳本
          IF lb_A_SYS_0059 THEN 
             LET ls_orig_script = sadzp310_util_trim_str(lo_T_DZIT_T[li_loop].DZIT011)
             IF (ls_orig_script.getLength() <= 0) THEN 
                # 新腳本為空,強制使用舊腳本
                LET ls_orig_script = lo_T_DZIT_T[li_loop].DZIT008
             ELSE
                LET ls_orig_script = lo_T_DZIT_T[li_loop].DZIT011
             END IF 
          END IF
          # 170210-00052#1 add by circlelai end
          #置換變數字串
          CALL lo_str_buf.append(ls_orig_script) -- 170210-00052#1 mod.
          CALL lo_str_buf.replace("{MDMDB}",ls_mdm_name,0)  -- 置換{MDMDB}
          CALL lo_str_buf.replace("{AWSDB}",ls_mdm_name,0)  -- 置換{AWSDB}
          CALL lo_str_buf.replace("{ERPDB}",ls_erp_name,0)  -- 置換{ERPDB}
          #產出 Create / Replace Trigger SQL File
          LET ls_trigger_sql = lo_str_buf.toString(),"\n", cs_sql_go_sign
          CALL sadzp310_util_gen_sql_script_file(ls_trigger_sql,cs_create_trigger) RETURNING ls_SQL_file 
          LET lo_db_coxn.db_sql_filename = ls_SQL_file
          #該有的資訊都有, 就執行
          IF NVL(lo_db_coxn.db_username,cs_null_value) <> cs_null_value AND 
             NVL(lo_db_coxn.db_password,cs_null_value) <> cs_null_value THEN 
            CALL sadzp310_db_sqlplus(lo_db_coxn.*) RETURNING ls_message
          ELSE
            LET ls_message = cs_warning_tag,"User name or password can not be null for ",ls_dzit003
            DISPLAY ls_message 
            CONTINUE FOR
          END IF        
          LET ls_all_message = ls_all_message,"\n",
                               "Process :","Create or Replace Trigger.[", lo_T_DZIT_T[li_loop].DZIT002,"]", "\n", 
                               "User : ",lo_db_coxn.db_username,"\n",
                               ls_message
          #異動過程中任一區域有任何錯誤, 就終止異動
          LET ls_check_error = ls_all_message.toUpperCase()
          #if have error then 取得trigger 詳細錯誤內容
          IF (ls_check_error.getIndexOf("ERROR",1) > 0) THEN
            LET lb_return = FALSE
            
            LET ls_objName = lo_T_DZIT_T[li_loop].DZIT002
            LET ls_dbName  = lo_dzej007[li_loop2]
            INITIALIZE ls_message TO NULL  
            #顯示 trigger 詳細錯誤訊息
            LET ls_chktrg_sql = "SELECT ('[' || LINE || ']: ' || TEXT) Errmsg ",
                          "  FROM ALL_ERRORS ",
                          " WHERE OWNER IN ('", ls_dbName.toUpperCase(), "')",
                          "   AND TYPE IN ('TRIGGER') ",
                          "   AND NAME = '", ls_objName.toUpperCase(), "' ",
                          "\n", cs_sql_go_sign
            CALL sadzp310_util_gen_sql_script_file(ls_chktrg_sql,"chktrg") RETURNING ls_SQL_file
            LET lo_db_coxn.db_sql_filename = ls_SQL_file
            IF NVL(lo_db_coxn.db_username,cs_null_value) <> cs_null_value 
              AND NVL(lo_db_coxn.db_password,cs_null_value) <> cs_null_value THEN
              CALL sadzp310_db_sqlplus(lo_db_coxn.*) RETURNING ls_message
            END IF 
            
            IF (ls_message IS NOT NULL) THEN 
              LET ls_all_message = ls_all_message, "\n",
                                   "Process :","Check Trigger FROM ALL_ERRORS.[", lo_T_DZIT_T[li_loop].DZIT002,"]", "\n", 
                                   "User : ",lo_db_coxn.db_username,"\n",
                                   ls_message
            END IF
            
            EXIT FOR
          END IF

          # 170210-00052#1 2017/02/15 begin by circlelai 
          # 新增"SP2-"判斷,表示執行時發生 SQL*Plus 錯誤  
          IF (ls_check_error.getIndexOf("SP2-",1) > 0) THEN 
             LET ls_all_message = ls_all_message , "\n" , "SQL*Plus Error.(SP2-?)" , "\n"
             EXIT FOR 
          END IF 
          # 170210-00052#1 2017/02/15 end by circlelai
        END FOR 
      END IF 
    ELSE  #針對舊有規格， --> lo_T_DZIT_T[li_loop].DZIT003 非資料庫代名詞
      DISPLAY cs_information_tag,"Alter trigger for schema : ",lo_T_DZIT_T[li_loop].DZIT003,"\n"

      #先取得資料庫連接資訊
      CALL sadzp310_db_get_db_connect_string(lo_T_DZIT_T[li_loop].DZIT003) RETURNING lo_db_coxn.*

      #產出 Create / Replace Trigger SQL File
      LET ls_trigger_sql = lo_T_DZIT_T[li_loop].DZIT008, "\n", cs_sql_go_sign
      CALL sadzp310_util_gen_sql_script_file(ls_trigger_sql,cs_create_trigger) RETURNING ls_SQL_file 
      LET lo_db_coxn.db_sql_filename = ls_SQL_file

      #該有的資訊都有, 就執行
      IF NVL(lo_db_coxn.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_coxn.db_password,cs_null_value) <> cs_null_value THEN
        CALL sadzp310_db_sqlplus(lo_db_coxn.*) RETURNING ls_message
      ELSE
        LET ls_message = cs_warning_tag,"User name or password can not be null for ",lo_T_DZIT_T[li_loop].DZIT003
        DISPLAY ls_message 
        CONTINUE FOR
      END IF
      
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","Create or Replace Trigger. [", lo_T_DZIT_T[li_loop].DZIT002,"]", "\n", 
                           "User : ",lo_db_coxn.db_username,"\n",
                           ls_message
      
      #異動過程中任一區域有任何錯誤, 就終止異動
      LET ls_check_error = ls_all_message.toUpperCase()
      IF (ls_check_error.getIndexOf("ERROR",1) > 0) THEN
        LET lb_return = FALSE
        LET ls_objName = lo_T_DZIT_T[li_loop].DZIT002
        LET ls_dbName  = lo_T_DZIT_T[li_loop].DZIT003
        #顯示 trigger 詳細錯誤訊息
        LET ls_chktrg_sql = "SELECT ('[' || LINE || ']: ' || TEXT) Errmsg ",
                            "  FROM ALL_ERRORS ",
                            " WHERE OWNER IN ('", ls_dbName.toUpperCase(), "')",
                            "   AND TYPE IN ('TRIGGER') ",
                            "   AND NAME = '", ls_objName.toUpperCase(), "' ",
                            "\n", cs_sql_go_sign
        CALL sadzp310_util_gen_sql_script_file(ls_chktrg_sql,"chktrg") RETURNING ls_SQL_file
        LET lo_db_coxn.db_sql_filename = ls_SQL_file
        IF NVL(lo_db_coxn.db_username,cs_null_value) <> cs_null_value 
           AND NVL(lo_db_coxn.db_password,cs_null_value) <> cs_null_value THEN
          CALL sadzp310_db_sqlplus(lo_db_coxn.*) RETURNING ls_message
        END IF 
        IF (ls_message IS NOT NULL) THEN 
          LET ls_all_message = ls_all_message, "\n",
                           "Process :","Check Trigger FROM ALL_ERRORS. [", lo_T_DZIT_T[li_loop].DZIT002,"]", "\n", 
                           "User : ",lo_db_coxn.db_username,"\n",
                           ls_message
        END IF
        
      EXIT FOR
      END IF
    END IF
  END FOR

  RETURN lb_return,ls_all_message

END FUNCTION

{#####################################
@descriptions 更新Trigger 設計資料狀態 (dzit_t.dzit009)
@para p_dzit_t 
@return lb_return
@modify  2016-11-23 by circlelai 07558
######################################}
FUNCTION sadzp310_asmg_and_set_trigger_status(p_dzit_t) 
DEFINE
  p_dzit_t  DYNAMIC ARRAY OF T_DZIT_T
DEFINE
  lo_dzit_t DYNAMIC ARRAY OF T_DZIT_T,
  ls_status STRING,
  li_loop   INTEGER,
  lb_status BOOLEAN,
  lb_result BOOLEAN
DEFINE
  lb_return BOOLEAN
  
  LET lo_dzit_t = p_dzit_t

  LET lb_result = TRUE
  
  FOR li_loop = 1 TO lo_dzit_t.getLength() 
    #取得trigger 目前狀態
    CALL sadzp310_asmg_get_trigger_status(lo_dzit_t[li_loop].DZIT003,   --預建立schema group name
                                          lo_dzit_t[li_loop].DZIT001,   --table name
                                          lo_dzit_t[li_loop].DZIT002)   --trigger id  
         RETURNING ls_status 
    LET lo_dzit_t[li_loop].DZIT009 = ls_status
    #更新trigger 狀態
    CALL sadzp310_asmg_set_trigger_status(lo_dzit_t[li_loop].*) RETURNING lb_status  
    IF NOT lb_status THEN LET lb_result = FALSE END IF
  END FOR  

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION 

{#######################################
@descriptions 取得觸發器目前狀態
  只要有一個trigger 狀態為'啟用'則為'Y'
@para  p_owner        資料庫代號
@para  p_table_name   表名稱
@para  p_trigger_name 觸發器名稱
@return ls_return
@author circlelai 07558
@modify 20160226 by circlelai
########################################}
FUNCTION sadzp310_asmg_get_trigger_status(p_owner,p_table_name,p_trigger_name)
DEFINE
  p_owner        STRING,
  p_table_name   STRING,
  p_trigger_name STRING
DEFINE
  lo_dzej007      DYNAMIC ARRAY OF LIKE DZEJ_T.DZEJ007,
  li_loop         INTEGER,
  ls_temp         STRING,
  ls_owner        STRING,
  ls_table_name   STRING,
  ls_trigger_name STRING,
  ls_sql          STRING,
  ls_status       VARCHAR(10)
DEFINE
  ls_return  STRING

  --LET ls_owner = p_owner.toUpperCase()
  LET ls_table_name = p_table_name.toUpperCase()
  LET ls_trigger_name = p_trigger_name.toUpperCase() 
  
  CALL sadzp310_util_decode_columns(p_owner) RETURNING ls_owner
  LET ls_owner = ls_owner.toUpperCase()
  
  #取得資料筆數
  LET ls_sql = "SELECT DECODE(STATUS,'ENABLED','Y','DISABLED','X','N') STATUS ",
               "  FROM DBA_TRIGGERS ATS                                       ",
               " WHERE 1=1                                                    ",
               "   AND ATS.OWNER IN (", ls_owner, ")                          ",
               "   AND ATS.TABLE_NAME = '",ls_table_name,"'                   ",
               "   AND ATS.TRIGGER_NAME = '",ls_trigger_name,"'               "
 
  PREPARE lpre_get_trigger_status FROM ls_sql
  DECLARE lcur_get_trigger_status CURSOR FOR lpre_get_trigger_status
  OPEN lcur_get_trigger_status
  #FETCH lcur_get_trigger_status INTO ls_status  --older 
  FOREACH lcur_get_trigger_status INTO ls_status
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    IF (ls_status == "Y" ) THEN
      EXIT FOREACH
    END IF
  END FOREACH
  CLOSE lcur_get_trigger_status
  FREE lcur_get_trigger_status
  FREE lpre_get_trigger_status

  LET ls_return = NVL(ls_status,"N")
  LET ls_return = ls_return.trim()
  
  RETURN ls_return 
END FUNCTION

{
@descriptions 更新trigger 設計資料狀態
@para p_dzit_t 更新物件相關訊息
@retuen lb_return 是否更新成功
}
FUNCTION sadzp310_asmg_set_trigger_status(p_dzit_t)
DEFINE
  p_dzit_t T_DZIT_T
DEFINE  
  lo_dzit_t  T_DZIT_T,
  lb_success BOOLEAN
DEFINE
  lb_return  BOOLEAN

  LET lo_dzit_t.* = p_dzit_t.*
  
  LET lb_success = TRUE

  TRY 
    UPDATE DZIT_T                                 
       SET DZIT009 = lo_dzit_t.DZIT009
     WHERE DZIT001 = lo_dzit_t.dzit001
       AND DZIT002 = lo_dzit_t.dzit002
       AND DZIT003 = lo_dzit_t.dzit003
       AND DZIT004 = lo_dzit_t.dzit004
       
  CATCH
    LET lb_success = FALSE
    DISPLAY cs_warning_tag,"Update trigger status unsuccess : ",SQLCA.sqlcode
  END TRY

  LET lb_return = lb_success     
    
  RETURN lb_return
  
END FUNCTION

###############################################################################
# @desc.  取得相對應的資料庫名稱
# @input_para. p_jsonobj  ,JSONObject 參數內容包含如下:
# ............ db_name  (erp || aws) db name
# ............ get_mode  決定取得模式，(erp || aws)相對應 db name
# @return ls_return  資料庫名稱
# @create 2016-02-26 by circlelai 
###############################################################################}
FUNCTION sadzp310_asmg_get_relative_db_name(p_jsonobj)
  DEFINE 
    p_jsonobj util.JSONObject
  DEFINE 
    ls_db_name    STRING,   -- (erp || aws) db name
    ls_get_mode   STRING,   --決定取得模式，(erp || aws)相對應 db name
    ls_sql        STRING,
    ls_DZEJ004_1  STRING,
    ls_DZEJ004_2  STRING,
    lv_rel_db     VARCHAR(20),   --relative db name
    lb_iserr      BOOLEAN
  DEFINE 
    ls_return     STRING 

  LET lb_iserr = FALSE 
  
  IF p_jsonobj.has("db_name") THEN
    LET ls_db_name = p_jsonobj.get("db_name")
  ELSE 
    LET lb_iserr = TRUE 
  END IF 
  
  IF p_jsonobj.has("get_mode") THEN
    LET ls_get_mode = p_jsonobj.get("get_mode")
  ELSE 
    LET lb_iserr = TRUE 
  END IF 
  
  
  IF NOT lb_iserr THEN
    CASE ls_get_mode
      WHEN cs_alias_erp_db
        LET ls_DZEJ004_1 = "MDMDB"
        LET ls_DZEJ004_2 = "'ERPDB', 'MDMDB'"
      WHEN cs_alias_aws_db
        LET ls_DZEJ004_1 = "ERPDB"
        LET ls_DZEJ004_2 = "'ERPDB', 'MDMDB'"
      OTHERWISE 
        DISPLAY "Unexpected value"
    END CASE 
    
    LET ls_sql = "SELECT EJ.DZEJ007                                               ",
                 "  FROM DZEJ_T EJ                                                ",
                 " WHERE EJ.DZEJ001 = 'adzi180_parameters'                        ",
                 "   AND EJ.DZEJ004 = '", ls_DZEJ004_1, "'                        ",
                 "   AND EJ.DZEJ005 = (                                           ",
                 "                      SELECT EJT.DZEJ005                        ",
                 "                        FROM DZEJ_T EJT                         ",
                 "                       WHERE EJT.DZEJ001 = 'adzi180_parameters' ",
                 "                         AND EJT.DZEJ004 IN (", ls_DZEJ004_2, ")",     
                 "                         AND EJT.DZEJ007 = '",ls_db_name,"'     ",
                 "                    )                                           "
    PREPARE lpre_get_reldb_name FROM ls_sql
    DECLARE lcur_get_reldb_name CURSOR FOR lpre_get_reldb_name
    OPEN lcur_get_reldb_name
    FETCH lcur_get_reldb_name INTO lv_rel_db
    CLOSE lcur_get_reldb_name
    FREE lcur_get_reldb_name
    FREE lpre_get_reldb_name
  END IF 

  IF NOT lb_iserr THEN LET ls_return =  lv_rel_db END IF
  
  RETURN ls_return
END FUNCTION 

{##########################################################
@descriptions  開關觸發器
  設定實體 trigger to 'ENABLED' or 'DISABLED';
@para   p_trg_name  trigger_name
@para   p_status    set status,if not "?" then 
           強制設定trigger disable or enable
@para   p_dbtype  資料庫型別, value in ('erpdb', 'awsdb')
@return lb_ret  回傳執行結果
@return lbs_msg.toString()  執行歷程
@author circlelai 07558
@since  2016-11-24
###########################################################}
FUNCTION sadzp310_asmg_switch_trg(p_trg_name, p_status, p_dbtype)
DEFINE p_trg_name STRING
DEFINE p_status   STRING
DEFINE p_dbtype   STRING 
DEFINE lb_ret      BOOLEAN

DEFINE lb_isErr    BOOLEAN
DEFINE ls_msg      STRING  
DEFINE lbs_msg     base.StringBuffer
DEFINE ls_trg_name STRING
DEFINE ls_status   STRING  
DEFINE ls_script   STRING  #alter trigger script
DEFINE ls_newline  STRING 
DEFINE ls_fname_sub  STRING  #sql file sub name
DEFINE ls_fullpath   STRING  #sql file full path

DEFINE lo_dzej007  DYNAMIC ARRAY OF LIKE DZEJ_T.DZEJ007 
DEFINE li_idx      INTEGER
DEFINE lo_db_coxn  T_DB_COXN_STR  #sqlplus 相關資料 
 
  LET lb_ret = FALSE 
  LET lb_isErr = FALSE
  LET lbs_msg = base.StringBuffer.create()
  
  LET ls_trg_name = p_trg_name.toUpperCase()
  LET ls_status   = p_status.toUpperCase()
  LET ls_newline  = "\n"
  LET ls_fname_sub = "asmg_switch_" ,p_trg_name.toLowerCase() 
  LET ls_script = "-- Switch Trigger.", ls_newline 
                , "DECLARE " ,ls_newline 
                , "  ls_SQL VARCHAR2(1024); " , ls_newline 
                , "  ls_status VARCHAR(10); " , ls_newline 
                , "BEGIN " ,ls_newline 
                , "  DBMS_OUTPUT.ENABLE(100000); " , ls_newline
                , ls_newline 
                , "  SELECT DECODE(UTS.STATUS,'ENABLED','DISABLE','DISABLED','ENABLE') STATUS " ,ls_newline
                , "    INTO ls_status                                                         " ,ls_newline
                , "    FROM USER_TRIGGERS UTS                                                 " ,ls_newline
                , "   WHERE UTS.TRIGGER_NAME = '" , ls_trg_name ,"'; " , ls_newline
                , ls_newline
                --強制設定trigger disable or enable
                , IIF ((ls_status == "?") , "" , ("ls_status := '" || ls_status || "';")) ,ls_newline
                , "  ls_SQL := 'ALTER TRIGGER " , ls_trg_name , " '||ls_status; " ,ls_newline
                , ls_newline
                , "  BEGIN" ,ls_newline
                , "    EXECUTE IMMEDIATE ls_SQL; " ,ls_newline
                , "    DBMS_OUTPUT.PUT_LINE('[Message] Switch trigger success.'); " ,ls_newline
                , "  EXCEPTION ", ls_newline
                , "    WHEN OTHERS THEN ",ls_newline
                , "      DBMS_OUTPUT.PUT_LINE(SQLERRM); " ,ls_newline
                , "  END; " ,ls_newline
                , ls_newline
                , "EXCEPTION " ,ls_newline
                , "  WHEN OTHERS THEN " ,ls_newline
                , "    DBMS_OUTPUT.PUT_LINE(SQLERRM); " ,ls_newline
                , "END; " ,ls_newline
                , "/ " ,ls_newline
                
  CALL sadzp310_util_gen_sql_script_file(ls_script, ls_fname_sub) RETURNING ls_fullpath 

  # 取得 資料庫
  IF (p_dbtype == cs_alias_erp_db OR p_dbtype == cs_alias_aws_db) THEN
    CALL sadzp310_util_trans_schema_queue_to_array(p_dbtype) RETURNING lo_dzej007
    IF lo_dzej007.getLength() IS NULL THEN
      LET lb_isErr = TRUE  
    END IF 
  ELSE 
    LET lb_isErr = TRUE  
    LET ls_msg = "[Error]Undefine DBtype [" , p_dbtype , "]" , ls_newline
    DISPLAY ls_msg
  END IF 

  IF NOT lb_isErr THEN
    FOR li_idx = 1 TO  lo_dzej007.getLength() 
      IF (lo_dzej007[li_idx] == 'ds') THEN CONTINUE FOR END IF
      DISPLAY cs_information_tag, "Switch trigger ", ls_trg_name
		    , " for schema : ", lo_dzej007[li_idx], ls_newline
      #資料庫資訊
      CALL sadzp310_db_get_db_connect_string(lo_dzej007[li_idx]) RETURNING lo_db_coxn.*
      LET lo_db_coxn.db_sql_filename = ls_fullpath
      
      IF NVL(lo_db_coxn.db_username,cs_null_value) <> cs_null_value AND 
         NVL(lo_db_coxn.db_password,cs_null_value) <> cs_null_value THEN
        CALL sadzp310_db_sqlplus(lo_db_coxn.*) RETURNING ls_msg  #實際執行sql檔
      ELSE 
        LET ls_msg = cs_warning_tag
                   , "User name or password can not be null for"
                   , lo_dzej007[li_idx], ls_newline
        DISPLAY ls_msg
        CONTINUE FOR
      END IF
      
      CALL lbs_msg.append(ls_newline)
      CALL lbs_msg.append("Process :")
      CALL lbs_msg.append(ls_msg)

      LET ls_msg = ls_msg.toUpperCase()
      IF (ls_msg.getIndexOf("ERROR",1) > 0) THEN #發生錯誤
        LET lb_isErr = TRUE
      END IF 
      
    END FOR
  END IF  

  #回傳結果
  IF lb_isErr THEN
    LET lb_ret = FALSE 
  ELSE 
    LET lb_ret = TRUE 
  END IF 
  
  RETURN lb_ret, lbs_msg.toString()
END FUNCTION 



