&include "../4gl/sadzi190_mcr.inc"

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi190_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi190_type.inc"

GLOBALS "../../cfg/top_global.inc"

DEFINE
  ms_execute_path STRING

FUNCTION sadzi190_util_set_execute_path(p_path)
DEFINE
  p_path STRING 

  LET ms_execute_path = p_path
  
END FUNCTION 

FUNCTION sadzi190_util_get_execute_path()
DEFINE
  ls_path STRING 
  
  LET ls_path = ms_execute_path

  RETURN ls_path
  
END FUNCTION 

FUNCTION sadzi190_util_get_form_path(p_form_name)
DEFINE
  p_form_name STRING 
DEFINE
  ls_form_name    STRING,
  ls_path         STRING,
  ls_os_separator STRING,
  ls_form_path    STRING

  LET ls_form_name = p_form_name
  
  LET ls_path = sadzi190_util_get_execute_path()
  LET ls_os_separator = os.Path.separator()
  LET ls_form_path = ls_path,ls_os_separator,ls_form_name                      

  RETURN ls_form_path
  
END FUNCTION 

################################################################################
# @desc.   刪除字串中\r,\n,\t,空白符號
# @para.   p_string 要處理的字串
# @return  ls_return  回傳處理後的字串
# @modify  170210-00052#1 at 2017/02/14 by circlelai 調整字串處理功能
################################################################################
FUNCTION sadzi190_util_trim_str(p_string)
DEFINE
  p_string STRING
DEFINE ls_string STRING
DEFINE lo_strbuf base.StringBuffer
  
DEFINE 
  ls_return STRING

  LET ls_string = p_string.trim()
  
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

FUNCTION sadzi190_util_get_table_leading_code(p_trigger_name)
DEFINE
  p_trigger_name STRING 
DEFINE
  ls_trigger_name     STRING,
  ls_table_pre_name STRING, 
  li_loop           INTEGER,
  ls_table_char     STRING
DEFINE
  ls_return STRING   
  
  LET ls_trigger_name = p_trigger_name
  
  LET ls_table_pre_name = ls_trigger_name
  FOR li_loop = 1 TO ls_trigger_name.getLength()
    LET ls_table_char = NVL(ls_trigger_name.subString(li_loop,li_loop),"@") 
    IF ls_table_char MATCHES "[_]" THEN
      LET ls_table_pre_name = ls_trigger_name.subString(1,li_loop - 1)
      EXIT FOR
    END IF    
  END FOR

  LET ls_return = ls_table_pre_name

  RETURN ls_return
  
END FUNCTION 

FUNCTION sadzi190_util_get_program_title(p_program,p_lang)
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

FUNCTION sadzi190_util_gen_sql_script_file(p_sql,p_sql_type)
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
  CALL sadzi190_util_get_GUID() RETURNING ls_GUID 
  
  LET ls_sript_filename = ls_tempdir,ls_separator,"sadzi190_",ls_sql_type,"_",ls_GUID,".sql"
  
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")

  LET ls_sql = ls_sql, "\n", ls_exit_sign
  
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

FUNCTION sadzi190_util_get_GUID()
DEFINE 
  ls_GUID  STRING
DEFINE  
  ls_return STRING

  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID 

  LET ls_return = ls_GUID
  
  RETURN ls_return                     
  
END FUNCTION

FUNCTION sadzi190_util_get_trigger_event_list(p_datas,p_side)
DEFINE
  p_datas      STRING,
  p_side       STRING
DEFINE
  ls_datas         STRING,
  ls_side          STRING,
  lo_column_array  DYNAMIC ARRAY OF T_COLUMN_LIST,
  li_rec_cnt       INTEGER,
  ls_sql           STRING,
  ls_sql_where     STRING
DEFINE
  lo_return  DYNAMIC ARRAY OF T_COLUMN_LIST

  LET ls_datas      = p_datas
  LET ls_side       = p_side

  IF ls_side = cs_side_left THEN
    IF ls_datas <> "''" THEN
      LET ls_sql_where = " AND EJ.DZEJ005 NOT IN (",ls_datas,")"
    ELSE
      LET ls_sql_where = " AND 1=1 "
    END IF  
  ELSE
    IF ls_side = cs_side_right THEN
      IF ls_datas <> "''" THEN
        LET ls_sql_where = " AND EJ.DZEJ005 IN (",ls_datas,")"
      ELSE
        LET ls_sql_where = " AND 1=2 "
      END IF   
    END IF
  END IF

  LET ls_sql = "SELECT EJ.DZEJ005,EJ.DZEJ009             ",
               "  FROM DZEJ_T EJ                         ",
               " WHERE EJ.DZEJ001 = 'adzi190_parameters' ",
               "   AND EJ.DZEJ004 = '",cs_param_event,"' ",
               ls_sql_where,
               " ORDER BY EJ.DZEJ002                     "
               
  PREPARE lpre_get_trigger_event_list FROM ls_sql
  DECLARE lcur_get_trigger_event_list CURSOR FOR lpre_get_trigger_event_list

  LET li_rec_cnt = 1

  CALL lo_column_array.Clear()
  
  OPEN lcur_get_trigger_event_list
  FOREACH lcur_get_trigger_event_list INTO lo_column_array[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CALL lo_column_array.deleteElement(li_rec_cnt)
  
  CLOSE lcur_get_trigger_event_list

  FREE lpre_get_trigger_event_list
  FREE lcur_get_trigger_event_list    

  LET lo_return = lo_column_array

  RETURN lo_return
  
END FUNCTION

#get per construct database, 取得預建構資料庫名稱 --DGW07558 add at 20160129
FUNCTION sadzi190_util_get_pre_const_db(p_tbl_name)  
  DEFINE 
    p_tbl_name STRING
  DEFINE
    lo_jsonobj      util.JSONObject, #"not_found","multi_db","const_db"
    lv_const_db     VARCHAR(100),
    li_rec_cnt      INTEGER,
    lb_not_found    BOOLEAN,  # table 找不到位於哪一個資料庫中
    lb_multi_db     BOOLEAN,  # table 同時存在ERP資料庫與中台資料庫中
    ls_const_db     STRING,   # table 預建構資料庫
    ls_sql          STRING
  DEFINE 
    lo_retval       util.JSONObject

  LET lb_not_found = TRUE  
  LET lb_multi_db  = FALSE 
  LET ls_const_db  = ""
  LET li_rec_cnt   = 0
  
  LET ls_sql = "SELECT DISTINCT '",cs_alias_erp_db,"' CONST_DB        ",
               " FROM DZEU_T EU                                       ",
               "WHERE EU.DZEU001 = '",p_tbl_name,"'                   ",
               "  AND EU.DZEU003 = '",cs_table_shorthand,"'           ",
               "  AND EXISTS (                                        ",
               "             SELECT *                                 ",
               "               FROM DZEJ_T EJ                         ",
               "              WHERE EJ.DZEJ001 = 'adzi180_parameters' ",
               "                AND EJ.DZEJ004 = 'ERPDB'              ",
               "                AND EJ.DZEJ007 = EU.DZEU002           ",
               "      )                                               ",
               "UNION ALL                                             ",
               "SELECT DISTINCT '",cs_alias_aws_db,"' CONST_DB        ",
               "  FROM DZIU_T IU                                      ",
               " WHERE IU.DZIU001 = '",p_tbl_name,"'                  ",
               "   AND IU.DZIU003 = '",cs_table_shorthand,"'          ",
               "  AND EXISTS (                                        ",
               "             SELECT *                                 ",
               "               FROM DZEJ_T EJ                         ",
               "              WHERE EJ.DZEJ001 = 'adzi180_parameters' ",
               "                AND EJ.DZEJ004 = 'MDMDB'              ",
               "                AND EJ.DZEJ007 = IU.DZIU002           ",
               "      )                                               "
  PREPARE lpre_get_pre_const_db FROM ls_sql
  DECLARE lcur_get_pre_const_db CURSOR FOR lpre_get_pre_const_db
  OPEN lcur_get_pre_const_db
  FOREACH lcur_get_pre_const_db INTO lv_const_db
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    LET lb_not_found = FALSE 
    LET li_rec_cnt = li_rec_cnt + 1
    LET ls_const_db = lv_const_db
  END FOREACH 
  CLOSE lcur_get_pre_const_db
  FREE lcur_get_pre_const_db
  FREE lpre_get_pre_const_db
  
  IF li_rec_cnt >= 2 THEN LET lb_multi_db = TRUE END IF 

  LET lo_jsonobj = util.JSONObject.create()

  IF (lb_not_found) THEN
    CALL lo_jsonobj.put("not_found", 1)
  ELSE 
    IF lb_multi_db THEN
      CALL lo_jsonobj.put("multi_db", 1)
    END IF
    CALL lo_jsonobj.put("const_db", ls_const_db) 
  END IF 

  LET lo_retval = lo_jsonobj
  RETURN lo_retval
END FUNCTION 

FUNCTION sadzi190_util_get_table_owner_list(p_trigger_name,p_datas,p_side)
DEFINE
  p_trigger_name STRING,
  p_datas      STRING,
  p_side       STRING
DEFINE
  ls_trigger_name    STRING,
  ls_datas         STRING,
  ls_side          STRING,
  lo_column_array  DYNAMIC ARRAY OF T_COLUMN_LIST,
  li_rec_cnt       INTEGER,
  ls_sql           STRING,
  ls_sql_eu_where  STRING,
  ls_sql_iu_where  STRING
DEFINE
  lo_return  DYNAMIC ARRAY OF T_COLUMN_LIST

  LET ls_trigger_name = p_trigger_name
  LET ls_datas      = p_datas
  LET ls_side       = p_side

  IF ls_side = cs_side_left THEN
    IF ls_datas <> "''" THEN
      LET ls_sql_eu_where = " AND EU.DZEU002 NOT IN (",ls_datas,")"
      LET ls_sql_iu_where = " AND IU.DZIU002 NOT IN (",ls_datas,")"
    ELSE
      LET ls_sql_eu_where = " AND 1=1 "
      LET ls_sql_iu_where = " AND 1=1 "
    END IF  
  ELSE
    IF ls_side = cs_side_right THEN
      IF ls_datas <> "''" THEN
        LET ls_sql_eu_where = " AND EU.DZEU002 IN (",ls_datas,")"
        LET ls_sql_iu_where = " AND IU.DZIU002 IN (",ls_datas,")"
      ELSE
        LET ls_sql_eu_where = " AND 1=2 "
        LET ls_sql_iu_where = " AND 1=2 "
      END IF   
    END IF
  END IF

  LET ls_sql = "SELECT EU.DZEU002, EU.DZEU002                            ",
               "  FROM DZEU_T EU                                         ",
               " WHERE EU.DZEU001 = '",ls_trigger_name,"'                  ",
               "   AND EU.DZEU003 = '",cs_table_shorthand,"'             ",
               ls_sql_eu_where,            
               "   AND EXISTS (                                          ", 
               "                SELECT 1                                 ",
               "                  FROM DZEJ_T EJ                         ",
               "                 WHERE EJ.DZEJ001 = 'adzi180_parameters' ",
               "                   AND EJ.DZEJ004 = 'ERPDB'              ",
               "                   AND EJ.DZEJ007 = EU.DZEU002           ",                                   
               "              )                                          ",
               "UNION ALL                                                ",
               "SELECT IU.DZIU002, IU.DZIU002                            ",
               "  FROM DZIU_T IU                                         ",
               " WHERE IU.DZIU001 = '",ls_trigger_name,"'                  ",
               "   AND IU.DZIU003 = '",cs_table_shorthand,"'             ",
               ls_sql_iu_where,            
               "   AND EXISTS (                                          ",
               "                SELECT 1                                 ",
               "                  FROM DZEJ_T EJ                         ",
               "                 WHERE EJ.DZEJ001 = 'adzi180_parameters' ",
               "                   AND EJ.DZEJ004 = 'MDMDB'              ",
               "                   AND EJ.DZEJ007 = IU.DZIU002           ",
               "              )                                          ",
               " ORDER BY 1                                              "
               
  PREPARE lpre_get_table_owner_list FROM ls_sql
  DECLARE lcur_get_table_owner_list CURSOR FOR lpre_get_table_owner_list

  LET li_rec_cnt = 1

  CALL lo_column_array.Clear()
  
  OPEN lcur_get_table_owner_list
  FOREACH lcur_get_table_owner_list INTO lo_column_array[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CALL lo_column_array.deleteElement(li_rec_cnt)
  
  CLOSE lcur_get_table_owner_list

  FREE lpre_get_table_owner_list
  FREE lcur_get_table_owner_list    

  LET lo_return = lo_column_array

  RETURN lo_return
  
END FUNCTION

#@description: 執行建構,建立或者取代Trigger
#@para: p_create_object  trigger 設計資料
#@para: p_owners_queue   預建構的資料庫名稱 queue list
#@return: lb_return      建構成功否
#@return: ls_all_message 執行日誌訊息
#@modify: 170210-00052#1 by circlelai 2017/02/13, 新增判斷是否啟用新版trigger script 執行建構  
FUNCTION sadzi190_util_create_replace_trigger(p_create_object,p_owners_queue)
DEFINE
  p_create_object  T_DZIT_T_WL,
  p_owners_queue   STRING
DEFINE
  lo_create_object       T_DZIT_T_WL, 
  lo_db_connstr          T_DB_COXN_STR,
  lo_object_info         DYNAMIC ARRAY OF T_DZEU_T, 
  lo_str_buf             base.StringBuffer,
  li_loop                INTEGER,
  ls_drop_dummy          STRING,
  ls_owners_queue        STRING,
  ls_crttrg_sql          STRING, 
  ls_crttrg_sql_filename STRING,
  ls_chktrg_sql          STRING,
  ls_chktrg_sql_filename STRING,
  ls_message             STRING,
  ls_all_message         STRING, 
  ls_alter_sql           STRING,
  ls_db_user_name        STRING,
  ls_check_error         STRING,
  ls_orig_script        STRING,
  ls_mdm_name            STRING,
  ls_erp_name            STRING,
  lb_success             BOOLEAN
# 170210-00052#1 begin
DEFINE lb_A_SYS_0059     BOOLEAN # [旗標]是否啟用新版trigger script 執行建構
DEFINE ls_A_SYS_0059     STRING  # 取得系統參數'A-SYS-0059'值  
# 170210-00052#1 end 
DEFINE 
  lb_return  BOOLEAN  

  LOCATE lo_create_object.DZIT008 IN FILE
  LOCATE lo_create_object.DZIT011 IN FILE
  
  LET lo_create_object.* = p_create_object.*
  LET ls_owners_queue = p_owners_queue
  LET ls_orig_script = lo_create_object.DZIT008
  LET lb_success = TRUE
  LET lo_str_buf = base.StringBuffer.create()
  LET lb_A_SYS_0059 = FALSE  # 預設使用舊版執行建構
  
  # 170210-00052#1 by circlelai begin
  # 判斷旗標使用新版或者舊版trigger 執行建構 
  LET ls_A_SYS_0059 = sadzi190_util_get_system_para_val("A-SYS-0059")
  IF (ls_A_SYS_0059.getLength() > 0 AND ls_A_SYS_0059 == "Y") THEN
    LET lb_A_SYS_0059 = TRUE # 使用新版trigger script
    # 檢查新版script若為空,使用舊版script
    LET ls_orig_script = sadzi190_util_trim_str(lo_create_object.DZIT011)
    IF (ls_orig_script.getLength() <= 0) THEN
      # 延用舊版本script
      LET lb_A_SYS_0059 = FALSE 
      LET ls_orig_script = lo_create_object.DZIT008
    ELSE
      LET ls_orig_script = lo_create_object.DZIT011
    END IF
  END IF 
  # 170210-00052#1 by circlelai end
  
  #取得表格在DB中是 Table or Synonym
  CALL sadzi190_db_get_object_information(lo_create_object.DZIT001,ls_owners_queue) RETURNING lo_object_info
  
  FOR li_loop = 1 TO lo_object_info.getLength()
    CALL sadzi190_db_get_db_connect_string(lo_object_info[li_loop].DZEU002) RETURNING lo_db_connstr.*
    
    #判斷若是要建立的型態為表格(T), 則產生Trigger建立Script
    IF lo_object_info[li_loop].DZEU003 = "T" THEN
      #變數{ERPDB}、{MDMDB}、{AWSDB}置換 --add at 201601271500 by DGW07558
      CALL sadzi190_util_get_mdmdb_name(lo_object_info[li_loop].DZEU002) RETURNING ls_mdm_name
      CALL sadzi190_util_get_erpdb_name(lo_object_info[li_loop].DZEU002) RETURNING ls_erp_name
      
      CALL lo_str_buf.clear()
      CALL lo_str_buf.append(ls_orig_script)
      CALL lo_str_buf.replace(cs_identify_mdm_db,ls_mdm_name,0) -- 置換{MDMDB}
      CALL lo_str_buf.replace("{AWSDB}",ls_mdm_name,0)          -- 置換{AWSDB}
      CALL lo_str_buf.replace(cs_identify_erp_db,ls_erp_name,0) -- 置換{ERPDB}
      LET  lo_create_object.DZIT008 = lo_str_buf.toString()
      
      LET ls_alter_sql = ""
      
      ###############################################################################################################################################################
      #取得Trigger Scripts
      LET ls_crttrg_sql = lo_create_object.DZIT008 , "\n" , cs_sql_go_sign
      LET ls_alter_sql = ls_alter_sql , "\n" , ls_crttrg_sql

      #產出 SQL Scripts File
      CALL sadzi190_util_gen_sql_script_file(ls_alter_sql,cs_create_trigger) RETURNING ls_crttrg_sql_filename
      LET lo_db_connstr.db_sql_filename = ls_crttrg_sql_filename
      IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
        CALL sadzi190_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
        LET ls_db_user_name = lo_db_connstr.db_username
        LET ls_all_message = ls_all_message , "\n" 
                           , "Process : " , "Create or Replace Trigger. " , (IIF(lb_A_SYS_0059, "(use new script)", "")) , "\n" 
                           , "User : " , lo_db_connstr.db_username,"\n",
                             ls_message
      END IF        
      ###############################################################################################################################################################
      
    END IF
    
    #異動過程中任一區域有任何錯誤, 就終止表格異動
    LET ls_check_error = ls_all_message.toUpperCase()
    IF (ls_check_error.getIndexOf("ERROR",1) > 0  
       || ls_check_error.getIndexOf("SP2-",1) > 0 ) THEN  
      LET lb_success = FALSE
      #顯示 trigger 詳細錯誤訊息--DGW07558_add_at20151203
      LET ls_chktrg_sql = "SHOW ERRORS TRIGGER ", lo_create_object.DZIT002 , ";"
            , "\n", cs_sql_go_sign
      CALL sadzi190_util_gen_sql_script_file(ls_chktrg_sql,"chktrg") RETURNING ls_chktrg_sql_filename
      LET lo_db_connstr.db_sql_filename = ls_chktrg_sql_filename
      CALL sadzi190_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
      LET ls_check_error = ls_message.toUpperCase()
      #將錯誤訊息加入回傳資料中
      LET ls_all_message = ls_all_message,"\n",
                           "Process :","SHOW ERRORS Trigger.","\n",
                           "User : ",lo_db_connstr.db_username,"\n",
                           ls_message
      EXIT FOR
    END IF

    # 新增"SP2-"判斷,表示執行時發生 SQL*Plus 錯誤  # 170210-00052#1 2017/02/13 begin by circlelai 
    IF (ls_check_error.getIndexOf("SP2-",1) > 0) THEN
       LET ls_all_message = ls_all_message , "\n" , "SQL*Plus Error." , "\n" # fixme: 可以優化錯誤顯示
       EXIT FOR
    END IF
    # 170210-00052#1 2017/02/13 end by circlelai
    
  END FOR

  LET lb_return = lb_success
  
  FREE lo_create_object.DZIT008
  FREE lo_create_object.DZIT011
  
  RETURN lb_return,ls_all_message
  
END FUNCTION

#刪除 Master Table 的資料
FUNCTION sadzi190_util_drop_trigger(p_dzit_t,p_owners_queue,p_delete_data)
DEFINE
  p_dzit_t         T_DZIT_T_WL,
  p_owners_queue   STRING,
  p_delete_data    BOOLEAN
DEFINE
  lo_dzit_t           T_DZIT_T_WL,
  ls_owners_queue     STRING,
  lb_delete_data      BOOLEAN,
  ls_trigger_name     STRING,
  lo_db_connstr       T_DB_COXN_STR,
  lo_object_info      DYNAMIC ARRAY OF T_DZEU_T,
  ls_sql              STRING,
  ls_replace_arg      STRING,
  ls_drop_script_name STRING,
  ls_all_message      STRING,
  ls_message          STRING,
  li_loop             INTEGER,
  ls_error            STRING,
  ls_question         STRING,
  ls_foreign_key_list STRING,
  lb_result           BOOLEAN,  
  lb_success          BOOLEAN
DEFINE 
  lb_return BOOLEAN  

  LET lo_dzit_t.*     = p_dzit_t.*
  LET ls_owners_queue = p_owners_queue  
  LET lb_delete_data  = p_delete_data
  
  LET ls_trigger_name = lo_dzit_t.DZIT001
  LET ls_trigger_name = lo_dzit_t.DZIT002
  
  LET lb_success    = TRUE 
  LET lb_result     = TRUE

  #取得表格形式,在DB中是 Table(T) or Synonym(S)
  CALL sadzi190_db_get_object_information(lo_dzit_t.DZIT001,ls_owners_queue) RETURNING lo_object_info
  
  FOR li_loop = 1 TO lo_object_info.getLength()
    CALL sadzi190_db_get_db_connect_string(lo_object_info[li_loop].DZEU002) RETURNING lo_db_connstr.*
    
    #若為表格, 則產生Drop Table Script file
    IF lo_object_info[li_loop].DZEU003 = "T" THEN
      CALL sadzi190_db_gen_drop_trigger_script(ls_trigger_name) RETURNING ls_drop_script_name 
      LET lo_db_connstr.db_sql_filename = ls_drop_script_name
      IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
        CALL sadzi190_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
        LET ls_all_message = ls_all_message,"\n",
                             "Process :","Drop Trigger.","\n", 
                             "User : ",lo_db_connstr.db_username,"\n",
                             ls_message
      END IF        
    END IF
    
  END FOR  
  
  LET ls_error = ls_all_message.toUpperCase()
  IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_success = FALSE
  END IF  

  IF lb_success AND lb_delete_data THEN 
    CALL sadzi190_util_delete_data(lo_dzit_t.*) RETURNING lb_result
    IF NOT lb_result THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = "adz-00164"   # 刪除設計資料過程出現錯誤
      LET g_errparam.extend = NULL
      LET g_errparam.popup  = TRUE  #訊息開窗顯示
      LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
      CALL cl_err()
      #CALL sadzi190_msg_message_box("Error","dialog","刪除表格相關資料時失敗.","stop")
    END IF 
  END IF    

  LET lb_success = lb_result
  LET lb_return = lb_success

  RETURN lb_return,ls_all_message
  
END FUNCTION

#開關trigger 
FUNCTION sadzi190_util_switch_trigger(p_dzit_t,p_josnobj)
DEFINE
  p_dzit_t        T_DZIT_T_WL,
  --p_owners_queue  STRING,
  p_josnobj       util.JSONObject   --owners_queue, switch_val
DEFINE
  lo_dzit_t           T_DZIT_T_WL, 
  lo_db_connstr       T_DB_COXN_STR,
  lo_object_info      DYNAMIC ARRAY OF T_DZEU_T,
  lo_jsonobj          util.JSONObject,
  li_loop             INTEGER,
  ls_owners_queue     STRING,
  ls_trigger_name     STRING,
  ls_switch_val       STRING,   #設置觸發器狀態 ?, "DISABLE", "ENABLED"
  ls_sql              STRING,
  ls_replace_arg      STRING,
  ls_drop_script_name STRING,
  ls_all_message      STRING,
  ls_message          STRING, 
  ls_error            STRING,
  ls_question         STRING,
  ls_foreign_key_list STRING,
  lb_result           BOOLEAN,
  lb_success          BOOLEAN
DEFINE 
  lb_return BOOLEAN  

  LET lo_dzit_t.*     = p_dzit_t.*

  IF (p_josnobj.has("owners_queue")) THEN
    LET ls_owners_queue = p_josnobj.get("owners_queue") 
  END IF
  --LET ls_owners_queue = p_owners_queue  
  
  IF (p_josnobj.has("switch_val")) THEN
    LET ls_switch_val = p_josnobj.get("switch_val") --"DISABLE" || "ENABLED"
  ELSE
    LET ls_switch_val = "?" 
  END IF 
  
  LET ls_trigger_name = lo_dzit_t.DZIT002 
  
  LET lb_success    = TRUE 
  LET lb_result     = TRUE

  #取得表格在DB中是 Table or Synonym
  CALL sadzi190_db_get_object_information(lo_dzit_t.DZIT001,ls_owners_queue) RETURNING lo_object_info
  
  FOR li_loop = 1 TO lo_object_info.getLength()
    CALL sadzi190_db_get_db_connect_string(lo_object_info[li_loop].DZEU002) RETURNING lo_db_connstr.*

    #若為表格, 則產生Disable Trigger Script file
    IF lo_object_info[li_loop].DZEU003 = "T" THEN
      LET lo_jsonobj = util.JSONObject.create()
      CALL lo_jsonobj.put("trigger_name", ls_trigger_name)
      IF (ls_switch_val <> "?") THEN #強制開或關
        CALL lo_jsonobj.put("status", ls_switch_val)
      END IF 
      CALL sadzi190_db_gen_switch_trigger_script(lo_jsonobj) RETURNING ls_drop_script_name 
      LET lo_db_connstr.db_sql_filename = ls_drop_script_name
      IF NVL(lo_db_connstr.db_username,cs_null_value) <> cs_null_value AND 
         NVL(lo_db_connstr.db_password,cs_null_value) <> cs_null_value THEN
        CALL sadzi190_db_sqlplus(lo_db_connstr.*) RETURNING ls_message
        LET ls_all_message = ls_all_message,"\n",
                             "Process :","Disable Trigger.","\n", 
                             "User : ",lo_db_connstr.db_username,"\n",
                             ls_message
      END IF        
    END IF
    
  END FOR  
  
  LET ls_error = ls_all_message.toUpperCase()
  IF (ls_error.getIndexOf("ERROR",1) > 0) THEN
    LET lb_success = FALSE
  END IF  

  LET lb_success = lb_result
  LET lb_return = lb_success

  RETURN lb_return,ls_all_message
  
END FUNCTION

#刪除設計資料 #older version . change at 20160126
FUNCTION sadzi190_util_delete_data_older(p_dzit_t)
DEFINE
  p_dzit_t  T_DZIT_T
DEFINE
  lo_dzit_t  T_DZIT_T,
  ls_sql     STRING
DEFINE
  lb_result BOOLEAN 
  
  LET lo_dzit_t.* = p_dzit_t.*

  LET lb_result = TRUE

  BEGIN WORK

  IF lb_result THEN 
    #Trigger資料表多語言檔
    LET ls_sql = "DELETE FROM DZITL_T                       ", 
                 " WHERE DZITL001 = '",lo_dzit_t.DZIT001,"' ",
                 "   AND DZITL002 = '",lo_dzit_t.DZIT002,"' ",
                 "   AND DZITL003 = '",lo_dzit_t.DZIT003,"' ",
                 "   AND DZITL004 = '",lo_dzit_t.DZIT004,"' "
                 
    CALL sadzi190_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
  END IF    
  
  IF lb_result THEN 
    #Trigger資料表
    LET ls_sql = "DELETE FROM DZIT_T                       ", 
                 " WHERE DZIT001 = '",lo_dzit_t.DZIT001,"' ",
                 "   AND DZIT002 = '",lo_dzit_t.DZIT002,"' ",
                 "   AND DZIT003 = '",lo_dzit_t.DZIT003,"' ",
                 "   AND DZIT004 = '",lo_dzit_t.DZIT004,"' "
                 
    CALL sadzi190_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
  END IF    

  IF lb_result THEN
    COMMIT WORK 
  ELSE
    ROLLBACK WORK
  END IF  

  RETURN lb_result  

END FUNCTION 
#刪除設計資料
FUNCTION sadzi190_util_delete_data(p_dzit_t)
DEFINE
  p_dzit_t  T_DZIT_T_WL
DEFINE
  lo_dzit_t  T_DZIT_T_WL,
  #li_fun_ver INTEGER,    --function version ,default = 0  
  ls_sql     STRING
DEFINE
  lb_result BOOLEAN 
   
  LET lo_dzit_t.* = p_dzit_t.* 
  LET lb_result = TRUE
  BEGIN WORK
  #Trigger資料表多語言檔
  IF lb_result THEN 
    LET ls_sql = "DELETE FROM DZITL_T                       ", 
                 " WHERE DZITL001 = '",lo_dzit_t.DZIT001,"' ",
                 "   AND DZITL002 = '",lo_dzit_t.DZIT002,"' ",
                 "   AND DZITL003 = '",lo_dzit_t.DZIT003,"' ",
                 "   AND DZITL004 = '",lo_dzit_t.DZIT004,"' "
    CALL sadzi190_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
  END IF    
  #Trigger資料表
  IF lb_result THEN 
    LET ls_sql = "DELETE FROM DZIT_T                       ", 
                 " WHERE DZIT001 = '",lo_dzit_t.DZIT001,"' ",
                 "   AND DZIT002 = '",lo_dzit_t.DZIT002,"' ",
                 "   AND DZIT003 = '",lo_dzit_t.DZIT003,"' ",
                 "   AND DZIT004 = '",lo_dzit_t.DZIT004,"' "
    CALL sadzi190_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
  END IF    

  IF (lb_result) THEN 
    #版本設定檔
    LET ls_sql = "DELETE FROM DZAF_T                       ", 
                 " WHERE DZAF001 = '",lo_dzit_t.DZIT002,"' ",
                 "   AND DZAF005 = 'MG'                    ",
                 "   AND DZAF010 = '",lo_dzit_t.DZIT004,"' "
    CALL sadzi190_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
  END IF
  IF (lb_result) THEN 
    #簽出入紀錄
    LET ls_sql = "DELETE FROM DZLM_T                       ", 
                 " WHERE DZLM002 = '",lo_dzit_t.DZIT002,"' ",
                 "   AND DZLM001 = 'MG'"
    CALL sadzi190_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
  END IF
    
  IF lb_result THEN
    COMMIT WORK 
  ELSE
    ROLLBACK WORK
  END IF  

  RETURN lb_result  

END FUNCTION 

# @desc. 依照目前trigger實際狀況更新trigger狀態到數據庫 
# @fixme  與sadzp310_asmg_and_set_trigger_status function 功能雷同,考慮整合；
FUNCTION sadzi190_get_and_set_trigger_status(p_dzit_t)
DEFINE
  p_dzit_t  T_DZIT_T_WL
DEFINE
  lo_dzit_t T_DZIT_T_WL,
  ls_status STRING,
  lb_result BOOLEAN
DEFINE
  lb_return BOOLEAN
  
  LET lo_dzit_t.* = p_dzit_t.*
  
  CALL sadzi190_db_get_trigger_status(lo_dzit_t.DZIT003,lo_dzit_t.DZIT001,lo_dzit_t.DZIT002) RETURNING ls_status
  LET lo_dzit_t.DZIT009 = ls_status
  CALL sadzi190_crud_set_trigger_status(lo_dzit_t.*) RETURNING lb_result
  
  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzi190_util_get_mdmdb_name(p_erp_db)
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

FUNCTION sadzi190_util_get_erpdb_name(p_mdmdb)
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

  #取得ERP資料
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
FUNCTION sadzi190_util_alm_check_out(p_enable_alm,p_user,p_lang,p_role,p_wizard)
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

FUNCTION sadzi190_util_set_alm_info(p_trigger_name,p_module_name,p_trigger_desc,p_spec_type,p_role,p_DZLU_T)
DEFINE
  p_trigger_name  STRING,
  p_module_name   STRING,
  p_trigger_desc  STRING,
  p_spec_type     STRING,
  p_role          STRING,
  p_DZLU_T        DYNAMIC ARRAY OF T_DZLU_T
DEFINE
  ls_trigger_name  STRING,
  ls_module_name   STRING,
  ls_trigger_desc  STRING,
  ls_spec_type     STRING,
  ls_role          STRING,
  lo_DZLU_T        DYNAMIC ARRAY OF T_DZLU_T,
  lb_result        BOOLEAN,
  ls_update_type   STRING,
  li_dzlu          INTEGER,
  ls_GUID          STRING,
  lo_dzlm_t        T_DZLM_T,
  lo_DZAF_T        T_DZAF_T,
  lo_table_info    T_PROGRAM_INFO
DEFINE
  lb_return  BOOLEAN,
  lo_return  T_DZLM_T
  

  LET ls_trigger_name = p_trigger_name
  LET ls_module_name  = p_module_name
  LET ls_trigger_desc = p_trigger_desc
  LET ls_spec_type    = p_spec_type
  LET ls_role         = p_role
  LET lo_DZLU_T       = p_DZLU_T

  #設定表格資訊 
  LET lo_table_info.pi_NAME   = ls_trigger_name
  LET lo_table_info.pi_MODULE = ls_module_name
  LET lo_table_info.pi_DESC   = ls_trigger_desc
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

FUNCTION sadzi190_util_alm_check_in(p_trigger_info,p_role)
DEFINE
  p_trigger_info  T_PROGRAM_INFO,
  p_role          STRING
DEFINE
  lo_trigger_info  T_PROGRAM_INFO,
  ls_role          STRING,
  lo_dzlm_t        T_DZLM_T,
  lb_result        BOOLEAN
DEFINE
  lb_return  BOOLEAN  

  LET lo_trigger_info.* = p_trigger_info.*
  LET ls_role = p_role

  CALL sadzp200_alm_get_dzlm(lo_trigger_info.*,ls_role) RETURNING lo_dzlm_t.*
  
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

# @desc. 確認程式是否存在
# @memo: 透過查詢程式資料表(gzza_t)取得程式是否有註冊
# @input_para.  p_program_name 程式名稱
# @return_para. lb_return 程式是否存在
# @create 170210-00052#1 at 2017/02/17 by circlelai
FUNCTION sadzi190_util_check_program_exists(p_program_name)
DEFINE -- input 
  p_program_name  STRING
DEFINE
  ls_program_name STRING,
  ls_sql          STRING,
  li_rec_count    INTEGER
  
DEFINE -- return 
  lb_return  BOOLEAN

  LET ls_program_name = p_program_name.toLowerCase()

  LET li_rec_count = 0

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1) FROM gzza_t WHERE GZZA001 = '",ls_program_name,"' "
 
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

# @desc. 取得系統全域參數值
# @input_para.  p_para_id  參數編號
# @return_para. ls_return  參數資料
# @create 170210-00052#1 2017/02/18 by circlelai
FUNCTION sadzi190_util_get_system_para_val(p_para_id)
DEFINE  -- input para
  p_para_id  STRING 
DEFINE  -- return para 
  ls_return  STRING
DEFINE l_para_id   LIKE gzsa_t.gzsa001
DEFINE l_para_val  LIKE gzsa_t.gzsa002
DEFINE li_cnt      INTEGER

  LET l_para_id = p_para_id
  
  # 判斷 參數編號 是否存在
  SELECT COUNT(1) INTO li_cnt FROM gzsa_t  WHERE gzsa001 = l_para_id;
  IF li_cnt > 0 THEN
    SELECT gzsa002 INTO l_para_val FROM gzsa_t WHERE gzsa001 = l_para_id;
  END IF 
  
  LET ls_return = l_para_val
  RETURN ls_return
END FUNCTION 


