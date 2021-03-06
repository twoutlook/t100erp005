# Modify         : 2015/11/09 by Hiko : 1.改善下載效能, 增加dzay005(程式是否需要重產)來記錄程式是否需要重產.
#                                       2.r.c3第四參數增加第3種功能給下載程式使用:不重產,只組合,不編譯. 除了有重產需要, 否則下載預設都是只做組合.
#                                       3.不呼叫備份段.
#                                       4.簽出要新建dzay_t.
#                : 2015/11/30 by elena: 1.查詢條件可組合查詢.
#                : 2015/12/04 by Hiko : 1.沒有設計資料不能下載要增加r.a的dzfq_5的判斷.
#                                       2.簽出過程失敗都需要rollback.
#                                       3.移除更新碼呼叫:sadzp200_intf_update_process_code
#                : 2015/12/17 by Hiko : 1.只要呼叫sadzp063_1的FUNCTION就不需要失敗彈窗.
#                                       2.調整簽出失敗呼叫sadzp063_1的參數.
#                                       3.標準轉客製簽出過程失敗都不應該繼續跑第二次.
#                : 2015/12/21 by elena: 1.新增顯示所有簽出程式checkbox.
#                : 2015/12/22 by Hiko : 1.只要呼叫sadzp063_1_del_design_data的地方,回傳的訊息都改,以免吃掉正常的錯誤訊息.
#                                       2.調整簽出時的檢查順序.
#                                       3.調整錯誤時的處理,包含錯誤訊息的呈現.
#                : 2015/12/25 by Hiko : 1.改在_moveing_fault統一呼叫sadzp063_1_del_design_data.
#                : 2015/12/31 by elena: 1.新增下載至模組資料夾checkbox.
#                : 20160111   by elena: 1.下載4RP至模組資料夾.
#                : 20160121   by elena: 1.將備份段註解掉.
#                                       2.標準轉客製增加背景執行r.l程式段落
#                : 20160128  by ernest: 1.M,S,Q 類的程式控管,當規格及程式的版次都為空值時,則將Full check out 設為Disable 
#                : 20160223   by elena: 1.複製來源類型為MSFQ檢核規格是否有資料，非F類型檢核程式是否有資料
#                : 20160304   by elena: 1.enable取消註解按鈕，當點選取消註解時，依程式建構版次提示使用adzp063方法
#                : 20160308   by elena: 1.簽出後查詢資料條件增加ls_chk_spec_type
#                                       2.一般程式下載(mutli_download)判斷是否是行業別程式，行業別程式才重抓版次
#                : 20160323  by  elena: 1.新增判斷標準環境不可簽出行業別程式、行業環境不可簽出標準程式
#                : 20160330  by ernest: 1.簽出到dzlm的程式或規格還需過濾判斷在dzlu_t上是否存在
#                : 20160412  by ernest: 1.修正 ms_user_name 抓取 g_acount
# 160420-00014   : 20160420  by ernest: 1.修正topstd不能正常簽出的問題
# 160504-00002   : 20160505  by ernest: 1.針對釋出的修改
#                                       2.AZZ不能簽出 
#                                       3.抓取 TOPIND 秀     
#                : 20160520  by hiko  : 1.修正簽出行業別程式錯誤問題
# 160803-00006   : 20160803  by ernest: 1.修正判斷dzlu008為空值時的問題
# 161004-00011   : 20161004  by ernest: 1.windowStyle改成 withoutToolBarCanSizable
#                                       2.畫面百分比改位置
#                                       3.客戶端簽入時提示 :此項操作僅釋放出修改權限, 並非結案, 請問是否繼續 ?
#                                       4.畫面的"版本"都改為"版次"
# 161027-00001   : 20161027  by ernest: 1.畫面增加[可merge]或是[可同步]的flag.
#                                       2.merge與同步按鈕在簽出狀態按下的時候, 要提示需要簽入才可以, 我們會自動簽入後繼續進行merge/同步, 請問是否繼續?
#                                       3.簽入的時候提示 : '溫馨提醒 : 簽入前請記得要上傳, 您確定要簽入%1嗎?'
#                                       4.簽入的時候進行 r.c, r.f 確認程式的正確性
# 161028-00001   : 20161028  by ernest: 1.在客製環境增加'下載標準規格'/'下載標準程式'功能, 下載畫面的功能越來越多
#                                       2.topstd簽出時, 進行嚴重警告
#                                       3.多加一個只顯示標準轉客製程式
# 161116-00032   : 20161116  by ernest: 1.4ad複製失敗不出現錯誤
# 170111-00006   : 20170111  by ernest: 1.下載時同時賦予壓縮包 everyone 的權限
#                                       2.標準轉客製要特別判斷此程式是否解開section再加上提示訊息 (azzi920.adz-00951)
# 170208-00008   : 20170123  by ernest: 1.差異比對下載(azzi920.adz-00952,adz-00954),(azzi902.adzp050)
# 170124-00031   : 20170124  by ernest: 1.啟動效能改善
#                                       2.搜尋按下 Enter 即執行
#                                       3.topstd簽出要依據類型控卡, 例如主程式不能沒有規格與程式的版次(azzi920.adz-00955,azzi920.adz-00956)
# xxxxxx-xxxxx   : 201xxxxx  by ernest: 1.加上'預設下載至模組資料夾'的紀錄功能. 下次就以上次設定的為主 : 放在home目錄下.


#執行程式語法
#1.程式:r.r adzp050 dir 'c:\\tt\\' CODE
#2.規格:r.r adzp050 dir 'c:\\tt\\' SPEC
#3.4RP :r.r adzp050 dir 'c:\\tt\\' 4RP
#4.更新基礎資料:r.r adzp050 TT DIR 'c:\\tt\\'


&include "../4gl/sadzp000_mcr.inc"

IMPORT OS
IMPORT XML
IMPORT security

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

GLOBALS
  DEFINE g_patch_mode LIKE TYPE_T.CHR1 
  DEFINE gb_diff_download  BOOLEAN #170208-00008  
END GLOBALS

&include "../4gl/sadzp000_cnst.inc" 
&include "../4gl/sadzp200_cnst.inc" 
&include "../4gl/sadzp050_cnst.inc"  

CONSTANT cs_top_module_name     STRING = "TOP"
CONSTANT cs_download_str        STRING = "Download finished"
CONSTANT cs_default_client_path STRING = "c:\\tt\\"
CONSTANT cs_adzp050_env_file    STRING = "adzp050_env.xml"
CONSTANT cs_focus_on_program    STRING = "PROGRAM" #161027-00001
CONSTANT cs_focus_on_demand     STRING = "DEMAND"  #161027-00001

&include "../4gl/sadzp000_type.inc" 
&include "../4gl/sadzp050_type.inc"  
&include "../4gl/sadzp060_type.inc"  
&include "../4gl/sadzp200_type.inc" 

PRIVATE TYPE T_PARAMETER RECORD
               p_PARAM1   STRING, 
               p_PARAM2   STRING, 
               p_PARAM3   STRING, 
               p_PARAM4   STRING
             END RECORD

PRIVATE TYPE T_PROGRAM_TYPE RECORD
               temp_ver   VARCHAR(10), 
               temp_type  VARCHAR(10),
               temp_name  VARCHAR(50)
             END RECORD

PRIVATE TYPE T_PROG_LIST RECORD
               row_num          INTEGER, 
               new_record       VARCHAR(02),  --COL01 
               prog_selected    VARCHAR(02),
               auto_start       VARCHAR(02),
               industry_type    VARCHAR(10),   
               module_name      VARCHAR(50),  --COL05
               cust_module_name VARCHAR(50),  --COL05
               spec_type        VARCHAR(02),  
               prog_name        VARCHAR(1024),
               prog_desc        VARCHAR(4000),
               include_ui       VARCHAR(02),
               version          INTEGER,  --COL10
               sd_ver           INTEGER,
               sd_read_write    VARCHAR(02),
               pg_ver           INTEGER,
               pg_read_write    VARCHAR(02),
               progress         INTEGER,      --COL15
               identity         VARCHAR(10),
               origin_prog      VARCHAR(50),
               origin_module    VARCHAR(50),  --COL20
               origin_spec_type VARCHAR(50),  --COL20
               origin_sd_ver    INTEGER,
               origin_pg_ver    INTEGER,
               origin_identity  VARCHAR(10),   
               merge_code       VARCHAR(02),
               sync_code        VARCHAR(02) #161027-00001
             END RECORD

PRIVATE TYPE T_PROG_LIST_COLOR RECORD
               row_num         STRING,
               new_record      STRING,
               prog_selected   STRING,
               auto_start      STRING,
               industry_type   STRING,
               module_name     STRING,
               cust_module_name STRING,  --COL05
               spec_type       STRING,
               prog_name       STRING,
               prog_desc       STRING,
               include_ui      STRING,
               version         STRING,
               sd_ver          STRING,
               sd_read_write   STRING,
               pg_ver          STRING,
               pg_read_write   STRING,
               progress        STRING,
               identity        STRING,
               origin_prog     STRING, 
               origin_module   STRING,
               origin_spec_type STRING,  --COL20
               origin_sd_ver   STRING, 
               origin_pg_ver   STRING, 
               origin_identity STRING,
               merge_code      STRING
             END RECORD

PRIVATE TYPE T_ALM_LIST RECORD
               row_num       INTEGER, 
               new_record    VARCHAR(02), 
               prog_selected VARCHAR(02),
               auto_start    VARCHAR(02),
               industry_type VARCHAR(10),   
               module_name   VARCHAR(50),
               spec_type     VARCHAR(02),  
               prog_name     VARCHAR(1024),
               prog_desc     VARCHAR(4000),
               include_ui    VARCHAR(02),
               version       INTEGER,
               sd_ver        INTEGER,
               sd_read_write VARCHAR(02),
               pg_ver        INTEGER,
               pg_read_write VARCHAR(02),
               progress      INTEGER,
               identity      VARCHAR(10),
               origin_prog   VARCHAR(50),
               origin_module VARCHAR(50),
               origin_spec_type VARCHAR(02),  
               origin_sd_ver    INTEGER,
               origin_pg_ver    INTEGER,
               origin_identity  VARCHAR(2), -- 使用標示(S/C)
               DZLM012	        VARCHAR(20),  -- 需求單號
               DZLM013	        VARCHAR(10),  -- 產品代號
               DZLM014	        VARCHAR(10),  -- 產品版本
               DZLM015	        INTEGER,      -- 作業項次
               DZLM018          VARCHAR(40),  -- SD GUID
               DZLM019          VARCHAR(40),  -- PR GUID
               DZLM020          VARCHAR(1),   -- SD 已下載
               DZLM021          VARCHAR(1),   -- PR 已下載
               merge_code       VARCHAR(02), #161027-00001
               sync_code        VARCHAR(02)  #161027-00001
             END RECORD

PRIVATE TYPE T_ALM_LIST_COLOR RECORD
               row_num       STRING,
               new_record    STRING,
               prog_selected STRING,
               auto_start    STRING,
               industry_type STRING,
               module_name   STRING,
               spec_type     STRING,
               prog_name     STRING,
               prog_desc     STRING,
               include_ui    STRING,
               version       STRING,
               sd_ver        STRING,
               sd_read_write STRING,
               pg_ver        STRING,
               pg_read_write STRING,
               progress      STRING,
               identity      STRING,
               origin_prog   STRING, 
               origin_module STRING,
               origin_spec_type STRING,  
               origin_sd_ver STRING, 
               origin_pg_ver STRING,
               origin_identity  STRING,
               DZLM012	     STRING,
               DZLM013	     STRING,
               DZLM014	     STRING,
               DZLM015	     STRING,
               DZLM018       STRING,
               DZLM019       STRING,
               DZLM020       STRING,
               DZLM021       STRING
             END RECORD             

PRIVATE TYPE T_BACKUP_DESIGN_DATA_INTF RECORD
               BDDI_S_spec_type     STRING,
               BDDI_S_file_name     STRING,
               BDDI_S_module_name   STRING,
               BDDI_S_identity      STRING,
               BDDI_S_module_path   STRING,
               BDDI_S_lang          STRING,
               BDDI_S_download_type STRING,
               BDDI_S_erpalm        STRING,
               BDDI_B_readonly      BOOLEAN,
               BDDI_B_run_alm       BOOLEAN,
               BDDI_S_version       STRING,
               BDDI_S_dgenv         STRING,
               BDDI_O_template_list DYNAMIC ARRAY OF T_TEMPLATE_LIST_R
             END RECORD 

PRIVATE TYPE T_BACKUP_DESIGN_DATA_RET RECORD
               BDDR_B_result        BOOLEAN,
               BDDR_S_src_path      STRING,
               BDDR_S_file_name     STRING,
               BDDR_S_download_type STRING
             END RECORD    

#161027-00001 begin 
PRIVATE TYPE T_MERGE_SYNC_PARA RECORD 
               msp_prog_name    VARCHAR(1024),
               msp_prog_desc    VARCHAR(2048),
               msp_module_name  VARCHAR(50),
               msp_spec_type    VARCHAR(02),  
               msp_dgenv        VARCHAR(10),
               msp_version      INTEGER,    -- 161028-00001
               msp_sd_ver       INTEGER,    -- 161028-00001
               msp_pr_ver       INTEGER,    -- 161028-00001
               msp_identity     VARCHAR(10) -- 161028-00001
             END RECORD 
#161027-00001 begin 
             
DEFINE m_prog_list DYNAMIC ARRAY OF T_PROG_LIST   

DEFINE m_demand_list DYNAMIC ARRAY OF T_ALM_LIST   
DEFINE m_demand_list_color DYNAMIC ARRAY OF T_ALM_LIST_COLOR
   
DEFINE ms_client_path STRING #Client Path

DEFINE mi_spend_time DATETIME HOUR TO FRACTION(5)

DEFINE ms_lang            STRING
DEFINE ms_user            STRING
DEFINE ms_user_name       STRING
DEFINE ms_erpalm          STRING
DEFINE ms_topind          STRING #160504-00002
DEFINE ms_DGENV           STRING 
DEFINE mb_debug           BOOLEAN
DEFINE mb_customize       BOOLEAN 
DEFINE ms_debug_message   STRING
DEFINE mb_download_all    BOOLEAN
DEFINE ms_download_type   STRING
DEFINE ms_running_process STRING
DEFINE ms_view_mergeable  STRING 
DEFINE ms_view_checkout   STRING  #20151221 by elena
DEFINE ms_modulefolder    STRING  #20151231 by elena
DEFINE ms_env_dir         STRING  #xxxxxx-xxxxx 
DEFINE ms_cursor_focus_on STRING  #161027-00001
DEFINE ms_view_std_to_cust STRING #161028-00001

DEFINE ms_dzaf_t_o_view STRING
DEFINE ms_dzaf_t_s_view STRING
DEFINE ms_dzaf_t_c_view STRING
DEFINE ms_gzzj_t_view   STRING
DEFINE ms_exclude_module STRING

DEFINE ms_search STRING 

DEFINE mo_template_list   DYNAMIC ARRAY OF T_TEMPLATE_LIST_R
DEFINE mb_result          BOOLEAN
DEFINE ms_enable_checkout STRING

DEFINE mb_enable_checkout_lib BOOLEAN 

DEFINE mo_PARAMETER  T_PARAMETER
DEFINE mb_initial_run  BOOLEAN #170124-00031

MAIN
  CALL adzp050_initialize()
  CALL adzp050_initial_form()
  CALL adzp050_start()
  CALL adzp050_finalize()
END MAIN

FUNCTION adzp050_initialize()
DEFINE
  ls_separator           STRING,
  ls_enable_checkout_lib STRING,
  lb_result              BOOLEAN #161027-00001

  OPTIONS INPUT WRAP
  
  LET mo_PARAMETER.p_PARAM1 = NVL(ARG_VAL(2),"DIR") #DIR
  LET mo_PARAMETER.p_PARAM2 = NVL(ARG_VAL(3),cs_default_client_path) #Client Path
  LET mo_PARAMETER.p_PARAM3 = ARG_VAL(4) #SPEC or CODE
  LET mo_PARAMETER.p_PARAM4 = ARG_VAL(5) #SPEC or CODE
  
  LET ls_separator = os.Path.separator()

  #決定下載時的路徑
  CASE
    WHEN (mo_PARAMETER.p_PARAM1.toUpperCase() = "DIR")
      LET ms_client_path   = mo_PARAMETER.p_PARAM2
      LET ms_download_type = NVL(mo_PARAMETER.p_PARAM3,cs_download_type_spec)
    WHEN (mo_PARAMETER.p_PARAM2.toUpperCase() = "DIR")
      LET ms_client_path   = mo_PARAMETER.p_PARAM3
      LET ms_download_type = NVL(mo_PARAMETER.p_PARAM4,cs_download_type_spec)
    OTHERWISE
      LET ms_client_path   = cs_default_client_path 
  END CASE  

  #依模組進行系統初始化設定(系統設定)
  CALL cl_tool_init()

  LET ms_lang = NVL(g_lang,cs_default_lang)
  LET ms_user = g_account --g_user 
  LET ms_user_name = g_account --FGL_GETENV("USER") -- 20160412 

  #系統是否允許LIB相關資源被簽出
  CALL cl_get_para("","","A-SYS-0040") RETURNING ls_enable_checkout_lib
  LET mb_enable_checkout_lib = IIF(NVL(ls_enable_checkout_lib,"N") == 'Y',TRUE,FALSE)

  #設定不被看見的模組
  LET ms_exclude_module = "'ADZ'"
  
  #抓系統參數
  CALL FGL_GETENV("TOPCHKOUT") RETURNING ms_enable_checkout
  CALL FGL_GETENV("TOPALM")    RETURNING ms_erpalm
  CALL FGL_GETENV("TOPIND")    RETURNING ms_topind #160504-00002

  LET ms_topind= NVL(ms_topind,cs_industry_type_standard)

  LET ms_DGENV = FGL_GETENV("DGENV") 
  LET mb_customize = IIF(ms_DGENV==cs_dgenv_customize,TRUE,FALSE)

  #xxxxxx-xxxxx begin
  #CALL adzp050_gen_environment_path() RETURNING ms_env_dir
  #CALL adzp050_set_environment_xml_file(ms_env_dir,ms_client_path) RETURNING lb_result  
  #CALL adzp050_get_environment_xml_file(ms_env_dir,ms_client_path) RETURNING lb_result  
  #xxxxxx-xxxxx end
  
END FUNCTION

FUNCTION adzp050_initial_form()
DEFINE
  ls_separator STRING 
#Being:20150414 by Hiko
DEFINE lw_window   ui.Window,
       lf_form     ui.Form,
       ls_cfg_path STRING,
       ls_4st_path STRING,
       ls_img_path STRING,
       ls_combobox ui.Combobox,
       ls_combobox_text STRING
#End:20150414 by Hiko
  
  LET ls_separator = os.Path.separator()
  
  IF (mo_PARAMETER.p_PARAM1.toUpperCase() <> "TT" AND mo_PARAMETER.p_PARAM1.toUpperCase() <> "T100") THEN
  
    CLOSE WINDOW SCREEN
    OPEN WINDOW w_adzp050 WITH FORM cl_ap_formpath("ADZ","adzp050")
    CURRENT WINDOW IS w_adzp050
 
    #Begin:20150414 by Hiko
    #瀏覽頁簽資料初始化
    #CALL cl_ui_init()

    CALL adzp050_set_window_title(ms_download_type) #這裡不能呼叫cl_ui_wintitle(1),要不然判斷不出來是哪種類型的下載

    CALL cl_load_4ad_interface(NULL)
    
    LET lw_window = ui.Window.getCurrent()
    LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
    CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))
    
    LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
    LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
    CALL ui.Interface.loadStyles(ls_4st_path)
    #End:20150414 by Hiko

    CALL ui.Dialog.setDefaultUnbuffered(TRUE)

    IF mo_PARAMETER.p_PARAM1.toUpperCase() = "DEBUG" THEN
      CALL adzp050_set_debug_mode(TRUE)
    ELSE  
      CALL adzp050_set_debug_mode(FALSE)
    END IF
    
    #CALL FGL_GETENV(cs_erp_path) RETURNING ls_erp_path
    #CALL ui.Interface.loadStyles(ls_erp_path||ls_separator||"cfg"||ls_separator||"4st"||ls_separator||"adzp050")
    #CALL ui.Interface.loadActionDefaults(ls_erp_path||ls_separator||"adz"||ls_separator||"4ad"||ls_separator||ms_lang||ls_separator||"adzp050")
    #CALL ui.Interface.loadActionDefaults(ls_erp_path||ls_separator||"cfg"||ls_separator||"4ad"||ls_separator||"tiptop_",ms_lang,"")
    
    CALL adzp050_set_customize_visible(mb_customize) #161027-00001
    CALL adzp050_set_alm_element_visible(NULL)
    CALL adzp050_refill_combobox(mb_customize,ms_lang)
    CALL adzp050_set_virtual_view()
    
  END IF
  
END FUNCTION 


FUNCTION adzp050_start()
DEFINE
  lo_win           ui.Window,
  ls_module        STRING,
  ls_exec_type     STRING,
  ls_module_name   STRING,
  ls_client_path   STRING,
  ls_temp_path     STRING,
  lo_prog_list     DYNAMIC ARRAY OF T_PROG_LIST,
  lo_demand_list   DYNAMIC ARRAY OF T_ALM_LIST,
  lo_template_list DYNAMIC ARRAY OF T_TEMPLATE_LIST_R,
  lo_check_out_owner_list DYNAMIC ARRAY OF T_CHECK_OUT_OWNER_LIST,
  ls_current_item  STRING, 
  ls_top_env       STRING,
  li_arr_curr      INTEGER,
  ls_chk_spec_type STRING,
  ls_get_last_ver  STRING,
  ls_enable_alm    STRING,
  ls_enable_customize STRING,
  lb_download_all     BOOLEAN,
  li_index            INTEGER,
  ls_download_type    STRING,
  ls_sql              STRING,
  ls_separator        STRING,
  lb_selected         BOOLEAN,
  ls_err_code         STRING,
  ls_err_msg          STRING, 
  lb_result           BOOLEAN,
  ls_result           STRING, #160504-00002
  ls_res_code         STRING, #160504-00002
  ls_prog_name        STRING,
  ls_spec_type        STRING,
  ls_dgenv            STRING,
  ls_message          STRING,
  ls_command          STRING,
  lb_return           STRING,
  ls_retmsg           STRING,  
  lb_full_check_out   BOOLEAN,
  lb_hide_full_check_out  BOOLEAN,    
  lb_hide_check_out       BOOLEAN,
  lo_DZAF_T               T_DZAF_T,
  lb_if_check_out         BOOLEAN,
  lb_if_std_check_out     BOOLEAN,
  li_check_in_cnt         INTEGER,
  li_check_out_cnt        INTEGER,
  li_uncheck_out_cnt      INTEGER,
  li_check_out_owner_list INTEGER,
  lo_curr_window          ui.Window,
  lo_curr_form            ui.Form,
  ls_check_out_owner_list STRING,  
  lo_program_info         T_PROGRAM_INFO,
  ls_combobox             ui.Combobox,
  ls_combobox_text        STRING,
  lo_USER_INFO            T_USER_INFO, #160504-00002
  lo_release_DZLM_T       T_DZLM_T, #160504-00002
  lb_topstd_check_out     BOOLEAN,  #160420-00014 by ernest
  li_cnt                  INTEGER,  #20160304 by elena
  li_release_cnt          INTEGER,  #160504-00002
  li_release_index        INTEGER,  #160504-00002
  ls_role                 STRING,   #160504-00002
  ls_industry_type        STRING,   #161027-00001
  ls_identity             STRING,   #161028-00001 
  lb_success              BOOLEAN,  #161028-00001 
  lo_check_out_owner      T_CHECK_OUT_OWNER_LIST, #160504-00002
  lo_mark_info            T_MARK_INFORMATION,  #160504-00002
  lo_MERGE_SYNC_PARA      T_MERGE_SYNC_PARA #161027-00001 

  LET ls_temp_path = FGL_GETENV("TEMPDIR")
  LET ls_separator = os.Path.separator()

  LET ls_client_path = ms_client_path
  LET ls_get_last_ver = "Y"
  LET lb_full_check_out = FALSE
  LET gb_diff_download = FALSE #170208-00008

  LET lo_curr_window = ui.Window.getCurrent()
  LET lo_curr_form   = lo_curr_window.getForm()
  
  IF (mo_PARAMETER.p_PARAM1.toUpperCase() = "DEBUG") OR (mo_PARAMETER.p_PARAM1.toUpperCase() = "DIR") THEN
  
    DIALOG ATTRIBUTES(UNBUFFERED)

      INPUT ARRAY lo_demand_list FROM sr_demand_list.* ATTRIBUTE(WITHOUT DEFAULTS)
        BEFORE ROW
          LET li_arr_curr = ARR_CURR()
          IF (ms_user_name = cs_topstd_user_name) THEN
            CALL lo_curr_form.setElementHidden("btn_recall",TRUE)
          ELSE   
            #CALL lo_curr_form.setElementHidden("btn_recall",FALSE)
            #CALL lo_curr_form.setElementHidden("btn_recall",IIF(mb_debug,FALSE,TRUE)) #2015.01.16 改為全面隱藏   #20160304 mark by elena
            CALL lo_curr_form.setElementHidden("btn_recall",FALSE)   #20160304 by elena
          END IF 

          #161027-00001 begin
          #已經客制過且都沒有簽出才能作Merge or Sync
          LET lo_program_info.pi_DESC   = lo_demand_list[li_arr_curr].prog_desc
          LET lo_program_info.pi_TYPE   = lo_demand_list[li_arr_curr].spec_type
          #標準程式是否已簽出
          LET lo_program_info.pi_NAME   = lo_demand_list[li_arr_curr].origin_prog
          LET lo_program_info.pi_MODULE = lo_demand_list[li_arr_curr].origin_module
          CALL sadzp200_alm_check_item_if_exist(lo_program_info.*,cs_user_role_all) RETURNING lb_if_std_check_out
          
          #行業別判斷是否可Sync
          IF (lo_demand_list[li_arr_curr].spec_type = "M") AND
             ((ms_user_name <> cs_topstd_user_name) AND (NOT mb_customize)) AND
             (NOT adzp050_check_dzaq_if_synced(lo_demand_list[li_arr_curr].prog_name)) AND
             (NOT lb_if_std_check_out) AND 
             (ms_topind <> cs_industry_type_standard) AND
             (lo_demand_list[li_arr_curr].identity = cs_dgenv_standard) THEN  
            CALL lo_curr_form.setElementHidden("btn_sync",FALSE)
            CALL lo_curr_form.setElementHidden("btn_view_sync",FALSE)
          ELSE            
            CALL lo_curr_form.setElementHidden("btn_sync",TRUE)
            CALL lo_curr_form.setElementHidden("btn_view_sync",TRUE)
          END IF
          
          #標準判斷可否 Merge
          IF (lo_demand_list[li_arr_curr].spec_type <> "G") AND
             (lo_demand_list[li_arr_curr].spec_type <> "X") AND
             (lo_demand_list[li_arr_curr].merge_code = "N") AND 
             ((ms_user_name <> cs_topstd_user_name) AND mb_customize) AND 
             (lo_demand_list[li_arr_curr].identity = cs_dgenv_customize) THEN
            CALL lo_curr_form.setElementHidden("btn_merge",FALSE)
          ELSE
            CALL lo_curr_form.setElementHidden("btn_merge",TRUE)
          END IF 
          #161027-00001 end
          -- 161028-00001 begin
          #IF (ms_user_name <> cs_topstd_user_name) AND (ms_DGENV = cs_dgenv_customize) AND
          IF ((ms_user_name = cs_topstd_user_name) OR (ms_DGENV = cs_dgenv_customize)) AND
             sadzp050_zip_get_if_standard_to_customize(lo_demand_list[li_arr_curr].prog_name) THEN
            CALL lo_curr_form.setElementHidden("btn_download_standard",FALSE)
          ELSE  
            CALL lo_curr_form.setElementHidden("btn_download_standard",TRUE)
          END IF
          -- 161028-00001 end
          #170208-00008 begin
          IF (((ms_topind <> cs_industry_type_standard) OR (ms_DGENV = cs_dgenv_customize) OR (ms_user_name = cs_topstd_user_name)) AND (ms_download_type = cs_download_type_code)) THEN
            CALL lo_curr_form.setElementHidden("btn_diff_download",FALSE)
          ELSE 
            CALL lo_curr_form.setElementHidden("btn_diff_download",TRUE)
          END IF          
          #170208-00008 end          
          
        BEFORE INPUT
          LET ms_cursor_focus_on = cs_focus_on_demand #161027-00001
          CALL DIALOG.setActionHidden("insert",TRUE)
          CALL DIALOG.setActionHidden("append",TRUE)
          CALL DIALOG.setActionHidden("delete",TRUE)
          LET lo_demand_list.* = m_demand_list.*
          LET li_arr_curr = ARR_CURR()
          #依照選擇的清單
          CALL lo_curr_form.setElementHidden("btn_merge",TRUE)
          CALL lo_curr_form.setElementHidden("btn_check_out",TRUE)
          CALL lo_curr_form.setElementHidden("btn_full_check_out",TRUE)
          #CALL lo_curr_form.setElementHidden("btn_recall",IIF(mb_debug,FALSE,TRUE)) #2015.01.16 改為全面隱藏  #20160304 mark by elena 
          CALL lo_curr_form.setElementHidden("btn_recall",FALSE)   #20160304 by elena
          CALL lo_curr_form.setElementHidden("btn_sync",TRUE)
          CALL lo_curr_form.setElementHidden("btn_view_sync",TRUE)
          IF (ms_erpalm = "N") OR ((ms_DGENV = cs_dgenv_customize) AND (ms_erpalm = "Y")) THEN 
            CALL lo_curr_form.setElementHidden("btn_check_in",FALSE)
          END IF 
          -- 160504-00002 begin
          IF (ms_erpalm = "Y") AND (ms_user_name <> cs_topstd_user_name) AND (ms_DGENV = cs_dgenv_standard) THEN
            CALL lo_curr_form.setElementHidden("btn_release",FALSE)
          END IF
          -- 160504-00002 end

        {  
        ON ACTION btn_alm_view_data
          LET li_arr_curr = ARR_CURR()
          LET lo_program_info.pi_MODULE = lo_prog_list[li_arr_curr].module_name
          LET lo_program_info.pi_NAME   = lo_prog_list[li_arr_curr].prog_name
          LET lo_program_info.pi_DESC   = lo_prog_list[li_arr_curr].prog_desc

          CALL lo_template_list.clear()
          LET lb_result = TRUE
          CALL sadzp050_tple_run(lo_program_info.*,lo_template_list) RETURNING lb_result, lo_template_list
        }
        
        #勾選時, 只能勾選ALM或一般程式其中一項, 且有多個版本時, 也只能勾選其中一個版本
        ON CHANGE lbl_alm_ckb_select
          LET li_arr_curr = ARR_CURR()

          FOR li_index = 1 TO lo_demand_list.getLength()
            IF (li_index <> li_arr_curr) OR (lo_demand_list[li_arr_curr].prog_name IS NULL) THEN
              LET lo_demand_list[li_index].prog_selected = "N"
            END IF 
          END FOR
          
          {
          FOR li_index = 1 TO lo_prog_list.getLength()
            IF lo_prog_list[li_index].prog_name = lo_demand_list[li_arr_curr].prog_name THEN
              LET lo_prog_list[li_index].prog_selected = "N"
            END IF 
          END FOR
          FOR li_index = 1 TO lo_demand_list.getLength()
            IF (li_index <> li_arr_curr) AND (lo_demand_list[li_index].prog_name = lo_demand_list[li_arr_curr].prog_name) THEN
              LET lo_demand_list[li_index].prog_selected = "N"
            END IF 
          END FOR
          } 
          
          #啟動樣板選單
          LET li_arr_curr = ARR_CURR()
          IF lo_demand_list[li_arr_curr].spec_type = "G" AND (ms_download_type = cs_download_type_4rp OR ms_download_type = "ALL") THEN
            LET mb_result = FALSE
            LET lo_program_info.pi_MODULE = lo_demand_list[li_arr_curr].module_name
            LET lo_program_info.pi_NAME   = lo_demand_list[li_arr_curr].prog_name
            LET lo_program_info.pi_DESC   = lo_demand_list[li_arr_curr].prog_desc
            LET ls_identity               = lo_demand_list[li_arr_curr].identity -- 161028-00001
            
            #CALL mo_template_list.clear()
            IF lo_demand_list[li_arr_curr].prog_selected = "Y" THEN
              CALL sadzp050_tple_get_template_records(ms_lang,lo_program_info.*,mo_template_list) RETURNING mb_result, mo_template_list -- 161028-00001 
            ELSE
              CALL sadzp050_tple_remove_template_records(lo_program_info.*,mo_template_list) RETURNING mb_result, mo_template_list
            END IF   
            
            {
            CALL sadzp050_tple_run(lo_program_info.*,mo_template_list) RETURNING mb_result, mo_template_list
            
            LET lo_demand_list[li_arr_curr].prog_selected = "N"
            IF mb_result THEN
              FOR li_index = 1 TO mo_template_list.getLength()
                IF mo_template_list[li_index].tl_COMPONENT = lo_demand_list[li_arr_curr].prog_name THEN
                  IF mo_template_list[li_index].FRP_LIST.getLength() >= 1 THEN
                    LET lo_demand_list[li_arr_curr].prog_selected = "Y"
                    EXIT FOR
                  END IF 
                END IF 
              END FOR 
            END IF
            } 
            
          END IF 
          
      END INPUT
      
      INPUT ARRAY lo_prog_list FROM sr_ProgList.* ATTRIBUTE(WITHOUT DEFAULTS)
        BEFORE ROW
          LET li_arr_curr = ARR_CURR()
          #判斷是否可以 Check Out
          IF ((ms_user_name = cs_topstd_user_name) AND (lo_prog_list[li_arr_curr].version IS NULL)) OR
             (ms_enable_checkout = "N") OR 
             (lo_prog_list[li_arr_curr].module_name = "LIB" AND NOT mb_enable_checkout_lib AND ms_user_name <> cs_topstd_user_name) THEN
            CALL lo_curr_form.setElementHidden("btn_check_out",TRUE)
            CALL lo_curr_form.setElementHidden("btn_full_check_out",TRUE)
          ELSE   

            #20160128 begin
            IF (
                 (lo_prog_list[li_arr_curr].spec_type = "M") OR
                 (lo_prog_list[li_arr_curr].spec_type = "Q") OR
                 (lo_prog_list[li_arr_curr].spec_type = "S")
               ) AND (ms_download_type = cs_download_type_spec) THEN
              IF (lo_prog_list[li_arr_curr].sd_ver IS NULL) AND (lo_prog_list[li_arr_curr].pg_ver IS NULL) THEN
                LET lb_hide_full_check_out = FALSE 
              ELSE  
                LET lb_hide_full_check_out = TRUE 
              END IF   
            ELSE   
              LET lb_hide_full_check_out = TRUE 
            END IF 
            #20160128 end
          
            #Q類特別判斷, 若版次為空值時, 就只能按同時簽出程式
            IF (lo_prog_list[li_arr_curr].spec_type = "Q") THEN 
              IF (lo_prog_list[li_arr_curr].version IS NULL) THEN 
                IF (ms_download_type = cs_download_type_spec) THEN
                  LET lb_hide_check_out = TRUE
                  #LET lb_hide_full_check_out = FALSE #20160128
                ELSE  
                  LET lb_hide_check_out = TRUE
                  #LET lb_hide_full_check_out = TRUE #20160128
                END IF
              ELSE  
                LET lb_hide_check_out = FALSE
                #LET lb_hide_full_check_out = IIF(ms_download_type == cs_download_type_spec AND (lo_prog_list[li_arr_curr].spec_type <> "F"),FALSE,TRUE) #20160128
              END IF  
            ELSE
              LET lb_hide_check_out = FALSE
              #LET lb_hide_full_check_out = IIF(ms_download_type == cs_download_type_spec AND (lo_prog_list[li_arr_curr].spec_type <> "F"),FALSE,TRUE) #20160128
            END IF
            
            CALL lo_curr_form.setElementHidden("btn_check_out",lb_hide_check_out)
            CALL lo_curr_form.setElementHidden("btn_full_check_out",lb_hide_full_check_out)
            
          END IF

          #已經客制過且都沒有簽出才能作Merge or Sync
          LET lo_program_info.pi_NAME   = lo_prog_list[li_arr_curr].prog_name
          LET lo_program_info.pi_DESC   = lo_prog_list[li_arr_curr].prog_desc
          LET lo_program_info.pi_MODULE = lo_prog_list[li_arr_curr].module_name
          LET lo_program_info.pi_TYPE   = lo_prog_list[li_arr_curr].spec_type
          #程式本體是否已簽出(含行業程式)
          CALL sadzp200_alm_check_item_if_exist(lo_program_info.*,cs_user_role_all) RETURNING lb_if_check_out
          #標準程式是否已簽出
          LET lo_program_info.pi_NAME   = lo_prog_list[li_arr_curr].origin_prog
          LET lo_program_info.pi_MODULE = lo_prog_list[li_arr_curr].origin_module
          CALL sadzp200_alm_check_item_if_exist(lo_program_info.*,cs_user_role_all) RETURNING lb_if_std_check_out
          
          #行業別判斷是否可Sync
          IF (lo_prog_list[li_arr_curr].spec_type = "M") AND
             (lo_prog_list[li_arr_curr].sync_code = "N") AND #161027-00001
             ((ms_user_name <> cs_topstd_user_name) AND (NOT mb_customize)) AND
             (NOT lb_if_check_out) AND
             #(NOT adzp050_check_dzaq_if_synced(lo_prog_list[li_arr_curr].prog_name)) AND #161027-00001 mark
             (ms_topind <> cs_industry_type_standard) AND #161027-00001
             (NOT lb_if_std_check_out) AND 
             (lo_prog_list[li_arr_curr].identity = cs_dgenv_standard)THEN  
            CALL lo_curr_form.setElementHidden("btn_sync",FALSE)
            CALL lo_curr_form.setElementHidden("btn_view_sync",FALSE)
          ELSE            
            CALL lo_curr_form.setElementHidden("btn_sync",TRUE)
            CALL lo_curr_form.setElementHidden("btn_view_sync",TRUE)
          END IF
          
          #標準判斷可否 Merge
          IF (lo_prog_list[li_arr_curr].spec_type <> "G") AND
             (lo_prog_list[li_arr_curr].spec_type <> "X") AND
             (lo_prog_list[li_arr_curr].merge_code = "N") AND 
             (NOT lb_if_check_out) AND 
             ((ms_user_name <> cs_topstd_user_name) AND mb_customize) AND 
             (lo_prog_list[li_arr_curr].identity = cs_dgenv_customize) THEN
            CALL lo_curr_form.setElementHidden("btn_merge",FALSE)
          ELSE
            CALL lo_curr_form.setElementHidden("btn_merge",TRUE)
          END IF
          
          -- 161028-00001 begin
          #IF (ms_user_name <> cs_topstd_user_name) AND (ms_DGENV = cs_dgenv_customize) AND
          IF ((ms_user_name = cs_topstd_user_name) OR (ms_DGENV = cs_dgenv_customize)) AND
             sadzp050_zip_get_if_standard_to_customize(lo_prog_list[li_arr_curr].prog_name) THEN
            CALL lo_curr_form.setElementHidden("btn_download_standard",FALSE)
          ELSE  
            CALL lo_curr_form.setElementHidden("btn_download_standard",TRUE)
          END IF
          -- 161028-00001 end          
          #170208-00008 begin
          IF (((ms_topind <> cs_industry_type_standard) OR (ms_DGENV = cs_dgenv_customize) OR (ms_user_name = cs_topstd_user_name)) AND (ms_download_type = cs_download_type_code)) THEN
            CALL lo_curr_form.setElementHidden("btn_diff_download",FALSE)
          ELSE 
            CALL lo_curr_form.setElementHidden("btn_diff_download",TRUE)
          END IF          
          #170208-00008 end          
          
        BEFORE INPUT
          LET ms_cursor_focus_on = cs_focus_on_program #161027-00001
          LET li_arr_curr = ARR_CURR()
          CALL DIALOG.setActionHidden("insert",TRUE)
          CALL DIALOG.setActionHidden("append",TRUE)
          CALL DIALOG.setActionHidden("delete",TRUE)
          LET lo_prog_list.* = m_prog_list.*
          #依照選擇的清單
          CALL lo_curr_form.setElementHidden("btn_merge",TRUE)
          CALL lo_curr_form.setElementHidden("btn_check_out",FALSE)
          CALL lo_curr_form.setElementHidden("btn_full_check_out",FALSE)
          CALL lo_curr_form.setElementHidden("btn_recall",TRUE)   
          CALL lo_curr_form.setElementHidden("btn_sync",TRUE)
          CALL lo_curr_form.setElementHidden("btn_view_sync",TRUE)
          IF (ms_erpalm = "N") OR ((ms_DGENV = cs_dgenv_customize) AND (ms_erpalm = "Y")) THEN 
            CALL lo_curr_form.setElementHidden("btn_check_in",TRUE)
          END IF   
          -- 160504-00002 begin
          CALL lo_curr_form.setElementHidden("btn_release",TRUE)
          -- 160504-00002 end

        {  
        ON ACTION btn_view_data
          LET li_arr_curr = ARR_CURR()
          LET lo_program_info.pi_MODULE = lo_prog_list[li_arr_curr].module_name
          LET lo_program_info.pi_NAME   = lo_prog_list[li_arr_curr].prog_name
          LET lo_program_info.pi_DESC   = lo_prog_list[li_arr_curr].prog_desc

          CALL lo_template_list.clear()
          LET lb_result = TRUE
          CALL sadzp050_tple_run(lo_program_info.*,lo_template_list) RETURNING lb_result, lo_template_list
        }
        
        #勾選時, 只能勾選ALM或一般程式其中一項, 且有多個版本時, 也只能勾選其中一個版本
        ON CHANGE lbl_ckb_Select
          LET li_arr_curr = ARR_CURR()
          FOR li_index = 1 TO lo_prog_list.getLength()
            IF (li_index <> li_arr_curr) THEN
              LET lo_prog_list[li_index].prog_selected = "N"
            END IF 
          END FOR

          {
          FOR li_index = 1 TO lo_demand_list.getLength()
            IF lo_demand_list[li_index].prog_name = lo_prog_list[li_arr_curr].prog_name THEN
              LET lo_demand_list[li_index].prog_selected = "N"
            END IF 
          END FOR
          FOR li_index = 1 TO lo_prog_list.getLength()
            IF (li_index <> li_arr_curr) AND (lo_prog_list[li_index].prog_name = lo_prog_list[li_arr_curr].prog_name) THEN
              LET lo_prog_list[li_index].prog_selected = "N"
            END IF 
          END FOR
          }

          #啟動樣板選單
          LET li_arr_curr = ARR_CURR()
          IF lo_prog_list[li_arr_curr].spec_type = "G" AND (ms_download_type = cs_download_type_4rp OR ms_download_type = cs_download_type_code OR ms_download_type = "ALL") THEN
            LET mb_result = FALSE
            LET lo_program_info.pi_MODULE = lo_prog_list[li_arr_curr].module_name
            LET lo_program_info.pi_NAME   = lo_prog_list[li_arr_curr].prog_name
            LET lo_program_info.pi_DESC   = lo_prog_list[li_arr_curr].prog_desc
            LET ls_identity               = lo_prog_list[li_arr_curr].identity -- 161028-00001

            #CALL mo_template_list.clear()
            IF lo_prog_list[li_arr_curr].prog_selected = "Y" THEN
              CALL sadzp050_tple_get_template_records(ms_lang,lo_program_info.*,mo_template_list) RETURNING mb_result, mo_template_list -- 161028-00001
            ELSE
              CALL sadzp050_tple_remove_template_records(lo_program_info.*,mo_template_list) RETURNING mb_result, mo_template_list
            END IF   
            
            {
            #挑選模式
            CALL sadzp050_tple_run(lo_program_info.*,mo_template_list) RETURNING mb_result, mo_template_list

            LET lo_prog_list[li_arr_curr].prog_selected = "N"
            IF mb_result THEN
              FOR li_index = 1 TO mo_template_list.getLength()
                IF mo_template_list[li_index].tl_COMPONENT = lo_prog_list[li_arr_curr].prog_name THEN
                  IF mo_template_list[li_index].FRP_LIST.getLength() >= 1 THEN
                    LET lo_prog_list[li_arr_curr].prog_selected = "Y"
                    EXIT FOR
                  END IF 
                END IF 
              END FOR 
            END IF
            }
            
          END IF 
          
      END INPUT


      INPUT ls_module FROM cb_DownloadModule ATTRIBUTE(WITHOUT DEFAULTS)
     
        ON CHANGE cb_DownloadModule
          LET ls_download_type = ms_download_type
          #Begin:20151221 by elena
          IF ms_view_checkout == "Y" THEN
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
          ELSE
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,ls_chk_spec_type,ls_download_type,ms_search) #20151130 by elena
          END IF
          #End:20151221
          CALL DIALOG.setArrayAttributes("sr_demand_list", m_demand_list_color)
          #CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena
          CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql 
          CALL adzp050_fill_all_list(ls_sql)

      END INPUT

      INPUT ls_chk_spec_type FROM cb_spec_type ATTRIBUTE(WITHOUT DEFAULTS)
        ON CHANGE cb_spec_type
          LET ls_download_type = ms_download_type
          #Begin:20151221 by elena
          IF ms_view_checkout == "Y" THEN
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
          ELSE
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,ls_chk_spec_type,ls_download_type,ms_search) #20151130 by elena 
          END IF
          #End:20151221
          CALL DIALOG.setArrayAttributes("sr_demand_list", m_demand_list_color)
          #CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena
          CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
          CALL adzp050_fill_all_list(ls_sql)
      END INPUT

      INPUT ms_search FROM ed_Search ATTRIBUTE(WITHOUT DEFAULTS)
        #170124-00031 begin
        ON CHANGE ed_search
          IF ms_search.trim() IS NOT NULL THEN GOTO _search END IF
        #170124-00031 end
      END INPUT

      INPUT ms_view_mergeable FROM chk_view_mergeable ATTRIBUTE(WITHOUT DEFAULTS)
        ON CHANGE chk_view_mergeable
          #CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena
          CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
          CALL adzp050_fill_all_list(ls_sql)
      END INPUT

      #BEGIN:20151221 by elena 
      INPUT ms_view_checkout FROM chk_view_checkout ATTRIBUTE(WITHOUT DEFAULTS)
        ON CHANGE chk_view_checkout
        IF ms_view_checkout =="Y" THEN
          CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
        ELSE
          CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,ls_chk_spec_type,ls_download_type,ms_search)       
        END IF 
      END INPUT

      #END:20151221 by elena
     
      #BEGIN:20151231 by elena
      INPUT ms_modulefolder FROM chk_modulefolder ATTRIBUTE(WITHOUT DEFAULTS)
        ON CHANGE chk_modulefolder
          
      END INPUT
      #END:20151231 by elena     

      #161028-00001 begin
      INPUT ms_view_std_to_cust FROM chk_view_std_to_cust ATTRIBUTE(WITHOUT DEFAULTS)
        ON CHANGE chk_view_std_to_cust
          IF ms_view_checkout == "Y" THEN
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ms_download_type,"")
          ELSE
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,ls_chk_spec_type,ms_download_type,ms_search)
          END IF
          CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
          CALL adzp050_fill_all_list(ls_sql)
      END INPUT
      #161028-00001 end
 
      INPUT lb_download_all FROM lbl_download_all ATTRIBUTE(WITHOUT DEFAULTS)
        ON CHANGE lbl_download_all
          LET mb_download_all = lb_download_all
          LET ls_download_type = ms_download_type
          #Begin:20151221 by elena
          IF ms_view_checkout == "Y" THEN
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
          ELSE
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,ls_chk_spec_type,ls_download_type,ms_search) #20151130 by elena
          END IF
          #End:20151221 by elena
          CALL DIALOG.setArrayAttributes("sr_demand_list", m_demand_list_color)
          #CALL adzp050_get_all_list_sql(ms_erpalm,NVL(ms_search,ls_module),ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena
          CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
          CALL adzp050_fill_all_list(ls_sql)
      END INPUT

      #在Debug mode 才有用
      INPUT ls_get_last_ver FROM lbl_get_last_version ATTRIBUTE(WITHOUT DEFAULTS)
        ON CHANGE lbl_get_last_version
          LET ls_download_type = ms_download_type
          #CALL adzp050_fill_demand_list(ms_erpalm,ms_user,NVL(ms_search,ls_module),ls_chk_spec_type,ls_download_type)  #20151130 by elena
          #Begin:20151221 by elena
          IF ms_view_checkout == "Y" THEN
          ELSE
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,ls_chk_spec_type,ls_download_type,ms_search)
          END IF
          #End:20151221 by elena
          CALL DIALOG.setArrayAttributes("sr_demand_list", m_demand_list_color)
          #CALL adzp050_get_all_list_sql(ms_erpalm,NVL(ms_search,ls_module),ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena
          CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
          CALL adzp050_fill_all_list(ls_sql)
      END INPUT

      #在Debug mode 才有用
      INPUT ls_enable_alm FROM chk_enable_alm ATTRIBUTE(WITHOUT DEFAULTS)
        ON CHANGE chk_enable_alm
          LET ms_erpalm = ls_enable_alm
          CALL adzp050_set_alm_element_visible(DIALOG)
          CALL DIALOG.setCurrentRow("sr_demand_list", 1)
          #CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ms_search,"",ls_download_type) #20151130 by elena
          #Begin:20151221 by elena
          IF ms_view_checkout == "Y" THEN
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
          ELSE
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,"",ls_download_type,ms_search)
          END IF
          #End:20151221 by elena
          CALL DIALOG.setArrayAttributes("sr_demand_list", m_demand_list_color)
          #CALL adzp050_get_all_list_sql(ms_erpalm,NVL(ms_search,ls_module),"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena
          CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
          CALL adzp050_fill_all_list(ls_sql)
      END INPUT
      
      #在Debug mode 才有用
      INPUT ls_enable_customize FROM chk_enable_customize ATTRIBUTE(WITHOUT DEFAULTS)
        ON CHANGE chk_enable_customize
          LET mb_customize = IIF(ls_enable_customize=="Y",TRUE,FALSE)
          LET ms_DGENV = IIF(mb_customize,cs_dgenv_customize,cs_dgenv_standard)
          CALL adzp050_refill_combobox(mb_customize,ms_lang)
          #CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ms_search,"",ls_download_type) #20151130 by elena
          #Begin:20151221 by elena
          IF ms_view_checkout == "Y" THEN
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
          ELSE
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,"",ls_download_type,ms_search)
          END IF
          #End:20151221 by elena
          CALL DIALOG.setArrayAttributes("sr_demand_list", m_demand_list_color)
          #CALL adzp050_get_all_list_sql(ms_erpalm,NVL(ms_search,ls_module),"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena
          CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
          CALL adzp050_fill_all_list(ls_sql)
      END INPUT

      BEFORE DIALOG
        LET lo_win = ui.Window.getCurrent()
        LET ls_top_env = FGL_GETENV(cs_top_module_name)
        LET ls_download_type = ms_download_type
        
        LET ls_combobox = ui.ComboBox.forName("formonly.cb_downloadmodule")  #20151130 by elena
        LET ls_combobox_text = ls_combobox.getItemName(1)     
 
        #20151223 by elena  checkbox給定預設值
        LET ms_view_checkout = "N"
        LET ms_view_mergeable = "N"
        LET ls_enable_alm = "N"
        LET ls_enable_customize = "N"
        LET ms_modulefolder = "N"
        LET ms_view_std_to_cust = "N" #161028-00001

        CALL lo_win.setImage("logo/dsc_logo.ico")
        #CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_combobox_text,"",ls_download_type,ms_search)
        CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,ms_search)  #20151130 by elena
        CALL DIALOG.setArrayAttributes("sr_demand_list", m_demand_list_color)
        #CALL adzp050_get_all_list_sql(ms_erpalm,"","",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql
        LET mb_initial_run = TRUE  #170124-00031
        CALL adzp050_get_all_list_sql(ms_erpalm,ls_combobox_text,"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
        CALL adzp050_fill_all_list(ls_sql)
        LET mb_initial_run = FALSE #170124-00031
        LET lo_prog_list.* = m_prog_list.*
        LET lo_demand_list.* = m_demand_list.*
        CALL adzp050_set_alm_element_visible(DIALOG)

        #當為4RP時, 類型固定在 G 類
        IF ms_download_type = cs_download_type_4rp THEN
          LET ls_chk_spec_type = "G"
          CALL DIALOG.setFieldActive("cb_spec_type",FALSE)
          CALL lo_curr_form.setElementHidden("btn_view_template",FALSE)
        ELSE  
          CALL lo_curr_form.setElementHidden("btn_view_template",TRUE)
        END IF 

      #170208-00008 begin  
      ON ACTION btn_diff_download
        LET gb_diff_download = TRUE
        GOTO _btn_Download
      #170208-00008 end  
      
      ON ACTION btn_Download
        LABEL _btn_Download:
        LET lb_selected = FALSE
        FOR li_index = 1 TO lo_prog_list.getLength()
          IF lo_prog_list[li_index].prog_selected = "Y" THEN
            LET lb_selected = TRUE
          END IF 
        END FOR
        FOR li_index = 1 TO lo_demand_list.getLength()
          IF lo_demand_list[li_index].prog_selected = "Y" THEN
            LET lb_selected = TRUE
          END IF 
        END FOR
        IF NOT lb_selected THEN
          LET ls_err_code = "adz-00343"
          LET ls_err_msg  = "|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          CONTINUE DIALOG
        END IF 
        LET ls_download_type = ms_download_type
        CALL lo_curr_form.setElementHidden("formonly.pgb_main",FALSE) #161004-00011
        CALL adzp050_multi_alm_download(DIALOG,ls_module_name,ls_download_type)
        CALL adzp050_multi_download(DIALOG,ls_module_name,ls_download_type)
        CALL cl_ask_confirm3('adz-00163',"")
        CALL lo_curr_form.setElementHidden("formonly.pgb_main",TRUE) #161004-00011
        LET gb_diff_download = FALSE #170208-00008
        CALL adzp050_show_debug_info()

      ON ACTION act_search_data
        LABEL _search:
        LET ls_download_type = ms_download_type
        #CALL adzp050_fill_demand_list(ms_erpalm,ms_user,NVL(ms_search,ls_module),"",ls_download_type)  #20151130 by elena 
        #Begin:20151221 by elena
        IF ms_view_checkout == "Y" THEN
          CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
        ELSE
          CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,ls_chk_spec_type,ls_download_type,ms_search) 
        END IF
        #End:20151221 by elena
        CALL DIALOG.setArrayAttributes("sr_demand_list", m_demand_list_color)
        #CALL adzp050_get_all_list_sql(ms_erpalm,NVL(ms_search,ls_module),"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena
        CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
        CALL adzp050_fill_all_list(ls_sql)

      ON ACTION btn_full_check_out
        LET lb_full_check_out = TRUE
        GOTO _btn_check_out
        
      ON ACTION btn_check_out
        LABEL _btn_check_out:
        LET lb_selected = FALSE
        LET li_check_out_cnt = 0
        LET li_arr_curr = ARR_CURR()
        FOR li_index = 1 TO lo_prog_list.getLength()
          IF lo_prog_list[li_index].prog_selected = "Y" THEN
            LET lb_selected = TRUE
            LET li_check_out_cnt = li_check_out_cnt + 1
          END IF 
        END FOR
        #未勾選任何項目提示
        IF NOT lb_selected THEN
          LET ls_err_code = "adz-00286"
          LET ls_err_msg  = "|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          CONTINUE DIALOG
        END IF 
        #同時僅能簽出一隻程式
        IF li_check_out_cnt >= 2 THEN
          LET ls_err_code = "adz-00357"
          LET ls_err_msg  = "|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          CONTINUE DIALOG
        END IF

        #161028-00001 begin
        IF (ms_user_name = cs_topstd_user_name) THEN
          CASE 
            WHEN ms_download_type = cs_download_type_spec
              #topstd 帳號是為了改標準Bug,Patch 會覆蓋掉. 
              LET ls_err_code = "adz-00931"
            WHEN ms_download_type = cs_download_type_code
              #topstd 帳號是為了改標準Bug,Patch 會覆蓋掉.
              LET ls_err_code = "adz-00932"
          END CASE  
          LET ls_err_msg  = "|"
          CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, 1)
        END IF
        #161028-00001 end

        #Begin:20160323 by elena 
        #判斷是否為行業區域
        IF NOT sadzp060_ind_check_area() THEN
           #標準區域：不可簽出行業程式
           IF ms_dgenv = 's' THEN 
              #IF sadzp060_ind_check_industry_prog(lo_prog_list[li_arr_curr].prog_name) THEN
              IF lo_prog_list[li_arr_curr].industry_type<>cs_industry_type_standard THEN #20160520 by Hiko
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = "adz-00810"   #標準環境不可簽岀行業程式.
                 LET g_errparam.extend = ""
                 LET g_errparam.popup = TRUE
                 LET g_errparam.replace[1] = lo_prog_list[li_arr_curr].prog_name
                 CALL cl_err()
                 LET lo_prog_list[li_arr_curr].prog_selected = "N"
                 CONTINUE DIALOG
              END IF
           END IF
        ELSE
           #行業區域：不可簽出標準程式
           #IF NOT sadzp060_ind_check_industry_prog(lo_prog_list[li_arr_curr].prog_name) THEN
           IF lo_prog_list[li_arr_curr].industry_type=cs_industry_type_standard THEN #20160520 by Hiko
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = "adz-00814"  #行業環境不可簽出標準程式
              LET g_errparam.extend = ""
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = lo_prog_list[li_arr_curr].prog_name
              CALL cl_err()
              LET lo_prog_list[li_arr_curr].prog_selected = "N"
              CONTINUE DIALOG
           END IF
        END IF
        #End:20160323 by elena

        #begin 160420-00014 by ernest 
        #topstd簽出客製程式
        IF (ms_user_name = cs_topstd_user_name) AND (lo_prog_list[li_arr_curr].identity = cs_dgenv_customize) THEN
           
          LET lb_topstd_check_out = TRUE
          
          CASE 
            WHEN ls_download_type = cs_download_type_spec
              IF (lo_prog_list[li_arr_curr].spec_type = "M") OR (lo_prog_list[li_arr_curr].spec_type = "S") THEN
                IF (NVL(lo_prog_list[li_arr_curr].sd_ver,0) <> 1) THEN 
                  LET lb_topstd_check_out = FALSE
                END IF
              ELSE  
                LET lb_topstd_check_out = FALSE
              END IF 
            WHEN ls_download_type = cs_download_type_code
              IF NVL(lo_prog_list[li_arr_curr].pg_ver,0) = 0 THEN 
                LET lb_topstd_check_out = FALSE
              END IF
          END CASE   

          IF NOT lb_topstd_check_out THEN 
            LET ls_err_code = "adz-00420"
            LET ls_err_msg  = cs_topstd_user_name,"|"
            CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
            LET lo_prog_list[li_arr_curr].prog_selected = "N"
            CONTINUE DIALOG
          END IF  
          
        END IF 
        #end 160420-00014 by ernest 
        
        #AZZ,ADZ模組在客戶家不能簽出 -- 160504-00002
        IF ((lo_prog_list[li_arr_curr].module_name = "ADZ") OR (lo_prog_list[li_arr_curr].module_name = "AZZ")) AND ms_dgenv = cs_dgenv_customize THEN
          LET ls_err_code = "adz-00421"
          LET ls_err_msg  = lo_prog_list[li_arr_curr].module_name,"|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          LET lo_prog_list[li_arr_curr].prog_selected = "N"
          CONTINUE DIALOG
        END IF
        
        #判斷是否要執行同步簽出規格及程式(只有規格能夠同時簽出)
        IF lb_full_check_out AND (ms_download_type = cs_download_type_spec) THEN 
          LET lo_prog_list[li_arr_curr].prog_selected = "Y"
          CALL adzp050_alm_check_out(cs_download_type_spec) RETURNING lb_result        
          IF lb_result THEN 
            LET lo_prog_list[li_arr_curr].prog_selected = "Y"
            CALL adzp050_alm_check_out(cs_download_type_code) RETURNING lb_result
          END IF  
        ELSE
          CALL adzp050_alm_check_out(ls_download_type) RETURNING lb_result
        END IF
        LET lb_full_check_out = FALSE
        #CALL adzp050_fill_demand_list(ms_erpalm,ms_user,NVL(ms_search,ls_module),"",ls_download_type) #20151130 by elena mark
        #BEGIN:20151221 by elena 
        IF ms_view_checkout == "Y" THEN
          CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
        ELSE
          #CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,"",ls_download_type,ms_search)  #20160308 by elena 增加ls_chk_spec_type，避免簽出後查詢資料未參考類型
          CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,ls_chk_spec_type,ls_download_type,ms_search)
        END IF
        #END:20151221 by elena
        CALL DIALOG.setArrayAttributes("sr_demand_list", m_demand_list_color)
        #CALL adzp050_get_all_list_sql(ms_erpalm,NVL(ms_search,ls_module),"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena mark
        CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,ls_chk_spec_type,IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
        CALL adzp050_fill_all_list(ls_sql)

      ON ACTION btn_recall

        #Begin:20160304 by elena 依程式建構版次提示使用adzp063方法
        FOR li_index = 1 TO lo_demand_list.getLength()
          IF lo_demand_list[li_index].prog_selected = "Y" THEN

 
             IF lo_demand_list[li_index].version > 1 THEN
               IF lo_demand_list[li_index].version == 2 THEN
                  LET ls_sql = "select count(*) from dzax_t where dzax001=? "
                  PREPARE query_dzax_t FROM ls_sql
                  EXECUTE query_dzax_t USING lo_demand_list[li_index].prog_name INTO li_cnt 

                  IF li_cnt == 2 THEN
                     #版次大於1，標準轉客製
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "adz-00789"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  ELSE
                     #版次大於1，且非標準轉客製
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "adz-00787"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF

                ELSE
                   #版次大於1，且非標準轉客製   
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code =  "adz-00787"
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                END IF
               
             END IF

             IF lo_demand_list[li_index].version == 1 THEN
                #版次等於1
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code =  "adz-00788"
                LET g_errparam.popup = TRUE
                CALL cl_err()
             END IF
           END IF
     END FOR       
 

        #End:20160304 by elena 

        #Begin:20160304 by elena 註解程式
        #LET lb_selected = FALSE
        #LET li_uncheck_out_cnt = 0
        #FOR li_index = 1 TO lo_demand_list.getLength()
        #  IF lo_demand_list[li_index].prog_selected = "Y" THEN
        #    LET lb_selected = TRUE
        #    LET li_uncheck_out_cnt = li_uncheck_out_cnt + 1
        #  END IF 
        #END FOR
        ##未勾選任何項目提示
        #IF NOT lb_selected THEN
        #  LET ls_err_code = "adz-00288"
        #  LET ls_err_msg  = "|"
        #  CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
        #  CONTINUE DIALOG
        #END IF 
        ##同時僅能取消簽出一隻程式
        #IF li_uncheck_out_cnt >= 2 THEN
        #  LET ls_err_code = "adz-00358"
        #  LET ls_err_msg  = "|"
        #  CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
        #  CONTINUE DIALOG
        #END IF 
        #CALL adzp050_alm_recall(ls_download_type)
        ##CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ms_search,"",ls_download_type)  #20151130 by elena
        ##Begin:20151221 by elena
        #IF ms_view_checkout == "Y" THEN
        #  CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
        #ELSE
        #  CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,"",ls_download_type,ms_search)
        #END IF
        ##End:20151221 by elena
        #CALL DIALOG.setArrayAttributes("sr_demand_list", m_demand_list_color)
        ##CALL adzp050_get_all_list_sql(ms_erpalm,NVL(ms_search,ls_module),"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena
        #CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
        #CALL adzp050_fill_all_list(ls_sql)
        #End:20160304 by elena     

      -- 160504-00002 begin   
      ON ACTION btn_release
        LET lb_selected = FALSE
        LET li_release_cnt = 0
        FOR li_index = 1 TO lo_demand_list.getLength()
          IF lo_demand_list[li_index].prog_selected = "Y" THEN
            LET lb_selected = TRUE
            LET li_release_cnt = li_release_cnt + 1
            LET li_release_index = li_index
          END IF 
        END FOR
        #未勾選任何項目提示
        IF NOT lb_selected THEN
          LET ls_err_code = "adz-00852"
          LET ls_err_msg  = "|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          CONTINUE DIALOG
        END IF 
        LET lo_USER_INFO.ui_NUMBER = ms_user
        LET lo_USER_INFO.ui_NAME   = cl_get_accountname(ms_user)
        LET lo_USER_INFO.ui_LANG   = ms_lang
        LET lo_USER_INFO.ui_ROLE   = sadzp50_get_download_match_type(ls_download_type)
        CALL adzp050_set_dzlm_data_from_screen_array(lo_demand_list[li_release_index].*,lo_USER_INFO.*) RETURNING lo_release_DZLM_T.*
        LET ls_role = sadzp50_get_download_match_type(ls_download_type)
        CALL sadzp200_alm_check_if_could_release(lo_release_DZLM_T.*,ls_role) RETURNING ls_result,ls_res_code,lo_mark_info.*,lo_check_out_owner.*
        CASE
          #曾過正&階段<=QC,不能釋出
          WHEN ls_result = cs_release_no
            LET ls_err_code = ls_res_code
            LET ls_err_msg  = "|"
            CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
            CONTINUE DIALOG 
          #曾過正(dzlm022='P')&階段>QC,或者已經 remark掉修改段就可以釋出   
          WHEN ls_result = cs_release_yes
            LET ls_err_msg = NULL
            IF lo_check_out_owner.cool_ID IS NOT NULL THEN 
              LET ls_err_msg  = lo_check_out_owner.cool_ROLE,"|",lo_check_out_owner.cool_ID,"|"
            END IF 
           CALL sadzp000_msg_question_box(ls_res_code,ls_res_code,ls_err_msg,0) RETURNING ls_result
           IF ls_result = cs_response_yes THEN 
              CALL adzp050_alm_check_in(ls_download_type,TRUE)
              IF ms_view_checkout == "Y" THEN
                CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
              ELSE
                CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,"",ls_download_type,ms_search)
              END IF
              CALL DIALOG.setArrayAttributes("sr_demand_list", m_demand_list_color)
              CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
              CALL adzp050_fill_all_list(ls_sql)
            END IF
          #未曾過正,必須要還原(remark掉本次修改)才能釋出   
          WHEN ls_result = cs_release_mark
            LET ls_err_code = ls_res_code
            LET ls_err_msg  = "|"
            CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
            LET ls_err_code = lo_mark_info.mi_code
            LET ls_err_msg  = "\n",
                              "Line no : ",lo_mark_info.mi_line_no,"\n",
                              "Code : ",lo_mark_info.mi_line_code,"|"
            CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
            CONTINUE DIALOG 
        END CASE 
      -- 160504-00002 end
      
      ON ACTION btn_check_in
        LET lb_selected = FALSE
        LET li_check_in_cnt = 0
        FOR li_index = 1 TO lo_demand_list.getLength()
          IF lo_demand_list[li_index].prog_selected = "Y" THEN
            LET lb_selected = TRUE
            LET li_check_in_cnt = li_check_in_cnt + 1
          END IF 
        END FOR
        #未勾選任何項目提示
        IF NOT lb_selected THEN
          LET ls_err_code = "adz-00325"
          LET ls_err_msg  = "|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          CONTINUE DIALOG
        END IF 
        #同時僅能簽入一隻程式
        IF li_check_in_cnt >= 2 THEN
          LET ls_err_code = "adz-00362"
          LET ls_err_msg  = "|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          CONTINUE DIALOG
        END IF 
        #161004-00011 begin
        IF (ms_DGENV = cs_dgenv_customize) AND (ms_erpalm = "Y") THEN  
           LET ls_err_code = "adz-00903"
           CALL sadzp000_msg_question_box(ls_err_code,ls_err_code,"",0) RETURNING ls_result
           IF ls_result <> cs_response_yes THEN
             CONTINUE DIALOG
           END IF 
        END IF
        #161004-00011 end
        CALL adzp050_alm_check_in(ls_download_type,FALSE)
        #CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ms_search,"",ls_download_type)  #20151130 by elena
        #Begin:20151221 by elena
        IF ms_view_checkout == "Y" THEN
          CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
        ELSE
          CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,"",ls_download_type,ms_search)
        END IF
        #End:20151221 by elena
        CALL DIALOG.setArrayAttributes("sr_demand_list", m_demand_list_color)
        #CALL adzp050_get_all_list_sql(ms_erpalm,NVL(ms_search,ls_module),"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena
        CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
        CALL adzp050_fill_all_list(ls_sql)

      ON ACTION btn_view_template
        LET ls_current_item = DIALOG.getCurrentItem()
        CASE 
          WHEN ls_current_item = "sr_demand_list.lbl_alm_ckb_select" 
            LET li_arr_curr = ARR_CURR()
            LET lo_program_info.pi_MODULE = lo_demand_list[li_arr_curr].module_name
            LET lo_program_info.pi_NAME   = lo_demand_list[li_arr_curr].prog_name
            LET lo_program_info.pi_DESC   = lo_demand_list[li_arr_curr].prog_desc
          WHEN ls_current_item = "sr_proglist.lbl_ckb_select" 
            LET li_arr_curr = ARR_CURR()
            LET lo_program_info.pi_MODULE = lo_prog_list[li_arr_curr].module_name
            LET lo_program_info.pi_NAME   = lo_prog_list[li_arr_curr].prog_name
            LET lo_program_info.pi_DESC   = lo_prog_list[li_arr_curr].prog_desc
        END CASE

        CALL lo_template_list.clear()
        LET lb_result = TRUE
        CALL sadzp050_tple_run(lo_program_info.*,lo_template_list) RETURNING lb_result, lo_template_list

      ON ACTION btn_view_alm
        LET ls_current_item = DIALOG.getCurrentItem()
        CASE 
          WHEN ls_current_item = "sr_demand_list.lbl_alm_ckb_select" 
            LET li_arr_curr = ARR_CURR()
            LET lo_program_info.pi_TYPE   = lo_demand_list[li_arr_curr].spec_type
            LET lo_program_info.pi_MODULE = lo_demand_list[li_arr_curr].module_name
            LET lo_program_info.pi_NAME   = lo_demand_list[li_arr_curr].prog_name
            LET lo_program_info.pi_DESC   = lo_demand_list[li_arr_curr].prog_desc
          WHEN ls_current_item = "sr_proglist.lbl_ckb_select" 
            LET li_arr_curr = ARR_CURR()
            LET lo_program_info.pi_TYPE   = lo_prog_list[li_arr_curr].spec_type
            LET lo_program_info.pi_MODULE = lo_prog_list[li_arr_curr].module_name
            LET lo_program_info.pi_NAME   = lo_prog_list[li_arr_curr].prog_name
            LET lo_program_info.pi_DESC   = lo_prog_list[li_arr_curr].prog_desc
        END CASE
        CALL sadzp200_alm_get_owner_list(lo_program_info.*) RETURNING lo_check_out_owner_list 
        LET ls_check_out_owner_list = " " 
        FOR li_check_out_owner_list = 1 TO lo_check_out_owner_list.getLength()
          IF lo_check_out_owner_list[li_check_out_owner_list].cool_ROLE IS NOT NULL THEN 
            LET ls_check_out_owner_list = ls_check_out_owner_list,cs_CRLF,
                                          "Role : ",lo_check_out_owner_list[li_check_out_owner_list].cool_ROLE,cs_CRLF, 
                                          "ID : ",lo_check_out_owner_list[li_check_out_owner_list].cool_ID,cs_CRLF,
                                          "Name : ",lo_check_out_owner_list[li_check_out_owner_list].cool_NAME,cs_CRLF,
                                          "Request Number : ",lo_check_out_owner_list[li_check_out_owner_list].cool_REQUEST_NO,cs_CRLF,
                                          "Request Sequence : ",lo_check_out_owner_list[li_check_out_owner_list].cool_SEQUENCE_NO,cs_CRLF
          END IF                                                   
        END FOR
        
        LET ls_err_code = "adz-00389"
        LET ls_err_msg  = lo_program_info.pi_NAME,"|",ls_check_out_owner_list,"|"
        CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, 1)

      ON ACTION btn_merge
        LET g_patch_mode = TRUE
        IF cl_ask_confirm_parm("adz-00488","") THEN
          LET li_arr_curr = ARR_CURR()

          #161027-00001 begin
          IF ms_cursor_focus_on = cs_focus_on_program THEN 
            LET lo_MERGE_SYNC_PARA.msp_prog_name   = lo_prog_list[li_arr_curr].prog_name
            LET lo_MERGE_SYNC_PARA.msp_module_name = lo_prog_list[li_arr_curr].module_name
            LET lo_MERGE_SYNC_PARA.msp_spec_type   = lo_prog_list[li_arr_curr].spec_type
            LET lo_MERGE_SYNC_PARA.msp_dgenv       = lo_prog_list[li_arr_curr].identity
            LET lo_prog_list[li_arr_curr].prog_selected = "N"
          ELSE
            LET lo_MERGE_SYNC_PARA.msp_prog_name   = lo_demand_list[li_arr_curr].prog_name
            LET lo_MERGE_SYNC_PARA.msp_module_name = lo_demand_list[li_arr_curr].module_name
            LET lo_MERGE_SYNC_PARA.msp_spec_type   = lo_demand_list[li_arr_curr].spec_type
            LET lo_MERGE_SYNC_PARA.msp_dgenv       = lo_demand_list[li_arr_curr].identity
            LET lo_demand_list[li_arr_curr].prog_selected = "N"
          END IF   

          DISPLAY cs_message_tag,"Merge program : ",lo_MERGE_SYNC_PARA.msp_prog_name 
          IF ms_cursor_focus_on = cs_focus_on_demand THEN 
            IF cl_ask_confirm_parm("adz-00925","") THEN
              CALL adzp050_merge_sync_check_in(lo_demand_list[li_arr_curr].*) RETURNING lb_result
              IF lb_result THEN 
                CALL adzp050_execute_merge_procedure(lo_MERGE_SYNC_PARA.*) RETURNING lb_result
              ELSE
                DISPLAY cs_error_tag,"Check in program not success !!"
              END IF  
            ELSE
              DISPLAY cs_message_tag,"Abort merge procedure."  
            END IF
          ELSE
            CALL adzp050_execute_merge_procedure(lo_MERGE_SYNC_PARA.*) RETURNING lb_result
          END IF  
          #161027-00001 end
          
          {
          #161027-00001 mark begin
          LET ls_prog_name   = lo_prog_list[li_arr_curr].prog_name
          LET ls_module_name = lo_prog_list[li_arr_curr].module_name
          LET ls_spec_type   = lo_prog_list[li_arr_curr].spec_type
          LET ls_dgenv       = lo_prog_list[li_arr_curr].identity
          
          CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*
          IF lo_DZAF_T.DZAF002 IS NOT NULL THEN
            LET lb_result = TRUE
            CALL sadzi888_07_auto_merge(lo_DZAF_T.*) RETURNING lb_result,ls_message
            IF NOT lb_result THEN
              LET ls_err_code = "adz-00489"
              LET ls_err_msg  = ls_message,"|"
              CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, TRUE)
            ELSE              
              LET ls_err_code = "adz-00490"
              LET ls_err_msg  = ""
              CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, TRUE)
            END IF
            #r.c
            IF lb_result THEN
              CALL adzp050_compile_4gl(ls_prog_name,ls_module_name) RETURNING lb_result
              IF NOT lb_result THEN 
                LET ls_err_code = "adz-00033"
                LET ls_err_msg  = ""
                CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, TRUE)
              END IF  
            END IF 
            #r.l
            IF lb_result THEN
              CALL adzp050_link_4gl(ls_prog_name,ls_module_name) RETURNING lb_result 
              IF NOT lb_result THEN 
                LET ls_err_code = "adz-00035"
                LET ls_err_msg  = ""
                CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, TRUE)
              END IF  
            END IF 
          END IF
          #161027-00001 mark end
          }
        END IF
        
        IF (ms_view_checkout = "Y") THEN
          CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
        ELSE
          CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,ls_chk_spec_type,ls_download_type,ms_search) 
        END IF
        #CALL adzp050_get_all_list_sql(ms_erpalm,NVL(ms_search,ls_module),"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena
        CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
        CALL adzp050_fill_all_list(ls_sql)
        LET g_patch_mode = FALSE

      ON ACTION btn_sync
        IF cl_ask_confirm_parm("adz-00528","") THEN
          LET li_arr_curr = ARR_CURR()

          #161027-00001 begin
          IF ms_cursor_focus_on = cs_focus_on_program THEN 
            LET lo_MERGE_SYNC_PARA.msp_prog_name   = lo_prog_list[li_arr_curr].prog_name
            LET lo_MERGE_SYNC_PARA.msp_module_name = lo_prog_list[li_arr_curr].module_name
            LET lo_MERGE_SYNC_PARA.msp_spec_type   = lo_prog_list[li_arr_curr].spec_type
            LET lo_MERGE_SYNC_PARA.msp_dgenv       = lo_prog_list[li_arr_curr].identity
            LET lo_prog_list[li_arr_curr].prog_selected = "N"
          ELSE
            LET lo_MERGE_SYNC_PARA.msp_prog_name   = lo_demand_list[li_arr_curr].prog_name
            LET lo_MERGE_SYNC_PARA.msp_module_name = lo_demand_list[li_arr_curr].module_name
            LET lo_MERGE_SYNC_PARA.msp_spec_type   = lo_demand_list[li_arr_curr].spec_type
            LET lo_MERGE_SYNC_PARA.msp_dgenv       = lo_demand_list[li_arr_curr].identity
            LET lo_demand_list[li_arr_curr].prog_selected = "N"
          END IF  

          DISPLAY cs_message_tag,"Synchronize program : ",lo_MERGE_SYNC_PARA.msp_prog_name 
          IF ms_cursor_focus_on = cs_focus_on_demand THEN 
            IF cl_ask_confirm_parm("adz-00924","") THEN
              CALL adzp050_merge_sync_check_in(lo_demand_list[li_arr_curr].*) RETURNING lb_result
              IF lb_result THEN 
                CALL adzp050_execute_sync_procedure(lo_MERGE_SYNC_PARA.*) RETURNING lb_result
              ELSE
                DISPLAY cs_error_tag,"Check in program not success !!"
              END IF  
            ELSE
              DISPLAY cs_message_tag,"Abort synchronize procedure."  
            END IF
          ELSE
            CALL adzp050_execute_sync_procedure(lo_MERGE_SYNC_PARA.*) RETURNING lb_result
          END IF  
          #161027-00001 end
          
          {
          #161027-00001 mark begin
          LET ls_prog_name   = lo_prog_list[li_arr_curr].prog_name
          LET ls_module_name = lo_prog_list[li_arr_curr].module_name
          LET ls_spec_type   = lo_prog_list[li_arr_curr].spec_type
          LET ls_dgenv       = lo_prog_list[li_arr_curr].identity
          
          CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*
          IF lo_DZAF_T.DZAF002 IS NOT NULL THEN
            LET lb_result = TRUE
            CALL sadzp060_4_start_sync(lo_DZAF_T.*) RETURNING lb_result,ls_message
            IF NOT lb_result THEN
              LET ls_err_code = "adz-00529"
              LET ls_err_msg  = ls_message,"|"
              CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, TRUE)
            ELSE              
              LET ls_err_code = "adz-00530"
              LET ls_err_msg  = ""
              CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, TRUE)
            END IF
          END IF
          #161027-00001 mark end
          }
          
          IF (ms_view_checkout = "Y") THEN
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,"","",ls_download_type,"")
          ELSE
            CALL adzp050_fill_demand_list(ms_erpalm,ms_user,ls_module,ls_chk_spec_type,ls_download_type,ms_search) 
          END IF
          #CALL adzp050_get_all_list_sql(ms_erpalm,NVL(ms_search,ls_module),"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type) RETURNING ls_sql  #20151130 by elena
          CALL adzp050_get_all_list_sql(ms_erpalm,ls_module,"",IIF(ls_get_last_ver == "Y",TRUE,FALSE),ls_download_type,ms_search) RETURNING ls_sql
          CALL adzp050_fill_all_list(ls_sql)
        END IF  

      ON ACTION btn_view_sync
        LET li_arr_curr = ARR_CURR()
        IF ms_cursor_focus_on = cs_focus_on_program THEN 
          LET ls_industry_type = lo_prog_list[li_arr_curr].industry_type
          LET ls_prog_name = lo_prog_list[li_arr_curr].prog_name
        ELSE
          LET ls_industry_type = lo_demand_list[li_arr_curr].industry_type
          LET ls_prog_name = lo_demand_list[li_arr_curr].prog_name
        END IF
        IF ls_industry_type <> ms_topind THEN
          LET ls_command = "r.r adzq620 ",ls_prog_name
          CALL cl_cmdrun_openpipe("r.r",ls_command,FALSE) RETURNING lb_return,ls_retmsg        
        END IF   

      #161028-00001 begin
      ON ACTION btn_download_standard
        LET lb_selected = FALSE
        FOR li_index = 1 TO lo_prog_list.getLength()
          IF lo_prog_list[li_index].prog_selected = "Y" THEN
            LET lb_selected = TRUE
          END IF 
        END FOR
        FOR li_index = 1 TO lo_demand_list.getLength()
          IF lo_demand_list[li_index].prog_selected = "Y" THEN
            LET lb_selected = TRUE
          END IF 
        END FOR
        IF NOT lb_selected THEN
          LET ls_err_code = "adz-00343"
          LET ls_err_msg  = "|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          CONTINUE DIALOG
        END IF 
        LET li_arr_curr = ARR_CURR()
        IF (ms_download_type = cs_download_type_spec) OR (ms_download_type = cs_download_type_code) OR (ms_download_type = cs_download_type_4rp) THEN
          #先設定抓取版本必要的參數
          IF ms_cursor_focus_on = cs_focus_on_program THEN 
            LET lo_MERGE_SYNC_PARA.msp_prog_name   = lo_prog_list[li_arr_curr].prog_name
            LET lo_MERGE_SYNC_PARA.msp_prog_desc   = lo_prog_list[li_arr_curr].prog_desc
            LET lo_MERGE_SYNC_PARA.msp_module_name = adzp050_get_standard_module(lo_prog_list[li_arr_curr].module_name)
            LET lo_MERGE_SYNC_PARA.msp_spec_type   = lo_prog_list[li_arr_curr].spec_type
            LET lo_MERGE_SYNC_PARA.msp_identity    = cs_dgenv_standard #lo_prog_list[li_arr_curr].identity
            LET lo_MERGE_SYNC_PARA.msp_dgenv       = cs_dgenv_standard
            LET lo_prog_list[li_arr_curr].prog_selected = "N"
          ELSE
            LET lo_MERGE_SYNC_PARA.msp_prog_name   = lo_demand_list[li_arr_curr].prog_name
            LET lo_MERGE_SYNC_PARA.msp_prog_desc   = lo_demand_list[li_arr_curr].prog_desc
            LET lo_MERGE_SYNC_PARA.msp_module_name = adzp050_get_standard_module(lo_demand_list[li_arr_curr].module_name)
            LET lo_MERGE_SYNC_PARA.msp_spec_type   = lo_demand_list[li_arr_curr].spec_type
            LET lo_MERGE_SYNC_PARA.msp_identity    = cs_dgenv_standard #lo_demand_list[li_arr_curr].identity
            LET lo_MERGE_SYNC_PARA.msp_dgenv       = cs_dgenv_standard
            LET lo_demand_list[li_arr_curr].prog_selected = "N"
          END IF
          #取得當前標準版次
          CALL adzp050_get_current_version(lo_MERGE_SYNC_PARA.msp_prog_name,lo_MERGE_SYNC_PARA.msp_spec_type,lo_MERGE_SYNC_PARA.msp_dgenv) RETURNING lo_dzaf_t.*
          #沒有標準版次就不能下載
          IF lo_dzaf_t.DZAF002 IS NOT NULL THEN 
            LET lo_MERGE_SYNC_PARA.msp_version = lo_dzaf_t.DZAF002
            LET lo_MERGE_SYNC_PARA.msp_sd_ver  = lo_dzaf_t.DZAF003
            LET lo_MERGE_SYNC_PARA.msp_pr_ver  = lo_dzaf_t.DZAF004
            LET lb_success = TRUE
            CALL adzp050_set_download_progress(0)
            CALL lo_curr_form.setElementHidden("formonly.pgb_main",FALSE)
            CALL adzp050_set_download_progress(50)
            CASE 
              WHEN (ms_download_type = cs_download_type_spec)
                IF lo_dzaf_t.DZAF003 IS NOT NULL THEN 
                  IF (lo_MERGE_SYNC_PARA.msp_spec_type = "M") OR (lo_MERGE_SYNC_PARA.msp_spec_type = "S") OR (lo_MERGE_SYNC_PARA.msp_spec_type = "F") THEN 
                    CALL adzp050_generate_tsd_file(lo_MERGE_SYNC_PARA.msp_prog_name,lo_MERGE_SYNC_PARA.msp_module_name,lo_MERGE_SYNC_PARA.msp_spec_type,lo_MERGE_SYNC_PARA.msp_sd_ver,lo_MERGE_SYNC_PARA.msp_pr_ver ,lo_MERGE_SYNC_PARA.msp_prog_name,lo_MERGE_SYNC_PARA.msp_sd_ver,lo_MERGE_SYNC_PARA.msp_pr_ver,lo_MERGE_SYNC_PARA.msp_dgenv) RETURNING lb_result
                    CALL adzp050_set_download_progress(100)
                    CALL adzp050_download_form_pack(lo_MERGE_SYNC_PARA.msp_prog_name,lo_MERGE_SYNC_PARA.msp_module_name,lo_MERGE_SYNC_PARA.msp_identity,"","",ms_client_path,cs_zip_name_tzs,ms_erpalm,TRUE) RETURNING lb_result
                  ELSE
                    DISPLAY cs_error_tag,"Standard download not support this spec type : ",lo_MERGE_SYNC_PARA.msp_spec_type   
                    LET lb_success = FALSE
                    LET ls_err_code = "adz-00937"
                    LET ls_err_msg  = lo_MERGE_SYNC_PARA.msp_spec_type,"|"
                    CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
                  END IF
                ELSE  
                  DISPLAY cs_error_tag,"Can not find spec version, skip download."  
                  LET lb_success = FALSE
                  LET ls_err_code = "adz-00934"
                  LET ls_err_msg  = "|"
                  CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
                END IF  
              WHEN (ms_download_type = cs_download_type_code)
                IF lo_dzaf_t.DZAF004 IS NOT NULL THEN 
                  CALL adzp050_generate_tap_file(lo_MERGE_SYNC_PARA.msp_prog_name,lo_MERGE_SYNC_PARA.msp_module_name,lo_MERGE_SYNC_PARA.msp_pr_ver,lo_MERGE_SYNC_PARA.msp_prog_name,lo_MERGE_SYNC_PARA.msp_pr_ver,lo_MERGE_SYNC_PARA.msp_spec_type,lo_MERGE_SYNC_PARA.msp_dgenv) RETURNING lb_result
                  CALL adzp050_set_download_progress(100)
                  CALL adzp050_download_code_pack(lo_MERGE_SYNC_PARA.msp_prog_name,lo_MERGE_SYNC_PARA.msp_module_name,lo_MERGE_SYNC_PARA.msp_identity,"","",ms_client_path,IIF(gb_diff_download,cs_zip_name_tzx,cs_zip_name_tzc),ms_erpalm,TRUE) RETURNING lb_result #170208-00008
                ELSE
                  DISPLAY cs_error_tag,"Can not find code version, skip download."  
                  LET lb_success = FALSE
                  LET ls_err_code = "adz-00935"
                  LET ls_err_msg  = "|"
                  CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
                END IF
              WHEN (ms_download_type = cs_download_type_4rp) 
                IF lo_dzaf_t.DZAF004 IS NOT NULL THEN 
                  LET mb_result = FALSE
                  LET lo_program_info.pi_MODULE = lo_MERGE_SYNC_PARA.msp_module_name
                  LET lo_program_info.pi_NAME   = lo_MERGE_SYNC_PARA.msp_prog_name
                  LET lo_program_info.pi_DESC   = lo_MERGE_SYNC_PARA.msp_prog_desc
                  LET ls_identity               = lo_MERGE_SYNC_PARA.msp_identity
                  CALL mo_template_list.clear() 
                  CALL sadzp050_tple_get_template_records(ms_lang,lo_program_info.*,mo_template_list) RETURNING mb_result, mo_template_list
                  CALL adzp050_set_download_progress(100)
                  CALL adzp050_download_4rp_pack(DIALOG,cs_run_type_normal,li_arr_curr,lo_MERGE_SYNC_PARA.msp_prog_name,lo_MERGE_SYNC_PARA.msp_module_name,lo_MERGE_SYNC_PARA.msp_spec_type,lo_MERGE_SYNC_PARA.msp_pr_ver,lo_MERGE_SYNC_PARA.msp_identity,"","",ms_client_path,cs_zip_name_tzt,mo_template_list) RETURNING lb_result
                ELSE
                  DISPLAY cs_error_tag,"Can not find code version, skip download."  
                  LET lb_success = FALSE
                  LET ls_err_code = "adz-00935"
                  LET ls_err_msg  = "|"
                  CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
                END IF
            END CASE
            CALL lo_curr_form.setElementHidden("formonly.pgb_main",TRUE)
            IF lb_success THEN
              CALL cl_ask_confirm3('adz-00940',"")
            END IF
          ELSE 
            DISPLAY cs_error_tag,"There is no any standard version for program ",lo_MERGE_SYNC_PARA.msp_prog_name,", skip download."
            LET ls_err_code = "adz-00936"
            LET ls_err_msg  = lo_MERGE_SYNC_PARA.msp_prog_name,"|"
            CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          END IF  
        ELSE
          DISPLAY cs_error_tag,"Standard download not support for ",ms_download_type," type !"            
          LET ls_err_code = "adz-00933"
          LET ls_err_msg  = ms_download_type,"|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
        END IF  
      #161028-00001 end
      
      ON ACTION CLOSE
        LET INT_FLAG=FALSE         
        EXIT DIALOG
        
      ON ACTION EXIT
        LET INT_FLAG=FALSE         
        EXIT DIALOG  
      
    END DIALOG
    
  ELSE
    IF ((mo_PARAMETER.p_PARAM1.toUpperCase() = "TT") OR (mo_PARAMETER.p_PARAM1.toUpperCase() = "T100")) THEN
      CALL adzp050_download_designer_pack(mo_PARAMETER.p_PARAM1.toUpperCase(),ls_module_name,ls_temp_path||ls_separator,ls_client_path) RETURNING lb_result
      IF NOT lb_result THEN
        LET ls_err_code = "adz-00124"
        LET ls_err_msg  = "|"
        CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
        DISPLAY "[Failed]",ui.Interface.getName()
      ELSE  
        DISPLAY "[Complete]",ui.Interface.getName()
      END IF
    END IF
  END IF

END FUNCTION

FUNCTION adzp050_finalize()
END FUNCTION

FUNCTION adzp050_get_progress(p_step,p_loop,p_inc)
DEFINE
  p_step INTEGER,
  p_loop INTEGER,
  p_inc  INTEGER
DEFINE
  li_step INTEGER,
  li_loop INTEGER,
  li_inc  INTEGER,
  li_all_step INTEGER,
  li_progress INTEGER 
DEFINE
  li_return     INTEGER,
  li_return_inc INTEGER    

  LET li_step = p_step 
  LET li_loop = p_loop
  LET li_inc  = p_inc  

  LET li_all_step = li_step * li_loop
  LET li_progress = (li_inc/li_all_step)*100

  LET li_inc = li_inc + 1

  LET li_return = li_progress
  LET li_return_inc = li_inc

  IF mb_debug THEN
    DISPLAY "[Return Progress] ",li_return
    DISPLAY "[Return Increase] ",li_return_inc
  END IF 
  
  RETURN li_return, li_return_inc 
  
END FUNCTION 

FUNCTION adzp050_check_version_if_exist(p_download_type,p_program_name,p_sd_version,p_pg_version)
DEFINE
  p_download_type STRING,
  p_program_name  STRING,
  p_sd_version    STRING,  
  p_pg_version    STRING  
DEFINE
  ls_download_type STRING,
  ls_program_name  STRING,
  ls_sd_version    STRING,  
  ls_pg_version    STRING,  
  ls_err_code      STRING,   
  ls_err_msg       STRING
DEFINE
  lb_return BOOLEAN  

  LET ls_download_type = p_download_type
  LET ls_program_name  = p_program_name
  LET ls_sd_version    = p_sd_version  
  LET ls_pg_version    = p_pg_version  

  LET lb_return = TRUE
  
  CASE
    WHEN ls_download_type = cs_download_type_spec
      IF NVL(ls_sd_version.trim(),cs_null_default)=cs_null_default THEN
        LET lb_return = FALSE
        LET ls_err_code = "adz-00298"
        LET ls_err_msg  = ls_program_name,"|"
        CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
      END IF  
    WHEN ls_download_type = cs_download_type_code
      IF NVL(ls_pg_version.trim(),cs_null_default)=cs_null_default THEN
        LET lb_return = FALSE
        LET ls_err_code = "adz-00299"
        LET ls_err_msg  = ls_program_name,"|"
        CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
      END IF  
  OTHERWISE   
  END CASE

  RETURN lb_return
  
END FUNCTION 

#一般程式下載
FUNCTION adzp050_multi_download(p_DIALOG,p_module_name,p_download_type)
DEFINE
  p_DIALOG        ui.DIALOG,
  p_module_name   STRING,
  p_download_type STRING 
DEFINE 
  ls_module_name   STRING,
  ls_download_type STRING, 
  lo_prog_list     DYNAMIC ARRAY OF T_PROG_LIST,
  li_rec_cnt       INTEGER,
  ls_prog_name     STRING,
  ls_tgl_path      STRING,
  ls_temp_path     STRING,
  ls_client_path   STRING,
  li_file_counts   INTEGER,
  ls_file_counts   STRING, 
  li_loops         INTEGER,
  lb_success       BOOLEAN,
  lb_complete      BOOLEAN,
  ls_spec_type     STRING,
  ls_sd_version    STRING,
  ls_pg_version    STRING,
  li_loop          INTEGER,
  li_loop_cnt      INTEGER,
  li_inc           INTEGER,
  li_progress      INTEGER,
  li_step          INTEGER,
  ls_err_code      STRING,
  ls_err_msg       STRING,
  ls_dgenv         STRING,
  ls_identity      STRING,
  ls_industry_type STRING, #170208-00008
  ls_result        STRING, #170208-00008
  lb_if_download_diff BOOLEAN, #170208-00008
  lb_result        BOOLEAN, #170208-00008   
  lo_DZAF_T        T_DZAF_T,
  #lo_curr_DZAF_T   T_DZAF_T,
  ls_form_zip_ext_name     STRING,
  ls_code_zip_ext_name     STRING,
  ls_all_zip_ext_name      STRING,
  ls_template_zip_ext_name STRING,
  ls_orig_prog_name  STRING,
  ls_orig_sd_version STRING,
  ls_orig_pg_version STRING,
  ls_separator   STRING, 
  li_time_start  DATETIME HOUR TO FRACTION(5),
  li_time_end    DATETIME HOUR TO FRACTION(5)  
DEFINE
  lb_return  BOOLEAN  
  
  LET lo_prog_list.*   = m_prog_list.*
  LET ls_module_name   = p_module_name
  LET ls_download_type = NVL(p_download_type,cs_download_type_all)

  LET ls_separator = os.Path.separator()
  
  LET ls_temp_path   = FGL_GETENV("TEMPDIR")
  LET ls_client_path = ms_client_path 
  LET lb_return      = TRUE
  LET li_loops       = 1

  CALL adzp050_get_download_file_counts() RETURNING li_file_counts

  FOR li_rec_cnt = 1 TO lo_prog_list.getLength()
    LET lb_success  = TRUE
    LET lb_complete = TRUE  
    
    IF lo_prog_list[li_rec_cnt].prog_selected = "Y" THEN

      #已執行下載, 所以將執行過的程式取消打勾    
      LET lo_prog_list[li_rec_cnt].prog_selected = "N"

      LET ls_prog_name   = lo_prog_list[li_rec_cnt].prog_name
      LET ls_module_name = lo_prog_list[li_rec_cnt].module_name
      LET ls_spec_type   = lo_prog_list[li_rec_cnt].spec_type
      LET ls_dgenv       = lo_prog_list[li_rec_cnt].identity

      #170208-00008 begin
      IF gb_diff_download THEN

        #檢查是否存在來源檔
        CALL sadzp050_zip_get_if_source_file_exists(ls_prog_name,ls_module_name) RETURNING lb_result
        IF NOT lb_result THEN
          LET ls_err_code = "adz-00954"
          LET ls_err_msg  = "|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          CONTINUE FOR   
        END IF
        
        LET lb_if_download_diff = FALSE
        LET ls_industry_type = lo_prog_list[li_rec_cnt].industry_type
        IF ls_industry_type.toLowerCase() = "sd" THEN
          IF NOT sadzp050_zip_get_dzbi_if_exists(ls_prog_name) THEN 
            LET lb_if_download_diff = TRUE 
          END IF 
          #檢查是否經過客制
          #IF sadzp050_zip_get_if_standard_to_customize(ls_prog_name) THEN 
          #END IF
        ELSE
          IF (NOT sadzp050_zip_get_dzbi_if_exists(ls_prog_name)) AND
             (NOT sadzp050_zip_get_dzbj_if_exists(ls_prog_name)) THEN 
            LET lb_if_download_diff = TRUE 
          END IF 
        END IF  
        IF lb_if_download_diff THEN 
         LET ls_err_code = "adz-00952"
         LET ls_err_msg  = ls_prog_name,"|"
         CALL sadzp000_msg_question_box(ls_err_code,ls_err_code,ls_err_msg,0) RETURNING ls_result
         IF ls_result = cs_response_no THEN
           CONTINUE FOR   
         END IF
        END IF 
      END IF
      #170208-00008 end

      #取得實際版次的資訊
      CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*
      LET ls_sd_version  = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].sd_ver
      LET ls_pg_version  = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].pg_ver
     
      #Begin:20160308 by elena 判斷是否是行業別程式，行業別程式才重抓版次 
      IF (NVL(lo_prog_list[li_rec_cnt].origin_prog,cs_null_default) <> cs_null_default) AND
         (lo_prog_list[li_rec_cnt].prog_name <> NVL(lo_prog_list[li_rec_cnt].origin_prog,cs_null_default)) THEN
         #取得實際版次的資訊(原始程式)
         CALL adzp050_get_current_version(lo_prog_list[li_rec_cnt].origin_prog,lo_prog_list[li_rec_cnt].origin_spec_type,lo_prog_list[li_rec_cnt].origin_identity) RETURNING lo_DZAF_T.*
      
         #標準程式
         LET ls_orig_prog_name  = lo_DZAF_T.DZAF001 --lo_prog_list[li_rec_cnt].origin_prog
         LET ls_orig_sd_version = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].origin_sd_ver
         LET ls_orig_pg_version = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].origin_pg_ver

      END IF
      #End:20160308 by elena

      #2014/12/03 by Hiko:補上下載規則
      IF (NOT adzp050_continue_download(lo_DZAF_T.*, ls_download_type)) THEN
         CONTINUE FOR
      END IF

      LET li_loop_cnt = 1
      IF ms_DGENV = "s" THEN #2014/12/03 by Hiko:只有標準環境才會有行業別議題.
         #若程式名稱和原始程式名稱不一樣, 則為行業別程式, 要抓取原始程式為 "tmp", 跑兩次迴圈
         IF (NVL(lo_prog_list[li_rec_cnt].origin_prog,cs_null_default) <> cs_null_default) AND 
            (lo_prog_list[li_rec_cnt].prog_name <> NVL(lo_prog_list[li_rec_cnt].origin_prog,cs_null_default)) THEN
           LET li_loop_cnt = 2
         END IF
      END IF

      DISPLAY "****************************************************************"
      LET li_time_start = CURRENT HOUR TO FRACTION(5)
      DISPLAY "[START] ",ls_prog_name,", Time : ",li_time_start

      #DISPLAY "li_rec_cnt : ",li_rec_cnt
      CALL adzp050_set_progress(0,li_rec_cnt,p_DIALOG)
      CASE 
        #4gl(應用元件),B類
        WHEN (ls_spec_type = "B")
          LET li_inc  = 1
          #下載的副檔名
          LET ls_all_zip_ext_name  = cs_zip_name_tzp
          LET ls_form_zip_ext_name = cs_zip_name_tzr
          LET ls_code_zip_ext_name = IIF(gb_diff_download,cs_zip_name_tzx,cs_zip_name_tzc) #170208-00008
          LET ls_identity          = lo_prog_list[li_rec_cnt].identity
          
          FOR li_loop = 1 TO li_loop_cnt

            #檢核版次資訊是否存在
            IF NOT adzp050_check_version_if_exist(ls_download_type,ls_prog_name,ls_sd_version,ls_pg_version) THEN
              CONTINUE FOR
            END IF

            IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_spec) THEN 
              LET li_step = 2 #Progress bar的程序數
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              -- 2014.11.03 改為產生及下載 rsd 
              --CALL adzp050_generate_csd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_dgenv) RETURNING lb_success
              CALL adzp050_generate_rsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_dgenv) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            END IF   
            
            IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_code) THEN 
              LET li_step = 1 #Progress bar的程序數
              #2014/12/03 by Hiko:tab,tgl,tgx,4gl一定是最新(Patch或是樣版改變都會重產tab,tgl,tgx,4gl),所以沒有簽出的程式下載只需要重產tap(包含.read)即可.
              #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              #CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              #CALL adzp050_generate_tab(ls_prog_name,ls_sd_version,ls_dgenv) RETURNING lb_success
              #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              #CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              #CALL adzp050_generate_code_4gl(ls_prog_name,ls_module_name.toLowercase(),ls_pg_version,ls_dgenv, "1") RETURNING lb_success
              #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
              #End:2014/12/03 by Hiko
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              CALL adzp050_generate_tap_file(ls_prog_name,ls_module_name,ls_pg_version,ls_orig_prog_name,ls_orig_pg_version,ls_spec_type,ls_dgenv) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            END IF
            
            IF (mb_download_all OR ls_download_type = cs_download_type_all)  THEN              
              -- 2014.11.03 改為產生及下載 rsd 
              --CALL adzp050_download_csd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
              CALL adzp050_download_rsd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            ELSE 
              IF ls_download_type = cs_download_type_spec THEN
                -- 2014.11.03 改為產生及下載 rsd 
                --CALL adzp050_download_csd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
                CALL adzp050_download_rsd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
              IF ls_download_type = cs_download_type_code THEN
                CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
            END IF
            
            #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
            #CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
            
            CALL adzp050_set_progress(100,li_rec_cnt,p_DIALOG)
            
            LET ls_prog_name   = lo_prog_list[li_rec_cnt].origin_prog
            LET ls_module_name = lo_prog_list[li_rec_cnt].origin_module
            LET ls_spec_type   = lo_prog_list[li_rec_cnt].origin_spec_type
            LET ls_dgenv       = lo_prog_list[li_rec_cnt].origin_identity
            
            #取得實際版次資訊
            CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*

            LET ls_sd_version  = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].origin_sd_ver
            LET ls_pg_version  = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].origin_pg_ver

            LET ls_all_zip_ext_name  = cs_zip_name_tmp
            LET ls_form_zip_ext_name = cs_zip_name_tmr
            LET ls_code_zip_ext_name = cs_zip_name_tmc
            LET ls_identity          = lo_prog_list[li_rec_cnt].origin_identity
            
          END FOR   
        #4fd(子畫面),F類
        WHEN (ls_spec_type = "F")
          LET li_inc = 1
          #下載的副檔名
          LET ls_all_zip_ext_name  = cs_zip_name_tzp
          LET ls_form_zip_ext_name = cs_zip_name_tzs
          LET ls_code_zip_ext_name = IIF(gb_diff_download,cs_zip_name_tzx,cs_zip_name_tzc) #170208-00008
          LET ls_identity          = lo_prog_list[li_rec_cnt].identity

          FOR li_loop = 1 TO li_loop_cnt

            #檢核版次資訊是否存在
            IF NOT adzp050_check_version_if_exist(ls_download_type,ls_prog_name,ls_sd_version,ls_pg_version) THEN
              CONTINUE FOR
            END IF

            LET li_step = 2 #Progress bar的程序數
            CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
            CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
            CALL adzp050_generate_tsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_pg_version,ls_orig_prog_name,ls_orig_sd_version,ls_orig_pg_version,ls_dgenv) RETURNING lb_success
            IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
            #CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
            #CALL adzp050_parse_4fd(ls_prog_name,ls_module_name,ls_sd_version) RETURNING lb_success
            #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
            
            CALL adzp050_download_form_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
            IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
            
            CALL adzp050_set_progress(100,li_rec_cnt,p_DIALOG)
            
            LET ls_prog_name   = lo_prog_list[li_rec_cnt].origin_prog
            LET ls_module_name = lo_prog_list[li_rec_cnt].origin_module
            LET ls_spec_type   = lo_prog_list[li_rec_cnt].origin_spec_type
            LET ls_dgenv       = lo_prog_list[li_rec_cnt].origin_identity

            #取得實際版次資訊
            CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*

            LET ls_sd_version  = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].origin_sd_ver
            LET ls_pg_version  = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].origin_pg_ver
            
            LET ls_all_zip_ext_name  = cs_zip_name_tmp
            LET ls_form_zip_ext_name = cs_zip_name_tms
            LET ls_code_zip_ext_name = cs_zip_name_tmc
            LET ls_identity          = lo_prog_list[li_rec_cnt].origin_identity
            
          END FOR   
        #4gl,4fd(主程式,子程式),M類或S類
        WHEN (ls_spec_type = "M") OR (ls_spec_type = "S") OR (ls_spec_type = "Q") 
          LET li_inc = 1
          #下載的副檔名
          LET ls_all_zip_ext_name  = cs_zip_name_tzp
          LET ls_form_zip_ext_name = cs_zip_name_tzs
          LET ls_code_zip_ext_name = IIF(gb_diff_download,cs_zip_name_tzx,cs_zip_name_tzc) #170208-00008
          LET ls_identity          = lo_prog_list[li_rec_cnt].identity

          FOR li_loop = 1 TO li_loop_cnt

            #檢核版次資訊是否存在
            IF NOT adzp050_check_version_if_exist(ls_download_type,ls_prog_name,ls_sd_version,ls_pg_version) THEN
              CONTINUE FOR
            END IF

            IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_spec) THEN 
              LET li_step = 2 #Progress bar的程序數
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              CALL adzp050_generate_tsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_pg_version,ls_orig_prog_name,ls_orig_sd_version,ls_orig_pg_version,ls_dgenv) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              #CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              #CALL adzp050_parse_4fd(ls_prog_name,ls_module_name,ls_sd_version) RETURNING lb_success
              #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
            END IF   

            IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_code) THEN 
              LET li_step = 1 #Progress bar的程序數
              #Begin:2014/12/03 by Hiko:tab,tgl,tgx,4gl一定是最新(Patch或是樣版改變都會重產tab,tgl,tgx,4gl),所以沒有簽出的程式下載只需要重產tap(包含.read)即可.
              #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              #CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              #CALL adzp050_generate_tab(ls_prog_name,ls_sd_version,ls_dgenv) RETURNING lb_success
              #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              #CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              #CALL adzp050_generate_code_4gl(ls_prog_name,ls_module_name.toLowercase(),ls_pg_version,ls_dgenv, "1") RETURNING lb_success
              #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
              #End:2014/12/03 by Hiko
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              CALL adzp050_generate_tap_file(ls_prog_name,ls_module_name,ls_pg_version,ls_orig_prog_name,ls_orig_pg_version,ls_spec_type,ls_dgenv) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            END IF   
            
            IF (mb_download_all OR ls_download_type = cs_download_type_all)  THEN              
              CALL adzp050_download_form_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            ELSE 
              IF ls_download_type = cs_download_type_spec THEN
                CALL adzp050_download_form_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
              IF ls_download_type = cs_download_type_code THEN
                CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
            END IF 

            #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
            CALL adzp050_set_progress(100,li_rec_cnt,p_DIALOG)
            
            LET ls_prog_name   = lo_prog_list[li_rec_cnt].origin_prog
            LET ls_module_name = lo_prog_list[li_rec_cnt].origin_module
            LET ls_spec_type   = lo_prog_list[li_rec_cnt].origin_spec_type
            LET ls_dgenv       = lo_prog_list[li_rec_cnt].origin_identity

            #取得實際版次資訊
            CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*

            LET ls_sd_version  = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].origin_sd_ver
            LET ls_pg_version  = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].origin_pg_ver

            LET ls_all_zip_ext_name  = cs_zip_name_tmp
            LET ls_form_zip_ext_name = cs_zip_name_tms
            LET ls_code_zip_ext_name = cs_zip_name_tmc
            LET ls_identity          = lo_prog_list[li_rec_cnt].origin_identity
            
          END FOR   
        #G, X 類報表, Extra Grid 
        WHEN (ls_spec_type = "G") OR (ls_spec_type = "X")
          LET li_inc = 1
          #下載的副檔名
          LET ls_all_zip_ext_name      = cs_zip_name_tzp
          LET ls_form_zip_ext_name     = cs_zip_name_tzr
          LET ls_code_zip_ext_name     = IIF(gb_diff_download,cs_zip_name_tzx,cs_zip_name_tzc) #170208-00008
          LET ls_template_zip_ext_name = cs_zip_name_tzt
          LET ls_identity              = lo_prog_list[li_rec_cnt].identity
          
          FOR li_loop = 1 TO li_loop_cnt

            #檢核版次資訊是否存在
            IF NOT adzp050_check_version_if_exist(ls_download_type,ls_prog_name,ls_sd_version,ls_pg_version) THEN
              CONTINUE FOR
            END IF

            IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_spec) THEN 
              LET li_step = 2 #Progress bar的程序數
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              CALL adzp050_generate_rsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_dgenv) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            END IF
            
            IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_code) THEN 
              LET li_step = 1 #Progress bar的程序數
              #Begin:2014/12/03 by Hiko:tab,tgl,tgx,4gl一定是最新(Patch或是樣版改變都會重產tab,tgl,tgx,4gl),所以沒有簽出的程式下載只需要重產tap(包含.read)即可.
              #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              #CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              #CALL adzp050_generate_tab(ls_prog_name,ls_pg_version,ls_dgenv) RETURNING lb_success
              #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              #CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              #CALL adzp050_generate_code_4gl(ls_prog_name,ls_module_name.toLowercase(),ls_pg_version,ls_dgenv, "1") RETURNING lb_success
              #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              #End:2014/12/03 by Hiko
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              CALL adzp050_generate_tap_file(ls_prog_name,ls_module_name,ls_pg_version,ls_orig_prog_name,ls_orig_pg_version,ls_spec_type,ls_dgenv) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
            END IF
            
            IF (mb_download_all OR ls_download_type = cs_download_type_all)  THEN              
              CALL adzp050_download_rsd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            ELSE 

              IF ls_download_type = cs_download_type_4rp THEN
                CALL adzp050_download_4rp_pack(p_DIALOG,cs_run_type_normal,li_rec_cnt,ls_prog_name,ls_module_name,ls_spec_type,ls_pg_version,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_template_zip_ext_name,mo_template_list) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
              IF ls_download_type = cs_download_type_spec THEN
                CALL adzp050_download_rsd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
              IF ls_download_type = cs_download_type_code THEN
                CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
              
            END IF 

            CALL adzp050_set_progress(100,li_rec_cnt,p_DIALOG)
            
            LET ls_prog_name   = lo_prog_list[li_rec_cnt].origin_prog
            LET ls_module_name = lo_prog_list[li_rec_cnt].origin_module
            LET ls_spec_type   = lo_prog_list[li_rec_cnt].origin_spec_type
            LET ls_dgenv       = lo_prog_list[li_rec_cnt].origin_identity

            #取得實際版次資訊
            CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*

            LET ls_sd_version  = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].origin_sd_ver
            LET ls_pg_version  = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].origin_pg_ver

            LET ls_all_zip_ext_name      = cs_zip_name_tmp
            LET ls_form_zip_ext_name     = cs_zip_name_tmr
            LET ls_code_zip_ext_name     = cs_zip_name_tmc
            LET ls_template_zip_ext_name = cs_zip_name_tmt
            LET ls_identity              = lo_prog_list[li_rec_cnt].origin_identity
            
          END FOR   
        #Web Service,W,Z類
        WHEN (ls_spec_type = "W") OR (ls_spec_type = "Z") 
          LET li_inc = 1
          #下載的副檔名
          LET ls_all_zip_ext_name  = cs_zip_name_tzp
          LET ls_form_zip_ext_name = cs_zip_name_tzr
          LET ls_code_zip_ext_name = IIF(gb_diff_download,cs_zip_name_tzx,cs_zip_name_tzc) #170208-00008
          LET ls_identity          = lo_prog_list[li_rec_cnt].identity
          
          FOR li_loop = 1 TO li_loop_cnt

            #檢核版次資訊是否存在
            IF NOT adzp050_check_version_if_exist(ls_download_type,ls_prog_name,ls_sd_version,ls_pg_version) THEN
              CONTINUE FOR
            END IF

            IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_spec) THEN 
              LET li_step = 2 #Progress bar的程序數
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              CALL adzp050_generate_rsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_dgenv) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            END IF
            
            IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_code) THEN 
              LET li_step = 1 #Progress bar的程序數
              #Begin:2014/12/03 by Hiko:tab,tgl,tgx,4gl一定是最新(Patch或是樣版改變都會重產tab,tgl,tgx,4gl),所以沒有簽出的程式下載只需要重產tap(包含.read)即可.
              #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              #CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              #CALL adzp050_generate_tab(ls_prog_name,ls_sd_version,ls_dgenv) RETURNING lb_success
              #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              #CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              #CALL adzp050_generate_code_4gl(ls_prog_name,ls_module_name.toLowercase(),ls_pg_version,ls_dgenv, "1") RETURNING lb_success
              #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
              #End:2014/12/03 by Hiko
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              CALL adzp050_set_progress(li_progress,li_rec_cnt,p_DIALOG)
              CALL adzp050_generate_tap_file(ls_prog_name,ls_module_name,ls_pg_version,ls_orig_prog_name,ls_orig_pg_version,ls_spec_type,ls_dgenv) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            END IF
            
            IF ls_download_type = cs_download_type_spec THEN
              CALL adzp050_download_rsd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            END IF   
            IF ls_download_type = cs_download_type_code THEN
              CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,TRUE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            END IF

            CALL adzp050_set_progress(100,li_rec_cnt,p_DIALOG)
            
            LET ls_prog_name   = lo_prog_list[li_rec_cnt].origin_prog
            LET ls_module_name = lo_prog_list[li_rec_cnt].origin_module
            LET ls_spec_type   = lo_prog_list[li_rec_cnt].origin_spec_type
            LET ls_dgenv       = lo_prog_list[li_rec_cnt].origin_identity

            #取得實際版次資訊
            CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*

            LET ls_sd_version  = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].origin_sd_ver
            LET ls_pg_version  = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].origin_pg_ver
            
            LET ls_all_zip_ext_name  = cs_zip_name_tmp
            LET ls_form_zip_ext_name = cs_zip_name_tmr
            LET ls_code_zip_ext_name = cs_zip_name_tmc
            LET ls_identity          = lo_prog_list[li_rec_cnt].origin_identity
            
          END FOR   
        OTHERWISE
      END CASE
      
      IF lo_prog_list[li_rec_cnt].auto_start = "Y" THEN
        CALL adzp050_start_spec_designer(ls_prog_name,cs_zip_name_tzp)
      END IF
      
      LABEL _complete:

      IF NOT lb_complete THEN
        LET ls_err_code = "adz-00162"
        #CALL FGL_WINMESSAGE("錯誤", "下載程式 "||ls_prog_name||" 失敗 !! ", "stop")
        #Begin:2015/12/25 by Hiko
        #LET ls_err_msg  = ls_prog_name,"|",ms_running_process,"|"
        #CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code  = ls_err_code
        LET g_errparam.replace[1] = ls_prog_name
        LET g_errparam.replace[2] = ms_running_process
        LET g_errparam.popup = TRUE
        CALL cl_err()
        #End:2015/12/25 by Hiko
      END IF
      
      LET li_time_end = CURRENT HOUR TO FRACTION(5) 
      DISPLAY "[END] ",ls_prog_name,", Time : ",li_time_end
      DISPLAY "****************************************************************"
      DISPLAY "[SPEND TIME] ",ls_prog_name,", Time : ",li_time_end - li_time_start
      DISPLAY "****************************************************************"
      LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
      
      LET li_loops = li_loops + 1
      IF li_loops > li_file_counts THEN
        LET li_loops = 1
        LET ls_file_counts = li_file_counts
        #程式下載已達最高下載數目是否繼續
        IF NOT cl_ask_confirm_parm("adz-00131",ls_file_counts) THEN
          EXIT FOR
        END IF
      END IF

    END IF
  END FOR

  DISPLAY cs_download_str
  
END FUNCTION

#ALM程式下載
FUNCTION adzp050_multi_alm_download(p_DIALOG,p_module_name,p_download_type)
DEFINE
  p_DIALOG        ui.DIALOG,
  p_module_name   STRING,
  p_download_type STRING
DEFINE 
  ls_module_name   STRING,
  ls_download_type STRING,
  lo_prog_list     DYNAMIC ARRAY OF T_ALM_LIST,
  li_rec_cnt       INTEGER,
  ls_prog_name     STRING,
  ls_tgl_path      STRING,
  ls_temp_path     STRING,
  ls_client_path   STRING,
  li_file_counts   INTEGER,
  ls_file_counts   STRING, 
  li_loops         INTEGER,
  lb_success       BOOLEAN,
  lb_complete      BOOLEAN,
  ls_spec_type     STRING,
  ls_sd_version    STRING,
  ls_pg_version    STRING,
  li_loop          INTEGER,
  li_loop_cnt      INTEGER,
  li_inc           INTEGER,
  li_step          INTEGER,
  li_progress      INTEGER,
  ls_err_code      STRING,
  ls_err_msg       STRING,
  lb_result        BOOLEAN,
  ls_GUID          STRING,
  ls_dgenv         STRING,
  ls_role          STRING,
  li_role_count    INTEGER,
  li_dzan_count    INTEGER,
  ls_identity      STRING,
  ls_industry_type STRING, #170208-00008
  ls_result        STRING, #170208-00008
  lb_if_download_diff BOOLEAN, #170208-00008
  ls_form_zip_ext_name     STRING,
  ls_code_zip_ext_name     STRING,
  ls_all_zip_ext_name      STRING,
  ls_template_zip_ext_name STRING,
  ls_orig_prog_name  STRING,
  ls_orig_sd_version STRING,
  ls_orig_pg_version STRING,
  ls_separator   STRING,
  lo_DZAF_T      T_DZAF_T,
  lo_DZAN_T      DYNAMIC ARRAY OF T_DZAN_T, 
  lo_role_arr    T_STATIC_ROLE_LIST,
  lo_USER_INFO   T_USER_INFO,
  lo_DZLM_T      T_DZLM_T,  
  #lo_curr_DZAF_T T_DZAF_T,
  lo_dzaf_t_prev T_DZAF_T,
  lo_dzaf_t_curr T_DZAF_T,
  li_time_start  DATETIME HOUR TO FRACTION(5),
  li_time_end    DATETIME HOUR TO FRACTION(5) 
DEFINE
  lb_return  BOOLEAN  
  
  LET lo_prog_list.*   = m_demand_list.*
  LET ls_module_name   = p_module_name
  LET ls_download_type = NVL(p_download_type,cs_download_type_all)

  LET ls_separator = os.Path.separator()
  
  LET ls_temp_path   = FGL_GETENV("TEMPDIR")
  LET ls_client_path = ms_client_path 
  LET lb_return      = TRUE
  LET li_loops       = 1

  CALL adzp050_get_download_file_counts() RETURNING li_file_counts

  FOR li_rec_cnt = 1 TO lo_prog_list.getLength()
    LET lb_success  = TRUE
    LET lb_complete = TRUE  
    
    IF lo_prog_list[li_rec_cnt].prog_selected = "Y" THEN

      #已執行程序, 所以將執行過的程式取消打勾    
      LET lo_prog_list[li_rec_cnt].prog_selected = "N"

      LET ls_prog_name   = lo_prog_list[li_rec_cnt].prog_name
      LET ls_module_name = lo_prog_list[li_rec_cnt].module_name
      LET ls_spec_type   = lo_prog_list[li_rec_cnt].spec_type
      LET ls_dgenv       = lo_prog_list[li_rec_cnt].identity

      #170208-00008 begin
      IF gb_diff_download THEN
      
        #檢查是否存在來源檔
        CALL sadzp050_zip_get_if_source_file_exists(ls_prog_name,ls_module_name) RETURNING lb_result
        IF NOT lb_result THEN
          LET ls_err_code = "adz-00954"
          LET ls_err_msg  = "|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          CONTINUE FOR   
        END IF
        
        LET lb_if_download_diff = FALSE
        LET ls_industry_type = lo_prog_list[li_rec_cnt].industry_type
        IF ls_industry_type.toLowerCase() = "sd" THEN
          IF NOT sadzp050_zip_get_dzbi_if_exists(ls_prog_name) THEN 
            LET lb_if_download_diff = TRUE 
          END IF 
          #檢查是否經過客制
          #IF sadzp050_zip_get_if_standard_to_customize(ls_prog_name) THEN 
          #END IF
        ELSE
          IF (NOT sadzp050_zip_get_dzbi_if_exists(ls_prog_name)) AND
             (NOT sadzp050_zip_get_dzbj_if_exists(ls_prog_name)) THEN 
            LET lb_if_download_diff = TRUE 
          END IF 
        END IF  
        IF lb_if_download_diff THEN 
         LET ls_err_code = "adz-00952"
         LET ls_err_msg  = ls_prog_name,"|"
         CALL sadzp000_msg_question_box(ls_err_code,ls_err_code,ls_err_msg,0) RETURNING ls_result
         IF ls_result = cs_response_no THEN
           CONTINUE FOR   
         END IF
        END IF 
      END IF
      #170208-00008 end
      
      #取得實際版次的資訊
      CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*
      LET ls_sd_version  = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].sd_ver
      LET ls_pg_version  = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].pg_ver

      ----------------------------------------------------------------------------------------------------
      ----------------------------------------------------------------------------------------------------
      #當識別為 c 且為第一版且已啟動ALM且Interface有效時執行搬移
      LET ls_role = sadzp50_get_download_match_type(ls_download_type)
      LET li_role_count = 1
      LET lo_role_arr[li_role_count] = ls_role
      
      #SD及PR的拋轉程序
      CASE 
        WHEN lo_role_arr[li_role_count] = cs_user_role_sd
          LET ls_GUID = lo_prog_list[li_rec_cnt].DZLM018
        WHEN lo_role_arr[li_role_count] = cs_user_role_pr
          LET ls_GUID = lo_prog_list[li_rec_cnt].DZLM019
      END CASE
      
      #取得現今DZAF的資料
      LET lo_dzaf_t_curr.DZAF001 = ls_prog_name
      LET lo_dzaf_t_curr.DZAF005 = ls_spec_type
      LET lo_dzaf_t_curr.DZAF010 = ls_DGENV
      CALL sadzp200_ver_get_curr_ver_info(lo_dzaf_t_curr.*) RETURNING lo_dzaf_t_curr.*
        
      #2014/12/03 by Hiko:補上下載規則
      IF NOT adzp050_continue_download(lo_dzaf_t_curr.*, ls_download_type) THEN
         CONTINUE FOR
      END IF

      #取得上一版次DZAF的資料
      LET lo_dzaf_t_prev.DZAF001 = ls_prog_name
      LET lo_dzaf_t_prev.DZAF005 = ls_spec_type
      LET lo_dzaf_t_prev.DZAF010 = ls_DGENV
      CALL sadzp200_ver_get_prev_ver_info_by_dgenv(lo_dzaf_t_prev.*,ls_role) RETURNING lo_dzaf_t_prev.*
      
      #IF (lo_dzaf_t_prev.DZAF001 IS NOT NULL) AND (lo_dzaf_t_curr.DZAF001 IS NOT NULL) THEN
        #不為 topstd 時才執行搬移
        IF NOT ((ms_user_name = cs_topstd_user_name) AND (ms_DGENV = cs_dgenv_standard)) THEN
          #呼叫搬移程序
          CALL sadzp060_2_after_check_out_for_download(ls_prog_name, lo_role_arr[li_role_count], lo_dzaf_t_curr.*, lo_dzaf_t_prev.*) RETURNING ms_running_process
          LET lb_result = IIF(ms_running_process IS NULL,TRUE,FALSE)
          IF NOT lb_result THEN LET lb_complete = lb_result GOTO _complete END IF
        END IF  
      #END IF  
      #更新處理碼 #2015/12/04 by Hiko
      #CALL sadzp200_intf_update_process_code(ls_GUID,lo_role_arr[li_role_count],"Y") RETURNING lb_result
      ----------------------------------------------------------------------------------------------------
      ----------------------------------------------------------------------------------------------------
      
      #取得實際版次的資訊
      CALL adzp050_get_current_version(lo_prog_list[li_rec_cnt].origin_prog,lo_prog_list[li_rec_cnt].origin_spec_type,lo_prog_list[li_rec_cnt].origin_identity) RETURNING lo_DZAF_T.*
      #標準程式
      LET ls_orig_prog_name  = lo_DZAF_T.DZAF001 --lo_prog_list[li_rec_cnt].origin_prog
      LET ls_orig_sd_version = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].origin_sd_ver
      LET ls_orig_pg_version = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].origin_pg_ver

      LET li_loop_cnt = 1
      IF ms_DGENV="s" THEN #2014/12/03 by Hiko:只有標準環境才會有行業別議題.
         #若程式名稱和原始程式名稱不一樣, 則為行業別程式, 要抓取原始程式為 "tmp", 跑兩次迴圈
         IF (NVL(lo_prog_list[li_rec_cnt].origin_prog,cs_null_default) <> cs_null_default) AND 
            (lo_prog_list[li_rec_cnt].prog_name <> NVL(lo_prog_list[li_rec_cnt].origin_prog,cs_null_default)) THEN
           LET li_loop_cnt = 2
         END IF
      END IF
      
      DISPLAY "****************************************************************"
      LET li_time_start = CURRENT HOUR TO FRACTION(5)
      DISPLAY "[START] ",ls_prog_name,", Time : ",li_time_start

      #DISPLAY "li_rec_cnt : ",li_rec_cnt
      CALL adzp050_set_alm_progress(0,li_rec_cnt,p_DIALOG)
      CASE 
        #4gl(應用元件),B類
        WHEN (ls_spec_type = "B")

          LET li_inc  = 1
          
          #下載的副檔名
          LET ls_all_zip_ext_name  = cs_zip_name_tzp
          LET ls_form_zip_ext_name = cs_zip_name_tzr
          LET ls_code_zip_ext_name = IIF(gb_diff_download,cs_zip_name_tzx,cs_zip_name_tzc) #170208-00008
          LET ls_identity          = lo_prog_list[li_rec_cnt].identity
          
          FOR li_loop = 1 TO li_loop_cnt

            IF li_loop = 1 THEN 
              #檢核版次資訊是否存在
              IF NOT adzp050_check_version_if_exist(ls_download_type,ls_prog_name,ls_sd_version,ls_pg_version) THEN
                CONTINUE FOR
              END IF
        
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_spec) THEN 
                LET li_step = 2 #Progress bar的程序數
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                -- 2014.11.03 改為產生及下載 rsd 
                --CALL adzp050_generate_csd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_dgenv) RETURNING lb_success
                CALL adzp050_generate_rsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
              
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_code) THEN 
                LET li_step = 4 #Progress bar的程序數
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                #Begin:2015/11/09 by Hiko
                IF sadzp060_2_is_regen(ls_prog_name) THEN
                   CALL adzp050_generate_tab(ls_prog_name,ls_sd_version,ls_dgenv) RETURNING lb_success
                   IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
                END IF
                #End:2015/11/09 by Hiko
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                #Begin:2015/11/09 by Hiko
                IF sadzp060_2_is_regen(ls_prog_name) OR sadzp030_tab_file_template_renewed(ls_prog_name) THEN
                   CALL adzp050_generate_code_4gl(ls_prog_name,ls_module_name.toLowercase(),ls_pg_version,ls_dgenv, "1") RETURNING lb_success
                   IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
                   CALL sadzp060_2_set_regen(ls_prog_name, "N") #2015/11/09 by Hiko:這裡才更新為不須重產.
                ELSE
                   CALL adzp050_generate_code_4gl(ls_prog_name,ls_module_name.toLowercase(),ls_pg_version,ls_dgenv,"3") RETURNING lb_success
                   IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
                END IF
                #Begin:2015/11/09 by Hiko
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                CALL adzp050_generate_tap_file(ls_prog_name,ls_module_name,ls_pg_version,ls_orig_prog_name,ls_orig_pg_version,ls_spec_type,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
            ELSE
              LET li_step = 1 #Progress bar的程序數
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc

              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_spec) THEN 
                CALL adzp050_generate_rsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
              
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_code) THEN 
                CALL adzp050_generate_tap_file(ls_prog_name,ls_module_name,ls_pg_version,ls_orig_prog_name,ls_orig_pg_version,ls_spec_type,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
              
            END IF  
            
            IF (mb_download_all OR ls_download_type = cs_download_type_all)  THEN              
              -- 2014.11.03 改為產生及下載 rsd 
              --CALL adzp050_download_csd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
              CALL adzp050_download_rsd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            ELSE 
              IF ls_download_type = cs_download_type_spec THEN
                -- 2014.11.03 改為產生及下載 rsd 
                --CALL adzp050_download_csd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
                CALL adzp050_download_rsd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
              IF ls_download_type = cs_download_type_code THEN
                CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
            END IF
            
            #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
            #CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
            
            CALL adzp050_set_alm_progress(100,li_rec_cnt,p_DIALOG)
            
            LET ls_prog_name   = lo_prog_list[li_rec_cnt].origin_prog
            LET ls_module_name = lo_prog_list[li_rec_cnt].origin_module
            LET ls_spec_type   = lo_prog_list[li_rec_cnt].origin_spec_type
            LET ls_dgenv       = lo_prog_list[li_rec_cnt].origin_identity

            #取得實際版次資訊
            CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*

            LET ls_sd_version  = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].origin_sd_ver
            LET ls_pg_version  = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].origin_pg_ver

            LET ls_all_zip_ext_name  = cs_zip_name_tmp
            LET ls_form_zip_ext_name = cs_zip_name_tmr
            LET ls_code_zip_ext_name = cs_zip_name_tmc
            LET ls_identity          = lo_prog_list[li_rec_cnt].origin_identity
            
          END FOR   
        #4fd(子畫面),F類
        WHEN (ls_spec_type = "F")
          LET li_inc  = 1
          #下載的副檔名
          LET ls_all_zip_ext_name  = cs_zip_name_tzp
          LET ls_form_zip_ext_name = cs_zip_name_tzs
          LET ls_code_zip_ext_name = IIF(gb_diff_download,cs_zip_name_tzx,cs_zip_name_tzc) #170208-00008
          LET ls_identity          = lo_prog_list[li_rec_cnt].identity
          
          FOR li_loop = 1 TO li_loop_cnt

            IF li_loop = 1 THEN 
              #檢核版次資訊是否存在
              IF NOT adzp050_check_version_if_exist(ls_download_type,ls_prog_name,ls_sd_version,ls_pg_version) THEN
                CONTINUE FOR
              END IF
              
              LET li_step = 2 #Progress bar的程序數
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
              CALL adzp050_generate_tsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_pg_version,ls_orig_prog_name,ls_orig_sd_version,ls_orig_pg_version,ls_dgenv) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
              #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              #CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
              #CALL adzp050_parse_4fd(ls_prog_name,ls_module_name,ls_sd_version) RETURNING lb_success
              #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
            ELSE   
              LET li_step = 1 #Progress bar的程序數
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              CALL adzp050_generate_tsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_pg_version,ls_orig_prog_name,ls_orig_sd_version,ls_orig_pg_version,ls_dgenv) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
            END IF 
            
            CALL adzp050_download_form_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
            IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
            
            CALL adzp050_set_alm_progress(100,li_rec_cnt,p_DIALOG)
            
            LET ls_prog_name   = lo_prog_list[li_rec_cnt].origin_prog
            LET ls_module_name = lo_prog_list[li_rec_cnt].origin_module
            LET ls_spec_type   = lo_prog_list[li_rec_cnt].origin_spec_type
            LET ls_dgenv       = lo_prog_list[li_rec_cnt].origin_identity

            #取得實際版次資訊
            CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*

            LET ls_sd_version  = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].origin_sd_ver
            LET ls_pg_version  = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].origin_pg_ver

            LET ls_all_zip_ext_name  = cs_zip_name_tmp
            LET ls_form_zip_ext_name = cs_zip_name_tms
            LET ls_code_zip_ext_name = cs_zip_name_tmc
            LET ls_identity          = lo_prog_list[li_rec_cnt].origin_identity
            
          END FOR   
        #4gl,4fd(主程式,子程式)
        WHEN (ls_spec_type = "M") OR (ls_spec_type = "S") OR (ls_spec_type = "Q")
          LET li_inc = 1
          #下載的副檔名
          LET ls_all_zip_ext_name  = cs_zip_name_tzp
          LET ls_form_zip_ext_name = cs_zip_name_tzs
          LET ls_code_zip_ext_name = IIF(gb_diff_download,cs_zip_name_tzx,cs_zip_name_tzc) #170208-00008
          LET ls_identity          = lo_prog_list[li_rec_cnt].identity
          
          FOR li_loop = 1 TO li_loop_cnt

            IF li_loop = 1 THEN 
            
              #檢核版次資訊是否存在
              IF NOT adzp050_check_version_if_exist(ls_download_type,ls_prog_name,ls_sd_version,ls_pg_version) THEN
                CONTINUE FOR
              END IF
              
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_spec) THEN 
                LET li_step = 2 #Progress bar的程序數
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                CALL adzp050_generate_tsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_pg_version,ls_orig_prog_name,ls_orig_sd_version,ls_orig_pg_version,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
                #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                #CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                #CALL adzp050_parse_4fd(ls_prog_name,ls_module_name,ls_sd_version) RETURNING lb_success
                #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
              END IF 
              
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_code) THEN 
                LET li_step = 4 #Progress bar的程序數
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                #Begin:2015/11/09 by Hiko
                IF sadzp060_2_is_regen(ls_prog_name) THEN
                   CALL adzp050_generate_tab(ls_prog_name,ls_sd_version,ls_dgenv) RETURNING lb_success
                   IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
                END IF
                #End:2015/11/09 by Hiko
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                #Begin:2015/11/09 by Hiko
                IF sadzp060_2_is_regen(ls_prog_name) OR sadzp030_tab_file_template_renewed(ls_prog_name) THEN
                   CALL adzp050_generate_code_4gl(ls_prog_name,ls_module_name.toLowercase(),ls_pg_version,ls_dgenv,"1") RETURNING lb_success
                   IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
                   CALL sadzp060_2_set_regen(ls_prog_name, "N") #2015/11/09 by Hiko:這裡才更新為不須重產.
                ELSE
                   CALL adzp050_generate_code_4gl(ls_prog_name,ls_module_name.toLowercase(),ls_pg_version,ls_dgenv,"3") RETURNING lb_success
                   IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
                END IF
                #End:2015/11/09 by Hiko
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                CALL adzp050_generate_tap_file(ls_prog_name,ls_module_name,ls_pg_version,ls_orig_prog_name,ls_orig_pg_version,ls_spec_type,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
              
            ELSE  
              LET li_step = 1 #Progress bar的程序數
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc

              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_spec) THEN 
                CALL adzp050_generate_tsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_pg_version,ls_orig_prog_name,ls_orig_sd_version,ls_orig_pg_version,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
              END IF 
              
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_code) THEN 
                CALL adzp050_generate_tap_file(ls_prog_name,ls_module_name,ls_pg_version,ls_orig_prog_name,ls_orig_pg_version,ls_spec_type,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
              
            END IF   
 
            IF (mb_download_all OR ls_download_type = cs_download_type_all) THEN              
              CALL adzp050_download_form_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            ELSE 
              IF ls_download_type = cs_download_type_spec THEN
                CALL adzp050_download_form_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
              IF ls_download_type = cs_download_type_code THEN
                CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
            END IF 

            #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
            #CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
            CALL adzp050_set_alm_progress(100,li_rec_cnt,p_DIALOG)
            
            LET ls_prog_name   = lo_prog_list[li_rec_cnt].origin_prog
            LET ls_module_name = lo_prog_list[li_rec_cnt].origin_module
            LET ls_spec_type   = lo_prog_list[li_rec_cnt].origin_spec_type
            LET ls_dgenv       = lo_prog_list[li_rec_cnt].origin_identity

            #取得實際版次資訊
            CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*

            LET ls_sd_version  = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].origin_sd_ver
            LET ls_pg_version  = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].origin_pg_ver

            LET ls_all_zip_ext_name  = cs_zip_name_tmp
            LET ls_form_zip_ext_name = cs_zip_name_tms
            LET ls_code_zip_ext_name = cs_zip_name_tmc
            LET ls_identity          = lo_prog_list[li_rec_cnt].origin_identity
            
          END FOR   
          
        #G, X 類報表, Extra Grid 
        WHEN (ls_spec_type = "G") OR (ls_spec_type = "X")
          LET li_inc = 1
          #下載的副檔名
          LET ls_all_zip_ext_name      = cs_zip_name_tzp
          LET ls_form_zip_ext_name     = cs_zip_name_tzr
          LET ls_code_zip_ext_name     = IIF(gb_diff_download,cs_zip_name_tzx,cs_zip_name_tzc) #170208-00008
          LET ls_template_zip_ext_name = cs_zip_name_tzt
          LET ls_identity              = lo_prog_list[li_rec_cnt].identity
          
          FOR li_loop = 1 TO li_loop_cnt
          
            IF li_loop = 1 THEN 
              #檢核版次資訊是否存在
              IF NOT adzp050_check_version_if_exist(ls_download_type,ls_prog_name,ls_sd_version,ls_pg_version) THEN
                CONTINUE FOR
              END IF
              
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_spec) THEN 
                LET li_step = 2 #Progress bar的程序數
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                CALL adzp050_generate_rsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
              
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_code) THEN 
                LET li_step = 4 #Progress bar的程序數
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                #Begin:2015/11/09 by Hiko:G/X的tab重產是在adzi188就處理了, 所以下載階段完全不需要.
                #CALL adzp050_generate_tab(ls_prog_name,ls_pg_version,ls_dgenv) RETURNING lb_success
                #IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
                #End:2015/11/09 by Hiko
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                #Begin:2015/11/09 by Hiko:G/X的tab重產是在adzi188就處理了, 所以下載階段完全不需要.
                IF sadzp060_2_is_regen(ls_prog_name) OR sadzp030_tab_file_template_renewed(ls_prog_name) THEN
                   CALL adzp050_generate_code_4gl(ls_prog_name,ls_module_name.toLowercase(),ls_pg_version,ls_dgenv,"1") RETURNING lb_success
                   IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
                   CALL sadzp060_2_set_regen(ls_prog_name, "N") #2015/11/09 by Hiko:這裡才更新為不須重產.
                ELSE
                   CALL adzp050_generate_code_4gl(ls_prog_name,ls_module_name.toLowercase(),ls_pg_version,ls_dgenv,"3") RETURNING lb_success
                   IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
                END IF
                #End:2015/11/09 by Hiko
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                CALL adzp050_generate_tap_file(ls_prog_name,ls_module_name,ls_pg_version,ls_orig_prog_name,ls_orig_pg_version,ls_spec_type,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
              END IF
            ELSE
              LET li_step = 1 #Progress bar的程序數
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_spec) THEN 
                CALL adzp050_generate_rsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
              
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_code) THEN 
                CALL adzp050_generate_tap_file(ls_prog_name,ls_module_name,ls_pg_version,ls_orig_prog_name,ls_orig_pg_version,ls_spec_type,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
              END IF
            END IF  

            IF (mb_download_all OR ls_download_type = cs_download_type_all)  THEN              
              CALL adzp050_download_rsd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            ELSE 
              IF ls_download_type = cs_download_type_4rp THEN
                CALL adzp050_download_4rp_pack(p_DIALOG,cs_run_type_alm,li_rec_cnt,ls_prog_name,ls_module_name,ls_spec_type,ls_pg_version,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_template_zip_ext_name,mo_template_list) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
              IF ls_download_type = cs_download_type_spec THEN
                CALL adzp050_download_rsd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
              IF ls_download_type = cs_download_type_code THEN
                CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF   
            END IF 

            #CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
            #CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)

            CALL adzp050_set_alm_progress(100,li_rec_cnt,p_DIALOG)
            
            LET ls_prog_name   = lo_prog_list[li_rec_cnt].origin_prog
            LET ls_module_name = lo_prog_list[li_rec_cnt].origin_module
            LET ls_spec_type   = lo_prog_list[li_rec_cnt].origin_spec_type
            LET ls_dgenv       = lo_prog_list[li_rec_cnt].origin_identity

            #取得實際版次資訊
            CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*

            LET ls_sd_version  = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].origin_sd_ver
            LET ls_pg_version  = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].origin_pg_ver
            
            LET ls_all_zip_ext_name      = cs_zip_name_tmp
            LET ls_form_zip_ext_name     = cs_zip_name_tmr
            LET ls_code_zip_ext_name     = cs_zip_name_tmc
            LET ls_template_zip_ext_name = cs_zip_name_tmt
            LET ls_identity              = lo_prog_list[li_rec_cnt].origin_identity
            
          END FOR   
        #Web Service W,Z類
        WHEN (ls_spec_type = "W") OR (ls_spec_type = "Z")
          LET li_inc = 1
          #下載的副檔名
          LET ls_all_zip_ext_name  = cs_zip_name_tzp
          LET ls_form_zip_ext_name = cs_zip_name_tzr
          LET ls_code_zip_ext_name = IIF(gb_diff_download,cs_zip_name_tzx,cs_zip_name_tzc) #170208-00008
          LET ls_identity          = lo_prog_list[li_rec_cnt].identity
          
          FOR li_loop = 1 TO li_loop_cnt

            IF li_loop = 1 THEN 
              #檢核版次資訊是否存在
              IF NOT adzp050_check_version_if_exist(ls_download_type,ls_prog_name,ls_sd_version,ls_pg_version) THEN
                CONTINUE FOR
              END IF
              
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_spec) THEN 
                LET li_step = 2 #Progress bar的程序數
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                CALL adzp050_generate_rsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
              
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_code) THEN 
                LET li_step = 4 #Progress bar的程序數
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                #Begin:2015/11/09 by Hiko
                IF sadzp060_2_is_regen(ls_prog_name) THEN
                   CALL adzp050_generate_tab(ls_prog_name,ls_sd_version,ls_dgenv) RETURNING lb_success
                   IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
                END IF
                #End:2015/11/09 by Hiko
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                #Begin:2015/11/09 by Hiko
                IF sadzp060_2_is_regen(ls_prog_name) OR sadzp030_tab_file_template_renewed(ls_prog_name) THEN
                   CALL adzp050_generate_code_4gl(ls_prog_name,ls_module_name.toLowercase(),ls_pg_version,ls_dgenv,"1") RETURNING lb_success
                   IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
                   CALL sadzp060_2_set_regen(ls_prog_name, "N") #2015/11/09 by Hiko:這裡才更新為不須重產.
                ELSE
                   CALL adzp050_generate_code_4gl(ls_prog_name,ls_module_name.toLowercase(),ls_pg_version,ls_dgenv,"3") RETURNING lb_success
                   IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF
                END IF
                #End:2015/11/09 by Hiko
                CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
                CALL adzp050_set_alm_progress(li_progress,li_rec_cnt,p_DIALOG)
                CALL adzp050_generate_tap_file(ls_prog_name,ls_module_name,ls_pg_version,ls_orig_prog_name,ls_orig_pg_version,ls_spec_type,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
            ELSE
              LET li_step = 1 #Progress bar的程序數
              CALL adzp050_get_progress(li_step,li_loop_cnt,li_inc) RETURNING li_progress,li_inc
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_spec) THEN 
                CALL adzp050_generate_rsd_file(ls_prog_name,ls_module_name,ls_spec_type,ls_sd_version,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
              
              IF (mb_download_all OR ls_download_type = cs_download_type_all OR ls_download_type = cs_download_type_code) THEN 
                CALL adzp050_generate_tap_file(ls_prog_name,ls_module_name,ls_pg_version,ls_orig_prog_name,ls_orig_pg_version,ls_spec_type,ls_dgenv) RETURNING lb_success
                IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
              END IF
            END IF   

            IF ls_download_type = cs_download_type_spec THEN
              CALL adzp050_download_rsd_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_form_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            END IF   
            IF ls_download_type = cs_download_type_code THEN
              CALL adzp050_download_code_pack(ls_prog_name,ls_module_name,ls_identity,ls_tgl_path,ls_temp_path||ls_separator||ls_prog_name||ls_separator,ls_client_path,ls_code_zip_ext_name,ms_erpalm,FALSE) RETURNING lb_success
              IF NOT lb_success THEN LET lb_complete = FALSE GOTO _complete END IF 
            END IF

            CALL adzp050_set_alm_progress(100,li_rec_cnt,p_DIALOG)
            
            LET ls_prog_name   = lo_prog_list[li_rec_cnt].origin_prog
            LET ls_module_name = lo_prog_list[li_rec_cnt].origin_module
            LET ls_spec_type   = lo_prog_list[li_rec_cnt].origin_spec_type
            LET ls_dgenv       = lo_prog_list[li_rec_cnt].origin_identity

            #取得實際版次資訊
            CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*

            LET ls_sd_version  = lo_DZAF_T.DZAF003 --lo_prog_list[li_rec_cnt].origin_sd_ver
            LET ls_pg_version  = lo_DZAF_T.DZAF004 --lo_prog_list[li_rec_cnt].origin_pg_ver
            
            LET ls_all_zip_ext_name  = cs_zip_name_tmp
            LET ls_form_zip_ext_name = cs_zip_name_tms
            LET ls_code_zip_ext_name = cs_zip_name_tmc
            LET ls_identity          = lo_prog_list[li_rec_cnt].origin_identity
            
          END FOR   
        OTHERWISE
      END CASE
      
      IF lo_prog_list[li_rec_cnt].auto_start = "Y" THEN
        CALL adzp050_start_spec_designer(ls_prog_name,cs_zip_name_tzp)
      END IF
      
      LABEL _complete:

      IF NOT lb_complete THEN
        LET ls_err_code = "adz-00162"
        #Begin:2015/12/25 by Hiko
        #LET ls_err_msg  = ls_prog_name,"|",ms_running_process,"|"
        #CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code  = ls_err_code
        LET g_errparam.replace[1] = ls_prog_name
        LET g_errparam.replace[2] = ms_running_process
        LET g_errparam.popup = TRUE
        CALL cl_err()
        #End:2015/12/25 by Hiko
        CALL sadzp060_2_set_regen(ls_prog_name, "Y") #2015/11/09 by Hiko:下載失敗強制將更新flag變成Y.
      ELSE 
        #下載成功時要更新下載狀態碼
        LET lo_USER_INFO.ui_NUMBER = ms_user
        LET lo_USER_INFO.ui_NAME   = cl_get_accountname(ms_user)
        LET lo_USER_INFO.ui_LANG   = ms_lang
        LET lo_USER_INFO.ui_ROLE   = sadzp50_get_download_match_type(ls_download_type)

        {
        #取得實際版次資訊
        CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*

        LET lo_prog_list[li_rec_cnt].version = lo_DZAF_T.DZAF002
        LET lo_prog_list[li_rec_cnt].sd_ver  = lo_DZAF_T.DZAF003
        LET lo_prog_list[li_rec_cnt].pg_ver  = lo_DZAF_T.DZAF004
        }
        
        CALL adzp050_set_dzlm_data_from_screen_array(lo_prog_list[li_rec_cnt].*,lo_USER_INFO.*) RETURNING lo_DZLM_T.*
        CALL sadzp200_alm_flush_dzlm_array(lo_DZLM_T.*) RETURNING lo_DZLM_T.*
        CALL sadzp200_alm_update_download_code(lo_DZLM_T.*,lo_USER_INFO.ui_ROLE) RETURNING lb_result
        IF NOT lb_result THEN
          LET ls_err_code = "adz-00306"
          LET ls_err_msg  = ls_prog_name,"|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
        END IF  
      END IF
      
      LET li_time_end = CURRENT HOUR TO FRACTION(5) 
      DISPLAY "[END] ",ls_prog_name,", Time : ",li_time_end
      DISPLAY "****************************************************************"
      DISPLAY "[SPEND TIME] ",ls_prog_name,", Time : ",li_time_end - li_time_start
      DISPLAY "****************************************************************"
      LET mi_spend_time = mi_spend_time + (li_time_end - li_time_start)
      
      LET li_loops = li_loops + 1
      IF li_loops > li_file_counts THEN
        LET li_loops = 1
        LET ls_file_counts = li_file_counts
        #程式下載已達最高下載數目是否繼續
        IF NOT cl_ask_confirm_parm("adz-00131",ls_file_counts) THEN
          EXIT FOR
        END IF
      END IF

    END IF
  END FOR

  DISPLAY cs_download_str
  
END FUNCTION

FUNCTION adzp050_get_dzaf_data_from_dzan(p_dzan_t)
DEFINE
  p_dzan_t T_DZAN_T
DEFINE
  lo_dzan_t T_DZAN_T
DEFINE 
  lo_dzaf_t T_DZAF_T
  
  LET lo_dzan_t.* = p_dzan_t.*

  CASE 
    WHEN lo_dzan_t.DZAN013 = cs_interface_type_prev
      LET lo_dzaf_t.DZAF001 = lo_dzan_t.DZAN001
      LET lo_dzaf_t.DZAF002 = lo_dzan_t.DZAN002
      LET lo_dzaf_t.DZAF003 = lo_dzan_t.DZAN003
      LET lo_dzaf_t.DZAF004 = lo_dzan_t.DZAN004
      LET lo_dzaf_t.DZAF005 = lo_dzan_t.DZAN005
      LET lo_dzaf_t.DZAF006 = lo_dzan_t.DZAN006
      LET lo_dzaf_t.DZAF007 = lo_dzan_t.DZAN007
      LET lo_dzaf_t.DZAF008 = lo_dzan_t.DZAN008
      LET lo_dzaf_t.DZAF009 = lo_dzan_t.DZAN009
      LET lo_dzaf_t.DZAF010 = lo_dzan_t.DZAN010
    WHEN lo_dzan_t.DZAN013 = cs_interface_type_curr
      LET lo_dzaf_t.DZAF001 = lo_dzan_t.DZAN001
      LET lo_dzaf_t.DZAF002 = lo_dzan_t.DZAN002
      LET lo_dzaf_t.DZAF003 = lo_dzan_t.DZAN003
      LET lo_dzaf_t.DZAF004 = lo_dzan_t.DZAN004
      LET lo_dzaf_t.DZAF005 = lo_dzan_t.DZAN005
      LET lo_dzaf_t.DZAF006 = lo_dzan_t.DZAN006
      LET lo_dzaf_t.DZAF007 = lo_dzan_t.DZAN007
      LET lo_dzaf_t.DZAF008 = lo_dzan_t.DZAN008
      LET lo_dzaf_t.DZAF009 = lo_dzan_t.DZAN009
      LET lo_dzaf_t.DZAF010 = lo_dzan_t.DZAN010
  END CASE 

  RETURN lo_dzaf_t.*
  
END FUNCTION 

#ALM簽出
FUNCTION adzp050_alm_check_out(p_download_type)
DEFINE
  p_download_type STRING 
DEFINE 
  ls_module_name   STRING,
  ls_download_type STRING, 
  lo_prog_list     DYNAMIC ARRAY OF T_PROG_LIST,
  li_rec_cnt       INTEGER,
  ls_prog_name     STRING,
  ls_spec_type     STRING,
  ls_err_code      STRING,
  ls_err_msg       STRING,
  lb_dzlm_exist    BOOLEAN,
  lb_result        BOOLEAN,
  li_dzlu_t        INTEGER,
  ls_GUID          STRING,
  ls_update_type   STRING,
  lo_role_arr      T_STATIC_ROLE_LIST,
  lo_rev_role_arr  T_STATIC_ROLE_LIST,
  lo_prog_list_arr DYNAMIC ARRAY OF VARCHAR(30),
  li_role_count    INTEGER,
  li_dzan_count    INTEGER,
  li_prog_list_arr INTEGER,
  lb_complete      BOOLEAN,
  ls_DGENV         STRING,
  ls_list_sql      STRING,
  ls_msg_code      STRING,
  ls_dzlm002       STRING,
  lb_dzlu_result   BOOLEAN,
  lb_run_two_trip  BOOLEAN,
  lb_revision      BOOLEAN,
  lb_had_check_in  BOOLEAN, 
  li_step          INTEGER,
  ls_parameter     STRING,
  lb_std_to_cust   BOOLEAN,
  ls_action        STRING,
  ls_message       STRING,
  li_sd_max_inc_num  INTEGER,
  li_pr_max_inc_num  INTEGER,
  lb_check_out_fault BOOLEAN,
  lb_allow_inc       BOOLEAN,
  li_count         INTEGER, 
  ls_temp_path     STRING,
  ls_separator     STRING,
  lb_gen_Q_hcode   BOOLEAN,
  li_check_out_owner_list INTEGER,
  ls_check_out_owner_list STRING,
  ls_check_version STRING,
  lo_BACKUP_DESIGN_DATA_RET DYNAMIC ARRAY OF T_BACKUP_DESIGN_DATA_RET,
  lo_program_info  T_PROGRAM_INFO,
  lo_USER_INFO     T_USER_INFO,
  lo_DZAF_T        T_DZAF_T,
  lo_DZLU_T        DYNAMIC ARRAY OF T_DZLU_T,  
  lo_DZLM_T        T_DZLM_T,
  lo_prev_DZAF_T   T_DZAF_T,
  lo_curr_DZAF_T   T_DZAF_T,
  lo_back_DZAF_T   T_DZAF_T,
  lo_DZAT_T        T_DZAT_PARA,
  lo_standard_DZAF_T  T_DZAF_T,
  lo_backup_design_data_intf T_BACKUP_DESIGN_DATA_INTF,
  lb_alm_exist        BOOLEAN,
  lo_DZAN_T           DYNAMIC ARRAY OF T_DZAN_T, 
  lo_check_out_owner_list DYNAMIC ARRAY OF T_CHECK_OUT_OWNER_LIST,
  ls_cmd           STRING    #20160121 by elena
DEFINE
  lb_return  BOOLEAN  
DEFINE
  lb_sd_bk_finish BOOLEAN, #2015.05.15 by Hiko
  lb_pr_bk_finish BOOLEAN,  #2015.05.15 by Hiko
  lb_sd_bk_dsg_finish BOOLEAN, #2015.05.15 by Hiko
  lb_pr_bk_dsg_finish BOOLEAN, #2015.05.15 by Hiko
  ls_err_msg2 STRING #2015/12/22 by Hiko
  
  LET ls_download_type = p_download_type

  LET lb_complete     = TRUE
  LET lb_result       = TRUE
  
  LET lb_run_two_trip = FALSE
  LET lb_revision     = FALSE
  LET ls_message      = ""
  LET lb_gen_Q_hcode  = FALSE
  
  CALL lo_prog_list_arr.clear()

  LET ls_temp_path = FGL_GETENV("TEMPDIR")
  LET ls_separator = os.Path.separator()
  
  LET lo_USER_INFO.ui_NUMBER = ms_user
  LET lo_USER_INFO.ui_NAME   = cl_get_accountname(ms_user)
  LET lo_USER_INFO.ui_LANG   = ms_lang
  LET lo_USER_INFO.ui_ROLE   = sadzp50_get_download_match_type(ls_download_type)
  
  #取得DZLU資料
  IF (ms_erpalm = "Y") AND (ms_user_name <> cs_topstd_user_name) THEN
    CALL sadzp200_ckout_run(lo_USER_INFO.ui_ROLE,lo_USER_INFO.ui_NUMBER,lo_USER_INFO.ui_LANG,li_step,FALSE) RETURNING lb_dzlu_result,li_step,lo_DZLU_T
  ELSE
    CALL sadzp200_ckout_get_dzlu_without_alm(lo_USER_INFO.ui_ROLE,lo_USER_INFO.ui_NUMBER) RETURNING lb_dzlu_result,lo_DZLU_T
  END IF   

  LET lb_sd_bk_finish = FALSE #2015.05.15 by Hiko
  LET lb_pr_bk_finish = FALSE #2015.05.15 by Hiko
  LET lb_sd_bk_dsg_finish = FALSE #2015.05.15 by Hiko
  LET lb_pr_bk_dsg_finish = FALSE #2015.05.15 by Hiko

  #開始的標記
  LABEL _begin_gen_alm:

  LET lo_USER_INFO.ui_NUMBER = ms_user
  LET lo_USER_INFO.ui_NAME   = cl_get_accountname(ms_user)
  LET lo_USER_INFO.ui_LANG   = ms_lang
  LET lo_USER_INFO.ui_ROLE   = sadzp50_get_download_match_type(ls_download_type)
  
  LET lo_prog_list.* = m_prog_list.*

  LET ls_DGENV  = ms_DGENV
  LET lb_return = TRUE
  LET lb_run_two_trip = FALSE 
  
  IF lb_dzlu_result THEN 
    FOR li_dzlu_t = 1 TO lo_DZLU_T.getLength()
      IF lo_DZLU_T[li_dzlu_t].DZLU001 IS NOT NULL THEN
        FOR li_rec_cnt = 1 TO lo_prog_list.getLength()

          LET lb_result = TRUE

          #有打勾的程式才做簽出
          IF lo_prog_list[li_rec_cnt].prog_selected = "Y" THEN

            #已執行ALM簽出, 所以將執行過的程式取消打勾    
            LET lo_prog_list[li_rec_cnt].prog_selected = "N"

            LET ls_prog_name   = lo_prog_list[li_rec_cnt].prog_name
            LET ls_module_name = IIF(mb_customize,lo_prog_list[li_rec_cnt].cust_module_name,lo_prog_list[li_rec_cnt].module_name)
            LET ls_spec_type   = lo_prog_list[li_rec_cnt].spec_type
            IF (ms_user_name = cs_topstd_user_name) THEN 
              LET ls_dgenv = sadzp200_ver_get_program_curr_dgenv(ls_prog_name)
            ELSE
              LET ls_dgenv = ms_DGENV
            END IF

            #Begin:2015/12/22 by Hiko:這段是為了版次歸一所做的判斷, 目前已經不需要了.
            ##取得SD,PR最大遞增允許值
            #LET lb_allow_inc = TRUE
            #LET li_sd_max_inc_num = NVL(sadzp200_ver_get_parameter(cs_ver_type_sd,cs_max_increase_number),ci_unlimit_number)
            #LET li_pr_max_inc_num = NVL(sadzp200_ver_get_parameter(cs_ver_type_pr,cs_max_increase_number),ci_unlimit_number)
            #CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*
            ##當版次大於最大遞增允許值表示有問題
            #CASE 
            #  WHEN lo_USER_INFO.ui_ROLE = cs_user_role_sd
            #    LET ls_err_msg = ls_prog_name,"|",lo_DZAF_T.DZAF003,"|",li_sd_max_inc_num,"|"
            #    IF (lo_DZAF_T.DZAF003 > li_sd_max_inc_num) AND (li_sd_max_inc_num <> ci_unlimit_number) THEN
            #      LET lb_allow_inc = FALSE
            #    END IF 
            #  WHEN lo_USER_INFO.ui_ROLE = cs_user_role_pr
            #    LET ls_err_msg = ls_prog_name,"|",lo_DZAF_T.DZAF004,"|",li_pr_max_inc_num,"|"
            #    IF (lo_DZAF_T.DZAF004 > li_pr_max_inc_num) AND (li_pr_max_inc_num <> ci_unlimit_number)THEN
            #      LET lb_allow_inc = FALSE
            #    END IF 
            #END CASE
            #IF NOT lb_allow_inc THEN
            #  LET ls_err_code = "adz-00553"
            #  CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
            #  #CONTINUE FOR
            #  EXIT FOR #2015/12/22 by Hiko
            #END IF             
            #End:2015/12/22 by Hiko
            
            #確認若為標準程式, 但是卻沒有建構版本的, 不能簽出
            IF (ms_DGENV = cs_dgenv_customize) AND (lo_prog_list[li_rec_cnt].module_name <> lo_prog_list[li_rec_cnt].cust_module_name) AND (lo_prog_list[li_rec_cnt].version IS NULL) THEN
              LET ls_err_code = "adz-00457"
              LET ls_err_msg  = ls_prog_name,"|"
              CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
              #CONTINUE FOR
              EXIT FOR #2015/12/22 by Hiko
            END IF   
            
            #若在標準環境, 且簽出行業別和程式行業別不同的, 不能簽出
            --IF (ms_erpalm = "Y") AND (ms_DGENV = cs_dgenv_standard) AND (NVL(lo_DZLU_T[li_dzlu_t].DZLU008,cs_null_default) <> NVL(lo_prog_list[li_rec_cnt].industry_type,cs_null_default)) THEN #160803-00006 Marked
            IF (ms_erpalm = "Y") AND (ms_DGENV = cs_dgenv_standard) AND (NVL(lo_DZLU_T[li_dzlu_t].DZLU008,NVL(ms_topind,cs_industry_type_standard)) <> NVL(lo_prog_list[li_rec_cnt].industry_type,NVL(ms_topind,cs_industry_type_standard))) THEN #160803-00006 modified
              LET ls_err_code = "adz-00516"
              LET ls_err_msg  = ls_prog_name,"|"
              CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
              #CONTINUE FOR
              EXIT FOR #2015/12/22 by Hiko
            END IF
            
            #確認若為G,X類的且已客制過的標準程式, 不能用topstd簽出
            IF (ms_user_name = cs_topstd_user_name) AND 
               ((ls_spec_type = 'G') OR (ls_spec_type = 'X')) AND 
               (sadzp200_ver_check_if_base_is_standard(ls_prog_name)) AND
               (lo_prog_list[li_rec_cnt].identity = cs_dgenv_customize) THEN
              LET ls_err_code = "adz-00561"
              LET ls_err_msg  = ls_prog_name,"|"
              CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
              #CONTINUE FOR
              EXIT FOR #2015/12/22 by Hiko
            END IF            

            #Begin:2015/12/22 by Hiko:從下面搬上來.#GET_DZLM
            LET lo_program_info.pi_NAME   = ls_prog_name
            LET lo_program_info.pi_MODULE = ls_module_name
            LET lo_program_info.pi_DESC   = lo_prog_list[li_rec_cnt].prog_desc
            LET lo_program_info.pi_TYPE   = ls_spec_type
            
            #檢核,若程式相同建構版次已經被簽出且簽入,則不能重複簽出
            CALL sadzp200_alm_get_dzlm(lo_program_info.*,cs_user_role_all) RETURNING lo_DZLM_T.*
            
            LET lb_had_check_in = FALSE
            CASE 
              WHEN lo_USER_INFO.ui_ROLE = cs_user_role_sd
                IF lo_DZLM_T.DZLM008 = cs_check_in THEN
                  LET lb_had_check_in = TRUE
                END IF 
              WHEN lo_USER_INFO.ui_ROLE = cs_user_role_pr
                IF lo_DZLM_T.DZLM011 = cs_check_in THEN
                  LET lb_had_check_in = TRUE
                END IF 
            END CASE

            IF lb_had_check_in THEN
              LET ls_err_code = "adz-00327"
              LET ls_err_msg  = ls_prog_name,"|"
              CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
              #CONTINUE FOR
              EXIT FOR #2015/12/22 by Hiko
            END IF 
            #End:2015/12/22 by Hiko

            IF NOT lb_revision THEN
               #Begin:2015/12/22 by Hiko:從下面搬上來:SD_TO_CUST
               LET lb_std_to_cust = FALSE
               #IF (NVL(lo_prog_list[li_rec_cnt].identity,cs_null_default) = cs_dgenv_standard AND mb_customize) AND (NOT lb_revision) THEN
               IF (NVL(lo_prog_list[li_rec_cnt].identity,cs_null_default) = cs_dgenv_standard AND mb_customize) THEN #2015/12/22 by Hiko
                 #確認是否執行標準轉客制
                 LET lb_std_to_cust = TRUE
                 LET ls_msg_code = "adz-00324" 
                 IF NOT cl_ask_confirm_parm(ls_msg_code, lo_prog_list[li_rec_cnt].prog_name) THEN
                   LET lb_result = FALSE                
                   #CONTINUE FOR
                   EXIT FOR #2015/12/22 by Hiko:因為不是錯誤, 所以不需要GOTO _complete.
                 #170111-00006 begin  
                 ELSE
                   IF adzp050_check_if_unlock_section(lo_prog_list[li_rec_cnt].prog_name,lo_prog_list[li_rec_cnt].pg_ver) THEN
                     LET ls_err_code = "adz-00951"
                     LET ls_err_msg  = lo_prog_list[li_rec_cnt].prog_name,"|"
                     CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, 1)
                   END IF  
                 #170111-00006 end  
                 END IF
               ELSE
                 #確認是否要簽出:標準簽出或客製簽出.
                 IF (ms_user_name = cs_topstd_user_name) THEN
                   #LET ls_parameter = ls_prog_name," ",ls_download_type," ","|"
                   #170124-00031 begin
                   CASE 
                     WHEN lo_USER_INFO.ui_ROLE = cs_user_role_sd
                       IF lo_prog_list[li_rec_cnt].sd_ver IS NULL THEN 
                         LET ls_err_code = "adz-00955"
                         LET ls_err_msg  = ls_prog_name,"|"
                         CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
                         CONTINUE FOR
                       END IF
                     WHEN lo_USER_INFO.ui_ROLE = cs_user_role_pr
                       IF lo_prog_list[li_rec_cnt].pg_ver IS NULL THEN 
                         LET ls_err_code = "adz-00956"
                         LET ls_err_msg  = ls_prog_name,"|"
                         CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
                         CONTINUE FOR
                       END IF
                   END CASE
                   #170124-00031 end
                   LET ls_parameter = ls_prog_name," ",ls_download_type #2015/12/17 by Hiko:移除後面的字符
                   IF NOT cl_ask_confirm_parm("adz-00481",ls_parameter) THEN
                     LET lb_result = FALSE                
                     #CONTINUE FOR
                     EXIT FOR #2015/12/22 by Hiko:因為不是錯誤, 所以不需要GOTO _complete.
                   END IF
                 ELSE
                   #LET ls_parameter = ls_prog_name," ",ls_download_type," ","|"
                   LET ls_parameter = ls_prog_name," ",ls_download_type #2015/12/17 by Hiko:移除後面的字符
                   IF NOT cl_ask_confirm_parm("adz-00363",ls_parameter) THEN
                     LET lb_result = FALSE                
                     #CONTINUE FOR
                     EXIT FOR #2015/12/22 by Hiko:因為不是錯誤, 所以不需要GOTO _complete.
                   END IF
                 END IF   
               END IF
            END IF   

            #判斷是否要呼叫 Q 類的 Gen Hard code 程序
            IF (ls_download_type = cs_download_type_code) AND (lo_prog_list[li_rec_cnt].version IS NULL) AND (lo_prog_list[li_rec_cnt].spec_type = "Q") THEN
              LET lb_gen_Q_hcode = TRUE  
            END IF  
            
            #2015/12/22 by Hiko:將整段搬到上面:GET_DZLM

            #2015/12/22 by Hiko:將整段搬到上面:SD_TO_CUST
            
            #依照SD/PR是否有版次決定要產生的版次資訊
            CALL lo_role_arr.clear()
            LET lo_role_arr[1] = sadzp50_get_download_match_type(ls_download_type)
            IF (NVL(lo_prog_list[li_rec_cnt].identity,cs_null_default) = cs_dgenv_standard AND mb_customize) THEN --OR lb_revision THEN  
              CALL adzp050_get_role_list(lo_USER_INFO.ui_ROLE,lo_prog_list[li_rec_cnt].*) RETURNING lo_role_arr
            END IF 

            #取得角色後開始進行簽出動作
            LET lb_check_out_fault = FALSE
            FOR li_role_count = 1 TO lo_role_arr.getLength() 
              -------------------------------------------------------------
              LET lo_USER_INFO.ui_ROLE = lo_role_arr[li_role_count]
              LET lo_DZLU_T[li_dzlu_t].DZLU001 = lo_role_arr[li_role_count]
              -------------------------------------------------------------

              #先取得目前版號資料
              LET lo_DZAF_T.DZAF001 = lo_program_info.pi_NAME
              LET lo_DZAF_T.DZAF005 = lo_program_info.pi_TYPE
              LET lo_DZAF_T.DZAF006 = lo_program_info.pi_MODULE

              #檢核是否正被簽出
              CALL sadzp200_alm_check_item_if_check_out(lo_DZLU_T[li_dzlu_t].*,lo_DZAF_T.*) RETURNING lb_alm_exist
              IF lb_alm_exist THEN
                CALL sadzp200_alm_get_owner_list(lo_program_info.*) RETURNING lo_check_out_owner_list  
                FOR li_check_out_owner_list = 1 TO lo_check_out_owner_list.getLength()
                  IF lo_check_out_owner_list[li_check_out_owner_list].cool_ROLE IS NOT NULL THEN 
                    LET ls_check_out_owner_list = ls_check_out_owner_list,cs_CRLF,
                                                  "Role : ",lo_check_out_owner_list[li_check_out_owner_list].cool_ROLE,cs_CRLF, 
                                                  "ID : ",lo_check_out_owner_list[li_check_out_owner_list].cool_ID,cs_CRLF,
                                                  "Name : ",lo_check_out_owner_list[li_check_out_owner_list].cool_NAME,cs_CRLF,
                                                  "Request Number : ",lo_check_out_owner_list[li_check_out_owner_list].cool_REQUEST_NO,cs_CRLF,
                                                  "Request Sequence : ",lo_check_out_owner_list[li_check_out_owner_list].cool_SEQUENCE_NO,cs_CRLF
                  END IF                                                   
                END FOR
                
                LET ls_err_code = "adz-00287"
                #Begin:2015/12/17 by Hiko:避免簽出失敗出現兩次錯誤訊息.
                #LET ls_err_msg  = ls_prog_name,"|",ls_check_out_owner_list,"|"
                #CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
                LET ls_message  = "\n",cl_getmsg("adz-00745", ms_lang),"\n",ls_check_out_owner_list
                #End:2015/12/17 by Hiko
                LET lb_result = FALSE #這裡不能GOTO到失敗Label,以免出現標準轉客製判斷上的錯誤.
              ELSE #沒有被簽出, 可以正常往下執行.
                #先取得現行的版號資料
                LET lo_DZAF_T.DZAF010 = lo_prog_list[li_rec_cnt].identity 
                CALL sadzp200_ver_get_curr_ver_info(lo_DZAF_T.*) RETURNING lo_DZAF_T.*
                IF (ms_user_name = cs_topstd_user_name) THEN 
                  LET lo_DZAF_T.DZAF010 = sadzp200_ver_get_program_curr_dgenv(ls_prog_name)
                ELSE
                  LET lo_DZAF_T.DZAF010 = ms_DGENV
                END IF

                ----------------------------------------------------------------------------------------------------
                ----------------------------------------------------------------------------------------------------
                #2015.04.08 begin
                #先彙整要傳遞的參數
                LET ls_check_version = NULL
                CASE 
                  WHEN lo_USER_INFO.ui_ROLE = cs_user_role_sd
                    LET ls_check_version = lo_DZAF_T.DZAF003                
                  WHEN lo_USER_INFO.ui_ROLE = cs_user_role_pr
                    LET ls_check_version = lo_DZAF_T.DZAF004                
                END CASE
                #Begin:20160121 by Hiko
                #IF ls_check_version IS NOT NULL THEN 
                #  LET lo_backup_design_data_intf.BDDI_S_spec_type     = lo_prog_list[li_rec_cnt].spec_type   
                #  LET lo_backup_design_data_intf.BDDI_S_file_name     = lo_prog_list[li_rec_cnt].prog_name
                #  LET lo_backup_design_data_intf.BDDI_S_module_name   = lo_prog_list[li_rec_cnt].module_name
                #  LET lo_backup_design_data_intf.BDDI_S_identity      = lo_prog_list[li_rec_cnt].identity 
                #  LET lo_backup_design_data_intf.BDDI_S_module_path   = ""
                #  LET lo_backup_design_data_intf.BDDI_S_lang          = ms_lang
                #  LET lo_backup_design_data_intf.BDDI_S_download_type = ms_download_type
                #  LET lo_backup_design_data_intf.BDDI_S_erpalm        = ms_erpalm
                #  LET lo_backup_design_data_intf.BDDI_B_readonly      = FALSE
                #  LET lo_backup_design_data_intf.BDDI_B_run_alm       = FALSE
                #  CASE 
                #    WHEN lo_USER_INFO.ui_ROLE = cs_user_role_sd
                #      LET lo_backup_design_data_intf.BDDI_S_version   = lo_DZAF_T.DZAF003 
                #    WHEN lo_USER_INFO.ui_ROLE = cs_user_role_pr
                #      LET lo_backup_design_data_intf.BDDI_S_version   = lo_DZAF_T.DZAF004 
                #  END CASE
                #  LET lo_backup_design_data_intf.BDDI_S_dgenv         = lo_DZAF_T.DZAF010 -- 兼顧 topstd
                #  LET lo_backup_design_data_intf.BDDI_O_template_list = mo_template_list
                
                #  #2015.05.15 by Hiko begin
                #  #呼叫產生備份壓縮檔
                #  IF (ms_user_name <> cs_topstd_user_name) THEN
                #    #CALL adzp050_backup_design_data(lo_backup_design_data_intf.*) RETURNING lo_BACKUP_DESIGN_DATA_RET
                #    CASE 
                #      WHEN lo_USER_INFO.ui_ROLE = cs_user_role_sd AND (lo_USER_INFO.ui_ROLE = sadzp50_get_download_match_type(ls_download_type))
                #        IF NOT lb_sd_bk_finish THEN
                #          CALL adzp050_backup_design_data(lo_backup_design_data_intf.*) RETURNING lo_BACKUP_DESIGN_DATA_RET
                #          LET lb_sd_bk_finish = TRUE
                #        END IF
                #      WHEN lo_USER_INFO.ui_ROLE = cs_user_role_pr AND (lo_USER_INFO.ui_ROLE = sadzp50_get_download_match_type(ls_download_type))
                #        IF NOT lb_pr_bk_finish THEN
                #          CALL adzp050_backup_design_data(lo_backup_design_data_intf.*) RETURNING lo_BACKUP_DESIGN_DATA_RET
                #          LET lb_pr_bk_finish = TRUE
                #        END IF
                #    END CASE
                #  END IF  
                #  #2015.05.15 by Hiko end 
                #END IF                
                #End:20160121 by Hiko
                #2015.04.08 end
                ----------------------------------------------------------------------------------------------------
                ----------------------------------------------------------------------------------------------------
                
                #判斷是否可以進行行業同步
                IF (ms_user_name <> cs_topstd_user_name) AND (ms_DGENV = cs_dgenv_standard) THEN 
                  CALL sadzp060_4_ins_dzaq_t(lo_DZAF_T.*,lo_DZLU_T[li_dzlu_t].DZLU003,lo_DZLU_T[li_dzlu_t].DZLU006) RETURNING lb_result,ls_message
                  #IF NOT lb_result THEN GOTO _complete END IF #2015/12/22 by Hiko : 就算沒有寫入dzaq_t應該也沒有關係, 不影響簽出.
                END IF
                
                ----------------------------------------------------------------------
                #取得舊的模組名稱(資料複製及搬移使用)
                LET lo_prev_DZAF_T.* = lo_DZAF_T.*
                LET lo_prev_DZAF_T.DZAF006 = lo_prog_list[li_rec_cnt].module_name
                LET lo_prev_DZAF_T.DZAF010 = lo_prog_list[li_rec_cnt].identity 
                ----------------------------------------------------------------------
                #回傳該資料在DZLM是否存在
                CALL sadzp200_alm_check_data_exist(lo_DZLU_T[li_dzlu_t].*,lo_DZAF_T.*) RETURNING lb_dzlm_exist
               
                BEGIN WORK 
                  #若使用者為 topstd 則不增加版號
                  IF ((ms_user_name = cs_topstd_user_name) AND (ms_DGENV = cs_dgenv_standard)) THEN
                    #取得既有版號
                    CALL sadzp200_ver_get_curr_ver_info(lo_DZAF_T.*) RETURNING lo_DZAF_T.*
                    IF lo_DZAF_T.DZAF002 IS NULL THEN ROLLBACK WORK GOTO _complete END IF 
                  ELSE   
                    #取得新版號
                    CALL sadzp200_ver_get_new_ver_info(lo_DZAF_T.*,lo_USER_INFO.ui_ROLE,lb_dzlm_exist) RETURNING lb_result,lo_DZAF_T.*
                    IF NOT lb_result THEN ROLLBACK WORK GOTO _complete END IF 
                  END IF 
                  #彙整入DZLM_T 
                  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID
                  CALL sadzp200_alm_set_dzlm_mix_info(lo_DZLU_T[li_dzlu_t].*,lo_DZAF_T.*,lo_program_info.*,ls_GUID) RETURNING lb_result,ls_update_type
                  IF NOT lb_result THEN ROLLBACK WORK GOTO _complete END IF
                  ----------------------------------------------------------------------
                  #呼叫產生規格或程式的介面資料(資料複製及搬移使用)
                  LET lo_curr_DZAF_T.* = lo_DZAF_T.*
                  CALL sadzp200_intf_set_interface_data(ls_GUID,lo_USER_INFO.ui_ROLE,lo_prev_DZAF_T.*,lo_curr_DZAF_T.*) RETURNING lb_result
                  IF NOT lb_result THEN ROLLBACK WORK GOTO _complete END IF
                ----------------------------------------------------------------------
                  
                COMMIT WORK

              END IF #結束:檢核是否被簽出
              
              -------------------------------------------------------------------
              -------------------------------------------------------------------
           
              LABEL _complete:

              IF NOT lb_result THEN
                #執行簽出時失敗
                LET lb_check_out_fault = TRUE
                LET ls_err_code = "adz-00284"
                #Begin:2015/12/17 by Hiko
                #LET ls_err_msg  = ls_prog_name,"|",ls_message,"|"
                #CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code  = ls_err_code
                LET g_errparam.replace[1] = ls_prog_name
                LET g_errparam.replace[2] = ls_message
                LET g_errparam.popup = TRUE
                CALL cl_err()
                #End:2015/12/17 by Hiko
                LET ls_message = ""
                EXIT FOR #2015/12/17 by Hiko
              END IF
            END FOR

            ----------------------------------------------------------------------------------------------------
            ----------------------------------------------------------------------------------------------------

            #重設 Role
            LET lo_USER_INFO.ui_ROLE = sadzp50_get_download_match_type(ls_download_type)
            
            #2015.04.08 begin
            #沒有錯誤才作備份(150908-00004)
            IF NOT lb_check_out_fault THEN 
              #Begin:2015/12/22 by Hiko : 乾脆全部移除, 加快速度.
              #LET ls_check_version = NULL
              #CASE 
              #  WHEN lo_USER_INFO.ui_ROLE = cs_user_role_sd
              #    LET ls_check_version = lo_prev_DZAF_T.DZAF003                
              #  WHEN lo_USER_INFO.ui_ROLE = cs_user_role_pr
              #    LET ls_check_version = lo_prev_DZAF_T.DZAF004                
              #END CASE
              #IF ls_check_version IS NOT NULL THEN 
              #  -- 執行 After download 之前先呼叫 sadzp060_3_backup_design_data 執行備份
              #  #先取得目前版號資料
              #  #取得上一版次DZAF的資料
              #  LET lo_prev_dzaf_t.DZAF001 = ls_prog_name
              #  LET lo_prev_dzaf_t.DZAF005 = ls_spec_type
              #  LET lo_prev_dzaf_t.DZAF010 = ls_DGENV
              #  CALL sadzp200_ver_get_prev_ver_info_by_dgenv(lo_prev_dzaf_t.*,lo_USER_INFO.ui_ROLE) RETURNING lo_prev_dzaf_t.*
              #  CALL sadzp200_alm_get_dzlm(lo_program_info.*,cs_user_role_all) RETURNING lo_DZLM_T.*
              #  LET lo_dzat_t.DZAT001   = lo_DZLM_T.DZLM002  #程式代號(PK)            
              #  CASE 
              #    WHEN lo_USER_INFO.ui_ROLE = cs_user_role_sd
              #      LET lo_dzat_t.DZAT002   = lo_DZLM_T.DZLM006 #版次(PK)                
              #    WHEN lo_USER_INFO.ui_ROLE = cs_user_role_pr
              #      LET lo_dzat_t.DZAT002   = lo_DZLM_T.DZLM009 #版次(PK)                
              #  END CASE
              #  LET lo_dzat_t.DZAT003   = lo_DZLM_T.DZLM001       #建構類型(M/S/F/B/G/X..) 
              #  LET lo_dzat_t.DZAT004   = lo_USER_INFO.ui_ROLE    #簽出類型(PK)(SD/PR)     
              #  LET lo_dzat_t.DZAT005   = lo_DZLM_T.DZLM012       #需求單號                
              #  LET lo_dzat_t.DZAT006   = lo_DZLM_T.DZLM015       #需求單項次              
              #  LET lo_dzat_t.DZAT007   = CURRENT HOUR TO SECOND  #簽出日期                
              #  LET lo_dzat_t.DZAT008   = lo_DZLM_T.DZLM004       #模組                    
              #  #LET lo_dzat_t.DZAT009   = ls_file_name  #實體檔案(tzs/tzc)       
              #  #LET lo_dzat_t.DZAT010   = ls_file_name  #實體檔案(tzt)           
              #  LET lo_dzat_t.DZAT013   = ls_DGENV  #客製(PK)                
              #  CASE 
              #    WHEN lo_USER_INFO.ui_ROLE = cs_user_role_sd
              #      LET lo_dzat_t.OLD_REV   = lo_prev_dzaf_t.DZAF003  #SD舊版次         
              #    WHEN lo_USER_INFO.ui_ROLE = cs_user_role_pr
              #      LET lo_dzat_t.OLD_REV   = lo_prev_dzaf_t.DZAF004  #PR舊版次         
              #  END CASE
              #  LET lo_dzat_t.OLD_IDEN  = lo_prev_dzaf_t.DZAF010  #舊客製
              
              #  FOR li_count = 1 TO lo_BACKUP_DESIGN_DATA_RET.getLength()
              #    IF lo_BACKUP_DESIGN_DATA_RET[li_count].BDDR_S_download_type = cs_download_type_4rp THEN
              #      LET lo_dzat_t.TZT_PATH  = lo_BACKUP_DESIGN_DATA_RET[li_count].BDDR_S_src_path||ls_separator||lo_BACKUP_DESIGN_DATA_RET[li_count].BDDR_S_file_name  #TZT的路徑,DZAT003=G才需要 
              #    END IF
              #    IF lo_BACKUP_DESIGN_DATA_RET[li_count].BDDR_S_download_type = cs_download_type_spec OR
              #       lo_BACKUP_DESIGN_DATA_RET[li_count].BDDR_S_download_type = cs_download_type_code THEN
              #       LET lo_dzat_t.FILE_PATH = lo_BACKUP_DESIGN_DATA_RET[li_count].BDDR_S_src_path||ls_separator||lo_BACKUP_DESIGN_DATA_RET[li_count].BDDR_S_file_name  #TZS/TZC的路徑      
              #    END IF    
              #  END FOR                 
              
              #  #2015.05.15 by Hiko begin
              #  #呼叫備份設計資料的 function
              #  IF (ms_user_name <> cs_topstd_user_name) THEN
              #    #CALL sadzp060_3_backup_design_data(lo_dzat_t.*) RETURNING lb_result
              #    CASE 
              #      WHEN lo_USER_INFO.ui_ROLE = cs_user_role_sd
              #        IF NOT lb_sd_bk_dsg_finish THEN
              #          #CALL sadzp060_3_backup_design_data(lo_dzat_t.*) RETURNING lb_result #2015/11/09 by Hiko
              #          LET lb_sd_bk_dsg_finish = TRUE
              #        END IF
              #      WHEN lo_USER_INFO.ui_ROLE = cs_user_role_pr
              #        IF NOT lb_pr_bk_dsg_finish THEN
              #          #CALL sadzp060_3_backup_design_data(lo_dzat_t.*) RETURNING lb_result #2015/11/09 by Hiko
              #          LET lb_pr_bk_dsg_finish = TRUE
              #        END IF
              #    END CASE
              #  END IF  
              #  LET lb_result = TRUE #備份失敗不影響流程, 因此還原預設值.
              #  #2015.05.15 by Hiko end 
              #END IF
              #End:2015/12/22 by Hiko
              
              CALL sadzp060_2_dzay_t(ls_prog_name, lo_prev_DZAF_T.dzaf010, "1") #2015/11/09 by Hiko
            END IF             
            #2015.04.08 end
            
            ----------------------------------------------------------------------------------------------------
            ----------------------------------------------------------------------------------------------------
            
            #=============================== After Download Begin ===========================================
            #建構版次不為空的時候進行搬移
            #IF (lo_prog_list[li_rec_cnt].version IS NOT NULL) AND NOT lb_check_out_fault THEN
            #2014.11.21 改為沒有版次一樣呼叫 sadzp060_2_after_check_out_for_download
            IF NOT lb_check_out_fault THEN
            
              #當識別為 c 且為第一版且已啟動ALM且Interface有效時執行搬移
              LET li_role_count = 1
              CALL lo_rev_role_arr.clear()
              LET lo_rev_role_arr[li_role_count] = lo_USER_INFO.ui_ROLE
              LET lb_complete = TRUE
              
              #設定程式資訊 
              LET lo_program_info.pi_NAME   = ls_prog_name
              LET lo_program_info.pi_MODULE = ls_module_name
              LET lo_program_info.pi_DESC   = lo_prog_list[li_rec_cnt].prog_desc
              LET lo_program_info.pi_TYPE   = ls_spec_type

              CALL sadzp200_alm_get_dzlm(lo_program_info.*,cs_user_role_all) RETURNING lo_DZLM_T.*
              
              #標準轉客制時要做SD及PR的拋轉程序
              LET ls_dzlm002 = lo_DZLM_T.DZLM002
              IF mb_customize AND (lo_DZLM_T.DZLM005 = '1') AND sadzp200_ver_check_if_base_is_standard(ls_prog_name) THEN 

                DISPLAY cs_information_tag,"Transform program from standard to customize." 
                 
                #先取得角色清單(有版次的表示有該角色)  
                CALL sadzp200_alm_get_dzlm_role_list(lo_DZLM_T.*) RETURNING lo_rev_role_arr
                FOR li_role_count = 1 TO lo_rev_role_arr.getLength()
                  CASE 
                    WHEN lo_rev_role_arr[li_role_count] = cs_user_role_sd
                      LET ls_GUID = lo_DZLM_T.DZLM018
                    WHEN lo_rev_role_arr[li_role_count] = cs_user_role_pr
                      LET ls_GUID = lo_DZLM_T.DZLM019
                  END CASE
                  
                  #取得現今DZAF的資料
                  LET lo_curr_DZAF_T.DZAF001 = ls_prog_name
                  LET lo_curr_DZAF_T.DZAF005 = ls_spec_type
                  LET lo_curr_DZAF_T.DZAF010 = ls_DGENV
                  CALL sadzp200_ver_get_curr_ver_info(lo_curr_DZAF_T.*) RETURNING lo_curr_DZAF_T.*

                  #取得上一版次DZAF的資料
                  LET lo_prev_dzaf_t.DZAF001 = ls_prog_name
                  LET lo_prev_dzaf_t.DZAF005 = ls_spec_type
                  LET lo_prev_dzaf_t.DZAF010 = ls_DGENV
                  CALL sadzp200_ver_get_prev_ver_info_by_dgenv(lo_prev_dzaf_t.*,lo_role_arr[li_role_count]) RETURNING lo_prev_dzaf_t.*

                  #2014.11.21 改為沒有版次一樣呼叫 sadzp060_2_after_check_out_for_download
                  #IF (lo_prev_dzaf_t.DZAF001 IS NOT NULL) AND (lo_curr_dzaf_t.DZAF001 IS NOT NULL) THEN
                    #不為 topstd 時才執行搬移.
                    IF NOT ((ms_user_name = cs_topstd_user_name) AND (ms_DGENV = cs_dgenv_standard)) THEN
                      #呼叫搬移程序
                      #Begin:2015/12/04 by Hiko:回傳值改為ls_err_msg
                      #CALL sadzp060_2_after_check_out_for_download(ls_prog_name, lo_rev_role_arr[li_role_count], lo_curr_dzaf_t.*, lo_prev_dzaf_t.*) RETURNING ms_running_process
                      #LET lb_result = IIF(ms_running_process IS NULL,TRUE,FALSE)
                      CALL sadzp060_2_after_check_out_for_download(ls_prog_name, lo_rev_role_arr[li_role_count], lo_curr_dzaf_t.*, lo_prev_dzaf_t.*) RETURNING ls_err_msg
                      #Begin:20160121 by elena 
                      IF lo_rev_role_arr[li_role_count] = cs_user_role_pr THEN
                         LET ls_cmd = "r.l ",ls_prog_name," ALL"
                         DISPLAY "adzp050 : ",ls_cmd
                         RUN ls_cmd WITHOUT WAITING  #背景執行r.1
                      END IF
                      #End:20160121 by elena
                      LET lb_result = IIF(ls_err_msg IS NULL,TRUE,FALSE)
                      #標準轉客製搬移不成功就不特別處理,由使用者自行透過adzp063的第4選項還原標準.
                      #End:2015/12/04 by Hiko
                      #搬移不成功則進行刪除.刪除失敗就算了. 
                      IF NOT lb_result THEN
                        LET ls_action = "4"
                        #CALL sadzp063_1_del_design_data(lo_prev_dzaf_t.*, ls_action) RETURNING lb_result,ls_err_msg2 #2015/12/25 by Hiko:改在_movefault處理
                        #Begin:2015/12/17 by Hiko
                        #IF NOT lb_result THEN
                        #  LET ls_err_code = "adz-00164"
                        #  LET ls_err_msg  = "|"
                        #  CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
                        #END IF
                        #End:2015/12/17 by Hiko
                        LET lb_result = FALSE

                        EXIT FOR #2015/12/25 by Hiko:這樣當規格轉客製過程有錯誤的時候就不會繼續跑程式的部分了.
                      END IF
                    END IF  
                  #END IF  
                  #更新處理碼 #2015/12/04 by Hiko
                  #CALL sadzp200_intf_update_process_code(ls_GUID,lo_rev_role_arr[li_role_count],"Y") RETURNING lb_result
                  --IF NOT lb_result THEN EXIT FOR END IF
                END FOR 

                IF NOT lb_result THEN LET lb_complete = lb_result GOTO _moveing_fault END IF
              ELSE #正常的標準/客製簽出.
                DISPLAY cs_information_tag,"Generate program." 
                #不然只做SD或PR
                CASE 
                  WHEN lo_rev_role_arr[li_role_count] = cs_user_role_sd
                    LET ls_GUID = lo_DZLM_T.DZLM018
                    LET ls_action = "1" #2015/12/17 by Hiko:規格簽出失敗還原使用
                  WHEN lo_rev_role_arr[li_role_count] = cs_user_role_pr
                    LET ls_GUID = lo_DZLM_T.DZLM019
                    LET ls_action = "2" #2015/12/17 by Hiko:程式簽出失敗還原使用
                END CASE
                
                #取得現今DZAF的資料
                LET lo_curr_DZAF_T.DZAF001 = ls_prog_name
                LET lo_curr_DZAF_T.DZAF005 = ls_spec_type
                LET lo_curr_DZAF_T.DZAF010 = ls_DGENV
                CALL sadzp200_ver_get_curr_ver_info(lo_curr_DZAF_T.*) RETURNING lo_curr_DZAF_T.*
                  
                #取得上一版次DZAF的資料
                LET lo_prev_dzaf_t.DZAF001 = ls_prog_name
                LET lo_prev_dzaf_t.DZAF005 = ls_spec_type
                LET lo_prev_dzaf_t.DZAF010 = ls_DGENV
                CALL sadzp200_ver_get_prev_ver_info_by_dgenv(lo_prev_dzaf_t.*,lo_role_arr[li_role_count]) RETURNING lo_prev_dzaf_t.*

                #呼叫sadzp210_gen_hardcode_to_freestyle
                IF lb_gen_Q_hcode THEN 
                  LET lb_gen_Q_hcode = FALSE
                  CALL sadzp210_gen_hardcode_to_freestyle(ls_prog_name) RETURNING lb_result,ls_err_msg #2015/12/25 by Hiko:ls_message改成ls_err_msg
                  IF NOT lb_result THEN
                    DISPLAY cs_error_tag," Call sadzp210_gen_hardcode_to_freestyle fault : ",ls_err_msg 
                    LET lb_complete = lb_result 
                    GOTO _moveing_fault 
                  END IF
                END IF
                
                #2014.11.21 改為沒有版次一樣呼叫 sadzp060_2_after_check_out_for_download
                #IF (lo_prev_dzaf_t.DZAF001 IS NOT NULL) AND (lo_curr_dzaf_t.DZAF001 IS NOT NULL) THEN
                  #不為 topstd 時才執行搬移
                  IF NOT ((ms_user_name = cs_topstd_user_name) AND (ms_DGENV = cs_dgenv_standard)) THEN
                    #呼叫搬移程序
                    #Begin:2015/12/04 by Hiko:回傳值改為ls_err_msg
                    #CALL sadzp060_2_after_check_out_for_download(ls_prog_name, lo_rev_role_arr[li_role_count], lo_curr_dzaf_t.*, lo_prev_dzaf_t.*) RETURNING ms_running_process
                    #LET lb_result = IIF(ms_running_process IS NULL,TRUE,FALSE)
                    CALL sadzp060_2_after_check_out_for_download(ls_prog_name, lo_rev_role_arr[li_role_count], lo_curr_dzaf_t.*, lo_prev_dzaf_t.*) RETURNING ls_err_msg
                    LET lb_result = IIF(ls_err_msg IS NULL,TRUE,FALSE)
                    #Begin:2015/12/25 by Hiko:統一改在_moveing_fault處理.
                    ##Begin:2015/12/04 by Hiko:搬移不成功則進行刪除.刪除失敗就算了.
                    #IF NOT lb_result THEN
                    #  CALL sadzp063_1_del_design_data(lo_prev_dzaf_t.*, ls_action) RETURNING lb_result,ls_err_msg2
                    #END IF
                    ##End:2015/12/04 by Hiko
                    #End:2015/12/25 by Hiko
                    IF NOT lb_result THEN LET lb_complete = lb_result GOTO _moveing_fault END IF
                  END IF  
                #END IF  
                #更新處理碼 #2015/12/04 by Hiko
                #CALL sadzp200_intf_update_process_code(ls_GUID,lo_rev_role_arr[li_role_count],"Y") RETURNING lb_result
              END IF 
              
              ----------------------------------------------------------------------------------------------------
              ----------------------------------------------------------------------------------------------------
              
              LABEL _moveing_fault:

              IF NOT lb_complete THEN #搬移時失敗
                #Begin:2015/12/04 by Hiko:還原註解,簽出過程失敗需要還原.
                #LET ls_err_code = "adz-00318"
                #LET ls_err_msg  = ls_prog_name,"|"
                #CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)

                #Begin:2015/12/25 by Hiko
                #LET ls_err_code = "adz-00737"
                IF ls_action="4" THEN #表示這是標準轉客製失敗的還原
                   LET ls_err_code = "adz-00748" #簽出成功但產生新版客製設計資料過程失敗, 即將進行反簽出動作. 結束之後請查明原因後再重新簽出.
                ELSE
                   LET ls_err_code = "adz-00737" #簽出成功但產生新版設計資料過程失敗,請查明原因後再重新簽出.
                END IF
                #End:2015/12/25 by Hiko

                INITIALIZE g_errparam TO NULL
                LET g_errparam.code  = ls_err_code
                LET g_errparam.extend = ls_err_msg #2015/12/25 by Hiko:ls_message改成ls_err_msg
                LET g_errparam.popup = TRUE
                CALL cl_err()

                CALL sadzp063_1_del_design_data(lo_prev_dzaf_t.*, ls_action) RETURNING lb_result,ls_err_msg2 #2015/12/25 by Hiko:改在_movefault處理

                #{
                #不是topstd且不是標準轉客製才做版次還原,標準轉客製就由使用者透過adzp063來做還原標準的動作. #2015/12/25 by Hiko:改成系統直接就還原標準,以免使用者忘了做這個動作然後又下載,造成更混亂的問題.
                IF (lo_curr_DZAF_T.dzaf010=lo_prev_dzaf_t.dzaf010) THEN
                   #搬移失敗時恢復前版次
                   BEGIN WORK
                   LET lb_result = TRUE
                   #topstd只能刪除簽出資料,不能刪除版次資料.
                   IF (ms_user_name<>cs_topstd_user_name) THEN
                      CALL sadzp200_ver_delete_data(lo_DZLM_T.*,ls_DGENV) RETURNING lb_result
                      IF NOT lb_result THEN GOTO _delete_fault END IF 
                   END IF

                   CALL sadzp200_alm_delete_dzlm_data(lo_DZLM_T.*) RETURNING lb_result
                   IF NOT lb_result THEN GOTO _delete_fault END IF
                      
                   LABEL _delete_fault:
                   
                   IF lb_result THEN 
                     COMMIT WORK
                   ELSE
                     ROLLBACK WORK
                     #執行搬移時失敗恢復版次時失敗
                     LET ls_err_code = "adz-00320"
                     #Begin:2015/12/22 by Hiko
                     #LET ls_err_msg  = ls_prog_name,"|"
                     #CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code  = ls_err_code
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #End:2015/12/22 by Hiko
                   END IF   
                END IF
                #}
                #End:2015/12/04 by Hiko
                
                EXIT FOR #2015/12/22 by Hiko
              ELSE #搬移成功
                LET ls_dzlm002 = lo_DZLM_T.DZLM002

                #當為客製環境,
                IF mb_customize AND (lo_DZLM_T.DZLM005 = '1') AND sadzp200_ver_check_if_base_is_standard(ls_prog_name) THEN 
                   
                  #成功時刪除DZLM的資料以便再簽出第二版
                  CALL sadzp200_alm_get_dzlm(lo_program_info.*,cs_user_role_all) RETURNING lo_DZLM_T.*
                  CALL sadzp200_alm_delete_dzlm_data(lo_DZLM_T.*) RETURNING lb_result

                  #收集要重作第二次簽出的程式名稱
                  LET lo_prog_list_arr[lo_prog_list_arr.getLength()+1] = lo_program_info.pi_NAME
                  
                  LET lb_run_two_trip = TRUE
                  LET lb_revision     = TRUE
                  
                END IF 
              END IF
            END IF #結束:沒有簽出失敗
            #=============================== After Download end ===========================================
          END IF #結束:有打勾的程式才做簽出.
        END FOR
      END IF   
    END FOR
  END IF   

  LABEL _run_two_trip:

  #重新Reload清單後再將收集到的要S轉C的程式勾起來
  IF lb_run_two_trip THEN 
    #CALL adzp050_get_all_list_sql(ms_erpalm,ms_search,"",TRUE,ls_download_type) RETURNING ls_list_sql  #20151130 by elena
    CALL adzp050_get_all_list_sql(ms_erpalm,ls_module_name,"",TRUE,ls_download_type,ms_search) RETURNING ls_list_sql
    CALL adzp050_fill_all_list(ls_list_sql)
    FOR li_rec_cnt = 1 TO m_prog_list.getLength()
      FOR li_prog_list_arr = 1 TO lo_prog_list_arr.getLength()
        IF lo_prog_list_arr[li_prog_list_arr] IS NOT NULL THEN
          IF m_prog_list[li_rec_cnt].prog_name = lo_prog_list_arr[li_prog_list_arr] THEN
            LET m_prog_list[li_rec_cnt].prog_selected = "Y"
          END IF 
        END IF 
      END FOR     
    END FOR      
    CALL lo_prog_list_arr.clear()
    GOTO _begin_gen_alm
  END IF   

  IF NOT lb_result OR NOT lb_complete THEN
    LET lb_return = FALSE
  END IF

  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_get_role_list(p_role,p_prog_list)
DEFINE
  p_role      STRING,
  p_prog_list T_PROG_LIST
DEFINE
  ls_role        STRING,
  lo_prog_list   T_PROG_LIST,
  lo_role_arr    T_STATIC_ROLE_LIST,
  li_role_count  INTEGER
DEFINE
  lo_return T_STATIC_ROLE_LIST

  LET ls_role = p_role
  LET lo_prog_list.* = p_prog_list.*

  LET li_role_count = 1
  
  IF ((lo_prog_list.sd_ver IS NOT NULL) OR (ls_role = cs_user_role_sd)) THEN
    LET lo_role_arr[li_role_count] = cs_user_role_sd
    LET li_role_count = li_role_count + 1 
  END IF 
  
  IF ((lo_prog_list.pg_ver IS NOT NULL) OR (ls_role = cs_user_role_pr))THEN 
    LET lo_role_arr[li_role_count] = cs_user_role_pr 
    LET li_role_count = li_role_count + 1 
  END IF 

  CALL lo_role_arr.deleteElement(li_role_count)
  
  LET lo_return = lo_role_arr

  RETURN lo_return
  
END FUNCTION 

#ALM取消簽出
FUNCTION adzp050_alm_recall(p_download_type)
DEFINE
  p_download_type STRING 
DEFINE 
  ls_module_name   STRING,
  ls_download_type STRING, 
  lo_prog_list     DYNAMIC ARRAY OF T_ALM_LIST,
  li_rec_cnt       INTEGER,
  ls_prog_name     STRING,
  ls_spec_type     STRING,
  ls_err_code      STRING,
  ls_err_msg       STRING,
  ls_DGENV         STRING,
  lb_result        BOOLEAN,
  lb_commit        BOOLEAN,
  ls_update_type   STRING,
  ls_GUID          STRING,
  li_dzan_count    INTEGER,
  ls_parameter     STRING,
  ls_retmsg        STRING, 
  lo_role_arr      T_STATIC_ROLE_LIST,
  lo_DZAN_T        DYNAMIC ARRAY OF T_DZAN_T,
  ls_action        STRING,
  #lo_curr_DZAF_T   T_DZAF_T,
  lo_dzaf_t_prev   T_DZAF_T,
  lo_dzaf_t_curr   T_DZAF_T,
  li_role_count    INTEGER,
  ls_command       STRING, 
  ls_result        STRING,
  lo_program_info  T_PROGRAM_INFO,
  lo_USER_INFO     T_USER_INFO,
  lo_DZAF_T        T_DZAF_T,
  lo_DZLM_T        T_DZLM_T  
DEFINE
  lb_return  BOOLEAN,  
  ls_err_msg2 STRING #2015/12/22 by Hiko
  
  LET lo_prog_list.*   = m_demand_list.*
  LET ls_download_type = p_download_type

  LET lb_return  = TRUE

  LET lo_USER_INFO.ui_NUMBER = ms_user
  LET lo_USER_INFO.ui_NAME   = cl_get_accountname(ms_user)
  LET lo_USER_INFO.ui_LANG   = ms_lang
  LET lo_USER_INFO.ui_ROLE   = sadzp50_get_download_match_type(ls_download_type)
  LET ls_action = IIF(lo_USER_INFO.ui_ROLE=="SD","1","2")

  LET ls_DGENV = ms_DGENV
  
  FOR li_rec_cnt = 1 TO lo_prog_list.getLength()
    LET lb_result = TRUE
    
    IF lo_prog_list[li_rec_cnt].prog_selected = "Y" THEN

      #依照SD/PR是否有版次決定要取消簽出的版次資訊
      LET ls_prog_name   = lo_prog_list[li_rec_cnt].prog_name
      LET lo_role_arr[1] = lo_USER_INFO.ui_ROLE
      IF NVL(lo_prog_list[li_rec_cnt].identity,cs_null_default) = cs_dgenv_customize AND mb_customize AND  
         lo_prog_list[li_rec_cnt].version = '1' AND sadzp200_ver_check_if_base_is_standard(ls_prog_name) THEN 
        CALL adzp050_get_alm_role_list(lo_USER_INFO.ui_ROLE,lo_prog_list[li_rec_cnt].*) RETURNING lo_role_arr
      END IF
            
      FOR li_role_count = 1 TO lo_role_arr.getLength() 
        -------------------------------------------------------------
        LET lo_USER_INFO.ui_ROLE = lo_role_arr[li_role_count]
        -------------------------------------------------------------
        #已執行ALM取消簽出, 所以將執行過的程式取消打勾    
        LET lo_prog_list[li_rec_cnt].prog_selected = "N"

        LET ls_prog_name   = lo_prog_list[li_rec_cnt].prog_name
        LET ls_module_name = lo_prog_list[li_rec_cnt].module_name
        LET ls_spec_type   = lo_prog_list[li_rec_cnt].spec_type
        
        #取得實際版次資訊
        CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*

        LET lo_prog_list[li_rec_cnt].version = lo_DZAF_T.DZAF002
        LET lo_prog_list[li_rec_cnt].sd_ver  = lo_DZAF_T.DZAF003
        LET lo_prog_list[li_rec_cnt].pg_ver  = lo_DZAF_T.DZAF004
        
        CALL adzp050_set_dzlm_data_from_screen_array(lo_prog_list[li_rec_cnt].*,lo_USER_INFO.*) RETURNING lo_DZLM_T.* 
        CALL sadzp200_alm_flush_dzlm_array(lo_DZLM_T.*) RETURNING lo_DZLM_T.*

        #當版次為 1 時不能取消簽出
        IF lo_prog_list[li_rec_cnt].version = "1" THEN  
          LET lb_result = FALSE
          LET ls_err_code = "adz-00310"
          LET ls_err_msg  = ls_prog_name,"|"
          #CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          CALL sadzp000_msg_question_box(ls_err_code,ls_err_code,ls_err_msg,0) RETURNING ls_result
          IF ls_result = cs_response_yes THEN 
            IF sadzp200_ver_check_if_base_is_standard(ls_prog_name) THEN
              IF (ms_DGENV = cs_dgenv_customize) THEN 
                LET ls_command = "r.r adzp063 4 ",ls_prog_name
              ELSE
                LET ls_command = "r.r adzp063 3 ",ls_prog_name
              END IF 
            ELSE
              LET ls_command = "r.r adzp063 3 ",ls_prog_name
            END IF 
            CALL cl_cmdrun_openpipe("r.r",ls_command,FALSE) RETURNING lb_return,ls_retmsg
          END IF
          EXIT FOR   
        END IF   
        IF NOT lb_result THEN LET lb_commit = FALSE GOTO _finished END IF

        #確認是否要取消簽出
        LET ls_parameter = lo_prog_list[li_rec_cnt].prog_name,"|",lo_prog_list[li_rec_cnt].version,"|"
        IF NOT cl_ask_confirm_parm("adz-00356",ls_parameter) THEN
          CONTINUE FOR
        END IF 
        
        -------------------------------------------------------------------------
        --------------------------- begin ALM 相關資訊 ----------------------------
        #取得現今DZAF的資料
        LET lo_dzaf_t_curr.DZAF001 = ls_prog_name
        LET lo_dzaf_t_curr.DZAF005 = ls_spec_type
        LET lo_dzaf_t_curr.DZAF010 = ls_DGENV
        CALL sadzp200_ver_get_curr_ver_info(lo_dzaf_t_curr.*) RETURNING lo_dzaf_t_curr.*
        
        LET lo_program_info.pi_NAME   = ls_prog_name
        LET lo_program_info.pi_MODULE = ls_module_name
        LET lo_program_info.pi_DESC   = lo_prog_list[li_rec_cnt].prog_desc
        LET lo_program_info.pi_TYPE   = ls_spec_type

        BEGIN WORK
        
        LET lb_commit = TRUE
        #先刪除介面檔資料
        --CALL sadzp200_intf_delete_interface_data(lo_USER_INFO.ui_ROLE,lo_DZLM_T.*) RETURNING lb_result
        --IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF
        #依據要取消的ROLE將相關資料清空並重新回傳
        CALL sadzp200_alm_preset_dzlm(lo_DZLM_T.*,lo_USER_INFO.ui_ROLE) RETURNING lo_DZLM_T.*
        #依據角色清空對應的版次欄位
        CALL sadzp200_alm_set_dzlm(lo_DZLM_T.*,lo_USER_INFO.ui_ROLE) RETURNING lb_result,ls_update_type
        IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF

        #檢核DZLM資料是否還有效(還存在SD或PR的資訊)
        #針對 topstd 做處理
        IF (ms_user_name = cs_topstd_user_name) AND (ms_DGENV = cs_dgenv_standard) THEN
          IF NOT sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_out) AND NOT sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_in) THEN
            #當DZLM中的SD或PR項的板次都不存在時, 表示該簽出均已取消, DZLM的資訊可刪除
            CALL sadzp200_alm_delete_dzlm_data(lo_DZLM_T.*) RETURNING lb_result
            IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF 
          ELSE
            #檢核DZLM資料是否還有簽出的
            CALL sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_out) RETURNING lb_result
            IF NOT lb_result THEN
              #當DZLM中的SD或PR項均無簽出者,則 DZLM 資訊更新遷入日期結案
              --CALL sadzp200_alm_delete_dzlm_data(lo_DZLM_T.*) RETURNING lb_result
              CALL sadzp200_alm_update_check_in_date(lo_DZLM_T.*) RETURNING lb_result
              IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF 
            END IF
          END IF
        ELSE
          IF NOT sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_out) AND NOT sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_in) THEN
            #當DZLM中的SD或PR項的板次都不存在時, 表示該簽出均已取消, DZLM及DZAF的資訊均可刪除
            CALL sadzp200_alm_delete_dzlm_data(lo_DZLM_T.*) RETURNING lb_result
            IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF 
            CALL sadzp200_ver_delete_data(lo_DZLM_T.*,ls_DGENV) RETURNING lb_result
            IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF 
          ELSE
            #更新版次資訊(DZAF_T)
            LET lo_DZAF_T.DZAF001 = lo_program_info.pi_NAME
            LET lo_DZAF_T.DZAF002 = lo_DZLM_T.DZLM005
            LET lo_DZAF_T.DZAF005 = lo_program_info.pi_TYPE
            LET lo_DZAF_T.DZAF006 = lo_program_info.pi_MODULE
            #先取得現行的DZAF版次相關資料
            CALL sadzp200_ver_get_curr_ver_info(lo_DZAF_T.*) RETURNING lo_DZAF_T.*
            #遞減對應的版次號碼
            CALL sadzp200_ver_decreas_dzaf_ver(lo_DZAF_T.*,lo_USER_INFO.ui_ROLE) RETURNING lo_DZAF_T.*
            #更新資料庫
            CALL sadzp200_ver_set_ver(lo_DZAF_T.*,lo_USER_INFO.ui_ROLE) RETURNING lb_result
            IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF 
            #檢核DZLM資料是否還有簽出的
            CALL sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_out) RETURNING lb_result
            IF NOT lb_result THEN
              #當DZLM中的SD或PR項均無簽出者,則 DZLM 資訊更新遷入日期結案
              --CALL sadzp200_alm_delete_dzlm_data(lo_DZLM_T.*) RETURNING lb_result
              CALL sadzp200_alm_update_check_in_date(lo_DZLM_T.*) RETURNING lb_result
              IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF 
            END IF
          END IF
        END IF   
        
        LABEL _CheckWork:
        
        IF lb_commit THEN 
          COMMIT WORK
        ELSE
          ROLLBACK WORK
          GOTO _check_result
        END IF
        
        ---------------------------- end ALM 相關資訊 ----------------------------
        -------------------------------------------------------------------------
        
        -------------------------------------------------------------------------
        ---------------------------- begin After recall -------------------------
        
        #取得上一版次DZAF的資料
        LET lo_dzaf_t_prev.DZAF001 = ls_prog_name
        LET lo_dzaf_t_prev.DZAF005 = ls_spec_type
        LET lo_dzaf_t_prev.DZAF010 = ls_DGENV
        CALL sadzp200_ver_get_prev_ver_info_by_dgenv(lo_dzaf_t_prev.*,lo_role_arr[li_role_count]) RETURNING lo_dzaf_t_prev.*
        IF lo_dzaf_t_prev.DZAF002 IS NULL THEN INITIALIZE lo_dzaf_t_prev TO NULL END IF 
        
        #檢核版次是否為 1 , 若是, 則不能取消簽出          
        IF NOT lo_prog_list[li_rec_cnt].version = "1" THEN  
          #不為 topstd 的時候才能取消簽出
          IF NOT ((ms_user_name = cs_topstd_user_name) AND (ms_DGENV = cs_dgenv_standard)) THEN
            CALL sadzp060_2_after_recall(ls_prog_name, lo_role_arr[li_role_count], lo_dzaf_t_curr.*, lo_dzaf_t_prev.*) RETURNING ls_err_msg
            LET lb_result = IIF(ls_err_msg IS NULL,TRUE,FALSE)
          END IF   
        END IF   
        IF NOT lb_result THEN LET lb_commit = FALSE GOTO _check_result END IF
        
        {
        IF (lo_dzaf_t_prev.DZAF001 IS NOT NULL AND lo_dzaf_t_curr.DZAF001 IS NOT NULL) OR
           (lo_dzaf_t_prev.DZAF001 IS NULL AND lo_dzaf_t_curr.DZAF001 IS NULL) THEN 
          IF lo_dzaf_t_prev.DZAF002 IS NULL THEN  
            LET lb_result = FALSE
            LET ls_err_code = "adz-00310"
            LET ls_err_msg  = ls_prog_name,"|"
            CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          ELSE
            CALL sadzp060_2_after_recall(ls_prog_name, lo_role_arr[li_role_count], lo_dzaf_t_curr.*, lo_dzaf_t_prev.*) RETURNING ls_err_msg
            LET lb_result = IIF(ls_err_msg IS NULL,TRUE,FALSE)
          END IF   
          IF NOT lb_result THEN LET lb_commit = FALSE GOTO _check_result END IF
        END IF
        } 
        
        ----------------------------- end After recall -------------------------
        -------------------------------------------------------------------------

        LABEL _check_result:
        
        IF NOT lb_commit THEN
          LET ls_err_code = "adz-00297"
          LET ls_err_msg  = ls_prog_name,"|",ls_err_msg,"|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          CALL sadzp063_1_del_design_data(lo_dzaf_t_prev.*, ls_action) RETURNING lb_result,ls_err_msg2
          #Begin:2015/12/17 by Hiko
          #IF NOT lb_result THEN 
          #  LET ls_err_code = "adz-00164"
          #  LET ls_err_msg  = "|"
          #  CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          #END IF 
          #End:2015/12/17 by Hiko
        ELSE  
          LET ls_err_code = "adz-00432"
          LET ls_err_msg  = ls_prog_name,"|"
          CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, 1)
        END IF

        LABEL _finished:
        
      END FOR
    END IF
  END FOR

END FUNCTION

#ALM簽入
FUNCTION adzp050_alm_check_in(p_download_type,p_release)
DEFINE
  p_download_type STRING,
  p_release       BOOLEAN #160504-00002
DEFINE 
  ls_download_type STRING, 
  lb_release       BOOLEAN, #160504-00002 
  lo_prog_list     DYNAMIC ARRAY OF T_ALM_LIST,
  li_rec_cnt       INTEGER,
  ls_prog_name     STRING,
  ls_parameter     STRING,
  ls_err_code      STRING,
  ls_err_msg       STRING,
  ls_DGENV         STRING,
  lb_result        BOOLEAN,
  lb_commit        BOOLEAN,
  lo_USER_INFO     T_USER_INFO,
  lo_DZAF_T        T_DZAF_T,  
  lo_DZLM_T        T_DZLM_T  
DEFINE
  lb_return  BOOLEAN  
  
  LET lo_prog_list.*   = m_demand_list.*
  LET ls_download_type = p_download_type
  LET lb_release       = p_release #160504-00002

  LET lb_return  = TRUE
  LET lb_commit  = TRUE

  LET lo_USER_INFO.ui_NUMBER = ms_user
  LET lo_USER_INFO.ui_NAME   = cl_get_accountname(ms_user)
  LET lo_USER_INFO.ui_LANG   = ms_lang
  LET lo_USER_INFO.ui_ROLE   = sadzp50_get_download_match_type(ls_download_type)

  LET ls_DGENV = ms_DGENV
  
  FOR li_rec_cnt = 1 TO lo_prog_list.getLength()
    LET lb_result = TRUE
    
    IF lo_prog_list[li_rec_cnt].prog_selected = "Y" AND lo_prog_list[li_rec_cnt].prog_name IS NOT NULL THEN

      #已執行過簽入, 所以將執行過的程式取消打勾    
      LET lo_prog_list[li_rec_cnt].prog_selected = "N"
      LET ls_prog_name = lo_prog_list[li_rec_cnt].prog_name

      #確認是否要簽入
      IF NOT lb_release THEN #160504-00002
        LET ls_parameter = ls_prog_name,"|"
        IF NOT cl_ask_confirm_parm("adz-00359",ls_parameter) THEN
          CONTINUE FOR
        END IF
      END IF #160504-00002

      #161027-00001 begin
      CALL adzp050_check_if_could_check_in(ls_download_type,lo_prog_list[li_rec_cnt].module_name,lo_prog_list[li_rec_cnt].prog_name) RETURNING lb_result
      IF NOT lb_result THEN
        LET ls_err_code = "adz-00923"
        LET ls_err_msg  = "|"
        CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
        CONTINUE FOR
      END IF
      #161027-00001 end
        
      #取得實際版次資訊
      CALL adzp050_get_current_version(lo_prog_list[li_rec_cnt].prog_name,lo_prog_list[li_rec_cnt].spec_type,lo_prog_list[li_rec_cnt].identity) RETURNING lo_DZAF_T.*

      LET lo_prog_list[li_rec_cnt].version = lo_DZAF_T.DZAF002
      LET lo_prog_list[li_rec_cnt].sd_ver  = lo_DZAF_T.DZAF003
      LET lo_prog_list[li_rec_cnt].pg_ver  = lo_DZAF_T.DZAF004

      #確認簽入的程式在dzba_t中是否有存在
      IF lo_USER_INFO.ui_ROLE = cs_ver_type_pr THEN 
        CALL adzp050_check_dzba_if_exist(ls_prog_name,lo_prog_list[li_rec_cnt].pg_ver,lo_prog_list[li_rec_cnt].identity) RETURNING lb_result        
        IF NOT lb_result THEN 
          LET ls_err_code = "adz-00563"
          LET ls_err_msg  = "|"
          CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
          CONTINUE FOR
        END IF 
      END IF 
      
      CALL adzp050_set_dzlm_data_from_screen_array(lo_prog_list[li_rec_cnt].*,lo_USER_INFO.*) RETURNING lo_DZLM_T.* 
      CALL sadzp200_alm_flush_dzlm_array(lo_DZLM_T.*) RETURNING lo_DZLM_T.*

      -------------------------------------------------------------------
      -------------------------- ALM 相關資訊 ----------------------------
      
      BEGIN WORK

      IF lb_release THEN 
        #160504-00002 begin 
        CALL sadzp200_alm_update_check_in_code(lo_DZLM_T.*,cs_user_role_sd) RETURNING lb_result
        IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF
        CALL sadzp200_alm_update_check_in_code(lo_DZLM_T.*,cs_user_role_pr) RETURNING lb_result
        IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF
        #160504-00002 end 
      ELSE
        CALL sadzp200_alm_update_check_in_code(lo_DZLM_T.*,lo_USER_INFO.ui_ROLE) RETURNING lb_result
        IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF
      END IF  

      #檢核DZLM資料是否還有簽出的
      CALL sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_out) RETURNING lb_result
      IF NOT lb_result THEN
        #當DZLM中的SD或PR項均無簽出者,則 DZLM 資訊更新遷入日期結案
        #topstd 的時候刪除 dzlm_t data
        IF ((ms_user_name = cs_topstd_user_name) AND (ms_DGENV = cs_dgenv_standard)) THEN
          CALL sadzp200_alm_delete_dzlm_data(lo_DZLM_T.*) RETURNING lb_result
          IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF 
        ELSE 
          CALL sadzp200_alm_update_check_in_date(lo_DZLM_T.*) RETURNING lb_result
          IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF 
        END IF 
      END IF
      #刪除介面檔資料
      --CALL sadzp200_intf_delete_interface_data(lo_USER_INFO.ui_ROLE,lo_DZLM_T.*) RETURNING lb_result
      --IF NOT lb_result THEN LET lb_commit = FALSE GOTO _CheckWork END IF
      
      -------------------------------------------------------------------
      -------------------------------------------------------------------
      
      LABEL _CheckWork:
      
      IF lb_commit THEN 
        COMMIT WORK
      ELSE
        ROLLBACK WORK
      END IF

      LABEL _check_result:
      
      IF NOT lb_commit THEN
        LET ls_err_code = "adz-00326"
        LET ls_err_msg  = ls_prog_name,"|",ls_err_msg,"|"
        CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
      END IF
      
    END IF
  END FOR

  {
  #簽入程序結束
  LET ls_err_code = "adz-00337"
  LET ls_err_msg  = "|"
  CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
  }
END FUNCTION

#161027-00001 begin
FUNCTION adzp050_merge_sync_check_in(p_demand_list)
DEFINE
  p_demand_list T_ALM_LIST
DEFINE 
  lo_demand_list   T_ALM_LIST,
  ls_download_type STRING,
  li_rec_cnt       INTEGER,
  ls_prog_name     STRING,
  ls_parameter     STRING,
  ls_err_code      STRING,
  ls_err_msg       STRING,
  lb_result        BOOLEAN,
  lb_commit        BOOLEAN,
  lo_USER_INFO     T_USER_INFO,
  lo_DZAF_T        T_DZAF_T,  
  lo_DZLM_T        T_DZLM_T  
DEFINE
  lb_return  BOOLEAN  
  
  LET lo_demand_list.* = p_demand_list.*

  LET lb_return  = TRUE
  LET lb_commit  = TRUE

  LET lo_USER_INFO.ui_NUMBER = ms_user
  LET lo_USER_INFO.ui_NAME   = cl_get_accountname(ms_user)
  LET lo_USER_INFO.ui_LANG   = ms_lang
  LET lo_USER_INFO.ui_ROLE   = sadzp50_get_download_match_type(ls_download_type)

  #取得實際版次資訊
  CALL adzp050_get_current_version(lo_demand_list.prog_name,lo_demand_list.spec_type,lo_demand_list.identity) RETURNING lo_DZAF_T.*
  LET lo_demand_list.version = lo_DZAF_T.DZAF002
  LET lo_demand_list.sd_ver  = lo_DZAF_T.DZAF003
  LET lo_demand_list.pg_ver  = lo_DZAF_T.DZAF004

  CALL adzp050_set_dzlm_data_from_screen_array(lo_demand_list.*,lo_USER_INFO.*) RETURNING lo_DZLM_T.* 
  CALL sadzp200_alm_flush_dzlm_array(lo_DZLM_T.*) RETURNING lo_DZLM_T.*

  -------------------------------------------------------------------
  -------------------------- ALM 相關資訊 ----------------------------
  
  BEGIN WORK

  #160504-00002 begin 
  CALL sadzp200_alm_update_check_in_code(lo_DZLM_T.*,cs_user_role_sd) RETURNING lb_result
  IF NOT lb_result THEN LET lb_commit = FALSE GOTO _check_result END IF
  CALL sadzp200_alm_update_check_in_code(lo_DZLM_T.*,cs_user_role_pr) RETURNING lb_result
  IF NOT lb_result THEN LET lb_commit = FALSE GOTO _check_result END IF
  #160504-00002 end 

  #檢核DZLM資料是否還有簽出的
  CALL sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_out) RETURNING lb_result
  IF NOT lb_result THEN
    #當DZLM中的SD或PR項均無簽出者,則 DZLM 資訊更新遷入日期結案
    #topstd 的時候刪除 dzlm_t data
    IF ((ms_user_name = cs_topstd_user_name) AND (ms_DGENV = cs_dgenv_standard)) THEN
      CALL sadzp200_alm_delete_dzlm_data(lo_DZLM_T.*) RETURNING lb_result
      IF NOT lb_result THEN LET lb_commit = FALSE GOTO _check_result END IF 
    ELSE 
      CALL sadzp200_alm_update_check_in_date(lo_DZLM_T.*) RETURNING lb_result
      IF NOT lb_result THEN LET lb_commit = FALSE GOTO _check_result END IF 
    END IF 
  END IF
  
  -------------------------------------------------------------------
  -------------------------------------------------------------------
  
  LABEL _check_result:
  
  IF lb_commit THEN 
    COMMIT WORK
  ELSE
    ROLLBACK WORK
  END IF

  IF NOT lb_commit THEN
    LET ls_err_code = "adz-00326"
    LET ls_err_msg  = ls_prog_name,"|",ls_err_msg,"|"
    CALL sadzp000_msg_show_error(ls_err_code, ls_err_code, ls_err_msg, 1)
  END IF

  LET lb_return = lb_commit

  RETURN lb_return

END FUNCTION
#161027-00001 end

FUNCTION adzp050_get_current_version(p_program,p_spec_type,p_dgenv)
DEFINE
  p_program   STRING,
  p_spec_type STRING,
  p_dgenv     STRING
DEFINE 
  ls_program     STRING,
  ls_spec_type   STRING,
  ls_dgenv       STRING,
  lo_curr_DZAF_T T_DZAF_T
DEFINE
  lo_return T_DZAF_T

  LET ls_program   = p_program
  LET ls_spec_type = p_spec_type
  LET ls_dgenv     = p_dgenv

  #取得現今DZAF的資料
  LET lo_curr_DZAF_T.DZAF001 = ls_program
  LET lo_curr_DZAF_T.DZAF005 = ls_spec_type
  LET lo_curr_DZAF_T.DZAF010 = ls_dgenv
  
  CALL sadzp200_ver_get_curr_ver_info(lo_curr_DZAF_T.*) RETURNING lo_curr_DZAF_T.*

  LET lo_return.* = lo_curr_DZAF_T.*

  RETURN lo_return.*  
  
END FUNCTION 

FUNCTION adzp050_get_alm_role_list(p_role,p_prog_list)
DEFINE
  p_role      STRING,
  p_prog_list T_ALM_LIST
DEFINE
  ls_role        STRING,
  lo_prog_list   T_ALM_LIST,
  lo_role_arr    T_STATIC_ROLE_LIST,
  li_role_count  INTEGER
DEFINE
  lo_return T_STATIC_ROLE_LIST

  LET ls_role = p_role
  LET lo_prog_list.* = p_prog_list.*

  LET li_role_count = 1

  IF ((lo_prog_list.sd_ver IS NOT NULL) OR (ls_role = cs_user_role_sd))  THEN
    LET lo_role_arr[li_role_count] = cs_user_role_sd
    LET li_role_count = li_role_count + 1 
  END IF 
  
  IF ((lo_prog_list.pg_ver IS NOT NULL) OR (ls_role = cs_user_role_pr)) THEN 
    LET lo_role_arr[li_role_count] = cs_user_role_pr 
    LET li_role_count = li_role_count + 1 
  END IF 

  LET lo_return = lo_role_arr

  RETURN lo_return
  
END FUNCTION 

FUNCTION adzp050_set_dzlm_data_from_screen_array(p_alm_list,p_USER_INFO)
DEFINE 
  p_alm_list  T_ALM_LIST,
  p_USER_INFO T_USER_INFO
DEFINE 
  lo_alm_list   T_ALM_LIST,
  lo_USER_INFO  T_USER_INFO,
  lo_DZLM_T     T_DZLM_T  
DEFINE 
  lo_return T_DZLM_T  

  LET lo_alm_list.*  = p_alm_list.*
  LET lo_USER_INFO.* = p_USER_INFO.*

  LET lo_DZLM_T.DZLM001 = lo_alm_list.spec_type
  LET lo_DZLM_T.DZLM002 = lo_alm_list.prog_name
  LET lo_DZLM_T.DZLM003 = lo_alm_list.prog_desc
  LET lo_DZLM_T.DZLM004 = lo_alm_list.module_name
  LET lo_DZLM_T.DZLM005 = lo_alm_list.version
  LET lo_DZLM_T.DZLM006 = lo_alm_list.sd_ver
  LET lo_DZLM_T.DZLM007 = lo_USER_INFO.ui_NUMBER
  LET lo_DZLM_T.DZLM008 = cs_check_out
  LET lo_DZLM_T.DZLM009 = lo_alm_list.pg_ver
  LET lo_DZLM_T.DZLM010 = lo_USER_INFO.ui_NUMBER
  LET lo_DZLM_T.DZLM011 = cs_check_out
  LET lo_DZLM_T.DZLM012 = lo_alm_list.DZLM012
  LET lo_DZLM_T.DZLM013 = lo_alm_list.DZLM013
  LET lo_DZLM_T.DZLM014 = lo_alm_list.DZLM014
  LET lo_DZLM_T.DZLM015 = lo_alm_list.DZLM015
  LET lo_DZLM_T.DZLM018 = lo_alm_list.DZLM018
  LET lo_DZLM_T.DZLM019 = lo_alm_list.DZLM019
  LET lo_DZLM_T.DZLM020 = lo_alm_list.DZLM020
  LET lo_DZLM_T.DZLM021 = lo_alm_list.DZLM021

  LET lo_return.* = lo_DZLM_T.*

  RETURN lo_return.*  
  
END FUNCTION 

FUNCTION adzp050_find_and_fill_combobox(p_component_name,p_sql)
DEFINE
  p_component_name STRING,
  p_sql           STRING
DEFINE 
  lo_combobox ui.ComboBox
  
  LET lo_combobox = ui.ComboBox.forName(p_component_name)
  CALL adzp050_fill_combobox(lo_combobox,p_sql)
  
END FUNCTION

FUNCTION adzp050_fill_combobox(p_combobox,p_sql)
DEFINE 
  p_combobox ui.ComboBox,
  p_sql      STRING
DEFINE
  ls_sql    STRING,
  li_count  INTEGER, 
  lo_module RECORD 
              combobox_name VARCHAR(50),
              combobox_desc VARCHAR(255)
            END RECORD  

  LET ls_sql = p_sql
 
  PREPARE lpre_combobox FROM ls_sql
  DECLARE lcur_combobox SCROLL CURSOR FOR lpre_combobox

  CALL p_combobox.clear()
  
  LET li_count = 0

  OPEN lcur_combobox
  FOREACH lcur_combobox INTO lo_module.*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    CALL p_combobox.addItem(lo_module.combobox_name,lo_module.combobox_desc)
    LET li_count = li_count + 1
  END FOREACH
  CLOSE lcur_combobox

  FREE lcur_combobox
  FREE lpre_combobox

END FUNCTION

FUNCTION adzp050_download_program_pack(p_file_name,p_module_name,p_identity,p_module_path,p_source_path,p_destination_path,p_download_type,p_erpalm,p_readonly)
DEFINE
  p_file_name        STRING,
  p_module_name      STRING,
  p_identity         STRING, 
  p_module_path      STRING,
  p_source_path      STRING,
  p_destination_path STRING,
  p_download_type    STRING,
  p_erpalm            STRING,
  p_readonly          BOOLEAN   
DEFINE
  ls_file_name        STRING,
  ls_module_name      STRING,
  ls_identity         STRING, 
  ls_module_path      STRING,
  ls_source_path      STRING,
  ls_destination_path STRING,
  ls_source_file      STRING,
  ls_destination_file STRING,
  ls_download_type    STRING,
  ls_erpalm           STRING,
  lb_readonly         BOOLEAN,  
  lb_result           BOOLEAN 
DEFINE
  lb_return BOOLEAN 

  LET ls_file_name        = p_file_name        
  LET ls_module_name      = p_module_name        
  LET ls_identity         = p_identity
  LET ls_module_path      = p_module_path        
  LET ls_source_path      = p_source_path        
  LET ls_destination_path = p_destination_path        
  LET ls_download_type    = p_download_type
  LET ls_erpalm           = p_erpalm
  LET lb_readonly         = p_readonly
  
  LET ls_source_file      = ls_source_path,ls_file_name
  LET ls_destination_file = ls_destination_path,ls_file_name

  LET ms_running_process = "adzp050_download_program_pack"
  
  #DISPLAY "Compressing files to TZP ..."
  CALL sadzp050_zip_compress_to_program_zip(ls_file_name,ls_module_name,ls_identity,ls_module_path,ms_lang,ls_download_type,ls_erpalm,lb_readonly,TRUE) RETURNING lb_result,ls_source_path,ls_file_name
  IF NOT lb_result THEN GOTO _return END IF 

  #DISPLAY "Downloading TZP file ..."
  CALL sadzp050_zip_download_program_zip(ls_file_name,ls_module_name,ls_source_path,ls_destination_path,ls_download_type,ms_modulefolder) RETURNING lb_result #20151231 by elena 增加ms_modulefolder參數
  IF NOT lb_result THEN GOTO _return END IF 

  LABEL _return:

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_download_code_pack(p_file_name,p_module_name,p_identity,p_module_path,p_source_path,p_destination_path,p_download_type,p_erpalm,p_readonly)
DEFINE
  p_file_name        STRING,
  p_module_name      STRING,
  p_identity         STRING,
  p_module_path      STRING,
  p_source_path      STRING,
  p_destination_path STRING,
  p_download_type    STRING,
  p_erpalm            STRING,
  p_readonly          BOOLEAN    
DEFINE
  ls_file_name        STRING,
  ls_module_name      STRING,
  ls_identity         STRING,
  ls_module_path      STRING,
  ls_source_path      STRING,
  ls_destination_path STRING,
  ls_download_type    STRING,  
  ls_erpalm           STRING,
  lb_readonly         BOOLEAN,  
  ls_source_file      STRING,
  ls_destination_file STRING,
  lb_result           BOOLEAN,
  ls_message          STRING
DEFINE
  lb_return BOOLEAN 

  LET ls_file_name        = p_file_name        
  LET ls_module_name      = p_module_name        
  LET ls_identity         = p_identity
  LET ls_module_path      = p_module_path        
  LET ls_source_path      = p_source_path        
  LET ls_destination_path = p_destination_path        
  LET ls_download_type    = p_download_type
  LET ls_erpalm           = p_erpalm
  LET lb_readonly         = p_readonly

  LET ls_source_file      = ls_source_path,ls_file_name
  LET ls_destination_file = ls_destination_path,ls_file_name

  LET ms_running_process = "adzp050_download_code_pack"
  
  CALL adzp050_show_message_designer()

  #DISPLAY "Compressing files to TZP ..."
  LET ls_message = "Compressing files ..."
  CALL adzp050_show_process_message(ls_message)
  CALL sadzp050_zip_compress_to_code_zip(ls_file_name,ls_module_name,ls_identity,ls_module_path,ms_lang,ls_download_type,ls_erpalm,lb_readonly,TRUE) RETURNING lb_result,ls_source_path,ls_file_name
  IF NOT lb_result THEN GOTO _return END IF

  #DISPLAY "Downloading TZP file ..."
  LET ls_message = "Downloading compressed file."
  CALL adzp050_show_process_message(ls_message)
  CALL sadzp050_zip_download_code_zip(ls_file_name,ls_module_name,ls_source_path,ls_destination_path,ls_download_type,ms_modulefolder) RETURNING lb_result #20151231 by elena 增加ms_modulefolder參數
  IF NOT lb_result THEN GOTO _return END IF 

  LABEL _return:

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_download_4rp_pack(p_DIALOG,p_run_type,p_arr_curr,p_file_name,p_module_name,p_type,p_version,p_identity,p_module_path,p_source_path,p_destination_path,p_download_type,p_template_list)
DEFINE
  p_DIALOG           ui.DIALOG,
  p_run_type         STRING,
  p_arr_curr         INTEGER,
  p_file_name        STRING,
  p_module_name      STRING,
  p_type             STRING,
  p_version          STRING, 
  p_identity         STRING,
  p_module_path      STRING,
  p_source_path      STRING,
  p_destination_path STRING,
  p_download_type    STRING,  
  p_template_list    DYNAMIC ARRAY OF T_TEMPLATE_LIST_R
DEFINE
  ls_run_type         STRING,
  li_arr_curr         INTEGER,
  ls_file_name        STRING,
  ls_module_name      STRING,
  ls_type             STRING,
  ls_version          STRING, 
  ls_identity         STRING,
  ls_module_path      STRING,
  ls_source_path      STRING,
  ls_destination_path STRING,
  ls_download_type    STRING,  
  ls_source_file      STRING,
  ls_destination_file STRING,
  ls_client_temp_path STRING,
  ls_message          STRING,
  lb_result           BOOLEAN,
  lb_run_alm          BOOLEAN  
DEFINE
  lb_return BOOLEAN 

  LET ls_run_type         = p_run_type
  LET li_arr_curr         = p_arr_curr
  LET ls_file_name        = p_file_name
  LET ls_module_name      = p_module_name    
  LET ls_type             = p_type
  LET ls_version          = p_version
  LET ls_identity         = p_identity  
  LET ls_module_path      = p_module_path        
  LET ls_source_path      = p_source_path        
  LET ls_destination_path = p_destination_path        
  LET ls_download_type    = p_download_type

  LET lb_run_alm = IIF(ls_run_type == cs_run_type_alm,TRUE,FALSE)
  
  LET ls_client_temp_path = cs_client_temp_dir,cs_dos_separator

  LET ls_source_file      = ls_source_path,ls_file_name
  LET ls_destination_file = ls_destination_path,ls_file_name

  LET ms_running_process = "adzp050_download_4rp_pack"
  
  CALL adzp050_show_message_designer()

  IF lb_run_alm THEN CALL adzp050_set_alm_progress(25,li_arr_curr,p_DIALOG) ELSE CALL adzp050_set_progress(25,li_arr_curr,p_DIALOG) END IF 
  LET ls_message = "Compress 4rp files to tzt."
  CALL adzp050_show_process_message(ls_message)
  CALL sadzp050_zip_compress_to_4rp_zip(ls_file_name,ls_module_name,ls_type,ls_version,ls_identity,ls_module_path,ms_lang,ms_dgenv,ls_download_type,p_template_list,lb_run_alm) RETURNING lb_result,ls_source_path,ls_file_name
  IF NOT lb_result THEN GOTO _return END IF

  IF lb_run_alm THEN CALL adzp050_set_alm_progress(50,li_arr_curr,p_DIALOG) ELSE CALL adzp050_set_progress(50,li_arr_curr,p_DIALOG) END IF 
  LET ls_message = "Create/Backup client directory."
  CALL adzp050_show_process_message(ls_message)
  CALL adzp050_create_client_directory(ls_file_name,ls_destination_path,ls_module_name) RETURNING lb_result #20160111 by elena 增加 ls_module_name參數
  IF NOT lb_result THEN GOTO _return END IF

  IF lb_run_alm THEN CALL adzp050_set_alm_progress(75,li_arr_curr,p_DIALOG) ELSE CALL adzp050_set_progress(75,li_arr_curr,p_DIALOG) END IF 
  LET ls_message = "Download tzt file."
  CALL adzp050_show_process_message(ls_message)
  CALL sadzp050_zip_download_4rp_zip(ls_file_name,ls_module_name,ls_source_path,ls_client_temp_path,ls_download_type,ms_modulefolder) RETURNING lb_result #20151231 by elena 增加ms_modulefolder參數
  IF NOT lb_result THEN GOTO _return END IF

  IF lb_run_alm THEN CALL adzp050_set_alm_progress(100,li_arr_curr,p_DIALOG) ELSE CALL adzp050_set_progress(100,li_arr_curr,p_DIALOG) END IF 
  LET ls_message = "Extract tzt file to destination."
  CALL adzp050_show_process_message(ls_message)
  CALL adzp050_extract_zip_to_program_directory(ls_file_name,ls_destination_path,ls_module_name) RETURNING lb_result  #20160111 by elena 增加 ls_module_name參數
  IF NOT lb_result THEN GOTO _return END IF
  
  LABEL _return:

  IF NOT lb_result THEN
    CALL sadzp000_msg_show_error(ls_message, "adz-00275", NULL, 1)
  END IF 

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_create_client_directory(p_file_name,p_work_path,p_module_name) #20160111 by elena 增加 p_module_name參數
DEFINE
  p_file_name   STRING, 
  p_work_path   STRING,
  p_module_name STRING   #20160111 by elena
DEFINE
  ls_file_name STRING, 
  ls_work_path STRING,
  ls_command   STRING,
  ls_separator STRING,
  ls_7zip_path  STRING,
  ls_source    STRING,
  ls_destination STRING,
  lb_result    BOOLEAN 

  LET ls_file_name = p_file_name

  #BEGIN:20160111 by elena 是否下載至各模組資料夾
  IF ms_modulefolder = "Y" THEN
    LET ls_work_path = p_work_path,p_module_name.ToLowerCase(),"\\"
  ELSE
    LET ls_work_path = p_work_path
  END IF
  #END:20160111 by elena

  LET ls_separator = os.Path.separator()
  LET ls_7zip_path = FGL_GETENV("UTL"),ls_separator,"3rd",ls_separator,"7zip",ls_separator

  ------------------------------------------------------------------------------
  #測試是否有解壓程式
  LET ls_command = cs_client_temp_dir,cs_dos_separator,"7za.exe"
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  IF lb_result THEN 
    DISPLAY cs_message_tag,"Check compress/uncompress program OK !!" 
  ELSE 
    DISPLAY cs_warning_tag,"Check compress/uncompress program unsuccess !!" 
  
    #建立 Client 暫存目錄
    LET ls_command = "cmd.exe /C \"mkdir ",cs_client_temp_dir,""
    CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
    IF lb_result THEN DISPLAY cs_message_tag,"Create client temp directory OK !" ELSE DISPLAY cs_warning_tag,"Create client temp directory unsuccess : ",ls_command END IF
    IF lb_result THEN CALL sadzp050_zip_grant_clinet_permission(cs_client_temp_dir,TRUE) RETURNING lb_result END IF #170111-00006

    #將暫存目錄設為隱藏
    {
    LET ls_command = "cmd.exe /C \"attrib +h ",cs_client_temp_dir,""
    CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
    IF lb_result THEN DISPLAY cs_message_tag,"Set client temp directory hidden OK !" ELSE DISPLAY cs_warning_tag,"Set client temp directory hidden unsuccess : ",ls_command END IF
    }
    
    DISPLAY cs_message_tag,"Downloading compress/uncompress program ....." 
    #下載7za.exe到 c:\t100temp
    LET ls_source      = ls_7zip_path,"7za.exe"
    LET ls_destination = cs_client_temp_dir,cs_dos_separator,"7za.exe"
    TRY
      LET lb_result = TRUE
      CALL FGL_PUTFILE(ls_source,ls_destination)
      CALL sadzp050_zip_grant_clinet_permission(ls_destination,FALSE) RETURNING lb_result #170111-00006
    CATCH
      LET lb_result = FALSE
    END TRY   
    IF lb_result THEN DISPLAY cs_message_tag,"Download compress/uncompress program OK !" ELSE DISPLAY cs_error_tag,"Download compress/uncompress program unsuccess : ",ls_command GOTO _return END IF
    
  END IF 
  ------------------------------------------------------------------------------

  ------------------------------------------------------------------------------
  
  #移除前一次備份目錄
  LET ls_command = "cmd.exe /C \"rmdir /Q /S ",ls_work_path,ls_file_name,".bak","" 
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  IF lb_result THEN DISPLAY cs_message_tag,"Remove backup report directory ",ls_file_name,".bak"," OK !" ELSE DISPLAY cs_warning_tag,"Remove backup report directory ",ls_file_name,".bak"," unsuccess : ",ls_command END IF

  #將原目錄更名為備份目錄
  LET ls_command = "cmd.exe /C \"rename ",ls_work_path,ls_file_name," ",ls_file_name,".bak","" 
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  IF lb_result THEN DISPLAY cs_message_tag,"Rename report directory ",ls_file_name," to ",ls_file_name,".bak"," OK !" ELSE DISPLAY cs_warning_tag,"Rename report directory ",ls_file_name," to ",ls_file_name,".bak"," unsuccess : ",ls_command END IF

  {  
  #建立備份目錄
  LET ls_command = "cmd.exe /C \"mkdir ",ls_work_path,ls_file_name,".bak","" 
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  IF lb_result THEN DISPLAY cs_message_tag,"Create backup report directory OK !" ELSE DISPLAY cs_warning_tag,"Create backup report directory unsuccess : ",ls_command END IF
  
  #將原目錄內容複製到備份目錄
  LET ls_command = "cmd.exe /C \"copy ",ls_work_path,ls_file_name,cs_dos_separator,cs_dos_separator,"*.* ",ls_work_path,ls_file_name,".bak","" 
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  IF lb_result THEN DISPLAY cs_message_tag,"Copy original files to backup directory OK !" ELSE DISPLAY cs_warning_tag,"Copy original files to backup directory unsuccess : ",ls_command END IF
  
  #移除原目錄
  LET ls_command = "cmd.exe /C \"rmdir /Q /S ",ls_work_path,ls_file_name,""
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  IF lb_result THEN DISPLAY cs_message_tag,"Remove original report directory OK !" ELSE DISPLAY cs_warning_tag,"Remove original report directory unsuccess : ",ls_command END IF
  }

  #建立程式目錄
  LET ls_command = "cmd.exe /C \"mkdir ",ls_work_path,ls_file_name,"" 
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  IF lb_result THEN DISPLAY cs_message_tag,"Create report directory ",ls_file_name," OK !" ELSE DISPLAY cs_error_tag,"Create report directory ",ls_file_name," unsuccess : ",ls_command GOTO _return END IF

  ------------------------------------------------------------------------------

  LABEL _return:

  RETURN lb_result
  
END FUNCTION 

FUNCTION adzp050_extract_zip_to_program_directory(p_file_name,p_work_path,p_module_name) #20160111 by elena 增加 p_module_name參數
DEFINE
  p_file_name     STRING, 
  p_work_path     STRING,
  p_module_name   STRING   #20160111 by elena
DEFINE
  ls_file_name   STRING, 
  ls_work_path   STRING,
  ls_command     STRING,
  lb_result      BOOLEAN,
  ls_full_path   STRING #170111-00006

  LET ls_file_name = p_file_name
   
  #BEGIN:20160111 by elena 是否下載至指定模組
  IF ms_modulefolder="Y" THEN
    LET ls_work_path = p_work_path,p_module_name.ToLowerCase(),"\\"
  ELSE
    LET ls_work_path = p_work_path
  END IF
  #END:20160111 by elena

  #將壓縮檔內容解縮到程式目錄中
  LET ls_full_path = ls_work_path,cs_dos_separator,ls_file_name
  LET ls_command = cs_client_temp_dir,cs_dos_separator,"7za.exe x -aoa ",cs_client_temp_dir,cs_dos_separator,ls_file_name,cs_download_string,".tzt -o",ls_full_path
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  IF lb_result THEN DISPLAY cs_message_tag,"Extract files OK !!" ELSE DISPLAY cs_error_tag,"Extract files unsuccess !!" GOTO _return END IF
  IF lb_result THEN CALL sadzp050_zip_grant_clinet_permission(ls_full_path,TRUE) RETURNING lb_result END IF #170111-00006
  
  #將.vfy檔設為隱藏
  {
  LET ls_command = "cmd.exe /C \"attrib +h ",ls_work_path,cs_dos_separator,ls_file_name,cs_dos_separator,ls_file_name,".vfy",""
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  IF lb_result THEN DISPLAY cs_message_tag,"Set verify file hidden OK !" ELSE DISPLAY cs_warning_tag,"Set verify file hidden unsuccess : ",ls_command END IF
  }
  
  {
  LET ls_command = cs_client_temp_dir,cs_dos_separator,"7za.exe x -aoa ",cs_client_temp_dir,cs_dos_separator,ls_file_name,".tzt -o",ls_work_path,cs_dos_separator,ls_file_name,".bak"
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_result])
  IF lb_result THEN DISPLAY cs_message_tag,"Extract files OK !!" ELSE DISPLAY cs_error_tag,"Extract files unsuccess !!" END IF

  LET ls_command = "cmd.exe /C \"attrib +h ",ls_work_path,cs_dos_separator,ls_file_name,".bak",cs_dos_separator,ls_file_name,".vfy",""
  CALL ui.Interface.frontCall("standard", "execute", [ls_command,1], [lb_reisult])
  IF lb_result THEN DISPLAY cs_message_tag,"Set backup verify file hidden OK !" ELSE DISPLAY cs_warning_tag,"Set backup verify file hidden unsuccess : ",ls_command END IF

  }

  LABEL _return:

  RETURN lb_result
  
END FUNCTION 

FUNCTION adzp050_download_form_pack(p_file_name,p_module_name,p_identity,p_module_path,p_source_path,p_destination_path,p_download_type,p_erpalm,p_readonly)
DEFINE
  p_file_name         STRING,
  p_module_name       STRING,
  p_identity          STRING,
  p_module_path       STRING,
  p_source_path       STRING,
  p_destination_path  STRING,
  p_download_type     STRING,
  p_erpalm            STRING,
  p_readonly          BOOLEAN  
DEFINE
  ls_file_name        STRING,
  ls_module_name      STRING,
  ls_identity         STRING,
  ls_module_path      STRING,
  ls_source_path      STRING,
  ls_destination_path STRING,
  ls_source_file      STRING,
  ls_destination_file STRING,
  ls_download_type    STRING,
  ls_erpalm           STRING,
  lb_readonly         BOOLEAN,  
  lb_result           BOOLEAN,
  ls_message          STRING
DEFINE
  lb_return BOOLEAN 

  LET ls_file_name        = p_file_name        
  LET ls_module_name      = p_module_name       
  LET ls_identity         = p_identity   
  LET ls_module_path      = p_module_path        
  LET ls_source_path      = p_source_path        
  LET ls_destination_path = p_destination_path        
  LET ls_download_type    = p_download_type
  LET ls_erpalm           = p_erpalm
  LET lb_readonly         = p_readonly

  LET ls_source_file      = ls_source_path,ls_file_name
  LET ls_destination_file = ls_destination_path,ls_file_name

  LET ms_running_process = "adzp050_download_form_pack"
  
  CALL adzp050_show_message_designer()
  
  #DISPLAY "Compressing files to TZP ..."
  LET ls_message = "Compressing files ..."
  CALL adzp050_show_process_message(ls_message)
  CALL sadzp050_zip_compress_to_form_zip(ls_file_name,ls_module_name,ls_identity,ls_module_path,ms_lang,ls_download_type,ls_erpalm,lb_readonly,TRUE) RETURNING lb_result,ls_source_path,ls_file_name
  IF NOT lb_result THEN GOTO _return END IF

  #DISPLAY "Downloading TZP file ..."
  LET ls_message = "Downloading Compressed files ..."
  CALL adzp050_show_process_message(ls_message)
  CALL sadzp050_zip_download_form_zip(ls_file_name,ls_module_name,ls_source_path,ls_destination_path,ls_download_type,ms_modulefolder) RETURNING lb_result #20151231 by elena 增加ms_modulefolder參數
  IF NOT lb_result THEN GOTO _return END IF 

  LABEL _return:

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_download_csd_pack(p_file_name,p_module_name,p_identity,p_module_path,p_source_path,p_destination_path,p_download_type,p_erpalm,p_readonly)
DEFINE
  p_file_name        STRING,
  p_module_name      STRING,
  p_identity         STRING, 
  p_module_path      STRING,
  p_source_path      STRING,
  p_destination_path STRING,
  p_download_type     STRING,
  p_erpalm            STRING,
  p_readonly          BOOLEAN   
DEFINE
  ls_file_name        STRING,
  ls_module_name      STRING,
  ls_identity         STRING, 
  ls_module_path      STRING,
  ls_source_path      STRING,
  ls_destination_path STRING,
  ls_source_file      STRING,
  ls_destination_file STRING,
  ls_download_type    STRING,
  ls_erpalm           STRING,
  lb_readonly         BOOLEAN,  
  lb_result           BOOLEAN,
  ls_message          STRING
DEFINE
  lb_return BOOLEAN 

  LET ls_file_name        = p_file_name        
  LET ls_module_name      = p_module_name        
  LET ls_identity         = p_identity
  LET ls_module_path      = p_module_path        
  LET ls_source_path      = p_source_path        
  LET ls_destination_path = p_destination_path        
  LET ls_download_type    = p_download_type
  LET ls_erpalm           = p_erpalm
  LET lb_readonly         = p_readonly

  LET ls_source_file      = ls_source_path,ls_file_name
  LET ls_destination_file = ls_destination_path,ls_file_name

  LET ms_running_process = "adzp050_download_csd_pack"
  
  CALL adzp050_show_message_designer()
  
  LET ls_message = "Compressing files ..."
  CALL adzp050_show_process_message(ls_message)
  CALL sadzp050_zip_compress_to_csd_zip(ls_file_name,ls_module_name,ls_identity,ls_module_path,ms_lang,ls_download_type,ls_erpalm,lb_readonly,TRUE) RETURNING lb_result,ls_source_path,ls_file_name
  IF NOT lb_result THEN GOTO _return END IF
  
  LET ls_message = "Downloading compressed files ..."
  CALL adzp050_show_process_message(ls_message)
  CALL sadzp050_zip_download_csd_zip(ls_file_name,ls_module_name,ls_source_path,ls_destination_path,ls_download_type,ms_modulefolder) RETURNING lb_result #20151231 by elena 增加ms_modulefolder參數
  IF NOT lb_result THEN GOTO _return END IF 

  LABEL _return:

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_download_rsd_pack(p_file_name,p_module_name,p_identity,p_module_path,p_source_path,p_destination_path,p_download_type,p_erpalm,p_readonly)
DEFINE
  p_file_name        STRING,
  p_module_name      STRING,
  p_identity         STRING,
  p_module_path      STRING,
  p_source_path      STRING,
  p_destination_path STRING,
  p_download_type     STRING,
  p_erpalm            STRING,
  p_readonly          BOOLEAN   
DEFINE
  ls_file_name        STRING,
  ls_module_name      STRING,
  ls_identity         STRING,
  ls_module_path      STRING,
  ls_source_path      STRING,
  ls_destination_path STRING,
  ls_source_file      STRING,
  ls_destination_file STRING,
  ls_download_type    STRING,
  ls_erpalm           STRING,
  lb_readonly         BOOLEAN,  
  lb_result           BOOLEAN,
  ls_message          STRING
DEFINE
  lb_return BOOLEAN 

  LET ls_file_name        = p_file_name        
  LET ls_module_name      = p_module_name    
  LET ls_identity         = p_identity
  LET ls_module_path      = p_module_path        
  LET ls_source_path      = p_source_path        
  LET ls_destination_path = p_destination_path        
  LET ls_download_type    = p_download_type
  LET ls_erpalm           = p_erpalm
  LET lb_readonly         = p_readonly

  LET ls_source_file      = ls_source_path,ls_file_name
  LET ls_destination_file = ls_destination_path,ls_file_name

  LET ms_running_process = "adzp050_download_rsd_pack"
  
  CALL adzp050_show_message_designer()
  
  LET ls_message = "Compressing files ..."
  CALL adzp050_show_process_message(ls_message)
  CALL sadzp050_zip_compress_to_rsd_zip(ls_file_name,ls_module_name,ls_identity,ls_module_path,ms_lang,ls_download_type,ls_erpalm,lb_readonly,TRUE) RETURNING lb_result,ls_source_path,ls_file_name
  IF NOT lb_result THEN GOTO _return END IF
  
  LET ls_message = "Downloading compressed file ..."
  CALL adzp050_show_process_message(ls_message)
  CALL sadzp050_zip_download_rsd_zip(ls_file_name,ls_module_name,ls_source_path,ls_destination_path,ls_download_type,ms_modulefolder) RETURNING lb_result #20151231 by elena 增加ms_modulefolder參數
  IF NOT lb_result THEN GOTO _return END IF 

  LABEL _return:
  
  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_download_designer_pack(p_file_name,p_module_name,p_source_path,p_destination_path)
DEFINE
  p_file_name        STRING,
  p_module_name      STRING,
  p_source_path      STRING,
  p_destination_path STRING
DEFINE
  ls_file_name        STRING,
  ls_module_name      STRING,
  ls_source_path      STRING,
  ls_destination_path STRING,
  ls_source_file      STRING,
  ls_destination_file STRING,
  lb_result           BOOLEAN,
  ls_message          STRING
DEFINE
  lb_return BOOLEAN 
  
  LET ls_file_name        = p_file_name        
  LET ls_module_name      = p_module_name        
  LET ls_source_path      = p_source_path        
  LET ls_destination_path = p_destination_path        

  LET ls_source_file      = ls_source_path,ls_file_name
  LET ls_destination_file = ls_destination_path,ls_file_name

  LET ms_running_process = "adzp050_download_designer_pack"
  
  CALL adzp050_show_message_designer()
  
  #DISPLAY "Compressing files to Designer ZIP ..."
  LET ls_message = "Compressing files ..."
  CALL adzp050_show_process_message(ls_message)
  CALL sadzp050_zip_compress_to_designer_zip(ls_file_name,ls_module_name,ms_lang) RETURNING ls_source_path

  #DISPLAY "Downloading Designer ZIP file ..."
  LET ls_message = "Downloading compressed file ..."
  CALL adzp050_show_process_message(ls_message)
  CALL sadzp050_zip_download_designer_zip(ls_file_name,ls_module_name,ls_source_path,ls_destination_path,ms_modulefolder) RETURNING lb_result #20151231 by elena 增加ms_modulefolder參數
  IF NOT lb_result THEN GOTO _return END IF 

  LABEL _return:

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_fill_all_list(p_sql)
DEFINE
  p_sql STRING
DEFINE
  li_count INTEGER,
  ls_sql   STRING

  LET ls_sql = p_sql

  #DISPLAY cs_message_tag,ls_sql

  PREPARE lpre_all_list FROM ls_sql
  DECLARE lcur_all_list CURSOR FOR lpre_all_list

  CALL m_prog_list.clear()
  
  LET li_count = 1
  
  FOREACH lcur_all_list INTO m_prog_list[li_count].*    
    #Begin:2014/08/25 by Hiko:客戶沒有行業別的開發需求,所以要將原本行業別對應的標準程式相關都改成和行業別代號相同.
    IF mb_customize THEN
       LET m_prog_list[li_count].origin_prog = m_prog_list[li_count].prog_name
       LET m_prog_list[li_count].origin_module = m_prog_list[li_count].module_name
       LET m_prog_list[li_count].origin_spec_type = m_prog_list[li_count].spec_type
       LET m_prog_list[li_count].origin_sd_ver = m_prog_list[li_count].sd_ver
       LET m_prog_list[li_count].origin_pg_ver = m_prog_list[li_count].pg_ver
       LET m_prog_list[li_count].origin_identity = m_prog_list[li_count].identity
    END IF
    #Begin:2014/08/25 by Hiko
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    LET li_count = li_count + 1
  END FOREACH
  CALL m_prog_list.deleteElement(li_count)
  
END FUNCTION 

FUNCTION adzp050_get_all_list_sql(p_erpalm,p_module_name,p_spec_type,p_max_ver,p_download_type,p_search)
DEFINE
  p_erpalm        STRING,
  p_module_name   STRING,
  p_spec_type     STRING,
  p_max_ver       BOOLEAN,
  p_download_type STRING,
  p_search        STRING  #20151130 by elena   
DEFINE 
  ls_erpalm           STRING,
  ls_module_name      STRING,
  ls_spec_type        STRING,  
  lb_max_ver          BOOLEAN,  
  ls_download_type    STRING,
  ls_search           STRING,  #20151130 by elena   
  ls_sql              STRING,
  ls_gzza_sql         STRING,
  ls_gzza_sql_cond    STRING,
  ls_gzde_sql         STRING,
  ls_gzde_sql_cond    STRING,
  ls_gzdf_de_sql      STRING,
  ls_gzdf_de_sql_cond STRING,
  ls_gzdf_za_sql      STRING,
  ls_gzdf_za_sql_cond STRING,
  ls_dzlm_sql         STRING,
  ls_exclude_sql      STRING,
  ls_gzja_sql         STRING,
  ls_gzja_sql_cond    STRING,
  ls_dzca_sql         STRING,
  ls_dzca_sql_cond    STRING,
  ls_cols_sql         STRING,
  ls_cols_sql_cond    STRING,
  ls_cols_sql_download_cond STRING,
  ls_sql_view_mergeable STRING,
  ls_module_sql_cond  STRING,
  ls_DGENV            STRING,
  ls_rtn_like         STRING,
  ls_rtn_escape       STRING, 
  ls_sql_alm          STRING, #20160330 by ernest
  ls_sql_view_std_to_cust STRING #161028-00001

  LET ls_erpalm        = p_erpalm
  LET ls_module_name   = p_module_name 
  LET ls_spec_type     = p_spec_type
  LET lb_max_ver       = p_max_ver
  LET ls_download_type = p_download_type
  LET ls_search        = p_search  #20151130 by elena

  LET ls_DGENV = ms_DGENV
  
  #先排除條件中有跳脫碼的資料
  #CALL adzp050_get_cond_with_escape(ls_module_name) RETURNING ls_rtn_like,ls_rtn_escape  #20151130 by elena
  CALL adzp050_get_cond_with_escape(ls_search) RETURNING ls_rtn_like,ls_rtn_escape  

  IF NVL(ls_spec_type,"!@#") <> "!@#" THEN
    LET ls_cols_sql = "SELECT ROWNUM ROW_NUM, COLS.* FROM ( "
    LET ls_cols_sql_cond = " ) COLS WHERE 1=1 AND COLS.COL07 = '",ls_spec_type,"'"
  ELSE
    LET ls_cols_sql = "SELECT ROWNUM ROW_NUM, COLS.* FROM ( "
    LET ls_cols_sql_cond = " ) COLS WHERE 1=1 "
  END IF

  #過濾下載清單為 SPEC 或是 CODE
  #非同時下載SPEC或CODE時使用
  IF NOT mb_download_all THEN
    IF ls_download_type.toUpperCase() = cs_download_type_spec THEN
      IF ls_spec_type IS NOT NULL THEN
        LET ls_cols_sql_download_cond = " AND COLS.COL07 IN ('", ls_spec_type ,"')"
      ELSE
        LET ls_cols_sql_download_cond = " AND COLS.COL07 IN ('B','M','S','G','X','Q','F','W','Z')"
      END IF
    END IF 
    IF ls_download_type.toUpperCase() = cs_download_type_code THEN
      IF ls_spec_type IS NOT NULL THEN
        LET ls_cols_sql_download_cond = " AND COLS.COL07 IN ('", ls_spec_type ,"')"
      ELSE
        LET ls_cols_sql_download_cond = " AND COLS.COL07 IN ('B','M','S','G','X','Q','W','Z')"
      END IF
    END IF 
    IF ls_download_type.toUpperCase() = cs_download_type_4rp THEN
      IF ls_spec_type IS NOT NULL THEN
        LET ls_cols_sql_download_cond = " AND COLS.COL07 IN ('", ls_spec_type ,"')"
      ELSE
        LET ls_cols_sql_download_cond = " AND COLS.COL07 IN ('R','G')"
      END IF
    END IF 
  ELSE 
    LET ls_cols_sql_download_cond = ""  
  END IF 

  #IF ls_module_name IS NOT NULL OR ls_rtn_like IS NOT NULL THEN
  #  LET ls_module_sql_cond = " AND (          ",
  #                           "          COLS.COL05 = '",ls_module_name.toUpperCase(),"'  ",
  #                           "       OR COLS.COL05 LIKE '%",ls_rtn_like.toUpperCase(),"%'",ls_rtn_escape,
  #                           "       OR COLS.COL08 LIKE '%",ls_rtn_like.toLowerCase(),"%'",ls_rtn_escape,
  #                           "       OR COLS.COL09 LIKE '%",ls_rtn_like,"%'",ls_rtn_escape,
  #                           "     )          "
  #ELSE
  #  LET ls_module_sql_cond = " AND 1=1 "
  #END IF 

  IF ls_module_name IS NULL AND ls_search IS NULL THEN
    LET ls_module_sql_cond = " AND 1=1 "
  ELSE
    IF ls_module_name IS NOT NULL THEN
      LET ls_module_sql_cond = " AND (   COLS.COL05 = '",ls_module_name.toUpperCase(),"'  )   "
    END IF

    IF ls_search IS NOT NULL THEN
      LET ls_module_sql_cond = ls_module_sql_cond, " AND (          ",
                                                   "          COLS.COL05 LIKE '%",ls_rtn_like.toUpperCase(),"%'",ls_rtn_escape,
                                                   "       OR COLS.COL08 LIKE '%",ls_rtn_like.toLowerCase(),"%'",ls_rtn_escape,
                                                   "       OR COLS.COL09 LIKE '%",ls_rtn_like,"%'",ls_rtn_escape,
                                                   "     )          "
    END IF

  END IF

  IF ms_view_mergeable = "Y" THEN 
    LET ls_sql_view_mergeable = " AND COLS.COL24 = 'N' AND COLS.COL17 = '",cs_dgenv_customize,"' "
  ELSE 
    LET ls_sql_view_mergeable = ""
  END IF 

  #161028-00001 begin
  IF ms_view_std_to_cust = "Y" THEN
    LET ls_sql_view_std_to_cust = " AND EXISTS (                                           ",
                                  "              SELECT 1                                  ",
                                  "                FROM DZAF_T AF                          ",
                                  "               WHERE AF.DZAF001 = COLS.COL08            ",
                                  "              HAVING MAX(AF.DZAF010) <> MIN(AF.DZAF010) ",
                                  "            )                                           "
  ELSE
    LET ls_sql_view_std_to_cust = ""
  END IF
  #161028-00001 end

  #=============================== begin Where 條件 =============================
  LET ls_gzza_sql_cond = " AND 1=1 "
  LET ls_gzde_sql_cond = " AND 1=1 "
  LET ls_gzdf_de_sql_cond = " AND 1=1 "
  LET ls_gzdf_za_sql_cond = " AND 1=1 "
  LET ls_gzja_sql_cond = " AND 1=1 "
  LET ls_dzca_sql_cond = " AND 1=1 "
  
  {
  #GZZA Where
  #IF ls_module_name IS NULL THEN
  #  LET ls_gzza_sql_cond = " AND 1=1 "
  #ELSE
  #  LET ls_gzza_sql_cond = " AND (                                                         ",
  #                         "          ZA.GZZA003 = '",ls_module_name.toUpperCase(),"'      ",
  #                         "       OR ZA.GZZA003 LIKE '%",ls_rtn_like.toUpperCase(),"%'    ",ls_rtn_escape,
  #                         "       OR ZA.GZZA001 LIKE '%",ls_rtn_like.toLowerCase(),"%'    ",ls_rtn_escape,
  #                         "       OR ZAL.GZZAL003 LIKE '%",ls_rtn_like,"%'                ",ls_rtn_escape,
  #                         "     )                                                         "
  #END IF  

  IF ls_module_name IS NULL AND ls_search IS NULL THEN
    LET ls_gzza_sql_cond = " AND 1=1 "
  ELSE
    IF ls_module_name IS NOT NULL THEN
      LET ls_gzza_sql_cond = " AND (      ZA.GZZA003 = '",ls_module_name.toUpperCase(),"'    )      "
    END IF

    IF ls_search IS NOT NULL THEN
      LET ls_gzza_sql_cond = ls_gzza_sql_cond, "AND (   "       
                                               "          ZA.GZZA003 LIKE '%",ls_rtn_like.toUpperCase(),"%'    ",ls_rtn_escape,
                                               "       OR ZA.GZZA001 LIKE '%",ls_rtn_like.toLowerCase(),"%'    ",ls_rtn_escape,
                                               "       OR ZAL.GZZAL003 LIKE '%",ls_rtn_like,"%'                ",ls_rtn_escape,
                                               "     ) 
    END IF
  END IF                  

  #GZDE Where
  #IF ls_module_name IS NULL THEN
  #  LET ls_gzde_sql_cond = " AND 1=1 "
  #ELSE
  #  LET ls_gzde_sql_cond = " AND (                                                   ",
  #                         "       DE.GZDE001 LIKE '%",ls_rtn_like.toLowerCase(),"%' ",ls_rtn_escape,
  #                         "       OR                                                ", 
  #                         "       DE.GZDE002 LIKE '%",ls_rtn_like.toUpperCase(),"%' ",ls_rtn_escape,
  #                         "       OR                                                ",
  #                         "       DEL.GZDEL003 LIKE '%",ls_rtn_like,"%'             ",ls_rtn_escape,
  #                         "     )                                                   " 
  #END IF  

  IF ls_module_name IS NULL AND ls_search IS NULL THEN
    LET ls_gzde_sql_cond = " AND 1=1 "
  ELSE
    IF ls_module_name IS NOT NULL THEN
      LET ls_gzde_sql_cond = " AND (                                                   ",
                           "       DE.GZDE001 LIKE '%",ls_module_name.toLowerCase(),"%' ",
                           "       OR                                                ",
                           "       DE.GZDE002 LIKE '%",ls_module_name.toUpperCase(),"%' ",
                           "       OR                                                ",
                           "       DEL.GZDEL003 LIKE '%",ls_module_name,"%'             ",
                           "     )  
    END IF

    IF ls_search IS NOT NULL THEN
      LET ls_gzde_sql_cond = ls_gzde_sql_cond, " AND (                                                   ",
                                               "       DE.GZDE001 LIKE '%",ls_rtn_like.toLowerCase(),"%' ",ls_rtn_escape,
                                               "       OR                                                ",
                                               "       DE.GZDE002 LIKE '%",ls_rtn_like.toUpperCase(),"%' ",ls_rtn_escape,
                                               "       OR                                                ",
                                               "       DEL.GZDEL003 LIKE '%",ls_rtn_like,"%'             ",ls_rtn_escape,
                                               "     )
    END IF
  END IF
                  

  #GZDF_DE Where
  #IF ls_module_name IS NULL THEN
  #  LET ls_gzdf_de_sql_cond = " AND 1=1 "
  #ELSE
  #  LET ls_gzdf_de_sql_cond = " AND (                                                       ",
  #                            "       DE.GZDE002 LIKE '%",ls_rtn_like.toUpperCase(),"%'  ",ls_rtn_escape,
  #                            "       OR                                                    ", 
  #                            "       ZDF.GZDF002 LIKE '%",ls_rtn_like.toLowerCase(),"%' ",ls_rtn_escape,
  #                            "     )                                                       " 
  #END IF                    

  IF ls_module_name IS NULL AND ls_search IS NULL THEN
    LET ls_gzdf_de_sql_cond = " AND 1=1 "
  ELSE
    IF ls_module_name IS NOT NULL THEN
      LET ls_gzdf_de_sql_cond = " AND (                                                       ",
                                "       DE.GZDE002 LIKE '%",ls_module_name.toUpperCase(),"%'  ",
                                "       OR                                                    ",
                                "       ZDF.GZDF002 LIKE '%",ls_module_name.toLowerCase(),"%' ",
                                "     )
    END IF

    IF ls_search IS NOT NULL THEN
          LET ls_gzdf_de_sql_cond =ls_gzdf_de_sql_cond, " AND (                                                       ",
                                                        "       DE.GZDE002 LIKE '%",ls_rtn_like.toUpperCase(),"%'  ",ls_rtn_escape,
                                                        "       OR                                                    ",
                                                        "       ZDF.GZDF002 LIKE '%",ls_rtn_like.toLowerCase(),"%' ",ls_rtn_escape,

                                                        "     )
    END IF
  END IF


  #GZDF_ZA Where
  #IF ls_module_name IS NULL THEN
  #  LET ls_gzdf_za_sql_cond = " AND 1=1 "
  #ELSE
  #  LET ls_gzdf_za_sql_cond = " AND (                                                           ",
  #                            "       (                                                         ",
  #                            "            ZA.GZZA003 = '",ls_module_name.toUpperCase(),"'      ",
  #                            "         OR ZA.GZZA003 LIKE '%",ls_rtn_like.toUpperCase(),"%'    ",ls_rtn_escape,
  #                            "         OR ZA.GZZA001 LIKE '%",ls_rtn_like.toLowerCase(),"%'    ",ls_rtn_escape,
  #                            "       )                                                         ",
  #                            "       OR                                                        ", 
  #                            "       ZDF.GZDF002 LIKE '%",ls_rtn_like.toLowerCase(),"%'        ",ls_rtn_escape,
  #                            "     )                                                           " 
  #END IF                    

  IF ls_module_name IS NULL AND ls_search IS NULL THEN
    LET ls_gzdf_za_sql_cond = " AND 1=1 "
  ELSE
    IF ls_module_name IS NOT NULL THEN
      LET ls_gzdf_za_sql_cond = " AND (  (  ZA.GZZA003 = '",ls_module_name.toUpperCase(),"'   ) OR ZDF.GZDF002 LIKE '%",ls_module_name.toLowerCase(),"%' ) " 
    END IF

    IF ls_search IS NOT NULL THEN
      LET ls_gzdf_za_sql_cond = ls_gzdf_za_sql_cond, " AND (                                                           ",
                                                     "       (                                                         ",
                                                     "            ZA.GZZA003 LIKE '%",ls_rtn_like.toUpperCase(),"%'    ",ls_rtn_escape,
                                                     "         OR ZA.GZZA001 LIKE '%",ls_rtn_like.toLowerCase(),"%'    ",ls_rtn_escape,
                                                     "       )                                                         ",
                                                     "       OR                                                        ",
                                                     "       ZDF.GZDF002 LIKE '%",ls_rtn_like.toLowerCase(),"%'        ",ls_rtn_escape,
                                                     "     )        
    END IF
  END IF

  #GZJA Where
  #IF ls_module_name IS NULL THEN
  #  LET ls_gzja_sql_cond = " AND 1=1 "
  #ELSE
  #  LET ls_gzja_sql_cond = " AND (                                                   ",
  #                         "       ZJA.GZJA001 LIKE '%",ls_rtn_like.toLowerCase(),"%' ",ls_rtn_escape,
  #                         "       OR                                                ", 
  #                         "       ZJA.GZJA002 LIKE '%",ls_rtn_like.toUpperCase(),"%' ",ls_rtn_escape,
  #                         "       OR                                                ",
  #                         "       JAL.GZJAL003 LIKE '%",ls_rtn_like,"%'             ",ls_rtn_escape,
  #                         "     )                                                   " 
  #END IF

  IF ls_module_name IS NULL AND ls_search IS NULL THEN
    LET ls_gzja_sql_cond = " AND 1=1 "
  ELSE
    IF ls_module_name IS NOT NULL THEN
      LET ls_gzja_sql_cond = " AND (                                                   ",
                             "       ZJA.GZJA001 LIKE '%",ls_module_name.toLowerCase(),"%' ",
                             "       OR                                                ",
                             "       ZJA.GZJA002 LIKE '%",ls_module_name.toUpperCase(),"%' ",
                             "       OR                                                ",
                             "       JAL.GZJAL003 LIKE '%",ls_module_name,"%'             ",
                             "     )  
    END IF

    IF ls_search IS NOT NULL THEN
      LET ls_gzja_sql_cond = ls_gzja_sql_cond, " AND (                                                   ",
                                               "       ZJA.GZJA001 LIKE '%",ls_rtn_like.toLowerCase(),"%' ",ls_rtn_escape,
                                               "       OR                                                ",
                                               "       ZJA.GZJA002 LIKE '%",ls_rtn_like.toUpperCase(),"%' ",ls_rtn_escape,
                                               "       OR                                                ",
                                               "       JAL.GZJAL003 LIKE '%",ls_rtn_like,"%'             ",ls_rtn_escape,
                                               "     )
    END IF
  END IF                    
  
  #DZCA Where
  #IF ls_module_name IS NULL THEN
  #  LET ls_dzca_sql_cond = " AND 1=1 "
  #ELSE
  #  LET ls_dzca_sql_cond = " AND (                                                    ",
  #                         "       ZCA.DZCA001 LIKE '%",ls_rtn_like.toLowerCase(),"%' ",ls_rtn_escape,
  #                         "       OR                                                 ", 
  #                         "       CAL.DZCAL003 LIKE '%",ls_rtn_like,"%'              ",ls_rtn_escape,
  #                         "     )                                                    " 
  #END IF

  IF ls_module_name IS NULL AND ls_search IS NULL THEN
    LET ls_dzca_sql_cond = " AND 1=1 "
  ELSE
    IF ls_module_name IS NOT NULL THEN
      LET ls_dzca_sql_cond = " AND (                                                    ",
                             "       ZCA.DZCA001 LIKE '%",ls_module_name.toLowerCase(),"%' ",
                             "       OR                                                 ",
                             "       CAL.DZCAL003 LIKE '%",ls_module_name,"%'              ",
                             "     )
    END IF
      LET ls_dzca_sql_cond = ls_dzca_sql_cond, " AND (                                                    ",
                                               "       ZCA.DZCA001 LIKE '%",ls_rtn_like.toLowerCase(),"%' ",ls_rtn_escape,
                                               "       OR                                                 ",
                                               "       CAL.DZCAL003 LIKE '%",ls_rtn_like,"%'              ",ls_rtn_escape,
                                               "     )
    IF ls_search IS NOT NULL THEN

    END IF
  END IF

  }
  
  #=============================== end Where 條件 =============================
   
  #M類
  LET ls_gzza_sql = "SELECT DISTINCT                                                              ",
                    "       ''                                                             COL01, ",
                    "       'N'                                                            COL02, ",
                    "       'N'                                                            COL03, ",
                    "       NVL(ZBA.GZZB002,NVL(ZA.GZZA015,'",cs_industry_type_standard,"')) COL04, ",
                    "       DECODE(ZA.GZZA011,'",cs_dgenv_customize,"',NVL(OZJ.GZZJ001,ZA.GZZA003),DECODE(CAF.CDZAF010,'",cs_dgenv_customize,"',NVL(OZJ.GZZJ001,ZA.GZZA003),ZA.GZZA003))  COL05, ",
                    "       NVL(OZJ.GZZJ001,ZA.GZZA003)                                    COL06, ",
                    "       'M'                                                            COL07, ",
                    "       ZA.GZZA001                                                     COL08, ",
                    "       ZAL.GZZAL003                                                   COL09, ",
                    "       ''                                                             COL10, ",
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF002,CAF.CDZAF002)            COL11, ", 
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF003,CAF.CDZAF003)            COL12, ",
                    "       DECODE( '",ls_erpalm,"','Y','R','W')                           COL13, ", 
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF004,CAF.CDZAF004)            COL14, ",
                    "       DECODE( '",ls_erpalm,"','Y','R','W')                           COL15, ", 
                    "       0                                                              COL16, ",
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF010,CAF.CDZAF010)            COL17, ",
                    "       ZBA.GZZB003                                                    COL18, ",
                    "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF006,ZBA.CDZAF006)            COL19, ",
                    "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF005,ZBA.CDZAF005)            COL20, ",
                    "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF003,ZBA.CDZAF003)            COL21, ",
                    "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF004,ZBA.CDZAF004)            COL22, ",
                    "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF010,ZBA.CDZAF010)            COL23, ",
                    --"       DECODE(AP.DZAP001,NULL,'',DECODE(AP.DZAP010,'Y','',NVL(AP.DZAP010,'N')))  COL24, ", #161027-00001 
                    --"       DECODE(AQ.DZAQ001,NULL,'',DECODE(AQ.DZAQ010,'Y','',NVL(AQ.DZAQ010,'N')))  COL25  ", #161027-00001 
                    "       DECODE(AP.DZAP001,NULL,'',AP.DZAP010)                          COL24, ", #161027-00001 
                    "       DECODE(AQ.DZAQ001,NULL,'',AQ.DZAQ010)                          COL25  ", #161027-00001 
                    "  FROM GZZA_T ZA                                                             ",
                    "  LEFT OUTER JOIN DZAP_T AP ON AP.DZAP001 = ZA.GZZA001                       ", 
                    "  LEFT OUTER JOIN DZAQ_T AQ ON AQ.DZAQ001 = ZA.GZZA001                       ", #161027-00001  
                    "  LEFT OUTER JOIN (                                                          ",
                    ms_dzaf_t_o_view,                                                      
                    "                  ) ZBA                                                      ",
                    "    ON ZBA.GZZB001 = ZA.GZZA001                                              ",
                    "  LEFT OUTER JOIN GZZAL_T ZAL ON ZAL.GZZAL001 = ZA.GZZA001                   ",
                    "                             AND ZAL.GZZAL002 = '",ms_lang,"'                ",
                    "  LEFT OUTER JOIN (                                                          ", 
                    ms_dzaf_t_s_view,                                                      
                    "                  ) SAF                                                      ", 
                    "                  ON SAF.SDZAF001 = ZA.GZZA001                               ", 
                    "  LEFT OUTER JOIN (                                                          ", 
                    ms_dzaf_t_c_view,                                                      
                    "                  ) CAF                                                      ", 
                    "                  ON CAF.CDZAF001 = ZA.GZZA001                               ", 
                    "  LEFT OUTER JOIN (                                                          ", 
                    ms_gzzj_t_view,                                                        
                    "                  ) OZJ                                                      ", 
                    "                  ON OZJ.GZZJ003 = ZA.GZZA003                                ", 
                    " WHERE 1=1                                                                   ", 
                    "   AND ZA.GZZA003 NOT IN (",ms_exclude_module,")                             ", 
                    "   AND NVL(ZA.GZZA016,'Y') = 'Y'                                             ", 
                    "   AND ZA.GZZA002 <> 'S'                                                     ",
                    ls_gzza_sql_cond                                           

  #S,B類(有Form), G,X類                    
  LET ls_gzde_sql = "SELECT DISTINCT                                                               ",
                    "       ''                                                             COL01,  ",
                    "       'N'                                                            COL02,  ",
                    "       'N'                                                            COL03,  ",
                    "       NVL(ZBA.GZZB002,NVL(DE.GZDE009,'",cs_industry_type_standard,"')) COL04,  ",
                    "       DECODE(DE.GZDE008,'",cs_dgenv_customize,"',NVL(OZJ.GZZJ001,DE.GZDE002),DECODE(CAF.CDZAF010,'",cs_dgenv_customize,"',NVL(OZJ.GZZJ001,DE.GZDE002),DE.GZDE002))  COL05,  ",
                    "       NVL(OZJ.GZZJ001,DE.GZDE002)                                    COL06,  ",
                    "       DE.GZDE003                                                     COL07,  ",
                    "       DE.GZDE001                                                     COL08,  ",
                    "       DEL.GZDEL003                                                   COL09,  ",
                    "       ''                                                             COL10,  ",
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF002,CAF.CDZAF002)            COL11,  ", 
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF003,CAF.CDZAF003)            COL12,  ",
                    "       DECODE( '",ls_erpalm,"','Y','R','W')                           COL13,  ", 
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF004,CAF.CDZAF004)            COL14,  ",
                    "       DECODE( '",ls_erpalm,"','Y','R','W')                           COL15,  ", 
                    "       0                                                              COL16,  ", 
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF010,CAF.CDZAF010)            COL17,  ",
                    "       ZBA.GZZB003                                                    COL18,  ",
                    "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF006,ZBA.CDZAF006)            COL19,  ",
                    "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF005,ZBA.CDZAF005)            COL20,  ",
                    "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF003,ZBA.CDZAF003)            COL21,  ",
                    "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF004,ZBA.CDZAF004)            COL22,  ",
                    "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF010,ZBA.CDZAF010)            COL23,  ",
                    --"       DECODE(AP.DZAP001,NULL,'',DECODE(AP.DZAP010,'Y','',NVL(AP.DZAP010,'N')))  COL24, ", #161027-00001 
                    --"       DECODE(AQ.DZAQ001,NULL,'',DECODE(AQ.DZAQ010,'Y','',NVL(AQ.DZAQ010,'N')))  COL25  ", #161027-00001 
                    "       DECODE(AP.DZAP001,NULL,'',AP.DZAP010)                          COL24, ", #161027-00001 
                    "       DECODE(AQ.DZAQ001,NULL,'',AQ.DZAQ010)                          COL25  ", #161027-00001 
                    "  FROM GZDE_T DE                                                              ",
                    "  LEFT OUTER JOIN DZAP_T AP ON AP.DZAP001 = DE.GZDE001                        ", 
                    "  LEFT OUTER JOIN DZAQ_T AQ ON AQ.DZAQ001 = DE.GZDE001                        ", #161027-00001  
                    "  LEFT OUTER JOIN (                                                           ",      
                    ms_dzaf_t_o_view,                                                      
                    "                  ) ZBA                                                       ",
                    "    ON ZBA.GZZB001 = DE.GZDE001                                               ",
                    "  LEFT OUTER JOIN GZDEL_T DEL ON DEL.GZDEL001 = DE.GZDE001                    ",
                    "                             AND DEL.GZDEL002 = '",ms_lang,"'                 ",
                    "  LEFT OUTER JOIN (                                                           ", 
                    ms_dzaf_t_s_view,                                                      
                    "                  ) SAF                                                       ", 
                    "                  ON SAF.SDZAF001 = DE.GZDE001                                ", 
                    "  LEFT OUTER JOIN (                                                           ", 
                    ms_dzaf_t_c_view,                                                      
                    "                  ) CAF                                                       ", 
                    "                  ON CAF.CDZAF001 = DE.GZDE001                                ", 
                    "  LEFT OUTER JOIN (                                                           ", 
                    ms_gzzj_t_view,                                                        
                    "                  ) OZJ                                                       ", 
                    "                  ON OZJ.GZZJ003 = DE.GZDE002                                 ", 
                    " WHERE 1=1                                                                    ",
                    "   AND DE.GZDE002 NOT IN (",ms_exclude_module,")                              ", #2014/12/03 by Hiko
                    "   AND NVL(DE.GZDE007,'Y') = 'Y'                                              ",
                    ls_gzde_sql_cond                                                              

  #F類(子畫面)                                                                                
  LET ls_gzdf_de_sql = "SELECT DISTINCT                                                               ",
                       "       ''                                                             COL01,  ",
                       "       'N'                                                            COL02,  ",
                       "       'N'                                                            COL03,  ",
                       "       NVL(ZBA.GZZB002,NVL(DE.GZDE009,'",cs_industry_type_standard,"')) COL04,  ",
                       "       DECODE(ZDF.GZDF003,'",cs_dgenv_customize,"',NVL(OZJ.GZZJ001,DE.GZDE002),DECODE(CAF.CDZAF010,'",cs_dgenv_customize,"',NVL(OZJ.GZZJ001,DE.GZDE002),DE.GZDE002)) COL05,  ",
                       "       NVL(OZJ.GZZJ001,DE.GZDE002)                                    COL06,  ",
                       "       'F'                                                            COL07,  ",
                       "       ZDF.GZDF002                                                    COL08,  ",
                       "       DFL.GZDFL003                                                   COL09,  ",
                       "       ''                                                             COL10,  ",
                       "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF002,CAF.CDZAF002)            COL11,  ", 
                       "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF003,CAF.CDZAF003)            COL12,  ",
                       "       DECODE( '",ls_erpalm,"','Y','R','W')                           COL13,  ", 
                       "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF004,CAF.CDZAF004)            COL14,  ",
                       "       DECODE( '",ls_erpalm,"','Y','R','W')                           COL15,  ", 
                       "       0                                                              COL16,  ", 
                       "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF010,CAF.CDZAF010)            COL17,  ",
                       "       ZBA.GZZB003                                                    COL18,  ",
                       "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF006,ZBA.CDZAF006)            COL19,  ",
                       "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF005,ZBA.CDZAF005)            COL20,  ",
                       "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF003,ZBA.CDZAF003)            COL21,  ",
                       "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF004,ZBA.CDZAF004)            COL22,  ",
                       "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF010,ZBA.CDZAF010)            COL23,  ",
                       --"       DECODE(AP.DZAP001,NULL,'',DECODE(AP.DZAP010,'Y','',NVL(AP.DZAP010,'N')))  COL24, ", #161027-00001 
                       --"       DECODE(AQ.DZAQ001,NULL,'',DECODE(AQ.DZAQ010,'Y','',NVL(AQ.DZAQ010,'N')))  COL25  ", #161027-00001 
                       "       DECODE(AP.DZAP001,NULL,'',AP.DZAP010)                          COL24, ", #161027-00001 
                       "       DECODE(AQ.DZAQ001,NULL,'',AQ.DZAQ010)                          COL25  ", #161027-00001 
                       "  FROM GZDF_T ZDF                                                             ",
                       " INNER JOIN GZDE_T DE ON DE.GZDE001 = ZDF.GZDF001 AND DE.GZDE002 NOT IN (",ms_exclude_module,") ", #2014/12/03 by Hiko                                         
                       "  LEFT OUTER JOIN DZAP_T AP ON AP.DZAP001 = ZDF.GZDF002                       ", 
                       "  LEFT OUTER JOIN DZAQ_T AQ ON AQ.DZAQ001 = ZDF.GZDF002                       ", #161027-00001 
                       "  LEFT OUTER JOIN (                                                           ",      
                       ms_dzaf_t_o_view,                                                      
                       "                  ) ZBA                                                       ",
                       "    ON ZBA.GZZB001 = ZDF.GZDF002                                              ",
                       "  LEFT OUTER JOIN GZDFL_T DFL ON DFL.GZDFL001 = ZDF.GZDF002                   ",
                       "                             AND DFL.GZDFL002 = '",ms_lang,"'                 ",
                       "  LEFT OUTER JOIN (                                                           ", 
                       ms_dzaf_t_s_view,                                                      
                       "                  ) SAF                                                       ", 
                       "                  ON SAF.SDZAF001 = ZDF.GZDF002                               ", 
                       "  LEFT OUTER JOIN (                                                           ", 
                       ms_dzaf_t_c_view,                                                      
                       "                  ) CAF                                                       ", 
                       "                  ON CAF.CDZAF001 = ZDF.GZDF002                               ",
                       "  LEFT OUTER JOIN (                                                           ", 
                       ms_gzzj_t_view,                                                        
                       "                  ) OZJ                                                       ", 
                       "                  ON OZJ.GZZJ003 = DE.GZDE002                                 ", 
                       " WHERE 1=1                                                                    ",
                       ls_gzdf_de_sql_cond

  #F類(主畫面)                    
  LET ls_gzdf_za_sql = "SELECT DISTINCT                                                              ",
                       "       ''                                                             COL01, ",
                       "       'N'                                                            COL02, ",
                       "       'N'                                                            COL03, ",
                       "       NVL(ZBA.GZZB002,NVL(ZA.GZZA015,'",cs_industry_type_standard,"')) COL04, ",
                       "       DECODE(ZDF.GZDF003,'",cs_dgenv_customize,"',NVL(OZJ.GZZJ001,ZA.GZZA003),DECODE(CAF.CDZAF010,'",cs_dgenv_customize,"',NVL(OZJ.GZZJ001,ZA.GZZA003),ZA.GZZA003)) COL05, ",
                       "       NVL(OZJ.GZZJ001,ZA.GZZA003)                                    COL06,  ",
                       "       'F'                                                            COL07, ",
                       "       ZDF.GZDF002                                                    COL08, ",
                       "       DFL.GZDFL003                                                   COL09, ",
                       "       ''                                                             COL10, ",
                       "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF002,CAF.CDZAF002)            COL11, ", 
                       "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF003,CAF.CDZAF003)            COL12, ",
                       "       DECODE( '",ls_erpalm,"','Y','R','W')                           COL13, ", 
                       "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF004,CAF.CDZAF004)            COL14, ",
                       "       DECODE( '",ls_erpalm,"','Y','R','W')                           COL15, ", 
                       "       0                                                              COL16, ", 
                       "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF010,CAF.CDZAF010)            COL17, ",
                       "       ZBA.GZZB003                                                    COL18, ",
                       "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF006,ZBA.CDZAF006)            COL19, ",
                       "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF005,ZBA.CDZAF005)            COL20, ",
                       "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF003,ZBA.CDZAF003)            COL21, ",
                       "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF004,ZBA.CDZAF004)            COL22, ",
                       "       DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF010,ZBA.CDZAF010)            COL23, ",
                       --"       DECODE(AP.DZAP001,NULL,'',DECODE(AP.DZAP010,'Y','',NVL(AP.DZAP010,'N')))  COL24, ", #161027-00001 
                       --"       DECODE(AQ.DZAQ001,NULL,'',DECODE(AQ.DZAQ010,'Y','',NVL(AQ.DZAQ010,'N')))  COL25  ", #161027-00001 
                       "       DECODE(AP.DZAP001,NULL,'',AP.DZAP010)                          COL24, ", #161027-00001 
                       "       DECODE(AQ.DZAQ001,NULL,'',AQ.DZAQ010)                          COL25  ", #161027-00001 
                       "  FROM GZDF_T ZDF                                                            ",
                       " INNER JOIN GZZA_T ZA ON ZA.GZZA001 = ZDF.GZDF001 AND ZA.GZZA003 NOT IN (",ms_exclude_module,") ", #2014/12/03 by Hiko
                       "  LEFT OUTER JOIN DZAP_T AP ON AP.DZAP001 = ZDF.GZDF002                      ", 
                       "  LEFT OUTER JOIN DZAQ_T AQ ON AQ.DZAQ001 = ZDF.GZDF002                      ", #161027-00001  
                       "  LEFT OUTER JOIN (                                                          ",      
                       ms_dzaf_t_o_view,                                                      
                       "                  ) ZBA                                                      ",
                       "    ON ZBA.GZZB001 = ZDF.GZDF002                                             ",
                       "  LEFT OUTER JOIN GZDFL_T DFL ON DFL.GZDFL001 = ZDF.GZDF002                  ",
                       "                             AND DFL.GZDFL002 = '",ms_lang,"'                ",
                       "  LEFT OUTER JOIN (                                                          ", 
                       ms_dzaf_t_s_view,                                                      
                       "                  ) SAF                                                      ", 
                       "                  ON SAF.SDZAF001 = ZDF.GZDF002                              ", 
                       "  LEFT OUTER JOIN (                                                          ", 
                       ms_dzaf_t_c_view,                                                      
                       "                  ) CAF                                                      ", 
                       "                  ON CAF.CDZAF001 = ZDF.GZDF002                              ",
                       "  LEFT OUTER JOIN (                                                          ", 
                       ms_gzzj_t_view,                                                        
                       "                  ) OZJ                                                      ", 
                       "                  ON OZJ.GZZJ003 = ZA.GZZA003                                ", 
                       " WHERE 1=1                                                                   ",
                       ls_gzdf_za_sql_cond                                                  

  #Z類(服務)                    
  LET ls_gzja_sql = "SELECT DISTINCT                                                                ",
                    "       ''                                                               COL01, ",
                    "       'N'                                                              COL02, ",
                    "       'N'                                                              COL03, ",
                    "       ZJA.GZJA006                                                      COL04, ",
                    "       DECODE(ZJA.GZJA005,'",cs_dgenv_customize,"',NVL(OZJ.GZZJ001,ZJA.GZJA002),DECODE(CAF.CDZAF010,'",cs_dgenv_customize,"',NVL(OZJ.GZZJ001,ZJA.GZJA002),ZJA.GZJA002)) COL05, ",
                    "       NVL(OZJ.GZZJ001,ZJA.GZJA002)                                     COL06, ",
                    "       'Z'                                                              COL07, ",
                    "       ZJA.GZJA001                                                      COL08, ",
                    "       JAL.GZJAL003                                                     COL09, ",
                    "       ''                                                               COL10, ",
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF002,CAF.CDZAF002)              COL11, ", 
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF003,CAF.CDZAF003)              COL12, ",
                    "       DECODE( '",ls_erpalm,"','Y','R','W')                             COL13, ", 
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF004,CAF.CDZAF004)              COL14, ",
                    "       DECODE( '",ls_erpalm,"','Y','R','W')                             COL15, ", 
                    "       0                                                                COL16, ", 
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF010,CAF.CDZAF010)              COL17, ",
                    "       NULL                                                             COL18, ",
                    "       NULL                                                             COL19, ",
                    "       NULL                                                             COL20, ",
                    "       NULL                                                             COL21, ",
                    "       NULL                                                             COL22, ",
                    "       NULL                                                             COL23, ",
                    --"       DECODE(AP.DZAP001,NULL,'',DECODE(AP.DZAP010,'Y','',NVL(AP.DZAP010,'N')))  COL24, ", #161027-00001 
                    --"       DECODE(AQ.DZAQ001,NULL,'',DECODE(AQ.DZAQ010,'Y','',NVL(AQ.DZAQ010,'N')))  COL25  ", #161027-00001 
                    "       DECODE(AP.DZAP001,NULL,'',AP.DZAP010)                            COL24, ", #161027-00001 
                    "       DECODE(AQ.DZAQ001,NULL,'',AQ.DZAQ010)                            COL25  ", #161027-00001 
                    "  FROM GZJA_T ZJA                                                              ",
                    "  LEFT OUTER JOIN GZJAL_T JAL ON JAL.GZJAL001 = ZJA.GZJA001                    ",
                    "                             AND JAL.GZJAL002 = '",ms_lang,"'                  ",
                    "  LEFT OUTER JOIN DZAP_T AP ON AP.DZAP001 = ZJA.GZJA001                        ", 
                    "  LEFT OUTER JOIN DZAQ_T AQ ON AQ.DZAQ001 = ZJA.GZJA001                        ", #161027-00001  
                    "  LEFT OUTER JOIN (                                                            ", 
                    ms_dzaf_t_s_view,                                                        
                    "                  ) SAF                                                        ", 
                    "                  ON SAF.SDZAF001 = ZJA.GZJA001                                ", 
                    "  LEFT OUTER JOIN (                                                            ", 
                    ms_dzaf_t_c_view,                                                        
                    "                  ) CAF                                                        ", 
                    "                  ON CAF.CDZAF001 = ZJA.GZJA001                                ",
                    "  LEFT OUTER JOIN (                                                            ", 
                    ms_gzzj_t_view,                                                          
                    "                  ) OZJ                                                        ", 
                    "                  ON OZJ.GZZJ003 = ZJA.GZJA002                                 ", 
                    " WHERE 1=1                                                                     ",
                    "   AND ZJA.GZJA002 NOT IN (",ms_exclude_module,")                              ", #2014/12/03 by Hiko
                    ls_gzja_sql_cond                                                         
 
  #Q類(開窗元件)                    
  LET ls_dzca_sql = "SELECT DISTINCT                                                                ",
                    "       ''                                                               COL01, ",
                    "       'N'                                                              COL02, ",
                    "       'N'                                                              COL03, ",
                    "       ZCA.DZCA007                                                      COL04, ",
                    "       DECODE(ZCA.DZCA002,'",cs_dgenv_customize,"',NVL(OZJ.GZZJ001,OZJ.GZZJ003),DECODE(CAF.CDZAF010,'",cs_dgenv_customize,"',NVL(OZJ.GZZJ001,OZJ.GZZJ003),OZJ.GZZJ003)) COL05, ",
                    "       NVL(OZJ.GZZJ001,OZJ.GZZJ003)                                     COL06, ",
                    "       'Q'                                                              COL07, ",
                    "       ZCA.DZCA001                                                      COL08, ",
                    "       CAL.DZCAL003                                                     COL09, ",
                    "       ''                                                               COL10, ",
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF002,CAF.CDZAF002)              COL11, ", 
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF003,CAF.CDZAF003)              COL12, ",
                    "       DECODE( '",ls_erpalm,"','Y','R','W')                             COL13, ", 
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF004,CAF.CDZAF004)              COL14, ",
                    "       DECODE( '",ls_erpalm,"','Y','R','W')                             COL15, ", 
                    "       0                                                                COL16, ", 
                    "       DECODE(CAF.CDZAF001,NULL,SAF.SDZAF010,CAF.CDZAF010)              COL17, ",
                    "       NULL                                                             COL18, ",
                    "       NULL                                                             COL19, ",
                    "       NULL                                                             COL20, ",
                    "       NULL                                                             COL21, ",
                    "       NULL                                                             COL22, ",
                    "       NULL                                                             COL23, ",
                    --"       DECODE(AP.DZAP001,NULL,'',DECODE(AP.DZAP010,'Y','',NVL(AP.DZAP010,'N')))  COL24, ", #161027-00001 
                    --"       DECODE(AQ.DZAQ001,NULL,'',DECODE(AQ.DZAQ010,'Y','',NVL(AQ.DZAQ010,'N')))  COL25  ", #161027-00001 
                    "       DECODE(AP.DZAP001,NULL,'',AP.DZAP010)                            COL24, ", #161027-00001 
                    "       DECODE(AQ.DZAQ001,NULL,'',AQ.DZAQ010)                            COL25  ", #161027-00001 
                    "  FROM DZCA_T ZCA                                                              ",
                    "  LEFT OUTER JOIN DZCAL_T CAL ON CAL.DZCAL001 = ZCA.DZCA001                    ",
                    "                             AND CAL.DZCAL002 = '",ms_lang,"'                  ",
                    "  LEFT OUTER JOIN DZAP_T AP ON AP.DZAP001 = ZCA.DZCA001                        ", 
                    "  LEFT OUTER JOIN DZAQ_T AQ ON AQ.DZAQ001 = ZCA.DZCA001                        ", #161027-00001 
                    "  LEFT OUTER JOIN (                                                            ", 
                    ms_dzaf_t_s_view,                                                        
                    "                  ) SAF                                                        ", 
                    "                  ON SAF.SDZAF001 = ZCA.DZCA001                                ", 
                    "  LEFT OUTER JOIN (                                                            ", 
                    ms_dzaf_t_c_view,                                                        
                    "                  ) CAF                                                        ", 
                    "                  ON CAF.CDZAF001 = ZCA.DZCA001                                ",
                    "  LEFT OUTER JOIN (                                                            ", 
                    ms_gzzj_t_view,                                                          
                    "                  ) OZJ                                                        ", 
                    "                  ON OZJ.GZZJ003 = 'QRY'                                       ", 
                    " WHERE 1=1                                                                     ",
                    "   AND ZCA.DZCA006 = 'Y'                                                       ",
                    ls_dzca_sql_cond
                    
  #BEGIN:20160330 by ernest
  IF ms_erpalm = "Y" THEN
    LET ls_sql_alm = " AND EXISTS (                                ",
                     "              SELECT 1                       ",
                     "                FROM DZLU_T LU               ",
                     "               WHERE LU.DZLU003 = LM.DZLM012 ",
                     "            )                                "
                      
  ELSE
    LET ls_sql_alm = ""
  END IF
  #END:20160330 by ernest
                    
  #判斷抓取在 dzlm 中沒有的版本
  LET ls_dzlm_sql = "AND NOT EXISTS (                                         ",
                    "                 SELECT 1                                ",
                    "                   FROM DZLM_T LM                        ",
                    "                  WHERE LM.DZLM001 <> 'T'                ",    
                    "                    AND LM.DZLM002 = COLS.COL08          ",
                    --"                    AND LM.DZLM004 = COLS.COL05          ",
                    "                    AND (                                ", 
                    "                          (LM.DZLM007 = '",ms_user,"' AND LM.DZLM008 = 'O' AND 'SD' = '",sadzp50_get_download_match_type(ls_download_type),"') ",
                    "                          OR                             ",
                    "                          (LM.DZLM010 = '",ms_user,"' AND LM.DZLM011 = 'O' AND 'PR' = '",sadzp50_get_download_match_type(ls_download_type),"') ",
                    "                        )                                ",
                    "                    AND LM.DZLM017 IS NULL               ",
                    ls_sql_alm, #20160330 by ernest
                    "               )                                         "

  LET ls_exclude_sql = "  AND NOT EXISTS (                                                ",
                       "                   SELECT 1                                       ",
                       "                     FROM GZZI_T ZI                               ",
                       "                    WHERE ZI.GZZI001 = COLS.COL08                 ",
                       "                 )                                                "
                       
  LET ls_sql = ls_cols_sql,
               ls_gzza_sql,
               " UNION ALL ",
               ls_gzde_sql,
               " UNION ALL ",
               ls_gzdf_de_sql,
               " UNION ALL ",
               ls_gzdf_za_sql,
               " UNION ALL ",
               ls_gzja_sql,
               " UNION ALL ",
               ls_dzca_sql,
               "ORDER BY 5,7,8",
               ls_cols_sql_cond,
               ls_cols_sql_download_cond,
               ls_module_sql_cond,
               ls_dzlm_sql,
               ls_exclude_sql,
               ls_sql_view_mergeable,
               ls_sql_view_std_to_cust #161028-00001

  #170124-00031 begin             
  IF mb_initial_run THEN
    LET ls_sql = "SELECT ROWNUM ROW_NUM, COLS.* FROM (                                                                 ",
                 "                                      SELECT NULL COL01,NULL COL02,NULL COL03,NULL COL04,NULL COL05, ",   
                 "                                             NULL COL06,NULL COL07,NULL COL08,NULL COL09,NULL COL10, ",  
                 "                                             NULL COL11,NULL COL12,NULL COL13,NULL COL14,NULL COL15, ",  
                 "                                             NULL COL16,NULL COL17,NULL COL18,NULL COL19,NULL COL20, ",  
                 "                                             NULL COL21,NULL COL22,NULL COL23,NULL COL24,NULL COL25  ",  
                 "                                        FROM DUAL                                                    ",
                 "                                   ) COLS WHERE 1=2                                                  "
  END IF
  #170124-00031 end
  
  IF mb_debug THEN
    DISPLAY "\n",
            "****************************** begin Main SQL ******************************","\n",
            ls_sql,"\n",
            "******************************* end Main SQL *******************************","\n"
  END IF

  RETURN ls_sql
  
END FUNCTION

FUNCTION adzp050_fill_demand_list(p_erpalm,p_user,p_module_name,p_spec_type,p_download_type,p_search)  #20151130 by elena  add p_search
DEFINE 
  p_erpalm        STRING,
  p_user          STRING,
  p_module_name   STRING,
  p_spec_type     STRING,
  p_download_type STRING,
  p_search        STRING   #20151130 by elena
DEFINE 
  ls_erpalm          STRING,
  ls_user            STRING,
  ls_module_name     STRING,
  ls_spec_type       STRING,
  ls_download_type   STRING,
  ls_search          STRING, #20151130 by elena
  ls_rtn_like        STRING,
  ls_rtn_escape      STRING, 
  ls_dzlm_sql_cond   STRING,
  ls_main_sql        STRING,  
  ls_cols_sql        STRING,
  ls_cols_sql_cond   STRING,
  ls_cols_sql_download_cond STRING,
  ls_module_sql_cond STRING,
  ls_DGENV           STRING, 
  ls_sql             STRING,
  ls_sql_alm         STRING, #20160330 by ernest
  ls_sql_view_std_to_cust STRING, #161028-00001
  li_count           INTEGER 

  LET ls_erpalm        = p_erpalm
  LET ls_user          = p_user
  LET ls_module_name   = p_module_name
  LET ls_spec_type     = p_spec_type
  LET ls_download_type = p_download_type
  LET ls_search        = p_search  #20151130 by elena  

  LET ls_DGENV = ms_DGENV

  #先排除條件中有跳脫碼的資料
  #CALL adzp050_get_cond_with_escape(ls_module_name) RETURNING ls_rtn_like,ls_rtn_escape
  CALL adzp050_get_cond_with_escape(ls_search) RETURNING ls_rtn_like,ls_rtn_escape

  IF NVL(ls_spec_type,"!@#") <> "!@#" THEN
    LET ls_cols_sql = "SELECT ROWNUM ROW_NUM, COLS.* FROM ( "
    LET ls_cols_sql_cond = " ) COLS WHERE COLS.COL06 = '",ls_spec_type,"'"
  ELSE
    LET ls_cols_sql = "SELECT ROWNUM ROW_NUM, COLS.* FROM ( "
    LET ls_cols_sql_cond = " ) COLS WHERE 1=1 "
  END IF

  #過濾下載清單為 SPEC 或是 CODE
  #非同時下載SPEC或CODE時使用
  IF NOT mb_download_all THEN
    IF ls_download_type.toUpperCase() = cs_download_type_spec THEN
       IF ls_spec_type IS NOT NULL THEN
          LET ls_cols_sql_download_cond = " AND COLS.COL06 IN ('", ls_spec_type ,"')"
       ELSE
          LET ls_cols_sql_download_cond = " AND COLS.COL06 IN ('B','M','S','G','X','Q','F','W','Z')"
       END IF
    END IF 
    IF ls_download_type.toUpperCase() = cs_download_type_code THEN
      IF ls_spec_type IS NOT NULL THEN
         LET ls_cols_sql_download_cond = " AND COLS.COL06 IN ('", ls_spec_type ,"')"
      ELSE
         LET ls_cols_sql_download_cond = " AND COLS.COL06 IN ('B','M','S','G','X','Q','W','Z')"
      END IF
    END IF 
    IF ls_download_type.toUpperCase() = cs_download_type_4rp THEN
      IF ls_spec_type IS NOT NULL THEN
         LET ls_cols_sql_download_cond = " AND COLS.COL06 IN ('", ls_spec_type ,"')"
      ELSE
         LET ls_cols_sql_download_cond = " AND COLS.COL06 IN ('R','G')"
      END IF
    END IF 
  ELSE 
    LET ls_cols_sql_download_cond = ""  
  END IF
 
  #BEGIN:20151130 by elena 調整查詢條件
  IF ls_module_name IS NULL AND ls_rtn_like IS NULL THEN
    LET ls_module_sql_cond = " AND 1=1 "
  ELSE

    IF ls_module_name IS NOT NULL THEN
    #IF ls_module_name IS NOT NULL OR ls_rtn_like IS NOT NULL THEN
      LET ls_module_sql_cond = " AND (          ",
                               "          COLS.COL05 = '",ls_module_name.toUpperCase(),"'  ",
                              # "       OR COLS.COL05 LIKE '%",ls_rtn_like.toUpperCase(),"%'",ls_rtn_escape,
                              # "       OR COLS.COL07 LIKE '%",ls_rtn_like.toLowerCase(),"%'",ls_rtn_escape,
                              # "       OR COLS.COL08 LIKE '%",ls_rtn_like,"%'",ls_rtn_escape,
                               "     )          "

    END IF

    IF ls_rtn_like IS NOT NULL THEN
      LET ls_module_sql_cond = ls_module_sql_cond, "AND (        ",
                                                   "       COLS.COL05 LIKE '%",ls_rtn_like.toUpperCase(),"%'",ls_rtn_escape,
                                                   "       OR COLS.COL07 LIKE '%",ls_rtn_like.toLowerCase(),"%'",ls_rtn_escape,
                                                   "       OR COLS.COL08 LIKE '%",ls_rtn_like,"%'",ls_rtn_escape,
                                                   "     )          "

    END IF
    #ELSE
    #  LET ls_module_sql_cond = " AND 1=1 "
    #END IF
  END IF
  #END:20151130 by elena 
#  { 
#  IF ls_module_name IS NULL THEN
#    LET ls_dzlm_sql_cond = " AND 1=1 "
#  ELSE
#    LET ls_dzlm_sql_cond = "AND (                                                      ",                                           
#                           "         LM.DZLM004 = '",ls_module_name.toUpperCase(),"'   ",                 
#                           "      OR LM.DZLM004 LIKE '%",ls_rtn_like.toUpperCase(),"%' ",ls_rtn_escape,   
#                           "      OR LM.DZLM002 LIKE '%",ls_rtn_like.toLowerCase(),"%' ",ls_rtn_escape,   
#                           "      OR LM.DZLM003 LIKE '%",ls_rtn_like,"%'               ",ls_rtn_escape,   
#                           "    )                                                      "                                            
#  END IF
#  }


  #BEGIN:20151130 by elena:查詢條件調整

  IF ls_module_name IS NULL AND ls_rtn_like IS NULL THEN
    LET ls_dzlm_sql_cond = " AND 1=1 "
  ELSE
    IF ls_module_name IS NOT NULL THEN
      LET ls_dzlm_sql_cond = "AND LM.DZLM004 = '",ls_module_name.toUpperCase(),"'   "
 
    END IF

    IF ls_rtn_like IS NOT NULL THEN
      LET ls_dzlm_sql_cond = ls_dzlm_sql_cond, "AND (                                                      ",
                                               "      LM.DZLM004 LIKE '%",ls_rtn_like.toUpperCase(),"%' ",ls_rtn_escape,
                                               "      OR LM.DZLM002 LIKE '%",ls_rtn_like.toLowerCase(),"%' ",ls_rtn_escape,
                                               "      OR LM.DZLM003 LIKE '%",ls_rtn_like,"%'               ",ls_rtn_escape,
                                               "    ) "
    END IF
  END IF
  #END:20151130 by elena
  
  #BEGIN:20160330 by ernest
  IF ms_erpalm = "Y" THEN
    LET ls_sql_alm = " AND EXISTS (                                ",
                     "              SELECT 1                       ",
                     "                FROM DZLU_T LU               ",
                     "               WHERE LU.DZLU003 = LM.DZLM012 ",
                     "            )                                "
                      
  ELSE
    LET ls_sql_alm = ""
  END IF
  #END:20160330 by ernest

  #161028-00001 begin
  IF ms_view_std_to_cust = "Y" THEN
    LET ls_sql_view_std_to_cust = " AND EXISTS (                                           ",
                                  "              SELECT 1                                  ",
                                  "                FROM DZAF_T AF                          ",
                                  "               WHERE AF.DZAF001 = LM.DZLM002            ",
                                  "              HAVING MAX(AF.DZAF010) <> MIN(AF.DZAF010) ",
                                  "            )                                           "
  ELSE
    LET ls_sql_view_std_to_cust = ""
  END IF 
  #161028-00001 end
  
  LET ls_main_sql = " SELECT DISTINCT                                                                ",
                    "        ''                                                         COL01,       ",
                    "        'N'                                                        COL02,       ",
                    "        'N'                                                        COL03,       ",
                    "        NVL(                                                                    ",
                    "            DECODE(                                                             ",
                    "                    ZBA.GZZB002,                                                ",
                    "                    NULL,DECODE(                                                ",
                    "                                 CA.DZCA007,                                    ",
                    "                                 NULL,DECODE(                                   ",
                    "                                              JA.GZJA006,                       ",
                    "                                              NULL,NULL,                        ",
                    "                                              JA.GZJA006                        ",
                    "                                             ),CA.DZCA007                       ",
                    "                               ),ZBA.GZZB002                                    ",
                    "                  )                                                             ",
                    "           ,'",cs_industry_type_standard,"')                       COL04,       ",
                    "        LM.DZLM004                                                 COL05,       ",
                    "        DECODE(                                                                 ",
                    "                DE.GZDE001,                                                     ",
                    "                NULL,DECODE(                                                    ",
                    "                             ZA.GZZA001,                                        ",
                    "                             NULL,DECODE(                                       ",
                    "                                          ZDF.GZDF002,                          ",
                    "                                          NULL,DECODE(                          ",
                    "                                                       JA.GZJA001,              ",
                    "                                                       NULL,DECODE(             ",
                    "                                                                    CA.DZCA001, ",
                    "                                                                    NULL,NULL,  ",
                    "                                                                    'Q'         ",                
                    "                                                                  ),            ",
                    "                                                       'Z'                      ",
                    "                                                     ),                         ",
                    "                                          'F'                                   ",
                    "                                        ),                                      ",
                    "                             'M'                                                ",
                    "                           ),                                                   ",
                    "                DE.GZDE003                                                      ",
                    "              )                                                    COL06,       ",
                    "        LM.DZLM002                                                 COL07,       ",
                    "        LM.DZLM003                                                 COL08,       ",
                    "        ''                                                         COL09,       ",
                    "        LM.DZLM005                                                 COL10,       ",
                    "        DECODE(                                                                 ",
                    "                LM.DZLM006,                                                     ",
                    "                NULL,                                                           ",
                    "                DECODE(CAF.CDZAF001,NULL,SAF.SDZAF003,CAF.CDZAF003),            ",
                    "                LM.DZLM006                                                      ",
                    "              )                                                    COL11,       ",
                    "        DECODE(LM.DZLM008,'O','W','R')                             COL12,       ",  
                    "        DECODE(                                                                 ",
                    "                LM.DZLM009,NULL,                                                ",
                    "                DECODE(CAF.CDZAF001,NULL,SAF.SDZAF004,CAF.CDZAF004),            ",
                    "                LM.DZLM009                                                      ",
                    "              )                                                    COL13,       ",
                    "        DECODE(LM.DZLM011,'O','W','R')                             COL14,       ",
                    "        0                                                          COL15,       ",
                    "        DECODE(CAF.CDZAF001,NULL,SAF.SDZAF010,CAF.CDZAF010)        COL16,       ",
                    "        ZBA.GZZB003                                                COL17,       ",
                    "        DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF006,ZBA.CDZAF006)        COL18,       ",
                    "        DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF005,ZBA.CDZAF005)        COL19,       ",
                    "        DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF003,ZBA.CDZAF003)        COL20,       ",
                    "        DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF004,ZBA.CDZAF004)        COL21,       ",
                    "        DECODE(ZBA.CDZAF001,NULL,ZBA.SDZAF010,ZBA.CDZAF010)        COL22,       ",
                    "        LM.DZLM012                                                 COL23,       ",
                    "        LM.DZLM013                                                 COL24,       ",
                    "        LM.DZLM014                                                 COL25,       ",
                    "        LM.DZLM015                                                 COL26,       ",
                    "        LM.DZLM018                                                 COL27,       ",
                    "        LM.DZLM019                                                 COL28,       ",
                    "        LM.DZLM020                                                 COL29,       ",
                    "        LM.DZLM021                                                 COL30,       ",
                    --"        DECODE(AP.DZAP001,NULL,'',DECODE(AP.DZAP010,'Y','',NVL(AP.DZAP010,'N')))  COL31, ", #161027-00001 
                    --"        DECODE(AQ.DZAQ001,NULL,'',DECODE(AQ.DZAQ010,'Y','',NVL(AQ.DZAQ010,'N')))  COL32  ", #161027-00001 
                    "        DECODE(AP.DZAP001,NULL,'',AP.DZAP010)                      COL31,       ", #161027-00001 
                    "        DECODE(AQ.DZAQ001,NULL,'',AQ.DZAQ010)                      COL32        ", #161027-00001 
                    "   FROM DZLM_T LM                                                               ",
                    "   LEFT OUTER JOIN GZDE_T DE ON DE.GZDE001   = LM.DZLM002                       ",
                    "   LEFT OUTER JOIN GZZA_T ZA ON ZA.GZZA001   = LM.DZLM002                       ",
                    "   LEFT OUTER JOIN GZDF_T ZDF ON ZDF.GZDF002 = LM.DZLM002                       ",
                    "   LEFT OUTER JOIN GZJA_T JA ON JA.GZJA001   = LM.DZLM002                       ",
                    "   LEFT OUTER JOIN DZCA_T CA ON CA.DZCA001   = LM.DZLM002                       ",
                    "   LEFT OUTER JOIN DZAP_T AP ON AP.DZAP001   = LM.DZLM002                       ", #161027-00001  
                    "   LEFT OUTER JOIN DZAQ_T AQ ON AQ.DZAQ001   = LM.DZLM002                       ", #161027-00001  
                    "   LEFT OUTER JOIN (                                                            ",      
                    ms_dzaf_t_o_view,                                                                
                    "                   ) ZBA                                                        ",
                    "     ON ZBA.GZZB001 = LM.DZLM002                                                ",
                    "  LEFT OUTER JOIN (                                                             ", 
                    ms_dzaf_t_s_view,                                                                
                    "                  ) SAF                                                         ", 
                    "                  ON SAF.SDZAF001 = LM.DZLM002                                  ", 
                    "  LEFT OUTER JOIN (                                                             ", 
                    ms_dzaf_t_c_view,                                                                
                    "                  ) CAF                                                         ", 
                    "                  ON CAF.CDZAF001 = LM.DZLM002                                  ", 
                    "  WHERE LM.DZLM001 <> 'T'                                                       ",
                    "    AND LM.DZLM017 IS NULL                                                      ",      
                    "    AND (                                                                       ",    
                    "          (LM.DZLM008 = 'O' AND LM.DZLM007 = '",ls_user,"' AND 'SD' = '",sadzp50_get_download_match_type(ls_download_type),"')",    
                    "          OR                                                                    ",    
                    "          (LM.DZLM011 = 'O' AND LM.DZLM010 = '",ls_user,"' AND 'PR' = '",sadzp50_get_download_match_type(ls_download_type),"')",    
                    "        )                                                                       ",    
                    ls_dzlm_sql_cond,
                    ls_sql_alm, #20160330 by ernest
                    ls_sql_view_std_to_cust, #161028-00001 
                    "  ORDER BY 5,7                                                                  "     
    

  LET ls_sql = ls_cols_sql,
               ls_main_sql,
               ls_cols_sql_cond,
               ls_cols_sql_download_cond,
               ls_module_sql_cond
               
  IF mb_debug THEN
    DISPLAY "\n",
            "****************************** begin ALM Main SQL ******************************","\n",
            ls_sql,"\n",
            "******************************* end ALM Main SQL *******************************","\n"
  END IF 
  
  CALL m_demand_list.clear()  
  CALL m_demand_list_color.clear()  
   
  PREPARE lpre_demand_list FROM ls_sql
  DECLARE lcur_demand_list CURSOR FOR lpre_demand_list

  CALL m_demand_list.clear()
  
  LET li_count = 1
  
  FOREACH lcur_demand_list INTO m_demand_list[li_count].*    
    #Begin:2014/08/25 by Hiko:客戶沒有行業別的開發需求,所以要將原本行業別對應的標準程式相關都改成和行業別代號相同.
    IF mb_customize THEN
       LET m_demand_list[li_count].origin_prog = m_demand_list[li_count].prog_name
       LET m_demand_list[li_count].origin_module = m_demand_list[li_count].module_name
       LET m_demand_list[li_count].origin_spec_type = m_demand_list[li_count].spec_type
       LET m_demand_list[li_count].origin_sd_ver = m_demand_list[li_count].sd_ver
       LET m_demand_list[li_count].origin_pg_ver = m_demand_list[li_count].pg_ver
       LET m_demand_list[li_count].origin_identity = m_demand_list[li_count].identity
    END IF
    #Begin:2014/08/25 by Hiko
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    {
    IF m_demand_list[li_count].sd_read_write = "W" THEN
      LET m_demand_list_color[li_count].sd_ver = "green reverse"
    ELSE   
      LET m_demand_list_color[li_count].sd_ver = NULL
    END IF 
    
    IF m_demand_list[li_count].pg_read_write = "W" THEN
      LET m_demand_list_color[li_count].pg_ver = "green reverse"
    ELSE   
      LET m_demand_list_color[li_count].pg_ver = NULL
    END IF
    }
    
    LET li_count = li_count + 1
    
  END FOREACH
  CALL m_demand_list.deleteElement(li_count)

END FUNCTION


FUNCTION adzp050_generate_tsd_file(p_prog_name, p_module_name, p_spec_type, p_sd_version,p_pr_version,p_std_program,p_std_sd_version,p_std_pr_version,p_dgenv)
DEFINE
  p_prog_name      STRING,
  p_module_name    STRING,
  p_spec_type      STRING,
  p_sd_version     STRING,
  p_pr_version     STRING,
  p_std_program    STRING,
  p_std_sd_version STRING,
  p_std_pr_version STRING,
  p_dgenv          STRING  
DEFINE 
  ls_prog_name      STRING,
  ls_module_name    STRING,
  ls_spec_type      STRING,
  ls_sd_version     STRING,
  ls_pr_version     STRING,
  ls_std_program    STRING,
  ls_std_sd_version STRING,
  ls_std_pr_version STRING,
  ls_dgenv          STRING,  
  ls_run_cmd        STRING,
  ls_message        STRING,
  lb_result         BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET ls_prog_name      = p_prog_name
  LET ls_module_name    = p_module_name
  LET ls_spec_type      = p_spec_type
  LET ls_sd_version     = p_sd_version
  LET ls_pr_version     = p_pr_version
  LET ls_std_program    = p_std_program
  LET ls_std_sd_version = p_std_sd_version
  LET ls_std_pr_version = p_std_pr_version
  LET ls_dgenv          = p_dgenv

  LET ms_running_process = 'sadzp040_util_generate_tsd'
  
  CALL adzp050_show_message_designer()

  LET ls_message = "Calling function ..."
  CALL adzp050_show_process_message(ls_message)
  
  CALL sadzp040_util_generate_tsd(ls_prog_name,ls_module_name,ls_sd_version,ls_spec_type,ls_std_program,ls_std_sd_version,ls_DGENV) RETURNING lb_result
  
  IF NOT lb_result THEN
    DISPLAY cs_error_tag,ls_message
  END IF 

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_generate_rsd_file(p_prog_name, p_module_name, p_spec_type, p_version,p_dgenv)
DEFINE
  p_prog_name   STRING,
  p_module_name STRING,
  p_spec_type   STRING,
  p_version     STRING,
  p_dgenv       STRING
DEFINE 
  ls_prog_name   STRING,
  ls_module_name STRING,
  ls_spec_type   STRING,
  ls_version     STRING,
  ls_dgenv       STRING,
  ls_run_cmd     STRING,
  ls_message     STRING,
  lb_result      BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET ls_prog_name   = p_prog_name
  LET ls_module_name = p_module_name
  LET ls_spec_type   = p_spec_type
  LET ls_version     = p_version
  LET ls_dgenv       = p_dgenv

  LET ms_running_process = 'adzp050_generate_rsd_file'
  
  CALL adzp050_show_message_designer()

  LET ls_message = "Calling function ..."
  CALL adzp050_show_process_message(ls_message)
  
  LET ls_run_cmd = "CALL sadzp030_tsd_gen_rsd : ","\n",
                   "           Program Name -> '",ls_prog_name,"'\n",
                   "            Module Name -> '",ls_module_name,"'\n",
                   "               Revision -> '",ls_version,"'\n",
                   "                   Type -> '",ls_spec_type,"\n",
                   "                  DGENV -> '",ls_dgenv,"'" 
  CALL adzp050_get_debug_info(ls_run_cmd)
  DISPLAY cs_parameter_tag,ls_run_cmd

  CALL sadzp030_tsd_gen_rsd(ls_prog_name, ls_module_name, ls_version, ls_spec_type, ls_dgenv) RETURNING lb_result
  
  IF NOT lb_result THEN
    DISPLAY cs_error_tag,ls_message
  END IF 

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_generate_csd_file(p_prog_name, p_module_name, p_spec_type, p_version,p_dgenv)
DEFINE
  p_prog_name   STRING,
  p_module_name STRING,
  p_spec_type   STRING,
  p_version     STRING,
  p_dgenv       STRING
DEFINE 
  ls_prog_name   STRING,
  ls_module_name STRING,
  ls_spec_type   STRING,
  ls_version     STRING,
  ls_dgenv       STRING,
  ls_run_cmd     STRING,
  ls_message     STRING,
  lb_result      BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET ls_prog_name   = p_prog_name
  LET ls_module_name = p_module_name
  LET ls_spec_type   = p_spec_type
  LET ls_version     = p_version
  LET ls_dgenv       = p_dgenv

  LET ms_running_process = 'adzp050_generate_csd_file'
  
  CALL adzp050_show_message_designer()

  LET ls_message = "Calling function ..."
  CALL adzp050_show_process_message(ls_message)
  
  LET ls_run_cmd = "CALL sadzp040_1_gen_csd : ","\n",
                   "           Program Name -> '",ls_prog_name,"'\n",
                   "            Module Name -> '",ls_module_name,"'\n",
                   "               Revision -> '",ls_version,"'\n",
                   "                   Type -> '",ls_spec_type,"\n",
                   "                  DGENV -> '",ls_dgenv,"'"
                   
  CALL adzp050_get_debug_info(ls_run_cmd)
  DISPLAY cs_parameter_tag,ls_run_cmd
  
  CALL sadzp040_1_gen_csd(ls_prog_name, ls_module_name, ls_version, ls_spec_type, ls_dgenv) RETURNING lb_result
  IF NOT lb_result THEN
    DISPLAY cs_error_tag,ls_message
  END IF 

  LET lb_return = lb_result
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_parse_4fd(p_prog_name, p_module_name, p_version, p_dgenv)
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

    CALL adzp050_get_debug_info(ls_debug_info)
    DISPLAY cs_parameter_tag,ls_debug_info
    CALL sadzp168_3(ls_module_name, ls_prog_name,ls_version,ls_dgenv) RETURNING lb_result,ls_retinfo
    DISPLAY cs_message_tag,ls_retinfo
  CATCH
    LET lb_result = FALSE
  END TRY  
  
  IF NOT lb_result THEN
    DISPLAY "[",ls_err_no,"]",cl_getmsg(ls_err_no, ms_lang)
  END IF
  
  RETURN lb_result    
  
END FUNCTION

FUNCTION adzp050_generate_tab(p_prog_name,p_version,p_dgenv)
DEFINE
  p_prog_name STRING,
  p_version   STRING,
  p_dgenv     STRING
DEFINE
  ls_prog_name     STRING,
  ls_version       STRING,
  ls_dgenv         STRING,
  ls_message       STRING,
  ls_form_style    STRING,
  ls_debug_info    STRING,
  lb_result        BOOLEAN

  LET ls_prog_name = p_prog_name
  LET ls_version   = p_version
  LET ls_dgenv     = p_dgenv
  
  LET lb_result = TRUE

  LET ms_running_process = 'adzp050_generate_tab'
  
  CALL adzp050_show_message_generator()
  
  {
  #呼叫adzp030_1產出 tab 檔案 
  CALL adzp050_get_program_type(ls_prog_name) RETURNING lo_program_type.*
  
  IF lo_program_type.temp_name IS NULL THEN
    LET lb_result  = FALSE
    LET ls_message = "Error : Can't find templete define by program : ",ls_prog_name," in DZFQ_T, can't generate TAB file."
  ELSE  
  }

  LET ls_message = "Calling function ..."
  CALL adzp050_show_process_message(ls_message)
  
  LET ls_message = "CALL sadzp030_tab_gen()"
  DISPLAY cs_information_tag,ls_message
  
  LET ls_form_style = "" #2014.03.12 改為不傳遞 Form Style
  #LET ls_version = "1"
  #CALL adzp050_get_form_style(ls_prog_name,ls_version) RETURNING ls_form_style
  LET ls_debug_info = "Call sadzp030_tab_gen : Program Name -> ",ls_prog_name,"\n",
                      "                        Form Style   -> ",ls_form_style,"\n",
                      "                        Version      -> ",ls_version,"\n",
                      "                        DGENV        -> ",ls_dgenv
  DISPLAY cs_parameter_tag,ls_debug_info
  CALL sadzp030_tab_gen(ls_prog_name,ls_version,ls_form_style,ls_dgenv) RETURNING lb_result
  CALL adzp050_get_debug_info(ls_debug_info)
  
  {
  END IF
  }
  
  IF NOT lb_result THEN
    DISPLAY cs_error_tag,ls_message
    CALL sadzp000_msg_show_error(ls_message, "adz-00038", NULL, 1)
  END IF
  
  RETURN lb_result
  
END FUNCTION

FUNCTION adzp050_generate_code_4gl(p_prog_name, p_module_name,p_version,p_dgenv, p_rc3_type)
DEFINE
  p_prog_name   STRING,
  p_module_name STRING,
  p_version     STRING,
  p_dgenv       STRING,
  p_rc3_type    STRING #2015/11/09 by Hiko:r.c3第四參數的類型
DEFINE 
  ls_prog_name         STRING,
  ls_module_name       STRING,
  ls_version           STRING,
  ls_dgenv             STRING,
  ls_run_cmd           STRING,
  lb_result            BOOLEAN,
  ls_message           STRING,
  ls_parameters        STRING,
  ls_prev_working_path STRING,
  ls_curr_working_path STRING
DEFINE
  lb_return  BOOLEAN  

  LET ls_prog_name   = p_prog_name
  LET ls_module_name = p_module_name
  LET ls_version     = p_version 
  LET ls_dgenv       = p_dgenv
  
  LET ms_running_process = 'adzp050_generate_code_4gl'
  
  CALL adzp050_show_message_generator()

  LET ls_message = "Calling command ..."
  CALL adzp050_show_process_message(ls_message)
  
  CALL os.Path.pwd() RETURNING ls_prev_working_path
  LET ls_curr_working_path = os.Path.join(FGL_GETENV(ls_module_name.toUpperCase()),"4gl")
  CALL adzp050_change_working_path(ls_curr_working_path)

  #第四個參數為 0 表示全部做完編譯以下的事情.
  #第四個參數為 1 表示做完產生與組合,但不做編譯和鏈結.
  #第四個參數為 2 表示只做組合器以後的事:包含編譯和鏈結.
  #第四個參數為 3 表示只做組合器以後的事:不做編譯和鏈結. #2015/11/09 by Hiko
  LET ls_parameters = ls_prog_name," ","''"," ",ls_version," ",p_rc3_type," ",ls_dgenv
  
  LET ls_run_cmd = "r.c3"," ",ls_parameters
  CALL adzp050_get_debug_info(ls_run_cmd)
  
  LET ls_message = cs_command_tag," ",ls_run_cmd
  DISPLAY cs_information_tag,ls_message
  
  CALL cl_cmdrun_openpipe("r.c3",ls_run_cmd,TRUE) RETURNING lb_result,ls_message
  IF NOT lb_result THEN
    DISPLAY cs_error_tag,ls_message
    CALL adzp050_rev_view_logresult(ls_message)
  END IF 
    
  CALL adzp050_change_working_path(ls_prev_working_path)

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_compile_4gl(p_prog_name, p_module_name)
DEFINE
  p_prog_name   STRING,
  p_module_name STRING
DEFINE 
  ls_prog_name         STRING,
  ls_module_name       STRING,
  ls_run_cmd           STRING,
  lb_result            BOOLEAN,
  ls_message           STRING,
  ls_parameters        STRING,
  ls_prev_working_path STRING,
  ls_curr_working_path STRING
DEFINE
  lb_return  BOOLEAN  

  LET ls_prog_name   = p_prog_name
  LET ls_module_name = p_module_name
  
  LET ms_running_process = 'adzp050_compile_4gl'
  
  CALL os.Path.pwd() RETURNING ls_prev_working_path
  LET ls_curr_working_path = os.Path.join(FGL_GETENV(ls_module_name.toUpperCase()),"4gl")
  CALL adzp050_change_working_path(ls_curr_working_path)

  LET ls_parameters = ls_prog_name
  
  LET ls_run_cmd = "r.c"," ",ls_parameters
  
  LET ls_message = cs_command_tag," ",ls_run_cmd
  DISPLAY ls_message
  
  CALL cl_cmdrun_openpipe("r.c",ls_run_cmd,TRUE) RETURNING lb_result,ls_message
  IF NOT lb_result THEN
    DISPLAY cs_error_tag,ls_message
  END IF 
    
  CALL adzp050_change_working_path(ls_prev_working_path)

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_link_4gl(p_prog_name, p_module_name)
DEFINE
  p_prog_name   STRING,
  p_module_name STRING
DEFINE 
  ls_prog_name         STRING,
  ls_module_name       STRING,
  ls_run_cmd           STRING,
  lb_result            BOOLEAN,
  ls_message           STRING,
  ls_parameters        STRING,
  ls_prev_working_path STRING,
  ls_curr_working_path STRING
DEFINE
  lb_return  BOOLEAN  

  LET ls_prog_name   = p_prog_name
  LET ls_module_name = p_module_name
  
  LET ms_running_process = 'adzp050_link_4gl'
  
  CALL os.Path.pwd() RETURNING ls_prev_working_path
  LET ls_curr_working_path = os.Path.join(FGL_GETENV(ls_module_name.toUpperCase()),"4gl")
  CALL adzp050_change_working_path(ls_curr_working_path)

  LET ls_parameters = ls_prog_name
  
  LET ls_run_cmd = "r.l"," ",ls_parameters
  
  LET ls_message = cs_command_tag," ",ls_run_cmd
  DISPLAY ls_message
  
  CALL cl_cmdrun_openpipe("r.l",ls_run_cmd,TRUE) RETURNING lb_result,ls_message
  IF NOT lb_result THEN
    DISPLAY cs_error_tag,ls_message
  END IF 
    
  CALL adzp050_change_working_path(ls_prev_working_path)

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_generate_tap_file(p_prog_name,p_module_name,p_version,p_std_prog_name,p_std_version,p_spec_type,p_dgenv)
DEFINE
  p_prog_name     STRING,
  p_module_name   STRING,
  p_version       STRING,
  p_std_prog_name STRING,
  p_std_version   STRING,
  p_spec_type     STRING,
  p_dgenv         STRING
DEFINE 
  ls_prog_name     STRING,
  ls_module_name   STRING,
  ls_version       STRING,
  ls_std_prog_name STRING,
  ls_std_version   STRING,
  ls_spec_type     STRING,
  ls_dgenv         STRING,
  ls_run_cmd       STRING,
  ls_message       STRING,
  lb_result        BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET ls_prog_name     = p_prog_name
  LET ls_module_name   = p_module_name
  LET ls_version       = p_version
  LET ls_std_prog_name = p_std_prog_name
  LET ls_std_version   = p_std_version
  LET ls_spec_type     = p_spec_type
  LET ls_dgenv         = p_dgenv

  LET ms_running_process = 'adzp050_generate_tap_file'
  
  CALL adzp050_show_message_designer()
  
  LET ls_message = "Running command ..."
  CALL adzp050_show_process_message(ls_message)
  
  LET ls_run_cmd = "r.r adzp110 '",ls_prog_name,"' '",ls_module_name.toLowerCase(),"' '",ls_version,"' '",ls_std_prog_name,"' '",ls_std_version,"' '",ls_spec_type,"' '",ls_dgenv,"'"
  CALL adzp050_get_debug_info(ls_run_cmd)

  LET ls_message = cs_command_tag," ",ls_run_cmd
  DISPLAY cs_command_tag,ls_message
  
  CALL cl_cmdrun_openpipe("r.r adzp110",ls_run_cmd,TRUE) RETURNING lb_result,ls_message
  IF NOT lb_result THEN
    DISPLAY cs_error_tag,ls_message
    CALL adzp050_rev_view_logresult(ls_message)
  END IF 

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_get_form_style(p_prog_name,p_ver)
DEFINE
  p_prog_name  STRING,
  p_ver        STRING 
DEFINE
  ls_prog_name  STRING,
  ls_ver        STRING, 
  ls_sql        STRING,
  ls_form_style VARCHAR(50),
  ls_return     STRING

  LET ls_prog_name = p_prog_name
  LET ls_ver       = p_ver

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

FUNCTION adzp050_get_program_type(p_program_name)
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

FUNCTION adzp050_set_window_title(p_spec_type)
DEFINE
  p_spec_type VARCHAR(10) 
DEFINE
  ls_spec_type    STRING,
  ls_zone         STRING,
  ls_form_title   STRING,
  ls_window_title STRING

  LET ls_spec_type = NVL(p_spec_type,cs_download_type_all)
  
  CALL FGL_GETENV("ZONE") RETURNING ls_zone

  LET ls_window_title = " [ Zone：",ls_zone," ] [ User：",ms_user," ] [ Download Type：",ls_spec_type," ]"
  
  CALL ui.Interface.getText() RETURNING ls_form_title
  LET ls_form_title = ls_form_title,ls_window_title
  
  CALL FGL_SETTITLE(ls_form_title)

END FUNCTION

FUNCTION adzp050_start_spec_designer(ps_program,ps_ext_name)
DEFINE
  ps_program  STRING,
  ps_ext_name STRING
DEFINE 
  ls_path   STRING, 
  li_result INTEGER
  
  LET ls_path = "\"",cs_default_client_path,ps_program,".",ps_ext_name,"\""
  #DISPLAY "ls_path:",ls_path
  CALL ui.Interface.frontCall("standard", "execute", [ls_path,1], [li_result])
  
END FUNCTION

FUNCTION adzp050_get_download_file_counts()
DEFINE
  ls_sql         STRING,
  ls_file_counts VARCHAR(10), 
  li_return      INTEGER

  LET ls_sql = "SELECT EJ.DZEJ005  FileCounts            ",
               "  FROM DZEJ_T EJ                         ",
               " WHERE EJ.DZEJ001 = 'adzp050_parameters' ",
               "   AND EJ.DZEJ003 = 'Program'            ",
               "   AND EJ.DZEJ004 = 'FileCounts'         "
                              
  PREPARE lpre_get_download_file_counts FROM ls_sql
  DECLARE lcur_get_download_file_counts CURSOR FOR lpre_get_download_file_counts

  OPEN lcur_get_download_file_counts
  FETCH lcur_get_download_file_counts INTO ls_file_counts
  CLOSE lcur_get_download_file_counts
  
  FREE lpre_get_download_file_counts
  FREE lcur_get_download_file_counts  

  LET li_return = NVL(ls_file_counts,"0")
  
  RETURN li_return
  
END FUNCTION

FUNCTION adzp050_get_4fd_exists(p_prog_name,p_module_name)
DEFINE 
  p_prog_name   STRING,
  p_module_name STRING
DEFINE
  ls_prog_name   STRING,
  ls_module_name STRING,
  ls_module_path STRING,
  ls_4fd_path    STRING,
  ls_4fd_name    STRING,
  lb_exist_4fd   BOOLEAN
DEFINE
  lb_return BOOLEAN  
  
  LET ls_prog_name   = p_prog_name
  LET ls_module_name = p_module_name

  LET ls_module_path = FGL_GETENV(ls_module_name)
  LET ls_4fd_path    = os.Path.join(ls_module_path,"4fd")
  LET ls_4fd_name    = os.Path.join(ls_4fd_path,ls_prog_name||".4fd")

  CALL os.Path.exists(ls_4fd_name) RETURNING lb_exist_4fd

  LET lb_return = lb_exist_4fd

  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_check_dzaq_if_exist(p_prog_name)
DEFINE
  p_prog_name  STRING
DEFINE
  ls_prog_name  STRING,
  lb_return     BOOLEAN,
  ls_sql        STRING,
  li_rec_count  INTEGER,
  lv_dzaq010    VARCHAR(5)

  LET ls_prog_name = p_prog_name

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                        ",
               "  FROM DZAQ_T AQ                       ",
               " WHERE AQ.DZAQ001 = '",ls_prog_name,"' "
 
  PREPARE lpre_check_dzaq_if_exist FROM ls_sql
  DECLARE lcur_check_dzaq_if_exist CURSOR FOR lpre_check_dzaq_if_exist
  OPEN lcur_check_dzaq_if_exist
  FETCH lcur_check_dzaq_if_exist INTO li_rec_count
  CLOSE lcur_check_dzaq_if_exist
  FREE lcur_check_dzaq_if_exist
  FREE lpre_check_dzaq_if_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_check_dzaq_if_synced(p_prog_name)
DEFINE
  p_prog_name  STRING
DEFINE
  ls_prog_name  STRING,
  lb_return     BOOLEAN,
  ls_sql        STRING,
  lv_dzaq010    VARCHAR(5)

  LET ls_prog_name = p_prog_name

  #取得資料
  LET ls_sql = "SELECT NVL(AQ.DZAQ010,'N') DZAQ010     ",
               "  FROM DZAQ_T AQ                       ",
               " WHERE AQ.DZAQ001 = '",ls_prog_name,"' "
 
  PREPARE lpre_check_dzaq_if_synced FROM ls_sql
  DECLARE lcur_check_dzaq_if_synced CURSOR FOR lpre_check_dzaq_if_synced
  OPEN lcur_check_dzaq_if_synced
  FETCH lcur_check_dzaq_if_synced INTO lv_dzaq010
  CLOSE lcur_check_dzaq_if_synced
  FREE lcur_check_dzaq_if_synced
  FREE lpre_check_dzaq_if_synced

  IF (lv_dzaq010 IS NOT NULL) AND (lv_dzaq010 = "N") THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

-- VER1_FLAG begin
FUNCTION adzp050_check_dzsa_if_exist(p_prog_name)
DEFINE
  p_prog_name  STRING
DEFINE
  ls_prog_name  STRING,
  lb_return     BOOLEAN,
  ls_sql        STRING,
  li_rec_count  INTEGER

  LET ls_prog_name = p_prog_name

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                        ",
               "  FROM DZSA_T SA                       ",
               " WHERE SA.DZSA001 = '",ls_prog_name,"' "
 
  PREPARE lpre_check_dzsa_if_exist FROM ls_sql
  DECLARE lcur_check_dzsa_if_exist CURSOR FOR lpre_check_dzsa_if_exist
  OPEN lcur_check_dzsa_if_exist
  FETCH lcur_check_dzsa_if_exist INTO li_rec_count
  CLOSE lcur_check_dzsa_if_exist
  FREE lcur_check_dzsa_if_exist
  FREE lpre_check_dzsa_if_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_check_dzpa_if_exist(p_prog_name)
DEFINE
  p_prog_name  STRING
DEFINE
  ls_prog_name  STRING,
  lb_return     BOOLEAN,
  ls_sql        STRING,
  li_rec_count  INTEGER

  LET ls_prog_name = p_prog_name

  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                        ",
               "  FROM DZPA_T PA                       ",
               " WHERE PA.DZPA001 = '",ls_prog_name,"' "
 
  PREPARE lpre_check_dzpa_if_exist FROM ls_sql
  DECLARE lcur_check_dzpa_if_exist CURSOR FOR lpre_check_dzpa_if_exist
  OPEN lcur_check_dzpa_if_exist
  FETCH lcur_check_dzpa_if_exist INTO li_rec_count
  CLOSE lcur_check_dzpa_if_exist
  FREE lcur_check_dzpa_if_exist
  FREE lpre_check_dzpa_if_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION
-- VER1_FLAG end

FUNCTION adzp050_check_dzba_if_exist(p_prog_name,p_version,p_dgenv)
DEFINE
  p_prog_name  STRING,
  p_version    STRING,
  p_dgenv      STRING
DEFINE
  ls_prog_name  STRING,
  ls_version    STRING,
  ls_dgenv      STRING,
  lb_return     BOOLEAN,
  ls_sql        STRING,
  li_rec_count  INTEGER

  LET ls_prog_name = p_prog_name.trim()
  LET ls_version   = p_version.trim()
  LET ls_dgenv     = p_dgenv.trim()
  
  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1)                        ",
               "  FROM DZBA_T BA                       ",
               " WHERE BA.DZBA001 = '",ls_prog_name,"' ",
               "   AND BA.DZBA002 = ",ls_version,"     ",
               "   AND BA.DZBA010 = '",ls_dgenv,"'     "
 
  PREPARE lpre_check_dzba_if_exist FROM ls_sql
  DECLARE lcur_check_dzba_if_exist CURSOR FOR lpre_check_dzba_if_exist
  OPEN lcur_check_dzba_if_exist
  FETCH lcur_check_dzba_if_exist INTO li_rec_count
  CLOSE lcur_check_dzba_if_exist
  FREE lcur_check_dzba_if_exist
  FREE lpre_check_dzba_if_exist

  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_change_working_path(p_working_path)
DEFINE
  p_working_path STRING
DEFINE
  ls_curr_working_path STRING,
  ls_pwd               STRING,
  ls_status            STRING,
  li_chdir_status      INTEGER
  
  LET ls_curr_working_path = p_working_path
  LET ls_status = ""
  
  CALL os.Path.chdir(ls_curr_working_path) RETURNING li_chdir_status
  CASE
    WHEN li_chdir_status = 0
      LET ls_status = "FAULT"
    WHEN li_chdir_status = 1
      LET ls_status = "SUCCESS" 
    OTHERWISE
      LET ls_status = ""
  END CASE
  
  DISPLAY cs_information_tag,"Changing path to : ",ls_curr_working_path," --> ",ls_status
  CALL os.Path.pwd() RETURNING ls_pwd
  DISPLAY cs_information_tag,"Current working path : ",ls_pwd
  
END FUNCTION

FUNCTION adzp050_set_progress(p_progress,p_rec_cnt,p_DIALOG)
DEFINE 
  p_progress INTEGER,
  p_rec_cnt  INTEGER,
  p_DIALOG   ui.Dialog
DEFINE 
  li_progress     INTEGER,
  li_scr_line     INTEGER,
  li_rec_cnt      INTEGER

  LET li_progress = p_progress
  LET li_rec_cnt  = p_rec_cnt

  CALL p_DIALOG.setCurrentRow("sr_proglist", li_rec_cnt)
  CALL ui.Interface.refresh()
  CALL SCR_LINE() RETURNING li_scr_line 
  #DISPLAY "li_rec_cnt : ",li_rec_cnt
  #DISPLAY "li_scr_line : ",li_scr_line
  LET m_prog_list[li_rec_cnt].progress = li_progress
  DISPLAY li_progress TO sr_proglist[li_rec_cnt].lbl_progress
  DISPLAY li_progress TO formonly.pgb_main #161004-00011
  CALL ui.Interface.refresh()
  
END FUNCTION 

FUNCTION adzp050_set_alm_progress(p_progress,p_rec_cnt,p_DIALOG)
DEFINE 
  p_progress INTEGER,
  p_rec_cnt  INTEGER,
  p_DIALOG   ui.Dialog
DEFINE 
  li_progress     INTEGER,
  li_scr_line     INTEGER,
  li_rec_cnt      INTEGER

  LET li_progress = p_progress
  LET li_rec_cnt  = p_rec_cnt

  CALL p_DIALOG.setCurrentRow("sr_demand_list", li_rec_cnt)
  CALL ui.Interface.refresh()
  CALL SCR_LINE() RETURNING li_scr_line 
  #DISPLAY "li_rec_cnt : ",li_rec_cnt
  #DISPLAY "li_scr_line : ",li_scr_line
  LET m_demand_list[li_rec_cnt].progress = li_progress
  DISPLAY li_progress TO sr_demand_list[li_rec_cnt].lbl_alm_progress
  DISPLAY li_progress TO formonly.pgb_main #161004-00011
  CALL ui.Interface.refresh()
  
END FUNCTION 

FUNCTION adzp050_get_cond_with_escape(p_value)
DEFINE
  p_value STRING
DEFINE
  lo_str_buf base.StringBuffer, 
  ls_value   STRING
DEFINE
  ls_return     STRING,
  ls_rtn_escape STRING 
  
  LET ls_value = p_value.trim()

  LET lo_str_buf = base.StringBuffer.create()
  CALL lo_str_buf.append(ls_value)

  IF lo_str_buf.getIndexOf("_",1) > 0 THEN
    CALL lo_str_buf.replace("_","\\_",0)
    LET ls_return     = lo_str_buf.toString()
    LET ls_rtn_escape = "ESCAPE '\\'"
  ELSE
    LET ls_return     = ls_value
    LET ls_rtn_escape = ""
  END IF

  RETURN ls_return, ls_rtn_escape

END FUNCTION

FUNCTION adzp050_set_alm_element_visible(p_DIALOG)
DEFINE
  p_DIALOG ui.Dialog
DEFINE
  lo_curr_window ui.Window,
  lo_curr_form   ui.Form,
  lb_visible     BOOLEAN

  LET lb_visible = IIF(ms_erpalm == "N",TRUE,FALSE)

  LET lo_curr_window = ui.Window.getCurrent()
  LET lo_curr_form   = lo_curr_window.getForm()

  CALL lo_curr_form.setElementHidden("formonly.chk_view_mergeable",NOT mb_customize)
  
  --CALL lo_curr_form.setElementHidden("grd_alm",lb_visible)
  --CALL lo_curr_form.setElementHidden("tbl_alm",lb_visible)
  --CALL lo_curr_form.setElementHidden("btn_check_in",NOT lb_visible) -- 待 ALM 完工後解除
  
END FUNCTION 

FUNCTION adzp050_set_debug_mode(p_enable)
DEFINE
  p_enable BOOLEAN
DEFINE
  lo_curr_window ui.Window,
  lo_curr_form   ui.Form,
  lb_visible     BOOLEAN

  LET lb_visible = NOT p_enable

  LET mb_debug = p_enable

  LET lo_curr_window = ui.Window.getCurrent()
  LET lo_curr_form   = lo_curr_window.getForm()
  
  CALL lo_curr_form.setFieldHidden("lbl_get_last_version",lb_visible)
  CALL lo_curr_form.setFieldHidden("chk_enable_alm",lb_visible)
  CALL lo_curr_form.setFieldHidden("chk_enable_customize",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_sd_rw",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_pg_rw",lb_visible)
  #CALL lo_curr_form.setFieldHidden("lbl_merge_code",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_gzzb003",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_origin_sd_ver",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_origin_pg_ver",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_origin_module",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_origin_spec_type",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_origin_identity",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_identity",lb_visible)
  CALL lo_curr_form.setFieldHidden("cust_module_name",lb_visible)

  CALL lo_curr_form.setFieldHidden("lbl_alm_sd_rw",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_alm_pg_rw",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_alm_gzzb003",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_alm_identity",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_alm_origin_module",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_alm_origin_spec_type",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_alm_origin_sd_ver",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_alm_origin_pg_ver",lb_visible)
  CALL lo_curr_form.setFieldHidden("lbl_alm_origin_identity",lb_visible)
  
  CALL lo_curr_form.setFieldHidden("dzlm012",lb_visible)
  CALL lo_curr_form.setFieldHidden("dzlm013",lb_visible)
  CALL lo_curr_form.setFieldHidden("dzlm014",lb_visible)
  CALL lo_curr_form.setFieldHidden("dzlm015",lb_visible)
  CALL lo_curr_form.setFieldHidden("dzlm018",lb_visible)
  CALL lo_curr_form.setFieldHidden("dzlm019",lb_visible)
  CALL lo_curr_form.setFieldHidden("dzlm020",lb_visible)
  CALL lo_curr_form.setFieldHidden("dzlm021",lb_visible)
  
END FUNCTION 

FUNCTION adzp050_set_customize_visible(p_customize)
DEFINE
  p_customize BOOLEAN
DEFINE
  lo_curr_window ui.Window,
  lo_curr_form   ui.Form,
  lb_hidden      BOOLEAN

  LET lb_hidden = NOT p_customize

  LET lo_curr_window = ui.Window.getCurrent()
  LET lo_curr_form   = lo_curr_window.getForm()
  
  CALL lo_curr_form.setFieldHidden("lbl_org_merge_code",lb_hidden)
  CALL lo_curr_form.setFieldHidden("lbl_alm_merge_code",lb_hidden)

  IF (ms_topind= cs_industry_type_standard) THEN 
    CALL lo_curr_form.setFieldHidden("lbl_org_sync_code",TRUE)
    CALL lo_curr_form.setFieldHidden("lbl_alm_sync_code",TRUE)
  ELSE 
    CALL lo_curr_form.setFieldHidden("lbl_org_sync_code",NOT lb_hidden)
    CALL lo_curr_form.setFieldHidden("lbl_alm_sync_code",NOT lb_hidden)
  END IF  
  
END FUNCTION 

FUNCTION adzp050_get_debug_info(p_info)
DEFINE
  p_info STRING 
  
  IF mb_debug THEN
    DISPLAY "[Debug] ",p_info
    LET ms_debug_message = ms_debug_message,p_info,"\n"
  END IF   
  
END FUNCTION 

FUNCTION adzp050_show_debug_info()
  IF mb_debug THEN
    DISPLAY "[ Debug messages ] ","\n",ms_debug_message
    LET ms_debug_message = ""
  END IF   
END FUNCTION 

FUNCTION adzp050_show_message_designer()
DEFINE
  lo_curr_time DATETIME YEAR TO SECOND

  LET lo_curr_time = cl_get_current()
  
  DISPLAY "[",lo_curr_time,"]",cs_message_half_separator,cs_message_designer,cs_message_half_separator
  
END FUNCTION

FUNCTION adzp050_show_process_message(p_message)
DEFINE
  p_message STRING
DEFINE
  lo_curr_time DATETIME YEAR TO SECOND

  LET lo_curr_time = cl_get_current()
  
  DISPLAY "[",lo_curr_time,"]",p_message
  
END FUNCTION

FUNCTION adzp050_show_message_generator()
DEFINE
  lo_curr_time DATETIME YEAR TO SECOND

  LET lo_curr_time = cl_get_current()
  
  DISPLAY "[",lo_curr_time,"]",cs_message_half_separator,cs_message_generator,cs_message_half_separator
  
END FUNCTION

FUNCTION sadzp50_get_download_match_type(p_download_type)
DEFINE
  p_download_type STRING
DEFINE
  ls_return STRING  

  CASE 
    WHEN (p_download_type = "SPEC") 
      LET ls_return = cs_ver_type_sd
    WHEN (p_download_type = "CODE" OR p_download_type = "4RP") 
      LET ls_return = cs_ver_type_pr
  END CASE
  
  RETURN ls_return
  
END FUNCTION 

FUNCTION adzp050_trim(p_string)
DEFINE
  p_string STRING 

  RETURN p_string.trim()

END FUNCTION 

FUNCTION adzp050_refill_combobox(p_customize,p_lang)
DEFINE
  p_customize BOOLEAN,
  p_lang      STRING
DEFINE
  lb_customize BOOLEAN,
  ls_lang      STRING,
  ls_sql       STRING,
  ls_customize_sql STRING

  LET lb_customize = p_customize
  LET ls_lang = p_lang

  IF (lb_customize) OR (ms_user_name = cs_topstd_user_name) THEN
    LET ls_customize_sql = "UNION ALL                                          ",
                           "SELECT ZJ.GZZJ001                     MODULE_NAME, ",
                           "       ZJ.GZZJ001||'. '||ZOL.GZZOL003 MODULE_DESC  ",
                           "  FROM GZZJ_T ZJ                                   ",
                           "  LEFT OUTER JOIN GZZOL_T ZOL                      ",
                           "               ON ZOL.GZZOL001 = ZJ.GZZJ003        ",
                           "              AND ZOL.GZZOL002 = '",ls_lang,"'     ",
                           " WHERE NOT EXISTS (                                ",
                           "                    SELECT 1                       ",
                           "                      FROM GZZO_T ZO               ",
                           "                     WHERE ZO.GZZO001 = ZJ.GZZJ001 ",
                           "                  )                                ",
                           "   AND ZJ.GZZJ003 NOT IN (",ms_exclude_module,")   " 
  ELSE
    LET ls_customize_sql = ""
  END IF 
  
  LET ls_sql = "SELECT ZO.GZZO001                     MODULE_NAME, ",
               "       ZO.GZZO001||'. '||ZOL.GZZOL003 MODULE_DESC  ",
               "  FROM GZZO_T ZO                                   ",
               "  LEFT OUTER JOIN GZZOL_T ZOL                      ",
               "               ON ZOL.GZZOL001 = ZO.GZZO001        ",
               "              AND ZOL.GZZOL002 = '",ls_lang,"'     ",
               " WHERE ZO.GZZO001 NOT IN (",ms_exclude_module,")   ",
               ls_customize_sql,
               " ORDER BY 1                                        "

  CALL adzp050_find_and_fill_combobox("formonly.cb_downloadmodule",ls_sql)

  LET ls_sql = "SELECT GZCB002                 SPEC_TYPE,  ",
               "       GZCB002||'. '||GZCBL004 SPEC_NAME   ",
               "  FROM GZCB_T CB                           ",
               "  LEFT OUTER JOIN GZCBL_T                  ",
               "               ON GZCB001  = GZCBL001      ",
               "              AND GZCB002  = GZCBL002      ",
               "              AND GZCBL003 = '",ls_lang,"' ",
               " WHERE CB.GZCB001 = 114                    ",
               "   AND CB.GZCB002 <> 'T'                   " 

  CALL adzp050_find_and_fill_combobox("formonly.cb_spec_type",ls_sql)
  CALL adzp050_find_and_fill_combobox("formonly.lbl_spec_type",ls_sql)
  CALL adzp050_find_and_fill_combobox("formonly.lbl_alm_spec_type",ls_sql)

  
END FUNCTION 

FUNCTION adzp050_set_virtual_view()

  LET ms_dzaf_t_o_view = " SELECT ZB.*, OSAF.*, OCAF.*                                                                                                    ",
                         "   FROM GZZB_T ZB                                                                                                               ",
                         "   LEFT OUTER JOIN (                                                                                                            ",
                         "                     SELECT AF.DZAF001 SDZAF001,AF.DZAF002 SDZAF002,AF.DZAF003 SDZAF003,AF.DZAF004 SDZAF004,AF.DZAF005 SDZAF005,",
                         "                            AF.DZAF006 SDZAF006,AF.DZAF007 SDZAF007,AF.DZAF008 SDZAF008,AF.DZAF009 SDZAF009,AF.DZAF010 SDZAF010 ",
                         "                       FROM DZAF_T AF                                                                                           ",
                         "                      WHERE AF.DZAF002 =                                                                                        ",
                         "                            (                                                                                                   ",
                         "                             SELECT MAX(NVL(AFM.DZAF002,0)) MAX_VER                                                             ",
                         "                               FROM DZAF_T AFM                                                                                  ",
                         "                              WHERE AFM.DZAF001 = AF.DZAF001                                                                    ",
                         "                                AND AFM.DZAF005 = AF.DZAF005                                                                    ",
                         --"                                AND AFM.DZAF007 = AF.DZAF007                                                                    ",
                         --"                                AND AFM.DZAF008 = AF.DZAF008                                                                    ",
                         "                                AND AFM.DZAF010 = AF.DZAF010                                                                    ",
                         "                            )                                                                                                   ",
                         "                        AND AF.DZAF010 = '",cs_dgenv_standard,"'                                                                ",
                         "                   ) OSAF                                                                                                       ",
                         "     ON OSAF.SDZAF001 = ZB.GZZB003                                                                                              ",
                         "   LEFT OUTER JOIN (                                                                                                            ",
                         "                     SELECT AF.DZAF001 CDZAF001,AF.DZAF002 CDZAF002,AF.DZAF003 CDZAF003,AF.DZAF004 CDZAF004,AF.DZAF005 CDZAF005,",
                         "                            AF.DZAF006 CDZAF006,AF.DZAF007 CDZAF007,AF.DZAF008 CDZAF008,AF.DZAF009 CDZAF009,AF.DZAF010 CDZAF010 ",
                         "                       FROM DZAF_T AF                                                                                           ",
                         "                      WHERE AF.DZAF002 =                                                                                        ",
                         "                            (                                                                                                   ",
                         "                             SELECT MAX(NVL(AFM.DZAF002,0)) MAX_VER                                                             ",
                         "                               FROM DZAF_T AFM                                                                                  ",
                         "                              WHERE AFM.DZAF001 = AF.DZAF001                                                                    ",
                         "                                AND AFM.DZAF005 = AF.DZAF005                                                                    ",
                         --"                                AND AFM.DZAF007 = AF.DZAF007                                                                    ",
                         --"                                AND AFM.DZAF008 = AF.DZAF008                                                                    ",
                         "                                AND AFM.DZAF010 = AF.DZAF010                                                                    ",
                         "                            )                                                                                                   ",
                         "                        AND AF.DZAF010 = '",cs_dgenv_customize,"'                                                               ",
                         "                   ) OCAF                                                                                                       ",
                         "     ON OCAF.CDZAF001 = ZB.GZZB003                                                                                              "
                       
  LET ms_dzaf_t_s_view = " SELECT AF.DZAF001 SDZAF001,AF.DZAF002 SDZAF002,AF.DZAF003 SDZAF003,AF.DZAF004 SDZAF004,AF.DZAF005 SDZAF005, ",
                         "        AF.DZAF006 SDZAF006,AF.DZAF007 SDZAF007,AF.DZAF008 SDZAF008,AF.DZAF009 SDZAF009,AF.DZAF010 SDZAF010  ",
                         "   FROM DZAF_T AF                                                                                            ",
                         "  WHERE AF.DZAF002 =                                                                                         ",
                         "        (                                                                                                    ",
                         "         SELECT MAX(NVL(AFM.DZAF002,0)) MAX_VER                                                              ",
                         "           FROM DZAF_T AFM                                                                                   ",
                         "          WHERE AFM.DZAF001 = AF.DZAF001                                                                     ",
                         "            AND AFM.DZAF005 = AF.DZAF005                                                                     ",
                         --"            AND AFM.DZAF007 = AF.DZAF007                                                                     ",
                         --"            AND AFM.DZAF008 = AF.DZAF008                                                                     ",
                         "            AND AFM.DZAF010 = AF.DZAF010                                                                     ",
                         "        )                                                                                                    ",
                         "    AND AF.DZAF010 = '",cs_dgenv_standard,"'                                                                 "
                         
  LET ms_dzaf_t_c_view = " SELECT AF.DZAF001 CDZAF001,AF.DZAF002 CDZAF002,AF.DZAF003 CDZAF003,AF.DZAF004 CDZAF004,AF.DZAF005 CDZAF005, ",
                         "        AF.DZAF006 CDZAF006,AF.DZAF007 CDZAF007,AF.DZAF008 CDZAF008,AF.DZAF009 CDZAF009,AF.DZAF010 CDZAF010  ",
                         "   FROM DZAF_T AF                                                                                            ",
                         "  WHERE AF.DZAF002 =                                                                                         ",
                         "        (                                                                                                    ",
                         "         SELECT MAX(NVL(AFM.DZAF002,0)) MAX_VER                                                              ",
                         "           FROM DZAF_T AFM                                                                                   ",
                         "          WHERE AFM.DZAF001 = AF.DZAF001                                                                     ",
                         "            AND AFM.DZAF005 = AF.DZAF005                                                                     ",
                         --"            AND AFM.DZAF007 = AF.DZAF007                                                                     ",
                         --"            AND AFM.DZAF008 = AF.DZAF008                                                                     ",
                         "            AND AFM.DZAF010 = AF.DZAF010                                                                     ",
                         "        )                                                                                                    ",
                         "    AND AF.DZAF010 = '",cs_dgenv_customize,"'                                                                " 

  LET ms_gzzj_t_view = " SELECT *                                            ",
                       "   FROM GZZJ_T ZJ                                    ",
                       "  WHERE NOT EXISTS (                                 ",
                       "                     SELECT 1                        ",
                       "                       FROM GZZO_T ZO                ",
                       "                      WHERE ZO.GZZO001 = ZJ.GZZJ001  ",
                       "                   )                                 ",
                       "    AND ZJ.GZZJ001 <> ZJ.GZZJ003                     " 

END FUNCTION

#觀看 Log
FUNCTION adzp050_rev_view_logresult(p_message)
DEFINE
  p_message     STRING
DEFINE  
  txt_LogResult STRING

  LET txt_LogResult = p_message
  
  CALL adzp050_rev_open_logresult_form()

  DISPLAY BY NAME txt_LogResult
  MENU
    ON ACTION btn_ok
      EXIT MENU  

    ON ACTION CLOSE
      EXIT MENU
  END MENU

  CALL adzp050_rev_close_logresult_form()
  
END FUNCTION

#開啟看 Log 的Form
FUNCTION adzp050_rev_open_logresult_form()

  &ifndef DEBUG
    OPEN WINDOW w_sadzp050_log WITH FORM cl_ap_formpath("ADZ","sadzp050_log")
  &else
    OPEN WINDOW w_sadzp050_log WITH FORM "sadzp050_log"
  &endif
  
  CURRENT WINDOW IS w_sadzp050_log
  
END FUNCTION

#關閉看 Log 的Form
FUNCTION adzp050_rev_close_logresult_form()

  CLOSE WINDOW w_sadzp050_log
  
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得規格識別碼的舊版版次資料
# Input parameter : po_curr_dzaf 目前的程式版次資訊
#                 : p_download_type 下載類型(SPEC/CODE)
# Return code     : BOOLEAN TRUE:執行成功;FALSE:執行失敗
# Date & Author   : 2014/12/03 by Hiko
##########################################################################
PRIVATE FUNCTION adzp050_continue_download(po_curr_dzaf, p_download_type)
   DEFINE po_curr_dzaf    T_DZAF_T,
          p_download_type STRING
   DEFINE ls_trigger       STRING,
          l_construct_type LIKE dzaf_t.dzaf005,
          li_cnt           SMALLINT,
          li_cnt2          SMALLINT, #2015/12/04 by Hiko
          ls_err_msg       STRING

   TRY
      LET ls_trigger = "call adzp050_continue_download() start..."
      DISPLAY ls_trigger

      LET l_construct_type = po_curr_dzaf.dzaf005 CLIPPED

      CASE p_download_type
         WHEN cs_download_type_spec
            #建構類型M/S/F/Q若沒有4fd設計資料,則不可以下載畫面和規格.
            #Begin:20160223 by elena
            #IF l_construct_type='M' OR l_construct_type='S' OR l_construct_type='F' THEN --OR l_construct_type='Q' THEN
            IF l_construct_type MATCHES "[MSFQ]" THEN
            #END:20160223 by elena
               SELECT COUNT(*) INTO li_cnt
                 FROM dzfi_t
                WHERE dzfi001=po_curr_dzaf.dzaf001
                  AND dzfi002=po_curr_dzaf.dzaf003
                  AND dzfi009=po_curr_dzaf.dzaf010
              ##Begin:2015/12/04 by Hiko
              #SELECT COUNT(*) INTO li_cnt2
              #  FROM dzfq_t
              # WHERE dzfq004=po_curr_dzaf.dzaf001
              #   AND dzfq003=1 #版次就只會是1
              ##End:2015/12/04 by Hiko
              #IF li_cnt=0 OR li_cnt2=0 THEN
               IF li_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code  = "adz-00466"
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = po_curr_dzaf.dzaf001
                  LET g_errparam.replace[2] = po_curr_dzaf.dzaf003
                  CALL cl_err()
                  RETURN FALSE                 
               END IF
            END IF
         WHEN cs_download_type_code
            #建構類型M/S/G/X/Q版次>1的時候,若沒有程式設計資料,則不可以下載規格.
            #Begin:20160223 by elena
            #IF l_construct_type='M' OR l_construct_type='S' OR l_construct_type='G' OR l_construct_type='X' OR l_construct_type='Q' THEN
            IF l_construct_type <> 'F' THEN
            #End:20160223 by elena
               IF po_curr_dzaf.dzaf004>1 THEN
                  {
                  SELECT COUNT(*) INTO li_cnt
                    FROM dzba_t
                   WHERE dzba001=po_curr_dzaf.dzaf001
                     AND dzba002=po_curr_dzaf.dzaf004
                     AND dzba010=po_curr_dzaf.dzaf010
                  }   
                  SELECT COUNT(*) INTO li_cnt
                    FROM dzbc_t
                   WHERE dzbc001=po_curr_dzaf.dzaf001
                     AND dzbc002=po_curr_dzaf.dzaf004
                     AND dzbc007=po_curr_dzaf.dzaf010
                  IF li_cnt=0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code  = "adz-00467"
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = po_curr_dzaf.dzaf001
                     LET g_errparam.replace[2] = po_curr_dzaf.dzaf004
                     CALL cl_err()
                     RETURN FALSE                 
                  END IF
               END IF
            END IF
      END CASE

      LET ls_trigger = "call adzp050_continue_download() finish!"
      DISPLAY ls_trigger

      RETURN TRUE
   CATCH 
      LET ls_err_msg = "ERROR : call adzp050_continue_download() check program revision failure!"
      DISPLAY ls_err_msg
      RETURN FALSE
   END TRY
END FUNCTION

FUNCTION adzp050_backup_design_data(p_backup_design_data_intf)
DEFINE
  p_backup_design_data_intf T_BACKUP_DESIGN_DATA_INTF
DEFINE
  lo_BACKUP_DESIGN_DATA_RET DYNAMIC ARRAY OF T_BACKUP_DESIGN_DATA_RET,
  ls_form_zip_ext_name      STRING,
  ls_code_zip_ext_name      STRING,
  ls_template_zip_ext_name  STRING,
  li_index                  INTEGER

  LET li_index = 0 
  
  CASE
  
    WHEN p_backup_design_data_intf.BDDI_S_spec_type = "B"
      LET ls_form_zip_ext_name = cs_zip_name_tzr
      LET ls_code_zip_ext_name = cs_zip_name_tzc
      CASE p_backup_design_data_intf.BDDI_S_download_type
        WHEN cs_download_type_spec
          LET li_index = li_index + 1
          CALL sadzp050_zip_compress_to_rsd_zip(p_backup_design_data_intf.BDDI_S_file_name,p_backup_design_data_intf.BDDI_S_module_name,p_backup_design_data_intf.BDDI_S_identity,p_backup_design_data_intf.BDDI_S_module_path,p_backup_design_data_intf.BDDI_S_lang,ls_form_zip_ext_name,p_backup_design_data_intf.BDDI_S_erpalm,p_backup_design_data_intf.BDDI_B_readonly,FALSE) RETURNING lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_B_result ,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_src_path,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_download_type = cs_download_type_spec
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name = lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name,'.',ls_form_zip_ext_name 
        WHEN cs_download_type_code
          LET li_index = li_index + 1
          CALL sadzp050_zip_compress_to_code_zip(p_backup_design_data_intf.BDDI_S_file_name,p_backup_design_data_intf.BDDI_S_module_name,p_backup_design_data_intf.BDDI_S_identity,p_backup_design_data_intf.BDDI_S_module_path,p_backup_design_data_intf.BDDI_S_lang,ls_code_zip_ext_name,p_backup_design_data_intf.BDDI_S_erpalm,p_backup_design_data_intf.BDDI_B_readonly,FALSE) RETURNING lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_B_result ,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_src_path,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_download_type = cs_download_type_code
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name = lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name,'.',ls_code_zip_ext_name 
      END CASE 
        
    WHEN p_backup_design_data_intf.BDDI_S_spec_type = "F"
      LET ls_form_zip_ext_name = cs_zip_name_tzs
      #LET ls_code_zip_ext_name = cs_zip_name_tzc
      LET li_index = li_index + 1
      CALL sadzp050_zip_compress_to_form_zip(p_backup_design_data_intf.BDDI_S_file_name,p_backup_design_data_intf.BDDI_S_module_name,p_backup_design_data_intf.BDDI_S_identity,p_backup_design_data_intf.BDDI_S_module_path,p_backup_design_data_intf.BDDI_S_lang,ls_form_zip_ext_name,p_backup_design_data_intf.BDDI_S_erpalm,p_backup_design_data_intf.BDDI_B_readonly,FALSE) RETURNING lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_B_result ,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_src_path,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name
      LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_download_type = cs_download_type_spec
      LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name = lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name,'.',ls_form_zip_ext_name 
      
    WHEN (p_backup_design_data_intf.BDDI_S_spec_type = "M") OR
         (p_backup_design_data_intf.BDDI_S_spec_type = "S") OR
         (p_backup_design_data_intf.BDDI_S_spec_type = "Q")
      LET ls_form_zip_ext_name = cs_zip_name_tzs
      LET ls_code_zip_ext_name = cs_zip_name_tzc
      CASE p_backup_design_data_intf.BDDI_S_download_type
        WHEN cs_download_type_spec
          LET li_index = li_index + 1
          CALL sadzp050_zip_compress_to_form_zip(p_backup_design_data_intf.BDDI_S_file_name,p_backup_design_data_intf.BDDI_S_module_name,p_backup_design_data_intf.BDDI_S_identity,p_backup_design_data_intf.BDDI_S_module_path,p_backup_design_data_intf.BDDI_S_lang,ls_form_zip_ext_name,p_backup_design_data_intf.BDDI_S_erpalm,p_backup_design_data_intf.BDDI_B_readonly,FALSE) RETURNING lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_B_result ,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_src_path,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_download_type = cs_download_type_spec
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name = lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name,'.',ls_form_zip_ext_name 
        WHEN cs_download_type_code
          LET li_index = li_index + 1
          CALL sadzp050_zip_compress_to_code_zip(p_backup_design_data_intf.BDDI_S_file_name,p_backup_design_data_intf.BDDI_S_module_name,p_backup_design_data_intf.BDDI_S_identity,p_backup_design_data_intf.BDDI_S_module_path,p_backup_design_data_intf.BDDI_S_lang,ls_code_zip_ext_name,p_backup_design_data_intf.BDDI_S_erpalm,p_backup_design_data_intf.BDDI_B_readonly,FALSE) RETURNING lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_B_result ,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_src_path,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_download_type = cs_download_type_code
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name = lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name,'.',ls_code_zip_ext_name 
      END CASE 
         
    WHEN (p_backup_design_data_intf.BDDI_S_spec_type = "G") OR
         (p_backup_design_data_intf.BDDI_S_spec_type = "X")
      LET ls_template_zip_ext_name = cs_zip_name_tzt
      LET ls_form_zip_ext_name     = cs_zip_name_tzr
      LET ls_code_zip_ext_name     = cs_zip_name_tzc
      CASE p_backup_design_data_intf.BDDI_S_download_type
        WHEN cs_download_type_4rp
          LET li_index = li_index + 1
          CALL sadzp050_zip_compress_to_4rp_zip(p_backup_design_data_intf.BDDI_S_file_name,p_backup_design_data_intf.BDDI_S_module_name,p_backup_design_data_intf.BDDI_S_spec_type,p_backup_design_data_intf.BDDI_S_version,p_backup_design_data_intf.BDDI_S_identity,p_backup_design_data_intf.BDDI_S_module_path,p_backup_design_data_intf.BDDI_S_lang,p_backup_design_data_intf.BDDI_S_dgenv,ls_template_zip_ext_name,p_backup_design_data_intf.BDDI_O_template_list,p_backup_design_data_intf.BDDI_B_run_alm) RETURNING lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_B_result ,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_src_path,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_download_type = cs_download_type_4rp
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name = lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name,'.',ls_template_zip_ext_name
          #如果是 G 類, 則包壓縮包時還要包 CODE 包  
          IF p_backup_design_data_intf.BDDI_S_spec_type = "G" THEN 
            LET li_index = li_index + 1
            CALL sadzp050_zip_compress_to_code_zip(p_backup_design_data_intf.BDDI_S_file_name,p_backup_design_data_intf.BDDI_S_module_name,p_backup_design_data_intf.BDDI_S_identity,p_backup_design_data_intf.BDDI_S_module_path,p_backup_design_data_intf.BDDI_S_lang,ls_code_zip_ext_name,p_backup_design_data_intf.BDDI_S_erpalm,p_backup_design_data_intf.BDDI_B_readonly,FALSE) RETURNING lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_B_result ,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_src_path,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name
            LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_download_type = cs_download_type_code
            LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name = lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name,'.',ls_code_zip_ext_name
          END IF            
        WHEN cs_download_type_spec
          LET li_index = li_index + 1
          CALL sadzp050_zip_compress_to_rsd_zip(p_backup_design_data_intf.BDDI_S_file_name,p_backup_design_data_intf.BDDI_S_module_name,p_backup_design_data_intf.BDDI_S_identity,p_backup_design_data_intf.BDDI_S_module_path,p_backup_design_data_intf.BDDI_S_lang,ls_form_zip_ext_name,p_backup_design_data_intf.BDDI_S_erpalm,p_backup_design_data_intf.BDDI_B_readonly,FALSE) RETURNING lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_B_result ,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_src_path,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_download_type = cs_download_type_spec
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name = lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name,'.',ls_form_zip_ext_name 
        WHEN cs_download_type_code
          LET li_index = li_index + 1
          CALL sadzp050_zip_compress_to_code_zip(p_backup_design_data_intf.BDDI_S_file_name,p_backup_design_data_intf.BDDI_S_module_name,p_backup_design_data_intf.BDDI_S_identity,p_backup_design_data_intf.BDDI_S_module_path,p_backup_design_data_intf.BDDI_S_lang,ls_code_zip_ext_name,p_backup_design_data_intf.BDDI_S_erpalm,p_backup_design_data_intf.BDDI_B_readonly,FALSE) RETURNING lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_B_result ,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_src_path,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_download_type = cs_download_type_code
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name = lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name,'.',ls_code_zip_ext_name 
          #如果是 G 類, 則包壓縮包時還要包 4RP 包  
          IF p_backup_design_data_intf.BDDI_S_spec_type = "G" THEN 
            LET li_index = li_index + 1
            CALL sadzp050_zip_compress_to_4rp_zip(p_backup_design_data_intf.BDDI_S_file_name,p_backup_design_data_intf.BDDI_S_module_name,p_backup_design_data_intf.BDDI_S_spec_type,p_backup_design_data_intf.BDDI_S_version,p_backup_design_data_intf.BDDI_S_identity,p_backup_design_data_intf.BDDI_S_module_path,p_backup_design_data_intf.BDDI_S_lang,p_backup_design_data_intf.BDDI_S_dgenv,ls_template_zip_ext_name,p_backup_design_data_intf.BDDI_O_template_list,p_backup_design_data_intf.BDDI_B_run_alm) RETURNING lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_B_result ,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_src_path,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name
            LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_download_type = cs_download_type_4rp
            LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name = lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name,'.',ls_template_zip_ext_name
          END IF  
      END CASE 
         
    WHEN (p_backup_design_data_intf.BDDI_S_spec_type = "W") OR
         (p_backup_design_data_intf.BDDI_S_spec_type = "Z") 
      LET ls_form_zip_ext_name = cs_zip_name_tzr
      LET ls_code_zip_ext_name = cs_zip_name_tzc
      CASE p_backup_design_data_intf.BDDI_S_download_type
        WHEN cs_download_type_spec
          LET li_index = li_index + 1
          CALL sadzp050_zip_compress_to_rsd_zip(p_backup_design_data_intf.BDDI_S_file_name,p_backup_design_data_intf.BDDI_S_module_name,p_backup_design_data_intf.BDDI_S_identity,p_backup_design_data_intf.BDDI_S_module_path,p_backup_design_data_intf.BDDI_S_lang,ls_form_zip_ext_name,p_backup_design_data_intf.BDDI_S_erpalm,p_backup_design_data_intf.BDDI_B_readonly,FALSE) RETURNING lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_B_result ,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_src_path,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_download_type = cs_download_type_spec
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name = lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name,'.',ls_form_zip_ext_name 
        WHEN cs_download_type_code
          LET li_index = li_index + 1
          CALL sadzp050_zip_compress_to_code_zip(p_backup_design_data_intf.BDDI_S_file_name,p_backup_design_data_intf.BDDI_S_module_name,p_backup_design_data_intf.BDDI_S_identity,p_backup_design_data_intf.BDDI_S_module_path,p_backup_design_data_intf.BDDI_S_lang,ls_code_zip_ext_name,p_backup_design_data_intf.BDDI_S_erpalm,p_backup_design_data_intf.BDDI_B_readonly,FALSE) RETURNING lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_B_result ,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_src_path,lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_download_type = cs_download_type_code
          LET lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name = lo_BACKUP_DESIGN_DATA_RET[li_index].BDDR_S_file_name,'.',ls_code_zip_ext_name 
      END CASE 

  END CASE 

  RETURN lo_BACKUP_DESIGN_DATA_RET
  
END FUNCTION 

#161027-00001 begin
FUNCTION adzp050_check_if_could_check_in(p_type,p_module_name,p_program_name)
DEFINE
  p_type         STRING,
  p_module_name  STRING,
  p_program_name STRING
DEFINE
  ls_type         STRING,
  ls_module_name  STRING,
  ls_program_name STRING,
  ls_module_path  STRING,
  ls_curr_path    STRING,
  ls_sub_path     STRING,
  ls_run_cmd      STRING,
  lb_result       BOOLEAN
DEFINE
  lb_return BOOLEAN  

  LET ls_type = p_type
  LET ls_module_name  = p_module_name.toUpperCase()
  LET ls_program_name = p_program_name

  LET lb_return = TRUE

  CALL os.Path.pwd() RETURNING ls_curr_path

  CASE
    WHEN ls_type = cs_download_type_spec
      LET ls_sub_path = "4fd"
      LET ls_run_cmd  = "r.f"
    WHEN ls_type = cs_download_type_code
      LET ls_sub_path = "4gl"
      LET ls_run_cmd  = "r.c"
  OTHERWISE 
    LET ls_sub_path = NULL
    LET ls_run_cmd  = NULL
  END CASE 

  IF ls_sub_path IS NOT NULL THEN 
    LET ls_module_path = os.Path.join(FGL_GETENV(ls_module_name),ls_sub_path)
    DISPLAY cs_message_tag,"Patch change to : ",ls_module_path
    CALL os.Path.chdir(ls_module_path) RETURNING lb_result
    CALL adzp050_check_compile_status(ls_run_cmd,ls_program_name) RETURNING lb_result
  END IF  
  
  LET lb_return = lb_result

  CALL os.Path.chdir(ls_curr_path) RETURNING lb_result

  RETURN lb_return
  
END FUNCTION 

FUNCTION adzp050_check_compile_status(p_runcmd,p_program)
DEFINE
  p_runcmd   STRING,
  p_program  STRING
DEFINE 
  ls_runcmd       STRING,
  ls_program       STRING,
  lb_result        BOOLEAN, 
  lo_channel       base.Channel,
  ls_exp_file_path STRING,
  ls_message       STRING,
  ls_err_message   STRING,
  ls_all_message   STRING,
  ls_command       STRING,
  li_line_num      INTEGER
DEFINE
  lb_return  BOOLEAN 

  LET ls_runcmd  = p_runcmd
  LET ls_program = p_program

  LET lb_result = TRUE
  LET lb_return = TRUE
  LET li_line_num = 0
  LET ls_all_message = ""
  
  LET lo_channel = base.Channel.create()
  CALL lo_channel.setDelimiter("")

  LET ls_command = ls_runcmd," ",ls_program 
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

    LET ls_all_message = ls_all_message,ls_message,"\n"

    LET ls_err_message = ls_message.toUpperCase()
    IF ls_err_message.getIndexOf("ERROR" ,1) THEN
      LET lb_result = FALSE
    END IF
  END WHILE
  CALL lo_channel.close()

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_execute_merge_procedure(p_MERGE_SYNC_PARA)
DEFINE
  p_MERGE_SYNC_PARA T_MERGE_SYNC_PARA
DEFINE
  lo_MERGE_SYNC_PARA T_MERGE_SYNC_PARA,
  lo_DZAF_T      T_DZAF_T,
  ls_prog_name   STRING,
  ls_module_name STRING,
  ls_spec_type   STRING,
  ls_dgenv       STRING,
  lb_result      BOOLEAN, 
  ls_message     STRING,
  ls_err_code    STRING, 
  ls_err_msg     STRING
DEFINE
  lb_return BOOLEAN  

  LET lo_MERGE_SYNC_PARA.* = p_MERGE_SYNC_PARA.*

  LET lb_return = TRUE

  LET ls_prog_name   = lo_MERGE_SYNC_PARA.msp_prog_name
  LET ls_module_name = lo_MERGE_SYNC_PARA.msp_module_name
  LET ls_spec_type   = lo_MERGE_SYNC_PARA.msp_spec_type
  LET ls_dgenv       = lo_MERGE_SYNC_PARA.msp_dgenv
          
  CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*
  IF lo_DZAF_T.DZAF002 IS NOT NULL THEN
    LET lb_result = TRUE
    CALL sadzi888_07_auto_merge(lo_DZAF_T.*) RETURNING lb_result,ls_message
    IF NOT lb_result THEN
      LET ls_err_code = "adz-00489"
      LET ls_err_msg  = ls_message,"|"
      CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, TRUE)
    ELSE              
      LET ls_err_code = "adz-00490"
      LET ls_err_msg  = ""
      CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, TRUE)
    END IF
    #r.c
    IF lb_result THEN
      CALL adzp050_compile_4gl(ls_prog_name,ls_module_name) RETURNING lb_result
      IF NOT lb_result THEN 
        LET ls_err_code = "adz-00033"
        LET ls_err_msg  = ""
        CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, TRUE)
      END IF  
    END IF 
    #r.l
    IF lb_result THEN
      CALL adzp050_link_4gl(ls_prog_name,ls_module_name) RETURNING lb_result 
      IF NOT lb_result THEN 
        LET ls_err_code = "adz-00035"
        LET ls_err_msg  = ""
        CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, TRUE)
      END IF  
    END IF 
  END IF

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_execute_sync_procedure(p_MERGE_SYNC_PARA)
DEFINE
  p_MERGE_SYNC_PARA T_MERGE_SYNC_PARA
DEFINE
  lo_MERGE_SYNC_PARA T_MERGE_SYNC_PARA,
  lo_DZAF_T      T_DZAF_T,
  ls_prog_name   STRING,
  ls_module_name STRING,
  ls_spec_type   STRING,
  ls_dgenv       STRING,
  lb_result      BOOLEAN, 
  ls_message     STRING,
  ls_err_code    STRING, 
  ls_err_msg     STRING
DEFINE
  lb_return BOOLEAN  

  LET lo_MERGE_SYNC_PARA.* = p_MERGE_SYNC_PARA.*

  LET lb_return = TRUE

  LET ls_prog_name   = lo_MERGE_SYNC_PARA.msp_prog_name
  LET ls_module_name = lo_MERGE_SYNC_PARA.msp_module_name
  LET ls_spec_type   = lo_MERGE_SYNC_PARA.msp_spec_type
  LET ls_dgenv       = lo_MERGE_SYNC_PARA.msp_dgenv
          
  CALL adzp050_get_current_version(ls_prog_name,ls_spec_type,ls_dgenv) RETURNING lo_DZAF_T.*
  IF lo_DZAF_T.DZAF002 IS NOT NULL THEN
    LET lb_result = TRUE
    CALL sadzp060_4_start_sync(lo_DZAF_T.*) RETURNING lb_result,ls_message
    IF NOT lb_result THEN
      LET ls_err_code = "adz-00529"
      LET ls_err_msg  = ls_message,"|"
      CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, TRUE)
    ELSE              
      LET ls_err_code = "adz-00530"
      LET ls_err_msg  = ""
      CALL sadzp000_msg_show_info(ls_err_code, ls_err_code, ls_err_msg, TRUE)
    END IF
  END IF

  LET lb_return = lb_result

  RETURN lb_return
  
END FUNCTION
#161027-00001 end

#xxxxxx-xxxxx begin
FUNCTION adzp050_gen_environment_path()
DEFINE
  ls_GUID     STRING,
  ls_tempdir  STRING,
  ls_env_dir  STRING,
  lb_result   BOOLEAN
DEFINE
  ls_return  STRING  

  LET ls_tempdir = FGL_GETENV("TEMPDIR")
  CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_GUID
  LET ls_env_dir = "adzp050_env_",ls_GUID
  DISPLAY cs_message_tag,"adzp050 env dir : ",ls_env_dir
  CALL os.Path.chdir(ls_tempdir) RETURNING lb_result
  CALL os.Path.mkdir(ls_env_dir) RETURNING lb_result

  LET ls_return = os.Path.join(ls_tempdir,ls_env_dir)

  RETURN ls_return
  
END FUNCTION

FUNCTION adzp050_gen_environment_xml_file(p_env_path)
DEFINE
  p_env_path  STRING
DEFINE
  ls_env_path  STRING,
  lb_result    BOOLEAN,
  lo_xml_aps_document  xml.DomDocument,
  lo_xml_exp_elements  xml.DomNode,
  lo_exp_node_xml      xml.DomNode

  LET ls_env_path = p_env_path
  CALL os.Path.chdir(ls_env_path) RETURNING lb_result
  
  #產出 XML 標頭
  LET lo_xml_aps_document = xml.DomDocument.CreateDocument("environment")
  LET lo_xml_exp_elements = lo_xml_aps_document.getDocumentElement()
  CALL lo_xml_exp_elements.setAttribute("program_no","adzp050")
  LET lo_exp_node_xml = lo_xml_exp_elements.appendChildElement("download")
  CALL lo_exp_node_xml.setAttribute("on_module_path","N")

  #開檔將String Buffer寫入實體檔案
  CALL lo_xml_aps_document.setFeature("format-pretty-print", "TRUE")
  CALL lo_xml_aps_document.save(cs_adzp050_env_file)

  IF os.Path.exists(cs_adzp050_env_file) THEN 
    DISPLAY cs_message_tag,"adzp050 environment file generate success !"
  ELSE
    DISPLAY cs_error_tag,"adzp050 environment file generate fail !"
  END IF  
  
END FUNCTION

FUNCTION adzp050_get_environment_xml_file(p_env_path,p_client_path)
DEFINE
  p_env_path    STRING,
  p_client_path STRING
DEFINE
  ls_env_path         STRING,
  ls_client_path      STRING,
  lb_result           BOOLEAN,
  ls_source_file      STRING,
  ls_destination_file STRING,
  ls_separator        STRING
DEFINE
  lb_return BOOLEAN  
  
  LET ls_env_path    = p_env_path
  LET ls_client_path = p_client_path

  LET lb_return = TRUE
  LET ls_separator = os.Path.separator()
  
  CALL os.Path.chdir(ls_env_path) RETURNING lb_result  

  LET ls_source_file      = ls_client_path,"\\mta\\",cs_adzp050_env_file
  LET ls_destination_file = ls_env_path,ls_separator,cs_adzp050_env_file

  DISPLAY cs_message_tag,"Source file : ",ls_source_file
  DISPLAY cs_message_tag,"Destination file : ",ls_destination_file

  TRY
    CALL FGL_GETFILE(ls_source_file,ls_destination_file)
    DISPLAY cs_message_tag,"Upload ",cs_adzp050_env_file," success ! "
  CATCH
    LET lb_return = FALSE 
    DISPLAY cs_warning_tag,"Upload ",cs_adzp050_env_file," fault ! "
  END TRY  

  RETURN lb_return
  
END FUNCTION

FUNCTION adzp050_set_environment_xml_file(p_env_path,p_client_path)
DEFINE
  p_env_path    STRING,
  p_client_path STRING
DEFINE
  ls_env_path         STRING,
  ls_client_path      STRING,
  lb_result           BOOLEAN,
  ls_source_file      STRING,
  ls_destination_file STRING,
  ls_separator        STRING
DEFINE
  lb_return BOOLEAN  
  
  LET ls_env_path    = p_env_path
  LET ls_client_path = p_client_path

  LET lb_return = TRUE
  LET ls_separator = os.Path.separator()
  
  CALL os.Path.chdir(ls_env_path) RETURNING lb_result  

  LET ls_source_file      = ls_env_path,ls_separator,cs_adzp050_env_file
  LET ls_destination_file = ls_client_path,"\\mta\\",cs_adzp050_env_file

  DISPLAY cs_message_tag,"Source file : ",ls_source_file
  DISPLAY cs_message_tag,"Destination file : ",ls_destination_file

  TRY
    CALL FGL_PUTFILE(ls_source_file,ls_destination_file)
    DISPLAY cs_message_tag,"Download ",cs_adzp050_env_file," success ! "
    CALL sadzp050_zip_grant_clinet_permission(ls_destination_file,FALSE) RETURNING lb_result #170111-00006
  CATCH
    LET lb_return = FALSE 
    DISPLAY cs_warning_tag,"Download ",cs_adzp050_env_file," fault ! "
  END TRY  

  RETURN lb_return
  
END FUNCTION
#xxxxxx-xxxxx end

#161028-00001 begin
FUNCTION adzp050_get_standard_module(p_module_name)
DEFINE
  p_module_name  STRING
DEFINE
  ls_module_name     STRING,
  ls_sql             STRING,
  ls_standard_module VARCHAR(50),
  ls_return          STRING

  LET ls_module_name = p_module_name

  LET ls_sql = "SELECT ZJ.GZZJ003                        ",
               "  FROM GZZJ_T ZJ                         ",
               " WHERE ZJ.GZZJ001 = '",ls_module_name,"' ",
               " ORDER BY ZJ.GZZJ001                     "
                              
  PREPARE lpre_get_standard_module FROM ls_sql
  DECLARE lcur_get_standard_module CURSOR FOR lpre_get_standard_module

  OPEN lcur_get_standard_module
  FETCH lcur_get_standard_module INTO ls_standard_module
  CLOSE lcur_get_standard_module
  
  FREE lpre_get_standard_module
  FREE lcur_get_standard_module  

  LET ls_return = ls_standard_module
  
  RETURN ls_return
  
END FUNCTION

FUNCTION adzp050_set_download_progress(p_progress)
DEFINE
  p_progress INTEGER
DEFINE
  li_progress INTEGER

  LET li_progress = p_progress
  
  DISPLAY li_progress TO formonly.pgb_main
  CALL ui.Interface.refresh()
  
END FUNCTION
#161028-00001 end

#170111-00006 begin
FUNCTION adzp050_check_if_unlock_section(p_program_name,p_prog_ver)
DEFINE
  p_program_name  STRING,
  p_prog_ver      STRING
DEFINE
  ls_program_name  STRING,
  ls_prog_ver      STRING,
  ls_sql           STRING,
  li_count         INTEGER
DEFINE  
  lb_return  BOOLEAN

  LET ls_program_name = p_program_name
  LET ls_prog_ver     = NVL(p_prog_ver.trim(),"0")

  LET ls_sql = "SELECT COUNT(*)                        ",
               "  FROM DZBC_T                          ",
               " WHERE DZBC001 = '",ls_program_name,"' ",
               "   AND DZBC002 = ",ls_prog_ver,"       ",
               "   AND DZBC005 = 'm'                   ",
               "   AND DZBC007 = 's'                   "
                               
  PREPARE lpre_check_if_unlock_section FROM ls_sql
  DECLARE lcur_check_if_unlock_section CURSOR FOR lpre_check_if_unlock_section

  OPEN lcur_check_if_unlock_section
  FETCH lcur_check_if_unlock_section INTO li_count
  CLOSE lcur_check_if_unlock_section
  
  FREE lpre_check_if_unlock_section
  FREE lcur_check_if_unlock_section  

  LET lb_return = IIF(li_count > 0,TRUE,FALSE)
  
  RETURN lb_return
  
END FUNCTION
#170111-00006 end

