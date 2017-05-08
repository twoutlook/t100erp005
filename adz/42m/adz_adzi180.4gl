{
  異動型態      version       日 期       異動者      異動內容
  =========== ============= ========== ========== =======================
  Modify      20161202      20161202   circlelai  1.表格欄位名稱限定只能小寫英文;2.新增歷程與版本代號
  add         20170110      20170110   circlelai  1.釋出功能
  add         20170110      20170116   circlelai  2.異動書籤
}


&include "../4gl/sadzi180_mcr.inc"

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi180_type.inc"

PUBLIC TYPE T_OBJECT_TYPE RECORD
              ot_schema  VARCHAR(50),
              ot_type    VARCHAR(50),
              ot_name    VARCHAR(50) 
END RECORD
 
&include "../4gl/sadzp000_cnst.inc" 
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzi180_cnst.inc"

CONSTANT cs_version  STRING = "20170110"  # 版本代號 # add 20161202 by circlelai
CONSTANT cs_erp_path STRING = "ERP"
CONSTANT cs_program_title STRING = "adzi180-Interface Table Creater " 

GLOBALS "../../cfg/top_global.inc"

DEFINE 
  ms_lang        STRING,
  ms_user        STRING,
  ms_dept        STRING,
  ms_search      STRING,
  ms_module      STRING,
  ms_enterprise  STRING,
  ms_dgenv       STRING,
  mb_debug       BOOLEAN,
  mb_enable_alm  BOOLEAN,   #檢查是否啟動ALM
  mb_enb_chkout  BOOLEAN,   #檢查是否可簽出  --DGW07558_add_at20151116
  mb_arg_run     BOOLEAN,   #檢查是否有帶入參數需要執行  --DGW07558_add_at20151119
  mo_window      ui.Window,  -- 20170110 add by circlelai 
  mo_form        ui.Form,    -- 20170110 add by circlelai 
  mo_master_db   T_PARAMETERS,
  mo_master_user T_PARAMETERS,
  mo_arguments   T_adzi180_ARGUMENTS   #帶入參數資料  --DGW07558_add_at20151119 
  
  
#定義模組變數
DEFINE m_dzia_t_scr DYNAMIC ARRAY OF T_DZIA_T_SCR
DEFINE m_dzib_t_scr DYNAMIC ARRAY OF T_DZIB_T_SCR

# 異動書籤 # 20170116 add by circlelai
DEFINE m_modify_info DYNAMIC ARRAY OF RECORD
          DZIACRTID  LIKE DZIA_T.DZIACRTID,   
          DZIACRTDT  LIKE DZIA_T.DZIACRTDT,
          DZIAMODID  LIKE DZIA_T.DZIAMODID,
          DZIAMODDT  LIKE DZIA_T.DZIAMODDT,
     DZIACRTID_DESC  VARCHAR(100),
     DZIAMODID_DESC  VARCHAR(100) 
                     END RECORD
#定義列表顯示顏色  --DGW07558_add_at20151110
DEFINE m_dzia_t_scr_color DYNAMIC ARRAY OF T_DZIA_T_SCR_COLOR
DEFINE m_dzib_t_scr_color DYNAMIC ARRAY OF T_DZIB_T_SCR_COLOR

DEFINE mi_dzia_index  INTEGER
DEFINE mi_dzib_index  INTEGER

MAIN
  CALL adzi180_initialize()
  CALL adzi180_initial_form()
  CALL adzi180_start()
  CALL adzi180_finalize(TRUE) 
END MAIN

FUNCTION adzi180_initialize()
DEFINE
  ls_parameter   STRING,
  ls_replace_arg STRING,
  ls_erpalm      STRING,
  ls_erpchkout   STRING,
  lb_exists      BOOLEAN,
  lb_error       BOOLEAN, 
  ls_user        STRING,
  li_args         INTEGER,
  li_total_args   INTEGER,
  li_loop         INTEGER,
  lb_args_exists  BOOLEAN,  #有參數要動作
  lb_args_fault   BOOLEAN,  #發現參數輸入錯誤或者未定義
  lb_result       BOOLEAN,
  ls_args         STRING 

  DISPLAY cs_information_tag, "Version : ", cs_version  #顯示版本代號
  CALL sadzi180_util_set_execute_path(os.path.pwd()) #設定執行路徑
  
  &ifndef DEBUG
    #依模組進行系統初始化設定(系統設定)
    CALL cl_tool_init()
    CALL cl_db_connect("ds", TRUE)
    LET ms_lang = g_lang
    LET ms_user = g_account --g_user -- 
    LET ms_dept = g_dept
    LET g_bgjob = "N"
    LET mb_debug = IIF(UPSHIFT(ARG_VAL(2))=="DEBUG",TRUE,FALSE)
    LET ms_enterprise = g_enterprise
    #是否啟動ALM
    CALL FGL_GETENV("TOPALM") RETURNING ls_erpalm
    #是否可簽出
    CALL FGL_GETENV("TOPCHKOUT") RETURNING ls_erpchkout
    CALL FGL_GETENV("DGENV") RETURNING ms_dgenv
  &else
    CALL FGL_GETENV("USER") RETURNING ls_user
    LET ms_lang = cs_default_lang
    LET ms_user = ls_user
    LET ms_dept = cs_dept
    CALL sadzi180_db_connect_db(cs_local_db)
    LET mb_debug = TRUE #IIF(UPSHIFT(ARG_VAL(1))=="DEBUG",TRUE,FALSE)
    LET ls_erpalm = "Y"
    LET ls_erpchkout = "Y"
    LET ms_enterprise = cs_enterprise
  &endif

  LET mb_enable_alm = IIF(NVL(ls_erpalm,"N")=="Y",TRUE,FALSE)
  LET mb_enb_chkout = IIF(NVL(ls_erpchkout,"N")=="Y",TRUE,FALSE)
  IF ms_dgenv IS NULL THEN LET ms_dgenv = "s" END IF 

  #取得Master DB 及 User 及 使用者定義欄位
  CALL sadzi180_db_get_parameters(cs_param_level_system,cs_param_master_db) RETURNING mo_master_db.*
  CALL sadzi180_db_get_parameters(cs_param_level_system,cs_param_master_user) RETURNING mo_master_user.*
  
  #判斷是否有帶參數  --DGW07558_add_at151119
  LET lb_args_fault = FALSE  
  LET lb_args_exists = FALSE 
  LET li_args = NUM_ARGS()
  LET li_total_args = 0
  FOR  li_loop = 1 TO li_args
    LET ls_args = UPSHIFT(ARG_VAL(li_loop))
    IF ls_args LIKE "-%" THEN
      LET li_total_args = li_total_args + 1
    END IF
  END FOR 

  IF (li_total_args > 0) THEN
    LET  lb_args_exists = TRUE 
    #檢查參數正確性
    FOR li_loop = 1 TO li_args
      LET ls_args = UPSHIFT(ARG_VAL(li_loop))
      IF ls_args LIKE "-%" THEN
        CALL adzi180_check_arguments(ls_args, ARG_VAL(li_loop + 1) ) RETURNING lb_result
        IF NOT lb_result THEN LET lb_args_fault = TRUE EXIT FOR END IF #參數有錯誤
        CASE
          WHEN ls_args = cs_args_working_type # -WT chkdiff  "檢查所有表格設計數據與實體數據差別"
            LET mo_arguments.a_WORKING_TYPE = ARG_VAL(li_loop + 1)
        END CASE
        LET li_loop = li_loop + 1 
      END IF 
    END FOR 
  ELSE 
    LET lb_args_exists = FALSE 
  END IF

  IF (lb_args_exists) AND (NOT lb_args_fault) THEN
    LET mb_arg_run = TRUE
  ELSE 
    LET mb_arg_run = FALSE 
  END IF 
  
END FUNCTION

FUNCTION adzi180_initial_form()
DEFINE 
  ls_tiptop_4ad  STRING,
  ls_top_menu    STRING,
  ls_erp_path    STRING,
  ls_separator   STRING,
  ls_temp        STRING,
  ls_toolbar     STRING,
  li_cnt         INTEGER,
  lcbo_target    ui.ComboBox,
  lo_window      ui.Window, 
  lo_form        ui.Form
DEFINE pa_array DYNAMIC ARRAY OF RECORD
             item_val       STRING,
             item_tag   STRING,
             item_label       STRING
                   END RECORD

  
  LET ls_separator = os.Path.separator()
  
  CALL FGL_GETENV(cs_erp_path) RETURNING ls_erp_path
  
  #按 Enter 自動跳欄位
  OPTIONS INPUT WRAP
  CLOSE WINDOW SCREEN

  &ifndef DEBUG
    OPEN WINDOW w_adzi180 WITH FORM cl_ap_formpath("ADZ","adzi180") 
    CURRENT WINDOW IS w_adzi180
    CALL adzi180_set_window_title()
    LET lo_window = ui.Window.getCurrent()
    LET lo_form = lo_window.getForm()

    #載入toolbar --20160309 1416 by Circle
    LET ls_toolbar = ls_erp_path,ls_separator,"cfg",ls_separator,"4tb",ls_separator,"toolbar_adzi180_",ms_lang,".4tb"
    DISPLAY cs_information_tag,"Load toolbar : ",ls_toolbar 
    CALL lo_form.loadToolBar(ls_toolbar) 
    
    CALL ui.Interface.loadStyles(ls_erp_path||ls_separator||"cfg"||ls_separator||"4st"||ls_separator||"adzi180")
    #讓ON ACITON controlg的Button從畫面上消失, 改成用Ctrl-G來觸發
    CALL cl_load_4ad_interface(NULL) 
  &else
    OPEN WINDOW w_adzi180 WITH FORM sadzi180_util_get_form_path("adzi180")
    CURRENT WINDOW IS w_adzi180
    CALL adzi180_set_window_title()
    LET lo_window = ui.Window.getCurrent()
    LET lo_form = lo_window.getForm()
    CALL ui.Interface.loadStyles("adzi180")
    CALL ui.Interface.loadActionDefaults("resource\\tiptop_0")
  &endif

  LET mo_window = lo_window
  LET mo_form   = lo_form
  CALL ui.Dialog.setDefaultUnbuffered(TRUE)
  {
  #combobox 加入選項;
  LET lcbo_target = ui.ComboBox.forName("cbo_exe")
  CALL lcbo_target.clear()
  LET li_cnt = 1              
  LET pa_array[li_cnt].item_val = "1"
  LET pa_array[li_cnt].item_tag = "1"
  LET pa_array[li_cnt].item_label = "標準轉客制"
  LET li_cnt = li_cnt + 1        
  LET pa_array[li_cnt].item_val = "2"
  LET pa_array[li_cnt].item_tag = "2"
  LET pa_array[li_cnt].item_label = "客制還原標準"
  FOR li_cnt = 1 TO pa_array.getLength()
    LET ls_temp = pa_array[li_cnt].item_tag,":",pa_array[li_cnt].item_label
    #display "combo_detail pa_array[li_cnt].value:",pa_array[li_cnt].value , " li_cnt:",li_cnt
    CALL lcbo_target.addItem(pa_array[li_cnt].item_val, ls_temp)
  END FOR
  }
END FUNCTION 

FUNCTION adzi180_start()
DEFINE 
  li_loop         INTEGER,
  lb_result       BOOLEAN,
  lo_jsonobj      util.JSONObject
  
  IF (mb_arg_run) THEN
    CASE
      WHEN mo_arguments.a_WORKING_TYPE = cs_mdm_arg_chk_diff
        #檢查所有設計表與實體表差異並更新'異動確認碼'旗標(DZIA011) --DGW07558_add_at20151119
        DISPLAY "Time:", CURRENT,",  Check Table need long time , please wait ."
        CALL adzi180_fill_dzia_t(NULL)
        FOR li_loop = 1 TO  m_dzia_t_scr.getLength()
          LET lo_jsonobj = util.JSONObject.create()
          CALL lo_jsonobj.put("tablename", m_dzia_t_scr[li_loop].DZIA001)
          CALL lo_jsonobj.put("stand_cust", m_dzia_t_scr[li_loop].DZIA015) 
          DISPLAY "Time:", CURRENT,", Check Table[", m_dzia_t_scr[li_loop].DZIA001,"] Start."
          CALL sadzp310_asmt_chk_tbl_diff(lo_jsonobj) returning lb_result
          DISPLAY "Time:", CURRENT,", Check Table[", m_dzia_t_scr[li_loop].DZIA001,"] Done."
        END FOR 
    END CASE 
  END IF 
  
  CALL adzi180_ui_dialog()
END FUNCTION

FUNCTION adzi180_finalize(p_value)
DEFINE
  p_value BOOLEAN

  IF p_value THEN
    EXIT PROGRAM
  ELSE
    EXIT PROGRAM -1
  END IF 
  
END FUNCTION

FUNCTION adzi180_set_window_title()
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
  
  CALL sadzi180_db_get_db_info() RETURNING lo_db_info.*
  CALL sadzi180_util_get_program_title('adzi180',ms_lang) RETURNING ls_program_title
  
  LET ls_zone = NVL(ls_zone,ls_user_domain)
  LET ls_user = NVL(ms_user,ls_user)

  LET ls_window_title = NVL(ls_program_title,cs_program_title)," [ Zone：",ls_zone," ] [ User：",ls_user," ] [DB Name：",lo_db_info.DB_NAME,"] [DB User：",lo_db_info.USER_NAME,"] [ Login Time：",CURRENT YEAR TO SECOND," ]"

  CALL FGL_SETTITLE(ls_window_title)

END FUNCTION

FUNCTION adzi180_ui_dialog()
  DEFINE 
    lo_win                  ui.Window,
    lo_jsonobj              util.JSONObject, #透過json傳遞參數
    lo_dnd                  ui.DragDrop,
    lo_schema_type          DYNAMIC ARRAY OF T_TABLE_SYNONYM,
    lo_db_connstr           T_DB_CONNSTR,
    lo_table_in_db_type     DYNAMIC ARRAY OF T_TABLE_IN_DB_TYPE,
    lb_drop_status          BOOLEAN,
    lb_error                BOOLEAN,
    lb_kill_tbl_files       BOOLEAN,
    lb_diff                 BOOLEAN,
    lb_table_lock           BOOLEAN,
    lb_table_rebuild        BOOLEAN,
    lb_success              BOOLEAN,
    lb_exist_foreign_key    BOOLEAN,
    lb_commit               BOOLEAN, 
    lb_active               BOOLEAN,
    lb_enable_next          BOOLEAN,
    lb_matched              BOOLEAN,
    lb_kill_data            BOOLEAN,
    drag_index              INTEGER,
    drop_index              INTEGER,
    li_index                INTEGER,
    li_loop                 INTEGER,
    li_arr_curr             INTEGER,
    li_return               INTEGER,
    li_dzlu                 INTEGER,
    li_prev_step            INTEGER,       
    li_next_step            INTEGER,       
    li_step                 INTEGER,
    ls_module               STRING,
    ls_schema_sql           STRING,
    ls_table_name           STRING,
    ls_module_name          STRING,
    ls_module_env           STRING,
    ls_search               STRING,
    ls_question             STRING,
    ls_tbl_Name             STRING,
    drag_source             STRING,
    drag_value              STRING,
    ls_group_id             STRING,
    ls_parameter            STRING,
    ls_key_list             STRING,
    ls_sql_script           STRING,
    ls_version              STRING,
    ls_all_message          STRING,
    ls_message              STRING,
    ls_table_sql_filename   STRING,
    ls_synonym_sql_filename STRING,
    ls_db_username          STRING,
    ls_curr_version         STRING,
    ls_new_version          STRING, 
    ls_table_grant          STRING,
    ls_working              STRING,
    ls_working_path         STRING,
    ls_alm_version          STRING,
    ls_replace_arg          STRING,
    ls_module_path          STRING,
    ls_current_item         STRING,
    ls_rtn_code             STRING,
    ls_table_type           STRING,
    ls_get_issue_table      STRING,
    ls_os_separator         STRING,
    ls_4gl_path             STRING,
    ls_command              STRING,
    ls_file_name            STRING, 
    ls_program_name         STRING,
    ls_pwd_path             STRING,
    ls_source_Table         STRING,
    ls_dest_Table           STRING,
    ls_tdi_name             STRING,
    ls_export_path          STRING,
    ls_export_desc          STRING,
    ls_export_title         STRING,
    ls_import_path          STRING,
    ls_import_desc          STRING,
    ls_import_title         STRING,
    ls_clinet_path_name     STRING,
    ls_separator            STRING,
    ls_alm_request_no       STRING,
    ls_dgenv                STRING,
    ls_GUID                 STRING,
    ls_update_type          STRING,
    ls_table_desc           STRING,
    ls_alm_sd_version       STRING,
    ls_request_no           STRING,
    ls_sequence_no          STRING,
    ls_check_out_full_name  STRING,
    ls_error                STRING,
    ls_table_list           STRING,
    ls_about                STRING,
    ls_module_code          STRING,
    ls_lang                 STRING,
    ls_table_xml            STRING,
    ls_full_table_name      STRING,
    ls_answer               STRING,
    ls_exe_item             STRING,
    ls_temp                 STRING
  DEFINE  #ALM begin
    lo_DZLU_T               DYNAMIC ARRAY OF T_DZLU_T,
    lo_user_info            T_USER_INFO, -- 使用者資訊物件
    lo_dzlm_t               T_DZLM_T,
    lo_table_info           T_PROGRAM_INFO,
    #ALM end
    #adzp310 begin
    lo_COMPRESS_FILE_INFO   T_COMPRESS_FILE_INFO,
    #adzp310 end
    lo_mdm_schema_list      DYNAMIC ARRAY OF T_SCHEMA_LIST,
    lo_columns_list         DYNAMIC ARRAY OF T_INTF_COLUMN_LIST,
    lo_columns_pre_del_list DYNAMIC ARRAY OF T_INTF_COLUMN_LIST,  -- 紀錄修改功能下(tbi_modify_table)準備刪除的資料
    lo_dzia_t               T_DZIA_T,
    lo_dzib_t               DYNAMIC ARRAY OF T_DZIB_T,
    lo_dziu_t               DYNAMIC ARRAY OF T_DZIU_T,
    lo_lang_arr             DYNAMIC ARRAY OF T_LANGUAGE_TYPE
  DEFINE 
    ls_retmsg       STRING,
    lb_return       BOOLEAN,
    lb_result       BOOLEAN,
    lb_isFault      BOOLEAN,
    lb_DropSuccess  BOOLEAN

  LET ls_separator = os.Path.separator()

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  DIALOG ATTRIBUTES(UNBUFFERED)
    
    #Table Lists 
    DISPLAY ARRAY m_dzia_t_scr TO sr_TableList.*
      BEFORE ROW 
        LET mi_dzia_index = ARR_CURR()
        LET ls_table_name = m_dzia_t_scr[mi_dzia_index].dzia001
        LET ls_full_table_name = m_dzia_t_scr[mi_dzia_index].dzia001," - ",m_dzia_t_scr[mi_dzia_index].dzia002
        DISPLAY ls_full_table_name TO formonly.lbl_table_name

        #異動書籤 20170116 add by circlelai
        DISPLAY m_modify_info[mi_dzia_index].DZIACRTID TO sr_ModifyInfo.DZIACRTID
        DISPLAY m_modify_info[mi_dzia_index].DZIACRTDT TO sr_ModifyInfo.DZIACRTDT
        DISPLAY m_modify_info[mi_dzia_index].DZIACRTID_DESC TO sr_ModifyInfo.DZIACRTID_DESC
        DISPLAY m_modify_info[mi_dzia_index].DZIAMODID TO sr_ModifyInfo.DZIAMODID
        DISPLAY m_modify_info[mi_dzia_index].DZIAMODDT TO sr_ModifyInfo.DZIAMODDT
        DISPLAY m_modify_info[mi_dzia_index].DZIAMODID_DESC TO sr_ModifyInfo.DZIAMODID_DESC
        
        LET  lo_jsonobj = util.JSONObject.create()
        CALL lo_jsonobj.put("tablename", ls_table_name)
        CALL lo_jsonobj.put("stand_cust", m_dzia_t_scr[mi_dzia_index].dzia015)
        CALL adzi180_refresh_detail(DIALOG, lo_jsonobj)
        CALL adzi180_set_active_state(DIALOG,mi_dzia_index)
        CALL adzi180_set_check_out_mode(DIALOG,m_dzia_t_scr[mi_dzia_index].*)
        
    END DISPLAY

    #Table Columns
    DISPLAY ARRAY m_dzib_t_scr TO sr_TableColumns.*
      BEFORE ROW
        LET mi_dzib_index = ARR_CURR()
    END DISPLAY
    
    #輸入搜尋條件
    INPUT ls_search FROM edt_Search ATTRIBUTE(WITHOUT DEFAULTS)
      AFTER INPUT 
        LET ms_search = ls_search
      ON CHANGE edt_Search
        LET ms_search = ls_search
    END INPUT

    #標準轉客制...etc操作行為 --DGW07558_add_at201512141400
    INPUT ls_exe_item FROM cbo_exe ATTRIBUTE(WITHOUT DEFAULTS)
      
    END INPUT
    
    BEFORE DIALOG
      LET ls_get_issue_table = "N"
      LET lo_win = ui.Window.getCurrent()
      LET mi_dzia_index = 1
      CALL lo_win.setImage("logo/dsc_logo.ico")
      CALL adzi180_fill_dzia_t(ls_module)
      CALL DIALOG.setArrayAttributes("sr_tablelist",m_dzia_t_scr_color)
      
    ON ACTION find_data   
      LET ms_search = ls_search
      CLEAR sr_tablelist.*
      #搜尋, 所以只傳入ms_search
      LET mi_dzia_index = 1
      CALL adzi180_refresh_master(DIALOG, ms_search)
      CALL DIALOG.setCurrentRow("sr_tablelist", mi_dzia_index)
      CALL adzi180_set_active_state(DIALOG, mi_dzia_index)
      NEXT FIELD lbl_dzia001      

    ON ACTION tbi_create_new_table  #新增表格
      INITIALIZE lo_dzia_t.* TO NULL  #避免新增時出現上次視窗殘留資料 --DGW07558_Add at 201510301155
      #ALM begin 
      #先呼叫簽出
      CALL sadzi180_util_alm_check_out(mb_enable_alm,ms_user,ms_lang,cs_user_role_sd,FALSE) 
           RETURNING lb_result,lo_USER_INFO.*,lo_DZLU_T
      #ALM end 
      IF lb_result THEN 
        CALL sadzi180_ictb_run(lo_dzia_t.*,lo_dzib_t,cs_mdf_type_new) 
          RETURNING lb_return,lo_dzia_t.*,lo_columns_list,lo_mdm_schema_list,lo_columns_pre_del_list
        IF lb_return THEN  
          IF (ms_dgenv = cs_dgenv_standard) THEN
            LET ls_temp = lo_dzia_t.DZIA001, "_t"
          ELSE 
            LET ls_temp = lo_dzia_t.DZIA001, "uc_t"
          END IF  
          LET lo_dzia_t.DZIA001 = ls_temp
          CALL sadzi180_db_append_dzia_information(lo_dzia_t.*) RETURNING lo_dzia_t.*
          CALL sadzi180_db_append_dzib_information(lo_dzia_t.DZIA001,lo_columns_list) RETURNING lo_dzib_t
          CALL sadzi180_db_append_dziu_information(lo_dzia_t.DZIA001) RETURNING lo_dziu_t
          
          #新增表格資料
          CALL sadzi180_crud_set_table_data(lo_dzia_t.*,lo_dzib_t,lo_dziu_t,cs_mdf_type_new,lo_columns_pre_del_list) 
            RETURNING lb_result,ls_message
          IF lb_result THEN
            #新增表格資料成功, 則在 dzlm_t 中實際寫入註冊資料 
            #ALM begin
            CALL sadzi180_util_set_alm_info(lo_dzia_t.DZIA001,lo_dzia_t.DZIA003,lo_dzia_t.DZIA002,"MT","SD",lo_DZLU_T) RETURNING lb_result,lo_dzlm_t.*
            IF NOT lb_result THEN
              #寫入ALM資訊失敗 --DGW07558_add_at20151112 取代 sadzi190_msg_message_box
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = "adz-00726"
              LET g_errparam.extend = NULL
              LET g_errparam.popup  = TRUE  #訊息開窗顯示
              LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
              CALL cl_err()
            END IF
            #ALM end
          ELSE 
            #新增表格資料失敗，請參考Log內容。 --DGW07558_modify_at20151112
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = "adz-00088"
            LET g_errparam.extend = NULL
            LET g_errparam.popup  = TRUE  #訊息開窗顯示
            LET g_errparam.replace[1] = lo_dzia_t.DZIA001
            LET g_errparam.replace[2] = "?"
            LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
            CALL cl_err()
            CALL sadzi180_log_view_logresult(ls_message)  #show log,顯示新增表格資料失敗原因
          END IF

          IF lb_result THEN
            #詢問新建設計表格完成，是否建立實體表格  --DGW07558_add_at151118
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = "adz-00217" # 執行成功
            LET g_errparam.extend = NULL
            LET g_errparam.popup  = TRUE  #訊息開窗顯示
            LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
            CALL cl_err()
            
            #question box: 詢問是否執行異動 --DGW07558_add_at20151110
            LET ls_replace_arg = lo_dzia_t.DZIA001, "|", ""
            CALL sadzp000_msg_question_box(NULL, "adz-00115", ls_replace_arg, 0) RETURNING ls_answer
            IF ls_answer = cs_response_yes THEN
              #adzp310 begin
              LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME = lo_dzia_t.DZIA001
              CALL sadzp310_asmt_run(TRUE,lo_COMPRESS_FILE_INFO.*) RETURNING lb_result,ls_message
              IF NOT lb_result THEN
                #異動表格欄位失敗,請參考Log內容 --DGW07558_modify_at20151112
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code   = "adz-00097"
                LET g_errparam.extend = NULL
                LET g_errparam.popup  = TRUE  #訊息開窗顯示
                LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
                CALL cl_err()
                CALL sadzi180_log_view_logresult(ls_message)
              ELSE
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code   = "adz-00217" # 執行成功
                LET g_errparam.extend = NULL
                LET g_errparam.popup  = TRUE  #訊息開窗顯示
                LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
                CALL cl_err()
                #CALL sadzi190_msg_message_box("Information","dialog","新建表格程序完成","information")
              END IF  
              #adzp310 end
            END IF 
            #重新指定主列表選擇位置 
            CALL adzi180_fill_dzia_t(ms_search)
            IF (m_dzia_t_scr.getLength() <> 0) THEN
              FOR li_index = 1 TO m_dzia_t_scr.getLength()
                IF m_dzia_t_scr[li_index].DZIA001 == lo_dzia_t.DZIA001 THEN
                  LET mi_dzia_index = li_index
                  EXIT FOR 
                END IF  
              END FOR 
            END IF 
            
          END IF
          
          #檢查實體表格與設計表格是否相同 --DGW07558_add_at20151117
          LET lo_jsonobj = util.JSONObject.create()
          CALL lo_jsonobj.put("tablename", lo_dzia_t.DZIA001)
          CALL lo_jsonobj.put("stand_cust", lo_dzia_t.dzia015)
          CALL sadzp310_asmt_chk_tbl_diff(lo_jsonobj) RETURNING lb_result
        END IF 
        
        CALL adzi180_refresh_master(DIALOG,ms_search)
        CALL adzi180_set_active_state(DIALOG, mi_dzia_index)
      END IF 

    ON ACTION tbi_modify_table  #修改表格行為 --DGW07558_add at20151103
      LET ls_table_name = m_dzia_t_scr[mi_dzia_index].dzia001
      LET  lo_jsonobj = util.JSONObject.create()
      CALL lo_jsonobj.put("tablename", ls_table_name)
      CALL lo_jsonobj.put("stand_cust", m_dzia_t_scr[mi_dzia_index].dzia015)
      
      CALL sadzi180_db_get_dzia_information(lo_jsonobj) RETURNING lo_dzia_t.*
      #tip : 在客戶家標準表必須先轉客制才能修改, UI已控管客戶家無法簽出標準表 
      --IF (ms_dgenv = cs_dgenv_customize AND  lo_dzia_t.DZIA015 = cs_dgenv_standard ) THEN CONTINUE DIALOG END IF  
      
      CALL sadzi180_db_get_dzib_information(lo_jsonobj) RETURNING lo_dzib_t
      CALL sadzi180_ictb_run(lo_dzia_t.*,lo_dzib_t,cs_mdf_type_modify) 
           RETURNING lb_return,lo_dzia_t.*,lo_columns_list,lo_mdm_schema_list,lo_columns_pre_del_list
      
      IF lb_return THEN  
        CALL sadzi180_db_append_dzib_information(lo_dzia_t.DZIA001,lo_columns_list) RETURNING lo_dzib_t 
        CALL sadzi180_crud_set_table_data(lo_dzia_t.*,lo_dzib_t,lo_dziu_t,cs_mdf_type_modify,lo_columns_pre_del_list) 
          RETURNING lb_result, ls_message
        IF lb_result THEN
          #show info :修改表格程序完成
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00217" # 執行成功
          LET g_errparam.extend = NULL
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
          CALL cl_err()
          #question box: 詢問是否執行異動 --DGW07558_add_at20151110
          LET ls_replace_arg = lo_dzia_t.DZIA001, "|", ""
          CALL sadzp000_msg_question_box(NULL, "adz-00115", ls_replace_arg, 0) RETURNING ls_answer
          IF ls_answer = cs_response_yes THEN 
            #adzp310 begin
            LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME = lo_dzia_t.DZIA001
            CALL sadzp310_asmt_run(TRUE,lo_COMPRESS_FILE_INFO.*) RETURNING lb_result,ls_message
            IF NOT lb_result THEN
              #show error: 異動表格欄位失敗,請參考Log內容 --DGW07558_modify_at20151112
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = "adz-00097"
              LET g_errparam.extend = NULL
              LET g_errparam.popup  = TRUE  #訊息開窗顯示
              LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
              CALL cl_err()
              CALL sadzi180_log_view_logresult(ls_message)
            ELSE 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = "adz-00771" #表格 %1 异动作业结束
              LET g_errparam.extend = NULL
              LET g_errparam.popup  = TRUE  #訊息開窗顯示
              LET g_errparam.replace[1] = lo_dzia_t.DZIA001
              LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
              CALL cl_err()
            END IF  
            #adzp310 end
          END IF 
          #檢查實體表格與設計表格是否相同 --DGW07558_add_at20151117
          LET lo_jsonobj = util.JSONObject.create()
          CALL lo_jsonobj.put("tablename", lo_dzia_t.DZIA001)
          CALL lo_jsonobj.put("stand_cust", lo_dzia_t.DZIA015)
          CALL sadzp310_asmt_chk_tbl_diff(lo_jsonobj) RETURNING lb_result
          
        ELSE
          #show error: 修改表格資料失敗，請參考Log內容。 --DGW07558_modify_at20151112
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00089"
          LET g_errparam.extend = NULL
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.replace[1] = lo_dzia_t.DZIA001
          LET g_errparam.replace[2] = "?"
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
          CALL cl_err()
          #CALL sadzi190_msg_message_box("Error","dialog","修改表格資料失敗，請參考Log內容。","stop")
          CALL sadzi180_log_view_logresult(ls_message)
        END IF
        CALL adzi180_refresh_master(DIALOG,ms_search)
        CALL DIALOG.setCurrentRow("sr_tablelist",mi_dzia_index)
      END IF
      
    ON ACTION tbi_delete_table
      LET ls_table_name = m_dzia_t_scr[mi_dzia_index].dzia001
      LET lo_jsonobj = util.JSONObject.create()
      CALL lo_jsonobj.put("tablename", ls_table_name)
      CALL lo_jsonobj.put("stand_cust", m_dzia_t_scr[mi_dzia_index].dzia015)
      
      IF ls_table_name.trim() IS NULL THEN
        #show error : 無表格名稱資料 --DGW07558_modify_at20151112
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "-6001"
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
        CONTINUE DIALOG  
      END IF
      
      #取得Schema List
      CALL sadzi180_scs_run() RETURNING lb_return,lo_mdm_schema_list

      IF lb_return THEN 
        LET lb_matched = FALSE
        FOR li_loop = 1 TO lo_mdm_schema_list.getLength()
          IF lo_mdm_schema_list[li_loop].sl_CHECK_BOX = "N" THEN
            LET lb_matched = TRUE
            LET ls_answer = cs_response_no
            EXIT FOR 
          END IF 
        END FOR 
        IF NOT lb_matched THEN 
          #adz-00731："是否一併刪除設定資料?"
          CALL sadzp000_msg_get_message('adz-00731',ms_lang) RETURNING ls_replace_arg
          LET ls_answer = sadzi190_msg_question_box("adz-00731","dialog",ls_replace_arg,"question")
        END IF  
      ELSE 
        LET ls_answer = cs_response_cancel
      END IF      
                                     
      IF (ls_answer <> cs_response_cancel) THEN   
      
        IF ls_answer = cs_response_yes THEN
          LET lb_kill_data = TRUE  
        ELSE
          LET lb_kill_data = FALSE  
        END IF

        IF lb_kill_data AND ((m_dzia_t_scr[mi_dzia_index].dzia015 = cs_dgenv_customize) AND 
         (m_dzia_t_scr[mi_dzia_index].dzia018 = cs_dgenv_standard)) THEN --"標準轉客制"的設計資料
          CALL adzi180_cust_to_std(DIALOG) RETURNING lb_result
          LET lo_jsonobj = util.JSONObject.create()
          CALL lo_jsonobj.put("tablename", ls_table_name)
          CALL lo_jsonobj.put("stand_cust", cs_dgenv_standard)
          CALL sadzp310_asmt_chk_tbl_diff(lo_jsonobj) RETURNING lb_result  --比對實體與設計資料
          CONTINUE DIALOG
        END IF 
        
        CALL sadzi180_db_get_dzia_information(lo_jsonobj) RETURNING lo_dzia_t.*
        CALL sadzi180_util_delete_master_table(lo_dzia_t.*,lo_mdm_schema_list,lb_kill_data) RETURNING lb_result,ls_message
        IF NOT lb_result THEN
          #show error: 刪除表格失敗,請參考Log內容 --DGW07558_add_at151112
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00091" #刪除表格%1失敗. %2
          LET g_errparam.extend = NULL
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.replace[1] = ls_table_name
          LET g_errparam.replace[2] = "please see error log."
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
          CALL cl_err()
          CALL sadzi180_log_view_logresult(ls_message)
        ELSE 
          #刪除表格程序結束
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00771"  # 刪除 %1 程序完成
          LET g_errparam.extend = NULL
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.replace[1] = ls_table_name
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
          CALL cl_err()
          LET mi_dzia_index = 1
        END IF
        
        IF NOT lb_kill_data THEN #設計表資料保留，檢查實體表格與設計表格是否相同
          CALL sadzp310_asmt_chk_tbl_diff(lo_jsonobj) RETURNING lb_result
        END IF 
        
        CALL adzi180_refresh_master(DIALOG,ms_search)
        CALL DIALOG.setCurrentRow("sr_tablelist",mi_dzia_index)
        CALL adzi180_set_active_state(DIALOG, mi_dzia_index)
      END IF  

    ON ACTION tbi_exec_alter #執行異動
      #question box: 詢問是否執行異動 --DGW07558_add_at20151110
      LET ls_replace_arg = lo_dzia_t.DZIA001, "|", ""
      CALL sadzp000_msg_question_box(NULL, "adz-00115", ls_replace_arg, 0) RETURNING ls_answer
      IF ls_answer = cs_response_yes THEN
        LET ls_table_name = m_dzia_t_scr[mi_dzia_index].dzia001
        #adzp310 begin
        LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME = ls_table_name
        CALL sadzp310_asmt_run(TRUE,lo_COMPRESS_FILE_INFO.*) RETURNING lb_result,ls_message
        IF lb_result THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00771"  # 表格 %1 异动作业结束
          LET g_errparam.extend = NULL
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.replace[1] = ls_table_name
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
          CALL cl_err()
        ELSE #show error : 異動表格欄位失敗,請參考Log內容. --DGW07558_mod_at20151112
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00097"
          LET g_errparam.extend = NULL
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
          CALL cl_err()
          CALL sadzi180_log_view_logresult(ls_message)
        END IF
        #adzp310 end
        #檢查實體表格與設計表格是否相同 --DGW07558_add_at20151117
        LET  lo_jsonobj = util.JSONObject.create()
        CALL lo_jsonobj.put("tablename", ls_table_name)
        CALL lo_jsonobj.put("stand_cust", m_dzia_t_scr[mi_dzia_index].dzia015)
        CALL sadzp310_asmt_chk_tbl_diff(lo_jsonobj) RETURNING lb_result
      END IF 
      CALL adzi180_refresh_master(DIALOG,ms_search)
      CALL DIALOG.setCurrentRow("sr_tablelist",mi_dzia_index)
    
    ON ACTION tbi_table_rebuild
      LET ls_table_name = m_dzia_t_scr[mi_dzia_index].dzia001
      LET  lo_jsonobj = util.JSONObject.create()
      CALL lo_jsonobj.put("tablename", ls_table_name)
      CALL lo_jsonobj.put("stand_cust", m_dzia_t_scr[mi_dzia_index].dzia015)
      
      IF ls_table_name.trim() IS NULL THEN #show error : 無表格名稱資料
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "-6001"
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
        CONTINUE DIALOG  
      END IF

      #question box :是否重建表格; --DGW07558_mod_at20151112
      LET ls_replace_arg = ""
      CALL sadzp000_msg_question_box(NULL, "adz-00170", ls_replace_arg, 0) RETURNING ls_answer 
      IF ls_answer = cs_response_yes THEN
        #取得Schema List
        CALL sadzi180_scs_run() RETURNING lb_return,lo_mdm_schema_list
        IF lb_return THEN
          CALL sadzi180_db_get_dzia_information(lo_jsonobj) RETURNING lo_dzia_t.*
          #先刪除實際表格
          CALL sadzi180_util_delete_master_table(lo_dzia_t.*,lo_mdm_schema_list,FALSE) RETURNING lb_result,ls_message
          IF NOT lb_result THEN
            #show error : 刪除表格失敗,請參考Log內容  --DGW07558_mod_at20151112
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = "adz-00167"
            LET g_errparam.extend = NULL
            LET g_errparam.popup  = TRUE  #訊息開窗顯示
            LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
            CALL cl_err()
            CALL sadzi180_log_view_logresult(ls_message)
          END IF
          
          IF lb_result THEN
            #adzp310 begin
            LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME = lo_dzia_t.DZIA001
            CALL sadzp310_asmt_run(TRUE,lo_COMPRESS_FILE_INFO.*) RETURNING lb_result,ls_message
            IF NOT lb_result THEN
              #show error : 異動表格欄位失敗,請參考Log內容.  --DGW07558_mod_at20151112
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = "adz-00097"
              LET g_errparam.extend = NULL
              LET g_errparam.popup  = TRUE  #訊息開窗顯示
              LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
              CALL cl_err()
              #CALL sadzi190_msg_message_box("Error","dialog","異動表格欄位失敗,請參考Log內容.","stop")
              CALL sadzi180_log_view_logresult(ls_message)
            END IF  
            #adzp310 end
          END IF
          
          {
            #再重建實體表格或同義字 
            IF lb_result THEN
              #新增實體表格或同義字 
              CALL sadzi180_util_create_real_object(lo_dzia_t.*,lo_mdm_schema_list) RETURNING lb_result,ls_message
              DISPLAY ls_message
              IF NOT lb_result THEN
                CALL sadzi190_msg_message_box("Error","dialog","新增實體表格或同義字失敗,請參考Log內容.","stop")
                CALL sadzi180_log_view_logresult(ls_message)
              END IF
            END IF 

            IF lb_result THEN
              #異動表格欄位
              CALL sadzi180_util_make_alter_object(lo_dzia_t.*,lo_mdm_schema_list) RETURNING lb_result,ls_message
              DISPLAY ls_message
              IF NOT lb_result THEN
                CALL sadzi190_msg_message_box("Error","dialog","異動表格欄位失敗,請參考Log內容.","stop")
                CALL sadzi180_log_view_logresult(ls_message)
              END IF  
            END IF
            }
          LET  lo_jsonobj = util.JSONObject.create()
          CALL lo_jsonobj.put("tablename", ls_table_name)
          CALL lo_jsonobj.put("stand_cust", m_dzia_t_scr[mi_dzia_index].dzia015)
          CALL sadzp310_asmt_chk_tbl_diff(lo_jsonobj) RETURNING lb_result  
          CALL adzi180_refresh_master(DIALOG,ms_search)
          CALL DIALOG.setCurrentRow("sr_tablelist",mi_dzia_index)
          IF lb_result THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = "adz-00169" # 表格%1重建作業結束
            LET g_errparam.extend = NULL
            LET g_errparam.popup  = TRUE  #訊息開窗顯示
            LET g_errparam.replace[1] = ls_table_name
            LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
            CALL cl_err()
          END IF 
        END IF
      END IF 
      

    #ALM begin
    ON ACTION btn_check_out  
      #先呼叫簽出
      CALL sadzi180_util_alm_check_out(mb_enable_alm,ms_user,ms_lang,cs_user_role_sd,FALSE) 
           RETURNING lb_result,lo_USER_INFO.*,lo_DZLU_T
      IF lb_result THEN
        #在 dzlm_t 中實際寫入註冊資料
        CALL sadzi180_util_set_alm_info(
            m_dzia_t_scr[mi_dzia_index].DZIA001,
            m_dzia_t_scr[mi_dzia_index].DZIA003,
            m_dzia_t_scr[mi_dzia_index].DZIA002,
            "MT","SD",lo_DZLU_T) RETURNING lb_result,lo_dzlm_t.*
        IF lb_result THEN
          #簽出成功
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00776"  #签出成功
          LET g_errparam.extend = NULL
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.replace[1] = m_dzia_t_scr[mi_dzia_index].DZIA001
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
          CALL cl_err()
        ELSE 
          #show error : %1執行簽出時失敗 %2
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "adz-00284"
          LET g_errparam.extend = NULL
          LET g_errparam.popup  = TRUE  #訊息開窗顯示
          LET g_errparam.replace[1] = m_dzia_t_scr[mi_dzia_index].DZIA001
          LET g_errparam.replace[2] = ""
          LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
          CALL cl_err()
        END IF
      END IF
      CALL adzi180_refresh_master(DIALOG,ms_search)
      CALL DIALOG.setCurrentRow("sr_tablelist",mi_dzia_index)
      CALL adzi180_set_active_state(DIALOG, mi_dzia_index)
      
    ON ACTION btn_recall   
      CALL adzi180_refresh_master(DIALOG,ms_search)
      CALL DIALOG.setCurrentRow("sr_tablelist",mi_dzia_index)
      CALL adzi180_set_active_state(DIALOG,mi_dzia_index)

    
    ON ACTION btn_release  #釋出功能 # 20170110
       GOTO _CHECK_IN
    ON ACTION btn_check_in
       LABEL _CHECK_IN:  
      #取得現今DZLM的資料
      LET lo_table_info.pi_NAME   = m_dzia_t_scr[mi_dzia_index].dzia001
      LET lo_table_info.pi_MODULE = m_dzia_t_scr[mi_dzia_index].dzia003
      LET lo_table_info.pi_DESC   = m_dzia_t_scr[mi_dzia_index].dzia002
      LET lo_table_info.pi_TYPE   = "MT" 
      CALL sadzi180_util_alm_check_in(lo_table_info.*,"SD") RETURNING lb_result
      IF lb_result THEN
        #簽入程序結束
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00337" # 簽入程序結束
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
      ELSE 
        #簽入失敗
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00326" # %1执行签入时失败,讯息:%2
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.replace[1] = m_dzia_t_scr[mi_dzia_index].DZIA001
        LET g_errparam.replace[2] = ""
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
      END IF
      CALL adzi180_refresh_master(DIALOG,ms_search)
      CALL DIALOG.setCurrentRow("sr_tablelist",mi_dzia_index)
      CALL adzi180_set_active_state(DIALOG,mi_dzia_index)
    #ALM end
    
    ON ACTION btn_exe_act
      IF (ls_exe_item.trim() IS NULL) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00564" #請先選取資料！
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
        CONTINUE DIALOG
      ELSE
        DISPLAY "ls_exe_item = ", ls_exe_item,""
        CASE ls_exe_item
          WHEN "1"  #標準轉客制 
            CALL adzi180_std_to_cust(DIALOG) RETURNING lb_result
          WHEN "2"  #客制還原標準
            CALL adzi180_cust_to_std(DIALOG) RETURNING lb_result
        END CASE 
      END IF
      
      
      
    ON ACTION EXIT
      LET INT_FLAG=FALSE         
      EXIT DIALOG  
      
    ON ACTION CLOSE    
      LET INT_FLAG=FALSE         
      EXIT DIALOG

    CONTINUE DIALOG  

  END DIALOG

END FUNCTION 
  
FUNCTION adzi180_fill_dzia_t(p_search_name) 
DEFINE 
  p_search_name STRING
DEFINE 
  ls_search_name STRING,
  ls_sql         STRING,
  ls_sql_cond    STRING,
  ls_sql_alm     STRING,
  ls_sql_issue   STRING,
  ls_sql_ooag    STRING,
  ls_column_alm  STRING,
  li_count       INTEGER
  
  DEFINE  ls_gzou003  LIKE gzou_t.gzou003  #ENT對應資料庫 #20170116 by circle

  #20170104 add by circle begin
  SELECT gzou003 INTO ls_gzou003 FROM gzou_t
    WHERE gzou001 = g_enterprise AND gzou002 = g_lang
  
  IF ls_gzou003 IS NULL THEN
    LET ls_gzou003 = "DSDEMO"
  END IF 
  #20170104 add by circle end
  
  LET ls_search_name = p_search_name

  IF (ls_search_name IS NULL) OR (ls_search_name = "*") THEN
    LET ls_sql_cond = " AND dzia003 = '",cs_mdm_module_name,"'"
  ELSE
    LET ls_sql_cond = " AND dzia003 = '",cs_mdm_module_name,"'                   ",
                      " AND (IA.DZIA003 = '",ls_search_name.toUpperCase(),"'     ",
                      "  OR IA.DZIA003 LIKE '%",ls_search_name.toUpperCase(),"%' ",
                      "  OR IA.DZIA001 LIKE '%",ls_search_name,"%'               ",
                      "  OR IA.DZIA002 LIKE '%",ls_search_name,"%')              "
  END IF 

  # 20170116 modify begin
  LET ls_sql = "SELECT DISTINCT DECODE(IA.DZIA011,'N','!','') RECORD_TYPE, '' SEQ_NO," , "\n"
             , "       IA.DZIA003,IA.DZIA001,IA.DZIA002,IA.DZIA004,IA.DZIA005, " , "\n"
             , "       IA.DZIA006,IA.DZIA007, " , "\n"
             , "       IA.DZIA011,IA.DZIA012,IA.DZIA013,IA.DZIA014,IA.DZIA015, " , "\n"
             , "       IA.DZIA016,IA.DZIA017,IA.DZIA018,IA.DZIA019,IA.DZIA020,IA.DZIA021, " , "\n"
             , "       LM.DZLM008,LM.DZLM007,AG.OOAG011, " , "\n"
             , "       IA.DZIACRTID,IA.DZIACRTDT,IA.DZIAMODID,IA.DZIAMODDT, " , "\n"
             , "       AG1.ooag011 dziacrtiddesc, AG2.ooag011 dziamodiddesc" , "\n"
             , "  FROM DZIA_T IA " , "\n"
             # 若標準與客制同時存在則取客制
             , " INNER JOIN (" , "\n"
             , "select distinct dzia001,MIN(dzia015) dzia015 FROM dzia_t GROUP BY dzia001 " , "\n"
             , " ) IA1 ON IA1.dzia001 = IA.dzia001 AND IA1.dzia015 = IA.dzia015 " , "\n"
             # DZLM_T 取得簽出入狀況 
             , "  LEFT OUTER JOIN dzlm_t LM " , "\n"
             , "    ON LM.dzlm001 = '", cs_mdm_construct_type_table, "'" , "\n"
             , "   AND LM.dzlm002 = IA.dzia001 AND LM.dzlm008 = '",cs_check_out,"' " , "\n"
             # 簽出者訊息
             , "  LEFT OUTER JOIN ( " , "\n"
             , "select XA.gzxa001,AG.ooag011 " , "\n"
             , "  FROM " , ls_gzou003 , ".ooag_t AG," , ls_gzou003 , ".gzxa_t XA " , "\n"
             , " WHERE AG.ooagent = XA.gzxaent AND AG.ooag001 = XA.gzxa003 " , "\n"
             , "   AND XA.gzxaent = '",ms_enterprise,"' " , "\n"
             , " GROUP BY XA.gzxa001,AG.ooag011 " , "\n"
             , " ORDER BY XA.gzxa001 " , "\n"
             , "  ) AG ON AG.gzxa001 = LM.dzlm007 " , "\n"
             # 取得異動資訊 資料建立者名稱  add 20170116 by circlelai
             , "  LEFT OUTER JOIN (SELECT ooag001,ooag011 FROM ", ls_gzou003, ".ooag_t " , "\n"
             , "                    WHERE ooagent = '",ms_enterprise,"') AG1" , "\n"
             , "    ON AG1.ooag001 = IA.dziacrtid " , "\n"
             # 取得異動資訊 最近修改者名稱  add 20170116 by circlelai
             , "  LEFT OUTER JOIN (SELECT ooag001,ooag011 FROM ", ls_gzou003, ".ooag_t " , "\n"
             , "                    WHERE ooagent = '",ms_enterprise,"') AG2" , "\n"
             , "    ON AG2.ooag001 = IA.dziamodid " , "\n"
             , " WHERE 1=1 " , "\n"
             , ls_sql_cond , "\n"
             , " ORDER BY IA.DZIA003,IA.DZIA001" , "\n"
  # DISPLAY ls_sql # debug
  # 20170116 modify end
  PREPARE lpre_fill_dzia_t FROM ls_sql
  DECLARE lcur_fill_dzia_t CURSOR FOR lpre_fill_dzia_t

  CALL m_dzia_t_scr.clear() 
  LET li_count = 1 
  
  FOREACH lcur_fill_dzia_t INTO m_dzia_t_scr[li_count].*, m_modify_info[li_count].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF 
    LET m_dzia_t_scr[li_count].DZIASEQ = li_count
    IF m_dzia_t_scr[li_count].dzia011 = "Y" THEN
      CALL adzi180_set_dzia_t_scr_color(m_dzia_t_scr_color[li_count].*, FALSE) 
           RETURNING m_dzia_t_scr_color[li_count].*
    ELSE 
      CALL adzi180_set_dzia_t_scr_color(m_dzia_t_scr_color[li_count].*, TRUE) 
           RETURNING m_dzia_t_scr_color[li_count].*
    END IF 
    
    LET li_count = li_count + 1
  END FOREACH
  CALL m_dzia_t_scr.deleteElement(li_count)
  CALL m_modify_info.deleteElement(li_count)

END FUNCTION

#更新表格內容
FUNCTION adzi180_refresh_detail(p_dialog, p_jsonobj)
DEFINE 
  p_dialog    ui.Dialog,
  p_jsonobj   util.JSONObject  #傳入參數 tablename, stand_cust
  
  CALL adzi180_fill_dzib_t(p_jsonobj)
  CALL p_dialog.setArrayAttributes("sr_tablecolumns",m_dzib_t_scr_color) 
END FUNCTION

FUNCTION adzi180_fill_dzib_t(p_jsonobj)
DEFINE
  p_jsonobj    util.JSONObject   #傳入參數 tablename, stand_cust  --DGW07558_add_at201512161150
DEFINE 
  ls_table_name  STRING,
  ls_stand_cust  STRING,  #取得標準或客製
  ls_sql         STRING,
  ls_sqlwhere    STRING,  #搜尋條件
  li_count       INTEGER 

  LET ls_table_name = IIF (p_jsonobj.has("tablename"), p_jsonobj.get("tablename"), NULL)
  LET ls_stand_cust = IIF (p_jsonobj.has("stand_cust"), p_jsonobj.get("stand_cust"), NULL)

  
  IF ls_table_name IS NULL THEN #傳入參數錯誤; 
    RETURN 
  END IF 

  LET ls_sqlwhere = " WHERE IB.DZIB001 = '",ls_table_name,"' "
  IF (ls_stand_cust IS NOT NULL) 
     AND (ls_stand_cust = cs_dgenv_customize 
         OR ls_stand_cust = cs_dgenv_standard) THEN
    LET ls_sqlwhere = ls_sqlwhere, " AND IB.DZIB029='", ls_stand_cust, "' "
  END IF 
  
  LET ls_sql = "SELECT DECODE(IB.DZIB028,'N','!','') RECORD_TYPE,",
               "       '' GROUP_ID,'' SEQ_NO,",
               "       IB.DZIB001,IB.DZIB002,  IB.DZIB003,IB.DZIB004,IB.DZIB005,    ",
               "       IB.DZIB006,TDL.GZTDL003,IB.DZIB007,IB.DZIB008,IB.DZIB012,    ",
               "       IB.DZIB021,IB.DZIB022,  IB.DZIB023,IB.DZIB024,IB.DZIB027,    ",
               "       IB.DZIB028,IB.DZIB029,  IB.DZIB030,IB.DZIB031                ",
               "  FROM DZIB_T IB                                                    ",
               "       LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = IB.DZIB006         ",                                              
               "       LEFT OUTER JOIN GZTDL_T TDL ON TDL.GZTDL001 = IB.DZIB006     ",                                              
               "                                  AND TDL.GZTDL002 =  '",ms_lang,"' ",                                              
               ls_sqlwhere,
               " ORDER BY DZIBMODDT,IB.DZIB021,IB.DZIB002                           "
  
  PREPARE lpre_fill_dzib_t FROM ls_sql
  DECLARE lcur_fill_dzib_t CURSOR FOR lpre_fill_dzib_t

  CALL m_dzib_t_scr.clear()
  
  LET li_count = 1
  
  #DISPLAY ls_table_name
  FOREACH lcur_fill_dzib_t INTO m_dzib_t_scr[li_count].*    
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET m_dzib_t_scr[li_count].dzibSEQ = li_count
    IF m_dzib_t_scr[li_count].DZIB028 = "Y" THEN
      CALL adzi180_set_dzib_t_scr_color(m_dzib_t_scr_color[li_count].*, FALSE) RETURNING m_dzib_t_scr_color[li_count].*
    ELSE 
      CALL adzi180_set_dzib_t_scr_color(m_dzib_t_scr_color[li_count].*, TRUE) RETURNING m_dzib_t_scr_color[li_count].*
    END IF 

    LET li_count = li_count + 1
    
  END FOREACH
  CALL m_dzib_t_scr.deleteElement(li_count)

END FUNCTION

#更新主表格列表內容
FUNCTION adzi180_refresh_master(p_dialog,p_module_name)
DEFINE 
  p_dialog      ui.Dialog,
  p_module_name STRING
DEFINE
  ls_full_table_name      STRING,
  ls_module_name          STRING,
  lo_combobox     ui.ComboBox,
  lo_jsonobj      util.JSONObject

  INITIALIZE m_dzia_t_scr TO NULL
  INITIALIZE m_dzib_t_scr TO NULL

  LET ls_module_name = p_module_name
  
  LET lo_combobox = ui.ComboBox.forName("formonly.cb_moduleselect")

  CALL adzi180_fill_dzia_t(ls_module_name)
  CALL p_dialog.setArrayAttributes("sr_tablelist",m_dzia_t_scr_color)
  
  LET lo_jsonobj = util.JSONObject.create()
  CALL lo_jsonobj.put("tablename", m_dzia_t_scr[mi_dzia_index].dzia001)
  CALL lo_jsonobj.put("stand_cust", m_dzia_t_scr[mi_dzia_index].dzia015)
  CALL adzi180_refresh_detail(p_dialog, lo_jsonobj)

  CALL adzi180_set_check_out_mode(p_dialog,m_dzia_t_scr[mi_dzia_index].*)
  
  LET ls_full_table_name = m_dzia_t_scr[mi_dzia_index].dzia001," - ",m_dzia_t_scr[mi_dzia_index].dzia002 
  
  DISPLAY ls_full_table_name TO formonly.lbl_table_name
  
END FUNCTION

#顯示目前簽出入狀態  --DGW07558_add_at20151126
FUNCTION adzi180_set_check_out_mode(p_dialog,p_dzia_t)
DEFINE
  p_dialog ui.dialog,
  p_dzia_t T_DZIA_T_SCR
DEFINE 
  ls_check_out_full_name  STRING,
  ls_mode_msg             STRING,
  lo_dzia_t   T_DZIA_T_SCR

  LET lo_dzia_t.* = p_dzia_t.*
  
  CASE 
    WHEN NVL(lo_dzia_t.dzlm008,cs_null_value) <> cs_check_out
      CALL sadzp000_msg_get_message('adz-00365',ms_lang) RETURNING ls_mode_msg
      LET ls_check_out_full_name = "[ ",ls_mode_msg," ]"   #[未簽出]
    WHEN NVL(lo_dzia_t.dzlm008,cs_null_value) = cs_check_out
      CALL sadzp000_msg_get_message('adz-00367',ms_lang) RETURNING ls_mode_msg
      LET ls_check_out_full_name = "[ ",ls_mode_msg,"：",
              lo_dzia_t.dzlm007,"-",
              lo_dzia_t.ooag011," ]"   #[簽出者：使用者帳號-使用者全名]
  END CASE
  
  DISPLAY ls_check_out_full_name TO formonly.lbl_check_out_full_name
  
END FUNCTION 
################################################################################
# Descriptions...: 介面元件權限控管
# Memo...........: 規則記錄
#                : 1.TOPCHKOUT = N, 不能執行簽出入行為.
#                : 2.topstd 帳號不能夠操作.
#                : 3.TOPALM = Y, 只可簽出不能簽入,此時簽入行為交由型管系統控制.
#                : 4.DGENV = s, 標準環境,可以執行簽出及簽入行為.
#                : 5.DGENV = c, 客戶家，針對標準表不能簽出及簽入,請執行標準轉客制.
#                : 6.表格已簽出(dzlm008='O')且目前使用者是簽出者本人(DZLM007),才能夠執行表格異動行為(刪除、修改、執行異動、表格重建).
#                : 7.出貨標識(dzia017)旗標如果為'Y',則不能刪除表格.
#                : 8.釋出功能使用限制標準環境下簽出者本人才能夠操作(TOPCHKOUT=Y，TOPALM=Y,簽出者本人).
# Usage..........: CALL adzi180_set_active_state(p_dialog, p_index)
# Input parameter: p_dialog  ui.Dialog
#                : p_index   目前介面指向位置
# Return code....: 
# Date & Author..: 
# Modify.........: 20151217, 20160401, 20170110 by CircleLai
################################################################################
FUNCTION adzi180_set_active_state(p_dialog, p_index)
DEFINE
  p_dialog    ui.Dialog,
  p_index     INTEGER
DEFINE
  ls_alm_state    STRING, 
  ls_chkout_user  STRING,   #簽出者
  lb_topstd       BOOLEAN,  #控管不能操作帳號
  lb_active       BOOLEAN,  #是否被簽出
  lb_godmod       BOOLEAN,  #上帝模式，開啟所有權限
  lb_chkout_user  BOOLEAN   #簽出者是否現在的使用者

  # init. local parameter
  LET lb_chkout_user = TRUE
  LET lb_godmod = FALSE 

  # 取得簽出入狀態, 簽出者
  LET ls_alm_state    = m_dzia_t_scr[p_index].DZLM008 
  LET ls_chkout_user  = m_dzia_t_scr[p_index].DZLM007
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
  
  # 操作行為還原成預設值不使用狀態
  CALL p_dialog.setActionActive("tbi_create_new_table", FALSE ) # 新增
  CALL p_dialog.setActionActive("tbi_modify_table", FALSE )     # 修改
  CALL p_dialog.setActionActive("tbi_delete_table", FALSE)      # 刪除
  CALL p_dialog.setActionActive("tbi_exec_alter", FALSE)        # 建構
  CALL p_dialog.setActionActive("tbi_table_rebuild", FALSE)     # 刪除並重新建構
  CALL p_dialog.setActionActive("btn_exe_act", FALSE)           # 標準'客製轉換

  # 簽出入先還原成預設值狀態
  CALL p_dialog.setActionActive("btn_check_out", FALSE)
  CALL p_dialog.setActionActive("btn_recall", FALSE)
  CALL p_dialog.setActionActive("btn_check_in", FALSE)
  
  # 20170110 add start
  # 檢查(標準客制轉換功能)是否可用
  IF ms_dgenv = cs_dgenv_customize THEN # 顯示功能鍵
    CALL mo_form.setElementHidden("grid_cust_std_transfer",FALSE) 
  ELSE # 隱藏功能鍵
    CALL mo_form.setElementHidden("grid_cust_std_transfer",TRUE)  
  END IF 

  # 隱藏 (簽入功能)鍵
  CALL mo_form.setElementHidden("btn_check_in",TRUE)

  # 釋出功能 (ps:目前只用於產中環境)
  CALL p_dialog.setActionActive("btn_release", FALSE) # 停用 (釋出功能)
  CALL mo_form.setElementHidden("btn_release", TRUE)  # 隱藏 (釋出功能) 鍵
  # 20170110 add end
  
  #判斷TOPALM and TOPCHKOUT 旗標決定簽出入功能鎖定狀況 # 20170110 mod start
  CASE 
    WHEN lb_godmod #上帝模式
      # 顯示功能鍵
      CALL mo_form.setElementHidden("grid_cust_std_transfer",FALSE)
      CALL mo_form.setElementHidden("btn_check_in",FALSE)
      CALL mo_form.setElementHidden("btn_release", FALSE)
      
      #表格操作行為
      CALL p_dialog.setActionActive("tbi_create_new_table", lb_godmod )
      CALL p_dialog.setActionActive("tbi_modify_table", lb_godmod )
      CALL p_dialog.setActionActive("tbi_delete_table", lb_godmod)
      CALL p_dialog.setActionActive("tbi_exec_alter", lb_godmod)
      CALL p_dialog.setActionActive("tbi_table_rebuild", lb_godmod)
      CALL p_dialog.setActionActive("btn_exe_act", lb_godmod)
      
      #簽出入
      CALL p_dialog.setActionActive("btn_check_out", lb_godmod)
      CALL p_dialog.setActionActive("btn_recall", lb_godmod)
      CALL p_dialog.setActionActive("btn_check_in", lb_godmod)
      CALL p_dialog.setActionActive("btn_release", lb_godmod)
      
    WHEN (NOT mb_enb_chkout) OR (lb_topstd) #禁用簽出入功能;所有操作行為
      #do nothing
    WHEN mb_enb_chkout AND mb_enable_alm  #型管存在
      #可簽出，簽入行為交由型管處理 
      IF (ms_dgenv = cs_dgenv_standard) THEN #標準環境下才可能執行簽出入
        CALL mo_form.setElementHidden("btn_release", NOT lb_active) # 簽出則顯示(釋出功能) # 20170110
        CALL p_dialog.setActionActive("btn_check_out", NOT lb_active)
        #簽入行為交由型管處理;
      ELSE 
        IF (m_dzia_t_scr[p_index].DZIA015 = cs_dgenv_standard) THEN
          #客戶家標準表不能夠簽出入
        ELSE 
          CALL p_dialog.setActionActive("btn_check_out", NOT lb_active)
        END IF 
      END IF 
      
      CALL p_dialog.setActionActive("tbi_create_new_table", TRUE )
      IF (lb_active AND lb_chkout_user) THEN #簽出者本人才能異動表格
        CALL p_dialog.setActionActive("tbi_modify_table", lb_chkout_user)
        IF (m_dzia_t_scr[p_index].DZIA017 = "Y") THEN #已出貨表格不能刪除
          #do nothing
        ELSE 
          CALL p_dialog.setActionActive("tbi_delete_table", lb_chkout_user)
        END IF 
        CALL p_dialog.setActionActive("tbi_exec_alter", lb_chkout_user)
        CALL p_dialog.setActionActive("tbi_table_rebuild", lb_chkout_user)
        CALL p_dialog.setActionActive("btn_release", lb_chkout_user) # 20170110
      END IF 

      #客戶家才能執行標準轉客制，客制還原成標準
      IF ms_dgenv = cs_dgenv_customize THEN
        CALL p_dialog.setActionActive("btn_exe_act", TRUE)
      END IF
      
    WHEN mb_enb_chkout AND (NOT mb_enable_alm)  #沒有型管
      # 顯示(簽入功能)鍵
      CALL mo_form.setElementHidden("btn_check_in", FALSE)  # 20170110 add

      #標準環境下
      IF (ms_dgenv = cs_dgenv_standard) THEN 
        IF (lb_chkout_user) THEN #控管簽出者才能夠做簽入行為
          CALL p_dialog.setActionActive("btn_check_out", NOT lb_active)
          CALL p_dialog.setActionActive("btn_check_in", lb_active )
        END IF
      ELSE 
        #客戶家，標準表不能夠簽出
        IF (m_dzia_t_scr[p_index].DZIA015 = cs_dgenv_standard) THEN
          #do nothing
        ELSE 
          IF (lb_chkout_user) THEN #控管簽出者才能夠做簽入行為
            CALL p_dialog.setActionActive("btn_check_out", NOT lb_active)
            CALL p_dialog.setActionActive("btn_check_in", lb_active )
          END IF
        END IF 
      END IF 
      
      CALL p_dialog.setActionActive("tbi_create_new_table", TRUE ) 

      IF (ms_dgenv = cs_dgenv_customize) THEN
        #卡控客戶家才能執行標準轉客制，客制還原成標準
        CALL p_dialog.setActionActive("btn_exe_act", TRUE )
      END IF
      
      IF (lb_active AND lb_chkout_user) THEN #簽出者本人才能夠執行異動
        IF ( ms_dgenv = cs_dgenv_customize  
            AND m_dzia_t_scr[p_index].DZIA015 = cs_dgenv_standard ) THEN
          #卡控客戶家標準表格不能異動
        ELSE 
          CALL p_dialog.setActionActive("tbi_modify_table", lb_chkout_user)
          IF (m_dzia_t_scr[p_index].DZIA017 = "Y") THEN #出貨旗標，卡控表格不能被刪除
            #do nothing
          ELSE 
            CALL p_dialog.setActionActive("tbi_delete_table", lb_chkout_user)
          END IF
          CALL p_dialog.setActionActive("tbi_exec_alter", lb_chkout_user)
          CALL p_dialog.setActionActive("tbi_table_rebuild", lb_chkout_user)
        END IF
      END IF
      
    OTHERWISE
      DISPLAY "Exception on adzi180_set_active_state(..)"
  END CASE 
  # 20170110 mod end
  
  
END FUNCTION

#設定表格主檔(dzia_t)列表顏色;  --DGW07558_add_at20151118 
FUNCTION adzi180_set_dzia_t_scr_color(p_obj, p_chk_diff)
DEFINE 
  p_obj       T_DZIA_T_SCR_COLOR,
  p_chk_diff  BOOLEAN
DEFINE 
  lo_obj      T_DZIA_T_SCR_COLOR

  LET lo_obj.* =  p_obj.* 
  
  IF (p_chk_diff) THEN
    LET lo_obj.RECORDTYPE = "red"
    LET lo_obj.DZIASEQ = "red reverse"
    LET lo_obj.DZIA003 = "red reverse"
    LET lo_obj.DZIA001 = "red reverse"
    LET lo_obj.DZIA002 = "red reverse"
    LET lo_obj.DZIA004 = "red reverse"
    LET lo_obj.DZIA005 = "red reverse"
    LET lo_obj.DZIA006 = "red reverse"
    LET lo_obj.DZIA007 = "red reverse"
    LET lo_obj.DZIA011 = "red reverse"
    LET lo_obj.DZIA012 = "red reverse"
    LET lo_obj.DZIA013 = "red reverse"
    LET lo_obj.DZIA014 = "red reverse"
    LET lo_obj.DZIA015 = "red reverse"
    LET lo_obj.DZIA016 = "red reverse"
    LET lo_obj.DZIA017 = "red reverse"
    LET lo_obj.DZIA018 = "red reverse"
    LET lo_obj.DZIA019 = "red reverse"
    LET lo_obj.DZIA020 = "red reverse"
    LET lo_obj.DZIA021 = "red reverse"
    LET lo_obj.DZLM008 = "red reverse"
  ELSE 
    LET lo_obj.RECORDTYPE = NULL
    LET lo_obj.DZIASEQ = NULL
    LET lo_obj.DZIA003 = NULL
    LET lo_obj.DZIA001 = NULL
    LET lo_obj.DZIA002 = NULL
    LET lo_obj.DZIA004 = NULL
    LET lo_obj.DZIA005 = NULL
    LET lo_obj.DZIA006 = NULL
    LET lo_obj.DZIA007 = NULL
    LET lo_obj.DZIA011 = NULL
    LET lo_obj.DZIA012 = NULL
    LET lo_obj.DZIA013 = NULL
    LET lo_obj.DZIA014 = NULL
    LET lo_obj.DZIA015 = NULL
    LET lo_obj.DZIA016 = NULL
    LET lo_obj.DZIA017 = NULL
    LET lo_obj.DZIA018 = NULL
    LET lo_obj.DZIA019 = NULL
    LET lo_obj.DZIA020 = NULL
    LET lo_obj.DZIA021 = NULL
    LET lo_obj.DZLM008 = NULL
  END IF 

  RETURN lo_obj.*
  
END FUNCTION 

#設定表格明細檔(dzib_t)列表顏色;  --DGW07558_add_at20151125
FUNCTION adzi180_set_dzib_t_scr_color(p_obj, p_chk_diff)
DEFINE 
  p_obj       T_DZIB_T_SCR_COLOR,
  p_chk_diff  BOOLEAN
DEFINE 
  lo_obj      T_DZIB_T_SCR_COLOR

  LET lo_obj.* =  p_obj.*
  IF (p_chk_diff) THEN
    LET lo_obj.RECORDTYPE = "red"
    LET lo_obj.DZIBSEQ = "red reverse"
    LET lo_obj.GROUPID = "red reverse"
    LET lo_obj.GZTDL003 = "red reverse"
    LET lo_obj.DZIB001 = "red reverse"
    LET lo_obj.DZIB002 = "red reverse"
    LET lo_obj.DZIB003 = "red reverse"
    LET lo_obj.DZIB004 = "red reverse"
    LET lo_obj.DZIB005 = "red reverse"
    LET lo_obj.DZIB006 = "red reverse"
    LET lo_obj.DZIB007 = "red reverse"
    LET lo_obj.DZIB008 = "red reverse"
    LET lo_obj.DZIB012 = "red reverse"
    LET lo_obj.DZIB021 = "red reverse"
    LET lo_obj.DZIB022 = "red reverse"
    LET lo_obj.DZIB023 = "red reverse"
    LET lo_obj.DZIB024 = "red reverse"
    LET lo_obj.DZIB027 = "red reverse"
    LET lo_obj.DZIB028 = "red reverse"
    LET lo_obj.DZIB029 = "red reverse"
    LET lo_obj.DZIB030 = "red reverse"
    LET lo_obj.DZIB031 = "red reverse"
  ELSE 
    LET lo_obj.RECORDTYPE = NULL
    LET lo_obj.DZIBSEQ = NULL
    LET lo_obj.GROUPID = NULL
    LET lo_obj.GZTDL003 = NULL
    LET lo_obj.DZIB001 = NULL
    LET lo_obj.DZIB002 = NULL
    LET lo_obj.DZIB003 = NULL
    LET lo_obj.DZIB004 = NULL
    LET lo_obj.DZIB005 = NULL
    LET lo_obj.DZIB006 = NULL
    LET lo_obj.DZIB007 = NULL
    LET lo_obj.DZIB008 = NULL
    LET lo_obj.DZIB012 = NULL
    LET lo_obj.DZIB021 = NULL
    LET lo_obj.DZIB022 = NULL
    LET lo_obj.DZIB023 = NULL
    LET lo_obj.DZIB024 = NULL
    LET lo_obj.DZIB027 = NULL
    LET lo_obj.DZIB028 = NULL
    LET lo_obj.DZIB029 = NULL
    LET lo_obj.DZIB030 = NULL
    LET lo_obj.DZIB031 = NULL
  END IF 
  
  RETURN lo_obj.*
END FUNCTION 

#檢查輸入參數
FUNCTION adzi180_check_arguments(p_argument_type, p_value)
DEFINE
  p_argument_type STRING,
  p_value         STRING
DEFINE
  ls_argument_type STRING,
  ls_value         STRING
DEFINE
  lb_return BOOLEAN

  LET lb_return = FALSE #預設輸入參數錯誤;
  LET ls_argument_type = p_argument_type
  LET ls_value = p_value 
  CASE 
    WHEN ls_argument_type = cs_args_working_type
      CASE
        WHEN ls_value = cs_mdm_arg_chk_diff #檢查設計表與實體表差異
          LET lb_return = TRUE 
        OTHERWISE
          DISPLAY cs_error_tag,ls_argument_type," : The working type '",ls_value,"' not correct."
          LET lb_return = FALSE
      END CASE   
  END CASE 
  RETURN lb_return 
END FUNCTION
 
################################################################################
# Descriptions...: 標準轉客製
# Memo...........: 
#                : 
# Usage..........: CALL adzi180_std_to_cust(p_dialog)
# Input parameter: p_dialog  ui.Dialog
# Return code....: lb_return 標準轉客制是否成功
# Date & Author..: 
# Modify.........: 20160401 by CircleLai
################################################################################
FUNCTION adzi180_std_to_cust(p_dialog) 
  DEFINE 
    p_dialog    ui.Dialog
  DEFINE 
    ls_replace_arg  STRING,
    ls_table_name   STRING,
    ls_message      STRING,
    li_cnt          INTEGER,
    lb_result       BOOLEAN,
    lo_jsonobj      util.JSONObject,
    lo_user_info    T_USER_INFO, -- 使用者資訊物件
    lo_DZLU_T       DYNAMIC ARRAY OF T_DZLU_T, --簽出入權限資訊
    lo_dzia_t       T_DZIA_T,
    lo_dzib_t       DYNAMIC ARRAY OF T_DZIB_T,
    lo_dzlm_t       T_DZLM_T
  DEFINE 
    lb_return       BOOLEAN
    
  LET lb_return = TRUE  
  LET ls_table_name = m_dzia_t_scr[mi_dzia_index].dzia001
  
  #數據庫或表格不存在
  IF ls_table_name IS NULL THEN
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "-6001"
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
    CALL cl_err()
    LET lb_return = FALSE 
    RETURN lb_return
  END IF

  #標準表格才能轉客制
  IF m_dzia_t_scr[mi_dzia_index].DZIA015 = cs_dgenv_standard THEN
    #do nothing
  ELSE
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00756" -- 客制資料已存在
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
    CALL cl_err()
    LET lb_return = FALSE 
    RETURN lb_return
  END IF 
  
  #客製環境下，才可執行此功能
  IF (ms_dgenv = cs_dgenv_customize) THEN
    #do nothing
  ELSE 
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00599" # 客製開發環境下，才可執行此功能！
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
    CALL cl_err()
    LET lb_return = FALSE 
    RETURN lb_return
  END IF  
  
  #ALM begin 
  #先呼叫簽出
  CALL sadzi180_util_alm_check_out(mb_enable_alm,ms_user,ms_lang,cs_user_role_sd,FALSE) 
       RETURNING lb_result,lo_USER_INFO.*,lo_DZLU_T
  #ALM end
  IF (lb_result) THEN 
    #取得資料，準備標準轉客制
    LET lo_jsonobj = util.JSONObject.create()
    CALL lo_jsonobj.put("tablename", ls_table_name)
    CALL lo_jsonobj.put("stand_cust", m_dzia_t_scr[mi_dzia_index].dzia015)
    CALL sadzi180_db_get_dzia_information(lo_jsonobj) RETURNING lo_dzia_t.*

    #取得表格欄位詳細資料
    CALL sadzi180_db_get_dzib_information(lo_jsonobj) RETURNING lo_dzib_t
    
    LET lo_dzia_t.DZIA015 = cs_dgenv_customize
    LET lo_dzia_t.DZIA017 = "N"   #出貨標識
    FOR li_cnt = 1 to lo_dzib_t.getLength()
      LET lo_dzib_t[li_cnt].DZIB029 = cs_dgenv_customize
     LET lo_dzib_t[li_cnt].DZIB031 = "N"  #出貨標識
    END FOR 
    #ALM
    #標準轉客制
    CALL sadzi180_crud_set_table_data(lo_dzia_t.*, lo_dzib_t, NULL, cs_mdf_type_std_to_cust, NULL) 
      RETURNING lb_result,ls_message
    IF lb_result THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = "adz-00549"
      LET g_errparam.extend = NULL
      LET g_errparam.popup  = TRUE  #訊息開窗顯示
      LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
      CALL cl_err()
      #完成標準轉客制，實際寫入註冊資料 DZLM_T
      #ALM begin
      CALL sadzi180_util_set_alm_info(lo_dzia_t.DZIA001,lo_dzia_t.DZIA003,lo_dzia_t.DZIA002,"MT","SD",lo_DZLU_T) 
           RETURNING lb_result,lo_dzlm_t.*
      IF NOT lb_result THEN
        #寫入ALM資訊失敗 --DGW07558_add_at20151112 取代 sadzi190_msg_message_box
        LET ls_replace_arg = ""
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00726"
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
        #ALM end 
      END IF 
      #刷新頁面;
      CALL adzi180_refresh_master(p_dialog,ms_search)
      CALL adzi180_set_active_state(p_dialog, mi_dzia_index)
    ELSE
      --adz-00758 標準轉客制出現錯誤，請參考LOG
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = "adz-00758"
      LET g_errparam.extend = NULL
      LET g_errparam.popup  = TRUE  #訊息開窗顯示
      LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
      CALL cl_err()
      
      CALL sadzi180_log_view_logresult(ls_message) #rixqq: 需要調整錯誤訊息的顯示方式，背景顯示錯誤訊息;
      LET lb_return = lb_result
    END IF
  ELSE 
    #rixqq? 簽出失敗，考慮是否要顯示失敗訊息
    LET lb_return = FALSE 
    RETURN lb_return
  END IF 
  
    
  RETURN lb_return 
END FUNCTION

#客製還原標準
FUNCTION adzi180_cust_to_std(p_dialog)
  DEFINE 
    p_dialog ui.Dialog
  DEFINE 
    ls_table_name   STRING,
    ls_replace_arg  STRING,
    ls_ans          STRING,
    ls_msg          STRING,
    lb_result       BOOLEAN,
    lo_jsonobj      util.JSONObject,
    lo_COMPRESS_FILE_INFO   T_COMPRESS_FILE_INFO 
  DEFINE 
    lb_return       BOOLEAN 

  LET ls_table_name = m_dzia_t_scr[mi_dzia_index].dzia001
  LET lb_return = TRUE 
  
  #數據庫或表格不存在
  IF lb_return AND (ls_table_name IS NULL) THEN
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "-6001"
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
    CALL cl_err()
    LET lb_return = FALSE
  END IF  
  #客製環境下，才可執行此功能
  IF lb_return AND (ms_dgenv = cs_dgenv_customize) THEN
    #do nothing
  ELSE 
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code   = "adz-00599"
    LET g_errparam.extend = NULL
    LET g_errparam.popup  = TRUE  #訊息開窗顯示
    LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
    CALL cl_err()
    LET lb_return = FALSE
  END IF
  #確認是否客製,是否由標準轉客製
  IF (lb_return) THEN 
    IF (m_dzia_t_scr[mi_dzia_index].DZIA015 = cs_dgenv_customize 
        AND m_dzia_t_scr[mi_dzia_index].DZIA018 = cs_dgenv_standard) THEN
      #do nothing
    ELSE 
      IF m_dzia_t_scr[mi_dzia_index].DZIA015 = cs_dgenv_standard THEN
        --已經是標準表
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00761"
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
        LET lb_return = FALSE 
      ELSE
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00559" #此程式不存在標準設計資料,所以不能執行還原標準.
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
        LET lb_return = FALSE 
      END IF
      
    END IF 
    
  END IF  
  #再次提醒確認是否執行
  IF (lb_return) THEN #再次確認是否要執行還原
    # adz-00762 確認要執行客制還原標準嗎
    CALL sadzp000_msg_get_message('adz-00762',ms_lang) RETURNING ls_replace_arg
    LET ls_replace_arg = "" #"確認要執行客制還原標準嗎？"
    CALL sadzp000_msg_question_box(NULL, "adz-00762", ls_replace_arg, 0) RETURNING ls_ans
    IF (ls_ans = cs_response_yes) THEN
      LET lb_return = TRUE 
    ELSE 
      LET lb_return = FALSE
    END IF 
    
  END IF 
  
  IF (lb_return) THEN
    LET lo_jsonobj = util.JSONObject.create()
    CALL lo_jsonobj.put("tablename", ls_table_name)
    CALL lo_jsonobj.put("stand_cust", m_dzia_t_scr[mi_dzia_index].dzia015) 
    
    CALL sadzi180_db_cust_to_std(lo_jsonobj) RETURNING lb_result
    IF (lb_result) THEN
      LET ls_replace_arg = ""
      # 異動實體表格
      #adzp310 begin
      LET lo_COMPRESS_FILE_INFO.cfi_OBJECT_NAME = ls_table_name
      CALL sadzp310_asmt_run(TRUE,lo_COMPRESS_FILE_INFO.*) RETURNING lb_result,ls_msg
      IF lb_result THEN 
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00771" # 表格 %1 异动作业结束
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.replace[1] = ls_table_name
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
      ELSE #show error : 異動表格欄位失敗,請參考Log內容. --DGW07558_mod_at20151112
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code   = "adz-00097"
        LET g_errparam.extend = NULL
        LET g_errparam.popup  = TRUE  #訊息開窗顯示
        LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
        CALL cl_err()
        CALL sadzi180_log_view_logresult(ls_msg)
        LET lb_return = FALSE 
      END IF
      #adzp310 end
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = "adz-00579" # 客制還原標準完成
      LET g_errparam.extend = NULL
      LET g_errparam.popup  = TRUE  #訊息開窗顯示
      LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
      CALL cl_err()
      #檢查標準設計表與實體表之間差異
      CALL lo_jsonobj.put("stand_cust", cs_dgenv_standard)
      CALL sadzp310_asmt_chk_tbl_diff(lo_jsonobj) RETURNING lb_result 
      #刷新頁面;
      CALL adzi180_refresh_master(p_dialog,ms_search)
      CALL adzi180_set_active_state(p_dialog, mi_dzia_index)
    ELSE
      --adz-00763 還原標準失敗,請參考Log內容
      LET g_errparam.code   = "adz-00763"
      LET g_errparam.extend = NULL
      LET g_errparam.popup  = TRUE  #訊息開窗顯示
      LET g_errparam.sqlerr = 0 #SQLCA.SQLERRD[2] #或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
      CALL cl_err()
      LET lb_return = FALSE 
      #rixqq? log file 待做
    END IF
    
  END IF  
  
  RETURN lb_return 
END FUNCTION  

