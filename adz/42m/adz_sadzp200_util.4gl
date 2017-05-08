&include "../4gl/sadzp000_mcr.inc"

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"

FUNCTION sadzp200_util_trim(p_string)
DEFINE
  p_string STRING 

  RETURN p_string.trim()

END FUNCTION 

#ALM簽出
FUNCTION sadzp200_util_check_out(p_user_info,p_prog_list,p_enable_alm)
DEFINE
  p_user_info  T_USER_INFO,
  p_prog_list  DYNAMIC ARRAY OF T_PROGRAM_INFO,
  p_enable_alm STRING 
DEFINE 
  lo_USER_INFO     T_USER_INFO,
  lo_prog_list     DYNAMIC ARRAY OF T_PROGRAM_INFO,
  ls_enable_alm    STRING, 
  ls_module_name   STRING,
  li_rec_cnt       INTEGER,
  li_dzlu_cnt      INTEGER,
  ls_prog_name     STRING,
  ls_spec_type     STRING,
  ls_err_code      STRING,
  ls_err_msg       STRING,
  lb_dzlm_exist    BOOLEAN,
  lb_result        BOOLEAN,
  ls_GUID          STRING,
  ls_update_type   STRING,
  li_step          INTEGER,
  lb_alm_exist     BOOLEAN,
  li_check_out_owner_list INTEGER,
  ls_check_out_owner_list STRING,
  lo_check_out_owner_list DYNAMIC ARRAY OF T_CHECK_OUT_OWNER_LIST,
  lo_program_info  T_PROGRAM_INFO,
  lo_DZAF_T        T_DZAF_T,
  lo_DZLU_T        DYNAMIC ARRAY OF T_DZLU_T  
DEFINE
  lb_return  BOOLEAN,
  ls_message STRING  
  
  LET lo_prog_list  = p_prog_list

  LET lo_USER_INFO.ui_NUMBER = p_user_info.ui_NUMBER
  LET lo_USER_INFO.ui_NAME   = p_user_info.ui_NAME
  LET lo_USER_INFO.ui_LANG   = p_user_info.ui_LANG
  LET lo_USER_INFO.ui_ROLE   = p_user_info.ui_ROLE

  LET ls_enable_alm = p_enable_alm

  LET lb_return  = TRUE
  LET ls_message = ""

  #取得DZLU資料
  #如果有啟動ALM模式, 則出現供選擇
  IF ls_enable_alm = "Y" THEN
    CALL sadzp200_ckout_run(lo_USER_INFO.ui_ROLE,lo_USER_INFO.ui_NUMBER,lo_USER_INFO.ui_LANG,li_step,FALSE) RETURNING lb_result,li_step,lo_DZLU_T
  ELSE
    CALL sadzp200_ckout_get_dzlu_without_alm(lo_USER_INFO.ui_ROLE,lo_USER_INFO.ui_NUMBER) RETURNING lb_result,lo_DZLU_T
  END IF   

  IF lb_result THEN 
    BEGIN WORK 
    LET lb_result = TRUE
    FOR li_dzlu_cnt = 1 TO lo_DZLU_T.getLength()
      IF NOT lb_result THEN 
        EXIT FOR 
      END IF
      #將角色重新指定
      LET lo_USER_INFO.ui_ROLE = lo_DZLU_T[li_dzlu_cnt].DZLU001
      IF lo_DZLU_T[li_dzlu_cnt].DZLU001 IS NOT NULL THEN 
        FOR li_rec_cnt = 1 TO lo_prog_list.getLength()
          
          LET ls_prog_name   = lo_prog_list[li_rec_cnt].pi_NAME 
          LET ls_module_name = lo_prog_list[li_rec_cnt].pi_MODULE
          LET ls_spec_type   = lo_prog_list[li_rec_cnt].pi_TYPE

          -------------------------------------------------------------------
          -------------------------- ALM 相關資訊 ----------------------------
          LET lo_program_info.pi_NAME   = ls_prog_name
          LET lo_program_info.pi_MODULE = ls_module_name
          LET lo_program_info.pi_DESC   = lo_prog_list[li_rec_cnt].pi_DESC
          LET lo_program_info.pi_TYPE   = ls_spec_type

          #先取得目前版號資料
          LET lo_DZAF_T.DZAF001 = lo_program_info.pi_NAME
          LET lo_DZAF_T.DZAF005 = lo_program_info.pi_TYPE
          LET lo_DZAF_T.DZAF006 = lo_program_info.pi_MODULE

          #檢核是否正被簽出
          CALL sadzp200_alm_check_item_if_check_out(lo_DZLU_T[li_dzlu_cnt].*,lo_DZAF_T.*) RETURNING lb_alm_exist
          IF lb_alm_exist THEN
            FOR li_check_out_owner_list = 1 TO lo_check_out_owner_list.getLength()
              LET ls_check_out_owner_list = ls_check_out_owner_list,cs_CRLF,
                                            "Role : ",lo_check_out_owner_list[li_check_out_owner_list].cool_ROLE,cs_CRLF, 
                                            "ID : ",lo_check_out_owner_list[li_check_out_owner_list].cool_ID,cs_CRLF,
                                            "Name : ",lo_check_out_owner_list[li_check_out_owner_list].cool_NAME,cs_CRLF,
                                            "Request Number : ",lo_check_out_owner_list[li_check_out_owner_list].cool_REQUEST_NO,cs_CRLF,
                                            "Request Sequence : ",lo_check_out_owner_list[li_check_out_owner_list].cool_SEQUENCE_NO
            END FOR 
            LET ls_err_code = "adz-00287"
            LET ls_err_msg  = ls_prog_name
            &ifndef DEBUG
            CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
            &else
            DISPLAY cs_error_tag,ls_err_code
            &endif
            LET lb_result = FALSE
            EXIT FOR
          ELSE 
            #取得物件現行的版次
            CALL sadzp200_ver_get_curr_ver_info(lo_DZAF_T.*) RETURNING lo_DZAF_T.*
            #回傳該資料在DZLM是否存在
            CALL sadzp200_alm_check_data_exist(lo_DZLU_T[li_dzlu_cnt].*,lo_DZAF_T.*) RETURNING lb_dzlm_exist
           
            #取得新版號
            CALL sadzp200_ver_get_new_ver_info(lo_DZAF_T.*,lo_USER_INFO.ui_ROLE,lb_dzlm_exist) RETURNING lb_result,lo_DZAF_T.*
            IF NOT lb_result THEN EXIT FOR END IF 
            #彙整入DZLM_T 
            CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID
            CALL sadzp200_alm_set_dzlm_mix_info(lo_DZLU_T[li_dzlu_cnt].*,lo_DZAF_T.*,lo_program_info.*,ls_GUID) RETURNING lb_result,ls_update_type
            IF NOT lb_result THEN EXIT FOR END IF
            
          END IF  
          
          -------------------------------------------------------------------
          -------------------------------------------------------------------
       
          IF NOT lb_result THEN
            LET lb_return   = FALSE
            LET ls_err_code = "adz-00284"
            LET ls_err_msg  = ls_prog_name,"|"
            &ifndef DEBUG
            CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
            &else
            DISPLAY cs_error_tag,ls_err_code
            &endif
            LET ls_message = ls_message,"[ ",ls_prog_name," ]"
          END IF
          
        END FOR
      END IF  
    END FOR
    
    LABEL _complete:
    
    IF NOT lb_result THEN
      ROLLBACK WORK 
    ELSE
      COMMIT WORK
    END IF   
    
  END IF   

  RETURN lb_result, ls_message

END FUNCTION

#ALM取消簽出
FUNCTION sadzp200_util_recall(p_user_info)
DEFINE
  p_user_info  T_USER_INFO
DEFINE 
  lo_USER_INFO     T_USER_INFO,
  ls_prog_name     STRING,
  ls_err_code      STRING,
  ls_err_msg       STRING,
  lb_result        BOOLEAN,
  lb_commit        BOOLEAN,
  li_count         INTEGER,
  ls_DGENV         STRING,
  ls_update_type   STRING,
  lo_DZAF_T        T_DZAF_T,
  lo_DZLM_T        T_DZLM_T,
  lo_dar_DZLM_T    DYNAMIC ARRAY OF T_DZLM_T
DEFINE
  lb_return  BOOLEAN,
  ls_message STRING  
  
  LET lo_USER_INFO.ui_NUMBER = p_user_info.ui_NUMBER
  LET lo_USER_INFO.ui_NAME   = p_user_info.ui_NAME
  LET lo_USER_INFO.ui_LANG   = p_user_info.ui_LANG
  LET lo_USER_INFO.ui_ROLE   = p_user_info.ui_ROLE

  LET lb_return  = TRUE
  LET ls_message = ""

  #先取得DZLM的資料
  CALL sadzp200_recall_run(lo_USER_INFO.ui_ROLE,lo_USER_INFO.ui_NUMBER,lo_USER_INFO.ui_LANG,FALSE) RETURNING lb_result,lo_dar_DZLM_T

  LET ls_DGENV = FGL_GETENV("DGENV")  

  IF lb_result THEN 
    FOR li_count = 1 TO lo_dar_DZLM_T.getLength()
      IF lo_dar_DZLM_T[li_count].DZLM002 IS NOT NULL THEN
        LET ls_prog_name = lo_dar_DZLM_T[li_count].DZLM002
        BEGIN WORK
        LET lb_commit = TRUE
        #先刪除介面檔資料
        CALL sadzp200_intf_delete_interface_data(lo_USER_INFO.ui_ROLE,lo_DZLM_T.*) RETURNING lb_result
        --IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF
        #依據要取消的ROLE將相關資料清空並重新回傳
        CALL sadzp200_alm_preset_dzlm(lo_dar_DZLM_T[li_count].*,lo_USER_INFO.ui_ROLE) RETURNING lo_DZLM_T.*
        #依據角色清空對應的版次欄位
        CALL sadzp200_alm_set_dzlm(lo_DZLM_T.*,lo_USER_INFO.ui_ROLE) RETURNING lb_result,ls_update_type
        IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF
        #檢核DZLM資料是否還有效(還存在SD或PR的資訊)
        --CALL sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_out) RETURNING lb_result
        IF NOT sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_out) AND NOT sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_in) THEN
          #當DZLM中的SD或PR項的板次都不存在時, 表示該簽出均已取消, DZLM及DZAF的資訊均可刪除
          CALL sadzp200_alm_delete_dzlm_data(lo_DZLM_T.*) RETURNING lb_result
          IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF 
          CALL sadzp200_ver_delete_data(lo_DZLM_T.*,ls_DGENV) RETURNING lb_result
          IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF 
        ELSE
          #更新版次資訊(DZAF_T)
          LET lo_DZAF_T.DZAF001 = lo_DZLM_T.DZLM002
          LET lo_DZAF_T.DZAF002 = lo_DZLM_T.DZLM005
          LET lo_DZAF_T.DZAF005 = lo_DZLM_T.DZLM001
          LET lo_DZAF_T.DZAF006 = lo_DZLM_T.DZLM004
          #先取得現行的DZAF版次相關資料
          CALL sadzp200_ver_get_curr_ver_info(lo_DZAF_T.*) RETURNING lo_DZAF_T.*
          #遞減對應的版次號碼
          CALL sadzp200_ver_decreas_dzaf_ver(lo_DZAF_T.*,lo_USER_INFO.ui_ROLE) RETURNING lo_DZAF_T.*
          #更新資料庫
          CALL sadzp200_ver_set_ver(lo_DZAF_T.*,lo_USER_INFO.ui_ROLE) RETURNING lb_result
          IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF 
        END IF 
        #刪除設計資料
        CALL sadzp200_util_del_spec_data(lo_DZLM_T.*,lo_USER_INFO.ui_ROLE) RETURNING lb_result
        IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF 
        
        LABEL _CheckWork:
        
        IF lb_commit THEN 
          COMMIT WORK
        ELSE
          ROLLBACK WORK
        END IF

        IF NOT lb_commit THEN
          LET lb_return   = FALSE
          LET ls_err_code = "adz-00297"
          LET ls_err_msg  = ls_prog_name,"|"
          &ifndef DEBUG
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          &else
          DISPLAY cs_error_tag,ls_err_code
          &endif
          LET ls_message = ls_message,"[ ",ls_prog_name," ]"
        END IF
        
      END IF   
    END FOR
  END IF   

  RETURN lb_result, ls_message

END FUNCTION

FUNCTION sadzp200_util_del_spec_data(p_DZLM_T,p_role)
DEFINE
  p_DZLM_T  T_DZLM_T,
  p_role    STRING    
DEFINE
  lo_DZLM_T    T_DZLM_T,
  ls_role      STRING,    
  ls_prog_no   STRING,
  ls_ver       STRING,
  ls_spec_type STRING,
  ls_zone      STRING,
  ls_erpver    STRING,
  ls_message   STRING,
  lb_result    BOOLEAN
DEFINE 
  lb_return  BOOLEAN

  LET lo_DZLM_T.* = p_DZLM_T.*
  LET ls_role     = p_role
  
  LET ls_spec_type = lo_DZLM_T.DZLM001
  LET ls_prog_no   = lo_DZLM_T.DZLM002

  CASE 
    WHEN ls_role = cs_user_role_sd
      LET ls_ver = lo_DZLM_T.DZLM006
    WHEN ls_role = cs_user_role_pr
      LET ls_ver = lo_DZLM_T.DZLM009
  END CASE 

  LET ls_zone   = FGL_GETENV("ZONE") CLIPPED
  LET ls_erpver = FGL_GETENV("ERPVER") CLIPPED

  LET lb_result = TRUE
  
  #Input parameter : p_code 規格/程式代號
  #                : p_ver  規格/程式版次
  #                : p_kind 檔案種類(SPEC/CODE)
  #Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
  #                : STRING (錯誤訊息)
  &ifndef DEBUG
  --CALL sadzp062_1_del_spec_data_db(ls_prog_no, ls_ver, ls_spec_type) RETURNING lb_result,ls_message
  &endif
  
  LET lb_return = lb_result

  RETURN lb_return

END FUNCTION

FUNCTION sadzp200_util_get_static_role_list()
DEFINE
  lo_role_arr T_STATIC_ROLE_LIST
DEFINE
  lo_return T_STATIC_ROLE_LIST

  #設定角色Array
  LET lo_role_arr[1] = cs_user_role_sd
  LET lo_role_arr[2] = cs_user_role_pr

  LET lo_return = lo_role_arr

  RETURN lo_return

END FUNCTION 

FUNCTION sadzp200_util_set_form_title(p_form,p_lang) 
DEFINE 
  p_form  STRING,
  p_lang  STRING
DEFINE 
  ls_form      STRING,
  ls_lang      STRING,
  lo_window    ui.Window,
  lf_form      ui.Form,
  ls_cfg_path  STRING,
  ls_4st_path  STRING,
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
  CALL lo_window.setText(ls_title CLIPPED) 

  LET ls_img_path  = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
  LET ls_icon_path = os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico")
  TRY 
    CALL lo_window.setImage(ls_icon_path)
  CATCH
    DISPLAY cs_warning_tag,"Can not set logo icon !"
  END TRY   
  
END FUNCTION

FUNCTION sadzp200_util_set_form_style(p_lang)
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