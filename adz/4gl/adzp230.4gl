#  異動型態    異動單號       日 期       異動者      異動內容
#  ========= ============= ========== ========== ===============================================
#  Modify                  2016.12.26 Ernestliou 1.配合其他匯出修改(ex.APS)

&include "../4gl/sadzi140_mcr.inc"

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzi140_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzi140_type.inc"

#執行的環境變數
DEFINE 
  mb_fault             BOOLEAN,
  ms_patch_no_or_path  STRING,
  ms_patch_serial_no   STRING,
  ms_work_type         STRING,
  ms_GUID              STRING,
  ms_sequence          STRING 
            
MAIN
     
  CALL adzp230_initialize()
  CALL adzp230_start()
  CALL adzp230_finalize()
    
END MAIN

FUNCTION adzp230_initialize()

  &ifndef DEBUG
    CALL cl_tool_init()
    CALL cl_db_connect("ds", TRUE)
    #CALL cl_ap_init("adz", "") 
    #DISCONNECT CURRENT
    #CONNECT TO "ds"
    LET ms_work_type        = ARG_VAL(2) 
    LET ms_patch_no_or_path = ARG_VAL(3)
    LET ms_patch_serial_no  = ARG_VAL(4)
    LET ms_GUID             = ARG_VAL(5)
    LET ms_sequence         = ARG_VAL(6)
  &else
    CONNECT TO "local"
    
    #LET ms_work_type        = "iexp"
    #LET ms_patch_no_or_path = "C:\\temp\\adzp230_table.xml"

    LET ms_work_type        = "iimp"
    LET ms_patch_no_or_path = "C:\\temp\\150310-00009T\\150310-00009T.tgz"

    
    #LET ms_patch_no_or_path = "999999-99999"
    #LET ms_patch_serial_no  = "9"
    
    #LET ms_patch_no_or_path = "C:\\temp\\999999-99999T\\999999-99999T.tgz" 
    #LET ms_patch_serial_no  = "-ID"
    #LET ms_GUID             = "039F97C3-E95F-41F0-845C-65CD409D0E38"
    #LET ms_sequence         = "1"
    
  &endif

  #設定最佳化架構
  #CALL sadzi140_db_alter_optimizer_feature()
  
  IF (ms_patch_no_or_path.trim() IS NULL) OR (
                                               (ms_work_type <> cs_exim_export) AND 
                                               (ms_work_type <> cs_exim_import) AND 
                                               (ms_work_type <> cs_exim_dump) #2016.12.26
                                             ) THEN
    LET mb_fault = TRUE
    CALL adzp230_show_help()
    CALL adzp230_finalize()
  END IF 

END FUNCTION

FUNCTION adzp230_start()
DEFINE
  lb_result     BOOLEAN,
  ls_TAR_path   STRING,
  ls_TAR_name   STRING,
  li_time_start DATETIME YEAR TO SECOND,
  li_time_end   DATETIME YEAR TO SECOND

  &ifndef DEBUG
    LET li_time_start = cl_get_current()
  &else
    LET li_time_start = CURRENT YEAR TO SECOND
  &endif  
  
  CASE NVL(ms_work_type.ToLowerCase(),cs_null_value)
    WHEN cs_exim_export  
      CALL sadzi888_04_export_run(ms_patch_no_or_path,ms_patch_serial_no) RETURNING lb_result,ls_TAR_path
    WHEN cs_exim_import  
      CALL sadzi888_04_import_run(ms_patch_no_or_path,ms_GUID,ms_sequence) RETURNING lb_result
    #2016.12.26 begin  
    WHEN cs_exim_dump  
      CALL sadzi888_04_export_run(ms_patch_no_or_path,cs_exim_dump) RETURNING lb_result,ls_TAR_path
    #2016.12.26 end  
  END CASE

  &ifndef DEBUG
    LET li_time_end = cl_get_current()
  &else
    LET li_time_end = CURRENT YEAR TO SECOND
  &endif  

  DISPLAY cs_information_tag,"Start Time : ",li_time_start
  DISPLAY cs_information_tag," End  Time : ",li_time_end
  
END FUNCTION

FUNCTION adzp230_finalize()

  IF mb_fault THEN
    EXIT PROGRAM -1 
  ELSE
    EXIT PROGRAM 
  END IF
  
END FUNCTION

FUNCTION adzp230_show_help()

  DISPLAY "\n",
          "Usage : ","\n",
          "  r.r ",ui.Interface.getName()," [iexp/iimp] [PatchNo/PatchFullPathName] [PatchSerialNo]","\n",
          "  r.r ",ui.Interface.getName()," [iimp] [PatchFullPathName] -ID [GUID] [SequenceNo]","\n",
          "  r.r ",ui.Interface.getName()," [idmp] [GUID]","\n", #2016.12.26
          "\n",
          "Ex. ","\n",
          "  For Export :","\n",
          "   1.Export as patch package (ex. A000000999T.tgz) :","\n",
          "     r.r ",ui.Interface.getName()," iexp A000000999","\n",
          "   2.Export as 'TABLE_EXPORT_PACKAGE.tgz' :","\n",
          "     r.r ",ui.Interface.getName()," iexp '131212-00002' 99","\n",
          "   3.Export as pass package with xml definition (ex. C150107-001T.tgz) :","\n",
          "     r.r ",ui.Interface.getName()," iexp '/u3/usr/john/C150107-001T.xml'","\n",
          "\n", #2016.12.26
          "  For customize export/dump table schema :","\n", #2016.12.26
          "   r.r ",ui.Interface.getName()," idmp 'A0B2FD40-014F-4EDD-9C1A-9AC25215BDBE'","\n", #2016.12.26
          "\n",
          "  For Import :","\n",
          "   1.Search for patch package :","\n",
          "     r.r ",ui.Interface.getName()," iimp '/u3/usr/john/A000000999T.tgz' ","\n",
          "   2.Search for 'TABLE_EXPORT_PACKAGE.tgz' :","\n",
          "     r.r ",ui.Interface.getName()," iimp '/u3/usr/marry' ","\n",
          "\n",
          "  For Patch Manager Import :","\n",
          "   r.r ",ui.Interface.getName()," iimp '/u3/usr/john/A000000777T_12.tgz' -ID 'A0B2FD40-014F-4EDD-9C1A-9AC25215BDBE' '12'"

END FUNCTION 