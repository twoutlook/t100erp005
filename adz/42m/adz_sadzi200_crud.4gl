&include "../4gl/sadzi200_mcr.inc"

IMPORT os
IMPORT util

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

FUNCTION sadzi200_crud_inser_dziv_t(p_dziv_t)
DEFINE
  p_dziv_t T_DZIV_T_WL
DEFINE  
  lo_dziv_t T_DZIV_T_WL
DEFINE
  ls_replace_arg STRING,
  lb_success     BOOLEAN,
  ls_user        VARCHAR(100),
  ldt_datetime   DATETIME YEAR TO SECOND

  LET lo_dziv_t.* = p_dziv_t.*
  LET lb_success = TRUE

  LET ls_user = g_user --FGL_GETENV("USERNUMBER")
  LET ldt_datetime = CURRENT YEAR TO SECOND

  TRY
    INSERT INTO DZIV_T(
                       DZIV001,DZIV002,DZIV003,DZIV004,DZIV005,
                       DZIVCRTID,DZIVCRTDT,DZIVMODID,DZIVMODDT
                      ) 
               VALUES (
                       lo_dziv_t.DZIV001,lo_dziv_t.DZIV002,lo_dziv_t.DZIV003,lo_dziv_t.DZIV004,lo_dziv_t.DZIV005,
                       ls_user,ldt_datetime,ls_user,ldt_datetime
                      )
    
  CATCH 
    TRY
    
      UPDATE DZIV_T                                 
         SET DZIV004   = lo_dziv_t.dziv004,
             DZIV005   = lo_dziv_t.dziv005,
             DZIVMODID = ls_user,
             DZIVMODDT = ldt_datetime
       WHERE DZIV001  = lo_dziv_t.dziv001
         AND DZIV002  = lo_dziv_t.dziv002
         AND DZIV003  = lo_dziv_t.dziv003
         
    CATCH
      LET lb_success = FALSE
      DISPLAY "[Warning] Insert or Update DZIV_T unsuccess : ",SQLCA.sqlcode
    END TRY
  END TRY

  RETURN lb_success
  
END FUNCTION

FUNCTION sadzi200_crud_inser_dzivl_t(p_dziv_t,p_lang)
DEFINE
  p_dziv_t  T_DZIV_T_WL,
  p_lang    STRING 
DEFINE  
  lo_dziv_t       T_DZIV_T_WL,
  ls_lang_content VARCHAR(1024),
  ls_lang_memo    VARCHAR(1024),
  ls_lang         VARCHAR(10),
  ls_orig_lang    STRING,
  li_loop         INTEGER,
  lo_lang_arr     DYNAMIC ARRAY OF T_LANGUAGE_TYPE
DEFINE
  lb_success  BOOLEAN

  LET lo_dziv_t.* = p_dziv_t.*
  LET ls_lang = p_lang
  LET ls_orig_lang = p_lang
  
  LET lb_success = TRUE

  LET ls_lang_content = lo_dziv_t.DZIVL005
  LET ls_lang_memo    = lo_dziv_t.DZIVL006

  &ifndef DEBUG
  CALL sadzi200_crud_get_static_lang_list() RETURNING lo_lang_arr

  FOR li_loop = 1 TO lo_lang_arr.getLength()
    LET ls_lang = lo_lang_arr[li_loop]
    IF ls_lang <> ls_orig_lang THEN 
      TRY 
        CALL cl_trans_code_tw_cn(ls_lang,lo_dziv_t.DZIVL005) RETURNING ls_lang_content
        CALL cl_trans_code_tw_cn(ls_lang,lo_dziv_t.DZIVL006) RETURNING ls_lang_memo
      CATCH
        DISPLAY cs_error_tag,"Translate language data '",ls_lang,"' error."
        LET ls_lang_content = lo_dziv_t.DZIVL005
        LET ls_lang_memo    = lo_dziv_t.DZIVL006
      END TRY
    ELSE  
      LET ls_lang_content = lo_dziv_t.DZIVL005
      LET ls_lang_memo    = lo_dziv_t.DZIVL006
    END IF     
  &endif
  
    TRY
      INSERT INTO DZIVL_T(
                          DZIVL001,DZIVL002,DZIVL003,DZIVL004,DZIVL005,
                          DZIVL006
                        ) 
                 VALUES (
                         lo_dziv_t.DZIV001,lo_dziv_t.DZIV002,lo_dziv_t.DZIV003,ls_lang,ls_lang_content,
                         ls_lang_memo
                        )
      
    CATCH 
      TRY
        UPDATE DZIVL_T                                 
           SET DZIVL005 = ls_lang_content,
               DZIVL006 = ls_lang_memo
         WHERE DZIVL001 = lo_dziv_t.dziv001
           AND DZIVL002 = lo_dziv_t.dziv002
           AND DZIVL003 = lo_dziv_t.dziv003
           AND DZIVL004 = ls_lang
           
      CATCH
        LET lb_success = FALSE
        DISPLAY "[Warning] Insert or Update DZIVL_T unsuccess : ",SQLCA.sqlcode
      END TRY
    END TRY
    
  &ifndef DEBUG
  END FOR  
  &endif

  RETURN lb_success
  
END FUNCTION

#新增或更新View設計資料到DB
FUNCTION sadzi200_crud_set_view_data(p_dziv_t,p_alter_type,p_lang,p_dgenv)
DEFINE
  p_dziv_t     T_DZIV_T_WL,
  p_alter_type STRING,
  p_lang       STRING,
  p_dgenv      STRING
DEFINE
  lo_dziv_t       T_DZIV_T_WL,
  ls_alter_type   STRING,
  ls_lang         STRING,
  ls_dgenv        STRING,
  lo_str_buf      base.StringBuffer,
  lo_dziv004      LIKE DZIV_T.dziv004,
  ls_dziv004      STRING,
  ls_orig_dziv004 STRING,
  ls_mdm_name     STRING,
  ls_erp_name     STRING,
  li_loop         INTEGER,
  lb_result       BOOLEAN,
  lb_success      BOOLEAN,
  lo_schema_list  DYNAMIC ARRAY OF T_SCHEMA_LIST
DEFINE
  lb_return BOOLEAN
  
  LET lo_dziv_t.* = p_dziv_t.*
  LET ls_alter_type = p_alter_type
  LET ls_lang  = p_lang 
  LET ls_dgenv = NVL(lo_dziv_t.DZIV003,p_dgenv)

  LOCATE lo_dziv004 IN FILE
  
  LET lo_str_buf = base.StringBuffer.create()
  CALL lo_str_buf.Clear()
  
  LET lb_success = TRUE
  LET lb_result  = TRUE
  
  BEGIN WORK

  #20160706 mark begin 
  ## 儲存 Template 的部份都改為不需要
  {
  IF lb_success THEN
    #mod at 20160322 by CircleLai start -->
    IF (lo_dziv_t.DZIV002 == cs_alias_aws_db OR lo_dziv_t.DZIV002 == cs_alias_erp_db) THEN
      IF (ls_alter_type = cs_type_std_to_cust) THEN #標準轉客制
        LET lo_dziv_t.DZIV003 = cs_dgenv_customize
      ELSE
        LET lo_dziv_t.DZIV003 = ls_DGENV
      END IF

      CALL sadzi200_crud_inser_dziv_t(lo_dziv_t.*) RETURNING lb_result
      CALL sadzi200_crud_inser_dzivl_t(lo_dziv_t.*,ls_lang) RETURNING lb_result
    ELSE  #older version ,暫時保留
      #先從"欲建構Schema"上抓取要建立資料的Schema名稱
      CALL sadzi200_crud_trans_schema_queue_to_array(lo_dziv_t.DZIV002) RETURNING lo_schema_list
      
      #建立時期而且Template不存在才新增 Template
      IF (ls_alter_type = cs_create_view) AND NOT sadzi200_crud_check_if_template_exists(lo_dziv_t.*) THEN  
        CALL sadzi200_crud_add_template_schema(lo_schema_list) RETURNING lo_schema_list
      END IF

      #先存原始的 DZIV004
      LET lo_dziv004 = lo_dziv_t.DZIV004
      LET ls_dziv004 = lo_dziv_t.DZIV004
      LET ls_orig_dziv004 = lo_dziv_t.DZIV004
      
      FOR li_loop = 1 TO lo_schema_list.getLength()
        IF lo_schema_list[li_loop].CHECKBOX = "Y" THEN 
          LET lo_dziv_t.DZIV002 = lo_schema_list[li_loop].SCHEMA_NAME
          #若是樣板, 則標準或客製給兩者
          IF lo_dziv_t.DZIV002 = cs_template_words THEN
            --LET lo_dziv_t. = cs_dgenv_standard,",",cs_dgenv_customize
            LET lo_dziv_t.DZIV003 = ls_DGENV
            LET lo_dziv_t.DZIV004 = ls_orig_dziv004
          ELSE
            #否則將ERP/MDM資料庫名稱置換進 Template 中
            LET lo_dziv_t.DZIV003 = ls_DGENV
            LET ls_dziv004 = ls_orig_dziv004
            CALL sadzi200_util_get_mdmdb_name(lo_schema_list[li_loop].SCHEMA_NAME) RETURNING ls_mdm_name
            CALL sadzi200_util_get_erpdb_name(lo_schema_list[li_loop].SCHEMA_NAME) RETURNING ls_erp_name
            CALL lo_str_buf.clear()
            CALL lo_str_buf.append(ls_dziv004)
            CALL lo_str_buf.replace(cs_identify_mdm_db,ls_mdm_name,0) -- 置換MDMDB 
            CALL lo_str_buf.replace(cs_identify_erp_db,ls_erp_name,0) -- 置換ERPDB  
            CALL lo_str_buf.toString() RETURNING ls_dziv004  
            LET lo_dziv_t.DZIV004 = ls_dziv004          
          END IF
          CALL sadzi200_crud_inser_dziv_t(lo_dziv_t.*) RETURNING lb_result
          CALL sadzi200_crud_inser_dzivl_t(lo_dziv_t.*,ls_lang) RETURNING lb_result
        END IF  
      END FOR
      
    END IF
    #mod at 20160322 by CircleLai end
    
    IF NOT lb_result THEN 
      LET lb_success = FALSE
      ROLLBACK WORK 
    END IF
    
  END IF   
  }
  #20160706 mark end

  #20160706 begin
  IF (ls_alter_type = cs_type_std_to_cust) THEN #標準轉客制
    LET lo_dziv_t.DZIV003 = cs_dgenv_customize
  ELSE
    LET lo_dziv_t.DZIV003 = ls_DGENV
  END IF

  IF lb_result THEN 
    CALL sadzi200_crud_inser_dziv_t(lo_dziv_t.*) RETURNING lb_result
  END IF  
  
  IF lb_result THEN 
    CALL sadzi200_crud_inser_dzivl_t(lo_dziv_t.*,ls_lang) RETURNING lb_result
  END IF  

  IF lb_result THEN 
    COMMIT WORK 
  ELSE
    LET lb_success = FALSE
    ROLLBACK WORK 
  END IF
  #20160706 end
  
  FREE lo_dziv004

  LET lb_return = lb_success

  RETURN lb_return
      
END FUNCTION

FUNCTION sadzi200_crud_get_static_lang_list()
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
################################################################################
# Descriptions...: 解譯schema_string或者資料庫別名(db_alias)取得 資料庫陣列(lo_schema_list)
# Memo...........: schema_string example "dsaws,dsawst"
#                : db_alias example "awsdb"
# Usage..........: CALL sadzi200_crud_trans_schema_queue_to_array(p_schemas) RETURNING lo_return
# Input parameter: p_schemas 要解譯的字串
# Return code....: lo_return 解譯取得的資料庫陣列
# Date & Author..: 
# Modify.........: 20160322 by CircleLai
################################################################################
FUNCTION sadzi200_crud_trans_schema_queue_to_array(p_schemas)
DEFINE 
  p_schemas STRING
DEFINE 
  li_index          INTEGER,
  li_schema_counts  INTEGER,
  ls_schema_char    STRING,
  ls_schemas        STRING,
  ls_schemas_string STRING,
  ls_sql            STRING,
  ls_db_type        STRING,
  lo_schema_list    DYNAMIC ARRAY OF T_SCHEMA_LIST
DEFINE
  lo_return DYNAMIC ARRAY OF T_SCHEMA_LIST

  LET ls_schemas = p_schemas 
  LET ls_schemas_string = NULL 

  CASE 
    #ERPDB
    WHEN (ls_schemas = cs_alias_erp_db) 
      LET ls_db_type = "Y" 
    #MDMDB
    WHEN (ls_schemas = cs_alias_aws_db)
      LET ls_db_type = "M"
  END CASE 

  LET ls_sql = "SELECT 'Y'        CHECKBOX,           ",
               "       DA.GZDA001 SCHEMA_NAME         ",
               "  FROM GZDA_T DA                      ",
               " WHERE DA.GZDASTUS = 'Y'              ", 
               "   AND DA.GZDA005  = '",ls_db_type,"' ",
               " ORDER BY DA.GZDA001 DESC             " 

  PREPARE lpre_trans_schema_queue_to_array FROM ls_sql
  DECLARE lcur_trans_schema_queue_to_array CURSOR FOR lpre_trans_schema_queue_to_array
  OPEN lcur_trans_schema_queue_to_array
  LET li_schema_counts = 1
  
  FOREACH lcur_trans_schema_queue_to_array INTO lo_schema_list[li_schema_counts].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET li_schema_counts = li_schema_counts + 1
    
  END FOREACH
  
  CALL lo_schema_list.deleteElement(li_schema_counts)
  
  CLOSE lcur_trans_schema_queue_to_array
  
  FREE lcur_trans_schema_queue_to_array
  FREE lpre_trans_schema_queue_to_array

  LET lo_return = lo_schema_list
  
  RETURN lo_return
  
END FUNCTION

FUNCTION sadzi200_crud_add_template_schema(p_schema_list)
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

FUNCTION sadzi200_crud_check_if_template_exists(p_dziv_t)
DEFINE
  p_dziv_t  T_DZIV_T_WL
DEFINE
  lo_dziv_t     T_DZIV_T_WL,
  ls_sql        STRING,
  li_rec_count  INTEGER
DEFINE
  lb_return  BOOLEAN

  LET lo_dziv_t.* = p_dziv_t.*

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                             ",
               "  FROM DZIV_T IT                            ",
               " WHERE IT.DZIV001 = '",lo_dziv_t.DZIV001,"' ",
               "   AND IT.DZIV002 = '",cs_template_words,"' ",
               "   AND IT.DZIV003 = '",lo_dziv_t.DZIV003,"' "
 
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

FUNCTION sadzi200_crud_check_if_design_data_exists(p_dziv_t)
DEFINE
  p_dziv_t  T_DZIV_T_WL
DEFINE
  lo_dziv_t     T_DZIV_T_WL,
  ls_sql        STRING,
  li_rec_count  INTEGER
DEFINE
  lb_return  BOOLEAN

  LET lo_dziv_t.* = p_dziv_t.*

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                              ",
               "  FROM DZIV_T IT                             ",
               " WHERE IT.DZIV001 = '",lo_dziv_t.DZIV001,"'  ",
               "   AND IT.DZIV002 <> '",cs_template_words,"' ",
               "   AND IT.DZIV003 = '",lo_dziv_t.DZIV003,"'  "
 
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

################################################################################
# Descriptions...: 檢查 View 設計資料是否已經存在設計資料表中
# Memo...........: 
# Usage..........: sadzi200_crud_check_if_dziv_t_exists(p_dziv_t) 
#                    RETURNING lb_return
# Input parameter: p_dziv_t   view 設計資料
#                : 
# Return code....: lb_return  true:設計資料已存在, false: 設計資料不存在
#                : 
# Date & Author..: 20160224 by Jack Cheng
# Modify.........: 20160315 by CircleLai
################################################################################
FUNCTION sadzi200_crud_check_if_dziv_t_exists(p_dziv_t)
DEFINE
  p_dziv_t  T_DZIV_T_WL
DEFINE
  lo_dziv_t     T_DZIV_T_WL,
  ls_sql        STRING,
  li_rec_count  INTEGER
DEFINE
  lb_return  BOOLEAN

  LET lo_dziv_t.* = p_dziv_t.*
  LET li_rec_count = 0

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                              ",
               "  FROM DZIV_T IT                             ",
               " WHERE IT.DZIV001 = '",lo_dziv_t.DZIV001,"'  ",
               "   AND IT.DZIV002 = '",lo_dziv_t.DZIV002,"' ",
               "   AND IT.DZIV003 = '",lo_dziv_t.DZIV003,"'  "
 
  PREPARE lpre_check_if_dziv_t_exists FROM ls_sql
  DECLARE lcur_check_if_dziv_t_exists CURSOR FOR lpre_check_if_dziv_t_exists
  OPEN lcur_check_if_dziv_t_exists
  FETCH lcur_check_if_dziv_t_exists INTO li_rec_count
  CLOSE lcur_check_if_dziv_t_exists
  FREE lcur_check_if_dziv_t_exists
  FREE lpre_check_if_dziv_t_exists

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi200_crud_check_view_name_if_exists(p_view_name)
DEFINE
  p_view_name  STRING
DEFINE
  ls_view_name  STRING,
  ls_sql        STRING,
  li_rec_count  INTEGER
DEFINE
  lb_return  BOOLEAN

  LET ls_view_name = p_view_name
  LET li_rec_count = 0

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                        ",
               "  FROM DZIV_T IT                       ",
               " WHERE IT.DZIV001 = '",ls_view_name,"' "
 
  PREPARE lpre_check_view_name_if_exists FROM ls_sql
  DECLARE lcur_check_view_name_if_exists CURSOR FOR lpre_check_view_name_if_exists
  OPEN lcur_check_view_name_if_exists
  FETCH lcur_check_view_name_if_exists INTO li_rec_count
  CLOSE lcur_check_view_name_if_exists
  FREE lcur_check_view_name_if_exists
  FREE lpre_check_view_name_if_exists

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi200_crud_set_view_status(p_dziv_t)
DEFINE
  p_dziv_t T_DZIV_T_WL
DEFINE  
  lo_dziv_t  T_DZIV_T_WL,
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
    DISPLAY "[Warning] Update view status unsuccess : ",SQLCA.sqlcode
  END TRY

  LET lb_return = lb_success     
    
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi200_crud_set_modify_date(p_dziv_t)
DEFINE
  p_dziv_t T_DZIV_T_WL
DEFINE  
  lo_dziv_t     T_DZIV_T_WL,
  ldt_datetime  DATETIME YEAR TO SECOND,
  lb_success    BOOLEAN
DEFINE
  lb_return  BOOLEAN

  LET lo_dziv_t.* = p_dziv_t.*
  
  LET lb_success = TRUE
  LET ldt_datetime = CURRENT YEAR TO SECOND

  TRY
  
    UPDATE DZIV_T                                 
       SET DZIVMODDT = ldt_datetime
     WHERE DZIV001 = lo_dziv_t.dziv001
       AND DZIV002 = lo_dziv_t.dziv002
       AND DZIV003 = lo_dziv_t.dziv003
       
  CATCH
    LET lb_success = FALSE
    DISPLAY "[Warning] Update view modify date unsuccess : ",SQLCA.sqlcode
  END TRY

  LET lb_return = lb_success     
    
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzi200_crud_check_if_MDMDB(p_schema_name)
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
