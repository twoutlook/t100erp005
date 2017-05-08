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

FUNCTION sadzp240_pk_collect_and_pack(p_patch_path,p_working_path,p_dzlm_table_list,p_patch_no)
DEFINE
  p_patch_path      STRING,
  p_working_path    STRING,
  p_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  p_patch_no        STRING 
DEFINE
  ls_patch_path       STRING,
  ls_working_path     STRING,
  lo_dzlm_table_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_patch_no         STRING, 
  lo_pack_info        T_DZLM_TABLE_LIST,
  lo_sub_table_list   DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  li_table_per_pack   INTEGER,
  li_pack_serial_no   INTEGER,  
  ls_pack_serial_no   STRING,  
  li_list_cnt         INTEGER,
  li_table_count      INTEGER,
  ls_sub_pack_name    STRING,
  ls_sub_pack_path    STRING,
  ls_os_separator     STRING,
  ls_tar_file_name    STRING,
  li_list_count       INTEGER,
  ls_task_path        STRING,  
  lo_tar_list         DYNAMIC ARRAY OF T_TAR_LIST,
  lb_result           BOOLEAN,
  lb_success          BOOLEAN 
DEFINE
  lb_return BOOLEAN,
  ls_return STRING,
  lo_return DYNAMIC ARRAY OF T_TAR_LIST

  LET ls_patch_path      = p_patch_path
  LET ls_working_path    = p_working_path
  LET lo_dzlm_table_list = p_dzlm_table_list
  LET ls_patch_no        = p_patch_no

  LET lb_result  = TRUE
  LET lb_success = TRUE
  
  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  #取得子包工作路徑
  CALL sadzp240_util_making_work_directory(cs_working_dir_type_subpkg,TRUE,TRUE) RETURNING ls_task_path

  #取得每包子包裝要放多少表格
  LET li_table_per_pack = sadzp240_util_get_parameter(cs_param_level_pack,cs_param_table_per_package)
  #初始化子包序號
  LET li_pack_serial_no = 0
  LET li_table_count = 0

  INITIALIZE lo_tar_list TO NULL
      
  #開始建立子包
  FOR li_list_cnt = 1 TO lo_dzlm_table_list.getLength()

    #建立子包路徑
    IF (li_table_count >= li_table_per_pack) OR (li_table_count = 0) THEN
      LET li_table_count = 0
      LET li_pack_serial_no = li_pack_serial_no + 1
      LET ls_pack_serial_no = li_pack_serial_no
      LET ls_sub_pack_name = ls_patch_no,"_",ls_pack_serial_no.trim()
      LET ls_sub_pack_path = ls_working_path,ls_os_separator,ls_sub_pack_name
      CALL sadzp240_util_making_work_directory(ls_sub_pack_path,FALSE,FALSE) RETURNING ls_sub_pack_path 
      INITIALIZE lo_sub_table_list TO NULL
    END IF 

    LET li_table_count = li_table_count + 1

    #將Table包移到子包路徑中
    CALL sadzp240_pk_copy_sub_pack_to_pack_dir(ls_working_path,ls_sub_pack_path,lo_dzlm_table_list[li_list_cnt].*) RETURNING lb_result
    IF NOT lb_result THEN LET lb_success = FALSE END IF
    #建立子包vfy檔案
    LET lo_sub_table_list[li_table_count].* = lo_dzlm_table_list[li_list_cnt].*
    #如果子包數已經達最大表格數或者已到最後一筆, 則拆包
    IF (li_table_count >= li_table_per_pack) OR (li_list_cnt = lo_dzlm_table_list.getLength()) THEN
      CALL sadzp240_pk_generate_verify_file(ls_sub_pack_name,ls_sub_pack_path,lo_sub_table_list)
      CALL sadzp240_pk_tar_sub_pack_files(ls_sub_pack_name) RETURNING ls_tar_file_name
      CALL sadzp240_pk_copy_sub_pack_to_task_dir(ls_sub_pack_path,ls_task_path,ls_tar_file_name) RETURNING lb_result
      IF lb_result THEN 
        LET li_list_count = lo_tar_list.getLength()+1
        LET lo_tar_list[li_list_count].tl_SEQ_NO   = ls_pack_serial_no #ls_tar_file_name.subString(ls_tar_file_name.getIndexOf("_",1)+1,ls_tar_file_name.getIndexOf(cs_default_export_ext,1)-2)
        LET lo_tar_list[li_list_count].tl_TAR_NAME = ls_tar_file_name
      END IF  
    END IF   

  END FOR

  LET lb_return = lb_result
  LET ls_return = ls_task_path
  LET lo_return = lo_tar_list

  RETURN lb_return,ls_return,lo_return
  
END FUNCTION 

FUNCTION sadzp240_pk_copy_sub_pack_to_task_dir(p_src_path,p_dst_path,p_tar_name)
DEFINE
  p_src_path  STRING,
  p_dst_path  STRING,
  p_tar_name  STRING
DEFINE
  ls_src_path  STRING,
  ls_dst_path  STRING,
  ls_tar_name  STRING,
  ls_src_path_name  STRING,
  ls_dst_path_name  STRING,
  ls_os_separator   STRING
DEFINE  
  lb_result BOOLEAN  
  
  LET ls_src_path = p_src_path
  LET ls_dst_path = p_dst_path
  LET ls_tar_name = p_tar_name

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  #將子包複製回原母包的路徑
  LET ls_src_path_name = ls_src_path,ls_os_separator,ls_tar_name
  LET ls_dst_path_name = ls_dst_path,ls_os_separator,ls_tar_name
  
  CALL os.Path.copy(ls_src_path_name,ls_dst_path_name) RETURNING lb_result

  RETURN lb_result
  
END FUNCTION 

FUNCTION sadzp240_pk_copy_sub_pack_to_pack_dir(p_working_path,p_sub_pack_path,p_pack_info)
DEFINE
  p_working_path  STRING,
  p_sub_pack_path STRING,
  p_pack_info     T_DZLM_TABLE_LIST
DEFINE
  ls_working_path   STRING,
  ls_sub_pack_path  STRING,
  lo_pack_info      T_DZLM_TABLE_LIST,
  ls_tar_name       STRING,
  ls_src_path_name  STRING,
  ls_dst_path_name  STRING,
  ls_os_separator   STRING
DEFINE
  lb_result BOOLEAN  

  LET ls_working_path   = p_working_path
  LET ls_sub_pack_path  = p_sub_pack_path
  LET lo_pack_info.*    = p_pack_info.*

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator

  IF lo_pack_info.dtl_TAR_NAME IS NOT NULL THEN 
    LET ls_tar_name = lo_pack_info.dtl_TAR_NAME
  ELSE
    LET ls_tar_name = lo_pack_info.dtl_DZLM002,"+TABLE+",
                      lo_pack_info.dtl_DZLM012,"+",
                      (lo_pack_info.dtl_DZLM015 USING cs_UsingFormat),".tdi"
  END IF                    

  LET ls_src_path_name = ls_working_path,ls_os_separator,ls_tar_name                      
  LET ls_dst_path_name = ls_sub_pack_path,ls_os_separator,ls_tar_name       

  CALL os.Path.copy(ls_src_path_name,ls_dst_path_name) RETURNING lb_result

  RETURN lb_result
  
END FUNCTION

FUNCTION sadzp240_pk_generate_verify_file(p_patch_no,p_temp_path,p_dzlm_table_list)
DEFINE
  p_patch_no         STRING,
  p_temp_path        STRING,
  p_dzlm_table_list  DYNAMIC ARRAY OF T_DZLM_TABLE_LIST
DEFINE 
  ls_patch_no        STRING,
  ls_temp_path       STRING,
  lo_dzlm_table_list DYNAMIC ARRAY OF T_DZLM_TABLE_LIST,
  ls_vfy_filename    STRING,
  ls_separator       STRING,
  ls_tar_name        STRING,
  li_table_list_cnt  INTEGER,
  li_table_cnt       INTEGER,
  li_exp_cnt         INTEGER,
  ls_temp_name       STRING,
  lo_xml_tap_document  xml.DomDocument,
  lo_xml_exp_elements  xml.DomNode,
  lo_exp_node_xml      xml.DomNode

  LET ls_patch_no        = p_patch_no
  LET ls_temp_path       = p_temp_path
  LET lo_dzlm_table_list = p_dzlm_table_list
  
  LET ls_separator = os.Path.separator()

  LET ls_vfy_filename = ls_temp_path,ls_separator,cs_table_export_list
  
  #產出 XML 標頭
  LET lo_xml_tap_document = xml.DomDocument.CreateDocument("export")
  LET lo_xml_exp_elements = lo_xml_tap_document.getDocumentElement()
  CALL lo_xml_exp_elements.setAttribute("patch_no",ls_patch_no)

  LET li_table_list_cnt = lo_dzlm_table_list.getLength()
  FOR li_table_cnt = 1 TO li_table_list_cnt
    IF lo_dzlm_table_list[li_table_cnt].dtl_DZLM002 IS NOT NULL THEN 
      LET lo_exp_node_xml = lo_xml_exp_elements.appendChildElement("object")
      CALL lo_exp_node_xml.setAttribute("name",lo_dzlm_table_list[li_table_cnt].dtl_DZLM002)
      CALL lo_exp_node_xml.setAttribute("type",NVL(lo_dzlm_table_list[li_table_cnt].dtl_DZLM001,"T"))
      CALL lo_exp_node_xml.setAttribute("construct_version",lo_dzlm_table_list[li_table_cnt].dtl_DZLM005)
      CALL lo_exp_node_xml.setAttribute("sd_version",lo_dzlm_table_list[li_table_cnt].dtl_DZLM006)
      CALL lo_exp_node_xml.setAttribute("request_no",lo_dzlm_table_list[li_table_cnt].dtl_DZLM012)
      CALL lo_exp_node_xml.setAttribute("sequence_no",lo_dzlm_table_list[li_table_cnt].dtl_DZLM015)
      CALL lo_exp_node_xml.setAttribute("module",lo_dzlm_table_list[li_table_cnt].dtl_module)
      CALL lo_exp_node_xml.setAttribute("table_type",lo_dzlm_table_list[li_table_cnt].dtl_table_type)
      IF lo_dzlm_table_list[li_table_cnt].dtl_TAR_NAME IS NOT NULL THEN
        LET ls_temp_name = lo_dzlm_table_list[li_table_cnt].dtl_TAR_NAME
      ELSE
        LET ls_temp_name = lo_dzlm_table_list[li_table_cnt].dtl_DZLM002,"+TABLE+",
                           lo_dzlm_table_list[li_table_cnt].dtl_DZLM012,"+",
                           (lo_dzlm_table_list[li_table_cnt].dtl_DZLM015 USING cs_UsingFormat),".tdi"
      END IF
      CALL lo_exp_node_xml.setAttribute("tar_name",ls_temp_name)
    END IF 
  END FOR 
  
  #開檔將String Buffer寫入實體檔案
  CALL lo_xml_tap_document.setFeature("format-pretty-print", "TRUE")
  CALL lo_xml_tap_document.save(ls_vfy_filename)

END FUNCTION

FUNCTION sadzp240_pk_tar_sub_pack_files(p_patch_no)
DEFINE
  p_patch_no STRING
DEFINE
  ls_patch_no     STRING,
  ls_os_separator STRING,
  ls_TARString    STRING,
  ls_TARName      STRING,
  lb_error        BOOLEAN
DEFINE
  ls_return  STRING 

  LET ls_patch_no = p_patch_no.trim()

  LET lb_error = FALSE
  
  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  #TAR FILE BEGIN
  LET ls_TARName = ls_patch_no,".",cs_default_export_ext
  
  LET ls_TARString = "tar zcvf ",ls_TARName," *.tvz *.tdi *.vfy"
  DISPLAY cs_command_tag,ls_TARString
  RUN ls_TARString   

  RETURN ls_TARName

END FUNCTION 
