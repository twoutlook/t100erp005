{
  異動型態    異動單號       日 期       異動者      異動內容
  ========= ============= ========== ========== ===============================================
  Modify                  20160901   Ernestliou 1.呼叫 adzp888及adzp241時多傳入"是否更新客製程式標準段落"
  Modify                  20160907   Ernestliou 1."是否更新客製程式標準段落"預設傳入 "Y", 但是勾選隱藏
  Modify                  20160921   Ernestliou 1.新增產出 Log 功能 for adzp340 及 adzp241
  Modify                  20161018   Ernestliou 1.執行時產生 dzyg_t 資料
}
  
&include "../4gl/sadzp340_mcr.inc"
IMPORT OS
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp340_cnst.inc"

CONSTANT cs_table_identify   STRING = "table_export_list.vfy"
CONSTANT cs_program_identify STRING = "adzp999_patch.unl"            

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp340_type.inc"

DEFINE ms_lang  STRING
DEFINE
  mb_backend_mode BOOLEAN,
  mo_arguments    T_ARGUMENTS,
  mb_return       BOOLEAN,
  ms_guid         STRING,
  ms_memo         STRING,
  ms_log_name     STRING -- 20160921

DEFINE mo_sr_adzp340 T_SR_ADZP340

FUNCTION sadzp340_run(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ARGUMENTS
  
  CALL sadzp340_initialize(p_backend_mode,p_arguments.*)
  CALL sadzp340_initial_form()
  CALL sadzp340_start()
  CALL sadzp340_finalize()

  RETURN mb_return
  
END FUNCTION 
  
FUNCTION sadzp340_initialize(p_backend_mode,p_arguments)
DEFINE
  p_backend_mode BOOLEAN,
  p_arguments    T_ARGUMENTS
DEFINE
  ls_current   STRING,
  lo_strbuf    base.StringBuffer,
  ls_TEMPDIR   STRING, -- 20160921
  ls_separator STRING  -- 20160921

  -- 20160921 begin
  LET ls_TEMPDIR = FGL_GETENV("TEMPDIR")
  LET ls_separator = os.Path.separator()
  
  &ifndef DEBUG
    LET ms_lang = g_lang
    LET ls_current = cl_get_current()
  &else
    LET ms_lang = cs_default_lang
    LET ls_current = CURRENT YEAR TO SECOND
  &endif

  LET lo_strbuf = base.StringBuffer.create()
  CALL lo_strbuf.clear()
  CALL lo_strbuf.append(ls_current)
  CALL lo_strbuf.replace(' ','',0)
  CALL lo_strbuf.replace(':','',0)
  CALL lo_strbuf.replace('-','',0)
  LET ls_current = lo_strbuf.toString()
  -- 20160921 end

  LET mb_backend_mode = p_backend_mode
  LET mo_arguments.*  = p_arguments.*
  
  LET ms_log_name = ls_TEMPDIR,ls_separator,"patch_adzp340_",ls_current,".log" -- 20160921

  LET ms_memo = ""

END FUNCTION

FUNCTION sadzp340_initial_form()
DEFINE 
  lw_window   ui.Window,
  lf_form     ui.Form,
  ls_cfg_path STRING,
  ls_4st_path STRING,
  ls_img_path STRING
  
  OPTIONS INPUT WRAP

  &ifndef DEBUG
    OPEN WINDOW w_sadzp340 WITH FORM cl_ap_formpath("ADZ","sadzp340")
  &else
    OPEN WINDOW w_sadzp340 WITH FORM "sadzp340" -- sadzp340_util_get_form_path("sadzp340")
  &endif
  
  CURRENT WINDOW IS w_sadzp340
  CLOSE WINDOW SCREEN
  
  &ifndef DEBUG
  CALL cl_ui_wintitle(1) #工具抬頭名稱
  CALL cl_load_4ad_interface(NULL)
  &endif

  CALL sadzp340_set_form_title('sadzp340',ms_lang)
  CALL sadzp340_set_form_style(ms_lang)
  
END FUNCTION 


FUNCTION sadzp340_start()
DEFINE
  ls_memo          STRING,
  ls_command       STRING,
  lb_result        BOOLEAN,
  ls_dir_name      STRING,
  ls_base_name     STRING,
  ls_separator     STRING,
  ls_prg_pkg_path  STRING,
  ls_ext_name      STRING,
  ls_err_code      STRING,
  ls_TEMPDIR       STRING, -- 20160921
  ls_adzp241_log   STRING, -- 20160921
  ls_current       STRING, -- 20160921
  ls_prog_pkg_name STRING  -- 20161018
  
  LET ls_TEMPDIR = FGL_GETENV("TEMPDIR") -- 20160921
  LET ls_separator = os.Path.separator() -- 20160921
  
  DIALOG ATTRIBUTE(UNBUFFERED)
    
    INPUT mo_sr_adzp340.* FROM sr_sadzp340.* ATTRIBUTE(WITHOUT DEFAULTS)
    END INPUT

    BEFORE DIALOG 
     LET mo_sr_adzp340.sa_refresh_cust_std_section = "Y" #20160907
     LET ls_memo = cs_information_tag,"Start patch console."
     CALL sadzp340_set_memo_contents(ls_memo)
     LET ls_memo = cs_message_tag,"Set log file on : ",ms_log_name
     CALL sadzp340_set_memo_contents(ls_memo)

    ON ACTION btn_load_tbl_path
      LET mo_sr_adzp340.sa_tbl_path = sadzp340_dlg_opendlg(
                                                            "Open table archive",
                                                            os.Path.homedir(),
                                                            NULL,
                                                            "*.tgz",""
                                                          )
      LET ls_memo = cs_message_tag,"'",mo_sr_adzp340.sa_tbl_path,"' as table archive path."
      CALL sadzp340_set_memo_contents(ls_memo)

      #判斷程式包是否存在, 若存在, 則自動指向該程式包
      #begin
      LET ls_dir_name  = os.Path.dirName(mo_sr_adzp340.sa_tbl_path)
      LET ls_base_name = os.Path.basename(mo_sr_adzp340.sa_tbl_path)
      LET ls_base_name = os.Path.basename(ls_base_name)
      LET ls_ext_name  = os.Path.extension(mo_sr_adzp340.sa_tbl_path)
      LET ls_prog_pkg_name = ls_base_name.subString(1,ls_base_name.getLength()-ls_ext_name.getLength()-2) -- 20161018
      LET ls_prg_pkg_path = ls_dir_name,ls_separator,ls_prog_pkg_name,".",ls_ext_name
      
      IF os.Path.exists(ls_prg_pkg_path) THEN
        LET mo_sr_adzp340.sa_merge_pkg_path = ls_prg_pkg_path
      ELSE
        LET mo_sr_adzp340.sa_merge_pkg_path = ""  
      END IF
      #end
      
      CALL sadzp340_check_if_any_patching_prog_runs() RETURNING lb_result
      IF lb_result THEN
        CALL DIALOG.setActionActive("btn_execute", FALSE) 
      ELSE
        CALL DIALOG.setActionActive("btn_execute", TRUE) 
      END IF
      
      NEXT FIELD ed_tbl_path

    ON ACTION btn_open_adzp250
      IF ms_guid IS NOT NULL THEN 
        LET ls_command = "r.r adzp250 -ID '",ms_guid,"'"
        RUN ls_command WITHOUT WAITING
        LET ls_memo = cs_command_tag,ls_command
        CALL sadzp340_set_memo_contents(ls_memo)
      ELSE
        LET ls_memo = cs_error_tag,"The GUID is null."
        CALL sadzp340_set_memo_contents(ls_memo)
      END IF
      
    ON ACTION btn_load_merge_pkg_path
      LET mo_sr_adzp340.sa_merge_pkg_path = sadzp340_dlg_opendlg(
                                                                  "Open merge archive",
                                                                  os.Path.homedir(),
                                                                  NULL,
                                                                  "*.tgz",""
                                                                )
      LET ls_memo = cs_message_tag,"'",mo_sr_adzp340.sa_merge_pkg_path,"' as merge path."
      CALL sadzp340_set_memo_contents(ls_memo)

      CALL sadzp340_check_if_any_patching_prog_runs() RETURNING lb_result
      IF lb_result THEN
        CALL DIALOG.setActionActive("btn_execute", FALSE) 
      ELSE
        CALL DIALOG.setActionActive("btn_execute", TRUE) 
      END IF
      
      NEXT FIELD ed_merge_pkg_path 
      
    ON ACTION btn_execute
      IF mo_sr_adzp340.sa_tbl_path IS NULL THEN
        LET ls_err_code = "adz-00895"
        CALL sadzp000_msg_show_error(ls_err_code,ls_err_code,"",0)
        NEXT FIELD ed_tbl_path
        CONTINUE DIALOG
      END IF 
      IF mo_sr_adzp340.sa_merge_pkg_path IS NULL THEN 
        LET ls_err_code = "adz-00896"
        CALL sadzp000_msg_show_error(ls_err_code,ls_err_code,"",0)
        NEXT FIELD ed_merge_pkg_path
        CONTINUE DIALOG
      END IF 
      #20161018 產生執行 Log 紀錄 begin
      CALL sadzp340_gen_log_record(ls_prog_pkg_name) RETURNING lb_result
      #20161018 產生執行 Log 紀錄 end
      IF mo_sr_adzp340.sa_tbl_path IS NOT NULL THEN 
        DISPLAY "" TO ed_guid
        LET ls_memo = cs_message_tag,"Start table patch manager, waiting for GUID ..."
        CALL sadzp340_set_memo_contents(ls_memo)
        CALL sadzp340_run_table_patcher(mo_sr_adzp340.sa_tbl_path) RETURNING ms_guid
        DISPLAY ms_guid TO ed_guid
        LET ls_memo = cs_message_tag,"Get GUID status : ",ms_guid
        CALL sadzp340_set_memo_contents(ls_memo)
        CALL sadzp340_check_if_any_patching_prog_runs() RETURNING lb_result
        IF lb_result THEN
          CALL DIALOG.setActionActive("btn_execute", FALSE) 
        ELSE
          CALL DIALOG.setActionActive("btn_execute", TRUE) 
        END IF
      END IF
      IF mo_sr_adzp340.sa_merge_pkg_path IS NOT NULL THEN
        IF mo_sr_adzp340.sa_tbl_path IS NOT NULL THEN
          IF ms_guid IS NOT NULL AND ms_guid.getIndexOf(cs_error_tag,1) = 0 THEN 
            LET ls_adzp241_log = ls_TEMPDIR,ls_separator,"patch_adzp241_",ms_guid,".log" -- 20160921
            #20160901 
            LET ls_command = "r.r adzp241 -ID '",ms_guid,"' -PATH '",mo_sr_adzp340.sa_merge_pkg_path,"' -RCPS '",mo_sr_adzp340.sa_refresh_cust_std_section,"' | tee ",ls_adzp241_log
            RUN ls_command WITHOUT WAITING
            LET ls_memo = cs_command_tag,ls_command
            CALL sadzp340_set_memo_contents(ls_memo)
          ELSE
            LET ls_memo = cs_error_tag,"Table patch GUID get error, could not execute merge patch."
            CALL sadzp340_set_memo_contents(ls_memo)
          END IF  
        ELSE 
          #20160901 
          LET ls_command = "r.r adzp888 '",mo_sr_adzp340.sa_merge_pkg_path,"' '' '",mo_sr_adzp340.sa_refresh_cust_std_section,"'"
          RUN ls_command WITHOUT WAITING
          LET ls_memo = cs_command_tag,ls_command
          CALL sadzp340_set_memo_contents(ls_memo)
        END IF 
      END IF  
    
    ON ACTION btn_exit 
      EXIT DIALOG
      
    ON ACTION CLOSE
      EXIT DIALOG

    ON IDLE 10
      &ifndef DEBUG
        LET ls_current = cl_get_current() --20161018
      &else
        LET ls_current = CURRENT YEAR TO SECOND -- 20160921
      &endif
      LET ls_memo = cs_message_tag,ls_current," Get running status ..."
      CALL sadzp340_set_memo_contents(ls_memo)
      CALL sadzp340_check_if_any_patching_prog_runs() RETURNING lb_result
      IF lb_result THEN
        CALL DIALOG.setActionActive("btn_execute", FALSE) 
      ELSE
        CALL DIALOG.setActionActive("btn_execute", TRUE) 
      END IF
      
  END DIALOG

END FUNCTION

FUNCTION sadzp340_finalize()
  CLOSE WINDOW w_sadzp340
END FUNCTION

FUNCTION sadzp340_set_form_title(p_form,p_lang) 
DEFINE 
  p_form  STRING,
  p_lang  STRING
DEFINE 
  ls_form      STRING,
  ls_lang      STRING,
  lo_window    ui.Window,
  ls_img_path  STRING,
  ls_icon_path STRING
DEFINE 
  ls_sql    STRING,
  ls_title  VARCHAR(1024) 

  LET ls_form = p_form
  LET ls_lang = p_lang
  
  LET ls_sql = "SELECT GZDEL003                ",
               "  FROM GZDEL_T                 ",
               " WHERE GZDEL001 = '",ls_form,"'",
               "   AND GZDEL002 = '",ls_lang,"'"
               
  PREPARE lcur_set_form_title FROM ls_sql
  EXECUTE lcur_set_form_title INTO ls_title
  FREE lcur_set_form_title

  LET lo_window = ui.Window.getCurrent()
  LET ls_title = ls_form,"-",ls_title
  CALL lo_window.setText(ls_title CLIPPED) 

  LET ls_img_path  = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
  LET ls_icon_path = os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico")
  TRY 
    CALL lo_window.setImage(ls_icon_path)
  CATCH
    DISPLAY cs_warning_tag,"Can not set logo icon !"
  END TRY   
    
  
END FUNCTION

FUNCTION sadzp340_set_form_style(p_lang)
DEFINE
  p_lang STRING
DEFINE
  ls_lang     STRING,
  ls_cfg_path STRING,
  ls_4st_path STRING

  LET ls_lang = p_lang
  
  LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
  LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), ls_lang), "designer.4st")
  
  TRY 
    CALL ui.Interface.loadStyles(ls_4st_path)
  CATCH
    DISPLAY cs_warning_tag,"Can not found 'designer.4st' !"
  END TRY   
  
END FUNCTION 

FUNCTION sadzp340_set_memo_contents(p_text)
DEFINE
  p_text STRING
DEFINE
  lb_result BOOLEAN  

  LET ms_memo = ms_memo,p_text,"\n"
  DISPLAY ms_memo TO txt_memo
  CALL sadzp340_write_file(ms_log_name,ms_memo) RETURNING lb_result -- 20160921
  
END FUNCTION

FUNCTION sadzp340_run_table_patcher(p_file_name)
DEFINE
  p_file_name STRING
DEFINE
  ls_file_name STRING,
  ls_command   STRING,
  ls_GUID      STRING,
  ls_TEMPDIR   STRING,
  ls_log_file  STRING,
  ls_file_main STRING,
  lb_result    BOOLEAN,
  ls_separator STRING,
  ls_result    STRING,
  li_count     INTEGER 
DEFINE
  ls_return  STRING
  
  LET ls_file_name = p_file_name

  LET ls_separator = os.Path.separator()

  LET ls_GUID = security.RandomGenerator.CreateUUIDString()
  LET ls_TEMPDIR = FGL_GETENV("TEMPDIR")
  LET ls_file_main = os.Path.basename(ls_file_name)
  LET ls_log_file = ls_TEMPDIR,ls_separator,"adzp340_",ls_GUID,".log" 
  
  LET ls_command = "r.r adzp240 '",ls_file_name,"' > ",ls_log_file
  DISPLAY cs_command_tag,ls_command

  &ifndef DEBUG
  RUN ls_command WITHOUT WAITING
  &endif

  LET li_count = 0
  #Log 檔產生以後才離開
  WHILE TRUE
    IF os.Path.exists(ls_log_file) AND os.Path.readable(ls_log_file) THEN
      #取得Log檔中的GUID
      CALL sadzp340_get_execution_guid(ls_log_file) RETURNING lb_result,ls_result
      IF ls_result IS NOT NULL THEN 
        DISPLAY cs_message_tag,"Get Execution ID : ",ls_result
        EXIT WHILE 
      END IF
    ELSE  
      LET li_count = li_count + 1 
      SLEEP 1
      ERROR "Waiting ",li_count," seconds." ATTRIBUTES(BLUE) 
      CALL ui.Interface.refresh()
      -- 60 秒後就離開
      IF li_count > = 60 THEN
        LET ls_result = cs_error_tag,"Out of time(60s) for waiting log generating !!" 
        ERROR ls_result ATTRIBUTES(BLUE)  
        EXIT WHILE 
      END IF
    END IF  
  END WHILE  
  CALL os.Path.delete(ls_log_file) RETURNING lb_result

  LET ls_return = ls_result

  RETURN ls_return
  
END FUNCTION

FUNCTION sadzp340_get_execution_guid(p_log_file)
DEFINE
  p_log_file STRING 
DEFINE
  lo_channel   base.Channel,
  ls_TextLine  STRING,
  li_RecCnt    INTEGER,
  ls_log_file  STRING,
  ls_GUID      STRING,
  lb_success   BOOLEAN,
  ls_const_str STRING
DEFINE
  lb_return BOOLEAN,
  ls_return STRING  

  LET ls_log_file = p_log_file 

  LET lb_success = TRUE
  LET ls_TextLine = ""
  LET ls_const_str = "Execution GUID : "
  
  LET lo_channel = base.Channel.create()
  TRY 
    CALL lo_channel.openFile(ls_log_file,"r")
  CATCH
    LET lb_success = FALSE
    DISPLAY cs_error_tag,"Open file ",ls_log_file," failed !!"
  END TRY  

  IF lb_success THEN
    LET li_RecCnt = 1 
    WHILE TRUE
      IF lo_channel.isEof() THEN 
        EXIT WHILE
      END IF

      LET ls_TextLine = lo_channel.readLine()

      IF ls_TextLine.getIndexOf(ls_const_str,1) >= 1 THEN
        LET ls_GUID = ls_TextLine.subString(ls_TextLine.getIndexOf(ls_const_str,1) + ls_const_str.getLength(),ls_TextLine.getLength())
        EXIT WHILE 
      END IF 
      
      LET li_RecCnt = li_RecCnt + 1 
        
    END WHILE
  END IF

  LET lb_return = lb_success
  LET ls_return = ls_GUID.trim()

  RETURN lb_return,ls_return
  
END FUNCTION

FUNCTION sadzp340_check_if_package_running(p_path,p_program,p_log_file)
DEFINE
  p_path     STRING,
  p_program  STRING,
  p_log_file STRING
DEFINE
  ls_path     STRING,
  ls_program  STRING,
  ls_log_file STRING,
  lo_channel  base.Channel,
  ls_line     STRING,
  ls_grep_cmd STRING,
  ls_name     STRING,
  lb_del_temp BOOLEAN,
  lb_result   BOOLEAN
DEFINE
  lb_return BOOLEAN
  
  LET ls_path = p_path
  LET ls_program = p_program
  LET ls_log_file = p_log_file
  
  LET lb_result = FALSE

  LET ls_name = os.Path.basename(ls_path)
  LET ls_name = os.Path.rootname(ls_name)

  #Linux
  LET ls_grep_cmd = "ps -ef|grep ",ls_program,"|grep '",ls_name,"' > ",ls_log_file
  RUN ls_grep_cmd

  #Windows (備用, 尚未驗證)
  #LET ls_grep_cmd = 'tasklist|findstr "adzp240"|findstr "',ls_name,'" > ',ls_log_file 
  #RUN ls_grep_cmd

  #DISPLAY cs_information_tag,"Get process log on : ",ls_log_file
  LET lo_channel = base.Channel.CREATE()
  CALL lo_channel.openFile(ls_log_file, "r")
  
  WHILE TRUE
    IF lo_channel.isEof() THEN 
      EXIT WHILE
    END IF

    LET ls_line = lo_channel.readLine()
    IF ls_line.getIndexOf("fglrun-bin",1) > 0 THEN 
      #Get running GUID
      IF ls_line.getIndexOf("-ID",1) > 0 THEN
        LET ms_guid = ls_line.subString(ls_line.getIndexOf("-ID",1) + 4,ls_line.getIndexOf("-ID",1)+39)
      END IF
      IF ls_line.getIndexOf(ls_name,1) > 0 THEN 
        LET lb_result = TRUE
        EXIT WHILE
      END IF
    END IF  
    
  END WHILE
  
  CALL lo_channel.CLOSE()

  CALL os.Path.delete(ls_log_file) RETURNING lb_del_temp

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION sadzp340_check_if_any_patching_prog_runs()
DEFINE
  lb_result   BOOLEAN,
  ls_memo     STRING,
  ls_guid     STRING,
  ls_tmp_dir  STRING,
  ls_os_separ STRING,
  ls_log_file STRING
DEFINE
  lb_return BOOLEAN

  LET lb_return = FALSE

  LET ls_guid = security.RandomGenerator.CreateUUIDString()

  LET ls_tmp_dir = FGL_GETENV("TEMPDIR")
  LET ls_os_separ = os.Path.separator()
  LET ls_log_file = ls_tmp_dir,ls_os_separ,"adzp340_",ls_guid,".log" 
  
  IF mo_sr_adzp340.sa_tbl_path IS NOT NULL THEN 
    CALL sadzp340_check_if_package_running(mo_sr_adzp340.sa_tbl_path,"adzp240",ls_log_file) RETURNING lb_result
    IF lb_result THEN LET lb_return = TRUE END IF
    LET ls_memo = cs_information_tag,"Check adzp240 for ",mo_sr_adzp340.sa_tbl_path," if running : ",IIF(lb_result,"YES","NO")
    CALL sadzp340_set_memo_contents(ls_memo)

    CALL sadzp340_check_if_package_running(mo_sr_adzp340.sa_tbl_path,"adzp230",ls_log_file) RETURNING lb_result
    IF lb_result THEN LET lb_return = TRUE DISPLAY ms_guid TO ed_guid END IF
    LET ls_memo = cs_information_tag,"Check adzp230 for ",mo_sr_adzp340.sa_tbl_path," if running : ",IIF(lb_result,"YES","NO")
    CALL sadzp340_set_memo_contents(ls_memo)
  END IF  

  IF mo_sr_adzp340.sa_merge_pkg_path IS NOT NULL THEN 
    CALL sadzp340_check_if_package_running(mo_sr_adzp340.sa_merge_pkg_path,"adzp888",ls_log_file) RETURNING lb_result
    IF lb_result THEN LET lb_return = TRUE END IF
    LET ls_memo = cs_information_tag,"Check adzp888 for ",mo_sr_adzp340.sa_merge_pkg_path," if running : ",IIF(lb_result,"YES","NO")
    CALL sadzp340_set_memo_contents(ls_memo)
  END IF  

  RETURN lb_return
  
END FUNCTION

-- 20160921 begin
FUNCTION sadzp340_write_file(p_file_name,p_line_string)
DEFINE
  p_file_name   STRING,
  p_line_string STRING
DEFINE   
  ls_file_name      STRING,
  ls_line_string    STRING,
  lo_channel_write  base.Channel,
  lb_success        BOOLEAN

  LET ls_file_name  = p_file_name
  LET ls_line_string = p_line_string

  LET lb_success = TRUE
  
  LET  lo_channel_write = base.Channel.create()
  CALL lo_channel_write.setDelimiter("")

  TRY
    CALL lo_channel_write.openFile(ls_file_name, "w" )
    CALL lo_channel_write.write(ls_line_string)
    CALL lo_channel_write.close()
    DISPLAY cs_success_tag,"Data write to '",ls_file_name,"' successed !!"
  CATCH
    LET lb_success = FALSE
    DISPLAY cs_error_tag,"Data write to '",ls_file_name,"' failed !!"
  END TRY  

  RETURN lb_success
  
END FUNCTION
-- 20160921 end

-- 20161018 begin
FUNCTION sadzp340_gen_log_record(p_patch_no)
DEFINE
  p_patch_no  STRING
DEFINE
  lv_patch_no  VARCHAR(100),
  ls_memo      STRING
DEFINE 
  lb_return BOOLEAN
  
  LET lv_patch_no = p_patch_no

  LET lb_return = TRUE

  BEGIN WORK

  TRY 
    DELETE FROM dzyg_t WHERE dzyg001 = lv_patch_no

    INSERT INTO dzyg_t (dzyg001) VALUES (lv_patch_no)

    COMMIT WORK

    LET ls_memo = cs_success_tag,"Insert log into dzyg_t successed !!"
    
    CALL sadzp340_set_memo_contents(ls_memo)    
    
  CATCH 
    ROLLBACK WORK 

    LET ls_memo = cs_error_tag,"Insert log into dzyg_t failed !!"
    
    CALL sadzp340_set_memo_contents(ls_memo)    
     
  END TRY 

  RETURN lb_return
  
END FUNCTION
-- 20161018 end
