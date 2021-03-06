#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: sadzi888_01
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzi888_01.4gl 
# Description    : 註冊資訊[清單]匯出
# Memo           :
#                : 2015/06/15 by madey :設計資料匯出入增加控卡規則 
#                : 2015/09/23 by madey :設計資料匯出入
#                                       1.匯入前，自動備份舊資料
#                                       2.將sadzi888_06_befor_imp()搬到sadzi888_02.4gl呼叫
#                : 2016/01/20 by ka0132:新增azzi880額外條件(非c才處理)
#                : 2016/01/27 by ka0132:調整folder取得方式
#                : 2016/02/15 by ka0132:調整檔案/目錄複製(避免重名問題)
#                : 2016/02/22 by ka0132:排除adzp888行為
#                  20160223 160223-00028 by madey :patch優化專案
#                : 2016/03/11 by ka0132:增加menu過單條件(僅限99)
#                : 2016/03/31 by ka0132:調整azzi300過單條件(by janet)
#                : 2016/04/22 by ka0132:調整檔案/目錄複製(避免重名問題) ver2
#                                       azzi933項目更名為append_file
#                : 2016/05/30 by madey: write debug log
#                : 2016/06/02 by ka0132:增加表格過單條件(dzlm008='O')
#                : 2016/07/07 by ka0132:增加azzi051過單項/動作, azzp660過單項
#                : 2016/08/03 by ka0132:排除重複booking的檔案清單
#                : 2016/08/23 by ka0132:夾帶patch必要資訊
#                : 2016/08/29 by ka0132:azzi911過單項
#                : 2016/08/30 by ka0132:匯出入環境檢查
#                : 2016/09/06 by ka0132:過單回復www/doc, 打包依舊排除
#                : 2016/09/12 by ka0132:42s過單機制調整
#                : 2016/09/20 by ka0132:dzbd瘦身
#                : 2016/11/10 by ka0132:呼叫azzp185參數調整

IMPORT os
IMPORT util
IMPORT security

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzi888_global.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzi888_06_type.inc"

CONSTANT g_summary_prefix = "summary-"

DEFINE g_work_dir           STRING              #目前程式執行路徑
DEFINE g_alm_tar_path       STRING              #ALM執行匯出/入時,tar放置完整路徑
DEFINE g_write_log          LIKE type_t.chr1    #開啟log是否成功
DEFINE g_log_file           STRING              #log file name
DEFINE g_channel            base.Channel

DEFINE g_gzzy001            DYNAMIC ARRAY OF LIKE gzzy_t.gzzy001     #界面語言編號
DEFINE g_import_data_flag   LIKE type_t.chr1    #是否import data
DEFINE g_gen_prog_pre       STRING              #產生程序在生成4gl前必須完成的維護作業
DEFINE g_tool_tar_path      STRING              #工具類tar檔路徑
DEFINE g_lang_list          DYNAMIC ARRAY OF LIKE type_t.chr20 #多語言清單 2016/04/22
DEFINE g_lang_idx           LIKE type_t.num5                   #2016/04/22
#2016/09/12
DEFINE g_write              base.Channel
#2016/09/12

CONSTANT g_patch_unl_path = "/u6/scm" #2016/08/23

#+ 建立temp table
PUBLIC FUNCTION sadzi888_01_create_temp_table()
   DEFINE l_errcode         STRING
   
   #Create temp table 程式註冊資料匯出主檔
   CREATE TEMP TABLE adzi888_master(
      master001        VARCHAR(40),       #GUID
      master002        VARCHAR(50),         #匯出主題
      master003        VARCHAR(10),         #匯出人員
      master004        VARCHAR(10),         #自動產生類型
      master005        VARCHAR(1),          #程式類型
      master006        VARCHAR(50),         #作業代號
      master007        DATE,           #資料起始時間
      master008        DATE,           #資料結束時間
      master009        DATE,           #匯出時間
      master010        DATE,           #匯入時間
      master011        VARCHAR(1),          #自動產生註冊資料清單否
      master012        VARCHAR(20),         #註冊資訊資料清單建立區域
      master013        VARCHAR(20),         #需求單號
      master014        SMALLINT     #作業項次
   )

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "create tmp adzi888_master:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-create tmp adzi888_master:", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF

   #Create temp table 設定和設計資料匯出清單
   CREATE TEMP TABLE adzi888_ddata(
      ddata001        VARCHAR(40),        #GUID
      ddata002        SMALLINT,           #序號
      ddata003        VARCHAR(20),        #作業代號
      ddata004        VARCHAR(1),        #匯入動作
      ddata005        VARCHAR(20),        #維護作業
      ddata006        VARCHAR(80),        #條件式1
      ddata007        VARCHAR(80),        #條件式2
      ddata008        VARCHAR(1),        #匯出狀態
      ddata009        VARCHAR(1),        #匯入狀態
      ddata010        VARCHAR(1),        #清單資料產生方式
      ddata015        VARCHAR(1)     #過單項目(m:單頭主項; d:單身子項)
   )

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "create tmp adzi888_ddata:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-create tmp adzi888_ddata:", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF

   #Create temp table 檔案匯出清單
   CREATE TEMP TABLE adzi888_dfile(
      dfile001        VARCHAR(40),        #GUID
      dfile002        SMALLINT,           #序號
      dfile003        VARCHAR(80),        #路徑
      dfile004        VARCHAR(1),        #類型
      dfile005        VARCHAR(40),        #檔名
      dfile006        VARCHAR(1),        #匯出狀態
      dfile007        VARCHAR(1)     #匯入狀態
   )

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "create tmp adzi888_dfile:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-create tmp adzi888_dfile:", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF

   #Create temp table IT工具類匯出清單
   CREATE TEMP TABLE adzi888_dtool(
      dtool001        VARCHAR(40),        #GUID
      dtool002        SMALLINT,           #序號
      dtool003        VARCHAR(4),        #模組
      dtool004        VARCHAR(10),        #匯入類型
      dtool005        VARCHAR(1),        #主程式否
      dtool006        VARCHAR(80),        #檔名
      dtool007        VARCHAR(1),        #no use
      dtool008        VARCHAR(1),        #匯出狀態
      dtool009        VARCHAR(1)     #匯入狀態
   )

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "create tmp adzi888_dtool:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-create tmp adzi888_dtool:", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF

   #建立dzye_t的temp table
   SELECT * FROM dzye_t WHERE 1 = 2 INTO TEMP tmp_dzye_t
   
   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "create tmp dzye_t:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-create tmp dzye_t:", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ drop temp table
PUBLIC FUNCTION sadzi888_01_drop_temp_table()
   DROP TABLE adzi888_master
   DROP TABLE adzi888_ddata
   DROP TABLE adzi888_dfile
   DROP TABLE adzi888_dtool
   DROP TABLE tmp_dzye_t
END FUNCTION



#+ alm端執行註冊資訊[清單]+[資料]匯出作業
PUBLIC FUNCTION sadzi888_01_alm_export(p_export_type, p_master013, p_master014)
   DEFINE p_export_type     LIKE type_t.chr1      #export方式(1:過單方式的打包; 3:patch方式的打包)
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次

   DEFINE l_master_m        type_g_master_m       #程式註冊資料匯出主檔
   DEFINE l_pack_dir        STRING                #打包檔置放路徑
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_cnt_dzld        LIKE type_t.num5
   DEFINE l_cnt_dzlf        LIKE type_t.num5
   DEFINE l_cnt_dzlt        LIKE type_t.num5
   DEFINE l_cnt_dzlm        LIKE type_t.num5
   DEFINE l_folder          STRING                #匯出檔目錄
   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_str             STRING
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   #CALL sadzi888_01_create_temp_table()

   IF cl_null(g_show_msg) THEN
      LET g_show_msg = "N"     #背景模式操作
   END IF
   
   CALL sadzi888_01_init()

   #取得匯出主題
   LET l_master_m.master001 = security.RandomGenerator.CreateUUIDString()
   LET l_master_m.master013 = p_master013
   LET l_master_m.master014 = p_master014
   LET l_master_m.master002 = l_master_m.master013, "#", l_master_m.master014 USING "<<<<<"

   IF g_run_mode = "a" THEN 
      IF gb_bak_mode THEN #20150923
         LET l_master_m.master003 = "auto_bak" #自動備份：自動命名為auto_bak
      ELSE
         LET l_master_m.master003 = g_user 
      END IF
      LET g_show_msg = "N"
   END IF 

   INSERT INTO adzi888_master(master001, master002, master003, master004, master005,
                              master006, master007, master008, master009, master010, 
                              master011, master012, master013, master014)
     VALUES (l_master_m.master001, l_master_m.master002, l_master_m.master003, l_master_m.master004, l_master_m.master005, 
             l_master_m.master006, l_master_m.master007, l_master_m.master008, l_master_m.master009, l_master_m.master010, 
             l_master_m.master011, l_master_m.master012, l_master_m.master013, l_master_m.master014) 
 
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-INSERT adzi888_master:", cl_getmsg(SQLCA.sqlcode, g_lang)
      RETURN FALSE, g_error_message 
   END IF

   #取得[需求單號]+[項次]的設計資料匯出清單
   INSERT INTO adzi888_ddata
     SELECT l_master_m.master001, dzld002, dzld003, dzld004, dzld005,
            dzld006, dzld007, dzld008, dzld009, dzld010,
            dzld015
       FROM dzld_t
       WHERE dzld011 = p_master013
         AND dzld012 = g_dzld012
         AND dzld013 = g_dzld013
         AND dzld014 = p_master014

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-INSERT adzi888_ddata:", cl_getmsg(SQLCA.sqlcode, g_lang)
      RETURN FALSE, g_error_message
   END IF

   #todo:準備呼叫新增[設計資料]
   CALL sadzi888_02_insert_temp_table_for_design_data(g_run_mode, p_master013, p_master014)
      RETURNING l_success, g_error_message

   IF NOT l_success THEN
      RETURN FALSE, g_error_message
   END IF

   #取得[需求單號]+[項次]的檔案匯出清單
   INSERT INTO adzi888_dfile
     SELECT l_master_m.master001, dzlf002, dzlf003, dzlf004, dzlf005,
            dzlf006, dzlf007
       FROM dzlf_t
       WHERE dzlf008 = p_master013
         AND dzlf009 = g_dzld012
         AND dzlf010 = g_dzld013
         AND dzlf011 = p_master014

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-INSERT adzi888_dfile:", cl_getmsg(SQLCA.sqlcode, g_lang)
      RETURN FALSE, g_error_message
   END IF

   #取得[需求單號]+[項次]的IT工具類匯出清單
   INSERT INTO adzi888_dtool
     SELECT l_master_m.master001, dzlt002, dzlt003, dzlt004, dzlt005,
            dzlt006, dzlt007, dzlt008, dzlt009
       FROM dzlt_t
       WHERE dzlt011 = p_master013
         AND dzlt012 = g_dzld012
         AND dzlt013 = g_dzld013
         AND dzlt014 = p_master014

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-INSERT adzi888_dtool:", cl_getmsg(SQLCA.sqlcode, g_lang)
      RETURN FALSE, g_error_message
   END IF

   #檢查是否有[設定資料],[設計資料],[檔案],[工具類]要過單
   SELECT COUNT(*) INTO l_cnt_dzld FROM adzi888_ddata
   DISPLAY "adzi888_ddata count(*):", l_cnt_dzld 

   SELECT COUNT(*) INTO l_cnt_dzlf FROM adzi888_dfile
   DISPLAY "adzi888_dfile count(*):", l_cnt_dzlf 

   SELECT COUNT(*) INTO l_cnt_dzlt FROM adzi888_dtool
   DISPLAY "adzi888_dtool count(*):", l_cnt_dzlt 

   #取得所有此次patch[資料表(table)]清單
   SELECT COUNT(*) INTO l_cnt_dzlm FROM dzlm_t
     WHERE dzlm001 IN ('T','MT','MV','MG') 
       AND dzlm012 = p_master013
       AND dzlm013 = g_dzld012
       AND dzlm014 = g_dzld013
       AND dzlm015 = p_master014
   DISPLAY "dzlm_t(T) count(*):", l_cnt_dzlm 
   
   #沒有任何[設定]資料或[設計]資訊要過單
   IF l_cnt_dzld = 0 AND l_cnt_dzlf = 0 AND l_cnt_dzlm = 0 AND l_cnt_dzlt = 0 THEN
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00355", g_lang, p_master013 || "|" || p_master014)
      RETURN FALSE, g_error_message
   END IF

   #讀取主要key值都失敗
   IF cl_null(l_master_m.master001) OR cl_null(l_master_m.master013) OR cl_null(l_master_m.master014) THEN
      DISPLAY "master001:", l_master_m.master001 CLIPPED
      DISPLAY "master013:", l_master_m.master013 CLIPPED
      DISPLAY "master014:", l_master_m.master014 CLIPPED
      LET g_error_message = "ERROR:", cl_getmsg("adz-00335", g_lang)
      RETURN FALSE, g_error_message
   END IF

   #開始記錄匯入log
   CALL sadzi888_01_log_file_start(g_run_mode, l_master_m.master002)
   
   #切換到$TEMPDIR工作目錄下
   LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
   
   IF NOT sadzi888_01_change_pack_dir(l_pack_dir) THEN
      RETURN FALSE, g_error_message
   END IF

   LET l_folder = sadzi888_01_get_folder_name(l_master_m.master002, l_master_m.master003)

   #註冊資訊[清單]+[資料]匯出作業
   IF NOT sadzi888_01_export(l_master_m.master001, l_master_m.master002, l_master_m.master013, l_master_m.master014, l_pack_dir, l_folder) THEN
      DISPLAY "sadzi888_01_export is error."
      RETURN FALSE, g_error_message
   END IF

   #切換回正確程式執行路徑
   IF NOT sadzi888_01_change_work_dir() THEN
      RETURN FALSE, g_error_message
   END IF

   #CALL sadzi888_01_drop_temp_table()

   LET g_error_message = ""

   IF cl_null(g_alm_tar_path) THEN
      DISPLAY "ERROR:g_alm_tar_path is error."
      RETURN FALSE, g_error_message
   END IF
   
   #結束記錄log
   CALL sadzi888_01_log_file_write("pack_path:" || g_alm_tar_path.trim())
   CALL sadzi888_01_log_file_end()

   RETURN TRUE, g_alm_tar_path
END FUNCTION

#+ alm端執行註冊資訊[清單]+[資料]匯入作業
PUBLIC FUNCTION sadzi888_01_alm_import(p_import_type, p_alm_tar_path, p_patch_pwd)
   DEFINE p_import_type     LIKE type_t.chr1      #import方式(2:過單方式的解包; 4:patch方式的解包)
   DEFINE p_alm_tar_path    STRING                #ALM執行匯出/入時,tar放置完整路徑
   DEFINE p_patch_pwd       STRING
   
   DEFINE l_master_m        type_g_master_m       #程式註冊資料匯出主檔
   DEFINE l_pack_dir        STRING                #打包檔置放路徑
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_folder          STRING                #匯出檔目錄
   DEFINE l_tar_name        STRING                #匯出包名稱
   DEFINE l_idx             LIKE type_t.num10
   DEFINE l_cmd             STRING
   DEFINE l_file            STRING
   DEFINE l_sql             STRING
   DEFINE l_temp            STRING
   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_str             STRING
   DEFINE lb_result         BOOLEAN               #20150615 madey
   DEFINE lb_chk            BOOLEAN               #2016/01/27
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   #CALL sadzi888_01_create_temp_table()

   IF cl_null(g_show_msg) THEN
      LET g_show_msg = "N"     #背景模式操作
   END IF

   IF cl_null(g_gen42s_flag) THEN
      LET g_gen42s_flag = TRUE
   END IF
   
   LET g_patch_pwd =  p_patch_pwd

   #patch模式下,一律不做產生42s動作
   IF g_patch_mode THEN
      LET g_gen42s_flag = FALSE
   END IF
   
   CALL sadzi888_01_init()
   
   #檢查tar是否存在
   IF NOT os.Path.EXISTS(p_alm_tar_path) THEN
      LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00328", g_lang, p_alm_tar_path.trim())
      RETURN FALSE, g_error_message
   END IF
   
   #切換到$TEMPDIR工作目錄下
   LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
   
   IF NOT sadzi888_01_change_pack_dir(l_pack_dir) THEN
      RETURN FALSE, g_error_message
   END IF

   #取得tar檔案名稱
   LET l_tar_name = os.Path.basename(p_alm_tar_path.trim())

   #取得匯出檔的目錄名稱
   LET l_idx = l_tar_name.getIndexOf(".tgz", 1)
   IF l_idx > 1 THEN
      LET l_folder = l_tar_name.subString(1, l_idx - 1)
   END IF

   IF cl_null(l_tar_name) OR cl_null(l_folder) THEN
      LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00331", g_lang, l_tar_name.trim())
      RETURN FALSE, g_error_message
   END IF

   #檢查目錄是否存在
   IF os.Path.EXISTS(l_folder) THEN
      #刪除目錄
      LET l_cmd = "rm -rf ", l_folder
      RUN l_cmd
   END IF

   #解包成tar檔範例:tar xvf $FOLDER.tgz
   LET l_cmd = "tar zxvf ", p_alm_tar_path.trim()
   #RUN l_cmd
   #2016/01/27
   LET lb_chk = FALSE
   CALL sadzi888_01_tar_extract_and_get_folder(l_cmd) 
     RETURNING lb_chk,l_folder
   IF NOT lb_chk THEN
      RETURN FALSE, g_error_message
   END IF 
   #2016/01/27

   #匯入[程式註冊資料匯出主檔]
   LET l_file = os.Path.join(l_folder.trim(), "Temp-adzi888_master.unl")
   LET l_sql = "INSERT INTO adzi888_master "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      LET g_error_message = "BREAK_ERROR-LOAD FROM ", l_file.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE, g_error_message
   END IF
   
   #匯入[設計資料匯出清單]
   LET l_file =  os.Path.join(l_folder.trim(), "Temp-adzi888_ddata.unl")
   LET l_sql = "INSERT INTO adzi888_ddata "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      LET g_error_message = "BREAK_ERROR-LOAD FROM ", l_file.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE, g_error_message
   END IF
   
   #匯入[檔案匯出清單]
   LET l_file =  os.Path.join(l_folder.trim(), "Temp-adzi888_dfile.unl")
   LET l_sql = "INSERT INTO adzi888_dfile "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      LET g_error_message = "BREAK_ERROR-LOAD FROM ", l_file.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE, g_error_message
   END IF
   
   #匯入[IT工具類匯出清單]
   LET l_file =  os.Path.join(l_folder.trim(), "Temp-adzi888_dtool.unl")
   LET l_sql = "INSERT INTO adzi888_dtool "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      LET g_error_message = "BREAK_ERROR-LOAD FROM ", l_file.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE, g_error_message
   END IF
   
   #取得[程式註冊資料匯出主檔]
   SELECT COUNT(*) INTO l_cnt FROM adzi888_master
   IF l_cnt <> 1 THEN
      LET g_error_message = "BREAK_ERROR-SELECT adzi888_master cnt:", cl_getmsg("adz-00335", g_lang)
      RETURN FALSE, g_error_message
   END IF

   SELECT master001, master002, master003, master004, master005, 
          master006, master007, master008, master009, master010, 
          master011, master012, master013, master014
     INTO l_master_m.master001, l_master_m.master002, l_master_m.master003, l_master_m.master004, l_master_m.master005, 
          l_master_m.master006, l_master_m.master007, l_master_m.master008, l_master_m.master009, l_master_m.master010, 
          l_master_m.master011, l_master_m.master012, l_master_m.master013, l_master_m.master014
     FROM adzi888_master

   IF cl_null(l_master_m.master001) THEN
      LET g_error_message = "BREAK_ERROR-SELECT adzi888_ddata master001:", cl_getmsg("adz-00335", g_lang)
      RETURN FALSE, g_error_message
   END IF

   #開始記錄匯入log
   CALL sadzi888_01_log_file_start(g_run_mode, l_master_m.master002)

   #ARG_VAL(4) = "after_imp"或"after_imp_redo"時:跳過import data階段,直接進入產生程式
   LET l_str = ARG_VAL(4) 

   #如果無任何傳遞參數,就視為過單
   LET g_import_data_flag = TRUE
   
   IF cl_null(l_str) THEN
      LET l_str = "sadzi888_01_import"
   END IF

   #取得dzye_t資訊
   IF NOT sadzi888_01_imp_get_dzye(l_master_m.master002, l_folder) THEN
      DISPLAY "BREAK_ERROR:sadzi888_01_imp_get_dzye is error."
      RETURN FALSE, g_error_message
   END IF
   
   #20150923 mark -Begin-:此段移到sadzi888_02
   ##設計資料匯出入卡控:20150615 madey -Begin-
   #IF g_run_mode = "b" THEN
   #   LET l_temp = NULL
   #   LET lb_result = NULL
   #   CALL sadzi888_06_before_imp() RETURNING lb_result, l_temp
   #   IF NOT lb_result THEN
   #      LET g_error_message = g_error_message, l_temp
   #      DISPLAY "BREAK_ERROR:sadzi888_06_before_imp is error."
   #      RETURN FALSE, g_error_message
   #   END IF
   #END IF
   ##20150615 madey -End-
   #20150923 mark -End-:此段移到sadzi888_02

   IF NOT (l_str.trim() = "after_imp" OR l_str.trim() = "after_imp_redo") THEN
      #註冊資訊[清單]+[資料]匯入作業
      IF NOT sadzi888_01_import(l_master_m.master001, l_master_m.master013, l_master_m.master014, l_pack_dir, l_folder) THEN
         DISPLAY "sadzi888_01_import is error."
         RETURN FALSE, g_error_message
      END IF
   
     #Begin: 160223-00028 註解段落
     ##[qry link]
     #SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     #  WHERE ddata005 = 'adzi210'
     #  
     #IF l_cnt > 0 THEN
     #   DISPLAY "sadzi888_01.s_azzi070_gen_qry() is start."
     #   LET l_str = "s_azzi070_gen_qry start:", cl_get_current(), ASCII 10
     #   CALL sadzi888_01_log_file_write(l_str)
     #
     #   CALL s_azzi070_gen_qry()
     # 
     #   LET l_str = "s_azzi070_gen_qry end:", cl_get_current(), ASCII 10
     #   CALL sadzi888_01_log_file_write(l_str)
     #END IF
     #End: 160223-00028 註解段落
   END IF

   DISPLAY "sadzi888_01.sadzi888_06_after_imp() is start."
   LET l_str = "sadzi888_06_after_imp start:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)
   
   CALL sadzi888_06_after_imp(g_run_mode) 
      RETURNING l_success, g_error_message
   
   LET l_str = "sadzi888_06_after_imp end:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)
   DISPLAY "sadzi888_01.sadzi888_06_after_imp() is end."

   #執行組合程式失敗時,將失敗原因寫入log檔中
   IF NOT l_success THEN
      DISPLAY "after_imp error:", g_error_message
      #將summary log 和 display 統一收集並寫入log,提供程式單獨匯出/入使用
      #CALL sadzi888_01_log_file_write(g_error_message)
   ELSE
      DISPLAY "after_imp success:", g_error_message
   END IF
   
   CALL sadzi888_01_log_file_write(g_error_message) 
   
   #2016/09/12
   #開啟azzp191寫檔
   LET g_write = base.Channel.create()
   CALL g_write.setDelimiter("")
   LET l_file = l_master_m.master001,".sh"
   LET l_file = os.Path.join(FGL_GETENV("TEMPDIR"), l_file) 
   DISPLAY "INFO:產出sh檔(",l_file,")!"
   CALL g_write.openFile( l_file, "w" )
   #2016/09/12
   
   #整批處理程式相關檔案產生
   DISPLAY "sadzi888_01.generator_program(FALSE) is start."
   LET l_str = "generator_program start:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)
      
   IF NOT sadzi888_01_generator_program_batch(l_master_m.master001, FALSE) THEN
      DISPLAY "sadzi888_01_generator_program_batch is error."
   END IF
   
   LET l_str = "generator_program end:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)
   DISPLAY "sadzi888_01.generator_program(FALSE) is end."

   #CALL sadzi888_01_drop_temp_table()
   #DROP TABLE tmp_dzye_t

   #解包成功後,從Server端刪除相關檔案
   IF NOT sadzi888_01_change_work_dir() THEN
      RETURN FALSE, g_error_message
   END IF
 
   #刪除目錄
   LET l_temp = os.Path.join(l_pack_dir.trim(), l_folder.trim())
   IF os.Path.EXISTS(l_temp) THEN
      LET l_cmd = "rm -rf ", l_temp
      RUN l_cmd
   END IF

   ####刪除tar檔
   ###LET l_temp = os.Path.join(l_pack_dir.trim(), l_tar_name.trim())
   ###IF os.Path.EXISTS(l_temp) THEN
   ###   LET l_cmd = "rm ", l_temp
   ###   RUN l_cmd
   ###END IF

   #結束記錄log
   CALL sadzi888_01_log_file_end()

   #失敗時,一樣切換回正確程式執行路徑
   IF NOT l_success THEN
      #為避免g_error_message受到change dir的影響,因此先記錄起來真正錯誤訊息內容
      LET l_str = g_error_message
      IF NOT sadzi888_01_change_work_dir() THEN
         LET g_error_message = l_str
      END IF
      
      RETURN FALSE, g_error_message
   END IF

   #2016/09/12
   #先關閉寫入
   CALL g_write.close()
   #執行azzp191
   LET l_cmd = "sh ",l_file," >/dev/null 2>&1"
   RUN l_cmd WITHOUT WAITING
   IF STATUS THEN
      LET l_str = "Warning-", l_cmd.trim(), ":", cl_getmsg(STATUS, g_lang)
      CALL sadzi888_01_log_file_write(l_str)
   END IF
   #2016/09/12
   
   #切換回正確程式執行路徑
   IF NOT sadzi888_01_change_work_dir() THEN
      RETURN FALSE, g_error_message
   END IF
 
   LET g_error_message = ""
   
   RETURN TRUE, ""
END FUNCTION






#+ 註冊資訊[清單]+[資料]匯出作業
PUBLIC FUNCTION sadzi888_01_export(p_master001, p_master002, p_master013, p_master014, p_pack_dir, p_folder)
   DEFINE p_master001       LIKE type_t.chr50
   DEFINE p_master002       LIKE type_t.chr50     #匯出主題
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   DEFINE p_pack_dir        STRING                #打包檔置放路徑
   DEFINE p_folder          STRING                #匯出檔目錄
   
   DEFINE l_cmd             STRING
   DEFINE l_tar_name        STRING                #匯出包名稱
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_str             STRING
   DEFINE l_master009       LIKE type_t.dat       #匯出時間

   IF cl_null(p_folder) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00349"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg("adz-00349", g_lang)
      RETURN FALSE
   END IF
   
   LET l_tar_name = p_folder, ".tgz"   

   IF NOT sadzi888_01_make_pack_dir(p_folder, l_tar_name) THEN
      RETURN FALSE
   END IF

   #檢查IT工具類匯出清單是否有資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM adzi888_dtool

   IF l_cnt > 0 THEN
      IF NOT sadzi888_01_export_tool(p_master001, p_master013, p_master014, p_pack_dir, p_folder) THEN
         RETURN FALSE
      END IF
   END IF

   #檢查設計資料匯出清單是否有資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata

   IF l_cnt > 0 THEN
      #取得程式相關設計資料資訊
      IF NOT adzp999_01_exp_get_dzye_pre(p_master002) THEN
         RETURN FALSE
      END IF 
   
      #是否為dmp模式過單
      IF (NOT cl_null(g_dmp_mode)) AND (g_dmp_mode) THEN
         IF NOT sadzi888_01_export_data_dmp(p_master001, p_master013, p_master014) THEN
            RETURN FALSE
         END IF
      ELSE
         DISPLAY "sadzi888_01_export_data can not be call."
         RETURN FALSE
         #IF NOT sadzi888_01_export_data(p_master001, p_master013, p_master014) THEN
         #   RETURN FALSE
         #END IF
      END IF
   END IF
   
   #特別處理
   #CALL sadzi888_01_append_file(p_master001,p_master013)

   #Begin: 160223-00028
   #source處理
   IF NOT sadzi888_01_export_source(p_pack_dir, p_folder) THEN
      RETURN FALSE
   END IF
   #End: 160223-00028

   #檢查檔案匯出清單是否有資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM adzi888_dfile
   IF l_cnt > 0 THEN
      IF NOT sadzi888_01_export_file(p_master001, p_master013, p_master014, p_pack_dir, p_folder) THEN
         RETURN FALSE
      END IF
   END IF

   #取得[資料表(table)]清單
   LET l_cnt = 0
   IF g_alm_jb = g_dgenv_c THEN
      DISPLAY ""
   ###   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
   ###     WHERE ddata005 = 'adzi140'
   ELSE
      SELECT COUNT(*) INTO l_cnt FROM dzlm_t
        WHERE dzlm001 IN ('T','MT','MV','MG')
          AND dzlm012 = p_master013
          AND dzlm013 = g_dzld012
          AND dzlm014 = g_dzld013
          AND dzlm015 = p_master014
          AND dzlm008 = 'O' #2016/06/02
   END IF
   
   IF l_cnt > 0 THEN
      IF NOT sadzi888_01_dzea_export(p_master013, p_master014) THEN
         LET g_error_message = "ERROR-export dzea:", p_master013, ".", p_master014
         RETURN FALSE
      END IF
   END IF
   
   #更新匯出時間為目前時間
   LET l_master009 = cl_get_current()
   
   UPDATE adzi888_master SET master009 = l_master009
     WHERE master001 = p_master001
   
   #匯出此次打包清單資訊
   IF NOT sadzi888_01_export_pack_list(p_master001) THEN
      RETURN FALSE
   END IF

   #返回上一層目錄
   LET l_str = os.Path.pwd()
   LET l_str = os.Path.dirname(l_str)
   IF NOT os.Path.chdir(l_str) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_str.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_str.trim())
      RETURN FALSE
   END IF

   #打包成tar檔範例:tar cvf $FOLDER.tgz $FOLDER
   LET l_cmd = "tar zcvf ", l_tar_name CLIPPED, " ", p_folder CLIPPED
   RUN l_cmd

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "tar zcvf ", l_tar_name CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-tar zcvf ", l_tar_name CLIPPED, ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF

   #是否為背景執行
   IF g_show_msg = "Y" THEN
      CALL cl_ask_confirm3("adz-00342", l_tar_name.trim())
   ELSE
      DISPLAY "Info:", cl_getmsg("adz-00342", g_lang)
   END IF

   #匯出包tar檔所在完整路徑
   LET g_alm_tar_path = os.Path.join(l_str.trim(), l_tar_name.trim())
   
   #LET g_export_flag = TRUE
   RETURN TRUE
END FUNCTION

#+ 初始化
PUBLIC FUNCTION sadzi888_01_init()
   DEFINE l_sql             STRING
   DEFINE li_idx            INTEGER
    
   LET g_error_message = ""
   LET g_alm_tar_path = ""
   LET g_write_log = FALSE
   LET g_log_file = ""
   LET g_gen_prog_pre = "adzi210,adzi150,azzi988,azzi908"
   LET g_patch005 = FALSE
   INITIALIZE g_channel TO NULL
   
   LET g_alm_jb = FGL_GETENV("DGENV")
   IF cl_null(g_alm_jb) THEN
      LET g_alm_jb = g_dgenv_c
   END IF
   
   #2016/04/22
   #過單打包
   IF g_run_mode = '1' THEN
      #全做(根據gzzy_t設定)
      LET l_sql = " SELECT gzzy001 FROM gzzy_t",
                  "  WHERE gzzystus = 'Y' "  
      DECLARE sadzi888_01_alm_lang_cs CURSOR WITH HOLD FROM l_sql
      LET li_idx = 1   
      FOREACH sadzi888_01_alm_lang_cs INTO g_lang_list[li_idx] 
         LET li_idx = li_idx + 1
      END FOREACH
   END IF
   
   #patch打包 
   IF g_run_mode = '3' THEN
      #要處理的語言別(patch-預設-繁簡中,英)
      LET g_lang_list[1] = 'zh_TW'
      LET g_lang_list[2] = 'zh_CN' 
      LET g_lang_list[3] = 'en_US'
   END IF
   #2016/04/22
   
   #是否串接ALM
   LET g_top_alm = FGL_GETENV("TOPALM")
   IF cl_null(g_top_alm) THEN
      LET g_top_alm = "N"
   END IF
   
   #是否允許簽出
   LET g_top_checkout = FGL_GETENV("TOPCHKOUT")
   IF cl_null(g_top_checkout) THEN
      LET g_top_checkout = "Y"
   END IF
   
   #是否為背景執行
   IF g_show_msg = "N" THEN
      LET g_bgjob = "Y"
   END IF
   
   LET g_dzld012 = FGL_GETENV("ERPID")     #產品代號
   LET g_dzld013 = FGL_GETENV("ERPVER")    #產品版本

   
   #取得[匯入動作為1:Merge or 2:Insert]取得所有相關註冊資訊清單
   LET l_sql = "SELECT ddata002, ddata003, ddata004, ddata005, ddata006, ",
               "       ddata007, ddata008, ddata009, ddata010, ddata015 ",
               "  FROM adzi888_ddata LEFT JOIN adzi888_master ON ddata001 = master001 ",
               "  WHERE ddata001 = ? ",
               "    AND (ddata004 = '1' OR ddata004 = '2') ",
               "  ORDER BY ddata002 "
   DECLARE sadzi888_01_ddata_exp_cs CURSOR WITH HOLD FROM l_sql
   
   #取得所有相關註冊資訊資料清單
   LET l_sql = "SELECT ddata002, ddata003, ddata004, ddata005, ddata006, ",
               "       ddata007, ddata008, ddata009, ddata010, ddata015 ",
               "  FROM adzi888_ddata LEFT JOIN adzi888_master ON ddata001 = master001 ",
               "  WHERE ddata001 = ? ",
               "  ORDER BY ddata002 "
   DECLARE sadzi888_01_ddata_imp_cs CURSOR WITH HOLD FROM l_sql

   #取得相關註冊維護作業[資料表代碼]清單
   LET l_sql = "SELECT dzyb001, dzyb002, dzyb003, dzyb004, dzyb005, ",
               "       dzyb006, dzyb007, dzyb008, dzyb009, ",
               "       dzyc002, dzyc003, dzyc004, dzyc005 ",
               "  FROM dzyb_t LEFT JOIN dzyc_t ON dzyb002 = dzyc001 ",
               "  WHERE dzyb001 = ? ",
               "  ORDER BY dzyb003 DESC "
   DECLARE sadzi888_01_dzyb_desc_cs CURSOR WITH HOLD FROM l_sql

   LET l_sql = "SELECT dzyb001, dzyb002, dzyb003, dzyb004, dzyb005, ",
               "       dzyb006, dzyb007, dzyb008, dzyb009, ",
               "       dzyc002, dzyc003, dzyc004, dzyc005 ",
               "  FROM dzyb_t LEFT JOIN dzyc_t ON dzyb002 = dzyc001 ",
               "  WHERE dzyb001 = ? ",
               "  ORDER BY dzyb003 ASC "
   DECLARE sadzi888_01_dzyb_asc_cs CURSOR WITH HOLD FROM l_sql
   
   #取得所有相關檔案匯出清單
   LET l_sql = "SELECT dfile002, dfile003, dfile004, dfile005, dfile006, ",
               "       dfile007 ",
               "  FROM adzi888_dfile LEFT JOIN adzi888_master ON dfile001 = master001 ",
               "  WHERE dfile001 = ? ",
               "  ORDER BY dfile002 "
   DECLARE sadzi888_01_dfile_cs CURSOR FROM l_sql

   #取得所有相關IT工具類匯出清單
   LET l_sql = "SELECT dtool002, dtool003, dtool004, dtool005, dtool006, ",
               "       dtool007, dtool008, dtool009 ",
               "  FROM adzi888_dtool LEFT JOIN adzi888_master ON dtool001 = master001 ",
               "  WHERE dtool001 = ? ",
               "  ORDER BY dtool002 "
   DECLARE sadzi888_01_dtool_cs CURSOR FROM l_sql
   
   #取得語系清單
   LET l_sql = "SELECT gzzy001 FROM gzzy_t ",
               "  WHERE gzzystus = 'Y' ",
               "    AND gzzy001 IN ('zh_TW', 'zh_CN') "
   DECLARE sadzi888_01_gzzy_cs CURSOR FROM l_sql
   
   #取得所屬維護作業清單
   LET l_sql = "SELECT ddata002, ddata003, ddata004, ddata005, ddata006, ",
               "       ddata007, ddata008, ddata009, ddata010, ddata015 ",
               "  FROM adzi888_ddata LEFT JOIN adzi888_master ON ddata001 = master001 ",
               "  WHERE ddata001 = ? AND ddata005 = ? ",
               "  ORDER BY ddata002 "
   DECLARE sadzi888_01_ddata005_cs CURSOR WITH HOLD FROM l_sql
   
END FUNCTION

#+ 切換工作路徑到製造匯出檔的工作目錄下
PUBLIC FUNCTION sadzi888_01_change_pack_dir(p_pack_dir)
   DEFINE p_pack_dir        STRING     #打包檔置放路徑
   
   #記錄目前程式執行路徑
   LET g_work_dir = os.Path.pwd()
   
   IF NOT os.Path.chdir(p_pack_dir) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_pack_dir.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, p_pack_dir.trim())
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ 建立匯出包目錄
PUBLIC FUNCTION sadzi888_01_make_pack_dir(p_folder, p_tar_name)
   DEFINE p_folder          STRING     #匯出檔目錄
   DEFINE p_tar_name        STRING     #匯出包名稱


   IF cl_null(p_folder) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00349"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg("adz-00349", g_lang)
      RETURN FALSE
   END IF
   
   #先刪除已存在的匯出包目錄和tar檔
   IF NOT sadzi888_01_delete_pack(p_folder, p_tar_name) THEN
      RETURN FALSE
   END IF
   
   #重新建立目錄
   IF NOT os.Path.mkdir(p_folder) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00341"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_folder.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00341", g_lang, p_folder.trim())
      RETURN FALSE
   END IF

   #切換到新目錄下,準備將匯出檔皆置於此目錄下
   IF (NOT os.Path.EXISTS(p_folder)) OR (NOT os.Path.chdir(p_folder)) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_folder.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, p_folder.trim())
      RETURN FALSE
   END IF   

   RETURN TRUE
END FUNCTION

#+ 刪除匯出包目錄和tar檔
PUBLIC FUNCTION sadzi888_01_delete_pack(p_folder, p_tar_name)
   DEFINE p_folder          STRING     #匯出檔目錄
   DEFINE p_tar_name        STRING     #匯出包名稱

   DEFINE l_msg             STRING
   DEFINE l_cmd             STRING
   
   #檢查目錄是否存在
   IF os.Path.EXISTS(p_folder) THEN
      #是否為背景執行
      IF g_show_msg = "Y" THEN
         #詢問一下是否要刪除
         LET l_msg = cl_getmsg_parm("adz-00323", g_lang, p_folder)
         
         IF NOT cl_ask_type1(l_msg, "Warning") THEN
            RETURN FALSE
         END IF
      END IF

      #刪除目錄
      LET l_cmd = "rm -rf ", p_folder
      RUN l_cmd

      #刪除tar檔
      IF os.Path.EXISTS(p_tar_name) THEN
         LET l_cmd = "rm -f ", p_tar_name
         RUN l_cmd
      END IF
   END IF

   #檢查tar是否存在
   IF os.Path.EXISTS(p_tar_name) THEN
       #是否為背景執行
       IF g_show_msg = "Y" THEN
         #詢問一下是否要刪除
         LET l_msg = cl_getmsg_parm("adz-00323", g_lang, p_tar_name)
         IF NOT cl_ask_type1(l_msg, "Warning") THEN
            RETURN FALSE
         END IF
      END IF

      #刪除tar檔
      LET l_cmd = "rm -f ", p_tar_name
      RUN l_cmd
   END IF

   RETURN TRUE
END FUNCTION

#+ 切換工作路徑到原本程式執行路徑下
PUBLIC FUNCTION sadzi888_01_change_work_dir()

   IF cl_null(g_work_dir) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00350"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg("adz-00350", g_lang)
      RETURN FALSE
   END IF
   
   #切換回正確程式執行路徑
   IF NOT os.Path.chdir(g_work_dir) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  g_work_dir.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, g_work_dir.trim())
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ 註冊資訊[資料]匯出
PUBLIC FUNCTION sadzi888_01_export_data(p_master001, p_master013, p_master014)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   
   DEFINE l_file            STRING
   DEFINE l_sql             STRING
   DEFINE l_pack_ddata      type_g_ddata_d
   DEFINE l_ddata008        LIKE type_t.chr1      #匯出狀態(0:建立; 1:成功; 2:失敗)
   DEFINE l_pack_dzyb       type_g_dzyb
   DEFINE l_errcode         STRING
   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_wc              STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_summary_file    STRING                #資料表資料的匯總檔
   DEFINE l_middle_file     STRING                #資料表資料的中介檔
   DEFINE l_table_list_json util.JSONObject
   DEFINE l_channel         base.Channel
   DEFINE l_str             STRING
   DEFINE l_size            LIKE type_t.num10
   DEFINE l_sys_dzyb002     STRING                #設計資料所在schema
   DEFINE l_dspatch_dzyb002 STRING                #dspatch schema下的資料表代碼,ex:dspatch.imaa_t
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_dzeb004         LIKE dzeb_t.dzeb004   #primary key
   
   LET l_table_list_json = util.JSONObject.create()
   
   LET l_str = "export data start:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)
   
   #找出[匯入動作為1:Merge or 2:Insert]的註冊資訊
   FOREACH sadzi888_01_ddata_exp_cs USING p_master001
                                    INTO l_pack_ddata.ddata002, l_pack_ddata.ddata003, l_pack_ddata.ddata004, l_pack_ddata.ddata005, l_pack_ddata.ddata006,  
                                         l_pack_ddata.ddata007, l_pack_ddata.ddata008, l_pack_ddata.ddata009, l_pack_ddata.ddata010, l_pack_ddata.ddata015
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzi888_01_ddata_exp_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-FOREACH sadzi888_01_ddata_exp_cs:", cl_getmsg(l_errcode, g_lang)
         RETURN FALSE
      END IF

      LET l_str = ASCII 10, "####################", ASCII 10
      LET l_str = l_str, "ddata002: ", l_pack_ddata.ddata002 USING "<<<<<", "; "
      LET l_str = l_str, "ddata003: '", l_pack_ddata.ddata003 CLIPPED, "'; "
      LET l_str = l_str, "ddata005: '", l_pack_ddata.ddata005 CLIPPED, "'; "
      LET l_str = l_str, "ddata006: '", l_pack_ddata.ddata006 CLIPPED, "'; "
      LET l_str = l_str, "ddata007: '", l_pack_ddata.ddata007 CLIPPED, "'; "
      CALL sadzi888_01_log_file_write(l_str)
      
      LET l_ddata008 = "1"
      LET l_sub_sql = ""

      #取得該註冊資訊維護作業[資料表代碼]清單
      FOREACH sadzi888_01_dzyb_desc_cs USING l_pack_ddata.ddata005
                                       INTO l_pack_dzyb.dzyb001, l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb005, 
                                            l_pack_dzyb.dzyb006, l_pack_dzyb.dzyb007, l_pack_dzyb.dzyb008, l_pack_dzyb.dzyb009, 
                                            l_pack_dzyb.dzyc002, l_pack_dzyb.dzyc003, l_pack_dzyb.dzyc004, l_pack_dzyb.dzyc005 
         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH sadzi888_01_dzyb_desc_cs:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "ERROR-FOREACH sadzi888_01_dzyb_desc_cs:", cl_getmsg(l_errcode, g_lang)
            LET l_ddata008 = "2"
            EXIT FOREACH
         END IF

         LET l_file = l_pack_ddata.ddata002 USING "<<<<<", "-", l_pack_dzyb.dzyb002 CLIPPED, ".unl"

         #[單身子項]項目的過單,遇到[次要資料條件]欄位為null時:表示該資料表內容並不存在[單身子項]的資料
         IF l_pack_ddata.ddata015 = "d" AND cl_null(l_pack_dzyb.dzyb008) THEN
            CONTINUE FOREACH
         END IF

         #取得資料過濾條件
         CALL sadzi888_01_get_export_wc(l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb008, l_pack_ddata.ddata005, l_pack_ddata.ddata006, l_pack_ddata.ddata007, l_pack_ddata.ddata015)
            RETURNING l_success, l_wc

         IF (NOT l_success) OR cl_null(l_wc) THEN
            IF cl_null(g_error_message) THEN
               LET g_error_message = "sadzi888_01_get_export_wc is error."
            END IF
            
            RETURN FALSE
         END IF

         
         #2016/09/20
         #dzbd額外條件
         #IF l_pack_dzyb.dzyb002 = 'dzbd_t' AND g_run_mode = 1 THEN
         #   #DISPLAY l_sql,  
         #   #    " AND dzbd001 IN (SELECT UNIQUE(dzbc001) FROM dzbc_t WHERE dzbc005='m' AND dzbc001 = '",l_pack_ddata.ddata006,"')"
         #   LET l_wc = l_wc,  
         #       " AND dzbd001 IN (SELECT UNIQUE(dzbc001) FROM dzbc_t WHERE dzbc005='m' AND dzbc001 = '",l_pack_ddata.ddata006,"')"
         #END IF
         #2016/09/20
         
         
         LET l_sql = "SELECT * FROM ", l_pack_dzyb.dzyb002 CLIPPED, " ", l_wc
         
         #patch模式且在標準環境下只取得某些固定條件的資料
         IF g_patch_mode AND g_alm_jb = g_dgenv_s THEN
            #取得標準版資料
            IF NOT cl_null(l_pack_dzyb.dzyc003) THEN
               LET l_sql = l_sql, " AND ", l_pack_dzyb.dzyc003 CLIPPED, " <> '", g_dgenv_c CLIPPED, "'"
            END IF

            #資料多語言相關資料表只出貨zh_TW和zh_CN
            IF NOT cl_null(l_pack_dzyb.dzyc005) THEN
               LET l_sql = l_sql, " AND (", l_pack_dzyb.dzyc005 CLIPPED, " = 'zh_TW' OR ", l_pack_dzyb.dzyc005 CLIPPED, " = 'zh_CN')"
            END IF

            #menu資料只取得ent=99的資料出patch
            IF l_pack_ddata.ddata005 = "azzi880" AND (NOT cl_null(l_pack_dzyb.dzyc004)) THEN
               #替換"dest."目的地table別名成null
               LET l_sub_sql = cl_replace_str(l_pack_dzyb.dzyc004, "dest.", "") 

               LET l_sql = l_sql, " AND ", l_sub_sql.trim()
            END IF
         END IF

         #標準環境下gzgm_t需另外只過gzgm003='YY' OR gzgm003= 'ZZ'
         IF g_alm_jb = g_dgenv_s AND l_pack_dzyb.dzyb002 = "gzgm_t" THEN
            LET l_sql = l_sql, " AND (gzgm003 = 'YY' OR gzgm003 = 'ZZ')"  
         END IF

         #在export data過程中需unload to file mode
         IF cl_null(g_unload_file) OR g_unload_file THEN
            LET l_str = "UNLOAD TO ", l_file, " ", l_sql
            CALL sadzi888_01_log_file_write(l_sql)
            
            UNLOAD TO l_file l_sql

            IF STATUS THEN
               LET l_errcode = STATUS
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
               LET l_ddata008 = "2"
               EXIT FOREACH
            END IF
         
            #todo:檢查一下主要資料表是否有Data被UNLOAD下來(防止在adzi888 key錯)
            IF l_pack_dzyb.dzyb003 = "Y" THEN
               LET l_size = os.Path.size(l_file)
               IF l_size = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "adz-00386"
                  LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = l_pack_ddata.ddata005 CLIPPED
                  LET g_errparam.replace[2] = l_pack_ddata.ddata006 CLIPPED
                  CALL cl_err()
                  LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00386", g_lang, l_pack_ddata.ddata005 || "|" || l_pack_ddata.ddata006)
                  RETURN FALSE
               END IF
            END IF
         END IF

         #[patch資料]匯出至dspatch
         IF (NOT cl_null(g_batch_flag)) AND (g_batch_flag) THEN
            #取得系統資料所在schema
            LET l_sys_dzyb002 = l_pack_dzyb.dzyb002 CLIPPED
   
            #取得dspatch的目標資料表代碼
            LET l_dspatch_dzyb002 = g_patch_schema CLIPPED, ".", l_pack_dzyb.dzyb002 CLIPPED

            IF NOT sadzi888_01_export_dspatch_data(l_dspatch_dzyb002, l_sql) THEN
               RETURN FALSE
            END IF

            #記錄目前需要import資料的表格代碼
            IF NOT l_table_list_json.has(l_sys_dzyb002) THEN
               CALL l_table_list_json.put(l_sys_dzyb002.trim(), l_dspatch_dzyb002.trim())
            END IF
         END IF
      END FOREACH

      #更新匯出狀態
      UPDATE adzi888_ddata SET ddata008 = l_ddata008
        WHERE ddata001 = p_master001
          AND ddata002 = l_pack_ddata.ddata002

      #串接ALM環境時,更新需求單狀態
      IF g_top_alm = "Y" AND (NOT (cl_null(p_master013) AND cl_null(p_master014))) THEN
         #同步回ALM需求單
         UPDATE dzld_t SET dzld008 = l_ddata008
           WHERE dzld002 = l_pack_ddata.ddata002
             AND dzld011 = p_master013
             AND dzld012 = g_dzld012
             AND dzld013 = g_dzld013
             AND dzld014 = p_master014
      END IF
   END FOREACH

   #因為azzi903裡的gzzq_t的ACTION多語言有大部份都屬於gzzq001='standard',所以需要獨立UNLOAD data
   #因此這部份資料需要額外處理
   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     WHERE ddata005 = 'azzi903'

   IF l_cnt > 0 THEN
      CALL sadzi888_01_unload_gzzq001_standard_data()
   END IF

   #取得azzi330報表表頭相關單身設定資料(因此這部份資料條件較特殊所以額外處理)
   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     WHERE ddata005 = 'azzi330'

   IF l_cnt > 0 THEN
      #匯出azzi330相關資料
      IF NOT sadzi888_01_azzi330_detail_data("exp") THEN
         RETURN FALSE
      END IF
   END IF
   
   LET l_str = "table list:", l_table_list_json.toString()
   DISPLAY l_str
   CALL sadzi888_01_log_file_write(l_str)

   #將summary file寫入xml file
   IF NOT cl_null(l_table_list_json.toString()) THEN
      LET l_channel = base.Channel.create()
      CALL l_channel.openFile(g_table_list, "w")
      CALL l_channel.setDelimiter("")

      LET l_str = l_table_list_json.toString()
      CALL l_channel.write(l_str)

      IF NOT os.Path.exists(g_table_list) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00382"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "BREAK_ERROR-", cl_getmsg("adz-00382", g_lang)
         RETURN FALSE
      END IF

      LET l_str = "chmod 666 ", g_table_list CLIPPED, " >/dev/null 2>/dev/null"
      RUN l_str
   END IF
   
   LET l_str = "export data end:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)
   
   RETURN TRUE
END FUNCTION

#+ [patch資料]匯出至dspatch schema
PUBLIC FUNCTION sadzi888_01_export_dspatch_data(p_dspatch_dzyb002, p_sql)
   #DEFINE p_dzyb002         LIKE dzyb_t.dzyb002   #資料表代碼
   DEFINE p_dspatch_dzyb002 STRING                #dspatch schema下的資料表代碼,ex:dspatch.imaa_t
   DEFINE p_sql             STRING

   DEFINE l_ins_sql         STRING
   DEFINE l_errcode         STRING
   DEFINE l_str             STRING
   
   IF cl_null(p_dspatch_dzyb002) OR cl_null(p_sql) THEN
      LET g_error_message = "BREAK_ERROR-sadzi888_01_export_dspatch_data is null."
      RETURN FALSE
   END IF

   #取得insert SQL語法
   IF p_dspatch_dzyb002.getIndexOf(g_patch_schema, 1) > 0 THEN
      LET l_ins_sql = "INSERT INTO ", p_dspatch_dzyb002, " (", p_sql, ")"
      CALL sadzi888_01_log_file_write(l_ins_sql)
      
      PREPARE sadzi888_01_ins_dspatch_data_pre FROM l_ins_sql
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE sadzi888_01_ins_dspatch_data_pre:', p_dspatch_dzyb002.trim()
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-PREPARE sadzi888_01_ins_dspatch_data_pre.", p_dspatch_dzyb002.trim(), ":", cl_getmsg(l_errcode, g_lang)
         RETURN FALSE
      END IF
   
      EXECUTE sadzi888_01_ins_dspatch_data_pre
      CASE 
         WHEN SQLCA.sqlcode = "-268"
            LET l_str = "Warn:", cl_getmsg(SQLCA.sqlcode, g_lang), "--", ASCII 10, "    ", l_ins_sql.trim()
            DISPLAY l_str
            CALL sadzi888_01_log_file_write(l_str)

         WHEN SQLCA.sqlcode <> 0
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = 'exc sadzi888_01_ins_dspatch_data_pre:', l_ins_sql
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "ERROR-exc sadzi888_01_ins_dspatch_data_pre.", l_ins_sql.trim(), ":", cl_getmsg(l_errcode, g_lang)
            RETURN FALSE
      END CASE
   ELSE
      DISPLAY "ERROR-ins sql:", p_dspatch_dzyb002
   END IF
   
   RETURN TRUE
END FUNCTION

#+ 註冊資訊[檔案]匯出
PUBLIC FUNCTION sadzi888_01_export_file(p_master001, p_master013, p_master014, p_pack_dir, p_folder)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   DEFINE p_pack_dir        STRING                #打包檔置放路徑
   DEFINE p_folder          STRING                #匯出檔所在目錄
   
   DEFINE l_dfile           type_g_dfile_d
   DEFINE l_cmd             STRING
   DEFINE l_source          STRING
   DEFINE l_dest            STRING
   DEFINE l_dest_indx       LIKE type_t.num10    #2016/02/15 by ka0132
   DEFINE l_dest_unique     STRING               #2016/02/15 by ka0132
   DEFINE l_tar_name        STRING
   DEFINE l_dfile003_str    STRING
   DEFINE l_dfile006        LIKE type_t.chr1     #匯出狀態(0:建立; 1:成功; 2:失敗) 
   DEFINE l_errcode         STRING
   DEFINE li_cnt            LIKE type_t.num10    #2016/04/22 by ka0132
   #2016/08/03
   DEFINE ls_sql            STRING
   DEFINE li_idx            LIKE type_t.num10
   DEFINE lr_dfile          RECORD
          cnt               LIKE type_t.num5,      #出現次數
          dfile001          LIKE dzlf_t.dzlf001,  
          dfile002          LIKE dzlf_t.dzlf002,   #項次
          dfile003          LIKE dzlf_t.dzlf003,   #路徑
          dfile004          LIKE dzlf_t.dzlf004,   #類型
          dfile005          LIKE dzlf_t.dzlf005    #檔名
          END RECORD
   DEFINE ls_dfile003       STRING                 #路徑
   DEFINE lc_dfile003       LIKE dzlf_t.dzlf003    #路徑
   #2016/08/03
   
   #2016/08/03
   #整理成無/
   LET ls_sql = " SELECT dfile001,dfile002,dfile003 ",
                "   FROM adzi888_dfile ",
                "  WHERE dfile003 LIKE '%/'"  
   PREPARE dfile_upd_pre FROM ls_sql
   DECLARE dfile_upd_cur CURSOR FOR dfile_upd_pre
   FOREACH dfile_upd_cur INTO lr_dfile.dfile001,
                              lr_dfile.dfile002,
                              lr_dfile.dfile003
      LET ls_dfile003 = lr_dfile.dfile003
      IF ls_dfile003.subString(ls_dfile003.getLength(),ls_dfile003.getLength()) = '/' THEN
         LET lc_dfile003 = ls_dfile003.subString(1,ls_dfile003.getLength()-1)
         #修改為無/
         UPDATE adzi888_dfile 
            SET dfile003 = lc_dfile003 #去除/
          WHERE dfile001 = lr_dfile.dfile001
            AND dfile002 = lr_dfile.dfile002
            AND dfile003 = lr_dfile.dfile003 
      END IF
   END FOREACH
   
   #export前砍掉重複資料
   LET ls_sql = " SELECT COUNT(*),dfile003,dfile004,dfile005 ",
                "   FROM adzi888_dfile ",
                "  GROUP BY dfile003,dfile004,dfile005 ",
                " HAVING COUNT(*) > 1 "
           
   PREPARE dfile_pre FROM ls_sql
   DECLARE dfile_cur CURSOR FOR dfile_pre
   
   FOREACH dfile_cur INTO lr_dfile.cnt,
                          lr_dfile.dfile003,
                          lr_dfile.dfile004,
                          lr_dfile.dfile005 
      #開始刪除不必要資料
      SELECT dfile002,dfile003,dfile004,dfile005 
        INTO lr_dfile.dfile002,
             lr_dfile.dfile003,
             lr_dfile.dfile004,
             lr_dfile.dfile005 
             FROM adzi888_dfile 
            WHERE rownum = 1 
              AND dfile003 = lr_dfile.dfile003
              AND dfile004 = lr_dfile.dfile004
              AND dfile005 = lr_dfile.dfile005 
   
      DELETE FROM adzi888_dfile 
            WHERE dfile002 <> lr_dfile.dfile002
              AND dfile003 = lr_dfile.dfile003
              AND dfile004 = lr_dfile.dfile004
              AND dfile005 = lr_dfile.dfile005 
              
   END FOREACH
   
   #2016/09/06
   #刪除$TOP/www/doc*的資料 - 瘦身
   IF g_run_mode <> '1' THEN 
      DELETE FROM adzi888_dfile 
            WHERE dfile003 LIKE '$TOP/www/doc%' 
   END IF
   #2016/09/06
   
   #2016/08/03
   
   #找出[檔案匯出清單]
   FOREACH sadzi888_01_dfile_cs USING p_master001 
                                INTO l_dfile.dfile002, l_dfile.dfile003, l_dfile.dfile004, l_dfile.dfile005, l_dfile.dfile006, 
                                     l_dfile.dfile007
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzi888_01_dfile_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-FOREACH sadzi888_01_dfile_cs:", cl_getmsg(l_errcode, g_lang)
         RETURN FALSE
      END IF

      #檔案類型為[f:檔案],cp {路徑}/{檔名} $FOLDER/f#
      #檔案類型為[d:整個目錄結構],tar cvf $FOLDER/d# {檔名}

      LET l_cmd = ""
      CASE l_dfile.dfile004 CLIPPED
         WHEN "f"
            #2016/02/15 by ka0132 -Begin-
            #2016/04/22 by ka0132 -Begin-
            #只有檔名重複出現才需處理
            SELECT COUNT(*) INTO li_cnt FROM adzi888_dfile
             WHERE dfile005 = l_dfile.dfile005
            IF li_cnt > 1 THEN
               LET l_source = os.Path.join(l_dfile.dfile003 CLIPPED, l_dfile.dfile005 CLIPPED)
               LET l_dest = os.Path.join(os.Path.join(p_pack_dir, p_folder), l_dfile.dfile005 CLIPPED)
               LET l_source = os.Path.join(l_dfile.dfile003 CLIPPED, l_dfile.dfile005 CLIPPED)
               LET l_dest_unique = l_dfile.dfile002 USING "&&&&&&&&&&", "-", l_dfile.dfile005 CLIPPED
               LET l_dest = os.Path.join(os.Path.join(p_pack_dir, p_folder), l_dest_unique)
               LET l_cmd = "cp ", l_source.trim(), " ", l_dest.trim()
               #RUN l_cmd
            #END IF
            ELSE
            #2016/04/22 by ka0132 -End-
            #2016/02/15 by ka0132 -End-
               LET l_source = os.Path.join(l_dfile.dfile003 CLIPPED, l_dfile.dfile005 CLIPPED)
               LET l_dest = os.Path.join(os.Path.join(p_pack_dir, p_folder), l_dfile.dfile005 CLIPPED)
               LET l_cmd = "cp ", l_source.trim(), " ", l_dest.trim()
            END IF
         WHEN "d" 
            #2016/02/15 by ka0132 -Begin-
            #2016/04/22 by ka0132 -Begin-
            #製作tar檔
            #指定tar檔名稱
            SELECT COUNT(*) INTO li_cnt FROM adzi888_dfile
             WHERE dfile005 = l_dfile.dfile005
            IF li_cnt > 1 THEN
               LET l_tar_name = l_dfile.dfile005 CLIPPED, ".tgz"
               LET l_tar_name = l_dfile.dfile002 USING "&&&&&&&&&&", "-", l_dfile.dfile005 CLIPPED, ".tgz"
               LET l_source = l_dfile.dfile005 CLIPPED 
               #2016/02/15 by ka0132
               #IF l_source.getIndexOf('azzi933_help',1) THEN
               #   LET l_source = l_source.subString(20,l_source.getLength())
               #   LET l_dfile.dfile005 = l_source
               #END IF
               
               LET l_dest = os.Path.join(os.Path.join(p_pack_dir, p_folder), l_tar_name)
               
               LET l_cmd = "cd ", l_dfile.dfile003 CLIPPED, ";"
               LET l_cmd = l_cmd, "tar zcvf ", l_dest.trim(), " ", l_source.trim()
               #RUN l_cmd
            #END IF
            ELSE
               #2016/04/22 by ka0132 -End-
               #2016/02/15 by ka0132 -End-
               
               #製作tar檔
               #指定tar檔名稱
               LET l_tar_name = l_dfile.dfile005 CLIPPED, ".tgz"
               LET l_source = l_dfile.dfile005 CLIPPED
               #IF l_source.getIndexOf('azzi933_help',1) THEN
               #   LET l_source = l_source.subString(20,l_source.getLength())
               #   LET l_dfile.dfile005 = l_source
               #END IF
               LET l_dest = os.Path.join(os.Path.join(p_pack_dir, p_folder), l_tar_name)
               
               LET l_cmd = "cd ", l_dfile.dfile003 CLIPPED, ";"
               LET l_cmd = l_cmd, "tar zcvf ", l_dest.trim(), " ", l_source.trim()
            END IF
      END CASE

      LET l_dfile006 = "2"

      #檢查檔案是否存在
      LET l_dfile003_str = sadzp007_util_get_path(l_dfile.dfile003 CLIPPED) #160223-00028
      LET l_dfile003_str = os.Path.join(l_dfile003_str, l_dfile.dfile005 CLIPPED)
                  
      IF NOT os.Path.EXISTS(l_dfile003_str) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00339"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_source.trim()
         CALL cl_err()
         LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_dfile003_str.trim())
         RETURN FALSE
      ELSE
         #複製檔案
         DISPLAY "l_cmd:", l_cmd, ";"
         RUN l_cmd
      
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00338"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] =  l_source.trim()
            CALL cl_err()
            LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00338", g_lang, l_source.trim())
            RETURN FALSE
         END IF
         
         LET l_dfile006 = "1"
      END IF

      #更新匯出狀態
      UPDATE adzi888_dfile SET dfile006 = l_dfile006
        WHERE dfile001 = p_master001 
          AND dfile002 = l_dfile.dfile002

      #串接ALM環境時,更新需求單狀態
      IF g_top_alm = "Y" AND (NOT (cl_null(p_master013) AND cl_null(p_master014))) THEN
         #同步回ALM需求單
         UPDATE dzlf_t SET dzlf006 = l_dfile006    
           WHERE dzlf002 = l_dfile.dfile002
             AND dzlf008 = p_master013 
             AND dzlf009 = g_dzld012
             AND dzlf010 = g_dzld013
             AND dzlf011 = p_master014 
      END IF
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 匯出此次打包清單資訊
PUBLIC FUNCTION sadzi888_01_export_pack_list(p_master001)
   DEFINE p_master001       LIKE type_t.chr50  #GUID
   DEFINE l_file            STRING
   DEFINE l_sql             STRING
   DEFINE l_errcode         STRING
   
   #匯出[程式註冊資料匯出主檔]
   LET l_file = "Temp-", "adzi888_master.unl"
   LET l_sql = "SELECT * FROM adzi888_master WHERE master001 = '", p_master001 CLIPPED, "' "
   UNLOAD TO l_file l_sql
   
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF
   
   #匯出[設計資料匯出清單]
   LET l_file = "Temp-", "adzi888_ddata.unl"
   LET l_sql = "SELECT * FROM adzi888_ddata WHERE ddata001 = '", p_master001 CLIPPED, "' "
   UNLOAD TO l_file l_sql
   
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF
   
   #匯出[檔案匯出清單]
   LET l_file = "Temp-", "adzi888_dfile.unl"
   LET l_sql = "SELECT * FROM adzi888_dfile WHERE dfile001 = '", p_master001 CLIPPED, "' "
   UNLOAD TO l_file l_sql
   
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF

   #匯出[IT工具類匯出清單]
   LET l_file = "Temp-", "adzi888_dtool.unl"
   LET l_sql = "SELECT * FROM adzi888_dtool WHERE dtool001 = '", p_master001 CLIPPED, "' "
   UNLOAD TO l_file l_sql
   
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF
   
   #2016/08/23
   #匯出額外處理
   IF sadzi888_01_get_patch_info() THEN
   END IF
   #2016/08/23

   RETURN TRUE
END FUNCTION

#+ 依[需求單號]+[項次]開始執行patch[資料表(table)]匯出打包
PUBLIC FUNCTION sadzi888_01_dzea_export(p_patch002, p_patch003)
   DEFINE p_patch002        LIKE type_t.chr20     #需求單號
   DEFINE p_patch003        LIKE type_t.num5      #項次

   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_tar_file_path   STRING
   DEFINE l_cmd             STRING
   DEFINE l_str             STRING
   #Begin: debug
   DEFINE li_i              LIKE type_t.num5
   DEFINE ls_log            STRING
   DEFINE l_time_t          DATETIME YEAR TO SECOND                                                         
   DEFINE l_time_s          DATETIME YEAR TO SECOND                                                         
   DEFINE l_time_e          DATETIME YEAR TO SECOND 
   DEFINE l_time_r          INTERVAL DAY  TO SECOND 

   LET l_time_s = cl_get_current()
   LET ls_log = "ls_log:r.t:",l_time_s," ","start"
   CALL sadzi888_01_log_file_write(ls_log)
   DISPLAY ls_log
   #End: debug

   #因為在表格的匯出過程中也會切換路徑,所需把路徑切回目前工作路徑
   LET l_str = os.Path.pwd()
   
   CALL sadzi888_04_export_run(p_patch002, p_patch003) 
      RETURNING l_success, l_tar_file_path 

   #Begin: debug
   LET l_time_e = cl_get_current()
   LET l_time_r = l_time_e - l_time_s
   LET ls_log= "ls_log:r.t:","used time: ",l_time_r," (",l_time_s," ",l_time_e,")"
   CALL sadzi888_01_log_file_write(ls_log)
   DISPLAY ls_log
   #End: debug

   IF NOT l_success THEN
      LET g_error_message = "BREAK_ERROR-dzea export:", p_patch002 CLIPPED, ".", p_patch003 USING "<<<<<"
      RETURN FALSE
   END IF

   #把路徑切回打包的工作路徑
   IF NOT os.Path.chdir(l_str) THEN
      LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_str.trim())
      RETURN FALSE
   END IF
   
   #檢查匯出檔案是否為null
   IF cl_null(l_tar_file_path) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00374"
      LET g_errparam.extend = p_patch002 CLIPPED, ".", p_patch003 USING "<<<<<"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "BREAK_ERROR-", p_patch002 CLIPPED, ".", p_patch003 USING "<<<<<", ":", cl_getmsg("adz-00374", g_lang)
      RETURN FALSE
   END IF
   
   #cp此次過單的表格匯出檔到打包目錄
   LET l_cmd = "cp ", l_tar_file_path.trim(), " . "
   RUN l_cmd
      
   IF STATUS THEN
      LET g_error_message = "BREAK_ERROR-cp ", l_tar_file_path.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION



#+ 程式註冊資料匯入前置作業
PUBLIC FUNCTION sadzi888_01_import(p_master001,  p_master013, p_master014, p_pack_dir, p_folder)
   DEFINE p_master001       LIKE type_t.chr50
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   DEFINE p_pack_dir        STRING                #打包檔置放路徑
   DEFINE p_folder          STRING                #匯出檔目錄
   
   DEFINE l_tar_name        STRING                #匯出包名稱
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_master010       LIKE type_t.dat
   DEFINE l_str             STRING
   DEFINE l_folder_path     STRING
   DEFINE l_patch_user      STRING                #patch chema
   DEFINE l_patch_pwd       STRING
   DEFINE lb_result         LIKE type_t.chr1
   DEFINE ls_message        STRING
   #Begin: debug
   DEFINE li_i              LIKE type_t.num5
   DEFINE ls_log            STRING
   DEFINE l_time_t          DATETIME YEAR TO SECOND                                                         
   DEFINE l_time_s          DATETIME YEAR TO SECOND                                                         
   DEFINE l_time_e          DATETIME YEAR TO SECOND 
   DEFINE l_time_r          INTERVAL DAY  TO SECOND 
   #End: debug
   #2016/08/30
   DEFINE l_master012       LIKE type_t.chr20
   DEFINE l_erpid           STRING
   #2016/08/30
     
   #todo:因需控管T100 Light平台不可匯入任何來自T100平台的資訊,增加[產品代號]-[區域別]的判斷管制
   SELECT master012 INTO l_master012 FROM adzi888_master

   #2016/08/30
   
   #取得產品代號(exp:T100ERP-topprd)
   IF NOT cl_null(l_master012) AND l_master012 MATCHES "*-*" THEN
      LET l_erpid = l_master012
      LET l_erpid = l_erpid.subString(1, l_erpid.getIndexOf("-", 1) - 1)
      DISPLAY "資料匯出環境為:",l_erpid
      DISPLAY "目前所屬環境為:",FGL_GETENV("ERPID")
      IF l_erpid <> FGL_GETENV("ERPID") THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00740"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_erpid.trim()
         LET g_errparam.replace[2] = FGL_GETENV("ERPID") CLIPPED 
         CALL cl_err()
         LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00740", g_lang, l_erpid.trim() || "|" || FGL_GETENV("ERPID") CLIPPED)
         CALL sadzi888_01_log_file_write(g_error_message)
         RETURN FALSE
      END IF
   END IF 
   #2016/08/30   
   
   IF cl_null(p_folder) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00349"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "BREAK_ERROR:", cl_getmsg("adz-00349", g_lang)
      RETURN FALSE
   END IF
   
   LET l_tar_name = p_folder, ".tgz"   

   #切換到新目錄下,準備讀取所有匯出檔
   IF (NOT os.Path.EXISTS(p_folder)) OR (NOT os.Path.chdir(p_folder)) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_folder.trim()
      CALL cl_err()
      LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00340", g_lang, p_folder.trim())
      RETURN FALSE
   END IF

   #2016/08/23
   #匯入額外處理
   IF NOT sadzi888_01_get_patch_info() THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00901"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00901", g_lang, "")
      RETURN FALSE
   END IF 
   #2016/08/23
   
   #[檔案]匯出清單匯入
   #檢查檔案匯出清單是否有資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM adzi888_dfile

   #進度列控制
   IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
      CALL adzp999_01_refresh_tasks_progressbar(gc_imp_file, "adz-00606") 
   END IF

   IF l_cnt > 0 THEN
      LET l_str = "import file start:", cl_get_current(), ASCII 10
      CALL sadzi888_01_log_file_write(l_str)
      
      IF NOT sadzi888_01_import_file(p_master001, p_master013, p_master014, p_pack_dir, p_folder) THEN
         RETURN FALSE
      END IF

      LET l_str = "import file end:", cl_get_current(), ASCII 10
      CALL sadzi888_01_log_file_write(l_str)
   END IF
   
   #[資料表(table)]匯入
   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     WHERE ddata005 IN ('adzi140', 'adzi180', 'adzi190', 'adzi200')
   IF l_cnt > 0 THEN
      LET l_str = "import dzea start:", ASCII 10
      CALL sadzi888_01_log_file_write(l_str)

      #Begin: debug
      LET l_time_s = cl_get_current()
      LET ls_log = "ls_log:r.t:",l_time_s," ","start"
      CALL sadzi888_01_log_file_write(ls_log)
      DISPLAY ls_log
      #End: debug
   
      #因為在表格的匯出過程中也會切換路徑,所需把路徑切回目前工作路徑
      LET l_str = os.Path.pwd()
   
      LET l_folder_path = os.Path.join(p_pack_dir, p_folder)
      CALL sadzp240_run(l_folder_path.trim())
         RETURNING lb_result, ls_message

      #Begin: debug
      LET l_time_e = cl_get_current()
      LET l_time_r = l_time_e - l_time_s
      LET ls_log= "ls_log:r.t:","used time: ",l_time_r," (",l_time_s," ",l_time_e,")"
      CALL sadzi888_01_log_file_write(ls_log)
      DISPLAY ls_log
      #End: debug

      IF NOT lb_result THEN
         LET g_error_message = "ERROR:import dzea error, GUID :", ls_message
         DISPLAY g_error_message
         CALL sadzi888_01_log_file_write(g_error_message)
         RETURN FALSE
      END IF

      #把路徑切回打包的工作路徑
      IF NOT os.Path.chdir(l_str) THEN
         LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_str.trim())
         RETURN FALSE
      END IF
      
      LET l_str = "import dzea end:", ASCII 10
      CALL sadzi888_01_log_file_write(l_str)
   END IF

   #進度列控制
   IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
      CALL adzp999_01_refresh_tasks_progressbar(gc_imp_base_data, "adz-00607")
      CALL adzp999_01_refresh_sub_tasks_progressbar(1, 4)      
   END IF
   
   #執行r.s ds 確保整個ds.sch的結構是最新的
   IF g_patch_mode THEN
      LET l_str = "r.s ds start:", cl_get_current(), ASCII 10
      CALL sadzi888_01_log_file_write(l_str)
   
      LET l_str = "r.s ds "
      IF NOT sadzi888_01_run_command(l_str) THEN
         RETURN FALSE
      END IF
      LET l_str = "r.s ds end:", cl_get_current(), ASCII 10
      CALL sadzi888_01_log_file_write(l_str)
   END IF

   #進度列控制
   IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
      CALL adzp999_01_refresh_sub_tasks_progressbar(2, 4)
   END IF
   
   #因為azzi903裡的gzzq_t的ACTION多語言有大部份都屬於gzzq001='standard',所以需要獨立LOAD data
   #因此這部份資料需要額外處理
   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     WHERE ddata005 = 'azzi903'

   IF l_cnt > 0 THEN
      LET l_str = "import gzzq_standard start:", cl_get_current(), ASCII 10
      CALL sadzi888_01_log_file_write(l_str)
      
      CALL sadzi888_01_merge_table_data("gzzq_t", g_gzzq_standard)

      LET l_str = "import gzzq_standard end:", cl_get_current(), ASCII 10
      CALL sadzi888_01_log_file_write(l_str)
   END IF

   #進度列控制
   IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
      CALL adzp999_01_refresh_sub_tasks_progressbar(3, 4)
   END IF
   
   #LOAD azzi330報表表頭相關單身設定資料(因此這部份資料條件較特殊所以額外處理)
   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     WHERE ddata005 = 'azzi330'

   IF l_cnt > 0 THEN
      #匯入azzi330相關資料
      LET l_str = "import azzi330_detail_data() start:", cl_get_current(), ASCII 10
      CALL sadzi888_01_log_file_write(l_str)
      
      IF NOT sadzi888_01_azzi330_detail_data("imp") THEN
         RETURN FALSE
      END IF
      
      LET l_str = "import azzi330_detail_data() end:", cl_get_current(), ASCII 10
      CALL sadzi888_01_log_file_write(l_str)
   END IF
   
   LET l_str = "import data start:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)

   #進度列控制
   IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
      CALL adzp999_01_refresh_sub_tasks_progressbar(4, 4)
      CALL adzp999_01_refresh_tasks_progressbar(gc_imp_dmp, "adz-00608")
   END IF

   #[patch資料]匯入
   IF (NOT cl_null(g_batch_flag)) AND (g_batch_flag) THEN
      LET l_str = "import dmp start:", cl_get_current(), ASCII 10
      CALL sadzi888_01_log_file_write(l_str)

      #只有當g_import_dapatch="N"時,才不做import dspatch的動作
      IF cl_null(g_import_dapatch) OR g_import_dapatch <> "N" THEN
         LET l_patch_user = g_patch_schema
         LET l_patch_pwd = g_patch_pwd
      
         #patch dmp檔匯入
         #2016/02/22 by ka0132
         #IF NOT sadzi888_01_import_dmp(l_patch_user, l_patch_pwd) THEN
         #   RETURN FALSE
         #END IF
         #2016/02/22 by ka0132
      ELSE
         LET l_str = "Not import dmp.", ASCII 10
         CALL sadzi888_01_log_file_write(l_str)
      END IF

      LET l_str = "import dmp end:", cl_get_current(), ASCII 10
      CALL sadzi888_01_log_file_write(l_str)

      #整批匯入
      #2016/02/22 by ka0132
      IF NOT sadzi888_01_merge_data_batch_pre(p_master001) THEN
         RETURN FALSE
      END IF
      #2016/02/22 by ka0132
   ELSE
      #是否為dmp模式過單
      IF (NOT cl_null(g_dmp_mode)) AND (g_dmp_mode) THEN
         IF NOT sadzi888_01_import_data_dmp(p_master001, p_master013, p_master014) THEN
            RETURN FALSE
         END IF
      ELSE
         DISPLAY "sadzi888_01_import_data can not be call."
         RETURN FALSE
         #IF NOT sadzi888_01_import_data(p_master001, p_master013, p_master014) THEN
         #   RETURN FALSE
         #END IF
      END IF
   END IF

   LET l_str = "import data end:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)
   
   #更新匯入時間為目前時間
   LET l_master010 = cl_get_current()
   
   UPDATE adzi888_master SET master010 = l_master010
     WHERE master001 = p_master001

   #todo:adzi888 也有匯入功能,因此先將此訊息關閉
   #在patch UI之後,可利用patch_mode來判斷是否再將此訊息開啟
   ####是否為背景執行
   #IF g_show_msg = "Y" THEN
   #   CALL cl_ask_confirm3("adz-00346", l_tar_name.trim())
   #ELSE
      DISPLAY "Info:", cl_getmsg("adz-00346", g_lang)
   #END IF
   
   #2016/08/23
   #匯入額外處理
   #CALL sadzi888_01_get_patch_info()
   #2016/08/23

   RETURN TRUE
END FUNCTION

#+ patch匯出時,先將patch schema imp至dspatch
PUBLIC FUNCTION sadzi888_01_import_dmp(p_patch_user, p_patch_pwd)
   DEFINE p_patch_user      STRING                #patch chema
   DEFINE p_patch_pwd       STRING
   
   DEFINE l_dmp_file        STRING                #dmp檔名
   DEFINE l_cmd             STRING

   #取得dmp gzip檔名
   LET l_dmp_file = p_patch_user.trim(), ".dmp", ".gz"

   #檢查gzip檔是否存在
   IF NOT os.Path.EXISTS(l_dmp_file) THEN
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_dmp_file.trim())
      RETURN FALSE
   END IF

   #gunzip dspatch.dmp.gz
   LET l_cmd = "gunzip ", l_dmp_file.trim()
   RUN l_cmd
   
   IF STATUS THEN
      LET g_error_message = "BREAK_ERROR:", l_cmd.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF
      
   #取得dmp檔名
   LET l_dmp_file = p_patch_user.trim(), ".dmp"

   #檢查gzip檔是否存在
   IF NOT os.Path.EXISTS(l_dmp_file) THEN
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_dmp_file.trim())
      RETURN FALSE
   END IF

   #進度列控制
   IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
      CALL adzp999_01_refresh_sub_tasks_progressbar(1, 2)
   END IF
   
   #imp dspatch/dspatch FILE=dspatch.dmp LOG=dspatch.implog STATISTICS=NONE
   LET l_cmd = "imp ", p_patch_user.trim(), "/", p_patch_pwd.trim(), " ",
               "FILE=", l_dmp_file.trim(), " LOG=", p_patch_user.trim(), ".implog STATISTICS=NONE"

   IF NOT sadzi888_01_run_command(l_cmd) THEN
      RETURN FALSE
   END IF

   #進度列控制
   IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
      CALL adzp999_01_refresh_sub_tasks_progressbar(2, 2)
   END IF
   
   RETURN TRUE
END FUNCTION

####+ 註冊資訊[資料]匯入
###PUBLIC FUNCTION sadzi888_01_import_data(p_master001, p_master013, p_master014)
###   DEFINE p_master001       LIKE type_t.chr50     #GUID
###   DEFINE p_master013       LIKE type_t.chr20     #需求單號
###   DEFINE p_master014       LIKE type_t.num5      #作業項次
###   
###   DEFINE l_pack_ddata      type_g_ddata_d
###   DEFINE l_ddata009        LIKE type_t.chr1            #匯入狀態(0:建立; 1:成功; 2:失敗)
###   DEFINE l_pack_dzyb       type_g_dzyb
###   DEFINE l_i               LIKE type_t.num5
###   DEFINE l_str             STRING
###   DEFINE l_errcode         STRING
###   DEFINE l_file            STRING
###   DEFINE l_size            LIKE type_t.num5
###   DEFINE l_time_s          DATETIME YEAR TO SECOND 
###   DEFINE l_time_e          DATETIME YEAR TO SECOND
###
###   LET l_i = 1
###   
###   #因產生程序動作需有語系資料
###   IF NOT sadzi888_01_get_gzzy001() THEN
###      RETURN FALSE
###   END IF
###   
###   #找出所有需匯入處理的註冊資訊清單
###   FOREACH sadzi888_01_ddata_imp_cs USING p_master001
###                                    INTO l_pack_ddata.ddata002, l_pack_ddata.ddata003, l_pack_ddata.ddata004, l_pack_ddata.ddata005, l_pack_ddata.ddata006,  
###                                         l_pack_ddata.ddata007, l_pack_ddata.ddata008, l_pack_ddata.ddata009, l_pack_ddata.ddata010, l_pack_ddata.ddata015
###      IF SQLCA.sqlcode THEN
###         LET l_errcode = SQLCA.sqlcode
###         INITIALIZE g_errparam TO NULL
###         LET g_errparam.code =  SQLCA.sqlcode
###         LET g_errparam.extend = "FOREACH sadzi888_01_ddata_imp_cs:"
###         LET g_errparam.popup = TRUE
###         CALL cl_err()
###         LET g_error_message = "BREAK_ERROR-FOREACH sadzi888_01_ddata_imp_cs:", cl_getmsg(l_errcode, g_lang)
###         CALL sadzi888_01_log_file_write(g_error_message)
###         RETURN FALSE
###      END IF
###
###      ####不再重做已[匯入成功]清單
###      ###IF l_pack_ddata.ddata009 = "1" THEN
###      ###   CONTINUE FOREACH
###      ###END IF
###
###      DISPLAY "ddata002:", l_pack_ddata.ddata002 USING "<<<<<", "---ddata005:", l_pack_ddata.ddata005 CLIPPED
###      
###      LET l_str = ASCII 10, "####################", ASCII 10
###      LET l_str = l_str, "ddata002: ", l_pack_ddata.ddata002 USING "<<<<<", "; "
###      LET l_str = l_str, "ddata003: '", l_pack_ddata.ddata003 CLIPPED, "'; "
###      LET l_str = l_str, "ddata005: '", l_pack_ddata.ddata005 CLIPPED, "'; "
###      LET l_str = l_str, "ddata006: '", l_pack_ddata.ddata006 CLIPPED, "'; "
###      LET l_str = l_str, "ddata007: '", l_pack_ddata.ddata007 CLIPPED, "'; "
###      CALL sadzi888_01_log_file_write(l_str)
###         
###      BEGIN WORK
###      LET l_ddata009 = "1"
###
###      #取得該註冊資訊維護作業[資料表代碼]清單
###      FOREACH sadzi888_01_dzyb_asc_cs USING l_pack_ddata.ddata005
###                                      INTO l_pack_dzyb.dzyb001, l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb005, 
###                                           l_pack_dzyb.dzyb006, l_pack_dzyb.dzyb007, l_pack_dzyb.dzyb008, l_pack_dzyb.dzyb009, 
###                                           l_pack_dzyb.dzyc002, l_pack_dzyb.dzyc003, l_pack_dzyb.dzyc004, l_pack_dzyb.dzyc005 
###         IF SQLCA.sqlcode THEN
###            LET l_errcode = SQLCA.sqlcode
###            INITIALIZE g_errparam TO NULL
###            LET g_errparam.code =  SQLCA.sqlcode
###            LET g_errparam.extend = "FOREACH sadzi888_01_dzyb_asc_cs", l_pack_ddata.ddata005 CLIPPED, ":"
###            LET g_errparam.popup = TRUE
###            CALL cl_err()
###            LET g_error_message = "BREAK_ERROR-FOREACH sadzi888_01_dzyb_asc_cs.", l_pack_ddata.ddata005 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
###            CALL sadzi888_01_log_file_write(g_error_message)
###            LET l_ddata009 = "2"
###            EXIT FOREACH
###         END IF
###
###         #[單身子項]項目的過單,遇到[次要資料條件]欄位為null時:表示該資料表內容並不存在[單身子項]的資料
###         IF l_pack_ddata.ddata015 = "d" AND cl_null(l_pack_dzyb.dzyb008) THEN
###            CONTINUE FOREACH
###         END IF
###         
###         #為merge或insert型式時,先檢查資料匯入檔案是否存在,是否有資料需匯入
###         IF l_pack_ddata.ddata004 = "1" OR l_pack_ddata.ddata004 = "2" THEN
###            LET l_file = l_pack_ddata.ddata002 USING "<<<<<", "-", l_pack_dzyb.dzyb002 CLIPPED, ".unl"
###         
###            IF NOT os.Path.EXISTS(l_file) THEN
###               INITIALIZE g_errparam TO NULL
###               LET g_errparam.code =  "adz-00339"
###               LET g_errparam.extend = NULL
###               LET g_errparam.popup = TRUE
###               LET g_errparam.replace[1] =  l_file.trim()
###               CALL cl_err()
###               LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_file.trim())
###               CALL sadzi888_01_log_file_write(g_error_message)
###               LET l_ddata009 = "2"
###               EXIT FOREACH
###            END IF
###
###            #size為0:代表沒資料,不需匯入
###            #todo:但是因為4fd設計資料為完整4fd xml內容,所以dzlm, dzfl_t需完整刪除
###            LET l_size = os.Path.size(l_file)
###            IF l_size = 0 AND (NOT (l_pack_dzyb.dzyb002 = "dzfl_t" OR l_pack_dzyb.dzyb002 = "dzam_t")) THEN  
###               CONTINUE FOREACH
###            END IF
###         END IF
###
###         LET l_time_s = cl_get_current()
###         
###         #匯入註冊資訊Data
###         CASE l_pack_ddata.ddata004 CLIPPED
###            WHEN "1"     #Merge
###               IF sadzi888_01_pack_del_data(l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb008, 
###                                            l_pack_ddata.ddata005, l_pack_ddata.ddata006, l_pack_ddata.ddata007, l_pack_ddata.ddata015, l_pack_ddata.ddata002) THEN
###                  IF NOT sadzi888_01_pack_ins_data(l_file, l_pack_dzyb.dzyb002,  l_pack_ddata.ddata004) THEN
###                     LET l_ddata009 = "2"
###                  END IF
###               ELSE
###                  LET l_ddata009 = "2"
###               END IF
###               
###            WHEN "2"     #Insert
###               IF NOT sadzi888_01_pack_ins_data(l_file, l_pack_dzyb.dzyb002, l_pack_ddata.ddata004) THEN
###                  LET l_ddata009 = "2"
###               END IF
###               
###            WHEN "3"     #Delete
###               IF NOT sadzi888_01_pack_del_data(l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb008, 
###                                                l_pack_ddata.ddata005, l_pack_ddata.ddata006, l_pack_ddata.ddata007, l_pack_ddata.ddata015, l_pack_ddata.ddata002) THEN
###
###                  LET l_ddata009 = "2"
###               END IF
###               
###         END CASE
###
###         #記錄data load耗費時間
###         LET l_time_e = cl_get_current()
###         LET l_str = "    Cost time : ", l_time_e - l_time_s
###         CALL sadzi888_01_log_file_write(l_str)
###      
###         #匯入失敗處理
###         IF l_ddata009 = "2" THEN
###            EXIT FOREACH
###         END IF
###         
###      END FOREACH
###
###      IF l_ddata009 = "2" THEN
###         ROLLBACK WORK
###         RETURN FALSE
###      ELSE
###         COMMIT WORK
###
###         #依據各註冊資料性質,呼叫產生程序(如:azzi902需產生str, 42s檔案)
###         IF (l_pack_ddata.ddata004 = "1" OR l_pack_ddata.ddata004 = "2") AND (g_gen_prog_pre.getIndexOf(l_pack_ddata.ddata005, 1) > 0) THEN
###            #防止command run切換路徑,所需把路徑切回目前工作路徑
###            LET l_str = os.Path.pwd()
###   
###            IF NOT sadzi888_01_generator_program(l_pack_ddata.ddata005, l_pack_ddata.ddata006, l_pack_ddata.ddata007, l_pack_ddata.ddata015) THEN
###               DISPLAY "ERROR:sadzi888_01_generator_program( ", l_pack_ddata.ddata005, ", ", l_pack_ddata.ddata006, ")"
###
###               #非patch模式下,任何的產生錯誤都視為失敗
###               IF (NOT cl_null(g_patch_mode)) AND (NOT g_patch_mode) THEN
###                  LET g_error_message = "BREAK_ERROR:sadzi888_01_generator_program( ", l_pack_ddata.ddata005, ", ", l_pack_ddata.ddata006, ")"
###                  RETURN FALSE
###               END IF
###            END IF
###
###            #把路徑切回打包的工作路徑
###            IF NOT os.Path.chdir(l_str) THEN
###               LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_str.trim())
###               RETURN FALSE
###            END IF
###         END IF
###      END IF
###      
###      #更新匯入狀態
###      UPDATE adzi888_ddata SET ddata009 = l_ddata009
###        WHERE ddata001 = p_master001 
###          AND ddata002 = l_pack_ddata.ddata002
###      
###      #串接ALM環境時,更新需求單狀態
###      IF g_top_alm = "Y" AND (NOT (cl_null(p_master013) AND cl_null(p_master014))) THEN
###         #同步回ALM需求單
###         UPDATE dzld_t SET dzld009 = l_ddata009    
###           WHERE dzld002 = l_pack_ddata.ddata002
###             AND dzld011 = p_master013 
###             AND dzld012 = g_dzld012
###             AND dzld013 = g_dzld013
###             AND dzld014 = p_master014 
###      END IF
###
###      
###      LET l_str = "####################"
###      CALL sadzi888_01_log_file_write(l_str)
###
###      #todo:要考慮是不是設定資料導入失敗,就先終止import動作
###      #IF l_ddata009 = "2" THEN
###      #   RETURN FALSE
###      #END IF
###   END FOREACH
###
###   RETURN TRUE
###END FUNCTION

#+ 註冊資訊[資料]新增
PUBLIC FUNCTION sadzi888_01_pack_ins_data(p_file, p_dzyb002, p_ddata004)
   DEFINE p_file            STRING
   DEFINE p_dzyb002         LIKE dzyb_t.dzyb002
   DEFINE p_ddata004        LIKE type_t.chr1        #匯入動作(1:Merge; 2:Insert; 3:Delete)
   
   DEFINE l_sql             STRING
   DEFINE l_str             STRING
   DEFINE l_errcode         STRING
   
   LET l_sql = "INSERT INTO ", p_dzyb002 CLIPPED

   LET l_str = "LOAD FROM ", p_file, " ", l_sql
   CALL sadzi888_01_log_file_write(l_str)

   LOAD FROM p_file l_sql

   IF STATUS THEN
      IF p_ddata004 = "2" THEN
         LET l_str = "Warning-LOAD FROM ", p_file.trim(), ":", cl_getmsg(STATUS, g_lang)
         DISPLAY l_str
         CALL sadzi888_01_log_file_write(l_str)
      ELSE
         LET l_errcode = STATUS
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  STATUS
         LET g_errparam.extend = "LOAD FROM ", p_file.trim()
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-LOAD FROM ", p_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
         CALL sadzi888_01_log_file_write(g_error_message)
         RETURN FALSE
      END IF
   END IF
   
   RETURN TRUE
END FUNCTION

#+ [設定/設計資料]刪除
PUBLIC FUNCTION sadzi888_01_pack_del_data(p_dzyb002, p_dzyb003, p_dzyb004, p_dzyb008, p_ddata005, p_ddata006, p_ddata007, p_ddata015, p_ddata002)
   DEFINE p_dzyb002         LIKE dzyb_t.dzyb002
   DEFINE p_dzyb003         LIKE dzyb_t.dzyb003
   DEFINE p_dzyb004         LIKE dzyb_t.dzyb004
   DEFINE p_dzyb008         LIKE dzyb_t.dzyb008
   DEFINE p_ddata005        LIKE type_t.chr20
   DEFINE p_ddata006        LIKE type_t.chr50
   DEFINE p_ddata007        LIKE type_t.chr50
   DEFINE p_ddata015        LIKE type_t.chr1
   DEFINE p_ddata002        LIKE type_t.num5
   
   DEFINE l_sql             STRING
   DEFINE l_str             STRING
   DEFINE l_errcode         STRING
   DEFINE l_wc              STRING
   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_cmd             STRING #2016/07/07
   
   #取得資料過濾條件
   CALL sadzi888_01_get_export_wc(p_dzyb002, p_dzyb003, p_dzyb004, p_dzyb008, p_ddata005, p_ddata006, p_ddata007, p_ddata015)
      RETURNING l_success, l_wc

   IF (NOT l_success) OR cl_null(l_wc) THEN
      IF cl_null(g_error_message) THEN
         LET g_error_message = "sadzi888_01_get_export_wc is error."
      END IF

      RETURN FALSE
   END IF

   ##檢查是否有人正在LOCK資料
   #LET l_sql = "SELECT * FROM ", p_dzyb002 CLIPPED, " ", l_wc.trim(), " FOR UPDATE"                      
   #LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
   #LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   
   #DECLARE sadzi888_01_del_lock_cl CURSOR FROM l_sql   # LOCK CURSOR

   #OPEN sadzi888_01_del_lock_cl
   #IF STATUS THEN
   #   LET l_errcode = SQLCA.sqlcode
   #   INITIALIZE g_errparam TO NULL 
   #   LET g_errparam.extend = "OPEN sadzi888_01_del_lock_cl:" 
   #   LET g_errparam.code = STATUS 
   #   LET g_errparam.popup = TRUE 
   #   CALL cl_err()
   #   CLOSE sadzi888_01_del_lock_cl
   #   LET g_error_message = "BREAK_ERROR-OPEN sadzi888_01_del_lock_cl:", cl_getmsg(l_errcode, g_lang)
   #   CALL sadzi888_01_log_file_write(g_error_message)
   #   RETURN FALSE
   #END IF
   
   #CLOSE sadzi888_01_del_lock_cl
   
   LET l_sql = "DELETE FROM ", p_dzyb002 CLIPPED, " ", l_wc.trim()
   LET l_str = l_sql 
   CALL sadzi888_01_log_file_write(l_str)

   PREPARE sadzi888_01_pack_del_data_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE sadzi888_01_pack_del_data_pre:' || p_dzyb002 CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-PREPARE sadzi888_01_pack_del_data_pre." || p_dzyb002 CLIPPED || ":", cl_getmsg(l_errcode, g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF

   EXECUTE sadzi888_01_pack_del_data_pre
   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'exc sadzi888_01_pack_del_data_pre:' || p_dzyb002 CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-exc sadzi888_01_pack_del_data_pre." || p_dzyb002 CLIPPED || ":", cl_getmsg(l_errcode, g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF 

   #因azzi993參數資料可一個參數編號對應不同的參數作業
   #所以無法單純利用參數作業代碼來刪除參數資料
   #因此利用要過的資料欄位PK來補足該刪除的資料
   IF (p_dzyb002 = "gzsz_t" OR p_dzyb002 = "gzszl_t") AND p_ddata005 = "azzi993" THEN
      IF NOT sadzi888_01_del_match_data(p_dzyb002, p_ddata002) THEN
         RETURN FALSE
      END IF
   END IF
   
   #2016/07/07
   #刪除azzi051後特別處理
   IF p_ddata005 = "azzi051" THEN
      #執行adzp180重組/編譯
      LET l_cmd = "r.c3 ",p_ddata006," '' A 2"
      CALL sadzi888_01_log_file_write(l_cmd)
      IF NOT sadzi888_01_run_command(l_cmd) THEN
         RETURN FALSE
      END IF
   END IF
   #2016/07/07
   
   RETURN TRUE
END FUNCTION

#+ 註冊資訊[資料]整批刪除
PUBLIC FUNCTION sadzi888_01_delete_data_batch(p_master001)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   
   DEFINE l_pack_ddata      type_g_ddata_d
   DEFINE l_pack_dzyb       type_g_dzyb
   DEFINE l_str             STRING
   DEFINE l_errcode         STRING
   DEFINE l_file            STRING
   DEFINE l_size            LIKE type_t.num10
   
   DEFINE l_sql             STRING
   DEFINE l_wc              STRING
   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_sub_sql         STRING
   DEFINE l_prog_num        LIKE type_t.num10
   DEFINE l_prog_cnt        LIKE type_t.num10
   
   LET l_prog_num = 0

   LET l_str = "delete_data_batch:"
   CALL sadzi888_01_log_file_write(l_str)
   
   SELECT COUNT(*) INTO l_prog_cnt FROM adzi888_ddata
     WHERE ddata001 = p_master001

   #找出所有需匯入處理的註冊資訊清單
   FOREACH sadzi888_01_ddata_imp_cs USING p_master001
                                    INTO l_pack_ddata.ddata002, l_pack_ddata.ddata003, l_pack_ddata.ddata004, l_pack_ddata.ddata005, l_pack_ddata.ddata006,  
                                         l_pack_ddata.ddata007, l_pack_ddata.ddata008, l_pack_ddata.ddata009, l_pack_ddata.ddata010, l_pack_ddata.ddata015
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH delete_data.sadzi888_01_ddata_imp_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "BREAK_ERROR-FOREACH delete_data.sadzi888_01_ddata_imp_cs:", cl_getmsg(l_errcode, g_lang)
         CALL sadzi888_01_log_file_write(g_error_message)
         RETURN FALSE
      END IF

      DISPLAY "ddata002:", l_pack_ddata.ddata002 USING "<<<<<", "---ddata005:", l_pack_ddata.ddata005 CLIPPED
      
      #進度列控制
      LET l_prog_num = l_prog_num + 1
      IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
         CALL adzp999_01_refresh_sub_tasks_progressbar(l_prog_num, l_prog_cnt)
      END IF
      
      LET l_str = ASCII 10, "####################", ASCII 10
      LET l_str = l_str, "ddata002: ", l_pack_ddata.ddata002 USING "<<<<<", "; "
      LET l_str = l_str, "ddata003: ", l_pack_ddata.ddata003 CLIPPED, "; "
      LET l_str = l_str, "ddata005: ", l_pack_ddata.ddata005 CLIPPED, "; "
      LET l_str = l_str, "ddata006: ", l_pack_ddata.ddata006 CLIPPED, "; "
      LET l_str = l_str, "ddata007: ", l_pack_ddata.ddata007 CLIPPED, "; "
      CALL sadzi888_01_log_file_write(l_str)

      #取得該註冊資訊維護作業[資料表代碼]清單
      FOREACH sadzi888_01_dzyb_asc_cs USING l_pack_ddata.ddata005
                                      INTO l_pack_dzyb.dzyb001, l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb005, 
                                           l_pack_dzyb.dzyb006, l_pack_dzyb.dzyb007, l_pack_dzyb.dzyb008, l_pack_dzyb.dzyb009, 
                                           l_pack_dzyb.dzyc002, l_pack_dzyb.dzyc003, l_pack_dzyb.dzyc004, l_pack_dzyb.dzyc005 
         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH delete_data.sadzi888_01_dzyb_asc_cs", l_pack_ddata.ddata005 CLIPPED, ":"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "BREAK_ERROR-FOREACH delete_data.sadzi888_01_dzyb_asc_cs.", l_pack_ddata.ddata005 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            CALL sadzi888_01_log_file_write(g_error_message)
            RETURN FALSE
         END IF

         #判斷是否為刪除資料模式
         IF l_pack_ddata.ddata004 <> "3" THEN
            #dzyc002="2"表示為delete/insert模式
            #依據Key值欄位的輸入值和客製欄位='s'的先刪除設計資料，再將patch的設計資料insert回客戶家
            IF l_pack_dzyb.dzyc002 <> "2" THEN
               CONTINUE FOREACH
            END IF
         END IF

         #[單身子項]項目的過單,遇到[次要資料條件]欄位為null時:表示該資料表內容並不存在[單身子項]的資料
         IF l_pack_ddata.ddata015 = "d" AND cl_null(l_pack_dzyb.dzyb008) THEN
            CONTINUE FOREACH
         END IF
         
         #為merge或insert型式時,先檢查資料匯入檔案是否存在,是否有資料需匯入
         IF l_pack_ddata.ddata004 = "1" OR l_pack_ddata.ddata004 = "2" THEN
            #依export data過程中是否啟動unload to file mode
            IF cl_null(g_unload_file) OR g_unload_file THEN            
               LET l_file = l_pack_ddata.ddata002 USING "<<<<<", "-", l_pack_dzyb.dzyb002 CLIPPED, ".unl"
            
               IF NOT os.Path.EXISTS(l_file) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "adz-00339"
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = l_file.trim()
                  CALL cl_err()
                  LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_file.trim())
                  CALL sadzi888_01_log_file_write(g_error_message)
                  #RETURN FALSE
                  CONTINUE FOREACH
               END IF
            
               #size為0:代表沒資料,不需匯入
               #todo:但是因為4fd設計資料為完整4fd xml內容,所以dzfi_t, dzfj_t, dzfk_t, dzfl_t, dzfb_t需完整刪除
               LET l_size = os.Path.size(l_file)
               IF l_size = 0 AND (NOT (l_pack_dzyb.dzyb002 = "dzfl_t" OR l_pack_dzyb.dzyb002 = "dzam_t")) THEN
                  CONTINUE FOREACH
               END IF
            END IF
         END IF

         CASE l_pack_ddata.ddata005
         
            WHEN "azzi300"
               IF l_pack_dzyb.dzyb003 = "Y" THEN
                  LET l_wc = "  WHERE ", l_pack_dzyb.dzyb004 CLIPPED, " = '", l_pack_ddata.ddata006 CLIPPED, "' "

                  #patch模式時,刪除資料依[patch條件](dzyc004)規則處理
                  IF NOT cl_null(l_pack_dzyb.dzyc004) THEN
                     LET l_sub_sql = cl_replace_str(l_pack_dzyb.dzyc004, "dest.", "") 
                     LET l_sub_sql = cl_replace_str(l_sub_sql, "ds.", "") 
                     LET l_wc = l_wc, " AND ", l_sub_sql.trim()

                     #XG patch規則異動:gzgf004和gzgf005是default的資料才可進行patch異動                                                                                                                                                
                     #(參考2015/1/28 XG上Patch的規則異動mail)                                                                                                                                                                   
                     IF l_pack_dzyb.dzyb002 = "gzgf_t" AND g_patch_mode THEN                                                                                                                                                              
                       　LET l_wc = l_wc, "  AND gzgf004 = 'default' AND gzgf005 = 'default' ",
                       　#2016/03/31      "  AND (gzgf001, gzgf002, gzgf003, gzgf004, gzgf005) ", 
                       　                 "  AND (gzgf001, gzgf003, gzgf004, gzgf005) ", 
                       　#2016/03/31      "   IN (SELECT gzgf001, gzgf002, gzgf003, gzgf004, gzgf005 ",
                       　                 "   IN (SELECT gzgf001, gzgf003, gzgf004, gzgf005 ",
                       　                 "         FROM ", g_patch_schema CLIPPED, ".gzgf_t WHERE gzgf001 = '", l_pack_ddata.ddata006 CLIPPED, "')"
                     END IF     
                  END IF
               ELSE
                  LET l_sub_sql = "SELECT gzgf000 FROM gzgf_t ", 
                                  "  WHERE gzgf001 = '", l_pack_ddata.ddata006 CLIPPED, "' AND gzgf003 <> 'c' "

                   #patch模式下 XG上Patch的規則異動:by 15/01/28 mail
                   IF g_patch_mode THEN
                      LET l_sub_sql = l_sub_sql, "  AND gzgf004 = 'default' AND gzgf005 = 'default' ",
                                    #2016/03/31  "  AND (gzgf001, gzgf002, gzgf003, gzgf004, gzgf005) ", 
                                    #2016/03/31  "   IN (SELECT gzgf001, gzgf002, gzgf003, gzgf004, gzgf005 ",
                                                 "  AND (gzgf001, gzgf003, gzgf004, gzgf005) ", 
                                                 "   IN (SELECT gzgf001, gzgf003, gzgf004, gzgf005 ",
                                                 "         FROM ", g_patch_schema CLIPPED, ".gzgf_t WHERE gzgf001 = '", l_pack_ddata.ddata006 CLIPPED, "')"
                   END IF
                                  
                  LET l_wc = "  WHERE ", l_pack_dzyb.dzyb004 CLIPPED, " IN (", l_sub_sql.trim(), ")"
               END IF
            
            WHEN "azzi301"
               IF l_pack_dzyb.dzyb003 = "Y" THEN
                  LET l_wc = "  WHERE ", l_pack_dzyb.dzyb004 CLIPPED, " = '", l_pack_ddata.ddata006 CLIPPED, "' "

                  #patch模式時,刪除資料依[patch條件](dzyc004)規則處理
                  IF NOT cl_null(l_pack_dzyb.dzyc004) THEN
                     LET l_sub_sql = cl_replace_str(l_pack_dzyb.dzyc004, "dest.", "") 
                     LET l_sub_sql = cl_replace_str(l_sub_sql, "ds.", "") 
                     LET l_wc = l_wc, " AND ", l_sub_sql.trim()
                  END IF
               ELSE
                  LET l_sub_sql = "SELECT gzgd000 FROM gzgd_t ", 
                                  "  WHERE gzgd001 = '", l_pack_ddata.ddata006 CLIPPED, "' AND gzgd003 <> 'c' "
                                  
                  LET l_wc = "  WHERE ", l_pack_dzyb.dzyb004 CLIPPED, " IN (", l_sub_sql.trim(), ")"
               END IF
         
            OTHERWISE
               #檢查是否需要加入第二條件式
               IF (l_pack_ddata.ddata015 = "d") AND (NOT cl_null(l_pack_ddata.ddata007)) AND (NOT cl_null(l_pack_dzyb.dzyb008)) THEN
                  DISPLAY "l_pack_ddata.ddata007 is not null."
                  
                  #這裡表示只需要過單身資料,而dzyb004 = dzyb008代表此table裡主要ID Key值就為adzi888輸入ddata007的key值
                  IF l_pack_dzyb.dzyb004 = l_pack_dzyb.dzyb008 THEN
                     LET l_wc = "  WHERE ", l_pack_dzyb.dzyb008 CLIPPED, " = '", l_pack_ddata.ddata007 CLIPPED, "' "
                  ELSE
                     CALL sadzi888_01_get_ddata007_wc(l_pack_dzyb.dzyb008, l_pack_ddata.ddata007)
                        RETURNING l_success, l_sub_sql
         
                     IF (NOT l_success) THEN
                        RETURN FALSE
                     END IF
                     
                     LET l_wc = "  WHERE ", l_pack_dzyb.dzyb004 CLIPPED, " = '", l_pack_ddata.ddata006 CLIPPED, "' "
                     
                     #加入單身子項條件
                     IF NOT cl_null(l_sub_sql) THEN
                        LET l_wc = l_wc, " AND ", l_sub_sql.trim()
                     END IF
                  END IF
               ELSE
                  LET l_wc = "  WHERE ", l_pack_dzyb.dzyb004 CLIPPED, " = '", l_pack_ddata.ddata006 CLIPPED, "' "
               END IF
               
               #patch模式時,刪除資料依[patch條件](dzyc004)規則處理
               IF NOT cl_null(l_pack_dzyb.dzyc004) THEN
                  #替換"dest."目的地table別名成null
                  LET l_sub_sql = cl_replace_str(l_pack_dzyb.dzyc004, "dest.", "") 
         
                  #替換"ds."目的地table owner別名成null
                  LET l_sub_sql = cl_replace_str(l_sub_sql, "ds.", "") 
                  
                  LET l_wc = l_wc, " AND ", l_sub_sql.trim()
               END IF
         
         END CASE
         
         LET l_sql = "DELETE FROM ", l_pack_dzyb.dzyb002 CLIPPED, " ", l_wc.trim()
         
         LET l_str = l_sql 
         CALL sadzi888_01_log_file_write(l_str)

         PREPARE sadzi888_01_del_data_batch_pre FROM l_sql
         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = 'PREPARE sadzi888_01_del_data_batch_pre:', l_pack_dzyb.dzyb002 CLIPPED
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "ERROR-PREPARE sadzi888_01_del_data_batch_pre.", l_pack_dzyb.dzyb002 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            CALL sadzi888_01_log_file_write(g_error_message)
            RETURN FALSE
         END IF
         
         EXECUTE sadzi888_01_del_data_batch_pre
         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = 'exc sadzi888_01_del_data_batch_pre:', l_pack_dzyb.dzyb002 CLIPPED
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "ERROR-exc sadzi888_01_del_data_batch_pre.", l_pack_dzyb.dzyb002 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            CALL sadzi888_01_log_file_write(g_error_message)
            RETURN FALSE
         END IF 
      END FOREACH
      
      LET l_str = "####################"
      CALL sadzi888_01_log_file_write(l_str)

   END FOREACH

   RETURN TRUE
END FUNCTION

####刪除dspatch中的patch資料
####(若有已被客製的資料先刪除dspatch的資料,這樣在做合併資料時就不會影響到已客製的資料)
###PUBLIC FUNCTION sadzi888_01_delete_dspatch_data(p_table, p_table_temp, p_pack_dzyb)
###   DEFINE p_table           LIKE dzea_t.dzea001     #資料表代碼
###   DEFINE p_table_temp      STRING                  #相對應temp table代碼
###   DEFINE p_pack_dzyb       type_g_dzyb
###
###   DEFINE l_sql             STRING
###   DEFINE l_errcode         STRING
###   DEFINE l_cust_wc         STRING
###
###   #合併資料時排除已客製的資料
###   IF p_pack_dzyb.dzyc002 = "1" OR p_pack_dzyb.dzyc002 = "3" THEN
###      IF NOT cl_null(l_dzyc003) THEN
###         LET l_cust_wc = " WHERE ", l_dzyc003 CLIPPED, " = 'c' "
###      END IF
###
###      #取得資料是否被客製
###      LET l_sql = "SELECT COUNT(*) FROM ", p_pack_dzyb.dzyb002 CLIPPED, " ", l_wc.trim()
###      PREPARE sadzi888_01_sel_data_cnt_pre FROM l_sql
###      EXECUTE sadzi888_01_sel_data_cnt_pre
###      IF SQLCA.sqlcode THEN
###         LET l_errcode = SQLCA.sqlcode
###         INITIALIZE g_errparam TO NULL
###         LET g_errparam.code =  SQLCA.sqlcode
###         LET g_errparam.extend = 'exc sadzi888_01_sel_data_cnt_pre:', p_pack_dzyb.dzyb002 CLIPPED
###         LET g_errparam.popup = TRUE
###         CALL cl_err()
###         LET g_error_message = "ERROR-exc sadzi888_01_sel_data_cnt_pre.", p_pack_dzyb.dzyb002 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
###         CALL sadzi888_01_log_file_write(g_error_message)
###         RETURN FALSE
###      END IF 
###   END IF
###
###   RETURN TRUE
###END FUNCTION

####+ patch[資料]整批匯入前置作業
###PUBLIC FUNCTION sadzi888_01_import_data_batch_pre(p_master001)
###   DEFINE p_master001       LIKE type_t.chr50     #GUID
###   
###   DEFINE l_table_list_json util.JSONObject
###   DEFINE l_success         LIKE type_t.chr1
###   DEFINE l_i               LIKE type_t.num5
###   DEFINE l_table           LIKE dzea_t.dzea001
###   DEFINE l_table_temp      STRING
###   DEFINE l_summary_file    STRING
###   DEFINE l_sql             STRING
###   DEFINE l_errcode         STRING
###   
###   #取得此次patch summary file
###   CALL sadzi888_01_get_summary_file()
###      RETURNING l_success, l_table_list_json
###
###   IF NOT l_success THEN
###      RETURN FALSE
###   END IF
###   
###   BEGIN WORK
###
###   #先進行整批刪除patch要import的資料
###   IF NOT sadzi888_01_delete_data_batch(p_master001) THEN
###      RETURN FALSE
###   END IF
###
###   FOR l_i = 1 TO l_table_list_json.getLength()
###      LET l_table_temp = ""
###      
###      #取得資料表代碼與summary file檔名
###      LET l_table = l_table_list_json.name(l_i)
###      LET l_summary_file = l_table_list_json.get(l_table)
###
###      IF cl_null(l_table) OR cl_null(l_summary_file) THEN
###         INITIALIZE g_errparam TO NULL
###         LET g_errparam.code =  "adz-00385"
###         LET g_errparam.extend = NULL
###         LET g_errparam.popup = TRUE
###         LET g_errparam.replace[1] = l_table CLIPPED, ".", l_summary_file.trim()
###         CALL cl_err()
###         LET g_error_message = "BREAK_ERROR-", cl_getmsg_parm("adz-00385", g_lang, l_table CLIPPED || "." || l_summary_file.trim())
###         ROLLBACK WORK
###         RETURN FALSE
###      END IF
###
###      #整批load data
###      IF NOT sadzi888_01_pack_ins_data(l_summary_file, l_table, "1") THEN
###         ROLLBACK WORK
###         RETURN FALSE
###      END IF
###   END FOR
###   
###   COMMIT WORK
###
###   ####整批處理程式相關檔案產生
###   ###IF NOT sadzi888_01_generator_program_batch(p_master001) THEN
###   ###   DISPLAY "sadzi888_01_generator_program_batch is error."
###   ###END IF
###   
###   RETURN TRUE
###END FUNCTION

#+ 取回此次patch summary file
PUBLIC FUNCTION sadzi888_01_get_summary_file()
   DEFINE l_table_list_json util.JSONObject
   DEFINE l_channel         base.Channel
   DEFINE l_str             STRING
   
   LET l_table_list_json = util.JSONObject.create()

   #取回此次patch summary file總數
   IF NOT os.Path.exists(g_table_list) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00382"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "BREAK_ERROR-", cl_getmsg("adz-00382", g_lang)
      RETURN FALSE, l_table_list_json
   END IF

   LET l_channel = base.Channel.create()
   CALL l_channel.setDelimiter("")
   CALL l_channel.openFile(g_table_list, "r")
   LET l_str = l_channel.readLine()

   IF cl_null(l_str) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00384"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "BREAK_ERROR-", cl_getmsg("adz-00384", g_lang)
      RETURN FALSE, l_table_list_json
   END IF

   LET l_table_list_json = util.JSONObject.parse(l_str)
   IF l_table_list_json.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00384"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "BREAK_ERROR-", cl_getmsg("adz-00384", g_lang)
      RETURN FALSE, l_table_list_json
   END IF
   
   RETURN TRUE, l_table_list_json
END FUNCTION

#+ [patch資料]整批匯入採取MERGE方式的前置作業
PUBLIC FUNCTION sadzi888_01_merge_data_batch_pre(p_master001)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   
   DEFINE l_table_list_json util.JSONObject
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_i               LIKE type_t.num10
   DEFINE l_table           LIKE dzea_t.dzea001
   DEFINE l_table_temp      STRING
   DEFINE l_summary_file    STRING
   DEFINE l_sql             STRING
   DEFINE l_errcode         STRING
   DEFINE l_sys_dzyb002     STRING                #設計資料所在schema
   DEFINE l_dspatch_dzyb002 STRING                #dspatch schema下的資料表代碼,ex:dspatch.imaa_t
   DEFINE l_str             STRING
   DEFINE l_cnt             LIKE type_t.num10
   
   #取得此次patch summary file
   CALL sadzi888_01_get_summary_file()
      RETURNING l_success, l_table_list_json

   IF NOT l_success THEN
      RETURN FALSE
   END IF
   
   #BEGIN WORK
   #2016/02/22 by ka0132
   #進度列控制
   #IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
   #   CALL adzp999_01_refresh_tasks_progressbar(gc_del_data, "adz-00609")
   #END IF

   #先進行整批刪除patch要import的資料
   #IF NOT sadzi888_01_delete_data_batch(p_master001) THEN
   #   RETURN FALSE
   #END IF

   #進度列控制
   #IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
   #   CALL adzp999_01_refresh_tasks_progressbar(gc_merge_data, "adz-00610")
   #END IF

   #LET l_cnt = l_table_list_json.getLength()
   #
   #FOR l_i = 1 TO l_table_list_json.getLength()
   #   LET l_table_temp = ""
   #
   #   #進度列控制
   #   IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
   #      CALL adzp999_01_refresh_sub_tasks_progressbar(l_i, l_cnt)
   #   END IF
   #   
   #   #取得資料表代碼與summary file檔名
   #   LET l_sys_dzyb002 = l_table_list_json.name(l_i)
   #   LET l_dspatch_dzyb002 = l_table_list_json.get(l_sys_dzyb002)
   #
   #   IF cl_null(l_sys_dzyb002) OR cl_null(l_dspatch_dzyb002) THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code =  "adz-00385"
   #      LET g_errparam.extend = NULL
   #      LET g_errparam.popup = TRUE
   #      LET g_errparam.replace[1] = l_sys_dzyb002 CLIPPED, ".", l_dspatch_dzyb002.trim()
   #      CALL cl_err()
   #      LET g_error_message = "BREAK_ERROR-", cl_getmsg_parm("adz-00385", g_lang, l_sys_dzyb002 CLIPPED || "." || l_dspatch_dzyb002 CLIPPED)
   #      ROLLBACK WORK
   #      RETURN FALSE
   #   END IF
   #   
   #   #patch[資料]整批匯入
   #   IF NOT sadzi888_01_merge_data_batch(l_sys_dzyb002, l_dspatch_dzyb002) THEN
   #      ROLLBACK WORK
   #      RETURN FALSE
   #   END IF
   #   
   #END FOR
   #
   #COMMIT WORK
   #
   ##進度列控制
   #IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
   #   CALL adzp999_01_refresh_tasks_progressbar(gc_gen_pattern, "adz-00611")
   #END IF

   #樣板產生
   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     WHERE ddata005 = 'adzi100'

   IF l_cnt > 0 THEN
      LET l_str = "gen adzi100 start:", cl_get_current(), ASCII 10
      CALL sadzi888_01_log_file_write(l_str)

      IF NOT sadzi888_01_gen_file_pre(p_master001, "adzi100") THEN
         RETURN FALSE
      END IF
      LET l_str = "gen adzi100 end:", cl_get_current(), ASCII 10
      CALL sadzi888_01_log_file_write(l_str)
   END IF

   #進度列控制
   #IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
   #   CALL adzp999_01_refresh_tasks_progressbar(gc_gen_base_prog, "adz-00612")
   #END IF

   #整批處理程式相關檔案產生
   #DISPLAY "sadzi888_01.generator_program(TRUE) is start."
   #LET l_str = "generator_program start:", cl_get_current(), ASCII 10
   #CALL sadzi888_01_log_file_write(l_str)

   #先產生adzi210,adzi150,azzi988的東西,否則將影響link
   IF NOT sadzi888_01_generator_program_batch(p_master001, TRUE) THEN
      DISPLAY "sadzi888_01_generator_program_batch is error."
   END IF
      
   LET l_str = "generator_program end:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)
   DISPLAY "sadzi888_01.generator_program(TRUE) is end."

   RETURN TRUE
   #2016/02/22 by ka0132
   
END FUNCTION

#+ patch[資料]整批匯入
PUBLIC FUNCTION sadzi888_01_merge_data_batch(p_table, p_table_temp)
   DEFINE p_table           LIKE dzea_t.dzea001     #資料表代碼
   DEFINE p_table_temp      STRING                  #相對應temp table代碼

   DEFINE l_sql             STRING
   DEFINE l_errcode         STRING
   DEFINE l_schema          LIKE type_t.chr10
   DEFINE l_con_column      DYNAMIC ARRAY OF LIKE type_t.chr20
   DEFINE l_tab_column      DYNAMIC ARRAY OF LIKE type_t.chr20
   DEFINE l_pk_wc           STRING
   DEFINE l_tmp             STRING
   DEFINE l_pk_field        STRING
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_equal           LIKE type_t.chr1
   DEFINE l_update_str      STRING
   DEFINE l_insert_col      STRING
   DEFINE l_insert_value    STRING
   DEFINE l_i               LIKE type_t.num10
   DEFINE l_dest_table      STRING
   DEFINE l_number_equal    LIKE type_t.chr1        #PK欄位數量是否與Table欄位數量相等 
   DEFINE l_field_cnt       LIKE type_t.num5        #欄位數量
   #DEFINE l_dzyb003         LIKE dzyb_t.dzyb003     #主表否
   DEFINE l_dzyc002         LIKE dzyc_t.dzyc002     #patch動作(1.update/insert(merge), 2.delete/insert, 3.insert(update), 4.insert)
   DEFINE l_dzyc003         LIKE dzyc_t.dzyc003     #客製欄位代號
   DEFINE l_dzyc004         LIKE dzyc_t.dzyc004     #patch條件
   DEFINE l_cust_wc         STRING                  #客製欄位條件
   DEFINE l_dzec002         LIKE dzec_t.dzec002     #索引代號
   DEFINE l_dzed004         LIKE dzed_t.dzed004     #鍵值欄位
   DEFINE l_tok             base.StringTokenizer
   DEFINE l_field           STRING
   
   LET l_cust_wc = ""
   LET l_dzec002 = ""
   LET l_dzed004 = ""
   LET l_schema = g_sys_schema
   
   LET l_cnt = 1
   CALL l_con_column.clear()
   
   #gzgd_t(GR報表樣板主檔)不以PK欄位型式進行Merge,因Merge會遇到Unique Index的衝突
   #所以只能用Unique Index的欄位來進行Merge合併設計資料
   IF p_table = "gzgd_t" THEN
      LET l_dzec002 = "gzgd_u"

      SELECT dzec004 INTO l_dzed004 FROM dzec_t 
        WHERE dzec001 = p_table AND dzec002 = l_dzec002 
   ELSE
      SELECT dzed004 INTO l_dzed004 FROM dzed_t 
        WHERE dzed001 = p_table AND dzed003 = 'P' 
   END IF

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "sel dzed004:", p_table CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-sel ", p_table CLIPPED, ".dzed004:", cl_getmsg(l_errcode, g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF

   IF cl_null(l_dzed004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-2270"
      LET g_errparam.extend = "sel dzed004:", p_table CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-sel ", p_table CLIPPED, ".dzed004:", cl_getmsg("-2270", g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF

   #取得PK欄位
   LET l_field = l_dzed004
   IF l_field.getIndexOf(",", 1) > 0 THEN
      LET l_tok = base.StringTokenizer.create(l_field.trim(), ",")
      WHILE l_tok.hasMoreTokens()
         LET l_field = l_tok.nextToken()
         LET l_con_column[l_cnt] = l_field.trim()

         #取得JOIN關聯條件(因為二資料表相同,所以JOIN關係一定是PK欄位)
         LET l_tmp = "sour.", l_con_column[l_cnt] CLIPPED, " = ", "dest.", l_con_column[l_cnt] CLIPPED

         IF cl_null(l_pk_wc) THEN
            LET l_pk_wc = l_tmp
         ELSE
            LET l_pk_wc = l_pk_wc, " AND ", l_tmp
         END IF

         LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_con_column.deleteElement(l_cnt)
   ELSE
      LET l_con_column[l_cnt] = l_field.trim()

      #取得JOIN關聯條件
      LET l_pk_wc = "sour.", l_con_column[l_cnt] CLIPPED, " = ", "dest.", l_con_column[l_cnt] CLIPPED
   END IF
   
   #PK欄位數量是否與Table欄位數量相等
   LET l_number_equal = FALSE

   SELECT COUNT(dzeb002) INTO l_field_cnt FROM dzeb_t
     WHERE dzeb001 = p_table

   IF l_field_cnt = l_con_column.getLength() THEN
      LET l_number_equal = TRUE
   END IF
  
   #取得資料表的所有欄位
   LET l_sql = "SELECT dzeb002 FROM dzeb_t ",
               "  WHERE dzeb001 = ? "
   
   LET l_cnt = 1
   CALL l_tab_column.clear()
   
   DECLARE sadzi888_01_col_cs CURSOR FROM l_sql
   FOREACH sadzi888_01_col_cs USING p_table INTO l_tab_column[l_cnt]
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzi888_01_col_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-FOREACH sadzi888_01_col_cs:", cl_getmsg(l_errcode, g_lang)
         CALL sadzi888_01_log_file_write(g_error_message)
         RETURN FALSE
      END IF

      #update 時需剔除PK欄位
      LET l_equal = FALSE
      FOR l_i = 1 TO l_con_column.getLength()
         #todo:gzgd013 for 報表暫時不需update
         #todo:150911 mail提出:報表上patch時不更新報表執行逾期時間欄位(gzgf011,gzgd011)
         IF l_tab_column[l_cnt] = l_con_column[l_i] OR l_tab_column[l_cnt] = "gzgd013" OR 
            l_tab_column[l_cnt] = "gzgf011" OR l_tab_column[l_cnt] = "gzgd011" THEN
            
            LET l_equal = TRUE
            EXIT FOR
         END IF
      END FOR

      IF (NOT l_equal) OR (l_number_equal) THEN
         #####取得UPDATE 子句#####
         LET l_tmp = "dest.", l_tab_column[l_cnt] CLIPPED, " = ", "sour.", l_tab_column[l_cnt] CLIPPED
      
         IF cl_null(l_update_str) THEN
            LET l_update_str = l_tmp
         ELSE
            LET l_update_str = l_update_str, ", ", l_tmp
         END IF
      END IF
      
      #####取得INSERT 欄位#####
      LET l_tmp = "dest.", l_tab_column[l_cnt] CLIPPED
      
      IF cl_null(l_insert_col) THEN
         LET l_insert_col = l_tmp
      ELSE
         LET l_insert_col = l_insert_col, ", ", l_tmp
      END IF

      #####取得INSERT 欄位值#####
      LET l_tmp = "sour.", l_tab_column[l_cnt] CLIPPED
   
      IF cl_null(l_insert_value) THEN
         LET l_insert_value = l_tmp
      ELSE
         LET l_insert_value = l_insert_value, ", ", l_tmp
      END IF
      
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_tab_column.deleteElement(l_cnt)

   #加入客製條件,在合併資料時排除已客製的資料
   #取得資料表關於patch的相關設定
   SELECT DISTINCT dzyc002, dzyc003, dzyc004 INTO l_dzyc002, l_dzyc003, l_dzyc004 FROM dzyc_t
     WHERE dzyc001 = p_table

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "sel dzyc004:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-sel dzyc004:", cl_getmsg(l_errcode, g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF

   IF NOT cl_null(l_dzyc004) THEN
      LET l_cust_wc = l_dzyc004
   ELSE
      LET l_cust_wc = ""
   END IF
   
   IF NOT cl_null(l_cust_wc) THEN
      LET l_update_str = l_update_str, " WHERE ", l_cust_wc.trim()
   END IF
   
   #組合merge語句
   LET l_dest_table = g_sys_schema CLIPPED, ".", p_table CLIPPED

   #insert狀態時:patch的設計資料不存在客戶家時採純insert作法，不作任何資料的Update．
   IF l_dzyc002 = "4" OR p_table = "gzhc_t" THEN
      LET l_sql = "MERGE INTO ", l_dest_table.trim(), " dest ",
                  "  USING ", p_table_temp.trim(), " sour ",
                  "    ON (", l_pk_wc.trim(), ")",
                  "  WHEN NOT MATCHED ",
                  "    THEN ",
                  "      INSERT (", l_insert_col.trim(), ")",
                  "        VALUES (", l_insert_value.trim(), ")"
   ELSE
      LET l_sql = "MERGE INTO ", l_dest_table.trim(), " dest ",
                  "  USING ", p_table_temp.trim(), " sour ",
                  "    ON (", l_pk_wc.trim(), ")",
                  "  WHEN MATCHED ",
                  "    THEN ",
                  "      UPDATE SET ", l_update_str.trim(),
                  "  WHEN NOT MATCHED ",
                  "    THEN ",
                  "      INSERT (", l_insert_col.trim(), ")",
                  "        VALUES (", l_insert_value.trim(), ")"
   END IF
   
   DISPLAY "merge sql:", l_sql 
   CALL sadzi888_01_log_file_write(l_sql)
   PREPARE sadzi888_01_merge_pre FROM l_sql
   EXECUTE sadzi888_01_merge_pre
   
   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE sadzi888_01_merge_pre:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-EXECUTE sadzi888_01_merge_pre:", cl_getmsg(l_errcode, g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      FREE sadzi888_01_merge_pre
      RETURN FALSE
   END IF

   FREE sadzi888_01_merge_pre

   RETURN TRUE
END FUNCTION

#+ 整批處理程式相關檔案產生
PUBLIC FUNCTION sadzi888_01_generator_program_batch(p_master001, p_prg_batch_pre)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_prg_batch_pre   LIKE type_t.chr1      #patch完資料產生作業順序(TRUE:倒完資料後順便產生; FASLE:產生完程式後才跟著產生)
   
   DEFINE l_pack_ddata      type_g_ddata_d
   DEFINE l_errcode         STRING
   DEFINE l_str             STRING
   DEFINE l_msg             STRING
   DEFINE l_prog_num        LIKE type_t.num10
   DEFINE l_prog_cnt        LIKE type_t.num10
   DEFINE l_bgjob           LIKE type_t.chr1
   
   LET l_prog_num = 0
   
   #因產生程序動作需有語系資料
   IF NOT sadzi888_01_get_gzzy001() THEN
      RETURN FALSE
   END IF

   SELECT COUNT(*) INTO l_prog_cnt FROM adzi888_ddata
     WHERE ddata001 = p_master001
       AND (ddata004 = '1' OR ddata004 = '2')

   #找出所有需匯入處理的註冊資訊清單
   FOREACH sadzi888_01_ddata_imp_cs USING p_master001
                                    INTO l_pack_ddata.ddata002, l_pack_ddata.ddata003, l_pack_ddata.ddata004, l_pack_ddata.ddata005, l_pack_ddata.ddata006,  
                                         l_pack_ddata.ddata007, l_pack_ddata.ddata008, l_pack_ddata.ddata009, l_pack_ddata.ddata010, l_pack_ddata.ddata015
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH batch.sadzi888_01_ddata_imp_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "BREAK_ERROR-FOREACH batch.sadzi888_01_ddata_imp_cs:", cl_getmsg(l_errcode, g_lang)
         CALL sadzi888_01_log_file_write(g_error_message)
         RETURN FALSE
      END IF

      
      #進度列控制
      LET l_prog_num = l_prog_num + 1
      IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
         CALL adzp999_01_refresh_sub_tasks_progressbar(l_prog_num, l_prog_cnt)
      END IF
      
      #todo:目前倒完資料後必須先產生adzi210, adzi150, azzi988的東西,否則將影響link
      IF p_prg_batch_pre THEN
         IF g_gen_prog_pre.getIndexOf(l_pack_ddata.ddata005, 1) = 0 THEN
            CONTINUE FOREACH
         END IF
      ELSE
         IF g_gen_prog_pre.getIndexOf(l_pack_ddata.ddata005, 1) > 0 THEN
            CONTINUE FOREACH
         END IF
      END IF
      
      #依據各註冊資料性質,呼叫產生程序(如:azzi902需產生str, 42s檔案)
      IF l_pack_ddata.ddata004 = "1" OR l_pack_ddata.ddata004 = "2" THEN
         LET l_str = ASCII 10, "####################", ASCII 10
         LET l_str = l_str, "ddata002: ", l_pack_ddata.ddata002 USING "<<<<<", "; "
         LET l_str = l_str, "ddata005: '", l_pack_ddata.ddata005 CLIPPED, "'; "
         LET l_str = l_str, "ddata006: '", l_pack_ddata.ddata006 CLIPPED, "'; "
         CALL sadzi888_01_log_file_write(l_str)
      
         #防止command run切換路徑,所需把路徑切回目前工作路徑
         LET l_str = os.Path.pwd()

         #進入此段時,指定全背景作業,不主動跳窗
         LET l_bgjob = g_bgjob
         LET g_bgjob = "Y" 
   
         IF NOT sadzi888_01_generator_program(l_pack_ddata.ddata005, l_pack_ddata.ddata006, l_pack_ddata.ddata007, l_pack_ddata.ddata015) THEN
            LET l_msg = "ERROR:sadzi888_01_generator_program( ", l_pack_ddata.ddata005, ", ", l_pack_ddata.ddata006, ")"
            DISPLAY l_msg
            CALL sadzi888_01_log_file_write(l_msg)
            LET g_bgjob = l_bgjob
            
            #非patch模式下,任何的產生錯誤都視為失敗
            IF (NOT cl_null(g_patch_mode)) AND (NOT g_patch_mode) THEN
               LET g_error_message = "BREAK_ERROR:sadzi888_01_generator_program( ", l_pack_ddata.ddata005, ", ", l_pack_ddata.ddata006, ")"
               #2016/11/10
               DISPLAY g_error_message
               #2016/11/10
               RETURN FALSE
            END IF
         END IF

         LET g_bgjob = l_bgjob
         CALL sadzi888_01_log_file_write("####################")
         
         #把路徑切回打包的工作路徑
         IF NOT os.Path.chdir(l_str) THEN
            LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_str.trim())
            RETURN FALSE
         END IF
      END IF
   END FOREACH
   
   RETURN TRUE
END FUNCTION

#+ 處理程式相關檔案產生
PUBLIC FUNCTION sadzi888_01_generator_program(p_ddata005, p_ddata006, p_ddata007, p_ddata015)
   DEFINE p_ddata005        LIKE type_t.chr20       #註冊資訊維護作業代碼(ex:azzi900)
   DEFINE p_ddata006        LIKE type_t.chr50       #條件式1
   DEFINE p_ddata007        LIKE type_t.chr50
   DEFINE p_ddata015        LIKE type_t.chr1
   
   DEFINE l_cmd             STRING
   DEFINE l_i               LIKE type_t.num10
   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_dzfq005         LIKE dzfq_t.dzfq005     #主/子程式
   DEFINE l_gzza003         LIKE gzza_t.gzza003     #模組代碼
   DEFINE l_str             STRING
   DEFINE l_sql             STRING
   DEFINE l_errcode         STRING
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_dzdz002         LIKE dzdz_t.dzdz002     #版本
   DEFINE l_time_s          DATETIME YEAR TO SECOND 
   DEFINE l_time_e          DATETIME YEAR TO SECOND
   DEFINE l_inc_file        STRING
   #2016/07/07
   DEFINE l_module          LIKE type_t.chr10 
   DEFINE l_ver             LIKE type_t.num10 
   DEFINE li_cnt            LIKE type_t.num10 
   DEFINE la_cmdrun         RECORD
          prog              STRING,
          actionid          STRING,
          background        LIKE type_t.chr1,
          param             DYNAMIC ARRAY OF STRING
          END RECORD
   #2016/07/07
   DEFINE ls_gzzi002        LIKE gzzi_t.gzzi002 #2016/08/29
   
   CALL FGL_SETENV("T100RUNWAIT", "1")

   LET l_time_s = cl_get_current()
   
   CASE 
      WHEN p_ddata005 = "azzi030"
         LET l_str = "s_azzi030_createxcf_sys()"
         CALL sadzi888_01_log_file_write(l_str)
         CALL s_azzi030_createxcf_sys()

      WHEN p_ddata005 = "azzi900"
        
      WHEN (p_ddata005 = "azzi902" OR p_ddata005 = "azzi912")
         #patch模式,先預設不做42s的產生
         IF g_patch_mode AND (NOT g_gen42s_flag) THEN
            EXIT CASE
         END IF
         
         #2016/09/12
         IF g_run_mode = '2' THEN
            #過單解包特別處理
            LET l_cmd = "r.r azzp191 ",p_ddata006," zh_TW,zh_CN tiptop '' "
            CALL g_write.write(l_cmd)
         ELSE
            #產生畫面42s語系檔案
            FOR l_i = 1 TO g_gzzy001.getLength()
               LET l_cmd = "r.r azzp191 ", p_ddata006 CLIPPED, " ", g_gzzy001[l_i] CLIPPED, " >/dev/null 2>&1"
               CALL sadzi888_01_log_file_write(l_cmd)
               RUN l_cmd WITHOUT WAITING
               
               IF STATUS THEN
                  LET l_str = "Warning-", l_cmd.trim(), ":", cl_getmsg(STATUS, g_lang)
                  CALL sadzi888_01_log_file_write(l_str)
               END IF
            END FOR
         END IF

         #產生所有用到子畫面的作業42s檔
         #取得畫面所屬類別(S:子程式畫面, F:子畫面)才需要做
         LET l_dzfq005 = sadzp060_2_chk_spec_type(p_ddata006)
         IF l_dzfq005 = "S" OR l_dzfq005 = "F" THEN
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
              WHERE ddata005 = 'design_data' AND ddata006 = p_ddata006

            IF l_cnt = 0 THEN
               #LET l_cmd = "r.f ", p_ddata006 CLIPPED, " &"
               
               IF g_run_mode = '2' THEN
                  #過單解包特別處理
                  LET l_cmd = "r.f ",p_ddata006
                  CALL g_write.write(l_cmd)
               ELSE
                  LET l_cmd = "r.f ", p_ddata006 CLIPPED, " >/dev/null 2>&1"
                  CALL sadzi888_01_log_file_write(l_cmd)
                  RUN l_cmd WITHOUT WAITING
                  
                  IF STATUS THEN
                     LET l_str = "Warning-", l_cmd.trim(), ":", cl_getmsg(STATUS, g_lang)
                     CALL sadzi888_01_log_file_write(l_str)
                  END IF
               END IF
            END IF
         END IF
         #2016/09/12
   
   
      WHEN p_ddata005 = "azzi903"
         #patch模式,先預設不做4ad和4tm的產生
         IF g_patch_mode AND (NOT g_gen42s_flag) THEN
            EXIT CASE
         END IF
         
         #產生4ad檔案
         LET l_cmd = "r.r azzp195 ", p_ddata006 CLIPPED   #, " 4ad"
         CALL sadzi888_01_log_file_write(l_cmd)
         IF NOT sadzi888_01_run_command(l_cmd) THEN
            RETURN FALSE
         END IF
         
         FOR l_i = 1 TO g_gzzy001.getLength()
            #產生4ad語系檔案
            LET l_cmd = "r.r azzp193 ", p_ddata006 CLIPPED, " 4ad ", g_gzzy001[l_i] CLIPPED, " &"
            CALL sadzi888_01_log_file_write(l_cmd)
            RUN l_cmd WITHOUT WAITING
            
            IF STATUS THEN
               LET l_str = "Warning-", l_cmd.trim(), ":", cl_getmsg(STATUS, g_lang)
               CALL sadzi888_01_log_file_write(l_str)
            END IF

            #產生4tm語系檔案
            LET l_cmd = "r.r azzp193 ", p_ddata006 CLIPPED, " 4tm ", g_gzzy001[l_i] CLIPPED, " &"
            CALL sadzi888_01_log_file_write(l_cmd)
            RUN l_cmd WITHOUT WAITING
            
            IF STATUS THEN
               LET l_str = "Warning-", l_cmd.trim(), ":", cl_getmsg(STATUS, g_lang)
               CALL sadzi888_01_log_file_write(l_str)
            END IF
         END FOR
         
      WHEN p_ddata005 = "azzi910"
         LET l_str = "s_azzi030_createxcf_app(", p_ddata006 CLIPPED, ", FALSE)"
         CALL sadzi888_01_log_file_write(l_str)
         CALL s_azzi030_createxcf_app(p_ddata006 CLIPPED, FALSE)

         #加入程式執行權限
         #2016/11/10
         #LET l_cmd = "r.r azzp185 'admin-01' ", p_ddata006 CLIPPED
         IF g_roles.getIndexOf(',',1) THEN
            DISPLAY 'INFO:g_roles有多個,僅處理第一筆!'
            LET l_cmd = "r.r azzp185 '",
                        g_roles.subString(1,g_roles.getIndexOf(',',1)-1),
                        "' ", p_ddata006 CLIPPED
         ELSE
            IF cl_null(g_roles) THEN
               LET li_cnt = 0
               SELECT COUNT(*) INTO li_cnt
                 FROM gzya_t 
                WHERE gzyaent = g_enterprise
                  AND gzya001 = 'admin-01'
               IF li_cnt > 0 THEN
                  LET l_cmd = "r.r azzp185 'admin-01' ", p_ddata006 CLIPPED
               ELSE
                  LET l_cmd = "r.r azzp185 'admin' ", p_ddata006 CLIPPED
               END IF            
            ELSE 
               DISPLAY 'INFO:g_roles僅一筆!'
               LET l_cmd = "r.r azzp185 '",g_roles,"' ", p_ddata006 CLIPPED
            END IF
         END IF
         DISPLAY l_cmd
         #2016/11/10
         CALL sadzi888_01_log_file_write(l_cmd)
         IF NOT sadzi888_01_run_command(l_cmd) THEN
            RETURN FALSE
         END IF

      WHEN p_ddata005 = "azzi991"
         LET l_str = "s_azzi991_carry(2, ", p_ddata006 CLIPPED, ")"
         CALL sadzi888_01_log_file_write(l_str)
         IF NOT s_azzi991_carry("2", p_ddata006 CLIPPED) THEN
            RETURN FALSE
         END IF

      WHEN p_ddata005 = "azzi993"
         LET l_dzfq005 = sadzp060_2_chk_spec_type(p_ddata006) 
         CALL sadzp062_1_find_module(p_ddata006, l_dzfq005) 
            RETURNING l_gzza003

         IF cl_null(l_gzza003) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00012"
            LET g_errparam.extend = "sadzi888_01_generator_program"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "ERROR-sadzi888_01_generator_program():", cl_getmsg_parm("adz-00012", g_lang, p_ddata006 CLIPPED)
            CALL sadzi888_01_log_file_write(g_error_message)
            RETURN FALSE
         END IF

         #產生參數作業
         LET  l_cmd = "gens ", l_gzza003 CLIPPED, " ", p_ddata006 CLIPPED
         CALL sadzi888_01_log_file_write(l_cmd)
         IF NOT sadzi888_01_run_command(l_cmd) THEN
            RETURN FALSE
         END IF
      
      WHEN p_ddata005 = "azzi070"
         #todo:看起來動作不少,應該要有一個function直接適用於過單
         
      WHEN p_ddata005 = "adzi210"
        #Begin: 160223-00028 註解段落
        #SELECT COUNT(*) INTO l_cnt FROM dzca_t
        #  WHERE dzca001 = p_ddata006

        #IF l_cnt = 0 THEN
        #   LET l_str = "ERROR:dzca001 = ", p_ddata006 CLIPPED, " is null."
        #   CALL sadzi888_01_log_file_write(l_str)
        #   RETURN TRUE
        #END IF
        #
        #LET l_str = "sadzp210_generate_qry(", p_ddata006 CLIPPED, ")"
        #CALL sadzi888_01_log_file_write(l_str)
        #IF NOT sadzp210_generate_qry(p_ddata006 CLIPPED) THEN
        #   RETURN FALSE
        #END IF
        #End: 160223-00028 註解段落

      WHEN p_ddata005 = "adzi150"
         #產生多語言 4gl 檔
         IF sadzi140_exim_get_table_type(p_ddata006) = "L" THEN
            LET l_str = "sadzi140_util_gen_multi_lang(", p_ddata006 CLIPPED, ")"
            CALL sadzi888_01_log_file_write(l_str)
            
            CALL sadzi140_util_gen_multi_lang(p_ddata006)
         END IF
      
      WHEN p_ddata005 = "azzi988"
         #產生報表4gl切片檔案
         LET l_str = "sadzi888_05_gen_include(", p_ddata006 CLIPPED, ")"
         CALL sadzi888_01_log_file_write(l_str)
         
         IF NOT sadzi888_05_gen_include(p_ddata006) THEN
            LET l_str = "sadzi888_05_gen_include(", p_ddata006 CLIPPED, ") is error." 
         ELSE
            LET l_str = "sadzi888_05_gen_include(", p_ddata006 CLIPPED, ") is success."
         END IF
         CALL sadzi888_01_log_file_write(l_str)

      WHEN p_ddata005 = "azzi908"
         #產生inc共用變數設定檔
         LET l_str = "s_azzi908_gen_inc_file(", p_ddata006 CLIPPED, ")"
         CALL sadzi888_01_log_file_write(l_str)
         
         CALL s_azzi908_gen_inc_file(p_ddata006) 
            RETURNING l_success, l_inc_file

         IF NOT l_success THEN
            LET l_str = "s_azzi908_gen_inc_file(", p_ddata006 CLIPPED, ") is error.", l_inc_file.trim() 
            RETURN FALSE
         ELSE
            LET l_str = "s_azzi908_gen_inc_file(", p_ddata006 CLIPPED, ") is success."
         END IF
         CALL sadzi888_01_log_file_write(l_str)

      WHEN p_ddata005 = "adzi100"
         #取得樣板及版本基本資料
         LET l_str = "sadzi100_extract(", p_ddata006 CLIPPED, ")"
         CALL sadzi888_01_log_file_write(l_str)

         LET l_sql = "SELECT dzdz002 FROM dzdz_t ", 
                     "  WHERE dzdz001 = ? "

         #判斷是否需要加入單身條件
         IF p_ddata015 = "d" AND (NOT cl_null(p_ddata007)) THEN
            LET l_sql = l_sql, " AND dzdz002 = ", p_ddata007 CLIPPED
         END IF
         
         DECLARE sadzi888_01_dzdz_cs CURSOR FROM l_sql

         FOREACH sadzi888_01_dzdz_cs USING p_ddata006 INTO l_dzdz002
            IF SQLCA.sqlcode THEN
               LET l_errcode = SQLCA.sqlcode
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH sadzi888_01_dzdz_cs:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_error_message = "BREAK_ERROR-FOREACH sadzi888_01_dzdz_cs:", cl_getmsg(l_errcode, g_lang)
               CALL sadzi888_01_log_file_write(g_error_message)
               RETURN FALSE
            END IF
      
            #產生各類程式樣板檔案
            CALL sadzi100_extract(p_ddata006 CLIPPED, l_dzdz002, "1")
        
        END FOREACH
      
      #2016/07/07
      WHEN p_ddata005 = "azzi051"
         #加入行業別邏輯段落
         LET li_cnt = 0
         LET l_str = "azzi051(", p_ddata006 CLIPPED, ") export."
         
         #檢查azzi900/azzi901是否存在
         SELECT COUNT(*) INTO li_cnt 
           FROM gzza_t 
          WHERE gzza001 = p_ddata006
         IF li_cnt > 0 THEN 
            SELECT gzza003 INTO l_module 
              FROM gzza_t
             WHERE gzza001 = p_ddata006
         END IF
         
         IF cl_null(l_module) THEN
            SELECT COUNT(*) INTO li_cnt 
              FROM gzde_t 
             WHERE gzde001 = p_ddata006
            IF li_cnt > 0 THEN 
               SELECT gzde005 INTO l_module 
                 FROM gzde_t
                WHERE gzde001 = p_ddata006
            END IF
         END IF
         
         #抓版次
         #LET l_ver = 0
         
         IF cl_null(l_module) THEN
            #抓不到模組,無設定
            LET l_str = "azzi051(", p_ddata006 CLIPPED, ") is not success."
            CALL sadzi888_01_log_file_write(g_showmsg)
            RETURN FALSE
         ELSE
            #執行adzp180重組/編譯
            LET l_cmd = "r.c3 ",p_ddata006," '' A 2"
            CALL sadzi888_01_log_file_write(l_cmd)
            IF NOT sadzi888_01_run_command(l_cmd) THEN
               RETURN FALSE
            END IF
            
         END IF
         
      WHEN p_ddata005 = "azzp660"
         LET la_cmdrun.prog = "azzp662"
         LET la_cmdrun.background = "Y"
         LET l_cmd = util.JSON.stringify(la_cmdrun)
         CALL sadzi888_01_log_file_write(l_cmd)
         CALL cl_cmdrun_wait(l_cmd)
         LET l_str = "azzp660(", p_ddata006 CLIPPED, ") is success."
         DISPLAY l_str
         CALL sadzi888_01_log_file_write(l_str)
      #2016/07/07
      
      #2016/08/29
      WHEN p_ddata005 = "azzi911"
         LET ls_gzzi002 = NULL
         SELECT gzzi002 
           INTO ls_gzzi002
           FROM gzzi_t
          WHERE gzzi001 = p_ddata006
         IF SQLCA.sqlcode OR ls_gzzi002 IS NULL THEN
            LET l_str = "azzi911(", p_ddata006 CLIPPED, ") is error(", SQLCA.sqlcode ,")."
            DISPLAY l_str
            CALL sadzi888_01_log_file_write(l_str)
            RETURN FALSE
         ELSE
            LET l_str = "azzi911(", p_ddata006 CLIPPED, ") is success."
            DISPLAY l_str
            CALL sadzi888_01_log_file_write(l_str)
            CALL azzi911_01_export_42m(p_ddata006,ls_gzzi002,'2') 
         END IF
      #2016/08/29
         
   END CASE

   #記錄data load耗費時間
   LET l_time_e = cl_get_current()
   LET l_str = "    Cost time : ", l_time_e - l_time_s
   CALL sadzi888_01_log_file_write(l_str)
         
   RETURN TRUE
END FUNCTION

#+ 註冊資訊[檔案]匯入
PUBLIC FUNCTION sadzi888_01_import_file(p_master001, p_master013, p_master014, p_pack_dir, p_folder)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   DEFINE p_pack_dir        STRING                #打包檔置放路徑
   DEFINE p_folder          STRING                #匯出檔所在目錄
   
   DEFINE l_dfile           type_g_dfile_d
   DEFINE l_cmd             STRING
   DEFINE l_source          STRING
   DEFINE l_dest            STRING
   DEFINE l_tar_name        STRING
   DEFINE l_dfile007        LIKE type_t.chr1   #匯入狀態(0:建立; 1:成功; 2:失敗) 
   DEFINE l_errcode         STRING             #錯誤代碼
   DEFINE l_dfile003_str    STRING
   DEFINE l_str             STRING
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_num             LIKE type_t.num10
   DEFINE li_cnt            LIKE type_t.num10  #2016/04/22 by ka0132
    DEFINE l_dest_unique     STRING            #2016/04/22 by ka0132
   
   LET l_cnt = 0
   LET l_num = 1
   
   SELECT COUNT(*) INTO l_cnt FROM adzi888_dfile
   
   #找出[檔案匯出清單]
   FOREACH sadzi888_01_dfile_cs USING p_master001
                                INTO l_dfile.dfile002, l_dfile.dfile003, l_dfile.dfile004, l_dfile.dfile005, l_dfile.dfile006, 
                                     l_dfile.dfile007
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzi888_01_dfile_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "BREAK_ERROR-FOREACH sadzi888_01_dfile_cs:", cl_getmsg(l_errcode, g_lang)
         CALL sadzi888_01_log_file_write(g_error_message)
         RETURN FALSE
      END IF
      
      ####不再重做已[匯入成功]清單
      ###IF l_dfile.dfile007 = "1" THEN
      ###   CONTINUE FOREACH
      ###END IF
      
      DISPLAY "dfile002:", l_dfile.dfile002 USING "<<<<<", "---dfile005:", l_dfile.dfile005 CLIPPED, "     (", l_num USING "<<<<<", "/", l_cnt USING "<<<<<", ")"
      
      #進度列控制
      IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
         CALL adzp999_01_refresh_sub_tasks_progressbar(l_num, l_cnt)
      END IF

      LET l_str = ASCII 10, "####################", ASCII 10
      LET l_str = l_str, "dfile002: ", l_dfile.dfile002 USING "<<<<<", " ; "
      LET l_str = l_str, "dfile003: ", l_dfile.dfile003 CLIPPED, " ; "
      LET l_str = l_str, "dfile005: ", l_dfile.dfile005 CLIPPED, " ; "
      CALL sadzi888_01_log_file_write(l_str)

      LET l_num = l_num + 1
      
      #檢查路徑是否存在
      LET l_dfile003_str = sadzp007_util_get_path(l_dfile.dfile003 CLIPPED)  #160223-00028     
      IF NOT os.Path.EXISTS(l_dfile003_str) THEN
         LET l_cmd = "mkdir -p ", l_dfile003_str.trim()
         CALL sadzi888_01_log_file_write(l_cmd)
         RUN l_cmd
         
         IF STATUS THEN
            LET g_error_message = "ERROR-mkdir -p ", l_dfile003_str.trim(), ":", cl_getmsg(STATUS, g_lang)
            CALL sadzi888_01_log_file_write(g_error_message)
            CONTINUE FOREACH
         END IF
      END IF

      #檔案類型為[f:檔案],cp f# {路徑}/{檔名} 
      #檔案類型為[d:整個目錄結構],tar xvf $FOLDER/d# {檔名}
      CASE l_dfile.dfile004 CLIPPED
         WHEN "f"
            #2016/02/15 by ka0132 -Begin-
            #2016/04/22 by ka0132 -Begin-
            SELECT COUNT(*) INTO li_cnt FROM adzi888_dfile
             WHERE dfile005 = l_dfile.dfile005
            IF li_cnt > 1 THEN
               LET l_dest_unique = l_dfile.dfile002 USING "&&&&&&&&&&", "-", l_dfile.dfile005 CLIPPED
               LET l_source = os.Path.join(os.Path.join(p_pack_dir, p_folder), l_dest_unique)
               LET l_dest = os.Path.join(l_dfile.dfile003 CLIPPED, l_dfile.dfile005 CLIPPED)
               LET l_cmd = "cp ", l_source.trim(), " ", l_dest.trim()
            ELSE
               #2016/04/22 by ka0132 -End-
               #2016/02/15 by ka0132 -End-
               LET l_source = os.Path.join(os.Path.join(p_pack_dir, p_folder), l_dfile.dfile005 CLIPPED)
               LET l_dest = os.Path.join(l_dfile.dfile003 CLIPPED, l_dfile.dfile005 CLIPPED)
               LET l_cmd = "cp ", l_source.trim(), " ", l_dest.trim()
            END IF #2016/04/22
         WHEN "d"
            #2016/02/15 by ka0132 -Begin-
            #2016/04/22 by ka0132 -Begin-
            SELECT COUNT(*) INTO li_cnt FROM adzi888_dfile
             WHERE dfile005 = l_dfile.dfile005
            IF li_cnt > 1 THEN
               #解包tar檔
               LET l_tar_name = l_dfile.dfile002 USING "&&&&&&&&&&", "-", l_dfile.dfile005 CLIPPED, ".tgz"
               LET l_source = os.Path.join(os.Path.join(p_pack_dir, p_folder), l_tar_name)
               LET l_dest = l_dfile.dfile005 CLIPPED
               #2016/02/15 by ka0132
               #IF l_dest.getIndexOf('azzi933_help',1) THEN #2016/04/22
               #   LET l_dest = l_dest.subString(20,l_dest.getLength()) #2016/04/22
               #END IF  #2016/04/22
               
               LET l_cmd = "cd ", l_dfile.dfile003 CLIPPED, ";"
               LET l_cmd = l_cmd, "tar zxvf ", l_source.trim(), " ", l_dest.trim()
            ELSE
               #2016/04/22 by ka0132 -End-
               #2016/02/15 by ka0132 -End-
               LET l_tar_name = l_dfile.dfile005 CLIPPED, ".tgz"
               LET l_source = os.Path.join(os.Path.join(p_pack_dir, p_folder), l_tar_name)
               LET l_dest = l_dfile.dfile005 CLIPPED
               #IF l_dest.getIndexOf('azzi933_help',1) THEN #2016/04/22
               #   LET l_dest = l_dest.subString(20,l_dest.getLength()) #2016/04/22
               #END IF #2016/04/22
               
               LET l_cmd = "cd ", l_dfile.dfile003 CLIPPED, ";"
               LET l_cmd = l_cmd, "tar zxvf ", l_source.trim(), " ", l_dest.trim()
            END IF
      END CASE

      #複製檔案
      LET l_dfile007 = "2"

      DISPLAY "l_cmd:", l_cmd, ";"
      CALL sadzi888_01_log_file_write(l_cmd)
         
      IF NOT os.Path.EXISTS(l_source) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00339"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_source.trim()
         CALL cl_err()
         LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_source.trim())
         CALL sadzi888_01_log_file_write(g_error_message)
         CONTINUE FOREACH
      ELSE
         RUN l_cmd

         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00338"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] =  l_source.trim()
            CALL cl_err()
            LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00338", g_lang, l_source.trim())
            CALL sadzi888_01_log_file_write(g_error_message)
            CONTINUE FOREACH
         END IF
         
         LET l_dfile007 = "1"
      END IF
    
      #更新匯入狀態
      UPDATE adzi888_dfile SET dfile007 = l_dfile007
        WHERE dfile001 = p_master001 
          AND dfile002 = l_dfile.dfile002
 
      #串接ALM環境時,更新需求單狀態
      IF g_top_alm = "Y" AND (NOT (cl_null(p_master013) AND cl_null(p_master014))) THEN
         #同步回ALM需求單
         UPDATE dzlf_t SET dzlf007 = l_dfile007    
           WHERE dzlf002 = l_dfile.dfile002
             AND dzlf008 = p_master013 
             AND dzlf009 = g_dzld012
             AND dzlf010 = g_dzld013
             AND dzlf011 = p_master014 
      END IF

      LET l_str = "####################"
      CALL sadzi888_01_log_file_write(l_str)
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 取得完整路徑(轉換環境變數設置)
PUBLIC FUNCTION sadzi888_01_get_path(p_path)
   DEFINE p_path            STRING             #檔案路徑
   DEFINE l_idx_start       LIKE type_t.num5
   DEFINE l_idx_end         LIKE type_t.num5
   DEFINE l_var             STRING
   DEFINE l_str             STRING
   DEFINE l_length          LIKE type_t.num5
   
   #環境變數應該都用"$"字元起頭
   LET l_idx_start = p_path.getIndexOf("$", 1)
   LET l_length = p_path.getLength()

   IF l_idx_start > 0 THEN
      #取得環境變數完整名稱
      LET l_idx_end = p_path.getIndexOf("/", l_idx_start)

      IF l_idx_end > 0 THEN
         LET l_var = p_path.subString(l_idx_start + 1, l_idx_end - 1)
         LET l_str = FGL_GETENV(l_var)

         #取替代字串
         LET l_var = "$", l_var.trim()
         LET p_path = cl_replace_str(p_path, l_var, l_str)

         LET p_path = sadzp007_util_get_path(p_path) #160223-00028
      ELSE
         LET l_var = p_path.subString(l_idx_start + 1, l_length)
         LET l_str = FGL_GETENV(l_var)

         #取替代字串
         LET l_var = "$", l_var.trim()
         LET p_path = cl_replace_str(p_path, l_var, l_str)
         RETURN p_path
      END IF
   END IF

   RETURN p_path
END FUNCTION

#+ 取得匯出檔目錄名稱
PUBLIC FUNCTION sadzi888_01_get_folder_name(p_master002, p_master003)
   DEFINE p_master002       LIKE type_t.chr50     #匯出主題
   DEFINE p_master003       LIKE type_t.chr10     #匯出人員

   DEFINE l_folder          STRING
   
   IF NOT cl_null(p_master003) THEN
      LET l_folder = p_master003 CLIPPED, "-", p_master002 CLIPPED
   ELSE
      LET l_folder = p_master002 CLIPPED
   END IF

   RETURN l_folder
END FUNCTION

#+ 執行指令
PUBLIC FUNCTION sadzi888_01_run_command(p_cmd)
   DEFINE p_cmd             STRING                #要執行的指令

   DEFINE ls_str            STRING
   DEFINE l_msg             STRING                #編譯後訊息
   DEFINE l_read            base.Channel
   DEFINE l_result          LIKE type_t.chr1      #編譯成功或失敗
   DEFINE l_errcode         STRING
   DEFINE l_errmsg          STRING
#  #Begin: debug
#  DEFINE li_i              LIKE type_t.num5
#  DEFINE ls_log            STRING
#  DEFINE l_time_t          DATETIME YEAR TO SECOND                                                         
#  DEFINE l_time_s          DATETIME YEAR TO SECOND                                                         
#  DEFINE l_time_e          DATETIME YEAR TO SECOND 
#  DEFINE l_time_r          INTERVAL DAY  TO SECOND 

#  LET l_time_s = cl_get_current()
#  LET ls_log = "ls_log:",l_time_s," ","start"
#  CALL sadzi888_01_log_file_write(ls_log)
#  DISPLAY ls_log
#  #End: debug

   LET l_errmsg = ""
   LET ls_str = "run command:", p_cmd.trim()

#  #debug
#  DISPLAY "ls_log:",ls_str

   IF ls_str.getIndexOf(g_patch_pwd, 1) > 0 THEN
      LET ls_str = cl_replace_str(ls_str, g_patch_pwd, "xxxx")
   END IF

   CALL sadzi888_01_log_file_write(ls_str)

   IF cl_null(p_cmd) THEN
      LET ls_str = "Warn:command is null." 
      CALL sadzi888_01_log_file_write(ls_str)
      RETURN FALSE
   END IF
   
   #執行指令
   LET l_result = "Y"
   LET ls_str = ""
   LET l_msg = ""
   #CALL cl_cmdrun_openpipe(p_cmd, p_cmd, FALSE)
   #  RETURNING l_result, ls_str

   LET l_read = base.Channel.create()
   CALL l_read.setDelimiter("")

   LET p_cmd = p_cmd CLIPPED, " 2>&1 "

#  #Begin :debug
#  LET l_time_t = cl_get_current()
#  LET ls_log = "ls_log:",l_time_t," ","before openPipe"
#  CALL sadzi888_01_log_file_write(ls_log)
#  DISPLAY ls_log
#  #End :debug

   CALL l_read.openPipe(p_cmd, "r")   #執行指令
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "run command:", p_cmd.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "run command-", p_cmd.trim(), ":", cl_getmsg(l_errcode, g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF

#  #Begin :debug
#  LET l_time_t = cl_get_current()
#  LET ls_log = "ls_log:",l_time_t," ","after openPipe"
#  CALL sadzi888_01_log_file_write(ls_log)
#  DISPLAY ls_log
#  LET li_i=0
#  #End :debug

   WHILE TRUE
      LET ls_str = l_read.readLine()

#     #Begin :debug
#     LET li_i = li_i+1
#     IF li_i < 3 THEN
#        LET l_time_t = cl_get_current()
#        LET ls_log = "ls_log:",l_time_t," ","readLine",li_i
#        CALL sadzi888_01_log_file_write(ls_log)
#        DISPLAY ls_log
#     END IF
#     #End :debug

      IF l_read.isEof() THEN 
         EXIT WHILE 
      END IF
      LET l_msg = l_msg, ls_str, ASCII 10
      LET ls_str = ls_str.toUpperCase()

      IF p_cmd MATCHES "imp dspatch*" THEN
         DISPLAY ls_str
      END IF
      
      #遇到編譯錯誤訊息時,結束整個作業
      IF ls_str.getIndexOf("ERROR", 1) > 0 OR ls_str.getIndexOf("CP: CANNOT" , 1) > 0 OR
         ls_str.getIndexOf("ORA-", 1) > 0 OR ls_str.getIndexOf("IMP-00015" , 1) > 0 THEN #OR ls_str.getIndexOf("EXP-" , 1) > 0 OR ls_str.getIndexOf("INVALID", 1) > 0  
         LET l_result = "N" 
         LET l_errmsg = l_errmsg, ls_str, ASCII 10
      END IF
   END WHILE
   CALL l_read.close()
   
   DISPLAY l_msg
   
   IF l_result = "N" THEN
      #show出最後編譯結果,提供使用者判斷是否整個過程都成功
      #todo:這邊show msg的做法可提供show出整個編譯錯誤的訊息
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00368"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_cmd.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00368", g_lang, p_cmd.trim())
      CALL sadzi888_01_log_file_write(g_error_message)
      CALL sadzi888_01_log_file_write("    err:" || l_errmsg)
      CALL sadzi888_01_log_file_write("    run msg:" || l_msg)
      RETURN FALSE
   END IF

   CALL sadzi888_01_log_file_write(l_msg)
   CALL sadzi888_01_log_file_write(p_cmd || " is success.")
#  #Begin: debug
#  LET l_time_e = cl_get_current()
#  LET l_time_r = l_time_e - l_time_s
#  LET ls_log= "ls_log:","used time: ",l_time_r," (",l_time_s," ",l_time_e,")"
#  CALL sadzi888_01_log_file_write(ls_log)
#  DISPLAY ls_log
#  #End: debug
   CALL sadzi888_01_log_file_write("----------------------------------------")
   
   RETURN TRUE
END FUNCTION

#+ 執行指令
PUBLIC FUNCTION sadzi888_01_get_command_msg(p_cmd)
   DEFINE p_cmd             STRING                #要執行的指令

   DEFINE ls_str            STRING
   DEFINE l_msg             util.JSONObject       #編譯後訊息
   DEFINE l_read            base.Channel
   DEFINE l_i               LIKE type_t.num10

   LET l_msg = util.JSONObject.create()
   LET l_i = 1

   LET l_read = base.Channel.create()
   CALL l_read.setDelimiter("")

   LET p_cmd = p_cmd CLIPPED, " 2>&1"

   CALL l_read.openPipe(p_cmd, "r")   #執行指令

   WHILE TRUE
      LET ls_str = l_read.readLine()
      IF l_read.isEof() THEN 
         EXIT WHILE 
      END IF

      CALL l_msg.put(l_i, ls_str)
      LET l_i = l_i + 1
   END WHILE
   CALL l_read.close()
   
   RETURN l_msg.toString()
END FUNCTION

PUBLIC FUNCTION sadzi888_01_log_file_start(p_type, p_master002)
   DEFINE p_type            LIKE type_t.chr1      #運行模式(1:過單打包; 2:過單解包; 3:patch打包; 4:patch解包; 5:需求單打包; 6:需求單解包)
   DEFINE p_master002       LIKE type_t.chr50     #匯出主題 
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   
   DEFINE l_channel         base.Channel
   DEFINE l_mode            STRING
   DEFINE l_file            STRING
   DEFINE l_str             STRING

   IF g_run_mode = "4" OR g_run_mode = "3" THEN
      IF NOT cl_null(p_master002) THEN
         LET l_file = "patch-", p_master002 CLIPPED, "-", TODAY USING 'YYYYMMDD', ".log"
      ELSE
         LET l_file = "patch-", TODAY USING 'YYYYMMDD', ".log"
      END IF
      
      LET l_mode = "w"
   ELSE
      LET l_file = "adzi888-", p_master002 CLIPPED, ".log"
      LET l_mode = "w"
   END IF
   
   LET l_file = os.Path.join(FGL_GETENV("TEMPDIR"), l_file) 
   LET l_channel = base.Channel.create()
   CALL l_channel.openFile(l_file, l_mode)

   IF STATUS = 0 THEN
      CALL l_channel.setDelimiter("")
      LET l_str = "#--------------------------- (", cl_get_current(), ") ------------------------#"
      CALL l_channel.write(l_str)

      LET l_str = "master002: ", p_master002 CLIPPED, " begin at ", cl_get_current()
      CALL l_channel.write(l_str)
      CALL l_channel.write("")

      LET g_write_log = TRUE
      LET g_log_file = l_file
      LET g_channel = l_channel
   ELSE
      DISPLAY "Can't open log file."
      LET g_write_log = FALSE
   END IF
   
END FUNCTION

PUBLIC FUNCTION sadzi888_01_log_file_write(p_str)
   DEFINE p_str             STRING

   IF p_str.getIndexOf(g_exp_para, 1) > 0 THEN
      LET p_str = cl_replace_str(p_str, g_exp_para, "xxxx")
   END IF
   
   IF g_write_log THEN
      CALL g_channel.write(p_str)
      #CALL g_channel.write("")
   END IF
END FUNCTION

PUBLIC FUNCTION sadzi888_01_log_file_end()
   DEFINE l_cmd             STRING
   DEFINE l_str             STRING
   
   IF g_write_log THEN
      LET l_str = " end at ", cl_get_current()     #CURRENT HOUR TO FRACTION(3)
      CALL g_channel.write(l_str)

      CALL g_channel.write("#------------------------------------------------------------------------------#")
      CALL g_channel.write("")
      CALL g_channel.close()

      IF NOT cl_null(g_log_file) THEN
         LET l_cmd = "chmod 666 ", g_log_file CLIPPED, " >/dev/null 2>/dev/null"
         RUN l_cmd
      END IF
   END IF
END FUNCTION

#+ 取得條件式二的where條件
PUBLIC FUNCTION sadzi888_01_get_ddata007_wc(p_dzyb008, p_ddata007)
   DEFINE p_dzyb008         STRING                   #次要資料條件欄位
   DEFINE p_ddata007        STRING                   #條件式2
   
   DEFINE l_tok             base.StringTokenizer
   DEFINE l_str             STRING
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_dzyb008_wc      DYNAMIC ARRAY OF STRING   #欄位
   DEFINE l_ddata007_wc     DYNAMIC ARRAY OF STRING   #條件值
   DEFINE l_wc              STRING
   
   #拆解資料條件欄位
   LET l_cnt = 1
   IF p_dzyb008.getIndexOf("|", 1) > 0 THEN
      LET l_tok = base.StringTokenizer.create(p_dzyb008.trim(), "|")
      WHILE l_tok.hasMoreTokens()
         LET l_str = l_tok.nextToken()
         LET l_dzyb008_wc[l_cnt] = l_str.trim()

         LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_dzyb008_wc.deleteElement(l_cnt)
   ELSE
      LET l_dzyb008_wc[l_cnt] = p_dzyb008.trim()
   END IF

   #拆解條件值欄位
   LET l_cnt = 1
   IF p_ddata007.getIndexOf("|", 1) > 0 THEN
      LET l_tok = base.StringTokenizer.create(p_ddata007.trim(), "|")
      WHILE l_tok.hasMoreTokens()
         LET l_str = l_tok.nextToken()
         LET l_ddata007_wc[l_cnt] = l_str.trim()

         LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_ddata007_wc.deleteElement(l_cnt)
   ELSE
      LET l_ddata007_wc[l_cnt] = p_ddata007.trim()
   END IF

   LET l_wc = ""
   IF l_dzyb008_wc.getLength() <> l_ddata007_wc.getLength() THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00375"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_ddata007.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00375", g_lang, p_ddata007.trim())
      RETURN FALSE, l_wc
   END IF

   FOR l_i = 1 TO l_dzyb008_wc.getLength()
      IF cl_null(l_wc) THEN
         LET l_wc = l_dzyb008_wc[l_i].trim(), " = '", l_ddata007_wc[l_i].trim(), "'"
      ELSE
         LET l_wc = l_wc, " AND ", l_dzyb008_wc[l_i].trim(), " = '", l_ddata007_wc[l_i].trim(), "'"
      END IF
   END FOR

   IF cl_null(l_wc) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00376"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_ddata007.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00376", g_lang, p_ddata007.trim())
      RETURN FALSE, l_wc
   END IF
   
   RETURN TRUE, l_wc
END FUNCTION

#+ 因為azzi903裡的gzzq_t的ACTION多語言有大部份都屬於gzzq001='standard',所以需要獨立LOAD data
PRIVATE FUNCTION sadzi888_01_merge_table_data(p_table, p_file)
   DEFINE p_table           STRING
   DEFINE p_file            STRING
   
   DEFINE l_sql             STRING
   DEFINE l_str             STRING
   DEFINE l_table_temp      STRING

   IF (NOT os.Path.EXISTS(p_file)) OR (os.Path.size(p_file) = 0) THEN
      LET l_str = "Warning:", cl_getmsg_parm("adz-00339", g_lang, p_file.trim())
      CALL sadzi888_01_log_file_write(l_str)
      RETURN
   END IF
   
   LET l_table_temp = "tmp_", p_table CLIPPED
   LET l_sql = "SELECT * INTO TEMP ", l_table_temp.trim(), 
               "  FROM ", "(SELECT * FROM ", p_table CLIPPED, " WHERE 1 = 2)"
   
   DISPLAY "create temp table sql:", l_sql
   PREPARE sadzi888_01_merge_create_pre FROM l_sql
   EXECUTE sadzi888_01_merge_create_pre

   IF SQLCA.sqlcode THEN
      LET l_str = "Warning-PREPARE sadzi888_01_merge_create_pre.", p_table CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      CALL sadzi888_01_log_file_write(l_str)
      RETURN
   END IF
   
   LET l_sql = "INSERT INTO ", l_table_temp.trim()
   
   DISPLAY "load sql:", l_sql
   LOAD FROM p_file l_sql
   
   IF STATUS THEN
      LET l_str = "Warning-LOAD FROM ", p_file.trim(), ":", cl_getmsg(STATUS, g_lang)
      CALL sadzi888_01_log_file_write(l_str)
      RETURN
   END IF

   #資料整批匯入
   IF NOT sadzi888_01_merge_data_batch(p_table, l_table_temp) THEN
      RETURN
   END IF

   #drop temp table
   IF l_table_temp.getIndexOf("tmp_", 1) > 0 AND l_table_temp.getIndexOf("_t", 1) > 0 THEN
      LET l_sql = "DROP TABLE ", l_table_temp.trim()
      DISPLAY "drop temp table:", l_sql
      PREPARE sadzi888_01_merge_drop_pre FROM l_sql
      EXECUTE sadzi888_01_merge_drop_pre
   
      IF SQLCA.sqlcode THEN
         LET l_str = "Warning-PREPARE sadzi888_01_merge_drop_pre.", l_table_temp.trim(), ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         CALL sadzi888_01_log_file_write(l_str)
         RETURN
      END IF
   END IF
   
   FREE sadzi888_01_merge_create_pre 
END FUNCTION

#+ 因為azzi330裡的gzgj_t,gzgjl_t,gzgk_t就是過'YY'的資料gzgl_t就是全過,所以需要獨立LOAD data
PRIVATE FUNCTION sadzi888_01_azzi330_detail_data(p_mode)
   DEFINE p_mode            STRING   #export或import模式("exp" or "imp")
          
   DEFINE l_file            STRING
   DEFINE l_str             STRING
   DEFINE l_errcode         STRING
   DEFINE l_sql             STRING
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_table           DYNAMIC ARRAY OF RECORD
             dzea001          LIKE dzea_t.dzea001,     #資料表代碼
             wc               STRING                   #where條件
                            END RECORD

   LET l_table[1].dzea001 = "gzgj_t"
   LET l_table[2].dzea001 = "gzgjl_t"
   LET l_table[3].dzea001 = "gzgk_t"
   LET l_table[4].dzea001 = "gzgl_t"

   LET l_table[1].wc = " gzgj001='YY' OR gzgj001= 'ZZ' "
   LET l_table[2].wc = " gzgjl001='YY' OR gzgjl001= 'ZZ' "
   LET l_table[3].wc = " gzgk001='YY' OR gzgk001= 'ZZ' "
   LET l_table[4].wc = " 1=1 "

   BEGIN WORK
   
   FOR l_i = 1 TO l_table.getLength()
      LET l_file = "azzi330_", l_table[l_i].dzea001 CLIPPED, ".unl"
      
      CASE p_mode
         WHEN "exp"
            LET l_sql = "SELECT * FROM ", l_table[l_i].dzea001 CLIPPED,
                        "  WHERE ", l_table[l_i].wc.trim()

            LET l_str = "UNLOAD TO ", l_file, " ", l_sql
            CALL sadzi888_01_log_file_write(l_sql)
         
            UNLOAD TO l_file l_sql
            
            IF STATUS THEN
               LET l_errcode = STATUS
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_str = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
               CALL sadzi888_01_log_file_write(l_str)
               DISPLAY l_str
               ROLLBACK WORK
               RETURN FALSE
            END IF

         WHEN "imp"            
            LET l_str = "import ", l_table[l_i].dzea001 CLIPPED, " start:", cl_get_current(), ASCII 10
            CALL sadzi888_01_log_file_write(l_str)

            IF NOT os.Path.EXISTS(l_file) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00339"
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] =  l_file.trim()
               CALL cl_err()
               LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_file.trim())
               CALL sadzi888_01_log_file_write(g_error_message)
               ROLLBACK WORK
               RETURN FALSE
            END IF

            IF os.Path.size(l_file) = 0 THEN  
               LET l_str = l_file.trim(), " is null. end:", cl_get_current(), ASCII 10
               CALL sadzi888_01_log_file_write(l_str)
               CONTINUE FOR
            END IF

            #azzi330相關報表表頭單身資料採2.先Delete後Insert方式
            LET l_sql = "DELETE FROM ", l_table[l_i].dzea001 CLIPPED, " WHERE ", l_table[l_i].wc.trim()

            CALL sadzi888_01_log_file_write(l_sql)

            PREPARE sadzi888_01_azzi330_del_data_pre FROM l_sql
            IF SQLCA.sqlcode THEN
               LET l_errcode = SQLCA.sqlcode
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  SQLCA.sqlcode
               LET g_errparam.extend = 'PREPARE sadzi888_01_azzi330_del_data_pre:', l_table[l_i].dzea001 CLIPPED
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_error_message = "ERROR-PREPARE sadzi888_01_azzi330_del_data_pre.", l_table[l_i].dzea001 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
               CALL sadzi888_01_log_file_write(g_error_message)
               ROLLBACK WORK
               RETURN FALSE
            END IF
            
            EXECUTE sadzi888_01_azzi330_del_data_pre
            IF SQLCA.sqlcode THEN
               LET l_errcode = SQLCA.sqlcode
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  SQLCA.sqlcode
               LET g_errparam.extend = 'exc sadzi888_01_azzi330_del_data_pre:', l_table[l_i].dzea001 CLIPPED
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_error_message = "ERROR-exc sadzi888_01_azzi330_del_data_pre.", l_table[l_i].dzea001 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
               CALL sadzi888_01_log_file_write(g_error_message)
               ROLLBACK WORK
               RETURN FALSE
            END IF 

            #將資料Load回資料表
            IF NOT sadzi888_01_pack_ins_data(l_file, l_table[l_i].dzea001, "1") THEN
               ROLLBACK WORK
               RETURN FALSE
            END IF
   
            LET l_str = "import ", l_table[l_i].dzea001 CLIPPED, " end:", cl_get_current(), ASCII 10
            CALL sadzi888_01_log_file_write(l_str)

      END CASE
   END FOR

   COMMIT WORK
   
   RETURN TRUE
END FUNCTION

#+ 註冊資訊[資料]匯出
PUBLIC FUNCTION sadzi888_01_export_data_dmp(p_master001, p_master013, p_master014)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   
   DEFINE l_file            STRING
   DEFINE l_parfile         STRING
   DEFINE l_sql             STRING
   DEFINE l_pack_ddata      type_g_ddata_d
   DEFINE l_ddata008        LIKE type_t.chr1      #匯出狀態(0:建立; 1:成功; 2:失敗)
   DEFINE l_pack_dzyb       type_g_dzyb
   DEFINE l_errcode         STRING
   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_wc              STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_summary_file    STRING                #資料表資料的匯總檔
   DEFINE l_middle_file     STRING                #資料表資料的中介檔
   DEFINE l_table_list_json util.JSONObject
   DEFINE l_channel         base.Channel
   DEFINE l_str             STRING
   DEFINE l_size            LIKE type_t.num10
   DEFINE l_sys_dzyb002     STRING                #設計資料所在schema
   DEFINE l_dspatch_dzyb002 STRING                #dspatch schema下的資料表代碼,ex:dspatch.imaa_t
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_dzeb004         LIKE dzeb_t.dzeb004   #primary key
   DEFINE l_cmd             STRING
   DEFINE l_row_cnt         LIKE type_t.num10
   
   LET l_table_list_json = util.JSONObject.create()
   
   LET l_str = "export data start:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)

   IF cl_null(g_exp_para) THEN
      LET l_str = "BREAK_ERROR:g_exp_para is null."
      CALL sadzi888_01_log_file_write(l_str)
      RETURN FALSE
   END IF
   
   #找出[匯入動作為1:Merge or 2:Insert]的註冊資訊
   FOREACH sadzi888_01_ddata_exp_cs USING p_master001
                                    INTO l_pack_ddata.ddata002, l_pack_ddata.ddata003, l_pack_ddata.ddata004, l_pack_ddata.ddata005, l_pack_ddata.ddata006,  
                                         l_pack_ddata.ddata007, l_pack_ddata.ddata008, l_pack_ddata.ddata009, l_pack_ddata.ddata010, l_pack_ddata.ddata015
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzi888_01_ddata_exp_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-FOREACH sadzi888_01_ddata_exp_cs:", cl_getmsg(l_errcode, g_lang)
         RETURN FALSE
      END IF

      LET l_str = ASCII 10, "####################", ASCII 10
      LET l_str = l_str, "ddata002: ", l_pack_ddata.ddata002 USING "<<<<<", "; "
      LET l_str = l_str, "ddata003: '", l_pack_ddata.ddata003 CLIPPED, "'; "
      LET l_str = l_str, "ddata005: '", l_pack_ddata.ddata005 CLIPPED, "'; "
      LET l_str = l_str, "ddata006: '", l_pack_ddata.ddata006 CLIPPED, "'; "
      LET l_str = l_str, "ddata007: '", l_pack_ddata.ddata007 CLIPPED, "'; "
      CALL sadzi888_01_log_file_write(l_str)
      
      LET l_ddata008 = "1"
      LET l_sub_sql = ""

      #取得該註冊資訊維護作業[資料表代碼]清單
      FOREACH sadzi888_01_dzyb_desc_cs USING l_pack_ddata.ddata005
                                       INTO l_pack_dzyb.dzyb001, l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb005, 
                                            l_pack_dzyb.dzyb006, l_pack_dzyb.dzyb007, l_pack_dzyb.dzyb008, l_pack_dzyb.dzyb009, 
                                            l_pack_dzyb.dzyc002, l_pack_dzyb.dzyc003, l_pack_dzyb.dzyc004, l_pack_dzyb.dzyc005 
         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH sadzi888_01_dzyb_desc_cs:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "ERROR-FOREACH sadzi888_01_dzyb_desc_cs:", cl_getmsg(l_errcode, g_lang)
            LET l_ddata008 = "2"
            EXIT FOREACH
         END IF

         #資料dmp檔名稱
         LET l_file = l_pack_ddata.ddata002 USING "<<<<<", "-", l_pack_dzyb.dzyb002 CLIPPED, ".dmp"
         
         #dmp檔所需parfile,主要記錄where條件式(如:QUERY="WHERE dzfk001 = 'apmt500'")
         LET l_parfile = l_pack_ddata.ddata002 USING "<<<<<", "-", l_pack_dzyb.dzyb002 CLIPPED, ".dat"

         #[單身子項]項目的過單,遇到[次要資料條件]欄位為null時:表示該資料表內容並不存在[單身子項]的資料
         IF l_pack_ddata.ddata015 = "d" AND cl_null(l_pack_dzyb.dzyb008) THEN
            CONTINUE FOREACH
         END IF

         #取得資料過濾條件
         CALL sadzi888_01_get_export_wc(l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb008, l_pack_ddata.ddata005, l_pack_ddata.ddata006, l_pack_ddata.ddata007, l_pack_ddata.ddata015)
            RETURNING l_success, l_wc

         IF (NOT l_success) OR cl_null(l_wc) THEN
            IF cl_null(g_error_message) THEN
               LET g_error_message = "sadzi888_01_get_export_wc is error."
            END IF
            
            RETURN FALSE
         END IF

         #標準環境下gzgm_t需另外只過gzgm003='YY' OR gzgm003= 'ZZ'
         IF g_alm_jb = g_dgenv_s AND l_pack_dzyb.dzyb002 = "gzgm_t" THEN
            LET l_wc = l_wc, " AND (gzgm003 = 'YY' OR gzgm003 = 'ZZ')"  
         END IF
         
         #2016/09/20
         #dzbd額外條件
         #IF l_pack_dzyb.dzyb002 = 'dzbd_t' AND g_run_mode = 1 THEN
         #   #DISPLAY l_wc,  
         #   #    " AND dzbd001 IN (SELECT UNIQUE(dzbc001) FROM dzbc_t WHERE dzbc005='m' AND dzbc001 = '",l_pack_ddata.ddata006,"')"
         #   LET l_wc = l_wc,  
         #       " AND dzbd001 IN (SELECT UNIQUE(dzbc001) FROM dzbc_t WHERE dzbc005='m' AND dzbc001 = '",l_pack_ddata.ddata006,"')"
         #END IF
         #2016/09/20

         #取得資料筆數
         LET l_row_cnt = 0
         LET l_sql = "SELECT COUNT(*) FROM ", l_pack_dzyb.dzyb002 CLIPPED, " ", l_wc
         PREPARE sadzi888_01_dzyb002_cnt_pre FROM l_sql

         EXECUTE sadzi888_01_dzyb002_cnt_pre INTO l_row_cnt
         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "exc sadzi888_01_dzyb002_cnt_pre.", l_pack_dzyb.dzyb002 CLIPPED
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "ERROR-exc sadzi888_01_dzyb002_cnt_pre.", l_pack_dzyb.dzyb002 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            CALL sadzi888_01_log_file_write(g_error_message)
            RETURN FALSE
         END IF
         
         #todo:檢查一下主要資料表是否有Data被UNLOAD下來(防止在adzi888 key錯)
         IF l_pack_dzyb.dzyb003 = "Y" AND l_row_cnt = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00386"
            LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_pack_ddata.ddata005 CLIPPED
            LET g_errparam.replace[2] = l_pack_ddata.ddata006 CLIPPED
            CALL cl_err()
            LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg_parm("adz-00386", g_lang, l_pack_ddata.ddata005 || "|" || l_pack_ddata.ddata006)
            RETURN FALSE
         END IF

         #export設計資料
         LET l_str = "UNLOAD TO ", l_file, "    ", l_wc
         DISPLAY "TEST:",l_str 
         CALL sadzi888_01_log_file_write(l_str)
         
         LET l_channel = base.Channel.create()
         CALL l_channel.openFile(l_parfile, "w")

         IF STATUS THEN
            LET l_errcode = STATUS
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  STATUS
            LET g_errparam.extend = "openFile:", l_parfile.trim()
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "ERROR-openFile ", l_parfile.trim(), ":", cl_getmsg(l_errcode, g_lang)
            LET l_ddata008 = "2"
            EXIT FOREACH
         END IF

         CALL l_channel.setDelimiter("")

         #寫入exp 所需的parfile
         #指定dmp的table
         LET l_str = "TABLES=", l_pack_dzyb.dzyb002 CLIPPED
         CALL l_channel.write(l_str)

         #指定table的資料條件
         LET l_str = 'QUERY="', l_wc.trim(), '"'
         CALL l_channel.write(l_str)
         CALL l_channel.close()

         #exp data指令
         LET l_cmd = "exp ", g_sys_schema CLIPPED, "/", g_exp_para.trim(), " FILE=", l_file.trim(), " LOG=", l_file.trim(), ".explog PARFILE=", l_parfile.trim()
         CALL sadzi888_01_log_file_write(l_cmd)
         
         IF NOT sadzi888_01_run_command(l_cmd) THEN
            RETURN FALSE
         END IF

         #記錄目前需要import資料的表格代碼
         IF NOT l_table_list_json.has(l_file) THEN
            #dmp檔名,資料筆數
            CALL l_table_list_json.put(l_file.trim(), l_row_cnt)
         END IF

         #因為azzi993參數資料可一個參數編號對應不同的參數作業
         #為了因應可依過單資料條件來先行[刪除參數資料],這樣才可以直接利用imp dmp檔完整將參數資料匯入
         #因此匯出時需利用UNLOAD語法匯出unl檔
         IF (l_pack_dzyb.dzyb002 = "gzsz_t" OR l_pack_dzyb.dzyb002 = "gzszl_t") AND l_pack_ddata.ddata005 = "azzi993" THEN
            LET l_file = l_pack_ddata.ddata002 USING "<<<<<", "-", l_pack_dzyb.dzyb002 CLIPPED, ".unl"
            LET l_sql = "SELECT * FROM ", l_pack_dzyb.dzyb002 CLIPPED, " ", l_wc

            IF NOT sadzi888_01_unload_data(l_file, l_sql) THEN
               RETURN FALSE
            END IF
         END IF
      END FOREACH

      #更新匯出狀態
      UPDATE adzi888_ddata SET ddata008 = l_ddata008
        WHERE ddata001 = p_master001
          AND ddata002 = l_pack_ddata.ddata002

      #串接ALM環境時,更新需求單狀態
      IF g_top_alm = "Y" AND (NOT (cl_null(p_master013) AND cl_null(p_master014))) THEN
         #同步回ALM需求單
         UPDATE dzld_t SET dzld008 = l_ddata008
           WHERE dzld002 = l_pack_ddata.ddata002
             AND dzld011 = p_master013
             AND dzld012 = g_dzld012
             AND dzld013 = g_dzld013
             AND dzld014 = p_master014
      END IF
   END FOREACH

   #因為azzi903裡的gzzq_t的ACTION多語言有大部份都屬於gzzq001='standard',所以需要獨立UNLOAD data
   #因此這部份資料需要額外處理
   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     WHERE ddata005 = 'azzi903'

   IF l_cnt > 0 THEN
      CALL sadzi888_01_unload_gzzq001_standard_data()
   END IF

   #取得azzi330報表表頭相關單身設定資料(因此這部份資料條件較特殊所以額外處理)
   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     WHERE ddata005 = 'azzi330'

   IF l_cnt > 0 THEN
      #匯出azzi330相關資料
      IF NOT sadzi888_01_azzi330_detail_data("exp") THEN
         RETURN FALSE
      END IF
   END IF
   
   LET l_str = "table list:", l_table_list_json.toString()
   DISPLAY l_str
   CALL sadzi888_01_log_file_write(l_str)

   #將summary file寫入xml file
   IF NOT cl_null(l_table_list_json.toString()) THEN
      LET l_channel = base.Channel.create()
      CALL l_channel.openFile(g_table_list, "w")
      CALL l_channel.setDelimiter("")

      LET l_str = l_table_list_json.toString()
      CALL l_channel.write(l_str)

      IF NOT os.Path.exists(g_table_list) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00382"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "BREAK_ERROR-", cl_getmsg("adz-00382", g_lang)
         RETURN FALSE
      END IF

      LET l_str = "chmod 666 ", g_table_list CLIPPED, " >/dev/null 2>/dev/null"
      RUN l_str
   END IF
   
   LET l_str = "export data end:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)
   
   RETURN TRUE
END FUNCTION

#+ 註冊資訊[資料]匯入
PUBLIC FUNCTION sadzi888_01_import_data_dmp(p_master001, p_master013, p_master014)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   
   DEFINE l_pack_ddata      type_g_ddata_d
   DEFINE l_ddata009        LIKE type_t.chr1            #匯入狀態(0:建立; 1:成功; 2:失敗)
   DEFINE l_pack_dzyb       type_g_dzyb
   DEFINE l_str             STRING
   DEFINE l_errcode         STRING
   DEFINE l_file            STRING
   DEFINE l_row_cnt         LIKE type_t.num10
   DEFINE l_table_list_json util.JSONObject
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_time_s          DATETIME YEAR TO SECOND 
   DEFINE l_time_e          DATETIME YEAR TO SECOND
   DEFINE l_bgjob           LIKE type_t.chr1

   IF cl_null(g_exp_para) THEN
      LET l_str = "BREAK_ERROR:g_exp_para is null."
      CALL sadzi888_01_log_file_write(l_str)
      RETURN FALSE
   END IF
   
   #取得此次patch summary file
   CALL sadzi888_01_get_summary_file()
      RETURNING l_success, l_table_list_json

   #因為有可能只過table
   #IF NOT l_success THEN
   #   RETURN FALSE
   #END IF
   
   #因產生程序動作需有語系資料
   IF NOT sadzi888_01_get_gzzy001() THEN
      RETURN FALSE
   END IF
   
   #找出所有需匯入處理的註冊資訊清單
   FOREACH sadzi888_01_ddata_imp_cs USING p_master001
                                    INTO l_pack_ddata.ddata002, l_pack_ddata.ddata003, l_pack_ddata.ddata004, l_pack_ddata.ddata005, l_pack_ddata.ddata006,  
                                         l_pack_ddata.ddata007, l_pack_ddata.ddata008, l_pack_ddata.ddata009, l_pack_ddata.ddata010, l_pack_ddata.ddata015
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzi888_01_ddata_imp_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "BREAK_ERROR-FOREACH sadzi888_01_ddata_imp_cs:", cl_getmsg(l_errcode, g_lang)
         CALL sadzi888_01_log_file_write(g_error_message)
         RETURN FALSE
      END IF

      DISPLAY "ddata002:", l_pack_ddata.ddata002 USING "<<<<<", "---ddata005:", l_pack_ddata.ddata005 CLIPPED
      
      LET l_str = ASCII 10, "####################", ASCII 10
      LET l_str = l_str, "ddata002: ", l_pack_ddata.ddata002 USING "<<<<<", "; "
      LET l_str = l_str, "ddata003: '", l_pack_ddata.ddata003 CLIPPED, "'; "
      LET l_str = l_str, "ddata005: '", l_pack_ddata.ddata005 CLIPPED, "'; "
      LET l_str = l_str, "ddata006: '", l_pack_ddata.ddata006 CLIPPED, "'; "
      LET l_str = l_str, "ddata007: '", l_pack_ddata.ddata007 CLIPPED, "'; "
      CALL sadzi888_01_log_file_write(l_str)

      #BEGIN WORK
      LET l_ddata009 = "1"

      #取得該註冊資訊維護作業[資料表代碼]清單
      FOREACH sadzi888_01_dzyb_asc_cs USING l_pack_ddata.ddata005
                                      INTO l_pack_dzyb.dzyb001, l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb005, 
                                           l_pack_dzyb.dzyb006, l_pack_dzyb.dzyb007, l_pack_dzyb.dzyb008, l_pack_dzyb.dzyb009, 
                                           l_pack_dzyb.dzyc002, l_pack_dzyb.dzyc003, l_pack_dzyb.dzyc004, l_pack_dzyb.dzyc005 
         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH sadzi888_01_dzyb_asc_cs", l_pack_ddata.ddata005 CLIPPED, ":"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "BREAK_ERROR-FOREACH sadzi888_01_dzyb_asc_cs:", cl_getmsg(l_errcode, g_lang)
            CALL sadzi888_01_log_file_write(g_error_message)
            LET l_ddata009 = "2"
            EXIT FOREACH
         END IF

         #[單身子項]項目的過單,遇到[次要資料條件]欄位為null時:表示該資料表內容並不存在[單身子項]的資料
         IF l_pack_ddata.ddata015 = "d" AND cl_null(l_pack_dzyb.dzyb008) THEN
            CONTINUE FOREACH
         END IF
         
         #為merge或insert型式時,先檢查資料匯入檔案是否存在,是否有資料需匯入
         IF l_pack_ddata.ddata004 = "1" OR l_pack_ddata.ddata004 = "2" THEN
            #資料dmp檔名
            LET l_file = l_pack_ddata.ddata002 USING "<<<<<", "-", l_pack_dzyb.dzyb002 CLIPPED, ".dmp"
         
            IF NOT os.Path.EXISTS(l_file) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00339"
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_file.trim()
               CALL cl_err()
               LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_file.trim())
               CALL sadzi888_01_log_file_write(g_error_message)
               LET l_ddata009 = "2"
               EXIT FOREACH
            END IF

            #資料筆數為0:代表沒資料,不需匯入
            #todo:但是因為4fd設計資料為完整4fd xml內容,所以dzlm, dzfl_t需完整刪除
            LET l_row_cnt = l_table_list_json.get(l_file)
            IF l_row_cnt = 0 AND (NOT (l_pack_dzyb.dzyb002 = "dzfl_t" OR l_pack_dzyb.dzyb002 = "dzam_t")) THEN
               DISPLAY l_file.trim(), ":row cnt is 0."
               #CONTINUE FOREACH
            END IF
         END IF

         LET l_time_s = cl_get_current()
         
         #匯入設計資料
         CASE l_pack_ddata.ddata004 CLIPPED
            WHEN "1"     #Merge
               IF sadzi888_01_pack_del_data(l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb008, 
                                            l_pack_ddata.ddata005, l_pack_ddata.ddata006, l_pack_ddata.ddata007, l_pack_ddata.ddata015, l_pack_ddata.ddata002) THEN
                  IF NOT sadzi888_01_pack_ins_data_dmp(l_file, l_pack_dzyb.dzyb002, l_pack_ddata.*) THEN
                     LET l_ddata009 = "2"
                  END IF
               ELSE
                  LET l_ddata009 = "2"
               END IF
               
            WHEN "2"     #Insert
               IF NOT sadzi888_01_pack_ins_data_dmp(l_file, l_pack_dzyb.dzyb002, l_pack_ddata.*) THEN
                  LET l_ddata009 = "2"
               END IF
               
            WHEN "3"     #Delete
               IF NOT sadzi888_01_pack_del_data(l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb008, 
                                                l_pack_ddata.ddata005, l_pack_ddata.ddata006, l_pack_ddata.ddata007, l_pack_ddata.ddata015, l_pack_ddata.ddata002) THEN

                  LET l_ddata009 = "2"
               END IF
               
         END CASE

         #記錄data load耗費時間
         LET l_time_e = cl_get_current()
         LET l_str = "    Cost time : ", l_time_e - l_time_s
         CALL sadzi888_01_log_file_write(l_str)
      
         #匯入失敗處理
         IF l_ddata009 = "2" THEN
            EXIT FOREACH
         END IF
         
      END FOREACH

      IF l_ddata009 = "2" THEN
         #ROLLBACK WORK
         RETURN FALSE
      ELSE
         #COMMIT WORK

         #依據各註冊資料性質,呼叫產生程序(如:azzi902需產生str, 42s檔案)
         IF (l_pack_ddata.ddata004 = "1" OR l_pack_ddata.ddata004 = "2") AND (g_gen_prog_pre.getIndexOf(l_pack_ddata.ddata005, 1) > 0) THEN
            #防止command run切換路徑,所需把路徑切回目前工作路徑
            LET l_str = os.Path.pwd()

            #進入此段時,指定全背景作業,不主動跳窗
            LET l_bgjob = g_bgjob
            LET g_bgjob = "Y"
   
            IF NOT sadzi888_01_generator_program(l_pack_ddata.ddata005, l_pack_ddata.ddata006, l_pack_ddata.ddata007, l_pack_ddata.ddata015) THEN
               DISPLAY "BREAK_ERROR:sadzi888_01_generator_program( ", l_pack_ddata.ddata005, ", ", l_pack_ddata.ddata006, ")"
               LET g_bgjob = l_bgjob 
               RETURN FALSE
            END IF

            LET g_bgjob = l_bgjob 
            
            #把路徑切回打包的工作路徑
            IF NOT os.Path.chdir(l_str) THEN
               LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_str.trim())
               RETURN FALSE
            END IF
         END IF
      END IF
      
      #更新匯入狀態
      UPDATE adzi888_ddata SET ddata009 = l_ddata009
        WHERE ddata001 = p_master001 
          AND ddata002 = l_pack_ddata.ddata002
      
      #串接ALM環境時,更新需求單狀態
      IF g_top_alm = "Y" AND (NOT (cl_null(p_master013) AND cl_null(p_master014))) THEN
         #同步回ALM需求單
         UPDATE dzld_t SET dzld009 = l_ddata009    
           WHERE dzld002 = l_pack_ddata.ddata002
             AND dzld011 = p_master013 
             AND dzld012 = g_dzld012
             AND dzld013 = g_dzld013
             AND dzld014 = p_master014 
      END IF

      LET l_str = "####################"
      CALL sadzi888_01_log_file_write(l_str)
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 取得所有語系
PUBLIC FUNCTION sadzi888_01_get_gzzy001()
   DEFINE l_i               LIKE type_t.num5 
   DEFINE l_errcode         STRING
   
   LET l_i = 1 
   
   #因產生程序動作需有語系資料
   CALL g_gzzy001.clear()
   FOREACH sadzi888_01_gzzy_cs INTO g_gzzy001[l_i]
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzi888_01_gzzy_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "BREAK_ERROR-FOREACH sadzi888_01_gzzy_cs:", cl_getmsg(l_errcode, g_lang)
         RETURN FALSE
      END IF

      LET l_i = l_i + 1
   END FOREACH
   CALL g_gzzy001.deleteElement(l_i)
   
   RETURN TRUE
END FUNCTION

#+ [設計資料]採單一個dmp方式imp
PUBLIC FUNCTION sadzi888_01_pack_ins_data_dmp(p_file, p_dzyb002, p_ddata)
   DEFINE p_file            STRING
   DEFINE p_dzyb002         LIKE dzyb_t.dzyb002
   DEFINE p_ddata           type_g_ddata_d
   #DEFINE p_ddata004        LIKE type_t.chr1        #匯入動作(1:Merge; 2:Insert; 3:Delete)
   
   DEFINE l_cmd             STRING
   DEFINE l_str             STRING
   DEFINE l_sql             STRING
   DEFINE l_errcode         STRING

   ##檢查是否有人正在LOCK資料
   #LET l_sql = "SELECT * FROM gzzd_t ",
   #                   "  WHERE gzzd001 = ? FOR UPDATE"
                      
   #LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
   #LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   #DECLARE sadzi888_01_lock_cl CURSOR FROM l_sql   # LOCK CURSOR

   #OPEN sadzi888_01_lock_cl USING "axrt300"
   #IF STATUS THEN
   #   LET l_errcode = STATUS
   #   INITIALIZE g_errparam TO NULL 
   #   LET g_errparam.extend = "OPEN sadzi888_01_lock_cl:" 
   #   LET g_errparam.code = STATUS 
   #   LET g_errparam.popup = TRUE 
   #   CALL cl_err()
   #   CLOSE sadzi888_01_lock_cl
   #   LET g_error_message = "BREAK_ERROR-OPEN sadzi888_01_lock_cl:", cl_getmsg(l_errcode, g_lang)
   #   CALL sadzi888_01_log_file_write(g_error_message)
   #   RETURN FALSE
   #END IF

   #CLOSE sadzi888_01_lock_cl
   
   #imp data指令
   LET l_cmd = "imp ", g_sys_schema CLIPPED, "/", g_exp_para.trim(), " FILE=", p_file.trim(), " LOG=", p_file.trim(), ".implog TABLES=", p_dzyb002 CLIPPED, " DATA_ONLY=Y STATISTICS=NONE"
   CALL sadzi888_01_log_file_write(l_cmd)
   
   IF NOT sadzi888_01_run_command(l_cmd) THEN
      IF p_ddata.ddata004 = "2" THEN
         LET l_str = "Warning-LOAD FROM ", p_file.trim(), ":", cl_getmsg(STATUS, g_lang)
         DISPLAY l_str
         CALL sadzi888_01_log_file_write(l_str)
      ELSE
         LET g_error_message = "BREAK_ERROR-imp ", p_file.trim()
         CALL sadzi888_01_log_file_write(g_error_message)
         RETURN FALSE
      END IF
   END IF

   RETURN TRUE
END FUNCTION

#+ [設計資料]採單一個dmp方式imp
PRIVATE FUNCTION sadzi888_01_unload_gzzq001_standard_data()
   DEFINE l_file            STRING
   DEFINE l_sql             STRING
   DEFINE l_errcode         STRING
   DEFINE l_str             STRING
   
   LET l_file = g_gzzq_standard
   LET l_sql = "SELECT * FROM gzzq_t ", 
               "  WHERE gzzq002 IN ", 
               "          (SELECT DISTINCT gzzr002 FROM gzzr_t ",
               "             WHERE gzzr001 IN ",
               "                     (SELECT DISTINCT ddata006 FROM adzi888_ddata ", 
               "                        WHERE ddata005 = 'azzi903')) ",
               "    AND gzzq001 = 'standard'"

   #patch打包資料只能包出zh_TW和zh_CN的資料
   IF g_patch_mode THEN
      LET l_sql = l_sql, " AND (gzzq003 = 'zh_TW' OR gzzq003 = 'zh_CN')"
   END IF

   LET l_str = "UNLOAD TO ", l_file, " ", l_sql
   CALL sadzi888_01_log_file_write(l_sql)

   UNLOAD TO l_file l_sql
   
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_str = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY l_str
   END IF
END FUNCTION

#+ 取得[資料]匯出where條件
PRIVATE FUNCTION sadzi888_01_get_export_wc(p_dzyb002, p_dzyb003, p_dzyb004, p_dzyb008, p_ddata005, p_ddata006, p_ddata007, p_ddata015)
   DEFINE p_dzyb002         LIKE dzyb_t.dzyb002
   DEFINE p_dzyb003         LIKE dzyb_t.dzyb003
   DEFINE p_dzyb004         LIKE dzyb_t.dzyb004
   DEFINE p_dzyb008         LIKE dzyb_t.dzyb008
   DEFINE p_ddata005        LIKE type_t.chr20
   DEFINE p_ddata006        LIKE type_t.chr50
   DEFINE p_ddata007        LIKE type_t.chr50
   DEFINE p_ddata015        LIKE type_t.chr1
   
   DEFINE l_wc              STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_str             STRING
   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_dgenv           LIKE type_t.chr1 
   
   LET l_wc = ""
   LET l_sub_sql = ""
   
   CASE p_ddata005

      WHEN "azzi300"
         IF p_dzyb003 = "Y" THEN
            LET l_wc = "  WHERE ", p_dzyb004 CLIPPED, " = '", p_ddata006 CLIPPED, "' "

            #XG patch規則異動:gzgf004和gzgf005是default的資料才可包出去
            #(參考2015/1/28 XG上Patch的規則異動mail)
            IF p_dzyb002 = "gzgf_t" AND g_patch_mode THEN
               LET l_wc = l_wc, " AND gzgf004 = 'default' AND gzgf005 = 'default' "
            ELSE
               #todo:過單規則異動(參考2015/10/23 mail):此處將Patch規則和過單規則完整切開
               #WHERE gzgf001 = 'apmr006_x01' AND gzgf002 = 'apmr006_x01' AND (gzgf003 ='s' OR gzgf003 ='c' )  
               #  AND gzgf004 = 'default' AND gzgf005 = 'default'
               LET l_wc = l_wc, 
                   #2016/03/31  " AND gzgf002 = '", p_ddata006 CLIPPED, "' ",
                                " AND (gzgf003 = 's' OR gzgf003 = 'c' ) ",
                                " AND gzgf004 = 'default' AND gzgf005 = 'default' "
            END IF
         ELSE
            LET l_sub_sql = "SELECT gzgf000 FROM gzgf_t ", 
                            "  WHERE gzgf001 = '", p_ddata006 CLIPPED, "' "

            #參考2015/1/28 XG上Patch的規則異動mail
            IF g_patch_mode THEN
               LET l_sub_sql = l_sub_sql, " AND gzgf004 = 'default' AND gzgf005 = 'default' "
            ELSE
               #todo:過單規則異動(參考2015/10/23 mail):此處將Patch規則和過單規則完整切開
               LET l_sub_sql = l_sub_sql, 
                             #2016/03/31  " AND gzgf002 = '", p_ddata006 CLIPPED, "' ",
                                          " AND (gzgf003 = 's' OR gzgf003 = 'c' ) ",
                                          " AND gzgf004 = 'default' AND gzgf005 = 'default' "
            END IF
            
            LET l_wc = "  WHERE ", p_dzyb004 CLIPPED, " IN (", l_sub_sql.trim(), ")"
         END IF
      
      WHEN "azzi301"
         IF p_dzyb003 = "Y" THEN
            LET l_wc = "  WHERE ", p_dzyb004 CLIPPED, " = '", p_ddata006 CLIPPED, "' "
         ELSE
            LET l_sub_sql = "SELECT gzgd000 FROM gzgd_t ", 
                            "  WHERE gzgd001 = '", p_ddata006 CLIPPED, "' "
                            
            LET l_wc = "  WHERE ", p_dzyb004 CLIPPED, " IN (", l_sub_sql.trim(), ")"
         END IF

      OTHERWISE
         #檢查是否需要加入第二條件式
         IF (p_ddata015 = "d") AND (NOT cl_null(p_ddata007)) AND (NOT cl_null(p_dzyb008)) THEN
            DISPLAY "p_ddata007 is not null."
            
            #這裡表示只需要過單身資料,而dzyb004 = dzyb008代表此table裡主要ID Key值就為adzi888輸入ddata007的key值
            IF p_dzyb004 = p_dzyb008 THEN
               LET l_wc = "  WHERE ", p_dzyb008 CLIPPED, " = '", p_ddata007 CLIPPED, "' "
               RETURN TRUE, l_wc
            ELSE
               CALL sadzi888_01_get_ddata007_wc(p_dzyb008, p_ddata007)
                  RETURNING l_success, l_sub_sql

               IF (NOT l_success) THEN
                  RETURN FALSE, ""
               END IF
            END IF
         END IF
         
         CASE 
            #子畫面多語言表因PK欄位只有子畫面代碼較為特殊,需額外處理
            WHEN p_dzyb002 = "gzdfl_t"
               LET l_wc = "  WHERE ", p_dzyb004 CLIPPED, " IN ",
                          "    (SELECT gzdf002 FROM gzdf_t WHERE gzdf001 = '", p_ddata006 CLIPPED, "') "

            #欄位多語言表因PK欄位只有欄位代碼較為特殊,需額外處理(dzebl_t尚未處理ddata015="d"的模式)
            WHEN p_dzyb002 = "dzebl_t"
               LET l_wc = "  WHERE ", p_dzyb004 CLIPPED, " IN ",
                          "    (SELECT dzeb002 FROM dzeb_t WHERE dzeb001 = '", p_ddata006 CLIPPED, "') "

            #azzi990參數設定主表需要與azzi993一同過單,避免參數程式產生失敗
            WHEN (p_dzyb002 = "gzsz_t" AND p_ddata005 = "azzi993") 
               LET l_wc = "  WHERE (gzsz001, gzsz002) IN ",
                          "    (SELECT gzsv005, gzsv006 FROM gzsv_t WHERE gzsv001 = '", p_ddata006 CLIPPED, "' AND 1=1) "

            WHEN (p_dzyb002 = "gzszl_t" AND p_ddata005 = "azzi993") 
               LET l_wc = "  WHERE (gzszl001, gzszl002) IN ",
                          "    (SELECT gzsv005, gzsv006 FROM gzsv_t WHERE gzsv001 = '", p_ddata006 CLIPPED, "' AND 1=1) "
           
            #2016/03/11
            #2016/01/20           
            #azzi880在標準環境不處理c開頭的選單
            #使用dgenv作為判斷依據
            #WHEN p_dzyb002 = "gzwe_t" AND p_ddata005 = "azzi880" #AND cl_null(p_ddata007)
            #   LET l_dgenv = FGL_GETENV("DGENV")
            #   IF l_dgenv = 's' THEN
            #      LET l_wc = "  WHERE ", p_dzyb004 CLIPPED, " = '", p_ddata006 CLIPPED, "' ", 
            #                 "    AND SUBSTR (gzwe001,1,1) <> 'c'",
            #                 "    AND SUBSTR (gzwe002,1,1) <> 'c'"
            #   END IF           
            #
            #WHEN p_dzyb002 = "gzwel_t" AND p_ddata005 = "azzi880" AND cl_null(p_ddata007)
            #   LET l_wc = "  WHERE ", p_dzyb004 CLIPPED, " = '", p_ddata006 CLIPPED, "' ", 
            #              "    AND SUBSTR (gzwel002,1,1) <> 'c'"
            #2016/01/20
            #2016/03/11
            
            OTHERWISE
               LET l_wc = "  WHERE ", p_dzyb004 CLIPPED, " = '", p_ddata006 CLIPPED, "' "
         END CASE 

         #參數資料如果只過單身項目(分頁編號)時,需加單身條件gzsv002
         IF (p_ddata015 = "d" AND (NOT cl_null(p_ddata007))) AND ((p_dzyb002 = "gzsz_t" OR p_dzyb002 = "gzszl_t") AND p_ddata005 = "azzi993") THEN
            LET l_str = "gzsv002 = '", p_ddata007 CLIPPED, "'"
            LET l_wc = cl_replace_str(l_wc, "1=1", l_str)
         END IF

         #加入單身子項條件
         IF NOT cl_null(l_sub_sql) THEN
            LET l_wc = l_wc, " AND ", l_sub_sql.trim()
         END IF
         
         #2016/03/11
         IF p_dzyb002 = "gzwe_t" AND p_ddata005 = "azzi880" AND FGL_GETENV("DGENV") = 's' THEN
            #不過開頭為c者/且只過ent=99(僅限標準環境)
            LET l_wc = l_wc, " AND SUBSTR (gzwe001,1,1) <> 'c' ",
                             " AND SUBSTR (gzwe002,1,1) <> 'c' ",
                             " AND gzweent = '99' "
         END IF
         #2016/03/11

   END CASE

   RETURN TRUE, l_wc
END FUNCTION

#+ 產生patch相關所需檔案,以利後序程式組裝&編譯...用
PUBLIC FUNCTION sadzi888_01_gen_file_pre(p_master001, p_ddata005)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_ddata005        LIKE type_t.chr20     #維護作業代碼
   
   DEFINE l_pack_ddata      type_g_ddata_d
   DEFINE l_errcode         STRING
   DEFINE l_str             STRING
   DEFINE l_msg             STRING
   DEFINE l_prog_num        LIKE type_t.num10
   DEFINE l_prog_cnt        LIKE type_t.num10
   DEFINE l_bgjob           LIKE type_t.chr1

   LET l_prog_num = 0
   
   SELECT COUNT(*) INTO l_prog_cnt FROM adzi888_ddata
     WHERE ddata001 = p_master001
       AND ddata005 = p_ddata005

   #找出所有需匯入處理的註冊資訊清單
   FOREACH sadzi888_01_ddata005_cs USING p_master001, p_ddata005
                                   INTO l_pack_ddata.ddata002, l_pack_ddata.ddata003, l_pack_ddata.ddata004, l_pack_ddata.ddata005, l_pack_ddata.ddata006,  
                                        l_pack_ddata.ddata007, l_pack_ddata.ddata008, l_pack_ddata.ddata009, l_pack_ddata.ddata010, l_pack_ddata.ddata015
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzi888_01_ddata005_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "BREAK_ERROR-FOREACH sadzi888_01_ddata005_cs", p_ddata005 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
         CALL sadzi888_01_log_file_write(g_error_message)
         RETURN FALSE
      END IF
      
      #進度列控制
      LET l_prog_num = l_prog_num + 1
      IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
         CALL adzp999_01_refresh_sub_tasks_progressbar(l_prog_num, l_prog_cnt)
      END IF

      #依據各註冊資料性質,呼叫產生程序(如:azzi902需產生str, 42s檔案)
      IF l_pack_ddata.ddata004 = "1" OR l_pack_ddata.ddata004 = "2" THEN
         LET l_str = ASCII 10, "####################", ASCII 10
         LET l_str = l_str, "ddata002: ", l_pack_ddata.ddata002 USING "<<<<<", "; "
         LET l_str = l_str, "ddata005: '", l_pack_ddata.ddata005 CLIPPED, "'; "
         LET l_str = l_str, "ddata006: '", l_pack_ddata.ddata006 CLIPPED, "'; "
         CALL sadzi888_01_log_file_write(l_str)
      
         #防止command run切換路徑,所需把路徑切回目前工作路徑
         LET l_str = os.Path.pwd()

         #進入此段時,指定全背景作業,不主動跳窗
         LET l_bgjob = g_bgjob
         LET g_bgjob = "Y"
   
         IF NOT sadzi888_01_generator_program(l_pack_ddata.ddata005, l_pack_ddata.ddata006, l_pack_ddata.ddata007, l_pack_ddata.ddata015) THEN
            LET l_msg = "ERROR:sadzi888_01_generator_program( ", l_pack_ddata.ddata005, ", ", l_pack_ddata.ddata006, ")"
            DISPLAY l_msg
            CALL sadzi888_01_log_file_write(l_msg)
            LET g_bgjob = l_bgjob 

            #非patch模式下,任何的產生錯誤都視為失敗
            IF (NOT cl_null(g_patch_mode)) AND (NOT g_patch_mode) THEN
               LET g_error_message = "BREAK_ERROR:sadzi888_01_generator_program( ", l_pack_ddata.ddata005, ", ", l_pack_ddata.ddata006, ")"
               #2016/11/10
               DISPLAY g_error_message
               #2016/11/10
               RETURN FALSE
            END IF
         END IF

         LET g_bgjob = l_bgjob
         CALL sadzi888_01_log_file_write("####################")
         
         #把路徑切回打包的工作路徑
         IF NOT os.Path.chdir(l_str) THEN
            LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_str.trim())
            RETURN FALSE
         END IF
      END IF
   END FOREACH
   
   RETURN TRUE
END FUNCTION

#+ [IT工具]匯出
PUBLIC FUNCTION sadzi888_01_export_tool(p_master001, p_master013, p_master014, p_pack_dir, p_folder)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   DEFINE p_pack_dir        STRING                #打包檔置放路徑
   DEFINE p_folder          STRING                #匯出檔所在目錄
   
   DEFINE l_dtool           type_g_dtool_d
   DEFINE l_cmd             STRING
   DEFINE l_source          STRING
   DEFINE l_dest            STRING
   DEFINE ls_dtool006       STRING
   DEFINE l_dtool008        LIKE type_t.chr1   #匯出狀態(0:建立; 1:成功; 2:失敗) 
   DEFINE l_errcode         STRING
   DEFINE l_work_dir        STRING
   DEFINE l_tool_folder     STRING
   DEFINE l_tar_name        STRING
   DEFINE l_pack_dir        STRING
   DEFINE l_file            STRING
   DEFINE l_sql             STRING
   DEFINE l_load_data       type_g_load_data
   DEFINE l_success         LIKE type_t.chr1

   #IT工具類單獨打成一包
   LET l_tool_folder = p_folder, "-tool"
   LET l_tar_name = l_tool_folder, ".tgz"

   #記錄目前程式執行路徑
   LET l_work_dir = os.Path.pwd()

   #切換至$TEMPDIR目錄下
   LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
   
   IF NOT os.Path.chdir(l_pack_dir) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_pack_dir.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_pack_dir.trim())
      RETURN FALSE
   END IF

   #建立[IT工具類]目錄
   IF NOT sadzi888_01_make_pack_dir(l_tool_folder, l_tar_name) THEN
      RETURN FALSE
   END IF


   #找出[檔案匯出清單]
   FOREACH sadzi888_01_dtool_cs USING p_master001 
                                INTO l_dtool.dtool002, l_dtool.dtool003, l_dtool.dtool004, l_dtool.dtool005, l_dtool.dtool006, 
                                     l_dtool.dtool007, l_dtool.dtool008, l_dtool.dtool009
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzi888_01_dtool_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-FOREACH sadzi888_01_dtool_cs:", cl_getmsg(l_errcode, g_lang)
         RETURN FALSE
      END IF

      #匯入類型為"del":不需做匯出動作
      IF l_dtool.dtool004 = "del" THEN
         CONTINUE FOREACH
      END IF
      
      LET l_cmd = ""

      #取得檔案
      #取得模組
      IF l_dtool.dtool003 <> "oth" THEN
         LET l_source = UPSHIFT(l_dtool.dtool003)
         LET l_source = FGL_GETENV(l_source)
      END IF

      #取得是否為4gl或4fd檔案類型
      IF l_dtool.dtool004 = "4gl" OR l_dtool.dtool004 = "4fd" OR l_dtool.dtool004 = "42m" THEN
         LET l_source = os.Path.join(l_source, l_dtool.dtool004)
      END IF

      #取得檔案所在完整路徑
      IF l_dtool.dtool003 = "oth" THEN
         LET l_source = sadzp007_util_get_path(l_dtool.dtool006 CLIPPED) #160223-00028
         LET ls_dtool006 = os.Path.basename(l_dtool.dtool006)
      ELSE
         LET ls_dtool006 = l_dtool.dtool006 CLIPPED
         IF l_dtool.dtool004 = "4gl" OR l_dtool.dtool004 = "4fd" THEN
            LET ls_dtool006 = ls_dtool006, ".", l_dtool.dtool004 CLIPPED
         END IF
         
         #42m檔案類型,前置檔名需要加入模組別名稱(例如:adz_sadzi888_01.42m)
         IF l_dtool.dtool004 = "42m" THEN
            LET ls_dtool006 = l_dtool.dtool003 CLIPPED, "_", ls_dtool006, ".", l_dtool.dtool004 CLIPPED 
         END IF
         
         LET l_source = os.Path.JOIN(l_source, ls_dtool006.trim())
      END IF

      #load匯入類型,data file檔名需為[table name].unl(例如:dzyc_t.unl)
      IF l_dtool.dtool004 = "load" THEN
         #LET l_source = l_source, ".unl" 
         #LET ls_dtool006 = ls_dtool006, ".unl" 

          CALL sadzi888_01_get_load_script(l_dtool.dtool006)
               RETURNING l_success, l_load_data.*

         IF NOT l_success THEN
            LET g_error_message = "ERROR-sadzi888_01_get_load_script is error.", l_dtool.dtool006 CLIPPED
            DISPLAY g_error_message
            RETURN FALSE
         END IF
         
         #匯出[匯出主檔]
         LET l_file = l_dtool.dtool002 USING "<<<<<", "-Temp-", l_load_data.dzea001 CLIPPED, ".unl"
         LET l_sql = "SELECT * FROM ", l_load_data.dzea001 CLIPPED, " WHERE ", l_load_data.wc
         UNLOAD TO l_file l_sql
   
         IF STATUS THEN
            LET l_errcode = STATUS
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
            RETURN FALSE
         END IF

         LET l_source = l_file

         #檢查檔案是否存在
         LET l_source = os.Path.join(os.Path.join(p_pack_dir, l_tool_folder), l_source)
         
         IF NOT os.Path.EXISTS(l_source) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "adz-00339"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_source.trim()
            CALL cl_err()
            LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_source.trim())
            RETURN FALSE
         END IF

         CONTINUE FOREACH
      END IF
      
      LET l_dest = os.Path.join(p_pack_dir, l_tool_folder)
      LET l_dest = os.Path.join(l_dest, ls_dtool006.trim())
      LET l_cmd = "cp ", l_source.trim(), " ", l_dest.trim()

      
      LET l_dtool008 = "2"

      #檢查檔案是否存在
      IF NOT os.Path.EXISTS(l_source) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00339"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_source.trim()
         CALL cl_err()
         LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_source.trim())
         RETURN FALSE
      ELSE
         #複製檔案
         DISPLAY "l_cmd:", l_cmd, ";"
         RUN l_cmd
      
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00338"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_source.trim()
            CALL cl_err()
            LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00338", g_lang, l_source.trim())
            RETURN FALSE
         END IF
         
         LET l_dtool008 = "1"
      END IF

      #更新匯出狀態
      UPDATE adzi888_dtool SET dtool008 = l_dtool008
        WHERE dtool001 = p_master001 
          AND dtool002 = l_dtool.dtool002

      #串接ALM環境時,更新需求單狀態
      IF g_top_alm = "Y" AND (NOT (cl_null(p_master013) AND cl_null(p_master014))) THEN
         #同步回ALM需求單
         UPDATE dzlt_t SET dzlt008 = l_dzlt008    
           WHERE dzlt002 = l_dtool.dtool002
             AND dzlt011 = p_master013 
             AND dzlt012 = g_dzld012
             AND dzlt013 = g_dzld013
             AND dzlt014 = p_master014 
      END IF
   END FOREACH

   #匯出[匯出主檔]
   LET l_file = "Temp-", "adzi888_master.unl"
   LET l_sql = "SELECT * FROM adzi888_master WHERE master001 = '", p_master001 CLIPPED, "' "
   UNLOAD TO l_file l_sql
   
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF
   
   #匯出[IT工具類匯出清單]
   LET l_file = "Temp-", "adzi888_dtool.unl"
   LET l_sql = "SELECT * FROM adzi888_dtool WHERE dtool001 = '", p_master001 CLIPPED, "' "
   UNLOAD TO l_file l_sql
   
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF
   
   #返回上一層目錄,準備打包相關工具類檔案
   IF NOT os.Path.chdir(l_pack_dir) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_pack_dir.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_pack_dir.trim())
      RETURN FALSE
   END IF

   #打包成tar檔範例:tar cvf $FOLDER.tgz $FOLDER
   LET l_cmd = "tar zcvf ", l_tar_name CLIPPED, " ", l_tool_folder CLIPPED
   RUN l_cmd

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "tar zcvf ", l_tar_name CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-tar zcvf ", l_tar_name CLIPPED, ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF

   #匯出包tar檔所在完整路徑
   LET g_tool_tar_path = os.Path.join(l_pack_dir.trim(), l_tar_name.trim())

   IF NOT os.Path.EXISTS(g_tool_tar_path) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00339"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_tool_tar_path.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, g_tool_tar_path.trim())
      RETURN FALSE
   END IF
   
   #切換回原打包路徑
   IF NOT os.Path.chdir(l_work_dir) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_work_dir.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_work_dir.trim())
      RETURN FALSE
   END IF

   #將IT工具打包的tar檔cp 至原打包[需求單號/項次]目錄內
   LET l_cmd = "cp ", g_tool_tar_path.trim(), " ."
   RUN l_cmd

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "cp ", g_tool_tar_path.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-cp ", g_tool_tar_path.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

#+ 解析load語句
PUBLIC FUNCTION sadzi888_01_get_load_script(p_dzlt006)
   DEFINE p_dzlt006         STRING
  
   DEFINE l_tok             base.StringTokenizer
   DEFINE l_str             STRING
   DEFINE l_load_data       type_g_load_data
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_row_cnt         LIKE type_t.num10
   DEFINE l_sql             STRING
   DEFINE l_idx             LIKE type_t.num10
   DEFINE l_dzyc005         LIKE dzyc_t.dzyc005
   
   LET l_cnt = 1
  
   IF p_dzlt006.getIndexOf(",", 1) > 0 THEN
       #LET l_tok = base.StringTokenizer.create(p_dzlt006.trim(), ",")
       #WHILE l_tok.hasMoreTokens()
       #   LET l_str = l_tok.nextToken()

       #   CASE l_cnt
       #      WHEN 1
       #         LET l_load_data.dzea001 = l_str.trim()
               
       #      WHEN 2
       #         LET l_load_data.wc = l_str.trim()

       #   END CASE

       #   LET l_cnt = l_cnt + 1
       #END WHILE

       #取得資料表代碼
       LET l_idx = p_dzlt006.getIndexOf(",", 1)
       LET l_load_data.dzea001 = p_dzlt006.subString(1, l_idx - 1)

       #取得where條件式
       LET l_load_data.wc = p_dzlt006.subString(l_idx + 1, p_dzlt006.getLength())
    ELSE
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00584"
       LET g_errparam.extend = NULL
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN FALSE, l_load_data.*
    END IF

   
    SELECT COUNT(*) INTO l_cnt FROM dzea_t WHERE dzea001 = l_load_data.dzea001

    IF l_cnt = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00493"
       LET g_errparam.extend = NULL
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] = l_load_data.dzea001 CLIPPED
       CALL cl_err()
       RETURN FALSE, l_load_data.*
    END IF

   
    #取得資料筆數
    LET l_row_cnt = 0
    LET l_sql = "SELECT COUNT(*) FROM ", l_load_data.dzea001 CLIPPED, " WHERE ", l_load_data.wc

    #加入patch模式判斷多語言資料表只出貨zh_TW和zh_CN和en_US
    #因為在tool機制下沒有多語言的設定判斷,暫時拿dzyc005來判斷
    IF g_patch_mode AND g_alm_jb = g_dgenv_s THEN
       SELECT dzyc005 INTO l_dzyc005 FROM dzyc_t WHERE dzyc001 = l_load_data.dzea001
       
       #IF SQLCA.sqlcode THEN
       IF SQLCA.sqlcode AND SQLCA.sqlcode <> 100 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "sel dzyc005.", l_load_data.dzea001 CLIPPED
          LET g_errparam.popup = TRUE
          CALL cl_err()
          RETURN FALSE, l_load_data.*
       END IF
       
       IF NOT cl_null(l_dzyc005) THEN
          LET l_sql = l_sql, " AND (", l_dzyc005 CLIPPED, " = 'zh_TW' OR ", l_dzyc005 CLIPPED, " = 'zh_CN' OR ", l_dzyc005 CLIPPED, " = 'en_US')"
       END IF
    END IF
    
    DISPLAY "sql:", l_sql.trim()
   
    PREPARE sadzi888_01_load_cnt_pre FROM l_sql
   
    EXECUTE sadzi888_01_load_cnt_pre INTO l_row_cnt
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "exc sadzi888_01_load_cnt_pre.", l_load_data.dzea001 CLIPPED
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN FALSE, l_load_data.*
    END IF

    IF l_row_cnt = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00585"
       LET g_errparam.extend = NULL
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] = p_dzlt006.trim()
       CALL cl_err()
       RETURN FALSE, l_load_data.*
    END IF

    RETURN TRUE, l_load_data.*
END FUNCTION

#取得目的端的程式相關資訊
PUBLIC FUNCTION sadzi888_01_imp_get_dzye(p_master002, p_folder)
   DEFINE p_master002       LIKE type_t.chr50
   DEFINE p_folder          STRING                #匯出檔目錄

   DEFINE l_dzye_d          type_g_dzye_d           #設計資料執行結果記錄表
   DEFINE l_errcode         STRING
   DEFINE l_gzza003         LIKE gzza_t.gzza003     #模組代碼
   DEFINE lo_DZAF_T         T_DZAF_T
   DEFINE ls_err_msg        STRING
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_file            STRING
   DEFINE l_sql             STRING

   #匯入[程式(dzye_t)相關資訊]
   LET l_file = os.Path.join(p_folder.trim(), "Temp-dzye_t.unl")
   LET l_sql = "INSERT INTO tmp_dzye_t "
   
   IF os.Path.exists(l_file) THEN
      LOAD FROM l_file l_sql
   
      IF STATUS THEN
         LET l_errcode = STATUS
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = "LOAD FROM ", l_file.trim()
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-LOAD FROM ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
         RETURN FALSE
      END IF
   ELSE
      DISPLAY l_file, " doesn't exist."
      RETURN TRUE
   END IF
 
   #patch程式(dzye_t)清單
   LET l_sql = "SELECT dzye001, dzye002, dzye003, dzye004, dzye005, ",
               "       dzye006, dzye007, dzye008, dzye009, dzye010, ", 
               "       dzye011, dzye012, dzye013, dzye014, dzye015, ", 
               "       dzye016, dzye017, dzye018, dzye019, dzye020, ", 
               "       dzye021, dzye022, dzye023, dzye024 ", 
               "  FROM tmp_dzye_t ", 
               "  WHERE dzye001 = ? ",
               "  ORDER BY dzye002"
   
   PREPARE sadzi888_01_imp_dzye FROM l_sql
   DECLARE sadzi888_01_imp_dzye_cs CURSOR FOR sadzi888_01_imp_dzye
   
   OPEN sadzi888_01_imp_dzye_cs USING p_master002

   FOREACH sadzi888_01_imp_dzye_cs INTO l_dzye_d.dzye001, l_dzye_d.dzye002, l_dzye_d.dzye003, l_dzye_d.dzye004, l_dzye_d.dzye005,
                                        l_dzye_d.dzye006, l_dzye_d.dzye007, l_dzye_d.dzye008, l_dzye_d.dzye009, l_dzye_d.dzye010,
                                        l_dzye_d.dzye011, l_dzye_d.dzye012, l_dzye_d.dzye013, l_dzye_d.dzye014, l_dzye_d.dzye015,
                                        l_dzye_d.dzye016, l_dzye_d.dzye017, l_dzye_d.dzye018, l_dzye_d.dzye019, l_dzye_d.dzye020,
                                        l_dzye_d.dzye021, l_dzye_d.dzye022, l_dzye_d.dzye023, l_dzye_d.dzye024 
                           
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzi888_01_imp_dzye_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-FOREACH sadzi888_01_imp_dzye_cs:", cl_getmsg(l_errcode, g_lang)
         FREE sadzi888_01_imp_dzye
         RETURN FALSE
      END IF
      
      #取得程式代碼匯入端所屬模組
      CALL sadzp062_1_find_module(l_dzye_d.dzye002, l_dzye_d.dzye003) 
         RETURNING l_gzza003
      
      IF cl_null(l_gzza003) THEN
         DISPLAY "   warning-", l_dzye_d.dzye002 CLIPPED, ".", l_dzye_d.dzye003 CLIPPED, ":", cl_getmsg("adz-00012", g_lang)
      END IF

      #取得程式碼版次及客製標示識別
      CALL sadzp060_2_get_curr_ver_info(l_dzye_d.dzye002, l_dzye_d.dzye003, NULL)
         RETURNING lo_DZAF_T.*, ls_err_msg

      IF NOT cl_null(ls_err_msg) THEN
         #todo:標準產品所patch出的"新程式",在匯入目的端還沒有任何版次資料(因為此時還沒有倒入任何設定和設計資料)
         DISPLAY "   warning-", l_dzye_d.dzye002 CLIPPED, ".", l_dzye_d.dzye003 CLIPPED, ":", cl_getmsg_parm("adz-00303", g_lang, l_dzye_d.dzye002), ". ", ls_err_msg.trim()

         #取不到版次資料,也取不到模組資料時,認定???
         #IF cl_null(l_gzza003) THEN
            LET l_dzye_d.dzye005 = ""
            LET l_dzye_d.dzye006 = ""
            LET l_dzye_d.dzye009 = ""
            LET l_dzye_d.dzye010 = ""
            LET l_dzye_d.dzye011 = ""
            LET l_dzye_d.dzye012 = ""   #todo:需考量客戶家時的過單情境該如何給(或者直接給DGENV)
            LET l_dzye_d.dzye015 = ""   #預設不需做Merge(標準程式)
            LET l_dzye_d.dzye022 = "N"
            LET l_dzye_d.dzye023 = "0" 
         #END IF
      ELSE
         #取得匯入端程式相關資訊至dzye_t表中
         LET l_dzye_d.dzye005 = l_gzza003 CLIPPED
         LET l_dzye_d.dzye006 = ""
         LET l_dzye_d.dzye009 = lo_DZAF_T.dzaf002 CLIPPED
         LET l_dzye_d.dzye010 = lo_DZAF_T.dzaf003 CLIPPED
         LET l_dzye_d.dzye011 = lo_DZAF_T.dzaf004 CLIPPED
         LET l_dzye_d.dzye012 = lo_DZAF_T.dzaf010 CLIPPED
         LET l_dzye_d.dzye015 = ""   #預設不需做Merge(標準程式)
         LET l_dzye_d.dzye023 = "0" 
         
         #取得程式簽出資訊(無論規格或代碼簽出都視為簽出)
         LET l_dzye_d.dzye022 = "N"
        
         SELECT COUNT(*) INTO l_cnt FROM dzlm_t
           WHERE dzlm002 = l_dzye_d.dzye002
             AND (dzlm008 = 'O' OR dzlm011 = 'O')

         IF SQLCA.sqlcode THEN
            DISPLAY "   ERROR:sel dzlm_t-", l_dzye_d.dzye002 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         END IF

         IF l_cnt > 0 THEN
            LET l_dzye_d.dzye022 = "Y"
         END IF
      END IF
      
      UPDATE tmp_dzye_t SET (dzye005, dzye006, dzye009, dzye010, dzye011, 
                             dzye012, dzye015, dzye022, dzye023) = 
                            (l_dzye_d.dzye005, l_dzye_d.dzye006, l_dzye_d.dzye009, l_dzye_d.dzye010, l_dzye_d.dzye011, 
                             l_dzye_d.dzye012, l_dzye_d.dzye015, l_dzye_d.dzye022, l_dzye_d.dzye023)
        WHERE dzye001 = l_dzye_d.dzye001
          AND dzye002 = l_dzye_d.dzye002

      IF SQLCA.sqlcode THEN
         DISPLAY "   ERROR:upd tmp_dzye_t-", l_dzye_d.dzye002 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      END IF
      
   END FOREACH

   FREE sadzi888_01_imp_dzye
   RETURN TRUE
END FUNCTION

#+ 利用UNLOAD指令unload data檔案
PRIVATE FUNCTION sadzi888_01_unload_data(p_file, p_sql)
   DEFINE p_file            STRING
   DEFINE p_sql             STRING

   DEFINE l_str             STRING
   DEFINE l_errcode         STRING
   DEFINE l_size            LIKE type_t.num10

   LET l_str = "UNLOAD TO ", p_file, " ", p_sql
   CALL sadzi888_01_log_file_write(l_str)
   
   UNLOAD TO p_file p_sql

   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "UNLOAD TO ", p_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-UNLOAD TO ", p_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF

   #檢查一下是否有Data被UNLOAD下來
   LET l_size = os.Path.size(p_file)
   IF l_size = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00434"
      LET g_errparam.extend = "UNLOAD TO ", p_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg("adz-00434", g_lang)
      DISPLAY "UNLOAD TO ", p_file.trim(), "   '", p_sql, "'"
      RETURN FALSE
   END IF
               
   RETURN TRUE
END FUNCTION

#+ 將dmp檔資料暫時import到temp table裡,並將預先將此資料由實體表中刪除
#避免下一個階段的insert data時發生pk重覆
PRIVATE FUNCTION sadzi888_01_del_match_data(p_dzyb002, p_ddata002)
   DEFINE p_dzyb002         LIKE dzyb_t.dzyb002
   DEFINE p_ddata002        LIKE type_t.num5

   DEFINE l_file            STRING
   DEFINE l_sql             STRING
   DEFINE l_str             STRING
   DEFINE l_table_temp      STRING
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_dzed004         LIKE dzed_t.dzed004     #鍵值欄位
   DEFINE l_errcode         STRING
   DEFINE l_wc              STRING
   DEFINE l_cmd             STRING

   LET l_table_temp = ""
   LET l_wc = ""

   LET l_file = p_ddata002 USING "<<<<<", "-", p_dzyb002 CLIPPED, ".unl"
   
   IF NOT os.Path.EXISTS(l_file) THEN
      LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_file.trim())
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF
   
   LET l_table_temp = "tmp_", p_dzyb002 CLIPPED
   LET l_sql = "SELECT * INTO TEMP ", l_table_temp.trim(), 
               "  FROM ", "(SELECT * FROM ", p_dzyb002 CLIPPED, " WHERE 1 = 2)"
   
   DISPLAY "create temp table sql:", l_sql
   PREPARE sadzi888_01_match_create_pre FROM l_sql
   EXECUTE sadzi888_01_match_create_pre

   IF SQLCA.sqlcode THEN
      LET g_error_message = "BREAK_ERROR-PREPARE sadzi888_01_match_create_pre.", p_dzyb002 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF

   LET l_sql = "SELECT COUNT(*) FROM ", l_table_temp
   PREPARE sadzi888_01_match_cnt_pre FROM l_sql
   EXECUTE sadzi888_01_match_cnt_pre INTO l_cnt
   DISPLAY l_table_temp, " cnt before:", l_cnt
   
   #insert data 語法
   LET l_sql = "INSERT INTO ", l_table_temp CLIPPED
   LET l_str = "LOAD FROM ", l_file, " ", l_sql
   CALL sadzi888_01_log_file_write(l_str)

   #從unl檔中取得要匯入的資料
   LOAD FROM l_file l_sql

   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "LOAD FROM ", l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-LOAD FROM ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF

   EXECUTE sadzi888_01_match_cnt_pre INTO l_cnt
   DISPLAY l_table_temp, " cnt after:", l_cnt

   SELECT dzed004 INTO l_dzed004 FROM dzed_t 
     WHERE dzed001 = p_dzyb002 AND dzed003 = 'P' 

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "sel dzed004:", p_dzyb002 CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-sel ", p_dzyb002 CLIPPED, ".dzed004:", cl_getmsg(l_errcode, g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF

   IF cl_null(l_dzed004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-2270"
      LET g_errparam.extend = "sel dzed004:", p_dzyb002 CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-sel ", p_dzyb002 CLIPPED, ".dzed004:", cl_getmsg("-2270", g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF

   LET l_wc = " WHERE (", l_dzed004 CLIPPED, ") ",
              "   IN (SELECT ", l_dzed004 CLIPPED, " FROM ", l_table_temp.trim(), ")"

   LET l_sql = "DELETE FROM ", p_dzyb002 CLIPPED, " ", l_wc.trim()
   LET l_str = l_sql 
   CALL sadzi888_01_log_file_write(l_str)

   PREPARE sadzi888_01_match_del_data_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE sadzi888_01_match_del_data_pre:", p_dzyb002 CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-PREPARE sadzi888_01_match_del_data_pre.", p_dzyb002 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF

   EXECUTE sadzi888_01_match_del_data_pre
   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "exc sadzi888_01_match_del_data_pre:", p_dzyb002 CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-exc sadzi888_01_match_del_data_pre.", p_dzyb002 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN FALSE
   END IF 

   #drop temp table
   IF l_table_temp.getIndexOf("tmp_", 1) > 0 AND l_table_temp.getIndexOf("_t", 1) > 0 THEN
      LET l_sql = "DROP TABLE ", l_table_temp.trim()
      DISPLAY "drop temp table:", l_sql
      PREPARE sadzi888_01_match_drop_pre FROM l_sql
      EXECUTE sadzi888_01_match_drop_pre
   
      IF SQLCA.sqlcode THEN
         LET l_str = "Warning-PREPARE sadzi888_01_match_drop_pre.", l_table_temp.trim(), ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         CALL sadzi888_01_log_file_write(l_str)
         RETURN TRUE
      END IF
   END IF
   
   FREE sadzi888_01_match_create_pre
   FREE sadzi888_01_match_cnt_pre

   RETURN TRUE
END FUNCTION






#+
PUBLIC FUNCTION sadzi888_01_get_exp_para(p_gzda001)
   DEFINE p_gzda001         LIKE gzda_t.gzda001
   DEFINE l_gzda004         LIKE gzda_t.gzda004
   
   LET l_gzda004 = sadzi888_01_get_db_connect_string(p_gzda001)

   IF cl_null(l_gzda004) THEN
      RETURN FALSE
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#+ 
PUBLIC FUNCTION sadzi888_01_get_db_connect_string(p_gzda001)
   DEFINE p_gzda001         LIKE gzda_t.gzda001

   DEFINE l_errcode         STRING
   DEFINE l_gzda003         LIKE gzda_t.gzda003
   DEFINE l_gzda004         LIKE gzda_t.gzda004
   DEFINE l_gzda006         LIKE gzda_t.gzda006
   DEFINE l_gzda007         LIKE gzda_t.gzda007
   DEFINE l_db              STRING

   LET l_gzda004 = ""
   
   SELECT gzda003, gzda004, gzda006, gzda007 INTO l_gzda003, l_gzda004, l_gzda006, l_gzda007 
     FROM gzda_t
     WHERE gzda001 = p_gzda001

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "sel gzda_t:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "BREAK_ERROR-sel gzda_t:", cl_getmsg(l_errcode, g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN ""
   END IF

   IF cl_null(l_gzda004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00593"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "BREAK_ERROR:", cl_getmsg("adz-00593", g_lang)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN ""
   END IF

   IF NOT cl_db_test_connect(p_gzda001, l_gzda003, l_gzda004, l_gzda006, l_gzda007) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00594"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_gzda001 CLIPPED
      CALL cl_err()
      LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00594", g_lang, p_gzda001)
      CALL sadzi888_01_log_file_write(g_error_message)
      RETURN ""
   END IF
   
   LET l_gzda004 = cl_hashkey_base65_anti(l_gzda004)
   
   RETURN l_gzda004
END FUNCTION

#2016/04/22 - Begin -
#+ azzi933打包目錄處理
#FUNCTION sadzi888_01_append_file(ps_master001,ps_master013)
#   DEFINE ps_master001       LIKE type_t.chr50
#   DEFINE ps_master013       LIKE type_t.chr50
#   DEFINE ls_cmd             STRING
#   DEFINE li_cnt             LIKE type_t.num10 
#   DEFINE li_idx             LIKE type_t.num10
#   DEFINE ls_ddata005        LIKE dzld_t.dzld005
#   DEFINE ls_ddata006        LIKE dzld_t.dzld006
#   DEFINE ls_ddata008        LIKE dzld_t.dzld008
#   DEFINE ls_dfile           RECORD  
#          dfile001  LIKE dzlf_t.dzlf001,   #GUID
#          dfile002  LIKE type_t.num5,      #序號
#          dfile003  LIKE dzlf_t.dzlf003,   #路徑
#          dfile004  LIKE dzlf_t.dzlf004,   #類型
#          dfile005  LIKE dzlf_t.dzlf005,   #檔名
#          dfile006  LIKE dzlf_t.dzlf006,   #匯出狀態
#          dfile007  LIKE dzlf_t.dzlf007    #匯入狀態
#      END RECORD
#   DEFINE ls_mod             LIKE type_t.chr10
#   DEFINE l_sql              STRING 
#   DEFINE ls_source          STRING
#   DEFINE ls_ddata           RECORD  
#      ddata001       LIKE dzld_t.dzld001,   #GUID
#      ddata002       LIKE type_t.num5,      #序號
#      ddata003       LIKE dzld_t.dzld003,   #作業代號
#      ddata004       LIKE dzld_t.dzld004,   #匯入動作
#      ddata005       LIKE dzld_t.dzld005,   #維護作業
#      ddata006       LIKE dzld_t.dzld006,   #條件式1
#      ddata007       LIKE dzld_t.dzld007,   #條件式2
#      ddata008       LIKE dzld_t.dzld008,   #匯出狀態
#      ddata009       LIKE dzld_t.dzld009,   #匯入狀態
#      ddata010       LIKE dzld_t.dzld010,   #清單資料產生方式
#      ddata015       LIKE dzld_t.dzld015    #過單項目(m:單頭主項; d:單身子項)
#   END RECORD
#   DEFINE ls_gzte002 LIKE gzte_t.gzte002
#
#   #檢測是否有需夾帶檔案的設定資訊
#   #目前需此行為作業為:azzi933,azzi551,azzi553   
#   #SELECT COUNT(*) INTO li_cnt FROM adzi888_ddata 
#   # WHERE ddata001 = ps_master001
#   #   AND ddata005 IN ('azzi933','azzi551','azzi553') 
#   #   AND (ddata004 = '1' OR ddata004 = '2')
#   #IF li_cnt = 0 THEN
#   #   #若無則返回
#   #   RETURN 
#   #END IF 
#   
#   #撈取夾檔相關設定
#   #LET l_sql = " SELECT ddata005,ddata006,ddata008 ",
#   #            "   FROM adzi888_ddata",
#   #            "  WHERE ddata001 = ? ",
#   #            "    AND ddata005 IN ('azzi933','azzi551','azzi553') ",
#   #            "    AND (ddata004 = '1' OR ddata004 = '2') ",
#   #            "  ORDER BY ddata002 "
#   #            
#   #DECLARE sadzi888_01_append_file_cs CURSOR WITH HOLD FROM l_sql
#   
#   #取出ddata最大idx
#   LET li_idx = 0
#   SELECT * INTO ls_ddata.* FROM adzi888_ddata 
#   SELECT MAX(ddata002) INTO li_idx FROM adzi888_ddata 
#    WHERE ddata001 = ps_master001
#   LET li_idx = li_idx + 1
#   
#   #寫入ddata
#   LET l_sql = " INSERT INTO adzi888_dfile ",
#               " (dfile001,dfile002,dfile003,dfile004,dfile005,dfile006,dfile007)",
#               " VALUES (?,?,?,?,?,?,?)"
#               
#   DECLARE sadzi888_01_append_file_ins CURSOR WITH HOLD FROM l_sql
#   LET ls_dfile.dfile001 = ps_master001 #dfile001 GUID
#   LET ls_dfile.dfile006 = '0'          #dfile006 匯出狀態
#   LET ls_dfile.dfile007 = '0'          #dfile007 匯入狀態
#   
#   #寫入meomo檔案資料(標準環境才做)
#   IF g_run_mode = "3" AND g_alm_jb = g_dgenv_s THEN
#      LET ls_cmd = 'cp -r ',os.Path.join('/u6/scm', ps_master013)
#      LET ls_cmd = ls_cmd, ' ', os.Path.join(FGL_GETENV("TOP"), 't100_hotfix')
#      RUN ls_cmd
#      LET ls_dfile.dfile004 = 'd'   
#      LET ls_dfile.dfile002 = li_idx 
#      LET ls_dfile.dfile005 = ps_master013
#      LET ls_dfile.dfile003 = '$TOP/t100_hotfix'
#      LET ls_source = sadzp007_util_get_path(ls_dfile.dfile003 CLIPPED)
#      LET ls_source = os.Path.join(ls_source, ls_dfile.dfile005 CLIPPED)
#      IF os.Path.EXISTS(ls_source) THEN
#         DISPLAY "INFO:打包patch memo!"
#         EXECUTE sadzi888_01_append_file_ins USING ls_dfile.*
#         LET li_idx = li_idx + 1
#      ELSE
#         DISPLAY 'INFO:',ls_source,'不存在!'
#      END IF
#   END IF
#
#   #開始撈取相關資訊
#   #FOREACH sadzi888_01_append_file_cs USING ps_master001 INTO ls_ddata005,ls_ddata006,ls_ddata008
#   #   
#   #   CASE ls_ddata005
#   #      WHEN 'azzi933' 
#   #         #dfile004 類型(d:目錄,f:檔案)
#   #         LET ls_dfile.dfile004 = 'd'   
#   #         
#   #         #撈取模組
#   #         SELECT LOWER(gzzz005) INTO ls_mod FROM gzzz_t 
#   #          WHERE gzzz001 = ls_ddata006
#   #         IF SQLCA.sqlcode THEN
#   #
#   #         END IF
#   #
#   #         FOR g_lang_idx = 1 TO g_lang_list.getLength()
#   #         
#   #            #dfile002 序號
#   #            LET ls_dfile.dfile002 = li_idx
#   #            
#   #            #dfile005 檔名(作業名)
#   #            #LET ls_dfile.dfile005 = 'azzi933_help_en_US-',ls_ddata006 #2016/04/22
#   #            LET ls_dfile.dfile005 = ls_ddata006  #2016/04/22
#   #            
#   #            #dfile003 路徑
#   #            #LET ls_dfile.dfile003 = '$TOP/www/doc/erp/',ls_mod,'/en_US'
#   #            LET ls_dfile.dfile003 = '$TOP/www/doc/erp/',ls_mod,'/',g_lang_list[g_lang_idx]
#   #            
#   #            LET ls_source = sadzp007_util_get_path(ls_dfile.dfile003 CLIPPED)
#   #            LET ls_source = os.Path.join(ls_source, ls_ddata006 CLIPPED)
#   #            IF os.Path.EXISTS(ls_source) THEN
#   #               DISPLAY "INFO:產生azzi933 - ",ls_source, "打包目錄!"
#   #               EXECUTE sadzi888_01_append_file_ins USING ls_dfile.*
#   #               LET li_idx = li_idx + 1
#   #            ELSE
#   #               DISPLAY 'INFO:',ls_source,'不存在!'
#   #            END IF
#   #         
#   #         END FOR
#   #         
#   #      WHEN 'azzi551'
#   #      
#   #         #gzth_t表 ---------------------------------
#   #      
#   #         #dfile004 類型(d:目錄,f:檔案)
#   #         LET ls_dfile.dfile004 = 'f'  
#   #         
#   #         #dfile003 路徑
#   #         LET ls_dfile.dfile003 = '$TOP/www/doc/km/icon/'
#   #
#   #         #根據設定決定單筆或多筆寫入
#   #         IF NOT cl_null(ls_ddata008) THEN 
#   #            LET l_sql = " SELECT gzth006 FROM gzth_t ",
#   #                        "  WHERE gzth001 = ? AND gzth002 = ? ",
#   #                        "    AND gzth006 IS NOT NULL "
#   #            DECLARE sadzi888_01_azzi551_sel CURSOR WITH HOLD FROM l_sql
#   #            OPEN sadzi888_01_azzi551_sel USING ls_ddata008,ls_ddata006
#   #         ELSE
#   #            LET l_sql = " SELECT gzth006 FROM gzth_t ",
#   #                        "  WHERE gzth002 = ? ",
#   #                        "    AND gzth006 IS NOT NULL "
#   #            OPEN sadzi888_01_azzi551_sel USING ls_ddata006
#   #         END IF
#   #         
#   #         #dfile005 檔名(可能有多筆)
#   #         FOREACH sadzi888_01_azzi551_sel INTO ls_dfile.dfile005
#   #         
#   #            #dfile002 序號
#   #            LET ls_dfile.dfile002 = li_idx 
#   #
#   #            LET ls_source = sadzp007_util_get_path(ls_dfile.dfile003 CLIPPED)
#   #            LET ls_source = os.Path.join(ls_source, ls_dfile.dfile005 CLIPPED)
#   #            IF os.Path.EXISTS(ls_source) THEN
#   #               DISPLAY "INFO:產生azzi551 - ",ls_source, "打包檔案!"
#   #               EXECUTE sadzi888_01_append_file_ins USING ls_dfile.*
#   #               LET li_idx = li_idx + 1
#   #            ELSE 
#   #               DISPLAY 'INFO:',ls_source,'不存在!'
#   #            END IF
#   #         
#   #         END FOREACH
#   #         
#   #         #gzti_t表 ---------------------------------
#   #
#   #         #dfile004 類型(d:目錄,f:檔案)
#   #         LET ls_dfile.dfile004 = 'f'  
#   #
#   #         #根據設定決定單筆或多筆寫入
#   #         IF NOT cl_null(ls_ddata008) THEN 
#   #            LET l_sql = " SELECT gzti006 FROM gzti_t ",
#   #                        "  WHERE gzti001 = ? AND gzti002 = ? ",
#   #                        "    AND gzti006 IS NOT NULL "
#   #            DECLARE sadzi888_01_azzi551_sel2 CURSOR WITH HOLD FROM l_sql
#   #            OPEN sadzi888_01_azzi551_sel2 USING ls_ddata008,ls_ddata006
#   #         ELSE
#   #            LET l_sql = " SELECT gzti006 FROM gzti_t ",
#   #                        "  WHERE gzti002 = ? ",
#   #                        "    AND gzti006 IS NOT NULL "
#   #            OPEN sadzi888_01_azzi551_sel2 USING ls_ddata006
#   #         END IF
#   #         
#   #         #dfile005 檔名(可能有多筆)
#   #         FOREACH sadzi888_01_azzi551_sel2 INTO ls_dfile.dfile005
#   #         
#   #            FOR g_lang_idx = 1 TO g_lang_list.getLength()
#   #               #dfile002 序號
#   #               LET ls_dfile.dfile002 = li_idx 
#   #               
#   #               #dfile003 路徑
#   #               LET ls_dfile.dfile003 = '$TOP/www/doc/km/',g_lang_list[g_lang_idx]
#   #               
#   #               LET ls_source = sadzp007_util_get_path(ls_dfile.dfile003 CLIPPED)
#   #               LET ls_source = os.Path.join(ls_source, ls_dfile.dfile005 CLIPPED)
#   #               IF os.Path.EXISTS(ls_source) THEN
#   #                  DISPLAY "INFO:產生azzi551 - ",ls_source, "打包檔案!"
#   #                  EXECUTE sadzi888_01_append_file_ins USING ls_dfile.*
#   #                  LET li_idx = li_idx + 1
#   #               ELSE 
#   #                  DISPLAY 'INFO:',ls_source,'不存在!'
#   #               END IF
#   #            
#   #            END FOR
#   #            
#   #         END FOREACH
#   #         
#   #      WHEN 'azzi553'
#   #         #dfile004 類型(d:目錄,f:檔案)
#   #         LET ls_dfile.dfile004 = 'd'  
#   #        
#   #         SELECT gzte002 INTO ls_gzte002
#   #           FROM gzte_t WHERE gzte001 = ls_ddata006
#   #         
#   #         FOR g_lang_idx = 1 TO g_lang_list.getLength()
#   #         
#   #            #dfile003 路徑
#   #            LET ls_dfile.dfile003 = 
#   #                '$TOP/www/doc/erp/',ls_gzte002 ,'/',g_lang_list[g_lang_idx],'/APP/'
#   #            
#   #            #dfile002 序號
#   #            LET ls_dfile.dfile002 = li_idx 
#   #            
#   #            LET ls_source = sadzp007_util_get_path(ls_dfile.dfile003 CLIPPED)
#   #            LET ls_source = os.Path.join(ls_source, ls_dfile.dfile005 CLIPPED)
#   #            IF os.Path.EXISTS(ls_source) THEN
#   #               DISPLAY "INFO:產生azzi551 - ",ls_source, "打包檔案!"
#   #               EXECUTE sadzi888_01_append_file_ins USING ls_dfile.*
#   #               LET li_idx = li_idx + 1
#   #            ELSE 
#   #               DISPLAY 'INFO:',ls_source,'不存在!'
#   #            END IF
#   #            
#   #         END FOR
#   #
#   #   END CASE
#   #   
#   #END FOREACH
#   
#END FUNCTION
#2016/04/22 - End -


#2016/01/27
#取得解檔&folder名稱
#傳入 tar 指令
#傳出 成功否/目錄名稱 
FUNCTION sadzi888_01_tar_extract_and_get_folder(ps_cmd)
   DEFINE ps_cmd             STRING
   DEFINE l_channel          base.Channel
   DEFINE l_temp             STRING
   DEFINE l_folder           STRING
   DEFINE l_str              STRING
   DEFINE l_msg              STRING
    
   #解tgz檔並取得實際目錄名稱
   LET l_temp = NULL
   LET l_channel = base.Channel.create()
   CALL l_channel.setDelimiter("")
   CALL l_channel.openPipe(ps_cmd, "r")
   LET l_str = NULL
   WHILE l_channel.read(l_temp)
      #只取第一行資訊，為了取實際目錄名稱
      IF l_str IS NULL THEN
         LET l_str = l_temp.trim()
      END IF
      DISPLAY l_temp
      IF l_channel.isEof() THEN
         EXIT WHILE
      END IF
   END WHILE
   CALL l_channel.close()

   IF cl_null(l_str) OR l_str.getIndexOf(os.Path.separator(),1)=0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "azz-00792" # %1資料格式解析失敗
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  g_tar_path.trim()
      CALL cl_err()
      RETURN FALSE,''
   ELSE
      LET l_folder = l_str.subString(1,l_str.getIndexOf(os.Path.separator(),1)-1)
      IF NOT os.Path.isdirectory(l_folder) THEN
         LET l_msg = cl_replace_err_msg(cl_getmsg("azz-00792", g_lang), g_tar_path.trim()),ASCII 10,l_str,cl_getmsg("-20", g_lang) #並非目錄.
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00023"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_msg
         CALL cl_err()
         RETURN FALSE,''
      END IF
   END IF
   
   RETURN TRUE,l_folder
   
END FUNCTION 

#+ [source]匯出 160223-00028 add
PUBLIC FUNCTION sadzi888_01_export_source(p_pack_dir, p_folder)
   DEFINE p_pack_dir             STRING                #打包檔置放路徑
   DEFINE p_folder               STRING                #匯出檔所在目錄

   DEFINE l_dzye_d               type_g_dzye_d
   DEFINE l_cmd                  STRING
   DEFINE l_source               STRING
   DEFINE l_dest                 STRING
   DEFINE l_errcode              STRING
   DEFINE l_work_dir             STRING
   DEFINE l_tar_name             STRING
   DEFINE l_pack_dir             STRING
   DEFINE l_file                 STRING
   DEFINE l_sql                  STRING
   DEFINE l_success              LIKE type_t.chr1
   DEFINE l_source_folder        STRING,
          l_source_folder_path   STRING
   DEFINE l_type                 STRING,
          l_prog                 STRING,
          l_module               STRING,
          l_module_path          STRING
   DEFINE l_ddata_d              type_g_ddata_d

   #ex. p_pack_dir = "/ut/t10dit/tmp"
   #ex. p_folder = "02785-aiti001#19963"

   DISPLAY "copy tab/tgl/4gl/4fd file"

   LET l_source_folder = p_folder, "-source"
   LET l_tar_name = l_source_folder, ".tgz"

   #記錄目前程式執行路徑
   LET l_work_dir = os.Path.pwd()

   #切換至$TEMPDIR目錄下
   LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
   
   IF NOT os.Path.chdir(l_pack_dir) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_pack_dir.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_pack_dir.trim())
      RETURN FALSE
   END IF

   #建立[source]目錄並切進該目錄
   IF NOT sadzi888_01_make_pack_dir(l_source_folder, l_tar_name) THEN
      RETURN FALSE
   END IF
 
   #source完整路徑
   LET l_source_folder_path = os.path.JOIN(p_pack_dir,l_source_folder) 

   #從dzye找出程式清單
   LET l_sql = "SELECT DISTINCT dzye002,dzye003,dzye005",
               "  FROM tmp_dzye_t",
               " ORDER BY dzye002"
   DECLARE sadzi888_01_source_cs CURSOR WITH HOLD FROM l_sql
   FOREACH sadzi888_01_source_cs INTO l_dzye_d.dzye002, l_dzye_d.dzye003,l_dzye_d.dzye005
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzi888_01_source_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-FOREACH sadzi888_01_source_cs:", cl_getmsg(l_errcode, g_lang)
         RETURN FALSE
      END IF

      #copy 4gl/4fd  to /source
      LET l_prog = l_dzye_d.dzye002
      LET l_type = l_dzye_d.dzye003
      LET l_module = l_dzye_d.dzye005
      LET l_module_path = FGL_GETENV(UPSHIFT(l_module))       # $AIT= /u1/topprd/erp/ait

      #4fd
      IF l_type MATCHES "[SMFQ]" THEN #正向表列有4fd的所有類型
         LET l_source = os.path.JOIN(os.path.JOIN(l_module_path,"4fd"),l_prog||".4fd")  # /u1/topprd/erp/ait/4fd/aiti001.4fd
         IF NOT os.path.EXISTS(l_source) THEN #檢查存在否，預設就是一定得存在，若不存在:打包過程中讓它報錯!! 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "adz-00339"
            LET g_errparam.EXTEND = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_source.trim()
            CALL cl_err()
            IF gb_bak_mode THEN
               #do nothing # 自動備份模式下的匯出，允許無檔案，因為可能原本壞了，但是需要透過新匯入來些修復,此處擋掉就沒解了
            ELSE
              LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_source.trim())
              RETURN FALSE
            END IF
         ELSE
            LET l_cmd = "cp " ,l_source ," ."
            DISPLAY l_cmd
            RUN l_cmd
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00338"
               LET g_errparam.EXTEND = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_cmd
               CALL cl_err()
               LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00338", g_lang, l_cmd)
               RETURN FALSE
            END IF
         END IF
      END IF

      #tab/tgl/4gl
      IF l_type MATCHES "[SMZBWQGX]" THEN #正向表列有4gl的所有類型
         LET l_source = os.path.JOIN(os.path.JOIN(os.path.JOIN(l_module_path,"dzx"),"tab"),l_prog||".tab")  # /u1/topprd/erp/ait/dzx/tab/aiti001.tab
         IF NOT os.path.EXISTS(l_source) THEN #檢查存在否，預設就是一定得存在，不存在在打包過程中讓它報錯!! 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "adz-00339"
            LET g_errparam.EXTEND = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_source.trim()
            CALL cl_err()
            IF gb_bak_mode THEN
               #do nothing # 自動備份模式下的匯出，允許無檔案，因為可能原本壞了，但是需要透過新匯入來些修復,此處擋掉就沒解了
            ELSE
              LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_source.trim())
              RETURN FALSE
            END IF
         ELSE
            LET l_cmd = "cp " ,l_source ," ."
            DISPLAY "l_cmd=",l_cmd
            RUN l_cmd
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00338"
               LET g_errparam.EXTEND = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_cmd
               CALL cl_err()
               LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00338", g_lang, l_cmd)
               RETURN FALSE
            END IF
         END IF

         LET l_source = os.path.JOIN(os.path.JOIN(os.path.JOIN(l_module_path,"dzx"),"tgl"),l_prog||".tgl")  # /u1/topprd/erp/ait/dzx/tgl/aiti001.tgl
         IF NOT os.path.EXISTS(l_source) THEN #檢查存在否，預設就是一定得存在，不存在在打包過程中讓它報錯!! 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "adz-00339"
            LET g_errparam.EXTEND = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_source.trim()
            CALL cl_err()
            IF gb_bak_mode THEN
               #do nothing # 自動備份模式下的匯出，允許無檔案，因為可能原本壞了，但是需要透過新匯入來些修復,此處擋掉就沒解了
            ELSE
              LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_source.trim())
              RETURN FALSE
            END IF
         ELSE
            LET l_cmd = "cp " ,l_source ," ."
            DISPLAY "l_cmd=",l_cmd
            RUN l_cmd
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00338"
               LET g_errparam.EXTEND = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_cmd
               CALL cl_err()
               LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00338", g_lang, l_cmd)
               RETURN FALSE
            END IF
         END IF

         LET l_source = os.path.JOIN(os.path.JOIN(l_module_path,"4gl"),l_prog||".4gl")  # /u1/topprd/erp/ait/4gl/aiti001.4gl 
         IF NOT os.path.EXISTS(l_source) THEN #檢查存在否，預設就是一定得存在，不存在在打包過程中讓它報錯!! 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "adz-00339"
            LET g_errparam.EXTEND = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_source.trim()
            CALL cl_err()
            IF gb_bak_mode THEN
               #do nothing # 自動備份模式下的匯出，允許無檔案，因為可能原本壞了，但是需要透過新匯入來些修復,此處擋掉就沒解了
            ELSE
              LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_source.trim())
              RETURN FALSE
            END IF
         ELSE
            LET l_cmd = "cp " ,l_source ," ."
            DISPLAY "l_cmd=",l_cmd
            RUN l_cmd
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00338"
               LET g_errparam.EXTEND = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_cmd
               CALL cl_err()
               LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00338", g_lang, l_cmd)
               RETURN FALSE
            END IF
         END IF
      END IF
   END FOREACH

   #從adzi888_ddata找出qry清單
   LET l_sql = "SELECT DISTINCT ddata006",
               "  FROM adzi888_ddata ",
               " WHERE ddata005='adzi210'",
               " ORDER BY ddata006"
   DECLARE sadzi888_01_source_cs2 CURSOR WITH HOLD FROM l_sql
   FOREACH sadzi888_01_source_cs2 INTO l_ddata_d.ddata006
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzi888_01_source_cs2:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-FOREACH sadzi888_01_source_cs2:", cl_getmsg(l_errcode, g_lang)
         RETURN FALSE
      END IF

      LET l_prog = l_ddata_d.ddata006
      LET l_module = sadzp062_1_find_module(l_prog,"Q")
      LET l_module_path = FGL_GETENV(UPSHIFT(l_module))       # $AIT= /u1/topprd/erp/ait

      #4fd
      LET l_source = os.path.JOIN(os.path.JOIN(l_module_path,"4fd"),l_prog||".4fd")  # /u1/topprd/erp/ait/4fd/aiti001.4fd
      IF NOT os.path.EXISTS(l_source) THEN #檢查存在否，預設就是一定得存在，若不存在:打包過程中讓它報錯!! 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00339"
         LET g_errparam.EXTEND = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_source.trim()
         CALL cl_err()
         LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_source.trim())
         RETURN FALSE
      ELSE
         LET l_cmd = "cp " ,l_source ," ."
         DISPLAY l_cmd
         RUN l_cmd
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00338"
            LET g_errparam.EXTEND = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_cmd
            CALL cl_err()
            LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00338", g_lang, l_cmd)
            RETURN FALSE
         END IF
      END IF

      #4gl
      LET l_source = os.path.JOIN(os.path.JOIN(l_module_path,"4gl"),l_prog||".4gl")  # /u1/topprd/erp/ait/4gl/aiti001.4gl 
      IF NOT os.path.EXISTS(l_source) THEN #檢查存在否，預設就是一定得存在，不存在在打包過程中讓它報錯!! 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00339"
         LET g_errparam.EXTEND = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_source.trim()
         CALL cl_err()
         LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_source.trim())
         RETURN FALSE
      ELSE
         LET l_cmd = "cp " ,l_source ," ."
         DISPLAY "l_cmd=",l_cmd
         RUN l_cmd
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00338"
            LET g_errparam.EXTEND = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_cmd
            CALL cl_err()
            LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00338", g_lang, l_cmd)
            RETURN FALSE
         END IF
      END IF
   END FOREACH

   #返回上一層目錄,準備打包相關工具類檔案
   IF NOT os.Path.chdir(l_pack_dir) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_pack_dir.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_pack_dir.trim())
      RETURN FALSE
   END IF
   
   #切換回原打包路徑
   IF NOT os.Path.chdir(l_work_dir) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_work_dir.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_work_dir.trim())
      RETURN FALSE
   END IF

   #將source目錄cp 至原打包[需求單號/項次]目錄內
   LET l_cmd = "cp -r ", l_source_folder_path, " ."
   DISPLAY "l_cmd=",l_cmd
   RUN l_cmd

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "cp -r ", l_source_folder_path
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-cp -r ", l_source_folder_path, ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

#2016/08/23
FUNCTION sadzi888_01_get_patch_info()       
   DEFINE ls_memo_file      STRING            
   DEFINE ls_patch_num      LIKE type_t.chr50 
   DEFINE lt_file           TEXT              
   DEFINE lb_result         BOOLEAN           
   DEFINE lchannel_write    base.Channel
   DEFINE ls_js             STRING
   DEFINE ls_info_file      STRING
   DEFINE li_cnt            LIKE type_t.num5
   DEFINE ls_imp            LIKE type_t.chr20
   DEFINE li_exp            LIKE type_t.num5
   DEFINE li_imp            LIKE type_t.num5
   
   #info檔名稱
   LET ls_info_file = "patch.info"
   
   LOCATE lt_file IN FILE
   
   #先取patch號
   SELECT master002 INTO ls_patch_num
     FROM adzi888_master
   
   #打包才做
   IF g_run_mode = '1' OR g_run_mode = '3' OR
      g_run_mode = '5' OR g_run_mode = '7' OR
      g_run_mode = 'a' THEN
      
      #T100版本(目前固定1.0)
      LET g_patch_info.info001 = "1.0"
      
      #Patch包版本(目前也是1.0)
      LET g_patch_info.info002 = "1.0"
      
      #Oracle版本(exp)
      CALL sadzi888_06_get_tool_ver("exp") 
      RETURNING lb_result,g_patch_info.info003
      
      #Oracle版本(imp)
      CALL sadzi888_06_get_tool_ver("imp") 
      RETURNING lb_result,g_patch_info.info004
      
      #匯出環境資訊(FGL_ASIP)
      LET g_patch_info.info005 = FGL_GETENV("FGLASIP")
      
      #匯出環境資訊(行業別TOPIND)
      LET g_patch_info.info006 = FGL_GETENV("TOPIND")
      
      #區域名稱(ERPID)
      LET g_patch_info.info007 = FGL_GETENV("ERPID")
      
      #patch目的說明(for patch專用)
      IF g_run_mode = '3' THEN
         
         #取得路徑
         LET ls_memo_file = os.Path.join(g_patch_unl_path.trim(), ls_patch_num)
         LET ls_memo_file = os.Path.join(ls_memo_file.trim(), "memo.txt")
         
         #讀取檔案
         CALL lt_file.readFile(ls_memo_file)
         
         #填回值
         LET g_patch_info.info008 = lt_file
         
      END IF
      
      #prog DYNAMIC RECORD            
      #   prog001 LIKE type_t.chr1,   #是否解開section
      #   prog002 LIKE type_t.chr1,   #是否為freestyle
      #   prog003 LIKE type_t.chr5    #歸屬行業
      #END RECORD
      
      #準備寫入
      LET lchannel_write = base.Channel.create()
      CALL lchannel_write.setDelimiter("")
      CALL lchannel_write.openFile( ls_info_file, "w" )
      
      #準備好json並寫入
      LET ls_js = util.JSON.stringify(g_patch_info)
      CALL lchannel_write.write(ls_js)
      CALL lchannel_write.close()
   END IF
   
   #解包才做
   IF g_run_mode = '2' OR g_run_mode = '4' OR
      g_run_mode = '6' OR g_run_mode = 'b' THEN
      
      #檢查是否有info檔
      IF os.Path.EXISTS(ls_info_file) THEN
         CALL lt_file.readFile(ls_info_file)
         CALL util.JSON.parse(lt_file, g_patch_info)
         DISPLAY "info001:",g_patch_info.info001 
         DISPLAY "info002:",g_patch_info.info002 
         DISPLAY "info003:",g_patch_info.info003 
         DISPLAY "info004:",g_patch_info.info004 
         DISPLAY "info005:",g_patch_info.info005 
         DISPLAY "info006:",g_patch_info.info006 
         DISPLAY "info007:",g_patch_info.info007 
         DISPLAY "info008:",g_patch_info.info008 
         
         #exp,imp檢核
         CALL sadzi888_06_get_tool_ver("imp") 
         RETURNING lb_result,ls_imp
         LET li_exp = g_patch_info.info003[1,2] 
         LET li_imp = ls_imp[1,2]
         DISPLAY "匯出環境版本:",li_exp USING "<<<", "(",g_patch_info.info003,")"
         DISPLAY "匯入環境版本:",li_imp USING "<<<", "(",ls_imp,")"
         IF li_exp > li_imp THEN
            RETURN FALSE
         END IF
         
         #patch解包才做
         IF g_run_mode = '4' THEN
            #回寫dzyg_t
            LET li_cnt = 0
            SELECT COUNT(*) INTO li_cnt 
              FROM dzyg_t
             WHERE dzyg001 = ls_patch_num
            
            IF li_cnt > 0 THEN
               UPDATE ds.dzyg_t SET dzyg010 = g_patch_info.info008
                WHERE dzyg001 = ls_patch_num
            ELSE
               INSERT INTO ds.dzyg_t (dzyg001,dzyg010) 
                VALUES (ls_patch_num,g_patch_info.info008)
            END IF         
            
            IF SQLCA.sqlcode THEN
               DISPLAY 'WARRING:回寫patch包(dzyg)資訊失敗!'
            END IF
         END IF
          
      END IF
   END IF
   
   RETURN TRUE

END FUNCTION 
