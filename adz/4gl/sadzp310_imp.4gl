
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
  mb_backend_mode BOOLEAN,
  mb_result       BOOLEAN,
  ms_result       STRING,
  mo_EXP_LIST     DYNAMIC ARRAY OF T_EXP_HEADER,
  mo_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO

CONSTANT cs_msg_header_records_diff = "Header record information not equal to real data records."   

FUNCTION sadzp310_imp_run(p_backend_mode,p_COMPRESS_FILE_INFO,p_EXP_LIST)
DEFINE
  p_backend_mode       BOOLEAN,
  p_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO,
  p_EXP_LIST           DYNAMIC ARRAY OF T_EXP_HEADER
  
  CALL sadzp310_imp_initialize(p_backend_mode,p_COMPRESS_FILE_INFO.*,p_EXP_LIST)
  CALL sadzp310_imp_start()
  CALL sadzp310_imp_finalize()

  RETURN mb_result

END FUNCTION 

FUNCTION sadzp310_imp_initialize(p_backend_mode,p_COMPRESS_FILE_INFO,p_EXP_LIST)
DEFINE
  p_backend_mode       BOOLEAN,
  p_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO,
  p_EXP_LIST           DYNAMIC ARRAY OF T_EXP_HEADER
  
  LET mb_backend_mode         = p_backend_mode
  LET mo_COMPRESS_FILE_INFO.* = p_COMPRESS_FILE_INFO.*
  LET mo_EXP_LIST             = p_EXP_LIST
  
END FUNCTION 

FUNCTION sadzp310_imp_start()
DEFINE
  ls_curr_working_dir STRING,
  lb_result       BOOLEAN,
  lb_chdir        BOOLEAN,
  ls_work_path    STRING,
  ls_os_separator STRING,
  lo_EXP_LIST     DYNAMIC ARRAY OF T_EXP_HEADER

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  #取得目前工作目錄
  CALL os.Path.pwd() RETURNING ls_curr_working_dir

  #取得及切換工作目錄
  CALL sadzp310_util_making_work_directory(mo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE,cs_working_dir_type_import,mo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME) RETURNING lb_result,ls_work_path 

  #切換目錄成功了, 才開始作業
  IF lb_result THEN   
    CALL sadzp310_imp_moving_files(mo_COMPRESS_FILE_INFO.cfi_PATH,ls_work_path,mo_EXP_LIST) RETURNING lb_result
    IF lb_result THEN 
      CASE  
        #Trigger
        WHEN mo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE = cs_working_type_trigger 
          CALL sadzp310_imp_import_trigger_data(mo_EXP_LIST) RETURNING lb_result
        #view
        WHEN mo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE = cs_working_type_view 
          CALL sadzp310_imp_import_view_data(mo_EXP_LIST) RETURNING lb_result
        #MTable
        WHEN mo_COMPRESS_FILE_INFO.cfi_OBJECT_TYPE = cs_working_type_mtable 
          CALL sadzp310_imp_import_mtable_data(mo_EXP_LIST) RETURNING lb_result
      END CASE
    END IF  
  END IF  

  #切回原目錄
  CALL os.Path.chdir(ls_curr_working_dir) RETURNING lb_chdir    

  #設定回傳值
  LET mo_EXP_LIST = lo_EXP_LIST
  LET mb_result = lb_result
  
END FUNCTION 

FUNCTION sadzp310_imp_finalize()
END FUNCTION 

#### Trigger 段
FUNCTION sadzp310_imp_import_trigger_data(p_EXP_LIST)
DEFINE
  p_EXP_LIST  DYNAMIC ARRAY OF T_EXP_HEADER
DEFINE
  lo_EXP_LIST   DYNAMIC ARRAY OF T_EXP_HEADER,
  li_loop       INTEGER,
  lb_result     BOOLEAN,
  lo_T_DZIT_T   DYNAMIC ARRAY OF T_DZIT_T,
  lo_T_DZITL_T  DYNAMIC ARRAY OF T_DZITL_T
DEFINE
  lb_return BOOLEAN  

  LET lo_EXP_LIST = p_EXP_LIST
  
  LET lb_return = TRUE

  BEGIN WORK
  
  FOR li_loop = 1 TO lo_EXP_LIST.getLength()
    CASE 
      WHEN lo_EXP_LIST[li_loop].eh_EXP_TABLE = 'dzit_t' 
        CALL sadzp310_imp_get_dzit_t_data(lo_EXP_LIST[li_loop].*) RETURNING lb_result,lo_T_DZIT_T
        IF NOT lb_result THEN EXIT CASE END IF
        CALL sadzp310_imp_set_dzit_t_data(lo_T_DZIT_T) RETURNING lb_result
        IF NOT lb_result THEN EXIT CASE END IF
      WHEN lo_EXP_LIST[li_loop].eh_EXP_TABLE = 'dzitl_t' 
        CALL sadzp310_imp_get_dzitl_t_data(lo_EXP_LIST[li_loop].*) RETURNING lb_result,lo_T_DZITL_T
        IF NOT lb_result THEN EXIT CASE END IF
        CALL sadzp310_imp_set_dzitl_t_data(lo_T_DZITL_T) RETURNING lb_result
        IF NOT lb_result THEN EXIT CASE END IF
    END CASE

    IF NOT lb_result THEN
      EXIT FOR 
    END IF 
    
  END FOR

  IF lb_result THEN 
    COMMIT WORK
  ELSE 
    ROLLBACK WORK
  END IF  
  
  RETURN lb_return
  
END FUNCTION

#DZIT_T 相關 Funtion Start

# desc. 從打包檔中取得觸發器設計資料
FUNCTION sadzp310_imp_get_dzit_t_data(p_EXP_HEADER)
DEFINE
  p_EXP_HEADER  T_EXP_HEADER
DEFINE
  lo_EXP_HEADER  T_EXP_HEADER,
  ls_file_name   STRING,
  lb_result      BOOLEAN,
  ls_result      STRING,
  lo_json_arr    util.JSONArray,
  lo_json_obj    util.JSONObject,
  lo_IMP_HEADER  T_EXP_HEADER,
  lo_T_DZIT_T    DYNAMIC ARRAY OF T_DZIT_T,
  li_loop        INTEGER
DEFINE 
  lb_return BOOLEAN,
  lo_return DYNAMIC ARRAY OF T_DZIT_T

  LET lo_EXP_HEADER.* = p_EXP_HEADER.*

  LET lo_json_arr = util.JSONArray.create()
  LET lb_return = TRUE 
  
  LET ls_file_name = lo_EXP_HEADER.eh_EXP_NAME 
  CALL sadzp310_util_read_file_contents(ls_file_name) RETURNING lb_result,ls_result

  LET lo_json_arr = util.JSONArray.parse(ls_result)

  FOR li_loop = 1 TO lo_json_arr.getLength()
    IF li_loop = 1 THEN
      #第一筆是Header information
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_IMP_HEADER)
    ELSE
      #其他是被壓縮物件的內容
      INITIALIZE lo_json_obj TO NULL
      LOCATE lo_T_DZIT_T[li_loop - 1].DZIT008 IN FILE
      LOCATE lo_T_DZIT_T[li_loop - 1].DZIT011 IN FILE  # 170210-00052#1 add
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_T_DZIT_T[li_loop - 1])
    END IF
  END FOR

  #內容筆數和Header筆數和驗證檔中的筆數不同, 則判斷為錯誤
  IF (lo_T_DZIT_T.getLength() <> lo_IMP_HEADER.eh_EXP_RECORDS) OR
     (lo_T_DZIT_T.getLength() <> lo_EXP_HEADER.eh_EXP_RECORDS) THEN
    LET lb_return = FALSE
    DISPLAY cs_error_tag,cs_msg_header_records_diff
    #DISPLAY lo_T_DZIT_T.getLength(),",",lo_IMP_HEADER.eh_EXP_RECORDS,",",lo_EXP_HEADER.eh_EXP_RECORDS
  END IF 

  LET lo_return = lo_T_DZIT_T

  RETURN lb_return,lo_return

END FUNCTION

# @desc. 觸發器設計資料儲存到資料庫中
# @memo  insert or update data into dzit_t
# @input_para.  p_T_DZIT_T  觸發器設計資料
# @retuen_para. lb_return  儲存是否成功
# @modify 170210-00052#1 at 2017/02/15 by circlelai  新增dzit011欄位儲存行為
FUNCTION sadzp310_imp_set_dzit_t_data(p_T_DZIT_T)
DEFINE
  p_T_DZIT_T  DYNAMIC ARRAY OF T_DZIT_T
DEFINE
  lo_T_DZIT_T  DYNAMIC ARRAY OF T_DZIT_T,
  li_loop      INTEGER,
  ls_InsertSQL STRING,
  ls_UpdateSQL STRING,
  ls_user      VARCHAR(100),
  ldt_datetime DATETIME YEAR TO SECOND,
  lb_result    BOOLEAN
DEFINE
  lb_return BOOLEAN 
  
  LET lo_T_DZIT_T = p_T_DZIT_T

  LET lb_return = TRUE
  LET lb_result = TRUE

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USER")
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif
  
  FOR li_loop = 1 TO lo_T_DZIT_T.getLength()

    LET ls_InsertSQL = "insert into dzit_t ( "
                     , "DZIT001, DZIT002, DZIT003, DZIT004, DZIT005, "
                     , "DZIT006, DZIT007, DZIT008, DZIT009, DZIT010, DZIT011, "
                     , "DZITCRTID, DZITCRTDT, DZITMODID, DZITMODDT) " , "\n"
                     , "values ( "
                     , "?,?,?,?,?,"
                     , "?,?,?,?,?,?,"
                     , "?,?,?,?) " , "\n"
    #DISPLAY ls_InsertSQL  # debug
    
    LET ls_UpdateSQL = "update dzit_t " 
                     , "   set DZIT005 = ?, DZIT006 = ?, DZIT007 = ?, DZIT008 = ?, DZIT009 = ?, DZIT010 = ?, DZIT011 = ?, " , "\n"
                     , "       DZITMODID = ?, DZITMODDT = ? " , "\n"
                     , " where DZIT001 = ? and DZIT002 = ? and DZIT003 = ? and DZIT004 = ? " , "\n"                    
    #DISPLAY ls_UpdateSQL # debug
    
    TRY
      PREPARE lpre_set_insert_dzit_t_data FROM ls_InsertSQL
      EXECUTE lpre_set_insert_dzit_t_data USING lo_T_DZIT_T[li_loop].DZIT001,
                                                lo_T_DZIT_T[li_loop].DZIT002,
                                                lo_T_DZIT_T[li_loop].DZIT003,
                                                lo_T_DZIT_T[li_loop].DZIT004,
                                                lo_T_DZIT_T[li_loop].DZIT005,
                                                ----------------------------
                                                lo_T_DZIT_T[li_loop].DZIT006,
                                                lo_T_DZIT_T[li_loop].DZIT007,
                                                lo_T_DZIT_T[li_loop].DZIT008,
                                                lo_T_DZIT_T[li_loop].DZIT009,
                                                lo_T_DZIT_T[li_loop].DZIT010,
                                                lo_T_DZIT_T[li_loop].DZIT011,
                                                ----------------------------
                                                ls_user,
                                                ldt_datetime,
                                                ls_user,
                                                ldt_datetime
                                                ----------------------------
    CATCH
      TRY
        PREPARE lpre_set_update_dzit_t_data FROM ls_UpdateSQL
        EXECUTE lpre_set_update_dzit_t_data USING lo_T_DZIT_T[li_loop].DZIT005,
                                                  lo_T_DZIT_T[li_loop].DZIT006,
                                                  lo_T_DZIT_T[li_loop].DZIT007,
                                                  lo_T_DZIT_T[li_loop].DZIT008,
                                                  lo_T_DZIT_T[li_loop].DZIT009,
                                                  lo_T_DZIT_T[li_loop].DZIT010,
                                                  lo_T_DZIT_T[li_loop].DZIT011,
                                                  ----------------------------
                                                  ls_user,
                                                  ldt_datetime,
                                                  ----------------------------
                                                  lo_T_DZIT_T[li_loop].DZIT001,
                                                  lo_T_DZIT_T[li_loop].DZIT002,
                                                  lo_T_DZIT_T[li_loop].DZIT003,
                                                  lo_T_DZIT_T[li_loop].DZIT004
        
      CATCH 
        DISPLAY cs_error_tag,"INSERT/UPDATE DZIT_T FAULT !! ",ls_InsertSQL
        LET lb_result = FALSE
      END TRY
    END TRY  
                       
  END FOR

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION 
#DZIT_T 相關 Funtion End

#DZITL_T 相關 Funtion Start
FUNCTION sadzp310_imp_get_dzitl_t_data(p_EXP_HEADER)
DEFINE
  p_EXP_HEADER  T_EXP_HEADER
DEFINE
  lo_EXP_HEADER  T_EXP_HEADER,
  ls_file_name   STRING,
  lb_result      BOOLEAN,
  ls_result      STRING,
  lo_json_arr    util.JSONArray,
  lo_json_obj    util.JSONObject,
  lo_IMP_HEADER  T_EXP_HEADER,
  lo_T_DZITL_T   DYNAMIC ARRAY OF T_DZITL_T,
  li_loop        INTEGER
DEFINE 
  lb_return BOOLEAN,
  lo_return DYNAMIC ARRAY OF T_DZITL_T

  LET lo_EXP_HEADER.* = p_EXP_HEADER.*

  LET lo_json_arr = util.JSONArray.create()
  LET lb_return = TRUE
  
  LET ls_file_name = lo_EXP_HEADER.eh_EXP_NAME 
  CALL sadzp310_util_read_file_contents(ls_file_name) RETURNING lb_result,ls_result

  LET lo_json_arr = util.JSONArray.parse(ls_result)

  FOR li_loop = 1 TO lo_json_arr.getLength()
    IF li_loop = 1 THEN
      #第一筆是Header information
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_IMP_HEADER)
    ELSE
      #其他是被壓縮物件的內容
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_T_DZITL_T[li_loop - 1])
    END IF
  END FOR

  #內容筆數和Header筆數和驗證檔中的筆數不同, 則判斷為錯誤
  IF (lo_T_DZITL_T.getLength() <> lo_IMP_HEADER.eh_EXP_RECORDS) OR
     (lo_T_DZITL_T.getLength() <> lo_EXP_HEADER.eh_EXP_RECORDS) THEN
    LET lb_return = FALSE
    DISPLAY cs_error_tag,cs_msg_header_records_diff
    #DISPLAY lo_T_DZITL_T.getLength(),",",lo_IMP_HEADER.eh_EXP_RECORDS,",",lo_EXP_HEADER.eh_EXP_RECORDS
  END IF 

  LET lo_return = lo_T_DZITL_T

  RETURN lb_return,lo_return

END FUNCTION

FUNCTION sadzp310_imp_set_dzitl_t_data(p_T_DZITL_T)
DEFINE
  p_T_DZITL_T  DYNAMIC ARRAY OF T_DZITL_T
DEFINE
  lo_T_DZITL_T  DYNAMIC ARRAY OF T_DZITL_T,
  li_loop      INTEGER,
  ls_InsertSQL STRING,
  ls_UpdateSQL STRING,
  lb_result    BOOLEAN
DEFINE
  lb_return BOOLEAN 
  
  LET lo_T_DZITL_T = p_T_DZITL_T

  LET lb_return = TRUE
  LET lb_result = TRUE

  FOR li_loop = 1 TO lo_T_DZITL_T.getLength()

    LET ls_InsertSQL = "INSERT INTO DZITL_T (                                              ", 
                       "                     DZITL001,DZITL002,DZITL003,DZITL004,DZITL005, ",
                       "                     DZITL006,DZITL007                             ",
                       "                   ) VALUES                                        ",
                       "                   (                                               ",
                       "                     ?,?,?,?,?,                                    ",
                       "                     ?,?                                           ", 
                       "                   )                                               "

    LET ls_UpdateSQL = " UPDATE DZITL_T       ",
                       "    SET DZITL006 = ?, ",
                       "        DZITL007 = ?  ",
                       "  WHERE DZITL001 = ?  ",
                       "    AND DZITL002 = ?  ",
                       "    AND DZITL003 = ?  ",
                       "    AND DZITL004 = ?  ",                       
                       "    AND DZITL005 = ?  "                       

    TRY
      PREPARE lpre_set_insert_dzitl_t_data FROM ls_InsertSQL
      EXECUTE lpre_set_insert_dzitl_t_data USING lo_T_DZITL_T[li_loop].DZITL001,
                                                 lo_T_DZITL_T[li_loop].DZITL002,
                                                 lo_T_DZITL_T[li_loop].DZITL003,
                                                 lo_T_DZITL_T[li_loop].DZITL004,
                                                 lo_T_DZITL_T[li_loop].DZITL005,
                                                 ----------------------------
                                                 lo_T_DZITL_T[li_loop].DZITL006,
                                                 lo_T_DZITL_T[li_loop].DZITL007
    CATCH
      TRY
        PREPARE lpre_set_update_dzitl_t_data FROM ls_UpdateSQL
        EXECUTE lpre_set_update_dzitl_t_data USING lo_T_DZITL_T[li_loop].DZITL006,
                                                   lo_T_DZITL_T[li_loop].DZITL007,
                                                   ----------------------------
                                                   lo_T_DZITL_T[li_loop].DZITL001,
                                                   lo_T_DZITL_T[li_loop].DZITL002,
                                                   lo_T_DZITL_T[li_loop].DZITL003,
                                                   lo_T_DZITL_T[li_loop].DZITL004,
                                                   lo_T_DZITL_T[li_loop].DZITL005
                                                  
      CATCH 
        DISPLAY cs_error_tag,"INSERT/UPDATE DZITL_T FAULT !! ",ls_InsertSQL
        LET lb_result = FALSE
      END TRY
    END TRY  
                       
  END FOR

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION 
#DZITL_T 相關 Funtion End

#### View 段
FUNCTION sadzp310_imp_import_view_data(p_EXP_LIST)
DEFINE
  p_EXP_LIST  DYNAMIC ARRAY OF T_EXP_HEADER
DEFINE
  lo_EXP_LIST   DYNAMIC ARRAY OF T_EXP_HEADER,
  li_loop       INTEGER,
  lb_result     BOOLEAN,
  lo_T_DZIV_T   DYNAMIC ARRAY OF T_DZIV_T,
  lo_T_DZIVL_T  DYNAMIC ARRAY OF T_DZIVL_T
DEFINE
  lb_return BOOLEAN  

  LET lo_EXP_LIST = p_EXP_LIST
  
  LET lb_return = TRUE

  BEGIN WORK
  
  FOR li_loop = 1 TO lo_EXP_LIST.getLength()
    CASE 
      WHEN lo_EXP_LIST[li_loop].eh_EXP_TABLE = 'dziv_t' 
        CALL sadzp310_imp_get_dziv_t_data(lo_EXP_LIST[li_loop].*) RETURNING lb_result,lo_T_DZIV_T
        IF NOT lb_result THEN EXIT CASE END IF
        CALL sadzp310_imp_set_dziv_t_data(lo_T_DZIV_T) RETURNING lb_result
        IF NOT lb_result THEN EXIT CASE END IF
      WHEN lo_EXP_LIST[li_loop].eh_EXP_TABLE = 'dzivl_t' 
        CALL sadzp310_imp_get_dzivl_t_data(lo_EXP_LIST[li_loop].*) RETURNING lb_result,lo_T_DZIVL_T
        IF NOT lb_result THEN EXIT CASE END IF
        CALL sadzp310_imp_set_dzivl_t_data(lo_T_DZIVL_T) RETURNING lb_result
        IF NOT lb_result THEN EXIT CASE END IF
    END CASE

    IF NOT lb_result THEN
      EXIT FOR 
    END IF 
    
  END FOR

  IF lb_result THEN 
    COMMIT WORK
  ELSE 
    ROLLBACK WORK
  END IF  
  
  RETURN lb_return
  
END FUNCTION

#DZIV_T 相關 Funtion Start
FUNCTION sadzp310_imp_get_dziv_t_data(p_EXP_HEADER)
DEFINE
  p_EXP_HEADER  T_EXP_HEADER
DEFINE
  lo_EXP_HEADER  T_EXP_HEADER,
  ls_file_name   STRING,
  lb_result      BOOLEAN,
  ls_result      STRING,
  lo_json_arr    util.JSONArray,
  lo_json_obj    util.JSONObject,
  lo_IMP_HEADER  T_EXP_HEADER,
  lo_T_DZIV_T    DYNAMIC ARRAY OF T_DZIV_T,
  li_loop        INTEGER
DEFINE 
  lb_return BOOLEAN,
  lo_return DYNAMIC ARRAY OF T_DZIV_T

  LET lo_EXP_HEADER.* = p_EXP_HEADER.*

  LET lo_json_arr = util.JSONArray.create()
  LET lb_return = TRUE
  
  LET ls_file_name = lo_EXP_HEADER.eh_EXP_NAME 
  CALL sadzp310_util_read_file_contents(ls_file_name) RETURNING lb_result,ls_result

  LET lo_json_arr = util.JSONArray.parse(ls_result)

  FOR li_loop = 1 TO lo_json_arr.getLength()
    IF li_loop = 1 THEN
      #第一筆是Header information
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_IMP_HEADER)
    ELSE
      #其他是被壓縮物件的內容
      INITIALIZE lo_json_obj TO NULL
      LOCATE lo_T_DZIV_T[li_loop - 1].DZIV004 IN FILE
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_T_DZIV_T[li_loop - 1])
    END IF
  END FOR

  #內容筆數和Header筆數和驗證檔中的筆數不同, 則判斷為錯誤
  IF (lo_T_DZIV_T.getLength() <> lo_IMP_HEADER.eh_EXP_RECORDS) OR
     (lo_T_DZIV_T.getLength() <> lo_EXP_HEADER.eh_EXP_RECORDS) THEN
    LET lb_return = FALSE
    DISPLAY cs_error_tag,cs_msg_header_records_diff
    #DISPLAY lo_T_DZIV_T.getLength(),",",lo_IMP_HEADER.eh_EXP_RECORDS,",",lo_EXP_HEADER.eh_EXP_RECORDS
  END IF 

  LET lo_return = lo_T_DZIV_T

  RETURN lb_return,lo_return

END FUNCTION

FUNCTION sadzp310_imp_set_dziv_t_data(p_T_DZIV_T)
DEFINE
  p_T_DZIV_T  DYNAMIC ARRAY OF T_DZIV_T
DEFINE
  lo_T_DZIV_T  DYNAMIC ARRAY OF T_DZIV_T,
  li_loop      INTEGER,
  ls_InsertSQL STRING,
  ls_UpdateSQL STRING,
  ls_user      VARCHAR(100),
  ldt_datetime DATETIME YEAR TO SECOND,
  lb_result    BOOLEAN
DEFINE
  lb_return BOOLEAN 
  
  LET lo_T_DZIV_T = p_T_DZIV_T

  LET lb_return = TRUE
  LET lb_result = TRUE

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USER")
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif
  
  FOR li_loop = 1 TO lo_T_DZIV_T.getLength()

    LET ls_InsertSQL = "INSERT INTO DZIV_T (                                          ", 
                       "                     DZIV001,DZIV002,DZIV003,DZIV004,DZIV005,DZIV006, ",
                       "                     DZIVCRTID,DZIVCRTDT,DZIVMODID,DZIVMODDT  ",
                       "                   ) VALUES                                   ",
                       "                   (                                          ",
                       "                     ?,?,?,?,?,?,                             ",
                       "                     ?,?,?,?                                  ", 
                       "                   )                                          "

    LET ls_UpdateSQL = " UPDATE DZIV_T         ",
                       "    SET DZIV004   = ?, ",
                       "        DZIV005   = ?, ",
                       "        DZIV006   = ?, ",
                       "        DZIVMODID = ?, ",
                       "        DZIVMODDT = ?  ", 
                       "  WHERE DZIV001 = ?    ",
                       "    AND DZIV002 = ?    ",
                       "    AND DZIV003 = ?    "

    TRY
      PREPARE lpre_set_insert_dziv_t_data FROM ls_InsertSQL
      EXECUTE lpre_set_insert_dziv_t_data USING lo_T_DZIV_T[li_loop].DZIV001,
                                                lo_T_DZIV_T[li_loop].DZIV002,
                                                lo_T_DZIV_T[li_loop].DZIV003,
                                                lo_T_DZIV_T[li_loop].DZIV004,
                                                lo_T_DZIV_T[li_loop].DZIV005,
                                                lo_T_DZIV_T[li_loop].DZIV006,
                                                ----------------------------
                                                ls_user,
                                                ldt_datetime,
                                                ls_user,
                                                ldt_datetime
                                                ----------------------------
    CATCH
      TRY
        PREPARE lpre_set_update_dziv_t_data FROM ls_UpdateSQL
        EXECUTE lpre_set_update_dziv_t_data USING lo_T_DZIV_T[li_loop].DZIV004,
                                                  lo_T_DZIV_T[li_loop].DZIV005,
                                                  lo_T_DZIV_T[li_loop].DZIV006,
                                                  ----------------------------
                                                  ls_user,
                                                  ldt_datetime,
                                                  ----------------------------
                                                  lo_T_DZIV_T[li_loop].DZIV001,
                                                  lo_T_DZIV_T[li_loop].DZIV002,
                                                  lo_T_DZIV_T[li_loop].DZIV003
                                                  
      CATCH 
        DISPLAY cs_error_tag,"INSERT/UPDATE DZIV_T FAULT !! ",ls_InsertSQL
        LET lb_result = FALSE
      END TRY
    END TRY  
                       
  END FOR

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION 
#DZIV_T 相關 Funtion End

#DZIVL_T 相關 Funtion Start
FUNCTION sadzp310_imp_get_dzivl_t_data(p_EXP_HEADER)
DEFINE
  p_EXP_HEADER  T_EXP_HEADER
DEFINE
  lo_EXP_HEADER  T_EXP_HEADER,
  ls_file_name   STRING,
  lb_result      BOOLEAN,
  ls_result      STRING,
  lo_json_arr    util.JSONArray,
  lo_json_obj    util.JSONObject,
  lo_IMP_HEADER  T_EXP_HEADER,
  lo_T_DZIVL_T   DYNAMIC ARRAY OF T_DZIVL_T,
  li_loop        INTEGER
DEFINE 
  lb_return BOOLEAN,
  lo_return DYNAMIC ARRAY OF T_DZIVL_T

  LET lo_EXP_HEADER.* = p_EXP_HEADER.*

  LET lo_json_arr = util.JSONArray.create()
  LET lb_return = TRUE
  
  LET ls_file_name = lo_EXP_HEADER.eh_EXP_NAME 
  CALL sadzp310_util_read_file_contents(ls_file_name) RETURNING lb_result,ls_result

  LET lo_json_arr = util.JSONArray.parse(ls_result)

  FOR li_loop = 1 TO lo_json_arr.getLength()
    IF li_loop = 1 THEN
      #第一筆是Header information
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_IMP_HEADER)
    ELSE
      #其他是被壓縮物件的內容
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_T_DZIVL_T[li_loop - 1])
    END IF
  END FOR

  #內容筆數和Header筆數和驗證檔中的筆數不同, 則判斷為錯誤
  IF (lo_T_DZIVL_T.getLength() <> lo_IMP_HEADER.eh_EXP_RECORDS) OR
     (lo_T_DZIVL_T.getLength() <> lo_EXP_HEADER.eh_EXP_RECORDS) THEN
    LET lb_return = FALSE
    DISPLAY cs_error_tag,cs_msg_header_records_diff
    #DISPLAY lo_T_DZIVL_T.getLength(),",",lo_IMP_HEADER.eh_EXP_RECORDS,",",lo_EXP_HEADER.eh_EXP_RECORDS
  END IF 

  LET lo_return = lo_T_DZIVL_T

  RETURN lb_return,lo_return

END FUNCTION

FUNCTION sadzp310_imp_set_dzivl_t_data(p_T_DZIVL_T)
DEFINE
  p_T_DZIVL_T  DYNAMIC ARRAY OF T_DZIVL_T
DEFINE
  lo_T_DZIVL_T  DYNAMIC ARRAY OF T_DZIVL_T,
  li_loop      INTEGER,
  ls_InsertSQL STRING,
  ls_UpdateSQL STRING,
  lb_result    BOOLEAN
DEFINE
  lb_return BOOLEAN 
  
  LET lo_T_DZIVL_T = p_T_DZIVL_T

  LET lb_return = TRUE
  LET lb_result = TRUE

  FOR li_loop = 1 TO lo_T_DZIVL_T.getLength()

    LET ls_InsertSQL = "INSERT INTO DZIVL_T (                                              ", 
                       "                     DZIVL001,DZIVL002,DZIVL003,DZIVL004,DZIVL005, ",
                       "                     DZIVL006                                      ",
                       "                   ) VALUES                                        ",
                       "                   (                                               ",
                       "                     ?,?,?,?,?,                                    ",
                       "                     ?                                             ", 
                       "                   )                                               "

    LET ls_UpdateSQL = " UPDATE DZIVL_T       ",
                       "    SET DZIVL005 = ?, ",
                       "        DZIVL006 = ?  ",
                       "  WHERE DZIVL001 = ?  ",
                       "    AND DZIVL002 = ?  ",
                       "    AND DZIVL003 = ?  ",
                       "    AND DZIVL004 = ?  "                       

    TRY
      PREPARE lpre_set_insert_dzivl_t_data FROM ls_InsertSQL
      EXECUTE lpre_set_insert_dzivl_t_data USING lo_T_DZIVL_T[li_loop].DZIVL001,
                                                 lo_T_DZIVL_T[li_loop].DZIVL002,
                                                 lo_T_DZIVL_T[li_loop].DZIVL003,
                                                 lo_T_DZIVL_T[li_loop].DZIVL004,
                                                 lo_T_DZIVL_T[li_loop].DZIVL005,
                                                 ----------------------------
                                                 lo_T_DZIVL_T[li_loop].DZIVL006
    CATCH
      TRY
        PREPARE lpre_set_update_dzivl_t_data FROM ls_UpdateSQL
        EXECUTE lpre_set_update_dzivl_t_data USING lo_T_DZIVL_T[li_loop].DZIVL005,
                                                   lo_T_DZIVL_T[li_loop].DZIVL006,
                                                   ----------------------------
                                                   lo_T_DZIVL_T[li_loop].DZIVL001,
                                                   lo_T_DZIVL_T[li_loop].DZIVL002,
                                                   lo_T_DZIVL_T[li_loop].DZIVL003,
                                                   lo_T_DZIVL_T[li_loop].DZIVL004
                                                  
      CATCH 
        DISPLAY cs_error_tag,"INSERT/UPDATE DZIVL_T FAULT !! ",ls_InsertSQL
        LET lb_result = FALSE
      END TRY
    END TRY  
                       
  END FOR

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION 
#DZIVL_T 相關 Funtion End

#### MTable 段
FUNCTION sadzp310_imp_import_mtable_data(p_EXP_LIST)
DEFINE
  p_EXP_LIST  DYNAMIC ARRAY OF T_EXP_HEADER
DEFINE
  lo_EXP_LIST  DYNAMIC ARRAY OF T_EXP_HEADER,
  li_loop      INTEGER,
  lb_result    BOOLEAN,
  lo_T_DZIA_T  DYNAMIC ARRAY OF T_DZIA_T,
  lo_T_DZIB_T  DYNAMIC ARRAY OF T_DZIB_T,
  lo_T_DZIU_T  DYNAMIC ARRAY OF T_DZIU_T
DEFINE
  lb_return BOOLEAN  

  LET lo_EXP_LIST = p_EXP_LIST
  
  LET lb_return = TRUE

  BEGIN WORK
  
  FOR li_loop = 1 TO lo_EXP_LIST.getLength()
    CASE 
      WHEN lo_EXP_LIST[li_loop].eh_EXP_TABLE = 'dzia_t' 
        CALL sadzp310_imp_get_dzia_t_data(lo_EXP_LIST[li_loop].*) RETURNING lb_result,lo_T_DZIA_T
        IF NOT lb_result THEN EXIT CASE END IF
        CALL sadzp310_imp_set_dzia_t_data(lo_T_DZIA_T) RETURNING lb_result
        IF NOT lb_result THEN EXIT CASE END IF
      WHEN lo_EXP_LIST[li_loop].eh_EXP_TABLE = 'dzib_t' 
        CALL sadzp310_imp_get_dzib_t_data(lo_EXP_LIST[li_loop].*) RETURNING lb_result,lo_T_DZIB_T
        IF NOT lb_result THEN EXIT CASE END IF
        CALL sadzp310_imp_set_dzib_t_data(lo_T_DZIB_T) RETURNING lb_result
        IF NOT lb_result THEN EXIT CASE END IF
      WHEN lo_EXP_LIST[li_loop].eh_EXP_TABLE = 'dziu_t' 
        CALL sadzp310_imp_get_dziu_t_data(lo_EXP_LIST[li_loop].*) RETURNING lb_result,lo_T_DZIU_T
        IF NOT lb_result THEN EXIT CASE END IF
        CALL sadzp310_imp_set_dziu_t_data(lo_T_DZIU_T) RETURNING lb_result
        IF NOT lb_result THEN EXIT CASE END IF
    END CASE

    IF NOT lb_result THEN
      EXIT FOR 
    END IF 
    
  END FOR

  IF lb_result THEN 
    COMMIT WORK
  ELSE 
    ROLLBACK WORK
  END IF  
  
  RETURN lb_return
  
END FUNCTION

#DZIA_T 相關 Funtion Start
FUNCTION sadzp310_imp_get_dzia_t_data(p_EXP_HEADER)
DEFINE
  p_EXP_HEADER  T_EXP_HEADER
DEFINE
  lo_EXP_HEADER  T_EXP_HEADER,
  ls_file_name   STRING,
  lb_result      BOOLEAN,
  ls_result      STRING,
  lo_json_arr    util.JSONArray,
  lo_json_obj    util.JSONObject,
  lo_IMP_HEADER  T_EXP_HEADER,
  lo_T_DZIA_T    DYNAMIC ARRAY OF T_DZIA_T,
  li_loop        INTEGER
DEFINE 
  lb_return BOOLEAN,
  lo_return DYNAMIC ARRAY OF T_DZIA_T

  LET lo_EXP_HEADER.* = p_EXP_HEADER.*

  LET lo_json_arr = util.JSONArray.create()
  LET lb_return = TRUE
  
  LET ls_file_name = lo_EXP_HEADER.eh_EXP_NAME 
  CALL sadzp310_util_read_file_contents(ls_file_name) RETURNING lb_result,ls_result

  LET lo_json_arr = util.JSONArray.parse(ls_result)

  FOR li_loop = 1 TO lo_json_arr.getLength()
    IF li_loop = 1 THEN
      #第一筆是Header information
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_IMP_HEADER)
    ELSE
      #其他是被壓縮物件的內容
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_T_DZIA_T[li_loop - 1])
    END IF
  END FOR

  #內容筆數和Header筆數和驗證檔中的筆數不同, 則判斷為錯誤
  IF (lo_T_DZIA_T.getLength() <> lo_IMP_HEADER.eh_EXP_RECORDS) OR
     (lo_T_DZIA_T.getLength() <> lo_EXP_HEADER.eh_EXP_RECORDS) THEN
    LET lb_return = FALSE
    DISPLAY cs_error_tag,cs_msg_header_records_diff
    #DISPLAY lo_T_DZIA_T.getLength(),",",lo_IMP_HEADER.eh_EXP_RECORDS,",",lo_EXP_HEADER.eh_EXP_RECORDS
  END IF 

  LET lo_return = lo_T_DZIA_T

  RETURN lb_return,lo_return

END FUNCTION

FUNCTION sadzp310_imp_set_dzia_t_data(p_T_DZIA_T)
DEFINE
  p_T_DZIA_T  DYNAMIC ARRAY OF T_DZIA_T
DEFINE
  lo_T_DZIA_T  DYNAMIC ARRAY OF T_DZIA_T,
  li_loop      INTEGER,
  ls_InsertSQL STRING,
  ls_UpdateSQL STRING,
  ls_user      VARCHAR(100),
  ldt_datetime DATETIME YEAR TO SECOND,
  lb_result    BOOLEAN
DEFINE
  lb_return BOOLEAN 
  
  LET lo_T_DZIA_T = p_T_DZIA_T

  LET lb_return = TRUE
  LET lb_result = TRUE

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USER")
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif
  
  FOR li_loop = 1 TO lo_T_DZIA_T.getLength()

    LET ls_InsertSQL = "INSERT INTO DZIA_T (                                          ", 
                       "                     DZIA001,DZIA002,DZIA003,DZIA004,DZIA005, ",
                       "                     DZIA006,DZIA007,DZIA008,DZIA009,DZIA010, ",
                       "                     DZIA011,DZIA012,DZIA013,DZIA014,DZIA015, ",
                       "                     DZIA016,DZIA017,DZIA018,DZIA019,DZIA020, ",
                       "                     DZIA021,DZIASTUS,                        ",
                       "                     DZIACRTID,DZIACRTDT,DZIAMODID,DZIAMODDT  ",
                       "                   ) VALUES                                   ",
                       "                   (                                          ",
                       "                     ?,?,?,?,?,                               ",
                       "                     ?,?,?,?,?,                               ",
                       "                     ?,?,?,?,?,                               ",
                       "                     ?,?,?,?,?,                               ",
                       "                     ?,?,                                     ",
                       "                     ?,?,?,?                                  ", 
                       "                   )                                          "

    LET ls_UpdateSQL = " UPDATE DZIA_T         ",
                       "    SET DZIA002   = ?, ",
                       "        DZIA003   = ?, ",
                       "        DZIA004   = ?, ",
                       "        DZIA005   = ?, ",
                       "        DZIA006   = ?, ",
                       "        DZIA007   = ?, ",
                       "        DZIA008   = ?, ",
                       "        DZIA009   = ?, ",
                       "        DZIA010   = ?, ", 
                       "        DZIA011   = ?, ", 
                       "        DZIA012   = ?, ", 
                       "        DZIA013   = ?, ", 
                       "        DZIA014   = ?, ", 
                       #"        DZIA015   = ?, ", 
                       "        DZIA016   = ?, ", 
                       "        DZIA017   = ?, ", 
                       "        DZIA018   = ?, ", 
                       "        DZIA019   = ?, ", 
                       "        DZIA020   = ?, ", 
                       "        DZIA021   = ?, ", 
                       "        DZIASTUS  = ?, ", 
                       "        DZIAMODID = ?, ", 
                       "        DZIAMODDT = ?  ", 
                       "  WHERE DZIA001 = ?    ",
                       "    AND DZIA015 = ?    "

    TRY
      PREPARE lpre_set_insert_dzia_t_data FROM ls_InsertSQL
      EXECUTE lpre_set_insert_dzia_t_data USING lo_T_DZIA_T[li_loop].DZIA001,
                                                lo_T_DZIA_T[li_loop].DZIA002,
                                                lo_T_DZIA_T[li_loop].DZIA003,
                                                lo_T_DZIA_T[li_loop].DZIA004,
                                                lo_T_DZIA_T[li_loop].DZIA005,
                                                ----------------------------
                                                lo_T_DZIA_T[li_loop].DZIA006,
                                                lo_T_DZIA_T[li_loop].DZIA007,
                                                lo_T_DZIA_T[li_loop].DZIA008,
                                                lo_T_DZIA_T[li_loop].DZIA009,
                                                lo_T_DZIA_T[li_loop].DZIA010,
                                                ----------------------------
                                                lo_T_DZIA_T[li_loop].DZIA011,
                                                lo_T_DZIA_T[li_loop].DZIA012,
                                                lo_T_DZIA_T[li_loop].DZIA013,
                                                lo_T_DZIA_T[li_loop].DZIA014,
                                                lo_T_DZIA_T[li_loop].DZIA015,
                                                ----------------------------
                                                lo_T_DZIA_T[li_loop].DZIA016,
                                                lo_T_DZIA_T[li_loop].DZIA017,
                                                lo_T_DZIA_T[li_loop].DZIA018,
                                                lo_T_DZIA_T[li_loop].DZIA019,
                                                lo_T_DZIA_T[li_loop].DZIA020,
                                                ----------------------------
                                                lo_T_DZIA_T[li_loop].DZIA021,
                                                lo_T_DZIA_T[li_loop].DZIASTUS,
                                                ----------------------------
                                                ls_user,
                                                ldt_datetime,
                                                ls_user,
                                                ldt_datetime
                                                ----------------------------
    CATCH
      TRY
        PREPARE lpre_set_update_dzia_t_data FROM ls_UpdateSQL
        EXECUTE lpre_set_update_dzia_t_data USING lo_T_DZIA_T[li_loop].DZIA002,
                                                  lo_T_DZIA_T[li_loop].DZIA003,
                                                  lo_T_DZIA_T[li_loop].DZIA004,
                                                  lo_T_DZIA_T[li_loop].DZIA005,
                                                  ----------------------------
                                                  lo_T_DZIA_T[li_loop].DZIA006,
                                                  lo_T_DZIA_T[li_loop].DZIA007,
                                                  lo_T_DZIA_T[li_loop].DZIA008,
                                                  lo_T_DZIA_T[li_loop].DZIA009,
                                                  lo_T_DZIA_T[li_loop].DZIA010,
                                                  ----------------------------
                                                  lo_T_DZIA_T[li_loop].DZIA011,
                                                  lo_T_DZIA_T[li_loop].DZIA012,
                                                  lo_T_DZIA_T[li_loop].DZIA013,
                                                  lo_T_DZIA_T[li_loop].DZIA014,
                                                  #lo_T_DZIA_T[li_loop].DZIA015,
                                                  ----------------------------
                                                  lo_T_DZIA_T[li_loop].DZIA016,
                                                  lo_T_DZIA_T[li_loop].DZIA017,
                                                  lo_T_DZIA_T[li_loop].DZIA018,
                                                  lo_T_DZIA_T[li_loop].DZIA019,
                                                  lo_T_DZIA_T[li_loop].DZIA020,
                                                  ----------------------------
                                                  lo_T_DZIA_T[li_loop].DZIA021,
                                                  lo_T_DZIA_T[li_loop].DZIASTUS,
                                                  ----------------------------
                                                  ls_user,
                                                  ldt_datetime,
                                                  ----------------------------
                                                  lo_T_DZIA_T[li_loop].DZIA001,
                                                  lo_T_DZIA_T[li_loop].DZIA015
                                                                                                  
      CATCH 
        DISPLAY cs_error_tag,"INSERT/UPDATE DZIA_T FAULT !! ",ls_InsertSQL
        LET lb_result = FALSE
      END TRY
    END TRY  
                       
  END FOR

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION 
#DZIA_T 相關 Funtion End

#DZIB_T 相關 Funtion Start
FUNCTION sadzp310_imp_get_dzib_t_data(p_EXP_HEADER)
DEFINE
  p_EXP_HEADER  T_EXP_HEADER
DEFINE
  lo_EXP_HEADER  T_EXP_HEADER,
  ls_file_name   STRING,
  lb_result      BOOLEAN,
  ls_result      STRING,
  lo_json_arr    util.JSONArray,
  lo_json_obj    util.JSONObject,
  lo_IMP_HEADER  T_EXP_HEADER,
  lo_T_DZIB_T   DYNAMIC ARRAY OF T_DZIB_T,
  li_loop        INTEGER
DEFINE 
  lb_return BOOLEAN,
  lo_return DYNAMIC ARRAY OF T_DZIB_T

  LET lo_EXP_HEADER.* = p_EXP_HEADER.*

  LET lo_json_arr = util.JSONArray.create()
  LET lb_return = TRUE
  
  LET ls_file_name = lo_EXP_HEADER.eh_EXP_NAME 
  CALL sadzp310_util_read_file_contents(ls_file_name) RETURNING lb_result,ls_result

  LET lo_json_arr = util.JSONArray.parse(ls_result)

  FOR li_loop = 1 TO lo_json_arr.getLength()
    IF li_loop = 1 THEN
      #第一筆是Header information
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_IMP_HEADER)
    ELSE
      #其他是被壓縮物件的內容
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_T_DZIB_T[li_loop - 1])
    END IF
  END FOR

  #內容筆數和Header筆數和驗證檔中的筆數不同, 則判斷為錯誤
  IF (lo_T_DZIB_T.getLength() <> lo_IMP_HEADER.eh_EXP_RECORDS) OR
     (lo_T_DZIB_T.getLength() <> lo_EXP_HEADER.eh_EXP_RECORDS) THEN
    LET lb_return = FALSE
    DISPLAY cs_error_tag,cs_msg_header_records_diff
    #DISPLAY lo_T_DZIB_T.getLength(),",",lo_IMP_HEADER.eh_EXP_RECORDS,",",lo_EXP_HEADER.eh_EXP_RECORDS
  END IF 

  LET lo_return = lo_T_DZIB_T

  RETURN lb_return,lo_return

END FUNCTION

FUNCTION sadzp310_imp_set_dzib_t_data(p_T_DZIB_T)
DEFINE
  p_T_DZIB_T  DYNAMIC ARRAY OF T_DZIB_T
DEFINE
  lo_T_DZIB_T  DYNAMIC ARRAY OF T_DZIB_T,
  li_loop      INTEGER,
  ls_user      VARCHAR(100),
  ldt_datetime DATETIME YEAR TO SECOND,
  ls_InsertSQL STRING,
  ls_UpdateSQL STRING,
  lb_result    BOOLEAN
DEFINE
  lb_return BOOLEAN 
  
  LET lo_T_DZIB_T = p_T_DZIB_T

  &ifndef DEBUG
  LET ls_user = g_user
  LET ldt_datetime = cl_get_current()
  &else
  LET ls_user = FGL_GETENV("USER")
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif
  
  LET lb_return = TRUE
  LET lb_result = TRUE

  FOR li_loop = 1 TO lo_T_DZIB_T.getLength()

    LET ls_InsertSQL = "INSERT INTO DZIB_T (                                              ", 
                       "                     DZIB001,DZIB002,DZIB003,DZIB004,DZIB005,     ",
                       "                     DZIB006,DZIB007,DZIB008,DZIB012,DZIB021,     ",
                       "                     DZIB022,DZIB023,DZIB024,DZIB027,DZIB028,     ",
                       "                     DZIB029,DZIB030,DZIB031,DZIBSTUS,            ",
                       "                     DZIBCRTID,DZIBCRTDT,DZIBMODID,DZIBMODDT      ",
                       "                   ) VALUES                                       ",
                       "                   (                                              ",
                       "                     ?,?,?,?,?,                                   ",
                       "                     ?,?,?,?,?,                                   ",
                       "                     ?,?,?,?,?,                                   ",
                       "                     ?,?,?,?,                                     ",
                       "                     ?,?,?,?                                      ",
                       "                   )                                              "

    LET ls_UpdateSQL = " UPDATE DZIB_T         ",
                       "    SET DZIB003   = ?, ",
                       "        DZIB004   = ?, ",
                       "        DZIB005   = ?, ",
                       "        DZIB006   = ?, ",
                       "        DZIB007   = ?, ",
                       "        DZIB008   = ?, ",
                       "        DZIB012   = ?, ",
                       "        DZIB021   = ?, ",
                       "        DZIB022   = ?, ",
                       "        DZIB023   = ?, ",
                       "        DZIB024   = ?, ",
                       "        DZIB027   = ?, ",
                       "        DZIB028   = ?, ",
                       #"        DZIB029   = ?, ",
                       "        DZIB030   = ?, ",
                       "        DZIB031   = ?, ",
                       "        DZIBSTUS  = ?, ",
                       "        DZIBMODID = ?, ",
                       "        DZIBMODDT = ?  ",
                       "  WHERE DZIB001 = ?    ",
                       "    AND DZIB002 = ?    ",
                       "    AND DZIB029 = ?    "

    TRY
      PREPARE lpre_set_insert_dzib_t_data FROM ls_InsertSQL
      EXECUTE lpre_set_insert_dzib_t_data USING lo_T_DZIB_T[li_loop].DZIB001,
                                                lo_T_DZIB_T[li_loop].DZIB002,
                                                lo_T_DZIB_T[li_loop].DZIB003,
                                                lo_T_DZIB_T[li_loop].DZIB004,
                                                lo_T_DZIB_T[li_loop].DZIB005,
                                                ----------------------------
                                                lo_T_DZIB_T[li_loop].DZIB006,
                                                lo_T_DZIB_T[li_loop].DZIB007,
                                                lo_T_DZIB_T[li_loop].DZIB008,
                                                lo_T_DZIB_T[li_loop].DZIB012,
                                                lo_T_DZIB_T[li_loop].DZIB021,
                                                ----------------------------
                                                lo_T_DZIB_T[li_loop].DZIB022,
                                                lo_T_DZIB_T[li_loop].DZIB023,
                                                lo_T_DZIB_T[li_loop].DZIB024,
                                                lo_T_DZIB_T[li_loop].DZIB027,
                                                lo_T_DZIB_T[li_loop].DZIB028,
                                                ----------------------------
                                                lo_T_DZIB_T[li_loop].DZIB029,
                                                lo_T_DZIB_T[li_loop].DZIB030,
                                                lo_T_DZIB_T[li_loop].DZIB031,
                                                lo_T_DZIB_T[li_loop].DZIBSTUS,
                                                ----------------------------
                                                ls_user,
                                                ldt_datetime,
                                                ls_user,
                                                ldt_datetime
                                                ----------------------------
    CATCH
      TRY
        PREPARE lpre_set_update_dzib_t_data FROM ls_UpdateSQL
        EXECUTE lpre_set_update_dzib_t_data USING lo_T_DZIB_T[li_loop].DZIB003,
                                                  lo_T_DZIB_T[li_loop].DZIB004,
                                                  lo_T_DZIB_T[li_loop].DZIB005,
                                                  lo_T_DZIB_T[li_loop].DZIB006,
                                                  lo_T_DZIB_T[li_loop].DZIB007,
                                                  ----------------------------
                                                  lo_T_DZIB_T[li_loop].DZIB008,
                                                  lo_T_DZIB_T[li_loop].DZIB012,
                                                  lo_T_DZIB_T[li_loop].DZIB021,
                                                  lo_T_DZIB_T[li_loop].DZIB022,
                                                  lo_T_DZIB_T[li_loop].DZIB023,
                                                  ----------------------------
                                                  lo_T_DZIB_T[li_loop].DZIB024,
                                                  lo_T_DZIB_T[li_loop].DZIB027,
                                                  lo_T_DZIB_T[li_loop].DZIB028,
                                                  #lo_T_DZIB_T[li_loop].DZIB029,
                                                  lo_T_DZIB_T[li_loop].DZIB030,
                                                  ----------------------------
                                                  lo_T_DZIB_T[li_loop].DZIB031,
                                                  lo_T_DZIB_T[li_loop].DZIBSTUS,
                                                  ----------------------------
                                                  ls_user,
                                                  ldt_datetime,
                                                  ----------------------------
                                                  lo_T_DZIB_T[li_loop].DZIB001,
                                                  lo_T_DZIB_T[li_loop].DZIB002,
                                                  lo_T_DZIB_T[li_loop].DZIB029
                                                  
                                                  
      CATCH 
        DISPLAY cs_error_tag,"INSERT/UPDATE DZIB_T FAULT !! ",ls_InsertSQL
        LET lb_result = FALSE
      END TRY
    END TRY  
                       
  END FOR

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION 
#DZIB_T 相關 Funtion End

#DZIU_T 相關 Funtion Start
FUNCTION sadzp310_imp_get_dziu_t_data(p_EXP_HEADER)
DEFINE
  p_EXP_HEADER  T_EXP_HEADER
DEFINE
  lo_EXP_HEADER  T_EXP_HEADER,
  ls_file_name   STRING,
  lb_result      BOOLEAN,
  ls_result      STRING,
  lo_json_arr    util.JSONArray,
  lo_json_obj    util.JSONObject,
  lo_IMP_HEADER  T_EXP_HEADER,
  lo_T_DZIU_T   DYNAMIC ARRAY OF T_DZIU_T,
  li_loop        INTEGER
DEFINE 
  lb_return BOOLEAN,
  lo_return DYNAMIC ARRAY OF T_DZIU_T

  LET lo_EXP_HEADER.* = p_EXP_HEADER.*

  LET lo_json_arr = util.JSONArray.create()
  LET lb_return = TRUE
  
  LET ls_file_name = lo_EXP_HEADER.eh_EXP_NAME 
  CALL sadzp310_util_read_file_contents(ls_file_name) RETURNING lb_result,ls_result

  LET lo_json_arr = util.JSONArray.parse(ls_result)

  FOR li_loop = 1 TO lo_json_arr.getLength()
    IF li_loop = 1 THEN
      #第一筆是Header information
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_IMP_HEADER)
    ELSE
      #其他是被壓縮物件的內容
      INITIALIZE lo_json_obj TO NULL
      CALL lo_json_arr.get(li_loop) RETURNING lo_json_obj
      CALL lo_json_obj.toFGL(lo_T_DZIU_T[li_loop - 1])
    END IF
  END FOR

  #內容筆數和Header筆數和驗證檔中的筆數不同, 則判斷為錯誤
  IF (lo_T_DZIU_T.getLength() <> lo_IMP_HEADER.eh_EXP_RECORDS) OR
     (lo_T_DZIU_T.getLength() <> lo_EXP_HEADER.eh_EXP_RECORDS) THEN
    LET lb_return = FALSE
    DISPLAY cs_error_tag,cs_msg_header_records_diff
    #DISPLAY lo_T_DZIU_T.getLength(),",",lo_IMP_HEADER.eh_EXP_RECORDS,",",lo_EXP_HEADER.eh_EXP_RECORDS
  END IF 

  LET lo_return = lo_T_DZIU_T

  RETURN lb_return,lo_return

END FUNCTION

FUNCTION sadzp310_imp_set_dziu_t_data(p_T_DZIU_T)
DEFINE
  p_T_DZIU_T  DYNAMIC ARRAY OF T_DZIU_T
DEFINE
  lo_T_DZIU_T  DYNAMIC ARRAY OF T_DZIU_T,
  li_loop      INTEGER,
  ls_InsertSQL STRING,
  ls_UpdateSQL STRING,
  lb_result    BOOLEAN
DEFINE
  lb_return BOOLEAN 
  
  LET lo_T_DZIU_T = p_T_DZIU_T

  LET lb_return = TRUE
  LET lb_result = TRUE

  FOR li_loop = 1 TO lo_T_DZIU_T.getLength()

    LET ls_InsertSQL = "INSERT INTO DZIU_T (                                          ", 
                       "                     DZIU001,DZIU002,DZIU003,DZIU004,DZIU005, ",
                       "                     DZIU006,DZIU007,DZIU008                  ",
                       "                   ) VALUES                                   ",
                       "                   (                                          ",
                       "                     ?,?,?,?,?,                               ",
                       "                     ?,?,?                                    ", 
                       "                   )                                          "

    LET ls_UpdateSQL = " UPDATE DZIU_T       ",
                       "    SET DZIU003 = ?, ",
                       "        DZIU004 = ?, ",
                       "        DZIU006 = ?, ",
                       "        DZIU007 = ?, ",
                       "        DZIU008 = ?  ",
                       "  WHERE DZIU001 = ?  ",
                       "    AND DZIU002 = ?  ",
                       "    AND DZIU005 = ?  "

    TRY
      PREPARE lpre_set_insert_dziu_t_data FROM ls_InsertSQL
      EXECUTE lpre_set_insert_dziu_t_data USING lo_T_DZIU_T[li_loop].DZIU001,
                                                lo_T_DZIU_T[li_loop].DZIU002,
                                                lo_T_DZIU_T[li_loop].DZIU003,
                                                lo_T_DZIU_T[li_loop].DZIU004,
                                                lo_T_DZIU_T[li_loop].DZIU005,
                                                ----------------------------
                                                lo_T_DZIU_T[li_loop].DZIU006,
                                                lo_T_DZIU_T[li_loop].DZIU007,
                                                lo_T_DZIU_T[li_loop].DZIU008
    CATCH
      TRY
        PREPARE lpre_set_update_dziu_t_data FROM ls_UpdateSQL
        EXECUTE lpre_set_update_dziu_t_data USING lo_T_DZIU_T[li_loop].DZIU003,
                                                  lo_T_DZIU_T[li_loop].DZIU004,
                                                  lo_T_DZIU_T[li_loop].DZIU006,
                                                  lo_T_DZIU_T[li_loop].DZIU007,
                                                  lo_T_DZIU_T[li_loop].DZIU008,
                                                  ----------------------------
                                                  lo_T_DZIU_T[li_loop].DZIU001,
                                                  lo_T_DZIU_T[li_loop].DZIU002,
                                                  lo_T_DZIU_T[li_loop].DZIU005
                                                  
      CATCH 
        DISPLAY cs_error_tag,"INSERT/UPDATE DZIU_T FAULT !! ",ls_InsertSQL
        LET lb_result = FALSE
      END TRY
    END TRY  
                       
  END FOR

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION 
#DZIU_T 相關 Funtion End

####### Common utility
FUNCTION sadzp310_imp_moving_files(p_uncompress_path,p_working_path,p_EXP_LIST)
DEFINE
  p_uncompress_path  STRING,
  p_working_path     STRING,
  p_EXP_LIST         DYNAMIC ARRAY OF T_EXP_HEADER
DEFINE
  ls_uncompress_path  STRING,
  ls_working_path     STRING,
  lo_EXP_LIST         DYNAMIC ARRAY OF T_EXP_HEADER,
  li_loop             INTEGER,
  ls_os_separator     STRING,
  ls_path_from        STRING,
  ls_path_to          STRING,
  ls_file_name        STRING,
  lb_result           BOOLEAN
DEFINE
  lb_return  BOOLEAN  

  LET ls_uncompress_path = p_uncompress_path
  LET ls_working_path    = p_working_path
  LET lo_EXP_LIST        = p_EXP_LIST

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator

  LET lb_return = TRUE
  LET lb_result = TRUE

  {  
  #先複製EXPORT_NOTICE.vfy到工作目錄
  LET ls_file_name = cs_verify_file_export_notice,".",cs_export_verify_ext
  LET ls_path_from = ls_uncompress_path,ls_os_separator,ls_file_name
  LET ls_path_to   = ls_working_path,ls_os_separator,ls_file_name
  DISPLAY cs_information_tag,"Copy file '",ls_file_name,"' from ",ls_uncompress_path," to ",ls_working_path,"."
  CALL os.Path.copy(ls_path_from,ls_path_to) RETURNING lb_result
  }
  
  IF lb_result THEN    
    #再複製其他json檔案到工作目錄
    FOR li_loop = 1 TO lo_EXP_LIST.getLength()
      LET ls_file_name = lo_EXP_LIST[li_loop].eh_EXP_NAME
      LET ls_path_from = ls_uncompress_path,ls_os_separator,ls_file_name
      LET ls_path_to   = ls_working_path,ls_os_separator,ls_file_name
      DISPLAY cs_information_tag,"Copy file '",ls_file_name,"' from ",ls_uncompress_path," to ",ls_working_path,"."
      CALL os.Path.copy(ls_path_from,ls_path_to) RETURNING lb_result
      IF NOT lb_result THEN
        LET lb_return = lb_result
        EXIT FOR
      END IF   
    END FOR
  ELSE   
    LET lb_return = lb_result
  END IF  

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp310_imp_parse_client_full_name(p_full_name,p_export_info)
DEFINE
  p_full_name    STRING, 
  p_export_info  T_EXPORT_INFO
DEFINE
  ls_full_name    STRING, 
  lo_export_info  T_EXPORT_INFO,
  ls_client_path  STRING,
  ls_client_name  STRING 
DEFINE
  lo_return T_EXPORT_INFO

  LET ls_full_name     = p_full_name
  LET lo_export_info.* = p_export_info.*

  CALL os.Path.dirname(ls_full_name) RETURNING ls_client_path
  CALL os.Path.basename(ls_full_name) RETURNING ls_client_name

  LET lo_export_info.TAR_NAME    = ls_client_name
  LET lo_export_info.CLIENT_PATH = ls_client_path

  LET lo_return.* = lo_export_info.*

  RETURN lo_return.*
  
END FUNCTION 

FUNCTION sadzp310_imp_get_server_working_path(p_object_name)
DEFINE
  p_object_name STRING
DEFINE 
  ls_object_name STRING,
  lb_result      STRING,
  ls_work_path   STRING   
DEFINE 
  lb_return BOOLEAN,
  ls_return STRING   

  LET ls_object_name = p_object_name

  CALL sadzp310_util_making_work_directory(cs_working_unknow_object,cs_working_dir_type_import,ls_object_name) RETURNING lb_result,ls_work_path 

  LET lb_return = lb_result
  LET ls_return = ls_work_path

  RETURN lb_return,ls_return
  
END FUNCTION 

FUNCTION sadzp310_imp_set_upload_parameter(p_param1,p_param2,p_param3,p_param4)
DEFINE 
  p_param1,p_param2,p_param3,p_param4 STRING 
DEFINE
  lo_parameter T_PUT_GET_FILE_PARA
DEFINE
  lo_return  T_PUT_GET_FILE_PARA

  #Source
  LET lo_parameter.CLIENT_FILE_PATH = p_param1   
  LET lo_parameter.CLIENT_FILE_NAME = p_param2   
  #Destination  
  LET lo_parameter.SERVER_FILE_PATH = p_param3   
  LET lo_parameter.SERVER_FILE_NAME = p_param4   

  LET lo_return.* = lo_parameter.*

  RETURN lo_return.*  

END FUNCTION 

FUNCTION sadzp310_imp_catch_to_server(mo_parameter)
DEFINE
  mo_parameter T_PUT_GET_FILE_PARA
DEFINE
  lo_parameter    T_PUT_GET_FILE_PARA,
  ls_source       STRING,
  ls_destination  STRING,
  ls_os_separator STRING  
DEFINE
  lb_return BOOLEAN  

  LET lo_parameter.* = mo_parameter.*
  LET lb_return = TRUE

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator 

  LET ls_source      = lo_parameter.CLIENT_FILE_PATH,ls_os_separator,lo_parameter.CLIENT_FILE_NAME
  LET ls_destination = lo_parameter.SERVER_FILE_PATH,ls_os_separator,lo_parameter.SERVER_FILE_NAME

  TRY 
    CALL FGL_GETFILE(ls_source,ls_destination)
  CATCH
    LET lb_return = FALSE
  END TRY

  RETURN lb_return 
  
END FUNCTION 

