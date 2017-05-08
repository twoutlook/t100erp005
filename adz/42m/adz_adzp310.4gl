{
  異動型態    異動單號         日 期       異動者      異動內容
  ========= =============== ========== ========== ===============================================
  Modify                    20160428   Circle.Lai 新增批次執行建構功能
  Modify                    20160525   Circle.Lai 執行建構行為變更，辨識資料庫代號 erpdb, awsdb
  Modify                    20160930   Circle.Lai 修改patch機制，依照本地環境決定是否執行建構(sadzp310_adpt)
  Modify                    20161102   Circle.Lai 修改patch機制
  Modify                    20161124   circlelai  修改 trigger 執行建構後設置disable, enable 機制
  Modify    160309-00001#1  20170208   circlelai  [問題修正]中間表新增PK欄位問題,column contains NULL.
  =========
  新增'fixme' flag 備註之後要優化的地方
# 170210-00052#1 ver:20170218 2017/02/10 by circlelai 新增欄位dzit011區分新舊版 trigger script 
}

&include "../4gl/sadzp310_mcr.inc"

IMPORT util 
IMPORT os 

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp310_type.inc"

CONSTANT cs_version       STRING = "20170218"

#執行的環境變數
DEFINE 
  ms_lang         STRING,
  mb_fault        BOOLEAN,
  mo_arguments    T_ARGUMENTS,
  mb_args_exists  BOOLEAN
            
MAIN
DEFINE
  lb_result        BOOLEAN,
  ls_TAR_file_path STRING
     
  CALL adzp310_initialize()
  CALL adzp310_start()
  CALL adzp310_finalize()
    
END MAIN

FUNCTION adzp310_initialize()
DEFINE
  li_args        INTEGER,
  li_loop        INTEGER,
  ls_args        STRING,
  lb_result      BOOLEAN,  
  li_total_args  INTEGER,
  lb_args_exists BOOLEAN

  LET lb_args_exists = TRUE
  
  &ifndef DEBUG
    #依模組進行系統初始化設定(系統設定)
    CALL cl_tool_init()
    CALL cl_db_connect("ds", TRUE)
    #CONNECT TO "ds"
    LET ms_lang = NVL(g_lang,cs_default_lang)
  &else
    CONNECT TO "local"
    LET ms_lang = cs_default_lang
  &endif

  #選項參數先給預設值
  LET mo_arguments.a_SHOW_DIALOG   = FALSE  --預設不顯示視窗
  LET mo_arguments.a_MAKE_ASSEMBLE = FALSE  --預設不執行異動
  LET mo_arguments.a_MAKE_REBUILD  = FALSE  --? 功能尚未建立，預埋功能'依照設計資料重新建構'
  LET mo_arguments.a_BACKEND_MODE  = TRUE   --預設背景模式執行

  #設定參數
  LET li_args = NUM_ARGS()

  #先作參數的檢核
  LET li_total_args = 0
  FOR li_loop = 1 TO li_args
    LET ls_args = UPSHIFT(ARG_VAL(li_loop))
    IF ls_args LIKE "-%" THEN
      LET li_total_args = li_total_args + 1
    END IF
  END FOR 
  IF li_total_args = 0 THEN 
    LET lb_args_exists = FALSE 
  END IF

  #參數有存在或正確的時候, 才會進行實際參數的指定
  IF lb_args_exists THEN
    FOR li_loop = 1 TO li_args
      LET ls_args = UPSHIFT(ARG_VAL(li_loop))

      #驗證參數
      CALL adzp310_check_arguments(ls_args,ARG_VAL(li_loop + 1)) RETURNING lb_result
      IF NOT lb_result THEN LET mb_fault = TRUE EXIT FOR END IF
      
      CASE 
        WHEN ls_args = cs_args_working_type  
          LET mo_arguments.a_WORKING_TYPE = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_construct_type
          LET mo_arguments.a_CONSTRUCT_TYPE = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_working_object
          LET mo_arguments.a_WORKING_OBJECT = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_working_file  
          LET mo_arguments.a_WORKING_FILE = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_working_path  
          LET mo_arguments.a_WORKING_PATH = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_working_xml   
          LET mo_arguments.a_WORKING_XML = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_working_guid  
          LET mo_arguments.a_WORKING_GUID = ARG_VAL(li_loop + 1)
        WHEN ls_args = cs_args_source_full_name
          LET mo_arguments.a_SOURCE_FULL_NAME = ARG_VAL(li_loop + 1) 
        WHEN ls_args = cs_args_export_file_location
          LET mo_arguments. a_EXPORT_FILE_LOCATION = ARG_VAL(li_loop + 1) 
        WHEN ls_args = cs_args_show_dialog
          LET mo_arguments.a_SHOW_DIALOG = TRUE
        WHEN ls_args = cs_args_make_assemble
          LET mo_arguments.a_MAKE_ASSEMBLE = TRUE
        WHEN ls_args = cs_args_make_rebuild
          LET mo_arguments.a_MAKE_REBUILD = TRUE
        WHEN ls_args = cs_args_backend_mode  
          LET mo_arguments.a_BACKEND_MODE = TRUE
      END CASE 
      
    END FOR
  END IF  

  LET mb_args_exists = lb_args_exists

  {
  #for test
  ###################
  LET mb_args_exists = TRUE
  LET mo_arguments.a_SHOW_DIALOG = TRUE
  LET mo_arguments.a_MAKE_ASSEMBLE = TRUE
  LET mo_arguments.a_BACKEND_MODE = FALSE
  ##EXPORT
  
  LET mo_arguments.a_WORKING_TYPE   = cs_mdm_export 
  LET mo_arguments.a_CONSTRUCT_TYPE = cs_mdm_construct_type_view
  LET mo_arguments.a_WORKING_OBJECT = "all_ernesttestuc_v"
  LET mo_arguments.a_EXPORT_FILE_LOCATION = "c:\\temp\\"
  
  ##IMPORT
  
  LET mo_arguments.a_WORKING_TYPE     = cs_mdm_import 
  LET mo_arguments.a_SOURCE_FULL_NAME = "C:\\TEMP\\erp_testernest_v_VIEW_999999-99999_99999.tvz"
  LET mo_arguments.a_WORKING_OBJECT   = "erp_ernesttestuc_v"
  
  ####################
  }

  #驗證參數失敗, 直接結束
  IF mb_fault THEN CALL adzp310_finalize() END IF
  
END FUNCTION

FUNCTION adzp310_start()
DEFINE
  lb_backend_mode BOOLEAN,
  lb_result       BOOLEAN,
  lo_COMPRESS_FILE_INFO T_COMPRESS_FILE_INFO

  LET lb_backend_mode = NVL(mo_arguments.a_BACKEND_MODE,FALSE)
  
  IF mb_args_exists THEN 
    CALL sadzp310_run(lb_backend_mode,mo_arguments.*) RETURNING lb_result,lo_COMPRESS_FILE_INFO.*
  ELSE 
    CALL adzp310_help()
  END IF  
  
END FUNCTION

FUNCTION adzp310_finalize()

  IF mb_fault THEN
    EXIT PROGRAM -1 
  ELSE
    EXIT PROGRAM 
  END IF
  
END FUNCTION

FUNCTION adzp310_help()
  
  DISPLAY "\n",
          "Usage :","\n",
          "  r.r adzp310 [Options] [Arguments]","\n","\n",
          "  Options :","\n",
          "    -SD : Show input/ouput dialog.","\n",  
          "    -MA : Make assemble when import data completed.","\n",
          --"    -MR : Make table rebuild, using with -MA option.","\n",  
          "    -BM : Run this program on backend mode.","\n","\n",
          "  Arguments :","\n",  
          "    -WT : Working Type ","\n",
          "      iexp : Export object datas.","\n",
          "      iimp : Import object datas.","\n",
          "      iasm : batch Create/Alter Object with design data..","\n", #160309-00001#1 add 'iasm' function by circlelai 
          "    -CT : Construct type ","\n",
          "      MT : MDM Table ","\n",
          "      MG : MDM Trigger ","\n",
          "      MV : MDM View ","\n",
          "    -WO : Working object name.","\n",  
          "    -SFN : Source package name with full path.","\n",
          "    -EFL : Export file location.","\n","\n",  
          "  Example :","\n",
          "    GUI Mode :","\n",
          "      Export objects :","\n",
          "        r.r adzp310 -SD -WT iexp -CT MT -WO 'all_bcme_t'","\n",
          "        r.r adzp310 -SD -WT iexp -CT MG -WO 'imaa_trg'","\n",
          "        r.r adzp310 -SD -WT iexp -CT MV -WO 'all_gcaf02_v'","\n",
          "      Import objects :","\n",
          "        r.r adzp310 -SD -WT iimp -MA","\n",
          "    Text Mode :","\n",
          "      Export objects :","\n",
          "        r.r adzp310 -WT iexp -CT MT -WO 'all_bcme_t' -EFL '/u3/usr/testuser/adzp310'","\n",
          "        r.r adzp310 -WT iexp -CT MG -WO 'imaa_trg' -EFL '/u3/usr/testuser/adzp310'","\n",
          "        r.r adzp310 -WT iexp -CT MV -WO 'all_gcaf02_v' -EFL '/u3/usr/testuser/adzp310'","\n",
          "      Import objects :","\n",
          "        r.r adzp310 -WT iimp -MA -SFN '/u3/usr/testuser/adzp310/all_bcme_t_MTABLE_999999-99999_99999.tvz'","\n",
          "      Create/Alter all objects :","\n",
          "        r.r adzp310 -WT iasm -CT MT -WO ALL","\n",
          "        r.r adzp310 -WT iasm -CT MG -WO ALL","\n",
          "        r.r adzp310 -WT iasm -CT MV -WO ALL","\n",
          "      Create/Alter some of selected objects:","\n",
          "        r.r adzp310 -WT iasm -CT MT -WO 'all_bcme_t,all_ooca_t'","\n",
          "        r.r adzp310 -WT iasm -CT MG -WO 'ooca_trg,loaa_trg'","\n",
          "        r.r adzp310 -WT iasm -CT MV -WO 'all_imaf01_v,all_imay01_v'","\n"
        , cs_information_tag , "Version : " , cs_version
END FUNCTION 

FUNCTION adzp310_check_arguments(p_argument_type,p_value)
DEFINE
  p_argument_type STRING,
  p_value         STRING
DEFINE
  ls_argument_type STRING,
  ls_value         STRING
DEFINE
  lb_return BOOLEAN

  LET ls_argument_type = p_argument_type
  LET ls_value = p_value

  LET lb_return = TRUE

  CASE 
    WHEN ls_argument_type = cs_args_working_type
      CASE
        WHEN ls_value = cs_mdm_export
        WHEN ls_value = cs_mdm_import
        WHEN ls_value = cs_mdm_assemble #160309-00001#1 add by circlelai
        OTHERWISE
          DISPLAY cs_error_tag,ls_argument_type," : The working type '",ls_value,"' not correct."
          LET lb_return = FALSE
      END CASE   
    WHEN ls_argument_type = cs_args_construct_type
      CASE
        WHEN ls_value = cs_mdm_construct_type_table
        WHEN ls_value = cs_mdm_construct_type_trigger
        WHEN ls_value = cs_mdm_construct_type_view
        OTHERWISE
          DISPLAY cs_error_tag,ls_argument_type," : The construct type '",ls_value,"' not correct."
          LET lb_return = FALSE
      END CASE   
    WHEN ls_argument_type = cs_args_working_object
      IF ls_value LIKE '-%' THEN 
        DISPLAY cs_error_tag,ls_argument_type," : The argument '",ls_value,"' not correct."
        LET lb_return = FALSE
      END IF      
    WHEN ls_argument_type = cs_args_working_file  
      IF NOT os.Path.exists(ls_value) THEN
        DISPLAY cs_error_tag,ls_argument_type," : The file '",ls_value,"' not exists."
        LET lb_return = FALSE
      END IF
    WHEN ls_argument_type = cs_args_working_path  
      IF NOT os.Path.isdirectory(ls_value) THEN
        DISPLAY cs_error_tag,ls_argument_type," : The workinh path '",ls_value,"' not exists."
        LET lb_return = FALSE
      END IF
    WHEN ls_argument_type = cs_args_working_xml   
      IF NOT os.Path.exists(ls_value) THEN
        DISPLAY cs_error_tag,ls_argument_type," : The XML file '",ls_value,"' not exists."
        LET lb_return = FALSE
      END IF
    WHEN ls_argument_type = cs_args_working_guid  
      IF ls_value LIKE '-%' THEN 
        DISPLAY cs_error_tag,ls_argument_type," : The GUID value '",ls_value,"' not correct."
        LET lb_return = FALSE
      END IF      
    WHEN ls_argument_type = cs_args_source_full_name
      IF NOT os.Path.exists(ls_value) THEN
        DISPLAY cs_error_tag,ls_argument_type," : The file '",ls_value,"' not exists."
        LET lb_return = FALSE
      END IF
    WHEN ls_argument_type = cs_args_export_file_location
      IF NOT os.Path.isdirectory(ls_value) THEN
        DISPLAY cs_error_tag,ls_argument_type," : The export directory '",ls_value,"' not exists."
        LET lb_return = FALSE
      END IF
  END CASE 

  RETURN lb_return

END FUNCTION