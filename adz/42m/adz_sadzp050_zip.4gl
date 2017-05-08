# Modify         : 2015/12/22 by elena  : 1.修改檔案下載儲存路徑
#                : 2015/12/28 by elena  : 1.下載基礎資料，暫存檔名稱加入前置詞"basedata_"
#                : 2015/12/31 by elena  : 1.下載增加p_modulefolder參數，Y:下載至模組資料夾
#                : 2016/01/08 by elena  : 1.下載資料至各模組前先新增資料夾
#                                         2.修改下載基礎資料SQL，改由GZZO_T取模組資訊
#                : 2016/01/25 by ernest : 1.從 Tempdir抓tap,tsd,csd等檔案
# 161116-00032   : 2016/11/16 by ernest : 1.4ad複製失敗不出現錯誤
# 170111-00006   : 20170111   by ernest : 1.下載時同時賦予壓縮包 everyone 的權限
# 170208-00008   : 20170123   by ernest : 1.差異比對下載
#                                         2.adz-00952-找不到此程式 %1 的差異紀錄, 是否仍要繼續執行差異比對下載 ?
# 170124-00011   : 20170124   by madey  : 1.增加function sadzp050_zip_delete_4rp_files

&include "../4gl/sadzp000_mcr.inc" 

IMPORT OS
IMPORT UTIL
IMPORT xml
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc" 
&include "../4gl/sadzp050_cnst.inc" 

CONSTANT cs_4gl_src_ext STRING = ".4gl.src"

&include "../4gl/sadzp000_type.inc" 
&include "../4gl/sadzp050_type.inc" 

GLOBALS "../../cfg/top_global.inc"

#170208-00008 begin  
GLOBALS
  DEFINE gb_diff_download  BOOLEAN 
END GLOBALS
#170208-00008 end  

FUNCTION sadzp050_zip_compress_to_program_zip(p_file_name,p_module_name,p_identity,p_module_path,p_lang,p_zip_ext_name,p_erpalm,p_readonly,p_must_exist)
DEFINE
  p_file_name    STRING,
  p_module_name  STRING,
  p_identity     STRING,
  p_module_path  STRING,
  p_lang         STRING,
  p_zip_ext_name STRING, 
  p_erpalm       STRING,
  p_readonly     BOOLEAN,
  p_must_exist   BOOLEAN 
DEFINE
  ls_file_name    STRING,
  ls_module_name  STRING, 
  ls_identity     STRING,
  ls_module_path  STRING,
  ls_lang         STRING, 
  ls_zip_ext_name STRING,
  ls_erpalm       STRING,
  lb_readonly     BOOLEAN, 
  lb_must_exist   BOOLEAN, 
  ls_zip_name    STRING,
  ls_zip_path    STRING,
  ls_zip_string  STRING,
  ls_random_path STRING,
  ls_module_env  STRING,
  ls_dir_pid     STRING,
  ls_src_path    STRING,
  ls_dst_path    STRING,
  li_chdir       INTEGER,
  li_mkdir       INTEGER,
  ls_return      STRING,
  ls_com_path    STRING,
  ls_run_command STRING,
  ls_separator   STRING,
  ls_identity_name STRING,
  lb_result      BOOLEAN 
DEFINE
  lb_return  BOOLEAN
  

  LET ls_file_name    = p_file_name
  LET ls_module_name  = p_module_name.toLowerCase()
  LET ls_identity     = p_identity
  LET ls_module_path  = p_module_path
  LET ls_lang         = p_lang
  LET ls_zip_ext_name = p_zip_ext_name
  LET ls_erpalm       = p_erpalm
  LET lb_readonly     = p_readonly
  LET lb_must_exist   = p_must_exist

  LET ls_separator  = os.Path.separator()
  
  LET ls_module_env = p_module_name.toUpperCase()

  LET ls_zip_path = FGL_GETENV("TEMPDIR")
  LET ls_com_path = FGL_GETENV("COM")

  #加入檔名加上 Identity Code
  IF (NVL(ls_identity.trim(),cs_null_default) <> cs_null_default) AND NOT sadzp050_zip_check_ext_is_standard(ls_zip_ext_name) THEN  
    LET ls_identity_name = ls_file_name,cs_open_paren,ls_identity,cs_close_paren
  ELSE
    LET ls_identity_name = ls_file_name
  END IF   
  
  LET ls_zip_name = ls_identity_name,".",ls_zip_ext_name
  
  CALL sadzp050_zip_gen_random_name() RETURNING ls_random_path
  LET ls_dir_pid = ls_zip_path,ls_separator,ls_file_name,"_",ls_random_path

  CALL os.Path.mkdir(ls_dir_pid) RETURNING li_mkdir

  CALL sadzp050_zip_get_dev_list("'ADZP050_DEV_PROG_LIST'",ls_file_name,ls_module_env,ls_dir_pid,ls_lang,ls_erpalm,lb_readonly,lb_must_exist) RETURNING lb_result
  IF NOT lb_result THEN GOTO _return END IF 
  
  LET ls_run_command = "cp ",ls_com_path,ls_separator,"mta",ls_separator,"ver ",ls_dir_pid 
  RUN ls_run_command

  LET ls_src_path  = FGL_GETENV(ls_module_env)
  LET ls_dst_path  = ls_dir_pid

  CALL os.Path.chdir(ls_dir_pid) RETURNING li_chdir
  LET ls_zip_string = "zip '",ls_zip_name,"' *"
  RUN ls_zip_string  

  LABEL _return:
  
  LET ls_return = ls_dir_pid,ls_separator
  LET lb_return = lb_result 

  RETURN lb_result,ls_return,ls_identity_name
  
END FUNCTION

FUNCTION sadzp050_zip_compress_to_code_zip(p_file_name,p_module_name,p_identity,p_module_path,p_lang,p_zip_ext_name,p_erpalm,p_readonly,p_must_exist)
DEFINE
  p_file_name    STRING,
  p_module_name  STRING,
  p_identity     STRING, 
  p_module_path  STRING,
  p_lang         STRING,
  p_zip_ext_name STRING, 
  p_erpalm       STRING,
  p_readonly     BOOLEAN,
  p_must_exist   BOOLEAN   
DEFINE
  ls_file_name     STRING,
  ls_module_name   STRING, 
  ls_identity      STRING, 
  ls_module_path   STRING, 
  ls_lang          STRING,
  ls_zip_ext_name  STRING,  
  ls_erpalm        STRING,
  lb_readonly      BOOLEAN, 
  lb_must_exist    BOOLEAN,   
  ls_zip_name      STRING,
  ls_zip_path      STRING,
  ls_zip_string    STRING,
  ls_random_path   STRING,
  ls_module_env    STRING,
  ls_dir_pid       STRING,
  li_chdir         INTEGER,
  li_mkdir         INTEGER,
  ls_return        STRING,
  ls_com_path      STRING,
  ls_run_command   STRING,
  ls_separator     STRING, 
  ls_identity_name STRING,
  ls_apt_path      STRING, #170208-00008
  ls_src_path      STRING, #170208-00008
  ls_dst_path      STRING, #170208-00008
  ls_src_4gl       STRING, #170208-00008
  lb_result        BOOLEAN 
DEFINE
  lb_return  BOOLEAN
  
  LET ls_file_name    = p_file_name
  LET ls_module_env   = p_module_name.toUpperCase()
  LET ls_module_name  = p_module_name.toLowerCase()
  LET ls_identity     = p_identity
  LET ls_module_path  = p_module_path
  LET ls_lang         = p_lang
  LET ls_zip_ext_name = p_zip_ext_name
  LET ls_erpalm       = p_erpalm
  LET lb_readonly     = p_readonly
  LET lb_must_exist   = p_must_exist

  LET ls_separator = os.Path.separator()

  LET ls_zip_path = FGL_GETENV("TEMPDIR")
  LET ls_com_path = FGL_GETENV("COM")

  #加入檔名加上 Identity Code
  IF (NVL(ls_identity.trim(),cs_null_default) <> cs_null_default) AND NOT sadzp050_zip_check_ext_is_standard(ls_zip_ext_name) THEN  
    LET ls_identity_name = ls_file_name,cs_open_paren,ls_identity,cs_close_paren
  ELSE
    LET ls_identity_name = ls_file_name
  END IF   
  
  LET ls_zip_name = ls_identity_name,".",ls_zip_ext_name

  CALL sadzp050_zip_gen_random_name() RETURNING ls_random_path
  LET ls_dir_pid = ls_zip_path,ls_separator,ls_file_name,"_",ls_random_path
  DISPLAY "Component Generate Path : ",ls_dir_pid

  CALL os.Path.mkdir(ls_dir_pid) RETURNING li_mkdir

  CALL sadzp050_zip_get_dev_list("'ADZP050_DEV_CODE_LIST'",ls_file_name,ls_module_env,ls_dir_pid,ls_lang,ls_erpalm,lb_readonly,lb_must_exist) RETURNING lb_result
  IF NOT lb_result THEN GOTO _return END IF 

  #170208-00008 begin
  IF gb_diff_download THEN
    LET ls_apt_path = ""
    #IF ls_identity.toLowerCase() <> "sd" THEN
    #  CALL sadzp050_apt_get_path("ind_path", ls_file_name, cl_chk_spec_type(ls_file_name)) RETURNING ls_apt_path 
    #ELSE
      #檢查是否經過客制
      #IF sadzp050_zip_get_if_standard_to_customize(ls_file_name) THEN 
        CALL sadzp050_apt_get_path("cus_path", ls_file_name, cl_chk_spec_type(ls_file_name)) RETURNING ls_apt_path 
      #END IF
    #END IF  
    IF ls_apt_path IS NOT NULL THEN
      #複製.apt檔
      LET ls_src_path = ls_apt_path
      LET ls_dst_path = ls_dir_pid,ls_separator,os.Path.basename(ls_apt_path)
      CALL os.Path.copy(ls_src_path,ls_dst_path) RETURNING lb_result
      DISPLAY cs_message_tag,"Copy apt file from ",ls_src_path," to ",ls_dst_path," : ",IIF(lb_result,"OK","Fail")
      #複製.src檔, 不存在時直接抓 4gl 檔改名稱
      LET ls_src_path = FGL_GETENV(sadzp050_zip_get_standard_module_name(ls_module_env)),ls_separator,"4gl",ls_separator,ls_file_name,cs_4gl_src_ext
      IF NOT os.Path.exists(ls_src_path) THEN
        DISPLAY cs_error_tag,"The source file '",ls_file_name,cs_4gl_src_ext,"' not exists, can not download diff file."
        GOTO _return 
      ELSE
        LET ls_dst_path = ls_dir_pid,ls_separator,ls_file_name,cs_4gl_src_ext
        CALL os.Path.copy(ls_src_path,ls_dst_path) RETURNING lb_result
        DISPLAY cs_message_tag,"Copy src file from ",ls_src_path," to ",ls_dst_path," : ",IIF(lb_result,"OK","Fail")
      END IF 
    END IF
  END IF
  #170208-00008 end
  
  LET ls_run_command = "cp ",ls_com_path,ls_separator,"mta",ls_separator,"ver ",ls_dir_pid 
  RUN ls_run_command

  CALL os.Path.chdir(ls_dir_pid) RETURNING li_chdir
  LET ls_zip_string = "zip '",ls_zip_name,"' *"
  RUN ls_zip_string  

  LABEL _return:

  LET ls_return = ls_dir_pid,ls_separator
  LET lb_return = lb_result 

  RETURN lb_result,ls_return,ls_identity_name
  
END FUNCTION

FUNCTION sadzp050_zip_compress_to_4rp_zip(p_file_name,p_module_name,p_type,p_version,p_identity,p_module_path,p_lang,p_dgenv,p_zip_ext_name,p_template_list,p_run_alm)
DEFINE
  p_file_name    STRING,
  p_module_name  STRING,
  p_type         STRING,
  p_version      STRING,
  p_identity     STRING,
  p_module_path  STRING,
  p_lang         STRING,
  p_dgenv        STRING,
  p_zip_ext_name STRING,
  p_template_list DYNAMIC ARRAY OF T_TEMPLATE_LIST_R,
  p_run_alm       BOOLEAN
DEFINE
  ls_file_name    STRING,
  ls_module_name  STRING, 
  ls_type         STRING,
  ls_version      STRING,
  ls_identity     STRING,
  ls_module_path  STRING, 
  ls_lang         STRING,
  ls_dgenv        STRING,
  ls_zip_ext_name STRING,  
  lb_run_alm      BOOLEAN,
  ls_zip_name     STRING,
  ls_zip_path     STRING,
  ls_zip_string   STRING,
  ls_random_path  STRING,
  ls_module_env   STRING,
  ls_dir_pid      STRING,
  li_chdir        INTEGER,
  li_mkdir        INTEGER,
  ls_return       STRING,
  ls_com_path     STRING,
  ls_run_command  STRING,
  ls_separator    STRING, 
  lb_result       BOOLEAN, 
  li_lang_cnt     INTEGER,
  ls_identity_name STRING,
  ls_lang_temp_path STRING,
  lb_success      BOOLEAN,
  lo_lang_arr     DYNAMIC ARRAY OF T_LANGUAGE_TYPE
DEFINE
  lb_return  BOOLEAN
  
  LET ls_file_name    = p_file_name
  LET ls_module_env   = p_module_name.toUpperCase()
  LET ls_module_name  = p_module_name.toLowerCase()
  LET ls_type         = p_type
  LET ls_version      = p_version 
  LET ls_identity     = p_identity
  LET ls_module_path  = p_module_path
  LET ls_lang         = p_lang
  LET ls_dgenv        = p_dgenv
  LET ls_zip_ext_name = p_zip_ext_name
  LET lb_run_alm      = p_run_alm

  LET ls_separator = os.Path.separator()

  LET ls_zip_path = FGL_GETENV("TEMPDIR")
  LET ls_com_path = FGL_GETENV("COM")
  #LET ls_zip_name = ls_file_name,".",cs_zip_name_tzc

  #加入檔名加上 Identity Code
  IF (NVL(ls_identity.trim(),cs_null_default) <> cs_null_default) AND NOT sadzp050_zip_check_ext_is_standard(ls_zip_ext_name) THEN  
    LET ls_identity_name = ls_file_name,cs_open_paren,ls_identity,cs_close_paren
  ELSE
    LET ls_identity_name = ls_file_name
  END IF   
  
  LET ls_zip_name = ls_identity_name,".",ls_zip_ext_name

  CALL sadzp050_zip_gen_random_name() RETURNING ls_random_path
  LET ls_dir_pid = ls_zip_path,ls_separator,ls_file_name,"_",ls_random_path
  DISPLAY "Component Generate Path : ",ls_dir_pid

  #建立暫存目錄
  CALL os.Path.mkdir(ls_dir_pid) RETURNING li_mkdir
  #建立暫存目錄中的語系目錄
  CALL sadzp050_zip_get_lang_type_list() RETURNING lo_lang_arr
  FOR li_lang_cnt = 1 TO lo_lang_arr.getLength()
    LET ls_lang_temp_path = ls_dir_pid,ls_separator,lo_lang_arr[li_lang_cnt]
    CALL os.Path.mkdir(ls_lang_temp_path) RETURNING lb_success    
  END FOR 

  CALL sadzp050_zip_copy_4rp_list(ls_file_name,ls_module_env,ls_dir_pid,ls_lang,p_template_list,TRUE) RETURNING lb_result
  IF NOT lb_result THEN GOTO _return END IF
  
  #產生驗證檔
  CALL adzp050_zip_generate_verify_file(ls_file_name,ls_module_env,ls_type,ls_version,ls_identity,ls_dgenv,ls_dir_pid,p_template_list,lb_run_alm)
  
  CALL os.Path.chdir(ls_dir_pid) RETURNING li_chdir
  LET ls_zip_string = "zip -r '",ls_zip_name,"' *"
  RUN ls_zip_string  

  LABEL _return:

  LET ls_return = ls_dir_pid,ls_separator
  LET lb_return = lb_result 

  RETURN lb_result,ls_return,ls_identity_name
  
END FUNCTION

FUNCTION adzp050_zip_generate_verify_file(p_file_name,p_module,p_type,p_version,p_identity,p_dgenv,p_temp_path,p_template_list,p_run_alm)
DEFINE 
  p_file_name     STRING,
  p_module        STRING,
  p_type          STRING,
  p_version       STRING,
  p_identity      STRING,
  p_dgenv         STRING,
  p_temp_path     STRING,
  p_template_list DYNAMIC ARRAY OF T_TEMPLATE_LIST_R,
  p_run_alm       BOOLEAN
DEFINE 
  ls_file_name     STRING,
  ls_module        STRING,
  ls_type          STRING,
  ls_version       STRING,
  ls_identity      STRING,
  ls_dgenv         STRING,
  ls_temp_path     STRING,
  lo_template_list DYNAMIC ARRAY OF T_TEMPLATE_LIST_R,
  lb_run_alm       BOOLEAN,
  ls_erpver        STRING,
  ls_zone          STRING,
  ls_vfy_filename  STRING,
  ls_separator     STRING,
  li_tple_cnt_all  INTEGER,
  li_tple_cnt      INTEGER,
  li_frp_cnt_all   INTEGER,
  li_frp_cnt       INTEGER,
  ls_component_name    STRING,
  lo_xml_tap_document  xml.DomDocument,
  lo_xml_tap_elements  xml.DomNode,
  lo_tap_node_xml      xml.DomNode

  LET ls_file_name     = p_file_name
  LET ls_module        = p_module
  LET ls_type          = p_type
  LET ls_version       = p_version
  LET ls_identity      = p_identity
  LET ls_dgenv         = p_dgenv
  LET ls_temp_path     = p_temp_path
  LET lo_template_list = p_template_list
  LET lb_run_alm       = p_run_alm

  LET ls_separator = os.Path.separator()

  LET ls_vfy_filename = ls_temp_path,ls_separator,ls_file_name,".vfy"
  
  LET ls_erpver = NVL(FGL_GETENV("ERPVER"),"NO DEFINE!!")
  LET ls_zone   = NVL(FGL_GETENV("ZONE"),"NO DEFINE!!")
  LET ls_dgenv  = NVL(NVL(ls_dgenv,FGL_GETENV("DGENV")),"NO DEFINE!!")
  
  #產出 XML 標頭
  LET lo_xml_tap_document = xml.DomDocument.CreateDocument("add_points")
  LET lo_xml_tap_elements = lo_xml_tap_document.getDocumentElement()
  CALL lo_xml_tap_elements.setAttribute("prog",ls_file_name)
  CALL lo_xml_tap_elements.setAttribute("std_prog",ls_file_name)
  CALL lo_xml_tap_elements.setAttribute("erpver",ls_erpver)
  CALL lo_xml_tap_elements.setAttribute("module",ls_module.toUpperCase())
  CALL lo_xml_tap_elements.setAttribute("ver",ls_version)
  CALL lo_xml_tap_elements.setAttribute("env",ls_dgenv)
  CALL lo_xml_tap_elements.setAttribute("zone",ls_zone)
  CALL lo_xml_tap_elements.setAttribute("type",ls_type)
  CALL lo_xml_tap_elements.setAttribute("booking", IIF(lb_run_alm,"Y","N"))
  CALL lo_xml_tap_elements.setAttribute("identity",ls_identity)

  #CALL sadzp050_zip_set_vfy_4rp_list(ls_file_name,p_template_list,lo_xml_tap_document)
  
  #抓取4rp相關檔名進 vfy 檔
  LET li_tple_cnt_all = lo_template_list.getLength()
  FOR li_tple_cnt = 1 TO li_tple_cnt_all
    LET ls_component_name = lo_template_list[li_tple_cnt].tl_COMPONENT
    IF ls_component_name = ls_file_name THEN 
      #Copy 4RP File
      LET li_frp_cnt_all = lo_template_list[li_tple_cnt].FRP_LIST.getLength()
      FOR li_frp_cnt = 1 TO li_frp_cnt_all 
        LET lo_tap_node_xml = lo_xml_tap_elements.appendChildElement("FRP")
        CALL lo_tap_node_xml.setAttribute("name",lo_template_list[li_tple_cnt].FRP_LIST[li_frp_cnt].fl_NAME)
        CALL lo_tap_node_xml.setAttribute("exist",lo_template_list[li_tple_cnt].FRP_LIST[li_frp_cnt].fl_EXIST)
        CALL lo_tap_node_xml.setAttribute("template",lo_template_list[li_tple_cnt].tl_NAME)
      END FOR
    END IF 
  END FOR 
  
  #開檔將String Buffer寫入實體檔案
  CALL lo_xml_tap_document.setFeature("format-pretty-print", "TRUE")
  CALL lo_xml_tap_document.save(ls_vfy_filename)

END FUNCTION

FUNCTION sadzp050_zip_compress_to_form_zip(p_file_name,p_module_name,p_identity,p_module_path,p_lang,p_zip_ext_name,p_erpalm,p_readonly,p_must_exist)
DEFINE
  p_file_name    STRING,
  p_module_name  STRING,
  p_identity     STRING,
  p_module_path  STRING,
  p_lang         STRING,
  p_zip_ext_name STRING,
  p_erpalm       STRING,
  p_readonly     BOOLEAN,
  p_must_exist   BOOLEAN
DEFINE
  ls_file_name     STRING,
  ls_module_name   STRING, 
  ls_identity      STRING,
  ls_module_path   STRING,
  ls_lang          STRING, 
  ls_zip_ext_name  STRING, 
  ls_erpalm        STRING,
  lb_readonly      BOOLEAN, 
  lb_must_exist    BOOLEAN,
  ls_zip_name      STRING,
  ls_zip_path      STRING,
  ls_zip_string    STRING,
  ls_random_path   STRING,
  ls_module_env    STRING,
  ls_dir_pid       STRING,
  ls_src_path      STRING,
  ls_dst_path      STRING,
  li_chdir         INTEGER,
  li_mkdir         INTEGER,
  ls_return        STRING,
  ls_run_command   STRING,
  ls_separator     STRING,
  ls_com_path      STRING, 
  ls_identity_name STRING,
  lb_result        BOOLEAN 
DEFINE
  lb_return  BOOLEAN 

  LET ls_file_name    = p_file_name
  LET ls_module_name  = p_module_name.toLowerCase()
  LET ls_identity     = p_identity
  LET ls_module_path  = p_module_path
  LET ls_lang         = p_lang
  LET ls_zip_ext_name = p_zip_ext_name
  LET ls_erpalm       = p_erpalm
  LET lb_readonly     = p_readonly 
  LET lb_must_exist   = p_must_exist

  LET ls_separator = os.Path.separator()
  
  LET ls_module_env  = p_module_name.toUpperCase()

  LET ls_zip_path = FGL_GETENV("TEMPDIR")
  LET ls_com_path = FGL_GETENV("COM")
  
  #加入檔名加上 Identity Code
  IF (NVL(ls_identity.trim(),cs_null_default) <> cs_null_default) AND NOT sadzp050_zip_check_ext_is_standard(ls_zip_ext_name) THEN  
    LET ls_identity_name = ls_file_name,cs_open_paren,ls_identity,cs_close_paren
  ELSE
    LET ls_identity_name = ls_file_name
  END IF   
  
  LET ls_zip_name = ls_identity_name,".",ls_zip_ext_name
  
  CALL sadzp050_zip_gen_random_name() RETURNING ls_random_path
  LET ls_dir_pid = ls_zip_path,ls_separator,ls_file_name,"_",ls_random_path

  CALL os.Path.mkdir(ls_dir_pid) RETURNING li_mkdir

  CALL sadzp050_zip_get_dev_list("'ADZP050_DEV_FORM_LIST'",ls_file_name,ls_module_env,ls_dir_pid,ls_lang,ls_erpalm,lb_readonly,lb_must_exist) RETURNING lb_result
  IF NOT lb_result THEN GOTO _return END IF 
  
  LET ls_run_command = "cp ",ls_com_path,ls_separator,"mta",ls_separator,"ver "||ls_dir_pid 
  RUN ls_run_command

  LET ls_src_path  = FGL_GETENV(ls_module_env)
  LET ls_dst_path  = ls_dir_pid

  CALL os.Path.chdir(ls_dir_pid) RETURNING li_chdir
  LET ls_zip_string = "zip '",ls_zip_name,"' *"
  RUN ls_zip_string  

  LABEL _return:

  LET ls_return = ls_dir_pid,ls_separator
  LET lb_return = lb_result 

  RETURN lb_result,ls_return,ls_identity_name
  
END FUNCTION

FUNCTION sadzp050_zip_compress_to_csd_zip(p_file_name,p_module_name,p_identity,p_module_path,p_lang,p_zip_ext_name,p_erpalm,p_readonly,p_must_exist)
DEFINE
  p_file_name    STRING,
  p_module_name  STRING,
  p_identity     STRING, 
  p_module_path  STRING,
  p_lang         STRING,
  p_zip_ext_name STRING, 
  p_erpalm       STRING,
  p_readonly     BOOLEAN,
  p_must_exist   BOOLEAN  
DEFINE
  ls_file_name    STRING,
  ls_module_name  STRING, 
  ls_identity     STRING, 
  ls_module_path  STRING,
  ls_lang         STRING, 
  ls_zip_ext_name STRING, 
  ls_erpalm       STRING,
  lb_readonly     BOOLEAN, 
  lb_must_exist   BOOLEAN,
  ls_zip_name    STRING,
  ls_zip_path    STRING,
  ls_zip_string  STRING,
  ls_random_path STRING,
  ls_module_env  STRING,
  ls_dir_pid     STRING,
  ls_src_path    STRING,
  ls_dst_path    STRING,
  li_chdir       INTEGER,
  li_mkdir       INTEGER,
  ls_return      STRING,
  ls_run_command STRING,
  ls_separator   STRING,
  ls_com_path    STRING, 
  ls_identity_name STRING,
  lb_result      BOOLEAN 
DEFINE
  lb_return  BOOLEAN   

  LET ls_file_name    = p_file_name
  LET ls_module_name  = p_module_name.toLowerCase()
  LET ls_identity     = p_identity
  LET ls_module_path  = p_module_path
  LET ls_lang         = p_lang
  LET ls_zip_ext_name = p_zip_ext_name
  LET ls_erpalm       = p_erpalm
  LET lb_readonly     = p_readonly
  LET lb_must_exist   = p_must_exist
  
  LET ls_separator = os.Path.separator()
  
  LET ls_module_env  = p_module_name.toUpperCase()

  LET ls_zip_path = FGL_GETENV("TEMPDIR")
  LET ls_com_path = FGL_GETENV("COM")

  #加入檔名加上 Identity Code
  IF (NVL(ls_identity.trim(),cs_null_default) <> cs_null_default) AND NOT sadzp050_zip_check_ext_is_standard(ls_zip_ext_name) THEN  
    LET ls_identity_name = ls_file_name,cs_open_paren,ls_identity,cs_close_paren
  ELSE
    LET ls_identity_name = ls_file_name
  END IF   
  
  LET ls_zip_name = ls_identity_name,".",ls_zip_ext_name
  
  CALL sadzp050_zip_gen_random_name() RETURNING ls_random_path
  LET ls_dir_pid = ls_zip_path,ls_separator,ls_file_name,"_",ls_random_path

  CALL os.Path.mkdir(ls_dir_pid) RETURNING li_mkdir

  CALL sadzp050_zip_get_dev_list("'ADZP050_DEV_CSD_LIST'",ls_file_name,ls_module_env,ls_dir_pid,ls_lang,ls_erpalm,lb_readonly,lb_must_exist) RETURNING lb_result
  IF NOT lb_result THEN GOTO _return END IF 
  
  LET ls_run_command = "cp ",ls_com_path,ls_separator,"mta",ls_separator,"ver "||ls_dir_pid 
  RUN ls_run_command

  LET ls_src_path  = FGL_GETENV(ls_module_env)
  LET ls_dst_path  = ls_dir_pid

  CALL os.Path.chdir(ls_dir_pid) RETURNING li_chdir
  LET ls_zip_string = "zip '",ls_zip_name,"' *"
  RUN ls_zip_string  

  LABEL _return:

  LET ls_return = ls_dir_pid,ls_separator
  LET lb_return = lb_result 

  RETURN lb_result,ls_return,ls_identity_name
  
END FUNCTION

FUNCTION sadzp050_zip_compress_to_rsd_zip(p_file_name,p_module_name,p_identity,p_module_path,p_lang,p_zip_ext_name,p_erpalm,p_readonly,p_must_exist)
DEFINE
  p_file_name    STRING,
  p_module_name  STRING,
  p_identity     STRING,
  p_module_path  STRING,
  p_lang         STRING,
  p_zip_ext_name STRING, 
  p_erpalm       STRING,
  p_readonly     BOOLEAN, 
  p_must_exist   BOOLEAN
DEFINE
  ls_file_name    STRING,
  ls_module_name  STRING, 
  ls_identity     STRING,
  ls_module_path  STRING,
  ls_lang         STRING, 
  ls_zip_ext_name STRING, 
  ls_erpalm       STRING,
  lb_readonly     BOOLEAN, 
  lb_must_exist   BOOLEAN,
  ls_zip_name    STRING,
  ls_zip_path    STRING,
  ls_zip_string  STRING,
  ls_random_path STRING,
  ls_module_env  STRING,
  ls_dir_pid     STRING,
  ls_src_path    STRING,
  ls_dst_path    STRING,
  li_chdir       INTEGER,
  li_mkdir       INTEGER,
  ls_return      STRING,
  ls_run_command STRING,
  ls_separator   STRING,
  ls_com_path    STRING, 
  ls_identity_name STRING,
  lb_result      BOOLEAN 
DEFINE
  lb_return  BOOLEAN   

  LET ls_file_name    = p_file_name
  LET ls_module_name  = p_module_name.toLowerCase()
  LET ls_identity     = p_identity
  LET ls_module_path  = p_module_path
  LET ls_lang         = p_lang
  LET ls_zip_ext_name = p_zip_ext_name
  LET ls_erpalm       = p_erpalm
  LET lb_readonly     = p_readonly
  LET lb_must_exist   = p_must_exist
  
  LET ls_separator = os.Path.separator()
  
  LET ls_module_env  = p_module_name.toUpperCase()

  LET ls_zip_path = FGL_GETENV("TEMPDIR")
  LET ls_com_path = FGL_GETENV("COM")
  
  #加入檔名加上 Identity Code
  IF (NVL(ls_identity.trim(),cs_null_default) <> cs_null_default) AND NOT sadzp050_zip_check_ext_is_standard(ls_zip_ext_name) THEN  
    LET ls_identity_name = ls_file_name,cs_open_paren,ls_identity,cs_close_paren
  ELSE
    LET ls_identity_name = ls_file_name
  END IF   
  
  LET ls_zip_name = ls_identity_name,".",ls_zip_ext_name
  
  CALL sadzp050_zip_gen_random_name() RETURNING ls_random_path
  LET ls_dir_pid = ls_zip_path,ls_separator,ls_file_name,"_",ls_random_path

  CALL os.Path.mkdir(ls_dir_pid) RETURNING li_mkdir

  CALL sadzp050_zip_get_dev_list("'ADZP050_DEV_RSD_LIST'",ls_file_name,ls_module_env,ls_dir_pid,ls_lang,ls_erpalm,lb_readonly,lb_must_exist) RETURNING lb_result
  IF NOT lb_result THEN GOTO _return END IF 
  
  LET ls_run_command = "cp ",ls_com_path,ls_separator,"mta",ls_separator,"ver "||ls_dir_pid 
  RUN ls_run_command

  LET ls_src_path  = FGL_GETENV(ls_module_env)
  LET ls_dst_path  = ls_dir_pid

  CALL os.Path.chdir(ls_dir_pid) RETURNING li_chdir
  LET ls_zip_string = "zip '",ls_zip_name,"' *"
  RUN ls_zip_string  

  LABEL _return:

  LET ls_return = ls_dir_pid,ls_separator
  LET lb_return = lb_result 

  RETURN lb_result,ls_return,ls_identity_name
  
END FUNCTION


#壓縮基礎資料為TT.zip
FUNCTION sadzp050_zip_compress_to_designer_zip(p_file_name,p_module_name,p_lang)
DEFINE
  p_file_name    STRING,
  p_module_name  STRING,
  p_lang         STRING
DEFINE
  ls_zip_name        STRING,
  ls_zip_path        STRING,
  ls_zip_string      STRING,
  ls_file_name       STRING,
  ls_module_env      STRING,
  ls_module_name     STRING, 
  ls_lang           STRING,
  ls_dir_pid         STRING,
  ls_src_path        STRING,
  ls_dst_path        STRING,
  ls_random_path     STRING,
  ls_module_path     STRING,
  ls_mta_path        STRING,
  ls_4tb_Path        STRING,
  ls_return          STRING,
  ls_mudule_zip_list STRING,
  ls_slice_Path      STRING, 
  ls_command         STRING,  
  ls_message         STRING, 
  ls_separator       STRING,
  ls_run_command     STRING,
  li_chdir           INTEGER,
  li_mkdir           INTEGER

  LET ls_file_name   = p_file_name
  LET ls_module_env  = p_module_name.toUpperCase()
  LET ls_module_name = p_module_name.toLowerCase()
  LET ls_lang        = p_lang

  LET ls_random_path = ""
  LET ls_module_path = ""
  LET ls_mta_path    = ""
  LET ls_4tb_Path    = ""

  LET ls_separator = os.Path.separator()

  LET ls_zip_path = FGL_GETENV("TEMPDIR")
  LET ls_zip_name = ls_file_name,".zip"
  
  CALL cl_progress_bar(6)
  
  CALL sadzp050_zip_gen_random_name() RETURNING ls_random_path
  LET ls_random_path = "basedata_",ls_random_path  #20151228 by elena

  LET ls_dir_pid = ls_zip_path,ls_separator,ls_random_path
  CALL os.Path.mkdir(ls_dir_pid) RETURNING li_mkdir
  LET ls_run_command = "rm ",ls_dir_pid,ls_separator,"*" 
  RUN ls_run_command

  CALL sadzp050_zip_make_module_directory(ls_dir_pid,ls_lang) RETURNING ls_mudule_zip_list

  LET ls_message = 'Making directory ...'
  CALL cl_progress_ing(ls_message)
  LET ls_mta_path = ls_dir_pid,ls_separator,"mta"  
  CALL os.Path.mkdir(ls_mta_path) RETURNING li_mkdir

  LET ls_4tb_Path = ls_dir_pid,ls_separator,"4tb"
  CALL os.Path.mkdir(ls_4tb_Path) RETURNING li_mkdir

  LET ls_slice_Path = ls_dir_pid,ls_separator,"slice"
  CALL os.Path.mkdir(ls_slice_Path) RETURNING li_mkdir

  LET ls_message = 'Copying MTA files...'
  CALL cl_progress_ing(ls_message)
  LET ls_dst_path  = ls_dir_pid
  LET ls_src_path = FGL_GETENV("COM")
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||"tsd.xsd "||ls_mta_path
  
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"checks.xml "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"datatypes.xml "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"items.xml "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"libraries.xml "||ls_mta_path
  #2013.06.11 messages.xml 移除不下載
  #2013.09.06 messages.xml 恢復下載
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"messages.xml "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"prog_rel.xml "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"subroutines.xml "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"subinfo.xml "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"tree_kind.xml "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"tables.xml "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"zooms.xml "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"code_sample.xml "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"code_template.xml "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"mta"||ls_separator||"ver "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"cfg"||ls_separator||"top_global.inc "||ls_mta_path
   
  LET ls_message = 'Copying GSTDIR files...'
  CALL cl_progress_ing(ls_message)
  LET ls_src_path = FGL_GETENV("GSTDIR")
  RUN "cp "||ls_src_path||ls_separator||"gst"||ls_separator||"conf"||ls_separator||"mod-fd.spec "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"gst"||ls_separator||"conf"||ls_separator||"core-br.spec "||ls_mta_path
  RUN "cp "||ls_src_path||ls_separator||"gst"||ls_separator||"conf"||ls_separator||"lexerproperties"||ls_separator||"4gl.xml "||ls_mta_path

  LET ls_message = 'Copying ERP files...'
  CALL cl_progress_ing(ls_message)
  LET ls_src_path = FGL_GETENV("ERP")
  RUN "cp "||ls_src_path||ls_separator||"cfg"||ls_separator||"4tb"||ls_separator||"toolbar*.4tb "||ls_4tb_Path
  RUN "cp "||ls_src_path||ls_separator||"mdl"||ls_separator||"slice"||ls_separator||"*.template "||ls_slice_Path
  ##RUN "cp "||ls_src_path||ls_separator||"cfg"||ls_separator||"4ad"||ls_separator||ls_lang||ls_separator||ls_module_name||ls_separator||ls_file_name||".4ad "||ls_dst_path
  LET ls_command = "cp ",ls_src_path,ls_separator,"cfg",ls_separator,"4ad",ls_separator,"tiptop_",ls_lang,".4ad ",ls_mta_path,ls_separator,"tiptop.4ad"
  DISPLAY "[Copy TIPTOP 4ad file] ",ls_command 
  RUN ls_command

  LET ls_message = 'Compressing common files...'
  CALL cl_progress_ing(ls_message)
  CALL os.Path.chdir(ls_dir_pid) RETURNING li_chdir
  #壓縮 4tb 及 mta 資料
  LET ls_zip_string = "zip "||ls_zip_name||" 4tb"||ls_separator||"* mta"||ls_separator||"* slice"||ls_separator||"*"
  RUN ls_zip_string  
  LET ls_message = 'Compressing module and table files...'
  CALL cl_progress_ing(ls_message)
  
  #壓縮各模組 tbl 資料
  LET ls_zip_string = "zip ",ls_zip_name," ",ls_mudule_zip_list
  DISPLAY "[ZIP Module]"||ls_zip_string
  RUN ls_zip_string    
  
  LET ls_return = ls_dir_pid||ls_separator

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp050_zip_check_ext_is_standard(p_ext_name)
DEFINE
  p_ext_name STRING
DEFINE
  lb_return BOOLEAN 
  
  IF p_ext_name.trim() = cs_zip_name_tmc OR
     p_ext_name.trim() = cs_zip_name_tmd OR
     p_ext_name.trim() = cs_zip_name_tmg OR
     p_ext_name.trim() = cs_zip_name_tmr OR
     p_ext_name.trim() = cs_zip_name_tms OR
     p_ext_name.trim() = cs_zip_name_tmt OR
     p_ext_name.trim() = cs_zip_name_tmp THEN
    LET lb_return = TRUE  
  ELSE
    LET lb_return = FALSE  
  END IF   

  RETURN lb_return

END FUNCTION 

FUNCTION sadzp050_zip_get_dev_list(p_type,p_file_name,p_module_name,p_Path,p_lang,p_erpalm,p_readonly,p_must_exist)
DEFINE 
  p_type        STRING,
  p_file_name   STRING,
  p_module_name STRING,
  p_Path        STRING,
  p_lang        STRING,
  p_erpalm      STRING,
  p_readonly    BOOLEAN,
  p_must_exist  BOOLEAN
DEFINE
  ls_type          STRING,
  ls_file_name     STRING,
  ls_module_name   STRING,
  ls_path          STRING,
  ls_lang          STRING,
  ls_erpalm        STRING,
  lb_readonly      BOOLEAN,
  lb_must_exist    BOOLEAN,
  ls_sql           STRING,
  ls_type_list     STRING,
  ls_full_path     STRING,
  ls_list_path     STRING,
  ls_module_path   STRING,
  ls_src_file      STRING,
  ls_dst_file      STRING,
  lb_copy_result   BOOLEAN,
  lsb_str_buf      base.StringBuffer,
  ls_separator     STRING,
  ls_err_code      STRING,
  ls_err_msg       STRING,
  ls_must_exist    STRING,
  ls_temp_path     STRING, #2016/01/25 by ernest
  lo_zip_documents RECORD
                     documents   VARCHAR(90),
                     lang_type   VARCHAR(90),
                     design_root VARCHAR(90),
                     sub_path    VARCHAR(90),
                     must_exist  VARCHAR(90) 
                   END RECORD
DEFINE
  ls_return STRING,
  lb_return BOOLEAN  

  LET ls_type         = p_type
  LET ls_file_name    = p_file_name
  LET ls_module_name  = p_module_name.toUpperCase()
  LET ls_path         = p_Path
  LET ls_lang         = p_lang
  LET ls_erpalm       = p_erpalm
  LET lb_readonly     = p_readonly
  LET lb_must_exist   = p_must_exist

  LET ls_separator = os.Path.separator()
  LET lb_copy_result = TRUE
  LET lb_return      = TRUE
  
  LET ls_temp_path    = FGL_GETENV("TEMPDIR") #2016/01/25 by ernest
  LET ls_module_path  = FGL_GETENV(ls_module_name)
  LET ls_list_path    = ls_path

  LET lsb_str_buf = base.StringBuffer.create()
  CALL lsb_str_buf.clear()

  IF ls_type IS NULL THEN
    LET ls_type_list = "'ADZP050_DEV_PROG_LIST'"
  ELSE
    LET ls_type_list = ls_type
  END IF

  IF lb_must_exist THEN
    LET ls_must_exist = " EJ.DZEJ009 " 
  ELSE
    LET ls_must_exist = " 'N' " 
  END IF 
  
  LET ls_sql = "SELECT EJ.DZEJ003                          Documents,  ",
               "       DECODE(                                         ",
               "               EJ.DZEJ005,                             ",  
               "               '{LangType}','",ls_lang,"',             ",
               "               NULL                                    ",
               "             )                             LangType,   ",
               "       EJ.DZEJ006                          DesignRoot, ",
               "       EJ.DZEJ007                          SubPath,    ",
               "       ",ls_must_exist,"                   MustExist   ",  
               "  FROM DZEJ_T EJ                                       ",
               " WHERE EJ.DZEJ001 IN (",ls_type_list,")                ",
               #"   AND EJ.DZEJ009 = 'Y'                                ", 
               " ORDER BY EJ.DZEJ001,EJ.DZEJ002                        " 
 
  PREPARE lpre_dev_list FROM ls_sql
  DECLARE lcur_dev_list SCROLL CURSOR FOR lpre_dev_list

  OPEN lcur_dev_list
  FOREACH lcur_dev_list INTO lo_zip_documents.*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    IF lo_zip_documents.design_root IS NOT NULL THEN
      LET ls_full_path = lo_zip_documents.design_root,ls_separator,lo_zip_documents.sub_path
    ELSE
      LET ls_full_path = lo_zip_documents.sub_path
    END IF

    IF lo_zip_documents.lang_type IS NOT NULL THEN
      LET ls_full_path = ls_full_path,ls_separator,lo_zip_documents.lang_type
    ELSE
      LET ls_full_path = ls_full_path
    END IF

    --IF lb_readonly AND ls_erpalm = "Y" AND (lo_zip_documents.documents = "tsd" OR lo_zip_documents.documents = "tap" OR lo_zip_documents.documents = "rsd" OR lo_zip_documents.documents = "csd") THEN
    IF lb_readonly AND (lo_zip_documents.documents = "tsd" OR lo_zip_documents.documents = "tap" OR lo_zip_documents.documents = "rsd" OR lo_zip_documents.documents = "csd") THEN
      #2016/01/25 Modify by ernest 
      #LET ls_src_file = ls_module_path,ls_separator,ls_full_path,ls_separator,ls_file_name,".",lo_zip_documents.documents,".read"
      LET ls_src_file = ls_temp_path,ls_separator,ls_file_name,".",lo_zip_documents.documents,".read"
    ELSE
      #2016/01/25 Modify by ernest
      IF (lo_zip_documents.documents = "tsd" OR lo_zip_documents.documents = "tap" OR lo_zip_documents.documents = "rsd" OR lo_zip_documents.documents = "csd") THEN  
        LET ls_src_file = ls_temp_path,ls_separator,ls_file_name,".",lo_zip_documents.documents
      ELSE
        LET ls_src_file = ls_module_path,ls_separator,ls_full_path,ls_separator,ls_file_name,".",lo_zip_documents.documents
      END IF  
    END IF   
    LET ls_dst_file = ls_path,ls_separator,ls_file_name,".",lo_zip_documents.documents

    CALL os.Path.copy(ls_src_file,ls_dst_file) RETURNING lb_copy_result
    
    DISPLAY cs_message_tag,"Clone file from [",ls_src_file,"] to [",ls_dst_file,"]"
    
    IF (NOT lb_copy_result) AND (lo_zip_documents.must_exist = "Y") AND 
       (lo_zip_documents.documents <> "4ad") THEN #161116-00032
      DISPLAY cs_error_tag,"Clone file from '",ls_src_file,"' to '",ls_dst_file,"'"
      LET ls_err_code = "adz-00269"
      LET ls_err_msg  = ls_src_file,"|",ls_dst_file,"|"
      CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)

      LET lb_return = lb_copy_result
      
      EXIT FOREACH
    END IF   
    
  END FOREACH
  CLOSE lcur_dev_list

  FREE lcur_dev_list
  FREE lpre_dev_list

  RETURN lb_return

END FUNCTION

FUNCTION sadzp050_zip_copy_4rp_list(p_file_name,p_module_name,p_Path,p_lang,p_template_list,p_positive)
DEFINE 
  p_file_name     STRING,
  p_module_name   STRING,
  p_Path          STRING,
  p_lang          STRING,
  p_template_list DYNAMIC ARRAY OF T_TEMPLATE_LIST_R,
  p_positive      BOOLEAN 
DEFINE
  ls_file_name      STRING,
  ls_module_name    STRING,
  ls_path           STRING,
  ls_lang           STRING,
  lo_template_list  DYNAMIC ARRAY OF T_TEMPLATE_LIST_R,
  lb_positive       BOOLEAN, 
  ls_sql            STRING,
  ls_type_list      STRING,
  ls_full_path      STRING,
  ls_module_path    STRING,
  ls_src_file       STRING,
  ls_dst_file       STRING,
  lb_copy_result    BOOLEAN,
  li_tple_cnt       INTEGER,
  li_frp_cnt        INTEGER,
  li_tple_cnt_all   INTEGER,
  li_frp_cnt_all    INTEGER,
  ls_component_name STRING,
  ls_4rp_name       STRING,
  ls_separator      STRING,
  ls_err_code       STRING,
  ls_err_msg        STRING,
  li_lang_cnt       INTEGER,
  lo_lang_arr       DYNAMIC ARRAY OF T_LANGUAGE_TYPE
DEFINE
  ls_return STRING,
  lb_return BOOLEAN  

  LET ls_file_name     = p_file_name
  LET ls_module_name   = p_module_name.toUpperCase()
  LET ls_path          = p_Path
  LET ls_lang          = p_lang
  LET lo_template_list = p_template_list
  LET lb_positive      = p_positive  

  LET ls_separator = os.Path.separator()
  LET lb_copy_result = TRUE
  LET lb_return      = TRUE
  
  LET ls_module_path = FGL_GETENV(ls_module_name)

  CALL sadzp050_zip_get_lang_type_list() RETURNING lo_lang_arr

  LET li_tple_cnt_all = lo_template_list.getLength()
  FOR li_tple_cnt = 1 TO li_tple_cnt_all
    LET ls_component_name = lo_template_list[li_tple_cnt].tl_COMPONENT
    IF ls_component_name = ls_file_name THEN 
      #複製到各語系的rdd
      FOR li_lang_cnt = 1 TO lo_lang_arr.getLength()
        #Copy RDD File
        IF lb_positive THEN 
          LET ls_src_file = ls_module_path,ls_separator,"4rp",ls_separator,"rdd",ls_separator,ls_component_name,".rdd"
          LET ls_dst_file = ls_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_component_name,".rdd"
        ELSE
          LET ls_src_file = ls_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_component_name,".rdd"
          LET ls_dst_file = ls_module_path,ls_separator,"4rp",ls_separator,"rdd",ls_separator,ls_component_name,".rdd"
        END IF   
        --DISPLAY "[rdd Source]",ls_src_file
        --DISPLAY "[rdd Target]",ls_dst_file
        CALL os.Path.copy(ls_src_file,ls_dst_file) RETURNING lb_copy_result
        IF NOT lb_copy_result THEN GOTO _return END IF 
      END FOR 

      #Copy 4RP File
      LET li_frp_cnt_all = lo_template_list[li_tple_cnt].FRP_LIST.getLength()
      #複製到各語系的4rp
      FOR li_lang_cnt = 1 TO lo_lang_arr.getLength()
        FOR li_frp_cnt = 1 TO li_frp_cnt_all 
          LET ls_4rp_name = lo_template_list[li_tple_cnt].FRP_LIST[li_frp_cnt].fl_NAME
          IF lb_positive THEN 
            LET ls_src_file = ls_module_path,ls_separator,"4rp",ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".4rp"
            LET ls_dst_file = ls_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".4rp"
          ELSE
            LET ls_src_file = ls_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".4rp"
            LET ls_dst_file = ls_module_path,ls_separator,"4rp",ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".4rp"
          END IF   
          --DISPLAY "[4rp Source]",ls_src_file
          --DISPLAY "[4rp Target]",ls_dst_file
          CALL os.Path.copy(ls_src_file,ls_dst_file) RETURNING lb_copy_result
          --IF NOT lb_copy_result THEN GOTO _return END IF -- 之後要取消
        END FOR
      END FOR 
      LET lb_copy_result = TRUE -- 暫時設為 True, 之後要拿掉
      
      #Copy jpg/png File
      LET li_frp_cnt_all = lo_template_list[li_tple_cnt].FRP_LIST.getLength()
      #複製到各語系的jpg/png
      FOR li_lang_cnt = 1 TO lo_lang_arr.getLength()
        FOR li_frp_cnt = 1 TO li_frp_cnt_all
        
          #JPG  
          LET ls_4rp_name = lo_template_list[li_tple_cnt].FRP_LIST[li_frp_cnt].fl_NAME
          IF lb_positive THEN 
            LET ls_src_file = ls_module_path,ls_separator,"4rp",ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".jpg"
            LET ls_dst_file = ls_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".jpg"
          ELSE
            LET ls_src_file = ls_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".jpg"
            LET ls_dst_file = ls_module_path,ls_separator,"4rp",ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".jpg"
          END IF   
          --DISPLAY "[jpg/png Source]",ls_src_file
          --DISPLAY "[jpg/png Target]",ls_dst_file
          CALL os.Path.copy(ls_src_file,ls_dst_file) RETURNING lb_copy_result
          --IF NOT lb_copy_result THEN GOTO _return END IF -- 之後要取消

          #PNG  
          IF lb_positive THEN 
            LET ls_src_file = ls_module_path,ls_separator,"4rp",ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".png"
            LET ls_dst_file = ls_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".png"
          ELSE
            LET ls_src_file = ls_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".png"
            LET ls_dst_file = ls_module_path,ls_separator,"4rp",ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".png"
          END IF   
          --DISPLAY "[jpg/png Source]",ls_src_file
          --DISPLAY "[jpg/png Target]",ls_dst_file
          CALL os.Path.copy(ls_src_file,ls_dst_file) RETURNING lb_copy_result
          --IF NOT lb_copy_result THEN GOTO _return END IF -- 之後要取消
          
        END FOR
      END FOR 
      LET lb_copy_result = TRUE -- 暫時設為 True, 之後要拿掉
      
    END IF 
  END FOR 

  LABEL _return:
  
  IF (NOT lb_copy_result) THEN
    DISPLAY cs_error_tag," Copy file from '",ls_src_file,"' to '",ls_dst_file,"'"
    LET ls_err_code = "adz-00269"
    LET ls_err_msg  = ls_src_file,"|",ls_dst_file,"|"
    CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)

    LET lb_return = lb_copy_result
    
  END IF   
    
  RETURN lb_return

END FUNCTION

FUNCTION sadzp050_zip_moving_4rp_files(p_file_name,p_from_path,p_to_path,p_template_list)
DEFINE 
  p_file_name     STRING,
  p_from_path     STRING,
  p_to_path       STRING,
  p_template_list DYNAMIC ARRAY OF T_TEMPLATE_LIST_R
DEFINE
  ls_file_name      STRING,
  ls_from_path      STRING,
  ls_to_path        STRING,
  lo_template_list  DYNAMIC ARRAY OF T_TEMPLATE_LIST_R,
  ls_src_file       STRING,
  ls_dst_file       STRING,
  lb_copy_result    BOOLEAN,
  li_tple_cnt       INTEGER,
  li_frp_cnt        INTEGER,
  li_tple_cnt_all   INTEGER,
  li_frp_cnt_all    INTEGER,
  ls_component_name STRING,
  ls_4rp_name       STRING,
  ls_separator      STRING,
  ls_err_code       STRING,
  ls_err_msg        STRING,
  li_lang_cnt       INTEGER,
  lo_lang_arr       DYNAMIC ARRAY OF T_LANGUAGE_TYPE
DEFINE
  ls_return STRING,
  lb_return BOOLEAN  

  LET ls_file_name     = p_file_name
  LET ls_from_path     = p_from_path
  LET ls_to_path       = p_to_path
  LET lo_template_list = p_template_list

  LET ls_separator = os.Path.separator()
  LET lb_copy_result = TRUE
  LET lb_return      = TRUE
  
  CALL sadzp050_zip_get_lang_type_list() RETURNING lo_lang_arr

  LET li_tple_cnt_all = lo_template_list.getLength()
  FOR li_tple_cnt = 1 TO li_tple_cnt_all
    LET ls_component_name = lo_template_list[li_tple_cnt].tl_COMPONENT
    IF ls_component_name = ls_file_name THEN 
    
      #Copy 4RP File
      LET li_frp_cnt_all = lo_template_list[li_tple_cnt].FRP_LIST.getLength()
      #複製到各語系的4rp
      FOR li_lang_cnt = 1 TO lo_lang_arr.getLength()
        FOR li_frp_cnt = 1 TO li_frp_cnt_all 
          LET ls_4rp_name = lo_template_list[li_tple_cnt].FRP_LIST[li_frp_cnt].fl_NAME

          LET ls_src_file = ls_from_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".4rp"
          LET ls_dst_file = ls_to_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".4rp"
          
          --DISPLAY "[4rp Source]",ls_src_file
          --DISPLAY "[4rp Target]",ls_dst_file
          CALL os.Path.copy(ls_src_file,ls_dst_file) RETURNING lb_copy_result
          --IF NOT lb_copy_result THEN GOTO _return END IF -- 之後要取消
        END FOR
      END FOR 
      LET lb_copy_result = TRUE -- 暫時設為 True, 之後要拿掉
      
    END IF 
  END FOR 

  LABEL _return:
  
  IF (NOT lb_copy_result) THEN
    DISPLAY cs_error_tag," Copy file from '",ls_src_file,"' to '",ls_dst_file,"'"
    LET ls_err_code = "adz-00269"
    LET ls_err_msg  = ls_src_file,"|",ls_dst_file,"|"
    CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)

    LET lb_return = lb_copy_result
    
  END IF   
    
  RETURN lb_return

END FUNCTION

FUNCTION sadzp050_zip_get_lang_type_list()
DEFINE
  lo_lang_arr  DYNAMIC ARRAY OF T_LANGUAGE_TYPE,
  li_count     INTEGER,
  ls_sql       STRING 
DEFINE
  lo_return DYNAMIC ARRAY OF T_LANGUAGE_TYPE

  LET ls_sql = "SELECT GZZY001    ", 
               "  FROM GZZY_T     ", 
               " ORDER BY GZZY001 "
               
  PREPARE lpre_get_lang_type_list FROM ls_sql
  DECLARE lcur_get_lang_type_list CURSOR FOR lpre_get_lang_type_list

  LET li_count = 1
  
  OPEN lcur_get_lang_type_list
  FOREACH lcur_get_lang_type_list INTO lo_lang_arr[li_count]  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_count = li_count + 1

  END FOREACH
  CLOSE lcur_get_lang_type_list

  FREE lcur_get_lang_type_list
  FREE lpre_get_lang_type_list
  
  CALL lo_lang_arr.deleteElement(li_count)
  
  LET lo_return = lo_lang_arr

  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzp050_zip_make_module_directory(p_dir_pid,p_lang)
DEFINE 
  p_dir_pid STRING,
  p_lang    STRING
DEFINE
  ls_dir_pid      STRING,
  ls_lang         STRING, 
  ls_sql          STRING,
  ls_module_list  STRING,
  ls_module_path  STRING,
  ls_module_name  VARCHAR(30),
  ls_module_env   STRING,
  ls_src_path     STRING,
  li_mkdir        INTEGER,
  ls_copy_tbls    STRING,
  ls_separator    STRING
DEFINE
  ls_return STRING  

  LET ls_dir_pid = p_dir_pid
  LET ls_lang    = p_lang

  LET ls_separator = os.Path.separator()
  
  LET ls_module_list = ""
  
  #BEGIN:20160107 by elena 產生基礎資料模組資料夾改抓GZZO
  #LET ls_sql = "SELECT DZEA003 MODULE_NAME ", 
  #             "  FROM DZEA_T              ",
  #             " GROUP BY DZEA003          ",
  #             " ORDER BY DZEA003          " 
  
  LET ls_sql = "SELECT ML.*                                                          ",
               "FROM (SELECT ZO.GZZO001 MODULE_NAME                                  ",
               "      FROM GZZO_T ZO                                                 ",
               "      WHERE 1 = 1                                                    ",
               "      UNION ALL                                                      ",
               "      SELECT ZJ.GZZJ001 MODULE_NAME                                  ",
               "      FROM GZZJ_T ZJ                                                 ",
               "      WHERE NOT EXISTS                                               ",
               "            (SELECT 1 FROM GZZO_T ZO WHERE ZO.GZZO001 = ZJ.GZZJ001)  ",
               "      ) ML                                                           ",
               "ORDER BY ML.MODULE_NAME                                              "

  #END:20160107 by elena
 
  PREPARE lpre_module_list FROM ls_sql
  DECLARE lcur_module_list CURSOR FOR lpre_module_list
  
  OPEN lcur_module_list
  FOREACH lcur_module_list INTO ls_module_name  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_module_env = ls_module_name

    #建立模組目錄
    LET ls_module_path = ls_dir_pid||ls_separator||ls_module_env.toLowerCase()
    CALL os.Path.mkdir(ls_module_path) RETURNING li_mkdir
    LET ls_module_path = ls_module_path||ls_separator||"tbl"
    CALL os.Path.mkdir(ls_module_path) RETURNING li_mkdir

    #複製模組相關Table資料到 Temp Dir
    LET ls_src_path = FGL_GETENV(ls_module_env.toUpperCase())
    LET ls_copy_tbls = "cp ",ls_src_path||ls_separator||"dzx"||ls_separator||"tbl"||ls_separator||ls_lang||ls_separator||"*.tbl "||ls_module_path
    DISPLAY "Copy tbl files : ",ls_copy_tbls 
    RUN ls_copy_tbls
    
    LET ls_module_list = ls_module_list,ls_module_env.toLowerCase(),ls_separator,"tbl",ls_separator,"* "
    LET ls_module_list = ls_module_list,ls_module_env.toLowerCase(),ls_separator,"* "
    
  END FOREACH
  
  CLOSE lcur_module_list

  FREE lcur_module_list
  FREE lpre_module_list

  LET ls_return = ls_module_list

  RETURN ls_return

END FUNCTION

FUNCTION sadzp050_zip_rename_client_filename(p_path,p_file_name,p_ext_name)
DEFINE
  p_path      STRING,
  p_file_name STRING,
  p_ext_name  STRING
DEFINE
  ls_path      STRING,
  ls_file_name STRING,
  ls_ext_name  STRING,
  ls_destination_file STRING,
  ls_full_dest_name   STRING, #170111-00006
  ls_command   STRING,
  lb_result    BOOLEAN
DEFINE
  lb_return BOOLEAN

  LET ls_path      = p_path
  LET ls_file_name = p_file_name
  LET ls_ext_name  = p_ext_name

  LET ls_destination_file = ls_path,ls_file_name,".",ls_ext_name
  LET ls_full_dest_name   = ls_destination_file,".bak"

  #將原檔案更名為備份
  LET ls_command = "cmd.exe /C \"copy ",ls_destination_file," ",ls_full_dest_name," /y" 
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  IF lb_result THEN DISPLAY cs_message_tag,"Rename file ",ls_destination_file," to ",ls_full_dest_name," OK !" ELSE DISPLAY cs_warning_tag,"Rename file ",ls_destination_file," to ",ls_full_dest_name," unsuccess : ",ls_command END IF
  IF lb_result THEN CALL sadzp050_zip_grant_clinet_permission(ls_full_dest_name,FALSE) RETURNING lb_result END IF #170111-00006

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION
 
#目前無使用
FUNCTION sadzp050_zip_download_program_zip(p_file_name,p_module_name,p_source_path,p_destination_path,p_zip_ext_name,p_modulefolder) #20151231 by elena
DEFINE
  p_file_name        STRING,
  p_module_name      STRING,
  p_source_path      STRING,
  p_destination_path STRING,
  p_zip_ext_name     STRING,
  P_modulefolder     STRING  #20151231 by elena
DEFINE
  ls_file_name         STRING,
  ls_module_name       STRING,
  ls_source_path       STRING,
  ls_destination_path  STRING,
  ls_zip_ext_name      STRING,
  ls_source_file       STRING,
  ls_destination_file  STRING,
  ls_compress_ext_name STRING,
  lb_result            BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET ls_file_name        = p_file_name
  LET ls_module_name      = p_module_name
  LET ls_source_path      = p_source_path     

  #BEGIN:20151231 by elena
  IF p_modulefolder = "Y" THEN
    LET ls_destination_path = p_destination_path,ls_module_name,"\\"
  ELSE   
    LET ls_destination_path = p_destination_path 
  END IF
  #END:20151231 by elena
  LET ls_zip_ext_name     = p_zip_ext_name
  
  LET ls_compress_ext_name = ls_zip_ext_name 

  LET ls_source_file      = ls_source_path,ls_file_name,".",ls_compress_ext_name
  LET ls_destination_file = ls_destination_path,ls_file_name,".",ls_compress_ext_name  

  #將Client端的檔案先作備份
  CALL sadzp050_zip_rename_client_filename(ls_destination_path,ls_file_name,ls_compress_ext_name) RETURNING lb_result 

  LET lb_result = TRUE
  TRY
    CALL FGL_PUTFILE(ls_source_file,ls_destination_file)
    DISPLAY "Download "||ls_compress_ext_name||" file "||ls_file_name||"."||ls_compress_ext_name||" success ! "
    CALL sadzp050_zip_grant_clinet_permission(ls_destination_file,FALSE) RETURNING lb_result #170111-00006
  CATCH
    LET lb_result = FALSE
    DISPLAY "Download "||ls_compress_ext_name||" file "||ls_file_name||"."||ls_compress_ext_name||" File Error ! "
  END TRY  
  
  LET lb_return = lb_result

  RETURN lb_return

END FUNCTION

#下載程式
FUNCTION sadzp050_zip_download_code_zip(p_file_name,p_module_name,p_source_path,p_destination_path,p_zip_ext_name,p_modulefolder)  #20151231 by elena
DEFINE
  p_file_name        STRING,
  p_module_name      STRING,
  p_source_path      STRING,
  p_destination_path STRING,
  p_zip_ext_name     STRING,
  p_modulefolder     STRING   #20151231 by elena
DEFINE
  ls_file_name         STRING,
  ls_module_name       STRING,
  ls_source_path       STRING,
  ls_destination_path  STRING,
  ls_zip_ext_name      STRING,
  ls_source_file       STRING,
  ls_destination_file  STRING,
  ls_compress_ext_name STRING,
  lb_result            BOOLEAN
DEFINE
  lb_return BOOLEAN, 
  ls_command STRING 

  LET ls_file_name        = p_file_name
  LET ls_module_name      = p_module_name
  LET ls_source_path      = p_source_path        

  #BEGIN: 20151231 by elena p_modulefolder="Y" 下載至模組資料夾
  IF p_modulefolder = "Y" THEN
    LET ls_destination_path = p_destination_path,ls_module_name.ToLowerCase(),"\\"
  ELSE
    LET ls_destination_path = p_destination_path
  END IF
  #END: 20151231 by elena
  LET ls_zip_ext_name = p_zip_ext_name

  #LET ls_compress_ext_name = cs_zip_name_tzc 
  LET ls_compress_ext_name = ls_zip_ext_name 

  LET ls_source_file      = ls_source_path,ls_file_name,".",ls_compress_ext_name
  #LET ls_destination_file = ls_destination_path,ls_file_name,".",ls_compress_ext_name #20151222 by elena
  LET ls_destination_file = ls_destination_path,ls_file_name,".",ls_compress_ext_name

  #新增資料夾  #elena
  LET ls_command = "cmd.exe /C \"mkdir ",ls_destination_path,""
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])

  #將Client端的檔案先作備份
  CALL sadzp050_zip_rename_client_filename(ls_destination_path,ls_file_name,ls_compress_ext_name) RETURNING lb_result
  
  LET lb_result = TRUE
  TRY
    CALL FGL_PUTFILE(ls_source_file,ls_destination_file)
    DISPLAY "Download code ",ls_compress_ext_name," file "||ls_file_name||"."||ls_compress_ext_name||" success ! "
    CALL sadzp050_zip_grant_clinet_permission(ls_destination_file,FALSE) RETURNING lb_result #170111-00006
  CATCH
    LET lb_result = FALSE
    DISPLAY "Download code ",ls_compress_ext_name," file "||ls_file_name||"."||ls_compress_ext_name||" File Error ! "
  END TRY  

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION

#下載G類報表樣板
FUNCTION sadzp050_zip_download_4rp_zip(p_file_name,p_module_name,p_source_path,p_destination_path,p_zip_ext_name,p_modulefolder)  #20151231 by elena add p_modulefolder
DEFINE
  p_file_name        STRING,
  p_module_name      STRING,
  p_source_path      STRING,
  p_destination_path STRING,
  p_zip_ext_name     STRING,
  p_modulefolder     STRING  #20151231 by elena
DEFINE
  ls_file_name         STRING,
  ls_module_name       STRING,
  ls_source_path       STRING,
  ls_destination_path  STRING,
  ls_zip_ext_name      STRING,
  ls_source_file       STRING,
  ls_destination_file  STRING,
  ls_compress_ext_name STRING,
  lb_result            BOOLEAN  
DEFINE
  lb_return  BOOLEAN,
  ls_command STRING   #20160108 by elena 

  LET ls_file_name        = p_file_name
  LET ls_module_name      = p_module_name
  LET ls_source_path      = p_source_path
  
  ##BEGIN:20151231 by elena 
  #IF p_modulefolder = "Y" THEN
  #  LET ls_destination_path = p_destination_path,ls_module_name.ToLowerCase(),"\\"
  #ELSE        
    LET ls_destination_path = p_destination_path
  #END IF
  ##END:20151231 by elena

  LET ls_zip_ext_name     = p_zip_ext_name

  #LET ls_compress_ext_name = cs_zip_name_tzc 
  LET ls_compress_ext_name = ls_zip_ext_name 

  LET ls_source_file      = ls_source_path,ls_file_name,".",ls_compress_ext_name
  LET ls_destination_file = ls_destination_path,ls_file_name,cs_download_string,".",ls_compress_ext_name  

  LET lb_result = TRUE
  {
  #4rp暫存檔不需做備份
  #將Client端的檔案先作備份
  CALL sadzp050_zip_rename_client_filename(ls_destination_path,ls_file_name,ls_compress_ext_name) RETURNING lb_result
  }

  ##20160108 by elena 新增資料夾
  #IF p_modulefolder="Y" THEN
  #  LET ls_command = "cmd.exe /C \"mkdir ",ls_destination_path,""
  #  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  #END IF

  LET lb_result = TRUE
  TRY
    CALL FGL_PUTFILE(ls_source_file,ls_destination_file)
    DISPLAY "Download code ",ls_compress_ext_name," file "||ls_file_name||"."||ls_compress_ext_name||" success ! "
    CALL sadzp050_zip_grant_clinet_permission(ls_destination_file,FALSE) RETURNING lb_result #170111-00006
  CATCH
    LET lb_result = FALSE
    DISPLAY "Download code ",ls_compress_ext_name," file "||ls_file_name||"."||ls_compress_ext_name||" File Error ! "
  END TRY  

  LET lb_return = lb_result

  RETURN lb_return

END FUNCTION

#下載F,M,Q,S類規格
FUNCTION sadzp050_zip_download_form_zip(p_file_name,p_module_name,p_source_path,p_destination_path,p_zip_ext_name,p_modulefolder) #20151231 by elena
DEFINE
  p_file_name        STRING,
  p_module_name      STRING,
  p_source_path      STRING,
  p_destination_path STRING,
  p_zip_ext_name     STRING,
  p_modulefolder    STRING   #20151231 by elena
DEFINE
  ls_file_name         STRING,
  ls_module_name       STRING,
  ls_source_path       STRING,
  ls_destination_path  STRING,
  ls_zip_ext_name      STRING,
  ls_source_file       STRING,
  ls_destination_file  STRING,
  ls_compress_ext_name STRING,
  lb_result            BOOLEAN
DEFINE
  lb_return  BOOLEAN,
  ls_command STRING   #20160108 by elena

  LET ls_file_name        = p_file_name
  LET ls_module_name      = p_module_name
  LET ls_source_path      = p_source_path   

  #BEGIN:20151231 by elena 
  IF p_modulefolder = "Y" THEN
    LET ls_destination_path = p_destination_path,ls_module_name.ToLowerCase(),"\\"
  ELSE     
    LET ls_destination_path = p_destination_path
  END IF
  #END:20151231 by elena
  LET ls_zip_ext_name     = p_zip_ext_name

  #LET ls_compress_ext_name = cs_zip_name_tzc 
  LET ls_compress_ext_name = ls_zip_ext_name 

  LET ls_source_file      = ls_source_path,ls_file_name,".",ls_compress_ext_name
  LET ls_destination_file = ls_destination_path,ls_file_name,".",ls_compress_ext_name

  #20160108 by elena 新增資料夾
  IF p_modulefolder="Y" THEN
    LET ls_command = "cmd.exe /C \"mkdir ",ls_destination_path,""
    CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  END IF

  #將Client端的檔案先作備份
  CALL sadzp050_zip_rename_client_filename(ls_destination_path,ls_file_name,ls_compress_ext_name) RETURNING lb_result
  
  LET lb_result = TRUE
  TRY
    CALL FGL_PUTFILE(ls_source_file,ls_destination_file)
    DISPLAY "Download form ",ls_compress_ext_name," file "||ls_file_name||"."||ls_compress_ext_name||" success ! "
    CALL sadzp050_zip_grant_clinet_permission(ls_destination_file,FALSE) RETURNING lb_result #170111-00006
  CATCH
    LET lb_result = FALSE
    DISPLAY "Download form ",ls_compress_ext_name," file "||ls_file_name||"."||ls_compress_ext_name||" File Error ! "
  END TRY  

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION


#改為使用rsd (sadzp050_zip_download_rsd_zip)
FUNCTION sadzp050_zip_download_csd_zip(p_file_name,p_module_name,p_source_path,p_destination_path,p_zip_ext_name,p_modulefolder) #20151231 by elena
DEFINE
  p_file_name        STRING,
  p_module_name      STRING,
  p_source_path      STRING,
  p_destination_path STRING,
  p_zip_ext_name     STRING,
  P_modulefolder     STRING  #20151231 by elena
DEFINE
  ls_file_name         STRING,
  ls_module_name       STRING,
  ls_source_path       STRING,
  ls_destination_path  STRING,
  ls_zip_ext_name      STRING,
  ls_source_file       STRING,
  ls_destination_file  STRING,
  ls_compress_ext_name STRING,
  lb_result            BOOLEAN 
DEFINE
  lb_return  BOOLEAN,
  ls_command STRING    #20160108 by elena

  LET ls_file_name        = p_file_name
  LET ls_module_name      = p_module_name
  LET ls_source_path      = p_source_path     
  
  #BEGIN:20151231 by elena 
  IF p_modulefolder = "Y" THEN
    LET ls_destination_path = p_destination_path,ls_module_name.ToLowerCase(),"\\"
  ELSE   
    LET ls_destination_path = p_destination_path
  END IF
  #END:20151231 by elena
  LET ls_zip_ext_name     = p_zip_ext_name

  #LET ls_compress_ext_name = cs_zip_name_tzc 
  LET ls_compress_ext_name = ls_zip_ext_name 

  LET ls_source_file      = ls_source_path,ls_file_name,".",ls_compress_ext_name
  LET ls_destination_file = ls_destination_path,ls_file_name,".",ls_compress_ext_name  

  #20160108 by elena 新增資料夾
  IF p_modulefolder="Y" THEN
    LET ls_command = "cmd.exe /C \"mkdir ",ls_destination_path,""
    CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  END IF
  
  #將Client端的檔案先作備份
  CALL sadzp050_zip_rename_client_filename(ls_destination_path,ls_file_name,ls_compress_ext_name) RETURNING lb_result
  
  LET lb_result = TRUE
  TRY
    CALL FGL_PUTFILE(ls_source_file,ls_destination_file)
    DISPLAY "Download form ",ls_compress_ext_name," file "||ls_file_name||"."||ls_compress_ext_name||" success ! "
    CALL sadzp050_zip_grant_clinet_permission(ls_destination_file,FALSE) RETURNING lb_result #170111-00006
  CATCH
    LET lb_result = FALSE
    DISPLAY "Download form ",ls_compress_ext_name," file "||ls_file_name||"."||ls_compress_ext_name||" File Error ! "
  END TRY  

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION

#下載 B,G,X,W,Z 類規格
FUNCTION sadzp050_zip_download_rsd_zip(p_file_name,p_module_name,p_source_path,p_destination_path,p_zip_ext_name,p_modulefolder) #20151231 by elena
DEFINE
  p_file_name        STRING,
  p_module_name      STRING,
  p_source_path      STRING,
  p_destination_path STRING,
  p_zip_ext_name     STRING,
  p_modulefolder     STRING  #20151231 by elena
DEFINE
  ls_file_name         STRING,
  ls_module_name       STRING,
  ls_source_path       STRING,
  ls_destination_path  STRING,
  ls_zip_ext_name      STRING,
  ls_source_file       STRING,
  ls_destination_file  STRING,
  ls_compress_ext_name STRING,
  lb_result            BOOLEAN
DEFINE
  lb_return  BOOLEAN,  
  ls_command STRING   #20160108 by elena

  LET ls_file_name        = p_file_name
  LET ls_module_name      = p_module_name
  LET ls_source_path      = p_source_path     
  
  #BEGIN:20151231 by elena
  IF p_modulefolder = "Y" THEN
    LET ls_destination_path = p_destination_path,ls_module_name.ToLowerCase(),"\\"
  ELSE   
    LET ls_destination_path = p_destination_path
  END IF
  #END:20151231 by elena
  LET ls_zip_ext_name     = p_zip_ext_name

  #LET ls_compress_ext_name = cs_zip_name_tzc 
  LET ls_compress_ext_name = ls_zip_ext_name 

  LET ls_source_file      = ls_source_path,ls_file_name,".",ls_compress_ext_name
  LET ls_destination_file = ls_destination_path,ls_file_name,".",ls_compress_ext_name  

  #20160108 by elena 新增資料夾
  IF p_modulefolder="Y" THEN
    LET ls_command = "cmd.exe /C \"mkdir ",ls_destination_path,""
    CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  END IF

  #將Client端的檔案先作備份
  CALL sadzp050_zip_rename_client_filename(ls_destination_path,ls_file_name,ls_compress_ext_name) RETURNING lb_result
  
  LET lb_result = TRUE
  TRY
    CALL FGL_PUTFILE(ls_source_file,ls_destination_file)
    DISPLAY "Download form ",ls_compress_ext_name," file "||ls_file_name||"."||ls_compress_ext_name||" success ! "
    CALL sadzp050_zip_grant_clinet_permission(ls_destination_file,FALSE) RETURNING lb_result #170111-00006
  CATCH
    LET lb_result = FALSE
    DISPLAY "Download form ",ls_compress_ext_name," file "||ls_file_name||"."||ls_compress_ext_name||" File Error ! "
  END TRY  

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION

#下載基礎資料
FUNCTION sadzp050_zip_download_designer_zip(p_file_name,p_module_name,p_source_path,p_destination_path,p_modulefolder) #20151231 by elena
DEFINE
  p_file_name        STRING,
  p_module_name      STRING,
  p_source_path      STRING,
  p_destination_path STRING,
  p_modulefolder     STRING
DEFINE
  ls_file_name         STRING,
  ls_module_name       STRING,
  ls_source_path       STRING,
  ls_destination_path  STRING,
  ls_source_file       STRING,
  ls_destination_file  STRING,
  ls_compress_ext_name STRING,
  lb_result            BOOLEAN 
DEFINE
  lb_return  BOOLEAN,
  ls_command STRING    #20160108 by elena

  LET ls_file_name        = p_file_name
  LET ls_module_name      = p_module_name
  LET ls_source_path      = p_source_path       
  
  #BEGIN:20151231 by elena
  IF p_modulefolder = "Y" THEN
    LET ls_destination_path = p_destination_path,ls_module_name.ToLowerCase(),"\\"
  ELSE 
    LET ls_destination_path = p_destination_path
  END IF
  #END:20151231

  LET ls_compress_ext_name = "zip"  

  LET ls_source_file      = ls_source_path,ls_file_name,".",ls_compress_ext_name
  LET ls_destination_file = ls_destination_path,ls_file_name,".",ls_compress_ext_name 

  #20160108 by elena 新增資料夾 
  IF p_modulefolder="Y" THEN
    LET ls_command = "cmd.exe /C \"mkdir ",ls_destination_path,""
    CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  END IF

  #將Client端的檔案先作備份
  CALL sadzp050_zip_rename_client_filename(ls_destination_path,ls_file_name,ls_compress_ext_name) RETURNING lb_result
  
  LET lb_result = TRUE
  TRY
    CALL FGL_PUTFILE(ls_source_file,ls_destination_file)
    DISPLAY "Download Designer ",ls_compress_ext_name," file "||ls_file_name||"."||ls_compress_ext_name||" success ! "
    CALL sadzp050_zip_grant_clinet_permission(ls_destination_file,FALSE) RETURNING lb_result #170111-00006
  CATCH
    LET lb_result = FALSE
    DISPLAY "Download Designer ",ls_compress_ext_name," file "||ls_file_name||"."||ls_compress_ext_name||" File Error ! "
  END TRY  

  LET lb_return = lb_result

  RETURN lb_return

END FUNCTION

#以亂數產出副檔名
FUNCTION sadzp050_zip_gen_random_name()
DEFINE
  lr_randomname RECORD
    segment1 STRING,
    segment2 STRING,
    segment3 STRING,
    segment4 STRING
  END RECORD
DEFINE 
  li_random_value    INTEGER,
  li_max_random_num  INTEGER,
  ls_final_name      STRING,
  ls_GUID            STRING,
  ls_using_format    STRING
DEFINE  
  ls_return  STRING

  {
  LET li_max_random_num = 9999
  LET ls_using_format  = "&&&&"
  
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_randomname.segment1 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_randomname.segment2 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_randomname.segment3 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_randomname.segment4 = li_random_value USING ls_using_format
  
  LET ls_final_name = lr_randomname.segment1,".",
                      lr_randomname.segment2,".",
                      lr_randomname.segment3,".",
                      lr_randomname.segment4
  }
  
  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID
  
  LET ls_return = ls_GUID
  
  RETURN ls_return                     
  
END FUNCTION

#161028-00001 begin
FUNCTION sadzp050_zip_get_if_standard_to_customize(p_program_name)
DEFINE
  p_program_name  STRING
DEFINE
  ls_program_name  STRING,
  ls_sql           STRING,
  ls_min_value     VARCHAR(50),
  ls_max_value     VARCHAR(50)
DEFINE  
  lb_return  BOOLEAN

  LET ls_program_name = p_program_name

  LET ls_sql = "SELECT MIN(DZAF010) MIN_VALUE,         ",
               "       MAX(DZAF010) MAX_VALUE          ",
               "  FROM DZAF_T                          ",
               " WHERE DZAF001 = '",ls_program_name,"' " 
                               
  PREPARE lpre_get_if_standard_to_customize FROM ls_sql
  DECLARE lcur_get_if_standard_to_customize CURSOR FOR lpre_get_if_standard_to_customize

  OPEN lcur_get_if_standard_to_customize
  FETCH lcur_get_if_standard_to_customize INTO ls_min_value,ls_max_value
  CLOSE lcur_get_if_standard_to_customize
  
  FREE lpre_get_if_standard_to_customize
  FREE lcur_get_if_standard_to_customize  

  LET lb_return = IIF(ls_min_value <> ls_max_value,TRUE,FALSE)
  
  RETURN lb_return
  
END FUNCTION
#161028-00001 end

#170111-00006 begin
FUNCTION sadzp050_zip_grant_clinet_permission(p_full_name,p_is_directory)
DEFINE
  p_full_name    STRING,
  p_is_directory BOOLEAN
DEFINE
  ls_full_name    STRING,
  lb_is_directory BOOLEAN,
  ls_command      STRING,
  lb_result       BOOLEAN,
  ls_recursive    STRING
DEFINE
  lb_return  BOOLEAN  

  LET ls_full_name = p_full_name
  LET lb_is_directory = p_is_directory

  LET ls_recursive = ""
  IF lb_is_directory THEN
    LET ls_recursive = "/T"
  END IF  

  LET lb_result = TRUE
  
  LET ls_command = "cmd.exe /C \"icacls ",ls_full_name," /grant Everyone:F ",ls_recursive,""
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  IF lb_result THEN DISPLAY cs_message_tag,"Grant permission to ",ls_full_name," OK !" ELSE DISPLAY cs_warning_tag,"Grant permission to ",ls_full_name," unsuccess : ",ls_command END IF

  LET lb_return = TRUE

  RETURN lb_return
  
END FUNCTION
#170111-00006 end

#170208-00008 begin
FUNCTION sadzp050_zip_get_dzbi_if_exists(p_program_name)
DEFINE
  p_program_name  STRING
DEFINE
  ls_program_name  STRING,
  ls_sql           STRING,
  li_count         INTEGER
DEFINE  
  lb_return  BOOLEAN

  LET ls_program_name = p_program_name

  LET ls_sql = "SELECT COUNT(1)                           ",
               "  FROM DZBI_T BI                          ",
               " WHERE BI.DZBI001 = '",ls_program_name,"' "
                                
  PREPARE lpre_get_dzbi_if_exists FROM ls_sql
  DECLARE lcur_get_dzbi_if_exists CURSOR FOR lpre_get_dzbi_if_exists

  OPEN lcur_get_dzbi_if_exists
  FETCH lcur_get_dzbi_if_exists INTO li_count
  CLOSE lcur_get_dzbi_if_exists
  
  FREE lpre_get_dzbi_if_exists
  FREE lcur_get_dzbi_if_exists  

  LET lb_return = IIF(li_count > 0,TRUE,FALSE)
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp050_zip_get_dzbj_if_exists(p_program_name)
DEFINE
  p_program_name  STRING
DEFINE
  ls_program_name  STRING,
  ls_sql           STRING,
  li_count         INTEGER
DEFINE  
  lb_return  BOOLEAN

  LET ls_program_name = p_program_name

  LET ls_sql = "SELECT COUNT(1)                           ",
               "  FROM DZBJ_T BJ                          ",
               " WHERE BJ.DZBJ007 = '",ls_program_name,"' "
                                
  PREPARE lpre_get_dzbj_if_exists FROM ls_sql
  DECLARE lcur_get_dzbj_if_exists CURSOR FOR lpre_get_dzbj_if_exists

  OPEN lcur_get_dzbj_if_exists
  FETCH lcur_get_dzbj_if_exists INTO li_count
  CLOSE lcur_get_dzbj_if_exists
  
  FREE lpre_get_dzbj_if_exists
  FREE lcur_get_dzbj_if_exists  

  LET lb_return = IIF(li_count > 0,TRUE,FALSE)
  
  RETURN lb_return
  
END FUNCTION
#170208-00008 end


#170124-00011 begin
FUNCTION sadzp050_zip_delete_4rp_files(p_file_name,p_from_path,p_template_list)
DEFINE 
  p_file_name     STRING,
  p_from_path     STRING,
 #p_to_path       STRING,
  p_template_list DYNAMIC ARRAY OF T_TEMPLATE_LIST_R
DEFINE
  ls_file_name      STRING,
  ls_from_path      STRING,
 #ls_to_path        STRING,
  lo_template_list  DYNAMIC ARRAY OF T_TEMPLATE_LIST_R,
  ls_src_file       STRING,
  ls_dst_file       STRING,
  lb_delete_result    BOOLEAN,
  li_tple_cnt       INTEGER,
  li_frp_cnt        INTEGER,
  li_tple_cnt_all   INTEGER,
  li_frp_cnt_all    INTEGER,
  ls_component_name STRING,
  ls_4rp_name       STRING,
  ls_separator      STRING,
  ls_err_code       STRING,
  ls_err_msg        STRING,
  li_lang_cnt       INTEGER,
  lo_lang_arr       DYNAMIC ARRAY OF T_LANGUAGE_TYPE
DEFINE
  ls_return STRING,
  lb_return BOOLEAN  
DEFINE ls_cmd       STRING

  LET ls_file_name     = p_file_name
  LET ls_from_path     = p_from_path
 #LET ls_to_path       = p_to_path
  LET lo_template_list = p_template_list

  LET ls_separator = os.Path.separator()
  LET lb_delete_result = TRUE
  LET lb_return      = TRUE
  
  CALL sadzp050_zip_get_lang_type_list() RETURNING lo_lang_arr

  LET li_tple_cnt_all = lo_template_list.getLength()
  FOR li_tple_cnt = 1 TO li_tple_cnt_all
    LET ls_component_name = lo_template_list[li_tple_cnt].tl_COMPONENT
    IF ls_component_name = ls_file_name THEN 
    
      #Delete 4RP File
      LET li_frp_cnt_all = lo_template_list[li_tple_cnt].FRP_LIST.getLength()
      #刪除各語系的4rp
      FOR li_lang_cnt = 1 TO lo_lang_arr.getLength()
        FOR li_frp_cnt = 1 TO li_frp_cnt_all 
          LET ls_4rp_name = lo_template_list[li_tple_cnt].FRP_LIST[li_frp_cnt].fl_NAME

         #LET ls_src_file = ls_from_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".4rp"
         #LET ls_dst_file = ls_to_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".4rp"
          LET ls_src_file = ls_from_path,ls_separator,lo_lang_arr[li_lang_cnt],ls_separator,ls_4rp_name,".*"
          
          LET ls_cmd = "rm -rf ",ls_src_file
          --DISPLAY "[4rp Source]",ls_cmd
          RUN ls_cmd
          --CALL os.Path.delete(ls_src_file) RETURNING lb_delete_result
          --IF NOT lb_delete_result THEN GOTO _return END IF -- 之後要取消
        END FOR
      END FOR 
      LET lb_delete_result = TRUE -- 暫時設為 True, 之後要拿掉
      
    END IF 
  END FOR 

  LABEL _return:
  
  IF (NOT lb_delete_result) THEN
    DISPLAY cs_error_tag," Delete file from '",ls_src_file,"'"
    LET ls_err_code = "adz-00953"
    LET ls_err_msg  = ls_src_file
    CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)

    LET lb_return = lb_delete_result
    
  END IF   
    
  RETURN lb_return

END FUNCTION
#170124-00011 end

#170208-00008 begin
FUNCTION sadzp050_zip_get_standard_module_name(p_src_module_name)
DEFINE
  p_src_module_name  STRING
DEFINE
  ls_return          STRING,
  ls_sql             STRING,
  ls_src_module_name STRING,
  ls_dst_module_name VARCHAR(20)

  LET ls_src_module_name = p_src_module_name

  LET ls_sql = "SELECT GZZJ003                            ",
               "  FROM GZZJ_T                             ",
               " WHERE GZZJ001 = '",ls_src_module_name,"' " 
  
  PREPARE lpre_get_standard_module_name FROM ls_sql
  DECLARE lcur_get_standard_module_name CURSOR FOR lpre_get_standard_module_name
  OPEN lcur_get_standard_module_name
  FETCH lcur_get_standard_module_name INTO ls_dst_module_name
  CLOSE lcur_get_standard_module_name
  FREE lcur_get_standard_module_name
  FREE lpre_get_standard_module_name

  LET ls_return = NVL(ls_dst_module_name,ls_src_module_name)
  
  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp050_zip_get_if_source_file_exists(p_program_name,p_module_name)
DEFINE
  p_program_name  STRING,
  p_module_name   STRING
DEFINE
  ls_program_name  STRING,
  ls_module_name   STRING,
  ls_full_path     STRING,
  ls_separator     STRING
DEFINE
  lb_return  BOOLEAN  

  LET ls_separator = os.Path.separator()
  LET lb_return = TRUE

  LET ls_program_name = p_program_name
  LET ls_module_name  = p_module_name

  LET ls_full_path = FGL_GETENV(sadzp050_zip_get_standard_module_name(ls_module_name)),ls_separator,"4gl",ls_separator,ls_program_name,cs_4gl_src_ext

  IF NOT os.Path.exists(ls_full_path) THEN
    LET lb_return = FALSE
  END IF

  RETURN lb_return  
  
END FUNCTION
#170208-00008 end