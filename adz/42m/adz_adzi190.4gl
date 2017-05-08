{
  異動型態      version       日 期       異動者      異動內容
  =========== ============= ========== ========== =======================
  add         20170103      20170103   CircleLai  新增釋出功能(btn_release)
  add         20170103      20170104   CircleLai  新增異動標籤(lbl_modify_info)

#170210-00052#1 ver:20170218 2017/02/10 by circlelai :
   1.新增欄位dzit011區分新舊版 trigger script (azzs010維護旗標);2.新增TopMenu 功能,匯入匯出設計資料,批次執行建構選項;3.新增debug模式(需驗證碼)
}


&include "../4gl/sadzi190_mcr.inc"

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi190_type.inc"

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi190_cnst.inc"

CONSTANT cs_erp_path STRING = "ERP"
CONSTANT cs_program_title STRING = "adzi190-Trigger creator "
CONSTANT cs_version       STRING = "20170218"

GLOBALS "../../cfg/top_global.inc"

DEFINE 
  ms_lang         STRING,
  ms_user         STRING,   #目前使用者
  ms_dept         STRING,
  mb_debug        BOOLEAN,
  mo_master_db    T_PARAMETERS,
  mo_master_user  T_PARAMETERS,
  ms_enterprise   STRING,
  ms_search       STRING,
  ms_module       STRING,
  ms_DGENV        STRING,
  ms_alter_type   STRING,
  ms_db_name      STRING,
  mo_window       ui.Window, 
  mo_form         ui.Form,  
  mb_enable_alm   BOOLEAN,
  mb_enb_chkout   BOOLEAN    #檢查是否可簽出  --DGW07558_add_at20151118
DEFINE mdt_login_time DATETIME YEAR TO SECOND  -- 170210-00052#1 add by circlelai
  
#定義模組變數
DEFINE m_dzit_t_h_scr DYNAMIC ARRAY OF T_DZIT_T_WL_H_SCR
DEFINE m_dzit_t_b_scr T_DZIT_T_WL_B_SCR

DEFINE mi_dzit_h_index  INTEGER
DEFINE mi_dzit_b_index  INTEGER

MAIN 
  CALL adzi190_initialize()
  CALL adzi190_initial_form()
  CALL adzi190_start()
  CALL adzi190_finalize(TRUE) 
END MAIN

# @desc 作業初始化 載入相關系統參數
FUNCTION adzi190_initialize()
DEFINE
  ls_parameter    STRING,
  ls_replace_arg  STRING,
  lb_exists       BOOLEAN,
  lb_error        BOOLEAN, 
  ls_user         STRING,
  ls_erpalm       STRING,
  ls_erpchkout    STRING
-- 170210-00052#1 add 17/02/20 by circlelai begin
DEFINE ls_verify_code STRING  #驗證碼 
DEFINE ls_chk_code STRING  # 確認碼
DEFINE lb_result STRING  # 
-- 170210-00052#1 add 17/02/20 by circlelai end 
  #20160103
  DISPLAY cs_information_tag, "Version : ", cs_version #version 方便開發者於客戶家辨識
  
  CALL sadzi190_util_set_execute_path(os.path.pwd()) #設定執行路徑
  
  &ifndef DEBUG
    #依模組進行系統初始化設定(系統設定)
    CALL cl_tool_init()
    CALL cl_db_connect("ds", TRUE)
    LET ms_lang = g_lang
    LET ms_user = g_account --g_user -- 
    LET ms_dept = g_dept
    LET g_bgjob = "N"
    LET ms_enterprise = g_enterprise
    
    # 170210-00052#1 at 17/02/20 by circlelai begin
    # LET mb_debug = IIF(UPSHIFT(ARG_VAL(2))=="DEBUG",TRUE,FALSE) # 170210-00052#1 mark 17/02/20
    LET mb_debug = FALSE 
    IF (UPSHIFT(ARG_VAL(2))=="DEBUG") THEN 
      # debug mode, check input verify code 
      LET ls_verify_code = NVL(UPSHIFT(ARG_VAL(3)), NULL)
      LET ls_verify_code = sadzp310_util_trim_str(ls_verify_code)
      # check verify code is not null string
      IF ls_verify_code.getLength() > 0 THEN
        LET ls_chk_code = TODAY USING 'YYYYMMDD' , "28682266"
        CALL sadzp310_util_ComputeHash(ls_chk_code, "MD5") RETURNING lb_result, ls_chk_code
        IF lb_result THEN 
          IF (UPSHIFT(ls_chk_code) == ls_verify_code) THEN
            LET mb_debug = TRUE 
          END IF 
        END IF
      END IF
      # DISPLAY "[" , ls_verify_code , "],[" , ls_chk_code , "]" # debug
    END IF 
    # 170210-00052#1 at 17/02/20 by circlelai end
    
    #是否啟動ALM
    CALL FGL_GETENV("TOPALM") RETURNING ls_erpalm
    CALL FGL_GETENV("TOPCHKOUT") RETURNING ls_erpchkout
    LET mdt_login_time = cl_get_current()
  &else
    CALL FGL_GETENV("USER") RETURNING ls_user
    LET ms_lang = cs_default_lang
    LET ms_user = ls_user
    LET ms_dept = cs_dept
    CALL sadzi190_db_connect_db(cs_local_db)
    LET mb_debug = TRUE #IIF(UPSHIFT(ARG_VAL(1))=="DEBUG",TRUE,FALSE)
    LET ls_erpalm = "Y"
    LET ls_erpchkout = "Y"
    LET mdt_login_time = CURRENT YEAR TO SECOND
  &endif

  LET mb_enable_alm = IIF(NVL(ls_erpalm,"N")=="Y",TRUE,FALSE)
  LET mb_enb_chkout = IIF(NVL(ls_erpchkout,"N")=="Y",TRUE,FALSE)
  
  #是否客制環境
  &ifndef DEBUG
  LET ms_DGENV = FGL_GETENV("DGENV")
  &else
  LET ms_DGENV = cs_dgenv_standard
  &endif
  
  #取得Master DB 及 User 及 使用者定義欄位
  CALL sadzi190_db_get_parameters(cs_param_level_system,cs_param_master_db) RETURNING mo_master_db.*
  CALL sadzi190_db_get_parameters(cs_param_level_system,cs_param_master_user) RETURNING mo_master_user.*

END FUNCTION

# @desc 介面初始化
FUNCTION adzi190_initial_form()
  DEFINE ls_tiptop_4ad   STRING
  DEFINE ls_erp_path     STRING # $ERP 
  DEFINE ls_sql          STRING 
  DEFINE ls_separator    STRING
  DEFINE ls_temp         STRING
  DEFINE ls_toolbar      STRING
  DEFINE li_cnt          INTEGER
  DEFINE lo_combobox     ui.ComboBox
  DEFINE ls_top_menu   STRING  # topmenu(4tm)檔案路徑 # 170210-00052#1 add 
  DEFINE ls_img_path   STRING   # 170210-00052#1 add 
  DEFINE ls_logo_path  STRING  # 170210-00052#1 add 

  LET ls_separator = os.Path.separator()
  LET ls_erp_path  = FGL_GETENV(cs_erp_path) 
  
  #按 Enter 自動跳欄位
  OPTIONS INPUT WRAP
  CLOSE WINDOW SCREEN
  # 取得 toolbar 檔案路徑 
  LET ls_toolbar = ls_erp_path , ls_separator 
                 , "cfg" , ls_separator , "4tb" , ls_separator 
                 , "toolbar_adzi190_" , ms_lang , ".4tb"  -- 20160309 add by circlelai 
  # 取得 topmenu 檔案路徑 
  LET ls_top_menu = ls_erp_path,ls_separator 
                  , "adz" , ls_separator , "4tm" , ls_separator
                  , ms_lang , ls_separator , "adzi190.4tm"  -- 170210-00052#1 add
  
  &ifndef DEBUG
  OPEN WINDOW w_adzi190 WITH FORM cl_ap_formpath("ADZ","adzi190") 
  CURRENT WINDOW IS w_adzi190

  LET mo_window = ui.Window.getCurrent()
  LET mo_form   = mo_window.getForm()

  # 170210-00052#1 at 2017/02/17 by circlelai begin
  CALL cl_ui_wintitle(1) #工具抬頭名稱
  LET ls_logo_path = os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico")
  CALL mo_window.setImage(ls_logo_path)
  # export TopMenu 功能
  DISPLAY cs_information_tag,"Load top menu : ",ls_top_menu 
  CALL mo_form.loadTopMenu(ls_top_menu)
  LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
  LET ls_logo_path = os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico")
  # 170210-00052#1 at 2017/02/17 by circlelai end
    
  #載入toolbar --20160309 add by circlelai
  DISPLAY cs_information_tag,"Load toolbar : ",ls_toolbar 
  CALL mo_form.loadToolBar(ls_toolbar) 
  
  CALL ui.Interface.loadStyles(ls_erp_path||ls_separator||"cfg"||ls_separator||"4st"||ls_separator||"adzi190")
  #讓ON ACITON controlg的Button從畫面上消失, 改成用Ctrl-G來觸發
  CALL cl_load_4ad_interface(NULL) 
  &else
  OPEN WINDOW w_adzi190 WITH FORM sadzi190_util_get_form_path("adzi190")
  CURRENT WINDOW IS w_adzi190
  
  CALL adzi190_set_window_title()
  
  LET mo_window = ui.Window.getCurrent()
  LET mo_form   = mo_window.getForm()
  # 170210-00052#1 at 2017/02/17 by circlelai begin
  DISPLAY cs_information_tag,"Load top menu : ",ls_top_menu
  CALL mo_form.loadTopMenu(ls_top_menu)
  # 170210-00052#1 at 2017/02/17 by circlelai end
  CALL ui.Interface.loadStyles("adzi190")
  CALL ui.Interface.loadActionDefaults("resource\\tiptop_0")
  &endif

  CALL ui.Dialog.setDefaultUnbuffered(TRUE)

  #combobox
  LET ls_sql = "SELECT GZCB002                 STAT_TYPE,  ",
               "       GZCB002||'. '||GZCBL004 STAT_NAME   ",
               "  FROM GZCB_T CB                           ",
               "  LEFT OUTER JOIN GZCBL_T                  ",
               "               ON GZCB001  = GZCBL001      ",
               "              AND GZCB002  = GZCBL002      ",
               "              AND GZCBL003 = '",ms_lang,"' ",
               " WHERE CB.GZCB001 = 197                    ",
               " ORDER BY CB.GZCB012                       "
               
  LET lo_combobox = ui.ComboBox.forName("formonly.lbl_dzit009")
  CALL adzi190_fill_combobox(lo_combobox,ls_sql)
  LET lo_combobox = ui.ComboBox.forName("formonly.ed_dzit009")
  CALL adzi190_fill_combobox(lo_combobox,ls_sql)
  
END FUNCTION 

FUNCTION adzi190_start()
  DEFINE
    ls_top_module_name  STRING,
    ls_top_env          STRING,
    ls_user             STRING,
    ls_master_user      STRING,
    ls_os_separator     STRING,
    ls_separator        STRING,
    ls_table_name       STRING,
    ls_trigger_name     STRING,
    ls_message          STRING, 
    ls_owners_queue     STRING,
    ls_answer           STRING,
    ls_replace_arg      STRING,
    ls_exe_item         STRING,
    lb_kill_data        BOOLEAN,
    li_idx              INTEGER,
    lo_win              ui.Window,
    lo_dzit_t           T_DZIT_T_WL,
    lo_COMPRESS_FILE_INFO   T_COMPRESS_FILE_INFO,
    lo_jsonobj          util.JSONObject,
    #ALM begin##################
    lo_DZLU_T          DYNAMIC ARRAY OF T_DZLU_T,
    lo_user_info       T_USER_INFO, -- 使用者資訊物件
    lo_dzlm_t          T_DZLM_T,
    lo_table_info      T_PROGRAM_INFO
    #ALM end##################
  DEFINE ls_parameter    STRING  # 170210-00052#1 add 
  DEFINE ls_program_name STRING  # 170210-00052#1 add
  DEFINE ls_about        STRING  # 170210-00052#1 add
  DEFINE  # retuen_parameter
    lb_result  BOOLEAN

  LET ls_top_module_name = cs_top_module_name
  LET ls_top_env         = FGL_GETENV(ls_top_module_name)
  LET ls_user            = ms_user  
  LET ls_master_user     = mo_master_user.PARAMETER1

  LET ls_separator = os.Path.separator()

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  DIALOG ATTRIBUTES(UNBUFFERED)
    
    #Table Lists 
    DISPLAY ARRAY m_dzit_t_h_scr TO sr_trigger_list.*
      BEFORE ROW 
        LET mi_dzit_h_index = ARR_CURR()
        LET ls_table_name = m_dzit_t_h_scr[mi_dzit_h_index].DZIT001
        CALL adzi190_refresh_detail(DIALOG,m_dzit_t_h_scr[mi_dzit_h_index].*)
        CALL adzi190_set_active_state(DIALOG, mi_dzit_h_index)
        CALL adzi190_set_check_out_mode(DIALOG, m_dzit_t_h_scr[mi_dzit_h_index].*)
    END DISPLAY

    #Table Columns
    --DISPLAY ARRAY m_dzit_t_b_scr TO sr_trigger_data.*
    --END DISPLAY

    INPUT m_dzit_t_b_scr.* FROM sr_trigger_data.* ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE INPUT 
        CALL DIALOG.setFieldActive("sr_trigger_data.*",FALSE)
    END INPUT

    #輸入搜尋條件
    INPUT ms_search FROM ed_search ATTRIBUTE(WITHOUT DEFAULTS)
    END INPUT

    INPUT ms_db_name FROM ed_db_list ATTRIBUTE(WITHOUT DEFAULTS)
      ON CHANGE ed_db_list
        CALL adzi190_refresh_master(DIALOG)
    END INPUT

    #標準轉客制...etc操作行為 --DGW07558_add_at20151230
    INPUT ls_exe_item FROM cbo_exe ATTRIBUTE(WITHOUT DEFAULTS)
    END INPUT
    
    BEFORE DIALOG
      CALL DIALOG.setFieldActive("ed_dzit003",FALSE)
      LET lo_win = ui.Window.getCurrent()
      LET mi_dzit_h_index = 1
      CALL lo_win.setImage("logo/dsc_logo.ico")
      CALL adzi190_fill_dzit_t_h()
      
    ON ACTION find_data
      CLEAR sr_trigger_list.*
      LET mi_dzit_h_index = 1
      CALL adzi190_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_trigger_list", mi_dzit_h_index)
      CALL adzi190_set_active_state(DIALOG, mi_dzit_h_index)
      NEXT FIELD lbl_dzit001

    ON ACTION tbi_create_trigger #新建觸發器
      #ALM begin
      #先呼叫簽出
      CALL sadzi190_util_alm_check_out(mb_enable_alm,ms_user,ms_lang,cs_user_role_sd,FALSE) 
           RETURNING lb_result,lo_USER_INFO.*,lo_DZLU_T
      #ALM end
      
      IF lb_result THEN
        LET ms_alter_type = cs_create_trigger
        CALL adzi190_alter_trigger(m_dzit_t_b_scr.*,FALSE) RETURNING lb_result,lo_dzit_t.*
        IF lb_result THEN
          #新增表格資料成功, 則在 dzlm_t 中實際寫入註冊資料 
          #ALM begin
          CALL sadzi190_util_set_alm_info(lo_dzit_t.DZIT002, cs_mdm_module_name, 
                                          lo_dzit_t.DZITL006, cs_mdm_construct_type_trigger, 
                                          cs_ver_type_sd,lo_DZLU_T) 
               RETURNING lb_result,lo_dzlm_t.*
          IF NOT lb_result THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = "adz-00726" #寫入ALM資訊失敗
            LET g_errparam.extend = NULL
            LET g_errparam.popup  = TRUE  #訊息開窗顯示
            LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
            CALL cl_err()
          END IF
          #ALM end

          #調整目前指向位置
          CALL adzi190_fill_dzit_t_h()
          FOR li_idx = 1 TO m_dzit_t_h_scr.getLength()
            IF (m_dzit_t_h_scr[li_idx].DZIT001 == lo_dzit_t.DZIT001
                AND m_dzit_t_h_scr[li_idx].DZIT002 == lo_dzit_t.DZIT002
                AND m_dzit_t_h_scr[li_idx].DZIT003 == lo_dzit_t.DZIT003) THEN
              LET mi_dzit_h_index = li_idx
              EXIT FOR 
            END IF 
          END FOR 
          
        END IF 
      END IF 
      CALL adzi190_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_trigger_list",mi_dzit_h_index)
      CALL adzi190_set_active_state(DIALOG, mi_dzit_h_index)

    ON ACTION MODIFY  #修改觸發器
      IF (m_dzit_t_b_scr.DZIT003 <> cs_alias_erp_db AND m_dzit_t_b_scr.DZIT003 <> cs_alias_aws_db) THEN 
        #rixqq? 過渡期,舊有設計資料不能異動 --add at 201601261715 DGW07558 
        CALL sadzi190_msg_message_box("Error","dialog","舊有設計資料不能修改.","stop")
        CONTINUE DIALOG  
      END IF 
      LET ms_alter_type = cs_modify_trigger
      CALL adzi190_alter_trigger(m_dzit_t_b_scr.*,FALSE) RETURNING lb_result,lo_dzit_t.*
      CALL adzi190_refresh_master(DIALOG)
      
    ON ACTION tbi_drop_trigger  #刪除觸發器
      LET ls_trigger_name = m_dzit_t_b_scr.DZIT002 
      IF ls_trigger_name.trim() IS NULL THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00774" # 無觸發器資料
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
        CALL cl_err()
        CONTINUE DIALOG  
      END IF
      IF (m_dzit_t_b_scr.DZIT003 <> cs_alias_erp_db AND m_dzit_t_b_scr.DZIT003 <> cs_alias_aws_db) THEN 
        #rixqq? 過渡期,舊有設計資料不能異動 --add at 201601261715 DGW07558 
        CALL sadzi190_msg_message_box("Error","dialog","舊有設計資料不能刪除.","stop")
        CONTINUE DIALOG  
      END IF 
      CALL adzi190_prepare_dzit_t_data(m_dzit_t_b_scr.*) RETURNING lo_dzit_t.*
      CALL sadzi190_dtas_decode_columns(lo_dzit_t.DZIT003) RETURNING ls_owners_queue
      #是否一併刪除設定資料
      CALL sadzp000_msg_get_message('adz-00731', ms_lang) RETURNING ls_replace_arg
      LET ls_answer = sadzi190_msg_question_box("adz-00731", "dialog", ls_replace_arg, "question")
      IF (ls_answer <> cs_response_cancel) THEN   
        IF ls_answer = cs_response_yes THEN
          LET lb_kill_data = TRUE  
        ELSE
          LET lb_kill_data = FALSE  
        END IF
        #客制環境下刪除'客制的'設計資料,檢查是否"標準轉客制"的設計資料
        IF lb_kill_data AND (ms_dgenv == cs_dgenv_customize) AND
           (lo_dzit_t.DZIT004 == cs_dgenv_customize) THEN
          LET lo_dzit_t.DZIT004 = cs_dgenv_standard
          IF (sadzi190_crud_check_if_dzit_t_exists(lo_dzit_t.*)) THEN 
            # 標準轉客制的資料執行'客制還原標準'
            LET lo_dzit_t.DZIT004 = cs_dgenv_customize
            CALL adzi190_cust_to_std(DIALOG) RETURNING lb_result --客制還原標準
            CONTINUE DIALOG  
          END IF
          LET lo_dzit_t.DZIT004 = cs_dgenv_customize
        END IF
        CALL sadzi190_util_drop_trigger(lo_dzit_t.*,ls_owners_queue,lb_kill_data) RETURNING lb_result,ls_message
        CALL adzi190_gen_log_file(ls_message)  #紀錄異動行為LOG,以方便之後追查用 --DGW07558_at20151202 
        CALL sadzi190_get_and_set_trigger_status(lo_dzit_t.*) RETURNING lb_result
        IF lb_result THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00772"   # 删除 %1 程序完成
          LET g_errparam.extend = NULL
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.replace[1] = lo_dzit_t.DZIT002  
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
          CALL cl_err()
          LET mi_dzit_h_index = 1
        ELSE
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00773"   # 刪除觸發器失敗,請參考Log內容
          LET g_errparam.extend = NULL
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
          CALL cl_err()
          CALL sadzi190_log_view_logresult(ls_message)
        END IF  
      END IF   
      CALL adzi190_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_trigger_list",mi_dzit_h_index) 
      CALL adzi190_set_active_state(DIALOG, mi_dzit_h_index)

    ON ACTION tbi_build_trigger  #執行建構
      CALL adzi190_prepare_dzit_t_data(m_dzit_t_b_scr.*) RETURNING lo_dzit_t.*
      CALL adzi190_tbi_build_trigger(DIALOG, lo_dzit_t.*, NULL) RETURNING lb_result
    
    ON ACTION tbi_switch_trigger  #開關觸發器
      LET ls_trigger_name = m_dzit_t_b_scr.DZIT002 
      IF ls_trigger_name.trim() IS NULL THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00774"   # 無觸發器資料
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
        CALL cl_err()
        CONTINUE DIALOG  
      END IF

      IF (m_dzit_t_b_scr.DZIT009 == "N") THEN  # trigger 狀態為未建立的,不能夠執行開關
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00782"   # 觸發器未建立,無法執行動作  請執行建構
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
        CALL cl_err()
        CONTINUE DIALOG  
      END IF
      
      CALL adzi190_prepare_dzit_t_data(m_dzit_t_b_scr.*) RETURNING lo_dzit_t.*
      CALL sadzi190_dtas_decode_columns(lo_dzit_t.DZIT003) RETURNING ls_owners_queue

      LET lo_jsonobj = util.JSONObject.create()
      CALL lo_jsonobj.put("owners_queue", ls_owners_queue)
      CALL sadzi190_util_switch_trigger(lo_dzit_t.*, lo_jsonobj) RETURNING lb_result,ls_message
      CALL adzi190_gen_log_file(ls_message)  #紀錄異動行為LOG,以方便之後追查用 --DGW07558_at20151202
      IF NOT lb_result THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00775"   # 開關Trigger失敗,請參考Log內容
        LET g_errparam.extend = lo_dzit_t.DZIT002
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
        CALL cl_err()
        CALL sadzi190_log_view_logresult(ls_message)
      ELSE
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00217"   # 執行成功
        LET g_errparam.extend = lo_dzit_t.DZIT002
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
        CALL cl_err()
      END IF  
      CALL sadzi190_get_and_set_trigger_status(lo_dzit_t.*) RETURNING lb_result
      CALL adzi190_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_trigger_list",mi_dzit_h_index)

    #ALM begin
    ON ACTION btn_check_out  #簽出
      #先呼叫簽出
      CALL sadzi190_util_alm_check_out(mb_enable_alm,ms_user,ms_lang,cs_user_role_sd,FALSE) 
           RETURNING lb_result,lo_USER_INFO.*,lo_DZLU_T

      IF lb_result THEN 
        #在 dzlm_t 中實際寫入註冊資料
        CALL sadzi190_util_set_alm_info(m_dzit_t_b_scr.DZIT002,cs_mdm_module_name,m_dzit_t_b_scr.DZITL006,cs_mdm_construct_type_trigger,cs_ver_type_sd,lo_DZLU_T) RETURNING lb_result,lo_dzlm_t.*
        IF lb_result THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00776"   # 簽出成功
          LET g_errparam.extend = m_dzit_t_b_scr.DZIT002 CLIPPED
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
          CALL cl_err() 
        ELSE 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00759"   # 簽出失敗
          LET g_errparam.extend = m_dzit_t_b_scr.DZIT002 CLIPPED
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
          CALL cl_err()
        END IF 
      END IF
      CALL adzi190_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_trigger_list",mi_dzit_h_index)
      CALL adzi190_set_active_state(DIALOG, mi_dzit_h_index)
      
    ON ACTION btn_recall   
      CALL adzi190_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_trigger_list",mi_dzit_h_index)
      CALL adzi190_set_active_state(DIALOG, mi_dzit_h_index)

    ON ACTION btn_release  #釋出功能  # 20170103
       GOTO _CHECK_IN
    ON ACTION btn_check_in  #簽入
       LABEL _CHECK_IN:
      #取得現今DZLM的資料
      LET lo_table_info.pi_NAME   = m_dzit_t_b_scr.DZIT002        # 觸發器ID
      LET lo_table_info.pi_MODULE = cs_mdm_module_name            # MDM(中間庫組件)
      LET lo_table_info.pi_DESC   = m_dzit_t_b_scr.DZITL006       # 觸發器描述
      LET lo_table_info.pi_TYPE   = cs_mdm_construct_type_trigger # 物件類型
      CALL sadzi190_util_alm_check_in(lo_table_info.*,cs_ver_type_sd) RETURNING lb_result
      IF lb_result THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00777" # 簽入成功
        LET g_errparam.extend = m_dzit_t_b_scr.DZIT002 CLIPPED
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
        CALL cl_err() 
      ELSE 
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00778" # 簽入失敗
        LET g_errparam.extend = m_dzit_t_b_scr.DZIT002 CLIPPED
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
        CALL cl_err() 
      END IF
      CALL adzi190_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_trigger_list",mi_dzit_h_index)
      CALL adzi190_set_active_state(DIALOG, mi_dzit_h_index)
    
    #ALM end

    ON ACTION btn_exe_act #標準、客制轉換
      IF (ls_exe_item.trim() IS NULL) THEN #未選擇動作
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00564" # 請先選取資料！
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 
        CALL cl_err()
        CONTINUE DIALOG
      ELSE
        #DISPLAY "ls_exe_item = ", ls_exe_item,""
        CASE ls_exe_item
          WHEN "1"  #標準轉客制 
            CALL adzi190_std_to_cust(DIALOG) RETURNING lb_result
          WHEN "2"  #客制還原標準
            CALL adzi190_cust_to_std(DIALOG) RETURNING lb_result
        END CASE 
      END IF

    # 170210-00052#1 at 2017/02/17 by circlelai begin  新增TOPMENU功能行為
    # TopMenu 工具-->觸發器設計資料匯出
    ON ACTION tm_export 
      # r.r adzp310 -WT iexp -CT MG -WO 'imaa_trg' -EFL '/u3/usr/testuser/adzp310'
      LET ls_trigger_name = m_dzit_t_b_scr.DZIT002
      LET ls_program_name = "adzp310"
      LET ls_parameter = "r.r " , ls_program_name , " -SD -WT iexp -CT MG -WO ", ls_trigger_name
      # 檢查執行程式是否存在
      IF sadzi190_util_check_program_exists(ls_program_name) THEN
        CALL cl_cmdrun_openpipe("r.r",ls_parameter,FALSE) RETURNING lb_result,ls_message
      END IF

    # TopMenu 工具-->觸發器設計資料匯入
    ON ACTION tm_import
      LET ls_trigger_name = m_dzit_t_b_scr.DZIT002
      LET ls_program_name = "adzp310"
      LET ls_parameter = "r.r ",ls_program_name," -SD -WT iimp " -- 沒有執行建構
      IF sadzi190_util_check_program_exists(ls_program_name) THEN
        CALL cl_cmdrun_openpipe("r.r",ls_parameter,FALSE) RETURNING lb_result,ls_message
      END IF
      CALL adzi190_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_trigger_list",mi_dzit_h_index)
      CALL adzi190_set_active_state(DIALOG, mi_dzit_h_index)

    # TopMenu DBA-->批次建構所有設計資料
    ON ACTION tm_buildall 
      # r.r adzp310 -WT iasm -CT MG -WO ALL 
      LET ls_program_name = "adzp310"
      LET ls_parameter = "r.r ",ls_program_name," -WT iasm -CT MG -WO ALL "
      IF sadzi190_util_check_program_exists(ls_program_name) THEN
        CALL cl_cmdrun_openpipe("r.r",ls_parameter,FALSE) RETURNING lb_result,ls_message
      END IF
      CALL adzi190_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_trigger_list",mi_dzit_h_index)
      CALL adzi190_set_active_state(DIALOG, mi_dzit_h_index)
    # TopMenu 其他-->關於
    ON ACTION tm_about
      LET ls_about = adzi190_get_system_information(FALSE)
      # OPEN MENU
      MENU 'About' ATTRIBUTE (STYLE="dialog", COMMENT=ls_about.trim() CLIPPED, IMAGE="information")
        ON ACTION ok
          EXIT MENU
      END MENU
    # 170210-00052#1 at 2017/02/17 by circlelai end 
    
    ON ACTION EXIT
      LET INT_FLAG=FALSE         
      EXIT DIALOG  
      
    ON ACTION CLOSE    
      LET INT_FLAG=FALSE         
      EXIT DIALOG

    CONTINUE DIALOG  

  END DIALOG

END FUNCTION

FUNCTION adzi190_finalize(p_value)
DEFINE
  p_value BOOLEAN

  IF p_value THEN
    EXIT PROGRAM
  ELSE
    EXIT PROGRAM -1
  END IF 
  
END FUNCTION

FUNCTION adzi190_set_window_title()
DEFINE
  ls_zone          STRING,
  ls_user          STRING,
  ls_user_domain   STRING,
  lo_db_info       T_DB_INFO,
  ls_program_title STRING,
  ls_window_title  STRING

  CALL FGL_GETENV("ZONE") RETURNING ls_zone

  #For get Windows information
  CALL FGL_GETENV("USERNAME") RETURNING ls_user
  CALL FGL_GETENV("USERDOMAIN") RETURNING ls_user_domain
  
  CALL sadzi190_db_get_db_info() RETURNING lo_db_info.*
  CALL sadzi190_util_get_program_title('adzi190',ms_lang) RETURNING ls_program_title
  
  LET ls_zone = NVL(ls_zone,ls_user_domain)
  LET ls_user = NVL(ms_user,ls_user)

  LET ls_window_title = NVL(ls_program_title,cs_program_title)," [ Zone：",ls_zone," ] [ User：",ls_user," ] [DB Name：",lo_db_info.DB_NAME,"] [DB User：",lo_db_info.USER_NAME,"] [ Login Time：",CURRENT YEAR TO SECOND," ]"

  CALL FGL_SETTITLE(ls_window_title)

END FUNCTION

################################################################################
# Descriptions...: 從資料庫取得資料更新畫面主列表內容
# Memo...........: 將資料塞入 m_dzit_t_h_scr array
# Usage..........: CALL adzi190_fill_dzit_t_h()
# Input parameter: ms_search  搜尋關鍵字
# Return code....: none
# Date & Author..: 
# Modify.........: 20170104 by CircleLai
################################################################################
FUNCTION adzi190_fill_dzit_t_h()
  DEFINE 
  ls_sql         STRING,
  ls_sql_cond    STRING,
  ls_sql_db_name STRING,
  ls_str1        STRING,
  li_count       INTEGER
  DEFINE  ls_gzou003  LIKE gzou_t.gzou003  #ENT對應資料庫 #20170104 by circle
  
  #20170104 add by circle begin
  SELECT gzou003 INTO ls_gzou003 FROM gzou_t
    WHERE gzou001 = g_enterprise AND gzou002 = g_lang
  
  IF ls_gzou003 IS NULL THEN
    LET ls_gzou003 = "DSDEMO"
  END IF 
  #20170104 add by circle end
    
  IF (ms_db_name IS NOT NULL) THEN
    #IF (ms_db_name == cs_alias_aws_db OR ms_db_name == cs_alias_erp_db) THEN
      #顯示舊有資料
      #CALL sadzp310_util_decode_columns(ms_db_name) RETURNING ls_str1
      #LET ls_sql_db_name = " AND IT.DZIT003 in (", ls_str1, ", '", ms_db_name, "')"
    #ELSE 
      LET ls_sql_db_name = " AND IT.dzit003 = '",ms_db_name,"' "
    #END IF 
  ELSE
    LET ls_sql_db_name = " AND IT.dzit003 in ('", cs_alias_aws_db, "', '", cs_alias_erp_db, "') "
    #ver 160525.01 
  END IF 
  
  IF (ms_search IS NULL) OR (ms_search = "*") THEN
    LET ls_sql_cond = ""
  ELSE
    LET ls_sql_cond = " AND (IT.dzit001 LIKE '%",ms_search.toUpperCase(),"%' "
           , "  OR IT.dzit002 LIKE '%",ms_search,"%' "
           , "  OR IT.dzit003 LIKE '%",ms_search,"%' "
           , "  OR IT.dzit004 LIKE '%",ms_search,"%') "
  END IF 

  # 20170104 modify start
  LET ls_sql = ""
        , "SELECT DISTINCT '' record_type, '' seq_no, " , "\n"
        , "       IT.dzit001, IT.dzit002, IT.dzit003, IT.dzit004, IT.dzit009, " , "\n"
        , "       ITL.dzitl006, LM.dzlm008, LM.dzlm007, AG.ooag011, IT.dzit010 " , "\n"
        , "  FROM dzit_t IT " , "\n"
        , " INNER JOIN ( "  , "\n"
        #如同時存在標準與客制,只顯示客制 
        , "SELECT DISTINCT IT0.dzit001, IT0.dzit002, IT0.dzit003, MIN(IT0.dzit004) dzit004 " , "\n"
        , "  FROM dzit_t IT0 GROUP BY dzit001,dzit002,dzit003 " , "\n"
        , " ) IT2 ON IT.dzit001 = IT2.dzit001 AND IT.dzit002 = IT2.dzit002 " , "\n" 
        , "      AND IT.dzit003 = IT2.dzit003 AND IT.dzit004 = IT2.dzit004 " , "\n"
        #多語言
        , "  LEFT OUTER JOIN dzitl_t ITL ON ITL.dzitl001 = IT.dzit001 AND ITL.dzitl002 = IT.dzit002 " , "\n"
        , "                             AND ITL.dzitl003 = IT.dzit003 AND ITL.dzitl004 = IT.dzit004 " , "\n"
        , "                             AND ITL.dzitl005 = '",ms_lang,"' " , "\n"
        #簽出入訊息
        , "  LEFT OUTER JOIN dzlm_t LM ON LM.dzlm001 = '",cs_mdm_construct_type_trigger,"' " , "\n"
        , "                           AND LM.dzlm002 = IT.dzit002 " , "\n"
        , "                           AND LM.dzlm008 = '",cs_check_out,"' " , "\n"
        #簽出者訊息
        , "  LEFT OUTER JOIN ( " , "\n"
        , "                   SELECT XA.gzxa001,AG.ooag011 " , "\n"
        , "                     FROM ", ls_gzou003,".ooag_t AG, ", ls_gzou003, ".gzxa_t XA " , "\n"
        , "                    WHERE XA.gzxaent = AG.ooagent AND AG.ooag001 = XA.gzxa003 " , "\n"
        , "                      AND XA.gzxaent = '",ms_enterprise,"' " , "\n"
        , "                    GROUP BY XA.gzxa001,AG.ooag011 " , "\n"
        , "                    ORDER BY XA.gzxa001 " , "\n"
        , "                  ) AG ON AG.gzxa001 = LM.dzlm007 " , "\n"
        , " WHERE 1=1 AND IT.DZIT003 <> '",cs_template_words,"' " , "\n"
        , ls_sql_cond , "\n"
        , ls_sql_db_name , "\n"
        , " ORDER BY IT.dzit004,IT.dzit003,IT.dzit001,IT.dzit002  " , "\n"
  # DISPLAY ls_sql  # debug
  # 20170104 modify end
  
  PREPARE lpre_fill_dzit_t_h FROM ls_sql
  DECLARE lcur_fill_dzit_t_h CURSOR FOR lpre_fill_dzit_t_h

  CALL m_dzit_t_h_scr.clear()
  
  LET li_count = 1
  
  FOREACH lcur_fill_dzit_t_h INTO m_dzit_t_h_scr[li_count].*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    LET m_dzit_t_h_scr[li_count].DZITSEQ = li_count

    LET li_count = li_count + 1
  END FOREACH
  CALL m_dzit_t_h_scr.deleteElement(li_count)

END FUNCTION

FUNCTION adzi190_refresh_detail(p_dialog,p_dzit_t_h_scr)
DEFINE 
  p_dialog       ui.Dialog,
  p_dzit_t_h_scr T_DZIT_T_WL_H_SCR
DEFINE
  lo_dzit_t_h_scr T_DZIT_T_WL_H_SCR,
  ls_current_item STRING

  LET lo_dzit_t_h_scr.* = p_dzit_t_h_scr.*
  LET ls_current_item = p_dialog.getCurrentItem()
  
  INITIALIZE m_dzit_t_b_scr TO NULL
  LOCATE m_dzit_t_b_scr.DZIT008 IN FILE
  LOCATE m_dzit_t_b_scr.DZITCRT_BODY IN FILE
  CALL adzi190_fill_dzit_t_b(lo_dzit_t_h_scr.*) RETURNING m_dzit_t_b_scr.*

END FUNCTION

################################################################################
# Descriptions...: 從資料庫取得設計資料詳細內容
# Memo...........: 單身
# Usage..........: CALL adzi190_fill_dzit_t_b(p_dzit_t_h_scr) 
#                       RETURNING m_dzit_t_b_scr.*
# Input parameter: p_dzit_t_h_scr  單頭資料
# Return code....: m_dzit_t_b_scr  回傳單身資料
# Date & Author..: 
# Modify.........: 20170104 by CircleLai
# modify.........: 170210-00052#1 at 2017/02/13 by circlelai 新增dzit011的處理 
################################################################################
FUNCTION adzi190_fill_dzit_t_b(p_dzit_t_h_scr)
  DEFINE
    p_dzit_t_h_scr T_DZIT_T_WL_H_SCR
  DEFINE 
    lo_dzit_t_h_scr   T_DZIT_T_WL_H_SCR,
    lo_dzit_t_b_scr   T_DZIT_T_WL_B_SCR,
    lo_return         T_DZIT_T_WL_B_SCR,
    ls_sql            STRING
  DEFINE ls_gzou003  LIKE gzou_t.gzou003  #ENT對應資料庫 # 20170104 add by circle
  DEFINE li_rec_cnt  INTEGER 
  DEFINE ls_str      STRING  # 字串暫存 # 170210-00052#1 add
  DEFINE ls_substr   STRING  # 字串暫存 # 170210-00052#1 add
  DEFINE lo_strbuf   base.StringBuffer # 字串暫存buff # 170210-00052#1 add
  DEFINE li_idx      INTEGER # 索引變量暫存 # 170210-00052#1 add
  
  LET lo_dzit_t_h_scr.* = p_dzit_t_h_scr.*
  INITIALIZE lo_dzit_t_b_scr TO NULL 
  INITIALIZE lo_return TO NULL
  LET lo_strbuf = base.StringBuffer.create() 

  # 20170104 modify by circle begin
  SELECT gzou003 INTO ls_gzou003 FROM gzou_t
    WHERE gzou001 = g_enterprise AND gzou002 = g_lang
  
  IF ls_gzou003 IS NULL THEN
    LET ls_gzou003 = "DSDEMO"
  END IF
  
  LET ls_sql = ""
        , "SELECT IT.dzit001, IT.dzit002, IT.dzit003, IT.dzit004, IT.dzit005, " , "\n"
        , "       IT.dzit006, IT.dzit007, IT.dzit008, IT.dzit009, ITL.dzitl006, " , "\n"
        , "       ITL.dzitl007, IT.dzitcrtid, IT.dzitcrtdt, IT.dzitmodid, IT.dzitmoddt, " , "\n"
        , "       AG1.ooag011 dzitcrtiddesc, AG2.ooag011 dzitmodiddesc, '' SYNTAX, IT.dzit011 " , "\n"
        , "  FROM dzit_t IT " , "\n"
        , "  LEFT OUTER JOIN dzitl_t ITL " , "\n"
        , "    ON ITL.dzitl001 = IT.dzit001 AND ITL.dzitl002 = IT.dzit002 " , "\n"
        , "   AND ITL.dzitl003 = IT.dzit003 AND ITL.dzitl004 = IT.dzit004 " , "\n"
        , "   AND ITL.dzitl005 = '",ms_lang,"' " , "\n"
        # 取得異動資訊 資料建立者名稱
        , "  LEFT OUTER JOIN (SELECT ooag001,ooag011 FROM ", ls_gzou003, ".ooag_t " , "\n"
        , "                    WHERE ooagent = '",ms_enterprise,"') AG1" , "\n"
        , "    ON AG1.ooag001 = IT.dzitcrtid " , "\n"
        # 取得異動資訊 最近修改者名稱
        , "  LEFT OUTER JOIN (SELECT ooag001,ooag011 FROM ", ls_gzou003, ".ooag_t " , "\n"
        , "                    WHERE ooagent = '",ms_enterprise,"') AG2" , "\n"
        , "    ON AG2.ooag001 = IT.dzitmodid " , "\n"
        , " WHERE 1=1 " , "\n"
        , "   AND IT.dzit001 = '",lo_dzit_t_h_scr.DZIT001,"' " , "\n"
        , "   AND IT.dzit002 = '",lo_dzit_t_h_scr.DZIT002,"' " , "\n"
        , "   AND IT.dzit003 = '",lo_dzit_t_h_scr.DZIT003,"' " , "\n"
        , "   AND IT.dzit004 = '",lo_dzit_t_h_scr.DZIT004,"' " , "\n"
        , " ORDER BY IT.dzit004,IT.dzit003,IT.dzit001,IT.dzit002 " , "\n"
  # 20170104 modify by circle end 
  
  PREPARE lpre_fill_dzit_t_b FROM ls_sql
  DECLARE lcur_fill_dzit_t_b CURSOR FOR lpre_fill_dzit_t_b
  OPEN lcur_fill_dzit_t_b 
  LOCATE lo_dzit_t_b_scr.DZIT008 IN FILE
  LOCATE lo_dzit_t_b_scr.DZITCRT_BODY IN FILE
  
  FETCH lcur_fill_dzit_t_b INTO lo_dzit_t_b_scr.*

  CLOSE lpre_fill_dzit_t_b
  CLOSE lcur_fill_dzit_t_b

  # 170210-00052#1 begin 20170210 by circlelai
  # 限制 trigger script 的開頭語法
  IF (lo_dzit_t_b_scr.dzit002 IS NOT NULL) THEN 
    LET ls_str = adzi190_get_trg_head_contents(lo_dzit_t_b_scr.*)
    LET lo_dzit_t_b_scr.DZITCRT_SYNTAX = ls_str
  END IF 
  
  # 取得 trigger script body, DZITCRT_BODY (刪除 trigger 開頭語法)
  LET ls_substr = lo_dzit_t_b_scr.DZITCRT_BODY
  IF (ls_substr.getLength() > 0) THEN 
     CALL lo_strbuf.clear()
     CALL lo_strbuf.append(lo_dzit_t_b_scr.DZITCRT_BODY)
     CALL lo_strbuf.toUpperCase() 
     # 搜尋 trigger 開頭語法結束位置
     LET ls_substr = "FOR EACH ROW " , cs_new_line
     LET li_idx = lo_strbuf.getIndexOf(ls_substr.toUpperCase(), 1) 
     IF li_idx = 0 THEN # 找不到字串更變更搜尋
        LET ls_substr = "ON " , lo_dzit_t_b_scr.DZIT001 , " " , cs_new_line 
                      , "REFERENCING new as n old as o " , cs_new_line
        LET li_idx = lo_strbuf.getIndexOf(ls_substr.toUpperCase(), 1)
     END IF 
     # 取得觸發器腳本主體內容 DZITCRT_BODY
     IF li_idx > 0 THEN
        LET li_idx = li_idx + ls_substr.getLength()
        # 重載 DZIT011 (保留大小寫) 
        CALL lo_strbuf.clear()
        CALL lo_strbuf.append(lo_dzit_t_b_scr.DZITCRT_BODY)
        LET  lo_dzit_t_b_scr.DZITCRT_SYNTAX = lo_strbuf.subString(1, li_idx - 1)
        LET  lo_dzit_t_b_scr.DZITCRT_BODY = lo_strbuf.subString(li_idx, lo_strbuf.getLength())
     ELSE
        # 取得觸發器腳本主體內容失敗
        DISPLAY cs_warning_tag, "Failed to get trigger script body contents"
     END IF 
  END IF 
  # 170210-00052#1 end 20170210 by circlelai 
  
  # 20170104 add begin
  &ifndef DEBUG
  IF (lo_dzit_t_b_scr.DZITCRTID_DESC IS NULL) THEN
    LET  lo_dzit_t_b_scr.DZITCRTID_DESC = cl_get_username(lo_dzit_t_b_scr.DZITCRTID)  
  END IF 
  IF (lo_dzit_t_b_scr.DZITMODID_DESC IS NULL) THEN
    LET  lo_dzit_t_b_scr.DZITMODID_DESC = cl_get_username(lo_dzit_t_b_scr.DZITMODID) 
  END IF 
  &endif
  # 20170104 add end
  
  LET lo_return.* = lo_dzit_t_b_scr.*
  RETURN lo_return.*
END FUNCTION

FUNCTION adzi190_refresh_master(p_dialog)
DEFINE 
  p_dialog      ui.Dialog
DEFINE
  lo_combobox    ui.ComboBox,
  ls_module_name STRING

  INITIALIZE m_dzit_t_h_scr TO NULL
  INITIALIZE m_dzit_t_b_scr TO NULL

  LET lo_combobox = ui.ComboBox.forName("formonly.cb_moduleselect")

  CALL adzi190_fill_dzit_t_h()
  
  CALL adzi190_set_check_out_mode(p_dialog, m_dzit_t_h_scr[mi_dzit_h_index].*)
  
  CALL adzi190_refresh_detail(p_dialog,m_dzit_t_h_scr[mi_dzit_h_index].*)
  
END FUNCTION

################################################################################
# Descriptions...: 新增或修改觸發器-控制介面
# Memo...........: 
# Usage..........: CALL adzi190_alter_trigger(m_dzit_t_b_scr.*,FALSE) RETURNING lb_result,lo_dzit_t.*
# Input parameter: p_dzit_t_b_scr  觸發器資料
#                : p_is_template   是否是樣板,
# Return code....: lb_return  確定=true, 放棄=false
#                : lo_return  觸發器資料
# Date & Author..: 
# Modify.........: 20160401 by CircleLai
# @modify 170210-00052#1 at 2017/02/14 by circlelai 新增 dzit011 處理
################################################################################
FUNCTION adzi190_alter_trigger(p_dzit_t_b_scr,p_is_template)
  DEFINE
    p_dzit_t_b_scr T_DZIT_T_WL_B_SCR,
    p_is_template  BOOLEAN 
  DEFINE
    lo_dzit_t_b_scr T_DZIT_T_WL_B_SCR,
    lo_dzit_t       T_DZIT_T_WL,
    lo_left_array   DYNAMIC ARRAY OF T_COLUMN_LIST,
    lo_right_array  DYNAMIC ARRAY OF T_COLUMN_LIST,
    lo_jsonobj      util.JSONObject,
    lb_is_template  BOOLEAN,
    lb_modify_mode  BOOLEAN,
    lb_result       BOOLEAN,
    ls_owners_queue STRING,
    ls_msg          STRING,
    ls_table_name   STRING,
    ls_datas        STRING,
    ls_datas_queue  STRING,
    ls_replace_arg  STRING
  DEFINE ls_str     STRING # 字串處理暫存 # 170210-00052#1 add 
  DEFINE
    lb_return  BOOLEAN,
    lo_return  T_DZIT_T_WL

  LET lb_is_template = p_is_template
  
  INITIALIZE lo_dzit_t_b_scr TO NULL
  LOCATE lo_dzit_t_b_scr.DZIT008 IN FILE
  LOCATE lo_dzit_t_b_scr.DZITCRT_BODY IN FILE
  LET lb_result = TRUE
  
  DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM) #欄位順序 --add at 20160126 by DGW07558
    INPUT lo_dzit_t_b_scr.* FROM sr_trigger_data.* ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE INPUT
        # 修改模式下需要將PK欄位設為不可使用
        LET lb_modify_mode = IIF(((ms_alter_type == cs_modify_trigger) 
              OR (ms_alter_type == cs_modify_template)),FALSE,TRUE)
        CALL DIALOG.setFieldActive("ed_dzit001",lb_modify_mode)
        CALL DIALOG.setFieldActive("ed_dzit002",lb_modify_mode)
        CALL DIALOG.setFieldActive("ed_dzit003",lb_modify_mode)
        
        # 修改模式下將修改資料儲存到 lo_dzit_t_b_scr
        IF ms_alter_type == cs_modify_trigger THEN 
          LET lo_dzit_t_b_scr.* = p_dzit_t_b_scr.*
        END IF
        
      AFTER FIELD ed_dzit001  #表格名稱
        IF (ms_alter_type == cs_create_trigger) THEN
          #輸入表格名稱後,自動帶出欲建構資料庫值； --add at 20160129 by DGW07558
          LET ls_datas = "" #避免殘留資料造成判斷錯誤
          LET ls_table_name = lo_dzit_t_b_scr.DZIT001
          CALL sadzi190_util_get_pre_const_db(ls_table_name) RETURNING lo_jsonobj
          IF (lo_jsonobj.has("not_found")) THEN 
            CALL DIALOG.setFieldActive("ed_dzit003", FALSE)
            #show error message 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = "adz-00754"  # 表格不存在,找不到對應的資料庫
            LET g_errparam.extend = NULL 
            LET g_errparam.popup  = TRUE
            LET g_errparam.sqlerr = 0
            CALL cl_err()
            
            NEXT FIELD ed_dzit001 
          ELSE 
            #表格名稱同時存在ERPDB與AWSDB,提供使用者選擇
            IF (lo_jsonobj.has("multi_db")) THEN 
              CALL DIALOG.setFieldActive("ed_dzit003", TRUE)
              NEXT FIELD ed_dzit003
            ELSE 
              CALL DIALOG.setFieldActive("ed_dzit003", FALSE)
            END IF

            CALL adzi190_anal_tbl_name(ls_table_name) RETURNING lb_result, ls_datas
            IF (lb_result AND lo_dzit_t_b_scr.DZIT002 IS NULL) THEN
              IF (ms_DGENV == cs_dgenv_standard) THEN 
                LET lo_dzit_t_b_scr.DZIT002 = ls_datas, "_trg"    #標準
              ELSE 
                LET lo_dzit_t_b_scr.DZIT002 = ls_datas, "uc_trg"  #客制
              END IF
            END IF
            
            LET ls_datas = IIF (lo_jsonobj.has("const_db"), lo_jsonobj.get("const_db"), "") 
          END IF 
          LET lo_dzit_t_b_scr.DZIT003 = ls_datas
        END IF 

      # 170210-00052#1 at by circlelai begin
      # 觸發器開頭語法變更 
      ON CHANGE ed_dzit001
         LET ls_str = adzi190_get_trg_head_contents(lo_dzit_t_b_scr.*)
         LET lo_dzit_t_b_scr.DZITCRT_SYNTAX = ls_str
      ON CHANGE ed_dzit002
         LET ls_str = adzi190_get_trg_head_contents(lo_dzit_t_b_scr.*)
         LET lo_dzit_t_b_scr.DZITCRT_SYNTAX = ls_str
      ON CHANGE ed_dzit005
         LET ls_str = adzi190_get_trg_head_contents(lo_dzit_t_b_scr.*)
         LET lo_dzit_t_b_scr.DZITCRT_SYNTAX = ls_str
      ON CHANGE ed_dzit006
         LET ls_str = adzi190_get_trg_head_contents(lo_dzit_t_b_scr.*)
         LET lo_dzit_t_b_scr.DZITCRT_SYNTAX = ls_str
      ON CHANGE ed_dzit007
         LET ls_str = adzi190_get_trg_head_contents(lo_dzit_t_b_scr.*)
         LET lo_dzit_t_b_scr.DZITCRT_SYNTAX = ls_str
      
      # 170210-00052#1 at by circlelai end
         
      #觸發事件  
      ON ACTION btn_dzit006  
        LET ls_datas = lo_dzit_t_b_scr.DZIT006
        CALL sadzi190_dtas_decode_columns(ls_datas) RETURNING ls_datas_queue
        CALL sadzi190_util_get_trigger_event_list(ls_datas_queue,cs_side_left) RETURNING lo_left_array
        CALL sadzi190_util_get_trigger_event_list(ls_datas_queue,cs_side_right) RETURNING lo_right_array
        CALL sadzi190_dtas_run(lo_left_array,lo_right_array) RETURNING ls_datas
        IF NVL(ls_datas,cs_null_value) <> cs_result_cancel THEN
          LET lo_dzit_t_b_scr.DZIT006 = ls_datas
        END IF
      
      ON ACTION btn_regen_script #重產觸法器script
        CALL adzi190_prepare_dzit_t_data(lo_dzit_t_b_scr.*) RETURNING lo_dzit_t.*
        CALL sadzi190_db_gen_trigger_scripts(lo_dzit_t.*) RETURNING lo_dzit_t.*
        LET lo_dzit_t_b_scr.DZIT008 = lo_dzit_t.DZIT008
      
    END INPUT

    BEFORE DIALOG
      CALL mo_form.setElementHidden("vbox_trigger_list",TRUE)
      CALL mo_form.setElementHidden("formonly.lbl_check_out_full_name",TRUE)
      CALL mo_form.setElementHidden("lbl_tools",TRUE)
      CALL mo_form.setElementHidden("formonly.cbo_exe",TRUE)
      CALL mo_form.setElementHidden("btn_exe_act",TRUE)
      
      IF lb_is_template THEN
        CALL adzi190_prepare_dzit_t_data(p_dzit_t_b_scr.*) RETURNING lo_dzit_t.*
        CALL sadzi190_db_load_template_data(lo_dzit_t.*,ms_lang) RETURNING lo_dzit_t.*
        CALL adzi190_refresh_dzit_t_scr_data(lo_dzit_t.*) RETURNING lo_dzit_t_b_scr.*
        NEXT FIELD ed_dzit008
      END IF

    ON ACTION ACCEPT #確定
      CALL adzi190_prepare_dzit_t_data(lo_dzit_t_b_scr.*) RETURNING lo_dzit_t.* 

      # 檢查欄位'預建構資料庫'是否有輸入
      IF lo_dzit_t.DZIT003 IS NULL THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00732" # 預建構資料庫未輸入
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
        CALL cl_err()  
        NEXT FIELD ed_dzit003
      END IF 

      #新增行為,檢查觸發器ID 是否正確
      IF (ms_alter_type == cs_create_trigger) THEN 
        IF (adzi190_chk_trigerid_iserr(lo_dzit_t.*)) THEN
          NEXT FIELD ed_dzit002 
        END IF
      END IF 

      # 檢查 AWSDB 的 Trigger 不能有對 ERPDB 更新或刪除的行為
      IF sadzi190_crud_verify_if_with_exclude_words(lo_dzit_t.*) THEN 
        # AWSDB(中台資料庫)不能透過trigger新增或者刪除資料
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00780" #中台資料庫觸發器內容 BEGIN 區段後不能有 DELETE 或 UPDATE 保留字
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
        CALL cl_err()
        #CALL sadzi190_msg_message_box("Error","dialog","???","stop")
        NEXT FIELD ed_dzit008
      ELSE
        CALL sadzi190_crud_set_trigger_data(lo_dzit_t.*, ms_alter_type, ms_lang,ms_dgenv) 
             RETURNING lb_result  #儲存設計資料
        IF NOT lb_is_template THEN #不是樣版,調整trigger狀態
          #新增或修改trigger後,尚未執行建構前,trigger 狀態設置為'未建立'
          LET lo_dzit_t.DZIT009 = "N" --未建立
          CALL sadzi190_crud_set_trigger_status(lo_dzit_t.*) RETURNING lb_result
          #停用相對應trigger
          CALL sadzi190_dtas_decode_columns(lo_dzit_t.DZIT003) RETURNING ls_owners_queue
          LET  lo_jsonobj = util.JSONObject.create()
          CALL lo_jsonobj.put("owners_queue", ls_owners_queue) 
          CALL lo_jsonobj.put("switch_val", "DISABLE") --停用trigger
          CALL sadzi190_util_switch_trigger(lo_dzit_t.*, lo_jsonobj) RETURNING lb_result,ls_msg
          #執行建構
          CALL adzi190_tbi_build_trigger(DIALOG, lo_dzit_t.*, NULL) RETURNING lb_result
        END IF
        
      END IF  
      LET lb_result = TRUE 
      LET lo_return.* = lo_dzit_t.*
      EXIT DIALOG
      
    ON ACTION CANCEL  
      LET lb_result = FALSE
      EXIT DIALOG 
    
  END DIALOG  

  LET lb_return = lb_result
  CALL mo_form.setElementHidden("vbox_trigger_list",FALSE)
  CALL mo_form.setElementHidden("formonly.lbl_check_out_full_name",FALSE)
  CALL mo_form.setElementHidden("lbl_tools",FALSE)
  CALL mo_form.setElementHidden("formonly.cbo_exe",FALSE)
  CALL mo_form.setElementHidden("btn_exe_act",FALSE)
  
  RETURN lb_return,lo_return.*

END FUNCTION

FUNCTION adzi190_prepare_dzit_t_data(p_dzit_t_scr)
DEFINE
  p_dzit_t_scr T_DZIT_T_WL_B_SCR
DEFINE
  lo_dzit_t T_DZIT_T_WL

DEFINE lo_str_buf  base.StringBuffer   # 170210-00052#1 add by circlelai
DEFINE ls_dzit011  STRING           # 170210-00052#1 add by circlelai
DEFINE ls_syntax   STRING

  # 170210-00052#1 add by circlelai begin
  # 新版 trigger script 
  LET lo_str_buf = base.StringBuffer.create()
  
  # check 是否空字串
  LET ls_dzit011 = sadzi190_util_trim_str(p_dzit_t_scr.DZITCRT_BODY)
  IF (ls_dzit011.getLength() > 0 ) THEN 
     LET ls_dzit011 = p_dzit_t_scr.DZITCRT_BODY
     CALL lo_str_buf.append(p_dzit_t_scr.DZITCRT_SYNTAX)
     CALL lo_str_buf.append(ls_dzit011)
     LET ls_dzit011 = lo_str_buf.toString()
  END IF 

  LOCATE lo_dzit_t.DZIT011 IN FILE
  # 170210-00052#1 add by circlelai end 
  
  LET lo_dzit_t.DZIT001 = p_dzit_t_scr.DZIT001
  LET lo_dzit_t.DZIT002 = p_dzit_t_scr.DZIT002
  LET lo_dzit_t.DZIT003 = p_dzit_t_scr.DZIT003
  LET lo_dzit_t.DZIT004 = NVL(p_dzit_t_scr.DZIT004,ms_DGENV)
  LET lo_dzit_t.DZIT005 = p_dzit_t_scr.DZIT005
  LET lo_dzit_t.DZIT006 = p_dzit_t_scr.DZIT006
  LET lo_dzit_t.DZIT007 = p_dzit_t_scr.DZIT007
  LET lo_dzit_t.DZIT008 = p_dzit_t_scr.DZIT008
  LET lo_dzit_t.DZIT009 = NVL(p_dzit_t_scr.DZIT009,"N")
  LET lo_dzit_t.DZIT011 = ls_dzit011  # 170210-00052#1 add
  LET lo_dzit_t.DZITL006 = p_dzit_t_scr.DZITL006
  LET lo_dzit_t.DZITL007 = p_dzit_t_scr.DZITL007  
  
  RETURN lo_dzit_t.*
  
END FUNCTION 

# @desc. 用於樣板功能中,目前樣板功能已經不使用,考慮刪除
FUNCTION adzi190_refresh_dzit_t_scr_data(p_dzit_t)
DEFINE
  p_dzit_t T_DZIT_T_WL
DEFINE
  lo_dzit_t_scr T_DZIT_T_WL_B_SCR

  LET lo_dzit_t_scr.DZIT001  = p_dzit_t.DZIT001 
  LET lo_dzit_t_scr.DZIT002  = p_dzit_t.DZIT002 
  LET lo_dzit_t_scr.DZIT003  = p_dzit_t.DZIT003 
  LET lo_dzit_t_scr.DZIT004  = p_dzit_t.DZIT004 
  LET lo_dzit_t_scr.DZIT005  = p_dzit_t.DZIT005 
  LET lo_dzit_t_scr.DZIT006  = p_dzit_t.DZIT006 
  LET lo_dzit_t_scr.DZIT007  = p_dzit_t.DZIT007 
  LET lo_dzit_t_scr.DZIT008  = p_dzit_t.DZIT008 
  LET lo_dzit_t_scr.DZIT009  = p_dzit_t.DZIT009
  LET lo_dzit_t_scr.DZITL006 = p_dzit_t.DZITL006
  LET lo_dzit_t_scr.DZITL007 = p_dzit_t.DZITL007  

  RETURN lo_dzit_t_scr.*
  
END FUNCTION 

FUNCTION adzi190_fill_combobox(p_combobox,p_sql)
DEFINE 
  p_combobox ui.combobox,
  p_sql      STRING
DEFINE
  ls_sql      STRING,
  li_index    INTEGER,
  li_count    INTEGER, 
  lo_combobox RECORD 
                combobox_name VARCHAR(50),
                combobox_desc VARCHAR(255)
              END RECORD  
  
  LET li_index = 0
  LET ls_sql = p_sql
  
  PREPARE lpre_combobox FROM ls_sql
  DECLARE lcur_combobox SCROLL CURSOR FOR lpre_combobox

  CALL p_combobox.clear()
  
  LET li_count = 1

  FOREACH lcur_combobox INTO lo_combobox.*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    CALL p_combobox.addItem(lo_combobox.combobox_name,lo_combobox.combobox_desc)
    LET li_count = li_count + 1
  END FOREACH

  FREE lcur_combobox
  FREE lpre_combobox

END FUNCTION

################################################################################
# Descriptions...: 使用者介面控管
# Memo...........: 規則記錄： 
#                    1.TOPCHKOUT = N ,不能執行簽出及簽入行為.
#                    2.使用者 = topstd,不能執行簽出及簽入行為.
#                    3.TOPALM = Y,只可簽出不能簽入,此時簽入行為交由型管系統控制.
#                    4.DGENV = s,標準環境,可以執行簽出及簽入行為
#                    5.DGENV = c, 客戶家,針對標準表不能簽出及簽入,請執行標準轉客制
#                    6.表格已簽出(dzlm008='O')且目前使用者是簽出者本人(DZLM007),才能夠執行表格異動行為(更改、執行建構、刪除、簽出).
#                    7.出貨標識(dzit010)旗標如果為'Y', 則不能執行刪除的功能.
#                    8.釋出功能使用限制標準環境下簽出者本人才能夠操作(TOPCHKOUT=Y,TOPALM=Y,簽出者本人)
# Usage..........: CALL adzi190_set_active_state(DIALOG,mi_dzit_h_index)
# Input parameter: p_dialog         ui.Dialog
#                : mi_dzit_h_index  索引值
# Return code....: none
# Date & Author..: 
# Modify.........: 20151230,20170103 by CircleLai
# @modify  170210-00052#1 2017/02/18 by circlelai # 新增tm_buildall 控管機制 #上帝模式功能
################################################################################
FUNCTION adzi190_set_active_state(p_dialog, p_index)
  DEFINE
    p_dialog    ui.Dialog,
    p_index     INTEGER
  DEFINE
    ls_alm_state    STRING,
    ls_chkout_user  STRING,   # Trigger 簽出者
    lb_topstd       BOOLEAN,  # topstd 特殊帳號控管不能操作帳號
    lb_chkout_user  BOOLEAN,  # 簽出者是否現在的使用者
    lb_active       BOOLEAN   # 是否被簽出 
  DEFINE lb_godmod  BOOLEAN   #上帝模式，開啟所有權限 # 170210-00052#1 add
  
  # init. local parameter
  LET lb_chkout_user = TRUE #default value
  LET lb_godmod = mb_debug
  
  # 取得簽出入狀態, 簽出者
  LET ls_alm_state    = m_dzit_t_h_scr[p_index].DZLM008
  LET ls_chkout_user  = m_dzit_t_h_scr[p_index].DZLM007
  # 
  LET lb_active = IIF(NVL(ls_alm_state,"X")=="O",TRUE,FALSE)
  
  # 檢查簽出者是否目前使用者本人
  IF (lb_active) AND (ls_chkout_user IS NOT NULL) 
    AND (NVL(ls_chkout_user,cs_null_value) <> ms_user)  THEN 
    LET lb_chkout_user  = FALSE 
  END IF
  
  #控管 topstd 特殊帳號
  IF (ms_user = cs_topstd_user_name) THEN
    LET lb_topstd = TRUE 
  ELSE 
    LET lb_topstd = FALSE 
  END IF 

  #簽出簽入按鍵,先還原成default狀態
  CALL p_dialog.setActionActive("btn_check_out", FALSE) 
  CALL p_dialog.setActionActive("btn_check_in", FALSE) 
  CALL p_dialog.setActionActive("btn_recall", FALSE)
  
  #操作行為還原成預設值不使用狀態
  CALL p_dialog.setActionActive("tbi_create_trigger", FALSE)    # 新增trigger
  CALL p_dialog.setActionActive("tbi_drop_trigger", FALSE)      # 刪除trigger 
  CALL p_dialog.setActionActive("tbi_build_trigger", FALSE)     # 執行建構
  CALL p_dialog.setActionActive("tbi_switch_trigger", FALSE)    # 開關trigger
  CALL p_dialog.setActionActive("modify", FALSE)                # 修改trigger
  #CALL p_dialog.setActionActive("accept", FALSE)               # 確定
  #CALL p_dialog.setActionActive("cancel", FALSE)               # 取消
  CALL p_dialog.setActionActive("btn_exe_act", FALSE)           # 標準、客制轉換

  # 20170103 add start
  # 檢查(標準客制轉換功能)是否可用
  IF ms_dgenv = cs_dgenv_customize THEN # 顯示功能鍵
    CALL mo_form.setElementHidden("grid_cust_std_transfer",FALSE) 
  ELSE # 隱藏功能鍵
    CALL mo_form.setElementHidden("grid_cust_std_transfer",TRUE)  
  END IF 
  
  # 隱藏 (簽入功能)鍵
  CALL mo_form.setElementHidden("btn_check_in",TRUE)
  
  # 釋出功能
  CALL p_dialog.setActionActive("btn_release", FALSE) # 停用 (釋出功能)
  CALL mo_form.setElementHidden("btn_release", TRUE)  # 隱藏 (釋出功能) 鍵
  # 20170103 add end 

  CALL p_dialog.setActionActive("tm_buildall", FALSE) # 停用 (建構所有設計資料) --170210-00052#1
  
  CASE
    WHEN lb_godmod # 上帝模式 -- 170210-00052#1 2017/02/18 add by circlelai
      CALL p_dialog.setActionActive("btn_check_out", TRUE)
      CALL p_dialog.setActionActive("btn_check_in", TRUE) 
      CALL p_dialog.setActionActive("btn_recall", TRUE)
      CALL p_dialog.setActionActive("tbi_create_trigger", TRUE )    # 新增trigger
      CALL p_dialog.setActionActive("tbi_drop_trigger", TRUE )      # 刪除trigger 
      CALL p_dialog.setActionActive("tbi_build_trigger", TRUE )     # 執行建構
      CALL p_dialog.setActionActive("tbi_switch_trigger", TRUE )    # 開關trigger
      CALL p_dialog.setActionActive("modify", TRUE )                # 修改trigger
      CALL p_dialog.setActionActive("btn_exe_act", TRUE )           # 標準、客制轉換
      CALL mo_form.setElementHidden("grid_cust_std_transfer", FALSE ) # show 標準、客制轉換
      CALL mo_form.setElementHidden("btn_check_in", FALSE ) # 簽入功能
      CALL p_dialog.setActionActive("btn_release", TRUE )   # 釋出功能
      CALL mo_form.setElementHidden("btn_release", FALSE )  # show 釋出功能
      CALL p_dialog.setActionActive("tm_buildall", TRUE)    # 批次建構所有物件
      
    WHEN (NOT mb_enb_chkout) OR (lb_topstd) #禁用簽出入功能;
      #do nothing
    WHEN (mb_enb_chkout) AND (mb_enable_alm)  #TOPCHKOUT=Y,TOPALM=Y
      
      IF (ms_dgenv = cs_dgenv_standard) THEN # 標準環境(產中)下才可執行簽出入
        CALL mo_form.setElementHidden("btn_release", NOT lb_active) # 簽出則顯示(釋出功能) # 20170103
        CALL p_dialog.setActionActive("btn_check_out", NOT lb_active)
      ELSE 
        IF (m_dzit_t_h_scr[p_index].DZIT004 = cs_dgenv_standard) THEN
           # 客戶家標準Trigger,不能夠簽出入
        ELSE 
           CALL p_dialog.setActionActive("btn_check_out", NOT lb_active)
        END IF 
      END IF 
      
      CALL p_dialog.setActionActive("btn_check_in", FALSE ) #簽入行為交由型管處理;

      CALL p_dialog.setActionActive("tbi_create_trigger", TRUE)
      IF (lb_active) AND (lb_chkout_user) THEN  #簽出者本人才能夠異動
        IF (m_dzit_t_h_scr[p_index].DZIT010 == "Y") THEN #已出貨設計資料不能刪除
          #do nothing
        ELSE 
          CALL p_dialog.setActionActive("tbi_drop_trigger", lb_chkout_user)  
        END IF 
        CALL p_dialog.setActionActive("tbi_build_trigger", lb_chkout_user)
        CALL p_dialog.setActionActive("tbi_switch_trigger", lb_chkout_user)
        CALL p_dialog.setActionActive("modify", lb_chkout_user)
        CALL p_dialog.setActionActive("btn_release", lb_chkout_user) # 20170103
      END IF 
      #客戶家才能執行標準與客制之間的轉換
      IF ms_dgenv = cs_dgenv_customize THEN
        CALL p_dialog.setActionActive("btn_exe_act", TRUE)
      END IF
      
    WHEN (mb_enb_chkout) AND (NOT mb_enable_alm)  #沒有型管
      CALL mo_form.setElementHidden("btn_check_in", FALSE) # 顯示(簽入功能)鍵
      IF (ms_dgenv = cs_dgenv_standard) THEN #標準環境才可能執行簽出入
        IF (lb_chkout_user) THEN #控管簽出者才能夠做簽入行為
          CALL p_dialog.setActionActive("btn_check_out", NOT lb_active)
          CALL p_dialog.setActionActive("btn_check_in", lb_active )
        END IF
      ELSE 
        IF (m_dzit_t_h_scr[p_index].DZIT004 == cs_dgenv_standard) THEN
          #客戶家標準Trigger,不能夠簽出入
        ELSE 
          IF (lb_chkout_user) THEN #控管簽出者才能夠做簽入行為
            CALL p_dialog.setActionActive("btn_check_out", NOT lb_active)
            CALL p_dialog.setActionActive("btn_check_in", lb_active )
          END IF 
        END IF 
      END IF 
      
      CALL p_dialog.setActionActive("tbi_create_trigger", TRUE )
      IF (lb_active) AND (lb_chkout_user) THEN  #簽出者本人才能夠異動
        IF ( ms_dgenv = cs_dgenv_customize  
            AND m_dzit_t_h_scr[p_index].DZIT004 = cs_dgenv_standard ) THEN
          #客戶家標準不能夠異動
        ELSE
          IF (m_dzit_t_h_scr[p_index].DZIT010 == "Y") THEN #已出貨設計資料不能刪除
            #do nothing
          ELSE 
            CALL p_dialog.setActionActive("tbi_drop_trigger", lb_chkout_user)  
          END IF
          CALL p_dialog.setActionActive("tbi_build_trigger", lb_chkout_user)
          CALL p_dialog.setActionActive("tbi_switch_trigger", lb_chkout_user)
          CALL p_dialog.setActionActive("modify", lb_chkout_user)
        END IF 
      END IF 
      
      #客戶家才能執行標準與客制之間的轉換
      IF ms_dgenv = cs_dgenv_customize THEN
        CALL p_dialog.setActionActive("btn_exe_act", TRUE)
      END IF
      
    OTHERWISE
      DISPLAY "Error: Exception on adzi190_set_active_state(..)"
  END CASE 
  
END FUNCTION

FUNCTION adzi190_gen_log_file(p_log)
DEFINE
  p_log      STRING
DEFINE
  ls_log            STRING,
  ls_file           STRING,
  ls_tmp            STRING,
  l_channel         base.Channel

  LET ls_file = "adzi190-", TODAY USING 'YYYYMMDD', ".log"
  LET ls_file = os.Path.join(FGL_GETENV("TEMPDIR"), ls_file)
  LET l_channel = base.Channel.create()
  CALL l_channel.openFile(ls_file, "a")
  
  IF STATUS = 0 THEN
    CALL l_channel.setDelimiter("")
    LET ls_tmp = "#--------------------------- (", CURRENT YEAR TO SECOND, ") ------------------------#"
    CALL l_channel.write(ls_tmp)

    LET ls_tmp = "Operator : ", ms_user
    CALL l_channel.write(ls_tmp)
    
    LET ls_tmp = p_log
    CALL l_channel.write(ls_tmp)
    
    LET ls_tmp = "#--------------------------------------------------------------------------#"
    CALL l_channel.write(ls_tmp)
    CALL l_channel.close()
  ELSE 
    DISPLAY "Can't open log file."
  END IF 
  
END FUNCTION 

#顯示目前簽出入狀態  --DGW07558_add_at20151230
FUNCTION adzi190_set_check_out_mode(p_dialog,p_dzit_t_hscr)
DEFINE
  p_dialog        ui.dialog,
  p_dzit_t_hscr   T_DZIT_T_WL_H_SCR
DEFINE 
  ls_check_out_full_name  STRING,
  ls_mode_msg             STRING,
  lo_dzit_t_hscr          T_DZIT_T_WL_H_SCR

  LET lo_dzit_t_hscr.* = p_dzit_t_hscr.*
  
  CASE 
    WHEN NVL(lo_dzit_t_hscr.dzlm008,cs_null_value) <> cs_check_out
      CALL sadzp000_msg_get_message('adz-00365',ms_lang) RETURNING ls_mode_msg
      LET ls_check_out_full_name = "[ ",ls_mode_msg," ]"   #[未簽出]
    WHEN NVL(lo_dzit_t_hscr.dzlm008,cs_null_value) = cs_check_out
      CALL sadzp000_msg_get_message('adz-00367',ms_lang) RETURNING ls_mode_msg
      LET ls_check_out_full_name = "[ ",ls_mode_msg,"：",
              lo_dzit_t_hscr.dzlm007,"-",
              lo_dzit_t_hscr.ooag011," ]"   #[簽出者：使用者帳號-使用者全名]
  END CASE
  
  DISPLAY ls_check_out_full_name TO formonly.lbl_check_out_full_name
  
END FUNCTION 

#標準轉客制
FUNCTION adzi190_std_to_cust(p_dialog)
  DEFINE
    p_dialog        ui.dialog
  DEFINE 
    lo_user_info      T_USER_INFO, -- 使用者資訊物件
    lo_DZLU_T         DYNAMIC ARRAY OF T_DZLU_T,
    lo_dzit_t_b_scr   T_DZIT_T_WL_B_SCR,
    lo_dzit_t         T_DZIT_T_WL,
    lo_dzlm_t         T_DZLM_T,
    lo_jsonobj        util.JSONObject,
    lb_return         BOOLEAN,
    lb_result         BOOLEAN,
    ls_table_name     STRING,
    ls_replace_arg    STRING

  LET ms_alter_type = cs_type_std_to_cust  #標準轉客制
  LET lb_return = TRUE
  LET ls_table_name = m_dzit_t_h_scr[mi_dzit_h_index].DZIT001
  #檢查
  #數據庫或表格不存在
  IF ls_table_name IS NULL THEN
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "-6001" # 數據庫或表格不存在
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
    CALL cl_err()
    LET lb_return = FALSE 
    RETURN lb_return
  END IF
  #標準表格才能轉客制
  IF m_dzit_t_h_scr[mi_dzit_h_index].DZIT004 = cs_dgenv_standard THEN
    #do nothing 
  ELSE 
    #已經是客製表
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00755" # 已經是客製表
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
    CALL cl_err()
    LET lb_return = FALSE 
    RETURN lb_return
  END IF 

  #客製開發環境下,才可執行此功能
  IF (ms_dgenv = cs_dgenv_customize) THEN
    #do nothing
  ELSE
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00599" #客製開發環境下,才可執行此功能！
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
    CALL cl_err()
    LET lb_return = FALSE 
    RETURN lb_return
  END IF 

  #複製標準資料
  INITIALIZE lo_dzit_t_b_scr TO NULL
  LOCATE lo_dzit_t_b_scr.DZIT008 IN FILE
  CALL adzi190_fill_dzit_t_b(m_dzit_t_h_scr[mi_dzit_h_index].*) RETURNING lo_dzit_t_b_scr.*
  CALL adzi190_prepare_dzit_t_data(lo_dzit_t_b_scr.*) RETURNING lo_dzit_t.*
  LET lo_dzit_t.DZIT004 = cs_dgenv_customize  #變更客制旗標'c'

  #檢查觸發器id是否已存在客制資料
  IF (sadzi190_crud_check_if_dzit_t_exists(lo_dzit_t.*)) THEN  
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00756" #客制資料已存在
    LET g_errparam.extend = lo_dzit_t.DZIT002
    LET g_errparam.popup  = TRUE  #訊息開窗顯示 
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
    CALL cl_err()
    LET lb_return = FALSE 
    RETURN lb_return
  END IF
  
  #ALM begin 
  CALL sadzi190_util_alm_check_out(mb_enable_alm,ms_user,ms_lang,cs_user_role_sd,FALSE) 
    RETURNING lb_result,lo_USER_INFO.*,lo_DZLU_T
  #ALM end
  IF (lb_result) THEN 
    #新增到資料庫
    CALL sadzi190_crud_set_trigger_data(lo_dzit_t.*, ms_alter_type, ms_lang, ms_dgenv) RETURNING lb_result
    IF (lb_result) THEN 
      #完成標準轉客制,實際寫入註冊資料 DZLM_T 
      #ALM begin
      CALL sadzi190_util_set_alm_info(lo_dzit_t.DZIT002, cs_mdm_module_name, 
                                      lo_dzit_t.DZITL006, cs_mdm_construct_type_trigger,
                                      cs_ver_type_sd,lo_DZLU_T) 
           RETURNING lb_result,lo_dzlm_t.*
      IF NOT lb_result THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00726"  #"寫入ALM資訊失敗"
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        #LET g_errparam.replace[1] = "寫入ALM資訊失敗"
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
        CALL cl_err()
      ELSE 
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00757" #標準轉客制成功
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示 
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
        CALL cl_err()
      END IF
      #ALM end 
      #更新頁面
      CALL adzi190_refresh_master(p_dialog)
      CALL adzi190_set_active_state(p_dialog, mi_dzit_h_index)
    ELSE 
      LET lb_return = FALSE 
      #儲存到資料庫時出現錯誤
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = "adz-00758" #標準轉客制出現錯誤
      LET g_errparam.extend = NULL
      LET g_errparam.popup  = TRUE  #訊息開窗顯示 
      LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
      CALL cl_err() 
    END IF
  ELSE 
    #無法正確被簽出
    LET lb_return = FALSE
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00759" #簽出失敗
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示 
    LET g_errparam.sqlerr = 0
    CALL cl_err()
  END IF 

  
  RETURN lb_return 
END FUNCTION 

#客制還原標準
FUNCTION adzi190_cust_to_std(p_dialog)
  DEFINE
    p_dialog    ui.dialog
  DEFINE 
    lo_dzit_t       T_DZIT_T_WL,
    lo_dzit_t2      T_DZIT_T_WL,
    lo_dzit_t_h_scr T_DZIT_T_WL_H_SCR,
    lo_dzit_t_b_scr T_DZIT_T_WL_B_SCR,
    lo_jsonobj      util.JSONObject,
    lb_active       BOOLEAN,  #資料是否被簽出
    lb_result       BOOLEAN,
    ls_answer       STRING,
    ls_msg          STRING,
    ls_chkout_user  STRING,   
    ls_table_name   STRING,
    ls_owners_queue STRING,
    ls_replace_arg  STRING
  DEFINE 
    lb_return     BOOLEAN 

  LET ms_alter_type = cs_type_cust_to_std  #客制還原標準
  LET lo_dzit_t_h_scr.* = m_dzit_t_h_scr[mi_dzit_h_index].*
  LET ls_table_name = m_dzit_t_h_scr[mi_dzit_h_index].DZIT001
  LET lb_active = IIF(NVL(m_dzit_t_h_scr[mi_dzit_h_index].DZLM008,"X"), TRUE, FALSE)
  LET ls_chkout_user = m_dzit_t_h_scr[mi_dzit_h_index].DZLM007
  #檢查
  #資料若被簽出,且非簽出者本人不能執行還原行為；
  IF lb_active AND (ls_chkout_user IS NOT NULL) AND 
     (NVL(ls_chkout_user,cs_null_value) <> ms_user) THEN
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00760" #非簽出資料者,沒有執行權限.
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示 
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
    CALL cl_err() 
    LET lb_return = FALSE
    RETURN lb_return
  END IF 
  #數據庫或表格不存在
  IF ls_table_name IS NULL THEN
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "-6001" #數據庫或表格不存在
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
    CALL cl_err()
    LET lb_return = FALSE 
    RETURN lb_return
  END IF
  #客製開發環境下,才可執行此功能
  IF (ms_dgenv = cs_dgenv_customize) THEN
    #do nothing
  ELSE 
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00599" #客製開發環境下,才可執行此功能
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
    CALL cl_err()
    LET lb_return = FALSE 
    RETURN lb_return
  END IF 
  #確認是否客製,是否由標準轉客製
  IF (m_dzit_t_h_scr[mi_dzit_h_index].DZIT004 = cs_dgenv_standard ) THEN
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00761" #已經是標準
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示 
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
    CALL cl_err()
    LET lb_return = FALSE
    RETURN lb_return
  ELSE 
    #取得目前的客制資料
    CALL adzi190_fill_dzit_t_b(lo_dzit_t_h_scr.*) RETURNING lo_dzit_t_b_scr.*
    CALL adzi190_prepare_dzit_t_data(lo_dzit_t_b_scr.*) RETURNING lo_dzit_t.*
    #檢查標準資料是否存在
    LET lo_dzit_t.DZIT004 = cs_dgenv_standard
    IF (NOT sadzi190_crud_check_if_dzit_t_exists(lo_dzit_t.*)) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = "adz-00559" 
      LET g_errparam.extend = NULL
      LET g_errparam.popup  = TRUE  #訊息開窗顯示
      LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
      CALL cl_err()
      LET lb_return = FALSE
      RETURN lb_return
    END IF 
    LET lo_dzit_t.DZIT004 = cs_dgenv_customize
  END IF 
  
  #再次確認是否要執行還原
  CALL sadzp000_msg_get_message('adz-00762',ms_lang) RETURNING ls_replace_arg
  LET ls_replace_arg = "" #"確認要執行客制還原標準嗎？"
  CALL sadzp000_msg_question_box(NULL, "adz-00762", ls_replace_arg, 0) RETURNING ls_answer
  IF ls_answer = cs_response_yes THEN #執行建構,回歸標準,確認無誤後才刪除客制資料；
    #取得標準設計資料
    LET lo_dzit_t_h_scr.DZIT004 = cs_dgenv_standard
    CALL adzi190_fill_dzit_t_b(lo_dzit_t_h_scr.*) RETURNING lo_dzit_t_b_scr.*
    CALL adzi190_prepare_dzit_t_data(lo_dzit_t_b_scr.*) RETURNING lo_dzit_t2.*

    #執行建構
    LET lo_jsonobj = util.JSONObject.create()
    CALL lo_jsonobj.put("confirm", 0)
    CALL adzi190_tbi_build_trigger(p_dialog, lo_dzit_t2.*, lo_jsonobj) RETURNING lb_result 
    IF (lb_result) THEN
      #刪除客制設計資料
      CALL sadzi190_crud_cust_to_std(lo_dzit_t.*) RETURNING lb_return
      IF (lb_return) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00579" #客製還原標準完成.
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
        CALL cl_err()
        LET lb_return = TRUE 
      ELSE
        #刪除客制設計資料失敗, 調整目前客制 trigger 狀態
        LET lo_dzit_t.DZIT009 = 'N'  #設置trigger狀態為未建立
        CALL sadzi190_crud_set_trigger_status(lo_dzit_t.*) RETURNING lb_result
        
        CALL sadzi190_dtas_decode_columns(lo_dzit_t.DZIT003) RETURNING ls_owners_queue
        LET lo_jsonobj = util.JSONObject.create()
        CALL lo_jsonobj.put("owners_queue", ls_owners_queue) 
        CALL lo_jsonobj.put("switch_val", "DISABLE") --停用trigger
        CALL sadzi190_util_switch_trigger(lo_dzit_t.*, lo_jsonobj) RETURNING lb_result,ls_msg

        LET lb_return = TRUE 
      END IF 
    ELSE
      #調整目前客制 trigger 狀態
      LET lo_dzit_t.DZIT009 = 'N'  #設置trigger狀態為未建立
      CALL sadzi190_crud_set_trigger_status(lo_dzit_t.*) RETURNING lb_result
      LET lb_return = FALSE 
    END IF
    #更新頁面
    CALL adzi190_refresh_master(p_dialog)
    CALL adzi190_set_active_state(p_dialog, mi_dzit_h_index)
  ELSE 
    #取消行為
    LET lb_return = FALSE 
  END IF
  
  RETURN lb_return
END FUNCTION 

#檢查觸發器ID是否正確
FUNCTION adzi190_chk_trigerid_iserr(p_dzit_t)
  DEFINE 
    p_dzit_t T_DZIT_T_WL
  DEFINE 
    lo_dzit_t       T_DZIT_T_WL,
    lo_dzit002      LIKE DZIT_T.DZIT002,
    lo_strbuf       base.StringBuffer,
    lb_err          BOOLEAN,
    lb_result       BOOLEAN,
    li_cnt          INTEGER,
    li_idx          INTEGER,
    ls_temp         STRING,
    ls_sql          STRING,
    ls_trgid        STRING,
    ls_trgid_mach   STRING,
    ls_tbl_name     STRING,
    ls_dgenv        STRING
  DEFINE -- return parameter
    l_ret BOOLEAN # 回傳檢查結果 
  DEFINE ls_msg STRING  # 字串訊息暫存 # 170210-00052#1 add
  #========檢查事項=============  
  #不為空
  #檢查命名規則 like (%tbl_name,"rg")  ex: ooca_trg
  #檢查觸發器ID是否重複
  #============================
  LET lo_dzit_t.* =  p_dzit_t.*
  LET lo_dzit002 = p_dzit_t.DZIT002
  LET lb_err = FALSE 
  LET ls_trgid = IIF (p_dzit_t.DZIT002 IS NOT NULL, p_dzit_t.DZIT002, "")
  LET ls_tbl_name = NVL(p_dzit_t.DZIT001 , "")
  LET ls_dgenv    = NVL(p_dzit_t.DZIT001 , ms_dgenv)
     
  IF (NOT lb_err) THEN #table name check 
    LET lo_strbuf = base.StringBuffer.create()
    
    #建立trigger id 比較字串'ls_trgid_mach'
    CALL adzi190_anal_tbl_name(ls_tbl_name) RETURNING lb_result, ls_temp
    IF (lb_result) THEN
      CALL lo_strbuf.append(ls_temp)
      IF (ms_DGENV == cs_dgenv_standard) THEN
        CALL lo_strbuf.append("_trg")
      ELSE 
        CALL lo_strbuf.append("uc_trg")
      END IF
      LET ls_trgid_mach = lo_strbuf.toString()
      # fixme_170302: 尚未完成比較機制
    ELSE
      LET lb_err = TRUE 
    END IF 
  END IF 

  #檢查 trigger id 命名規則是否正確
  IF (lb_err) THEN 
    LET li_idx = ls_trgid.getLength() - ls_temp.getLength()
    IF (li_idx == 0 AND ls_trgid <> ls_temp) THEN
      LET lb_err = TRUE
    ELSE 
      IF (li_idx < 0) THEN 
        LET lb_err = TRUE
      ELSE 
        LET li_idx = li_idx + 1
        IF (ls_trgid.subString(li_idx, ls_trgid.getLength()) <> ls_temp) THEN
          LET lb_err = TRUE
        END IF  
      END IF 
    END IF 

    IF (lb_err) THEN #命名規則錯誤,顯示錯誤訊息
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = "adz-00765"  # 觸發器ID命名錯誤
      LET g_errparam.extend = NULL 
      LET g_errparam.popup  = TRUE
      LET g_errparam.sqlerr = 0
      CALL cl_err()
    END IF 
  END IF 

  #檢查觸發器ID是否重複
  IF (NOT lb_err) THEN
    LET lo_dzit_t.DZIT002 = ls_trgid
    IF (sadzi190_crud_check_if_dzit_t_exists(lo_dzit_t.*)) THEN 
      LET lb_err = TRUE 
      #觸發器ID重複,顯示錯誤訊息
      LET ls_msg = adzi190_get_screen_tag_str("adzi190", ms_lang, "lbl_dzit002")
      IF ls_msg.getLength() <= 0 THEN LET ls_msg = "Trigger ID" END IF 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = "adz-00766"  # %1 必須唯一
      LET g_errparam.extend = NULL 
      LET g_errparam.popup  = TRUE
      LET g_errparam.replace[1] = "", ls_msg
      LET g_errparam.sqlerr = 0
      CALL cl_err()
    END IF
    LET lo_dzit_t.DZIT002 = lo_dzit002
  END IF 
  
  LET l_ret = lb_err
  RETURN l_ret
END FUNCTION 

#analyzing table name,  分析表格名稱
FUNCTION adzi190_anal_tbl_name(p_tbl_name)
  DEFINE 
    p_tbl_name  STRING
  DEFINE
    li_idx          INTEGER,
    lb_suces        BOOLEAN,
    ls_tbl_name     STRING,
    ls_sub_tblname  STRING
  DEFINE ls_msg STRING  -- # 170210-00052#1 add at 2017/02/18 by circlelai
  DEFINE 
    lb_ret   BOOLEAN,
    ls_ret   STRING

  #檢查table name 結尾是否正確 #

  LET lb_suces = TRUE 
  LET ls_tbl_name = IIF (p_tbl_name IS NOT NULL , p_tbl_name.trim(), "")
  
  IF ls_tbl_name IS NULL THEN  #null string
    LET lb_suces = FALSE
    # 170210-00052#1 at 2017/02/18 by circlelai begin
    LET ls_msg = adzi190_get_screen_tag_str("adzi190", ms_lang, "lbl_dzit001")
    IF (ls_msg.getLength() <= 0) THEN LET ls_msg = "Table Name" END IF  
    # 170210-00052#1 at 2017/02/18 by circlelai end
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00767" #%1不能為空
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示 
    LET g_errparam.replace[1] = ls_msg #表格名稱 -- 170210-00052#1 mod
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
    CALL cl_err()
  END IF

  IF (lb_suces) THEN   
    LET li_idx = ls_tbl_name.getLength()
    IF (li_idx > 2) AND ls_tbl_name.getCharAt(li_idx - 1) == "_"
       AND ls_tbl_name.getCharAt(li_idx) == "t" THEN
      IF (li_idx > 3) AND (ls_tbl_name.getCharAt(li_idx - 3) == "u") 
         AND (ls_tbl_name.getCharAt(li_idx - 2) == "c") THEN
        #客制表 "uc_t"
        LET ls_sub_tblname =  ls_tbl_name.subString(1, li_idx-4)
      ELSE 
        #標準表 "_t"
        LET ls_sub_tblname =  ls_tbl_name.subString(1, li_idx-2)
      END IF 
    END IF  
    
    IF (ls_sub_tblname IS NULL) THEN
      LET lb_suces = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = "adz-00768" #表格名稱不符命名規則
      LET g_errparam.extend = NULL
      LET g_errparam.popup  = TRUE  #訊息開窗顯示 
      LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定,0則不顯示)
      CALL cl_err()
    END IF 
  END IF
  
  LET lb_ret = lb_suces
  IF (lb_suces) THEN LET ls_ret =  ls_sub_tblname END IF 
  
  RETURN lb_ret,ls_ret
END FUNCTION 

# @desc.  執行建構
# @input_para.  p_dialog : 目前的DIALOG物件
# @input_para.  p_dzit_t : trigger 設計資料
# @input_para.  p_jsonobj : json object , json 鍵值如下:
# ................confirm : 用於判斷是否要跳出視窗詢問是否執行建構.
# @return_para. lb_return : 回傳執行建構成功否,(ps: 目前只有客制還原標準時的執行建構使用此旗標判斷)
FUNCTION adzi190_tbi_build_trigger(p_dialog, p_dzit_t, p_jsonobj)
  DEFINE --input parameter
    p_dialog  ui.dialog,
    p_dzit_t  T_DZIT_T_WL,
    p_jsonobj util.JSONObject   -- confirm
  DEFINE  --暫存變數
    lo_dzit_t         T_DZIT_T_WL,
    lo_jsonobj        util.JSONObject,
    lb_result         BOOLEAN,
    lb_confirm        BOOLEAN,  
    ls_replace_arg    STRING,
    ls_answer         STRING,
    ls_msg            STRING,
    ls_owners_queue   STRING
  --170210-00052#1 add begin
  DEFINE ls_dzit011     STRING # 新觸法器內容
  DEFINE ls_info_msg    STRING # 訊息字串暫存 
  DEFINE ls_str         STRING # 字串變數暫存
  DEFINE ls_A_SYS_0059  STRING # 系統參數'A-SYS-0059'值
  --170210-00052#1 add end
  DEFINE --return parameter
    lb_return    BOOLEAN
  
  LET lo_dzit_t.* =  p_dzit_t.*
  LET lb_confirm = TRUE 
  LET lb_return = TRUE 
  
  IF p_jsonobj IS NOT NULL THEN
    IF (p_jsonobj.has("confirm")) THEN  #是否要跳出視窗詢問是否執行建構
      LET lb_confirm = p_jsonobj.get("confirm")
    END IF
  END IF 
  
  IF lb_confirm THEN #重複確認
    # 170210-00052#1 at 20170218 by circlelai begin
    #"是否執行建構?(新版觸發器內容)"
    # 取得 adz-00769 訊息字串
    LET ls_replace_arg = ""
    LET ls_info_msg = sadzp000_msg_get_message("adz-00769",NVL(g_lang,cs_default_language))
    LET ls_info_msg = sadzp000_msg_replace_message(ls_info_msg, ls_replace_arg) 

    # 提示目前執行腳本是新的還是舊的
    LET ls_dzit011 = sadzi190_util_trim_str(lo_dzit_t.DZIT011)
    LET ls_A_SYS_0059 = sadzi190_util_get_system_para_val("A-SYS-0059")

    # A-SYS-0059旗標等於"Y" 且new script content 不為空
    IF (ls_A_SYS_0059.getLength() > 0 AND ls_A_SYS_0059 == "Y" 
       AND ls_dzit011.getLength() > 0) THEN
      LET ls_str = adzi190_get_screen_tag_str("adzi190", ms_lang, "lbl_scripts1")
      IF (ls_str.getLength() <= 0) THEN LET ls_str = "New Trigger contents" END IF
    ELSE 
      LET ls_str = adzi190_get_screen_tag_str("adzi190", ms_lang, "lbl_scripts")
      IF (ls_str.getLength() <= 0) THEN LET ls_str = "Trigger contents" END IF 
    END IF
    LET ls_info_msg = ls_info_msg , "(" , ls_str , ")"
    # 開窗確認
    MENU "Confirm" ATTRIBUTE (STYLE="dialog", COMMENT=ls_info_msg.trim(), IMAGE="question")
      ON ACTION yes
        LET lb_result = TRUE
        EXIT MENU
      ON ACTION NO
        LET lb_result = FALSE
        EXIT MENU
      END MENU
    LET ls_answer = IIF(lb_result,cs_response_yes,cs_response_no)
    # 170210-00052#1 at 20170218 by circlelai end 
  ELSE 
    LET ls_answer = cs_response_yes #不確認直接執行建構
  END IF
  
  IF (ls_answer == cs_response_yes) THEN
    CALL sadzi190_dtas_decode_columns(lo_dzit_t.DZIT003) RETURNING ls_owners_queue
    #實際產生 trigger
    CALL sadzi190_util_create_replace_trigger(lo_dzit_t.*,ls_owners_queue) RETURNING lb_result,ls_msg
    CALL adzi190_gen_log_file(ls_msg) #紀錄異動行為LOG,以方便之後追查用 --DGW07558_at20151202
    IF NOT lb_result THEN --執行建構失敗
      LET lb_return = FALSE 
      INITIALIZE g_errparam TO NULL
      IF ms_alter_type == cs_type_cust_to_std THEN
        LET g_errparam.code   = "adz-00763" #還原標準失敗,請參考Log內容
      ELSE 
        LET g_errparam.code   = "adz-00770"  # 新增或置換觸發器失敗,請參考Log內容.
      END IF
      LET g_errparam.extend = NULL 
      LET g_errparam.popup  = TRUE
      LET g_errparam.sqlerr = 0
      CALL cl_err()
      CALL sadzi190_log_view_logresult(ls_msg)
      #更新trigger狀態為未建立,停用已存在trigger 
      LET lo_dzit_t.DZIT009 = 'N'  #設置trigger狀態為未建立
      CALL sadzi190_crud_set_trigger_status(lo_dzit_t.*) RETURNING lb_result
      
      LET lo_jsonobj = util.JSONObject.create()
      CALL lo_jsonobj.put("owners_queue", ls_owners_queue) 
      CALL lo_jsonobj.put("switch_val", "DISABLE") --停用trigger
      CALL sadzi190_util_switch_trigger(lo_dzit_t.*, lo_jsonobj) RETURNING lb_result,ls_msg
    ELSE
      IF ms_alter_type == cs_type_cust_to_std THEN
        #do nothing
      ELSE
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00795"  # %1 建构程序完成
        LET g_errparam.extend = NULL 
        LET g_errparam.popup  = TRUE
        LET g_errparam.replace[1] = lo_dzit_t.DZIT002
        LET g_errparam.sqlerr = 0
        CALL cl_err()
      END IF
      #更新觸發器狀態
      CALL sadzi190_get_and_set_trigger_status(lo_dzit_t.*) RETURNING lb_result 
    END IF
    
    CALL adzi190_refresh_master(p_dialog)
  END IF 

  RETURN lb_return
END FUNCTION 

# @desc.   取得觸發器建立腳本開頭內容
# @memo    按照設計資料建立觸發器開頭腳本
# @para.   p_dzit_t_b_scr  trigger 設計資料
# @return  l_ret  觸發器建立開頭腳本內容
# @create  170210-00052#1 at 2017/02/14 by circlelai 
FUNCTION adzi190_get_trg_head_contents(p_dzit_t_b_scr)
DEFINE # input para 
  p_dzit_t_b_scr T_DZIT_T_WL_B_SCR
DEFINE lo_dzit_t_b_scr  T_DZIT_T_WL_B_SCR
DEFINE ls_events     STRING
DEFINE ls_script_str STRING
DEFINE # return
  l_ret STRING
  
  LET lo_dzit_t_b_scr.* = p_dzit_t_b_scr.*

  -- CREATE OR REPLACE TRIGGER "觸發器ID"
  -- {AFTER | BEFORE} <"觸發事件"> 
  -- REFERENCING new as n old as o 
  -- ON "表格名稱"
  -- {FOR EACH ROW}
  LET ls_events = sadzi190_db_parse_trigger_event(lo_dzit_t_b_scr.DZIT006)
  LET ls_script_str = "CREATE OR REPLACE TRIGGER " , lo_dzit_t_b_scr.dzit002 , " ", cs_new_line
             , lo_dzit_t_b_scr.DZIT005 , " " , ls_events , " " , cs_new_line  
             , "ON " , lo_dzit_t_b_scr.DZIT001 , " " , cs_new_line 
             , "REFERENCING new as n old as o " , cs_new_line 
  IF lo_dzit_t_b_scr.DZIT007 = cs_trigger_type_row THEN
     LET ls_script_str = ls_script_str , "FOR EACH ROW " , cs_new_line
  END IF  

  IF ls_script_str.getLength() > 0 THEN
     LET l_ret = ls_script_str
  ELSE 
     LET l_ret = ""
  END IF 
  
  RETURN l_ret
END FUNCTION 

# @desc.  取得系統資訊
# @input_para.  p_set_title 是否設定作業標題
# @return_para. ls_return  回傳系統資訊
# @create  170210-00052#1 at 2017/02/17 by circlelai
FUNCTION adzi190_get_system_information(p_set_title)
DEFINE  -- input parameter
  p_set_title BOOLEAN
DEFINE
  lb_set_title     BOOLEAN,
  ls_zone          STRING,  # 目前所在開發區域 eg: t10dev 
  ls_cust          STRING,  # T100 客戶名稱
  ls_user          STRING,  # 目前使用帳號
  ls_window_title  STRING,  # title 字串
  lo_db_info       T_DB_INFO, 
  ls_program_title STRING,  
  ls_about         STRING,
  ls_mode          STRING,
  ls_erpid         STRING,
  ls_topind        STRING,  
  ls_DB_TYPE       STRING,  # 數據庫類別
  ldt_curr_time    DATETIME YEAR TO SECOND  # 目前時間
DEFINE  -- return parameter
  ls_return STRING

  LET lb_set_title = p_set_title

  CALL FGL_GETENV("ZONE") RETURNING ls_zone
  CALL FGL_GETENV("CUST") RETURNING ls_cust
  CALL FGL_GETENV("ERPID") RETURNING ls_erpid
  CALL DB_GET_DATABASE_TYPE() RETURNING ls_DB_TYPE
  CALL FGL_GETENV("TOPIND") RETURNING ls_topind 

  LET ls_user = ms_user 
  
  &ifndef DEBUG
  LET ldt_curr_time = cl_get_current()
  &else
  LET ldt_curr_time = CURRENT YEAR TO SECOND
  &endif

  #For get Windows information

  CALL sadzi190_db_get_db_info() RETURNING lo_db_info.*
  CALL sadzi190_util_get_program_title('adzi190',ms_lang) RETURNING ls_program_title

  IF lb_set_title THEN
    LET ls_window_title = NVL(ls_program_title,cs_program_title) 
          , " [ Cust：",ls_cust," ]" , " [ Zone：",ls_zone," ]" 
          , " [ User：",ls_user," ]" , " [DB Name：",lo_db_info.DB_NAME,"]" 
          , " [DB User：",lo_db_info.USER_NAME,"]" 
          , " [ Login Time：",CURRENT YEAR TO SECOND," ]"
    CALL FGL_SETTITLE(ls_window_title)
  END IF

  LET ls_about = "Trigger Designer : " , cs_version , "\n\n"
               , "Environment : ",IIF(ms_dgenv=cs_dgenv_standard,"Standard","Customize") , "\n"
               , "Cust : " , ls_cust , "\n" 
               , "Zone：" , ls_zone , "\n" 
               , "ERPID：" , ls_erpid , "\n"
               , "TOPIND：" , ls_topind , "\n"
               , "DB Type：" , ls_db_type , "\n"
               , "DB Name：" , lo_db_info.DB_NAME , "\n"
               , "DB User：" , lo_db_info.USER_NAME , "\n"
               , "Login User：" , ls_user , "\n"
               , "Login Time：" , mdt_login_time , "\n"  # 登入adzi190時間
               , "Current Time：" , ldt_curr_time

  LET ls_return = ls_about

  RETURN ls_return

END FUNCTION 

# @desc.  取得畫面多語言檔轉換標籤文字 
# @memo  向程式畫面多語言(azzi902) 取得轉換標籤文字
# @input_para.  p_screen_name : 作業名稱  
# @input_para.  p_lang : 語系
# @input_para.  p_chg_tag : 轉換標籤
# @return_para. ls_return : 轉換後的字串
# @create  170210-00052#1 2017/02/18 by circlelai 
FUNCTION adzi190_get_screen_tag_str(p_screen_name, p_lang, p_chg_tag)
  DEFINE  -- input parameter
    p_screen_name  STRING,
    p_lang         STRING,
    p_chg_tag      STRING
  DEFINE  -- return 
    ls_return  STRING
  -- 暫存變數
  DEFINE lo_strbuf   base.StringBuffer # 字串暫存buff # 170210-00052#1 add
  DEFINE ls_str      STRING 
  DEFINE lc_screen_name LIKE gzzd_t.gzzd001
  DEFINE lc_lang        LIKE gzzd_t.gzzd002
  DEFINE lc_chg_tag     LIKE gzzd_t.gzzd003
  DEFINE lc_msg         LIKE gzzd_t.gzzd005

  LET ls_return      = NULL 
  LET lo_strbuf      = base.StringBuffer.create()
  LET lc_screen_name = p_screen_name
  LET lc_lang        = p_lang
  LET lc_chg_tag     = p_chg_tag
  
  # 取得轉換字串 from DB
  SELECT gzzd005 INTO lc_msg 
    FROM gzzd_t 
   WHERE gzzd001 = lc_screen_name AND gzzd002 = lc_lang AND gzzd003 = lc_chg_tag

  # 檢查字串不為空
  LET ls_str = sadzi190_util_trim_str(lc_msg) 
  IF ls_str.getLength() > 0 THEN 
    LET ls_return = lc_msg
  END IF 

  RETURN ls_return
END FUNCTION 

#ver 160525.01 限制只顯示 erpdb, awsdb 的設計資料