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

FUNCTION sadzp240_upk_get_and_untar_package(p_tar_full_path)
DEFINE
  p_tar_full_path STRING
DEFINE
  ls_working_path STRING,
  ls_tar_path     STRING,
  ls_tar_name     STRING,  
  ls_src_path     STRING,
  ls_dst_path     STRING,
  ls_os_separator STRING,
  ls_message      STRING,
  ls_TARString    STRING,
  ls_ext_name     STRING,
  ls_default_export_name STRING,
  lb_result       BOOLEAN,
  lb_success      BOOLEAN 
DEFINE
  lb_return BOOLEAN  

  LET ls_tar_path = os.Path.dirName(p_tar_full_path)
  LET ls_tar_name = os.Path.basename(p_tar_full_path)
  LET ls_default_export_name = cs_default_export_name,".",cs_default_export_ext

  LET ls_ext_name = os.path.extension(ls_tar_name)
  IF NVL(ls_ext_name,cs_null_default) <> cs_default_export_ext THEN
    LET ls_tar_path = p_tar_full_path
    LET ls_tar_name = ls_default_export_name
  END IF 

  LET lb_success = TRUE 
  
  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
   
  #建立工作目錄
  CALL sadzp240_util_making_work_directory(cs_working_dir_type_patch,TRUE,TRUE) RETURNING ls_working_path
  DISPLAY cs_information_tag,"Working Path : ",ls_working_path

  LET ls_src_path = ls_tar_path,ls_os_separator,ls_tar_name
  LET ls_dst_path = ls_working_path,ls_os_separator,ls_tar_name

  IF NOT os.Path.EXISTS(ls_src_path) THEN
    LET lb_success = FALSE
    LET ls_message = "The file '",ls_src_path,"' that you want to unpack is not exists."
    DISPLAY cs_error_tag,ls_message
    GOTO _ERROR
  END IF
  
  LET ls_message = "Moving Table file from ",ls_src_path,"\n"," TO ",ls_dst_path
  
  CALL os.Path.copy(ls_src_path,ls_dst_path) RETURNING lb_result
  
  IF NOT lb_result THEN
    LET lb_success = FALSE
    DISPLAY cs_error_tag,ls_message
    GOTO _ERROR
  ELSE
    DISPLAY cs_success_tag,ls_message
  END IF

  #Untar
  LET ls_TARString = "tar zxvf ",ls_tar_name
  RUN ls_TARString 
  
  LABEL _ERROR:  
  
  LET lb_return = lb_success

  RETURN lb_return,ls_working_path  
  
END FUNCTION 

FUNCTION sadzp240_upk_get_vfy_table_list(p_working_path)
DEFINE
  p_working_path  STRING
DEFINE 
  ls_request_no    STRING,
  ls_sequence_no   STRING,
  ls_working_path  STRING,
  ls_vfy_file      STRING,
  ls_separator     STRING,
  li_count         INTEGER,
  lb_error         BOOLEAN,
  ls_patch_no      STRING,
  lo_xml_file      xml.domDocument,
  lo_dom_node      xml.DomNode,
  lo_table_node    xml.DomNode,
  lo_dzlm_table_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lb_return  BOOLEAN,
  lo_return  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_return  STRING

  LET ls_working_path = p_working_path

  LET ls_separator = os.Path.separator()
  CALL lo_dzlm_table_list.clear()
  CALL lo_return.clear()

  LET lb_error = FALSE 

  LET ls_vfy_file = ls_working_path,ls_separator,cs_table_export_list

  LET lo_xml_file = xml.domDocument.create()
  
  TRY 
    CALL lo_xml_file.load(ls_vfy_file)
  CATCH 
    LET lb_error = TRUE
    DISPLAY cs_error_tag," Get verify file fault."
    GOTO _ERROR 
  END TRY
 
  LET lo_dom_node = lo_xml_file.getDocumentElement()
  LET ls_patch_no = lo_dom_node.getAttribute("patch_no")
  LET ls_patch_no = ls_patch_no,"T"

  LET lo_table_node = lo_dom_node.getFirstChildElement()

  LET li_count = 1  
  WHILE (lo_table_node IS NOT NULL)

    LET lo_dzlm_table_list[li_count].dtl_DZLM002    = lo_table_node.getAttribute("name") 
    LET lo_dzlm_table_list[li_count].dtl_DZLM001    = lo_table_node.getAttribute("type") 
    LET lo_dzlm_table_list[li_count].dtl_DZLM005    = lo_table_node.getAttribute("construct_version") 
    LET lo_dzlm_table_list[li_count].dtl_DZLM006    = lo_table_node.getAttribute("sd_version") 
    LET lo_dzlm_table_list[li_count].dtl_DZLM012    = lo_table_node.getAttribute("request_no") 
    LET lo_dzlm_table_list[li_count].dtl_DZLM015    = lo_table_node.getAttribute("sequence_no") 
    LET lo_dzlm_table_list[li_count].dtl_MODULE     = lo_table_node.getAttribute("module") 
    LET lo_dzlm_table_list[li_count].dtl_TABLE_TYPE = lo_table_node.getAttribute("table_type") 
    LET lo_dzlm_table_list[li_count].dtl_TAR_NAME   = lo_table_node.getAttribute("tar_name")
    LET lo_dzlm_table_list[li_count].dtl_TAR_PATH      = ""
    LET lo_dzlm_table_list[li_count].dtl_TAR_FULL_NAME = lo_table_node.getAttribute("tar_name")

    LET li_count = li_count + 1 
    
    LET lo_table_node = lo_table_node.getNextSiblingElement()
    
  END WHILE 

  LET lo_return = lo_dzlm_table_list
  LET ls_return = ls_patch_no

  LABEL _ERROR:

  LET lb_return = NOT lb_error
  
  RETURN lb_return,lo_return,ls_return
  
END FUNCTION

FUNCTION sadzp240_upk_resort_object_list(p_dzlm_object_list)
DEFINE
  p_dzlm_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_dzlm_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_temp_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  lo_sort_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_records  INTEGER,
  li_loop     INTEGER,
  lb_result   BOOLEAN
DEFINE
  lb_return  BOOLEAN,
  lo_return  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST

  LET lo_dzlm_object_list = p_dzlm_object_list

  LET li_records = lo_dzlm_object_list.getLength()
  
  CALL lo_temp_object_list.clear()

  {
  #For debug print 
  FOR li_loop = 1 TO lo_dzlm_object_list.getLength()
    DISPLAY lo_dzlm_object_list[li_loop].dtl_MODULE," ; ",lo_dzlm_object_list[li_loop].dtl_DZLM002
  END FOR 
  }
  
  #ADZ
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF lo_dzlm_object_list[li_loop].dtl_MODULE = 'ADZ' THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzp240_upk_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzp240_upk_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR

  #AZZ
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF lo_dzlm_object_list[li_loop].dtl_MODULE = 'AZZ' THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzp240_upk_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzp240_upk_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR

  #AWS
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF lo_dzlm_object_list[li_loop].dtl_MODULE = 'AWS' THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzp240_upk_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzp240_upk_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR

  #Axx
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF (lo_dzlm_object_list[li_loop].dtl_MODULE <> 'ADZ') AND
       (lo_dzlm_object_list[li_loop].dtl_MODULE <> 'AZZ') AND
       (lo_dzlm_object_list[li_loop].dtl_MODULE <> 'AWS') AND
       (lo_dzlm_object_list[li_loop].dtl_MODULE <> 'MDM') THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzp240_upk_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzp240_upk_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR
  
  #MDM放最後, 以 Table -> View -> Trigger 順序執行
  #MT
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF lo_dzlm_object_list[li_loop].dtl_MODULE = 'MDM' AND lo_dzlm_object_list[li_loop].dtl_DZLM001 = "MT" THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzp240_upk_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzp240_upk_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR

  #MV
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF lo_dzlm_object_list[li_loop].dtl_MODULE = 'MDM' AND lo_dzlm_object_list[li_loop].dtl_DZLM001 = "MV" THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzp240_upk_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzp240_upk_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR
  
  #MG
  CALL lo_sort_object_list.clear()
  FOR li_loop = 1 TO li_records
    IF lo_dzlm_object_list[li_loop].dtl_MODULE = 'MDM' AND lo_dzlm_object_list[li_loop].dtl_DZLM001 = "MG" THEN
      LET lo_sort_object_list[lo_sort_object_list.getLength() + 1].* = lo_dzlm_object_list[li_loop].*
    END IF    
  END FOR
  CALL sadzp240_upk_insert_into_sort_temp_table(lo_sort_object_list) RETURNING lb_result 
  CALL sadzp240_upk_get_sorted_object_list() RETURNING lo_sort_object_list
  FOR li_loop = 1 TO lo_sort_object_list.getLength()
    LET lo_temp_object_list[lo_temp_object_list.getLength() + 1].* = lo_sort_object_list[li_loop].*
  END FOR

  LET lo_return = lo_temp_object_list

  {
  #For debug print 
  FOR li_loop = 1 TO lo_return.getLength()
    DISPLAY lo_return[li_loop].dtl_MODULE," ; ",lo_return[li_loop].dtl_DZLM002
  END FOR 
  }
  
  RETURN lo_return
  
END FUNCTION

#建立排序 temp table
FUNCTION sadzp240_upk_crate_sort_temp_table()

  CREATE TEMP TABLE adzp240_sort
  (
    WORK_TYPE	    VARCHAR(10),
    DZLM001	      VARCHAR(10),
    DZLM002	      VARCHAR(20),
    DZLM005	      VARCHAR(10),
    DZLM006	      VARCHAR(10),
    DZLM012	      VARCHAR(20),
    DZLM015	      VARCHAR(40),
    MODULE        VARCHAR(10),
    TABLE_TYPE    VARCHAR(10),
    TAR_NAME      VARCHAR(100),
    TAR_PATH      VARCHAR(250),
    TAR_FULL_NAME VARCHAR(500)
  )
  
END FUNCTION

FUNCTION sadzp240_upk_drop_sort_temp_table()

  DROP TABLE adzp240_sort
  
END FUNCTION

FUNCTION sadzp240_upk_insert_into_sort_temp_table(p_dzlm_object_list)
DEFINE
  p_dzlm_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE
  lo_dzlm_object_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_object_count      INTEGER,
  li_loop              INTEGER 
DEFINE
  lb_return BOOLEAN

  LET lo_dzlm_object_list = p_dzlm_object_list

  LET li_object_count = lo_dzlm_object_list.getLength()
  LET lb_return = TRUE

  BEGIN WORK 
  DELETE FROM adzp240_sort
  COMMIT WORK 

  BEGIN WORK 

  TRY 
    FOR li_loop = 1 TO li_object_count
      INSERT INTO adzp240_sort 
        (
          WORK_TYPE,
          DZLM001,
          DZLM002,
          DZLM005,
          DZLM006,
          DZLM012,
          DZLM015,
          MODULE,
          TABLE_TYPE,
          TAR_NAME,
          TAR_PATH,
          TAR_FULL_NAME
        )
      VALUES
        (
          lo_dzlm_object_list[li_loop].dtl_WORK_TYPE,	   
          lo_dzlm_object_list[li_loop].dtl_DZLM001,	     
          lo_dzlm_object_list[li_loop].dtl_DZLM002,	     
          lo_dzlm_object_list[li_loop].dtl_DZLM005,	     
          lo_dzlm_object_list[li_loop].dtl_DZLM006,	     
          lo_dzlm_object_list[li_loop].dtl_DZLM012,	     
          lo_dzlm_object_list[li_loop].dtl_DZLM015,	     
          lo_dzlm_object_list[li_loop].dtl_MODULE,       
          lo_dzlm_object_list[li_loop].dtl_TABLE_TYPE,   
          lo_dzlm_object_list[li_loop].dtl_TAR_NAME,     
          lo_dzlm_object_list[li_loop].dtl_TAR_PATH,     
          lo_dzlm_object_list[li_loop].dtl_TAR_FULL_NAME
        )  
    END FOR
    
    COMMIT WORK
  CATCH 
    LET lb_return = FALSE
    ROLLBACK WORK
  END TRY   
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp240_upk_get_sorted_object_list()
DEFINE
  lo_dzlm_object_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_sql              STRING,
  li_rec_cnt          INTEGER
DEFINE
  lo_result DYNAMIC ARRAY OF T_DZLM_TABLE_LIST

  LET ls_sql = "SELECT WORK_TYPE,DZLM001,DZLM002,DZLM005,DZLM006,   ",
               "       DZLM012,DZLM015,MODULE, TABLE_TYPE,TAR_NAME, ",
               "       TAR_PATH,TAR_FULL_NAME                       ",
               "  FROM ADZP240_SORT                                 ",
               " ORDER BY MODULE,DZLM002                            " 
  
  PREPARE lpre_get_sorted_object_list FROM ls_sql
  DECLARE lcur_get_sorted_object_list CURSOR FOR lpre_get_sorted_object_list

  LET li_rec_cnt = 1 
  
  OPEN lcur_get_sorted_object_list
  FOREACH lcur_get_sorted_object_list INTO lo_dzlm_object_list[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CLOSE lcur_get_sorted_object_list

  CALL lo_dzlm_object_list.deleteElement(li_rec_cnt)
  
  FREE lpre_get_sorted_object_list
  FREE lcur_get_sorted_object_list  

  LET lo_result = lo_dzlm_object_list
  
  RETURN lo_result
  
END FUNCTION
