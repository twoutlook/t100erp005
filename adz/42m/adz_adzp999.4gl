#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: adzp999
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp999.4gl 
# Description    : ALM端註冊資料匯出入過單作業
# Memo           :
#                  2016/02/22 by ka0132 排除adzp888相關動作
#                  20160223 160223-00028 by madey :patch優化專案
#                  2016/12/30            by ka0132:多語言打包機制調整
#                  2017/02/13            by ka0132 引導式Patch串接

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzi888_global.inc"

#CONSTANT g_patch_unl_path = "/u3/usr/jay"
CONSTANT g_patch_unl_path = "/u6/scm"
CONSTANT g_adzp999_patch_unl = "adzp999_patch.unl"

DEFINE g_alm_tar_path       STRING              #ALM執行匯出/入時,tar放置完整路徑
DEFINE g_rqpg_unl_path      STRING              #adzi800匯出打單需求單項次清單完整路徑

MAIN
   DEFINE l_master013       LIKE type_t.chr20     #需求單號
   DEFINE l_master014       LIKE type_t.num5      #作業項次
   DEFINE l_alm_tar_path    STRING                #ALM執行匯出/入時,tar放置完整路徑
   DEFINE l_patch_num       STRING                #patch number
   DEFINE l_user_pwd        STRING
   DEFINE l_patch_pwd       STRING
   DEFINE l_cmd             STRING
   
   DEFINE l_result          BOOLEAN
   DEFINE l_error_message   STRING
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
   CALL cl_tool_init()

   #切換至使用者所需要的資料庫 (營運中心)
   CALL cl_db_connect("ds", FALSE)

   #打包或解包
   LET g_run_mode = ARG_VAL(2)
   LET g_exp_para = ""
   LET l_error_message = ""
   LET g_error_message = ""
   LET g_adzp999_01_s01 = FALSE

   #topstd帳號不可進行任何匯出/入動作
   IF g_account = "topstd" THEN
      #UI 界面情況下才show cl_err
      IF g_run_mode = 4 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00602"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      
      LET g_error_message = "BREAK_ERROR:", cl_getmsg("adz-00602", g_lang)
      RETURN
   END IF

   IF NOT sadzi888_01_create_temp_table() THEN
      CALL sadzi888_01_drop_temp_table()
      DISPLAY "BREAK_ERROR:", g_error_message
      CALL cl_ap_exitprogram("-1")
   END IF
   
   CASE g_run_mode
      #過單方式的打包
      WHEN "1"
         LET l_master013 = ARG_VAL(3)
         LET l_master014 = ARG_VAL(4)
         LET g_exp_para = sadzi888_02_get_ds_password()
         LET g_dmp_mode = TRUE
         LET g_patch_mode = FALSE
         LET g_unload_file = TRUE

         CALL sadzi888_01_alm_export(g_run_mode, l_master013, l_master014)
            RETURNING l_result, l_error_message

         IF l_result THEN
            DISPLAY "pack_path:", l_error_message
            DISPLAY "export_success."
         END IF

      #過單方式的解包
      WHEN "2"
         LET l_alm_tar_path = ARG_VAL(3)
         LET g_exp_para = sadzi888_02_get_ds_password()
         LET g_dmp_mode = TRUE
         LET g_batch_flag = FALSE
         LET g_patch_mode = FALSE
         LET g_unload_file = TRUE

         CALL sadzi888_01_alm_import(g_run_mode, l_alm_tar_path, "")
            RETURNING l_result, l_error_message

         IF l_result THEN
            DISPLAY "import_success."
         END IF
         
      #patch方式的打包
      WHEN "3"
         LET l_patch_num = ARG_VAL(3)
         LET l_user_pwd = sadzi888_02_get_ds_password()
         LET l_patch_pwd = sadzi888_01_get_db_connect_string(g_patch_schema)   #ARG_VAL(5)
         LET g_alm_tar_path = ""
         LET g_batch_flag = TRUE       #是否整批import data
         LET g_patch_mode = TRUE       #是否為patch流程
         LET g_unload_file = FALSE     #是否在export data過程中UNLOAD TO FILE

         IF cl_null(l_patch_pwd) THEN
            CALL sadzi888_01_drop_temp_table()
            CALL cl_ap_exitprogram("-1")
         END IF
   
         #整批處理export data
         IF g_batch_flag THEN
            #先清空dspatch的所有table
            LET l_cmd = "emptydspatch.sh Y "
            DISPLAY l_cmd
            RUN l_cmd

            IF STATUS THEN
               DISPLAY "BREAK_ERROR-", l_cmd.trim(), ":", cl_getmsg(STATUS, g_lang)
               CALL sadzi888_01_drop_temp_table()
               CALL cl_ap_exitprogram("-1")
            END IF
         
            IF NOT adzp999_patch_export_schema(g_sys_schema, l_user_pwd, g_patch_schema, l_patch_pwd) THEN
               DISPLAY "adzp999 BREAK_ERROR:", g_error_message
               CALL sadzi888_01_drop_temp_table()
               CALL cl_ap_exitprogram("-1")
            END IF
         END IF
         
         LET l_result = adzp999_patch_export_pre(l_patch_num, g_patch_schema, l_patch_pwd) 

         IF l_result THEN
            DISPLAY "pack_path:", g_alm_tar_path
            DISPLAY "patch_export_success."
         ELSE
            LET l_error_message = g_error_message
         END IF

         #CALL sadzi888_01_drop_temp_table()
         DROP TABLE adzp999_patch

      #patch解包
      WHEN "4"
         #新版UI方式之patch解包
         CALL adzp999_01()
         DISPLAY "import patch finish."

         IF cl_null(g_error_message) THEN
            LET l_result = TRUE
         ELSE
            LET l_error_message = g_error_message
         END IF
      
      #   #離開作業
      #   CALL cl_ap_exitprogram("0")
      #
      #   #舊版指令方式之patch解包
      #   LET l_alm_tar_path = ARG_VAL(3)
      #   LET l_patch_pwd = ARG_VAL(4)
      #   LET g_batch_flag = TRUE
      #   LET g_patch_mode = TRUE
      #   LET g_unload_file = FALSE     #是否在export data過程中UNLOAD TO FILE
      #   
      #   IF cl_null(ARG_VAL(5)) OR ARG_VAL(5) <> FGL_GETENV("ZONE") THEN
      #      DISPLAY "zone is error."
      #      RETURN
      #   END IF
      #
      #   IF cl_null(l_patch_pwd) THEN
      #      DISPLAY "dspatch pwd is null."
      #      RETURN
      #   END IF
      #   
      #   #是否先import dspatch dmp檔
      #   LET g_import_dapatch = ARG_VAL(6)
      #
      #   #若參數值不符合或為空白時皆認定做Patch完整流程
      #   IF NOT (g_import_dapatch = "Y" OR g_import_dapatch = "N") THEN
      #      LET g_import_dapatch = ""
      #   END IF
      #
      #   #只有當g_import_dapatch="N"時,才不做import dspatch的動作
      #   IF g_batch_flag AND (cl_null(g_import_dapatch) OR g_import_dapatch <> "N") THEN
      #      #先清空dspatch的所有table
      #      LET l_cmd = "emptydspatch.sh Y "
      #      DISPLAY l_cmd
      #      RUN l_cmd
      #
      #      IF STATUS THEN
      #         DISPLAY "BREAK_ERROR-", l_cmd.trim(), ":", cl_getmsg(STATUS, g_lang)
      #         CALL cl_ap_exitprogram("-1")
      #         RETURN
      #      END IF
      #   END IF
      #
      #   #若採取先import dspatch dmp檔時,只純做import dmp還不做patch後續的動作
      #   IF g_import_dapatch = "Y" AND g_batch_flag THEN
      #      IF NOT adzp999_import_dspatch(l_alm_tar_path, l_patch_pwd) THEN
      #         DISPLAY "import dspatch error."
      #         RETURN
      #      END IF
      #
      #      DISPLAY "import dspatch success."
      #      RETURN
      #   END IF
      #   
      #   CALL sadzi888_01_alm_import(g_run_mode, l_alm_tar_path, l_patch_pwd)
      #      RETURNING l_result, l_error_message
      #
      #   IF l_result THEN
      #      DISPLAY "patch_import_success."
      #   END IF

      #需求單過到正式區的打包
      WHEN "5"
         LET l_master013 = ARG_VAL(3)
         LET g_exp_para = sadzi888_02_get_ds_password()
         LET g_dmp_mode = TRUE
         LET g_error_message = ""
         LET g_alm_tar_path = ""
         LET g_batch_flag = FALSE     #是否整批import data
         LET g_patch_mode = FALSE
         LET g_unload_file = TRUE

         LET l_result = adzp999_patch_export_pre(l_master013, "", "")

         IF l_result THEN
            DISPLAY "rqpg_path:", g_alm_tar_path
            DISPLAY "rqpg_export_success."
         ELSE
            LET l_error_message = g_error_message
         END IF

         #CALL sadzi888_01_drop_temp_table()
         DROP TABLE adzp999_patch
         
      #需求單過到正式區的解包
      WHEN "6"
         LET l_alm_tar_path = ARG_VAL(3)
         LET g_exp_para = sadzi888_02_get_ds_password()
         LET g_dmp_mode = TRUE
         LET g_batch_flag = FALSE
         LET g_patch_mode = FALSE
         LET g_unload_file = TRUE

         CALL sadzi888_01_alm_import(g_run_mode, l_alm_tar_path, "")
            RETURNING l_result, l_error_message

         IF l_result THEN
            DISPLAY "import_success."
         END IF
      
      #adzi800需求單過到正式區的打包(客戶家適用)
      WHEN "7"
         LET l_master013 = ARG_VAL(3)
         #LET g_exp_para = ARG_VAL(4)     #sadzi888_02_get_ds_password()
         LET g_exp_para = sadzi888_02_get_ds_password()
         LET g_rqpg_unl_path = ARG_VAL(5)
         LET g_dmp_mode = TRUE
         LET g_error_message = ""
         LET g_alm_tar_path = ""
         LET g_batch_flag = FALSE     #是否整批import data
         LET g_patch_mode = FALSE
         LET g_unload_file = TRUE

         LET l_result = adzp999_patch_export_pre(l_master013, "", "")

         IF l_result THEN
            DISPLAY "rqpg_path:", g_alm_tar_path
            DISPLAY "rqpg_export_success."
         ELSE
            LET l_error_message = g_error_message
         END IF

         #CALL sadzi888_01_drop_temp_table()
         DROP TABLE adzp999_patch

      #2017/02/13
      #patch解包
      WHEN "8"
         #新版UI方式之patch解包
         IF adzp999_01_bgjob() THEN
            DISPLAY "INFO:import patch success."
            
            IF cl_null(g_error_message) THEN
               LET l_result = TRUE
            ELSE
               LET l_error_message = g_error_message
            END IF
         ELSE
            DISPLAY "ERROR:import patch fault."
         END IF

      #2017/02/13
         
   END CASE

   CALL sadzi888_01_drop_temp_table()
   
   #離開作業
   IF l_result THEN
      DISPLAY "adzp999 success."
      CALL cl_ap_exitprogram("0")
   ELSE
      DISPLAY "adzp999 BREAK_ERROR:", l_error_message
      CALL cl_ap_exitprogram("-1")
   END IF
   
END MAIN

#+ 建立temp table
PUBLIC FUNCTION adzp999_crate_temp_table()
   #Create temp table 程式註冊資料匯出主檔
   CREATE TEMP TABLE adzp999_patch
   (
       patch001          VARCHAR(10),       
       patch002          VARCHAR(20),       
       patch003          INTEGER,           
       patch004          VARCHAR(10),       #作業類型
       patch005          VARCHAR(160),      #作業代號
       patch006          VARCHAR(120),      #作業名稱
       patch007          VARCHAR(5),        #階段
       patch008          VARCHAR(20),       #過單人
       patch009          DATE,              #過單時
       patch010          DATE               #簽入時   
   )
END FUNCTION




#+ alm端執行patch匯出前置作業
PRIVATE FUNCTION adzp999_patch_export_pre(p_patch_num, p_patch_user, p_patch_pwd)
   DEFINE p_patch_num       STRING                #patch number
   DEFINE p_patch_user      STRING                #patch chema
   DEFINE p_patch_pwd       STRING
   
   DEFINE l_unl_file        STRING                #此次patch的[需求單號]+[項次]清單
   DEFINE l_sql             STRING
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_pack_dir        STRING                #patch檔打包置放路徑
   DEFINE l_folder          STRING                #patch匯出檔目錄
   DEFINE l_tar_name        STRING                #patch包名稱
   DEFINE l_master_m        type_g_master_m       #程式註冊資料匯出主檔
   DEFINE l_str             STRING
   DEFINE l_cmd             STRING
   DEFINE l_dmp_file        STRING
   DEFINE l_cnt_ddata       LIKE type_t.num5
   DEFINE l_cnt_dfile       LIKE type_t.num5
   DEFINE l_cnt_dtool       LIKE type_t.num5
   DEFINE l_table_list_json util.JSONObject
   DEFINE l_channel         base.Channel
   DEFINE l_parfile         STRING
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_table_temp      STRING
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_dzea001         LIKE dzea_t.dzea001
   DEFINE ls_patch_num      STRING #2016/12/30
   
   IF cl_null(p_patch_num) THEN
      LET g_error_message = "BREAK_ERROR:", cl_getmsg("adz-00372", g_lang)
      RETURN FALSE
   END IF

   #取得此次patch的[需求單號]+[項次]匯出清單unl檔
   IF g_run_mode = "7" THEN
      LET l_unl_file = g_rqpg_unl_path
   ELSE
      LET l_unl_file = os.Path.join(g_patch_unl_path.trim(), p_patch_num.trim())
      LET l_unl_file = os.Path.join(l_unl_file.trim(), g_adzp999_patch_unl.trim())
   END IF

   #檢查unl檔是否存在
   IF NOT os.Path.EXISTS(l_unl_file) THEN
      LET g_error_message = "BREAK_ERROR:chk file_", cl_getmsg_parm("adz-00371", g_lang, l_unl_file.trim())
      RETURN FALSE
   END IF

   CALL adzp999_crate_temp_table()

   #匯入patch清單
   LET l_sql = "INSERT INTO adzp999_patch "
   LOAD FROM l_unl_file l_sql
   
   IF STATUS THEN
      LET g_error_message = "BREAK_ERROR-LOAD FROM ", l_unl_file.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF

   #檢查patch是否有清單資料
   SELECT COUNT(*) INTO l_cnt FROM adzp999_patch

   IF l_cnt = 0 THEN
      LET g_error_message = "BREAK_ERROR:chk list_", cl_getmsg_parm("adz-00371", g_lang, l_unl_file.trim())
      RETURN FALSE
   END IF



   #準備依[需求單號]+[項次]打包資料
   #CALL sadzi888_01_create_temp_table()

   LET g_show_msg = "N"     #背景模式操作
   CALL sadzi888_01_init()

   #切換到$TEMPDIR工作目錄下
   LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
   
   IF NOT sadzi888_01_change_pack_dir(l_pack_dir) THEN
      RETURN FALSE
   END IF
   
   #存放patch包所需檔案的目錄
   LET l_folder = p_patch_num

   #patch包名稱
   LET l_tar_name = l_folder, ".tgz"   

   IF NOT sadzi888_01_make_pack_dir(l_folder, l_tar_name) THEN
      RETURN FALSE
   END IF

   #cp此次過單的需求單號有那些
   LET l_cmd = "cp ", l_unl_file.trim(), " ", g_adzp999_patch_unl.trim()
   RUN l_cmd
      
   IF STATUS THEN
      LET g_error_message = "BREAK_ERROR-cp ", g_adzp999_patch_unl.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF

   CALL adzp999_init()

   #設定一個匯出入的UUID
   LET l_master_m.master001 = security.RandomGenerator.CreateUUIDString()

   #匯出主題直接設定成patch number
   LET l_master_m.master002 = p_patch_num.trim()
   LET l_master_m.master003 = g_user CLIPPED
   LET l_master_m.master009 = cl_get_current()
   LET l_master_m.master012 = FGL_GETENV("ZONE")    #區域別
   LET l_master_m.master013 = ""
   LET l_master_m.master014 = ""
   
   INSERT INTO adzi888_master(master001, master002, master003, master004, master005,
                              master006, master007, master008, master009, master010, 
                              master011, master012, master013, master014)
     VALUES (l_master_m.master001, l_master_m.master002, l_master_m.master003, l_master_m.master004, l_master_m.master005, 
             l_master_m.master006, l_master_m.master007, l_master_m.master008, l_master_m.master009, l_master_m.master010, 
             l_master_m.master011, l_master_m.master012, l_master_m.master013, l_master_m.master014) 
 
   IF SQLCA.sqlcode THEN
      LET g_error_message = "BREAK_ERROR-INSERT adzi888_master:", cl_getmsg(SQLCA.sqlcode, g_lang)
      RETURN FALSE 
   END IF




   #開始記錄匯入log(patch方式的打包)
   CALL sadzi888_01_log_file_start(g_run_mode, l_master_m.master002)
   
   #防止其他FUNCTION切換路徑,所需把路徑切回目前工作路徑
   LET l_str = os.Path.pwd()
   
   #依[需求單號]+[項次]開始取得所有patch所需匯出的清單資訊
   IF NOT adzp999_patch_export(l_master_m.master001) THEN
      RETURN FALSE
   END IF

   #把路徑切回打包的工作路徑
   IF NOT os.Path.chdir(l_str) THEN
      LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_str.trim())
      RETURN FALSE
   END IF

   SELECT COUNT(*) INTO l_cnt_ddata FROM adzi888_ddata
   DISPLAY "adzi888_ddata count(*):", l_cnt_ddata 

   SELECT COUNT(*) INTO l_cnt_dfile FROM adzi888_dfile
   DISPLAY "adzi888_dfile count(*):", l_cnt_dfile 

   SELECT COUNT(*) INTO l_cnt_dtool FROM adzi888_dtool
   DISPLAY "adzi888_dtool count(*):", l_cnt_dtool

   #沒有任何[設定]資料或[設計]資訊或[IT工具]要patch
   IF l_cnt_ddata = 0 AND l_cnt_dfile = 0 AND l_cnt_dtool = 0 THEN
      IF g_run_mode = "5" OR g_run_mode = "7" THEN
         LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00479", g_lang, p_patch_num.trim())
      ELSE
         LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00373", g_lang, p_patch_num.trim())
      END IF
      RETURN FALSE
   END IF

   #取得程式相關設計資料資訊
   IF NOT adzp999_01_exp_get_dzye_pre(l_master_m.master002) THEN
      RETURN FALSE
   END IF

   #[patch資料]匯出
   IF g_run_mode = "5" OR g_run_mode = "7" THEN
      #需求單過單到正式區採data dmp方式匯出
      IF NOT sadzi888_01_export_data_dmp(l_master_m.master001, "", "") THEN
         RETURN FALSE
      END IF
   ELSE
      IF NOT sadzi888_01_export_data(l_master_m.master001, "", "") THEN
         RETURN FALSE
      END IF
   END IF

   #IF g_patch_mode THEN
   #   #patch打包資料需將SA的規格描述資料update
   #   IF NOT adzp999_upd_spec_data() THEN
   #      RETURN FALSE
   #   END IF
   #END IF
   
   #[patch schema]exp dmp
   IF (NOT cl_null(g_batch_flag)) AND (g_batch_flag) THEN

      #只取得patch時需用到的table
      LET l_parfile = "table_list_json.dat"
      
      LET l_channel = base.Channel.create()
      CALL l_channel.openFile(l_parfile, "w")

      IF STATUS THEN
         LET g_error_message = "ERROR-openFile ", l_parfile.trim(), ":", cl_getmsg(STATUS, g_lang)
         RETURN FALSE
      END IF

      CALL l_channel.setDelimiter("")

      
      #取得此次patch summary file
      CALL sadzi888_01_get_summary_file()
         RETURNING l_success, l_table_list_json

      IF NOT l_success THEN
         RETURN FALSE
      END IF

      LET l_table_temp = ""
      
      FOR l_i = 1 TO l_table_list_json.getLength()
         #取得資料表代碼
         LET l_dzea001 = l_table_list_json.name(l_i)

         IF l_table_temp.getLength() = 0 THEN
            LET l_table_temp = l_dzea001 CLIPPED
         ELSE
            LET l_table_temp = l_table_temp, ",", l_dzea001 CLIPPED
         END IF
      END FOR

      IF l_table_temp.getLength() = 0 THEN
         LET g_error_message = "ERROR-", cl_getmsg_parm("adz-00385", g_lang, "patch")
         RETURN FALSE
      END IF
      
      #寫入exp 所需的parfile
      #指定dmp的table
      LET l_str = "TABLES=", l_table_temp.trim()
      CALL l_channel.write(l_str)
      CALL l_channel.close()

      #指定dmp檔名稱
      LET l_dmp_file = p_patch_user.trim(), ".dmp"
   
      #exp dspatch
      #LET l_cmd = "exp ", p_patch_user.trim(), "/", p_patch_pwd.trim(), " OWNER=", p_patch_user.trim(), " ",
      #            "FILE=", l_dmp_file.trim(), " LOG=", p_patch_user.trim(), ".explog STATISTICS=NONE"
      LET l_cmd = "exp ", p_patch_user.trim(), "/", p_patch_pwd.trim(), " ",
                  "FILE=", l_dmp_file.trim(), " LOG=", p_patch_user.trim(), ".explog STATISTICS=NONE PARFILE=", l_parfile.trim()
         
      IF NOT sadzi888_01_run_command(l_cmd) THEN
         RETURN FALSE
      END IF

      #gzip dmp檔
      LET l_cmd = "gzip ", l_dmp_file.trim()
      RUN l_cmd
   
      IF STATUS THEN
         LET g_error_message = "BREAK_ERROR:", l_cmd.trim(), ":", cl_getmsg(STATUS, g_lang)
         RETURN FALSE
      END IF

      #檢查gzip檔是否存在
      LET l_dmp_file = l_dmp_file.trim(), ".gz"
      IF NOT os.Path.EXISTS(l_dmp_file) THEN
         LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_dmp_file.trim())
         RETURN FALSE
      END IF
   END IF

   #azzi933特別處理
   #CALL sadzi888_01_azzi933_export(l_master_m.master001)

   #Begin: 160223-00028
   #source處理
   IF NOT sadzi888_01_export_source(l_pack_dir, l_folder) THEN
      RETURN FALSE
   END IF
   #End: 160223-00028
   
   #檢查檔案匯出清單是否有資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM adzi888_dfile

   IF l_cnt > 0 THEN
      IF NOT sadzi888_01_export_file(l_master_m.master001, "", "", l_pack_dir, l_folder) THEN
         RETURN FALSE
      END IF
   END IF

   #檢查IT工具匯出清單是否有資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM adzi888_dtool

   IF l_cnt > 0 THEN
      IF NOT sadzi888_01_export_tool(l_master_m.master001, "", "", l_pack_dir, l_folder) THEN
         RETURN FALSE
      END IF
   END IF

   #匯出此次打包清單資訊
   IF NOT sadzi888_01_export_pack_list(l_master_m.master001) THEN
      RETURN FALSE
   END IF

   #返回上一層目錄
   LET l_str = os.Path.pwd()
   LET l_str = os.Path.dirname(l_str)
   IF NOT os.Path.chdir(l_str) THEN
      LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_str.trim())
      RETURN FALSE
   END IF
   
   #2016/12/30
   LET ls_patch_num = ARG_VAL(3)
   #若為例行(月)包才進行多語言打包
   IF ls_patch_num.getIndexOf('TSD-3',1) > 0 THEN
      #LET l_cmd = "pack_lang ", os.Path.join(g_pack_dir_env, l_folder.trim())
      LET l_cmd = "pack_lang ", os.Path.join(FGL_GETENV(g_pack_dir_env), l_folder.trim())
      DISPLAY l_cmd
      CALL sadzi888_01_log_file_write(l_cmd)
      RUN l_cmd
   END IF
   #2016/12/30

   #打包成tar檔範例:tar zcvf $FOLDER.tar $FOLDER
   #IF (NOT cl_null(g_patch_file_path)) AND os.Path.EXISTS(g_patch_file_path) THEN
   #   LET l_str = g_patch_file_path
   #   LET l_cmd = "tar zcvf ", os.Path.join(l_str.trim(), l_tar_name CLIPPED), " ", l_folder CLIPPED
   #ELSE
   LET l_cmd = "tar zcvf ", l_tar_name CLIPPED, " ", l_folder CLIPPED
   #END IF
   
   RUN l_cmd

   IF STATUS THEN
      LET g_error_message = "BREAK_ERROR-tar zcvf ", l_tar_name CLIPPED, ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF

   #匯出包tar檔所在完整路徑
   LET g_alm_tar_path = os.Path.join(l_str.trim(), l_tar_name.trim())

   IF cl_null(g_alm_tar_path) THEN
      DISPLAY "BREAK_ERROR:g_alm_tar_path is error."
      RETURN FALSE
   END IF
   
   #切換回正確程式執行路徑
   IF NOT sadzi888_01_change_work_dir() THEN
      RETURN FALSE
   END IF

   #結束記錄log
   CALL sadzi888_01_log_file_write("pack_path:" || g_alm_tar_path.trim())
   CALL sadzi888_01_log_file_end()

   LET g_error_message = ""
   
   RETURN TRUE
END FUNCTION

#+ 初始化
PUBLIC FUNCTION adzp999_init()
   DEFINE l_sql             STRING
   
   #取得需要patch的清單([需求單號]+[項次])
   LET l_sql = "SELECT DISTINCT patch002, patch003 ",
               "  FROM adzp999_patch "
   DECLARE adzp999_patch_list_cs CURSOR WITH HOLD FROM l_sql

   #取得[需求單號]+[項次]的設定資料匯出清單
   LET l_sql = "SELECT dzld002, dzld003, dzld004, dzld005, dzld006, ",
               "       dzld007, dzld008, dzld009, dzld010, dzld015 ",
               "  FROM dzld_t ",
               "  WHERE dzld011 = ? ",
               "    AND dzld012 = ? ",
               "    AND dzld013 = ? ",
               "    AND dzld014 = ? ",
               "    AND dzld016 IS NOT NULL "
   DECLARE adzp999_dzld_list_cs CURSOR WITH HOLD FROM l_sql

   LET l_sql = "SELECT dzlf002, dzlf003, dzlf004, dzlf005, dzlf006, ",
               "       dzlf007 ",
               "  FROM dzlf_t ",
               "  WHERE dzlf008 = ? ",
               "    AND dzlf009 = ? ",
               "    AND dzlf010 = ? ",
               "    AND dzlf011 = ? ",
               "    AND dzlf012 IS NOT NULL "
   DECLARE adzp999_dzlf_list_cs CURSOR WITH HOLD FROM l_sql
   
   LET l_sql = "SELECT dzlt002, dzlt003, dzlt004, dzlt005, dzlt006, ",
               "       dzlt007, dzlt008, dzlt009 ",
               "  FROM dzlt_t ",
               "  WHERE dzlt011 = ? ",
               "    AND dzlt012 = ? ",
               "    AND dzlt013 = ? ",
               "    AND dzlt014 = ? ",
               "    AND dzlt010 IS NOT NULL "
   DECLARE adzp999_dzlt_list_cs CURSOR WITH HOLD FROM l_sql
   
END FUNCTION

#+ patch匯出時,先將ds schema exp至dspatch
PRIVATE FUNCTION adzp999_patch_export_schema(p_db_user, p_user_pwd, p_patch_user, p_patch_pwd)
   DEFINE p_db_user         STRING               #系統schema
   DEFINE p_user_pwd        STRING
   DEFINE p_patch_user      STRING               #patch chema
   DEFINE p_patch_pwd       STRING

   DEFINE l_cmd             STRING
   DEFINE l_dmp_file        STRING

   #指定dmp檔名稱
   LET l_dmp_file = p_db_user.trim(), ".dmp"
   
   #exp ds schema command
   LET l_cmd = "exp ", p_db_user.trim(), "/", p_user_pwd.trim(), " OWNER=", p_db_user.trim(), " ",
               "ROWS=N FILE=", l_dmp_file.trim(), " LOG=", p_db_user.trim(), ".explog STATISTICS=NONE"

   RUN l_cmd
   
   IF STATUS THEN
      LET g_error_message = "BREAK_ERROR-exp ", p_db_user.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF

   #檢查dmp檔是否存在
   IF NOT os.Path.EXISTS(l_dmp_file) THEN
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_dmp_file.trim())
      RETURN FALSE
   END IF
   
   #imp ds to dspatch
   LET l_cmd = "imp ", p_patch_user.trim(), "/", p_patch_pwd.trim(), " FROMUSER=", p_db_user.trim(), " ",
               "TOUSER=", p_patch_user.trim(), " FILE=", l_dmp_file.trim(), " ",
               "LOG=", p_patch_user.trim(), ".implog STATISTICS=NONE"
   
   RUN l_cmd
   
   IF STATUS THEN
      LET g_error_message = "BREAK_ERROR-exp ", p_db_user.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ 依[需求單號]+[項次]開始取得所有patch所需匯出的清單資訊
PRIVATE FUNCTION adzp999_patch_export(p_master001)
   DEFINE p_master001       LIKE type_t.chr50     #GUID

   DEFINE l_patch002        LIKE type_t.chr20     #需求單號
   DEFINE l_patch003        LIKE type_t.num5      #項次
   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_cnt             LIKE type_t.num5

   #取得此次patch所有[需求單號]+[項次]清單
   FOREACH adzp999_patch_list_cs INTO l_patch002, l_patch003
      IF SQLCA.sqlcode THEN
         LET g_error_message = "BREAK_ERROR-", l_patch002 CLIPPED, ".", l_patch003 USING "<<<<<", "-FOREACH adzp999_patch_list_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         RETURN FALSE
      END IF

      #run mode="5"(需求單打包)的過單需包含table的過單
      IF g_run_mode = "5" OR g_run_mode = "7" THEN
         #取得所有此次patch[資料表(table)]清單
         SELECT COUNT(*) INTO l_cnt FROM dzlm_t
           WHERE dzlm001 = 'T'
             AND dzlm012 = l_patch002
             AND dzlm013 = g_dzld012
             AND dzlm014 = g_dzld013
             AND dzlm015 = l_patch003
      
         IF l_cnt > 0 THEN
            IF NOT sadzi888_01_dzea_export(l_patch002, l_patch003) THEN
               LET g_error_message = "BREAK_ERROR-export dzea:", l_patch002 CLIPPED, ".", l_patch003 USING "<<<<<"
               RETURN FALSE
            END IF
         END IF
      END IF
      
      #取得所有此次patch[設定資料]清單
      IF NOT adzp999_patch_dzld_export(p_master001, l_patch002, l_patch003) THEN
         RETURN FALSE
      END IF

      #取得所有此次patch[檔案]清單
      IF NOT adzp999_patch_dzlf_export(p_master001, l_patch002, l_patch003) THEN
         RETURN FALSE
      END IF
      
      #取得所有此次patch[IT工具]清單
      IF NOT adzp999_patch_dzlt_export(p_master001, l_patch002, l_patch003) THEN
         RETURN FALSE
      END IF
      
      #依[需求單號]+[項次]呼叫新增[設計資料]的patch資訊,且是patch方式的打包
      #todo:第一個參數改成g_run_mode,且須通知其他人配合,打包方式同patch("3")
      CALL sadzi888_02_insert_temp_table_for_design_data("3", l_patch002, l_patch003)
         RETURNING l_success, g_error_message

      IF NOT l_success THEN
         RETURN FALSE
      END IF
   
   END FOREACH
   
   RETURN TRUE
END FUNCTION

#+ 依[需求單號]+[項次]開始執行patch[設定資料]匯出打包
PRIVATE FUNCTION adzp999_patch_dzld_export(p_master001, p_patch002, p_patch003)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_patch002        LIKE type_t.chr20     #需求單號
   DEFINE p_patch003        LIKE type_t.num5      #項次

   DEFINE l_ddata_d         type_g_ddata_d        #設定資料清單
   DEFINE l_ddata002        LIKE type_t.num5
   DEFINE l_cnt             LIKE type_t.num5
   
   #取得目前最大項次
   SELECT MAX(ddata002) + 1 INTO l_ddata002 FROM adzi888_ddata
     WHERE ddata001 = p_master001

   IF cl_null(l_ddata002) OR l_ddata002 = 0 THEN
      LET l_ddata002 = 1
   END IF

   #取得[需求單號]+[項次]的設定資料匯出清單
   FOREACH adzp999_dzld_list_cs USING p_patch002, g_dzld012, g_dzld013, p_patch003
                                INTO l_ddata_d.ddata002, l_ddata_d.ddata003, l_ddata_d.ddata004, l_ddata_d.ddata005, l_ddata_d.ddata006,  
                                     l_ddata_d.ddata007, l_ddata_d.ddata008, l_ddata_d.ddata009, l_ddata_d.ddata010, l_ddata_d.ddata015

      IF SQLCA.sqlcode THEN
         LET g_error_message = "BREAK_ERROR-", p_patch002 CLIPPED, ".", p_patch003 USING "<<<<<", "-FOREACH adzp999_dzld_list_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         RETURN FALSE
      END IF

      #檢查[匯入動作], [維護作業], [條件式1], [條件式2]的設定資訊是否已經重覆產生
      IF cl_null(l_ddata_d.ddata007) THEN
         SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
           WHERE ddata001 = p_master001
             AND ddata004 = l_ddata_d.ddata004
             AND ddata005 = l_ddata_d.ddata005
             AND ddata006 = l_ddata_d.ddata006
      ELSE
         SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
           WHERE ddata001 = p_master001
             AND ddata004 = l_ddata_d.ddata004
             AND ddata005 = l_ddata_d.ddata005
             AND ddata006 = l_ddata_d.ddata006
             AND ddata007 = l_ddata_d.ddata007
      END IF

      #表示同樣key值的設定已經重覆產生
      IF l_cnt > 0 THEN
         CONTINUE FOREACH
      END IF

      INSERT INTO adzi888_ddata(ddata001, ddata002, ddata003, ddata004, ddata005, 
                                ddata006, ddata007, ddata008, ddata009, ddata010,
                                ddata015) 
        VALUES(p_master001, l_ddata002, l_ddata_d.ddata003, l_ddata_d.ddata004, l_ddata_d.ddata005, 
               l_ddata_d.ddata006, l_ddata_d.ddata007, l_ddata_d.ddata008, l_ddata_d.ddata009, l_ddata_d.ddata010,
               l_ddata_d.ddata015)

      IF SQLCA.sqlcode THEN
         LET g_error_message = "BREAK_ERROR-", p_patch002 CLIPPED, ".", p_patch003 USING "<<<<<", "(", l_ddata_d.ddata005 CLIPPED, ".", l_ddata_d.ddata006 CLIPPED, "):", cl_getmsg(SQLCA.sqlcode, g_lang)
         RETURN FALSE
      END IF

      LET l_ddata002 = l_ddata002 + 1
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 依[需求單號]+[項次]開始執行patch[檔案]匯出打包
PRIVATE FUNCTION adzp999_patch_dzlf_export(p_master001, p_patch002, p_patch003)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_patch002        LIKE type_t.chr20     #需求單號
   DEFINE p_patch003        LIKE type_t.num5      #項次

   DEFINE l_patch002        LIKE type_t.chr20     #需求單號
   DEFINE l_patch003        LIKE type_t.num5      #項次
   DEFINE l_dfile_d         type_g_dfile_d        #設定資料清單
   DEFINE l_dfile002        LIKE type_t.num5
   DEFINE l_cnt             LIKE type_t.num5
   
   #取得目前最大項次
   SELECT MAX(dfile002) + 1 INTO l_dfile002 FROM adzi888_dfile
     WHERE dfile001 = p_master001

   IF cl_null(l_dfile002) OR l_dfile002 = 0 THEN
      LET l_dfile002 = 1
   END IF

   #取得[需求單號]+[項次]的設定資料匯出清單
   FOREACH adzp999_dzlf_list_cs USING p_patch002, g_dzld012, g_dzld013, p_patch003
                                INTO l_dfile_d.dfile002, l_dfile_d.dfile003, l_dfile_d.dfile004, l_dfile_d.dfile005, l_dfile_d.dfile006,  
                                     l_dfile_d.dfile007

      IF SQLCA.sqlcode THEN
         LET g_error_message = "BREAK_ERROR-", p_patch002 CLIPPED, ".", p_patch003 USING "<<<<<", "-FOREACH adzp999_dzlf_list_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         RETURN FALSE
      END IF

      #檢查[路徑], [類型], [條件式1], [檔名]的檔案資料是否已經重覆產生
      IF NOT cl_null(l_dfile_d.dfile005) THEN
         SELECT COUNT(*) INTO l_cnt FROM adzi888_dfile
           WHERE dfile001 = p_master001
             AND dfile003 = l_dfile_d.dfile003
             AND dfile004 = l_dfile_d.dfile004
             AND dfile005 = l_dfile_d.dfile005
      ELSE
         CONTINUE FOREACH
      END IF

      #表示同樣key值的設定已經重覆產生
      IF l_cnt > 0 THEN
         CONTINUE FOREACH
      END IF

      INSERT INTO adzi888_dfile(dfile001, dfile002, dfile003, dfile004, dfile005, 
                                dfile006, dfile007) 
        VALUES(p_master001, l_dfile002, l_dfile_d.dfile003, l_dfile_d.dfile004, l_dfile_d.dfile005, 
               l_dfile_d.dfile006, l_dfile_d.dfile007)

      IF SQLCA.sqlcode THEN
         LET g_error_message = "BREAK_ERROR-", p_patch002 CLIPPED, ".", p_patch003 USING "<<<<<", "(", l_dfile_d.dfile003 CLIPPED, "/", l_dfile_d.dfile005 CLIPPED, "):", cl_getmsg(SQLCA.sqlcode, g_lang)
         RETURN FALSE
      END IF

      LET l_dfile002 = l_dfile002 + 1
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 依[需求單號]+[項次]開始執行patch[IT工具]匯出打包
PRIVATE FUNCTION adzp999_patch_dzlt_export(p_master001, p_patch002, p_patch003)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_patch002        LIKE type_t.chr20     #需求單號
   DEFINE p_patch003        LIKE type_t.num5      #項次

   DEFINE l_dtool_d         type_g_dtool_d        #IT工具資料清單
   DEFINE l_dtool002        LIKE type_t.num5
   DEFINE l_cnt             LIKE type_t.num5
   
   #取得目前最大項次
   SELECT MAX(dtool002) + 1 INTO l_dtool002 FROM adzi888_dtool
     WHERE dtool001 = p_master001

   IF cl_null(l_dtool002) OR l_dtool002 = 0 THEN
      LET l_dtool002 = 1
   END IF

   #取得[需求單號]+[項次]的設定資料匯出清單
   FOREACH adzp999_dzlt_list_cs USING p_patch002, g_dzld012, g_dzld013, p_patch003
                                INTO l_dtool_d.dtool002, l_dtool_d.dtool003, l_dtool_d.dtool004, l_dtool_d.dtool005, l_dtool_d.dtool006,  
                                     l_dtool_d.dtool007, l_dtool_d.dtool008, l_dtool_d.dtool009

      IF SQLCA.sqlcode THEN
         LET g_error_message = "BREAK_ERROR-", p_patch002 CLIPPED, ".", p_patch003 USING "<<<<<", "-FOREACH adzp999_dzlt_list_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         RETURN FALSE
      END IF

      #檢查[模組], [匯入類型], [檔名]的工具資訊是否已經重覆產生
      IF NOT cl_null(l_dtool_d.dtool006) THEN
         SELECT COUNT(*) INTO l_cnt FROM adzi888_dtool
           WHERE dtool001 = p_master001
             AND dtool003 = l_dtool_d.dtool003
             AND dtool004 = l_dtool_d.dtool004
             AND dtool006 = l_dtool_d.dtool006
      ELSE
         CONTINUE FOREACH
      END IF

      #表示同樣key值的設定已經重覆產生
      IF l_cnt > 0 THEN
         CONTINUE FOREACH
      END IF

      INSERT INTO adzi888_dtool(dtool001, dtool002, dtool003, dtool004, dtool005, 
                                dtool006, dtool007, dtool008, dtool009) 
        VALUES(p_master001, l_dtool002, l_dtool_d.dtool003, l_dtool_d.dtool004, l_dtool_d.dtool005, 
               l_dtool_d.dtool006, l_dtool_d.dtool007, l_dtool_d.dtool008, l_dtool_d.dtool009)

      IF SQLCA.sqlcode THEN
         LET g_error_message = "BREAK_ERROR-", p_patch002 CLIPPED, ".", p_patch003 USING "<<<<<", "(", l_dtool_d.dtool003 CLIPPED, "/", l_dtool_d.dtool004 CLIPPED, "/", l_dtool_d.dtool006 CLIPPED, "):", cl_getmsg(SQLCA.sqlcode, g_lang)
         RETURN FALSE
      END IF

      LET l_dtool002 = l_dtool002 + 1
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ patch打包資料需將SA的規格描述資料update
PRIVATE FUNCTION adzp999_upd_spec_data()
   DEFINE l_spec_desc_tab   DYNAMIC ARRAY OF RECORD    #規格描述資料所屬資料表和欄位
             dzea001           LIKE dzea_t.dzea001,
             dzea002           LIKE dzea_t.dzea002
                            END RECORD     
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_sql             STRING
   DEFINE l_errcode         STRING
   
   LET l_spec_desc_tab[1].dzea001 = "dzab_t"
   LET l_spec_desc_tab[2].dzea001 = "dzac_t"
   LET l_spec_desc_tab[3].dzea001 = "dzad_t"
   LET l_spec_desc_tab[4].dzea001 = "dzaj_t"
   
   LET l_spec_desc_tab[1].dzea002 = "dzab099"
   LET l_spec_desc_tab[2].dzea002 = "dzac099"
   LET l_spec_desc_tab[3].dzea002 = "dzad099"
   LET l_spec_desc_tab[4].dzea002 = "dzaj099"

   BEGIN WORK
   
   FOR l_i = 1 TO l_spec_desc_tab.getLength()
      LET l_sql = "UPDATE ", g_patch_schema CLIPPED, ".", l_spec_desc_tab[l_i].dzea001 CLIPPED,
                  "  SET ", l_spec_desc_tab[l_i].dzea002, " = ''"

      #確保執行的是dspatch schema
      IF l_sql.getIndexOf(g_patch_schema, 1) > 0 THEN
         DISPLAY "upd spec:", l_sql.trim()

         PREPARE adzp999_upd_spec_data_pre FROM l_sql
         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = 'PREPARE adzp999_upd_spec_data_pre:', l_spec_desc_tab[l_i].dzea001 CLIPPED
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "ERROR-PREPARE adzp999_upd_spec_data_pre.", l_spec_desc_tab[l_i].dzea001 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            ROLLBACK WORK
            RETURN FALSE
         END IF
      
         EXECUTE adzp999_upd_spec_data_pre
         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = 'exc adzp999_upd_spec_data_pre:', l_sql.trim()
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "ERROR-exc adzp999_upd_spec_data_pre.", l_sql.trim(), ":", cl_getmsg(l_errcode, g_lang)
            ROLLBACK WORK
            RETURN FALSE
         END IF
      END IF
   END FOR

   COMMIT WORK
   RETURN TRUE
END FUNCTION

#+ patch打包資料只能包出zh_TW和zh_CN的資料,所以整批刪除多語言資料表的其他語系資料
PRIVATE FUNCTION adzp999_del_multi_lang_data()
   DEFINE l_table_list_json util.JSONObject
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_table           LIKE dzea_t.dzea001
   DEFINE l_dspatch_table   LIKE dzea_t.dzea001
   DEFINE l_str             STRING
   
   #取得此次patch summary file
   CALL sadzi888_01_get_summary_file()
      RETURNING l_success, l_table_list_json

   IF NOT l_success THEN
      RETURN FALSE
   END IF

   BEGIN WORK
   
   #依序取得table名稱
   FOR l_i = 1 TO l_table_list_json.getLength()
      #取得資料表代碼與dspatch檔名
      LET l_table = l_table_list_json.name(l_i)
      LET l_dspatch_table = l_table_list_json.get(l_table)

      IF cl_null(l_table) OR cl_null(l_dspatch_table) THEN
         LET l_str = "ERROR-", cl_getmsg_parm("adz-00385", g_lang, l_table CLIPPED || "." || l_dspatch_table CLIPPED)
         ROLLBACK WORK
         RETURN FALSE
      END IF

      CASE 
         #標準多語言表:[table id]是四碼 + [l]一碼是多語言表特徵 + [_t]
         WHEN l_table MATCHES "[a-z][a-z][a-z][a-z]l_t" 

      END CASE
   END FOR

   COMMIT WORK
   
   RETURN TRUE
END FUNCTION

#+ 先import dspatch dmp檔
PRIVATE FUNCTION adzp999_import_dspatch(p_alm_tar_path, p_patch_pwd)
   DEFINE p_alm_tar_path    STRING                #ALM執行匯出/入時,tar放置完整路徑
   DEFINE p_patch_pwd       STRING

   DEFINE l_pack_dir        STRING                #打包檔置放路徑
   DEFINE l_folder          STRING                #匯出檔目錄
   DEFINE l_tar_name        STRING                #匯出包名稱
   DEFINE l_idx             LIKE type_t.num5
   DEFINE l_cmd             STRING
   DEFINE l_str             STRING
   DEFINE l_patch_user      STRING                #patch chema
   DEFINE l_patch_pwd       STRING
   
   #檢查tar是否存在
   IF NOT os.Path.EXISTS(p_alm_tar_path) THEN
      DISPLAY "BREAK_ERROR:", cl_getmsg_parm("adz-00328", g_lang, p_alm_tar_path.trim())
      RETURN FALSE
   END IF
   
   #切換到$TEMPDIR工作目錄下
   LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
   
   IF NOT sadzi888_01_change_pack_dir(l_pack_dir) THEN
      RETURN FALSE
   END IF

   #取得tar檔案名稱
   LET l_tar_name = os.Path.basename(p_alm_tar_path.trim())

   #取得匯出檔的目錄名稱
   LET l_idx = l_tar_name.getIndexOf(".tgz", 1)
   IF l_idx > 1 THEN
      LET l_folder = l_tar_name.subString(1, l_idx - 1)
   END IF

   IF cl_null(l_tar_name) OR cl_null(l_folder) THEN
      DISPLAY "BREAK_ERROR:", cl_getmsg_parm("adz-00331", g_lang, l_tar_name.trim())
      RETURN FALSE
   END IF

   #檢查目錄是否存在
   IF os.Path.EXISTS(l_folder) THEN
      #刪除目錄
      LET l_cmd = "rm -rf ", l_folder
      RUN l_cmd
   END IF

   #解包成tar檔範例:tar xvf $FOLDER.tgz
   LET l_cmd = "tar zxvf ", p_alm_tar_path.trim()
   RUN l_cmd

   #切換到新目錄下,準備讀取所有匯出檔
   IF (NOT os.Path.EXISTS(l_folder)) OR (NOT os.Path.chdir(l_folder)) THEN
      DISPLAY "BREAK_ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_folder.trim())
      RETURN FALSE
   END IF
   
   LET l_str = "import dmp start:", cl_get_current(), ASCII 10
   DISPLAY l_str

   LET l_patch_user = g_patch_schema
   LET l_patch_pwd = p_patch_pwd
   
   #patch dmp檔匯入
   IF NOT sadzi888_01_import_dmp(l_patch_user, l_patch_pwd) THEN
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   LET l_str = "import dmp end:", cl_get_current(), ASCII 10
   DISPLAY l_str
   
   RETURN TRUE
END FUNCTION
