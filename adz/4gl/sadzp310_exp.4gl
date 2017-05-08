
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
  mo_arguments    T_ARGUMENTS,
  mb_backend_mode BOOLEAN,
  mb_result       BOOLEAN,
  ms_result       STRING,
  mo_EXP_LIST     DYNAMIC ARRAY OF T_EXP_HEADER

FUNCTION sadzp310_exp_run(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode  BOOLEAN,
  p_arguments     T_ARGUMENTS
  
  CALL sadzp310_exp_initialize(p_backend_mode,p_arguments.*)
  CALL sadzp310_exp_start()
  CALL sadzp310_exp_finalize()

  RETURN mb_result,mo_EXP_LIST

END FUNCTION 

FUNCTION sadzp310_exp_initialize(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ARGUMENTS
  
  LET mb_backend_mode = p_backend_mode
  LET mo_arguments.*  = p_arguments.*
  
END FUNCTION 

FUNCTION sadzp310_exp_start()
DEFINE
  ls_curr_working_dir STRING,
  lb_result       BOOLEAN,
  lb_chdir        BOOLEAN,
  ls_work_path    STRING,
  ls_os_separator STRING,
  lo_EXP_LIST   DYNAMIC ARRAY OF T_EXP_HEADER

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  #取得目前工作目錄
  CALL os.Path.pwd() RETURNING ls_curr_working_dir

  #依照建構型態指定物件型態
  CASE 
    #Trigger
    WHEN mo_arguments.a_CONSTRUCT_TYPE = cs_mdm_construct_type_trigger
      LET mo_arguments.a_OBJECT_TYPE = cs_working_type_trigger
    #View  
    WHEN mo_arguments.a_CONSTRUCT_TYPE = cs_mdm_construct_type_view
      LET mo_arguments.a_OBJECT_TYPE = cs_working_type_view
    #MTable  
    WHEN mo_arguments.a_CONSTRUCT_TYPE = cs_mdm_construct_type_table
      LET mo_arguments.a_OBJECT_TYPE = cs_working_type_mtable
  END CASE
  
  #取得及切換工作目錄
  CALL sadzp310_util_making_work_directory(mo_arguments.a_OBJECT_TYPE, 
                                           cs_working_dir_type_export, 
                                           mo_arguments.a_WORKING_OBJECT) RETURNING lb_result,ls_work_path 
  LET mo_arguments.a_WORKING_PATH      = ls_work_path
  LET mo_arguments.a_WORKING_FULL_NAME = ls_work_path,ls_os_separator,mo_arguments.a_WORKING_FILE

  #切換目錄成功了, 才開始作業
  IF lb_result THEN   
    CASE 
      #Trigger
      WHEN mo_arguments.a_CONSTRUCT_TYPE = cs_mdm_construct_type_trigger 
        CALL sadzp310_exp_export_trigger_data(mo_arguments.*) RETURNING lo_EXP_LIST
      #View
      WHEN mo_arguments.a_CONSTRUCT_TYPE = cs_mdm_construct_type_view 
        CALL sadzp310_exp_export_view_data(mo_arguments.*) RETURNING lo_EXP_LIST
      #MTable
      WHEN mo_arguments.a_CONSTRUCT_TYPE = cs_mdm_construct_type_table 
        CALL sadzp310_exp_export_mtable_data(mo_arguments.*) RETURNING lo_EXP_LIST
    END CASE
  END IF  

  #切回原目錄
  CALL os.Path.chdir(ls_curr_working_dir) RETURNING lb_chdir    

  #設定回傳值
  LET mo_EXP_LIST = lo_EXP_LIST
  LET mb_result = lb_result
  
END FUNCTION 

FUNCTION sadzp310_exp_finalize()
END FUNCTION 

## Trigger ##
# @desc. 觸發器設計資料打包
# @input_para.  p_arguments  打包資料訊息
# @return_para. lo_return  打包檔(list)
FUNCTION sadzp310_exp_export_trigger_data(p_arguments)
DEFINE
  p_arguments  T_ARGUMENTS
DEFINE
  lo_arguments   T_ARGUMENTS,
  lo_exp_header  T_EXP_HEADER,
  lo_T_DZIT_T    DYNAMIC ARRAY OF T_DZIT_T,
  lo_T_DZITL_T   DYNAMIC ARRAY OF T_DZITL_T,
  lo_EXP_LIST    DYNAMIC ARRAY OF T_EXP_HEADER,
  ls_JSON_string STRING,
  ls_exp_table   STRING,
  lb_result      BOOLEAN
DEFINE
  lo_return  DYNAMIC ARRAY OF T_EXP_HEADER
  
  LET lo_arguments.* = p_arguments.*

  #dzit_t  
  LET ls_exp_table = "dzit_t"
  INITIALIZE lo_exp_header TO NULL
  CALL sadzp310_exp_get_dzit_t_data(lo_arguments.a_WORKING_OBJECT) RETURNING lo_T_DZIT_T
  CALL sadzp310_exp_get_table_header(ls_exp_table,lo_T_DZIT_T.getLength(),lo_arguments.*) RETURNING lo_exp_header.*
  CALL sadzp310_exp_prepare_dzit_t_json_data(lo_exp_header.*, lo_T_DZIT_T) RETURNING ls_JSON_string
  CALL sadzp310_util_write_file(lo_exp_header.eh_EXP_FULL_NAME,ls_JSON_string) RETURNING lb_result
  CALL sadzp310_exp_set_export_list(lo_exp_header.*,lo_EXP_LIST) RETURNING lo_EXP_LIST
  
  #dzitl_t  
  LET ls_exp_table = "dzitl_t"
  INITIALIZE lo_exp_header TO NULL
  CALL sadzp310_exp_get_dzitl_t_data(lo_arguments.a_WORKING_OBJECT) RETURNING lo_T_DZITL_T
  CALL sadzp310_exp_get_table_header(ls_exp_table,lo_T_DZITL_T.getLength(),lo_arguments.*) RETURNING lo_exp_header.*
  CALL sadzp310_exp_prepare_dzitl_t_json_data(lo_exp_header.*, lo_T_DZITL_T) RETURNING ls_JSON_string
  CALL sadzp310_util_write_file(lo_exp_header.eh_EXP_FULL_NAME,ls_JSON_string) RETURNING lb_result
  CALL sadzp310_exp_set_export_list(lo_exp_header.*,lo_EXP_LIST) RETURNING lo_EXP_LIST

  LET lo_return = lo_EXP_LIST

  RETURN lo_return
  
END FUNCTION

## DZIT_T 相關 Funtion Start
# @desc.  取得Trigger設計資料
# @memo:  get trigger design data from dzit_t table
# @input_para.  p_object_name  觸發器ID
# @return_para. lo_return  trigger 設計資料 
# @modify 170210-00052#1 at 2017/02/15 by circlelai 新增dzit011
FUNCTION sadzp310_exp_get_dzit_t_data(p_object_name)
DEFINE
  p_object_name  STRING
DEFINE
  ls_object_name STRING,
  ls_SQL         STRING,
  li_rec_count   INTEGER,
  lo_T_DZIT_T    DYNAMIC ARRAY OF T_DZIT_T
DEFINE
  lo_return  DYNAMIC ARRAY OF T_DZIT_T

  INITIALIZE lo_T_DZIT_T TO NULL
  LET ls_object_name = p_object_name.toLowerCase()
  
  LET ls_sql = "" 
        , "SELECT IT.DZIT001, IT.DZIT002, IT.DZIT003, IT.DZIT004, IT.DZIT005, " , "\n"
        , "       IT.DZIT006, IT.DZIT007, IT.DZIT008, IT.DZIT009, IT.DZIT010, IT.DZIT011 " , "\n"
        , "  FROM dzit_t IT " , "\n"
        , " WHERE 1=1 " , "\n"
        , "   AND IT.DZIT002 = '",ls_object_name,"' " , "\n"
        , " ORDER BY IT.DZIT004,IT.DZIT001,IT.DZIT003 " , "\n"
  
  PREPARE lpre_get_dzit_t_data FROM ls_sql
  DECLARE lcur_get_dzit_t_data CURSOR FOR lpre_get_dzit_t_data

  LET li_rec_count = 1
  LOCATE lo_T_DZIT_T[li_rec_count].DZIT008 IN FILE
  LOCATE lo_T_DZIT_T[li_rec_count].DZIT011 IN FILE

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

# @desc. 觸發器設計資料轉成'json String'
# @memo  Record-data parse to JSon-array
# @input_para.  p_exp_header  匯出檔檔頭
# @input_para.  p_T_DZIT_T    觸發器設計資料
# @return_para. ls_return     json String
# @modify 170210-00052#1 at 2017/02/15 by circlelai 新增dzit011
FUNCTION sadzp310_exp_prepare_dzit_t_json_data(p_exp_header,p_T_DZIT_T)
DEFINE
  p_exp_header  T_EXP_HEADER,
  p_T_DZIT_T    DYNAMIC ARRAY OF T_DZIT_T
DEFINE
  lo_exp_header    T_EXP_HEADER,
  lo_T_DZIT_T      DYNAMIC ARRAY OF T_DZIT_T,
  lo_T_DZIT_T_JSON DYNAMIC ARRAY OF T_DZIT_T_JSON,
  lo_json_obj      util.JSONArray,
  li_loop          INTEGER
DEFINE
  ls_return STRING 

  LET lo_exp_header.* = p_exp_header.*
  LET lo_T_DZIT_T = p_T_DZIT_T
  
  LET lo_json_obj = util.JSONArray.create()

  #先放Header
  CALL lo_json_obj.put(1,lo_exp_header)

  FOR li_loop = 1 TO lo_T_DZIT_T.getLength()

    LET lo_T_DZIT_T_JSON[li_loop].DZIT001 = lo_T_DZIT_T[li_loop].DZIT001
    LET lo_T_DZIT_T_JSON[li_loop].DZIT002 = lo_T_DZIT_T[li_loop].DZIT002
    LET lo_T_DZIT_T_JSON[li_loop].DZIT003 = lo_T_DZIT_T[li_loop].DZIT003
    LET lo_T_DZIT_T_JSON[li_loop].DZIT004 = lo_T_DZIT_T[li_loop].DZIT004
    LET lo_T_DZIT_T_JSON[li_loop].DZIT005 = lo_T_DZIT_T[li_loop].DZIT005
    LET lo_T_DZIT_T_JSON[li_loop].DZIT006 = lo_T_DZIT_T[li_loop].DZIT006
    LET lo_T_DZIT_T_JSON[li_loop].DZIT007 = lo_T_DZIT_T[li_loop].DZIT007
    LET lo_T_DZIT_T_JSON[li_loop].DZIT008 = lo_T_DZIT_T[li_loop].DZIT008
    LET lo_T_DZIT_T_JSON[li_loop].DZIT009 = lo_T_DZIT_T[li_loop].DZIT009
    LET lo_T_DZIT_T_JSON[li_loop].DZIT010 = lo_T_DZIT_T[li_loop].DZIT010
    LET lo_T_DZIT_T_JSON[li_loop].DZIT011 = lo_T_DZIT_T[li_loop].DZIT011  # 170210-00052#1 add by circlelai

    #由於已經先放Header, 所以loop都要往後加一
    CALL lo_json_obj.put(li_loop + 1,lo_T_DZIT_T_JSON[li_loop])
    
  END FOR

  #排版一下JSON格式文件
  LET ls_return = util.JSON.format(lo_json_obj.toString())

  RETURN ls_return
  
END FUNCTION
## DZIT_T 相關 Funtion End

## DZITL_T 相關 Funtion Start
FUNCTION sadzp310_exp_get_dzitl_t_data(p_object_name)
DEFINE
  p_object_name STRING
DEFINE
  ls_object_name STRING,
  ls_SQL         STRING,
  li_rec_count   INTEGER,
  lo_T_DZITL_T   DYNAMIC ARRAY OF T_DZITL_T
DEFINE
  lo_return  DYNAMIC ARRAY OF T_DZITL_T

  LET ls_object_name = p_object_name.toLowerCase()

  LET ls_sql = "SELECT ITL.DZITL001,ITL.DZITL002,ITL.DZITL003,ITL.DZITL004,ITL.DZITL005, ",
               "       ITL.DZITL006,ITL.DZITL007                                         ",
               "  FROM DZITL_T ITL                                                       ",
               " WHERE 1=1                                                               ",
               "   AND ITL.DZITL002 = '",ls_object_name,"'                               ", 
               " ORDER BY ITL.DZITL004,ITL.DZITL001,ITL.DZITL003                         "

  INITIALIZE lo_T_DZITL_T TO NULL
  
  PREPARE lpre_get_dzitl_t_data FROM ls_sql
  DECLARE lcur_get_dzitl_t_data CURSOR FOR lpre_get_dzitl_t_data

  LET li_rec_count = 1

  OPEN lcur_get_dzitl_t_data
  FOREACH lcur_get_dzitl_t_data INTO lo_T_DZITL_T[li_rec_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

  END FOREACH
  CALL lo_T_DZITL_T.deleteElement(li_rec_count)
  
  CLOSE lpre_get_dzitl_t_data
  CLOSE lcur_get_dzitl_t_data

  LET lo_return = lo_T_DZITL_T

  RETURN lo_return

END FUNCTION

FUNCTION sadzp310_exp_prepare_dzitl_t_json_data(p_exp_header,p_T_DZITL_T)
DEFINE
  p_exp_header  T_EXP_HEADER,
  p_T_DZITL_T   DYNAMIC ARRAY OF T_DZITL_T
DEFINE
  lo_exp_header     T_EXP_HEADER,
  lo_T_DZITL_T      DYNAMIC ARRAY OF T_DZITL_T,
  lo_T_DZITL_T_JSON DYNAMIC ARRAY OF T_DZITL_T_JSON,
  lo_json_obj       util.JSONArray,
  li_loop           INTEGER
DEFINE
  ls_return STRING 

  LET lo_exp_header.* = p_exp_header.*
  LET lo_T_DZITL_T = p_T_DZITL_T
  
  LET lo_json_obj = util.JSONArray.create()

  #先放Header
  CALL lo_json_obj.put(1,lo_exp_header)

  FOR li_loop = 1 TO lo_T_DZITL_T.getLength()

    LET lo_T_DZITL_T_JSON[li_loop].DZITL001 = lo_T_DZITL_T[li_loop].DZITL001
    LET lo_T_DZITL_T_JSON[li_loop].DZITL002 = lo_T_DZITL_T[li_loop].DZITL002
    LET lo_T_DZITL_T_JSON[li_loop].DZITL003 = lo_T_DZITL_T[li_loop].DZITL003
    LET lo_T_DZITL_T_JSON[li_loop].DZITL004 = lo_T_DZITL_T[li_loop].DZITL004
    LET lo_T_DZITL_T_JSON[li_loop].DZITL005 = lo_T_DZITL_T[li_loop].DZITL005
    LET lo_T_DZITL_T_JSON[li_loop].DZITL006 = lo_T_DZITL_T[li_loop].DZITL006
    LET lo_T_DZITL_T_JSON[li_loop].DZITL007 = lo_T_DZITL_T[li_loop].DZITL007

    #由於已經先放Header, 所以loop都要往後加一
    CALL lo_json_obj.put(li_loop + 1,lo_T_DZITL_T_JSON[li_loop])
    
  END FOR

  #排版一下JSON格式文件
  LET ls_return = util.JSON.format(lo_json_obj.toString())

  RETURN ls_return
  
END FUNCTION
## DZITL_T 相關 Funtion End

## View ##
FUNCTION sadzp310_exp_export_view_data(p_arguments)
DEFINE
  p_arguments  T_ARGUMENTS
DEFINE
  lo_arguments   T_ARGUMENTS,
  lo_exp_header  T_EXP_HEADER,
  lo_T_DZIV_T    DYNAMIC ARRAY OF T_DZIV_T,
  lo_T_DZIVL_T   DYNAMIC ARRAY OF T_DZIVL_T,
  lo_EXP_LIST    DYNAMIC ARRAY OF T_EXP_HEADER,
  ls_JSON_string STRING,
  ls_exp_table   STRING,
  lb_result      BOOLEAN
DEFINE
  lo_return  DYNAMIC ARRAY OF T_EXP_HEADER
  
  LET lo_arguments.* = p_arguments.*

  #dziv_t  
  LET ls_exp_table = "dziv_t"
  INITIALIZE lo_exp_header TO NULL
  CALL sadzp310_exp_get_dziv_t_data(lo_arguments.a_WORKING_OBJECT) RETURNING lo_T_DZIV_T
  CALL sadzp310_exp_get_table_header(ls_exp_table,lo_T_DZIV_T.getLength(),lo_arguments.*) RETURNING lo_exp_header.*
  CALL sadzp310_exp_prepare_dziv_t_json_data(lo_exp_header.*, lo_T_DZIV_T) RETURNING ls_JSON_string
  CALL sadzp310_util_write_file(lo_exp_header.eh_EXP_FULL_NAME,ls_JSON_string) RETURNING lb_result
  CALL sadzp310_exp_set_export_list(lo_exp_header.*,lo_EXP_LIST) RETURNING lo_EXP_LIST
  
  #dzivl_t  
  LET ls_exp_table = "dzivl_t"
  INITIALIZE lo_exp_header TO NULL
  CALL sadzp310_exp_get_dzivl_t_data(lo_arguments.a_WORKING_OBJECT) RETURNING lo_T_DZIVL_T
  CALL sadzp310_exp_get_table_header(ls_exp_table,lo_T_DZIVL_T.getLength(),lo_arguments.*) RETURNING lo_exp_header.*
  CALL sadzp310_exp_prepare_dzivl_t_json_data(lo_exp_header.*, lo_T_DZIVL_T) RETURNING ls_JSON_string
  CALL sadzp310_util_write_file(lo_exp_header.eh_EXP_FULL_NAME,ls_JSON_string) RETURNING lb_result
  CALL sadzp310_exp_set_export_list(lo_exp_header.*,lo_EXP_LIST) RETURNING lo_EXP_LIST

  LET lo_return = lo_EXP_LIST

  RETURN lo_return
  
END FUNCTION

## DZIV_T 相關 Funtion Start
FUNCTION sadzp310_exp_get_dziv_t_data(p_object_name)
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

  LET ls_sql = "SELECT IV.DZIV001,IV.DZIV002,IV.DZIV003, ",
               "       IV.DZIV004,IV.DZIV005,IV.DZIV006  ",
               "  FROM DZIV_T IV                         ",
               " WHERE 1=1                               ",
               "   AND IV.DZIV001 = '",ls_object_name,"' ", 
               " ORDER BY IV.DZIV002,IV.DZIV001          "

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

FUNCTION sadzp310_exp_prepare_dziv_t_json_data(p_exp_header,p_T_DZIV_T)
DEFINE
  p_exp_header  T_EXP_HEADER,
  p_T_DZIV_T    DYNAMIC ARRAY OF T_DZIV_T
DEFINE
  lo_exp_header    T_EXP_HEADER,
  lo_T_DZIV_T      DYNAMIC ARRAY OF T_DZIV_T,
  lo_T_DZIV_T_JSON DYNAMIC ARRAY OF T_DZIV_T_JSON,
  lo_json_obj      util.JSONArray,
  li_loop          INTEGER
DEFINE
  ls_return STRING 

  LET lo_exp_header.* = p_exp_header.*
  LET lo_T_DZIV_T = p_T_DZIV_T
  
  LET lo_json_obj = util.JSONArray.create()

  #先放Header
  CALL lo_json_obj.put(1,lo_exp_header)

  FOR li_loop = 1 TO lo_T_DZIV_T.getLength()

    LET lo_T_DZIV_T_JSON[li_loop].DZIV001 = lo_T_DZIV_T[li_loop].DZIV001
    LET lo_T_DZIV_T_JSON[li_loop].DZIV002 = lo_T_DZIV_T[li_loop].DZIV002
    LET lo_T_DZIV_T_JSON[li_loop].DZIV003 = lo_T_DZIV_T[li_loop].DZIV003
    LET lo_T_DZIV_T_JSON[li_loop].DZIV004 = lo_T_DZIV_T[li_loop].DZIV004
    LET lo_T_DZIV_T_JSON[li_loop].DZIV005 = lo_T_DZIV_T[li_loop].DZIV005
    LET lo_T_DZIV_T_JSON[li_loop].DZIV006 = lo_T_DZIV_T[li_loop].DZIV006 #出貨旗標 add at 20160330 by CircleLai

    #由於已經先放Header, 所以loop都要往後加一
    CALL lo_json_obj.put(li_loop + 1,lo_T_DZIV_T_JSON[li_loop])
    
  END FOR

  #排版一下JSON格式文件
  LET ls_return = util.JSON.format(lo_json_obj.toString())

  RETURN ls_return
  
END FUNCTION
## DZIV_T 相關 Funtion End

## DZIVL_T 相關 Funtion Start
FUNCTION sadzp310_exp_get_dzivl_t_data(p_object_name)
DEFINE
  p_object_name STRING
DEFINE
  ls_object_name STRING,
  ls_SQL         STRING,
  li_rec_count   INTEGER,
  lo_T_DZIVL_T   DYNAMIC ARRAY OF T_DZIVL_T 
DEFINE
  lo_return  DYNAMIC ARRAY OF T_DZIVL_T

  LET ls_object_name = p_object_name.toLowerCase()

  LET ls_sql = "SELECT IVL.DZIVL001,IVL.DZIVL002,IVL.DZIVL003,IVL.DZIVL004,IVL.DZIVL005, ",
               "       IVL.DZIVL006                                                      ",
               "  FROM DZIVL_T IVL                                                       ",
               " WHERE 1=1                                                               ",
               "   AND IVL.DZIVL001 = '",ls_object_name,"'                               ", 
               " ORDER BY IVL.DZIVL002,IVL.DZIVL001                                      "

  INITIALIZE lo_T_DZIVL_T TO NULL
  
  PREPARE lpre_get_dzivl_t_data FROM ls_sql
  DECLARE lcur_get_dzivl_t_data CURSOR FOR lpre_get_dzivl_t_data

  LET li_rec_count = 1

  OPEN lcur_get_dzivl_t_data
  FOREACH lcur_get_dzivl_t_data INTO lo_T_DZIVL_T[li_rec_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

  END FOREACH
  CALL lo_T_DZIVL_T.deleteElement(li_rec_count)
  
  CLOSE lpre_get_dzivl_t_data
  CLOSE lcur_get_dzivl_t_data

  LET lo_return = lo_T_DZIVL_T

  RETURN lo_return

END FUNCTION

FUNCTION sadzp310_exp_prepare_dzivl_t_json_data(p_exp_header,p_T_DZIVL_T)
DEFINE
  p_exp_header  T_EXP_HEADER,
  p_T_DZIVL_T   DYNAMIC ARRAY OF T_DZIVL_T
DEFINE
  lo_exp_header     T_EXP_HEADER,
  lo_T_DZIVL_T      DYNAMIC ARRAY OF T_DZIVL_T,
  lo_T_DZIVL_T_JSON DYNAMIC ARRAY OF T_DZIVL_T_JSON,
  lo_json_obj       util.JSONArray,
  li_loop           INTEGER
DEFINE
  ls_return STRING 

  LET lo_exp_header.* = p_exp_header.*
  LET lo_T_DZIVL_T = p_T_DZIVL_T
  
  LET lo_json_obj = util.JSONArray.create()

  #先放Header
  CALL lo_json_obj.put(1,lo_exp_header)

  FOR li_loop = 1 TO lo_T_DZIVL_T.getLength()

    LET lo_T_DZIVL_T_JSON[li_loop].DZIVL001 = lo_T_DZIVL_T[li_loop].DZIVL001
    LET lo_T_DZIVL_T_JSON[li_loop].DZIVL002 = lo_T_DZIVL_T[li_loop].DZIVL002
    LET lo_T_DZIVL_T_JSON[li_loop].DZIVL003 = lo_T_DZIVL_T[li_loop].DZIVL003
    LET lo_T_DZIVL_T_JSON[li_loop].DZIVL004 = lo_T_DZIVL_T[li_loop].DZIVL004
    LET lo_T_DZIVL_T_JSON[li_loop].DZIVL005 = lo_T_DZIVL_T[li_loop].DZIVL005
    LET lo_T_DZIVL_T_JSON[li_loop].DZIVL006 = lo_T_DZIVL_T[li_loop].DZIVL006

    #由於已經先放Header, 所以loop都要往後加一
    CALL lo_json_obj.put(li_loop + 1,lo_T_DZIVL_T_JSON[li_loop])
    
  END FOR

  #排版一下JSON格式文件
  LET ls_return = util.JSON.format(lo_json_obj.toString())

  RETURN ls_return
  
END FUNCTION
## DZIVL_T 相關 Funtion End

## MTable ##
FUNCTION sadzp310_exp_export_mtable_data(p_arguments)
DEFINE
  p_arguments  T_ARGUMENTS
DEFINE
  lo_arguments   T_ARGUMENTS,
  lo_exp_header  T_EXP_HEADER,
  lo_T_DZIA_T    DYNAMIC ARRAY OF T_DZIA_T,
  lo_T_DZIB_T    DYNAMIC ARRAY OF T_DZIB_T,
  lo_T_DZIU_T    DYNAMIC ARRAY OF T_DZIU_T,
  lo_EXP_LIST    DYNAMIC ARRAY OF T_EXP_HEADER,
  ls_JSON_string STRING,
  ls_exp_table   STRING,
  lb_result      BOOLEAN
DEFINE
  lo_return  DYNAMIC ARRAY OF T_EXP_HEADER
  
  LET lo_arguments.* = p_arguments.*

  #dzia_t  
  LET ls_exp_table = "dzia_t"
  INITIALIZE lo_exp_header TO NULL
  CALL sadzp310_exp_get_dzia_t_data(lo_arguments.a_WORKING_OBJECT) RETURNING lo_T_DZIA_T
  CALL sadzp310_exp_get_table_header(ls_exp_table,lo_T_DZIA_T.getLength(),lo_arguments.*) RETURNING lo_exp_header.*
  CALL sadzp310_exp_prepare_dzia_t_json_data(lo_exp_header.*, lo_T_DZIA_T) RETURNING ls_JSON_string
  CALL sadzp310_util_write_file(lo_exp_header.eh_EXP_FULL_NAME,ls_JSON_string) RETURNING lb_result
  CALL sadzp310_exp_set_export_list(lo_exp_header.*,lo_EXP_LIST) RETURNING lo_EXP_LIST
  
  #dzib_t  
  LET ls_exp_table = "dzib_t"
  INITIALIZE lo_exp_header TO NULL
  CALL sadzp310_exp_get_dzib_t_data(lo_arguments.a_WORKING_OBJECT) RETURNING lo_T_DZIB_T
  CALL sadzp310_exp_get_table_header(ls_exp_table,lo_T_DZIB_T.getLength(),lo_arguments.*) RETURNING lo_exp_header.*
  CALL sadzp310_exp_prepare_dzib_t_json_data(lo_exp_header.*, lo_T_DZIB_T) RETURNING ls_JSON_string
  CALL sadzp310_util_write_file(lo_exp_header.eh_EXP_FULL_NAME,ls_JSON_string) RETURNING lb_result
  CALL sadzp310_exp_set_export_list(lo_exp_header.*,lo_EXP_LIST) RETURNING lo_EXP_LIST

  #dziu_t  
  LET ls_exp_table = "dziu_t"
  INITIALIZE lo_exp_header TO NULL
  CALL sadzp310_exp_get_dziu_t_data(lo_arguments.a_WORKING_OBJECT) RETURNING lo_T_DZIU_T
  CALL sadzp310_exp_get_table_header(ls_exp_table,lo_T_DZIU_T.getLength(),lo_arguments.*) RETURNING lo_exp_header.*
  CALL sadzp310_exp_prepare_dziu_t_json_data(lo_exp_header.*, lo_T_DZIU_T) RETURNING ls_JSON_string
  CALL sadzp310_util_write_file(lo_exp_header.eh_EXP_FULL_NAME,ls_JSON_string) RETURNING lb_result
  CALL sadzp310_exp_set_export_list(lo_exp_header.*,lo_EXP_LIST) RETURNING lo_EXP_LIST

  LET lo_return = lo_EXP_LIST

  RETURN lo_return
  
END FUNCTION

## DZIA_T 相關 Funtion Start
FUNCTION sadzp310_exp_get_dzia_t_data(p_object_name)
DEFINE
  p_object_name STRING
DEFINE
  ls_object_name STRING,
  ls_SQL         STRING,
  li_rec_count   INTEGER,
  lo_T_DZIA_T    DYNAMIC ARRAY OF T_DZIA_T
DEFINE
  lo_return  DYNAMIC ARRAY OF T_DZIA_T

  LET ls_object_name = p_object_name.toLowerCase()

  LET ls_sql = "SELECT IA.DZIA001,IA.DZIA002,IA.DZIA003,IA.DZIA004,IA.DZIA005, ",
               "       IA.DZIA006,IA.DZIA007,IA.DZIA008,IA.DZIA009,IA.DZIA010, ",
               "       IA.DZIA011,IA.DZIA012,IA.DZIA013,IA.DZIA014,IA.DZIA015, ",
               "       IA.DZIA016,IA.DZIA017,IA.DZIA018,IA.DZIA019,IA.DZIA020, ",
               "       IA.DZIA021,IA.DZIASTUS                                  ",
               "  FROM DZIA_T IA                                               ",
               " WHERE 1=1                                                     ",
               "   AND IA.DZIA001 = '",ls_object_name,"'                       ",
               " ORDER BY IA.DZIA001                                           "

  INITIALIZE lo_T_DZIA_T TO NULL
  
  PREPARE lpre_get_dzia_t_data FROM ls_sql
  DECLARE lcur_get_dzia_t_data CURSOR FOR lpre_get_dzia_t_data

  LET li_rec_count = 1

  OPEN lcur_get_dzia_t_data
  FOREACH lcur_get_dzia_t_data INTO lo_T_DZIA_T[li_rec_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

  END FOREACH
  CALL lo_T_DZIA_T.deleteElement(li_rec_count)
  
  CLOSE lpre_get_dzia_t_data
  CLOSE lcur_get_dzia_t_data

  LET lo_return = lo_T_DZIA_T

  RETURN lo_return

END FUNCTION

FUNCTION sadzp310_exp_prepare_dzia_t_json_data(p_exp_header,p_T_DZIA_T)
DEFINE
  p_exp_header  T_EXP_HEADER,
  p_T_DZIA_T    DYNAMIC ARRAY OF T_DZIA_T
DEFINE
  lo_exp_header    T_EXP_HEADER,
  lo_T_DZIA_T      DYNAMIC ARRAY OF T_DZIA_T,
  lo_T_DZIA_T_JSON DYNAMIC ARRAY OF T_DZIA_T_JSON,
  lo_json_obj      util.JSONArray,
  li_loop          INTEGER
DEFINE
  ls_return STRING 

  LET lo_exp_header.* = p_exp_header.*
  LET lo_T_DZIA_T = p_T_DZIA_T
  
  LET lo_json_obj = util.JSONArray.create()

  #先放Header
  CALL lo_json_obj.put(1,lo_exp_header)

  FOR li_loop = 1 TO lo_T_DZIA_T.getLength()

    LET lo_T_DZIA_T_JSON[li_loop].DZIA001  = lo_T_DZIA_T[li_loop].DZIA001 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA002  = lo_T_DZIA_T[li_loop].DZIA002 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA003  = lo_T_DZIA_T[li_loop].DZIA003 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA004  = lo_T_DZIA_T[li_loop].DZIA004 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA005  = lo_T_DZIA_T[li_loop].DZIA005 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA006  = lo_T_DZIA_T[li_loop].DZIA006 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA007  = lo_T_DZIA_T[li_loop].DZIA007 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA008  = lo_T_DZIA_T[li_loop].DZIA008 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA009  = lo_T_DZIA_T[li_loop].DZIA009 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA010  = lo_T_DZIA_T[li_loop].DZIA010 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA011  = lo_T_DZIA_T[li_loop].DZIA011 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA012  = lo_T_DZIA_T[li_loop].DZIA012 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA013  = lo_T_DZIA_T[li_loop].DZIA013 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA014  = lo_T_DZIA_T[li_loop].DZIA014 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA015  = lo_T_DZIA_T[li_loop].DZIA015 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA016  = lo_T_DZIA_T[li_loop].DZIA016 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA017  = lo_T_DZIA_T[li_loop].DZIA017 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA018  = lo_T_DZIA_T[li_loop].DZIA018 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA019  = lo_T_DZIA_T[li_loop].DZIA019 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA020  = lo_T_DZIA_T[li_loop].DZIA020 
    LET lo_T_DZIA_T_JSON[li_loop].DZIA021  = lo_T_DZIA_T[li_loop].DZIA021 
    LET lo_T_DZIA_T_JSON[li_loop].DZIASTUS = lo_T_DZIA_T[li_loop].DZIASTUS
    
    #由於已經先放Header, 所以loop都要往後加一
    CALL lo_json_obj.put(li_loop + 1,lo_T_DZIA_T_JSON[li_loop])
    
  END FOR

  #排版一下JSON格式文件
  LET ls_return = util.JSON.format(lo_json_obj.toString())

  RETURN ls_return
  
END FUNCTION
## DZIA_T 相關 Funtion End

## DZIB_T 相關 Funtion Start
FUNCTION sadzp310_exp_get_dzib_t_data(p_object_name)
DEFINE
  p_object_name STRING
DEFINE
  ls_object_name STRING,
  ls_SQL         STRING,
  li_rec_count   INTEGER,
  lo_T_DZIB_T    DYNAMIC ARRAY OF T_DZIB_T 
DEFINE
  lo_return  DYNAMIC ARRAY OF T_DZIB_T

  LET ls_object_name = p_object_name.toLowerCase()

  LET ls_sql = "SELECT IB.DZIB001,IB.DZIB002,IB.DZIB003,IB.DZIB004,IB.DZIB005, ",
               "       IB.DZIB006,IB.DZIB007,IB.DZIB008,IB.DZIB012,IB.DZIB021, ",
               "       IB.DZIB022,IB.DZIB023,IB.DZIB024,IB.DZIB027,IB.DZIB028, ",
               "       IB.DZIB029,IB.DZIB030,IB.DZIB031,                       ",
               "       IB.DZIBSTUS                                             ",
               "  FROM DZIB_T IB                                               ",
               " WHERE IB.DZIB001 = '",ls_object_name,"'                       ",
               " ORDER BY IB.DZIB021                                           "

  INITIALIZE lo_T_DZIB_T TO NULL
  
  PREPARE lpre_get_dzib_t_data FROM ls_sql
  DECLARE lcur_get_dzib_t_data CURSOR FOR lpre_get_dzib_t_data

  LET li_rec_count = 1

  OPEN lcur_get_dzib_t_data
  FOREACH lcur_get_dzib_t_data INTO lo_T_DZIB_T[li_rec_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

  END FOREACH
  CALL lo_T_DZIB_T.deleteElement(li_rec_count)
  
  CLOSE lpre_get_dzib_t_data
  CLOSE lcur_get_dzib_t_data

  LET lo_return = lo_T_DZIB_T

  RETURN lo_return

END FUNCTION

FUNCTION sadzp310_exp_prepare_dzib_t_json_data(p_exp_header,p_T_DZIB_T)
DEFINE
  p_exp_header  T_EXP_HEADER,
  p_T_DZIB_T    DYNAMIC ARRAY OF T_DZIB_T
DEFINE
  lo_exp_header     T_EXP_HEADER,
  lo_T_DZIB_T       DYNAMIC ARRAY OF T_DZIB_T,
  lo_T_DZIB_T_JSON  DYNAMIC ARRAY OF T_DZIB_T_JSON,
  lo_json_obj       util.JSONArray,
  li_loop           INTEGER
DEFINE
  ls_return STRING 

  LET lo_exp_header.* = p_exp_header.*
  LET lo_T_DZIB_T = p_T_DZIB_T
  
  LET lo_json_obj = util.JSONArray.create()

  #先放Header
  CALL lo_json_obj.put(1,lo_exp_header)

  FOR li_loop = 1 TO lo_T_DZIB_T.getLength()

    LET lo_T_DZIB_T_JSON[li_loop].DZIB001  = lo_T_DZIB_T[li_loop].DZIB001 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB002  = lo_T_DZIB_T[li_loop].DZIB002 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB003  = lo_T_DZIB_T[li_loop].DZIB003 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB004  = lo_T_DZIB_T[li_loop].DZIB004 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB005  = lo_T_DZIB_T[li_loop].DZIB005 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB006  = lo_T_DZIB_T[li_loop].DZIB006 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB007  = lo_T_DZIB_T[li_loop].DZIB007 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB008  = lo_T_DZIB_T[li_loop].DZIB008 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB012  = lo_T_DZIB_T[li_loop].DZIB012 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB021  = lo_T_DZIB_T[li_loop].DZIB021 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB022  = lo_T_DZIB_T[li_loop].DZIB022 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB023  = lo_T_DZIB_T[li_loop].DZIB023 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB024  = lo_T_DZIB_T[li_loop].DZIB024 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB027  = lo_T_DZIB_T[li_loop].DZIB027 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB028  = lo_T_DZIB_T[li_loop].DZIB028 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB029  = lo_T_DZIB_T[li_loop].DZIB029 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB030  = lo_T_DZIB_T[li_loop].DZIB030 
    LET lo_T_DZIB_T_JSON[li_loop].DZIB031  = lo_T_DZIB_T[li_loop].DZIB031 
    LET lo_T_DZIB_T_JSON[li_loop].DZIBSTUS = lo_T_DZIB_T[li_loop].DZIBSTUS
    
    #由於已經先放Header, 所以loop都要往後加一
    CALL lo_json_obj.put(li_loop + 1,lo_T_DZIB_T_JSON[li_loop])
    
  END FOR

  #排版一下JSON格式文件
  LET ls_return = util.JSON.format(lo_json_obj.toString())

  RETURN ls_return
  
END FUNCTION
## DZIB_T 相關 Funtion End

## DZIU_T 相關 Funtion Start
FUNCTION sadzp310_exp_get_dziu_t_data(p_object_name)
DEFINE
  p_object_name STRING
DEFINE
  ls_object_name STRING,
  ls_SQL         STRING,
  li_rec_count   INTEGER,
  lo_T_DZIU_T    DYNAMIC ARRAY OF T_DZIU_T 
DEFINE
  lo_return  DYNAMIC ARRAY OF T_DZIU_T

  LET ls_object_name = p_object_name.toLowerCase()

  LET ls_sql = "SELECT IU.DZIU001,IU.DZIU002,IU.DZIU003,IU.DZIU004,IU.DZIU005, ",
               "       IU.DZIU006,IU.DZIU007,IU.DZIU008                        ",
               "  FROM DZIU_T IU                                               ",
               " WHERE IU.DZIU001 = '",ls_object_name,"'                       ",
               " ORDER BY IU.DZIU001,IU.DZIU002                                "
               
  INITIALIZE lo_T_DZIU_T TO NULL
  
  PREPARE lpre_get_dziu_t_data FROM ls_sql
  DECLARE lcur_get_dziu_t_data CURSOR FOR lpre_get_dziu_t_data

  LET li_rec_count = 1

  OPEN lcur_get_dziu_t_data
  FOREACH lcur_get_dziu_t_data INTO lo_T_DZIU_T[li_rec_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

  END FOREACH
  CALL lo_T_DZIU_T.deleteElement(li_rec_count)
  
  CLOSE lpre_get_dziu_t_data
  CLOSE lcur_get_dziu_t_data

  LET lo_return = lo_T_DZIU_T

  RETURN lo_return

END FUNCTION

FUNCTION sadzp310_exp_prepare_dziu_t_json_data(p_exp_header,p_T_DZIU_T)
DEFINE
  p_exp_header  T_EXP_HEADER,
  p_T_DZIU_T   DYNAMIC ARRAY OF T_DZIU_T
DEFINE
  lo_exp_header     T_EXP_HEADER,
  lo_T_DZIU_T       DYNAMIC ARRAY OF T_DZIU_T,
  lo_T_DZIU_T_JSON  DYNAMIC ARRAY OF T_DZIU_T_JSON,
  lo_json_obj       util.JSONArray,
  li_loop           INTEGER
DEFINE
  ls_return STRING 

  LET lo_exp_header.* = p_exp_header.*
  LET lo_T_DZIU_T = p_T_DZIU_T
  
  LET lo_json_obj = util.JSONArray.create()

  #先放Header
  CALL lo_json_obj.put(1,lo_exp_header)

  FOR li_loop = 1 TO lo_T_DZIU_T.getLength()

    LET lo_T_DZIU_T_JSON[li_loop].DZIU001 = lo_T_DZIU_T[li_loop].DZIU001
    LET lo_T_DZIU_T_JSON[li_loop].DZIU002 = lo_T_DZIU_T[li_loop].DZIU002
    LET lo_T_DZIU_T_JSON[li_loop].DZIU003 = lo_T_DZIU_T[li_loop].DZIU003
    LET lo_T_DZIU_T_JSON[li_loop].DZIU004 = lo_T_DZIU_T[li_loop].DZIU004
    LET lo_T_DZIU_T_JSON[li_loop].DZIU005 = lo_T_DZIU_T[li_loop].DZIU005
    LET lo_T_DZIU_T_JSON[li_loop].DZIU006 = lo_T_DZIU_T[li_loop].DZIU006
    LET lo_T_DZIU_T_JSON[li_loop].DZIU007 = lo_T_DZIU_T[li_loop].DZIU007
    LET lo_T_DZIU_T_JSON[li_loop].DZIU008 = lo_T_DZIU_T[li_loop].DZIU008
    
    #由於已經先放Header, 所以loop都要往後加一
    CALL lo_json_obj.put(li_loop + 1,lo_T_DZIU_T_JSON[li_loop])
    
  END FOR

  #排版一下JSON格式文件
  LET ls_return = util.JSON.format(lo_json_obj.toString())

  RETURN ls_return
  
END FUNCTION
## DZIU_T 相關 Funtion End
################################################################################

# Common function
FUNCTION sadzp310_exp_get_table_header(p_exp_table,p_record_count,p_arguments)
DEFINE
  p_exp_table    STRING,
  p_record_count INTEGER,
  p_arguments    T_ARGUMENTS
DEFINE
  ls_exp_table     STRING,
  li_record_count  INTEGER,
  lo_arguments     T_ARGUMENTS,
  lo_T_DZIT_T      DYNAMIC ARRAY OF T_DZIT_T,
  lo_exp_header    T_EXP_HEADER,
  ls_os_separator  STRING
DEFINE
  lo_return T_EXP_HEADER

  LET ls_exp_table    = p_exp_table
  LET li_record_count = p_record_count
  LET lo_arguments.*  = p_arguments.*

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator

  LET lo_exp_header.eh_OBJECT_TYPE   = lo_arguments.a_OBJECT_TYPE
  LET lo_exp_header.eh_OBJECT_NAME   = lo_arguments.a_WORKING_OBJECT
  LET lo_exp_header.eh_EXP_TABLE     = ls_exp_table
  LET lo_exp_header.eh_EXP_RECORDS   = li_record_count
  LET lo_exp_header.eh_EXP_NAME      = lo_arguments.a_WORKING_OBJECT,"_",lo_arguments.a_OBJECT_TYPE,"_",ls_exp_table,".",cs_export_import_ext
  LET lo_exp_header.eh_EXP_PATH      = lo_arguments.a_WORKING_PATH  
  LET lo_exp_header.eh_EXP_FULL_NAME = lo_exp_header.eh_EXP_PATH,ls_os_separator,lo_exp_header.eh_EXP_NAME 
  LET lo_exp_header.eh_EXP_OWNER     = FGL_GETENV("USER")
  LET lo_exp_header.eh_EXP_DATETIME  = CURRENT YEAR TO SECOND
  LET lo_exp_header.eh_DGENV         = FGL_GETENV("DGENV")
  LET lo_exp_header.eh_CUST          = FGL_GETENV("CUST")
  
  LET lo_return.* = lo_exp_header.*

  RETURN lo_return.*
  
END FUNCTION 

FUNCTION sadzp310_exp_set_export_list(p_exp_header,p_EXP_LIST)
DEFINE
  p_exp_header  T_EXP_HEADER,
  p_EXP_LIST  DYNAMIC ARRAY OF T_EXP_HEADER
DEFINE
  lo_exp_header T_EXP_HEADER,
  lo_EXP_LIST DYNAMIC ARRAY OF T_EXP_HEADER,
  li_counts     INTEGER 
DEFINE
  lo_retrn DYNAMIC ARRAY OF T_EXP_HEADER

  LET lo_exp_header.* = p_exp_header.*
  LET lo_EXP_LIST = p_EXP_LIST

  LET li_counts = lo_EXP_LIST.getLength() + 1
  
  LET lo_EXP_LIST[li_counts].* = lo_exp_header.*
  
  LET lo_retrn = lo_EXP_LIST

  RETURN lo_retrn
  
END FUNCTION

FUNCTION sadzp310_exp_set_download_file_parameter(p_param1,p_param2,p_param3,p_param4)
DEFINE 
  p_param1,p_param2,p_param3,p_param4 STRING 
DEFINE
  lo_parameter T_PUT_GET_FILE_PARA
DEFINE
  lo_return  T_PUT_GET_FILE_PARA

  #Source
  LET lo_parameter.SERVER_FILE_PATH = p_param1   
  LET lo_parameter.SERVER_FILE_NAME = p_param2
  #Destination  
  LET lo_parameter.CLIENT_FILE_PATH = p_param3   
  LET lo_parameter.CLIENT_FILE_NAME = p_param4   

  LET lo_return.* = lo_parameter.*

  RETURN lo_return.*  

END FUNCTION 

FUNCTION sadzp310_exp_save_to_client(mo_parameter)
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

  LET ls_source      = lo_parameter.SERVER_FILE_PATH,ls_os_separator,lo_parameter.SERVER_FILE_NAME
  LET ls_destination = lo_parameter.CLIENT_FILE_PATH,ls_os_separator,lo_parameter.CLIENT_FILE_NAME

  DISPLAY cs_information_tag,"Source File : ",ls_source
  DISPLAY cs_information_tag,"Destination File : ",ls_destination 

  TRY 
    CALL FGL_PUTFILE(ls_source,ls_destination)
  CATCH
    LET lb_return = FALSE 
  END TRY  

  RETURN lb_return
  
END FUNCTION 

FUNCTION sadzp310_exp_clone_to_specify_location(p_source_path,p_dest_path,p_file_name)
DEFINE
  p_source_path  STRING,
  p_dest_path    STRING,
  p_file_name    STRING
DEFINE
  ls_source_path      STRING,
  ls_dest_path        STRING,
  ls_file_name        STRING,
  ls_source_full_name STRING,
  ls_dest_full_name   STRING,
  ls_separator        STRING,
  lb_result           BOOLEAN,
  ls_message          STRING  
DEFINE
  lb_return  BOOLEAN
  
  LET ls_source_path  = p_source_path
  LET ls_dest_path    = p_dest_path
  LET ls_file_name    = p_file_name

  LET ls_separator = os.Path.separator()

  LET ls_source_full_name = ls_source_path,ls_separator,ls_file_name
  LET ls_dest_full_name   = ls_dest_path,ls_separator,ls_file_name

  LET lb_result = TRUE

  LET ls_message = "Clone file from '",ls_source_full_name,"' to '",ls_dest_full_name,"'" 
  TRY 
    CALL os.Path.copy(ls_source_full_name,ls_dest_full_name) RETURNING lb_result
  CATCH 
    LET lb_result = FALSE
  END TRY

  IF lb_result THEN 
    DISPLAY cs_success_tag,ls_message
  ELSE
    DISPLAY cs_error_tag,ls_message
  END IF  

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION 

