&include "../4gl/sadzp360_mcr.inc"

IMPORT util 
IMPORT os 
IMPORT security
IMPORT xml

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp360_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp360_type.inc"

#執行的環境變數
DEFINE 
  ms_lang         STRING,
  mb_backend_mode BOOLEAN,
  ms_guid         VARCHAR(60),
  mo_arguments    T_ARGUMENTS,
  mb_result       BOOLEAN
            
FUNCTION sadzp360_run(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ARGUMENTS 
  
  CALL sadzp360_initialize(p_backend_mode,p_arguments.*)
  CALL sadzp360_start() RETURNING mb_result
  CALL sadzp360_finalize()

  RETURN mb_result

END FUNCTION

FUNCTION sadzp360_initialize(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ARGUMENTS

  LET mb_backend_mode = p_backend_mode
  LET mo_arguments.*  = p_arguments.*

  &ifndef DEBUG
    LET ms_lang = NVL(g_lang,cs_default_lang)
  &else
    LET ms_lang = cs_default_lang
  &endif

  LET ms_guid = security.RandomGenerator.CreateUUIDString()
  
END FUNCTION

FUNCTION sadzp360_start()
DEFINE
  lb_result      BOOLEAN,
  lo_aps_tables  DYNAMIC ARRAY OF T_APS_TABLE_LIST,
  lb_status      BOOLEAN,
  ls_file_path   STRING
DEFINE
  lb_return  BOOLEAN

  LET lb_result = TRUE
  LET lb_status = TRUE

  #先刪除殘留的暫存資料
  CALL sadzp360_delete_dzlm_data_for_aps_table_export() RETURNING lb_result
  IF NOT lb_result THEN LET lb_status = FALSE END IF

  #取得有賦予給 APS 的表格, 並產出匯出清單到 dzlm_t
  CALL sadzp360_get_aps_granted_table_list() RETURNING lo_aps_tables
  CALL sadzp360_gen_dzlm_data_for_aps_table_export(lo_aps_tables) RETURNING lb_result
  IF NOT lb_result THEN LET lb_status = FALSE END IF

  CALL sadzp360_export_aps_tables(ms_guid) RETURNING lb_result,ls_file_path
  IF NOT lb_result THEN LET lb_status = FALSE END IF
  
  #最後刪除暫存資料
  CALL sadzp360_delete_dzlm_data_for_aps_table_export() RETURNING lb_result
  IF NOT lb_result THEN LET lb_status = FALSE END IF
  
  LET lb_return = lb_status
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp360_finalize()
END FUNCTION

FUNCTION sadzp360_get_aps_granted_table_list()
DEFINE
  li_rec_count   INTEGER,
  ls_sql         STRING,
  lo_aps_tables  DYNAMIC ARRAY OF T_APS_TABLE_LIST
DEFINE
  lo_return  DYNAMIC ARRAY OF T_APS_TABLE_LIST
  
  INITIALIZE lo_aps_tables TO NULL
  
  LET ls_sql = "SELECT EA.DZEA001                              ",
               "  FROM DZEA_T EA                               ",
               " WHERE EXISTS (                                ",
               "                SELECT 1                       ",
               "                  FROM DZEN_T EN               ",
               "                 WHERE EN.DZEN001 = EA.DZEA001 ",
               "                   AND EN.DZEN003 = 'dsaps'    ",
               "              )                                ",
               " ORDER BY EA.DZEA001                           "
 
  PREPARE lpre_get_aps_granted_table_list FROM ls_sql
  DECLARE lcur_get_aps_granted_table_list CURSOR FOR lpre_get_aps_granted_table_list

  LET li_rec_count = 1

  OPEN lcur_get_aps_granted_table_list
  FOREACH lcur_get_aps_granted_table_list INTO lo_aps_tables[li_rec_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_count = li_rec_count + 1

  END FOREACH
  CALL lo_aps_tables.deleteElement(li_rec_count)
  
  CLOSE lpre_get_aps_granted_table_list
  CLOSE lcur_get_aps_granted_table_list
  
  LET lo_return = lo_aps_tables
  
  RETURN lo_return
  
END FUNCTION 

FUNCTION sadzp360_gen_dzlm_data_for_aps_table_export(p_aps_tables)
DEFINE
  p_aps_tables  DYNAMIC ARRAY OF T_APS_TABLE_LIST
DEFINE
  lo_aps_tables  DYNAMIC ARRAY OF T_APS_TABLE_LIST,
  ls_dzlm003     VARCHAR(120),
  li_loop        INTEGER,
  ldt_datetime   DATETIME YEAR TO SECOND
DEFINE
  lb_return BOOLEAN
  
  LET lo_aps_tables = p_aps_tables

  LET ls_dzlm003 = cs_exp_aps_dzlm003
  LET lb_return = TRUE

  &ifndef DEBUG
  LET ldt_datetime = cl_get_current()
  &else
  LET ldt_datetime = CURRENT YEAR TO SECOND
  &endif

  BEGIN WORK
  
  TRY 
    FOR li_loop = 1 TO lo_aps_tables.getLength()
      INSERT INTO DZLM_T (
                           DZLM001, DZLM002, DZLM003, DZLM004, DZLM005, 
                           DZLM006, DZLM007, DZLM008, DZLM009, DZLM010, 
                           DZLM011, DZLM012, DZLM013, DZLM014, DZLM015, 
                           DZLM016, DZLM017, DZLM018, DZLM019, DZLM020, 
                           DZLM021, DZLM022
                         ) 
                  VALUES ( 
                           "T", lo_aps_tables[li_loop].atl_TABLE_NAME,ls_dzlm003, "ZZZ", ci_construct_no, 
                           ci_version_no, "tiptop", "I", NULL, NULL, 
                           NULL, cs_reauest_no, "T100ERP", "1.0", ci_reauest_seq, 
                           NULL, ldt_datetime, ms_guid, "", "N", 
                           "N", "P"
                         );
    END FOR
    
    COMMIT WORK
    
    DISPLAY cs_success_tag,"Insert APS export data into DZLM_T success." 
    
  CATCH
    DISPLAY cs_error_tag,"Insert APS export data into DZLM_T fail, rollback transaction."
    ROLLBACK WORK  
    LET lb_return = FALSE
  END TRY  

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp360_delete_dzlm_data_for_aps_table_export()
DEFINE
  ls_dzlm003  VARCHAR(120)
DEFINE
  lb_return BOOLEAN
  
  LET ls_dzlm003 = cs_exp_aps_dzlm003
  LET lb_return = TRUE

  BEGIN WORK
  
  TRY 
    DELETE
      FROM DZLM_T
     WHERE 1=1
       AND DZLM001 = 'T'
       AND DZLM003 = ls_dzlm003
       AND DZLM005 = ci_construct_no
       AND DZLM012 = cs_reauest_no
       AND DZLM015 = ci_reauest_seq
   
    COMMIT WORK

    DISPLAY cs_success_tag,"Delete APS export data from DZLM_T success." 
    
  CATCH
    DISPLAY cs_error_tag,"Delete APS export data from DZLM_T not success, rollback transaction."
    ROLLBACK WORK  
    LET lb_return = FALSE
  END TRY  

  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp360_export_aps_tables(p_guid)
DEFINE
  p_guid  STRING
DEFINE
  ls_guid     STRING,
  ls_temp_dir STRING,
  ls_curr_dir STRING,
  lb_result   BOOLEAN,
  lb_status   BOOLEAN,
  ls_export_path  STRING, 
  ls_separator    STRING,
  ls_aps_exp_dir  STRING,
  ls_all_message  STRING,
  lo_export_info  T_EXPORT_INFO,
  lo_file_dialog  T_FILE_DIALOG,
  lo_putfile_para T_PUT_GET_FILE_PARA
DEFINE
  lb_return  BOOLEAN,
  ls_return  STRING     

  LET ls_guid = p_guid

  LET lb_status = TRUE
  LET ls_separator = os.Path.separator()
  LET ls_curr_dir = os.Path.pwd()
  LET ls_temp_dir = FGL_GETENV("TEMPDIR")
  LET ls_aps_exp_dir = "adzp360_aps_export_",ls_guid

  #切換到暫存目錄建立工作區, 並切換到該區
  CALL os.Path.chdir(ls_temp_dir) RETURNING lb_result
  IF NOT lb_result THEN LET lb_status = FALSE END IF 
  CALL os.Path.mkdir(ls_aps_exp_dir) RETURNING lb_result
  IF NOT lb_result THEN LET lb_status = FALSE END IF 
  CALL os.Path.chdir(ls_aps_exp_dir) RETURNING lb_result
  IF NOT lb_result THEN LET lb_status = FALSE END IF

  LET ls_export_path = ls_temp_dir,ls_separator,ls_aps_exp_dir
  
  DISPLAY cs_message_tag,"Directory change to : ",ls_export_path 

  #產生匯出參考 xml 檔
  CALL sadzp360_gen_exp_xml_file()   
  #呼叫 adzp230 產出匯出檔
  CALL sadzp360_export_table_with_adzp230(ls_export_path) RETURNING lb_result,ls_all_message,lo_export_info.*

  IF os.Path.exists(lo_export_info.TAR_NAME) THEN 
    #設定傳送到 Client 端資訊
    CALL sadzp360_dlg_set_dialog_parameter(ls_export_path,"TAR File","*.tgz","Export APS table package") RETURNING lo_file_dialog.*
    CALL sadzp360_dlg_save_dir_dialog(lo_file_dialog.*) RETURNING lo_export_info.CLIENT_PATH
    CALL sadzp360_exp_set_putfile_parameter(lo_export_info.WORKING_PATH,lo_export_info.TAR_NAME,lo_export_info.CLIENT_PATH,lo_export_info.TAR_NAME) RETURNING lo_putfile_para.*
    IF NVL(lo_putfile_para.CLIENT_FILE_PATH,cs_null_value) <> cs_null_value THEN
      CALL sadzp360_exp_save_to_client(lo_putfile_para.*)
      CALL sadzp000_msg_show_info(NULL, 'adz-00922', NULL, 0)
    END IF   
  ELSE
    DISPLAY cs_error_tag,"Export file not exists, can not send to client !"  
  END IF   
  
  #切回原目錄
  CALL os.Path.chdir(ls_curr_dir) RETURNING lb_result
  
  DISPLAY cs_message_tag,"Directory change to : ",ls_curr_dir 
  
  RETURN lb_return,ls_return
  
END FUNCTION

FUNCTION sadzp360_gen_exp_xml_file()
DEFINE
  lo_xml_aps_document  xml.DomDocument,
  lo_xml_exp_elements  xml.DomNode,
  lo_exp_node_xml      xml.DomNode
  
  #產出 XML 標頭
  LET lo_xml_aps_document = xml.DomDocument.CreateDocument("patch")
  LET lo_xml_exp_elements = lo_xml_aps_document.getDocumentElement()
  CALL lo_xml_exp_elements.setAttribute("patch_no",cs_aps_exp_patch_no)
  LET lo_exp_node_xml = lo_xml_exp_elements.appendChildElement("request")
  CALL lo_exp_node_xml.setAttribute("no",cs_reauest_no)
  CALL lo_exp_node_xml.setAttribute("sequence",ci_reauest_seq)

  #開檔將String Buffer寫入實體檔案
  CALL lo_xml_aps_document.setFeature("format-pretty-print", "TRUE")
  CALL lo_xml_aps_document.save(cs_aps_exp_xml_ref)

  IF os.Path.exists(cs_aps_exp_xml_ref) THEN 
    DISPLAY cs_message_tag,"APS exp refernece XML file generate success !"
  ELSE
    DISPLAY cs_error_tag,"APS exp refernece XML file generate fail !"
  END IF  
  
END FUNCTION

FUNCTION sadzp360_export_table_with_adzp230(p_path)
DEFINE
  p_path  STRING
DEFINE 
  ls_path          STRING, 
  lb_result        BOOLEAN, 
  lo_channel       base.Channel,
  ls_exp_file_path STRING,
  ls_separator     STRING,
  ls_message       STRING,
  ls_err_message   STRING,
  ls_all_message   STRING,
  ls_command       STRING,
  li_line_num      INTEGER,
  lo_export_info   T_EXPORT_INFO  
DEFINE
  lb_return  BOOLEAN,
  ls_return  STRING,  
  lo_return  T_EXPORT_INFO

  LET ls_path = p_path

  LET lb_result = TRUE
  LET lb_return = TRUE
  LET li_line_num = 0
  LET ls_all_message = ""
  LET ls_separator = os.Path.separator()
  LET ls_exp_file_path = ls_path,ls_separator,cs_aps_exp_xml_ref
  
  LET lo_channel = base.Channel.create()
  CALL lo_channel.setDelimiter("")

  LET ls_command = "r.r adzp230 iexp ","'",ls_exp_file_path,"'"," | tee sadzp360_exportaps.log"
  DISPLAY cs_command_tag,ls_command

  #執行
  CALL lo_channel.openPipe(ls_command,"r")
  
  WHILE TRUE
    CALL lo_channel.readLine() RETURNING ls_message
    IF lo_channel.isEof() THEN
      EXIT WHILE
    END IF

    LET li_line_num = li_line_num + 1
    DISPLAY "[",(li_line_num USING "&&&&&"),"] ",ls_message

    #取得匯出目錄
    IF ls_message.getIndexOf(cs_exp_table_pack_path,1) > 0 THEN
      LET lo_export_info.WORKING_PATH = ls_message.subString(cs_exp_table_pack_path.getLength() + 1,ls_message.getLength()) 
    END IF
    #取得匯出檔案
    IF ls_message.getIndexOf(cs_exp_table_pack_name,1) > 0 THEN
      LET lo_export_info.TAR_NAME = ls_message.subString(cs_exp_table_pack_name.getLength() + 1,ls_message.getLength()) 
    END IF

    LET ls_all_message = ls_all_message,ls_message,"\n"

    LET ls_err_message = ls_message.toUpperCase()
    IF ls_err_message.getIndexOf("ERROR" ,1) THEN
      LET lb_result = FALSE
    END IF
  END WHILE
  CALL lo_channel.close()

  LET lb_return = lb_result
  LET ls_return = ls_all_message
  LET lo_return.* = lo_export_info.*

  RETURN lb_return,ls_return,lo_return.*
  
END FUNCTION

#Dialog Section
FUNCTION sadzp360_dlg_set_dialog_parameter(p_param1,p_param2,p_param3,p_param4)
DEFINE
  p_param1,p_param2,p_param3,p_param4 STRING
DEFINE
  lo_open_dialog T_FILE_DIALOG
DEFINE
  lo_return T_FILE_DIALOG

  LET lo_open_dialog.PATH       = p_param1
  LET lo_open_dialog.TYPE_DESC  = p_param2
  LET lo_open_dialog.TYPE_LIST  = p_param3
  LET lo_open_dialog.CAPTION    = p_param4
  
  LET lo_return.* = lo_open_dialog.*

  RETURN lo_return.*
  
END FUNCTION 

FUNCTION sadzp360_dlg_save_dir_dialog(p_save_dialog)
DEFINE
  p_save_dialog T_FILE_DIALOG
DEFINE
  ls_rtn_name STRING   
DEFINE
  ls_return STRING   

  CALL ui.interface.frontCall("standard","opendir",[p_save_dialog.PATH,p_save_dialog.CAPTION],[ls_rtn_name])

  LET ls_return = ls_rtn_name

  RETURN ls_return
  
END FUNCTION  

#Export Section
FUNCTION sadzp360_exp_set_putfile_parameter(p_param1,p_param2,p_param3,p_param4)
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

FUNCTION sadzp360_exp_save_to_client(mo_parameter)
DEFINE
  mo_parameter T_PUT_GET_FILE_PARA
DEFINE
  lo_parameter    T_PUT_GET_FILE_PARA,
  ls_source       STRING,
  ls_destination  STRING,
  ls_os_separator STRING  

  LET lo_parameter.* = mo_parameter.*

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator 

  LET ls_source      = lo_parameter.SERVER_FILE_PATH,ls_os_separator,lo_parameter.SERVER_FILE_NAME
  LET ls_destination = lo_parameter.CLIENT_FILE_PATH,ls_os_separator,lo_parameter.CLIENT_FILE_NAME

  DISPLAY cs_message_tag,"Source File : ",ls_source
  DISPLAY cs_message_tag,"Destination File : ",ls_destination 

  TRY 
    CALL FGL_PUTFILE(ls_source,ls_destination)
  CATCH
    DISPLAY cs_error_tag,"The file ",lo_parameter.SERVER_FILE_NAME," can not put to client side."
  END TRY  
  
END FUNCTION 
