{
  異動型態    異動單號       日 期       異動者      異動內容
  ========= ============= ========== ========== ===============================================
  Modify                  20160706   Ernestliou 1.修改成可供ERP使用的設計器
  Modify                  20161021   Ernestliou 1.將Toolbar拆解出來
}

&include "../4gl/sadzi200_mcr.inc"

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi200_type.inc"

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi200_cnst.inc"

CONSTANT cs_erp_path      STRING = "ERP"
CONSTANT cs_program_title STRING = "adzi200-View Creator"
CONSTANT cs_version       STRING = "20160707"

GLOBALS "../../cfg/top_global.inc"

################################################################################
#資料表 TYPE 宣告

DEFINE 
  ms_lang        STRING,
  ms_user        STRING,
  ms_dept        STRING,
  mb_debug       BOOLEAN,
  mo_master_db   T_PARAMETERS,
  mo_master_user T_PARAMETERS,
  ms_search      STRING,
  ms_module      STRING,
  ms_enterprise  STRING, --Jack Cheng 20160115
  ms_dgenv       STRING,
  ms_alter_type  STRING,
  ms_db_name     STRING,
  mo_window      ui.Window, 
  mo_form        ui.Form,
  mb_enable_alm  BOOLEAN,
  mb_enb_chkout  BOOLEAN,   #檢查是否可簽出  --DGW07558_add_at20151118
  ms_topind      STRING, -- 20160706
  mb_dziv004_modified BOOLEAN, -- 20160706
  mdt_login_time DATETIME YEAR TO SECOND -- 20160706

#定義模組變數
DEFINE m_dziv_t_h_scr DYNAMIC ARRAY OF T_DZIV_T_H_SCR
DEFINE m_dziv_t_b_scr T_DZIV_T_B_SCR

DEFINE mi_dziv_h_index  INTEGER
DEFINE mi_dziv_b_index  INTEGER

MAIN
  --DISPLAY "ver 160525.01" -- 20160706 Marked
  CALL adzi200_initialize()
  CALL adzi200_initial_form()
  CALL adzi200_start()
  CALL adzi200_finalize(TRUE) 
END MAIN

FUNCTION adzi200_initialize()
DEFINE
  ls_parameter   STRING,
  ls_replace_arg STRING,
  lb_exists      BOOLEAN,
  lb_error       BOOLEAN, 
  ls_user        STRING,
  ls_erpalm      STRING,
  ls_erpchkout   STRING 

  #20160706
  DISPLAY cs_information_tag,"Version : ",cs_version

  CALL sadzi200_util_set_execute_path(os.path.pwd()) #設定執行路徑
  
  &ifndef DEBUG
    #依模組進行系統初始化設定(系統設定)
    CALL cl_tool_init()
    CALL cl_db_connect("ds", TRUE)
    LET ms_lang = g_lang
    LET ms_user = g_account --g_user -- 
    LET ms_dept = g_dept
    LET g_bgjob = "N"
    LET mb_debug = IIF(UPSHIFT(ARG_VAL(2))=="DEBUG",TRUE,FALSE)
    LET ms_enterprise = g_enterprise --Jack Cheng 20160115
    CALL FGL_GETENV("TOPCHKOUT") RETURNING ls_erpchkout
    CALL FGL_GETENV("TOPALM") RETURNING ls_erpalm
    CALL FGL_GETENV("DGENV") RETURNING ms_dgenv
    LET mdt_login_time = cl_get_current()
  &else
    CALL FGL_GETENV("USER") RETURNING ls_user
    LET ms_lang = cs_default_lang
    LET ms_user = ls_user
    LET ms_dept = cs_dept
    CALL sadzi200_db_connect_db(cs_local_db)
    LET mb_debug = TRUE #IIF(UPSHIFT(ARG_VAL(1))=="DEBUG",TRUE,FALSE)
    LET ls_erpalm = "N"
    LET ls_erpchkout = "Y"
    LET mdt_login_time = CURRENT YEAR TO SECOND
  &endif

  LET mb_enable_alm = IIF(NVL(ls_erpalm,"N")=="Y",TRUE,FALSE)
  LET mb_enb_chkout = IIF(NVL(ls_erpchkout,"N")=="Y",TRUE,FALSE)
  
  #是否客制環境
  &ifndef DEBUG
    CALL FGL_GETENV("DGENV") RETURNING ms_dgenv
    CALL FGL_GETENV("TOPIND") RETURNING ms_topind
  &else
    LET ms_dgenv = "c"
    LET ms_topind = cs_topind_standard
  &endif

  #取得Master DB 及 User 及 使用者定義欄位
  CALL sadzi200_db_get_parameters(cs_param_level_system,cs_param_master_db) RETURNING mo_master_db.*
  CALL sadzi200_db_get_parameters(cs_param_level_system,cs_param_master_user) RETURNING mo_master_user.*

END FUNCTION

FUNCTION adzi200_initial_form()
DEFINE 
  ls_tiptop_4ad  STRING,
  ls_top_menu    STRING,
  ls_erp_path    STRING,
  ls_sql         STRING,
  lo_combobox    ui.ComboBox,
  ls_separator   STRING,
  ls_img_path    STRING, -- 20160706
  ls_logo_path   STRING, -- 20160706
  ls_toolbar     STRING  -- 20161021

  LET ls_separator = os.Path.separator()
  
  CALL FGL_GETENV(cs_erp_path) RETURNING ls_erp_path
  
  #按 Enter 自動跳欄位
  OPTIONS INPUT WRAP
  CLOSE WINDOW SCREEN

  &ifndef DEBUG
    OPEN WINDOW w_adzi200 WITH FORM cl_ap_formpath("ADZ","adzi200") 
    CURRENT WINDOW IS w_adzi200
    LET ls_top_menu = ls_erp_path,ls_separator,"adz",ls_separator,"4tm",ls_separator,ms_lang,ls_separator,"adzi200.4tm"
    LET ls_toolbar  = ls_erp_path,ls_separator,"cfg",ls_separator,"4tb",ls_separator,"toolbar_adzi200_",ms_lang,".4tb" -- 20161021
    LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui") -- 20160706

    #CALL adzi200_set_window_title()
    LET mo_window = ui.Window.getCurrent()
    LET mo_form = mo_window.getForm()

    -- 20160706 begin
    CALL cl_ui_wintitle(1) #工具抬頭名稱
    LET ls_logo_path = os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico")
    CALL mo_window.setImage(ls_logo_path)
    -- 20160706 end
    
    DISPLAY cs_information_tag,"Load top menu : ",ls_top_menu
    CALL mo_form.loadTopMenu(ls_top_menu)
    CALL mo_form.loadToolBar(ls_toolbar) -- 20161021
    
    #CALL ui.Interface.loadStyles(ls_erp_path||ls_separator||"cfg"||ls_separator||"4st"||ls_separator||"adzi200")
    CALL sadzi200_util_set_form_style(ms_lang)
    #讓ON ACITON controlg的Button從畫面上消失, 改成用Ctrl-G來觸發
    CALL cl_load_4ad_interface(NULL) 
  &else
    OPEN WINDOW w_adzi200 WITH FORM sadzi200_util_get_form_path("adzi200")
    CURRENT WINDOW IS w_adzi200
    LET ls_top_menu = ls_erp_path,ls_separator,"adz",ls_separator,"4tm",ls_separator,ms_lang,ls_separator,"adzi200.4tm"
    LET ls_toolbar  = ls_erp_path,ls_separator,"cfg",ls_separator,"4tb",ls_separator,"toolbar_adzi200_",ms_lang,".4tb" -- 20161021

    CALL adzi200_set_window_title()
    LET mo_window = ui.Window.getCurrent()
    LET mo_form = mo_window.getForm()

    DISPLAY cs_information_tag,"Load top menu : ",ls_top_menu
    CALL mo_form.loadTopMenu(ls_top_menu)
    CALL mo_form.loadToolBar(ls_toolbar) -- 20161021
    
    #CALL ui.Interface.loadStyles("adzi200")
    CALL sadzi200_util_set_form_style(ms_lang)
    CALL ui.Interface.loadActionDefaults("resource\\tiptop_0")
  &endif

  CALL ui.Dialog.setDefaultUnbuffered(TRUE)

  #disable at 20160323 by CircleLai Start ,改用介面多語系支援方式
  #LET ls_sql = "SELECT EJ.DZEJ005 DB_LIST,                ",
  #             "       EJ.DZEJ005 DB_LIST_NAME            ",
  #             "  FROM DZEJ_T EJ                          ",
  #             " WHERE EJ.DZEJ001 = 'adzi200_parameters'  ",
  #             "   AND EJ.DZEJ004 = 'MasterDB'            ",
  #             " UNION                                    ",
  #             "SELECT EJ.DZEJ007 DB_LIST,                ",
  #             "       EJ.DZEJ007 DB_LIST_NAME            ",
  #             "  FROM DZEJ_T EJ                          ",
  #             " WHERE EJ.DZEJ001 = 'adzi180_parameters'  ",
  #             "   AND EJ.DZEJ004 IN ('ERPDB','MDMDB')    ",
  #             " ORDER BY 1                               "
  #LET lo_combobox = ui.ComboBox.forName("formonly.ed_db_list")  #搜尋資料庫列表
  #CALL adzi200_fill_combobox(lo_combobox,ls_sql)
  #disable at 20160323 by CircleLai End 

  #生失效別
  LET ls_sql = "SELECT GZCB002                 STAT_TYPE,  ",
               "       GZCB002||'. '||GZCBL004 STAT_NAME   ",
               "  FROM GZCB_T CB                           ",
               "  LEFT OUTER JOIN GZCBL_T                  ",
               "               ON GZCB001  = GZCBL001      ",
               "              AND GZCB002  = GZCBL002      ",
               "              AND GZCBL003 = '",ms_lang,"' ",
               " WHERE CB.GZCB001 = 197                    ",
               " ORDER BY CB.GZCB012                       "
               
  LET lo_combobox = ui.ComboBox.forName("formonly.lbl_dziv005")
  CALL adzi200_fill_combobox(lo_combobox,ls_sql)
  LET lo_combobox = ui.ComboBox.forName("formonly.ed_dziv005")
  CALL adzi200_fill_combobox(lo_combobox,ls_sql)

  #資料庫別
  LET ls_sql = "SELECT GZCB002    DB_TYPE,                 ",
               "       GZCBL004   DB_NAME                  ",
               "  FROM GZCB_T CB                           ",
               "  LEFT OUTER JOIN GZCBL_T                  ",
               "               ON GZCB001  = GZCBL001      ",
               "              AND GZCB002  = GZCBL002      ",
               "              AND GZCBL003 = '",ms_lang,"' ",
               " WHERE CB.GZCB001 = 231                    ",
               " ORDER BY CB.GZCB012                       "
               
  LET lo_combobox = ui.ComboBox.forName("formonly.ed_dziv002")
  CALL adzi200_fill_combobox(lo_combobox,ls_sql)
  LET lo_combobox = ui.ComboBox.forName("formonly.ed_db_list")
  CALL adzi200_fill_combobox(lo_combobox,ls_sql)

  #標準客制轉換
  LET ls_sql = "SELECT GZCB002    WORK_TYPE,               ",
               "       GZCBL004   WORK_NAME                ",
               "  FROM GZCB_T CB                           ",
               "  LEFT OUTER JOIN GZCBL_T                  ",
               "               ON GZCB001  = GZCBL001      ",
               "              AND GZCB002  = GZCBL002      ",
               "              AND GZCBL003 = '",ms_lang,"' ",
               " WHERE CB.GZCB001 = 232                    ",
               " ORDER BY CB.GZCB012                       "
               
  LET lo_combobox = ui.ComboBox.forName("formonly.cbo_cust_std_transfer")
  CALL adzi200_fill_combobox(lo_combobox,ls_sql)

  #視觀表 Leading code
  LET ls_sql = "SELECT GZCB002    CODE_TYPE,               ",
               "       GZCB002    CODE_NAME                ",
               "  FROM GZCB_T CB                           ",
               "  LEFT OUTER JOIN GZCBL_T                  ",
               "               ON GZCB001  = GZCBL001      ",
               "              AND GZCB002  = GZCBL002      ",
               "              AND GZCBL003 = '",ms_lang,"' ",
               " WHERE CB.GZCB001 = 233                    ",
               " ORDER BY CB.GZCB012                       "
               
  LET lo_combobox = ui.ComboBox.forName("formonly.cbo_view_header")
  CALL adzi200_fill_combobox(lo_combobox,ls_sql)
  
END FUNCTION 

FUNCTION adzi200_start()
DEFINE
  lo_win             ui.Window,
  li_idx             INTEGER,
  ls_top_module_name STRING,
  ls_top_env         STRING,
  ls_user            STRING,
  ls_master_user     STRING,
  ls_os_separator    STRING,
  ls_separator       STRING,
  ls_view_name       STRING,
  ls_message         STRING, 
  --ls_owners_queue    STRING,
  ls_answer          STRING,
  ls_replace_arg     STRING,  --Jack Cheng 20160224
  ls_exe_item        STRING,  --Jack Cheng 20160224
  lb_kill_data       BOOLEAN,
  ls_program_name    STRING, --20160706
  ls_parameter       STRING, --20160706
  ls_about           STRING, --20160706
  lo_jsonobj         util.JSONObject,
  lo_dziv_t          T_DZIV_T_WL,
  lo_COMPRESS_FILE_INFO   T_COMPRESS_FILE_INFO,
  #ALM begin
  lo_DZLU_T          DYNAMIC ARRAY OF T_DZLU_T,
  lo_user_info       T_USER_INFO, -- 使用者資訊物件
  lo_dzlm_t          T_DZLM_T,
  lo_table_info      T_PROGRAM_INFO
  #ALM end
DEFINE
  lb_result  BOOLEAN

  LET ls_top_module_name = cs_top_module_name
  LET ls_top_env         = FGL_GETENV(ls_top_module_name)
  LET ls_user            = ms_user  
  LET ls_master_user     = mo_master_user.PARAMETER1
  LET lo_jsonobj         = util.JSONObject.create()

  LET ls_separator = os.Path.separator()

  #取得作業系統的分隔符號
  CALL os.Path.separator() RETURNING ls_os_separator
  
  DIALOG ATTRIBUTES(UNBUFFERED)
    #Table Lists  
    DISPLAY ARRAY m_dziv_t_h_scr TO sr_view_list.*
      BEFORE ROW 
        LET mi_dziv_h_index = ARR_CURR()
        LET ls_view_name = m_dziv_t_h_scr[mi_dziv_h_index].DZIV001
        CALL adzi200_refresh_detail(DIALOG,m_dziv_t_h_scr[mi_dziv_h_index].*)
        CALL adzi200_set_active_state(DIALOG,m_dziv_t_h_scr[mi_dziv_h_index].DZLM008)
        #顯示目前的簽出資訊  --Jack Cheng 20160115
        CALL adzi200_set_check_out_mode(DIALOG,m_dziv_t_h_scr[mi_dziv_h_index].*) 
    END DISPLAY

    #Table Columns
    {
    DISPLAY ARRAY m_dziv_t_b_scr TO sr_view_data.*
    END DISPLAY
    }
    
    INPUT m_dziv_t_b_scr.* FROM sr_view_data.* ATTRIBUTE(WITHOUT DEFAULTS)
    END INPUT    
    
    #輸入搜尋條件
    INPUT ms_search FROM ed_search ATTRIBUTE(WITHOUT DEFAULTS)
    END INPUT

    #資料庫搜尋
    INPUT ms_db_name FROM ed_db_list ATTRIBUTE(WITHOUT DEFAULTS)
      ON CHANGE ed_db_list
        CALL adzi200_refresh_master(DIALOG)
        LET mi_dziv_h_index = 1
        CALL DIALOG.setCurrentRow("sr_view_list",mi_dziv_h_index)
        CALL adzi200_set_active_state(DIALOG,m_dziv_t_h_scr[mi_dziv_h_index].DZLM008)
    END INPUT
  
    #標準轉客制...etc操作行為 --Jack Cheng 20160224
    INPUT ls_exe_item FROM cbo_cust_std_transfer ATTRIBUTE(WITHOUT DEFAULTS)
    END INPUT
    
    BEFORE DIALOG
      LET lo_win = ui.Window.getCurrent()
      LET mi_dziv_h_index = 1
      CALL lo_win.setImage("logo/dsc_logo.ico")
      CALL adzi200_fill_dziv_t_h()
      CALL DIALOG.setFieldActive("sr_view_data.*",FALSE)
      CALL adzi200_refresh_component_status(cs_browse_view)

    ON ACTION btn_view_detail  
      
    ON ACTION find_data
      CLEAR sr_view_list.* 
      LET mi_dziv_h_index = 1
      CALL adzi200_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_view_list",mi_dziv_h_index)
      CALL adzi200_set_active_state(DIALOG,m_dziv_t_h_scr[mi_dziv_h_index].DZLM008)
      NEXT FIELD lbl_dziv001 

    ON ACTION tbi_create_view #新增視觀表
      #ALM begin #先呼叫簽出
      CALL sadzi200_util_alm_check_out(mb_enable_alm,ms_user,ms_lang,cs_user_role_sd,FALSE) RETURNING lb_result,lo_USER_INFO.*,lo_DZLU_T
      #ALM end 
      IF lb_result THEN
        LET ms_alter_type = cs_create_view
        CALL adzi200_alter_view(m_dziv_t_b_scr.*,FALSE) RETURNING lb_result, lo_dziv_t.*
        IF lb_result THEN
          #ALM begin #新增表格資料成功, 則在 dzlm_t 中實際寫入註冊資料
          CALL sadzi200_util_set_alm_info(lo_dziv_t.DZIV001, cs_mdm_module_name, 
                                          lo_dziv_t.DZIVL005, cs_mdm_construct_type_view,
                                          cs_ver_type_sd, lo_DZLU_T) RETURNING lb_result, lo_dzlm_t.*
          IF NOT lb_result THEN 
            CALL sadzp000_msg_show_error(NULL,"adz-00726" ,NULL,0)
          END IF
          #ALM end
          
          #調整目前指向位置
          CALL adzi200_fill_dziv_t_h()
          FOR li_idx = 1 TO m_dziv_t_h_scr.getLength()
            IF (m_dziv_t_h_scr[li_idx].DZIV001 == lo_dziv_t.DZIV001 AND  m_dziv_t_h_scr[li_idx].DZIV002 == lo_dziv_t.DZIV002) THEN
              LET mi_dziv_h_index = li_idx
              EXIT FOR 
            END IF 
          END FOR  
          
        END IF
        CALL mo_form.setElementHidden("vbox_view_list",FALSE)
      END IF
      
      CALL adzi200_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_view_list",mi_dziv_h_index)
      CALL adzi200_set_active_state(DIALOG,m_dziv_t_h_scr[mi_dziv_h_index].DZLM008)
      CALL adzi200_refresh_component_status(cs_browse_view)

    ON ACTION MODIFY #更改
      LET ms_alter_type = cs_modify_view
      CALL adzi200_alter_view(m_dziv_t_b_scr.*,FALSE) RETURNING lb_result,lo_dziv_t.*
      CALL mo_form.setElementHidden("vbox_view_list",FALSE)
      CALL adzi200_refresh_master(DIALOG)
      CALL adzi200_refresh_component_status(cs_browse_view)
      
    ON ACTION tbi_modify_template #原本畫面就不存在此button
      LET ms_alter_type = cs_modify_template
      CALL adzi200_alter_view(m_dziv_t_b_scr.*,TRUE) RETURNING lb_result,lo_dziv_t.*
      CALL mo_form.setElementHidden("vbox_view_list",FALSE)
      CALL adzi200_refresh_master(DIALOG)
      CALL adzi200_refresh_component_status(cs_browse_view)
      
    ON ACTION tbi_drop_view
      LET ls_view_name = m_dziv_t_b_scr.DZIV001 
      IF ls_view_name.trim() IS NULL THEN
        CALL sadzp000_msg_show_error(NULL,"adz-00790" ,NULL,0)
        CONTINUE DIALOG  
      END IF
      
      CALL adzi200_prepare_dziv_t_data(m_dziv_t_b_scr.*) RETURNING lo_dziv_t.*

      CALL sadzp000_msg_get_message('adz-00731',ms_lang) RETURNING ls_replace_arg
      LET ls_answer = sadzi200_msg_question_box("adz-00731","dialog",ls_replace_arg,"question")  #adz-00731："是否一併刪除設定資料?"
      IF (ls_answer <> cs_response_cancel) THEN  
        IF ls_answer = cs_response_yes THEN
          LET lb_kill_data = TRUE  
        ELSE
          LET lb_kill_data = FALSE  
        END IF 
        
        #客制環境下刪除'客制的'設計資料，檢查是否"標準轉客制"的設計資料
        IF lb_kill_data AND (ms_dgenv == cs_dgenv_customize) 
           AND (lo_dziv_t.DZIV003 == cs_dgenv_customize) THEN
          LET lo_dziv_t.DZIV003 = cs_dgenv_standard
          IF (sadzi200_crud_check_if_dziv_t_exists(lo_dziv_t.*)) THEN #標準轉客制的資料執行'客制還原標準'
            LET lo_dziv_t.DZIV003 = cs_dgenv_customize
            CALL adzi200_customize_to_standard(DIALOG) RETURNING lb_result --客制還原標準
            CONTINUE DIALOG 
          END IF 
          LET lo_dziv_t.DZIV003 = cs_dgenv_customize
        END IF 
        
        CALL sadzi200_util_get_and_set_view_status(lo_dziv_t.*) RETURNING lb_result
        CALL sadzi200_util_drop_view(lo_dziv_t.*,lb_kill_data) RETURNING lb_result, ls_message
        
        IF lb_result THEN
          CALL sadzp000_msg_show_info(NULL,"adz-00894" ,NULL,0)
          LET mi_dziv_h_index = 1
        ELSE 
          CALL sadzp000_msg_show_error(NULL,"adz-00792" ,NULL,0)
          CALL sadzi200_log_view_logresult(ls_message)
        END IF  
        #更新view狀態
        CALL sadzi200_util_get_and_set_view_status(lo_dziv_t.*) RETURNING lb_result 
        
      ELSE # 放棄刪除作業 
        #do nothing
      END IF 
      
      CALL adzi200_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_view_list",mi_dziv_h_index)
      CALL adzi200_set_active_state(DIALOG,m_dziv_t_h_scr[mi_dziv_h_index].DZLM008)
      CALL adzi200_refresh_component_status(cs_browse_view)

    ON ACTION tbi_build_view #執行建構
      CALL adzi200_prepare_dziv_t_data(m_dziv_t_b_scr.*) RETURNING lo_dziv_t.*
      CALL adzi200_build_view(lo_dziv_t.*, TRUE) RETURNING lb_result
      CALL adzi200_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_view_list",mi_dziv_h_index)

    #ALM begin
    ON ACTION btn_check_out  
      #先呼叫簽出
      CALL sadzi200_util_alm_check_out(mb_enable_alm,ms_user,ms_lang,cs_user_role_sd,FALSE) RETURNING lb_result,lo_USER_INFO.*,lo_DZLU_T
      IF lb_result THEN
        #在 dzlm_t 中實際寫入註冊資料 
        CALL sadzi200_util_set_alm_info(m_dziv_t_b_scr.DZIV001,cs_mdm_module_name,m_dziv_t_b_scr.DZIVL005,cs_mdm_construct_type_view,cs_ver_type_sd,lo_DZLU_T) RETURNING lb_result,lo_dzlm_t.*
        IF lb_result THEN
          CALL sadzp000_msg_show_info(NULL,"adz-00796" ,NULL,0)
        ELSE
          CALL sadzp000_msg_show_error(NULL,"adz-00797" ,NULL,0)
        END IF
        
      END IF
      
      CALL adzi200_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_view_list",mi_dziv_h_index)
      CALL adzi200_set_active_state(DIALOG,m_dziv_t_h_scr[mi_dziv_h_index].DZLM008)
      
    ON ACTION btn_recall   
      CALL adzi200_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_view_list",mi_dziv_h_index)
      CALL adzi200_set_active_state(DIALOG,m_dziv_t_h_scr[mi_dziv_h_index].DZLM008)

    ON ACTION btn_release
      GOTO _CHECK_IN
    ON ACTION btn_check_in
      LABEL _CHECK_IN:  
      #取得現今DZLM的資料
      LET lo_table_info.pi_NAME   = m_dziv_t_b_scr.DZIV001
      LET lo_table_info.pi_MODULE = cs_mdm_module_name
      LET lo_table_info.pi_DESC   = m_dziv_t_b_scr.DZIVL005
      LET lo_table_info.pi_TYPE   = cs_mdm_construct_type_view
      CALL sadzi200_util_alm_check_in(lo_table_info.*,cs_ver_type_sd) RETURNING lb_result
      IF lb_result THEN
        CALL sadzp000_msg_show_info(NULL,"adz-00777" ,NULL,0)
      ELSE 
        CALL sadzp000_msg_show_error(NULL,"adz-00778" ,NULL,0)
      END IF
      CALL adzi200_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_view_list",mi_dziv_h_index)
      CALL adzi200_set_active_state(DIALOG,m_dziv_t_h_scr[mi_dziv_h_index].DZLM008)
    #ALM end
  
    ON ACTION btn_exe_act #標準、客制轉換  --Jack Cheng 20160224
      IF (ls_exe_item.trim() IS NULL) THEN #未選擇動作
        CALL sadzp000_msg_show_info(NULL,"adz-00564" ,NULL,0)
        CONTINUE DIALOG
      ELSE
        #DISPLAY "ls_exe_item = ", ls_exe_item,""
        CASE ls_exe_item
          WHEN "1"  #標準轉客制 
            CALL adzi200_standard_to_customize(DIALOG) RETURNING lb_result
          WHEN "2"  #客制還原標準
            CALL adzi200_customize_to_standard(DIALOG) RETURNING lb_result
        END CASE 
      END IF

    #20160706 TOP Menu start  
    ON ACTION tm_export
      LET ls_view_name = m_dziv_t_b_scr.DZIV001
      LET ls_program_name = 'adzp310'
      LET ls_parameter = "r.r ",ls_program_name," -SD -WT iexp -CT MV -WO ",ls_view_name
      &ifndef DEBUG
      IF sadzi200_util_check_program_exists(ls_program_name) THEN
        CALL cl_cmdrun_openpipe("r.r",ls_parameter,FALSE) RETURNING lb_result,ls_message
      END IF
      &endif

    ON ACTION tm_import
      LET ls_view_name = m_dziv_t_b_scr.DZIV001
      LET ls_program_name = 'adzp310'
      LET ls_parameter = "r.r ",ls_program_name," -SD -WT iimp -MA"
      &ifndef DEBUG
      IF sadzi200_util_check_program_exists(ls_program_name) THEN
        CALL cl_cmdrun_openpipe("r.r",ls_parameter,FALSE) RETURNING lb_result,ls_message
      END IF
      CALL adzi200_refresh_master(DIALOG)
      CALL DIALOG.setCurrentRow("sr_view_list",mi_dziv_h_index)
      CALL adzi200_set_active_state(DIALOG,m_dziv_t_h_scr[mi_dziv_h_index].DZLM008)
      &endif

    ON ACTION tm_about
      LET ls_about = adzi200_get_system_information(FALSE)
      #About
      MENU 'About' ATTRIBUTE (STYLE="dialog", COMMENT=ls_about.trim() CLIPPED, IMAGE="information")
        ON ACTION ok
          EXIT MENU
      END MENU
      
    #20160706 TOP Menu end
    
    ON ACTION EXIT
      LET INT_FLAG=FALSE         
      EXIT DIALOG  
      
    ON ACTION CLOSE    
      LET INT_FLAG=FALSE         
      EXIT DIALOG

    CONTINUE DIALOG  

  END DIALOG

END FUNCTION

FUNCTION adzi200_finalize(p_value)
DEFINE
  p_value BOOLEAN

  IF p_value THEN
    EXIT PROGRAM
  ELSE
    EXIT PROGRAM -1
  END IF 
  
END FUNCTION

FUNCTION adzi200_set_window_title()
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
  
  CALL sadzi200_db_get_db_info() RETURNING lo_db_info.*
  CALL sadzi200_util_get_program_title('adzi200',ms_lang) RETURNING ls_program_title
  
  LET ls_zone = NVL(ls_zone,ls_user_domain)
  LET ls_user = NVL(ms_user,ls_user)

  LET ls_window_title = NVL(ls_program_title,cs_program_title)," [ Zone：",ls_zone," ] [ User：",ls_user," ] [DB Name：",lo_db_info.DB_NAME,"] [DB User：",lo_db_info.USER_NAME,"] [ Login Time：",CURRENT YEAR TO SECOND," ]"

  CALL FGL_SETTITLE(ls_window_title)

END FUNCTION

################################################################################
# Descriptions...: 從資料庫取得資料更新畫面主列表內容
# Memo...........: 將資料塞入 m_dziv_t_h_scr array
# Usage..........: CALL adzi200_fill_dziv_t_h()
# Input parameter: ms_search  搜尋關鍵字
# Return code....: none
# Date & Author..: 
# Modify.........: 20160315 by CircleLai
################################################################################
FUNCTION adzi200_fill_dziv_t_h() 
DEFINE 
  ls_sql          STRING,
  ls_sql_cond     STRING,
  ls_sql_db_name  STRING,
  ls_str1         STRING,
  li_count        INTEGER

  IF (ms_db_name IS NOT NULL) THEN
    #IF (ms_db_name == cs_alias_aws_db OR ms_db_name == cs_alias_erp_db) THEN
    #  CALL sadzi200_dtas_decode_columns(ms_db_name) RETURNING ls_str1
    #  LET ls_sql_db_name = " AND IV.DZIV002 in (", ls_str1, ", '", ms_db_name, "')"
    #ELSE 
      LET ls_sql_db_name = " AND IV.DZIV002 = '",ms_db_name,"'"
    #END IF
  ELSE 
    #ver 160525.01
    LET ls_sql_db_name = " AND IV.DZIV002 in ('",cs_alias_aws_db,"', '", cs_alias_erp_db ,"')"
  END IF 
  
  IF (ms_search IS NULL) OR (ms_search = "*") THEN
    LET ls_sql_cond = ""
  ELSE
    LET ls_sql_cond = " AND (IV.DZIV001 LIKE '%",ms_search.toLowerCase(),"%' ",
                      "  OR IV.DZIV002 LIKE '%",ms_search,"%'                ",
                      "  OR IV.DZIV003 LIKE '%",ms_search,"%')               "
  END IF 

  LET ls_sql = "SELECT DISTINCT '' RECORD_TYPE, '' SEQ_NO,                                              ",
               "       IV.DZIV001,IV.DZIV002,IV.DZIV003,IV.DZIV005,IVL.DZIVL005,                        ",
               "       LM.DZLM008,LM.DZLM007,AG.OOAG011,IV.DZIV006                                      ", --Jack Cheng 20160115
               "  FROM DZIV_T IV                                                                        ",
               " INNER JOIN (                                                                           ", #20160706 ernest begin
               "              SELECT IV0.DZIV001,IV0.DZIV002,MIN(IV0.DZIV003) DZIV003                   ",
               "                FROM DZIV_T IV0                                                         ",
               "               GROUP BY DZIV001,DZIV002                                                 ",
               "            ) IV2 ON IV.DZIV001 = IV2.DZIV001                                           ",
               "                 AND IV.DZIV002 = IV2.DZIV002                                           ",
               "                 AND IV.DZIV003 = IV2.DZIV003                                           ", #20160706 ernest end
               #20160706 ernest mark begin
               { 
               " INNER JOIN (                                                                           ",
               "              SELECT DISTINCT DZIV001,DZIV002,                                          ", #如同時存在標準與客制，只顯示客制 --Jack Cheng 20160224 
               "                     CASE WHEN EXISTS (                                                 ",  
               "                                        SELECT 1                                        ",                            
               "                                          FROM DZIV_T IV2                               ",                            
               "                                         WHERE IV2.DZIV001 = IV1.DZIV001                ",                            
               "                                           AND IV2.DZIV002 = IV1.DZIV002                ",                            
               "                                           AND IV2.DZIV003 = '", cs_dgenv_customize, "' ",                            
               "                                      )                                                 ",  
               "                     THEN '", cs_dgenv_customize, "'                                    ",  
               "                     ELSE '", cs_dgenv_standard, "'                                     ",  
               "                     END AS DZIV003                                                     ",  
               "                FROM (                                                                  ",  
               "                      SELECT IV0.DZIV001, IV0.DZIV002, IV0.DZIV003                      ",          
               "                        FROM DZIV_T IV0                                                 ",          
               "                     ) IV1                                                              ",  
               "            ) IV2 ON IV.DZIV001 = IV2.DZIV001                                           ",
               "                 AND IV.DZIV002 = IV2.DZIV002                                           ",
               "                 AND IV.DZIV003 = IV2.DZIV003                                           ",
               } 
               #20160706 ernest mark end
               "  LEFT OUTER JOIN DZIVL_T IVL ON IVL.DZIVL001 = IV.DZIV001                              ", #多語系支援
               "                             AND IVL.DZIVL002 = IV.DZIV002                              ",
               "                             AND IVL.DZIVL003 = IV.DZIV003                              ",
               "                             AND IVL.DZIVL004 = '",ms_lang,"'                           ",
               "  LEFT OUTER JOIN DZLM_T LM ON LM.DZLM001 = '",cs_mdm_construct_type_view,"'            ",
               "                           AND LM.DZLM002 = IV.DZIV001                                  ",
               "                           AND LM.DZLM008 = '",cs_check_out,"'                          ",
               "  LEFT OUTER JOIN (                                                                     ",
               "                    SELECT XA.GZXA001,AG.OOAG011                                        ", # Jack Cheng 20160115 start  
               "                      FROM DSDEMO.OOAG_T AG,                                            ", # 簽出者資料                    
               "                           DSDEMO.GZXA_T XA                                             ",    
               "                     WHERE XA.GZXAENT = AG.OOAGENT                                      ",    
               "                       AND AG.OOAG001 = XA.GZXA003                                      ",    
               "                       AND XA.GZXAENT = '",ms_enterprise,"'                             ",    
               "                     GROUP BY XA.GZXA001,AG.OOAG011                                     ",    
               "                     ORDER BY XA.GZXA001                                                ",    
               "                  ) AG ON AG.GZXA001 = LM.DZLM007                                       ", # Jack Cheng 20160115 end    
               " WHERE 1=1                                                                              ",
               "   AND IV.DZIV002 <> '",cs_template_words,"'                                            ",
               ls_sql_cond,                                                                            
               ls_sql_db_name,                                                                         
               " ORDER BY IV.DZIV002,IV.DZIV001                                                         "
                  
  PREPARE lpre_fill_dziv_t_h FROM ls_sql
  DECLARE lcur_fill_dziv_t_h CURSOR FOR lpre_fill_dziv_t_h

  CALL m_dziv_t_h_scr.clear()
  
  LET li_count = 1
  
  FOREACH lcur_fill_dziv_t_h INTO m_dziv_t_h_scr[li_count].*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET m_dziv_t_h_scr[li_count].DZIVSEQ = li_count 
    LET li_count = li_count + 1
  END FOREACH
  
  CALL m_dziv_t_h_scr.deleteElement(li_count)

END FUNCTION

FUNCTION adzi200_refresh_detail(p_dialog,p_dziv_t_h_scr)
DEFINE 
  p_dialog       ui.Dialog,
  p_dziv_t_h_scr T_DZIV_T_H_SCR
DEFINE
  lo_dziv_t_h_scr T_DZIV_T_H_SCR,
  lo_dziv_t_b_scr T_DZIV_T_B_SCR,  --Jack Cheng 20160224
  ls_current_item STRING

  LET lo_dziv_t_h_scr.* = p_dziv_t_h_scr.*
  LET ls_current_item = p_dialog.getCurrentItem()
  
  CALL adzi200_fill_dziv_t_b(lo_dziv_t_h_scr.*) RETURNING lo_dziv_t_b_scr.*  --Jack Cheng 20160224
  
END FUNCTION

################################################################################
# Descriptions...: 從資料庫取得設計資料詳細內容
# Memo...........: 單身
# Usage..........: CALL adzi200_fill_dziv_t_b(p_dziv_t_h_scr) RETURNING lo_return
# Input parameter: p_dziv_t_h_scr  單頭資料
#                : 
# Return code....: lo_return  回傳單身資料
#                : 
# Date & Author..: 
# Modify.........: 20160315 by CircleLai
################################################################################
FUNCTION adzi200_fill_dziv_t_b(p_dziv_t_h_scr)
DEFINE
  p_dziv_t_h_scr   T_DZIV_T_H_SCR
DEFINE 
  lo_dziv_t_h_scr  T_DZIV_T_H_SCR,
  ls_dziv004       STRING, -- 20160706
  lo_view_contents T_VIEW_CONTENTS, -- 20160706
  ls_sql           STRING
DEFINE
  lo_return        T_DZIV_T_B_SCR  --Jack Cheng 20160224
  
  LET lo_dziv_t_h_scr.* = p_dziv_t_h_scr.*
  
  INITIALIZE lo_return TO NULL      --Jack Cheng 20160224

  LET ls_sql = "SELECT IV.DZIV001,IV.DZIV002,IV.DZIV003,IV.DZIV004,IV.DZIV005,   ",
               "       IVL.DZIVL005,IVL.DZIVL006,                                ", 
               "       IV.DZIVCRTID,IV.DZIVCRTDT,IV.DZIVMODID,IV.DZIVMODDT,      ", #20160706 ernest
               "       '' DZIVCRTIDDESC,'' DZIVMODIDDESC,                        ", #20160706 ernest
               "       '' HEAD,'' BODY,'' TAIL, '' SYNTAX                        ", #20160706 ernest
               "  FROM DZIV_T IV                                                 ",
               "  LEFT OUTER JOIN DZIVL_T IVL ON IVL.DZIVL001 = IV.DZIV001       ",
               "                             AND IVL.DZIVL002 = IV.DZIV002       ",
               "                             AND IVL.DZIVL003 = IV.DZIV003       ",
               "                             AND IVL.DZIVL004 = '",ms_lang,"'    ", 
               " WHERE 1=1                                                       ",
               "   AND IV.DZIV001 = '",lo_dziv_t_h_scr.DZIV001,"'                ",
               "   AND IV.DZIV002 = '",lo_dziv_t_h_scr.DZIV002,"'                ",
               "   AND IV.DZIV003 = '",lo_dziv_t_h_scr.DZIV003,"'                ",
               " ORDER BY IV.DZIV003,IV.DZIV002,IV.DZIV001                       "
               
  INITIALIZE m_dziv_t_b_scr TO NULL
  
  PREPARE lpre_fill_dziv_t_b FROM ls_sql
  DECLARE lcur_fill_dziv_t_b CURSOR FOR lpre_fill_dziv_t_b
  LOCATE m_dziv_t_b_scr.DZIV004 IN FILE
  OPEN lcur_fill_dziv_t_b
  FETCH lcur_fill_dziv_t_b INTO m_dziv_t_b_scr.*
  #20160706 ernest begin
  &ifndef DEBUG
  LET m_dziv_t_b_scr.DZIVCRTIDDESC = cl_get_username(m_dziv_t_b_scr.DZIVCRTID)
  LET m_dziv_t_b_scr.DZIVMODIDDESC = cl_get_username(m_dziv_t_b_scr.DZIVMODID)
  &endif
  LET ls_dziv004 = m_dziv_t_b_scr.DZIV004
  CALL adzi200_separate_view_contents(ls_dziv004) RETURNING lo_view_contents.*
  LET m_dziv_t_b_scr.vns_SYNTAX = lo_view_contents.vc_HEAD
  LET m_dziv_t_b_scr.DZIV004    = lo_view_contents.vc_BODY
  #20160706 ernest end
  CLOSE lpre_fill_dziv_t_b
  CLOSE lcur_fill_dziv_t_b
  
  LET lo_return.* = m_dziv_t_b_scr.*  --Jack Cheng 20160224
  
  RETURN lo_return.*                  --Jack Cheng 20160224
  
END FUNCTION

FUNCTION adzi200_refresh_master(p_dialog)
DEFINE 
  p_dialog      ui.Dialog
DEFINE
  lo_combobox    ui.ComboBox,
  ls_module_name STRING

  INITIALIZE m_dziv_t_h_scr TO NULL
  INITIALIZE m_dziv_t_b_scr TO NULL

  LET lo_combobox = ui.ComboBox.forName("formonly.cb_moduleselect")

  CALL adzi200_fill_dziv_t_h()
  CALL adzi200_refresh_detail(p_dialog,m_dziv_t_h_scr[mi_dziv_h_index].*)
  CALL adzi200_set_check_out_mode(p_dialog,m_dziv_t_h_scr[mi_dziv_h_index].*) #顯示目前的簽出資訊  --Jack Cheng 20160115
  
END FUNCTION

################################################################################
# Descriptions...: 新增或修改視觀表控制介面
# Memo...........: 
# Usage..........: CALL adzi200_alter_view(m_dziv_t_b_scr.*,FALSE) RETURNING lb_result, lo_dziv_t.*
# Input parameter: p_dziv_t_b_scr  視觀表資料
#                : p_is_template   是否是樣板，
# Return code....: lb_return  確定=true, 放棄=false
#                : lo_return  視觀表資料
# Date & Author..: 
# Modify.........: 20160325 by CircleLai
################################################################################
FUNCTION adzi200_alter_view(p_dziv_t_b_scr,p_is_template)
DEFINE
  p_dziv_t_b_scr T_DZIV_T_B_SCR,
  p_is_template  BOOLEAN 
DEFINE
  lo_dziv_t_b_scr T_DZIV_T_B_SCR,
  lb_is_template  BOOLEAN, 
  lo_dziv_t       T_DZIV_T_WL,
  lo_left_array   DYNAMIC ARRAY OF T_COLUMN_LIST,
  lo_right_array  DYNAMIC ARRAY OF T_COLUMN_LIST,
  lo_coxn_info    DYNAMIC ARRAY OF T_DB_COXN_STR,
  lo_strbuf       base.StringBuffer,
  lc_msg          VARCHAR(1024),
  lc_lang         VARCHAR (6),
  ls_view_name    STRING,
  ls_datas        STRING,
  ls_old_datas    STRING,
  ls_datas_queue  STRING,
  li_idx          INTEGER,
  li_idx2         INTEGER,
  lb_modify_mode  BOOLEAN,
  lb_result       BOOLEAN,
  li_loop         INTEGER, --20160706
  ls_view_char    VARCHAR(1), --20160706
  lb_info_hidden  BOOLEAN, --20160706
  li_cusr_pos     INTEGER, --20160706
  ls_replace_arg  STRING, --20160706
  ls_topind       STRING, --20160706
  ls_dgenv        STRING, --20160706
  ls_old_head     STRING, --20160706
  ls_dziv004_before   STRING, --20160706
  ls_dziv004_after    STRING, --20160706
  ls_msg              STRING, --20160706
  ls_cmpnd_str        STRING  --20160706
DEFINE
  lb_return  BOOLEAN,  
  lo_return  T_DZIV_T_WL

  LET lo_strbuf = base.StringBuffer.create()
  LET lc_lang   = ms_lang
  LET lb_is_template = p_is_template

  LET mb_dziv004_modified = FALSE
  LET lb_info_hidden = FALSE
  
  INITIALIZE lo_dziv_t_b_scr TO NULL
  LOCATE lo_dziv_t_b_scr.DZIV004 IN FILE
  
  DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)  #'FIELD ORDER FORM' 修改欄位index的順序  --Jack Cheng 20160107 
    
    INPUT lo_dziv_t_b_scr.* FROM sr_view_data.* ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE INPUT
        LET ls_old_head = lo_dziv_t_b_scr.vns_HEAD --20160706  
        #修改模式下需要將Key欄位設為不可使用
        LET lb_modify_mode = IIF(((ms_alter_type == cs_modify_view) OR (ms_alter_type == cs_modify_template)),FALSE,TRUE)
        IF ms_alter_type == cs_modify_view THEN 
          LET lo_dziv_t_b_scr.* = p_dziv_t_b_scr.*
        END IF 

        CALL DIALOG.setFieldActive("ed_dziv002",lb_modify_mode)
        CALL adzi200_refresh_syntax_toolbar(DIALOG,FALSE)

      #20160706 begin
      ON CHANGE ed_dziv002
        #依照選擇資料庫型態, 預設一下View Head
        CASE 
          WHEN lo_dziv_t_b_scr.DZIV002 = cs_alias_erp_db
            LET lo_dziv_t_b_scr.vns_HEAD = cs_view_head_code_erp
          WHEN lo_dziv_t_b_scr.DZIV002 = cs_alias_aws_db
            LET lo_dziv_t_b_scr.vns_HEAD = cs_view_head_code_all
        END CASE
        CALL adzi200_refresh_view_name(lo_dziv_t_b_scr.*) RETURNING ls_view_name,lo_dziv_t_b_scr.vns_SYNTAX
        LET lo_dziv_t_b_scr.DZIV001 = ls_view_name
      #20160706 end

      ON ACTION btn_regen_script #重產視觀表基礎語法
        CALL adzi200_prepare_dziv_t_data(lo_dziv_t_b_scr.*) RETURNING lo_dziv_t.*
        CALL sadzi200_db_gen_view_scripts(lo_dziv_t.*) RETURNING lo_dziv_t.*
        LET lo_dziv_t_b_scr.DZIV004 = lo_dziv_t.DZIV004

      #20160706 begin
      ON ACTION btn_test_script #測試語法
        CALL adzi200_prepare_dziv_t_data(lo_dziv_t_b_scr.*) RETURNING lo_dziv_t.*
        CALL sadzi200_util_test_view(lo_dziv_t.*) RETURNING lb_result, ls_msg   
        IF lb_result THEN 
          CALL sadzp000_msg_show_info(NULL,"adz-00889" ,NULL,0)
        ELSE
          #執行測試失敗
          CALL sadzp000_msg_show_error(NULL,"adz-00890" ,NULL,0)
          CALL sadzi200_log_view_logresult(ls_msg)
        END IF
      
      ON ACTION btn_hide_info
        LET lb_info_hidden = NOT lb_info_hidden
        CALL mo_form.setElementHidden("grid_basic_info", lb_info_hidden) 
        CALL mo_form.setElementText("btn_hide_info",IIF(lb_info_hidden,"︾","︽"))  

      ON CHANGE cbo_view_header
        #如果資料庫型態不是 ERP, 則 View Head 不能選 _erp
        IF lo_dziv_t_b_scr.DZIV002 <> cs_alias_erp_db AND lo_dziv_t_b_scr.vns_HEAD = cs_view_head_code_erp THEN
          LET lo_dziv_t_b_scr.vns_HEAD = cs_view_head_code_all
        END IF
        #如果資料庫型態是 ERP, 則 View Head 只能選 _erp
        IF lo_dziv_t_b_scr.DZIV002 = cs_alias_erp_db AND lo_dziv_t_b_scr.vns_HEAD <> cs_view_head_code_erp THEN
          LET lo_dziv_t_b_scr.vns_HEAD = cs_view_head_code_erp
        END IF
        GOTO _ED_VIEW_BODY
      AFTER FIELD ed_view_body  
        GOTO _ED_VIEW_BODY
      ON CHANGE ed_view_body
        LABEL _ED_VIEW_BODY:
        CALL adzi200_refresh_view_name(lo_dziv_t_b_scr.*) RETURNING ls_view_name,lo_dziv_t_b_scr.vns_SYNTAX
        LET lo_dziv_t_b_scr.DZIV001 = ls_view_name
        IF lo_dziv_t_b_scr.vns_BODY IS NOT NULL THEN 
          CALL adzi200_check_view_name_valid(ls_view_name) RETURNING lb_result
          IF NOT lb_result THEN
            NEXT FIELD ed_view_body 
          END IF
        END IF          

      BEFORE FIELD ed_dziv004
        CALL adzi200_refresh_syntax_toolbar(DIALOG,TRUE)
        LET mb_dziv004_modified = FALSE 
        LET ls_dziv004_before = lo_dziv_t_b_scr.DZIV004

      AFTER FIELD ed_dziv004  
        CALL adzi200_refresh_syntax_toolbar(DIALOG,FALSE)
        LET ls_dziv004_after = lo_dziv_t_b_scr.DZIV004
        IF ls_dziv004_before <> ls_dziv004_after THEN
          LET mb_dziv004_modified = TRUE 
        END IF

      ## DB Page begin  
      #在編輯內容附加上{ERPDB}  
      ON ACTION btn_db_erpdb
        LET ls_cmpnd_str = cs_identify_erp_db,cs_sql_dot
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,ls_cmpnd_str) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+ls_cmpnd_str.getLength())    
        
      #在編輯內容附加上{AWSDB}  
      ON ACTION btn_db_awsdb
        LET ls_cmpnd_str = cs_identify_aws_db,cs_sql_dot
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,ls_cmpnd_str) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+ls_cmpnd_str.getLength())    
        
      #在編輯內容附加上DS
      ON ACTION btn_db_ds
        LET ls_cmpnd_str = cs_db_name_ds,cs_sql_dot
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,ls_cmpnd_str) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+ls_cmpnd_str.getLength())
        
      #在編輯內容附加上DSDEMO
      ON ACTION btn_db_dsdemo
        LET ls_cmpnd_str = cs_db_name_dsdemo,cs_sql_dot
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,ls_cmpnd_str) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+ls_cmpnd_str.getLength())
        
      #在編輯內容附加上DSDATA
      ON ACTION btn_db_dsdata
        LET ls_cmpnd_str = cs_db_name_dsdata,cs_sql_dot
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,ls_cmpnd_str) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+ls_cmpnd_str.getLength())
        
      #在編輯內容附加上DSAWS
      ON ACTION btn_db_dsaws
        LET ls_cmpnd_str = cs_db_name_dsaws,cs_sql_dot
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,ls_cmpnd_str) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+ls_cmpnd_str.getLength())
        
      #在編輯內容附加上DSAWST
      ON ACTION btn_db_dsawst
        LET ls_cmpnd_str = cs_db_name_dsawst,cs_sql_dot
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,ls_cmpnd_str) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+ls_cmpnd_str.getLength())
      ## DB Page end

      ## Base Syntax Page begin  
      #在編輯內容附加上{SELECT ... FROM}  
      ON ACTION btn_sql_base_select
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_select) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_select.getLength())
        
      ON ACTION btn_sql_base_distinct
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_distinct) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_distinct.getLength())
        
      ON ACTION btn_sql_base_from
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_from) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_from.getLength())
        
      ON ACTION btn_sql_base_where
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_where) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_where.getLength())
        
      ON ACTION btn_sql_base_and
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_and) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_and.getLength())

      ON ACTION btn_sql_base_or
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_or) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_or.getLength())

      ON ACTION btn_sql_base_not
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_not) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_not.getLength())

      ON ACTION btn_sql_base_in
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_in) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_in.getLength())
        
      ON ACTION btn_sql_base_between
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_between) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_between.getLength())
        
      ON ACTION btn_sql_base_like
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_like) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_like.getLength())
        
      ON ACTION btn_sql_base_exists
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_exists) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_exists.getLength())
        
      ON ACTION btn_sql_base_order_by
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_order_by) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_order_by.getLength())
        
      ON ACTION btn_sql_base_group_by
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_group_by) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_group_by.getLength())
        
      ON ACTION btn_sql_base_union
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_union) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_union.getLength())
        
      ON ACTION btn_sql_base_having
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_base_having) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_having.getLength())
        
      ## Base Syntax Page end
      
      ## Compound Syntax Page begin  
      #在編輯內容附加上{SELECT ... FROM}  
      ON ACTION btn_sql_cmpnd_select_from
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_cmpnd_select_from) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_base_select.getLength())
        
      ON ACTION btn_sql_cmpnd_inner_join
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_cmpnd_inner_join) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_cmpnd_inner_join.getLength())

      ON ACTION btn_sql_cmpnd_left_outer_join
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_cmpnd_left_outer_join) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_cmpnd_left_outer_join.getLength())
        
      ON ACTION btn_sql_cmpnd_on
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,cs_sql_cmpnd_on) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+cs_sql_cmpnd_on.getLength())
        
      ON ACTION btn_sql_cmpnd_where_exists
        LET ls_cmpnd_str = cs_sql_cmpnd_where_exists,cs_sql_open_paren," ",cs_sql_close_paren
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,ls_cmpnd_str) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+ls_cmpnd_str.getLength() - cs_sql_close_paren.getLength() - 1)
        
      ON ACTION btn_sql_cmpnd_where_not_exists
        LET ls_cmpnd_str = cs_sql_cmpnd_where_not_exists,cs_sql_open_paren," ",cs_sql_close_paren
        CALL adzi200_refresh_editor_text(lo_dziv_t_b_scr.*,ls_cmpnd_str) RETURNING li_cusr_pos
        CALL FGL_DIALOG_SETCURSOR(li_cusr_pos+ls_cmpnd_str.getLength() - cs_sql_close_paren.getLength() - 1)
        
      ## Compound Syntax Page end
        
      #20160706 end
        
    END INPUT

    BEFORE DIALOG
      #20160706 begin
      CASE 
        WHEN ms_alter_type == cs_create_view
          CALL adzi200_refresh_component_status(ms_alter_type)
          LET ls_topind = ms_topind
          LET ls_dgenv  = ms_dgenv
          LET lo_dziv_t_b_scr.DZIV002 = cs_alias_erp_db
          LET lo_dziv_t_b_scr.vns_HEAD = cs_view_head_code_erp
          CASE 
            #是客制, 那就是統一為 "uc_v"
            WHEN ls_dgenv = cs_dgenv_customize
              LET lo_dziv_t_b_scr.vns_TAIL = cs_view_user_customize,cs_view_tail_code
            #在標準環境下, topind <> sd, 則冠上行業別再加上_v
            WHEN ls_dgenv = cs_dgenv_standard
              CASE
                WHEN ls_topind <> cs_topind_standard
                  LET lo_dziv_t_b_scr.vns_TAIL = ls_topind,cs_view_tail_code
                WHEN ls_topind = cs_topind_standard
                  LET lo_dziv_t_b_scr.vns_TAIL = cs_view_tail_code 
              END CASE 
          END CASE
        WHEN ms_alter_type == cs_modify_view
          CALL adzi200_refresh_component_status(ms_alter_type)
      END CASE 
      #20160706 end
      
      IF lb_is_template THEN
        CALL adzi200_prepare_dziv_t_data(p_dziv_t_b_scr.*) RETURNING lo_dziv_t.*
        CALL sadzi200_db_load_template_data(lo_dziv_t.*,ms_lang) RETURNING lo_dziv_t.*
        CALL adzi200_refresh_dziv_t_scr_data(lo_dziv_t.*) RETURNING lo_dziv_t_b_scr.*
        NEXT FIELD ed_dziv008
      END IF

    AFTER DIALOG
      CALL mo_form.setElementText("btn_hide_info","︽")  
      
    ON ACTION ACCEPT
      IF (ms_alter_type == cs_create_view) THEN
        #檢核View功能名稱是否空白
        IF sadzi200_util_trim_str(lo_dziv_t_b_scr.vns_BODY) IS NULL THEN 
          CALL sadzp000_msg_show_error(NULL,"adz-00893" ,NULL,0)
          NEXT FIELD ed_view_body 
        END IF
        #檢核View名稱相關限制
        CALL adzi200_check_view_name_valid(lo_dziv_t_b_scr.DZIV001) RETURNING lb_result
        IF NOT lb_result THEN 
          NEXT FIELD ed_view_body 
        END IF
      END IF  
      
      LET ls_dziv004_after = lo_dziv_t_b_scr.DZIV004
      IF ls_dziv004_before <> ls_dziv004_after THEN
        LET mb_dziv004_modified = TRUE 
      END IF
      CALL adzi200_prepare_dziv_t_data(lo_dziv_t_b_scr.*) RETURNING lo_dziv_t.*
      CALL sadzi200_crud_set_view_data(lo_dziv_t.*, ms_alter_type, ms_lang, ms_dgenv) RETURNING lb_result
      CALL sadzi200_util_get_and_set_view_status(lo_dziv_t.*) RETURNING lb_result
      
      #是否執行建構
      CALL adzi200_build_view(lo_dziv_t.*, TRUE) RETURNING lb_result
      
      LET lb_result = TRUE
      LET lo_return.* = lo_dziv_t.*
      ACCEPT DIALOG
      
    ON ACTION CANCEL  
      LET lb_result = FALSE
      ACCEPT DIALOG 
    
  END DIALOG  

  LET lb_return = lb_result
  
  RETURN lb_return,lo_return.*
  
END FUNCTION

FUNCTION adzi200_prepare_dziv_t_data(p_dziv_t_scr)
DEFINE
  p_dziv_t_scr T_DZIV_T_B_SCR
DEFINE
  lo_dziv_t       T_DZIV_T_WL,
  ls_dziv004      STRING,
  ls_buffer       STRING,
  li_select_index INTEGER,
  ls_syntax       VARCHAR(1024),
  lo_strbuf       base.StringBuffer

  LET lo_strbuf = base.StringBuffer.create()

  --20160706 begin
  LET ls_syntax = sadzi200_util_trim_str(p_dziv_t_scr.vns_SYNTAX)

  IF ls_syntax IS NULL THEN 
    LET ls_dziv004 = p_dziv_t_scr.DZIV004
  ELSE
    LET ls_dziv004 = p_dziv_t_scr.DZIV004
    LET ls_buffer = ls_dziv004.toUpperCase()
    LET li_select_index = ls_buffer.getIndexOf("SELECT ",1)
    LET ls_dziv004 = ls_dziv004.subString(li_select_index,ls_dziv004.getLength())
    
    CALL lo_strbuf.clear()
    CALL lo_strbuf.append(ls_dziv004)
    CALL lo_strbuf.replace(cs_sql_exe_sign,"",0)

    LET ls_dziv004 = lo_strbuf.toString()
    
    LET ls_dziv004 = p_dziv_t_scr.vns_SYNTAX," ",
                     ls_dziv004
  END IF                 

  LOCATE lo_dziv_t.DZIV004 IN FILE                   
  --20160706 end

  LET lo_dziv_t.DZIV001  = p_dziv_t_scr.DZIV001
  LET lo_dziv_t.DZIV002  = p_dziv_t_scr.DZIV002
  LET lo_dziv_t.DZIV003  = NVL(p_dziv_t_scr.DZIV003,ms_dgenv)
  LET lo_dziv_t.DZIV004  = ls_dziv004
  LET lo_dziv_t.DZIV005  = NVL(p_dziv_t_scr.DZIV005,"N")
  LET lo_dziv_t.DZIVL005 = p_dziv_t_scr.DZIVL005
  LET lo_dziv_t.DZIVL006 = p_dziv_t_scr.DZIVL006  

  RETURN lo_dziv_t.*
  
END FUNCTION 

FUNCTION adzi200_refresh_dziv_t_scr_data(p_dziv_t)
DEFINE
  p_dziv_t T_DZIV_T_WL
DEFINE
  lo_dziv_t_scr T_DZIV_T_B_SCR

  LET lo_dziv_t_scr.DZIV001  = p_dziv_t.DZIV001 
  LET lo_dziv_t_scr.DZIV002  = p_dziv_t.DZIV002 
  LET lo_dziv_t_scr.DZIV003  = p_dziv_t.DZIV003 
  LET lo_dziv_t_scr.DZIV004  = p_dziv_t.DZIV004 
  LET lo_dziv_t_scr.DZIV005  = p_dziv_t.DZIV005 
  LET lo_dziv_t_scr.DZIVL005 = p_dziv_t.DZIVL005
  LET lo_dziv_t_scr.DZIVL006 = p_dziv_t.DZIVL006  

  RETURN lo_dziv_t_scr.*
  
END FUNCTION 

FUNCTION adzi200_fill_combobox(p_combobox,p_sql)
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
#                    1.TOPCHKOUT = N ，不能執行簽出及簽入行為
#                    2.使用者 = topstd，不能執行簽出及簽入行為
#                    3.TOPALM = Y，只可簽出不能簽入，此時簽入行為交由型管系統控制
#                    4.DGENV = s，標準環境，可以執行簽出及簽入行為
#                    5.DGENV = c, 客戶家，針對標準表不能簽出及簽入，請執行標準轉客制
#                    6.表格已簽出(dzlm008='O')且目前使用者是簽出者本人(DZLM007)，才能夠執行表格異動行為(更改、執行建構、刪除、簽出)
#                    7.出貨標識(dziv006)旗標如果為'Y'，則不能執行刪除的功能
# Usage..........: CALL adzi200_set_active_state(DIALOG,m_dziv_t_h_scr[mi_dziv_h_index].DZLM008)
# Input parameter: p_dialog     ui.Dialog
#                : p_alm_state  是否被簽出
# Return code....: none
#                : 
# Date & Author..: 20160130 by Jack Cheng
# Modify.........: 20160314 by CircleLai
################################################################################
FUNCTION adzi200_set_active_state(p_dialog,p_alm_state)
DEFINE
  p_dialog     ui.Dialog,
  p_alm_state  STRING       #p_alm_state：m_dziv_t_h_scr[mi_dziv_h_index].DZLM008(是否被簽出)
DEFINE  
  lb_active       BOOLEAN,  #是否被簽出
  ls_chkout_user  STRING,   #簽出者
  lb_chkout_user  BOOLEAN,  #簽出者是否是現在的使用者
  lb_topstd       BOOLEAN   #控管不能操作的帳號
  
  LET lb_active = IIF(NVL(p_alm_state,"X")=="O",TRUE,FALSE)      --是否被簽出
  LET ls_chkout_user  = m_dziv_t_h_scr[mi_dziv_h_index].DZLM007  --簽出者
  LET lb_chkout_user = TRUE
  
  #簽出者是否是現在的使用者
  IF (lb_active) AND (ls_chkout_user IS NOT NULL)
    AND (NVL(ls_chkout_user,cs_null_value) <> ms_user)  THEN     --ms_user：ls_user(目前使用者)
    LET lb_chkout_user = FALSE  --已經簽出，但簽出者不是自己   
  END IF
   
  #控管禁止操作的帳號
  IF (ms_user = cs_topstd_user_name) THEN  --cs_topstd_user_name = "topstd"
    LET lb_topstd = TRUE 
  ELSE 
    LET lb_topstd = FALSE 
  END IF
    
  #表格操作行為還原成預設值不使用狀態
  CALL p_dialog.setActionActive("tbi_create_view", FALSE) --新建視觀表
  CALL p_dialog.setActionActive("tbi_drop_view", FALSE)   --刪除視觀表
  CALL p_dialog.setActionActive("tbi_build_view", FALSE)  --執行建構
  CALL p_dialog.setActionActive("modify", FALSE )         --更改
     
  #簽出簽入按鍵，先還原成default狀態
  CALL p_dialog.setActionActive("btn_check_out", FALSE)   --簽出
  CALL p_dialog.setActionActive("btn_recall", FALSE)      --取消簽出
  CALL p_dialog.setActionActive("btn_check_in", FALSE)    --簽入
  CALL p_dialog.setActionActive("btn_exe_act", FALSE)     --標準、客制轉換

  #20160706 add begin
  IF ms_dgenv = cs_dgenv_customize THEN 
    CALL mo_form.setElementHidden("grid_cust_std_transfer",FALSE)
  ELSE
    CALL mo_form.setElementHidden("grid_cust_std_transfer",TRUE)
  END IF  
  --簽入設定
  CALL mo_form.setElementHidden("btn_check_in",TRUE)
  --釋出設定
  CALL p_dialog.setActionActive("btn_release", FALSE) 
  CALL mo_form.setElementHidden("btn_release",TRUE)
  #20160706 add end
  
  CASE  
    WHEN (NOT mb_enb_chkout) OR (lb_topstd) #所有的UI操作，禁止簽出簽入
      #TOPCHKOUT = N or 使用者是topstd
      #do nothing    
    WHEN (mb_enb_chkout) AND (mb_enable_alm)  #TOPCHKOUT=Y，TOPALM=Y
      --TOPALM=Y，型管狀態，所以只能簽出，不能簽入，此時簽入行為交由型管控制
      IF (ms_dgenv = cs_dgenv_standard) THEN  #標準環境(產中)，可以執行簽出及簽入
        CALL mo_form.setElementHidden("btn_release",FALSE)
        CALL p_dialog.setActionActive("btn_check_out", NOT lb_active) 
      ELSE  #客戶環境(客戶家)
        IF (m_dziv_t_h_scr[mi_dziv_h_index].DZIV003 = cs_dgenv_standard) THEN #在客戶家的標準表，不能簽出
          #do nothing 
        ELSE #在客戶家的客製表，可以簽出
          CALL p_dialog.setActionActive("btn_check_out", NOT lb_active)
        END IF
        CALL p_dialog.setActionActive("btn_exe_act", TRUE)  #在客戶家才可以執行，標準、客制的轉換
      END IF 
      
      CALL p_dialog.setActionActive("tbi_create_view", TRUE) #新建視觀表 
      
      IF (lb_active AND lb_chkout_user) THEN #已經簽出，並且簽出者是本人才能異動修改
        CALL p_dialog.setActionActive("modify", lb_chkout_user)
        CALL p_dialog.setActionActive("tbi_build_view", TRUE)
        CALL p_dialog.setActionActive("btn_release", TRUE) #20160706
        IF (m_dziv_t_h_scr[mi_dziv_h_index].DZIV006 = "Y") THEN #出貨標識(dziv006)如果為'Y'，則不能執行刪除的功能 
          #do nothing
        ELSE 
          CALL p_dialog.setActionActive("tbi_drop_view", lb_chkout_user)   --刪除視觀表
        END IF 
      END IF 
    
    WHEN (mb_enb_chkout) AND (Not mb_enable_alm)  #TOPCHKOUT=Y，TOPALM=N 
      CALL mo_form.setElementHidden("btn_check_in",FALSE)
      IF (ms_dgenv = cs_dgenv_standard) THEN  #標準環境(產中)，可以執行簽出及簽入
        CALL p_dialog.setActionActive("btn_check_out", NOT lb_active)    
        IF (lb_chkout_user) THEN #必須簽出者，才可以執行簽入 
          CALL p_dialog.setActionActive("btn_check_in", lb_active )
        END IF
      ELSE  #客戶環境(客戶家) 
        IF (m_dziv_t_h_scr[mi_dziv_h_index].DZIV003 = cs_dgenv_standard) THEN #在客戶家的標準表，不能簽出
          #do nothing
        ELSE #在客戶家的客製表，可以簽出
          CALL p_dialog.setActionActive("btn_check_out", NOT lb_active)
          IF (lb_chkout_user) THEN #必須簽出者，才可以執行簽入
            CALL p_dialog.setActionActive("btn_check_in", lb_active )
          END IF
        END IF 
        CALL p_dialog.setActionActive("btn_exe_act", TRUE) --在客戶家才可以執行，標準、客制的轉換
      END IF
      
      CALL p_dialog.setActionActive("tbi_create_view", TRUE) --新建視觀表
      
      IF (lb_active AND lb_chkout_user) THEN #已經簽出，並且簽出者是本人才能異動修改
        CALL p_dialog.setActionActive("modify", lb_chkout_user)  --更改
        CALL p_dialog.setActionActive("tbi_build_view", TRUE)    --執行建構
        IF (m_dziv_t_h_scr[mi_dziv_h_index].DZIV006 = "Y") THEN #出貨標識(dziv006)如果為'Y'，則不能執行刪除的功能 
          #do nothing
        ELSE 
          CALL p_dialog.setActionActive("tbi_drop_view", lb_chkout_user)   --刪除視觀表
        END IF            
      END IF 
      
    OTHERWISE
      #do nothing
      
  END CASE
 
END FUNCTION

#顯示目前的簽出資訊  --Jack Cheng 20160115
FUNCTION adzi200_set_check_out_mode(p_dialog,p_dziv_t)
DEFINE
  p_dialog ui.dialog,
  p_dziv_t T_DZIV_T_H_SCR
DEFINE 
  ls_check_out_full_name  STRING,
  ls_mode_msg             STRING,
  lo_dziv_t   T_DZIV_T_H_SCR

  LET lo_dziv_t.* = p_dziv_t.*
  
  CASE 
    WHEN NVL(lo_dziv_t.dzlm008,cs_null_value) <> cs_check_out
      CALL sadzp000_msg_get_message('adz-00365',ms_lang) RETURNING ls_mode_msg
      LET ls_check_out_full_name = "[ ",ls_mode_msg," ]"   #[未簽出]
    WHEN NVL(lo_dziv_t.dzlm008,cs_null_value) = cs_check_out
      CALL sadzp000_msg_get_message('adz-00367',ms_lang) RETURNING ls_mode_msg
      LET ls_check_out_full_name = "[ ",ls_mode_msg,"：",
              lo_dziv_t.dzlm007,"-",
              lo_dziv_t.ooag011," ]"   #[簽出者：使用者帳號-使用者全名]
  END CASE
  
  DISPLAY ls_check_out_full_name TO formonly.lbl_check_out_full_name  
  
END FUNCTION

################################################################################
# Descriptions...: 標準轉客制
# Memo...........: 
# Usage..........: CALL adzi200_standard_to_customize(DIALOG) RETURNING lb_result
# Input parameter: p_dialog     ui.Dialog
#                : 
# Return code....: lb_return  轉客制是否成功
#                : 
# Date & Author..: 20160224 by Jack Cheng
# Modify.........: 20160314 by CircleLai
################################################################################
FUNCTION adzi200_standard_to_customize(p_dialog)
DEFINE
  p_dialog          ui.dialog
DEFINE 
  lo_user_info      T_USER_INFO, --使用者資訊物件
  lo_DZLU_T         DYNAMIC ARRAY OF T_DZLU_T,
  lo_dziv_t_b_scr   T_DZIV_T_B_SCR,      
  lo_dziv_t         T_DZIV_T_WL,
  lo_dzlm_t         T_DZLM_T,  
  --lo_jsonobj        util.JSONObject, --20160706 marked
  lc_msg            VARCHAR(1024),
  lc_lang           VARCHAR (6),
  lb_return         BOOLEAN,
  lb_result         BOOLEAN,
  ls_view_name      STRING,
  ls_replace_arg    STRING

  LET lc_lang   = ms_lang
  LET lb_return = TRUE
  LET ls_view_name = m_dziv_t_h_scr[mi_dziv_h_index].DZIV001
  
  #檢查
  #數據庫或表格不存在
  IF ls_view_name IS NULL THEN 
    INITIALIZE lc_msg TO NULL 
    SELECT gzzd005 
      INTO lc_msg 
      FROM gzzd_t 
     WHERE gzzd001 = 'adzi200' 
       AND gzzd002 = lc_lang
       AND gzzd003 = 'lbl_dziv001'
    IF (lc_msg IS NULL ) THEN LET lc_msg = "View ID" END IF

    LET ls_replace_arg = lc_msg,"|"
    CALL sadzp000_msg_show_error(NULL,"adz-00766" ,ls_replace_arg,0)
    LET lb_return = FALSE 
    
    RETURN lb_return
    
  END IF
  
  #客戶環境下，才可執行此功能
  IF (ms_dgenv = cs_dgenv_customize) THEN
    #do nothing
  ELSE #客製開發環境下，才可執行此功能！
    CALL sadzp000_msg_show_info(NULL,"adz-00599" ,NULL,0)
    
    LET lb_return = FALSE 
    
    RETURN lb_return
    
  END IF 
  
  #標準表格才能轉客制
  IF m_dziv_t_h_scr[mi_dziv_h_index].DZIV003 = cs_dgenv_standard THEN
    #do nothing 
  ELSE 
    #已經是客製表
    CALL sadzp000_msg_show_info(NULL,"adz-00755" ,NULL,0)
    LET lb_return = FALSE 
    
    RETURN lb_return
    
  END IF
  
  #複製標準資料
  INITIALIZE lo_dziv_t_b_scr TO NULL
  LOCATE lo_dziv_t_b_scr.DZIV004 IN FILE  --DZIV004 視觀表Scripts
  
  CALL adzi200_fill_dziv_t_b(m_dziv_t_h_scr[mi_dziv_h_index].*) RETURNING lo_dziv_t_b_scr.*  
  CALL adzi200_prepare_dziv_t_data(lo_dziv_t_b_scr.*) RETURNING lo_dziv_t.*
  LET lo_dziv_t.DZIV003 = cs_dgenv_customize  #變更客制旗標'c'    --DZIV003：標準表或是客製表
  
  #檢查視觀表id是否已存在客制資料  
  IF (sadzi200_crud_check_if_dziv_t_exists(lo_dziv_t.*)) THEN  
    CALL sadzp000_msg_show_info(NULL,"adz-00756" ,NULL,0)
    LET lb_return = FALSE 
    
    RETURN lb_return
    
  END IF
  
  #ALM begin 
  CALL sadzi200_util_alm_check_out(mb_enable_alm, ms_user, ms_lang, cs_user_role_sd, FALSE) RETURNING lb_result,lo_USER_INFO.*,lo_DZLU_T
  #ALM end
  
  IF (lb_result) THEN #新增客製設計資料
    LET ms_alter_type = cs_type_std_to_cust
    #insert into DB  --qq: 待改善，錯誤時要回傳錯誤訊息
    CALL sadzi200_crud_set_view_data(lo_dziv_t.*,ms_alter_type,ms_lang,ms_dgenv) RETURNING lb_result
    IF (lb_result) THEN 
      CALL sadzi200_util_get_and_set_view_status(lo_dziv_t.*) RETURNING lb_result --20160706

      #完成標準轉客制，實際寫入註冊資料 into DZLM_T table
      #ALM begin  
      CALL sadzi200_util_set_alm_info(
                                       m_dziv_t_b_scr.DZIV001, cs_mdm_module_name, 
                                       m_dziv_t_b_scr.DZIVL005, cs_mdm_construct_type_view, 
                                       cs_ver_type_sd,lo_DZLU_T
                                     ) RETURNING lb_result,lo_dzlm_t.* 
                                     
      IF NOT lb_result THEN 
        #註冊資料寫入失敗
        CALL sadzp000_msg_show_error(NULL,"adz-00726" ,NULL,0)
      ELSE 
        #標準轉客制成功
        CALL sadzp000_msg_show_info(NULL,"adz-00757" ,NULL,0)
      END IF
      #ALM end
      CALL adzi200_refresh_master(p_dialog)#更新頁面
      CALL adzi200_set_active_state(p_dialog, m_dziv_t_h_scr[mi_dziv_h_index].DZLM008)
    ELSE 
      #標準轉客制出現錯誤
      LET lb_return = FALSE #Error when insert cust. design data into DB 
      CALL sadzp000_msg_show_error(NULL,"adz-00758" ,NULL,0)
      #CALL sadzi200_log_view_logresult(ls_message) #rixqq? 需要改進錯誤訊息顯示詳細內容
    END IF
  ELSE  
    #簽出行為 ALM 發生錯誤
    LET lb_return = FALSE
    CALL sadzp000_msg_show_error(NULL,"adz-00759" ,NULL,0)
  END IF 
  
  RETURN lb_return
  
END FUNCTION

################################################################################
# Descriptions...: 客制還原標準
# Memo...........: 
# Usage..........: CALL adzi200_customize_to_standard(DIALOG) RETURNING lb_result
# Input parameter: p_dialog     ui.Dialog
#                : 
# Return code....: lb_return  還原標準是否成功
#                : 
# Date & Author..: 20160224 by Jack Cheng
# Modify.........: 20160314 by CircleLai
################################################################################
FUNCTION adzi200_customize_to_standard(p_dialog)
DEFINE
  p_dialog          ui.dialog
DEFINE
  lo_dziv_t         T_DZIV_T_WL,
  lo_dziv_t2        T_DZIV_T_WL,  
  lo_dziv_t_h_scr   T_DZIV_T_H_SCR,  
  lo_dziv_t_b_scr   T_DZIV_T_B_SCR,
  lc_msg            VARCHAR(1024),
  lc_lang           VARCHAR (6),
  lb_active         BOOLEAN,  #資料是否被簽出
  lb_result         BOOLEAN,
  ls_answer         STRING,
  ls_msg            STRING,
  ls_chkout_user    STRING,   
  ls_view_name      STRING,
  ls_owners_queue   STRING,
  ls_replace_arg    STRING
DEFINE 
  lb_return         BOOLEAN    

  LET lc_lang   = ms_lang  
  LET lo_dziv_t_h_scr.* = m_dziv_t_h_scr[mi_dziv_h_index].*
  LET ls_view_name = m_dziv_t_h_scr[mi_dziv_h_index].DZIV001
  LET ls_chkout_user = m_dziv_t_h_scr[mi_dziv_h_index].DZLM007
  
  IF m_dziv_t_h_scr[mi_dziv_h_index].DZLM008 == "O" THEN
    LET lb_active = TRUE
  ELSE
    LET lb_active = FALSE
  END IF                  
  
  #檢查
  #資料若被簽出，只有簽出者本人才能執行還原行為；
  IF lb_active AND (ls_chkout_user IS NOT NULL) AND 
      (NVL(ls_chkout_user,cs_null_value) <> ms_user) THEN
    INITIALIZE g_errparam TO NULL
    CALL sadzp000_msg_show_info(NULL,"adz-00760" ,NULL,0)

    LET lb_return = FALSE
    
    RETURN lb_return
    
  END IF 
    
  #數據庫或表格不存在
  IF ls_view_name IS NULL THEN --視觀表ID
    INITIALIZE lc_msg TO NULL 
      SELECT gzzd005 
        INTO lc_msg 
        FROM gzzd_t 
       WHERE gzzd001 = 'adzi200' 
         AND gzzd002 = lc_lang
         AND gzzd003 = 'lbl_dziv001' #視觀表ID
    IF (lc_msg IS NULL ) THEN LET lc_msg = "View ID" END IF
    LET ls_replace_arg = lc_msg
    CALL sadzp000_msg_show_error(NULL,"adz-00767" ,ls_replace_arg,0)
    LET lb_return = FALSE 
    RETURN lb_return
  END IF
  
  #客製開發環境下，才可執行此功能
  IF (ms_dgenv = cs_dgenv_customize) THEN
    #do nothing
  ELSE 
    CALL sadzp000_msg_show_info(NULL,"adz-00599" ,NULL,0)
    LET lb_return = FALSE 
    RETURN lb_return
  END IF 
  
  #確認是否客製，是否由標準轉客製
  IF (m_dziv_t_h_scr[mi_dziv_h_index].DZIV003 = cs_dgenv_standard ) THEN
    CALL sadzp000_msg_show_info(NULL,"adz-00761" ,NULL,0)
    LET lb_return = FALSE
    RETURN lb_return
  ELSE 
    #取得目前的客制資料    
    CALL adzi200_fill_dziv_t_b(lo_dziv_t_h_scr.*) RETURNING lo_dziv_t_b_scr.*      
    CALL adzi200_prepare_dziv_t_data(lo_dziv_t_b_scr.*) RETURNING lo_dziv_t.*
    #檢查標準資料是否存在
    LET lo_dziv_t.DZIV003 = cs_dgenv_standard
    IF (NOT sadzi200_crud_check_if_dziv_t_exists(lo_dziv_t.*)) THEN
      CALL sadzp000_msg_show_info(NULL,"adz-00559" ,NULL,0)
      LET lb_return = FALSE
      RETURN lb_return
    END IF 
    
    LET lo_dziv_t.DZIV003 = cs_dgenv_customize  
  END IF
  
  #再次確認是否要執行還原
  CALL sadzp000_msg_get_message('adz-00762',ms_lang) RETURNING ls_replace_arg
  LET ls_replace_arg = "" #"確認要執行客制還原標準嗎？"
  CALL sadzp000_msg_question_box(NULL, "adz-00762", ls_replace_arg, 0) RETURNING ls_answer

  #執行建構，回歸標準，確認無誤後才刪除客制資料
  IF ls_answer = cs_response_yes THEN 
    LET ms_alter_type = cs_type_cust_to_std
    #取得標準設計資料
    LET lo_dziv_t_h_scr.DZIV003 = cs_dgenv_standard    
    CALL adzi200_fill_dziv_t_b(lo_dziv_t_h_scr.*) RETURNING lo_dziv_t_b_scr.*  
    CALL adzi200_prepare_dziv_t_data(lo_dziv_t_b_scr.*) RETURNING lo_dziv_t2.*   
    CALL sadzi200_crud_set_modify_date(lo_dziv_t2.*) RETURNING lb_result -- 20160706
    
    #執行建構
    CALL adzi200_build_view(lo_dziv_t2.*,FALSE) RETURNING lb_result

    #不管標準設計資料建構是否成功都刪除客制設計資料回歸標準
    CALL sadzi200_util_restore_to_standard(lo_dziv_t.*) RETURNING lb_return
    IF (lb_result) THEN
      LET lb_return = TRUE 
      CALL sadzp000_msg_show_info(NULL,"adz-00579" ,NULL,0)
    END IF
    CALL sadzi200_util_get_and_set_view_status(lo_dziv_t2.*) RETURNING lb_result -- 20160706
    #更新頁面
    CALL adzi200_refresh_master(p_dialog)
    CALL adzi200_set_active_state(p_dialog,m_dziv_t_h_scr[mi_dziv_h_index].DZLM008) 
    
    #END IF
  ELSE 
    #取消行為
    LET lb_return = FALSE
    RETURN lb_return 
  END IF

  RETURN lb_return
  
END FUNCTION

################################################################################
# Descriptions...: 實際執行建構
# Memo...........: 
# Usage..........: CALL adzi200_build_view(lo_dziv_t.*, NULL ) 
#                :       RETURNING lb_result
# Input parameter: p_dialog   ui.Dialog
#                : p_dziv_t   預建構view資料
#                : p_jsonobj  包含參數: 
#                               'confirm' 視窗詢問重複確認
# Return code....: lb_ret  建構是否成功
#                : 
# Date & Author..: 20160325 by CircleLai
# Modify.........: 
################################################################################
FUNCTION adzi200_build_view(p_dziv_t, p_confirm)
DEFINE 
  p_dziv_t  T_DZIV_T_WL,
  p_confirm BOOLEAN
DEFINE 
  lo_dziv_t       T_DZIV_T_WL,  
  lb_confirm      BOOLEAN,
  lb_result       BOOLEAN,
  ls_msg          STRING,
  ls_answer       STRING,
  ls_replace_arg  STRING,
  ls_error_code   STRING
DEFINE 
  lb_return  BOOLEAN 
  
  LET lo_dziv_t.* = p_dziv_t.*
  LET lb_confirm  = p_confirm #預設顯示確認視窗
  
  LET lb_return = TRUE 

  #確認是否執行建構？
  IF lb_confirm THEN 
    LET ls_replace_arg = ""
    LET ls_answer = sadzp000_msg_question_box(NULL, "adz-00769", ls_replace_arg, 0)
  ELSE 
    #不確認直接執行建構
    LET ls_answer = cs_response_yes
  END IF

  IF (ls_answer == cs_response_yes) THEN
    CALL sadzi200_util_create_replace_view(lo_dziv_t.*) RETURNING lb_result, ls_msg
    IF NOT lb_result THEN #執行建構失敗
      LET lb_return = FALSE
      #20160706 begin
      IF ms_alter_type == cs_type_cust_to_std THEN 
        LET ls_error_code = "adz-00763"  # 還原標準失敗,請參考Log內容
      ELSE 
        LET ls_error_code = "adz-00794"  # 新增或置換觸發器失敗,請參考Log內容.
      END IF 
      CALL sadzp000_msg_show_error(NULL,ls_error_code ,NULL,0)
      #20160706 end
      CALL sadzi200_log_view_logresult(ls_msg)
    ELSE
      IF ms_alter_type == cs_type_cust_to_std THEN
        #do nothing
      ELSE
        LET ls_replace_arg = lo_dziv_t.DZIV001
        CALL sadzp000_msg_show_info(NULL,"adz-00795" ,ls_replace_arg,0)
      END IF
    END IF
    #更新view狀態
    CALL sadzi200_util_get_and_set_view_status(lo_dziv_t.*) RETURNING lb_result 
  ELSE #取消執行
    LET lb_return = FALSE 
  END IF 
  
  RETURN lb_return
  
END FUNCTION 

#20160706 begin
FUNCTION adzi200_refresh_component_status(p_alter_type)
DEFINE
  p_alter_type STRING 
DEFINE
  ls_alter_type STRING

  LET ls_alter_type = p_alter_type

  CALL mo_form.setElementHidden("lbl_dziv001", FALSE )
  CALL mo_form.setElementHidden("formonly.ed_dziv001", FALSE )
  CALL mo_form.setElementHidden("formonly.ed_dziv005", FALSE )
  CALL mo_form.setElementHidden("lbl_view_name", FALSE )
  CALL mo_form.setElementHidden("formonly.cbo_view_header", FALSE )
  CALL mo_form.setElementHidden("formonly.ed_view_body", FALSE )
  CALL mo_form.setElementHidden("formonly.lbl_view_tail", FALSE )
  CALL mo_form.setElementHidden("formonly.lbl_check_out_full_name", FALSE )
  CALL mo_form.setElementHidden("lbl_cust_std_transfer", FALSE )
  CALL mo_form.setElementHidden("formonly.cbo_cust_std_transfer", FALSE )
  CALL mo_form.setElementHidden("btn_exe_act", FALSE ) 
  CALL mo_form.setElementHidden("grid_basic_info", FALSE) 
  CALL mo_form.setElementHidden("fd_syntax_toolbar", TRUE) 
  CALL mo_form.setElementHidden("btn_regen_script", TRUE) 
  CALL mo_form.setElementHidden("btn_test_script", TRUE) 
  CALL mo_form.setElementHidden("btn_hide_info", TRUE) 
  
  CASE 
    WHEN ls_alter_type = cs_browse_view
      CALL mo_form.setElementHidden("lbl_view_name", TRUE )
      CALL mo_form.setElementHidden("formonly.cbo_view_header", TRUE )
      CALL mo_form.setElementHidden("formonly.ed_view_body", TRUE )
      CALL mo_form.setElementHidden("formonly.lbl_view_tail", TRUE )
    WHEN ls_alter_type = cs_create_view
      CALL mo_form.setElementHidden("lbl_dziv001", TRUE )
      CALL mo_form.setElementHidden("formonly.ed_dziv001", TRUE )
      CALL mo_form.setElementHidden("formonly.ed_dziv005", TRUE )
      CALL mo_form.setElementHidden("vbox_view_list",TRUE)
      CALL mo_form.setElementHidden("formonly.lbl_check_out_full_name", TRUE )
      CALL mo_form.setElementHidden("lbl_cust_std_transfer", TRUE )
      CALL mo_form.setElementHidden("formonly.cbo_cust_std_transfer", TRUE )
      CALL mo_form.setElementHidden("btn_exe_act", TRUE )
      CALL mo_form.setElementHidden("fd_syntax_toolbar", FALSE ) 
      CALL mo_form.setElementHidden("btn_regen_script", FALSE) 
      CALL mo_form.setElementHidden("btn_test_script", FALSE) 
      CALL mo_form.setElementHidden("btn_hide_info", FALSE) 
    WHEN ls_alter_type = cs_modify_view
      CALL mo_form.setElementHidden("lbl_view_name", TRUE )
      CALL mo_form.setElementHidden("formonly.cbo_view_header", TRUE )
      CALL mo_form.setElementHidden("formonly.ed_view_body", TRUE )
      CALL mo_form.setElementHidden("formonly.lbl_view_tail", TRUE )
      CALL mo_form.setElementHidden("vbox_view_list",TRUE)
      CALL mo_form.setElementHidden("formonly.lbl_check_out_full_name", TRUE )
      CALL mo_form.setElementHidden("lbl_cust_std_transfer", TRUE )
      CALL mo_form.setElementHidden("formonly.cbo_cust_std_transfer", TRUE )
      CALL mo_form.setElementHidden("btn_exe_act", TRUE )
      CALL mo_form.setElementHidden("fd_syntax_toolbar", FALSE ) 
      CALL mo_form.setElementHidden("btn_regen_script", FALSE) 
      CALL mo_form.setElementHidden("btn_test_script", FALSE) 
      CALL mo_form.setElementHidden("btn_hide_info", FALSE) 
  END CASE
  
END FUNCTION

FUNCTION adzi200_refresh_view_name(p_DZIV_T_B_SCR)
DEFINE
  p_dziv_t_b_scr  T_DZIV_T_B_SCR
DEFINE
  lo_dziv_t_b_scr  T_DZIV_T_B_SCR,
  ls_view_name     STRING,
  lo_strbuf        base.StringBuffer
DEFINE
  ls_res_name   STRING,  
  ls_res_syntax STRING  

  LET lo_dziv_t_b_scr.* = p_dziv_t_b_scr.*

  LET lo_strbuf = base.StringBuffer.create()
  CALL lo_strbuf.clear()
  CALL lo_strbuf.append(cs_create_view_syntax)

  #組合視觀表名稱及建構語法
  LET ls_view_name = lo_dziv_t_b_scr.vns_HEAD,lo_dziv_t_b_scr.vns_BODY,lo_dziv_t_b_scr.vns_TAIL
  CALL lo_strbuf.replace(cs_identift_viewname,ls_view_name,0)

  LET ls_res_name = ls_view_name
  LET ls_res_syntax = lo_strbuf.toString()

  RETURN ls_res_name,ls_res_syntax
  
END FUNCTION

FUNCTION adzi200_separate_view_contents(p_view_contents)
DEFINE
  p_view_contents STRING
DEFINE
  ls_view_contents STRING,
  lo_strbuf        base.StringBuffer,
  lo_strbuf_temp   base.StringBuffer,
  lo_view_contents T_VIEW_CONTENTS,
  lb_separate      BOOLEAN,
  li_head_begin    INTEGER,
  li_head_end      INTEGER, 
  li_body_begin    INTEGER, 
  li_body_end      INTEGER
DEFINE
  lo_result T_VIEW_CONTENTS

  LET ls_view_contents = p_view_contents

  LET lb_separate = FALSE
  
  LET lo_strbuf_temp = base.StringBuffer.create()

  LET lo_strbuf = base.StringBuffer.create()
  CALL lo_strbuf.clear()
  CALL lo_strbuf.append(ls_view_contents)
  
  {
  #Contents Head
  IF lo_strbuf.getIndexOf(cs_view_head_begin_tag,1) >= 1 OR 
     lo_strbuf.getIndexOf(cs_view_head_end_tag,1) >= 1 THEN
    LET lo_view_contents.vc_HEAD = lo_strbuf.subString(lo_strbuf.getIndexOf(cs_view_head_begin_tag,1)+cs_view_head_begin_tag.getLength(),lo_strbuf.getIndexOf(cs_view_head_end_tag,1)-1)
    LET lb_separate = TRUE
  END IF   

  #Contents Body
  IF lo_strbuf.getIndexOf(cs_view_body_begin_tag,1) >= 1 OR 
     lo_strbuf.getIndexOf(cs_view_body_end_tag,1) >= 1 THEN
    LET lo_view_contents.vc_BODY = lo_strbuf.subString(lo_strbuf.getIndexOf(cs_view_body_begin_tag,1)+cs_view_body_begin_tag.getLength(),lo_strbuf.getIndexOf(cs_view_body_end_tag,1)-1)
    LET lb_separate = TRUE
  END IF

  IF NOT lb_separate THEN
    LET lo_view_contents.vc_BODY = ls_view_contents 
  END IF
  
  }

  CALL lo_strbuf_temp.clear()
  CALL lo_strbuf_temp.append(lo_strbuf.toString())
  CALL lo_strbuf_temp.toUpperCase()

  LET li_head_begin = lo_strbuf_temp.getIndexOf(cs_view_create_tag,1)
  LET li_head_end   = lo_strbuf_temp.getIndexOf(cs_view_as_tag,1) + cs_view_as_tag.getLength()
  LET li_body_begin = li_head_end + 1
  LET li_body_end   = lo_strbuf_temp.getLength()
  
  LET lo_view_contents.vc_HEAD = lo_strbuf.subString(li_head_begin,li_head_end)
  LET lo_view_contents.vc_BODY = lo_strbuf.subString(li_body_begin,li_body_end)

  LET lo_view_contents.vc_HEAD = lo_view_contents.vc_HEAD.trim()
  LET lo_view_contents.vc_BODY = lo_view_contents.vc_BODY.trim()

  LET lo_result.* = lo_view_contents.*

  RETURN lo_result.*
  
END FUNCTION

FUNCTION adzi200_refresh_editor_text(p_dziv_t_b_scr,p_syntax)
DEFINE
  p_dziv_t_b_scr  T_DZIV_T_B_SCR,
  p_syntax        STRING  
DEFINE 
  ls_syntax         STRING,
  li_cusr_pos       INTEGER,
  ls_dziv004_before STRING, 
  ls_dziv004_after  STRING, 
  ls_dziv004        STRING
DEFINE
  li_return INTEGER  

  LET ls_syntax = p_syntax 
  
  LET li_cusr_pos = FGL_DIALOG_GETCURSOR() 
  LET ls_dziv004 = p_dziv_t_b_scr.DZIV004
  LET ls_dziv004_before = ls_dziv004.subString(1,li_cusr_pos-1)
  LET ls_dziv004_after  = ls_dziv004.subString(li_cusr_pos,ls_dziv004.getLength())
  LET ls_dziv004 = ls_dziv004_before,ls_syntax,ls_dziv004_after
  LET p_dziv_t_b_scr.DZIV004 = ls_dziv004    

  LET li_return = li_cusr_pos

  RETURN li_return
  
END FUNCTION 

FUNCTION adzi200_refresh_syntax_toolbar(p_dialog,p_status)
DEFINE
  p_dialog ui.Dialog,
  p_status BOOLEAN

  #Base Syntax page
  CALL p_dialog.setActionActive("btn_sql_base_select",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_distinct",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_from",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_where",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_and",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_or",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_not",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_in",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_between",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_like",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_exists",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_order_by",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_group_by",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_union",p_status)
  CALL p_dialog.setActionActive("btn_sql_base_having",p_status)

  #Compound Syntax page
  CALL p_dialog.setActionActive("btn_sql_cmpnd_select_from",p_status)
  CALL p_dialog.setActionActive("btn_sql_cmpnd_inner_join",p_status)
  CALL p_dialog.setActionActive("btn_sql_cmpnd_left_outer_join",p_status)
  CALL p_dialog.setActionActive("btn_sql_cmpnd_on",p_status)
  CALL p_dialog.setActionActive("btn_sql_cmpnd_where_exists",p_status)
  CALL p_dialog.setActionActive("btn_sql_cmpnd_where_not_exists",p_status)

  #DB Page
  CALL p_dialog.setActionActive("btn_db_erpdb",p_status)
  CALL p_dialog.setActionActive("btn_db_awsdb",p_status)
  CALL p_dialog.setActionActive("btn_db_ds",p_status)
  CALL p_dialog.setActionActive("btn_db_dsdemo",p_status)
  CALL p_dialog.setActionActive("btn_db_dsdata",p_status)
  CALL p_dialog.setActionActive("btn_db_dsaws",p_status)
  CALL p_dialog.setActionActive("btn_db_dsawst",p_status)
  
END FUNCTION

FUNCTION adzi200_check_view_name_valid(p_view_name)
DEFINE
  p_view_name  STRING
DEFINE
  ls_view_name   STRING,
  li_loop        INTEGER,
  ls_view_char   VARCHAR(1),
  ls_replace_arg STRING,
  lb_result      BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET lb_result = TRUE

  LET ls_view_name = p_view_name

  #判斷輸入名稱是否含有其他 Unicode
  FOR li_loop = 1 TO ls_view_name.getLength()
    LET ls_view_char = ls_view_name.subString(li_loop,li_loop)
    IF ls_view_char IS NOT NULL AND ls_view_char NOT MATCHES "[a-z]" AND ls_view_char NOT MATCHES "[0-9]" AND ls_view_char NOT MATCHES "[_]" THEN
      LET ls_replace_arg = ls_view_name,"|"
      CALL sadzp000_msg_show_error(NULL, "adz-00892", ls_replace_arg, 1)
      LET lb_result = FALSE
      EXIT FOR
    END IF
  END FOR
  IF NOT lb_result THEN GOTO _return END IF

  #檢核長度
  IF ls_view_name.getLength() > ci_max_view_length THEN
    LET ls_replace_arg = ci_max_view_length,"|"
    CALL sadzp000_msg_show_error(NULL,"adz-00887" ,ls_replace_arg,0)
    LET lb_result = FALSE
  END IF
  IF NOT lb_result THEN GOTO _return END IF

  #檢核名稱是否已經存在
  IF (sadzi200_crud_check_view_name_if_exists(ls_view_name)) THEN 
    LET ls_replace_arg = ls_view_name,"|"
    CALL sadzp000_msg_show_error(NULL,"adz-00891" ,ls_replace_arg,0)
    LET lb_result = FALSE
  END IF
  IF NOT lb_result THEN GOTO _return END IF

  LABEL _return:
  
  LET lb_return = lb_result

  RETURN lb_return  

END FUNCTION

FUNCTION adzi200_get_system_information(p_set_title)
DEFINE
  p_set_title BOOLEAN
DEFINE
  lb_set_title     BOOLEAN,
  ls_zone          STRING,
  ls_cust          STRING,
  ls_user          STRING,
  ls_window_title  STRING,
  lo_db_info       T_DB_INFO,
  ls_program_title STRING,
  ls_about         STRING,
  ls_mode          STRING,
  ls_erpid         STRING,
  ls_topind        STRING,
  ls_DB_TYPE       STRING,
  ldt_curr_time    DATETIME YEAR TO SECOND
DEFINE
  ls_return STRING

  LET lb_set_title = p_set_title

  CALL FGL_GETENV("ZONE") RETURNING ls_zone
  CALL FGL_GETENV("CUST") RETURNING ls_cust
  CALL FGL_GETENV("ERPID") RETURNING ls_erpid
  CALL DB_GET_DATABASE_TYPE() RETURNING ls_DB_TYPE
  CALL FGL_GETENV("TOPIND") RETURNING ls_topind

  &ifndef DEBUG
  LET ldt_curr_time = cl_get_current()
  &else
  LET ldt_curr_time = CURRENT YEAR TO SECOND
  &endif

  #For get Windows information
  LET ls_user = ms_user

  CALL sadzi200_db_get_db_info() RETURNING lo_db_info.*
  CALL sadzi200_util_get_program_title('adzi140',ms_lang) RETURNING ls_program_title

  LET ls_zone = ls_zone
  LET ls_user = ms_user

  IF lb_set_title THEN
    LET ls_window_title = NVL(ls_program_title,cs_program_title)," [ Cust：",ls_cust," ] [ Zone：",ls_zone," ] [ User：",ls_user," ] [DB Name：",lo_db_info.DB_NAME,"] [DB User：",lo_db_info.USER_NAME,"] [ Login Time：",CURRENT YEAR TO SECOND," ]"
    CALL FGL_SETTITLE(ls_window_title)
  END IF

  LET ls_about = "View Designer : ",cs_version,"\n\n",
                 "Environment : ",IIF(ms_dgenv=cs_dgenv_standard,"Standard","Customize"),"\n",
                 "Cust : ",ls_cust,"\n",
                 "Zone：",ls_zone,"\n",
                 "ERPID：",ls_erpid,"\n",
                 "TOPIND：",ls_topind,"\n",
                 "DB Type：",ls_db_type,"\n",
                 "DB Name：",lo_db_info.DB_NAME,"\n",
                 "DB User：",lo_db_info.USER_NAME,"\n",
                 "Login User：",ls_user,"\n",
                 "Login Time：",mdt_login_time,"\n",
                 "Current Time：",ldt_curr_time

  LET ls_return = ls_about

  RETURN ls_return

END FUNCTION 
#20160706 end
