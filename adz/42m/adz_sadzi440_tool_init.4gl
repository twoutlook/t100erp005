IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE   g_fglserver   STRING


#函式名稱：sadzi440_tool_init  更改from ：  cl_tool_init
#用    途：依模組進行系統初始化設定(含系統設定,畫面開啟,SQL撈取)
#用    法：cl_ap_init(p_mod,p_bgjob)
PUBLIC FUNCTION sadzi440_tool_init()

   #設定執行環境-此處規範不進行資料庫連結
   IF (NOT sadzi440_set_environment()) THEN
      EXIT PROGRAM
   END IF

   #連線預設資料庫
   IF (NOT sadzi440_set_default_dbs()) THEN
      RETURN FALSE
   END IF

   #設定使用者資料  (抓取基本的 gzza/gzxa)
   SELECT gzza001 FROM gzza_t WHERE gzza001=g_code
   IF SQLCA.sqlcode THEN
      IF (NOT sadzi440_set_user_profile_test()) THEN  #修改的
         RETURN FALSE
      END IF
   ELSE
      IF (NOT sadzi440_set_user_profile()) THEN
         RETURN FALSE
      END IF
   END IF

   #切換至使用者所需要的資料庫 (企業編號+營運據點)
   IF (NOT sadzi440_set_user_dbs()) THEN
      RETURN FALSE
   END IF

   #設定模組資料
   IF NOT cl_set_up() THEN
      RETURN FALSE
   END IF

END FUNCTION

PRIVATE FUNCTION sadzi440_set_user_profile()
   DEFINE lst_tok           base.StringTokenizer
   DEFINE ls_proc           STRING
   DEFINE ls_sql            STRING
   DEFINE li_gzza004_para   LIKE type_t.num10
   DEFINE lc_gzza004        LIKE gzza_t.gzza004    #執行指令
   DEFINE lc_gzza012        LIKE gzza_t.gzza012    #處理閒置連線方式
   DEFINE lc_gzxa005        LIKE gzxa_t.gzxa005    #內部使用者AD代碼
   DEFINE lc_gzxa014        LIKE gzxa_t.gzxa014
   DEFINE lc_gzxastus       LIKE gzxa_t.gzxastus

   WHENEVER ERROR CALL cl_err_msg_log

   #由作業記錄檔 (gzza) 取出本支作業
   SELECT gzza002,gzza003,gzza004,gzza006,gzza010,gzza012,gzza014
          #程式類別,模組名稱,執行指令,是否允許改KEY,是否將錯誤訊息寫入,閒置處理方式,秒
     INTO g_template_type,g_sys,lc_gzza004,g_chkey,g_need_err_log,lc_gzza012,g_idle_seconds
     FROM gzza_t
    WHERE gzza001 = g_code
   IF SQLCA.SQLCODE OR SQLCA.SQLCODE = NOTFOUND THEN
      LET g_need_err_log = 'N' #是否要將錯誤訊息寫入log檔內,預設為'N'.(by 程式)
      LET li_gzza004_para = 0
      DISPLAY "Error:程式資料:",g_code CLIPPED,"有缺,請到 azzi900 內補上"
      RETURN FALSE
   ELSE
      LET g_template_type = DOWNSHIFT(g_template_type)
      LET lst_tok = base.StringTokenizer.create(lc_gzza004 CLIPPED, " ")
      LET li_gzza004_para = lst_tok.countTokens() - 2
   END IF

   #是否允許改KEY,default 為 N
   IF cl_null(g_chkey) THEN
      LET g_chkey = "N"
   END IF

   #由使用者記錄檔 (gzxa) 取出使用者資料
   SELECT gzxa003,gzxa007,gzxa010,
         #員工編號,預設營運據點編號,慣用語言,
          gzxa014,gzxastus
         #可用截止日,有效無效碼
     INTO g_user,g_site,g_lang,lc_gzxa014,lc_gzxastus
     FROM gzxa_t
    WHERE gzxa001 = g_account AND gzxaent = g_enterprise
   IF (SQLCA.SQLCODE) THEN
      DISPLAY "Error:使用者:",g_account,"不存在,請到 azzi800 內補上"
      RETURN FALSE
   END IF
   #此處取出的 g_dept是『內部使用者代碼』,需要等切換資料庫後才能抓出正確的部門名稱

   #使用者已經失效
   IF lc_gzxastus <> "Y" THEN
      DISPLAY "Error:使用者:",g_account,"資料已經失效"
      RETURN FALSE
   END IF
   #使用者已經過期
   IF lc_gzxa014 < g_today THEN
      DISPLAY "Error:使用者:",g_account,"資料已經過期 (期限至:",lc_gzxa014,")"
      RETURN FALSE
   END IF

   #取得資料語言別
   SELECT gzzy003 INTO g_dlang
     FROM gzzy_t
    WHERE gzzy001 = g_lang
   IF STATUS OR g_dlang IS NULL THEN
      LET g_dlang = g_lang
   END IF

   #若g_rlang為null or empty就給予初始值
   IF g_rlang IS NULL OR g_rlang=" " THEN
      LET g_rlang = g_lang CLIPPED
   END IF

   #idle sec秒數以程式設定為先, 其次是權限, 系統設定
   CASE lc_gzza012
      WHEN "1"
         DISPLAY "Warning:本作業無閒置管制 "
      WHEN "2"
         IF cl_null(g_idle_seconds) THEN
            LET g_idle_seconds = 10
         END IF
      WHEN "3"
   END CASE

   #判斷是否需要產生SQL錯誤記錄檔
   CALL cl_err_chk_setting()

   RETURN TRUE
END FUNCTION

#直接cl_set_user_profile()()中的逻辑，取消抓取gzza_t部分
PRIVATE FUNCTION sadzi440_set_user_profile_test()
   DEFINE lc_gzxa014        LIKE gzxa_t.gzxa014
   DEFINE lc_gzxastus       LIKE gzxa_t.gzxastus

   #LET g_sys = gzza003  #adzi400画面中可能要增加的
   LET g_chkey = "N"

   #由使用者記錄檔 (gzxa) 取出使用者資料
   SELECT gzxa003,gzxa007,gzxa010,
         #員工編號,預設營運據點編號,慣用語言,
          gzxa014,gzxastus
         #可用截止日,有效無效碼
     INTO g_user,g_site,g_lang,lc_gzxa014,lc_gzxastus
     FROM gzxa_t
    WHERE gzxa001 = g_account AND gzxaent = g_enterprise
   IF (SQLCA.SQLCODE) THEN
      DISPLAY "Error:使用者:",g_account,"不存在,請到 azzi800 內補上"
      RETURN FALSE
   END IF
   #此處取出的 g_dept是『內部使用者代碼』,需要等切換資料庫後才能抓出正確的部門名稱

   #使用者已經失效
   IF lc_gzxastus <> "Y" THEN
      DISPLAY "Error:使用者:",g_account,"資料已經失效"
      RETURN FALSE
   END IF
   #使用者已經過期
   IF lc_gzxa014 < g_today THEN
      DISPLAY "Error:使用者:",g_account,"資料已經過期 (期限至:",lc_gzxa014,")"
      RETURN FALSE
   END IF

   #取得資料語言別
   SELECT gzzy003 INTO g_dlang
     FROM gzzy_t
    WHERE gzzy001 = g_lang
   IF STATUS OR g_dlang IS NULL THEN
      LET g_dlang = g_lang
   END IF

   #若g_rlang為null or empty就給予初始值
   IF g_rlang IS NULL OR g_rlang=" " THEN
      LET g_rlang = g_lang CLIPPED
   END IF

   #判斷是否需要產生SQL錯誤記錄檔
   CALL cl_err_chk_setting()

   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION sadzi440_set_environment()
   DEFINE li_idx      LIKE type_t.num5
   DEFINE p_bgjob     LIKE type_t.chr1
   DEFINE lc_parentid LIKE type_t.chr80     #Parent SESSION Key
   DEFINE lc_prog     LIKE gzzz_t.gzzz001

   #抓取程式名稱 g_code
   IF (cl_null(g_code)) THEN
      LET g_code = ui.Interface.getName()
      LET g_prog = g_code
   END IF

   #確認執行的方式 g_gui_type (前景或背景, WEB-ActiveX 或 GWC 或 ASCII 或 Windows-GUI)
   LET g_gui_type = cl_getenv_fglgui()

   IF g_bgjob = 'N' THEN
      #若是傳統的 GUI, 顯示錯誤訊息離開
      IF NOT g_gui_type MATCHES "[123]" THEN
         DISPLAY "WARNING: TIPTOP GP CANNOT SUPPORT YOUR Client (",g_gui_type,")!"
      END IF
   END IF

   #取得使用者登入帳號 g_account
   CASE
      #WEB的背景作業
      WHEN (g_gui_type = 0) AND (FGL_GETENV("BGJOB") = '1') AND (FGL_GETENV("WEBMODE") = '1') #Background Job from WEB Mode
         LET g_account = FGL_GETENV("WEBUSER")

      #WEB的ActiveX 或 GWC
      WHEN (g_gui_type = 2) OR (g_gui_type = 3)
         LET g_account = FGL_GETENV("WEBUSER")

      #ASCII Mode 或 Windows GUI
      WHEN (g_gui_type = 0) OR (g_gui_type = 1)
         LET g_account = FGL_GETENV("LOGNAME")

         #抓取體系代碼 enterprise
         LET g_enterprise = FGL_GETENV("TOPENT")
         IF g_enterprise IS NULL THEN
            LET g_enterprise = 100
            DISPLAY "Error: TOPEnterprise Code Doesn't Exists! Let's Goto Demo Enterprise (100) !"
         END IF
   END CASE

   IF ( g_gui_type = 0 ) AND
      ((FGL_GETENV("BGJOB")='1') OR (FGL_GETENV("EASYFLOW")='1')
    OR (FGL_GETENV("SPC")='1') OR (FGL_GETENV("TPGateWay") ='1')
    OR (FGL_GETENV("WSBGJOB")='1'))
   THEN
      IF FGL_GETENV("WSBGJOB") = '1' THEN
         LET g_account = FGL_GETENV("WSUSER")
      END IF
   END IF

   #必須先得到gui type才可以組出正確的IP字串
   LET g_fglserver = FGL_GETENV("FGLSERVER")
#  LET g_fglserver = cl_process_chg_iprec(g_fglserver)

   #時間設定
   LET g_lastdat = MDY(12,31,9999)
   LET g_today = TODAY

   #使用g_argv承接其他外部參數-先抓取再確認
   FOR li_idx = 1 TO NUM_ARGS()
   #display li_idx,'--',ARG_VAL(li_idx)
      #指定外部參數
      CASE li_idx
         WHEN 1     LET g_sessionkey = ARG_VAL(1)   #SESSION Key
         WHEN 2     LET lc_parentid = ARG_VAL(2)     #Parent SESSION Key
         WHEN 3     LET g_bgjob = ARG_VAL(4)
         WHEN 4     LET lc_prog = ARG_VAL(5)
                    IF lc_prog IS NOT NULL THEN LET g_prog = lc_prog END IF
      END CASE
      IF li_idx >= 6 THEN
         LET g_argv[li_idx - 5 ] = ARG_VAL(li_idx)
      END IF
   END FOR

   #判斷程式執行模式(背景/視窗)
   IF (FGL_GETENV("EASYFLOW") = '1' OR FGL_GETENV("SPC")='1' OR
       FGL_GETENV("TPGateWay") = '1' OR FGL_GETENV("WSBGJOB")='1' )
       AND g_gui_type = 0
   THEN
      LET g_bgjob = 'Y'
   END IF

   IF p_bgjob = 'C' THEN
      IF cl_null(g_argv[1]) THEN
         LET p_bgjob = g_argv[1]
         LET g_bgjob = g_argv[1]
      ELSE
         LET p_bgjob = 'N'
         LET g_bgjob = 'N'
      END IF
   ELSE
      LET g_bgjob = p_bgjob
   END IF

   #初始化 Transaction 記錄變數
   LET g_intrans = "N"

   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION sadzi440_set_default_dbs()
   #進行系統庫的連線
   CONNECT TO "ds"

   #資料庫參數設定 (DIRTY READ/LOCK MODE)
   IF NOT sadzi440_set_database_parameter() THEN
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION sadzi440_set_database_parameter()
 DEFINE lc_db_type   LIKE type_t.chr3

   #設定資料庫種類
   LET lc_db_type = cl_db_get_database_type()

   #依據不同資料庫,調整讀取模式
   CASE lc_db_type
      WHEN "IFX"
         SET ISOLATION TO DIRTY READ
      WHEN "MSV"
         SET ISOLATION TO DIRTY READ
         SET LOCK MODE TO NOT WAIT
      WHEN "ASE"
         SET ISOLATION TO DIRTY READ
         SET LOCK MODE TO NOT WAIT
   END CASE

   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION sadzi440_set_user_dbs()
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE li_status    LIKE type_t.num5
   DEFINE ls_db        STRING
   DEFINE lc_gzou003   LIKE gzou_t.gzou003   #主資料庫
   DEFINE lc_gzou004   LIKE gzou_t.gzou004   #是否採用分散式部署
   DEFINE lc_gzou006   LIKE gzou_t.gzou006   #分散式部署的子資料庫清單
   DEFINE lc_gzda003   LIKE gzda_t.gzda003
   DEFINE lc_gzda004   LIKE gzda_t.gzda004
   DEFINE lc_gzda006   LIKE gzda_t.gzda006
   DEFINE lc_gzda007   LIKE gzda_t.gzda007

   #初始化狀態
   LET li_status = TRUE

   #連線到指定資料庫
   SELECT gzou003,gzou004,gzou006
     INTO lc_gzou003,lc_gzou004,lc_gzou006 FROM gzou_t
    WHERE gzou001 = g_enterprise
   IF SQLCA.SQLCODE THEN
      DISPLAY "Error:企業編號(",g_enterprise,") 不存在!維持於SYSTEM中!"
      LET li_status = FALSE
   ELSE
      IF lc_gzou004 = "Y" THEN
         DISPLAY "INFO:企業編號(",g_enterprise,") 採用分散式部署!"
         #還未完成相關規劃及功能
      END IF

      #查看要連線的資料庫資訊
      SELECT gzda003,gzda004,gzda006,gzda007
        INTO lc_gzda003,lc_gzda004,lc_gzda006,lc_gzda007
        FROM gzda_t
       WHERE gzda001 = lc_gzou003

      #設定連線字串 "demo1+driver='dbmoraA2x'"
      LET ls_db = lc_gzou003 CLIPPED,"+driver='dbm",lc_gzda006 CLIPPED,lc_gzda007 CLIPPED,"'"
      DISCONNECT "ds"
      CONNECT TO ls_db USER lc_gzda003 USING lc_gzda004
   END IF

   #重新設定g_dept (屬於企業資料 - 在此之前g_dept存內部員工代號,空表示外部員工)
   IF g_dept IS NOT NULL THEN
      SELECT ooag002 INTO g_dept FROM ooag_t
       WHERE ooag001 = g_dept AND ooagent = g_enterprise
      IF SQLCA.SQLCODE THEN
         DISPLAY "Warning:企業(",g_enterprise,") 內不存在員工:",g_dept,"!"
         LET g_dept = ""
      END IF
   END IF

   #目前尚未定義指定營運中心編號在外部參數第幾個位置

   #確認 site 是否存在於該企業內
   SELECT ooea038 INTO g_timezone FROM ooea_t
    WHERE ooea001 = g_site AND ooeaent = g_enterprise AND ooea004 = 'Y'
   IF SQLCA.SQLCODE THEN
      DISPLAY "Warning:企業(",g_enterprise,") 內不存在據點:",g_site,"!"
   ELSE
      IF cl_null(g_timezone) THEN
         DISPLAY "Warning:據點(",g_site,")時區未設定,以GMT+8替代!"
         LET g_timezone = "GMT+8"
      END IF
   END IF

   RETURN li_status
END FUNCTION





