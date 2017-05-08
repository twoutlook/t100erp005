{
  異動型態    異動單號       日 期       異動者      異動內容
  ========= ============= ========== ========== ===============================================
  Modify                  20161206   Ernestliou 1.Add NVL() for null schema name
}

&include "../4gl/sadzi200_mcr.inc"

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi200_type.inc"

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi200_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

DEFINE
  ms_execute_path STRING

FUNCTION sadzi200_util_set_execute_path(p_path)
DEFINE
  p_path STRING 

  LET ms_execute_path = p_path
  
END FUNCTION 

FUNCTION sadzi200_util_get_execute_path()
DEFINE
  ls_path STRING 
  
  LET ls_path = ms_execute_path

  RETURN ls_path
  
END FUNCTION 

FUNCTION sadzi200_util_get_form_path(p_form_name)
DEFINE
  p_form_name STRING 
DEFINE
  ls_form_name    STRING,
  ls_path         STRING,
  ls_os_separator STRING,
  ls_form_path    STRING

  LET ls_form_name = p_form_name
  
  LET ls_path = sadzi200_util_get_execute_path()
  LET ls_os_separator = os.Path.separator()
  LET ls_form_path = ls_path,ls_os_separator,ls_form_name                      

  RETURN ls_form_path
  
END FUNCTION 

FUNCTION sadzi200_util_trim_str(p_string)
DEFINE
  p_string STRING
DEFINE
  ls_string STRING,
  lo_strbuf base.StringBuffer
DEFINE
  ls_return STRING

  LET ls_string = p_string

  LET ls_string = ls_string.trim()

  IF ls_string IS NOT NULL THEN 
    LET lo_strbuf = base.StringBuffer.create()
    CALL lo_strbuf.clear()
    CALL lo_strbuf.append(ls_string)
    CALL lo_strbuf.replace(" ","",0)
    CALL lo_strbuf.replace("\t","",0)
    CALL lo_strbuf.replace("\r","",0)
    CALL lo_strbuf.replace("\n","",0)
    LET ls_string = lo_strbuf.toString()
  END IF
  
  LET ls_return = ls_string
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzi200_util_trim_return_code(p_string)
DEFINE
  p_string STRING
DEFINE
  ls_string STRING,
  lo_strbuf base.StringBuffer
DEFINE
  ls_return STRING

  LET ls_string = p_string

  LET ls_string = ls_string.trim()

  LET lo_strbuf = base.StringBuffer.create()
  CALL lo_strbuf.clear()
  CALL lo_strbuf.append(ls_string)
  CALL lo_strbuf.replace("\t","",0)
  CALL lo_strbuf.replace("\r","",0)
  CALL lo_strbuf.replace("\n","",0)
  LET ls_string = lo_strbuf.toString()
  
  LET ls_return = ls_string
  
  RETURN ls_return

END FUNCTION

FUNCTION sadzi200_util_get_table_leading_code(p_table_name)
DEFINE
  p_table_name STRING 
DEFINE
  ls_table_name     STRING,
  ls_table_pre_name STRING, 
  li_loop           INTEGER,
  ls_table_char     STRING
DEFINE
  ls_return STRING   
  
  LET ls_table_name = p_table_name
  
  LET ls_table_pre_name = ls_table_name
  FOR li_loop = 1 TO ls_table_name.getLength()
    LET ls_table_char = NVL(ls_table_name.subString(li_loop,li_loop),"@") 
    IF ls_table_char MATCHES "[_]" THEN
      LET ls_table_pre_name = ls_table_name.subString(1,li_loop - 1)
      EXIT FOR
    END IF    
  END FOR

  LET ls_return = ls_table_pre_name

  RETURN ls_return
  
END FUNCTION 

FUNCTION sadzi200_util_get_program_title(p_program,p_lang)
DEFINE
  p_program STRING,
  p_lang    STRING
DEFINE
  ls_program STRING,
  ls_lang    STRING,
  ls_program_title VARCHAR(512),
  ls_sql     STRING
DEFINE
  ls_return STRING  

  LET ls_program = p_program
  LET ls_lang    = p_lang
  
  LET ls_sql = "SELECT ZA.GZZA001||'-'||ZAL.GZZAL003  PROGRAM_TITLE           ",
               "  FROM GZZA_T ZA                                              ",
               "  LEFT OUTER JOIN GZZAL_T ZAL ON ZAL.GZZAL001 = ZA.GZZA001    ",
               "                             AND ZAL.GZZAL002 = '",ls_lang,"' ",
               " WHERE ZA.GZZA001 = '",ls_program,"'                          "              

  PREPARE lpre_get_program_title FROM ls_sql
  DECLARE lcur_get_program_title CURSOR FOR lpre_get_program_title

  INITIALIZE ls_program_title TO NULL
  
  OPEN lcur_get_program_title
  FETCH lcur_get_program_title INTO ls_program_title
  CLOSE lcur_get_program_title
  
  FREE lpre_get_program_title
  FREE lcur_get_program_title  

  LET ls_return = ls_program_title
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi200_util_gen_sql_script_file(p_sql,p_sql_type)
DEFINE
  p_sql      STRING,
  p_sql_type STRING 
DEFINE
  ls_sql             STRING,
  ls_sql_type        STRING, 
  ls_exit_sign       STRING,
  ls_GUID            STRING,
  ls_tempdir         STRING,
  lchannel_write     base.Channel,
  ls_sript_filename  STRING,
  ls_separator       STRING, 
  ls_return          STRING
  
  LET ls_sql      = p_sql
  LET ls_sql_type = p_sql_type
  
  LET ls_exit_sign = "exit;"

  LET ls_separator = os.Path.separator()

  LET ls_tempdir = FGL_GETENV("TEMPDIR")
  CALL sadzi200_util_get_GUID() RETURNING ls_GUID 
  
  LET ls_sript_filename = ls_tempdir,ls_separator,"sadzi200_",ls_sql_type,"_",ls_GUID,".sql"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  LET ls_sql = ls_sql,"\n",
               ls_exit_sign
  
  #開檔寫入
  TRY
    CALL lchannel_write.openFile(ls_sript_filename, "w" )
    CALL lchannel_write.write(ls_sql)
    #關檔
    CALL lchannel_write.close()
  CATCH
    DISPLAY "Generate Script Error !!"
  END TRY  

  LET ls_return = ls_sript_filename

  RETURN ls_return

END FUNCTION

FUNCTION sadzi200_util_get_GUID()
DEFINE 
  ls_GUID  STRING
DEFINE  
  ls_return STRING

  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID 

  LET ls_return = ls_GUID
  
  RETURN ls_return                     
  
END FUNCTION

################################################################################
# Descriptions...: 建構視觀表
# Memo...........: 
# Usage..........: CALL sadzi200_util_create_replace_view(lo_dziv_t.*) RETURNING lb_result, ls_message
# Input parameter: p_create_object  預建構物件
#                : 
# Return code....: lb_return      建構是否成功
#                : ls_all_message 建構執行日誌
# Date & Author..: 
# Modify.........: 20160323 by CircleLai
################################################################################
FUNCTION sadzi200_util_create_replace_view(p_create_object)
DEFINE
  p_create_object  T_DZIV_T_WL
DEFINE
  lo_create_object       T_DZIV_T_WL,
  lo_db_connstr          T_DB_COXN_STR,
  lo_schema_list         DYNAMIC ARRAY OF T_SCHEMA_LIST,
  lo_str_buf             base.StringBuffer,
  li_loop                INTEGER,
  lb_success             BOOLEAN,
  ls_owners_queue        STRING,
  ls_sql                 STRING,
  ls_view_name              STRING,
  ls_dziv004             STRING,
  ls_orig_dziv004        STRING,
  ls_mdm_name            STRING,
  ls_erp_name            STRING,
  ls_crttrg_sql          STRING,
  ls_crttrg_sql_filename STRING,
  ls_message             STRING,
  ls_all_message         STRING,
  ls_alter_sql           STRING,
  ls_db_user_name        STRING,
  ls_check_error         STRING,
  ls_err_message         STRING
DEFINE 
  lb_return  BOOLEAN  

  LOCATE lo_create_object.DZIV004 IN FILE
  
  LET lo_create_object.* = p_create_object.*
  
  LET ls_orig_dziv004 = lo_create_object.DZIV004
  LET ls_view_name    = lo_create_object.DZIV001
  LET lo_str_buf = base.StringBuffer.create()
  LET lb_success = TRUE

  CALL sadzi200_crud_trans_schema_queue_to_array(lo_create_object.DZIV002) RETURNING lo_schema_list
  FOR li_loop =1 TO  lo_schema_list.getLength()
    #取得資料庫連線資料
    CALL sadzi200_db_get_db_connect_string(lo_schema_list[li_loop].SCHEMA_NAME) RETURNING lo_db_connstr.*

    LET ls_alter_sql = ""
    LET ls_dziv004 = ls_orig_dziv004
    
    CALL sadzi200_util_get_mdmdb_name(lo_schema_list[li_loop].SCHEMA_NAME) RETURNING ls_mdm_name
    CALL sadzi200_util_get_erpdb_name(lo_schema_list[li_loop].SCHEMA_NAME) RETURNING ls_erp_name
    
    CALL lo_str_buf.clear()
    CALL lo_str_buf.append(ls_dziv004)

    CALL lo_str_buf.replace(cs_identify_aws_db,ls_mdm_name,0) -- 置換{AWSDB} 20160706
    CALL lo_str_buf.replace(cs_identify_mdm_db,ls_mdm_name,0) -- 置換{MDMDB} 
    --CALL lo_str_buf.replace(cs_identify_erp_db,ls_erp_name,0) -- 置換{ERPDB}  -- 20161206 Mark 
    CALL lo_str_buf.replace(cs_identify_erp_db,NVL(ls_erp_name,lo_schema_list[li_loop].SCHEMA_NAME),0) -- 置換{ERPDB} -- -- 20161206 Add NVL() for null schema

    {
    #置換HTML Tag為""
    CALL lo_str_buf.replace(cs_view_head_begin_tag,"",0)
    CALL lo_str_buf.replace(cs_view_head_end_tag,"",0)
    CALL lo_str_buf.replace(cs_view_body_begin_tag,"",0)
    CALL lo_str_buf.replace(cs_view_body_end_tag,"",0)
    }
    
    CALL lo_str_buf.toString() RETURNING ls_dziv004  
      
    ###############################################################################################################################################################
    #取得View Scripts
    LET ls_crttrg_sql = ls_dziv004,cs_sql_exe_sign,"\n",cs_sql_go_sign
    LET ls_alter_sql = ls_alter_sql,"\n",
                       ls_crttrg_sql
                       
    #產出 SQL Scripts File
    CALL sadzi200_util_gen_sql_script_file(ls_alter_sql, cs_create_view) RETURNING ls_crttrg_sql_filename
    LET lo_db_connstr.db_sql_filename = ls_crttrg_sql_filename
    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
    CALL sadzi200_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
    LET ls_db_user_name = lo_db_connstr.db_username
    LET ls_all_message = ls_all_message,"\n",
                         "Process :","Create or Replace View.","\n", 
                         "User : ",lo_db_connstr.db_username,"\n",
                         ls_message
    END IF        
    ###############################################################################################################################################################

    #異動過程中任一區域有任何錯誤, 就終止表格異動  #rixqq? 執行建構題是錯誤訊息需要優化
    LET ls_check_error = ls_all_message.toUpperCase()
    IF (ls_check_error.getIndexOf("ERROR",1) > 0) THEN
      LET lb_success = FALSE
      EXIT FOR
    END IF
      
  END FOR 

  #擷取建制過程出錯的訊息
  CALL sadzi200_util_get_alter_view_error_message(ls_view_name) RETURNING ls_err_message
  LET ls_all_message = ls_all_message,"\n",ls_err_message
  
  LET lb_return = lb_success
  
  RETURN lb_return, ls_all_message
  
END FUNCTION

#刪除 Master Table 的資料
FUNCTION sadzi200_util_drop_view(p_drop_object,p_delete_data)
DEFINE
  p_drop_object    T_DZIV_T_WL,
  p_delete_data    BOOLEAN
DEFINE
  lo_drop_object      T_DZIV_T_WL,
  lo_db_connstr       T_DB_COXN_STR,
  lo_coxn_info        DYNAMIC ARRAY OF T_DB_COXN_STR,
  lo_schema_list      DYNAMIC ARRAY OF T_SCHEMA_LIST,
  li_loop             INTEGER,
  li_idx1             INTEGER,
  ls_view_name        STRING,
  ls_sql              STRING,
  ls_replace_arg      STRING,
  ls_drop_script_name STRING,
  ls_all_message      STRING,
  ls_message          STRING,
  ls_error            STRING,
  ls_question         STRING,
  ls_foreign_key_list STRING,
  lb_delete_data      BOOLEAN,  
  lb_result           BOOLEAN,  
  lb_success          BOOLEAN
DEFINE 
  lb_return BOOLEAN  

  LET lo_drop_object.* = p_drop_object.*
  LET lb_delete_data   = p_delete_data
  
  LET ls_view_name  = lo_drop_object.DZIV001
  
  LET lb_success = TRUE 
  LET lb_result  = TRUE

  #mod at 20160322 by CircleLai start
  CALL sadzi200_crud_trans_schema_queue_to_array(lo_drop_object.DZIV002) RETURNING lo_schema_list 
  FOR li_loop = 1 TO lo_schema_list.getLength()
    CALL sadzi200_db_get_db_connect_string(lo_schema_list[li_loop].SCHEMA_NAME) RETURNING lo_db_connstr.*
    CALL sadzi200_db_gen_drop_view_script(ls_view_name) RETURNING ls_drop_script_name
    LET lo_db_connstr.db_sql_filename = ls_drop_script_name
    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND 
       NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
      CALL sadzi200_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
      LET ls_all_message = ls_all_message,"\n",
            "Process :","Drop View.","\n", 
            "User : ",lo_db_connstr.db_username,"\n",
            ls_message
    END IF
  END FOR 
  #mod at 20160322 by CircleLai end
  
  LET ls_error = ls_all_message.toUpperCase()
  IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_success = FALSE 
  END IF  

  IF lb_success AND lb_delete_data THEN
    CALL sadzi200_util_delete_data(lo_drop_object.*) RETURNING lb_result
    IF NOT lb_result THEN
      CALL sadzp000_msg_show_error(NULL,"adz-00164" ,NULL,0)
      LET lb_success = FALSE 
      {
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = "adz-00164"   # 刪除設計資料過程出現錯誤
      LET g_errparam.extend = NULL
      LET g_errparam.popup  = TRUE  #訊息開窗顯示
      LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
      CALL cl_err()
      }
    END IF 
  END IF    
  
  LET lb_return = lb_success

  RETURN lb_return,ls_all_message
  
END FUNCTION

#測試建 View 的SQL
FUNCTION sadzi200_util_test_view(p_test_object)
DEFINE
  p_test_object  T_DZIV_T_WL
DEFINE
  lo_test_object         T_DZIV_T_WL,
  lo_db_connstr          T_DB_COXN_STR,
  lo_schema_list         DYNAMIC ARRAY OF T_SCHEMA_LIST,
  lo_str_buf             base.StringBuffer,
  li_loop                INTEGER,
  lb_success             BOOLEAN,
  ls_owners_queue        STRING,
  ls_sql                 STRING,
  ls_view_name           STRING,
  ls_dziv004             STRING,
  ls_orig_dziv004        STRING,
  ls_mdm_name            STRING,
  ls_erp_name            STRING,
  ls_testview_sql        STRING,
  ls_testview_sql_filename STRING,
  ls_message             STRING,
  ls_all_message         STRING,
  ls_alter_sql           STRING,
  ls_db_user_name        STRING,
  ls_check_error         STRING,
  ls_err_message         STRING,
  ls_test_sql            STRING,
  lo_view_contents       T_VIEW_CONTENTS
DEFINE 
  lb_return  BOOLEAN  

  LOCATE lo_test_object.DZIV004 IN FILE
  
  LET lo_test_object.* = p_test_object.*
  
  LET ls_orig_dziv004 = lo_test_object.DZIV004
  LET ls_view_name    = lo_test_object.DZIV001
  LET lo_str_buf = base.StringBuffer.create()
  LET lb_success = TRUE

  CALL sadzi200_crud_trans_schema_queue_to_array(lo_test_object.DZIV002) RETURNING lo_schema_list
  FOR li_loop =1 TO  lo_schema_list.getLength()
    #取得資料庫連線資料
    CALL sadzi200_db_get_db_connect_string(lo_schema_list[li_loop].SCHEMA_NAME) RETURNING lo_db_connstr.*

    LET ls_alter_sql = ""
    LET ls_dziv004 = ls_orig_dziv004
    
    CALL sadzi200_util_get_mdmdb_name(lo_schema_list[li_loop].SCHEMA_NAME) RETURNING ls_mdm_name
    CALL sadzi200_util_get_erpdb_name(lo_schema_list[li_loop].SCHEMA_NAME) RETURNING ls_erp_name
    
    CALL lo_str_buf.clear()
    CALL lo_str_buf.append(ls_dziv004)
    CALL lo_str_buf.replace(cs_identify_aws_db,ls_mdm_name,0) -- 置換{AWSDB} 20160706
    CALL lo_str_buf.replace(cs_identify_mdm_db,ls_mdm_name,0) -- 置換{MDMDB} 
    CALL lo_str_buf.replace(cs_identify_erp_db,ls_erp_name,0) -- 置換{ERPDB}  

    CALL lo_str_buf.toString() RETURNING ls_dziv004

    #區分建View語法
    CALL adzi200_separate_view_contents(ls_dziv004) RETURNING lo_view_contents.*    
    LET ls_test_sql = cs_test_sql_begin,lo_view_contents.vc_BODY,cs_test_sql_end
      
    ###############################################################################################################################################################
    #取得View Scripts
    LET ls_testview_sql = cs_ora_set_sqlblanklines_on,"\n",
                          ls_test_sql,cs_sql_exe_sign,"\n",
                          cs_sql_go_sign
    LET ls_alter_sql = ls_alter_sql,"\n",
                       ls_testview_sql
                       
    #產出 SQL Scripts File
    CALL sadzi200_util_gen_sql_script_file(ls_alter_sql, cs_test_view) RETURNING ls_testview_sql_filename
    LET lo_db_connstr.db_sql_filename = ls_testview_sql_filename
    IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
    CALL sadzi200_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
    LET ls_db_user_name = lo_db_connstr.db_username
    LET ls_all_message = ls_all_message,"\n",
                         "Process :","Test View.","\n", 
                         "User : ",lo_db_connstr.db_username,"\n",
                         ls_message
    END IF        
    ###############################################################################################################################################################

    #異動過程中任一區域有任何錯誤, 就終止表格異動  #rixqq? 執行建構題是錯誤訊息需要優化
    LET ls_check_error = ls_all_message.toUpperCase()
    IF (ls_check_error.getIndexOf("ERROR",1) > 0) THEN
      LET lb_success = FALSE
      EXIT FOR
    END IF
      
  END FOR 

  #擷取測試過程出錯的訊息
  CALL sadzi200_util_get_alter_view_error_message(ls_view_name) RETURNING ls_err_message
  LET ls_all_message = ls_all_message,"\n",ls_err_message

  #移除測試語法
  CALL lo_str_buf.clear()
  CALL lo_str_buf.append(ls_all_message)
  CALL lo_str_buf.replace(cs_test_sql_begin,"",0)
  CALL lo_str_buf.replace(cs_test_sql_end,"",0)
  LET ls_all_message = lo_str_buf.toString() 
  
  LET lb_return = lb_success
  
  RETURN lb_return, ls_all_message
  
END FUNCTION

FUNCTION sadzi200_util_delete_data(p_dziv_t)
DEFINE
  p_dziv_t  T_DZIV_T_WL
DEFINE
  lo_dziv_t  T_DZIV_T_WL,
  ls_sql     STRING
DEFINE
  lb_result BOOLEAN 
  
  LET lo_dziv_t.* = p_dziv_t.*

  LET lb_result = TRUE

  BEGIN WORK

  IF lb_result THEN 
    #View資料表多語言檔
    LET ls_sql = "DELETE FROM DZIVL_T                       ", 
                 " WHERE DZIVL001 = '",lo_dziv_t.DZIV001,"' ",
                 "   AND DZIVL002 = '",lo_dziv_t.DZIV002,"' ",
                 "   AND DZIVL003 = '",lo_dziv_t.DZIV003,"' "
                 
    CALL sadzi200_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
  END IF    
  
  IF lb_result THEN 
    #View資料表
    LET ls_sql = "DELETE FROM DZIV_T                       ", 
                 " WHERE DZIV001 = '",lo_dziv_t.DZIV001,"' ",
                 "   AND DZIV002 = '",lo_dziv_t.DZIV002,"' ",
                 "   AND DZIV003 = '",lo_dziv_t.DZIV003,"' "
                 
    CALL sadzi200_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
  END IF    
  
  #add at 20160316 by CircleLai start
  #如果不存在其他設計資料，刪除ALM資料(DZLM_T)與版本紀錄(DZAF_T) 
  IF NOT sadzi200_crud_check_if_design_data_exists(lo_dziv_t.*) THEN  
    IF (lb_result) THEN 
      #版本設定檔
      LET ls_sql = "DELETE FROM DZAF_T                       ", 
                   " WHERE DZAF001 = '",lo_dziv_t.DZIV001,"' ",
                   "   AND DZAF005 = 'MV'                    ",
                   "   AND DZAF010 = '",lo_dziv_t.DZIV003,"' "
      CALL sadzi200_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
    END IF
    IF (lb_result) THEN 
      #簽出入紀錄
      LET ls_sql = "DELETE FROM DZLM_T                       ", 
                   " WHERE DZLM002 = '",lo_dziv_t.DZIV001,"' ",
                   "   AND DZLM001 = 'MV'"
      CALL sadzi200_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
    END IF
  END IF 
  #add at 20160316 by CircleLai end
  
  IF lb_result THEN
    COMMIT WORK 
  ELSE
    ROLLBACK WORK
  END IF  

  RETURN lb_result  

END FUNCTION 

FUNCTION sadzi200_util_get_and_set_view_status(p_dziv_t)
DEFINE
  p_dziv_t  T_DZIV_T_WL
DEFINE
  lo_dziv_t       T_DZIV_T_WL,
  lb_result       BOOLEAN,
  ls_owners_queue STRING,
  ls_view_status  STRING
DEFINE
  lb_return BOOLEAN
  
  LET lo_dziv_t.* = p_dziv_t.*

  LET ls_view_status = cs_view_status_created
  
  #檢核是否有任何 View 不存在, 如果都沒有, 就掛上未建立
  CALL sadzi200_util_check_view_exists(lo_dziv_t.*) RETURNING lb_result 
  IF NOT lb_result THEN LET ls_view_status = cs_view_status_uncreated GOTO _VIEW_STATUS END IF

  #檢核View是否有無效建立, 若有, 則掛上失效中
  CALL sadzi200_util_check_view_if_invalid(lo_dziv_t.DZIV001) RETURNING lb_result
  IF lb_result THEN LET ls_view_status = cs_view_status_invalid GOTO _VIEW_STATUS END IF  

  #檢核View Data是否比較新, 若是, 則掛上失效中
  CALL sadzi200_util_check_view_if_expired(lo_dziv_t.*) RETURNING lb_result 
  IF lb_result THEN LET ls_view_status = cs_view_status_invalid GOTO _VIEW_STATUS END IF
  
  LABEL _VIEW_STATUS:
  
  LET lo_dziv_t.DZIV005 = ls_view_status
  CALL sadzi200_crud_set_view_status(lo_dziv_t.*) RETURNING lb_result
    
  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzi200_util_get_mdmdb_name(p_erp_db)
DEFINE
  p_erp_db STRING
DEFINE
  ls_erp_db STRING,
  ls_sql        STRING,
  ls_mdm_name   VARCHAR(20),
  li_rec_count  INTEGER
DEFINE
  ls_return  STRING

  LET ls_erp_db = p_erp_db

  #取得MDM資料
  LET ls_sql = "SELECT EJ.DZEJ007                                               ",
               "  FROM DZEJ_T EJ                                                ",
               " WHERE EJ.DZEJ001 = 'adzi180_parameters'                        ",
               "   AND EJ.DZEJ004 = 'MDMDB'                                     ",
               "   AND EJ.DZEJ005 = (                                           ",
               "                      SELECT EJT.DZEJ005                        ",
               "                        FROM DZEJ_T EJT                         ",
               "                       WHERE EJT.DZEJ001 = 'adzi180_parameters' ",
               "                         AND EJT.DZEJ004 in ('ERPDB','MDMDB')   ",
               "                         AND EJT.DZEJ007 = '",ls_erp_db,"'      ",
               "                    )                                           "
 
  PREPARE lpre_get_mdmdb_name FROM ls_sql
  DECLARE lcur_get_mdmdb_name CURSOR FOR lpre_get_mdmdb_name
  OPEN lcur_get_mdmdb_name
  FETCH lcur_get_mdmdb_name INTO ls_mdm_name
  CLOSE lcur_get_mdmdb_name
  FREE lcur_get_mdmdb_name
  FREE lpre_get_mdmdb_name

  LET ls_return = ls_mdm_name

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzi200_util_get_erpdb_name(p_mdmdb)
DEFINE
  p_mdmdb STRING
DEFINE
  ls_mdmdb STRING,
  ls_sql        STRING,
  ls_erp_name   VARCHAR(20),
  li_rec_count  INTEGER
DEFINE
  ls_return  STRING

  LET ls_mdmdb = p_mdmdb

  #取得MDM資料
  LET ls_sql = "SELECT EJ.DZEJ007                                               ",
               "  FROM DZEJ_T EJ                                                ",
               " WHERE EJ.DZEJ001 = 'adzi180_parameters'                        ",
               "   AND EJ.DZEJ004 = 'ERPDB'                                     ",
               "   AND EJ.DZEJ005 = (                                           ",
               "                      SELECT EJT.DZEJ005                        ",
               "                        FROM DZEJ_T EJT                         ",
               "                       WHERE EJT.DZEJ001 = 'adzi180_parameters' ",
               "                         AND EJT.DZEJ004 in ('MDMDB','ERPDB')   ",
               "                         AND EJT.DZEJ007 = '",ls_mdmdb,"'       ",
               "                    )                                           "
 
  PREPARE lpre_get_erpdb_name FROM ls_sql
  DECLARE lcur_get_erpdb_name CURSOR FOR lpre_get_erpdb_name
  OPEN lcur_get_erpdb_name
  FETCH lcur_get_erpdb_name INTO ls_erp_name
  CLOSE lcur_get_erpdb_name
  FREE lcur_get_erpdb_name
  FREE lpre_get_erpdb_name

  LET ls_return = ls_erp_name

  RETURN ls_return
  
END FUNCTION

#呼叫 ALM 取得 DZLU 資訊
FUNCTION sadzi200_util_alm_check_out(p_enable_alm,p_user,p_lang,p_role,p_wizard)
DEFINE
  p_enable_alm BOOLEAN,
  p_user       STRING,
  p_lang       STRING,
  p_role       STRING, 
  p_wizard     BOOLEAN 
DEFINE
  lb_enable_alm BOOLEAN,
  ls_user       STRING,
  ls_lang       STRING,
  ls_role       STRING, 
  li_step       INTEGER,
  lb_wizard     BOOLEAN, 
  lo_DZLU_T     DYNAMIC ARRAY OF T_DZLU_T,
  lo_user_info  T_USER_INFO,
  lb_result     BOOLEAN

  LET lb_enable_alm = p_enable_alm
  LET ls_user       = p_user
  LET ls_lang       = p_lang
  LET ls_role       = p_role
  LET lb_wizard     = p_wizard
  
  #設定使用者資訊
  LET lo_user_info.ui_NUMBER = ls_user
  &ifndef DEBUG 
    LET lo_user_info.ui_NAME = cl_get_username(ls_user)
  &else  ""  
    LET lo_user_info.ui_NAME = cs_null_username_default
  &endif
  LET lo_user_info.ui_LANG   = ls_lang
  LET lo_user_info.ui_ROLE   = ls_role

  IF (lb_enable_alm) THEN
    #取得DZLU資料
    CALL sadzp200_ckout_run(lo_USER_INFO.ui_ROLE,lo_USER_INFO.ui_NUMBER,lo_USER_INFO.ui_LANG,0,lb_wizard) RETURNING lb_result,li_step,lo_DZLU_T
  ELSE
    CALL sadzp200_ckout_get_dzlu_without_alm(lo_USER_INFO.ui_ROLE,lo_USER_INFO.ui_NUMBER) RETURNING lb_result,lo_DZLU_T
  END IF

  RETURN lb_result,lo_user_info.*,lo_DZLU_T
  
END FUNCTION 

FUNCTION sadzi200_util_set_alm_info(p_view_name,p_module_name,p_view_desc,p_spec_type,p_role,p_DZLU_T)
DEFINE
  p_view_name   STRING,
  p_module_name STRING,
  p_view_desc   STRING,
  p_spec_type   STRING,
  p_role        STRING,
  p_DZLU_T      DYNAMIC ARRAY OF T_DZLU_T
DEFINE
  ls_view_name    STRING,
  ls_module_name  STRING,
  ls_view_desc    STRING,
  ls_spec_type    STRING,
  ls_role         STRING,
  lo_DZLU_T       DYNAMIC ARRAY OF T_DZLU_T,
  lb_result       BOOLEAN,
  ls_update_type  STRING,
  li_dzlu         INTEGER,
  ls_GUID         STRING,
  lo_dzlm_t       T_DZLM_T,
  lo_DZAF_T       T_DZAF_T,
  lo_table_info   T_PROGRAM_INFO
DEFINE
  lb_return  BOOLEAN,
  lo_return  T_DZLM_T

  LET ls_view_name   = p_view_name
  LET ls_module_name = p_module_name
  LET ls_view_desc   = p_view_desc
  LET ls_spec_type   = p_spec_type
  LET ls_role        = p_role
  LET lo_DZLU_T      = p_DZLU_T

  #設定表格資訊 
  LET lo_table_info.pi_NAME   = ls_view_name
  LET lo_table_info.pi_MODULE = ls_module_name
  LET lo_table_info.pi_DESC   = ls_view_desc
  LET lo_table_info.pi_TYPE   = ls_spec_type 
  
  #設定版號輸入資料
  LET lo_DZAF_T.DZAF001 = lo_table_info.pi_NAME
  LET lo_DZAF_T.DZAF005 = lo_table_info.pi_TYPE
  LET lo_DZAF_T.DZAF006 = lo_table_info.pi_MODULE
  
  #取得新版號
  CALL sadzp200_ver_get_new_ver_info(lo_DZAF_T.*,ls_role,FALSE) RETURNING lb_result,lo_DZAF_T.*
  IF NOT lb_result THEN DISPLAY cs_error_tag,"Get New version information fault." GOTO _RETURN END IF 
  #彙整入DZLM_T 
  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID
  FOR li_dzlu = 1 TO lo_DZLU_T.getLength()
    IF lo_DZLU_T[li_dzlu].DZLU001 IS NOT NULL THEN 
      CALL sadzp200_alm_set_dzlm_mix_info(lo_DZLU_T[li_dzlu].*,lo_DZAF_T.*,lo_table_info.*,ls_GUID) RETURNING lb_result,ls_update_type
      EXIT FOR 
    END IF   
  END FOR 
  IF NOT lb_result THEN DISPLAY cs_error_tag,"Set DZLM data fault." GOTO _RETURN END IF 
  CALL sadzp200_alm_get_dzlm(lo_table_info.*,cs_user_role_sd) RETURNING lo_dzlm_t.*  
  IF NOT lb_result THEN DISPLAY cs_error_tag,"Get DZLM information fault." GOTO _RETURN END IF
  
  LABEL _RETURN:

  LET lb_return = lb_result
  LET lo_return.* = lo_dzlm_t.*  

  RETURN lb_return,lo_return.*
  
END FUNCTION 

FUNCTION sadzi200_util_alm_check_in(p_view_info,p_role)
DEFINE
  p_view_info  T_PROGRAM_INFO,
  p_role       STRING
DEFINE
  lo_view_info  T_PROGRAM_INFO,
  ls_role       STRING,
  lo_dzlm_t     T_DZLM_T,
  lb_result     BOOLEAN
DEFINE
  lb_return  BOOLEAN  

  LET lo_view_info.* = p_view_info.*
  LET ls_role = p_role

  CALL sadzp200_alm_get_dzlm(lo_view_info.*,ls_role) RETURNING lo_dzlm_t.*
  
  BEGIN WORK
  
  CALL sadzp200_alm_update_check_in_code(lo_dzlm_t.*,ls_role) RETURNING lb_result
  IF NOT lb_result THEN GOTO _CheckWork END IF

  #檢核DZLM資料是否還有簽出的
  CALL sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_out) RETURNING lb_result
  IF NOT lb_result THEN
    #當DZLM中的SD或PR項均無簽出者,則 DZLM 資訊更新遷入日期結案
    CALL sadzp200_alm_update_check_in_date(lo_DZLM_T.*) RETURNING lb_result
    IF NOT lb_result THEN GOTO _CheckWork END IF 
  END IF
  
  LABEL _CheckWork:
  
  IF lb_result THEN 
    COMMIT WORK
  ELSE
    ROLLBACK WORK
  END IF

  LET lb_return = lb_result

  RETURN lb_return
      
END FUNCTION

FUNCTION sadzi200_util_set_form_style(p_lang)
DEFINE
  p_lang STRING
DEFINE
  ls_lang     STRING,
  ls_cfg_path STRING,
  ls_4st_path STRING

  LET ls_lang = p_lang
  
  LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
  LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), ls_lang), "designer.4st")
  
  TRY 
    CALL ui.Interface.loadStyles(ls_4st_path)
  CATCH
    DISPLAY cs_warning_tag,"Can not found 'designer.4st' !"
  END TRY   
  
END FUNCTION 

################################################################################
# Descriptions...: 客製還原標準
# Memo...........: 刪除客製設計資料，清除ALM資料
# Usage..........: sadzi200_util_restore_to_standard(p_dziv_t) 
#                    RETURNING lb_return
# Input parameter: p_dziv_t   view 設計資料
#                : 
# Return code....: lb_return  true:還原成功, false: 還原失敗
#                : 
# Date & Author..: 20160224 by Jack Cheng
# Modify.........: 20160315 by CircleLai
################################################################################
FUNCTION sadzi200_util_restore_to_standard(p_dziv_t)
  DEFINE
  p_dziv_t      T_DZIV_T_WL
  DEFINE
    lo_dziv_t     T_DZIV_T_WL,
    ls_sqlwhere   STRING,
    ls_sql        STRING,
    ls_view_name  STRING,   #視觀表ID
    ls_stand_cust STRING,   #客制旗標
    li_rec_count  INTEGER,
    lb_result     BOOLEAN,
    lb_del_temp   BOOLEAN   #是否要刪除樣版 
  DEFINE
    lb_return  BOOLEAN
  
  LET lo_dziv_t.* = p_dziv_t.*
  
  LET lb_return = TRUE 
  LET lb_result = TRUE
  LET ls_view_name = lo_dziv_t.DZIV001
  LET ls_stand_cust = lo_dziv_t.DZIV003

  #檢查傳入資料正確性
  IF (ls_view_name IS NULL 
      || ls_stand_cust IS NULL ) THEN 
    LET lb_return = FALSE
  END IF
  
  #是否要一併刪除樣板
  IF (NOT sadzi200_crud_check_if_design_data_exists(lo_dziv_t.*)) THEN          
    LET lb_del_temp = TRUE 
  ELSE 
    LET lb_del_temp = FALSE 
  END IF 
  
  IF (lb_return) THEN
    BEGIN WORK
    #刪除設計資料 from dziv_t
    IF (lb_result) THEN
      LET ls_sqlwhere = " WHERE IV.DZIV001='",ls_view_name,"' "
      IF (lb_del_temp) THEN 
        LET ls_sqlwhere = ls_sqlwhere, 
                          "   AND IV.DZIV002 in ('",lo_dziv_t.DZIV002,"','",cs_template_words,"') "
      ELSE 
        LET ls_sqlwhere = ls_sqlwhere, "   AND IV.DZIV002='",lo_dziv_t.DZIV002,"' "
      END IF 
      LET ls_sqlwhere = ls_sqlwhere, 
                        "   AND IV.DZIV003='",ls_stand_cust,"' "
      LET ls_sql = "DELETE FROM dziv_t IV ", ls_sqlwhere
      
    CALL sadzi200_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
    END IF
  
    #刪除設計資料 from dzivl_t
    IF (lb_result) THEN
      LET ls_sqlwhere = " WHERE IVL.DZIVL001='",ls_view_name,"' "
                        
      IF (lb_del_temp) THEN
        LET ls_sqlwhere = ls_sqlwhere, 
                          "   AND IVL.DZIVL002 in ('",lo_dziv_t.DZIV002,"','",cs_template_words,"') "
      ELSE 
        LET ls_sqlwhere = ls_sqlwhere, "   AND IVL.DZIVL002='",lo_dziv_t.DZIV002,"' "
      END IF 
      LET ls_sqlwhere = ls_sqlwhere,
                        "   AND IVL.DZIVL003='",ls_stand_cust,"' "
      LET ls_sql = "DELETE FROM dzivl_t IVL ", ls_sqlwhere  
      CALL sadzi200_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
    END IF 

    # add at 20160315 by CircleLai start
    #刪除 DZLM_T (簽出入記錄) 
    IF (lb_result) THEN
      LET ls_sqlwhere = " WHERE LM.DZLM001='MV' ",
                        "   AND LM.DZLM002='",ls_view_name,"' "
      LET ls_sql = "DELETE FROM DZLM_T LM ", ls_sqlwhere
      CALL sadzi200_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
    END IF
    
    #刪除 DZAF_T (版本樹) 中有關客制的部分
    IF lb_result THEN
      LET ls_sqlwhere = " WHERE DZAF001='", ls_view_name, "'    ", 
                        "   AND DZAF005='MV'  ", 
                        "   AND DZAF010='", ls_stand_cust, "' "
      LET ls_sql = "DELETE FROM DZAF_T ", ls_sqlwhere
      CALL sadzi200_db_exec_SQL_no_commit(ls_sql, FALSE) RETURNING lb_result
    END IF
    # add at 20160315 by CircleLai end
    
    IF lb_result THEN
      COMMIT WORK 
    ELSE
      LET lb_return = FALSE 
      ROLLBACK WORK
    END IF
    
  END IF 
  
  RETURN lb_return
  
END FUNCTION

#20160706 begin
FUNCTION sadzi200_util_get_alter_view_error_message(p_view_id)
DEFINE
  p_view_id STRING
DEFINE
  ls_view_id STRING,
  ls_sql     STRING,
  lv_errmsg  VARCHAR(1000),
  ls_message STRING
DEFINE
  ls_return STRING  

  LET ls_view_id = p_view_id
  LET ls_message = ""

  LET ls_sql = "SELECT 'Create or replace view '||owner||'.'||name||' with error : '||TEXT AS ERR_MSG ",
               "  FROM DBA_ERRORS                                                                     ",
               " WHERE TYPE = 'VIEW'                                                                  ",
               "   AND NAME = '", ls_view_id.toUpperCase(),"'                                         "
               
  PREPARE lpre_get_alter_view_error_message FROM ls_sql
  DECLARE lcur_get_alter_view_error_message CURSOR FOR lpre_get_alter_view_error_message
  OPEN lcur_get_alter_view_error_message
  FOREACH lcur_get_alter_view_error_message INTO lv_errmsg
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    LET ls_message = ls_message,"\n",
                     lv_errmsg
  END FOREACH
  CLOSE lcur_get_alter_view_error_message
  FREE lcur_get_alter_view_error_message
  FREE lpre_get_alter_view_error_message

  LET ls_return = ls_message

  RETURN ls_return
    
END FUNCTION

FUNCTION sadzi200_util_check_view_exists(p_dziv_t)
DEFINE        
  p_dziv_t   T_DZIV_T_WL
DEFINE
  lo_dziv_t     T_DZIV_T_WL,
  ls_view_name  STRING,
  ls_db_type    STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  ls_gzda005    STRING
DEFINE  
  lb_return     BOOLEAN

  LET lo_dziv_t.* = p_dziv_t.*
  
  LET ls_view_name = UPSHIFT(lo_dziv_t.DZIV001)
  LET ls_db_type   = lo_dziv_t.DZIV002

  CASE
    WHEN ls_db_type = cs_alias_erp_db
      LET ls_gzda005 = "Y"
    WHEN ls_db_type = cs_alias_aws_db
      LET ls_gzda005 = "M"
  END CASE

  #取得資料筆數
  LET ls_sql = "SELECT CASE                                         ",
               "         WHEN DBCS.CNTS <> DACS.CNTS THEN 0 ELSE 1  ",
               "       END AS CNTS                                  ",
               "  FROM (                                            ",
               "        SELECT COUNT(1) CNTS                        ",   
               "          FROM DBA_OBJECTS DOS                      ",
               "         WHERE DOS.OBJECT_NAME = '",ls_view_name,"' ",
               "           AND DOS.OBJECT_TYPE = 'VIEW'             ",
               "       ) DBCS,                                      ",
               "       (                                            ",
               "        SELECT COUNT(1) CNTS                        ",
               "          FROM GZDA_T DA                            ",
               "         WHERE DA.GZDASTUS = 'Y'                    ",
               "           AND DA.GZDA005  = '",ls_gzda005,"'       ",
               "       ) DACS                                       ",
               " WHERE 1=1                                          "
 
  PREPARE lpre_check_view_exists FROM ls_sql
  DECLARE lcur_check_view_exists CURSOR FOR lpre_check_view_exists
  OPEN lcur_check_view_exists
  FETCH lcur_check_view_exists INTO li_rec_count
  CLOSE lcur_check_view_exists
  FREE lcur_check_view_exists
  FREE lpre_check_view_exists

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi200_util_check_view_if_invalid(p_view_name)
DEFINE        
  p_view_name  STRING
DEFINE
  ls_view_name  STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  lb_return     BOOLEAN

  LET ls_view_name = p_view_name.toUpperCase()

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                             ",
               "  FROM DBA_OBJECTS DOS                      ",
               " WHERE DOS.OBJECT_NAME = '",ls_view_name,"' ", 
               "   AND DOS.OBJECT_TYPE = 'VIEW'             ",
               "   AND DOS.STATUS      = 'INVALID'          "
   
  PREPARE lpre_check_view_if_invalid FROM ls_sql
  DECLARE lcur_check_view_if_invalid CURSOR FOR lpre_check_view_if_invalid
  OPEN lcur_check_view_if_invalid
  FETCH lcur_check_view_if_invalid INTO li_rec_count
  CLOSE lcur_check_view_if_invalid
  FREE lcur_check_view_if_invalid
  FREE lpre_check_view_if_invalid

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi200_util_check_view_if_expired(p_dziv_t)
DEFINE        
  p_dziv_t   T_DZIV_T_WL
DEFINE
  lo_dziv_t     T_DZIV_T_WL,
  ls_view_name  STRING,
  ls_db_type    STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  ls_gzda005    STRING
DEFINE  
  lb_return     BOOLEAN

  LET lo_dziv_t.* = p_dziv_t.*
  
  LET ls_view_name = lo_dziv_t.DZIV001

  #取得資料筆數
  LET ls_sql = "SELECT CASE                                                                   ",
               "         WHEN DALMDT.LAST_MODIFY_TIME > DBLMDT.LAST_MODIFY_TIME THEN 1 ELSE 0 ",
               "       END LMDT                                                               ",
               "  FROM (                                                                      ",
               "        SELECT MAX(DOS.LAST_DDL_TIME) LAST_MODIFY_TIME                        ",
               "          FROM DBA_OBJECTS DOS                                                ",
               "         WHERE DOS.OBJECT_NAME = '",ls_view_name.toUpperCase(),"'             ",
               "           AND DOS.OBJECT_TYPE = 'VIEW'                                       ",
               "       ) DBLMDT,                                                              ",
               "       (                                                                      ",
               "        SELECT IV.DZIVMODDT LAST_MODIFY_TIME                                  ",
               "          FROM DZIV_T IV                                                      ",
               "         WHERE IV.DZIV001 = '",ls_view_name.toLowerCase(),"'                  ",
               "       ) DALMDT                                                               ",
               " WHERE 1=1                                                                    "
                                                                                              
  PREPARE lpre_check_view_if_expired FROM ls_sql
  DECLARE lcur_check_view_if_expired CURSOR FOR lpre_check_view_if_expired
  OPEN lcur_check_view_if_expired
  FETCH lcur_check_view_if_expired INTO li_rec_count
  CLOSE lcur_check_view_if_expired
  FREE lcur_check_view_if_expired
  FREE lpre_check_view_if_expired

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi200_util_check_program_exists(p_program_name)
DEFINE
  p_program_name  STRING
DEFINE
  ls_program_name STRING,
  ls_sql          STRING,
  li_rec_count    INTEGER
DEFINE
  lb_return  BOOLEAN

  LET ls_program_name = p_program_name.toLowerCase()

  LET li_rec_count = 0

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                           ",
               "  FROM GZZA_T ZA                          ",
               " WHERE 1=1                                ",
               "   AND ZA.GZZA001 = '",ls_program_name,"' "
 
  PREPARE lpre_check_program_exists FROM ls_sql
  DECLARE lcur_check_program_exists CURSOR FOR lpre_check_program_exists
  OPEN lcur_check_program_exists
  FETCH lcur_check_program_exists INTO li_rec_count
  CLOSE lcur_check_program_exists
  FREE lcur_check_program_exists
  FREE lpre_check_program_exists

  IF li_rec_count = 0 THEN
    DISPLAY cs_warning_tag,"No such execution program ",ls_program_name
  ELSE 
    DISPLAY cs_message_tag,"Execution program ",ls_program_name," found !"  
  END IF
  
  LET lb_return = IIF(li_rec_count==0,FALSE,TRUE)
  
  RETURN lb_return
  
END FUNCTION
#20160706 end