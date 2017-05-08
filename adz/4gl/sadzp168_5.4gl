#+ 程式版本......: T6 Version 1.00.00 Build-0001 AT 13/01/15
#
#+ 程式代碼......: sadzp168_5
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp168_5.4gl 
# Description    : 重組設計資料成4fd畫面工具
# Memo           :

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"

GLOBALS
   DEFINE g_error_message       STRING               #錯誤訊息
END GLOBALS

CONSTANT g_module = "mdl"                            #template所在路徑
CONSTANT g_form_template = "F000"                    #預設template畫面檔檔名

DEFINE g_dzfi001             LIKE dzfi_t.dzfi001     #結構代號
DEFINE g_dzfi002             LIKE dzfi_t.dzfi002     #版次
             
DEFINE g_template_node       om.DomNode              #UI樣版
DEFINE g_form                om.DomNode              #樣版上的Form節點
DEFINE g_sr_ref              om.DomNode              #新增SR節點時,所需參考的SR(Undefined)節點

DEFINE g_dgenv               LIKE type_t.chr1        #識別標示:s-標準產品, c-客製
DEFINE g_dzfi017             LIKE dzfi_t.dzfi017     #客戶代號

PUBLIC FUNCTION sadzp168_5(p_form_name, p_ver, p_dgenv, p_compile) 
   DEFINE p_form_name         STRING                        #畫面結構代號
   DEFINE p_ver               LIKE dzfi_t.dzfi002           #規格版次
   DEFINE p_dgenv             LIKE type_t.chr1              #識別標示:s-標準產品, c-客製
   DEFINE p_compile           LIKE type_t.chr1              #是否編譯
     
   DEFINE l_time_s            DATETIME YEAR TO SECOND       #FRACTION(4)
   DEFINE l_time_e            DATETIME YEAR TO SECOND       #FRACTION(4)
   DEFINE l_result            BOOLEAN
   DEFINE l_node              om.DomNode                    #4fd domNode
   DEFINE l_dzfi_root         DYNAMIC ARRAY OF type_g_dzfi  #畫面結構檔
   DEFINE l_container_height  LIKE type_t.num10             #container已用高度
   DEFINE l_container_width   LIKE type_t.num10             #container已用寬度
   DEFINE l_file              STRING                        #產出4fd檔案名稱(不必須參數,但需在azzi900有註冊)
   DEFINE l_dzaf010           LIKE dzaf_t.dzaf010           #識別標示
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   LET l_time_s = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
   DISPLAY "   Strat time : ", l_time_s, ASCII 10

   LET g_dzfi001 = p_form_name   #畫面結構代號
   LET g_dzfi002 = p_ver         #規格版次
   LET g_dgenv = p_dgenv         #識別標示:s-標準產品, c-客製

   #取得當下最大的規格版次
   IF cl_null(g_dzfi002) OR g_dzfi002 = 0 THEN
      LET g_error_message = "ERROR-revision is null."
      DISPLAY g_error_message
      RETURN FALSE, g_error_message
   END IF

   #建立畫面檔設計資料temp table
   CALL sadzp168_5_crate_temp_table()

   #程式初始化
   IF NOT sadzp168_5_init() THEN
      DISPLAY "Cannot initialize API."         #程式初始化失敗
      RETURN FALSE, g_error_message
   END IF

   #取得畫面樣檔
   LET g_template_node = sadzp168_5_get_4fd()

   INITIALIZE l_node TO NULL
   
   LET l_node = g_template_node
   IF l_node IS NULL THEN
      #取得畫面樣版檔失敗.
      LET g_error_message = "ERROR-", cl_getmsg_parm("adz-00076", g_lang, g_form_template)
      DISPLAY g_error_message
      RETURN FALSE, g_error_message
   END IF

   #取得UI畫面樣版檔目前所使用的fieldId和tabIndex最大值
   CALL sadzp168_2_search_fieldId_tabIndex_max(l_node, 0, 0)
      RETURNING g_fieldId_max, g_tabIndex_max

   #取得畫面檔根節點資料
   LET l_dzfi_root = sadzp168_5_get_structure("root")

   IF l_dzfi_root.getLength() = 0 THEN
      DISPLAY "Root 4fd structure failed."   #取得根節點失敗.
      IF cl_null(g_error_message) THEN
         LET g_error_message = "ERROR:Root 4fd structure failed." 
      END IF
      
      RETURN FALSE, g_error_message
   END IF
   
   #由根節點開始往下新增子節點結構(由外而內新增畫面結構)
   CALL sadzp168_5_add_structure(l_node, l_dzfi_root, "")
      RETURNING l_result, l_container_width, l_container_height

   DROP TABLE sadzp168_5_dzfi
   DROP TABLE sadzp168_5_dzfj

   IF NOT l_result THEN
      DISPLAY "Reassembly Failure."  #重組失敗
      IF cl_null(g_error_message) THEN
         LET g_error_message = "ERROR:Reassembly Failure." 
      END IF
      
      RETURN FALSE, g_error_message
   END IF
   
   #實際生成4fd畫面檔
   IF NOT cl_null(l_file) THEN
      CALL sadzp168_2_gen_4fd_file(l_file, l_node, p_compile)
         RETURNING l_result
   ELSE
      CALL sadzp168_2_gen_4fd_file(p_form_name, l_node, p_compile)
         RETURNING l_result
   END IF

   IF NOT l_result THEN
      IF cl_null(g_error_message) THEN
         LET g_error_message = "ERROR-gen 4fd file Failure."  #重組失敗
      END IF
      DISPLAY g_error_message
      RETURN FALSE, g_error_message
   END IF

   LET l_time_e = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
   DISPLAY ASCII 10, ASCII 10, "    End  time : ", l_time_e
   DISPLAY "    Cost time : ", l_time_e - l_time_s

   LET g_error_message = ""
   RETURN TRUE, ""
END FUNCTION

#+ 建立temp table
PRIVATE FUNCTION sadzp168_5_crate_temp_table()

   #Create temp TABLE 畫面結構設計資料暫存檔
   CREATE TEMP TABLE sadzp168_5_dzfi
   (
      dzfi001       VARCHAR(20),   #結構代號
      dzfi002       INTEGER,       #版次
      dzfi003       INTEGER,       #流水號
      dzfi004       VARCHAR(40),   #群組代碼
      dzfi005       INTEGER,       #順序編號
      dzfi006       VARCHAR(40),   #元件(組)代碼
      dzfi007       VARCHAR(20),   #節點類型
      dzfi008       VARCHAR(1),    #畫面顯示否
      dzfi009       VARCHAR(1),    #識別標示
      dzfi010       VARCHAR(1),    #元素類型
      dzfi011       VARCHAR(1),    #直橫排列
      dzfi012       INTEGER,       #節點階層
      dzfi013       INTEGER,       #群組起始X軸位置
      dzfi014       INTEGER,       #群組起始Y軸位置
      dzfi015       INTEGER,       #群組寬度
      dzfi016       INTEGER,       #群組長度
      dzfistus      VARCHAR(10),   #狀態碼
      dzfi017       VARCHAR(40)    #客戶代號
   );

   #Create temp TABLE 畫面元件組合設計資料暫存檔
   CREATE TEMP TABLE sadzp168_5_dzfj
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

END FUNCTION

#+ 程式相關資料初始化
PRIVATE FUNCTION sadzp168_5_init()
   DEFINE l_cnt             LIKE type_t.num5      
   DEFINE l_sql             STRING
   DEFINE l_dzfa003         LIKE dzfa_t.dzfa003   #識別標示
   
   INITIALIZE g_template_node TO NULL

   LET g_gzza003_module = ""
   LET l_dzfa003 =  "c"
   
   #若無版次資料,預設為1
   IF cl_null(g_dzfi002) OR g_dzfi002 = 0 THEN
      LET g_dzfi002 = 1
   END IF

   #取得識別標示
   IF cl_null(g_dgenv) THEN
      LET g_dgenv = FGL_GETENV("DGENV")     #"s":標準; "c"客製
   END IF

   #取得客戶代號
   LET g_dzfi017 = FGL_GETENV("CUST")
   
   #取得此畫面代碼畫面結構設計資料, 但NOT EXISTS 於dzfa_t(畫面UI元件失效檔)內dzfa005='0'(container)
   INSERT INTO sadzp168_5_dzfi
     SELECT dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
            dzfi006, dzfi007, dzfi008, dzfi009, dzfi010, 
            dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
            dzfi016, dzfistus, dzfi017 
       FROM dzfi_t
       WHERE dzfi001 = g_dzfi001 AND dzfi002 = g_dzfi002 AND dzfi009 = g_dgenv
         #AND NOT EXISTS 
         #    (SELECT * FROM dzfa_t 
         #       WHERE dzfa001 = g_dzfi001
         #         AND dzfa003 = l_dzfa003
         #         AND dzfa005 = '0'
         #         AND dzfa001 = dzfi001
         #         AND dzfa002 = dzfi006)
 
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-ins sadzp168_5_dzfi:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   #取得此畫面代碼畫面元件組合設計資料, 但NOT EXISTS 於dzfa_t(畫面UI元件失效檔)內dzfa005='1'(widget)
   INSERT INTO sadzp168_5_dzfj
     SELECT dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
            dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
            dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
            dzfj016, dzfjstus, dzfj017, dzfj018 
       FROM dzfj_t
       WHERE dzfj001 = g_dzfi001 AND dzfj002 = g_dzfi002 AND dzfj017 = g_dgenv
         #AND NOT EXISTS 
         #    (SELECT * FROM dzfa_t 
         #       WHERE dzfa001 = g_dzfi001
         #         AND dzfa003 = l_dzfa003
         #         AND dzfa005 = '1'
         #         AND dzfa001 = dzfj001
         #         AND dzfa002 = dzfj005)
 
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-ins sadzp168_5_dzfj:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   SELECT COUNT(*) INTO l_cnt FROM sadzp168_5_dzfi
   DISPLAY "sadzp168_5_dzfi count(*):", l_cnt

   #取得節點下各子節點畫面結構資訊
   LET l_sql = "SELECT * FROM sadzp168_5_dzfi ",
               "  WHERE dzfi004 = ? ", 
               "  ORDER BY dzfi005"
   PREPARE sadzp168_5_dzfi_pre FROM l_sql
   DECLARE sadzp168_5_dzfi_cs CURSOR FOR sadzp168_5_dzfi_pre

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_5_dzfi_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   
   #取得元件組合下的widget節點設計資料
   LET l_sql = "SELECT * FROM sadzp168_5_dzfj ",
               "  WHERE dzfj001 = ? AND dzfj002 = ? AND dzfj003 = ? ",
               "  ORDER BY dzfj004"
   PREPARE sadzp168_5_dzfj_pre FROM l_sql
   DECLARE sadzp168_5_dzfj_cs CURSOR FOR sadzp168_5_dzfj_pre

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_5_dzfj_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF
   
   #取得節點屬性設計資料
   LET l_sql = "SELECT dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, ",
               "       dzfk006, dzfk007, dzfk008, dzfk009 ",
               "  FROM dzfk_t ",
               "  WHERE dzfk001 = ? AND dzfk002 = ? AND dzfk003 = ? AND dzfk007 = ? "
               #"  ORDER BY dzfk004"
   PREPARE sadzp168_5_dzfk_pre FROM l_sql
   DECLARE sadzp168_5_dzfk_cs CURSOR FOR sadzp168_5_dzfk_pre

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_5_dzfk_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   #取得ComboBox和RadioGroup二個widget的子項目設計資料, 但NOT EXISTS 於dzfa_t(畫面UI元件失效檔)內dzfa005='2'(item資料項目)
   LET l_sql = "SELECT dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, ",
               "       dzfl006, dzflstus, dzfl007, dzfl008 ",
               "  FROM dzfl_t ",
               "  WHERE dzfl001 = ? AND dzfl002 = ? AND dzfl003 = ? AND dzfl007 = ? ",
               #"    AND NOT EXISTS ", 
               #"       (SELECT * FROM dzfa_t ", 
               #"          WHERE dzfa001 = ? ", 
               #"            AND dzfa003 = ? ", 
               #"            AND dzfa005 = '2' ", 
               #"            AND dzfa001 = dzfl001 ", 
               #"            AND dzfa002 = dzfl003 ",
               #"            AND dzfa007 = dzfl005) ", 
               "  ORDER BY dzfl004"
   PREPARE sadzp168_5_dzfl_pre FROM l_sql
   DECLARE sadzp168_5_dzfl_cs CURSOR FOR sadzp168_5_dzfl_pre
   
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-PREPARE sadzp168_5_dzfl_pre:", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ 載入預設template畫面樣版檔成domNode,準備組合畫面元件用
PRIVATE FUNCTION sadzp168_5_get_4fd()
   DEFINE l_file            STRING
   DEFINE r_template_node   om.DomNode            #4fd domNode
   
   INITIALIZE r_template_node TO NULL

   LET l_file = os.Path.JOIN(FGL_GETENV("ERP"), g_module)
   LET l_file = os.Path.JOIN(l_file, g_form_template || ".snippet")

   IF (NOT cl_null(l_file)) AND (NOT os.Path.EXISTS(l_file)) THEN
      RETURN r_template_node
   END IF
   
   #載入需要解析的4fd畫面檔成domNode
   LET r_template_node = sadzp168_2_load_xml_to_dom(l_file) 

   #todo:取得一個參考的Screen Record節點,目前預設取得[Undefined]
   #預備之後新增Screen Record節點,可參考其屬性
   IF r_template_node IS NOT NULL THEN
      LET g_form = sadzp168_2_get_domNode(r_template_node, "Form", "name", g_form_template)
      LET g_sr_ref = sadzp168_2_get_domNode(r_template_node, "Record", "name", "Undefined")
   END IF

   RETURN r_template_node
END FUNCTION

#+ 逐一新增尚未處理之結構點資料(為container節點)
PRIVATE FUNCTION sadzp168_5_add_structure(p_node, p_dzfi, p_dzfi011)
   DEFINE p_node             om.DomNode
   DEFINE p_dzfi             DYNAMIC ARRAY OF type_g_dzfi  #畫面結構檔
   DEFINE p_dzfi011          LIKE dzfi_t.dzfi011           #父節點直橫排列組合方式
   
   DEFINE l_i                LIKE type_t.num5
   DEFINE l_child_count      LIKE type_t.num5
   DEFINE l_total_rows       LIKE type_t.num5
   DEFINE l_new_node         om.DomNode
   DEFINE l_dzfi_child       DYNAMIC ARRAY OF type_g_dzfi  #子節點畫面結構檔
   DEFINE l_posX_first       LIKE type_t.num5              #第一個欄位元件X軸位置
   DEFINE l_posY_first       LIKE type_t.num5              #第一個欄位元件Y軸位置
   DEFINE l_posX_max         LIKE type_t.num5              #此container中欄位控件用到的posX最大值(準備下一行欄位控件使用的posX起始點)
   DEFINE l_posY_max         LIKE type_t.num5              #此container中欄位控件用到的posY最大值(準備下一行欄位控件使用的posY起始點)
   DEFINE l_container_width  LIKE type_t.num5              #container已用寬度
   DEFINE l_container_height LIKE type_t.num5              #container已用高度
   DEFINE l_dzfi015          LIKE dzfi_t.dzfi015           #群組寬度(Container所用掉的寬度)
   DEFINE l_dzfi016          LIKE dzfi_t.dzfi016           #群組長度(Container所用掉的長度)
   DEFINE l_pos_init         LIKE type_t.chr1              #取得每一種Container下的widget啟始位置(只取得一次)
   
   DEFINE l_result           LIKE type_t.chr1
   
   INITIALIZE l_new_node TO NULL
   LET l_posX_first = 0
   LET l_posY_first = 0
   LET l_posX_max = 0
   LET l_posY_max = 0
   LET l_dzfi015 = 0
   LET l_dzfi016 = 0
   LET l_result = FALSE
   LET l_pos_init = FALSE
   LET l_total_rows = 0

   LET l_container_width = 0
   LET l_container_height = 0
   
   #結構資料處理完畢時,不再新增畫面節點
   FOR l_i = 1 TO p_dzfi.getLength()
      #此筆設計資料包含元素類型3.Widget
      #就直接新增widget節點
      IF p_dzfi[l_i].dzfi010 = "3" THEN
         CALL sadzp168_5_add_widget(p_node, p_dzfi[l_i].dzfi006, p_dzfi[l_i].dzfi011)
            RETURNING l_result, l_dzfi015, l_dzfi016

         #widget計算posX, posY 值錯誤
         IF NOT l_result THEN
            LET g_error_message = "ERROR-posX & posY are error."
            DISPLAY "posX & posY are error."
            RETURN FALSE, l_container_width, l_container_height
         ELSE
            #計算container所需佔用最大長/寬
            IF l_container_width < l_dzfi015 THEN
               LET l_container_width = l_dzfi015
            END IF

            IF l_container_height < l_dzfi016 THEN
               LET l_container_height = l_dzfi016
            END IF
         END IF

         #如果為container和widget混合畫面,則需計算下一個
         IF l_i < p_dzfi.getLength() THEN
            IF p_dzfi[l_i + 1].dzfi010 = "1" THEN
               #todo:群組間不等高代表排列方式不為橫向排列,視為直向排列
               IF p_dzfi[l_i].dzfi014 <> p_dzfi[l_i + 1].dzfi014 THEN
                  LET l_posX_max = p_dzfi[l_i + 1].dzfi013
                  LET l_posY_max = l_container_height
                  LET l_container_height = l_container_height + 1
               ELSE
                  LET l_posX_max = l_container_width + 1
                  LET l_container_width = l_posX_max
               END IF 
            END IF
         END IF
         
         CONTINUE FOR
      END IF

      #設計資料 = 樣版上的Form節點時,表示為第一筆資料,直接取用樣版上的Form節點即可("Form")
      IF p_dzfi[l_i].dzfi007 = g_form.getTagName() THEN
         LET l_new_node = g_form
      ELSE
         LET l_new_node = p_node.createChild(p_dzfi[l_i].dzfi007) 
      END IF

      ####140708:出貨前判斷4fd是否符合不可在Grid中再加入Group, Table容器
      ###IF p_node.getTagName() = "Grid" AND (l_new_node.getTagName() = "Group" OR l_new_node.getTagName() = "Table") THEN
      ###   DISPLAY "    Rule warning:,", p_dzfi[l_i].dzfi001 CLIPPED, ",(", p_dzfi[l_i].dzfi004 CLIPPED, ".", p_dzfi[l_i].dzfi006 CLIPPED, ")"
      ###END IF

      #設定節點屬性
      IF NOT sadzp168_5_set_attr(l_new_node, p_dzfi[l_i].dzfi006) THEN
         RETURN FALSE, l_container_width, l_container_height
      END IF

      #繼續往下層取得子節點結構
      LET l_dzfi_child = sadzp168_5_get_structure(p_dzfi[l_i].dzfi006)

      #新增子節點畫面結構設計資料   
      IF l_dzfi_child.getLength() > 0 THEN
         CALL sadzp168_5_add_structure(l_new_node, l_dzfi_child, p_dzfi[l_i].dzfi011)
            RETURNING l_result, l_dzfi015, l_dzfi016

         #container計算width, height 值錯誤
         IF NOT l_result THEN
            RETURN FALSE, l_dzfi015, l_dzfi016
         END IF
      ELSE
         IF NOT cl_null(l_new_node.getAttribute("gridWidth")) THEN
            LET l_dzfi015 = l_new_node.getAttribute("gridWidth")
         END IF

         IF NOT cl_null(l_new_node.getAttribute("gridHeight")) THEN
            LET l_dzfi016 = l_new_node.getAttribute("gridHeight")
         END IF
      END IF
     
      CASE l_new_node.getTagName()
         WHEN "Table"
            #Table容器的寬度 = 已用寬度 + 欄位個數 + 1
            LET l_child_count = l_new_node.getChildCount()
            LET l_dzfi015 = l_dzfi015 + l_child_count + 1

            #Table容器的高度 = "totalRows"屬性值 + 1(標題列高度)
            LET l_total_rows = l_new_node.getAttribute("totalRows")
            IF cl_null(l_total_rows) OR l_total_rows = 0 THEN
               LET l_total_rows = 20
               CALL l_new_node.setAttribute("totalRows", "20")
            END IF
            LET l_dzfi016 = l_total_rows + 1

         WHEN "Tree"
            #Tree容器的寬度 = 已用寬度 + 欄位個數 + 1
            LET l_child_count = l_new_node.getChildCount()
            LET l_dzfi015 = l_dzfi015 + l_child_count + 1

            #Tree容器的高度 = "totalRows"屬性值 + 1(標題列高度)
            LET l_total_rows = l_new_node.getAttribute("totalRows")
            IF cl_null(l_total_rows) OR l_total_rows = 0 THEN
               LET l_total_rows = 20
               CALL l_new_node.setAttribute("totalRows", "20")
            END IF
            LET l_dzfi016 = l_total_rows + 1

         WHEN "ScrollGrid"
            LET l_dzfi015 = l_dzfi015
            LET l_dzfi016 = l_dzfi016
         
         WHEN "VBox"
            LET l_dzfi016 = l_dzfi016 + 1
            
            #最小長/寬限制
            IF l_dzfi015 < 3 THEN
               LET l_dzfi015 = 3
            END IF

            IF l_dzfi016 < 4 THEN
               LET l_dzfi016 = 4
            END IF

         WHEN "HBox"
            LET l_dzfi015 = l_dzfi015 + 2

            #最小長/寬限制
            IF l_dzfi015 < 7 THEN
               LET l_dzfi015 = 7
            END IF

            IF l_dzfi016 < 3 THEN
               LET l_dzfi016 = 3
            END IF

         WHEN "Folder"
            LET l_dzfi015 = l_dzfi015 + 1
            LET l_dzfi016 = l_dzfi016 + 1

         WHEN "Group"
            LET l_dzfi015 = l_dzfi015 + 1
            LET l_dzfi016 = l_dzfi016 + 1
         
         WHEN "Form"
            LET l_dzfi015 = l_dzfi015 + 2
            LET l_dzfi016 = l_dzfi016 + 2

         OTHERWISE
            LET l_dzfi015 = l_dzfi015
            LET l_dzfi016 = l_dzfi016
      END CASE

      
      #設定container寬度
      IF (NOT cl_null(l_new_node.getAttribute("gridWidth"))) AND l_new_node.getAttribute("gridWidth") < l_dzfi015 THEN
         CALL l_new_node.setAttribute("gridWidth", l_dzfi015)
      END IF

      #設定container高度
      IF (NOT cl_null(l_new_node.getAttribute("gridHeight"))) AND l_new_node.getAttribute("gridHeight") < l_dzfi016 THEN
         CALL l_new_node.setAttribute("gridHeight", l_dzfi016)
      END IF

      #第一個子元件參考父節點(p_node)下應該需要預設的最小的posX, posY值
      IF NOT l_pos_init THEN
         #再參照第一個子元件預設的 X, Y軸位置
         LET l_posX_first = l_new_node.getAttribute("posX")
         LET l_posY_first = l_new_node.getAttribute("posY")

         IF (NOT cl_null(l_posX_first)) AND (NOT cl_null(l_posY_first)) THEN
            CALL sadzp168_5_get_container_pos_init(p_node.getTagName())
               RETURNING l_posX_max, l_posY_max

            LET l_pos_init = TRUE
         
            #指定第一個子元件的 X, Y軸位置
            IF l_posX_max < l_posX_first THEN
               LET l_posX_max = l_posX_first
               #LET l_posX_first = l_posX_max
            END IF

            IF l_posY_max < l_posY_first THEN
               LET l_posY_max = l_posY_first
               #LET l_posY_first = l_posY_max
            END IF
         END IF
      END IF

      #每個Container元件的位置
      IF NOT cl_null(l_new_node.getAttribute("posX")) THEN
         CALL l_new_node.setAttribute("posX", l_posX_max)
      END IF

      IF NOT cl_null(l_new_node.getAttribute("posY")) THEN
         CALL l_new_node.setAttribute("posY", l_posY_max)
      END IF  

      
      #參照直/橫排列加總後計算X, Y軸的位置,做為下一個Container的位置
      IF p_dzfi011 = "V" THEN
         LET l_posY_max = l_new_node.getAttribute("posY") CLIPPED + l_new_node.getAttribute("gridHeight") CLIPPED   
      ELSE   
         LET l_posX_max = l_new_node.getAttribute("posX") CLIPPED + l_new_node.getAttribute("gridWidth") CLIPPED
      END IF

      #取得每一個Container已佔用畫面寬度/高度
      IF NOT cl_null(l_new_node.getAttribute("gridWidth")) THEN
         LET l_dzfi015 = l_new_node.getAttribute("posX") CLIPPED + l_new_node.getAttribute("gridWidth") CLIPPED
      END IF
      IF NOT cl_null(l_new_node.getAttribute("gridWidth")) THEN
         LET l_dzfi016 = l_new_node.getAttribute("posY") CLIPPED + l_new_node.getAttribute("gridHeight") CLIPPED
      END IF


      #取得目前使用長/寬
      IF NOT cl_null(l_dzfi015) THEN
         IF l_container_width < l_dzfi015 THEN
            LET l_container_width = l_dzfi015
         END IF
      END IF

      IF NOT cl_null(l_dzfi016) THEN
         IF l_container_height < l_dzfi016 THEN
            LET l_container_height = l_dzfi016
         END IF
      END IF

      #如果為Grid中包含了Group的混合畫面,則參考原本的下一個Group的位置排列
      IF l_i < p_dzfi.getLength() AND p_node.getTagName() = "Grid" AND p_dzfi011 = "H" THEN
         #為了確保不重疊,只有在下一個Group的posY > 目前計算的container所需高度(l_container_height)時,才換掉posY軸位置
         IF p_dzfi[l_i + 1].dzfi007 = "Group" AND p_dzfi[l_i].dzfi014 <> p_dzfi[l_i + 1].dzfi014 AND l_container_height <= p_dzfi[l_i + 1].dzfi014 THEN
            LET l_posX_max = p_dzfi[l_i + 1].dzfi013

            IF l_posY_max < p_dzfi[l_i + 1].dzfi014 THEN
               LET l_posY_max = p_dzfi[l_i + 1].dzfi014
               LET l_container_height = l_posY_max
            END IF
         END IF 
      END IF
   END FOR

   
   #為元件組合節點時,表示此節點為container結構
   RETURN TRUE, l_container_width, l_container_height
END FUNCTION

#+ 逐一取得container節點設計資料(dzfi_t)
PRIVATE FUNCTION sadzp168_5_get_structure(p_dzfi004)
   DEFINE p_dzfi004          LIKE dzfi_t.dzfi004
   
   DEFINE l_n                LIKE type_t.num5
   DEFINE r_dzfi             DYNAMIC ARRAY OF type_g_dzfi  #畫面結構檔
   
   LET l_n = 1
   CALL r_dzfi.CLEAR()

   OPEN sadzp168_5_dzfi_cs USING p_dzfi004
   IF STATUS THEN
      LET g_error_message = "ERROR-OPEN sadzp168_5_dzfi_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message
      CLOSE sadzp168_5_dzfi_cs
      RETURN r_dzfi
   END IF

   FOREACH sadzp168_5_dzfi_cs INTO r_dzfi[l_n].*
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-FOREACH sadzp168_5_dzfi_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message
         EXIT FOREACH
      END IF

      LET l_n = l_n + 1
   END FOREACH
   CALL r_dzfi.deleteElement(l_n)

   RETURN r_dzfi
END FUNCTION

#+ 設置節點屬性
PRIVATE FUNCTION sadzp168_5_set_attr(p_node, p_dzfk003)
   DEFINE p_node             om.DomNode
   DEFINE p_dzfk003          LIKE dzfk_t.dzfk003     #widget 代碼

   DEFINE l_dzfk             type_g_dzfk             #畫面元件屬性檔
   DEFINE l_cnt              LIKE type_t.num5
   DEFINE l_domDoc           om.DomDocument
   DEFINE l_root_node        om.DomNode
   DEFINE l_i                LIKE type_t.num5
   DEFINE l_attr_name        STRING                  #節點屬性名稱
   DEFINE l_attr_value       STRING                  #節點屬性值
   DEFINE l_widget_name      STRING    
   DEFINE l_dzfq001          LIKE dzfq_t.dzfq001
   DEFINE l_dzfq003          LIKE dzfq_t.dzfq003
   DEFINE l_dzfq004          LIKE dzfq_t.dzfq004   
   DEFINE l_parent_node      om.DomNode
   
   IF p_node IS NULL THEN
      RETURN FALSE
   END IF

   #取得舊版畫面是否已經有這個節點屬性,有此節點以舊畫面(客戶畫面)為主
   #LET l_cnt = 0
   LOCATE l_dzfk.dzfk009 IN FILE
   
   EXECUTE sadzp168_5_dzfk_cs USING g_dzfi001, g_dzfi002, p_dzfk003, g_dgenv
                           INTO l_dzfk.dzfk001, l_dzfk.dzfk002, l_dzfk.dzfk003, l_dzfk.dzfk004, l_dzfk.dzfk005, 
                                l_dzfk.dzfk006, l_dzfk.dzfk007, l_dzfk.dzfk008, l_dzfk.dzfk009

   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-EXECUTE sadzp168_5_dzfk_cs.", p_dzfk003 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY g_error_message
      FREE l_dzfk.dzfk009   #釋放LOCATE
      RETURN FALSE
   END IF
   
   LET l_domDoc = om.DomDocument.createFromString(l_dzfk.dzfk009)
   LET l_root_node = l_domDoc.getDocumentElement()

   FOR l_i = 1 TO l_root_node.getAttributesCount()
       LET l_attr_name = l_root_node.getAttributeName(l_i) CLIPPED
       LET l_attr_value = l_root_node.getAttributeValue(l_i) CLIPPED

       CALL p_node.setAttribute(l_attr_name.trim(), l_attr_value.trim())

       #增加欄位如果有fieldId和tabIndex屬性,值都要依續加1
       CALL sadzp168_5_field_add_index(p_node, l_attr_name)
   END FOR

   FREE l_dzfk.dzfk009   #釋放LOCATE
   RETURN TRUE
END FUNCTION

#+ fieldId和tabIndex屬性都要是4fd的唯一值
PRIVATE FUNCTION sadzp168_5_field_add_index(p_node, p_dzfk005)
   DEFINE p_node             om.DomNode              #新增節點
   DEFINE p_dzfk005          LIKE dzfk_t.dzfk005     #屬性名稱

   #因為要新增加欄位,所以fieldId和tabIndex都要依續加1,都要是畫面的唯一值
   IF p_dzfk005 CLIPPED = "fieldId" THEN
      LET g_fieldId_max = g_fieldId_max + 1
      CALL p_node.setAttribute(p_dzfk005 CLIPPED, g_fieldId_max)
   END IF

   #IF p_dzfk005 CLIPPED = "tabIndex" THEN
   #   LET g_tabIndex_max = g_tabIndex_max + 1
   #   CALL p_node.setAttribute(p_dzfk005 CLIPPED, g_tabIndex_max)
   #END IF
END FUNCTION

#+ 在container下逐一新增原有的widget節點
PRIVATE FUNCTION sadzp168_5_add_widget(p_node, p_dzfj003, p_dzfi011)
   DEFINE p_node             om.DomNode
   DEFINE p_dzfj003          LIKE dzfj_t.dzfj003     #群組代碼
   DEFINE p_dzfi011          LIKE dzfi_t.dzfi011     #直橫排列組合方式

   DEFINE l_dzfj             type_g_dzfj             #畫面元件組合檔
   DEFINE l_new_node         om.DomNode
   DEFINE l_items            STRING                  #ComboBox和RadioGroup二個widget的items屬性值
   DEFINE l_sr_name          STRING                  #Screen Record的name
   DEFINE l_sr_node          om.DomNode              #Screen Record節點
   DEFINE l_sr_child         om.DomNode              #SR要新增的子節點欄位

   DEFINE l_posX_max         LIKE type_t.num10       #此container中欄位控件用到的posY最大值(準備下一行欄位控件使用的posY起始點)
   DEFINE l_posY_max         LIKE type_t.num10       #此container中欄位控件用到的posY最大值(準備下一行欄位控件使用的posY起始點)   
   DEFINE l_dzfi015          LIKE dzfi_t.dzfi015     #群組寬度
   DEFINE l_dzfi016          LIKE dzfi_t.dzfi016     #群組長度
   DEFINE l_result           LIKE type_t.chr1

   INITIALIZE l_new_node TO NULL
   INITIALIZE l_sr_node TO NULL

   LET l_posX_max = 0
   LET l_posY_max = 0
   LET l_dzfi015 = 0
   LET l_dzfi016 = 0
   LET l_result = FALSE

   #目前解析程式邏輯定義container下的widget排列方式都是橫向排列,以posY同一排為主
   IF cl_null(p_dzfi011) THEN
      LET p_dzfi011 = "H"
   END IF
   
   #####處理Screen Record節點的前置程序#####
   #取得Screen Record節點name名稱
   #todo:目前暫定 table, tree, scrollGrid 三種container需要另外新增Screen Record節點
   IF p_node.getTagName() = "Table" OR p_node.getTagName() = "Tree" OR p_node.getTagName() = "ScrollGrid" THEN 
      LET l_sr_name = p_node.getAttribute("name")
   ELSE
      LET l_sr_name = "Undefined"
   END IF

   LET l_sr_node = sadzp168_2_add_sr_structure(l_sr_name, g_template_node, g_sr_ref, g_form)
   
   #####取得此元件組合下的widget設計結構資料   
   OPEN sadzp168_5_dzfj_cs USING g_dzfi001, g_dzfi002, p_dzfj003
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-OPEN sadzp168_5_dzfj_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message
      CLOSE sadzp168_5_dzfj_cs
      RETURN FALSE, l_dzfi015, l_dzfi016
   END IF

   FOREACH sadzp168_5_dzfj_cs INTO l_dzfj.*
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-FOREACH sadzp168_5_dzfj_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message
         RETURN FALSE, l_dzfi015, l_dzfi016
      END IF

      #新增widget子節點
      LET l_new_node = p_node.createChild(l_dzfj.dzfj006 CLIPPED) 

      #設定節點屬性
      IF NOT sadzp168_5_set_attr(l_new_node, l_dzfj.dzfj005) THEN
         RETURN FALSE, l_dzfi015, l_dzfi016
      END IF

      #重新設置posX, posY 座標值: 每個UI元件的位置抓取X, Y軸和長/寬的設計資訊
      IF (NOT cl_null(l_dzfj.dzfj013)) AND (NOT cl_null(l_new_node.getAttribute("posX"))) THEN
         CALL l_new_node.setAttribute("posX", l_dzfj.dzfj013)
      END IF
      
      IF (NOT cl_null(l_dzfj.dzfj014)) AND (NOT cl_null(l_new_node.getAttribute("posY"))) THEN
         CALL l_new_node.setAttribute("posY", l_dzfj.dzfj014)
      END IF   

      IF (NOT cl_null(l_dzfj.dzfj015)) AND (NOT cl_null(l_new_node.getAttribute("gridWidth"))) THEN
         CALL l_new_node.setAttribute("gridWidth", l_dzfj.dzfj015)
      END IF

      IF (NOT cl_null(l_dzfj.dzfj016)) AND (NOT cl_null(l_new_node.getAttribute("gridHeight"))) THEN
         CALL l_new_node.setAttribute("gridHeight", l_dzfj.dzfj016)
      END IF

      #重新設置posX, posY 座標值(目前程式邏輯定義container下的widget排列方式都是橫向排列,以posY同一排為主)
      IF (NOT cl_null(l_new_node.getAttribute("gridWidth"))) AND (NOT cl_null(l_new_node.getAttribute("gridHeight"))) THEN
         LET l_posX_max = l_new_node.getAttribute("posX") CLIPPED + l_new_node.getAttribute("gridWidth") CLIPPED
         LET l_posY_max = l_new_node.getAttribute("posY") CLIPPED + l_new_node.getAttribute("gridHeight") CLIPPED

         IF l_dzfi015 < l_posX_max THEN
            LET l_dzfi015 = l_posX_max
         END IF

         IF l_dzfi016 < l_posY_max THEN
            LET l_dzfi016 = l_posY_max
         END IF
      END IF
      
      #ComboBox和RadioGroup二個widget需要建立Items子項目
      IF l_new_node.getTagName() = "ComboBox" OR l_new_node.getTagName() = "RadioGroup" THEN
         CALL sadzp168_5_add_items(l_new_node, l_dzfj.dzfj005)
            RETURNING l_result, l_items

         IF NOT l_result THEN
            RETURN FALSE, l_dzfi015, l_dzfi016
         END IF
         #設定items屬性值
         CALL l_new_node.setAttribute("items", l_items)
      END IF

      ############處理Screen Records##############################
      #todo:初步判斷widget有fieldId屬性,應該就需要在Screen Record增加一個子節點
      IF NOT cl_null(l_new_node.getAttribute("fieldId")) THEN
         LET l_sr_child = l_sr_node.createChild("RecordField")
      
         #設置新sr child node的屬性
         CALL sadzp168_2_set_sr_attr(l_sr_child, l_new_node)
      END IF
      ###########################################################
   END FOREACH

   RETURN TRUE, l_dzfi015, l_dzfi016
END FUNCTION

#+ ComboBox和RadioGroup二個widget需要建立Items子資料項目
PRIVATE FUNCTION sadzp168_5_add_items(p_node, p_dzfl003)
   DEFINE p_node             om.DomNode
   DEFINE p_dzfl003          LIKE dzfl_t.dzfl003     #元件代碼

   DEFINE l_dzfl             type_g_dzfl             #資料項目檔
   DEFINE l_new_node         om.DomNode
   DEFINE l_items            STRING                  #widget下items屬性值
   
   INITIALIZE l_new_node TO NULL

   LET l_items = ""
   
   OPEN sadzp168_5_dzfl_cs USING g_dzfi001, g_dzfi002, p_dzfl003, g_dgenv
   IF SQLCA.sqlcode THEN
      LET g_error_message = "ERROR-OPEN sadzp168_5_dzfl_cs:", cl_getmsg(STATUS, g_lang)
      DISPLAY g_error_message
      CLOSE sadzp168_5_dzfl_cs
      RETURN FALSE, l_items
   END IF

   FOREACH sadzp168_5_dzfl_cs INTO l_dzfl.*
      IF SQLCA.sqlcode THEN
         LET g_error_message = "ERROR-FOREACH sadzp168_5_dzfl_cs:", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY g_error_message
         RETURN FALSE, l_items
         EXIT FOREACH
      END IF

      LET l_new_node = p_node.createChild("Item") 

      #設定節點屬性
      CALL l_new_node.setAttribute("lstrtext", "true")
      CALL l_new_node.setAttribute("name", l_dzfl.dzfl005 CLIPPED)
      CALL l_new_node.setAttribute("text", l_dzfl.dzfl006 CLIPPED)

      #紀錄子項目
      IF cl_null(l_items) THEN
         LET l_items = l_dzfl.dzfl006 CLIPPED
      ELSE
         LET l_items = l_items, ", ", l_dzfl.dzfl006 CLIPPED
      END IF
   END FOREACH

   RETURN TRUE, l_items
END FUNCTION

#+ 取得每一種Container下的widget啟始位置
PRIVATE FUNCTION sadzp168_5_get_container_pos_init(p_container)
   DEFINE p_container             STRING

   DEFINE r_posX_start            LIKE type_t.num10     #每一排元件X軸啟始位置
   DEFINE r_posY_start            LIKE type_t.num10     #每一排元件Y軸啟始位置
   
   CASE p_container.trim()
      WHEN "HBox"
         LET r_posX_start = 2
         LET r_posY_start = 0

      WHEN "VBox"
         LET r_posX_start = 0
         LET r_posY_start = 1

      WHEN "Form"
         LET r_posX_start = 0
         LET r_posY_start = 0

      WHEN "Folder"
         LET r_posX_start = 0
         LET r_posY_start = 0

      WHEN "Page"
         LET r_posX_start = 0
         LET r_posY_start = 0

      WHEN "Grid"
         LET r_posX_start = 1
         LET r_posY_start = 0

      WHEN "Group"
         LET r_posX_start = 1
         LET r_posY_start = 1

      WHEN "Table"
         LET r_posX_start = 0
         LET r_posY_start = 0

      WHEN "Tree"
         LET r_posX_start = 0
         LET r_posY_start = 0

      WHEN "ScrollGrid"
         LET r_posX_start = 1
         LET r_posY_start = 1

      OTHERWISE
         LET r_posX_start = 1
         LET r_posY_start = 1

   END CASE

   RETURN r_posX_start, r_posY_start
END FUNCTION
