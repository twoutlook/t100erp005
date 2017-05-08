# Modify         : 2015/11/09 by Hiko : 1.改善上傳效能:r.c3第四個參數預設為2:只做組合器以後的事:包含編譯和鏈結.
#                                       2.報表元件規格上傳不需要tab gen.
#                                       3.重產是包含tab gen, 所以程式的地方也得加上判斷條件.
#                                       4.執行r.c/r.f改成呼叫cl_cmdrun_openpipe().
#                                       5.由adzp080跳出錯誤訊息即可.

#&define DEBUG

IMPORT os
IMPORT util

SCHEMA ds

#匯入adzp080的常數設定   
&include "../4gl/sadzp000_cnst.inc" 
&include "../4gl/adzp080_cnst.inc" 

PRIVATE TYPE T_PROGRAM_TYPE RECORD
               temp_ver    VARCHAR(10), 
               temp_type   VARCHAR(10),
               temp_name   VARCHAR(50)
             END RECORD

DEFINE ms_lang    STRING 

DEFINE
  mi_progress     INTEGER,
  ms_progress_all STRING,
  mb_back_job     BOOLEAN,
  mb_result       BOOLEAN 

DEFINE 
  mi_spend_time DATETIME HOUR TO SECOND

&ifndef DEBUG
GLOBALS "../../cfg/top_global.inc"
&endif

MAIN
  CALL adzp040_initialize()
  CALL adzp040_start()
  CALL adzp040_finalize()
END MAIN

FUNCTION adzp040_initialize()
DEFINE
  ls_erp_path STRING,
  ls_arg_val1 STRING,
  ls_back_job STRING 

  LET ls_arg_val1 = ARG_VAL(2)          #Program Name
  LET ls_back_job = NVL(ARG_VAL(7),"N") #Background runtime

  IF ls_arg_val1 IS NULL THEN
    DISPLAY "\n",
            "Usage : r.r ",ui.Interface.getName()," [ProgramName.ext] [ModuleName] [SpecType] [Spec Version] [Code Version]","\n",
            "        r.r ",ui.Interface.getName()," [GENDATA]","\n",
            "        r.r ",ui.Interface.getName()," [GENTSD] [ProgramName] [ModuleName] [SpecType] [Spec Version] [Code Version] [Std Program] [Std Spec Version] [Std Code Version]","\n"
    EXIT PROGRAM
  END IF
  
  LET mi_progress = 0
  LET mb_result = TRUE

  CALL FGL_GETENV(cs_erp_path) RETURNING ls_erp_path

  IF ls_back_job = "Y" THEN
    LET mb_back_job = TRUE
  ELSE
    LET mb_back_job = FALSE
  END IF
  
  {
  IF NOT mb_back_job THEN
    CLOSE WINDOW SCREEN
  END IF  
  
  &ifndef DEBUG
    #依模組進行系統初始化設定(系統設定)
    CALL cl_tool_init()
    OPEN WINDOW w_adzp041 WITH FORM cl_ap_formpath("ADZ","adzp041")
    #CONNECT TO "ds"
    LET ms_lang = g_lang
  &else
    OPEN WINDOW w_adzp041 WITH FORM "adzp041"
    CONNECT TO "local"
    LET ms_lang = cs_default_lang
  &endif
  
  CURRENT WINDOW IS w_adzp041

  #瀏覽頁簽資料初始化
  CALL cl_ui_init()

  IF NOT mb_back_job THEN
    CALL ui.Interface.loadStyles(ls_erp_path||"/cfg/4st/adzp040")
  END IF  
  }

  &ifndef DEBUG
    #依模組進行系統初始化設定(系統設定)
    CALL cl_tool_init()
    LET g_bgjob = ls_back_job
    #DISPLAY "g_bgjob : ",g_bgjob
    LET ms_lang = g_lang
  &else
    CONNECT TO "local"
    LET ms_lang = cs_default_lang
  &endif

END FUNCTION

FUNCTION adzp040_start()
DEFINE
  ls_prog_name       STRING,
  ls_ext_name        STRING,
  ls_module_name     STRING,
  ls_arg_val1        STRING,
  ls_arg_val2        STRING,
  ls_arg_val3        STRING,
  ls_arg_val4        STRING,
  ls_arg_val5        STRING,
  ls_arg_val6        STRING,
  ls_arg_val7        STRING,
  ls_arg_val8        STRING,
  ls_arg_val9        STRING,
  ls_arg_val10       STRING,
  ls_zip_type        STRING,
  ls_upload_doc_type STRING,
  ls_message         STRING,
  lb_result          BOOLEAN,
  ls_sd_version      STRING,
  ls_pr_version      STRING,
  ls_std_prog_name   STRING,
  ls_std_sd_version  STRING,
  ls_std_pr_version  STRING,
  ls_spec_type       STRING,
  ls_exec_type       STRING,  
  ls_DGENV           STRING,  
  ls_identity        STRING,
  ls_err_msg         STRING,
  ls_err_no          STRING,
  ls_type            STRING,
  ls_tiptop          STRING,  
  lo_program_type    T_PROGRAM_TYPE,
  li_time_start      DATETIME YEAR TO SECOND,
  li_time_end        DATETIME YEAR TO SECOND  

  LET lb_result = FALSE
  LET ls_exec_type = ARG_VAL(2)

  IF ls_exec_type = "GENTSD" THEN
    LET ls_arg_val1  = ARG_VAL(3)  #Program Name
    LET ls_arg_val2  = ARG_VAL(4)  #Module Name
    LET ls_arg_val3  = ARG_VAL(5)  #Upload Document Type (SPEC or CODE)
    LET ls_arg_val4  = ARG_VAL(6)  #SDVersionCode/SpecType(GENTSD)
    LET ls_arg_val5  = ARG_VAL(7)  #PRVersionCode/Version(GENTSD)
    LET ls_arg_val6  = ARG_VAL(8)  #Standard Program
    LET ls_arg_val7  = ARG_VAL(9)  #Standard SDVersionCode/SpecType(GENTSD)
    LET ls_arg_val8  = ARG_VAL(10) #Standard PRVersionCode/Version(GENTSD)  
    LET ls_arg_val9  = ARG_VAL(11) #DGENV
    LET ls_arg_val10 = ARG_VAL(12) #Type
  ELSE
    LET ls_arg_val1  = ARG_VAL(2)  #Program Name
    LET ls_arg_val2  = ARG_VAL(3)  #Module Name
    LET ls_arg_val3  = ARG_VAL(4)  #Upload Document Type (SPEC or CODE)
    LET ls_arg_val4  = ARG_VAL(5)  #SDVersionCode/SpecType(GENTSD)
    LET ls_arg_val5  = ARG_VAL(6)  #PRVersionCode/Version(GENTSD)
    LET ls_arg_val6  = ARG_VAL(7)  #Standard Program
    LET ls_arg_val7  = ARG_VAL(8)  #Standard SDVersionCode/SpecType(GENTSD)
    LET ls_arg_val8  = ARG_VAL(9)  #Standard PRVersionCode/Version(GENTSD)  
    LET ls_arg_val9  = ARG_VAL(10) #DGENV
    LET ls_arg_val10 = ARG_VAL(11) #Type
  END IF 

  DISPLAY "ls_arg_val1  : ",ls_arg_val1 
  DISPLAY "ls_arg_val2  : ",ls_arg_val2 
  DISPLAY "ls_arg_val3  : ",ls_arg_val3 
  DISPLAY "ls_arg_val4  : ",ls_arg_val4 
  DISPLAY "ls_arg_val5  : ",ls_arg_val5 
  DISPLAY "ls_arg_val6  : ",ls_arg_val6 
  DISPLAY "ls_arg_val7  : ",ls_arg_val7 
  DISPLAY "ls_arg_val8  : ",ls_arg_val8 
  DISPLAY "ls_arg_val9  : ",ls_arg_val9 
  DISPLAY "ls_arg_val10 : ",ls_arg_val10
  
  LET ls_prog_name      = ls_arg_val1
  LET ls_module_name    = ls_arg_val2
  LET ls_spec_type      = ls_arg_val3
  LET ls_sd_version     = ls_arg_val4
  LET ls_pr_version     = ls_arg_val5
  LET ls_std_prog_name  = NVL(ls_arg_val6,ls_prog_name)
  LET ls_std_sd_version = ls_arg_val7
  LET ls_DGENV          = ls_arg_val9
      
  IF (ls_exec_type.toUpperCase() = "GENDATA") OR (ls_exec_type.toUpperCase() = "GENTSD") THEN
    LET ls_zip_type = ls_exec_type.toUpperCase()
    LET ls_upload_doc_type = ""
    CALL adzp040_get_adzp040_progress_all(ls_zip_type,ls_upload_doc_type) RETURNING ms_progress_all
    IF ls_exec_type.toUpperCase() = "GENDATA" THEN
      LET ls_ext_name  = cs_zip_name_tzp
      CALL sadzp040_util_generate_designer_files(ms_lang) RETURNING lb_result,ls_message
    ELSE
      #2014.06.10 加入 Parse 4fd
      CALL sadzp040_util_parse_4fd(ls_prog_name, ls_module_name, ls_sd_version, ls_DGENV,ms_lang) RETURNING lb_result 
      IF NOT lb_result THEN GOTO _ERROR END IF
      CALL sadzp040_util_generate_tsd(ls_prog_name,ls_module_name,ls_sd_version,ls_spec_type,ls_std_prog_name,ls_std_sd_version,ls_DGENV) RETURNING lb_result
      IF NOT lb_result THEN GOTO _ERROR END IF
    END IF
    LABEL _ERROR:
    CALL adzp040_set_adzp040_progress_all(ls_zip_type,ls_upload_doc_type,mi_progress)
  ELSE
  
    #取得程式名稱及副檔名
    IF ls_arg_val1.getIndexOf(".",1) > 1 THEN
      LET ls_prog_name = ls_arg_val1.subString(1,ls_arg_val1.getIndexOf(".",1)-1)
      LET ls_ext_name  = ls_arg_val1.subString(ls_arg_val1.getIndexOf(".",1)+1,ls_arg_val1.getLength())
    ELSE
      LET ls_prog_name = ls_arg_val1
      LET ls_ext_name  = cs_zip_name_tzp
    END IF

    LET ls_zip_type = ls_ext_name

    
    #取得模組名稱
    IF ls_arg_val2 IS NULL THEN
      LET ls_module_name = ls_prog_name.subString(1,3)
      LET ls_module_name = ls_module_name.toUpperCase()
    ELSE  
      LET ls_module_name = ls_arg_val2.trim()
    END IF  

    LET ls_upload_doc_type = ls_arg_val3

    #取得程式類型(M,B ...)
    LET ls_type = sadzp060_2_chk_spec_type(ls_prog_name)
    LET ls_type = ls_type.toUpperCase()

    {
    #2015.01.06 Marked
    IF ((ls_type.trim() <> 'M') AND (ls_type.trim() <> 'Z')) THEN  
      IF (
           ls_upload_doc_type.toUpperCase() = cs_doc_type_code OR 
           ls_upload_doc_type.toUpperCase() = cs_doc_type_specgen OR 
           ls_upload_doc_type.toUpperCase() = cs_doc_type_gcode
         ) THEN    
        LET ls_err_no = "adz-00485"
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code =  ls_err_no
        LET g_errparam.extend = ls_message
        LET g_errparam.popup = TRUE
        LET g_errparam.type = 2
        CALL cl_err()
      END IF  
    END IF
    }
    
    #取得Progress的總筆數
    CALL adzp040_get_adzp040_progress_all(ls_zip_type,ls_upload_doc_type) RETURNING ms_progress_all

    #SPEC/SPECGEN/CSPEC/RSPEC 時執行
    IF (
        ls_upload_doc_type.toUpperCase() = cs_doc_type_spec OR 
        ls_upload_doc_type.toUpperCase() = cs_doc_type_specgen OR 
        ls_upload_doc_type.toUpperCase() = cs_doc_type_cspec OR
        ls_upload_doc_type.toUpperCase() = cs_doc_type_rspec 
       ) THEN
      #Update tsd
      LET lb_result = TRUE
      CALL adzp040_set_progress("")
      LET li_time_start = cl_get_current() 
      CALL adzp040_update_sd_data(ls_upload_doc_type,ls_zip_type,ls_prog_name,ls_module_name,ls_DGENV) RETURNING lb_result
      LET li_time_end = cl_get_current()
      DISPLAY cs_information_tag,"Update SPEC Data START Time : ",li_time_start  
      DISPLAY cs_information_tag,"Update SPEC Data  END Time : ",li_time_end  
      LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
      IF NOT lb_result THEN GOTO _complete END IF
    END IF 

    #SPEC/SPECGEN 時執行
    IF (ls_upload_doc_type.toUpperCase() = cs_doc_type_spec OR ls_upload_doc_type.toUpperCase() = cs_doc_type_specgen) THEN

      IF (ls_type = "M") OR (ls_type = "S") OR (ls_type = "F") OR (ls_type = "Q") THEN 

        #20141204 區分類別
        LET ls_tiptop = "tiptop"
        IF ls_type = "M" THEN
          LET ls_tiptop = ""
        END IF

        #編譯 4fd
        LET lb_result = TRUE
        CALL adzp040_set_progress("")
        LET li_time_start = cl_get_current() 
        CALL adzp040_compile_4fd(ls_prog_name,ls_module_name,ls_tiptop) RETURNING lb_result
        LET li_time_end = cl_get_current()
        DISPLAY cs_information_tag,"Compile 4fd START Time : ",li_time_start  
        DISPLAY cs_information_tag,"Compile 4fd  END Time : ",li_time_end  
        LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
        IF NOT lb_result THEN GOTO _complete END IF #2015/11/09 by Hiko

        #Parse 4fd
        LET lb_result = TRUE
        CALL adzp040_set_progress("")
        LET li_time_start = cl_get_current() 
        CALL adzp040_parse_4fd(ls_prog_name,ls_module_name,ls_sd_version,ls_DGENV) RETURNING lb_result
        LET li_time_end = cl_get_current()
        DISPLAY cs_information_tag,"Parse 4fd START Time : ",li_time_start  
        DISPLAY cs_information_tag,"Parse 4fd  END Time : ",li_time_end  
        LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
        IF NOT lb_result THEN GOTO _complete END IF
        
        LET lb_result = TRUE
        #分析 4fd 和 4gl 資訊, 錯誤的話不管它
        LET li_time_start = cl_get_current() 
        CALL adzp040_analyze_4fd_4gl(ls_prog_name,ls_sd_version,ls_DGENV) RETURNING lb_result
        LET li_time_end = cl_get_current()
        DISPLAY cs_information_tag,"Analyze 4fd START Time : ",li_time_start  
        DISPLAY cs_information_tag,"Analyze 4fd  END Time : ",li_time_end  
        LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
        --IF NOT lb_result THEN GOTO _complete END IF
      
      END IF   

    END IF 

    {    
    #SPEC/SPECGEN 時執行
    #20141204 marked
    IF (
        ls_upload_doc_type.toUpperCase() = cs_doc_type_spec OR 
        ls_upload_doc_type.toUpperCase() = cs_doc_type_specgen  
       ) THEN
       
      LET lb_result = TRUE
      #分析 4fd 和 4gl 資訊, 錯誤的話不管它
      LET li_time_start = cl_get_current() 
      CALL adzp040_analyze_4fd_4gl(ls_prog_name,ls_sd_version,ls_DGENV) RETURNING lb_result
      LET li_time_end = cl_get_current()
      DISPLAY cs_information_tag,"Analyze 4fd START Time : ",li_time_start  
      DISPLAY cs_information_tag,"Analyze 4fd  END Time : ",li_time_end  
      LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
      --IF NOT lb_result THEN GOTO _complete END IF
      
    END IF 
    }

    #SPEC 時執行
    IF (
         ls_upload_doc_type.toUpperCase() = cs_doc_type_spec
       ) THEN

      #Gen tab
      #2015.10.19 改為SPEC呼叫
      LET lb_result = TRUE
      CALL adzp040_set_progress("")
      LET li_time_start = cl_get_current() 
      #Begin:2015/11/09 by Hiko
      IF (ls_arg_val10.toUpperCase() MATCHES "[MSQ]") THEN #只有M/S/Q類的規格才會影響程式,所以才需要特別在規格上傳的時候先檢查規格設定的正確性.
      #IF (ls_arg_val10.toUpperCase() = "G" OR ls_arg_val10.toUpperCase() = "X") THEN
      #  CALL adzp040_generate_tab(ls_prog_name,lo_program_type.*,ls_pr_version,ls_DGENV) RETURNING lb_result
      #ELSE
      #End:2015/11/09 by Hiko
        IF ls_sd_version IS NULL THEN
          CALL sadzp060_2_get_spec_curr_revision(ls_prog_name, ls_arg_val10.toUpperCase(), ls_module_name) RETURNING ls_sd_version,ls_identity,ls_err_msg
        END IF
        CALL adzp040_generate_tab(ls_prog_name,lo_program_type.*,ls_sd_version,ls_DGENV) RETURNING lb_result
      END IF 
      LET li_time_end = cl_get_current()
      DISPLAY cs_information_tag,"Generate Tab START Time : ",li_time_start  
      DISPLAY cs_information_tag,"Generate Tab  END Time : ",li_time_end  
      LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
      IF NOT lb_result THEN GOTO _complete END IF
      
    END IF   
    
    #CODE/SPECGEN/GCODE 時執行
    IF (
         ls_upload_doc_type.toUpperCase() = cs_doc_type_code OR 
         ls_upload_doc_type.toUpperCase() = cs_doc_type_specgen OR 
         ls_upload_doc_type.toUpperCase() = cs_doc_type_gcode
       ) THEN

      #Update tap
      LET lb_result = TRUE
      CALL adzp040_set_progress("")
      LET li_time_start = cl_get_current() 
      CALL adzp040_update_tap(ls_upload_doc_type,ls_zip_type,ls_prog_name,ls_module_name,ls_DGENV) RETURNING lb_result
      LET li_time_end = cl_get_current()
      DISPLAY cs_information_tag,"Update tap data START Time : ",li_time_start  
      DISPLAY cs_information_tag,"Update tap data  END Time : ",li_time_end  
      LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
      IF NOT lb_result THEN GOTO _complete END IF

      #Gen tab
      #2014.06.10 改為不呼叫
      #2014.07.09 改回呼叫,且區分為若為G,X類,則給PR
      #           若SD Version為空, 則呼叫sadzp060_2_get_spec_curr_revision取得之
      #2014.09.24 改為不呼叫
      LET lb_result = TRUE
      CALL adzp040_set_progress("")
      IF sadzp060_2_is_regen(ls_prog_name) OR sadzp030_tab_file_template_renewed(ls_prog_name) THEN #2015/11/09 by Hiko
         LET li_time_start = cl_get_current() 
         IF (ls_arg_val10.toUpperCase() = "G" OR ls_arg_val10.toUpperCase() = "X") THEN
           CALL adzp040_generate_tab(ls_prog_name,lo_program_type.*,ls_pr_version,ls_DGENV) RETURNING lb_result
         ELSE
           IF ls_sd_version IS NULL THEN
             CALL sadzp060_2_get_spec_curr_revision(ls_prog_name, ls_arg_val10.toUpperCase(), ls_module_name) RETURNING ls_sd_version,ls_identity,ls_err_msg
           END IF
           CALL adzp040_generate_tab(ls_prog_name,lo_program_type.*,ls_sd_version,ls_DGENV) RETURNING lb_result
         END IF 
         LET li_time_end = cl_get_current()
         DISPLAY cs_information_tag,"Generate Tab START Time : ",li_time_start  
         DISPLAY cs_information_tag,"Generate Tab  END Time : ",li_time_end  
         LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
         IF NOT lb_result THEN GOTO _complete END IF
      END IF
   
      #產生 tgl 及 4gl 及 42s 及 compile link
      LET lb_result = TRUE
      CALL adzp040_set_progress("")
      LET li_time_start = cl_get_current() 
      CALL adzp040_generate_tgl_4gl(ls_prog_name,ls_module_name,ls_pr_version,ls_DGENV) RETURNING lb_result
      LET li_time_end = cl_get_current()
      DISPLAY cs_information_tag,"Generate tgl 4gl START Time : ",li_time_start  
      DISPLAY cs_information_tag,"Generate tgl 4gl  END Time : ",li_time_end  
      LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
      IF NOT lb_result THEN GOTO _complete END IF

      #GCODE需產生rdd檔
      IF (ls_upload_doc_type.toUpperCase() = cs_doc_type_gcode) THEN
        LET lb_result = TRUE
        CALL adzp040_set_progress("")
        LET li_time_start = cl_get_current() 
        CALL adzp040_generate_rdd(ls_prog_name,ls_module_name,ls_pr_version) RETURNING lb_result      
        LET li_time_end = cl_get_current()
        DISPLAY cs_information_tag,"Generate rdd START Time : ",li_time_start  
        DISPLAY cs_information_tag,"Generate rdd  END Time : ",li_time_end  
        LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
        IF NOT lb_result THEN GOTO _complete END IF
      END IF  
      
    END IF   

    LABEL _complete:

    IF lb_result THEN
      CALL adzp040_set_adzp040_progress_all(ls_zip_type,ls_upload_doc_type,mi_progress)

      {
      #2015.01.06 Marked
      LET ls_type = sadzp060_2_chk_spec_type(ls_prog_name) 
      IF (ls_type = "S") OR (ls_type = "F") OR (ls_type = "Q") THEN 
        #SPEC/SPECGEN 時執行
        IF (ls_upload_doc_type.toUpperCase() = cs_doc_type_spec OR ls_upload_doc_type.toUpperCase() = cs_doc_type_specgen) THEN
          #顯示若要整個系統完整測試, 請自行執行r.f
          LET ls_err_no = "adz-00388"
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code =  ls_err_no
          LET g_errparam.extend = ls_message
          LET g_errparam.popup = TRUE
          LET g_errparam.type = 2
          CALL cl_err()
        END IF  
      END IF
      }
      
    END IF
    
  END IF  

  IF NOT lb_result THEN
    IF NVL(ls_message.trim(),cs_null_default) <> cs_null_default THEN 
      DISPLAY cs_error_tag," ",ls_message
    END IF   
    DISPLAY "[Failed]",ui.Interface.getName()
  ELSE
    DISPLAY "[Complete]",ui.Interface.getName()
  END IF  

  DISPLAY cs_information_tag,"Build program Total Time : ",mi_spend_time  
  
  LET mb_result = lb_result
  
END FUNCTION

FUNCTION adzp040_finalize()

  {  
  CLOSE WINDOW w_adzp041
  }
  
  IF mb_result THEN
    EXIT PROGRAM 
  ELSE
    EXIT PROGRAM -1
  END IF
  
END FUNCTION

{
FUNCTION adzp040_refresh_progressbar(pi_position,ps_message)
DEFINE 
  pi_position INTEGER,
  ps_message  STRING
DEFINE 
  pgr_status  INTEGER,
  txt_Message STRING   

  DISPLAY "***** Time : ",CURRENT YEAR TO SECOND," *****"

  IF pi_position <> 0 THEN 
    LET pgr_status = pi_position
    DISPLAY BY NAME pgr_status
  END IF 

  IF NVL(ps_message,"NULL") <> "NULL" THEN
    LET txt_Message = ps_message
    DISPLAY BY NAME txt_Message
  END IF
  
  CALL ui.Interface.refresh()
  
END FUNCTION
}

FUNCTION adzp040_generate_tab(p_prog_name,p_program_type,p_version,p_dgenv)
DEFINE
  p_prog_name     STRING,
  p_program_type  T_PROGRAM_TYPE,
  p_version       STRING,
  p_dgenv         STRING   
DEFINE
  ls_prog_name     STRING,
  lo_program_type  T_PROGRAM_TYPE,
  ls_version       STRING, 
  ls_dgenv         STRING,   
  ls_message       STRING,
  ls_form_style    STRING,
  ls_err_no        STRING,
  ls_debug_info    STRING,
  lb_result        BOOLEAN

  LET ls_prog_name      = p_prog_name
  LET lo_program_type.* = p_program_type.*
  LET ls_version        = p_version
  LET ls_dgenv          = p_dgenv

  CALL adzp040_show_message_generator()
  
  LET lb_result = TRUE
  LET ls_err_no = "adz-00038"
  
  LET ls_message = "Call sadzp030_tab_gen [ "||ls_prog_name||" ]"
  DISPLAY cs_message_tag,ls_message
  DISPLAY cs_information_tag,ls_message
  CALL adzp040_set_progress(ls_message)
  LET ls_form_style = "" #2014.03.12 改為不傳遞 Form Style
  #CALL adzp040_get_form_style(ls_prog_name) RETURNING ls_form_style
  DISPLAY cs_command_tag,"CALL sadzp030_tab_gen(",ls_prog_name,",",ls_version,",",ls_form_style,",",ls_dgenv,")"
  CALL sadzp030_tab_gen(ls_prog_name,ls_version,ls_form_style,ls_dgenv) RETURNING lb_result
  LET ls_debug_info = "Call sadzp030_tab_gen : Program Name -> ",ls_prog_name,"\n",
                      "                        Form Style   -> ",ls_form_style,"\n",
                      "                        Version      -> ",ls_version,"\n",
                      "                        DGENV        -> ",ls_dgenv
  
  IF NOT lb_result THEN
    IF mb_back_job THEN
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang),"\n",
               ls_debug_info
    ELSE
      DISPLAY cs_error_tag,"[",ls_err_no,"]",ls_debug_info,"\n"
      #Begin:2015/11/09 by Hiko:由adzp080跳出錯誤訊息即可.
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code =  ls_err_no
      #LET g_errparam.extend = ls_message
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      #End:2015/11/09 by Hiko
    END IF  
  END IF

  RETURN lb_result
  
END FUNCTION

FUNCTION adzp040_get_form_style(p_prog_name)
DEFINE
  p_prog_name  STRING 
DEFINE
  ls_prog_name  STRING,
  ls_sql        STRING,
  ls_form_style VARCHAR(50),
  ls_return     STRING

  LET ls_prog_name = p_prog_name

  LET ls_sql = "SELECT FQ.DZFQ001 FORM_STYLE           ",
               "  FROM DZFQ_T FQ                       ",
               " WHERE FQ.DZFQ004 = '",ls_prog_name,"' ",
               "   AND FQ.DZFQ003 = '1'                "  #'",ls_ver,"'"  #2013.12.03 修改為寫死 "1"
 
  PREPARE lpre_get_form_style FROM ls_sql
  DECLARE lcur_get_form_style CURSOR FOR lpre_get_form_style

  OPEN lcur_get_form_style
  FETCH lcur_get_form_style INTO ls_form_style
  CLOSE lcur_get_form_style
  
  FREE lpre_get_form_style
  FREE lcur_get_form_style  

  LET ls_return = ls_form_style
  
  RETURN ls_return
  
END FUNCTION

FUNCTION adzp040_update_sd_data(p_upload_doc_type,p_zip_type,p_prog_name,p_module_name,p_DGENV)
DEFINE
  p_upload_doc_type STRING,
  p_zip_type        STRING,
  p_prog_name       STRING,
  p_module_name     STRING,
  p_DGENV           STRING   
DEFINE
  ls_upload_doc_type STRING,
  ls_zip_type        STRING,
  ls_prog_name       STRING,
  ls_module_name     STRING, 
  ls_DGENV           STRING,   
  ls_message         STRING,
  ls_err_message     STRING,
  ls_err_no          STRING,
  lb_result          BOOLEAN  

  LET ls_upload_doc_type = p_upload_doc_type 
  LET ls_zip_type        = p_zip_type     
  LET ls_prog_name       = p_prog_name
  LET ls_module_name     = p_module_name
  LET ls_DGENV           = p_DGENV

  CALL adzp040_show_message_designer()
  
  LET lb_result = TRUE

  #SPEC, SPECGEN 時處理
  IF (ls_upload_doc_type IS NOT NULL) AND (ls_upload_doc_type.toUpperCase() = cs_doc_type_spec OR ls_upload_doc_type.toUpperCase() = cs_doc_type_specgen) THEN
    LET ls_err_no      = "adz-00040"
    LET ls_message     = "Update tsd (SPEC,SPECGEN) : "||ls_prog_name
    LET ls_err_message = "Update tsd error !"
    DISPLAY cs_message_tag,ls_message
    DISPLAY cs_information_tag,ls_message
    CALL adzp040_set_progress(ls_message)
    #呼叫產出 tsd
    DISPLAY cs_command_tag,"CALL sadzp060_1_update_tsd(",ls_prog_name,",",ls_module_name,",",ls_DGENV,")"
    CALL sadzp060_1_update_tsd(ls_prog_name,ls_module_name,ls_DGENV) RETURNING lb_result
  END IF
  
  #RSPEC 時處理
  IF (ls_upload_doc_type IS NOT NULL) AND (ls_upload_doc_type.toUpperCase() = cs_doc_type_rspec) THEN
    LET ls_err_no      = "adz-00040"
    LET ls_message     = "Update rsd (RSPEC) : "||ls_prog_name
    LET ls_err_message = "Update rsd error !"
    DISPLAY cs_message_tag,ls_message
    DISPLAY cs_information_tag,ls_message
    CALL adzp040_set_progress(ls_message)
    #呼叫產出 rsd
    DISPLAY cs_command_tag,"CALL sadzp060_1_update_rsd(",ls_prog_name,",",ls_module_name,",",ls_DGENV,")"
    CALL sadzp060_1_update_rsd(ls_prog_name,ls_module_name,ls_DGENV) RETURNING lb_result
  END IF
  
  #CSPEC 時處理
  IF (ls_upload_doc_type IS NOT NULL) AND (ls_upload_doc_type.toUpperCase() = cs_doc_type_cspec) THEN
    LET ls_err_no      = "adz-00040"
    LET ls_message     = "Update tsd (CSPEC) : "||ls_prog_name
    LET ls_err_message = "Update tsd error !"
    DISPLAY cs_message_tag,ls_message
    DISPLAY cs_information_tag,ls_message
    CALL adzp040_set_progress(ls_message)
    #呼叫產出 tsd
    DISPLAY cs_command_tag,"CALL sadzp040_2_update_csd(",ls_prog_name,",",ls_module_name,",",ls_DGENV,")"
    CALL sadzp040_2_update_csd(ls_prog_name,ls_module_name,ls_DGENV) RETURNING lb_result
  END IF
  
  IF NOT lb_result THEN
    IF mb_back_job THEN
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
    ELSE
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
      #Begin:2015/11/09 by Hiko:由adzp080跳出錯誤訊息即可.
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code =  ls_err_no
      #LET g_errparam.extend = ls_err_message
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      #End:2015/11/09 by Hiko
    END IF  
  END IF

  RETURN lb_result
  
END FUNCTION

FUNCTION adzp040_update_tap(p_upload_doc_type,p_zip_type,p_prog_name,p_module_name,p_DGENV)
DEFINE
  p_upload_doc_type STRING,
  p_zip_type        STRING,
  p_prog_name       STRING,
  p_module_name     STRING, 
  p_DGENV           STRING 
DEFINE
  ls_upload_doc_type STRING,
  ls_zip_type        STRING,
  ls_prog_name       STRING,
  ls_module_name     STRING,
  ls_DGENV           STRING, 
  ls_message         STRING,
  ls_err_message     STRING,
  ls_err_no          STRING,
  lb_result          BOOLEAN  

  LET ls_upload_doc_type = p_upload_doc_type 
  LET ls_zip_type        = p_zip_type     
  LET ls_prog_name       = p_prog_name
  LET ls_module_name     = p_module_name
  LET ls_DGENV           = p_DGENV

  CALL adzp040_show_message_designer()
  
  LET lb_result = TRUE

  IF (ls_upload_doc_type IS NOT NULL) AND 
     (
      ls_upload_doc_type.toUpperCase() = cs_doc_type_code OR
      ls_upload_doc_type.toUpperCase() = cs_doc_type_gcode
     ) THEN
    LET ls_err_no      = "adz-00039"
    LET ls_message     = "Update tap : "||ls_prog_name
    LET ls_err_message = "Update tap error !"
    DISPLAY cs_message_tag,ls_message
    DISPLAY cs_information_tag,ls_message
    CALL adzp040_set_progress(ls_message)
    
    #呼叫更新 tap
    DISPLAY cs_command_tag,"CALL sadzp060_1_update_tap(",ls_prog_name,",",ls_module_name,",",ls_DGENV,")"
    CALL sadzp060_1_update_tap(ls_prog_name,ls_module_name,ls_DGENV) RETURNING lb_result
  ELSE 
    LET ls_message = "Not 'CODE' type package, skip update TAP data."
    DISPLAY cs_information_tag,ls_message
  END IF

  IF NOT lb_result THEN
    IF mb_back_job THEN
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
    ELSE
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
      #Begin:2015/11/09 by Hiko:由adzp080跳出錯誤訊息即可.
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code =  ls_err_no
      #LET g_errparam.extend = ls_err_message
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      #End:2015/11/09 by Hiko
    END IF  
  END IF

  RETURN lb_result
  
END FUNCTION

FUNCTION adzp040_generate_tgl_4gl(p_prog_name, p_module_name, p_version,p_dgenv)
DEFINE
  p_prog_name    STRING,
  p_module_name  STRING,
  p_version      STRING,
  p_dgenv        STRING
DEFINE
  ls_prog_name     STRING,
  ls_module_name   STRING,
  ls_version       STRING, 
  ls_dgenv         STRING,
  ls_module_env    STRING,
  ls_exec_str      STRING,
  ls_sub_root      STRING,
  li_chdir_result  STRING,
  lb_result        BOOLEAN,
  ls_message       STRING,
  ls_err_message   STRING, 
  ls_pid           STRING, 
  ls_err_file_name STRING,
  ls_temp_dir      STRING,
  ls_err_no        STRING,
  ls_parameter     STRING

  LET ls_prog_name   = p_prog_name
  LET ls_module_name = p_module_name.toLowerCase()
  LET ls_version     = p_version
  LET ls_dgenv       = p_dgenv
  
  CALL adzp040_show_message_generator()
  
  LET ls_err_no = "adz-00128"
  
  LET ls_sub_root   = "4gl"
  LET ls_module_env = os.Path.join(FGL_GETENV(p_module_name.toUpperCase()),ls_sub_root)

  CALL os.Path.chdir(ls_module_env) RETURNING li_chdir_result
  
  LET ls_message  = "Call r.c3 generate tgl and 4gl"
  DISPLAY cs_message_tag,ls_message
  DISPLAY cs_information_tag,ls_message
  CALL adzp040_set_progress(ls_message)
  #第四個參數為 0 表示全部做完編譯以下的事情.
  #第四個參數為 1 表示做完產生與組合,但不做編譯和鏈結.
  #第四個參數為 2 表示只做組合器以後的事:包含編譯和鏈結.
  #第四個參數為 3 表示只做組合器以後的事:不做編譯和鏈結. #2015/11/09 by Hiko
  #2014.07.03 第四個參數從 2 改為 1
  #2014.09.24 第四個參數改回 2
  #2014.12.05 第四個參數改回 0

  #Begin:2015/11/09 by Hiko
  #LET ls_parameter = ls_prog_name," ","''"," ",ls_version," ","0"," ",ls_dgenv
  IF sadzp060_2_is_regen(ls_prog_name) OR sadzp030_tab_file_template_renewed(ls_prog_name) THEN
     LET ls_parameter = ls_prog_name," ","''"," ",ls_version," ","0"," ",ls_dgenv
  ELSE
     LET ls_parameter = ls_prog_name," ","''"," ",ls_version," ","2"," ",ls_dgenv
  END IF
  #Begin:2015/11/09 by Hiko
  DISPLAY cs_command_tag,"r.c3 ",ls_module_name," ",ls_parameter
  CALL adzp040_execute_program("r.c3 ",ls_module_name,ls_parameter) RETURNING lb_result,ls_err_message
  
  IF NOT lb_result THEN
    IF mb_back_job THEN
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
    ELSE
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
      #Begin:2015/11/09 by Hiko:由adzp080跳出錯誤訊息即可.
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code =  ls_err_no
      #LET g_errparam.extend = ls_message
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      #End:2015/11/09 by Hiko
    END IF  
  END IF

  RETURN lb_result    
  
END FUNCTION

FUNCTION adzp040_generate_rdd(p_prog_name, p_module_name, p_version)
DEFINE
  p_prog_name    STRING,
  p_module_name  STRING,
  p_version      STRING
DEFINE
  ls_prog_name     STRING,
  ls_module_name   STRING,
  ls_version       STRING, 
  ls_module_env    STRING,
  ls_exec_str      STRING,
  ls_sub_root      STRING,
  li_chdir_result  STRING,
  lb_result        BOOLEAN,
  ls_message       STRING,
  ls_err_message   STRING, 
  ls_pid           STRING, 
  ls_err_file_name STRING,
  ls_temp_dir      STRING,
  ls_err_no        STRING,
  ls_parameter     STRING

  LET ls_prog_name   = p_prog_name
  LET ls_module_name = p_module_name.toLowerCase()
  LET ls_version     = p_version

  CALL adzp040_show_message_generator()
  
  LET ls_err_no = "adz-00128"
  
  LET ls_sub_root   = "4gl"
  LET ls_module_env = os.Path.join(FGL_GETENV(p_module_name.toUpperCase()),ls_sub_root)

  CALL os.Path.chdir(ls_module_env) RETURNING li_chdir_result
  
  LET ls_message  = "Call r.c generate rdd"
  DISPLAY cs_message_tag,ls_message
  DISPLAY cs_information_tag,ls_message
  CALL adzp040_set_progress(ls_message)

  LET ls_parameter = ls_prog_name," ","rdd"
  DISPLAY cs_command_tag,"r.c ",ls_module_name," ",ls_parameter
  CALL adzp040_execute_program("r.c ",ls_module_name,ls_parameter) RETURNING lb_result,ls_err_message
  
  IF NOT lb_result THEN
    IF mb_back_job THEN
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
    ELSE
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
      #Begin:2015/11/09 by Hiko:由adzp080跳出錯誤訊息即可.
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code =  ls_err_no
      #LET g_errparam.extend = ls_message
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      #End:2015/11/09 by Hiko
    END IF  
  END IF

  RETURN lb_result    
  
END FUNCTION

FUNCTION adzp040_compile_4fd(p_prog_name,p_module_name,p_tiptop)
DEFINE
  p_prog_name    STRING,
  p_module_name  STRING,
  p_tiptop       STRING
DEFINE
  ls_prog_name    STRING,
  ls_module_name  STRING,
  ls_tiptop       STRING,
  ls_module_env   STRING,
  ls_exec_str     STRING,
  ls_sub_root     STRING,
  li_chdir_result STRING,
  lb_result       BOOLEAN,
  ls_parameter    STRING,
  ls_message      STRING,
  ls_err_message  STRING, 
  ls_err_no       STRING

  LET ls_prog_name   = p_prog_name
  LET ls_module_name = p_module_name.toLowerCase()
  LET ls_tiptop      = p_tiptop

  CALL adzp040_show_message_user_control()
  
  LET ls_err_no = "adz-00034"
  
  LET ls_sub_root   = "4fd"
  LET ls_module_env = os.Path.join(FGL_GETENV(p_module_name.toUpperCase()),ls_sub_root)

  CALL os.Path.chdir(ls_module_env) RETURNING li_chdir_result
  
  LET ls_message = "Compile form (4fd) "||ls_prog_name
  DISPLAY cs_message_tag,ls_message
  DISPLAY cs_information_tag,ls_message
  CALL adzp040_set_progress(ls_message)

  LET ls_parameter = ls_prog_name," ",ls_tiptop
  DISPLAY cs_command_tag,"r.f ",ls_parameter
  CALL adzp040_execute_program("r.f ",ls_module_name,ls_parameter) RETURNING lb_result,ls_err_message

  IF NOT lb_result THEN
    IF mb_back_job THEN
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
    ELSE
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
      #Begin:2015/11/09 by Hiko:由adzp080跳出錯誤訊息即可.
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code =  ls_err_no
      #LET g_errparam.extend = ls_message
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      #End:2015/11/09 by Hiko
    END IF  
  END IF

  RETURN lb_result    
  
END FUNCTION

FUNCTION adzp040_parse_4fd(p_prog_name, p_module_name, p_version, p_dgenv)
DEFINE
  p_prog_name    STRING,
  p_module_name  STRING,
  p_version      STRING,
  p_dgenv        STRING
DEFINE
  ls_prog_name    STRING,
  ls_module_name  STRING,
  ls_version      STRING,
  ls_dgenv        STRING,
  ls_module_env   STRING,
  ls_exec_str     STRING,
  ls_sub_root     STRING,
  li_chdir_result STRING,
  lb_result       BOOLEAN,
  ls_return       STRING,
  ls_message      STRING,
  ls_err_no       STRING

  LET ls_prog_name    = p_prog_name
  LET ls_module_name  = p_module_name.toLowerCase()
  LET ls_version      = p_version.Trim()
  LET ls_dgenv        = p_dgenv.trim()
  
  CALL adzp040_show_message_designer()
  
  LET ls_err_no = "adz-00137"
  
  LET ls_sub_root   = "4fd"
  LET ls_module_env = os.Path.join(FGL_GETENV(p_module_name.toUpperCase()),ls_sub_root)

  CALL os.Path.chdir(ls_module_env) RETURNING li_chdir_result
  
  LET ls_message = "Parse form (4fd) "||ls_prog_name
  DISPLAY cs_message_tag,ls_message
  DISPLAY cs_information_tag,ls_message
  CALL adzp040_set_progress(ls_message)

  LET lb_result = TRUE
  TRY
    #DISPLAY "sadzp168_3 version : ",ls_version 
    DISPLAY cs_command_tag,"CALL sadzp168_3(",ls_module_name,",",ls_prog_name,",",ls_version,",",ls_dgenv,")"
    CALL sadzp168_3(ls_module_name, ls_prog_name,ls_version,ls_dgenv) RETURNING lb_result,ls_return
  CATCH
    LET lb_result = FALSE
  END TRY  
  
  IF NOT lb_result THEN
    IF mb_back_job THEN
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
    ELSE
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
      #Begin:2015/11/09 by Hiko:由adzp080跳出錯誤訊息即可.
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code =  ls_err_no
      #LET g_errparam.extend = ls_message
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      #End:2015/11/09 by Hiko
    END IF  
  END IF

  RETURN lb_result    
  
END FUNCTION

FUNCTION adzp040_analyze_4fd_4gl(p_prog_name,p_version,p_dgenv)
DEFINE
  p_prog_name    STRING,
  p_version      STRING,
  p_dgenv        STRING
DEFINE
  ls_prog_name    STRING,
  ls_version      STRING,
  ls_dgenv        STRING,
  ls_module_env   STRING,
  ls_exec_str     STRING,
  ls_sub_root     STRING,
  li_chdir_result STRING,
  lb_result       BOOLEAN,
  ls_return       STRING,
  ls_message      STRING,
  ls_err_no       STRING

  LET ls_prog_name    = p_prog_name
  LET ls_version      = p_version.Trim()
  LET ls_dgenv        = p_dgenv.Trim()

  CALL adzp040_show_message_designer()

  LET ls_err_no = "adz-00301"
  
  LET ls_message = "Analyze 4fd and 4gl information "||ls_prog_name
  DISPLAY cs_message_tag,ls_message
  DISPLAY cs_information_tag,ls_message
  CALL adzp040_set_progress(ls_message)

  LET lb_result = TRUE
  TRY
    DISPLAY cs_command_tag,"CALL sadzp168_4(",ls_prog_name,",",ls_version,",",ls_dgenv,")"
    DISPLAY cs_ignore_tag
    CALL sadzp168_4(ls_prog_name,ls_version,ls_dgenv) RETURNING lb_result,ls_return
    DISPLAY cs_note_tag
  CATCH
    LET lb_result = FALSE
  END TRY  
  LET lb_result = TRUE -- 錯誤都忽略
  
  IF NOT lb_result THEN
    IF mb_back_job THEN
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
    ELSE
      DISPLAY cs_error_tag,"[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
      --CALL cl_err_msg(ls_message, ls_err_no, NULL, 0)
    END IF  
  END IF

  RETURN lb_result    
  
END FUNCTION

PUBLIC FUNCTION adzp040_execute_program(p_command,p_module_name,p_other_parm)
DEFINE 
  p_command      STRING, #要執行的指令
  p_module_name  STRING, #模組名稱
  p_other_parm   STRING  #其他參數
DEFINE  
  ls_command      STRING, #要執行的指令
  ls_module_name  STRING,
  ls_other_parm   STRING, #其他參數
  ls_path         STRING, #要編譯的路徑
  ls_prog_line    STRING,
  ls_msg          STRING, #編譯後訊息
  lb_result       BOOLEAN,#成功或失敗
  li_chdir_result INTEGER, 
  lch_read        base.Channel

  LET ls_command     = p_command
  LET ls_module_name = p_module_name   
  LET ls_other_parm  = p_other_parm
  
  LET lb_result = TRUE
  LET lch_read  = base.Channel.create()
  CALL lch_read.setDelimiter("")
  LET ls_msg    = ls_command,"\n" 
   
  #切換目錄
  LET ls_path = FGL_GETENV(ls_module_name.toUpperCase())

  #若是 r.f 就切換到 4fd 目錄下
  IF ls_command.getIndexOf("r.f",1) > 0 THEN
    LET ls_path = os.Path.join(ls_path, "4fd")
  ELSE  
    IF ls_module_name IS NOT NULL THEN
      LET ls_path = os.Path.join(ls_path, "4gl")
    ELSE
      LET ls_path = ""  
    END IF  
  END IF

  IF ls_path IS NOT NULL THEN
    CALL os.Path.chdir(ls_path) RETURNING li_chdir_result
    IF NOT li_chdir_result THEN
      LET lb_result = FALSE
      DISPLAY "Change directory to """,ls_path,""" fail."
    ELSE
      DISPLAY "Change directory to """,ls_path,""" success."  
    END IF
  END IF  

  IF lb_result THEN
    #Begin:2015/11/09 by Hiko
    ##執行指令
    #LET ls_command = ls_command,ls_other_parm," 2>&1"
    
    #DISPLAY cs_command_tag,ls_command
    #
    #CALL lch_read.openPipe(ls_command, "r")
    #WHILE TRUE
    #  LET ls_prog_line = lch_read.readLine()
    #  IF lch_read.isEof() THEN 
    #    EXIT WHILE 
    #  END IF
    #  
    #  #DISPLAY cs_debug_tag,ls_prog_line
    #  LET ls_msg = ls_msg, 
    #               ls_prog_line, "\n"
    #  LET ls_prog_line = ls_prog_line.toUpperCase()
    #   
    #  #遇到錯誤訊息, 回傳 False
    #  IF ls_prog_line.getIndexOf("ERROR", 1) > 0 THEN
    #    LET lb_result = FALSE
    #  END IF
    #END WHILE
    #CALL lch_read.close()
    
    #DISPLAY ls_msg
    
    LET ls_command = ls_command,ls_other_parm
    DISPLAY cs_command_tag,ls_command
    CALL cl_cmdrun_openpipe("adzp040_execute_program", ls_command, FALSE) RETURNING lb_result,ls_msg
    #End:2015/11/09 by Hiko
  END IF
  
  RETURN lb_result,ls_msg
  
END FUNCTION

FUNCTION adzp040_get_program_type(p_program_name)
DEFINE
  p_program_name STRING
DEFINE
  ls_sql           STRING,
  ls_program_name  STRING,
  lo_program_type  T_PROGRAM_TYPE
DEFINE
  lo_return  T_PROGRAM_TYPE

  LET ls_program_name = p_program_name

  #取得程式樣板型態
  LET ls_sql = "SELECT FQ.DZFQ003 temp_ver,               ",
               "       FQ.DZFQ005 temp_type,              ",
               "       FQ.DZFQ001 temp_name               ",
               "  FROM DZFQ_T FQ                          ",
               " WHERE FQ.DZFQ004  = '",ls_program_name,"'",
               "   AND FQ.DZFQ003  = '1'                  ",
               "   AND FQ.DZFQSTUS = 'Y'                  "
               
  PREPARE lpre_get_program_type FROM ls_sql
  DECLARE lcur_get_program_type CURSOR FOR lpre_get_program_type
  OPEN lcur_get_program_type
  FETCH lcur_get_program_type INTO lo_program_type.*
  CLOSE lcur_get_program_type
  FREE lcur_get_program_type
  FREE lpre_get_program_type

  LET lo_return.* = lo_program_type.*
  
  RETURN lo_return.*
  
END FUNCTION

#以亂數產出副檔名
FUNCTION adzp040_gen_random_name()
DEFINE
  lr_random_name RECORD
    segment1 STRING,
    segment2 STRING,
    segment3 STRING,
    segment4 STRING
  END RECORD
DEFINE 
  li_random_value   INTEGER,
  li_max_random_num INTEGER,
  ls_final_name     STRING,
  ls_using_format   STRING
DEFINE  
  ls_return STRING

  LET li_max_random_num = 9999
  LET ls_using_format  = "&&&&"
  
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_random_name.segment1 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_random_name.segment2 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_random_name.segment3 = li_random_value USING ls_using_format
  CALL util.math.rand(li_max_random_num) RETURNING li_random_value
  LET lr_random_name.segment4 = li_random_value USING ls_using_format
  
  LET ls_final_name = lr_random_name.segment1,".",
                      lr_random_name.segment2,".",
                      lr_random_name.segment3,".",
                      lr_random_name.segment4

  LET ls_return = ls_final_name
  
  RETURN ls_return                     
  
END FUNCTION

FUNCTION adzp040_write_file(p_file_name,p_line_string)
DEFINE
  p_file_name   STRING,
  p_line_string STRING
DEFINE   
  ls_file_name      STRING,
  ls_line_string    STRING,
  lo_channel_write  base.Channel

  LET ls_file_name   = p_file_name
  LET ls_line_string = p_line_string

  LET  lo_channel_write = base.Channel.create()
  CALL lo_channel_write.setDelimiter("")

  CALL lo_channel_write.openFile(ls_file_name, "w" )
  CALL lo_channel_write.write(ls_line_string)
  CALL lo_channel_write.close()
   
END FUNCTION

FUNCTION adzp040_if_first_version(p_program)
DEFINE
  p_program STRING
DEFINE
  lr_first_version RECORD
                     VER_COUNT INTEGER,
                     MIN_VER   VARCHAR(20)
                   END RECORD
DEFINE
  ls_program STRING,
  ls_sql     STRING
DEFINE
  lb_return BOOLEAN   

  LET ls_program = p_program.toLowerCase()

  LET ls_sql = "SELECT COUNT(DISTINCT BA.DZBA002) VER_COUNT,MIN(BA.DZBA002) MIN_VER ",
               "  FROM DZBA_T BA                                                    ",
               " WHERE BA.DZBA001 = '",ls_program,"'                                "
               
  PREPARE lpre_if_first_version FROM ls_sql
  DECLARE lcur_if_first_version CURSOR FOR lpre_if_first_version

  OPEN lcur_if_first_version
  FETCH lcur_if_first_version INTO lr_first_version.*
  CLOSE lcur_if_first_version
  
  FREE lpre_if_first_version
  FREE lcur_if_first_version  

  DISPLAY "VER_COUNT : ",lr_first_version.VER_COUNT
  DISPLAY "MIN_VER : ",lr_first_version.MIN_VER

  IF (lr_first_version.VER_COUNT = 0) OR (lr_first_version.VER_COUNT >= 2) OR (lr_first_version.VER_COUNT = 1 AND lr_first_version.MIN_VER <> "1") THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF   
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp040_get_adzp040_progress_all(p_pgrs_type,p_doc_type)
DEFINE
  p_pgrs_type STRING,
  p_doc_type  STRING
DEFINE
  ls_pgrs_type    STRING,
  ls_doc_type     STRING,
  ls_progress_all VARCHAR(5),
  ls_sql          STRING
DEFINE
  ls_return STRING  

  LET ls_pgrs_type = p_pgrs_type
  LET ls_doc_type  = p_doc_type.toUpperCase()
  
  LET ls_sql = "SELECT EJ.DZEJ006 PROGRESS_ALL                         ",
               "  FROM DZEJ_T EJ                                       ",
               " WHERE EJ.DZEJ001 = 'adzp040_Progress'                 ",  
               "   AND EJ.DZEJ003 = 'ALL'                              ",
               "   AND EJ.DZEJ004 = '",ls_pgrs_type,"'                 ",
               "   AND NVL(EJ.DZEJ005,'X') = NVL('",ls_doc_type,"','X')"
 
  PREPARE lpre_get_adzp040_progress_all FROM ls_sql
  DECLARE lcur_get_adzp040_progress_all CURSOR FOR lpre_get_adzp040_progress_all

  OPEN lcur_get_adzp040_progress_all
  FETCH lcur_get_adzp040_progress_all INTO ls_progress_all
  CLOSE lcur_get_adzp040_progress_all
  
  FREE lpre_get_adzp040_progress_all
  FREE lcur_get_adzp040_progress_all  

  LET ls_return = ls_progress_all
  
  RETURN ls_return
  
END FUNCTION

FUNCTION adzp040_set_adzp040_progress_all(p_pgrs_type,p_doc_type,p_progress)
DEFINE
  p_pgrs_type STRING,
  p_doc_type  STRING,
  p_progress  STRING
DEFINE
  ls_pgrs_type STRING,
  ls_doc_type  STRING,
  ls_progress  STRING,
  ls_sql       STRING

  LET ls_pgrs_type = p_pgrs_type
  LET ls_doc_type  = p_doc_type.toUpperCase()
  LET ls_progress  = p_progress

  LET ls_sql = "UPDATE DZEJ_T EJ                                       ", 
               "   SET EJ.DZEJ006 = '",ls_progress,"'                  ",
               " WHERE EJ.DZEJ001 = 'adzp040_Progress'                 ",  
               "   AND EJ.DZEJ003 = 'ALL'                              ",
               "   AND EJ.DZEJ004 = '",ls_pgrs_type,"'                 ",
               "   AND NVL(EJ.DZEJ005,'X') = NVL('",ls_doc_type,"','X')"

  #DISPLAY "Update SQL : ",ls_sql

  BEGIN WORK

  TRY
    PREPARE lpre_set_adzp040_progress_all FROM ls_sql
    EXECUTE lpre_set_adzp040_progress_all
    COMMIT WORK
  CATCH
    DISPLAY "[ERROR] Update adzp040 progress. "
    ROLLBACK WORK
  END TRY  
  
END FUNCTION

FUNCTION adzp040_set_progress(p_message)
DEFINE
  p_message STRING
DEFINE
  ls_message      STRING,
  ls_progress     STRING,
  ls_env_progress STRING

  IF mb_back_job THEN RETURN END IF

  LET ls_message = p_message
  
  LET mi_progress = mi_progress + 1
  LET ls_progress = mi_progress
  
  DISPLAY cs_progress_tag,ls_progress
  
  IF NVL(ls_message,"X") <> "X" THEN
    DISPLAY cs_message_tag,ls_message
  END IF
  
END FUNCTION

FUNCTION adzp040_show_message_designer()
  DISPLAY cs_message_half_separator,cs_message_designer,cs_message_half_separator
END FUNCTION

FUNCTION adzp040_show_message_generator()
  DISPLAY cs_message_half_separator,cs_message_generator,cs_message_half_separator
END FUNCTION

FUNCTION adzp040_show_message_user_control()
  DISPLAY cs_message_half_separator,cs_message_user_control,cs_message_half_separator
END FUNCTION

FUNCTION adzp040_show_message_separator()
  DISPLAY cs_message_separator
END FUNCTION
