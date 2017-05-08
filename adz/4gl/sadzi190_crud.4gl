&include "../4gl/sadzi190_mcr.inc"

IMPORT os
IMPORT util

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

#@Description 儲存設計資料到 dzit_t 
#@modify  # 170210-00052#1 by circlelai 加入dzit011欄位
FUNCTION sadzi190_crud_inser_dzit_t(p_dzit_t)
DEFINE
  p_dzit_t T_DZIT_T_WL
DEFINE  
  lo_dzit_t T_DZIT_T_WL
DEFINE
  ls_replace_arg STRING,
  lb_success     BOOLEAN,
  ls_user        VARCHAR(100),
  ldt_datetime   DATETIME YEAR TO SECOND

  LET lo_dzit_t.* = p_dzit_t.*
  LET lb_success = TRUE

  LET ls_user = g_user -- FGL_GETENV("USERNUMBER") #20170104 by circlelai
  
  LET ldt_datetime = CURRENT YEAR TO SECOND

  TRY
    INSERT INTO DZIT_T(
                       DZIT001,DZIT002,DZIT003,DZIT004,DZIT005,
                       DZIT006,DZIT007,DZIT008,DZIT009,DZIT011,
                       DZITCRTID,DZITCRTDT,DZITMODID,DZITMODDT
                      ) 
               VALUES (
                       lo_dzit_t.DZIT001,lo_dzit_t.DZIT002,lo_dzit_t.DZIT003,lo_dzit_t.DZIT004,lo_dzit_t.DZIT005,
                       lo_dzit_t.DZIT006,lo_dzit_t.DZIT007,lo_dzit_t.DZIT008,lo_dzit_t.DZIT009,lo_dzit_t.DZIT011,
                       ls_user,ldt_datetime,ls_user,ldt_datetime
                      )
    
  CATCH 
    TRY
      UPDATE DZIT_T                                 
         SET DZIT005   = lo_dzit_t.dzit005,
             DZIT006   = lo_dzit_t.dzit006,
             DZIT007   = lo_dzit_t.dzit007,
             DZIT008   = lo_dzit_t.dzit008,
             DZIT009   = lo_dzit_t.dzit009,
             DZIT011   = lo_dzit_t.dzit011,
             DZITMODID = ls_user,
             DZITMODDT = ldt_datetime
       WHERE DZIT001  = lo_dzit_t.dzit001
         AND DZIT002  = lo_dzit_t.dzit002
         AND DZIT003  = lo_dzit_t.dzit003
         AND DZIT004  = lo_dzit_t.dzit004
    CATCH
      LET lb_success = FALSE
      DISPLAY "[Warning] Insert or Update DZIT_T unsuccess : ",SQLCA.sqlcode
    END TRY
  END TRY

  RETURN lb_success
  
END FUNCTION

# @fixme 多語言功能尚待完善
FUNCTION sadzi190_crud_inser_dzitl_t(p_dzit_t,p_lang)
DEFINE
  p_dzit_t  T_DZIT_T_WL,
  p_lang    STRING 
DEFINE  
  lo_dzit_t       T_DZIT_T_WL,
  ls_lang_content VARCHAR(1024),
  ls_lang_memo    VARCHAR(1024),
  ls_lang         VARCHAR(10),
  ls_orig_lang    STRING,
  li_loop         INTEGER,
  lo_lang_arr     DYNAMIC ARRAY OF T_LANGUAGE_TYPE
DEFINE
  lb_success  BOOLEAN

  LET lo_dzit_t.* = p_dzit_t.*
  LET ls_lang = p_lang
  LET ls_orig_lang = p_lang
  
  LET lb_success = TRUE

  LET ls_lang_content = lo_dzit_t.DZITL006
  LET ls_lang_memo    = lo_dzit_t.DZITL007

  &ifndef DEBUG
  CALL sadzi190_crud_get_static_lang_list() RETURNING lo_lang_arr

  FOR li_loop = 1 TO lo_lang_arr.getLength()
    LET ls_lang = lo_lang_arr[li_loop]
    IF ls_lang <> ls_orig_lang THEN 
      TRY 
        CALL cl_trans_code_tw_cn(ls_lang,lo_dzit_t.DZITL006) RETURNING ls_lang_content
        CALL cl_trans_code_tw_cn(ls_lang,lo_dzit_t.DZITL007) RETURNING ls_lang_memo
      CATCH
        DISPLAY cs_error_tag,"Translate language data '",ls_lang,"' error."
        LET ls_lang_content = lo_dzit_t.DZITL006
        LET ls_lang_memo    = lo_dzit_t.DZITL007
      END TRY
    ELSE  
      LET ls_lang_content = lo_dzit_t.DZITL006
      LET ls_lang_memo    = lo_dzit_t.DZITL007
    END IF     
  &endif
  
    TRY
      INSERT INTO DZITL_T(
                          DZITL001,DZITL002,DZITL003,DZITL004,DZITL005,
                          DZITL006,DZITL007
                        ) 
                 VALUES (
                         lo_dzit_t.DZIT001,lo_dzit_t.DZIT002,lo_dzit_t.DZIT003,lo_dzit_t.DZIT004,ls_lang,
                         ls_lang_content,ls_lang_memo
                        )
      
    CATCH 
      TRY
        UPDATE DZITL_T                                 
           SET DZITL006 = ls_lang_content,
               DZITL007 = ls_lang_memo
         WHERE DZITL001 = lo_dzit_t.dzit001
           AND DZITL002 = lo_dzit_t.dzit002
           AND DZITL003 = lo_dzit_t.dzit003
           AND DZITL004 = lo_dzit_t.dzit004
           AND DZITL005 = ls_lang
           
      CATCH
        LET lb_success = FALSE
        DISPLAY "[Warning] Insert or Update DZITL_T unsuccess : ",SQLCA.sqlcode
      END TRY
    END TRY
    
  &ifndef DEBUG
  END FOR  
  &endif

  RETURN lb_success
  
END FUNCTION

################################################################################
# Descriptions...: 儲存 trigger 設計資料 到 dzit_t, dzitl_t 資料表中
# Memo...........: 作用於"新增trigger","修改trigger","標準轉客制"
# Usage..........: CALL sadzi190_crud_set_trigger_data(p_dzit_t,p_alter_type,p_lang,p_dgenv)
#                  RETURNINIG lb_success
# Input parameter: p_dzit_t     ,trigger 設計資料
#                : p_alter_type ,新增模式或者修改模式
#                : p_lang       ,目前介面語系
#                : p_dgenv      ,目前環境 客製(c)或標準(s)
# Return code....: lb_success   ,儲存是否成功
# Date & Author..: 
# Modify.........: 2016/01/26 by circlelai
################################################################################
FUNCTION sadzi190_crud_set_trigger_data(p_dzit_t,p_alter_type,p_lang,p_dgenv)
  DEFINE
    p_dzit_t     T_DZIT_T_WL,
    p_alter_type STRING,
    p_lang       STRING,
    p_dgenv      STRING
  DEFINE
    lo_dzit_t       T_DZIT_T_WL,
    lb_result       BOOLEAN,
    lb_success      BOOLEAN,
    ls_alter_type   STRING,
    ls_lang         STRING,
    ls_dgenv        STRING
    

  LET lo_dzit_t.* = p_dzit_t.*
  LET ls_alter_type = p_alter_type
  LET ls_lang  = p_lang 
  LET ls_dgenv = NVL(lo_dzit_t.DZIT004,p_dgenv) 
  LET lb_success = TRUE 
  LET lb_result  = TRUE
  
  BEGIN WORK 
  IF lb_success THEN 
    IF (ls_alter_type = cs_type_std_to_cust) THEN #標準轉客制
      LET lo_dzit_t.DZIT004 = cs_dgenv_customize
    ELSE
      LET lo_dzit_t.DZIT004 = ls_DGENV
    END IF
    
    CALL sadzi190_crud_inser_dzit_t(lo_dzit_t.*) RETURNING lb_result
    CALL sadzi190_crud_inser_dzitl_t(lo_dzit_t.*,ls_lang) RETURNING lb_result
    
    IF NOT lb_result THEN  
      LET lb_success = FALSE
      ROLLBACK WORK 
    END IF  
  END IF
  
  IF lb_success THEN 
    COMMIT WORK 
  END IF
  
  RETURN lb_success
  
END FUNCTION

FUNCTION sadzi190_crud_get_static_lang_list()
DEFINE
  lo_lang_arr DYNAMIC ARRAY OF T_LANGUAGE_TYPE
DEFINE
  lo_return DYNAMIC ARRAY OF T_LANGUAGE_TYPE

  #設定角色Array
  LET lo_lang_arr[1] = cs_lang_zh_cn
  LET lo_lang_arr[2] = cs_lang_zh_tw

  LET lo_return = lo_lang_arr

  RETURN lo_return

END FUNCTION 

FUNCTION sadzi190_crud_trans_schema_queue_to_array(p_schemas)
  DEFINE 
    p_schemas STRING
  DEFINE
    lo_schema_list    DYNAMIC ARRAY OF T_SCHEMA_LIST, 
    li_index          INTEGER,  
    li_schema_counts  INTEGER,
    ls_schema_char    STRING,
    ls_schemas        STRING,
    ls_schemas_string STRING,
    ls_sql            STRING
  DEFINE
    lo_return DYNAMIC ARRAY OF T_SCHEMA_LIST

  LET ls_schemas = p_schemas

  LET ls_schemas_string = NULL 
  #新增"ERPDB"、"MDMDB"字串判斷 --add at 201601261500 by DGW07558
  IF (ls_schemas == cs_alias_erp_db OR  ls_schemas == cs_alias_aws_db) THEN
    LET ls_schemas = IIF ((p_schemas == cs_alias_erp_db), "ERPDB" , "MDMDB")
    LET ls_sql = "SELECT EJ.DZEJ007 FROM DZEJ_T EJ         ", 
                 " WHERE EJ.DZEJ001 = 'adzi180_parameters' ",
                 "   AND EJ.DZEJ004 = '",ls_schemas,"'     "
    PREPARE lpre_trans_schema_que_to_arr FROM ls_sql
    DECLARE lcur_trans_schema_que_to_arr CURSOR FOR lpre_trans_schema_que_to_arr
    OPEN lcur_trans_schema_que_to_arr
    LET li_schema_counts = 1
    FOREACH lcur_trans_schema_que_to_arr INTO lo_schema_list[li_schema_counts].SCHEMA_NAME
      IF SQLCA.sqlcode THEN
        EXIT FOREACH
      END IF
      LET lo_schema_list[li_schema_counts].CHECKBOX = "Y"
      LET li_schema_counts = li_schema_counts + 1 
    END FOREACH
    CALL lo_schema_list.deleteElement(li_schema_counts)
    CLOSE lcur_trans_schema_que_to_arr
    FREE lcur_trans_schema_que_to_arr
    FREE lpre_trans_schema_que_to_arr
  ELSE --old version
    FOR li_index = 1 TO ls_schemas.getLength()
      LET ls_schema_char = NVL(ls_schemas.subString(li_index,li_index),cs_null_value) 
      IF ls_schema_char MATCHES "," THEN
        LET li_schema_counts = lo_schema_list.getLength()
        LET lo_schema_list[li_schema_counts + 1].CHECKBOX = "Y"
        LET lo_schema_list[li_schema_counts + 1].SCHEMA_NAME = ls_schemas_string
        LET ls_schemas_string = NULL
      ELSE
        LET ls_schemas_string = ls_schemas_string,ls_schema_char 
      END IF    
    END FOR

    #最後一組或僅有一組要加入Array
    IF ls_schemas_string IS NOT NULL THEN 
      LET li_schema_counts = lo_schema_list.getLength()
      LET lo_schema_list[li_schema_counts + 1].CHECKBOX = "Y"
      LET lo_schema_list[li_schema_counts + 1].SCHEMA_NAME = ls_schemas_string
    END IF  
  END IF 
  
  

  LET lo_return = lo_schema_list
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi190_crud_add_template_schema(p_schema_list)
DEFINE
  p_schema_list    DYNAMIC ARRAY OF T_SCHEMA_LIST
DEFINE
  lo_schema_list   DYNAMIC ARRAY OF T_SCHEMA_LIST,
  li_schema_counts INTEGER
DEFINE
  lo_return DYNAMIC ARRAY OF T_SCHEMA_LIST

  LET lo_schema_list = p_schema_list

  LET li_schema_counts = lo_schema_list.getLength()
  LET lo_schema_list[li_schema_counts + 1].CHECKBOX = "Y"
  LET lo_schema_list[li_schema_counts + 1].SCHEMA_NAME = cs_template_words

  LET lo_return = lo_schema_list  
  
  RETURN lo_return
  
END FUNCTION

# @desc.  檢查Trigger樣版是否存在
FUNCTION sadzi190_crud_check_if_template_exists(p_dzit_t)
  DEFINE
    p_dzit_t      T_DZIT_T_WL
  DEFINE
    lo_dzit_t     T_DZIT_T_WL,
    ls_sql        STRING,
    li_rec_count  INTEGER
  DEFINE
    lb_return  BOOLEAN

  LET lo_dzit_t.* = p_dzit_t.*

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                             ",
               "  FROM DZIT_T IT                            ",
               " WHERE IT.DZIT001 = '",lo_dzit_t.DZIT001,"' ",
               "   AND IT.DZIT002 = '",lo_dzit_t.DZIT002,"' ",
               "   AND IT.DZIT003 = '",cs_template_words,"' ",
               --"   AND IT.DZIT004 = '",cs_dgenv_standard,",",cs_dgenv_customize,"' "
               "   AND IT.DZIT004 = '",lo_dzit_t.DZIT004,"' "
 
  PREPARE lpre_check_if_template_exists FROM ls_sql
  DECLARE lcur_check_if_template_exists CURSOR FOR lpre_check_if_template_exists
  OPEN lcur_check_if_template_exists
  FETCH lcur_check_if_template_exists INTO li_rec_count
  CLOSE lcur_check_if_template_exists
  FREE lcur_check_if_template_exists
  FREE lpre_check_if_template_exists

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

# @desc.  檢核還有沒有其他設計資料
FUNCTION sadzi190_crud_check_if_design_data_exists(p_dzit_t)
DEFINE
  p_dzit_t  T_DZIT_T_WL
DEFINE
  lo_dzit_t     T_DZIT_T_WL,
  ls_sql        STRING,
  li_rec_count  INTEGER
DEFINE
  lb_return  BOOLEAN

  LET lo_dzit_t.* = p_dzit_t.*

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                              ",
               "  FROM DZIT_T IT                             ",
               " WHERE IT.DZIT001 = '",lo_dzit_t.DZIT001,"'  ",
               "   AND IT.DZIT002 = '",lo_dzit_t.DZIT002,"'  ",
               "   AND IT.DZIT003 <> '",cs_template_words,"' ",
               "   AND IT.DZIT004 = '",lo_dzit_t.DZIT004,"'  "
 
  PREPARE lpre_check_if_design_data_exists FROM ls_sql
  DECLARE lcur_check_if_design_data_exists CURSOR FOR lpre_check_if_design_data_exists
  OPEN lcur_check_if_design_data_exists
  FETCH lcur_check_if_design_data_exists INTO li_rec_count
  CLOSE lcur_check_if_design_data_exists
  FREE lcur_check_if_design_data_exists
  FREE lpre_check_if_design_data_exists

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

# @desc.  檢核dzit_t資料是否存在
FUNCTION sadzi190_crud_check_if_dzit_t_exists(p_dzit_t)
  DEFINE
    p_dzit_t  T_DZIT_T_WL
  DEFINE 
    lo_dzit_t     T_DZIT_T_WL,
    li_rec_count  INTEGER,
    ls_sql        STRING 
    
  DEFINE
    lb_return  BOOLEAN

  LET lo_dzit_t.* = p_dzit_t.*
  LET li_rec_count = 0

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                              ",
               "  FROM DZIT_T IT                             ",
               " WHERE IT.DZIT001 = '",lo_dzit_t.DZIT001,"'  ",
               "   AND IT.DZIT002 = '",lo_dzit_t.DZIT002,"'  ",
               "   AND IT.DZIT003 = '",lo_dzit_t.DZIT003,"' ",
               "   AND IT.DZIT004 = '",lo_dzit_t.DZIT004,"'  "
 
  PREPARE lpre_check_if_dzit_t_exists FROM ls_sql
  DECLARE lcur_check_if_dzit_t_exists CURSOR FOR lpre_check_if_dzit_t_exists
  OPEN lcur_check_if_dzit_t_exists
  FETCH lcur_check_if_dzit_t_exists INTO li_rec_count
  CLOSE lcur_check_if_dzit_t_exists
  FREE lcur_check_if_dzit_t_exists
  FREE lpre_check_if_dzit_t_exists
  
  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  RETURN lb_return
END FUNCTION 

# @desc.  更新trigger狀態到數據庫中
FUNCTION sadzi190_crud_set_trigger_status(p_dzit_t)
DEFINE
  p_dzit_t T_DZIT_T_WL
DEFINE  
  lo_dzit_t  T_DZIT_T_WL,
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
    DISPLAY "[Warning] Update trigger status unsuccess : ",SQLCA.sqlcode
  END TRY

  LET lb_return = lb_success     
    
  RETURN lb_return
  
END FUNCTION

# @desc.  判斷schema_name是否'中台資料庫類'
FUNCTION sadzi190_crud_check_if_MDMDB(p_schema_name)
DEFINE
  p_schema_name  STRING
DEFINE
  ls_schema_name STRING,
  ls_sql         STRING,
  li_rec_count   INTEGER
DEFINE
  lb_return  BOOLEAN

  LET ls_schema_name = p_schema_name

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                          ",
               "  FROM DZEJ_T EJ                         ",
               " WHERE EJ.DZEJ001 = 'adzi180_parameters' ",
               "   AND EJ.DZEJ004 = 'MDMDB'              ",
               "   AND EJ.DZEJ007 = '",ls_schema_name,"' "
                
  PREPARE lpre_check_if_MDMDB FROM ls_sql
  DECLARE lcur_check_if_MDMDB CURSOR FOR lpre_check_if_MDMDB
  OPEN lcur_check_if_MDMDB
  FETCH lcur_check_if_MDMDB INTO li_rec_count
  CLOSE lcur_check_if_MDMDB
  FREE lcur_check_if_MDMDB
  FREE lpre_check_if_MDMDB

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

# @desc.  trigger script content 檢查
# @memo   中間庫的trigger不能對ERP資料庫做刪除(DELETE),更改(UPDATE)的操作行為
# @modify 170210-00052#1 at 2017/02/14 by circlelai 新增dzit011內容檢查行為 
FUNCTION sadzi190_crud_verify_if_with_exclude_words(p_dzit_t)
DEFINE
  p_dzit_t  T_DZIT_T_WL
DEFINE
  lo_dzit_t      T_DZIT_T_WL,
  lo_str_buf     base.StringBuffer,
  li_BEGIN_pos   INTEGER,
  li_delete_pos  INTEGER,
  li_update_pos  INTEGER,
  ls_dzit008     STRING,
  li_loop        INTEGER,
  lb_result      BOOLEAN,
  lo_schema_list DYNAMIC ARRAY OF T_SCHEMA_LIST
DEFINE ls_str    STRING                 # 字串暫存變數 # 170210-00052#1 add 
DEFINE li_dzit011_BEGIN_pos   INTEGER   # 170210-00052#1 add 
DEFINE li_dzit011_delete_pos  INTEGER   # 170210-00052#1 add 
DEFINE li_dzit011_update_pos  INTEGER   # 170210-00052#1 add 
DEFINE
  lb_return  BOOLEAN  

  LET lo_dzit_t.* = p_dzit_t.*

  LET li_BEGIN_pos = 0
  LET li_delete_pos = 0
  LET li_update_pos = 0

  # 170210-00052#1 add by circlelai begin 
  LET li_dzit011_BEGIN_pos  = 0
  LET li_dzit011_delete_pos = 0
  LET li_dzit011_update_pos = 0
  # 170210-00052#1 add by circlelai end
  
  #檢核傳入的欲建構Schema是否有MDM資料庫
  CALL sadzi190_crud_trans_schema_queue_to_array(lo_dzit_t.DZIT003) RETURNING lo_schema_list
  LET lb_result = FALSE
  FOR li_loop = 1 TO lo_schema_list.getLength()
    CALL sadzi190_crud_check_if_MDMDB(lo_schema_list[li_loop].SCHEMA_NAME) RETURNING lb_result
    IF lb_result THEN EXIT FOR END IF 
  END FOR
  #如果沒有MDM資料庫則不做DELETE,UPDATE檢核,直接離開
  IF NOT lb_result THEN GOTO _return END IF

  LET lo_str_buf = base.StringBuffer.create()
  CALL lo_str_buf.Clear()
  
  # --檢查 dzit008 內容是否含有 DELETE 與 UPDATE 關鍵字
  LET ls_dzit008 = lo_dzit_t.DZIT008
  CALL lo_str_buf.append(ls_dzit008.toUpperCase())

  #先取得"BEGIN"的位置
  LET li_BEGIN_pos = lo_str_buf.getIndexOf(cs_trigger_keyword_begin,1)
  #再加上"BEGIN"的長度才是檢核開始位置
  LET li_BEGIN_pos = li_BEGIN_pos + cs_trigger_keyword_begin.getLength()
  
  #檢核是否有 DELETE 關鍵字
  LET li_delete_pos = lo_str_buf.getIndexOf(cs_exclude_keyword_delete,li_BEGIN_pos)
  #檢核是否有 UPDATE 關鍵字
  LET li_update_pos = lo_str_buf.getIndexOf(cs_exclude_keyword_update,li_BEGIN_pos)

  # 170210-00052#1 add by circlelai begin 
  # --檢查 dzit011 內容是否含有 DELETE 與 UPDATE 關鍵字
  CALL lo_str_buf.Clear()
  LET  ls_str = lo_dzit_t.DZIT011
  CALL lo_str_buf.append(ls_str.toUpperCase())
  
  #先取得"BEGIN"的位置
  LET li_dzit011_BEGIN_pos = lo_str_buf.getIndexOf(cs_trigger_keyword_begin,1)
  #再加上"BEGIN"的長度才是檢核開始位置
  LET li_dzit011_BEGIN_pos = li_BEGIN_pos + cs_trigger_keyword_begin.getLength()
  
  #檢核是否有 DELETE 關鍵字
  LET li_dzit011_delete_pos = lo_str_buf.getIndexOf(cs_exclude_keyword_delete,li_dzit011_BEGIN_pos)
  #檢核是否有 UPDATE 關鍵字
  LET li_dzit011_update_pos = lo_str_buf.getIndexOf(cs_exclude_keyword_update,li_dzit011_BEGIN_pos)
  # 170210-00052#1 add by circlelai end
  
  LABEL _return:
  
  IF (li_delete_pos > 0) OR (li_update_pos > 0)
     OR (li_dzit011_delete_pos > 0) OR (li_dzit011_update_pos > 0) THEN  # 170210-00052#1 mod
    LET lb_return = TRUE 
  ELSE 
    LET lb_return = FALSE 
  END IF 

  RETURN lb_return
      
END FUNCTION

# @desc.  客制還原回標準
FUNCTION sadzi190_crud_cust_to_std(p_dzit_t)
  DEFINE
    p_dzit_t      T_DZIT_T_WL
  DEFINE
    lo_dzit_t     T_DZIT_T_WL,
    ls_sqlwhere   STRING,
    ls_sql        STRING,
    ls_tbl_name   STRING,   #table name
    ls_trg_name   STRING,   #Trigger Name
    ls_stand_cust STRING,   #客制旗標
    li_rec_count  INTEGER,
    lb_result     BOOLEAN,
    lb_del_temp   BOOLEAN   --是否要刪除trigger樣版
    
  DEFINE
    lb_return  BOOLEAN
  
  LET lo_dzit_t.* = p_dzit_t.*
  
  LET lb_return = TRUE 
  LET lb_result = TRUE
  LET ls_tbl_name = lo_dzit_t.DZIT001
  LET ls_trg_name = lo_dzit_t.DZIT002
  LET ls_stand_cust = lo_dzit_t.DZIT004

  #檢查
  IF (ls_tbl_name IS NULL 
      || ls_trg_name IS NULL 
      || ls_stand_cust IS NULL ) THEN 
    LET lb_return = FALSE
  END IF
  
  #是否要一併刪除Trigger樣板
  IF (NOT sadzi190_crud_check_if_design_data_exists(lo_dzit_t.*)) THEN
    LET lb_del_temp = TRUE 
  ELSE 
    LET lb_del_temp = FALSE 
  END IF 
  
  IF (lb_return) THEN
    BEGIN WORK
    #刪除設計資料 from dzit_t
    IF (lb_result) THEN
      LET ls_sqlwhere = " WHERE IT.DZIT001='",ls_tbl_name,"' ",
                        "   AND IT.DZIT002='",ls_trg_name,"' "
      IF (lb_del_temp) THEN 
        LET ls_sqlwhere = ls_sqlwhere, 
                          "   AND IT.DZIT003 in ('",lo_dzit_t.DZIT003,"','",cs_template_words,"') "
      ELSE 
        LET ls_sqlwhere = ls_sqlwhere, "   AND IT.DZIT003='",lo_dzit_t.DZIT003,"' "
      END IF 
      LET ls_sqlwhere = ls_sqlwhere, 
                        "   AND IT.DZIT004='",ls_stand_cust,"' "
      LET ls_sql = "DELETE FROM DZIT_T IT ", ls_sqlwhere
      CALL sadzi190_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
    END IF 
    #刪除設計資料 from dzitl_t
    IF (lb_result) THEN
      LET ls_sqlwhere = " WHERE ITL.DZITL001='",ls_tbl_name,"' ",
                        "   AND ITL.DZITL002='",ls_trg_name,"' "
      IF (lb_del_temp) THEN
        LET ls_sqlwhere = ls_sqlwhere, 
                          "   AND ITL.DZITL003 in ('",lo_dzit_t.DZIT003,"','",cs_template_words,"') "
      ELSE 
        LET ls_sqlwhere = ls_sqlwhere, "   AND ITL.DZITL003='",lo_dzit_t.DZIT003,"' "
      END IF 
      LET ls_sqlwhere = ls_sqlwhere,
                        "   AND ITL.DZITL004='",ls_stand_cust,"' "
      LET ls_sql = "DELETE FROM DZITL_T ITL ", ls_sqlwhere
      CALL sadzi190_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
    END IF 
    #刪除 DZLM_T (簽出入記錄)
    IF (lb_result) THEN
      LET ls_sqlwhere = " WHERE LM.DZLM001='MG' ",
                        "   AND LM.DZLM002='",ls_trg_name,"' "
      LET ls_sql = "DELETE FROM DZLM_T LM ", ls_sqlwhere
      CALL sadzi190_db_exec_SQL_no_commit(ls_sql,FALSE) RETURNING lb_result
    END IF 
    #刪除 DZAF_T (版本樹) 中有關客制的部分
    IF lb_result THEN
      LET ls_sqlwhere = " WHERE DZAF001='", ls_trg_name, "'    ", 
                        "   AND DZAF010='", ls_stand_cust, "'  ", 
                        "   AND DZAF005='MG'                   "
      LET ls_sql = "DELETE FROM DZAF_T ", ls_sqlwhere
      CALL sadzi190_db_exec_SQL_no_commit(ls_sql, FALSE) RETURNING lb_result
    END IF
    
    IF lb_result THEN
      COMMIT WORK 
    ELSE
      LET lb_return = FALSE 
      ROLLBACK WORK
    END IF 
  END IF 
  
  RETURN lb_return
END FUNCTION 
