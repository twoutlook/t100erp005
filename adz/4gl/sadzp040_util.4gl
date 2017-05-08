IMPORT os
IMPORT util

SCHEMA ds

#匯入adzp080的常數設定   
&include "../4gl/sadzp000_cnst.inc" 
&include "../4gl/adzp080_cnst.inc" 

FUNCTION sadzp040_util_generate_designer_files(p_lang)
DEFINE
  p_lang STRING
DEFINE 
  ls_lang       STRING,
  lb_result     BOOLEAN,
  ls_message    STRING,
  ls_err_no     STRING,
  ls_top_env    STRING,
  li_base_count INTEGER
  

  LET ls_lang = p_lang
  
  #LET ls_err_no = ""
  LET ls_top_env = FGL_GETENV("TOP")
  LET lb_result = TRUE

  CALL sadzp010_1_get_file_cnt() RETURNING li_base_count
  LET li_base_count = li_base_count + 1
  
  CALL cl_progress_bar(li_base_count)

  CALL sadzp010_1_gen_base_data() RETURNING lb_result,ls_message
  IF NOT lb_result THEN GOTO _fault END IF

  {
  #Call adzp010 functions
  LET ls_message  = "[adzp040] Call sadzp010_1_gen_checks_xml"
  DISPLAY cs_message_tag,ls_message
  CALL adzp040_set_progress(ls_message)
  CALL cl_progress_ing(ls_message)
  CALL sadzp010_1_gen_checks_xml() RETURNING lb_result
  IF NOT lb_result THEN GOTO _fault END IF
  
  LET ls_message  = "[adzp040] Call sadzp010_1_gen_zooms_xml"
  DISPLAY cs_message_tag,ls_message
  CALL adzp040_set_progress(ls_message)
  CALL cl_progress_ing(ls_message)
  CALL sadzp010_1_gen_zooms_xml() RETURNING lb_result
  IF NOT lb_result THEN GOTO _fault END IF
  
  LET ls_message  = "[adzp040] Call sadzp010_1_gen_items_xml"
  DISPLAY cs_message_tag,ls_message
  CALL adzp040_set_progress(ls_message)
  CALL cl_progress_ing(ls_message)
  CALL sadzp010_1_gen_items_xml() RETURNING lb_result
  IF NOT lb_result THEN GOTO _fault END IF
  
  LET ls_message  = "[adzp040] Call sadzp010_1_gen_prog_rel_xml"
  DISPLAY cs_message_tag,ls_message
  CALL adzp040_set_progress(ls_message)
  CALL cl_progress_ing(ls_message)
  CALL sadzp010_1_gen_prog_rel_xml() RETURNING lb_result
  IF NOT lb_result THEN GOTO _fault END IF
  
  LET ls_message  = "[adzp040] Call sadzp010_1_gen_sub_xml"
  DISPLAY cs_message_tag,ls_message
  CALL adzp040_set_progress(ls_message)
  CALL cl_progress_ing(ls_message)
  CALL sadzp010_1_gen_sub_xml() RETURNING lb_result
  IF NOT lb_result THEN GOTO _fault END IF
  
  LET ls_message  = "[adzp040] Call sadzp010_1_gen_lib_xml"
  DISPLAY cs_message_tag,ls_message
  CALL adzp040_set_progress(ls_message)
  CALL cl_progress_ing(ls_message)
  CALL sadzp010_1_gen_lib_xml() RETURNING lb_result
  IF NOT lb_result THEN GOTO _fault END IF

  #2013.06.11 移除不下載
  #2013.09.06 恢復
  LET ls_message  = "[adzp040] Call sadzp010_1_gen_messages_xml"
  DISPLAY cs_message_tag,ls_message
  CALL adzp040_set_progress(ls_message)
  CALL cl_progress_ing(ls_message)
  CALL sadzp010_1_gen_messages_xml() RETURNING lb_result
  IF NOT lb_result THEN GOTO _fault END IF

  LET ls_message  = "[adzp040] Call sadzp010_1_gen_code_sample_xml"
  DISPLAY cs_message_tag,ls_message
  CALL adzp040_set_progress(ls_message)
  CALL cl_progress_ing(ls_message)
  CALL sadzp010_1_gen_code_sample_xml() RETURNING lb_result
  IF NOT lb_result THEN GOTO _fault END IF
  
  LET ls_message  = "[adzp040] Call sadzp010_1_gen_tree_kind_xml"
  DISPLAY cs_message_tag,ls_message
  CALL adzp040_set_progress(ls_message)
  CALL cl_progress_ing(ls_message)
  CALL sadzp010_1_gen_tree_kind_xml() RETURNING lb_result
  IF NOT lb_result THEN GOTO _fault END IF

  
  #LET ls_message  = "[adzp040] Call sadzi140_xml_gen_table_data_types_XML"
  #DISPLAY cs_message_tag,ls_message
  #CALL adzp040_set_progress(ls_message)
  #CALL cl_progress_ing(ls_message)
  #CALL sadzi140_xml_gen_table_data_types_XML(ls_top_env||"/com/mta/"||ls_lang||"/datatypes.xml")
  }
  
  LET ls_message  = "[adzp040] Call sadzi140_xml_gen_table_list"
  DISPLAY cs_message_tag,ls_message
  CALL cl_progress_ing(ls_message)
  CALL sadzi140_xml_gen_table_list(ls_top_env||"/com/mta/"||ls_lang||"/tables.xml",ls_lang)

  LABEL _fault:

  IF NOT lb_result THEN
    CALL cl_progress_bar_close()
    DISPLAY cs_error_tag," Generate designer files not success."
    DISPLAY cs_message_tag," ",ls_message
  END IF
  
  RETURN lb_result,ls_message
  
END FUNCTION

FUNCTION sadzp040_util_parse_4fd(p_prog_name, p_module_name, p_version, p_dgenv,p_lang)
DEFINE
  p_prog_name    STRING,
  p_module_name  STRING,
  p_version      STRING,
  p_dgenv        STRING,
  p_lang         STRING 
DEFINE
  ls_prog_name    STRING,
  ls_module_name  STRING,
  ls_version      STRING,
  ls_dgenv        STRING, 
  ls_lang         STRING, 
  ls_module_env   STRING,
  ls_sub_root     STRING,
  li_chdir_result STRING,
  lb_result       BOOLEAN,
  ls_message      STRING,
  ls_debug_info   STRING,
  ls_retinfo      STRING,
  ls_err_no       STRING

  LET ls_prog_name    = p_prog_name
  LET ls_module_name  = p_module_name.toLowerCase()
  LET ls_version      = p_version.Trim()
  LET ls_dgenv        = p_dgenv
  LET ls_lang         = p_lang

  LET ls_err_no = "adz-00137"
  
  LET ls_sub_root   = "4fd"
  LET ls_module_env = os.Path.join(FGL_GETENV(p_module_name.toUpperCase()),ls_sub_root)

  CALL os.Path.chdir(ls_module_env) RETURNING li_chdir_result
  
  LET ls_message  = "Parse form (4fd) "||ls_prog_name

  LET lb_result = TRUE
  TRY
    DISPLAY "sadzp168_3 version : ",ls_version 
    LET ls_debug_info = ls_message,"\n",
                        "Call sadzp168_3 : Program Name -> ",ls_prog_name,"\n",
                        "                  Module Name  -> ",ls_module_name,"\n",
                        "                  Version      -> ",ls_version,"\n",
                        "                  DGENV        -> ",ls_dgenv    

    CALL sadzp168_3(ls_module_name, ls_prog_name,ls_version,ls_dgenv) RETURNING lb_result,ls_retinfo
    DISPLAY cs_message_tag,ls_retinfo
  CATCH
    LET lb_result = FALSE
  END TRY  
  
  IF NOT lb_result THEN
    DISPLAY "[",ls_err_no,"]",cl_getmsg(ls_err_no, ls_lang)
  END IF
  
  RETURN lb_result    
  
END FUNCTION

FUNCTION sadzp040_util_generate_tsd(p_prog_name,p_module_name,p_sd_version,p_spec_type,p_std_program,p_std_sd_version,p_dgenv)
DEFINE
  p_prog_name      STRING,
  p_module_name    STRING,
  p_sd_version     STRING,
  p_spec_type      STRING,
  p_std_program    STRING,
  p_std_sd_version STRING,
  p_dgenv          STRING
DEFINE 
  ls_prog_name      STRING,
  ls_module_name    STRING,
  ls_sd_version     STRING,
  ls_spec_type      STRING,
  ls_std_program    STRING,
  ls_std_sd_version STRING,
  ls_dgenv          STRING,
  ls_message        STRING,
  ls_err_no         STRING,
  lb_result         BOOLEAN

  LET ls_prog_name      = p_prog_name
  LET ls_module_name    = p_module_name
  LET ls_sd_version     = p_sd_version
  LET ls_spec_type      = p_spec_type
  LET ls_std_program    = p_std_program
  LET ls_std_sd_version = p_std_sd_version
  LET ls_dgenv          = p_dgenv
  
  LET lb_result   = TRUE
  
  #LET ls_err_no = ""
  
  TRY
    LET ls_message  = "Call sadzp030_tsd_gen_tsd to generate "||ls_prog_name||".tsd"
    DISPLAY cs_message_tag,ls_message
    DISPLAY cs_information_tag,ls_message
    --CALL adzp040_set_progress(ls_message)
    
    DISPLAY "Prog_name : ",ls_prog_name,"\n",
            "Module_name : ",ls_module_name,"\n",
            "Sd_version : ",ls_sd_version,"\n",
            "Spec_type : ",ls_spec_type,"\n",
            "Std_program : ",ls_std_program,"\n",
            "Std_sd_version : ",ls_std_sd_version,"\n",
            "DGENV : ",ls_dgenv,"\n"
    
    CALL sadzp030_tsd_gen_tsd(ls_prog_name,ls_module_name,ls_sd_version,ls_spec_type,ls_std_program,ls_std_sd_version,ls_dgenv) RETURNING lb_result 
    
  CATCH
    LET lb_result = FALSE
  END TRY
  
  IF NOT lb_result THEN
    DISPLAY "[ERROR] Generate tsd file unsuccess."
  END IF

  RETURN lb_result
  
END FUNCTION