#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: sadzp168_6
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp168_6.4gl 
# Description    : 比對新/舊版畫面設計資料的Patch工具
# Memo           : 
#+ Modifier......: No.161024-00044      2016/10/24  tracy：增加 merge 過程紀錄
#                  No.161229-00042      2016/12/29  tracy：增加 merge 過程紀錄

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"
#&include "adzp168_global.inc"

CONSTANT g_widget_group = "widget_group"                 #元件組合群組代碼前綴字元
CONSTANT g_patch_grid = "patch_grid"                     #單頭類型patch區塊

DEFINE g_dzfi001             LIKE dzfi_t.dzfi001         #結構代號

DEFINE g_dzfi002_s           LIKE dzfi_t.dzfi002         #標準畫面最大版次
DEFINE g_dzfi002_c           LIKE dzfi_t.dzfi002         #客製畫面最大版次
DEFINE g_dzfi009_s           LIKE dzfi_t.dzfi009         #客製標示='s'
DEFINE g_dzfi009_c           LIKE dzfi_t.dzfi009         #客製標示='c'
DEFINE g_dzfa003_c           LIKE dzfa_t.dzfa003         #客製標示='c'

DEFINE g_dzfi_patch_grid     type_g_dzfi                 #設計資料patch區塊
DEFINE g_dzfi017             LIKE dzfi_t.dzfi017         #客戶代號
DEFINE g_error_message       STRING                      #錯誤訊息
DEFINE g_new_container       LIKE type_t.chr1            #是否為本次新增之container

PUBLIC FUNCTION sadzp168_6(p_dzfi001, p_dzfi002_s, p_dzfi002_c)
   DEFINE p_dzfi001         LIKE dzfi_t.dzfi001         #畫面代號
   DEFINE p_dzfi002_s       LIKE dzfi_t.dzfi002         #標準畫面最大版次
   DEFINE p_dzfi002_c       LIKE dzfi_t.dzfi002         #客製畫面最大版次

   DEFINE l_time_s          DATETIME YEAR TO SECOND     #FRACTION(4)
   DEFINE l_time_e          DATETIME YEAR TO SECOND     #FRACTION(4)
   DEFINE l_result          BOOLEAN
   DEFINE l_node            om.DomNode                  #4fd domNode
   DEFINE l_count           INTEGER                     #更新資料筆數
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   LET l_time_s = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
   DISPLAY "   Strat time : ", l_time_s, ASCII 10

   #建立畫面檔設計資料temp table
   CALL sadzp168_6_crate_temp_table()
   
   IF NOT sadzp168_6_init(p_dzfi001, p_dzfi002_s, p_dzfi002_c) THEN
      DISPLAY "Cannot initialize API."         #程式初始化失敗
      RETURN FALSE, g_error_message
   END IF

   #UI的C1版次視為產中標準UI
   IF p_dzfi002_c = 1 THEN
     IF NOT sadzp168_6_get_standard(p_dzfi001, p_dzfi002_s) THEN
        RETURN FALSE, g_error_message
     END IF
   ELSE
      IF NOT sadzp168_6_compare_structure() THEN
         DISPLAY "Merger failures."
         RETURN FALSE, g_error_message
      END IF
   END IF

   UPDATE sadzp168_6_dzfi_o SET dzfi002 = p_dzfi002_c, dzfi009 = g_dzfi009_c
   UPDATE sadzp168_6_dzfj_o SET dzfj002 = p_dzfi002_c, dzfj017 = g_dzfi009_c
   UPDATE sadzp168_6_dzfk_o SET dzfk002 = p_dzfi002_c, dzfk007 = g_dzfi009_c
   UPDATE sadzp168_6_dzfl_o SET dzfl002 = p_dzfi002_c, dzfl007 = g_dzfi009_c

   #BEGIN WORK
   
   #刪除畫面代碼此客製版次的相關設計資訊
   IF NOT sadzp168_3_reload_delete(g_dzfi001, g_dzfi002_c, g_dzfi009_c) THEN
      DISPLAY "Delete failures."    #刪除失敗
   END IF
   
   INSERT INTO dzfi_t(dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
                      dzfi006, dzfi007, dzfi008, dzfi009, dzfi010,
                      dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
                      dzfi016, dzfistus, dzfi017)
     SELECT dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
            dzfi006, dzfi007, dzfi008, dzfi009, dzfi010,
            dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
            dzfi016, dzfistus, dzfi017 
       FROM sadzp168_6_dzfi_o
   
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-ins dzfi_t:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      CALL sadzp168_6_drop_temp_table()
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
        FROM sadzp168_6_dzfj_o
        
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-ins dzfj_t:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      CALL sadzp168_6_drop_temp_table()
      DISPLAY "Insert Failed："         #No.161024-00044：過程記錄
      #ROLLBACK WORK
      RETURN FALSE, g_error_message
   END IF
   # 計算 temp table 中新增的欄位數量
   SELECT count(1) INTO l_count FROM sadzp168_6_dzfj_o
   DISPLAY "Count (sadzp168_6_dzfj_o)：",l_count         #No.161024-00044：過程記錄
   
   LET l_count = 0
   # 計算真正新增的欄位數量
   SELECT count(1) INTO l_count FROM dzfj_t WHERE dzfj001 = g_dzfi001 and dzfj002 = p_dzfi002_c and dzfj017 = 'c' 
   DISPLAY "Count (sadzp168_6_dzfj)：",l_count         #No.161024-00044：過程記錄
   
   INSERT INTO dzfk_t(dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
                      dzfk006, dzfk007, dzfk008, dzfk009)
     SELECT dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
            dzfk006, dzfk007, dzfk008, dzfk009 
        FROM sadzp168_6_dzfk_o

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-ins dzfk_t:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      CALL sadzp168_6_drop_temp_table()
      #ROLLBACK WORK
      RETURN FALSE, g_error_message
   END IF
   
  INSERT INTO dzfl_t(dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, 
                     dzfl006, dzflstus, dzfl007, dzfl008)
     SELECT dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, 
            dzfl006, dzflstus, dzfl007, dzfl008
        FROM sadzp168_6_dzfl_o

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-ins dzfl_t:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      CALL sadzp168_6_drop_temp_table()
      #ROLLBACK WORK
      RETURN FALSE, g_error_message
   END IF
   
   CALL sadzp168_6_drop_temp_table()

   #COMMIT WORK
   
   LET l_time_e = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
   DISPLAY ASCII 10, ASCII 10, "    End  time : ", l_time_e
   DISPLAY "    Cost time : ", l_time_e - l_time_s

   LET g_error_message = ""
   RETURN TRUE, ""
END FUNCTION

#+ drop temp table
PRIVATE FUNCTION sadzp168_6_drop_temp_table()
   DROP TABLE sadzp168_6_dzfi_n
   DROP TABLE sadzp168_6_dzfi_o
   
   DROP TABLE sadzp168_6_dzfj_n
   DROP TABLE sadzp168_6_dzfj_o

   DROP TABLE sadzp168_6_dzfk_o
   DROP TABLE sadzp168_6_dzfl_o
      
END FUNCTION

#+ 建立temp table
PRIVATE FUNCTION sadzp168_6_crate_temp_table()

   #Create temp table 新版畫面結構設計資料暫存檔
   CREATE TEMP TABLE sadzp168_6_dzfi_n
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

   #Create temp table 舊版畫面結構結構設計資料暫存檔
   CREATE TEMP TABLE sadzp168_6_dzfi_o
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
   
   #Create temp table 新版元件組合設計資料暫存檔
   CREATE TEMP TABLE sadzp168_6_dzfj_n
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

   #Create temp table 舊版元件組合設計資料暫存檔
   CREATE TEMP TABLE sadzp168_6_dzfj_o
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
   
   #Create temp table 舊版畫面元件屬性資料暫存檔
   CREATE TEMP TABLE sadzp168_6_dzfk_o
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

   #Create temp table 舊版畫面元件屬性資料暫存檔
   CREATE TEMP TABLE sadzp168_6_dzfl_o
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
PRIVATE FUNCTION sadzp168_6_init(p_dzfi001, p_dzfi002_s, p_dzfi002_c)
   DEFINE p_dzfi001         LIKE dzfi_t.dzfi001         #畫面代號
   DEFINE p_dzfi002_s       LIKE dzfi_t.dzfi002         #標準畫面最大版次
   DEFINE p_dzfi002_c       LIKE dzfi_t.dzfi002         #客製畫面最大版次
   
   DEFINE l_sql             STRING

   INITIALIZE g_dzfi_patch_grid TO NULL

   IF cl_null(p_dzfi002_s) OR p_dzfi002_s = 0 THEN
      LET g_error_message = "ERROR-init():", cl_getmsg("adz-00295", g_lang)
      DISPLAY g_error_message
      DISPLAY "g_dzfi002_s is null."
      RETURN FALSE
   END IF

   IF cl_null(p_dzfi002_c) OR p_dzfi002_c = 0 THEN
      LET g_error_message = "ERROR-init():", cl_getmsg("adz-00296", g_lang)
      DISPLAY g_error_message
      DISPLAY "g_dzfi002_c is null."
      RETURN FALSE
   END IF

   LET g_dzfi001 = p_dzfi001     #需比對的UI畫面代號 "demo"
   LET g_dzfi002_s = p_dzfi002_s
   LET g_dzfi002_c = p_dzfi002_c
   LET g_dzfi009_s = "s"
   LET g_dzfi009_c = "c"
   LET g_dzfa003_c = "c"
   LET g_dzfi017 = FGL_GETENV("CUST")

   #UI的C1版次視為產中標準UI,不需要繼續取客制後的設計資料
   IF p_dzfi002_c = 1 THEN
      RETURN TRUE
   END IF
   
   #########################畫面結構設計資料(dzfi_t)#########################
   INSERT INTO sadzp168_6_dzfi_n
     SELECT dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
            dzfi006, dzfi007, dzfi008, dzfi009, dzfi010,
            dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
            dzfi016, dzfistus, dzfi017 
       FROM dzfi_t
       WHERE dzfi001 = g_dzfi001 AND dzfi002 = g_dzfi002_s AND dzfi009 = g_dzfi009_s

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-init()-ins sadzp168_6_dzfi_n.", g_dzfi001 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   INSERT INTO sadzp168_6_dzfi_o
     SELECT dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
            dzfi006, dzfi007, dzfi008, dzfi009, dzfi010,
            dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
            dzfi016, dzfistus, dzfi017  
       FROM dzfi_t
       WHERE dzfi001 = g_dzfi001 AND dzfi002 = g_dzfi002_c AND dzfi009 = g_dzfi009_c

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-init()-ins sadzp168_6_dzfi_o.", g_dzfi001 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   #取得新版畫面結構設計資料
   LET l_sql = "SELECT * FROM sadzp168_6_dzfi_n ",
               "  ORDER BY dzfi003"
      
   PREPARE sadzp168_6_dzfi_n FROM l_sql
   DECLARE sadzp168_6_dzfi_n_cs CURSOR FOR sadzp168_6_dzfi_n

   OPEN sadzp168_6_dzfi_n_cs
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-init()-OPEN sadzp168_6_dzfi_n_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message
      CLOSE sadzp168_6_dzfi_n_cs
      RETURN FALSE
   END IF

   
     
   #########################畫面元件組合設計資料(dzfj_t)#########################   
   #取得新版畫面元件組合設計資料
   INSERT INTO sadzp168_6_dzfj_n
     SELECT dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
            dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
            dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
            dzfj016, dzfjstus, dzfj017, dzfj018 
        FROM dzfj_t
        WHERE dzfj001 = g_dzfi001 AND dzfj002 = g_dzfi002_s AND dzfj017 = g_dzfi009_s

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-init()-ins sadzp168_6_dzfj_n.", g_dzfi001 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   #取得舊版畫面元件組合設計資料
   INSERT INTO sadzp168_6_dzfj_o
     SELECT dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
            dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
            dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
            dzfj016, dzfjstus, dzfj017, dzfj018 
        FROM dzfj_t
        WHERE dzfj001 = g_dzfi001 AND dzfj002 = g_dzfi002_c AND dzfj017 = g_dzfi009_c

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-init()-ins sadzp168_6_dzfj_o.", g_dzfi001 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   #取得新版畫面元件組合設計資料
   LET l_sql = "SELECT * FROM sadzp168_6_dzfj_n ",
               "  WHERE dzfj003 = ? ",
               "  ORDER BY dzfj004"
      
   PREPARE sadzp168_6_dzfj_n FROM l_sql
   DECLARE sadzp168_6_dzfj_n_cs CURSOR FOR sadzp168_6_dzfj_n



   #########################畫面元件屬性設計資料(dzfk_t)#########################   
   #取得舊版畫面元件屬性設計資料
   INSERT INTO sadzp168_6_dzfk_o
     SELECT dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
            dzfk006, dzfk007, dzfk008, dzfk009
        FROM dzfk_t
        WHERE dzfk001 = g_dzfi001 AND dzfk002 = g_dzfi002_c AND dzfk007 = g_dzfi009_c 

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-init()-ins sadzp168_6_dzfk_o.", g_dzfi001 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   #########################畫面元件資料項目設計資料(dzfl_t)#########################   
   #取得舊版畫面元件資料項目設計資料
   INSERT INTO sadzp168_6_dzfl_o
     SELECT dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, 
            dzfl006, dzflstus, dzfl007, dzfl008
        FROM dzfl_t
        WHERE dzfl001 = g_dzfi001 AND dzfl002 = g_dzfi002_c AND dzfl007 = g_dzfi009_c

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-init()-ins sadzp168_6_dzfl_o.", g_dzfi001 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   


   #########################比對單頭元件群組設計資料(dzfj_t)#########################
   #取得新版畫面參考點(比對點)元件組合設計資料
   LET l_sql = "SELECT * FROM sadzp168_6_dzfj_n ",
               "  WHERE dzfj003 = (SELECT dzfi006 FROM sadzp168_6_dzfi_n ",
               "                     WHERE dzfi004 = ? AND dzfi005 = ? ) ",
               "  ORDER BY dzfj004"
   
   PREPARE sadzp168_6_group_ref FROM l_sql
   DECLARE sadzp168_6_group_ref_cs CURSOR FOR sadzp168_6_group_ref




   #########################同一個Container下的元件群組設計資料(sadzp168_6_dzfi_o)##############################################
   #取得目前merge階段同一個Container下的元件群組設計資料
   LET l_sql = "SELECT dzfi006, dzfi010 FROM sadzp168_6_dzfi_o ",
               "  WHERE dzfi004 = ? ",
               "  ORDER BY dzfi005"
   
   PREPARE sadzp168_6_dzfi006_group FROM l_sql
   DECLARE sadzp168_6_dzfi006_group_cs CURSOR FOR sadzp168_6_dzfi006_group

   #########################取得同一組[元件組代碼]下的[畫面元件組合檔]widget設計資料(sadzp168_6_dzfj_n)#########################
   LET l_sql = "SELECT dzfj003, dzfj004, dzfj005, dzfj013, dzfj014, (dzfj013+dzfj015), (dzfj014+dzfj016) ",
               "  FROM sadzp168_6_dzfj_n ",
               "  WHERE dzfj003 = ? ",
               "  ORDER BY dzfj004"
   
   PREPARE sadzp168_6_dzfj003_group FROM l_sql
   DECLARE sadzp168_6_dzfj003_group_cs CURSOR FOR sadzp168_6_dzfj003_group

   RETURN TRUE
END FUNCTION

#+ 新舊畫面結構比較
PRIVATE FUNCTION sadzp168_6_compare_structure()
   DEFINE l_dzfi            type_g_dzfi            #畫面結構檔
   DEFINE l_cnt             LIKE type_t.num5     
   DEFINE l_dzfi_relative   type_g_dzfi            #新設計資料需加入在舊版畫面結構中的相對位置節點
   
   #利用新版結構資料為基礎
   FOREACH sadzp168_6_dzfi_n_cs INTO l_dzfi.*
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-compare_structure()-FOREACH sadzp168_6_dzfi_n_cs.", l_dzfi.dzfi006 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message
         #CALL cl_err("FOREACH sadzp168_6_dzfi_n_cs:", SQLCA.sqlcode, 1)
         RETURN FALSE
      END IF

      LET l_cnt = 0
      LET g_new_container = FALSE

      #排除畫面UI元件失效檔內的container代碼不merge回設計資訊(dzfa005='0')
      SELECT COUNT(1) INTO l_cnt FROM dzfa_t
        WHERE dzfa001 = l_dzfi.dzfi001
          AND dzfa002 = l_dzfi.dzfi006
          AND dzfa003 = g_dzfa003_c
          AND dzfa005 = '0'

      IF l_cnt > 0 THEN
         DISPLAY "容器設定為失效，不處理： ", l_dzfi.dzfi006    # 161229-00042
         CONTINUE FOREACH
      END IF

      #取得新版結構設計資料是否存在舊版中
      SELECT COUNT(1) INTO l_cnt FROM sadzp168_6_dzfi_o
        WHERE dzfi006 = l_dzfi.dzfi006

      #新版設計資料不存在舊版畫面結構中時,需新增此筆設計資料
      IF l_cnt = 0 AND (l_dzfi.dzfi010 = "0" OR l_dzfi.dzfi010 = "1") THEN        
      
         #先往上尋找在舊版畫面結構中要加入之節點是否有可參考的依據
         CALL sadzp168_6_previous_node(l_dzfi.*)
            RETURNING l_dzfi_relative.*

         #往上尋找不到參考點時,就往下尋找參考點方式
         IF cl_null(l_dzfi_relative.dzfi006) THEN
            CALL sadzp168_6_next_node(l_dzfi.*)
               RETURNING l_dzfi_relative.*

            #找到參考點時,新增此筆設計資料至相對位置
            IF NOT cl_null(l_dzfi_relative.dzfi006) THEN
               #此筆設計資料取代此參考點順序位置,並將參考點順序往下排序
               IF NOT sadzp168_6_add_structure(l_dzfi.*, l_dzfi_relative.*, "N") THEN
                  RETURN FALSE
               END IF
            ELSE
               #全新的一筆設計資料
               IF NOT sadzp168_6_add_structure(l_dzfi.*, l_dzfi_relative.*, "A") THEN
                  RETURN FALSE
               END IF
            END IF
         ELSE
            #此筆設計資料加入在參考點下一個順序位置
            IF NOT sadzp168_6_add_structure(l_dzfi.*, l_dzfi_relative.*, "P") THEN
               RETURN FALSE
            END IF
         END IF
      END IF
      
      #元件組合處理
      IF l_dzfi.dzfi010 = "3" THEN
         IF NOT sadzp168_6_compare_widget(l_dzfi.*) THEN
            RETURN FALSE
         END IF
      END IF
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 在新版畫面結構設計資料中往上尋找上一個節點位置,並取得在舊版畫面結構中相符合的節點
PRIVATE FUNCTION sadzp168_6_previous_node(p_dzfi)
   DEFINE p_dzfi            type_g_dzfi            #畫面結構檔

   DEFINE l_dzfi_previous   type_g_dzfi            #新版畫面上一個節點設計資料
   DEFINE r_dzfi            type_g_dzfi            #舊版畫面可加入新設計資料的節點位置

   INITIALIZE l_dzfi_previous TO NULL
   INITIALIZE r_dzfi TO NULL

   #此元件群組的序號已經為 NULL時
   #表示舊版畫面結構設計資料中無存在此筆新的設計資料參考點
   IF cl_null(p_dzfi.dzfi006) THEN
      RETURN r_dzfi.*
   END IF
   
   #取得上一個節點位置
   SELECT * INTO l_dzfi_previous.* FROM sadzp168_6_dzfi_n
     WHERE dzfi004 = p_dzfi.dzfi004 
       AND dzfi005 = p_dzfi.dzfi005 - 1 
     
   #取得舊版畫面結構中是否有相符合的節點
   IF NOT cl_null(l_dzfi_previous.dzfi006) THEN
      #只需要Container名稱一致即可,不用管它已經移到那個父節點下
      SELECT * INTO r_dzfi.* FROM sadzp168_6_dzfi_o
        WHERE dzfi006 = l_dzfi_previous.dzfi006
   ELSE
      RETURN r_dzfi.*
   END IF

   #已取得參考點時直接回傳此參考點設計資料
   #如果沒有找到繼續往上尋找
   IF NOT cl_null(r_dzfi.dzfi006) THEN
      RETURN r_dzfi.*
   ELSE
      CALL sadzp168_6_previous_node(l_dzfi_previous.*)
         RETURNING r_dzfi.*
   END IF

   IF NOT cl_null(r_dzfi.dzfi006) THEN
      RETURN r_dzfi.*
   ELSE
      INITIALIZE r_dzfi TO NULL
      RETURN r_dzfi.*
   END IF
END FUNCTION

#+ 在新版畫面結構設計資料中往上尋找下一個節點位置,並取得在舊版畫面結構中相符合的節點
PRIVATE FUNCTION sadzp168_6_next_node(p_dzfi)
   DEFINE p_dzfi            type_g_dzfi            #畫面結構檔

   DEFINE l_dzfi_next       type_g_dzfi            #新版畫面上一個節點設計資料
   DEFINE r_dzfi            type_g_dzfi            #舊版畫面可加入新設計資料的節點位置

   INITIALIZE l_dzfi_next TO NULL
   INITIALIZE r_dzfi TO NULL

   #此元件群組的序號已經為 NULL時
   #表示舊版畫面結構設計資料中無存在此筆新的設計資料參考點
   IF cl_null(p_dzfi.dzfi006) THEN
      RETURN r_dzfi.*
   END IF
   
   #取得下一個節點位置
   SELECT * INTO l_dzfi_next.* FROM sadzp168_6_dzfi_n
     WHERE dzfi004 = p_dzfi.dzfi004 
       AND dzfi005 = p_dzfi.dzfi005 + 1 

   #取得舊版畫面結構中是否有相符合的節點
   IF NOT cl_null(l_dzfi_next.dzfi006) THEN
      #只需要Container名稱一致即可,不用管它已經移到那個父節點下
      SELECT * INTO r_dzfi.* FROM sadzp168_6_dzfi_o
        WHERE dzfi006 = l_dzfi_next.dzfi006
   ELSE
      RETURN r_dzfi.*
   END IF

   #已取得參考點時直接回傳此參考點設計資料
   #如果沒有找到繼續往下尋找
   IF NOT cl_null(r_dzfi.dzfi006) THEN
      RETURN r_dzfi.*
   ELSE
      CALL sadzp168_6_next_node(l_dzfi_next.*)
         RETURNING r_dzfi.*
   END IF

   IF NOT cl_null(r_dzfi.dzfi006) THEN
      RETURN r_dzfi.*
   ELSE
      INITIALIZE r_dzfi TO NULL
      RETURN r_dzfi.*
   END IF
END FUNCTION

#+ 在舊版畫面結構設計資料中新增新版畫面結構設計資料,並將序號往下加1
PRIVATE FUNCTION sadzp168_6_add_structure(p_dzfi, p_dzfi_relative, p_add_mode)
   DEFINE p_dzfi            type_g_dzfi            #新結構檔(Container)設計資料
   DEFINE p_dzfi_relative   type_g_dzfi            #新設計資料需加入在舊版畫面結構中的相對位置節點
   DEFINE p_add_mode        LIKE type_t.chr10      #新節點加入模式
   
   DEFINE l_dzfi_ins        type_g_dzfi            #新增至DB的Container設計資料
   DEFINE l_dzfi003         LIKE dzfi_t.dzfi003    #節點設計資料ID 
   DEFINE l_dzfi004         LIKE dzfi_t.dzfi004    #群組代碼
   DEFINE l_dzfi005         LIKE dzfi_t.dzfi005    #同群組內順序編號
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_layout          LIKE type_t.chr1       #是否有正確Layout

   #add mode:(1)P:參考點在上方位置 
   #         (2)N:參考點在下方位置 
   #         (3)A:無任何參考點(為新的一筆設計資料,直接加入在父節點下的第一筆節點)--目前在CASE中不做任何處理
   CASE p_add_mode
      WHEN "P"   #往上取得參考節點方式(採下一節點插入方式)
         #檢查[新增的Container]與參考的[相對位置Container]是否有用Layout(HBox或VBox)包起來
         CALL sadzp168_6_check_layout(p_dzfi.*, p_dzfi_relative.*, p_add_mode)
            RETURNING l_layout, l_dzfi004, l_dzfi005

         #正常Layout下,都採用參考的[相對位置Container]設計資料
         IF l_layout THEN
            UPDATE sadzp168_6_dzfi_o SET dzfi005 = (dzfi005 + 1)
              WHERE dzfi004 = p_dzfi_relative.dzfi004 
                AND dzfi005 > p_dzfi_relative.dzfi005
             
            IF SQLCA.sqlcode THEN
               LET g_error_message = "ERROR-add_structure()-upd P:sadzp168_6_dzfi_o.", p_dzfi_relative.dzfi004 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
               DISPLAY g_error_message
               #CALL cl_err("upd P:sadzp168_6_dzfi_o", SQLCA.sqlcode, 1)
               RETURN FALSE
            END IF

            LET l_dzfi004 = p_dzfi_relative.dzfi004
            LET l_dzfi005 = p_dzfi_relative.dzfi005 + 1
         END IF
         
      WHEN "N"   #往下取得參考節點方式(採直接由此節點插入方式)
         #檢查[新增的Container]與參考的[相對位置Container]是否有用Layout(HBox或VBox)包起來
         CALL sadzp168_6_check_layout(p_dzfi.*, p_dzfi_relative.*, p_add_mode)
            RETURNING l_layout, l_dzfi004, l_dzfi005

         #正常Layout下,都採用參考的[相對位置Container]設計資料
         IF l_layout THEN
            UPDATE sadzp168_6_dzfi_o SET dzfi005 = (dzfi005 + 1)
              WHERE dzfi004 = p_dzfi_relative.dzfi004 
                AND dzfi005 >= p_dzfi_relative.dzfi005

            IF SQLCA.sqlcode THEN
               LET g_error_message = "ERROR-add_structure()-upd N:sadzp168_6_dzfi_o.", p_dzfi_relative.dzfi004 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
               DISPLAY g_error_message
               #CALL cl_err("upd N:sadzp168_6_dzfi_o", SQLCA.sqlcode, 1)
               RETURN FALSE
            END IF

            LET l_dzfi004 = p_dzfi_relative.dzfi004
            LET l_dzfi005 = p_dzfi_relative.dzfi005
         END IF
         
      OTHERWISE
         #全新的一筆container設計資料,節點順序採用[新版]之畫面結構順序
         #父節點採用[新版]之畫面(因父節點在merge架構中,一定會先被加入[舊版]畫面上)
         #因此將原[舊版]畫面的此父節點下之子節點順序往後+1
         UPDATE sadzp168_6_dzfi_o SET dzfi005 = (dzfi005 + 1)
           WHERE dzfi004 = p_dzfi.dzfi004
             AND dzfi005 >= p_dzfi.dzfi005

         IF SQLCA.sqlcode THEN
            LET g_error_message = "ERROR-add_structure()-upd A:sadzp168_6_dzfi_o.", p_dzfi.dzfi004 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
            DISPLAY g_error_message
            RETURN FALSE
         END IF
            
         LET l_dzfi004 = p_dzfi.dzfi004
         LET l_dzfi005 = p_dzfi.dzfi005
   END CASE

   IF cl_null(l_dzfi004) THEN
      LET l_dzfi004 = p_dzfi.dzfi004
   END IF
   
   #取得最大ID序號值
   #SELECT MAX(dzfi003) INTO l_dzfi003 FROM sadzp168_6_dzfi_o
    
   #新增此筆新版畫面結構設計資料
   LET l_dzfi_ins.dzfi001 = p_dzfi.dzfi001 CLIPPED
   LET l_dzfi_ins.dzfi002 = g_dzfi002_c
   #LET l_dzfi_ins.dzfi003 = l_dzfi003 + 1
   LET l_dzfi_ins.dzfi004 = l_dzfi004
   LET l_dzfi_ins.dzfi005 = l_dzfi005   
   LET l_dzfi_ins.dzfi006 = p_dzfi.dzfi006
   LET l_dzfi_ins.dzfi007 = p_dzfi.dzfi007
   LET l_dzfi_ins.dzfi008 = p_dzfi.dzfi008
   #LET l_dzfi_ins.dzfi009 = p_dzfi.dzfi009
   LET l_dzfi_ins.dzfi010 = p_dzfi.dzfi010
   LET l_dzfi_ins.dzfi011 = p_dzfi.dzfi011
   #LET l_dzfi_ins.dzfi012 = 99
   #LET l_dzfi_ins.dzfi013 = 0
   #LET l_dzfi_ins.dzfi014 = 0
   #LET l_dzfi_ins.dzfi015 = 0
   #LET l_dzfi_ins.dzfi016 = 0
   #LET l_dzfi_ins.dzfistus = "Y"

   CALL sadzp168_6_ins_dzfi(l_dzfi_ins.*)
      RETURNING l_success, l_dzfi_ins.*

   IF NOT l_success THEN
      RETURN FALSE
   END IF

   #已在此本版次內新增了一個Container
   LET g_new_container = TRUE
   RETURN TRUE
END FUNCTION

#+ 新舊畫面元件組合設計資料比較
PRIVATE FUNCTION sadzp168_6_compare_widget(p_dzfi)
   DEFINE p_dzfi               type_g_dzfi            #畫面結構檔
   
   DEFINE l_dzfj003            LIKE dzfj_t.dzfj003    #元件組合群組代碼
   DEFINE l_dzfi004            LIKE dzfi_t.dzfi004    #container群組代碼
   
   DEFINE l_dzfj               type_g_dzfj            #元件組合檔
   DEFINE l_cnt                LIKE type_t.num5     
   DEFINE l_dzfj_relative      type_g_dzfj            #新widget需加入在舊版畫面結構中的相對位置節點
   DEFINE l_dzfi_relative      type_g_dzfi            #參考點所屬的元件組合檔
   DEFINE l_dzfi005_max        LIKE dzfi_t.dzfi005    #畫面結構群組的最大序號
   
   INITIALIZE l_dzfj_relative TO NULL
   INITIALIZE l_dzfi_relative TO NULL
   
   #取得指定的元件組合代碼下所有widget結構
   OPEN sadzp168_6_dzfj_n_cs USING p_dzfi.dzfi006
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-compare_widget()-OPEN sadzp168_6_dzfj_n_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("OPEN sadzp168_6_dzfj_n_cs:", STATUS, 1)
      CLOSE sadzp168_6_dzfj_n_cs
      RETURN FALSE
   END IF
   
   #利用新元件組合資料為基礎
   FOREACH sadzp168_6_dzfj_n_cs INTO l_dzfj.*
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-compare_widget()-FOREACH sadzp168_6_dzfj_n_cs.", l_dzfj.dzfj005 CLIPPED, ":", cl_getmsg(STATUS, g_lang)
         DISPLAY g_error_message
         #CALL cl_err("FOREACH sadzp168_6_dzfj_n_cs:", SQLCA.sqlcode, 1)
         RETURN FALSE
      END IF

      LET l_dzfi_relative.dzfi005 = 0
      
      LET l_cnt = 0
      
      #排除畫面UI元件失效檔內的widget代碼不merge回設計資訊
      SELECT COUNT(1) INTO l_cnt FROM dzfa_t
        WHERE dzfa001 = l_dzfj.dzfj001
          AND dzfa002 = l_dzfj.dzfj005
          AND dzfa003 = g_dzfa003_c
          AND dzfa005 = '1'

      IF l_cnt > 0 THEN
         DISPLAY "設定為失效，不新增： ", l_dzfj.dzfj005    # 161229-00042
         CONTINUE FOREACH
      END IF

      #取得新版結構設計資料是否存在舊版中
      SELECT COUNT(1) INTO l_cnt FROM sadzp168_6_dzfj_o
        WHERE dzfj005 = l_dzfj.dzfj005
     
      IF l_cnt = 0 THEN
         #取得Container內是否有存在[控件高度 > 2]的widget
         IF sadzp168_6_check_height(p_dzfi.dzfi004, l_dzfj.*) THEN
            IF NOT sadzp168_6_add_widget_patch(l_dzfj.*) THEN
               RETURN FALSE
            END IF

            CONTINUE FOREACH
         END IF
         
         #先往上尋找在舊版元件組合資料中要加入之節點是否有可參考的依據
         CALL sadzp168_6_previous_widget(l_dzfj.*)
            RETURNING l_dzfj_relative.*

         #往上尋找不到參考點時,就往下尋找參考點方式
         IF cl_null(l_dzfj_relative.dzfj005) THEN
            CALL sadzp168_6_next_widget(l_dzfj.*)
               RETURNING l_dzfj_relative.*

            #找到參考點時,新增此筆設計資料至相對位置
            IF NOT cl_null(l_dzfj_relative.dzfj005) THEN
               #取得參考點所屬Container代碼
               LET l_dzfi004 = sadzp168_6_get_container(l_dzfj_relative.dzfj003)
               IF cl_null(l_dzfi004) THEN
                  RETURN FALSE
               END IF
               
               #此筆設計資料取代此參考點順序位置,並將參考點順序往下排序
               #IF NOT sadzp168_6_add_widget(p_dzfi.dzfi004, l_dzfj.*, l_dzfj_relative.*, "SG_N", l_dzfi_relative.*) THEN
               IF NOT sadzp168_6_add_widget(l_dzfi004, l_dzfj.*, l_dzfj_relative.*, "SG_N", l_dzfi_relative.*) THEN
                  RETURN FALSE
               END IF
            END IF
         ELSE
            #取得參考點所屬Container代碼
            LET l_dzfi004 = sadzp168_6_get_container(l_dzfj_relative.dzfj003)
            IF cl_null(l_dzfi004) THEN
               RETURN FALSE
            END IF
               
            #此筆設計資料加入在參考點下一個順序位置
            #IF NOT sadzp168_6_add_widget(p_dzfi.dzfi004, l_dzfj.*, l_dzfj_relative.*, "SG_P", l_dzfi_relative.*) THEN
            IF NOT sadzp168_6_add_widget(l_dzfi004, l_dzfj.*, l_dzfj_relative.*, "SG_P", l_dzfi_relative.*) THEN
               RETURN FALSE
            END IF
         END IF

         #單頭排列方式--全新的一筆控件(widget)設計資料,需再依元件群組比對上下排列關係
         #(表示在同一個Y軸情況下,找不到參考點:所以繼續往上一排/往下一排(不同Y軸)尋找參考點位置
         IF cl_null(l_dzfj_relative.dzfj005) THEN
            #先往上一排(上一個Y軸)尋找在舊版畫面結構中要加入之節點是否有可參考的依據
            CALL sadzp168_6_previous_group(p_dzfi.dzfi004, p_dzfi.dzfi005)
               RETURNING l_dzfi_relative.*
               
            IF l_dzfi_relative.dzfi005 = 0 THEN
               #取得此元件群組的序號最大值
               LET l_dzfi005_max = 0
               SELECT MAX(dzfi005) INTO l_dzfi005_max FROM sadzp168_6_dzfi_n
                 WHERE dzfi004 = p_dzfi.dzfi004

               #往上尋找不到參考點時,就往下一排(下一個Y軸)尋找參考點方式
               CALL sadzp168_6_next_group(p_dzfi.dzfi004, p_dzfi.dzfi005, l_dzfi005_max)
                  RETURNING l_dzfi_relative.*

               IF l_dzfi_relative.dzfi005 <> 0 THEN
                  #IF NOT sadzp168_6_add_widget(p_dzfi.dzfi004, l_dzfj.*, l_dzfj_relative.*, "DG_N", l_dzfi_relative.*) THEN
                  IF NOT sadzp168_6_add_widget(l_dzfi_relative.dzfi004, l_dzfj.*, l_dzfj_relative.*, "DG_N", l_dzfi_relative.*) THEN
                     RETURN FALSE
                  END IF
               ELSE
                  #都找不到參考點時,視為全新的一筆控件(widget)設計資料,直接加入成Container的最後一筆
                  #此時元件組合檔(dzfi_t)的參考組合檔就視為本筆Container設計資料(p_dzfi)
                  LET l_dzfi_relative.* = p_dzfi.*
                  IF NOT sadzp168_6_add_widget(p_dzfi.dzfi004, l_dzfj.*, l_dzfj_relative.*, "A", l_dzfi_relative.*) THEN
                     RETURN FALSE
                  END IF
               END IF
            
            ELSE
               #IF NOT sadzp168_6_add_widget(p_dzfi.dzfi004, l_dzfj.*, l_dzfj_relative.*, "DG_P", l_dzfi_relative.*) THEN
               IF NOT sadzp168_6_add_widget(l_dzfi_relative.dzfi004, l_dzfj.*, l_dzfj_relative.*, "DG_P", l_dzfi_relative.*) THEN
                  RETURN FALSE
               END IF
            END IF            
         END IF
      ELSE
         DISPLAY "sadzp168_6_already_exist： ", l_dzfj.dzfj005    # 161229-00042
      END IF
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ 在新版畫面元件組合設計資料中往上尋找上一個節點位置,並取得在舊版畫面元件組合中相符合的節點
PRIVATE FUNCTION sadzp168_6_previous_widget(p_dzfj)
   DEFINE p_dzfj            type_g_dzfj            #畫面元件組合檔

   DEFINE l_dzfj_previous   type_g_dzfj            #新版畫面上一個節點設計資料
   DEFINE r_dzfj            type_g_dzfj            #舊版畫面可加入新設計資料的節點位置

   INITIALIZE l_dzfj_previous TO NULL
   INITIALIZE r_dzfj TO NULL

   #此元件組合的序號已經為 NULL時
   #表示舊版畫面元件組合設計資料中無存在此筆新的設計資料參考點
   IF cl_null(p_dzfj.dzfj005) THEN
      RETURN r_dzfj.*
   END IF
   
   #取得上一個節點位置
   SELECT * INTO l_dzfj_previous.* FROM sadzp168_6_dzfj_n
     WHERE dzfj003 = p_dzfj.dzfj003 
       AND dzfj004 = p_dzfj.dzfj004 - 1 
     
   #取得舊版畫面元件組合中是否有相符合的節點
   IF NOT cl_null(l_dzfj_previous.dzfj005) THEN
      SELECT * INTO r_dzfj.* FROM sadzp168_6_dzfj_o
        WHERE dzfj005 = l_dzfj_previous.dzfj005
   ELSE
      RETURN r_dzfj.*
   END IF

   IF NOT cl_null(r_dzfj.dzfj005) THEN
      RETURN r_dzfj.*
   ELSE
      CALL sadzp168_6_previous_widget(l_dzfj_previous.*)
         RETURNING r_dzfj.*
   END IF

   IF NOT cl_null(r_dzfj.dzfj005) THEN
      RETURN r_dzfj.*
   ELSE
      INITIALIZE r_dzfj TO NULL
      RETURN r_dzfj.*
   END IF
END FUNCTION

#+ 在新版畫面元件組合設計資料中往上尋找下一個節點位置,並取得在舊版畫面元件組合中相符合的節點
PRIVATE FUNCTION sadzp168_6_next_widget(p_dzfj)
   DEFINE p_dzfj            type_g_dzfj            #畫面元件組合檔

   DEFINE l_dzfj_next       type_g_dzfj            #新版畫面上一個節點設計資料
   DEFINE r_dzfj            type_g_dzfj            #舊版畫面可加入新設計資料的節點位置

   INITIALIZE l_dzfj_next TO NULL
   INITIALIZE r_dzfj TO NULL
   
   #此元件組合的序號已經為 NULL時
   #表示舊版畫面元件組合設計資料中無存在此筆新的設計資料參考點
   IF cl_null(p_dzfj.dzfj005) THEN
      RETURN r_dzfj.*
   END IF
   
   #取得下一個節點位置
   SELECT * INTO l_dzfj_next.* FROM sadzp168_6_dzfj_n
     WHERE dzfj003 = p_dzfj.dzfj003 
       AND dzfj004 = p_dzfj.dzfj004 + 1 
     
   #取得舊版畫面元件組合中是否有相符合的節點
   IF NOT cl_null(l_dzfj_next.dzfj005) THEN
      SELECT * INTO r_dzfj.* FROM sadzp168_6_dzfj_o
        WHERE dzfj005 = l_dzfj_next.dzfj005
   ELSE
      RETURN r_dzfj.*
   END IF

   IF NOT cl_null(r_dzfj.dzfj005) THEN
      RETURN r_dzfj.*
   ELSE
      CALL sadzp168_6_next_widget(l_dzfj_next.*)
         RETURNING r_dzfj.*
   END IF

   IF NOT cl_null(r_dzfj.dzfj005) THEN
      RETURN r_dzfj.*
   ELSE
      INITIALIZE r_dzfj TO NULL
      RETURN r_dzfj.*
   END IF
END FUNCTION

#+ 在舊版畫面元件組合設計資料中新增新版畫面元件組合設計資料,並將序號往下加1
PRIVATE FUNCTION sadzp168_6_add_widget(p_dzfi004, p_dzfj, p_dzfj_relative, p_add_mode, p_dzfi_relative)
   DEFINE p_dzfi004            LIKE dzfi_t.dzfi004    #新控件所屬Container群組代碼
   DEFINE p_dzfj               type_g_dzfj            #新控件(widget)設計資料
   DEFINE p_dzfj_relative      type_g_dzfj            #新設計資料需加入在舊版畫面元件組合中的相對位置節點
   DEFINE p_add_mode           LIKE type_t.chr10      #新節點加入模式(SG_P:同一群組前面參考點; SG_N:同一群組後面參考點; DG_P:上一個群組參考點; DG_N:下一個群組參考點)
   #DEFINE p_dzfi004            LIKE dzfi_t.dzfi004    #container群組代碼
   #DEFINE p_dzfi005_relative   LIKE dzfi_t.dzfi005    #新元件組合需加入的參考點位置序號
   DEFINE p_dzfi_relative      type_g_dzfi            #參考點所屬的元件組合檔
   
   DEFINE l_dzfi_ins           type_g_dzfi            #畫面結構檔
   DEFINE l_dzfj_ins           type_g_dzfj            #新增至DB的widget設計資料
   
   DEFINE l_dzfj003            LIKE dzfj_t.dzfj003    #widget所屬群組
   DEFINE l_dzfj004            LIKE dzfj_t.dzfj004    #widget在群組下的順序位置
   DEFINE l_dzfi003            LIKE dzfi_t.dzfi003    #畫面結構設計資料ID 
   DEFINE l_dzfi005            LIKE dzfi_t.dzfi005    #畫面結構群組的最大序號
   DEFINE l_success            LIKE type_t.chr1

   INITIALIZE l_dzfi_ins TO NULL

   ###IF sadzp168_6_check_height(p_dzfi004, p_dzfj_relative.*) THEN
   ###END IF

   DISPLAY "sadzp168_6_new：",p_dzfj.dzfj005         #No.161024-00044：過程記錄
      
   #add mode:(1)P:參考點在上方位置 
   #         (2)N:參考點在下方位置 
   #         (3)A:無任何參考點(為新的一筆設計資料,直接加入在父節點下的第一筆節點)
   CASE p_add_mode
      WHEN "SG_P"   #同一群組前面參考點:往上取得參考節點方式(採下一節點插入方式)
         #元件群組設計資料可直接插入舊版的元件組合檔
         #將要插入的節點序號往後加1
         UPDATE sadzp168_6_dzfj_o SET dzfj004 = (dzfj004 + 1)
           WHERE dzfj003 = p_dzfj_relative.dzfj003 
             AND dzfj004 > p_dzfj_relative.dzfj004

         IF SQLCA.sqlcode THEN
            LET g_error_message = "ERROR-add_widget()-upd SG_P:sadzp168_6_dzfj_o.", p_dzfj_relative.dzfj003 CLIPPED, ":[",SQLCA.sqlcode,"]", cl_getmsg(SQLCA.sqlcode, g_lang)
            DISPLAY g_error_message
            #CALL cl_err("upd SG_P:sadzp168_6_dzfj_o", SQLCA.sqlcode, 1)
            DISPLAY "Insert Failed..."         #No.161024-00044：過程記錄
            RETURN FALSE
         END IF
         DISPLAY "Insert Sucess..."         #No.161024-00044：過程記錄
         LET l_dzfj003 = p_dzfj_relative.dzfj003
         
         #此筆設計資料加入在參考點下一個順序位置
         LET l_dzfj004 = p_dzfj_relative.dzfj004 + 1

         CALL sadzp168_6_set_widget_pos(p_add_mode, p_dzfi004, "", p_dzfj.*, p_dzfj_relative.*)
            RETURNING l_success, p_dzfj.*
         
         IF NOT l_success THEN
            RETURN FALSE
         END IF

      WHEN "DG_P"   #往上已取得個群組的參考點:在參考群組下一個序號加入一組全新的元件群組設計資料
         UPDATE sadzp168_6_dzfi_o SET dzfi005 = (dzfi005 + 1)
           WHERE dzfi004 = p_dzfi_relative.dzfi004
             AND dzfi005 > p_dzfi_relative.dzfi005

         IF SQLCA.sqlcode THEN
            LET g_error_message = "ERROR-add_widget()-upd DG_P:sadzp168_6_dzfi_o.", p_dzfi_relative.dzfi004 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
            DISPLAY g_error_message
            #CALL cl_err("upd DG_P:sadzp168_6_dzfi_o", SQLCA.sqlcode, 1)
            DISPLAY "Insert Failed..."         #No.161024-00044：過程記錄
            RETURN FALSE
         END IF
         DISPLAY "Insert Sucess..."         #No.161024-00044：過程記錄
         CALL sadzp168_6_set_widget_pos(p_add_mode, p_dzfi004, p_dzfi_relative.dzfi006, p_dzfj.*, p_dzfj_relative.*)
            RETURNING l_success, p_dzfj.*
         
         IF NOT l_success THEN
            RETURN FALSE
         END IF

         #####insert 畫面結構檔資枓表#####
         #取得最大ID序號值
         #SELECT MAX(dzfi003) INTO l_dzfi003 FROM sadzp168_6_dzfi_o
         
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
         #LET l_dzfi_ins.dzfi012 = 99
         #LET l_dzfi_ins.dzfi013 = 0
         #LET l_dzfi_ins.dzfi014 = 0
         #LET l_dzfi_ins.dzfi015 = 0
         #LET l_dzfi_ins.dzfi016 = 0
         #LET l_dzfi_ins.dzfistus = "Y"

         CALL sadzp168_6_ins_dzfi(l_dzfi_ins.*)
            RETURNING l_success, l_dzfi_ins.*

         IF NOT l_success THEN
            RETURN FALSE
         END IF

         LET l_dzfj003 = l_dzfi_ins.dzfi006
         LET l_dzfj004 = 1



      WHEN "SG_N"   #同一群組後面參考點:往下取得參考節點方式(採直接由此節點插入方式)
         #元件群組設計資料可直接插入舊版的元件組合檔
         #將要插入的節點序號往後加1
         UPDATE sadzp168_6_dzfj_o SET dzfj004 = (dzfj004 + 1)
           WHERE dzfj003 = p_dzfj_relative.dzfj003 
             AND dzfj004 >= p_dzfj_relative.dzfj004

         IF SQLCA.sqlcode THEN
            LET g_error_message = "ERROR-add_widget()-upd SG_N:sadzp168_6_dzfj_o.", p_dzfj_relative.dzfj003 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
            DISPLAY g_error_message
            #CALL cl_err("upd N:sadzp168_6_dzfj_o", SQLCA.sqlcode, 1)
            DISPLAY "Insert Failed..."         #No.161024-00044：過程記錄
            RETURN FALSE
         END IF
         DISPLAY "Insert Sucess..."         #No.161024-00044：過程記錄
         LET l_dzfj003 = p_dzfj_relative.dzfj003
         
         #此筆設計資料取代此參考點順序位置,並將參考點順序往下排序
         LET l_dzfj004 = p_dzfj_relative.dzfj004
         
         CALL sadzp168_6_set_widget_pos(p_add_mode, p_dzfi004, "", p_dzfj.*, p_dzfj_relative.*)
            RETURNING l_success, p_dzfj.*
         
         IF NOT l_success THEN
            RETURN FALSE
         END IF

      WHEN "DG_N"   #往下已取得群組的參考點:在參考群組上一個序號加入一組全新的元件群組設計資料
         #將要插入的元件群組序號往後加1
         UPDATE sadzp168_6_dzfi_o SET dzfi005 = (dzfi005 + 1)
           WHERE dzfi004 = p_dzfi_relative.dzfi004
             AND dzfi005 >= p_dzfi_relative.dzfi005

         IF SQLCA.sqlcode THEN
            LET g_error_message = "ERROR-add_widget()-upd DG_N:sadzp168_6_dzfj_o.", p_dzfi_relative.dzfi004 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
            DISPLAY g_error_message
            #CALL cl_err("upd N:sadzp168_6_dzfj_o", SQLCA.sqlcode, 1)
            DISPLAY "Insert Failed..."         #No.161024-00044：過程記錄
            RETURN FALSE
         END IF
         DISPLAY "Insert Sucess..."         #No.161024-00044：過程記錄
         CALL sadzp168_6_set_widget_pos(p_add_mode, p_dzfi004, p_dzfi_relative.dzfi006, p_dzfj.*, p_dzfj_relative.*)
            RETURNING l_success, p_dzfj.*
         
         IF NOT l_success THEN
            RETURN FALSE
         END IF

         #####insert 畫面結構檔資枓表#####
         #取得最大ID序號值
         #SELECT MAX(dzfi003) INTO l_dzfi003 FROM sadzp168_6_dzfi_o
         
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
         #LET l_dzfi_ins.dzfi012 = 99
         #LET l_dzfi_ins.dzfi013 = 0
         #LET l_dzfi_ins.dzfi014 = 0
         #LET l_dzfi_ins.dzfi015 = 0
         #LET l_dzfi_ins.dzfi016 = 0
         #LET l_dzfi_ins.dzfistus = "Y"

         CALL sadzp168_6_ins_dzfi(l_dzfi_ins.*)
            RETURNING l_success, l_dzfi_ins.*

         IF NOT l_success THEN
            RETURN FALSE
         END IF

         LET l_dzfj003 = l_dzfi_ins.dzfi006
         LET l_dzfj004 = 1



      WHEN "A"   #無任何參考點(直接新增在父節點下的最後面順序位置)
         #取得最大ID序號值
         #SELECT MAX(dzfi003) INTO l_dzfi003 FROM sadzp168_6_dzfi_o

         #取得所屬container下最大序號ID
         SELECT MAX(dzfi005) INTO l_dzfi005 FROM sadzp168_6_dzfi_o
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
         #LET l_dzfi_ins.dzfi012 = 99
         #LET l_dzfi_ins.dzfi013 = 0
         #LET l_dzfi_ins.dzfi014 = 0
         #LET l_dzfi_ins.dzfi015 = 0
         #LET l_dzfi_ins.dzfi016 = 0
         #LET l_dzfi_ins.dzfistus = "Y"

         CALL sadzp168_6_ins_dzfi(l_dzfi_ins.*)
            RETURNING l_success, l_dzfi_ins.*

         IF NOT l_success THEN
            DISPLAY "Insert Failed..."         #No.161024-00044：過程記錄
            RETURN FALSE
         END IF

         LET l_dzfj003 = l_dzfi_ins.dzfi006
         LET l_dzfj004 = 1

         DISPLAY "Insert Sucess..."         #No.161024-00044：過程記錄

      OTHERWISE
      
   END CASE
    
   #新增此筆新版畫面元件組合(widget)設計資料
   LET l_dzfj_ins.dzfj001 = p_dzfj.dzfj001 CLIPPED
   LET l_dzfj_ins.dzfj002 = g_dzfi002_c
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

   INSERT INTO sadzp168_6_dzfj_o (dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
                                  dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
                                  dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
                                  dzfj016, dzfjstus, dzfj017, dzfj018)
     VALUES (l_dzfj_ins.dzfj001, l_dzfj_ins.dzfj002, l_dzfj_ins.dzfj003, l_dzfj_ins.dzfj004, l_dzfj_ins.dzfj005, 
             l_dzfj_ins.dzfj006, l_dzfj_ins.dzfj007, l_dzfj_ins.dzfj008, l_dzfj_ins.dzfj009, l_dzfj_ins.dzfj010, 
             l_dzfj_ins.dzfj011, l_dzfj_ins.dzfj012, l_dzfj_ins.dzfj013, l_dzfj_ins.dzfj014, l_dzfj_ins.dzfj015, 
             l_dzfj_ins.dzfj016, l_dzfj_ins.dzfjstus, l_dzfj_ins.dzfj017, l_dzfj_ins.dzfj018) 

   DISPLAY "sadzp168_6_insert：",p_dzfj.dzfj005         #No.161024-00044：過程記錄
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-add_widget()-ins sadzp168_6_dzfj_o.", l_dzfj_ins.dzfj005 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("ins sadzp168_6_dzfj_o", SQLCA.sqlcode, 1)
      DISPLAY "Insert Failed："         #No.161024-00044：過程記錄
      RETURN FALSE
   END IF
   DISPLAY "Insert Success..."         #No.161024-00044：過程記錄
   
   INSERT INTO sadzp168_6_dzfk_o 
     SELECT dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
            dzfk006, dzfk007, dzfk008, dzfk009
       FROM dzfk_t
       WHERE dzfk001 = l_dzfj_ins.dzfj001 AND dzfk002 = g_dzfi002_s 
         AND dzfk003 = l_dzfj_ins.dzfj005 AND dzfk007 = g_dzfi009_s 

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-add_widget()-ins sadzp168_6_dzfk_o.", l_dzfj_ins.dzfj005 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("ins sadzp168_6_dzfk_o:" || p_dzfj.dzfj005 CLIPPED, SQLCA.sqlcode, 1)
      RETURN FALSE
   END IF
 
   INSERT INTO sadzp168_6_dzfl_o 
     SELECT dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, 
            dzfl006, dzflstus, dzfl007, dzfl008
       FROM dzfl_t
       WHERE dzfl001 = l_dzfj_ins.dzfj001 AND dzfl002 = g_dzfi002_s 
         AND dzfl003 = l_dzfj_ins.dzfj005 AND dzfl007 = g_dzfi009_s

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-add_widget()-ins sadzp168_6_dzfl_o.", l_dzfj_ins.dzfj005 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("ins sadzp168_6_dzfl_o:" || p_dzfj.dzfj005 CLIPPED, SQLCA.sqlcode, 1)
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

#+ 在新版畫面結構設計資料中往上尋找上一個元件組合群組,並取得在舊版畫面結構中相符合的節點
PRIVATE FUNCTION sadzp168_6_previous_group(p_dzfi004, p_dzfi005)
   DEFINE p_dzfi004         LIKE dzfi_t.dzfi004    #container群組代碼
   DEFINE p_dzfi005         LIKE dzfi_t.dzfi005    #順序序號
   
   DEFINE l_dzfj_n          type_g_dzfj            #畫面元件組合檔
   DEFINE l_dzfj_o          type_g_dzfj            #舊版畫面可加入新設計資料的節點位置 

   DEFINE r_dzfi_relative   type_g_dzfi            #參考點所屬的元件組合檔
   #DEFINE r_dzfi005         LIKE dzfi_t.dzfi005    #順序序號
   
   INITIALIZE l_dzfj_o TO NULL
   INITIALIZE r_dzfi_relative TO NULL
   LET r_dzfi_relative.dzfi005 = 0
   
   #此元件組合的序號已經小於1時
   #表示舊版畫面元件組合設計資料中無存在此筆新的設計資料參考點
   IF p_dzfi005 < 1 THEN
      RETURN r_dzfi_relative.*
   END IF

   #取得上一組元件組合檔
   LET p_dzfi005 = p_dzfi005 - 1
   
   #取得指定的元件組合代碼下所有widget結構
   OPEN sadzp168_6_group_ref_cs USING p_dzfi004, p_dzfi005
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-previous_group()-OPEN sadzp168_6_group_ref_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("OPEN sadzp168_6_group_ref_cs:", STATUS, 1)
      CLOSE sadzp168_6_group_ref_cs
      LET r_dzfi_relative.dzfi005 = 0
      RETURN r_dzfi_relative.*
   END IF
   
   #利用新元件組合資料為基礎
   FOREACH sadzp168_6_group_ref_cs INTO l_dzfj_n.*
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-previous_group()-FOREACH sadzp168_6_group_ref_cs.", l_dzfj_n.dzfj005 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message
         #CALL cl_err("FOREACH sadzp168_6_group_ref_cs:", SQLCA.sqlcode, 1)
         EXIT FOREACH
      END IF
      
      #取得舊版畫面元件組合中是否有相符合的節點
      SELECT * INTO l_dzfj_o.* FROM sadzp168_6_dzfj_o
        WHERE dzfj005 = l_dzfj_n.dzfj005

      #找到參考點時,取得此元件組合檔資訊
      IF NOT cl_null(l_dzfj_o.dzfj005) THEN
         SELECT * INTO r_dzfi_relative.* FROM sadzp168_6_dzfi_o
           WHERE dzfi006 = l_dzfj_o.dzfj003
         EXIT FOREACH
      END IF
   END FOREACH

   #已取得參考點時直接回傳元件組合檔資訊
   #如果沒有找到繼續往上尋找
   IF NOT cl_null(l_dzfj_o.dzfj005) THEN
      RETURN r_dzfi_relative.*
   ELSE
      CALL sadzp168_6_previous_group(p_dzfi004, p_dzfi005)
         RETURNING r_dzfi_relative.*
   END IF

   IF NOT cl_null(r_dzfi_relative.dzfi005) AND r_dzfi_relative.dzfi005 <> 0 THEN
      RETURN r_dzfi_relative.*
   ELSE
      LET r_dzfi_relative.dzfi005 = 0
      RETURN r_dzfi_relative.*
   END IF
END FUNCTION

#+ 在新版畫面結構設計資料中往下尋找下一個元件組合群組,並取得在舊版畫面結構中相符合的節點
PRIVATE FUNCTION sadzp168_6_next_group(p_dzfi004, p_dzfi005, p_dzfi005_max)
   DEFINE p_dzfi004         LIKE dzfi_t.dzfi004    #container群組代碼
   DEFINE p_dzfi005         LIKE dzfi_t.dzfi005    #順序序號
   DEFINE p_dzfi005_max     LIKE dzfi_t.dzfi005    #畫面結構群組的最大序號
   
   DEFINE l_dzfj_n          type_g_dzfj            #畫面元件組合檔
   DEFINE l_dzfj_o          type_g_dzfj            #舊版畫面可加入新設計資料的節點位置 

   DEFINE r_dzfi_relative   type_g_dzfi            #參考點所屬的元件組合檔
   #DEFINE r_dzfi005         LIKE dzfi_t.dzfi005    #順序序號
   
   INITIALIZE l_dzfj_o TO NULL
   LET r_dzfi_relative.dzfi005 = 0
   
   #此元件組合的序號已經大於此container下的元件組合最大序號時
   #表示舊版畫面元件組合設計資料中無存在此筆新的設計資料參考點
   IF p_dzfi005 > p_dzfi005_max THEN
      RETURN r_dzfi_relative.*
   END IF
   
   #取得下一組元件組合檔
   LET p_dzfi005 = p_dzfi005 + 1
   
   #取得指定的元件組合代碼下所有widget結構
   OPEN sadzp168_6_group_ref_cs USING p_dzfi004, p_dzfi005
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-next_group()-OPEN sadzp168_6_group_ref_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("OPEN sadzp168_6_group_ref_cs:", STATUS, 1)
      CLOSE sadzp168_6_group_ref_cs
      LET r_dzfi_relative.dzfi005 = 0
      RETURN r_dzfi_relative.*
   END IF
   
   #利用新元件組合資料為基礎
   FOREACH sadzp168_6_group_ref_cs INTO l_dzfj_n.*
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-next_group()-FOREACH sadzp168_6_group_ref_cs.", l_dzfj_n.dzfj005 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message
         #CALL cl_err("FOREACH sadzp168_6_group_ref_cs:", SQLCA.sqlcode, 1)
         EXIT FOREACH
      END IF

      LET l_dzfj_n.dzfj005 = l_dzfj_n.dzfj005 CLIPPED
      
      #取得舊版畫面元件組合中是否有相符合的節點
      SELECT * INTO l_dzfj_o.* FROM sadzp168_6_dzfj_o
        WHERE dzfj005 = l_dzfj_n.dzfj005

      IF NOT cl_null(l_dzfj_o.dzfj005) THEN
         SELECT * INTO r_dzfi_relative.* FROM sadzp168_6_dzfi_o
            WHERE dzfi004 = p_dzfi004 AND dzfi006 = l_dzfj_o.dzfj003
         EXIT FOREACH
      END IF
   END FOREACH

   IF NOT cl_null(l_dzfj_o.dzfj005) THEN
      RETURN r_dzfi_relative.*
   ELSE
      CALL sadzp168_6_next_group(p_dzfi004, p_dzfi005, p_dzfi005_max)
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
PRIVATE FUNCTION sadzp168_6_ins_dzfi(p_dzfi)
   DEFINE p_dzfi               type_g_dzfi
   
   DEFINE l_dzfi003            LIKE dzfi_t.dzfi003    #畫面結構設計資料ID 
   DEFINE l_dzfi_ins           type_g_dzfi            #畫面結構檔
   
   #取得最大ID序號值
   SELECT MAX(dzfi003) INTO l_dzfi003 FROM sadzp168_6_dzfi_o
   
   LET l_dzfi_ins.dzfi001 = p_dzfi.dzfi001 CLIPPED
   LET l_dzfi_ins.dzfi002 = g_dzfi002_c
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

   INSERT INTO sadzp168_6_dzfi_o (dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
                                   dzfi006, dzfi007, dzfi008, dzfi009, dzfi010, 
                                   dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
                                   dzfi016, dzfistus, dzfi017)
     VALUES (l_dzfi_ins.dzfi001, l_dzfi_ins.dzfi002, l_dzfi_ins.dzfi003, l_dzfi_ins.dzfi004, l_dzfi_ins.dzfi005, 
             l_dzfi_ins.dzfi006, l_dzfi_ins.dzfi007, l_dzfi_ins.dzfi008, l_dzfi_ins.dzfi009, l_dzfi_ins.dzfi010, 
             l_dzfi_ins.dzfi011, l_dzfi_ins.dzfi012, l_dzfi_ins.dzfi013, l_dzfi_ins.dzfi014, l_dzfi_ins.dzfi015, 
             l_dzfi_ins.dzfi016, l_dzfi_ins.dzfistus, l_dzfi_ins.dzfi017) 

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-ins_dzfi()-ins sadzp168_6_dzfi_o.", l_dzfi_ins.dzfi006 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("ins sadzp168_6_dzfi_o", SQLCA.sqlcode, 1)
      RETURN FALSE, l_dzfi_ins.*
   END IF

   DISPLAY "sadzp168_6_new_container : ",l_dzfi_ins.dzfi006   #  161229-00042
   
   IF (NOT cl_null(l_dzfi_ins.dzfi007)) AND l_dzfi_ins.dzfi010 <> "3" THEN
      INSERT INTO sadzp168_6_dzfk_o 
        SELECT dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
               dzfk006, dzfk007, dzfk008, dzfk009
          FROM dzfk_t
          WHERE dzfk001 = l_dzfi_ins.dzfi001 AND dzfk002 = g_dzfi002_s 
            AND dzfk003 = l_dzfi_ins.dzfi006 AND dzfk007 = g_dzfi009_s
      
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-ins_dzfi()-ins sadzp168_6_dzfk_o.", l_dzfi_ins.dzfi006 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message
         #CALL cl_err("ins sadzp168_6_dzfk_o:" || p_dzfi.dzfi006 CLIPPED, SQLCA.sqlcode, 1)
         RETURN FALSE, l_dzfi_ins.*
      END IF
   END IF 

   RETURN TRUE, l_dzfi_ins.*
END FUNCTION

#+ 重新計算新插入的widget X, Y軸位置
PRIVATE FUNCTION sadzp168_6_set_widget_pos(p_add_mode, p_dzfi004, p_dzfi006_relative, p_dzfj_new, p_dzfj_relative)
   DEFINE p_add_mode           LIKE type_t.chr10      #新節點加入模式
   DEFINE p_dzfi004            LIKE dzfi_t.dzfi004    #新widget所屬Container
   DEFINE p_dzfi006_relative   LIKE dzfi_t.dzfi006    #新widget參考群組
   DEFINE p_dzfj_new           type_g_dzfj            #新增的畫面元件組合檔(新widget設計資料)
   DEFINE p_dzfj_relative      type_g_dzfj            #新widget設計資料需加入在舊版參考點[畫面元件組合檔]中的相對位置節點
   
   DEFINE l_posX               LIKE dzfj_t.dzfj013    #新控件的X軸
   DEFINE l_posY               LIKE dzfj_t.dzfj014    #新控件的Y軸
   DEFINE l_dzfj003            LIKE dzfj_t.dzfj003

   CASE p_add_mode
      WHEN "SG_P"   #同一群組前面參考點:往上取得參考節點方式(採下一節點插入方式)
         #同一群組(同一排Y軸)插入:所以X軸位置直接加在參考點後面(+1:留一個空白),預設[Y軸座標]和參考點一樣
         #新控件X軸 = 參考點控件X軸 + 參考點控件寬度 + 1
         LET p_dzfj_new.dzfj013 = p_dzfj_relative.dzfj013 + p_dzfj_relative.dzfj015 + 1
         LET p_dzfj_new.dzfj014 = p_dzfj_relative.dzfj014

         #重新計算在同一個container下,因為插入新的widget位置,而其它控件的位移關係
         IF NOT sadzp168_6_widget_pos_calc(p_dzfi004, p_dzfj_relative.dzfj003, p_dzfj_new.*) THEN
            RETURN FALSE, p_dzfj_new.*
         END IF

      WHEN "SG_N"   #同一群組前面參考點:往下取得參考節點方式(採上一節點插入方式)
         #同一群組(同一排Y軸)插入:所以[X軸位置]直接取代[參考點]X軸位置,預設[Y軸座標]和參考點一樣(參考點往下一個X軸位移量移動)
         #新控件X軸 = 參考點控件X軸
         LET p_dzfj_new.dzfj013 = p_dzfj_relative.dzfj013
         LET p_dzfj_new.dzfj014 = p_dzfj_relative.dzfj014

         #重新計算在同一個container下,因為插入新的widget位置,而其它控件的位移關係
         IF NOT sadzp168_6_widget_pos_calc(p_dzfi004, p_dzfj_relative.dzfj003, p_dzfj_new.*) THEN
            RETURN FALSE, p_dzfj_new.*
         END IF



      WHEN "DG_P"   #往上已取得個群組的參考點:在參考群組下一個序號加入一組全新的元件群組設計資料
         #取得Container下的最小X軸數值(為新控件的X軸參考依據)
         SELECT MIN(dzfj013) INTO l_posX FROM sadzp168_6_dzfj_o
           WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_6_dzfi_o
                               WHERE dzfi004 = p_dzfi004)

         #取得上一個參考點所用完的Y軸高度
         SELECT MAX(dzfj014+dzfj016) INTO l_posY FROM sadzp168_6_dzfj_o
           WHERE dzfj003 = p_dzfi006_relative

         IF p_dzfj_new.dzfj013 < l_posX THEN
            LET p_dzfj_new.dzfj013 = l_posX
         END IF
         
         LET p_dzfj_new.dzfj014 = l_posY

#         # 列出被調整Y軸的元件
#         DECLARE dzfj014_cur FOR
#            SELECT dzfj003 FROM sadzp168_6_dzfj_o
#              WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_6_dzfi_o
#                                  WHERE dzfi004 = p_dzfi004)
#                AND dzfj014 >= p_dzfj_new.dzfj014
#                
#         FOREACH dzfj014_cur into 
         
         #Container下的群組元件Y軸 > 新控件的Y軸, 往下位移(位移量為新控件的高度)
         UPDATE sadzp168_6_dzfj_o SET dzfj014 = (dzfj014 + p_dzfj_new.dzfj016)
           WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_6_dzfi_o
                               WHERE dzfi004 = p_dzfi004)
             AND dzfj014 >= p_dzfj_new.dzfj014
             
         IF SQLCA.sqlcode THEN
            LET g_error_message = "ERROR-set_widget_pos(dzfj014+dzfj016)-upd DG_P:sadzp168_6_dzfj_o.", p_dzfi004 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
            DISPLAY g_error_message
            #CALL cl_err("upd DG_P:sadzp168_6_dzfi_o", SQLCA.sqlcode, 1)
            RETURN FALSE, p_dzfj_new.*
         END IF

      WHEN "DG_N"   #往下已取得群組的參考點:在參考群組上一個序號加入一組全新的元件群組設計資料
         #取得Container下的最小X軸數值(為新控件的X軸參考依據)
         SELECT MIN(dzfj013) INTO l_posX FROM sadzp168_6_dzfj_o
           WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_6_dzfi_o
                               WHERE dzfi004 = p_dzfi004)

         #取得此元件群組的Y軸高度(理論上同一排widget的Y軸應該相同)
         SELECT DISTINCT dzfj014 INTO l_posY FROM sadzp168_6_dzfj_o
           WHERE dzfj003 = p_dzfi006_relative
              
         IF p_dzfj_new.dzfj013 < l_posX THEN
            LET p_dzfj_new.dzfj013 = l_posX
         END IF

         LET p_dzfj_new.dzfj014 = l_posY

         #Container下的群組元件Y軸 > 新控件的Y軸, 往下位移(位移量為新控件的高度)
         UPDATE sadzp168_6_dzfj_o SET dzfj014 = (dzfj014 + p_dzfj_new.dzfj016)
           WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_6_dzfi_o
                               WHERE dzfi004 = p_dzfi004)
             AND dzfj014 >= p_dzfj_new.dzfj014

         IF SQLCA.sqlcode THEN
            LET g_error_message = "ERROR-set_widget_pos(dzfj014+dzfj016)-upd DG_N:sadzp168_6_dzfj_o.", p_dzfi004 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
            DISPLAY g_error_message
            #CALL cl_err("upd N:sadzp168_6_dzfj_o", SQLCA.sqlcode, 1)
            RETURN FALSE, p_dzfj_new.*
         END IF

      WHEN "A"   #無任何參考點(直接新增在父節點下的最後面順序位置)
         #取得Container下的最小X軸數值(為新控件的X軸參考依據)
         SELECT MIN(dzfj013) INTO l_posX FROM sadzp168_6_dzfj_o
           WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_6_dzfi_o
                               WHERE dzfi004 = p_dzfi004)

         #取得Container下已用掉最大Y軸高度(為新控件的Y軸參考依據)
         SELECT MAX(dzfj014+dzfj016) INTO l_posY FROM sadzp168_6_dzfj_o
           WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_6_dzfi_o
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
PRIVATE FUNCTION sadzp168_6_widget_pos_calc(p_dzfi004, p_dzfj003_relative, p_dzfj_new)
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
   
   DEFINE l_dzfj005            LIKE dzfj_t.dzfj005
   DEFINE l_dzfi007            LIKE dzfi_t.dzfi007    #群組實際類型

   IF cl_null(p_dzfi004) THEN
      DISPLAY "ERROR-沒有任何參考點位置."
      RETURN FALSE
   END IF
   
   #取得同一群組代碼(dzfi004)下的container設計資料
   OPEN sadzp168_6_dzfi006_group_cs USING p_dzfi004
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-widget_pos_calc()-OPEN sadzp168_6_dzfi006_group_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("OPEN sadzp168_6_dzfi006_group_cs:", STATUS, 1)
      CLOSE sadzp168_6_dzfi006_group_cs
      RETURN FALSE
   END IF
   
   #逐一取得同一畫面結構設計資料
   FOREACH sadzp168_6_dzfi006_group_cs INTO l_dzfi006, l_dzfi010
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-widget_pos_calc()-FOREACH sadzp168_6_dzfi006_group_cs,", l_dzfi006 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message
         #CALL cl_err("FOREACH sadzp168_6_dzfi006_group_cs:", SQLCA.sqlcode, 1)
         RETURN FALSE
      END IF
   
      #群組包含widget設計資料(元件類型:3)
      IF l_dzfi010 = "3" THEN
         #新插入控件與[舊版次同一元件群組]時
         IF l_dzfi006 = p_dzfj003_relative THEN

			# No.161229-00042 列出被調整的元件清單
            DECLARE dzfj005_cur CURSOR FOR 
               SELECT dzfj005 FROM sadzp168_6_dzfj_o
                  WHERE dzfj003 = l_dzfi006
                     AND dzfj013 >= p_dzfj_new.dzfj013
                   
            FOREACH dzfj005_cur INTO l_dzfj005
               Display "調整位置： ",l_dzfj005
            END FOREACH
			# 161229-00042：END

            #同一群組(同一排Y軸)插入:所以X軸位置直接加在參考點後面(+1:留一個空白),預設[Y軸座標]和參考點一樣
            UPDATE sadzp168_6_dzfj_o SET dzfj013 = (dzfj013 + p_dzfj_new.dzfj015 + 1)
              WHERE dzfj003 = l_dzfi006
                AND dzfj013 >= p_dzfj_new.dzfj013
                
            IF SQLCA.sqlcode THEN
               LET g_error_message = "ERROR-widget_pos_calc(dzfj013+dzfj015+1)-upd:sadzp168_6_dzfj_o.", l_dzfi006 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
               DISPLAY g_error_message
               #CALL cl_err("upd:sadzp168_6_dzfj_o", SQLCA.sqlcode, 1)
               RETURN FALSE
            END IF
         ELSE
            LET l_dzfj014_group = 0
            
            #取得此元件群組的Y軸高度(理論上同一排widget的Y軸應該相同)
            SELECT DISTINCT dzfj014 INTO l_dzfj014_group FROM sadzp168_6_dzfj_o
              WHERE dzfj003 = l_dzfi006

            IF SQLCA.sqlcode THEN
               LET g_error_message = "ERROR-widget_pos_calc()-SELECT DISTINCT dzfj014.", l_dzfi006 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
               DISPLAY g_error_message
               #CALL cl_err("SELECT DISTINCT dzfj014:", SQLCA.sqlcode, 1)
               RETURN FALSE
            END IF

            #檢查[群組元件Y軸]高度 < [新控件Y軸]高度的控件,Y軸是否有重疊
            IF (NOT cl_null(l_dzfj014_group)) AND (l_dzfj014_group < p_dzfj_new.dzfj014) THEN
               #以每一個元件的[起點/終點X軸]位置,來判斷是否有和新控件的X重疊為基礎
               #取得此元件群組所佔用最大Y軸間距(如:TextEdit-Y軸起始點為2,高度為3.所佔Y軸間距為2~5)
               SELECT MAX(dzfj014 + dzfj016) INTO l_y_max FROM sadzp168_6_dzfj_o
                 WHERE dzfj003 = l_dzfi006
                   AND (dzfj013 + dzfj015) > p_dzfj_new.dzfj013
                   AND (p_dzfj_new.dzfj013 + p_dzfj_new.dzfj015) > dzfj013

               #重疊的控件之最大Y軸間距 > 新插入控件的Y軸座標: 需要位移此元件群組下控件的X軸座標
               IF (NOT cl_null(l_y_max)) AND (l_y_max > p_dzfj_new.dzfj014) THEN
                  #取得元件群組的最小X軸位置
                  #用來判斷是否與新控件X軸有overlap情況
                  SELECT MIN(dzfj013) INTO l_x_min FROM sadzp168_6_dzfj_o
                    WHERE dzfj003 = l_dzfi006
                      AND (dzfj013+dzfj015) > p_dzfj_new.dzfj013

                  #計算X軸位移量(todo--PS:l_x_min有可能也會 > p_dzfj_new.dzfj013,注意一下負值是否可以運作正常)
                  LET l_x_gap = (p_dzfj_new.dzfj013 - l_x_min) + p_dzfj_new.dzfj015 + 1
                  
                  # 161229-00042：START   列出被調整的元件清單
                  DECLARE dzfj005_cur_1 CURSOR FOR 
                     SELECT dzfj005 FROM sadzp168_6_dzfj_o
                        WHERE dzfj003 = l_dzfi006
                      AND (dzfj013+dzfj015) > p_dzfj_new.dzfj013
                         
                  FOREACH dzfj005_cur_1 INTO l_dzfj005
                     Display "調整位置： ",l_dzfj005
                  END FOREACH
                  # 161229-00042：END
                  
                  UPDATE sadzp168_6_dzfj_o SET dzfj013 = (dzfj013 + l_x_gap)
                    WHERE dzfj003 = l_dzfi006
                      AND (dzfj013+dzfj015) > p_dzfj_new.dzfj013

                  IF SQLCA.sqlcode THEN
                     LET g_error_message = "ERROR-widget_pos_calc(dzfj013+l_x_gap)-upd:sadzp168_6_dzfj_o.", l_dzfi006 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
                     DISPLAY g_error_message
                     #CALL cl_err("upd:sadzp168_6_dzfj_o", SQLCA.sqlcode, 1)
                     RETURN FALSE
                  END IF
               END IF
            END IF

            
            #檢查[群組元件Y軸]高度 > [新控件Y軸]高度的控件: 當[新控件的Y軸]高度 > [群組元件的Y軸]最高高度,Y軸需全部往下位移
            IF (NOT cl_null(l_dzfj014_group)) AND (l_dzfj014_group > p_dzfj_new.dzfj014) THEN
               #取得此元件群組所佔用最大Y軸間距(如:TextEdit-Y軸起始點為2,高度為3.所佔Y軸間距為2~5)
               SELECT MAX(dzfj016) INTO l_dzfj016 FROM sadzp168_6_dzfj_o
                 WHERE dzfj003 = p_dzfj_new.dzfj003

               #新控件高度 > 群組元件裡的最高高度
               IF p_dzfj_new.dzfj016 > l_dzfj016 THEN
                  #計算Y軸位移量
                  LET l_y_gap = p_dzfj_new.dzfj016 - l_dzfj016

                  # 161229-00042：START  列出被調整的元件清單
                  DECLARE dzfj005_cur_2 CURSOR FOR 
                     SELECT dzfj005 FROM sadzp168_6_dzfj_o
                        WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_6_dzfi_o
                                        WHERE dzfi004 = p_dzfi004)
                              AND dzfj014 > p_dzfj_new.dzfj014
                         
                  FOREACH dzfj005_cur_2 INTO l_dzfj005
                     Display "調整位置： ",l_dzfj005
                  END FOREACH
                  # 161229-00042：END 
                  UPDATE sadzp168_6_dzfj_o SET dzfj014 = (dzfj014 + l_y_gap)
                    WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_6_dzfi_o
                                        WHERE dzfi004 = p_dzfi004)
                      AND dzfj014 > p_dzfj_new.dzfj014
                      
                  IF SQLCA.sqlcode THEN
                     LET g_error_message = "ERROR-widget_pos_calc(dzfj014+l_y_gap)-upd:sadzp168_6_dzfj_o.", p_dzfi004 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
                     DISPLAY g_error_message
                     #CALL cl_err("upd:sadzp168_6_dzfj_o", SQLCA.sqlcode, 1)
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
PRIVATE FUNCTION sadzp168_6_max_value(p_value1, p_value2)
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
PRIVATE FUNCTION sadzp168_6_min_value(p_value1, p_value2)
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
PRIVATE FUNCTION sadzp168_6_check_height(p_dzfi004, p_dzfj)
   DEFINE p_dzfi004            LIKE dzfi_t.dzfi004    #新控件所屬Container群組代碼
   DEFINE p_dzfj               type_g_dzfj            #新控件(widget)設計資料

   DEFINE l_dzfj016            LIKE dzfj_t.dzfj016    #控件高度
   DEFINE l_dzfi007            LIKE dzfi_t.dzfi007    #container類型

   #todo:二個Container間的父節點必為HBox或VBOx(參考的[相對位置Container]父節點必須為HBox或VBOx)
   SELECT dzfi007 INTO l_dzfi007 FROM sadzp168_6_dzfi_n
      WHERE dzfi006 = p_dzfi004
   
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-sel dzfi007.", p_dzfi004 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      #當發生無法預期錯誤時,當成新增至patch區塊處理
      RETURN TRUE
   END IF

   #Container為table和tree時,不需另外將控件新增至 patch區塊
   IF l_dzfi007 = "Table" OR l_dzfi007 = "Tree" THEN
      RETURN FALSE
   END IF
   
   #取得p_dzfi004 所有控件下最大的Y軸高度
   SELECT MAX(dzfj016) INTO l_dzfj016 FROM sadzp168_6_dzfj_o
     WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_6_dzfi_o
                         WHERE dzfi004 = p_dzfi004)

   #控件高度 <= 1 情況下,不需另外將控件新增至 patch區塊
   IF cl_null(l_dzfj016) OR l_dzfj016 < 2 THEN
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#將隸屬於類似單頭型態的控件,放置在Grid的patch區塊
PRIVATE FUNCTION sadzp168_6_add_widget_patch(p_dzfj)
   DEFINE p_dzfj               type_g_dzfj            #新控件(widget)設計資料
   
   DEFINE l_dzfi_ins           type_g_dzfi            #新增至DB的Container設計資料
   DEFINE l_dzfi005            LIKE dzfi_t.dzfi005
   DEFINE l_success            LIKE type_t.chr1
   DEFINE l_dzfj_ins           type_g_dzfj            #新增至DB的widget設計資料
   DEFINE l_dzfj014            LIKE dzfj_t.dzfj014    #widget Y軸位置
   
   #新增Grid的patch區塊
   IF cl_null(g_dzfi_patch_grid.dzfi004) THEN
      IF NOT sadzp168_6_add_grid_block() THEN
         RETURN FALSE
      END IF
   END IF

   #取得此群代碼(l_dzfi006_parent)下最大順序序號
   SELECT MAX(dzfi005) INTO l_dzfi005 FROM sadzp168_6_dzfi_o
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

   CALL sadzp168_6_ins_dzfi(l_dzfi_ins.*)
      RETURNING l_success, l_dzfi_ins.*

   IF NOT l_success THEN
      RETURN FALSE
   END IF

   #取得Grid的patch區塊目前已用最大Y軸高度
   SELECT MAX(dzfj014+dzfj016) INTO l_dzfj014 FROM sadzp168_6_dzfj_o
     WHERE dzfj003 IN (SELECT dzfi006 FROM sadzp168_6_dzfi_o
                         WHERE dzfi004 = g_dzfi_patch_grid.dzfi006)

   IF cl_null(l_dzfj014) THEN
      LET l_dzfj014 = 0
   END IF
   
   #新增此筆新版畫面結構設計資料
   LET l_dzfj_ins.dzfj001 = p_dzfj.dzfj001 CLIPPED
   LET l_dzfj_ins.dzfj002 = g_dzfi002_c
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

   INSERT INTO sadzp168_6_dzfj_o (dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
                                  dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
                                  dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
                                  dzfj016, dzfjstus, dzfj017, dzfj018)
     VALUES (l_dzfj_ins.dzfj001, l_dzfj_ins.dzfj002, l_dzfj_ins.dzfj003, l_dzfj_ins.dzfj004, l_dzfj_ins.dzfj005, 
             l_dzfj_ins.dzfj006, l_dzfj_ins.dzfj007, l_dzfj_ins.dzfj008, l_dzfj_ins.dzfj009, l_dzfj_ins.dzfj010, 
             l_dzfj_ins.dzfj011, l_dzfj_ins.dzfj012, l_dzfj_ins.dzfj013, l_dzfj_ins.dzfj014, l_dzfj_ins.dzfj015, 
             l_dzfj_ins.dzfj016, l_dzfj_ins.dzfjstus, l_dzfj_ins.dzfj017, l_dzfj_ins.dzfj018) 

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-add_widget_patch()-ins sadzp168_6_dzfj_o.", l_dzfj_ins.dzfj003 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("ins sadzp168_6_dzfj_o", SQLCA.sqlcode, 1)
      RETURN FALSE
   END IF

   
   INSERT INTO sadzp168_6_dzfk_o 
     SELECT dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
            dzfk006, dzfk007, dzfk008, dzfk009
       FROM dzfk_t
       WHERE dzfk001 = l_dzfj_ins.dzfj001 AND dzfk002 = g_dzfi002_s 
         AND dzfk003 = l_dzfj_ins.dzfj005 AND dzfk007 = g_dzfi009_s 

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-add_widget_patch()-ins sadzp168_6_dzfk_o.", p_dzfj.dzfj005 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("ins sadzp168_6_dzfk_o:" || p_dzfj.dzfj005 CLIPPED, SQLCA.sqlcode, 1)
      RETURN FALSE
   END IF
 
   INSERT INTO sadzp168_6_dzfl_o 
     SELECT dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, 
            dzfl006, dzflstus, dzfl007, dzfl008
       FROM dzfl_t
       WHERE dzfl001 = l_dzfj_ins.dzfj001 AND dzfl002 = g_dzfi002_s 
         AND dzfl003 = l_dzfj_ins.dzfj005 AND dzfl007 = g_dzfi009_s

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-add_widget_patch()-ins sadzp168_6_dzfl_o.", p_dzfj.dzfj005 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("ins sadzp168_6_dzfl_o:" || p_dzfj.dzfj005 CLIPPED, SQLCA.sqlcode, 1)
      RETURN FALSE
   END IF
   DISPLAY "INSERT into patch grid: ", l_dzfj_ins.dzfj005   # 161229-00042
   
   RETURN TRUE
END FUNCTION

#新增一個Grid的patch區塊(放置隸屬於類似單頭型態的控件)
PRIVATE FUNCTION sadzp168_6_add_grid_block()
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
   DEFINE l_domDoc          om.DomDocument
   DEFINE l_root_node       om.DomNode
   
   INITIALIZE g_dzfi_patch_grid TO NULL

   #Grid的patch區塊的屬性
   #LET l_grid_attr = "gridHeight|5,gridWidth|5,name|", g_patch_grid CLIPPED, ",posX|0,posY|0,style|,tag|"
   LET l_grid_attr = '<Grid gridHeight="5" gridWidth="5" name="', g_patch_grid CLIPPED,'" posX="0" posY="0" style="" tag=""/>'
   
   #檢查Grid patch區塊是否已存在畫面結構檔中
   LET l_dzfi004_patch = g_patch_grid 
   SELECT * INTO l_dzfi_block.* FROM sadzp168_6_dzfi_o
     WHERE dzfi004 = l_dzfi004_patch
   
   IF NOT cl_null(g_dzfi_patch_grid.dzfi004) THEN
      LET g_dzfi_patch_grid.* = l_dzfi_block.*
      RETURN TRUE
   END IF

   #取得Form節點下的第一個Layout(通常會是HBox或VBox)
   SELECT dzfi006 INTO l_dzfi006_parent FROM sadzp168_6_dzfi_o 
     WHERE dzfi004 = (SELECT dzfi006 FROM sadzp168_6_dzfi_o WHERE dzfi007 = 'Form')

   
   #取得最大ID序號值
   SELECT MAX(dzfi003) INTO l_dzfi003 FROM sadzp168_6_dzfi_o

   #取得此群代碼(l_dzfi006_parent)下最大順序序號
   SELECT MAX(dzfi005) INTO l_dzfi005 FROM sadzp168_6_dzfi_o
     WHERE dzfi004 = l_dzfi006_parent

   #新增一筆Grid區塊的設計資料(準備擺放控件設計資料)
   LET l_dzfi_block.dzfi001 = g_dzfi001 CLIPPED
   LET l_dzfi_block.dzfi002 = g_dzfi002_c
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

   INSERT INTO sadzp168_6_dzfi_o (dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
                                   dzfi006, dzfi007, dzfi008, dzfi009, dzfi010, 
                                   dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
                                   dzfi016, dzfistus, dzfi017)
     VALUES (l_dzfi_block.dzfi001, l_dzfi_block.dzfi002, l_dzfi_block.dzfi003, l_dzfi_block.dzfi004, l_dzfi_block.dzfi005, 
             l_dzfi_block.dzfi006, l_dzfi_block.dzfi007, l_dzfi_block.dzfi008, l_dzfi_block.dzfi009, l_dzfi_block.dzfi010, 
             l_dzfi_block.dzfi011, l_dzfi_block.dzfi012, l_dzfi_block.dzfi013, l_dzfi_block.dzfi014, l_dzfi_block.dzfi015, 
             l_dzfi_block.dzfi016, l_dzfi_block.dzfistus, l_dzfi_block.dzfi017) 

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-add_grid_block()-ins sadzp168_6_dzfi_o:", g_patch_grid.trim(), cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("ins sadzp168_6_dzfi_o", SQLCA.sqlcode, 1)
      RETURN FALSE
   END IF

   #取得Patch Grid區塊的屬性值
   LET l_domDoc = om.DomDocument.createFromString(l_grid_attr.trim())
   LET l_root_node = l_domDoc.getDocumentElement()

   LOCATE l_dzfk_ins.dzfk009 IN FILE
   
   LET l_dzfk_ins.dzfk001 = g_dzfi001 CLIPPED
   LET l_dzfk_ins.dzfk002 = g_dzfi002_c
   LET l_dzfk_ins.dzfk003 = g_patch_grid CLIPPED
   LET l_dzfk_ins.dzfk004 = ""
   LET l_dzfk_ins.dzfk005 = ""
   LET l_dzfk_ins.dzfk006 = ""
   LET l_dzfk_ins.dzfk007 = "c"
   LET l_dzfk_ins.dzfk008 = l_dzfi_block.dzfi017
   LET l_dzfk_ins.dzfk009 = l_root_node.toString()

   INSERT INTO sadzp168_6_dzfk_o(dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
                                  dzfk006, dzfk007, dzfk008, dzfk009)
     VALUES (l_dzfk_ins.dzfk001, l_dzfk_ins.dzfk002, l_dzfk_ins.dzfk003, l_dzfk_ins.dzfk004, l_dzfk_ins.dzfk005,
             l_dzfk_ins.dzfk006, l_dzfk_ins.dzfk007, l_dzfk_ins.dzfk008, l_dzfk_ins.dzfk009)

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-add_grid_block()-ins sadzp168_6_dzfk_o.", g_patch_grid.trim(), ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("ins sadzp168_6_dzfk_o", SQLCA.sqlcode, 1)
      RETURN FALSE
   END IF

   LET g_dzfi_patch_grid.* = l_dzfi_block.*
   RETURN TRUE
END FUNCTION

#檢查二個Container間是否有layout
PRIVATE FUNCTION sadzp168_6_check_layout(p_dzfi, p_dzfi_relative, p_add_mode)
   DEFINE p_dzfi               type_g_dzfi            #新結構檔(Container)設計資料
   DEFINE p_dzfi_relative      type_g_dzfi            #新設計資料需加入在舊版畫面結構中的相對位置節點
   DEFINE p_add_mode           LIKE type_t.chr10      #新節點加入模式
   
   DEFINE l_dzfi004            LIKE dzfi_t.dzfi004    #群組代碼
   DEFINE l_dzfi005            LIKE dzfi_t.dzfi005    #順序
   DEFINE l_dzfi004_parent     LIKE dzfi_t.dzfi004    #新Container父節點的父節點
   DEFINE l_dzfi005_relative   LIKE dzfi_t.dzfi004    #新Container在父節點下的順序位置
   DEFINE l_dzfi007_parent     LIKE dzfi_t.dzfi004    #相對位置節點(參考節點)的父節點節點類型(Container樣式)
   
   LET l_dzfi004 = ""
   LET l_dzfi005 = 0
   
   IF cl_null(p_dzfi_relative.dzfi004) THEN
      DISPLAY "ERROR-check_layout():", p_dzfi_relative.dzfi004, "(dzfi004) is null."
      RETURN FALSE, l_dzfi004, l_dzfi005
   END IF

   #todo:二個Container間的父節點必為HBox或VBOx(參考的[相對位置Container]父節點必須為HBox或VBOx)
   SELECT dzfi007 INTO l_dzfi007_parent FROM sadzp168_6_dzfi_o
      WHERE dzfi006 = p_dzfi_relative.dzfi004
   
   IF cl_null(l_dzfi007_parent) THEN
      DISPLAY "ERROR-check_layout():", p_dzfi_relative.dzfi004, "(dzfi007) is null."
      RETURN FALSE, l_dzfi004, l_dzfi005
   END IF
   
   #IF p_dzfi_relative.dzfi007 = "HBox" OR p_dzfi_relative.dzfi007 = "VBox" THEN
   IF UPSHIFT(l_dzfi007_parent) = "HBOX" OR UPSHIFT(l_dzfi007_parent) = "VBOX" THEN
      LET l_dzfi004 = p_dzfi_relative.dzfi004
      LET l_dzfi005 = p_dzfi_relative.dzfi005
      RETURN TRUE, l_dzfi004, l_dzfi005
   END IF

   #當不為HBox或VBOx時,代表上一層無Layout情形,此時可能會造成編譯失敗
   #此筆新增之結構檔(Container)設計資料父節點,不參考[相對位置]節點,採用自己的父節點資料(dzfi004)
   LET l_dzfi004 = p_dzfi.dzfi004

   ####取得目前此父節點目前在[舊版畫面結構]下子節點數量(順序編號)
   ###SELECT MAX(dzfi005) INTO l_dzfi005 FROM sadzp168_6_dzfi_o
   ###   WHERE dzfi004 = p_dzfi.dzfi004

   

   #新增之結構檔(Container)之Layout父節點應該在新版畫面檔已有此Layout元件
   #而按照元件merger邏輯,此Layout父節點應該已經先被加入舊版畫面檔中(dzfi_o)
   #所以從舊版畫面檔中(dzfi_o)操作此Layout父節點的設計資料邏輯
   
   #指定新增之結構檔(Container)設計資料位於父節點下的順序位置
   LET l_dzfi005 = p_dzfi.dzfi005
   
   #將要插入的節點序號往後加1
   UPDATE sadzp168_6_dzfi_o SET dzfi005 = (dzfi005 + 1)
     WHERE dzfi004 = p_dzfi.dzfi004
       AND dzfi005 >= l_dzfi005
   
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-check_layout(dzfi005+1)-upd sadzp168_6_dzfi_o.", p_dzfi.dzfi004 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      #CALL cl_err("ins sadzp168_6_dzfi_o:" || p_dzfi.dzfi004 CLIPPED, SQLCA.sqlcode, 1)
      RETURN FALSE, l_dzfi004, l_dzfi005
   END IF


          
   #取得新增之結構檔(Container)設計資料父節點的父節點名稱
   SELECT dzfi004 INTO l_dzfi004_parent FROM sadzp168_6_dzfi_o
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
      UPDATE sadzp168_6_dzfi_o SET dzfi005 = (dzfi005 + 1)
        WHERE dzfi004 = p_dzfi.dzfi004
          AND dzfi005 >= l_dzfi005_relative

      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-check_layout(dzfi005+1)-upd sadzp168_6_dzfi_o.", p_dzfi.dzfi004 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message
         #CALL cl_err("ins sadzp168_6_dzfi_o:" || p_dzfi.dzfi004 CLIPPED, SQLCA.sqlcode, 1)
         RETURN FALSE, l_dzfi004, l_dzfi005
      END IF

      #變更[相對位置]Container節點的父節點和位於父節點的順序位置
      UPDATE sadzp168_6_dzfi_o SET dzfi004 = p_dzfi.dzfi004, dzfi005 = l_dzfi005_relative
        WHERE dzfi006 = p_dzfi_relative.dzfi006
        
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-check_layout(dzfi004=p_dzfi.dzfi004)-upd sadzp168_6_dzfi_o.", p_dzfi_relative.dzfi006 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message
         #CALL cl_err("ins sadzp168_6_dzfi_o:" || p_dzfi_relative.dzfi006 CLIPPED, SQLCA.sqlcode, 1)
         RETURN FALSE, l_dzfi004, l_dzfi005
      END IF

   END IF
   
   RETURN FALSE, l_dzfi004, l_dzfi005
END FUNCTION

#+ UI的C1版次視為產中標準UI,因此在patch時需要將標準的最大版次(Sx版次)覆蓋成C1版次的UI設計資料
#  接著用C1的設計資料產出畫面,這樣就會是patch過去的產中標準UI
PRIVATE FUNCTION sadzp168_6_get_standard(p_dzfi001, p_dzfi002)
   DEFINE p_dzfi001         LIKE dzfi_t.dzfi001         #畫面代號
   DEFINE p_dzfi002         LIKE dzfi_t.dzfi002         #標準畫面最大版次
   
   DEFINE l_dzfi009         LIKE dzfi_t.dzfi009         #客製碼
   
   LET l_dzfi009 = "s"
   
   #########################畫面結構設計資料(dzfi_t)#########################
   INSERT INTO sadzp168_6_dzfi_o
     SELECT dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
            dzfi006, dzfi007, dzfi008, dzfi009, dzfi010,
            dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
            dzfi016, dzfistus, dzfi017 
       FROM dzfi_t
       WHERE dzfi001 = p_dzfi001 AND dzfi002 = p_dzfi002 AND dzfi009 = l_dzfi009

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-init()-ins sadzp168_6_dzfi_o.", p_dzfi001 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
     
   #########################畫面元件組合設計資料(dzfj_t)#########################   
   INSERT INTO sadzp168_6_dzfj_o
     SELECT dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
            dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
            dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
            dzfj016, dzfjstus, dzfj017, dzfj018 
        FROM dzfj_t
        WHERE dzfj001 = p_dzfi001 AND dzfj002 = p_dzfi002 AND dzfj017 = l_dzfi009

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-init()-ins sadzp168_6_dzfj_o.", p_dzfi001 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   #########################畫面元件屬性設計資料(dzfk_t)#########################   
   #取得舊版畫面元件屬性設計資料
   INSERT INTO sadzp168_6_dzfk_o
     SELECT dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
            dzfk006, dzfk007, dzfk008, dzfk009
        FROM dzfk_t
        WHERE dzfk001 = p_dzfi001 AND dzfk002 = p_dzfi002 AND dzfk007 = l_dzfi009 

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-init()-ins sadzp168_6_dzfk_o.", p_dzfi001 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   #########################畫面元件資料項目設計資料(dzfl_t)#########################   
   #取得舊版畫面元件資料項目設計資料
   INSERT INTO sadzp168_6_dzfl_o
     SELECT dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, 
            dzfl006, dzflstus, dzfl007, dzfl008
        FROM dzfl_t
        WHERE dzfl001 = p_dzfi001 AND dzfl002 = p_dzfi002 AND dzfl007 = l_dzfi009

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-init()-ins sadzp168_6_dzfl_o.", p_dzfi001 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

#+ 取得參考點(widget)在舊版畫面中所屬的Container代碼
PRIVATE FUNCTION sadzp168_6_get_container(p_dzfi006)
   DEFINE p_dzfi006         LIKE dzfi_t.dzfi006         #widget所屬元件組代碼
   DEFINE l_dzfi004         LIKE dzfi_t.dzfi004         #所屬container代碼

   LET l_dzfi004 = ""
   
   SELECT dzfi004 INTO l_dzfi004 FROM sadzp168_6_dzfi_o
      WHERE dzfi006 = p_dzfi006

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-sadzp168_6_get_container()-sel sadzp168_6_dzfi_o.", p_dzfi006 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN ""
   END IF

   IF cl_null(l_dzfi004) THEN
      LET g_error_message = "ERROR-sadzp168_6_get_container()-", p_dzfi006 CLIPPED, " get container error."
      DISPLAY g_error_message
      RETURN ""
   END IF
   
   RETURN l_dzfi004
END FUNCTION
