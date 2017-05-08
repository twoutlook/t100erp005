#2016-08-29 temp table變數定義更換&drop table資源釋放
#2016-10-12 by ka0132 取消自身運行檢查, 僅由呼叫方控卡
#2016-10-27 遇到客戶已解開Section程式不做Section刪除
#           檢查drop表動作是否落實
#           訊息修改
#2016-11-11 topstd判斷調整
#2016-12-13 增加-v功能, 確認該adp保留是否為重要!(暫不做)
#2016-01-04 抄寫topstd保留資訊
#2016-01-10 排除不存在的adp問題(客戶家有/產中無)
#2016-01-20 topstd時間與產中相同,不做保留


#版本資訊需連同修改

IMPORT os
IMPORT security
IMPORT util

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../adz/4gl/adzi888_global.inc"
DEFINE g_package         STRING
DEFINE g_channel         base.Channel
DEFINE g_topstd_channel  base.Channel #2016-11-11
#patch 單頭 type 宣告
DEFINE g_patch_m   RECORD
       patch001    LIKE type_t.chr50,   #GUID
       patch002    LIKE type_t.chr50,   #patch包
       patch003    LIKE type_t.chr100,  #patch包所在路徑
       patch006    LIKE type_t.chr100   #patch包所在路徑 
       END RECORD
DEFINE g_merge     LIKE type_t.chr1
DEFINE g_msg       LIKE type_t.chr500
DEFINE ga_cust     DYNAMIC ARRAY OF STRING
DEFINE g_start_time          DATETIME YEAR TO SECOND           #patch import 起始時間 
DEFINE g_merge_time          DATETIME YEAR TO SECOND           #patch merge  起始時間 
DEFINE g_finish_time         DATETIME YEAR TO SECOND           #patch        結束時間 

MAIN
   DEFINE ls_path STRING
   DEFINE ls_pack_dir  STRING 
   DEFINE l_log        STRING
   DEFINE l_log_topstd STRING #2016-11-11
   DEFINE l_str        STRING
   DEFINE lc_gzda004   LIKE gzda_t.gzda004
   DEFINE ls_db_user   LIKE type_t.chr50
   DEFINE ls_sql       STRING
   DEFINE ls_time      STRING

   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
   
   #2016/12/13
   IF ARG_VAL(2) = "-v" OR ARG_VAL(2) = "-version" THEN
      CALL adzp888_version()
      EXIT PROGRAM
   END IF
   #2016/12/13
   
   #切換至資料庫dspatch
   CALL cl_tool_init()
   CALL cl_db_connect("dspatch", FALSE)

   #for test
   #2016-11-11 已完成imp,取得ds較新的程式清單, 並處理topstd adp
   #IF adzp888_for_newer_prog() THEN
   #
   #END IF
   #IF adzp888_for_topstd() THEN
   #
   #END IF
   ##2016-11-11
   #EXIT PROGRAM
   
   #路徑(patch包) 
   LET ls_path = ARG_VAL(2)
   IF cl_null(ls_path) THEN
      #DISPLAY "ERROR:請輸入patch包路徑!"
      DISPLAY "\n" 
      DISPLAY "Usage:r.r adzp888 patch-source.tgz" 
      DISPLAY "   Ex:r.r adzp888 /ut/tmp/A000000424.tgz" 
      EXIT PROGRAM
   END IF

   #特別模式(drop table)
   IF ls_path = "drop" THEN
      LET g_msg = "INFO:特別模式-drop dspatch開始"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      IF NOT adzp888_drop_dspatch() THEN
         LET g_msg = "WARNING:drop dspatch失敗!"
         DISPLAY g_msg
      ELSE
         LET g_msg = "INFO:drop dspatch完成!"
         DISPLAY g_msg 
      END IF
      CALL adzp888_log_file_write(g_msg)
      EXIT PROGRAM
   END IF

   ##2016/10/12
   #先檢查是否有其他adzp888正在執行
   #IF adzp888_chk_run() THEN
   #   DISPLAY "BREAK_ERROR:已有其他adzp888正在運行中!"
   #   EXIT PROGRAM
   #END IF
   ##2016/10/12
   
   SELECT SYS_CONTEXT ('USERENV', 'SESSION_USER') INTO ls_db_user FROM DUAL
   IF ls_db_user <> 'DSPATCH' THEN 
      LET g_msg = "BREAK_ERROR:連線到DSPATCH失敗!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      EXIT PROGRAM
   END IF
    
   #dspatch密碼
   LET g_patch_pwd = ARG_VAL(3)
   
   #是否merge客製程式
   #LET g_merge = ARG_VAL(4) 
   #IF cl_null(g_merge) OR g_merge <> 'Y' THEN
   #   LET g_merge = 'N' #預設為N (不要merge)
   #END IF
   LET g_merge = 'Y'
   
   #若無給則採用azzi085設定
   IF cl_null(g_patch_pwd) THEN
      SELECT gzda004
        INTO lc_gzda004
        FROM ds.gzda_t
       WHERE gzda001 = 'dspatch'
      LET g_patch_pwd = cl_hashkey_base65_anti(lc_gzda004)
      LET g_msg = "INFO:無輸入dspatch密碼,將採用azzi085設定值!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
   END IF
   
   #給予參數預設值
   LET g_patch_mode = TRUE
   LET g_unload_file = FALSE 
   
   #log宣告
   LET g_channel        = base.Channel.create()
   LET g_topstd_channel = base.Channel.create() #2016-11-11
   LET ls_time = cl_get_current()
   LET ls_time = cl_str_replace(ls_time,' ','')
   LET ls_time = cl_str_replace(ls_time,':','')
   LET ls_time = cl_str_replace(ls_time,'-','')
   
   #2016-11-11
   LET l_log_topstd = 'patch-topstd-',ls_time,'-adzp888.log'
   LET l_log_topstd = os.Path.join(FGL_GETENV(g_pack_dir_env),l_log_topstd)
   CALL g_topstd_channel.openFile(l_log_topstd, "w")
   CALL g_topstd_channel.setDelimiter("")
   #2016-11-11
   
   LET l_log = 'patch-',ls_time,'-adzp888.log'
   LET l_log = os.Path.join(FGL_GETENV(g_pack_dir_env),l_log)
   CALL g_channel.openFile(l_log, "w")
   CALL g_channel.setDelimiter("")
   LET l_str =  'INFO:Patch包位址為',ARG_VAL(2)
   CALL adzp888_topstd_log_file_write(l_str)
   #LET l_str =  'INFO:是否merge ',ARG_VAL(4)
   #CALL adzp888_topstd_log_file_write(l_str)
   
   #Create temp table
   LET g_start_time = cl_get_current()
   LET l_str = "INFO:程式初始化!開始時間:",cl_get_current()
   CALL adzp888_log_file_write(l_str)
   CALL adzp888_init()
   LET l_str = "INFO:程式初始化完成!結束時間:",cl_get_current()
   CALL adzp888_log_file_write(l_str)
   
   #load temp table
   LET l_str = "INFO:建立暫存表!開始時間:",cl_get_current()
   CALL adzp888_log_file_write(l_str)
   IF NOT adzp888_temp_table_pre(ls_path) THEN
      CALL adzp888_exit(FALSE)
   END IF
   LET l_str = "INFO:暫存表建立完成!結束時間:",cl_get_current()
   CALL adzp888_log_file_write(l_str)
   
   #load patch資訊
   SELECT master001, master002
     INTO g_patch_m.patch001, g_patch_m.patch002
     FROM adzi888_master
   LET g_patch_m.patch006 = ls_path
   
   #2016-01-04
   #先清空dzbi_t
   #DELETE FROM ds.dzbi_t
   # WHERE dzbi005 = g_patch_m.patch002
   #IF SQLCA.sqlcode THEN
   #   LET g_msg = "ERROR(",SQLCA.sqlcode,"):Can't delete dzbi_t!"
   #   DISPLAY g_msg
   #   CALL adzp888_log_file_write(g_msg)
   #   EXIT PROGRAM
   #END IF
   #DISPLAY "INFO:Delete dzbi_t where dzbi005 = ",g_patch_m.patch002
   #2016-01-04
     
   #drop&imp dspatch data
   LET l_str = "INFO:更新dspatch並讀入設計資料!開始時間:",cl_get_current()
   CALL adzp888_log_file_write(l_str)
   LET ls_pack_dir = FGL_GETENV(g_pack_dir_env)
   LET ls_path = os.Path.join(ls_pack_dir,g_package)
   IF NOT adzp888_import_patch_pre(g_patch_m.patch001,g_patch_m.patch006) THEN
      LET l_str = "INFO:更新dspatch失敗!結束時間:",cl_get_current() 
      CALL adzp888_log_file_write(l_str)
      CALL adzp888_exit(FALSE)
   ELSE
      LET l_str = "INFO:更新dspatch完成!結束時間:",cl_get_current()
      CALL adzp888_log_file_write(l_str)
   END IF
   CALL adzp888_update_dzyg('import')
   
   #merge
   LET g_merge_time = cl_get_current()
   LET l_str = "INFO:開始Merge!開始時間:",cl_get_current()
   CALL adzp888_log_file_write(l_str)
   IF adzp888_merge_data_batch_pre(g_patch_m.patch001) THEN
      LET l_str = "INFO:Merge完成!結束時間:",cl_get_current()
      CALL adzp888_log_file_write(l_str)
   ELSE
      LET l_str = "INFO:Merge失敗!結束時間:",cl_get_current()
      CALL adzp888_log_file_write(l_str)
      CALL adzp888_exit(FALSE)
   END IF 
   CALL adzp888_update_dzyg('merge')
   
   #drop dspatch (事後清除)
   IF NOT adzp888_drop_dspatch() THEN
      LET g_msg = "WARNING:drop dspatch失敗!"
   ELSE
      LET g_msg = "INFO:drop dspatch完成!"
   END IF
   DISPLAY g_msg
   CALL adzp888_log_file_write(g_msg)
   
   LET g_finish_time = cl_get_current()
   LET l_str = "INFO:執行結束!結束時間:",cl_get_current()
   CALL adzp888_log_file_write(l_str)
   
   LET g_msg = 'Info:log檔位置-',l_log
   DISPLAY g_msg
   CALL adzp888_log_file_write(g_msg)
   
   LET g_msg = 'Info:log(topstd)檔位置-',l_log_topstd #2016-11-11
   CALL adzp888_topstd_log_file_write(g_msg)
   
   LET l_str = 'Info:import花費時間-',g_merge_time - g_start_time
   DISPLAY l_str
   CALL adzp888_log_file_write(l_str)
   LET l_str =  'Info:merge花費時間-',g_finish_time - g_merge_time
   DISPLAY l_str
   CALL adzp888_log_file_write(l_str)
   LET l_str =  'Info:總花費時間-',g_finish_time - g_start_time
   DISPLAY l_str
   CALL adzp888_log_file_write(l_str)
   
   CALL adzp888_exit(TRUE)
   
END MAIN
  
#+ 定義temp table
FUNCTION adzp888_init()
   DEFINE l_sql STRING
      
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
      LET g_msg = "ERROR(",SQLCA.sqlcode,"):Can't create temp table adzi888_master!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      EXIT PROGRAM
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
      LET g_msg = "ERROR(",SQLCA.sqlcode,"):Can't create temp table adzi888_ddata!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      EXIT PROGRAM
   END IF
    
   ##取得[匯入動作為1:Merge or 2:Insert]取得所有相關註冊資訊清單
   #LET l_sql = "SELECT ddata002, ddata003, ddata004, ddata005, ddata006, ",
   #            "       ddata007, ddata008, ddata009, ddata010, ddata015 ",
   #            "  FROM adzi888_ddata LEFT JOIN adzi888_master ON ddata001 = master001 ",
   #            #"  FROM adzi888_ddata ",
   #            "  WHERE ddata001 = ? ",
   #            "    AND (ddata004 = '1' OR ddata004 = '2') ",
   #            "  ORDER BY ddata002 "
   #DECLARE adzi888_ddata_exp_cs CURSOR WITH HOLD FROM l_sql
   #
   ##取得相關註冊維護作業[資料表代碼]清單
   #LET l_sql = "SELECT dzyb001, dzyb002, dzyb003, dzyb004, dzyb005, ",
   #            "       dzyb006, dzyb007, dzyb008, dzyb009, ",
   #            "       dzyc002, dzyc003, dzyc004, dzyc005 ",
   #            "  FROM dzyb_t LEFT JOIN dzyc_t ON dzyb002 = dzyc001 ",
   #            "  WHERE dzyb001 = ? ",
   #            "  ORDER BY dzyb003 DESC "
   #DECLARE adzp888_dzyb_desc_cs CURSOR WITH HOLD FROM l_sql
   
END FUNCTION

#+ patch包匯入前置作業
PRIVATE FUNCTION adzp888_import_patch_pre(ps_master001,ps_patch_path)
   DEFINE ps_patch_path     CHAR(1000)  #打包檔置放路徑
   DEFINE ps_master001      STRING      #GUID
   DEFINE l_pack_dir        STRING      #打包檔置放路徑
   DEFINE l_cmd             STRING
   DEFINE l_result          BOOLEAN
   DEFINE l_error_message   STRING
   DEFINE l_folder          STRING               #匯出檔目錄
   DEFINE l_tar_name        STRING               #匯出包名稱
   DEFINE l_cnt             LIKE type_t.num5

   #檢查是否重複執行patch包匯入
   LET l_cnt = 0
   #SELECT COUNT(*) INTO l_cnt FROM dzye_t WHERE dzye001 = g_patch_m.patch002
   #
   #IF l_cnt > 0 THEN
   #
   #   #刪除已保存的patch記錄(dzye_t)
   #   DELETE FROM dzye_t WHERE dzye001 = g_patch_m.patch002
   #   
   #   IF SQLCA.sqlcode THEN
   #      DISPLAY "刪除dzye資料失敗!"
   #      RETURN
   #   END IF
   #END IF
   
   #切換路徑至patch包解包的所在路徑
   #LET l_pack_dir = os.Path.dirname(FGL_GETENV("TEMPDIR"))
   LET l_pack_dir = FGL_GETENV("TEMPDIR")
   LET g_msg = 'INFO:切換至解包路徑(',FGL_GETENV("TEMPDIR"),')!'
   DISPLAY g_msg
   CALL adzp888_log_file_write(g_msg)
   
   CALL adzp888_change_pack_dir(l_pack_dir)

   CALL adzp888_get_pack_name(ps_patch_path)
      RETURNING l_result, l_tar_name, l_folder

   IF NOT l_result THEN
      RETURN FALSE
   END IF
   
   #檢查目錄是否存在,準備讀取匯入檔
   #IF (NOT os.Path.EXISTS(l_folder)) OR (NOT os.Path.chdir(l_folder)) THEN
   IF NOT os.Path.EXISTS(l_folder) THEN
      LET g_msg = "ERROR:檢查",l_folder,"檔案不存在!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE
   END IF

   LET g_batch_flag = TRUE
   LET g_patch_mode = TRUE
   LET g_unload_file = FALSE     #是否在export data過程中UNLOAD TO FILE
   
   #是否先import dspatch dmp檔
   LET g_import_dapatch = ""

   #drop dspatch 
   IF NOT adzp888_drop_dspatch() THEN
      LET g_msg = "ERROR:drop dspatch失敗!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE
   END IF
   #只有當g_import_dapatch="N"時,才不做import dspatch的動作
   #IF g_batch_flag AND (cl_null(g_import_dapatch) OR g_import_dapatch <> "N") THEN
   #   #先清空dspatch的所有table
   #   LET l_cmd = "emptydspatch.sh Y "
   #   DISPLAY l_cmd
   #   RUN l_cmd
   #
   #   IF STATUS THEN
   #      DISPLAY "ERROR:執行emptydspatch.sh失敗!"
   #      RETURN
   #   END IF
   #
   #END IF

   #執行patch包匯入
   CALL adzp888_import_patch(l_pack_dir, l_folder)
      RETURNING l_result, l_error_message
      
   IF l_result THEN
      LET g_msg = "patch_import_success."
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
   ELSE
      LET g_msg = "adzp888 BREAK_ERROR:", l_error_message
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE
   END IF

   #已完成patch,重新取得patch後資訊
   #LET g_finish_flag = TRUE
   #DELETE FROM tmp_dzye_t WHERE 1 = 1
   #INSERT INTO tmp_dzye_t SELECT * FROM dzye_t WHERE dzye001 = ps_patch_path
   #
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = "INSERT TEMP tmp_dzye_t:"
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #END IF
   
   #刪除目錄
   #LET l_cmd = os.Path.join(l_pack_dir.trim(), l_folder.trim())
   #IF os.Path.EXISTS(l_cmd) THEN
   #   LET l_cmd = "rm -rf ", l_cmd
   #   RUN l_cmd
   #END IF
   
   RETURN TRUE
   
END FUNCTION

#+ patch包匯入作業
PRIVATE FUNCTION adzp888_import_patch(p_pack_dir, p_folder)
   DEFINE p_pack_dir        STRING               #打包檔置放路徑
   DEFINE p_folder          STRING               #匯出檔目錄
   
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_str             STRING
   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_cmd             STRING
   DEFINE l_temp            STRING
   
   LET g_show_msg = "Y"     #前景UI模式操作
   #LET g_gen42s_flag = TRUE
   #LET g_patch007_t = g_patch_m.patch007

   #patch模式下,一律不做產生42s動作
   #IF g_patch_mode AND (g_patch_m.patch007 = "N") THEN
   #   LET g_gen42s_flag = FALSE
   #END IF

   #開始記錄匯入log
   #CALL adzp888_log_file_start(g_run_mode, g_patch_m.patch002)

   #[設定資訊]+[設計資料]匯入作業(含進行Merge程序)
   IF NOT adzp888_import(g_patch_m.patch001, "", "", p_pack_dir, p_folder) THEN
      LET g_msg = "adzp888_import is error."
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE, g_error_message
   END IF
   
   RETURN TRUE, ""
END FUNCTION

#+ 切換工作路徑到製造匯出檔的工作目錄下
PUBLIC FUNCTION adzp888_change_pack_dir(p_pack_dir)
   DEFINE p_pack_dir        STRING     #打包檔置放路徑
   
   #切換目錄
   IF NOT os.Path.chdir(p_pack_dir) THEN
      LET g_msg = "ERROR:Can't chdir to ",p_pack_dir,"!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      EXIT PROGRAM
   END IF
   
END FUNCTION


#+ [patch資料]預先準備temp table相關資料
PUBLIC FUNCTION adzp888_temp_table_pre(ps_path)
   DEFINE ps_path    STRING
   DEFINE l_pack_dir STRING #打包檔置放路徑
   DEFINE l_src      STRING #來源文件
   DEFINE l_dst      STRING #目的
   DEFINE l_work_dir STRING #目前程式執行路徑
   DEFINE l_folder   STRING #匯出檔目錄
   DEFINE l_tar_name STRING #匯出包名稱
   DEFINE l_idx             LIKE type_t.num5
   DEFINE l_cmd             STRING
   DEFINE l_sql             STRING
   DEFINE l_file            STRING
   
   #檢查tar是否存在
   IF NOT os.Path.EXISTS(ps_path) THEN
      LET g_msg = "ERROR:",ps_path," is not exists!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   #切換到$TEMPDIR工作目錄下
   LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
   CALL adzp888_change_pack_dir(l_pack_dir)

   #取得tar檔案名稱
   LET l_tar_name = os.Path.basename(ps_path.trim())

   #取得匯出檔的目錄名稱
   LET l_idx = l_tar_name.getIndexOf(".tgz", 1)
   IF l_idx > 1 THEN
      LET l_folder = l_tar_name.subString(1, l_idx - 1)
   END IF

   IF adzp888_is_null(l_tar_name) OR adzp888_is_null(l_folder) THEN
      LET g_msg = "ERROR:Can't find tar file!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE
   END IF

   #檢查目錄是否存在
   IF os.Path.EXISTS(l_folder) THEN
      #刪除目錄
      LET l_cmd = "rm -rf ", l_folder
      RUN l_cmd
   END IF
   
   #解包成tar檔範例:tar xvf $FOLDER.tgz
   LET l_cmd = "tar zxvf ", ps_path.trim()
   RUN l_cmd
   
   #匯入[程式註冊資料匯出主檔]
   LET g_package = l_folder
   LET l_file = os.Path.join(l_folder.trim(), "Temp-adzi888_master.unl")
   LET l_sql = "INSERT INTO adzi888_master "
   LOAD FROM l_file l_sql
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR:Can't load file to adzi888_master!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   #匯入[設計資料匯出清單]
   LET l_file =  os.Path.join(l_folder.trim(), "Temp-adzi888_ddata.unl")
   LET l_sql = "INSERT INTO adzi888_ddata "
   LOAD FROM l_file l_sql
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR:Can't load file to adzi888_ddata!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   #切換目錄
   CALL adzp888_change_pack_dir(l_folder.trim())
   
   RETURN TRUE
   
END FUNCTION
 
#+ [patch資料]整批匯入採取MERGE方式的前置作業
PUBLIC FUNCTION adzp888_merge_data_batch_pre(p_master001)
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
   
   #取得所有相關註冊資訊資料清單
   LET l_sql = "SELECT ddata002, ddata003, ddata004, ddata005, ddata006, ",
               "       ddata007, ddata008, ddata009, ddata010, ddata015 ",
               "  FROM adzi888_ddata LEFT JOIN adzi888_master ON ddata001 = master001 ",
               "  WHERE ddata001 = ? ",
               "  ORDER BY ddata002 "
               
   DECLARE adzi888_ddata_imp_cs CURSOR WITH HOLD FROM l_sql
   LET l_sql = "SELECT dzyb001, dzyb002, dzyb003, dzyb004, dzyb005, ",
               "       dzyb006, dzyb007, dzyb008, dzyb009, ",
               "       dzyc002, dzyc003, dzyc004, dzyc005 ",
               "  FROM ds.dzyb_t LEFT JOIN ds.dzyc_t ON dzyb002 = dzyc001 ",
               "  WHERE dzyb001 = ? ",
               "  ORDER BY dzyb003 ASC "
               
   DECLARE adzp888_dzyb_asc_cs CURSOR WITH HOLD FROM l_sql
   
   #取得此次patch summary file
   CALL adzp888_get_summary_file()
      RETURNING l_success, l_table_list_json

   IF NOT l_success THEN
      LET g_msg = 'ERROR:無法取得list清單!'
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   BEGIN WORK

   #進度列控制
   #IF g_adzp888_s01 IS NOT NULL AND g_adzp888_s01 THEN
   #   #CALL zzzp999_01_refresh_tasks_progressbar(gc_del_data, "zzz-00609")
   #END IF

   #先進行整批刪除patch要import的資料
   #IF NOT adzp888_delete_data_batch(p_master001) THEN
   IF NOT adzp888_delete_data_batch(p_master001) THEN
      RETURN FALSE
   END IF

   LET l_cnt = l_table_list_json.getLength()
   
   FOR l_i = 1 TO l_table_list_json.getLength()
      LET l_table_temp = ""

      #取得資料表代碼與summary file檔名
      LET l_sys_dzyb002 = l_table_list_json.name(l_i)
      LET l_dspatch_dzyb002 = l_table_list_json.get(l_sys_dzyb002)

      IF adzp888_is_null(l_sys_dzyb002) OR adzp888_is_null(l_dspatch_dzyb002) THEN
         #LET g_error_message = "BREAK_ERROR-", cl_getmsg_parm("zzz-00385", g_lang, l_sys_dzyb002 CLIPPED || "." || l_dspatch_dzyb002 CLIPPED)
         LET g_error_message = "BREAK_ERROR-無法取得資料表代碼與summary file檔名!"
         DISPLAY g_error_message
         CALL adzp888_log_file_write(g_error_message)
         ROLLBACK WORK
         RETURN FALSE
      END IF
      
      #patch[資料]整批匯入
      IF NOT adzp888_merge_data_batch(l_sys_dzyb002, l_dspatch_dzyb002) THEN
         ROLLBACK WORK
         RETURN FALSE
      END IF
      
   END FOR
   
   COMMIT WORK

   RETURN TRUE
   
END FUNCTION

#+ 註冊資訊[資料]整批刪除
PUBLIC FUNCTION adzp888_delete_data_batch(p_master001)
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
   DEFINE li_cnt            LIKE type_t.num10
   
   LET l_prog_num = 0

   LET l_str = "delete_data_batch:"
   CALL adzp888_log_file_write(l_str)
   
   SELECT COUNT(*) INTO l_prog_cnt FROM adzi888_ddata
     WHERE ddata001 = p_master001

   #找出所有需匯入處理的註冊資訊清單
   FOREACH adzi888_ddata_imp_cs USING p_master001
                                    INTO l_pack_ddata.ddata002, l_pack_ddata.ddata003, l_pack_ddata.ddata004, l_pack_ddata.ddata005, l_pack_ddata.ddata006,  
                                         l_pack_ddata.ddata007, l_pack_ddata.ddata008, l_pack_ddata.ddata009, l_pack_ddata.ddata010, l_pack_ddata.ddata015
      LET g_msg = "INFO:開始處理設定, 作業 ",l_pack_ddata.ddata005," - ",l_pack_ddata.ddata006 
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      
      IF SQLCA.sqlcode THEN
         #LET g_error_message = "BREAK_ERROR-FOREACH delete_data.adzi888_ddata_imp_cs:", cl_getmsg(l_errcode, g_lang)
         LET g_error_message = "BREAK_ERROR-FOREACH delete_data.adzi888_ddata_imp_cs:發生異常,錯誤代代碼-",SQLCA.sqlcode
         DISPLAY g_error_message
         CALL adzp888_log_file_write(g_error_message)
         RETURN FALSE
      END IF

      #DISPLAY "ddata002:", l_pack_ddata.ddata002 USING "<<<<<", "---ddata005:", l_pack_ddata.ddata005 CLIPPED
      
      #進度列控制
      LET l_prog_num = l_prog_num + 1
      #IF g_adzp888_s01 IS NOT NULL AND g_adzp888_s01 THEN
      #   CALL zzzp999_01_refresh_sub_tasks_progressbar(l_prog_num, l_prog_cnt)
      #END IF
      
      LET l_str = ASCII 10, "####################", ASCII 10
      LET l_str = l_str, "ddata002: ", l_pack_ddata.ddata002 USING "<<<<<", "; "
      LET l_str = l_str, "ddata003: ", l_pack_ddata.ddata003 CLIPPED, "; "
      LET l_str = l_str, "ddata005: ", l_pack_ddata.ddata005 CLIPPED, "; "
      LET l_str = l_str, "ddata006: ", l_pack_ddata.ddata006 CLIPPED, "; "
      LET l_str = l_str, "ddata007: ", l_pack_ddata.ddata007 CLIPPED, "; "
      CALL adzp888_log_file_write(l_str)

      #2016-11-11 判斷程式是否較新, 若較新則不刪除ds資料
      IF l_pack_ddata.ddata005 = 'design_data'THEN
         LET li_cnt = 0
         SELECT COUNT(*) INTO li_cnt
           FROM dspatch.client_newer  
          WHERE prog_name = l_pack_ddata.ddata006
          IF li_cnt > 0 THEN
             LET l_str = "INFO:",l_pack_ddata.ddata006,"版本較新,不進行更新!"
             CALL adzp888_topstd_log_file_write(l_str)
             CONTINUE FOREACH
          END IF
      END IF
      #2016-11-11
      
      #IF l_pack_ddata.ddata005 = 'design_data' AND g_merge = "N" THEN
      #   LET li_cnt = 0
      #   SELECT COUNT(*) INTO li_cnt
      #     FROM ds.dzaf_t  
      #    WHERE dzaf010='c' AND dzaf001 = l_pack_ddata.ddata006
      #    IF li_cnt > 0 THEN
      #       LET l_str = "INFO:",l_pack_ddata.ddata006,"已客製,不進行merge!"
      #       CALL adzp888_log_file_write(l_str)
      #       CONTINUE FOREACH
      #    END IF
      #END IF
      
      #取得該註冊資訊維護作業[資料表代碼]清單
      FOREACH adzp888_dzyb_asc_cs USING l_pack_ddata.ddata005
                                      INTO l_pack_dzyb.dzyb001, l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb005, 
                                           l_pack_dzyb.dzyb006, l_pack_dzyb.dzyb007, l_pack_dzyb.dzyb008, l_pack_dzyb.dzyb009, 
                                           l_pack_dzyb.dzyc002, l_pack_dzyb.dzyc003, l_pack_dzyb.dzyc004, l_pack_dzyb.dzyc005 
         IF SQLCA.sqlcode THEN
            #LET g_error_message = "BREAK_ERROR-FOREACH delete_data.adzp888_dzyb_asc_cs.", l_pack_ddata.ddata005 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            LET g_error_message = "BREAK_ERROR-FOREACH delete_data.adzp888_dzyb_asc_cs.", l_pack_ddata.ddata005 CLIPPED, ":錯誤代碼為-",SQLCA.sqlcode
            DISPLAY g_error_message
            CALL adzp888_log_file_write(g_error_message)
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
         IF l_pack_ddata.ddata015 = "d" AND adzp888_is_null(l_pack_dzyb.dzyb008) THEN
            CONTINUE FOREACH
         END IF
         
         #為merge或insert型式時,先檢查資料匯入檔案是否存在,是否有資料需匯入
         IF l_pack_ddata.ddata004 = "1" OR l_pack_ddata.ddata004 = "2" THEN
            #依export data過程中是否啟動unload to file mode
            IF adzp888_is_null(g_unload_file) OR g_unload_file THEN            
               LET l_file = l_pack_ddata.ddata002 USING "<<<<<", "-", l_pack_dzyb.dzyb002 CLIPPED, ".unl"
            
               IF NOT os.Path.EXISTS(l_file) THEN
                  #LET g_error_message = "ERROR:", cl_getmsg_parm("zzz-00339", g_lang, l_file.trim())
                  LET g_error_message = "ERROR:檔案不存在-",l_file.trim()
                  DISPLAY g_error_message
                  CALL adzp888_log_file_write(g_error_message)
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
                  IF NOT adzp888_is_null(l_pack_dzyb.dzyc004) THEN
                     LET l_sub_sql = adzp888_str_replace(l_pack_dzyb.dzyc004, "dest.", "") 
                     LET l_sub_sql = adzp888_str_replace(l_sub_sql, "ds.", "") 
                     LET l_wc = l_wc, " AND ", l_sub_sql.trim()

                     #XG patch規則異動:gzgf004和gzgf005是default的資料才可進行patch異動                                                                                                                                                
                     #(參考2015/1/28 XG上Patch的規則異動mail)                                                                                                                                                                   
                     IF l_pack_dzyb.dzyb002 = "gzgf_t" AND g_patch_mode THEN                                                                                                                                                              
                       LET l_wc = l_wc, "  AND gzgf004 = 'default' AND gzgf005 = 'default' ",
                                        "  AND (gzgf001, gzgf002, gzgf003, gzgf004, gzgf005) ", 
                                        "   IN (SELECT gzgf001, gzgf002, gzgf003, gzgf004, gzgf005 ",
                                        "         FROM ", g_patch_schema CLIPPED, ".gzgf_t WHERE gzgf001 = '", l_pack_ddata.ddata006 CLIPPED, "')"
                     END IF    
                  END IF
               ELSE
                  LET l_sub_sql = "SELECT gzgf000 FROM ds.gzgf_t ", 
                                  "  WHERE gzgf001 = '", l_pack_ddata.ddata006 CLIPPED, "' AND gzgf003 <> 'c' "

                   #patch模式下 XG上Patch的規則異動:by 15/01/28 mail
                   IF g_patch_mode THEN
                      LET l_sub_sql = l_sub_sql, "  AND gzgf004 = 'default' AND gzgf005 = 'default' ",
                                                 "  AND (gzgf001, gzgf002, gzgf003, gzgf004, gzgf005) ", 
                                                 "   IN (SELECT gzgf001, gzgf002, gzgf003, gzgf004, gzgf005 ",
                                                 "         FROM ", g_patch_schema CLIPPED, ".gzgf_t WHERE gzgf001 = '", l_pack_ddata.ddata006 CLIPPED, "')"
                   END IF
                                  
                  LET l_wc = "  WHERE ", l_pack_dzyb.dzyb004 CLIPPED, " IN (", l_sub_sql.trim(), ")"
               END IF
            
            WHEN "azzi301"
               IF l_pack_dzyb.dzyb003 = "Y" THEN
                  LET l_wc = "  WHERE ", l_pack_dzyb.dzyb004 CLIPPED, " = '", l_pack_ddata.ddata006 CLIPPED, "' "

                  #patch模式時,刪除資料依[patch條件](dzyc004)規則處理
                  IF NOT adzp888_is_null(l_pack_dzyb.dzyc004) THEN
                     LET l_sub_sql = adzp888_str_replace(l_pack_dzyb.dzyc004, "dest.", "") 
                     LET l_sub_sql = adzp888_str_replace(l_sub_sql, "ds.", "") 
                     LET l_wc = l_wc, " AND ", l_sub_sql.trim()
                  END IF
               ELSE
                  LET l_sub_sql = "SELECT gzgd000 FROM ds.gzgd_t ", 
                                  "  WHERE gzgd001 = '", l_pack_ddata.ddata006 CLIPPED, "' AND gzgd003 <> 'c' "
                                  
                  LET l_wc = "  WHERE ", l_pack_dzyb.dzyb004 CLIPPED, " IN (", l_sub_sql.trim(), ")"
               END IF
         
            OTHERWISE
               #檢查是否需要加入第二條件式
               IF (l_pack_ddata.ddata015 = "d") AND (NOT adzp888_is_null(l_pack_ddata.ddata007)) AND (NOT adzp888_is_null(l_pack_dzyb.dzyb008)) THEN
                  #DISPLAY "l_pack_ddata.ddata007 is not null."
                  
                  #這裡表示只需要過單身資料,而dzyb004 = dzyb008代表此table裡主要ID Key值就為adzp888輸入ddata007的key值
                  IF l_pack_dzyb.dzyb004 = l_pack_dzyb.dzyb008 THEN
                     LET l_wc = "  WHERE ", l_pack_dzyb.dzyb008 CLIPPED, " = '", l_pack_ddata.ddata007 CLIPPED, "' "
                  ELSE
                     CALL adzp888_get_ddata007_wc(l_pack_dzyb.dzyb008, l_pack_ddata.ddata007)
                        RETURNING l_success, l_sub_sql
         
                     IF (NOT l_success) THEN
                        RETURN FALSE
                     END IF
                     
                     LET l_wc = "  WHERE ", l_pack_dzyb.dzyb004 CLIPPED, " = '", l_pack_ddata.ddata006 CLIPPED, "' "
                     
                     #加入單身子項條件
                     IF NOT adzp888_is_null(l_sub_sql) THEN
                        LET l_wc = l_wc, " AND ", l_sub_sql.trim()
                     END IF
                  END IF
               ELSE
                  LET l_wc = "  WHERE ", l_pack_dzyb.dzyb004 CLIPPED, " = '", l_pack_ddata.ddata006 CLIPPED, "' "
               END IF
               
               #patch模式時,刪除資料依[patch條件](dzyc004)規則處理
               IF NOT adzp888_is_null(l_pack_dzyb.dzyc004) THEN
                  #替換"dest."目的地table別名成null
                  LET l_sub_sql = adzp888_str_replace(l_pack_dzyb.dzyc004, "dest.", "") 
         
                  #替換"ds."目的地table owner別名成null
                  LET l_sub_sql = adzp888_str_replace(l_sub_sql, "ds.", "") 
                  
                  LET l_wc = l_wc, " AND ", l_sub_sql.trim()
               END IF
         
         END CASE
         
         #2016-10-27 
         #額外判斷是否解開scetion
         IF l_pack_dzyb.dzyb002 = "dzbc_t" OR l_pack_dzyb.dzyb002 = "dzbd_t" THEN
            #若有c/m則視為解開
            LET li_cnt = 0
            SELECT COUNT(*) INTO li_cnt 
              FROM ds.dzbc_t 
             WHERE dzbc001 = l_pack_ddata.ddata006
               AND dzbc005 <> 's' 
            IF li_cnt > 0 THEN
               #額外判斷條件, 若有解開section則不刪除ds
               LET l_str = "此程式(",l_pack_ddata.ddata006,")已解開Section, 不做Section資料刪除(",l_pack_dzyb.dzyb002,")!"
               CALL adzp888_log_file_write(l_str)
                
               #若有c則另外刪除此次patch的Section-S部分, 避免影響到客戶的S
               LET li_cnt = 0   
               SELECT COUNT(*) INTO li_cnt 
                 FROM ds.dzbc_t 
                WHERE dzbc001 = l_pack_ddata.ddata006
                  AND dzbc005 = 'c'
               IF li_cnt> 0 THEN
                  #清除dspatch的dzbc005為s,dzbd004為s的section
                  LET l_str = '此程式包含客製c Section, 刪除dspatch S資料!'
                  CALL adzp888_log_file_write(l_str)
                  LET l_str = "刪除dspatch的dzbc005為s,dzbd004為s的section!"
                  CALL adzp888_log_file_write(l_str)
                  LET l_str = "DELETE FROM dspatch.dzbc_t WHERE dzbc001 = '",l_pack_ddata.ddata006,"' AND dzbc005='s'"
                  DELETE FROM dspatch.dzbc_t WHERE dzbc001 = l_pack_ddata.ddata006 AND dzbc005='s'
                  CALL adzp888_log_file_write(l_str)
                  LET l_str = "DELETE FROM dspatch.dzbd_t WHERE dzbd001 = '",l_pack_ddata.ddata006,"' AND dzbd004='s'"
                  DELETE FROM dspatch.dzbd_t WHERE dzbd001 = l_pack_ddata.ddata006 AND dzbd004='s'
                  CALL adzp888_log_file_write(l_str)
               END IF
               CONTINUE FOREACH
            END IF
         END IF 
         
         LET l_sql = "DELETE FROM ds.", l_pack_dzyb.dzyb002 CLIPPED, " ", l_wc.trim()
         #2016-10-27
         DISPLAY l_sql
         
         LET l_str = l_sql 
         #CALL adzp888_log_file_write(l_str)

         PREPARE adzp888_del_data_batch_pre FROM l_sql
         IF SQLCA.sqlcode THEN
            #LET g_error_message = "ERROR-PREPARE adzp888_del_data_batch_pre.", l_pack_dzyb.dzyb002 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            LET g_error_message = "ERROR-PREPARE adzp888_del_data_batch_pre.", l_pack_dzyb.dzyb002 CLIPPED, ":錯誤代碼為-", SQLCA.sqlcode
            DISPLAY g_error_message
            CALL adzp888_log_file_write(g_error_message)
            RETURN FALSE
         END IF
         
         EXECUTE adzp888_del_data_batch_pre
         IF SQLCA.sqlcode THEN
            #LET g_error_message = "ERROR-exc adzp888_del_data_batch_pre.", l_pack_dzyb.dzyb002 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            LET g_error_message = "ERROR-exc adzp888_del_data_batch_pre.", l_pack_dzyb.dzyb002 CLIPPED, ":錯誤代碼為-",SQLCA.sqlcode
            DISPLAY g_error_message
            CALL adzp888_log_file_write(g_error_message)
            RETURN FALSE
         END IF 
      END FOREACH
      
      LET l_str = "####################"
      CALL adzp888_log_file_write(l_str)

   END FOREACH

   RETURN TRUE
END FUNCTION

PUBLIC FUNCTION adzp888_merge_data_batch(p_table, p_table_temp)
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

      SELECT dzec004 INTO l_dzed004 FROM ds.dzec_t 
        WHERE dzec001 = p_table AND dzec002 = l_dzec002 
   ELSE
      SELECT dzed004 INTO l_dzed004 FROM ds.dzed_t 
        WHERE dzed001 = p_table AND dzed003 = 'P' 
   END IF

   IF SQLCA.sqlcode THEN
      #LET g_error_message = "ERROR-sel ", p_table CLIPPED, ".dzed004:", cl_getmsg(l_errcode, g_lang)
      LET g_error_message = "ERROR-sel ", p_table CLIPPED, ".dzed004:錯誤代碼為-", SQLCA.sqlcode
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      RETURN FALSE
   END IF

   IF adzp888_is_null(l_dzed004) THEN
      #LET g_error_message = "ERROR-sel ", p_table CLIPPED, ".dzed004:", cl_getmsg("-2270", g_lang)
      LET g_error_message = "ERROR-sel ", p_table CLIPPED, ".dzed004:資料內容為空!"
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
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

         IF adzp888_is_null(l_pk_wc) THEN
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

   SELECT COUNT(dzeb002) INTO l_field_cnt FROM ds.dzeb_t
     WHERE dzeb001 = p_table

   IF l_field_cnt = l_con_column.getLength() THEN
      LET l_number_equal = TRUE
   END IF
  
   #取得資料表的所有欄位
   LET l_sql = "SELECT dzeb002 FROM ds.dzeb_t ",
               "  WHERE dzeb001 = ? "
   
   LET l_cnt = 1
   CALL l_tab_column.clear()
   
   DECLARE adzp888_col_cs CURSOR FROM l_sql
   FOREACH adzp888_col_cs USING p_table INTO l_tab_column[l_cnt]
      IF SQLCA.sqlcode THEN
         #LET g_error_message = "ERROR-FOREACH adzp888_col_cs:", cl_getmsg(l_errcode, g_lang)
         LET g_error_message = "ERROR-FOREACH adzp888_col_cs:錯誤代碼為-",SQLCA.sqlcode
         DISPLAY g_error_message
         CALL adzp888_log_file_write(g_error_message)
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
      
         IF adzp888_is_null(l_update_str) THEN
            LET l_update_str = l_tmp
         ELSE
            LET l_update_str = l_update_str, ", ", l_tmp
         END IF
      END IF
      
      #####取得INSERT 欄位#####
      LET l_tmp = "dest.", l_tab_column[l_cnt] CLIPPED
      
      IF adzp888_is_null(l_insert_col) THEN
         LET l_insert_col = l_tmp
      ELSE
         LET l_insert_col = l_insert_col, ", ", l_tmp
      END IF

      #####取得INSERT 欄位值#####
      LET l_tmp = "sour.", l_tab_column[l_cnt] CLIPPED
   
      IF adzp888_is_null(l_insert_value) THEN
         LET l_insert_value = l_tmp
      ELSE
         LET l_insert_value = l_insert_value, ", ", l_tmp
      END IF
      
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_tab_column.deleteElement(l_cnt)

   #加入客製條件,在合併資料時排除已客製的資料
   #取得資料表關於patch的相關設定
   SELECT DISTINCT dzyc002, dzyc003, dzyc004 INTO l_dzyc002, l_dzyc003, l_dzyc004 FROM ds.dzyc_t
     WHERE dzyc001 = p_table

   IF SQLCA.sqlcode THEN
      #LET g_error_message = "ERROR-sel dzyc004:", cl_getmsg(l_errcode, g_lang),
      #                      " IN ",p_table
      LET g_error_message = "ERROR-sel dzyc004:錯誤代碼為-",SQLCA.sqlcode,
                            " IN ",p_table
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      #RETURN FALSE
   END IF

   IF NOT adzp888_is_null(l_dzyc004) THEN
      LET l_cust_wc = l_dzyc004
   ELSE
      LET l_cust_wc = ""
   END IF
   
   IF NOT adzp888_is_null(l_cust_wc) THEN
      LET l_update_str = l_update_str, " WHERE ", l_cust_wc.trim()
   END IF
   
   #組合merge語句
   LET l_dest_table = g_sys_schema CLIPPED, ".", p_table CLIPPED

   #insert狀態時:patch的設計資料不存在客戶家時採純insert作法，不作任何資料的Update．
   IF l_dzyc002 = "4" OR p_table = "gzhc_t" OR p_table = "gzig_t" THEN
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
   CALL adzp888_log_file_write(l_sql)
   PREPARE adzp888_merge_pre FROM l_sql
   EXECUTE adzp888_merge_pre
   
   IF SQLCA.sqlcode THEN 
      #LET g_error_message = "ERROR-EXECUTE adzp888_merge_pre:", cl_getmsg(l_errcode, g_lang)
      LET g_error_message = "ERROR-EXECUTE adzp888_merge_pre:錯誤代碼為-", SQLCA.sqlcode
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      FREE adzp888_merge_pre
      RETURN FALSE
   END IF

   FREE adzp888_merge_pre

   RETURN TRUE
END FUNCTION

#+ 取得條件式二的where條件
PUBLIC FUNCTION adzp888_get_ddata007_wc(p_dzyb008, p_ddata007)
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
      #LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00375", g_lang, p_ddata007.trim())
      LET g_error_message = "ERROR:資料條件欄位和資料條件值無法對應-", p_ddata007.trim()
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      RETURN FALSE, l_wc
   END IF

   FOR l_i = 1 TO l_dzyb008_wc.getLength()
      IF adzp888_is_null(l_wc) THEN
         LET l_wc = l_dzyb008_wc[l_i].trim(), " = '", l_ddata007_wc[l_i].trim(), "'"
      ELSE
         LET l_wc = l_wc, " AND ", l_dzyb008_wc[l_i].trim(), " = '", l_ddata007_wc[l_i].trim(), "'"
      END IF
   END FOR

   IF adzp888_is_null(l_wc) THEN
      #LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00376", g_lang, p_ddata007.trim())
      LET g_error_message = "ERROR:無法組合資料條件式二-", p_ddata007.trim()
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      RETURN FALSE, l_wc
   END IF
   
   RETURN TRUE, l_wc
END FUNCTION

PUBLIC FUNCTION adzp888_log_file_write(p_str)
   DEFINE p_str             STRING

   CALL g_channel.write(p_str)
   
END FUNCTION

#2016-11-11 topstd專用log(原本的log照寫)
PUBLIC FUNCTION adzp888_topstd_log_file_write(p_str)
   DEFINE p_str             STRING

   DISPLAY p_str
   CALL g_topstd_channel.write(p_str)
   CALL adzp888_log_file_write(p_str)
   
END FUNCTION
#2016-11-11

#+ 取回此次patch summary file
PUBLIC FUNCTION adzp888_get_summary_file()
   DEFINE l_table_list_json util.JSONObject
   DEFINE l_channel         base.Channel
   DEFINE l_str             STRING
   DEFINE l_path            STRING
   
   LET l_table_list_json = util.JSONObject.create()
   
   #取回此次patch summary file總數
   LET l_path = os.Path.join(g_package, g_table_list)
   LET l_path = os.Path.join(FGL_GETENV(g_pack_dir_env), l_path)
   LET g_error_message = "INFO:讀取summary(",l_path,")!"
   DISPLAY g_error_message
   CALL adzp888_log_file_write(g_error_message)
   IF NOT os.Path.exists(l_path) THEN
      LET g_error_message = "BREAK_ERROR-找不到表格清單資訊!"
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      RETURN FALSE, l_table_list_json
   END IF

   LET l_channel = base.Channel.create()
   CALL l_channel.setDelimiter("")
   CALL l_channel.openFile(l_path, "r")
   LET l_str = l_channel.readLine()

   IF adzp888_is_null(l_str) THEN
      LET g_error_message = "BREAK_ERROR-表格清單資訊為空!"
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      RETURN FALSE, l_table_list_json
   END IF

   LET l_table_list_json = util.JSONObject.parse(l_str)
   IF l_table_list_json.getLength() = 0 THEN
      LET g_error_message = "BREAK_ERROR-表格清單資訊為空!"
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      RETURN FALSE, l_table_list_json
   END IF
   
   RETURN TRUE, l_table_list_json
END FUNCTION

############################################################
#+ @code
#+ 函式目的  檢查字串是否為NULL或是空字串.
#+ @param    ps_source  STRING  來源字串
#+
#+ @return   SMALLINT   TRUE/FALSE
############################################################
PUBLIC FUNCTION adzp888_is_null(ps_source)
   DEFINE   ps_source    STRING
   DEFINE   li_is_null   LIKE type_t.num5

   IF (ps_source IS NULL) THEN
      LET li_is_null = TRUE
   ELSE
      LET ps_source = ps_source.trim()
      IF (ps_source.getLength() = 0) THEN
         LET li_is_null = TRUE
      END IF
   END IF

   RETURN li_is_null
END FUNCTION

############################################################
#+ @code
#+ 函式目的 取代字串.
#+ @param   ps_source  STRING  來源字串
#+ @param   ps_old     STRING  舊字串
#+ @param   ps_new     STRING  新字串
#+
#+ @return  STRING     取代後的新字串
############################################################
PUBLIC FUNCTION adzp888_str_replace(ps_source,ps_old,ps_new)
   DEFINE ps_source,ps_old,ps_new STRING
   DEFINE buf base.StringBuffer

   LET buf = base.StringBuffer.create()
   CALL buf.append(ps_source)
   CALL buf.replace(ps_old, ps_new, 0)
   RETURN buf.toString()

END FUNCTION

PUBLIC FUNCTION adzp888_chk_run()
   DEFINE ls_cmd       STRING
   DEFINE l_chk        BOOLEAN        #是否執行成功
   DEFINE l_msg        STRING         #截取的錯誤訊息
   DEFINE l_ch         base.Channel
   DEFINE l_buf        STRING
   DEFINE l_str        STRING
   DEFINE l_cnt        INTEGER
   
   LET ls_cmd = "ps -f|grep adzp888"
   LET l_ch = base.Channel.create()
   CALL l_ch.setDelimiter("")
   CALL l_ch.openPipe(ls_cmd,"r")   #執行指令
   LET l_cnt = 0
   WHILE TRUE
      CALL l_ch.readLine() RETURNING l_buf
      DISPLAY l_buf
      IF l_buf.getIndexOf('adzp888',1) > 0 AND 
         l_buf.getIndexOf('42r',1)     > 0 THEN
         LET l_cnt = l_cnt + 1
      END IF
      
      IF l_cnt > 1 THEN
         RETURN TRUE
      END IF
      
      IF l_ch.isEof() THEN
         EXIT WHILE
      END IF
   END WHILE
   
   RETURN FALSE
   
END FUNCTION

#+ 程式註冊資料匯入前置作業
PUBLIC FUNCTION adzp888_import(p_master001,  p_master013, p_master014, p_pack_dir, p_folder)
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

   IF cl_null(p_folder) THEN
      LET g_msg = "ERROR:",p_folder,"不存在!"
      DISPLAY g_msg       
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   LET l_tar_name = p_folder, ".tgz"   

   #切換到新目錄下,準備讀取所有匯出檔
   IF (NOT os.Path.EXISTS(p_folder)) OR (NOT os.Path.chdir(p_folder)) THEN
      LET g_msg = "ERROR:檢查",p_folder,"不存在!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE
   END IF

   #[檔案]匯出清單匯入
   #檢查檔案匯出清單是否有資料
   #LET l_cnt = 0
   #SELECT COUNT(*) INTO l_cnt FROM adzi888_dfile
   #
   ##進度列控制
   #IF g_adzp888_s01 IS NOT NULL AND g_adzp888_s01 THEN
   #   CALL adzp888_refresh_tasks_progressbar(gc_imp_file, "adz-00606")
   #END IF
   #
   #IF l_cnt > 0 THEN
   #   LET l_str = "import file start:", cl_get_current()
   #   CALL adzp888_log_file_write(l_str)
   #   
   #   IF NOT adzp888_import_file(p_master001, p_master013, p_master014, p_pack_dir, p_folder) THEN
   #      RETURN FALSE
   #   END IF
   #
   #   LET l_str = "import file end:", cl_get_current()
   #   CALL adzp888_log_file_write(l_str)
   #END IF
   
   #[資料表(table)]匯入
   LET g_msg = "INFO:進行adzi140額外匯入動作!"
   DISPLAY g_msg
   CALL adzp888_log_file_write(g_msg)
      
   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     WHERE ddata005 = 'adzi140'
   IF l_cnt > 0 THEN
      LET l_str = "import dzea start:", ASCII 10
      CALL adzp888_log_file_write(l_str)
   
      #因為在表格的匯出過程中也會切換路徑,所需把路徑切回目前工作路徑
      LET l_str = os.Path.pwd()
   
      LET l_folder_path = os.Path.join(p_pack_dir, p_folder)
      CALL sadzp240_run(l_folder_path.trim())
         RETURNING lb_result, ls_message

      IF NOT lb_result THEN
         LET g_error_message = "ERROR:import dzea error, GUID :", ls_message
         DISPLAY g_error_message
         CALL adzp888_log_file_write(g_error_message)
         RETURN FALSE
      END IF

      #把路徑切回打包的工作路徑
      IF NOT os.Path.chdir(l_str) THEN
         #LET g_error_message = "BREAK_ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_str.trim())
         LET g_error_message = "BREAK_ERROR:切換目錄", l_str.trim(),"失敗!"
         DISPLAY g_error_message
         CALL adzp888_log_file_write(g_error_message)
         RETURN FALSE
      END IF
      
      LET l_str = "import dzea end:", ASCII 10
      CALL adzp888_log_file_write(l_str)
   END IF
   
   #執行r.s ds 確保整個ds.sch的結構是最新的
   LET g_msg = "INFO:進行r.s 產出最新sch!"
   DISPLAY g_msg
   CALL adzp888_log_file_write(g_msg)
   IF g_patch_mode THEN
      LET l_str = "r.s ds start:", cl_get_current()
      CALL adzp888_log_file_write(l_str)
   
      LET l_str = "r.s ds "
      IF NOT adzp888_run_command(l_str) THEN
         #2016-10-27 
         #當下可能有甚麼狀況, 再做一次
         IF NOT adzp888_run_command(l_str) THEN
            LET g_msg = 'WARNING: r.s ds發生異常!'
            DISPLAY g_msg
            CALL adzp888_log_file_write(g_msg)
            RETURN FALSE
         END IF
         #2016-10-27 
      END IF
      LET l_str = "r.s ds end:", cl_get_current()
      CALL adzp888_log_file_write(l_str)
   END IF
   
   #因為azzi903裡的gzzq_t的ACTION多語言有大部份都屬於gzzq001='standard',所以需要獨立LOAD data
   #因此這部份資料需要額外處理
   LET g_msg = "INFO:進行azzi903額外匯入動作!"
   DISPLAY g_msg
   CALL adzp888_log_file_write(g_msg)
   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     WHERE ddata005 = 'azzi903'

   IF l_cnt > 0 THEN
      LET l_str = "import gzzq_standard start:", cl_get_current()
      CALL adzp888_log_file_write(l_str)
      
      IF NOT adzp888_merge_table_data("gzzq_t", g_gzzq_standard) THEN
         RETURN FALSE
      END IF

      LET l_str = "import gzzq_standard end:", cl_get_current()
      CALL adzp888_log_file_write(l_str)
   END IF
   
   #LOAD azzi330報表表頭相關單身設定資料(因此這部份資料條件較特殊所以額外處理)
   SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     WHERE ddata005 = 'azzi330'
   DISPLAY "INFO:進行adzi330額外匯入動作!"
   IF l_cnt > 0 THEN
      #匯入azzi330相關資料
      LET l_str = "import azzi330_detail_data() start:", cl_get_current()
      CALL adzp888_log_file_write(l_str)
      
      IF NOT adzp888_azzi330_detail_data("imp") THEN
         RETURN FALSE
      END IF
      
      LET l_str = "import azzi330_detail_data() end:", cl_get_current()
      CALL adzp888_log_file_write(l_str)
   END IF
   
   #[patch資料]匯入
   LET l_str = "import dmp start:", cl_get_current()
   CALL adzp888_log_file_write(l_str)

   #只有當g_import_dapatch="N"時,才不做import dspatch的動作
   LET l_patch_user = g_patch_schema
   
   #patch dmp檔匯入
   IF NOT adzp888_import_dmp(l_patch_user) THEN
      LET g_msg = "ERROR:dmp匯入失敗!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   #2016-11-11 判斷程式是否較新, 若較新則刪除dspatch資料
   #比patch包新的程式不做更新
   DELETE FROM dspatch.dzaa_t WHERE dzaa001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzaa_t WHERE dzaa001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzab_t WHERE dzab001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzac_t WHERE dzac001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzad_t WHERE dzad001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzaf_t WHERE dzaf001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzag_t WHERE dzag001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzai_t WHERE dzai001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzaj_t WHERE dzaj001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzak_t WHERE dzak001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzal_t WHERE dzal001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzam_t WHERE dzam001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzax_t WHERE dzax001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzba_t WHERE dzba001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzbb_t WHERE dzbb001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzbc_t WHERE dzbc001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzbd_t WHERE dzbd001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzfb_t WHERE dzfb001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzff_t WHERE dzff001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzfi_t WHERE dzfi001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzfj_t WHERE dzfj001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzfk_t WHERE dzfk001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzfl_t WHERE dzfl001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzfq_t WHERE dzfq004 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzfs_t WHERE dzfs002 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzga_t WHERE dzga001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzgb_t WHERE dzgb001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzgc_t WHERE dzgc001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzgd_t WHERE dzgd001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzge_t WHERE dzge001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzgf_t WHERE dzgf001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzgg_t WHERE dzgg001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzgh_t WHERE dzgh001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzgi_t WHERE dzgi001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzgj_t WHERE dzgj001 IN (SELECT prog_name FROM dspatch.client_newer)
   DELETE FROM dspatch.dzgl_t WHERE dzgl001 IN (SELECT prog_name FROM dspatch.client_newer)
   #2016-11-11
   
   #根據設定決定是否刪除相關作業資訊
   #IF g_merge = 'N' THEN
   #   DELETE FROM dspatch.dzaa_t WHERE dzaa001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzab_t WHERE dzab001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzac_t WHERE dzac001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzad_t WHERE dzad001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzaf_t WHERE dzaf001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzag_t WHERE dzag001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzai_t WHERE dzai001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzaj_t WHERE dzaj001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzak_t WHERE dzak001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzal_t WHERE dzal001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzam_t WHERE dzam001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzax_t WHERE dzax001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzba_t WHERE dzba001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzbb_t WHERE dzbb001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzbc_t WHERE dzbc001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzbd_t WHERE dzbd001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzfb_t WHERE dzfb001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzff_t WHERE dzff001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzfi_t WHERE dzfi001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzfj_t WHERE dzfj001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzfk_t WHERE dzfk001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzfl_t WHERE dzfl001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzfq_t WHERE dzfq004 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzfs_t WHERE dzfs002 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzga_t WHERE dzga001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzgb_t WHERE dzgb001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzgc_t WHERE dzgc001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzgd_t WHERE dzgd001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzge_t WHERE dzge001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzgf_t WHERE dzgf001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzgg_t WHERE dzgg001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzgh_t WHERE dzgh001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzgi_t WHERE dzgi001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzgj_t WHERE dzgj001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #   DELETE FROM dspatch.dzgl_t WHERE dzgl001 IN (SELECT dzaf001 FROM ds.dzaf_t WHERE dzaf010='c' AND dzaf001 NOT LIKE '%_t')
   #END IF

   LET l_str = "import dmp end:", cl_get_current()
   CALL adzp888_log_file_write(l_str)

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
   #DISPLAY "Info:", cl_getmsg("adz-00346", g_lang)
   DISPLAY "Info:匯入完成!"
   #END IF

   RETURN TRUE
END FUNCTION

#+ patch匯出時,先將patch schema imp至dspatch
PUBLIC FUNCTION adzp888_import_dmp(p_patch_user)
   DEFINE p_patch_user      STRING  #patch chema
   DEFINE l_dmp_file        STRING  #dmp檔名
   DEFINE l_cmd             STRING

   #取得dmp gzip檔名
   LET l_dmp_file = p_patch_user.trim(), ".dmp", ".gz"

   #檢查gzip檔是否存在
   IF NOT os.Path.EXISTS(l_dmp_file) THEN
      #LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_dmp_file.trim())
      LET g_error_message = "ERROR:壓縮檔不存在-",l_dmp_file
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      RETURN FALSE
   END IF

   #gunzip dspatch.dmp.gz
   LET l_cmd = "gunzip ", l_dmp_file.trim()
   RUN l_cmd
   LET g_msg = "Info:解壓縮dmp.gz!"
   DISPLAY g_msg
   CALL adzp888_log_file_write(g_msg)
      
   IF STATUS THEN
      #LET g_error_message = "BREAK_ERROR:", l_cmd.trim(), ":", cl_getmsg(STATUS, g_lang)
      LET g_error_message = "BREAK_ERROR:解壓縮異常", l_cmd.trim(), ":錯誤代碼為-", STATUS
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      RETURN FALSE
   END IF
      
   #取得dmp檔名
   LET l_dmp_file = p_patch_user.trim(), ".dmp"

   #檢查gzip檔是否存在
   IF NOT os.Path.EXISTS(l_dmp_file) THEN
      #LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_dmp_file.trim())
      LET g_error_message = "ERROR:檔案不存在-", l_dmp_file.trim()
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      RETURN FALSE
   END IF
   
   #imp dspatch/dspatch FILE=dspatch.dmp LOG=dspatch.implog STATISTICS=NONE
   LET l_cmd = "imp ", p_patch_user.trim(), "/", g_patch_pwd.trim(), " ",
               "FILE=", l_dmp_file.trim(), " LOG=", p_patch_user.trim(), ".implog STATISTICS=NONE"
   LET g_msg = "Info:import資料至dspatch!"
   DISPLAY g_msg
   CALL adzp888_log_file_write(g_msg)
   LET g_msg = "Info:指令-",l_cmd
   DISPLAY g_msg
   CALL adzp888_log_file_write(g_msg)
   IF NOT adzp888_run_command(l_cmd) THEN
      RETURN FALSE
   END IF
   
   #2016-11-11 已完成imp,取得ds較新的程式清單, 並處理topstd adp
   IF NOT adzp888_for_newer_prog() THEN
      RETURN FALSE
   END IF
   IF NOT adzp888_for_topstd() THEN
      RETURN FALSE
   END IF
   #2016-11-11
   
   RETURN TRUE
END FUNCTION

#+ 因為azzi903裡的gzzq_t的ACTION多語言有大部份都屬於gzzq001='standard',所以需要獨立LOAD data
PRIVATE FUNCTION adzp888_merge_table_data(p_table, p_file)
   DEFINE p_table           STRING
   DEFINE p_file            STRING
   
   DEFINE l_sql             STRING
   DEFINE l_str             STRING
   DEFINE l_table_temp      STRING

   IF (NOT os.Path.EXISTS(p_file)) OR (os.Path.size(p_file) = 0) THEN
      #LET l_str = "Warning:", cl_getmsg_parm("adz-00339", g_lang, p_file.trim())
      LET l_str = "Warning:檔案不存在-",p_file.trim()
      CALL adzp888_log_file_write(l_str)
      RETURN FALSE
   END IF
   
   LET l_table_temp = "tmp_", p_table CLIPPED
   LET l_sql = "SELECT * INTO TEMP ", l_table_temp.trim(), 
               "  FROM ", "(SELECT * FROM ds.", p_table CLIPPED, " WHERE 1 = 2)"
   
   DISPLAY "create temp table sql:", l_sql
   PREPARE adzp888_merge_create_pre FROM l_sql
   EXECUTE adzp888_merge_create_pre

   IF SQLCA.sqlcode THEN
      #LET l_str = "Warning-PREPARE adzp888_merge_create_pre.", p_table CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      LET l_str = "Warning-PREPARE adzp888_merge_create_pre.", p_table CLIPPED, ":錯誤代碼為-",SQLCA.sqlcode
      CALL adzp888_log_file_write(l_str)
      RETURN FALSE
   END IF
   
   LET l_sql = "INSERT INTO ", l_table_temp.trim()
   
   DISPLAY "load sql:", l_sql
   LOAD FROM p_file l_sql
   
   IF STATUS THEN
      #LET l_str = "Warning-LOAD FROM ", p_file.trim(), ":", cl_getmsg(STATUS, g_lang)
      LET l_str = "Warning-LOAD FROM ", p_file.trim(), ":檔案load發生異常-",STATUS
      CALL adzp888_log_file_write(l_str)
      RETURN FALSE
   END IF

   #資料整批匯入
   IF NOT adzp888_merge_data_batch(p_table, l_table_temp) THEN
      RETURN FALSE
   END IF

   #drop temp table
   IF l_table_temp.getIndexOf("tmp_", 1) > 0 AND l_table_temp.getIndexOf("_t", 1) > 0 THEN
      LET l_sql = "DROP TABLE ", l_table_temp.trim(), " purge"
      DISPLAY "drop temp table:", l_sql
      PREPARE adzp888_merge_drop_pre FROM l_sql
      EXECUTE adzp888_merge_drop_pre
   
      IF SQLCA.sqlcode THEN
         #LET l_str = "Warning-PREPARE adzp888_merge_drop_pre.", l_table_temp.trim(), ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         LET l_str = "Warning-PREPARE adzp888_merge_drop_pre.", l_table_temp.trim(), ":merge發生異常-",SQLCA.sqlcode
         CALL adzp888_log_file_write(l_str)
         RETURN FALSE
      END IF
   END IF
   
   FREE adzp888_merge_create_pre 
   
   RETURN TRUE
   
END FUNCTION 

#+ 因為azzi330裡的gzgj_t,gzgjl_t,gzgk_t就是過'YY'的資料gzgl_t就是全過,所以需要獨立LOAD data
PRIVATE FUNCTION adzp888_azzi330_detail_data(p_mode)
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
         #WHEN "exp"
         #   LET l_sql = "SELECT * FROM ", l_table[l_i].dzea001 CLIPPED,
         #               "  WHERE ", l_table[l_i].wc.trim()
         #
         #   LET l_str = "UNLOAD TO ", l_file, " ", l_sql
         #   CALL adzp888_log_file_write(l_sql)
         #
         #   UNLOAD TO l_file l_sql
         #   
         #   IF STATUS THEN
         #      LET l_errcode = STATUS
         #      INITIALIZE g_errparam TO NULL
         #      LET g_errparam.code =  STATUS
         #      LET g_errparam.extend = "UNLOAD TO ", l_file.trim()
         #      LET g_errparam.popup = TRUE
         #      CALL cl_err()
         #      LET l_str = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
         #      CALL adzp888_log_file_write(l_str)
         #      DISPLAY l_str
         #      ROLLBACK WORK
         #      RETURN FALSE
         #   END IF

         WHEN "imp"            
            LET l_str = "import ", l_table[l_i].dzea001 CLIPPED, " start:", cl_get_current()
            CALL adzp888_log_file_write(l_str)

            IF NOT os.Path.EXISTS(l_file) THEN
               #DISPLAY "ERROR:",l_file,"檔案不存在!"
               #LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_file.trim())
               LET g_error_message = "ERROR:檔案不存在-",l_file.trim()
               DISPLAY g_error_message
               CALL adzp888_log_file_write(g_error_message)
               ROLLBACK WORK
               RETURN FALSE
            END IF

            IF os.Path.size(l_file) = 0 THEN  
               LET l_str = l_file.trim(), " is null. end:", cl_get_current()
               CALL adzp888_log_file_write(l_str)
               CONTINUE FOR
            END IF

            #azzi330相關報表表頭單身資料採2.先Delete後Insert方式
            LET l_sql = "DELETE FROM ds.", l_table[l_i].dzea001 CLIPPED, " WHERE ", l_table[l_i].wc.trim()

            CALL adzp888_log_file_write(l_sql)

            PREPARE adzp888_azzi330_del_data_pre FROM l_sql
            IF SQLCA.sqlcode THEN
               DISPLAY "ERROR:刪除azzi330資料失敗!"
               #LET g_error_message = "ERROR-PREPARE adzp888_azzi330_del_data_pre.", l_table[l_i].dzea001 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
               LET g_error_message = "ERROR-PREPARE adzp888_azzi330_del_data_pre.", l_table[l_i].dzea001 CLIPPED, ":錯誤代碼為-", SQLCA.sqlcode 
               DISPLAY g_error_message
               CALL adzp888_log_file_write(g_error_message)
               ROLLBACK WORK
               RETURN FALSE
            END IF
            
            EXECUTE adzp888_azzi330_del_data_pre
            IF SQLCA.sqlcode THEN
               DISPLAY "ERROR(",SQLCA.sqlcode,"):執行adzp888_azzi330_del_data_pre失敗!"
               #LET g_error_message = "ERROR-exc adzp888_azzi330_del_data_pre.", l_table[l_i].dzea001 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
               LET g_error_message = "ERROR-exc adzp888_azzi330_del_data_pre.", l_table[l_i].dzea001 CLIPPED, ":錯誤代碼為-", SQLCA.sqlcode
               DISPLAY g_error_message
               CALL adzp888_log_file_write(g_error_message)
               ROLLBACK WORK
               RETURN FALSE
            END IF 

            #將資料Load回資料表
            IF NOT adzp888_pack_ins_data(l_file, l_table[l_i].dzea001, "1") THEN
               ROLLBACK WORK
               RETURN FALSE
            END IF
   
            LET l_str = "import ", l_table[l_i].dzea001 CLIPPED, " end:", cl_get_current()
            CALL adzp888_log_file_write(l_str)

      END CASE
   END FOR

   COMMIT WORK
   
   RETURN TRUE
END FUNCTION

#+ 註冊資訊[資料]新增
PUBLIC FUNCTION adzp888_pack_ins_data(p_file, p_dzyb002, p_ddata004)
   DEFINE p_file            STRING
   DEFINE p_dzyb002         LIKE dzyb_t.dzyb002
   DEFINE p_ddata004        LIKE type_t.chr1        #匯入動作(1:Merge; 2:Insert; 3:Delete)
   
   DEFINE l_sql             STRING
   DEFINE l_str             STRING
   DEFINE l_errcode         STRING
   
   LET l_sql = "INSERT INTO ds.", p_dzyb002 CLIPPED

   LET l_str = "LOAD FROM ", p_file, " ", l_sql
   CALL adzp888_log_file_write(l_str)

   LOAD FROM p_file l_sql

   IF STATUS THEN
      IF p_ddata004 = "2" THEN
         #LET l_str = "Warning-LOAD FROM ", p_file.trim(), ":", cl_getmsg(STATUS, g_lang)
         LET l_str = "Warning-LOAD FROM ", p_file.trim(), ":錯誤代碼為-", STATUS
         DISPLAY l_str
         CALL adzp888_log_file_write(l_str)
      ELSE
         DISPLAY "ERROR:LOAD至",p_dzyb002,"資料失敗!"
         #LET g_error_message = "ERROR-LOAD FROM ", p_file.trim(), ":", cl_getmsg(l_errcode, g_lang)
         LET g_error_message = "ERROR-LOAD FROM ", p_file.trim(), ":錯誤代碼為-", STATUS
         DISPLAY g_error_message
         CALL adzp888_log_file_write(g_error_message)
         RETURN FALSE
      END IF
   END IF
   
   RETURN TRUE
END FUNCTION

#+ 執行指令
PUBLIC FUNCTION adzp888_run_command(p_cmd)
   DEFINE p_cmd             STRING                #要執行的指令

   DEFINE ls_str            STRING
   DEFINE l_msg             STRING                #編譯後訊息
   DEFINE l_read            base.Channel
   DEFINE l_result          LIKE type_t.chr1      #編譯成功或失敗
   DEFINE l_errcode         STRING
   DEFINE l_errmsg          STRING

   LET l_errmsg = ""
   LET ls_str = "run command:", p_cmd.trim()

   IF ls_str.getIndexOf(g_patch_pwd, 1) > 0 THEN
      LET ls_str = cl_replace_str(ls_str, g_patch_pwd, "xxxx")
   END IF

   CALL adzp888_log_file_write(ls_str)

   IF cl_null(p_cmd) THEN
      LET ls_str = "Warn:command is null." 
      CALL adzp888_log_file_write(ls_str)
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

   CALL l_read.openPipe(p_cmd, "r")   #執行指令

   IF STATUS THEN
      DISPLAY "ERROR:執行(",p_cmd,")失敗!"
      #LET g_error_message = "run command-", p_cmd.trim(), ":", cl_getmsg(l_errcode, g_lang)
      LET g_error_message = "run command-", p_cmd.trim(), ":錯誤代碼為-", STATUS
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      RETURN FALSE
   END IF

   WHILE TRUE
      LET ls_str = l_read.readLine()
      CALL adzp888_log_file_write(ls_str)
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
      DISPLAY "ERROR:執行結果有誤(",l_errmsg,")!"
      #LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00368", g_lang, p_cmd.trim())
      LET g_error_message = "ERROR:", p_cmd.trim(),"發生異常!"
      DISPLAY g_error_message
      CALL adzp888_log_file_write(g_error_message)
      CALL adzp888_log_file_write("    err:" || l_errmsg)
      CALL adzp888_log_file_write("    run msg:" || l_msg)
      RETURN FALSE
   END IF

   CALL adzp888_log_file_write(l_msg)
   CALL adzp888_log_file_write(p_cmd || " is success.")
   CALL adzp888_log_file_write("----------------------------------------")
   
   RETURN TRUE
END FUNCTION

#+ 取得patch包檔案名稱和解包時的目錄名稱
PRIVATE FUNCTION adzp888_get_pack_name(p_pack)
   DEFINE p_pack            STRING               #patch包路徑
   
   DEFINE l_folder          STRING               #匯出檔目錄
   DEFINE l_tar_name        STRING               #匯出包名稱
   DEFINE l_idx             LIKE type_t.num5

   LET l_tar_name = ""
   LET l_folder = ""
   
   #取得tar檔案名稱
   LET l_tar_name = os.Path.basename(p_pack)
   
   #取得匯出檔的目錄名稱
   LET l_idx = l_tar_name.getIndexOf(".tgz", 1)
   IF l_idx > 1 THEN
      LET l_folder = l_tar_name.subString(1, l_idx - 1)
   END IF

   IF cl_null(l_tar_name) OR cl_null(l_folder) THEN
      LET g_msg = "ERROR:解包路徑有誤(",l_tar_name,",",l_folder,")!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
      RETURN FALSE, l_tar_name, l_folder
   END IF

   RETURN TRUE, l_tar_name, l_folder
END FUNCTION

FUNCTION adzp888_drop_dspatch()
   DEFINE lr_tables    DYNAMIC ARRAY OF RECORD
          table_name   LIKE type_t.chr200
          END RECORD   
   DEFINE ls_db_user   CHAR(50)
   DEFINE ls_table     STRING
   DEFINE ls_drop_sql  STRING
   DEFINE ls_sql       STRING
   DEFINE l_ac         INTEGER
   DEFINE l_i          INTEGER
   DEFINE li_cnt       INTEGER #2016-10-27
  
   #確認當下在dspatch
   SELECT SYS_CONTEXT ('USERENV', 'SESSION_USER') 
     INTO ls_db_user 
     FROM DUAL
   IF ls_db_user <> 'DSPATCH' THEN 
      RETURN FALSE
   END IF
   
   LET ls_sql = 'select table_name from user_tables'
   
   PREPARE sadzp888_drop FROM ls_sql
   DECLARE sadzp888_drop_cs CURSOR FOR sadzp888_drop
   
   LET l_ac = 1
   FOREACH sadzp888_drop_cs INTO lr_tables[l_ac].*
       IF STATUS THEN
          DISPLAY 'FOREACH ERROR'
          EXIT FOREACH
       END IF
       LET l_ac= l_ac + 1
   END FOREACH   
   
   LET g_msg = "INFO:開始drop table"
   DISPLAY g_msg
   CALL adzp888_log_file_write(g_msg)
   FOR l_i = 1 TO l_ac-1
       LET ls_table = lr_tables[l_i].table_name CLIPPED
       IF ls_table.getIndexOf("ADZI888_MASTER",1) > 0 OR 
          ls_table.getIndexOf("ADZI888_DDATA",1)      THEN
          CONTINUE FOR
       END IF
       LET ls_drop_sql = 'drop table DSPATCH.',ls_table, ' purge'
       #EXECUTE IMMEDIATE ls_drop_sql
       PREPARE sadzp888_01_drop_pre FROM ls_drop_sql
       EXECUTE sadzp888_01_drop_pre
       display "drop",":",ls_drop_sql
       CALL adzp888_log_file_write(ls_drop_sql)
       IF sqlca.sqlcode THEN
          EXIT FOR
          RETURN FALSE
       END IF
   
   END FOR
   
   LET g_msg = "INFO:結束drop table"
   DISPLAY g_msg
   CALL adzp888_log_file_write(g_msg)
   
   #2016-10-27
   #檢查是否有殘存表格
   LET li_cnt = 0
   SELECT COUNT(*) 
     INTO li_cnt
     FROM user_tables
    WHERE table_name NOT LIKE '%ADZI888%'
   
   IF li_cnt > 0 THEN
      LET g_msg = 'WARNING:dspatch資料表未清除乾淨!'
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
   ELSE
      LET g_msg = 'INFO:dspatch資料表已清除乾淨!'
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
   END IF
     
   #2016-10-27

   RETURN TRUE
   
END FUNCTION

FUNCTION adzp888_exit(pb_chk)
   DEFINE pb_chk BOOLEAN
   
   IF pb_chk THEN
      DISPLAY 'adzp888 success!'  
   ELSE
      DISPLAY 'adzp888 failure!'  
   END IF
   
   DROP TABLE adzi888_master
   DROP TABLE adzi888_ddata
   
   CALL g_channel.close()
   CALL g_topstd_channel.close() #2016-11-11

   EXIT PROGRAM
   
   
END FUNCTION

FUNCTION adzp888_update_dzyg(ps_type)
   DEFINE ps_type STRING #完成動作import/merge
   DEFINE li_cnt  INTEGER
   
   #暫用
   SELECT COUNT(*) INTO li_cnt FROM ds.dzyg_t
    WHERE dzyg001 = g_patch_m.patch002
    
   IF li_cnt = 0 THEN
      INSERT INTO ds.dzyg_t (dzyg001) values (g_patch_m.patch002)
   END IF 
   
   CASE ps_type
      WHEN "import" #import完成寫入flag
         UPDATE ds.dzyg_t SET dzyg003 = 'Y' 
          WHERE dzyg001 = g_patch_m.patch002
      WHEN "merge"  #merge 完成寫入flag
         UPDATE ds.dzyg_t SET dzyg004 = 'Y'#,
                              #dzyg012 = g_merge 
          WHERE dzyg001 = g_patch_m.patch002
   END CASE
   
   IF SQLCA.sqlcode THEN
      LET g_msg = "WARNING:更新patch紀錄(",ps_type,")失敗!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
   ELSE
      LET g_msg = "INFO:更新patch紀錄(",ps_type,")完成!"
      DISPLAY g_msg
      CALL adzp888_log_file_write(g_msg)
   END IF
   
END FUNCTION 

#2016-11-11 新增函式
#針對比patch包內更新的程式做額外處理
FUNCTION adzp888_for_newer_prog()
   DEFINE ls_sql  STRING
   DEFINE li_cnt  INTEGER
   DEFINE li_idx  INTEGER
   DEFINE la_prog DYNAMIC ARRAY OF CHAR(30)
   DEFINE ls_prog STRING
   
   #建立dspatch_dzaf
   DELETE FROM dspatch.dspatch_dzaf
   CREATE TEMP TABLE dspatch_dzaf
   (
   dzaf001 VARCHAR(20),
   dzaf002 INT
   );
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR: dspatch_dzaf 建立失敗!"
      CALL adzp888_topstd_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   #建立ds_dzaf
   DELETE FROM dspatch.ds_dzaf
   CREATE TEMP TABLE ds_dzaf
   (
   dzaf001 VARCHAR(20),
   dzaf002 INT
   );
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR: ds_dzaf 建立失敗!"
      CALL adzp888_topstd_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   #建立client_newer
   DELETE FROM client_newer
   CREATE TEMP TABLE client_newer
   (
   prog_name VARCHAR(20)
   );
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR: client_newer 建立失敗!"
      CALL adzp888_topstd_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   #建立dspatch ver所需資料
   INSERT INTO dspatch.dspatch_dzaf (dzaf001,dzaf002) 
   SELECT dzaf001,MAX(dzaf002) FROM dspatch.dzaf_t 
    WHERE dzaf001 NOT LIKE '%_t'
      AND dzaf010 = 's'    
    GROUP BY dzaf001;
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR: dspatch_dzaf 資料篩選失敗!"
      CALL adzp888_topstd_log_file_write(g_msg)
      RETURN FALSE
   END IF
     
   #建立ds ver所需資料
   INSERT INTO dspatch.ds_dzaf (dzaf001,dzaf002)  
   SELECT dzaf001,MAX(dzaf002) FROM ds.dzaf_t 
    WHERE dzaf001 NOT LIKE '%_t' 
      AND dzaf010 = 's'  
      AND dzaf001 IN (SELECT dzaf001 FROM dspatch.dspatch_dzaf) 
    GROUP BY dzaf001;
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR: ds_dzaf 資料篩選失敗!"
      CALL adzp888_topstd_log_file_write(g_msg)
      RETURN FALSE
   END IF
    
   #取出客戶家較新的程式新單
   INSERT INTO dspatch.client_newer (prog_name)  
   SELECT t1.dzaf001 
     FROM dspatch_dzaf t1 
    INNER JOIN ds_dzaf t2 
       ON t1.dzaf001 = t2.dzaf001 AND 
          t2.dzaf002 > t1.dzaf002;
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR: client_newer 資料篩選失敗!"
      CALL adzp888_topstd_log_file_write(g_msg)
      RETURN FALSE
   END IF
    
   #取出ds比dspatch舊的程式做一般更新
   LET ls_sql = "   SELECT DISTINCT(dzaf001)    ",
                "     FROM dspatch.dzaf_t       ",
                "    WHERE dzaf001 NOT IN       ",
                "     (SELECT prog_name         ",
                "     FROM dspatch.client_newer)",
                " ORDER BY dzaf001              "
   PREPARE update_pre FROM ls_sql
   DECLARE update_precur CURSOR FOR update_pre
   
   LET li_idx = 1
   LET g_msg = "INFO:------一般更新程式清單開始!------"
   CALL adzp888_topstd_log_file_write(g_msg)
   
   FOREACH update_precur INTO la_prog[li_idx]
      LET ls_prog = la_prog[li_idx]
      LET ls_prog = ls_prog.trim()
      LET g_msg = "INFO:程式(",ls_prog,")將進行更新!"
      CALL adzp888_topstd_log_file_write(g_msg)
      LET li_idx = li_idx + 1
   END FOREACH
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR: client_newer 資料取得失敗!"
      CALL adzp888_topstd_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   LET g_msg = "INFO:------一般更新程式清單結束!------\n"
   CALL adzp888_topstd_log_file_write(g_msg)
    
   #取出ds比dspatch新的程式做特別處理
   LET ls_sql = "   SELECT prog_name            ",
                "     FROM dspatch.client_newer ",
                " ORDER BY prog_name            "
   PREPARE newer_pre FROM ls_sql
   DECLARE newer_precur CURSOR FOR newer_pre
   
   LET li_idx = 1
   LET g_msg = "INFO:------不做更新程式清單開始!------"
   CALL adzp888_topstd_log_file_write(g_msg)
    
   FOREACH newer_precur INTO la_prog[li_idx]
      LET ls_prog = la_prog[li_idx]
      LET ls_prog = ls_prog.trim()
      LET g_msg = "INFO:因客戶程式(",ls_prog,")較新,不做更新!"
      CALL adzp888_topstd_log_file_write(g_msg)
      LET li_idx = li_idx + 1
   END FOREACH
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR: client_newer 資料取得失敗!"
      CALL adzp888_topstd_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   LET g_msg = "INFO:------不做更新程式清單結束!------\n"
   CALL adzp888_topstd_log_file_write(g_msg)
   
   RETURN TRUE

END FUNCTION

#抄寫topstd相關adp資料
FUNCTION adzp888_for_topstd()
   DEFINE ls_sql  STRING
   DEFINE li_idx  INTEGER
   DEFINE li_cnt  INTEGER
   DEFINE li_ver  INTEGER
   DEFINE lr_dzbb RECORD 
          dzbb001    LIKE dzbb_t.dzbb001,
          dzbb002    LIKE dzbb_t.dzbb002,
          dzbb003    LIKE dzbb_t.dzbb003,
          dzbb004    LIKE dzbb_t.dzbb004,
          dzbb098    LIKE dzbb_t.dzbb098,
          dzbbmodid  LIKE dzbb_t.dzbbmodid,
          dzbbmoddt  LIKE dzbb_t.dzbbmoddt,
          dzbbcrtid  LIKE dzbb_t.dzbbcrtid,
          dzbbcrtdt  LIKE dzbb_t.dzbbcrtdt,
          max_time LIKE dzbb_t.dzbbcrtdt
          END RECORD
   DEFINE lr_dzbb_time RECORD  
          dzbbcrtdt LIKE dzbb_t.dzbbcrtdt,
          dzbbmoddt LIKE dzbb_t.dzbbmoddt
          END RECORD
   #2016-01-04
   #DEFINE lr_dzbi RECORD 
   #       dzbi001   LIKE dzbi_t.dzbi001,
   #       dzbi002   LIKE dzbi_t.dzbi002,
   #       dzbi003   LIKE dzbi_t.dzbi003,
   #       dzbi004   LIKE dzbi_t.dzbi004,
   #       dzbi005   LIKE dzbi_t.dzbi005,
   #       dzbi006   LIKE dzbi_t.dzbi006,
   #       dzbi007   LIKE dzbi_t.dzbi007,
   #       dzbi008   LIKE dzbi_t.dzbi008,
   #       dzbi098   LIKE dzbi_t.dzbi098,
   #       dzbistus  LIKE dzbi_t.dzbistus,
   #       dzbicrtid LIKE dzbi_t.dzbicrtid,
   #       dzbicrtdt LIKE dzbi_t.dzbicrtdt
   #       END RECORD
   #2016-01-04       

   LOCATE lr_dzbb.dzbb098 IN FILE
          
   #首先取得這次patch清單內且有TOPSTD修改紀錄的程式到dzbb_topstd
   SELECT * FROM ds.dzbb_t
          #topstd有動到
    WHERE (LOWER(dzbbcrtid)='topstd' OR 
           LOWER(dzbbcrtid)='topdev' OR 
           LOWER(dzbbmodid)='topstd' OR 
           LOWER(dzbbmodid)='topdev' 
           ) AND
          #出現在dspatch(更新清單內)
           dzbb001 IN ( SELECT DISTINCT(dzbb001) FROM dspatch.dzbb_t) AND
          #客戶家的程式版本比dspatch(patch包)內更舊
           dzbb001 NOT IN ( SELECT prog_name FROM dspatch.client_newer)      
     INTO TEMP dzbb_topstd
    
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR: topstd修改資料取得失敗!"
      CALL adzp888_topstd_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   SELECT COUNT(*) INTO li_cnt
     FROM dzbb_topstd
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR: topstd修改數量取得失敗!"
      CALL adzp888_topstd_log_file_write(g_msg)
      RETURN FALSE
   END IF
   IF li_cnt = 0 THEN
      LET g_msg = "INFO:無 add-point 須特別處理!"
      CALL adzp888_topstd_log_file_write(g_msg)
      RETURN TRUE
   ELSE 
      #LET g_msg = "INFO:共有 ",li_cnt USING "<<<"," 個 add-point 可能須特別處理!",
      #            "\n----------------------------------------"
      #CALL adzp888_topstd_log_file_write(g_msg)
   END IF   

   #抓取該adp最後修改時間
   LET ls_sql = " SELECT dzbb001,dzbb002,dzbb003  ",
                "        dzbbmoddt,dzbbcrtdt      ",
                "   FROM dzbb_topstd              ",
                "   ORDER BY dzbb001,dzbb002      "
   
   ##顯示此次patch可能會異動的adp by topstd
   #DECLARE adzi888_topstd_pre CURSOR WITH HOLD FROM ls_sql
   #FOREACH adzi888_topstd_pre INTO lr_dzbb.dzbb001,
   #                                lr_dzbb.dzbb002,
   #                                lr_dzbb.dzbb003,
   #                                lr_dzbb.dzbbmoddt,
   #                                lr_dzbb.dzbbcrtdt
   #   LET g_msg = "INFO:",
   #               "程式名稱(",lr_dzbb.dzbb001,"),",
   #               "adp名稱(" ,lr_dzbb.dzbb002,"),",
   #               "adp版次(" ,lr_dzbb.dzbb003 USING "<<<<","),",
   #               "建立時間(" ,lr_dzbb.dzbbmoddt,"),",
   #               "修改時間(" ,lr_dzbb.dzbbcrtdt,")"
   #   CALL adzp888_topstd_log_file_write(g_msg)  
   #END FOREACH
   #INITIALIZE lr_dzbb TO NULL
   
   LET g_msg = "INFO:以下為topstd修改adp清單!" 
   CALL adzp888_topstd_log_file_write(g_msg)  
   
   #抓取該adp最後修改時間
   LET ls_sql = " SELECT dzbb001,dzbb002,dzbb003,dzbb004,dzbb098, ",
                "        dzbbmodid,dzbbmoddt,dzbbcrtid,dzbbcrtdt, ",
                "        (                                        ",
                "        CASE                                     ",
                "        WHEN trim(dzbbmoddt) IS NULL             ",
                "        THEN dzbbcrtdt                           ",
                "        ELSE dzbbmoddt                           ",
                "        END                                      ",
                "        ) max_time                               ",
                "   FROM dzbb_topstd                              ",
                "   ORDER BY dzbb001,dzbb002,dzbb003              "
   
   #抓取topstd修改adp的所有資訊   
   DECLARE adzi888_topstd CURSOR WITH HOLD FROM ls_sql
   FOREACH adzi888_topstd INTO lr_dzbb.dzbb001,
                               lr_dzbb.dzbb002,
                               lr_dzbb.dzbb003,
                               lr_dzbb.dzbb004,
                               lr_dzbb.dzbb098,
                               lr_dzbb.dzbbmodid,
                               lr_dzbb.dzbbmoddt,
                               lr_dzbb.dzbbcrtid,
                               lr_dzbb.dzbbcrtdt,
                               lr_dzbb.max_time
      
      #2016-01-10
      LET li_cnt = 0
      SELECT COUNT(*) INTO li_cnt
        FROM dspatch.dzbb_t
       WHERE dzbb001   = lr_dzbb.dzbb001    #程式名稱
         AND dzbb002   = lr_dzbb.dzbb002    #adp名稱
      IF li_cnt = 0 THEN
         LET g_msg = "-----------------------------------\n",
                     "INFO:標準環境-程式名稱(",lr_dzbb.dzbb001 ,")\n",
                     "INFO:標準環境-adp名稱(",lr_dzbb.dzbb002 ,")\n",
                     "INFO:該adp已不存在於標準(dspatch)中,略過!"
         CALL adzp888_topstd_log_file_write(g_msg)  
         CONTINUE FOREACH    
      END IF 
      #2016-01-10
      
      IF lr_dzbb.max_time IS NULL THEN
         LET g_msg = "-----------------------------------\n",
                     "INFO:客戶環境-程式名稱(",lr_dzbb.dzbb001 ,")\n",
                     "INFO:客戶環境-adp名稱(",lr_dzbb.dzbb002 ,")\n",
                     "INFO:客戶環境-adp設計點版次(",lr_dzbb.dzbb003 USING "<<<<<",")\n",
                     "INFO:客戶環境-adp(客戶)無法取得最後修改時間,不做處理!"
         CALL adzp888_topstd_log_file_write(g_msg)  
         CONTINUE FOREACH         
      END IF
       
      #比較跟標準的時間
      LET li_cnt = 0
      SELECT COUNT(*) INTO li_cnt
        FROM dspatch.dzbb_t
       WHERE dzbb001   = lr_dzbb.dzbb001     #程式名稱
         AND dzbb002   = lr_dzbb.dzbb002     #adp名稱
         #2016-01-20
         AND (dzbbcrtdt >= lr_dzbb.max_time  #時間比較
          OR  dzbbmoddt >= lr_dzbb.max_time) #時間比較
         #2016-01-20
      IF li_cnt = 0 THEN
         #topstd修改時間>標準, 要進行特別處理
         LET g_msg = "-----------------------------------\n",
                     "INFO:客戶環境-程式名稱(",lr_dzbb.dzbb001 ,")\n",
                     "INFO:客戶環境-adp名稱(",lr_dzbb.dzbb002 ,")\n",
                     "INFO:客戶環境-adp設計點版次(",lr_dzbb.dzbb003 USING "<<<<<",")\n",
                     "INFO:客戶環境-adp(客戶)最後修改時間(",lr_dzbb.max_time,")"
         CALL adzp888_topstd_log_file_write(g_msg)        
         
         #顯示patch包內最後修改時間
         SELECT dzbbcrtdt,dzbbmoddt 
           INTO lr_dzbb_time.dzbbcrtdt,lr_dzbb_time.dzbbmoddt
           FROM dspatch.dzbb_t
          WHERE dzbb001 = lr_dzbb.dzbb001    #程式名稱
            AND dzbb002 = lr_dzbb.dzbb002    #adp名稱
            AND dzbb003 = 
                (
                SELECT MAX(dzbb003) 
                  FROM dspatch.dzbb_t
                 WHERE dzbb001 = lr_dzbb.dzbb001 
                   AND dzbb002 = lr_dzbb.dzbb002 
                   GROUP BY dzbb001,dzbb002
                )
         IF lr_dzbb_time.dzbbmoddt IS NOT NULL THEN
            LET g_msg = "INFO:標準環境-最後修改時間(",lr_dzbb_time.dzbbmoddt,")"
         ELSE
            LET g_msg = "INFO:標準環境-最後修改時間(",lr_dzbb_time.dzbbcrtdt,")"
         END IF
         CALL adzp888_topstd_log_file_write(g_msg)
         
         #更新dspatch內adp內容
         SELECT MAX(dzbb003) INTO li_ver
           FROM dspatch.dzbb_t
          WHERE dzbb001 = lr_dzbb.dzbb001
            AND dzbb002 = lr_dzbb.dzbb002
            GROUP BY dzbb001,dzbb002
         IF SQLCA.sqlcode THEN
            LET g_msg = "ERROR: dspatch dzbb_t 資料讀取失敗!"
            CALL adzp888_topstd_log_file_write(g_msg)
            RETURN FALSE
         END IF
         LET g_msg = "INFO:標準環境-最新版次(",li_ver USING "<<<<",")"
         CALL adzp888_topstd_log_file_write(g_msg)
         
         #2016-01-04
         #INITIALIZE lr_dzbi TO NULL
         #SELECT dzba002,dzba009,dzbastus
         #  INTO lr_dzbi.dzbi002,lr_dzbi.dzbi007,lr_dzbi.dzbistus
         #  FROM dzba_t a,
         #       (SELECT MAX(dzaf004) m FROM dzaf_t WHERE dzaf001 = lr_dzbb.dzbb001) b 
         # WHERE dzba001 = lr_dzbb.dzbb001 
         #   AND dzba002 = b.m 
         #   AND dzba003 = lr_dzbb.dzbb002
         #
         #LET lr_dzbi.dzbi001  = lr_dzbb.dzbb001    #來源程式編號(PK) : dzba001
         #LET lr_dzbi.dzbi002  = dzbi002           #來源程式版次     : dzba002
         #LET lr_dzbi.dzbi003  = lr_dzbb.dzbb002    #識別碼名稱(PK)   : dzba003
         #LET lr_dzbi.dzbi004  = lr_dzbb.dzbb003    #識別碼使用版次   : dzba004
         #LET lr_dzbi.dzbi005  = g_patch_m.patch002 #Patch編號(PK)
         #LET lr_dzbi.dzbi006  = '1'                #識別碼類型(PK)   : 
         #                                          #1.add point
         #                                          #2.section
         #LET lr_dzbi.dzbi007  = dzbi007           #下方的硬結構編號整段註解 : dzba009
         #LET lr_dzbi.dzbi008  = 's'                #使用標示
         #LET lr_dzbi.dzbi098  = lr_dzbb.dzbb098    #程式內容 : dzbb098
         ##LET lr_dzbi.dzbistus = dzbistus          #狀態碼   : dzbastus
         #LET lr_dzbi.dzbicrtid = 'adzp888'         #建立人員 : dzbicrtid
         #LET lr_dzbi.dzbicrtdt = cl_get_current()  #建立時間 : dzbicrtdt
         #
         #INSERT INTO ds.dzbi_t 
         #(
         #dzbi001,dzbi002,dzbi003,
         #dzbi004,dzbi005,dzbi006,
         #dzbi007,dzbi098,dzbistus,
         #dzbicrtid,dzbicrtdt
         #)
         #VALUES
         #(
         #lr_dzbi.dzbi001,lr_dzbi.dzbi002,lr_dzbi.dzbi003,
         #lr_dzbi.dzbi004,lr_dzbi.dzbi005,lr_dzbi.dzbi006,
         #lr_dzbi.dzbi007,lr_dzbi.dzbi098,lr_dzbi.dzbistus,
         #lr_dzbi.dzbicrtid,lr_dzbi.dzbicrtdt         
         #)
         #IF SQLCA.sqlcode  THEN
         #   IF SQLCA.sqlcode = -268 THEN
         #      DISPLAY "INFO:資料重複寫入dzbi_t-",lr_dzbi.dzbi001,'-',lr_dzbi.dzbi003,',略過此步驟!'
         #   ELSE
         #      LET g_msg = "ERROR: dzbi_t 資料新增失敗(",SQLCA.sqlcode,")!"
         #      CALL adzp888_topstd_log_file_write(g_msg)
         #      RETURN FALSE
         #   END IF
         #ELSE
         #   DISPLAY "INFO:資料寫入dzbi_t-",lr_dzbi.dzbi001,'-',lr_dzbi.dzbi003  
         #END IF
         #2016-01-04
         
         UPDATE dspatch.dzbb_t
            SET dzbb098   = lr_dzbb.dzbb098,
                dzbbcrtdt = lr_dzbb.dzbbcrtdt,
                dzbbcrtid = lr_dzbb.dzbbcrtid,
                dzbbmoddt = lr_dzbb.dzbbmoddt,
                dzbbmodid = lr_dzbb.dzbbmodid
          WHERE dzbb001   = lr_dzbb.dzbb001
            AND dzbb002   = lr_dzbb.dzbb002
            AND ( 
                dzbb003   = li_ver OR 
                dzbb003   = lr_dzbb.dzbb003
                )
            AND dzbb004 = 's' 
   
         IF SQLCA.sqlcode THEN
            LET g_msg = "ERROR: topstd 資料覆寫失敗!"
            CALL adzp888_topstd_log_file_write(g_msg)
            RETURN FALSE
         END IF
         
         LET g_msg = "INFO:因標準(dspatch)資料較客戶舊,保留topstd修改結果!"
         CALL adzp888_topstd_log_file_write(g_msg)
         
         #2016-12-13
         #IF adzp888_topstd_important(lr_dzbb.dzbb001,lr_dzbb.dzbb003) THEN
         #   LET g_msg = "INFO:保留adp資訊(重要) - ",lr_dzbb.dzbb001,'-',lr_dzbb.dzbb002
         #ELSE
         #   LET g_msg = "INFO:保留adp資訊(一般) - ",lr_dzbb.dzbb001,'-',lr_dzbb.dzbb002 
         #END IF
         LET g_msg = "INFO:保留adp資訊 - ",lr_dzbb.dzbb001,'-',lr_dzbb.dzbb002 
         #2016-12-13
         
         CALL adzp888_topstd_log_file_write(g_msg)
         
         #已完成覆寫
         LET g_msg = "INFO:標準環境-版次覆寫(",lr_dzbb.dzbb003 USING "<<<<",")"
         CALL adzp888_topstd_log_file_write(g_msg)
         IF li_ver <> lr_dzbb.dzbb003 THEN
            LET g_msg = "INFO:標準環境-版次覆寫(",li_ver USING "<<<<",")"
            CALL adzp888_topstd_log_file_write(g_msg)
         END IF
      ELSE   
         SELECT dzbbcrtdt,dzbbmoddt 
           INTO lr_dzbb_time.dzbbcrtdt,lr_dzbb_time.dzbbmoddt
           FROM dspatch.dzbb_t
          WHERE dzbb001   = lr_dzbb.dzbb001    #程式名稱
            AND dzbb002   = lr_dzbb.dzbb002    #adp名稱
            AND dzbb003 = 
                (
                SELECT MAX(dzbb003) 
                  FROM dspatch.dzbb_t
                 WHERE dzbb001 = lr_dzbb.dzbb001 
                   AND dzbb002 = lr_dzbb.dzbb002 
                   GROUP BY dzbb001,dzbb002
                )
      
         #topstd修改時間<標準, 不處理
         LET g_msg = "-----------------------------------\n",
                     "INFO:客戶環境-程式名稱(",lr_dzbb.dzbb001 ,")\n",
                     "INFO:客戶環境-adp名稱(",lr_dzbb.dzbb002 ,")\n",
                     "INFO:客戶環境-adp設計點版次(",lr_dzbb.dzbb003 USING "<<<<<",")\n",
                     "INFO:客戶環境-adp(客戶)最後修改時間(",lr_dzbb.max_time,")\n",
                     "INFO:因標準(dspatch)資料較客戶新,不做特別處理!"
         CALL adzp888_topstd_log_file_write(g_msg)    
         IF lr_dzbb_time.dzbbmoddt IS NOT NULL THEN
            LET g_msg = "INFO:標準環境-最後修改時間(",lr_dzbb_time.dzbbmoddt,")"
         ELSE
            LET g_msg = "INFO:標準環境-最後修改時間(",lr_dzbb_time.dzbbcrtdt,")"
         END IF
         CALL adzp888_topstd_log_file_write(g_msg)        
         
      END IF

   END FOREACH
   IF SQLCA.sqlcode THEN
      LET g_msg = "ERROR: adzi888_topstd 時間資訊取得!"
      CALL adzp888_topstd_log_file_write(g_msg)
      RETURN FALSE
   END IF
   
   FREE lr_dzbb.dzbb098
   
   LET g_msg = "-----------------------------------\n"
   CALL adzp888_topstd_log_file_write(g_msg) 
   
   RETURN TRUE
   
END FUNCTION
#2016-11-11

#2016-12-13
PRIVATE FUNCTION adzp888_version()
   DISPLAY ""
   DISPLAY "adzp888 import&merge 版本為:1.01.06 build-20170120 "
   DISPLAY ""
END FUNCTION

#PRIVATE FUNCTION adzp888_topstd_important(ps_prog,ps_ver)
#   DEFINE ps_prog LIKE type_t.chr50
#   DEFINE ps_ver  LIKE type_t.num5
#   
#   SELECT COUNT(*) FROM 
#   (
#   SELECT count(*) cnt,dzbb001,dzbb003
#   FROM dzbb_t 
#   WHERE dzbb001='axmt500' 
#   AND dzbb003 >= 3 
#   GROUP BY dzbb001,dzbb003
#   ) flt
#   where flt.cnt > 1
#   
#END FUNCTION
#2016-12-13
