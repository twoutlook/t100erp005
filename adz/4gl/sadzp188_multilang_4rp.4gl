#+ Version..: T100-ERP-1.00.00(版次:1) Build-000
#+ 
#+ Filename...: sadzp188_multilang_4rp.4gl 
#+ Description: 報表樣板轉換多語言程式
#+ Modifier...: No.150616-00029#1 15/06/16 Cynthia  純英數字串不寫入多語言檔(gzge_t),強制訊息調整
#+ Modifier...: No.150707-00030#1 15/06/16 Cynthia  1.空樣板上傳時,轉換語言別也視為成功
#                                                   2.上傳時當欄位說明跟r.t一致,但gzge_t有資料時,把gzge_t的資料砍掉
#+ Modifier...: No.150901-00021#1 15/09/01 Cynthia  將adz中,使用到cl_gr跟cl_xg的FUNCTION獨立出來, 降低關聯性
#+ Modifier...: No.151026-00010#1 15/10/27 Cynthia  開放設定"準確性(Fidelity)"
#+ Modifier...: No.151102-00034#1 15/11/02 Cynthia  報表環境變數入資料庫
#+ Modifier...: No.151208-00023#1 15/12/09 Cynthia  調整從gztz_t抓取table名時，要排除備份檔(rebuil)
#+ Modifier...: No.160127-00012#1 16/01/27 Cynthia  sadzp188_multilang_4rp_chk_label中沒有樣板的錯誤訊息改用DISPLAY
#+ Modifier...: No.160608-00012#1 16/06/08 Cynthia  T100 Light架構調整
#+ Modifier...: No.160629-00012#1 16/06/29 Cynthia  1.報表樣板多語言功能
#                                                   2.上傳時檢查Page Root的高寬都要是max
#                                                   3.禁用字詞錯誤訊息彙總
#+ Modifier...: No.160921-00027#1 16/09/21 Cynthia  憑證報表樣板(4rp)上傳時不檢查物件寬度及定位點的單位(cm/pixel)
#+ Modifier...: No.161103-00051#1 16/09/29 Cynthia  樣板多語言機制(英文樣板單頭固定長度,最終須比對字典檔內容,log機制)
#+ Modifier...: No.161216-00001#1 16/12/16 Cynthia  產生樣板時，只有產生繁/簡體，沒有英文樣板
#+ Modifier...: No.161227-00056#1 16/12/28 Janet    調整撈取gztz_t時，要判斷掉'erp'、'all'、'b2b'、'pos'、'dsm'，避免多拉資料
#+ Modifier...: No.170123-00046#1 17/01/24 Cynthia  整批調整報表工具訊息為多語言

IMPORT os
IMPORT security 

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"
&include "../4gl/sadzp000_type.inc"

DEFINE g_log_ch_ok      base.Channel
DEFINE g_log_ch_err     base.Channel
#DEFINE g_logfilepath    STRING             #Log Directory
DEFINE g_logokfile      STRING
DEFINE g_logerrfile     STRING

DEFINE g_4rpid          LIKE gzgd_t.gzgd000 #樣板ID
DEFINE g_gzgd007        LIKE gzgd_t.gzgd007 #樣板名稱 
DEFINE g_mdir           STRING              #改用g_mnt4rp_path
DEFINE g_4rpfile        STRING              #檔案路徑
DEFINE g_find_cnt       INTEGER
DEFINE g_msg            STRING 
DEFINE g_chk_err_msg    STRING              #檢查報表命名規則的錯誤訊息
DEFINE g_chk_force_msg  STRING              #檢查報表命名規則的錯誤訊息(強制)
DEFINE g_chk_set_msg    STRING              #檢查報表命名規則的錯誤訊息(設定)
DEFINE g_chk_lbl_msg    STRING              #檢查報表命名規則的錯誤訊息(設定)
DEFINE g_chk_fid_msg    STRING              #檢查報表命名規則的錯誤訊息(準確性)   #151026-00010#1 add
DEFINE g_force_err      INTEGER             #強制錯誤訊息數
DEFINE g_langs          DYNAMIC ARRAY OF LIKE gzzy_t.gzzy001
DEFINE g_cust_flag      LIKE gzde_t.gzde008 #客製
DEFINE g_erpid          STRING              #160608-00012#1 add
DEFINE g_header_wid     DECIMAL             #非中文樣板,單頭欄位說明寬度預設值   #161103-00051#1 add


################################################################################
# Descriptions...: 轉換4rp語言別前置
# Memo...........:
# Usage..........: CALL sadzp188_multilang_4rp(p_mod,p_sys,p_rep_code,p_4rpname,p_lang_src,p_lang_trans,p_flag)
# Input parameter: p_mod          模組名稱
#                : p_sys          模組代碼
#                : p_rep_code     報表元件代號
#                : p_4rpname      樣板名稱
#                : p_lang_src     來源語言別
#                : p_lang_trans   轉換語言別
#                : p_flag         覆蓋否(Y/N)
# Return code....: void
# Date & Author..: 2014/8/8 By Cynthia
# Modify.........:
################################################################################
PUBLIC FUNCTION sadzp188_multilang_4rp(p_mod,p_sys,p_rep_code,p_4rpname,p_lang_src,p_lang_trans,p_flag)
   DEFINE p_mod            LIKE gzde_t.gzde002   #模組代碼
   DEFINE p_sys            LIKE gzde_t.gzde002   #模組代碼
   DEFINE p_rep_code       LIKE gzgd_t.gzgd001   #報表元件代號
   DEFINE p_4rpname        LIKE gzgd_t.gzgd002   #樣板代號
   DEFINE p_lang_src       LIKE gzzy_t.gzzy001   #來源語言別
   DEFINE p_lang_trans     LIKE gzzy_t.gzzy001   #轉換語言別
   DEFINE p_flag           LIKE type_t.chr1      #覆蓋否(當4rp存在時,可選擇是否覆蓋)
   DEFINE l_gzgd007        LIKE gzgd_t.gzgd007   #樣板名稱(4rp)
   DEFINE l_gzgd013        LIKE gzgd_t.gzgd013   #客戶紙張 #150202 add
   DEFINE lb_result        BOOLEAN
   DEFINE ls_err_msg       STRING
   
   DEFINE l_i              INTEGER       
   DEFINE li_errcnt        INTEGER 
   DEFINE ls_msg           STRING
   DEFINE ls_msg_1         STRING
   DEFINE ls_paper_msg     STRING
   DEFINE l_paper_size     STRING
   DEFINE l_4rp_size       STRING
   DEFINE l_lbl_msg        STRING                #141224 add   
   DEFINE l_lang_flag      LIKE type_t.chr1      #160629-00012#1-1 add
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_tmpdir         STRING,
          l_log_errfile    STRING,
          l_today_str      STRING,
          l_log_okfile     STRING   

   LET g_chk_lbl_msg = NULL   #141223 add
   LET g_erpid = NVL(FGL_GETENV("ERPID"),"T100ERP")           #160608-00012#1 add
   LET l_lang_flag = "N"                                      #160629-00012#1-1 add
   
   LET g_header_wid = 2.5   #161103-00051#1

   LET l_today_str = TODAY USING "yymmdd"
   LET l_tmpdir = FGL_GETENV("TEMPDIR")
   LET l_log_okfile = "sadzp188_multilang_4rp_ok",l_today_str,".log" #正式區ok檔案      
   LET g_logokfile = os.Path.join(l_tmpdir, l_log_okfile)
   LET g_log_ch_ok = base.Channel.create()
   CALL g_log_ch_ok.openFile(g_logokfile, "a")    #161103-00051#1 add
   IF os.Path.chrwx(g_logokfile,511) THEN END IF  #161103-00051#1 add #修改權限

   IF cl_null(g_prog) OR g_prog != "azzi303" THEN
      #4rp上傳檢查
      LET g_msg = cl_getmsg("adz-01155",g_lang) CLIPPED,'(4RP):',g_lang   #170123-00046#1 add
      DISPLAY g_msg                                                       #170123-00046#1 add
#      DISPLAY "4RP g_lang:",g_lang                                       #170123-00046#1 mark
      #DISPLAY "4RP Upload START:",CURRENT  YEAR  TO SECOND               #170123-00046#1 mark
      SELECT gzde008 INTO g_cust_flag FROM gzde_t 
       WHERE gzde001 = p_rep_code 
      
#      CALL sadzp188_multilang_4rp_chkgr(p_sys,p_rep_code,l_gzgd007,p_lang_src) RETURNING li_errcnt,ls_msg
#      CALL sadzp188_multilang_4rp_chkgr(p_sys,p_rep_code,l_gzgd007,g_lang) RETURNING li_errcnt,ls_msg #150120 mark
      LET g_msg = "=============檢查規範 START TIME:",CURRENT HOUR TO FRACTION(3)
      CALL g_log_ch_ok.writeLine(g_msg)
      CALL sadzp188_multilang_4rp_chkgr(p_sys,p_rep_code,NULL,g_lang) RETURNING li_errcnt,ls_msg  #150120 add
      LET g_msg = "=============檢查規範 END TIME:",CURRENT HOUR TO FRACTION(3)
      CALL g_log_ch_ok.writeLine(g_msg)
      #當有強制訊息時，不允許上傳(使用.4rp.bak檔還原)
      IF li_errcnt > 0 THEN
         CALL sadzp188_multilang_4rp_recovery(p_sys,p_rep_code,p_4rpname,"zh_TW")
         CALL sadzp188_multilang_4rp_recovery(p_sys,p_rep_code,p_4rpname,"zh_CN")
         LET r_success = FALSE
         LET ls_msg_1 = cl_str_replace(ls_msg,"\r\n","") 
         #顯示檢查命名規則的錯誤訊息
         #IF ls_msg_1 IS NOT NULL THEN
         IF NOT cl_null(ls_msg_1) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00458"  
            LET g_errparam.extend = ls_msg
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         RETURN r_success
      END IF

      #顯示檢查命名規則的錯誤訊息
#      IF ls_msg IS NOT NULL THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code =  "adz-00458"
#         LET g_errparam.extend = ls_msg
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#      END IF
#      DISPLAY "4RP Upload END:",CURRENT  YEAR  TO SECOND   #170123-00046#1 mark   
   END IF
   
   LET ls_msg = ls_msg,"\r\n"  #141224 add
   IF g_prog = "azzi303" THEN
      CALL sadzp188_multilang_4rp_gen(p_mod,p_sys,p_rep_code,p_4rpname,p_lang_src,p_lang_trans,p_flag) RETURNING r_success,l_lbl_msg 
      IF NOT cl_null(l_lbl_msg) THEN
         LET ls_msg = ls_msg,cl_getmsg("adz-00483",g_lang) CLIPPED,"\r\n",l_lbl_msg    #141224 add
      END IF   
   ELSE
      #取得語言列表
#      CALL cl_gr_lang_list() RETURNING g_langs   #150901-00021#1 mark
      CALL cl_rpt_lang_list() RETURNING g_langs   #150901-00021#1 add

      #150202 add(s)
      #依據客戶紙張調整樣板紙張大小
      LET g_msg = "=============客戶紙張 START TIME:",CURRENT HOUR TO FRACTION(3)
      CALL g_log_ch_ok.writeLine(g_msg)
      SELECT MAX(gzgd013) INTO l_gzgd013 FROM gzgd_t WHERE gzgd001 = p_rep_code
      IF NOT cl_null(l_gzgd013) THEN
         CALL sadzp188_multilang_4rp_cust_paper(p_sys,p_rep_code,p_4rpname,p_lang_src) RETURNING ls_paper_msg 
         #INITIALIZE g_errparam TO NULL 
         #LET g_errparam.extend = ls_paper_msg  
         #LET g_errparam.code   = "adz-00527" 
         #LET g_errparam.popup  = TRUE
         #LET g_errparam.replace[1] = p_rep_code                     
         #CALL cl_err()
      END IF
      #150202 add(e)
      LET g_msg = "=============客戶紙張 END TIME:",CURRENT HOUR TO FRACTION(3)
      CALL g_log_ch_ok.writeLine(g_msg)

      #160629-00012#1-1 add(s)
      #檢查是否有繁中之外的語系
      FOR l_i = 1 TO g_langs.getLength()
         LET g_msg = "=============回寫gzge g_langs[l_i]:",g_langs[l_i]," START TIME:",CURRENT HOUR TO FRACTION(3)
         CALL g_log_ch_ok.writeLine(g_msg)
         #上傳4rp時將各語言別的欄位說明回寫至gzge_t
         CALL sadzp188_multilang_4rp_chk_label(p_sys,p_rep_code,p_4rpname,g_langs[l_i])   #141223 add      
         LET g_msg = "=============回寫gzge g_langs[l_i]:",g_langs[l_i]," END TIME:",CURRENT HOUR TO FRACTION(3)
         CALL g_log_ch_ok.writeLine(g_msg)
         IF g_langs[l_i] = "en_US" OR g_langs[l_i] = "ja_JP" OR g_langs[l_i] = "vi_VN" OR g_langs[l_i] = "th_TH" THEN
            LET l_lang_flag = "Y"
         END IF
      END FOR

#      DISPLAY "4rp l_lang_flag:",l_lang_flag   #170123-00046#1 mark
      IF l_lang_flag = "Y" AND (g_lang ="zh_TW" OR g_lang ="zh_CN") THEN
         #有繁簡之外的語系才需要詢問是否覆蓋
         IF NOT cl_ask_confirm("adz-00885") THEN
            CALL g_langs.clear()
            LET g_langs[1] = "zh_TW"
            LET g_langs[2] = "zh_CN"   #161103-00051#1 mod
         END IF
      END IF
      #160629-00012#1-1 add(e)
      IF g_user = '04010' THEN
            CALL g_langs.clear()
            LET g_langs[1] = "zh_TW"
            LET g_langs[2] = "zh_CN"
            LET g_langs[3] = "en_US"
      END IF
      FOR l_i = 1 TO g_langs.getLength()   
         #上傳4rp時將各語言別的欄位說明回寫至gzge_t
#         CALL sadzp188_multilang_4rp_chk_label(p_sys,p_rep_code,p_4rpname,"zh_TW") #141223 mark
#         CALL sadzp188_multilang_4rp_chk_label(p_sys,p_rep_code,p_4rpname,"zh_CN") #141223 mark
#         CALL sadzp188_multilang_4rp_chk_label(p_sys,p_rep_code,p_4rpname,g_langs[l_i])   #141223 add   #160629-00012#1-1 mark
         IF g_lang != g_langs[l_i] THEN
            #轉換各語言別4rp
            #DISPLAY "START TIME:",CURRENT HOUR TO FRACTION(3)
IF g_lang = "zh_TW" OR g_lang = "zh_CN" THEN  #161109 add 
            CALL sadzp188_multilang_4rp_gen(p_mod,p_sys,p_rep_code,p_4rpname,g_lang,g_langs[l_i],p_flag) RETURNING r_success,l_lbl_msg
            IF NOT cl_null(l_lbl_msg) THEN
               LET ls_msg = ls_msg,cl_getmsg("adz-00483",g_lang) CLIPPED,"\r\n",l_lbl_msg    #141224 add
            END IF   
END IF     #161109 add
IF g_user = '04010' THEN
            LET g_msg = "l_lang_flag",l_lang_flag
            CALL g_log_ch_ok.writeLine(g_msg)
            LET g_msg = "g_langs[l_i]:",g_langs[l_i]
            CALL g_log_ch_ok.writeLine(g_msg)
            LET g_msg = "START TIME:",CURRENT HOUR TO FRACTION(3) 
            CALL g_log_ch_ok.writeLine(g_msg)
            CALL sadzp188_multilang_4rp_gen(p_mod,p_sys,p_rep_code,p_4rpname,g_lang,g_langs[l_i],p_flag) RETURNING r_success,l_lbl_msg
            IF NOT cl_null(l_lbl_msg) THEN
               LET ls_msg = ls_msg,cl_getmsg("adz-00483",g_lang) CLIPPED,"\r\n",l_lbl_msg    #141224 add
            END IF   
            LET g_msg = "END TIME:",CURRENT HOUR TO FRACTION(3) 
            CALL g_log_ch_ok.writeLine(g_msg)
END IF
           #DISPLAY "END TIME:",CURRENT HOUR TO FRACTION(3)
         END IF   
      END FOR

      #比對繁簡資料      
   END IF

   #沒有強制訊息,上傳成功時的"設定","說明不一致"等訊息 
   IF li_errcnt = 0 THEN
      LET ls_msg = ls_msg,"\r\n",ls_paper_msg
      LET ls_msg_1 = cl_str_replace(ls_msg,"\r\n","") 
      #顯示檢查命名規則的錯誤訊息
      #IF ls_msg_1 IS NOT NULL THEN
      IF NOT cl_null(ls_msg_1) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00458"
         LET g_errparam.extend = ls_msg
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END IF
      
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 轉換4rp語言別
# Memo...........:
# Usage..........: CALL sadzp188_multilang_4rp_gen(p_mod,p_sys,p_rep_code,p_4rpname,p_lang_src,p_lang_trans,p_flag)
# Input parameter: p_mod          模組名稱
#                : p_sys          模組代碼
#                : p_rep_code     報表元件代號
#                : p_4rpname      樣板名稱
#                : p_lang_src     來源語言別
#                : p_lang_trans   轉換語言別
#                : p_flag         覆蓋否(Y/N)
# Return code....: void
# Date & Author..: 2014/8/8 By Cynthia
# Modify.........:
################################################################################
PUBLIC FUNCTION sadzp188_multilang_4rp_gen(p_mod,p_sys,p_rep_code,p_4rpname,p_lang_src,p_lang_trans,p_flag)
   DEFINE p_mod            LIKE gzde_t.gzde002   #模組代碼
   DEFINE p_sys            LIKE gzde_t.gzde002   #模組代碼
   DEFINE p_rep_code       LIKE gzgd_t.gzgd001   #報表元件代號
   DEFINE p_4rpname        LIKE gzgd_t.gzgd002   #樣板代號
   DEFINE p_lang_src       LIKE gzzy_t.gzzy001   #來源語言別
   DEFINE p_lang_trans     LIKE gzzy_t.gzzy001   #轉換語言別
   DEFINE p_flag           LIKE type_t.chr1      #覆蓋否(當4rp存在時,可選擇是否覆蓋)
   DEFINE l_rootnode       om.DomNode
   DEFINE l_doc            om.DomDocument
   DEFINE l_base4rp        STRING
   DEFINE l_4rpfile        STRING
   DEFINE l_4rpfile_w      STRING
   DEFINE l_4rpfile_src    STRING
   DEFINE l_4rpdir         STRING
   DEFINE l_4rpdir_w       STRING 
   DEFINE l_sql            STRING 
   DEFINE l_gzgd000        LIKE gzgd_t.gzgd000,   #報表樣板ID
          l_gzgd001        LIKE gzgd_t.gzgd001,   #報表元件代號
          l_gzgd002        LIKE gzgd_t.gzgd002,   #樣板代號
          l_gzgd003        LIKE gzgd_t.gzgd003,   #客製否
          l_gzgd004        LIKE gzgd_t.gzgd004,   #角色
          l_gzgd005        LIKE gzgd_t.gzgd005,   #用戶
          #l_gdw06          LIKE gdw_file.gdw06,   #行業別
          l_gzgd007        LIKE gzgd_t.gzgd007,   #樣板名稱(4rp)
          l_gzgd013        LIKE gzgd_t.gzgd013    #客戶紙張  #150202 add
   DEFINE l_mdir           STRING 
   DEFINE l_tmpdir         STRING,
          l_log_errfile    STRING,
          l_today_str      STRING,
          l_log_okfile     STRING   
   DEFINE l_j              INTEGER 
   DEFINE l_result         BOOLEAN
   DEFINE l_msg            STRING              #141224 add
   DEFINE r_lbl_msg        STRING              #141224 add 
   DEFINE r_success        LIKE type_t.num5

   LET g_erpid = NVL(FGL_GETENV("ERPID"),"T100ERP")           #161213 add
   LET l_today_str = TODAY USING "yymmdd"
   LET l_tmpdir = FGL_GETENV("TEMPDIR")
   LET l_log_okfile = "sadzp188_multilang_4rp_ok",l_today_str,".log" #正式區ok檔案      
   LET g_logokfile = os.Path.join(l_tmpdir, l_log_okfile)
   LET g_log_ch_ok = base.Channel.create()
#   CALL g_log_ch_ok.openFile(g_logokfile, "w")   #161103-00051#1 mark
   CALL g_log_ch_ok.openFile(g_logokfile, "a")    #161103-00051#1 add
   IF os.Path.chrwx(g_logokfile,511) THEN END IF  #161103-00051#1 add #修改權限
         
   LET l_log_errfile = "sadzp188_multilang_4rp_err",l_today_str,".log" #正式區不ok檔案      
   LET g_logerrfile = os.Path.join(l_tmpdir, l_log_errfile)
   LET g_log_ch_err = base.Channel.create()
#   CALL g_log_ch_err.openFile(g_logerrfile, "w")   #161103-00051#1 mark
   CALL g_log_ch_err.openFile(g_logerrfile, "a")    #161103-00051#1 add
   IF os.Path.chrwx(g_logerrfile,511) THEN END IF  #161103-00051#1 add #修改權限

   LET g_chk_lbl_msg = NULL  #141224 add
   LET r_lbl_msg = NULL      #141224 add 
   LET l_j=1

   IF cl_null(g_cust_flag) THEN
      SELECT gzde008 INTO g_cust_flag FROM gzde_t 
       WHERE gzde001 = p_rep_code 
   END IF
   CALL cl_err_collect_init()     #錯誤訊息彙總   #160629-00012#1-3 add
   #依模組轉換   
   IF p_mod IS NOT NULL THEN
      LET p_mod = DOWNSHIFT(p_mod)
      LET l_sql = "SELECT gzgd000,gzgd001,gzgd002,gzgd005,gzgd004,",
                  "       gzgd003,gzgd007,gzgd013 ",   #150202 add gzgd013
                  "  FROM gzgd_t ",
                  " WHERE gzgdstus = 'Y' ",
                  "   AND gzgd001 LIKE '",p_mod CLIPPED,"%'",
                  " ORDER BY gzgd001,gzgd002,gzgd003,gzgd007 "
   END IF
   
   #單支報表轉換
   IF p_rep_code IS NOT NULL THEN 
      IF cl_null(p_4rpname) THEN
         #未傳入樣板代號      
         LET l_sql = "SELECT gzgd000,gzgd001,gzgd002,gzgd005,gzgd004,",
                     "       gzgd003,gzgd007,gzgd013 ",  #150202 add gzgd013
                     "  FROM gzgd_t ",
                     " WHERE gzgdstus = 'Y' ",
                     "   AND gzgd001 = '",p_rep_code CLIPPED,"'",
                     "   AND gzgd003 = '",g_cust_flag CLIPPED,"' ",
                     " ORDER BY gzgd001,gzgd002,gzgd003,gzgd007 "
      ELSE
         #有傳入樣板代號
         LET l_sql = "SELECT gzgd000,gzgd001,gzgd002,gzgd005,gzgd004,",
                     "       gzgd003,gzgd007,gzgd013 ",  #150202 add gzgd013
                     "  FROM gzgd_t ",
                     " WHERE gzgdstus = 'Y' ",
                     "   AND gzgd001 = '",p_rep_code CLIPPED,"'",
                     "   AND gzgd002 = '",p_4rpname CLIPPED,"'",                     
                     "   AND gzgd003 = '",g_cust_flag CLIPPED,"' ",
                     " ORDER BY gzgd001,gzgd002,gzgd003,gzgd007 "         
      END IF      
   END IF
         
   LET g_4rpid = ""
   LET g_gzgd007 = ""
   LET l_gzgd001 = ""
   LET l_gzgd002 = ""
   LET l_gzgd005 = ""
   LET l_gzgd004 = ""
   LET l_gzgd003 = ""
   LET l_gzgd007 = ""
   LET l_gzgd013 = ""  #150202 add
   
   PREPARE azzi303_multi_lang_gzgd_pr FROM l_sql
   DECLARE azzi303_multi_lang_gzgd_cs CURSOR FOR azzi303_multi_lang_gzgd_pr
   FOREACH azzi303_multi_lang_gzgd_cs INTO l_gzgd000,l_gzgd001,l_gzgd002,l_gzgd005,l_gzgd004,
                                         l_gzgd003,l_gzgd007,l_gzgd013  #150202 add gzgd013
      LET g_4rpid = l_gzgd000
      LET g_gzgd007 = l_gzgd007
      LET r_success = FALSE
   
      #依模組轉換
      IF NOT cl_null(p_mod) THEN LET l_mdir = p_mod END IF
      
      #簽入時的模組
      IF NOT cl_null(p_sys) THEN LET l_mdir = p_sys END IF           
      LET  g_mdir = l_mdir
          
      LET l_4rpdir = os.Path.join(FGL_GETENV(UPSHIFT(l_mdir)),"4rp") #取得4rp路徑
#      LET l_4rpdir_w = os.Path.join(os.Path.join(FGL_GETENV("MNT4RP"),DOWNSHIFT(l_mdir)),"4rp")   #151102-00034#1 mark
      LET l_4rpdir_w = os.Path.join(os.Path.join(cl_rpt_get_env_global("MNT4RP"),DOWNSHIFT(l_mdir)),"4rp")   #151102-00034#1 add
      
      IF os.Path.exists(l_4rpdir) THEN
         LET l_4rpfile = os.Path.join(l_4rpdir,p_lang_trans CLIPPED)  
         LET l_4rpfile = os.Path.join(l_4rpfile,l_gzgd007 CLIPPED||".4rp")

         LET l_4rpfile_src = os.Path.join(l_4rpdir,p_lang_src)
         LET l_4rpfile_src = os.Path.join(l_4rpfile_src,l_gzgd007 CLIPPED||".4rp")
   
            
         IF os.Path.exists(l_4rpfile_src) THEN
            #不覆蓋就離開
            IF p_flag = "N" AND os.Path.exists(l_4rpfile) THEN
               LET r_success = TRUE
               RETURN r_success,r_lbl_msg
            END IF 

            #先備份
            CALL os.Path.copy(l_4rpfile, l_4rpfile||"_lang.bak") RETURNING l_result
            #161103-00051#1 add(s)
            IF NOT l_result THEN
               LET g_msg = g_prog,",",g_4rpfile,", copy file failure-bak"
               CALL g_log_ch_err.writeLine(g_msg)
            END IF
            #161103-00051#1 add(e)
            #先複製底稿檔案至語言別資料夾
            CALL os.Path.copy(l_4rpfile_src, l_4rpfile) RETURNING l_result
            #161103-00051#1 add(s)
            IF NOT l_result THEN
               LET g_msg = g_prog,",",g_4rpfile,", copy file failure-src"
               CALL g_log_ch_err.writeLine(g_msg)
            END IF
            #161103-00051#1 add(e)
            CALL os.Path.chrwx(l_4rpfile,511) RETURNING l_result
            LET l_base4rp = ""
            LET l_base4rp = l_4rpfile

            LET g_4rpfile = l_4rpfile
              
            LET l_doc = om.DomDocument.createFromXmlFile(l_base4rp)
            IF l_doc IS NOT NULL THEN
               LET l_rootnode = l_doc.getDocumentElement()
               IF l_rootnode IS NOT NULL THEN  
                  LET  g_find_cnt=0
                  CALL sadzp188_multilang_4rp_font(l_rootnode,p_lang_trans)  #根據語言別替換字型
                  CALL sadzp188_multilang_4rp_label_trans(l_gzgd007,l_rootnode,"WORDWRAPBOX",p_lang_trans) RETURNING l_msg
                  LET r_lbl_msg = r_lbl_msg,l_msg  #141224 add
                  CALL sadzp188_multilang_4rp_label_trans(l_gzgd007,l_rootnode,"WORDBOX",p_lang_trans) RETURNING l_msg
                  LET r_lbl_msg = r_lbl_msg,l_msg  #141224 add
                  #161103-00051#1 add(s)
                  #表頭欄位說明等寬
                  IF (p_lang_trans != "zh_TW" AND p_lang_trans != "zh_CN") THEN   #161103-00051#1 add
                  #IF (p_lang_trans != "zh_TW" OR p_lang_trans != "zh_CN") THEN   #161103-00051#1 mark
                     CALL sadzp188_multilang_4rp_en_header(l_rootnode)
                  END IF
                  #161103-00051#1 add(e)
               END IF   
               CALL l_rootnode.writeXml(l_base4rp)  #更新xml
 
               #先將AP主機上的檔案備份，再把檔案複製一份至AP主機上
               LET l_4rpfile_w = os.Path.join(l_4rpdir_w,p_lang_trans CLIPPED)
               LET l_4rpfile_w = os.Path.join(l_4rpfile_w,l_gzgd007 CLIPPED||".4rp")

               IF g_erpid = "T100ERP" THEN             #160608-00012#1 add       
                  CALL os.Path.copy(l_4rpfile, l_4rpfile_w) RETURNING l_result 
                  #161103-00051#1 add(s)
                  IF NOT l_result THEN
                     #DISPLAY "copy file to Report Server failure"   #170123-00046#1 mark
                     LET g_msg = g_prog,",",g_4rpfile,", copy file failure-Report Server"
                     CALL g_log_ch_err.writeLine(g_msg)
                  END IF
                  #161103-00051#1 add(e)
                  CALL os.Path.chrwx(l_4rpfile_w,511) RETURNING l_result     
               END IF                                  #160608-00012#1 add
               
               LET g_msg=""
#               LET g_msg=l_base4rp,"已轉換"              #161103-00051#1 mark
               LET g_msg=g_prog,",",l_base4rp,",已轉換"   #161103-00051#1 add
               CALL g_log_ch_ok.writeLine(g_msg)          #161103-00051#1 remark
               LET r_success = TRUE
            ELSE   #150707-00030#1 add
               LET r_success = TRUE   #150707-00030#1 add            
            END IF #l_doc IS NOT NULL THEN
            #LET g_title=0
         END IF  
      END IF 
   END FOREACH

   CALL cl_err_collect_show()     #160629-00012#1-3 #顯示彙總錯誤訊息
   
   CLOSE azzi303_multi_lang_gzgd_cs
   FREE azzi303_multi_lang_gzgd_cs
   FREE azzi303_multi_lang_gzgd_pr
   
   RETURN r_success,r_lbl_msg
END FUNCTION

################################################################################
# Descriptions...: 根據語言別替換字型
# Memo...........:
# Usage..........: sadzp188_multilang_4rp_font(p_rootnode,p_lang_trans)
# Input parameter: p_rootnode     
#                : p_lang_trans   轉換語言別
# Return code....: void
# Date & Author..: 2014/8/8 By Cynthia
# Modify.........:
################################################################################
PRIVATE FUNCTION sadzp188_multilang_4rp_font(p_rootnode,p_lang_trans)
   DEFINE p_rootnode   om.DomNode
   DEFINE p_lang_trans LIKE gzzy_t.gzzy001   #轉換語言別
   DEFINE l_curnode    om.DomNode
   DEFINE l_nodes      om.NodeList
   DEFINE l_i,l_j      INTEGER
   DEFINE l_font_tag   DYNAMIC ARRAY OF LIKE type_t.chr50
   DEFINE l_fontname   STRING
   
   LET g_msg = ""

   LET l_font_tag[1] = "WORDBOX"
   LET l_font_tag[2] = "WORDWRAPBOX"      
   LET l_font_tag[3] = "HTMLBOX"      
   LET l_font_tag[4] = "DECIMALFORMATBOX"
   LET l_font_tag[5] = "PAGENOBOX"
   LET l_font_tag[6] = "IMAGEBOX"

   #根據語言別指定字型
   CASE p_lang_trans
      WHEN "zh_TW"
         LET l_fontname = "微軟正黑體"
      WHEN "zh_CN"
         LET l_fontname = "Microsoft YaHei" 
      OTHERWISE
         LET l_fontname = "Arial Unicode MS"                  
   END CASE   

   FOR l_i = 1 TO l_font_tag.getLength()  
      LET l_nodes = p_rootnode.selectByTagName(l_font_tag[l_i])
      FOR l_j = 1 TO l_nodes.getLength()
         LET l_curnode=l_nodes.item(l_j)  
         CALL l_curnode.removeAttribute("fontName")
         CALL l_curnode.setAttribute("fontName",l_fontname)              
      END FOR
   END FOR    
END FUNCTION


################################################################################
# Descriptions...: 根據語言別置換欄位說明(_Label)
# Memo...........:
# Usage..........: CALL sadzp188_multilang_4rp_label_trans(p_gzgd007,p_rootnode,p_tagname,p_lang) RETURNING l_msg
# Input parameter: p_rootnode
#                : p_lang_src     來源語言別
#                : p_lang_trans   轉換語言別
# Return code....: void
# Date & Author..: 2014/8/8 By Cynthia
# Modify.........:
################################################################################
PRIVATE FUNCTION sadzp188_multilang_4rp_label_trans(p_gzgd007,p_rootnode,p_tagname,p_lang)
   DEFINE p_gzgd007       LIKE gzgd_t.gzgd007  #141224 add
   DEFINE p_rootnode      om.DomNode
   DEFINE p_tagname       STRING
   DEFINE p_lang          LIKE gzzy_t.gzzy001   #語言別
   DEFINE l_curnode       om.DomNode
   DEFINE l_nodes         om.NodeList
   DEFINE l_i             INTEGER
   DEFINE l_curname       STRING
   DEFINE l_fieldname     STRING
   DEFINE l_label_text    STRING
   DEFINE l_trans         STRING
   DEFINE l_flag          LIKE type_t.chr1    #欄位說明是否有冒號
   DEFINE l_gzge001       LIKE gzge_t.gzge001
   DEFINE l_gzge003       LIKE gzge_t.gzge003
   DEFINE l_gzge003_tran  LIKE gzge_t.gzge003
   DEFINE l_test          INTEGER
   DEFINE l_flag2         LIKE type_t.chr1    #欄位說明是否為純英數 #150616-00029#1 add 
   DEFINE l_lbl_strbuf    base.StringBuffer   #錯誤訊息(說明)  #141224 add
   DEFINE l_msg           STRING              #141224 add
   DEFINE r_msg           STRING              #141224 add  
   #161103-00051#1 add(s)
   DEFINE l_ch1      base.Channel
   DEFINE l_file1    STRING
   DEFINE l_msg1     STRING 
   DEFINE l_ch2      base.Channel
   DEFINE l_file2    STRING
   DEFINE l_msg2     STRING 
   DEFINE l_sql              STRING
   DEFINE l_gzge003_tw       LIKE gzge_t.gzge003
   DEFINE la_gzzy     RECORD
                             gzzy001 LIKE gzzy_t.gzzy001, #語言別
                             gzozcol LIKE type_t.chr10    #語言別欄位
                      END RECORD
   DEFINE l_str       STRING            
   #161103-00051#1 add(e)
 
   LET g_msg = NULL
   LET l_msg = NULL   
   LET r_msg = NULL
   LET l_lbl_strbuf = base.StringBuffer.create()  

   #161103-00051#1 add(s)
   #取得說明失敗log檔
   LET l_file1 = os.Path.join(FGL_GETENV("TEMPDIR"), "mtl_gr_gzge.txt")
   LET l_ch1 = base.Channel.create()
   CALL l_ch1.openFile(l_file1, "a")   
   IF os.Path.chrwx(l_file1,511) THEN END IF  #161103-00051#1 add #修改權限
   LET l_file2 = os.Path.join(FGL_GETENV("TEMPDIR"), "mtl_gr_gzge2.txt")
   LET l_ch2 = base.Channel.create()
   CALL l_ch2.openFile(l_file2, "a")   
   IF os.Path.chrwx(l_file2,511) THEN END IF  #161103-00051#1 add #修改權限
   #161103-00051#1 add(e)
   
   CALL cl_err_collect_init()     #錯誤訊息彙總   #160629-00012#1-3 add   
   LET l_nodes = p_rootnode.selectByTagName(p_tagname)
   FOR l_i = 1 TO l_nodes.getLength()
      LET l_flag = ""
      LET l_trans = ""
      LET l_fieldname = ""
      LET l_label_text = ""
         
      LET l_curnode=l_nodes.item(l_i)  
      LET l_curname=l_curnode.getAttribute("name")
      LET l_label_text=l_curnode.getAttribute("text")

      IF l_curname.getIndexOf("_Label",1) > 0 THEN
         #先移除欄位說明的":"     
         IF l_label_text.getIndexOf(":",1) > 0 THEN
            LET l_flag = "Y"
            LET l_label_text = cl_replace_str(l_label_text,":","")   #150616-00029#1 add         
         ELSE
            LET l_flag = "N"
         END IF

         #判斷是否為純英數
         LET l_flag2 = sadzp188_gen4rp_str_chk(l_label_text)   #150616-00029#1 add         

         LET l_fieldname = l_curname
         LET l_fieldname = l_fieldname.subString(1,l_fieldname.getIndexOf("_Label",1)-1)
         IF l_fieldname.getIndexOf("sr",1) > 0 THEN
            LET l_fieldname = l_fieldname.subString(l_fieldname.getIndexOf(".",1)+1,l_fieldname.getLength())
         END IF 
         #DISPLAY "l_fieldname:",l_fieldname

         LET l_fieldname = cl_replace_str(l_fieldname,"PH","")
         LET l_fieldname = cl_replace_str(l_fieldname,"RH","")        
         LET l_fieldname = cl_replace_str(l_fieldname,"PF","")
         LET l_fieldname = cl_replace_str(l_fieldname,"RF","")

         CALL sadzp188_gen4rp_get_field_label(l_fieldname,p_lang,g_4rpid) RETURNING l_gzge003 #取出欄位說明
         #161103-00051#1 add(s)
         IF cl_null(l_gzge003) and p_lang = 'zh_TW' and g_lang = 'zh_CN' THEN
            LET l_gzge003 = cl_trans_code_tw_cn("zh_TW",l_label_text)
         END IF
         #161103-00051#1 add(e)
         #160127-00012#1 add(s)
         #轉英文樣板時,若多語言檔沒資料,呈現原本語系的說明
         IF p_lang = 'en_US' THEN
            IF cl_null(l_gzge003) THEN            
#               LET l_gzge003 = l_label_text #161103-00051#1 mark
               #161103-00051#1 add(s)
               #如果以上說明都取不到就到字典檔取
               CASE p_lang
                  WHEN "en_US" LET la_gzzy.gzozcol = "gzoz001"
                  WHEN "zh_CN" LET la_gzzy.gzozcol = "gzoz002"
                  WHEN "ja_JP" LET la_gzzy.gzozcol = "gzoz003"
                  WHEN "vi_VN" LET la_gzzy.gzozcol = "gzoz004"
                  WHEN "th_TH" LET la_gzzy.gzozcol = "gzoz005"
               END CASE

               LET l_gzge003_tw = NULL
               #取多語言檔繁體中文說明
               LET l_gzge001 = l_fieldname
               SELECT gzge003 INTO l_gzge003_tw FROM gzge_t
                WHERE gzge000 = g_4rpid   AND gzge001 = l_gzge001
                  AND gzge002 = "zh_TW"    AND gzgestus = "Y"

               IF cl_null(l_gzge003_tw) THEN
               SELECT gzge003 INTO l_gzge003_tw FROM gzge_t
                WHERE gzge000 = "standard"   AND gzge001 = l_gzge001
                  AND gzge002 = "zh_TW"    AND gzgestus = "Y"
               END IF

               IF cl_null(l_gzge003_tw) THEN
                  LET l_gzge003_tw = l_label_text
               END IF
              
               LET l_str = l_gzge003_tw
               LET l_str = cl_replace_str(l_str,"'","")
               LET l_str = cl_replace_str(l_str," ","")
               LET l_str = cl_replace_str(l_str,"　","")
               LET l_str = cl_replace_str(l_str,"：","")
               LET l_str = cl_replace_str(l_str,":","")
               LET l_gzge003_tw = l_str
               
               LET l_sql = "SELECT ",la_gzzy.gzozcol CLIPPED,
                           "  FROM gzoz_t WHERE gzoz000= '",l_gzge003_tw CLIPPED,"' "
               PREPARE get_gzzy_pre FROM l_sql
               EXECUTE get_gzzy_pre INTO l_gzge003
                        
               LET l_str = l_curname
               LET l_str = l_str.subString(1,7)
              
               IF cl_null(l_gzge003) THEN
                  IF l_label_text.subString(1,2) = "{{" THEN
                     LET l_msg2 = g_4rpfile,",",l_curname,",",l_label_text
                     CALL l_ch2.writeLine(l_msg2)
                  ELSE
                     IF l_str = "apr_str" THEN
                     ELSE
                        LET l_gzge003 = l_label_text
                        #IF g_prog = 'azzi303' THEN
                        IF l_label_text NOT MATCHES "[0-9]" AND NOT cl_null(l_label_text) THEN
                           LET l_msg1 = g_4rpfile,",",l_curname,",",l_label_text
                           CALL l_ch1.writeLine(l_msg1)                     
                           #LET l_msg1 = l_sql
                           #CALL l_ch1.writeLine(l_msg1)                     
                        END IF
                        #END IF
                     END IF
                  END IF
               END IF  
               #161103-00051#1 add(e)               
            END IF
         END IF
         #160127-00012#1 add(e)
         #150616-00029#1 add(s)
         #DISPLAY "l_flag2:",l_flag2
         #IF l_flag2 = "Y" THEN                                             #161216-00001#1 mark
         IF l_flag2 = "Y" AND (g_lang = "zh_TW" OR g_lang = "zh_CN") THEN   #161216-00001#1 add
            LET l_gzge003 = l_label_text
            #DISPLAY "l_label_text:",l_label_text
         END IF
         #150616-00029#1 add(e)
               
         #141224 add (s)
         IF g_prog <> "azzi303" THEN
            IF p_lang = "zh_TW" THEN
               CALL sadzp188_gen4rp_get_field_label(l_fieldname,"zh_CN",g_4rpid) RETURNING l_gzge003_tran #取出欄位說明
               IF l_gzge003_tran <> cl_trans_code_tw_cn("zh_CN",l_gzge003) THEN
                  LET l_msg=cl_getmsg("adz-00482",g_lang) CLIPPED,p_gzgd007," ",l_curname," 繁\"",l_gzge003,"\", 簡\"",l_gzge003_tran,"\""
                  IF l_msg IS NOT NULL THEN
                     CALL l_lbl_strbuf.append(l_msg)
                     CALL l_lbl_strbuf.append("\r\n")
                  END IF
               END IF
            END IF
            IF p_lang = "zh_CN" THEN
               CALL sadzp188_gen4rp_get_field_label(l_fieldname,"zh_TW",g_4rpid) RETURNING l_gzge003_tran #取出欄位說明 
               IF l_gzge003_tran <> cl_trans_code_tw_cn("zh_TW",l_gzge003) THEN
                  LET l_msg=cl_getmsg("adz-00482",g_lang) CLIPPED,p_gzgd007," ",l_curname," 繁\"",l_gzge003_tran,"\", 简\"",l_gzge003,"\""
                  IF l_msg IS NOT NULL THEN
                     CALL l_lbl_strbuf.append(l_msg)
                     CALL l_lbl_strbuf.append("\r\n")
                  END IF
               END IF 
            END IF
         END IF
         #141224 add (e)
      
         #150907 add(s)
         IF l_curname.getIndexOf("title",1) > 0 THEN
            IF p_lang="zh_TW" THEN 
               LET l_gzge003 = cl_trans_code_tw_cn("zh_TW",l_label_text) 
            ELSE
               LET l_gzge003 = cl_trans_code_tw_cn("zh_CN",l_label_text) 
            END IF
         END IF  #150907 add
         #150907 add(e)

         #上述比對完成後仍沒有值,寫入log
         IF NOT cl_null(l_gzge003) THEN
            LET l_trans = l_gzge003
            IF l_flag = "Y" THEN            
               LET l_trans = l_trans,":"
            END IF 
            CALL l_curnode.removeAttribute("text")
            CALL l_curnode.setAttribute("text",l_trans)
         ELSE
            LET g_msg = ""
            CALL l_curnode.removeAttribute("text")
            CALL l_curnode.setAttribute("text","")                
            LET g_msg = g_4rpfile," ",l_curname," 轉換失敗"
            #CALL g_log_ch_err.writeLine(g_msg)
         END IF                 
                   
      END IF
   END FOR

   CALL cl_err_collect_show()     #160629-00012#1-3 #顯示彙總錯誤訊息
   LET r_msg = l_lbl_strbuf.toString()
   RETURN r_msg
END FUNCTION


################################################################################
# Descriptions...: 檢查字串是否為純英數字(0~9,a~z,A~Z)
# Memo...........:
# Usage..........: CALL cl_chk_str_correct(ps_source,1,10)
# Input parameter: ps_source      來源資料
#                : ps_count       檢查幾碼, 如果未傳幾碼, 則會以來源字串長度當作ps_count
# Return code....: li_result
# Date & Author..: 2014/10/7 By Cynthia
# Modify.........:
################################################################################
PRIVATE FUNCTION sadzp188_multilang_chk_label(ps_source,pi_start,pi_end)
   DEFINE   ps_source   STRING
   DEFINE   pi_start    LIKE type_t.num5
   DEFINE   pi_end      LIKE type_t.num5
   DEFINE   li_i        LIKE type_t.num5
   DEFINE   l_j         LIKE type_t.num5
   DEFINE   ls_chk_chr  LIKE type_t.chr1
   DEFINE   li_result   LIKE type_t.num5

   IF (ps_source IS NULL) OR (pi_end < pi_start) OR
      (pi_start <= 0) OR (pi_end <= 0) THEN
      RETURN FALSE
   END IF

   IF (pi_start IS NULL) OR (pi_end IS NULL) THEN
      LET pi_start = 1
      LET pi_end = ps_source.getLength()
   END IF

   LET li_result = FALSE
   LET l_j = 0
   FOR li_i = pi_start TO pi_end
       LET ls_chk_chr = ps_source.getCharAt(li_i)
       #IF ls_chk_chr NOT MATCHES "[0-9a-zA-Z]" AND NOT cl_null(ls_chk_chr) THEN
       IF ls_chk_chr NOT MATCHES "[ 0-9a-zA-Z]" THEN
          LET l_j = l_j + 1        
       END IF
   END FOR

   IF l_j > 0 THEN
      LET li_result = TRUE
   END IF
   
   RETURN li_result
END FUNCTION   


################################################################################
# Descriptions...: 檢查4rp規範
# Memo...........:
# Usage..........: CALL sadzp188_multilang_4rp_chkgr(p_sys,p_rep_code,p_4rpname,p_lang)
# Input parameter: p_sys          模組代碼
#                : p_rep_code     報表元件代號
#                : p_4rpname      樣板名稱
#                : p_lang         語言別
# Return code....: ri_errcnt
#                : rs_msg
# Date & Author..: 2014/10/9 By Cynthia
# Modify.........:
################################################################################
PUBLIC FUNCTION sadzp188_multilang_4rp_chkgr(p_sys,p_rep_code,p_4rpname,p_lang)
   DEFINE p_sys            LIKE gzde_t.gzde002   #模組代碼
   DEFINE p_rep_code       LIKE gzgd_t.gzgd001   #報表元件代號
   DEFINE p_4rpname        LIKE gzgd_t.gzgd002   #樣板代號
   DEFINE p_lang           LIKE gzzy_t.gzzy001   #語言別
   DEFINE l_4rpfile        STRING
   DEFINE l_sql            STRING
   DEFINE l_gzgd000        LIKE gzgd_t.gzgd000,   #報表樣板ID
          l_gzgd002        LIKE gzgd_t.gzgd002,   #樣板代號
          l_gzgd003        LIKE gzgd_t.gzgd003,   #客製否
          l_gzgd007        LIKE gzgd_t.gzgd007,   #樣板名稱(4rp)
          l_gzgd013        LIKE gzgd_t.gzgd013    
   DEFINE l_doc            om.DomDocument
   DEFINE l_rootnode       om.DomNode
   DEFINE ri_errcnt        INTEGER 
   DEFINE rs_msg           STRING      
   
   LET g_chk_err_msg = NULL
   LET g_chk_force_msg = NULL
   LET g_chk_set_msg = NULL
   LET g_chk_fid_msg = NULL   #151026-00010#1 add
    
   IF cl_null(p_4rpname) THEN
      #未傳入樣板代號      
      LET l_sql = "SELECT gzgd000,gzgd002,gzgd003,gzgd007,gzgd013 ",
                  "  FROM gzgd_t ",
                  " WHERE gzgdstus = 'Y' ",
                  "   AND gzgd001 = '",p_rep_code CLIPPED,"'",
                  "   AND gzgd003 = '",g_cust_flag CLIPPED,"' ",
                  " ORDER BY gzgd001,gzgd002,gzgd003,gzgd007 "
   ELSE
      #有傳入樣板代號
      LET l_sql = "SELECT gzgd000,gzgd002,gzgd003,gzgd007,gzgd013 ",
                  "  FROM gzgd_t ",
                  " WHERE gzgdstus = 'Y' ",
                  "   AND gzgd001 = '",p_rep_code CLIPPED,"'",
                  "   AND gzgd002 = '",p_4rpname CLIPPED,"'",                
                  "   AND gzgd003 = '",g_cust_flag CLIPPED,"' ",
                  " ORDER BY gzgd001,gzgd002,gzgd003,gzgd007 "         
   END IF  

   LET g_4rpid = ""
   #LET g_gzgd007 = ""
   LET l_gzgd002 = ""
   LET l_gzgd003 = ""
   LET l_gzgd007 = ""
   
   PREPARE sadzp188_multilang_4rp_name_pr FROM l_sql
   DECLARE sadzp188_multilang_4rp_name_cs CURSOR FOR sadzp188_multilang_4rp_name_pr
   FOREACH sadzp188_multilang_4rp_name_cs INTO l_gzgd000,l_gzgd002,l_gzgd003,l_gzgd007,l_gzgd013
      CALL sadzp188_get4rppath(p_sys,l_gzgd007,p_lang) RETURNING l_4rpfile
      IF NOT os.Path.exists(l_4rpfile) THEN
         #LET rs_msg = "(path: ",l_4rpfile.trim(),")"
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'azz-00676'
         LET g_errparam.extend = l_4rpfile
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN 0,NULL
      END IF

      #將4rp欄位屬性讀入陣列
      LET l_doc = om.DomDocument.createFromXmlFile(l_4rpfile)
      IF l_doc IS NOT NULL THEN
         LET l_rootnode = l_doc.getDocumentElement()
      
         #檢查GR所有規範
         LET g_force_err=0
         CALL sadzp188_multilang_4rp_chkrule(l_gzgd007,p_lang,l_rootnode,"WORDWRAPBOX")
         CALL sadzp188_multilang_4rp_chkrule(l_gzgd007,p_lang,l_rootnode,"WORDBOX")
         CALL sadzp188_multilang_4rp_chkrule(l_gzgd007,p_lang,l_rootnode,"DECIMALFORMATBOX")  
         CALL sadzp188_multilang_4rp_chkrule(l_gzgd007,p_lang,l_rootnode,"PAGENOBOX")  
         CALL sadzp188_multilang_4rp_chkrule(l_gzgd007,p_lang,l_rootnode,"IMAGEBOX")  
         CALL sadzp188_multilang_4rp_chkrule(l_gzgd007,p_lang,l_rootnode,"MINIPAGE")  
         CALL sadzp188_multilang_4rp_chkrule(l_gzgd007,p_lang,l_rootnode,"LAYOUTNODE")
         CALL sadzp188_multilang_4rp_chkrule(l_gzgd007,p_lang,l_rootnode,"TABLE")
         #檢查數值格式
         CALL sadzp188_multilang_4rp_chknum(p_lang,p_rep_code,l_gzgd007,l_rootnode)
         #檢查日期格式
         CALL sadzp188_multilang_4rp_chkdate(p_lang,p_rep_code,l_gzgd007,l_rootnode)
      END IF   
      LET ri_errcnt=g_force_err + ri_errcnt
   END FOREACH                                      

#   CLOSE sadzp188_multilang_4rp_name_cs
#   FREE sadzp188_multilang_4rp_name_cs
#   FREE sadzp188_multilang_4rp_name_pr
   
#   IF NOT cl_null(g_chk_force_msg) THEN
   #151026-00010#1 mark(s)
#   IF ri_errcnt > 0 THEN
#      LET g_chk_err_msg = cl_getmsg("adz-00459",p_lang) CLIPPED,"\r\n",g_chk_force_msg
#      IF NOT cl_null(g_chk_set_msg) THEN
#         LET g_chk_err_msg = g_chk_err_msg,"\r\n\r\n",g_chk_set_msg
#      END IF
#   ELSE
#      IF NOT cl_null(g_chk_set_msg) THEN
#         LET g_chk_err_msg = g_chk_set_msg
#      END IF
#   END IF
   #151026-00010#1 mark(e)

   #151026-00010#1 add(s)
   #強制訊息
   IF ri_errcnt > 0 THEN
#      LET g_chk_err_msg = cl_getmsg("adz-00459",p_lang) CLIPPED,"\r\n",g_chk_force_msg,"\r\n\r\n"   #170123-00046#1 mark
      LET g_chk_err_msg = cl_getmsg("adz-00459",g_lang) CLIPPED,"\r\n",g_chk_force_msg,"\r\n\r\n"    #170123-00046#1 add
   END IF

   #準確性
   IF NOT cl_null(g_chk_fid_msg) THEN
#      LET g_chk_err_msg = g_chk_err_msg,cl_getmsg("adz-00722",p_lang) CLIPPED,"\r\n"   #170123-00046#1 mark
      LET g_chk_err_msg = g_chk_err_msg,cl_getmsg("adz-00722",g_lang) CLIPPED,"\r\n"    #170123-00046#1 add
      LET g_chk_err_msg = g_chk_err_msg,g_chk_fid_msg,"\r\n\r\n"
   END IF      

   #設定   
   IF NOT cl_null(g_chk_set_msg) THEN
#      LET g_chk_err_msg = g_chk_err_msg,cl_getmsg("adz-00723",p_lang) CLIPPED,"\r\n"   #170123-00046#1 mark
      LET g_chk_err_msg = g_chk_err_msg,cl_getmsg("adz-00723",g_lang) CLIPPED,"\r\n"    #170123-00046#1 add
      LET g_chk_err_msg = g_chk_err_msg,g_chk_set_msg
   END IF   
   #151026-00010#1 add(e)
      
   LET rs_msg=g_chk_err_msg
   RETURN ri_errcnt,rs_msg      
   
END FUNCTION

################################################################################
# Descriptions...: 根據程式代號與樣板名稱取得4rp檔案完整路徑
# Memo...........:
# Usage..........: CALL sadzp188_get4rppath(p_sys,p_4rpname,p_lang)
# Input parameter: p_sys          模組代碼
#                : p_4rpname      樣板名稱
#                : p_lang         語言別
# Return code....: void
# Date & Author..: 2014/10/9 By Cynthia
# Modify.........:
################################################################################
PRIVATE FUNCTION sadzp188_get4rppath(p_sys,p_4rpname,p_lang)
   DEFINE p_sys            LIKE gzde_t.gzde002   #模組代碼
   DEFINE p_4rpname        LIKE gzgd_t.gzgd007   #樣板名稱
   DEFINE p_lang           LIKE gzzy_t.gzzy001   #語言別
   DEFINE l_mdir           STRING
   DEFINE r_path           STRING

   IF NOT cl_null(p_sys) AND NOT cl_null(p_4rpname) AND NOT cl_null(p_lang) THEN
      LET l_mdir = os.Path.join(FGL_GETENV(UPSHIFT(p_sys)),"4rp")
      LET l_mdir = os.Path.join(l_mdir,p_lang)
      IF os.Path.exists(l_mdir) THEN
         LET r_path = os.Path.join(l_mdir,p_4rpname||".4rp")
      ELSE
         LET r_path = ""
      END IF
   END IF

   RETURN r_path
END FUNCTION

################################################################################
# Descriptions...: 根據程式代號與樣板名稱取得4rp檔案完整路徑
# Memo...........:
# Usage..........: CALL sadzp188_multilang_4rp_chkrule(p_gzgd007,p_lang,p_node,p_tagname)
# Input parameter: p_sys          模組代碼
#                : p_4rpname      樣板名稱
#                : p_lang         語言別
# Return code....: void
# Date & Author..: 2014/10/9 By Cynthia
# Modify.........:
################################################################################
PRIVATE FUNCTION sadzp188_multilang_4rp_chkrule(p_gzgd007,p_lang,p_node,p_tagname)
   DEFINE p_gzgd007       STRING    #樣板名稱(4rp) 
   DEFINE p_lang          LIKE gzzy_t.gzzy001   #語言別
   DEFINE p_node          om.DomNode
   DEFINE p_tagname       STRING 
   DEFINE l_node          om.NodeList           #存標籤節點 
   DEFINE l_parent        om.DomNode
   DEFINE l_curnode       om.DomNode
   DEFINE l_par_parnode   om.DomNode            #祖父節點
   DEFINE l_ancestor_node om.DomNode            #祖父節點的父節點    
   DEFINE l_i             LIKE type_t.num5   
   DEFINE l_nodeName      STRING
   DEFINE l_parname       STRING                #父節點name屬性,父節點流水號
   DEFINE l_par_parname   STRING                #祖父節點name屬性
   DEFINE l_ancestor_name STRING                #祖父節點的父節點name屬性   
   DEFINE l_msg           STRING
   DEFINE l_force_strbuf  base.StringBuffer     #錯誤訊息(強制)   
   DEFINE l_set_strbuf    base.StringBuffer     #錯誤訊息(設定)   
   DEFINE l_fid_strbuf    base.StringBuffer     #錯誤訊息(準確性)   #151026-00010#1 add
   DEFINE l_childName     STRING                #子節點name屬性
   DEFINE l_cur_size      DYNAMIC ARRAY OF STRING       #X,Y,X-size,y-size屬性內容 
   DEFINE l_chi_node      DYNAMIC ARRAY OF om.DomNode   #子節點陣列  
   DEFINE l_childtag      STRING                #子節點的tagname
   DEFINE l_chi_i         LIKE type_t.num5   
   DEFINE l_ii            INTEGER
   DEFINE l_grandchi_node DYNAMIC ARRAY OF om.DomNode   #第二層子節點陣列  
   DEFINE l_grandchildtag STRING                #第二層子節點的tagname
   DEFINE l_grandchi_i    LIKE type_t.num5   
   DEFINE l_iii           INTEGER
   DEFINE l_childnode     om.DomNode 
   DEFINE l_grandchildnode     om.DomNode 
   DEFINE l_grandchildName      STRING                #第二層子節點name屬性
   DEFINE l_find_str      STRING               #尋找字串
   DEFINE l_find_chi_str  STRING               #尋找字串
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_cur_value     FLOAT
   DEFINE l_set_length    STRING 
   DEFINE l_set_width     STRING 
   DEFINE l_BORDERWIDTH_T ,l_BORDERWIDTH_B ,l_bottonwidth,l_topwidth  FLOAT   #分隔線
   DEFINE l_toppadding,l_borderStyle,l_borderStyle_D,l_bordertopstyle,l_borderbottonstyle    STRING
   DEFINE l_font,l_font_size  STRING
   DEFINE l_PADDINGWIDTH, l_paddingTopWidth STRING  #留白
   DEFINE l_box_str           STRING
   DEFINE l_str               STRING                 #160629-00012#1-2 add

   LET l_force_strbuf = base.StringBuffer.create()
   LET l_set_strbuf = base.StringBuffer.create()
   LET l_fid_strbuf = base.StringBuffer.create()   #151026-00010#1 add
   LET l_node = p_node.selectByTagName(p_tagname)
   
   IF l_node IS NOT NULL THEN
      FOR l_i=1 TO l_node.getLength()
         LET l_curnode = l_node.item(l_i)
         LET l_nodename = l_curnode.getAttribute("name")
         LET l_parent = l_curnode.getParent()
         LET l_parname=l_parent.getAttribute("name")
         LET l_par_parnode=l_parent.getParent() #祖父節點
         LET l_par_parname=l_par_parnode.getAttribute("name")#祖父節點名稱
         LET l_ancestor_node=l_par_parnode.getParent() #祖父節點的父節點
         LET l_ancestor_name=l_ancestor_node.getAttribute("name")#祖父節點的父節點名稱
         
         ###檢查父節點(容器)(s)
         IF (p_tagname="WORDWRAPBOX" OR p_tagname="WORDBOX" OR 
            p_tagname="PAGENOBOX" OR p_tagname="IMAGEBOX" OR 
            p_tagname="HTMLBOX" OR p_tagname="DECIMALFORMATBOX") AND p_gzgd007.getIndexOf("subrep",1)=0 THEN 
            IF l_parent.getAttribute("name") IS NOT NULL THEN
               IF l_parname.getIndexOf("PageFooter",1)>0 THEN
                  IF NOT l_par_parname.equals("PageFooters") THEN
                     #LET l_msg ="(強制)", cl_getmsg_parm("azz1235", p_lang, l_nodename),"PageFooters"
#                     LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED, p_gzgd007," ",cl_getmsg("adz-00406",p_lang)," PageFooters"   #170123-00046#1 mark
#                     LET l_msg = cl_replace_str(l_msg,"[%1]",l_nodename)                                                             #170123-00046#1 mark
                     LET l_msg = cl_getmsg("adz-00408",g_lang) CLIPPED, p_gzgd007," ",
                                 cl_replace_err_msg(cl_getmsg("adz-00406", g_lang),l_nodename)," PageFooters"                         #170123-00046#1 add
                     IF l_msg IS NOT NULL THEN
                        CALL l_force_strbuf.append(l_msg)
                        CALL l_force_strbuf.append("\r\n")
                     END IF     
                     LET g_force_err=g_force_err+1 #強制訊息                                              
                  END IF
               ELSE 
                  IF l_parname.getIndexOf("PHMaster",1)>0 AND l_parname.getIndexOf("PHMasterA",1)=0 AND l_parname.getIndexOf("PHMasterC",1)=0 THEN
                     IF NOT l_par_parname.getIndexOf("PHMaster",1)>0 THEN
#                        LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," PHMaster"   #170123-00046#1 mark
#                        LET l_msg = cl_replace_str(l_msg,"[%1]",l_nodename)                                                          #170123-00046#1 mark
                        LET l_msg = cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",
                                    cl_replace_err_msg(cl_getmsg("adz-00406", g_lang),l_nodename)," PHMaster"                         #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_force_strbuf.append(l_msg)
                           CALL l_force_strbuf.append("\r\n")
                        END IF     
                        LET g_force_err=g_force_err+1 #強制訊息      
                     ELSE
                        IF NOT l_ancestor_name.equals("PHMasters") AND l_ancestor_name.getIndexOf("PHMasterC",1)=0 THEN
#                           LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," PHMasters"   #150616-00029#1 mark
#                           LET l_msg = cl_replace_str(l_msg,"[%1]",l_parname)   #150616-00029#1 mark
#                           LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," ",l_parname   #150616-00029#1 add   #170123-00046#1 mark
#                           LET l_msg = cl_replace_str(l_msg,"[%1]",l_nodename)   #150616-00029#1 add                                                            #170123-00046#1 mark
                           LET l_msg = cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",
                                       cl_replace_err_msg(cl_getmsg("adz-00406", g_lang),l_nodename)," ",l_parname                                               #170123-00046#1 add
                           IF l_msg IS NOT NULL THEN
                              CALL l_force_strbuf.append(l_msg)
                              CALL l_force_strbuf.append("\r\n")
                           END IF     
                           LET g_force_err=g_force_err+1 #強制訊息                                 
                        END IF 
                     END IF
                  ELSE
                     IF l_parname.getIndexOf("PHMasterA",1)>0 AND l_parname.getIndexOf("PHMasterC",1)=0 THEN
                        IF NOT l_par_parname.equals("PHMasterAs") THEN
#                           LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," PHMasterAs"   #170123-00046#1 mark
#                           LET l_msg = cl_replace_str(l_msg,"[%1]",l_nodename)                                                            #170123-00046#1 mark
                           LET l_msg = cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",
                                       cl_replace_err_msg(cl_getmsg("adz-00406", g_lang),l_nodename)," PHMasterAs"                         #170123-00046#1 add
                           IF l_msg IS NOT NULL THEN
                              CALL l_force_strbuf.append(l_msg)
                              CALL l_force_strbuf.append("\r\n")
                           END IF     
                           LET g_force_err=g_force_err+1 #強制訊息                                              
                        END IF
                     ELSE
#                        IF l_parname.getIndexOf("PHDetailHeader",1)>0 AND l_parname.getIndexOf("PHDetailHeaderV",1)=0 THEN  #150624 mark
                        IF l_parname.getIndexOf("PHDetailHeader",1)>0 AND l_parname.getIndexOf("PHDetailHeaderV",1)=0 AND l_parname.getIndexOf("PHDetailHeaderC",1)=0 THEN   #150624 add
                           IF NOT l_par_parname.equals("PHDetailHeaders") THEN
#                              LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," PHDetailHeaders"   #170123-00046#1 mark
#                              LET l_msg = cl_replace_str(l_msg,"[%1]",l_nodename)                                                                 #170123-00046#1 mark
                              LET l_msg = cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",
                                          cl_replace_err_msg(cl_getmsg("adz-00406", g_lang),l_nodename)," PHDetailHeaders"                         #170123-00046#1 add
                              IF l_msg IS NOT NULL THEN
                                 CALL l_force_strbuf.append(l_msg)
                                 CALL l_force_strbuf.append("\r\n")
                              END IF     
                              LET g_force_err=g_force_err+1 #強制訊息                                             
                           END IF
                        ELSE
                           IF l_parname.getIndexOf("RHMaster",1)>0 AND l_parname.getIndexOf("RHMasterA",1)=0 AND l_parname.getIndexOf("RHMasterC",1)=0 THEN
                              IF NOT l_par_parname.getIndexOf("RHMaster",1)>0 THEN
#                                 LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," RHMaster"   #170123-00046#1 mark
#                                 LET l_msg = cl_replace_str(l_msg,"[%1]",l_nodename)                                                          #170123-00046#1 mark
                                 LET l_msg = cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",
                                             cl_replace_err_msg(cl_getmsg("adz-00406", g_lang),l_nodename)," RHMaster"                         #170123-00046#1 add
                                 IF l_msg IS NOT NULL THEN
                                    CALL l_force_strbuf.append(l_msg)
                                    CALL l_force_strbuf.append("\r\n")
                                 END IF     
                                 LET g_force_err=g_force_err+1 #強制訊息      
                              ELSE
                                 IF NOT l_ancestor_name.equals("RHMasters") AND l_ancestor_name.getIndexOf("RHMasterC",1)=0 THEN
#                                    LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," RHMasters"   #150616-00029#1 mark
#                                    LET l_msg = cl_replace_str(l_msg,"[%1]",l_parname)   #150616-00029#1 mark
#                                    LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," ",l_parname   #150616-00029#1 add   #170123-00046#1 mark
#                                    LET l_msg = cl_replace_str(l_msg,"[%1]",l_nodename)   #150616-00029#1 add                                                            #170123-00046#1 mark
                                    LET l_msg = cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",
                                                cl_replace_err_msg(cl_getmsg("adz-00406", g_lang),l_nodename)," ",l_parname                                               #170123-00046#1 add
                                    IF l_msg IS NOT NULL THEN
                                       CALL l_force_strbuf.append(l_msg)
                                       CALL l_force_strbuf.append("\r\n")
                                    END IF     
                                    LET g_force_err=g_force_err+1 #強制訊息                                 
                                 END IF 
                              END IF
                           ELSE
                              IF l_parname.getIndexOf("RHMasterA",1)>0 AND l_parname.getIndexOf("RHMasterC",1)=0 THEN
                                 IF NOT l_par_parname.equals("RHMasterAs") THEN
#                                    LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," RHMasterAs"   #170123-00046#1 mark
#                                    LET l_msg = cl_replace_str(l_msg,"[%1]",l_nodename)                                                            #170123-00046#1 mark
                                    LET l_msg = cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",
                                                cl_replace_err_msg(cl_getmsg("adz-00406", g_lang),l_nodename)," RHMasterAs"                         #170123-00046#1 add
                                    IF l_msg IS NOT NULL THEN
                                       CALL l_force_strbuf.append(l_msg)
                                       CALL l_force_strbuf.append("\r\n")
                                    END IF     
                                    LET g_force_err=g_force_err+1 #強制訊息                                              
                                 END IF
                              ELSE
#                                 IF l_parname.getIndexOf("RHDetailHeader",1)>0 AND l_parname.getIndexOf("RHDetailHeaderV",1)=0 THEN   #150624 mark
                                 IF l_parname.getIndexOf("RHDetailHeader",1)>0 AND l_parname.getIndexOf("RHDetailHeaderV",1)=0 AND l_parname.getIndexOf("RHDetailHeaderC",1)=0 THEN   #150624 add
                                    IF NOT l_par_parname.equals("RHDetailHeaders") THEN
#                                       LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," RHDetailHeaders"   #170123-00046#1 mark
#                                       LET l_msg = cl_replace_str(l_msg,"[%1]",l_nodename)                                                                 #170123-00046#1 mark
                                       LET l_msg = cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",
                                                   cl_replace_err_msg(cl_getmsg("adz-00406", g_lang),l_nodename)," RHDetailHeaders"                         #170123-00046#1 add
                                       IF l_msg IS NOT NULL THEN
                                          CALL l_force_strbuf.append(l_msg)
                                          CALL l_force_strbuf.append("\r\n")
                                       END IF     
                                       LET g_force_err=g_force_err+1 #強制訊息                                             
                                    END IF
                                 ELSE
                                    LET l_box_str = DOWNSHIFT(l_parname)
#                                    IF l_parname.getIndexOf("Detail",1)>0 THEN
                                    #IF l_parname.getIndexOf("Detail",1)>0 AND l_parname.getIndexOf("_Col",1)=0 THEN  #141204
                                    IF l_parname.getIndexOf("Detail",1)>0 AND l_parname.getIndexOf("_Col",1)=0 AND l_box_str.getIndexOf("_box",1)=0 AND
                                       l_parname.getIndexOf("DetailVbox",1)=0 AND l_parname.getIndexOf("DetailHeaderV",1)=0 AND l_parname.getIndexOf("DetailHeaderC",1)=0 AND l_parname.getIndexOf("DetailC",1)=0 THEN  #141204 #150624 add
#                                       l_parname.getIndexOf("DetailVbox",1)=0 AND l_parname.getIndexOf("DetailHeaderV",1)=0 AND l_parname.getIndexOf("DetailC",1)=0 THEN  #141204 #150624 
                                       IF NOT l_par_parname.equals("Details") THEN
#                                          LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," Details"   #170123-00046#1 mark
#                                          LET l_msg = cl_replace_str(l_msg,"[%1]",l_nodename)                                                         #170123-00046#1 mark
                                          LET l_msg = cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",
                                                      cl_replace_err_msg(cl_getmsg("adz-00406", g_lang),l_nodename)," Details"                         #170123-00046#1 add
                                          IF l_msg IS NOT NULL THEN
                                             CALL l_force_strbuf.append(l_msg)
                                             CALL l_force_strbuf.append("\r\n")
                                          END IF     
                                          LET g_force_err=g_force_err+1 #強制訊息                                             
                                       END IF
                                    ELSE
                                       IF l_parname.getIndexOf("ReportFooter",1)>0 THEN
                                          IF NOT l_par_parname.equals("ReportFooters") THEN
#                                             LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," ReportFooters"   #170123-00046#1 mark
#                                             LET l_msg = cl_replace_str(l_msg,"[%1]",l_nodename)                                                               #170123-00046#1 mark
                                             LET l_msg = cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",
                                                         cl_replace_err_msg(cl_getmsg("adz-00406", g_lang),l_nodename)," ReportFooters"                         #170123-00046#1 add
                                             IF l_msg IS NOT NULL THEN
                                                CALL l_force_strbuf.append(l_msg)
                                                CALL l_force_strbuf.append("\r\n")
                                             END IF     
                                             LET g_force_err=g_force_err+1 #強制訊息                                             
                                          END IF
                                       ELSE
                                          IF l_parname.getIndexOf("DetailVbox",1)>0 THEN
                                             IF NOT l_par_parname.equals("DetailVboxs") THEN
#                                                LET l_msg = cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", cl_getmsg("adz-00406",p_lang)," DetailVboxs"   #170123-00046#1 mark
#                                                LET l_msg = cl_replace_str(l_msg,"[%1]",l_nodename)                                                             #170123-00046#1 mark
                                                LET l_msg = cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",
                                                            cl_replace_err_msg(cl_getmsg("adz-00406", g_lang),l_nodename)," DetailVboxs"                         #170123-00046#1 add
                                                IF l_msg IS NOT NULL THEN
                                                   CALL l_force_strbuf.append(l_msg)
                                                   CALL l_force_strbuf.append("\r\n")
                                                END IF     
                                                LET g_force_err=g_force_err+1 #強制訊息                                             
                                             END IF                                          
                                          END IF
                                       END IF   #Detail
                                    END IF   #RHDetailHeader
                                 END IF   #RHDetailHeader
                              END IF   #RHMastersA   
                           END IF   #RHMaster                      
                        END IF   #PHDetailHeader
                     END IF   #PageFooter                  
                  END IF   #PHMaster
               END IF   #PageFooter             
            END IF   #l_parent.getAttribute("name") IS NOT NULL
         END IF   #IF p_tagname=WORDWRAPBOX、WORDBOX~~~~
         ###檢查父節點(容器)(e)

         ###檢查PageRoot相關規則(s)
         IF  l_curnode.getAttribute("name")="Page Root" THEN 
            #160629-00012#1-2 add(s)
            #檢查高和寬是否為max
            LET l_str = l_curnode.getAttribute("width")
            LET l_str = DOWNSHIFT(l_str)
            IF l_str != "max" THEN
#               LET l_msg= cl_getmsg("adz-00886",p_lang)                                #170123-00046#1 mark
#               LET l_msg = cl_replace_str(l_msg,"%1","X-Size")                         #170123-00046#1 mark
               LET l_msg= cl_replace_err_msg(cl_getmsg("adz-00886", g_lang),"X-Size")   #170123-00046#1 add
               LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",l_msg
               CALL l_force_strbuf.append(l_msg)
               CALL l_force_strbuf.append("\r\n")
               LET g_force_err=g_force_err+1 #強制訊息                                
            END IF
            
            LET l_str = l_curnode.getAttribute("length")
            LET l_str = DOWNSHIFT(l_str)
            IF l_str != "max" THEN
#               LET l_msg= cl_getmsg("adz-00886",p_lang)                                #170123-00046#1 mark
#               LET l_msg = cl_replace_str(l_msg,"%1","Y-Size")                         #170123-00046#1 mark
               LET l_msg= cl_replace_err_msg(cl_getmsg("adz-00886", g_lang),"Y-Size")   #170123-00046#1 add
               LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",l_msg
               CALL l_force_strbuf.append(l_msg)
               CALL l_force_strbuf.append("\r\n")
               LET g_force_err=g_force_err+1 #強制訊息                                
            END IF
            #160629-00012#1-2 add(e)
            ##檢查尾頁是否隱藏PageFooter
            IF l_curnode.getAttribute("hidePageFooterOnLastPage") IS NULL AND 
               l_curnode.getAttribute("hidePageFooterOnLastPage") ="false" THEN
#               LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ",l_nodeName ," HidePageFooterOnLastPage ",cl_getmsg("adz-00443",p_lang) CLIPPED,"(PageRoot)"   #170123-00046#1 mark
               LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",l_nodeName ," HidePageFooterOnLastPage ",cl_getmsg("adz-00443",g_lang) CLIPPED,"(PageRoot)"    #170123-00046#1 add
               IF l_msg IS NOT NULL THEN
                  CALL l_force_strbuf.append(l_msg)
                  CALL l_force_strbuf.append("\r\n")
               END IF  
               LET g_force_err=g_force_err+1 #強制訊息                    
            END IF    
         END IF   #IF  l_curnode.getAttribute("name")="Page Root"
         ###檢查PageRoot相關規則(e)
            
         ###檢查PageHeaders相關規則(s)
         IF  l_curnode.getAttribute("name")="PageHeaders" THEN 
            ##檢查尾頁是否隱藏PageFooter
            IF l_curnode.getAttribute("port") <> "anyPageHeader" THEN
#               LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ",l_nodeName," anyPageHeader ",cl_getmsg("adz-00443",p_lang) CLIPPED,"(PageHeaders)"   #170123-00046#1 mark
               LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",l_nodeName," anyPageHeader ",cl_getmsg("adz-00443",g_lang) CLIPPED,"(PageHeaders)"    #170123-00046#1 add
               IF l_msg IS NOT NULL THEN
                  CALL l_force_strbuf.append(l_msg)
                  CALL l_force_strbuf.append("\r\n")
               END IF  
               LET g_force_err=g_force_err+1 #強制訊息                    
            END IF    
         END IF   #IF  l_curnode.getAttribute("name")="Page Root"
         ###檢查PageHeaders相關規則(e)

         ###檢查ReportHeaders相關規則(s)
         IF  l_curnode.getAttribute("name")="ReportHeaders" THEN 
            ##檢查尾頁是否隱藏PageFooter
            IF l_curnode.getAttribute("port") <> "firstPageHeader" THEN
#               LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ",l_nodeName ," firstPageHeader ",cl_getmsg("adz-00443",p_lang) CLIPPED,"(ReportHeaders)"   #170123-00046#1 mark
               LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",l_nodeName ," firstPageHeader ",cl_getmsg("adz-00443",g_lang) CLIPPED,"(ReportHeaders)"    #170123-00046#1 add
               IF l_msg IS NOT NULL THEN
                  CALL l_force_strbuf.append(l_msg)
                  CALL l_force_strbuf.append("\r\n")
               END IF  
               LET g_force_err=g_force_err+1 #強制訊息                    
            END IF    
         END IF   #IF  l_curnode.getAttribute("name")="Page Root"
         ###檢查ReportHeaders相關規則(e)
         
         ###檢查detail子節點欄位是否有設定右邊界為0.1cm(s)
         IF p_tagname="MINIPAGE" THEN                         
            IF  l_parname.subString("Detail",1) AND (NOT l_parname.equals("Details")) THEN 
               IF l_curnode.getAttribute("marginRightWidth") <> "0.1cm" THEN
                  #LET l_msg=l_nodeName ,"單身的欄位右邊界設定錯誤，應為0.1cm (Margin->Right Width->0.1cm)" 
#                  LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodeName," ",cl_getmsg("adz-00435",p_lang)," (Margin->Right Width->0.1cm)"   #170123-00046#1 mark
                  LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodeName," ",cl_getmsg("adz-00435",g_lang)," (Margin->Right Width->0.1cm)"    #170123-00046#1 add
                  IF l_msg IS NOT NULL THEN
                     CALL l_set_strbuf.append(l_msg)
                     CALL l_set_strbuf.append("\r\n")
                  END IF            
               END IF 
            END IF 

            IF  l_parname.subString("PHMaster",1) AND (NOT l_parname.equals("PHMasters")) THEN 
               IF l_curnode.getAttribute("marginRightWidth") <> "0.1cm" THEN
                  #LET l_msg=l_nodeName ,"單頭的欄位右邊界設定錯誤，應為0.1cm (Margin->Right Width->0.1cm)" 
#                  LET l_msg=cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ",l_nodeName," ",cl_getmsg("adz-00435",p_lang)," (Margin->Right Width->0.1cm)"   #170123-00046#1 mark
                  LET l_msg=cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",l_nodeName," ",cl_getmsg("adz-00435",g_lang)," (Margin->Right Width->0.1cm)"    #170123-00046#1 add
                  IF l_msg IS NOT NULL THEN
                     CALL l_set_strbuf.append(l_msg)
                     CALL l_set_strbuf.append("\r\n")
                  END IF            
               END IF 
            END IF             

            IF  l_parname.subString("RHMaster",1) AND (NOT l_parname.equals("RHMasters")) THEN 
               IF l_curnode.getAttribute("marginRightWidth") <> "0.1cm" THEN
                  #LET l_msg=l_nodeName ,"單頭的欄位右邊界設定錯誤，應為0.1cm (Margin->Right Width->0.1cm)" 
#                  LET l_msg=cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ",l_nodeName," ",cl_getmsg("adz-00435",p_lang)," (Margin->Right Width->0.1cm)"   #170123-00046#1 mark
                  LET l_msg=cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ",l_nodeName," ",cl_getmsg("adz-00435",g_lang)," (Margin->Right Width->0.1cm)"    #170123-00046#1 add
                  IF l_msg IS NOT NULL THEN
                     CALL l_set_strbuf.append(l_msg)
                     CALL l_set_strbuf.append("\r\n")
                  END IF            
               END IF 
            END IF                       
         END IF 
         ###檢查detail子節點欄位是否有設定右邊界為0.1cm(e)

         ###檢查需照流水號編號的規則(s)
         IF l_curnode.getTagName() = "LAYOUTNODE" OR l_curnode.getTagName() = "MINIPAGE"THEN  
            CALL  l_chi_node.clear()
            LET l_chi_i=0
            FOR  l_ii=1 TO l_curnode.getChildCount()
               LET l_childnode=l_curnode.getChildByIndex(l_ii)
               LET l_childname= l_childnode.getAttribute("name")
               LET l_childtag=l_childnode.getTagName()
               IF l_childtag="MINIPAGE" AND l_childname.getIndexOf("subrep",1)=0 THEN  
                  LET l_chi_i=l_chi_i+1
                  LET l_chi_node[l_chi_i]=l_childnode
               END IF                       
            END FOR 
            FOR l_ii=1 TO l_chi_node.getLength()    
               LET l_find_str=l_nodename    #父節點name屬性的內容
               IF l_find_str="RHMasters" THEN LET l_find_str="PHMasters"  END IF #規則相同
               IF l_find_str="RHMasterAs" THEN LET l_find_str="PHMasterAs"  END IF #規則相同
               IF l_find_str="RHDetailHeaders" THEN LET l_find_str="PHDetailHeaders"  END IF #規則相同
               
               LET l_find_str=l_find_str.subString(1,l_find_str.getLength()-1),l_ii USING "&&"
               LET l_childname= l_chi_node[l_ii].getAttribute("name")
               CASE l_nodename             
                  WHEN "PHDetailHeaders" #單身欄位說明各行Stripe物件名稱為PHDetailHeader01~99，上層節點為PHDetailHeaders (LayoutNode)             
                     IF NOT l_childname.equals(l_find_str) THEN #找name搭上流水號是否正確                                             
                        #LET l_msg="(強制)", l_childname ,"不應該出現此行或命名錯誤" 
#                        LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", l_childname," ",cl_getmsg("adz-00436",p_lang) CLIPPED   #170123-00046#1 mark
                        LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ", l_childname," ",cl_getmsg("adz-00436",g_lang) CLIPPED    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_force_strbuf.append(l_msg)
                           CALL l_force_strbuf.append("\r\n")
                        END IF 
                        LET g_force_err=g_force_err+1 #強制訊息                           
                     END IF
                  WHEN "Details"  #單身各行物件名稱為 Detail01~99 (Stripe)， 上層節點為 Details (LayoutNode)
                     #IF NOT l_childname.equals(l_find_str) THEN #找name搭上流水號是否正確 
                     IF NOT l_childname.equals(l_find_str) THEN#OR NOT l_childname.equals("subrep02") OR NOT l_childname.equals("subrep03") THEN #找name搭上流水號是否正確 
                        #LET l_msg="(強制)", l_childname ,"不應該出現於",l_ii,"行, 或命名錯誤" 
#                        LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", l_childname," ",cl_getmsg("adz-00436",p_lang) CLIPPED,"(",l_ii,")"   #170123-00046#1 mark
                        LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ", l_childname," ",cl_getmsg("adz-00436",g_lang) CLIPPED,"(",l_ii,")"    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_force_strbuf.append(l_msg)
                           CALL l_force_strbuf.append("\r\n")
                        END IF  
                        LET g_force_err=g_force_err+1 #強制訊息                           
                     END IF
                  WHEN "PHMasters"  #單頭各行 Stripe物件名稱為PHMaster01~99
                     IF l_childname.getIndexOf("PHMasterC",1)=0 THEN
                        IF NOT l_childname.equals(l_find_str) THEN #找name搭上流水號是否正確 
                           #LET l_msg="(強制)", l_childname ,"不應該出現於",l_ii,"行, 或命名錯誤" 
#                           LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", l_childname," ",cl_getmsg("adz-00436",p_lang) CLIPPED,"(",l_ii,")"   #170123-00046#1 mark 
                           LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ", l_childname," ",cl_getmsg("adz-00436",g_lang) CLIPPED,"(",l_ii,")"    #170123-00046#1 add
                           IF l_msg IS NOT NULL THEN
                              CALL l_force_strbuf.append(l_msg)
                              CALL l_force_strbuf.append("\r\n")
                           END IF 
                           LET g_force_err=g_force_err+1 #強制訊息
                        ELSE
                           #第二層單頭容器
                           CALL l_grandchi_node.clear()
                           LET l_grandchi_i=0
                           FOR  l_iii=1 TO l_chi_node[l_ii].getChildCount()
                              LET l_grandchildnode= l_chi_node[l_ii].getChildByIndex(l_iii)
                              LET l_grandchildname= l_grandchildnode.getAttribute("name")
                              LET l_grandchildtag= l_grandchildnode.getTagName()
                              IF l_grandchildtag="MINIPAGE" THEN  
                                 LET l_grandchi_i=l_grandchi_i+1
                                 LET l_grandchi_node[l_grandchi_i]=l_grandchildnode
                              END IF
                           END FOR 
#                           LET l_find_chi_str=l_childname    #子節點name屬性的內容
#                           LET l_find_chi_str=l_find_chi_str,"_",l_iii USING "&&"
#                           LET l_grandchildname= l_grandchi_node[l_iii].getAttribute("name")

                           FOR l_iii=1 TO l_grandchi_i
                              LET l_find_chi_str=l_childname    #子節點name屬性的內容
                              LET l_find_chi_str=l_find_chi_str,"_",l_iii USING "&&"
                              LET l_grandchildname= l_grandchi_node[l_iii].getAttribute("name")
                           
                              IF NOT l_grandchildname.equals(l_find_chi_str) THEN
#                                 LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", l_grandchildname," ",cl_getmsg("adz-00436",p_lang) CLIPPED,"(",l_iii,")"   #170123-00046#1 mark
                                 LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ", l_grandchildname," ",cl_getmsg("adz-00436",g_lang) CLIPPED,"(",l_iii,")"    #170123-00046#1 add
                                 IF l_msg IS NOT NULL THEN
                                    CALL l_force_strbuf.append(l_msg)
                                    CALL l_force_strbuf.append("\r\n")
                                 END IF 
                                 LET g_force_err=g_force_err+1 #強制訊息
                              END IF
                           END FOR
                        END IF
                     END IF   
                  WHEN "PHMasterAs"  #單頭各行 Stripe物件名稱為PHMaster01~99
                     IF NOT l_childname.equals(l_find_str) THEN #找name搭上流水號是否正確 
                        #LET l_msg="(強制)", l_childname ,"不應該出現於",l_ii,"行, 或命名錯誤" 
#                        LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", l_childname," ",cl_getmsg("adz-00436",p_lang) CLIPPED,"(",l_ii,")"   #170123-00046#1 mark
                        LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ", l_childname," ",cl_getmsg("adz-00436",g_lang) CLIPPED,"(",l_ii,")"    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_force_strbuf.append(l_msg)
                           CALL l_force_strbuf.append("\r\n")
                        END IF 
                        LET g_force_err=g_force_err+1 #強制訊息
                     END IF             
                  WHEN "PageFooters"  ##頁尾欄位各行命名為PageFooter01，PageFooter02…，依行序編號即可
                     IF NOT l_childname.equals(l_find_str) THEN
                        #LET l_msg="(強制)", l_childname ,"不應該出現於",l_ii,"行, 或命名錯誤" 
#                        LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", l_childname," ",cl_getmsg("adz-00436",p_lang) CLIPPED,"(",l_ii,")"   #170123-00046#1 mark
                        LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,g_gzgd007," ", l_childname," ",cl_getmsg("adz-00436",g_lang) CLIPPED,"(",l_ii,")"    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_force_strbuf.append(l_msg)
                           CALL l_force_strbuf.append("\r\n")
                        END IF 
                        LET g_force_err=g_force_err+1 #強制訊息                           
                     END IF 
                  #WHEN "ReportFooters"  #頁尾欄位各行命名為PageFooter01，PageFooter02…，依行序編號即可
                  #   IF NOT l_childname.equals(l_find_str) THEN
                  #      #LET l_msg="(強制)", l_childname ,"不應該出現於",l_ii,"行, 或命名錯誤" 
                  #      LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED, l_childname ,cl_getmsg("adz-00436",p_lang) CLIPPED,"(",l_ii,")"
                  #      IF l_msg IS NOT NULL THEN
                  #         CALL l_force_strbuf.append(l_msg)
                  #         CALL l_force_strbuf.append("\r\n")
                  #      END IF  
                  #      LET g_force_err=g_force_err+1 #強制訊息                           
                  #   END IF               
                      
                  #WHEN "PageHeaderGroups" #群組首名稱：GroupHeader_[群組欄位名稱]_[流水號兩碼]
                  #   IF NOT l_childname.equals(l_find_str) THEN
                  #      #LET l_msg="(強制)", l_childname ,"不應該出現於",l_ii,"行, 或命名錯誤" 
                  #      LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED, l_childname ,cl_getmsg("adz-00436",p_lang) CLIPPED,"(",l_ii,")"
                  #      IF l_msg IS NOT NULL THEN
                  #         CALL l_force_strbuf.append(l_msg)
                  #         CALL l_force_strbuf.append("\r\n")
                  #      END IF 
                  #      LET g_force_err=g_force_err+1 #強制訊息                           
                  #   END IF 
                  #先不用檢查--------start
                  #OTHERWISE      # 群組尾名稱：GroupFooter_[群組欄位名稱]_[流水號兩碼] or 群組首GroupHeader_[群組欄位名稱]_[流水號兩碼]                     
                  #   LET l_find_str=l_parent.getAttribute("name"),"_",l_i USING "&&"     #父節點name屬性的內容             
                  #   IF l_nodeName.getIndexOf("l_find_str",1) <0 THEN
                  #      LET l_msg=l_nodeName ,cl_getmsg("adz-00436",p_lang) CLIPPED,"(",l_ii,")"
                  #      IF l_msg IS NOT NULL THEN
                  #         CALL l_force_strbuf.append(l_msg)
                  #         CALL l_force_strbuf.append("\r\n")
                  #      END IF 
                  #      LET g_force_err=g_force_err+1 #強制訊息                           
                  #   END IF 
                  #先不用檢查--------end 
               END CASE
            END FOR 
         END IF  # l_curnode.getTagName() = "LAYOUTNODE"
         ###檢查需照流水號編號的規則(e)

         ###160921-00027#1 mark(s)
         #為提升開發效能,不再控卡單位
         ###欄位若設定X-Size, Y-Size, X, Y數字，則單位必用cm(必小寫)。0 視同於0 cm。也可設定非數字，ex: max, min, rest(s)
#         IF  p_tagname <>"MINIPAGE" OR p_tagname<> "LAYOUTNODE" THEN 
#            IF l_nodename.getIndexOf("ReporterPF",1)=0 AND l_nodename.getIndexOf("PageNoPF",1)=0 AND 
#               l_nodename.getIndexOf("ReporterRF",1)=0 AND l_nodename.getIndexOf("ReporterRF",1)=0 AND 
#               l_nodename.getIndexOf("logoPH",1)=0 AND l_nodename.getIndexOf("logoRH",1)=0 AND 
#               l_nodename.getIndexOf("apr_str",1)=0 THEN  
#               CALL l_cur_size.clear()
#               #因為會有max-5cm這類的值，所以不檢查x及y欄位
#               CALL l_cur_size.appendElement()
#               LET l_cur_size[l_cur_size.getLength()]= l_curnode.getAttribute("width")
#               CALL l_cur_size.appendElement()
#               LET l_cur_size[l_cur_size.getLength()]= l_curnode.getAttribute("length")  
#               CALL l_cur_size.deleteElement(l_cur_size.getLength())
#               FOR l_cnt=1 TO l_cur_size.getLength()
#                  IF l_cur_size[l_cnt] IS NOT NULL THEN 
#                     IF l_cur_size[l_cnt].getIndexOf("cm",1)>0 THEN 
#                        LET l_cur_value=cl_replace_str(l_cur_size[l_cnt],"cm","") #若轉出是max-5 要判斷掉           
#                        IF l_cur_value IS NULL  THEN #l_cur_size截掉cm不是純數字
#                           #LET l_msg="設定",l_curnode.getAttribute("name"),"格式設定應為 0.5cm, max 或 min"
#                           LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",cl_getmsg("adz-00437",p_lang) CLIPPED," ",l_curnode.getAttribute("name")," ",cl_getmsg("adz-00444",p_lang) CLIPPED,"0.5cm, max, min"
#                           IF l_msg IS NOT NULL THEN
#                              CALL l_set_strbuf.append(l_msg)
#                              CALL l_set_strbuf.append("\r\n")
#                           END IF                                  
#                        END IF                
#                     ELSE 
#                        IF l_cur_size[l_cnt].equalsIgnoreCase("max") =0 AND
#                           l_cur_size[l_cnt].equalsIgnoreCase("{max}") =0 AND 
#                           l_cur_size[l_cnt].equalsIgnoreCase("min") =0 AND 
#                           l_cur_size[l_cnt].equalsIgnoreCase("{min}") =0 AND
#                           l_cur_size[l_cnt].equalsIgnoreCase("rest") =0 AND  
#                           l_cur_size[l_cnt].equalsIgnoreCase("{rest}") =0 THEN 
#                           #LET l_msg="設定",l_curnode.getAttribute("name"),"定位單位",l_cur_size[l_cnt],"必須為cm"
#                           LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_curnode.getAttribute("name")," ",cl_getmsg("adz-00445",p_lang) CLIPPED," ",l_cur_size[l_cnt],cl_getmsg("adz-00446",p_lang) CLIPPED,"cm"
#                           IF l_msg IS NOT NULL THEN
#                              CALL l_set_strbuf.append(l_msg)
#                              CALL l_set_strbuf.append("\r\n")
#                           END IF   
#                        END IF #max' min'rest
#                     END IF #l_cur_size[l_cnt].getIndexOf("cm",1)>0
#                  END IF  #l_cur_size[l_cnt] IS NOT NULL
#               END FOR  #l_cnt=1 TO l_cur_size.getLength()             
#            END IF #l_nodename.getIndexOf("PageFooterStatus",1)=0 AND l_nodename.getIndexOf("Reporter",1)=0 AND 
#                   # l_nodename.getIndexOf("ReportFooterStatus",1)=0 AND l_nodename.getIndexOf("PageNo",1)
#         END IF  #p_tagname <>"MINIPAGE" AND p_tagname<> "LAYOUTNODE" 
         ###欄位若設定X-Size, Y-Size, X, Y數字，則單位必用cm(必小寫)。0 視同於0 cm。也可設定非數字，ex: max, min, rest(e)
         ###160921-00027#1 mark(e)          
           
         ###所有欄位的縱向高度都不必設定,寬度一定要設， imageBox,title例外, 容器一定要設寬跟高(s)
         LET l_set_length =l_curnode.getAttribute("length")
         LET l_set_width =l_curnode.getAttribute("width")
         IF p_tagname="MINIPAGE" OR p_tagname="LAYOUTNODE" THEN   #容器一定要設寬跟高
            ##Layout Node 與 Mini Page 的 X-Size 跟 Y-Size 一定要存在，但不檢查設定值
            IF l_set_length IS NULL OR l_set_length.getLength()=0 THEN
#               LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00447",p_lang) CLIPPED,"Y-Size"   #170123-00046#1 mark
               LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00447",g_lang) CLIPPED,"Y-Size"    #170123-00046#1 add
               IF l_msg IS NOT NULL THEN
                  CALL l_set_strbuf.append(l_msg)
                  CALL l_set_strbuf.append("\r\n")
               END IF                     
            END IF
            IF l_set_width IS NULL OR l_set_width.getLength()=0 THEN
#               LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00447",p_lang) CLIPPED,"X-Size"   #170123-00046#1 mark
               LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00447",g_lang) CLIPPED,"X-Size"    #170123-00046#1 add
               IF l_msg IS NOT NULL THEN
                  CALL l_set_strbuf.append(l_msg)
                  CALL l_set_strbuf.append("\r\n")
               END IF                     
            END IF               
         ELSE #非容器類 縱向高度都不必設定,寬度一定要設
            IF l_set_length IS NOT NULL AND l_nodename.getIndexOf("title",1)=0 AND l_nodename.getIndexOf("sign_img",1)=0 AND l_nodename.getIndexOf("sr2.ooff013_Label",1)=0 THEN
#               LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00448",p_lang) CLIPPED,"Y-Size"   #170123-00046#1 mark
               LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00448",g_lang) CLIPPED,"Y-Size"    #170123-00046#1 add
               IF l_msg IS NOT NULL THEN
                  CALL l_set_strbuf.append(l_msg)
                  CALL l_set_strbuf.append("\r\n")
               END IF                     
            END IF   
               
            IF p_tagname="IMAGEBOX"  THEN   #IMAGEBOX是例外，先檢查不能設寬高
               IF l_set_width IS NOT NULL AND l_nodename.getIndexOf("sign_img",1)=0 THEN
#                  LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00448",p_lang) CLIPPED,"X-Size"   #170123-00046#1 mark
                  LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00448",g_lang) CLIPPED,"X-Size"    #170123-00046#1 add
                  IF l_msg IS NOT NULL THEN
                     CALL l_set_strbuf.append(l_msg)
                     CALL l_set_strbuf.append("\r\n")
                  END IF                     
               END IF                    
            ELSE
               IF l_set_width IS NULL AND p_tagname<>"TABLE" THEN
#                  LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00447",p_lang) CLIPPED,"X-Size"   #170123-00046#1 mark
                  LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00447",g_lang) CLIPPED,"X-Size"    #170123-00046#1 add
                  IF l_msg IS NOT NULL THEN
                     CALL l_set_strbuf.append(l_msg)
                     CALL l_set_strbuf.append("\r\n")
                  END IF                     
               END IF                 
            END IF      
         END IF 
         ###所有欄位的縱向高度都不必設定,寬度一定要設， imageBox例外, 容器一定要設寬跟高(e)
 
         ### 分隔線檢查(s)
         #IF p_tagname="MINIPAGE" THEN#or p_tagname="LAYOUTNODE"
         IF p_tagname="MINIPAGE" OR p_tagname="LAYOUTNODE" THEN           ## 表單中共有6條分隔線：
            ## 1. PHMasters 或 RHMasters 設 borderTopWidth (1)
            ## 2. PHDetailHeaders 或 RHDetailHeaders 設 borderTopWidth (1),borderBottomWidth(0.5)
            ## 3. Details 設 borderBottomWidth(0.5)(dashed)
            ## 4. PageFooter02 或 ReportFooter02 設 borderTopWidth (1),borderBottomWidth(0.5)
                
            IF l_curnode.getAttribute("name") IS NOT NULL THEN
               LET l_BORDERWIDTH_T=1 #寬度1
               LET l_BORDERWIDTH_B=0.5 #寬度0.5
               LET l_borderStyle="solid"
               LET l_borderStyle_D="dashed"                   
               LET l_bottonwidth=l_curnode.getAttribute("borderBottomWidth")
               LET l_topwidth=l_curnode.getAttribute("borderTopWidth")
               LET l_toppadding=l_curnode.getAttribute("paddingTopWidth")
               LET l_bordertopstyle=l_curnode.getAttribute("borderTopStyle")
               LET l_borderbottonstyle=l_curnode.getAttribute("borderBottomStyle")
                   
               #第1條線 #
               IF l_nodename.getIndexOf("PHMasters",1)>0 OR l_nodename.getIndexOf("RHMasters",1)>0 THEN    
                  IF l_topwidth IS NULL THEN
                     #區段頂端須有一條分隔線
#                     LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00439",p_lang) CLIPPED   #170123-00046#1 mark
                     LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00439",g_lang) CLIPPED    #170123-00046#1 add
                     IF l_msg IS NOT NULL THEN
                        CALL l_set_strbuf.append(l_msg)
                        CALL l_set_strbuf.append("\r\n")
                     END IF                            
                  ELSE 
                     IF l_topwidth <> l_BORDERWIDTH_T THEN
                        #線條寬度應為1
#                        LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename,cl_getmsg("adz-00440",p_lang) CLIPPED,"1"   #170123-00046#1 mark
                        LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename,cl_getmsg("adz-00440",g_lang) CLIPPED,"1"    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_set_strbuf.append(l_msg)
                           CALL l_set_strbuf.append("\r\n")
                        END IF                              
                     END IF 
                  END IF 

                  IF l_bordertopstyle IS NOT NULL THEN
                     IF l_bordertopstyle <> l_borderStyle THEN
                        #borderBottomStyle應為solid
#                        LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," borderBottomStyle",cl_getmsg("adz-00446",p_lang) CLIPPED,l_borderStyle   #170123-00046#1 mark
                        LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," borderBottomStyle",cl_getmsg("adz-00446",g_lang) CLIPPED,l_borderStyle    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_set_strbuf.append(l_msg)
                           CALL l_set_strbuf.append("\r\n")
                        END IF                             
                     END IF 
                  END IF #l_bordertopstyle IS NOT NULL
                  IF l_borderbottonstyle IS NOT NULL THEN
                     IF l_borderbottonstyle <> l_borderStyle THEN
                        #l_borderbottonstyle應為solid
#                        LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," borderbottonstyle",cl_getmsg("adz-00446",p_lang) CLIPPED,l_borderStyle   #170123-00046#1 mark
                        LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," borderbottonstyle",cl_getmsg("adz-00446",g_lang) CLIPPED,l_borderStyle    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_set_strbuf.append(l_msg)
                           CALL l_set_strbuf.append("\r\n")
                        END IF                             
                     END IF 
                  END IF #l_borderbottonstyle IS NOT NULL
               END IF  #l_nodename.getIndexOf("PHMasters",1)>0

               #第2,3,5,6條線
               IF l_nodename.getIndexOf("PHDetailHeaders",1)>0 OR l_nodename.getIndexOf("RHDetailHeaders",1)>0 OR 
                  l_nodename.getIndexOf("PageFooter02",1)>0 OR l_nodename.getIndexOf("ReportFooter02",1)>0 THEN                                        
                  IF l_topwidth IS NULL THEN
                     #區段頂端須有一條分隔線
#                     LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00439",p_lang) CLIPPED   #170123-00046#1 mark
                     LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00439",g_lang) CLIPPED    #170123-00046#1 add
                     IF l_msg IS NOT NULL THEN
                        CALL l_set_strbuf.append(l_msg)
                        CALL l_set_strbuf.append("\r\n")
                     END IF
                  ELSE 
                     IF l_topwidth <> l_BORDERWIDTH_T THEN
                        #線條寬度應為1
#                        LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00440",p_lang) CLIPPED,"1"   #170123-00046#1 mark
                        LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00440",g_lang) CLIPPED,"1"    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_set_strbuf.append(l_msg)
                           CALL l_set_strbuf.append("\r\n")
                        END IF
                     END IF 
                  END IF 
                  IF l_bottonwidth IS NULL THEN
                     #區段底部須有一條分隔線
#                     LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00438",p_lang) CLIPPED   #170123-00046#1 mark
                     LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00438",g_lang) CLIPPED    #170123-00046#1 add
                     IF l_msg IS NOT NULL THEN
                        CALL l_set_strbuf.append(l_msg)
                        CALL l_set_strbuf.append("\r\n")
                     END IF
                  ELSE 
                     IF l_bottonwidth <> l_BORDERWIDTH_B THEN
                        #線條寬度應為0.5
#                        LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00440",p_lang) CLIPPED,"0.5"   #170123-00046#1 mark
                        LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00440",g_lang) CLIPPED,"0.5"    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_set_strbuf.append(l_msg)
                           CALL l_set_strbuf.append("\r\n")
                        END IF
                     END IF 
                  END IF 
                  
                  IF l_bordertopstyle IS NOT NULL THEN
                     IF l_bordertopstyle <> l_borderStyle THEN
                        #borderBottomStyle應為solid
#                        LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," borderBottomStyle",cl_getmsg("adz-00446",p_lang) CLIPPED,l_borderStyle   #170123-00046#1 mark
                        LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," borderBottomStyle",cl_getmsg("adz-00446",g_lang) CLIPPED,l_borderStyle    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_set_strbuf.append(l_msg)
                           CALL l_set_strbuf.append("\r\n")
                        END IF
                     END IF 
                  END IF #l_bordertopstyle IS NOT NULL
                  IF l_borderbottonstyle IS NOT NULL THEN
                     IF l_borderbottonstyle <> l_borderStyle THEN
                        #l_borderbottonstyle應為solid
#                        LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," borderbottonstyle",cl_getmsg("adz-00446",p_lang) CLIPPED,l_borderStyle   #170123-00046#1 mark
                        LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," borderbottonstyle",cl_getmsg("adz-00446",g_lang) CLIPPED,l_borderStyle    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_set_strbuf.append(l_msg)
                           CALL l_set_strbuf.append("\r\n")
                        END IF
                     END IF 
                  END IF #l_borderbottonstyle IS NOT NULL
               END IF    #l_parent.getAttribute("name")="PHDetailHeaders"
                   
               #第4條線 #
               IF l_nodename.getIndexOf("Details",1)>0 AND p_gzgd007.getIndexOf("subrep",1)=0 THEN 
                  IF p_tagname <> "MINIPAGE" THEN
                     #Details容器是MINIPAGE
#                     LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00438",p_lang) CLIPPED   #170123-00046#1 mark
                     LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00438",g_lang) CLIPPED    #170123-00046#1 add
                     IF l_msg IS NOT NULL THEN
                        CALL l_set_strbuf.append(l_msg)
                        CALL l_set_strbuf.append("\r\n")
                     END IF                     
                  END IF
                  IF l_bottonwidth IS NULL THEN
                     #區段底部須有一條分隔線
#                     LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00438",p_lang) CLIPPED   #170123-00046#1 mark
                     LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00438",g_lang) CLIPPED    #170123-00046#1 add
                     IF l_msg IS NOT NULL THEN
                        CALL l_set_strbuf.append(l_msg)
                        CALL l_set_strbuf.append("\r\n")
                     END IF
                  ELSE 
                     IF l_bottonwidth <> l_BORDERWIDTH_B THEN
                        #線條寬度應為1
#                        LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00440",p_lang) CLIPPED,"0.5"   #170123-00046#1 mark
                        LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00440",g_lang) CLIPPED,"0.5"    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_set_strbuf.append(l_msg)
                           CALL l_set_strbuf.append("\r\n")
                        END IF
                     END IF
                  END IF

                  IF l_borderbottonstyle IS NOT NULL THEN
                     IF l_borderbottonstyle <> l_borderStyle_D THEN
                        #l_borderbottonstyle應為dashed
#                        LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," borderbottonstyle",cl_getmsg("adz-00446",p_lang) CLIPPED,l_borderStyle_D   #170123-00046#1 mark
                        LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," borderbottonstyle",cl_getmsg("adz-00446",g_lang) CLIPPED,l_borderStyle_D    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_set_strbuf.append(l_msg)
                           CALL l_set_strbuf.append("\r\n")
                        END IF
                     END IF 
                  END IF #l_borderbottonstyle IS NOT NULL
               END IF  #l_nodename.getIndexOf("Details",1)>0
            END IF  #
         END IF
         ### 分隔線檢查(e)

         ### 排版留白(s)
         IF p_tagname="MINIPAGE" OR p_tagname="LAYOUTNODE" THEN
            ## 1. PHMasters 或 RHMasters
            ## 2. PHDetailHeaders 或 PHDetailHeaders
            ## 3. DetailHeaders
                
            IF l_curnode.getAttribute("name") IS NOT NULL THEN
               LET l_PADDINGWIDTH="0.2cm" #留白0.2cm
                   
               IF (l_nodename.getIndexOf("PHMasters",1)>0 OR l_nodename.getIndexOf("RHMasters",1)>0 ) 
                  AND p_gzgd007.getIndexOf("subrep",1)=0 THEN    
                  LET l_paddingTopWidth=l_curnode.getAttribute("paddingTopWidth")
                  
                  IF l_paddingTopWidth IS NULL THEN
                     #區段頂端須有0.2cm的留白
#                     LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00449",p_lang) CLIPPED   #170123-00046#1 mark
                     LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00449",g_lang) CLIPPED    #170123-00046#1 add
                     IF l_msg IS NOT NULL THEN
                        CALL l_set_strbuf.append(l_msg)
                        CALL l_set_strbuf.append("\r\n")
                     END IF                            
                  ELSE 
                     IF l_paddingTopWidth <> "0.2cm" THEN
                        #留白應為0.2cm
#                        LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00450",p_lang) CLIPPED   #170123-00046#1 mark
                        LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00450",g_lang) CLIPPED    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_set_strbuf.append(l_msg)
                           CALL l_set_strbuf.append("\r\n")
                        END IF                              
                     END IF 
                  END IF 
               END IF  #l_nodename.getIndexOf("PHMasters",1)>0

               #IF (l_nodename.getIndexOf("PHDetailHeaders",1)>0 OR l_nodename.getIndexOf("RHDetailHeaders",1)>0 OR l_nodename.getIndexOf("DetailHeaders",1)>0) 
               IF l_nodename.getIndexOf("DetailHeaders",1)>0 AND p_gzgd007.getIndexOf("subrep",1)=0 THEN    
                  LET l_paddingTopWidth=l_curnode.getAttribute("marginTopWidth")
                  
                  IF l_paddingTopWidth IS NULL THEN
                     #區段頂端須有0.2cm的留白
#                     LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00449",p_lang) CLIPPED   #170123-00046#1 mark
                     LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00449",g_lang) CLIPPED    #170123-00046#1 add
                     IF l_msg IS NOT NULL THEN
                        CALL l_set_strbuf.append(l_msg)
                        CALL l_set_strbuf.append("\r\n")
                     END IF                            
                  ELSE 
                     IF l_paddingTopWidth <> "0.2cm" THEN
                        #留白應為0.2cm
#                        LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00450",p_lang) CLIPPED   #170123-00046#1 mark
                        LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00450",g_lang) CLIPPED    #170123-00046#1 add
                        IF l_msg IS NOT NULL THEN
                           CALL l_set_strbuf.append(l_msg)
                           CALL l_set_strbuf.append("\r\n")
                        END IF                              
                     END IF 
                  END IF 
               END IF  #l_nodename.getIndexOf("PHMasters",1)>0               
            END IF  #
         END IF
         ### 排版留白(e)
         
         ###欄位顯示的內容有文字，在欄位屬性不需勾選Fidelity，否則匯出的檔案大小會增加(s)
         IF p_tagname="WORDWRAPBOX" OR p_tagname="WORDBOX" OR 
            p_tagname="PAGENOBOX" OR p_tagname="IMAGEBOX" OR 
            p_tagname="HTMLBOX" OR p_tagname="DECIMALFORMATBOX" THEN #150506 數值格式不檢查mark #151026-00010#1 remark
#            p_tagname="HTMLBOX" THEN #150506 數值格式不檢查 add #151026-00010#1 mark
            IF l_curnode.getAttribute("fidelity")="true" THEN
#               LET l_msg=cl_getmsg("adz-00408",p_lang) CLIPPED, p_gzgd007," ",l_curnode.getAttribute("name")," ",cl_getmsg("adz-00451",p_lang) CLIPPED   #151026-00010#1 mark
#               LET l_msg=cl_getmsg("adz-00721",p_lang) CLIPPED, p_gzgd007," ",l_curnode.getAttribute("name")," ",cl_getmsg("adz-00451",p_lang) CLIPPED   #151026-00010#1 add   #170123-00046#1 mark
               LET l_msg=cl_getmsg("adz-00721",g_lang) CLIPPED, p_gzgd007," ",l_curnode.getAttribute("name")," ",cl_getmsg("adz-00451",g_lang) CLIPPED                          #170123-00046#1 add
               IF l_msg IS NOT NULL THEN
#                  CALL l_force_strbuf.append(l_msg)   #151026-00010#1 mark
#                  CALL l_force_strbuf.append("\r\n")   #151026-00010#1 mark
                  CALL l_fid_strbuf.append(l_msg)   #151026-00010#1 add
                  CALL l_fid_strbuf.append("\r\n")   #151026-00010#1 add
               END IF  
               #LET g_force_err=g_force_err+1 #強制訊息   #151026-00010#1 mark               
            END IF              
         END IF 
         ###欄位顯示的內容有文字，在欄位屬性不需勾選Fidelity，否則匯出的檔案大小會增加(e)

         ###Title以外內容的字型大小皆為10
         IF p_tagname="WORDWRAPBOX" OR p_tagname="WORDBOX" OR 
            p_tagname="PAGENOBOX" OR p_tagname="HTMLBOX" OR 
            p_tagname="DECIMALFORMATBOX" THEN
            LET l_font_size=l_curnode.getAttribute("fontSize")   
            IF l_nodename.getIndexOf("title",1)=0 THEN
               IF l_font_size<>"10" THEN
#                  LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00441",p_lang) CLIPPED   #170123-00046#1 mark
                  LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00441",g_lang) CLIPPED    #170123-00046#1 add
                  IF l_msg IS NOT NULL THEN
                     CALL l_set_strbuf.append(l_msg)
                     CALL l_set_strbuf.append("\r\n")
                  END IF                   
               END IF 
            END IF
         END IF   
         
         ###Title以外內容的字型不為粗體
         IF p_tagname="WORDWRAPBOX" OR p_tagname="WORDBOX" OR 
            p_tagname="PAGENOBOX" OR p_tagname="HTMLBOX" OR 
            p_tagname="DECIMALFORMATBOX" THEN
            IF l_nodename.getIndexOf("title",1)=0 THEN
               IF l_curnode.getAttribute("fontBold")="true" THEN
#                  LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00452",p_lang) CLIPPED   #170123-00046#1 mark
                  LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00452",g_lang) CLIPPED    #170123-00046#1 add
                  IF l_msg IS NOT NULL THEN
                     CALL l_set_strbuf.append(l_msg)
                     CALL l_set_strbuf.append("\r\n")
                  END IF                   
               END IF 
            END IF
         END IF   

         ##MiniPage下元件若為欄位，name一定要設為"_Value"、"_Label"、"_LValue" (s)
         #IF l_parent.getAttribute("name")="MINIPAGE" AND 
         IF 
            (p_tagname="WORDWRAPBOX" OR p_tagname="WORDBOX" OR 
             p_tagname="PAGENOBOX" OR #p_tagname="IMAGEBOX" OR 
             p_tagname="HTMLBOX" OR p_tagname="DECIMALFORMATBOX") THEN           
               
            IF l_nodename.subString(l_nodename.getLength()-6+1,l_nodename.getLength()) <> "_Value" AND 
               l_nodename.subString(l_nodename.getLength()-6+1,l_nodename.getLength()) <> "_Label" AND  
               l_nodename.subString(l_nodename.getLength()-7+1,l_nodename.getLength()) <> "_Label" THEN
#               LET l_msg=cl_getmsg("adz-00408",p_lang) CLIPPED,p_gzgd007," ", l_nodename," ",cl_getmsg("adz-00453",p_lang) CLIPPED   #170123-00046#1 mark
               LET l_msg=cl_getmsg("adz-00408",g_lang) CLIPPED,p_gzgd007," ", l_nodename," ",cl_getmsg("adz-00453",g_lang) CLIPPED    #170123-00046#1 add
               IF l_msg IS NOT NULL THEN
                  CALL l_force_strbuf.append(l_msg)
                  CALL l_force_strbuf.append("\r\n")
               END IF 
               LET g_force_err=g_force_err+1 #強制訊息
            END IF 
         END IF  #
         ##MiniPage下元件若為欄位，name一定要設為"_Value"、"_Label"、"_LValue" (e)
            
         ###繁體中文的標準字型為微軟正黑體；簡體中文的標準字型為微軟雅黑(Microsoft YaHei)；其他語言別為Arial
         IF (p_tagname="WORDWRAPBOX" OR p_tagname="WORDBOX" OR 
             p_tagname="PAGENOBOX" OR p_tagname="HTMLBOX" OR 
             p_tagname="DECIMALFORMATBOX") THEN
            LET l_font = NULL
            LET l_font=l_curnode.getAttribute("fontName")
            IF FGL_GETENV("DGENV") ="s" THEN  #標準環境才檢查字型
               CASE p_lang
                  WHEN "zh_TW" #繁中       
                     IF (l_font != "微軟正黑體" AND l_font != "Microsoft JhengHei") OR cl_null(l_font) THEN                        
                        IF cl_null(l_font) THEN
                           IF l_nodename.getIndexOf("apr_str",1)=0  THEN
#                              LET l_msg=cl_getmsg("adz-00408",p_lang) CLIPPED, p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00507",p_lang) CLIPPED,cl_getmsg("azz-00700",p_lang) CLIPPED,"(Microsoft JhengHei)"   #170123-00046#1 mark
                              LET l_msg=cl_getmsg("adz-00408",g_lang) CLIPPED, p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00507",g_lang) CLIPPED,cl_getmsg("azz-00700",g_lang) CLIPPED,"(Microsoft JhengHei)"    #170123-00046#1 add
                              IF l_msg IS NOT NULL THEN
                                 CALL l_force_strbuf.append(l_msg)
                                 CALL l_force_strbuf.append("\r\n")
                              END IF   
                              LET g_force_err=g_force_err+1 #強制訊息                                  
                           END IF  
                        ELSE
#                           LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00454",p_lang) CLIPPED,cl_getmsg("azz-00700",p_lang) CLIPPED,"(Microsoft JhengHei)"   #170123-00046#1 mark
                           LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00454",g_lang) CLIPPED,cl_getmsg("azz-00700",g_lang) CLIPPED,"(Microsoft JhengHei)"    #170123-00046#1 add
                           IF l_msg IS NOT NULL THEN
                              CALL l_set_strbuf.append(l_msg)
                              CALL l_set_strbuf.append("\r\n")
                           END IF
                        END IF
                     END IF   
 
                  WHEN "zh_CN" #簡中
                     IF (l_font != "Microsoft YaHei" AND l_font != "微軟雅黑") OR cl_null(l_font) THEN                        
                        IF cl_null(l_font) THEN
                           IF l_nodename.getIndexOf("apr_str",1)=0  THEN
#                              LET l_msg=cl_getmsg("adz-00408",p_lang) CLIPPED, p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00507",p_lang) CLIPPED,cl_getmsg("azz-00701",p_lang) CLIPPED,"(Microsoft YaHei)"   #170123-00046#1 mark
                              LET l_msg=cl_getmsg("adz-00408",g_lang) CLIPPED, p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00507",g_lang) CLIPPED,cl_getmsg("azz-00701",g_lang) CLIPPED,"(Microsoft YaHei)"    #170123-00046#1 add
                              IF l_msg IS NOT NULL THEN
                                 CALL l_force_strbuf.append(l_msg)
                                 CALL l_force_strbuf.append("\r\n")
                              END IF
                              LET g_force_err=g_force_err+1 #強制訊息                               
                           END IF     
                        ELSE                        
#                           LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00454",p_lang) CLIPPED,cl_getmsg("azz-00701",p_lang) CLIPPED,"(Microsoft YaHei)"   #170123-00046#1 mark
                           LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00454",g_lang) CLIPPED,cl_getmsg("azz-00701",g_lang) CLIPPED,"(Microsoft YaHei)"    #170123-00046#1 add
                           IF l_msg IS NOT NULL THEN
                              CALL l_set_strbuf.append(l_msg)
                              CALL l_set_strbuf.append("\r\n")
                           END IF
                        END IF
                     END IF
                  OTHERWISE #其他                      
                     IF l_font !="Arial" OR cl_null(l_font) THEN 
                        IF cl_null(l_font) THEN
                           IF l_nodename.getIndexOf("apr_str",1)=0 THEN
#                              LET l_msg=cl_getmsg("adz-00408",p_lang) CLIPPED, p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00507",p_lang) CLIPPED,"Arial"   #170123-00046#1 mark
                              LET l_msg=cl_getmsg("adz-00408",g_lang) CLIPPED, p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00507",g_lang) CLIPPED,"Arial"    #170123-00046#1 add
                              IF l_msg IS NOT NULL THEN
                                 CALL l_force_strbuf.append(l_msg)
                                 CALL l_force_strbuf.append("\r\n")
                              END IF
                              LET g_force_err=g_force_err+1 #強制訊息                               
                           END IF     
                        ELSE                                             
#                           LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00454",p_lang) CLIPPED,"Arial"   #170123-00046#1 mark
                           LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00454",g_lang) CLIPPED,"Arial"    #170123-00046#1 add
                           IF l_msg IS NOT NULL THEN
                              CALL l_set_strbuf.append(l_msg)
                              CALL l_set_strbuf.append("\r\n")
                           END IF
                        END IF 
                     END IF
               END CASE
            ELSE   #客製環境只提示未設定字型的
               IF cl_null(l_font) THEN
#                  LET l_msg=cl_getmsg("adz-00437",p_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00506",p_lang) CLIPPED   #170123-00046#1 mark
                  LET l_msg=cl_getmsg("adz-00437",g_lang) CLIPPED,p_gzgd007," ",l_nodename," ",cl_getmsg("adz-00506",g_lang) CLIPPED    #170123-00046#1 add
                  IF l_msg IS NOT NULL THEN
                     CALL l_set_strbuf.append(l_msg)
                     CALL l_set_strbuf.append("\r\n")
                  END IF                  
               END IF
            END IF
         END IF   
      END FOR
   END IF #l_node IS NOT NULL

   #將錯誤訊息附加到紀錄檢查命名規則錯誤的變數中
   IF l_force_strbuf.getLength() > 0 THEN
      IF g_chk_force_msg IS NULL THEN
         LET g_chk_force_msg = l_force_strbuf.toString()
      ELSE
         LET g_chk_force_msg = g_chk_force_msg,l_force_strbuf.toString()
      END IF
   END IF
   IF l_set_strbuf.getLength() > 0 THEN
      IF g_chk_set_msg IS NULL THEN
         LET g_chk_set_msg = l_set_strbuf.toString()
      ELSE
         LET g_chk_set_msg = g_chk_set_msg,l_set_strbuf.toString()
      END IF
   END IF
   #151026-00010#1 add(s)
   IF l_fid_strbuf.getLength() > 0 THEN
      IF g_chk_fid_msg IS NULL THEN
         LET g_chk_fid_msg = l_fid_strbuf.toString()
      ELSE
         LET g_chk_fid_msg = g_chk_fid_msg,l_fid_strbuf.toString()
      END IF
   END IF   
   #151026-00010#1 add(e)   
END FUNCTION


#數值格式檢查
PRIVATE FUNCTION sadzp188_multilang_4rp_chknum(p_lang,p_rep_code,p_4rpname,p_rootnode)
   DEFINE p_lang           LIKE gzzy_t.gzzy001   #語言別
   DEFINE p_rep_code       LIKE gzgd_t.gzgd001   #報表元件代號
   DEFINE p_4rpname        STRING                #樣板代號
   DEFINE p_rootnode       om.DomNode
   DEFINE l_msg            STRING
   DEFINE l_curnode        om.DomNode
   DEFINE l_nodes          om.NodeList
   DEFINE l_i              INTEGER
   DEFINE l_curname        STRING
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_cnt_s          LIKE type_t.num5
   DEFINE l_cnt_e          LIKE type_t.num5
   DEFINE l_def_flag       BOOLEAN
   DEFINE l_field          STRING
   DEFINE l_field_1        STRING
   DEFINE l_dzgh007        LIKE dzgh_t.dzgh007 #報表變數代號
   DEFINE l_dzgh001        LIKE dzgh_t.dzgh001 #報表變數代號
   DEFINE l_dzgh003        LIKE dzgh_t.dzgh003 #報表變數代號
   DEFINE l_dzgh010        LIKE dzgh_t.dzgh010
  
   DEFINE l_gztz001        LIKE gztz_t.gztz001 #表格編號
   DEFINE l_datatype       LIKE dzeb_t.dzeb007
   DEFINE l_length         LIKE dzeb_t.dzeb008
   DEFINE ls_revision      INTEGER
   DEFINE ls_identity      STRING
   DEFINE ls_err_msg       STRING
   DEFINE l_typestr        STRING #欄位型態 數值或字串   
   DEFINE l_numfmt_x       LIKE gzgg_t.gzgg008   #XG 數值格式
   DEFINE l_numfmt_t       STRING  #原本的4rp數值Format
   DEFINE l_numfmt_std     STRING   
   #DEFINE l_dzeb006        LIKE dzeb_t.dzeb006
   DEFINE l_force_strbuf   base.StringBuffer     #錯誤訊息(強制)
   DEFINE l_set_strbuf     base.StringBuffer     #錯誤訊息(設定) 

   LET g_msg = ""
   LET l_force_strbuf = base.StringBuffer.create()
   LET l_set_strbuf = base.StringBuffer.create()
   
   #取得最大版次
   CALL cl_adz_get_spec_curr_revision(p_rep_code,"","G") RETURNING ls_revision,ls_identity,ls_err_msg
      
   LET l_nodes = p_rootnode.selectByTagName("DECIMALFORMATBOX")
   FOR l_i = 1 TO l_nodes.getLength()                                
      LET l_def_flag = FALSE
      LET l_curnode=l_nodes.item(l_i)  
      LET l_curname=l_curnode.getAttribute("name")      
      LET l_numfmt_t = l_curnode.getAttribute("format")
      
      IF l_numfmt_t.getIndexOf("{{",1) > 0 THEN         
         LET l_numfmt_t = l_numfmt_t.subString(3,l_numfmt_t.getLength()-2)
      END IF
         
      LET l_field = l_curnode.getAttribute("value")  #value="{{sr1.xmdc015}}"
      LET l_cnt_s = l_field.getIndexOf(".",1)
      LET l_cnt_e = l_field.getIndexOf("}",1) - 1
      LET l_field_1 = l_field.subString(l_cnt_s + 1,l_cnt_e)
      IF l_field_1.subString(1,2) = "l_" THEN
         LET l_def_flag = TRUE
      END IF
      
      LET l_field = l_field.subString(3,l_cnt_e)

      LET l_dzgh001 = p_rep_code
      LET l_dzgh003 = p_4rpname
      LET l_dzgh010 = l_field_1

      LET l_dzgh007 = ""
      SELECT MAX(dzgh007) INTO l_dzgh007 FROM dzgh_t
       WHERE dzgh001 = l_dzgh001
         AND dzgh002 = ls_revision
         AND dzgh003 = l_dzgh003
         AND dzgh010 = l_dzgh010
         AND dzgh012 = 's'

      LET l_datatype = ""
      IF NOT cl_null(l_dzgh007) THEN      
         #取得table名稱     
         SELECT gztz001 INTO l_gztz001 FROM gztz_t WHERE gztz002 = l_dzgh007
            AND gztz001 NOT LIKE '%rebuil'    #151208-00023#1 add 
            ##161227-00056#1 add -(s)
            AND gztz001 NOT LIKE 'erp%'   
            AND gztz001 NOT LIKE 'all%'
            AND gztz001 NOT LIKE 'b2b%'
            AND gztz001 NOT LIKE 'pos%'
            AND gztz001 NOT LIKE 'dsm%'
            ##161227-00056#1 add -(e)        
#         CALL cl_xg_get_column_info("ds",l_gztz001,l_dzgh007) RETURNING l_datatype,l_length   #150901-00021#1 mark
         CALL cl_rpt_get_column_info("ds",l_gztz001,l_dzgh007) RETURNING l_datatype,l_length   #150901-00021#1 add
         CALL sadzp188_gen4rp_get_type(p_rep_code,l_dzgh007,l_dzgh010) RETURNING l_typestr, l_numfmt_std, l_numfmt_x
         IF l_numfmt_t = "g_grNumFmt.seq" THEN LET l_numfmt_std = "g_grNumFmt.seq" END IF
         IF cl_null(l_numfmt_std) THEN LET l_numfmt_std = "g_grNumFmt.default" END IF
#         IF l_typestr = "FGLNumeric" THEN
#            SELECT dzeb006 INTO l_dzeb006 FROM dzeb_t
#            LEFT JOIN gztz_t ON gztz001 = dzeb001 AND gztz002 = dzeb002
#             WHERE dzeb002 = l_dzgh007
#         END IF

         #CALL cl_gr_get_numfmt(l_dzeb006,"G","") RETURNING l_numfmt_std,l_numfmt_x          

         #數值格式如果是手動輸入,如"---,---,--&.&&",改為提示訊息 
         IF l_numfmt_t.getIndexOf("g_grNumFmt",1) > 0 THEN 
            #IF l_numfmt_t != l_numfmt_std THEN
            IF (l_numfmt_t != l_numfmt_std AND NOT l_def_flag) OR cl_null(l_numfmt_t) THEN
#               LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED,p_4rpname," ", l_curname," ",cl_getmsg("adz-00464",p_lang) CLIPPED   #170123-00046#1 mark
               LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_4rpname," ", l_curname," ",cl_getmsg("adz-00464",g_lang) CLIPPED    #170123-00046#1 add
               LET l_msg = cl_replace_str(l_msg,"%1",l_numfmt_std)
               IF l_msg IS NOT NULL THEN
                  CALL l_force_strbuf.append(l_msg)
                  CALL l_force_strbuf.append("\r\n")
               END IF 
               LET g_force_err=g_force_err+1 #強制訊息                           
            END IF
         ELSE
#            LET l_msg= cl_getmsg("adz-00437",p_lang) CLIPPED,p_4rpname," ", l_curname," ",cl_getmsg("adz-00464",p_lang) CLIPPED   #170123-00046#1 mark
            LET l_msg= cl_getmsg("adz-00437",g_lang) CLIPPED,p_4rpname," ", l_curname," ",cl_getmsg("adz-00464",g_lang) CLIPPED    #170123-00046#1 add
            IF l_msg IS NOT NULL THEN
               CALL l_set_strbuf.append(l_msg)
               CALL l_set_strbuf.append("\r\n")
            END IF             
         END IF
      #欄位在設計資料中找不到   
      ELSE
         LET l_cnt = l_field.getIndexOf("sr",1)
         IF l_cnt > 0 THEN
            LET l_dzgh007 = l_field_1
            #取得table名稱     
            SELECT gztz001 INTO l_gztz001 FROM gztz_t WHERE gztz002 = l_dzgh007
               AND gztz001 NOT LIKE '%rebuil'    #151208-00023#1 add
               ##161227-00056#1 add -(s)
               AND gztz001 NOT LIKE 'erp%'   
               AND gztz001 NOT LIKE 'all%'
               AND gztz001 NOT LIKE 'b2b%'
               AND gztz001 NOT LIKE 'pos%'
               AND gztz001 NOT LIKE 'dsm%'
               ##161227-00056#1 add -(e)           
            CALL sadzp188_gen4rp_get_type(p_rep_code,l_dzgh007,l_dzgh007) RETURNING l_typestr, l_numfmt_std, l_numfmt_x
            IF l_numfmt_t = "g_grNumFmt.seq" THEN LET l_numfmt_std = "g_grNumFmt.seq" END IF
            IF cl_null(l_numfmt_std) THEN LET l_numfmt_std = "g_grNumFmt.default" END IF

#            IF l_typestr = "FGLNumeric" THEN
#               SELECT dzeb006 INTO l_dzeb006 FROM dzeb_t
#               LEFT JOIN gztz_t ON gztz001 = dzeb001 AND gztz002 = dzeb002
#                WHERE dzeb002 = l_dzgh007
#            END IF            

            #數值格式如果是手動輸入,如"---,---,--&.&&",改為提示訊息 
            IF l_numfmt_t.getIndexOf("g_grNumFmt",1) > 0 AND l_numfmt_std <> "g_grNumFmt.default" THEN             
               IF (l_numfmt_t != l_numfmt_std AND NOT l_def_flag) OR cl_null(l_numfmt_t) THEN
#                  LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED,p_4rpname," ", l_curname," ",cl_getmsg("adz-00464",p_lang) CLIPPED   #170123-00046#1 mark
                  LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_4rpname," ", l_curname," ",cl_getmsg("adz-00464",g_lang) CLIPPED    #170123-00046#1 add
                  LET l_msg = cl_replace_str(l_msg,"%1",l_numfmt_std)
                  IF l_msg IS NOT NULL THEN
                     CALL l_force_strbuf.append(l_msg)
                     CALL l_force_strbuf.append("\r\n")
                  END IF 
                  LET g_force_err=g_force_err+1 #強制訊息                           
               END IF
            ELSE
#               LET l_msg= cl_getmsg("adz-00437",p_lang) CLIPPED,p_4rpname," ", l_curname," ",cl_getmsg("adz-00464",p_lang) CLIPPED   #170123-00046#1 mark
               LET l_msg= cl_getmsg("adz-00437",g_lang) CLIPPED,p_4rpname," ", l_curname," ",cl_getmsg("adz-00464",g_lang) CLIPPED    #170123-00046#1 add
               IF l_msg IS NOT NULL THEN
                  CALL l_set_strbuf.append(l_msg)
                  CALL l_set_strbuf.append("\r\n")
               END IF             
            END IF
            
         END IF   
      END IF  #NOT cl_null(l_dzgh007)
   END FOR 

   #將錯誤訊息附加到紀錄檢查命名規則錯誤的變數中
   IF l_force_strbuf.getLength() > 0 THEN
      IF g_chk_force_msg IS NULL THEN
         LET g_chk_force_msg = l_force_strbuf.toString()
      ELSE
         LET g_chk_force_msg = g_chk_force_msg,l_force_strbuf.toString()
      END IF
   END IF   
END FUNCTION 


#日期格式檢查
PRIVATE FUNCTION sadzp188_multilang_4rp_chkdate(p_lang,p_rep_code,p_4rpname,p_rootnode)
   DEFINE p_lang           LIKE gzzy_t.gzzy001   #語言別
   DEFINE p_rep_code       LIKE gzgd_t.gzgd001   #報表元件代號
   DEFINE p_4rpname        STRING                #樣板代號
   DEFINE p_rootnode       om.DomNode
   DEFINE l_curnode        om.DomNode
   DEFINE l_nodes          om.NodeList
   DEFINE l_i              INTEGER
   DEFINE l_curname        STRING
   DEFINE l_msg            STRING
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_cnt_s          LIKE type_t.num5
   DEFINE l_cnt_e          LIKE type_t.num5
   DEFINE l_field          STRING
   DEFINE l_field_t        STRING  
   DEFINE l_field_1        STRING
   DEFINE l_field_std      STRING   
   DEFINE l_dzgh007        LIKE dzgh_t.dzgh007 #報表變數代號
   DEFINE l_dzgh001        LIKE dzgh_t.dzgh001 #報表變數代號
   DEFINE l_dzgh003        LIKE dzgh_t.dzgh003 #報表變數代號
   DEFINE l_dzgh010        LIKE dzgh_t.dzgh010
  
   DEFINE l_gztz001        LIKE gztz_t.gztz001 #表格編號
   DEFINE l_datatype       LIKE dzeb_t.dzeb007
   DEFINE l_length  　     LIKE dzeb_t.dzeb008
   DEFINE l_force_strbuf  base.StringBuffer     #錯誤訊息(強制) 
  
   LET g_msg = ""
   LET l_force_strbuf = base.StringBuffer.create()
   
   LET l_nodes = p_rootnode.selectByTagName("WORDWRAPBOX")
   FOR l_i = 1 TO l_nodes.getLength()                                
      LET l_curnode=l_nodes.item(l_i)  
      LET l_curname=l_curnode.getAttribute("name")
      LET l_cnt = l_curname.getIndexOf("_Value",1)

      IF l_cnt > 0 THEN
         LET l_field = l_curnode.getAttribute("text")
         LET l_field_t = l_field
         #已加入日期格式
         IF l_field.getIndexOf("isoValue",1) > 0 THEN
            LET l_cnt_s = l_field.getIndexOf("Date.fromIsoValue",1)+1
            LET l_cnt_e = l_field.getIndexOf(".isoValue",1) - 1
            LET l_field_1 = l_field.subString(l_cnt_s + 21,l_cnt_e)
            LET l_field = l_field.subString(l_cnt_s + 17,l_cnt_e)
         ELSE
            LET l_cnt_s = l_field.getIndexOf(".",1)
            LET l_cnt_e = l_field.getIndexOf("}",1) - 1
            LET l_field_1 = l_field.subString(l_cnt_s + 1,l_cnt_e)

            LET l_field = l_field.subString(3,l_cnt_e)
         END IF                 

         LET l_dzgh001 = p_rep_code
         LET l_dzgh003 = p_4rpname
         LET l_dzgh010 = l_field_1

         LET l_dzgh007 = ""
         SELECT MAX(dzgh007) INTO l_dzgh007 FROM dzgh_t
          WHERE dzgh001 = l_dzgh001
            AND dzgh002 = "1"
            AND dzgh003 = l_dzgh003
            AND dzgh010 = l_dzgh010
            AND dzgh012 = 's'

         LET l_datatype = ""
         IF NOT cl_null(l_dzgh007) THEN      
            #取得table名稱     
            SELECT gztz001 INTO l_gztz001 FROM gztz_t WHERE gztz002 = l_dzgh007
               AND gztz001 NOT LIKE '%rebuil'    #151208-00023#1 add   
               ##161227-00056#1 add -(s)
               AND gztz001 NOT LIKE 'erp%'   
               AND gztz001 NOT LIKE 'all%'
               AND gztz001 NOT LIKE 'b2b%'
               AND gztz001 NOT LIKE 'pos%'
               AND gztz001 NOT LIKE 'dsm%'
               ##161227-00056#1 add -(e)           
            
#            CALL cl_xg_get_column_info("ds",l_gztz001,l_dzgh007) RETURNING l_datatype,l_length   #150901-00021#1 mark
            CALL cl_rpt_get_column_info("ds",l_gztz001,l_dzgh007) RETURNING l_datatype,l_length   #150901-00021#1 add
            IF UPSHIFT(l_datatype) = "DATETIME" OR UPSHIFT(l_datatype) = "DATE" THEN
               LET l_field_std = "{{",l_field,".isoValue.trim().isEmpty()?\"\":Date.fromIsoValue(",l_field,".isoValue).format(g_date_fmt)}}"            

               IF l_field_t !=l_field_std THEN
#                  LET l_msg= cl_getmsg("adz-00408",p_lang) CLIPPED,p_4rpname," ", l_curname," ",cl_getmsg("adz-00465",p_lang) CLIPPED   #170123-00046#1 mark
                  LET l_msg= cl_getmsg("adz-00408",g_lang) CLIPPED,p_4rpname," ", l_curname," ",cl_getmsg("adz-00465",g_lang) CLIPPED    #170123-00046#1 add
                  LET l_msg = cl_replace_str(l_msg,"%1",l_field_std)
                  IF l_msg IS NOT NULL THEN
                     CALL l_force_strbuf.append(l_msg)
                     CALL l_force_strbuf.append("\r\n")
                  END IF 
                  LET g_force_err=g_force_err+1 #強制訊息                           
               END IF   
            END IF #IF UPSHIFT(l_datatype) = "DATETIME" OR UPSHIFT(l_datatype) = "DATE"
         END IF  #NOT cl_null(l_dzgh007)
      END IF 

   END FOR
      
   #將錯誤訊息附加到紀錄檢查命名規則錯誤的變數中
   IF l_force_strbuf.getLength() > 0 THEN
      IF g_chk_force_msg IS NULL THEN
         LET g_chk_force_msg = l_force_strbuf.toString()
      ELSE
         LET g_chk_force_msg = g_chk_force_msg,l_force_strbuf.toString()
      END IF
   END IF      
END FUNCTION 

#還原4rp
PRIVATE FUNCTION sadzp188_multilang_4rp_recovery(p_module_name,p_rep_code,p_file_name,p_lang)
   DEFINE p_module_name    STRING                #模組代碼
   DEFINE p_rep_code       LIKE gzgd_t.gzgd001   #報表元件代號
   DEFINE p_file_name      STRING                #樣板代號
   DEFINE p_lang           STRING
   DEFINE ls_module_path   STRING
   DEFINE ls_module_full_path STRING
   DEFINE lo_lang_arr      DYNAMIC ARRAY OF T_LANGUAGE_TYPE
   DEFINE ls_source_dir    STRING
   DEFINE ls_bak_dir       STRING
   DEFINE ls_source_wdir   STRING
   DEFINE ls_bak_wdir      STRING   
   DEFINE ls_module_name   STRING
   DEFINE ls_file_name     STRING
   DEFINE ls_separator     STRING
   DEFINE ls_mnt4rp        STRING
   DEFINE ls_lang          STRING
   DEFINE lb_success       BOOLEAN
   DEFINE li_lng_count     INTEGER
   DEFINE l_gzgd000        LIKE gzgd_t.gzgd000,   #報表樣板ID
          l_gzgd002        LIKE gzgd_t.gzgd002,   #樣板代號
          l_gzgd003        LIKE gzgd_t.gzgd003,   #客製否
          l_gzgd007        LIKE gzgd_t.gzgd007,   #樣板名稱(4rp)
          l_gzgd013        LIKE gzgd_t.gzgd013    
   DEFINE ls_4rp_name      STRING

       
   LET ls_module_name = p_module_name.toUpperCase()
   LET ls_file_name   = p_file_name
   
   LET lb_success     = TRUE
   LET ls_separator   = os.Path.separator()
   LET ls_lang        = p_lang
   
   LET ls_module_path = FGL_GETENV(ls_module_name)
#   CALL FGL_GETENV("MNT4RP") RETURNING ls_mnt4rp   #151102-00034#1 mark
   LET ls_mnt4rp = cl_rpt_get_env_global("MNT4RP")   #151102-00034#1 add

   LET ls_module_full_path = ls_module_path,ls_separator,"4rp",ls_separator,ls_lang
   CALL os.Path.chdir(ls_module_full_path) RETURNING lb_success
   
   CALL sadzp060_get_lang_type_list() RETURNING lo_lang_arr

   LET g_4rpid = ""
   LET l_gzgd002 = ""
   LET l_gzgd003 = ""
   LET l_gzgd007 = ""
   FOR li_lng_count = 1 TO lo_lang_arr.getLength()
      LET ls_lang = lo_lang_arr[li_lng_count]
      FOREACH sadzp188_multilang_4rp_name_cs INTO l_gzgd000,l_gzgd002,l_gzgd003,l_gzgd007,l_gzgd013
         LET ls_4rp_name = l_gzgd007
         LET ls_source_dir = ls_module_path,ls_separator,"4rp",ls_separator,ls_lang,ls_separator,ls_4rp_name,".4rp"
         LET ls_bak_dir    = ls_module_path,ls_separator,"4rp",ls_separator,ls_lang,ls_separator,ls_4rp_name,".4rp.bak"
         IF os.Path.exists(ls_source_dir) AND os.Path.exists(ls_bak_dir) THEN
            CALL os.Path.copy(ls_bak_dir,ls_source_dir) RETURNING lb_success
            IF NOT lb_success THEN
               #161103-00051#1 add(s)
               LET g_msg = g_prog,",",g_4rpfile,", copy file failure-Recover"
               CALL g_log_ch_err.writeLine(g_msg)
               #161103-00051#1 add(e)
               #報表樣板還原失敗
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00463"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = ls_4rp_name
               CALL cl_err()
            END IF   
         END IF   

         LET ls_source_wdir = ls_mnt4rp,ls_separator,ls_module_name.toLowerCase(),ls_separator,"4rp",ls_separator,ls_lang,ls_separator,ls_4rp_name,".4rp"
         LET ls_bak_wdir    = ls_mnt4rp,ls_separator,ls_module_name.toLowerCase(),ls_separator,"4rp",ls_separator,ls_lang,ls_separator,ls_4rp_name,".4rp.bak"
         IF g_erpid = "T100ERP" THEN             #160608-00012#1 add
            IF os.Path.exists(ls_source_wdir) AND os.Path.exists(ls_bak_wdir) THEN
               CALL os.Path.copy(ls_bak_wdir,ls_source_wdir) RETURNING lb_success
               IF NOT lb_success THEN
                  #報表樣板還原失敗
                  #161103-00051#1 add(s)
                  LET g_msg = g_prog,",",g_4rpfile,", copy file failure-Recover"
                  CALL g_log_ch_err.writeLine(g_msg)
                  #161103-00051#1 add(e)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "adz-00463"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = ls_4rp_name
                  CALL cl_err()
               END IF
            END IF
         END IF                                  #160608-00012#1 add
      END FOREACH
   END FOR

END FUNCTION

################################################################################
# Descriptions...: 上傳4rp時將欄位說明回寫至gzge_t
# Memo...........:
# Usage..........: CALL sadzp188_multilang_4rp_chk_label(p_sys,p_rep_code,p_4rpname,p_lang)
# Input parameter: p_sys          模組代碼
#                : p_rep_code     報表元件代號
#                : p_4rpname      樣板名稱
#                : p_lang         語言別
# Return code....: ri_errcnt
#                : rs_msg
# Date & Author..: 2014/12/4 By Cynthia
# Modify.........:
################################################################################
PUBLIC FUNCTION sadzp188_multilang_4rp_chk_label(p_sys,p_rep_code,p_4rpname,p_lang)
   DEFINE p_sys            LIKE gzde_t.gzde002   #模組代碼
   DEFINE p_rep_code       LIKE gzgd_t.gzgd001   #報表元件代號
   DEFINE p_4rpname        LIKE gzgd_t.gzgd002   #樣板代號
   DEFINE p_lang           LIKE gzzy_t.gzzy001   #語言別
   DEFINE l_4rpfile        STRING
   DEFINE l_sql            STRING
   DEFINE l_gzgd000        LIKE gzgd_t.gzgd000,  #報表樣板ID
          l_gzgd002        LIKE gzgd_t.gzgd002,  #樣板代號
          l_gzgd003        LIKE gzgd_t.gzgd003,  #客製否
          l_gzgd007        LIKE gzgd_t.gzgd007,  #樣板名稱(4rp)
          l_gzgd013        LIKE gzgd_t.gzgd013    
   DEFINE l_doc            om.DomDocument
   DEFINE l_rootnode       om.DomNode 
   DEFINE l_msg            STRING                #160127-00012 add      
 
   LET g_4rpid = ""
   LET l_gzgd002 = ""
   LET l_gzgd003 = ""
   LET l_gzgd007 = ""
   
   FOREACH sadzp188_multilang_4rp_name_cs INTO l_gzgd000,l_gzgd002,l_gzgd003,l_gzgd007,l_gzgd013  
      CALL sadzp188_get4rppath(p_sys,l_gzgd007,p_lang) RETURNING l_4rpfile
      IF NOT os.Path.exists(l_4rpfile) THEN
         LET l_msg = cl_getmsg("azz-00676",g_lang)   #160127-00012 add
         DISPLAY "ERROR!! ",l_msg                    #160127-00012 add
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'azz-00676'
         LET g_errparam.extend = l_4rpfile
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         RETURN 
      END IF
      #將4rp欄位屬性讀入陣列
      LET l_doc = om.DomDocument.createFromXmlFile(l_4rpfile)
      IF l_doc IS NOT NULL THEN
         LET l_rootnode = l_doc.getDocumentElement()
         CALL sadzp188_multilang_4rp_upd_gzge(l_gzgd000,p_lang,l_rootnode,"WORDWRAPBOX")
         CALL sadzp188_multilang_4rp_upd_gzge(l_gzgd000,p_lang,l_rootnode,"WORDBOX")
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 欄位說明回寫至gzge_t
# Memo...........:
# Usage..........: CALL 
# Input parameter: p_sys          模組代碼
#                : p_4rpname      樣板名稱
#                : p_lang         語言別
# Return code....: void
# Date & Author..: 2014/10/9 By Cynthia
# Modify.........:
################################################################################
PRIVATE FUNCTION sadzp188_multilang_4rp_upd_gzge(p_gzgd000,p_lang,p_node,p_tagname)
   DEFINE p_gzgd000       LIKE gzgd_t.gzgd000  #報表樣板ID
   DEFINE p_lang          LIKE gzzy_t.gzzy001  #語言別
   DEFINE p_node          om.DomNode
   DEFINE p_tagname       STRING 
   DEFINE l_node          om.NodeList          #存標籤節點 
   DEFINE l_curnode       om.DomNode
   DEFINE l_curname       STRING
   DEFINE l_i             LIKE type_t.num5   
   DEFINE l_msg           STRING
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_tran_cnt      LIKE type_t.num5
   DEFINE l_std_cnt       LIKE type_t.num5
   DEFINE l_label         STRING
   DEFINE l_label_name    STRING
   DEFINE l_gzge          RECORD LIKE gzge_t.*
   DEFINE l_date          DATETIME YEAR TO SECOND
   DEFINE l_flag          LIKE type_t.chr1   #150616-00029#1 add   
   
   LET l_node = p_node.selectByTagName(p_tagname)
   
   CALL cl_err_collect_init()     #錯誤訊息彙總   #160629-00012#1-3 add
   IF l_node IS NOT NULL THEN
      FOR l_i=1 TO l_node.getLength()
         LET l_curnode = l_node.item(l_i)
         LET l_curname = l_curnode.getAttribute("name")

         IF l_curname.getIndexOf("_Label",1) > 0 AND l_curname.getIndexOf("PF",1) = 0 AND 
            l_curname.getIndexOf("RF",1) = 0 THEN
            LET l_label = l_curnode.getAttribute("text")
            #150707 add(s)
            IF l_curname.getIndexOf("apdasite",1) > 0 THEN
               #DISPLAY "l_label:",l_label,";l_lang:",p_lang
            END IF
            #150707 add(e)

            #去除排版加空白的部分
            LET l_label = cl_replace_str(l_label,' ','')
            #先移除欄位說明的":"     
            LET l_label = cl_replace_str(l_label,':','')
            #判斷是否為純英數
            LET l_flag = sadzp188_gen4rp_str_chk(l_label)   #150616-00029#1 add
            IF l_flag = "N" THEN   #150616-00029#1 add
               IF NOT cl_null(l_label) THEN
                  LET l_label_name = l_curname.subString(1,l_curname.getIndexOf("_Label",1)-1)
                  LET l_label_name = cl_replace_str(l_label_name,"PH","")
                  LET l_label_name = cl_replace_str(l_label_name,"RH","")
               
                  IF l_label_name.getIndexOf("sr",1) > 0 THEN
                     LET l_label_name = l_label_name.subString(l_label_name.getIndexOf(".",1)+1,l_label_name.getLength())
                  END IF
                  #DISPLAY "l_label_name:",l_label_name

                  LET l_gzge.gzge001 = l_label_name   #報表欄位代碼
                  LET l_gzge.gzge003 = l_label        #說明
               
                  #比對"資料表欄位多語言檔(r.t)"中有無此欄位說明 
                  SELECT COUNT(dzebl001) INTO l_std_cnt FROM dzebl_t
                   WHERE dzebl001 = l_gzge.gzge001
                     AND dzebl002 = p_lang
                     AND dzebl003 = l_gzge.gzge003
                              
                  IF l_std_cnt = 0 THEN   
                     SELECT COUNT(gzge001) INTO l_cnt FROM gzge_t  
                      WHERE gzge000 = p_gzgd000
                        AND gzge001 = l_gzge.gzge001
                        AND gzge002 = p_lang
                  
#                     IF l_cnt = 0 THEN   #150616-00029#1 mark
                     IF l_cnt = 0 AND NOT cl_null(l_label_name) THEN   #150616-00029#1 add
                        LET l_gzge.gzgestus = "Y"
                        LET l_gzge.gzge000 = p_gzgd000
                        LET l_gzge.gzge001 = l_label_name   #報表欄位代碼
                        LET l_gzge.gzge002 = p_lang
                        LET l_gzge.gzge003 = l_label        #說明
                        LET l_gzge.gzgeownid = g_user
                        LET l_gzge.gzgeowndp = g_dept
                        LET l_gzge.gzgecrtid = g_user
                        LET l_gzge.gzgecrtdp = g_dept
                        LET l_gzge.gzgecrtdt = cl_get_current()
                        LET l_gzge.gzgemodid = ""
                        LET l_gzge.gzgemoddt = ""
  
                        INSERT INTO gzge_t VALUES l_gzge.*
                        #150204 第一次就需寫入語言add(s)
                        IF p_lang = 'zh_TW' THEN
                           SELECT COUNT(gzge001) INTO l_tran_cnt FROM gzge_t
                            WHERE gzge001 = l_gzge.gzge001 
                              AND gzge002 = 'zh_CN'
                              AND gzge000 = p_gzgd000
                           IF l_tran_cnt < 1 THEN
                              LET l_label = l_gzge.gzge003
                              LET l_label = cl_trans_code_tw_cn('zh_CN',l_label)
                              LET l_gzge.gzge003 = l_label        #說明
                              LET l_gzge.gzge002 = 'zh_CN'
                              INSERT INTO gzge_t VALUES l_gzge.*
                           END IF   
                        END IF
                     
                        IF p_lang = 'zh_CN' THEN
                           SELECT COUNT(gzge001) INTO l_tran_cnt FROM gzge_t
                            WHERE gzge001 = l_gzge.gzge001
                              AND gzge002 = 'zh_TW'
                              AND gzge000 = p_gzgd000
                           IF l_tran_cnt < 1 THEN
                              LET l_label = l_gzge.gzge003
                              LET l_label = cl_trans_code_tw_cn('zh_TW',l_label)
                              LET l_gzge.gzge003 = l_label        #說明
                              LET l_gzge.gzge002 = 'zh_TW'
                              INSERT INTO gzge_t VALUES l_gzge.*
                           END IF   
                        END IF
                        #150204 add(e)
                     ELSE
                        LET l_date = cl_get_current()
                        UPDATE gzge_t SET (gzge003,gzgemodid,gzgemoddt) = (l_gzge.gzge003,g_user,l_date)
                         WHERE gzge000 = p_gzgd000
                           AND gzge001 = l_gzge.gzge001
                           AND gzge002 = p_lang
                           AND gzgestus = "Y"
                     END IF #l_cnt = 0 gzge_t中無資料
                  #150707-00030#1 add(s)
                  ELSE   #如果與r.t的說明一致, gzge_t的資料要刪掉
                     SELECT COUNT(gzge003) INTO l_cnt FROM gzge_t  
                      WHERE gzge000 = p_gzgd000
                        AND gzge001 = l_gzge.gzge001
                        AND gzge002 = p_lang
                     IF l_cnt > 0 THEN
                        DELETE FROM gzge_t WHERE gzge000 = p_gzgd000 AND gzge001 = l_gzge.gzge001 AND gzge002 = p_lang
                     END IF
                  #150707-00030#1 add(e)                     
                  END IF #l_std_cnt = 0  r.t中無資料
               ELSE
                  IF g_lang != p_lang THEN
                     LET l_label_name = l_curname.subString(1,l_curname.getIndexOf("_Label",1)-1)
                     LET l_label_name = cl_replace_str(l_label_name,"PH","")
                     LET l_label_name = cl_replace_str(l_label_name,"RH","")
               
                     IF l_label_name.getIndexOf("sr",1) > 0 THEN
                        LET l_label_name = l_label_name.subString(l_label_name.getIndexOf(".",1)+1,l_label_name.getLength())
                     END IF
                     #DISPLAY "l_label_name:",l_label_name

                     LET l_gzge.gzge001 = l_label_name   #報表欄位代碼
#                     LET l_gzge.gzge003 = l_label        #說明
               
                     #比對"資料表欄位多語言檔(r.t)"中有無此欄位說明(g_lang) 
                     SELECT COUNT(dzebl001) INTO l_std_cnt FROM dzebl_t
                      WHERE dzebl001 = l_gzge.gzge001
                        AND dzebl002 = g_lang
                              
                     IF l_std_cnt = 0 THEN   
                        SELECT COUNT(gzge001) INTO l_cnt FROM gzge_t  
                         WHERE gzge000 = p_gzgd000
                           AND gzge001 = l_gzge.gzge001
                           AND gzge002 = p_lang
                  
                        IF l_cnt = 0 THEN
                           SELECT gzge003 INTO l_gzge.gzge003 FROM gzge_t  
                            WHERE gzge000 = p_gzgd000
                              AND gzge001 = l_gzge.gzge001
                              AND gzge002 = g_lang
                     
#                           IF NOT cl_null(l_gzge.gzge003) THEN   #150616-00029#1 mark
                           IF NOT cl_null(l_gzge.gzge003) AND NOT cl_null(l_label_name) THEN   #150616-00029#1 add
                              LET l_label = l_gzge.gzge003
                              LET l_label = cl_trans_code_tw_cn(p_lang,l_label)                     
                     
                              LET l_gzge.gzgestus = "Y"
                              LET l_gzge.gzge000 = p_gzgd000
                              LET l_gzge.gzge001 = l_label_name   #報表欄位代碼
                              LET l_gzge.gzge002 = p_lang
                              LET l_gzge.gzge003 = l_label        #說明
                              LET l_gzge.gzgeownid = g_user
                              LET l_gzge.gzgeowndp = g_dept
                              LET l_gzge.gzgecrtid = g_user
                              LET l_gzge.gzgecrtdp = g_dept
                              LET l_gzge.gzgecrtdt = cl_get_current()
                              LET l_gzge.gzgemodid = ""
                              LET l_gzge.gzgemoddt = ""

                              INSERT INTO gzge_t VALUES l_gzge.*
                           END IF
                        END IF
                     END IF   
                  END IF   #150616-00029#1 add
                END IF #NOT cl_null(l_label) 欄位說明不為空
            END IF       
         END IF
      END FOR
   END IF

   CALL cl_err_collect_show()     #160629-00012#1-3 #顯示彙總錯誤訊息
END FUNCTION

################################################################################
# Descriptions...: 上傳4rp時將欄位說明回寫至gzge_t
# Memo...........:
# Usage..........: CALL sadzp188_multilang_4rp_chk_label(p_sys,p_rep_code,p_4rpname,p_lang)
# Input parameter: p_sys          模組代碼
#                : p_rep_code     報表元件代號
#                : p_4rpname      樣板名稱
#                : p_lang         語言別
# Return code....: ri_errcnt
#                : rs_msg
# Date & Author..: 2014/12/4 By Cynthia
# Modify.........:
################################################################################
PRIVATE FUNCTION sadzp188_multilang_4rp_cust_paper(p_sys,p_rep_code,p_4rpname,p_lang)
   DEFINE p_sys            LIKE gzde_t.gzde002   #模組代碼
   DEFINE p_rep_code       LIKE gzgd_t.gzgd001   #報表元件代號
   DEFINE p_4rpname        LIKE gzgd_t.gzgd002   #樣板代號
   DEFINE p_lang           LIKE gzzy_t.gzzy001   #語言別
   DEFINE l_4rpfile        STRING
   DEFINE l_sql            STRING
   DEFINE l_gzgd000        LIKE gzgd_t.gzgd000,  #報表樣板ID
          l_gzgd002        LIKE gzgd_t.gzgd002,  #樣板代號
          l_gzgd003        LIKE gzgd_t.gzgd003,  #客製否
          l_gzgd007        LIKE gzgd_t.gzgd007,  #樣板名稱(4rp)
          l_gzgd013        LIKE gzgd_t.gzgd013
   DEFINE l_gzgd          RECORD
             gzgd001          LIKE gzgd_t.gzgd001,
             gzgd002          LIKE gzgd_t.gzgd002,
             gzgd003          LIKE gzgd_t.gzgd003,
             gzgd004          LIKE gzgd_t.gzgd004,
             gzgd005          LIKE gzgd_t.gzgd005
                          END RECORD      
   DEFINE l_gzgd002_r      DYNAMIC ARRAY OF LIKE gzgd_t.gzgd002
   DEFINE l_gzgd003_r      DYNAMIC ARRAY OF LIKE gzgd_t.gzgd003
   DEFINE l_gzgd013_r      DYNAMIC ARRAY OF LIKE gzgd_t.gzgd013
   DEFINE l_i,l_j          LIKE type_t.num5   
   DEFINE l_doc            om.DomDocument
   DEFINE l_rootnode       om.DomNode 
   DEFINE l_paper_size     LIKE gzgi_t.gzgi001   #樣板紙張大小
   DEFINE l_orientation    LIKE type_t.chr1      #樣板紙張方向
   
   DEFINE l_dst_width     STRING
   DEFINE l_dst_length    STRING 
   
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_msg            STRING   
   DEFINE r_msg            STRING
         
   LET l_gzgd002 = ""
   LET l_gzgd003 = ""
   LET l_gzgd007 = ""
   LET r_msg = NULL
   LET l_flag = FALSE

   LET l_i = 1
   FOREACH sadzp188_multilang_4rp_name_cs INTO l_gzgd000,l_gzgd002,l_gzgd003,l_gzgd007,l_gzgd013  
      CALL sadzp188_get4rppath(p_sys,l_gzgd007,p_lang) RETURNING l_4rpfile
      IF NOT os.Path.exists(l_4rpfile) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'azz-00676'
         LET g_errparam.extend = l_4rpfile
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         RETURN NULL
      END IF

      LET l_gzgd.gzgd001 = p_rep_code
      LET l_gzgd.gzgd002 = l_gzgd002
      LET l_gzgd.gzgd003 = l_gzgd003
      LET l_gzgd.gzgd004 = 'default'
      LET l_gzgd.gzgd005 = 'default'
      
      #將4rp欄位屬性讀入陣列
      LET l_doc = om.DomDocument.createFromXmlFile(l_4rpfile)
      IF l_doc IS NOT NULL THEN
         LET l_rootnode = l_doc.getDocumentElement()
#         CALL cl_gr_get_4rp_paper_size(l_rootnode) RETURNING l_paper_size,l_orientation   #150901-00021#1 mark
         CALL cl_rpt_get_4rp_paper_size(l_rootnode) RETURNING l_paper_size,l_orientation   #150901-00021#1 add
         IF l_gzgd013 != l_paper_size AND NOT cl_null(l_gzgd013) THEN
            #LET l_flag = TRUE
            #LET l_flag1 = FALSE
            #FOR l_j = 1 TO l_gzgd002_r.getLength()
            #FOR l_j = 1 TO l_i
            #   IF l_gzgd002 = l_gzgd002_r[l_j] THEN
            #      LET l_flag1 = TRUE
            #   END IF
            #END FOR 

            #IF NOT l_flag1 THEN
            #   LET l_gzgd002_r[l_i] = l_gzgd002
            #   LET l_gzgd003_r[l_i] = l_gzgd003
            #   LET l_gzgd013_r[l_i] = l_gzgd013
            #   LET l_i = l_i+1 
            #END IF
            
            IF cl_null(r_msg) THEN
#               LET r_msg = cl_getmsg("adz-00527",p_lang) CLIPPED,"\r\n",cl_getmsg("adz-00537",p_lang) CLIPPED," ", l_gzgd007 CLIPPED," ",l_paper_size,"-->",l_gzgd013   #170123-00046#1 mark
               LET r_msg = cl_getmsg("adz-00527",g_lang) CLIPPED,"\r\n",cl_getmsg("adz-00537",g_lang) CLIPPED," ", l_gzgd007 CLIPPED," ",l_paper_size,"-->",l_gzgd013    #170123-00046#1 add
            ELSE
#               LET r_msg = r_msg,"\r\n",cl_getmsg("adz-00537",p_lang) CLIPPED," ",l_gzgd007 CLIPPED," ",l_paper_size,"-->",l_gzgd013   #170123-00046#1 mark
               LET r_msg = r_msg,"\r\n",cl_getmsg("adz-00537",g_lang) CLIPPED," ",l_gzgd007 CLIPPED," ",l_paper_size,"-->",l_gzgd013    #170123-00046#1 add
            END IF
            
            CALL s_azzi301_change_paper_size(l_gzgd.*,p_lang,l_gzgd013,"") RETURNING l_success,l_msg 
            
            #IF l_flag THEN
            #   CALL s_azzi301_get_paper_size(p_paper_size) RETURNING l_dst_width,l_dst_length
            #END IF
            
         END IF
      END IF      
   END FOREACH

   
#   IF l_flag THEN
#      FOR l_j = 1 TO l_gzgd002_r.getLength()
#         LET l_gzgd.gzgd002 = l_gzgd002_r[l_j]               
#         LET l_gzgd.gzgd003 = l_gzgd003_r[l_j] 
#         IF cl_null(l_gzgd013_r[l_j]) THEN
#           LET l_gzgd013_r[l_j] = "A4"   #預設紙張為A4
#         END IF
#         IF cl_null(l_gzgd.gzgd002) THEN
#            CALL s_azzi301_change_paper_size(l_gzgd.*,p_lang,l_gzgd013_r[l_j],"") RETURNING l_success,l_msg               
#         END IF   
#      END FOR
#   END IF   

   RETURN r_msg
END FUNCTION

#161103-00051#1 add(s)
#取得單頭區塊
PRIVATE FUNCTION sadzp188_multilang_4rp_en_header(p_rootnode)
   DEFINE p_rootnode       om.DomNode
   DEFINE l_curnode        om.DomNode   
   DEFINE l_nodes          om.NodeList
   DEFINE l_curname        STRING   
   DEFINE l_i              INTEGER

   LET l_nodes = p_rootnode.selectByTagName("LAYOUTNODE")
   FOR l_i = 1 TO l_nodes.getLength()
      LET l_curnode=l_nodes.item(l_i)
      LET l_curname=l_curnode.getAttribute("name")
      IF l_curname.getIndexOf("RHMasters",1) > 0 OR l_curname.getIndexOf("RHMasterAs",1) > 0 
         OR l_curname.getIndexOf("PHMasters",1) > 0 OR l_curname.getIndexOf("PHMasterAs",1) > 0 THEN
         CALL sadzp188_multilang_4rp_en_header_wid(l_curnode)        
      END IF
   END FOR
   
END FUNCTION
#161103-00051#1 add(e)

#161103-00051#1 add(s)
#英文樣板單頭說明固定寬度
PRIVATE FUNCTION sadzp188_multilang_4rp_en_header_wid(p_rootnode)
   DEFINE p_rootnode       om.DomNode
   DEFINE l_curnode        om.DomNode
   DEFINE l_parent        om.DomNode
   DEFINE l_nextnode       om.DomNode
   DEFINE l_tmpnode       om.DomNode
   DEFINE l_lastnode       om.DomNode
   DEFINE l_nodes          om.NodeList
   DEFINE l_i              INTEGER
   DEFINE l_curname        STRING
   DEFINE l_nextname       STRING
   DEFINE l_width          STRING
   DEFINE l_w_ori          STRING   #原始寬度
   DEFINE l_w_cm           DECIMAL  #原始寬度(數字/cm)
   DEFINE l_w_pi           DECIMAL  #原始寬度(數字/pixel)
   DEFINE l_less           DECIMAL  #放大的寬度
   DEFINE l_less_s         STRING   #放大的寬度
   DEFINE l_nw_ori          STRING   #原始寬度
   DEFINE l_nw_cm           DECIMAL  #原始寬度(數字/cm)
   DEFINE l_nw_pi           DECIMAL  #原始寬度(數字/pixel)
   DEFINE l_next_width      STRING
   DEFINE l_str             STRING
   DEFINE l_j              INTEGER

   
   LET l_width = g_header_wid
   LET l_width = l_width.trim(),"cm"
   
   LET l_nodes = p_rootnode.selectByTagName("WORDWRAPBOX")
   FOR l_i = 1 TO l_nodes.getLength()                                
      LET l_curnode=l_nodes.item(l_i)
      LET l_curname=l_curnode.getAttribute("name")
      IF l_curname.getIndexOf("_Label",1) > 0 THEN
         LET l_w_cm = 0
         LET l_w_pi = 0
         LET l_w_ori = l_curnode.getAttribute("width")
         LET l_str = l_w_ori.subString(l_w_ori.getLength()-1,l_w_ori.getLength())
         #DISPLAY "l_str:",l_str
         IF l_w_ori.subString(l_w_ori.getLength()-1,l_w_ori.getLength()) = "cm" THEN
            LET l_w_ori = l_w_ori.subString(1,l_w_ori.getLength()-2)
            LET l_w_cm  = l_w_ori
         ELSE
            LET l_w_pi = l_w_ori
         END IF

         IF (l_w_cm!=0 AND l_w_cm < 3) OR (l_w_pi!=0 AND l_w_pi < g_header_wid*28.35) THEN
            CALL l_curnode.setAttribute("width",l_width)
            IF l_w_cm!=0 THEN 
               LET l_less = g_header_wid - l_w_cm
               LET l_less_s = l_less
               LET l_less_s = l_less_s.trim(),"cm"
            ELSE
               LET l_less = g_header_wid*28.35 - l_w_pi   
            END IF

            LET l_parent = l_curnode.getParent()
            LET l_lastnode = l_parent.getLastChild()      

            LET l_nextnode = l_curnode.getNext()
            WHILE TRUE
               IF l_curnode = l_lastnode THEN EXIT WHILE END IF
               LET l_nextname = l_nextnode.getAttribute("name")
               IF l_nextname.getIndexOf("_Value",1) > 0 THEN
                  LET l_nw_ori = l_nextnode.getAttribute("width")
                  #DISPLAY "l_nw_ori:",l_nw_ori
                  IF l_nw_ori.subString(l_nw_ori.getLength()-1,l_nw_ori.getLength()) = "cm" THEN
                     LET l_nw_ori = l_nw_ori.subString(1,l_nw_ori.getLength()-2)
                     LET l_nw_cm = l_nw_ori
                     IF l_w_cm!=0 THEN
                        LET l_nw_cm = l_nw_cm - l_less
                     ELSE
                        LET l_nw_cm = l_nw_cm - l_less/28.35
                     END IF
                     IF l_nw_cm < 0 THEN LET l_nw_cm = 1 END IF
                     LET l_next_width = l_nw_cm
                     LET l_next_width = l_next_width.trim(),"cm"
                     #DISPLAY "l_next_width:",l_next_width
                     CALL l_nextnode.setAttribute("width",l_next_width)
                  ELSE
                     LET l_nw_pi = l_nw_ori
                     IF l_w_cm!=0 THEN
                        LET l_nw_pi = l_nw_pi - l_less*28.35
                     ELSE
                        LET l_nw_pi = l_nw_pi - l_less
                     END IF
                     IF l_nw_pi < 0 THEN LET l_nw_pi = 28.35 END IF
                     LET l_next_width = l_nw_pi
                     #DISPLAY "l_next_width:",l_next_width
                     CALL l_nextnode.setAttribute("width",l_next_width)               
                  END IF
                  EXIT WHILE
               ELSE
                  LET l_tmpnode = l_nextnode
                  IF l_tmpnode = l_lastnode THEN EXIT WHILE END IF
                  LET l_nextnode = l_tmpnode.getNext()
               END IF
             END WHILE
          END IF 
      END IF
      
   END FOR   
   
END FUNCTION
#161103-00051#1 add(e)
