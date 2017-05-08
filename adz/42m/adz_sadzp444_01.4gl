#+ 程式版本......: T6 Version 1.00.00 Build-0001 AT 12/12/21
#
#+ 程式代碼......: sadzp444_01
#+ 設計人員......: madey
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp444_01.4gl 
# Description    : 註冊資訊[清單]匯出
# Memo           :

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp444_global.inc"

DEFINE g_work_dir           STRING     #目前程式執行路徑
DEFINE g_error_message      STRING     #錯誤訊息
DEFINE g_alm_tar_path       STRING     #ALM執行匯出/入時,tar放置完整路徑

#+ 建立temp table
PUBLIC FUNCTION sadzp444_01_crate_temp_table()
   #Create temp TABLE 程式註冊資料匯出主檔
   CREATE TEMP TABLE adzp444_master
   (
      master001       VARCHAR(50),   #GUID
      master002       VARCHAR(50),   #匯出主題
      master003       VARCHAR(10),   #匯出人員
      master004       VARCHAR(10),   #自動產生類型
      master005       VARCHAR(1),    #程式類型
      master006       VARCHAR(20),   #作業代號
      master007       DATE,          #資料起始時間
      master008       DATE,          #資料結束時間
      master009       DATE,          #匯出時間
      master010       DATE,          #匯入時間
      master011       VARCHAR(1),    #自動產生註冊資料清單否
      master012       VARCHAR(20),   #註冊資訊資料清單建立區域
      master013       VARCHAR(20),   #需求單號
      master014       INTEGER        #作業項次
   )

   #Create temp TABLE 設計資料匯出清單
   CREATE TEMP TABLE adzp444_ddata
   (
      ddata001       VARCHAR(50),   #GUID
      ddata002       INTEGER,       #序號
      ddata003       VARCHAR(20),   #作業代號
      ddata004       VARCHAR(1),    #匯入動作
      ddata005       VARCHAR(20),   #維護作業
      ddata006       VARCHAR(50),   #條件式1
      ddata007       VARCHAR(50),   #條件式2
      ddata008       VARCHAR(1),    #匯出狀態
      ddata009       VARCHAR(1),    #匯入狀態
      ddata010       VARCHAR(1)     #清單資料產生方式
   )

   #Create temp TABLE 檔案匯出清單
   CREATE TEMP TABLE adzp444_dfile
   (
      dfile001       VARCHAR(50),   #GUID
      dfile002       INTEGER,       #序號
      dfile003       VARCHAR(200),  #路徑
      dfile004       VARCHAR(1),    #類型
      dfile005       VARCHAR(50),   #檔名
      dfile006       VARCHAR(1),    #匯出狀態
      dfile007       VARCHAR(1)     #匯入狀態
   )
   
   ####Create temp TABLE 設計資料匯出清單
   ###CREATE TEMP TABLE adzp444_dtable
   
   ###   dtable001       VARCHAR(50),   #GUID
   ###   dtable002       INTEGER,       #序號
   ###   dtable003       VARCHAR(20),   #資料表代碼
   ###   dtable004       VARCHAR(50)    #匯出檔案名稱
   ###)

END FUNCTION

#+ drop TEMP TABLE
PUBLIC FUNCTION sadzp444_01_drop_temp_table()
   DROP TABLE adzp444_master
   DROP TABLE adzp444_ddata
   DROP TABLE adzp444_dfile
END FUNCTION



#+ alm端執行註冊資訊[清單]+[資料]匯出作業
PUBLIC FUNCTION sadzp444_01_alm_export(p_master013, p_master014)
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次

   DEFINE l_master_m        type_g_master_m       #程式註冊資料匯出主檔
   #DEFINE l_ddata_d         type_g_ddata_d        #設計資料匯出清單
   #DEFINE l_dfile_d         type_g_dfile_d        #檔案匯出清單
   DEFINE l_pack_dir        STRING                #打包檔置放路徑
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_folder          STRING                #匯出檔目錄
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   CALL sadzp444_01_crate_temp_table()
   
   LET g_show_msg = "N"     #背景模式操作
   CALL sadzp444_01_init()

   #取得[需求單號]+[項次]的設計資料匯出清單
   INSERT INTO adzp444_ddata
     SELECT dzld001, dzld002, dzld003, dzld004, dzld005,
            dzld006, dzld007, dzld008, dzld009, dzld010
       FROM dzld_t
       WHERE dzld011 = p_master013
         AND dzld012 = g_dzld012
         AND dzld013 = g_dzld013
         AND dzld014 = p_master014

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-INSERT adzp444_ddata:", cl_getmsg(SQLCA.sqlcode, g_lang)
      RETURN FALSE, g_error_message
   END IF

   SELECT COUNT(*) INTO l_cnt FROM adzp444_ddata
   DISPLAY "adzp444_ddata count(*):", l_cnt 

   IF l_cnt = 0 THEN
      LET g_error_message = "Info:", cl_getmsg_parm("adz-00355", g_lang, p_master013 || "|" || p_master014)
      RETURN FALSE, g_error_message
   END IF

   #取得匯出主檔單頭資訊
   SELECT DISTINCT dzld001, dzld011, dzld014 
       INTO l_master_m.master001, l_master_m.master013, l_master_m.master014 
     FROM dzld_t
     WHERE dzld011 = p_master013
       AND dzld012 = g_dzld012
       AND dzld013 = g_dzld013
       AND dzld014 = p_master014

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-SELECT adzp444_ddata:", cl_getmsg(SQLCA.sqlcode, g_lang)
      RETURN FALSE, g_error_message
   END IF

   IF cl_null(l_master_m.master001) THEN
      LET g_error_message = "ERROR:", cl_getmsg("adz-00335", g_lang)
      RETURN FALSE, g_error_message
   END IF

   #取得匯出主題
   LET l_master_m.master002 = l_master_m.master013, "#", l_master_m.master014 USING "<<<<<"
   
   INSERT INTO adzp444_master(master001, master002, master003, master004, master005,
                              master006, master007, master008, master009, master010, 
                              master011, master012, master013, master014)
     VALUES (l_master_m.master001, l_master_m.master002, l_master_m.master003, l_master_m.master004, l_master_m.master005, 
             l_master_m.master006, l_master_m.master007, l_master_m.master008, l_master_m.master009, l_master_m.master010, 
             l_master_m.master011, l_master_m.master012, l_master_m.master013, l_master_m.master014) 
 
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-INSERT adzp444_master:", cl_getmsg(SQLCA.sqlcode, g_lang)
      RETURN FALSE, g_error_message 
   END IF
               
   #切換到$TEMPDIR工作目錄下
   LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
   
   IF NOT sadzp444_01_change_pack_dir(l_pack_dir) THEN
      RETURN FALSE, g_error_message
   END IF

   #LET l_folder = l_master_m.master002
   LET l_folder = sadzp444_01_get_folder_name(l_master_m.master002, l_master_m.master003)

   #註冊資訊[清單]+[資料]匯出作業
   IF NOT sadzp444_01_export(l_master_m.master001, l_master_m.master013, l_master_m.master014, l_pack_dir, l_folder) THEN
      DISPLAY "sadzp444_01_export is error."
      RETURN FALSE, g_error_message
   END IF

   #切換回正確程式執行路徑
   IF NOT sadzp444_01_change_work_dir() THEN
      RETURN FALSE, g_error_message
   END IF

   CALL sadzp444_01_drop_temp_table()

   LET g_error_message = ""

   IF cl_null(g_alm_tar_path) THEN
      DISPLAY "ERROR:g_alm_tar_path is error."
      RETURN FALSE, g_error_message
   END IF
   
   RETURN TRUE, g_alm_tar_path
END FUNCTION

#+ alm端執行註冊資訊[清單]+[資料]匯入作業
PUBLIC FUNCTION sadzp444_01_alm_import(p_alm_tar_path)
   #DEFINE p_master013       LIKE type_t.chr20     #需求單號
   #DEFINE p_master014       LIKE type_t.num5      #作業項次
   DEFINE p_alm_tar_path    STRING                #ALM執行匯出/入時,tar放置完整路徑

   DEFINE l_master_m        type_g_master_m       #程式註冊資料匯出主檔
   #DEFINE l_ddata_d         type_g_ddata_d        #設計資料匯出清單
   #DEFINE l_dfile_d         type_g_dfile_d        #檔案匯出清單
   DEFINE l_pack_dir        STRING                #打包檔置放路徑
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_folder          STRING                #匯出檔目錄
   DEFINE l_tar_name        STRING                #匯出包名稱
   DEFINE l_idx             LIKE type_t.num5
   DEFINE l_cmd             STRING
   DEFINE l_file            STRING
   DEFINE l_sql             STRING
   DEFINE l_temp            STRING
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   CALL sadzp444_01_crate_temp_table()

   LET g_show_msg = "N"     #背景模式操作
   CALL sadzp444_01_init()
   
   #檢查tar是否存在
   IF NOT os.Path.EXISTS(p_alm_tar_path) THEN
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00328", g_lang, p_alm_tar_path.trim())
      RETURN FALSE, g_error_message
   END IF
   
   #切換到$TEMPDIR工作目錄下
   LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
   
   IF NOT sadzp444_01_change_pack_dir(l_pack_dir) THEN
      RETURN FALSE, g_error_message
   END IF

   #取得tar檔案名稱
   LET l_tar_name = os.Path.basename(p_alm_tar_path.trim())

   #取得匯出檔的目錄名稱
   LET l_idx = l_tar_name.getIndexOf(".tar", 1)
   IF l_idx > 1 THEN
      LET l_folder = l_tar_name.subString(1, l_idx - 1)
   END IF

   IF cl_null(l_tar_name) OR cl_null(l_folder) THEN
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00331", g_lang, l_tar_name.trim())
      RETURN FALSE, g_error_message
   END IF

   #檢查目錄是否存在
   IF os.Path.EXISTS(l_folder) THEN
      #刪除目錄
      LET l_cmd = "rm -rf ", l_folder
      RUN l_cmd
   END IF

   #解包成tar檔範例:tar xvf $FOLDER.tar
   LET l_cmd = "tar xvf ", p_alm_tar_path.trim()
   RUN l_cmd

   ####切換到新目錄下,準備讀取匯入檔
   ###IF (NOT os.Path.EXISTS(l_folder)) OR (NOT os.Path.chdir(l_folder)) THEN
   ###   LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_folder.trim())
   ###   RETURN FALSE, g_error_message
   ###END IF

   #匯入[程式註冊資料匯出主檔]
   LET l_file = os.Path.JOIN(l_folder.trim(), "Temp-adzp444_master.unl")
   LET l_sql = "INSERT INTO adzp444_master "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      LET g_error_message = "ERROR-LOAD FROM " || l_file.trim() || ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE, g_error_message
   END IF
   
   #匯入[設計資料匯出清單]
   LET l_file =  os.Path.JOIN(l_folder.trim(), "Temp-adzp444_ddata.unl")
   LET l_sql = "INSERT INTO adzp444_ddata "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      LET g_error_message = "ERROR-LOAD FROM " || l_file.trim() || ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE, g_error_message
   END IF
   
   #取得[程式註冊資料匯出主檔]
   SELECT COUNT(*) INTO l_cnt FROM adzp444_master
   IF l_cnt <> 1 THEN
      LET g_error_message = "ERROR-SELECT adzp444_ddata cnt:", cl_getmsg("adz-00335", g_lang)
      RETURN FALSE, g_error_message
   END IF

   SELECT master001, master002, master003, master004, master005, 
          master006, master007, master008, master009, master010, 
          master011, master012, master013, master014
     INTO l_master_m.master001, l_master_m.master002, l_master_m.master003, l_master_m.master004, l_master_m.master005, 
          l_master_m.master006, l_master_m.master007, l_master_m.master008, l_master_m.master009, l_master_m.master010, 
          l_master_m.master011, l_master_m.master012, l_master_m.master013, l_master_m.master014
     FROM adzp444_master

   IF cl_null(l_master_m.master001) THEN
      LET g_error_message = "ERROR-SELECT adzp444_ddata master001:", cl_getmsg("adz-00335", g_lang)
      RETURN FALSE, g_error_message
   END IF
   
   #註冊資訊[清單]+[資料]匯入作業
   IF NOT sadzp444_01_import(l_master_m.master001, l_master_m.master013, l_master_m.master014, l_pack_dir, l_folder) THEN
      DISPLAY "sadzp444_01_import is error."
      RETURN FALSE, g_error_message
   END IF

   #切換回正確程式執行路徑
   IF NOT sadzp444_01_change_work_dir() THEN
      RETURN FALSE, g_error_message
   END IF

   CALL sadzp444_01_drop_temp_table()

   LET g_error_message = ""

   #下載成功後,從Server端刪除相關檔案
   #刪除目錄
   LET l_temp = os.Path.JOIN(l_pack_dir.trim(), l_folder.trim())
   IF os.Path.EXISTS(l_temp) THEN
      LET l_cmd = "rm -rf ", l_temp
      RUN l_cmd
   END IF
      
   #刪除tar檔
   LET l_temp = os.Path.JOIN(l_pack_dir.trim(), l_tar_name.trim())
   IF os.Path.EXISTS(l_temp) THEN
      LET l_cmd = "rm ", l_temp
      RUN l_cmd
   END IF
      
   RETURN TRUE, ""
END FUNCTION






#+ 註冊資訊[清單]+[資料]匯出作業
PUBLIC FUNCTION sadzp444_01_export(p_master001, p_master013, p_master014, p_pack_dir, p_folder)
   DEFINE p_master001       LIKE type_t.chr50
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   DEFINE p_pack_dir        STRING                #打包檔置放路徑
   DEFINE p_folder          STRING                #匯出檔目錄
   
   DEFINE l_cmd             STRING
   DEFINE l_tar_name        STRING                #匯出包名稱
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_str             STRING
   DEFINE l_master009       LIKE type_t.dat       #匯出時間

   IF cl_null(p_folder) THEN
      CALL cl_err("", "adz-00349", 0)
      LET g_error_message = "ERROR:", cl_getmsg("adz-00349", g_lang)
      RETURN FALSE
   END IF
   
   LET l_tar_name = p_folder, ".tar"   

   IF NOT sadzp444_01_make_pack_dir(p_folder, l_tar_name) THEN
      RETURN FALSE
   END IF

   #檢查設計資料匯出清單是否有資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM adzp444_ddata

   IF l_cnt > 0 THEN
      IF NOT sadzp444_01_export_data(p_master001, p_master013, p_master014) THEN
         RETURN FALSE
      END IF
   END IF

   #檢查檔案匯出清單是否有資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM adzp444_dfile

   IF l_cnt > 0 THEN
      IF NOT sadzp444_01_export_file(p_master001, p_pack_dir, p_folder) THEN
         RETURN FALSE
      END IF
   END IF

   #更新匯出時間為目前時間
   LET l_master009 = cl_get_current()
   
   UPDATE adzp444_master SET master009 = l_master009
     WHERE master001 = p_master001
   
   #匯出此次打包清單資訊
   IF NOT sadzp444_01_export_pack_list(p_master001) THEN
      RETURN FALSE
   END IF

   #返回上一層目錄
   LET l_str = os.Path.pwd()
   LET l_str = os.Path.dirname(l_str)
   IF NOT os.Path.chdir(l_str) THEN
      CALL cl_err_msg(NULL, "adz-00340", l_str.trim(), 1)
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, l_str.trim())
      RETURN FALSE
   END IF

   #打包成tar檔範例:tar cvf $FOLDER.tar $FOLDER
   LET l_cmd = "tar cvf ", l_tar_name CLIPPED, " ", p_folder CLIPPED
   RUN l_cmd

   IF STATUS THEN
      CALL cl_err("tar cvf " || l_tar_name CLIPPED, STATUS, 1)
      LET g_error_message = "ERROR-tar cvf ", l_tar_name CLIPPED, ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF

   #是否為背景執行
   IF g_show_msg = "Y" THEN
      CALL cl_ask_confirm3("adz-00342", l_tar_name.trim())
   ELSE
      DISPLAY "Info:", cl_getmsg("adz-00342", g_lang)
   END IF

   #匯出包tar檔所在完整路徑
   LET g_alm_tar_path = os.Path.JOIN(l_str.trim(), l_tar_name.trim())
   
   #LET g_export_flag = TRUE
   RETURN TRUE
END FUNCTION

#+ 初始化
PUBLIC FUNCTION sadzp444_01_init()
   DEFINE l_sql             STRING
   
   LET g_error_message = ""
   LET g_alm_tar_path = ""
   
   LET g_alm_jb = FGL_GETENV("DGENV")
   IF cl_null(g_alm_jb) THEN
      LET g_alm_jb = g_dgenv_c
   END IF
  
   #是否為背景執行
   IF g_show_msg = "N" THEN
      LET g_bgjob = "Y"
   END IF
   
   LET g_dzld012 = FGL_GETENV("ERPID")     #產品代號
   LET g_dzld013 = FGL_GETENV("ERPVER")    #產品版本

   
   #取得[匯入動作為1:Merge or 2:Insert]取得所有相關註冊資訊清單
   LET l_sql = "SELECT ddata002, ddata003, ddata004, ddata005, ddata006, ",
               "       ddata007, ddata008, ddata009, ddata010 ",
               "  FROM adzp444_ddata LEFT JOIN adzp444_master ON ddata001 = master001 ",
               "  WHERE ddata001 = ? ",
               "    AND (ddata004 = '1' OR ddata004 = '2') ",
               "  ORDER BY ddata002 "
   DECLARE sadzp444_01_ddata_exp_cs CURSOR WITH HOLD FROM l_sql
   
   #取得所有相關註冊資訊資料清單
   LET l_sql = "SELECT ddata002, ddata003, ddata004, ddata005, ddata006, ",
               "       ddata007, ddata008, ddata009, ddata010 ",
               "  FROM adzp444_ddata LEFT JOIN adzp444_master ON ddata001 = master001 ",
               "  WHERE ddata001 = ? ",
               "  ORDER BY ddata002 "
   DECLARE sadzp444_01_ddata_imp_cs CURSOR WITH HOLD FROM l_sql

   #取得相關註冊維護作業[資料表代碼]清單
   LET l_sql = "SELECT dzyb001, dzyb002, dzyb003, dzyb004, dzyb005, ",
               "       dzyb006, dzyb007 ",
               "  FROM dzyb_t ",
               "  WHERE dzyb001 = ? "
   DECLARE sadzp444_01_dzyb_cs CURSOR WITH HOLD FROM l_sql
   
   #取得所有相關檔案匯出清單
   LET l_sql = "SELECT dfile002, dfile003, dfile004, dfile005, dfile006, ",
               "       dfile007 ",
               "  FROM adzp444_dfile LEFT JOIN adzp444_master ON dfile001 = master001 ",
               "  WHERE dfile001 = ? ",
               "  ORDER BY dfile002 "
   DECLARE sadzp444_01_dfile_cs CURSOR FROM l_sql
   
END FUNCTION

#+ 切換工作路徑到製造匯出檔的工作目錄下
PUBLIC FUNCTION sadzp444_01_change_pack_dir(p_pack_dir)
   DEFINE p_pack_dir        STRING     #打包檔置放路徑
   
   #記錄目前程式執行路徑
   LET g_work_dir = os.Path.pwd()
   
   IF NOT os.Path.chdir(p_pack_dir) THEN
      CALL cl_err_msg(NULL, "adz-00340", p_pack_dir.trim(), 1)
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, p_pack_dir.trim())
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ 建立匯出包目錄
PUBLIC FUNCTION sadzp444_01_make_pack_dir(p_folder, p_tar_name)
   DEFINE p_folder          STRING     #匯出檔目錄
   DEFINE p_tar_name        STRING     #匯出包名稱

   IF cl_null(p_folder) THEN
      CALL cl_err("", "adz-00349", 0)
      LET g_error_message = "ERROR:", cl_getmsg("adz-00349", g_lang)
      RETURN FALSE
   END IF
   
   #先刪除已存在的匯出包目錄和tar檔
   IF NOT sadzp444_01_delete_pack(p_folder, p_tar_name) THEN
      RETURN FALSE
   END IF
   
   #重新建立目錄
   IF NOT os.Path.mkdir(p_folder) THEN
      CALL cl_err_msg(NULL, "adz-00341", p_folder.trim(), 1)
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00341", g_lang, p_folder.trim())
      RETURN FALSE
   END IF

   #切換到新目錄下,準備將匯出檔皆置於此目錄下
   IF (NOT os.Path.EXISTS(p_folder)) OR (NOT os.Path.chdir(p_folder)) THEN
      CALL cl_err_msg(NULL, "adz-00340", p_folder.trim(), 1)
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, p_folder.trim())
      RETURN FALSE
   END IF   

   RETURN TRUE
END FUNCTION

#+ 刪除匯出包目錄和tar檔
PUBLIC FUNCTION sadzp444_01_delete_pack(p_folder, p_tar_name)
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
         LET l_cmd = "rm ", p_tar_name
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
      LET l_cmd = "rm ", p_tar_name
      RUN l_cmd
   END IF

   RETURN TRUE
END FUNCTION

#+ 切換工作路徑到原本程式執行路徑下
PUBLIC FUNCTION sadzp444_01_change_work_dir()

   IF cl_null(g_work_dir) THEN
      CALL cl_err("", "adz-00350", 1)
      LET g_error_message = "ERROR:", cl_getmsg("adz-00350", g_lang)
      RETURN FALSE
   END IF
   
   #切換回正確程式執行路徑
   IF NOT os.Path.chdir(g_work_dir) THEN
      CALL cl_err_msg(NULL, "adz-00340", g_work_dir.trim(), 1)
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, g_work_dir.trim())
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ 註冊資訊[資料]匯出
PUBLIC FUNCTION sadzp444_01_export_data(p_master001, p_master013, p_master014)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   
   DEFINE l_file            STRING
   DEFINE l_sql             STRING
   DEFINE l_pack_ddata      type_g_ddata_d
   DEFINE l_ddata008        LIKE type_t.chr1      #匯出狀態(0:建立; 1:成功; 2:失敗)
   DEFINE l_pack_dzyb       type_g_dzyb

   #找出[匯入動作為1:Merge or 2:Insert]的註冊資訊
   FOREACH sadzp444_01_ddata_exp_cs USING p_master001
                                    INTO l_pack_ddata.ddata002, l_pack_ddata.ddata003, l_pack_ddata.ddata004, l_pack_ddata.ddata005, l_pack_ddata.ddata006,  
                                         l_pack_ddata.ddata007, l_pack_ddata.ddata008, l_pack_ddata.ddata009, l_pack_ddata.ddata010
      IF SQLCA.sqlcode THEN
         CALL cl_err("FOREACH sadzp444_01_ddata_exp_cs:", SQLCA.sqlcode, 1)
         LET g_error_message = "ERROR-FOREACH sadzp444_01_ddata_exp_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         RETURN FALSE
      END IF

      ####不再重做已[匯出成功]清單
      ###IF l_pack_ddata.ddata008 = "1" THEN
      ###   CONTINUE FOREACH
      ###END IF

      LET l_ddata008 = "1"

      #取得該註冊資訊維護作業[資料表代碼]清單
      FOREACH sadzp444_01_dzyb_cs USING l_pack_ddata.ddata005
                                   INTO l_pack_dzyb.dzyb001, l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb005, 
                                        l_pack_dzyb.dzyb006, l_pack_dzyb.dzyb007
         IF SQLCA.sqlcode THEN
            CALL cl_err("FOREACH sadzp444_01_dzyb_cs:", SQLCA.sqlcode, 1)
            LET g_error_message = "ERROR-FOREACH sadzp444_01_dzyb_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
            LET l_ddata008 = "2"
            EXIT FOREACH
         END IF

         LET l_file = l_pack_ddata.ddata002 USING "<<<<<", "-", l_pack_dzyb.dzyb002 CLIPPED, ".unl"
         LET l_sql = "SELECT * FROM ", l_pack_dzyb.dzyb002 CLIPPED, 
                     "    WHERE ", l_pack_dzyb.dzyb004 CLIPPED, " = '", l_pack_ddata.ddata006 CLIPPED, "' "

         #檢查是否需要加入第二條件式
         IF NOT cl_null(l_pack_ddata.ddata007) THEN
            DISPLAY "l_pack_ddata.ddata007 is not null."
            LET l_sql = l_sql, " AND ", l_pack_dzyb.dzyb004 CLIPPED, " = '", l_pack_ddata.ddata007 CLIPPED, "' "
         END IF

         #DISPLAY "UNLOAD TO :", l_file.trim(), " ", l_sql.trim()
         UNLOAD TO l_file l_sql
      
         IF STATUS THEN
            CALL cl_err("UNLOAD TO " || l_file.trim(), STATUS, 1)
            LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(STATUS, g_lang)
            LET l_ddata008 = "2"
            EXIT FOREACH
         END IF
      END FOREACH

      #更新匯出狀態
      UPDATE adzp444_ddata SET ddata008 = l_ddata008
        WHERE ddata001 = p_master001
          AND ddata002 = l_pack_ddata.ddata002

      #如果為標準環境,需和ALM需求單結合
      IF g_alm_jb = g_dgenv_s THEN
         #同步回ALM需求單
         UPDATE dzld_t SET dzld008 = l_ddata008
           WHERE dzld002 = l_pack_ddata.ddata002
             AND dzld011 = p_master013
             AND dzld012 = g_dzld012
             AND dzld013 = g_dzld013
             AND dzld014 = p_master014
      END IF
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 註冊資訊[檔案]匯出
PUBLIC FUNCTION sadzp444_01_export_file(p_master001, p_pack_dir, p_folder)
   DEFINE p_master001       LIKE type_t.chr50  #GUID
   DEFINE p_pack_dir        STRING             #打包檔置放路徑
   DEFINE p_folder          STRING             #匯出檔所在目錄
   
   DEFINE l_dfile           type_g_dfile_d
   DEFINE l_cmd             STRING
   DEFINE l_source          STRING
   DEFINE l_dest            STRING
   DEFINE l_tar_name        STRING
   DEFINE l_dfile003_str    STRING
   DEFINE l_dfile006        LIKE type_t.chr1   #匯出狀態(0:建立; 1:成功; 2:失敗) 
   
   #找出[檔案匯出清單]
   FOREACH sadzp444_01_dfile_cs USING p_master001 
                                INTO l_dfile.dfile002, l_dfile.dfile003, l_dfile.dfile004, l_dfile.dfile005, l_dfile.dfile006, 
                                     l_dfile.dfile007
      IF SQLCA.sqlcode THEN
         CALL cl_err("FOREACH sadzp444_01_dfile_cs:", SQLCA.sqlcode, 1)
         LET g_error_message = "ERROR-FOREACH sadzp444_01_dfile_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         RETURN FALSE
      END IF

      ####不再重做已[匯出成功]清單
      ###IF l_dfile.dfile006 = "1" THEN
      ###   CONTINUE FOREACH
      ###END IF

      #檔案類型為[f:檔案],cp {路徑}/{檔名} $FOLDER/f#
      #檔案類型為[d:整個目錄結構],tar cvf $FOLDER/d# {檔名}
      LET l_cmd = ""
      CASE l_dfile.dfile004 CLIPPED
         WHEN "f"
            LET l_source = os.Path.JOIN(l_dfile.dfile003 CLIPPED, l_dfile.dfile005 CLIPPED)
            LET l_dest = os.Path.JOIN(os.Path.JOIN(p_pack_dir, p_folder), l_dfile.dfile005 CLIPPED)
            LET l_cmd = "cp ", l_source.trim(), " ", l_dest.trim()

         WHEN "d"
            #製作tar檔
            #指定tar檔名稱
            LET l_tar_name = l_dfile.dfile005 CLIPPED, ".tar"
            LET l_source = l_dfile.dfile005 CLIPPED
            LET l_dest = os.Path.JOIN(os.Path.JOIN(p_pack_dir, p_folder), l_tar_name)
            
            LET l_cmd = "cd ", l_dfile.dfile003 CLIPPED, ";"
            LET l_cmd = l_cmd, "tar cvf ", l_dest.trim(), " ", l_source.trim()
      END CASE

      LET l_dfile006 = "2"

      #檢查檔案是否存在
      LET l_dfile003_str = sadzp444_01_get_path(l_dfile.dfile003 CLIPPED)
      LET l_dfile003_str = os.Path.JOIN(l_dfile003_str, l_dfile.dfile005 CLIPPED)
                  
      IF NOT os.Path.EXISTS(l_dfile003_str) THEN
         CALL cl_err_msg(NULL, "adz-00339", l_source.trim(), 1)
         LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_dfile003_str.trim())
         RETURN FALSE
      ELSE
         #複製檔案
         DISPLAY "l_cmd:", l_cmd, ";"
         RUN l_cmd
      
         IF STATUS THEN
            CALL cl_err_msg(NULL, "adz-00338", l_source.trim(), 1)
            LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00338", g_lang, l_source.trim())
            RETURN FALSE
         END IF
         
         LET l_dfile006 = "1"
      END IF

      #更新匯出狀態
      UPDATE adzp444_dfile SET dfile006 = l_dfile006
        WHERE dfile001 = p_master001 
          AND dfile002 = l_dfile.dfile002
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 匯出此次打包清單資訊
PUBLIC FUNCTION sadzp444_01_export_pack_list(p_master001)
   DEFINE p_master001       LIKE type_t.chr50  #GUID
   
   DEFINE l_cmd             STRING
   DEFINE l_file            STRING
   DEFINE l_sql             STRING
   
   #匯出[程式註冊資料匯出主檔]
   #LET l_cmd = "unloadx ", g_dbs CLIPPED, " adzp444_master.unl ", 
   #            """SELECT * FROM adzp444_master WHERE master001 = '", g_master_m.master001 CLIPPED, "' """
   #RUN l_cmd
   LET l_file = "Temp-", "adzp444_master.unl"
   LET l_sql = "SELECT * FROM adzp444_master WHERE master001 = '", p_master001 CLIPPED, "' "
   UNLOAD TO l_file l_sql
   
   IF STATUS THEN
      CALL cl_err("UNLOAD TO " || l_file.trim(), STATUS, 1)
      LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF
   
   #匯出[設計資料匯出清單]
   LET l_file = "Temp-", "adzp444_ddata.unl"
   LET l_sql = "SELECT * FROM adzp444_ddata WHERE ddata001 = '", p_master001 CLIPPED, "' "
   UNLOAD TO l_file l_sql
   
   IF STATUS THEN
      CALL cl_err("UNLOAD TO " || l_file.trim(), STATUS, 1)
      LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF
   
   #匯出[檔案匯出清單]
   LET l_file = "Temp-", "adzp444_dfile.unl"
   LET l_sql = "SELECT * FROM adzp444_dfile WHERE dfile001 = '", p_master001 CLIPPED, "' "
   UNLOAD TO l_file l_sql
   
   IF STATUS THEN
      CALL cl_err("UNLOAD TO " || l_file.trim(), STATUS, 1)
      LET g_error_message = "ERROR-UNLOAD TO ", l_file.trim(), ":", cl_getmsg(STATUS, g_lang)
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

















#+ 程式註冊資料匯入前置作業
PUBLIC FUNCTION sadzp444_01_import(p_master001,  p_master013, p_master014, p_pack_dir, p_folder)
   DEFINE p_master001       LIKE type_t.chr50
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   DEFINE p_pack_dir        STRING                #打包檔置放路徑
   DEFINE p_folder          STRING                #匯出檔目錄
   
   DEFINE l_tar_name        STRING                #匯出包名稱
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_master010       LIKE type_t.dat
   
   IF cl_null(p_folder) THEN
      CALL cl_err("", "adz-00349", 0)
      LET g_error_message = "ERROR:", cl_getmsg("adz-00349", g_lang)
      RETURN FALSE
   END IF
   
   LET l_tar_name = p_folder, ".tar"   

   #切換到新目錄下,準備讀取所有匯出檔
   IF (NOT os.Path.EXISTS(p_folder)) OR (NOT os.Path.chdir(p_folder)) THEN
      CALL cl_err_msg(NULL, "adz-00340", p_folder.trim(), 1)
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, p_folder.trim())
      RETURN FALSE
   END IF

   #註冊資訊[資料]匯入
   IF NOT sadzp444_01_import_data(p_master001, p_master013, p_master014) THEN
      RETURN FALSE
   END IF

   #[檔案]匯出清單匯入
   #檢查檔案匯出清單是否有資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM adzp444_dfile

   IF l_cnt > 0 THEN
      IF NOT sadzp444_01_import_file(p_master001, p_pack_dir, p_folder) THEN
         RETURN FALSE
      END IF
   END IF
   
   #更新匯入時間為目前時間
   LET l_master010 = cl_get_current()
   
   UPDATE adzp444_master SET master010 = l_master010
     WHERE master001 = p_master001

   #是否為背景執行
   IF g_show_msg = "Y" THEN
      CALL cl_ask_confirm3("adz-00346", l_tar_name.trim())
   ELSE
      DISPLAY "Info:", cl_getmsg("adz-00346", g_lang)
   END IF

   RETURN TRUE
END FUNCTION

#+ 註冊資訊[資料]匯入
PUBLIC FUNCTION sadzp444_01_import_data(p_master001, p_master013, p_master014)
   DEFINE p_master001       LIKE type_t.chr50     #GUID
   DEFINE p_master013       LIKE type_t.chr20     #需求單號
   DEFINE p_master014       LIKE type_t.num5      #作業項次
   
   DEFINE l_pack_ddata      type_g_ddata_d
   DEFINE l_ddata009        LIKE type_t.chr1            #匯入狀態(0:建立; 1:成功; 2:失敗)
   DEFINE l_pack_dzyb       type_g_dzyb
   
   #找出所有需匯入處理的註冊資訊清單
   FOREACH sadzp444_01_ddata_imp_cs USING p_master001
                                    INTO l_pack_ddata.ddata002, l_pack_ddata.ddata003, l_pack_ddata.ddata004, l_pack_ddata.ddata005, l_pack_ddata.ddata006,  
                                         l_pack_ddata.ddata007, l_pack_ddata.ddata008, l_pack_ddata.ddata009, l_pack_ddata.ddata010
      IF SQLCA.sqlcode THEN
         CALL cl_err("FOREACH sadzp444_01_ddata_imp_cs:", SQLCA.sqlcode, 1)
         LET g_error_message = "ERROR-FOREACH sadzp444_01_ddata_imp_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         RETURN FALSE
      END IF

      ####不再重做已[匯入成功]清單
      ###IF l_pack_ddata.ddata009 = "1" THEN
      ###   CONTINUE FOREACH
      ###END IF

      BEGIN WORK
      LET l_ddata009 = "1"

      #取得該註冊資訊維護作業[資料表代碼]清單
      FOREACH sadzp444_01_dzyb_cs USING l_pack_ddata.ddata005
                                  INTO l_pack_dzyb.dzyb001, l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb003, l_pack_dzyb.dzyb004, l_pack_dzyb.dzyb005, 
                                       l_pack_dzyb.dzyb006, l_pack_dzyb.dzyb007
         IF SQLCA.sqlcode THEN
            CALL cl_err("FOREACH sadzp444_01_dzyb_cs:", SQLCA.sqlcode, 1)
            LET g_error_message = "ERROR-FOREACH sadzp444_01_dzyb_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
            LET l_ddata009 = "2"
            EXIT FOREACH
         END IF

         #匯入註冊資訊Data
         CASE l_pack_ddata.ddata004 CLIPPED
            WHEN "1"     #Merge
               IF sadzp444_01_pack_del_data(l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb004, l_pack_ddata.ddata006, l_pack_ddata.ddata007) THEN
                  IF NOT sadzp444_01_pack_ins_data(l_pack_ddata.ddata002, l_pack_dzyb.dzyb002,  l_pack_ddata.ddata004) THEN
                     LET l_ddata009 = "2"
                  END IF
               ELSE
                  LET l_ddata009 = "2"
               END IF
               
            WHEN "2"     #Insert
               IF NOT sadzp444_01_pack_ins_data(l_pack_ddata.ddata002, l_pack_dzyb.dzyb002, l_pack_ddata.ddata004) THEN
                  LET l_ddata009 = "2"
               END IF
               
            WHEN "3"     #Delete
               IF NOT sadzp444_01_pack_del_data(l_pack_dzyb.dzyb002, l_pack_dzyb.dzyb004, l_pack_ddata.ddata006, l_pack_ddata.ddata007) THEN
                  LET l_ddata009 = "2"
               END IF
               
         END CASE

         #匯入失敗處理
         IF l_ddata009 = "2" THEN
            EXIT FOREACH
         END IF
         
      END FOREACH

      IF l_ddata009 = "2" THEN
         ROLLBACK WORK
      ELSE
         COMMIT WORK

         #依據各註冊資料性質,呼叫產生程序(如:azzi902需產生str, 42s檔案)
         IF l_pack_ddata.ddata004 = "1" OR l_pack_ddata.ddata004 = "2" THEN
            IF NOT sadzp444_01_generator_program(l_pack_ddata.ddata005, l_pack_ddata.ddata006) THEN
               DISPLAY "ERROR:sadzp444_01_generator_program( ", l_pack_ddata.ddata005, ", ", l_pack_ddata.ddata006, ")"
            END IF
         END IF
      END IF
      
      #更新匯入狀態
      UPDATE adzp444_ddata SET ddata009 = l_ddata009
        WHERE ddata001 = p_master001 
          AND ddata002 = l_pack_ddata.ddata002
      
      #如果為標準環境,需和ALM需求單結合
      IF g_alm_jb = g_dgenv_s THEN
        #同步回ALM需求單
         UPDATE dzld_t SET dzld009 = l_ddata009    
           WHERE dzld002 = l_pack_ddata.ddata002
             AND dzld011 = p_master013 
             AND dzld012 = g_dzld012
             AND dzld013 = g_dzld013
             AND dzld014 = p_master014 
      END IF
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 註冊資訊[資料]新增
PUBLIC FUNCTION sadzp444_01_pack_ins_data(p_ddata002, p_dzyb002, p_ddata004)
   DEFINE p_ddata002        LIKE type_t.num5
   DEFINE p_dzyb002         LIKE dzyb_t.dzyb002
   DEFINE p_ddata004        LIKE type_t.chr1        #匯入動作(1:Merge; 2:Insert; 3:Delete)
   
   DEFINE l_file            STRING
   DEFINE l_sql             STRING
   DEFINE l_size            LIKE type_t.num5
   
   LET l_file = p_ddata002 USING "<<<<<", "-", p_dzyb002 CLIPPED, ".unl"
   LET l_sql = "INSERT INTO ", p_dzyb002 CLIPPED

   IF NOT os.Path.EXISTS(l_file) THEN
      CALL cl_err_msg(NULL, "adz-00339", l_file.trim(), 1)
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_file.trim())
      RETURN FALSE
   END IF

   #size為0:代表沒資料,不需匯入
   LET l_size = os.Path.SIZE(l_file)
   IF l_size = 0 THEN
      RETURN TRUE
   END IF
   
   LOAD FROM l_file l_sql

   IF STATUS THEN
      IF p_ddata004 = "2" THEN
         DISPLAY "Warning-LOAD FROM ", l_file.trim(), ":", cl_getmsg(STATUS, g_lang)
      ELSE
         CALL cl_err("LOAD FROM " || l_file.trim(), STATUS, 1)
         LET g_error_message = "ERROR-LOAD FROM ", l_file.trim(), ":", cl_getmsg(STATUS, g_lang)
         RETURN FALSE
      END IF
   END IF
   
   RETURN TRUE
END FUNCTION

#+ 註冊資訊[資料]刪除
PUBLIC FUNCTION sadzp444_01_pack_del_data(p_dzyb002, p_dzyb004, p_ddata006, p_ddata007)
   DEFINE p_dzyb002         LIKE dzyb_t.dzyb002
   DEFINE p_dzyb004         LIKE dzyb_t.dzyb004
   DEFINE p_ddata006        LIKE type_t.chr50
   DEFINE p_ddata007        LIKE type_t.chr50
   
   DEFINE l_sql             STRING
   
   #LET l_sql = "DELETE FROM ", p_dzyb002 CLIPPED,
   #            "  WHERE ", p_dzyb004 CLIPPED, " = '", p_ddata006 CLIPPED, "' "
   LET l_sql = "DELETE FROM ", p_dzyb002 CLIPPED,
               "  WHERE ", p_dzyb004 CLIPPED, " = ? "


   PREPARE sadzp444_01_pack_del_data_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      CALL cl_err('PREPARE sadzp444_01_pack_del_data_pre:' || p_dzyb002 CLIPPED, SQLCA.sqlcode, 1)
      LET g_error_message = "ERROR-PREPARE sadzp444_01_pack_del_data_pre." || p_dzyb002 CLIPPED || ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      RETURN FALSE
   END IF

   EXECUTE sadzp444_01_pack_del_data_pre USING p_ddata006
   IF SQLCA.sqlcode THEN
      CALL cl_err('exc sadzp444_01_pack_del_data_pre:' || p_dzyb002 CLIPPED, SQLCA.sqlcode, 1)
      LET g_error_message = "ERROR-exc sadzp444_01_pack_del_data_pre." || p_dzyb002 CLIPPED || ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      RETURN FALSE
   END IF 

   RETURN TRUE
END FUNCTION

#+ 取得完整路徑(轉換環境變數設置)
PUBLIC FUNCTION sadzp444_01_generator_program(p_ddata005, p_ddata006)
   DEFINE p_ddata005        LIKE type_t.chr20  #註冊資訊維護作業代碼(ex:azzi900)
   DEFINE p_ddata006        LIKE type_t.chr50  #條件式1
   
   DEFINE l_cmd             STRING
   DEFINE l_success         LIKE type_t.chr1 
   
   CASE p_ddata005 CLIPPED
      WHEN "azzi030"
         CALL s_azzi030_createxcf_sys()

      WHEN "azzi900"
         LET l_cmd = ""
         
      WHEN "azzi902"
         #LET l_cmd = "r.r azzp191"
 
      WHEN "azzi910"
         #CALL s_azzi030_createxcf_app(p_ddata006 CLIPPED, FALSE)

      WHEN "azzi991"
         #LET l_success = s_azzi991_carry("2", p_ddata006 CLIPPED)

      #WHEN "adzi210"
      #   LET l_success = adzi210_generate_qry(p_ddata006 CLIPPED)

   END CASE

   RETURN TRUE
END FUNCTION

#+ 註冊資訊[檔案]匯出
PUBLIC FUNCTION sadzp444_01_import_file(p_master001, p_pack_dir, p_folder)
   DEFINE p_master001       LIKE type_t.chr50  #GUID
   DEFINE p_pack_dir        STRING             #打包檔置放路徑
   DEFINE p_folder          STRING             #匯出檔所在目錄
   
   DEFINE l_dfile           type_g_dfile_d
   DEFINE l_cmd             STRING
   DEFINE l_source          STRING
   DEFINE l_dest            STRING
   DEFINE l_tar_name        STRING
   DEFINE l_dfile007        LIKE type_t.chr1   #匯入狀態(0:建立; 1:成功; 2:失敗) 
   
   #找出[檔案匯出清單]
   FOREACH sadzp444_01_dfile_cs USING p_master001
                                INTO l_dfile.dfile002, l_dfile.dfile003, l_dfile.dfile004, l_dfile.dfile005, l_dfile.dfile006, 
                                     l_dfile.dfile007
      IF SQLCA.sqlcode THEN
         CALL cl_err("FOREACH sadzp444_01_dfile_cs:", SQLCA.sqlcode, 1)
         LET g_error_message = "ERROR-FOREACH sadzp444_01_dfile_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         RETURN FALSE
      END IF
      
      ####不再重做已[匯入成功]清單
      ###IF l_dfile.dfile007 = "1" THEN
      ###   CONTINUE FOREACH
      ###END IF

      #檔案類型為[f:檔案],cp f# {路徑}/{檔名} 
      #檔案類型為[d:整個目錄結構],tar xvf $FOLDER/d# {檔名}
      CASE l_dfile.dfile004 CLIPPED
         WHEN "f"
            LET l_source = os.Path.JOIN(os.Path.JOIN(p_pack_dir, p_folder), l_dfile.dfile005 CLIPPED)
            LET l_dest = os.Path.JOIN(l_dfile.dfile003 CLIPPED, l_dfile.dfile005 CLIPPED)
            LET l_cmd = "cp ", l_source.trim(), " ", l_dest.trim()

         WHEN "d"
            LET l_tar_name = l_dfile.dfile005 CLIPPED, ".tar"
            LET l_source = os.Path.JOIN(os.Path.JOIN(p_pack_dir, p_folder), l_tar_name)
            LET l_dest = l_dfile.dfile005 CLIPPED

            LET l_cmd = "cd ", l_dfile.dfile003 CLIPPED, ";"
            LET l_cmd = l_cmd, "tar xvf ", l_source.trim(), " ", l_dest.trim()
      END CASE

      #複製檔案
      LET l_dfile007 = "2"
      
      IF NOT os.Path.EXISTS(l_source) THEN
         CALL cl_err_msg(NULL, "adz-00339", l_source.trim(), 1)
         LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00339", g_lang, l_source.trim())
         RETURN FALSE
      ELSE
         DISPLAY "l_cmd:", l_cmd, ";"
         RUN l_cmd

         IF STATUS THEN
            CALL cl_err_msg(NULL, "adz-00338", l_source.trim(), 1)
            LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00338", g_lang, l_source.trim())
            RETURN FALSE
         END IF
         
         LET l_dfile007 = "1"
      END IF
    
      #更新匯入狀態
      UPDATE adzp444_dfile SET dfile007 = l_dfile007
        WHERE dfile001 = p_master001 
          AND dfile002 = l_dfile.dfile002

   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 取得完整路徑(轉換環境變數設置)
PUBLIC FUNCTION sadzp444_01_get_path(p_path)
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

         LET p_path = sadzp444_01_get_path(p_path)
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
PUBLIC FUNCTION sadzp444_01_get_folder_name(p_master002, p_master003)
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

