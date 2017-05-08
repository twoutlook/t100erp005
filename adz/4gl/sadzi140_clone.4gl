&include "../4gl/sadzi140_mcr.inc"

IMPORT os
IMPORT util

SCHEMA ds

&include "../4gl/sadzi140_cnst.inc"

&include "../4gl/sadzi140_type.inc"

&ifndef DEBUG
GLOBALS "../../cfg/top_global.inc"
&endif

DEFINE ms_lang STRING 

DEFINE m_common_fields DYNAMIC ARRAY WITH DIMENSION 2 OF VARCHAR(50)

FUNCTION sadzi140_clone_start(p_src_table,p_dest_table)
DEFINE 
  p_src_table, p_dest_table STRING 
DEFINE 
  ls_src_table, ls_dest_table STRING,
  lo_column_src_data     DYNAMIC ARRAY OF T_DZEB_T,
  lo_column_spec_data    DYNAMIC ARRAY OF T_DZEP_T,
  lo_key_src_data        DYNAMIC ARRAY OF T_DZED_T,
  lo_index_src_data      DYNAMIC ARRAY OF T_DZEC_T,
  lo_multi_lang_src_data DYNAMIC ARRAY OF T_DZER_T,
  lo_tree_src_data       DYNAMIC ARRAY OF T_DZEQ_T,
  lo_column_ref_data     DYNAMIC ARRAY OF T_DZEF_T,
  lo_state_code_data     DYNAMIC ARRAY OF T_GZCC_T,
  lb_exist_foreign_key   BOOLEAN,
  li_loop    INTEGER,
  lb_success BOOLEAN 
DEFINE
  lb_return BOOLEAN   

  LET ls_src_table  = p_src_table 
  LET ls_dest_table = p_dest_table

  LET lb_success = TRUE
  LET lb_exist_foreign_key = FALSE
  
  &ifndef DEBUG
  LET ms_lang = g_lang
  &else
  LET ms_lang = cs_default_lang
  &endif  

  #取得DZEF要用到的共用欄位設定
  CALL sadzi140_util_get_common_fields(m_common_fields)
  
  #先取得原始表格的相關資料
  CALL sadzi140_clone_get_column_src_data(ls_src_table,ls_dest_table) RETURNING lo_column_src_data
  CALL sadzi140_clone_get_column_spec_data(ls_src_table,ls_dest_table) RETURNING lo_column_spec_data
  CALL sadzi140_clone_get_key_src_data(ls_src_table,ls_dest_table) RETURNING lo_key_src_data
  CALL sadzi140_clone_get_index_src_data(ls_src_table,ls_dest_table) RETURNING lo_index_src_data
  CALL sadzi140_clone_get_column_ref_data(ls_src_table,ls_dest_table) RETURNING lo_column_ref_data
  CALL sadzi140_clone_get_multi_lang_src_data(ls_src_table,ls_dest_table) RETURNING lo_multi_lang_src_data
  CALL sadzi140_clone_get_tree_src_data(ls_src_table,ls_dest_table) RETURNING lo_tree_src_data
  CALL sadzi140_clone_get_state_code_data(ls_src_table,ls_dest_table) RETURNING lo_state_code_data
  
  #開始將資料匯入
  BEGIN WORK
  
  FOR li_loop = 1 TO lo_column_src_data.getLength()
    #新增到 DZEB_T 中
    CALL sadzi140_crud_insert_update_dzeb_t(lo_column_src_data[li_loop].*)
    #新增欄位多語言資料
    CALL sadzi140_crud_insert_update_dzebl_t(lo_column_src_data[li_loop].*,ms_lang)
  END FOR 
  IF NOT lb_success THEN GOTO _clone_error END IF 
  
  FOR li_loop = 1 TO lo_column_spec_data.getLength()
    #將欄位規格資料匯入
    CALL sadzi140_crud_clone_dzep_t(lo_column_spec_data[li_loop].*)
  END FOR 
  IF NOT lb_success THEN GOTO _clone_error END IF
  
  FOR li_loop = 1 TO lo_column_ref_data.getLength()
    #將欄位參考資料匯入
    CALL sadzi140_crud_clone_dzef_t(lo_column_ref_data[li_loop].*)
  END FOR 
  IF NOT lb_success THEN GOTO _clone_error END IF 

  FOR li_loop = 1 TO lo_key_src_data.getLength()
    #判斷複製的表是否有Foreign Key, 有則提醒
    IF lo_key_src_data[li_loop].dzed003 = "R" THEN
      LET lb_exist_foreign_key = TRUE
    END IF 
    #將鍵值資料匯入
    CALL sadzi140_crud_insert_update_dzed_t(lo_key_src_data[li_loop].*)
  END FOR 
  IF NOT lb_success THEN GOTO _clone_error END IF 

  FOR li_loop = 1 TO lo_index_src_data.getLength()
    #將索引資料匯入
    CALL sadzi140_crud_insert_update_dzec_t(lo_index_src_data[li_loop].*)
  END FOR 
  IF NOT lb_success THEN GOTO _clone_error END IF 

  FOR li_loop = 1 TO lo_multi_lang_src_data.getLength()
    #將資料多語言設定匯入
    CALL sadzi140_crud_insert_update_dzer_t(lo_multi_lang_src_data[li_loop].*)
  END FOR   
  IF NOT lb_success THEN GOTO _clone_error END IF 

  FOR li_loop = 1 TO lo_tree_src_data.getLength()
    #將樹狀結構設定匯入
    CALL sadzi140_crud_insert_update_dzeq_t(lo_tree_src_data[li_loop].*)
  END FOR   
  IF NOT lb_success THEN GOTO _clone_error END IF 
  
  FOR li_loop = 1 TO lo_state_code_data.getLength()
    #將狀態碼設定匯入
    CALL sadzi140_crud_clone_gzcc_t(lo_state_code_data[li_loop].*)
  END FOR   
  IF NOT lb_success THEN GOTO _clone_error END IF
  
  LABEL _clone_error:
  
  IF NOT lb_success THEN
    ROLLBACK WORK 
  ELSE 
    COMMIT WORK
  END IF
  
  LET lb_return = lb_success
    
  RETURN lb_return, lb_exist_foreign_key 

END FUNCTION 

FUNCTION sadzi140_clone_get_column_src_data(p_src_table,p_dest_table)
DEFINE
  p_src_table  STRING,
  p_dest_table STRING
DEFINE  
  ls_src_table         STRING,
  ls_dest_table        STRING,
  ls_src_leading_code  STRING,
  ls_dest_leading_code STRING,
  ls_DGENV             STRING, 
  lo_column_src_data   DYNAMIC ARRAY OF T_DZEB_T
DEFINE  
  ls_SQL     STRING,
  li_RecCnt  INTEGER,
  lo_RETURN  DYNAMIC ARRAY OF T_DZEB_T

  LET ls_src_table  = p_src_table
  LET ls_dest_table = p_dest_table

  LET ls_DGENV = FGL_GETENV("DGENV")

  CALL sadzi140_util_get_table_leading_code(ls_src_table) RETURNING ls_src_leading_code
  CALL sadzi140_util_get_table_leading_code(ls_dest_table) RETURNING ls_dest_leading_code
  
  INITIALIZE lo_column_src_data TO NULL
  INITIALIZE lo_RETURN TO NULL
  
  LET ls_SQL = " SELECT '','','',                                                                      ",
               "        REPLACE(DZEB001,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEB001, ",
               "        REPLACE(DZEB002,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEB002, ",
               "        DZEBL003 DZEB003,                                                              ", #20160901 modify
               "        DZEB004,                                                                       ",
               "        DZEB005,                                                                       ",
               "        DZEB006,                                                                       ",
               "        '' DZEB006_DESC,                                                               ",
               "        DZEB007,                                                                       ",
               "        DZEB008,                                                                       ",
               "        DZEB012,                                                                       ",
               "        DZEB021,                                                                       ",
               "        DZEB022,                                                                       ",
               "        DZEB023,                                                                       ",
               "        DZEB024,                                                                       ",
               "        DZEB027,                                                                       ",
               "        'N' DZEB028,                                                                   ",
               "        '",ls_DGENV,"' DZEB029,                                                        ",
               "        '",ls_DGENV,"' DZEB030,                                                        ",
               "        'N'            DZEB031,                                                        ",
               "        ''             DZEB002_ORIG,                                                   ",
               "        ''             DZEP012,                                                        ",
               "        ''             CATEGORY,                                                       ",
               "        '",cs_lang_modified,"'  LANG_MODIFIED                                          ",
               "   FROM DZEB_T                                                                         ",
               "   LEFT OUTER JOIN DZEBL_T ON DZEBL001 = DZEB002                                       ", #20160901 begin
               "                          AND DZEBL002 = '",ms_lang,"'                                 ", #20160901 end
               "  WHERE DZEB001 = '",ls_src_table,"'                                                   "

  PREPARE lpre_get_column_src_data FROM ls_SQL
  DECLARE lcur_get_column_src_data CURSOR FOR lpre_get_column_src_data

  LET li_RecCnt = 1 
  
  OPEN lcur_get_column_src_data
  FOREACH lcur_get_column_src_data INTO lo_column_src_data[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_get_column_src_data
  CALL lo_column_src_data.deleteElement(li_RecCnt)
  
  FREE lpre_get_column_src_data
  FREE lcur_get_column_src_data  

  LET lo_RETURN.* = lo_column_src_data.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzi140_clone_get_key_src_data(p_src_table,p_dest_table)
DEFINE
  p_src_table  STRING,
  p_dest_table STRING
DEFINE  
  ls_src_table  STRING,
  ls_dest_table STRING,
  ls_src_leading_code  STRING,
  ls_dest_leading_code STRING,
  ls_DGENV        STRING,
  lo_key_src_data DYNAMIC ARRAY OF T_DZED_T
DEFINE  
  ls_SQL     STRING,
  li_RecCnt  INTEGER,
  lo_RETURN  DYNAMIC ARRAY OF T_DZED_T

  LET ls_src_table  = p_src_table
  LET ls_dest_table = p_dest_table

  LET ls_DGENV = FGL_GETENV("DGENV")

  CALL sadzi140_util_get_table_leading_code(ls_src_table) RETURNING ls_src_leading_code
  CALL sadzi140_util_get_table_leading_code(ls_dest_table) RETURNING ls_dest_leading_code
  
  INITIALIZE lo_key_src_data TO NULL
  INITIALIZE lo_RETURN TO NULL
  
  LET ls_SQL = "SELECT '',                                                                            ",
               "       REPLACE(DZED001,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZED001, ",
               "       REPLACE(DZED002,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZED002, ",
               "       DZED003,                                                                       ",
               "       REPLACE(DZED004,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZED004, ",
               "       DZED005,                                                                       ",
               "       DZED006,                                                                       ",
               "       'N' DZED007,                                                                   ",
               "       '",ls_DGENV,"' DZED008,                                                        ",                   
               "       '",ls_DGENV,"' DZED009,                                                        ",                   
               "       'N' DZED010,                                                                   ",
               "       ''                                                                             ",
               "  FROM DZED_T                                                                         ",
               " WHERE DZED001 = '",ls_src_table,"'                                                   "
   
  PREPARE lpre_get_key_src_data FROM ls_SQL
  DECLARE lcur_get_key_src_data CURSOR FOR lpre_get_key_src_data

  LET li_RecCnt = 1 
  
  OPEN lcur_get_key_src_data
  FOREACH lcur_get_key_src_data INTO lo_key_src_data[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_get_key_src_data
  CALL lo_key_src_data.deleteElement(li_RecCnt)
  
  FREE lpre_get_key_src_data
  FREE lcur_get_key_src_data  

  LET lo_RETURN.* = lo_key_src_data.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzi140_clone_get_index_src_data(p_src_table,p_dest_table)
DEFINE
  p_src_table  STRING,
  p_dest_table STRING
DEFINE  
  ls_src_table  STRING,
  ls_dest_table STRING,
  ls_src_leading_code  STRING,
  ls_dest_leading_code STRING,
  ls_DGENV          STRING,
  lo_index_src_data DYNAMIC ARRAY OF T_DZEC_T
DEFINE  
  ls_SQL     STRING,
  li_RecCnt  INTEGER,
  lo_RETURN  DYNAMIC ARRAY OF T_DZEC_T

  LET ls_src_table  = p_src_table
  LET ls_dest_table = p_dest_table

  LET ls_DGENV = FGL_GETENV("DGENV")
  
  CALL sadzi140_util_get_table_leading_code(ls_src_table) RETURNING ls_src_leading_code
  CALL sadzi140_util_get_table_leading_code(ls_dest_table) RETURNING ls_dest_leading_code
  
  INITIALIZE lo_index_src_data TO NULL
  INITIALIZE lo_RETURN TO NULL
  
  LET ls_SQL = "SELECT '',                                                                            ",
               "       REPLACE(DZEC001,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEC001, ",
               "       REPLACE(DZEC002,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEC002, ",
               "       DZEC003,                                                                       ",
               "       REPLACE(DZEC004,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEC004, ",
               "       'N' DZEC005,                                                                   ",
               "       '",ls_DGENV,"' DZEC006,                                                        ",
               "       '",ls_DGENV,"' DZEC007,                                                        ",
               "       'N' DZEC008,                                                                   ",                          
               "       ''                                                                             ",
               "  FROM DZEC_T                                                                         ",
               " WHERE DZEC001 = '",ls_src_table,"'                                                   "
   
  PREPARE lpre_get_index_src_data FROM ls_SQL
  DECLARE lcur_get_index_src_data CURSOR FOR lpre_get_index_src_data

  LET li_RecCnt = 1 
  
  OPEN lcur_get_index_src_data
  FOREACH lcur_get_index_src_data INTO lo_index_src_data[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_get_index_src_data
  CALL lo_index_src_data.deleteElement(li_RecCnt)
  
  FREE lpre_get_index_src_data
  FREE lcur_get_index_src_data  

  LET lo_RETURN.* = lo_index_src_data.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzi140_clone_get_multi_lang_src_data(p_src_table,p_dest_table)
DEFINE
  p_src_table  STRING,
  p_dest_table STRING
DEFINE  
  ls_src_table  STRING,
  ls_dest_table STRING,
  ls_src_leading_code  STRING,
  ls_dest_leading_code STRING,
  lo_multi_lang_src_data DYNAMIC ARRAY OF T_DZER_T
DEFINE  
  ls_SQL     STRING,
  li_RecCnt  INTEGER,
  lo_RETURN  DYNAMIC ARRAY OF T_DZER_T

  LET ls_src_table  = p_src_table
  LET ls_dest_table = p_dest_table

  CALL sadzi140_util_get_table_leading_code(ls_src_table) RETURNING ls_src_leading_code
  CALL sadzi140_util_get_table_leading_code(ls_dest_table) RETURNING ls_dest_leading_code
  
  INITIALIZE lo_multi_lang_src_data TO NULL
  INITIALIZE lo_RETURN TO NULL
  
  LET ls_SQL = "SELECT '',                                                                            ",
               "       REPLACE(DZER001,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZER001, ",
               "       REPLACE(DZER002,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZER002, ",
               "       DZER003,                                                                       ",
               "       REPLACE(DZER004,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZER004, ",
               "       REPLACE(DZER005,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZER005, ",
               "       REPLACE(DZER006,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZER006, ",
               "       REPLACE(DZER007,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZER007, ",
               "       REPLACE(DZER008,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZER008  ",
               "  FROM DZER_T                                                                         ",
               " WHERE DZER001 = '",ls_src_table,"'                                                   "
   
  PREPARE lpre_get_multi_lang_src_data FROM ls_SQL
  DECLARE lcur_get_multi_lang_src_data CURSOR FOR lpre_get_multi_lang_src_data

  LET li_RecCnt = 1 
  
  OPEN lcur_get_multi_lang_src_data
  FOREACH lcur_get_multi_lang_src_data INTO lo_multi_lang_src_data[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_get_multi_lang_src_data
  CALL lo_multi_lang_src_data.deleteElement(li_RecCnt)
  
  FREE lpre_get_multi_lang_src_data
  FREE lcur_get_multi_lang_src_data  

  LET lo_RETURN.* = lo_multi_lang_src_data.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzi140_clone_get_tree_src_data(p_src_table,p_dest_table)
DEFINE
  p_src_table  STRING,
  p_dest_table STRING
DEFINE  
  ls_src_table  STRING,
  ls_dest_table STRING,
  ls_src_leading_code  STRING,
  ls_dest_leading_code STRING,
  lo_tree_src_data DYNAMIC ARRAY OF T_DZEQ_T
DEFINE  
  ls_SQL     STRING,
  li_RecCnt  INTEGER,
  lo_RETURN  DYNAMIC ARRAY OF T_DZEQ_T

  LET ls_src_table  = p_src_table
  LET ls_dest_table = p_dest_table

  CALL sadzi140_util_get_table_leading_code(ls_src_table) RETURNING ls_src_leading_code
  CALL sadzi140_util_get_table_leading_code(ls_dest_table) RETURNING ls_dest_leading_code
  
  INITIALIZE lo_tree_src_data TO NULL
  INITIALIZE lo_RETURN TO NULL
  
  LET ls_SQL = "SELECT '',                                                                            ",
               "       REPLACE(DZEQ001,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEQ001, ",
               "       DZEQ002,                                                                       ",
               "       DZEQ003,                                                                       ",
               "       DZEQ004,                                                                       ",
               "       DZEQ005,                                                                       ",
               "       DZEQ006,                                                                       ",
               "       DZEQ007,                                                                       ",
               "       REPLACE(DZEQ008,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEQ008, ",
               "       REPLACE(DZEQ009,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEQ009  ",
               "  FROM DZEQ_T                                                                         ",
               " WHERE DZEQ001 = '",ls_src_table,"'                                                   "
   
  PREPARE lpre_get_tree_src_data FROM ls_SQL
  DECLARE lcur_get_tree_src_data CURSOR FOR lpre_get_tree_src_data

  LET li_RecCnt = 1 
  
  OPEN lcur_get_tree_src_data
  FOREACH lcur_get_tree_src_data INTO lo_tree_src_data[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_get_tree_src_data
  CALL lo_tree_src_data.deleteElement(li_RecCnt)
  
  FREE lpre_get_tree_src_data
  FREE lcur_get_tree_src_data  

  LET lo_RETURN.* = lo_tree_src_data.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzi140_clone_get_column_spec_data(p_src_table,p_dest_table)
DEFINE
  p_src_table  STRING,
  p_dest_table STRING
DEFINE  
  ls_src_table         STRING,
  ls_dest_table        STRING,
  ls_src_leading_code  STRING,
  ls_dest_leading_code STRING,
  lo_column_spec_data  DYNAMIC ARRAY OF T_DZEP_T
DEFINE  
  ls_SQL     STRING,
  li_RecCnt  INTEGER,
  lo_RETURN  DYNAMIC ARRAY OF T_DZEP_T

  LET ls_src_table  = p_src_table
  LET ls_dest_table = p_dest_table

  CALL sadzi140_util_get_table_leading_code(ls_src_table) RETURNING ls_src_leading_code
  CALL sadzi140_util_get_table_leading_code(ls_dest_table) RETURNING ls_dest_leading_code
  
  INITIALIZE lo_column_spec_data TO NULL
  INITIALIZE lo_RETURN TO NULL
  
  LET ls_SQL = "SELECT '',                                                                            ",
               "       REPLACE(DZEP001,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEP001, ",
               "       REPLACE(DZEP002,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEP002, ",
               "       DZEP003,                                                                       ",
               "       DZEP004,                                                                       ",
               "       DZEP005,                                                                       ",
               "       DZEP006,                                                                       ",
               "       DZEP007,                                                                       ",
               "       DZEP008,                                                                       ",
               "       DZEP009,                                                                       ",
               "       DZEP010,                                                                       ",
               "       DZEP011,                                                                       ",
               "       DZEP012,                                                                       ",
               "       DZEP013,                                                                       ",
               "       DZEP014,                                                                       ",
               "       DZEP015,                                                                       ",
               "       DZEP016,                                                                       ",
               "       DZEP017,                                                                       ",
               "       DZEP018,                                                                       ",
               "       DZEP019,                                                                       ",
               "       DZEP020,                                                                       ",
               "       DZEP021,                                                                       ",
               "       DZEP022,                                                                       ",
               "       DZEP023,                                                                       ",
               "       DZEP024,                                                                       ",
               "       DZEP025,                                                                       ",
               "       DZEP026,                                                                       ",
               "       DZEP027,                                                                       ",
               "       DZEP028                                                                        ",
               "  FROM DZEP_T                                                                         ",
               " WHERE DZEP001 = '",ls_src_table,"'                                                   "

  PREPARE lpre_get_column_spec_data FROM ls_SQL
  DECLARE lcur_get_column_spec_data CURSOR FOR lpre_get_column_spec_data

  LET li_RecCnt = 1 
  
  OPEN lcur_get_column_spec_data
  FOREACH lcur_get_column_spec_data INTO lo_column_spec_data[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_get_column_spec_data
  CALL lo_column_spec_data.deleteElement(li_RecCnt)
  
  FREE lpre_get_column_spec_data
  FREE lcur_get_column_spec_data  

  LET lo_RETURN.* = lo_column_spec_data.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzi140_clone_get_column_ref_data(p_src_table,p_dest_table)
DEFINE
  p_src_table  STRING,
  p_dest_table STRING
DEFINE  
  ls_src_table         STRING,
  ls_dest_table        STRING,
  ls_src_leading_code  STRING,
  ls_dest_leading_code STRING,
  lo_column_ref_data   DYNAMIC ARRAY OF T_DZEF_T
DEFINE  
  ls_SQL     STRING,
  li_RecCnt  INTEGER,
  lo_RETURN  DYNAMIC ARRAY OF T_DZEF_T

  LET ls_src_table  = p_src_table
  LET ls_dest_table = p_dest_table

  CALL sadzi140_util_get_table_leading_code(ls_src_table) RETURNING ls_src_leading_code
  CALL sadzi140_util_get_table_leading_code(ls_dest_table) RETURNING ls_dest_leading_code
  
  INITIALIZE lo_column_ref_data TO NULL
  INITIALIZE lo_RETURN TO NULL
  
  LET ls_SQL = "SELECT '',                                                                            ",
               "       REPLACE(DZEF001,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEF001, ",
               "       REPLACE(DZEF002,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEF002, ",
               "       REPLACE(DZEF003,'",ls_src_leading_code,"','",ls_dest_leading_code,"') DZEF003, ",
               "       DZEF004,                                                                       ",
               "       DZEF005,                                                                       ",
               "       DZEF006,                                                                       ",
               "       DZEF007,                                                                       ",
               "       DZEF008,                                                                       ",
               "       DZEF009,                                                                       ",
               "       DZEF010                                                                        ",
               "  FROM DZEF_T                                                                         ",
               " WHERE DZEF001 = '",ls_src_table,"'                                                   "

  PREPARE lpre_get_column_ref_data FROM ls_SQL
  DECLARE lcur_get_column_ref_data CURSOR FOR lpre_get_column_ref_data

  LET li_RecCnt = 1 
  
  OPEN lcur_get_column_ref_data
  FOREACH lcur_get_column_ref_data INTO lo_column_ref_data[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_get_column_ref_data
  CALL lo_column_ref_data.deleteElement(li_RecCnt)
  
  FREE lpre_get_column_ref_data
  FREE lcur_get_column_ref_data  

  LET lo_RETURN.* = lo_column_ref_data.* 
  
  RETURN lo_RETURN
  
END FUNCTION

FUNCTION sadzi140_clone_get_state_code_data(p_src_table,p_dest_table)
DEFINE
  p_src_table  STRING,
  p_dest_table STRING
DEFINE  
  ls_src_table         STRING,
  ls_dest_table        STRING,
  ls_src_leading_code  STRING,
  ls_dest_leading_code STRING,
  lo_state_code_data   DYNAMIC ARRAY OF T_GZCC_T
DEFINE  
  ls_SQL     STRING,
  li_RecCnt  INTEGER,
  lo_RETURN  DYNAMIC ARRAY OF T_GZCC_T

  LET ls_src_table  = p_src_table
  LET ls_dest_table = p_dest_table

  CALL sadzi140_util_get_table_leading_code(ls_src_table) RETURNING ls_src_leading_code
  CALL sadzi140_util_get_table_leading_code(ls_dest_table) RETURNING ls_dest_leading_code
  
  INITIALIZE lo_state_code_data TO NULL
  INITIALIZE lo_RETURN TO NULL
  
  LET ls_SQL = "SELECT REPLACE(GZCC001,'",ls_src_leading_code,"','",ls_dest_leading_code,"') GZCC001, ",
               "       REPLACE(GZCC002,'",ls_src_leading_code,"','",ls_dest_leading_code,"') GZCC002, ",
               "       GZCC003,                                                                       ",
               "       GZCC004,                                                                       ",
               "       GZCC005,                                                                       ",
               "       GZCC006,                                                                       ",
               "       GZCCSTUS                                                                       ",
               "  FROM GZCC_T                                                                         ",
               " WHERE GZCC001 = '",ls_src_table,"'                                                   "

  PREPARE lpre_get_state_code_data FROM ls_SQL
  DECLARE lcur_get_state_code_data CURSOR FOR lpre_get_state_code_data

  LET li_RecCnt = 1 
  
  OPEN lcur_get_state_code_data
  FOREACH lcur_get_state_code_data INTO lo_state_code_data[li_RecCnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_RecCnt = li_RecCnt + 1

  END FOREACH
  CLOSE lcur_get_state_code_data
  CALL lo_state_code_data.deleteElement(li_RecCnt)
  
  FREE lpre_get_state_code_data
  FREE lcur_get_state_code_data  

  LET lo_RETURN.* = lo_state_code_data.* 
  
  RETURN lo_RETURN
  
END FUNCTION