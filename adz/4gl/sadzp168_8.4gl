#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 15/01/09
#
#+ 程式代碼......: sadzp168_8
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp168_8.4gl 
# Description    : 行業別畫面設計資料同步工具
# Memo           :

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"
GLOBALS "../4gl/adzi888_global.inc"

CONSTANT g_widget_group = "widget_group"                 #元件組合群組代碼前綴字元
CONSTANT g_patch_grid = "patch_grid"                     #單頭類型patch區塊

DEFINE g_gzzb001             LIKE gzzb_t.gzzb001         #行業畫面代碼
DEFINE g_gzzb003             LIKE gzzb_t.gzzb003         #[引用]的[標準畫面]代碼

DEFINE g_dzfi002_is          LIKE dzfi_t.dzfi002         #行業畫面最大版次
DEFINE g_dzfi002_sd          LIKE dzfi_t.dzfi002         #[引用]的[標準畫面]最大版次

DEFINE g_dzfi_patch_grid     type_g_dzfi                 #設計資料patch區塊
DEFINE g_dzfi009             LIKE dzfi_t.dzfi009         #客製標示='s'
DEFINE g_dzfi017             LIKE dzfi_t.dzfi017         #客戶代號
DEFINE g_error_message       STRING                      #錯誤訊息
DEFINE g_new_container       LIKE type_t.chr1            #是否為本次新增之container

PUBLIC FUNCTION sadzp168_8(p_gzzb001, p_dzfi002_is, p_gzzb003, p_dzfi002_sd)
   DEFINE p_gzzb001         LIKE gzzb_t.gzzb001         #行業畫面代碼
   DEFINE p_dzfi002_is      LIKE dzfi_t.dzfi002         #行業畫面最大版次
   DEFINE p_gzzb003         LIKE gzzb_t.gzzb003         #[引用]的[標準畫面]代碼
   DEFINE p_dzfi002_sd      LIKE dzfi_t.dzfi002         #[引用]的[標準畫面]最大版次

   DEFINE l_time_s          DATETIME YEAR TO SECOND     #FRACTION(4)
   DEFINE l_time_e          DATETIME YEAR TO SECOND     #FRACTION(4)
   DEFINE l_result          BOOLEAN
   DEFINE l_node            om.DomNode                  #4fd domNode
   DEFINE l_errcode         STRING
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   LET l_time_s = cl_get_current()
   DISPLAY "   Strat time : ", l_time_s, ASCII 10

   #建立畫面檔設計資料temp table
   CALL sadzp168_8_crate_temp_table()
   
   IF NOT sadzp168_8_init(p_gzzb001, p_dzfi002_is, p_gzzb003, p_dzfi002_sd) THEN
      DISPLAY g_error_message
      DISPLAY "Cannot initialize API."         #程式初始化失敗
      RETURN FALSE, g_error_message
   END IF

   IF NOT sadzp168_8_compare_structure() THEN
      DISPLAY "Merger failures."
      RETURN FALSE, g_error_message
   END IF

   UPDATE sadzp168_8_dzfi_is SET dzfi001 = g_gzzb001, dzfi002 = g_dzfi002_is, dzfi009 = g_dzfi009
   UPDATE sadzp168_8_dzfj_is SET dzfj001 = g_gzzb001, dzfj002 = g_dzfi002_is, dzfj017 = g_dzfi009
   UPDATE sadzp168_8_dzfk_is SET dzfk001 = g_gzzb001, dzfk002 = g_dzfi002_is, dzfk007 = g_dzfi009
   UPDATE sadzp168_8_dzfl_is SET dzfl001 = g_gzzb001, dzfl002 = g_dzfi002_is, dzfl007 = g_dzfi009

   #BEGIN WORK
   
   #刪除畫面代碼此客製版次的相關設計資訊
   IF NOT sadzp168_3_reload_delete(g_gzzb001, g_dzfi002_is, g_dzfi009) THEN
      DISPLAY "Delete failures."    #刪除失敗
      RETURN FALSE, g_error_message
   END IF
   
   INSERT INTO dzfi_t(dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
                      dzfi006, dzfi007, dzfi008, dzfi009, dzfi010,
                      dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
                      dzfi016, dzfistus, dzfi017)
     SELECT dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
            dzfi006, dzfi007, dzfi008, dzfi009, dzfi010,
            dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
            dzfi016, dzfistus, dzfi017 
       FROM sadzp168_8_dzfi_is

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfi_t:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-ins dzfi_t:", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      CALL sadzp168_8_drop_temp_table()
      #ROLLBACK WORK
      RETURN FALSE, g_error_message
   END IF
   
   INSERT INTO dzfj_t(dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
                      dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
                      dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
                      dzfj016, dzfjstus, dzfj017, dzfj018) 
     SELECT dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
            dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
            dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
            dzfj016, dzfjstus, dzfj017, dzfj018 
        FROM sadzp168_8_dzfj_is

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfj_t:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-ins dzfj_t:", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      CALL sadzp168_8_drop_temp_table()
      #ROLLBACK WORK
      RETURN FALSE, g_error_message
   END IF
   
   INSERT INTO dzfk_t(dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
                      dzfk006, dzfk007, dzfk008, dzfk009)
     SELECT dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
            dzfk006, dzfk007, dzfk008, dzfk009 
        FROM sadzp168_8_dzfk_is

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfk_t:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-ins dzfk_t:", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      CALL sadzp168_8_drop_temp_table()
      #ROLLBACK WORK
      RETURN FALSE, g_error_message
   END IF
   
  INSERT INTO dzfl_t(dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, 
                     dzfl006, dzflstus, dzfl007, dzfl008)
     SELECT dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, 
            dzfl006, dzflstus, dzfl007, dzfl008
        FROM sadzp168_8_dzfl_is

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfl_t:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-ins dzfl_t:", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      CALL sadzp168_8_drop_temp_table()
      #ROLLBACK WORK
      RETURN FALSE, g_error_message
   END IF
   
   CALL sadzp168_8_drop_temp_table()

   #COMMIT WORK
   
   LET l_time_e = cl_get_current()
   DISPLAY ASCII 10, ASCII 10, "    End  time : ", l_time_e
   DISPLAY "    Cost time : ", l_time_e - l_time_s

   LET g_error_message = ""
   RETURN TRUE, ""
END FUNCTION

#+ drop temp table
PRIVATE FUNCTION sadzp168_8_drop_temp_table()
   DROP TABLE sadzp168_8_dzfi_sd
   DROP TABLE sadzp168_8_dzfi_is
   
   DROP TABLE sadzp168_8_dzfj_sd
   DROP TABLE sadzp168_8_dzfj_is

   DROP TABLE sadzp168_8_dzfk_is
   DROP TABLE sadzp168_8_dzfl_is
      
END FUNCTION

#+ 建立temp table
PRIVATE FUNCTION sadzp168_8_crate_temp_table()

   #Create temp table 引用的[標準畫面]結構設計資料暫存檔
   CREATE TEMP TABLE sadzp168_8_dzfi_sd
   (
      dzfi001       VARCHAR(20),   #結構代號
      dzfi002       INTEGER,       #版次
      dzfi003       INTEGER,       #流水號
      dzfi004       VARCHAR(40),   #群組代碼
      dzfi005       INTEGER,       #順序編號
      dzfi006       VARCHAR(40),   #元件(組)代碼
      dzfi007       VARCHAR(20),   #節點類型
      dzfi008       VARCHAR(1),    #畫面顯示否
      dzfi009       VARCHAR(1),    #識別標示:s-標準產品, c-客製(PK)
      dzfi010       VARCHAR(1),    #元素類型
      dzfi011       VARCHAR(1),    #直橫排列
      dzfi012       INTEGER,       #節點階層
      dzfi013       INTEGER,       #群組X軸位置
      dzfi014       INTEGER,       #群組Y軸位置
      dzfi015       INTEGER,       #群組寬度
      dzfi016       INTEGER,       #群組長度
      dzfistus      VARCHAR(10),   #狀態碼
      dzfi017       VARCHAR(40)    #客戶代號
   );

   #Create temp table [行業畫面]結構設計資料暫存檔
   CREATE TEMP TABLE sadzp168_8_dzfi_is
   (
      dzfi001       VARCHAR(20),   #結構代號
      dzfi002       INTEGER,       #版次
      dzfi003       INTEGER,       #流水號
      dzfi004       VARCHAR(40),   #群組代碼
      dzfi005       INTEGER,       #順序編號
      dzfi006       VARCHAR(40),   #元件(組)代碼
      dzfi007       VARCHAR(20),   #節點類型
      dzfi008       VARCHAR(1),    #畫面顯示否
      dzfi009       VARCHAR(1),    #識別標示:s-標準產品, c-客製(PK)
      dzfi010       VARCHAR(1),    #元素類型
      dzfi011       VARCHAR(1),    #直橫排列
      dzfi012       INTEGER,       #節點階層
      dzfi013       INTEGER,       #群組X軸位置
      dzfi014       INTEGER,       #群組Y軸位置
      dzfi015       INTEGER,       #群組寬度
      dzfi016       INTEGER,       #群組長度
      dzfistus      VARCHAR(10),   #狀態碼
      dzfi017       VARCHAR(40)    #客戶代號
   );
   
   #Create temp table 引用的[標準畫面]元件組合設計資料暫存檔
   CREATE TEMP TABLE sadzp168_8_dzfj_sd
   (
      dzfj001       VARCHAR(20),   #結構代號
      dzfj002       INTEGER,       #版次
      dzfj003       VARCHAR(40),   #群組代碼
      dzfj004       INTEGER,       #順序編號
      dzfj005       VARCHAR(40),   #元件代碼
      dzfj006       VARCHAR(20),   #節點類型
      dzfj007       VARCHAR(20),   #所屬結構類型    
      dzfj008       VARCHAR(40),   #所屬結構代碼    
      dzfj009       VARCHAR(40),   #所屬結構標籤代碼
      dzfj010       VARCHAR(40),   #欄位標籤代碼    
      dzfj011       VARCHAR(40),   #參考欄位控件代號
      dzfj012       VARCHAR(1),    #是否為參考欄位  
      dzfj013       INTEGER,       #元件X軸位置
      dzfj014       INTEGER,       #元件Y軸位置
      dzfj015       INTEGER,       #元件寬度
      dzfj016       INTEGER,       #元件高度
      dzfjstus      VARCHAR(10),   #狀態碼
      dzfj017       VARCHAR(1),    #識別標示
      dzfj018       VARCHAR(40)    #客戶代號
   );

   #Create temp table [行業畫面]元件組合設計資料暫存檔
   CREATE TEMP TABLE sadzp168_8_dzfj_is
   (
      dzfj001       VARCHAR(20),   #結構代號
      dzfj002       INTEGER,       #版次
      dzfj003       VARCHAR(40),   #群組代碼
      dzfj004       INTEGER,       #順序編號
      dzfj005       VARCHAR(40),   #元件代碼
      dzfj006       VARCHAR(20),   #節點類型
      dzfj007       VARCHAR(20),   #所屬結構類型    
      dzfj008       VARCHAR(40),   #所屬結構代碼    
      dzfj009       VARCHAR(40),   #所屬結構標籤代碼
      dzfj010       VARCHAR(40),   #欄位標籤代碼    
      dzfj011       VARCHAR(40),   #參考欄位控件代號
      dzfj012       VARCHAR(1),    #是否為參考欄位  
      dzfj013       INTEGER,       #元件X軸位置
      dzfj014       INTEGER,       #元件Y軸位置
      dzfj015       INTEGER,       #元件寬度
      dzfj016       INTEGER,       #元件高度
      dzfjstus      VARCHAR(10),   #狀態碼
      dzfj017       VARCHAR(1),    #識別標示
      dzfj018       VARCHAR(40)    #客戶代號
   );
   
   #Create temp table [行業畫面]元件屬性資料暫存檔
   CREATE TEMP TABLE sadzp168_8_dzfk_is
   (
      dzfk001       VARCHAR(20),   #結構代號
      dzfk002       INTEGER,       #版次
      dzfk003       VARCHAR(40),   #元件代碼
      dzfk004       INTEGER,       #no use
      dzfk005       VARCHAR(40),   #no use
      dzfk006       VARCHAR(40),   #no use
      dzfk007       VARCHAR(1),    #識別標示
      dzfk008       VARCHAR(40),   #客戶代號
      dzfk009       TEXT           #屬性值
   );

   #Create temp table [行業畫面]元件屬性資料暫存檔
   CREATE TEMP TABLE sadzp168_8_dzfl_is
   (
      dzfl001       VARCHAR(20),   #結構代號
      dzfl002       INTEGER,       #版次
      dzfl003       VARCHAR(40),   #元件代碼
      dzfl004       INTEGER,       #順序編號
      dzfl005       VARCHAR(40),   #項目name
      dzfl006       VARCHAR(40),   #項目text
      dzflstus      VARCHAR(10),   #狀態碼
      dzfl007       VARCHAR(1),    #識別標示
      dzfl008       VARCHAR(40)    #客戶代號
   );

END FUNCTION

#+ 程式相關資料初始化
PRIVATE FUNCTION sadzp168_8_init(p_gzzb001, p_dzfi002_is, p_gzzb003, p_dzfi002_sd)
   DEFINE p_gzzb001         LIKE gzzb_t.gzzb001         #行業畫面代碼
   DEFINE p_dzfi002_is      LIKE dzfi_t.dzfi002         #行業畫面最大版次
   DEFINE p_gzzb003         LIKE gzzb_t.gzzb003         #[引用]的[標準畫面]代碼
   DEFINE p_dzfi002_sd      LIKE dzfi_t.dzfi002         #[引用]的[標準畫面]最大版次
   
   DEFINE l_sql             STRING
   DEFINE l_errcode         STRING
   DEFINE l_cnt             LIKE type_t.num5

   INITIALIZE g_dzfi_patch_grid TO NULL
   LET g_bgjob = "Y"

   IF cl_null(p_gzzb001) OR cl_null(p_dzfi002_is) OR p_dzfi002_is = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00497"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-init():", cl_getmsg("adz-00497", g_lang)
      RETURN FALSE
   END IF

   IF cl_null(p_gzzb003) OR cl_null(p_dzfi002_sd) OR p_dzfi002_sd = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00498"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-init():", cl_getmsg("adz-00498", g_lang)
      RETURN FALSE
   END IF
   
   LET g_gzzb001 = p_gzzb001
   LET g_gzzb003 = p_gzzb003
   LET g_dzfi002_is = p_dzfi002_is
   LET g_dzfi002_sd = p_dzfi002_sd
   LET g_dzfi009 = FGL_GETENV("DGENV")   #產中標準開發環境才會開發[行業別]程式("s")
   LET g_dzfi017 = FGL_GETENV("CUST")

   #行業別UI同步工具只限定在產中開發環境上使用
   IF g_dzfi009 <> "s" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00512"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg("adz-00512", g_lang)
      RETURN FALSE
   END IF
   
   #檢查設計資料是否存在
   SELECT COUNT(*) INTO l_cnt
     FROM dzfi_t
     WHERE dzfi001 = g_gzzb003 AND dzfi002 = g_dzfi002_sd AND dzfi009 = g_dzfi009

   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00499"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_gzzb003 CLIPPED
      LET g_errparam.replace[2] = g_dzfi002_sd USING "<<<<<"
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00499", g_lang, g_gzzb003 || "|" || g_dzfi002_sd USING "<<<<<")
      RETURN FALSE
   END IF

   SELECT COUNT(*) INTO l_cnt
     FROM dzfi_t
     WHERE dzfi001 = p_gzzb001 AND dzfi002 = p_dzfi002_is AND dzfi009 = g_dzfi009

   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00499"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_gzzb003 CLIPPED
      LET g_errparam.replace[2] = p_dzfi002_is USING "<<<<<"
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00499", g_lang, g_gzzb003 || "|" || p_dzfi002_is USING "<<<<<")
      RETURN FALSE
   END IF

   #########################畫面結構設計資料(dzfi_t)#########################   
   INSERT INTO sadzp168_8_dzfi_sd
     SELECT dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
            dzfi006, dzfi007, dzfi008, dzfi009, dzfi010,
            dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
            dzfi016, dzfistus, dzfi017 
       FROM dzfi_t
       WHERE dzfi001 = g_gzzb003 AND dzfi002 = g_dzfi002_sd AND dzfi009 = g_dzfi009

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfi_sd:', g_gzzb003 CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-init()-ins sadzp168_8_dzfi_sd.", g_gzzb003 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF
                   
   #取得原行業畫面結構設計資料(取得客製畫面的最大版次設計資料)
   INSERT INTO sadzp168_8_dzfi_is
     SELECT dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
            dzfi006, dzfi007, dzfi008, dzfi009, dzfi010,
            dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
            dzfi016, dzfistus, dzfi017  
       FROM dzfi_t
       WHERE dzfi001 = g_gzzb001 AND dzfi002 = g_dzfi002_is AND dzfi009 = g_dzfi009

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfi_is:', g_gzzb003 CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-init()-ins sadzp168_8_dzfi_is.", g_gzzb001 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF
   
   #取得引用之畫面結構設計資料
   LET l_sql = "SELECT * FROM sadzp168_8_dzfi_sd ",
               "  ORDER BY dzfi003"
      
   PREPARE sadzp168_8_dzfi_sd FROM l_sql
   DECLARE sadzp168_8_dzfi_sd_cs CURSOR FOR sadzp168_8_dzfi_sd

   OPEN sadzp168_8_dzfi_sd_cs
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "OPEN sadzp168_8_dzfi_sd_cs:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-init()-OPEN sadzp168_8_dzfi_sd_cs:", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      CLOSE sadzp168_8_dzfi_sd_cs
      RETURN FALSE
   END IF

   
     
   #########################畫面元件組合設計資料(dzfj_t)#########################   
   #取得引用之畫面元件組合設計資料
   INSERT INTO sadzp168_8_dzfj_sd
     SELECT dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
            dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
            dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
            dzfj016, dzfjstus, dzfj017, dzfj018 
        FROM dzfj_t
        WHERE dzfj001 = g_gzzb003 AND dzfj002 = g_dzfi002_sd AND dzfj017 = g_dzfi009

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins dzfj_sd:"
      LET g_errparam.popup = TRUE
      CALL cl_err()      
      LET g_error_message = "ERROR-init()-ins sadzp168_8_dzfj_sd.", g_gzzb003 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   #取得原行業畫面元件組合設計資料
   INSERT INTO sadzp168_8_dzfj_is
     SELECT dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
            dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
            dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
            dzfj016, dzfjstus, dzfj017, dzfj018 
        FROM dzfj_t
        WHERE dzfj001 = g_gzzb001 AND dzfj002 = g_dzfi002_is AND dzfj017 = g_dzfi009

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins dzfj_is:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-init()-ins sadzp168_8_dzfj_is.", g_gzzb001 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   #取得引用之畫面元件組合設計資料
   LET l_sql = "SELECT * FROM sadzp168_8_dzfj_sd ",
               "  WHERE dzfj003 = ? ",
               "  ORDER BY dzfj004"
      
   PREPARE sadzp168_8_dzfj_sd FROM l_sql
   DECLARE sadzp168_8_dzfj_sd_cs CURSOR FOR sadzp168_8_dzfj_sd



   #########################畫面元件屬性設計資料(dzfk_t)#########################   
   #取得原行業畫面元件屬性設計資料
   INSERT INTO sadzp168_8_dzfk_is
     SELECT dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
            dzfk006, dzfk007, dzfk008, dzfk009
        FROM dzfk_t
        WHERE dzfk001 = g_gzzb001 AND dzfk002 = g_dzfi002_is AND dzfk007 = g_dzfi009 

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins dzfk_is:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-init()-ins sadzp168_8_dzfk_is.", g_gzzb001 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   #########################畫面元件資料項目設計資料(dzfl_t)#########################   
   #取得原行業畫面元件資料項目設計資料
   INSERT INTO sadzp168_8_dzfl_is
     SELECT dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, 
            dzfl006, dzflstus, dzfl007, dzfl008
        FROM dzfl_t
        WHERE dzfl001 = g_gzzb001 AND dzfl002 = g_dzfi002_is AND dzfl007 = g_dzfi009

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins dzfl_is:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-init()-ins sadzp168_8_dzfl_is.", g_gzzb001 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   


   #########################比對單頭元件群組設計資料(dzfj_t)#########################
   #取得引用之畫面參考點(比對點)元件組合設計資料
   LET l_sql = "SELECT * FROM sadzp168_8_dzfj_sd ",
               "  WHERE dzfj003 = (SELECT dzfi006 FROM sadzp168_8_dzfi_sd ",
               "                     WHERE dzfi004 = ? AND dzfi005 = ? ) ",
               "  ORDER BY dzfj004"
   
   PREPARE sadzp168_8_group_ref FROM l_sql
   DECLARE sadzp168_8_group_ref_cs CURSOR FOR sadzp168_8_group_ref




   #########################同一個Container下的元件群組設計資料(sadzp168_8_dzfi_is)##############################################
   #取得目前merge階段同一個Container下的元件群組設計資料
   LET l_sql = "SELECT dzfi006, dzfi010 FROM sadzp168_8_dzfi_is ",
               "  WHERE dzfi004 = ? ",
               "  ORDER BY dzfi005"
   
   PREPARE sadzp168_8_dzfi006_group FROM l_sql
   DECLARE sadzp168_8_dzfi006_group_cs CURSOR FOR sadzp168_8_dzfi006_group

   #########################取得同一組[元件組代碼]下的[畫面元件組合檔]widget設計資料(sadzp168_8_dzfj_sd)#########################
   LET l_sql = "SELECT dzfj003, dzfj004, dzfj005, dzfj013, dzfj014, (dzfj013+dzfj015), (dzfj014+dzfj016) ",
               "  FROM sadzp168_8_dzfj_sd ",
               "  WHERE dzfj003 = ? ",
               "  ORDER BY dzfj004"
   
   PREPARE sadzp168_8_dzfj003_group FROM l_sql
   DECLARE sadzp168_8_dzfj003_group_cs CURSOR FOR sadzp168_8_dzfj003_group

   RETURN TRUE
END FUNCTION

#+ 新舊畫面結構比較
PRIVATE FUNCTION sadzp168_8_compare_structure()
   DEFINE l_dzfi            type_g_dzfi            #畫面結構檔
   DEFINE l_cnt             LIKE type_t.num5     
   DEFINE l_dzfi_relative   type_g_dzfi            #新設計資料需加入在原行業畫面結構中的相對位置節點
   DEFINE l_errcode         STRING
   
   #利用引用之結構資料為基礎
   FOREACH sadzp168_8_dzfi_sd_cs INTO l_dzfi.*
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH sadzp168_8_dzfi_sd_cs:', l_dzfi.dzfi006 CLIPPED
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-compare_structure()-FOREACH sadzp168_8_dzfi_sd_cs.", l_dzfi.dzfi006 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
         RETURN FALSE
      END IF

      LET l_cnt = 0
      LET g_new_container = FALSE

      #排除未引用的畫面UI container代碼不merge回設計資訊(dzft004='0')
      SELECT COUNT(*) INTO l_cnt FROM dzft_t
        WHERE dzft001 = l_dzfi.dzfi001
          AND dzft002 = l_dzfi.dzfi006
          AND dzft003 = g_dzfi009
          AND dzft004 = '0'

      IF l_cnt > 0 THEN
         CONTINUE FOREACH
      END IF

      #取得引用之結構設計資料是否存在原行業畫面中
      SELECT COUNT(*) INTO l_cnt FROM sadzp168_8_dzfi_is
        WHERE dzfi006 = l_dzfi.dzfi006

      #引用之設計資料不存在原行業畫面結構中時,需新增此筆設計資料
      IF l_cnt = 0 AND (l_dzfi.dzfi010 = "0" OR l_dzfi.dzfi010 = "1") THEN        
      
         #先往上尋找在原行業畫面結構中要加入之節點是否有可參考的依據
         CALL sadzp168_8_previous_node(l_dzfi.*)
            RETURNING l_dzfi_relative.*

         #往上尋找不到參考點時,就往下尋找參考點方式
         IF cl_null(l_dzfi_relative.dzfi006) THEN
            CALL sadzp168_8_next_node(l_dzfi.*)
               RETURNING l_dzfi_relative.*

            #找到參考點時,新增此筆設計資料至相對位置
            IF NOT cl_null(l_dzfi_relative.dzfi006) THEN
               #此筆設計資料取代此參考點順序位置,並將參考點順序往下排序
               IF NOT sadzp168_8_add_structure(l_dzfi.*, l_dzfi_relative.*, "N") THEN
                  RETURN FALSE
               END IF
            ELSE
               #全新的一筆設計資料
               IF NOT sadzp168_8_add_structure(l_dzfi.*, l_dzfi_relative.*, "A") THEN
                  RETURN FALSE
               END IF
            END IF
         ELSE
            #此筆設計資料加入在參考點下一個順序位置
            IF NOT sadzp168_8_add_structure(l_dzfi.*, l_dzfi_relative.*, "P") THEN
               RETURN FALSE
            END IF
         END IF
      END IF
      
      #元件組合處理
      IF l_dzfi.dzfi010 = "3" THEN
         IF NOT sadzp168_8_compare_widget(l_dzfi.*) THEN
            RETURN FALSE
         END IF
      END IF
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 在引用之畫面結構設計資料中往上尋找上一個節點位置,並取得在原行業畫面結構中相符合的節點
PRIVATE FUNCTION sadzp168_8_previous_node(p_dzfi)
   DEFINE p_dzfi            type_g_dzfi            #畫面結構檔

   DEFINE l_dzfi_previous   type_g_dzfi            #引用之畫面上一個節點設計資料
   DEFINE r_dzfi            type_g_dzfi            #原行業畫面可加入新設計資料的節點位置

   INITIALIZE l_dzfi_previous TO NULL
   INITIALIZE r_dzfi TO NULL

   #此元件群組的序號已經為 NULL時
   #表示原行業畫面結構設計資料中無存在此筆新的設計資料參考點
   IF cl_null(p_dzfi.dzfi006) THEN
      RETURN r_dzfi.*
   END IF
   
   #取得上一個節點位置
   SELECT * INTO l_dzfi_previous.* FROM sadzp168_8_dzfi_sd
     WHERE dzfi004 = p_dzfi.dzfi004 
       AND dzfi005 = p_dzfi.dzfi005 - 1 
     
   #取得原行業畫面結構中是否有相符合的節點
   IF NOT cl_null(l_dzfi_previous.dzfi006) THEN
      #只需要Container名稱一致即可,不用管它已經移到那個父節點下
      SELECT * INTO r_dzfi.* FROM sadzp168_8_dzfi_is
        WHERE dzfi006 = l_dzfi_previous.dzfi006
   ELSE
      RETURN r_dzfi.*
   END IF

   #已取得參考點時直接回傳此參考點設計資料
   #如果沒有找到繼續往上尋找
   IF NOT cl_null(r_dzfi.dzfi006) THEN
      RETURN r_dzfi.*
   ELSE
      CALL sadzp168_8_previous_node(l_dzfi_previous.*)
         RETURNING r_dzfi.*
   END IF

   IF NOT cl_null(r_dzfi.dzfi006) THEN
      RETURN r_dzfi.*
   ELSE
      INITIALIZE r_dzfi TO NULL
      RETURN r_dzfi.*
   END IF
END FUNCTION

#+ 在引用之畫面結構設計資料中往上尋找下一個節點位置,並取得在原行業畫面結構中相符合的節點
PRIVATE FUNCTION sadzp168_8_next_node(p_dzfi)
   DEFINE p_dzfi            type_g_dzfi            #畫面結構檔

   DEFINE l_dzfi_next       type_g_dzfi            #引用之畫面上一個節點設計資料
   DEFINE r_dzfi            type_g_dzfi            #原行業畫面可加入新設計資料的節點位置

   INITIALIZE l_dzfi_next TO NULL
   INITIALIZE r_dzfi TO NULL

   #此元件群組的序號已經為 NULL時
   #表示原行業畫面結構設計資料中無存在此筆新的設計資料參考點
   IF cl_null(p_dzfi.dzfi006) THEN
      RETURN r_dzfi.*
   END IF
   
   #取得下一個節點位置
   SELECT * INTO l_dzfi_next.* FROM sadzp168_8_dzfi_sd
     WHERE dzfi004 = p_dzfi.dzfi004 
       AND dzfi005 = p_dzfi.dzfi005 + 1 

   #取得原行業畫面結構中是否有相符合的節點
   IF NOT cl_null(l_dzfi_next.dzfi006) THEN
      #只需要Container名稱一致即可,不用管它已經移到那個父節點下
      SELECT * INTO r_dzfi.* FROM sadzp168_8_dzfi_is
        WHERE dzfi006 = l_dzfi_next.dzfi006
   ELSE
      RETURN r_dzfi.*
   END IF

   #已取得參考點時直接回傳此參考點設計資料
   #如果沒有找到繼續往下尋找
   IF NOT cl_null(r_dzfi.dzfi006) THEN
      RETURN r_dzfi.*
   ELSE
      CALL sadzp168_8_next_node(l_dzfi_next.*)
         RETURNING r_dzfi.*
   END IF

   IF NOT cl_null(r_dzfi.dzfi006) THEN
      RETURN r_dzfi.*
   ELSE
      INITIALIZE r_dzfi TO NULL
      RETURN r_dzfi.*
   END IF
END FUNCTION

#+ 在原行業畫面結構設計資料中新增引用之畫面結構設計資料,並將序號往下加1
PRIVATE FUNCTION sadzp168_8_add_structure(p_dzfi, p_dzfi_relative, p_add_mode)
   DEFINE p_dzfi            type_g_dzfi            #新結構檔(Container)設計資料
   DEFINE p_dzfi_relative   type_g_dzfi            #新設計資料需加入在原行業畫面結構中的相對位置節點
   DEFINE p_add_mode        LIKE type_t.chr10      #新節點加入模式
   
   DEFINE l_dzfi_ins        type_g_dzfi            #新增至DB的Container設計資料
   DEFINE l_dzfi003         LIKE dzfi_t.dzfi003    #節點設計資料ID 
   DEFINE l_dzfi004         LIKE dzfi_t.dzfi004    #群組代碼
   DEFINE l_dzfi005         LIKE dzfi_t.dzfi005    #同群組內順序編號
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_layout          LIKE type_t.chr1       #是否有正確Layout
   DEFINE l_errcode         STRING

   #add mode:(1)P:參考點在上方位置 
   #         (2)N:參考點在下方位置 
   #         (3)A:無任何參考點(為新的一筆設計資料,直接加入在父節點下的第一筆節點)--目前在CASE中不做任何處理
   CASE p_add_mode
      WHEN "P"   #往上取得參考節點方式(採下一節點插入方式)
         #檢查[新增的Container]與參考的[相對位置Container]是否有用Layout(HBox或VBox)包起來
         CALL sadzp168_8_check_layout(p_dzfi.*, p_dzfi_relative.*, p_add_mode)
            RETURNING l_layout, l_dzfi004, l_dzfi005

         #正常Layout下,都採用參考的[相對位置Container]設計資料
         IF l_layout THEN
            UPDATE sadzp168_8_dzfi_is SET dzfi005 = (dzfi005 + 1)
              WHERE dzfi004 = p_dzfi_relative.dzfi004 
                AND dzfi005 > p_dzfi_relative.dzfi005
             
            IF SQLCA.sqlcode THEN
               LET l_errcode = SQLCA.sqlcode
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00517"
               LET g_errparam.extend = "upd add_structure().dzfi_is_P:"
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = p_dzfi_relative.dzfi004 CLIPPED
               CALL cl_err()
               LET g_error_message = "ERROR-add_structure()-upd P:sadzp168_8_dzfi_is.", p_dzfi_relative.dzfi004 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
               DISPLAY g_error_message
               RETURN FALSE
            END IF

            LET l_dzfi004 = p_dzfi_relative.dzfi004
            LET l_dzfi005 = p_dzfi_relative.dzfi005 + 1
         END IF
         
      WHEN "N"   #往下取得參考節點方式(採直接由此節點插入方式)
         #檢查[新增的Container]與參考的[相對位置Container]是否有用Layout(HBox或VBox)包起來
         CALL sadzp168_8_check_layout(p_dzfi.*, p_dzfi_relative.*, p_add_mode)
            RETURNING l_layout, l_dzfi004, l_dzfi005

         #正常Layout下,都採用參考的[相對位置Container]設計資料
         IF l_layout THEN
            UPDATE sadzp168_8_dzfi_is SET dzfi005 = (dzfi005 + 1)
              WHERE dzfi004 = p_dzfi_relative.dzfi004 
                AND dzfi005 >= p_dzfi_relative.dzfi005

            IF SQLCA.sqlcode THEN
               LET l_errcode = SQLCA.sqlcode
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00517"
               LET g_errparam.extend = "upd add_structure().dzfi_is_N:"
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = p_dzfi_relative.dzfi004 CLIPPED
               CALL cl_err()
               LET g_error_message = "ERROR-add_structure()-upd N:sadzp168_8_dzfi_is.", p_dzfi_relative.dzfi004 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
               DISPLAY g_error_message
               RETURN FALSE
            END IF

            LET l_dzfi004 = p_dzfi_relative.dzfi004
            LET l_dzfi005 = p_dzfi_relative.dzfi005
         END IF
         
      OTHERWISE
         #全新的一筆container設計資料,節點順序採用[引用]之畫面結構順序
         #父節點採用[引用]之畫面(因父節點在merge架構中,一定會先被加入[原行業]畫面上)
         #因此將原[行業]畫面的此父節點下之子節點順序往後+1
         UPDATE sadzp168_8_dzfi_is SET dzfi005 = (dzfi005 + 1)
           WHERE dzfi004 = p_dzfi.dzfi004
             AND dzfi005 >= p_dzfi.dzfi005

         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00517"
            LET g_errparam.extend = "upd add_structure().dzfi_is_A:"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = p_dzfi.dzfi004 CLIPPED
            CALL cl_err()
            LET g_error_message = "ERROR-add_structure()-upd A:sadzp168_8_dzfi_is.", p_dzfi.dzfi004 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            DISPLAY g_error_message
            RETURN FALSE
         END IF

         LET l_dzfi004 = p_dzfi.dzfi004
         LET l_dzfi005 = p_dzfi.dzfi005
   END CASE

   IF cl_null(l_dzfi004) THEN
      LET l_dzfi004 = p_dzfi.dzfi004
   END IF
   
   #新增此筆引用之畫面結構設計資料
   LET l_dzfi_ins.dzfi001 = p_dzfi.dzfi001 CLIPPED
   LET l_dzfi_ins.dzfi002 = g_dzfi002_is
   #LET l_dzfi_ins.dzfi003 = l_dzfi003 + 1
   LET l_dzfi_ins.dzfi004 = l_dzfi004
   LET l_dzfi_ins.dzfi005 = l_dzfi005   
   LET l_dzfi_ins.dzfi006 = p_dzfi.dzfi006
   LET l_dzfi_ins.dzfi007 = p_dzfi.dzfi007
   LET l_dzfi_ins.dzfi008 = p_dzfi.dzfi008
   #LET l_dzfi_ins.dzfi009 = p_dzfi.dzfi009
   LET l_dzfi_ins.dzfi010 = p_dzfi.dzfi010
   LET l_dzfi_ins.dzfi011 = p_dzfi.dzfi011

   CALL sadzp168_8_ins_dzfi(l_dzfi_ins.*)
      RETURNING l_success, l_dzfi_ins.*

   IF NOT l_success THEN
      RETURN FALSE
   END IF

   #已在此本版次內新增了一個Container
   LET g_new_container = TRUE
   RETURN TRUE
END FUNCTION

#+ 新舊畫面元件組合設計資料比較
PRIVATE FUNCTION sadzp168_8_compare_widget(p_dzfi)
   DEFINE p_dzfi               type_g_dzfi            #畫面結構檔
   
   DEFINE l_dzfj003            LIKE dzfj_t.dzfj003    #元件組合群組代碼
   DEFINE l_dzfi004            LIKE dzfi_t.dzfi004    #container群組代碼
   
   DEFINE l_dzfj               type_g_dzfj            #元件組合檔
   DEFINE l_cnt                LIKE type_t.num5     
   DEFINE l_dzfj_relative      type_g_dzfj            #新widget需加入在原行業畫面結構中的相對位置節點
   DEFINE l_dzfi_relative      type_g_dzfi            #參考點所屬的元件組合檔
   DEFINE l_dzfi005_max        LIKE dzfi_t.dzfi005    #畫面結構群組的最大序號
   DEFINE l_errcode            STRING
   
   INITIALIZE l_dzfj_relative TO NULL
   INITIALIZE l_dzfi_relative TO NULL
   
   #取得指定的元件組合代碼下所有widget結構
   OPEN sadzp168_8_dzfj_sd_cs USING p_dzfi.dzfi006
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "OPEN sadzp168_8_dzfj_sd_cs:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-compare_widget()-OPEN sadzp168_8_dzfj_sd_cs:", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      CLOSE sadzp168_8_dzfj_sd_cs
      RETURN FALSE
   END IF
   
   #利用新元件組合資料為基礎
   FOREACH sadzp168_8_dzfj_sd_cs INTO l_dzfj.*
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzp168_8_dzfj_sd_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-compare_widget()-FOREACH sadzp168_8_dzfj_sd_cs.", l_dzfj.dzfj005 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
         DISPLAY g_error_message
         RETURN FALSE
      END IF

      LET l_dzfi_relative.dzfi005 = 0
      
      LET l_cnt = 0
      
      #排除畫面UI元件失效檔內的widget代碼不merge回設計資訊
      SELECT COUNT(*) INTO l_cnt FROM dzft_t
        WHERE dzft001 = l_dzfj.dzfj001
          AND dzft002 = l_dzfj.dzfj005
          AND dzft003 = g_dzfi009
          AND dzft004 = '1'

      IF l_cnt > 0 THEN
         CONTINUE FOREACH
      END IF

      #取得引用之結構設計資料是否存在原行業中
      SELECT COUNT(*) INTO l_cnt FROM sadzp168_8_dzfj_is
        WHERE dzfj005 = l_dzfj.dzfj005
     
      IF l_cnt = 0 THEN
         #取得Container內是否有存在[控件高度 > 2]的widget
         IF sadzp168_8_check_height(p_dzfi.dzfi004, l_dzfj.*) THEN
            IF NOT sadzp168_8_add_widget_patch(l_dzfj.*) THEN
               RETURN FALSE
            END IF

            CONTINUE FOREACH
         END IF
         
         #先往上尋找在原行業元件組合資料中要加入之節點是否有可參考的依據
         CALL sadzp168_8_previous_widget(l_dzfj.*)
            RETURNING l_dzfj_relative.*

         #往上尋找不到參考點時,就往下尋找參考點方式
         IF cl_null(l_dzfj_relative.dzfj005) THEN
            CALL sadzp168_8_next_widget(l_dzfj.*)
               RETURNING l_dzfj_relative.*

            #找到參考點時,新增此筆設計資料至相對位置
            IF NOT cl_null(l_dzfj_relative.dzfj005) THEN
               #取得參考點所屬Container代碼
               LET l_dzfi004 = sadzp168_8_get_container(l_dzfj_relative.dzfj003)
               IF cl_null(l_dzfi004) THEN
                  RETURN FALSE
               END IF
               
               #此筆設計資料取代此參考點順序位置,並將參考點順序往下排序
               IF NOT sadzp168_8_add_widget(l_dzfi004, l_dzfj.*, l_dzfj_relative.*, "SG_N", l_dzfi_relative.*) THEN
                  RETURN FALSE
               END IF
            END IF
         ELSE
            #取得參考點所屬Container代碼
            LET l_dzfi004 = sadzp168_8_get_container(l_dzfj_relative.dzfj003)
            IF cl_null(l_dzfi004) THEN
               RETURN FALSE
            END IF
               
            #此筆設計資料加入在參考點下一個順序位置
            IF NOT sadzp168_8_add_widget(l_dzfi004, l_dzfj.*, l_dzfj_relative.*, "SG_P", l_dzfi_relative.*) THEN
               RETURN FALSE
            END IF
         END IF

         #單頭排列方式--全新的一筆控件(widget)設計資料,需再依元件群組比對上下排列關係
         #(表示在同一個Y軸情況下,找不到參考點:所以繼續往上一排/往下一排(不同Y軸)尋找參考點位置
         IF cl_null(l_dzfj_relative.dzfj005) THEN
            #先往上一排(上一個Y軸)尋找在原行業畫面結構中要加入之節點是否有可參考的依據
            CALL sadzp168_8_previous_group(p_dzfi.dzfi004, p_dzfi.dzfi005)
               RETURNING l_dzfi_relative.*
               
            IF l_dzfi_relative.dzfi005 = 0 THEN
               #取得此元件群組的序號最大值
               LET l_dzfi005_max = 0
               SELECT MAX(dzfi005) INTO l_dzfi005_max FROM sadzp168_8_dzfi_sd
                 WHERE dzfi004 = p_dzfi.dzfi004

               #往上尋找不到參考點時,就往下一排(下一個Y軸)尋找參考點方式
               CALL sadzp168_8_next_group(p_dzfi.dzfi004, p_dzfi.dzfi005, l_dzfi005_max)
                  RETURNING l_dzfi_relative.*

               IF l_dzfi_relative.dzfi005 <> 0 THEN
                  IF NOT sadzp168_8_add_widget(l_dzfi_relative.dzfi004, l_dzfj.*, l_dzfj_relative.*, "DG_N", l_dzfi_relative.*) THEN
                     RETURN FALSE
                  END IF
               ELSE
                  #都找不到參考點時,視為全新的一筆控件(widget)設計資料,直接加入成Container的最後一筆
                  #此時元件組合檔(dzfi_t)的參考組合檔就視為本筆Container設計資料(p_dzfi)
                  LET l_dzfi_relative.* = p_dzfi.*
                  IF NOT sadzp168_8_add_widget(p_dzfi.dzfi004, l_dzfj.*, l_dzfj_relative.*, "A", l_dzfi_relative.*) THEN
                     RETURN FALSE
                  END IF
               END IF
            
            ELSE
               IF NOT sadzp168_8_add_widget(l_dzfi_relative.dzfi004, l_dzfj.*, l_dzfj_relative.*, "DG_P", l_dzfi_relative.*) THEN
                  RETURN FALSE
               END IF
            END IF            
         END IF
      END IF
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 在引用之畫面元件組合設計資料中往上尋找上一個節點位置,並取得在原行業畫面元件組合中相符合的節點
PRIVATE FUNCTION sadzp168_8_previous_widget(p_dzfj)
   DEFINE p_dzfj            type_g_dzfj            #畫面元件組合檔

   DEFINE l_dzfj_previous   type_g_dzfj            #引用之畫面上一個節點設計資料
   DEFINE r_dzfj            type_g_dzfj            #原行業畫面可加入新設計資料的節點位置

   INITIALIZE l_dzfj_previous TO NULL
   INITIALIZE r_dzfj TO NULL

   #此元件組合的序號已經為 NULL時
   #表示原行業畫面元件組合設計資料中無存在此筆新的設計資料參考點
   IF cl_null(p_dzfj.dzfj005) THEN
      RETURN r_dzfj.*
   END IF
   
   #取得上一個節點位置
   SELECT * INTO l_dzfj_previous.* FROM sadzp168_8_dzfj_sd
     WHERE dzfj003 = p_dzfj.dzfj003 
       AND dzfj004 = p_dzfj.dzfj004 - 1 
     
   #取得原行業畫面元件組合中是否有相符合的節點
   IF NOT cl_null(l_dzfj_previous.dzfj005) THEN
      SELECT * INTO r_dzfj.* FROM sadzp168_8_dzfj_is
        WHERE dzfj005 = l_dzfj_previous.dzfj005
   ELSE
      RETURN r_dzfj.*
   END IF

   IF NOT cl_null(r_dzfj.dzfj005) THEN
      RETURN r_dzfj.*
   ELSE
      CALL sadzp168_8_previous_widget(l_dzfj_previous.*)
         RETURNING r_dzfj.*
   END IF

   IF NOT cl_null(r_dzfj.dzfj005) THEN
      RETURN r_dzfj.*
   ELSE
      INITIALIZE r_dzfj TO NULL
      RETURN r_dzfj.*
   END IF
END FUNCTION

#+ 在引用之畫面元件組合設計資料中往上尋找下一個節點位置,並取得在原行業畫面元件組合中相符合的節點
PRIVATE FUNCTION sadzp168_8_next_widget(p_dzfj)
   DEFINE p_dzfj            type_g_dzfj            #畫面元件組合檔

   DEFINE l_dzfj_next       type_g_dzfj            #引用之畫面上一個節點設計資料
   DEFINE r_dzfj            type_g_dzfj            #原行業畫面可加入新設計資料的節點位置

   INITIALIZE l_dzfj_next TO NULL
   INITIALIZE r_dzfj TO NULL
   
   #此元件組合的序號已經為 NULL時
   #表示原行業畫面元件組合設計資料中無存在此筆新的設計資料參考點
   IF cl_null(p_dzfj.dzfj005) THEN
      RETURN r_dzfj.*
   END IF
   
   #取得下一個節點位置
   SELECT * INTO l_dzfj_next.* FROM sadzp168_8_dzfj_sd
     WHERE dzfj003 = p_dzfj.dzfj003 
       AND dzfj004 = p_dzfj.dzfj004 + 1 
     
   #取得原行業畫面元件組合中是否有相符合的節點
   IF NOT cl_null(l_dzfj_next.dzfj005) THEN
      SELECT * INTO r_dzfj.* FROM sadzp168_8_dzfj_is
        WHERE dzfj005 = l_dzfj_next.dzfj005
   ELSE
      RETURN r_dzfj.*
   END IF

   IF NOT cl_null(r_dzfj.dzfj005) THEN
      RETURN r_dzfj.*
   ELSE
      CALL sadzp168_8_next_widget(l_dzfj_next.*)
         RETURNING r_dzfj.*
   END IF

   IF NOT cl_null(r_dzfj.dzfj005) THEN
      RETURN r_dzfj.*
   ELSE
      INITIALIZE r_dzfj TO NULL
      RETURN r_dzfj.*
   END IF
END FUNCTION

#+ 在原行業畫面元件組合設計資料中新增引用之畫面元件組合設計資料,並將序號往下加1
PRIVATE FUNCTION sadzp168_8_add_widget(p_dzfi004, p_dzfj, p_dzfj_relative, p_add_mode, p_dzfi_relative)
   DEFINE p_dzfi004            LIKE dzfi_t.dzfi004    #新控件所屬Container群組代碼
   DEFINE p_dzfj               type_g_dzfj            #新控件(widget)設計資料
   DEFINE p_dzfj_relative      type_g_dzfj            #新設計資料需加入在原行業畫面元件組合中的相對位置節點
   DEFINE p_add_mode           LIKE type_t.chr10      #新節點加入模式(SG_P:同一群組前面參考點; SG_N:同一群組後面參考點; DG_P:上一個群組參考點; DG_N:下一個群組參考點)
   DEFINE p_dzfi_relative      type_g_dzfi            #參考點所屬的元件組合檔
   
   DEFINE l_dzfi_ins           type_g_dzfi            #畫面結構檔
   DEFINE l_dzfj_ins           type_g_dzfj            #新增至DB的widget設計資料
   
   DEFINE l_dzfj003            LIKE dzfj_t.dzfj003    #widget所屬群組
   DEFINE l_dzfj004            LIKE dzfj_t.dzfj004    #widget在群組下的順序位置
   DEFINE l_dzfi003            LIKE dzfi_t.dzfi003    #畫面結構設計資料ID 
   DEFINE l_dzfi005            LIKE dzfi_t.dzfi005    #畫面結構群組的最大序號
   DEFINE l_success            LIKE type_t.chr1
   DEFINE l_errcode            STRING

   INITIALIZE l_dzfi_ins TO NULL

   #add mode:(1)P:參考點在上方位置 
   #         (2)N:參考點在下方位置 
   #         (3)A:無任何參考點(為新的一筆設計資料,直接加入在父節點下的第一筆節點)
   CASE p_add_mode
      WHEN "SG_P"   #同一群組前面參考點:往上取得參考節點方式(採下一節點插入方式)
         #元件群組設計資料可直接插入原行業的元件組合檔
         #將要插入的節點序號往後加1
         UPDATE sadzp168_8_dzfj_is SET dzfj004 = (dzfj004 + 1)
           WHERE dzfj003 = p_dzfj_relative.dzfj003 
             AND dzfj004 > p_dzfj_relative.dzfj004

         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00517"
            LET g_errparam.extend = "upd add_widget().dzfj_is_SG_P:"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = p_dzfj_relative.dzfj003 CLIPPED
            CALL cl_err()
            LET g_error_message = "ERROR-add_widget()-upd SG_P:sadzp168_8_dzfj_is.", p_dzfj_relative.dzfj003 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            DISPLAY g_error_message
            RETURN FALSE
         END IF

         LET l_dzfj003 = p_dzfj_relative.dzfj003
         
         #此筆設計資料加入在參考點下一個順序位置
         LET l_dzfj004 = p_dzfj_relative.dzfj004 + 1

         CALL sadzp168_8_set_widget_pos(p_add_mode, p_dzfi004, "", p_dzfj.*, p_dzfj_relative.*)
            RETURNING l_success, p_dzfj.*
         
         IF NOT l_success THEN
            RETURN FALSE
         END IF

      WHEN "DG_P"   #往上已取得個群組的參考點:在參考群組下一個序號加入一組全新的元件群組設計資料
         UPDATE sadzp168_8_dzfi_is SET dzfi005 = (dzfi005 + 1)
           WHERE dzfi004 = p_dzfi_relative.dzfi004
             AND dzfi005 > p_dzfi_relative.dzfi005

         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00517"
            LET g_errparam.extend = "upd add_widget().dzfi_is_DG_P:"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = p_dzfi_relative.dzfi004 CLIPPED
            CALL cl_err()
            LET g_error_message = "ERROR-add_widget()-upd DG_P:sadzp168_8_dzfi_is.", p_dzfi_relative.dzfi004 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            DISPLAY g_error_message
            RETURN FALSE
         END IF
         
         CALL sadzp168_8_set_widget_pos(p_add_mode, p_dzfi004, p_dzfi_relative.dzfi006, p_dzfj.*, p_dzfj_relative.*)
            RETURNING l_success, p_dzfj.*
         
         IF NOT l_success THEN
            RETURN FALSE
         END IF

         #####insert 畫面結構檔資枓表#####
         LET l_dzfi_ins.dzfi001 = p_dzfi_relative.dzfi001 CLIPPED
         #LET l_dzfi_ins.dzfi002 = 2
         #LET l_dzfi_ins.dzfi003 = l_dzfi003 + 1
         LET l_dzfi_ins.dzfi004 = p_dzfi_relative.dzfi004                            #群組代碼
         LET l_dzfi_ins.dzfi005 = p_dzfi_relative.dzfi005 + 1                        #順序
         #LET l_dzfi_ins.dzfi006 = g_widget_group, l_dzfi_ins.dzfi003 USING "<<<<<"   #元件(組)代碼 
         LET l_dzfi_ins.dzfi006 = ""                                                 #元件(組)代碼 
         LET l_dzfi_ins.dzfi007 = ""                                                 #節點類型
         LET l_dzfi_ins.dzfi008 = "Y"                                                #畫面結構中是否顯示
         #LET l_dzfi_ins.dzfi009 = ""
         LET l_dzfi_ins.dzfi010 = "3"                                                #包含元素類型3.Widget 
         LET l_dzfi_ins.dzfi011 = ""                                                 #直橫排列V/H

         CALL sadzp168_8_ins_dzfi(l_dzfi_ins.*)
            RETURNING l_success, l_dzfi_ins.*

         IF NOT l_success THEN
            RETURN FALSE
         END IF

         LET l_dzfj003 = l_dzfi_ins.dzfi006
         LET l_dzfj004 = 1



      WHEN "SG_N"   #同一群組後面參考點:往下取得參考節點方式(採直接由此節點插入方式)
         #元件群組設計資料可直接插入原行業的元件組合檔
         #將要插入的節點序號往後加1
         UPDATE sadzp168_8_dzfj_is SET dzfj004 = (dzfj004 + 1)
           WHERE dzfj003 = p_dzfj_relative.dzfj003 
             AND dzfj004 >= p_dzfj_relative.dzfj004
             
         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00517"
            LET g_errparam.extend = "upd add_widget().dzfj_is_SG_N:"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = p_dzfj_relative.dzfj003 CLIPPED
            CALL cl_err()
            LET g_error_message = "ERROR-add_widget()-upd SG_N:sadzp168_8_dzfj_is.", p_dzfj_relative.dzfj003 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            DISPLAY g_error_message
            RETURN FALSE
         END IF

         LET l_dzfj003 = p_dzfj_relative.dzfj003
         
         #此筆設計資料取代此參考點順序位置,並將參考點順序往下排序
         LET l_dzfj004 = p_dzfj_relative.dzfj004
         
         CALL sadzp168_8_set_widget_pos(p_add_mode, p_dzfi004, "", p_dzfj.*, p_dzfj_relative.*)
            RETURNING l_success, p_dzfj.*
         
         IF NOT l_success THEN
            RETURN FALSE
         END IF

      WHEN "DG_N"   #往下已取得群組的參考點:在參考群組上一個序號加入一組全新的元件群組設計資料
         #將要插入的元件群組序號往後加1
         UPDATE sadzp168_8_dzfi_is SET dzfi005 = (dzfi005 + 1)
           WHERE dzfi004 = p_dzfi_relative.dzfi004
             AND dzfi005 >= p_dzfi_relative.dzfi005

         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00517"
            LET g_errparam.extend = "upd add_widget().dzfi_is_DG_N:"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = p_dzfi_relative.dzfi004 CLIPPED
            CALL cl_err()
            LET g_error_message = "ERROR-add_widget()-upd DG_N:sadzp168_8_dzfj_is.", p_dzfi_relative.dzfi004 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            DISPLAY g_error_message
            RETURN FALSE
         END IF
         
         CALL sadzp168_8_set_widget_pos(p_add_mode, p_dzfi004, p_dzfi_relative.dzfi006, p_dzfj.*, p_dzfj_relative.*)
            RETURNING l_success, p_dzfj.*
         
         IF NOT l_success THEN
            RETURN FALSE
         END IF

         #####insert 畫面結構檔資枓表#####
         LET l_dzfi_ins.dzfi001 = p_dzfi_relative.dzfi001 CLIPPED
         #LET l_dzfi_ins.dzfi002 = 2
         #LET l_dzfi_ins.dzfi003 = l_dzfi003 + 1
         LET l_dzfi_ins.dzfi004 = p_dzfi_relative.dzfi004                            #群組代碼
         LET l_dzfi_ins.dzfi005 = p_dzfi_relative.dzfi005                            #順序
         #LET l_dzfi_ins.dzfi006 = g_widget_group, l_dzfi_ins.dzfi003 USING "<<<<<"   #元件(組)代碼 
         LET l_dzfi_ins.dzfi006 = ""                                                 #元件(組)代碼 
         LET l_dzfi_ins.dzfi007 = ""                                                 #節點類型
         LET l_dzfi_ins.dzfi008 = "Y"                                                #畫面結構中是否顯示
         #LET l_dzfi_ins.dzfi009 = ""
         LET l_dzfi_ins.dzfi010 = "3"                                                #包含元素類型3.Widget 
         LET l_dzfi_ins.dzfi011 = ""                                                 #直橫排列V/H

         CALL sadzp168_8_ins_dzfi(l_dzfi_ins.*)
            RETURNING l_success, l_dzfi_ins.*

         IF NOT l_success THEN
            RETURN FALSE
         END IF

         LET l_dzfj003 = l_dzfi_ins.dzfi006
         LET l_dzfj004 = 1



      WHEN "A"   #無任何參考點(直接新增在父節點下的最後面順序位置)
         #取得所屬container下最大序號ID
         SELECT MAX(dzfi005) INTO l_dzfi005 FROM sadzp168_8_dzfi_is
           WHERE dzfi004 = p_dzfi_relative.dzfi004

         #上層container  
         IF cl_null(l_dzfi005) THEN
            LET l_dzfi005 = 0
         END IF

         #####insert 畫面結構檔資枓表#####
         LET l_dzfi_ins.dzfi001 = p_dzfi_relative.dzfi001 CLIPPED
         #LET l_dzfi_ins.dzfi002 = 2
         #LET l_dzfi_ins.dzfi003 = l_dzfi003 + 1
         LET l_dzfi_ins.dzfi004 = p_dzfi_relative.dzfi004                            #群組代碼
         LET l_dzfi_ins.dzfi005 = l_dzfi005 + 1                                      #順序
         #LET l_dzfi_ins.dzfi006 = g_widget_group, l_dzfi_ins.dzfi003 USING "<<<<<"   #元件(組)代碼 
         LET l_dzfi_ins.dzfi006 = ""                                                 #元件(組)代碼 
         LET l_dzfi_ins.dzfi007 = ""                                                 #節點類型
         LET l_dzfi_ins.dzfi008 = "Y"                                                #畫面結構中是否顯示
         #LET l_dzfi_ins.dzfi009 = ""
         LET l_dzfi_ins.dzfi010 = "3"                                                #包含元素類型3.Widget 
         LET l_dzfi_ins.dzfi011 = ""                                                 #直橫排列V/H

         CALL sadzp168_8_ins_dzfi(l_dzfi_ins.*)
            RETURNING l_success, l_dzfi_ins.*

         IF NOT l_success THEN
            RETURN FALSE
         END IF

         LET l_dzfj003 = l_dzfi_ins.dzfi006
         LET l_dzfj004 = 1

      OTHERWISE
      
   END CASE
    
   #新增此筆引用之畫面元件組合(widget)設計資料
   LET l_dzfj_ins.dzfj001 = p_dzfj.dzfj001 CLIPPED
   LET l_dzfj_ins.dzfj002 = g_dzfi002_is
   LET l_dzfj_ins.dzfj003 = l_dzfj003
   LET l_dzfj_ins.dzfj004 = l_dzfj004
   LET l_dzfj_ins.dzfj005 = p_dzfj.dzfj005 
   LET l_dzfj_ins.dzfj006 = p_dzfj.dzfj006
   LET l_dzfj_ins.dzfj007 = ""
   LET l_dzfj_ins.dzfj008 = ""
   LET l_dzfj_ins.dzfj009 = ""
   LET l_dzfj_ins.dzfj010 = ""
   LET l_dzfj_ins.dzfj011 = ""
   LET l_dzfj_ins.dzfj012 = ""
   LET l_dzfj_ins.dzfj013 = p_dzfj.dzfj013
   LET l_dzfj_ins.dzfj014 = p_dzfj.dzfj014
   LET l_dzfj_ins.dzfj015 = p_dzfj.dzfj015
   LET l_dzfj_ins.dzfj016 = p_dzfj.dzfj016
   LET l_dzfj_ins.dzfjstus = "Y"
   LET l_dzfj_ins.dzfj017 = "c"
   LET l_dzfj_ins.dzfj018 = g_dzfi017

   INSERT INTO sadzp168_8_dzfj_is (dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
                                  dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
                                  dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
                                  dzfj016, dzfjstus, dzfj017, dzfj018)
     VALUES (l_dzfj_ins.dzfj001, l_dzfj_ins.dzfj002, l_dzfj_ins.dzfj003, l_dzfj_ins.dzfj004, l_dzfj_ins.dzfj005, 
             l_dzfj_ins.dzfj006, l_dzfj_ins.dzfj007, l_dzfj_ins.dzfj008, l_dzfj_ins.dzfj009, l_dzfj_ins.dzfj010, 
             l_dzfj_ins.dzfj011, l_dzfj_ins.dzfj012, l_dzfj_ins.dzfj013, l_dzfj_ins.dzfj014, l_dzfj_ins.dzfj015, 
             l_dzfj_ins.dzfj016, l_dzfj_ins.dzfjstus, l_dzfj_ins.dzfj017, l_dzfj_ins.dzfj018) 

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfj_is:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-add_widget()-ins sadzp168_8_dzfj_is.", l_dzfj_ins.dzfj005 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   
   INSERT INTO sadzp168_8_dzfk_is 
     SELECT dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
            dzfk006, dzfk007, dzfk008, dzfk009
       FROM dzfk_t
       WHERE dzfk001 = l_dzfj_ins.dzfj001 AND dzfk002 = g_dzfi002_sd 
         AND dzfk003 = l_dzfj_ins.dzfj005 AND dzfk007 = g_dzfi009 

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfk_is:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-add_widget()-ins sadzp168_8_dzfk_is.", l_dzfj_ins.dzfj005 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
 
   INSERT INTO sadzp168_8_dzfl_is 
     SELECT dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, 
            dzfl006, dzflstus, dzfl007, dzfl008
       FROM dzfl_t
       WHERE dzfl001 = l_dzfj_ins.dzfj001 AND dzfl002 = g_dzfi002_sd 
         AND dzfl003 = l_dzfj_ins.dzfj005 AND dzfl007 = g_dzfi009

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfl_is:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-add_widget()-ins sadzp168_8_dzfl_is.", l_dzfj_ins.dzfj005 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

#+ 在引用之畫面結構設計資料中往上尋找上一個元件組合群組,並取得在原行業畫面結構中相符合的節點
PRIVATE FUNCTION sadzp168_8_previous_group(p_dzfi004, p_dzfi005)
   DEFINE p_dzfi004         LIKE dzfi_t.dzfi004    #container群組代碼
   DEFINE p_dzfi005         LIKE dzfi_t.dzfi005    #順序序號
   
   DEFINE l_dzfj_n          type_g_dzfj            #畫面元件組合檔
   DEFINE l_dzfj_o          type_g_dzfj            #原行業畫面可加入新設計資料的節點位置 
   DEFINE l_errcode         STRING
   
   DEFINE r_dzfi_relative   type_g_dzfi            #參考點所屬的元件組合檔
   
   INITIALIZE l_dzfj_o TO NULL
   INITIALIZE r_dzfi_relative TO NULL
   LET r_dzfi_relative.dzfi005 = 0
   
   #此元件組合的序號已經小於1時
   #表示原行業畫面元件組合設計資料中無存在此筆新的設計資料參考點
   IF p_dzfi005 < 1 THEN
      RETURN r_dzfi_relative.*
   END IF

   #取得上一組元件組合檔
   LET p_dzfi005 = p_dzfi005 - 1
   
   #取得指定的元件組合代碼下所有widget結構
   OPEN sadzp168_8_group_ref_cs USING p_dzfi004, p_dzfi005
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "OPEN sadzp168_8_group_ref_cs:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-previous_group()-OPEN sadzp168_8_group_ref_cs:", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      CLOSE sadzp168_8_group_ref_cs
      LET r_dzfi_relative.dzfi005 = 0
      RETURN r_dzfi_relative.*
   END IF
   
   #利用新元件組合資料為基礎
   FOREACH sadzp168_8_group_ref_cs INTO l_dzfj_n.*
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzp168_8_group_ref_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-previous_group()-FOREACH sadzp168_8_group_ref_cs.", l_dzfj_n.dzfj005 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
         DISPLAY g_error_message
         EXIT FOREACH
      END IF
      
      #取得原行業畫面元件組合中是否有相符合的節點
      SELECT * INTO l_dzfj_o.* FROM sadzp168_8_dzfj_is
        WHERE dzfj005 = l_dzfj_n.dzfj005

      #找到參考點時,取得此元件組合檔資訊
      IF NOT cl_null(l_dzfj_o.dzfj005) THEN
         SELECT * INTO r_dzfi_relative.* FROM sadzp168_8_dzfi_is
           WHERE dzfi006 = l_dzfj_o.dzfj003
         EXIT FOREACH
      END IF
   END FOREACH

   #已取得參考點時直接回傳元件組合檔資訊
   #如果沒有找到繼續往上尋找
   IF NOT cl_null(l_dzfj_o.dzfj005) THEN
      RETURN r_dzfi_relative.*
   ELSE
      CALL sadzp168_8_previous_group(p_dzfi004, p_dzfi005)
         RETURNING r_dzfi_relative.*
   END IF

   IF NOT cl_null(r_dzfi_relative.dzfi005) AND r_dzfi_relative.dzfi005 <> 0 THEN
      RETURN r_dzfi_relative.*
   ELSE
      LET r_dzfi_relative.dzfi005 = 0
      RETURN r_dzfi_relative.*
   END IF
END FUNCTION

#+ 在引用之畫面結構設計資料中往下尋找下一個元件組合群組,並取得在原行業畫面結構中相符合的節點
PRIVATE FUNCTION sadzp168_8_next_group(p_dzfi004, p_dzfi005, p_dzfi005_max)
   DEFINE p_dzfi004         LIKE dzfi_t.dzfi004    #container群組代碼
   DEFINE p_dzfi005         LIKE dzfi_t.dzfi005    #順序序號
   DEFINE p_dzfi005_max     LIKE dzfi_t.dzfi005    #畫面結構群組的最大序號
   
   DEFINE l_dzfj_n          type_g_dzfj            #畫面元件組合檔
   DEFINE l_dzfj_o          type_g_dzfj            #原行業畫面可加入新設計資料的節點位置 
   DEFINE l_errcode         STRING

   DEFINE r_dzfi_relative   type_g_dzfi            #參考點所屬的元件組合檔
   
   INITIALIZE l_dzfj_o TO NULL
   LET r_dzfi_relative.dzfi005 = 0
   
   #此元件組合的序號已經大於此container下的元件組合最大序號時
   #表示原行業畫面元件組合設計資料中無存在此筆新的設計資料參考點
   IF p_dzfi005 > p_dzfi005_max THEN
      RETURN r_dzfi_relative.*
   END IF
   
   #取得下一組元件組合檔
   LET p_dzfi005 = p_dzfi005 + 1
   
   #取得指定的元件組合代碼下所有widget結構
   OPEN sadzp168_8_group_ref_cs USING p_dzfi004, p_dzfi005
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "OPEN sadzp168_8_group_ref_cs:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-next_group()-OPEN sadzp168_8_group_ref_cs:", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      CLOSE sadzp168_8_group_ref_cs
      LET r_dzfi_relative.dzfi005 = 0
      RETURN r_dzfi_relative.*
   END IF
   
   #利用新元件組合資料為基礎
   FOREACH sadzp168_8_group_ref_cs INTO l_dzfj_n.*
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzp168_8_group_ref_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-next_group()-FOREACH sadzp168_8_group_ref_cs.", l_dzfj_n.dzfj005 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
         DISPLAY g_error_message
         EXIT FOREACH
      END IF

      LET l_dzfj_n.dzfj005 = l_dzfj_n.dzfj005 CLIPPED
      
      #取得原行業畫面元件組合中是否有相符合的節點
      SELECT * INTO l_dzfj_o.* FROM sadzp168_8_dzfj_is
        WHERE dzfj005 = l_dzfj_n.dzfj005

      IF NOT cl_null(l_dzfj_o.dzfj005) THEN
         SELECT * INTO r_dzfi_relative.* FROM sadzp168_8_dzfi_is
            WHERE dzfi004 = p_dzfi004 AND dzfi006 = l_dzfj_o.dzfj003
         EXIT FOREACH
      END IF
   END FOREACH

   IF NOT cl_null(l_dzfj_o.dzfj005) THEN
      RETURN r_dzfi_relative.*
   ELSE
      CALL sadzp168_8_next_group(p_dzfi004, p_dzfi005, p_dzfi005_max)
         RETURNING r_dzfi_relative.*
   END IF

   IF NOT cl_null(r_dzfi_relative.dzfi005) AND r_dzfi_relative.dzfi005 <> 0 THEN
      RETURN r_dzfi_relative.*
   ELSE
      LET r_dzfi_relative.dzfi005 = 0
      RETURN r_dzfi_relative.*
   END IF
END FUNCTION


#+ 新增一筆畫面結構檔(Container)
PRIVATE FUNCTION sadzp168_8_ins_dzfi(p_dzfi)
   DEFINE p_dzfi               type_g_dzfi
   
   DEFINE l_dzfi003            LIKE dzfi_t.dzfi003    #畫面結構設計資料ID 
   DEFINE l_dzfi_ins           type_g_dzfi            #畫面結構檔
   DEFINE l_errcode            STRING
   
   #取得最大ID序號值
   SELECT MAX(dzfi003) INTO l_dzfi003 FROM sadzp168_8_dzfi_is
   
   LET l_dzfi_ins.dzfi001 = p_dzfi.dzfi001 CLIPPED
   LET l_dzfi_ins.dzfi002 = g_dzfi002_is
   LET l_dzfi_ins.dzfi003 = l_dzfi003 + 1
   LET l_dzfi_ins.dzfi004 = p_dzfi.dzfi004                                     #群組代碼
   LET l_dzfi_ins.dzfi005 = p_dzfi.dzfi005                                     #順序

   IF cl_null(p_dzfi.dzfi006) THEN   
      LET p_dzfi.dzfi006 = g_widget_group, l_dzfi_ins.dzfi003 USING "<<<<<"    #元件(組)代碼 
   END IF

   LET l_dzfi_ins.dzfi006 = p_dzfi.dzfi006                                     #元件(組)代碼 
   LET l_dzfi_ins.dzfi007 = p_dzfi.dzfi007                                     #節點類型
   LET l_dzfi_ins.dzfi008 = p_dzfi.dzfi008                                     #畫面結構中是否顯示
   LET l_dzfi_ins.dzfi009 = "c"                                                #識別標示:c-客製
   LET l_dzfi_ins.dzfi010 = p_dzfi.dzfi010                                     #包含元素類型3.Widget 
   LET l_dzfi_ins.dzfi011 = p_dzfi.dzfi011                                     #直橫排列V/H
   LET l_dzfi_ins.dzfi012 = 99
   LET l_dzfi_ins.dzfi013 = 0
   LET l_dzfi_ins.dzfi014 = 0
   LET l_dzfi_ins.dzfi015 = 0
   LET l_dzfi_ins.dzfi016 = 0
   LET l_dzfi_ins.dzfistus = "Y"
   LET l_dzfi_ins.dzfi017 = g_dzfi017

   INSERT INTO sadzp168_8_dzfi_is (dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
                                   dzfi006, dzfi007, dzfi008, dzfi009, dzfi010, 
                                   dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
                                   dzfi016, dzfistus, dzfi017)
     VALUES (l_dzfi_ins.dzfi001, l_dzfi_ins.dzfi002, l_dzfi_ins.dzfi003, l_dzfi_ins.dzfi004, l_dzfi_ins.dzfi005, 
             l_dzfi_ins.dzfi006, l_dzfi_ins.dzfi007, l_dzfi_ins.dzfi008, l_dzfi_ins.dzfi009, l_dzfi_ins.dzfi010, 
             l_dzfi_ins.dzfi011, l_dzfi_ins.dzfi012, l_dzfi_ins.dzfi013, l_dzfi_ins.dzfi014, l_dzfi_ins.dzfi015, 
             l_dzfi_ins.dzfi016, l_dzfi_ins.dzfistus, l_dzfi_ins.dzfi017) 

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins dzfi_is:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-ins_dzfi()-ins sadzp168_8_dzfi_is.", l_dzfi_ins.dzfi006 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE, l_dzfi_ins.*
   END IF

   IF (NOT cl_null(l_dzfi_ins.dzfi007)) AND l_dzfi_ins.dzfi010 <> "3" THEN
      INSERT INTO sadzp168_8_dzfk_is 
        SELECT dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
               dzfk006, dzfk007, dzfk008, dzfk009
          FROM dzfk_t
          WHERE dzfk001 = l_dzfi_ins.dzfi001 AND dzfk002 = g_dzfi002_sd 
            AND dzfk003 = l_dzfi_ins.dzfi006 AND dzfk007 = g_dzfi009
      
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dzfk_is:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-ins_dzfi()-ins sadzp168_8_dzfk_is.", l_dzfi_ins.dzfi006 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
         DISPLAY g_error_message
         RETURN FALSE, l_dzfi_ins.*
      END IF
   END IF 

   RETURN TRUE, l_dzfi_ins.*
END FUNCTION

#+ 重新計算新插入的widget X, Y軸位置
PRIVATE FUNCTION sadzp168_8_set_widget_pos(p_add_mode, p_dzfi004, p_dzfi006_relative, p_dzfj_new, p_dzfj_relative)
   DEFINE p_add_mode           LIKE type_t.chr10      #新節點加入模式
   DEFINE p_dzfi004            LIKE dzfi_t.dzfi004    #新widget所屬Container
   DEFINE p_dzfi006_relative   LIKE dzfi_t.dzfi006    #新widget參考群組
   DEFINE p_dzfj_new           type_g_dzfj            #新增的畫面元件組合檔(新widget設計資料)
   DEFINE p_dzfj_relative      type_g_dzfj            #新widget設計資料需加入在原行業參考點[畫面元件組合檔]中的相對位置節點
   
   DEFINE l_posX               LIKE dzfj_t.dzfj013    #新控件的X軸
   DEFINE l_posY               LIKE dzfj_t.dzfj014    #新控件的Y軸
   DEFINE l_errcode            STRING

   CASE p_add_mode
      WHEN "SG_P"   #同一群組前面參考點:往上取得參考節點方式(採下一節點插入方式)
         #同一群組(同一排Y軸)插入:所以X軸位置直接加在參考點後面(+1:留一個空白),預設[Y軸座標]和參考點一樣
         #新控件X軸 = 參考點控件X軸 + 參考點控件寬度 + 1
         LET p_dzfj_new.dzfj013 = p_dzfj_relative.dzfj013 + p_dzfj_relative.dzfj015 + 1
         LET p_dzfj_new.dzfj014 = p_dzfj_relative.dzfj014

         #重新計算在同一個container下,因為插入新的widget位置,而其它控件的位移關係
         IF NOT sadzp168_8_widget_pos_calc(p_dzfi004, p_dzfj_relative.dzfj003, p_dzfj_new.*) THEN
            RETURN FALSE, p_dzfj_new.*
         END IF

      WHEN "SG_N"   #同一群組前面參考點:往下取得參考節點方式(採上一節點插入方式)
         #同一群組(同一排Y軸)插入:所以[X軸位置]直接取代[參考點]X軸位置,預設[Y軸座標]和參考點一樣(參考點往下一個X軸位移量移動)
         #新控件X軸 = 參考點控件X軸
         LET p_dzfj_new.dzfj013 = p_dzfj_relative.dzfj013
         LET p_dzfj_new.dzfj014 = p_dzfj_relative.dzfj014

         #重新計算在同一個container下,因為插入新的widget位置,而其它控件的位移關係
         IF NOT sadzp168_8_widget_pos_calc(p_dzfi004, p_dzfj_relative.dzfj003, p_dzfj_new.*) THEN
            RETURN FALSE, p_dzfj_new.*
         END IF



      WHEN "DG_P"   #往上已取得個群組的參考點:在參考群組下一個序號加入一組全新的元件群組設計資料
         #取得Container下的最小X軸數值(為新控件的X軸參考依據)
         SELECT MIN(dzfj013) INTO l_posX FROM sadzp168_8_dzfj_is
           WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_8_dzfi_is
                               WHERE dzfi004 = p_dzfi004)

         #取得上一個參考點所用完的Y軸高度
         SELECT MAX(dzfj014+dzfj016) INTO l_posY FROM sadzp168_8_dzfj_is
           WHERE dzfj003 = p_dzfi006_relative

         IF p_dzfj_new.dzfj013 < l_posX THEN
            LET p_dzfj_new.dzfj013 = l_posX
         END IF
         
         LET p_dzfj_new.dzfj014 = l_posY

         #Container下的群組元件Y軸 > 新控件的Y軸, 往下位移(位移量為新控件的高度)
         UPDATE sadzp168_8_dzfj_is SET dzfj014 = (dzfj014 + p_dzfj_new.dzfj016)
           WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_8_dzfi_is
                               WHERE dzfi004 = p_dzfi004)
             AND dzfj014 >= p_dzfj_new.dzfj014
             
         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00517"
            LET g_errparam.extend = "upd widget_pos().dzfj_is_DG_P:"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = p_dzfi004 CLIPPED
            CALL cl_err()
            LET g_error_message = "ERROR-set_widget_pos(dzfj014+dzfj016)-upd DG_P:sadzp168_8_dzfj_is.", p_dzfi004 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            DISPLAY g_error_message
            RETURN FALSE, p_dzfj_new.*
         END IF

      WHEN "DG_N"   #往下已取得群組的參考點:在參考群組上一個序號加入一組全新的元件群組設計資料
         #取得Container下的最小X軸數值(為新控件的X軸參考依據)
         SELECT MIN(dzfj013) INTO l_posX FROM sadzp168_8_dzfj_is
           WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_8_dzfi_is
                               WHERE dzfi004 = p_dzfi004)

         #取得此元件群組的Y軸高度(理論上同一排widget的Y軸應該相同)
         SELECT DISTINCT dzfj014 INTO l_posY FROM sadzp168_8_dzfj_is
           WHERE dzfj003 = p_dzfi006_relative
              
         IF p_dzfj_new.dzfj013 < l_posX THEN
            LET p_dzfj_new.dzfj013 = l_posX
         END IF

         LET p_dzfj_new.dzfj014 = l_posY

         #Container下的群組元件Y軸 > 新控件的Y軸, 往下位移(位移量為新控件的高度)
         UPDATE sadzp168_8_dzfj_is SET dzfj014 = (dzfj014 + p_dzfj_new.dzfj016)
           WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_8_dzfi_is
                               WHERE dzfi004 = p_dzfi004)
             AND dzfj014 >= p_dzfj_new.dzfj014

         IF SQLCA.sqlcode THEN
            LET l_errcode = SQLCA.sqlcode
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00517"
            LET g_errparam.extend = "upd widget_pos().dzfj_is_DG_N:"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = p_dzfi004 CLIPPED
            CALL cl_err()
            LET g_error_message = "ERROR-set_widget_pos(dzfj014+dzfj016)-upd DG_N:sadzp168_8_dzfj_is.", p_dzfi004 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
            DISPLAY g_error_message
            RETURN FALSE, p_dzfj_new.*
         END IF

      WHEN "A"   #無任何參考點(直接新增在父節點下的最後面順序位置)
         #取得Container下的最小X軸數值(為新控件的X軸參考依據)
         SELECT MIN(dzfj013) INTO l_posX FROM sadzp168_8_dzfj_is
           WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_8_dzfi_is
                               WHERE dzfi004 = p_dzfi004)

         #取得Container下已用掉最大Y軸高度(為新控件的Y軸參考依據)
         SELECT MAX(dzfj014+dzfj016) INTO l_posY FROM sadzp168_8_dzfj_is
           WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_8_dzfi_is
                               WHERE dzfi004 = p_dzfi004)

         IF p_dzfj_new.dzfj013 < l_posX THEN
            LET p_dzfj_new.dzfj013 = l_posX
         END IF

         LET p_dzfj_new.dzfj014 = l_posY
         
      OTHERWISE
      
   END CASE

   RETURN TRUE, p_dzfj_new.*
END FUNCTION

#重新計算在同一個container下,插入的widget位置(不與其它UI元件位置重疊)
PRIVATE FUNCTION sadzp168_8_widget_pos_calc(p_dzfi004, p_dzfj003_relative, p_dzfj_new)
   DEFINE p_dzfi004            LIKE dzfi_t.dzfi004    #群組代碼
   DEFINE p_dzfj003_relative   LIKE dzfj_t.dzfj003
   DEFINE p_dzfj_new           type_g_dzfj
   
   DEFINE l_dzfi006            LIKE dzfi_t.dzfi006
   DEFINE l_dzfi010            LIKE dzfi_t.dzfi010
   DEFINE l_y_max              LIKE dzfj_t.dzfj014
   DEFINE l_dzfj014_group      LIKE dzfj_t.dzfj014    #元件群組的Y軸高度
   DEFINE l_x_min              LIKE dzfj_t.dzfj013    #元件群組的最小X軸位置
   DEFINE l_x_gap              LIKE dzfj_t.dzfj013    #X軸位移量
   DEFINE l_y_gap              LIKE dzfj_t.dzfj014    #Y軸位移量
   DEFINE l_dzfj016            LIKE dzfj_t.dzfj016
   DEFINE l_errcode            STRING

   IF cl_null(p_dzfi004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00518"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-", cl_getmsg("adz-00518", g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   #取得同一群組代碼(dzfi004)下的container設計資料
   OPEN sadzp168_8_dzfi006_group_cs USING p_dzfi004
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "OPEN sadzp168_8_dzfi006_group_cs:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-widget_pos_calc()-OPEN sadzp168_8_dzfi006_group_cs:", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      CLOSE sadzp168_8_dzfi006_group_cs
      RETURN FALSE
   END IF
   
   #逐一取得同一畫面結構設計資料
   FOREACH sadzp168_8_dzfi006_group_cs INTO l_dzfi006, l_dzfi010
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH sadzp168_8_dzfi006_group_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-widget_pos_calc()-FOREACH sadzp168_8_dzfi006_group_cs,", l_dzfi006 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
         DISPLAY g_error_message
         RETURN FALSE
      END IF
   
      #群組包含widget設計資料(元件類型:3)
      IF l_dzfi010 = "3" THEN
         #新插入控件與[原行業次同一元件群組]時
         IF l_dzfi006 = p_dzfj003_relative THEN
            #同一群組(同一排Y軸)插入:所以X軸位置直接加在參考點後面(+1:留一個空白),預設[Y軸座標]和參考點一樣
            UPDATE sadzp168_8_dzfj_is SET dzfj013 = (dzfj013 + p_dzfj_new.dzfj015 + 1)
              WHERE dzfj003 = l_dzfi006
                AND dzfj013 >= p_dzfj_new.dzfj013
                
            IF SQLCA.sqlcode THEN
               LET l_errcode = SQLCA.sqlcode
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00519"
               LET g_errparam.extend = "upd dzfj013:"
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_dzfi006 CLIPPED
               CALL cl_err()
               LET g_error_message = "ERROR-widget_pos_calc(dzfj013+dzfj015+1)-upd:sadzp168_8_dzfj_is.", l_dzfi006 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
               DISPLAY g_error_message
               RETURN FALSE
            END IF
         ELSE
            LET l_dzfj014_group = 0
            
            #取得此元件群組的Y軸高度(理論上同一排widget的Y軸應該相同)
            SELECT DISTINCT dzfj014 INTO l_dzfj014_group FROM sadzp168_8_dzfj_is
              WHERE dzfj003 = l_dzfi006

            IF SQLCA.sqlcode THEN
               LET l_errcode = SQLCA.sqlcode
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "sel pos_calc().dzfj014:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_error_message = "ERROR-widget_pos_calc()-SELECT DISTINCT dzfj014.", l_dzfi006 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
               DISPLAY g_error_message
               RETURN FALSE
            END IF

            #檢查[群組元件Y軸]高度 < [新控件Y軸]高度的控件,Y軸是否有重疊
            IF (NOT cl_null(l_dzfj014_group)) AND (l_dzfj014_group < p_dzfj_new.dzfj014) THEN
               #以每一個元件的[起點/終點X軸]位置,來判斷是否有和新控件的X重疊為基礎
               #取得此元件群組所佔用最大Y軸間距(如:TextEdit-Y軸起始點為2,高度為3.所佔Y軸間距為2~5)
               SELECT MAX(dzfj014 + dzfj016) INTO l_y_max FROM sadzp168_8_dzfj_is
                 WHERE dzfj003 = l_dzfi006
                   AND (dzfj013 + dzfj015) > p_dzfj_new.dzfj013
                   AND (p_dzfj_new.dzfj013 + p_dzfj_new.dzfj015) > dzfj013

               #重疊的控件之最大Y軸間距 > 新插入控件的Y軸座標: 需要位移此元件群組下控件的X軸座標
               IF (NOT cl_null(l_y_max)) AND (l_y_max > p_dzfj_new.dzfj014) THEN
                  #取得元件群組的最小X軸位置
                  #用來判斷是否與新控件X軸有overlap情況
                  SELECT MIN(dzfj013) INTO l_x_min FROM sadzp168_8_dzfj_is
                    WHERE dzfj003 = l_dzfi006
                      AND (dzfj013+dzfj015) > p_dzfj_new.dzfj013

                  #計算X軸位移量(todo--PS:l_x_min有可能也會 > p_dzfj_new.dzfj013,注意一下負值是否可以運作正常)
                  LET l_x_gap = (p_dzfj_new.dzfj013 - l_x_min) + p_dzfj_new.dzfj015 + 1
                  
                  UPDATE sadzp168_8_dzfj_is SET dzfj013 = (dzfj013 + l_x_gap)
                    WHERE dzfj003 = l_dzfi006
                      AND (dzfj013+dzfj015) > p_dzfj_new.dzfj013

                  IF SQLCA.sqlcode THEN
                     LET l_errcode = SQLCA.sqlcode
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "adz-00519"
                     LET g_errparam.extend = "upd dzfj013:"
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = l_dzfi006 CLIPPED
                     CALL cl_err()
                     LET g_error_message = "ERROR-widget_pos_calc(dzfj013+l_x_gap)-upd:sadzp168_8_dzfj_is.", l_dzfi006 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
                     DISPLAY g_error_message
                     RETURN FALSE
                  END IF
               END IF
            END IF

            
            #檢查[群組元件Y軸]高度 > [新控件Y軸]高度的控件: 當[新控件的Y軸]高度 > [群組元件的Y軸]最高高度,Y軸需全部往下位移
            IF (NOT cl_null(l_dzfj014_group)) AND (l_dzfj014_group > p_dzfj_new.dzfj014) THEN
               #取得此元件群組所佔用最大Y軸間距(如:TextEdit-Y軸起始點為2,高度為3.所佔Y軸間距為2~5)
               SELECT MAX(dzfj016) INTO l_dzfj016 FROM sadzp168_8_dzfj_is
                 WHERE dzfj003 = p_dzfj_new.dzfj003

               #新控件高度 > 群組元件裡的最高高度
               IF p_dzfj_new.dzfj016 > l_dzfj016 THEN
                  #計算Y軸位移量
                  LET l_y_gap = p_dzfj_new.dzfj016 - l_dzfj016

                  UPDATE sadzp168_8_dzfj_is SET dzfj014 = (dzfj014 + l_y_gap)
                    WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_8_dzfi_is
                                        WHERE dzfi004 = p_dzfi004)
                      AND dzfj014 > p_dzfj_new.dzfj014
                      
                  IF SQLCA.sqlcode THEN
                     LET l_errcode = SQLCA.sqlcode
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "adz-00520"
                     LET g_errparam.extend = "upd dzfj014:"
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = p_dzfi004 CLIPPED
                     CALL cl_err()
                     LET g_error_message = "ERROR-widget_pos_calc(dzfj014+l_y_gap)-upd:sadzp168_8_dzfj_is.", p_dzfi004 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
                     DISPLAY g_error_message
                     RETURN FALSE
                  END IF
               END IF
               
               EXIT FOREACH
            END IF
         END IF
      END IF
   
   END FOREACH

   RETURN TRUE
END FUNCTION

#取得二數值間的最大數值
PRIVATE FUNCTION sadzp168_8_max_value(p_value1, p_value2)
   DEFINE p_value1             LIKE type_t.num5         #第一個比較值
   DEFINE p_value2             LIKE type_t.num5         #第二個被比較值
   
   CASE
      WHEN (p_value1 > p_value2)
         RETURN p_value1

      WHEN (p_value1 < p_value2)
         RETURN p_value2

      WHEN (p_value1 = p_value2)
         RETURN p_value1
   END CASE

   RETURN 0
END FUNCTION

#取得二數值間的最小數值
PRIVATE FUNCTION sadzp168_8_min_value(p_value1, p_value2)
   DEFINE p_value1             LIKE type_t.num5         #第一個比較值
   DEFINE p_value2             LIKE type_t.num5         #第二個被比較值
   
   CASE
      WHEN (p_value1 > p_value2)
         RETURN p_value2

      WHEN (p_value1 < p_value2)
         RETURN p_value1

      WHEN (p_value1 = p_value2)
         RETURN p_value1
   END CASE

   RETURN 0
END FUNCTION

#取得Container內是否有存在[控件高度 > 2]的widget
PRIVATE FUNCTION sadzp168_8_check_height(p_dzfi004, p_dzfj)
   DEFINE p_dzfi004            LIKE dzfi_t.dzfi004    #新控件所屬Container群組代碼
   DEFINE p_dzfj               type_g_dzfj            #新控件(widget)設計資料

   DEFINE l_dzfj016            LIKE dzfj_t.dzfj016    #控件高度
   DEFINE l_dzfi007            LIKE dzfi_t.dzfi007    #container類型
   DEFINE l_errcode            STRING       

   #todo:二個Container間的父節點必為HBox或VBOx(參考的[相對位置Container]父節點必須為HBox或VBOx)
   SELECT dzfi007 INTO l_dzfi007 FROM sadzp168_8_dzfi_sd
      WHERE dzfi006 = p_dzfi004
   
   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "sel dzfi007:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-sel dzfi007.", p_dzfi004 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      #當發生無法預期錯誤時,當成新增至patch區塊處理
      RETURN TRUE
   END IF

   #Container為table和tree時,不需另外將控件新增至 patch區塊
   IF l_dzfi007 = "Table" OR l_dzfi007 = "Tree" THEN
      RETURN FALSE
   END IF
   
   #取得p_dzfi004 所有控件下最大的Y軸高度
   SELECT MAX(dzfj016) INTO l_dzfj016 FROM sadzp168_8_dzfj_is
     WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_8_dzfi_is
                         WHERE dzfi004 = p_dzfi004)

   #控件高度 <= 1 情況下,不需另外將控件新增至 patch區塊
   IF cl_null(l_dzfj016) OR l_dzfj016 < 2 THEN
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#將隸屬於類似單頭型態的控件,放置在Grid的patch區塊
PRIVATE FUNCTION sadzp168_8_add_widget_patch(p_dzfj)
   DEFINE p_dzfj               type_g_dzfj            #新控件(widget)設計資料
   
   DEFINE l_dzfi_ins           type_g_dzfi            #新增至DB的Container設計資料
   DEFINE l_dzfi005            LIKE dzfi_t.dzfi005
   DEFINE l_success            LIKE type_t.chr1
   DEFINE l_dzfj_ins           type_g_dzfj            #新增至DB的widget設計資料
   DEFINE l_dzfj014            LIKE dzfj_t.dzfj014    #widget Y軸位置
   DEFINE l_errcode            STRING
   
   #新增Grid的patch區塊
   IF cl_null(g_dzfi_patch_grid.dzfi004) THEN
      IF NOT sadzp168_8_add_grid_block() THEN
         RETURN FALSE
      END IF
   END IF

   #取得此群代碼(l_dzfi006_parent)下最大順序序號
   SELECT MAX(dzfi005) INTO l_dzfi005 FROM sadzp168_8_dzfi_is
     WHERE dzfi004 = g_dzfi_patch_grid.dzfi006

   IF cl_null(l_dzfi005) THEN
      LET l_dzfi005 = 0
   END IF

   #新增一筆元件群組結構檔
   LET l_dzfi_ins.dzfi001 = g_dzfi_patch_grid.dzfi001 CLIPPED
   LET l_dzfi_ins.dzfi004 = g_dzfi_patch_grid.dzfi006             #群組代碼
   LET l_dzfi_ins.dzfi005 = l_dzfi005 + 1                         #順序
   LET l_dzfi_ins.dzfi006 = ""                                    #元件(組)代碼 
   LET l_dzfi_ins.dzfi007 = ""                                    #節點類型
   LET l_dzfi_ins.dzfi008 = "Y"                                   #畫面結構中是否顯示
   LET l_dzfi_ins.dzfi010 = "3"                                   #包含元素類型3.Widget 
   LET l_dzfi_ins.dzfi011 = ""                                    #直橫排列V/H

   CALL sadzp168_8_ins_dzfi(l_dzfi_ins.*)
      RETURNING l_success, l_dzfi_ins.*

   IF NOT l_success THEN
      RETURN FALSE
   END IF

   #取得Grid的patch區塊目前已用最大Y軸高度
   SELECT MAX(dzfj014+dzfj016) INTO l_dzfj014 FROM sadzp168_8_dzfj_is
     WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_8_dzfi_is
                         WHERE dzfi004 = g_dzfi_patch_grid.dzfi006)

   IF cl_null(l_dzfj014) THEN
      LET l_dzfj014 = 0
   END IF
   
   #新增此筆引用之畫面結構設計資料
   LET l_dzfj_ins.dzfj001 = p_dzfj.dzfj001 CLIPPED
   LET l_dzfj_ins.dzfj002 = g_dzfi002_is
   LET l_dzfj_ins.dzfj003 = l_dzfi_ins.dzfi006
   LET l_dzfj_ins.dzfj004 = 1
   LET l_dzfj_ins.dzfj005 = p_dzfj.dzfj005   
   LET l_dzfj_ins.dzfj006 = p_dzfj.dzfj006
   LET l_dzfj_ins.dzfj007 = ""
   LET l_dzfj_ins.dzfj008 = ""
   LET l_dzfj_ins.dzfj009 = ""
   LET l_dzfj_ins.dzfj010 = ""
   LET l_dzfj_ins.dzfj011 = ""
   LET l_dzfj_ins.dzfj012 = ""
   LET l_dzfj_ins.dzfj013 = 1
   LET l_dzfj_ins.dzfj014 = l_dzfj014
   LET l_dzfj_ins.dzfj015 = p_dzfj.dzfj015
   LET l_dzfj_ins.dzfj016 = p_dzfj.dzfj016
   LET l_dzfj_ins.dzfjstus = "Y"
   LET l_dzfj_ins.dzfj017 = "c"
   LET l_dzfj_ins.dzfj018 = g_dzfi017

   INSERT INTO sadzp168_8_dzfj_is (dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
                                  dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
                                  dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
                                  dzfj016, dzfjstus, dzfj017, dzfj018)
     VALUES (l_dzfj_ins.dzfj001, l_dzfj_ins.dzfj002, l_dzfj_ins.dzfj003, l_dzfj_ins.dzfj004, l_dzfj_ins.dzfj005, 
             l_dzfj_ins.dzfj006, l_dzfj_ins.dzfj007, l_dzfj_ins.dzfj008, l_dzfj_ins.dzfj009, l_dzfj_ins.dzfj010, 
             l_dzfj_ins.dzfj011, l_dzfj_ins.dzfj012, l_dzfj_ins.dzfj013, l_dzfj_ins.dzfj014, l_dzfj_ins.dzfj015, 
             l_dzfj_ins.dzfj016, l_dzfj_ins.dzfjstus, l_dzfj_ins.dzfj017, l_dzfj_ins.dzfj018) 

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfj_is:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-add_widget_patch()-ins sadzp168_8_dzfj_is.", l_dzfj_ins.dzfj003 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   
   INSERT INTO sadzp168_8_dzfk_is 
     SELECT dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
            dzfk006, dzfk007, dzfk008, dzfk009
       FROM dzfk_t
       WHERE dzfk001 = l_dzfj_ins.dzfj001 AND dzfk002 = g_dzfi002_sd 
         AND dzfk003 = l_dzfj_ins.dzfj005 AND dzfk007 = g_dzfi009 

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfk_is:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-add_widget_patch()-ins sadzp168_8_dzfk_is.", p_dzfj.dzfj005 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
 
   INSERT INTO sadzp168_8_dzfl_is 
     SELECT dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, 
            dzfl006, dzflstus, dzfl007, dzfl008
       FROM dzfl_t
       WHERE dzfl001 = l_dzfj_ins.dzfj001 AND dzfl002 = g_dzfi002_sd 
         AND dzfl003 = l_dzfj_ins.dzfj005 AND dzfl007 = g_dzfi009

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfl_is:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-add_widget_patch()-ins sadzp168_8_dzfl_is.", p_dzfj.dzfj005 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

#新增一個Grid的patch區塊(放置隸屬於類似單頭型態的控件)
PRIVATE FUNCTION sadzp168_8_add_grid_block()
   DEFINE l_dzfi006_parent     LIKE dzfi_t.dzfi006    #Form節點下的第一個子節點(通常會是HBox或VBox)
   DEFINE l_dzfi_block         type_g_dzfi            #設計資料patch區塊
   DEFINE l_dzfi003            LIKE dzfi_t.dzfi003
   DEFINE l_dzfi004_patch      LIKE dzfi_t.dzfi004
   DEFINE l_dzfi005            LIKE dzfi_t.dzfi005
   DEFINE l_grid_attr          STRING
   DEFINE l_tok                base.StringTokenizer
   DEFINE l_tmp                STRING
   DEFINE l_dzfk_ins           type_g_dzfk
   DEFINE l_idx                LIKE type_t.num5
   DEFINE l_dzfk004            LIKE dzfk_t.dzfk004
   DEFINE l_dzfk005            LIKE dzfk_t.dzfk005
   DEFINE l_dzfk006            LIKE dzfk_t.dzfk006
   DEFINE l_domDoc             om.DomDocument
   DEFINE l_root_node          om.DomNode
   DEFINE l_errcode            STRING
   
   INITIALIZE g_dzfi_patch_grid TO NULL

   #Grid的patch區塊的屬性
   #LET l_grid_attr = "gridHeight|5,gridWidth|5,name|", g_patch_grid CLIPPED, ",posX|0,posY|0,style|,tag|"
   LET l_grid_attr = '<Grid gridHeight="5" gridWidth="5" name="', g_patch_grid CLIPPED,'" posX="0" posY="0" style="" tag=""/>'
   
   #檢查Grid patch區塊是否已存在畫面結構檔中
   LET l_dzfi004_patch = g_patch_grid 
   SELECT * INTO l_dzfi_block.* FROM sadzp168_8_dzfi_is
     WHERE dzfi004 = l_dzfi004_patch
   
   IF NOT cl_null(g_dzfi_patch_grid.dzfi004) THEN
      LET g_dzfi_patch_grid.* = l_dzfi_block.*
      RETURN TRUE
   END IF

   #取得Form節點下的第一個Layout(通常會是HBox或VBox)
   SELECT dzfi006 INTO l_dzfi006_parent FROM sadzp168_8_dzfi_is 
     WHERE dzfi004 = (SELECT dzfi006 FROM sadzp168_8_dzfi_is WHERE dzfi007 = 'Form')

   
   #取得最大ID序號值
   SELECT MAX(dzfi003) INTO l_dzfi003 FROM sadzp168_8_dzfi_is

   #取得此群代碼(l_dzfi006_parent)下最大順序序號
   SELECT MAX(dzfi005) INTO l_dzfi005 FROM sadzp168_8_dzfi_is
     WHERE dzfi004 = l_dzfi006_parent

   #新增一筆Grid區塊的設計資料(準備擺放控件設計資料)
   LET l_dzfi_block.dzfi001 = g_gzzb003 CLIPPED
   LET l_dzfi_block.dzfi002 = g_dzfi002_is
   LET l_dzfi_block.dzfi003 = l_dzfi003 + 1
   LET l_dzfi_block.dzfi004 = l_dzfi006_parent   #群組代碼
   LET l_dzfi_block.dzfi005 = l_dzfi005 + 1      #順序
   LET l_dzfi_block.dzfi006 = g_patch_grid       #patch區塊(子節點)
   LET l_dzfi_block.dzfi007 = "Grid"             #單頭patch區塊指定為"Grid"
   LET l_dzfi_block.dzfi008 = "Y"                #畫面結構中是否顯示
   LET l_dzfi_block.dzfi009 = "c"                #識別標示:c-客製
   LET l_dzfi_block.dzfi010 = "1"                #包含元素類型1:元件組合
   LET l_dzfi_block.dzfi011 = "H"                #直橫排列V/H
   LET l_dzfi_block.dzfi012 = 99
   LET l_dzfi_block.dzfi013 = 0
   LET l_dzfi_block.dzfi014 = 0
   LET l_dzfi_block.dzfi015 = 0
   LET l_dzfi_block.dzfi016 = 0
   LET l_dzfi_block.dzfistus = "Y"
   LET l_dzfi_block.dzfi017 = g_dzfi017

   INSERT INTO sadzp168_8_dzfi_is (dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
                                   dzfi006, dzfi007, dzfi008, dzfi009, dzfi010, 
                                   dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
                                   dzfi016, dzfistus, dzfi017)
     VALUES (l_dzfi_block.dzfi001, l_dzfi_block.dzfi002, l_dzfi_block.dzfi003, l_dzfi_block.dzfi004, l_dzfi_block.dzfi005, 
             l_dzfi_block.dzfi006, l_dzfi_block.dzfi007, l_dzfi_block.dzfi008, l_dzfi_block.dzfi009, l_dzfi_block.dzfi010, 
             l_dzfi_block.dzfi011, l_dzfi_block.dzfi012, l_dzfi_block.dzfi013, l_dzfi_block.dzfi014, l_dzfi_block.dzfi015, 
             l_dzfi_block.dzfi016, l_dzfi_block.dzfistus, l_dzfi_block.dzfi017) 

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfi_is:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-add_grid_block()-ins sadzp168_8_dzfi_is:", g_patch_grid.trim(), cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   #取得Patch Grid區塊的屬性值
   LET l_domDoc = om.DomDocument.createFromString(l_grid_attr.trim())
   LET l_root_node = l_domDoc.getDocumentElement()

   LOCATE l_dzfk_ins.dzfk009 IN FILE
   
   LET l_dzfk_ins.dzfk001 = g_gzzb003 CLIPPED
   LET l_dzfk_ins.dzfk002 = g_dzfi002_is
   LET l_dzfk_ins.dzfk003 = g_patch_grid CLIPPED
   LET l_dzfk_ins.dzfk004 = ""
   LET l_dzfk_ins.dzfk005 = ""
   LET l_dzfk_ins.dzfk006 = ""
   LET l_dzfk_ins.dzfk007 = "c"
   LET l_dzfk_ins.dzfk008 = l_dzfi_block.dzfi017
   LET l_dzfk_ins.dzfk009 = l_root_node.toString()

   INSERT INTO sadzp168_8_dzfk_is(dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
                                  dzfk006, dzfk007, dzfk008, dzfk009)
     VALUES (l_dzfk_ins.dzfk001, l_dzfk_ins.dzfk002, l_dzfk_ins.dzfk003, l_dzfk_ins.dzfk004, l_dzfk_ins.dzfk005,
             l_dzfk_ins.dzfk006, l_dzfk_ins.dzfk007, l_dzfk_ins.dzfk008, l_dzfk_ins.dzfk009)

   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'ins dzfk_is:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR-add_grid_block()-ins sadzp168_8_dzfk_is.", g_patch_grid.trim(), ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   LET g_dzfi_patch_grid.* = l_dzfi_block.*
   RETURN TRUE
END FUNCTION



















#檢查二個Container間是否有layout
PRIVATE FUNCTION sadzp168_8_check_layout(p_dzfi, p_dzfi_relative, p_add_mode)
   DEFINE p_dzfi               type_g_dzfi            #新結構檔(Container)設計資料
   DEFINE p_dzfi_relative      type_g_dzfi            #新設計資料需加入在原行業畫面結構中的相對位置節點
   DEFINE p_add_mode           LIKE type_t.chr10      #新節點加入模式
   
   DEFINE l_dzfi004            LIKE dzfi_t.dzfi004    #群組代碼
   DEFINE l_dzfi005            LIKE dzfi_t.dzfi005    #順序
   DEFINE l_dzfi004_parent     LIKE dzfi_t.dzfi004    #新Container父節點的父節點
   DEFINE l_dzfi005_relative   LIKE dzfi_t.dzfi004    #新Container在父節點下的順序位置
   DEFINE l_dzfi007_parent     LIKE dzfi_t.dzfi004    #相對位置節點(參考節點)的父節點節點類型(Container樣式)
   DEFINE l_errcode            STRING
   
   LET l_dzfi004 = ""
   LET l_dzfi005 = 0
   
   IF cl_null(p_dzfi_relative.dzfi004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00514"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_dzfi_relative.dzfi006 CLIPPED
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00514", g_lang, p_dzfi_relative.dzfi006)
      DISPLAY g_error_message
      RETURN FALSE, l_dzfi004, l_dzfi005
   END IF

   #todo:二個Container間的父節點必為HBox或VBOx(參考的[相對位置Container]父節點必須為HBox或VBOx)
   SELECT dzfi007 INTO l_dzfi007_parent FROM sadzp168_8_dzfi_is
      WHERE dzfi006 = p_dzfi_relative.dzfi004
   
   IF cl_null(l_dzfi007_parent) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00515"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_dzfi_relative.dzfi004 CLIPPED
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00515", g_lang, p_dzfi_relative.dzfi004)
      DISPLAY g_error_message
   END IF
   
   IF UPSHIFT(l_dzfi007_parent) = "HBOX" OR UPSHIFT(l_dzfi007_parent) = "VBOX" THEN
      LET l_dzfi004 = p_dzfi_relative.dzfi004
      LET l_dzfi005 = p_dzfi_relative.dzfi005
      RETURN TRUE, l_dzfi004, l_dzfi005
   END IF

   #當不為HBox或VBOx時,代表上一層無Layout情形,此時可能會造成編譯失敗
   #此筆新增之結構檔(Container)設計資料父節點,不參考[相對位置]節點,採用自己的父節點資料(dzfi004)
   LET l_dzfi004 = p_dzfi.dzfi004

   #新增之結構檔(Container)之Layout父節點應該在引用之畫面檔已有此Layout元件
   #而按照元件merger邏輯,此Layout父節點應該已經先被加入原行業畫面檔中(dzfi_o)
   #所以從原行業畫面檔中(dzfi_o)操作此Layout父節點的設計資料邏輯
   
   #指定新增之結構檔(Container)設計資料位於父節點下的順序位置
   LET l_dzfi005 = p_dzfi.dzfi005
   
   #將要插入的節點序號往後加1
   UPDATE sadzp168_8_dzfi_is SET dzfi005 = (dzfi005 + 1)
     WHERE dzfi004 = p_dzfi.dzfi004
       AND dzfi005 >= l_dzfi005
   
   IF SQLCA.sqlcode THEN
      LET l_errcode = SQLCA.sqlcode
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00517"
      LET g_errparam.extend = "upd check_layout().dzfi_is_1:"
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_dzfi.dzfi004 CLIPPED
      CALL cl_err()
      LET g_error_message = "ERROR-check_layout(dzfi005+1)-upd sadzp168_8_dzfi_is.", p_dzfi.dzfi004 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE, l_dzfi004, l_dzfi005
   END IF


          
   #取得新增之結構檔(Container)設計資料父節點的父節點名稱
   SELECT dzfi004 INTO l_dzfi004_parent FROM sadzp168_8_dzfi_is
      WHERE dzfi006 = p_dzfi.dzfi004

   #變更[相對位置]Container節點的父節點和[新Container]父節點一致(這樣之後重組畫面檔時,才不會有沒有Layout的Container)
   IF l_dzfi004_parent = p_dzfi_relative.dzfi004 THEN
      CASE p_add_mode
         WHEN "P"   #往上取得參考節點方式(採下一節點插入方式)
            LET l_dzfi005_relative = p_dzfi.dzfi005 - 1

            IF l_dzfi005_relative < 1 THEN
               LET l_dzfi005_relative = 1
            END IF

         WHEN "N"   #往下取得參考節點方式(採直接由此節點插入方式)
            LET l_dzfi005_relative = p_dzfi.dzfi005 + 1
      END CASE

      #將要插入的節點序號往後加1
      UPDATE sadzp168_8_dzfi_is SET dzfi005 = (dzfi005 + 1)
        WHERE dzfi004 = p_dzfi.dzfi004
          AND dzfi005 >= l_dzfi005_relative

      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00517"
         LET g_errparam.extend = "upd check_layout().dzfi_is_2:"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = p_dzfi.dzfi004 CLIPPED
         CALL cl_err()
         LET g_error_message = "ERROR-check_layout(dzfi005+1)-upd sadzp168_8_dzfi_is.", p_dzfi.dzfi004 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
         DISPLAY g_error_message
         RETURN FALSE, l_dzfi004, l_dzfi005
      END IF

      #變更[相對位置]Container節點的父節點和位於父節點的順序位置
      UPDATE sadzp168_8_dzfi_is SET dzfi004 = p_dzfi.dzfi004, dzfi005 = l_dzfi005_relative
        WHERE dzfi006 = p_dzfi_relative.dzfi006
        
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00517"
         LET g_errparam.extend = "upd check_layout().dzfi_is_3:"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = p_dzfi_relative.dzfi006 CLIPPED
         CALL cl_err()
         LET g_error_message = "ERROR-check_layout(dzfi004=p_dzfi_relative.dzfi006)-upd sadzp168_8_dzfi_is.", p_dzfi_relative.dzfi006 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
         DISPLAY g_error_message
         RETURN FALSE, l_dzfi004, l_dzfi005
      END IF

   END IF
   
   RETURN FALSE, l_dzfi004, l_dzfi005
END FUNCTION















#+ 取得參考點(widget)在舊版畫面中所屬的Container代碼
PRIVATE FUNCTION sadzp168_8_get_container(p_dzfi006)
   DEFINE p_dzfi006         LIKE dzfi_t.dzfi006         #widget所屬元件組代碼
   DEFINE l_dzfi004         LIKE dzfi_t.dzfi004         #所屬container代碼

   LET l_dzfi004 = ""
   
   SELECT dzfi004 INTO l_dzfi004 FROM sadzp168_8_dzfi_is
      WHERE dzfi006 = p_dzfi006

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-sadzp168_8_get_container()-sel sadzp168_8_dzfi_is.", p_dzfi006 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN ""
   END IF

   IF cl_null(l_dzfi004) THEN
      LET g_error_message = "ERROR-sadzp168_8_get_container()-", p_dzfi006 CLIPPED, " get container error."
      DISPLAY g_error_message
      RETURN ""
   END IF
   
   RETURN l_dzfi004
END FUNCTION
