#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: sadzp168_3
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp168_3.4gl 
# Description    : 解析4fd畫面成設計資料工具
# Memo           :

IMPORT os
SCHEMA ds

&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp000_type.inc"

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"
GLOBALS "../4gl/adzi888_global.inc"

CONSTANT g_widget_group = "widget_group"             #元件組合群組代碼前綴字元

TYPE type_g_structure        RECORD                      #控件所屬結構
                type            STRING,                  #structure類型
                id              STRING,                  #structure代碼
                label_text      STRING,                  #structure標籤代碼
                level           LIKE type_t.num5         #structure節點階層
             END RECORD

TYPE type_g_dzfa             RECORD                      #畫面UI元件失效檔
                dzfa001         LIKE dzfa_t.dzfa001,     #失效UI代碼(PK)
                dzfa002         LIKE dzfa_t.dzfa002,     #客製標示(PK)
                dzfa003         LIKE dzfa_t.dzfa003,     #客戶代號
                dzfa004         LIKE dzfa_t.dzfa004,     #類型
                dzfa005         LIKE dzfa_t.dzfa005,     #失效版次
                dzfa006         LIKE dzfa_t.dzfa006,     #失效項目name
                dzfa007         LIKE dzfa_t.dzfa007,     #節點類型
                dzfaownid       LIKE dzfa_t.dzfaownid, 
                dzfaowndp       LIKE dzfa_t.dzfaowndp, 
                dzfacrtid       LIKE dzfa_t.dzfacrtid, 
                dzfacrtdp       LIKE dzfa_t.dzfacrtdp, 
                dzfacrtdt       LIKE dzfa_t.dzfacrtdt, 
                dzfamodid       LIKE dzfa_t.dzfamodid, 
                dzfamoddt       LIKE dzfa_t.dzfamoddt
             END RECORD

DEFINE g_dzfi001             LIKE dzfi_t.dzfi001         #4fd 結構代號
DEFINE g_dzfi002             LIKE dzfi_t.dzfi002         #設計點版本
DEFINE g_dzfi003             LIKE dzfi_t.dzfi003         #編號

DEFINE g_dgenv               LIKE type_t.chr1            #客製標示:s-標準產品, c-客製
DEFINE g_dzfi017             LIKE dzfi_t.dzfi017         #客戶代號
DEFINE g_error_message       STRING                      #錯誤訊息

#+ 作業開始
PUBLIC FUNCTION sadzp168_3(p_module, p_form_name, p_ver, p_dgenv)
   DEFINE p_module          STRING                  #畫面檔所在模組
   DEFINE p_form_name       STRING                  #畫面結構代號
   DEFINE p_ver             LIKE dzfi_t.dzfi002     #規格版次
   DEFINE p_dgenv           LIKE type_t.chr1        #客製標示:s-標準產品, c-客製

   DEFINE l_time_s          DATETIME YEAR TO SECOND #FRACTION(4)
   DEFINE l_time_e          DATETIME YEAR TO SECOND #FRACTION(4)
   DEFINE l_node            om.DomNode              #4fd domNode
   DEFINE l_structure       type_g_structure
   DEFINE l_dzfi012         LIKE dzfi_t.dzfi012     #節點所屬階層

   #todo:free style的解析與否判斷,系統/應用元件有無4fd的判斷
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   LET l_time_s = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
   DISPLAY "   Strat time : ", l_time_s, ASCII 10

   INITIALIZE l_structure TO NULL   
   
   #程式初始化
   IF NOT sadzp168_3_init(p_form_name, p_ver, p_dgenv) THEN
      RETURN FALSE, g_error_message
   END IF

   #取得需要解析的4fd畫面檔結構
   CALL sadzp168_3_get_4fd(p_module, p_form_name) RETURNING l_node

   #取得4fd畫面檔結構失敗.
   IF l_node IS NULL THEN
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00243", g_lang, "")
      DISPLAY g_error_message

      RETURN FALSE, g_error_message
   END IF
   
   BEGIN WORK

   #root為最上階(第1階層)
   LET l_dzfi012 = 0

   #記錄Form tag屬性
   IF NOT sadzp168_3_insert_attr(l_node) THEN
      RETURN FALSE, g_error_message
   END IF

   #進行畫面解析,最上層節點定義為root
   IF NOT sadzp168_3_analyze(l_node, "root", 1, l_structure.*, l_dzfi012) THEN
      RETURN FALSE, g_error_message
   END IF

   IF cl_null(g_patch_mode) OR (NOT g_patch_mode) THEN
      IF NOT sadzp168_3_get_diff_element(p_module, g_dzfi001, g_dzfi002, p_dgenv) THEN
         RETURN FALSE, g_error_message
      END IF
   END IF
   
   COMMIT WORK
   
   LET l_time_e = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
   DISPLAY ASCII 10, ASCII 10, "    End  time : ", l_time_e
   DISPLAY "    Cost time : ", l_time_e - l_time_s

   LET g_error_message = ""
   RETURN TRUE, ""
END FUNCTION

#+ 作業開始for patch長畫面設計資料用
PUBLIC FUNCTION sadzp168_3_patch(p_module, p_form_name, p_ver, p_dgenv)
   DEFINE p_module          STRING                  #畫面檔所在模組
   DEFINE p_form_name       STRING                  #畫面結構代號
   DEFINE p_ver             LIKE dzfi_t.dzfi002     #規格版次
   DEFINE p_dgenv           LIKE type_t.chr1        #客製標示:s-標準產品, c-客製

   DEFINE l_time_s          DATETIME YEAR TO SECOND #FRACTION(4)
   DEFINE l_time_e          DATETIME YEAR TO SECOND #FRACTION(4)
   DEFINE l_node            om.DomNode              #4fd domNode
   DEFINE l_structure       type_g_structure
   DEFINE l_dzfi012         LIKE dzfi_t.dzfi012     #節點所屬階層

   #todo:free style的解析與否判斷,系統/應用元件有無4fd的判斷
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   LET l_time_s = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
   DISPLAY "   Strat time : ", l_time_s, ASCII 10

   INITIALIZE l_structure TO NULL   
   
   #程式初始化
   IF NOT sadzp168_3_init(p_form_name, p_ver, p_dgenv) THEN
      RETURN FALSE, g_error_message
   END IF

   #取得需要解析的4fd畫面檔結構
   CALL sadzp168_3_get_4fd(p_module, p_form_name) RETURNING l_node

   #取得4fd畫面檔結構失敗.
   IF l_node IS NULL THEN
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00243", g_lang, "")
      DISPLAY g_error_message

      RETURN FALSE, g_error_message
   END IF
   
   BEGIN WORK

   #root為最上階(第1階層)
   LET l_dzfi012 = 0

   #記錄Form tag屬性
   IF NOT sadzp168_3_insert_attr(l_node) THEN
      RETURN FALSE, g_error_message
   END IF

   #進行畫面解析,最上層節點定義為root
   IF NOT sadzp168_3_analyze(l_node, "root", 1, l_structure.*, l_dzfi012) THEN
      RETURN FALSE, g_error_message
   END IF

   COMMIT WORK
   
   LET l_time_e = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
   DISPLAY ASCII 10, ASCII 10, "    End  time : ", l_time_e
   DISPLAY "    Cost time : ", l_time_e - l_time_s

   LET g_error_message = ""
   RETURN TRUE, ""
END FUNCTION

#+ 程式相關資料初始化
PRIVATE FUNCTION sadzp168_3_init(p_form_name, p_ver, p_dgenv)
   DEFINE p_form_name       STRING                  #UI結構代號:xxx.4fd
   DEFINE p_ver             LIKE dzfi_t.dzfi002     #規格版次
   DEFINE p_dgenv           LIKE type_t.chr1        #客製標示:s-標準產品, c-客製
   
   DEFINE l_sql             STRING

   LET g_error_message = ""
   LET g_dzfi001 = p_form_name
   LET g_dzfi002 = p_ver
   LET g_dzfi003 = 0
   LET g_dgenv = p_dgenv
   LET g_dzfi017 = FGL_GETENV("CUST")

   IF cl_null(p_ver) OR p_ver = 0 THEN
      LET g_error_message = "ERROR-revision is null."
      DISPLAY g_error_message
   END IF

   IF cl_null(g_rtn_msg) THEN
      LET g_rtn_msg = TRUE
   END IF
   
   IF cl_null(g_dgenv) THEN
      LET g_dgenv = FGL_GETENV("DGENV")     #"s":標準; "c"客製
   END IF

   #刪除此畫面代碼所有相關設計資訊
   IF NOT sadzp168_3_reload_delete(p_form_name, g_dzfi002, p_dgenv) THEN
      DISPLAY "Delete failures."    #刪除失敗
   END IF

   #####宣告insert 畫面結構檔資枓表#####
   LET l_sql = "INSERT INTO dzfi_t (dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, ",
               "                    dzfi006, dzfi007, dzfi008, dzfi009, dzfi010, ",
               "                    dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, ",
               "                    dzfi016, dzfi017, ", 
               "                    dzfiownid, dzfiowndp, dzficrtid, dzficrtdp, dzficrtdt, ",
               "                    dzfimodid, dzfimoddt, dzfistus ", 
               "                     )",
               "  VALUES (?,?,?,?,?, ?,?,?,?,?,",
               "          ?,?,?,?,?, ?,?, ",
               "          ?,?,?,?,?, ?,?,?)"

   PREPARE sadzp168_3_dzfi_ins_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_dzfi_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   

   
   #####宣告insert 畫面元件組合檔資枓表#####
   LET l_sql = "INSERT INTO dzfj_t (dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, ", 
               "                    dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, ", 
               "                    dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, ", 
               "                    dzfj016, dzfjstus, dzfj017, dzfj018)",
               "  VALUES (?,?,?,?,?, ?,?,?,?,?,",
               "          ?,?,?,?,?, ?,?,?,?)"
                     
   PREPARE sadzp168_3_dzfj_ins_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_dzfj_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF


   
   #####宣告insert 畫面元件屬性檔資枓表#####
   LET l_sql = "INSERT INTO dzfk_t (dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, ", 
               "                    dzfk006, dzfk007, dzfk008, dzfk009)",
               "  VALUES (?,?,?,?,?, ?,?,?,?)"
                     
   PREPARE sadzp168_3_dzfk_ins_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_dzfk_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF


   
   #####宣告insert 畫面元件資料項目檔資枓表#####
   LET l_sql = "INSERT INTO dzfl_t (dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, ", 
               "                    dzfl006, dzflstus, dzfl007, dzfl008)",
               "  VALUES (?,?,?,?,?, ?,?,?,?)"
                     
   PREPARE sadzp168_3_dzfl_ins_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_dzfl_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF


   
   #####取得畫面結構檔資枓表(dzfi_t) Container部份#####
   #base(比對基礎);Contrast(對比資料)
   LET l_sql = "SELECT base.dzfi006, base.dzfi010 ",
               "  FROM (SELECT * FROM dzfi_t ",
               "          WHERE dzfi001 = ? AND dzfi002 = ? AND dzfi009 = ? ",
               "            AND (dzfi010 = '0' OR dzfi010 = '1')) base ",
               "  WHERE NOT EXISTS ",
               "    (SELECT * FROM dzfi_t cont ",
               "       WHERE dzfi001 = ? AND dzfi002 = ? AND dzfi009 = ? ",
               "         AND (dzfi010 = '0' OR dzfi010 = '1') ",
               #"         AND base.dzfi001 = cont.dzfi001 ",
               "         AND base.dzfi006 = cont.dzfi006) "

   PREPARE sadzp168_3_dzfi_diff_pre FROM l_sql
   DECLARE sadzp168_3_dzfi_cs CURSOR FOR sadzp168_3_dzfi_diff_pre
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_dzfi_diff_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   #####取得畫面元件組合檔資枓表(dzfj_t) Widget部份#####
   #base(比對基礎);Contrast(對比資料)
   LET l_sql = "SELECT base.dzfj005 ",
               "  FROM (SELECT * FROM dzfj_t ",
               "          WHERE dzfj001 = ? AND dzfj002 = ? AND dzfj017 = ? ) base ",
               "  WHERE NOT EXISTS ",
               "    (SELECT * FROM dzfj_t cont ",
               "       WHERE dzfj001 = ? AND dzfj002 = ? AND dzfj017 = ? ",
               #"         AND base.dzfj001 = cont.dzfj001 ",
               "         AND base.dzfj005 = cont.dzfj005) "

   PREPARE sadzp168_3_dzfj_diff_pre FROM l_sql
   DECLARE sadzp168_3_dzfj_cs CURSOR FOR sadzp168_3_dzfj_diff_pre
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_dzfj_diff_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   #####取得畫面元件資料項目檔資枓表(dzfl_t) ComboBox/RadioGroup的Item部份#####
   #base(比對基礎);Contrast(對比資料)
   LET l_sql = "SELECT base.dzfl003, base.dzfl005 ",
               "  FROM (SELECT * FROM dzfl_t ",
               "          WHERE dzfl001 = ? AND dzfl002 = ? AND dzfl007 = ? ) base ",
               "  WHERE NOT EXISTS ",
               "    (SELECT * FROM dzfl_t cont ",
               "       WHERE dzfl001 = ? AND dzfl002 = ? AND dzfl007 = ? ",
               #"         AND base.dzfl001 = cont.dzfl001 ",
               "         AND base.dzfl003 = cont.dzfl003 ",
               "         AND base.dzfl005 = cont.dzfl005) "

   PREPARE sadzp168_3_dzfl_diff_pre FROM l_sql
   DECLARE sadzp168_3_dzfl_cs CURSOR FOR sadzp168_3_dzfl_diff_pre
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_dzfl_diff_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   #####宣告insert 畫面UI元件失效檔資枓表#####
   LET l_sql = "INSERT INTO dzfa_t (dzfa001, dzfa002, dzfa003, dzfa004, dzfa005, ", 
               "                    dzfa006, dzfa007, ",
               "                    dzfaownid, dzfaowndp, dzfacrtid, dzfacrtdp, dzfacrtdt, ",
               "                    dzfamodid, dzfamoddt )",
               "  VALUES (?,?,?,?,?, ?,?, ",
               "          ?,?,?,?,?, ?,?)"
                     
   PREPARE sadzp168_3_dzfa_ins_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_dzfa_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF



   #####取得畫面結構檔資枓表(dzfi_t) Container是否"又"恢復生效#####
   LET l_sql = "SELECT dzfa001, dzfa002, dzfa003, dzfa005, dzfa007 ",
               "  FROM (SELECT * FROM dzfa_t ",
               "          WHERE dzfa001 = ? AND dzfa003 = ? ",
               "            AND dzfa005 = '0') ",
               "  WHERE EXISTS ",
               "    (SELECT * FROM dzfi_t ",
               "       WHERE dzfi001 = ? AND dzfi002 = ? AND dzfi009 = ? ",
               "         AND (dzfi010 = '0' OR dzfi010 = '1') ",
               "         AND dzfa001 = dzfi001 ",
               "         AND dzfa002 = dzfi006) "

   PREPARE sadzp168_3_container_pre FROM l_sql
   DECLARE sadzp168_3_container_cs CURSOR FOR sadzp168_3_container_pre
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_container_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   #####取得畫面元件組合檔資枓表(dzfj_t) widget是否"又"恢復生效#####
   LET l_sql = "SELECT dzfa001, dzfa002, dzfa003, dzfa005, dzfa007 ",
               "  FROM (SELECT * FROM dzfa_t ",
               "          WHERE dzfa001 = ? AND dzfa003 = ? ",
               "            AND dzfa005 = '1') ",
               "  WHERE EXISTS ",
               "    (SELECT * FROM dzfj_t ",
               "       WHERE dzfj001 = ? AND dzfj002 = ? AND dzfj017 = ? ",
               "         AND dzfa001 = dzfj001 ",
               "         AND dzfa002 = dzfj005) "

   PREPARE sadzp168_3_widget_pre FROM l_sql
   DECLARE sadzp168_3_widget_cs CURSOR FOR sadzp168_3_widget_pre
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_widget_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   #####取得畫面元件資料項目檔資枓表(dzfl_t) item是否"又"恢復生效#####
   LET l_sql = "SELECT dzfa001, dzfa002, dzfa003, dzfa005, dzfa007 ",
               "  FROM (SELECT * FROM dzfa_t ",
               "          WHERE dzfa001 = ? AND dzfa003 = ? ",
               "            AND dzfa005 = '2') ",
               "  WHERE EXISTS ",
               "    (SELECT * FROM dzfl_t ",
               "       WHERE dzfl001 = ? AND dzfl002 = ? AND dzfl007 = ? ",
               "         AND dzfa001 = dzfl001 ",
               "         AND dzfa002 = dzfl003 ",
               "         AND dzfa007 = dzfl005) "

   PREPARE sadzp168_3_item_pre FROM l_sql
   DECLARE sadzp168_3_item_cs CURSOR FOR sadzp168_3_item_pre
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_item_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION
   
#+ 載入4fd畫面成domNode
PRIVATE FUNCTION sadzp168_3_get_4fd(p_module, p_form_name)
   DEFINE p_module          STRING                #4fd所在模組
   DEFINE p_form_name       STRING                #4fd畫面檔檔案名稱,xxxx.4fd

   DEFINE r_template_node   om.DomNode            #4fd domNode
   
   INITIALIZE r_template_node TO NULL
   
   #載入需要解析的4fd畫面檔成domNode
   LET r_template_node = sadzp168_2_get_4fd(p_module, p_form_name)

   #取得符合條件的節點(domNode)=>取得只需要解析4fd結構
   #通常就是由<Form></Form> tag裡的結構資料
   IF r_template_node IS NOT NULL THEN
      CALL sadzp168_2_get_form_node(r_template_node, "Form")
         RETURNING r_template_node  
   END IF
   
   RETURN r_template_node
END FUNCTION

#+ 分析4fd結構(解析方式:XML結構由外而內方式)
PRIVATE FUNCTION sadzp168_3_analyze(p_node, p_dzfi004, p_dzfi005, p_structure, p_dzfi012)
   DEFINE p_node             om.DomNode  
   DEFINE p_dzfi004          LIKE dzfi_t.dzfi004              #父節點群組代碼
   DEFINE p_dzfi005          LIKE dzfi_t.dzfi005              #排序順序
   DEFINE p_structure        type_g_structure
   DEFINE p_dzfi012          LIKE dzfi_t.dzfi012              #節點所屬階層

   DEFINE l_dzfi             type_g_dzfi
   DEFINE l_child_node       om.DomNode                       #子節點
   DEFINE l_child_num        LIKE dzfi_t.dzfi005              #子節點排序順序

   INITIALIZE l_child_node TO NULL
   
   LET g_dzfi003 = g_dzfi003 + 1
   
   #####insert 畫面結構檔資枓表#####
   LET l_dzfi.dzfi003 = g_dzfi003 CLIPPED                     #編號
   LET l_dzfi.dzfi004 = p_dzfi004 CLIPPED                     #群組代碼
   LET l_dzfi.dzfi005 = p_dzfi005 CLIPPED                     #順序
   LET l_dzfi.dzfi006 = p_node.getAttribute("name") CLIPPED   #元件(組)代碼 
   LET l_dzfi.dzfi007 = p_node.getTagName()                   #節點類型
   LET l_dzfi.dzfi012 = p_dzfi012                             #節點階層
   LET l_dzfi.dzfi017 = g_dzfi017                             #客戶代號
   LET l_dzfi.dzfi013 = p_node.getAttribute("posX") CLIPPED   #群組X軸位置
   LET l_dzfi.dzfi014 = p_node.getAttribute("posY") CLIPPED   #群組Y軸位置
   

   #取得widget所屬結構
   CALL sadzp168_3_get_structure(l_dzfi.dzfi006, l_dzfi.dzfi007, p_dzfi012, p_node.getAttribute("text"), p_structure.*)
      RETURNING p_structure.*

   #todo:UI解析資料暫時將dzfi008視為都需要組合(顯示)的元件
   LET l_dzfi.dzfi008 = "Y"
   
   #客製標示:s-標準產品, c-客製
   LET l_dzfi.dzfi009 = g_dgenv
   
   #dzfi010先定義:最終元件子widget目前只可在某幾個container下
   #這些container下,視為元件組合
   #目前dzfi011取群組的原則都是橫向排列,只有VBox元件是直向排列
   CALL sadzp168_3_is_container(p_node.getTagName(), p_node.getAttribute("name"))
      RETURNING l_dzfi.dzfi010, l_dzfi.dzfi011

   #insert 畫面結構檔
   IF NOT sadzp168_3_insert_dzfi(l_dzfi.*) THEN
      RETURN FALSE
   END IF

   #Container若為元件組合,需逐一解析內存的widget排列方式
   IF l_dzfi.dzfi010 = "1" THEN
      IF NOT sadzp168_3_analyze_container(p_node, l_dzfi.dzfi006, p_structure.*, p_dzfi012) THEN
         RETURN FALSE
      ELSE
         RETURN TRUE
      END IF
   END IF

   #node結構不為元件組合的container時,繼續往下層結構解析
   LET l_child_node = p_node.getFirstChild()
   LET l_child_num = 1
   LET p_dzfi012 = p_dzfi012 + 1

   WHILE l_child_node IS NOT NULL
      #DISPLAY "tag:", l_child_node.getTagName(), "; name:", l_child_node.getAttribute("name")
      #紀錄各節點(包含container和widget..等)屬性值
      IF NOT sadzp168_3_insert_attr(l_child_node) THEN
         RETURN FALSE
      END IF

      #繼續逐層往下往子節點解析(由外而內)
      IF sadzp168_3_analyze(l_child_node, l_dzfi.dzfi006, l_child_num, p_structure.*, p_dzfi012) THEN
         LET l_child_node = l_child_node.getNext()
         LET l_child_num = l_child_num + 1
      ELSE
         RETURN FALSE
      END IF
   END WHILE

   RETURN TRUE
END FUNCTION

#+ 取得是否為container元件
#todo:目前最終元件子widget目前只可在某幾個container下,是否合理?
PRIVATE FUNCTION sadzp168_3_is_container(p_widget, p_widget_name)
   DEFINE p_widget          STRING                #widget type
   DEFINE p_widget_name     STRING                #widget name
   
   DEFINE l_dzfi010         LIKE dzfi_t.dzfi010   #包含元素類型(0:Container, 1:元件組合, 2:xml, 3:Widget)
   DEFINE l_dzfi011         LIKE dzfi_t.dzfi011   #直橫排列V/H

   LET l_dzfi010 = ""
   LET l_dzfi011 = ""

   CASE p_widget.trim()
      WHEN "Grid"
         LET l_dzfi010 = "1"
         LET l_dzfi011 = "H"
      WHEN "Group"
         LET l_dzfi010 = "1"
         LET l_dzfi011 = "H"
         
      WHEN "Table"
         LET l_dzfi010 = "1"
         LET l_dzfi011 = "H"
      WHEN "Tree"
         LET l_dzfi010 = "1"
         LET l_dzfi011 = "H"
      WHEN "ScrollGrid"
         LET l_dzfi010 = "1"
         LET l_dzfi011 = "H"

      WHEN "Folder"
         LET l_dzfi010 = "0"
         LET l_dzfi011 = "H"
      WHEN "Page"
         LET l_dzfi010 = "1"
         LET l_dzfi011 = "H"

      WHEN "HBox"
         LET l_dzfi010 = "0"
         LET l_dzfi011 = "H"
      WHEN "VBox"
         LET l_dzfi010 = "0"
         LET l_dzfi011 = "V"
         
      OTHERWISE
         LET l_dzfi010 = ""
         LET l_dzfi011 = ""
   END CASE 

   RETURN l_dzfi010, l_dzfi011
END FUNCTION

#+ 解析container內的元件組合各內容物
PRIVATE FUNCTION sadzp168_3_analyze_container(p_node, p_dzfi004, p_structure, p_dzfi012)
   DEFINE p_node            om.DomNode            #Container Node
   DEFINE p_dzfi004         LIKE dzfi_t.dzfi004   #上層父節點元件(組)代碼 
   DEFINE p_structure       type_g_structure
   DEFINE p_dzfi012         LIKE dzfi_t.dzfi012   #節點所屬階層

   DEFINE l_dzfi            type_g_dzfi           #畫面結構檔
   DEFINE l_dzfj            type_g_dzfj           #畫面元件組合檔
   DEFINE l_dzfj_t          type_g_dzfj
   
   DEFINE l_child_node      om.DomNode            #子節點
   DEFINE l_posY            LIKE type_t.num10     #同一排的posY軸位置
   DEFINE l_posY_widget     LIKE type_t.num10     #每個widget的posY軸位置
   DEFINE l_new_group       LIKE type_t.chr1      #是否為一個新的群組
   DEFINE l_dzfj003         LIKE dzfj_t.dzfj003   #群組代碼
   DEFINE l_child_num       LIKE dzfj_t.dzfj004   #同一群組下的widget排列順序
   DEFINE l_dzfi005         LIKE dzfi_t.dzfi005   #父節點下的各群組順序
   DEFINE l_dzfi006         LIKE dzfi_t.dzfi006   #元件(組)代碼
   DEFINE l_dzfi010         LIKE dzfi_t.dzfi010   #包含元素類型(0:Container, 1:元件組合, 2:xml, 3:Widget)
   DEFINE l_dzfi011         LIKE dzfi_t.dzfi011   #直橫排列V/H
   
   DEFINE l_label           LIKE dzfj_t.dzfj010   #欄位標籤代碼
   DEFINE l_dzfj012         LIKE dzfj_t.dzfj012   #是否為參考欄位
   DEFINE l_success         LIKE type_t.chr1

   #預設l_posY = -1表示元件組合無任何widget
   LET l_posY = -1
   LET l_dzfj003  = ""
   LET l_dzfj012 = "N"
   LET l_dzfi005 = 0
   
   LET l_child_node = p_node.getFirstChild()
   
   WHILE l_child_node IS NOT NULL
      #判斷container裡是否還包了一層的container   
      CALL sadzp168_3_is_container(l_child_node.getTagName(), l_child_node.getAttribute("name"))
         RETURNING l_dzfi010, l_dzfi011

      #子節點若為Container,需再逐一解析內存的widget 元件組合方式
      IF l_dzfi010 = "0" OR l_dzfi010 = "1" THEN
         LET l_dzfi005 = l_dzfi005 + 1
         LET l_dzfi006 = p_node.getAttribute("name") CLIPPED   #元件(組)代碼

         LET p_dzfi012 = p_dzfi012 + 1
         
         #再往下層解析至元件組合結構為止
         IF NOT sadzp168_3_analyze(l_child_node, l_dzfi006, l_dzfi005, p_structure.*, p_dzfi012) THEN
            RETURN FALSE
         END IF
      ELSE
         #container內的widget屬性posY值相同的話,視為同一排組合元件(同一個群組)
         LET l_posY_widget = l_child_node.getAttribute("posY") 
         
         #如果是Phantom欄位沒有posY就直接指定為0
         IF l_posY_widget IS NULL AND l_child_node.getTagName() = "Phantom" THEN
            LET l_posY_widget = 0
         END IF
         
         IF l_posY <> l_posY_widget THEN
            #新元件組合群組成立
            LET l_new_group = TRUE   
            LET l_child_num = 1

            #同一排(posY)組合元件(同一個群組)
            LET l_posY = l_posY_widget
         ELSE
            LET l_new_group = FALSE
         END IF   
    
         #新的元件組合檔群組成立時,insert一筆回畫面結構檔
         IF l_new_group THEN
            #####insert 畫面結構檔資枓表#####
            LET g_dzfi003 = g_dzfi003 + 1

            #取得本次元件(組)代碼
            LET l_dzfj003 = g_widget_group, g_dzfi003 USING "<<<<<"
            
            LET l_dzfi.dzfi003 = g_dzfi003           #編號
            LET l_dzfi.dzfi004 = p_dzfi004 CLIPPED   #群組代碼
            LET l_dzfi005 = l_dzfi005 + 1
            LET l_dzfi.dzfi005 = l_dzfi005 CLIPPED   #順序
            LET l_dzfi.dzfi006 = l_dzfj003 CLIPPED   #元件(組)代碼 
            LET l_dzfi.dzfi007 = ""                  #節點類型
            LET l_dzfi.dzfi008 = "Y"                 #todo:UI解析資料暫時將dzfi008視為都需要組合(顯示)的元件
            LET l_dzfi.dzfi009 = g_dgenv             #客製標示:s-標準產品, c-客製
            LET l_dzfi.dzfi010 = "3"                 #包含元素類型
            LET l_dzfi.dzfi011 = ""                  #直橫排列V/H
            LET l_dzfi.dzfi012 = ""                  #節點階層
            LET l_dzfi.dzfi017 = g_dzfi017           #客戶代號
            LET l_dzfi.dzfi013 = l_child_node.getAttribute("posX") CLIPPED   #群組X軸位置
            LET l_dzfi.dzfi014 = l_child_node.getAttribute("posY") CLIPPED   #群組Y軸位置

            #insert 畫面結構檔
            IF NOT sadzp168_3_insert_dzfi(l_dzfi.*) THEN
               RETURN FALSE
            END IF
         END IF

         #依據單頭/單身不同,取得widget欄位標籤代碼
         LET l_label = sadzp168_3_get_label(p_node, l_child_node)

         #取得reference欄位控件時,需要將ref欄位控件代號資訊Update到前一個控件代號中(pmdb004=>pmdb004_desc)
         CALL sadzp168_3_get_ref_widget(l_child_node, l_dzfj_t.*)
            RETURNING l_success, l_dzfj012
            
         IF NOT l_success THEN
            ROLLBACK WORK
            RETURN FALSE
         END IF
         
         #####insert 畫面元件組合檔資枓表#####
         LET l_dzfj.dzfj001 = g_dzfi001 CLIPPED
         LET l_dzfj.dzfj002 = g_dzfi002 CLIPPED
         LET l_dzfj.dzfj003 = l_dzfj003 CLIPPED                           #群組代碼
         LET l_dzfj.dzfj004 = l_child_num                                 #順序
         LET l_dzfj.dzfj005 = l_child_node.getAttribute("name") CLIPPED   #元件名稱
         LET l_dzfj.dzfj006 = l_child_node.getTagName() CLIPPED           #節點類型
         LET l_dzfj.dzfj007 = p_structure.type CLIPPED                    #所屬結構類型
         LET l_dzfj.dzfj008 = p_structure.id CLIPPED                      #所屬結構代碼
         LET l_dzfj.dzfj009 = p_structure.label_text CLIPPED              #所屬結構標籤代碼
         LET l_dzfj.dzfjstus = "Y"
         LET l_dzfj.dzfj017 = g_dgenv                                     #客製標示:s-標準產品, c-客製
         LET l_dzfj.dzfj018 = g_dzfi017                                   #客戶代號

         IF cl_null(l_dzfj.dzfj008) THEN
            LET l_dzfj.dzfj008 = l_dzfi.dzfi004
         END IF

         LET l_dzfj.dzfj010 = l_label CLIPPED                             #欄位widget標籤代碼
         LET l_dzfj.dzfj011 = ""                                          #參考欄位控件代號
         LET l_dzfj.dzfj012 = l_dzfj012                                   #是否為參考欄位

         #記錄控件所佔畫面位置
         #控件起始X軸位置
         IF NOT cl_null(l_child_node.getAttribute("posX")) THEN
            LET l_dzfj.dzfj013 = l_child_node.getAttribute("posX") CLIPPED
            LET l_dzfj.dzfj015 = l_child_node.getAttribute("gridWidth") CLIPPED
         END IF
         
         #控件起始Y軸位置
         IF NOT cl_null(l_child_node.getAttribute("posY")) THEN
            LET l_dzfj.dzfj014 = l_child_node.getAttribute("posY") CLIPPED
            LET l_dzfj.dzfj016 = l_child_node.getAttribute("gridHeight") CLIPPED
         END IF
   
         #新增畫面元件組合檔設計資料畫面(widget設計資料)
         EXECUTE sadzp168_3_dzfj_ins_pre USING l_dzfj.dzfj001, l_dzfj.dzfj002, l_dzfj.dzfj003, l_dzfj.dzfj004, l_dzfj.dzfj005, 
                                               l_dzfj.dzfj006, l_dzfj.dzfj007, l_dzfj.dzfj008, l_dzfj.dzfj009, l_dzfj.dzfj010,
                                               l_dzfj.dzfj011, l_dzfj.dzfj012, l_dzfj.dzfj013, l_dzfj.dzfj014, l_dzfj.dzfj015, 
                                               l_dzfj.dzfj016, l_dzfj.dzfjstus, l_dzfj.dzfj017, l_dzfj.dzfj018
         IF SQLCA.sqlcode THEN
            LET g_error_message = "ERROR-PREPARE sadzp168_3_dzfj_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
            DISPLAY g_error_message

            ROLLBACK WORK
            RETURN FALSE
         END IF
      END IF

      LET l_dzfj_t.* = l_dzfj.*
      
      #紀錄各節點(包含container和widget..等)屬性值
      IF NOT sadzp168_3_insert_attr(l_child_node) THEN
         RETURN FALSE
      END IF
      
      LET l_child_node = l_child_node.getNext()
      LET l_child_num = l_child_num + 1
   END WHILE

   RETURN TRUE
END FUNCTION

#+ insert 畫面結構檔
PRIVATE FUNCTION sadzp168_3_insert_dzfi(p_dzfi)
   DEFINE p_dzfi            type_g_dzfi           #畫面結構檔 

   LET p_dzfi.dzfi001 = g_dzfi001 CLIPPED
   LET p_dzfi.dzfi002 = g_dzfi002 CLIPPED
   
   LET p_dzfi.dzfiownid = g_user
   LET p_dzfi.dzfiowndp = g_dept
   LET p_dzfi.dzficrtid = g_user
   LET p_dzfi.dzficrtdp = g_dept
   LET p_dzfi.dzficrtdt = cl_get_current()
   LET p_dzfi.dzfimodid = g_user
   LET p_dzfi.dzfimoddt = cl_get_current()
   LET p_dzfi.dzfistus = "Y"
   
   EXECUTE sadzp168_3_dzfi_ins_pre USING p_dzfi.dzfi001, p_dzfi.dzfi002, p_dzfi.dzfi003, p_dzfi.dzfi004, p_dzfi.dzfi005, 
                                         p_dzfi.dzfi006, p_dzfi.dzfi007, p_dzfi.dzfi008, p_dzfi.dzfi009, p_dzfi.dzfi010, 
                                         p_dzfi.dzfi011, p_dzfi.dzfi012, p_dzfi.dzfi013, p_dzfi.dzfi014, p_dzfi.dzfi015, 
                                         p_dzfi.dzfi016, p_dzfi.dzfi017, 
                                         p_dzfi.dzfiownid, p_dzfi.dzfiowndp, p_dzfi.dzficrtid, p_dzfi.dzficrtdp, p_dzfi.dzficrtdt, 
                                         p_dzfi.dzfimodid, p_dzfi.dzfimoddt, p_dzfi.dzfistus
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_dzfi_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message

      ROLLBACK WORK
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ insert 畫面元件屬性檔
PRIVATE FUNCTION sadzp168_3_insert_attr(p_node)
   DEFINE p_node            om.DomNode          #widget Node
   
   DEFINE l_dzfk            type_g_dzfk
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_domDoc          om.DomDocument
   DEFINE l_root_node       om.DomNode
   
   IF p_node IS NULL THEN
      RETURN FALSE
   END IF

   #####insert 畫面元件屬性檔資枓表#####
   LET l_dzfk.dzfk001 = g_dzfi001 CLIPPED
   LET l_dzfk.dzfk002 = g_dzfi002 CLIPPED
   LET l_dzfk.dzfk007 = g_dgenv             #客製標示:s-標準產品, c-客製
   LET l_dzfk.dzfk008 = g_dzfi017 CLIPPED   #客戶代號

   LET l_dzfk.dzfk003 = p_node.getAttribute("name") CLIPPED     #元件代碼
   LET l_dzfk.dzfk004 = ""
   LET l_dzfk.dzfk005 = ""
   LET l_dzfk.dzfk006 = "" 

   #取得節點所有屬性資料
   LOCATE l_dzfk.dzfk009 IN FILE
   LET l_domDoc = om.DomDocument.createFromString(p_node.toString())
   LET l_root_node = l_domDoc.copy(p_node, FALSE)
   LET l_dzfk.dzfk009 = l_root_node.toString()

   EXECUTE sadzp168_3_dzfk_ins_pre USING l_dzfk.dzfk001, l_dzfk.dzfk002, l_dzfk.dzfk003, l_dzfk.dzfk004, l_dzfk.dzfk005, 
                                         l_dzfk.dzfk006, l_dzfk.dzfk007, l_dzfk.dzfk008, l_dzfk.dzfk009

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-EXECUTE sadzp168_3_dzfk_ins_pre.", l_dzfk.dzfk003 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      FREE l_dzfk.dzfk009
      ROLLBACK WORK
      RETURN FALSE
   END IF
   
   FREE l_dzfk.dzfk009
   
   #widget為"ComboBox"和"RadioGroup"時,需紀錄資料項目(item子項目)
   IF p_node.getTagName() = "ComboBox" OR p_node.getTagName() = "RadioGroup" THEN
      IF NOT sadzp168_3_insert_items(p_node) THEN
         RETURN FALSE
       END IF
   END IF
   
   RETURN TRUE
END FUNCTION

#+ insert 畫面元件資料項目檔
PRIVATE FUNCTION sadzp168_3_insert_items(p_node)
   DEFINE p_node            om.DomNode          #widget Node

   DEFINE l_dzfl            type_g_dzfl
   DEFINE l_child_node      om.DomNode          #子節點
   DEFINE l_child_num       LIKE type_t.num5    #同一群組下的widget排列順序

   IF p_node IS NULL THEN
      RETURN FALSE
   END IF
   
   LET l_child_node = p_node.getFirstChild()
   LET l_child_num = 1

   #####insert 畫面元件資料項目檔資枓表#####
   LET l_dzfl.dzfl001 = g_dzfi001 CLIPPED
   LET l_dzfl.dzfl002 = g_dzfi002 CLIPPED
   LET l_dzfl.dzflstus = "Y"
   LET l_dzfl.dzfl007 = g_dgenv             #客製標示:s-標準產品, c-客製
   LET l_dzfl.dzfl008 = g_dzfi017 CLIPPED   #客戶代號
   
   WHILE l_child_node IS NOT NULL
       LET l_dzfl.dzfl003 = p_node.getAttribute("name") CLIPPED         #元件代碼
       LET l_dzfl.dzfl004 = l_child_num                                 #編號
       LET l_dzfl.dzfl005 = l_child_node.getAttribute("name") CLIPPED   #項目name
       LET l_dzfl.dzfl006 = l_child_node.getAttribute("text") CLIPPED   #項目text
 
       EXECUTE sadzp168_3_dzfl_ins_pre USING l_dzfl.dzfl001, l_dzfl.dzfl002, l_dzfl.dzfl003, l_dzfl.dzfl004, l_dzfl.dzfl005, 
                                             l_dzfl.dzfl006, l_dzfl.dzflstus, l_dzfl.dzfl007, l_dzfl.dzfl008
       IF SQLCA.sqlcode THEN
          LET g_error_message = "ERROR-EXECUTE sadzp168_3_dzfl_ins_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
          DISPLAY g_error_message

          ROLLBACK WORK
          RETURN FALSE
       END IF
          
      LET l_child_node = l_child_node.getNext()
      LET l_child_num = l_child_num + 1
   END WHILE

   RETURN TRUE
END FUNCTION

#取得欄位標籤代碼. exp:imba001=>lbl_imba001
PRIVATE FUNCTION sadzp168_3_get_label(p_node, p_child_node)
   DEFINE p_node            om.DomNode            #Container Node
   DEFINE p_child_node      om.DomNode            #子節點

   DEFINE l_label           LIKE dzfj_t.dzfj010   #欄位標籤代碼
   DEFINE l_previous_node   om.DomNode            #前一個節點

   LET l_label = ""

   CASE
      #紀錄單身欄位標籤代碼(父節點一定為Table container)
      WHEN (p_node.getTagName() = "Table" OR p_node.getTagName() = "Tree" )
         LET l_label = p_child_node.getAttribute("title") CLIPPED
         RETURN l_label

      #CheckBox widget直接取得text屬性
      WHEN p_child_node.getTagName() = "CheckBox"
         LET l_label = p_child_node.getAttribute("text") CLIPPED

      #紀錄單頭欄位標籤代碼,直接取得label widget名稱
      #WHEN p_child_node.getTagName() = "Label"
         #LET l_label = p_child_node.getAttribute("name") CLIPPED
         
      OTHERWISE
         #紀錄單頭欄位標籤代碼,直接取得label widget名稱
         #單頭欄位標籤代碼,按規則應該都是和欄位控件的posY值相同(同一排)且在前面(previous node)
         LET l_previous_node = p_child_node.getPrevious()

         IF p_child_node.getAttribute("posY") = l_previous_node.getAttribute("posY") THEN
            CASE l_previous_node.getTagName()
               WHEN "Label" 
                  LET l_label = l_previous_node.getAttribute("text") CLIPPED 
                  IF l_label IS NULL THEN
                     LET l_label = l_previous_node.getAttribute("name") CLIPPED
                  END IF

               #串查欄位呈現
               WHEN "Button" 
                  IF l_previous_node.getAttribute("style") = "button_qrystr" AND l_previous_node.getAttribute("name") MATCHES "prog_*" THEN
                     LET l_label = l_previous_node.getAttribute("text") CLIPPED
                  END IF
                  
            END CASE
         END IF

   END CASE

   #下述控件型態在欄位前方應該不會有文字說明
   IF p_child_node.getTagName() = "Phantom" OR p_child_node.getTagName() = "FFLabel" OR p_child_node.getTagName() = "Label" OR 
      p_child_node.getTagName() = "Button" OR p_child_node.getTagName() = "Slider" OR p_child_node.getTagName() = "ProgressBar" OR
      p_child_node.getTagName() = "SpinEdit" THEN
      
      LET l_label = ""
   END IF
   
   RETURN l_label
END FUNCTION

#取得欄位reference說明. exp:pmdb004=>pmdb004_desc
PRIVATE FUNCTION sadzp168_3_get_ref_widget(p_child_node, p_dzfj)
   DEFINE p_child_node      om.DomNode            #子節點
   DEFINE p_dzfj            type_g_dzfj           #畫面元件組合檔

   DEFINE l_ref_widget      LIKE dzfj_t.dzfj011   #參考欄位控件代號
   DEFINE l_previous_node   om.DomNode            #前一個控件欄位
   DEFINE l_str             STRING
   DEFINE l_dzfj012         LIKE dzfj_t.dzfj012   #是否為參考欄位

   LET l_ref_widget = ""
   LET l_dzfj012 = "N"

   #判斷是否為reference說明欄位控件
   IF p_child_node.getTagName() = "FFLabel" AND 
      (p_child_node.getAttribute("style") = "reference" OR p_child_node.getAttribute("style") = "extend_reference") AND
      p_child_node.getAttribute("name") MATCHES "*_desc" THEN
      
      LET l_ref_widget = p_child_node.getAttribute("name") CLIPPED
      LET l_previous_node = p_child_node.getPrevious()
      LET l_str = l_ref_widget
   END IF

   #下述控件型態若在參考欄位[前方]出現,應該不會有參考欄位的說明文字,因此排除
   IF l_previous_node.getTagName() = "Phantom" OR l_previous_node.getTagName() = "FFLabel" OR      #l_previous_node.getTagName() = "Label" OR 
      l_previous_node.getTagName() = "Button" OR l_previous_node.getTagName() = "Slider" OR l_previous_node.getTagName() = "ProgressBar" OR
      l_previous_node.getTagName() = "SpinEdit" THEN
      
      LET l_ref_widget = ""
   END IF

   #將ref欄位控件代號資訊Update到前一個控件代號中
   IF (NOT cl_null(l_ref_widget)) AND (NOT cl_null(p_dzfj.dzfj004)) THEN
      UPDATE dzfj_t SET dzfj011 = l_ref_widget
        WHERE dzfj001 = p_dzfj.dzfj001
          AND dzfj002 = p_dzfj.dzfj002
          AND dzfj003 = p_dzfj.dzfj003
          AND dzfj004 = p_dzfj.dzfj004
          AND dzfj017 = p_dzfj.dzfj017

      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-upd dzfj_t:", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message

         ROLLBACK WORK
         RETURN FALSE, l_dzfj012
      END IF 
      
      LET l_dzfj012 = "Y"
   END IF
    
   RETURN TRUE, l_dzfj012
END FUNCTION

#+ delete 畫面相關設計資訊
PUBLIC FUNCTION sadzp168_3_reload_delete(p_dzfi001, p_dzfi002, p_dzfi009)
   DEFINE p_dzfi001         LIKE dzfi_t.dzfi001    #畫面代碼
   DEFINE p_dzfi002         LIKE dzfi_t.dzfi002    #設計點版本
   DEFINE p_dzfi009         LIKE dzfi_t.dzfi009    #客製標示:s-標準產品, c-客製
   
   #DEFINE l_dzfi017         LIKE dzfi_t.dzfi017    #客戶代號

   #LET l_dzfi009 = g_dgenv
   IF cl_null(p_dzfi009) THEN
      LET p_dzfi009 = FGL_GETENV("DGENV")     #"s":標準; "c"客製
   END IF

   DELETE FROM dzfi_t WHERE dzfi001 = p_dzfi001 AND dzfi002 = p_dzfi002 AND dzfi009 = p_dzfi009
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-del dzfi_t:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   DELETE FROM dzfj_t WHERE dzfj001 = p_dzfi001 AND dzfj002 = p_dzfi002 AND dzfj017 = p_dzfi009
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-del dzfj_t:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   DELETE FROM dzfk_t WHERE dzfk001 = p_dzfi001 AND dzfk002 = p_dzfi002 AND dzfk007 = p_dzfi009
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-del dzfk_t:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   DELETE FROM dzfl_t WHERE dzfl001 = p_dzfi001 AND dzfl002 = p_dzfi002 AND dzfl007 = p_dzfi009
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-del dzfl_t:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

#取得控件所屬結構
PRIVATE FUNCTION sadzp168_3_get_structure(p_dzfi006, p_dzfi007, p_dzfi012, p_text, p_structure)
   DEFINE p_dzfi006         LIKE dzfi_t.dzfi006     #container代碼
   DEFINE p_dzfi007         LIKE dzfi_t.dzfi007     #container類型
   DEFINE p_dzfi012         LIKE dzfi_t.dzfi012     #container節點所屬階層
   DEFINE p_text            STRING                  #container標籤代碼
   DEFINE p_structure       type_g_structure

   #結構分類定義:1.Page 2.Group 3.Table
   #以最先找到(最上層結構為區分)結構為主,意同:Page > Group > Table
   #如果已存在所屬結構,且為最上層
   IF (NOT cl_null(p_structure.id)) AND (p_structure.level < p_dzfi012) THEN
      IF NOT (p_structure.type = "Group" AND (p_dzfi007 = "Page" OR p_dzfi007 = "Table")) THEN 
         RETURN p_structure.*
      END IF
   END IF

   IF p_dzfi007 = "Page" OR p_dzfi007 = "Group" OR p_dzfi007 = "Table" THEN
      INITIALIZE p_structure TO NULL

      #記錄widget所屬結構資訊
      LET p_structure.type = p_dzfi007
      LET p_structure.id = p_dzfi006
      LET p_structure.label_text = p_text
      LET p_structure.level = p_dzfi012

      IF cl_null(p_structure.label_text) THEN
         LET p_structure.label_text = p_dzfi006
      END IF
   END IF
   
   RETURN p_structure.*
END FUNCTION

#比對客製與標準的元件差異
PRIVATE FUNCTION sadzp168_3_get_diff_element(p_module, p_dzfi001, p_dzfi002, p_dzfi009)
   DEFINE p_module          STRING                  #畫面檔所在模組
   DEFINE p_dzfi001         LIKE dzfi_t.dzfi001     #結構代號
   DEFINE p_dzfi002         LIKE dzfi_t.dzfi002     #規格版次
   DEFINE p_dzfi009         LIKE dzfi_t.dzfi009     #客製標示:s-標準產品, c-客製

   DEFINE l_type            LIKE type_t.chr1        #比對類型(1:以標準為主檢查失效; 2:以客製為主檢查是否"又"恢復生效)
   DEFINE l_dzfi002_base    LIKE dzfi_t.dzfi002     #比對基礎資料的規格版次
   DEFINE l_dzfi002_cont    LIKE dzfi_t.dzfi002     #對比資料的規格版次
   DEFINE l_dzfq005         LIKE dzfq_t.dzfq005     #畫面類別
   DEFINE lo_DZAF_T         T_DZAF_T
   DEFINE lo_DZAF_T_new     T_DZAF_T
   DEFINE l_cnt             LIKE type_t.num5

   #只在客戶家環境做比對失效功能
   IF p_dzfi009 = "s" OR p_dzfi002 = 1 THEN
      RETURN TRUE
   END IF

   #取得是否為全新客製程式
   SELECT COUNT(*) INTO l_cnt FROM dzaf_t 
     WHERE dzaf001 = p_dzfi001 AND dzaf010 = 's'

   #相同畫面代碼下沒有任何標準('s')的版次資料,視為全新客製畫面,此時也不需要和標準畫面做差異比對
   IF l_cnt = 0 THEN
      RETURN TRUE
   END IF
   
   #比對二版次間的設計資料差異範例:
   #SELECT s.dzfi006, s.dzfi010
   #  FROM (SELECT * FROM dzfi_t 
   #          WHERE dzfi001 = 'aiti170' AND dzfi002 = 1 AND dzfi009 = 's'
   #            AND (dzfi010 = '0' OR dzfi010 = '1')) s
   #  WHERE NOT EXISTS
   #    (SELECT * FROM dzfi_t c
   #       WHERE dzfi001 = 'aiti170' AND dzfi002 = 1 AND dzfi009 = 'c'
   #         AND (dzfi010 = '0' OR dzfi010 = '1')
   #         AND s.dzfi001 = c.dzfi001
   #         AND s.dzfi006 = c.dzfi006);

   #取得客製過後已失效的UI元件(以標準為主,客製為比對資料):檢查那些標準版的UI元件已不存在客製版的設計資料中
   #LET l_type = "1"

   #SELECT MAX(dzfi002) FROM dzfi_t
   #對比資料設定為客製畫面此次的版次(比對失效功能預設只在客戶家才做) 
   LET l_dzfi002_cont = p_dzfi002

   #取得畫面所屬類別(M:主程式畫面, S:子程式畫面, F:子畫面)
   LET l_dzfq005 = sadzp060_2_chk_spec_type(p_dzfi001)

   #取得標準畫面的最大版次
   LET lo_DZAF_T.DZAF001 = p_dzfi001 CLIPPED
   LET lo_DZAF_T.DZAF005 = l_dzfq005 CLIPPED
   LET lo_DZAF_T.DZAF006 = p_module.trim()
   LET lo_DZAF_T.DZAF002 = 0
   LET lo_DZAF_T.DZAF010 = "s"

   CALL sadzp200_ver_get_curr_ver_info(lo_DZAF_T.*) RETURNING lo_DZAF_T_new.*
   IF cl_null(lo_DZAF_T_new.DZAF002) OR lo_DZAF_T_new.DZAF002 = 0 THEN
      LET g_error_message = "ERROR: ", p_dzfi001 CLIPPED, " revision info is NULL"
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   #取得規格版次資料   
   LET l_dzfi002_base = lo_DZAF_T_new.dzaf003 CLIPPED

   IF cl_null(l_dzfi002_base) OR l_dzfi002_base = 0 THEN 
      LET g_error_message = "ERROR : ", p_dzfi001 CLIPPED, " spec revision is NULL or 0"
      DISPLAY g_error_message
      RETURN FALSE
   END IF
      
   #比對Container設計資料差異
   IF NOT sadzp168_3_get_diff_dzfi(p_dzfi001, l_dzfi002_base, l_dzfi002_cont, "s", "c") THEN
      RETURN FALSE
   END IF

   #比對Widget設計資料差異
   IF NOT sadzp168_3_get_diff_dzfj(p_dzfi001, l_dzfi002_base, l_dzfi002_cont, "s", "c") THEN
      RETURN FALSE
   END IF

   #比對Item項目設計資料差異
   IF NOT sadzp168_3_get_diff_dzfl(p_dzfi001, l_dzfi002_base, l_dzfi002_cont, "s", "c") THEN
      RETURN FALSE
   END IF
   
   #檢查[container]代碼是否"又"恢復生效
   IF NOT sadzp168_3_dzfa_delete_container(p_dzfi001, l_dzfi002_cont, p_dzfi009) THEN
      RETURN FALSE
   END IF
   
   #檢查[widget]代碼是否"又"恢復生效
   #IF NOT sadzp168_3_dzfa_delete_widget(p_dzfi001, l_dzfi002_base) THEN
   IF NOT sadzp168_3_dzfa_delete_widget(p_dzfi001, l_dzfi002_cont, p_dzfi009) THEN
      RETURN FALSE
   END IF
   
   #檢查[item資料項目]代碼是否"又"恢復生效
   IF NOT sadzp168_3_dzfa_delete_item(p_dzfi001, l_dzfi002_cont, p_dzfi009) THEN
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

#比對標準和客製二版次間的dzfi_t(畫面結構檔)設計資料差異
PRIVATE FUNCTION sadzp168_3_get_diff_dzfi(p_dzfi001, p_dzfi002_base, p_dzfi002_cont, p_dzfi009_base, p_dzfi009_cont)
   #DEFINE p_type            LIKE type_t.chr1        #比對類型(1:以標準為主檢查失效; 2:以客製為主檢查是否"又"恢復生效)
   DEFINE p_dzfi001         LIKE dzfi_t.dzfi001     #結構代號
   DEFINE p_dzfi002_base    LIKE dzfi_t.dzfi002     #比對基礎資料的規格版次
   DEFINE p_dzfi002_cont    LIKE dzfi_t.dzfi002     #對比資料的規格版次
   DEFINE p_dzfi009_base    LIKE dzfi_t.dzfi009     #比對基礎資料的客製標示
   DEFINE p_dzfi009_cont    LIKE dzfi_t.dzfi009     #對比資料的客製標示

   DEFINE l_dzfi006         LIKE dzfi_t.dzfi006     #元件(組)代碼
   DEFINE l_dzfi010         LIKE dzfi_t.dzfi010     #包含元素類型
   
   #檢查客製和標準畫面Container元件的設計資料差異
   OPEN sadzp168_3_dzfi_cs USING p_dzfi001, p_dzfi002_base, p_dzfi009_base, p_dzfi001, p_dzfi002_cont, p_dzfi009_cont
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-OPEN sadzp168_3_dzfi_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message

      CLOSE sadzp168_3_dzfi_cs
      ROLLBACK WORK
      RETURN FALSE
   END IF

   FOREACH sadzp168_3_dzfi_cs INTO l_dzfi006, l_dzfi010
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-FOREACH sadzp168_3_dzfi_cs.", l_dzfi006 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message

         ROLLBACK WORK
         RETURN FALSE
      END IF

      IF NOT sadzp168_3_insert_dzfa(l_dzfi006, "0", l_dzfi006) THEN
         RETURN FALSE
      END IF
   END FOREACH

   RETURN TRUE
END FUNCTION

#比對標準和客製二版次間的dzfj_t(畫面元件組合檔)設計資料差異
PRIVATE FUNCTION sadzp168_3_get_diff_dzfj(p_dzfj001, p_dzfj002_base, p_dzfj002_cont, p_dzfj017_base, p_dzfj017_cont)
   #DEFINE p_type            LIKE type_t.chr1        #比對類型(1:以標準為主檢查失效; 2:以客製為主檢查是否"又"恢復生效)
   DEFINE p_dzfj001         LIKE dzfj_t.dzfj001     #結構代號
   DEFINE p_dzfj002_base    LIKE dzfj_t.dzfj002     #比對基礎資料的規格版次
   DEFINE p_dzfj002_cont    LIKE dzfj_t.dzfj002     #對比資料的規格版次
   DEFINE p_dzfj017_base    LIKE dzfj_t.dzfj017     #比對基礎資料的客製標示
   DEFINE p_dzfj017_cont    LIKE dzfj_t.dzfj017     #對比資料的客製標示

   DEFINE l_dzfj005         LIKE dzfj_t.dzfj005     #Widget元件代碼
   
   #檢查客製和標準畫面Widget元件的設計資料差異
   OPEN sadzp168_3_dzfj_cs USING p_dzfj001, p_dzfj002_base, p_dzfj017_base, p_dzfj001, p_dzfj002_cont, p_dzfj017_cont
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-OPEN sadzp168_3_dzfj_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message

      CLOSE sadzp168_3_dzfj_cs
      ROLLBACK WORK
      RETURN FALSE
   END IF

   FOREACH sadzp168_3_dzfj_cs INTO l_dzfj005
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-FOREACH sadzp168_3_dzfj_cs.", l_dzfj005 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message

         ROLLBACK WORK
         RETURN FALSE
      END IF

      IF NOT sadzp168_3_insert_dzfa(l_dzfj005, "1", l_dzfj005) THEN
         RETURN FALSE
      END IF
   END FOREACH

   RETURN TRUE
END FUNCTION

#比對標準和客製二版次間的dzfl_t(畫面元件資料項目檔)設計資料差異
PRIVATE FUNCTION sadzp168_3_get_diff_dzfl(p_dzfl001, p_dzfl002_base, p_dzfl002_cont, p_dzfl007_base, p_dzfl007_cont)
   #DEFINE p_type            LIKE type_t.chr1        #比對類型(1:以標準為主檢查失效; 2:以客製為主檢查是否"又"恢復生效)
   DEFINE p_dzfl001         LIKE dzfl_t.dzfl001     #結構代號
   DEFINE p_dzfl002_base    LIKE dzfl_t.dzfl002     #比對基礎資料的規格版次
   DEFINE p_dzfl002_cont    LIKE dzfl_t.dzfl002     #對比資料的規格版次
   DEFINE p_dzfl007_base    LIKE dzfl_t.dzfl007     #比對基礎資料的客製標示
   DEFINE p_dzfl007_cont    LIKE dzfl_t.dzfl007     #對比資料的客製標示

   DEFINE l_dzfl003         LIKE dzfl_t.dzfl003     #Widget元件代碼
   DEFINE l_dzfl005         LIKE dzfl_t.dzfl005     #Item項目name
   
   #檢查客製和標準畫面ComboBox/RadioGroup的Item設計資料差異
   OPEN sadzp168_3_dzfl_cs USING p_dzfl001, p_dzfl002_base, p_dzfl007_base, p_dzfl001, p_dzfl002_cont, p_dzfl007_cont
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-OPEN sadzp168_3_dzfl_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message

      CLOSE sadzp168_3_dzfl_cs
      ROLLBACK WORK
      RETURN FALSE
   END IF

   FOREACH sadzp168_3_dzfl_cs INTO l_dzfl003, l_dzfl005
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-FOREACH sadzp168_3_dzfl_cs.", l_dzfl003 CLIPPED, "(", l_dzfl005 CLIPPED, ")", ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message

         ROLLBACK WORK
         RETURN FALSE
      END IF

      IF NOT sadzp168_3_insert_dzfa(l_dzfl003, "2", l_dzfl005) THEN
         RETURN FALSE
      END IF
   END FOREACH

   RETURN TRUE
END FUNCTION

#+ insert 畫面UI元件失效檔
PRIVATE FUNCTION sadzp168_3_insert_dzfa(p_dzfa002, p_dzfa005, p_dzfa007)
   DEFINE p_dzfa002         LIKE dzfa_t.dzfa002     #失效UI代碼
   DEFINE p_dzfa005         LIKE dzfa_t.dzfa005     #UI元件類型
   DEFINE p_dzfa007         LIKE dzfa_t.dzfa007     #失效項目name(Item)
   
   DEFINE l_dzfa            type_g_dzfa             #畫面UI元件失效檔
   DEFINE l_cnt             LIKE type_t.num5

   LET l_cnt = 0

   #檢查失效UI元件是否已存在
   IF p_dzfa007 = "2" THEN
      #ComboBox、RadioGroup的Item項目資料
      SELECT COUNT(*) INTO l_cnt FROM dzfa_t
        WHERE dzfa001 = g_dzfi001
          AND dzfa002 = p_dzfa002
          AND dzfa003 = 'c'
          AND dzfa005 = p_dzfa005
          AND dzfa007 = p_dzfa007
   ELSE
      SELECT COUNT(*) INTO l_cnt FROM dzfa_t
        WHERE dzfa001 = g_dzfi001
          AND dzfa002 = p_dzfa002
          AND dzfa003 = 'c'
          AND dzfa005 = p_dzfa005
   END IF
   
   IF l_cnt > 0 THEN
      RETURN TRUE
   END IF
      
   LET l_dzfa.dzfa001 = g_dzfi001 CLIPPED
   LET l_dzfa.dzfa002 = p_dzfa002 CLIPPED
   LET l_dzfa.dzfa003 = "c"                 #todo:因為判斷客製畫面所以固定傳"c"
   LET l_dzfa.dzfa004 = g_dzfi017 CLIPPED
   LET l_dzfa.dzfa005 = p_dzfa005           #失效UI元件類型為"0":container; "1":Widget; "2":Item(ComboBox、RadioGroup)
   LET l_dzfa.dzfa006 = g_dzfi002 CLIPPED
   LET l_dzfa.dzfa007 = p_dzfa007

   LET l_dzfa.dzfaownid = g_user
   LET l_dzfa.dzfaowndp = g_dept
   LET l_dzfa.dzfacrtid = g_user
   LET l_dzfa.dzfacrtdp = g_dept
   LET l_dzfa.dzfacrtdt = cl_get_current()
   LET l_dzfa.dzfamodid = g_user
   LET l_dzfa.dzfamoddt = cl_get_current()
   
   EXECUTE sadzp168_3_dzfa_ins_pre USING l_dzfa.dzfa001, l_dzfa.dzfa002, l_dzfa.dzfa003, l_dzfa.dzfa004, l_dzfa.dzfa005, 
                                         l_dzfa.dzfa006, l_dzfa.dzfa007, 
                                         l_dzfa.dzfaownid, l_dzfa.dzfaowndp, l_dzfa.dzfacrtid, l_dzfa.dzfacrtdp, l_dzfa.dzfacrtdt, 
                                         l_dzfa.dzfamodid, l_dzfa.dzfamoddt
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_3_dzfa_ins_pre.", p_dzfa002 CLIPPED,":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message

      ROLLBACK WORK
      RETURN FALSE
   END IF
      
   RETURN TRUE
END FUNCTION

#+ 檢查已失效的客製畫面[container]"代碼"是否"又"恢復生效,需從畫面UI元件失效檔刪除此筆資料
PRIVATE FUNCTION sadzp168_3_dzfa_delete_container(p_dzfi001, p_dzfi002, p_dzfa003)
   DEFINE p_dzfi001         LIKE dzfi_t.dzfi001     #結構代號
   DEFINE p_dzfi002         LIKE dzfi_t.dzfi002     #規格版次
   DEFINE p_dzfa003         LIKE dzfa_t.dzfa003     #dzfa_t客製標示

   #DEFINE l_dzfi009         LIKE dzfi_t.dzfi009     #dzfi_t客製標示
   DEFINE l_dzfa            type_g_dzfa

   #LET l_dzfa003 = "c"   #畫面UI元件失效檔皆為[客製版]設計資訊
   #LET l_dzfi009 = "s"   #對比dzfi_t的[標準版]畫面UI設計資訊

   #檢查Container是否有生效的代碼,並刪除此筆失效資料
   #比對是否"又"恢復生效的設計資料範例:
   #SELECT dzfa002, dzfa005, dzfa007
   #  FROM (SELECT * FROM dzfa_t 
   #          WHERE dzfa001 = 'aiti170' AND dzfa003 = 'c'
   #            AND dzfa005 = '0')
   #  WHERE EXISTS
   #    (SELECT * FROM dzfi_t
   #       WHERE dzfi001 = 'aiti170' AND dzfi002 = 1 AND dzfi009 = 'c'
   #         AND (dzfi010 = '0' OR dzfi010 = '1')
   #         AND dzfa001 = dzfi001
   #         AND dzfa002 = dzfi006)

   OPEN sadzp168_3_container_cs USING p_dzfi001, p_dzfa003, p_dzfi001, p_dzfi002, p_dzfa003
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-OPEN sadzp168_3_container_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message

      CLOSE sadzp168_3_container_cs
      ROLLBACK WORK
      RETURN FALSE
   END IF

   #逐筆刪除失效資料
   FOREACH sadzp168_3_container_cs INTO l_dzfa.dzfa001, l_dzfa.dzfa002, l_dzfa.dzfa003, l_dzfa.dzfa005, l_dzfa.dzfa007
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-FOREACH sadzp168_3_container_cs.", p_dzfi001 CLIPPED, "(", l_dzfa.dzfa002 CLIPPED, ")", ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message

         ROLLBACK WORK
         RETURN FALSE
      END IF

      IF NOT sadzp168_3_delete_dzfa(l_dzfa.*) THEN
         RETURN FALSE
      END IF
   END FOREACH
   
   RETURN TRUE
END FUNCTION

#+ 檢查已失效的客製畫面[widget]"代碼"是否"又"恢復生效,需從畫面UI元件失效檔刪除此筆資料
PRIVATE FUNCTION sadzp168_3_dzfa_delete_widget(p_dzfj001, p_dzfj002, p_dzfa003)
   DEFINE p_dzfj001         LIKE dzfj_t.dzfj001     #結構代號
   DEFINE p_dzfj002         LIKE dzfj_t.dzfj002     #規格版次
   DEFINE p_dzfa003         LIKE dzfa_t.dzfa003     #dzfa_t客製標示
   
   #DEFINE l_dzfa003         LIKE dzfa_t.dzfa003     #dzfa_t客製標示
   #DEFINE l_dzfj017         LIKE dzfj_t.dzfj017     #dzfj_t客製標示
   DEFINE l_dzfa            type_g_dzfa

   #LET l_dzfa003 = "c"   #畫面UI元件失效檔皆為[客製版]設計資訊
   #LET l_dzfj017 = "s"   #對比dzfj_t的[標準版]畫面UI設計資訊

   #檢查widget是否有生效的代碼,並刪除此筆失效資料
   #OPEN sadzp168_3_widget_cs USING p_dzfj001, l_dzfa003, p_dzfj001, p_dzfj002, l_dzfj017
   OPEN sadzp168_3_widget_cs USING p_dzfj001, p_dzfa003, p_dzfj001, p_dzfj002, p_dzfa003
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-OPEN sadzp168_3_widget_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message

      CLOSE sadzp168_3_widget_cs
      ROLLBACK WORK
      RETURN FALSE
   END IF

   #逐筆刪除失效資料
   FOREACH sadzp168_3_widget_cs INTO l_dzfa.dzfa001, l_dzfa.dzfa002, l_dzfa.dzfa003, l_dzfa.dzfa005, l_dzfa.dzfa007
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-FOREACH sadzp168_3_widget_cs.", p_dzfj001 CLIPPED, "(", l_dzfa.dzfa002 CLIPPED, ")", ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message

         ROLLBACK WORK
         RETURN FALSE
      END IF

      IF NOT sadzp168_3_delete_dzfa(l_dzfa.*) THEN
         RETURN FALSE
      END IF
   END FOREACH
   
   RETURN TRUE
END FUNCTION

#+ 檢查已失效的客製畫面[item資料項目]是否"又"恢復生效,需從畫面UI元件失效檔刪除此筆資料
PRIVATE FUNCTION sadzp168_3_dzfa_delete_item(p_dzfl001, p_dzfl002, p_dzfa003)
   DEFINE p_dzfl001         LIKE dzfl_t.dzfl001     #結構代號
   DEFINE p_dzfl002         LIKE dzfl_t.dzfl002     #規格版次
   DEFINE p_dzfa003         LIKE dzfa_t.dzfa003     #dzfa_t客製標示

   #DEFINE l_dzfa003         LIKE dzfa_t.dzfa003     #dzfa_t客製標示
   #DEFINE l_dzfl007         LIKE dzfl_t.dzfl007     #dzfl_t客製標示
   DEFINE l_dzfa            type_g_dzfa

   #LET l_dzfa003 = "c"   #畫面UI元件失效檔皆為[客製版]設計資訊
   #LET l_dzfl007 = "s"   #對比dzfl_t的[標準版]畫面UI設計資訊

   #檢查item是否有生效的代碼,並刪除此筆失效資料
   OPEN sadzp168_3_item_cs USING p_dzfl001, p_dzfa003, p_dzfl001, p_dzfl002, p_dzfa003
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-OPEN sadzp168_3_item_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message

      CLOSE sadzp168_3_item_cs
      ROLLBACK WORK
      RETURN FALSE
   END IF

   #逐筆刪除失效資料
   FOREACH sadzp168_3_item_cs INTO l_dzfa.dzfa001, l_dzfa.dzfa002, l_dzfa.dzfa003, l_dzfa.dzfa005, l_dzfa.dzfa007
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-FOREACH sadzp168_3_item_cs.", p_dzfl001 CLIPPED, "(", l_dzfa.dzfa002 CLIPPED, ")", ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message

         ROLLBACK WORK
         RETURN FALSE
      END IF

      IF NOT sadzp168_3_delete_dzfa(l_dzfa.*) THEN
         RETURN FALSE
      END IF
   END FOREACH
   
   RETURN TRUE
END FUNCTION

#+ delete 畫面UI元件失效檔
PRIVATE FUNCTION sadzp168_3_delete_dzfa(p_dzfa)
   DEFINE p_dzfa            type_g_dzfa

   DELETE FROM dzfa_t 
     WHERE dzfa001 = p_dzfa.dzfa001
       AND dzfa002 = p_dzfa.dzfa002
       AND dzfa003 = p_dzfa.dzfa003
       AND dzfa005 = p_dzfa.dzfa005
       AND dzfa007 = p_dzfa.dzfa007
       
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-del dzfa_t.", p_dzfa.dzfa002 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      ROLLBACK WORK
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION